Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FE8C55822
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 05:56:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA21B40144;
	Wed,  5 Aug 2026 07:56:15 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B79B84003C
 for <dev@dpdk.org>; Wed,  5 Aug 2026 07:56:14 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 883AB2051A;
 Wed,  5 Aug 2026 07:56:14 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [PATCH] eal/x86: optimize memcpy of small 64-byte blocks
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 5 Aug 2026 07:56:13 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659BD@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <6f474724bc22441a8a4f516f3398ca76@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] eal/x86: optimize memcpy of small 64-byte blocks
Thread-Index: AQHdJB42oNL4gJj070KJtRurBEIGmLaN+WoAgAAJXwCAAOt0oIAABRpA
References: <20260804143305.1344327-1-mb@smartsharesystems.com>
 <20260804085210.74763eb5@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F659B8@smartserver.smartshare.dk>
 <6f474724bc22441a8a4f516f3398ca76@huawei.com>
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
d2VpLmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCA1IEF1Z3VzdCAyMDI2IDA3LjQ2DQo+IA0KPiA+
ID4gRnJvbTogU3RlcGhlbiBIZW1taW5nZXIgW21haWx0bzpzdGVwaGVuQG5ldHdvcmtwbHVtYmVy
Lm9yZ10NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIDQgQXVndXN0IDIwMjYgMTcuNTINCj4gPiA+DQo+
ID4gPiBPbiBUdWUsICA0IEF1ZyAyMDI2IDE0OjMzOjA0ICswMDAwDQo+ID4gPiBNb3J0ZW4gQnLD
uHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiA+ICsJ
LyogQ29tbW9uIHdheSBmb3Igc21hbGwgY29weSBzaXplIG9mIDY0LWJ5dGUgYmxvY2tzLg0KPiBV
bmxpa2VseSwgc28NCj4gPiA+IGNvbnN0YW50IHNpemUgb25seSAqLw0KPiA+ID4gPiArCWlmIChf
X3J0ZV9jb25zdGFudChuKSAmJiAobiAmIDYzKSA9PSAwICYmIG4gPD0NCj4gPiA+IFJURV9NRU1D
UFlfQkxPQ0tfNjRfTUFYKSB7DQo+ID4gPiA+ICsJCXZvaWQgKnJldCA9IGRzdDsNCj4gPiA+ID4g
Kw0KPiA+ID4NCj4gPiA+IE1heWJlIGp1c3QgbGV0IGNvbXBpbGVyIGRlY2lkZSwgaXQgd2lsbCBn
ZW5lcmF0ZSB2ZWN0b3INCj4gaW5zdHJ1Y3Rpb25zIGluDQo+ID4gPiBtb3N0IGNhc2VzLg0KPiA+
ID4NCj4gPiA+IAlpZiAoX19ydGVfY29uc3RhbnQobikpDQo+ID4gPiAJCXJldHVybiBtZW1wY3B5
KGRzdCwgc3JjLCBuKTsNCj4gPg0KPiA+IE1heWJlIGluIG1vc3QsIGJ1dCBub3QgaW4gYWxsOg0K
PiA+IGh0dHBzOi8vZ29kYm9sdC5vcmcvei9LdmRLcVQ1clkNCj4gDQo+IFdpdGggJy1tYXZ4JyBv
ciAnLW1hdng1MTJmJyBpdCBsb29rcyBsaWtlIGl0IGRvZXMgZm9yIHlvdXIgc2FtcGxlIGNvZGUu
DQoNCkl0IGFsc28gZG9lcyB3aXRoIC1tc3NlNC4yIHdoZW4gU1ogaXMgcmVkdWNlZCB0byAyNTYg
Ynl0ZXMuDQpDbGFuZyBzd2l0Y2hlcyB0byBpbmxpbmUgd2hlbiBTWiBpcyByZWR1Y2VkIHRvIDEy
OCBieXRlcy4NCg0KSXQgc2VlbXMgdGhlIGNvbXBpbGVyIGhhcyBhIHRocmVzaG9sZCBmb3Igd2hl
biB0byBpbmxpbmUgYW5kIHdoZW4gdG8gY2FsbCB0aGUgQyBsaWJyYXJ5J3MgbWVtY3B5IHN1YnJv
dXRpbmUuDQpUaGUgdGhyZXNob2xkIGRlcGVuZHMgb24gYm90aCBjb3B5IHNpemUgYW5kIHZlY3Rv
ciByZWdpc3RlciBzaXplLg0KQW5kIGl0IGlzIGNvbXBpbGVyIGRlcGVuZGVudC4NCg0KV2l0aCBy
dGVfbWVtY3B5KCkgaXQgaXMgYWx3YXlzIGlubGluZS4NCg0K
