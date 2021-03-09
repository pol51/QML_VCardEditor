import QtQuick 2.2;

Column {
  add: Transition {
    NumberAnimation { properties: "x,y"; easing.type: Easing.OutBounce; }
  }
  move: Transition {
    NumberAnimation { properties: "x,y"; easing.type: Easing.OutBounce; }
  }
}
