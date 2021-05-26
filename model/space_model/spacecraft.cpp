#include "spacecraft.h"

/*!
 * \brief Spacecraft::Spacecraft default constructor
 */
Spacecraft::Spacecraft() :
    elevations("elevation", "degree"),
    passes("pass_duration", "s"),
    maxElevations("max_elevation", "deg"),
    illuminations("illuminated", "boolean"),
    positionEcefX("SC_ECEF_x", "km"),
    positionEcefY("SC_ECEF_y", "km"),
    positionEcefZ("SC_ECEF_z", "km")
{
}

/*!
 * \brief Spacecraft::getTheoreticalPosition returns the position in ECI at dT in s. Won't change
 * the inner state of spacecraft.
 * \param seconds
 * \return
 */
QVector3D Spacecraft::predictPosition(const double &i_seconds)
{
    SpiceDouble state[6];
    spkezr_c ( sat_spice_id, etSpacecraft + i_seconds, "J2000", "NONE", "EARTH", state,
                     &lt );
    return QVector3D(state[0],state[1],state[2]);
}

/*!
 * \brief Spacecraft::getTheoreticalPosition returns the position in ECI at dT in s. Won't change
 * the inner state of spacecraft.
 * \param seconds
 * \param i_datetime
 * \return
 */
QVector3D Spacecraft::predictPosition(const QDateTime &i_datetime)
{
    SpiceDouble state[6];
    SpiceDouble et;
    getJ2000seconds(i_datetime, et);
    spkezr_c ( sat_spice_id, et, "J2000", "NONE", "EARTH", state, &lt );
    return QVector3D(state[0],state[1],state[2]);
}

/*!
 * \brief calcNext position of S/C
 * \param i_Sseconds in seconds
 * \return Spacecraft report containing DateTime dt, CoordTopocentric topp, CoordGeodetic geo
 */
void Spacecraft::calcNextMarker(const double &i_seconds) {
    etMarker += i_seconds;
    spkezr_c ( sat_spice_id, etMarker, "J2000", "NONE", "EARTH", stateMarker,
                     &lt );
}

/*!
 * \brief Spacecraft::calc_date calc position of S/C @ datetime
 * \param i_datetime
 */
void Spacecraft::calcSpacecraftDate(const QDateTime &i_datetime)
{
    getJ2000seconds(i_datetime, etSpacecraft);
    //et_spacecraft -= 2212;
    etMarker = etSpacecraft;
    spkezr_c ( sat_spice_id, etSpacecraft, "J2000", "NONE", "EARTH", stateSpacecraft,
                     &lt );

    double yaw = (etSpacecraft-etInitial)*yawRate;
    double pitch = (etSpacecraft-etInitial)*pitchRate;
    double roll = (etSpacecraft-etInitial)*rollRate;

    //order of rotation
    //Yaw - x
    //Pitch - z
    //Roll - y

    oriantation = QQuaternion(quatW,quatX,quatY,quatZ).normalized().inverted()
                    * QQuaternion::fromEulerAngles(yaw,0,0).inverted()
                    * QQuaternion::fromEulerAngles(0,0,pitch).inverted()
                    * QQuaternion::fromEulerAngles(0,roll,0).inverted();

    //qDebug() << state_spacecraft[0] << " " << state_spacecraft[1] << " " << state_spacecraft[2] << " " ;
}


/*!
 * \brief Spacecraft::predictPasses used to predict passes of the SC above the observer (Additionally it calculates illumination and position
 * in ECEF)
 * \param start_date
 * \param end_date
 */
