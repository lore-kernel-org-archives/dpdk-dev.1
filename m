Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4292C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 06:45:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC61B402D4;
	Tue, 10 Jun 2025 08:45:28 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 4B6AC40299
 for <dev@dpdk.org>; Tue, 10 Jun 2025 08:45:27 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id F10FF20462;
 Tue, 10 Jun 2025 08:45:26 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [EXTERNAL] Re: [PATCH v2 1/1] ethdev: add support to provide link
 type
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 10 Jun 2025 08:45:24 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FCD8@smartserver.smartshare.dk>
In-Reply-To: <CO6PR18MB3860A0F5A75F34D2C76F1B58B46AA@CO6PR18MB3860.namprd18.prod.outlook.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/1] ethdev: add support to provide
 link type
Thread-Index: AQHb1sV4glZQDx84DkubxQo6XdgHSLP15I0AgABbtoCABZrpAIAAGSKA
References: <20250605113159.3035480-1-skori@marvell.com>
 <20250606092904.3145608-1-skori@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FCD0@smartserver.smartshare.dk>
 <20250606082307.152616f3@hermes.local>
 <CO6PR18MB3860A0F5A75F34D2C76F1B58B46AA@CO6PR18MB3860.namprd18.prod.outlook.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Sunil Kumar Kori" <skori@marvell.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: "Thomas Monjalon" <thomas@monjalon.net>,
 "Ferruh Yigit" <ferruh.yigit@amd.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>,
 "Nithin Kumar Dabilpuram" <ndabilpuram@marvell.com>,
 "Jerin Jacob" <jerinj@marvell.com>
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

