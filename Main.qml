import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import "utils"

Window {
    id: root
    width: 400
    height: 600
    visible: true
    title: qsTr("Todo App")
    color: "#1e1e1e"

    ColumnLayout {
        anchors {
            fill: parent
            margins: 10
            topMargin: 30
            bottomMargin: 30
        }

        spacing: 10

        CustomTextField {
            Layout.fillWidth: true
            Layout.leftMargin: 16
            Layout.rightMargin: 16
            Layout.preferredHeight: 40
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.leftMargin: 16
            Layout.rightMargin: 16

            spacing: 5

            Text {
                text: BackendHelper.currentDay
                font {
                    pointSize: 30
                    weight: Font.DemiBold
                }
                color: "#fff"
            }

            ColumnLayout {
                spacing: 0
                Text {
                    text: BackendHelper.currentMonth
                    font {
                        pointSize: 13
                        weight: Font.Medium
                    }
                    color: "#ddd"
                }

                Text {
                    text: BackendHelper.currentYear
                    font {
                        pointSize: 11
                        weight: Font.Medium
                    }
                    color: "#aaa"
                }
            }

            Item {
                Layout.fillWidth: true
            }

            Text {
                text: BackendHelper.currentDayOfWeek
                font {
                    pointSize: 13
                    weight: Font.Medium
                }
                color: "#fff"
            }
        }

        ListView {
            id: todoList
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: 16
            Layout.rightMargin: 16

            model: todoModel
            delegate: todoDelegate

            spacing: 8
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            ScrollBar.vertical: CustomScrollbar {}
        }

        Button {
            id: addItemButton
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 40
            Layout.preferredWidth: 200

            contentItem: Text {
                text: "Add Task"
                font.pointSize: 12
                color: "#fff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            background: Rectangle {
                anchors.fill: parent
                color: addItemButton.hovered ? Qt.darker("#2ba84a",
                                                         1.1) : "#2ba84a"
                radius: 10
            }
            onClicked: {
                todoModel.append({
                                     "task": "New Task " + (todoModel.count + 1)
                                 })
                notificationPopup.showPopup("Item Added Successfully")
            }
        }
    }

    Component {
        id: todoDelegate
        Rectangle {
            required property string task
            required property int index

            width: todoList.width
            height: 50
            color: "#363636"
            radius: 12

            RowLayout {
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    Layout.fillWidth: true
                    Layout.leftMargin: 10
                    Layout.rightMargin: 10
                    text: task
                    font.pointSize: 12
                    color: "#fafafa"
                }

                Image {
                    Layout.preferredWidth: 18
                    Layout.preferredHeight: 18
                    Layout.alignment: Qt.AlignVCenter
                    source: "qrc:/Images/edit.svg"

                    MouseArea {
                        cursorShape: Qt.PointingHandCursor
                        anchors.fill: parent
                        onClicked: {
                            editItemPopup.showPopup(task, index)
                        }
                    }
                }

                Image {
                    Layout.preferredWidth: 20
                    Layout.preferredHeight: 20
                    Layout.rightMargin: 10
                    Layout.alignment: Qt.AlignVCenter
                    source: "qrc:/Images/delete.svg"

                    MouseArea {
                        cursorShape: Qt.PointingHandCursor
                        anchors.fill: parent
                        onClicked: {
                            todoModel.remove(index)
                            notificationPopup.showPopup(
                                        "Item Deleted Successfully")
                        }
                    }
                }
            }
        }
    }

    ListModel {
        id: todoModel
        ListElement {
            task: "Finish the lecture"
        }
        ListElement {
            task: "Code on my own"
        }
        ListElement {
            task: "Improve the UI/UX"
        }
        ListElement {
            task: "Upload this GitHub"
        }
    }

    AppPopup {
        id: notificationPopup
        x: root.width / 2 - width / 2
        y: 30
    }

    EditPopup {
        id: editItemPopup
        anchors.centerIn: parent

        onUpdateListText: function (newText, index) {
            todoModel.set(index, {
                              "task": newText
                          })
        }
    }
}
