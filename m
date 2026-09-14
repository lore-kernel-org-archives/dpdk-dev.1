Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698D8C88E73
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 12:04:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAA24402F1;
	Mon, 14 Sep 2026 14:04:24 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 47CC640272
 for <dev@dpdk.org>; Mon, 14 Sep 2026 14:04:23 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=XtoWqQpFsjWXRS5XRCZ2w8ochjUPVsSvCV2XDWkd0Qk=;
 b=oMlxfBoPUakDdy5FtuPWm/8KKVtrPLwdNh26fmeR3vuXMeOpWLcBm70uysxqCeApp3g6M2GbN
 4KQrLnBZImOuB12xJ98DeyqdOYKVzPcAnJXBgXjioaTF4QKJdbI99sEQYHveLew1CYMsLh224Hy
 KIKl1GNNXgHLUVuFzv9SuFQ=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hk3j267xGzHnH69;
 Mon, 14 Sep 2026 20:04:06 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id 4F66E40571;
 Mon, 14 Sep 2026 20:04:17 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 13:04:16 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.2562.046; 
 Mon, 14 Sep 2026 13:04:16 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <hofors@lysator.liu.se>, "Stephen
 Hemminger" <stephen@networkplumber.org>, "dev@dpdk.org" <dev@dpdk.org>
CC: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>
Subject: RE: [PATCH v2] eal: allow setting random number generator seed
Thread-Topic: [PATCH v2] eal: allow setting random number generator seed
Thread-Index: AQHdQtJYQorH0PciNka/Z4TPHAjWYrbN4isAgAAZi4A=
Date: Mon, 14 Sep 2026 12:04:16 +0000
Message-ID: <8bf95eb0e0704401a1168a4e4fd238de@huawei.com>
References: <20260911225845.3168061-1-stephen@networkplumber.org>
 <20260912161744.201627-1-stephen@networkplumber.org>
 <bd0242b5-44d8-40c7-8928-4586f0191fe1@lysator.liu.se>
In-Reply-To: <bd0242b5-44d8-40c7-8928-4586f0191fe1@lysator.liu.se>
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

