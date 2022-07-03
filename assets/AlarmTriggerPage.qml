import bb.cascades 1.2
import bb.system 1.2
import QtQuick 1.0

Sheet {
id:alarmTriggerPage
peekEnabled: false
onCreationCompleted: {open();}
function stopAlarm(){alarmServer.stop(); led.cancel();close();alarmServer.stopFlash();}
content: Page {
    id: page
attachedObjects: Connections {
    target: alarmServer
    onTriggerPageClose:{stopAlarm();}
}

  titleBar: TitleBar {
    visibility: compactMode?ChromeVisibility.Hidden: ChromeVisibility.Visible
      appearance: TitleBarAppearance.Default
      kind: TitleBarKind.FreeForm
      kindProperties: FreeFormTitleBarKindProperties { 
          id: kindProperties 
          content: Container { 
              layout: DockLayout { }
              ActivityIndicator {
                  id: bufferInd
                  preferredHeight: 60  
                  preferredWidth: 60
                  running: alarmServer.audioBufferProgress===1? true:false
                  horizontalAlignment: HorizontalAlignment.Right
                  rightMargin: 10
                  verticalAlignment: VerticalAlignment.Center
              }
              Label {
                  verticalAlignment: VerticalAlignment.Center
                  horizontalAlignment: HorizontalAlignment.Center
                  text:appsettings.getSystemSetting("alarmCompletedMessage", "")===""? "Alarm!": appsettings.getSystemSetting("alarmCompletedMessage", "")
                  id: alarmMessageText
                  textStyle{
                      fontWeight: if(appsettings.getSystemSetting("fontBold", "")==="")FontWeight.Normal 
                      else FontWeight.Bold
                      fontSize: FontSize.PointValue
                      fontSizeValue: 9
                      base: SystemDefaults.TextStyles.BigText
                      color: Color.create("white")}
              }
        } 
          } 
  }
    Container{  
        id: cont
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        layout: DockLayout {}
Container{ 
    horizontalAlignment: HorizontalAlignment.Right
    rightMargin: 10
    
    verticalAlignment: VerticalAlignment.Top
    visible: compactMode? true:false
    topPadding: 100
            ActivityIndicator {
                id: bufferInd2
            
                preferredHeight: 60  
                preferredWidth: 60
                running: alarmServer.audioBufferProgress===1? true:false

            }
        }
Container {
    verticalAlignment: VerticalAlignment.Top
    visible: compactMode? true:false
    topPadding:100
    horizontalAlignment: HorizontalAlignment.Center
            Label {

                text:appsettings.getSystemSetting("alarmCompletedMessage", "")===""? "Alarm!": appsettings.getSystemSetting("alarmCompletedMessage", "")
                id: alarmMessageText2
                textStyle{
                    fontWeight: if(appsettings.getSystemSetting("fontBold", "")==="")FontWeight.Normal 
                    else FontWeight.Bold
                    fontSize: FontSize.PointValue
                    fontSizeValue: 8
                    base: SystemDefaults.TextStyles.BigText
                    color: Color.create("white")}
            }
    }
        Button{
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Top
            onClicked: {stopAlarm();}
            text: "Stop Alarm"
        }
        Button{
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Bottom
            onClicked: {
                alarmServer.stop();
                led.cancel();
                alarmTriggerPage.close();
                alarmServer.snooze();
                alarmServer.stopFlash();
                
                toast.showText("Alarm Snoozed\nTap Snooze Icon To Cancel");
            }
            text: "Snooze"
        }
        ImageView {
            imageSource: appsettings.getSystemSetting("alarmtriggerimgSource", "")===""? "asset:///images/alarmicons/TriggerPage/alarm_bbblue.png": appsettings.getSystemSetting("alarmtriggerimgSource", "")
            minHeight: compactMode? 240: 360
            minWidth:compactMode? 240: 360
            maxHeight: minHeight
            maxWidth: minWidth
            id: alarmimg
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
        
        }  
        
 
       
}
}

}