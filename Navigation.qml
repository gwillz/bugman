import QtQuick 2.0

Item {
    id: nav
    
    property int index: Views.home
    property var data: ({})
    
    readonly property int isHome: {
        return index === Views.home
    }
    
    function navigate(index, data) {
        nav.index = index;
        nav.data = data || ({});
    }
}
