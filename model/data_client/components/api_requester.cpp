#include "api_requester.h"

#include <QDateTime>
#include <QUrl>
#include <QFileInfo>
#include <QBuffer>


ApiRequester::ApiRequester(const QString &i_url_str) :
    url(i_url_str)
{
}

void ApiRequester::addVar(const QString &i_key, const QString &i_value) {
    vars[i_key] = i_value;
}






HttpRequestWorker::HttpRequestWorker(QObject  *i_parent)
    : QObject(i_parent),
      manager(this)
{
    connect(&manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onManagerFinished(QNetworkReply*)));
}

void HttpRequestWorker::execute(ApiRequester *i_input) {

    // reset variables

    QByteArray request_content = "";
    //response = "";
    errorType = QNetworkReply::NoError;
    errorString = "";


    // prepare request content

    QString boundary = "";

        if (i_input->vars.count() > 0) {
            bool first = true;
            foreach (QString key, i_input->vars.keys()) {
                if (!first) {
                    request_content.append("&");
                }
                first = false;

                request_content.append(QUrl::toPercentEncoding(key));
                request_content.append("=");
                request_content.append(QUrl::toPercentEncoding(i_input->vars.value(key)));
            }

            i_input->url += "?" + request_content;
            request_content = "";
            qDebug() << "httprequest API ULR: "<< i_input->url;
        }


    // prepare connection //Memory Leak
    QNetworkRequest *request = new QNetworkRequest(QUrl(i_input->url));
    manager.get(*request);
}

void HttpRequestWorker::onManagerFinished(QNetworkReply *i_reply) {
    errorType = i_reply->error();
    if (errorType == QNetworkReply::NoError) {
        response = QJsonDocument::fromJson(i_reply->readAll());
    }
    else {

        errorString = i_reply->errorString();
    }

    i_reply->deleteLater();

    emit onExecutionFinished(this);
}
