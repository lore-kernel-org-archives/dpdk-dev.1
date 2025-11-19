Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4272CF34A1
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 13:50:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B110D40270;
	Wed, 19 Nov 2025 14:50:34 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D9A8E40262
 for <dev@dpdk.org>; Wed, 19 Nov 2025 14:50:32 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A09C2214DC;
 Wed, 19 Nov 2025 14:50:32 +0100 (CET)
Content-class: urn:content-classes:message
Subject: RE: [PATCH] drivers/net: fix Tx packet prepare
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Wed, 19 Nov 2025 14:50:31 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65576@smartserver.smartshare.dk>
In-Reply-To: <3449306.jE0xQCEvom@thomas>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] drivers/net: fix Tx packet prepare
Thread-Index: AdxZWpUe13agfqWwSs6Z1BOCXc+uogAABswQ
References: <20251119130333.2697937-1-thomas@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F65575@smartserver.smartshare.dk>
 <3449306.jE0xQCEvom@thomas>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: <dev@dpdk.org>, "Jiawen Wu" <jiawenwu@trustnetic.com>,
 "Xingui Yang" <yangxingui@huawei.com>,
 "Chengwen Feng" <fengchengwen@huawei.com>,
 "Zaiyu Wang" <zaiyuwang@trustnetic.com>,
 "Christian Koue Muf" <ckm@napatech.com>,
 "Serhii Iliushyk" <sil-plv@napatech.com>,
 "Cristian Dumitrescu" <cristian.dumitrescu@intel.com>,
 "Jian Wang" <jianwang@trustnetic.com>,
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

PiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0bzp0aG9tYXNAbW9uamFsb24ubmV0XQ0KPiBT
ZW50OiBXZWRuZXNkYXksIDE5IE5vdmVtYmVyIDIwMjUgMTQuNDQNCj4gDQo+IDE5LzExLzIwMjUg
MTQ6MTksIE1vcnRlbiBCcsO4cnVwOg0KPiA+ID4gRnJvbTogVGhvbWFzIE1vbmphbG9uIFttYWls
dG86dGhvbWFzQG1vbmphbG9uLm5ldF0NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgMTkgTm92ZW1i
ZXIgMjAyNSAxNC4wNA0KPiA+ID4NCj4gPiA+IEFmdGVyIHJlbW92aW5nIGNhbGxiYWNrIGNoZWNr
cyBmcm9tIGV0aGRldiBmYXN0IHBhdGgsDQo+ID4gPiBzb21lIGRyaXZlcnMgY3Jhc2hlZCBiZWNh
dXNlIHR4X3BrdF9wcmVwYXJlIHdhcyBzZXQgdG8gTlVMTC4NCj4gPiA+DQo+ID4gPiBTb21lIGRy
aXZlcnMgKGhuczMsIG5nYmUsIHR4Z2JlKSBuZWVkIHRvIHVzZQ0KPiA+ID4gcnRlX2V0aF90eF9w
a3RfcHJlcGFyZV9kdW1teQ0KPiA+ID4gd2hlbiBjb25maWd1cmluZyBxdWV1ZXMuDQo+ID4gPiBP
dGhlciBkcml2ZXJzIChudG5pYywgc29mdG5pYykgZG9lcyBub3QgbmVlZCB0byBzZXQgdHhfcGt0
X3ByZXBhcmUNCj4gPiA+IGFzIGl0IHdhcyBzZXQgYnkgZXRoX2Rldl9zZXRfZHVtbXlfZm9wcygp
IGNhbGxlZCBieQ0KPiA+ID4gcnRlX2V0aF9kZXZfYWxsb2NhdGUoKS4NCj4gPiA+DQo+ID4gPiBC
dWd6aWxsYSBJRDogMTgzNA0KPiA+ID4gRml4ZXM6IDA2NmYzZDljYzIxYyAoImV0aGRldjogcmVt
b3ZlIGNhbGxiYWNrIGNoZWNrcyBmcm9tIGZhc3QNCj4gcGF0aCIpDQo+ID4gPg0KPiA+ID4gUmVw
b3J0ZWQtYnk6IEppYXdlbiBXdSA8amlhd2Vud3VAdHJ1c3RuZXRpYy5jb20+DQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBUaG9tYXMgTW9uamFsb24gPHRob21hc0Btb25qYWxvbi5uZXQ+DQo+ID4gPiAt
LS0NCj4gPg0KPiA+IFNlYXJjaGluZyBmb3IgInR4X3BrdF9wcmVwYXJlID0gTlVMTDsiIGZpbmRz
IGEgZmV3IG1vcmUsIGJ1dCB0aGV5IGFyZQ0KPiBhbGwgaW4gZHJpdmVyIGNsZWFudXAgZnVuY3Rp
b25zLCBzby4uLg0KPiA+IFJldmlld2VkLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFy
ZXN5c3RlbXMuY29tPg0KPiANCj4gWWVzIEkgYW0gd29ya2luZyBvbiB0aGUgY2xlYW51cCBzaWRl
Lg0KPiBCdXQgdGhlcmUgaXMgbm8gYnVnIGluIGNsZWFudXAsIGl0IHdpbGwgYmUgYSBjbGVhbnVw
IG9mIGNsZWFudXAgOykNCg0KQWdyZWUuDQpJIHNob3VsZCBoYXZlIGJlZW4gbW9yZSBjbGVhciBp
biBteSByZXZpZXcgY29tbWVudDoNClRoZSBvbmVzIEkgZm91bmQgaW4gZHJpdmVyIGNsZWFudXAg
ZnVuY3Rpb25zIGRvbid0IGNhdXNlIHByb2JsZW1zLCBzbyBJIGNvbnNpZGVyIHRoaXMgcGF0Y2gg
Y29tcGxldGUuDQoNCj4gU28gY2xlYW51cCB3aWxsIGJlIGhhbmRsZWQgYWZ0ZXIgMjUuMTEgcmVs
ZWFzZS4NCj4gDQoNCg==
