#include "controller.h"

/*!
 * \brief Controller::Controller Constructor
 */
Controller::Controller() :
        model(),
        mutexVal(QMutex::Recursive)
{
    addClass(QString::fromStdString(QML_NAME), this);
    QObject::connect(&model, SIGNAL(dataLoaded()), this, SLOT(handleModelImportFinished()));
    QObject::connect(&model, SIGNAL(noDataLoaded()), this, SLOT(handleModelImportFailed()));

}

/*!
 * \brief Controller::init Called at the start to do parallel initiation
 */
void Controller::init() {
    QMutexLocker locker(&mutexVal);
}

/*!
 * \brief Controller::calculateNextOrbitMarker calculates the next Orbit Marker and saves its result in
 * orbitMarkerX
 * orbitMarkerY
 * orbitMarkerZ
 */
void Controller::calculateNextOrbitMarker()
{
    model.spacecraft.calc_next_marker(orbit_marker_interval);
    orbitMarkerX.push_back(model.spacecraft.getPositionECI(false).x());
    orbitMarkerY.push_back(model.spacecraft.getPositionECI(false).y());
    orbitMarkerZ.push_back(model.spacecraft.getPositionECI(false).z());
}


/*!
 * \brief Controller::setSatnogs called to update the SatNOGS data. Sets local bool satnogs_data_changed, therefore the controller thread can process this information. (Q_INVOKABLE) 
 * \param i_norad_id Satellite ID example: 45263
 * \param i_start observation start time example: 2020-05-20T00:00:00
 * \param i_end observation end time example: 2020-05-20T10:00:00
 * \param i_status observation status example: good
 */
void Controller::setSatnogs(QString i_norad_id, QString i_start, QString i_end, QString i_status, bool i_delOldFiles)
{
    QMutexLocker locker(&mutexVal);
    model.norad_id = i_norad_id;
    model.start_datetime = i_start;
    model.end_datetime = i_end;
    model.satnogs_status = i_status;
    emit dataReseted();

    model.importer.load(model.norad_id, model.start_datetime, model.end_datetime, model.satnogs_status, i_delOldFiles);
    satnogs_data_changed = true;

}

/*!
 * \brief Controller::setOverflight Invoced by GUI to kick of the calculation of the passes. Since this is a quit calculation heavy duty,
 * it is performaed on the conroller thread.
 * \param i_lat expl: 10.123
 * \param i_lon eclp: 50.012
 * \param i_start_year
 * \param i_start_month
 * \param i_start_day
 * \param i_start_hour
 * \param i_start_min
 * \param i_start_sec
 * \param timespan in days
 * \param i_elevation elevtion in degree
 */
void Controller::setOverflight(QString i_lat, QString i_lon,
                               QString i_start_year, QString i_start_month, QString i_start_day,
                               QString i_start_hour, QString i_start_min, QString i_start_sec,
                               QString timespan, QString i_elevation)
{

    QMutexLocker locker(&mutexVal);

    model.spacecraft.passes_start = QDateTime(QDate(i_start_year.toInt(), i_start_month.toInt(), i_start_day.toInt()),
                                QTime(i_start_hour.toInt(), i_start_min.toInt(), i_start_sec.toInt()), QTimeZone::utc()  );
    model.spacecraft.passes_end = model.spacecraft.passes_start.addDays(timespan.toInt());
    model.spacecraft.obs_lat = i_lat.toDouble();
    model.spacecraft.obs_lon = i_lon.toDouble();
    model.spacecraft.obs_min_elevation = i_elevation.toDouble();
    calc_passes = true;
}

void Controller::loadData()
{
    //if available, load existing Satnogs data
    satnogs_load_data = true;
    emit dataReseted();
}


/*!
 * \brief Controller::run Backend Thread
 */
