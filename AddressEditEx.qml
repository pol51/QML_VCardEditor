import QtQuick 2.2;
import QtQuick.Controls 1.2;

Row {
  property int itemHeight;

  property alias street:  txtStreet.text;
  property alias city:    txtCity.text;
  property alias country: txtCountry.text;
  property alias zip:     txtZIP.text;
  property alias subType: typeName.currentText;

  property string type: '';
  property int idx: -1;

  property string text: ';;;' + street + ';' + city + ';;' + zip + ';' + country;

  function setText(values) {
    for (var i in values)
      switch (i) {
        case '3': street  = values[i]; break;
        case '4': city    = values[i]; break;
        case '6': zip     = values[i]; break;
        case '7': country = values[i]; break;
      }
  }

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
  }

  ColumnWithBounce {
    spacing: margin;

    width: parent.width - margin - typeName.width;

    TextField { id: txtStreet;   width: parent.width; placeholderText: 'Street'; }
    TextField { id: txtCity;     width: parent.width; placeholderText: 'City'; }
    TextField { id: txtCountry;  width: parent.width; placeholderText: 'Country'; }
    TextField { id: txtZIP;      width: parent.width; placeholderText: 'ZIP Code'; }
  }

  Button {
    //width: height;
    text: "-";
    onClicked: parent.destroy();
  }
}
