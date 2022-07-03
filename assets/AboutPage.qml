import bb.cascades 1.2
import bb.system 1.0

Sheet {
    id:about

    onCreationCompleted: {open();}
    attachedObjects:
    [
        Invocation
        {
            id: invoke
            query: InvokeQuery
            {
                id: query
                mimeType: "text/html"
               uri: "http://facebook.com/AllstarSoftware"
                invokeActionId: "bb.action.OPEN"
            }
        }, 
        
        Invocation
        {
            id: invoke2
            query: InvokeQuery
            {
                id: query2
                mimeType: "text/html"
                uri: "https://twitter.com/paulwallace1234"
                invokeActionId: "bb.action.OPEN"
            }
        }, 
        Invocation
        {
            id: invoke4
            
            query.mimeType: "text/plain"
            query.invokeTargetId: "sys.pim.uib.email.hybridcomposer"
            query.invokeActionId: "bb.action.SENDEMAIL"
            onArmed: {
              invoke4.trigger(invoke4.query.invokeActionId);
            }
        },
        Invocation {
            id: share
            query: InvokeQuery {
                id: sharequery
                mimeType: "text/plain"
                uri: "http://appworld.blackberry.com/webstore/content/59945087/"
                invokeActionId: "bb.action.SHARE"
            }
        },
        Invocation
        {
                    id: invoke5
                    query: InvokeQuery
                    {
                        id: query5
                        mimeType: "text/html"
                        uri: "http://allstarsoftware.co.uk/BlackBerryWorldPrivacyPolicy.txt"
                        invokeActionId: "bb.action.OPEN"
                    }
        } 
        
    ]
    content: Page {
        titleBar: TitleBar {
            appearance: TitleBarAppearance.Branded
            title: ("Nightly Clock v" + Application.applicationVersion.substring(0,4)) 

            dismissAction: ActionItem {
                title: ("Close") 
                onTriggered: {
                about.close();about.destroy();
                }
            
            }
            acceptAction: ActionItem {
                imageSource: "asset:///images/ic_share.png"
                onTriggered: {
                    share.trigger("bb.action.SHARE")
                }
            }
           
        }
       Container {
           layout: DockLayout {
        
           }
           DropDown {
               id: infodrop
               onSelectedIndexChanged: {
                   if(selectedIndex===0){  invoke4.query.uri = "mailto:contact@allstarsoftware.co.uk?subject=Nightly Clock BlackBerry 10&body=" + ""; invoke4.query.updateQuery();}
                   else if(selectedIndex===1){invoke.trigger("bb.action.OPEN")}
                   else if(selectedIndex===2){invoke2.trigger("bb.action.OPEN")}
                   else if(selectedIndex===3){invoke5.trigger("bb.action.OPEN")}
               }
               topPadding: 5
               title:"Find/ Contact Us/ Privacy Policy"
               Option{
                   text: "Email"
               }
               Option{
                   text: "Facebook"
               }
             Option{
                   text: "Twitter"
               }
               
               Option{
                   text: "Privacy Policy"
               }
               
           }
          
       
        ImageView {
            id: image
            opacity: infodrop.expanded? 0:1
            layoutProperties: StackLayoutProperties {}
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            minHeight: 390    
            minWidth: 390
            maxHeight: minHeight
            maxWidth: minWidth
            imageSource: "images/appicon.png"
        }
        
      /*  Button {
            horizontalAlignment: HorizontalAlignment.Right
            verticalAlignment: VerticalAlignment.Bottom
            text:"Twitter"
            onClicked: {
                invoke2.trigger("bb.action.OPEN")
            }
        }*/
      /*  Button {
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Bottom
            text:"Email"
            onClicked: {
               invoke4.query.uri = "mailto:contact@allstarsoftware.co.uk?subject=Nightly Clock BlackBerry 10&body=" + ""
                invoke4.query.updateQuery();
            }
        }*/
        
        /*Button {
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Bottom
            text:"Facebook"
            onClicked: {
                invoke.trigger("bb.action.OPEN")
            }
            }*/
       /* Container{
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Bottom
            bottomPadding: 100
            
        Button{
          text: "Privacy Policy"
          onClicked: {
              invoke5.trigger("bb.action.OPEN")
              
          }
            
        }}*/
    }
    }
}
