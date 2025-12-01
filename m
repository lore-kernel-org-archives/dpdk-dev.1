Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C599D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 09:35:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43A784021F;
	Mon,  1 Dec 2025 10:35:30 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id EB7674021E
 for <dev@dpdk.org>; Mon,  1 Dec 2025 10:35:28 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dKdzx1dKZzJ46p1;
 Mon,  1 Dec 2025 17:35:25 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id 4E1374056B;
 Mon,  1 Dec 2025 17:35:28 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 1 Dec 2025 09:35:27 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 1 Dec 2025 09:35:27 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, 
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, Vipin Varghese
 <vipin.varghese@amd.com>
CC: Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH v3] eal/x86: optimize memcpy of small sizes
Thread-Topic: [PATCH v3] eal/x86: optimize memcpy of small sizes
Thread-Index: AQHcWtNXD+EKJWk0k0O6HEmUv7nh0LUIKREQgAAduhCAACfB0IAAh3yAgAOXQSA=
Date: Mon, 1 Dec 2025 09:35:27 +0000
Message-ID: <a67ae53332c24176902e1d98167a3142@huawei.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20251121104052.1273637-1-mb@smartsharesystems.com>
 <59db9d3d83d94ec9a7c26ae506fd4813@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6559E@smartserver.smartshare.dk>
 <11d412346d5548c5a5a3bf578b86f4ee@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655A0@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F655A0@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.175.246]
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

