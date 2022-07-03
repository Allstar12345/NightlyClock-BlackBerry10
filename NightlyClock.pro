APP_NAME = NightlyClock
LIBS += -lbbmultimedia
LIBS += -lbbcascadespickers
 LIBS += -lbbdevice
 LIBS += -lbbplatform
 LIBS += -lbbsystem
    LIBS += -lcamapi
 QT += xml
    
 
 
 CONFIG += qt warn_on debug_and_release cascades mobility
    MOBILITY += sensors
 
CONFIG += qt warn_on cascades10
Qt +=network



include(config.pri)
