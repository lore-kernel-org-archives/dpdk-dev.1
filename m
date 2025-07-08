Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379F1C83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 15:15:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D1A640677;
	Tue,  8 Jul 2025 17:15:47 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 6B08C4025E
 for <dev@dpdk.org>; Tue,  8 Jul 2025 17:15:45 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 3BBBD208F0;
 Tue,  8 Jul 2025 17:15:45 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH v3 03/18] test/mempool: fix test without stack driver
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 8 Jul 2025 17:15:43 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FDA7@smartserver.smartshare.dk>
In-Reply-To: <20250708122823.3406288-4-david.marchand@redhat.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 03/18] test/mempool: fix test without stack driver
Thread-Index: AdvwA/E0PRRseIXATrCPN/Kr4ZTpUAAFy38w
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
 <20250708122823.3406288-4-david.marchand@redhat.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "David Marchand" <david.marchand@redhat.com>,
	<dev@dpdk.org>
Cc: "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Marat Khalili" <marat.khalili@huawei.com>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

PiBGcm9tOiBEYXZpZCBNYXJjaGFuZCBbbWFpbHRvOmRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb21d
DQo+IFNlbnQ6IFR1ZXNkYXksIDggSnVseSAyMDI1IDE0LjI4DQo+IA0KPiBJbiBhIG1pbmltYWwg
YnVpbGQsIHRoZSBtZW1wb29sL3N0YWNrIGRyaXZlciBpcyBkaXNhYmxlZC4NCj4gU2VwYXJhdGUg
dGhlIGNvZGUgc3BlY2lmaWMgdG8gdGhpcyBleHRlcm5hbCBkcml2ZXIgYW5kIHJlbmFtZSB1bnJl
bGF0ZWQNCj4gdmFyaWFibGVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTWFyY2hhbmQg
PGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+DQo+IEFja2VkLWJ5OiBBbmRyZXcgUnliY2hlbmtv
IDxhbmRyZXcucnliY2hlbmtvQG9rdGV0bGFicy5ydT4NCj4gUmV2aWV3ZWQtYnk6IE1hcmF0IEto
YWxpbGkgPG1hcmF0LmtoYWxpbGlAaHVhd2VpLmNvbT4NCj4gLS0tDQoNCkFja2VkLWJ5OiBNb3J0
ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KDQo=
