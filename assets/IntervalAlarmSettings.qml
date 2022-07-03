import bb.cascades 1.2
import bb.cascades.pickers 1.0
import timer 1.0
Sheet {
    id:inte
    property bool finished:false
    property int optionsInUse: 0
    onCreationCompleted: {
        open()
        bodger.start();
        
    }
    attachedObjects:[ SystemTimer {
            id: bodger
            interval: 600
            onTimeout: {
                finished=true
                togglebutton.enabled=true
                console.log("Change allowed")
                bodger.destroy()
            }
    }

]
    content: Page {
        id: page
        titleBar: TitleBar {
            appearance: TitleBarAppearance.Branded
            title: ("Interval Alarm Settings") 
            dismissAction: ActionItem {
                title: ("Close") 
                onTriggered: {inte.close();inte.destroy()
                }
            }
        }
        ScrollView {
            scrollViewProperties { scrollMode: ScrollMode.Vertical }
            id: scroller
            content:Container{ 
                id: cont
                    Container {
                      topPadding: 20;  leftPadding: 20;rightPadding: 20
                        layout: DockLayout {}
                        horizontalAlignment: HorizontalAlignment.Fill
                        Label {
                            text:"Alarm Interval Enabled"
                            verticalAlignment: VerticalAlignment.Center
                            horizontalAlignment: HorizontalAlignment.Left
                            textStyle {
                                base: SystemDefaults.TextStyles.BodyText
                                fontSize: FontSize.PointValue
                                fontSizeValue: 8
                            }
                        }
                        ToggleButton {
                            accessibility.name: "Alarm Interval Enabled Toggle"
                            enabled: false
                            id: togglebutton
                            horizontalAlignment: HorizontalAlignment.Right
                            checked: intervalAlarm? true:false
                            onCheckedChanged: {
                                if(finished===false){console.log("Denied checked changed")}
                                else if (finished===true){
                                    
                                    if(intervalAlarm===false) {intervalAlarm=true; appsettings.saveSystemSetting("intervalAlarmMode", true)}
                                    else{intervalAlarm=false; appsettings.saveSystemSetting("intervalAlarmMode", "")
                                    }
                                }
                            
                            }
                        }
                    
                    }
                
                DropDown{
                    title: "Interval Timeout"
                    onCreationCompleted: {
                        selectedIndex=parseInt(appsettings.getSystemSetting("intervalAlarmTimeoutIndex", "")) 
                    }
                    onSelectedIndexChanged: {
                       appsettings.saveSystemSetting("intervalAlarmTimeoutIndex", selectedIndex)
                       appsettings.saveSystemSetting("intervalAlarmTimeout", selectedValue);
                       appsettings.saveSystemSetting("intervalAlarmTimeoutText", selectedOption.text);

                        console.log(appsettings.getSystemSetting("intervalAlarmTimeout", ""));
                        alarmServer.soundingInterval= selectedValue;
                    }
                    Option {
                        text: "10 Seconds"
                        value:"10000"
                        description: "Alarm will sound for 10 seconds"
                    }
                    Option {
                        text: "15 Seconds"
                        value:"15000"
                        description: "Alarm will sound for 15 seconds" 
                    }
                    Option {
                        text: "20 Seconds"
                        value:"20000"
                        description: "Alarm will sound for 20 seconds"
                    }
                    Option {
                        text: "25 Seconds"
                        value:"25000"
                        description: "Alarm will sound for 25 seconds"
                    }
                    Option {
                        text: "30 Seconds"
                        value:"30000"
                        description: "Alarm will sound for 30 seconds"
                    }
                    Option {
                        text: "35 Seconds"
                        value:"35000"
                        description: "Alarm will sound for 35 seconds"
                    }
                    Option {
                        text: "40 Seconds"
                        value:"40000"
                        description: "Alarm will sound for 40 seconds"
                }
                Option {
                    text: "45 Seconds"
                    value:"45000"
                    description: "Alarm will sound for 45 seconds"
                }
                    
                    
                }
                DropDown {
                    title:"How many times to sound"
                    onCreationCompleted: {
                        selectedIndex=parseInt(appsettings.getSystemSetting("intervalAlarmTimesIndex", ""))

                    }
                    onSelectedIndexChanged: {
                        appsettings.saveSystemSetting("intervalAlarmTimesIndex", selectedIndex)
                        appsettings.saveSystemSetting("intervalHowManyToSound", selectedValue); 
                        appsettings.saveSystemSetting("intervalHowManyToSoundText", selectedOption.text);

                        alarmServer.intervalCount= selectedValue;
                    
                    }
                    Option{
                        text:"1 Time"
                        value: "1"
                        description: compactMode? "Sound 1 time, then full alarm will sound":"The Alarm will sound 1 time, then the full alarm will sound after the set time"
                    }
                    Option{
                        text:"2 Times"
                        value: "2"
                        description: compactMode? "Sound 2 times, one at a time, then full alarm will sound":"The Alarm will sound 2 times, one at a time after the set time, then the full alarm will sound"
                    }
                    Option{
                        text:"3 Times"
                        value: "3"
                        description:compactMode? "Sound 3 times, one at a time, then full alarm will sound": "The Alarm will sound 3 times, one at a time after the set time, then the full alarm will sound"
                    }
                    Option{
                        text:"4 Times"
                        value: "4"
                        description:compactMode? "Sound 4 times, one at a time, then full alarm will sound": "The Alarm will sound 4 times, one at a time after the set time, then the full alarm will sound"
                    }
                    
                }
                
                
                DropDown {
                    onCreationCompleted: {
                        selectedIndex=parseInt(appsettings.getSystemSetting("intervalAlarmBetweeenIndex", ""))
                    }
                    onSelectedIndexChanged: {
                        appsettings.saveSystemSetting("intervalAlarmBetweeenIndex", selectedIndex)
                        appsettings.saveSystemSetting("intervalTimeBetweenSounding", selectedValue); 
                        appsettings.saveSystemSetting("intervalTimeBetweenSoundingText", selectedOption.text);

                        alarmServer.intervalRestartTime= selectedValue;
                    }
                    title:"Time between sounding"
                    Option{
                        text:"1 Minute"
                        value:"60000"
                        description: "Alarm will sound after 1 Minute"
                    }
                    Option{
                        text:"2 Minutes"
                        value:"120000"
                        description: "Alarm will sound after 2 Minutes"
                    }
                    Option{
                        text:"3 Minutes"
                        value:"180000"
                        description: "Alarm will sound after 3 Minutes"
                    }
                    Option{
                        text:"4 Minutes"
                        value:"240000"
                        description: "Alarm will sound after 4 Minutes"
                    }
                    Option{
                        text:"5 Minutes"
                        value:"300000"
                        description:"Alarm will sound after 5 Minutes"
                    }
                    Option{
                        text:"10 Minutes"
                        value:"600000"
                        description: "Alarm will sound after 10 Minutes"
                    }
                    Option{
                        text:"15 Minutes"
                        value:"900000"
                        description: "Alarm will sound after 15 Minutes"
                    }
                    Option{
                        text:"20 Minutes"
                        value:"1200000"
                        description:"Alarm will sound after 20 Minutes"
                    }
                    Option{
                        text:"25 Minutes"
                        value:"1500000"
                        description: "Alarm will sound after 25 Minutes"
                    }
                    Option{
                        text:"30 Minutes"
                        value:"1800000"
                        description: "Alarm will sound after 30 Minutes"
                    }
                    Option{
                        text:"35 Minutes"
                        value:"2100000"
                        description: "Alarm will sound after 35 Minutes"
                    }
                    Option{
                        text:"40 Minutes"
                        value:"2400000"
                        description: "Alarm will sound after 40 Minutes"
                    }
                }
                }

            }  
        }
    }
