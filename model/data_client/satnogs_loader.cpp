#include "satnogs_loader.h"

SatnogsLoader::SatnogsLoader(QObject *i_parent)
    : QObject(i_parent),
      downloader(this, DATA_PATH),
      apiRequester("")
{
    connect(&downloader, SIGNAL(finished()), this, SLOT(handleDownloadFinished()));
}


/*!
 * \brief SatNOGS_loader::load Prepares and initiates a loading process of the Satnogs Loader
 * \param i_norad_id Satellite ID example: 45263
 * \param i_start observation start time example: 2020-05-20T00:00:00
 * \param i_end observation end time example: 2020-05-20T10:00:00
 * \param i_status observation status example: good
 */
void SatnogsLoader::load(const QString &i_noradId, const QString &i_start, const QString &i_end,
                     const QString &i_status, const bool &i_keepOldFiles){
    //clean download folder and reset required parameter

    if(!i_keepOldFiles) cleanFolder();

    foundResult = false;
    jsonResult = QJsonArray();
    page = 1;

    noradId = i_noradId;
    start = i_start;
    end = i_end;
    status = i_status;

    loadIterative();
}


/*!
 * \brief SatNOGS_loader::loadIterative starts the API request, needs to be called multiple times when API answer
 * is longer then a single page
 */
void SatnogsLoader::loadIterative()
{
    //prepare API request
    QString url_str = SATNOGS_URL;
    apiRequester = ApiRequester(url_str);
    if(noradId != "") apiRequester.addVar("satellite__norad_cat_id", noradId);
    if(start != "") apiRequester.addVar("start", start);
    if(end != "") apiRequester.addVar("end", end);
    if(status != "") apiRequester.addVar("status", status);

    apiRequester.addVar("page", QString::number(page));

    //MEMORY LEAK?
    HttpRequestWorker *worker = new HttpRequestWorker(this);
    connect(worker, SIGNAL(onExecutionFinished(HttpRequestWorker*)), this, SLOT(handleApiResult(HttpRequestWorker*)));
    worker->execute(&apiRequester);
}




/*!
 * \brief SatNOGS_loader::handle_API_result Slot which is called wehn the HttpRequestWorker fhnished his API request
 * \param worker The requesting object, provides the result
 */
void SatnogsLoader::handleApiResult(HttpRequestWorker *i_worker) {

    if (i_worker->errorType == QNetworkReply::NoError) {

        if(i_worker->response.array().size() == 0) {
            //No Data found
            qDebug() << "There was no data available during the specified dates!";
            emit importFailed();
            return;
        }

        // communication was successful
        jsonResult.append(i_worker->response.array());
        foundResult = true;

        qDebug() << "satnogs_Loader: Successfully SatNOGS API call page -" << page;
        page++;
        loadIterative();

    } else {

        //In case of multiple API pages, recall API until next page is not found
        if(foundResult) {
            processResult();
            return;
        }

        // an error occurred
        qDebug() << "satnogs_Loader Error: " << i_worker->errorString;
    }
}

/*!
 * \brief SatNOGS_loader::handle_Download_finished Slot which is called when the observation downloader is finished.
 * Starts the postprocessing of the data via python script
 */
void SatnogsLoader::handleDownloadFinished()
{
    QString path = QDir::currentPath() + "/python";
    const int py_argc = 1;
    char* py_argv[py_argc];
    py_argv[0] = path.toStdString().data();
    runPyScriptArgs(DECODER_PATH,1,py_argv);
    emit importFinished();
}

/*!
 * \brief SatNOGS_loader::processResult Processes the API request and downloades the referred observation files and waterfalls
 */
void SatnogsLoader::processResult() {

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
void SatnogsLoader::saveJsonToFile(const QJsonObject &i_jsObj, const QString &i_name,
                                   const QString &i_path){
    QFile file(i_path + "/" + i_name + ".json");
    QJsonDocument doc;
    doc.setObject(i_jsObj);
    file.open(QFile::WriteOnly | QFile::Text | QFile::Truncate);
    file.write(doc.toJson());
    file.close();
}

/*!
 * \brief SatNOGS_loader::cleanFolder Removes all files from a folder.
 * \param path
 */
void SatnogsLoader::cleanFolder(const QString &i_path) {
    QDir dir(i_path);
//    dir.setNameFilters(QStringList() << "*.*");
    dir.setNameFilters(QStringList() << "*");
    dir.setFilter(QDir::Files);
    foreach(QString dirFile, dir.entryList())
    {
        dir.remove(dirFile);
    }
}























