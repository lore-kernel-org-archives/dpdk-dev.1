Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EC9606C0B1
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 17:33:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFED64028E;
	Fri, 13 Nov 2026 18:33:03 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTPS id 535C94003C
 for <dev@dpdk.org>; Fri, 13 Nov 2026 18:33:02 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id AE4DE20972;
 Fri, 13 Nov 2026 18:32:59 +0100 (CET)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: RE: [PATCH 1/3] mempool: remove assumptions on maximum cache size
Content-Transfer-Encoding: base64
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 13 Nov 2026 18:32:58 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65B09@smartserver.smartshare.dk>
In-Reply-To: <20261113155633.1883479-1-kishore.padmanabha@broadcom.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/3] mempool: remove assumptions on maximum cache size
Thread-Index: Ad1zh5hbJcuPJV0oSHaXLBmHqN3uBQADPUeA
References: <20261113155633.1883479-1-kishore.padmanabha@broadcom.com>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBGcm9tOiBLaXNob3JlIFBhZG1hbmFiaGEgW21haWx0bzpraXNob3JlLnBhZG1hbmFiaGFAYnJv
YWRjb20uY29tXQ0KPiBTZW50OiBGcmlkYXksIDEzIE5vdmVtYmVyIDIwMjYgMDcuNTcNCj4gDQo+
IFNpbmNlIHRoZSBjYWNoZSBzaXplIGxpbWl0IHdhcyByZW1vdmVkLCBhIG1lbXBvb2wgY2FjaGUg
Y2FuIGJlIGNyZWF0ZWQNCj4gd2l0aCBhbnkgc2l6ZSB1cCB0byB0aGUgbnVtYmVyIG9mIG9iamVj
dHMgaW4gdGhlIG1lbXBvb2wuDQo+IFJURV9NRU1QT09MX0NBQ0hFX01BWF9TSVpFIGlzIHRoZXJl
Zm9yZSBubyBsb25nZXIgYW4gdXBwZXIgYm91bmQgZm9yDQo+IHRoZSBjYWNoZSBzaXplLCBub3Ig
Zm9yIHRoZSBudW1iZXIgb2Ygb2JqZWN0cyBpbiB0aGUgY2FjaGUuDQo+IA0KPiBUaGUgcHV0IGFu
ZCBnZXQgZnVuY3Rpb25zIHN0aWxsIHBhc3NlZCBhc3N1bXB0aW9ucyBkZXJpdmVkIGZyb20gdGhp
cw0KPiBjb25zdGFudCB0byB0aGUgY29tcGlsZXIuIFRoZXkgYXJlIHdyb25nIGZvciBhIGNhY2hl
IGxhcmdlciB0aGFuDQo+IFJURV9NRU1QT09MX0NBQ0hFX01BWF9TSVpFLCBhbmQgdmlvbGF0aW5n
IGEgY29tcGlsZXIgYXNzdW1wdGlvbiBpcw0KPiB1bmRlZmluZWQgYmVoYXZpb3IuDQo+IA0KPiBS
ZW1vdmUgdGhlIGFzc3VtcHRpb25zIGJhc2VkIG9uIHRoZSBjb25zdGFudCwgYW5kIGFzc3VtZSB0
aGF0IHRoZQ0KPiBudW1iZXINCj4gb2Ygb2JqZWN0cyBpbiB0aGUgY2FjaGUgZG9lcyBub3QgZXhj
ZWVkIHRoZSBjYWNoZSBzaXplIGluc3RlYWQuDQo+IA0KPiBGaXhlczogYjgxNWFjZmRmYzQ4ICgi
bWVtcG9vbDogcmVtb3ZlIGNhY2hlIHNpemUgbGltaXQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBLaXNo
b3JlIFBhZG1hbmFiaGEgPGtpc2hvcmUucGFkbWFuYWJoYUBicm9hZGNvbS5jb20+DQo+IC0tLQ0K
DQpJbXBvcnRhbnQgZml4LCB0aGFuayB5b3UhDQoNClJldmlld2VkLWJ5OiBNb3J0ZW4gQnLDuHJ1
cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KDQpJZiB5b3UgaGF2ZSB0aW1lL3Jlc291cmNl
cyBhdmFpbGFibGUsIGNvdWxkIHlvdSBwbGVhc2UgY2hlY2sgaWYgc2ltaWxhciBmaXhlcyBhcmUg
cmVxdWlyZWQgaW4gb3RoZXIgY29kZSB3aGVyZSBSVEVfTUVNUE9PTF9DQUNIRV9NQVhfU0laRSB1
c2VkOg0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vZHBkay92MjYuMTEtcmMxL0EvaWRlbnQv
UlRFX01FTVBPT0xfQ0FDSEVfTUFYX1NJWkUNCg0KLU1vcnRlbg0K
