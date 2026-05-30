Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F250CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 05:31:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3569E40262;
	Sat, 30 May 2026 07:31:46 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 73CD9400D6
 for <dev@dpdk.org>; Sat, 30 May 2026 07:31:44 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 3BEF22098F;
 Sat, 30 May 2026 07:31:44 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] app/test: use memcpy in ipsec test
Date: Sat, 30 May 2026 07:31:40 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658BA@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260529155254.6f563f48@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] app/test: use memcpy in ipsec test
Thread-Index: AdzvvedKB1FFVjD5QGe76Y1l7mDXAgAN4Hdw
References: <20260529154651.128372-1-stephen@networkplumber.org><cd2886ccd3134ab0a712e739bad4da5e@huawei.com><98CBD80474FA8B44BF855DF32C47DC35F658B7@smartserver.smartshare.dk>
 <20260529155254.6f563f48@phoenix.local>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, <dev@dpdk.org>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>
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
b3JnXQ0KPiBTZW50OiBTYXR1cmRheSwgMzAgTWF5IDIwMjYgMDAuNTMNCj4gDQo+IE9uIEZyaSwg
MjkgTWF5IDIwMjYgMjI6NDU6MDAgKzAyMDANCj4gTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hh
cmVzeXN0ZW1zLmNvbT4gd3JvdGU6DQo+IA0KPiA+ID4gPiBAQCAtNjA0LDIyICs2MDMsMjIgQEAg
c2V0dXBfdGVzdF9zdHJpbmdfdHVubmVsZWQoc3RydWN0DQo+IHJ0ZV9tZW1wb29sDQo+ID4gPiA+
ICptcG9vbCwgY29uc3QgY2hhciAqc3RyaW5nLA0KPiA+ID4gPiAgCS8qIGNvcHkgb3V0ZXIgSVAg
YW5kIEVTUCBoZWFkZXIgKi8NCj4gPiA+ID4gIAlpcHY0X291dGVyLnRvdGFsX2xlbmd0aCA9IHJ0
ZV9jcHVfdG9fYmVfMTYodF9sZW4pOw0KPiA+ID4gPiAgCWlwdjRfb3V0ZXIucGFja2V0X2lkID0g
cnRlX2NwdV90b19iZV8xNihzZXEpOw0KPiA+ID4gPiAtCXJ0ZV9tZW1jcHkoZHN0LCAmaXB2NF9v
dXRlciwgc2l6ZW9mKGlwdjRfb3V0ZXIpKTsNCj4gPiA+ID4gKwltZW1jcHkoZHN0LCAmaXB2NF9v
dXRlciwgc2l6ZW9mKGlwdjRfb3V0ZXIpKTsNCj4gPg0KPiA+IEhvdyBhYm91dDoNCj4gPiAqZHN0
ID0gaXB2NF9vdXRlcjsNCj4gPg0KPiA+IERvbid0IGtub3cgaWYgaXQgYXBwbGllcyBoZXJlLg0K
PiANCj4gR29vZCBpZGVhIGJ1dCBkc3QgaXMgY2hhciAqLg0KPiBJIHN1cHBvc2UgY291bGQgdXNl
IGEgY2FzdCBidXQgYXQgdGhhdCBwb2ludCB0aGUgZ29vZA0KPiBwcm9wZXJ0aWVzIG9mIGFzc2ln
bm1lbnQgZGlzYXBwZWFyLg0KPiANCj4gRGlkbid0IHdhbnQgdG8gZ28gY2hhbmdpbmcgb3RoZXIg
Y29kZS4NCg0KQWdyZWUuIEJldHRlciBzdGljayB3aXRoIG1lbWNweSgpIHRoYW4gdHlwZSBjYXN0
Lg0KDQo=
