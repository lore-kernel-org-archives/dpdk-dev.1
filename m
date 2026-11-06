Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63044606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 19:24:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AED942DC7;
	Fri,  6 Nov 2026 20:24:07 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTPS id BF1F6402AC;
 Fri,  6 Nov 2026 20:24:05 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 242032384F;
 Fri,  6 Nov 2026 20:24:05 +0100 (CET)
Content-class: urn:content-classes:message
Subject: RE: [PATCH v2 2/3] mempool: fix dump of unpopulated pool
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 6 Nov 2026 20:24:02 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65AFF@smartserver.smartshare.dk>
In-Reply-To: <20261106184329.2095115-1-rsanford2@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 2/3] mempool: fix dump of unpopulated pool
Thread-Index: Ad1uHsik29Iyk9DjRIqGeRuxVzwAsAABN+0g
References: <20261103011107.3658840-1-rsanford2@gmail.com>
 <20261103173543.130142-1-rsanford2@gmail.com>
 <20261103173543.130142-3-rsanford2@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65AFD@smartserver.smartshare.dk>
 <20261106184329.2095115-1-rsanford2@gmail.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Robert Sanford" <rsanford2@gmail.com>,
	<dev@dpdk.org>
Cc: <andrew.rybchenko@oktetlabs.ru>, <olivier.matz@6wind.com>,
 <stable@dpdk.org>, <rsanford@akamai.com>
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

PiBGcm9tOiBSb2JlcnQgU2FuZm9yZCBbbWFpbHRvOnJzYW5mb3JkMkBnbWFpbC5jb21dDQo+IFNl
bnQ6IEZyaWRheSwgNiBOb3ZlbWJlciAyMDI2IDE5LjQzDQo+IA0KPiBIaSBNb3J0ZW4sDQo+IA0K
PiBUaGFua3MgZm9yIHRoZSByZXZpZXcuDQo+IA0KPiA+IG1lbXBvb2xfaXNfY3JlYXRlZCgpIHNo
b3VsZCBiZSBwdWJsaWMgYXMgcnRlX21lbXBvb2xfaXNfY3JlYXRlZCgpLg0KPiANCj4gSSBtYWRl
IHRoZSBjaGFuZ2U6IHJ0ZV9tZW1wb29sX2lzX2NyZWF0ZWQoKSBpcyBwdWJsaWMsIG5vbi1pbmxp
bmUsDQo+IG5vdCBleHBlcmltZW50YWwsIGFuZCB0aGUgcnRlX21lbXBvb2xfd2FsaygpIGRlc2Ny
aXB0aW9uIHJlZmVycyB0byBpdC4NCj4gDQo+IEhvd2V2ZXIsIGRldnRvb2xzL2NoZWNrLXN5bWJv
bC1jaGFuZ2UucHkgcmVwb3J0czoNCj4gDQo+ICAgRVJST1I6IHJ0ZV9tZW1wb29sX2lzX2NyZWF0
ZWQgaW4gbGliL21lbXBvb2wgaGFzIGJlZW4gYWRkZWQgZGlyZWN0bHkNCj4gICB0byBzdGFibGUg
QUJJLg0KPiANCj4gSG93IHdvdWxkIHlvdSBsaWtlIG1lIHRvIHByb2NlZWQ/DQoNClBsZWFzZSBp
Z25vcmUgdGhlIGVycm9yLCBhbmQgc2VuZCB0aGUgc2VyaWVzIGFueXdheS4NClBhdGNoIGFjY2Vw
dGFuY2UgaXMgYSBtYW51YWwgcHJvY2VzcywgYW5kIHdlIGNhbiBpZ25vcmUgZXJyb3JzIGxpa2Ug
dGhpcywgd2hlbiByZWxldmFudC4NCg0KSSBjb25zaWRlciB0aGUgYWx0ZXJuYXRpdmUsIGFuIGV4
cGVyaW1lbnRhbCBwdWJsaWMgZnVuY3Rpb24sIGFuZCBhIHByaXZhdGUgZnVuY3Rpb24gZG9pbmcg
ZXhhY3RseSB0aGUgc2FtZSAob3IgY29weS1wYXN0ZWQgY29kZSB0byBhdG9taWNhbGx5IGNoZWNr
IHRoZSAiY3JlYXRlZCIgZmxhZyksIGFuIHVnbHkgaGFjay4NCg0KLU1vcnRlbg0KDQo=
