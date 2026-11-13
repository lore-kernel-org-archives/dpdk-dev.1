Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFB4606A323
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 20:28:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F8C340E34;
	Fri, 13 Nov 2026 21:28:12 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTPS id 51FE94028E;
 Fri, 13 Nov 2026 21:28:10 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id F36E420972;
 Fri, 13 Nov 2026 21:28:09 +0100 (CET)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: RE: [PATCH v5] examples/l3fwd: fix RFC 1812 checks
Content-Transfer-Encoding: base64
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 13 Nov 2026 21:28:09 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65B0E@smartserver.smartshare.dk>
In-Reply-To: <p157maOqQ8evUr4r5eTihA@monjalon.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5] examples/l3fwd: fix RFC 1812 checks
Thread-Index: Ad1y6mvF/yri3FZAQPOalQpfr7JirwAwTEEQ
References: <20260915105822.988106-1-mb@smartsharesystems.com>
 <20261024123557.3234240-1-mb@smartsharesystems.com>
 <p157maOqQ8evUr4r5eTihA@monjalon.net>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: <dev@dpdk.org>,
	<stable@dpdk.org>
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

VGhhbmsgeW91IGZvciByZXZpZXdpbmcuDQoNCj4gMyBjb21tZW50cyBmcm9tIEFJOg0KPiANCj4g
LSBUaGUgc29mdHdhcmUgY2hlY2tzdW0gcmVhZHMgdGhlIGhlYWRlciBiZWZvcmUgdmFsaWRhdGlu
ZyBpdHMgbGVuZ3RoLg0KPiAgIEEgdHJ1bmNhdGVkIHBhY2tldCB3aXRoIGFuIG92ZXJzaXplZCBJ
SEwgY2F1c2VzIGFuIG91dC1vZi1ib3VuZHMNCj4gcmVhZC4NCg0KRml4ZWQgaW4gdjYuDQoNCj4g
DQo+IC0gQ0tTVU1fTk9ORSBwYWNrZXRzIGFyZSBhY2NlcHRlZCB3aXRob3V0IHJlYnVpbGRpbmcg
dGhlaXIgY2hlY2tzdW0sDQo+ICAgc28gZm9yd2FyZGluZyBsZWF2ZXMgaXQgaW52YWxpZC4NCg0K
Rml4ZWQgaW4gdjYuDQoNCj4gDQo+IC0gUHJlLWV4aXN0aW5nOiB0aGUgRU0gcGF0aCBzdGlsbCBj
YWxscyBzZW5kX3NpbmdsZV9wYWNrZXQoKQ0KPiAgIGFmdGVyIHZhbGlkYXRpb24gZnJlZXMgdGhl
IHBhY2tldCBhbmQgcmV0dXJucyBCQURfUE9SVCwNCj4gICBjYXVzaW5nIGFuIG91dC1vZi1ib3Vu
ZHMgYXJyYXkgYWNjZXNzLg0KDQpUaGF0IGJ1ZyBpcyBub3QgZGlyZWN0bHkgcmVsYXRlZCB0byB0
aGUgUkZDIDE4MTIgY2hlY2sgYnVncyBmaXhlZCBpbiB0aGlzIHNlcmllcy4NCkknbSBub3QgZXh0
ZW5kaW5nIHRoaXMgc2VyaWVzIHRvIGZpeCBtb3JlIGJ1Z3MgbGlrZSB0aGF0IG9uZS4NCg0K
