Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299E9C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 15:44:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73904410ED;
	Mon,  9 Jun 2025 17:44:10 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D72854064F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 17:44:08 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id AAB0920469;
 Mon,  9 Jun 2025 17:44:08 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [RFC PATCH] mempool: Fix some Coverity defects
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 9 Jun 2025 17:44:06 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FCD7@smartserver.smartshare.dk>
In-Reply-To: <20250609082545.4c932967@hermes.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] mempool: Fix some Coverity defects
Thread-Index: AdvZUsjeo6FHQnUkR/2sAidoplGxQQAABvnQ
References: <20250609144226.232625-1-mb@smartsharesystems.com>
 <20250609082545.4c932967@hermes.local>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
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

PiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3BsdW1iZXIu
b3JnXQ0KPiBTZW50OiBNb25kYXksIDkgSnVuZSAyMDI1IDE3LjI2DQo+IA0KPiBPbiBNb24sICA5
IEp1biAyMDI1IDE0OjQyOjI2ICswMDAwDQo+IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJl
c3lzdGVtcy5jb20+IHdyb3RlOg0KPiANCj4gPiBAQCAtMTQxLDggKzE0MSwxMyBAQCBydGVfbWVt
X3BhZ2Vfc2l6ZSh2b2lkKQ0KPiA+ICB7DQo+ID4gIAlzdGF0aWMgc2l6ZV90IHBhZ2Vfc2l6ZTsN
Cj4gPg0KPiA+IC0JaWYgKCFwYWdlX3NpemUpDQo+ID4gKwlpZiAocGFnZV9zaXplID09IDApIHsN
Cj4gPiArCQllcnJubyA9IDA7IC8qIG1hbiBzeXNjb25mKDMpICovDQo+ID4gIAkJcGFnZV9zaXpl
ID0gc3lzY29uZihfU0NfUEFHRVNJWkUpOw0KPiA+ICsJCWlmICgoc3NpemVfdClwYWdlX3NpemUg
PCAwKQ0KPiA+ICsJCQlydGVfcGFuaWMoInN5c2NvbmYoX1NDX1BBR0VTSVpFKSBmYWlsZWQ6ICVz
IiwNCj4gPiArCQkJCQllcnJubyA9PSAwID8gIkluZGV0ZXJtaW5hdGUiIDoNCj4gc3RyZXJyb3Io
ZXJybm8pKTsNCj4gPiArCX0NCj4gDQo+IFdoeSBub3QgbWFrZSBwYWdlX3NpemUgYSBzc2l6ZV90
IG9yIGxvbmc/DQo+IFRoZSByZXR1cm4gdmFsdWUgb2Ygc3lzY29uZiBpcyBsb25nLg0KDQpJIGd1
ZXNzIGl0J3MgYSBtYXR0ZXIgb2YgcHJlZmVyZW5jZS4uLg0KVGhpcyBmdW5jdGlvbiByZXR1cm5z
IHNpemVfdCwgaS5lLiBhbiB1bnNpZ25lZCB0eXBlLiBTbyBJIGtlcHQgcGFnZV9zaXplICh0aGUg
Y2FjaGVkIHJldHVybiB2YWx1ZSkgdGhlIHNhbWUgdHlwZSwgYW5kIHB1dCB0aGUgdHlwZSBjYXN0
IGluIHRoZSB1bmxpa2VseSBjb2RlIHBhdGguDQpUaGUgYWx0ZXJuYXRpdmUsIGNoYW5naW5nIHBh
Z2Vfc2l6ZSB0byBhIHNpZ25lZCB0eXBlIChzc2l6ZV90IG9yIGxvbmcpLCB3b3VsZCByZXF1aXJl
IGNhc3RpbmcgdG8gYW4gdW5zaWduZWQgdHlwZSBpbiB0aGUgcmV0dXJuIHN0YXRlbWVudC4NCg0K
PiBOb3Qgc3VyZSBpZiBzZXR0aW5nIGVycm5vIHRvIHplcm8gaXMgcmVxdWlyZWQsIHN5c2NvbmYg
b25seSB0b3VjaHMgaXQgaWYNCj4gcmV0dXJuIHZhbHVlIGlzIG5lZ2F0aXZlLg0KDQpUaGUgTGlu
dXggbWFuIHN5c2NvbmYoMykgcGFnZSByZWNvbW1lbmRzIHNldHRpbmcgZXJybm8gdG8gemVybyBi
ZWZvcmUgY2FsbGluZyBzeXNjb25mKCksIHNvIGVycm5vIGNhbiBiZSB1c2VkIHRvIGRpc2NyaW1p
bmF0ZSBiZXR3ZWVuIGFjdHVhbCBlcnJvcnMgYW5kIGFuIGluZGV0ZXJtaW5hdGUgdmFsdWUgd2hl
biBzeXNjb25mKCkgcmV0dXJucyAtMS4NCkhlbmNlIHRoZSAibWFuIHN5c2NvbmYoMykiIGNvbW1l
bnQuDQpCU0Qgc3lzY29uZigzKSBiZWhhdmVzIHRoZSBzYW1lIHdheSwgYnV0IHRoZSBCU0QgbWFu
IHBhZ2UgaXMgbGVzcyBleHBsaWNpdCBhYm91dCBzZXR0aW5nIGVycm5vIHRvIHplcm8uDQoNCg==
