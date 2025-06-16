Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4A4C71155
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 14:31:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDDC9402BC;
	Mon, 16 Jun 2025 16:31:02 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 07B44402B5
 for <dev@dpdk.org>; Mon, 16 Jun 2025 16:31:01 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BD0EB200E2;
 Mon, 16 Jun 2025 16:31:00 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v2 2/2] ethdev: remove callback checks from fast path
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 16 Jun 2025 16:30:57 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FCFC@smartserver.smartshare.dk>
In-Reply-To: <CO6PR18MB3860D388FFE168A3ED50D5F4B470A@CO6PR18MB3860.namprd18.prod.outlook.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 2/2] ethdev: remove callback checks from fast path
Thread-Index: AQHbw0+l0RHSW4O8306bysHIPKBvWrPn4SoAgBQkLbCACab9cIAAY0DA
References: <20250429181132.2544771-1-skori@marvell.com>
 <20250512150732.65743-1-skori@marvell.com>
 <20250512150732.65743-2-skori@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC9E@smartserver.smartshare.dk>
 <CO6PR18MB386002BE3B4FF5646A41404AB46AA@CO6PR18MB3860.namprd18.prod.outlook.com>
 <CO6PR18MB3860D388FFE168A3ED50D5F4B470A@CO6PR18MB3860.namprd18.prod.outlook.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Sunil Kumar Kori" <skori@marvell.com>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>
