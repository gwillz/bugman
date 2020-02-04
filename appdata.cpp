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
    loadTemplates();
    
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
    db.clear();
    
    qDebug() << "DB:" << dbPath;
    
    QFile dbFile(dbPath);
    if (!dbFile.open(QIODevice::ReadOnly)) return;
    
    QByteArray data = dbFile.readAll();
    QJsonDocument doc = QJsonDocument::fromJson(data);
    
    db.read(doc.object());
    
    qDebug() << "Sets:" << db.sets.size();
    qDebug() << "Entries:" << db.entries.size();
}

void AppData::saveDb() const {
    QFile dbFile(dbPath);
    if (!dbFile.open(QIODevice::WriteOnly)) {
        qWarning() << "Couldn't open save file.";
        qWarning() << dbPath;
        return;
    }
    
    QJsonObject object;
    db.write(object);
    
    QJsonDocument doc(object);
    dbFile.write(doc.toJson());
}

void AppData::loadTemplates() {
    QDir dir(":templates");
    
    for (QString path : dir.entryList(QDir::Files)) {
        qDebug() << "Template:" << path;
        
        QFile file(dir.absoluteFilePath(path));
        if (!file.open(QIODevice::ReadOnly)) continue;
        
        QByteArray data = file.readAll();
        QJsonDocument doc = QJsonDocument::fromJson(data);
        QJsonObject root = doc.object();
        
        EntryTemplate entryTemplate;
        entryTemplate.read(root);
        templates.append(entryTemplate);
    }
    
    qDebug() << "Templates:" << templates.size();
}


QList<EntrySet> AppData::getData() const {
    return db.sets;
}

void AppData::setEntry(const Entry &entry) {
    for (Entry e : db.entries) {
        if (e.entry_id == entry.entry_id) {
            e = entry;
            break;
        }
    }
    
    saveDb();
    emit dataChanged();
}

void AppData::setSet(const EntrySet &set) {
    for (EntrySet s : db.sets) {
        if (s.set_id == set.set_id) {
            s = set;
            break;
        }
    }
    
    saveDb();
    emit dataChanged();
}
