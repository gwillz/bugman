#ifndef CSVWRITER_H
#define CSVWRITER_H

#include <QVariant>

class QTextStream;
class QIODevice;

class CsvWriter {
    
    QTextStream* stream;
    int rowCount = 0;
    
public:
    CsvWriter(QIODevice* file);
    CsvWriter(QString* file);
    ~CsvWriter();
    
    void write(const QVariant &item);
    void write(const QString &item);
    void write(const char* item);
    void write(const int item);
    void write(const qreal item);
    void write(std::initializer_list<QVariant> list);
    void writeList(QVariantList list);
    
    void newRow();
};

#endif // CSVWRITER_H
