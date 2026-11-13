Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518E5607E83D
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 17:40:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8751D4028E;
	Fri, 13 Nov 2026 18:40:20 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTPS id ABDC54003C
 for <dev@dpdk.org>; Fri, 13 Nov 2026 18:40:18 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5E96D20972;
 Fri, 13 Nov 2026 18:40:18 +0100 (CET)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: RE: [PATCH 2/3] app/testpmd: remove mbuf cache size limit
Content-Transfer-Encoding: base64
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 13 Nov 2026 18:40:17 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65B0A@smartserver.smartshare.dk>
In-Reply-To: <20261113155633.1883479-2-kishore.padmanabha@broadcom.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/3] app/testpmd: remove mbuf cache size limit
Thread-Index: Ad1zh7n+3BlMEK5STbiXRT3ILrd6iQADbolQ
References: <20261113155633.1883479-1-kishore.padmanabha@broadcom.com>
 <20261113155633.1883479-2-kishore.padmanabha@broadcom.com>
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

PiAgKiAgIGBgLS1tYmNhY2hlPU5gYA0KPiANCj4gLSAgICBTZXQgdGhlIGNhY2hlIG9mIG1idWYg
bWVtb3J5IHBvb2xzIHRvIE4sIHdoZXJlIDAgPD0gTiA8PSA1MTIuDQo+ICsgICAgU2V0IHRoZSBj
YWNoZSBvZiBtYnVmIG1lbW9yeSBwb29scyB0byBOLCB3aGVyZSAwIDw9IE4gPD0NCj4gVUlOVDE2
X01BWC4NCg0KTml0cGlja2luZzoNCjY1NTM1IGluc3RlYWQgb2YgVUlOVDE2X01BWC4NCg0KPiAg
ICAgIFRoZSBkZWZhdWx0IHZhbHVlIGlzIDE2Lg0KDQpXaGlsZSB1cGRhdGluZyB0aGlzIGZpbGUs
IHBsZWFzZSBmaXggdGhpcyB0b28uDQpUaGUgZGVmYXVsdCB2YWx1ZSBpcyAyNTAsIG5vdCAxNi4N
Cg0KPiANCj4gICogICBgYC0tcnhwdD1OYGANCj4gLS0NCj4gMi41NC4wDQoNCldpdGggb3Igd2l0
aG91dCBzdWdnZXN0ZWQgZml4ZXMsDQpSZXZpZXdlZC1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNt
YXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCg0K
