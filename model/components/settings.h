#ifndef SETTINGS_H
#define SETTINGS_H
#include <QObject>
#include <QDebug>
#include <string>


class Settings : public QObject
{
        Q_OBJECT
        Q_PROPERTY(double baseLat READ getBaseLat)
        Q_PROPERTY(double baseLon READ getBaseLon)

    public:
        Settings();
        const std::string QML_NAME = "Settings";
        bool loadSettings();

        //BaseStation Properties
        double latitude;
        double getBaseLat() { return latitude; };
        double longitude;
        double getBaseLon() { return longitude; };


    signals:
        void settingsChanged();

    public slots:

};

#endif // SETTINGS_H
