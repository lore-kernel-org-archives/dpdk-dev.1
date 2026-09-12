Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB44C88E45
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Sep 2026 06:27:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 852CA4029D;
	Sat, 12 Sep 2026 08:27:01 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 76D2A40281
 for <dev@dpdk.org>; Sat, 12 Sep 2026 08:27:00 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 3CFDA20BA1;
 Sat, 12 Sep 2026 08:26:59 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [RFC] eal: allow setting random number generator seed
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sat, 12 Sep 2026 08:26:54 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A3F@smartserver.smartshare.dk>
In-Reply-To: <20260911225845.3168061-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] eal: allow setting random number generator seed
Thread-Index: Ad1CQSPDdCg2igaQSha82BupZtb01gAPnqoQ
References: <20260911225845.3168061-1-stephen@networkplumber.org>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>
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
b3JnXQ0KPiBTZW50OiBTYXR1cmRheSwgMTIgU2VwdGVtYmVyIDIwMjYgMDAuNTkNCj4gDQo+IE1h
bnkgcGVyZm9ybWFuY2UgdGVzdHMgdXNlIHJ0ZV9yYW5kKCkgYW5kIHRoZSByYW5kb20gbnVtYmVy
DQo+IGNhbiBwZXJ0dXJiIHRoZSByZXN1bHRzLiBBZGQgYW4gYWJpbGl0eSB0byBvdmVyaWRlIHRo
ZSBhdXRvbWF0aWMNCj4gcmFuZG9tIHNlZWQgb24gRFBESyBzdGFydHVwLg0KPiANCj4gVGhpcyBp
cyBub3QgYSBzZWN1cml0eSBwcm9ibGVtIHNpbmNlIHJ0ZV9yYW5kKCkgaXMgZG9jdW1lbnRlZA0K
PiBhcyBub3QgYmVpbmcgY3J5cHRvZ3JhcGhpY2FsbHkgc2VjdXJlLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogU3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiAt
LS0NCj4gIGxpYi9lYWwvY29tbW9uL3J0ZV9yYW5kb20uYyB8IDEzICsrKysrKysrKysrKy0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvbGliL2VhbC9jb21tb24vcnRlX3JhbmRvbS5jIGIvbGliL2VhbC9jb21tb24v
cnRlX3JhbmRvbS5jDQo+IGluZGV4IDU3NmEzMmE0NmMuLmNkYWQ2MDA0OWIgMTAwNjQ0DQo+IC0t
LSBhL2xpYi9lYWwvY29tbW9uL3J0ZV9yYW5kb20uYw0KPiArKysgYi9saWIvZWFsL2NvbW1vbi9y
dGVfcmFuZG9tLmMNCj4gQEAgLTI0Nyw3ICsyNDcsMTggQEAgZWFsX3JhbmRfaW5pdCh2b2lkKQ0K
PiANCj4gIAlSVEVfTENPUkVfVkFSX0FMTE9DKHJhbmRfc3RhdGUpOw0KPiANCj4gLQlzZWVkID0g
X19ydGVfcmFuZG9tX2luaXRpYWxfc2VlZCgpOw0KPiArCWNvbnN0IGNoYXIgKmVudiA9IGdldGVu
digiRFBES19SQU5ET01fU0VFRCIpOw0KPiArCWlmIChlbnYgIT0gTlVMTCAmJiAqZW52ICE9ICdc
MCcpIHsNCj4gKwkJY2hhciAqZW5kOw0KPiArDQo+ICsJCWVycm5vID0gMDsNCj4gKwkJc2VlZCA9
IHN0cnRvdWxsKGVudiwgJmVuZCwgMCk7DQo+ICsJCWlmIChlcnJubyAhPSAwIHx8ICplbmQgIT0g
J1wwJykNCj4gKwkJCXJ0ZV9leGl0KEVYSVRfRkFJTFVSRSwNCj4gKwkJCQkgImludmFsaWQgRFBE
S19SQU5ET01fU0VFRDogJXNcbiIsIGVudik7DQo+ICsJfSBlbHNlIHsNCj4gKwkJc2VlZCA9IF9f
cnRlX3JhbmRvbV9pbml0aWFsX3NlZWQoKTsNCj4gKwl9DQo+IA0KPiAgCXJ0ZV9zcmFuZChzZWVk
KTsNCj4gIH0NCj4gLS0NCj4gMi41My4wDQoNCk1pZ2h0IGJlIHVzZWZ1bC4NClJldmlld2VkLWJ5
OiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KDQo=
