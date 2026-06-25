Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EBDCDB47F
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 06:01:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C15640663;
	Thu, 25 Jun 2026 08:01:24 +0200 (CEST)
Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
 by mails.dpdk.org (Postfix) with ESMTP id 8C6034025F
 for <dev@dpdk.org>; Thu, 25 Jun 2026 08:01:22 +0200 (CEST)
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4gm7Tr59h2z1b0Rh;
 Thu, 25 Jun 2026 14:01:20 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4gm7Tn58yrz1b0Rh;
 Thu, 25 Jun 2026 14:01:17 +0800 (CST)
Received: from cncheex03.Hygon.cn (unknown [172.23.18.113])
 by maildlp1.hygon.cn (Postfix) with ESMTPS id C287891FE;
 Thu, 25 Jun 2026 14:01:09 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex03.Hygon.cn
 (172.23.18.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 25 Jun
 2026 14:01:17 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Thu, 25 Jun 2026 14:01:17 +0800
From: Liangxing Wang <wangliangxing@hygon.cn>
To: "thomas@monjalon.net" <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, fengchengwen <fengchengwen@huawei.com>
Subject: RE: [PATCH v3 0/2] Extend NUMA nodes limit
Thread-Topic: [PATCH v3 0/2] Extend NUMA nodes limit
Thread-Index: AQHcpi2EBfMTEG03Y0KYWGG/jeVVW7WTt9gAgChS8rCAk3in8A==
Date: Thu, 25 Jun 2026 06:01:17 +0000
Message-ID: <446f513ff01b4355aa5aa61b3011c865@hygon.cn>
References: <20260225080419.727470-1-wangliangxing@hygon.cn>
 <ac35b365-8efe-4930-99ee-1d68a92cc972@huawei.com> 
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

SGkgVGhvbWFzLA0KDQpGcmllbmRseSBwaW5nIGZvciByZXZpZXcvdXBzdHJlYW0sIHRoYW5rcy4N
Cg0KUmVnYXJkcywNCkxpYW5neGluZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IExpYW5neGluZyBXYW5nDQo+IFNlbnQ6IDIwMjblubQz5pyIMjPml6UgMTg6MDENCj4g
VG86ICdmZW5nY2hlbmd3ZW4nIDxmZW5nY2hlbmd3ZW5AaHVhd2VpLmNvbT47IHRob21hc0Btb25q
YWxvbi5uZXQNCj4gQ2M6IGRldkBkcGRrLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYzIDAv
Ml0gRXh0ZW5kIE5VTUEgbm9kZXMgbGltaXQNCj4gDQo+IEhpIFRob21hcywNCj4gDQo+IEZyaWVu
ZGx5IHBpbmcgZm9yIHJldmlldy91cHN0cmVhbS4NCj4gDQo+IFJlZ2FyZHMsDQo+IExpYW5neGlu
Zw0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IGZlbmdjaGVu
Z3dlbiA8ZmVuZ2NoZW5nd2VuQGh1YXdlaS5jb20+DQo+ID4gU2VudDogMjAyNuW5tDLmnIgyNuaX
pSAxMDoxMQ0KPiA+IFRvOiBMaWFuZ3hpbmcgV2FuZyA8d2FuZ2xpYW5neGluZ0BoeWdvbi5jbj47
IHRob21hc0Btb25qYWxvbi5uZXQ7DQo+ID4gc3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmcNCj4g
PiBDYzogZGV2QGRwZGsub3JnDQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzJdIEV4dGVu
ZCBOVU1BIG5vZGVzIGxpbWl0DQo+ID4NCj4gPiBTZXJpZXMtYWNrZWQtYnk6IENoZW5nd2VuIEZl
bmcgPGZlbmdjaGVuZ3dlbkBodWF3ZWkuY29tPg0KPiA+DQo+ID4gT24gMi8yNS8yMDI2IDQ6MDQg
UE0sIExpYW5neGluZyBXYW5nIHdyb3RlOg0KPiA+ID4gVGhpcyBwYXRjaHNldCB1c2UgUlRFX01B
WF9OVU1BX05PREVTIGluc3RlYWQgb2YgaGFyZGNvZGVkIHZhbHVlcyB0bw0KPiA+ID4gZXh0ZW5k
IE5VTUEgbm9kZXMgbGltaXQgZm9yIHNvbWUgZXhhbXBsZXMgYW5kIHRlc3QgYXBwLiBBbHNvIHJl
bW92ZQ0KPiA+ID4gdW51c2VkIE5CX1NPQ0tFVFMgbWFjcm8gZm9yIGlwX3JlYXNzZW1ibHkgZXhh
bXBsZSBhbmQgZ3JhcGggYXBwLg0KPiA+ID4NCj4gPiA+IExpYW5neGluZyBXYW5nICgyKToNCj4g
PiA+ICAgZXhhbXBsZXM6IGV4dGVuZCBOVU1BIG5vZGVzIGxpbWl0DQo+ID4gPiAgIGFwcDogZXh0
ZW5kIE5VTUEgbm9kZXMgbGltaXQNCj4gPiA+DQo+ID4gPiAgYXBwL2dyYXBoL2V0aGRldl9yeF9w
cml2LmggICAgICAgICB8IDEgLQ0KPiA+ID4gIGFwcC90ZXN0L3Rlc3RfcG1kX3BlcmYuYyAgICAg
ICAgICAgfCAyICstDQo+ID4gPiAgZXhhbXBsZXMvaXBfcmVhc3NlbWJseS9tYWluLmMgICAgICB8
IDIgLS0NCj4gPiA+ICBleGFtcGxlcy9pcHNlYy1zZWNndy9pcHNlYy1zZWNndy5oIHwgMiArLQ0K
PiA+ID4gIGV4YW1wbGVzL2wzZndkLWdyYXBoL21haW4uYyAgICAgICAgfCAyICstDQo+ID4gPiAg
ZXhhbXBsZXMvbDNmd2QtcG93ZXIvbWFpbi5jICAgICAgICB8IDIgKy0NCj4gPiA+ICBleGFtcGxl
cy9sM2Z3ZC9sM2Z3ZC5oICAgICAgICAgICAgIHwgMiArLQ0KPiA+ID4gIGV4YW1wbGVzL3Zob3N0
X2NyeXB0by9tYWluLmMgICAgICAgfCAyICstDQo+ID4gPiAgOCBmaWxlcyBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+DQoNCg==

