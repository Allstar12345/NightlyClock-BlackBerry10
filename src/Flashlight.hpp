#ifndef FLASHLIGHT_HPP
#define FLASHLIGHT_HPP
#include <QObject>
#include <camera/camera_api.h>
class Flashlight: public QObject
{
Q_OBJECT
// Defines whether the flash light of the camera is enabled or not
Q_PROPERTY(bool enabled READ enabled WRITE setEnabled NOTIFY enabledChanged)
public:
Flashlight(QObject *parent = 0);
~Flashlight();
// The accessor methods for the property
void setEnabled(bool enabled);
bool enabled() const;
Q_SIGNALS:
// The change notification signal of the property
void enabledChanged(bool);
private:
// The property value
bool m_enabled;
// The handle for the camera device
camera_handle_t m_camera;
};
#endif