PiBGcm9tOiBTdW5pbCBLdW1hciBLb3JpIFttYWlsdG86c2tvcmlAbWFydmVsbC5jb21dDQo+IFNl
bnQ6IFR1ZXNkYXksIDEwIEp1bmUgMjAyNSAwNy4wMg0KPiANCj4gPiBPbiBGcmksIDYgSnVuIDIw
MjUgMTE6NTQ6NTIgKzAyMDANCj4gPiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3Rl
bXMuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gPiBGcm9tOiBza29yaUBtYXJ2ZWxsLmNvbSBbbWFp
bHRvOnNrb3JpQG1hcnZlbGwuY29tXQ0KPiA+ID4gPiBTZW50OiBGcmlkYXksIDYgSnVuZSAyMDI1
IDExLjI4DQo+ID4gPiA+DQo+ID4gPiA+IEZyb206IFN1bmlsIEt1bWFyIEtvcmkgPHNrb3JpQG1h
cnZlbGwuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBBZGRpbmcgbGluayB0eXBlIHBhcmFtZXRlciB0
byBwcm92aWRlIHRoZSB0eXBlIG9mIHBvcnQgbGlrZSB0d2lzdGVkDQo+ID4gPiA+IHBhaXIsIGZp
YnJlIGV0Yy4NCj4gPiA+ID4NCj4gPiA+ID4gQWxzbyBhZGRlZCBhbiBBUEkgdG8gY29udmVydCB0
aGUgUlRFX0VUSF9MSU5LX1RZUEVfWFhYIHRvIGEgcmVhZGFibGUNCj4gPiA+ID4gc3RyaW5nLg0K
PiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOaXRoaW4gRGFiaWxwdXJhbSA8bmRhYmls
cHVyYW1AbWFydmVsbC5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFN1bmlsIEt1bWFyIEtv
cmkgPHNrb3JpQG1hcnZlbGwuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gKy8qKkB7QG5hbWUg
UE9SVCB0eXBlDQo+ID4gPiA+ICsgKiBFdGhlcm5ldCBwb3J0IHR5cGUNCj4gPiA+ID4gKyAqLw0K
PiA+ID4gPiArI2RlZmluZSBSVEVfRVRIX0xJTktfVFlQRV9OT05FICAweDAwIC8qKjwgTm90IGRl
ZmluZWQgKi8NCj4gPiA+ID4gKyNkZWZpbmUgUlRFX0VUSF9MSU5LX1RZUEVfVFAgICAgMHgwMSAv
Kio8IFR3aXN0ZWQgUGFpciAqLw0KPiA+ID4gPiArI2RlZmluZSBSVEVfRVRIX0xJTktfVFlQRV9B
VUkgICAweDAyIC8qKjwgQXR0YWNobWVudCBVbml0IEludGVyZmFjZSAqLw0KPiA+ID4gPiArI2Rl
ZmluZSBSVEVfRVRIX0xJTktfVFlQRV9NSUkgICAweDAzIC8qKjwgTWVkaWEgSW5kZXBlbmRlbnQg
SW50ZXJmYWNlDQo+ID4gPiA+ICovDQo+ID4gPiA+ICsjZGVmaW5lIFJURV9FVEhfTElOS19UWVBF
X0ZJQlJFIDB4MDQgLyoqPCBGaWJyZSAqLw0KPiA+ID4gPiArI2RlZmluZSBSVEVfRVRIX0xJTktf
VFlQRV9CTkMgICAweDA1IC8qKjwgQk5DICovDQo+ID4gPiA+ICsjZGVmaW5lIFJURV9FVEhfTElO
S19UWVBFX0RBICAgIDB4MDYgLyoqPCBEaXJlY3QgQXR0YWNoIGNvcHBlciAqLw0KPiA+ID4gPiAr
I2RlZmluZSBSVEVfRVRIX0xJTktfVFlQRV9PVEhFUiAweDFGIC8qKjwgT3RoZXIgdHlwZSAqLyAv
KipAfSovDQo+ID4gPg0KPiA+ID4gSSBkb24ndCBzZWUgdGhlIHVzZSBjYXNlIGZvciB0aGlzIHBh
dGNoLCB3aGVuIG9ubHkgYW5jaWVudCBpbnRlcmZhY2UgdHlwZXMNCj4gYXJlDQo+ID4gZGVmaW5l
ZC4NCj4gPiA+IEhvdyBhYm91dCBSTUlJLCBHTUlJLCBSR01JSSwgWEdNSUksIFhBVUksIFhBVUk0
LCBDQVVJNCwgU0ZQLCBTRlArLCBTRlAyOCwNCj4gZXRjLg0KPiA+ID4NCj4gPiA+IFBsZWFzZSBk
b24ndCBibGluZGx5IHBvcnQgc3R1ZmYgZnJvbSBMaW51eCB0byBEUERLLg0KPiA+ID4NCj4gPiA+
DQo+ID4NCj4gPiBBZ3JlZSB3aXRoIE1vcnRlbiBoZXJlLg0KPiA+IFBsdXMsIGl0IGlzbid0IHJl
YWxseSBtdWNoIHVzZSB0byB1c2VyIHVubGVzcyBhbGwgZHJpdmVycyByZXBvcnQgaXQuDQo+ID4g
QWxzbywgaXQgYnJlYWtzIEFCSSAoc2VlIGJ1aWxkIGZhaWx1cmVzKS4NCj4gDQo+IEFncmVlZC4g
SSB3aWxsIHRyeSB0byBtYWtlIHRoaXMgaW1wbGVtZW50YXRpb24gbW9yZSB1c2VmdWwgYW5kIHdp
bGwgc2hhcmUgbmV4dA0KPiB2ZXJzaW9uIGFmdGVyIGhhbmRsaW5nIHRoZSBzdWdnZXN0aW9ucy4N
Cj4gVGhhbmtzLg0KDQpJZiB5b3UgY2hvb3NlIHRvIHByb2NlZWQgd2l0aCB0aGlzLCBwbGVhc2Ug
bm90ZSB0aGF0IEFQSXMgZm9yIG1hbmFnaW5nIFBIWXMgYW5kIHBsdWdnYWJsZSBtb2R1bGVzIChT
RlAsIGV0Yy4pIHdvdWxkIGJlIG1vcmUgdXNlZnVsIHRoYW4gc2ltcGx5IGluZGljYXRpbmcgaWYg
ZHVhbC1wZXJzb25hbGl0eSBwb3J0IGlzIGNvbm5lY3RlZCBieSBUd2lzdGVkIFBhaXIgb3IgU0ZQ
ICh3aGljaCBpcyB0aGUgb25seSBjYXNlIEkgY2FuIGltYWdpbmUgZm9yIHRoaXMgQVBJKS4NCkEg
UEhZIEFQSSBjb3VsZCBhbHNvIGJlIHVzZWQgZm9yIEVFRSAoIkdyZWVuIEV0aGVybmV0IikgYW5k
IFBPRSBtYW5hZ2VtZW50LCBjYWJsZSB0ZXN0IGFuZCBzaW1pbGFyIGZlYXR1cmVzLg0KDQpNYXJ2
ZWxsIG1ha2VzIFBIWXMsIHNvIHBsZWFzZSBhc2sgdG8geW91ciBQSFkgcGVvcGxlIGFib3V0IHJl
bGV2YW50IGZlYXR1cmVzIGZvciBhIFBIWSBBUEkuDQpUaGlzIHNob3VsZCBiZSBkcml2ZW4gYnkg
dXNlIGNhc2VzLCBub3QgYnkgd2hhdCBpcyBhdmFpbGFibGUgaW4gTGludXggQVBJcy4NCg0K
