Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9713606D498
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 17:51:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ED694028E;
	Fri, 13 Nov 2026 18:51:40 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTPS id 347434003C
 for <dev@dpdk.org>; Fri, 13 Nov 2026 18:51:39 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id DD66220972;
 Fri, 13 Nov 2026 18:51:38 +0100 (CET)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: RE: [PATCH 3/3] doc: update mempool cache description
Content-Transfer-Encoding: base64
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 13 Nov 2026 18:51:38 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65B0B@smartserver.smartshare.dk>
In-Reply-To: <20261113155633.1883479-3-kishore.padmanabha@broadcom.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 3/3] doc: update mempool cache description
Thread-Index: Ad1zh7yMvBIBDwY0Sc2nu3FC54G7LgADw0UQ
References: <20261113155633.1883479-1-kishore.padmanabha@broadcom.com>
 <20261113155633.1883479-3-kishore.padmanabha@broadcom.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Kishore Padmanabha" <kishore.padmanabha@broadcom.com>,
	<dev@dpdk.org>
Cc: "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Aman Singh" <aman.deep.singh@intel.com>
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

PiBGcm9tOiBLaXNob3JlIFBhZG1hbmFiaGEgW21haWx0bzpraXNob3JlLnBhZG1hbmFiaGFAYnJv
YWRjb20uY29tXQ0KPiBTZW50OiBGcmlkYXksIDEzIE5vdmVtYmVyIDIwMjYgMDcuNTcNCj4gDQo+
IFRoZSBwcm9ncmFtbWVyJ3MgZ3VpZGUgc3RpbGwgZGVzY3JpYmVkIHRoZSBtYXhpbXVtIGNhY2hl
IHNpemUgYXMgYQ0KPiBjb21waWxlIHRpbWUgY29uc3RhbnQuIERlc2NyaWJlIGhvdyB0aGUgY2Fj
aGUgc2l6ZSBpcyBzcGVjaWZpZWQsIGFuZA0KPiBob3cNCj4gdGhlIGNhY2hlIGlzIGZsdXNoZWQg
YW5kIHJlZmlsbGVkLg0KPiANCj4gRml4ZXM6IGI4MTVhY2ZkZmM0OCAoIm1lbXBvb2w6IHJlbW92
ZSBjYWNoZSBzaXplIGxpbWl0IikNCj4gU2lnbmVkLW9mZi1ieTogS2lzaG9yZSBQYWRtYW5hYmhh
IDxraXNob3JlLnBhZG1hbmFiaGFAYnJvYWRjb20uY29tPg0KPiAtLS0NCj4gIGRvYy9ndWlkZXMv
cHJvZ19ndWlkZS9tZW1wb29sX2xpYi5yc3QgfCA1ICsrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZG9jL2d1
aWRlcy9wcm9nX2d1aWRlL21lbXBvb2xfbGliLnJzdA0KPiBiL2RvYy9ndWlkZXMvcHJvZ19ndWlk
ZS9tZW1wb29sX2xpYi5yc3QNCj4gaW5kZXggMGJiODVmYjY4ZDNlLi5lODljZjc3ZWU5YmYgMTAw
NjQ0DQo+IC0tLSBhL2RvYy9ndWlkZXMvcHJvZ19ndWlkZS9tZW1wb29sX2xpYi5yc3QNCj4gKysr
IGIvZG9jL2d1aWRlcy9wcm9nX2d1aWRlL21lbXBvb2xfbGliLnJzdA0KPiBAQCAtOTYsNyArOTYs
MTAgQEAgdGhlIHNwZWVkIGF0IHdoaWNoIGEgY29yZSBjYW4gYWNjZXNzIGl0cyBvd24gY2FjaGUN
Cj4gZm9yIGEgc3BlY2lmaWMgbWVtb3J5IHBvb2wgd2kNCj4gIFRoZSBjYWNoZSBpcyBjb21wb3Nl
ZCBvZiBhIHNtYWxsLCBwZXItY29yZSB0YWJsZSBvZiBwb2ludGVycyBhbmQgaXRzDQo+IGxlbmd0
aCAodXNlZCBhcyBhIHN0YWNrKS4NCj4gIFRoaXMgaW50ZXJuYWwgY2FjaGUgY2FuIGJlIGVuYWJs
ZWQgb3IgZGlzYWJsZWQgYXQgY3JlYXRpb24gb2YgdGhlDQo+IHBvb2wuDQo+IA0KPiAtVGhlIG1h
eGltdW0gc2l6ZSBvZiB0aGUgY2FjaGUgaXMgc3RhdGljIGFuZCBpcyBkZWZpbmVkIGF0IGNvbXBp
bGF0aW9uDQo+IHRpbWUgKFJURV9NRU1QT09MX0NBQ0hFX01BWF9TSVpFKS4NCj4gK1RoZSBzaXpl
IG9mIHRoZSBjYWNoZSBpcyBzcGVjaWZpZWQgYXQgcG9vbCBjcmVhdGlvbiwgdXAgdG8gdGhlIG51
bWJlcg0KPiBvZiBvYmplY3RzIGluIHRoZSBwb29sLg0KDQpDb25zaWRlcjoNCiJ1cCB0byB0aGUg
bnVtYmVyIG9mIG9iamVjdHMgaW4gdGhlIHBvb2wuIg0KLT4NCiJ1cCB0byB0aGUgc2l6ZSBvZiB0
aGUgcG9vbC4iDQoNCj4gK1doZW4gdGhlIGNhY2hlIGlzIGZ1bGwsIGhhbGYgb2YgaXQgaXMgZmx1
c2hlZCB0byB0aGUgcG9vbCdzIHJpbmcsDQo+ICthbmQgd2hlbiBpdCBpcyBlbXB0eSwgaGFsZiBv
ZiBpdCBpcyByZWZpbGxlZCBmcm9tIHRoZSBwb29sJ3MgcmluZy4NCg0KVGhlIG1lbXBvb2wgbWF5
IHVzZSBhIGRpZmZlcmVudCBkcml2ZXIgdGhhbiB0aGUgInJpbmciLg0KUGxlYXNlIGNoYW5nZSAo
Ym90aCBpbnN0YW5jZXMpOg0KInRoZSBwb29sJ3MgcmluZyIgLT4gInRoZSBwb29sJ3MgZHJpdmVy
Ig0KDQo+ICtSZXF1ZXN0cyBvZiBtb3JlIHRoYW4gaGFsZiBvZiB0aGUgY2FjaGUgc2l6ZSBhcmUg
c2VydmVkLCBmdWxseSBvcg0KPiBwYXJ0bHksIGJ5IHRoZSBwb29sJ3MgcmluZy4NCg0KRHJvcCB0
aGlzIHNlbnRlbmNlLiBUaGUgbWVtcG9vbCBkb2VzIG5vdCBiZWhhdmUgdGhpcyB3YXkuIElmIHRo
ZSByZXF1ZXN0IGNhbiBiZSBzZXJ2ZWQgYnkgdGhlIGNhY2hlLCBpdCBpcy4NCg0KV2l0aCB0aGUg
cmVxdWVzdGVkIGNoYW5nZXMsDQpSZXZpZXdlZC1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0
c2hhcmVzeXN0ZW1zLmNvbT4NCg0K
