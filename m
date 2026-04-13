Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2ABF34C52
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 13:34:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A05D24021E;
	Mon, 13 Apr 2026 15:34:11 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id AD6D14014F
 for <dev@dpdk.org>; Mon, 13 Apr 2026 15:34:10 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 8CDA1205F2;
 Mon, 13 Apr 2026 15:34:09 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v3 0/7] Rework device probing
Date: Mon, 13 Apr 2026 15:34:05 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657E3@smartserver.smartshare.dk>
In-Reply-To: <CAJFAV8xPCsHY4OFLy19jDv4KgVbZotn1pobNGhokbuQcY1AniQ@mail.gmail.com>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 0/7] Rework device probing
Thread-Index: AdzJm4Q830/t4mNJQnWHeFTq+fUe/wBqwz1g
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-1-david.marchand@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657DF@smartserver.smartshare.dk>
 <CAJFAV8xPCsHY4OFLy19jDv4KgVbZotn1pobNGhokbuQcY1AniQ@mail.gmail.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "David Marchand" <david.marchand@redhat.com>
Cc: "Bruce Richardson" <bruce.richardson@intel.com>,
 "Robin Jarry" <rjarry@redhat.com>,
 "Hemant Agrawal" <hemant.agrawal@nxp.com>,
 "Maxime Leroy" <maxime@leroys.fr>, "Kevin Traynor" <ktraynor@redhat.com>,
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

