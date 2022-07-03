/*
 * OrientationSensor.cpp
 *
 *  Created on: 12 Nov 2014
 *      Author: me
 */


   #include <QDebug>

    #include "OrientationSensor.hpp"

    OrientationSensor::OrientationSensor(QObject *parent)
        : QObject(parent)
        , m_orientation(Undefined)
    {

        // At first we have to connect to the sensor backend...
        if (!m_sensor.connectToBackend()) {
            qWarning() << "Cannot connect to orientation sensor backend!";
        }

        // ... and then add a filter that will process the read data
        m_sensor.addFilter(this);

        // Start gathering the data
        m_sensor.start();

        qDebug() << "Connected...apparently ";
    }

    OrientationSensor::Orientation OrientationSensor::orientation() const
    {
        return m_orientation;
    }

    bool OrientationSensor::filter(QOrientationReading *reading)
    {
        // Store the previous orientation
        const Orientation oldOrientation = m_orientation;

        switch (reading->orientation()) {
        case QOrientationReading::Undefined:
            m_orientation = Undefined;
            break;
        case QOrientationReading::TopUp:
            m_orientation = TopUp;
            break;
        case QOrientationReading::TopDown:
            m_orientation = TopDown;
            break;
        case QOrientationReading::LeftUp:
            m_orientation = LeftUp;
            break;
        case QOrientationReading::RightUp:
            m_orientation = RightUp;
            break;
        case QOrientationReading::FaceUp:
            m_orientation = FaceUp;
            break;
        case QOrientationReading::FaceDown:
            m_orientation = FaceDown;
            break;
        }

        // Emit changed signal if orientation has changed
        if (m_orientation != oldOrientation)
            emit orientationChanged();

        // Do no further processing of the sensor data
        return false;
    }

