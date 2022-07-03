/*
 * Copyright (c) 2011-2014 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "applicationui.hpp"
#include <bb/cascades/Application>

#include <QTranslator>
#include <Qt/qdeclarativedebug.h>
#include "timer.hpp"
#include <bb/cascades/Window>
using namespace bb::cascades;
#include "DisplayInformation.hpp"
#include "Flashlight.hpp"
#include "setting.h"
//#include "WeatherService.hpp"
//#include "ImageDownloader.h"
#include "downloadmanager.h"







Q_DECL_EXPORT int main(int argc, char **argv)
{

    Application app(argc, argv);

    Application::instance()->mainWindow()->setScreenIdleMode(ScreenIdleMode::KeepAwake);

    qmlRegisterType<Timer> ("timer", 1, 0, "SystemTimer");
    qmlRegisterType<Flashlight>("Flashlight", 1, 0, "Flashlight");
    qmlRegisterType<Setting> ("AppSettings", 1, 0, "AppSettings");
    qmlRegisterType<DownloadManager> ("DownloadManager", 1, 0, "DownloadManager");

    //qmlRegisterType<WeatherService>("weather", 1, 0, "WeatherService");

  //  qmlRegisterType<ImageDownloader>("ImageDownloader",1, 0, "ImageDownloader");

    // Register to type to make Orientation enum accessible in QML file
        // qmlRegisterUncreatableType<OrientationSensor>("Utils", 1, 0, "OrientationSensor", "Used for enums");
//


    new ApplicationUI(&app);



    return Application::exec();

}
