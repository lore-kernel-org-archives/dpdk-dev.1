Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A54BFF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:06:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AC264064A;
	Thu, 30 Apr 2026 13:06:30 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 47CB04028C;
 Thu, 30 Apr 2026 13:06:28 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 3A076205F2;
 Thu, 30 Apr 2026 13:06:27 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH dpdk v4] net: fix VLAN packet type
Date: Thu, 30 Apr 2026 13:06:24 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65833@smartserver.smartshare.dk>
In-Reply-To: <CAJFAV8wf-orBns0McCNeW1nx6a1s34+syV0jMXUP-+=0q4k8ow@mail.gmail.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH dpdk v4] net: fix VLAN packet type
Thread-Index: AdzYidWpIjyddCi1T2+EzE737c3IvQABo3yg
References: <20260422102814.645299-2-rjarry@redhat.com>
 <CAJFAV8yAhr-iXkn6JvderT_Yy4rB91LVWqYvwRqJH0DdmNkJ1g@mail.gmail.com>
 <DI3VM171VBSL.3E3J3C1HJ1GZG@redhat.com> <40394769.10thIPus4b@thomas>
 <CAJFAV8wf-orBns0McCNeW1nx6a1s34+syV0jMXUP-+=0q4k8ow@mail.gmail.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: <dev@dpdk.org>
Cc: "Robin Jarry" <rjarry@redhat.com>, "Gregory Etelson" <getelson@nvidia.com>,
 <stable@dpdk.org>, "Kevin Traynor" <ktraynor@redhat.com>,
 "Luca Boccassi" <bluca@debian.org>,
 "David Marchand" <david.marchand@redhat.com>,
 "Thomas Monjalon" <thomas@monjalon.net>
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
DQo+IFNlbnQ6IFRodXJzZGF5LCAzMCBBcHJpbCAyMDI2IDEyLjEyDQo+IA0KPiBPbiBNb24sIDI3
IEFwciAyMDI2IGF0IDE3OjUzLCBUaG9tYXMgTW9uamFsb24gPHRob21hc0Btb25qYWxvbi5uZXQ+
DQo+IHdyb3RlOg0KPiA+DQo+ID4gMjcvMDQvMjAyNiAxMjo0NywgUm9iaW4gSmFycnk6DQo+ID4g
PiBEYXZpZCBNYXJjaGFuZCwgQXByIDI1LCAyMDI2IGF0IDEwOjQwOg0KPiA+ID4gPiBPbiBUaHUs
IDIzIEFwciAyMDI2IGF0IDEzOjI1LCBSb2JpbiBKYXJyeSA8cmphcnJ5QHJlZGhhdC5jb20+DQo+
IHdyb3RlOg0KPiA+ID4gPiBUaGlzIGlzIHVudGVzdGVkLCBidXQgd2hhdCBkbyB5b3UgdGhpbms/
DQo+ID4gPg0KPiA+ID4gVGhhdCBsb29rcyBjb3JyZWN0LiBCdXQgeW91IGRvbid0IGltcG9zZSBh
IGxpbWl0IGluIHRoZSBudW1iZXIgb2YNCj4gVkxBTnM/DQo+ID4gPg0KPiA+ID4gSSBkb24ndCBz
ZWUgYW55IGdvb2QgcmVhc29uIHRvIHN1cHBvcnQgbW9yZSB0aGFuIDIgc3RhY2tlZCB0YWdzLg0K
PiA+DQo+ID4gTG9vayBpbiB0aGUgbWFpbGluZyBsaXN0Lg0KPiA+IEkgcmVtZW1iZXIgaXQgd2Fz
IHRvIGxpbWl0IGEgcmlzayBvZiBpbmZpbml0ZSBsb29wLg0KPiANCj4gRGVmZW5zaXZlIHByb2dy
YW1taW5nIChpaXVjIHdoeSBpdCB3YXMgaW50cm9kdWNlZCkgc2VlbXMgYSBiYWQgaWRlYS4NCj4g
SXQgaW1wb3NlcyBhIHJlc3RyaWN0aW9uIGZvciBubyBnb29kIHJlYXNvbi4NCj4gVGhlIHNhbWUg
Y2FuIGJlIGFjaGlldmVkIGJ5IGNoZWNraW5nIHRoZSBvZmZzZXQgdnMgcGFja2V0IGxlbmd0aA0K
PiAocnRlX3BrdG1idWZfcmVhZCksIGFuZCBubyBhcmJpdHJhcnkgbGltaXQgbmVlZGVkLg0KPiAN
Cj4gSSBhbSBmb3Igc2ltcGx5IHJldmVydGluZyB0aGUgcGF0Y2ggaW4gTFRTIHJlbGVhc2VzLg0K
PiBXZSBjYW4gY29tZSB1cCB3aXRoIGEgbmV3IGNoYW5nZSBpbiBtYWluIGZvciBHcmVnb3J5IHVz
ZWNhc2UsIGJ1dCBpdA0KPiBkb2VzIG5vdCBzZWVtIGxpa2Ugc29tZXRoaW5nIHdlIHdhbnQgdG8g
YmFja3BvcnQgaW4gTFRTLg0KPiANCg0KSSBqdXN0IHRvb2sgYSBsb29rIGF0IHJ0ZV9uZXRfZ2V0
X3B0eXBlKCkuDQoNClRoZSBNUExTIHBhcnNlciBpcyBhbHNvIGJyb2tlbi4NCkl0IHNpbXBseSBz
a2lwcyA1IE1QTFMgbGFiZWxzIHdpdGhvdXQgY2hlY2tpbmcgaWYgdGhleSBhcmUgTVBMUyBsYWJl
bHMgYXQgYWxsLg0KDQpBbmQgdGhlcmUncyBubyBQUFBvRSBwYXJzZXIuDQoNCg==