void Controller::run() {

    init();

    while(true){
        QThread::msleep(8);

        if(satnogs_load_data) {
            QMutexLocker locker(&mutexVal);
            emit calculating();
            model.startLoadingData();
            satnogs_load_data = false;
        }

        if(update_spacecraft) {
            QMutexLocker locker(&mutexVal);
            if(model.observationList.length() != 0) {

                double quat_w = 0;
                double quat_x = 0;
                double quat_y = 0;
                double quat_z = 0;
                double yaw_rate = 0;
                double pitch_rate = 0;
                double roll_rate = 0;


                if(current_transmsission_id != -1)
                for(DatedValueList *list : model.dataLists) {
                    if(list->getName() == "q_ib_w") {
                        quat_w = list->at(current_transmsission_id).value;
                    }
                    if(list->getName() == "q_ib_i") {
                        quat_x = list->at(current_transmsission_id).value;
                    }
                    if(list->getName() == "q_ib_j") {
                        quat_y = list->at(current_transmsission_id).value;
                    }
                    if(list->getName() == "q_ib_k") {
                        quat_z = list->at(current_transmsission_id).value;
                    }
                    if(list->getName() == "angular_rate_x") {
                        yaw_rate = list->at(current_transmsission_id).value;
                    }
                    if(list->getName() == "angular_rate_y") {
                        pitch_rate = list->at(current_transmsission_id).value;
                    }
                    if(list->getName() == "angular_rate_z") {
                        roll_rate = list->at(current_transmsission_id).value;
                    }
                }


                model.spacecraft.reinit(playblack_date, quat_w, quat_x, quat_y, quat_z,
                                        yaw_rate, pitch_rate, roll_rate);
                orbitMarkerX.clear();
                orbitMarkerY.clear();
                orbitMarkerZ.clear();


                update_spacecraft = false;
                calculate_orbitMarker = true;
                emit spacecraftUpdated();
            } else {
                update_spacecraft = false;
                emit spacecraftUpdated();
            }

        }

        if(calculate_orbitMarker) {
            QMutexLocker locker(&mutexVal);
            calculateNextOrbitMarker();

            if(orbitMarkerX.length() > orbit_marker_max) {
                calculate_orbitMarker = false;
            }

            emit orbitMarkerUpdated();
        }


        if(satnogs_data_changed) {
            QMutexLocker locker(&mutexVal);
            satnogs_data_changed = false;
            emit calculating();
        }

        if(play && last_millis + delay < QDateTime::currentMSecsSinceEpoch() && model.observationList.size() > 0) {
            QMutexLocker locker(&mutexVal);
            if(last_millis != 0) {
                playblack_date = playblack_date.addMSecs((QDateTime::currentMSecsSinceEpoch() - last_millis) * speed);

                if(model.dataLists.size() != 0) {
                    //check if playback corresponds to a different transmission
                    if(current_transmsission_id + 1 < model.dataLists.at(0)->size()) {
                        if( playblack_date >= model.dataLists.at(0)->at(current_transmsission_id + 1).date) {
                            current_transmsission_id += 1;
                            current_observation_id = model.observationList.getObsIndex(model.dataLists.at(0)
                                                            ->at(current_transmsission_id).observationIndex);
                            emit transmissionUpdated();
                            emit observationUpdated();
                        }
                    }

                    if(current_transmsission_id - 1 > - 1 ) {
                        if(playblack_date < model.dataLists.at(0)->at(current_transmsission_id ).date)  {
                            current_transmsission_id -= 1;
                            current_observation_id = model.observationList.getObsIndex(model.dataLists.at(0)
                                                            ->at(current_transmsission_id).observationIndex);
                            emit transmissionUpdated();
                            emit observationUpdated();
                        }
                    }
                }

                model.spacecraft.calc_spacecraft_date(playblack_date);

                orbitMarkerX.clear();
                orbitMarkerY.clear();
                orbitMarkerZ.clear();

                calculate_orbitMarker = true;

                emit dateUpdated();
                emit spacecraftUpdated();

            }
            last_millis = QDateTime::currentMSecsSinceEpoch();
        }

        if(calc_passes) {
            QMutexLocker locker(&mutexVal);
            emit calculating();
            model.spacecraft.predictPasses();
            model.spacecraft.writeCSV_raw();
            model.spacecraft.writeCSV_passes();
            qDebug() << "CSV writing finished: ./output/spacecraft.csv & ./output/spacecraft_passes.csv";
            calc_passes = false;
            emit passesCalculated();
            emit calculatingFinished();
        }

    }
}

