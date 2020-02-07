
# Field Assistant (QML)
## Aka. Bugman


### TODO
- singleton naivgation
  - should fix double listener (onNavChanged: nav.onIndexChanged: {})
- fix home view first swipe panel
  - current workaround is gross
- fix camera
  - try android-28
- about view
- migrate qlist to qmlpropertylist
- create csvwriter to replace csvbuilder
- images:
    - image picker actions
    - load entry images
    - copy new entry images
    - export images zip
- different entry fields per 'type'
- rename AppData -> App
- templates fields:
    - add dialog close button
    - add clear button 
    - icons
- post message/dialog after exporting

### Development

+ Install Qt 5.14.1+

#### Android

+ Install Java 8
+ Install Android Studio

+ Use the Android Studio SDK Manager:
    + Install NDK v20+ (v29.0.3)
    + Install SDK v21+ (v29)
+ Configure QtCreator:
    + Set Paths: Tools -> Options -> Devices -> Android
    + https://doc.qt.io/qtcreator/creator-developing-android.html#specifying-android-device-settings


#### iOS
  + Install XCode? is that is?
