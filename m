Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862B7CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 07:55:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A15B42799;
	Fri, 17 Oct 2025 09:55:35 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8BD8840269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 09:55:33 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4337E206E3;
 Fri, 17 Oct 2025 09:55:33 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v7 3/7] mbuf: record mbuf operations history
Date: Fri, 17 Oct 2025 09:55:30 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654D9@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <2943496.bcXerOTE6V@thomas>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v7 3/7] mbuf: record mbuf operations history
Thread-Index: Adw/OC7ogX/yC4ItSoOwbsAyraH5SQAAcmTg
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251016203557.2554678-4-thomas@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F654D7@smartserver.smartshare.dk>
 <2943496.bcXerOTE6V@thomas>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: <dev@dpdk.org>, <shperetz@nvidia.com>, <viacheslavo@nvidia.com>,
 <bruce.richardson@intel.com>, <stephen@networkplumber.org>
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
ZW50OiBGcmlkYXksIDE3IE9jdG9iZXIgMjAyNSAwOS4zMg0KPiANCj4gMTcvMTAvMjAyNSAwMDoy
OSwgTW9ydGVuIEJyw7hydXA6DQo+ID4gPiArCS8qIENhbGN1bGF0ZSB0b3RhbCBhbGxvY2F0ZWQg
bWJ1ZnMgKi8NCj4gPiA+ICsJdWludDY0X3QgdG90YWxfYWxsb2NhdGVkID0gMDsNCj4gPiA+ICsJ
Zm9yIChlbnVtIHJ0ZV9tYnVmX2hpc3Rvcnlfb3Agb3AgPSBSVEVfTUJVRl9ISVNUT1JZX09QX0xJ
Ql9BTExPQzsNCj4gPiA+ICsJCQlvcCA8IFJURV9NQlVGX0hJU1RPUllfT1BfTUFYOyBvcCsrKQ0K
PiA+ID4gKwkJdG90YWxfYWxsb2NhdGVkICs9IHN0YXRzW29wXTsNCj4gPg0KPiA+IEkgbWlnaHQg
YmUgb3Zlcmx5IGNhdXRpb3VzIGhlcmUsIGJ1dCB0aGUgYXBwIChvciBkcml2ZXIpIG1pZ2h0IGhh
dmUgYQ0KPiBidWcsIGFuZCBtYXJrIHRoZSBtYnVmIHdpdGggT1BfQVBQX0ZSRUUgKG9yIE9QX1BN
RF9GUkVFKSB3aXRob3V0DQo+IGFjdHVhbGx5IGZyZWVpbmcgdGhlIG1idWYgYmFjayB0byB0aGUg
bWVtcG9vbC4NCj4gDQo+IFllcw0KPiANCj4gPiBTbyB5b3Ugc2hvdWxkIG9ubHkgdHJ1c3QgdGhl
IG1lbXBvb2wgbGlicmFyeSAoT1BfTElCX0ZSRUUpIHRvIG1hcmsNCj4gdGhlIG1idWYgYXMgYWN0
dWFsbHkgZnJlZWQuIEkuZS4gc3RhcnQgdGhlIGxvb3AgYXQgb3AgPQ0KPiBSVEVfTUJVRl9ISVNU
T1JZX09QX0xJQl9GUkVFLg0KPiANCj4gV2UgY2Fubm90IGJlY2F1c2UgdGhlc2Ugc3RhdGlzdGlj
cyBhcmUgYWJvdXQgdGhlIGxhdGVzdCBzdGF0ZS4NCj4gU28gaWYgdGhlIGFwcCBtYXJrcyB0aGUg
bWJ1ZiBhcyBmcmVlZCBhZnRlciB0aGUgbGlicmFyeSwNCj4gdGhleSBzaG91bGQgYmUgcmVwb3J0
ZWQgYXMgbm9uIGFsbG9jYXRlZC4NCg0KVGhlIGFwcCBjYW5ub3QgbWFyayB0aGUgbWJ1ZiBhZnRl
ciBjYWxsaW5nIHJ0ZV9tYnVmX3Jhd19mcmVlX2J1bGsoKS4gVGhhdCB3b3VsZCBiZSBhICJ1c2Ug
YWZ0ZXIgZnJlZSIgYnVnLg0KDQo+IA0KPiA+IFRoZSBhcHAvZHJpdmVyIHNob3VsZCBldmVudHVh
bGx5IGNhbGwgcnRlX21idWZfcmF3X2ZyZWVfYnVsaygpIG9yDQo+IHNpbWlsYXIgdG8gcmVsZWFz
ZSB0aGUgbWJ1ZiBiYWNrIHRvIHRoZSBtZW1wb29sLg0KPiANCj4gQmVjYXVzZSB3ZSBkb24ndCBr
bm93IGluIHdoaWNoIG9yZGVyIHRoZSBtYnVmcyBhcmUgbWFya2VkDQo+IGluIHRoZSBjYWxsIHN0
YWNrLCB3ZSBtdXN0IHRydXN0IHRoZXNlIGZyZWUgb3BzLg0KPiANCj4gSSByZWFsbHkgdGhpbmsg
dGhlcmUgaXMgcm9vbSBmb3IgaW1wcm92ZW1lbnRzIGluIHRoZSBkZXRhaWxzIG9mIHRoZQ0KPiBt
YXJrcw0KPiBhbmQgdGhlaXIgdXNhZ2UuIEkgc3VnZ2VzdCB3ZSBtZXJnZSBhbmQgcGxheSB3aXRo
IHRoaXMgZXhwZXJpbWVudGFsDQo+IGZlYXR1cmUsDQo+IGFuZCBkaXNjdXNzIGluIHRoZSBuZXh0
IGN5Y2xlIGhvdyB0byBpbXByb3ZlIHRoZSBtYXJrZXJzLg0KPiANCg0KU2luY2UgaXQncyBvbmx5
IGEgbWlub3IgZGV0YWlsIGluIHRoZSBkdW1wIGZ1bmN0aW9uIHRoYXQgSSdtIGhhdmluZyBtaW5v
ciBkb3VidHMgYWJvdXQsIG1lcmdpbmcgYXMtaXMgaXMgT0sgd2l0aCBtZS4NCg0KSXQncyBtb3Jl
IGltcG9ydGFudCBnZXR0aW5nIHRoZSBmZWF0dXJlIGluY2x1ZGVkIHRoYW4gbWFraW5nIGl0IHBl
cmZlY3QgYXQgaXRzIGludHJvZHVjdGlvbiAtIGFzIHlvdSBtZW50aW9uIHlvdXJzZWxmOiBpdCdz
IGFuIGV4cGVyaW1lbnRhbCBmZWF0dXJlLg0KDQo=
