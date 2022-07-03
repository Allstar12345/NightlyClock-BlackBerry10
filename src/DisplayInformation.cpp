#include "DisplayInformation.hpp"
#include <QDebug>

namespace si
{
    namespace blackberrydev
    {
        DisplayInformation::DisplayInformation()
        {
            bb::device::DisplayInfo display;
            displayWidth = display.pixelSize().width();
            displayHeight = display.pixelSize().height();
            qDebug() << displayWidth;
            qDebug() << displayHeight;
        }

        DisplayInformation::~DisplayInformation()
        {
        }

        int DisplayInformation::getDisplayWidth()
        {
            return displayWidth;
        }

        void DisplayInformation::setDisplayWidth(int _displayWidth)
        {
            displayWidth = _displayWidth;
        }

        int DisplayInformation::getDisplayHeight()
        {
            return displayHeight;
        }

        void DisplayInformation::setDisplayHeight(int _displayHeight)
        {
            displayHeight = _displayHeight;
        }
    }
}
