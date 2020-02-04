#include "appdata.h"

#include <QDebug>
#include <QStandardPaths>
#include <QDir>
#include <QFileSystemWatcher>
#include <QQmlEngine>
#include <QFile>
#include <QJsonArray>
#include <QJsonObject>

AppData::AppData(QObject *parent)
        : QObject(parent) {
    
    appPath = QStandardPaths::standardLocations(QStandardPaths::AppDataLocation).last();
    dbPath = appPath + "/db.json";
    loadDb();
    
    imagePaths = QStandardPaths::standardLocations(QStandardPaths::PicturesLocation);
    
    imageWatcher = new QFileSystemWatcher(this);
    imageWatcher->addPaths(imagePaths);
    
    connect(imageWatcher, &QFileSystemWatcher::directoryChanged,
            this, &AppData::imagesChanged);
}

QJSValue AppData::registerType(QQmlEngine* engine, QJSEngine *script) {
    return script->newQObject(new AppData(engine));
}

QStringList AppData::getImages() {
    QStringList paths;
    
    if (!imagePaths.isEmpty()) {
        for (QString dirPath : imagePaths) {
            QDir dir(dirPath);
            
            for (QString path : dir.entryList(QDir::Files)) {
                paths.append("file:///" + dir.absoluteFilePath(path));
            }
        }
    }
    
    return paths;
}

void AppData::loadDb() {
    entries.clear();
    
    qDebug() << "Load:" << dbPath;
    
    QFile dbFile(dbPath);
    if (!dbFile.open(QIODevice::ReadOnly)) return;
    
    QByteArray data = dbFile.readAll();
    QJsonDocument db = QJsonDocument::fromJson(data);
    
    QJsonObject doc = db.object();
    
    if (doc.contains("data") && doc["data"].isArray()) {
        for (QJsonValue value : doc["data"].toArray()) {
            if (value.isObject()) {
                EntrySet set;
                set.read(value.toObject());
                sets.append(set);
                entries.append(set.entries);
            }
        }
    }
}

void AppData::saveDb() const {
    QFile dbFile(dbPath);
    if (!dbFile.open(QIODevice::WriteOnly)) {
        qWarning() << "Couldn't open save file.";
        qWarning() << dbPath;
        return;
    }
    
    QJsonArray data;
    
    for (EntrySet set : sets) {
        QJsonObject object;
        set.write(object);
        data.append(object);
    }
    
    {
        QJsonObject object;
        object["data"] = data;
        
        QJsonDocument doc(object);
        dbFile.write(doc.toJson());
    }
}

QList<EntrySet> AppData::getData() const {
    qDebug() << sets[0].set_id;
    return sets;
}

void AppData::setEntry(const Entry &entry) {
    for (Entry e : entries) {
        if (e.entry_id == entry.entry_id) {
            e = entry;
            break;
        }
    }
    
    saveDb();
    emit dataChanged();
}

void AppData::setSet(const EntrySet &set) {
    for (EntrySet s : sets) {
        if (s.set_id == set.set_id) {
            s = set;
            break;
        }
    }
    
    saveDb();
    emit dataChanged();
}
