#ifndef DisplayInformation_HPP_
#define DisplayInformation_HPP_

#include <QObject>
#include <QString>
#include <bb/device/DisplayInfo>

namespace si
{
	namespace blackberrydev
	{
	    class DisplayInformation: public QObject
	    {
	        Q_OBJECT

public:
	        DisplayInformation();
	        ~DisplayInformation();

	        Q_PROPERTY(int displayWidth READ getDisplayWidth WRITE setDisplayWidth NOTIFY displayWidthChanged)
	        Q_PROPERTY(int displayHeight READ getDisplayHeight WRITE setDisplayHeight NOTIFY displayHeightChanged)

	        Q_INVOKABLE	int getDisplayWidth();
	        Q_INVOKABLE void setDisplayWidth(int);

	        Q_INVOKABLE int getDisplayHeight();
	        Q_INVOKABLE void setDisplayHeight(int);
	        int displayWidth;
	                    int displayHeight;

signals:
	        void displayWidthChanged();
	        void displayHeightChanged();

private:


	    };
	}
}

#endif
