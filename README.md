# BXCODE MTProto Proxy for Railway

هذا المشروع يشغل Telegram MTProto Proxy على Railway.

## مهم جداً: قناة الراعي

اسم القناة `BXCODE` وحده لا يكفي لإظهارها كـ Sponsored Channel.

بعد تشغيل البروكسي:
1. افتح @MTProxyBot في Telegram.
2. أرسل `/newproxy`.
3. أعطِ البوت عنوان الـ public TCP والـ port الخاص بـ Railway.
4. البوت سيعطيك Proxy Tag.
5. اختر Set promotion / Set channel وأرسل رابط القناة العامة:
   https://t.me/BXCODE
6. ضع الـ Proxy Tag في Railway Environment Variables باسم:
   PROXY_TAG

بعدها أعد نشر الخدمة.

Telegram يوضح أن تسجيل البروكسي مع @MTProxyBot ثم استخدام الـ tag مع `-P` هو طريقة ربط قناة الراعي بالبروكسي.

## Railway Variables

PORT=443
WORKERS=1
PROXY_SECRET=

PROXY_TAG=ضع_التاغ_الذي_يعطيك_إياه_MTProxyBot

إذا تركت PROXY_SECRET فارغاً سيتم توليد secret عشوائي عند كل تشغيل.
الأفضل وضع secret ثابت حتى لا يتغير رابط البروكسي بعد إعادة التشغيل.

## Public TCP

لازم يكون عندك TCP endpoint عام من Railway. الـ HTTP domain وحده لا يكفي لـ MTProto.

رابط البروكسي بعد معرفة الـ host والـ public port:

tg://proxy?server=HOST&port=PUBLIC_PORT&secret=SECRET

## ملاحظة

لا تضع @BXCODE أو BXCODE مباشرة داخل `-P`.
الذي يوضع في `-P` هو Proxy Tag الذي يعطيه @MTProxyBot.
