#include "csvbuilder.h"

#include <QVariant>
#include <QDateTime>
#include <QRegularExpression>

CSVRow CSVBuilder::row() {
    return CSVRow(this);
}

CSVRow::CSVRow(CSVBuilder *parent) : parent(parent) {}

CSVRow& CSVRow::item(const QVariant &data) {
    
    if (data.type() == QVariant::String) {
        return item(data.toString());
    }
    
    if (data.type() == QVariant::Int) {
        return item(data.toInt());
    }
    
    if (data.type() == QVariant::Double) {
        return item(data.toDouble());
    }
    
    if (data.canConvert(QVariant::Double)) {
        return item(data.toDouble());
    }
    
    if (data.canConvert(QVariant::DateTime)) {
        return item(data.toDateTime());
    }
    
    return item(data.toString());
}

CSVRow& CSVRow::item(const char *data) {
    items.append(QString::fromLocal8Bit(data));
    return *this;
}

CSVRow& CSVRow::item(const QString &data) {
    items.append(data);
    return *this;
}

CSVRow& CSVRow::item(const QDateTime &data) {
    items.append(data.toUTC().toString(Qt::ISODate));
    return *this;
}

CSVRow& CSVRow::item(const qreal data) {
    items.append(CSVBuilder::cleanZeros(QString::number(data, 'f', 8)));
    return *this;
}

CSVRow& CSVRow::item(const int data) {
    items.append(QString::number(data));
    return *this;
}

CSVBuilder& CSVRow::end() {
    parent->row(items);
    return *parent;
}


CSVBuilder& CSVBuilder::header(const QString &name) {
    headers.append(CSVBuilder::cleanString(name));
    return *this;
}

CSVBuilder& CSVBuilder::row(const QStringList &items) {
    QStringList row;
    
    for (QString item : items) {
        row.append(CSVBuilder::cleanString(item));
    }
    
    rows.append(row);
    
    return *this;
}

CSVBuilder& CSVBuilder::row(const QVariantList &items) {
    CSVRow row(this);
    
    for (QVariant item : items) {
        row.item(item);
    }
    row.end();
    
    return *this;
}

QString CSVBuilder::build() const {
    QString builder;
    
    builder.append(headers.join(","));
    builder.append("\n");
    
    for (QStringList items : rows) {
        builder.append(items.join(","));
        builder.append("\n");
    }
    
    return builder;
}

const auto DIRTY_RE = QRegularExpression("[ ,'\"\\r\\n]");
const auto BREAK_RE = QRegularExpression("[\\r\\n]");

const QString CSVBuilder::cleanString(const QString &str) {
    
    const auto match = DIRTY_RE.match(str);
    
    if (match.hasMatch()) {
        QString dirty(str);
        dirty.replace(BREAK_RE, "");
        dirty.replace("\"", "\\\"");
        
        dirty = dirty.trimmed();
        dirty.prepend("\"");
        dirty.append("\"");
        
        return dirty;
    }
    else {
        return str.trimmed();
    }
}

const QString CSVBuilder::cleanZeros(const QString &num) {
    QString dirty(num);
    
    int i = num.length() - 1;
    for (; i >= 0 && num[i] == '0'; i--);
    if (num[i] == '.') i++;
    
    dirty.remove(i + 1, num.length());
    
    return dirty;
}
