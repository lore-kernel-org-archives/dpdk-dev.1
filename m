Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F216C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 14:28:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52E0B40EF0;
	Wed, 19 Feb 2025 15:28:27 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 8228940E6E
 for <dev@dpdk.org>; Wed, 19 Feb 2025 15:28:25 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yydxh68MSz6GDB9;
 Wed, 19 Feb 2025 22:26:48 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
 by mail.maildlp.com (Postfix) with ESMTPS id A656E1400F4;
 Wed, 19 Feb 2025 22:28:24 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Feb 2025 15:28:24 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 19 Feb 2025 15:28:24 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: David Marchand <david.marchand@redhat.com>
CC: Andre Muezerie <andremue@linux.microsoft.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "honnappa.nagarahalli@arm.com" <honnappa.nagarahalli@arm.com>
Subject: RE: [PATCH v22 00/27] remove use of VLAs for Windows
Thread-Topic: [PATCH v22 00/27] remove use of VLAs for Windows
Thread-Index: AQHbeDcwSpSc/vf1v0aa09+A8QveyLM6roeAgAE1MSCAETwpAIABoNyA
Date: Wed, 19 Feb 2025 14:28:24 +0000
Message-ID: <c50dc7482fab4dcb8acaa09fd7135b12@huawei.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8zzqa50xJLTk2gb2eZR2fSXNaLX7rHkEx_jdJkERk7Asw@mail.gmail.com>
 <4810322be9134e939513693ae1e88884@huawei.com>
 <CAJFAV8zrcg3yy6c7_Fo5dm_g8KmBYPtGMvcZyaDq_jpYdu3=Sw@mail.gmail.com>
In-Reply-To: <CAJFAV8zrcg3yy6c7_Fo5dm_g8KmBYPtGMvcZyaDq_jpYdu3=Sw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.73]
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

