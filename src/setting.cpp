    #include "setting.h"
    #include <QSettings>
    #include <Qstring>
    #include <QDebug>

    Setting::Setting(QObject *parent):
     QObject(parent)
    {
    }


    QString Setting::getSystemSetting(QString name, QString defaultValue){
        QSettings settings("NightlyClock");
        return settings.value(name, defaultValue).toString();
    }
    void Setting::saveSystemSetting(QString name,QString data){
         QSettings settings("NightlyClock");
         settings.setValue(name, data);
    }
    void Setting::dropSettings(){
        QSettings settings("NightlyClock");
        settings.remove("");
    }




