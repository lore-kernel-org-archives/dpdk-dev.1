Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8885D111A8
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 10:41:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1F3540261;
	Mon,  1 Dec 2025 11:41:50 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A1DFD4013F
 for <dev@dpdk.org>; Mon,  1 Dec 2025 11:41:48 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 847F7202E1;
 Mon,  1 Dec 2025 11:41:47 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v3] eal/x86: optimize memcpy of small sizes
Date: Mon, 1 Dec 2025 11:41:45 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F655A7@smartserver.smartshare.dk>
In-Reply-To: <a67ae53332c24176902e1d98167a3142@huawei.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3] eal/x86: optimize memcpy of small sizes
Thread-Index: AQHcWtNXD+EKJWk0k0O6HEmUv7nh0LUIKREQgAAduhCAACfB0IAAh3yAgAOXQSCAABfZ0A==
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20251121104052.1273637-1-mb@smartsharesystems.com>
 <59db9d3d83d94ec9a7c26ae506fd4813@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6559E@smartserver.smartshare.dk>
 <11d412346d5548c5a5a3bf578b86f4ee@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655A0@smartserver.smartshare.dk>
 <a67ae53332c24176902e1d98167a3142@huawei.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, <dev@dpdk.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Konstantin Ananyev" <konstantin.v.ananyev@yandex.ru>,
 "Vipin Varghese" <vipin.varghese@amd.com>
Cc: "Stephen Hemminger" <stephen@networkplumber.org>
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