DQo+ID4gPiA+IEFzIHBlciBndWlkYW5jZSB0ZWNobmljYWwgYm9hcmQgbWVldGluZyAyMDI0LzA0
LzE3LiBUaGlzIHNlcmllcw0KPiA+ID4gPiByZW1vdmVzIHRoZSB1c2Ugb2YgVkxBcyBmcm9tIGNv
ZGUgYnVpbHQgZm9yIFdpbmRvd3MgZm9yIGFsbCAzDQo+ID4gPiA+IHRvb2xjaGFpbnMuIElmIHRo
ZXJlIGFyZSBhZGRpdGlvbmFsIG9wcG9ydHVuaXRpZXMgdG8gY29udmVydCBWTEFzDQo+ID4gPiA+
IHRvIHJlZ3VsYXIgQyBhcnJheXMgcGxlYXNlIHByb3ZpZGUgdGhlIGRldGFpbHMgZm9yIGluY29y
cG9yYXRpb24NCj4gPiA+ID4gaW50byB0aGUgc2VyaWVzLg0KPiA+ID4gPg0KPiA+ID4gPiBNU1ZD
IGRvZXMgbm90IHN1cHBvcnQgVkxBcywgcmVwbGFjZSBWTEFzIHdpdGggc3RhbmRhcmQgQyBhcnJh
eXMNCj4gPiA+ID4gb3IgYWxsb2NhKCkuIGFsbG9jYSgpIGlzIGF2YWlsYWJsZSBmb3IgYWxsIHRv
b2xjaGFpbi9wbGF0Zm9ybQ0KPiA+ID4gPiBjb21iaW5hdGlvbnMgb2ZmaWNpYWxseSBzdXBwb3J0
ZWQgYnkgRFBESy4NCj4gPiA+DQo+ID4gPiAtIEkgaGF2ZSBvbmUgY29uY2VybiB3cnQgcGF0Y2gg
Ny4NCj4gPiA+IFRoaXMgY2hhbmdlcyB0aGUgQVBJL0FCSSBvZiB0aGUgUkNVIGxpYnJhcnkuDQo+
ID4gPiBBQkkgY2FuJ3QgYmUgYnJva2VuIGluIHRoZSAyNS4wMyByZWxlYXNlLg0KPiA+ID4NCj4g
PiA+IFNpbmNlIE1TVkMgYnVpbGRzIGRvIG5vdCBpbmNsdWRlIFJDVSB5ZXQsIEkgc2tpcHBlZCB0
aGlzIGNoYW5nZSBhbmQNCj4gPiA+IGFkanVzdGVkIHRoaXMgbGlicmF5IG1lc29uLmJ1aWxkLg0K
PiA+ID4NCj4gPiA+IEtvbnN0YW50aW4sIGRvIHlvdSB0aGluayBwYXRjaCA3IGNvdWxkIGJlIHJl
d3JpdHRlbiB0byBtYWtlIHVzZSBvZg0KPiA+ID4gYWxsb2NhKCkgYW5kIGF2b2lkIGFuIEFQSSBj
aGFuZ2U/DQo+ID4gPiBodHRwczovL3BhdGNod29yay5kcGRrLm9yZy9wcm9qZWN0L2RwZGsvcGF0
Y2gvMTczODgwNTYxMC0xNzUwNy04LWdpdC1zZW5kLWVtYWlsLWFuZHJlbXVlQGxpbnV4Lm1pY3Jv
c29mdC5jb20vDQo+ID4NCj4gPiBJIGFtIG5vdCBiaWcgZmFuIG9mIGFsbG9jYSgpIGFwcHJvYWNo
LCBidXQgeWVzIGl0IGlzIHN1cmVseSBwb3NzaWJsZS4NCj4gDQo+IENhbiB5b3UgcGxlYXNlIGV4
cGxhaW4geW91ciByZWx1Y3RhbmNlPw0KDQpNb3N0bHkgY29uY2VwdHVhbDogdXNpbmcgYWxsb2Nh
KCkgZG9lc24ndCByZWFsbHkgZGlmZmVyIGZyb20gc2ltcGx5IHVzaW5nIFZMQSwNCmluIGZhY3Qg
aXQgbWFrZXMgY29kZSBsb29rcyB1Z2xpZXIuDQpJIHVuZGVyc3RhbmQgdGhhdCB3ZSBkbyB3YW50
IE1TVkMgZW5hYmxlZCwgYW5kIGluIG1hbnkgY2FzZXMgc3VjaCBtZWNoYW5pY2FsDQpyZXBsYWNl
bWVudCBpcyBvaywgYnV0IHByb2JhYmx5IGJldHRlciB0byBhdm9pZCAgaXQgd2hlbmV2ZXIgcG9z
c2libGUuICANCg0KPiANCj4gDQo+ID4gQlRXLCB3aHkgaXQgaXMgY29uc2lkZXJlZCBhZCBBUEkv
QUJJIGNoYW5nZT8NCj4gPiBCZWNhdXNlIHdlIGludHJvZHVjZSBleHRyYSBsaW1pdCBvbiBtYXgg
YWxsb3dhYmxlIHNpemU/DQo+IA0KPiBZZXMsIHRoaXMgaXMgd2hhdCB3YXMgbWVudGlvbm5lZCBp
biB0aGUgY29tbWl0bG9nLg0KPiANCj4gDQo+ID4gSWYgdGhhdCB3b3VsZCBoZWxwIHNvbWVob3cs
IHdlIGNhbiBtYWtlIGl0IGV2ZW4gYmlnZ2VyOiAxSyBvciBzby4NCj4gDQo+IFN0cmljdGx5IHNw
ZWFraW5nLCBpdCBpcyBzdGlsbCBhbiBBUEkgY2hhbmdlLg0KIA0KT2ssIHRoZW4gSSBzdXBwb3Nl
IHdlIGhhdmUgMyBvcHRpb25zOg0KMSkgd2FpdCBmb3IgMjUuMTEgdG8gYXBwbHkgdGhlc2UgY2hh
bmdlcw0KMikgdXNlIGFsbG9jYSgpDQozKSBjb21lLXVwIHdpdGggc29tZSBzbWFydGVyIGFwcHJv
YWNoLg0KDQpGb3IgMykgLSBJIGRvbid0IGhhdmUgYW55IGdvb2QgaWRlYXMgcmlnaHQgbm93Lg0K
T25lIG9wdGlvbiB3b3VsZCBiZSB0byBhbGxvdyByaW5nX2VucXVldWUvcmluZ19kZXF1ZXVlIHRv
IGFjY2VwdCBjdXN0b20gY29weV9lbGVtKCkgZnVuY3Rpb25zIGFzIGEgcGFyYW1ldGVyLg0KVGhh
dCB3b3VsZCBzb2x2ZSBhbiBpc3N1ZSwgYXMgaW4gdGhhdCBjYXNlIHdlIHdvdWxkbid0IG5lZWQg
dG8gbWFrZSB0ZW1wIGNvcHkgb2YgZGF0YSBvbiB0aGUgc3RhY2ssDQpidXQgdGhhdCdzIHByb2Jh
Ymx5IHRvbyBiaWcgY2hhbmdlcyBmb3Igc3VjaCBzbWFsbCB0aGluZy4NClNvIEkgYW0gb2sgd2l0
aCBib3RoIDEpIGFuZCAyKS4NCkluIGZhY3QgLSBpdCBpcyBwcm9iYWJseSBwb3NzaWJsZSB0byBn
byB3aXRoIDIpIGZvciBub3csIGFuZCB0aGVuIHN3aXRjaCB0byAxKSBvciAzKSBpbiAyNS4xMQ0K
DQo=
