Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA0ACAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 06:16:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AD8840151;
	Tue, 30 Sep 2025 08:16:09 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id CF87440150;
 Tue, 30 Sep 2025 08:16:08 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 8D20A202E1;
 Tue, 30 Sep 2025 08:16:08 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [dpdk-dev v4 1/2] eal: Add mem equal and non-equal to prevent
 timing attacks memcmp.
Date: Tue, 30 Sep 2025 08:16:07 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65482@smartserver.smartshare.dk>
In-Reply-To: <20250929154838.2f0741f7@hermes.local>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [dpdk-dev v4 1/2] eal: Add mem equal and non-equal to prevent
 timing attacks memcmp.
Thread-Index: AdwxkzXjDZeyQ8K1SvKI9vXIq5jDkAAPjSGQ
References: <20250926160209.56496-1-kai.ji@intel.com><20250929145049.153078-1-kai.ji@intel.com><98CBD80474FA8B44BF855DF32C47DC35F65481@smartserver.smartshare.dk>
 <20250929154838.2f0741f7@hermes.local>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Kai Ji" <kai.ji@intel.com>
Cc: <dev@dpdk.org>, <gakhil@marvell.com>, <konstantin.ananyev@huawei.com>,
 <bruce.richardson@intel.com>, <thomas@monjalon.net>, <stable@dpdk.org>
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
b3JnXQ0KPiBTZW50OiBUdWVzZGF5LCAzMCBTZXB0ZW1iZXIgMjAyNSAwMC40OQ0KPiANCj4gT24g
TW9uLCAyOSBTZXAgMjAyNSAxOTo0ODoxOSArMDIwMA0KPiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21h
cnRzaGFyZXN5c3RlbXMuY29tPiB3cm90ZToNCj4gDQo+ID4gPiBGcm9tOiBLYWkgSmkgW21haWx0
bzprYWkuamlAaW50ZWwuY29tXQ0KPiA+ID4gU2VudDogTW9uZGF5LCAyOSBTZXB0ZW1iZXIgMjAy
NSAxNi41MQ0KPiA+ID4NCj4gPiA+IEJ1Z3ppbGxhIElEOiAxNzczDQo+ID4gPiBDYzogc3RhYmxl
QGRwZGsub3JnDQo+ID4gPg0KPiA+ID4gWzBdIGh0dHBzOi8vYnVncy5kcGRrLm9yZy9zaG93X2J1
Zy5jZ2k/aWQ9MTc3Mw0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEthaSBKaSA8a2FpLmpp
QGludGVsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+DQo+ID4gQWNrZWQtYnk6IE1vcnRlbiBCcsO4cnVw
IDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQo+ID4NCj4gPiBAU3RlcGhlbjogVjQgYWxzbyBp
bmNsdWRlcyBlcXVhbCwgd2hpY2ggeW91IHdhcyBhc2tpbmcgZm9yLg0KPiA+DQo+IA0KPiBUaGUg
cG9pbnQgaXMgdGhhdCB3ZSBzaG91bGQgb25seSBoYXZlIHRoZSBlcSB2YXJpYW50Lg0KPiBIYXZp
bmcgdGhlIG5vdCBlcXVhbCBpcyB1bm5lY2Vzc2FyeSBhZGRpdGlvbi4NCg0KWWVzLCBJIHdvdWxk
IHRlbmQgdG8gYWdyZWUgd2l0aCBTdGVwaGVuIG9uIHRoaXMuDQoNCg==
