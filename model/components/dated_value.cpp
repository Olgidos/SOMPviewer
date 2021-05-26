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
