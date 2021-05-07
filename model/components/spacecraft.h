#ifndef TLE_H
#define TLE_H

//QT includes
#include <QDebug>
#include <QVector3D>
#include <QDateTime>
#include <QQuaternion>
#include <QtMath>
#include <QtCore>

//CSPICE
#include "resource/cspice/include/SpiceUsr.h"

//std include
#include <math.h>
#include <string.h>

//custom classes includes
#include <model/components/text_progressbar.h>
#include <model/components/dated_value.h>

#define sat_spice_id "-48"
#define EARTH_RADIUS 6371
#define CSV_PATH_RAW "output/spacecraft.csv"
#define CSV_PATH_PASSES "output/spacecraft_passes.csv"

/*!
 * \brief The Spacecraft class containes all information about one S/C and its observer
 */
class Spacecraft
{

    public:
        Spacecraft();

        //Variables
        const std::string QML_NAME = "Spacecraft";

        //Functions
        QVector3D predictPosition(double seconds);
        QVector3D predictPosition(QDateTime i_datetime);
        void calc_next_marker(double seconds);
        void calc_spacecraft_date(QDateTime i_datetime);
        void predictPasses();
        bool predictIlluminated(QDateTime dt);
        void writeCSV_raw();
        void writeCSV_passes();

        void reinit(QDateTime i_datetime, double i_quat_w, double i_quat_x,
                    double i_quat_y , double i_quat_z,
                    double i_yaw_rate, double i_pitch_rate, double i_roll_rate);

        QVector3D getPositionECI(bool spacecraft = true);
        QVector3D getDate();
        QVector3D getTime();
        QVector3D getObsPosition();
        QQuaternion eci_to_LVLH_rot();
        QVector3D getVelocityECI();
        QQuaternion getOrientation();

        DatedValueList elevations;
        DatedValueList passes;
        DatedValueList max_elevations;
        DatedValueList illuminations;
        DatedValueList positionECEF_x;
        DatedValueList positionECEF_y;
        DatedValueList positionECEF_z;

        //data for passes
        QDateTime passes_start;
        QDateTime passes_end;
        double obs_lat;
        double obs_lon;
        double obs_min_elevation;
        TextProgressBar progressBar;

    private:
        SpiceDouble         et_initial;
        SpiceDouble         et_spacecraft;
        SpiceDouble         et_marker;
        SpiceDouble         state_spacecraft[6];
        SpiceDouble         state_marker[6];
        SpiceDouble         position_obs[3];
        SpiceDouble         epoch;
        SpiceDouble         lt;
        QQuaternion         oriantation;

        //oriantation ind deg, deg/s
        double quat_w = 0;
        double quat_x = 0;
        double quat_y = 0;
        double quat_z = 0;

        double yaw_rate = 0;
        double pitch_rate = 0;
        double roll_rate = 0;



        void getJ2000seconds(QDateTime date, SpiceDouble &et);


};

#endif // TLE_H
