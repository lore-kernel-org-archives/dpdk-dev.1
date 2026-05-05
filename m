Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00802FF885A
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 09:05:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37AD14060B;
	Tue,  5 May 2026 11:05:16 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 7D2AA40272;
 Tue,  5 May 2026 11:05:14 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g8szG6rSMzJ46bb;
 Tue,  5 May 2026 17:04:58 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id 26DDF40569;
 Tue,  5 May 2026 17:05:14 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 May 2026 10:05:13 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 5 May 2026 10:05:13 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, "stable@dpdk.org" <stable@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>
Subject: RE: [PATCH] ring: add cache guard after ring elements table
Thread-Topic: [PATCH] ring: add cache guard after ring elements table
Thread-Index: AQHc0XkQlTcfmwaszE+wFaHNWAZ9L7X358TAgAAS8tCAArdBsIADNeMQgAE7FGCAAAE+cIAAEtSg
Date: Tue, 5 May 2026 09:05:13 +0000
Message-ID: <8cdf3d98977e4a1abe0face5da65b26a@huawei.com>
References: <20260421102358.118204-1-mb@smartsharesystems.com>
 <e1fa27a3450f4bc5ab0c12bcfb07f694@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65835@smartserver.smartshare.dk>
 <452224d4ef25481b938a10b3d82b69a5@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65842@smartserver.smartshare.dk>
 <70a4b0baa49448d0b93d2088319afaf5@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65843@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65843@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.173.196]
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

