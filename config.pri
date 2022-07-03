# Config.pri file version 2.0. Auto-generated by IDE. Any changes made by user will be lost!
BASEDIR = $$quote($$_PRO_FILE_PWD_)

device {
    CONFIG(debug, debug|release) {
        profile {
            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        } else {
            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        }

    }

    CONFIG(release, debug|release) {
        !profile {
            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        }
    }
}

simulator {
    CONFIG(debug, debug|release) {
        !profile {
            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        }
    }
}

config_pri_assets {
    OTHER_FILES += \
        $$quote($$BASEDIR/assets/AboutPage.qml) \
        $$quote($$BASEDIR/assets/ActiveFrameSettings.qml) \
        $$quote($$BASEDIR/assets/AdvancedSettings.qml) \
        $$quote($$BASEDIR/assets/AlarmNotificationSettings.qml) \
        $$quote($$BASEDIR/assets/AlarmOnStartDialog.qml) \
        $$quote($$BASEDIR/assets/AlarmServer.qml) \
        $$quote($$BASEDIR/assets/AlarmSettings.qml) \
        $$quote($$BASEDIR/assets/AlarmSoundPicker.qml) \
        $$quote($$BASEDIR/assets/AlarmSoundPreviewer.qml) \
        $$quote($$BASEDIR/assets/AlarmTriggerPage.qml) \
        $$quote($$BASEDIR/assets/Cover.qml) \
        $$quote($$BASEDIR/assets/CoverOlderFirmware.qml) \
        $$quote($$BASEDIR/assets/EventServer.qml) \
        $$quote($$BASEDIR/assets/FirstRunArea.qml) \
        $$quote($$BASEDIR/assets/FontChangeCloseDialog.qml) \
        $$quote($$BASEDIR/assets/HelpToast.qml) \
        $$quote($$BASEDIR/assets/ImageFade.qml) \
        $$quote($$BASEDIR/assets/InternetAudioSource.qml) \
        $$quote($$BASEDIR/assets/IntervalAlarmSettings.qml) \
        $$quote($$BASEDIR/assets/MediaControlButton.qml) \
        $$quote($$BASEDIR/assets/MediaController.qml) \
        $$quote($$BASEDIR/assets/MediaWatcher.qml) \
        $$quote($$BASEDIR/assets/ProfileSettings.qml) \
        $$quote($$BASEDIR/assets/ReviewDialog.qml) \
        $$quote($$BASEDIR/assets/Settings.qml) \
        $$quote($$BASEDIR/assets/SnoozeSwitchDialog.qml) \
        $$quote($$BASEDIR/assets/ThumbnailAlarmTriggerDialog.qml) \
        $$quote($$BASEDIR/assets/TimeFormatSwitcher.qml) \
        $$quote($$BASEDIR/assets/WallpaperPicker.qml) \
        $$quote($$BASEDIR/assets/WeatherServer.qml) \
        $$quote($$BASEDIR/assets/alarmTime12hourValues.xml) \
        $$quote($$BASEDIR/assets/alarmtimevalues.xml) \
        $$quote($$BASEDIR/assets/images/ActiveFrame/alarm_bblue.png) \
        $$quote($$BASEDIR/assets/images/ActiveFrame/alarm_blue.png) \
        $$quote($$BASEDIR/assets/images/ActiveFrame/alarm_defaultbbblue.png) \
        $$quote($$BASEDIR/assets/images/ActiveFrame/alarm_green.png) \
        $$quote($$BASEDIR/assets/images/ActiveFrame/alarm_magenta.png) \
        $$quote($$BASEDIR/assets/images/ActiveFrame/alarm_orange.png) \
        $$quote($$BASEDIR/assets/images/ActiveFrame/alarm_purple.png) \
        $$quote($$BASEDIR/assets/images/ActiveFrame/alarm_red.png) \
        $$quote($$BASEDIR/assets/images/ActiveFrame/alarm_white.png) \
        $$quote($$BASEDIR/assets/images/ActiveFrame/alarm_yellow.png) \
        $$quote($$BASEDIR/assets/images/ActiveFrame/interval_bblue.png) \
        $$quote($$BASEDIR/assets/images/ActiveFrame/interval_blue.png) \
        $$quote($$BASEDIR/assets/images/ActiveFrame/interval_green.png) \
        $$quote($$BASEDIR/assets/images/ActiveFrame/interval_magenta.png) \
        $$quote($$BASEDIR/assets/images/ActiveFrame/interval_orange.png) \
        $$quote($$BASEDIR/assets/images/ActiveFrame/interval_purple.png) \
        $$quote($$BASEDIR/assets/images/ActiveFrame/interval_red.png) \
        $$quote($$BASEDIR/assets/images/ActiveFrame/interval_white.png) \
        $$quote($$BASEDIR/assets/images/ActiveFrame/interval_yellow.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/70plus_battery_bbblue.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/70plus_battery_blue.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/70plus_battery_green.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/70plus_battery_magenta.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/70plus_battery_orange.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/70plus_battery_purple.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/70plus_battery_red.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/70plus_battery_white.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/70plus_battery_yellow.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/full_battery_bbblue.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/full_battery_blue.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/full_battery_green.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/full_battery_magenta.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/full_battery_orange.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/full_battery_purple.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/full_battery_red.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/full_battery_white.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/full_battery_yellow.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/low_battery_bbblue.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/low_battery_blue.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/low_battery_green.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/low_battery_magenta.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/low_battery_orange.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/low_battery_purple.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/low_battery_red.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/low_battery_white.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/low_battery_yellow.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/medium_battery_bbblue.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/medium_battery_blue.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/medium_battery_green.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/medium_battery_magenta.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/medium_battery_orange.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/medium_battery_purple.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/medium_battery_red.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/medium_battery_white.png) \
        $$quote($$BASEDIR/assets/images/BatteryIcons/medium_battery_yellow.png) \
        $$quote($$BASEDIR/assets/images/IntervalIcons/bblue_interval.png) \
        $$quote($$BASEDIR/assets/images/IntervalIcons/blue_interval.png) \
        $$quote($$BASEDIR/assets/images/IntervalIcons/green_interval.png) \
        $$quote($$BASEDIR/assets/images/IntervalIcons/magenta_interval.png) \
        $$quote($$BASEDIR/assets/images/IntervalIcons/orange_interval.png) \
        $$quote($$BASEDIR/assets/images/IntervalIcons/purple_interval.png) \
        $$quote($$BASEDIR/assets/images/IntervalIcons/red_interval.png) \
        $$quote($$BASEDIR/assets/images/IntervalIcons/white_interval.png) \
        $$quote($$BASEDIR/assets/images/IntervalIcons/yellow_interval.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/back_bbblue.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/back_blue.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/back_green.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/back_magenta.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/back_orange.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/back_purple.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/back_red.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/back_white.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/back_yellow.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/pause_bbblue.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/pause_blue.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/pause_green.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/pause_magenta.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/pause_orange.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/pause_purple.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/pause_red.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/pause_white.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/pause_yellow.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/play_bbblue.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/play_blue.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/play_green.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/play_magenta.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/play_orange.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/play_purple.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/play_red.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/play_white.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/play_yellow.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/skip_bbblue.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/skip_blue.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/skip_green.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/skip_magenta.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/skip_orange.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/skip_purple.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/skip_red.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/skip_white.png) \
        $$quote($$BASEDIR/assets/images/MediaControlIcons/skip_yellow.png) \
        $$quote($$BASEDIR/assets/images/Setup/settingsMenu.png) \
        $$quote($$BASEDIR/assets/images/Setup/settingsMenuButton.png) \
        $$quote($$BASEDIR/assets/images/Setup/settingsMenuButton_Compact.png) \
        $$quote($$BASEDIR/assets/images/Setup/settingsMenu_Compact.png) \
        $$quote($$BASEDIR/assets/images/SnoozeIcons/base.svg) \
        $$quote($$BASEDIR/assets/images/SnoozeIcons/snooze_bblue.png) \
        $$quote($$BASEDIR/assets/images/SnoozeIcons/snooze_blue.png) \
        $$quote($$BASEDIR/assets/images/SnoozeIcons/snooze_green.png) \
        $$quote($$BASEDIR/assets/images/SnoozeIcons/snooze_magenta.png) \
        $$quote($$BASEDIR/assets/images/SnoozeIcons/snooze_orange.png) \
        $$quote($$BASEDIR/assets/images/SnoozeIcons/snooze_purple.png) \
        $$quote($$BASEDIR/assets/images/SnoozeIcons/snooze_red.png) \
        $$quote($$BASEDIR/assets/images/SnoozeIcons/snooze_white.png) \
        $$quote($$BASEDIR/assets/images/SnoozeIcons/snooze_yellow.png) \
        $$quote($$BASEDIR/assets/images/alarm_pulldown.png) \
        $$quote($$BASEDIR/assets/images/alarm_pulldown_small.png) \
        $$quote($$BASEDIR/assets/images/alarm_template.svg) \
        $$quote($$BASEDIR/assets/images/alarm_white.png) \
        $$quote($$BASEDIR/assets/images/alarm_white_small.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/TriggerPage/alarm_bbblue.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/TriggerPage/alarm_blue.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/TriggerPage/alarm_green.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/TriggerPage/alarm_magenta.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/TriggerPage/alarm_orange.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/TriggerPage/alarm_purple.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/TriggerPage/alarm_red.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/TriggerPage/alarm_white.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/TriggerPage/alarm_yellow.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/alarm_blue.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/alarm_defaultbbblue.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/alarm_green.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/alarm_magenta.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/alarm_orange.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/alarm_purple.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/alarm_red.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/alarm_white.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/alarm_yellow.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/interval_blue.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/interval_defaultbblue.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/interval_green.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/interval_magenta.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/interval_orange.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/interval_purple.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/interval_red.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/interval_white.png) \
        $$quote($$BASEDIR/assets/images/alarmicons/interval_yellow.png) \
        $$quote($$BASEDIR/assets/images/appicon.png) \
        $$quote($$BASEDIR/assets/images/bbblue.jpg) \
        $$quote($$BASEDIR/assets/images/blue.jpg) \
        $$quote($$BASEDIR/assets/images/cover.png) \
        $$quote($$BASEDIR/assets/images/green.jpg) \
        $$quote($$BASEDIR/assets/images/ic_info.png) \
        $$quote($$BASEDIR/assets/images/ic_notification.png) \
        $$quote($$BASEDIR/assets/images/ic_pause.png) \
        $$quote($$BASEDIR/assets/images/ic_play.png) \
        $$quote($$BASEDIR/assets/images/ic_powersaving.png) \
        $$quote($$BASEDIR/assets/images/ic_share.png) \
        $$quote($$BASEDIR/assets/images/ic_view_grid.png) \
        $$quote($$BASEDIR/assets/images/ic_view_list.png) \
        $$quote($$BASEDIR/assets/images/intervalTriggerImage.svg) \
        $$quote($$BASEDIR/assets/images/loop.png) \
        $$quote($$BASEDIR/assets/images/magenta.jpg) \
        $$quote($$BASEDIR/assets/images/orange.jpg) \
        $$quote($$BASEDIR/assets/images/powersavingTemplate.svg) \
        $$quote($$BASEDIR/assets/images/pullDownInterval.png) \
        $$quote($$BASEDIR/assets/images/purple.jpg) \
        $$quote($$BASEDIR/assets/images/red.jpg) \
        $$quote($$BASEDIR/assets/images/white.jpg) \
        $$quote($$BASEDIR/assets/images/yellow.jpg) \
        $$quote($$BASEDIR/assets/main.qml) \
        $$quote($$BASEDIR/assets/resetDialog.qml) \
        $$quote($$BASEDIR/assets/sounds/1.aac) \
        $$quote($$BASEDIR/assets/sounds/2.aac) \
        $$quote($$BASEDIR/assets/sounds/3.aac) \
        $$quote($$BASEDIR/assets/sounds/4.mp3) \
        $$quote($$BASEDIR/assets/sounds/5.mp3) \
        $$quote($$BASEDIR/assets/sounds/tick.mp3)
}

