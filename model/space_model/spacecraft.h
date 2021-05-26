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
        QVector3D predictPosition(const double &i_seconds);
        QVector3D predictPosition(const QDateTime &i_datetime);
        void calcNextMarker(const double &i_seconds);
        void calcSpacecraftDate(const QDateTime &i_datetime);
        void predictPasses();
        bool predictIlluminated(const QDateTime &i_dt);
        void writeCsvRaw();
        void writeCsvPasses();

        void reinit(QDateTime i_datetime, double i_quat_w, double i_quat_x,
                    double i_quat_y , double i_quat_z,
                    double i_yaw_rate, double i_pitch_rate, double i_roll_rate);

        QVector3D getPositionEci(const bool &i_spacecraft = true);
        QVector3D getDate();
        QVector3D getTime();
        QVector3D getObsPosition();
        QQuaternion eciToLvlhRot();
        QVector3D getVelocityEci();
        QQuaternion getOrientation();

        DatedValueList elevations;
        DatedValueList passes;
        DatedValueList maxElevations;
        DatedValueList illuminations;
        DatedValueList positionEcefX;
        DatedValueList positionEcefY;
        DatedValueList positionEcefZ;

        //data for passes
        QDateTime passesStart;
        QDateTime passesEnd;
        double obsLat;
        double obsLon;
        double obsMinElevation;
        TextProgressBar progressBar;

    private:
        SpiceDouble         etInitial;
        SpiceDouble         etSpacecraft;
        SpiceDouble         etMarker;
        SpiceDouble         stateSpacecraft[6];
        SpiceDouble         stateMarker[6];
        SpiceDouble         position_obs[3];
        SpiceDouble         epoch;
        SpiceDouble         lt;
        QQuaternion         oriantation;

        //oriantation ind deg, deg/s
        double quatW = 0;
        double quatX = 0;
        double quatY = 0;
        double quatZ = 0;

        double yawRate = 0;
        double pitchRate = 0;
        double rollRate = 0;


        void getJ2000seconds(const QDateTime &i_date, SpiceDouble &i_et);


};

#endif // TLE_H
