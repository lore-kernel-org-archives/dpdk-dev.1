Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15020CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 11:50:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 414CD40611;
	Wed, 24 Sep 2025 13:50:59 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id BE52E40289
 for <dev@dpdk.org>; Wed, 24 Sep 2025 13:50:57 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cWw9W3tdgz6L4sK;
 Wed, 24 Sep 2025 19:49:03 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 8FCAB1400D9;
 Wed, 24 Sep 2025 19:50:56 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 24 Sep 2025 12:50:56 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 24 Sep 2025 12:50:56 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Ola Liljedahl <Ola.Liljedahl@arm.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Honnappa Nagarahalli
 <Honnappa.Nagarahalli@arm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Dhruv Tripathi <Dhruv.Tripathi@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: RE: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Topic: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Index: AQHcJnJlB2Gj2xn6O0SOJRCJl7cS/rSWYP5wgABfdICAADf1oP///ZsAgATllsCABXDfAIAApMtQgAARVpCAAACagIAAJIKggAAHFQCAABO1wA==
Date: Wed, 24 Sep 2025 11:50:56 +0000
Message-ID: <73287d6c09d049aa994a1d17962130b9@huawei.com>
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
In-Reply-To: <9B712773-4A39-4D09-9313-1623EE30F209@arm.com>
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