void Spacecraft::predictPasses()
{
    elevations.clear();
    passes.clear();
    illuminations.clear();
    positionEcefX.clear();
    positionEcefY.clear();
    positionEcefZ.clear();
    maxElevations.clear();

    progressBar.setMessage("predict passes");


    //latrec_c(EARTH_RADIUS, obs_lon,obs_lat, position_obs);
    obsLon = obsLon * M_PI /180;
    obsLat = obsLat * M_PI /180;

    position_obs[0] = EARTH_RADIUS*cos(obsLon)*cos(obsLat);
    position_obs[1] = EARTH_RADIUS*sin(obsLon)*cos(obsLat);
    position_obs[2] = EARTH_RADIUS*sin(obsLat);

    SpiceDouble et_start;
    SpiceDouble et_end;
    getJ2000seconds(passesStart, et_start);
    getJ2000seconds(passesEnd, et_end);
    SpiceDouble state[6];

    double time = 0;

    bool pass = false;
    QDateTime pass_time;
    double max_elevation;
    QDateTime max_elevation_date;

    while(et_start + time < et_end) {
        spkcpo_c(sat_spice_id, et_start + time, "IAU_EARTH" , "OBSERVER" , "NONE", position_obs , "EARTH", "IAU_EARTH" , state , &lt);

        double dot = state[0]*position_obs[0] + state[1]*position_obs[1] + state[2]*position_obs[2];
        double square1 = state[0]*state[0] + state[1]*state[1] + state[2]*state[2];
        double square2 = position_obs[0]*position_obs[0] + position_obs[1]*position_obs[1] + position_obs[2]*position_obs[2];
        double angle = 90 - acos(dot/sqrt(square1 * square2)) / M_PI * 180.0 ;

        elevations.append(DatedValue(angle,passesStart.addSecs(time),-1));

        //predict illumination for same dataset
        if(predictIlluminated(passesStart.addSecs(time))) {
            illuminations.append(DatedValue(obsMinElevation,passesStart.addSecs(time),-1));
        } else {
            illuminations.append(DatedValue(0,passesStart.addSecs(time),-1));
        }

        //predict ECEF position for same dataset
        QVector3D sc_ecef = predictPosition(passesStart.addSecs(time));
        positionEcefX.append(DatedValue(sc_ecef.x(), passesStart.addSecs(time), -1));
        positionEcefY.append(DatedValue(sc_ecef.y(), passesStart.addSecs(time), -1));
        positionEcefZ.append(DatedValue(sc_ecef.z(), passesStart.addSecs(time), -1));

        //update progressbar
        progressBar.setStatus(time,et_end-et_start);
        progressBar.update();

        if(!pass && angle > obsMinElevation) {
            pass = true;
            pass_time = passesStart.addSecs(time);
        }

        if(pass && angle > max_elevation) {
            max_elevation = angle;
            max_elevation_date = passesStart.addSecs(time);
        }

        if(pass && angle < obsMinElevation) {
            pass = false;

            maxElevations.append(DatedValue(max_elevation, max_elevation_date, -1));
            max_elevation = -180;

            passes.append( DatedValue( pass_time.secsTo(passesStart.addSecs(time)), pass_time, -1) );
        }


        if(angle - obsMinElevation >= 0 ) {
            time++;
        }else {
            time = time + 1 + pow(-(angle - obsMinElevation), 1.5);
        }
    }

    progressBar.setStatus(1,1);
    progressBar.update();
    progressBar.clear();

    qDebug() << "Calculateed " << elevations.size() << " data points. With " << passes.size() << " passes above minimum elevation.";
}


/*!
 * \brief Spacecraft::predictllumination predicts if sc is illuminated at dt or if it is in shadow
 * \param dt
 * \return bool is illuminated
 */
bool Spacecraft::predictIlluminated(const QDateTime &dt)
{
    SpiceDouble et;
    getJ2000seconds(dt, et);
    SpiceDouble state[6];

    spkezr_c ( sat_spice_id, et, "J2000", "NONE", "EARTH", state, &lt );
    QVector3D sc_vec(state[0],state[1],state[2]);

    spkezr_c ( "SUN", et, "J2000", "NONE", "EARTH", state, &lt );
    QVector3D sun_vec(state[0],state[1],state[2]);

    sun_vec.normalize();
    double t = QVector3D::dotProduct(sc_vec, sun_vec);
    QVector3D P = sun_vec * t;
    double distance = (sc_vec-P).length();

    bool illu = true;
    if(t < 0 && distance < EARTH_RADIUS)  illu = false;

    return illu;
}

/*!
 * \brief SimController::writeCSV writes elevation, illumination and position calculated by the predict passes
 * routine into an .csv file
 */
void Spacecraft::writeCsvRaw() {
    QList<DatedValueList*> dataLists;
    QList<QString> names;

    names.append(positionEcefX.getName() + "_" + positionEcefX.getUnit());
    names.append(positionEcefY.getName() + "_" + positionEcefY.getUnit());
    names.append(positionEcefZ.getName() + "_" + positionEcefZ.getUnit());
    names.append(elevations.getName() + "_" + elevations.getUnit());
    names.append(illuminations.getName() + "_" + illuminations.getUnit());

    dataLists.append(&positionEcefX);
    dataLists.append(&positionEcefY);
    dataLists.append(&positionEcefZ);
    dataLists.append(&elevations);
    dataLists.append(&illuminations);


    QFile file(CSV_PATH_RAW);
    file.open(QIODevice::WriteOnly);

    QTextStream stream(&file);

    stream << "t" << ",";
    for(QString name : names) {
        stream << name << ",";
    }

    stream << "\n";
    long l = dataLists.at(0)->length();

    for(int i = 0; i < l; i++) {

        //write date
        stream << dataLists.at(0)->at(i).date.toString("yyyy.MM.dd hh:mm:ss") << ",";

        //write data
        for(int k = 0; k < names.length(); k++) {
            stream << dataLists.at(k)->at(i).value << ",";
        }
        stream << "\n";
    }

    file.close();
}

