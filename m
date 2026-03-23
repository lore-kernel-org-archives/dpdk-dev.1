Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAE6EC01A2
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 08:14:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 656944064A;
	Mon, 23 Mar 2026 09:14:45 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E7EF54025F;
 Mon, 23 Mar 2026 09:14:43 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E736420784;
 Mon, 23 Mar 2026 09:14:42 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] eal: fix cache guard for pedantic compilation
Date: Mon, 23 Mar 2026 09:14:41 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657B0@smartserver.smartshare.dk>
In-Reply-To: <20260323081204.748909-1-mb@smartsharesystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [PATCH] eal: fix cache guard for pedantic compilation
Thread-Index: Ady6nL/WOjtCiJOMROm+kMkTcOjffAAAEBjg
References: <20260323081204.748909-1-mb@smartsharesystems.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: <stable@dpdk.org>
Cc: <dev@dpdk.org>
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

Rm9yZ290IGNjIHN0YWJsZS4NCg0KPiBGcm9tOiBNb3J0ZW4gQnLDuHJ1cCBbbWFpbHRvOm1iQHNt
YXJ0c2hhcmVzeXN0ZW1zLmNvbV0NCj4gU2VudDogTW9uZGF5LCAyMyBNYXJjaCAyMDI2IDA5LjEy
DQo+IA0KPiBUaGUgY2FjaGUgZ3VhcmQgbWFjcm8gdXNlcyBfX0NPVU5URVJfXyB0byBnZW5lcmF0
ZSB1bmlxdWUgbmFtZXMuDQo+IEhvd2V2ZXIsIGFsdGhvdWdoIG1vc3QgQyBjb21waWxlcnMgc3Vw
cG9ydCBfX0NPVU5URVJfXywgaXQgaXMgbm90IHlldA0KPiBwYXJ0IG9mIHRoZSBDIHN0YW5kYXJk
LCBzbyBjb21waWxhdGlvbiBmYWlscyB3aGVuIGJ1aWxkaW5nIGluIHBlZGFudGljDQo+IG1vZGUu
DQo+IFRoZSBtYWNybyB3YXMgY2hhbmdlZCB0byB1c2UgX19MSU5FX18gaW5zdGVhZC4NCj4gDQo+
IEZpeGVzOiA2NWY2MDBjMGYwMDAgKCJlYWw6IGFkZCBlbXB0eSBjYWNoZSBsaW5lIG1hY3JvIikN
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVt
cy5jb20+DQo+IC0tLQ0KPiAgbGliL2VhbC9pbmNsdWRlL3J0ZV9jb21tb24uaCB8IDYgKysrKyst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvbGliL2VhbC9pbmNsdWRlL3J0ZV9jb21tb24uaA0KPiBiL2xpYi9lYWwv
aW5jbHVkZS9ydGVfY29tbW9uLmgNCj4gaW5kZXggNTczYmY0ZjJjZS4uOTc4NjVhYWEzOSAxMDA2
NDQNCj4gLS0tIGEvbGliL2VhbC9pbmNsdWRlL3J0ZV9jb21tb24uaA0KPiArKysgYi9saWIvZWFs
L2luY2x1ZGUvcnRlX2NvbW1vbi5oDQo+IEBAIC03NTEsOCArNzUxLDEyIEBAIHJ0ZV9pc19hbGln
bmVkKGNvbnN0IHZvaWQgKiBjb25zdCBfX3J0ZV9yZXN0cmljdA0KPiBwdHIsIGNvbnN0IHVuc2ln
bmVkIGludCBhbGlnbikNCj4gICAqDQo+ICAgKiBVc2UgYXMgc3BhY2luZyBiZXR3ZWVuIGRhdGEg
YWNjZXNzZWQgYnkgZGlmZmVyZW50IGxjb3JlcywNCj4gICAqIHRvIHByZXZlbnQgY2FjaGUgdGhy
YXNoaW5nIG9uIGhhcmR3YXJlIHdpdGggc3BlY3VsYXRpdmUNCj4gcHJlZmV0Y2hpbmcuDQo+ICsg
Kg0KPiArICogTm90ZTogQWx0aG91Z2ggX19DT1VOVEVSX18gd291bGQgYmUgYmV0dGVyIGZvciB1
bmlxdWVuZXNzLCBpdCBpcw0KPiBub3QgeWV0DQo+ICsgKiAoTWFyY2ggMjAyNikgcGFydCBvZiB0
aGUgQyBzdGFuZGFyZCwgc28gY29tcGlsYXRpb24gd291bGQgZmFpbCB3aGVuDQo+IGJ1aWxkaW5n
DQo+ICsgKiBpbiBwZWRhbnRpYyBtb2RlLg0KPiAgICovDQo+IC0jZGVmaW5lIFJURV9DQUNIRV9H
VUFSRCBfUlRFX0NBQ0hFX0dVQVJEX0hFTFBFUjEoX19DT1VOVEVSX18pDQo+ICsjZGVmaW5lIFJU
RV9DQUNIRV9HVUFSRCBfUlRFX0NBQ0hFX0dVQVJEX0hFTFBFUjEoX19MSU5FX18pDQo+IA0KPiAg
LyoqKioqKioqKioqIFBBL0lPVkEgdHlwZSBkZWZpbml0aW9ucyAqKioqKioqKi8NCj4gDQo+IC0t
DQo+IDIuNDMuMA0KDQo=
