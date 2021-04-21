#ifndef APIREQUESTER_H
#define APIREQUESTER_H

#include <QObject>
#include <QString>
#include <QMap>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QDebug>
#include <QJsonDocument>

#include <memory>

class API_requester {

public:
    QString url_str;
    //HttpRequestVarLayout var_layout;
    QMap<QString, QString> vars;

    API_requester(QString v_url_str);
    void add_var(QString key, QString value);
};


class HttpRequestWorker : public QObject {
    Q_OBJECT

public:
    //QByteArray response;
    QJsonDocument response;
    QNetworkReply::NetworkError error_type;
    QString error_str;

    HttpRequestWorker(QObject *parent = 0);

    void execute(API_requester *input);

signals:
    void on_execution_finished(HttpRequestWorker *worker);

private:
    QNetworkAccessManager manager;

private slots:
    void on_manager_finished(QNetworkReply *reply);
    void handleError(QNetworkReply::NetworkError code) { qDebug() << "Error:" << code; }

};

#endif // HTTPREQUEST_H
