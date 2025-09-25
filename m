Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4A1CAC5AA
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 07:11:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6CA8402AB;
	Thu, 25 Sep 2025 09:11:11 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 715454028F
 for <dev@dpdk.org>; Thu, 25 Sep 2025 09:11:10 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cXPtw35txz6M4JZ;
 Thu, 25 Sep 2025 15:08:08 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 449941402FB;
 Thu, 25 Sep 2025 15:11:08 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Sep 2025 08:11:07 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 25 Sep 2025 08:11:07 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, Ola Liljedahl
 <Ola.Liljedahl@arm.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>, 
 Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Dhruv Tripathi <Dhruv.Tripathi@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: RE: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Topic: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Index: AQHcJnJlB2Gj2xn6O0SOJRCJl7cS/rSWYP5wgABfdICAADf1oP///ZsAgATllsCABXDfAIAApMtQgAARVpCAAACagIAAJIKggAAHFQCAABO1wIAADi0AgAAmfOCAANzOcIAAMtaQ
Date: Thu, 25 Sep 2025 07:11:07 +0000
Message-ID: <48e8cd3f68a440d7a83092903d710307@huawei.com>
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
 <2421eba5de7c4586a7b80dda29078eb2@huawei.com>
 <9B712773-4A39-4D09-9313-1623EE30F209@arm.com>
 <73287d6c09d049aa994a1d17962130b9@huawei.com>
 <BD3A1BB1-B778-46DE-94BA-6E27DA4B0B08@arm.com>
 <4cec8b9ca5114f90b8ce1047abdaa936@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65465@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65465@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.245.113]
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

