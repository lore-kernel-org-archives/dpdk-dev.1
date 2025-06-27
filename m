Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2C2C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 16:47:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD84E402AE;
	Fri, 27 Jun 2025 18:47:06 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 40BB54026D
 for <dev@dpdk.org>; Fri, 27 Jun 2025 18:47:05 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id F2CB220625;
 Fri, 27 Jun 2025 18:47:04 +0200 (CEST)
Subject: RE: [PATCH v3 1/3] eal/unix: fix log message for madvise() failure
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Fri, 27 Jun 2025 18:47:02 +0200
Content-class: urn:content-classes:message
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD52@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <4027143.U75o6juQT5@thomas>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 1/3] eal/unix: fix log message for madvise() failure
Thread-Index: Advne/3hgm1tTKklTJqxld64wGwumgABgKMw
References: <20250610131348.248800-1-mb@smartsharesystems.com>
 <20250624080333.127618-1-mb@smartsharesystems.com>
 <20250624080333.127618-2-mb@smartsharesystems.com>
 <4027143.U75o6juQT5@thomas>
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
ZW50OiBGcmlkYXksIDI3IEp1bmUgMjAyNSAxNy41Ng0KPiANCj4gMjQvMDYvMjAyNSAxMDowMywg
TW9ydGVuIEJyw7hydXA6DQo+ID4gSW4gZWFsX21lbV9zZXRfZHVtcCgpLCB3aGVuIG1hZHZpc2Uo
KSBmYWlsZWQsIGFuIGluY29ycmVjdCByZWFzb24gd2FzDQo+ID4gbG9nZ2VkLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4N
Cj4gPiBBY2tlZC1ieTogQW5hdG9seSBCdXJha292IDxhbmF0b2x5LmJ1cmFrb3ZAaW50ZWwuY29t
Pg0KPiANCj4gV2UgbmVlZCB0byB0cmFjayB0aGUgcm9vdCBjYXVzZSB3aXRoIEZpeGVzOiBwbGVh
c2UuDQo+IA0KDQpJIGFscmVhZHkgbG9va2VkIGludG8gaXQsIGFuZCB0aGUgYnVnIHdhcyB0aGVy
ZSBmcm9tIHRoZSBpbml0aWFsIGNvbW1pdCBvZiB0aGlzIGZ1bmN0aW9uOg0KaHR0cHM6Ly9naXQu
ZHBkay5vcmcvZHBkay9jb21taXQvbGliL2xpYnJ0ZV9lYWwvdW5peC9lYWxfdW5peF9tZW1vcnku
Yz9pZD1jNGI4OWVjYjY0ZWFlNzczMzM3ZjNiMTM2N2RkOGIxZjA5NzM3ZjJlDQoNCkkgZGlkbid0
IHRoaW5rIHRoZSBGaXhlcyB0YWcgd2FzIHJlcXVpcmVkIGlmIHRoYXQgd2FzIHRoZSBjYXNlLCBi
dXQgSSBtYXkgaGF2ZSBtaXN1bmRlcnN0b29kIHRoaXMuDQoNCkFsc28sIGl0J3MgYW4gaW5zaWdu
aWZpY2FudCBidWcsIHNvIG5vIG5lZWQgdG8gYmFja3BvcnQuDQoNCg==