/*!
 * \brief Spacecraft::writeCSV_passes writes the start time of the passes and their duration
 * into an .csv file
 */
void Spacecraft::writeCsvPasses()
{
    QList<QString> names;

    names.append(passes.getName() + "_" + passes.getUnit());
    names.append(maxElevations.getName() + "_" + maxElevations.getUnit());

    QFile file(CSV_PATH_PASSES);
    file.open(QIODevice::WriteOnly);

    QTextStream stream(&file);

    stream << "start_date" << ",";
    stream << passes.getName() << "_" << passes.getUnit() << ",";
    stream << "max_elevation_date" << ",";
    stream << maxElevations.getName() << "_" << maxElevations.getUnit() << ",";

    stream << "\n";
    long l = passes.length();

    for(int i = 0; i < l; i++) {

        //write pass
        stream << passes.at(i).date.toString("yyyy.MM.dd hh:mm:ss") << ",";
        stream << passes.at(i).value << ",";

        //write elevation
        stream << maxElevations.at(i).date.toString("yyyy.MM.dd hh:mm:ss") << ",";
        stream << maxElevations.at(i).value << ",";

        stream << "\n";
    }

    file.close();
}



/*!
 * \brief Spacecraft::getPositionECI provides position vector of S/C in the ECI
 * \param inital if true it returns the initial value
 * \return x / km, y / km, z / km
 */
QVector3D Spacecraft::getPositionEci(const bool &i_spacecraft)
{
   if(i_spacecraft) return QVector3D(stateSpacecraft[0],stateSpacecraft[1],stateSpacecraft[2]);
   return QVector3D(stateMarker[0],stateMarker[1],stateMarker[2]);
}


/*!
 * \brief Spacecraft::getDate returns current date of S/C
 * \return QVector3D x: year; x: month; z; day
 */
QVector3D Spacecraft::getDate()
{
   //timout_c ( et+spd_c(), "YYYY-MM-DD HR:MN:SC.### ::RND", 32, utc );
    return QVector3D(0,0,0);
}

/*!
 * \brief Spacecraft::getTime returns current time of S/C
 * \return QVector3D x: hour; x: minute; z; second
 */
QVector3D Spacecraft::getTime()
{
    return QVector3D(0,0,0);
}


/*!
 * \brief Spacecraft::getObsPosition returns observer position
 * \return QVector3D x: latidude / degree; x: longitude / degree; z; altitude / km
 */
QVector3D Spacecraft::getObsPosition()
{
    return QVector3D(0,0,0);
}

/*!
 * \brief Spacecraft::eci_to_LVLH_rot get quaternion to translate from ECI to the LVLH coord system
 * \return
 */
QQuaternion Spacecraft::eciToLvlhRot()
{
    QVector3D pos = getPositionEci();
    QVector3D velo = getVelocityEci();
    QVector3D x = - pos.normalized();
    QVector3D z = QVector3D::crossProduct(-pos , velo).normalized();
    QVector3D y = QVector3D::crossProduct(z , x).normalized();

    return QQuaternion::fromAxes(x,y,z);
}

/*!
 * \brief Spacecraft::getVelocity provides the velocity vector in the ECI system, based on the central difference dT = 1s
 * \return
 */
QVector3D Spacecraft::getVelocityEci()
{
    return QVector3D(stateSpacecraft[3],stateSpacecraft[4],stateSpacecraft[5]);
}

/*!
 * \brief Spacecraft::getOriantation returns oriantation based on inner state
 * \return
 */
QQuaternion Spacecraft::getOrientation()
{
    return oriantation;
}

/*!
 * \brief Spacecraft::getJ2000seconds gets socend since j2000
 * \param date
 * \param et
 */
void Spacecraft::getJ2000seconds(const QDateTime &i_date, SpiceDouble &i_et)
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

/*!
 * \brief Spacecraft::reinit reinits the state of the spacecraft to new date. Is used when the active transmission is changed.
 * \param i_datetime
 * \param i_yaw in deg
 * \param i_pitch in deg
 * \param i_roll in deg
 * \param i_yaw_rate in deg/s
 * \param i_pitch_rate in deg/s
 * \param i_roll_rate in deg/s
 */
void Spacecraft::reinit(QDateTime i_datetime, double i_quat_w, double i_quat_x,
                        double i_quat_y , double i_quat_z,
                        double i_yaw_rate, double i_pitch_rate, double i_roll_rate)
{
    quatW = i_quat_w;
    quatX = i_quat_x;
    quatY = i_quat_y;
    quatZ = i_quat_z;
    yawRate = i_yaw_rate;
    pitchRate = i_pitch_rate;
    rollRate = i_roll_rate;

    getJ2000seconds(i_datetime, etInitial);
    calcSpacecraftDate(i_datetime);
}










