Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A7BCAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 06:49:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4257540654;
	Mon, 22 Sep 2025 08:49:13 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 93A42402ED;
 Mon, 22 Sep 2025 08:49:11 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cVYVv5dyqz6L5SD;
 Mon, 22 Sep 2025 14:44:23 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id F2A8C1400CB;
 Mon, 22 Sep 2025 14:49:10 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Sep 2025 07:49:10 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 22 Sep 2025 07:49:10 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Nithin Dabilpuram <nithind1988@gmail.com>, Sivaprasad Tummala
 <sivaprasad.tummala@amd.com>
CC: "jerinj@marvell.com" <jerinj@marvell.com>, "kirankumark@marvell.com"
 <kirankumark@marvell.com>, "ndabilpuram@marvell.com"
 <ndabilpuram@marvell.com>, "yanzhirun_163@163.com" <yanzhirun_163@163.com>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "ktraynor@redhat.com" <ktraynor@redhat.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "konstantin.v.ananyev@yandex.ru"
 <konstantin.v.ananyev@yandex.ru>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "maxime.coquelin@redhat.com"
 <maxime.coquelin@redhat.com>, "aconole@redhat.com" <aconole@redhat.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] examples/l3fwd-graph: remove redundant Tx queue limit
Thread-Topic: [PATCH] examples/l3fwd-graph: remove redundant Tx queue limit
Thread-Index: AQHcG1dOQb3avSLjL0+HBBPzSFwn8rSewqUAgAAgKeA=
Date: Mon, 22 Sep 2025 06:49:10 +0000
Message-ID: <819a994c1ae6461795b6ee8356e2fc32@huawei.com>
References: <20250901154400.2333310-1-sivaprasad.tummala@amd.com>
 <CAMuDWKRZDdnrzjJGFpRTmfjcw-z+w+3wObc5bvUANA3JXStgkQ@mail.gmail.com>
In-Reply-To: <CAMuDWKRZDdnrzjJGFpRTmfjcw-z+w+3wObc5bvUANA3JXStgkQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.173.214]
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

