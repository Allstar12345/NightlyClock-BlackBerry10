import bb.cascades 1.2

ImageView {
    opacity:1
    id: batteryImage
    visible: true
   property double customFadeInValue

    property bool animation:false
    
    animations: [
        FadeTransition {
            id: fadeOut
            fromOpacity: 1
            toOpacity: 0.4
            duration: 1000
            onEnded: {fadeIn.play();}
        },
        FadeTransition {
            id: fadeIn
            fromOpacity: 0.4
            toOpacity: customFadeInValue?customFadeInValue: 1
            duration: 1000
        }
    ]
    function flash(){fadeOut.play(); }
}