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
    Q_INVOKABLE void setSatnogs(QString i_norad_id, QString i_start, QString i_end, QString i_status, bool i_delOldFiles);
    Q_INVOKABLE void setOverflight(QString i_lat, QString i_lon,
                                    QString i_start_year, QString i_start_month, QString i_start_day,
                                    QString i_start_hour, QString i_start_min, QString i_start_sec,
                                    QString timespan, QString i_elevation);
    Q_INVOKABLE void loadData();
    Q_INVOKABLE QList<QString> getListNames();
    Q_INVOKABLE QVariantList getListPasses();
    Q_INVOKABLE void updateChart(int id, QAbstractSeries *series, QAbstractAxis *axisX, QAbstractAxis *axisY, bool zoom);
    Q_INVOKABLE void updateChart_overflight(QAbstractSeries *series, QAbstractSeries *series2, QAbstractAxis *axisX, QAbstractAxis *axisY);
    Q_INVOKABLE QString getUnit(int id);
    Q_INVOKABLE QVariantList getObservationData();
    Q_INVOKABLE QVariantList getSpacecraftData();
    Q_INVOKABLE QVariantList getEarthEphemerides();
    Q_INVOKABLE QVariantList getTransmissionData();
    Q_INVOKABLE QVariantList getPlaybackDate();
    Q_INVOKABLE QVariantList getEarthRotationJ2000();
    Q_INVOKABLE QVariantList getLVLHquaternion();
    Q_INVOKABLE void nextTransmission();
    Q_INVOKABLE void previousTransmission();
    Q_INVOKABLE void set_play_pause(bool i_play);
    Q_INVOKABLE void set_date(int day, int month, int year, int hour, int minute, int second);
    Q_INVOKABLE void reset_date();
    Q_INVOKABLE void set_speed(double i_speed);
    Q_INVOKABLE QVariantList getOrbitMarkerX();
    Q_INVOKABLE QVariantList getOrbitMarkerY();
    Q_INVOKABLE QVariantList getOrbitMarkerZ();
    Q_INVOKABLE int getOrbitMarkerIntervall();
    Q_INVOKABLE void setOrbitMarkerIntervall(int interval);
    Q_INVOKABLE int getOrbitMarkerMax();
    Q_INVOKABLE void setOrbitMarkerMax(int max);


private:
    void run() override;

    //std::atomic<bool> are used becouse they provide defined behavior when two threads are accessing them at the same time
    std::atomic<bool> satnogs_data_changed = false;
    std::atomic<bool> satnogs_load_data = false;
    std::atomic<bool> update_spacecraft = false;
    std::atomic<bool> calc_passes = false;
    std::atomic<bool> calculate_orbitMarker = false;
    std::atomic<int> orbit_marker_max = 88; //120
    std::atomic<int> orbit_marker_interval = 60; //in s

    QVariantList orbitMarkerX;
    QVariantList orbitMarkerY;
    QVariantList orbitMarkerZ;

    void changeTransmission(bool changeDate = true);
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
