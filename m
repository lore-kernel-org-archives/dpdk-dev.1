Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BBC1049515
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 10:25:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 583374067C;
	Wed, 11 Mar 2026 11:25:32 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 0146140431
 for <dev@dpdk.org>; Wed, 11 Mar 2026 11:25:30 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C3DDC21B36;
 Wed, 11 Mar 2026 11:25:30 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: RE: mempool name size incorrect?
Content-Transfer-Encoding: base64
Date: Wed, 11 Mar 2026 11:25:29 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65777@smartserver.smartshare.dk>
In-Reply-To: <f8381c90-d73c-446c-bb2f-2fe3bc921714@oktetlabs.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: mempool name size incorrect?
Thread-Index: AdyxO/fgXEPaDJaNRR6mmpJPDr31JwAAuUew
References: <98CBD80474FA8B44BF855DF32C47DC35F65773@smartserver.smartshare.dk>
 <f8381c90-d73c-446c-bb2f-2fe3bc921714@oktetlabs.ru>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
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

PiBGcm9tOiBBbmRyZXcgUnliY2hlbmtvIFttYWlsdG86YW5kcmV3LnJ5YmNoZW5rb0Bva3RldGxh
YnMucnVdDQo+IFNlbnQ6IFdlZG5lc2RheSwgMTEgTWFyY2ggMjAyNiAxMC40Nw0KPiANCj4gT24g
My8xMC8yNiA1OjEwIFBNLCBNb3J0ZW4gQnLDuHJ1cCB3cm90ZToNCj4gPiBJc24ndCB0aGUgUlRF
X01FTVBPT0xfTkFNRVNJWkUgdG9vIHNob3J0Pw0KPiA+DQo+ID4gTG9va2luZyBhdCB0aGUgbmFt
ZXMgc2l6ZXM6DQo+ID4NCj4gPiBSVEVfTUVNWk9ORV9OQU1FU0laRSA9IDMyLA0KPiA+IFJURV9S
SU5HX05BTUVTSVpFID0gUlRFX01FTVpPTkVfTkFNRVNJWkUgLSAoc2l6ZW9mKCJSR18iKT00KSAr
IDEgPQ0KPiAyOSwNCj4gPiBSVEVfTUVNUE9PTF9OQU1FU0laRSA9IFJURV9SSU5HX05BTUVTSVpF
IC0gKHNpemVvZigiTVBfIik9NCkgKyAxID0gMjYNCj4gPg0KPiA+IFJlZmVycmluZyB0byBbMV0s
IEkgdGhpbmsgaXQgc2hvdWxkIGJlIGZpeGVkIGFzOg0KPiA+IC0gI2RlZmluZSBSVEVfTUVNUE9P
TF9OQU1FU0laRSAoUlRFX1JJTkdfTkFNRVNJWkUgLSBcDQo+ID4gCQkJICAgICAgc2l6ZW9mKFJU
RV9NRU1QT09MX01aX1BSRUZJWCkgKyAxKQ0KPiA+ICsgI2RlZmluZSBSVEVfTUVNUE9PTF9OQU1F
U0laRSAoUlRFX01FTVpPTkVfTkFNRVNJWkUgLSBcDQo+ID4gCQkJICAgICAgc2l6ZW9mKFJURV9N
RU1QT09MX01aX1BSRUZJWCkgKyAxKQ0KPiA+DQo+ID4gVGhlcmUgaXMgbm8gcmluZyBpbnZvbHZl
ZCwgc28gSSBndWVzcyBpdCBpcyBzb21lIGtpbmQgb2YgY29weS1wYXN0ZS0NCj4gc2VhcmNoLXJl
cGxhY2UgZXJyb3IuDQo+ID4NCj4gDQo+IEkgZ3Vlc3MgcmluZyBpcyBpbnZvbHZlZCBpbiBmYWN0
IHNpbmNlIHRoZSBkZWZhdWx0IG1lbXBvb2wgZHJpdmVyIGlzDQo+IHJpbmcuDQo+IA0KPiBTZWUg
ZHJpdmVycy9tZW1wb29sL3JpbmcvcnRlX21lbXBvb2xfcmluZy5jIHJpbmdfYWxsb2MoKS4NCj4g
DQo+IFllcywgaXQgaXMgbm90IGlkZWFsLCBidXQgYXQgbGVhc3QgaXQgZXhwbGFpbnMgd2h5IFJU
RV9SSU5HX05BTUVTSVpFDQo+IGlzIHVzZWQuDQoNClRoYW5rcywgdGhhdCBleHBsYWlucyBpdC4g
QmFkIGxheWVyIHZpb2xhdGlvbi4uLg0KTGV0J3MgaG9wZSBubyBmdXR1cmUgbWVtcG9vbCBkcml2
ZXIgYWRkcyBhbnl0aGluZyBsb25nZXIgdGhhbiAiUkdfIiB0byB0aGUgbmFtZSBvZiBhbnkgbWVt
em9uZSBpdCBjcmVhdGVzLg0KDQpMb29raW5nIGludG8gdGhlIGFzc29jaWF0ZWQgc3RyaW5nIGxl
bmd0aCBjaGVja3MsIHVzaW5nIGEgdG9vIGxvbmcgbmFtZSB3aWxsIGZhaWwgd2l0aCBFTkFNRVRP
T0xPTkcuDQpTbywgdXNpbmcgYSBsb25nIG1lbXBvb2wgbmFtZSBtaWdodCBzdWNjZWVkIHdpdGgg
c29tZSBtZW1wb29sIGRyaXZlcnMgYW5kIGZhaWwgd2l0aCBvdGhlcnMuIDotKA0KDQpJIGd1ZXNz
IHRoZXJlJ3Mgbm8gc2ltcGxlIGZpeCBmb3IgdGhhdC4NCkFuZCBJIHdhcyB3cm9uZyB0byB0aGlu
ayB0aGF0IHRoZSBSVEVfTUVNUE9PTF9OQU1FU0laRSBzaG91bGQgYmUgaW5jcmVhc2VkIGZyb20g
MjYgdG8gMjkuDQoNCj4gDQo+ID4NCj4gPiBMb29raW5nIGF0IHRoZSBydGVfbWVtcG9vbCBzdHJ1
Y3R1cmUgWzJdOg0KPiA+IHN0cnVjdCBfX3J0ZV9jYWNoZV9hbGlnbmVkIHJ0ZV9tZW1wb29sIHsN
Cj4gPiAJY2hhciBuYW1lW1JURV9NRU1QT09MX05BTUVTSVpFXTsgLyoqPCBOYW1lIG9mIG1lbXBv
b2wuICovDQo+ID4gCXVuaW9uIHsNCj4gPiAJCXZvaWQgKnBvb2xfZGF0YTsgICAgICAgICAvKio8
IFJpbmcgb3IgcG9vbCB0byBzdG9yZQ0KPiBvYmplY3RzLiAqLw0KPiA+IAkJdWludDY0X3QgcG9v
bF9pZDsgICAgICAgIC8qKjwgRXh0ZXJuYWwgbWVtcG9vbCBpZGVudGlmaWVyLg0KPiAqLw0KPiA+
IAl9Ow0KPiA+DQo+ID4NCj4gPiBEdWUgdG8gdGhlIDgtYnl0ZSBhbGlnbm1lbnQgb2YgdGhlIHBv
b2xfaWQgZmllbGQgZm9sbG93aW5nIHRoZSBuYW1lDQo+IGZpZWxkLCBmaXhpbmcgdGhlIGxlbmd0
aCBhcyBzdWdnZXN0ZWQgZG9lc24ndCBjaGFuZ2UgdGhlIG1lbW9yeSBsYXlvdXQNCj4gZm9yIDY0
IGJpdCBDUFUgYXJjaGl0ZWN0dXJlcy4NCj4gPiBCdXQgaXQgZG9lcyBmb3IgMzIgYml0IENQVSBh
cmNoaXRlY3R1cmVzLCB3aGljaCB3aWxsIG9ubHkgNC1ieXRlDQo+IGFsaWduIHRoZSBwb29sX2lk
IGZpZWxkLg0KPiA+DQo+ID4gWzFdOiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9kcGRrL3Yy
Ni4wMy0NCj4gcmMxL3NvdXJjZS9saWIvbWVtcG9vbC9ydGVfbWVtcG9vbC5oI0wxMjgNCj4gPiBb
Ml06IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2RwZGsvdjI2LjAzLQ0KPiByYzEvc291cmNl
L2xpYi9tZW1wb29sL3J0ZV9tZW1wb29sLmgjTDIzMA0KPiA+DQo+ID4NCj4gPiBBbm90aGVyIHRo
aW5nOg0KPiA+IE9uIDMyIGJpdCBDUFUgYXJjaGl0ZWN0dXJlcywgdGhlIGNhY2hlX3NpemUgYW5k
IGxvY2FsX2NhY2hlIGZpZWxkcyBpbg0KPiB0aGUgcnRlX21lbXBvb2wgc3RydWN0dXJlIGFyZSBu
b3QgaW4gdGhlIHNhbWUgY2FjaGUgbGluZS4NCj4gPiBCdXQgSSBndWVzcyB3ZSBkb24ndCByZWFs
bHkgY2FyZSBhYm91dCAzMiBiaXQgQ1BVIGFyY2hpdGVjdHVyZXMuDQo+ID4NCj4gPg0KPiA+IFZl
bmxpZyBoaWxzZW4gLyBLaW5kIHJlZ2FyZHMsDQo+ID4gLU1vcnRlbiBCcsO4cnVwDQo+ID4NCg0K
