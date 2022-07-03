import bb.cascades 1.2
import bb.system 1.2
Sheet {
    id:firstrun
    peekEnabled: false
    property int step: 1
    onCreationCompleted: {open();}
    content: Page {
        id: page
        titleBar: TitleBar {
            id: titlebar
            appearance: TitleBarAppearance.Branded
            title: ("Welcome to Nightly Clock") 
            dismissAction: ActionItem {
                title: ("Close") 
                id: closebut
                onTriggered: {
                    if(title==="Close") {firstrun.close(); appsettings.saveSystemSetting("firstrun", true);firstrun.destroy(250);firstRunTip.start();}
                    else{
                        step-=1;
                        if(step===1){nextbut.step1()}
                     else if (step===2) {nextbut.step2();}
                     else if (step===3) {nextbut.step3();}
                     else if (step===4) {nextbut.step4();}
                    }
                }
            }
            acceptAction: ActionItem {
                id: nextbut
                title:"Next"
                function step1(){iconImage.opacity=1; titlebar.title= "Welcome to Nightly Clock";accessSettLabel.opacity=0; closebut.title="Close"; accessSettImg.opacity=0;butclockLabel.opacity=0; accessSettButImg.opacity=0; accessSettLabelButt.opacity=0;step3text.opacity=0;}
                function step2(){iconImage.opacity=0; titlebar.title="Using Nightly Clock"; closebut.title= "Back";step3text.opacity=0;accessSettLabel.opacity=1;accessSettImg.opacity=1;butclockLabel.opacity=0.8; accessSettButImg.opacity=1; accessSettLabelButt.opacity=1; step3text.opacity=0}
                function step3() {titlebar.title="How we use Permissions";accessSettLabel.opacity=0;accessSettImg.opacity=0;butclockLabel.opacity=0; accessSettButImg.opacity=0; accessSettLabelButt.opacity=0; step3text.opacity=1}
                function step4() {titlebar.title="Important Information";nextbut.title="Next"; step3text.opacity=0; step4text.opacity=1; ;nextbut.title="Finish"; }
                function step5() {appsettings.saveSystemSetting("firstrun", true); firstRunTip.start();firstrun.close(); firstrun.destroy(250)}
                onTriggered: {
                    step+=1;
                    if(step== 2) {step2();}
                    else if (step==3) {step3();}
                    else if (step==4) {step4();}
                    else if (step==5){step5();}
                }
            }
        }
        Container {
            layout: DockLayout {
            
            }
        ImageView {
            id: iconImage
            minHeight: 410
            minWidth: 410
            layoutProperties: StackLayoutProperties {}
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            imageSource: "images/appicon.png"
        }
        Label {
            opacity: 0
            id: accessSettLabel
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Top
            multiline: true
            text:"Access Settings Menu by Pulling down from the top of the screen"
            textStyle{
                fontWeight: FontWeight.Bold
                fontSize: FontSize.PointValue
                fontSizeValue: 8
                base: SystemDefaults.TextStyles.BigText
                color: Color.create("white")}
        }
        Container {
            topPadding: 75
            verticalAlignment: VerticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Center
        ImageView{
            id: accessSettImg
            opacity:0
            imageSource:compactMode? "asset:///images/Setup/settingsMenu_Compact.png": "asset:///images/Setup/settingsMenu.png"
        }
    }
        
        Container {
            topPadding: 225
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Top
        Label { 
            id: butclockLabel
            opacity: 0
            multiline: true
            text:"The Settings Menu is only available on the main clock view"
            textStyle{
                fontSizeValue: 8
                color: Color.create("Red")
                fontSize: FontSize.PointValue
                fontWeight: FontWeight.Bold
                base: SystemDefaults.TextStyles.BigText
              }}
        
        }
        Container {
            topPadding: 305
            verticalAlignment: VerticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Center
            ImageView{
                id: accessSettButImg
                opacity:0
                imageSource:compactMode? "asset:///images/Setup/settingsMenuButton_Compact.png": "asset:///images/Setup/settingsMenuButton.png"
            }
        }
        Container {
            topPadding: 460
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Top
        Label {
            opacity: 0
            multiline: true
            id: accessSettLabelButt
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Top
            text: "Press a Button Once to use its feature, the Three Middle Buttons Toggle features"
            textStyle{
                fontWeight: FontWeight.Bold
                fontSize: FontSize.PointValue
                fontSizeValue: 8
                base: SystemDefaults.TextStyles.BigText
                color: Color.create("white")}
        }
    }
        Label{
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Top
            id: step3text
            opacity:0
            multiline: true
            text:"<html>Nightly Clock like other Apps uses Permissions which allows it to access features in the OS, it is vital these Permissions are allowed.\n\n•<b>Shared Files:</b> This allows you to choose a custom external Alarm Sound and a Custom Wallpaper\n\n<strong>•Camera:</strong> This is used to access the Rear Flash Light for Alarm Notifications\n\n<strong>•Notifications Control:</strong> This allows the Application to change the devices Profile into the All Alerts Off/Do Not Disturb Profile when launched, if enabled from the Applications Settings</html>"
            textStyle{
               // fontWeight: FontWeight.Bold
                fontSize: FontSize.PointValue
                fontSizeValue: 7.5
                base: SystemDefaults.TextStyles.BigText
                color: Color.create("white")} 
        }
        Label{
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Top
            id: step4text
            opacity:0
            multiline: true
            text:"<html>Since Nightly Clock is a bedside clock the screen will always stay on to display itself, But BlackBerry 10 does not allow Applications to extend the OS Lock Time unless you enable it, without this enabled the device would auto lock with Nightly Clock Running.\n\n<b>Please go to: Device Settings-Security and Privacy- Device Password- 'Allow Apps to Extend Password Lock Time' and click the Toggle Button into the 'On' position.</b></html>"
            textStyle{
                // fontWeight: FontWeight.Bold
                fontSize: FontSize.PointValue
                fontSizeValue: 7.5
                base: SystemDefaults.TextStyles.BigText
                color: Color.create("white")} 
        }
          
    }
    }
}

