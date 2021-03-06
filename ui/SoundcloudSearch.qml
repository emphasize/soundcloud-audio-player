/*
 *  Copyright 2018 by Aditya Mehra <aix.m@outlook.com>
 *  Copyright 2018 Marco Martin <mart@kde.org>
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.

 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.

 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.4
import QtQuick.Layouts 1.4
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import org.kde.kirigami 2.4 as Kirigami

import Mycroft 1.0 as Mycroft

Mycroft.ScrollableDelegate {
    id: delegate

    property var scSearchModel: JSON.parse(sessionData.scSearchBlob)
    property var scCurrentSongUrl: sessionData.audioSource
    property var scCurrentTitle: sessionData.audioTitle

    skillBackgroundSource: "https://source.unsplash.com/1920x1080/?+music"
    
    ToolButton {
        id: topbutton
        anchors.top: parent.top
        anchors.topMargin: Kirigami.Units.largeSpacing
        anchors.left: parent.left
        anchors.leftMargin: Kirigami.Units.largeSpacing
        width: Kirigami.Units.iconSizes.medium
        height: Kirigami.Units.iconSizes.medium

        background: Rectangle {
            color: "transparent"
        }

        contentItem: Image {
            width: Kirigami.Units.iconSizes.smallMedium
            height: Kirigami.Units.iconSizes.smallMedium
            source: "images/back.png"
        }
        onClicked: {
            root.parent.backRequested()
        }
    }
    
    Kirigami.CardsListView {
        anchors.top: topbutton.bottom
        anchors.topMargin: Kirigami.Units.largeSpacing
        model: scSearchModel
        delegate: Kirigami.AbstractCard {
            showClickFeedback: true
            Layout.fillWidth: true
            implicitHeight: delegateItem.implicitHeight + Kirigami.Units.largeSpacing * 3
            highlighted: modelData.url == scCurrentSongUrl ? 1 : 0
            contentItem: Item {
                implicitWidth: parent.implicitWidth
                implicitHeight: parent.implicitHeight
                z: 1000

                RowLayout {
                    id: delegateItem
                    anchors {
                        left: parent.left
                        right: parent.right
                        top: parent.top
                    }
                    spacing: Kirigami.Units.largeSpacing

                    Image {
                        id: videoImage
                        source: modelData.thumbnail
                        Layout.preferredHeight: Kirigami.Units.gridUnit * 3
                        Layout.preferredWidth: Kirigami.Units.gridUnit * 3
                        fillMode: Image.Stretch
                    }

                    Kirigami.Separator {
                        Layout.fillHeight: true
                        color: Kirigami.Theme.linkColor
                    }

                    Label {
                        id: videoLabel
                        Layout.fillWidth: true
                        text: modelData.title
                        wrapMode: Text.WordWrap
                    }
                }
            }
                onClicked: {
                    triggerGuiEvent("aiix.soundcloud-audio-player.playtitle", {playtitle: modelData.title})
            }
        }
    }
}

