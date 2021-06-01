#ifndef CONTROLLER_H
#define CONTROLLER_H

//std includes
#include <atomic>

//Qt includes
#include <QtConcurrent>
#include <QQmlContext>
#include <QtCharts/QLineSeries>
#include <QtCharts/QValueAxis>
#include <QtCharts/QDateTimeAxis>
#include <QtCharts/QAbstractSeries>

//custom classes includes
#include <model/model.h>
#include <libs/_qml.h>
#include <QMutexLocker>
#include <model/components/text_progressbar.h>


QT_CHARTS_USE_NAMESPACE

class Controller : public QThread
{
    Q_OBJECT

public:
    Controller();

    //Global Variables
    Model model;
    const std::string QML_NAME = "Controller";
    QMutex mutexVal;
    std::atomic<int> current_transmsission_id = 0;
    std::atomic<int> current_observation_id = 0;
    std::atomic<bool> play = false;
    std::atomic<double> speed = 1;
    QDateTime playblack_date;
    qint64 last_millis = 0;
    std::atomic<double> delay = 1000;

    //Methods
    void init();
    void calculateNextOrbitMarker();

    //Invokables for Viewer
    Q_INVOKABLE void setSatnogs(const QString &i_norad_id, const QString &i_start,
                                const QString &i_end,
                                const QString &i_status,
                                const bool &i_delOldFiles);
    Q_INVOKABLE void setOverflight(const QString &i_lat, const QString &i_lon,
                                   const QString &i_start_year,
                                   const QString &i_start_month,
                                   const QString &i_start_day,
                                   const QString &i_start_hour,
                                   const QString &i_start_min,
                                   const QString &i_start_sec,
                                   const QString &i_timespan,
                                   const QString &i_elevation);
    Q_INVOKABLE void loadData();
    Q_INVOKABLE QList<QString> getListNames();
    Q_INVOKABLE QVariantList getListPasses();
    Q_INVOKABLE void updateChart(const int &i_id,
                                 QAbstractSeries *i_series,
                                 QAbstractAxis *i_axisX,
                                 QAbstractAxis *i_axisY,
                                 const bool &i_zoom);
    Q_INVOKABLE void updateChart_overflight(QAbstractSeries *i_series,
                                            QAbstractSeries *i_series2,
                                            QAbstractAxis *i_axisX,
                                            QAbstractAxis *i_axisY);
    Q_INVOKABLE QString getUnit(const int &i_id);
    Q_INVOKABLE QVariantList getObservationData();
    Q_INVOKABLE QVariantList getSpacecraftData();
    Q_INVOKABLE QVariantList getEarthEphemerides();
    Q_INVOKABLE QVariantList getTransmissionData();
    Q_INVOKABLE QVariantList getPlaybackDate();
    Q_INVOKABLE QVariantList getEarthRotationJ2000();
    Q_INVOKABLE QVariantList getLVLHquaternion();
    Q_INVOKABLE void nextTransmission();
    Q_INVOKABLE void previousTransmission();
    Q_INVOKABLE void set_play_pause(const bool &i_play);
    Q_INVOKABLE void set_date(const int &i_day, const int &i_month, const int &i_year,
                              const int &i_hour, const int &i_minute, const int &i_second);
    Q_INVOKABLE void reset_date();
    Q_INVOKABLE void set_speed(const double &i_speed);
    Q_INVOKABLE QVariantList getOrbitMarkerX();
    Q_INVOKABLE QVariantList getOrbitMarkerY();
    Q_INVOKABLE QVariantList getOrbitMarkerZ();
    Q_INVOKABLE int getOrbitMarkerIntervall();
    Q_INVOKABLE void setOrbitMarkerIntervall(const int &i_interval);
    Q_INVOKABLE int getOrbitMarkerMax();
    Q_INVOKABLE void setOrbitMarkerMax(const int &i_max);


private:
    void run() override;

    //std::atomic<bool> are used becouse they provide defined behavior when two threads are accessing them at the same time
    std::atomic<bool> satnogsDataChanged = false;
    std::atomic<bool> satnogsLoadData = false;
    std::atomic<bool> reinitSpacecraft = false;
    std::atomic<bool> calcPasses = false;
    std::atomic<bool> calculateOrbitMarker = false;
    std::atomic<int> orbitMarkerMax = 88; //120
    std::atomic<int> orbitMarkerInterval = 60; //in s

    QVariantList orbitMarkerX;
    QVariantList orbitMarkerY;
    QVariantList orbitMarkerZ;

    void changeTransmission(const bool &changeDate = true);
    TextProgressBar progressBar;


signals:
    void setSpacecraftLocation();
    void calculating();
    void calculatingFinished();
    void dataReseted();
    void dataAvailable();
    void observationUpdated();
    void transmissionUpdated();
    void spacecraftUpdated();
    void orbitMarkerUpdated();
    void dateUpdated();
    void passesCalculated();


private slots:
    void handleModelImportFinished();
    void handleModelImportFailed();


};

#endif // CONTROLLER_H
