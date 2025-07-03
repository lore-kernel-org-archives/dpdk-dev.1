Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC910C77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 08:12:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AD8D40298;
	Thu,  3 Jul 2025 10:12:52 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 300024028E
 for <dev@dpdk.org>; Thu,  3 Jul 2025 10:12:50 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXqHD34HZz6M5NV;
 Thu,  3 Jul 2025 16:11:52 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
 by mail.maildlp.com (Postfix) with ESMTPS id 404C71402F3;
 Thu,  3 Jul 2025 16:12:49 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Jul 2025 10:12:49 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 3 Jul 2025 10:12:49 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] net/i40e: Fast release optimizations
Thread-Topic: [PATCH] net/i40e: Fast release optimizations
Thread-Index: AQHb5M8cy6WBmzI3MUC2TH1cjpMU4LQbm/iwgAAfruCAACXVQIAAjgtQgACQEeCAAxIakA==
Date: Thu, 3 Jul 2025 08:12:48 +0000
Message-ID: <03b6263113f642828843b60878c811e6@huawei.com>
References: <20250624061238.89259-1-mb@smartsharesystems.com>
 <cda18d9197ed4ee9bd5ed73fd02bd032@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD5F@smartserver.smartshare.dk>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD60@smartserver.smartshare.dk>
 <bb4a70c74968437491d61714994a7006@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD67@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD67@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.244.118]
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

