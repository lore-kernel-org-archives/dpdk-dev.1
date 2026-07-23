Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149D9C531F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 15:04:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEF5B40679;
	Thu, 23 Jul 2026 17:04:56 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E54B340663
 for <dev@dpdk.org>; Thu, 23 Jul 2026 17:04:55 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id DFE58205EE;
 Thu, 23 Jul 2026 17:04:53 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v2 7/9] test: limit internal API usage
Date: Thu, 23 Jul 2026 17:04:52 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6599A@smartserver.smartshare.dk>
In-Reply-To: <20260723125559.3087579-8-david.marchand@redhat.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 7/9] test: limit internal API usage
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Index: Ad0aorjyv/9RSpq2Tk+IzEec6wSf9AAEdLbA
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260723125559.3087579-1-david.marchand@redhat.com>
 <20260723125559.3087579-8-david.marchand@redhat.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "David Marchand" <david.marchand@redhat.com>,
	<dev@dpdk.org>
Cc: <bruce.richardson@intel.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Reshma Pattan" <reshma.pattan@intel.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
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
DQo+IFNlbnQ6IFRodXJzZGF5LCAyMyBKdWx5IDIwMjYgMTQuNTYNCj4gDQo+IEludGVybmFsIEFQ
SXMgbWF5IGJlIHVzZWQgZm9yIHZhbGlkYXRpbmcgdGhlIGludGVybmFscyBvZiBzb21lDQo+IGNv
bXBvbmVudCwgYnV0IGluIGdlbmVyYWwsIGl0IHNob3VsZCBiZSBkaXNjb3VyYWdlZC4NCj4gDQo+
IExldCdzIG5vdCBhbGxvdyBnbG9iYWxseSBpbnRlcm5hbCBBUEkgaW4gdGhlIHVuaXQgdGVzdHMu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBNYXJjaGFuZCA8ZGF2aWQubWFyY2hhbmRAcmVk
aGF0LmNvbT4NCj4gLS0tDQoNCkFja2VkLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFy
ZXN5c3RlbXMuY29tPg0KDQo=
