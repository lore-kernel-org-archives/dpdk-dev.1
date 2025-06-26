Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA55C7EE32
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 15:44:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACACE40276;
	Thu, 26 Jun 2025 17:44:03 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D52DE40156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 17:44:02 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id AA39B2045F;
 Thu, 26 Jun 2025 17:44:02 +0200 (CEST)
Subject: RE: [PATCH] net/null: Add fast mbuf release TX offload
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Date: Thu, 26 Jun 2025 17:44:01 +0200
Content-Transfer-Encoding: base64
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD49@smartserver.smartshare.dk>
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20250626070557.33058157@hermes.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net/null: Add fast mbuf release TX offload
Thread-Index: Advmo3MhznlEgk49TcKAwd7u/TRcjwADCj0A
References: <20250624181416.167181-1-mb@smartsharesystems.com>
 <20250626070557.33058157@hermes.local>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: "Tetsuya Mukawa" <mtetsuyah@gmail.com>,
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

PiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3BsdW1iZXIu
b3JnXQ0KPiBTZW50OiBUaHVyc2RheSwgMjYgSnVuZSAyMDI1IDE2LjA2DQo+IA0KPiBPbiBUdWUs
IDI0IEp1biAyMDI1IDE4OjE0OjE2ICswMDAwDQo+IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNo
YXJlc3lzdGVtcy5jb20+IHdyb3RlOg0KPiANCj4gPiBBZGRlZCBmYXN0IG1idWYgcmVsZWFzZSwg
cmUtdXNpbmcgdGhlIGV4aXN0aW5nIG1idWYgcG9vbCBwb2ludGVyDQo+ID4gaW4gdGhlIHF1ZXVl
IHN0cnVjdHVyZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1vcnRlbiBCcsO4cnVwIDxtYkBz
bWFydHNoYXJlc3lzdGVtcy5jb20+DQo+IA0KPiBNYWtlcyBzZW5zZS4NCj4gDQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvbmV0L251bGwvcnRlX2V0aF9udWxsLmMgfCAzMCArKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvbnVsbC9ydGVf
ZXRoX251bGwuYw0KPiBiL2RyaXZlcnMvbmV0L251bGwvcnRlX2V0aF9udWxsLmMNCj4gPiBpbmRl
eCA4YTliNzRhMDNiLi4xMmMwZDhkMWZmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L251
bGwvcnRlX2V0aF9udWxsLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9udWxsL3J0ZV9ldGhfbnVs
bC5jDQo+ID4gQEAgLTM0LDYgKzM0LDE3IEBAIHN0cnVjdCBwbWRfaW50ZXJuYWxzOw0KPiA+ICBz
dHJ1Y3QgbnVsbF9xdWV1ZSB7DQo+ID4gIAlzdHJ1Y3QgcG1kX2ludGVybmFscyAqaW50ZXJuYWxz
Ow0KPiA+DQo+ID4gKwkvKioNCj4gPiArCSAqIEZvciBSWCBxdWV1ZToNCj4gPiArCSAqICBNZW1w
b29sIHRvIGFsbG9jYXRlIG1idWZzIGZyb20uDQo+ID4gKwkgKg0KPiA+ICsJICogRm9yIFRYIHF1
ZXVlOg0KPiA+ICsJICogIE1lbXBvb2wgdG8gZnJlZSBtYnVmcyB0bywgaWYgZmFzdCByZWxlYXNl
IG9mIG1idWZzIGlzIGVuYWJsZWQuDQo+ID4gKwkgKiAgVUlOVFBUUl9NQVggaWYgdGhlIG1lbXBv
b2wgZm9yIGZhc3QgcmVsZWFzZSBvZiBtYnVmcyBoYXMgbm90DQo+IHlldCBiZWVuIGRldGVjdGVk
Lg0KPiA+ICsJICogIE5VTEwgaWYgZmFzdCByZWxlYXNlIG9mIG1idWZzIGlzIG5vdCBlbmFibGVk
Lg0KPiA+ICsJICoNCj4gPiArCSAqICBAc2VlIFJURV9FVEhfVFhfT0ZGTE9BRF9NQlVGX0ZBU1Rf
RlJFRQ0KPiA+ICsJICovDQo+ID4gIAlzdHJ1Y3QgcnRlX21lbXBvb2wgKm1iX3Bvb2w7DQo+IA0K
PiBEbyBhbGwgZHJpdmVycyB0byBpdCB0aGlzIHdheT8NCg0KTm8sIEkgdGhpbmsgbW9zdCBkcml2
ZXJzIGhhdmUgc2VwYXJhdGUgc3RydWN0dXJlcyBmb3IgcnggYW5kIHR4IHF1ZXVlcy4gVGhpcyBk
cml2ZXIgZG9lc24ndCBzbyBJJ20gcmV1c2luZyB0aGUgZXhpc3RpbmcgbWVtcG9vbCBwb2ludGVy
Lg0KQWxzbywgdGhleSBkb24ndCBjYWNoZSB0aGUgbWVtcG9vbCBwb2ludGVyLCBidXQgbG9vayBh
dCBtYnVmWzBdLnBvb2wgYXQgZXZlcnkgYnVyc3Q7IHNvIHRoZWlyIHR4IHF1ZXVlIHN0cnVjdHVy
ZSBkb2Vzbid0IGhhdmUgYSBtZW1wb29sIHBvaW50ZXIgZmllbGQuDQpBbmQgdGhleSBjaGVjayBh
biBvZmZsb2FkIGZsYWcgKGVpdGhlciB0aGUgYml0IGluIHRoZSByYXcgb2ZmbG9hZCBmaWVsZCwg
b3IgYSBzaGFkb3cgdmFyaWFibGUgZm9yIHRoZSByZWxldmFudCBvZmZsb2FkIGZsYWcpLCBpbnN0
ZWFkIG9mIGNoZWNraW5nIHRoZSBtZW1wb29sIHBvaW50ZXIuDQoNCk90aGVyIGRyaXZlcnMgY2Fu
IGJlIGltcHJvdmVkLCBhbmQgSSBoYXZlIHN1Ym1pdHRlZCBhbiBvcHRpbWl6YXRpb24gcGF0Y2gg
Zm9yIHRoZSBpNDBlIGRyaXZlciB3aXRoIHNvbWUgb2YgdGhlIHRoaW5ncyBJIGRvIGluIHRoaXMg
cGF0Y2g6DQpodHRwczovL2luYm94LmRwZGsub3JnL2Rldi8yMDI1MDYyNDA2MTIzOC44OTI1OS0x
LW1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbS8NCg0KPiBJcyBpdCBkb2N1bWVudGVkIGluIGV0aGRl
dj8NCg0KVGhlIFJURV9FVEhfVFhfT0ZGTE9BRF9NQlVGX0ZBU1RfRlJFRSBmbGFnIGlzIGRvY3Vt
ZW50ZWQuDQpIb3cgdG8gaW1wbGVtZW50IGl0IGluIHRoZSBkcml2ZXJzIGlzIG5vdC4NCg0KLU1v
cnRlbg0KDQo=
