#ifndef APPDATA_H
#define APPDATA_H

#include <QObject>
#include <QJsonDocument>
#include "entry.h"

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
    QString csvPath;
    QString dbPath;
    
    EntryDatabase db;
    QList<EntryTemplate> templates;
    
    void loadDb();
    void saveDb() const;
    void loadTemplates();
    void watchImages();
    
public:
    explicit AppData(QObject *parent = nullptr);
    
    static QJSValue registerType(QQmlEngine* engine, QJSEngine *script);
    
    QStringList getImages();
    
    QList<EntrySet> getData() const;
    
    Q_INVOKABLE int setEntry(const QVariantMap &entry);
    
    Q_INVOKABLE void removeEntry(int setId, int entryId);
    
    Q_INVOKABLE int setSet(const QVariantMap &set);
    
    Q_INVOKABLE void removeSet(int setId);
    
    Q_INVOKABLE void exportSet(const QString &fileName, int setId);
    
    QString getExportPath(const QString fileName, int revision = 1) const;
    
    inline Q_INVOKABLE int nextSetId() const {
        return db.nextSetId();
    }
    
    inline Q_INVOKABLE int nextEntryId() const {
        return db.nextEntryId();
    }
    
    Q_INVOKABLE QString sprintf(const QString format, int number) const;
    
signals:
    void imagesChanged();
    void dataChanged();
};

#endif // APPDATA_H
