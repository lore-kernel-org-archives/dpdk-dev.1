Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563C9FEA82F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 07:41:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DD12402D3;
	Wed, 25 Mar 2026 08:41:41 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D9A95402AA
 for <dev@dpdk.org>; Wed, 25 Mar 2026 08:41:39 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C2C3B21353;
 Wed, 25 Mar 2026 08:41:38 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v20 25/25] app/pdump: preserve VLAN tags in captured
 packets
Date: Wed, 25 Mar 2026 08:41:39 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657C2@smartserver.smartshare.dk>
In-Reply-To: <20260324101209.04ffae54@phoenix.local>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v20 25/25] app/pdump: preserve VLAN tags in captured
 packets
Thread-Index: Ady7sV1/WdMo5DsOTpS+qdnyRY4siQAdonlQ
References: <20260106182823.192350-1-stephen@networkplumber.org><20260310161356.194553-1-stephen@networkplumber.org><20260310161356.194553-26-stephen@networkplumber.org><abgi0O1fWFqYIDP5@bricha3-mobl1.ger.corp.intel.com><98CBD80474FA8B44BF855DF32C47DC35F6579A@smartserver.smartshare.dk>
 <20260324101209.04ffae54@phoenix.local>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: "Bruce Richardson" <bruce.richardson@intel.com>, <dev@dpdk.org>,
 "Reshma Pattan" <reshma.pattan@intel.com>
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
b3JnXQ0KPiBTZW50OiBUdWVzZGF5LCAyNCBNYXJjaCAyMDI2IDE4LjEyDQo+IA0KPiBPbiBNb24s
IDE2IE1hciAyMDI2IDE2OjU1OjI5ICswMTAwDQo+IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNo
YXJlc3lzdGVtcy5jb20+IHdyb3RlOg0KPiANCj4gPiA+DQo+ID4gPiBUaGlzIGlzIGFuIGV4YW1w
bGUgb2Ygc29tZXRoaW5nIEkgcHJldmlvdXNseSBmbGFnZ2VkLiBMaWtlIHdpdGgNCj4gcmVhbA0K
PiA+ID4gaGFyZHdhcmUsIEkgdGhpbmsgdGhlIFBNRCBzaG91bGQgYmUgaW5zZXJ0aW5nIHRoZSBW
TEFOIHRhZyBpbnRvIHRoZQ0KPiA+ID4gcGFja2V0DQo+ID4gPiBhcyBwYXJ0IG9mIHRoZSBUeCBm
dW5jdGlvbiwgbm90IHRoZSBwcmVwYXJlIGZ1bmN0aW9uLg0KPiA+DQo+ID4gQWdyZWUgd2l0aCBC
cnVjZSBvbiB0aGlzLg0KPiA+IEZvciBzaW1wbGUgc3R1ZmYgbGlrZSBWTEFOIG9mZmxvYWQsIGFw
cGxpY2F0aW9ucyBzaG91bGQgbm90IGJlDQo+IHJlcXVpcmVkIHRvIGNhbGwgdHhfcHJlcCBmaXJz
dC4NCj4gPg0KPiA+IEhvd2V2ZXIsIHRoZSBUeCBmdW5jdGlvbiBpcyBzdXBwb3NlZCB0byBub3Qg
bW9kaWZ5IHRoZSBwYWNrZXRzOw0KPiByZWxldmFudCB3aGVuIHJlZmNudCA+IDEuDQo+ID4NCj4g
PiBJbnN0ZWFkIG9mIG1vZGlmeWluZyB0aGUgcGFja2V0IGRhdGEgdG8gaW5zZXJ0L3N0cmlwIHRo
ZSBWTEFOIHRhZywNCj4gPiBwZXJoYXBzIHRoZSBkcml2ZXIgY2FuIHNwbGl0IHRoZSB3cml0ZS9y
ZWFkIG9wZXJhdGlvbiBpbnRvIG11bHRpcGxlDQo+IHdyaXRlL3JlYWQgb3BlcmF0aW9uczoNCj4g
PiAxLiB0aGUgRXRoZXJuZXQgaGVhZGVyDQo+ID4gMi4gdGhlIFZMQU4gdGFnDQo+ID4gMy4gdGhl
IHJlbWFpbmluZyBwYWNrZXQgZGF0YQ0KPiA+DQo+ID4gSSBoYXZlbid0IHJlYWxseSBmb2xsb3dl
ZCB0aGUgcGNhcCBkcml2ZXIsIHNvIG1heWJlIG15IHN1Z2dlc3Rpb24NCj4gZG9lc24ndCBtYWtl
IHNlbnNlLg0KPiANCj4gVGhlIHByZXBhcmUgY29kZSBhbmQgVkxBTiB3YXMgY29waWVkIGZyb20g
dmlydGlvLg0KPiBJIGFzc3VtZSB2aXJ0aW8gaXMgd2lkZWx5IHVzZWQgYWxyZWFkeS4NCg0KT0ss
IHRoYXQgbWFrZXMgaXQgaGFyZGVyIHRvIG9iamVjdCB0by4NCg0KPHJhbnQ+DQoNCkkgY2hlY2tl
ZCBvdXQgdGhlIHZpcnRpbyBjb2RlLg0KdmlydGlvX3htaXRfcGt0c19wcmVwYXJlKCkgY2FsbHMg
cnRlX3ZsYW5faW5zZXJ0KCkuDQpBbmQgcnRlX3ZsYW5faW5zZXJ0KCkgZG9lc24ndCBzdXBwb3J0
IG1idWYgcmVmY250ID4gMS4NCg0KU28gYmFzaWNhbGx5LCB0aGVzZSBkcml2ZXJzIGRvbid0IHN1
cHBvcnQgc2ltcGxlIFZMQU4gdGFnZ2luZyB3aGVuIG1idWYgcmVmY250ID4gMS4NClRoaXMgc2Vl
bXMgbGlrZSBhIG1ham9yIGxpbWl0YXRpb24sIHdoaWNoIHNob3VsZCBiZSBwcm9taW5lbnRseSBk
b2N1bWVudGVkLg0KDQpBIGRlY2FkZSBhZ28sIHdoZW4gd2Ugc3RhcnRlZCB1c2luZyBEUERLIGZv
ciBvdXIgcHJvamVjdHMsIG9uZSBvZiB0aGUgdGhpbmdzIEkgbG92ZWQgYWJvdXQgaXQgd2FzIGl0
cyBkb2N1bWVudGF0aW9uLg0KQnV0IGFmdGVyIGEgd2hpbGUsIEkgbm90aWNlZCB0aGF0IGEgbG90
IG9mIHRoZSBkb2N1bWVudGVkIG1idWYgbGlicmFyeSBmZWF0dXJlcyB3ZXJlbid0IGZ1bGx5IGlt
cGxlbWVudGVkLg0KVGhlc2UgbGltaXRhdGlvbnMgc2hvdWxkIGJlIGRvY3VtZW50ZWQuDQoNCkUu
Zy4gaWYgYW4gaW1wb3J0YW50IGRyaXZlciBsaWtlIHZpcnRpbyBkb2Vzbid0IHN1cHBvcnQgVkxB
TiB0YWdnaW5nIG9mIGluZGlyZWN0L2Nsb25lZCBtYnVmcywgdGhpcyBzaG91bGQgYmUgcHJvbWlu
ZW50bHkgaGlnaGxpZ2h0ZWQgaW4gZG9jdW1lbnRhdGlvbiENCg0KPC9yYW50Pg0KDQo=
