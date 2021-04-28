#include "spacecraft.h"

/*!
 * \brief Spacecraft::Spacecraft default constructor
 */
Spacecraft::Spacecraft() :
    elevations("elevation", "degree"),
    passes("pass_duration", "s"),
    illuminations("illuminated", "boolean"),
    positionECEF_x("SC_ECEF_x", "km"),
    positionECEF_y("SC_ECEF_y", "km"),
    positionECEF_z("SC_ECEF_z", "km")
{
}

/*!
 * \brief Spacecraft::getTheoreticalPosition returns the position in ECI at dT in s. Won't change
 * the inner state of spacecraft.
 * \param seconds
 * \return
 */
QVector3D Spacecraft::predictPosition(double seconds)
{
    SpiceDouble state[6];
    spkezr_c ( sat_spice_id, et_spacecraft + seconds, "J2000", "NONE", "EARTH", state,
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
QVector3D Spacecraft::predictPosition(QDateTime i_datetime)
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
void Spacecraft::calc_next_marker(double seconds) {
    et_marker += seconds;
    spkezr_c ( sat_spice_id, et_marker, "J2000", "NONE", "EARTH", state_marker,
                     &lt );
}

/*!
 * \brief Spacecraft::calc_date calc position of S/C @ datetime
 * \param i_datetime
 */
void Spacecraft::calc_spacecraft_date(QDateTime i_datetime)
{
    getJ2000seconds(i_datetime, et_spacecraft);
    //et_spacecraft -= 2212;
    et_marker = et_spacecraft;
    spkezr_c ( sat_spice_id, et_spacecraft, "J2000", "NONE", "EARTH", state_spacecraft,
                     &lt );

    double yaw = (et_spacecraft-et_initial)*yaw_rate;
    double pitch = (et_spacecraft-et_initial)*pitch_rate;
    double roll = (et_spacecraft-et_initial)*roll_rate;

    //order of rotation
    //Yaw - x
    //Pitch - z
    //Roll - y

    oriantation = QQuaternion(quat_w,quat_x,quat_y,quat_z).normalized().inverted()
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
    positionECEF_x.clear();
    positionECEF_y.clear();
    positionECEF_z.clear();

    progressBar.setMessage("predict passes");


    //latrec_c(EARTH_RADIUS, obs_lon,obs_lat, position_obs);
    obs_lon = obs_lon * M_PI /180;
    obs_lat = obs_lat * M_PI /180;

    position_obs[0] = EARTH_RADIUS*cos(obs_lon)*cos(obs_lat);
    position_obs[1] = EARTH_RADIUS*sin(obs_lon)*cos(obs_lat);
    position_obs[2] = EARTH_RADIUS*sin(obs_lat);

    SpiceDouble et_start;
    SpiceDouble et_end;
    getJ2000seconds(passes_start, et_start);
    getJ2000seconds(passes_end, et_end);
    SpiceDouble state[6];

    double time = 0;

    bool pass = false;
    QDateTime pass_time;

    while(et_start + time < et_end) {
        spkcpo_c(sat_spice_id, et_start + time, "IAU_EARTH" , "OBSERVER" , "NONE", position_obs , "EARTH", "IAU_EARTH" , state , &lt);

        double dot = state[0]*position_obs[0] + state[1]*position_obs[1] + state[2]*position_obs[2];
        double square1 = state[0]*state[0] + state[1]*state[1] + state[2]*state[2];
        double square2 = position_obs[0]*position_obs[0] + position_obs[1]*position_obs[1] + position_obs[2]*position_obs[2];
        double angle = 90 - acos(dot/sqrt(square1 * square2)) / M_PI * 180.0 ;

        elevations.append(DatedValue(angle,passes_start.addSecs(time),-1));

        //predict illumination for same dataset
        if(predictIlluminated(passes_start.addSecs(time))) {
            illuminations.append(DatedValue(obs_min_elevation,passes_start.addSecs(time),-1));
        } else {
            illuminations.append(DatedValue(0,passes_start.addSecs(time),-1));
        }

        //predict ECEF position for same dataset
        QVector3D sc_ecef = predictPosition(passes_start.addSecs(time));
        positionECEF_x.append(DatedValue(sc_ecef.x(), passes_start.addSecs(time), -1));
        positionECEF_y.append(DatedValue(sc_ecef.y(), passes_start.addSecs(time), -1));
        positionECEF_z.append(DatedValue(sc_ecef.z(), passes_start.addSecs(time), -1));

        //update progressbar
        progressBar.setStatus(time,et_end-et_start);
        progressBar.update();

        if(!pass && angle > obs_min_elevation) {
            pass = true;
            pass_time = passes_start.addSecs(time);
        }

        if(pass && angle < obs_min_elevation) {
            pass = false;
            passes.append( DatedValue( pass_time.secsTo(passes_start.addSecs(time)), pass_time, -1) );
        }

        if(angle - obs_min_elevation >= 0 ) {
            time++;
        }else {
            time = time + 1 + pow(-(angle - obs_min_elevation), 1.5);
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
bool Spacecraft::predictIlluminated(QDateTime dt)
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
void Spacecraft::writeCSV_raw() {
    QList<DatedValueList*> dataLists;
    QList<QString> names;

    names.append(positionECEF_x.getName() + "_" + positionECEF_x.getUnit());
    names.append(positionECEF_y.getName() + "_" + positionECEF_y.getUnit());
    names.append(positionECEF_z.getName() + "_" + positionECEF_z.getUnit());
    names.append(elevations.getName() + "_" + elevations.getUnit());
    names.append(illuminations.getName() + "_" + illuminations.getUnit());

    dataLists.append(&positionECEF_x);
    dataLists.append(&positionECEF_y);
    dataLists.append(&positionECEF_z);
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
void Spacecraft::writeCSV_passes()
{
    QList<DatedValueList*> dataLists;
    QList<QString> names;

    names.append(passes.getName() + "_" + passes.getUnit());
    dataLists.append(&passes);

    QFile file(CSV_PATH_PASSES);
    file.open(QIODevice::WriteOnly);

    QTextStream stream(&file);

    stream << "start_date" << ",";
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
 * \brief Spacecraft::getPositionECI provides position vector of S/C in the ECI
 * \param inital if true it returns the initial value
 * \return x / km, y / km, z / km
 */
QVector3D Spacecraft::getPositionECI(bool spacecraft)
{
   if(spacecraft) return QVector3D(state_spacecraft[0],state_spacecraft[1],state_spacecraft[2]);
   return QVector3D(state_marker[0],state_marker[1],state_marker[2]);
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
QQuaternion Spacecraft::eci_to_LVLH_rot()
{
    QVector3D pos = getPositionECI();
    QVector3D velo = getVelocityECI();
    QVector3D x = - pos.normalized();
    QVector3D z = QVector3D::crossProduct(-pos , velo).normalized();
    QVector3D y = QVector3D::crossProduct(z , x).normalized();

    return QQuaternion::fromAxes(x,y,z);
}

/*!
 * \brief Spacecraft::getVelocity provides the velocity vector in the ECI system, based on the central difference dT = 1s
 * \return
 */
QVector3D Spacecraft::getVelocityECI()
{
    return QVector3D(state_spacecraft[3],state_spacecraft[4],state_spacecraft[5]);
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
void Spacecraft::getJ2000seconds(QDateTime date, SpiceDouble &et)
{
    std::string s = "" + std::to_string(date.date().year());
    s += " ";
    s += std::to_string(date.date().month());
    s += " ";
    s += std::to_string(date.date().day());
    s += " ";

    s += std::to_string(date.time().hour());
    s += ":";
    s += std::to_string(date.time().minute());
    s += ":";
    s += std::to_string(date.time().second());
    //s += " UTC";

    SpiceChar time [41];

    strcpy_s(time, s.c_str());

    str2et_c(time, &et);
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
    quat_w = i_quat_w;
    quat_x = i_quat_x;
    quat_y = i_quat_y;
    quat_z = i_quat_z;
    yaw_rate = i_yaw_rate;
    pitch_rate = i_pitch_rate;
    roll_rate = i_roll_rate;

    getJ2000seconds(i_datetime, et_initial);
    calc_spacecraft_date(i_datetime);
}










