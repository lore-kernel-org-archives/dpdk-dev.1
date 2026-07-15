Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5442AC44507
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 09:02:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48C8C40290;
	Wed, 15 Jul 2026 11:02:09 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id BA0984028B
 for <dev@dpdk.org>; Wed, 15 Jul 2026 11:02:08 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 770642033E;
 Wed, 15 Jul 2026 11:02:08 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: mempool cache change
Date: Wed, 15 Jul 2026 11:02:07 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6596E@smartserver.smartshare.dk>
In-Reply-To: <e0b59e0b-1fb7-4a7b-84bb-9fc47f4feb5a@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mempool cache change
Thread-Index: Ad0UMaAaUYxlF7KGSBCr3Sh3BZWuCQABbuaw
X-MimeOLE: Produced By Microsoft Exchange V6.5
References: <b54ad1f1692a0274da705d446972efd1@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596D@smartserver.smartshare.dk>
 <e0b59e0b-1fb7-4a7b-84bb-9fc47f4feb5a@huawei.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "fengchengwen" <fengchengwen@huawei.com>,
 "Kishore Padmanabha" <kishore.padmanabha@broadcom.com>,
 "Thomas Monjalon" <thomas@monjalon.net>
Cc: <dev@dpdk.org>,
	"Wisam Jaddo" <wisamm@nvidia.com>
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

