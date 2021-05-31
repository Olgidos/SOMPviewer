QT += concurrent network core gui widgets charts qml quick\
3dcore 3drender 3dinput \
3dquick 3dquickrender 3dquickinput 3dquickextras

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++17 console
CONFIG += resources_big
CONFIG += QT_NO_DEBUG_OUTPUT
CONFIG += force_debug_info

#CONFIG -= app_bundle
#file:///C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/MSVC/14.27.29110/lib/x64/store/legacy_stdio_definitions.lib
#python

win32 {
  APPDATA_DIR = $$system(echo %LOCALAPPDATA%)
}

INCLUDEPATH += "$$APPDATA_DIR\Programs\Python\Python39\include"
LIBS += -L"$$APPDATA_DIR\Programs\Python\Python39\libs" -l"python39"

SOURCES += \
    controller/controller.cpp \
    main.cpp \
    model/components/dated_observation.cpp \
    model/components/dated_value.cpp \
    model/components/text_progressbar.cpp \
    model/data_client/components/api_requester.cpp \
    model/data_client/components/download_manager.cpp \
    model/data_client/satnogs_loader.cpp \
    model/model.cpp \
    model/space_model/space_model.cpp \
    model/space_model/spacecraft.cpp


TRANSLATIONS += \
    Somp_data_loader_en_GB.ts

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

RESOURCES += \
    resource-graphic.qrc \
    resource-qml.qrc

RC_ICONS = resource/images/icon.ico

HEADERS += \
    controller/controller.h \
    libs/_python.h \
    libs/_qml.h \
    model/components/dated_observation.h \
    model/components/dated_value.h \
    model/components/mkspkCon.h \
    model/components/text_progressbar.h \
    model/data_client/components/api_requester.h \
    model/data_client/components/download_manager.h \
    model/data_client/satnogs_loader.h \
    model/model.h \
    model/space_model/space_model.h \
    model/space_model/spacecraft.h


DISTFILES += \
    resource/images/1_earthcloudsalpha_16k.png \
    resource/images/8081_earthspec10k.jpg \
    resource/images/galaxy_starfield.jpg \
    resource/images/highRes/earthmap21k coloradjust1.jpg \
    resource/images/highRes/earthmap21k coloradjust1.jpg \
    resource/images/highRes/earthmap21k coloradjust1.jpg \
    resource/images/icon.ico \
    resource/images/sunmap.jpg \
    resource/objects/LitSat-1.mtl \
    resource/objects/positionMarker.STL \
    resource/qml/shaders/cloudShader.frag \
    resource/qml/shaders/cloudShader.vert \
    resource/qml/shaders/test.frag \
    resource/qml/shaders/test.vert




#unix|win32: LIBS += -llegacy_stdio_definitions

unix|win32: LIBS += -L$$PWD/resource/cspice/lib/ -lcspice

INCLUDEPATH += $$PWD/resource/cspice/include
DEPENDPATH += $$PWD/resource/cspice/include

win32:!win32-g++: PRE_TARGETDEPS += $$PWD/resource/cspice/lib/cspice.lib
else:unix|win32-g++: PRE_TARGETDEPS += $$PWD/resource/cspice/lib/libcspice.a
