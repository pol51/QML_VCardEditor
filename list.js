var propertyTypes = [];
var propertyTypeNames = {};
var properties = {};
var areas = {};
var next_id = 0;

function init(area, types, typeNames) {
  propertyTypes = types;
  for (var i in propertyTypes) {
    properties[propertyTypes[i]] = {};
    propertyTypeNames[propertyTypes[i]] = typeNames[i]
    areas[propertyTypes[i]] = Qt.createQmlObject(
          'import QtQuick 2.2;' +
          'ColumnWithBounce {' +
            'spacing: margin;' +
            'visible: false;' +
            'Separator { text: "' + typeNames[i] + '"; }' +
          '}',
          area);
  }
}

function removeFromArray(type, idx) {
  delete properties[type][idx];
  if (!getCount(type))
    areas[type].visible = false;
}

function getCount(type) {
  console.log("new count: " + Object.keys(properties[type]).length);
  return Object.keys(properties[type]).length;
}

function clear() {
  for (var typeId in propertyTypes) {
    var type = propertyTypes[typeId];
    areas[type].visible = false;
    for (var propId in properties[type]) {
      properties[type][propId].destroy();
      delete properties[type][propId];
    }
  }
}

function addItem(type) {
  var y = areas[type].height - firstName.height;
  ++next_id;

  if (!getCount(type))
    areas[type].visible = true;

  if (type !== 'ADR') {
    properties[type][next_id] =
        Qt.createQmlObject(
          'import QtQuick 2.2;' +
          'LineEditEx {' +
            'y: ' + y + ';' +
            'type: "' + type + '";' +
            'idx: ' + next_id + ';' +
            'width: baseWidth;' +
            'Component.onDestruction: { removeFromArray("' + type + '", ' + next_id + '); }' +
          '}',
          areas[type]);
    properties[type][next_id].placeholderText = propertyTypeNames[type];
  }
  else
    properties[type][next_id] =
        Qt.createQmlObject(
          'import QtQuick 2.2;' +
          'AddressEditEx {' +
            'y: ' + y + ';' +
            'type: "' + type + '";' +
            'idx: ' + next_id + ';' +
            'width: baseWidth;' +
            'itemHeight: firstName.height;' +
            'Component.onDestruction: { removeFromArray("' + type + '", ' + next_id + '); }' +
          '}',
          areas[type]);

  return properties[type][next_id];
}

function getVCard() {
  var res = 'BEGIN:VCARD\nVERSION:3.0\n' +
      'FN:' + firstName.text + ' ' + lastName.text + '\n' +
      'N:' + lastName.text + ';' + firstName.text + ';;;\n';
  for (var typeId in propertyTypes) {
    var type = propertyTypes[typeId];
    var props = properties[type];
    for (var propId in props) {
      var prop = props[propId].text;
      if (prop.length && prop.split(';').join('').length)
        res += type + ';TYPE=' + props[propId].subType + ':' + props[propId].text + '\n';
    }
  }
  return res + 'END:VCARD\n\n';
}

function setVCard(vcard) {
  var lines = vcard.split(/\r?\n/);
  var filter = /^(N|TEL.*|EMAIL.*|ADR.*)\:(.+)$/;
  var typeFilter = /^TYPE=(.+)$/;
  var fields = {};

  for (var n in lines) {
    var line = lines[n];
    var item;

    if (filter.test(line))
    {
      var results = line.match(filter);
      var key_args = results[1].split(';');
      var key = key_args[0];
      var subType = key_args[1];
      var vals = results[2].split(';');

      switch (key) {
        case 'N':
          lastName.text  = vals[0];
          firstName.text = vals[1];
          break;
        case 'TEL':
        case 'EMAIL':
          item = addItem(key);
          item.setSubType(subType);
          item.text = vals[0];
          break;
        case 'ADR':
          item = addItem(key);
          item.setSubType(subType);
          item.setText(vals);
          break;
        default:
          console.debug('?:' + results);
          break;
      }
    }
  }
}
