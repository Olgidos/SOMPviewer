#ifndef MKSPKCON_H
#define MKSPKCON_H

#endif // MKSPKCON_H
#include <QtCore>
#include "resource/cspice/include/SpiceUsr.h"

#define SETUP_NAME "/setup.tle"
#define IO_NAME "hst"
#define std_path "kernels"

/*!
 * \brief setupFile creates the setup file for the mkspk tle to .spk file routine
 * \param norad_id
 * \param path for the file output
 */
static void mkSetupFile(int norad_id, int spk_obj_id, int center_id, QString path = std_path) {
    QFile file(path + SETUP_NAME);
    file.remove();

    if (file.open(QIODevice::ReadWrite)) {
        QTextStream stream(&file);
        stream << "\\begindata" << Qt::endl;
        stream << "INPUT_DATA_TYPE   = 'TL_ELEMENTS'" << Qt::endl;
        stream << "OUTPUT_SPK_TYPE   = 10" << Qt::endl;
        stream << "TLE_INPUT_OBJ_ID  = " << norad_id << Qt::endl;
        stream << "TLE_SPK_OBJ_ID    = " << spk_obj_id << Qt::endl;
        stream << "CENTER_ID         = " << center_id << Qt::endl;
        stream << "REF_FRAME_NAME    = 'J2000'" << Qt::endl;
        stream << "START_TIME        = '2000 1 1 00:00:00'" << Qt::endl;
        stream << "STOP_TIME         = '3000 1 1 00:00:00'" << Qt::endl;
        stream << "LEAPSECONDS_FILE  = '" << std_path << "\\" << "naif0012.tls'" << Qt::endl;
        stream << "INPUT_DATA_FILE   = '" << std_path << "\\" << IO_NAME << ".tle'" << Qt::endl;
        stream << "OUTPUT_SPK_FILE   = '" << std_path << "\\" << IO_NAME << ".bsp'" << Qt::endl;
        stream << "PCK_FILE          = '" << std_path << "\\" << "geophysical.ker'" << Qt::endl;
        stream << "SEGMENT_ID        = 'HST TLE-based Trajectory'" << Qt::endl;
        stream << "PRODUCER_ID       = 'Automatic'" << Qt::endl;
        stream << "\\begintext";

        file.close();
        return;
    }

    qWarning() << "Failed to write mkspk File";
}

/*!
 * \brief mkInputFile writes the Input file for the mkspk containing all tles
 * \param tles List of tle lines must have an even length
 * \param path
 */
static void mkInputFile(QList<QString> &tles, QString path = std_path) {
    if(tles.size() % 2 == 0) {
        QFile file(path + "/" + IO_NAME + ".tle");

        if (file.open(QIODevice::ReadWrite)) {
            QTextStream stream(&file);

            for(QString line : tles) {
                QTextStream stream(&file);
                stream << line << Qt::endl;
            }
            file.close();
            return;
        }
    }

    qWarning() << "Forgot a TLE line? tles.length: " << tles.size();
}

/*!
 * \brief runMkspk
 * \param path
 */
static void runMkspk( QString path  = std_path) {

    QString kernel_file = path + "\\" + IO_NAME + ".bsp";
    unload_c(kernel_file.toStdString().c_str());

    QFile file (kernel_file);
    file.remove();

    const std::string comb = path.toStdString() + "\\mkspk.exe -setup " + path.toStdString() + "\\setup.tle";
    system(comb.c_str());

    furnsh_c (kernel_file.toStdString().c_str());
}












