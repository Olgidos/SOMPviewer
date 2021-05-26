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

class ApiRequester {
public:
    ApiRequester(const QString &i_url);

    QString url;
    QMap<QString, QString> vars;

    void addVar(const QString &i_key, const QString &i_value);
};




class HttpRequestWorker : public QObject {
    Q_OBJECT

public:
    HttpRequestWorker(QObject *i_parent = 0);

    QJsonDocument response;
    QNetworkReply::NetworkError errorType;
    QString errorString;

    void execute(ApiRequester *i_input);

private:
    QNetworkAccessManager manager;

signals:
    void onExecutionFinished(HttpRequestWorker *i_worker);

private slots:
    void onManagerFinished(QNetworkReply *i_reply);
    void handleError(const QNetworkReply::NetworkError &i_code) { qDebug() << "Error:" << i_code; }

};

#endif // HTTPREQUEST_H
