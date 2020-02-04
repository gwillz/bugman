import QtQuick 2.0

ListModel {
    ListElement {
        name: "Wasps"
        author: "Field Assistant"
        
        attributes: [
            ListElement {
                name: "Specimen Type"
                type: "string"
            },
            ListElement {
                name: "Specimen Count"
                type: "string"
            },
            ListElement {
                name: "State/Territory"
                type: "string"
            },
            ListElement {
                name: "Location"
                type: "string"
            },
            ListElement {
                name: "Method"
                type: "string"
            },
            ListElement {
                name: "Flower/Host"
                type: "string"
            },
            ListElement {
                name: "Notes"
                type: "text"
            }
        ]
    }
    ListElement {
        name: "Test"
        author: "Field Assistant"
        
        attributes: [
            ListElement {
                name: "Rock Type"
                type: "string"
            },
            ListElement {
                name: "Diameter"
                type: "decimal"
            },
            ListElement {
                name: "Count"
                type: "integer"
            },
            ListElement {
                name: "Roughness"
                type: "string"
            },
            ListElement {
                name: "Notes"
                type: "text"
            }
        ]
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
