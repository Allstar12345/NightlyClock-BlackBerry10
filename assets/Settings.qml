import bb.cascades 1.2
import timer 1.0

Sheet {
id: settingsSheet
property bool finished:false
content: Page {
    actionBarVisibility:ChromeVisibility.Visible
    actions: [
        ActionItem {
            id: active
            title: "Advanced Settings"
            imageSource: "asset:///images/ic_view_list.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: { creator.createQMLObject("AdvancedSettings.qml")}
        },
        ActionItem {
            id: alarm
            title: "Alarm Settings"
            imageSource: "asset:///images/alarm_white_small.png"
            ActionBar.placement: if(olderFirmware===true)ActionBarPlacement.OnBar
            else{ActionBarPlacement.Signature}
            onTriggered: { creator.createQMLObject("AlarmSettings.qml")}
        },
        ActionItem {
            id: profile
            title: "Profile Settings"
            imageSource: "asset:///images/ic_notification.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: { creator.createQMLObject("ProfileSettings.qml")}
        }
     
      
    ]
titleBar: TitleBar {
appearance: TitleBarAppearance.Branded
title: ("Settings") 
dismissAction: ActionItem {
title: ("Close") 
id: closeBut
onTriggered: {
    settingsSheet.close();settingsSheet.destroy();}}
acceptAction: ActionItem {
    id: actionOne
    title:"Reset App"
    onTriggered: { creator.createQMLObject("resetDialog.qml")}
}
}
onCreationCompleted: {open();bodge.start(); 
 }
    attachedObjects:[ SystemTimer {
        id: bodge
        interval: 600
        onTimeout: {
            if(compactMode===false){
            
         if(appsettings.getSystemSetting("SettingsStart", "")===""){
                toast.showTextWithButton("Scroll Down for more Settings", "Ok", "SettingsStart")}
     }
        finished=true;
        console.log("Change allowed");
        togglebutton.enabled=true;
        togglebutton2.enabled=true;
        togglebutton4.enabled=true;

        bodge.destroy();
        }
    }
    ]
    ScrollView {
    
    content: Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Center
        id: conterr
        topPadding: 15
        bottomPadding: 15
        layout: StackLayout { }

        Container {
            leftPadding: 20;rightPadding: 20
            layout: DockLayout {}
            horizontalAlignment: HorizontalAlignment.Fill
            Label {
                text:"Bold Font"
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Left
                textStyle {
                    base: SystemDefaults.TextStyles.BodyText
                    fontSize: FontSize.PointValue
                    fontSizeValue: 8
                }
            }
            ToggleButton {
                accessibility.name:"Bold Font Toggle"
                enabled: false
                id: togglebutton
                horizontalAlignment: HorizontalAlignment.Right
                checked: boldFont
                onCheckedChanged: {
                    if(finished===true){
                if(boldFont===true){boldFont=false; appsettings.saveSystemSetting("fontBold", "")}
                else{boldFont=true; appsettings.saveSystemSetting("fontBold", "true")}    
                
                }
                }
            }
        }
        
        Container {

            topPadding: 15 ;leftPadding: 20;rightPadding: 20
            layout: DockLayout {}
            horizontalAlignment: HorizontalAlignment.Fill
            Label {
                text:"Music Player Controls"
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Left
                textStyle {
                    base: SystemDefaults.TextStyles.BodyText
                    fontSize: FontSize.PointValue
                    fontSizeValue: 8
                }
            }
            ToggleButton {
                accessibility.name:"Music Player Controls Toggle"

                enabled: false
                id: togglebutton2
                horizontalAlignment: HorizontalAlignment.Right
                checked: mediaControls? true:false
                onCheckedChanged: {
                    if(finished===false){console.log("Denied checked changed")}
                    else if (finished===true){
                        console.log("1" +mediaControls)
                        if(mediaControls===true) {
                            
                            mediaControls=false
                            console.log("2" +mediaControls)
                      appsettings.saveSystemSetting("mediaControls", false)
                        }
                        else{ 
                            console.log("3" +mediaControls)
                            mediaControls=true;
                            appsettings.saveSystemSetting("mediaControls", "")
                        
                        }
                    }
                } 
            }
        }
    

        Container {
            topPadding: 15 ;leftPadding: 20;rightPadding: 20
            layout: DockLayout {}
            horizontalAlignment: HorizontalAlignment.Fill
            Label {
                text:"Show Date"
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Left
                textStyle {base: SystemDefaults.TextStyles.BodyText;fontSize: FontSize.PointValue;fontSizeValue: 8}
            }
            ToggleButton {
                accessibility.name:"Show Date Toggle"

                enabled: false
                id: togglebutton4
                horizontalAlignment: HorizontalAlignment.Right
                checked: dateVisible
                onCheckedChanged: {
                    if(finished===false){console.log("Denied checked changed")}
                    else if (finished===true){
                        if(dateVisible===true){dateVisible=false;appsettings.saveSystemSetting("dateVisible", "false")}
                        else{dateVisible=true;appsettings.saveSystemSetting("dateVisible", "") }
                    }
                } 
            }
        
        }
        Container {
            leftPadding: 20;rightPadding: 20; topPadding: 15
            layout: DockLayout {}
            minHeight: 120
            horizontalAlignment: HorizontalAlignment.Fill
            Label {
                text:"Main View Brightness:"
                verticalAlignment: VerticalAlignment.Top
                horizontalAlignment: HorizontalAlignment.Left
                textStyle {
                    base: SystemDefaults.TextStyles.BodyText
                    fontSize: FontSize.PointValue
                    fontSizeValue: 7
                }
            }
            Label {
                text:Math.round(mainViewBrightness*100)+ "%"
                verticalAlignment: VerticalAlignment.Top
                horizontalAlignment: HorizontalAlignment.Right
                textStyle {
                    base: SystemDefaults.TextStyles.BodyText
                    fontSize: FontSize.PointValue
                    fontSizeValue: 6
                }
            }
            Slider {
                id:slider
                verticalAlignment: VerticalAlignment.Bottom
                horizontalAlignment: HorizontalAlignment.Fill
                value: mainViewBrightness
                toValue:1
                fromValue: 0.3 
                onValueChanged: {mainViewBrightness=slider.immediateValue;appsettings.saveSystemSetting("mainViewBrightness", immediateValue)}
            }
        }

        
        DropDown {
            title: "Time Format"
            onSelectedIndexChanged: {
                if(alarmTime===""){} else{creator.createQMLObject("TimeFormatSwitcher.qml")}
                timeFormat=selectedValue; appsettings.saveSystemSetting("timeFormat", selectedValue)
            }
            Option {
                text: "24 Hour with Seconds" 
                description: Qt.formatDateTime(new Date(), "hh:mm:ss")
                value: "hh:mm:ss"
            }
            Option {
                text: "24 Hour without Seconds" 
                description: Qt.formatDateTime(new Date(), "hh:mm")
                value: "hh:mm"
            }
            Option {
                text: "12 Hour with Seconds" 
                description: Qt.formatDateTime(new Date(), "h:mm:ss AP")
                value: "h:mm:ss AP"
            }
            Option {
                text: "12 Hour without Seconds" 
                description: Qt.formatDateTime(new Date(), "h:mm AP")
                value: "h:mm AP"
            }
        }
       DropDown {
           title:"Background Image"
           attachedObjects: ComponentDefinition {                     
               id: dd                 
               source: "WallpaperPicker.qml" }
           onSelectedIndexChanged: {
               if(selectedIndex===0){appsettings.saveSystemSetting("appWallpaper", "");albumArtWallpaper=false;
                   wallpaper="";}
                   else if(selectedIndex===1){albumArtWallpaper=false; var dp = dd.createObject()}
                   else if(selectedIndex===2)albumArtWallpaper=true;
           }
           
           Option {
               text: "Default Black Background"
           }
           
           Option {
               text:"Custom Image"
           }
           Option {
               text:"Now Playing Album Art"
           }
           
        }

        DropDown{
            title:"Clock Colour"
            onCreationCompleted: {
                if(appsettings.getSystemSetting("clockColourIndex", "")==="")selectedIndex=2
                else{
                selectedIndex= parseInt(appsettings.getSystemSetting("clockColourIndex", ""));}
            }
            onSelectedIndexChanged: {
                appsettings.saveSystemSetting("clockColourIndex", selectedIndex)
            }
            Option{
                id: loop
                text:"Loop Through Colours"
                description: "Colour will change every 5 minutes"
                imageSource: "asset:///images/loop.png"
                onSelectedChanged: {
                    if(selected){
                        colour = "white";
                        appsettings.saveSystemSetting("alarmimgSource", "asset:///images/alarmicons/alarm_white.png")
                        appsettings.saveSystemSetting("intervalIconSource", "asset:///images/alarmicons/interval_white.png")
                        appsettings.saveSystemSetting("alarmtriggerimgSource", "asset:///images/alarmicons/TriggerPage/alarm_white.png")
                        appsettings.saveSystemSetting("clockColour", "white")
                        alarmImage.imageSource= intervalAlarm?"asset:///images/alarmicons/interval_white.png": "asset:///images/alarmicons/alarm_white.png";
                        randomColourDecider.start();
                        appsettings.saveSystemSetting("loopColours", "true");
                        timelabel.textStyle.color=  Color.create(colour);
                        datelabel.textStyle.color= Color.create(colour);
                        batteryPercentage.textStyle.color = Color.create(colour);
                        paneMain.getBatteryIconSource();
                        paneMain.getLedColour();
                        if(olderFirmware===false)     decideApplicationtheme()

                    }
                    
                }
            }
            Option{
                id: white
                value: "white"
                text:"White"
                imageSource: "asset:///images/white.jpg"
                onSelectedChanged: {
                    if(selected){
                        colour = "white";
                        appsettings.saveSystemSetting("alarmimgSource", "asset:///images/alarmicons/alarm_white.png")
                        appsettings.saveSystemSetting("intervalIconSource", "asset:///images/alarmicons/interval_white.png")
                        appsettings.saveSystemSetting("alarmtriggerimgSource", "asset:///images/alarmicons/TriggerPage/alarm_white.png")
                        appsettings.saveSystemSetting("clockColour", "white")
                        alarmImage.imageSource= intervalAlarm?"asset:///images/alarmicons/interval_white.png": "asset:///images/alarmicons/alarm_white.png";
                        randomColourDecider.stop();
                        appsettings.saveSystemSetting("loopColours", "");
                        timelabel.textStyle.color=  Color.create(colour)
                        datelabel.textStyle.color= Color.create(colour)
                        batteryPercentage.textStyle.color = Color.create(colour)
                        paneMain.getBatteryIconSource();
                        paneMain.getLedColour();
                       
                        if(olderFirmware===false) decideApplicationtheme()
                    }
                }
            }
            Option{
                id: bblue
                value:"#0092cc"
                text:"BlackBerry Blue"
                imageSource: "asset:///images/bbblue.jpg"
                onSelectedChanged: {
                    if(selected){
                        colour= "#0092cc"
                        appsettings.saveSystemSetting("alarmimgSource", "asset:///images/alarmicons/alarm_defaultbbblue.png");
                        appsettings.saveSystemSetting("intervalIconSource", "asset:///images/alarmicons/interval_defaultbblue.png");
                        appsettings.saveSystemSetting("alarmtriggerimgSource", "asset:///images/alarmicons/TriggerPage/alarm_bbblue.png");
                        appsettings.saveSystemSetting("clockColour", bblue.value);
                        appsettings.saveSystemSetting("loopColours", "");
                        alarmImage.imageSource= intervalAlarm?"asset:///images/alarmicons/interval_defaultbblue.png": "asset:///images/alarmicons/alarm_defaultbbblue.png";
                        randomColourDecider.stop();
                        timelabel.textStyle.color=  Color.create(colour)
                        datelabel.textStyle.color= Color.create(colour)
                        batteryPercentage.textStyle.color = Color.create(colour)
                        paneMain.getBatteryIconSource();
                        paneMain.getLedColour(); 
                        if(olderFirmware===false)       decideApplicationtheme()

                        
                    }
                }
            }
            Option{
                id: blue
                value:"#0000ff"
                text:"Blue"
                imageSource: "asset:///images/blue.jpg"
                onSelectedChanged: {
                if(selected){
                    colour= "#0000ff"
                    appsettings.saveSystemSetting("alarmimgSource", "asset:///images/alarmicons/alarm_blue.png");
                    appsettings.saveSystemSetting("intervalIconSource", "asset:///images/alarmicons/interval_blue.png");
                    appsettings.saveSystemSetting("alarmtriggerimgSource", "asset:///images/alarmicons/TriggerPage/alarm_blue.png");
                    appsettings.saveSystemSetting("clockColour", blue.value);
                    appsettings.saveSystemSetting("loopColours", "");
                    alarmImage.imageSource= intervalAlarm?"asset:///images/alarmicons/interval_blue.png": "asset:///images/alarmicons/alarm_blue.png";
                    randomColourDecider.stop();
                    timelabel.textStyle.color=  Color.create(colour);
                    datelabel.textStyle.color= Color.create(colour);
                    batteryPercentage.textStyle.color = Color.create(colour);
                    paneMain.getBatteryIconSource();
                    paneMain.getLedColour(); 
                    if(olderFirmware===false)  decideApplicationtheme()
                }
            }
            }
            Option{
                id: red
                value:"#ff0000"
                text:"Red"
                imageSource: "asset:///images/red.jpg"
                onSelectedChanged: {
                    if(selected){
                        colour= "#ff0000"
                        appsettings.saveSystemSetting("alarmimgSource", "asset:///images/alarmicons/alarm_red.png");
                        appsettings.saveSystemSetting("intervalIconSource", "asset:///images/alarmicons/interval_red.png");
                        appsettings.saveSystemSetting("alarmtriggerimgSource", "asset:///images/alarmicons/TriggerPage/alarm_red.png");
                        appsettings.saveSystemSetting("clockColour", red.value);
                        appsettings.saveSystemSetting("loopColours", "");
                        alarmImage.imageSource= intervalAlarm?"asset:///images/alarmicons/interval_red.png": "asset:///images/alarmicons/alarm_red.png";
                        randomColourDecider.stop();
                        timelabel.textStyle.color=  Color.create(colour);
                        datelabel.textStyle.color= Color.create(colour);
                        batteryPercentage.textStyle.color = Color.create(colour);
                        paneMain.getBatteryIconSource();
                        paneMain.getLedColour(); 
                        if(olderFirmware===false)    decideApplicationtheme()
                    }
                }
            }
            Option{
                id: green
                value:"#48ff00"
                text:"Green"
                imageSource: "asset:///images/green.jpg"
                
                onSelectedChanged: {
                    if(selected){
                        colour= "#48ff00"
                        appsettings.saveSystemSetting("alarmimgSource", "asset:///images/alarmicons/alarm_green.png");
                        appsettings.saveSystemSetting("intervalIconSource", "asset:///images/alarmicons/interval_green.png");
                        appsettings.saveSystemSetting("alarmtriggerimgSource", "asset:///images/alarmicons/TriggerPage/alarm_green.png");
                        appsettings.saveSystemSetting("clockColour", green.value);
                        appsettings.saveSystemSetting("loopColours", "");
                        alarmImage.imageSource= intervalAlarm?"asset:///images/alarmicons/interval_green.png": "asset:///images/alarmicons/alarm_green.png";
                        randomColourDecider.stop();
                        timelabel.textStyle.color=  Color.create(colour);
                        datelabel.textStyle.color= Color.create(colour);
                        batteryPercentage.textStyle.color = Color.create(colour);
                        paneMain.getBatteryIconSource();
                        paneMain.getLedColour(); 
                        if(olderFirmware===false)   decideApplicationtheme()
                    }
                }
            }
            Option{
                id: yellow
                value:"#ffff00"
                text:"Yellow"
                imageSource: "asset:///images/yellow.jpg"
                
                onSelectedChanged: {
                    if(selected){
                        colour= "#ffff00"
                        appsettings.saveSystemSetting("alarmimgSource", "asset:///images/alarmicons/alarm_yellow.png");
                        appsettings.saveSystemSetting("intervalIconSource", "asset:///images/alarmicons/interval_yellow.png");
                        appsettings.saveSystemSetting("alarmtriggerimgSource", "asset:///images/alarmicons/TriggerPage/alarm_yellow.png");
                        appsettings.saveSystemSetting("clockColour", yellow.value);
                        appsettings.saveSystemSetting("loopColours", "");
                        alarmImage.imageSource= intervalAlarm?"asset:///images/alarmicons/interval_yellow.png": "asset:///images/alarmicons/alarm_yellow.png";
                        randomColourDecider.stop();
                        timelabel.textStyle.color=  Color.create(colour);
                        datelabel.textStyle.color= Color.create(colour);
                        batteryPercentage.textStyle.color = Color.create(colour);
                        paneMain.getBatteryIconSource();
                        paneMain.getLedColour(); 
                        if(olderFirmware===false)    decideApplicationtheme()
                    }
                }
                
            }
            Option{
                id: orange
                value:"#ffcc00"
                text:"Orange"
                imageSource: "asset:///images/orange.jpg"
                onSelectedChanged: {
                    if(selected){
                        colour= "#ffcc00"
                        appsettings.saveSystemSetting("alarmimgSource", "asset:///images/alarmicons/alarm_orange.png");
                        appsettings.saveSystemSetting("intervalIconSource", "asset:///images/alarmicons/interval_orange.png");
                        appsettings.saveSystemSetting("alarmtriggerimgSource", "asset:///images/alarmicons/TriggerPage/alarm_orange.png");
                        appsettings.saveSystemSetting("clockColour", orange.value);
                        appsettings.saveSystemSetting("loopColours", "");
                        alarmImage.imageSource= intervalAlarm?"asset:///images/alarmicons/interval_orange.png": "asset:///images/alarmicons/alarm_orange.png";
                        randomColourDecider.stop();
                        timelabel.textStyle.color=  Color.create(colour)
                        datelabel.textStyle.color= Color.create(colour)
                        batteryPercentage.textStyle.color = Color.create(colour)
                        paneMain.getBatteryIconSource();
                        paneMain.getLedColour(); 
                        if(olderFirmware===false) decideApplicationtheme()
                    }
                }
            }
            Option{
                id: magenta
                value:"#ff00ff"
                text:"Magenta"
                imageSource: "asset:///images/magenta.jpg"
                
                onSelectedChanged: {
                    if(selected){
                        colour= "#ff00ff"
                        appsettings.saveSystemSetting("alarmimgSource", "asset:///images/alarmicons/alarm_magenta.png");
                        appsettings.saveSystemSetting("intervalIconSource", "asset:///images/alarmicons/interval_magenta.png");
                        appsettings.saveSystemSetting("alarmtriggerimgSource", "asset:///images/alarmicons/TriggerPage/alarm_magenta.png");
                        appsettings.saveSystemSetting("clockColour", magenta.value);
                        appsettings.saveSystemSetting("loopColours", "");
                        alarmImage.imageSource= intervalAlarm?"asset:///images/alarmicons/interval_magenta.png": "asset:///images/alarmicons/alarm_magenta.png";
                        randomColourDecider.stop();
                        timelabel.textStyle.color=  Color.create(colour);
                        datelabel.textStyle.color= Color.create(colour);
                        batteryPercentage.textStyle.color = Color.create(colour);
                        paneMain.getBatteryIconSource();
                        paneMain.getLedColour(); 
                        if(olderFirmware===false)   decideApplicationtheme()

                    }
                }
                
            }
            Option{
                id:purple
                value:"#9900ff"
                text:"Purple"
                imageSource: "asset:///images/purple.jpg"
                
                onSelectedChanged: {
                    if(selected){
                        colour= "#9900ff"
                        appsettings.saveSystemSetting("alarmimgSource", "asset:///images/alarmicons/alarm_purple.png");
                        appsettings.saveSystemSetting("intervalIconSource", "asset:///images/alarmicons/interval_purple.png");
                        appsettings.saveSystemSetting("alarmtriggerimgSource", "asset:///images/alarmicons/TriggerPage/alarm_purple.png");
                        appsettings.saveSystemSetting("clockColour", purple.value);
                        appsettings.saveSystemSetting("loopColours", "");
                        alarmImage.imageSource= intervalAlarm?"asset:///images/alarmicons/interval_purple.png": "asset:///images/alarmicons/alarm_purple.png";
                        randomColourDecider.stop();
                        timelabel.textStyle.color=  Color.create(colour);
                        datelabel.textStyle.color= Color.create(colour);
                        batteryPercentage.textStyle.color = Color.create(colour);
                        paneMain.getBatteryIconSource();
                        paneMain.getLedColour(); 
                        if(olderFirmware===false)    decideApplicationtheme()
                    }
                }
            }
        }
        DropDown {
            title:"Clock Size"
            onSelectedIndexChanged: {
                appsettings.saveSystemSetting("fontSize", selectedValue);
                  fsize=selectedValue;}
            Option{
                text:"Large"
                description: "Largest Clock Size"
                value:"55" 
            }
            Option{
                text:"Medium"
                description: "Medium Clock Size"
                value:"49" 
            }
            Option{
                text:"Small"
                description: "Small Clock Size"
                value:"45" 
            }
            Option{
                text:"Very Small"
                description: "Smallest Clock Size"
                value:"42" 
            }
        }
        
        DropDown {
            title: "Date Format"
            id: dateformat
            visible: dateVisible?true:false
            onCreationCompleted: {selectedIndex=parseInt(appsettings.getSystemSetting("dateFormatIndex", ""));}
            onSelectedIndexChanged: {
                appsettings.saveSystemSetting("dateFormatIndex", selectedIndex)
                appsettings.saveSystemSetting("dateFormat", selectedValue)
                dateFormat=selectedValue;
                datelabel=Qt.formatDateTime (new Date(), dateFormat);
            }
           
            Option{
                text: Qt.formatDateTime (new Date(), "dd/MM/yyyy")
                description: "dd/MM/yyyy"
                value:"dd/MM/yyyy"
            }
            Option{
                text: Qt.formatDateTime (new Date(), "MM/dd/yyyy")
                description: "MM/dd/yyyy"
                value:"MM/dd/yyyy"
            }
            Option{
                text: Qt.formatDateTime (new Date(), "yyyy/MM/dd")
                description: "yyyy/MM/dd"
                value:"yyyy/MM/dd"
            }
            Option{
                text: Qt.formatDateTime (new Date(), "yyyy/dd/MM")
                description: "yyyy/dd/MM"
                value:"yyyy/dd/MM"
            }
            Option{
                text: Qt.formatDateTime (new Date(), "dd/MMMM/yy")
                description: "dd/MMMM/yy"
                value:"dd/MMMM/yy"
            }
            Option{
                text: Qt.formatDateTime (new Date(), "dddd/MM/yy")
                description: "dddd/MM/yy"
                value:"dddd/MM/yy"
            }
            Option{
                text: Qt.formatDateTime (new Date(), "dd/MM/yy")
                description: "dd/MM/yy"
                value:"dd/MM/yy"
            }
            Option{
                text: Qt.formatDateTime (new Date(), "MM/dd/yy")
                description: "MM/dd/yy"
                value:"MM/dd/yy"
            }
            Option{
                text: Qt.formatDateTime (new Date(), "yy/dd/MM")
                description: "yy/dd/MM"
                value:"yy/dd/MM"
            }
            Option{
                text: Qt.formatDateTime (new Date(), "yy/MM/dd")
                description: "yy/MM/dd"
                value:"yy/MM/dd"
            }
            Option{
                text: Qt.formatDateTime (new Date(), "dd.MM.yyyy")
                description: "dd.MM.yyyy"
                value:"dd.MM.yyyy"
            }
            
        }
}
  }   
   
}
}
