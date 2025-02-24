Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDAAC021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 11:13:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18C324042E;
	Mon, 24 Feb 2025 12:13:04 +0100 (CET)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mails.dpdk.org (Postfix) with ESMTP id 762B1402A4
 for <dev@dpdk.org>; Mon, 24 Feb 2025 12:13:02 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Z1dQM6cx7zpbLB;
 Mon, 24 Feb 2025 19:13:31 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
 by mail.maildlp.com (Postfix) with ESMTPS id 19BEE180214;
 Mon, 24 Feb 2025 19:13:00 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 24 Feb 2025 19:12:58 +0800
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 24 Feb 2025 12:12:56 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "david.hunt@intel.com" <david.hunt@intel.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>,
 "sivaprasad.tummala@amd.com" <sivaprasad.tummala@amd.com>, liuyonglong
 <liuyonglong@huawei.com>, Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH] power: use hugepage memory for queue list entry structure
Thread-Topic: [PATCH] power: use hugepage memory for queue list entry structure
Thread-Index: AQHbUezKxRn4I6S/S0+UBKv0KpGojbNQN46AgAAaEkCABjU+gIAALxgw
Date: Mon, 24 Feb 2025 11:12:56 +0000
Message-ID: <cebfbfb33329429a9a7e28ec717f80cf@huawei.com>
References: <20241219075319.8874-1-lihuisong@huawei.com>
 <01d163c6-6d18-03e8-ac67-e7907d27bd08@huawei.com>
 <60199571d93a4cf88d7ab9aa6a79611e@huawei.com>
 <683e3919-ec47-7918-92f5-fc805952ae75@huawei.com>
In-Reply-To: <683e3919-ec47-7918-92f5-fc805952ae75@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.73]
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

