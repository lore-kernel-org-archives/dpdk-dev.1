Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C69FCD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 16:01:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D26A4326E;
	Thu, 11 Jun 2026 18:01:15 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9797240677;
 Thu, 11 Jun 2026 18:01:14 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 74C13205C8;
 Thu, 11 Jun 2026 18:01:14 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH 8/9] ethdev: keep fast-path ops valid after port stop
Date: Thu, 11 Jun 2026 18:01:11 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65909@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260611154926.392670-9-maxime@leroys.fr>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 8/9] ethdev: keep fast-path ops valid after port stop
Thread-Index: Adz5ugeigPhQxIBKSGSGbY1/AXGFIgAAPTBw
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260611154926.392670-9-maxime@leroys.fr>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Maxime Leroy" <maxime@leroys.fr>, <hemant.agrawal@nxp.com>,
 <sachin.saxena@nxp.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, "Thomas Monjalon" <thomas@monjalon.net>,
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
QmVoYWxmIE9mIE1heGltZQ0KPiBMZXJveQ0KPiBTZW50OiBUaHVyc2RheSwgMTEgSnVuZSAyMDI2
IDE3LjQ5DQo+IA0KPiBldGhfZGV2X2ZwX29wc19yZXNldCgpIHJlc3RvcmVzIGEgcG9ydCdzIGZh
c3QtcGF0aCBvcHMgb24gc3RvcC9yZWxlYXNlDQo+IHZpYSBhIGNvbXBvdW5kIGxpdGVyYWwsIHNv
IGV2ZXJ5IGZpZWxkIGl0IG9taXRzIGlzIHplcm9lZCB0byBOVUxMLiBJdA0KPiBzZXRzIG9ubHkg
cnhfcGt0X2J1cnN0L3R4X3BrdF9idXJzdCAoYW5kIHRoZSByeHEvdHhxIGRhdGEpLCBsZWF2aW5n
DQo+IHJ4X3F1ZXVlX2NvdW50LCB0eF9xdWV1ZV9jb3VudCwgcngvdHhfZGVzY3JpcHRvcl9zdGF0
dXMsIHR4X3BrdF9wcmVwYXJlDQo+IGFuZCB0aGUgcmVjeWNsZSBjYWxsYmFja3MgTlVMTC4NCj4g
DQo+IEluIG5vbi1kZWJ1ZyBidWlsZHMgdGhlc2Ugb3BzIGFyZSByZWFjaGVkIHRocm91Z2ggYW4g
dW5ndWFyZGVkIGluZGlyZWN0DQo+IGNhbGwgKHRoZSBOVUxMIGNoZWNrIGV4aXN0cyBvbmx5IHVu
ZGVyIFJURV9FVEhERVZfREVCVUdfUlgvVFgpLiBTbyBhDQo+IHRocmVhZCBjYWxsaW5nIGUuZy4g
cnRlX2V0aF9yeF9xdWV1ZV9jb3VudCgpIG9uIGEgcG9ydCBiZWluZyBzdG9wcGVkDQo+IGRlcmVm
ZXJlbmNlcyBOVUxMIGFuZCBjcmFzaGVzLCB3aGlsZSB0aGUgc2FtZSByYWNlIG9uDQo+IHJ0ZV9l
dGhfcnhfYnVyc3QoKQ0KPiBpcyBoYXJtbGVzcyBiZWNhdXNlIHRoZSBidXJzdCBvcHMgYXJlIHJl
c2V0IHRvIGR1bW1pZXMuIEEgcG9sbC1tb2RlDQo+IHdvcmtlciByZS1jaGVja2luZyByeF9xdWV1
ZV9jb3VudCBiZWZvcmUgYXJtaW5nIHRoZSBSeCBpbnRlcnJ1cHQgYW5kDQo+IHNsZWVwaW5nIGhp
dHMgZXhhY3RseSB0aGlzLg0KPiANCj4gUmVzZXQgdGhlc2Ugb3BzIHRvIHRoZSBzYW1lIGR1bW1p
ZXMgZXRoX2Rldl9zZXRfZHVtbXlfZm9wcygpIGluc3RhbGxzLA0KPiBzbyBhIHN0b3BwZWQgcG9y
dCBiZWhhdmVzIGxpa2UgYSBmcmVzaGx5IGFsbG9jYXRlZCBvbmU6IGV2ZXJ5IGZhc3QtcGF0aA0K
PiBvcCBpcyBhIHNhZmUgbm8tb3AsIG5vbmUgaXMgTlVMTC4NCj4gDQo+IEZpeGVzOiAwNjZmM2Q5
Y2MyMWMgKCJldGhkZXY6IHJlbW92ZSBjYWxsYmFjayBjaGVja3MgZnJvbSBmYXN0IHBhdGgiKQ0K
PiBDYzogc3RhYmxlQGRwZGsub3JnDQo+IFNpZ25lZC1vZmYtYnk6IE1heGltZSBMZXJveSA8bWF4
aW1lQGxlcm95cy5mcj4NCj4gLS0tDQoNCkdvb2QgY2F0Y2guDQpBY2tlZC1ieTogTW9ydGVuIEJy
w7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCg0KTm90IHJlbGF0ZWQgdG8gdGhlIHNl
cmllcywgY29uc2lkZXIgc2VuZGluZyBhcyBzZXBhcmF0ZSBwYXRjaC4NCg0K
