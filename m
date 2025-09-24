Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC85DCAC5B0
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 10:08:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D627E4065E;
	Wed, 24 Sep 2025 12:08:30 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 74C444027C
 for <dev@dpdk.org>; Wed, 24 Sep 2025 12:08:29 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cWsvH4wzHz6L587;
 Wed, 24 Sep 2025 18:06:35 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id AD7161402FF;
 Wed, 24 Sep 2025 18:08:28 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 24 Sep 2025 11:08:28 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 24 Sep 2025 11:08:28 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Ola Liljedahl <Ola.Liljedahl@arm.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Honnappa Nagarahalli
 <Honnappa.Nagarahalli@arm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Dhruv Tripathi <Dhruv.Tripathi@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: RE: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Topic: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Index: AQHcJnJlB2Gj2xn6O0SOJRCJl7cS/rSWYP5wgABfdICAADf1oP///ZsAgATllsCABXDfAIAApMtQgAARVpCAAACagIAAJIKg
Date: Wed, 24 Sep 2025 10:08:28 +0000
Message-ID: <2421eba5de7c4586a7b80dda29078eb2@huawei.com>
References: <20250915185451.533039-1-wathsala.vithanage@arm.com>
 <20250915185451.533039-2-wathsala.vithanage@arm.com>
 <a5fae8a9edc947fdbaf4e2519c39f93e@huawei.com>
 <2a611c3cf926d752a54b7655c27d6df874a2d0de.camel@arm.com>
 <61a9d5b157be4816aa296194f9c0eabe@huawei.com>
 <4173E44D-BB31-45B9-AF6A-553B1E755604@arm.com>
 <64a7def62ee642139c3af31ce4fd94e9@huawei.com>
 <EF1C5BFC-B9C7-4D38-8FDC-FF412DD45C21@arm.com>
 <8eab3da6eb2944a4a4a197aeb38ee2f1@huawei.com>
 <d485010b97654d09a1921b97879faf90@huawei.com>
 <71C73931-11EA-4B4C-8FFF-F82A2B2F7520@arm.com>
In-Reply-To: <71C73931-11EA-4B4C-8FFF-F82A2B2F7520@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.173.27]
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

DQoNCj4gPiA+IFN1cmUsIEkgYW0gdGFsa2luZyBhYm91dCBNVCBzY2VuYXJpby4NCj4gPiA+IEkg
dGhpbmsgSSBhbHJlYWR5IHByb3ZpZGVkIGFuIGV4YW1wbGU6IERQREsgbWVtcG9vbCBsaWJyYXJ5
IChzZWUgYmVsb3cpLg0KPiA+ID4gSW4gYnJpZWYsIEl0IHdvcmtzIGxpa2UgdGhhdDoNCj4gPiA+
IEF0IGluaXQgaXQgYWxsb2NhdGVzIHJpbmcgb2YgTiBtZW1vcnkgYnVmZmVycyBhbmQgcmluZyBi
aWcgZW5vdWdoIHRvIGhvbGQgYWxsIG9mDQo+IHRoZW0uDQo+ID4NCj4gPiBTb3JyeSwgSSBtZWFu
dCB0byBzYXk6ICJpdCBhbGxvY2F0ZXMgTiBtZW1vcnkgYnVmZmVycyBhbmQgcmluZyBiaWcgZW5v
dWdoIHRvIGhvbGQNCj4gYWxsIG9mIHRoZW0iLg0KPiA+DQo+ID4gPiBUaGVuIGl0IGVucXVldWVz
IGFsbCBhbGxvY2F0ZWQgbWVtb3J5IGJ1ZmZlcnMgaW50byB0aGUgcmluZy4NCj4gPiA+IG1lbXBv
b2xfZ2V0IC0gcmV0cmlldmVzIChkZXF1ZXVlcykgYnVmZmVycyBmcm9tIHRoZSByaW5nLg0KPiA+
ID4gbWVtcG9vbF9wdXQgLSBwdXRzIHRoZW0gYmFjayAoZW5xdWV1ZXMpIHRvIHRoZSByaW5nDQo+
ID4gPiBnZXQoKSBtaWdodCBmYWlsIChFTk9NRU0pLCB3aGlsZSBwdXQgaXMgZXhwZWN0ZWQgdG8g
YWx3YXlzIHN1Y2NlZWQuDQo+IEJ1dCBob3cgZG9lcyB0aGUgdGhyZWFkIHdoaWNoIGNhbGxzIG1l
bXBvb2xfcHV0KCkgZ2V0IGhvbGQgb2YgdGhlIG1lbW9yeSBidWZmZXJzDQo+IHRoYXQNCj4gd2Vy
ZSBvYnRhaW5lZCB1c2luZyBtZW1wb29sX2dldCgpIGJ5IHNvbWUgb3RoZXIgdGhyZWFkPyBPciB0
aGlzIGlzIG5vdCB0aGUNCj4gc2NlbmFyaW8geW91DQo+IGFyZSB3b3JyeWluZyBhYm91dD8NCj4g
SXMgaXQgcmF0aGVyIHRoYXQgbXVsdGlwbGUgdGhyZWFkcyBpbmRlcGVuZGVudGx5IGNhbGwgbWVt
cG9vbF9nZXQoKSBhbmQgdGhlbg0KPiBtZW1wb29sX3B1dCgpDQo+IG9uIHRoZWlyIG93biBidWZm
ZXJzPyBBbmQgeW91IGFyZSB3b3JyaWVkIHRoYXQgYSB0aHJlYWQgd2lsbCBmYWlsIHRvIHJldHVy
bg0KPiAobWVtcG9vbF9wdXQpIGENCj4gYnVmZmVyIHRoYXQgaXQgZWFybGllciBhbGxvY2F0ZWQg
KG1lbXBvb2xfZ2V0KT8gV2UgY291bGQgY3JlYXRlIGEgbGl0bXVzIHRlc3QgZm9yDQo+IHRoYXQu
DQoNCkJvdGggc2NlbmFyaW9zIGFyZSBwb3NzaWJsZS4NCkZvciBSdW4tVG8tQ29tcGxldGlvbiBt
b2RlbCBlYWNoIHRocmVhZCB1c3VhbGx5IGRvZXM6IGFsbG9jYXRlL3VzZS9mcmVlIGdyb3VwIG9m
IG1idWZzLg0KRm9yIHBpcGxlbGluZSBtb2RlbCBvbmUgdGhyZWFkIGNhbiBhbGxvY2F0ZSBidW5j
aCBvZiBtYnVmcywgdGhlbiBwYXNzIHRoZW0gdG8gb3RoZXIgDQp0aHJlYWQgKHZpYSBhbm90aGVy
IHJpbmcgZm9yIGV4YW1wbGUpIGZvciBmdXJ0aGVyIHByb2Nlc3NpbmcgYW5kIHRoZW4gcmVsZWFz
aW5nLg0KDQoNCg==
