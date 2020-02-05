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
    Q_PROPERTY(QList<EntryTemplate> templates MEMBER templates CONSTANT)
    
    QFileSystemWatcher* imageWatcher;
    QStringList imagePaths;
    
    QString appPath;
    QString dbPath;
    
    EntryDatabase db;
    QList<EntryTemplate> templates;
    
    explicit AppData(QObject *parent = nullptr);
    
public:
    static QJSValue registerType(QQmlEngine* engine, QJSEngine *script);
    
    void loadDb();
    void saveDb() const;
    void loadTemplates();
    
    QStringList getImages();
    
    QList<EntrySet> getData() const;
    
    Q_INVOKABLE int setEntry(const QVariantMap &entry);
    
    Q_INVOKABLE int setSet(const QVariantMap &set);
    
    Q_INVOKABLE void removeSet(int setId);
    
    inline Q_INVOKABLE int nextSetId() const {
        return db.sets.size() + 1;
    }
    
    inline Q_INVOKABLE int nextEntryId() const {
        return db.entryCount + 1;
    }
    
    Q_INVOKABLE QString sprintf(const QString format, int number) const;
    
signals:
    void imagesChanged();
    void dataChanged();
};

#endif // APPDATA_H
