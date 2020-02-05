import QtQuick 2.0

Item {
    id: nav
    
    signal closeDialog()
    
    property int index: Views.home
    property var data: ({})
    property bool hasDialog: false
    
    readonly property int isExitReady: {
        return isHome && !hasDialog
    }
    
    readonly property int isHome: {
        return index === Views.home
    }
    
    function navigate(index, data) {
        nav.data = data || ({});
        nav.index = index;
        nav.hasDialog = false;
    }
    
    function goBack() {
        if (isExitReady) return;
        
        if (!nav.hasDialog) {
            nav.navigate(Views.home);
        }
        
        nav.closeDialog()
        nav.hasDialog = false
    }
}
