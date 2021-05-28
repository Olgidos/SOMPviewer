#include "space_model.h"

SpaceModel::SpaceModel()
{

}


/*!
 * \brief Earth::getEphermisForDate provides ephermeris coordinates for date in the J2000 system
 * \param date
 * \return
 */
Vector3D SpaceModel::getSunEphemeris(const QDateTime &i_date)
{
    SpiceDouble et;
    getJ2000seconds(i_date, et);
    SpiceDouble   state[6];
    SpiceDouble   lt;
    spkezr_c ( "SUN", et, "J2000", "NONE", "EARTH", state,
                     &lt );
    return Vector3D(state[0],state[1],state[2]);
}

/*!
 * \brief Earth::getEarthRotation Returns quaternion for earth rotation based on SPICE
 * \param date
 * \return
 */
QQuaternion SpaceModel::getEarthRotation(const QDateTime &i_date)
{
    SpiceDouble et;
    getJ2000seconds(i_date, et);
    SpiceDouble mat[3][3];
    pxform_c ( "J2000", "ITRF93", et, mat );
    QVector3D x = QVector3D(mat[0][0],mat[0][1],mat[0][2]);
    QVector3D y = QVector3D(mat[1][0],mat[1][1],mat[1][2]);
    QVector3D z = QVector3D(mat[2][0],mat[2][1],mat[2][2]);
    return QQuaternion::fromAxes(x,y,z);
}


/*!
 * \brief Earth::getJ2000seconds returns spacetime in s for a specific date
 * \param date
 * \param et
 */
void SpaceModel::getJ2000seconds(const QDateTime &i_date, SpiceDouble &i_et)
{
    std::string s = "" + std::to_string(i_date.date().year());
    s += " ";
    s += std::to_string(i_date.date().month());
    s += " ";
    s += std::to_string(i_date.date().day());
    s += " ";

    s += std::to_string(i_date.time().hour());
    s += ":";
    s += std::to_string(i_date.time().minute());
    s += ":";
    s += std::to_string(i_date.time().second());
    //s += " UTC";

    SpiceChar time [41];

    strcpy_s(time, s.c_str());

    str2et_c(time, &i_et);
}
