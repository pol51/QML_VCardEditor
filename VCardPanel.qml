import QtQuick 2.2;
import QtQuick.Controls 1.2;
import QtQuick.Layouts 1.1;
import QtQuick.Window 2.2;

import "list.js" as Code;

Window {
  id: vCardArea;
  color: syspal.window;

  SystemPalette{ id: syspal; }

  width: 350;
  height: 400;
  title: qsTr('Edit contact: ') + firstName.text + ' ' + lastName.text;

  property int margin: 5;
  property int baseWidth: scrollview.viewport.width - (margin<<3) + margin;
  property int currentId: -1;

  function editVCard(idx, vcard) {
    currentId = idx;
    Code.setVCard(vcard);
    visible = true;
  }

  function removeFromArray(type, idx) {
    Code.removeFromArray(type, idx);
  }

  Component.onCompleted: Code.init(dynamicArea, ['TEL', 'EMAIL', 'ADR'], [qsTr('Phone'), qsTr('E-Mail'), qsTr('Address')]);

  ColumnLayout {
    anchors.fill: parent;
    anchors.margins: 5;

    ScrollView {
      id: scrollview;

      Layout.fillWidth: true;
      Layout.fillHeight: true;

      ColumnWithBounce {
        id: vCardPanel;

        spacing: margin;

        Separator {
          text: 'Basics'
        }

        TextField {
          id: firstName;
          width: baseWidth;
          placeholderText: qsTr("First Name");
        }

        TextField {
          id: lastName;
          width: baseWidth;
          placeholderText: qsTr("Last Name");
        }

        ColumnWithBounce {
          id: dynamicArea;
          spacing: margin;
        }
      }
    }

    RowLayout {
      id: buttons;

      Layout.fillWidth: true;

      Button {
        id: btnAdd;
        text: qsTr("Add field");
        menu: Menu {
          MenuItem { text: qsTr('Phone');   onTriggered: Code.addItem('TEL'); }
          MenuItem { text: qsTr('E-Mail');  onTriggered: Code.addItem('EMAIL'); }
          MenuItem { text: qsTr('Address'); onTriggered: Code.addItem('ADR'); }
        }
      }

      Item {
        Layout.fillWidth: true;
      }

      Button {
        text: "Save";
        onClicked: {
          //contactsModel.onSaveContact(currentId, Code.getVCard());
          console.log(Code.getVCard());
          close();
        }
      }
      Button {
        text: "Cancel";
        onClicked: close();
      }
    }
  }
}
