#include "app.h"

#include <QDebug>
#include <QStandardPaths>
#include <QDir>
#include <QFileSystemWatcher>
#include <QQmlEngine>
#include <QQmlContext>
#include <QFile>
#include <QJsonArray>
#include <QJsonObject>
#include <QDateTime>
#include "csvwriter.h"

static App* instance = nullptr;

App::App(QObject *parent)
        : QObject(parent) {
    
    appPath = QStandardPaths::standardLocations(QStandardPaths::AppDataLocation).last();
    csvPath = QStandardPaths::standardLocations(QStandardPaths::DocumentsLocation).last();
    imagePaths = QStandardPaths::standardLocations(QStandardPaths::PicturesLocation);
    dbPath = appPath + "/db.json";
    
    QDir().mkpath(appPath);
    
    loadDb();
    loadTemplates();
}

QJSValue App::registerType(QQmlEngine* engine, QJSEngine *script) {
    return script->newQObject(new App(engine));
}

void App::registerSingleton(QQmlEngine *qmlEngine) {
    if (instance == nullptr) {
        instance = new App(qmlEngine);
    }
    QQmlContext* rootContext = qmlEngine->rootContext();
    rootContext->setContextProperty("App", instance);
}

void App::watchImages() {
    if (imageWatcher != nullptr) delete imageWatcher;
    
    imageWatcher = new QFileSystemWatcher(this);
    imageWatcher->addPaths(imagePaths);
    
    connect(imageWatcher, &QFileSystemWatcher::directoryChanged,
            this, &App::imagesChanged);
}

void App::loadDb() {
    db.clear();
    
    qDebug() << "DB:" << dbPath;
    
    QFile dbFile(dbPath);
    int entryCount = 0;
    
    if (dbFile.open(QIODevice::ReadOnly)) {
        QByteArray data = dbFile.readAll();
        QJsonDocument doc = QJsonDocument::fromJson(data);
        
        entryCount = db.read(doc.object());
        
        dbFile.close();
    }
    
    qDebug() << "Sets:" << db.sets.size();
    qDebug() << "Entries:" << entryCount;
}

void App::saveDb() const {
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
    
    dbFile.close();
    qDebug() << "DB written.";
}

void App::loadTemplates() {
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
        
        file.close();
    }
    
    qDebug() << "Templates:" << templates.size();
}

QStringList App::getImages() {
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

QList<EntrySet> App::getData() const {
    return db.sets.values();
}

int App::setEntry(const QVariantMap &object) {
    
    Entry entry = Entry::fromObject(object);
    if (!entry.entry_id || !entry.entry_set_id) {
        return -1;
    }
    
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

int App::removeEntry(int setId, int entryId) {
    
    if (db.sets.contains(setId)) {
        qDebug() << "Remove entry" << entryId << "from set" << setId;
        int index = db.sets.keys().indexOf(setId);
        int count = db.sets[setId].entries.remove(entryId);
        
        if (count < 1) {
            qDebug() << "Entry not in set?";
            return -1;
        }
        else {
            saveDb();
            emit dataChanged();
            return index;
        }
    }
    else {
        qDebug() << setId << "This set doesn't exist.";
        return -1;
    }
}

int App::setSet(const QVariantMap &object) {
    
    EntrySet set = EntrySet::fromObject(object);
    if (!set.set_id) return -1;
    
    int index = db.setSet(set);
    
    qDebug() << "Save set" << set.set_id;
    saveDb();
    emit dataChanged();
    
    return index;
}

int App::removeSet(int setId) {
    int index = db.sets.keys().indexOf(setId);
    
    int count = db.sets.remove(setId);
    if (count < 0) {
        qDebug() << "Set doesn't exist?";
        return -1;
    }
    else {
        saveDb();
        emit dataChanged();
        qDebug() << "Remove set" << setId;
        
        return index;
    }
}

QString App::getExportPath(const QString fileName, int revision) const {
    QString path(fileName);
    
    if (!path.endsWith(".csv")) {
        path.append(".csv");
    }
    
    if (revision > 1) {
        path.insert(path.length() - 4, QString("-%1").arg(revision));
    }
    
    path.prepend("/");
    path.prepend(csvPath);
    
    return path;
}

void App::exportSet(const QString &fileName, int setId) {
    if (!db.sets.contains(setId)) {
        qDebug() << setId << "set not found.";
        return;
    }
    
    const EntrySet set = db.sets[setId];
    QString path = getExportPath(fileName);
    QFile file(path);
    
    int revision = 1;
    while (file.exists()) {
        path = getExportPath(fileName, ++revision);
        
        if (revision >= 100) {
            qDebug() << "Revision limit exceeded" << revision;
            return;
        }
    }
    
    if (!file.open(QIODevice::WriteOnly)) {
        qWarning() << "Cannot write file" << path;
        return;
    }
    
    CsvWriter csv(&file);
    csv.write("Voucher");
    csv.write("Date");
    csv.write("Time");
    csv.write("Latitude");
    csv.write("Longitude");
    csv.write("Altitude (m)");
    csv.write("Collector");
    
    QStringList fieldNames = set.getFieldNames();
    
    for (const QString name : fieldNames) {
        csv.write(name);
    }
    
    csv.newRow();
    
    for (const Entry entry : set.entries) {
        QDateTime date = QDateTime::fromMSecsSinceEpoch(entry.timestamp.toLongLong());
        
        csv.write(entry.voucher);
        csv.write(date.date());
        csv.write(date.time());
        csv.write(entry.position.latitude);
        csv.write(entry.position.longitude);
        csv.write(entry.position.altitude);
        csv.write(entry.collector);
        
        QMap<QString, EntryField> fields = entry.getFieldMap(); 
        
        for (const QString name : fieldNames) {
            const EntryField field = fields[name];
            csv.write(field.value);
        }
        
        csv.newRow();
    }
    
    qDebug() << "Written file" << path;
    file.close();
}

QString App::sprintf(const QString format, int number) const {
    QByteArray bytes = format.toUtf8();
    const char* cformat = bytes.data();
    return QString::asprintf(cformat, number);
}
