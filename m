Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC90C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 09:01:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C01E4021F;
	Mon, 14 Jul 2025 11:01:25 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 62E4E400D5
 for <dev@dpdk.org>; Mon, 14 Jul 2025 11:01:24 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgbr32nrqz6L5WD;
 Mon, 14 Jul 2025 17:00:19 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id 601FF14044F;
 Mon, 14 Jul 2025 17:01:23 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 11:01:23 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 14 Jul 2025 11:01:23 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Thomas Monjalon <thomas@monjalon.net>, Andre Muezerie
 <andremue@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, David Marchand <david.marchand@redhat.com>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 "honnappa.nagarahalli@arm.com" <honnappa.nagarahalli@arm.com>
Subject: RE: [PATCH] rcu: add deprecation notice about limit on defer queue
 element size
Thread-Topic: [PATCH] rcu: add deprecation notice about limit on defer queue
 element size
Thread-Index: AQHby3J+6csbXQ+lwUObzuOK3rg/V7QdbUoAgA4qsoCAAXD3AIAEl8Xw
Date: Mon, 14 Jul 2025 09:01:23 +0000
Message-ID: <b2f6bd8eda1c4e728caeb5ee918d0068@huawei.com>
References: <1747957021-2581-1-git-send-email-andremue@linux.microsoft.com>
 <4620749.daG60p0z9X@thomas>
 <20250710143747.GA24344@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <5695570.h0BymrIErR@thomas>
In-Reply-To: <5695570.h0BymrIErR@thomas>
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

