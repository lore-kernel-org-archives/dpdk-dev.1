Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB034EA3F35
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 10:15:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96717400D7;
	Tue, 10 Feb 2026 11:15:32 +0100 (CET)
Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
 by mails.dpdk.org (Postfix) with ESMTP id 33945400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 11:15:30 +0100 (CET)
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
 by mailgw2.hygon.cn (Postfix) with ESMTP id 4f9HWG2rnhz1YHN2Z;
 Tue, 10 Feb 2026 18:15:22 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
 by mailgw2.hygon.cn (Postfix) with ESMTP id 4f9HWD4dVYz1YHN2Z;
 Tue, 10 Feb 2026 18:15:20 +0800 (CST)
Received: from cncheex03.Hygon.cn (unknown [172.23.18.113])
 by maildlp2.hygon.cn (Postfix) with ESMTPS id 18CBD30195CE;
 Tue, 10 Feb 2026 18:14:42 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex03.Hygon.cn
 (172.23.18.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 10 Feb
 2026 18:15:21 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Tue, 10 Feb 2026 18:15:21 +0800
From: Liangxing Wang <wangliangxing@hygon.cn>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v2 1/3] examples/l3fwd: extend NUMA nodes limit beyond 8
Thread-Topic: [PATCH v2 1/3] examples/l3fwd: extend NUMA nodes limit beyond 8
Thread-Index: AQHcgHCUC5q1bz9lpE6JM/w8ds+K5bVZRsQggAKmGACAH/xSkA==
Date: Tue, 10 Feb 2026 10:15:21 +0000
Message-ID: <5c38455874a1433aa34842391525e8a5@hygon.cn>
References: <20260108072919.1279731-1-wangliangxing@hygon.cn>
 <c0fde19abc9e4b44b2d21a9cf22553e8@hygon.cn> <15656361.tv2OnDr8pf@thomas>
In-Reply-To: <15656361.tv2OnDr8pf@thomas>
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

SGkgVGhvbWFzLA0KDQpUaGlzIHNpbXBsZSBzZXJpZXMgaGFzIGJlZW4gd2l0aG91dCBhIGRlbGVn
YXRlIGZvciBhYm91dCBhIG1vbnRoLiBDb3VsZCB5b3UgaGVscCBoYXZlIGEgbG9vaz8gVGhhbmtz
Lg0KDQpSZWdhcmRzLA0KTGlhbmd4aW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogVGhvbWFzIE1vbmphbG9uIDx0aG9tYXNAbW9uamFsb24ubmV0Pg0KPiBTZW50OiAy
MDI25bm0MeaciDIx5pelIDE3OjQwDQo+IFRvOiBMaWFuZ3hpbmcgV2FuZyA8d2FuZ2xpYW5neGlu
Z0BoeWdvbi5jbj4NCj4gQ2M6IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnOyBmZW5nY2hlbmd3
ZW5AaHVhd2VpLmNvbTsNCj4gZGV2QGRwZGsub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIg
MS8zXSBleGFtcGxlcy9sM2Z3ZDogZXh0ZW5kIE5VTUEgbm9kZXMgbGltaXQNCj4gYmV5b25kIDgN
Cj4gDQo+IDE5LzAxLzIwMjYgMTA6MTksIExpYW5neGluZyBXYW5nOg0KPiA+IEhpLA0KPiA+DQo+
ID4gTm90IHN1cmUgZm9yIHdoYXQgcmVhc29uLCB0aGVyZSB3YXNuJ3QgYW55IHRlc3QgY2hlY2sg
dHJpZ2dlcmVkIGJ5IHRoaXMgcGF0Y2guDQo+IERvIEkgaGF2ZSB0byBzdWJtaXQgYSBuZXcgcGF0
Y2ggdmVyc2lvbiB0byB0cmlnZ2VyIHRoZSB0ZXN0cz8gVGhhbmtzLg0KPiANCj4gVGhlIHdob2xl
IHNlcmllcyBnb3QgdGVzdGVkIGFuZCByZXBvcnRlZCBvbiB0aGUgbGFzdCBwYXRjaDoNCj4gaHR0
cHM6Ly9wYXRjaGVzLmRwZGsub3JnL3Byb2plY3QvZHBkay9wYXRjaC8yMDI2MDEwODA3MzEzNS4x
Mjc5ODE0LTEtdw0KPiBhbmdsaWFuZ3hpbmdAaHlnb24uY24vDQo+IA0KPiANCg0K

