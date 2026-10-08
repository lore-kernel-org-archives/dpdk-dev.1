Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128F5CA600E
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 07:19:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFB394027B;
	Thu,  8 Oct 2026 09:19:21 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id EE93E40274
 for <dev@dpdk.org>; Thu,  8 Oct 2026 09:19:19 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C74EF201E4;
 Thu,  8 Oct 2026 09:19:17 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH 20/20] mempool: promote memory range and alignment to
 stable
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 8 Oct 2026 09:19:16 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65AA3@smartserver.smartshare.dk>
In-Reply-To: <20261007214115.3092715-21-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 20/20] mempool: promote memory range and alignment to
 stable
Thread-Index: Ad1WpKW9JYRTvV0zSq+dPd78sU07TQAUKKZw
References: <20261007214115.3092715-1-stephen@networkplumber.org>
 <20261007214115.3092715-21-stephen@networkplumber.org>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
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

PiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3BsdW1iZXIu
b3JnXQ0KPiBTZW50OiBXZWRuZXNkYXksIDcgT2N0b2JlciAyMDI2IDIzLjQwDQo+IA0KPiBydGVf
bWVtcG9vbF9nZXRfbWVtX3JhbmdlKCkgYW5kIHJ0ZV9tZW1wb29sX2dldF9vYmpfYWxpZ25tZW50
KCkgd2VyZQ0KPiBhZGRlZCBpbiAyNC4wNyBhbmQgaGF2ZSBub3QgY2hhbmdlZCBzaW5jZS4gVGhl
IGJ1bGsgb2YgdGhlIG1lbXBvb2wgQVBJDQo+IGlzIGFscmVhZHkgc3RhYmxlLg0KPiANCj4gVGhl
IHRyYWNlIHBvaW50cyBhbmQgcnRlX21lbXBvb2xfc3RhdHNfcmVzZXQoKSBmcm9tIDI2LjA3IGFy
ZSBsZWZ0DQo+IGV4cGVyaW1lbnRhbC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN0ZXBoZW4gSGVt
bWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4NCj4gLS0tDQoNCkFja2VkLWJ5OiBN
b3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KDQo=
