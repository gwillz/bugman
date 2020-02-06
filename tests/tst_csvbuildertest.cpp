#include <QtTest/QtTest>

#include "../csvbuilder.h"

class CSVBuilderTest : public QObject {
    Q_OBJECT
    
private slots:
    void test();
    
};

void CSVBuilderTest::test() {
    
    QString csv = CSVBuilder()
        .header("one")
        .header("two")
        .header("three,four")
        .row()
            .item("abc")
            .item(QString("uhh\" nice"))
            .item(QVariant("This \n is \r a mess  "))
        .end()
        .row(QVariantList({1, 2.345, 6.0, "neat"}))
        .row(QStringList({"neat", "stuff"}))
    .build();
    
//    qDebug() << csv;
    
    QString expected =
        "one,two,\"three,four\"\n"
        "abc,\"uhh\\\" nice\",\"This  is  a mess\"\n"
        "1,2.345,6.0,neat\n"
        "neat,stuff\n"
    ;
    
    QCOMPARE(csv, expected);
}

QTEST_MAIN(CSVBuilderTest)

#include "tst_csvbuildertest.moc"