PiA+ID4gPiA+ID4gKy8qKg0KPiA+ID4gPiA+ID4gKyAqIENvcHkgYnl0ZXMgZnJvbSBvbmUgbG9j
YXRpb24gdG8gYW5vdGhlciwNCj4gPiA+ID4gPiA+ICsgKiBsb2NhdGlvbnMgc2hvdWxkIG5vdCBv
dmVybGFwLg0KPiA+ID4gPiA+ID4gKyAqIFVzZSB3aXRoIG4gPD0gMTYuDQo+ID4gPiA+ID4gPiAr
ICoNCj4gPiA+ID4gPiA+ICsgKiBOb3RlOiBDb3B5aW5nIHVuaW5pdGlhbGl6ZWQgbWVtb3J5IGlz
IHBlcmZlY3RseQ0KPiBhY2NlcHRhYmxlLg0KPiA+ID4gPiA+ID4gKyAqIFVzaW5nIGUuZy4gbWVt
Y3B5KGRzdCwgc3JjLCA4KSBpbnN0ZWFkIG9mDQo+ID4gPiA+ID4gPiArICogKih1bmFsaWduZWRf
dWludDY0X3QqKSA9ICooY29uc3QgdW5hbGlnbmVkX3VpbnQ2NF90ICopc3JjDQo+ID4gPiA+ID4g
PiArICogYXZvaWRzIGNvbXBpbGVyIHdhcm5pbmdzIGFib3V0IHNvdXJjZSBkYXRhIG1heSBiZQ0K
PiA+ID4gdW5pbml0aWFsaXplZA0KPiA+ID4gPiA+ID4gKyAqIFstV21heWJlLXVuaW5pdGlhbGl6
ZWRdLg0KPiA+ID4gPiA+ID4gKyAqDQo+ID4gPiA+ID4gPiArICogTm90ZTogVXNpbmcgIm4gJiBY
IiBnZW5lcmF0ZXMgMy1ieXRlICJ0ZXN0IiBpbnN0cnVjdGlvbnMsDQo+ID4gPiA+ID4gPiArICog
aW5zdGVhZCBvZiAibiA+PSBYIiwgd2hpY2ggd291bGQgZ2VuZXJhdGUgNC1ieXRlICJjbXAiDQo+
ID4gPiA+ID4gaW5zdHJ1Y3Rpb25zLg0KPiA+ID4gPiA+ID4gKyAqLw0KPiA+ID4gPiA+ID4gK3N0
YXRpYyBfX3J0ZV9hbHdheXNfaW5saW5lIHZvaWQgKg0KPiA+ID4gPiA+ID4gK3J0ZV9tb3YxNl9v
cl9sZXNzKHZvaWQgKmRzdCwgY29uc3Qgdm9pZCAqc3JjLCBzaXplX3QgbikNCj4gPiA+ID4gPiA+
ICt7DQo+ID4gPiA+ID4gPiArCS8qIEZhc3RlciB3YXkgd2hlbiBzaXplIGlzIGtub3duIGF0IGJ1
aWxkIHRpbWUuICovDQo+ID4gPiA+ID4gPiArCWlmIChfX3J0ZV9jb25zdGFudChuKSkgew0KPiA+
ID4gPiA+ID4gKwkJaWYgKG4gPT0gMikNCj4gPiA+ID4gPiA+ICsJCQlyZXR1cm4gbWVtY3B5KGRz
dCwgc3JjLCAyKTsNCj4gPiA+ID4gPiA+ICsJCWlmIChuID09IDQpDQo+ID4gPiA+ID4gPiArCQkJ
cmV0dXJuIG1lbWNweShkc3QsIHNyYywgNCk7DQo+ID4gPiA+ID4gPiArCQlpZiAobiA9PSA2KSAv
KiA0ICsgMiAqLw0KPiA+ID4gPiA+ID4gKwkJCXJldHVybiBtZW1jcHkoZHN0LCBzcmMsIDYpOw0K
PiA+ID4gPiA+ID4gKwkJaWYgKG4gPT0gOCkNCj4gPiA+ID4gPiA+ICsJCQlyZXR1cm4gbWVtY3B5
KGRzdCwgc3JjLCA4KTsNCj4gPiA+ID4gPiA+ICsJCWlmIChuID09IDEwKSAvKiA4ICsgMiAqLw0K
PiA+ID4gPiA+ID4gKwkJCXJldHVybiBtZW1jcHkoZHN0LCBzcmMsIDEwKTsNCj4gPiA+ID4gPiA+
ICsJCWlmIChuID09IDEyKSAvKiA4ICsgNCAqLw0KPiA+ID4gPiA+ID4gKwkJCXJldHVybiBtZW1j
cHkoZHN0LCBzcmMsIDEyKTsNCj4gPiA+ID4gPiA+ICsJCWlmIChuID09IDE2KSB7DQo+ID4gPiA+
ID4gPiArCQkJcnRlX21vdjE2KCh1aW50OF90ICopZHN0LCAoY29uc3QgdWludDhfdA0KPiA+ID4g
KilzcmMpOw0KPiA+ID4gPiA+ID4gKwkJCXJldHVybiBkc3Q7DQo+ID4gPiA+ID4gPiArCQl9DQo+
ID4gPiA+ID4gPiArCX0NCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsJaWYgKG4gJiAweDE4
KSB7IC8qIG4gPj0gOCAqLw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gUHJvYmFibHkgJ24gJiAweDgn
Pw0KPiA+ID4gPg0KPiA+ID4gPiBJdCdzIGludGVudGlvbmFsLCB0byBjYXRjaCBuID09IDB4MTAg
dG9vLg0KPiA+ID4gPiBJdCBzZWVtcyB0aGUgYXNzb2NpYXRlZCBjb21tZW50IHNob3VsZCBiZSBt
b3JlIHZlcmJvc2UuIEhvdw0KPiBhYm91dDoNCj4gPiA+ID4gaWYgKG4gJiAweDE4KSB7IC8qIG4g
Pj0gOCwgaW5jbHVkaW5nIG4gPT0gMHgxMCwgaGVuY2UgbiAmIDB4MTggKi8NCj4gPiA+DQo+ID4g
PiBPaywgd2h5IGp1c3Qgbm90IHNpbXBseSA6IGlmIChuID49IDgpIHRoZW4/DQo+ID4NCj4gPiBU
aGUgcmVhc29uIG1lbnRpb25lZCBpbiB0aGUgZnVuY3Rpb24gZGVzY3JpcHRpb246DQo+ID4gICog
Tm90ZTogVXNpbmcgIm4gJiBYIiBnZW5lcmF0ZXMgMy1ieXRlICJ0ZXN0IiBpbnN0cnVjdGlvbnMs
DQo+ID4gICogaW5zdGVhZCBvZiAibiA+PSBYIiwgd2hpY2ggd291bGQgZ2VuZXJhdGUgNC1ieXRl
ICJjbXAiDQo+IGluc3RydWN0aW9ucy4NCj4gQWgsIEkgc2VlIHRoZSBjb21tZW50IG5vdywgc29y
cnkgbWlzc2VkIGl0IGZpcnN0IHRpbWUuDQo+IEluZGVlZCAnY21wJyBXaWxsIGJlIG9uZSBieXRl
IGxvbmdlci4NCj4gVGhvdWdoIGZvciBub24tY29uc3RhbnQgJ24nIGdjYyBnZW5lcmF0ZXMgOTBC
IG9mIGNvZGUgZm9yIGJvdGgNCj4gdmVyc2lvbnM6DQo+IGh0dHBzOi8vZ29kYm9sdC5vcmcvei9L
Njg2MXFHY3INCg0KVHJ1ZS4gVGhlIHNhdmVkIGJ5dGUgYmVjb21lcyBhbiBleHRyYSBieXRlIG9m
IE5PUCBwYWRkaW5nLg0KDQpUaGVyZSBtaWdodCBhbHNvIGJlIG9wcG9ydHVuaXR5IHRvIGVsaW1p
bmF0ZSBvbmUgbW9yZSBicmFuY2ggYnkgcmVvcmdhbml6aW5nIHRoZSBvdXRlciBjb21wYXJpc29u
IGxpa2Ugc286DQoNCmlmIChuIDw9IDMyKQ0KCWlmIChuIDw9IDE2KQ0KCQlyZXR1cm4gcnRlX21v
djE2X29yX2xlc3MgKGRzdCwgc3JjLCBuKTsNCgllbHNlDQoJCXJldHVybiBydGVfbW92MTdfdG9f
MzIoZHN0LCBzcmMsIG4pOw0KZWxzZSBpZiAobiA8PSA2NCkNCglyZXR1cm4gcnRlX21vdjMzX3Rv
XzY0KGRzdCwgc3JjLCBuKTsNCg0KT3I6DQoNCmlmIChuIDw9IDE2KQ0KCXJldHVybiBydGVfbW92
MTZfb3JfbGVzcyAoZHN0LCBzcmMsIG4pOw0KZWxzZSBpZiAobiA8PSA2NCkNCglpZiAobiA8PSAz
MikNCgkJcmV0dXJuIHJ0ZV9tb3YxN190b18zMihkc3QsIHNyYywgbik7DQoJZWxzZQ0KCQlyZXR1
cm4gcnRlX21vdjMzX3RvXzY0KGRzdCwgc3JjLCBuKTsNCg0KSSdsbCBwbGF5IGFyb3VuZCB3aXRo
IGl0IHNvbWUgbW9yZSBhbmQgcG9zdCBhIHY0Lg0KDQo+IA0KPiANCj4gPg0KPiA+IEknbGwgbW92
ZSB0aGF0IGNvbW1lbnQgZG93biBoZXJlLCBqdXN0IGJlZm9yZSB0aGUgY29tcGFyaXNvbnMuDQo+
ID4NCj4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICsJCS8qIGNvcHkgOCB+IDE2IGJ5dGVz
ICovDQo+ID4gPiA+ID4gPiArCQltZW1jcHkoZHN0LCBzcmMsIDgpOw0KPiA+ID4gPiA+ID4gKwkJ
bWVtY3B5KCh1aW50OF90ICopZHN0IC0gOCArIG4sIChjb25zdCB1aW50OF90ICopc3JjIC0NCj4g
PiA+IDggKw0KPiA+ID4gPiA+IG4sIDgpOw0KPiA+ID4gPiA+ID4gKwl9IGVsc2UgaWYgKG4gJiAw
eDQpIHsNCj4gPiA+ID4gPiA+ICsJCS8qIGNvcHkgNCB+IDcgYnl0ZXMgKi8NCj4gPiA+ID4gPiA+
ICsJCW1lbWNweShkc3QsIHNyYywgNCk7DQo+ID4gPiA+ID4gPiArCQltZW1jcHkoKHVpbnQ4X3Qg
Kilkc3QgLSA0ICsgbiwgKGNvbnN0IHVpbnQ4X3QgKilzcmMgLQ0KPiA+ID4gNCArDQo+ID4gPiA+
ID4gbiwgNCk7DQo+ID4gPiA+ID4gPiArCX0gZWxzZSBpZiAobiAmIDB4Mikgew0KPiA+ID4gPiA+
ID4gKwkJLyogY29weSAyIH4gMyBieXRlcyAqLw0KPiA+ID4gPiA+ID4gKwkJbWVtY3B5KGRzdCwg
c3JjLCAyKTsNCj4gPiA+ID4gPiA+ICsJCW1lbWNweSgodWludDhfdCAqKWRzdCAtIDIgKyBuLCAo
Y29uc3QgdWludDhfdCAqKXNyYyAtDQo+ID4gPiAyICsNCj4gPiA+ID4gPiBuLCAyKTsNCj4gPiA+
ID4gPiA+ICsJfSBlbHNlIGlmIChuICYgMHgxKSB7DQo+ID4gPiA+ID4gPiArCQkvKiBjb3B5IDEg
Ynl0ZSAqLw0KPiA+ID4gPiA+ID4gKwkJbWVtY3B5KGRzdCwgc3JjLCAxKTsNCj4gPiA+ID4gPiA+
ICsJfQ0KPiA+ID4gPiA+ID4gKwlyZXR1cm4gZHN0Ow0KPiA+ID4gPiA+ID4gK30NCg==
