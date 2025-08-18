Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC91CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 08:39:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFD8140267;
	Mon, 18 Aug 2025 10:39:16 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8A0814013F
 for <dev@dpdk.org>; Mon, 18 Aug 2025 10:39:14 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 42D6F206AF;
 Mon, 18 Aug 2025 10:39:14 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [EXTERNAL] Re: [PATCH v4 1/1] ethdev: add support to provide link
 type
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 18 Aug 2025 10:39:11 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE44@smartserver.smartshare.dk>
In-Reply-To: <3f847399-a91c-a6c1-48db-33f83fca9994@arknetworks.am>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [EXTERNAL] Re: [PATCH v4 1/1] ethdev: add support to provide
 link type
Thread-Index: AdwQF/45OEPFzHfYQO+xjZeDn6ck0gAAOWww
References: <20250813084508.1446318-1-skori@marvell.com>
 <20250814081215.1904078-1-skori@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE35@smartserver.smartshare.dk>
 <20250814091556.6db159d0@hermes.local>
 <CO6PR18MB3860FCC393EF51C8664B364BB431A@CO6PR18MB3860.namprd18.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE41@smartserver.smartshare.dk>
 <3f847399-a91c-a6c1-48db-33f83fca9994@arknetworks.am>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Ivan Malov" <ivan.malov@arknetworks.am>
Cc: "Sunil Kumar Kori" <skori@marvell.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>,
 "Thomas Monjalon" <thomas@monjalon.net>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>,
 "Nithin Kumar Dabilpuram" <ndabilpuram@marvell.com>
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

