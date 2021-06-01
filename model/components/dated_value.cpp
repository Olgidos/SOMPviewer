#include "dated_value.h"

/*!
 * \brief DatedValue::DatedValue Data structure to combine a double value and a date
 * \param i_value
 * \param i_date
 */
DatedValue::DatedValue(const double &i_value, const QDateTime &i_date, const int &i_observationIndex)
    : date(i_date),
      value(i_value),
      observationIndex(i_observationIndex)
{
}

/*!
 * \brief DatedValueList::DatedValueList base constructor
 * \param i_name name of the contained dated values
 * \param i_unit unit of the contained dated values
 */
DatedValueList::DatedValueList(const QString &i_name, const QString &i_unit)
      :name(i_name),
      unit(i_unit)
{
    //DatedValueList::lists.push_back(this);
}

/*!
 * \brief DatedValueList::getName Basic name getter for the Viewer (Q_INVOKABLE)
 */
QString DatedValueList::getName()
{
    return name;
}

/*!
 * \brief DatedValueList::getName Basic unit getter for the Viewer (Q_INVOKABLE)
 */
QString DatedValueList::getUnit()
{
    return unit;
}


bool dateTimeComp(DatedValue &left, DatedValue &right)
{
    return left.date < right.date;
}


void DatedValueList::sort()
{
    std::sort(begin(), end(), dateTimeComp);
}

/*!
 * \brief DatedValueList::getIDforDate returns id of the item which directly below the input date
 * \param i_date
 */
int DatedValueList::getIDforDate(const QDateTime i_date)
{

    if(empty()) return -1;

    if (QList::at(lastCallItemID).date <= i_date) {

        if(lastCallItemID +1 >= size() ) {
            return lastCallItemID;
        }

        for(int i = lastCallItemID + 1; i < size(); i++) {
            if (QList::at(i).date > i_date) {
                return i-1;
            }
        }
        return size()-1;
    }


    //if(lastCallItemID + 1 >= size()) return 0;

    if (QList::at(lastCallItemID).date > i_date) {
        for(int i = lastCallItemID; i >= 0; i--) {
            if (QList::at(i).date <= i_date) {
                return i;
            }
        }
        return 0;
    }

    return -1;
}

const DatedValue &DatedValueList::at(int i)
{
    lastCallItemID = i;
    return QList::at(i);
}

