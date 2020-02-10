pragma Singleton
import QtQuick 2.0

QtObject {
    id: nav
    
    readonly property int homeView:      0
    readonly property int aboutView:     1
    readonly property int entryEditView: 2
    readonly property int setEditView:   3
    readonly property int setSaveView:   4
    
    signal closeDialog()
    
    property int index: homeView
    property var data: ({})
    property bool hasDialog: false
    
    readonly property int isExitReady: {
        return isHome && !hasDialog
    }
    
    readonly property int isHome: {
        return index === homeView
    }
    
    function navigate(index, data) {
        nav.data = data || ({});
        nav.index = index;
        nav.hasDialog = false;
    }
    
    function goBack() {
        if (isExitReady) return;
        
        if (!nav.hasDialog) {
            nav.navigate(homeView);
        }
        
        nav.closeDialog()
        nav.hasDialog = false
    }
}
