Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE966CFC509
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 21:36:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCA9140280;
	Fri, 21 Nov 2025 22:36:35 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5216740269
 for <dev@dpdk.org>; Fri, 21 Nov 2025 22:36:34 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2560D20C26;
 Fri, 21 Nov 2025 22:36:34 +0100 (CET)
Content-class: urn:content-classes:message
Subject: RE: [PATCH v2] eal/x86: optimize memcpy of small sizes
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Fri, 21 Nov 2025 22:36:33 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65581@smartserver.smartshare.dk>
In-Reply-To: <20251121091159.4783d97b@phoenix.local>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2] eal/x86: optimize memcpy of small sizes
Thread-Index: AdxbCfU+hyJqm87mTUWDhRz0RYQTGAAG/2Dw
References: <20251120114554.950287-1-mb@smartsharesystems.com><20251121103535.1273457-1-mb@smartsharesystems.com><20251121085730.51f0466a@phoenix.local><aSCbGWNQ7dr7EE7A@bricha3-mobl1.ger.corp.intel.com>
 <20251121091159.4783d97b@phoenix.local>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, "Konstantin Ananyev" <konstantin.v.ananyev@yandex.ru>,
 "Vipin Varghese" <vipin.varghese@amd.com>
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

PiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3BsdW1iZXIu
b3JnXQ0KPiBTZW50OiBGcmlkYXksIDIxIE5vdmVtYmVyIDIwMjUgMTguMTINCj4gDQo+IE9uIEZy
aSwgMjEgTm92IDIwMjUgMTc6MDI6MTcgKzAwMDANCj4gQnJ1Y2UgUmljaGFyZHNvbiA8YnJ1Y2Uu
cmljaGFyZHNvbkBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiA+IEFzIEkgaGF2ZSBzYWlkIGJl
Zm9yZSB3b3VsZCByYXRoZXIgdGhhdCBEUERLIG1vdmUgYXdheSBmcm9tIGhhdmluZw0KPiBpdHMN
Cj4gPiA+IG93biBzcGVjaWFsaXplZCBtZW1jcHkuICBIb3cgaXMgdGhpcyBjb21wYXJlZCB0byBz
dG9jayBpbmxpbmUgZ2NjPw0KDQpUaGUgIi4vYnVpbGQvYXBwL3Rlc3QvZHBkay10ZXN0IG1lbWNw
eV9wZXJmX2F1dG90ZXN0IiBjb21wYXJlcyB0byBzdGFuZGFyZCBtZW1jcHkoKS4NCg0KT24gbXkg
YnVpbGQgc3lzdGVtLCBjb3BpZXMgdXAgdG8gNjQgYnl0ZXMgKHdpdGggc2l6ZSBub3Qga25vd24g
YXQgYnVpbGQgdGltZSkgdGFrZSA5IGN5Y2xlcyB1c2luZyBtZW1jcHkoKSB2cy4gMi00IGN5Y2xl
cyB1c2luZyBydGVfbWVtY3B5KCkuDQoNClRoZSBnZW5lcmFsIGRpZmZlcmVuY2Ugd2FzIHByb2Jh
Ymx5IHdvcnNlIHdpdGggb2xkZXIgY29tcGlsZXJzLg0KV2Ugc2hvdWxkIGNvbXBhcmUgdXNpbmcg
dGhlIG9sZGVzdCBjb21waWxlciB2ZXJzaW9ucyBvZmZpY2lhbGx5IHN1cHBvcnRlZCBieSBEUERL
LiAoR0NDLCBDbGFuZywgTVNWQywgLi4uKSBBbmQgYWNyb3NzIHRoZSBzdXBwb3J0ZWQgQ1BVcy4N
Cg0KVGhlcmUgYXJlIHBsZW50eSBvZiBvcHRpbWl6YXRpb25zIGluIERQREssIHdoaWNoIHdlcmUg
cmVsZXZhbnQgYXQgdGhlIHRpbWUgb2YgYWRkaXRpb24sIGJ1dCBoYXZlIGJlY29tZSBvYnNvbGV0
ZSBvdmVyIHRpbWUuDQpJIGRvbid0IHRoaW5rIHJ0ZV9tZW1jcHkoKSBpcyB0aGVyZSB5ZXQuIChH
dXQgZmVlbGluZywgbm8gZGF0YSB0byBiYWNrIGl0IHVwIHdpdGghKQ0KVW50aWwgd2UgZ2V0IHRo
ZXJlLCB3ZSBzaG91bGQga2VlcCBvcHRpbWl6aW5nIHJ0ZV9tZW1jcHkoKS4NCg0KRm9yIGFueSBw
ZXItcGFja2V0IG9wZXJhdGlvbiwgc2hhdmluZyBvZmYgYSBmZXcgY3ljbGVzIGlzIHZhbHVhYmxl
Lg0KQW5kIGlmIHRoZSBtYWpvcml0eSBvZiBhbiBhcHBsaWNhdGlvbidzIGNvcHkgb3BlcmF0aW9u
cyBwZXIgcGFja2V0IGFyZSBtb3JlIHRoYW4gYSBmZXcgYnl0ZXMsIHRoZSBhcHBsaWNhdGlvbiB3
aWxsIG5vdCBhY2hpZXZlIGhpZ2ggcGVyZm9ybWFuY2UuDQpUaHVzLCBJIHRoaW5rIG9wdGltaXpp
bmcgc21hbGwgY29waWVzIGlzIHJlbGV2YW50OiBBIG5vcm1hbCBEUERLIGFwcGxpY2F0aW9uIHNo
b3VsZCBwZXJmb3JtIG1hbnkgbW9yZSBzbWFsbCBjb3BpZXMgdGhhbiBsYXJnZSBjb3BpZXMuIChN
ZWFzdXJlZCBieSBudW1iZXIgb2YgY29weSBvcGVyYXRpb25zLCBub3QgbnVtYmVyIG9mIGNvcGll
ZCBieXRlcy4pDQoNCj4gPiA+IFRoZSBtYWluIG1vdGl2YXRpb24gaXMgdGhhdCB0aGUgZ2xpYmMv
Z2NjIHRlYW0gZG9lcyBtb3JlIHRlc3RpbmcNCj4gYWNyb3NzDQo+ID4gPiBtdWx0aXBsZSBhcmNo
aXRlY3R1cmVzIGFuZCBoYXMgYSBjb21tdW5pdHkgd2l0aCBtb3JlIGV4cGVydGlzZSBvbg0KPiBD
UFUNCj4gPiA+IHNwZWNpYWwgY2FzZXMuDQo+ID4NCj4gPiBJIHdvdWxkIHRlbmQgdG8gYWdyZWUu
IEV2ZW4gaWYgd2UgZ2V0IHJ0ZV9tZW1jcHkgYSBmZXcgY3ljbGVzIGZhc3RlciwNCj4gSQ0KPiA+
IHN1c3BlY3QgbWFueSBhcHBzIHdvdWxkbid0IG5vdGljZSB0aGUgZGlmZmVyZW5jZS4gSG93ZXZl
ciwgSQ0KPiB1bmRlcnN0YW5kDQo+ID4gdGhhdCB0aGUgdmlydGlvL3Zob3N0IGxpYnJhcmllcyBn
YWluIGZyb20gdXNpbmcgcnRlX21lbWNweSBvdmVyDQo+IHN0YW5kYXJkDQo+ID4gbWVtY3B5IC0g
b3IgYXQgbGVhc3QgdXNlZCB0by4gUGVyaGFwcyB3ZSBjYW4gY29uc2lkZXIgZGVwcmVjYXRpbmcN
Cj4gPiBydGVfbWVtY3B5IGFuZCBqdXN0IHB1dHRpbmcgYSB2aG9zdC1zcGVjaWZpYyBtZW1jcHkg
aW4gdGhhdCBsaWJyYXJ5Pw0KPiANCj4gSXQgd291bGQgYmUgZ29vZCB0byBmaWd1cmUgb3V0IHdo
eSB2aG9zdCBpcyBiZXR0ZXIgd2l0aCBydGVfbWVtY3B5LA0KPiBtYXliZSB0aGVyZSBpcyBzb21l
IGFsaWdubWVudCBhc3N1bXB0aW9uIHRoYXQgaXMgaW4gb25lIGFuZCBub3QgdGhlDQo+IG90aGVy
Pw0KDQpMb29raW5nIGF0IDEwMjQgYnl0ZXMgY29weSBvbiBteSBidWlsZCBzeXN0ZW0sDQpjYWNo
ZS10by1tZW0gaXMgMTIgJSBmYXN0ZXIgd2l0aCBydGVfbWVtY3B5KCksIGFuZA0KbWVtLXRvLWNh
Y2hlIGlzIDEwICUgc2xvd2VyLg0KDQpNYXliZSB0aGUgdmhvc3QgbGlicmFyeSB3b3VsZCBiZW5l
Zml0IGZyb20gaGF2aW5nIGFjY2VzcyB0byB0d28gcnRlX21lbWNweSB2YXJpYW50cywgcmVzcGVj
dGl2ZWx5IG9wdGltaXplZCBmb3IgY2FjaGUtdG8tbWVtIGFuZCBtZW0tdG8tY2FjaGUuDQoNClRo
ZXJlIHdpbGwgYWx3YXlzIGJlIHNvbWUgdXNlIGNhc2VzIHdoZXJlIGEgZ2VuZXJpYyAib3B0aW1p
emVkIiBydGVfbWVtY3B5KCkgd2lsbCBiZSBzdWJvcHRpbWFsLg0KDQpQcm92aWRpbmcgc3BlY2lm
aWMgZnVuY3Rpb25zIG9wdGltaXplZCBmb3Igc3BlY2lmaWMgdXNlIGNhc2VzIG1ha2VzIHJlYWxs
eSBnb29kIHNlbnNlLg0KDQo=
