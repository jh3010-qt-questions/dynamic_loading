import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

ApplicationWindow
{
  id: appWindow

  width:    640
  height:   480
  visible:  true
  title:    qsTr("Hello World")

  property var component
  property var componentObject
  property var componentNames: [ "ComponentA.qml", "ComponentB.qml", "ComponentC.qml" ]

  function finishCreation()
  {
    console.log( "finish creation" )

    if ( component.status === Component.Ready )
    {
      componentObject = component.createObject( contentColumn );

      if ( componentObject === null )
      {
          // Error Handling
          console.log("Error creating object");
      }
    }
    else if ( component.status === Component.Error )
    {
        // Error Handling
        console.log("Error loading component:", component.errorString());
    }
  }

  Connections
  {
    target: appWindow

    Component.onCompleted:
    {
      component = Qt.createComponent( `qrc:/${componentNames[0]}` );

      if ( component.status === Component.Ready )
      {
        console.log( "ready" )

        finishCreation();
      }
      else
      {
        component.statusChanged.connect( finishCreation );
      }


      console.log( "completed window" )
    }
  }

  Item
  {
    anchors.fill: parent

    Column
    {
      id: contentColumn

//      ComponentA {
//      }

//      ComponentB {
//      }

//      ComponentC {
//      }
    }
  }
}
