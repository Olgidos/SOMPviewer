#ifndef TEST_H
#define TEST_H

// Qt includes
#include <QObject>
#include <QDebug>
#include <model/components/api_requester.h>
#include <QString>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QtConcurrent>
#include <QtCore>

// custom includes
#include <model/components/download_manager.h>
#include <libs/_python.h>

#define DECODER_PATH "python/decode.py"
#define SATNOGS_URL "https://network.satnogs.org/api/observations/"
#define DATA_PATH "download"

class SatNOGS_loader : public QObject
{
    Q_OBJECT

public:
   explicit SatNOGS_loader(QObject *parent = nullptr);
   void load(QString i_norad_id, QString i_start, QString i_end, QString i_status, bool keepOldFiles);

   DownloadManager downloader;

private:
   QString norad_id;
   QString start;
   QString end;
   QString status;

   QJsonArray jsonResult;
   bool found_result;
   int page = 1;
   API_requester api_requester;

   void processResult();
   void cleanFolder(QString path = DATA_PATH);
   void saveJsonToFile(QJsonObject jsObj, QString name = "data", QString path = DATA_PATH);
   void loadIterative();

signals:
   void import_finished();
   void import_failed();

private slots:
   void handle_API_result(HttpRequestWorker *worker);
   void handle_Download_finished();

};

#endif // TEST_H
