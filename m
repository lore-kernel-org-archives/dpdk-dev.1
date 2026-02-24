Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E40DEFB7F9
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 06:38:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 664E84027F;
	Tue, 24 Feb 2026 07:38:38 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1F3B5400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 07:38:37 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E48CD20770;
 Tue, 24 Feb 2026 07:38:36 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] mempool: introduce statistics reset function
Date: Tue, 24 Feb 2026 07:38:32 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65740@smartserver.smartshare.dk>
In-Reply-To: <6af4bdb3-0a0c-4d99-9852-376bf93d1a16@oktetlabs.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mempool: introduce statistics reset function
Thread-Index: AdylVu2U3o9RxGGpRUWxz6JQPGpmVwAABzdA
References: <20260223102054.336350-1-mb@smartsharesystems.com>
 <6af4bdb3-0a0c-4d99-9852-376bf93d1a16@oktetlabs.ru>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
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
YnMucnVdDQo+IFNlbnQ6IFR1ZXNkYXksIDI0IEZlYnJ1YXJ5IDIwMjYgMDcuMjkNCj4gDQo+IE9u
IDIvMjMvMjYgMToyMCBQTSwgTW9ydGVuIEJyw7hydXAgd3JvdGU6DQo+ID4gUG9wdWxhdGluZyBh
IG1lbXBvb2wgd2l0aCBvYmplY3RzIGlzIGFjY291bnRlZCBmb3IgaW4gdGhlIHN0YXRpc3RpY3Mu
DQo+ID4gV2hlbiBhbmFseXppbmcgbWVtcG9vbCBjYWNoZSBzdGF0aXN0aWNzLCB0aGlzIG1heSBk
aXN0b3J0IHRoZSBkYXRhLg0KPiA+IEluIG9yZGVyIHRvIHNpbXBsaWZ5IG1lbXBvb2wgY2FjaGUg
c3RhdGlzdGljcyBhbmFseXNpcywgYSBtZW1wb29sDQo+ID4gc3RhdGlzdGljcyByZXNldCBmdW5j
dGlvbiB3YXMgYWRkZWQuDQo+ID4NCj4gPiBGdXJ0aGVybW9yZSwgZGV0YWlscyBhYm91dCBhdmVy
YWdlIGJ1cnN0IHNpemVzIGFuZCBtZW1wb29sIGNhY2hlIG1pc3MNCj4gPiByYXRlcyB3ZXJlIGFk
ZGVkIHRvIHRoZSBzdGF0aXN0aWNzIHNob3duIHdoZW4gZHVtcGluZyBhIG1lbXBvb2wuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMu
Y29tPg0KPiANCj4gSSdkIGxpa2UgdG8gc2VlIHRob3VnaHRzIGFib3V0IGNvbnNpc3RlbmN5IGFm
dGVyIHJlc2V0IHRha2luZyBpbnRvDQo+IGFjY291bnQgdGhhdCByZXNldCB3aWxsIGxpa2VseSB0
byBiZSBkb25lIGZyb20gY29udHJvbCBjb3JlIHdoZXJlYXMNCj4gc3RhdHMgYXJlIHVwZGF0ZWQg
ZnJvbSBkYXRhIGNvcmVzLiBSZXN1bHRzIGNvdWxkIGJlIHZlcnkgaW50ZXJlc3RpbmcuDQo+IEkg
Z3Vlc3MgaXQgaXMgbm90IHRoZSByZWFzb24gdG8gaW50cm9kdWNlIGxvY2tpbmcgb3IgYW55IG90
aGVyIGtpbmQNCj4gb2Ygc3luY2hyb25pemF0aW9uLCBidXQgdXNlciBzaG91bGQgYmUgd2FybmVk
IGFzIHRoZSBiYXJlIG1pbmltdW0uDQoNCldoZW4gdXNlZCBmb3IgY2FjaGUgc3RhdGlzdGljcyBh
bmFseXNpcywgdGhlIHJlc2V0IGZ1bmN0aW9uIHdpbGwgYmUgY2FsbGVkIG9uY2Ugb25seTogQWZ0
ZXIgZXZlcnl0aGluZyBoYXMgYmVlbiBpbml0aWFsaXplZCAobWVtcG9vbCBjcmVhdGVkIGFuZCBw
b3B1bGF0ZWQsIGFuZCBldGhkZXYgUnggcXVldWVzIHByZWxvYWRlZCB3aXRoIG1idWZzKSwgYnV0
IGJlZm9yZSB0aGUgZGF0YSBwbGFuZSBpcyBzdGFydGVkLg0KDQpJIGRvbid0IHRoaW5rIHRoZSBl
bmQgdXNlciBzaG91bGQgYmUgd2FybmVkOyB0aGlzIG1heSBiZSBub3JtYWwgYmVoYXZpb3IgZm9y
IGFuIGFwcGxpY2F0aW9uLg0KSW4gYWRkaXRpb24gdG8gdGhlIHRyYWNlIGV2ZW50LCBJJ2xsIGFk
ZCBhIERFQlVHIGxldmVsIGxvZyBtZXNzYWdlIGluIHRoZSBmdW5jdGlvbi4NCg0KQW5kIGEgd2Fy
bmluZyBhYm91dCBwb3RlbnRpYWwgaW5jb25zaXN0ZW5jeSBpbiB0aGUgZnVuY3Rpb24gZGVzY3Jp
cHRpb24uDQoNCkdvb2QgZmVlZGJhY2ssIEFuZHJldyENCg0K
