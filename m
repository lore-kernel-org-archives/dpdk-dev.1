Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE49CD98CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 09:55:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FD724060C;
	Tue, 16 Jun 2026 11:55:01 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D730C40289;
 Tue, 16 Jun 2026 11:54:59 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D72CA2067E;
 Tue, 16 Jun 2026 11:54:58 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH 2/2] ethdev: return 0 from dummy queue count
Date: Tue, 16 Jun 2026 11:54:55 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65910@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260616094259.686555-3-maxime@leroys.fr>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/2] ethdev: return 0 from dummy queue count
Thread-Index: Adz9dIxfkwapSeGARmu9nZW/P3mFQwAAY4mQ
References: <20260616094259.686555-1-maxime@leroys.fr>
 <20260616094259.686555-3-maxime@leroys.fr>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Maxime Leroy" <maxime@leroys.fr>,
	<dev@dpdk.org>
Cc: <stable@dpdk.org>, "Stephen Hemminger" <stephen@networkplumber.org>,
 "Thomas Monjalon" <thomas@monjalon.net>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Sunil Kumar Kori" <skori@marvell.com>
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

PiBGcm9tOiBNYXhpbWUgTGVyb3kgW21haWx0bzptYXhpbWUubGVyb3lzQGdtYWlsLmNvbV0gT24g
QmVoYWxmIE9mIE1heGltZQ0KPiBMZXJveQ0KPiBTZW50OiBUdWVzZGF5LCAxNiBKdW5lIDIwMjYg
MTEuNDMNCj4gDQo+IFRoZSBkdW1teSByeF9xdWV1ZV9jb3VudC90eF9xdWV1ZV9jb3VudCBjYWxs
YmFjayByZXR1cm5lZCAtRU5PVFNVUC4gT24NCj4gYQ0KPiBwb3J0IHRoYXQgaXMgbm90IHN0YXJ0
ZWQgKGZyZXNobHkgYWxsb2NhdGVkLCBvciBzdG9wcGVkIG9uY2UgdGhlIGZhc3QtDQo+IHBhdGgN
Cj4gb3BzIGFyZSByZXNldCB0byBkdW1taWVzKSB0aGVyZSBhcmUgbm8gcGFja2V0cyBxdWV1ZWQs
IHNvIHRoZSB0cnV0aGZ1bA0KPiBhbnN3ZXIgaXMgMCwgbm90IGFuIGVycm9yOiBxdWVyeWluZyB0
aGUgY291bnQgaXMgbm90IGFuIHVuc3VwcG9ydGVkDQo+IG9wZXJhdGlvbi4gVGhpcyBhbHNvIG1h
dGNoZXMgdGhlIGR1bW15IFJ4L1R4IGJ1cnN0LCB3aGljaCByZXBvcnRzIDANCj4gcGFja2V0cy4N
Cj4gDQo+IEEgcG9sbC1tb2RlIHdvcmtlciBjaGVja2luZyBydGVfZXRoX3J4X3F1ZXVlX2NvdW50
KCkgYWNyb3NzIGENCj4gY29uY3VycmVudA0KPiBwb3J0IHN0b3AgdGhlbiBzZWVzIGFuIGVtcHR5
IHF1ZXVlIGluc3RlYWQgb2YgYSBuZWdhdGl2ZSBlcnJvci4NCj4gDQo+IEZpeGVzOiAwNjZmM2Q5
Y2MyMWMgKCJldGhkZXY6IHJlbW92ZSBjYWxsYmFjayBjaGVja3MgZnJvbSBmYXN0IHBhdGgiKQ0K
PiBDYzogc3RhYmxlQGRwZGsub3JnDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFN0ZXBoZW4gSGVtbWlu
Z2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogTWF4aW1l
IExlcm95IDxtYXhpbWVAbGVyb3lzLmZyPg0KPiAtLS0NCg0KQWNrZWQtYnk6IE1vcnRlbiBCcsO4
cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQoNCg==
