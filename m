Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D1ACCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 08:24:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CF9F4026D;
	Tue, 11 Nov 2025 09:24:26 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 9A23C4026A
 for <dev@dpdk.org>; Tue, 11 Nov 2025 09:24:24 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5KLt1NDdzHnHFZ;
 Tue, 11 Nov 2025 16:24:06 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id E80E714033C;
 Tue, 11 Nov 2025 16:24:22 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Nov 2025 08:24:22 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 11 Nov 2025 08:24:22 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Isaac Boukris <iboukris@gmail.com>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, =?utf-8?B?TW9ydGVuIEJyw7hydXA=?=
 <mb@smartsharesystems.com>
Subject: RE: [PATCH v3] lib/ring: do not allow zero size ring
Thread-Topic: [PATCH v3] lib/ring: do not allow zero size ring
Thread-Index: AQHcUtPKTszth2sYVkuwt08KNd8I0rTtI2xw
Date: Tue, 11 Nov 2025 08:24:22 +0000
Message-ID: <e7fd8bbd16d94544aaae9507cece72ba@huawei.com>
References: <20251110222827.575488-1-iboukris@gmail.com>
 <20251111062253.578121-1-iboukris@gmail.com>
In-Reply-To: <20251111062253.578121-1-iboukris@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.188.82]
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