DQoNCj4gDQo+IDEwLzA3LzIwMjUgMTY6MzcsIEFuZHJlIE11ZXplcmllOg0KPiA+IE9uIFR1ZSwg
SnVsIDAxLCAyMDI1IGF0IDA0OjE3OjIwUE0gKzAyMDAsIFRob21hcyBNb25qYWxvbiB3cm90ZToN
Cj4gPiA+IDIzLzA1LzIwMjUgMDE6MzcsIEFuZHJlIE11ZXplcmllOg0KPiA+ID4gPiBUaGUgZnVu
Y3Rpb25zIHJ0ZV9yY3VfcXNicl9kcV9jcmVhdGUgYW5kIHJ0ZV9yY3VfcXNicl9kcV9yZWNsYWlt
IGVzdGFibGlzaA0KPiA+ID4gPiBubyBsaW1pdCBvbiB0aGUgc2l6ZSBvZiBlYWNoIGVsZW1lbnQg
aW4gdGhlIGRlZmVyIHF1ZXVlLg0KPiA+ID4NCj4gPiA+IFZlcnkgZ29vZCwgd2UgbmVlZCBtb3Jl
IHVubGltaXRlZCBBUEkgaW4gRFBESy4NCj4gPiA+DQo+ID4gPiA+IFdpdGggRFBESyAyNS4xMSBh
IGhhcmQgbGltaXQgd2lsbCBiZSBzZXQgKGBgUlRFX1FTQlJfRVNJWkVfTUFYYGApLg0KPiA+ID4N
Cj4gPiA+IEkgdGhpbmsgaXQgaXMgYSBzdGVwIGluIHRoZSB3cm9uZyBkaXJlY3Rpb24uDQo+ID4g
PiBJIHByZWZlciBoYXZpbmcgbm8gbGltaXQuDQo+ID4gPg0KPiA+ID4gPiBUaGlzIHdpbGwgYWxs
b3cgZml4ZWQgQyBhcnJheXMgdG8gYmUgdXNlZCBpbiB0aGUgZnVuY3Rpb25zJyBpbXBsZW1lbnRh
dGlvbnMsDQo+ID4gPiA+IGF2b2lkaW5nIFZMQXMgYW5kIHVzZSBvZiBhbGxvY2EoKS4NCj4gPiA+
DQo+ID4gPiBJIGRvbid0IHVuZGVyc3RhbmQgdGhpcyBqdXN0aWZpY2F0aW9uLg0KPiA+ID4gV2h5
IHRyeWluZyB0byByZW1vdmUgdGhlIDIgYWxsb2NhKCkgaW4gdGhlIGxpYiBSQ1U/DQo+ID4gPg0K
PiA+DQo+ID4gT25seSBiZWNhdXNlIG90aGVyIGRldmVsb3BlciBleHByZXNzZWQgY29uY2VybnMg
dGhhdCB1c2luZyBhbGxvY2EoKSBhbGxvd3MNCj4gPiBpbGwtaW50ZW5kZWQgY2FsbGVycyB0byBj
YXVzZSBhIHN0YWNrIG92ZXJmbG93Lg0KPiA+IEkgcGVyc29uYWxseSBhbHNvIHByZWZlciB0byBo
YXZlIG5vIGhhcmRjb2RlZCBsaW1pdHMuDQo+IA0KPiBZZXMgSSB2b3RlIGZvciBrZWVwaW5nIGFs
bG9jYSgpLg0KPiANCg0KUHJvYmFibHkgaXQgd2FzIG1lIHdobyBleHByZXNzZWQgc29tZSBjb25j
ZXJucywgc29ycnkgZm9yIGxhdGUgcmVwbHkuDQpJIGNhbiBvbmx5IHJlcGVhdCB3aGF0IEkgYWxy
ZWFkeSByZXBsaWVkIHRvIERhdmlkOg0KIA0KRm9yIHRoYXQgcGFydGljdWxhciBjYXNlLCBteSBy
ZWFzb25zIGFyZSBtb3N0bHkgY29uY2VwdHVhbDoNCnVzaW5nIGFsbG9jYSgpIGRvZXNuJ3QgcmVh
bGx5IGRpZmZlciBmcm9tIHNpbXBseSB1c2luZyBWTEEsDQppbiBmYWN0IGl0IG1ha2VzIGNvZGUg
bG9va3MgdWdsaWVyLg0KSSB1bmRlcnN0YW5kIHRoYXQgd2UgZG8gd2FudCBNU1ZDIGVuYWJsZWQs
IGFuZCBpbiBtYW55IGNhc2VzIHN1Y2ggbWVjaGFuaWNhbA0KcmVwbGFjZW1lbnQgaXMgb2ssIGJ1
dCBwcm9iYWJseSBiZXR0ZXIgdG8gYXZvaWQgIGl0IHdoZW5ldmVyIHBvc3NpYmxlLiANCg0KIHN1
cHBvc2Ugd2UgaGF2ZSAzIG9wdGlvbnM6DQoxKSB1c2UgcHJlZGVmaW5lZCBtYXggdmFsdWUgKGl0
IGNvdWxkIGJlIHF1aXRlIGJpZyB0byBmaXQgYW55IHJlYXNvbmFibGUgdXNhZ2UsIGxldCBzYXkg
MUtCIG9yIHNvKS4NCjIpIHVzZSBhbGxvY2EoKS4NCjMpIGNvbWUtdXAgd2l0aCBzb21lIHNtYXJ0
ZXIgYXBwcm9hY2guDQoNCkZvciAzKSAtIEkgZG9uJ3QgaGF2ZSBhbnkgZ29vZCBpZGVhcy4NCk9u
ZSBvcHRpb24gd291bGQgYmUgdG8gY3JlYXRlIHRoYXQgcmluZyBSSU5HX0ZfTVBfSFRTX0VOUSAg
ZmxhZ3MsDQp0aGVuIHdlIGNhbiB1c2UgcGVlayBBUEkgIGZvciBlbnF1ZXVlIHBhcnQgdG9vIChy
dGVfcmluZ19lbnF1ZXVlX2J1bGtfZWxlbV9zdGFydCkuDQpUaGF0IHdvdWxkIHNvbHZlIGFuIGlz
c3VlLCBhcyBpbiB0aGF0IGNhc2Ugd2Ugd291bGRuJ3QgbmVlZCB0byBtYWtlIHRlbXAgY29weSBv
ZiBkYXRhIG9uIHRoZSBzdGFjay4NCk15IHByZWZlcmVuY2Ugd291bGQgYmUgZWl0aGVyIDEpIG9y
IDMpLCBidXQgSSBjb3VsZCBsZWF2ZSB3aXRoIDIpIHRvbyAtIHNwZWNpYWxseSB0aGF0IEkgZG9u
J3QgcmVhbGx5IHVzZSB0aGF0IHBhcnQgb2YgUkNVIGxpYi4NCldvdWxkIGJlIHJlYWxseSBnb29k
IHRvIGhlYXIgb3BpbmlvbiBvZiBSQ1UgbGliIG1haW50YWluZXIuDQoNCktvbnN0YW50aW4NCg==
