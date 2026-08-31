Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5C9C61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 16:37:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75CE24042E;
	Mon, 31 Aug 2026 18:37:06 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 95DDA40269
 for <dev@dpdk.org>; Mon, 31 Aug 2026 18:37:05 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 6AB992024A;
 Mon, 31 Aug 2026 18:37:05 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v3 1/2] stack: introduce pile
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 31 Aug 2026 18:37:03 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A28@smartserver.smartshare.dk>
In-Reply-To: <20260831081522.16ffb8b2@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 1/2] stack: introduce pile
Thread-Index: Ad05ZIPSVKqfkQR4RpiU06eWhA+iCQAAToLw
References: <20260812134756.1829613-1-mb@smartsharesystems.com>
 <20260827135556.522443-1-mb@smartsharesystems.com>
 <20260827135556.522443-2-mb@smartsharesystems.com>
 <20260831081522.16ffb8b2@phoenix.local>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>, "Bruce Richardson" <bruce.richardson@intel.com>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>
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
b3JnXQ0KPiBTZW50OiBNb25kYXksIDMxIEF1Z3VzdCAyMDI2IDE4LjA2DQo+IA0KPiBPbiBUaHUs
IDI3IEF1ZyAyMDI2IDEzOjU1OjU1ICswMDAwDQo+IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNo
YXJlc3lzdGVtcy5jb20+IHdyb3RlOg0KPiANCj4gPiArX19ydGVfc3RhY2tfcGlsZV9wb3Aoc3Ry
dWN0IHJ0ZV9zdGFjayAqcywNCj4gPiArCQl2b2lkICoqb2JqX3RhYmxlLA0KPiANCj4gTkFLIHRv
IHVzaW5nIGFsd2F5c19pbmxpbmUgb24gYSBmdW5jdGlvbiB0aGlzIGJpZw0KPiBJdCBnZW5lcmF0
ZXMgd29yc2UgY29kZSBpbiBhIGxvdCBvZiBjYXNlcyBiZWNhdXNlIG9mIHJlZ2lzdGVyIHNwaWxs
Lg0KDQpPSywgSSB3aWxsIGNoYW5nZSBpdCB0byAiaW5saW5lIiwgYW5kIGxldCB0aGUgY29tcGls
ZXIgZGVjaWRlLg0KVGhlbiB3ZSBkb24ndCBoYXZlIHRvIGRpc2N1c3Mgd2hpY2ggaXMgYmV0dGVy
LiA6LSkNCg0KSSdsbCBjaGFuZ2UgdGhlIHB1bGwgZnVuY3Rpb24gdG9vLg0KDQpCVFcsIGl0J3Mg
bm90IHF1aXRlIGFzIGJpZyBhcyBpdCBsb29rcy4NCkhlcmUncyB0aGUgZnVuY3Rpb24gd2l0aG91
dCBjb21tZW50cywgYXNzZXJ0aW9ucyBhbmQgZW1wdHkgbGluZXM6DQoNCnN0YXRpYyBfX3J0ZV9h
bHdheXNfaW5saW5lIHVuc2lnbmVkIGludA0KX19ydGVfc3RhY2tfcGlsZV9wb3Aoc3RydWN0IHJ0
ZV9zdGFjayAqcywNCgkJdm9pZCAqKm9ial90YWJsZSwNCgkJdW5zaWduZWQgaW50IG4pDQp7DQoJ
c3RydWN0IHJ0ZV9zdGFja19waWxlICpwaWxlID0gJnMtPnN0YWNrX3BpbGU7DQoJc3RydWN0IHJ0
ZV9zdGFja19waWxlX2J1bGtfZWxlbSAqYnVsa19maXJzdCA9IE5VTEwsICpidWxrX2xhc3QgPSBO
VUxMOw0KCXN0cnVjdCBydGVfc3RhY2tfbGZfZWxlbSAqc29sb19maXJzdCA9IE5VTEwsICpzb2xv
X2xhc3QgPSBOVUxMOw0KCXVuc2lnbmVkIGludCBuX2J1bGsgPSBuIC8gUlRFX1NUQUNLX1BJTEVf
QlVMS19TSVpFOw0KCXVuc2lnbmVkIGludCBuX3NvbG8gPSBuICYgKFJURV9TVEFDS19QSUxFX0JV
TEtfU0laRSAtIDEpOw0KCWlmICh1bmxpa2VseShuX2J1bGsgPT0gMCkpIHsNCgkJaWYgKHVubGlr
ZWx5KG5fc29sbyA9PSAwKSkNCgkJCXJldHVybiAwOw0KCQlnb3RvIHNvbG87DQoJfQ0KYnVsazoN
CglidWxrX2ZpcnN0ID0gX19ydGVfc3RhY2tfcGlsZV9idWxrX3BvcF9lbGVtcygmcGlsZS0+YnVs
aywgbl9idWxrLCBvYmpfdGFibGUsICZidWxrX2xhc3QpOw0KCWlmICh1bmxpa2VseShidWxrX2Zp
cnN0ID09IE5VTEwpKSB7DQoJCXVuc2lnbmVkIGludCBkZWx0YV9idWxrID0gbl9idWxrIC0gX19y
dGVfc3RhY2tfbGZfZWxlbXNfY291bnQoJnBpbGUtPmJ1bGspOw0KCQlpZiAodW5saWtlbHkoKGlu
dClkZWx0YV9idWxrIDw9IDApKQ0KCQkJZGVsdGFfYnVsayA9IDE7DQoJCW5fYnVsayAtPSBkZWx0
YV9idWxrOw0KCQluX3NvbG8gKz0gUlRFX1NUQUNLX1BJTEVfQlVMS19TSVpFICogZGVsdGFfYnVs
azsNCgkJaWYgKG5fYnVsayA9PSAwKQ0KCQkJZ290byBzb2xvOw0KCQlnb3RvIGJ1bGs7DQoJfQ0K
CW9ial90YWJsZSArPSBuX2J1bGsgKiBSVEVfU1RBQ0tfUElMRV9CVUxLX1NJWkU7DQoJaWYgKGxp
a2VseShuX3NvbG8gPT0gMCkpDQoJCWdvdG8gZG9uZTsNCnNvbG86DQoJc29sb19maXJzdCA9IF9f
cnRlX3N0YWNrX2xmX3BvcF9lbGVtcygmcGlsZS0+c29sbywgbl9zb2xvLA0KCQkJb2JqX3RhYmxl
LCAmc29sb19sYXN0KTsNCglpZiAoc29sb19maXJzdCAhPSBOVUxMKQ0KCQlnb3RvIGRvbmU7DQoJ
aWYgKHVubGlrZWx5KG5fc29sbyA+PSBSVEVfU1RBQ0tfUElMRV9CVUxLX1NJWkUpKQ0KCQlnb3Rv
IGZhaWw7DQoJaWYgKHVubGlrZWx5KF9fcnRlX3N0YWNrX3BpbGVfcG9wX2ZyYWcocGlsZSwgb2Jq
X3RhYmxlLCBuX3NvbG8pID09IDApKQ0KCQlnb3RvIGZhaWw7DQpkb25lOg0KCWlmIChidWxrX2Zp
cnN0ICE9IE5VTEwpDQoJCV9fcnRlX3N0YWNrX3BpbGVfYnVsa19wdXNoX2VsZW1zKCZwaWxlLT5m
cmVlX2J1bGssIGJ1bGtfZmlyc3QsIGJ1bGtfbGFzdCwgbl9idWxrKTsNCglpZiAoc29sb19maXJz
dCAhPSBOVUxMKQ0KCQlfX3J0ZV9zdGFja19sZl9wdXNoX2VsZW1zKCZwaWxlLT5mcmVlX3NvbG8s
IHNvbG9fZmlyc3QsIHNvbG9fbGFzdCwgbl9zb2xvKTsNCglyZXR1cm4gbjsNCmZhaWw6DQoJaWYg
KGJ1bGtfZmlyc3QgIT0gTlVMTCkNCgkJX19ydGVfc3RhY2tfcGlsZV9idWxrX3B1c2hfZWxlbXMo
JnBpbGUtPmJ1bGssIGJ1bGtfZmlyc3QsIGJ1bGtfbGFzdCwgbl9idWxrKTsNCglyZXR1cm4gMDsN
Cn0NCg0K
