Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1C3C44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 10:50:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30016400EF;
	Wed, 21 Jan 2026 11:50:21 +0100 (CET)
Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
 by mails.dpdk.org (Postfix) with ESMTP id 16E5C400D7
 for <dev@dpdk.org>; Wed, 21 Jan 2026 11:50:18 +0100 (CET)
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
 by mailgw2.hygon.cn (Postfix) with ESMTP id 4dx1Df22qSz1Yghmm;
 Wed, 21 Jan 2026 18:50:10 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
 by mailgw2.hygon.cn (Postfix) with ESMTP id 4dx1Df0Hlcz1Yghmm;
 Wed, 21 Jan 2026 18:50:10 +0800 (CST)
Received: from cncheex03.Hygon.cn (unknown [172.23.18.113])
 by maildlp1.hygon.cn (Postfix) with ESMTPS id C1B964B40;
 Wed, 21 Jan 2026 18:50:04 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex03.Hygon.cn
 (172.23.18.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 21 Jan
 2026 18:50:10 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Wed, 21 Jan 2026 18:50:10 +0800
From: Liangxing Wang <wangliangxing@hygon.cn>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v2 1/3] examples/l3fwd: extend NUMA nodes limit beyond 8
Thread-Topic: [PATCH v2 1/3] examples/l3fwd: extend NUMA nodes limit beyond 8
Thread-Index: AQHcgHCUC5q1bz9lpE6JM/w8ds+K5bVZRsQggAKmGACAAJXrgA==
Date: Wed, 21 Jan 2026 10:50:10 +0000
Message-ID: <7a474605687e4dcc95f11f91764ff289@hygon.cn>
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

PiAxOS8wMS8yMDI2IDEwOjE5LCBMaWFuZ3hpbmcgV2FuZzoNCj4gPiBIaSwNCj4gPg0KPiA+IE5v
dCBzdXJlIGZvciB3aGF0IHJlYXNvbiwgdGhlcmUgd2Fzbid0IGFueSB0ZXN0IGNoZWNrIHRyaWdn
ZXJlZCBieSB0aGlzIHBhdGNoLg0KPiBEbyBJIGhhdmUgdG8gc3VibWl0IGEgbmV3IHBhdGNoIHZl
cnNpb24gdG8gdHJpZ2dlciB0aGUgdGVzdHM/IFRoYW5rcy4NCj4gDQo+IFRoZSB3aG9sZSBzZXJp
ZXMgZ290IHRlc3RlZCBhbmQgcmVwb3J0ZWQgb24gdGhlIGxhc3QgcGF0Y2g6DQo+IGh0dHBzOi8v
cGF0Y2hlcy5kcGRrLm9yZy9wcm9qZWN0L2RwZGsvcGF0Y2gvMjAyNjAxMDgwNzMxMzUuMTI3OTgx
NC0xLXcNCj4gYW5nbGlhbmd4aW5nQGh5Z29uLmNuLw0KPiANCj4gDQpUaGFua3MgZm9yIHRoZSBp
bmZvLCBUaG9tYXMuIA0KDQpMaWFuZ3hpbmcNCg==

