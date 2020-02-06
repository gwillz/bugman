
# Field Assistant (QML)
## Aka. Bugman


### TODO
- singleton naivgation
  - should fix double listener (onNavChanged: nav.onIndexChanged: {})
- fix home view first swipe panel
  - current workaround is gross
- fix camera
  - try android-28
- edit view buttons add/template
- text change create/edit buttons
- empty set view button
- about view
- migrate qlist to qmlpropertylist
- create csvwriter to replace csvbuilder
- fix entry block fields
- images:
    - image picker actions
    - load entry images
    - copy new entry images
    - export images zip

- refactor:
    - EntryField -> LouField
    - EntryDropField -> LouComboField

    - TemplateModel.qml -> TemplateModel.js
- remove:
    - EntryFieldModel
    - TemplateFieldModel
    - TemplateModel
