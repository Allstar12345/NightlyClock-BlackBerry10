import bb.cascades 1.2
import bb.multimedia 1.2

Page {
    property alias state: nowPlaying.mediaState
    property alias forwardEnabled: nowPlaying.nextEnabled
    property alias backEnabled: nowPlaying.previousEnabled
    onStateChanged: {if(albumArtWallpaper===true){  if(nowPlaying.mediaState===4)wallpaper=""}}
    signal playPause
    signal next
    signal previous
    signal pause
    onPlayPause: {
    nowPlaying.playPause()
    }
    onNext: {
        nowPlaying.next()
    }
    onPrevious: {
        nowPlaying.previous()
    }
    onPause:{
        nowPlaying.pause()
    }
    attachedObjects:  NowPlayingController {
        id: nowPlaying
        onMetaDataChanged: {
            if(albumArtWallpaper===true) wallpaper=nowPlaying.iconUrl.toString();
        }
        onTrackChanged: {
            if(albumArtWallpaper===true) wallpaper=nowPlaying.iconUrl.toString();
        }
    }
    Container {
        minWidth: display.displayWidth
    }
}
