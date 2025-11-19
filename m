Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFED2CF2591
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 13:19:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BE5940265;
	Wed, 19 Nov 2025 14:19:49 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9B9D140262
 for <dev@dpdk.org>; Wed, 19 Nov 2025 14:19:47 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 79124214DC;
 Wed, 19 Nov 2025 14:19:46 +0100 (CET)
Content-class: urn:content-classes:message
Subject: RE: [PATCH] drivers/net: fix Tx packet prepare
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Wed, 19 Nov 2025 14:19:45 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65575@smartserver.smartshare.dk>
In-Reply-To: <20251119130333.2697937-1-thomas@monjalon.net>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] drivers/net: fix Tx packet prepare
Thread-Index: AdxZVPNCm8GRiPybSFSv6vY+qALXWAAAd9UA
References: <20251119130333.2697937-1-thomas@monjalon.net>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
	<dev@dpdk.org>
Cc: "Jiawen Wu" <jiawenwu@trustnetic.com>,
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
ZW50OiBXZWRuZXNkYXksIDE5IE5vdmVtYmVyIDIwMjUgMTQuMDQNCj4gDQo+IEFmdGVyIHJlbW92
aW5nIGNhbGxiYWNrIGNoZWNrcyBmcm9tIGV0aGRldiBmYXN0IHBhdGgsDQo+IHNvbWUgZHJpdmVy
cyBjcmFzaGVkIGJlY2F1c2UgdHhfcGt0X3ByZXBhcmUgd2FzIHNldCB0byBOVUxMLg0KPiANCj4g
U29tZSBkcml2ZXJzIChobnMzLCBuZ2JlLCB0eGdiZSkgbmVlZCB0byB1c2UNCj4gcnRlX2V0aF90
eF9wa3RfcHJlcGFyZV9kdW1teQ0KPiB3aGVuIGNvbmZpZ3VyaW5nIHF1ZXVlcy4NCj4gT3RoZXIg
ZHJpdmVycyAobnRuaWMsIHNvZnRuaWMpIGRvZXMgbm90IG5lZWQgdG8gc2V0IHR4X3BrdF9wcmVw
YXJlDQo+IGFzIGl0IHdhcyBzZXQgYnkgZXRoX2Rldl9zZXRfZHVtbXlfZm9wcygpIGNhbGxlZCBi
eQ0KPiBydGVfZXRoX2Rldl9hbGxvY2F0ZSgpLg0KPiANCj4gQnVnemlsbGEgSUQ6IDE4MzQNCj4g
Rml4ZXM6IDA2NmYzZDljYzIxYyAoImV0aGRldjogcmVtb3ZlIGNhbGxiYWNrIGNoZWNrcyBmcm9t
IGZhc3QgcGF0aCIpDQo+IA0KPiBSZXBvcnRlZC1ieTogSmlhd2VuIFd1IDxqaWF3ZW53dUB0cnVz
dG5ldGljLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIE1vbmphbG9uIDx0aG9tYXNAbW9u
amFsb24ubmV0Pg0KPiAtLS0NCg0KU2VhcmNoaW5nIGZvciAidHhfcGt0X3ByZXBhcmUgPSBOVUxM
OyIgZmluZHMgYSBmZXcgbW9yZSwgYnV0IHRoZXkgYXJlIGFsbCBpbiBkcml2ZXIgY2xlYW51cCBm
dW5jdGlvbnMsIHNvLi4uDQpSZXZpZXdlZC1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hh
cmVzeXN0ZW1zLmNvbT4NCg0K
