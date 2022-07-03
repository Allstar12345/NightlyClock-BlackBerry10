import bb.cascades 1.2
    Container {
        visible: mediaController.state===4? false: true
        opacity: mediaControls? 1:0
        property alias iconSource: img.imageSource
        signal clicked
        
        onTouch: {
       if(event.isUp()) {
                clicked()}   
        }
        onTouchExit: {
            if(event.isDown()){}
        }
        verticalAlignment: VerticalAlignment.Bottom
        ImageView {
            id: img
        }
    }

