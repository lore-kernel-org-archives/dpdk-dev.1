Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA80606A319
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 16:39:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0000B40297;
	Mon, 19 Oct 2026 18:39:46 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 25A844021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 18:39:46 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id EA8C620678;
 Mon, 19 Oct 2026 18:39:45 +0200 (CEST)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v7 0/2] introduce pile stack and mempool driver
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 19 Oct 2026 18:39:42 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65AC3@smartserver.smartshare.dk>
In-Reply-To: <f515d29c-525d-4854-bede-ffcc01303062@nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v7 0/2] introduce pile stack and mempool driver
Thread-Index: Ad1f0agawBP1wDrURZKFqsaWOOdNIgAFpJaw
References: <20260901064331.594276-1-mb@smartsharesystems.com>
 <20260914155901.943571-1-mb@smartsharesystems.com>
 <ItqMX3UyR721OV9AeSB9fA@monjalon.net>
 <f515d29c-525d-4854-bede-ffcc01303062@nvidia.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Ali Alnubani" <alialnu@nvidia.com>,
 "Thomas Monjalon" <thomas@monjalon.net>
Cc: <dev@dpdk.org>, "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBGcm9tOiBBbGkgQWxudWJhbmkgW21haWx0bzphbGlhbG51QG52aWRpYS5jb21dDQo+IFNlbnQ6
IE1vbmRheSwgMTkgT2N0b2JlciAyMDI2IDE1LjU2DQo+IA0KPiBPbiAxMC8xNS8yNiA4OjIyIFBN
LCBUaG9tYXMgTW9uamFsb24gd3JvdGU6DQo+IA0KPiA+IDE0LzA5LzIwMjYgMTc6NTgsIE1vcnRl
biBCcsO4cnVwOg0KPiA+PiBBZGRlZCBhIG5ldyBoaWdoLXBlcmZvcm1hbmNlIGxvY2stZnJlZSAi
cGlsZSIsIHVzaW5nIHRoZSBTdGFjayBBUEksDQo+ID4+IGFuZCBhbiBhY2NvbXBhbnlpbmcgbWVt
cG9vbCBkcml2ZXIuDQo+ID4+DQo+ID4+IE1vcnRlbiBCcsO4cnVwICgyKToNCj4gPj4gICAgc3Rh
Y2s6IGludHJvZHVjZSBwaWxlDQo+ID4+ICAgIG1lbXBvb2w6IGludHJvZHVjZSBwaWxlIGRyaXZl
cg0KPiA+IEFwcGxpZWQsIHRoYW5rcy4NCj4gDQo+IEhlbGxvLA0KPiANCj4gRGVidWcgYnVpbGQg
ZmFpbHMgb24gVWJ1bnR1IDI0LjA0IChhYXJjaDY0KSB3aXRoIHRoaXMgcGF0Y2hzZXQuIEJ1ZzoN
Cj4gDQo+IGh0dHBzOi8vYnVncy5kcGRrLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjA2MQ0KPiANCj4g
UmVnYXJkcywNCj4gQWxpDQoNCkkgYW0gYWJsZSB0byByZXByb2R1Y2UuDQpIYXZlIHdvcmtpbmcg
d29ya2Fyb3VuZC4NCldpbGwgc3VibWl0IHRvbW9ycm93Lg0KDQotTW9ydGVuDQoNCg==
