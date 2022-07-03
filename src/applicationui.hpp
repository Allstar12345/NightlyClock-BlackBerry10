#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <QObject>
#include <bb/cascades/Application>
#include "DisplayInformation.hpp"



using namespace ::bb::cascades;

class ApplicationUI : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool globalCompactMode READ getGlobalCompactMode  NOTIFY globalChanged)

public:
  Q_INVOKABLE  ApplicationUI(bb::cascades::Application *app);
    virtual ~ApplicationUI() { }
    bool globalCompactMode;
    Q_INVOKABLE  bool getGlobalCompactMode() { return globalCompactMode; }
    Q_INVOKABLE void setGlobalCompactMode(bool value);
    Q_INVOKABLE QString testU(QString bob);
    Q_INVOKABLE QString plsFile(const QString &source);
    Q_INVOKABLE QString homePath();
    Q_INVOKABLE void deleteFile(const QString file);
    Q_INVOKABLE void onOnlineStatusChanged(bool isOnline);


    Q_SIGNALS:
    Q_INVOKABLE void m3uFileData(QString data);
    Q_INVOKABLE void onlineModeChanged(bool isOnline);




signals:
void globalChanged();

private:
  //  bb::device::DisplayAspectType::Type *bob;

    si::blackberrydev::DisplayInformation *displayInformation;
    QNetworkConfigurationManager* mConfig;


    private slots:


};

#endif /* ApplicationUI_HPP_ */
