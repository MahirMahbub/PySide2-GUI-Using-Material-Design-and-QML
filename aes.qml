import QtQuick 2.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Dialogs 1.0
import QtQuick.Dialogs 1.1
ApplicationWindow {
    id: applicationWindow
    visible: true
    height: 750

    width: 800
    Material.theme: Material.Dark
    Material.accent: Material.Purple

    Column {
        id: col
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.leftMargin: 11
        anchors.left: parent.left
        objectName: "colMode"

        Label{
            width: 26
            text: "Operation"
            anchors.top: parent.top
            anchors.topMargin: 20
            font.weight: Font.Bold
            font.pointSize: 11
            Material.elevation: 10
            bottomPadding: 15
            objectName: operation
        }
        ButtonGroup {
            id: radiooperation
        }

        RadioButton {
            id: radioButtonOperation1
            anchors.left: radioButtonOperation1.right
            anchors.leftMargin: 20
            objectName: "radioButtonOperation1"
            text: qsTr("Encrypt")
            anchors.top: parent.top
            anchors.topMargin: 50
            Material.elevation: 10
            checked: true
            ButtonGroup.group: radiooperation
        }
        RadioButton {
            id: radioButtonOperation2
            anchors.left: radioButtonOperation2.right
            anchors.leftMargin: 20
            text: qsTr("Decrypt")
            objectName: "radioButtonOperation2"
            anchors.top: radioButtonOperation1.bottom
            Material.elevation: 10
            anchors.topMargin: 1
            ButtonGroup.group: radiooperation
        }
        Label{
            width: 26
            text: "Mode"
            anchors.top: parent.top
            anchors.topMargin: 150
            font.weight: Font.Bold
            font.pointSize: 11
            Material.elevation: 10
            bottomPadding: 15
        }
        ButtonGroup {
            id: radiomode
        }

        RadioButton {
            id: radioButton1
            anchors.left: radioButton1.right
            anchors.leftMargin: 20
            objectName: "radioButton1"
            text: qsTr("CTR")
            anchors.top: parent.top
            anchors.topMargin: 180
            Material.elevation: 10
            checked: true
            ButtonGroup.group: radiomode
        }
        RadioButton {
            id: radioButton2
            anchors.left: radioButton2.right
            anchors.leftMargin: 20
            text: qsTr("OFB")
            objectName: "radioButton2"
            anchors.top: radioButton1.bottom
            Material.elevation: 10
            anchors.topMargin: 1
            ButtonGroup.group: radiomode
        }
        Label{
            width: 26
            text: "Encryption File Path"
            font.bold: true
            anchors.top: parent.top
            anchors.topMargin: 280
            font.pointSize: 11
            Material.elevation: 6
            bottomPadding: 15
        }

        TextField{
            id: textencrypt
            width: 605
            height: 40
            anchors.top: parent.top
            anchors.topMargin: 320
            placeholderText: qsTr("Encryption Path")
            Material.elevation: 6
            objectName:"textField"

        }
        Button{
            id: buttonEncryption
            y: 165
            width: 102
            height: 40
            objectName: "encryptionButton"
            text: qsTr("Browse")
            anchors.horizontalCenterOffset: 687
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: textencrypt.bottom
            anchors.topMargin: -40
            Material.elevation: 6
            onClicked: fileDialog.open()


        }
        FileDialog {
            id: fileDialog
            title: "Please choose a file"
            folder: shortcuts.home
            onAccepted: {
                textencrypt.text = fileUrl
                buttonEncryptionPath.enabled=true
            }
            onRejected: {
                console.log("Canceled")
            }

        }

        Label{
            width: 26
            text: "Key Path"
            font.bold: true
            anchors.top: parent.top
            anchors.topMargin: 520
            font.pointSize: 11
            Material.elevation: 6
            bottomPadding: 15
        }

        TextField{
            id: keytext
            width: 605
            height: 40
            anchors.top: parent.top
            anchors.topMargin: 560
            placeholderText: qsTr("Key Path")
            Material.elevation: 6
            objectName:"keyField"

        }
        Button{
            id: buttonKey
            y: 165
            width: 102
            height: 40
            enabled: false
            objectName: "encryptionButton"
            text: qsTr("Browse")
            anchors.horizontalCenterOffset: 687
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: keytext.bottom
            anchors.topMargin: -40
            Material.elevation: 6
            onClicked: filekey.open()


        }
        FileDialog {
            id: filekey
            title: "Please choose a file"
            folder: shortcuts.home
            onAccepted: {
                keytext.text = fileUrl
                operationConfirm.enabled=true
            }
            onRejected: {
                console.log("Canceled")
            }

        }

        Label{
            width: 26
            text: "Save Location"
            anchors.top: parent.top
            anchors.topMargin: 400
            font.weight: Font.Bold
            font.pointSize: 11
            Material.elevation: 10
            bottomPadding: 15

        }


        TextField {
            id: saveEncryptPath
            width: 605
            height: 40
            anchors.top: parent.top
            anchors.topMargin: 440
            Material.elevation: 6
            placeholderText: qsTr("Encryption Path")
            objectName: "savePathField"
        }

        Button {
            id: buttonEncryptionPath
            enabled: false
            y: 165
            width: 102
            height: 40
            text: qsTr("Browse")
            anchors.top: saveEncryptPath.bottom
            anchors.topMargin: -40
            Material.elevation: 6
            anchors.horizontalCenterOffset: 687
            anchors.horizontalCenter: parent.horizontalCenter
            objectName: "encryptionButton"
            onClicked: folderDialog.open()
        }

        FileDialog {
            id: folderDialog

            title: "Please choose a file"
            folder: shortcuts.home
            selectFolder: true
            onAccepted: {
                saveEncryptPath.text = folder
                buttonKey.enabled = true
            }
            onRejected: {
                console.log("Canceled")

            }

        }


        Button{
            id: operationConfirm
            y: 528
            width: 102
            height: 40
            enabled: false
            objectName: "confirmOperation"
            text: qsTr("Ok")
            anchors.horizontalCenterOffset: 700
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
            anchors.topMargin: 665
            Material.elevation: 6
            onClicked: {
                messageDialog.open()
            }

        }

        MessageDialog {
            id: messageDialog
            title: "AES Confirmation"
            text: "AES operation is successful"
            onAccepted: {
                console.log("And of course you could only agree.")
            }

        }

    }

}
