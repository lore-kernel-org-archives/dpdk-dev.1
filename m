Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03D0D116EA
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 18:10:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00E4D402CB;
	Fri, 28 Nov 2025 19:10:36 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 16182402C8
 for <dev@dpdk.org>; Fri, 28 Nov 2025 19:10:34 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dJ1Xk5btYzHnGdR;
 Sat, 29 Nov 2025 02:09:42 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id AD4CE140136;
 Sat, 29 Nov 2025 02:10:33 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Nov 2025 18:10:33 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Fri, 28 Nov 2025 18:10:32 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, 
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, Vipin Varghese
 <vipin.varghese@amd.com>
CC: Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH v3] eal/x86: optimize memcpy of small sizes
Thread-Topic: [PATCH v3] eal/x86: optimize memcpy of small sizes
Thread-Index: AQHcWtNXD+EKJWk0k0O6HEmUv7nh0LUIKREQgAAduhCAACfB0A==
Date: Fri, 28 Nov 2025 18:10:32 +0000
Message-ID: <11d412346d5548c5a5a3bf578b86f4ee@huawei.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20251121104052.1273637-1-mb@smartsharesystems.com>
 <59db9d3d83d94ec9a7c26ae506fd4813@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6559E@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6559E@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

DQoNCj4gPiBGcm9tOiBLb25zdGFudGluIEFuYW55ZXYgW21haWx0bzprb25zdGFudGluLmFuYW55
ZXZAaHVhd2VpLmNvbV0NCj4gPiBTZW50OiBGcmlkYXksIDI4IE5vdmVtYmVyIDIwMjUgMTUuMDMN
Cj4gPg0KPiA+ID4gKy8qKg0KPiA+ID4gKyAqIENvcHkgYnl0ZXMgZnJvbSBvbmUgbG9jYXRpb24g
dG8gYW5vdGhlciwNCj4gPiA+ICsgKiBsb2NhdGlvbnMgc2hvdWxkIG5vdCBvdmVybGFwLg0KPiA+
ID4gKyAqIFVzZSB3aXRoIG4gPD0gMTYuDQo+ID4gPiArICoNCj4gPiA+ICsgKiBOb3RlOiBDb3B5
aW5nIHVuaW5pdGlhbGl6ZWQgbWVtb3J5IGlzIHBlcmZlY3RseSBhY2NlcHRhYmxlLg0KPiA+ID4g
KyAqIFVzaW5nIGUuZy4gbWVtY3B5KGRzdCwgc3JjLCA4KSBpbnN0ZWFkIG9mDQo+ID4gPiArICog
Kih1bmFsaWduZWRfdWludDY0X3QqKSA9ICooY29uc3QgdW5hbGlnbmVkX3VpbnQ2NF90ICopc3Jj
DQo+ID4gPiArICogYXZvaWRzIGNvbXBpbGVyIHdhcm5pbmdzIGFib3V0IHNvdXJjZSBkYXRhIG1h
eSBiZSB1bmluaXRpYWxpemVkDQo+ID4gPiArICogWy1XbWF5YmUtdW5pbml0aWFsaXplZF0uDQo+
ID4gPiArICoNCj4gPiA+ICsgKiBOb3RlOiBVc2luZyAibiAmIFgiIGdlbmVyYXRlcyAzLWJ5dGUg
InRlc3QiIGluc3RydWN0aW9ucywNCj4gPiA+ICsgKiBpbnN0ZWFkIG9mICJuID49IFgiLCB3aGlj
aCB3b3VsZCBnZW5lcmF0ZSA0LWJ5dGUgImNtcCINCj4gPiBpbnN0cnVjdGlvbnMuDQo+ID4gPiAr
ICovDQo+ID4gPiArc3RhdGljIF9fcnRlX2Fsd2F5c19pbmxpbmUgdm9pZCAqDQo+ID4gPiArcnRl
X21vdjE2X29yX2xlc3Modm9pZCAqZHN0LCBjb25zdCB2b2lkICpzcmMsIHNpemVfdCBuKQ0KPiA+
ID4gK3sNCj4gPiA+ICsJLyogRmFzdGVyIHdheSB3aGVuIHNpemUgaXMga25vd24gYXQgYnVpbGQg
dGltZS4gKi8NCj4gPiA+ICsJaWYgKF9fcnRlX2NvbnN0YW50KG4pKSB7DQo+ID4gPiArCQlpZiAo
biA9PSAyKQ0KPiA+ID4gKwkJCXJldHVybiBtZW1jcHkoZHN0LCBzcmMsIDIpOw0KPiA+ID4gKwkJ
aWYgKG4gPT0gNCkNCj4gPiA+ICsJCQlyZXR1cm4gbWVtY3B5KGRzdCwgc3JjLCA0KTsNCj4gPiA+
ICsJCWlmIChuID09IDYpIC8qIDQgKyAyICovDQo+ID4gPiArCQkJcmV0dXJuIG1lbWNweShkc3Qs
IHNyYywgNik7DQo+ID4gPiArCQlpZiAobiA9PSA4KQ0KPiA+ID4gKwkJCXJldHVybiBtZW1jcHko
ZHN0LCBzcmMsIDgpOw0KPiA+ID4gKwkJaWYgKG4gPT0gMTApIC8qIDggKyAyICovDQo+ID4gPiAr
CQkJcmV0dXJuIG1lbWNweShkc3QsIHNyYywgMTApOw0KPiA+ID4gKwkJaWYgKG4gPT0gMTIpIC8q
IDggKyA0ICovDQo+ID4gPiArCQkJcmV0dXJuIG1lbWNweShkc3QsIHNyYywgMTIpOw0KPiA+ID4g
KwkJaWYgKG4gPT0gMTYpIHsNCj4gPiA+ICsJCQlydGVfbW92MTYoKHVpbnQ4X3QgKilkc3QsIChj
b25zdCB1aW50OF90ICopc3JjKTsNCj4gPiA+ICsJCQlyZXR1cm4gZHN0Ow0KPiA+ID4gKwkJfQ0K
PiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiArCWlmIChuICYgMHgxOCkgeyAvKiBuID49IDggKi8N
Cj4gPg0KPiA+IFByb2JhYmx5ICduICYgMHg4Jz8NCj4gDQo+IEl0J3MgaW50ZW50aW9uYWwsIHRv
IGNhdGNoIG4gPT0gMHgxMCB0b28uDQo+IEl0IHNlZW1zIHRoZSBhc3NvY2lhdGVkIGNvbW1lbnQg
c2hvdWxkIGJlIG1vcmUgdmVyYm9zZS4gSG93IGFib3V0Og0KPiBpZiAobiAmIDB4MTgpIHsgLyog
biA+PSA4LCBpbmNsdWRpbmcgbiA9PSAweDEwLCBoZW5jZSBuICYgMHgxOCAqLw0KDQpPaywgd2h5
IGp1c3Qgbm90IHNpbXBseSA6IGlmIChuID49IDgpIHRoZW4/DQoNCj4gPg0KPiA+ID4gKwkJLyog
Y29weSA4IH4gMTYgYnl0ZXMgKi8NCj4gPiA+ICsJCW1lbWNweShkc3QsIHNyYywgOCk7DQo+ID4g
PiArCQltZW1jcHkoKHVpbnQ4X3QgKilkc3QgLSA4ICsgbiwgKGNvbnN0IHVpbnQ4X3QgKilzcmMg
LSA4ICsNCj4gPiBuLCA4KTsNCj4gPiA+ICsJfSBlbHNlIGlmIChuICYgMHg0KSB7DQo+ID4gPiAr
CQkvKiBjb3B5IDQgfiA3IGJ5dGVzICovDQo+ID4gPiArCQltZW1jcHkoZHN0LCBzcmMsIDQpOw0K
PiA+ID4gKwkJbWVtY3B5KCh1aW50OF90ICopZHN0IC0gNCArIG4sIChjb25zdCB1aW50OF90ICop
c3JjIC0gNCArDQo+ID4gbiwgNCk7DQo+ID4gPiArCX0gZWxzZSBpZiAobiAmIDB4Mikgew0KPiA+
ID4gKwkJLyogY29weSAyIH4gMyBieXRlcyAqLw0KPiA+ID4gKwkJbWVtY3B5KGRzdCwgc3JjLCAy
KTsNCj4gPiA+ICsJCW1lbWNweSgodWludDhfdCAqKWRzdCAtIDIgKyBuLCAoY29uc3QgdWludDhf
dCAqKXNyYyAtIDIgKw0KPiA+IG4sIDIpOw0KPiA+ID4gKwl9IGVsc2UgaWYgKG4gJiAweDEpIHsN
Cj4gPiA+ICsJCS8qIGNvcHkgMSBieXRlICovDQo+ID4gPiArCQltZW1jcHkoZHN0LCBzcmMsIDEp
Ow0KPiA+ID4gKwl9DQo+ID4gPiArCXJldHVybiBkc3Q7DQo+ID4gPiArfQ0K
