SKIPUNZIP=0
echo [ 08:22:57 ]  开始解压精简文件
unzip -o -q $MODPATH/system/system.zip && rm -rf $MODPATH/system/system.zip
REPLACE="
/system/data-app
/system/recovery-from-boot.p
/system/app/AnalyticsCore
/system/app/MSA
/system/app/mab
/system/priv-app/ONS
/system/app/CarrierDefaultApp
/system/app/BasicDreams
/system/app/Traceur
/system/app/BookmarkProvider
/system/app/FidoAuthen
/system/app/FidoClient
/system/app/YouDaoEngine
/system/app/TranslationService
/system/app/HybridAccessory
/system/priv-app/UserDictionaryProvider
/system/product/app/PhotoTable
/system/product/app/talkback
/system/vendor/app/Joyose
/system/vendor/data-app
/system/vendor/app/CACertService
/system/vendor/app/CneApp
"
