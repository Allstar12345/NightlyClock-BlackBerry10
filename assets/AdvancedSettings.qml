
import bb.cascades 1.2
import timer 1.0
import bb.cascades.pickers 1.0
Sheet {
id: ad
property bool finished:false
onCreationCompleted: {open();bodge.start();}
attachedObjects:[ SystemTimer {
        id: bodge
        interval: 600
        onTimeout: {
            finished=true
            console.log("Change allowed")
            togglebutton4.enabled=true;
            tickSound.enabled=true;
            tickSoundback.enabled=true;

            bodge.destroy()
        }
},
FilePicker {
    id: picker
    onFileSelected: {
        var bob = "file:///" + selectedFiles.toString();
        customFontURL= bob;
        creator.createQMLObject("FontChangeCloseDialog.qml")
    }
}
]
content: Page {
    
    titleBar: TitleBar {
        appearance: TitleBarAppearance.Branded
        title: ("Advanced Settings") 
        dismissAction: ActionItem {
            title: ("Close") 
            id: closeBut
            onTriggered: {
               ad.close();ad.destroy();}}
    }
    
    ScrollView {
        id: scroller

        content: Container {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Center
            id: conter
            topPadding: 20
            bottomPadding: 20
            layout: StackLayout { }
            
            Container {
                leftPadding: 20;rightPadding: 20
                layout: DockLayout {}
                horizontalAlignment: HorizontalAlignment.Fill
                Label {
                    text: compactMode? "Device facedown to PowerSave":"Place device face down to turn on Power Saving"
                    verticalAlignment: VerticalAlignment.Center 
                    horizontalAlignment: HorizontalAlignment.Left
                    textStyle {
                        base: SystemDefaults.TextStyles.BodyText
                        fontSize: FontSize.PointValue
                        fontSizeValue: 8
                    }
                }
                ToggleButton {
                    accessibility.name:"Device facedown to Powersave Toggle"
                    enabled: false
                    id: togglebutton4
                    horizontalAlignment: HorizontalAlignment.Right
                    checked:faceDownToPowerSave
                    onCheckedChanged: {
                        if(finished===false){console.log("Denied checked changed")}
                        else if (finished===true){
                            
                            if(faceDownToPowerSave===true){ faceDownToPowerSave=false; appsettings.saveSystemSetting("faceDownToPowerSave", "")}
                            
                            else{ faceDownToPowerSave=true; appsettings.saveSystemSetting("faceDownToPowerSave", "true")}
                        }  
                    }
                }
            
            }
            Container {
                leftPadding: 20;rightPadding: 20; topPadding: 15
                layout: DockLayout {}
                horizontalAlignment: HorizontalAlignment.Fill
                Label {
                    text:"Clock Ticking Sound Effect"
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
                    accessibility.name:"Clock Ticking Sound Effect Toggle"
                    id: tickSound
                    horizontalAlignment: HorizontalAlignment.Right
                    checked: tickingSound
                    onCheckedChanged: {        
                        if(finished===false){console.log("Denied checked changed")}
                        else if (finished===true){
                            if(tickingSound===true){ tickingSound=false; appsettings.saveSystemSetting("tickingSound", "");}
                            else { tickingSound=true; appsettings.saveSystemSetting("tickingSound", "true"); }
                        
                        }
                    
                    }  
                }
            }
            Container {
                opacity: tickingSound? 1:0
                
                leftPadding: 20;rightPadding: 20; topPadding: tickingSound?15:0
                layout: DockLayout {}
                minHeight: tickingSound? 140: 0
                horizontalAlignment: HorizontalAlignment.Fill
                
                Label {
                    text:"Clock Tick Volume" 
                    verticalAlignment: VerticalAlignment.Top
                    horizontalAlignment: HorizontalAlignment.Left
                    textStyle {
                        base: SystemDefaults.TextStyles.BodyText
                        fontSize: FontSize.PointValue
                        fontSizeValue: 7
                    }
                }
                Label {
                    text:Math.round(slider.immediateValue *100) + "%"
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
                    value: tickVolume
                    toValue: 1.0
                    fromValue: 0.10
                    onValueChanged: {
                        tickVolume=slider.immediateValue;appsettings.saveSystemSetting("tickVolume", slider.immediateValue)      
                    }
                }
            }
            Container {
                topPadding: tickingSound?15:0
                opacity: tickingSound? 1:0
                leftPadding: 20;rightPadding: 20
                visible: tickingSound? true:false
                layout: DockLayout {}
                horizontalAlignment: HorizontalAlignment.Fill
                Label {
                    text:"Tick When Locked/Minimised"
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Left
                    textStyle {
                        base: SystemDefaults.TextStyles.BodyText
                        fontSize: FontSize.PointValue
                        fontSizeValue: 8
                    }
                }
                ToggleButton {
                    accessibility.name:"Tick When Locked/Minimised Toggle"

                    enabled: false
                    id: tickSoundback
                    horizontalAlignment: HorizontalAlignment.Right
                    checked: tickingSoundWhenLocked
                    onCheckedChanged: {        
                        if(finished===false){console.log("Denied checked changed")}
                        else if (finished===true){
                            if(tickingSoundWhenLocked===true){ tickingSoundWhenLocked=false; appsettings.saveSystemSetting("tickingSoundWhenLocked", "");}
                            else { tickingSoundWhenLocked=true; appsettings.saveSystemSetting("tickingSoundWhenLocked", "true"); }
                        
                        }
                    
                    }  
                }
            }
            DropDown{
                accessibility.name:"Wallpaper Aspect Ratio"

                title: "Wallpaper Aspect Ratio"
                
                onCreationCompleted: {
                    if(appsettings.getSystemSetting("wallpaperRatioIndex", "")==="")selectedIndex=2
                    else{
                        selectedIndex= parseInt(appsettings.getSystemSetting("wallpaperRatioIndex", ""));}
                }
                onSelectedIndexChanged: {
                    appsettings.saveSystemSetting("wallpaperRatioIndex", selectedIndex)
                    if(selectedIndex===0){wallpaperAspectRatio=0; appsettings.saveSystemSetting("wallpaperAspectRatio", "0")}
                    if(selectedIndex===1){wallpaperAspectRatio=1; appsettings.saveSystemSetting("wallpaperAspectRatio", "1")}
                    if(selectedIndex===2){wallpaperAspectRatio=2; appsettings.saveSystemSetting("wallpaperAspectRatio", "2")} 
                }
                Option {
                    text:"AspectFit"
                    description: "Fit the image inside assigned area while keeping the correct aspect ratio"
                }
                Option {
                    text:"AspectFill"
                    description: "Stretch and crop the image to fill the entire assigned area while keeping the aspect ratio"
                }
                Option {
                    text:"Fill"
                    description: "Stretch the image to fit assigned area. "
                }
                
                
            }
            DropDown {
                title:"Clock Font"
                
                onSelectedIndexChanged: {
                    if(selectedIndex===0){customFontURL=""; creator.createQMLObject("FontChangeCloseDialog.qml")
}
                    else if(selectedIndex===1){picker.open();}
                }
                Option {
                    text: "Default"
                }
                Option {
                    text: "Custom Font"
                }
            }
       Button {
           text: "Active Frame Settings"
           horizontalAlignment: HorizontalAlignment.Fill
           onClicked: {
               creator.createQMLObject("ActiveFrameSettings.qml")
           }
       }
        }
    }
}
}