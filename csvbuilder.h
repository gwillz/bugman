#ifndef CSVBUILDER_H
#define CSVBUILDER_H

#include <QObject>

class CSVBuilder;

class CSVRow {
    friend class CSVBuilder;
    
    CSVBuilder *parent;
    QStringList items;
    
    CSVRow(CSVBuilder *parent);
    
public:
    
    CSVRow& item(const QVariant &data);
    CSVRow& item(const QString &data);
    CSVRow& item(const QDateTime &data);
    CSVRow& item(const char *data);
    CSVRow& item(const qreal data);
    CSVRow& item(const int data);
    
    CSVBuilder& end();
};


class CSVBuilder {
    
    QList<QString> headers;
    QList<QStringList> rows;
    
public:
    CSVBuilder& header(const QString &name);
    
    CSVBuilder& row(const QStringList &items);
    CSVBuilder& row(const QVariantList &items);
    CSVRow row();
    
    QString build() const;
    
    static const QString cleanString(const QString &str);
    static const QString cleanZeros(const QString &num);
};


#endif // CSVBUILDER_H
