#ifndef DATAENTRY_H
#define DATAENTRY_H

#include <QObject>
#include <QList>
#include <QMap>

class QJsonObject;

class EntryPosition {
    Q_GADGET;
public:
    Q_PROPERTY(qreal latitude MEMBER latitude)
    Q_PROPERTY(qreal longitude MEMBER longitude)
    Q_PROPERTY(qreal altitude MEMBER altitude)
    
    qreal latitude;
    qreal longitude;
    qreal altitude;
    
    void operator=(const EntryPosition &other);
    bool operator==(const EntryPosition &other) const;
    inline bool operator!=(const EntryPosition &other) const {
        return !(*this == other);
    }
    
    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;
    
    static EntryPosition fromObject(const QVariantMap &object);
    
};

Q_DECLARE_METATYPE(EntryPosition)

class EntryField {
    Q_GADGET;
public:
    Q_PROPERTY(QString name MEMBER name)
    Q_PROPERTY(QString type MEMBER type)
    Q_PROPERTY(QString value MEMBER value)
    
    QString name;
    QString type;
    QString value;
    
    void operator=(const EntryField &other);
    bool operator==(const EntryField &other) const;
    inline bool operator!=(const EntryField &other) const {
        return !(*this == other);
    }
    
    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;
    
    static EntryField fromObject(const QVariantMap &object);
    
};

Q_DECLARE_METATYPE(EntryField)

class Entry {
    Q_GADGET;
public:
    Q_PROPERTY(int entry_id MEMBER entry_id)
    Q_PROPERTY(int entry_set_id MEMBER entry_set_id)
    Q_PROPERTY(QString voucher MEMBER voucher)
    Q_PROPERTY(QString timestamp MEMBER timestamp)
    Q_PROPERTY(EntryPosition position MEMBER position)
    Q_PROPERTY(QString collector MEMBER collector)
    Q_PROPERTY(QList<QString> images MEMBER images)
    Q_PROPERTY(QList<EntryField> fields MEMBER fields)
    
    int entry_id;
    int entry_set_id;
    QString voucher;
    EntryPosition position;
    QString timestamp;
    QString collector;
    QList<QString> images;
    QList<EntryField> fields;
    
    void operator=(const Entry &other);
    bool operator==(const Entry &other) const;
    inline bool operator!=(const Entry &other) const {
        return !(*this == other);
    }
    
    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;
    
    static Entry fromObject(const QVariantMap &object);
    
};

Q_DECLARE_METATYPE(Entry)

class EntrySet {
    Q_GADGET;
public:
    Q_PROPERTY(int set_id MEMBER set_id)
    Q_PROPERTY(QString name MEMBER name)
    Q_PROPERTY(QString collector MEMBER collector)
    Q_PROPERTY(QString voucher_format MEMBER voucher_format)
    Q_PROPERTY(QList<EntryField> fields MEMBER fields)
    Q_PROPERTY(QList<Entry> entries READ getEntries)
    
    Q_PROPERTY(QString next_voucher READ getNextVoucher STORED false)
    
    int set_id;
    QString name;
    QString collector;
    QString voucher_format;
    
    QList<EntryField> fields;
    QMap<int, Entry> entries;
    
    void operator=(const EntrySet &other);
    bool operator==(const EntrySet &other) const;
    inline bool operator!=(const EntrySet &other) const {
        return !(*this == other);
    }
    
    inline QList<Entry> getEntries() const {
        return entries.values();
    }
    
    Q_INVOKABLE QString getNextVoucher() const;
    
    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;
    
    static EntrySet fromObject(const QVariantMap &object);
    
};

Q_DECLARE_METATYPE(EntrySet)

class EntryDatabase {
    
public:
    QMap<int, EntrySet> sets;
    int entryCount;
    
    inline void clear() {
        sets.clear();
    }
    
    int setEntry(const Entry &entry);
    int setSet(const EntrySet &set);
    
    int read(const QJsonObject &json);
    void write(QJsonObject &json) const;
};


class EntryTemplate {
    Q_GADGET;
public:
    Q_PROPERTY(QString name MEMBER name)
    Q_PROPERTY(QString author MEMBER author)
    Q_PROPERTY(QList<EntryField> fields MEMBER fields)
    
    QString name;
    QString author;
    QList<EntryField> fields;
    
    void operator=(const EntryTemplate &other);
    bool operator==(const EntryTemplate &other) const;
    inline bool operator!=(const EntryTemplate &other) const {
        return !(*this == other);
    }
    
    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;
};

Q_DECLARE_METATYPE(EntryTemplate)

#endif // DATAENTRY_H
