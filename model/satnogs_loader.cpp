#include "satnogs_loader.h"

SatNOGS_loader::SatNOGS_loader(QObject *parent)
    : QObject(parent),
      downloader(this, DATA_PATH),
      api_requester("")
{
    connect(&downloader, SIGNAL(finished()), this, SLOT(handle_Download_finished()));
}


/*!
 * \brief SatNOGS_loader::load Prepares and initiates a loading process of the Satnogs Loader
 * \param i_norad_id Satellite ID example: 45263
 * \param i_start observation start time example: 2020-05-20T00:00:00
 * \param i_end observation end time example: 2020-05-20T10:00:00
 * \param i_status observation status example: good
 */
void SatNOGS_loader::load(QString i_norad_id, QString i_start, QString i_end, QString i_status, bool keepOldFiles) {
    //clean download folder and reset required parameter

    if(!keepOldFiles) cleanFolder();

    found_result = false;
    jsonResult = QJsonArray();
    page = 1;

    norad_id = i_norad_id;
    start = i_start;
    end = i_end;
    status = i_status;

    loadIterative();
}


/*!
 * \brief SatNOGS_loader::loadIterative starts the API request, needs to be called multiple times when API answer
 * is longer then a single page
 */
void SatNOGS_loader::loadIterative()
{
    //prepare API request
    QString url_str = SATNOGS_URL;
    api_requester = API_requester(url_str);
    if(norad_id != "") api_requester.add_var("satellite__norad_cat_id", norad_id);
    if(start != "") api_requester.add_var("start", start);
    if(end != "") api_requester.add_var("end", end);
    if(status != "") api_requester.add_var("status", status);

    api_requester.add_var("page", QString::number(page));

    //MEMORY LEAK?
    HttpRequestWorker *worker = new HttpRequestWorker(this);
    connect(worker, SIGNAL(on_execution_finished(HttpRequestWorker*)), this, SLOT(handle_API_result(HttpRequestWorker*)));
    worker->execute(&api_requester);
}




/*!
 * \brief SatNOGS_loader::handle_API_result Slot which is called wehn the HttpRequestWorker fhnished his API request
 * \param worker The requesting object, provides the result
 */
void SatNOGS_loader::handle_API_result(HttpRequestWorker *worker) {

    if (worker->error_type == QNetworkReply::NoError) {

        if(worker->response.array().size() == 0) {
            //No Data found
            qDebug() << "There was no data available during the specified dates!";
            emit import_failed();
            return;
        }

        // communication was successful
        jsonResult.append(worker->response.array());
        found_result = true;

        qDebug() << "satnogs_Loader: Successfully SatNOGS API call page -" << page;
        page++;
        loadIterative();

    } else {

        //In case of multiple API pages, recall API until next page is not found
        if(found_result) {
            processResult();
            return;
        }

        // an error occurred
        qDebug() << "satnogs_Loader Error: " << worker->error_str;
    }
}

/*!
 * \brief SatNOGS_loader::handle_Download_finished Slot which is called when the observation downloader is finished.
 * Starts the postprocessing of the data via python script
 */
void SatNOGS_loader::handle_Download_finished()
{
    QString path = QDir::currentPath() + "/python";
    const int py_argc = 1;
    char* py_argv[py_argc];
    py_argv[0] = path.toStdString().data();
    runPyScriptArgs(DECODER_PATH,1,py_argv);
    emit import_finished();
}

/*!
 * \brief SatNOGS_loader::processResult Processes the API request and downloades the referred observation files and waterfalls
 */
void SatNOGS_loader::processResult() {

    int i = 0;

    QJsonArray rootArray = jsonResult;

    for(const QJsonValue& subArray: jsonResult) {

        for(const QJsonValue& val: subArray.toArray()) {
            QJsonObject loopObj = val.toObject();
            qDebug() << "[" << i << "] id       : " << loopObj["id"].toInt();
            qDebug() << "[" << i << "] start    : " << loopObj["start"].toString();
            qDebug() << "[" << i << "] end      : " << loopObj["end"].toString();
            qDebug() << "[" << i << "] waterfall: " << loopObj["waterfall"].toString();
            downloader.append(loopObj["waterfall"].toString());

            saveJsonToFile(loopObj, "observation_" + QString::number(loopObj["id"].toInt()) );

            int n = 0;
            QJsonArray loopArray = loopObj["demoddata"].toArray();
            for(const QJsonValue& val_2: loopArray) {
               QJsonObject loopObj_2 = val_2.toObject();
               QString url = loopObj_2["payload_demod"].toString();
               qDebug() << "[" << i << "," << n << "] demoddata: " << url;
               downloader.append(url); //the finished signal is processed in handle_Download_finished
               n++;
            }
            i++;
        }

    }
}


/*!
 * \brief SatNOGS_loader::saveJsonToFile Writes a JsonObject to file. Is used to store the individual observations
 * from the API request.
 * \param jsObj JsonObject to write
 * \param name Name of the file
 * \param path Path of the file
 */
void SatNOGS_loader::saveJsonToFile(QJsonObject jsObj, QString name, QString path){
    QFile file(path + "/" + name + ".json");
    QJsonDocument doc;
    doc.setObject(jsObj);
    file.open(QFile::WriteOnly | QFile::Text | QFile::Truncate);
    file.write(doc.toJson());
    file.close();
}

/*!
 * \brief SatNOGS_loader::cleanFolder Removes all files from a folder.
 * \param path
 */
void SatNOGS_loader::cleanFolder(QString path) {
    QDir dir(path);
//    dir.setNameFilters(QStringList() << "*.*");
    dir.setNameFilters(QStringList() << "*");
    dir.setFilter(QDir::Files);
    foreach(QString dirFile, dir.entryList())
    {
        dir.remove(dirFile);
    }
}























