#ifndef MODEL_H
#define MODEL_H

// Qt includes
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QtCore>
#include <QRegularExpression>
#include <QtCharts/QAbstractSeries>
#include <QtCharts/QAbstractAxis>

//CSPICE
#include "resource/cspice/include/SpiceUsr.h"
#define META_KERNAL "kernels/meta.ker"


// custom includes
#include <model/components/dated_value.h>
#include <model/components/dated_observation.h>
#include <model/components/spacecraft.h>
#include <model/satnogs_loader.h>
#include <model/components/ICRS_to_ECI.h>
#include <model/components/mkspkCon.h>
#include <libs/_qml.h>



#define DATA_PATH "download"
#define DECODED_TAG "decoded_"
#define OBSERVATION_TAG "observation_"
#define WATERFALL_TAG "waterfall_"


class Model : public QObject
{
    Q_OBJECT

public:
    Model();

    //Var
    SatNOGS_loader importer;


    //Satnogs Settings data
    QString norad_id;
    QString start_datetime;
    QString end_datetime;
    QString satnogs_status;
    QDateTime j2000;

    /*!
     * \brief dataLists contains all Data in multiple lists, each is labled. The different list entries represent the observations.
     */
    QList<DatedValueList*> dataLists;
    /*!
     * \brief observationList contains the observation information for each observation
     */
    DatedObservationList observationList;

    /*!
     * \brief spacecraft contains all spacecraft related infos and methods
     */
    Spacecraft spacecraft;

    //Methods
    bool loadDecodedData(QString path = DATA_PATH, QString tag = DECODED_TAG);
    bool loadObservationData(QString path = DATA_PATH, QString tag = OBSERVATION_TAG, QString tag_watertfall = WATERFALL_TAG);
    double earthAngleSinceJ2000(QDateTime date);
    Vector3D getSunEphermis(QDateTime date);
    QQuaternion getEarthRotation(QDateTime date);
    QDateTime getDateTimeFromString(QString string);
    QDateTime getDateTimeFromString2(QString string);

private:
    QJsonObject loadJson(QString file);
    int getIDFromString(QString string);
    bool decodedFinished = false;
    bool observationFinished = false;
    void getJ2000seconds(QDateTime date, SpiceDouble &et);
    void reloadMkspk();


signals:
    void dataLoaded();
    void noDataLoaded();

public slots:
   void startLoadingData();
};

#endif // DATAMODEL_H
