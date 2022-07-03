import bb.cascades 1.2
import bb.cascades.pickers 1.0
import timer 1.0
Sheet {
    id:notifications
  property bool finished:false
    onCreationCompleted: { open();bodger.start(); }
    attachedObjects:[
     
        SystemTimer {
            id: bodger
            interval: 600
            onTimeout: {
                finished=true;
                cameralight.enabled=true;
                fadetog.enabled=true;
                led.enabled=true;
                console.log("Change allowed");
                bodger.destroy();
            }
    }
]
    content: Page {
        id: page
        titleBar: TitleBar {
            appearance: TitleBarAppearance.Branded
            title: ("Alarm Notification Settings") 
            dismissAction: ActionItem {
                title: ("Close") 
                onTriggered: {appsettings.saveSystemSetting("flashLightSpeed", slider.immediateValue);notifications.close();notifications.destroy()
                }
            }
        }
    ScrollView {
        scrollViewProperties { scrollMode: ScrollMode.Vertical }
        id: scroller
        content:Container{ 
            id: cont
            topPadding: 20
            Container {
                leftPadding: 20;rightPadding: 20
                layout: DockLayout {}
                horizontalAlignment: HorizontalAlignment.Fill
                Label {
                    text:"Fade In Alarm Sound"
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
                    accessibility.name: "Fade In Alarm Sound Toggle"

                    id: fadetog
                    horizontalAlignment: HorizontalAlignment.Right
                    checked: appsettings.getSystemSetting("fadeAudio", "")===""? false: true
                    onCheckedChanged: {        
                        if(finished===false){console.log("Denied checked changed")}
                        else if (finished===true){
                           if(appsettings.getSystemSetting("fadeAudio", "")===""){
                               appsettings.saveSystemSetting("fadeAudio", "true")
                           }
                           else{
                               appsettings.saveSystemSetting("fadeAudio", "")
                           }
                        }
                    
                    }  
                }
            }
            Container {
                leftPadding: 20;rightPadding: 20; topPadding: 20
                layout: DockLayout {}
                horizontalAlignment: HorizontalAlignment.Fill
                Label {
                    text:"Flash Notification LED"
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
                    id: led
                    accessibility.name: "Flash Notification LED Toggle"

                    horizontalAlignment: HorizontalAlignment.Right
                    checked: flashLED
                    onCheckedChanged: {        
                        if(finished===false){console.log("Denied checked changed")}
                        else if (finished===true){
                           
                            if(flashLED==true) {
                                flashLED=false;
                                console.log("1 " +flashLED)
                                appsettings.saveSystemSetting("flashLED", "false")
                            }
                            else{ 
                                flashLED=true;
                                console.log("1 " +flashLED)
                                appsettings.saveSystemSetting("flashLED", "")
                            
                            }
                        }
                    
                    }  
                }
            }
            Container {
                leftPadding: 20;rightPadding: 20; topPadding: 20
                layout: DockLayout {}
                horizontalAlignment: HorizontalAlignment.Fill
                Label {
                    text:"Flash Camera Light"
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Left
                    textStyle {
                        base: SystemDefaults.TextStyles.BodyText
                        fontSize: FontSize.PointValue
                        fontSizeValue: 8
                    }
                }
                ToggleButton {
                    accessibility.name: "Flash Camera Light Toggle"

                   enabled: false
                    id: cameralight
                    horizontalAlignment: HorizontalAlignment.Right
                    checked: flashLight
                    onCheckedChanged: {        
                       if(finished===false){console.log("Denied checked changed")}
                        else if (finished===true){
                            console.log("1" +flashLight)
                            if(flashLight===true) {
                                flashLight=false;
                                appsettings.saveSystemSetting("flashlight", "false")
                            }
                            else{ 
                                flashLight=true;
                                appsettings.saveSystemSetting("flashlight", "")

                            }
                        }
                    
                    }  
                }
            }
            Container {
                visible:flashLight?  slider.immediateValue===1000?false:true: false
verticalAlignment: VerticalAlignment.Fill
horizontalAlignment: HorizontalAlignment.Center
            
            Button {
                text: "Reset Flash Speed"
                onClicked: {
                    flashSpeed=1000;
                }
            }
        }
            Container {
                opacity: flashLight? 1:0
                
                leftPadding: 20;rightPadding: 20; topPadding: flashLight?10:0
                layout: DockLayout {}
                minHeight: flashLight? 140: 0
                horizontalAlignment: HorizontalAlignment.Fill
               
                Label {
                    function valueText(){
                        if(slider.immediateValue<500)return "Very Fast"
                         if(slider.immediateValue<1000) return "Fast"
                         if(slider.immediateValue===1000) return "Default"
                         if(slider.immediateValue>1000) return "Slow"
                        else return "Error"
                    }
                    text:"Camera Light Flash Speed: " + valueText();
                    verticalAlignment: VerticalAlignment.Top
                    horizontalAlignment: HorizontalAlignment.Left
                    textStyle {
                        base: SystemDefaults.TextStyles.BodyText
                        fontSize: FontSize.PointValue
                        fontSizeValue: 7
                    }
                }
                Label {
                    text:Math.round(slider.immediateValue *1)
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
                value: flashSpeed
                toValue: 5000
                fromValue: 100
                onValueChanged: {
                    flashSpeed=slider.immediateValue;
                    
                }
            }
        }
            DropDown {
                id:  sounddrop
                title: "Alarm Sound (Hold To Preview)"
                attachedObjects: [ComponentDefinition {                     
                    id: dd                 
                    source: "AlarmSoundPicker.qml" }
                , ComponentDefinition {                     
                    id: prb                  
                    source: "InternetAudioSource.qml" }]
                onSelectedIndexChanged: {
                    if(selectedIndex=== 0) { dd.createObject()
                      }
                    else if (selectedIndex===1) {alarmSound= "asset:///sounds/1.aac";
                        appsettings.saveSystemSetting("alarmSound", alarmSound);appsettings.saveSystemSetting("alarmSoundInternet", ""); toast.showText("Alarm Sound One Selected");}
                        else if(selectedIndex===2){alarmSound= "asset:///sounds/2.aac";
                        appsettings.saveSystemSetting("alarmSound", alarmSound);appsettings.saveSystemSetting("alarmSoundInternet", "");toast.showText("Alarm Sound Two Selected");}
                        else if(selectedIndex===3) {alarmSound= "asset:///sounds/3.aac";
                        appsettings.saveSystemSetting("alarmSound", alarmSound);appsettings.saveSystemSetting("alarmSoundInternet", "");toast.showText("Alarm Sound Three Selected");}
                        else if(selectedIndex===4) {alarmSound= "asset:///sounds/4.mp3";
                        appsettings.saveSystemSetting("alarmSound", alarmSound);appsettings.saveSystemSetting("alarmSoundInternet", ""); toast.showText("Alarm Sound Four Selected");}
                        else if(selectedIndex===5) {alarmSound= "asset:///sounds/5.mp3";
                        appsettings.saveSystemSetting("alarmSound", alarmSound);appsettings.saveSystemSetting("alarmSoundInternet", "");toast.showText("Alarm Sound Five Selected");}
                        else if(selectedIndex===6)  prb.createObject()
                }
                
                contextActions:   ActionSet {
                    title: "Menu"
                    ActionItem {
                        imageSource: "asset:///images/ic_play.png"
                        title:"Preview Sounds"
                        onTriggered: {
                           creator.createQMLObject("AlarmSoundPreviewer.qml")
                        }
                    }
                }
                Option {
                    value: "custom"
                    text: "Custom Alarm Sound"
                    description: "Allows you to use a local song/file as your Alarm sound"                
                }
                
                Option{
                    text:"Alarm Sound 1"
                    value: 1
                }
                Option{
                    text:"Alarm Sound 2"
                    value: 2
                }
                Option{
                    text:"Alarm Sound 3"
                    value: 3
                }
                Option{
                    text:"Alarm Sound 4"
                    value: 4
                }
                Option{
                    text:"Alarm Sound 5"
                    value: 5
                }
                Option {
                    text:"Internet File"
                }
            }
            DropDown {
                id: vibrateDropDown
                title: "Vibration Duration"
                onCreationCompleted: {
                    if(appsettings.getSystemSetting("vibrationDurationIndex", "")==="")selectedIndex=5
                    else{
                    selectedIndex=parseInt(appsettings.getSystemSetting("vibrationDurationIndex", ""))}
                }
                
                onSelectedIndexChanged: {
                    appsettings.saveSystemSetting("vibrationDurationIndex", selectedIndex)

                    if(selectedIndex=== 0) {appsettings.saveSystemSetting("VibrationDuration", "0")}
                    else if (selectedIndex===1) {appsettings.saveSystemSetting("VibrationDuration", "1000")}
                    else if(selectedIndex===2){appsettings.saveSystemSetting("VibrationDuration", "2000")}
                    else if(selectedIndex===3) {appsettings.saveSystemSetting("VibrationDuration", "3000")}
                    else if(selectedIndex===4) {appsettings.saveSystemSetting("VibrationDuration", "4000")}
                    else if(selectedIndex===5) {appsettings.saveSystemSetting("VibrationDuration", "5000")}
                    console.log("DURATION " + appsettings.getSystemSetting("VibrationDuration", ""))
                    vibrationDuration=  appsettings.getSystemSetting("VibrationDuration", "")
                }
                Option {
                    text:"Vibration Disabled"
                }
                Option {
                    text:"1 Second"
                }
                Option {
                    text:"2 Seconds"
                }
                Option {
                    text:"3 Seconds"
                }
                Option {
                    text:"4 Seconds"
                }
                Option {
                    text:"5 Seconds"
                }
        }  
    }
    }
}
}