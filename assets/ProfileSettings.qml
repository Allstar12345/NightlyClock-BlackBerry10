import bb.cascades 1.2
import timer 1.0

Sheet {
    id: pr
    property bool finished:false
    onCreationCompleted: { open();}
    content: Page {
        titleBar: TitleBar {
            appearance: TitleBarAppearance.Branded
            title: ("Profile Settings") 
            dismissAction: ActionItem {
                title: ("Close") 
                onTriggered: {close();pr.destroy();
                }
            }
        }
        onCreationCompleted: {bodge.start()}
        attachedObjects:[ SystemTimer {
                id: bodge
                interval: 600
                onTimeout: {
                    finished=true
                    console.log("Change allowed")
                    togglebutton.enabled=true;
                    bodge.destroy()
                }
        }
    ]
    ScrollView {
        content: Container {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Center
            id: conte
            layout: StackLayout {  }
            
            Container {
                minHeight: 125
                leftPadding: 20;rightPadding: 20
                layout: DockLayout {}
                horizontalAlignment: HorizontalAlignment.Fill
                Label {
                    text:olderFirmware ? "All Alerts Off Profile on Launch" : "Do Not Disturb Profile On Launch"
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Left
                    textStyle {
                        base: SystemDefaults.TextStyles.BodyText
                        fontSize: FontSize.PointValue
                        fontSizeValue: 8
                    }
                }
                Label {
                    text:if(compactMode===true){olderFirmware ? "Will place device into the All Alerts Off Profile on launch":"Will place the device into the Do Not Disturb Profile on Launch"
} 
                    else{ olderFirmware ? "This will place the device into the All Alerts Off Profile when Launched":"This will place the device into the Do Not Disturb Profile when Launched"
}
                        
                    opacity:0.8
                 
                    verticalAlignment: VerticalAlignment.Bottom
                  
                    horizontalAlignment: HorizontalAlignment.Left
                    textStyle {
                        base: SystemDefaults.TextStyles.BodyText
                        fontSize: FontSize.PointValue
                        fontSizeValue: 6
                    }
                }
                ToggleButton {
                    enabled: false
                    accessibility.name:olderFirmware ? "All Alerts Off Profile on Launch Toggle" : "Do Not Disturb Profile On Launch Toggle"

                    id: togglebutton
                    horizontalAlignment: HorizontalAlignment.Right
                    verticalAlignment: VerticalAlignment.Center
                    checked:appsettings.getSystemSetting("doNotDisturbOnLaunch", "")? true:false
                    onCheckedChanged: {
                       if(finished===true){
                           if(appsettings.getSystemSetting("doNotDisturbOnLaunch", "")===""){
                               appsettings.saveSystemSetting("doNotDisturbOnLaunch", "true");}  
                           else{appsettings.saveSystemSetting("doNotDisturbOnLaunch", "");}                           
                       }
                       }
                }
            
            }
          
        }
    }
    }
}