/*!
 * \brief Controller::handleExternalCalculationFinished SLOT to passthrough external calculation finished signals.
 */
void Controller::handleModelImportFinished()
{
    update_spacecraft = true;

    playblack_date = QDateTime( QDate(2021, 1, 1), QTime(0, 0, 0), QTimeZone::utc() );
    current_transmsission_id = -1;
    current_observation_id = -1;

    //if observations are available
    if(model.observationList.size() > 0) {
        current_observation_id = 0;
        playblack_date = model.observationList.at(0).start;
    }

    //if transmissions are available
    if(model.dataLists.size() > 0) {
        if(model.dataLists.at(0)->size() > 0){
            current_transmsission_id = 0;
            playblack_date = model.dataLists.at(0)->at(current_transmsission_id).date;
        }
    }


    emit calculatingFinished();
    emit dataAvailable();
    emit observationUpdated();
    emit transmissionUpdated();
    emit dateUpdated();
}

/*!
 * \brief Controller::handleExternalCalculationFinished SLOT to passthrough external calculation failed signals.
 */
void Controller::handleModelImportFailed()
{
    emit calculatingFinished();
}




/*!
 * \brief Controller::getListNames Function which is Q_INVOKABLE so the Viewer can obtain information about all available DatedValueLists
 * \return List of Names of all available DatedValueLists
 */
QList<QString> Controller::getListNames()
{
    QMutexLocker locker(&mutexVal);
    QList<QString> return_list;

    for(DatedValueList *list : model.dataLists) {
        return_list.push_back(list->getName());
    }

    return return_list;
}

/*!
 * \brief Controller::getListPasses returns all passes in a list
 * \return return_list // id1.date // id1.value // id2.date // id2.value
 */
QVariantList Controller::getListPasses()
{
    QMutexLocker locker(&mutexVal);
    QVariantList return_list;

    for(int i = 0; i < model.spacecraft.passes.size(); i++) {
        return_list.push_back(model.spacecraft.passes.at(i).date.toString());
        return_list.push_back(model.spacecraft.passes.at(i).value);
        return_list.push_back(model.spacecraft.max_elevations.at(i).value);
    }
    return return_list;
}


/*!
 * \brief Controller::updateChart Method to update chart, which can be called by the Viewer (Q_INVOKABLE). This external update method
 * improves the performance of the chart.
 * \param series Pointer to the series, which it will update with the current values
 * \param axisX Pointer to the x-Axis, which it will update to accommodate for the new size
 * \param axisY Pointer to the y-Axis, which it will update to accommodate for the new size
 */
