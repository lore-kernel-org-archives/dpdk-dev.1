Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993EA606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 12:51:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9047C402D6;
	Wed, 21 Oct 2026 14:51:27 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id C436240041;
 Wed, 21 Oct 2026 14:51:26 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 940AA2033E;
 Wed, 21 Oct 2026 14:51:24 +0200 (CEST)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v2 3/3] net/ice: do not include private headers in testpmd
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 21 Oct 2026 14:51:20 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65AD1@smartserver.smartshare.dk>
In-Reply-To: <CAJFAV8wwuxGjGC95KkASQvPe07E64=N9L_aKuygT9LCoooTOdA@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 3/3] net/ice: do not include private headers in testpmd
Thread-Index: Ad1hQhEYvMVx1bznRdGNVGcLFYLsBQAFRHIw
References: <35d9aed797cb433296b1c0d53fbda4b45c38e833.1792074055.git.anatoly.burakov@intel.com>
 <ff393eb2eef43c9ab3d27824badda9743e717a98.1792074055.git.anatoly.burakov@intel.com>
 <atDk1fSEoCYA8ZZd@bricha3-mobl1.ger.corp.intel.com>
 <atDlunTe_r3gqsVW@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8wwuxGjGC95KkASQvPe07E64=N9L_aKuygT9LCoooTOdA@mail.gmail.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "David Marchand" <david.marchand@redhat.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Anatoly Burakov" <anatoly.burakov@intel.com>, <dev@dpdk.org>,
 <techboard@dpdk.org>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiA+ID4gQWNrZWQtYnk6IEJydWNlIFJpY2hhcmRzb24gPGJydWNlLnJpY2hhcmRzb25AaW50ZWwu
Y29tPg0KPiA+ID4NCj4gPiA+IEdpdmVuIHdoZXJlIHdlIGFyZSwgdGhpcyBpcyBwcm9iYWJseSBh
IHJlYXNvbmFibGUgc29sdXRpb24uDQo+IEhvd2V2ZXIsIEknbQ0KPiA+ID4gYWxzbyB0aGlua2lu
ZyB0aGF0IG1heWJlIHdlIHNob3VsZCBoYXZlIGEgZGlzY3Vzc2lvbiBhcyB0byB3aGV0aGVyDQo+
IHRlc3RwbWQNCj4gPiA+IC0gd2hpY2ggaXMsIGFmdGVyIGFsbCwgZm9yIHRlc3RpbmcgUE1EcyAt
IHNob3VsZCBiZSBsaW1pdGVkIHRvIHRoZQ0KPiBwdWJsaWMNCj4gPiA+IEFQSXMuIElzIHRoZXJl
IG5vdCBhIGNhc2UgdG8gYmUgbWFkZSBmb3IgYWxsb3dpbmcgdGhlIHBlci1kcml2ZXINCj4gdGVz
dHBtZA0KPiA+ID4gZmlsZXMgdG8gYWNjZXNzIHRoZSBpbnRlcm5hbHMgb2YgdGhlIGRyaXZlciBm
b3IgdGVzdGluZyBwdXJwb3Nlcz8NCj4gPiA+DQo+ID4gK3RlY2hib2FyZCBhbmQgb3RoZXJzIGZv
ciBtb3JlIGlucHV0IGFuZCB0aG91Z2h0cyBmb3IgdGhlIGZ1dHVyZS4NCj4gDQo+IEFjY2Vzc2lu
ZyBzb21lIHN5bWJvbHMgZnJvbSB0aGUgaW50ZXJuYWwgQUJJIGlzIHByb2JhYmx5IG9rIGJ1dCBp
dCBpcw0KPiBhIHNsaXBwZXJ5IHRvcGljLg0KPiBMaWtlIHRoZSBldGhkZXYgb3BzIGNoYW5nZXMg
YmV0d2VlbiAyNS4xMS8yNi4wNyB0aGF0IHRyaWdnZXJlZCBjcmFzaGVzDQo+IGluIGFwcC90ZXN0
Lg0KDQpJIHRlbmQgdG8gYWdyZWUgd2l0aCBCcnVjZSdzIHN0YXRlbWVudCBhYm91dCB0aGUgcHVy
cG9zZSBvZiB0ZXN0cG1kOg0KVGhlIHB1cnBvc2Ugb2YgdGVzdHBtZCBpcyB0ZXN0aW5nIFBNRHMu
DQoNCldoZW4gdXNlZCBmb3IgUE1EIGRldmVsb3BtZW50IHB1cnBvc2VzLCB0aGlzIG1lYW5zOg0K
MS4gVGVzdHBtZCBzaG91bGQgYmUgYWxsb3dlZCB0byBnbyBkZWVwIGluc2lkZSBQTURzLg0KMi4g
VGVzdHBtZCBzaG91bGQgbm90IGJlIGxpbWl0ZWQgYnkgQUJJL0FQSSBzdGFiaWxpdHkuDQoNClRo
aXMgYWxzbyBtZWFucyB0aGF0IHRoZSB0ZXN0cG1kIHJlbGVhc2VkIHdpdGggRFBESyAyNy4wMyBp
cyBub3QgZXhwZWN0ZWQgdG8gYmUgY29tcGF0aWJsZSB3aXRoIHRoZSBEUERLIDI2LjExIExUUyBy
dW50aW1lLg0KSWYgYSBuZXcgcmVsZWFzZSBvZiB0ZXN0cG1kIG9mZmVycyBuZXcgZmVhdHVyZXMs
IHRoZXkgd2lsbCBub3QgYmUgYXZhaWxhYmxlIHVudGlsIHlvdSB1cGdyYWRlIHlvdXIgRFBESyBy
dW50aW1lLg0KDQoiTmljZSB0byBoYXZlIjoNCldoZW4gdXNlZCBmb3Igbm9uLVBNRCBkZXZlbG9w
bWVudCBwdXJwb3NlcywNCnBlcmhhcHMgdGVzdHBtZCBjb3VsZCBlbWl0IGEgd2FybmluZyBpZiBu
b3QgcnVubmluZyBvbiB0aGUgc2FtZSBidWlsZCBhcyB0aGUgRFBESyBydW50aW1lLg0KDQotTW9y
dGVuDQoNCg==
