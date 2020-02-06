#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include "appdata.h"
#include "dataentry.h"

#ifdef Q_OS_ANDROID
#include <QtAndroid>
void requestAndroidPermissions();
#endif

int main(int argc, char *argv[]) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    
//    qmlRegisterType<Entry>("entry", 1, 0, "Entry");
//    qmlRegisterType<EntrySet>("entry", 1, 0, "EntrySet");
//    qmlRegisterType<EntryField>("entry", 1, 0, "EntryField");
//    qmlRegisterType<EntryPosition>("entry", 1, 0, "EntryPosition");
//    qmlRegisterType<EntryTemplate>("entry", 1, 0, "EntryTemplate");
    
    qmlRegisterSingletonType("AppData", 1, 0, "AppData", AppData::registerType);
    
    QGuiApplication app(argc, argv);
    
#ifdef Q_OS_ANDROID
    requestAndroidPermissions();
#endif
    
    QQmlApplicationEngine engine;
    
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl) {
            QCoreApplication::exit(-1);
        }
    }, Qt::QueuedConnection);
    
    engine.load(url);
    
    return app.exec();
}

#ifdef Q_OS_ANDROID

typedef QtAndroid::PermissionResult Permission;

void requestAndroidPermissions() {
    //Request requiered permissions at runtime
    
    const QStringList permissions({
        "android.permission.ACCESS_COARSE_LOCATION",
        "android.permission.ACCESS_FINE_LOCATION",
    });
    
    QHash<QString, Permission> results =
            QtAndroid::requestPermissionsSync(permissions);
    
    for (QString permission : results.keys()) {
        auto status = results[permission];
        
        switch (status) {
        case Permission::Denied: 
            qDebug() << permission << ": Denied";
            break;
            
        case Permission::Granted:
            qDebug() << permission << ": Denied";
            break;
        }
    }
    
//    if (resultHash[permission] == QtAndroid::PermissionResult::Denied) {
//        return false;
//    }
    
//    for (const QString &permission : permissions) {
//        auto result = QtAndroid::checkPermission(permission);
        
//        if (result == QtAndroid::PermissionResult::Denied) {
            
//        }
//    }
}
#endif
