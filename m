Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11180FF886F
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 May 2026 13:17:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B91B402BC;
	Mon,  4 May 2026 15:17:59 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 6037C402B2;
 Mon,  4 May 2026 15:17:58 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2B1CC20628;
 Mon,  4 May 2026 15:17:58 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] ring: add cache guard after ring elements table
Date: Mon, 4 May 2026 15:17:53 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65842@smartserver.smartshare.dk>
In-Reply-To: <452224d4ef25481b938a10b3d82b69a5@huawei.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ring: add cache guard after ring elements table
Thread-Index: AQHc0XkQlTcfmwaszE+wFaHNWAZ9L7X358TAgAAS8tCAArdBsIADNeMQ
References: <20260421102358.118204-1-mb@smartsharesystems.com><e1fa27a3450f4bc5ab0c12bcfb07f694@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65835@smartserver.smartshare.dk>
 <452224d4ef25481b938a10b3d82b69a5@huawei.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, <dev@dpdk.org>,
 "Konstantin Ananyev" <konstantin.v.ananyev@yandex.ru>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>, <stable@dpdk.org>
Cc: "David Marchand" <david.marchand@redhat.com>
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

K0NDOiBTdGFibGUgbWFpbnRhaW5lcnMsIHNvIHlvdSBjYW4gZGVjaWRlIG9uIGJhY2twb3J0aW5n
Lg0KDQo+ID4gPiA+IEFkZGVkIGNhY2hlIGd1YXJkIGFmdGVyIHRoZSB0YWJsZSBob2xkaW5nIHRo
ZSByaW5nIGVsZW1lbnRzLCB0bw0KPiBhdm9pZA0KPiA+ID4gPiBmYWxzZSBzaGFyaW5nIGNvbmZs
aWN0cyBjYXVzZWQgYnkgbmV4dC1saW5lIGhhcmR3YXJlIHByZWZldGNoZXJzDQo+IHdoZW4NCj4g
PiA+ID4gYWNjZXNzaW5nIGVsZW1lbnRzIGF0IHRoZSBlbmQgb2YgdGhlIHJpbmcgdGFibGUuDQo+
ID4gPg0KPiA+ID4gSSBkb24ndCBzZWUgYW55IGhhcm0gd2l0aCBpdCwgYW5kIGluIHRoZW9yeSBp
dCBtaWdodCBoZWxwIGluIHNvbWUNCj4gPiA+IGNhc2VzLi4uDQo+ID4gPiBUaG91Z2ggSSB3b25k
ZXIgaG93IHJlYWwgaXMgdGhhdCBwcm9ibGVtPw0KPiA+ID4gRGlkIHlvdSBldmVyIG9ic2VydmUg
c3VjaCBjb250ZW50aW9uIHRvIGhhcHBlbj8NCj4gPg0KPiA+IEkgbmV2ZXIgb2JzZXJ2ZWQgYSBw
cm9ibGVtIHdpdGggdGhpcy4NCj4gPiBUaGUgcmlzayBvZiBjb250ZW50aW9uIGRlcGVuZHMgb24g
d2hhdCBpcyBhbGxvY2F0ZWQgaW4gdGhlIG1lbW9yeQ0KPiBhZnRlciB0aGUgcmluZy4NCj4gPiBX
aGljaCBpcyBhcHBsaWNhdGlvbiBzcGVjaWZpYy4NCj4gPg0KPiA+IEl0IHNlZW1zIGxpa2UgYSBw
dXJlbHkgdGhlb3JldGljYWwgaXNzdWUsIGJ1dCBzaG91bGQgYmUgZml4ZWQgYW55d2F5LA0KPiB0
byBlbGltaW5hdGUNCj4gPiB0aGF0IHJpc2suDQo+IA0KPiBPaywgYXMgSSBzYWlkIEkgc2VlIG5v
IGhhcm0gd2l0aCBpdC4NCj4gU2hvdWxkIHdlIGRvY3VtZW50IHRoaXMgY2hhbmdlIHNvbWV3aGVy
ZT8gUk4gb3IgUEc/DQoNCldlIGRvbid0IHdhbnQgdGhlIHJlbGVhc2Ugbm90ZXMgb3ZlcmZsb3dp
bmcgd2l0aCBtaW5vciBkZXRhaWxzLg0KSU1PLCB0aGlzIGNoYW5nZSBpcyBiZWxvdyB0aGUgdGhy
ZXNob2xkIGZvciB3aGF0IHBlb3BsZSBtaWdodCBjYXJlIGFib3V0Lg0KUGVvcGxlIGludGVyZXN0
ZWQgaW4gdGhlIGRldGFpbGVkIGNoYW5nZXMgYmV0d2VlbiByZWxlYXNlcyBzaG91bGQgcmVhZCB0
aGUgZ2l0IGxvZy4NCg0KQWxzbywgSSBkb24ndCB0aGluayBpdCdzIHdvcnRoIGJhY2twb3J0aW5n
LCBiZWNhdXNlIEkgY29uc2lkZXIgaXQgdW5saWtlbHkgdG8gaGF2ZSBhbnkgcmVhbCBlZmZlY3Qu
DQpJbiB0aGUgY29udGV4dCBvZiBiYWNrcG9ydGluZywgaXQgY291bGQgYmUgY29uc2lkZXJlZCBh
IHBlcmZvcm1hbmNlIGltcHJvdmVtZW50IHJhdGhlciB0aGFuIGEgYnVnIGZpeC4NCg0KPiBBY2tl
ZC1ieTogS29uc3RhbnRpbiBBbmFueWV2IDxrb25zdGFudGluLmFuYW55ZXZAaHVhd2VpLmNvbT4N
Cj4gDQo+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21h
cnRzaGFyZXN5c3RlbXMuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGxpYi9yaW5nL3J0ZV9y
aW5nLmMgfCAzICsrKw0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0K
PiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvbGliL3JpbmcvcnRlX3JpbmcuYyBiL2xpYi9y
aW5nL3J0ZV9yaW5nLmMNCj4gPiA+ID4gaW5kZXggZjEwMDUwYTFjNC4uOWNjYzYyY2Q0MiAxMDA2
NDQNCj4gPiA+ID4gLS0tIGEvbGliL3JpbmcvcnRlX3JpbmcuYw0KPiA+ID4gPiArKysgYi9saWIv
cmluZy9ydGVfcmluZy5jDQo+ID4gPiA+IEBAIC03Myw4ICs3MywxMSBAQCBydGVfcmluZ19nZXRf
bWVtc2l6ZV9lbGVtKHVuc2lnbmVkIGludCBlc2l6ZSwNCj4gPiA+IHVuc2lnbmVkDQo+ID4gPiA+
IGludCBjb3VudCkNCj4gPiA+ID4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiA+ICAJfQ0KPiA+
ID4gPg0KPiA+ID4gPiArCXN0YXRpY19hc3NlcnQoc2l6ZW9mKHN0cnVjdCBydGVfcmluZykgPT0N
Cj4gPiA+ID4gUlRFX0NBQ0hFX0xJTkVfUk9VTkRVUChzaXplb2Yoc3RydWN0IHJ0ZV9yaW5nKSks
DQo+ID4gPiA+ICsJCQkiU2l6ZSBvZiBzdHJ1Y3QgcnRlX3Jpbmcgbm90IGNhY2hlIGxpbmUNCj4g
YWxpZ25lZCIpOw0KPiA+ID4gPiAgCXN6ID0gc2l6ZW9mKHN0cnVjdCBydGVfcmluZykgKyAoc3Np
emVfdCljb3VudCAqIGVzaXplOw0KPiA+ID4gPiAgCXN6ID0gUlRFX0FMSUdOKHN6LCBSVEVfQ0FD
SEVfTElORV9TSVpFKTsNCj4gPiA+ID4gKwlzeiArPSBSVEVfQ0FDSEVfR1VBUkRfTElORVMgKiBS
VEVfQ0FDSEVfTElORV9TSVpFOw0KPiA+ID4gPiAgCXJldHVybiBzejsNCj4gPiA+ID4gIH0NCj4g
PiA+ID4NCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi40My4wDQoNCg==
