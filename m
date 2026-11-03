Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A2A606A329
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 06:29:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9518D4028B;
	Tue,  3 Nov 2026 07:29:47 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTPS id 6A74F40278
 for <dev@dpdk.org>; Tue,  3 Nov 2026 07:29:46 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 189A0207E3;
 Tue,  3 Nov 2026 07:29:46 +0100 (CET)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [RFC 0/2] move module EEPROM decoding to a transceiver library
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 3 Nov 2026 07:29:43 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65AEF@smartserver.smartshare.dk>
In-Reply-To: <20261103041851.447193-1-roma55592@yandex.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC 0/2] move module EEPROM decoding to a transceiver library
Thread-Index: Ad1rSpj+SgQBP6jWQIe9C9xpgOsLfQAEf1dw
References: <20261014071245.2323258-1-roma55592@yandex.ru>
 <98CBD80474FA8B44BF855DF32C47DC35F65AEC@smartserver.smartshare.dk>
 <20261103041851.447193-1-roma55592@yandex.ru>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Roman Khromenok" <roma55592@yandex.ru>,
	<dev@dpdk.org>
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <andrew.rybchenko@oktetlabs.ru>
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

PiBGcm9tOiBSb21hbiBLaHJvbWVub2sgW21haWx0bzpyb21hNTU1OTJAeWFuZGV4LnJ1XQ0KPiBT
ZW50OiBUdWVzZGF5LCAzIE5vdmVtYmVyIDIwMjYgMDUuMTkNCj4gDQo+IDAyLzExLzIwMjYgMTI6
MDcsIE1vcnRlbiBCcsO4cnVwOg0KPiA+IEFyZSB0aGVyZSBhbnkgQVBJcyB0byB0ZWxsIGlmIGEg
dHJhbnNjZWl2ZXIgbW9kdWxlIGlzIHBsdWdnZWQgaW50bw0KPiB0aGUNCj4gPiB0cmFuc2NlaXZl
ciBtb2R1bGUgc29ja2V0IG9uIHRoZSBOSUMsIGVpdGhlciBpbiB0aGUgZXRoZGV2IGxpYnJhcnkg
b3INCj4gPiB1bmRlciB0aGlzIG5ldyB0cmFuc2NlaXZlciBsaWJyYXJ5Pw0KPiANCj4gVGhlcmUg
aXMgbm8gZGVkaWNhdGVkICJtb2R1bGUgcHJlc2VudCIgQVBJIGluIERQREsgdG9kYXkuDQo+IA0K
PiBNb2R1bGUgcHJlc2VuY2UgaXMgb25seSBkZXRlY3RlZCBpbmRpcmVjdGx5Og0KPiBydGVfZXRo
X2Rldl9nZXRfbW9kdWxlX2luZm8oKQ0KPiBhbmQgcnRlX2V0aF9kZXZfZ2V0X21vZHVsZV9lZXBy
b20oKSByZXR1cm4gYW4gZXJyb3IsIGZvciBleGFtcGxlIC1FSU8sDQo+IHdoZW4gbm8gbW9kdWxl
IGlzIHBsdWdnZWQsIGJ1dCBvbmx5IGZvciBkcml2ZXJzIGltcGxlbWVudGluZyB0aGVzZQ0KPiBv
cGVyYXRpb25zIChpeGdiZSwgaTQwZSwgaWNlLCBobnMzLCBjbnhrLCAuLi4pLiBUaGUgbGluayBz
dGF0ZSBpcyBub3QgYQ0KPiByZWxpYWJsZSBpbmRpY2F0b3IgZWl0aGVyOiBhIHBsdWdnZWQgbW9k
dWxlIGNhbiBiZSBkb3duLCBhbmQgc29tZQ0KPiBtb2R1bGVzIChEQUMgY2FibGVzKSByZXBvcnQg
bGluayB3aXRob3V0IG9wdGljYWwgZGlhZ25vc3RpY3MuDQo+IA0KPiBUaGUgdHJhbnNjZWl2ZXIg
bGlicmFyeSBjYW5ub3QgZGV0ZWN0IHByZXNlbmNlIGJ5IGRlc2lnbjogaXQgd29ya3Mgb24NCj4g
dGhlIHJhdyBFRVBST00gYnl0ZXMgb25seSBhbmQgaGFzIG5vIGRlcGVuZGVuY3kgb24gYW55IGRl
dmljZSwgZHJpdmVyDQo+IG9yIGV2ZW4gRUFMIGluaXRpYWxpemF0aW9uLiBUaGlzIGlzIGFsc28g
d2hhdCBtYWtlcyBpdCB1c2FibGUgZm9yDQo+IGtlcm5lbCBwb3J0cyByZWFkIHdpdGggdGhlIGV0
aHRvb2wgaW9jdGxzLg0KPiANCj4gUGh5c2ljYWxseSwgbW9kdWxlIHByZXNlbmNlIGlzIGEgTU9E
X0FCUyBwaW4gb2YgdGhlIHNvY2tldCwgbm90DQo+IHNvbWV0aGluZyB0aGF0IGNhbiBiZSByZWFk
IGZyb20gdGhlIEVFUFJPTSwgc28gaXQgYmVsb25ncyB0byB0aGUNCj4gZHJpdmVyIGxldmVsLiBJ
ZiBhbiBleHBsaWNpdCBwcmVzZW5jZSBBUEkgaXMgd2FudGVkLCBJIHRoaW5rIGl0IHNob3VsZA0K
PiBiZSBhIHNlcGFyYXRlIGV0aGRldiBkZXZpY2Ugb3BlcmF0aW9uLCBmb3IgZXhhbXBsZQ0KPiAu
Z2V0X21vZHVsZV9wcmVzZW5jZSwgc28gZHJpdmVycyBjb3VsZCByZXBvcnQgaXQgd2l0aG91dCBh
dHRlbXB0aW5nIGFuDQo+IEVFUFJPTSByZWFkLiBUaGF0IHdvdWxkIGJlIGEgZm9sbG93LXVwIHNl
cmllcywgaW5kZXBlbmRlbnQgb2YgdGhpcyBvbmUuDQo+IA0KPiBUaGFua3MsDQo+IFJvbWFuDQoN
ClRoYW5rIHlvdSBmb3IgdGhlIGRldGFpbGVkIHJlcGx5Lg0KSSBhZ3JlZSB3aXRoIHlvdXIgY29u
Y2x1c2lvbnMuDQoNCi1Nb3J0ZW4NCg==
