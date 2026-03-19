Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1F0109022E
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 14:31:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4DBB402BD;
	Thu, 19 Mar 2026 15:31:04 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 21C824025D;
 Thu, 19 Mar 2026 15:31:04 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id DF7A2205CA;
 Thu, 19 Mar 2026 15:31:03 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v2] mbuf: fix read packet data
Date: Thu, 19 Mar 2026 15:31:01 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657A8@smartserver.smartshare.dk>
In-Reply-To: <da1693e3aef3481583356e9e7393a8fa@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [PATCH v2] mbuf: fix read packet data
Thread-Index: AQHct54EgHZAG2nipE+i7GOZrCGhprW12CGAgAAQkEA=
References: <20260319084048.652493-1-mb@smartsharesystems.com>
 <20260319124329.729034-1-mb@smartsharesystems.com>
 <da1693e3aef3481583356e9e7393a8fa@huawei.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Marat Khalili" <marat.khalili@huawei.com>,
	<dev@dpdk.org>
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

PiBGcm9tOiBNYXJhdCBLaGFsaWxpIFttYWlsdG86bWFyYXQua2hhbGlsaUBodWF3ZWkuY29tXQ0K
PiBTZW50OiBUaHVyc2RheSwgMTkgTWFyY2ggMjAyNiAxNS4yMg0KPiANCj4gQWNrZWQtYnk6IE1h
cmF0IEtoYWxpbGkgPG1hcmF0LmtoYWxpbGlAaHVhd2VpLmNvbT4NCj4gVGVzdGVkLWJ5OiBNYXJh
dCBLaGFsaWxpIDxtYXJhdC5raGFsaWxpQGh1YXdlaS5jb20+DQoNClRoYW5rIHlvdSBmb3IgdGVz
dGluZywgTWFyYXQhDQoNCj4gDQo+IEdvb2QgaWRlYSB0byBjbGFyaWZ5IGNoZWNrIHRleHRzIGlu
IHRoZSB0ZXN0Lg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXBwL3Rlc3QvdGVzdF9tYnVmLmMgYi9h
cHAvdGVzdC90ZXN0X21idWYuYw0KPiA+IGluZGV4IGE0MWQyZDBmOTcuLmRiMjMyNTk3NDUgMTAw
NjQ0DQo+ID4gLS0tIGEvYXBwL3Rlc3QvdGVzdF9tYnVmLmMNCj4gPiArKysgYi9hcHAvdGVzdC90
ZXN0X21idWYuYw0KPiA+IEBAIC0yMDM3LDEzICsyMDM3LDEzIEBAIHRlc3RfcGt0bWJ1Zl9yZWFk
X2Zyb21fb2Zmc2V0KHN0cnVjdA0KPiBydGVfbWVtcG9vbCAqcGt0bWJ1Zl9wb29sKQ0KPiA+ICAJ
LyogcmVhZCBsZW5ndGggZ3JlYXRlciB0aGFuIG1idWYgZGF0YV9sZW4gKi8NCj4gPiAgCWlmIChy
dGVfcGt0bWJ1Zl9yZWFkKG0sIGhkcl9sZW4sIHJ0ZV9wa3RtYnVmX2RhdGFfbGVuKG0pICsgMSwN
Cj4gPiAgCQkJCU5VTEwpICE9IE5VTEwpDQo+ID4gLQkJR09UT19GQUlMKCIlczogUmVxdWVzdGVk
IGxlbiBpcyBsYXJnZXIgdGhhbiBtYnVmIGRhdGENCj4gbGVuIVxuIiwNCj4gPiArCQlHT1RPX0ZB
SUwoIiVzOiBSZXF1ZXN0ZWQgb2Zmc2V0ICsgbGVuIGlzIGxhcmdlciB0aGFuIG1idWYNCj4gZGF0
YSBsZW4hXG4iLA0KPiA+ICAJCQkJX19mdW5jX18pOw0KPiANCj4gQW5vdGhlciBzdHJhbmdlIGNo
ZWNrIHRiaCwgdGhlcmUgaXMgbm90aGluZyB3cm9uZyB3aXRoIHJlYWRpbmcgYmV5b25kDQo+IG1i
dWYgZGF0YQ0KPiBsZW5ndGguIFRoaXMgb25seSBmYWlscyBiZWNhdXNlIHdlIGFyZSByZWFkaW5n
IGJleW9uZCBwYWNrZXQgbGVuZ3RoLA0KPiB3aGljaCBpcw0KPiB0ZXN0ZWQgaW1tZWRpYXRlbHkg
YWZ0ZXIuIEknZCB2b3RlIHRvIGRlbGV0ZSBpdCwgYWx0aG91Z2ggaXQgaGFzDQo+IG5vdGhpbmcg
dG8gZG8NCj4gd2l0aCB0aGUgcGF0Y2guIFRoaXMgaXMganVzdCBhIGdlbmVyYWwgY29tbWVudCwg
bm90IGFuIGlzc3VlLg0KDQpBZ3JlZS4NCg0KSSBhbHNvIG5vdGljZWQgdGhhdCB0aGUgb2Zmc2V0
IGlzIG5vdCBzdWJ0cmFjdGVkIGZyb20gbGVuZ3RoIHBhcmFtZXRlci4NClRlc3RpbmcgdGhlIGNv
cm5lciBjYXNlIHNob3VsZCBiZToNCg0KcnRlX3BrdG1idWZfcmVhZChtLCBoZHJfbGVuLCBydGVf
cGt0bWJ1Zl9kYXRhX2xlbihtKSAtIGhkcl9sZW4gKyAxLA0KDQoNCkFuZCBtb3JlIHRlc3RzIGNv
dWxkIGJlIGFkZGVkIHRvIHRlc3Qgc2VnbWVudGVkIG1idWZzLg0KDQpCdXQgSSdsbCBsZWF2ZSB0
aGlzIHBhdGNoIHRvIG9ubHkgY2FyZSBhYm91dCBmaXhpbmcgdGhlIHdyYXBwaW5nIGJ1Zy4NCg0K
VGhlIG1idWZzIHRlc3RzIGNhbiBiZSBmdXJ0aGVyIGltcHJvdmVkIGFub3RoZXIgZGF5LCBpZiBz
b21lb25lIGNhcmVzIHRvIGRvIHRoZSB3b3JrLg0KDQo+IA0KPiA+DQo+ID4gIAkvKiByZWFkIGxl
bmd0aCBncmVhdGVyIHRoYW4gbWJ1ZiBwa3RfbGVuICovDQo+ID4gIAlpZiAocnRlX3BrdG1idWZf
cmVhZChtLCBoZHJfbGVuLCBydGVfcGt0bWJ1Zl9wa3RfbGVuKG0pICsgMSwNCj4gPiAgCQkJCU5V
TEwpICE9IE5VTEwpDQo+ID4gLQkJR09UT19GQUlMKCIlczogUmVxdWVzdGVkIGxlbiBpcyBsYXJn
ZXIgdGhhbiBtYnVmIHBrdA0KPiBsZW4hXG4iLA0KPiA+ICsJCUdPVE9fRkFJTCgiJXM6IFJlcXVl
c3RlZCBvZmZzZXQgKyBsZW4gaXMgbGFyZ2VyIHRoYW4gbWJ1Zg0KPiBwa3QgbGVuIVxuIiwNCj4g
PiAgCQkJCV9fZnVuY19fKTsNCj4gPg0KPiA+ICAJLyogcmVhZCBkYXRhIG9mIHplcm8gbGVuIGZy
b20gdmFsaWQgb2Zmc2V0ICovDQoNCg==
