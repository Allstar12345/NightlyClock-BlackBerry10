#ifndef ORIENTATIONSENSOR_HPP
    #define ORIENTATIONSENSOR_HPP

    #include <QObject>
    #include <QtSensors/QOrientationFilter>

    QTM_USE_NAMESPACE

    /**
     * The OrientationSensor class uses the QOrientationSensor class from the QtSensors
     * module to retrieve the current orientation/direction of the device.
     */
    class OrientationSensor : public QObject, QOrientationFilter
    {
        Q_OBJECT

        // The property to access the orientation value of the sensor
        Q_PROPERTY(Orientation orientation READ orientation NOTIFY orientationChanged)

    public:
        enum Orientation {
            Undefined = 0,
            TopUp,
            TopDown,
            LeftUp,
            RightUp,
            FaceUp,
            FaceDown
        };
        Q_ENUMS(Orientation);

        OrientationSensor(QObject *parent = 0);

        // The accessor method for the orientation property
        Orientation orientation() const;

    Q_SIGNALS:
        // The change notification signal of the orientation property
        void orientationChanged();

    protected:
        /**
         * This method is reimplemented from the QOrientationFilter interface and is
         * called by the QOrientationFilter whenever new values are available.
         */
        bool filter(QOrientationReading *reading);

    private:
        // The orientation sensor
        QOrientationSensor m_sensor;

        // The orientation value
        Orientation m_orientation;
    };

    #endif