PiBGcm9tOiBJdmFuIE1hbG92IFttYWlsdG86aXZhbi5tYWxvdkBhcmtuZXR3b3Jrcy5hbV0NCj4g
U2VudDogTW9uZGF5LCAxOCBBdWd1c3QgMjAyNSAxMC4xMw0KPiANCj4gSGkgTW9ydGVuLA0KPiAN
Cj4gT24gTW9uLCAxOCBBdWcgMjAyNSwgTW9ydGVuIEJyw7hydXAgd3JvdGU6DQo+IA0KPiA8c25p
cD4NCj4gDQo+ID4NCj4gPiBFdGh0b29sIGhhcyBib3RoIE5PTkUgYW5kIE9USEVSOg0KPiA+DQo+
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9uZXR3b3JrL2V0aHRvb2wvZXRodG9vbC5n
aXQvdHJlZS91YXBpL2xpbnV4L2V0aA0KPiB0b29sLmgjbjIyNDINCj4gPg0KPiA+IEV0aHRvb2wg
ZG9lc24ndCBoYXZlIGEgM3JkIHZhbHVlIFVOS05PV04sIGFuZCBJIHRoaW5rIGhhdmluZyBhIDNy
ZCB2YWx1ZQ0KPiBjb21wbGljYXRlcyB0aGluZ3MgdG9vIG11Y2guDQo+ID4NCj4gPiBJIHN0aWxs
IHRoaW5rIHdlIHNob3VsZCBjb25zaWRlciBPVEhFUj09VU5LTk9XTiwgYW5kIHRoYXQgTk9ORSAo
aGF2aW5nIG5vDQo+IGNvbm5lY3RvcikgY2Fubm90IGhhcHBlbiBhbmQgdGh1cyBzaG91bGQgYmUg
b21pdHRlZC4NCj4gPiBIYXZpbmcgbW9yZSB0aGFuIG9uZSBvZiB0aGVzZSBhZGRzIGNvbXBsZXhp
dHksIGFuZCBJIGZhaWwgdG8gc2VlIHRoZQ0KPiBiZW5lZml0Lg0KPiANCj4gSSBjYW4gaW1hZ2lu
ZSB0aGUgdXNlciBoYXZpbmcgYSAyLXBvcnQgTklDIChhbmQgMiBQRnMgZXhwb3NlZCB0byB0aGUg
aG9zdCBieQ0KPiBkZWZhdWx0KSwgd2l0aCBvbmx5IHRoZSAxc3QgcG9ydCBoYXZpbmcgYSBjYWJs
ZSBwbHVnZ2VkIGludG8gaXQsIHdoZXJlIHNvbWUNCj4gdHJhZmZpYyByZWNlaXZlZCBieSB0aGUg
MXN0IHBvcnQgaXMgaW50ZXJjZXB0ZWQgYnkgYSAndHJhbnNmZXInIGZsb3cgcnVsZSB0bw0KPiBi
ZQ0KPiByZWRpcmVjdGVkIHRvIHRoZSAybmQgUEYuIFdoaWxlIHRoZSAybmQgUEYgaW4gdGhpcyBj
YXNlIHNlcnZlcyBzb21lIGZyYWN0aW9uDQo+IG9mDQo+IHRyYWZmaWMsIGl0cyBMSU5LX1RZUEUg
KG9yLCBtYXliZSBMSU5LX1RFQ0gpIGlzIHN0aWxsICdOT05FJywgYXMgaXRzIG93bg0KPiBhc3Nv
Y2lhdGVkIG5ldHdvcmsgcG9ydCAodGhlIDJuZCBwb3J0KSBoYXMgZ290IG5vIGNhYmxlLg0KDQpJ
biB0aGlzIHNjZW5hcmlvLCBhbHRob3VnaCB0aGUgMm5kIHBvcnQgaGFzIG5vIHNvY2tldCB0byBw
bHVnL3VucGx1ZyBhIGNhYmxlLCBJIHdvdWxkIGNvbnNpZGVyIHRoZSAybmQgcG9ydCBhcyBjb25u
ZWN0ZWQgYnkgaW50ZXJuYWwgKG9uLWNoaXApIHdpcmVzLCBhbmQgdXNlIHRoZSAiT1RIRVIiIGNv
bm5lY3RvciB0eXBlIHRvIGRlc2NyaWJlIHRoYXQgb24tY2hpcCBjb25uZWN0aW9uLg0KDQpCdXQg
d2hhdCBoYXBwZW5zIGlmIGEgY2FibGUgaXMgYWxzbyBwbHVnZ2VkIGludG8gdGhlIDJuZCBwb3J0
Li4uIG5vdyBpdCBoYXMgdHdvIGNvbm5lY3RvcnMgc2ltdWx0YW5lb3VzbHkuIFRoZSBzYW1lIGNv
dWxkIG9jY3VyIHRvIGEgTklDIHRoYXQgaXMgZXhwb3NlZCB0byBEUERLIGFzIGEgc2luZ2xlIHBv
cnQsIGJ1dCBpcyBhY3R1YWxseSBjb25uZWN0ZWQgdmlhIGEgcG9ydCBtdWx0aXBsZXhlciAoZS5n
LiBhIDUtcG9ydCBzd2l0Y2ggY2hpcCkgdG8gbXVsdGlwbGUgcGh5c2ljYWwgcG9ydHMuDQoNCj4g
DQo+IEFsc28sIHBlcmhhcHMgcG9ydCByZXByZXNlbnRvcnMgZm9yIFZGcyB0aGF0IGNhbiBhY3Qg
YXMgJ3BhdGNoIHBhbmVsJyB0bywgc2F5LA0KPiBzZXQgTVRVIG9uIHRoZSB0YXJnZXQgVkYsIGJ1
dCBkbyBub3QgZXhwb3NlIFJ4L1R4IHRvIHRoZSBEUERLIGFwcGxpY2F0aW9uIGNhbg0KPiBoYXZl
IHRoZSBsaW5rIHR5cGUgaW5kaWNhdGUgJ05PTkUnLCBidXQgdGhpcyBpcyBhIGJpdCBvZiBhIHN0
cmV0Y2gsIG9mIGNvdXJzZS4NCg0KWWVhaCwgIk5PTkUiIG1pZ2h0IGJlIGFwcHJvcHJpYXRlIGhl
cmUuDQpTbyB0aGUgcXVlc3Rpb24gaXM6IElmICJOT05FIiBpcyBvbmx5IHJlbGV2YW50IGZvciBl
eG90aWMgY2FzZXMgbGlrZSB0aGlzLCBzaG91bGQgd2Ugb21pdCBpdCBmb3Igc2ltcGxpY2l0eT8N
Cg0KPiANCj4gTWF5YmUgSSdtIHZlcnkgd3JvbmcgaW4gZmFjdCwgc28gZmVlbCBmcmVlIHRvIGRp
c3JlZ2FyZCBteSBub3Rlcy4NCg0KR29vZCwgY3JlYXRpdmUgaW5wdXQhDQoNCj4gDQo+IFRoYW5r
IHlvdS4NCj4gDQo+ID4NCj4gPiAiQmVjYXVzZSBFdGh0b29sIGFsc28gaGFzIE5PTkUiIGlzIG5v
dCBhIGdvb2QgYXJndW1lbnQuIExpbnV4IGhhcyBwbGVudHkgb2YNCj4gb2Jzb2xldGUgc3R1ZmYs
IHdoaWNoIHdlIGRvbid0IG5lZWQgdG8gY29weSB0byBEUERLLg0KPiA+IEhvd2V2ZXIsIHJlZmVy
cmluZyB0byB0aGUgcmVhc29uIHdoeSBFdGh0b29sIGFsc28gaGFzIE5PTkUgKGluIGFkZGl0aW9u
IHRvDQo+IE9USEVSKSBtaWdodCByZXZlYWwgYSB2YWxpZCBhcmd1bWVudCBmb3IgaGF2aW5nIGl0
IGluIERQREsgdG9vLg0KPiA+DQo+ID4gQW55d2F5LCBpZiB3ZSBoYXZlIG1vcmUgdGhhbiBvbmUg
dmFsdWUgKGluIGFkZGl0aW9uIHRvIHRoZSBhY3R1YWwgcGh5c2ljYWwNCj4gY29ubmVjdG9yIHZh
bHVlcyksIHRoZXkgbmVlZCBnb29kIGRlc2NyaXB0aW9ucywgc28gaXQgaXMgY3J5c3RhbCBjbGVh
ciB3aGF0DQo+IHRoZSBkaWZmZXJlbmNlIGlzIGJldHdlZW4gTk9ORSBhbmQgT1RIRVIgKGFuZCBV
TktOT1dOLCBpZiB3ZSBwcm9jZWVkIHdpdGggdGhpcw0KPiAzcmQgdmFsdWUpLg0KPiA+DQo+ID4N
Cg==
