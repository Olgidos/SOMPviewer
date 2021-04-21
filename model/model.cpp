#include "model.h"

#include <stdio.h>
#include <math.h>

Model::Model() :
    j2000(QDate(2000,1,1),QTime(12,0,0), QTimeZone::utc())
{
    QObject::connect(&importer, SIGNAL(import_finished()), this, SLOT(startLoadingData()));
    QObject::connect(&importer, SIGNAL(import_failed()), this, SIGNAL(noDataLoaded()));
    furnsh_c (META_KERNAL);
}



/*!
 * \brief DataModel::jsonDataLoader Loads all .json data from path starting with the DECODED TAG.
 * \param path Path to data.
 * \param tag Name start Tag of .json data.
 */
bool Model::loadDecodedData(QString path, QString tag)
{

    //Read decoded .json Data
    QDir dir(path);
    dir.setNameFilters(QStringList() << (tag + "*"));
    dir.setFilter(QDir::Files);

    if(dir.entryList().size() == 0) {
        emit noDataLoaded();
        return false; //No data available
    }

    for(int i = 0; i < dir.entryList().size(); i++ )
    {
        QJsonObject obj = loadJson(QString(DATA_PATH) + "/" + dir.entryList().at(i));

        //Identify the date and time from the file name,
        QDateTime dateTime = getDateTimeFromString(dir.entryList().at(i));
        int id = getIDFromString(dir.entryList().at(i));

        //Adding values into DatedValueLists
        for(QString key : obj.keys()) {

            int first = key.indexOf('[', 0, Qt::CaseSensitive );
            int last = key.indexOf(']', 0, Qt::CaseSensitive );
            QStringRef name(&key, 0 , first - 1);
            QStringRef unit(&key, first + 1 , last - first - 1);

            bool available = false;
            for(DatedValueList *list : dataLists ) {
                if(list->getName() == name) {
                    list->push_back( DatedValue(obj[key].toDouble(), dateTime, id) );
                    available = true;
                }
            }
            //If no List for a key is available a new one is created
            if(!available) {
                dataLists.push_back( new DatedValueList(name.toString(), unit.toString()));
                dataLists.last()->push_back(DatedValue(obj[key].toDouble(), dateTime, id));
            }
        }
    }

    //Sort Value list for date
    for(DatedValueList *list : dataLists) {
        list->sort();
    }

    qInfo() << "Model: decoded data imported!" << dataLists[0]->length() << " Data rows";

    decodedFinished = true;
    //if(observationFinished) emit dataLoaded();
    return true;
}

bool Model::loadObservationData(QString path, QString tag, QString tag_watertfall)
{
    //Read Observation file
    QDir dir_obs(path);
    dir_obs.setNameFilters(QStringList() << (tag + "*"));
    dir_obs.setFilter(QDir::Files);

    if(dir_obs.entryList().size() == 0) {
        qWarning() << "No observations available. Aborting";
        emit noDataLoaded();
        return false; //No data available
    }


    for(int i = 0; i < dir_obs.entryList().size(); i++ )
    {
        QJsonObject obj = loadJson(QString(DATA_PATH) + "/" + dir_obs.entryList().at(i));

        //Identify the date and time from the file name,
        QDateTime start = getDateTimeFromString2(obj["start"].toString());

        observationList.push_back( Dated_observation(obj["tle1"].toString(), obj["tle2"].toString(), start) );

        norad_id = QString::number(obj["norad_cat_id"].toInt());
        observationList.last().end = getDateTimeFromString2(obj["end"].toString());
        observationList.last().max_altitude = obj["max_altitude"].toDouble();
        observationList.last().rise_azimuth = obj["rise_azimuth"].toDouble();
        observationList.last().set_azimuth = obj["set_azimuth"].toDouble();
        observationList.last().station_lat = obj["station_lat"].toDouble();
        observationList.last().station_lng = obj["station_lng"].toDouble();
        observationList.last().station_name = obj["station_name"].toString();
        observationList.last().status = obj["status"].toString();
        observationList.last().tle0 = obj["tle0"].toString();
        observationList.last().id = obj["id"].toInt();
        observationList.last().transmitter_description = obj["transmitter_description"].toString();

        QDir dir_waterfall(path);
        dir_waterfall.setNameFilters(QStringList() << (tag_watertfall + QString::number(obj["id"].toInt()) + "*"));
        dir_waterfall.setFilter(QDir::Files);

       if(dir_waterfall.entryList().size() == 1) {
            //observationHistory.last().waterfall = QImage( path + "/" + dir_waterfall.entryList().first() );
           observationList.last().waterfall = "" + path + "/" + dir_waterfall.entryList().first();
        }
        else {
            qWarning() << "No waterfall available for observation " << obj["id"].toInt();
        }
    }


    observationList.sort();

    if(observationList.length() != 0 ) qInfo() << "Model: observation data imported! " << observationList.length() << " Data rows";
    else qInfo() << "Model: No data was imported! ";

    observationFinished = true;
    //if(decodedFinished) emit dataLoaded();
    return true;
}


/*!
 * \brief Model::earthAngleSinceJ2000 returns the angle the earth rotated around its z axis since J2000
 * \param date
 * \return angle in degree
 */
double Model::earthAngleSinceJ2000(QDateTime date)
{

    qint64 secSinceJ2000 = j2000.secsTo(date);
    return secSinceJ2000 * 0.004178074132;
}

/*!
 * \brief Model::getEphermisForDate provides ephermeris coordinates for date in the J2000 system
 * \param date
 * \return
 */
