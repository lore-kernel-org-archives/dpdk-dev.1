Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC656CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 13:17:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2D8A40267;
	Mon, 18 Aug 2025 15:17:51 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id DB30640262
 for <dev@dpdk.org>; Mon, 18 Aug 2025 15:17:50 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5Cts6tWpz6L5Vh;
 Mon, 18 Aug 2025 21:17:41 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 923CA1402FE;
 Mon, 18 Aug 2025 21:17:49 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Aug 2025 15:17:49 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 18 Aug 2025 15:17:49 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>, Andre Muezerie <andremue@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, David Marchand <david.marchand@redhat.com>, 
 Bruce Richardson <bruce.richardson@intel.com>, Honnappa Nagarahalli
 <Honnappa.Nagarahalli@arm.com>, nd <nd@arm.com>
Subject: RE: [PATCH] rcu: add deprecation notice about limit on defer queue
 element size
Thread-Topic: [PATCH] rcu: add deprecation notice about limit on defer queue
 element size
Thread-Index: AQHby3J+6csbXQ+lwUObzuOK3rg/V7QdbUoAgA4qsoCAAXD3AIAEl8XwgCZReoCAEPp6MA==
Date: Mon, 18 Aug 2025 13:17:49 +0000
Message-ID: <3d00b2eba2a0481dada17c7139c40d2f@huawei.com>
References: <1747957021-2581-1-git-send-email-andremue@linux.microsoft.com>
 <4620749.daG60p0z9X@thomas>
 <20250710143747.GA24344@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <5695570.h0BymrIErR@thomas> <b2f6bd8eda1c4e728caeb5ee918d0068@huawei.com>
 <PAWPR08MB890987187E300A80DC4FD36B9F2CA@PAWPR08MB8909.eurprd08.prod.outlook.com>
In-Reply-To: <PAWPR08MB890987187E300A80DC4FD36B9F2CA@PAWPR08MB8909.eurprd08.prod.outlook.com>
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

