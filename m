Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6054EEDB7CA
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 08:44:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0002340293;
	Tue,  7 Apr 2026 10:44:50 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id CA2314028E
 for <dev@dpdk.org>; Tue,  7 Apr 2026 10:44:49 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7FE4D2041E;
 Tue,  7 Apr 2026 10:44:47 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] doc: add link to mbuf layout history
Date: Tue, 7 Apr 2026 10:44:45 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657D8@smartserver.smartshare.dk>
In-Reply-To: <20260407080544.614206-1-thomas@monjalon.net>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] doc: add link to mbuf layout history
Thread-Index: AdzGZW8U7nqNbV/pS8OnZhE2myEeHAABPexQ
References: <20260407080544.614206-1-thomas@monjalon.net>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
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

PiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0bzp0aG9tYXNAbW9uamFsb24ubmV0XQ0KPiBT
ZW50OiBUdWVzZGF5LCA3IEFwcmlsIDIwMjYgMTAuMDYNCj4gDQo+IEluIG9yZGVyIHRvIGlsbHVz
dHJhdGUgaG93IG1idWYgaXMga2VwdCBzbWFsbCwNCj4gYWRkIGEgbGluayB0byBhIHBhZ2Ugc2hv
d2luZyB0aGUgbWJ1ZiBsYXlvdXQgZm9yIGVhY2ggdmVyc2lvbi4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFRob21hcyBNb25qYWxvbiA8dGhvbWFzQG1vbmphbG9uLm5ldD4NCj4gLS0tDQo+ICBkb2Mv
Z3VpZGVzL3Byb2dfZ3VpZGUvbWJ1Zl9saWIucnN0IHwgMTEgKysrKysrLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZG9jL2d1aWRlcy9wcm9nX2d1aWRlL21idWZfbGliLnJzdA0KPiBiL2RvYy9ndWlkZXMv
cHJvZ19ndWlkZS9tYnVmX2xpYi5yc3QNCj4gaW5kZXggMzgyYmZiZGNhNC4uOTdmOGU3MjM1NiAx
MDA2NDQNCj4gLS0tIGEvZG9jL2d1aWRlcy9wcm9nX2d1aWRlL21idWZfbGliLnJzdA0KPiArKysg
Yi9kb2MvZ3VpZGVzL3Byb2dfZ3VpZGUvbWJ1Zl9saWIucnN0DQo+IEBAIC04LDExICs4LDEyIEBA
IFRoZSBQYWNrZXQgKE1CdWYpIGxpYnJhcnkgcHJvdmlkZXMgdGhlIGFiaWxpdHkgdG8NCj4gYWxs
b2NhdGUgYW5kIGZyZWUgYnVmZmVycyAobWJ1DQo+ICB0aGF0IG1heSBiZSB1c2VkIGJ5IHRoZSBE
UERLIGFwcGxpY2F0aW9uIHRvIHN0b3JlIG1lc3NhZ2UgYnVmZmVycy4NCj4gIFRoZSBtZXNzYWdl
IGJ1ZmZlcnMgYXJlIHN0b3JlZCBpbiBhIG1lbXBvb2wsIHVzaW5nIHRoZQ0KPiA6ZG9jOmBtZW1w
b29sX2xpYmAuDQo+IA0KPiAtQSBydGVfbWJ1ZiBzdHJ1Y3QgZ2VuZXJhbGx5IGNhcnJpZXMgbmV0
d29yayBwYWNrZXQgYnVmZmVycywgYnV0IGl0IGNhbg0KPiBhY3R1YWxseQ0KPiAtYmUgYW55IGRh
dGEgKGNvbnRyb2wgZGF0YSwgZXZlbnRzLCAuLi4pLg0KPiAtVGhlIHJ0ZV9tYnVmIGhlYWRlciBz
dHJ1Y3R1cmUgaXMga2VwdCBhcyBzbWFsbCBhcyBwb3NzaWJsZSBhbmQNCj4gY3VycmVudGx5IHVz
ZXMNCj4gLWp1c3QgdHdvIGNhY2hlIGxpbmVzLCB3aXRoIHRoZSBtb3N0IGZyZXF1ZW50bHkgdXNl
ZCBmaWVsZHMgYmVpbmcgb24NCj4gdGhlIGZpcnN0DQo+IC1vZiB0aGUgdHdvIGNhY2hlIGxpbmVz
Lg0KPiArQSBgYHN0cnVjdCBydGVfbWJ1ZmBgIGdlbmVyYWxseSBjYXJyaWVzIG5ldHdvcmsgcGFj
a2V0IGJ1ZmZlcnMsDQo+ICtidXQgaXQgY2FuIGFjdHVhbGx5IGJlIGFueSBkYXRhIChjb250cm9s
IGRhdGEsIGV2ZW50cywgZXRjKS4NCj4gK1RoZSBgYHJ0ZV9tYnVmYGAgaGVhZGVyIHN0cnVjdHVy
ZSBpcw0KPiArYGtlcHQgYXMgc21hbGwgYXMgcG9zc2libGUNCj4gPGh0dHBzOi8vZG9jLmRwZGsu
b3JnL3N0cnVjdC9tYnVmL2hpc3RvcnkuaHRtbD5gXw0KPiArYW5kIGN1cnJlbnRseSB1c2VzIGp1
c3QgdHdvIDY0LWJ5dGUgY2FjaGUgbGluZXMsDQo+ICt3aXRoIHRoZSBtb3N0IGZyZXF1ZW50bHkg
dXNlZCBmaWVsZHMgYmVpbmcgb24gdGhlIGZpcnN0IG9mIHRoZSB0d28NCj4gY2FjaGUgbGluZXMu
DQo+IA0KPiAgRGVzaWduIG9mIFBhY2tldCBCdWZmZXJzDQo+ICAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gLS0NCj4gMi41My4wDQoNCkhhZG4ndCBub3RpY2VkIHRoYXQgaWxsdXN0cmF0aW9u
IGJlZm9yZSwgc28gZ29vZCBpZGVhIGxpbmtpbmcgdG8gaXQgaGVyZS4NCg0KQWNrZWQtYnk6IE1v
cnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQoNCg==
