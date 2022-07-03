import bb.cascades 1.3

MultiCover {
    id: multiCover
    
    SceneCover {
        id: large
        MultiCover.level: CoverDetailLevel.High
        content: Container {
            background: Color.create("#000000")
            layout: DockLayout {}
            ImageView {
                visible: liveActiveFrame==false?true:false
                layoutProperties: StackLayoutProperties {}
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                maxHeight: 250 
                maxWidth: 250
                minHeight:250
                minWidth: 250
                imageSource: "images/appicon.png"
            }
            Container{
                background: Color.Black
                visible:  liveActiveFrame
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Top
                preferredHeight:100
                layout: DockLayout {
                }
                
                Container {
                    id: clockCont
                    horizontalAlignment: HorizontalAlignment.Center
                    leftPadding: 5
                    verticalAlignment: VerticalAlignment.Top
                    topPadding: 3
                    Label {
                        text:  clockTime
                        textStyle{
                            color: activeFrameContentColour==="clockColour"? Color.create(colour): Color.create(activeFrameContentColour)
                            fontSize: FontSize.PointValue
                            fontSizeValue:  if(timeFormat==="hh:mm:ss"){
                                if(keyboardDeviceNonPassport===true){
                                  return 10;
                                }
                                else{
                                    return 13;
                                }
                            }
                            else if(timeFormat==="hh:mm"){
                                if(keyboardDeviceNonPassport===true){
                                    return 16;
                                }
                                else{  return 15;}
                            }
                            
                            else if(timeFormat==="h:mm:ss AP"){
                                if(keyboardDeviceNonPassport===true){
                                    return 12;
                                }
                                else{
                                    return 12;
                                
                                }
                            }
                            
                            else  if(timeFormat==="h:mm AP"){
                                if(keyboardDeviceNonPassport===true){
                                    return 14;
                                }
                                else{   return 14;}
                            }
                            
                            }
                        
                    }
                }
                Container {
                    id:subTitleCont
                    leftPadding: 5
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Bottom
                    bottomPadding: passport?0:1
                    opacity: 0.9
                    Label {
                        textStyle{
                            color: activeFrameContentColour==="clockColour"? Color.create(colour): Color.create(activeFrameContentColour)

                            fontSize: FontSize.PointValue
                            fontSizeValue: passport?5:6 }
                        text: datelabel.text
                    }
                }
                Divider { }
            
            }
            ImageView {
                visible: liveActiveFrame
                opacity:alarmServer.snoozed? 1:0
                layoutProperties: StackLayoutProperties {}
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                minHeight:compactMode? 85:95
                minWidth: compactMode? 85:95
                imageSource: "asset:///images/SnoozeIcons/snooze_white.png" 
            }
            ImageView {
                visible: liveActiveFrame
                opacity:alarmEnabled? 1:0
                layoutProperties: StackLayoutProperties {}
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                minHeight:compactMode? 85:95
                minWidth:compactMode? 85:95
                imageSource:if(intervalAlarm===true){
                    if(activeFrameContentColour==="clockColour"){
                        if(colour==="white")return "asset:///images/ActiveFrame/interval_white.png";
                        else if(colour==="#0092cc")return "asset:///images/ActiveFrame/interval_bblue.png";
                        else if (colour==="#0000ff")return "asset:///images/ActiveFrame/interval_blue.png";
                        else if (colour==="#ff0000")return "asset:///images/ActiveFrame/interval_red.png";
                        else if (colour==="#48ff00")return "asset:///images/ActiveFrame/interval_green.png";
                        else if (colour==="#ffff00")return "asset:///images/ActiveFrame/interval_yellow.png";
                        else if (colour==="#ffcc00")return "asset:///images/ActiveFrame/interval_orange.png";
                        else if (colour==="#ff00ff")return "asset:///images/ActiveFrame/interval_magenta.png";
                        else if (colour==="#9900ff")return "asset:///images/ActiveFrame/interval_purple.png";
                    }
                   else if(activeFrameContentColour==="white")return "asset:///images/ActiveFrame/interval_white.png";
                    else if(activeFrameContentColour==="#0092cc")return "asset:///images/ActiveFrame/interval_bblue.png";
                    else if (activeFrameContentColour==="#0000ff")return "asset:///images/ActiveFrame/interval_blue.png";

                    else if (activeFrameContentColour==="#ff0000")return "asset:///images/ActiveFrame/interval_red.png";
                    else if (activeFrameContentColour==="#48ff00")return "asset:///images/ActiveFrame/interval_green.png";
                    else if (activeFrameContentColour==="#ffff00")return "asset:///images/ActiveFrame/interval_yellow.png";
                    else if (activeFrameContentColour==="#ffcc00")return "asset:///images/ActiveFrame/interval_orange.png";
                    else if (activeFrameContentColour==="#ff00ff")return "asset:///images/ActiveFrame/interval_magenta.png";
                    else if (activeFrameContentColour==="#9900ff")return "asset:///images/ActiveFrame/interval_purple.png";

                }
                else{
                    if(activeFrameContentColour==="clockColour"){
                        if(colour==="white")return "asset:///images/ActiveFrame/alarm_white.png";
                        else if(colour==="#0092cc")return "asset:///images/ActiveFrame/alarm_bblue.png";
                        else if (colour==="#0000ff")return "asset:///images/ActiveFrame/alarm_blue.png";
                        else if (colour==="#ff0000")return "asset:///images/ActiveFrame/alarm_red.png";
                        else if (colour==="#48ff00")return "asset:///images/ActiveFrame/alarm_green.png";
                        else if (colour==="#ffff00")return "asset:///images/ActiveFrame/alarm_yellow.png";
                        else if (colour==="#ffcc00")return "asset:///images/ActiveFrame/alarm_orange.png";
                        else if (colour==="#ff00ff")return "asset:///images/ActiveFrame/alarm_magenta.png";
                        else if (colour==="#9900ff")return "asset:///images/ActiveFrame/alarm_purple.png";
                    }
                    else if(activeFrameContentColour==="white")return "asset:///images/ActiveFrame/alarm_white.png";
                    else if(activeFrameContentColour==="#0092cc")return "asset:///images/ActiveFrame/alarm_bblue.png";
                    else if (activeFrameContentColour==="#0000ff")return "asset:///images/ActiveFrame/alarm_blue.png";
                    else if (activeFrameContentColour==="#ff0000")return "asset:///images/ActiveFrame/alarm_red.png";
                    else if (activeFrameContentColour==="#48ff00")return "asset:///images/ActiveFrame/alarm_green.png";
                    else if (activeFrameContentColour==="#ffff00")return "asset:///images/ActiveFrame/alarm_yellow.png";
                    else if (activeFrameContentColour==="#ffcc00")return "asset:///images/ActiveFrame/alarm_orange.png";
                    else if (activeFrameContentColour==="#ff00ff")return "asset:///images/ActiveFrame/alarm_magenta.png";
                    else if (activeFrameContentColour==="#9900ff")return "asset:///images/ActiveFrame/alarm_purple.png";
                }  
                    }

                    
                  //  intervalAlarm?"asset:///images/coverInterval.png":"asset:///images/alarmicons/alarm_white.png" 
                  
                  Container {
                      layout: DockLayout {
                          
                      }
                      leftPadding: 1
                      rightPadding: 1
                      horizontalAlignment: HorizontalAlignment.Fill
                      verticalAlignment: VerticalAlignment.Bottom
                      minHeight: 100
                  
                    Label {
                        visible: liveActiveFrame
                        horizontalAlignment:alarmEnabled? showActiveFrameNextAlarm? HorizontalAlignment.Left: HorizontalAlignment.Center :HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Bottom
                        multiline: true
                        textStyle.color:activeFrameContentColour==="clockColour"? Color.create(colour): Color.create(activeFrameContentColour)
                        opacity: showActiveFrameBattery? 1:0
                        textStyle.fontSize: FontSize.PointValue
                        textStyle.fontSizeValue: compactMode?6: 8
                        textFit.mode: textFit.mode.FitToBounds
                        text:alarmEnabled? showActiveFrameNextAlarm? "Batt: " + battery.level + "%" : "Battery: " + battery.level + "%" : "Battery: " + battery.level + "%"
                    }
            Label {
                visible: liveActiveFrame
                horizontalAlignment: showActiveFrameBattery? HorizontalAlignment.Right: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Bottom
                multiline: true
                opacity: showActiveFrameNextAlarm?1:0
                textStyle.color:activeFrameContentColour==="clockColour"? Color.create(colour): Color.create(activeFrameContentColour)

                textStyle.fontSize: FontSize.PointValue
                textStyle.fontSizeValue: compactMode?6: 8
                textFit.mode: textFit.mode.FitToBounds
                text: alarmEnabled? "Next Alarm:\n" : ""
            }
            Label {
                visible: liveActiveFrame
                horizontalAlignment:  showActiveFrameBattery? HorizontalAlignment.Right: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Bottom
                opacity: showActiveFrameNextAlarm? 1:0
                multiline: false
                textStyle.color: activeFrameContentColour==="clockColour"? Color.create(colour): Color.create(activeFrameContentColour)

                textStyle.fontSize: FontSize.PointValue
                textStyle.fontSizeValue: compactMode?6: 8
                textFit.mode: textFit.mode.FitToBounds
                text: alarmEnabled? alarmTime : ""
            }
        }
        }
    }
    
    SceneCover{
        id: small
        MultiCover.level: CoverDetailLevel.Medium
        content: Container {
            background: Color.create("#000000")
            layout: DockLayout {}
            Container{
                background: Color.Black
                visible:  liveActiveFrame
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Top
                preferredHeight:100
                layout: DockLayout {
                }
                
                Container {
                    id: clockContsmall
                    horizontalAlignment: HorizontalAlignment.Center
                    leftPadding: 5
                    verticalAlignment: VerticalAlignment.Top
                    topPadding: 3
                    Label {
                        text:  clockTime
                        textStyle{
                            color: activeFrameContentColour==="clockColour"? Color.create(colour): Color.create(activeFrameContentColour)

                            fontSize: FontSize.PointValue
                            fontSizeValue:  if(timeFormat==="hh:mm:ss"){
                                if(keyboardDeviceNonPassport===true){
                                    return 10;
                                }
                                else{
                                    return 14;
                                }
                            }
                            else if(timeFormat==="hh:mm"){
                                if(keyboardDeviceNonPassport===true){
                                    return 16;
                                }
                                else{  return 16;}
                            }
                            
                            else if(timeFormat==="h:mm:ss AP"){
                                if(keyboardDeviceNonPassport===true){
                                    return 12;
                                }
                                else{
                                    return 12;
                                
                                }
                            }
                            
                            else  if(timeFormat==="h:mm AP"){
                                if(keyboardDeviceNonPassport===true){
                                    return 14;
                                }
                                else{   return 14;}
                            }
                        
                        }
                    
                    }
                }
                Container {
                    id:subTitleContsmall
                    leftPadding: 5
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Bottom
                    bottomPadding: 1
                    opacity: 0.9
                    Label {
                        textStyle{
                            color: Color.create(activeFrameContentColour)

                            fontSize: FontSize.PointValue
                            fontSizeValue: 6 }
                        text: datelabel.text
                    }
                }
                Divider { }
            
            }
        
        }
    }
}


