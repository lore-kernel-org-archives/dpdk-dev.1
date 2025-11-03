Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974A8CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 18:06:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60ECC40285;
	Mon,  3 Nov 2025 19:06:08 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 61E2C40270
 for <dev@dpdk.org>; Mon,  3 Nov 2025 19:06:07 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4d0fYk6Ygtz6L4tn;
 Tue,  4 Nov 2025 02:02:18 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id 2F4801400E5;
 Tue,  4 Nov 2025 02:06:06 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 18:06:05 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 3 Nov 2025 18:06:05 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>, Ola Liljedahl
 <ola.liljedahl@arm.com>, "vattunuru@marvell.com" <vattunuru@marvell.com>
Subject: RE: [PATCH 1/1] eal: correct memory ordering in MCS lock
Thread-Topic: [PATCH 1/1] eal: correct memory ordering in MCS lock
Thread-Index: AQHcRE2WHhnnI3qNXUmQEzir4eowobThH/qAgAAgCICAAAZ5gIAACaJw
Date: Mon, 3 Nov 2025 18:06:05 +0000
Message-ID: <d63bc45cb32848299574333fed5e5406@huawei.com>
References: <20251023184724.1759497-1-wathsala.vithanage@arm.com>
 <f08a5a55-2a46-4f8c-9658-f7c320de57f2@arm.com>
 <20251103090717.2d181d95@phoenix>
 <b435dd1d-c56f-4d56-9f73-30ee1ec99eac@arm.com>
In-Reply-To: <b435dd1d-c56f-4d56-9f73-30ee1ec99eac@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
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

DQoNCj4gDQo+IE9uIDExLzMvMjUgMTE6MDcsIFN0ZXBoZW4gSGVtbWluZ2VyIHdyb3RlOg0KPiA+
IE9uIE1vbiwgMyBOb3YgMjAyNSAwOToxMjozOSAtMDYwMA0KPiA+IFdhdGhzYWxhIFZpdGhhbmFn
ZSA8d2F0aHNhbGEudml0aGFuYWdlQGFybS5jb20+IHdyb3RlOg0KPiA+DQo+ID4+IE1DUyBsb2Nr
IGlzIGJyb2tlbiwgaXQncyBqdXN0IGEgbWF0dGVyIG9mIHRpbWUgaXQgd2lsbCBydW4gaW50byBh
IGRlYWRsb2NrLg0KPiA+Pg0KPiA+PiBkcml2ZXJzL2RtYS9jbnhrIGlzIGEgdXNlciBvZiBNQ1Mg
bG9jay4NCj4gPiBJIGFtIHN1cnByaXNlZCB0aGF0IGEgZHJpdmVyIHdvdWxkIHVzZSBtY3Nsb2Nr
Lg0KPiA+IE1DU2xvY2sgaXMgdGFyZ2V0ZWQgYXQgY2FzZSBvZiBsYXJnZSBudW1iZXIgb2YgQ1BV
J3Mgd2l0aCBsb3RzIG9mIGNvbnRlbnRpb24uDQo+ID4gSXQgd2lsbCBsaWtlbHkgYmUgc2xvd2Vy
IHRoYW4gc3BpbmxvY2sgb3IgdGlja2V0bG9jayBmb3IgdGhlIHVzZSBjYXNlIG9mIGRyaXZlci4N
Cj4gSXQgYXBwZWFycyBpbiB8ZHJpdmVycy9kbWEvY254ay9jbnhrX2RtYWRldl9mcC5jfCwgcGVy
aGFwcyB0aGUNCj4gbWFpbnRhaW5lciBjYW4gY2xhcmlmeS4NCj4gDQoNCklmIE1DUyBsb2NrIGlz
IHJlYWxseSBicm9rZW4sIGl0IG5lZWRzIHRvIGJlIGZpeGVkIGFueXdheS4NCkl0IG1pZ2h0IGJl
IHVzZWQgYnkgb3RoZXIgdGhpcmQtcGFydHkgbGlicy9hcHBzIHRoYXQgZG8gdXNlIG9uIERQREsu
DQo=
