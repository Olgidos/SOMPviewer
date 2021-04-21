#include "settings.h"

Settings::Settings() :
    latitude(0),
    longitude(0)
{

}

bool Settings::loadSettings() {
    settingsChanged();
    return true;
}


