import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0


ApplicationWindow {
    visible: true
    width: 380
    height: 600
    title: qsTr("TestApp")
    id: mainw

    font.capitalization: Font.MixedCase

    signal loginleave;


    header: ToolBar {
        Material.background: Material.LightBlue
        id: apptoolbar
        opacity: 0

    }

    StackView {
        anchors.fill: parent
        id: stackview
        initialItem: loginview
        onCurrentItemChanged: {

            console.log(currentItem)
        }

    }

    Component {
        id: busyview

        Pane {
            id: busypane
            BusyIndicator {
                anchors.centerIn: parent
                MouseArea {
                    acceptedButtons: Qt.AllButtons
                    anchors.fill: parent
                    onClicked: stackview.push(mainview)
                }
            }
            Component.onCompleted: {apptoolbar.opacity = 1; console.log(busypane)}
            Component.onDestruction: apptoolbar.opacity = 0
        }

    }

    Component {
        id: loginview
        Pane {
            ColumnLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 40

                TextField {
                    placeholderText: "Login"
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: 270
                    Layout.fillWidth: true
                }

                TextField {
                    placeholderText: "Password"
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: 270
                    Layout.fillWidth: true
                }


                RowLayout {
                    Layout.alignment: Qt.AlignVCenter
                    Button {
                        text: "Login"
                        Layout.fillWidth: true
                        onClicked: { !bsi.running ? bsi.running = true : bsi.running = false }
                    }
                    Button {
                        text: "Register"
                        Layout.fillWidth: true
                        onClicked: stackview.push(busyview)

                    }
                }

                Button {
                    Layout.fillWidth: true
                    text: "Sign in with Google+"

                    Component.onCompleted: background.color = "#dd4b39"
                }

                Button {
                    Layout.fillWidth: true

                    text: "Sign in with Facebook"

                    Component.onCompleted: background.color = "#3b5998"
                }

                BusyIndicator {
                    id: bsi
                    running: false
                    Layout.topMargin: 20
                    anchors.horizontalCenter: parent.horizontalCenter

                }

            }
        }
    }

    Component {
        id: mainview

        Pane {
            id: panemain
            ListView {
                id: varlistview
                anchors.fill: parent
                model: varlistmodel

                delegate: varlistdelegate

                highlight: Rectangle { color: "lightsteelblue"; radius: 5 }

            }
        }
    }
    ListModel {
        id: varlistmodel

        ListElement {
            tagname: "Nota 1"
            addr: "125"
            value: "124"
            protocol: "01/03/17"
            type: "total"
        }

        ListElement {
            tagname: "Nota 2"
            addr: "125"
            value: "17"
            protocol: "02/04/2017"
            type: "total"
        }

        ListElement {
            tagname: "Nota 3"
            addr: "200"
            value: "245"
            protocol: "05/04/2017"
            type: "total"
        }

    }

    Component {
        id: varlistdelegate

        Rectangle{

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    writePopup.waddr = parseInt(addrstr.text)
                    writePopup.open()
                    console.log("clicked " + typestr.text)
                }
            }

            height: (tagstr.height + addrstr.height)*1.6
            color: model.index % 2 == 0? "lightgray": Qt.lighter("gray")
            Text{
                id:tagstr
                text: tagname
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 10
                anchors.topMargin: 10
                font.pointSize: 20
            }
            RowLayout{

                anchors.top: tagstr.bottom
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 10

                Text {
                    id:protostr
                    text: protocol

                    font.pointSize: 12
                }
                Text {
                    id:typestr
                    text: type
                    font.pointSize: 12
                }
                Text {
                    id:addrstr
                    text: addr
                    font.pointSize: 12
                }
            }

            Text {
                id:valstr
                text: value
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10
                font.pointSize: 20
            }
        }

    }


}
