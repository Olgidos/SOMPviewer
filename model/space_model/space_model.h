#ifndef EARTH_H
#define EARTH_H

//QT includes
#include <QDebug>
#include <QVector3D>
#include <QDateTime>
#include <QQuaternion>
#include <QtMath>
#include <QtCore>

//CSPICE
#include "resource/cspice/include/SpiceUsr.h"

class Vector3D {
public:
    Vector3D(const double &i_x, const double &i_y, const double &i_z)
        : x(i_x),
          y(i_y),
          z(i_z)
    {}

    double x = 0;
    double y = 0;
    double z = 0;
};



class Space_model
{
public:
    Space_model();
    Vector3D getSunEphemeris(const QDateTime &i_date);
    QQuaternion getEarthRotation(const QDateTime &i_date);

private:
    void getJ2000seconds(const QDateTime &i_date, SpiceDouble &i_et);
};

#endif // EARTH_H
