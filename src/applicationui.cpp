#include "applicationui.hpp"


#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/SceneCover>
#include <bb/device/DisplayAspectType>
#include <QProcess>
#include <bb/platform/PlatformInfo>
#include <QDir>
#include <QFile>
#include <QDebug>
#include <QString>
//#include "OrientationSensor.hpp"
using namespace bb::cascades;
using namespace bb::platform;

ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
        QObject(app) {
    mConfig = new QNetworkConfigurationManager();

    displayInformation = new si::blackberrydev::DisplayInformation;
//    bob=  new bb::device::DisplayAspectType::Type;

PlatformInfo * info= new PlatformInfo;
bool res = QObject::connect(mConfig, SIGNAL(onlineStateChanged(bool)), this,
        SLOT(onOnlineStatusChanged(bool)));
globalCompactMode=true;

    qmlRegisterType<SceneCover>("bb.cascades", 1, 2, "SceneCover");
    qmlRegisterUncreatableType<AbstractCover>("bb.cascades", 1, 2, "AbstractCover", "");
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
    qml->setContextProperty("display", displayInformation);
    qml->setContextProperty("platinfo", info);
    qml->setContextProperty("application", app);
    QDeclarativeEngine *engine = QmlDocument::defaultDeclarativeEngine();
    QDeclarativeContext *rootContext = engine->rootContext();
    rootContext->setContextProperty("appUI", this);
    rootContext->setContextProperty("compactModeGlobal", globalCompactMode);

    const QString workingDir = QDir::currentPath();
       const QString dirPaths = QString::fromLatin1("file://%1/app/public/").arg(workingDir);
       qml->documentContext()->setContextProperty("_publicDir", dirPaths);
    AbstractPane *root = qml->createRootObject<AbstractPane>();
    Application::instance()->setScene(root);

}


void ApplicationUI::onOnlineStatusChanged(bool isOnline)
{
QString onlineStatus = isOnline ? "Online" : "Offline";
qDebug() << onlineStatus;
emit onlineModeChanged(isOnline);

}
void ApplicationUI::setGlobalCompactMode(bool value){
    globalCompactMode=value;
}


QString ApplicationUI::plsFile(const QString &source){
    QFile inputList(source);
    if (inputList.open(QIODevice::ReadOnly)){
        QTextStream in(&inputList);
        while ( !in.atEnd() ){
          QString line = in.readLine();
          if(line.at(0) == 'F'){
              while(line.at(0) != '=')
                  line.remove(0,1);
              line.remove(0,1);
              return line;
          }
        }
        inputList.close();

    }
}
QString ApplicationUI::testU(QString fileName){

    QFile inputFile(fileName);
    if (inputFile.open(QIODevice::ReadOnly))
    {
       QTextStream in(&inputFile);
       while (!in.atEnd())
       {
          QString line = in.readLine();
          qDebug() << "Output: " << line;
          return line;

       }
       inputFile.close();

    }

}


void ApplicationUI::deleteFile(const QString file){
    QFile filer(file);

    if (!filer.open(QIODevice::ReadWrite)) {
    qDebug() << "couldn't open file ReadWrite" ;
   // return false;
    }
    else{
        filer.remove(file);
        qDebug() <<"Removed";

    }
}

QString ApplicationUI::homePath(){
    return QDir::homePath();
}

