Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6473CD767FF
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 13:13:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 128B6402E9;
	Fri, 19 Dec 2025 14:13:32 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 7E82440150;
 Fri, 19 Dec 2025 14:13:30 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXnyd0B2MzJ46Bv;
 Fri, 19 Dec 2025 21:12:57 +0800 (CST)
Received: from dubpeml100003.china.huawei.com (unknown [7.214.147.98])
 by mail.maildlp.com (Postfix) with ESMTPS id A5E2B40539;
 Fri, 19 Dec 2025 21:13:29 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100003.china.huawei.com (7.214.147.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 19 Dec 2025 13:13:29 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Fri, 19 Dec 2025 13:13:29 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "jerinjacobk@gmail.com"
 <jerinjacobk@gmail.com>, "mb@smartsharesystems.com"
 <mb@smartsharesystems.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v3 2/6] bpf: fix signed shift overflows in ARM JIT
Thread-Topic: [PATCH v3 2/6] bpf: fix signed shift overflows in ARM JIT
Thread-Index: AQHcb39oaXN2p+kuN06nAGJHbmqCHbUo80Zg
Date: Fri, 19 Dec 2025 13:13:29 +0000
Message-ID: <ce03cd32a7a04eb7b06524d978047265@huawei.com>
References: <20251216182036.77869-1-marat.khalili@huawei.com>
 <20251217180141.60227-1-marat.khalili@huawei.com>
 <20251217180141.60227-3-marat.khalili@huawei.com>
In-Reply-To: <20251217180141.60227-3-marat.khalili@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.245.175]
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

DQoNCj4gDQo+IExlZnQgc2hpZnRzIG9mIGludGVnZXIgbGl0ZXJhbHMgYW5kIGJvb2wgdmFsdWVz
IG92ZXJ3cml0aW5nIHRoZSBzaWduIGJpdA0KPiB3ZXJlIHVzZWQgbXVsdGlwbGUgdGltZXMgaW4g
YnBmX2ppdF9hcm02NC5jLiBFLmcuOg0KPiANCj4gICAgIGluc24gPSAoISFpczY0KSA8PCAzMTsN
Cj4gDQo+IHdoZXJlIGlzNjQgaGFzIHR5cGUgYm9vbCAoZG91YmxlIGJhbmcgaXMgYSBuby1vcCBo
ZXJlKS4gVGhlIG9wZXJhbmQgb2YNCj4gbGVmdCBzaGlmdCB3YXMgcHJvbW90ZWQgdG8gdHlwZSBp
bnQsIHdoaWNoIHdoZW4gMzItYml0IHdpZGUgY2Fubm90DQo+IHJlcHJlc2VudCB0aGUgcmVzdWx0
LiBTaW1pbGFybHkgbGl0ZXJhbCBpbnRlZ2VycyBoYXZlIGludCB0eXBlIGJ5DQo+IGRlZmF1bHQu
ICBTYW5pdGl6ZXIgcHJvZHVjZWQgdGhlIGZvbGxvd2luZyBkaWFnbm9zdGljIGR1cmluZyBydW50
aW1lDQo+IChmb3IgdmFyaW91cyBsaW5lcyk6DQo+IA0KPiAgICAgbGliL2JwZi9icGZfaml0X2Fy
bTY0LmM6MjQxOjE4OiBydW50aW1lIGVycm9yOiBsZWZ0IHNoaWZ0IG9mIDEgYnkgMzENCj4gICAg
IHBsYWNlcyBjYW5ub3QgYmUgcmVwcmVzZW50ZWQgaW4gdHlwZSAnaW50Jw0KPiANCj4gVG8gZml4
IHRoZSBpc3N1ZSB1c2UgUlRFX0JJVDMyIGFuZCBzaW1pbGFyIG1hY3JvcyBpbnN0ZWFkLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogTWFyYXQgS2hhbGlsaSA8bWFyYXQua2hhbGlsaUBodWF3ZWkuY29t
Pg0KPiBBY2tlZC1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4N
Cj4gLS0tDQoNCkFja2VkLWJ5OiBLb25zdGFudGluIEFuYW55ZXYgPGtvbnN0YW50aW4uYW5hbnll
dkBodWF3ZWkuY29tPiANCg0KPiAtLQ0KPiAyLjQzLjANCg0K
