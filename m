Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E442606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 14:20:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C131A402D6;
	Thu, 19 Nov 2026 15:20:37 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTPS id 4D800400D7;
 Thu, 19 Nov 2026 15:20:36 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E0C6C20C50;
 Thu, 19 Nov 2026 15:20:35 +0100 (CET)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v4 2/3] mempool: fix dump of unpopulated pool
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 19 Nov 2026 15:20:33 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65B16@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4 2/3] mempool: fix dump of unpopulated pool
Thread-Index: Ad14L27WjX/kz57PQ42iENv6i9rGaQAABYiAAABlCLA=
References: <20261109144054.3784583-1-rsanford2@gmail.com>
 <20261112154342.1484709-1-rsanford2@gmail.com>
 <20261112154342.1484709-3-rsanford2@gmail.com>
 <eexnNMGcSbWMwzjgikVLXw@monjalon.net> 
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "Thomas Monjalon" <thomas@monjalon.net>,
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

PiBGcm9tOiBNb3J0ZW4gQnLDuHJ1cA0KPiBTZW50OiBUaHVyc2RheSwgMTkgTm92ZW1iZXIgMjAy
NiAwNi4xOA0KPiANCj4gPiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0bzp0aG9tYXNAbW9u
amFsb24ubmV0XQ0KPiA+IFNlbnQ6IFRodXJzZGF5LCAxOSBOb3ZlbWJlciAyMDI2IDA2LjA4DQo+
ID4NCj4gPiAxMi8xMS8yMDI2IDE2OjQzLCBSb2JlcnQgU2FuZm9yZDoNCj4gPiA+ICsqICoqQWRk
ZWQgZnVuY3Rpb24gdG8gY2hlY2sgaWYgYSBtZW1wb29sIGlzIGNyZWF0ZWQuKioNCj4gPiA+ICsN
Cj4gPiA+ICsgIEFkZGVkIHRoZSBgYHJ0ZV9tZW1wb29sX2lzX2NyZWF0ZWQoKWBgIGZ1bmN0aW9u
DQo+ID4gPiArICB0byBjaGVjayB3aGV0aGVyIHRoZSBzdG9yZSBvZiBhIG1lbXBvb2wgaGFzIGJl
ZW4gY3JlYXRlZC4NCj4gPiA+ICsgIGBgcnRlX21lbXBvb2xfd2FsaygpYGAgY2FsbGJhY2tzIGNh
biB1c2UgaXQgdG8gc2tpcCBtZW1wb29scw0KPiA+ID4gKyAgdGhhdCBhcmUgbm90IHBvcHVsYXRl
ZCB5ZXQgYmVmb3JlIHF1ZXJ5aW5nIHRoZSBtZW1wb29sIGRyaXZlci4NCj4gPg0KPiA+IElmIHVz
YWdlIGlzIGludGVybmFsLCB3aHkgZXhwb3NpbmcgdGhpcyBmdW5jdGlvbiBwdWJsaWNseT8NCj4g
DQo+IEl0IGlzIGFsc28gZm9yIHB1YmxpYyB1c2U6DQo+IElmIGFuIGFwcGxpY2F0aW9uIHdhbGtz
IHRoZSBsaXN0IG9mIG1lbXBvb2xzIHVzaW5nIHRoZSBwdWJsaWMgZnVuY3Rpb24NCj4gcnRlX21l
bXBvb2xfd2FsaygpLCB3ZSBuZWVkIGEgcHVibGljIGZ1bmN0aW9uIGZvciB0aGUgYXBwbGljYXRp
b24ncw0KPiBjYWxsYmFjayB0byBkZXRlcm1pbmUgaWYgdGhlIG1lbXBvb2wgaXMgY3JlYXRlZCAo
aS5lLiBkcml2ZXIgY2FsbGJhY2tzDQo+IGFyZSBpbml0aWFsaXplZCkuIElmIHRoZSBtZW1wb29s
IGlzIG5vdCBjcmVhdGVkLCBhY2Nlc3NpbmcgdGhlIG1lbXBvb2wNCj4gZHJpdmVyIGlzIG5vdyBh
bGxvd2VkLg0KDQpUeXBvOiBpcyBOT1QgYWxsb3dlZC4NCg0KPiANCj4gPg0KPiA+IFsuLi5dDQo+
ID4gPiArYm9vbCBydGVfbWVtcG9vbF9pc19jcmVhdGVkKGNvbnN0IHN0cnVjdCBydGVfbWVtcG9v
bCAqbXApOw0KPiA+DQo+ID4gQW55IG5ldyBBUEkgbXVzdCBlbnRlciBpbiBhbiBleHBlcmltZW50
YWwgZmlyc3QuDQo+ID4gQnV0IGhlcmUgd2UgbWF5IG5vdCBuZWVkIHRvIGV4cG9zZSBpdCBhcyBh
biBBUEk/DQo+IA0KPiBJZiBpdCBpcyBtYXJrZWQgYXMgZXhwZXJpbWVudGFsLCBpdCBjYW5ub3Qg
YmUgdXNlZCBpbnRlcm5hbGx5LCBhbmQgaXRzDQo+IGludGVybmFsIHVzZXIgd291bGQgbmVlZCB0
byBpbXBsZW1lbnQgc2ltaWxhciBmdW5jdGlvbmFsaXR5Lg0KPiBBbmQgc2luY2UgaXQgaXMgYSBz
aW1wbGUgZnVuY3Rpb24sIHdlIGRlY2lkZWQgdG8gc2tpcCB0aGUgZXhwZXJpbWVudGFsDQo+IHN0
YWdlLg0KPiBUaGUgYWx0ZXJuYXRpdmUgd2FzIG1ha2luZyBpdCBpbmxpbmU7IGJ1dCBpdCBpcyBu
b3QgYSBmYXN0IHBhdGgNCj4gZnVuY3Rpb24sIEkgcHJlZmVycmVkIG5vdCB0by4NCj4gDQo+IC1N
b3J0ZW4NCg==
