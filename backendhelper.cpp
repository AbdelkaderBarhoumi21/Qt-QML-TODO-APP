#include "backendhelper.h"

BackendHelper::BackendHelper(QObject *parent)
    : QObject{parent}
{
    QDateTime dateTime;
    m_currentDay=QString::number(dateTime.currentDateTime().date().day());
    QLocale locale;
    m_currentMonth=locale.monthName(dateTime.currentDateTime().date().month());
    m_currentYear=QString::number(dateTime.currentDateTime().date().year());
    m_currentDayOfWeek=locale.dayName(dateTime.currentDateTime().date().dayOfWeek());
}

QString BackendHelper::currentDay() const
{
    return m_currentDay;
}

void BackendHelper::setCurrentDay(const QString &newCurrentDay)
{
    if (m_currentDay == newCurrentDay)
        return;
    m_currentDay = newCurrentDay;
    emit currentDayChanged();
}

QString BackendHelper::currentMonth() const
{
    return m_currentMonth;
}

void BackendHelper::setcurrentMonth(const QString &newCurrentMonth)
{
    if (m_currentMonth == newCurrentMonth)
        return;
    m_currentMonth = newCurrentMonth;
    emit currentMonthChanged();
}

QString BackendHelper::currentYear() const
{
    return m_currentYear;
}

void BackendHelper::setcurrentYear(const QString &newCurrentYear)
{
    if (m_currentYear == newCurrentYear)
        return;
    m_currentYear = newCurrentYear;
    emit currentYearChanged();
}

QString BackendHelper::currentDayOfWeek() const
{
    return m_currentDayOfWeek;
}

void BackendHelper::setcurrentDayOfWeek(const QString &newCurrentDayOfWeek)
{
    if (m_currentDayOfWeek == newCurrentDayOfWeek)
        return;
    m_currentDayOfWeek = newCurrentDayOfWeek;
    emit currentDayOfWeekChanged();
}
