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
togglebutton.enabled=true;togglebutton1.enabled=true;togglebutton2.enabled=true;
bodge.destroy()
}
}]
content: Page {

titleBar: TitleBar {
appearance: TitleBarAppearance.Branded
title: ("Active Frame Settings") 
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
        text:"Live Active Frame"
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
        accessibility.name: "Live Active Frame Toggle"

        id: togglebutton
        horizontalAlignment: HorizontalAlignment.Right
        checked:liveActiveFrame
        onCheckedChanged: {
            if(finished===false){console.log("Denied checked changed")}
            else if (finished===true){if(liveActiveFrame===true){
                    appsettings.saveSystemSetting("liveActiveFrame", "false")
                    liveActiveFrame=false;
                    togglebutton1.enabled=false;   
                    togglebutton2.enabled=false;                
             
            }
            else{ 
                appsettings.saveSystemSetting("liveActiveFrame", "")
                liveActiveFrame=true;
                togglebutton1.enabled=true;
                togglebutton2.enabled=true;
            }}  
        }
    }

}



Container {
    topPadding: 20; leftPadding: 20;rightPadding: 20
    layout: DockLayout {}
    horizontalAlignment: HorizontalAlignment.Fill
    Label {
        text:compactMode?"Battery on Active Frame": "Show Battery Status on Active Frame"
        verticalAlignment: VerticalAlignment.Center
        horizontalAlignment: HorizontalAlignment.Left
        textStyle {
            base: SystemDefaults.TextStyles.BodyText
            fontSize: FontSize.PointValue
            fontSizeValue: 8
        }
    }

    ToggleButton {
        accessibility.name: "Show Battery Status on Active Frame"

        enabled: false
        id: togglebutton1
        horizontalAlignment: HorizontalAlignment.Right
        verticalAlignment: VerticalAlignment.Center
        checked:showActiveFrameBattery
        onCheckedChanged: {
            if(finished===false){console.log("Denied checked changed")}
            else if (finished===true){if(showActiveFrameBattery===true){appsettings.saveSystemSetting("showActiveFrameBattery", "false"); showActiveFrameBattery=false;
            }
            else{  appsettings.saveSystemSetting("showActiveFrameBattery", "");showActiveFrameBattery=true;
            
            }}  
        }
    }

}
Container {
    topPadding: 20; leftPadding: 20;rightPadding: 20
    layout: DockLayout {}
    horizontalAlignment: HorizontalAlignment.Fill
    Label {
        text:compactMode?"Next Alarm on Active Frame": "Show Next Alarm on Active Frame"
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
        id: togglebutton2
        accessibility.name: "Show Next Alarm on Active Frame"

        horizontalAlignment: HorizontalAlignment.Right
        verticalAlignment: VerticalAlignment.Center
        checked:showActiveFrameNextAlarm
        onCheckedChanged: {
            if(finished===false){console.log("Denied checked changed")}
            else if (finished===true){if(showActiveFrameNextAlarm===true){appsettings.saveSystemSetting("showActiveFrameNextAlarm", "false"); showActiveFrameNextAlarm=false;
            }
            else{  appsettings.saveSystemSetting("showActiveFrameNextAlarm", "");showActiveFrameNextAlarm=true;
            
            }}  
        }
    }

}
DropDown {
    title: "Active Frame Content Colour"
    
    onSelectedIndexChanged: {
        if(selectedIndex===0){activeFrameContentColour="clockColour"; appsettings.saveSystemSetting("activeFrameContentColour", "clockColour")}
        else{activeFrameContentColour= selectedValue;appsettings.saveSystemSetting("activeFrameContentColour",selectedValue)}
    }
Option {
        text: "Follow Clock Colour"
    }
Option {
    value: "white"
    text:"White"
    imageSource: "asset:///images/white.jpg"
}
Option {
    value:"#0092cc"
    text:"BlackBerry Blue"
    imageSource: "asset:///images/bbblue.jpg"
}
Option {
    value:"#0000ff"
    text:"Blue"
    imageSource: "asset:///images/blue.jpg"
}
Option {
    value:"#ff0000"
    text:"Red"
    imageSource: "asset:///images/red.jpg"}
Option {
    value:"#48ff00"
    text:"Green"
    imageSource: "asset:///images/green.jpg"
}
Option {
    value:"#ffff00"
    text:"Yellow"
    imageSource: "asset:///images/yellow.jpg"
}
Option {
    value:"#ffcc00"
    text:"Orange"
    imageSource: "asset:///images/orange.jpg"
}
Option {
    value:"#ff00ff"
    text:"Magenta"
    imageSource: "asset:///images/magenta.jpg"
}
Option {
    value:"#9900ff"
    text:"Purple"
    imageSource: "asset:///images/purple.jpg"
}
}
}
}
}
}