import bb.cascades 1.2
import bb.multimedia 1.2

Sheet {
    onCreationCompleted: {
        open();
    }
    id: soundpreview
    Page {
        titleBar: TitleBar {
            appearance: TitleBarAppearance.Branded
            title: "Preview Sounds"
            dismissAction: ActionItem {
                title: ("Close") 
                onTriggered: {
                    soundpreview.close();soundpreview.destroy();
                }
            }
        }
        attachedObjects: 
        MediaPlayer {
            id: previewPlayer
            onError: {
                
            }
            onPlaybackCompleted: {
                playbackbutton.imageSource= "asset:///images/ic_play.png"
                playbackbutton.text= "Play"
            }
        }
        Container {
            onCreationCompleted: {
                drop.setExpanded(true)
            }
            DropDown {
                id: drop
                onSelectedIndexChanged: {
                    console.log(selectedIndex)
                    if (selectedIndex===0) {previewPlayer.sourceUrl= "asset:///sounds/1.aac"; playbackbutton.enabled=true}
                    else if(selectedIndex===1){previewPlayer.sourceUrl= "asset:///sounds/2.aac"; playbackbutton.enabled=true}
                    else if(selectedIndex===2) {previewPlayer.sourceUrl= "asset:///sounds/3.aac"; playbackbutton.enabled=true}
                    else if(selectedIndex===3) {previewPlayer.sourceUrl= "asset:///sounds/4.mp3"; playbackbutton.enabled=true}
                    else if(selectedIndex===4) {previewPlayer.sourceUrl= "asset:///sounds/5.mp3"; playbackbutton.enabled=true}
                    else if(selectedIndex===5){previewPlayer.sourceUrl= appsettings.getSystemSetting("alarmSoundInternet", ""); playbackbutton.enabled=true}
                }
                title:"Pick Sound To Preview"
                Option{
                    text:"Alarm Sound 1"
                }
                Option{
                    text:"Alarm Sound 2"
                }
                Option{
                    text:"Alarm Sound 3"
                }
                Option{
                    text:"Alarm Sound 4"
                }
                Option{
                    text:"Alarm Sound 5"
                }
                Option {
                    text:"Internet File"
                }
            }
            
                ProgressIndicator {
                    id: playerprogress
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    value: previewPlayer.position
                    fromValue: 0
                    toValue: previewPlayer.duration
                }
            
           
            
            Button {
                id: playbackbutton
                text:"Play"
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                enabled: false
                imageSource: "asset:///images/ic_play.png"
                onClicked: {
                    if(previewPlayer.mediaState===0){ previewPlayer.play()
                        imageSource= "asset:///images/ic_pause.png"; text= "Pause"}
                    else if (previewPlayer.mediaState=== 2){previewPlayer.pause(); imageSource= "asset:///images/ic_play.png"; text= "Play"}
                    else if(previewPlayer.mediaState===3) {previewPlayer.play(); imageSource="asset:///images/ic_pause.png"; text="Pause";}
                    console.log("STATUS  "+previewPlayer.mediaState)
                }
        }
        ActivityIndicator {
            id: bufferInd
            preferredHeight: 100  
            preferredWidth: 100
            running: previewPlayer.bufferStatus===1? true:false
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
        }
        }
    }
}