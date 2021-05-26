#ifndef VALUE_H
#define VALUE_H

#include <QObject>
#include <QDateTime>
#include <float.h>
#include <algorithm>

class DatedValue
{

public:
    DatedValue(const double &i_value, const QDateTime &i_date, const int &i_observationIndex);
    QDateTime date;
    double value;
    int observationIndex;
};



class DatedValueList: public QList<DatedValue>
{

public:
    //Constructor
    DatedValueList(const QString &i_name, const QString &i_unit);

    QString getName();
    QString getUnit();
    void sort();

private:
    QString name;
    QString unit;

};




#endif // VALUE_H
