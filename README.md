
# Field Assistant (QML)
## Aka. Bugman


### TODO

#### features
- about view
- images:
    - image picker actions
    - load entry images
    - copy new entry images
    - export images zip
- different entry fields per 'type'
- post message/dialog after exporting
- field validations
    - set edit
    - entry edit
    - template field edit
- icon button component

#### fixes
- fix home view first swipe panel
    - current workaround is gross
- fix camera

#### housework
- migrate qlist to qmlpropertylist
- separate entry types into separate files
- some docs/comments
- can we do better styles?
    - https://doc.qt.io/qt-5/qtquickcontrols2-customize.html#definition-of-a-style

#### future
- more field types
    - switch/boolean
    - range (from, to)
    - combobox (list of options)


### Development

+ Install Qt 5.14.1+

#### Android

+ Install Java 8
+ Install Android Studio

+ Use the Android Studio SDK Manager:
    + Install NDK v20+ (v29.0.3)
    + Install SDK v21+ (v29)
+ Configure QtCreator:
    + Update to 4.11.1+
    + Set Paths: Tools -> Options -> Devices -> Android
    + https://doc.qt.io/qtcreator/creator-developing-android.html#specifying-android-device-settings


#### iOS
  + Install XCode? is that is?
