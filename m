Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76CACCF2D0
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 09:19:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 510364025D;
	Mon, 19 Jan 2026 10:19:29 +0100 (CET)
Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
 by mails.dpdk.org (Postfix) with ESMTP id A63E94025A
 for <dev@dpdk.org>; Mon, 19 Jan 2026 10:19:26 +0100 (CET)
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
 by mailgw2.hygon.cn (Postfix) with ESMTP id 4dvlJr1jJHz1YFqxm;
 Mon, 19 Jan 2026 17:19:24 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
 by mailgw2.hygon.cn (Postfix) with ESMTP id 4dvlJn3KHyz1YFqxm;
 Mon, 19 Jan 2026 17:19:21 +0800 (CST)
Received: from cncheex03.Hygon.cn (unknown [172.23.18.113])
 by maildlp1.hygon.cn (Postfix) with ESMTPS id 078E11546;
 Mon, 19 Jan 2026 17:19:18 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex03.Hygon.cn
 (172.23.18.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 19 Jan
 2026 17:19:21 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Mon, 19 Jan 2026 17:19:21 +0800
From: Liangxing Wang <wangliangxing@hygon.cn>
To: "thomas@monjalon.net" <thomas@monjalon.net>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 1/3] examples/l3fwd: extend NUMA nodes limit beyond 8
Thread-Topic: [PATCH v2 1/3] examples/l3fwd: extend NUMA nodes limit beyond 8
Thread-Index: AQHcgHCUC5q1bz9lpE6JM/w8ds+K5bVZRsQg
Date: Mon, 19 Jan 2026 09:19:21 +0000
Message-ID: <c0fde19abc9e4b44b2d21a9cf22553e8@hygon.cn>
References: <20260108072919.1279731-1-wangliangxing@hygon.cn>
In-Reply-To: <20260108072919.1279731-1-wangliangxing@hygon.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.19.25.208]
Content-Type: text/plain; charset="gb2312"
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

