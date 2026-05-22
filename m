Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2500BCD5BAC
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 09:58:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2EB44064F;
	Fri, 22 May 2026 11:58:26 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A344D4028D
 for <dev@dpdk.org>; Fri, 22 May 2026 11:58:25 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7500720416;
 Fri, 22 May 2026 11:58:25 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v1 1/1] net/iavf: fix large VF IRQ mapping
Date: Fri, 22 May 2026 11:58:22 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65891@smartserver.smartshare.dk>
In-Reply-To: <8b0e6d7f-c7c1-4d0d-8b76-ea2f1fd6655c@intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v1 1/1] net/iavf: fix large VF IRQ mapping
Thread-Index: Adzpz9R7VH0oFRfkT6yawnd1gK+qvQAADYGA
References: <c50ef6c3d4ecaa7902d325d5e8a7fd4c92c8eeb6.1778076415.git.anatoly.burakov@intel.com>
 <CAJFAV8yNKxSXjmjQ0sM21-6hZDTVrGT9cpZ6aQU_FNTepTP4nw@mail.gmail.com>
 <3b9ba191-f086-4264-8382-653c06772e17@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65860@smartserver.smartshare.dk>
 <8b0e6d7f-c7c1-4d0d-8b76-ea2f1fd6655c@intel.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>,
	"David Marchand" <david.marchand@redhat.com>
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
bV0NCj4gU2VudDogRnJpZGF5LCAyMiBNYXkgMjAyNiAxMS40Ng0KPiANCj4gT24gNS84LzIwMjYg
MTE6MTYgQU0sIE1vcnRlbiBCcsO4cnVwIHdyb3RlOg0KPiA+PiBGcm9tOiBCdXJha292LCBBbmF0
b2x5IFttYWlsdG86YW5hdG9seS5idXJha292QGludGVsLmNvbV0NCj4gPj4gU2VudDogVGh1cnNk
YXksIDcgTWF5IDIwMjYgMTAuMDkNCj4gPj4NCj4gPj4gT24gNS82LzIwMjYgNTo1OCBQTSwgRGF2
aWQgTWFyY2hhbmQgd3JvdGU6DQo+ID4+PiBPbiBXZWQsIDYgTWF5IDIwMjYgYXQgMTY6MDcsIEFu
YXRvbHkgQnVyYWtvdg0KPiA+PiA8YW5hdG9seS5idXJha292QGludGVsLmNvbT4gd3JvdGU6DQo+
ID4+Pj4NCj4gPj4+PiBUaGUgUEYgd2lsbCBjaGVjayBidWZmZXIgc2l6ZSBmb3IgYmVpbmcgdG9v
IGJpZywgYW5kIHRoZSBjaHVuaw0KPiA+PiBzaXppbmcgY29kZQ0KPiA+Pj4+IGNvcnJlY3RseSBj
YWxscyB0aGF0IG91dC4gSG93ZXZlciwgdGhlIHNpemUgd2FzIGFjdHVhbGx5IHN0aWxsIHRvbw0K
PiA+PiBiaWcNCj4gPj4+PiBiZWNhdXNlIGBzdHJ1Y3QgdmlydGNobmxfcXVldWVfdmVjdG9yX21h
cHNgIGFscmVhZHkgaGFkIG9uZSBxdWV1ZQ0KPiA+PiB2ZWN0b3INCj4gPj4+PiBhcyBwYXJ0IG9m
IGl0cyBkZWZpbml0aW9uLCBzbyBgY2h1bmtfc3pgIHdhcyB0b28gYmlnIGJ5IDEuDQo+ID4+Pj4N
Cj4gPj4+PiBGaXhlczogMjkyZDNiNzgxYWM0ICgibmV0L2lhdmY6IHJlcGxhY2UgdW5uZWNlc3Nh
cnkgaHVnZXBhZ2UNCj4gbWVtb3J5DQo+ID4+IGFsbG9jYXRpb25zIikNCj4gPj4+Pg0KPiA+Pj4+
IFNpZ25lZC1vZmYtYnk6IEFuYXRvbHkgQnVyYWtvdiA8YW5hdG9seS5idXJha292QGludGVsLmNv
bT4NCj4gPj4+PiAtLS0NCj4gPj4+PiAgICBkcml2ZXJzL25ldC9pbnRlbC9pYXZmL2lhdmZfdmNo
bmwuYyB8IDIgKy0NCj4gPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gPj4+Pg0KPiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9pbnRl
bC9pYXZmL2lhdmZfdmNobmwuYw0KPiA+PiBiL2RyaXZlcnMvbmV0L2ludGVsL2lhdmYvaWF2Zl92
Y2hubC5jDQo+ID4+Pj4gaW5kZXggYzJmMzQwZGI4MS4uZGQwOWIwZmE2MSAxMDA2NDQNCj4gPj4+
PiAtLS0gYS9kcml2ZXJzL25ldC9pbnRlbC9pYXZmL2lhdmZfdmNobmwuYw0KPiA+Pj4+ICsrKyBi
L2RyaXZlcnMvbmV0L2ludGVsL2lhdmYvaWF2Zl92Y2hubC5jDQo+ID4+Pj4gQEAgLTE1MjgsNyAr
MTUyOCw3IEBAIGlhdmZfY29uZmlnX2lycV9tYXBfbHZfY2h1bmsoc3RydWN0DQo+ID4+IGlhdmZf
YWRhcHRlciAqYWRhcHRlciwNCj4gPj4+Pg0KPiA+Pj4+ICAgICAgICAgICAvKiBmb3Igc29tZSBy
ZWFzb24gUEYgc2lkZSBjaGVja3MgZm9yIGJ1ZmZlciBiZWluZyB0b28NCj4gYmlnLA0KPiA+PiBz
byBhZGp1c3QgaXQgZG93biAqLw0KPiA+Pj4NCj4gPj4+IFRoZSBjb21tZW50IGFib3ZlIGNhbiBi
ZSByZW1vdmVkPw0KPiA+Pg0KPiA+PiBObywgaXQncyBzdGlsbCByZWxldmFudCwgYmVjYXVzZSBp
dCByZWZlcnMgdG8gdGhlIGZhY3QgdGhhdCB3ZSdyZQ0KPiA+PiBhZGp1c3RpbmcgdGhlIHRvdGFs
IGxlbmd0aCBkb3dud2FyZHMgYXMgb3Bwb3NlZCB0byBsZWF2aW5nIGl0IGF0IG1heA0KPiA+PiBz
aXplLg0KPiA+Pg0KPiA+Pj4NCj4gPj4+PiAgICAgICAgICAgYnVmX2xlbiA9IHNpemVvZihzdHJ1
Y3QgdmlydGNobmxfcXVldWVfdmVjdG9yX21hcHMpICsNCj4gPj4+PiAtICAgICAgICAgICAgICAg
ICBzaXplb2Yoc3RydWN0IHZpcnRjaG5sX3F1ZXVlX3ZlY3RvcikgKiBjaHVua19zejsNCj4gPj4+
PiArICAgICAgICAgICAgICAgICBzaXplb2Yoc3RydWN0IHZpcnRjaG5sX3F1ZXVlX3ZlY3Rvcikg
KiAoY2h1bmtfc3oNCj4gLQ0KPiA+PiAxKTsNCj4gPj4+DQo+ID4+PiAtIGRpZCB5b3UgbWFrZSBz
dXJlIHlvdSBkaWQgbm90IGJyZWFrIGNvbXBhdCB3aXRoIHByZXZpb3VzIHZlcnNpb24NCj4gb2YN
Cj4gPj4+IEludGVsIG91dCBvZiB0cmVlIFBGIGRyaXZlciAoc2luY2UgdGhpcyBjb25jZXJucyBj
b25maWd1cmluZyAiTGFyZ2UNCj4gPj4+IFZGIik/DQo+ID4+DQo+ID4+IFRoZSBjb21taXQgaW4g
cXVlc3Rpb24gKmRpZCogYnJlYWsgdGhpbmdzIHdpdGggcHJldmlvdXMgb3V0IG9mIHRyZWUNCj4g
UEYNCj4gPj4gZHJpdmVyLiBUaGlzIGNvbW1pdCBmaXhlcyB0aGUgYnJlYWthZ2UgaW50cm9kdWNl
ZCBpbiB0aGF0IGNvbW1pdC4NCj4gVGhlDQo+ID4+IGNvbW1pdCBiZWluZyBmaXhlZCB3YXMgYSBy
ZWZhY3Rvciwgd2hpY2ggc3BlY2lmaWVkIHNpemUgYXMgTi0xLg0KPiA+Pg0KPiA+Pj4NCj4gPj4+
IC0gYWxsIHRob3NlIHZpcnRjaG5sIGxpc3Qgc3RydWN0IGhhdmUgdGhlIHNhbWUgZWxlbXNbMV0g
aXNzdWUuDQo+ID4+PiBLZXJuZWwgc2lkZSBkaWQgc29tZSBjbGVhbnVwcyBzb21lIHRpbWUgYWdv
LCBtYXliZSB0aW1lIGZvciBEUERLIHRvDQo+ID4+IGRvDQo+ID4+PiB0aGUgc2FtZS4uLj8NCj4g
Pj4+DQo+ID4+DQo+ID4+IFllcywgaXQgaXMgaW5kZWVkIHRpbWUgdG8gZG8gdGhlIHNhbWUsIGJ1
dCBub3QgYXMgcGFydCBvZiB0aGlzDQo+ID4+IHBhdGNoc2V0LA0KPiA+PiBhbmQgbm90IGJlZm9y
ZSB0aGUgYmFzZSBkcml2ZXIgY29kZSBpcyB1cGRhdGVkIHRvIGRvIHRoZSBzYW1lLiBUaGVyZQ0K
PiBpcw0KPiA+PiBzb21lIGJhY2tncm91bmQgd29yayBoYXBwZW5pbmcgb24gdGhhdCBmcm9udCBh
bHJlYWR5LCBidXQgdGhlcmUgYXJlDQo+IGENCj4gPj4gbG90IG9mIGRlcGVuZGVuY2llcyBhbmQg
bW92aW5nIHBhcnRzLCBzbyB3ZSBjYW4ndCBqdXN0IGNoYW5nZSB0aGlzDQo+ID4+IHdpbGx5DQo+
ID4+IG5pbGx5Lg0KPiA+DQo+ID4gSXMgdGhlcmUgYSB0aW1lbGluZSBmb3IgdGhpcyBmaXg/DQo+
ID4NCj4gDQo+IE5vIHNwZWNpZmljIHRpbWVsaW5lLCB1bmZvcnR1bmF0ZWx5Lg0KDQpUaGUgZHJp
dmVycyB3ZXJlIHZlcnkgcmVjZW50bHkgdXBkYXRlZCB0byB1c2UgbWVtY3B5KCkgaW5zdGVhZCBv
ZiBydGVfbWVtY3B5KCksIHNvIG5vdyB3ZSBjYW4gZW5hYmxlIHN0cmluZ29wLW92ZXJmbG93IHdh
cm5pbmdzIGluIHJ0ZV9tZW1jcHkoKS4NCldoYXQgcmVhbGx5IGFubm95ZWQgbWUgd2FzIHRoZSBu
ZWVkIHRvIGRpc2FibGUgdGhlc2Ugd2FybmluZ3MgaW4gYSBnZW5lcmFsIGxpYnJhcnkgZnVuY3Rp
b24gZHVlIHRvIHNvbWUgZHJpdmVycy4NCg0KU2luY2UgdGhpcyBwcm9ibGVtIGhhcyBub3cgYmVl
biByZXNvbHZlZCwgYW5kIHRoZSBzY29wZSBvZiB0aGUgZWxlbXNbMV0gcHJvYmxlbSBoYXMgc2hy
dW5rIGZyb20gc3lzdGVtLXdpZGUgdG8gSW50ZWwgZHJpdmVycyBvbmx5LCBJJ20gbm90IHRoYXQg
Y29uY2VybmVkIGFib3V0IHRpbWVsaW5lIGFueW1vcmUuIDstKQ0KDQotTW9ydGVuDQoNCg==
