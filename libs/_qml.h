#ifndef _QML_H
#define _QML_H
#include <QtCore>
#include <QQmlContext>

inline QQmlContext* rootContext;

static void addClass(const QString &i_name, QObject *i_obj){
    rootContext->setContextProperty(i_name, i_obj);
    qDebug() << "MAIN: Class added " << i_name;
}


#endif // _QML_H

