import QtQuick 2.2;
import QtQuick.Controls 1.2;

Row {
  property alias text: textItem.text

  spacing: margin;

  Rectangle {
    width: margin<<2;
    height: 1;
    color: syspal.windowText;
    anchors.verticalCenter: parent.verticalCenter;
  }

  Label {
    id: textItem
    color: syspal.windowText;
    anchors.verticalCenter: parent.verticalCenter;
  }

  Rectangle {
    width: vCardArea.baseWidth - textItem.width;
    height: 1;
    color: syspal.windowText;
    anchors.verticalCenter: parent.verticalCenter;
  }
}
