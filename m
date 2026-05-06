Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37E8CD3424
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 08:21:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25D214026D;
	Wed,  6 May 2026 10:21:15 +0200 (CEST)
Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
 by mails.dpdk.org (Postfix) with ESMTP id B8F24400D6
 for <dev@dpdk.org>; Wed,  6 May 2026 10:21:13 +0200 (CEST)
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4g9SyG1VHzz1P6SM;
 Wed,  6 May 2026 16:21:10 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4g9SyD6qQXz1P6SM;
 Wed,  6 May 2026 16:21:08 +0800 (CST)
Received: from cncheex03.Hygon.cn (unknown [172.23.18.113])
 by maildlp1.hygon.cn (Postfix) with ESMTPS id 1CE02A93E;
 Wed,  6 May 2026 16:21:03 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex03.Hygon.cn
 (172.23.18.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 6 May
 2026 16:20:44 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Wed, 6 May 2026 16:20:44 +0800
From: Liangxing Wang <wangliangxing@hygon.cn>
To: "thomas@monjalon.net" <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, fengchengwen <fengchengwen@huawei.com>
Subject: RE: [PATCH v3 0/2] Extend NUMA nodes limit
Thread-Topic: [PATCH v3 0/2] Extend NUMA nodes limit
Thread-Index: AQHcpi2EBfMTEG03Y0KYWGG/jeVVW7WTt9gAgChS8rCARQoYEA==
Date: Wed, 6 May 2026 08:20:44 +0000
Message-ID: <9328565675b04a4d883b3fbef4e42746@hygon.cn>
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

SGkgVGhvbWFzLA0KDQpGcmllbmRseSBwaW5nIGZvciByZXZpZXcvdXBzdHJlYW0uDQoNClJlZ2Fy
ZHMsDQpMaWFuZ3hpbmcNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGlh
bmd4aW5nIFdhbmcNCj4gU2VudDogMjAyNuW5tDPmnIgyM+aXpSAxODowMQ0KPiBUbzogJ2Zlbmdj
aGVuZ3dlbicgPGZlbmdjaGVuZ3dlbkBodWF3ZWkuY29tPjsgdGhvbWFzQG1vbmphbG9uLm5ldA0K
PiBDYzogZGV2QGRwZGsub3JnDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjMgMC8yXSBFeHRlbmQg
TlVNQSBub2RlcyBsaW1pdA0KPiANCj4gSGkgVGhvbWFzLA0KPiANCj4gRnJpZW5kbHkgcGluZyBm
b3IgcmV2aWV3L3Vwc3RyZWFtLg0KPiANCj4gUmVnYXJkcywNCj4gTGlhbmd4aW5nDQo+IA0KPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogZmVuZ2NoZW5nd2VuIDxmZW5n
Y2hlbmd3ZW5AaHVhd2VpLmNvbT4NCj4gPiBTZW50OiAyMDI25bm0MuaciDI25pelIDEwOjExDQo+
ID4gVG86IExpYW5neGluZyBXYW5nIDx3YW5nbGlhbmd4aW5nQGh5Z29uLmNuPjsgdGhvbWFzQG1v
bmphbG9uLm5ldDsNCj4gPiBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZw0KPiA+IENjOiBkZXZA
ZHBkay5vcmcNCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvMl0gRXh0ZW5kIE5VTUEgbm9k
ZXMgbGltaXQNCj4gPg0KPiA+IFNlcmllcy1hY2tlZC1ieTogQ2hlbmd3ZW4gRmVuZyA8ZmVuZ2No
ZW5nd2VuQGh1YXdlaS5jb20+DQo+ID4NCj4gPiBPbiAyLzI1LzIwMjYgNDowNCBQTSwgTGlhbmd4
aW5nIFdhbmcgd3JvdGU6DQo+ID4gPiBUaGlzIHBhdGNoc2V0IHVzZSBSVEVfTUFYX05VTUFfTk9E
RVMgaW5zdGVhZCBvZiBoYXJkY29kZWQgdmFsdWVzDQo+IHRvDQo+ID4gPiBleHRlbmQgTlVNQSBu
b2RlcyBsaW1pdCBmb3Igc29tZSBleGFtcGxlcyBhbmQgdGVzdCBhcHAuIEFsc28gcmVtb3ZlDQo+
ID4gPiB1bnVzZWQgTkJfU09DS0VUUyBtYWNybyBmb3IgaXBfcmVhc3NlbWJseSBleGFtcGxlIGFu
ZCBncmFwaCBhcHAuDQo+ID4gPg0KPiA+ID4gTGlhbmd4aW5nIFdhbmcgKDIpOg0KPiA+ID4gICBl
eGFtcGxlczogZXh0ZW5kIE5VTUEgbm9kZXMgbGltaXQNCj4gPiA+ICAgYXBwOiBleHRlbmQgTlVN
QSBub2RlcyBsaW1pdA0KPiA+ID4NCj4gPiA+ICBhcHAvZ3JhcGgvZXRoZGV2X3J4X3ByaXYuaCAg
ICAgICAgIHwgMSAtDQo+ID4gPiAgYXBwL3Rlc3QvdGVzdF9wbWRfcGVyZi5jICAgICAgICAgICB8
IDIgKy0NCj4gPiA+ICBleGFtcGxlcy9pcF9yZWFzc2VtYmx5L21haW4uYyAgICAgIHwgMiAtLQ0K
PiA+ID4gIGV4YW1wbGVzL2lwc2VjLXNlY2d3L2lwc2VjLXNlY2d3LmggfCAyICstDQo+ID4gPiAg
ZXhhbXBsZXMvbDNmd2QtZ3JhcGgvbWFpbi5jICAgICAgICB8IDIgKy0NCj4gPiA+ICBleGFtcGxl
cy9sM2Z3ZC1wb3dlci9tYWluLmMgICAgICAgIHwgMiArLQ0KPiA+ID4gIGV4YW1wbGVzL2wzZndk
L2wzZndkLmggICAgICAgICAgICAgfCAyICstDQo+ID4gPiAgZXhhbXBsZXMvdmhvc3RfY3J5cHRv
L21haW4uYyAgICAgICB8IDIgKy0NCj4gPiA+ICA4IGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4NCg0K

