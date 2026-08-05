Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9734AC55822
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 08:36:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BE2E40144;
	Wed,  5 Aug 2026 10:36:43 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 65EBE4003C
 for <dev@dpdk.org>; Wed,  5 Aug 2026 10:36:41 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 37AD92051A;
 Wed,  5 Aug 2026 10:36:41 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [PATCH] eal/x86: optimize memcpy of small 64-byte blocks
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 5 Aug 2026 10:36:40 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659BF@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <3c7eea01416249e0aaeab0e8b6b4c157@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] eal/x86: optimize memcpy of small 64-byte blocks
Thread-Index: AQHdJB42oNL4gJj070KJtRurBEIGmLaN+WoAgAAJXwCAAOt0oIAABRpAgAAL2ECAAB9NYA==
References: <20260804143305.1344327-1-mb@smartsharesystems.com>
 <20260804085210.74763eb5@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F659B8@smartserver.smartshare.dk>
 <6f474724bc22441a8a4f516f3398ca76@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F659BD@smartserver.smartshare.dk>
 <3c7eea01416249e0aaeab0e8b6b4c157@huawei.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>,
	"Bruce Richardson" <bruce.richardson@intel.com>
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

PiBGcm9tOiBLb25zdGFudGluIEFuYW55ZXYgW21haWx0bzprb25zdGFudGluLmFuYW55ZXZAaHVh
d2VpLmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCA1IEF1Z3VzdCAyMDI2IDA4LjUwDQo+IA0KPiA+
IEZyb206IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQo+ID4gU2Vu
dDogV2VkbmVzZGF5LCBBdWd1c3QgNSwgMjAyNiA2OjU2IEFNDQo+ID4NCj4gPiA+IEZyb206IEtv
bnN0YW50aW4gQW5hbnlldiBbbWFpbHRvOmtvbnN0YW50aW4uYW5hbnlldkBodWF3ZWkuY29tXQ0K
PiA+ID4gU2VudDogV2VkbmVzZGF5LCA1IEF1Z3VzdCAyMDI2IDA3LjQ2DQo+ID4gPg0KPiA+ID4g
PiA+IEZyb206IFN0ZXBoZW4gSGVtbWluZ2VyIFttYWlsdG86c3RlcGhlbkBuZXR3b3JrcGx1bWJl
ci5vcmddDQo+ID4gPiA+ID4gU2VudDogVHVlc2RheSwgNCBBdWd1c3QgMjAyNiAxNy41Mg0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gT24gVHVlLCAgNCBBdWcgMjAyNiAxNDozMzowNCArMDAwMA0KPiA+
ID4gPiA+IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+IHdyb3RlOg0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiArCS8qIENvbW1vbiB3YXkgZm9yIHNtYWxsIGNvcHkgc2l6
ZSBvZiA2NC1ieXRlIGJsb2Nrcy4NCj4gPiA+IFVubGlrZWx5LCBzbw0KPiA+ID4gPiA+IGNvbnN0
YW50IHNpemUgb25seSAqLw0KPiA+ID4gPiA+ID4gKwlpZiAoX19ydGVfY29uc3RhbnQobikgJiYg
KG4gJiA2MykgPT0gMCAmJiBuIDw9DQo+ID4gPiA+ID4gUlRFX01FTUNQWV9CTE9DS182NF9NQVgp
IHsNCj4gPiA+ID4gPiA+ICsJCXZvaWQgKnJldCA9IGRzdDsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IE1heWJlIGp1c3QgbGV0IGNvbXBpbGVyIGRlY2lkZSwgaXQgd2lsbCBn
ZW5lcmF0ZSB2ZWN0b3INCj4gPiA+IGluc3RydWN0aW9ucyBpbg0KPiA+ID4gPiA+IG1vc3QgY2Fz
ZXMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAJaWYgKF9fcnRlX2NvbnN0YW50KG4pKQ0KPiA+ID4g
PiA+IAkJcmV0dXJuIG1lbXBjcHkoZHN0LCBzcmMsIG4pOw0KPiA+ID4gPg0KPiA+ID4gPiBNYXli
ZSBpbiBtb3N0LCBidXQgbm90IGluIGFsbDoNCj4gPiA+ID4gaHR0cHM6Ly9nb2Rib2x0Lm9yZy96
L0t2ZEtxVDVyWQ0KPiA+ID4NCj4gPiA+IFdpdGggJy1tYXZ4JyBvciAnLW1hdng1MTJmJyBpdCBs
b29rcyBsaWtlIGl0IGRvZXMgZm9yIHlvdXIgc2FtcGxlDQo+IGNvZGUuDQo+ID4NCj4gPiBJdCBh
bHNvIGRvZXMgd2l0aCAtbXNzZTQuMiB3aGVuIFNaIGlzIHJlZHVjZWQgdG8gMjU2IGJ5dGVzLg0K
PiA+IENsYW5nIHN3aXRjaGVzIHRvIGlubGluZSB3aGVuIFNaIGlzIHJlZHVjZWQgdG8gMTI4IGJ5
dGVzLg0KPiA+DQo+ID4gSXQgc2VlbXMgdGhlIGNvbXBpbGVyIGhhcyBhIHRocmVzaG9sZCBmb3Ig
d2hlbiB0byBpbmxpbmUgYW5kIHdoZW4gdG8NCj4gY2FsbCB0aGUgQw0KPiA+IGxpYnJhcnkncyBt
ZW1jcHkgc3Vicm91dGluZS4NCj4gPiBUaGUgdGhyZXNob2xkIGRlcGVuZHMgb24gYm90aCBjb3B5
IHNpemUgYW5kIHZlY3RvciByZWdpc3RlciBzaXplLg0KPiA+IEFuZCBpdCBpcyBjb21waWxlciBk
ZXBlbmRlbnQuDQo+IA0KPiBJIHRoaW5rIHRoZXJlIGFyZSBjb21waWxlciBvcHRpb25zIHRvIHNw
ZWNpZnkgZGVzaXJlZCB0aHJlc2hvbGQgdmFsdWVzLg0KPiBMZXQgc2F5IGZvciBnY2MgdGhlcmUg
aXMgICcgLW1tZW1jcHktc3RyYXRlZ3k9c3RyYXRlZ3knLg0KPiBGb3IgdGhhdCBleGFtcGxlIGlu
IHRoYXQgcGFydGljdWxhciBjYXNlDQo+IC1tbWVtY3B5LXN0cmF0ZWd5PXZlY3Rvcl9sb29wOjUx
MjphbGlnbixsb29wOi0xOmFsaWduDQo+IGdlbmVyYXRlcyBzc2UgbG9hZHMvc3RvcmVzLg0KPiBN
aWdodCBiZSB3ZSBjYW4gZXhwbG9pdCBpdCBzb21laG93Pw0KDQpUaGF0IGNvdWxkIGdpdmUgdXMg
aGlnaGVyIGdyYW51bGFyaXR5L2NvbnRyb2wgb3ZlciBtZW1jcHkgZm9yIGluZGl2aWR1YWwgbWVt
Y3B5IGluc3RhbmNlczsgbWlnaHQgYmUgdXNlZnVsIGZvciBob3QgY29kZSBwYXRocyB3aGVyZSB3
ZSBoYXZlIG1vcmUga25vd2xlZGdlIGFib3V0IHRoZSBjb3B5IG9wZXJhdGlvbiB0aGFuIHRoZSBj
b21waWxlciBjYW4gaW5mZXIuDQpIb3dldmVyLCBwcmFnbWFzIGFyZSBkaXNjb3VyYWdlZCBpbiBE
UERLLCBhbmQgdGhpcyBsb29rcyBsaWtlIGEgdmVyeSBzaW1pbGFyIHBhdGguDQoNCj4gSSBhbSBu
b3QgcmVhbGx5IGhhcHB5IHRoYXQgb3VyIGhvbWUtYnJld2VkIG1lbWNweSBjb2RlLWJsb2NrIGtl
ZXBzDQo+IGdyb3dpbmcsDQo+IHdoaWxlIHdlIGtlZXAgdGFsa2luZyB0aGF0IGl0IHdvdWxkIGJl
IGdvb2QgdG8gZWxpbWluYXRlIGl0IGNvbXBsZXRlbHkuDQoNCkkgYWdyZWUgaW4gcHJpbmNpcGxl
Lg0KSG93ZXZlciwgdGhpcyBydGVfbWVtY3B5KCkgb3B0aW1pemF0aW9uIGlzIGZvciB0aGUgcGls
ZS9tZW1wb29sIG9wdGltaXphdGlvbnMgSSdtIHdvcmtpbmcgb24sIHNvIHRoZXJlIGlzIGEgc3Bl
Y2lmaWMgdXNlIGNhc2UgbW90aXZhdGluZyB0aGUgYWRkZWQgY29kZS4NCg0KPiANCj4gDQo+IA0K
PiANCj4gPiBXaXRoIHJ0ZV9tZW1jcHkoKSBpdCBpcyBhbHdheXMgaW5saW5lLg0KDQo=
