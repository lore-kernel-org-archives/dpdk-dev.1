Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447A1CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 15:08:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12CAC4029E;
	Wed, 27 Aug 2025 17:08:55 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9F70D40292
 for <dev@dpdk.org>; Wed, 27 Aug 2025 17:08:53 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5B26020A24;
 Wed, 27 Aug 2025 17:08:53 +0200 (CEST)
Subject: RE: [PATCH v3 0/9] introduce common FOREACH_SAFE macros
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Wed, 27 Aug 2025 17:08:50 +0200
Content-class: urn:content-classes:message
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE79@smartserver.smartshare.dk>
In-Reply-To: <e9017361-f29b-45da-a1b0-cc745b8c906f@intel.com>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 0/9] introduce common FOREACH_SAFE macros
Thread-Index: AdwXXN7pa7ZX4nxsRkqhKBSl8oedPQABcMNQ
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250312231715.222149-1-stephen@networkplumber.org>
 <20250818093416.057aad97@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE53@smartserver.smartshare.dk>
 <e9017361-f29b-45da-a1b0-cc745b8c906f@intel.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>,
 "Tyler Retzlaff" <roretzla@microsoft.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Thomas Monjalon" <thomas@monjalon.net>
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

PiBGcm9tOiBCdXJha292LCBBbmF0b2x5IFttYWlsdG86YW5hdG9seS5idXJha292QGludGVsLmNv
bV0NCj4gU2VudDogV2VkbmVzZGF5LCAyNyBBdWd1c3QgMjAyNSAxNi4xNA0KPiANCj4gT24gOC8y
MC8yMDI1IDg6NDIgQU0sIE1vcnRlbiBCcsO4cnVwIHdyb3RlOg0KPiA+PiBGcm9tOiBTdGVwaGVu
IEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnXQ0KPiA+PiBTZW50
OiBNb25kYXksIDE4IEF1Z3VzdCAyMDI1IDE4LjM0DQo+ID4+DQo+ID4+IE9uIFdlZCwgMTIgTWFy
IDIwMjUgMTY6MTU6MjkgLTA3MDANCj4gPj4gU3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5AbmV0
d29ya3BsdW1iZXIub3JnPiB3cm90ZToNCj4gPj4NCj4gPj4+IFRoaXMgc2VyaWVzIGFkZHMgY29t
bW9uIG1hY3JvcyBmb3Igc2FmZSBpdGVyYXRpb24gb3ZlciBsaXN0cy4NCj4gPj4+IEl0IGlzIGEg
c3Vic2V0IGNvcHkgb2YgdGhlIG1hY3JvcyBmcm9tIEZyZWVCU0QgdGhhdCBhcmUNCj4gPj4+IG1p
c3NpbmcgZnJvbSB0aGUgTGludXggaGVhZGVyIHN5cy9xdWV1ZS5oDQo+ID4+Pg0KPiA+Pj4gQ2hv
c2UgdGhpcyBvdmVyIHNldmVyYWwgb3RoZXIgb3B0aW9uczoNCj4gPj4+ICAgIC0gbGV0IGVhY2gg
ZHJpdmVyIGRlZmluZSB0aGVpciBvd24gYXMgbmVlZGVkLg0KPiA+Pj4gICAgICBPbmUgSW50ZWwg
ZHJpdmVyIGdvdCBpdCB3cm9uZywgb3RoZXJzIHdpbGwgYXMgd2VsbC4NCj4gPj4+ICAgIC0gcmVu
YW1lIGFsbCB0aGUgcXVldWUgbWFjcm9zIHRvIFJURV9YWFggdmFyaWFudHMuDQo+ID4+PiAgICAg
IFNlZW1zIGxpa2UgdXNlbGVzcyByZW5hbWluZyBhbmQgY29uZnVzaW9uLg0KPiA+Pj4gICAgLSBT
ZXZlcmFsIGRpc3Ryb3MgaGF2ZSBsaWJic2QgcGFja2FnZSB3aXRoIHRoZSBjb3JyZWN0IG1hY3Jv
cy4NCj4gPj4+ICAgICAgQnV0IGFkZGluZyB5ZXQgYW5vdGhlciBkZXBlbmRlbmN5IHRvIERQREsg
d291bGQgYmUgYW5ub3lpbmcNCj4gPj4+ICAgICAgZm9yIHNvbWV0aGluZyB0aGlzIGJhc2ljLg0K
PiA+Pj4NCj4gPj4+IFRoZXJlIGFyZSBtb3JlIG1hY3JvcyBpbiBGcmVlQlNEIGhlYWRlciB0aGF0
IGNvdWxkIGJlIHVzZWZ1bCwNCj4gPj4+IGJ1dCB3ZSBjYW4gYWRkIHRob3NlIGxhdGVyIGFzIG5l
ZWRlZCBoZXJlLg0KPiA+Pj4NCj4gPj4+ICAgbGliL2VhbC9pbmNsdWRlL3J0ZV9xdWV1ZS5oICAg
ICAgICAgICAgICB8IDE3NCArKysrKysrKysrKysrKysrKysrKysrKw0KPiA+Pg0KPiA+PiBSZXZp
c2l0aW5nIHRoaXMgYW5kIHdvbmRlcmluZyBhYm91dCBuYW1pbmcuLi4NCj4gPj4gVGhlIGZpbGUg
cnRlX3F1ZXVlLmggaXMgbm90IHJlYWxseSBEUERLIChpZSBub3QgcmVsYXRlZCB0byBydW50aW1l
DQo+ID4+IGVudmlyb25tZW50KS4NCj4gPj4gVGhpbmtpbmcgb2YgY2FsbGluZyBpdCBic2RfcXVl
dWUuaCBhcyBhIGNvbXByb21pc2UNCj4gPg0KPiA+IFNpbmNlIGl0IHJlcGxhY2VzIHN5cy9xdWV1
ZS5oLCB0aGVuIG1heWJlIHN5c19xdWV1ZS5oIChvciBydGVfc3lzX3F1ZXVlLmgpLg0KPiA+DQo+
ID4gQnV0IG1vcmUgaW1wb3J0YW50bHk6DQo+ID4gSXQgaXMgbm90IHJlYWxseSBEUERLLCBhbmQg
dGh1cyBzaG91bGRuJ3QgcmVhbGx5IGJlIHBhcnQgb2YgdGhlIEVBTC4NCj4gPiBTbyBoZXJlJ3Mg
YW4gaWRlYToNCj4gPiBBcyBwYXJ0IG9mIGRlLWJsb2F0aW5nIHRoZSBFQUwsIGNhbiB3ZSBzb21l
aG93IGFkZCBhIG5ldyBkaXJlY3Rvcnkgc3RydWN0dXJlDQo+IGZvciBpbmRlcGVuZGVudCAibGli
cmFyaWVzIiBsaWtlIHRoaXM/DQo+ID4gQW5kIHRyZWF0IHRoaXMgcnRlX3F1ZXVlLmggZmlsZSBh
cyBhICJoZWFkZXIgZmlsZSBvbmx5IiBsaWJyYXJ5LCBhbmQgcHV0IGl0DQo+IHRoZXJlLg0KPiA+
IFRoZW4sIGJ1aWxkIHdpc2UsIHRoZSBFQUwgY291bGQgZGVwZW5kIG9uIHRoaXMgImxpYnJhcnki
Lg0KPiA+DQo+IA0KPiBJTU8gaXQgZGVwZW5kcyBvbiB3aGF0IHlvdSBtZWFuIGJ5ICJFQUwiLiBF
QUwgaXMgZW52aXJvbm1lbnQgYWJzdHJhY3Rpb24NCj4gbGF5ZXIsIGFuZCB0aGlzIGhlYWRlciBh
YnN0cmFjdHMgT1MsIHRoZXJlYnkgbWVldGluZyBkZXNjcmlwdGlvbiBvZiBhbg0KPiAiZW52aXJv
bm1lbnQgYWJzdHJhY3Rpb24gbGF5ZXIiPw0KDQpUaGlzIGxpYnJhcnkgKGhlYWRlciBmaWxlKSBp
cyBnZW5lcmljLCBhbmQgaGFzIHplcm8gaW50ZXJhY3Rpb24gd2l0aCB0aGUgaGFyZHdhcmUgYW5k
IE9TLCBzbyBpdCdzIG5vdCBhbiBlbnZpcm9ubWVudCBhYnN0cmFjdGlvbi4NClRoZSBFQUwgaGFz
IGJlY29tZSBhIGR1bXAgZm9yICJldmVyeXRoaW5nIGVsc2UiIHRoYXQgaXNuJ3QgYW4gaW5kaXZp
ZHVhbCBsaWJyYXJ5IHdpdGggaXRzIG93biBzdWJkaXJlY3Rvcnkgb2YgdGhlIC9saWIgZGlyZWN0
b3J5Lg0KSU1PLCBpdCB3b3VsZCBiZSBuaWNlIGlmIHdlIGNvdWxkIHNlcGFyYXRlIGdlbmVyaWMg
dXRpbGl0eSBsaWJyYXJpZXMgZnJvbSB0aGUgRUFMLg0KDQo=
