Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97E9C28B20
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Mar 2025 08:57:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8EAE402AB;
	Sun, 30 Mar 2025 10:57:22 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id BBD4C402A4
 for <dev@dpdk.org>; Sun, 30 Mar 2025 10:57:20 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 6F5F021733;
 Sun, 30 Mar 2025 10:57:20 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] mempool perf test: test random bulk sizes
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sun, 30 Mar 2025 10:57:19 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FB83@smartserver.smartshare.dk>
In-Reply-To: <0ec8a97b-6668-424a-a375-e5c660219835@oktetlabs.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mempool perf test: test random bulk sizes
Thread-Index: AduhTddqTTlnIi23Q+Cf+DDUCJGtcgAAuMCg
References: <20250228164858.274204-1-mb@smartsharesystems.com>
 <0ec8a97b-6668-424a-a375-e5c660219835@oktetlabs.ru>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
Cc: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
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

PiBGcm9tOiBBbmRyZXcgUnliY2hlbmtvIFttYWlsdG86YW5kcmV3LnJ5YmNoZW5rb0Bva3RldGxh
YnMucnVdDQo+IFNlbnQ6IFN1bmRheSwgMzAgTWFyY2ggMjAyNSAxMC4yOQ0KPiANCj4gT24gMi8y
OC8yNSAxOTo0OCwgTW9ydGVuIEJyw7hydXAgd3JvdGU6DQo+ID4gQnVsayByZXF1ZXN0cyB0byBn
ZXQgb3IgcHV0IG9iamVjdHMgaW4gYSBtZW1wb29sIG9mdGVuIHZhcnkgaW4gc2l6ZS4NCj4gPiBB
IHNlcmllcyBvZiB0ZXN0cyB3aXRoIHBzZXVkbyByYW5kb20gcmVxdWVzdCBzaXplcywgdG8gbWl0
aWdhdGUgdGhlDQo+ID4gYmVuZWZpdHMgb2YgdGhlIENQVSdzIGR5bmFtaWMgYnJhbmNoIHByZWRp
Y3Rvciwgd2FzIGFkZGVkLg0KPiA+DQo+ID4gQWxzbywgdmFyaW91cyBvdGhlciBtaW5vciBjaGFu
Z2VzOg0KPiA+IC0gSW1wcm92ZWQgdGhlIG91dHB1dCBmb3JtYXR0aW5nIGZvciByZWFkYWJpbGl0
eS4NCj4gPiAtIEFkZGVkIHRlc3QgZm9yIHRoZSAiZGVmYXVsdCIgbWVtcG9vbCB3aXRoIGNhY2hl
Lg0KPiA+IC0gU2tpcCB0aGUgdGVzdHMgZm9yIHRoZSAiZGVmYXVsdCIgbWVtcG9vbCwgaWYgaXQg
aGFwcGVucyB0byB1c2UgdGhlDQo+IHNhbWUNCj4gPiAgICBkcml2ZXIgKGkuZS4gb3BlcmF0aW9u
cykgYXMgYWxyZWFkeSB0ZXN0ZWQuDQo+ID4gLSBSZXBsYWNlZCBiYXJlIHVzZSBvZiAidW5zaWdu
ZWQiIHdpdGggInVuc2lnbmVkIGludCIsDQo+ID4gICAgdG8gbWFrZSBjaGVja3BhdGNoZXMgaGFw
cHkuDQo+IA0KPiBJTUhPLCBpdCB3b3VsZCBiZSBtdWNoIGJldHRlciBhbmQgZWFzaWVyIHRvIHJl
dmlldyBpZiBhbGwgYWJvdmUgY2hhbmdlcw0KPiBhcmUgZG9uZSBvbmUgYnkgb25lIGluIHNlcGFy
YXRlIHBhdGNoZXMuDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTW9ydGVuIEJyw7hydXAg
PG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCj4gDQo+IE92ZXJhbGwgdGhlIGlkZWEgbG9va3Mg
Z29vZCwgc28NCj4gQWNrZWQtYnk6IEFuZHJldyBSeWJjaGVua28gPGFuZHJldy5yeWJjaGVua29A
b2t0ZXRsYWJzLnJ1Pg0KPiANCj4gYnV0IEknZCBiZSB0aGFua2Z1bCBpZiB5b3Ugc3BsaXQgdGhl
IHBhdGNoLg0KDQpPSy4NCkknbGwgcG9zdCBhIHYyIHdpdGggY2hhbmdlcyBvbmUgYnkgb25lIGlu
IGEgc2VyaWVzIG9mIHBhdGNoZXMuDQo8c2FyY2FzbSBhYm91dCB0aGUgd3JpdGUtb25seSBtYWls
aW5nIGxpc3Q+DQpMZXQncyBob3BlIHNvbWVvbmUgZWxzZSBmaW5kcyB0aGUgc2VyaWVzIG9mIHNp
bXBsZSBwYXRjaGVzIHN1ZmZpY2llbnRseSByZWFkYWJsZSB0byBjYXJlIHRvIHJldmlldy4gOy0p
DQo8L3NhcmNhc20+DQoNClRoYW5rcywgQW5kcmV3Lg0KDQo=