Vector3D Model::getSunEphermis(QDateTime date)
{
    SpiceDouble et;
    getJ2000seconds(date, et);
    SpiceDouble   state[6];
    SpiceDouble   lt;
    spkezr_c ( "SUN", et, "J2000", "NONE", "EARTH", state,
                     &lt );
    return Vector3D(state[0],state[1],state[2]);
}

/*!
 * \brief Model::getEarthRotation Returns quaternion for earth rotation based on SPICE
 * \param date
 * \return
 */
QQuaternion Model::getEarthRotation(QDateTime date)
{
    SpiceDouble et;
    getJ2000seconds(date, et);
    SpiceDouble mat[3][3];
    pxform_c ( "J2000", "IAU_EARTH", et, mat );
    QVector3D x = QVector3D(mat[0][0],mat[0][1],mat[0][2]);
    QVector3D y = QVector3D(mat[1][0],mat[1][1],mat[1][2]);
    QVector3D z = QVector3D(mat[2][0],mat[2][1],mat[2][2]);
    return QQuaternion::fromAxes(x,y,z);
}

/*!
 * \brief Model::getDateTimeFromString used to generate time from data name
 * \param string _YYYY-mm-ddThh-mm-ss
 * \return
 */
QDateTime Model::getDateTimeFromString(QString string) {
    int n = 0;
    QRegExp regex("_");
    n =  string.indexOf(regex , n);
    n += 1;
    n =  string.indexOf(regex , n);
    n += 1;
    QStringRef str_year(&string, n , 4);
    int year = str_year.toInt();

    regex.setPattern("-");
    n =  string.indexOf(regex , n);
    n += 1;
    QStringRef str_month(&string, n , 2);
    int month = str_month.toInt();

    regex.setPattern("-");
    n =  string.indexOf(regex , n);
    n += 1;
    QStringRef str_day(&string, n , 2);
    int day = str_day.toInt();

    regex.setPattern("T");
    n =  string.indexOf(regex , n);
    n += 1;
    QStringRef str_hour(&string, n , 2);
    int hour = str_hour.toInt();

    regex.setPattern("-");
    n =  string.indexOf(regex , n);
    n += 1;
    QStringRef str_minute(&string, n , 2);
    int minute = str_minute.toInt();

    regex.setPattern("-");
    n =  string.indexOf(regex , n);
    n += 1;
    QStringRef str_second(&string, n , 2);
    int second = str_second.toInt();

    return QDateTime( QDate(year, month, day), QTime(hour, minute, second), QTimeZone::utc() );
}

/*!
 * \brief Model::getDateTimeFromString2 used to generate date from jsob entry
 * \param string YYYY-mm-ddThh:mm:ss
 * \return
 */
QDateTime Model::getDateTimeFromString2(QString string)
{
    int n = 0;
    QStringRef str_year(&string, n , 4);
    int year = str_year.toInt();

    QRegExp regex("-");
    n =  string.indexOf(regex , n);
    n += 1;
    QStringRef str_month(&string, n , 2);
    int month = str_month.toInt();

    regex.setPattern("-");
    n =  string.indexOf(regex , n);
    n += 1;
    QStringRef str_day(&string, n , 2);
    int day = str_day.toInt();

    regex.setPattern("T");
    n =  string.indexOf(regex , n);
    n += 1;
    QStringRef str_hour(&string, n , 2);
    int hour = str_hour.toInt();

    regex.setPattern(":");
    n =  string.indexOf(regex , n);
    n += 1;
    QStringRef str_minute(&string, n , 2);
    int minute = str_minute.toInt();

    regex.setPattern(":");
    n =  string.indexOf(regex , n);
    n += 1;
    QStringRef str_second(&string, n , 2);
    int second = str_second.toInt();

    return QDateTime( QDate(year, month, day), QTime(hour, minute, second), QTimeZone::utc() );
}


int Model::getIDFromString(QString string)
{
    QRegExp regex("(_|\\.)");
    int n = string.indexOf(regex , 0);
    n += 1;
    int m = string.indexOf(regex , n);
    m -= n;
    QStringRef id_ (&string, n , m);
    return id_.toInt();
}

void Model::getJ2000seconds(QDateTime date, SpiceDouble &et)
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
 * \brief Model::reloadMkspk calls mkspk setup file creating rountine, then collects all tle and writes
 * them to a input file. Afterwards the mkspk.exe is run and the spice kernel is reloaded
 */
void Model::reloadMkspk()
{
    if(observationList.size() == 0) return;

    //-48 sat position
    //399 earth id
    mkSetupFile(norad_id.toInt(),-48,399);

    QList<QString> tles;
    for(Dated_observation obs : observationList) {
        tles.append(obs.tle1);
        tles.append(obs.tle2);
    }

    mkInputFile(tles);
    runMkspk();
}





/*!
 * \brief DataModel::loadJson Loads a .json file and returns a QJsonObject
 * \param file Path/Name of file
 * \return QJsonObject
 */
QJsonObject Model::loadJson(QString filePath)
{
    QString val;
    QFile file;
    file.setFileName(filePath);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    val = file.readAll();
    file.close();

    //qWarning() << val;
    QJsonDocument doc = QJsonDocument::fromJson(val.toUtf8());
    return doc.object();
}

/*!
 * \brief DataModel::startLoadingData Qt slot to start the data importing process.
 */
void Model::startLoadingData()
{

    //Empty existing ValueLists
    for(DatedValueList *list : dataLists) {
        list->clear();
    }

    observationList.clear();

    //
    decodedFinished = false;
    observationFinished = false;
    loadObservationData();
    loadDecodedData();
    reloadMkspk();
    emit dataLoaded();
}


