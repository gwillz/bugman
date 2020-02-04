
#include "dataentry.h"
#include <QDebug>
#include <QDateTime>
#include <QJsonObject>
#include <QJsonArray>

#define JSON_IS_LIST(field) json.contains(#field) && json[#field].isArray()

#define JSON_IS_OBJECT(field) json.contains(#field) && json[#field].isObject()

#define JSON_IS_STRING(field) json.contains(#field) && json[#field].isString()

#define JSON_IS_NUMBER(field) json.contains(#field) && json[#field].isDouble()

#define JSON_READ_STRING(field) \
    if (JSON_IS_STRING(field)) \
        field = json[#field].toString(); \
    else qDebug() << #field " is not a string.";

#define JSON_READ_INT(field) \
    if (JSON_IS_NUMBER(field)) \
        field = json[#field].toInt(); \
    else qDebug() << #field " is not a number (int).";

#define JSON_READ_REAL(field) \
    if (JSON_IS_NUMBER(field)) \
        field = json[#field].toDouble(); \
    else qDebug() << #field " is not a number (real).";

#define JSON_READ_OBJECT(field, Type) \
    if (JSON_IS_OBJECT(field)) { \
        field = Type(); \
        field.read(json[#field].toObject()); \
    } \
    else qDebug() << #field " is not an object.";

#define JSON_FOR_LIST(field, value) \
    if (JSON_IS_LIST(field)) \
        for (QJsonValue value : json[#field].toArray())

#define JSON_WRITE(field) json[#field] = field

#define JSON_WRITE_OBJECT(field) \
    { \
        QJsonObject object; \
        field.write(object); \
        json[#field] = object; \
    }

void EntryPosition::read(const QJsonObject &json) {
    JSON_READ_REAL(latitude);
    JSON_READ_REAL(longitude);
    JSON_READ_REAL(elevation);
}

void EntryPosition::write(QJsonObject &json) const {
    JSON_WRITE(latitude);
    JSON_WRITE(longitude);
    JSON_WRITE(elevation);
}

void EntryField::read(const QJsonObject &json) {
    JSON_READ_STRING(name);
    JSON_READ_STRING(type);
    
//    if (JSON_IS_STRING(type)) {
//        type = EntryField::typeFromString(json["type"].toString());
//    }
}

void EntryField::write(QJsonObject &json) const {
    JSON_WRITE(name);
    JSON_WRITE(type);
//    json["type"] = EntryField::typeToString(type);
}

//QString EntryField::typeToString(EntryField::EntryFieldType type) {
//    switch (type) {
//        case String: return "string";
//        case Text: return "text";
//        case Integer: return "integer";
//        case Decimal: return "decimal";
//    }
//    return "string";
//}

//EntryField::EntryFieldType EntryField::typeFromString(QString type) {
//    type = type.toLower();
    
//    if (type == "string")  return EntryField::EntryFieldType::String;
//    if (type == "text")    return EntryField::EntryFieldType::Text;
//    if (type == "integer") return EntryField::EntryFieldType::Integer;
//    if (type == "decimal") return EntryField::EntryFieldType::Decimal;
    
//    return EntryField::EntryFieldType::String;
//}

void EntryItem::read(const QJsonObject &json) {
    JSON_READ_STRING(name);
    JSON_READ_STRING(value);
}

void EntryItem::write(QJsonObject &json) const {
    JSON_WRITE(name);
    JSON_WRITE(value);
}

void Entry::operator=(const Entry &other) {
    entry_id = other.entry_id;
    voucher = other.voucher;
    collector = other.collector;
    position = other.position;
    images.clear();
    images.append(other.images);
    data.clear();
    data.append(other.data);
}

bool Entry::operator==(const Entry &other) const {
    return entry_id == other.entry_id &&
        voucher == other.voucher &&
        collector == other.collector &&
        position == other.position &&
        images == other.images &&
        data == other.data;
}

bool Entry::operator!=(const Entry &other) const {
    return !operator==(other);
}

QString Entry::getPositionString() const {
    QString str;
    str.append(QString::number(position.latitude, 'f', 5));
    str.append(", ");
    str.append(QString::number(position.longitude, 'f', 5));
    str.append(" @ ");
    str.append(QString::number(position.elevation, 'f', 0));
    str.append("m");
    return str;
}

QString Entry::getTimestampString() const {
    QDateTime datetime = QDateTime::fromSecsSinceEpoch(timestamp);
    return datetime.toString("dd MMM yyyy - HH:mm");
}

QString Entry::getPreviewString() const {
    QDateTime datetime = QDateTime::fromSecsSinceEpoch(timestamp);
    return datetime.toString("dd MMM yyyy / HH:mm") + " / " + collector;
}

void Entry::read(const QJsonObject &json) {
    JSON_READ_INT(entry_id);
    JSON_READ_INT(timestamp);
    JSON_READ_STRING(voucher);
    JSON_READ_STRING(collector);
    JSON_READ_OBJECT(position, EntryPosition);
    
    JSON_FOR_LIST(images, value) {
        if (value.isString()) {
            images.append(value.toString());
        }
    }
    
    JSON_FOR_LIST(data, value) {
        if (value.isObject()) {
            EntryItem item;
            item.read(value.toObject());
            data.append(item);
        }
    }
    
    qDebug() << entry_id;
    qDebug() << voucher;
    qDebug() << collector;
}

void Entry::write(QJsonObject &json) const {
    JSON_WRITE(entry_id);
    JSON_WRITE(timestamp);
    JSON_WRITE(voucher);
    JSON_WRITE_OBJECT(position);
}

void EntrySet::operator=(const EntrySet &other) {
    voucher_format = other.voucher_format;
    collector = other.collector;
    entries.clear();
    entries.append(other.entries);
    fields.clear();
    fields.append(other.fields);
}

bool EntrySet::operator==(const EntrySet &other) const {
    return set_id == other.set_id &&
        voucher_format == other.voucher_format &&
        collector == other.collector &&
        fields == other.fields &&
        entries == other.entries;
}

bool EntrySet::operator!=(const EntrySet &other) const {
    return !operator==(other);
}

QString EntrySet::getNextVoucher() const {
    QByteArray format = voucher_format.toUtf8();
    const char *cformat = format.constData();
    
    return QString::asprintf(cformat, entries.size() + 1);
}

void EntrySet::read(const QJsonObject &json) {
    JSON_READ_INT(set_id);
    JSON_READ_STRING(name);
    JSON_READ_STRING(collector);
    JSON_READ_STRING(voucher_format);
    
    JSON_FOR_LIST(fields, value) {
        if (value.isObject()) {
            EntryField field;
            field.read(value.toObject());
            fields.append(field);
        }
    }
    
    JSON_FOR_LIST(entries, value) {
        if (value.isObject()) {
            Entry entry;
            entry.read(value.toObject());
            entries.append(entry);
        }
    }
    
    qDebug() << set_id;
    qDebug() << name;
    qDebug() << collector;
    qDebug() << voucher_format;
}

void EntrySet::write(QJsonObject &json) const {
    JSON_WRITE(set_id);
    JSON_WRITE(name);
    JSON_WRITE(collector);
    JSON_WRITE(voucher_format);
    
    {
        QJsonArray array;
        for (EntryField field : fields) {
            QJsonObject object;
            field.write(object);
            array.append(object);
        }
        json["fields"] = array;
    }
    {
        QJsonArray array;
        for (Entry entry : entries) {
            QJsonObject object;
            entry.write(object);
            array.append(object);
        }
        json["entries"] = array;
    }
}