Cc: <dev@dpdk.org>, "Thomas Monjalon" <thomas@monjalon.net>,
 "Ferruh Yigit" <ferruh.yigit@amd.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
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
bnQ6IE1vbmRheSwgMTYgSnVuZSAyMDI1IDEwLjM2DQo+IA0KPiA+ID4gPiBGcm9tOiBTdW5pbCBL
dW1hciBLb3JpIDxza29yaUBtYXJ2ZWxsLmNvbT4NCj4gPiA+ID4gU2VudDogTW9uZGF5LCAxMiBN
YXkgMjAyNSAxNy4wNw0KPiA+ID4gPg0KPiA+ID4gPiBydGVfZXRoX2ZwX29wcyBjb250YWlucyBv
cHMgZm9yIGZhc3QgcGF0aCBBUElzLiBFYWNoIEFQSSB2YWxpZGF0ZXMNCj4gPiA+ID4gYXZhaWxh
YmlsaXR5IG9mIGNhbGxiYWNrIGFuZCB0aGVuIGludm9rZSBpdC4NCj4gPiA+ID4gVGhlc2UgY2hl
Y2tzIGltcGFjdCBkYXRhIHBhdGggcGVyZm9ybWFjZS4NCj4gPiA+DQo+ID4gPiBQaWNraW5nIHVw
IHRoZSBkaXNjdXNzaW9uIGZyb20gYW5vdGhlciB0aHJlYWQgWzFdOg0KPiA+ID4NCj4gPiA+ID4g
RnJvbTogS29uc3RhbnRpbiBBbmFueWV2IFttYWlsdG86a29uc3RhbnRpbi5hbmFueWV2QGh1YXdl
aS5jb21dDQo+ID4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgMjggTWF5IDIwMjUgMTEuMTQNCj4gPiA+
ID4NCj4gPiA+ID4gU28gd2hhdCB3ZSBhcmUgc2F2aW5nIHdpdGggdGhhdCBwYXRjaDogb25lIGNt
cCBhbmQgb25lIHVuLXRha2VuIGJyYW5jaDoNCj4gPiA+ID4gQEAgLTYzOTksOCArNjM5OSw2IEBA
IHJ0ZV9ldGhfcnhfcXVldWVfY291bnQodWludDE2X3QgcG9ydF9pZCwNCj4gPiA+ID4gdWludDE2
X3QNCj4gPiA+ID4gcXVldWVfaWQpDQo+ID4gPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+ID4g
PiAgI2VuZGlmDQo+ID4gPiA+DQo+ID4gPiA+IC0JaWYgKHAtPnJ4X3F1ZXVlX2NvdW50ID09IE5V
TEwpDQo+ID4gPiA+IC0JCXJldHVybiAtRU5PVFNVUDsNCj4gPiA+ID4gIAlyZXR1cm4gcC0+cnhf
cXVldWVfY291bnQocWQpOw0KPiA+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+IFRoZXNlIGFyZSBpbmxp
bmUgZnVuY3Rpb25zLCBzbyB3ZSBhbHNvIHNhdmUgc29tZSBjb2RlIHNwYWNlLA0KPiA+ID4gaW5z
dHJ1Y3Rpb24gY2FjaGUsIGFuZCBwb3NzaWJseSBhbiBlbnRyeSBpbiB0aGUgYnJhbmNoIHByZWRp
Y3RvciAtDQo+ID4gPiBldmVyeXdoZXJlIHRoZXNlIGZ1bmN0aW9ucyBhcmUgaW5zdGFudGlhdGVk
IGJ5IHRoZSBjb21waWxlci4NCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEkgd29uZGVyIGlzIGhv
dyByZWFsaXN0aWMgKGFuZCBtZWFzdXJhYmxlKSBpcyB0aGUgZ2Fpbj8NCj4gPiA+DQo+ID4gPiBU
aGUgcGVyZm9ybWFuY2Ugb3B0aW1pemF0aW9uIGlzIG1haW5seSB0YXJnZXRpbmcgdGhlIG1idWYg
cmVjeWNsZQ0KPiA+ID4gb3BlcmF0aW9ucywgaS5lLiB0aGUgaG90IGZhc3QgcGF0aCwgd2hlcmUg
ZXZlcnkgY3ljbGUgY291bnRzLg0KPiA+ID4gQW5kIHdoaWxlIG9wdGltaXppbmcgdGhvc2UsIHRo
ZSBvdGhlciBldGhkZXYgZmFzdCBwYXRoIGNhbGxiYWNrcyBhcmUNCj4gPiA+IGFsc28gb3B0aW1p
emVkLg0KPiA+ID4NCj4gPiA+IFllcywgYWx0aG91Z2ggd2UgYWxsIGFncmVlIHRoYXQgdGhlcmUg
aXMgbm8gZG93bnNpZGUgdG8gdGhpcw0KPiA+ID4gb3B0aW1pemF0aW9uLCBpdCB3b3VsZCBiZSBu
aWNlIHRvIHNlZSBzb21lIHBlcmZvcm1hbmNlIG51bWJlcnMuDQo+ID4gPg0KPiA+IFN1cmUsIEkg
d2lsbCBnZXQgcGVyZm9ybWFuY2UgbnVtYmVycyBmb3IgTWFydmVsbCBwbGF0Zm9ybSBhbmQgd2ls
bCBzaGFyZS4NCj4gPg0KPiANCj4gSGkgTW9ydGVuLA0KPiBJIGdvdCBwZXJmb3JtYW5jZSBudW1i
ZXJzIG9uIG11bHRpcGxlIE1hcnZlbGwncyBwbGF0Zm9ybXMgYW5kIG9ic2VydmVkIGdhaW4NCj4g
YXJvdW5kIDAuMSUgKH4yMEsgcHBzKSB3aXRoIHRoaXMgcGF0Y2guIE90aGVyIHRoYW4gdGhpcywg
dGhlcmUgYXJlIG90aGVyIGZhc3QNCj4gcGF0aCBjYWxsYmFja3MgKHJ4X3BrdF9idXJzdCBhbmQg
dHhfcGt0X2J1cnN0KSB3aGljaCBhdm9pZCB0aGlzIGNoZWNrLg0KPiANCj4gSU1PLCB0aGlzIHBh
dGNoIGhhcyBubyBuZWdhdGl2ZSBpbXBhY3QgYW5kIHNsaWdodCBpbXByb3ZlbWVudCAmIGNsZWFu
dXAgdGhlDQo+IGZhc3QgcGF0aC4gUGxlYXNlIHN1Z2dlc3QuDQoNCkkgc3RpbGwgbGlrZSB0aGlz
IHBhdGNoLCBzbyBJIGNvbmZpcm0gbXkgQUNLOg0KDQpBY2tlZC1ieTogTW9ydGVuIEJyw7hydXAg
PG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCg0K