DQoNCj4gDQo+IOWcqCAyMDI1LzIvMjAgMTc6NDEsIEtvbnN0YW50aW4gQW5hbnlldiDlhpnpgZM6
DQo+ID4gSGkNCj4gPg0KPiA+PiBIaSBhbGwsDQo+ID4+DQo+ID4+IEtpbmRseSBwaW5nIGZvciBy
ZXZpZXcuDQo+ID4+DQo+ID4+DQo+ID4+IOWcqCAyMDI0LzEyLzE5IDE1OjUzLCBIdWlzb25nIExp
IOWGmemBkzoNCj4gPj4+IFRoZSBxdWV1ZV9saXN0X2VudHJ5IHN0cnVjdHVyZSBkYXRhIGlzIHVz
ZWQgaW4gcnhfY2FsbGJhY2sgb2YgaW8gcGF0aA0KPiA+Pj4gd2hlbiBlbmFibGUgUE1EIFBvd2Vy
IE1hbmFnZW1lbnQuIEhvd2V2ZXIgaXRzIG1lbW9yeSBpcyBjdXJyZW50bHkgZnJvbQ0KPiA+Pj4g
bm9ybWFsIGhlYXAgbWVtb3J5LiBGb3IgYmV0dGVyIHBlcmZvcm1hbmNlLCB1c2UgaHVnZXBhZ2Ug
bWVtb3J5IHRvDQo+ID4+PiByZXBsYWNlIGl0Lg0KPiA+IE1ha2Ugc2Vuc2UgdG8gbWUuDQo+ID4g
QWNrZWQtYnk6IEtvbnN0YW50aW4gQW5hbnlldiA8a29uc3RhbnRpbi5hbmFueWV2QGh1YXdlaS5j
b20+DQo+ID4NCj4gPiBJICBzdXBwb3NlIGl0IHdvdWxkIGFsc28gaGVscCBpZiB5b3UgY2FuIHBy
b3ZpZGUgc29tZSBudW1iZXJzOg0KPiA+IGkuZS46IGhvdyBtdWNoIGV4YWN0bHkgaXQgaXMgJ2Jl
dHRlcic/DQo+ID4gRGlkIHlvdSBzZWUgYW55IGNoYW5nZXMgaW4gdGhyb3VnaHB1dC9sYXRlbmN5
IG51bWJlcnMsIGV0Yy4NCj4gDQo+IFRoaXMgcGF0Y2ggaXMganVzdCBmcm9tIG15IGtub3dsZWRn
ZSBvZiBEUERLLg0KPiANCj4gSSBkb24ndCB3aGF0IGlzIHRoZSBnb29kIHdheSB0byBldmFsdWF0
ZSB0aGUgcGVyZm9ybWFuY2Ugb2YgbDNmd2QtcG93ZXIuDQo+IA0KPiBCdXQgSSBkaWQgYSB0ZXN0
IGZvciB0aGlzIGFmdGVyIHlvdSBzYWlkLg0KPiANCj4gSSBmb3VuZCB0aGF0IHRoZSB0aHJvdWdo
cHV0IG9mIHVzaW5nIG1hbGxvYyBpcyBiZXR0ZXIgdGhhbiBydGVfbWFsbG9jIGluDQo+IGNvbnRp
bnVvdXMgcGFja2V0IGZsb3cgY2FzZS7wn5iuDQo+IA0KPiBDYW4geW91IHRlc3QgdGhpcyBwYXRj
aCBvbiB5b3VyIHBsYXRmb3JtPw0KDQpJIGRpZCBhIHF1aWNrIHRlc3QgLSBkaWRuJ3Qgc2VlIGFu
eSBkaWZmIGluIHBlcmZvcm1hbmNlIChwYWNrZXQgZmxvb2RpbmcpIHdpdGgvd2l0aG91dCB0aGUg
cGF0Y2guDQogDQo+IA0KPiA+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBIdWlzb25nIExpIDxsaWh1
aXNvbmdAaHVhd2VpLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gICAgbGliL3Bvd2VyL3J0ZV9wb3dl
cl9wbWRfbWdtdC5jIHwgMTAgKysrKystLS0tLQ0KPiA+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEv
bGliL3Bvd2VyL3J0ZV9wb3dlcl9wbWRfbWdtdC5jIGIvbGliL3Bvd2VyL3J0ZV9wb3dlcl9wbWRf
bWdtdC5jDQo+ID4+PiBpbmRleCBhMmZmZjNiNzY1Li5jN2JmNTdhOTEwIDEwMDY0NA0KPiA+Pj4g
LS0tIGEvbGliL3Bvd2VyL3J0ZV9wb3dlcl9wbWRfbWdtdC5jDQo+ID4+PiArKysgYi9saWIvcG93
ZXIvcnRlX3Bvd2VyX3BtZF9tZ210LmMNCj4gPj4+IEBAIC05Nyw3ICs5Nyw3IEBAIHF1ZXVlX2xp
c3RfZmluZChjb25zdCBzdHJ1Y3QgcG1kX2NvcmVfY2ZnICpjZmcsIGNvbnN0IHVuaW9uIHF1ZXVl
ICpxKQ0KPiA+Pj4gICAgfQ0KPiA+Pj4NCj4gPj4+ICAgIHN0YXRpYyBpbnQNCj4gPj4+IC1xdWV1
ZV9saXN0X2FkZChzdHJ1Y3QgcG1kX2NvcmVfY2ZnICpjZmcsIGNvbnN0IHVuaW9uIHF1ZXVlICpx
KQ0KPiA+Pj4gK3F1ZXVlX2xpc3RfYWRkKHN0cnVjdCBwbWRfY29yZV9jZmcgKmNmZywgY29uc3Qg
dW5pb24gcXVldWUgKnEsIHVuc2lnbmVkIGludCBsY29yZV9pZCkNCj4gPj4+ICAgIHsNCj4gPj4+
ICAgIAlzdHJ1Y3QgcXVldWVfbGlzdF9lbnRyeSAqcWxlOw0KPiA+Pj4NCj4gPj4+IEBAIC0xMDUs
MTAgKzEwNSwxMCBAQCBxdWV1ZV9saXN0X2FkZChzdHJ1Y3QgcG1kX2NvcmVfY2ZnICpjZmcsIGNv
bnN0IHVuaW9uIHF1ZXVlICpxKQ0KPiA+Pj4gICAgCWlmIChxdWV1ZV9saXN0X2ZpbmQoY2ZnLCBx
KSAhPSBOVUxMKQ0KPiA+Pj4gICAgCQlyZXR1cm4gLUVFWElTVDsNCj4gPj4+DQo+ID4+PiAtCXFs
ZSA9IG1hbGxvYyhzaXplb2YoKnFsZSkpOw0KPiA+Pj4gKwlxbGUgPSBydGVfem1hbGxvY19zb2Nr
ZXQoTlVMTCwgc2l6ZW9mKCpxbGUpLCBSVEVfQ0FDSEVfTElORV9TSVpFLA0KPiA+Pj4gKwkJCQkg
cnRlX2xjb3JlX3RvX3NvY2tldF9pZChsY29yZV9pZCkpOw0KPiA+Pj4gICAgCWlmIChxbGUgPT0g
TlVMTCkNCj4gPj4+ICAgIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4+PiAtCW1lbXNldChxbGUsIDAs
IHNpemVvZigqcWxlKSk7DQo+ID4+Pg0KPiA+Pj4gICAgCXF1ZXVlX2NvcHkoJnFsZS0+cXVldWUs
IHEpOw0KPiA+Pj4gICAgCVRBSUxRX0lOU0VSVF9UQUlMKCZjZmctPmhlYWQsIHFsZSwgbmV4dCk7
DQo+ID4+PiBAQCAtNTcwLDcgKzU3MCw3IEBAIHJ0ZV9wb3dlcl9ldGhkZXZfcG1nbXRfcXVldWVf
ZW5hYmxlKHVuc2lnbmVkIGludCBsY29yZV9pZCwgdWludDE2X3QgcG9ydF9pZCwNCj4gPj4+ICAg
IAkJZ290byBlbmQ7DQo+ID4+PiAgICAJfQ0KPiA+Pj4gICAgCS8qIGFkZCB0aGlzIHF1ZXVlIHRv
IHRoZSBsaXN0ICovDQo+ID4+PiAtCXJldCA9IHF1ZXVlX2xpc3RfYWRkKGxjb3JlX2NmZywgJnFk
YXRhKTsNCj4gPj4+ICsJcmV0ID0gcXVldWVfbGlzdF9hZGQobGNvcmVfY2ZnLCAmcWRhdGEsIGxj
b3JlX2lkKTsNCj4gPj4+ICAgIAlpZiAocmV0IDwgMCkgew0KPiA+Pj4gICAgCQlQT1dFUl9MT0co
REVCVUcsICJGYWlsZWQgdG8gYWRkIHF1ZXVlIHRvIGxpc3Q6ICVzIiwNCj4gPj4+ICAgIAkJCQlz
dHJlcnJvcigtcmV0KSk7DQo+ID4+PiBAQCAtNjY0LDcgKzY2NCw3IEBAIHJ0ZV9wb3dlcl9ldGhk
ZXZfcG1nbXRfcXVldWVfZGlzYWJsZSh1bnNpZ25lZCBpbnQgbGNvcmVfaWQsDQo+ID4+PiAgICAJ
ICogY2FsbGJhY2tzIGNhbiBiZSBmcmVlZC4gd2UncmUgaW50ZW50aW9uYWxseSBjYXN0aW5nIGF3
YXkgY29uc3QtbmVzcy4NCj4gPj4+ICAgIAkgKi8NCj4gPj4+ICAgIAlydGVfZnJlZSgodm9pZCAq
KSh1aW50cHRyX3QpcXVldWVfY2ZnLT5jYik7DQo+ID4+PiAtCWZyZWUocXVldWVfY2ZnKTsNCj4g
Pj4+ICsJcnRlX2ZyZWUocXVldWVfY2ZnKTsNCj4gPj4+DQo+ID4+PiAgICAJcmV0dXJuIDA7DQo+
ID4+PiAgICB9DQo=
