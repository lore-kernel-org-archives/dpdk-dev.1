Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD71C61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:50:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5CFA40374;
	Mon, 31 Aug 2026 10:50:21 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 114B5400D5
 for <dev@dpdk.org>; Mon, 31 Aug 2026 10:50:21 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=NbKg+uWV82qDoEoalZjK0f/iEKd69mYyTyKTPMghiYQ=;
 b=YSFDWv0kHXCOEEfn07k3P05hO8VqAqFgT46W+93c1NhHUco2qwPP6S2kdQAzoIuLX/Bun5vvU
 B+dT5E59gWpeSvYzj6svH77mh1pscSt+f1G+uBkIELMZxdAQyS8p/fX5WGzJni8catFm+uiC8/r
 5ABqZRhx4JeY/SBU7a8Ubx8=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hYN2z6JF4zHnH5P;
 Mon, 31 Aug 2026 16:49:31 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 4367A40569;
 Mon, 31 Aug 2026 16:50:15 +0800 (CST)
Received: from dubpemt500001.china.huawei.com (7.214.144.77) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 31 Aug 2026 09:50:14 +0100
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpemt500001.china.huawei.com (7.214.144.77) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 31 Aug 2026 09:50:14 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.2562.045; 
 Mon, 31 Aug 2026 09:50:14 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>
Subject: RE: [PATCH v3 1/2] stack: introduce pile
Thread-Topic: [PATCH v3 1/2] stack: introduce pile
Thread-Index: AQHdNivZlPLzR2W88UagmX4dOkumu7a33Nkw
Date: Mon, 31 Aug 2026 08:50:14 +0000
Message-ID: <ec4ba9b4d8f34eb78e86a5ccc2a01a89@huawei.com>
References: <20260812134756.1829613-1-mb@smartsharesystems.com>
 <20260827135556.522443-1-mb@smartsharesystems.com>
 <20260827135556.522443-2-mb@smartsharesystems.com>
In-Reply-To: <20260827135556.522443-2-mb@smartsharesystems.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.172.158]
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

DQoNCj4gQWRkZWQgYSBuZXcgaGlnaC1wZXJmb3JtYW5jZSBsb2NrLWZyZWUgInBpbGUiLCB1c2lu
ZyB0aGUgU3RhY2sgQVBJLg0KPiBUaGUgcGlsZSBiZWhhdmVzIHJvdWdobHkgbGlrZSBhIHN0YWNr
LCBidXQgaXMgbm90IHN0cmljdGx5IExJRk8uDQo+IA0KPiBUaGUgcGlsZSBpcyBvcHRpbWl6ZWQg
Zm9yIHB1c2hpbmcvcG9wcGluZyBidWxrcyBvZiBvYmplY3RzLCB3aGljaA0KPiBpdCBkb2VzIHNp
Z25pZmljYW50bHkgZmFzdGVyIHRoYW4gdGhlIGxvY2stZnJlZSBzdGFjay4NCj4gDQo+IFB1c2hp
bmcvcG9wcGluZyBhIG51bWJlciBvZiBvYmplY3RzIG5vdCBkaXZpc2libGUgYnkgdGhlIGNvbXBp
bGUgdGltZQ0KPiBjb25maWd1cmFibGUgYnVsayBzaXplIGlzIGhhbmRsZWQgZ3JhY2VmdWxseSwg
YnV0IG5vdCBhcyBmYXN0IGFzDQo+IGNvbXBsZXRlIGJ1bGtzLg0KPiANCj4gUGVyZm9ybWFuY2Ug
ZXhhbXBsZXMsIHN0YWNrX3BpbGVfcGVyZl9hdXRvdGVzdCB2cy4gc3RhY2tfbGZfYXV0b3Rlc3Q6
DQo+IA0KPiBPbiBhIHNpbmdsZSBjb3JlLCBwdXNoaW5nL3BvcHBpbmcgMSBvciA4IG9iamVjdHMg
aXMgc2ltaWxhciBzcGVlZC4NCj4gT24gYSBzaW5nbGUgY29yZSwgcHVzaGluZy9wb3BwaW5nIDMy
IG9iamVjdHMgaXMgMnggZmFzdGVyLg0KPiBPbiBhIHNpbmdsZSBjb3JlLCBwdXNoaW5nL3BvcHBp
bmcgNTEyIG9iamVjdHMgaXMgMTB4IGZhc3Rlci4NCj4gDQo+IE9uIGZvdXIgY29yZXMsIHB1c2hp
bmcvcG9wcGluZyAxLCA4IG9yIDMyIG9iamVjdHMgaXMgc2xpZ2h0bHkgZmFzdGVyLg0KPiBPbiBm
b3VyIGNvcmVzLCBwdXNoaW5nL3BvcHBpbmcgNTEyIG9iamVjdHMgaXMgNHggZmFzdGVyLg0KDQpB
Y2tlZC1ieTogS29uc3RhbnRpbiBBbmFueWV2IDxrb25zdGFudGluLmFuYW55ZXZAaHVhd2VpLmNv
bT4NCg0KVGhlIGNvZGUgaXRzZWxmIGxvb2tzIG9rIHRvIG1lLCB0aG91Z2h0IEkgc3RpbGwgdGhp
bmsgaXQgaXMgd29ydGggdG8gY29uc2lkZXINCm1vdmluZyBsZl9waWxlIChhbmQgbGZfc3RhY2sp
IERQIGltcGxlbWVudGF0aW9uIGluIC5jLCB0byBhdm9pZCBlYWNoIHJ0ZV9zdGFja19wdXMvcG9w
DQp0byBpbmxpbmUgYWxsIHRocmVlIG9mIHRoZW0uDQpNeSBzcGVjdWxhdGlvbiBpcyB0aGF0IHRo
ZSBwZXJmIGRpZmYgZm9yIGJ1bGsgZW5xdWV1ZS9kZXF1ZXVlIGJlY2F1c2Ugb2YNCnRoYXQgd291
bGQgYmUgbmVnbGlnaWJsZSwgd2hpbGUgYm90aCBhcmUgcXVpdGUgYmlnIGZvciBpbmxpbmluZyB0
aGVtIGFsd2F5cw0KKHNwZWNpYWxseSBsZl9waWxlKS4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBNb3J0
ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KPiAtLS0NCg==