PiBGcm9tOiBEYXZpZCBNYXJjaGFuZCBbbWFpbHRvOmRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb21d
DQo+IFNlbnQ6IFNhdHVyZGF5LCAxMSBBcHJpbCAyMDI2IDEyLjExDQo+IA0KPiBPbiBGcmksIDEw
IEFwciAyMDI2IGF0IDE2OjM1LCBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMu
Y29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IElzIHRoZXJlIGEgd29ya2Fyb3VuZCB1bnRpbCB0aGlz
IHBhdGNoIGlzIGFkZGVkLCBpZiBJIGRvbid0IHdhbnQNCj4gcnRlX2VhbF9pbml0KCkgdG8gcHJv
YmUgYW55IGRldmljZXMsIGJ1dCBJIHdhbnQgbXkgYXBwbGljYXRpb24gdG8gcHJvYmUNCj4gZGV2
aWNlcyBsYXRlciBieSBjYWxsaW5nIHJ0ZV9idXNfc2NhbigpIGZvbGxvd2VkIGJ5IHJ0ZV9idXNf
cHJvYmUoKT8NCj4gPg0KPiA+IEl0J3Mgbm90IHNvbWV0aGluZyB3ZSByZWFsbHkgbmVlZCwgc28g
aWYgeW91IGRvbid0IGtub3cgaXQgb2ZmIHRoZQ0KPiB0b3Agb2YgeW91ciBoZWFkLCBkb24ndCBz
cGVuZCB0aW1lIHRyeWluZyB0byBmaWd1cmUgaXQgb3V0Lg0KPiANCj4gV2VsbCwgc3RhcnRpbmcg
ZnJvbSB0aGUgd2VsbCBrbm93biAtYSBwY2k6MDAwMDowMDowMC4wIHRyaWNrLCBJIHdyb3RlDQo+
IGFuIGluY29tcGxldGUgd29ya2Fyb3VuZCBpbXBsZW1lbnRlZCBmb3IgT1ZTLg0KPiBodHRwczov
L3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3Qvb3BlbnZzd2l0Y2gvcGF0Y2gvMjAyNjAyMjYx
NzI0MjkuMg0KPiAxMjAzNC0zLWRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20vDQo+IA0KPiBJbmNv
bXBsZXRlLCBiZWNhdXNlIHNvbWUgYnVzZXMgbWFrZSBsaWZlIGhhcmRlciB3aXRoIHNvbWUgYWRk
aXRpb25hbA0KPiBwYXJzaW5nIHJlc3RyYWludHMgKGJ1cy9kcGFhIGlzIHRoZSBmaXJzdCBvbmUg
dGhhdCBjb21lcyB0byBtaW5kKSBvcg0KPiByZXF1aXJpbmcgYSBkcml2ZXIgaGFuZGxpbmcgdGhl
IGRldmljZSBleGlzdHMgKGJ1cy9wbGF0Zm9ybSB3aGljaCBoYXMNCj4gKm5vKiBpbi10cmVlIGRy
aXZlciwgdGhvdWdoIHRoaXMgaXMgYSBkaWZmZXJlbnQgc3RvcnkuLikuDQoNClRoYW5rcyBmb3Ig
YWxsIHRoZSBpbnB1dCwgRGF2aWQuDQoNCkluIG15IGNhc2UgaXQncyBvbmx5IFBDSSBidXMgZGV2
aWNlcywgc28gSSBmb3VuZCBhIHJlbGF0aXZlbHkgc2ltcGxlIHdvcmthcm91bmQgaW5zdGVhZCBv
ZiB1c2luZyB0aGUgIi1hIiB0cmljay4NCg0KSSBzdGFydCBieSBub3QgYmluZGluZyB0aGUgZGV2
aWNlcyB0byB0aGUgdmZpby1wY2kga2VybmVsIGRyaXZlci4NClRoZW4gSSBjYWxsIHJ0ZV9lYWxf
aW5pdCgpOyBhbmQgdGhlIGRldmljZXMgYXJlIG5vdCBkZXRlY3RlZCBieSB0aGUgRUFMIGF0IHRo
aXMgcG9pbnQuDQpUaGVuIEkgYmluZCB0aGUgZGV2aWNlcyB0byB0aGUgdmZpby1wY2kga2VybmVs
IGRyaXZlci4NCkFuZCBmaW5hbGx5IEkgY2FsbCBydGVfYnVzX3NjYW4oKSBhbmQgcnRlX2J1c19w
cm9iZSgpOyB0aGVuIHRoZSBkZXZpY2VzIGFyZSBkZXRlY3RlZCBhdCB0aGlzIHBvaW50Lg0KDQpO
b3RlOiBJIGhhdmUgdG8gcGFzcyAiLS1pb3ZhLW1vZGUgcGEiIHRvIEVBTCBpbml0Lg0KT3RoZXJ3
aXNlIEVBTCBpbml0IGNob29zZXMgVkEgbW9kZSwgY2F1c2luZyBteSBkcml2ZXJzIHRvIG5vdCBs
b2FkLCB3aXRoIHRoZSBmb2xsb3dpbmcgbWVzc2FnZToNCiJQQ0lfQlVTOiAgIEV4cGVjdGluZyAn
UEEnIElPVkEgbW9kZSBidXQgY3VycmVudCBtb2RlIGlzICdWQScsIG5vdCBpbml0aWFsaXppbmci
DQoNCkZvciBhbnlvbmUgZm9sbG93aW5nIHRoZSB0aHJlYWQuLi4NCg0KRHVyaW5nIGV4cGVyaW1l
bnRhdGlvbiwgSSBvYnNlcnZlZCB0aGF0IGlmIHRoZSBkZXZpY2VzIHdlcmUgYm91bmQgdG8gdGhl
IHZmaW8tcGNpIGtlcm5lbCBkcml2ZXIsIGFuZCAiLWEgLi4uIiB3YXMgcGFzc2VkIHRvIHJ0ZV9l
YWxfaW5pdCgpIGl0IGRpZCAtIGFzIGV4cGVjdGVkIC0gbm90IGxvYWQgdGhlIGRyaXZlcnMuDQpI
b3dldmVyLCB3aGVuIGNhbGxpbmcgcnRlX2J1c19zY2FuKCkgYW5kIHJ0ZV9idXNfcHJvYmUoKSBh
ZnRlcndhcmRzLCB0aGUgZHJpdmVycyB3ZXJlIGFsc28gbm90IGF1dG8tZGV0ZWN0ZWQgYXQgdGhp
cyBwb2ludC4NCkkgZ3Vlc3MgdGhlICItYSAuLi4iIHBhcmFtZXRlciBpcyBzdGlja3ksIHdoaWNo
IG1ha2VzIHNlbnNlLg0KDQpBbnl3YXksIGxvb2tpbmcgZm9yd2FyZCB0byB0aGUgLS1uby1hdXRv
LXByb2JpbmcgRUFMIG9wdGlvbi4gOi0pDQoNCg==
