#ifndef APPDATA_H
#define APPDATA_H

#include <QObject>
#include <QJsonDocument>
#include "dataentry.h"

class QQmlEngine;
class QJSValue;
class QJSEngine;
class QFileSystemWatcher;

class AppData : public QObject {
    Q_OBJECT
    
    Q_PROPERTY(QStringList images READ getImages NOTIFY imagesChanged)
    Q_PROPERTY(QList<EntrySet> sets READ getData NOTIFY dataChanged)
    
    QFileSystemWatcher* imageWatcher;
    QStringList imagePaths;
    QString appPath;
    QString dbPath;
    QList<EntrySet> sets;
    QList<Entry> entries;
    
    explicit AppData(QObject *parent = nullptr);
    
public:
    static QJSValue registerType(QQmlEngine* engine, QJSEngine *script);
    
    void loadDb();
    void saveDb() const;
    
    QStringList getImages();
    
    QList<EntrySet> getData() const;
    
    Q_INVOKABLE void setEntry(const Entry &entry);
    
    Q_INVOKABLE void setSet(const EntrySet &set);
    
signals:
    void imagesChanged();
    void dataChanged();
};

#endif // APPDATA_H
