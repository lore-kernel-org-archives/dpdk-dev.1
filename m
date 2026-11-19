Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15113606A324
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 14:18:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6661402D6;
	Thu, 19 Nov 2026 15:18:19 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTPS id 0392C400D7;
 Thu, 19 Nov 2026 15:18:18 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 8829B20C50;
 Thu, 19 Nov 2026 15:18:16 +0100 (CET)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v4 2/3] mempool: fix dump of unpopulated pool
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 19 Nov 2026 15:18:14 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65B15@smartserver.smartshare.dk>
In-Reply-To: <eexnNMGcSbWMwzjgikVLXw@monjalon.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4 2/3] mempool: fix dump of unpopulated pool
Thread-Index: Ad14L27WjX/kz57PQ42iENv6i9rGaQAABYiA
References: <20261109144054.3784583-1-rsanford2@gmail.com>
 <20261112154342.1484709-1-rsanford2@gmail.com>
 <20261112154342.1484709-3-rsanford2@gmail.com>
 <eexnNMGcSbWMwzjgikVLXw@monjalon.net>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
 "Robert Sanford" <rsanford@akamai.com>,
 "Robert Sanford" <rsanford2@gmail.com>
Cc: <dev@dpdk.org>, <andrew.rybchenko@oktetlabs.ru>, <olivier.matz@6wind.com>,
 <stable@dpdk.org>, "David Marchand" <david.marchand@redhat.com>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0bzp0aG9tYXNAbW9uamFsb24ubmV0XQ0KPiBT
ZW50OiBUaHVyc2RheSwgMTkgTm92ZW1iZXIgMjAyNiAwNi4wOA0KPiANCj4gMTIvMTEvMjAyNiAx
Njo0MywgUm9iZXJ0IFNhbmZvcmQ6DQo+ID4gKyogKipBZGRlZCBmdW5jdGlvbiB0byBjaGVjayBp
ZiBhIG1lbXBvb2wgaXMgY3JlYXRlZC4qKg0KPiA+ICsNCj4gPiArICBBZGRlZCB0aGUgYGBydGVf
bWVtcG9vbF9pc19jcmVhdGVkKClgYCBmdW5jdGlvbg0KPiA+ICsgIHRvIGNoZWNrIHdoZXRoZXIg
dGhlIHN0b3JlIG9mIGEgbWVtcG9vbCBoYXMgYmVlbiBjcmVhdGVkLg0KPiA+ICsgIGBgcnRlX21l
bXBvb2xfd2FsaygpYGAgY2FsbGJhY2tzIGNhbiB1c2UgaXQgdG8gc2tpcCBtZW1wb29scw0KPiA+
ICsgIHRoYXQgYXJlIG5vdCBwb3B1bGF0ZWQgeWV0IGJlZm9yZSBxdWVyeWluZyB0aGUgbWVtcG9v
bCBkcml2ZXIuDQo+IA0KPiBJZiB1c2FnZSBpcyBpbnRlcm5hbCwgd2h5IGV4cG9zaW5nIHRoaXMg
ZnVuY3Rpb24gcHVibGljbHk/DQoNCkl0IGlzIGFsc28gZm9yIHB1YmxpYyB1c2U6DQpJZiBhbiBh
cHBsaWNhdGlvbiB3YWxrcyB0aGUgbGlzdCBvZiBtZW1wb29scyB1c2luZyB0aGUgcHVibGljIGZ1
bmN0aW9uIHJ0ZV9tZW1wb29sX3dhbGsoKSwgd2UgbmVlZCBhIHB1YmxpYyBmdW5jdGlvbiBmb3Ig
dGhlIGFwcGxpY2F0aW9uJ3MgY2FsbGJhY2sgdG8gZGV0ZXJtaW5lIGlmIHRoZSBtZW1wb29sIGlz
IGNyZWF0ZWQgKGkuZS4gZHJpdmVyIGNhbGxiYWNrcyBhcmUgaW5pdGlhbGl6ZWQpLiBJZiB0aGUg
bWVtcG9vbCBpcyBub3QgY3JlYXRlZCwgYWNjZXNzaW5nIHRoZSBtZW1wb29sIGRyaXZlciBpcyBu
b3cgYWxsb3dlZC4NCg0KPiANCj4gWy4uLl0NCj4gPiArYm9vbCBydGVfbWVtcG9vbF9pc19jcmVh
dGVkKGNvbnN0IHN0cnVjdCBydGVfbWVtcG9vbCAqbXApOw0KPiANCj4gQW55IG5ldyBBUEkgbXVz
dCBlbnRlciBpbiBhbiBleHBlcmltZW50YWwgZmlyc3QuDQo+IEJ1dCBoZXJlIHdlIG1heSBub3Qg
bmVlZCB0byBleHBvc2UgaXQgYXMgYW4gQVBJPw0KDQpJZiBpdCBpcyBtYXJrZWQgYXMgZXhwZXJp
bWVudGFsLCBpdCBjYW5ub3QgYmUgdXNlZCBpbnRlcm5hbGx5LCBhbmQgaXRzIGludGVybmFsIHVz
ZXIgd291bGQgbmVlZCB0byBpbXBsZW1lbnQgc2ltaWxhciBmdW5jdGlvbmFsaXR5Lg0KQW5kIHNp
bmNlIGl0IGlzIGEgc2ltcGxlIGZ1bmN0aW9uLCB3ZSBkZWNpZGVkIHRvIHNraXAgdGhlIGV4cGVy
aW1lbnRhbCBzdGFnZS4NClRoZSBhbHRlcm5hdGl2ZSB3YXMgbWFraW5nIGl0IGlubGluZTsgYnV0
IGl0IGlzIG5vdCBhIGZhc3QgcGF0aCBmdW5jdGlvbiwgSSBwcmVmZXJyZWQgbm90IHRvLg0KDQot
TW9ydGVuDQo=
