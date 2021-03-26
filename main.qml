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

  function generateObjects()
  {
      function generateOneObject( name )
      {
          var component
          var componentObject

          function finishCreation()
          {
            console.log( `finish creation ${name}` )

            if ( component.status === Component.Ready )
            {
              componentObject = component.createObject( contentColumn );

              if ( componentObject === null )
              {
                console.log( "Error creating object" );
              }
            }
            else if ( component.status === Component.Error )
            {
              console.log("Error loading component:", component.errorString());
            }
          }

          component = Qt.createComponent( `qrc:/${name}` )

          if ( component.status === Component.Ready )
          {
              finishCreation()
          }
          else
          {
              component.statusChanged.connect( finishCreation );
          }
      }

      for ( var index in componentNames )
      {
          generateOneObject( componentNames[ index ] )
      }
  }

  Connections
  {
    target: appWindow

    Component.onCompleted:
    {
      generateObjects()

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
