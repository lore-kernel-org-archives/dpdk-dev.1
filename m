Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BC6EB48FC
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 10:44:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F9A74027A;
	Thu, 12 Feb 2026 11:44:29 +0100 (CET)
Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
 by mails.dpdk.org (Postfix) with ESMTP id 1886240268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 11:44:26 +0100 (CET)
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
 by mailgw2.hygon.cn (Postfix) with ESMTP id 4fBX3p3vq8z1YHN35;
 Thu, 12 Feb 2026 18:44:22 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
 by mailgw2.hygon.cn (Postfix) with ESMTP id 4fBX3m0yr1z1YHN35;
 Thu, 12 Feb 2026 18:44:20 +0800 (CST)
Received: from cncheex05.Hygon.cn (unknown [172.23.18.115])
 by maildlp2.hygon.cn (Postfix) with ESMTPS id 0051A30A2C69;
 Thu, 12 Feb 2026 18:43:38 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex05.Hygon.cn
 (172.23.18.115) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 12 Feb
 2026 18:44:20 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Thu, 12 Feb 2026 18:44:20 +0800
From: Liangxing Wang <wangliangxing@hygon.cn>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 1/3] examples/l3fwd: extend NUMA nodes limit beyond 8
Thread-Topic: [PATCH v2 1/3] examples/l3fwd: extend NUMA nodes limit beyond 8
Thread-Index: AQHcgHCUC5q1bz9lpE6JM/w8ds+K5bVZRsQggAKmGACAH/xSkP//srcAgANp52A=
Date: Thu, 12 Feb 2026 10:44:20 +0000
Message-ID: <219006e5169f4a00a91c8327b15a09a1@hygon.cn>
References: <20260108072919.1279731-1-wangliangxing@hygon.cn>
 <15656361.tv2OnDr8pf@thomas> <5c38455874a1433aa34842391525e8a5@hygon.cn>
 <12551721.nUPlyArG6x@thomas>
In-Reply-To: <12551721.nUPlyArG6x@thomas>
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

PiBGcm9tOiBUaG9tYXMgTW9uamFsb24gPHRob21hc0Btb25qYWxvbi5uZXQ+DQo+IFNlbnQ6IDIw
MjblubQy5pyIMTDml6UgMjE6MzENCj4gDQo+IDEwLzAyLzIwMjYgMTE6MTUsIExpYW5neGluZyBX
YW5nOg0KPiA+IEhpIFRob21hcywNCj4gPg0KPiA+IFRoaXMgc2ltcGxlIHNlcmllcyBoYXMgYmVl
biB3aXRob3V0IGEgZGVsZWdhdGUgZm9yIGFib3V0IGEgbW9udGguIENvdWxkIHlvdQ0KPiBoZWxw
IGhhdmUgYSBsb29rPyBUaGFua3MuDQo+IA0KPiBUaGVyZSBhcmUgbW9yZSBpbnN0YW5jZXMgdG8g
Zml4IGluIGFwcC9ncmFwaCwgZXhhbXBsZXMvaXBfcmVhc3NlbWJseSBhbmQNCj4gZXhhbXBsZXMv
dmhvc3RfY3J5cHRvLg0KPiBDb3VsZCB5b3UgZml4IGFsbCBwbGVhc2U/DQo+IEkgdGhpbmsgeW91
IGNhbiBzcGxpdCBpbiAyIGNvbW1pdHM6IGV4YW1wbGVzIGFuZCBhcHAuDQo+IEluIHRoZSBjYXNl
IG9mIGFwcHMsIHBsZWFzZSBjaGVjayBpdCBpcyBub3QgaW5jcmVhc2luZyB0aGUgbWVtb3J5IHVz
YWdlIHRvbw0KPiBtdWNoLg0KPiBUaGFua3MNCj4gDQpPa2F5LCB3aWxsIGRvIHRoaXMuIE5CX1NP
Q0tFVFMgaW4gZXhhbXBsZXMvaXBfcmVhc3NlbWJseSBpcyBub3QgdXNlZC4gV2lsbCByZW1vdmUg
aXQuDQoNClJlZ2FyZHMsDQpMaWFuZ3hpbmcNCg0K

