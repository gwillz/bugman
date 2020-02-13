
# Field Assistant (QML)
## Aka. Bugman


### TODO

#### features
- about view
- images picker:
    - signals, pass path to edit view
    - kinda jumps when closing
    - record/copy images
- entry view:
    - add/remove images
- export images zip

#### fixes
- fix home view first swipe panel
    - current workaround is gross
- fix editing sets
- remove filter hack fix after 5.14.2 update

#### housework
- separate entry types into separate files
- some docs/comments
- onTextChanged in EntryField and TemplateField is kinda dodgey

#### future
- swipedelegate for editing template fields
- swipedelegate for switch..?
- more field types
    - range (from, to)
    - combobox (list of options)


### Development

+ Install Qt 5.14.2+
+ Install Java 8
+ Install Android Studio

+ Use the Android Studio SDK Manager:
    + Install NDK v20+ (v29.0.3)
    + Install SDK v21+ (v29)

#### Android

+ Configure QtCreator:
    + Update to 4.11.1+
    + Set Paths: Tools -> Options -> Devices -> Android
    + https://doc.qt.io/qtcreator/creator-developing-android.html#specifying-android-device-settings

##### Notes
+ The android camera is broken in Qt 5.14, fixed in 5.14.2
+ Deploying android for release (signed & compiled) is broken in QtCreator 4.11, fixed in 4.11.1

#### iOS
+ Buy a Mac
+ Install XCode
+ Configure QtCreator, I assume?
