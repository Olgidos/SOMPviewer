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
#include <model/space_model/spacecraft.h>
#include <model/space_model/space_model.h>
#include <model/data_client/satnogs_loader.h>
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
    SatnogsLoader importer;
    Spacecraft spacecraft;
    Space_model spaceModel;

    //Satnogs Settings data
    QString noradId;
    QString startDatetime;
    QString endDatetime;
    QString satnogsStatus;
    QDateTime j2000;

    /*!
     * \brief dataLists contains all Data in multiple lists, each is labled. The different list entries represent the observations.
     */
    QList<DatedValueList*> dataLists;
    /*!
     * \brief observationList contains the observation information for each observation
     */
    DatedObservationList observationList;


    //Methods
    bool loadDecodedData(const QString &i_path = DATA_PATH, const QString &i_tag = DECODED_TAG);
    bool loadObservationData( const QString &i_path = DATA_PATH, const QString &i_tag = OBSERVATION_TAG,
                             const QString &i_tagWatertfall = WATERFALL_TAG);

    QDateTime getDateTimeFromString(const QString &i_string);
    QDateTime getDateTimeFromString2(const QString &i_string);

private:
    QJsonObject loadJson(const QString &i_file);
    int getIDFromString(const QString &i_string);
    void reloadMkspk();

signals:
    void dataLoaded();
    void noDataLoaded();

public slots:
   void startLoadingData();
};



#endif // DATAMODEL_H