DQoNCj4gPiA+ID4gPiBTdXJlLCBJIGFtIHRhbGtpbmcgYWJvdXQgTVQgc2NlbmFyaW8uDQo+ID4g
PiA+ID4gSSB0aGluayBJIGFscmVhZHkgcHJvdmlkZWQgYW4gZXhhbXBsZTogRFBESyBtZW1wb29s
IGxpYnJhcnkgKHNlZSBiZWxvdykuDQo+ID4gPiA+ID4gSW4gYnJpZWYsIEl0IHdvcmtzIGxpa2Ug
dGhhdDoNCj4gPiA+ID4gPiBBdCBpbml0IGl0IGFsbG9jYXRlcyByaW5nIG9mIE4gbWVtb3J5IGJ1
ZmZlcnMgYW5kIHJpbmcgYmlnIGVub3VnaCB0byBob2xkIGFsbCBvZg0KPiA+ID4gdGhlbS4NCj4g
PiA+ID4NCj4gPiA+ID4gU29ycnksIEkgbWVhbnQgdG8gc2F5OiAiaXQgYWxsb2NhdGVzIE4gbWVt
b3J5IGJ1ZmZlcnMgYW5kIHJpbmcgYmlnIGVub3VnaCB0bw0KPiBob2xkDQo+ID4gPiBhbGwgb2Yg
dGhlbSIuDQo+ID4gPiA+DQo+ID4gPiA+ID4gVGhlbiBpdCBlbnF1ZXVlcyBhbGwgYWxsb2NhdGVk
IG1lbW9yeSBidWZmZXJzIGludG8gdGhlIHJpbmcuDQo+ID4gPiA+ID4gbWVtcG9vbF9nZXQgLSBy
ZXRyaWV2ZXMgKGRlcXVldWVzKSBidWZmZXJzIGZyb20gdGhlIHJpbmcuDQo+ID4gPiA+ID4gbWVt
cG9vbF9wdXQgLSBwdXRzIHRoZW0gYmFjayAoZW5xdWV1ZXMpIHRvIHRoZSByaW5nDQo+ID4gPiA+
ID4gZ2V0KCkgbWlnaHQgZmFpbCAoRU5PTUVNKSwgd2hpbGUgcHV0IGlzIGV4cGVjdGVkIHRvIGFs
d2F5cyBzdWNjZWVkLg0KPiA+ID4gQnV0IGhvdyBkb2VzIHRoZSB0aHJlYWQgd2hpY2ggY2FsbHMg
bWVtcG9vbF9wdXQoKSBnZXQgaG9sZCBvZiB0aGUgbWVtb3J5DQo+IGJ1ZmZlcnMNCj4gPiA+IHRo
YXQNCj4gPiA+IHdlcmUgb2J0YWluZWQgdXNpbmcgbWVtcG9vbF9nZXQoKSBieSBzb21lIG90aGVy
IHRocmVhZD8gT3IgdGhpcyBpcyBub3QgdGhlDQo+ID4gPiBzY2VuYXJpbyB5b3UNCj4gPiA+IGFy
ZSB3b3JyeWluZyBhYm91dD8NCj4gPiA+IElzIGl0IHJhdGhlciB0aGF0IG11bHRpcGxlIHRocmVh
ZHMgaW5kZXBlbmRlbnRseSBjYWxsIG1lbXBvb2xfZ2V0KCkgYW5kIHRoZW4NCj4gPiA+IG1lbXBv
b2xfcHV0KCkNCj4gPiA+IG9uIHRoZWlyIG93biBidWZmZXJzPyBBbmQgeW91IGFyZSB3b3JyaWVk
IHRoYXQgYSB0aHJlYWQgd2lsbCBmYWlsIHRvIHJldHVybg0KPiA+ID4gKG1lbXBvb2xfcHV0KSBh
DQo+ID4gPiBidWZmZXIgdGhhdCBpdCBlYXJsaWVyIGFsbG9jYXRlZCAobWVtcG9vbF9nZXQpPyBX
ZSBjb3VsZCBjcmVhdGUgYSBsaXRtdXMgdGVzdCBmb3INCj4gPiA+IHRoYXQuDQo+ID4NCj4gPg0K
PiA+IEJvdGggc2NlbmFyaW9zIGFyZSBwb3NzaWJsZS4NCj4gPiBGb3IgUnVuLVRvLUNvbXBsZXRp
b24gbW9kZWwgZWFjaCB0aHJlYWQgdXN1YWxseSBkb2VzOiBhbGxvY2F0ZS91c2UvZnJlZSBncm91
cA0KPiBvZiBtYnVmcy4NCj4gPiBGb3IgcGlwbGVsaW5lIG1vZGVsIG9uZSB0aHJlYWQgY2FuIGFs
bG9jYXRlIGJ1bmNoIG9mIG1idWZzLCB0aGVuIHBhc3MgdGhlbSB0bw0KPiBvdGhlcg0KPiA+IHRo
cmVhZCAodmlhIGFub3RoZXIgcmluZyBmb3IgZXhhbXBsZSkgZm9yIGZ1cnRoZXIgcHJvY2Vzc2lu
ZyBhbmQgdGhlbiByZWxlYXNpbmcuDQo+IEluIHRoZSBwaXBlbGluZSBtb2RlbCwgaWYgdGhlIGxh
c3Qgc3RhZ2UgKHRocmVhZCkgZnJlZXMgKGVucXVldWVzKSBidWZmZXJzIG9udG8gc29tZQ0KPiBy
aW5nIGJ1ZmZlcg0KPiBhbmQgdGhlIGZpcnN0IHN0YWdlICh0aHJlYWQpIGFsbG9jYXRlcyAoZGVx
dWV1ZXMpIGJ1ZmZlcnMgZnJvbSB0aGUgc2FtZSByaW5nIGJ1ZmZlcg0KPiBidXQgdGhlcmUNCj4g
aXNuJ3QgYW55IG90aGVyIHR5cGUgb2Ygc3luY2hyb25pemF0aW9uIGJldHdlZW4gdGhlIHRocmVh
ZHMsIHdlIGNhbiBuZXZlciBndWFyYW50ZWUNCj4gdGhhdA0KPiB0aGUgZmlyc3QgdGhyZWFkIHdp
bGwgYmUgYWJsZSB0byBkZXF1ZXVlIGJ1ZmZlcnMgYmVjYXVzZSBpdCBkb2Vzbid0IGtub3cgd2hl
dGhlciB0aGUNCj4gbGFzdA0KPiB0aHJlYWQgaGFzIGVucXVldWVkIGFueSBidWZmZXJzLg0KDQpZ
ZXMsIGFzIEkgc2FpZCBhYm92ZSAtIGZvciBtZW1wb29sIHVzZS1jYXNlOiBkZXF1ZXVlIGNhbiBm
YWlsLCBlbnF1ZXVlIHNob3VsZCBhbHdheXMgc3VjY2VlZC4NClRoZSBjbG9zZXN0IGFuYWxvZ3k6
IG1hbGxvYygpIGNhbiBmYWlsLCBmcmVlKCkgc2hvdWxkIG5ldmVyIGZhaWwuDQoNCj4gDQo+IEhv
d2V2ZXIsIGVucXVldWUgb3VnaHQgdG8gYWx3YXlzIHN1Y2NlZWQuIFdlIHNob3VsZCBiZSBhYmxl
IHRvIGNyZWF0ZSBhIGxpdG11cw0KPiB0ZXN0IGZvciB0aGF0Lg0KPiBSaW5nIDEgaXMgdXNlZCBh
cyBtZW1wb29sLCBpdCBpbml0aWFsbHkgY29udGFpbnMgY2FwYWNpdHkgZWxlbWVudHMgKGZ1bGwp
Lg0KPiBSaW5nIDIgaXMgdXNlZCBhcyBwaXBlIGJldHdlZW4gc3RhZ2VzIDEgYW5kIDIsIGl0IGlu
aXRpYWxseSBjb250YWlucyAwIGVsZW1lbnRzIChlbXB0eSkuDQo+IFRocmVhZCAxIGFsbG9jYXRl
cy9kZXF1ZXVlcyBhIGJ1ZmZlciBmcm9tIHJpbmcgMS4NCj4gVGhyZWFkIDEgZW5xdWV1ZXMgdGhh
dCBidWZmZXIgb250byByaW5nIDIuDQo+IFRocmVhZCAyIGRlcXVldWVzIGEgYnVmZmVyIGZyb20g
cmluZyAyLg0KPiBUaHJlYWQgMiBmcmVlcy9lbnF1ZXVlcyB0aGF0IGJ1ZmZlciBvbnRvIHJpbmcg
MS4gIDw8PCB0aGlzIG11c3Qgc3VjY2VlZCENCj4gRG9lcyB0aGlzIHJlZmxlY3QgdGhlIHNpdHVh
dGlvbiB5b3Ugd29ycnkgYWJvdXQ/DQoNClRoaXMgaXMgb25lIG9mIHRoZSBwb3NzaWJsZSBzY2Vu
YXJpb3MuDQpBcyBJIHNhaWQgYWJvdmUgLSBtZW1wb29sX3B1dCgpIGlzIGV4cGVjdGVkIHRvIGFs
d2F5cyBiZSBhYmxlIHRvIGVucXVldWUgZWxlbWVudCB0byB0aGUgcmluZy4NClRCSCwgSSBhbSBu
b3Qgc3VyZSB3aGF0IHlvdSBhcmUgdHJ5aW5nIHRvIHByb3ZlIHdpdGggdGhlIGxpdG11cyB0ZXN0
Lg0KTG9va2luZyBhdCB0aGUgY2hhbmdlcyB5b3UgcHJvcG9zZWQ6DQoNCisgICAgICAgICAgICAg
ICAvKg0KKyAgICAgICAgICAgICAgICAqIEVuc3VyZSB0aGUgZW50cmllcyBjYWxjdWxhdGlvbiB3
YXMgbm90IGJhc2VkIG9uIGEgc3RhbGUNCisgICAgICAgICAgICAgICAgKiBhbmQgdW5zYWZlIHN0
YWlsIG9ic2VydmF0aW9uIHRoYXQgY2F1c2VzIHVuZGVyZmxvdy4NCisgICAgICAgICAgICAgICAg
Ki8NCisgICAgICAgICAgICAgICBpZiAoKGludCkqZW50cmllcyA8IDApDQorICAgICAgICAgICAg
ICAgICAgICAgICAqZW50cmllcyA9IDA7DQorIA0KDQogICAgICAgICAgICAgICAgLyogY2hlY2sg
dGhhdCB3ZSBoYXZlIGVub3VnaCByb29tIGluIHJpbmcgKi8NCiAgICAgICAgICAgICAgICBpZiAo
dW5saWtlbHkobiA+ICplbnRyaWVzKSkNCiAgICAgICAgICAgICAgICAgICAgICAgIG4gPSAoYmVo
YXZpb3IgPT0gUlRFX1JJTkdfUVVFVUVfRklYRUQpID8NCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAwIDogKmVudHJpZXM7DQoNCiAgICAgICAgICAgICAgICAqbmV3X2hl
YWQgPSAqb2xkX2hlYWQgKyBuOw0KICAgICAgICAgICAgICAgIGlmIChuID09IDApDQogICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCg0KSXQgaXMgY2xlYXIgdGhhdCB3aXRoIHRoZXNl
IGNoYW5nZXMgZW5xdWV1ZS9kZXF1ZXVlIG1pZ2h0IGZhaWwgZXZlbg0Kd2hlbiB0aGVyZSBhcmUg
YXZhaWxhYmxlIGVudHJpZXMgaW4gdGhlIHJpbmcuDQpPbmUgc2ltcGxlIHdheSB0aGF0IHByb2Jh
Ymx5IHdpbGwgaW50cm9kdWNlIGEgbG9vcCBpbnN0ZWFkIG9mICdpZic6DQooa2VlcCByZWFkaW5n
IGhlYWQgYW5kIHRhaWwgdmFsdWVzIHRpbGwgd2UgZ2V0IGEgdmFsaWQgcmVzdWx0cykNCmJ1dCBh
Z2FpbiBJIGFtIG5vdCBzdXJlIGl0IGlzIGEgZ29vZCB3YXkuIA0KS29uc3RhbnRpbg0K
