#ifndef DATAENTRY_H
#define DATAENTRY_H

#include <QObject>
#include <QList>

class QJsonObject;

class EntryPosition {
    Q_GADGET;
public:
    qreal latitude;
    qreal longitude;
    qreal elevation;
    
    inline bool operator==(const EntryPosition &other) const {
        return latitude == other.latitude &&
            longitude == other.longitude &&
            elevation == other.elevation;
    }
    
    inline bool operator!=(const EntryPosition &other) const {
        return !operator==(other);
    }
    
    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;
};

Q_DECLARE_METATYPE(EntryPosition)

class EntryField {
    Q_GADGET;
public:
//    enum EntryFieldType {
//        String,
//        Text,
//        Integer,
//        Decimal,
//    };
    
//    Q_ENUM(EntryFieldType)
    Q_PROPERTY(QString name MEMBER name)
    Q_PROPERTY(QString type MEMBER type)
    
    QString name;
    QString type;
    
    inline bool operator==(const EntryField &other) const {
        return name == other.name && type == other.type;
    }
    
    inline bool operator!=(const EntryField &other) const {
        return !operator==(other);
    }
    
    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;
    
//    static EntryFieldType typeFromString(QString type);
//    static QString typeToString(EntryFieldType type);
};

Q_DECLARE_METATYPE(EntryField)

class EntryItem {
    Q_GADGET;
public:
    Q_PROPERTY(QString name MEMBER name)
    Q_PROPERTY(QString value MEMBER value)
    
    QString name;
    QString value;
    
    inline bool operator==(const EntryItem &other) const {
        return name == other.name && value == other.value;
    }
    
    inline bool operator!=(const EntryItem &other) const {
        return !operator==(other);
    }
    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;
};

Q_DECLARE_METATYPE(EntryItem)

class Entry {
    Q_GADGET;
public:
    Q_PROPERTY(int entry_id MEMBER entry_id)
    Q_PROPERTY(int timestamp MEMBER timestamp)
    Q_PROPERTY(QString voucher MEMBER voucher)
    Q_PROPERTY(QString collector MEMBER collector)
    Q_PROPERTY(EntryPosition position MEMBER position)
    Q_PROPERTY(QList<QString> images MEMBER images)
    Q_PROPERTY(QList<EntryItem> data MEMBER data)
    
    Q_PROPERTY(QString timestamp_string READ getTimestampString CONSTANT)
    Q_PROPERTY(QString position_string READ getPositionString CONSTANT)
    
    int entry_id;
    int timestamp;
    QString voucher;
    QString collector;
    EntryPosition position;
    QList<QString> images;
    QList<EntryItem> data;
    
    void operator=(const Entry &other);
    bool operator==(const Entry &other) const;
    bool operator!=(const Entry &other) const;
    
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
    
    int set_id;
    QString name;
    QString collector;
    QString voucher_format;
    
    QList<EntryField> fields;
    QList<Entry> entries;
    
    void operator=(const EntrySet &other);
    bool operator==(const EntrySet &other) const;
    bool operator!=(const EntrySet &other) const;
    
    Q_INVOKABLE QString getNextVoucher() const;
    
    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;
    
};

Q_DECLARE_METATYPE(EntrySet)

#endif // DATAENTRY_H
