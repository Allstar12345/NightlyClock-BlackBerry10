#include "Flashlight.hpp"
#include <QDebug>
Flashlight::Flashlight(QObject * parent)
: QObject(parent)
, m_enabled(false)
{
// Acquire access to the camera hardware
const camera_error_t error = camera_open(CAMERA_UNIT_REAR, CAMERA_MODE_PREAD | CAMERA_MODE_PWRITE, &m_camera);
if (CAMERA_EOK != error) {
qDebug() << "Failed to open camera";
}
}
Flashlight::~Flashlight()
{
// Release access to the camera hardware
camera_close(m_camera);
}
void Flashlight::setEnabled(bool enabled)
{
if (m_enabled == enabled)
return;
m_enabled = enabled;
// Switch the flash light on/off depending on the value of the 'enabled' property
const camera_videolightmode_t mode = (m_enabled ? CAMERA_VIDEOLIGHT_ON : CAMERA_VIDEOLIGHT_OFF);
const camera_error_t error = camera_config_videolight(m_camera, mode);
if (CAMERA_EOK != error) {
qDebug() << "Failed to toggle the front camera video light";
}
emit enabledChanged(m_enabled);
}
bool Flashlight::enabled() const
{
return m_enabled;
}