config_pri_source_group1 {
    SOURCES += \
        $$quote($$BASEDIR/src/DisplayInformation.cpp) \
        $$quote($$BASEDIR/src/Flashlight.cpp) \
        $$quote($$BASEDIR/src/OrientationSensor.cpp) \
        $$quote($$BASEDIR/src/applicationui.cpp) \
        $$quote($$BASEDIR/src/downloadmanager.cpp) \
        $$quote($$BASEDIR/src/main.cpp) \
        $$quote($$BASEDIR/src/qtsoap.cpp) \
        $$quote($$BASEDIR/src/setting.cpp) \
        $$quote($$BASEDIR/src/timer.cpp)

    HEADERS += \
        $$quote($$BASEDIR/src/DisplayInformation.hpp) \
        $$quote($$BASEDIR/src/Flashlight.hpp) \
        $$quote($$BASEDIR/src/OrientationSensor.hpp) \
        $$quote($$BASEDIR/src/applicationui.hpp) \
        $$quote($$BASEDIR/src/downloadmanager.h) \
        $$quote($$BASEDIR/src/qtsoap.h) \
        $$quote($$BASEDIR/src/setting.h) \
        $$quote($$BASEDIR/src/timer.hpp)
}

CONFIG += precompile_header

PRECOMPILED_HEADER = $$quote($$BASEDIR/precompiled.h)

