#include "csvwriter.h"

#include <QTextStream>
#include <QIODevice>
#include <QRegularExpression>
#include <QDebug>

static const auto DIRTY_RE = QRegularExpression("[ ,'\"\\r\\n]");
static const auto BREAK_RE = QRegularExpression("[\\r\\n]");

const QString cleanString(const QString &str) {
    
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

const QString cleanZeros(const QString &num) {
    QString dirty(num);
    
    int i = num.length() - 1;
    for (; i >= 0 && num[i] == '0'; i--);
    if (num[i] == '.') i++;
    
    dirty.remove(i + 1, num.length());
    
    return dirty;
}

CsvWriter::CsvWriter(QIODevice* file) {
    stream = new QTextStream(file);
}

CsvWriter::CsvWriter(QString* file) {
    stream = new QTextStream(file);
}

CsvWriter::~CsvWriter() {
    delete stream;
}

void CsvWriter::write(const QVariant &item) {
    
    if (item.type() == QVariant::String) {
        write(item.toString());
    }
    else if (item.type() == QVariant::Int) {
        write(item.toInt());
    }
    else if (item.type() == QVariant::Double) {
        write(item.toDouble());
    }
    else if (item.type() == QVariant::List) {
        writeList(item.toList());
    }
    else {
        write(item.toString());
    }
}

void CsvWriter::write(const QString &item) {
    if (rowCount++) (*stream) << ",";
    (*stream) << cleanString(item);
}

void CsvWriter::write(const char* item) {
    write(QString::fromLocal8Bit(item));
}

void CsvWriter::write(const int item) {
    write(QString::number(item));
}

void CsvWriter::write(const qreal item) {
    write(cleanZeros(QString::number(item, 'f', 8)));
}

void CsvWriter::write(std::initializer_list<QVariant> list) {
    writeList(QVariantList(list));
}

void CsvWriter::writeList(QVariantList list) {
    for (const QVariant &item : list) {
        write(item);
    }
}

void CsvWriter::newRow() {
    rowCount = 0;
    (*stream) << "\n";
}