DQoNCj4gdGhpcyBtaWdodCBoYXBwZW4gd2hlbiBmb3IgaW5zdGFuY2UgdGhlIHJpbmcgc2l6ZSBp
cyByZWFkIGZyb20NCj4gY29uZmlnLCBhbmQgd291bGQgY2F1c2UgcnVudGltZSBjcmFzaC4gRG8g
c28gYnkgdXNpbmcgdGhlDQo+IFJURV9JU19QT1dFUl9PRl8yIG1hY3JvLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogSXNhYWMgQm91a3JpcyA8aWJvdWtyaXNAZ21haWwuY29tPg0KPiBBY2tlZC1ieTog
V2F0aHNhbGEgVml0aGFuYWdlIDx3YXRoc2FsYS52aXRoYW5hZ2VAYXJtLmNvbT4NCj4gQWNrZWQt
Ynk6IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQo+IC0tLQ0KPiAN
Cj4gdjM6DQo+ICogY2hhbmdlZCB0byB1c2UgdGhlIFJURV9JU19QT1dFUl9PRl8yIG1hY3JvLg0K
PiANCj4gdjI6DQo+ICogbW92ZSB0aGUgZml4IHRvIHRoZSBQT1dFUk9GMiBtYWNybyBpdHNlbGYu
DQo+ICogZml4ZWQgc3R5bGUgaW4gdGhlIHRlc3QgY29kZS4NCj4gDQo+ICBhcHAvdGVzdC90ZXN0
X3JpbmcuYyB8IDcgKysrKysrKw0KPiAgbGliL3JpbmcvcnRlX3JpbmcuYyAgfCA4ICsrKy0tLS0t
DQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYXBwL3Rlc3QvdGVzdF9yaW5nLmMgYi9hcHAvdGVzdC90ZXN0X3Jp
bmcuYw0KPiBpbmRleCBiYTFmZWMxZGUzLi4zMDc4MzQ4YjJmIDEwMDY0NA0KPiAtLS0gYS9hcHAv
dGVzdC90ZXN0X3JpbmcuYw0KPiArKysgYi9hcHAvdGVzdC90ZXN0X3JpbmcuYw0KPiBAQCAtNTA1
LDYgKzUwNSwxMyBAQCB0ZXN0X3JpbmdfbmVnYXRpdmVfdGVzdHModm9pZCkNCj4gIAlzdHJ1Y3Qg
cnRlX3JpbmcgKnJ0ID0gTlVMTDsNCj4gIAl1bnNpZ25lZCBpbnQgaTsNCj4gDQo+ICsJLyogVGVz
dCB6ZXJvIHNpemUgcmluZyAqLw0KPiArCXJwID0gdGVzdF9yaW5nX2NyZWF0ZSgidGVzdF96ZXJv
X3NpemVfcmluZyIsIC0xLCAwLCBTT0NLRVRfSURfQU5ZLCAwKTsNCj4gKwlpZiAocnAgIT0gTlVM
TCkgew0KPiArCQlwcmludGYoIlRlc3QgZmFpbGVkIHRvIGRldGVjdCB6ZXJvIHNpemUgcmluZ1xu
Iik7DQo+ICsJCWdvdG8gdGVzdF9mYWlsOw0KPiArCX0NCj4gKw0KPiAgCS8qIFRlc3Qgd2l0aCBl
c2l6ZSBub3QgYSBtdWx0aXBsZSBvZiA0ICovDQo+ICAJcnAgPSB0ZXN0X3JpbmdfY3JlYXRlKCJ0
ZXN0X2JhZF9lbGVtZW50X3NpemUiLCAyMywNCj4gIAkJCQlSSU5HX1NJWkUgKyAxLCBTT0NLRVRf
SURfQU5ZLCAwKTsNCj4gZGlmZiAtLWdpdCBhL2xpYi9yaW5nL3J0ZV9yaW5nLmMgYi9saWIvcmlu
Zy9ydGVfcmluZy5jDQo+IGluZGV4IGVkZDYzYWE1MzUuLmYxMDA1MGExYzQgMTAwNjQ0DQo+IC0t
LSBhL2xpYi9yaW5nL3J0ZV9yaW5nLmMNCj4gKysrIGIvbGliL3JpbmcvcnRlX3JpbmcuYw0KPiBA
QCAtMjUsNiArMjUsNyBAQA0KPiAgI2luY2x1ZGUgPHJ0ZV9zdHJpbmdfZm5zLmg+DQo+ICAjaW5j
bHVkZSA8cnRlX3RhaWxxLmg+DQo+ICAjaW5jbHVkZSA8cnRlX3RlbGVtZXRyeS5oPg0KPiArI2lu
Y2x1ZGUgPHJ0ZV9iaXRvcHMuaD4NCj4gDQo+ICAjaW5jbHVkZSAicnRlX3JpbmcuaCINCj4gICNp
bmNsdWRlICJydGVfcmluZ19lbGVtLmgiDQo+IEBAIC00Niw5ICs0Nyw2IEBAIEVBTF9SRUdJU1RF
Ul9UQUlMUShydGVfcmluZ190YWlscSkNCj4gIAkJICAgICBSSU5HX0ZfTVBfUlRTX0VOUSB8IFJJ
TkdfRl9NQ19SVFNfREVRIHwJICAgICAgIFwNCj4gIAkJICAgICBSSU5HX0ZfTVBfSFRTX0VOUSB8
IFJJTkdfRl9NQ19IVFNfREVRKQ0KPiANCj4gLS8qIHRydWUgaWYgeCBpcyBhIHBvd2VyIG9mIDIg
Ki8NCj4gLSNkZWZpbmUgUE9XRVJPRjIoeCkgKCgoKHgpLTEpICYgKHgpKSA9PSAwKQ0KPiAtDQo+
ICAvKiBieSBkZWZhdWx0IHNldCBoZWFkL3RhaWwgZGlzdGFuY2UgYXMgMS84IG9mIHJpbmcgY2Fw
YWNpdHkgKi8NCj4gICNkZWZpbmUgSFREX01BWF9ERUYJOA0KPiANCj4gQEAgLTY3LDcgKzY1LDcg
QEAgcnRlX3JpbmdfZ2V0X21lbXNpemVfZWxlbSh1bnNpZ25lZCBpbnQgZXNpemUsIHVuc2lnbmVk
IGludA0KPiBjb3VudCkNCj4gIAl9DQo+IA0KPiAgCS8qIGNvdW50IG11c3QgYmUgYSBwb3dlciBv
ZiAyICovDQo+IC0JaWYgKCghUE9XRVJPRjIoY291bnQpKSB8fCAoY291bnQgPiBSVEVfUklOR19T
Wl9NQVNLICkpIHsNCj4gKwlpZiAoKCFSVEVfSVNfUE9XRVJfT0ZfMihjb3VudCkpIHx8IChjb3Vu
dCA+IFJURV9SSU5HX1NaX01BU0spKSB7DQo+ICAJCVJJTkdfTE9HKEVSUiwNCj4gIAkJCSJSZXF1
ZXN0ZWQgbnVtYmVyIG9mIGVsZW1lbnRzIGlzIGludmFsaWQsIG11c3QgYmUgcG93ZXIgb2YNCj4g
MiwgYW5kIG5vdCBleGNlZWQgJXUiLA0KPiAgCQkJUlRFX1JJTkdfU1pfTUFTSyk7DQo+IEBAIC0y
MjcsNyArMjI1LDcgQEAgcnRlX3JpbmdfaW5pdChzdHJ1Y3QgcnRlX3JpbmcgKnIsIGNvbnN0IGNo
YXIgKm5hbWUsIHVuc2lnbmVkDQo+IGludCBjb3VudCwNCj4gIAkJci0+bWFzayA9IHItPnNpemUg
LSAxOw0KPiAgCQlyLT5jYXBhY2l0eSA9IGNvdW50Ow0KPiAgCX0gZWxzZSB7DQo+IC0JCWlmICgo
IVBPV0VST0YyKGNvdW50KSkgfHwgKGNvdW50ID4gUlRFX1JJTkdfU1pfTUFTSykpIHsNCj4gKwkJ
aWYgKCghUlRFX0lTX1BPV0VSX09GXzIoY291bnQpKSB8fCAoY291bnQgPiBSVEVfUklOR19TWl9N
QVNLKSkNCj4gew0KPiAgCQkJUklOR19MT0coRVJSLA0KPiAgCQkJCSJSZXF1ZXN0ZWQgc2l6ZSBp
cyBpbnZhbGlkLCBtdXN0IGJlIHBvd2VyIG9mIDIsIGFuZA0KPiBub3QgZXhjZWVkIHRoZSBzaXpl
IGxpbWl0ICV1IiwNCj4gIAkJCQlSVEVfUklOR19TWl9NQVNLKTsNCj4gLS0NCg0KQWNrZWQtYnk6
IEtvbnN0YW50aW4gQW5hbnlldiA8a29uc3RhbnRpbi5hbmFueWV2QGh1YXdlaS5jb20+DQoNCj4g
Mi40OS4wDQoNCg==
