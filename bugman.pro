TEMPLATE = subdirs

#SUBDIRS += \
#    bugman-qt/bugman.pro \
#    quazip/quazip/quazip.pro \
#    zlib.pro

SUBDIRS += \
    zlib.pro \
    quazip.pro \
    bugman-qt/bugman.pro

quazip.depends = zlib.pro
bugman.depends = quazip.pro
