#ifndef APPDATA_H
#define APPDATA_H

#include <QObject>
#include <QJsonDocument>
#include "entry.h"

class QQmlEngine;
class QJSValue;
class QJSEngine;
class QFileSystemWatcher;

class App : public QObject {
    Q_OBJECT
    
    Q_PROPERTY(QStringList images READ getImages NOTIFY imagesChanged)
    Q_PROPERTY(QList<EntrySet> sets READ getData NOTIFY dataChanged)
    Q_PROPERTY(QList<EntryTemplate> templates MEMBER templates CONSTANT)
    Q_PROPERTY(QString imagePath READ getImagePath CONSTANT)
    
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
    explicit App(QObject *parent = nullptr);
    
    static QJSValue registerType(QQmlEngine* engine, QJSEngine *script);
    
    static void registerSingleton(QQmlEngine* engine);
    
    QStringList getImages() const;
    
    QString getImagePath() const;
    
    QList<EntrySet> getData() const;
    
    Q_INVOKABLE void removeFile(QString path) const;
    
    Q_INVOKABLE int setEntry(const QVariantMap &entry);
    
    Q_INVOKABLE int removeEntry(int setId, int entryId);
    
    Q_INVOKABLE int setSet(const QVariantMap &set);
    
    Q_INVOKABLE int removeSet(int setId);
    
    Q_INVOKABLE QString exportSet(const QString &fileName, int setId);
    
    QString getExportPath(const QString fileName, int revision = 1) const;
    
    inline Q_INVOKABLE int nextSetId() const {
        return db.nextSetId();
    }
    
    inline Q_INVOKABLE int nextEntryId() const {
        return db.nextEntryId();
    }
    
    static Q_INVOKABLE QString sprintf(const QString format, int number);
    
signals:
    void imagesChanged();
    void dataChanged();
};

#endif // APPDATA_H