DQoNCj4gPiA+ID4gPiArLyoqDQo+ID4gPiA+ID4gKyAqIENvcHkgYnl0ZXMgZnJvbSBvbmUgbG9j
YXRpb24gdG8gYW5vdGhlciwNCj4gPiA+ID4gPiArICogbG9jYXRpb25zIHNob3VsZCBub3Qgb3Zl
cmxhcC4NCj4gPiA+ID4gPiArICogVXNlIHdpdGggbiA8PSAxNi4NCj4gPiA+ID4gPiArICoNCj4g
PiA+ID4gPiArICogTm90ZTogQ29weWluZyB1bmluaXRpYWxpemVkIG1lbW9yeSBpcyBwZXJmZWN0
bHkgYWNjZXB0YWJsZS4NCj4gPiA+ID4gPiArICogVXNpbmcgZS5nLiBtZW1jcHkoZHN0LCBzcmMs
IDgpIGluc3RlYWQgb2YNCj4gPiA+ID4gPiArICogKih1bmFsaWduZWRfdWludDY0X3QqKSA9ICoo
Y29uc3QgdW5hbGlnbmVkX3VpbnQ2NF90ICopc3JjDQo+ID4gPiA+ID4gKyAqIGF2b2lkcyBjb21w
aWxlciB3YXJuaW5ncyBhYm91dCBzb3VyY2UgZGF0YSBtYXkgYmUNCj4gPiB1bmluaXRpYWxpemVk
DQo+ID4gPiA+ID4gKyAqIFstV21heWJlLXVuaW5pdGlhbGl6ZWRdLg0KPiA+ID4gPiA+ICsgKg0K
PiA+ID4gPiA+ICsgKiBOb3RlOiBVc2luZyAibiAmIFgiIGdlbmVyYXRlcyAzLWJ5dGUgInRlc3Qi
IGluc3RydWN0aW9ucywNCj4gPiA+ID4gPiArICogaW5zdGVhZCBvZiAibiA+PSBYIiwgd2hpY2gg
d291bGQgZ2VuZXJhdGUgNC1ieXRlICJjbXAiDQo+ID4gPiA+IGluc3RydWN0aW9ucy4NCj4gPiA+
ID4gPiArICovDQo+ID4gPiA+ID4gK3N0YXRpYyBfX3J0ZV9hbHdheXNfaW5saW5lIHZvaWQgKg0K
PiA+ID4gPiA+ICtydGVfbW92MTZfb3JfbGVzcyh2b2lkICpkc3QsIGNvbnN0IHZvaWQgKnNyYywg
c2l6ZV90IG4pDQo+ID4gPiA+ID4gK3sNCj4gPiA+ID4gPiArCS8qIEZhc3RlciB3YXkgd2hlbiBz
aXplIGlzIGtub3duIGF0IGJ1aWxkIHRpbWUuICovDQo+ID4gPiA+ID4gKwlpZiAoX19ydGVfY29u
c3RhbnQobikpIHsNCj4gPiA+ID4gPiArCQlpZiAobiA9PSAyKQ0KPiA+ID4gPiA+ICsJCQlyZXR1
cm4gbWVtY3B5KGRzdCwgc3JjLCAyKTsNCj4gPiA+ID4gPiArCQlpZiAobiA9PSA0KQ0KPiA+ID4g
PiA+ICsJCQlyZXR1cm4gbWVtY3B5KGRzdCwgc3JjLCA0KTsNCj4gPiA+ID4gPiArCQlpZiAobiA9
PSA2KSAvKiA0ICsgMiAqLw0KPiA+ID4gPiA+ICsJCQlyZXR1cm4gbWVtY3B5KGRzdCwgc3JjLCA2
KTsNCj4gPiA+ID4gPiArCQlpZiAobiA9PSA4KQ0KPiA+ID4gPiA+ICsJCQlyZXR1cm4gbWVtY3B5
KGRzdCwgc3JjLCA4KTsNCj4gPiA+ID4gPiArCQlpZiAobiA9PSAxMCkgLyogOCArIDIgKi8NCj4g
PiA+ID4gPiArCQkJcmV0dXJuIG1lbWNweShkc3QsIHNyYywgMTApOw0KPiA+ID4gPiA+ICsJCWlm
IChuID09IDEyKSAvKiA4ICsgNCAqLw0KPiA+ID4gPiA+ICsJCQlyZXR1cm4gbWVtY3B5KGRzdCwg
c3JjLCAxMik7DQo+ID4gPiA+ID4gKwkJaWYgKG4gPT0gMTYpIHsNCj4gPiA+ID4gPiArCQkJcnRl
X21vdjE2KCh1aW50OF90ICopZHN0LCAoY29uc3QgdWludDhfdA0KPiA+ICopc3JjKTsNCj4gPiA+
ID4gPiArCQkJcmV0dXJuIGRzdDsNCj4gPiA+ID4gPiArCQl9DQo+ID4gPiA+ID4gKwl9DQo+ID4g
PiA+ID4gKw0KPiA+ID4gPiA+ICsJaWYgKG4gJiAweDE4KSB7IC8qIG4gPj0gOCAqLw0KPiA+ID4g
Pg0KPiA+ID4gPiBQcm9iYWJseSAnbiAmIDB4OCc/DQo+ID4gPg0KPiA+ID4gSXQncyBpbnRlbnRp
b25hbCwgdG8gY2F0Y2ggbiA9PSAweDEwIHRvby4NCj4gPiA+IEl0IHNlZW1zIHRoZSBhc3NvY2lh
dGVkIGNvbW1lbnQgc2hvdWxkIGJlIG1vcmUgdmVyYm9zZS4gSG93IGFib3V0Og0KPiA+ID4gaWYg
KG4gJiAweDE4KSB7IC8qIG4gPj0gOCwgaW5jbHVkaW5nIG4gPT0gMHgxMCwgaGVuY2UgbiAmIDB4
MTggKi8NCj4gPg0KPiA+IE9rLCB3aHkganVzdCBub3Qgc2ltcGx5IDogaWYgKG4gPj0gOCkgdGhl
bj8NCj4gDQo+IFRoZSByZWFzb24gbWVudGlvbmVkIGluIHRoZSBmdW5jdGlvbiBkZXNjcmlwdGlv
bjoNCj4gICogTm90ZTogVXNpbmcgIm4gJiBYIiBnZW5lcmF0ZXMgMy1ieXRlICJ0ZXN0IiBpbnN0
cnVjdGlvbnMsDQo+ICAqIGluc3RlYWQgb2YgIm4gPj0gWCIsIHdoaWNoIHdvdWxkIGdlbmVyYXRl
IDQtYnl0ZSAiY21wIiBpbnN0cnVjdGlvbnMuDQpBaCwgSSBzZWUgdGhlIGNvbW1lbnQgbm93LCBz
b3JyeSBtaXNzZWQgaXQgZmlyc3QgdGltZS4NCkluZGVlZCAnY21wJyBXaWxsIGJlIG9uZSBieXRl
IGxvbmdlci4NClRob3VnaCBmb3Igbm9uLWNvbnN0YW50ICduJyBnY2MgZ2VuZXJhdGVzIDkwQiBv
ZiBjb2RlIGZvciBib3RoIHZlcnNpb25zOg0KaHR0cHM6Ly9nb2Rib2x0Lm9yZy96L0s2ODYxcUdj
cg0KDQogDQo+IA0KPiBJJ2xsIG1vdmUgdGhhdCBjb21tZW50IGRvd24gaGVyZSwganVzdCBiZWZv
cmUgdGhlIGNvbXBhcmlzb25zLg0KPiANCj4gPg0KPiA+ID4gPg0KPiA+ID4gPiA+ICsJCS8qIGNv
cHkgOCB+IDE2IGJ5dGVzICovDQo+ID4gPiA+ID4gKwkJbWVtY3B5KGRzdCwgc3JjLCA4KTsNCj4g
PiA+ID4gPiArCQltZW1jcHkoKHVpbnQ4X3QgKilkc3QgLSA4ICsgbiwgKGNvbnN0IHVpbnQ4X3Qg
KilzcmMgLQ0KPiA+IDggKw0KPiA+ID4gPiBuLCA4KTsNCj4gPiA+ID4gPiArCX0gZWxzZSBpZiAo
biAmIDB4NCkgew0KPiA+ID4gPiA+ICsJCS8qIGNvcHkgNCB+IDcgYnl0ZXMgKi8NCj4gPiA+ID4g
PiArCQltZW1jcHkoZHN0LCBzcmMsIDQpOw0KPiA+ID4gPiA+ICsJCW1lbWNweSgodWludDhfdCAq
KWRzdCAtIDQgKyBuLCAoY29uc3QgdWludDhfdCAqKXNyYyAtDQo+ID4gNCArDQo+ID4gPiA+IG4s
IDQpOw0KPiA+ID4gPiA+ICsJfSBlbHNlIGlmIChuICYgMHgyKSB7DQo+ID4gPiA+ID4gKwkJLyog
Y29weSAyIH4gMyBieXRlcyAqLw0KPiA+ID4gPiA+ICsJCW1lbWNweShkc3QsIHNyYywgMik7DQo+
ID4gPiA+ID4gKwkJbWVtY3B5KCh1aW50OF90ICopZHN0IC0gMiArIG4sIChjb25zdCB1aW50OF90
ICopc3JjIC0NCj4gPiAyICsNCj4gPiA+ID4gbiwgMik7DQo+ID4gPiA+ID4gKwl9IGVsc2UgaWYg
KG4gJiAweDEpIHsNCj4gPiA+ID4gPiArCQkvKiBjb3B5IDEgYnl0ZSAqLw0KPiA+ID4gPiA+ICsJ
CW1lbWNweShkc3QsIHNyYywgMSk7DQo+ID4gPiA+ID4gKwl9DQo+ID4gPiA+ID4gKwlyZXR1cm4g
ZHN0Ow0KPiA+ID4gPiA+ICt9DQo=
