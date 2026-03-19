Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E0C109022C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 13:55:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 711DC402E9;
	Thu, 19 Mar 2026 14:55:14 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 574154025D;
 Thu, 19 Mar 2026 14:55:13 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1FA06205CA;
 Thu, 19 Mar 2026 14:55:13 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v2] mbuf: fix read packet data
Date: Thu, 19 Mar 2026 14:55:11 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657A6@smartserver.smartshare.dk>
In-Reply-To: <71be4d5ba80847d3994012a082fc42d6@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [PATCH v2] mbuf: fix read packet data
Thread-Index: AQHct54NPTc54bXoC0m5ZJ+QMc+jJLW11CBggAAHG1A=
References: <20260319084048.652493-1-mb@smartsharesystems.com>
 <20260319124329.729034-1-mb@smartsharesystems.com>
 <71be4d5ba80847d3994012a082fc42d6@huawei.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, <dev@dpdk.org>,
 "Marat Khalili" <marat.khalili@huawei.com>
Cc: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Christophe Fontaine" <cfontain@redhat.com>,
 "Konstantin Ananyev" <konstantin.v.ananyev@yandex.ru>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>, <stable@dpdk.org>
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

PiA+IGRpZmYgLS1naXQgYS9saWIvbWJ1Zi9ydGVfbWJ1Zi5jIGIvbGliL21idWYvcnRlX21idWYu
Yw0KPiA+IGluZGV4IGE1ZDE2ZTRjOTcuLmMyNDc2ZTc3MDQgMTAwNjQ0DQo+ID4gLS0tIGEvbGli
L21idWYvcnRlX21idWYuYw0KPiA+ICsrKyBiL2xpYi9tYnVmL3J0ZV9tYnVmLmMNCj4gPiBAQCAt
Nzk1LDcgKzc5NSw3IEBAIGNvbnN0IHZvaWQgKl9fcnRlX3BrdG1idWZfcmVhZChjb25zdCBzdHJ1
Y3QNCj4gcnRlX21idWYNCj4gPiAqbSwgdWludDMyX3Qgb2ZmLA0KPiA+ICAJY29uc3Qgc3RydWN0
IHJ0ZV9tYnVmICpzZWcgPSBtOw0KPiA+ICAJdWludDMyX3QgYnVmX29mZiA9IDAsIGNvcHlfbGVu
Ow0KPiA+DQo+ID4gLQlpZiAob2ZmICsgbGVuID4gcnRlX3BrdG1idWZfcGt0X2xlbihtKSkNCj4g
PiArCWlmICgodWludDY0X3Qpb2ZmICsgbGVuID4gcnRlX3BrdG1idWZfcGt0X2xlbihtKSkNCj4g
DQo+IFRoYW5rcyBNb3J0ZW4gZm9yIGFkZHJlc3NpbmcgaXQuDQo+IEp1c3QgYXMgYSBuaXQsIGZv
ciAzMi1iaXQgc3lzdGVtcywgd291bGRuJ3QgaXQgYmUgbW9yZSBmcmllbmRseToNCj4gSWYgKG9m
ZiArIGxlbiA8IG9mZiB8fCBvZmYgKyBsZW4gPiBydGVfcGt0bWJ1Zl9wa3RfbGVuKG0pKQ0KPiA/
DQo+IFNhbWUgZm9yIGNvbXBhcmlzb24gaW4gcnRlX3BrdG1idWZfcmVhZCgpLg0KDQpOZWF0IHRy
aWNrLg0KSSB0aGluayBleHBhbmRpbmcgdG8gNjQgYml0IGlzIGVhc2llciByZWFkYWJsZSwgc28g
SSdkIHJhdGhlciBzdGljayB3aXRoIHRoYXQuDQoNCkFsc28sIHdoaWxlIHRoZSB0cmljayBpcyBw
cm9iYWJseSBmYXN0ZXIgZm9yIDMyIGJpdCwgdGhlcmUgaXMgYSByaXNrIGl0IGNvdWxkIGJlIHNs
b3dlciBmb3IgNjQgYml0LCB3aGVyZSBJIGV4cGVjdCBleHBhbmRpbmcgdG8gNjQgYml0IGhhcyBu
ZWFyIHplcm8gY29zdC4NCldlIGNvdWxkIHNvbHZlIHRoYXQgYnkgYWRkaW5nICNpZmRlZnMgZm9y
IDMyLzY0IGJpdCBhcmNoaXRlY3R1cmVzLCBidXQgSSB0aGluayBtYW55IHBlb3BsZSBpbiB0aGUg
Y29tbXVuaXR5IHdvdWxkIGNvbnNpZGVyIGl0IGNsdXR0ZXIgYW5kIG9iamVjdCB0byBpdC4NCg0K
PiBXaXRoIG9yIHdpdGhvdXQgc3VnZ2VzdGVkIGNoYW5nZToNCj4gQWNrZWQtYnk6IEtvbnN0YW50
aW4gQW5hbnlldiA8a29uc3RhbnRpbi5hbmFueWV2QGh1YXdlaS5jb20+DQoNClRoYW5rcywgS29u
c3RhbnRpbi4gSSdsbCBrZWVwIGl0IGFzIGlzLg0KDQo+IA0KPiA+ICAJCXJldHVybiBOVUxMOw0K
PiA+DQo+ID4gIAl3aGlsZSAob2ZmID49IHJ0ZV9wa3RtYnVmX2RhdGFfbGVuKHNlZykpIHsNCj4g
PiBkaWZmIC0tZ2l0IGEvbGliL21idWYvcnRlX21idWYuaCBiL2xpYi9tYnVmL3J0ZV9tYnVmLmgN
Cj4gPiBpbmRleCA1OTJhZjIzODhjLi5kNjYwMmY3NGJjIDEwMDY0NA0KPiA+IC0tLSBhL2xpYi9t
YnVmL3J0ZV9tYnVmLmgNCj4gPiArKysgYi9saWIvbWJ1Zi9ydGVfbWJ1Zi5oDQo+ID4gQEAgLTE4
NDMsNyArMTg0Myw3IEBAIGNvbnN0IHZvaWQgKl9fcnRlX3BrdG1idWZfcmVhZChjb25zdCBzdHJ1
Y3QNCj4gcnRlX21idWYNCj4gPiAqbSwgdWludDMyX3Qgb2ZmLA0KPiA+ICBzdGF0aWMgaW5saW5l
IGNvbnN0IHZvaWQgKnJ0ZV9wa3RtYnVmX3JlYWQoY29uc3Qgc3RydWN0IHJ0ZV9tYnVmICptLA0K
PiA+ICAJdWludDMyX3Qgb2ZmLCB1aW50MzJfdCBsZW4sIHZvaWQgKmJ1ZikNCj4gPiAgew0KPiA+
IC0JaWYgKGxpa2VseShvZmYgKyBsZW4gPD0gcnRlX3BrdG1idWZfZGF0YV9sZW4obSkpKQ0KPiA+
ICsJaWYgKGxpa2VseSgodWludDY0X3Qpb2ZmICsgbGVuIDw9IHJ0ZV9wa3RtYnVmX2RhdGFfbGVu
KG0pKSkNCj4gPiAgCQlyZXR1cm4gcnRlX3BrdG1idWZfbXRvZF9vZmZzZXQobSwgY2hhciAqLCBv
ZmYpOw0KPiA+ICAJZWxzZQ0KPiA+ICAJCXJldHVybiBfX3J0ZV9wa3RtYnVmX3JlYWQobSwgb2Zm
LCBsZW4sIGJ1Zik7DQo+ID4gLS0NCj4gPiAyLjQzLjANCg0K
