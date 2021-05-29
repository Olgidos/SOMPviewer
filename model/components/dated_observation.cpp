#include "dated_observation.h"

/*!
 * \brief DatedValue::DatedValue Data structure to combine a double value and a date
 * \param i_value
 * \param i_date
 */
DatedObservation::DatedObservation(const QString &i_tle1, const QString &i_tle2, const QDateTime &i_start)
    : start(i_start),
      tle1(i_tle1),
      tle2(i_tle2)
{
}

DatedObservationList::DatedObservationList() {

}


bool dateTimeComp(DatedObservation &left, DatedObservation &right)
{
    return left.start < right.start;
}


void DatedObservationList::sort()
{
    std::sort(begin(), end(), dateTimeComp);
}

int DatedObservationList::getObsIndex(const int &i_id)
{
    for(int i = 0; i < length(); i++) {
        if(i_id == at(i).id) return i;
    }
    return -1;
}

