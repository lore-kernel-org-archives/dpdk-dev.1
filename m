Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF42CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 14:55:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BB14402D5;
	Fri, 31 Oct 2025 15:55:31 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 6A30540150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 15:55:30 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 3F610206E7;
 Fri, 31 Oct 2025 15:55:30 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH 1/1] move SPDX tag on the first line
Date: Fri, 31 Oct 2025 15:55:27 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65525@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20251031142018.49319-1-thomas@monjalon.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] move SPDX tag on the first line
Thread-Index: AdxKcZEB+YG9SR3dQgiwKMs11ET//AABLzaA
References: <20251031142018.49319-1-thomas@monjalon.net>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
	<dev@dpdk.org>
Cc: "Jerin Jacob" <jerinj@marvell.com>,
 "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 "Kiran Kumar K" <kirankumark@marvell.com>,
 "Sunil Kumar Kori" <skori@marvell.com>,
 "Satha Rao" <skoteshwar@marvell.com>, "Harman Kalra" <hkalra@marvell.com>,
 "Christian Koue Muf" <ckm@napatech.com>,
 "Serhii Iliushyk" <sil-plv@napatech.com>, "Rosen Xu" <rosen.xu@altera.com>,
 "David Christensen" <drc@linux.ibm.com>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Bibo Mao" <maobibo@loongson.cn>,
 =?UTF-8?B?U3RhbmlzxYJhdyBLYXJkYWNo?= <stanislaw.kardach@gmail.com>,
 "Sun Yuechi" <sunyuechi@iscas.ac.cn>, "Jiayu Hu" <hujiayu.hu@foxmail.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Cristian Dumitrescu" <cristian.dumitrescu@intel.com>
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
ZW50OiBGcmlkYXksIDMxIE9jdG9iZXIgMjAyNSAxNS4yMA0KPiANCj4gRnJvbSAiQ29udHJpYnV0
b3IncyBHdWlkZWxpbmVzIjoNCj4gIg0KPiBEUERLIHVzZXMgZmlyc3QgbGluZSBvZiB0aGUgZmls
ZSB0byBiZSBTUERYIHRhZy4NCj4gSW4gY2FzZSBvZiAjISBzY3JpcHRzLCBTUERYIHRhZyBjYW4g
YmUgcGxhY2VkIGluIDJuZCBsaW5lIG9mIHRoZSBmaWxlLg0KPiAiDQo+IA0KPiBTb21lIC5jIG9y
IC5oIGZpbGVzIGhhZCB0aGUgU1BEWCBpZGVudGlmaWVyIG9uIHRoZSBzZWNvbmQgbGluZQ0KPiBm
b3Igbm8gZ29vZCByZWFzb24sIHNvIGl0IGlzIG1vdmVkIHRvIHRoZSBmaXJzdCBsaW5lDQo+IHRv
IGNvbXBseSB3aXRoIHRoZSBndWlkZWxpbmVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGhvbWFz
IE1vbmphbG9uIDx0aG9tYXNAbW9uamFsb24ubmV0Pg0KPiAtLS0NCg0KQ2xlYW5pbmcgdXAgaXMg
YWx3YXlzIGdvb2QuDQpBY2tlZC1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0
ZW1zLmNvbT4NCg0K