SGksDQoNCk5vdCBzdXJlIGZvciB3aGF0IHJlYXNvbiwgdGhlcmUgd2Fzbid0IGFueSB0ZXN0IGNo
ZWNrIHRyaWdnZXJlZCBieSB0aGlzIHBhdGNoLiBEbyBJIGhhdmUgdG8gc3VibWl0IGEgbmV3IHBh
dGNoIHZlcnNpb24gdG8gdHJpZ2dlciB0aGUgdGVzdHM/IFRoYW5rcy4NCg0KUmVnYXJkcywNCkxp
YW5neGluZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExpYW5neGlu
ZyBXYW5nIDx3YW5nbGlhbmd4aW5nQGh5Z29uLmNuPg0KPiBTZW50OiAyMDI2xOox1MI4yNUgMTU6
MjkNCj4gVG86IHRob21hc0Btb25qYWxvbi5uZXQ7IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3Jn
Ow0KPiBmZW5nY2hlbmd3ZW5AaHVhd2VpLmNvbQ0KPiBDYzogZGV2QGRwZGsub3JnOyBMaWFuZ3hp
bmcgV2FuZyA8d2FuZ2xpYW5neGluZ0BoeWdvbi5jbj47DQo+IHN0YWJsZUBkcGRrLm9yZw0KPiBT
dWJqZWN0OiBbUEFUQ0ggdjIgMS8zXSBleGFtcGxlcy9sM2Z3ZDogZXh0ZW5kIE5VTUEgbm9kZXMg
bGltaXQgYmV5b25kIDgNCj4gDQo+IEZvciBwbGF0Zm9ybXMgd2l0aCBtb3JlIHRoYW4gOCBOVU1B
IG5vZGVzLCBleGFtcGxlcyBsM2Z3ZCwgbDNmd2QtZ3JhcGgsDQo+IGFuZCBsM2Z3ZC1wb3dlciBm
YWlsIHdoZW4gdXNpbmcgY29yZXMgb24gTlVNQSBub2RlIDggb3IgYWJvdmUuDQo+IA0KPiBVc2Ug
UlRFX01BWF9OVU1BX05PREVTIGluc3RlYWQgb2YgOCB0byBleHRlbmQgTlVNQSBub2RlcyBsaW1p
dC4NCj4gDQo+IENjOiBzdGFibGVAZHBkay5vcmcNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExpYW5n
eGluZyBXYW5nIDx3YW5nbGlhbmd4aW5nQGh5Z29uLmNuPg0KPiAtLS0NCj4gIGV4YW1wbGVzL2wz
ZndkLWdyYXBoL21haW4uYyB8IDIgKy0NCj4gIGV4YW1wbGVzL2wzZndkLXBvd2VyL21haW4uYyB8
IDIgKy0NCj4gIGV4YW1wbGVzL2wzZndkL2wzZndkLmggICAgICB8IDIgKy0NCj4gIDMgZmlsZXMg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2V4YW1wbGVzL2wzZndkLWdyYXBoL21haW4uYyBiL2V4YW1wbGVzL2wzZndkLWdyYXBoL21h
aW4uYw0KPiBpbmRleCA5MmNkYWExZWJlLi5kNzdiNWY0ZWY2IDEwMDY0NA0KPiAtLS0gYS9leGFt
cGxlcy9sM2Z3ZC1ncmFwaC9tYWluLmMNCj4gKysrIGIvZXhhbXBsZXMvbDNmd2QtZ3JhcGgvbWFp
bi5jDQo+IEBAIC01Niw3ICs1Niw3IEBADQo+IA0KPiAgI2RlZmluZSBNQVhfTENPUkVfUEFSQU1T
IDEwMjQNCj4gDQo+IC0jZGVmaW5lIE5CX1NPQ0tFVFMgOA0KPiArI2RlZmluZSBOQl9TT0NLRVRT
IFJURV9NQVhfTlVNQV9OT0RFUw0KPiANCj4gIC8qIEdyYXBoIG1vZHVsZSAqLw0KPiAgI2RlZmlu
ZSBXT1JLRVJfTU9ERUxfUlRDICJydGMiDQo+IGRpZmYgLS1naXQgYS9leGFtcGxlcy9sM2Z3ZC1w
b3dlci9tYWluLmMgYi9leGFtcGxlcy9sM2Z3ZC1wb3dlci9tYWluLmMNCj4gaW5kZXggZWMxMmQx
Y2MwYi4uNTM0ZTQzOGQwYiAxMDA2NDQNCj4gLS0tIGEvZXhhbXBsZXMvbDNmd2QtcG93ZXIvbWFp
bi5jDQo+ICsrKyBiL2V4YW1wbGVzL2wzZndkLXBvd2VyL21haW4uYw0KPiBAQCAtMTE1LDcgKzEx
NSw3IEBAIFJURV9MT0dfUkVHSVNURVIobDNmd2RfcG93ZXJfbG9ndHlwZSwNCj4gbDNmd2QucG93
ZXIsIElORk8pOw0KPiANCj4gICNkZWZpbmUgQlVSU1RfVFhfRFJBSU5fVVMgMTAwIC8qIFRYIGRy
YWluIGV2ZXJ5IH4xMDB1cyAqLw0KPiANCj4gLSNkZWZpbmUgTkJfU09DS0VUUyA4DQo+ICsjZGVm
aW5lIE5CX1NPQ0tFVFMgUlRFX01BWF9OVU1BX05PREVTDQo+IA0KPiAgLyogQ29uZmlndXJlIGhv
dyBtYW55IHBhY2tldHMgYWhlYWQgdG8gcHJlZmV0Y2gsIHdoZW4gcmVhZGluZyBwYWNrZXRzICov
DQo+ICAjZGVmaW5lIFBSRUZFVENIX09GRlNFVAkzDQo+IGRpZmYgLS1naXQgYS9leGFtcGxlcy9s
M2Z3ZC9sM2Z3ZC5oIGIvZXhhbXBsZXMvbDNmd2QvbDNmd2QuaCBpbmRleA0KPiA0NzFlM2I0ODhm
Li5jYTlkMGQyZGQwIDEwMDY0NA0KPiAtLS0gYS9leGFtcGxlcy9sM2Z3ZC9sM2Z3ZC5oDQo+ICsr
KyBiL2V4YW1wbGVzL2wzZndkL2wzZndkLmgNCj4gQEAgLTMzLDcgKzMzLDcgQEANCj4gICNkZWZp
bmUgVkVDVE9SX1NJWkVfREVGQVVMVCAgIE1BWF9QS1RfQlVSU1QNCj4gICNkZWZpbmUgVkVDVE9S
X1RNT19OU19ERUZBVUxUIDFFNiAvKiAxbXMgKi8NCj4gDQo+IC0jZGVmaW5lIE5CX1NPQ0tFVFMg
ICAgICAgIDgNCj4gKyNkZWZpbmUgTkJfU09DS0VUUyAgICAgICAgUlRFX01BWF9OVU1BX05PREVT
DQo+IA0KPiAgLyogQ29uZmlndXJlIGhvdyBtYW55IHBhY2tldHMgYWhlYWQgdG8gcHJlZmV0Y2gs
IHdoZW4gcmVhZGluZyBwYWNrZXRzICovDQo+ICAjZGVmaW5lIFBSRUZFVENIX09GRlNFVAkgIDMN
Cj4gLS0NCj4gMi40My4wDQoNCg==