lupdate_inclusion {
    SOURCES += \
        $$quote($$BASEDIR/../src/*.c) \
        $$quote($$BASEDIR/../src/*.c++) \
        $$quote($$BASEDIR/../src/*.cc) \
        $$quote($$BASEDIR/../src/*.cpp) \
        $$quote($$BASEDIR/../src/*.cxx) \
        $$quote($$BASEDIR/..//*.qml) \
        $$quote($$BASEDIR/..//*.js) \
        $$quote($$BASEDIR/..//*.qs) \
        $$quote($$BASEDIR/../assets/*.qml) \
        $$quote($$BASEDIR/../assets/*.js) \
        $$quote($$BASEDIR/../assets/*.qs) \
        $$quote($$BASEDIR/../assets/images/*.qml) \
        $$quote($$BASEDIR/../assets/images/*.js) \
        $$quote($$BASEDIR/../assets/images/*.qs) \
        $$quote($$BASEDIR/../assets/images/ActiveFrame/*.qml) \
        $$quote($$BASEDIR/../assets/images/ActiveFrame/*.js) \
        $$quote($$BASEDIR/../assets/images/ActiveFrame/*.qs) \
        $$quote($$BASEDIR/../assets/images/BatteryIcons/*.qml) \
        $$quote($$BASEDIR/../assets/images/BatteryIcons/*.js) \
        $$quote($$BASEDIR/../assets/images/BatteryIcons/*.qs) \
        $$quote($$BASEDIR/../assets/images/IntervalIcons/*.qml) \
        $$quote($$BASEDIR/../assets/images/IntervalIcons/*.js) \
        $$quote($$BASEDIR/../assets/images/IntervalIcons/*.qs) \
        $$quote($$BASEDIR/../assets/images/MediaControlIcons/*.qml) \
        $$quote($$BASEDIR/../assets/images/MediaControlIcons/*.js) \
        $$quote($$BASEDIR/../assets/images/MediaControlIcons/*.qs) \
        $$quote($$BASEDIR/../assets/images/Setup/*.qml) \
        $$quote($$BASEDIR/../assets/images/Setup/*.js) \
        $$quote($$BASEDIR/../assets/images/Setup/*.qs) \
        $$quote($$BASEDIR/../assets/images/SnoozeIcons/*.qml) \
        $$quote($$BASEDIR/../assets/images/SnoozeIcons/*.js) \
        $$quote($$BASEDIR/../assets/images/SnoozeIcons/*.qs) \
        $$quote($$BASEDIR/../assets/images/alarmicons/*.qml) \
        $$quote($$BASEDIR/../assets/images/alarmicons/*.js) \
        $$quote($$BASEDIR/../assets/images/alarmicons/*.qs) \
        $$quote($$BASEDIR/../assets/images/alarmicons/TriggerPage/*.qml) \
        $$quote($$BASEDIR/../assets/images/alarmicons/TriggerPage/*.js) \
        $$quote($$BASEDIR/../assets/images/alarmicons/TriggerPage/*.qs) \
        $$quote($$BASEDIR/../assets/sounds/*.qml) \
        $$quote($$BASEDIR/../assets/sounds/*.js) \
        $$quote($$BASEDIR/../assets/sounds/*.qs) \
        $$quote($$BASEDIR/../releases/*.qml) \
        $$quote($$BASEDIR/../releases/*.js) \
        $$quote($$BASEDIR/../releases/*.qs)

    HEADERS += \
        $$quote($$BASEDIR/../src/*.h) \
        $$quote($$BASEDIR/../src/*.h++) \
        $$quote($$BASEDIR/../src/*.hh) \
        $$quote($$BASEDIR/../src/*.hpp) \
        $$quote($$BASEDIR/../src/*.hxx)
}

TRANSLATIONS = $$quote($${TARGET}.ts)