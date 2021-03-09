import QtQuick 2.2;
import QtQuick.Controls 1.2;
import QtQuick.Layouts 1.1;

RowLayout {
  property alias font:            lineEdit.font;

  property alias text:            lineEdit.text;
  property alias subType:         typeName.currentText;
  property alias placeholderText: lineEdit.placeholderText;

  property string type: '';
  property int idx: -1;

  spacing: margin;

  function setSubType(value) {
    typeName.currentIndex = typeName.find(value);
  }

  ComboBox {
    id: typeName;
    model: ListModel {
      id: subTypeModel;

      ListElement { text: "HOME"; }
      ListElement { text: "WORK"; }
    }
    Component.onCompleted: {
      if (type === 'TEL')
        subTypeModel.append({text: 'CELL'});
    }
  }

  TextField {
    id: lineEdit;
    implicitWidth: parent.width - margin - typeName.width;
  }

  Button {
    implicitWidth: implicitHeight;
    text: "-";
    onClicked: parent.destroy();
  }
}