PiBGcm9tOiBmZW5nY2hlbmd3ZW4gW21haWx0bzpmZW5nY2hlbmd3ZW5AaHVhd2VpLmNvbV0NCj4g
U2VudDogV2VkbmVzZGF5LCAxNSBKdWx5IDIwMjYgMTAuMTINCj4gDQo+IE9uIDcvMTUvMjAyNiA0
OjA4IEFNLCBNb3J0ZW4gQnLDuHJ1cCB3cm90ZToNCj4gPiBIaSBLaXNob3JlLA0KPiA+DQo+ID4g
Rm9yIHlvdXIgdGVzdGluZyBwdXJwb3NlcywgcGxlYXNlIGZvbGxvdyB0aGUgZ3VpZGFuY2UgcHJv
dmlkZWQgdG8NCj4gV2lzYW0gSmFkZG86DQo+ID4NCj4gaHR0cHM6Ly9pbmJveC5kcGRrLm9yZy9k
ZXYvOThDQkQ4MDQ3NEZBOEI0NEJGODU1REYzMkM0N0RDMzVGNjU5NjRAc21hcnQNCj4gc2VydmVy
LnNtYXJ0c2hhcmUuZGsvDQo+IA0KPiBXZSBuZWVkIHRvIHJlY29tcGlsZSBpbiB0aGlzIGNhc2Uu
IFdlIHNob3VsZCB0cnkgdG8gYXZvaWQNCj4gcmVjb21waWxhdGlvbi4NCj4gSSB0aGluayBpdCBp
cyBuZWNlc3NhcnkgdG8gYWRqdXN0IFJURV9NRU1QT09MX0NBQ0hFX01BWF9TSVpFIHRvIDc2OCBh
cw0KPiBhIGRlZmF1bHQgY29uZmlndXJhdGlvbi4NCg0KQ2hhbmdpbmcgUlRFX01FTVBPT0xfQ0FD
SEVfTUFYX1NJWkUgYnJlYWtzIGJvdGggdGhlIEFQSSBhbmQgdGhlIEFCSTsgc28gaXQgaGFzIHRv
IGJlIGRvbmUgd2hlbiBidWlsZGluZyBsb2NhbGx5LCB3aGVyZSBBUEkvQUJJIGJyZWFrYWdlIGlz
IGFjY2VwdGFibGUuDQoNCkZvciBEUERLIDI2LjExLCB3aGVyZSBBUEkvQUJJIGJyZWFrYWdlIGlz
IGFjY2VwdGFibGUsIHdlIGNhbiBkaXNjdXNzIGluY3JlYXNpbmcgdGhlIGRlZmF1bHQgZnJvbSA1
MTIgdG8gYSBoaWdoZXIgdmFsdWUuIEkgZG8gaGF2ZSBzb21lIGlucHV0IHRvIHRoYXQgZGlzY3Vz
c2lvbiwgYnV0IGxldCdzIHBvc3Rwb25lIGl0IHVudGlsIGFmdGVyIERQREsgMjYuMDcgaGFzIGJl
ZW4gcmVsZWFzZWQuDQoNCj4gDQo+IFRoYW5rcw0KPiANCj4gPg0KPiA+IFRoYW5rIHlvdSBmb3Ig
dGVzdGluZyENCj4gPg0KPiA+IFZlbmxpZyBoaWxzZW4gLyBLaW5kIHJlZ2FyZHMsDQo+ID4gLU1v
cnRlbiBCcsO4cnVwDQo+ID4NCj4gPiBGcm9tOiBLaXNob3JlIFBhZG1hbmFiaGEgW21haWx0bzpr
aXNob3JlLnBhZG1hbmFiaGFAYnJvYWRjb20uY29tXQ0KPiA+IFNlbnQ6IFR1ZXNkYXksIDE0IEp1
bHkgMjAyNiAxOC40OQ0KPiA+IFRvOiBUaG9tYXMgTW9uamFsb247IE1vcnRlbiBCcsO4cnVwDQo+
ID4gQ2M6IGRldkBkcGRrLm9yZw0KPiA+IFN1YmplY3Q6IG1lbXBvb2wgY2FjaGUgY2hhbmdlDQo+
ID4NCj4gPiBIaSBUaG9tYXMsDQo+ID4NCj4gPiBUaGUgcmVjZW50IGNoYW5nZSBkb25lIGFzIHBh
cnQgb2YgQlVHIElEOiAxMDI3LCB3aXRoIGNvbW1pdCBpZA0KPiBodHRwczovL2dpdC5kcGRrLm9y
Zy9kcGRrL2NvbW1pdC8/aWQ9ZjVlMTMxMGYxNmUwOTA5ZTdlN2Y3MTgwNzEyMzY0NGM2Mw0KPiBi
MjNjYmENCj4gPiBJcyBjYXVzaW5nIHBlcmZvcm1hbmNlIGRyb3AgZm9yIHRoZSBibnh0IE5JQyBp
biAyNi4wNyByZWxlYXNlLg0KPiA+DQo+ID4gVGhlIHNtYWxsZXIsIHNoYWxsb3dlciBjYWNoZSBp
bmNyZWFzZXMgdGhlIG1pc3MgcmF0ZSwgY2F1c2luZyByZWZpbGxzDQo+IHRvIGhpdCB0aGUgc2hh
cmVkIHJpbmcgbW9yZSBmcmVxdWVudGx5Lg0KPiA+IEluIHRoZSBvbGQgY29kZSwgdGhlIGNhY2hl
IG9ubHkgdG91Y2hlZCB0aGUgc2hhcmVkIHJpbmcgd2hlbiBpdA0KPiBjbGltYmVkIHBhc3QgNzY4
IGluc3RlYWQgb2YgNTEyLiBUaGF0IGV4dHJhIDI1NiBlbGVtZW50cyBvZiBoZWFkcm9vbQ0KPiBh
bGxvd2VkIHNpZ25pZmljYW50bHkgbW9yZSBmcmVlcyB0byByZW1haW4gbG9jYWwuDQo+ID4NCj4g
PiBDb3VsZCB3ZSBtYWtlIHRoZSBjaGFuZ2UgaW4gY29uZmlnL3J0ZV9jb25maWcuaCBmb3INCj4g
UlRFX01FTVBPT0xfQ0FDSEVfTUFYX1NJWkUgdG8gYmUgNzY4IGluc3RlYWQgb2YgNTEyLiBTaW5j
ZSB3ZSB1c2Ug4oCTDQo+IG1iY2FjaGU9NTEyIGFzIGFyZ3VtZW50IGZvciB0aGUgcGVyZm9ybWFu
Y2UgdGVzdHMuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gS2lzaG9yZQ0KPiA+DQo+ID4NCg0K
