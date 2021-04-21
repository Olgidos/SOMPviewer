#ifndef SUN_MODEL_H
#define SUN_MODEL_H

#include <math.h>
#include <QtCore>

#define a_0 1.00000264      //AU
#define adt 0.00000562      //AU/century
#define e_0 0.01671123      //rad
#define edt -0.00004392     //rad/century
#define I_0 -0.00001531     //deg
#define Idt -0.01294668     //deg/century
#define L_0 100.46457166    //deg
#define Ldt 35999.37244981  //deg/century
#define w_0 102.93768193    //deg
#define wdt 0.32327364      //deg/century
#define o_0 0.0             //deg
#define odt 0.0             //deg/century
#define tolerance 0.000001

class Vector3D {
public:

    Vector3D(double i_x, double i_y, double i_z)
        : x(i_x),
          y(i_y),
          z(i_z)
    {}

    double x = 0;
    double y = 0;
    double z = 0;
};


/*!
 * \brief calculateEarthPosition calculates Earth position according to JPL's Keplerian approximation
 * https://ssd.jpl.nasa.gov/txt/aprx_pos_planets.pdf
 * \param day
 * \param month
 * \param year
 */
static Vector3D calculateEarthPosition(int day, int month, int year) {
    QDate dt(year, month, day);

    //1.
    double T = (dt.toJulianDay() - 2451545.0 ) / 36525.0;
    double a = a_0 + adt*T; //AU
    double e = e_0 + edt*T; //rad
    double I = I_0 + Idt*T; //deg
    double L = L_0 + Ldt*T; //deg
    double w_ = w_0 + wdt*T;//deg
    double o = o_0 + odt*T; //deg

    //2.
    double w = w_ - o; //deg
    double M = L - w_; //deg
    M = fmod(M, 360);// - 180;

    //3
    double e_ = 180.0/ M_PI * e; // deg
    double dE = 1.0;
    double E_n = M + e_*sin(M * M_PI/180.0); //deg
    while(dE > tolerance || dE < -tolerance) {
        double dM = M - (E_n - e_ * sin(E_n * M_PI/180.0));
        dE = dM / (1 - e * cos(E_n * M_PI/180.0) );
        E_n += dE;
    }

    double E = E_n;

    //4
    double x_ = a * (cos(E* M_PI/180.0) - e);
    double y_ = a * sqrt(1-e*e) * sin(E* M_PI/180.0);
    //double z_ = 0;

    //5
    w *= M_PI/180.0;
    o *= M_PI/180.0;
    I *= M_PI/180.0;

    double x = (cos(w) * cos(o) - sin(w) * sin(o) * cos(I)) * x_
                +
              (-sin(w) * cos(o) - cos(w) * sin(o) * cos(I) ) * y_;

    double y = (cos(w) * sin(o) + sin(w) * cos(o) * cos(I) ) * x_
                +
              (-sin(w) * sin(o) + cos(w) * cos(o) * cos(I)) * y_;
    double z = ( sin(w) * sin(I) ) * x_ + ( cos(w) * sin(I) ) * y_;

//    qDebug() << ": " << QString::fromStdString(dt->ToString());
//    qDebug() << "JD: " << dt->ToJulian();
//    qDebug() << "x_: " << x;
//    qDebug() << "y_: " << y;
//    qDebug() << "z_: " << z;

//    qDebug() << "EC_: " << e;
//    qDebug() << "IN_: " << I;
//    qDebug() << "MA_: " << M;
//    qDebug() << "QM_: " << o;
//    qDebug() << "W_: " << w;
//    qDebug() << "TA_: " << E;
//    qDebug() << "A_: " << a;
//    qDebug() << "";

    return Vector3D(x,y,z);
}

#endif // SUN_MODEL_H
