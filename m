Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EF5D2502D
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Jan 2026 17:43:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68B3B4028F;
	Sun, 11 Jan 2026 18:43:24 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 11F474013F;
 Sun, 11 Jan 2026 18:43:23 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1DA65206E5;
 Sun, 11 Jan 2026 18:43:22 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] mbuf: fix packet copy
Date: Sun, 11 Jan 2026 18:43:20 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6564B@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <212f88e700fa4a6a97a421cb3b84e03a@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mbuf: fix packet copy
Thread-Index: AQHcWUyxZC53baITAUi48xMVA9nXxbVA/w+AgAxm98CAACY5MA==
References: <20251119120403.907511-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6561A@smartserver.smartshare.dk>
 <212f88e700fa4a6a97a421cb3b84e03a@huawei.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>
Cc: <stable@dpdk.org>
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
d2VpLmNvbV0NCj4gDQo+ID4NCj4gPiBQSU5HIGZvciByZXZpZXcuDQo+ID4NCj4gPiA+IEZyb206
IE1vcnRlbiBCcsO4cnVwIFttYWlsdG86bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tXQ0KPiA+ID4g
U2VudDogV2VkbmVzZGF5LCAxOSBOb3ZlbWJlciAyMDI1IDEzLjA0DQo+ID4gPg0KPiA+ID4gUmVx
dWVzdHMgZm9yIGNvcHlpbmcgdGhlIGF0IHRoZSBlbmQgb2YgYSBwYWNrZXQgaW5jb3JyZWN0bHkN
Cj4gcmV0dXJuZWQNCj4gPiA+IE5VTEwsDQo+ID4gPiBhcyBpZiBjb3B5aW5nIHBhc3QgdGhlIGVu
ZCBvZiBhIHBhY2tldC4NCj4gPiA+DQo+ID4gPiBXaGVuIGFsbG9jYXRpbmcgY29waWVzIGZyb20g
YSBtZW1wb29sIHVzaW5nIHBpbm5lZCBleHRlcm5hbA0KPiBidWZmZXJzLA0KPiA+ID4gdGhlDQo+
ID4gPiBleHRlcm5hbCBmbGFnIHdhcyBub3QgcHJlc2VydmVkIGluIHRoZXNlIG1idWZzLg0KPiA+
ID4NCj4gPiA+IEZpeGVzOiBjM2E5MGMzODFkYWEgKCJtYnVmOiBhZGQgYSBjb3B5IHJvdXRpbmUi
KQ0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNo
YXJlc3lzdGVtcy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBsaWIvbWJ1Zi9ydGVfbWJ1Zi5jIHwg
NiArKystLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9saWIvbWJ1Zi9ydGVfbWJ1Zi5jIGIv
bGliL21idWYvcnRlX21idWYuYw0KPiA+ID4gaW5kZXggMGQ5MzFjN2ExNS4uZTYzOWFmZjAzZSAx
MDA2NDQNCj4gPiA+IC0tLSBhL2xpYi9tYnVmL3J0ZV9tYnVmLmMNCj4gPiA+ICsrKyBiL2xpYi9t
YnVmL3J0ZV9tYnVmLmMNCj4gPiA+IEBAIC02NzUsNyArNjc1LDcgQEAgcnRlX3BrdG1idWZfY29w
eShjb25zdCBzdHJ1Y3QgcnRlX21idWYgKm0sDQo+IHN0cnVjdA0KPiA+ID4gcnRlX21lbXBvb2wg
Km1wLA0KPiA+ID4gIAlfX3J0ZV9tYnVmX3Nhbml0eV9jaGVjayhtLCAxKTsNCj4gPiA+DQo+ID4g
PiAgCS8qIGNoZWNrIGZvciByZXF1ZXN0IHRvIGNvcHkgYXQgb2Zmc2V0IHBhc3QgZW5kIG9mIG1i
dWYgKi8NCj4gPiA+IC0JaWYgKHVubGlrZWx5KG9mZiA+PSBtLT5wa3RfbGVuKSkNCj4gPiA+ICsJ
aWYgKHVubGlrZWx5KG9mZiA+IG0tPnBrdF9sZW4pKQ0KPiA+ID4gIAkJcmV0dXJuIE5VTEw7DQo+
IA0KPiBTbywgd2hlbiBvZmY9IG0tPnBrdF9sZW4sIHdoYXQgZG8gd2Ugd2FudCBpdCB0byByZXR1
cm4/DQo+IE5ldyBtYnVmIHdpdGggcGt0X2xlbiA9PSAwPw0KPiBBbnkgcG9pbnQgb2Ygc3VjaCBj
b3B5aW5nIHRoZW4/DQoNCkVtcHR5IHBhY2tldHMgYXJlIHBlcmZlY3RseSB2YWxpZC4NCkEgbGli
cmFyeSBzaG91bGQgbm90IG9wdGltaXplIHRoZW0gYXdheTsgaXQgaXMgdGhlIGFwcGxpY2F0aW9u
J3MgY2hvaWNlIGhvdyB0byBoYW5kbGUgZW1wdHkgcGFja2V0cy4NCg0KPiANCj4gPiA+ICAJbWMg
PSBydGVfcGt0bWJ1Zl9hbGxvYyhtcCk7DQo+ID4gPiBAQCAtNjg4LDggKzY4OCw4IEBAIHJ0ZV9w
a3RtYnVmX2NvcHkoY29uc3Qgc3RydWN0IHJ0ZV9tYnVmICptLA0KPiBzdHJ1Y3QNCj4gPiA+IHJ0
ZV9tZW1wb29sICptcCwNCj4gPiA+DQo+ID4gPiAgCV9fcnRlX3BrdG1idWZfY29weV9oZHIobWMs
IG0pOw0KPiA+ID4NCj4gPiA+IC0JLyogY29waWVkIG1idWYgaXMgbm90IGluZGlyZWN0IG9yIGV4
dGVybmFsICovDQo+ID4gPiAtCW1jLT5vbF9mbGFncyA9IG0tPm9sX2ZsYWdzICYNCj4gPiA+IH4o
UlRFX01CVUZfRl9JTkRJUkVDVHxSVEVfTUJVRl9GX0VYVEVSTkFMKTsNCj4gPiA+ICsJLyogY29w
eSBmbGFncyBleGNlcHQgaW5kaXJlY3QgYW5kIGV4dGVybmFsLCBhbmQgcHJlc2VydmUgZmxhZ3Mg
b2YNCj4gPiA+IG5ld2x5IGFsbG9jYXRlZCBtYnVmICovDQo+ID4gPiArCW1jLT5vbF9mbGFncyB8
PSBtLT5vbF9mbGFncyAmDQo+ID4gPiB+KFJURV9NQlVGX0ZfSU5ESVJFQ1R8UlRFX01CVUZfRl9F
WFRFUk5BTCk7DQo+IA0KPiBXaGljaCBmbGFncyBpbiB0aGUgbmV3IG1idWYgd2Ugd2FudCB0byBw
cmVzZXJ2ZT8NCj4gQUZBSUsgbWJ1Zl9hbGxvYygpIGRvZXNuJ3Qgc2V0IGFueSBmbGFncy4NCg0K
Q29ycmVjdDogdGhlIG5ld2x5IGFsbG9jYXRlZCBtYnVmIHJldHVybmVkIGJ5IG1idWZfYWxsb2Mo
KSBub3JtYWxseSBoYXMgbm8gZmxhZ3Mgc2V0Lg0KSG93ZXZlciwgaWYgaXQgaXMgYWxsb2NhdGVk
IGZyb20gYW4gbWJ1ZiBwb29sIGhvbGRpbmcgbWJ1ZnMgdXNpbmcgcGlubmVkIGV4dGVybmFsIGJ1
ZmZlcnMsIHRoZSBSVEVfTUJVRl9GX0VYVEVSTkFMIGlzIGFscmVhZHkgc2V0IGluIHRoZSBtYnVm
cyBoZWxkIGluIHRoYXQgcG9vbCwgYW5kIHdpbGwgcmVtYWluIHNldCB3aGVuIHJldHVybmluZyB0
aGUgbWJ1ZiBieSBtYnVmX2FsbG9jKCkuIFdlIHdhbnQgdG8gcHJlc2VydmUgdGhhdCBmbGFnLg0K
DQo+IEJUVywgaWYgdGhlcmUgYXJlIHNvbWUgZmxhZ3MgdGhhdCB3ZSB3b3VsZCBsaWtlIHRvIHBy
ZXNlcnZlLA0KPiB3b3VsZG4ndCB0aGF0IGJlIGEgIGNoYW5nZSBpbiBwdWJsaWMgQVBJIGJlaGF2
aW9yPw0KDQpUaGlzIHBhdGNoIGRvZXMgbm90IGNoYW5nZSB3aGljaCBmbGFncyB0byBwcmVzZXJ2
ZSBmcm9tIHRoZSBzb3VyY2UgbWJ1Zi4NClRoZSBwYXRjaCBvbmx5IGFkZHMgdGhhdCB0aGUgZmxh
Z3Mgb2YgdGhlIG5ld2x5IGFsbG9jYXRlZCBtYnVmIGFyZSBub3QgY2xlYXJlZCB3aGVuIGNvcHlp
bmcgdGhlIGZsYWdzIGZyb20gdGhlIHNvdXJjZSBtYnVmLg0KDQo+IA0KPiA+ID4NCj4gPiA+ICAJ
cHJldiA9ICZtYy0+bmV4dDsNCj4gPiA+ICAJbV9sYXN0ID0gbWM7DQo+ID4gPiAtLQ0KPiA+ID4g
Mi40My4wDQoNCg==