DQoNCj4gPiBJIGFtIHRhbGtpbmcgYWJvdXQgZGlmZmVyZW50IHRoaW5nOg0KPiA+IEkgdGhpbmsg
d2l0aCBzb21lIGV4dHJhIGVmZm9ydCBkcml2ZXIgY2FuIHVzZSAoaW4gc29tZSBjYXNlcykNCj4g
PiBydGVfbWJ1Zl9yYXdfZnJlZV9idWxrKCkgIGV2ZW4gIHdoZW4gICBSVEVfRVRIX1RYX09GRkxP
QURfTUJVRl9GQVNUX0ZSRUUNCj4gPiBpcyBub3Qgc3BlY2lmaWVkLg0KPiA+IExldCBzYXkgd2Ug
Y2FuIG1ha2UgdHhxLT5mYXN0X2ZyZWVfbXBbXSBhbiBhcnJheSB3aXRoIHRoZSBzYW1lIHNpemUg
YXMgdHhxLQ0KPiA+ID50eGVwW10uDQo+ID4gQXQgdHhfYnVyc3QoKSB3aGVuIGZpbGxpbmcgdHhl
cFtdIHdlIGNhbiBkbyBwcmVfZnJlZSgpIGNoZWNrcyBmb3IgdGhhdCBtYnVmLA0KPiA+IGFuZCBp
biBjYXNlIG9mIHN1Y2Nlc3Mgc3RvcmUgaXQncyBtZW1wb29sIHBvaW50ZXIgaW4gY29ycmVzcG9u
ZGluZyAgdHhxLQ0KPiA+ID5mYXN0X2ZyZWVfbXBbXSwNCj4gPiBvdGhlcndpc2UgcHV0IE5VTEwg
dGhlcmUuDQo+ID4gVGhlbiBhdCB0eF9mcmVlKCkgd2UgY2FuIHNjYW4gZmFzdF9mcmVlX21wW10g
YW5kIGludm9rZSAgIHJhd19mcmVlKCkgZm9yIG5vbi0NCj4gPiBOVUxMIGVudHJpZXMuDQo+ID4g
QWdhaW4sIGZvciBub3cgaXQgaXMganVzdCBhbiBpZGVhIHByb2JhYmx5IHdvcnRoIHRvIHRoaW5r
IGFib3V0Lg0KPiANCj4gWWVzLCB0aGF0IHNlZW1zIGxpa2UgYW4gZXhjZWxsZW50IGlkZWEsIGNl
cnRhaW5seSB3b3J0aCBjb25zaWRlcmluZyENCj4gDQo+IEF0IHR4X2ZyZWUoKSwgdGhlIG1idWZz
IG1pZ2h0IGJlIGNvbGQsIHNvIG5vdCBhY2Nlc3NpbmcgdGhlbSBhdCB0aGlzIHBvaW50IGltcHJv
dmVzIHBlcmZvcm1hbmNlLiAoV2hpY2ggaXMgYWxzbyB0aGUgcG9pbnQgb2YgbXkNCj4gcGF0Y2gu
KQ0KDQpZZXMuDQoNCj4gDQo+IEF0IHR4X2J1cnN0KCksIHRoZSBtYnVmcyBhcmUgcmVhZCBhbnl3
YXkgKHRoZWlyIGluZm9ybWF0aW9uIGlzIHdyaXR0ZW4gaW50byB0aGUgdHggZGVzY3JpcHRvcnMp
LCBzbyB0aGUgbWJ1ZnMgYXJlIGhvdCBpbiB0aGUgY2FjaGUgYXQNCj4gdGhpcyBwb2ludC4NCg0K
WWVzLg0KIA0KPiBCZXN0IGNhc2Ugd2l0aCB5b3VyIHN1Z2dlc3Rpb24sIHJ0ZV9wa3RtYnVmX3By
ZWZyZWVfc2VnKCkgZG9lc24ndCB3cml0ZSB0aGUgbWJ1Ziwgc28gdGhlIHBlcmZvcm1hbmNlIGNv
c3Qgb2YgZG9pbmcgaXQgYXQgdHhfYnVyc3QoKQ0KPiBpcyBleHRyZW1lbHkgbG93Lg0KDQpZZXMu
IA0KDQo+IFdvcnN0IGNhc2Ugd2l0aCB5b3VyIHN1Z2dlc3Rpb24sIHJ0ZV9wa3RtYnVmX3ByZWZy
ZWVfc2VnKCkgZG9lcyB3cml0ZSB0aGUgbWJ1Ziwgc28gdGhlIG1idWYgd3JpdGUgb3BlcmF0aW9u
IHNpbXBseSBtb3ZlcyBmcm9tDQo+IHR4X2ZyZWUoKSB0byB0eF9idXJzdCgpLg0KPiBIb3dldmVy
LCBpbiB0eF9idXJzdCgpLCB0aGUgbWJ1ZiBpcyBhbHJlYWR5IGhvdCBpbiB0aGUgY2FjaGUsIHNv
IHBlciB0cmFuc21pdHRlZCBtYnVmLCB3ZSBnZXQgb25lIGxvYWQrc3RvcmUgYXQgdHhfYnVyc3Qo
KSBpbnN0ZWFkIG9mDQo+IG9uZSBsb2FkIGF0IHR4X2J1cnN0KCkgKyBvbmUgbG9hZCtzdG9yZSBh
dCB0eF9mcmVlKCkuDQoNCkkgc3VwcG9zZSB5b3UgcGxhbiB0byBpbnZva2UgZnVsbCAgcnRlX3Br
dG1idWZfcHJlZnJlZV9zZWcoKSBoZXJlPw0KVW5mb3J0dW5hdGVseSwgSSBkb24ndCB0aGluayBp
dCBpcyBwb3NzaWJsZSAtIGZvciBjYXNlcyB3aGVuIHJlZmNudCA+IDEsIHdlIG5lZWQgdG8gZGVj
cmVtZW50IHJlZmNudCBvbmx5IHdoZW4gd2UgYXJlIHJlYWR5IHRvDQpyZWxlYXNlIHRoZSBtYnVm
LiBPdGhlcndpc2Ugd2UgY2FuIGVuZCB1cCB3aXRoIE5JQyBIVyByZWFkaW5nIGZyb20gYWxyZWFk
eSByZWxlYXNlZCAoYW5kIHByb2JhYmx5IHJlLXVzZWQpIG1idWYuDQpXaGF0IHdlIHByb2JhYmx5
IG5lZWQgaXMgYSBsaWdodHdlaWdodCB2ZXJzaW9uIG9mICAgcnRlX3BrdG1idWZfcHJlZnJlZV9z
ZWcoKSB0aGF0IHdvdWxkIHJldHVybiBub3QtTlVMTCB2YWx1ZSBvbmx5IHdoZW4NCnJlZmNudD09
MSwgYW5kIHNlZ21lbnQgYW5kIG5vdCBpbmRpcmVjdCBtYnVmIG9yIGV4dGVybmFsIG1lbW9yeSBh
dHRhY2hlZC4NClNvbWV0aGluZyBsaWtlOg0KDQpzdGF0aWMgX19ydGVfYWx3YXlzX2lubGluZSBz
dHJ1Y3QgcnRlX21idWYgKg0KcnRlX3BrdG1idWZfcHJlZnJlZV9jaGVjayhzY29uc3QgdHJ1Y3Qg
cnRlX21idWYgKm0pDQp7DQogICAgICAgIGlmIChydGVfbWJ1Zl9yZWZjbnRfcmVhZChtKSA9PSAx
ICYmIFJURV9NQlVGX0RJUkVDVChtKSkNCiAgICAgICAgICAgICByZXR1cm4gbTsNCiAgICAgICBy
ZXR1cm4gTlVMTDsNCn0NCg0KU28gYXQgd29yc3QgY2FzZSAod2hlbiBzdWNoIGNoZWNrIHdpbGwg
cmV0dXJuIE5VTEwpIHdlIHN0aWxsIG5lZWQgdG8gZG8gbG9hZCtzdG9yZSBhdCB0eF9mcmVlKCku
IA0KDQoNCg0KIA0KDQoNCg==