DQoNCj4gSSBoYXZlIGJlZW4gZm9sbG93aW5nIHRoaXMgaW50ZXJlc3RpbmcgZGlzY3Vzc2lvbiwg
YW5kIHdhbnQgdG8gY2xhcmlmeToNCj4gDQo+IEZvciBhIGdlbmVyaWMgcmluZywgZW5xdWV1ZSBj
YW4gZmFpbCBpZiB0aGUgcmluZyBkb2Vzbid0IGhhdmUgc3VmZmljaWVudCBmcmVlIHNwYWNlLCBh
bmQNCj4gZGVxdWV1ZSBjYW4gZmFpbCBpZiBpdCBkb2Vzbid0IGhhdmUgc3VmZmljaWVudCBvYmpl
Y3RzIGluIHF1ZXVlLg0KPiANCj4gSG93ZXZlciwgd2hlbiBhIHJpbmcgaXMgdXNlZCBhcyB0aGUg
YmFja2luZyBzdG9yZSBmb3IgYSBtZW1wb29sLCBlbnF1ZXVlIGNhbg0KPiBuZXZlciBmYWlsLiAo
RGVxdWV1ZSBjYW4gc3RpbGwgZmFpbCBpZiB0aGUgbWVtcG9vbCBoYXMgYmVlbiBkZXBsZXRlZC4p
DQo+IA0KPiBUaGUgcmVhc29uIGVucXVldWUgaW50byBhIG1lbXBvb2wgcmluZyBjYW4gbmV2ZXIg
ZmFpbCBpczoNCj4gT24gY3JlYXRpb24gb2YgdGhlIG1lbXBvb2wgcmluZywgdGhlIG9iamVjdHMg
aGVsZCBieSB0aGUgbWVtcG9vbCAoZS5nLiBtYnVmcykgYXJlDQo+IGFsbG9jYXRlZCBpbiBtZW1v
cnkgYW5kIGVucXVldWVkIGludG8gdGhlIHJpbmcuIElmIHRoZSBtZW1wb29sIHJpbmcgaGFzIHNp
emUgU0laRSwNCj4gdGhlbiBTSVpFIG9iamVjdHMgYXJlIGFsbG9jYXRlZCBpbiBtZW1vcnkgYW5k
IGVucXVldWVkIGludG8gdGhlIG1lbXBvb2wgcmluZy4NCj4gU28sIHNpbmNlIG9ubHkgU0laRSBv
YmplY3RzIGV4aXN0IGluIHRoZSB3aG9sZSB3b3JsZCwgYW5kIHRoZSBtZW1wb29sIHJpbmcgaGFz
IHNpemUNCj4gU0laRSwgZW5xdWV1ZSBvZiB0aG9zZSBvYmplY3RzIGludG8gdGhlIG1lbXBvb2wg
cmluZyBjYW5ub3QgZmFpbCwgYW5kIHRoZSBtZW1wb29sDQo+ICJwdXQiIEFQSSByZWZsZWN0cyB0
aGlzLg0KPiANCj4gTm90ZSB0aGF0IHRoaXMgaXMgYSByZXF1aXJlbWVudCBmb3IgdGhlIG1lbXBv
b2wgQVBJLCBub3QgdGhlIHJpbmcgQVBJLg0KPiBTbywgaWYgdGhlIHJpbmcgQVBJIGRvZXNuJ3Qg
cHJvdmlkZSB0aGlzIGd1YXJhbnRlZSAodGhhdCBpZiBvbmx5IFNJWkUgb2JqZWN0cyBleGlzdCwN
Cj4gZW5xdWV1ZSBjYW5ub3QgZmFpbCksIHRoZW4gdGhpcyBndWFyYW50ZWUgY291bGQgYmUgaW1w
bGVtZW50ZWQgaW4gdGhlIG1lbXBvb2wNCj4gbGlicmFyeSB3aGVyZSBpdCBpbnRlcmZhY2VzIHRv
IHRoZSByaW5nICJlbnF1ZXVlIiBBUEkgKGluc3RlYWQgb2YgaGF2aW5nIHRoZSByaW5nIEFQSQ0K
PiBwcm92aWRlIHRoaXMgZ3VhcmFudGVlKS4NCj4gDQo+IEhvd2V2ZXIsIG90aGVyIGxpYnJhcmll
cyBvciBhcHBsaWNhdGlvbnMgbWlnaHQgYXNzdW1lIHRoZSBzYW1lIGd1YXJhbnRlZSBmb3IgYSBy
aW5nDQo+IHdoZW4gbm8gbW9yZSB0aGFuIFNJWkUgb2JqZWN0cyBleGlzdC4gKEkgZG9uJ3Qga25v
dyEpIElmIHRoaXMgaXMgdGhlIGNhc2UsIHRoZW4gaXQgaXMgYQ0KPiByaW5nIEFQSSByZXF1aXJl
bWVudCwgbm90IGp1c3QgYSBtZW1wb29sIEFQSSByZXF1aXJlbWVudC4NCg0KWWVwLCB0aGVyZSBj
b3VsZCBiZSBvdGhlciBsaWJzIChib3RoIERQREsgYW5kIHRoaXJkLXBhcnR5KSB0aGF0IHJlbHkg
b24gdGhhdC4NClRoYXQncyB3aHkgSSB0aGluayB3ZSBuZWVkIHRvIHByZXNlcnZlIGV4aXN0aW5n
IGJlaGF2aW9yIG9mIHRoZSBwdWJsaWMgcmluZyBBUEkuICANClByb3ZpZGluZyBzb21lIGV4dHJh
IChmYXN0KSB2ZXJzaW9uIG9mIEFQSSBpcyBwb3NzaWJsZSwgdGhvdWdoIEkgYW0gbm90IGJpZyBm
YW4NCm9mIHRoYXQgaWRlYTogaXQgd2lsbCBjb21wbGljYXRlIGFuZCBpbmNyZWFzZSBleGlzdGlu
ZyBjb2RlIHF1aXRlIGEgYml0LCB3aGlsZQ0KSSBkb24ndCB0aGluayB0aGUgZ2FpbiB3b3VsZCBi
ZSB0aGF0IGh1Z2UuDQpCdXQgYWdhaW4gLSBJIHRoaW5rIHRoYXQgbmV3IEFQSSBzaGFsbCBiZSBz
dWJqZWN0IG9mIGEgc2VwYXJhdGUgcGF0Y2gtc2V0IGFuZCBkaXNjdXNzaW9uLg0KQXMgZmlyc3Qg
dGhpbmcgd2UgZG8gbmVlZCBhIGZpeCBvciBleGlzdGluZyBvbmUuDQpUaGFuayB5b3UgZm9yIGdy
ZWF0IHN1bW1hcnkuICANCktvbnN0YW50aW4NCg0KPiBPbmUgcG9zc2libGUgc29sdXRpb24gdG8g
dGhpcyBjb3VsZCBiZSBvZmZlcmluZyB0d28gcmluZyBlbnF1ZXVlIEFQSXMsIGEgImZhc3QiIEFQ
SQ0KPiB3aXRob3V0IHRoZSBndWFyYW50ZWUgYW5kIGEgInNhZmUiIEFQSSB3aXRoIHRoZSBndWFy
YW50ZWUuDQo+IFNvbWV3aGF0IGxpa2UgdGhlIGl0ZXJhdGlvbiBtYWNyb3MgZm9yIGxpbmtlZCBs
aXN0czogZm9yZWFjaCgpIGFuZCBmb3JlYWNoX3NhZmUoKS4NCg0K