void Controller::updateChart(int id, QAbstractSeries *series, QAbstractAxis *axisX, QAbstractAxis *axisY, bool zoom)
{
    QMutexLocker locker(&mutexVal);
    DatedValueList *list;

    list = model.dataLists[id];


    if (series && axisX && axisY) {
        QLineSeries *lineSeries = static_cast<QLineSeries *>(series);
        QDateTimeAxis *valAxisX = static_cast<QDateTimeAxis *>(axisX);
        QValueAxis *valAxisY = static_cast<QValueAxis *>(axisY);


        if(list->isEmpty()) return;

        double valAxisY_max = -DBL_MAX;
        double valAxisY_min = DBL_MAX;

        QDateTime valAxisX_max;
        QDateTime valAxisX_min = QDateTime::fromMSecsSinceEpoch( pow(2,57), QTimeZone::utc() );

        lineSeries->clear();

        progressBar.setMessage("preparing graph " + list->getName());

        int offset = QDateTime::currentDateTime().offsetFromUtc()*1000;


        QVector<QPointF> points;
        points.reserve(list->size());

        for(long i = 0; i < list->size(); i++) {
            points.append(QPointF(list->at(i).date.toLocalTime().toMSecsSinceEpoch() - offset, list->at(i).value));

            if(list->at(i).value > valAxisY_max) valAxisY_max = list->at(i).value * 1.2;
            if(list->at(i).value < valAxisY_min && list->at(i).value >= 0) valAxisY_min = list->at(i).value * 0.8;
            if(list->at(i).value < valAxisY_min && list->at(i).value < 0) valAxisY_min = list->at(i).value * 1.2;

            progressBar.setStatus(i,list->size());
            progressBar.update();
        }
        lineSeries->replace(points);

        progressBar.setStatus(1,1);
        progressBar.update();
        progressBar.clear();


        valAxisX_min = list->first().date.addMSecs( - offset);
        valAxisX_max = list->last().date.addMSecs( - offset);

        if(valAxisY_max == 0) valAxisY_max = 1;
        if(valAxisY_min == 0) valAxisY_min = -1;

        valAxisY->setMax(valAxisY_max);
        valAxisY->setMin(valAxisY_min);
        valAxisX->setMax(valAxisX_max);
        valAxisX->setMin(valAxisX_min);
    }
}


/*!
 * \brief Controller::updateChart_overflight similar to updateChart(), but optimized for >5000 data, which is easely generated by the spacecraft pass calculation
 * CHANGE (CAN BE PROPABLY BE COMBINED WITH OTHER CHART METHOD)
 * \param series
 * \param axisX
 * \param axisY
 * \param precalc first call via controller thread to prepare graph data. second call precalc = false asign calculated data to GUI.
 */
void Controller::updateChart_overflight(QAbstractSeries *series, QAbstractSeries *series2, QAbstractAxis *axisX, QAbstractAxis *axisY)
{
    QMutexLocker locker(&mutexVal);


    DatedValueList *list;
    DatedValueList *list2;

    list = &model.spacecraft.elevations;
    list2 = &model.spacecraft.illuminations;


    if (series && axisX && axisY) {
        QLineSeries *lineSeries = static_cast<QLineSeries *>(series);
        QLineSeries *lineSeries2 = static_cast<QLineSeries *>(series2);
        QDateTimeAxis *valAxisX = static_cast<QDateTimeAxis *>(axisX);
        QValueAxis *valAxisY = static_cast<QValueAxis *>(axisY);

        if(list->isEmpty()) return;

        double valAxisY_max = DBL_MIN;
        double valAxisY_min = DBL_MAX;

        QDateTime valAxisX_max;
        QDateTime valAxisX_min = QDateTime::fromMSecsSinceEpoch( pow(2,57), QTimeZone::utc() );

        lineSeries->clear();
        int offset = QDateTime::currentDateTime().offsetFromUtc()*1000;
        progressBar.setMessage("preparing graph " + list->getName() + " "+ list2->getName());

        QVector<QPointF> points1;
        QVector<QPointF> points2;
        points1.reserve(list->size());
        points2.reserve(list->size());

        for(long i = 0; i < list->size(); i++) {
            points1.append(QPointF(list->at(i).date.toLocalTime().toMSecsSinceEpoch() - offset, list->at(i).value));
            points2.append(QPointF(list2->at(i).date.toLocalTime().toMSecsSinceEpoch() - offset, list2->at(i).value));
            if(list->at(i).value > valAxisY_max)valAxisY_max = list->at(i).value * 1.2;
            if(list->at(i).value < valAxisY_min && list->at(i).value > 0) valAxisY_min = list->at(i).value * 0.8;
            if(list->at(i).value < valAxisY_min && list->at(i).value < 0) valAxisY_min = list->at(i).value * 1.2;
            progressBar.setStatus(i,list->size());
            progressBar.update();
        }

        lineSeries->replace(points1);
        lineSeries2->replace(points2);

        progressBar.setStatus(1,1);
        progressBar.update();
        progressBar.clear();

        valAxisX_min = list->first().date.addMSecs(-offset);
        valAxisX_max = list->last().date.addMSecs(-offset);

        if(valAxisY_max == 0) valAxisY_max = 1;
        if(valAxisY_min == 0) valAxisY_min = -1;

        valAxisY->setMax(valAxisY_max);
        valAxisY->setMin(valAxisY_min);
        valAxisX->setMax(valAxisX_max);
        valAxisX->setMin(valAxisX_min);

    }

}

