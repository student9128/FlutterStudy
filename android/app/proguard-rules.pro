# ref: https://github.com/firebase/firebase-android-sdk/blob/master/protolite-well-known-types/proguard-rules.pro

# protobuf-javalite has a bug that requires this workaround rule
# https://github.com/protocolbuffers/protobuf/issues/6463#issuecomment-553183215
-keepclassmembers class * extends com.google.protobuf.GeneratedMessageLite {
  <fields>;
}
-dontwarn com.google.zxing.**
-keep class com.google.zxing.**{*;}

-keepclasseswithmembernames class * { native <methods>; }

-keep class com.tencent.mm.opensdk.** {
    *;
}

-keep class com.tencent.wxop.** {
    *;
}

-keep class com.tencent.mm.sdk.** {
    *;
}

# 阿里云推送混淆配置
-keepclasseswithmembernames class ** {
    native <methods>;
}
-keepattributes Signature
-keep class sun.misc.Unsafe { *; }
-keep class com.taobao.** {*;}
-keep class com.alibaba.** {*;}
-keep class com.alipay.** {*;}
-keep class com.ut.** {*;}
-keep class com.ta.** {*;}
-keep class anet.**{*;}
-keep class anetwork.**{*;}
-keep class org.android.spdy.**{*;}
-keep class org.android.agoo.**{*;}
-keep class android.os.**{*;}
-keep class org.json.**{*;}
-dontwarn com.taobao.**
-dontwarn com.alibaba.**
-dontwarn com.alipay.**
-dontwarn anet.**
-dontwarn org.android.spdy.**
-dontwarn org.android.agoo.**
-dontwarn anetwork.**
-dontwarn com.ut.**
-dontwarn com.ta.**


# 华为通道
-keep class com.huawei.** {*;}
-dontwarn com.huawei.**

# 小米通道
-keep class com.xiaomi.** {*;}
-dontwarn com.xiaomi.**

# OPPO通道
-keep public class * extends android.app.Service

# 魅族通道
-keep class com.meizu.cloud.** {*;}
-dontwarn com.meizu.cloud.**

# VIVO通道
-keep class com.vivo.** {*;}
-dontwarn com.vivo.**

# GCM/FCM通道
-keep class com.google.firebase.**{*;}
-dontwarn com.google.firebase.**

-keep class com.baidu.location.** {*;}
-keep class com.baidu.** {*;}
-keep class vi.com.** {*;}
-keep class com.baidu.vi.** {*;}
-dontwarn com.baidu.**