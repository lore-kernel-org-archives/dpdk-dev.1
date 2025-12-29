Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F006BD3B7E5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 02:56:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BC6C402A0;
	Mon, 29 Dec 2025 03:56:12 +0100 (CET)
Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
 by mails.dpdk.org (Postfix) with ESMTP id EDBFD40267;
 Mon, 29 Dec 2025 03:56:09 +0100 (CET)
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4dfgp63gz1z25f5C;
 Mon, 29 Dec 2025 10:55:58 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4dfgp53TsCz25f5C;
 Mon, 29 Dec 2025 10:55:57 +0800 (CST)
Received: from cncheex06.Hygon.cn (unknown [172.23.18.116])
 by maildlp1.hygon.cn (Postfix) with ESMTPS id 5FEBD78AA;
 Mon, 29 Dec 2025 10:55:55 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex06.Hygon.cn
 (172.23.18.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 29 Dec
 2025 10:55:58 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Mon, 29 Dec 2025 10:55:58 +0800
From: Liangxing Wang <wangliangxing@hygon.cn>
To: fengchengwen <fengchengwen@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] examples/l3fwd: extend NUMA nodes limit beyond 8
Thread-Topic: [PATCH] examples/l3fwd: extend NUMA nodes limit beyond 8
Thread-Index: AQHcdkAhExcq1e/bDE6F7yRTUF7zjbU0qeKAgANFecA=
Date: Mon, 29 Dec 2025 02:55:58 +0000
Message-ID: <3d56e737305b43b29bea1d2a8b27a4c7@hygon.cn>
References: <20251226081719.1120313-1-wangliangxing@hygon.cn>
 <06d7fffb-558c-4088-8410-8943d12724fe@huawei.com>
In-Reply-To: <06d7fffb-558c-4088-8410-8943d12724fe@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.19.25.208]
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

VGhhbmtzIGZvciB0aGUgcmVtaW5kZXIuIE5vdGljZWQgdGhhdCB0b28uIE1heWJlIEkgY2FuIHVz
ZSBhbm90aGVyIGNvbW1pdCB0byBjb3ZlciBhbGwgb3RoZXIgZXhhbXBsZXMgdGhhdCBuZWVkIG1v
ZGlmaWNhdGlvbi4NCg0KUmVnYXJkcywNCkxpYW5neGluZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IGZlbmdjaGVuZ3dlbiA8ZmVuZ2NoZW5nd2VuQGh1YXdlaS5jb20+
DQo+IFNlbnQ6IDIwMjXlubQxMuaciDI35pelIDE2OjUzDQo+IFRvOiBMaWFuZ3hpbmcgV2FuZyA8
d2FuZ2xpYW5neGluZ0BoeWdvbi5jbj47IGRldkBkcGRrLm9yZw0KPiBDYzogc3RhYmxlQGRwZGsu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGV4YW1wbGVzL2wzZndkOiBleHRlbmQgTlVNQSBu
b2RlcyBsaW1pdCBiZXlvbmQgOA0KPiANCj4gQWNrZWQtYnk6IENoZW5nd2VuIEZlbmcgPGZlbmdj
aGVuZ3dlbkBodWF3ZWkuY29tPg0KPiANCj4gQlRXOiBPdGhlciBleGFtcGxlcyBhbHNvIGRlZmlu
ZWQgdGhlIE5CX1NPQ0tUUyAoZS5nLg0KPiBsM2Z3ZC1wb3dlci9sM2Z3ZC1ncmFwaC9pcHNlYy1z
ZWNndyksDQo+ICAgICAgaG93IGFib3V0IGFkZCBtb3JlIGNvbW1pdHMgdG8gZml4Lg0KPiANCj4g
T24gMTIvMjYvMjAyNSA0OjE3IFBNLCBMaWFuZ3hpbmcgV2FuZyB3cm90ZToNCj4gPiBGb3IgcGxh
dGZvcm1zIHdpdGggbW9yZSB0aGFuIDggTlVNQSBub2RlcywgdGhlIGwzZndkIGV4YW1wbGUgZmFp
bHMNCj4gPiB3aGVuIHVzaW5nIGNvcmVzIG9uIE5VTUEgbm9kZSA4IG9yIGFib3ZlLg0KPiA+DQo+
ID4gVXNlIFJURV9NQVhfTlVNQV9OT0RFUyBpbnN0ZWFkIG9mIDggdG8gZXh0ZW5kIE5VTUEgbm9k
ZXMgbGltaXQuDQo+ID4NCj4gPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBMaWFuZ3hpbmcgV2FuZyA8d2FuZ2xpYW5neGluZ0BoeWdvbi5jbj4NCj4gPiAtLS0N
Cj4gPiAgZXhhbXBsZXMvbDNmd2QvbDNmd2QuaCB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZXhh
bXBsZXMvbDNmd2QvbDNmd2QuaCBiL2V4YW1wbGVzL2wzZndkL2wzZndkLmggaW5kZXgNCj4gPiA0
NzFlM2I0ODhmLi5jYTlkMGQyZGQwIDEwMDY0NA0KPiA+IC0tLSBhL2V4YW1wbGVzL2wzZndkL2wz
ZndkLmgNCj4gPiArKysgYi9leGFtcGxlcy9sM2Z3ZC9sM2Z3ZC5oDQo+ID4gQEAgLTMzLDcgKzMz
LDcgQEANCj4gPiAgI2RlZmluZSBWRUNUT1JfU0laRV9ERUZBVUxUICAgTUFYX1BLVF9CVVJTVA0K
PiA+ICAjZGVmaW5lIFZFQ1RPUl9UTU9fTlNfREVGQVVMVCAxRTYgLyogMW1zICovDQo+ID4NCj4g
PiAtI2RlZmluZSBOQl9TT0NLRVRTICAgICAgICA4DQo+ID4gKyNkZWZpbmUgTkJfU09DS0VUUyAg
ICAgICAgUlRFX01BWF9OVU1BX05PREVTDQo+ID4NCj4gPiAgLyogQ29uZmlndXJlIGhvdyBtYW55
IHBhY2tldHMgYWhlYWQgdG8gcHJlZmV0Y2gsIHdoZW4gcmVhZGluZyBwYWNrZXRzDQo+ICovDQo+
ID4gICNkZWZpbmUgUFJFRkVUQ0hfT0ZGU0VUCSAgMw0KPiANCg0K