DQoNCj4gPiA+ID4gPiA+ID4gQWRkZWQgY2FjaGUgZ3VhcmQgYWZ0ZXIgdGhlIHRhYmxlIGhvbGRp
bmcgdGhlIHJpbmcgZWxlbWVudHMsDQo+ID4gdG8NCj4gPiA+ID4gYXZvaWQNCj4gPiA+ID4gPiA+
ID4gZmFsc2Ugc2hhcmluZyBjb25mbGljdHMgY2F1c2VkIGJ5IG5leHQtbGluZSBoYXJkd2FyZQ0K
PiA+IHByZWZldGNoZXJzDQo+ID4gPiA+IHdoZW4NCj4gPiA+ID4gPiA+ID4gYWNjZXNzaW5nIGVs
ZW1lbnRzIGF0IHRoZSBlbmQgb2YgdGhlIHJpbmcgdGFibGUuDQo+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gSSBkb24ndCBzZWUgYW55IGhhcm0gd2l0aCBpdCwgYW5kIGluIHRoZW9yeSBpdCBtaWdo
dCBoZWxwIGluDQo+ID4gc29tZQ0KPiA+ID4gPiA+ID4gY2FzZXMuLi4NCj4gPiA+ID4gPiA+IFRo
b3VnaCBJIHdvbmRlciBob3cgcmVhbCBpcyB0aGF0IHByb2JsZW0/DQo+ID4gPiA+ID4gPiBEaWQg
eW91IGV2ZXIgb2JzZXJ2ZSBzdWNoIGNvbnRlbnRpb24gdG8gaGFwcGVuPw0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gSSBuZXZlciBvYnNlcnZlZCBhIHByb2JsZW0gd2l0aCB0aGlzLg0KPiA+ID4gPiA+
IFRoZSByaXNrIG9mIGNvbnRlbnRpb24gZGVwZW5kcyBvbiB3aGF0IGlzIGFsbG9jYXRlZCBpbiB0
aGUgbWVtb3J5DQo+ID4gPiA+IGFmdGVyIHRoZSByaW5nLg0KPiA+ID4gPiA+IFdoaWNoIGlzIGFw
cGxpY2F0aW9uIHNwZWNpZmljLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSXQgc2VlbXMgbGlrZSBh
IHB1cmVseSB0aGVvcmV0aWNhbCBpc3N1ZSwgYnV0IHNob3VsZCBiZSBmaXhlZA0KPiA+IGFueXdh
eSwNCj4gPiA+ID4gdG8gZWxpbWluYXRlDQo+ID4gPiA+ID4gdGhhdCByaXNrLg0KPiA+ID4gPg0K
PiA+ID4gPiBPaywgYXMgSSBzYWlkIEkgc2VlIG5vIGhhcm0gd2l0aCBpdC4NCj4gPiA+ID4gU2hv
dWxkIHdlIGRvY3VtZW50IHRoaXMgY2hhbmdlIHNvbWV3aGVyZT8gUk4gb3IgUEc/DQo+ID4gPg0K
PiA+ID4gV2UgZG9uJ3Qgd2FudCB0aGUgcmVsZWFzZSBub3RlcyBvdmVyZmxvd2luZyB3aXRoIG1p
bm9yIGRldGFpbHMuDQo+ID4gPiBJTU8sIHRoaXMgY2hhbmdlIGlzIGJlbG93IHRoZSB0aHJlc2hv
bGQgZm9yIHdoYXQgcGVvcGxlIG1pZ2h0IGNhcmUNCj4gPiBhYm91dC4NCj4gPiA+IFBlb3BsZSBp
bnRlcmVzdGVkIGluIHRoZSBkZXRhaWxlZCBjaGFuZ2VzIGJldHdlZW4gcmVsZWFzZXMgc2hvdWxk
DQo+ID4gcmVhZCB0aGUgZ2l0DQo+ID4gPiBsb2cuDQo+ID4NCj4gPiBJIHN0aWxsIHRoaW5rIHdl
IGRvIG5lZWQgZG9jdW1lbnQgc29tZXdoZXJlIHdoeSB3ZSBkb2luZyBpdC4NCj4gPiBJZiB5b3Ug
dGhpbmsgUk4gb3IgUEcgaXMgbm90IHRoZSByaWdodCBwbGFjZSwgbGV0J3MganVzdCBwdXQgaXQg
YXMgYQ0KPiA+IGNvbW1lbnQgZm9yIHRoYXQgcGFydGljdWxhciBmdW5jdGlvbi4NCj4gDQo+IFRo
ZSBmdW5jdGlvbiByZXR1cm5zIHRoZSB0b3RhbCBzaXplIG9mIHRoZSBzdHJ1Y3R1cmUgaW5jbHVk
aW5nIGl0cyBlbGVtZW50cy4NCj4gVGhlcmUncyBubyBuZWVkIHRvIGRvY3VtZW50IGlmIHRoZSBz
dHJ1Y3R1cmUgaW5jbHVkZXMgcGFkZGluZyAodGhlIHRyYWlsaW5nIGNhY2hlDQo+IGd1YXJkKSBv
ciBub3QuDQo+IFRoZSBwcmVzZW5jZSBvZiBjYWNoZSBndWFyZHMgb3Igb3RoZXIgZm9ybXMgb2Yg
cGFkZGluZyBpcyBub3QgZG9jdW1lbnRlZCBmb3INCj4gYW55IG90aGVyICJnZXQgc2l6ZSIgZnVu
Y3Rpb25zLCBzbyBsZXQncyBub3QgZG8gaXQgaGVyZSBlaXRoZXIuDQo+IA0KPiBDb25zaWRlcmlu
ZyBob3cgdGhpcyBmdW5jdGlvbiBpcyB1c2VkLCBJIGRvbid0IHNlZSBhbnkgcmlzayB3aXRoIHRo
aXMgcGF0Y2guIFNvIEknZA0KPiByYXRoZXIgYmUgc2lsZW50IHRoYW4gYWRkIG5vaXNlLg0KPiBJ
ZiBJIGNvdWxkIHNlZSBhbnkgcmlzayBhdCBhbGwsIEknZCBhZ3JlZSBpdCBzaG91bGQgYmUgbWVu
dGlvbmVkIGluIHRoZSBSTi4NCj4gDQo+IA0KPiBNYXliZSBJIG1pc3VuZGVyc3Rvb2QgeW91ciBm
ZWVkYmFjaywgc28gaGVyZSdzIGFub3RoZXIgYW5nbGU6DQo+IERvIHlvdSB0aGluayB3ZSBzaG91
bGQgZGVzY3JpYmUgd2h5IHRoZSBjYWNoZSBndWFyZCBpcyB0aGVyZT8NCj4gVGhlbiBteSByZXNw
b25zZSBpczogVGhlIG5hbWUgUlRFX0NBQ0hFX0dVQVJEX0xJTkVTIGltcGxpZXMgdGhhdCBpdCBp
cyBhDQo+IGNhY2hlIGd1YXJkLg0KDQpZZXMsIEkgdGhpbmsgd2UgbmVlZCB0byBkZXNjcmliZSB3
aHkgd2UgZGVjaWRlZCB0aGF0IHdlIGRvIG5lZWQgdGhhdCBleHRyYSBjYWNoZS1saW5lIGhlcmUu
DQpUaGVyZSB3YXMgbm8gZXZpZGVuY2Ugb2YgYW55IHBlcmZvcm1hbmNlIGhpdCBjYXVzZWQgYnkg
bm90IGhhdmluZyBpdCwNCnNvIEkgdGhpbmsgaXQgaXMgd29ydGggdG8gcHV0IGEgdHdvIGxpbmUg
Y29tbWVudCB0byBleHBsYWluIHdoeSB3ZSB0aGluaw0Kc3VjaCBjaGFuZ2Ugd291bGQgYmUgYmVu
ZWZpY2lhbC4NCiANCj4gRGlnZ2luZyBzb21ld2hhdCBtb3JlIGludG8gdGhpcy4uLiB0aGUgUlRF
X0NBQ0hFX0dVQVJEX0xJTkVTIGlzIGRlZmluZWQgaW4NCj4gcnRlX2NvbmZpZy5oIHdpdGhvdXQg
YW55IGRlc2NyaXB0aW9uLg0KPiBTbyBhIGRlc2NyaXB0aW9uIG9mIHRoZSBjb25jZXB0IG9mIGEg
ImNhY2hlIGd1YXJkIiBjb3VsZCBiZSBhZGRlZCB0aGVyZS4NCj4gQnV0IHRoZXJlIHNlZW1zIHRv
IGJlIGEgdHJhZGl0aW9uIGZvciBub3QgaGF2aW5nIGFueSBkZXNjcmlwdGl2ZSBjb21tZW50cyBp
biB0aGF0DQo+IGZpbGUuIDotKA0KPiANCj4gVGhlcmUncyBhIGdvb2QgZGVzY3JpcHRpb24gZm9y
IHRoZSBSVEVfQ0FDSEVfR1VBUkQgbWFjcm8gaW4gcnRlX2NvbW1vbi5oLg0KPiBNYXliZSB3ZSBz
aG91bGQgaW50cm9kdWNlIGEgc2ltaWxhcmx5IHdlbGwgZGVzY3JpYmVkIFJURV9DQUNIRV9HVUFS
RF9TSVpFDQo+IG1hY3JvIGluIHJ0ZV9jb21tb24uaCwgYW5kIHVzZSBzeiArPSBSVEVfQ0FDSEVf
R1VBUkRfU0laRSBpbnN0ZWFkIG9mIHN6ICs9DQo+IFJURV9DQUNIRV9HVUFSRF9MSU5FUyAqIFJU
RV9DQUNIRV9MSU5FX1NJWkUuDQo+IA0KPiA+DQo+ID4gPiBBbHNvLCBJIGRvbid0IHRoaW5rIGl0
J3Mgd29ydGggYmFja3BvcnRpbmcsIGJlY2F1c2UgSSBjb25zaWRlciBpdA0KPiA+IHVubGlrZWx5
IHRvIGhhdmUNCj4gPiA+IGFueSByZWFsIGVmZmVjdC4NCj4gPiA+IEluIHRoZSBjb250ZXh0IG9m
IGJhY2twb3J0aW5nLCBpdCBjb3VsZCBiZSBjb25zaWRlcmVkIGEgcGVyZm9ybWFuY2UNCj4gPiA+
IGltcHJvdmVtZW50IHJhdGhlciB0aGFuIGEgYnVnIGZpeC4NCj4gPg0KPiA+IEkgZG9uJ3Qgc2Vl
IG11Y2ggcG9pbnQgdG8gYmFja3BvcnQgaXQuDQo+ID4NCj4gPiA+DQo+ID4gPiA+IEFja2VkLWJ5
OiBLb25zdGFudGluIEFuYW55ZXYgPGtvbnN0YW50aW4uYW5hbnlldkBodWF3ZWkuY29tPg0KPiA+
ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTW9ydGVuIEJy
w7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCj4gPiA+ID4gPiA+ID4gLS0tDQo+ID4g
PiA+ID4gPiA+ICBsaWIvcmluZy9ydGVfcmluZy5jIHwgMyArKysNCj4gPiA+ID4gPiA+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
ID4gZGlmZiAtLWdpdCBhL2xpYi9yaW5nL3J0ZV9yaW5nLmMgYi9saWIvcmluZy9ydGVfcmluZy5j
DQo+ID4gPiA+ID4gPiA+IGluZGV4IGYxMDA1MGExYzQuLjljY2M2MmNkNDIgMTAwNjQ0DQo+ID4g
PiA+ID4gPiA+IC0tLSBhL2xpYi9yaW5nL3J0ZV9yaW5nLmMNCj4gPiA+ID4gPiA+ID4gKysrIGIv
bGliL3JpbmcvcnRlX3JpbmcuYw0KPiA+ID4gPiA+ID4gPiBAQCAtNzMsOCArNzMsMTEgQEAgcnRl
X3JpbmdfZ2V0X21lbXNpemVfZWxlbSh1bnNpZ25lZCBpbnQNCj4gPiBlc2l6ZSwNCj4gPiA+ID4g
PiA+IHVuc2lnbmVkDQo+ID4gPiA+ID4gPiA+IGludCBjb3VudCkNCj4gPiA+ID4gPiA+ID4gIAkJ
cmV0dXJuIC1FSU5WQUw7DQo+ID4gPiA+ID4gPiA+ICAJfQ0KPiA+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gPiArCXN0YXRpY19hc3NlcnQoc2l6ZW9mKHN0cnVjdCBydGVfcmluZykgPT0NCj4gPiA+
ID4gPiA+ID4gUlRFX0NBQ0hFX0xJTkVfUk9VTkRVUChzaXplb2Yoc3RydWN0IHJ0ZV9yaW5nKSks
DQo+ID4gPiA+ID4gPiA+ICsJCQkiU2l6ZSBvZiBzdHJ1Y3QgcnRlX3Jpbmcgbm90IGNhY2hlIGxp
bmUNCj4gPiA+ID4gYWxpZ25lZCIpOw0KPiA+ID4gPiA+ID4gPiAgCXN6ID0gc2l6ZW9mKHN0cnVj
dCBydGVfcmluZykgKyAoc3NpemVfdCljb3VudCAqIGVzaXplOw0KPiA+ID4gPiA+ID4gPiAgCXN6
ID0gUlRFX0FMSUdOKHN6LCBSVEVfQ0FDSEVfTElORV9TSVpFKTsNCj4gPiA+ID4gPiA+ID4gKwlz
eiArPSBSVEVfQ0FDSEVfR1VBUkRfTElORVMgKiBSVEVfQ0FDSEVfTElORV9TSVpFOw0KPiA+ID4g
PiA+ID4gPiAgCXJldHVybiBzejsNCj4gPiA+ID4gPiA+ID4gIH0NCj4gPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+ID4gLS0NCj4gPiA+ID4gPiA+ID4gMi40My4wDQoNCg==
