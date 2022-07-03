import bb.cascades 1.2
import bb.system 1.2
import timer 1.0
import QtQuick 1.0


Sheet {
id:alarmSheet
property bool finished:false
property bool noSeconds:false
property string alarmTimeDescription:appsettings.getSystemSetting("alarmTime", "");
property string  snoozePickerDescription: ""
property string alarmSoundDescription: ""
onCreationCompleted: {
    open();
    if(timeFormat==="hh:mm:ss"){timePicker12.visible=false;noSeconds=false; timePicker12.destroy(); cont12.remove(timePicker12); }
    else if(timeFormat==="hh:mm"){timePicker12.visible=false; noSeconds=true; timePicker12.destroy(); cont12.remove(timePicker12);}
    else if(timeFormat==="h:mm:ss AP"){timePicker24.visible=false;noSeconds=false; timePicker24.destroy();cont12.remove(timePicker24)}
    else if(timeFormat==="h:mm AP"){timePicker24.visible=false; noSeconds=true;timePicker24.destroy();cont12.remove(timePicker24)}

    bodger.start();  
    snoozePickerDescription= appsettings.getSystemSetting("alarmSnoozeTimoutDescription", "");
    alarmSoundDescription= appsettings.getSystemSetting("alarmSoundDescription", "");

}
content: Page {
id: page
titleBar: TitleBar {
appearance: TitleBarAppearance.Branded
title: ("Alarm Settings") 
dismissAction: ActionItem {
title: ("Close") 
onTriggered: {
    appsettings.saveSystemSetting("alarmCompletedMessage", alarmmessagefield.text);alarmSheet.close();alarmSheet.destroy();
}
}
}
attachedObjects:[ SystemTimer {
        id: bodger
        interval: 600
        onTimeout: {
            finished=true
            togglebutton.enabled=true; 
            togglebutton2.enabled=true;
            togglebutton3.enabled=true;

            console.log("Change allowed")
            bodger.destroy()
        }
},
Connections {
    target:paneMain
    onCompactModeChanged:{
        if(timeFormat==="hh:mm:ss"){timePicker24.setExpanded(false); }
        else if(timeFormat==="hh:mm"){timePicker24.setExpanded(false);}
        else if(timeFormat==="h:mm:ss AP"){timePicker12.setExpanded(false);}
        else if(timeFormat==="h:mm AP"){timePicker12.setExpanded(false);}
    }
}

]
ScrollView {
    scrollViewProperties { scrollMode: ScrollMode.Vertical }
id: scroller
content:Container{ 
    id: cont12
   
    topPadding: 20
    Container {
        leftPadding: 20;rightPadding: 20
        layout: DockLayout {}
        horizontalAlignment: HorizontalAlignment.Fill
        Label {
            text:"Alarm Enabled"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Left
            textStyle {
                base: SystemDefaults.TextStyles.BodyText
                fontSize: FontSize.PointValue
                fontSizeValue: 8
            }
        }
        ToggleButton {
            enabled: false
            accessibility.name: "Alarm Enabled Toggle"

            id: togglebutton
            horizontalAlignment: HorizontalAlignment.Right
            checked: alarmEnabled? true: false
            onCheckedChanged: {
                if(finished===false){console.log("Denied checked changed")}
                else{
                    if(alarmEnabled===true){
                        console.log("Disabled")
                        alarmEnabled= false;
                        console.log("State: "+ alarmEnabled)
                        appsettings.saveSystemSetting("alarmEnabled", "")
                    }
                    else{
                        console.log("Enabled")
                        alarmEnabled= true;
                        appsettings.saveSystemSetting("alarmEnabled", "true")
                        console.log("State: "+ alarmEnabled)}
                
                }
                if(alarmTime===""){toast.showText("Alarm Time is not set");  togglebutton.checked=false}
            }
        }
    }
    Container {
        topPadding: 15 ;leftPadding: 20;rightPadding: 20
        layout: DockLayout {}
        horizontalAlignment: HorizontalAlignment.Fill
        Label {
            text:if(compactMode===true){olderFirmware ? "Device face down to stop Alarm":"Place device face down to stop Alarm"
            } 
            else{ olderFirmware ? "Place device face down to stop Alarm":"Place device face down to stop Alarm"
            }
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Left
            textStyle {
                base: SystemDefaults.TextStyles.BodyText
                fontSize: FontSize.PointValue
                fontSizeValue: 8
            }
        }
        ToggleButton {
            accessibility.name: "Place device face down to stop Alarm Toggle"

            enabled: false
            id: togglebutton2
            horizontalAlignment: HorizontalAlignment.Right
            checked: faceDownToStop
            onCheckedChanged: {
                if(finished===false){console.log("Denied checked changed")}
                else if (finished===true){
                    if(faceDownToStop===true){faceDownToStop=false;appsettings.saveSystemSetting("faceDownToStop", ""); }
                    
                    else{faceDownToStop=true;appsettings.saveSystemSetting("faceDownToStop", "true"); if(appsettings.getSystemSetting("facedownAlarmEnabledWarning", "")===""){toast.showTextWithButton("Please note that this feature does not work when Nightly Clock is Minimised", "Ok", "facedownAlarmEnabledWarning") }}
                }
            } 
        }
    }
    Container {
        topPadding: 15 ;leftPadding: 20;rightPadding: 20
        layout: DockLayout {}
        horizontalAlignment: HorizontalAlignment.Fill
        Label {
            text:compactMode? "Play/Pause Key Alarm Function":"Play/Pause Key Alarm Function"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Left
            textStyle {
                base: SystemDefaults.TextStyles.BodyText
                fontSize: FontSize.PointValue
                fontSizeValue: 8
            }
        }
        ToggleButton {
            enabled: false
            id: togglebutton3
            accessibility.name: "Press Media Ket to perform a selected Alarm Function Toggle"

            horizontalAlignment: HorizontalAlignment.Right
            checked: mediaKeyToStopAlarm
            onCheckedChanged: {
                if(finished===false){console.log("Denied checked changed")}
                else if (finished===true){
                    if(mediaKeyToStopAlarm===true){mediaKeyToStopAlarm=false;appsettings.saveSystemSetting("mediaKeyToStopAlarm", ""); }
                    
                    else{mediaKeyToStopAlarm=true;appsettings.saveSystemSetting("mediaKeyToStopAlarm", "true"); }
                }
            } 
        }
    }
    DropDown {
        visible:mediaKeyToStopAlarm?true:false
        opacity: mediaKeyToStopAlarm? 1:0
        onCreationCompleted: {
            if(appsettings.getSystemSetting("mediaKeySelectedIndex", "")==="")selectedIndex=0
            else{selectedIndex=parseInt(appsettings.getSystemSetting("mediaKeySelectedIndex", ""))}
        }
        title:"Play/Pause Key Alarm Function"
        onSelectedIndexChanged: {
            if(selectedIndex===0){appsettings.saveSystemSetting("mediaKeyOption", "")}
          else if(selectedIndex===1){appsettings.saveSystemSetting("mediaKeyOption", "Snooze")}
          appsettings.saveSystemSetting("mediaKeySelectedIndex", selectedIndex)

        }
        Option {
            text: "Stop Alarm"
        }
        Option {
            text: "Snooze Alarm"
        }
    }
  
    Picker {
        topMargin: 20   
        id: timePicker24
        property string myValue: ""
        kind: PickerKind.Expandable
        title: "Alarm Time"
        description: alarmTimeDescription
        dataModel: XmlDataModel {source: "alarmtimevalues.xml"}

        pickerItemComponents: [
            
            PickerItemComponent {
                type: "hour"
                
                id: hourPicker
               Container {
                   leftPadding: appUI.getGlobalCompactMode()? 165: 300
                    id: hourPickerCont
                    horizontalAlignment: HorizontalAlignment.Center;verticalAlignment: VerticalAlignment.Center
                    layout: StackLayout {orientation: LayoutOrientation.LeftToRight}
                    Label {text: pickerItemData.value}
                }
            }, 
            PickerItemComponent {
                type: "min"
                id: minPicker
               
                 Container {
                     leftPadding: appUI.getGlobalCompactMode()? 165: 300
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    layout: StackLayout { orientation: LayoutOrientation.LeftToRight  }
                    
                    Label {
                        text: pickerItemData.value
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                    }
                }
            }
        ]
        onSelectedValueChanged: {
            var hour
            
            switch (timePicker24.selectedIndex(0)) {
                case 0:
                    hour="00"
                    break;
                case 1:
                    hour="01"
                    break;
                case 2:
                    hour="02"
                    break;
                case 3:
                    hour="03"
                    break;
                case 4:
                    hour="04"
                    break;
                case 5:
                    hour="05"
                    break;
                case 6:
                    hour="06"
                    break;
                case 7:
                    hour="07"
                    break;
                case 8:
                    hour="08"
                    break;
                case 9:
                    hour="09"
                    break;
                case 10:
                    hour="10"
                    break;
                case 11:
                    hour="11"
                    break;
                
                case 12:
                    hour="12"
                    break;
                case 13:
                    hour="13"
                    break;
                case 14:
                    hour="14"
                    break;
                case 15:
                    hour="15"
                    break;
                case 16:
                    hour="16"
                    break;
                case 17:
                    hour="17"
                    break;
                case 18:
                    hour="18"
                    break;
                case 19:
                    hour="19"
                    break;
                case 20:
                    hour="20"
                    break;
                case 21:
                    hour="21"
                    break;
                case 22:
                    hour="22"
                    break;
                case 23:
                    hour="23"
                    break;
            }
            var min
            switch (timePicker24.selectedIndex(1)) {
                case 0:
                    min="00"
                    break;
                case 1:
                    min="01"
                    break;
                case 2:
                    min="02"
                    break;
                case 3:
                    min="03"
                    break;
                case 4:
                    min="04"
                    break;
                case 5:
                    min="05"
                    break;
                case 6:
                    min="06"
                    break;
                case 7:
                    min="07"
                    break;
                case 8:
                    min="08"
                    break;
                case 9:
                    min="09"
                    break;
                case 10:
                    min="10"
                    break;
                case 11:
                    min="11"
                    break;
                case 12:
                    min="12"
                    break;
                case 13:
                    min="13"
                    break;
                case 14:
                    min="14"
                    break;
                case 15:
                    min="15"
                    break;
                case 16:
                    min="16"
                    break;
                case 17:
                    min="17"
                    break;
                case 18:
                    min="18"
                    break;
                case 19:
                    min="19"
                    break;
                case 20:
                    min="20"
                    break;
                case 21:
                    min="21"
                    break;
                case 22:
                    min="22"
                    break;
                case 23:
                    min="23"
                    break;
                case 24:
                    min="24"
                    break;
                case 25:
                    min="25"
                    break;
                case 26:
                    min="26"
                    break;
                case 27:
                    min="27"
                    break;
                case 28:
                    min="28"
                    break;
                case 29:
                    min="29"
                    break;
                case 30:
                    min="30"
                    break;
                case 31:
                    min="31"
                    break;
                case 32:
                    min="32"
                    break;
                case 33:
                    min="33"
                    break;
                case 34:
                    min="34"
                    break;
                case 35:
                    min="35"
                    break;
                case 36:
                    min="36"
                    break;
                case 37:
                    min="37"
                    break;
                case 38:
                    min="38"
                    break;
                case 39:
                    min="39"
                    break;
                case 40:
                    min="40"
                    break;
                case 41:
                    min="41"
                    break;
                case 42:
                    min="42"
                    break;
                case 43:
                    min="43"
                    break;
                case 44:
                    min="44"
                    break;
                case 45:
                    min="45"
                    break;
                case 46:
                    min="46"
                    break;
                case 47:
                    min="47"
                    break;             
                case 48:
                    min="48"
                    break;
                case 49:
                    min="49"
                    break;
                case 50:
                    min="50"
                    break;
                case 51:
                    min="51"
                    break;
                case 52:
                    min="52"
                    break;
                case 53:
                    min="53"
                    break;
                case 54:
                    min="54"
                    break;
                case 55:
                    min="55"
                    break;
                case 56:
                    min="56"
                    break;
                case 57:
                    min="57"
                    break;
                case 58:
                    min="58"
                    break;
                case 59:
                    min="59"
                    break;
            }
            if(noSeconds===true){ alarmTimeDescription= hour + ":" + min; appsettings.saveSystemSetting("alarmTime", hour + ":" +min ); }
            
            else{ alarmTimeDescription= hour + ":" + min + ":" + "00"; appsettings.saveSystemSetting("alarmTime", hour + ":" + min + ":" + "00");}
            
            timePicker24.description= alarmTimeDescription;

            console.log( "ALARM TIME SETTINGS "+ appsettings.getSystemSetting("alarmTime", "")) 
            alarmTime=appsettings.getSystemSetting("alarmTime", "")
            console.log("String " + alarmTime)
        }         
    }    
    
    
    
    Picker {
        topMargin: 20   
        id: timePicker12
        property string myValue: ""
        kind: PickerKind.Expandable
        title: "Alarm Time"
        description: alarmTimeDescription
        dataModel: XmlDataModel {source: "alarmTime12hourValues.xml"}
        
        pickerItemComponents: [
            PickerItemComponent {
                type: "hour"
                id: hourPicker12
                Container {
                    leftPadding: appUI.getGlobalCompactMode()? 165: 300

                    horizontalAlignment: HorizontalAlignment.Left;verticalAlignment: VerticalAlignment.Center
                    layout: DockLayout {}
                    Label {text: pickerItemData.value}
                    Container {
                        bottomPadding: 18
                        verticalAlignment: VerticalAlignment.Bottom
                    Label {text:pickerItemData.format; opacity: 0.7; 
                        textStyle {
                            base:SystemDefaults.TextStyles.SubtitleText
                            color: Color.White
                        }}
                }
                }
            }, 
            PickerItemComponent {
                type: "min"
                id: minPicker12
                 Container {
                     leftPadding: appUI.getGlobalCompactMode()? 165: 300

                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    layout: StackLayout { orientation: LayoutOrientation.LeftToRight  }
                    
                    Label {
                        text: pickerItemData.value
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                    }
                }
            }
        ]
        onSelectedValueChanged: {
            var hour
            var format
            
            switch (timePicker12.selectedIndex(0)) {
                case 0:
                    hour="1"
                    format= "AM"
                    break;
                case 1:
                    hour="2"
                    format= "AM"
                    break;
                case 2:
                    hour="3"
                    format= "AM"
                    break;
                case 3:
                    hour="4"
                    format= "AM"
                    break;
                case 4:
                    hour="5"
                    format= "AM"
                    break;
                case 5:
                    hour="6"
                    format= "AM"
                    break;
                case 6:
                    hour="7"
                    format= "AM"
                    break;
                case 7:
                    hour="8"
                    format= "AM"
                    break;
                case 8:
                    hour="9"
                    format= "AM"
                    break;
                case 9:
                    hour="10"
                    format= "AM"
                    break;
                case 10:
                    hour="11"
                    format= "AM"
                    break;
                case 11:
                    hour="12"
                    format= "AM"
                    break;
                
                case 12:
                    hour="1"
                    format= "PM"
                    break;
                case 13:
                    hour="2"
                    format= "PM"
                    break;
                case 14:
                    hour="3"
                    format= "PM"
                    break;
                case 15:
                    hour="4"
                    format= "PM"
                    break;
                case 16:
                    hour="5"
                    format= "PM"
                    break;
                case 17:
                    hour="6"
                    format= "PM"
                    break;
                case 18:
                    hour="7"
                    format= "PM"
                    break;
                case 19:
                    hour="8"
                    format= "PM"
                    break;
                case 20:
                    hour="9"
                    format= "PM"
                    break;
                case 21:
                    hour="10"
                    format= "PM"
                    break;
                case 22:
                    hour="11"
                    format= "PM"
                    break;
                case 23:
                    hour="12"
                    format= "PM"
                    break;
            }
            var min
            switch (timePicker12.selectedIndex(1)) {
                case 0:
                    min="00"
                    break;
                case 1:
                    min="01"
                    break;
                case 2:
                    min="02"
                    break;
                case 3:
                    min="03"
                    break;
                case 4:
                    min="04"
                    break;
                case 5:
                    min="05"
                    break;
                case 6:
                    min="06"
                    break;
                case 7:
                    min="07"
                    break;
                case 8:
                    min="08"
                    break;
                case 9:
                    min="09"
                    break;
                case 10:
                    min="10"
                    break;
                case 11:
                    min="11"
                    break;
                case 12:
                    min="12"
                    break;
                case 13:
                    min="13"
                    break;
                case 14:
                    min="14"
                    break;
                case 15:
                    min="15"
                    break;
                case 16:
                    min="16"
                    break;
                case 17:
                    min="17"
                    break;
                case 18:
                    min="18"
                    break;
                case 19:
                    min="19"
                    break;
                case 20:
                    min="20"
                    break;
                case 21:
                    min="21"
                    break;
                case 22:
                    min="22"
                    break;
                case 23:
                    min="23"
                    break;
                case 24:
                    min="24"
                    break;
                case 25:
                    min="25"
                    break;
                case 26:
                    min="26"
                    break;
                case 27:
                    min="27"
                    break;
                case 28:
                    min="28"
                    break;
                case 29:
                    min="29"
                    break;
                case 30:
                    min="30"
                    break;
                case 31:
                    min="31"
                    break;
                case 32:
                    min="32"
                    break;
                case 33:
                    min="33"
                    break;
                case 34:
                    min="34"
                    break;
                case 35:
                    min="35"
                    break;
                case 36:
                    min="36"
                    break;
                case 37:
                    min="37"
                    break;
                case 38:
                    min="38"
                    break;
                case 39:
                    min="39"
                    break;
                case 40:
                    min="40"
                    break;
                case 41:
                    min="41"
                    break;
                case 42:
                    min="42"
                    break;
                case 43:
                    min="43"
                    break;
                case 44:
                    min="44"
                    break;
                case 45:
                    min="45"
                    break;
                case 46:
                    min="46"
                    break;
                case 47:
                    min="47"
                    break;             
                case 48:
                    min="48"
                    break;
                case 49:
                    min="49"
                    break;
                case 50:
                    min="50"
                    break;
                case 51:
                    min="51"
                    break;
                case 52:
                    min="52"
                    break;
                case 53:
                    min="53"
                    break;
                case 54:
                    min="54"
                    break;
                case 55:
                    min="55"
                    break;
                case 56:
                    min="56"
                    break;
                case 57:
                    min="57"
                    break;
                case 58:
                    min="58"
                    break;
                case 59:
                    min="59"
                    break;
            }
            if(noSeconds===true){ alarmTimeDescription= hour + ":" + min; appsettings.saveSystemSetting("alarmTime", hour + ":" +min +" "+ format ); }
            else{ alarmTimeDescription= hour + ":" + min + ":" + "00"; appsettings.saveSystemSetting("alarmTime", hour + ":" +min + " " + format);}
            timePicker12.description= alarmTimeDescription;
            console.log( "ALARM TIME SETTINGS "+ appsettings.getSystemSetting("alarmTime", "")) 
            alarmTime=appsettings.getSystemSetting("alarmTime", "")
            console.log("String " + alarmTime)
        }         
    }    
    
DropDown {
    onCreationCompleted: {
        if(appsettings.getSystemSetting("alarmSnoozeTimeoutIndex", "")==="") selectedIndex=1
        else{
        selectedIndex=parseInt(appsettings.getSystemSetting("alarmSnoozeTimeoutIndex", ""))
        }
    }
    onSelectedIndexChanged: {
        alarmSnoozeTimeout=selectedValue;
        appsettings.saveSystemSetting("alarmSnoozeTimeout", selectedValue);
        appsettings.saveSystemSetting("alarmSnoozeTimeoutIndex", selectedIndex)
        console.log(alarmSnoozeTimeout);
    }
    id: snoozepicker
    title: "Snooze Timeout"
    topMargin: 20
Option {
    text: "1 Minute"
    value:"60000"
}
Option {
    text: "5 Minutes"
    value:"300000"
}
Option {
    text: "10 Minutes"
    value:"600000"
}
Option {
    text: "15 Minutes"
    value:"900000"
}
Option {
    text: "20 Minutes"
    value:"1200000"
}
Option {
text: "25 Minutes"
value:"1500000"
}
Option {
    text: "30 Minutes"
    value:"1800000"
}
Option {
    text: "35 Minutes"
    value:"2100000"
}
Option {
    text: "40 Minutes"
    value:"2400000"
}
Option {
    text: "45 Minutes"
    value:"2700000"
}
}

Button {
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    text: "Interval Alarm"
    onClicked:{   var ale = notif.createObject()}
    attachedObjects: ComponentDefinition {
        id:notif;
        source: "IntervalAlarmSettings.qml"
    }
}
Button {
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    text: "Alarm Notification Settings"
    onClicked:{   var ale = inter.createObject()}
    attachedObjects: ComponentDefinition {
        id:inter;
        source: "AlarmNotificationSettings.qml"
    }
}

Header {
    title: "Alarm Message"
}
TextField {
  horizontalAlignment: HorizontalAlignment.Fill
  verticalAlignment: VerticalAlignment.Fill

    maximumLength:30
    id: alarmmessagefield
    text: appsettings.getSystemSetting("alarmCompletedMessage", "")===""? "": appsettings.getSystemSetting("alarmCompletedMessage", "")
    onVisibleChanged: {
        console.log("VISIBLE" + visible)
    }
    onFocusedChanged: {
        console.log("FOCUS" + focused)
    }
    hintText: "Message to show when alarm is sounded"
}
}  
}
}
}