/*!
 * \brief Controller::getUnit Returns the unit of the DatedValueList at id
 * \param id
 * \return Unit as QString
 */
QString Controller::getUnit(int id)
{
    QMutexLocker locker(&mutexVal);
    return model.dataLists[id]->getUnit();
}


/*!
 * \brief Controller::getObservationData Returns a QVariantList, which contains a full data set of an observation
 * \return QVariantList
 */
QVariantList Controller::getObservationData()
{
    QMutexLocker locker(&mutexVal);
    QVariantList gui_observation_buffer;

    if(current_observation_id != -1 && model.observationList.length() != 0) {
    //0
    gui_observation_buffer.append(  model.observationList[current_observation_id].start.toString() );
    //1
    gui_observation_buffer.append(  model.observationList[current_observation_id].end.toString() );
    //2
    gui_observation_buffer.append(  model.observationList[current_observation_id].tle1 + "\n" +
                                    model.observationList[current_observation_id].tle2);

    //3
    gui_observation_buffer.append( model.observationList[current_observation_id].max_altitude );
    //4
    gui_observation_buffer.append( model.observationList[current_observation_id].rise_azimuth );
    //5
    gui_observation_buffer.append( model.observationList[current_observation_id].set_azimuth );
    //6
    gui_observation_buffer.append( model.observationList[current_observation_id].station_lat );
    //7
    gui_observation_buffer.append( model.observationList[current_observation_id].station_lng );

    //8
    gui_observation_buffer.append( model.observationList[current_observation_id].station_name );
    //9
    gui_observation_buffer.append( model.observationList[current_observation_id].status );
    //10
    gui_observation_buffer.append( model.observationList[current_observation_id].tle0 );
    //11
    gui_observation_buffer.append( model.observationList[current_observation_id].transmitter_description );
    //12
    gui_observation_buffer.append( model.observationList[current_observation_id].id );
    //13
    gui_observation_buffer.append( model.observationList[current_observation_id].waterfall );

    } else {
        for (int i = 0; i < 14; i++) {
            gui_observation_buffer.append("");
        }
    }
    return gui_observation_buffer;
}

/*!
 * \brief Controller::getSpacecraftData provides spacecraft data to GUI
 * \return ECI height in km [0]; 3d ECI position vector in km [1,2,3]; Oriantation quaternion [4,5,6,7]
 */
QVariantList Controller::getSpacecraftData()
{
    QMutexLocker locker(&mutexVal);
    QVariantList gui_spacecraft_buffer;

    QQuaternion quat = model.spacecraft.getOrientation();
    gui_spacecraft_buffer.append( 0 );
    gui_spacecraft_buffer.append( model.spacecraft.getPositionECI( true ).x() );
    gui_spacecraft_buffer.append( model.spacecraft.getPositionECI( true ).y() );
    gui_spacecraft_buffer.append( model.spacecraft.getPositionECI( true ).z() );
    gui_spacecraft_buffer.append( quat.x());
    gui_spacecraft_buffer.append( quat.y());
    gui_spacecraft_buffer.append( quat.z());
    gui_spacecraft_buffer.append( quat.scalar());
    return gui_spacecraft_buffer;
}

/*!
 * \brief Controller::getEarthEphemerides provides earth ephmerides to GUI
 * \return
 */