DQoNCj4gRGVuIDIwMjYtMDktMTIga2wuIDE4OjE2LCBza3JldiBTdGVwaGVuIEhlbW1pbmdlcjoN
Cj4gPiBNYW55IHBlcmZvcm1hbmNlIHRlc3RzIHVzZSBydGVfcmFuZCgpIGFuZCB0aGUgcmFuZG9t
IG51bWJlcg0KPiA+IGNhbiBwZXJ0dXJiIHRoZSByZXN1bHRzLiBBZGQgYW4gYWJpbGl0eSB0byBv
dmVycmlkZSB0aGUgYXV0b21hdGljDQo+ID4gcmFuZG9tIHNlZWQgb24gRFBESyBzdGFydHVwLg0K
PiANCj4gVGhlcmUgaXMgYSB3YXkgdG8gc2VlZCB0aGUgUFJORyBhbHJlYWR5LCBydGVfc3JhbmQo
KS4gV2h5IHRoZSB0ZXN0cw0KPiBjYW4ndCB1c2UgdGhpcz8NCj4gDQo+IFByb3ZpZGVkIHRoZSB0
ZXN0IHJlc3VsdHMgZGVwZW5kIG9uIHNvbWV0aGluZyB0aGF0IHVzZSB0aGUgUFJORyBiZWZvcmUN
Cj4gdGhlIHRlc3QgZHJpdmVyIGhhcyBoYWQgdGhlIG9wcG9ydHVuaXR5IHRvIGNhbGwgcnRlX3Ny
YW5kKCksIGNvbnRyb2xsaW5nDQo+IHRoZSAqaW5pdGlhbCogc2VlZCBtYXkgYmUgcmVxdWlyZWQu
DQo+IA0KPiBJIGRvbid0IHRoaW5rIHRoaXMgZmVhdHVyZSBzaG91bGQgYmUgY29udHJvbGxlZCBi
eSBhbiBlbnZpcm9ubWVudA0KPiB2YXJpYWJsZS4gVGhlcmUgaXMgbm8gcHJlY2VkZW50IGZvciB0
aGF0LiBJZiB0aGlzIGZ1bmN0aW9uYWxpdHkgaXMNCj4gZGVlbWVkIHVzZWZ1bCwgaXQgc2hvdWxk
IGJlIGFuIEVBTCBjb21tYW5kIGxpbmUgb3B0aW9uLCBpdCBzZWVtcyB0byBtZS4NCg0KKzENCg0K
PiANCj4gPg0KPiA+IFRoaXMgaXMgbm90IGEgc2VjdXJpdHkgcHJvYmxlbSBzaW5jZSBydGVfcmFu
ZCgpIGlzIGRvY3VtZW50ZWQNCj4gPiBhcyBub3QgYmVpbmcgY3J5cHRvZ3JhcGhpY2FsbHkgc2Vj
dXJlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5A
bmV0d29ya3BsdW1iZXIub3JnPg0KPiA+IFJldmlld2VkLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8bWJA
c21hcnRzaGFyZXN5c3RlbXMuY29tPg0KPiA+IC0tLQ0KPiA+IHYyIC0gZml4IGhlYWRlciBpbmNs
dXNpb24NCj4gPiAgICAgLSBhZGQgZG9jYm9vayBjb21tZW50DQo+ID4NCj4gPiAgIGxpYi9lYWwv
Y29tbW9uL3J0ZV9yYW5kb20uYyAgfCAxNCArKysrKysrKysrKysrLQ0KPiA+ICAgbGliL2VhbC9p
bmNsdWRlL3J0ZV9yYW5kb20uaCB8ICA4ICsrKysrLS0tDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQs
IDE4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
bGliL2VhbC9jb21tb24vcnRlX3JhbmRvbS5jIGIvbGliL2VhbC9jb21tb24vcnRlX3JhbmRvbS5j
DQo+ID4gaW5kZXggNTc2YTMyYTQ2Yy4uM2NjMGUzZWM1ZiAxMDA2NDQNCj4gPiAtLS0gYS9saWIv
ZWFsL2NvbW1vbi9ydGVfcmFuZG9tLmMNCj4gPiArKysgYi9saWIvZWFsL2NvbW1vbi9ydGVfcmFu
ZG9tLmMNCj4gPiBAQCAtOCw2ICs4LDcgQEANCj4gPiAgICNlbmRpZg0KPiA+ICAgI2VuZGlmDQo+
ID4gICAjaW5jbHVkZSA8dW5pc3RkLmg+DQo+ID4gKyNpbmNsdWRlIDxzdGRsaWIuaD4NCj4gPg0K
PiA+ICAgI2luY2x1ZGUgPHJ0ZV9iaXRvcHMuaD4NCj4gPiAgICNpbmNsdWRlIDxydGVfYnJhbmNo
X3ByZWRpY3Rpb24uaD4NCj4gPiBAQCAtMjQ3LDcgKzI0OCwxOCBAQCBlYWxfcmFuZF9pbml0KHZv
aWQpDQo+ID4NCj4gPiAgIAlSVEVfTENPUkVfVkFSX0FMTE9DKHJhbmRfc3RhdGUpOw0KPiA+DQo+
ID4gLQlzZWVkID0gX19ydGVfcmFuZG9tX2luaXRpYWxfc2VlZCgpOw0KPiA+ICsJY29uc3QgY2hh
ciAqZW52ID0gZ2V0ZW52KCJEUERLX1JBTkRPTV9TRUVEIik7DQo+ID4gKwlpZiAoZW52ICE9IE5V
TEwgJiYgKmVudiAhPSAnXDAnKSB7DQo+ID4gKwkJY2hhciAqZW5kOw0KPiA+ICsNCj4gPiArCQll
cnJubyA9IDA7DQo+ID4gKwkJc2VlZCA9IHN0cnRvdWxsKGVudiwgJmVuZCwgMCk7DQo+ID4gKwkJ
aWYgKGVycm5vICE9IDAgfHwgKmVuZCAhPSAnXDAnKQ0KPiA+ICsJCQlydGVfZXhpdChFWElUX0ZB
SUxVUkUsDQo+ID4gKwkJCQkgImludmFsaWQgRFBES19SQU5ET01fU0VFRDogJXNcbiIsIGVudik7
DQo+IA0KPiBJcyBydGVfZXhpdCgpIHRoZSB3YXkgdG8gZGVhbCB3aXRoIGVycm9ycyBoZXJlPyBO
b3QgdG8gYmUgdXNlZCBpbiBEUERLDQo+IGxpYnJhcmllcywgaWYgSSByZWNhbGwgY29ycmVjdGx5
Lg0KDQpBZ2FpbiwgKzENCldob2xlIHBhdGNoIGxvb2tzIHRvIG1lIGxpa2UgYSBzdHJhbmdlIGhh
Y2sgdGhhdCBjb21wbGV0ZWx5IGlnbm9yZXMgRFBESyBjb2RpbmcgcHJhY3RpY2VzLiANCk15IHZv
dGUgaXMgTkFDSy4NCg0KPiANCj4gSSB3b3VsZCB0aGluayBsb2dnaW5nIGFuIGVycm9yIHdvdWxk
IHN1ZmZpY2UuIE9yIHJ0ZV9lYWxfaW5pdF9hbGVydCgpLg0KPiANCj4gPiArCX0gZWxzZSB7DQo+
ID4gKwkJc2VlZCA9IF9fcnRlX3JhbmRvbV9pbml0aWFsX3NlZWQoKTsNCj4gPiArCX0NCj4gPg0K
PiA+ICAgCXJ0ZV9zcmFuZChzZWVkKTsNCj4gPiAgIH0NCj4gPiBkaWZmIC0tZ2l0IGEvbGliL2Vh
bC9pbmNsdWRlL3J0ZV9yYW5kb20uaCBiL2xpYi9lYWwvaW5jbHVkZS9ydGVfcmFuZG9tLmgNCj4g
PiBpbmRleCAxNWNiZTYyMTVhLi5iZGQ0MDAxZTc4IDEwMDY0NA0KPiA+IC0tLSBhL2xpYi9lYWwv
aW5jbHVkZS9ydGVfcmFuZG9tLmgNCj4gPiArKysgYi9saWIvZWFsL2luY2x1ZGUvcnRlX3JhbmRv
bS5oDQo+ID4gQEAgLTIwLDkgKzIwLDExIEBAIGV4dGVybiAiQyIgew0KPiA+ICAgLyoqDQo+ID4g
ICAgKiBTZWVkIHRoZSBwc2V1ZG8tcmFuZG9tIGdlbmVyYXRvci4NCj4gPiAgICAqDQo+ID4gLSAq
IFRoZSBnZW5lcmF0b3IgaXMgYXV0b21hdGljYWxseSBzZWVkZWQgYnkgdGhlIEVBTCBpbml0IHdp
dGggYSB0aW1lcg0KPiA+IC0gKiB2YWx1ZS4gSXQgbWF5IG5lZWQgdG8gYmUgcmUtc2VlZGVkIGJ5
IHRoZSB1c2VyIHdpdGggYSByZWFsIHJhbmRvbQ0KPiA+IC0gKiB2YWx1ZS4NCj4gPiArICogVGhl
IGdlbmVyYXRvciBpcyBhdXRvbWF0aWNhbGx5IHNlZWRlZCBieSB0aGUgRUFMIGluaXQgd2l0aA0K
PiA+ICsgKiBhIHN5c3RlbSBwcm92aWRlZCByYW5kb20gZW50cm9weSBzb3VyY2UuIEJ1dCBmb3Ig
dGVzdGluZw0KPiA+ICsgKiBpdCBjYW4gYmUgdXNlZnVsIHRvIGZvcmNlIGEgcmVwZWF0YWJsZSBz
dGFydGluZyBwb2ludCBieQ0KPiA+ICsgKiBzZXR0aW5nIHRoZSBpbml0aWFsIHNlZWQuIFRoaXMg
Y2FuIGJlIGRvbmUgYnkgc2V0dGluZw0KPiA+ICsgKiB0aGUgYERQREtfUkFORE9NX1NFRURgIGVu
dmlyb25tZW50IHZhcmlhYmxlLg0KPiA+ICAgICoNCj4gPiAgICAqIFRoaXMgZnVuY3Rpb24gaXMg
bm90IG11bHRpLXRocmVhZCBzYWZlIGluIHJlZ2FyZHMgdG8gb3RoZXINCj4gPiAgICAqIHJ0ZV9z
cmFuZCgpIGNhbGxzLCBub3IgaXMgaXQgaW4gcmVsYXRpb24gdG8gY29uY3VycmVudCBydGVfcmFu
ZCgpLA0KDQo=
