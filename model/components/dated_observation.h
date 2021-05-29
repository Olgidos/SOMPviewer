#ifndef DATED_TLE_H
#define DATED_TLE_H

#include <QObject>
#include <QDateTime>
#include <float.h>
#include <algorithm>
#include <QImage>
#include <QDebug>


class DatedObservation
{

public:
    DatedObservation(const QString &i_tle1, const QString &i_tle2, const QDateTime &i_start);

    //to make it printable via qDebug()
    operator QString() const {
        QString d;
        d += "id: " + QString::number(id) + " \n";
        d += "start: " + start.toString() + " \n";
        d += "end: " + end.toString() + " \n";
        d += "tle1: " + tle1 + " \n";
        d += "tle2: " + tle2 + " \n";
        d += "max_altitude: " + QString::number(max_altitude) + " \n";
        d += "rise_azimuth: " + QString::number(rise_azimuth) + " \n";
        d += "set_azimuth: " + QString::number(set_azimuth) + " \n";
        d += "station_lat: " + QString::number(station_lat) + " \n";
        d += "station_lng: " + QString::number(station_lng) + " \n";
        d += "station_name: " + station_name + " \n";
        d += "status: " + status + " \n";
        d += "tle0: " + tle0 + " \n";
        d += "transmitter_description: " + transmitter_description + " \n";
        //d += "waterfall size: " + QString::number(waterfall.height()) + " " + QString::number(waterfall.width());
        return d;
    }

    QDateTime start;
    QDateTime end;
    QString tle1;
    QString tle2;
    double max_altitude;
    double rise_azimuth;
    double set_azimuth;
    double station_lat;
    double station_lng;
    QString station_name;
    QString status;
    QString tle0;
    QString transmitter_description;
    QString waterfall;
    int id;
};



class DatedObservationList: public QList<DatedObservation>
{

public:
    //Constructor
    DatedObservationList();

    void sort();
    int getObsIndex(const int &i_id);
};


#endif // DATED_TLE_H
