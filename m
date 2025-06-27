Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B3EC7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 17:51:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 564EA4026D;
	Fri, 27 Jun 2025 19:51:28 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 138D4400EF
 for <dev@dpdk.org>; Fri, 27 Jun 2025 19:51:27 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D0BD320625;
 Fri, 27 Jun 2025 19:51:26 +0200 (CEST)
Subject: RE: [PATCH v3 1/3] eal/unix: fix log message for madvise() failure
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Fri, 27 Jun 2025 19:51:24 +0200
Content-class: urn:content-classes:message
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD54@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <3811264.esFFXGZ24q@thomas>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 1/3] eal/unix: fix log message for madvise() failure
Thread-Index: AdvnibaKFcVmrCQHS1Ormqox3xzKXwAAk0HA
References: <20250610131348.248800-1-mb@smartsharesystems.com>
 <4027143.U75o6juQT5@thomas>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD52@smartserver.smartshare.dk>
 <3811264.esFFXGZ24q@thomas>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>
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

PiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0bzp0aG9tYXNAbW9uamFsb24ubmV0XQ0KPiBT
ZW50OiBGcmlkYXksIDI3IEp1bmUgMjAyNSAxOS4zNA0KPiANCj4gMjcvMDYvMjAyNSAxODo0Nywg
TW9ydGVuIEJyw7hydXA6DQo+ID4gPiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0bzp0aG9t
YXNAbW9uamFsb24ubmV0XQ0KPiA+ID4gU2VudDogRnJpZGF5LCAyNyBKdW5lIDIwMjUgMTcuNTYN
Cj4gPiA+DQo+ID4gPiAyNC8wNi8yMDI1IDEwOjAzLCBNb3J0ZW4gQnLDuHJ1cDoNCj4gPiA+ID4g
SW4gZWFsX21lbV9zZXRfZHVtcCgpLCB3aGVuIG1hZHZpc2UoKSBmYWlsZWQsIGFuIGluY29ycmVj
dCByZWFzb24NCj4gd2FzDQo+ID4gPiA+IGxvZ2dlZC4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCj4gPiA+
ID4gQWNrZWQtYnk6IEFuYXRvbHkgQnVyYWtvdiA8YW5hdG9seS5idXJha292QGludGVsLmNvbT4N
Cj4gPiA+DQo+ID4gPiBXZSBuZWVkIHRvIHRyYWNrIHRoZSByb290IGNhdXNlIHdpdGggRml4ZXM6
IHBsZWFzZS4NCj4gPiA+DQo+ID4NCj4gPiBJIGFscmVhZHkgbG9va2VkIGludG8gaXQsIGFuZCB0
aGUgYnVnIHdhcyB0aGVyZSBmcm9tIHRoZSBpbml0aWFsDQo+IGNvbW1pdCBvZiB0aGlzIGZ1bmN0
aW9uOg0KPiA+DQo+IGh0dHBzOi8vZ2l0LmRwZGsub3JnL2RwZGsvY29tbWl0L2xpYi9saWJydGVf
ZWFsL3VuaXgvZWFsX3VuaXhfbWVtb3J5LmM/aQ0KPiBkPWM0Yjg5ZWNiNjRlYWU3NzMzMzdmM2Ix
MzY3ZGQ4YjFmMDk3MzdmMmUNCj4gDQo+IElmIHdlIGRvbid0IHRyYWNrIHRoaXMgb3JpZ2luIGlu
IHRoZSBjb21taXQgbG9nLCBpdCBpcyBkaWZmaWN1bHQgdG8NCj4ga25vdy4NCj4gDQo+ID4gSSBk
aWRuJ3QgdGhpbmsgdGhlIEZpeGVzIHRhZyB3YXMgcmVxdWlyZWQgaWYgdGhhdCB3YXMgdGhlIGNh
c2UsIGJ1dCBJDQo+IG1heSBoYXZlIG1pc3VuZGVyc3Rvb2QgdGhpcy4NCj4gDQo+IFllcyB3ZSBt
dXN0IGJlIGV4cGxpY2l0IGFuZCBhZGQgaXQuDQo+IA0KPiA+IEFsc28sIGl0J3MgYW4gaW5zaWdu
aWZpY2FudCBidWcsIHNvIG5vIG5lZWQgdG8gYmFja3BvcnQuDQo+IA0KPiBBIGJ1ZyBpcyBhIGJ1
Zy4NCj4gTFRTIG1haW50YWluZXJzIG9yIGFueW9uZSBtYWludGFpbmluZyBoaXMgb3duIGJyYW5j
aCB3aWxsIGRlY2lkZSB3aGV0aGVyDQo+IHRvIGJhY2twb3J0Lg0KPiANCg0KT0suIFRoYW5rIHlv
dSBmb3IgY2xhcmlmeWluZywgVGhvbWFzLg0KDQo=