DQo+ID4gPg0KPiA+ID4gMTAvMDcvMjAyNSAxNjozNywgQW5kcmUgTXVlemVyaWU6DQo+ID4gPiA+
IE9uIFR1ZSwgSnVsIDAxLCAyMDI1IGF0IDA0OjE3OjIwUE0gKzAyMDAsIFRob21hcyBNb25qYWxv
biB3cm90ZToNCj4gPiA+ID4gPiAyMy8wNS8yMDI1IDAxOjM3LCBBbmRyZSBNdWV6ZXJpZToNCj4g
PiA+ID4gPiA+IFRoZSBmdW5jdGlvbnMgcnRlX3JjdV9xc2JyX2RxX2NyZWF0ZSBhbmQgcnRlX3Jj
dV9xc2JyX2RxX3JlY2xhaW0NCj4gPiA+ID4gPiA+IGVzdGFibGlzaCBubyBsaW1pdCBvbiB0aGUg
c2l6ZSBvZiBlYWNoIGVsZW1lbnQgaW4gdGhlIGRlZmVyIHF1ZXVlLg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gVmVyeSBnb29kLCB3ZSBuZWVkIG1vcmUgdW5saW1pdGVkIEFQSSBpbiBEUERLLg0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiBXaXRoIERQREsgMjUuMTEgYSBoYXJkIGxpbWl0IHdpbGwgYmUg
c2V0IChgYFJURV9RU0JSX0VTSVpFX01BWGBgKS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEkgdGhp
bmsgaXQgaXMgYSBzdGVwIGluIHRoZSB3cm9uZyBkaXJlY3Rpb24uDQo+ID4gPiA+ID4gSSBwcmVm
ZXIgaGF2aW5nIG5vIGxpbWl0Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGlzIHdpbGwgYWxs
b3cgZml4ZWQgQyBhcnJheXMgdG8gYmUgdXNlZCBpbiB0aGUgZnVuY3Rpb25zJw0KPiA+ID4gPiA+
ID4gaW1wbGVtZW50YXRpb25zLCBhdm9pZGluZyBWTEFzIGFuZCB1c2Ugb2YgYWxsb2NhKCkuDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBJIGRvbid0IHVuZGVyc3RhbmQgdGhpcyBqdXN0aWZpY2F0aW9u
Lg0KPiA+ID4gPiA+IFdoeSB0cnlpbmcgdG8gcmVtb3ZlIHRoZSAyIGFsbG9jYSgpIGluIHRoZSBs
aWIgUkNVPw0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IE9ubHkgYmVjYXVzZSBvdGhlciBk
ZXZlbG9wZXIgZXhwcmVzc2VkIGNvbmNlcm5zIHRoYXQgdXNpbmcgYWxsb2NhKCkNCj4gPiA+ID4g
YWxsb3dzIGlsbC1pbnRlbmRlZCBjYWxsZXJzIHRvIGNhdXNlIGEgc3RhY2sgb3ZlcmZsb3cuDQo+
ID4gPiA+IEkgcGVyc29uYWxseSBhbHNvIHByZWZlciB0byBoYXZlIG5vIGhhcmRjb2RlZCBsaW1p
dHMuDQo+ID4gPg0KPiA+ID4gWWVzIEkgdm90ZSBmb3Iga2VlcGluZyBhbGxvY2EoKS4NCj4gPiA+
DQo+ID4NCj4gPiBQcm9iYWJseSBpdCB3YXMgbWUgd2hvIGV4cHJlc3NlZCBzb21lIGNvbmNlcm5z
LCBzb3JyeSBmb3IgbGF0ZSByZXBseS4NCj4gPiBJIGNhbiBvbmx5IHJlcGVhdCB3aGF0IEkgYWxy
ZWFkeSByZXBsaWVkIHRvIERhdmlkOg0KPiA+DQo+ID4gRm9yIHRoYXQgcGFydGljdWxhciBjYXNl
LCBteSByZWFzb25zIGFyZSBtb3N0bHkgY29uY2VwdHVhbDoNCj4gPiB1c2luZyBhbGxvY2EoKSBk
b2Vzbid0IHJlYWxseSBkaWZmZXIgZnJvbSBzaW1wbHkgdXNpbmcgVkxBLCBpbiBmYWN0IGl0IG1h
a2VzIGNvZGUNCj4gPiBsb29rcyB1Z2xpZXIuDQo+ID4gSSB1bmRlcnN0YW5kIHRoYXQgd2UgZG8g
d2FudCBNU1ZDIGVuYWJsZWQsIGFuZCBpbiBtYW55IGNhc2VzIHN1Y2gNCj4gPiBtZWNoYW5pY2Fs
IHJlcGxhY2VtZW50IGlzIG9rLCBidXQgcHJvYmFibHkgYmV0dGVyIHRvIGF2b2lkICBpdCB3aGVu
ZXZlcg0KPiA+IHBvc3NpYmxlLg0KPiA+DQo+ID4gIHN1cHBvc2Ugd2UgaGF2ZSAzIG9wdGlvbnM6
DQo+ID4gMSkgdXNlIHByZWRlZmluZWQgbWF4IHZhbHVlIChpdCBjb3VsZCBiZSBxdWl0ZSBiaWcg
dG8gZml0IGFueSByZWFzb25hYmxlIHVzYWdlLA0KPiA+IGxldCBzYXkgMUtCIG9yIHNvKS4NCj4g
PiAyKSB1c2UgYWxsb2NhKCkuDQo+ID4gMykgY29tZS11cCB3aXRoIHNvbWUgc21hcnRlciBhcHBy
b2FjaC4NCj4gPg0KPiA+IEZvciAzKSAtIEkgZG9uJ3QgaGF2ZSBhbnkgZ29vZCBpZGVhcy4NCj4g
PiBPbmUgb3B0aW9uIHdvdWxkIGJlIHRvIGNyZWF0ZSB0aGF0IHJpbmcgUklOR19GX01QX0hUU19F
TlEgIGZsYWdzLCB0aGVuIHdlDQo+ID4gY2FuIHVzZSBwZWVrIEFQSSAgZm9yIGVucXVldWUgcGFy
dCB0b28gKHJ0ZV9yaW5nX2VucXVldWVfYnVsa19lbGVtX3N0YXJ0KS4NCj4gPiBUaGF0IHdvdWxk
IHNvbHZlIGFuIGlzc3VlLCBhcyBpbiB0aGF0IGNhc2Ugd2Ugd291bGRuJ3QgbmVlZCB0byBtYWtl
IHRlbXANCj4gPiBjb3B5IG9mIGRhdGEgb24gdGhlIHN0YWNrLg0KPiA+IE15IHByZWZlcmVuY2Ug
d291bGQgYmUgZWl0aGVyIDEpIG9yIDMpLCBidXQgSSBjb3VsZCBsZWF2ZSB3aXRoIDIpIHRvbyAt
IHNwZWNpYWxseQ0KPiA+IHRoYXQgSSBkb24ndCByZWFsbHkgdXNlIHRoYXQgcGFydCBvZiBSQ1Ug
bGliLg0KPiA+IFdvdWxkIGJlIHJlYWxseSBnb29kIHRvIGhlYXIgb3BpbmlvbiBvZiBSQ1UgbGli
IG1haW50YWluZXIuDQo+ID4NCj4gPiBLb25zdGFudGluDQo+IA0KPiBKdXN0IG15IDJjIG9uIHRo
ZSAzIG9wdGlvbnMuDQo+IDEpIFdoYXQncyB0aGUgcmlnaHQgbWF4IHNpemU/IEkgZG9uJ3Qga25v
dywgc28gSSB3b3VsZCByYXRoZXIgbGVhdmUgdGhpcyBmb3IgdGhlIHVzZXIuDQo+IDIpIEkgcHJl
ZmVyIHRoaXMgb3B0aW9uIG92ZXIgKDEpIGR1ZSB0byBhYm92ZSByZWFzb24uDQo+IDMpIHJpbmcg
aXRzZWxmIGlzIHRyaWNreSBzcGVjaWFsbHkgdW5kZXIgcmVsYXhlZCBtZW1vcnksIFJDVSBJcyBh
bHJlYWR5IGNvbXBsZXguIFNvLCBJIHdvdWxkIHJhdGhlciBrZWVwIHRoZW0gc2VwYXJhdGUuDQoN
Ck5vdCBzdXJlLCB3aGF0IHlvdSBhcmUgdGFsa2luZyBhYm91dD8NClJpbmcgaXMgYWxyZWFkeSB0
aGVyZSwgaXQgd2FzIGFkZGVkIGFzIHBhcnQgb2Y6DQpjb21taXQgNzA2ZDMwNmVhMzljOTgyMTkz
YTBjZWRiMzdmZDRiZjhjYWU4NDk3Mg0KQXV0aG9yOiBIb25uYXBwYSBOYWdhcmFoYWxsaSA8aG9u
bmFwcGEubmFnYXJhaGFsbGlAYXJtLmNvbT4NCkRhdGU6ICAgVHVlIEFwciAyMSAyMjozMDowMyAy
MDIwIC0wNTAwDQoNCiAgICByY3U6IGFkZCByZXNvdXJjZSByZWNsYW1hdGlvbiBBUElzDQoNCiAg
ICBBZGQgcmVzb3VyY2UgcmVjbGFtYXRpb24gdXNpbmcgZGVmZXIgcXVldWVzIHRvIG1ha2UgaXQg
c2ltcGxlIGZvcg0KICAgIGFwcGxpY2F0aW9ucyBhbmQgbGlicmFyaWVzIHRvIGludGVncmF0ZSBy
dGVfcmN1IGxpYnJhcnkuDQoNCmNvbW1pdC4NCk15IHN1Z2dlc3Rpb24gd2FzIHRvIGNoYW5nZSBl
bnEgZmxhZ3MsIHRoYXQgd291bGQgYWxsb3cgdXMgdG8gdXNlIHBlZWsgQVBJLg0KSS5FLjoNCiAg
ICAgICAvKiBEZWNpZGUgdGhlIGZsYWdzIGZvciB0aGUgcmluZy4NCiAgICAgICAgICogSWYgTVQg
c2FmZXR5IGlzIHJlcXVlc3RlZCwgdXNlIFJUUyBmb3IgcmluZyBlbnF1ZXVlIGFzIG1vc3QNCiAg
ICAgICAgICogdXNlIGNhc2VzIGludm9sdmUgZHEtZW5xdWV1ZSBoYXBwZW5pbmcgb24gdGhlIGNv
bnRyb2wgcGxhbmUuDQogICAgICAgICAqIFJpbmcgZGVxdWV1ZSBpcyBhbHdheXMgSFRTIGR1ZSB0
byB0aGUgcG9zc2liaWxpdHkgb2YgcmV2ZXJ0Lg0KICAgICAgICAgKi8NCi0gICAgICAgZmxhZ3Mg
PSBSSU5HX0ZfTVBfUlRTX0VOUTsNCisgICAgICBmbGFncyA9IFJJTkdfRl9NUF9IVFNfRU5ROw0K
ICAgICAgICBpZiAocGFyYW1zLT5mbGFncyAmIFJURV9SQ1VfUVNCUl9EUV9NVF9VTlNBRkUpDQog
ICAgICAgICAgICAgICAgZmxhZ3MgPSBSSU5HX0ZfU1BfRU5ROw0KICAgICAgICBmbGFncyB8PSBS
SU5HX0ZfTUNfSFRTX0RFUTsNCiANCk5vdGUgdGhhdCB3ZSBhbHJlYWR5IHVzaW5nIEhUUyBtb2Rl
IGZvciBkZXF1ZXVlLg0KDQo+IFNvLCBJIHByZWZlciBhbGxvY2EoKSBvcHRpb24uDQo+IA0KPiBU
aGFua3MNCj4gDQo+IC0td2F0aHNhbGENCg==
