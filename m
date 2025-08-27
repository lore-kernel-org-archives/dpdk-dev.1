Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F2FCA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 15:56:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 134C94029E;
	Wed, 27 Aug 2025 17:56:29 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7C7BC40292
 for <dev@dpdk.org>; Wed, 27 Aug 2025 17:56:27 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5DF8320A24;
 Wed, 27 Aug 2025 17:56:27 +0200 (CEST)
Subject: RE: [PATCH v3 0/9] introduce common FOREACH_SAFE macros
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Wed, 27 Aug 2025 17:56:24 +0200
Content-class: urn:content-classes:message
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE7B@smartserver.smartshare.dk>
In-Reply-To: <2404222.ECZNHGQPT7@thomas>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [PATCH v3 0/9] introduce common FOREACH_SAFE macros
Thread-Index: AdwXZOPQoRWznWQdTz64RaR2rR2DBQABKNgw
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <e9017361-f29b-45da-a1b0-cc745b8c906f@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE79@smartserver.smartshare.dk>
 <2404222.ECZNHGQPT7@thomas>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
 "Burakov, Anatoly" <anatoly.burakov@intel.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>,
	"Tyler Retzlaff" <roretzla@microsoft.com>
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

PiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0bzp0aG9tYXNAbW9uamFsb24ubmV0XQ0KPiBT
ZW50OiBXZWRuZXNkYXksIDI3IEF1Z3VzdCAyMDI1IDE3LjEyDQo+IA0KPiAyNy8wOC8yMDI1IDE3
OjA4LCBNb3J0ZW4gQnLDuHJ1cDoNCj4gPiA+IEZyb206IEJ1cmFrb3YsIEFuYXRvbHkgW21haWx0
bzphbmF0b2x5LmJ1cmFrb3ZAaW50ZWwuY29tXQ0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCAyNyBB
dWd1c3QgMjAyNSAxNi4xNA0KPiA+ID4NCj4gPiA+IE9uIDgvMjAvMjAyNSA4OjQyIEFNLCBNb3J0
ZW4gQnLDuHJ1cCB3cm90ZToNCj4gPiA+ID4+IEZyb206IFN0ZXBoZW4gSGVtbWluZ2VyIFttYWls
dG86c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmddDQo+ID4gPiA+PiBTZW50OiBNb25kYXksIDE4
IEF1Z3VzdCAyMDI1IDE4LjM0DQo+ID4gPiA+Pg0KPiA+ID4gPj4gT24gV2VkLCAxMiBNYXIgMjAy
NSAxNjoxNToyOSAtMDcwMA0KPiA+ID4gPj4gU3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5AbmV0
d29ya3BsdW1iZXIub3JnPiB3cm90ZToNCj4gPiA+ID4+DQo+ID4gPiA+Pj4gVGhpcyBzZXJpZXMg
YWRkcyBjb21tb24gbWFjcm9zIGZvciBzYWZlIGl0ZXJhdGlvbiBvdmVyIGxpc3RzLg0KPiA+ID4g
Pj4+IEl0IGlzIGEgc3Vic2V0IGNvcHkgb2YgdGhlIG1hY3JvcyBmcm9tIEZyZWVCU0QgdGhhdCBh
cmUNCj4gPiA+ID4+PiBtaXNzaW5nIGZyb20gdGhlIExpbnV4IGhlYWRlciBzeXMvcXVldWUuaA0K
PiA+ID4gPj4+DQo+ID4gPiA+Pj4gQ2hvc2UgdGhpcyBvdmVyIHNldmVyYWwgb3RoZXIgb3B0aW9u
czoNCj4gPiA+ID4+PiAgICAtIGxldCBlYWNoIGRyaXZlciBkZWZpbmUgdGhlaXIgb3duIGFzIG5l
ZWRlZC4NCj4gPiA+ID4+PiAgICAgIE9uZSBJbnRlbCBkcml2ZXIgZ290IGl0IHdyb25nLCBvdGhl
cnMgd2lsbCBhcyB3ZWxsLg0KPiA+ID4gPj4+ICAgIC0gcmVuYW1lIGFsbCB0aGUgcXVldWUgbWFj
cm9zIHRvIFJURV9YWFggdmFyaWFudHMuDQo+ID4gPiA+Pj4gICAgICBTZWVtcyBsaWtlIHVzZWxl
c3MgcmVuYW1pbmcgYW5kIGNvbmZ1c2lvbi4NCj4gPiA+ID4+PiAgICAtIFNldmVyYWwgZGlzdHJv
cyBoYXZlIGxpYmJzZCBwYWNrYWdlIHdpdGggdGhlIGNvcnJlY3QgbWFjcm9zLg0KPiA+ID4gPj4+
ICAgICAgQnV0IGFkZGluZyB5ZXQgYW5vdGhlciBkZXBlbmRlbmN5IHRvIERQREsgd291bGQgYmUg
YW5ub3lpbmcNCj4gPiA+ID4+PiAgICAgIGZvciBzb21ldGhpbmcgdGhpcyBiYXNpYy4NCj4gPiA+
ID4+Pg0KPiA+ID4gPj4+IFRoZXJlIGFyZSBtb3JlIG1hY3JvcyBpbiBGcmVlQlNEIGhlYWRlciB0
aGF0IGNvdWxkIGJlIHVzZWZ1bCwNCj4gPiA+ID4+PiBidXQgd2UgY2FuIGFkZCB0aG9zZSBsYXRl
ciBhcyBuZWVkZWQgaGVyZS4NCj4gPiA+ID4+Pg0KPiA+ID4gPj4+ICAgbGliL2VhbC9pbmNsdWRl
L3J0ZV9xdWV1ZS5oICAgICAgICAgICAgICB8IDE3NA0KPiArKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ID4gPj4NCj4gPiA+ID4+IFJldmlzaXRpbmcgdGhpcyBhbmQgd29uZGVyaW5nIGFib3V0
IG5hbWluZy4uLg0KPiA+ID4gPj4gVGhlIGZpbGUgcnRlX3F1ZXVlLmggaXMgbm90IHJlYWxseSBE
UERLIChpZSBub3QgcmVsYXRlZCB0byBydW50aW1lDQo+ID4gPiA+PiBlbnZpcm9ubWVudCkuDQo+
ID4gPiA+PiBUaGlua2luZyBvZiBjYWxsaW5nIGl0IGJzZF9xdWV1ZS5oIGFzIGEgY29tcHJvbWlz
ZQ0KPiA+ID4gPg0KPiA+ID4gPiBTaW5jZSBpdCByZXBsYWNlcyBzeXMvcXVldWUuaCwgdGhlbiBt
YXliZSBzeXNfcXVldWUuaCAob3INCj4gcnRlX3N5c19xdWV1ZS5oKS4NCj4gPiA+ID4NCj4gPiA+
ID4gQnV0IG1vcmUgaW1wb3J0YW50bHk6DQo+ID4gPiA+IEl0IGlzIG5vdCByZWFsbHkgRFBESywg
YW5kIHRodXMgc2hvdWxkbid0IHJlYWxseSBiZSBwYXJ0IG9mIHRoZSBFQUwuDQo+ID4gPiA+IFNv
IGhlcmUncyBhbiBpZGVhOg0KPiA+ID4gPiBBcyBwYXJ0IG9mIGRlLWJsb2F0aW5nIHRoZSBFQUws
IGNhbiB3ZSBzb21laG93IGFkZCBhIG5ldyBkaXJlY3RvcnkNCj4gc3RydWN0dXJlDQo+ID4gPiBm
b3IgaW5kZXBlbmRlbnQgImxpYnJhcmllcyIgbGlrZSB0aGlzPw0KPiA+ID4gPiBBbmQgdHJlYXQg
dGhpcyBydGVfcXVldWUuaCBmaWxlIGFzIGEgImhlYWRlciBmaWxlIG9ubHkiIGxpYnJhcnksIGFu
ZCBwdXQNCj4gaXQNCj4gPiA+IHRoZXJlLg0KPiA+ID4gPiBUaGVuLCBidWlsZCB3aXNlLCB0aGUg
RUFMIGNvdWxkIGRlcGVuZCBvbiB0aGlzICJsaWJyYXJ5Ii4NCj4gPiA+ID4NCj4gPiA+DQo+ID4g
PiBJTU8gaXQgZGVwZW5kcyBvbiB3aGF0IHlvdSBtZWFuIGJ5ICJFQUwiLiBFQUwgaXMgZW52aXJv
bm1lbnQgYWJzdHJhY3Rpb24NCj4gPiA+IGxheWVyLCBhbmQgdGhpcyBoZWFkZXIgYWJzdHJhY3Rz
IE9TLCB0aGVyZWJ5IG1lZXRpbmcgZGVzY3JpcHRpb24gb2YgYW4NCj4gPiA+ICJlbnZpcm9ubWVu
dCBhYnN0cmFjdGlvbiBsYXllciI/DQo+ID4NCj4gPiBUaGlzIGxpYnJhcnkgKGhlYWRlciBmaWxl
KSBpcyBnZW5lcmljLCBhbmQgaGFzIHplcm8gaW50ZXJhY3Rpb24gd2l0aCB0aGUNCj4gaGFyZHdh
cmUgYW5kIE9TLCBzbyBpdCdzIG5vdCBhbiBlbnZpcm9ubWVudCBhYnN0cmFjdGlvbi4NCj4gDQo+
IEkgZGlzYWdyZWUgaGVyZSwgaXQgaXMgc29tZXRoaW5nIGR1ZSBieSB0aGUgT1MgbGliYywNCj4g
YnV0IG5vdCByZWxpYWJseSBhdmFpbGFibGUgZXZlcnl3aGVyZS4NCj4gDQo+ID4gVGhlIEVBTCBo
YXMgYmVjb21lIGEgZHVtcCBmb3IgImV2ZXJ5dGhpbmcgZWxzZSIgdGhhdCBpc24ndCBhbiBpbmRp
dmlkdWFsDQo+IGxpYnJhcnkgd2l0aCBpdHMgb3duIHN1YmRpcmVjdG9yeSBvZiB0aGUgL2xpYiBk
aXJlY3RvcnkuDQo+ID4gSU1PLCBpdCB3b3VsZCBiZSBuaWNlIGlmIHdlIGNvdWxkIHNlcGFyYXRl
IGdlbmVyaWMgdXRpbGl0eSBsaWJyYXJpZXMgZnJvbQ0KPiB0aGUgRUFMLg0KPiANCj4gSSBhZ3Jl
ZSB3aXRoIHRoZSBnb2FsIG9mIGhhdmluZyBhIHRoaW5uZXIgRUFMLg0KPiANCj4gSSdtIG5vdCBz
dXJlIGFib3V0IHRoaXMgb25lLg0KDQpJIHRob3VnaHQgdGhpcyBmaWxlIG1pZ2h0IGJlIGEgZ29v
ZCBwbGFjZSB0byBzdGFydCBzZXBhcmF0aW5nIHV0aWxpdGllcyBmcm9tIGFic3RyYWN0aW9uLg0K
SG93ZXZlciwgYSB3ZWxsIGRlc2lnbmVkIHJvYWRtYXAgdG8gcmUtb3JnYW5pemUgdGhlIEVBTCBp
cyBwcm9iYWJseSBiZXR0ZXIgdGhhbiBzdGFydGluZyB3aXRoIHRoaXMgc3BlY2lmaWMgbGlicmFy
eS4NCg0KU29ycnkgKG5vdCBzb3JyeSkgYWJvdXQgdGhlIG5vaXNlLiBJIHdpbGwga2VlcCByZW1p
bmRpbmcgdGhlIGNvbW11bml0eSBhYm91dCB0aGUgYmxvYXRlZCBFQUwgZnJvbSB0aW1lIHRvIHRp
bWUuIDotKQ0KDQo=
