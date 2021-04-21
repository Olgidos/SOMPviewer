#include "api_requester.h"

#include <QDateTime>
#include <QUrl>
#include <QFileInfo>
#include <QBuffer>


API_requester::API_requester(QString v_url_str) {
    url_str = v_url_str;
}


void API_requester::add_var(QString key, QString value) {
    vars[key] = value;
}


HttpRequestWorker::HttpRequestWorker(QObject *parent)
    : QObject(parent),
      manager(this)
{
    //manager = new QNetworkAccessManager(this);
    connect(&manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(on_manager_finished(QNetworkReply*)));
}

void HttpRequestWorker::execute(API_requester *input) {

    // reset variables

    QByteArray request_content = "";
    //response = "";
    error_type = QNetworkReply::NoError;
    error_str = "";


    // prepare request content

    QString boundary = "";

        if (input->vars.count() > 0) {
            bool first = true;
            foreach (QString key, input->vars.keys()) {
                if (!first) {
                    request_content.append("&");
                }
                first = false;

                request_content.append(QUrl::toPercentEncoding(key));
                request_content.append("=");
                request_content.append(QUrl::toPercentEncoding(input->vars.value(key)));
            }

            input->url_str += "?" + request_content;
            request_content = "";
            qDebug() << "httprequest API ULR: "<< input->url_str;
        }


    // prepare connection //Memory Leak
    QNetworkRequest *request = new QNetworkRequest(QUrl(input->url_str));
    manager.get(*request);
}

void HttpRequestWorker::on_manager_finished(QNetworkReply *reply) {
    error_type = reply->error();
    if (error_type == QNetworkReply::NoError) {
        response = QJsonDocument::fromJson(reply->readAll());
    }
    else {

        error_str = reply->errorString();
    }

    reply->deleteLater();

    emit on_execution_finished(this);
}