QVariantList Controller::getEarthEphemerides()
{

    QMutexLocker locker(&mutexVal);
    QVariantList gui_buffer;

    Vector3D d3 = model.getSunEphermis(playblack_date);
    gui_buffer.append( d3.x );
    gui_buffer.append( d3.y );
    gui_buffer.append( d3.z );

    return gui_buffer;
}

/*!
 * \brief Controller::getTransmissionData Returns a QVariantList, which contains a full data set of an transmission
 * \return
 */
QVariantList Controller::getTransmissionData()
{
    QMutexLocker locker(&mutexVal);
    QVariantList gui_observation_buffer;

    if(current_transmsission_id != -1 && model.dataLists.length() != 0 && model.dataLists.at(0)->length() != 0) {

    //0
    gui_observation_buffer.append( (int) current_transmsission_id + 1 );
    //1
    gui_observation_buffer.append(  model.dataLists.at(0)->length() );
    //2
    gui_observation_buffer.append(  model.dataLists.at(0)->at(current_transmsission_id).date.toString() );


    } else {
        for (int i = 0; i < 3; i++) {
            gui_observation_buffer.append("");
        }
    }
    return gui_observation_buffer;
}

/*!
 * \brief Controller::getEarthEphemerides provides current date to GUI
 * \return
 */
QVariantList Controller::getPlaybackDate()
{
    QMutexLocker locker(&mutexVal);
    QVariantList gui_buffer;

    //0
    gui_buffer.append( playblack_date.date().day() );
    //1
    gui_buffer.append( playblack_date.date().month() );
    //2
    gui_buffer.append( playblack_date.date().year() );

    //3
    gui_buffer.append( playblack_date.time().second());
    //4
    gui_buffer.append( playblack_date.time().minute() );
    //5
    gui_buffer.append( playblack_date.time().hour() );

    return gui_buffer;
}

/*!
 * \brief Controller::getEarthRotationJ2000 returns the Quaternion transformation for Earth rel to J2000
 * \return
 */
QVariantList Controller::getEarthRotationJ2000()
{
    QMutexLocker locker(&mutexVal);
    QVariantList gui_buffer;

    QQuaternion quat = model.getEarthRotation(playblack_date);
    gui_buffer.append(quat.x());
    gui_buffer.append(quat.y());
    gui_buffer.append(quat.z());
    gui_buffer.append(quat.scalar());
    return gui_buffer;
}

/*!
 * \brief Controller::getLVLHquaternion returns the ECI to LVLH quaternion to the GUI
 * \return
 */
QVariantList Controller::getLVLHquaternion()
{
    QMutexLocker locker(&mutexVal);
    QVariantList gui_buffer;

    QQuaternion quat = model.spacecraft.eci_to_LVLH_rot();
    gui_buffer.append(quat.x());
    gui_buffer.append(quat.y());
    gui_buffer.append(quat.z());
    gui_buffer.append(quat.scalar());
    return gui_buffer;
}

/*!
 * \brief Controller::nextObservation switches current active observation to the next.
 */
void Controller::nextTransmission()
{
    QMutexLocker locker(&mutexVal);
    if(current_transmsission_id == model.dataLists.at(0)->length() - 1) {
        current_transmsission_id = 0;
    } else {
        current_transmsission_id++;
    }

    changeTransmission();
}

/*!
 * \brief Controller::previousObservation switches current active observation to the previous.
 */
void Controller::previousTransmission()
{
    QMutexLocker locker(&mutexVal);
    if(current_transmsission_id == 0) {
        current_transmsission_id = model.dataLists.at(0)->length() - 1;
    } else {
        current_transmsission_id--;
    }

    changeTransmission();
}


/*!
 * \brief Controller::changeTransmission private helper function to combine functionality of next and previous transmission
 */
void Controller::changeTransmission( bool changeDate) {
    int newObservation = model.observationList.getObsIndex(model.dataLists.at(0)->at(current_transmsission_id).observationIndex);
    if(current_observation_id != newObservation ){
        current_observation_id = newObservation;
        emit observationUpdated();
    }

    if(changeDate) playblack_date = model.dataLists.at(0)->at(current_transmsission_id).date;
    update_spacecraft = true;
    emit transmissionUpdated();
    emit dateUpdated();
}

