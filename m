Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2761039895
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 21:24:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 039C74060F;
	Fri, 27 Feb 2026 22:24:19 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 44A60402C6;
 Fri, 27 Feb 2026 22:24:17 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 57A3C20698;
 Fri, 27 Feb 2026 22:24:15 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v2] mempool: introduce statistics reset function
Date: Fri, 27 Feb 2026 22:24:00 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65757@smartserver.smartshare.dk>
In-Reply-To: <78c276d7-6d80-408c-a1f2-a92f1a89a9ea@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2] mempool: introduce statistics reset function
Thread-Index: AdynyklBcW6CeMZbTBSepP1n6YXu2AAY8RQA
References: <20260223102054.336350-1-mb@smartsharesystems.com>
 <20260224092802.359592-1-mb@smartsharesystems.com>
 <78c276d7-6d80-408c-a1f2-a92f1a89a9ea@huawei.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "fengchengwen" <fengchengwen@huawei.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>
Cc: <techboard@dpdk.org>
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

PiBGcm9tOiBmZW5nY2hlbmd3ZW4gW21haWx0bzpmZW5nY2hlbmd3ZW5AaHVhd2VpLmNvbV0NCj4g
U2VudDogRnJpZGF5LCAyNyBGZWJydWFyeSAyMDI2IDEwLjIwDQo+IA0KPiBBY2tlZC1ieTogQ2hl
bmd3ZW4gRmVuZyA8ZmVuZ2NoZW5nd2VuQGh1YXdlaS5jb20+DQo+IA0KPiBBbm90aGVyIHF1ZXN0
aW9uOg0KPiAgICBIb3cgYWJvdXQgdGhlIG92ZXJsb2FkIG9mIG1lbXBvb2wgc3RhdHMsIElmIHRo
ZSBjb3N0IGlzIGxvdywgY2FuIHdlDQo+ICAgIHJlbW92ZSB0aGUgZGVidWcgbWFjcm8/IEFzIGZh
ciBhcyBJIGtub3csIHNvbWUgRFBESyBhcHBsaWNhdGlvbnMNCj4gZW5hYmxlDQo+ICAgIG1lbXBv
b2wgc3RhdGlzdGljcyAobWF5YmUgc2VsZi1pbXBsKSBpbiB0aGUgcHJvZHVjdGlvbiBlbnZpcm9u
bWVudCwNCj4gICAgd2hpY2ggaXMgbWFpbmx5IHVzZWQgdG8gaGVscCBsb2NhdGUgcHJvYmxlbXMu
DQoNCk1lbXBvb2wgaXMgYSBjb3JlIGxpYnJhcnksIHNvIGV2ZW4gdGhvdWdoIHRoZSBvdmVyaGVh
ZCBvZiB0aGUgbWVtcG9vbCBzdGF0aXN0aWNzIGlzIHJlbGF0aXZlbHkgbG93IGNvc3QsIGl0IGlz
IGEgZGVidWctb25seSBmYWNpbGl0eSwgYW5kIHRoZSBleHRyYSBvdmVyaGVhZCBzaG91bGQgYmUg
bm90IGJlIGZvcmNlZCB1cG9uIHVzZXJzLg0KSU1PLCB3ZSBzaG91bGQga2VlcCBpdCBidWlsZCB0
aW1lIGNvbmZpZ3VyYWJsZS4NCg0KWW91IGRvIHJhaXNlIGEgZ29vZCBwb2ludCBhYm91dCB0aGUg
YmFsYW5jZSB0cmFkZW9mZiENCk1heWJlIGVuYWJsaW5nIGl0IGZvciBwcm9kdWN0aW9uIGlzIHdv
cnRoIGl0IGZvciB0aGUgbWFqb3JpdHkgb2YgdXNlcnMuIEluIFNtYXJ0U2hhcmUgU3lzdGVtcywg
d2UgZW5hYmxlIGl0IGZvciBwcm9kdWN0aW9uIHRvby4gDQoNCldlIHNob3VsZCBkaXNjdXNzIGNo
YW5naW5nIHRoZSBkZWZhdWx0IGZyb20gZGlzYWJsZWQgdG8gZW5hYmxlZC4NCg0K
