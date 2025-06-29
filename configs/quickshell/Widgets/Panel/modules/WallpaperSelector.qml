import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import "root:/Data" as Data

Item {
    id: root

    property bool isVisible: false
    signal visibilityChanged(bool visible)

    anchors.fill: parent
    visible: isVisible
    enabled: visible
    clip: true

    property bool containsMouse: wallpaperSelectorMouseArea.containsMouse || scrollView.containsMouse
    property bool menuJustOpened: false

    onContainsMouseChanged: {
        if (containsMouse) {
            hideTimer.stop()
        } else if (!menuJustOpened && !isVisible) {
            hideTimer.restart()
        }
    }

    onVisibleChanged: {
        if (visible) {
            menuJustOpened = true
            hideTimer.stop()
            Qt.callLater(() => {
                menuJustOpened = false
                wallpaperGrid.forceActiveFocus()
            })
        }
    }

    MouseArea {
        id: wallpaperSelectorMouseArea
        anchors.fill: parent
        hoverEnabled: true
        preventStealing: false
        propagateComposedEvents: true
    }

    ScrollView {
        id: scrollView
        anchors.fill: parent
        clip: true

        GridView {
            id: wallpaperGrid
            anchors.fill: parent
            cellWidth: parent.width / 2 - 8
            cellHeight: cellWidth * 0.6
            model: Data.WallpaperManager.wallpaperList
            cacheBuffer: 0
            leftMargin: 4
            rightMargin: 4
            topMargin: 4
            bottomMargin: 4

            focus: true
            highlightFollowsCurrentItem: true
            keyNavigationWraps: true

            Keys.onReturnPressed: {
                if (currentIndex >= 0 && currentIndex < model.count) {
                    Data.WallpaperManager.setWallpaper(model.get(currentIndex))
                }
            }
            Keys.onEnterPressed: Keys.onReturnPressed()

            delegate: Item {
                width: wallpaperGrid.cellWidth - 8
                height: wallpaperGrid.cellHeight - 8

                Rectangle {
                    id: wallpaperItem
                    anchors.fill: parent
                    anchors.margins: 4
                    color: Qt.darker(Data.ThemeManager.bgColor, 1.2)
                    radius: 20

                    Image {
                        anchors.fill: parent
                        anchors.margins: 4
                        source: modelData
                        fillMode: Image.PreserveAspectCrop
                        asynchronous: true
                        cache: false
                        sourceSize.width: Math.min(width, 150)
                        sourceSize.height: Math.min(height, 90)
                        visible: parent.parent.y >= wallpaperGrid.contentY - parent.parent.height &&
                                parent.parent.y <= wallpaperGrid.contentY + wallpaperGrid.height
                    }

                    Rectangle {
                        visible: modelData === Data.WallpaperManager.currentWallpaper
                        anchors.fill: parent
                        radius: parent.radius
                        color: "transparent"
                        border.color: Data.ThemeManager.accentColor
                        border.width: 2
                    }

                    Rectangle {
                        visible: GridView.isCurrentItem
                        anchors.fill: parent
                        radius: parent.radius
                        color: "transparent"
                        border.color: "#7fbfff"
                        border.width: 2
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            Data.WallpaperManager.setWallpaper(modelData)
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        Data.WallpaperManager.ensureWallpapersLoaded()
    }
}