/*!
 * \brief Controller::play_pauseObservation play pause playpack
 */
void Controller::set_play_pause(bool i_play)
{
    QMutexLocker locker(&mutexVal);
    play = i_play;
    last_millis = 0;
}

/*!
 * \brief Controller::set_set_date GUI updates date
 * \param day
 * \param month
 * \param year
 * \param hour
 * \param minute
 * \param second
 */
void Controller::set_date(int day, int month, int year, int hour, int minute, int second)
{
    QMutexLocker locker(&mutexVal);

    playblack_date = QDateTime(QDate(year,month,day), QTime(hour, minute, second), QTimeZone::utc());

    if(!playblack_date.isValid()) {
        changeTransmission();
        return;
    }

    //In case there is no transmission data loaded
    if(model.dataLists.size() == 0 ) {
        update_spacecraft = true;
        emit dateUpdated();
        return;
    }

    //search fitting transmission
    current_transmsission_id = -2;
    for(int i = 0; i < model.dataLists.at(0)->size(); i++) {
        if(model.dataLists.at(0)->at(i).date > playblack_date) {
            current_transmsission_id = i - 1;
            if(current_transmsission_id < 0) current_transmsission_id = 0;
            i = model.dataLists.at(0)->size();
        }
    }
    if(current_transmsission_id == -2) current_transmsission_id = model.dataLists.at(0)->size()-1;

    changeTransmission(false);
}

/*!
 * \brief Controller::reset_date GUI call to reset to the start date
 */
void Controller::reset_date()
{
    QMutexLocker locker(&mutexVal);

    if(model.dataLists.size() == 0) {
        playblack_date = model.observationList.at(0).start;
        emit dateUpdated();
        update_spacecraft = true;
        return;
    }
    changeTransmission();
}

/*!
 * \brief Controller::set_speed GUI sets playback speed
 * \param i_speed
 */
void Controller::set_speed(double i_speed)
{
    QMutexLocker locker(&mutexVal);
    speed = i_speed;
    delay = 1000/abs(speed);
    if(delay < 17) delay = 17;
}


/*!
 * \brief Controller::getOrbitMarkerX return OrbitMarkerX to GUI
 * \return
 */
QVariantList Controller::getOrbitMarkerX()
{
    QMutexLocker locker(&mutexVal);
    return orbitMarkerX;
}

/*!
 * \brief Controller::getOrbitMarkerX return OrbitMarkerY to GUI
 * \return
 */
QVariantList Controller::getOrbitMarkerY()
{
    QMutexLocker locker(&mutexVal);
    return orbitMarkerY;
}

/*!
 * \brief Controller::getOrbitMarkerX return OrbitMarkerZ to GUI
 * \return
 */
QVariantList Controller::getOrbitMarkerZ()
{
    QMutexLocker locker(&mutexVal);
    return orbitMarkerZ;
}

/*!
 * \brief Controller::getOrbitMarkerIntervall return OrbitMarkerIntervall to GUI
 * \return
 */
int Controller::getOrbitMarkerIntervall()
{
    return orbit_marker_interval;
}

/*!
 * \brief Controller::setOrbitMarkerIntervall allowes the GUI to set OrbitMarkerIntervall
 * \param interval
 */
void Controller::setOrbitMarkerIntervall(int interval)
{
    orbit_marker_interval = interval;
}

/*!
 * \brief Controller::getOrbitMarkerMax return orbit_marker_max to GUI
 * \return
 */
int Controller::getOrbitMarkerMax()
{
    return orbit_marker_max;
}

/*!
 * \brief Controller::setOrbitMarkerMax allowes the GUI to set orbit_marker_max
 * \param interval
 */
void Controller::setOrbitMarkerMax(int max)
{
    orbit_marker_max = max;
}

