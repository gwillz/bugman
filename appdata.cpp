#include "appdata.h"

#include <QDebug>
#include <QStandardPaths>
#include <QDir>
#include <QFileSystemWatcher>
#include <QQmlEngine>
#include <QFile>
#include <QJsonArray>
#include <QJsonObject>
#include <QDateTime>

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
    int entryCount;
    
    if (dbFile.open(QIODevice::ReadOnly)) {
        QByteArray data = dbFile.readAll();
        QJsonDocument doc = QJsonDocument::fromJson(data);
        
        entryCount = db.read(doc.object());
    }
    
    qDebug() << "Sets:" << db.sets.size();
    qDebug() << "Entries:" << entryCount;
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
    
    qDebug() << "DB written.";
}

void AppData::loadTemplates() {
    templates.clear();
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
    return db.sets.values();
}

int AppData::setEntry(const QVariantMap &object) {
    
    Entry entry = Entry::fromObject(object);
    if (!entry.entry_id || !entry.entry_set_id) return -1;
    
    int index = db.setEntry(entry);
    
    if (index >= 0) {
        qDebug() << "Save entry" << entry.entry_id;
        saveDb();
        emit dataChanged();
    }
    else {
        qDebug() << entry.entry_set_id << "This set doesn't exist.";
    }
    return index;
}

int AppData::setSet(const QVariantMap &object) {
    
    EntrySet set = EntrySet::fromObject(object);
    if (!set.set_id) return -1;
    
    int index = db.setSet(set);
    
    qDebug() << "Save set" << set.set_id;
    saveDb();
    emit dataChanged();
    
    return index;
}

void AppData::removeSet(int setId) {
    db.sets.remove(setId);
    qDebug() << "Remove set" << setId;
    
    saveDb();
    emit dataChanged();
}

QString AppData::sprintf(const QString format, int number) const {
    QByteArray bytes = format.toUtf8();
    const char* cformat = bytes.data();
    return QString::asprintf(cformat, number);
}
