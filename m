Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF672606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 17:32:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37ABD40659;
	Thu, 22 Oct 2026 19:32:47 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E826740264
 for <dev@dpdk.org>; Thu, 22 Oct 2026 19:32:45 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A8B20207E3;
 Thu, 22 Oct 2026 19:32:45 +0200 (CEST)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] doc: remove cache flush threshold deprecation notice
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 22 Oct 2026 19:32:40 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65AD8@smartserver.smartshare.dk>
In-Reply-To: <20261022164844.34845-1-dsosnowski@nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] doc: remove cache flush threshold deprecation notice
Thread-Index: Ad1iRVJEO7hSmHHORSi7lqIRES4fTgABcOoQ
References: <20261022164844.34845-1-dsosnowski@nvidia.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Dariusz Sosnowski" <dsosnowski@nvidia.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>
Cc: <dev@dpdk.org>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBGcm9tOiBEYXJpdXN6IFNvc25vd3NraSBbbWFpbHRvOmRzb3Nub3dza2lAbnZpZGlhLmNvbV0N
Cj4gU2VudDogVGh1cnNkYXksIDIyIE9jdG9iZXIgMjAyNiAxOC40OQ0KPiANCj4gUmVtb3ZlIHRo
ZSBkZXByZWNhdGlvbiBub3RpY2UgZm9yIGZsdXNodGhyZXNoIGZpZWxkDQo+IGluIHN0cnVjdCBy
dGVfbWVtcG9vbF9jYWNoZSwgd2hpY2ggd2FzIHJlbW92ZWQgaW4gdGhlIG9mZmVuZGluZyBjb21t
aXQuDQo+IA0KPiBGaXhlczogN2RiZWM5ZTY5YzM2ICgibWVtcG9vbDogcmVtb3ZlIGRlcHJlY2F0
ZWQgY2FjaGUgZmx1c2gNCj4gdGhyZXNob2xkIikNCj4gQ2M6IG1iQHNtYXJ0c2hhcmVzeXN0ZW1z
LmNvbQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFyaXVzeiBTb3Nub3dza2kgPGRzb3Nub3dza2lA
bnZpZGlhLmNvbT4NCj4gLS0tDQo+ICBkb2MvZ3VpZGVzL3JlbF9ub3Rlcy9kZXByZWNhdGlvbi5y
c3QgfCAzIC0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZG9jL2d1aWRlcy9yZWxfbm90ZXMvZGVwcmVjYXRpb24ucnN0DQo+IGIvZG9jL2d1
aWRlcy9yZWxfbm90ZXMvZGVwcmVjYXRpb24ucnN0DQo+IGluZGV4IDI5ZmI3ZDU2ZDYuLjQ0ODI2
YTBjZjIgMTAwNjQ0DQo+IC0tLSBhL2RvYy9ndWlkZXMvcmVsX25vdGVzL2RlcHJlY2F0aW9uLnJz
dA0KPiArKysgYi9kb2MvZ3VpZGVzL3JlbF9ub3Rlcy9kZXByZWNhdGlvbi5yc3QNCj4gQEAgLTI5
LDkgKzI5LDYgQEAgRGVwcmVjYXRpb24gTm90aWNlcw0KPiAgICBVc2UgdGhlIGBgLVMgPHNlcnZp
Y2UtY29yZWxpc3Q+YGAgcGFyYW1ldGVyIGluc3RlYWQNCj4gICAgdG8gc3BlY2lmeSB0aGUgY29y
ZXMgdG8gYmUgdXNlZCBmb3IgYmFja2dyb3VuZCBzZXJ2aWNlcyBpbiBEUERLLg0KPiANCj4gLSog
bWVtcG9vbDogVGhlIGBgZmx1c2h0aHJlc2hgYCBmaWVsZCBpbiBgYHN0cnVjdCBydGVfbWVtcG9v
bF9jYWNoZWBgDQo+IGlzIG9ic29sZXRlLA0KPiAtICBhbmQgd2lsbCBiZSByZW1vdmVkIGluIERQ
REsgMjYuMTEuDQo+IC0NCj4gICogbWVtcG9vbDogVGhlIG9iamVjdCBhcnJheSBpbiBgYHN0cnVj
dCBydGVfbWVtcG9vbF9jYWNoZWBgIGlzDQo+IG92ZXJzaXplIGJ5IGZhY3RvciB0d28sDQo+ICAg
IGFuZCB3aWxsIGJlIHJlZHVjZWQgdG8gYGBSVEVfTUVNUE9PTF9DQUNIRV9NQVhfU0laRWBgIGlu
IERQREsgMjYuMTEuDQoNCllvdSBjYW4gcmVtb3ZlIHRoaXMgYnVsbGV0IHRvby4NClRoZSBvYmpl
Y3QgYXJyYXkgaXMgbm93IHJpZ2h0c2l6ZWQsIGFuZCBub3QgZml4ZWQgc2l6ZS4NCg0KQWNrZWQt
Ynk6IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQoNCg==
