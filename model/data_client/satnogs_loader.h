#ifndef TEST_H
#define TEST_H

// Qt includes
#include <QObject>
#include <QDebug>
#include <QString>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QtConcurrent>
#include <QtCore>

// custom includes
#include <model/data_client/components/download_manager.h>
#include <model/data_client/components/api_requester.h>
#include <libs/_python.h>

#define DECODER_PATH "python/decode.py"
#define SATNOGS_URL "https://network.satnogs.org/api/observations/"
#define DATA_PATH "download"

class SatnogsLoader : public QObject
{
    Q_OBJECT

public:
   explicit SatnogsLoader(QObject *i_parent = nullptr);
   void load(const QString &i_noradId, const QString &i_start, const QString &i_end,
             const QString &i_status, const bool &i_keepOldFiles);

   DownloadManager downloader;

private:
   QString noradId;
   QString start;
   QString end;
   QString status;

   QJsonArray jsonResult;
   bool foundResult;
   int page = 1;
   ApiRequester apiRequester;

   void processResult();
   void cleanFolder(const QString &i_path = DATA_PATH);
   void saveJsonToFile(const QJsonObject &i_jsObj, const QString &i_name = "data",
                       const QString &i_path = DATA_PATH);
   void loadIterative();

signals:
   void importFinished();
   void importFailed();

private slots:
   void handleApiResult(HttpRequestWorker *i_worker);
   void handleDownloadFinished();

};

#endif // TEST_H
