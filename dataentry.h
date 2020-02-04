#ifndef DATAENTRY_H
#define DATAENTRY_H

#include <QObject>
#include <QList>

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
};

Q_DECLARE_METATYPE(EntryField)

class Entry {
    Q_GADGET;
public:
    Q_PROPERTY(int entry_id MEMBER entry_id)
    Q_PROPERTY(int timestamp MEMBER timestamp)
    Q_PROPERTY(QString voucher MEMBER voucher)
    Q_PROPERTY(QString collector MEMBER collector)
    Q_PROPERTY(EntryPosition position MEMBER position)
    Q_PROPERTY(QList<QString> images MEMBER images)
    Q_PROPERTY(QList<EntryField> data MEMBER data)
    
    int entry_id;
    int timestamp;
    QString voucher;
    QString collector;
    EntryPosition position;
    QList<QString> images;
    QList<EntryField> data;
    
    void operator=(const Entry &other);
    bool operator==(const Entry &other) const;
    inline bool operator!=(const Entry &other) const {
        return !(*this == other);
    }
    
    Q_INVOKABLE QString getTimestampString() const;
    Q_INVOKABLE QString getPositionString() const;
    Q_INVOKABLE QString getPreviewString() const;
    
    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;
    
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
    Q_PROPERTY(QList<Entry> entries MEMBER entries)
    
    Q_PROPERTY(QString next_voucher READ getNextVoucher STORED false)
    
    int set_id;
    QString name;
    QString collector;
    QString voucher_format;
    
    QList<EntryField> fields;
    QList<Entry> entries;
    
    void operator=(const EntrySet &other);
    bool operator==(const EntrySet &other) const;
    inline bool operator!=(const EntrySet &other) const {
        return !(*this == other);
    }
    
    Q_INVOKABLE QString getNextVoucher() const;
    
    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;
    
};

Q_DECLARE_METATYPE(EntrySet)

class EntryDatabase {
    
public:
    QList<EntrySet> sets;
    QList<Entry> entries;
    
    inline void clear() {
        sets.clear();
        entries.clear();
    }
    
    void read(const QJsonObject &json);
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
