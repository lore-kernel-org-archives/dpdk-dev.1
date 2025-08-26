Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33EECA0FE7
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 14:13:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EF6B402E9;
	Tue, 26 Aug 2025 16:13:32 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 70275402D4
 for <dev@dpdk.org>; Tue, 26 Aug 2025 16:13:31 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4173E22D5C;
 Tue, 26 Aug 2025 16:13:31 +0200 (CEST)
Subject: RE: [PATCH v2 3/4] hash: reduce architecture special cases
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Tue, 26 Aug 2025 16:13:29 +0200
Content-class: urn:content-classes:message
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE73@smartserver.smartshare.dk>
In-Reply-To: <20250826064149.25787722@hermes.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 3/4] hash: reduce architecture special cases
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Index: AdwWjzBD/TQC0KK7RsaLb3svTHcvKAAAK7LQ
References: <20250821203646.133506-1-stephen@networkplumber.org><20250822182110.27599-1-stephen@networkplumber.org><20250822182110.27599-4-stephen@networkplumber.org><98CBD80474FA8B44BF855DF32C47DC35E9FE6C@smartserver.smartshare.dk>
 <20250826064149.25787722@hermes.local>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>, "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Yipeng Wang" <yipeng1.wang@intel.com>,
 "Sameh Gobriel" <sameh.gobriel@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>,
 =?UTF-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>
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
b3JnXQ0KPiBTZW50OiBUdWVzZGF5LCAyNiBBdWd1c3QgMjAyNSAxNS40Mg0KPiANCj4gT24gVHVl
LCAyNiBBdWcgMjAyNSAwODo1NToyMyArMDIwMA0KPiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRz
aGFyZXN5c3RlbXMuY29tPiB3cm90ZToNCj4gDQo+ID4gPiArc3RhdGljIGludA0KPiA+ID4gK3J0
ZV9oYXNoX2s2NF9jbXBfZXEoY29uc3Qgdm9pZCAqa2V5MSwgY29uc3Qgdm9pZCAqa2V5Miwgc2l6
ZV90DQo+IGtleV9sZW4pDQo+ID4gPiArew0KPiA+ID4gKwlyZXR1cm4gcnRlX2hhc2hfazMyX2Nt
cF9lcShrZXkxLCBrZXkyLCBrZXlfbGVuKSB8DQo+ID4NCj4gPiBJcyB0aGUgInwiIGluc3RlYWQg
b2YgInx8IiwgdG8gY29tcGFyZSBpbiBibG9ja3Mgb2YgNjQgYnl0ZXMgaW5zdGVhZA0KPiBvZiAz
MiwgaW50ZW50aW9uYWw/DQo+IA0KPiBUaGUgY29zdCBvZiB0aGUgY29uZGl0aW9uYWwgYnJhbmNo
IGlzIHVzdWFsbHkgaGlnaGVyIHRoYW4gdGhlIGNvc3Qgb2YNCj4gZG9pbmcNCj4gYSBmZXcgbW9y
ZSBpbnN0cnVjdGlvbnMgb24gY2FjaGVkIGRhdGEuDQoNCkkgYWdyZWUgdGhlIGtleSBiZWluZyBs
b29rZWQgdXAgaXMgdmVyeSBsaWtlbHkgY2FjaGVkLg0KDQpCdXQgdGhlIGtleSBpbiB0aGUgaGFz
aCB0YWJsZSBtaWdodCBub3QgYmUsIGFuZCB0aGUgNjQgYnl0ZSBjb21wYXJpc29uIG1pZ2h0IGNy
b3NzIGEgY2FjaGUgbGluZS4NCkkgdGhpbmsgdXNpbmcgaGFsZiBhIGNhY2hlIGxpbmUgYXMgdGhl
IGJyZWFrcG9pbnQgKGZvciB1c2luZyBjb25kaXRpb25hbCBicmFuY2ggaW5zdGVhZCBvZiB1bmNv
bmRpdGlvbmFsIGxvYWQgYW5kIGNvbXBhcmUpIHNlZW1zIGxpa2UgYSBiZXR0ZXIgdHJhZGVvZmYg
dGhhbiBhIGZ1bGwgY2FjaGUgbGluZS4gSSBoYXZlIG5vIGRhdGEgdG8gYmFjayB0aGlzIHVwLCBq
dXN0IGEgaHVuY2guDQpJbiByZWFsaXR5LCBpdCBkZXBlbmRzIG9uIHRoZSB1c2UgY2FzZS4gSWYg
YSBjYWNoZSBoaXQgaXMgbW9yZSBsaWtlbHkgdGhhbiBhIGNhY2hlIG1pc3MsIHRoZW4gdGhlIHVu
Y29uZGl0aW9uYWwgY29tcGFyaXNvbiBpcyBwcmVmZXJhYmxlLg0KTm8gc3Ryb25nIG9waW5pb24u
IEkgbWFpbmx5IHdhbnRlZCB0byBlbnN1cmUgdGhpcyB3YXMgaW50ZW50aW9uYWwuDQoNCg0KV2hp
bGUgbG9va2luZyBpbnRvIHRoaXMsIEkgbm90aWNlZCBhIGZldyBpbnN0YW5jZXMgd2hlcmUgeW91
ciBhc3N1bXB0aW9uIGFib3V0IGtleTEgYmVpbmcgYWxpZ25lZCBpcyB3cm9uZywgYW5kIHRoZSBr
ZXkxL2tleTIgcGFyYW1ldGVycyBzaG91bGQgYmUgc3dhcHBlZDoNCmh0dHBzOi8vZWxpeGlyLmJv
b3RsaW4uY29tL2RwZGsvdjI1LjA3L3NvdXJjZS9saWIvaGFzaC9ydGVfY3Vja29vX2hhc2guYyNM
NzYzDQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9kcGRrL3YyNS4wNy9zb3VyY2UvbGliL2hh
c2gvcnRlX2N1Y2tvb19oYXNoLmMjTDEzMTkNCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2Rw
ZGsvdjI1LjA3L3NvdXJjZS9saWIvaGFzaC9ydGVfY3Vja29vX2hhc2guYyNMMTM1Nw0KRS5nLiB3
aGVuIGNhbGxpbmcgcnRlX2hhc2hfYWRkX2tleV93aXRoX2hhc2goKSwgdGhlIGtleSBwYXJhbWV0
ZXIgY2FuIGJlIHVuYWxpZ25lZCwgYW5kIGl0IHJpcHBsZXMgZG93biBhbmQgYmVjb21lcyBrZXkx
Og0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vZHBkay92MjUuMDcvc291cmNlL2xpYi9oYXNo
L3J0ZV9jdWNrb29faGFzaC5jI0wxMjU5DQoNCg==
