Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B163FEC01B6
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 10:00:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4B2340268;
	Mon, 23 Mar 2026 11:00:41 +0100 (CET)
Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
 by mails.dpdk.org (Postfix) with ESMTP id 1C3B64025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 11:00:39 +0100 (CET)
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4ffTFK56ZBzrbrJ;
 Mon, 23 Mar 2026 18:00:37 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4ffTFJ65gnzrbrJ;
 Mon, 23 Mar 2026 18:00:36 +0800 (CST)
Received: from cncheex06.Hygon.cn (unknown [172.23.18.116])
 by maildlp1.hygon.cn (Postfix) with ESMTPS id EF8BF5959;
 Mon, 23 Mar 2026 18:00:32 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex06.Hygon.cn
 (172.23.18.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 23 Mar
 2026 18:00:36 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Mon, 23 Mar 2026 18:00:36 +0800
From: Liangxing Wang <wangliangxing@hygon.cn>
To: fengchengwen <fengchengwen@huawei.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v3 0/2] Extend NUMA nodes limit
Thread-Topic: [PATCH v3 0/2] Extend NUMA nodes limit
Thread-Index: AQHcpi2EBfMTEG03Y0KYWGG/jeVVW7WTt9gAgChS8rA=
Date: Mon, 23 Mar 2026 10:00:35 +0000
Message-ID: <969e9f14c78447e9af12df1415339cb7@hygon.cn>
References: <20260225080419.727470-1-wangliangxing@hygon.cn>
 <ac35b365-8efe-4930-99ee-1d68a92cc972@huawei.com>
In-Reply-To: <ac35b365-8efe-4930-99ee-1d68a92cc972@huawei.com>
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

SGkgVGhvbWFzLA0KDQpGcmllbmRseSBwaW5nIGZvciByZXZpZXcvdXBzdHJlYW0uIA0KDQpSZWdh
cmRzLA0KTGlhbmd4aW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
ZmVuZ2NoZW5nd2VuIDxmZW5nY2hlbmd3ZW5AaHVhd2VpLmNvbT4NCj4gU2VudDogMjAyNuW5tDLm
nIgyNuaXpSAxMDoxMQ0KPiBUbzogTGlhbmd4aW5nIFdhbmcgPHdhbmdsaWFuZ3hpbmdAaHlnb24u
Y24+OyB0aG9tYXNAbW9uamFsb24ubmV0Ow0KPiBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZw0K
PiBDYzogZGV2QGRwZGsub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC8yXSBFeHRlbmQg
TlVNQSBub2RlcyBsaW1pdA0KPiANCj4gU2VyaWVzLWFja2VkLWJ5OiBDaGVuZ3dlbiBGZW5nIDxm
ZW5nY2hlbmd3ZW5AaHVhd2VpLmNvbT4NCj4gDQo+IE9uIDIvMjUvMjAyNiA0OjA0IFBNLCBMaWFu
Z3hpbmcgV2FuZyB3cm90ZToNCj4gPiBUaGlzIHBhdGNoc2V0IHVzZSBSVEVfTUFYX05VTUFfTk9E
RVMgaW5zdGVhZCBvZiBoYXJkY29kZWQgdmFsdWVzIHRvDQo+ID4gZXh0ZW5kIE5VTUEgbm9kZXMg
bGltaXQgZm9yIHNvbWUgZXhhbXBsZXMgYW5kIHRlc3QgYXBwLiBBbHNvIHJlbW92ZQ0KPiA+IHVu
dXNlZCBOQl9TT0NLRVRTIG1hY3JvIGZvciBpcF9yZWFzc2VtYmx5IGV4YW1wbGUgYW5kIGdyYXBo
IGFwcC4NCj4gPg0KPiA+IExpYW5neGluZyBXYW5nICgyKToNCj4gPiAgIGV4YW1wbGVzOiBleHRl
bmQgTlVNQSBub2RlcyBsaW1pdA0KPiA+ICAgYXBwOiBleHRlbmQgTlVNQSBub2RlcyBsaW1pdA0K
PiA+DQo+ID4gIGFwcC9ncmFwaC9ldGhkZXZfcnhfcHJpdi5oICAgICAgICAgfCAxIC0NCj4gPiAg
YXBwL3Rlc3QvdGVzdF9wbWRfcGVyZi5jICAgICAgICAgICB8IDIgKy0NCj4gPiAgZXhhbXBsZXMv
aXBfcmVhc3NlbWJseS9tYWluLmMgICAgICB8IDIgLS0NCj4gPiAgZXhhbXBsZXMvaXBzZWMtc2Vj
Z3cvaXBzZWMtc2VjZ3cuaCB8IDIgKy0NCj4gPiAgZXhhbXBsZXMvbDNmd2QtZ3JhcGgvbWFpbi5j
ICAgICAgICB8IDIgKy0NCj4gPiAgZXhhbXBsZXMvbDNmd2QtcG93ZXIvbWFpbi5jICAgICAgICB8
IDIgKy0NCj4gPiAgZXhhbXBsZXMvbDNmd2QvbDNmd2QuaCAgICAgICAgICAgICB8IDIgKy0NCj4g
PiAgZXhhbXBsZXMvdmhvc3RfY3J5cHRvL21haW4uYyAgICAgICB8IDIgKy0NCj4gPiAgOCBmaWxl
cyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4NCj4gDQoNCg==

