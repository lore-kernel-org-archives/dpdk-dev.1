Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA81C7EE32
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Jun 2025 10:11:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DBFB402A1;
	Sat, 28 Jun 2025 12:11:12 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 080534026F;
 Sat, 28 Jun 2025 12:11:10 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B1ED320625;
 Sat, 28 Jun 2025 12:11:10 +0200 (CEST)
Subject: RE: [PATCH v3 1/3] eal/unix: fix log message for madvise() failure
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Sat, 28 Jun 2025 12:11:10 +0200
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD56@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 1/3] eal/unix: fix log message for madvise() failure
Thread-Index: AdvnibaKFcVmrCQHS1Ormqox3xzKXwAAk0HAACIHfWA=
References: <20250610131348.248800-1-mb@smartsharesystems.com>
 <4027143.U75o6juQT5@thomas>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD52@smartserver.smartshare.dk>
 <3811264.esFFXGZ24q@thomas> 
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: <thomas@monjalon.net>,
	<stable@dpdk.org>
Cc: "Tyler Retzlaff" <roretzla@linux.microsoft.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Maxime Coquelin" <maxime.coquelin@redhat.com>,
 "Chenbo Xia" <chenbox@nvidia.com>,
 "Tomasz Duszynski" <tduszynski@marvell.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>
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

PiBGcm9tOiBNb3J0ZW4gQnLDuHJ1cA0KPiBTZW50OiBGcmlkYXksIDI3IEp1bmUgMjAyNSAxOS41
MQ0KPiANCj4gPiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0bzp0aG9tYXNAbW9uamFsb24u
bmV0XQ0KPiA+IFNlbnQ6IEZyaWRheSwgMjcgSnVuZSAyMDI1IDE5LjM0DQo+ID4NCj4gPiAyNy8w
Ni8yMDI1IDE4OjQ3LCBNb3J0ZW4gQnLDuHJ1cDoNCj4gPiA+ID4gRnJvbTogVGhvbWFzIE1vbmph
bG9uIFttYWlsdG86dGhvbWFzQG1vbmphbG9uLm5ldF0NCj4gPiA+ID4gU2VudDogRnJpZGF5LCAy
NyBKdW5lIDIwMjUgMTcuNTYNCj4gPiA+ID4NCj4gPiA+ID4gMjQvMDYvMjAyNSAxMDowMywgTW9y
dGVuIEJyw7hydXA6DQo+ID4gPiA+ID4gSW4gZWFsX21lbV9zZXRfZHVtcCgpLCB3aGVuIG1hZHZp
c2UoKSBmYWlsZWQsIGFuIGluY29ycmVjdA0KPiByZWFzb24NCj4gPiB3YXMNCj4gPiA+ID4gPiBs
b2dnZWQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNb3J0ZW4gQnLDuHJ1
cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KPiA+ID4gPiA+IEFja2VkLWJ5OiBBbmF0b2x5
IEJ1cmFrb3YgPGFuYXRvbHkuYnVyYWtvdkBpbnRlbC5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IFdl
IG5lZWQgdG8gdHJhY2sgdGhlIHJvb3QgY2F1c2Ugd2l0aCBGaXhlczogcGxlYXNlLg0KPiA+ID4g
Pg0KPiA+ID4NCj4gPiA+IEkgYWxyZWFkeSBsb29rZWQgaW50byBpdCwgYW5kIHRoZSBidWcgd2Fz
IHRoZXJlIGZyb20gdGhlIGluaXRpYWwNCj4gPiBjb21taXQgb2YgdGhpcyBmdW5jdGlvbjoNCj4g
PiA+DQo+ID4NCj4gaHR0cHM6Ly9naXQuZHBkay5vcmcvZHBkay9jb21taXQvbGliL2xpYnJ0ZV9l
YWwvdW5peC9lYWxfdW5peF9tZW1vcnkuYz9pDQo+ID4gZD1jNGI4OWVjYjY0ZWFlNzczMzM3ZjNi
MTM2N2RkOGIxZjA5NzM3ZjJlDQo+ID4NCj4gPiBJZiB3ZSBkb24ndCB0cmFjayB0aGlzIG9yaWdp
biBpbiB0aGUgY29tbWl0IGxvZywgaXQgaXMgZGlmZmljdWx0IHRvDQo+ID4ga25vdy4NCj4gPg0K
PiA+ID4gSSBkaWRuJ3QgdGhpbmsgdGhlIEZpeGVzIHRhZyB3YXMgcmVxdWlyZWQgaWYgdGhhdCB3
YXMgdGhlIGNhc2UsIGJ1dA0KPiBJDQo+ID4gbWF5IGhhdmUgbWlzdW5kZXJzdG9vZCB0aGlzLg0K
PiA+DQo+ID4gWWVzIHdlIG11c3QgYmUgZXhwbGljaXQgYW5kIGFkZCBpdC4NCj4gPg0KPiA+ID4g
QWxzbywgaXQncyBhbiBpbnNpZ25pZmljYW50IGJ1Zywgc28gbm8gbmVlZCB0byBiYWNrcG9ydC4N
Cj4gPg0KPiA+IEEgYnVnIGlzIGEgYnVnLg0KPiA+IExUUyBtYWludGFpbmVycyBvciBhbnlvbmUg
bWFpbnRhaW5pbmcgaGlzIG93biBicmFuY2ggd2lsbCBkZWNpZGUNCj4gd2hldGhlcg0KPiA+IHRv
IGJhY2twb3J0Lg0KPiA+DQo+IA0KPiBPSy4gVGhhbmsgeW91IGZvciBjbGFyaWZ5aW5nLCBUaG9t
YXMuDQoNCkZpeGVzOiBjNGI4OWVjYjY0ZWEgKCJlYWw6IGludHJvZHVjZSBtZW1vcnkgbWFuYWdl
bWVudCB3cmFwcGVycyIpDQoNCg==
