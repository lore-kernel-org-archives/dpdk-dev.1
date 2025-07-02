Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81215C83013
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 05:56:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AA4E40285;
	Wed,  2 Jul 2025 07:56:54 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 186FA40269
 for <dev@dpdk.org>; Wed,  2 Jul 2025 07:56:53 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id CA42D20636;
 Wed,  2 Jul 2025 07:56:52 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: Does rte_net_get_ptype() support processing packets with two
 0x8100 VLAN tags?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Wed, 2 Jul 2025 07:56:50 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD80@smartserver.smartshare.dk>
In-Reply-To: <e158a8b8-74d1-4df9-ada7-7485ac58336b@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Does rte_net_get_ptype() support processing packets with two
 0x8100 VLAN tags?
Thread-Index: Advq+l8OCRdR9alBSNKIlRp3mvSrHAAGSZJA
References: <e158a8b8-74d1-4df9-ada7-7485ac58336b@huawei.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "huangdengdui" <huangdengdui@huawei.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>, <jasvinder.singh@intel.com>,
 <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, "liuyonglong" <liuyonglong@huawei.com>
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

PiBGcm9tOiBodWFuZ2RlbmdkdWkgW21haWx0bzpodWFuZ2RlbmdkdWlAaHVhd2VpLmNvbV0NCj4g
U2VudDogV2VkbmVzZGF5LCAyIEp1bHkgMjAyNSAwNC4zOA0KPiANCj4gSGkgZXZlcnlvbmUsDQo+
IA0KPiBUaGUgY3VycmVudCBydGVfbmV0X2dldF9wdHlwZSgpIG9ubHkgc3VwcG9ydHMgcGFyc2lu
ZyBwYWNrZXRzIHdpdGggIGENCj4gc2luZ2xlIDB4ODEwMCBWTEFOIHRhZyBhbmQgdHdvIDB4ODhh
OCBWTEFOIHRhZ3MsDQo+IGJ1dCBkb2VzIG5vdCBzdXBwb3J0IHByb2Nlc3NpbmcgcGFja2V0cyB3
aXRoIHR3byAweDgxMDAgVkxBTiB0YWdzLg0KPiANCj4gU29tZSBuZXR3b3JrIGNhcmRzIChlLmcu
LCBobnMzKSBkbyBzdXBwb3J0IHBhcnNpbmcgcGFja2V0cyB3aXRoIHR3bw0KPiAweDgxMDAgVkxB
TiB0YWdzLg0KPiBDYW4gdGhpcyBBUEkgYmUgZXh0ZW5kZWQgdG8gc3VwcG9ydCBzdWNoIHBhY2tl
dHM/DQoNCkl0IGFscmVhZHkgZG9lczsgdGhlIGxheWVycyBwYXJhbWV0ZXIgbXVzdCBoYXZlIFJU
RV9QVFlQRV9JTk5FUl9MMl9NQVNLIHNldC4NCg0KPiANCj4gSSB1bmRlcnN0YW5kIHRoYXQgdHdv
IDB4ODEwMCBWTEFOIHRhZyBwYWNrZXRzIGFyZW4ndCBjb21tb25seSB1c2VkLCBzbw0KPiBJJ20g
dW5jZXJ0YWluIHdoZXRoZXIgYWRkaW5nIHN1cHBvcnQgaXMgbmVjZXNzYXJ5Lg0KDQpBRkFJUiwg
aXQncyBjYWxsZWQgIlZMQU4gU3RhY2tpbmciLg0KU3RhY2tpbmcgdHdvIDB4ODEwMCBWTEFOIHRh
Z3MgaXMgY29tbW9ubHkgdXNlZC4NCkUuZy4gdGhlIG1ham9yaXR5IG9mIGNvbnN1bWVyIGZpYmVy
IGludGVybmV0IGNvbm5lY3Rpb25zIGluIERlbm1hcmsgdXNlIFZMQU4gU3RhY2tpbmcgKG5vdCBR
aW5RKSBhdCB0aGUgbmV0d29yayBvd25lcnMnIFBvaW50cy1vZi1JbnRlcmNvbm5lY3QgZm9yIHRo
ZSBzZXJ2aWNlIHByb3ZpZGVycyB0byBpZGVudGlmeSBpbmRpdmlkdWFsIGhvbWVzLg0KDQo+IA0K
PiBBbnlvbmUgaXMgd2VsY29tZSB0byBkaXNjdXNzIHRoaXMgYW5kIHNoYXJlIHRoZWlyIG9waW5p
b25zLg0KPiANCj4gVGhhbmtzLA0KPiAvRGVuZ2R1aQ0K
