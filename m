Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3905FD116EA
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Nov 2025 02:17:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC8B14021F;
	Sat, 29 Nov 2025 03:17:22 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 05AE34013F
 for <dev@dpdk.org>; Sat, 29 Nov 2025 03:17:21 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A673F20698;
 Sat, 29 Nov 2025 03:17:21 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Subject: RE: [PATCH v3] eal/x86: optimize memcpy of small sizes
Content-Transfer-Encoding: base64
Date: Sat, 29 Nov 2025 03:17:16 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F655A0@smartserver.smartshare.dk>
In-Reply-To: <11d412346d5548c5a5a3bf578b86f4ee@huawei.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3] eal/x86: optimize memcpy of small sizes
Thread-Index: AQHcWtNXD+EKJWk0k0O6HEmUv7nh0LUIKREQgAAduhCAACfB0IAAh3yA
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20251121104052.1273637-1-mb@smartsharesystems.com>
 <59db9d3d83d94ec9a7c26ae506fd4813@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6559E@smartserver.smartshare.dk>
 <11d412346d5548c5a5a3bf578b86f4ee@huawei.com>
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

PiBGcm9tOiBLb25zdGFudGluIEFuYW55ZXYgW21haWx0bzprb25zdGFudGluLmFuYW55ZXZAaHVh
d2VpLmNvbV0NCj4gU2VudDogRnJpZGF5LCAyOCBOb3ZlbWJlciAyMDI1IDE5LjExDQo+IA0KPiA+
ID4gRnJvbTogS29uc3RhbnRpbiBBbmFueWV2IFttYWlsdG86a29uc3RhbnRpbi5hbmFueWV2QGh1
YXdlaS5jb21dDQo+ID4gPiBTZW50OiBGcmlkYXksIDI4IE5vdmVtYmVyIDIwMjUgMTUuMDMNCj4g
PiA+DQo+ID4gPiA+ICsvKioNCj4gPiA+ID4gKyAqIENvcHkgYnl0ZXMgZnJvbSBvbmUgbG9jYXRp
b24gdG8gYW5vdGhlciwNCj4gPiA+ID4gKyAqIGxvY2F0aW9ucyBzaG91bGQgbm90IG92ZXJsYXAu
DQo+ID4gPiA+ICsgKiBVc2Ugd2l0aCBuIDw9IDE2Lg0KPiA+ID4gPiArICoNCj4gPiA+ID4gKyAq
IE5vdGU6IENvcHlpbmcgdW5pbml0aWFsaXplZCBtZW1vcnkgaXMgcGVyZmVjdGx5IGFjY2VwdGFi
bGUuDQo+ID4gPiA+ICsgKiBVc2luZyBlLmcuIG1lbWNweShkc3QsIHNyYywgOCkgaW5zdGVhZCBv
Zg0KPiA+ID4gPiArICogKih1bmFsaWduZWRfdWludDY0X3QqKSA9ICooY29uc3QgdW5hbGlnbmVk
X3VpbnQ2NF90ICopc3JjDQo+ID4gPiA+ICsgKiBhdm9pZHMgY29tcGlsZXIgd2FybmluZ3MgYWJv
dXQgc291cmNlIGRhdGEgbWF5IGJlDQo+IHVuaW5pdGlhbGl6ZWQNCj4gPiA+ID4gKyAqIFstV21h
eWJlLXVuaW5pdGlhbGl6ZWRdLg0KPiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIE5vdGU6IFVzaW5n
ICJuICYgWCIgZ2VuZXJhdGVzIDMtYnl0ZSAidGVzdCIgaW5zdHJ1Y3Rpb25zLA0KPiA+ID4gPiAr
ICogaW5zdGVhZCBvZiAibiA+PSBYIiwgd2hpY2ggd291bGQgZ2VuZXJhdGUgNC1ieXRlICJjbXAi
DQo+ID4gPiBpbnN0cnVjdGlvbnMuDQo+ID4gPiA+ICsgKi8NCj4gPiA+ID4gK3N0YXRpYyBfX3J0
ZV9hbHdheXNfaW5saW5lIHZvaWQgKg0KPiA+ID4gPiArcnRlX21vdjE2X29yX2xlc3Modm9pZCAq
ZHN0LCBjb25zdCB2b2lkICpzcmMsIHNpemVfdCBuKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArCS8q
IEZhc3RlciB3YXkgd2hlbiBzaXplIGlzIGtub3duIGF0IGJ1aWxkIHRpbWUuICovDQo+ID4gPiA+
ICsJaWYgKF9fcnRlX2NvbnN0YW50KG4pKSB7DQo+ID4gPiA+ICsJCWlmIChuID09IDIpDQo+ID4g
PiA+ICsJCQlyZXR1cm4gbWVtY3B5KGRzdCwgc3JjLCAyKTsNCj4gPiA+ID4gKwkJaWYgKG4gPT0g
NCkNCj4gPiA+ID4gKwkJCXJldHVybiBtZW1jcHkoZHN0LCBzcmMsIDQpOw0KPiA+ID4gPiArCQlp
ZiAobiA9PSA2KSAvKiA0ICsgMiAqLw0KPiA+ID4gPiArCQkJcmV0dXJuIG1lbWNweShkc3QsIHNy
YywgNik7DQo+ID4gPiA+ICsJCWlmIChuID09IDgpDQo+ID4gPiA+ICsJCQlyZXR1cm4gbWVtY3B5
KGRzdCwgc3JjLCA4KTsNCj4gPiA+ID4gKwkJaWYgKG4gPT0gMTApIC8qIDggKyAyICovDQo+ID4g
PiA+ICsJCQlyZXR1cm4gbWVtY3B5KGRzdCwgc3JjLCAxMCk7DQo+ID4gPiA+ICsJCWlmIChuID09
IDEyKSAvKiA4ICsgNCAqLw0KPiA+ID4gPiArCQkJcmV0dXJuIG1lbWNweShkc3QsIHNyYywgMTIp
Ow0KPiA+ID4gPiArCQlpZiAobiA9PSAxNikgew0KPiA+ID4gPiArCQkJcnRlX21vdjE2KCh1aW50
OF90ICopZHN0LCAoY29uc3QgdWludDhfdA0KPiAqKXNyYyk7DQo+ID4gPiA+ICsJCQlyZXR1cm4g
ZHN0Ow0KPiA+ID4gPiArCQl9DQo+ID4gPiA+ICsJfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICsJaWYg
KG4gJiAweDE4KSB7IC8qIG4gPj0gOCAqLw0KPiA+ID4NCj4gPiA+IFByb2JhYmx5ICduICYgMHg4
Jz8NCj4gPg0KPiA+IEl0J3MgaW50ZW50aW9uYWwsIHRvIGNhdGNoIG4gPT0gMHgxMCB0b28uDQo+
ID4gSXQgc2VlbXMgdGhlIGFzc29jaWF0ZWQgY29tbWVudCBzaG91bGQgYmUgbW9yZSB2ZXJib3Nl
LiBIb3cgYWJvdXQ6DQo+ID4gaWYgKG4gJiAweDE4KSB7IC8qIG4gPj0gOCwgaW5jbHVkaW5nIG4g
PT0gMHgxMCwgaGVuY2UgbiAmIDB4MTggKi8NCj4gDQo+IE9rLCB3aHkganVzdCBub3Qgc2ltcGx5
IDogaWYgKG4gPj0gOCkgdGhlbj8NCg0KVGhlIHJlYXNvbiBtZW50aW9uZWQgaW4gdGhlIGZ1bmN0
aW9uIGRlc2NyaXB0aW9uOg0KICogTm90ZTogVXNpbmcgIm4gJiBYIiBnZW5lcmF0ZXMgMy1ieXRl
ICJ0ZXN0IiBpbnN0cnVjdGlvbnMsDQogKiBpbnN0ZWFkIG9mICJuID49IFgiLCB3aGljaCB3b3Vs
ZCBnZW5lcmF0ZSA0LWJ5dGUgImNtcCIgaW5zdHJ1Y3Rpb25zLg0KDQpJJ2xsIG1vdmUgdGhhdCBj
b21tZW50IGRvd24gaGVyZSwganVzdCBiZWZvcmUgdGhlIGNvbXBhcmlzb25zLg0KDQo+IA0KPiA+
ID4NCj4gPiA+ID4gKwkJLyogY29weSA4IH4gMTYgYnl0ZXMgKi8NCj4gPiA+ID4gKwkJbWVtY3B5
KGRzdCwgc3JjLCA4KTsNCj4gPiA+ID4gKwkJbWVtY3B5KCh1aW50OF90ICopZHN0IC0gOCArIG4s
IChjb25zdCB1aW50OF90ICopc3JjIC0NCj4gOCArDQo+ID4gPiBuLCA4KTsNCj4gPiA+ID4gKwl9
IGVsc2UgaWYgKG4gJiAweDQpIHsNCj4gPiA+ID4gKwkJLyogY29weSA0IH4gNyBieXRlcyAqLw0K
PiA+ID4gPiArCQltZW1jcHkoZHN0LCBzcmMsIDQpOw0KPiA+ID4gPiArCQltZW1jcHkoKHVpbnQ4
X3QgKilkc3QgLSA0ICsgbiwgKGNvbnN0IHVpbnQ4X3QgKilzcmMgLQ0KPiA0ICsNCj4gPiA+IG4s
IDQpOw0KPiA+ID4gPiArCX0gZWxzZSBpZiAobiAmIDB4Mikgew0KPiA+ID4gPiArCQkvKiBjb3B5
IDIgfiAzIGJ5dGVzICovDQo+ID4gPiA+ICsJCW1lbWNweShkc3QsIHNyYywgMik7DQo+ID4gPiA+
ICsJCW1lbWNweSgodWludDhfdCAqKWRzdCAtIDIgKyBuLCAoY29uc3QgdWludDhfdCAqKXNyYyAt
DQo+IDIgKw0KPiA+ID4gbiwgMik7DQo+ID4gPiA+ICsJfSBlbHNlIGlmIChuICYgMHgxKSB7DQo+
ID4gPiA+ICsJCS8qIGNvcHkgMSBieXRlICovDQo+ID4gPiA+ICsJCW1lbWNweShkc3QsIHNyYywg
MSk7DQo+ID4gPiA+ICsJfQ0KPiA+ID4gPiArCXJldHVybiBkc3Q7DQo+ID4gPiA+ICt9DQo=
