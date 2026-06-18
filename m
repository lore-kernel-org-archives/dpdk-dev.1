Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32445CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 18:52:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AD54402B6;
	Thu, 18 Jun 2026 20:52:28 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E2C8E4028C
 for <dev@dpdk.org>; Thu, 18 Jun 2026 20:52:25 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id F0389201E4;
 Thu, 18 Jun 2026 20:52:24 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v1 0/5] prefix lcore role enum values
Date: Thu, 18 Jun 2026 20:52:21 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65926@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <SdThFrO9S62xAryFCraiCQ@monjalon.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v1 0/5] prefix lcore role enum values
Thread-Index: Adz/Pkc9p+WkU0LWQCWBo7RXS6NeVgAFAyFA
References: <20260617102834.2343356-1-lihuisong@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65917@smartserver.smartshare.dk>
 <SdThFrO9S62xAryFCraiCQ@monjalon.net>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
 "Huisong Li" <lihuisong@huawei.com>
Cc: <dev@dpdk.org>, <andrew.rybchenko@oktetlabs.ru>, <zhanjie9@hisilicon.com>,
 "David Marchand" <david.marchand@redhat.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>
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

PiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0bzp0aG9tYXNAbW9uamFsb24ubmV0XQ0KPiBT
ZW50OiBUaHVyc2RheSwgMTggSnVuZSAyMDI2IDE4LjIwDQo+IA0KPiAxNy8wNi8yMDI2IDEzOjQ4
LCBNb3J0ZW4gQnLDuHJ1cDoNCj4gPiA+IEZyb206IEh1aXNvbmcgTGkgW21haWx0bzpsaWh1aXNv
bmdAaHVhd2VpLmNvbV0NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgMTcgSnVuZSAyMDI2IDEyLjI4
DQo+ID4gPg0KPiA+ID4gQWRkIHRoZSBSVEVfTENPUkVfIHByZWZpeCB0byB0aGUgbGNvcmUgcm9s
ZSBlbnVtIHZhbHVlcyBpbg0KPiA+ID4gcnRlX2xjb3JlX3JvbGVfdA0KPiA+ID4gdG8gZm9sbG93
IERQREsgbmFtaW5nIGNvbnZlbnRpb25zLg0KPiA+ID4NCj4gPiA+IC0gUk9MRV9SVEUgICAgICAt
PiBSVEVfTENPUkVfUk9MRV9SVEUNCj4gPiA+IC0gUk9MRV9PRkYgICAgICAtPiBSVEVfTENPUkVf
Uk9MRV9PRkYNCj4gPiA+IC0gUk9MRV9TRVJWSUNFICAtPiBSVEVfTENPUkVfUk9MRV9TRVJWSUNF
DQo+ID4gPiAtIFJPTEVfTk9OX0VBTCAgLT4gUlRFX0xDT1JFX1JPTEVfTk9OX0VBTA0KPiA+ID4N
Cj4gPiA+IE9sZCBuYW1lcyBhcmUga2VwdCBhcyBtYWNyb3MgYWxpYXNpbmcgdG8gdGhlIG5ldyBu
YW1lcyB0byBwcmVzZXJ2ZQ0KPiA+ID4gYmFja3dhcmQgY29tcGF0aWJpbGl0eS4NCj4gPiA+DQo+
ID4NCj4gPiBTZXJpZXMtQWNrZWQtYnk6IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lz
dGVtcy5jb20+DQo+IA0KPiBTcXVhc2hlZCBhbmQgYXBwbGllZCwgdGhhbmtzLg0KPiANCj4gSSBo
YXZlIGEgZG91YnQgYWJvdXQgUlRFX0xDT1JFX1JPTEVfUlRFOiBjb3VsZCB3ZSBmaW5kIGEgYmV0
dGVyIG5hbWU/DQoNClllcywgaXQgbWFkZSBtb3JlIHNlbnNlIHdoZW4gbGNvcmVzIHdlcmUgZWl0
aGVyIHVzZWQgYnkgRFBESyBvciBub3QuDQpOb3RlIHRoYXQgaXQncyB1c2VkIGJ5IGJvdGggd29y
a2VycyBhbmQgdGhlIG1haW4gbGNvcmUuDQoNCj4gDQo+IEFsc28gd2Ugc2hvdWxkIHByb2JhYmx5
IGFkZCBzb21lIGNvbW1lbnRzIHRvIGV4cGxhaW4gZWFjaCByb2xlLg0KDQorMQ0KDQpCVFcsIEkg
dGhvdWdodCB0aGUgTm9uLUVBTCByb2xlIHdhcyBmb3IgcmVnaXN0ZXJlZCBjb250cm9sIHBsYW5l
IHRocmVhZHMuIEJ1dCB0aGVuIEkgbG9va2VkIGludG8gR3JvdXQuDQpHcm91dCB1c2VzIHRoZSBO
b24tRUFMIHJvbGUgZm9yIGl0cyBkYXRhcGxhbmUgdGhyZWFkcy4gQW5kIHRoZSBSVEUgcm9sZSBm
b3IgaXRzIG1haW4gdGhyZWFkLCB3aGljaCBpcyBoYW5kbGluZyB0aGUgY29udHJvbCBwbGFuZSAo
d2hpY2ggSSBzdXBwb3NlIGlzIG5vdCB1bnVzdWFsKS4NCg0KTGNvcmUgcm9sZXMgYW5kIENQVSBj
b3JlIGlzb2xhdGlvbiBpcyB2ZXJ5IGZsZXhpYmxlIGluIERQREsuIE1heWJlIHRvbyBmbGV4aWJs
ZS4NCg0K
