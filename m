Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08321CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 01:43:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12B7E40292;
	Thu, 21 Aug 2025 03:43:39 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D29E74026C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 03:43:37 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 9E16720F9E;
 Thu, 21 Aug 2025 03:43:37 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [PATCH] hash: replace zero length array
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Thu, 21 Aug 2025 03:43:36 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE59@smartserver.smartshare.dk>
In-Reply-To: <0b845c31-7c76-4cc4-b1e6-a1912be7898b@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] hash: replace zero length array
Thread-Index: AdwSNIo/YKK1ErMSSAy4eyp9myUeFgACF7zg
X-MimeOLE: Produced By Microsoft Exchange V6.5
References: <20250820211901.21986-1-stephen@networkplumber.org>
 <0b845c31-7c76-4cc4-b1e6-a1912be7898b@huawei.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Yipeng Wang" <yipeng1.wang@intel.com>,
 "Sameh Gobriel" <sameh.gobriel@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>,
 "fengchengwen" <fengchengwen@huawei.com>
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
U2VudDogVGh1cnNkYXksIDIxIEF1Z3VzdCAyMDI1IDAyLjQzDQo+IA0KPiBBY2tlZC1ieTogQ2hl
bmd3ZW4gRmVuZyA8ZmVuZ2NoZW5nd2VuQGh1YXdlaS5jb20+DQo+IA0KPiBPbiA4LzIxLzIwMjUg
NToxOSBBTSwgU3RlcGhlbiBIZW1taW5nZXIgd3JvdGU6DQo+ID4gWmVyby1sZW5ndGggYXJyYXlz
IGFyZSBhIEdOVSBDIGV4dGVuc2lvbiBhbmQgaW5zdGVhZCB1c2UgdGhlIElTTyBDOTkNCj4gPiBm
bGV4aWJsZSBhcnJheSBtZW1iZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVwaGVuIEhl
bW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+ID4gLS0tDQo+ID4gIGxpYi9o
YXNoL3J0ZV9jdWNrb29faGFzaC5oIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9saWIvaGFzaC9y
dGVfY3Vja29vX2hhc2guaCBiL2xpYi9oYXNoL3J0ZV9jdWNrb29faGFzaC5oDQo+ID4gaW5kZXgg
MjZhOTkyNDE5YS4uY2Y1Y2QyOTE0NCAxMDA2NDQNCj4gPiAtLS0gYS9saWIvaGFzaC9ydGVfY3Vj
a29vX2hhc2guaA0KPiA+ICsrKyBiL2xpYi9oYXNoL3J0ZV9jdWNrb29faGFzaC5oDQo+ID4gQEAg
LTEzMSw3ICsxMzEsNyBAQCBzdHJ1Y3QgcnRlX2hhc2hfa2V5IHsNCj4gPiAgCQlSVEVfQVRPTUlD
KHZvaWQgKikgcGRhdGE7DQo+ID4gIAl9Ow0KPiA+ICAJLyogVmFyaWFibGUga2V5IHNpemUgKi8N
Cj4gPiAtCWNoYXIga2V5WzBdOw0KPiA+ICsJY2hhciBrZXlbXTsNCj4gPiAgfTsNCj4gPg0KPiA+
ICAvKiogQnVja2V0IHN0cnVjdHVyZSAqLw0KDQpBY2tlZC1ieTogTW9ydGVuIEJyw7hydXAgPG1i
QHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCg0K