DQoNCj4gT24gTW9uLCBTZXAgMSwgMjAyNSBhdCAxMTozOeKAr1BNIFNpdmFwcmFzYWQgVHVtbWFs
YQ0KPiA8c2l2YXByYXNhZC50dW1tYWxhQGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSW4gYGwz
ZndkLWdyYXBoYCBhcHBsaWNhdGlvbiwgVHggcXVldWVzIGFyZSBjb25maWd1cmVkIHBlciBsY29y
ZQ0KPiA+IHRvIGVuYWJsZSBhIGxvY2tsZXNzIGRlc2lnbiBhbmQgYWNoaWV2ZSBvcHRpbWFsIHBl
cmZvcm1hbmNlLg0KPiA+DQo+ID4gVGhlIGBNQVhfVFhfUVVFVUVfUEVSX1BPUlRgIG1hY3JvLCBk
ZWZpbmVkIGFzIGBSVEVfTUFYX0VUSFBPUlRTYCwNCj4gPiBpbnRyb2R1Y2VkIGFuIGFydGlmaWNp
YWwgY29uc3RyYWludCBvbiB0aGUgbnVtYmVyIG9mIFR4IHF1ZXVlcw0KPiA+IGFuZCBsaW1pdGVk
IGNvcmUtc2NhbGluZyBwZXJmb3JtYW5jZS4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggcmVtb3ZlcyB0
aGUgdW51c2VkIGBNQVhfVFhfUVVFVUVfUEVSX1BPUlRgIG1hY3JvIGFuZA0KPiA+IHJlZHVuZGFu
dCBUeCBxdWV1ZSBjaGVjaywgYWxsb3dpbmcgVHggcXVldWVzIHRvIHNjYWxlIGRpcmVjdGx5DQo+
ID4gd2l0aCB0aGUgbm8uIG9mIGxjb3Jlcy4NCj4gPg0KPiA+IEZpeGVzOiAwOGJkMWExNzQ0NjEg
KCJleGFtcGxlcy9sM2Z3ZC1ncmFwaDogYWRkIGdyYXBoLWJhc2VkIGwzZndkIHNrZWxldG9uIikN
Cj4gPiBDYzogbmRhYmlscHVyYW1AbWFydmVsbC5jb20NCj4gPiBDYzogc3RhYmxlQGRwZGsub3Jn
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaXZhcHJhc2FkIFR1bW1hbGEgPHNpdmFwcmFzYWQu
dHVtbWFsYUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBleGFtcGxlcy9sM2Z3ZC1ncmFwaC9tYWlu
LmMgfCAzIC0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9leGFtcGxlcy9sM2Z3ZC1ncmFwaC9tYWluLmMgYi9leGFtcGxlcy9sM2Z3
ZC1ncmFwaC9tYWluLmMNCj4gPiBpbmRleCA5MmNkYWExZWJlLi4xMjkwOGFjYmJhIDEwMDY0NA0K
PiA+IC0tLSBhL2V4YW1wbGVzL2wzZndkLWdyYXBoL21haW4uYw0KPiA+ICsrKyBiL2V4YW1wbGVz
L2wzZndkLWdyYXBoL21haW4uYw0KPiA+IEBAIC00OSw3ICs0OSw2IEBADQo+ID4gICNkZWZpbmUg
UlhfREVTQ19ERUZBVUxUIDEwMjQNCj4gPiAgI2RlZmluZSBUWF9ERVNDX0RFRkFVTFQgMTAyNA0K
PiA+DQo+ID4gLSNkZWZpbmUgTUFYX1RYX1FVRVVFX1BFUl9QT1JUIFJURV9NQVhfRVRIUE9SVFMN
Cj4gPiAgI2RlZmluZSBNQVhfUlhfUVVFVUVfUEVSX1BPUlQgMTI4DQoNCkFGQUlLLCBpbiB0aGUg
bWFpbmxpbmUgd2UgYWN0dWFsbHkgaGF2ZToNCiNkZWZpbmUgTUFYX1RYX1FVRVVFX1BFUl9QT1JU
IFJURV9NQVhfTENPUkUNCg0Kc2luY2U6DQpjb21taXQgODgyNTZlZDg1MzM4YzU3MmQ3MzAwNmU0
YzQ1MzBhNTJkM2I0NzdmZg0KQXV0aG9yOiBIYXJtYW4gS2FscmEgPGhrYWxyYUBtYXJ2ZWxsLmNv
bT4NCkRhdGU6ICAgVHVlIEphbiAxMiAyMzo1NDo0NiAyMDIxICswNTMwDQoNCiAgICBleGFtcGxl
cy9sM2Z3ZDogcmVtb3ZlIGxpbWl0YXRpb24gb24gVHggcXVldWUgY291bnQNCg0KV2hhdCBJIGFt
IG1pc3NpbmcgaGVyZT8NCg0KPiA+DQo+ID4gICNkZWZpbmUgTUFYX1JYX1FVRVVFX1BFUl9MQ09S
RSAxNg0KPiA+IEBAIC0xMDc2LDggKzEwNzUsNiBAQCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJn
dikNCj4gPg0KPiA+ICAgICAgICAgICAgICAgICBuYl9yeF9xdWV1ZSA9IGdldF9wb3J0X25fcnhf
cXVldWVzKHBvcnRpZCk7DQo+ID4gICAgICAgICAgICAgICAgIG5fdHhfcXVldWUgPSBuYl9sY29y
ZXM7DQo+ID4gLSAgICAgICAgICAgICAgIGlmIChuX3R4X3F1ZXVlID4gTUFYX1RYX1FVRVVFX1BF
Ul9QT1JUKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIG5fdHhfcXVldWUgPSBNQVhfVFhf
UVVFVUVfUEVSX1BPUlQ7DQo+ID4gICAgICAgICAgICAgICAgIHByaW50ZigiQ3JlYXRpbmcgcXVl
dWVzOiBuYl9yeHE9JWQgbmJfdHhxPSV1Li4uICIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICBuYl9yeF9xdWV1ZSwgbl90eF9xdWV1ZSk7DQo+ID4NCj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+
DQo=
