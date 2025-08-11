Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41B4C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 08:17:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 218A04025D;
	Mon, 11 Aug 2025 10:17:21 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1B58C400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 10:17:19 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B083C20752;
 Mon, 11 Aug 2025 10:17:18 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v3 1/3] testpmd: Do not enable mbuf fast release TX
 offload by default
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 11 Aug 2025 10:17:17 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE1E@smartserver.smartshare.dk>
In-Reply-To: <20250803194218.683318-1-mb@smartsharesystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 1/3] testpmd: Do not enable mbuf fast release TX
 offload by default
Thread-Index: AdwErr2limiPBW4ITMOhDTwxiMxnzwF5/hgg
References: <20250731090731.671589-1-mb@smartsharesystems.com>
 <20250803194218.683318-1-mb@smartsharesystems.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Chengwen Feng" <fengchengwen@huawei.com>,
 "Ivan Malov" <ivan.malov@arknetworks.am>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>, "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Aman Singh" <aman.deep.singh@intel.com>,
 "Thomas Monjalon" <thomas@monjalon.net>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Gao, DaxueX" <daxuex.gao@intel.com>,
 "Raslan Darawsheh" <rasland@nvidia.com>,
 "Aaron Conole" <aconole@redhat.com>
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

SGkgZm9sa3MsDQoNClNvbWUgb2YgeW91IGNvbW1lbnRlZCBvbiB0aGlzIHBhdGNoLg0KUGxlYXNl
IGZvcm1hbGx5IHRhZyB3aXRoIEFDS0VELUJZIG9yIFJFVklFV0VELUJZLCBzbyBpdCBjYW4gYmUg
bWVyZ2VkLg0KDQpQYXRjaCAzLzMgaW4gdGhlIHNlcmllcyBoYXMgYmVlbiBtZXJnZWQsIGFuZCBp
cyBjYXVzaW5nIHRoZSAidGVzdF90eG9mZmxvYWRfcG9ydF9tdWx0aV9zZWdzIiB0ZXN0IHRvIGZh
aWwuIEkgZXhwZWN0IHRoaXMgcGF0Y2ggMS8zIHRvIGZpeCAob3IgcGFydGlhbGx5IGZpeCkgdGhh
dC4NCg0KTWVkIHZlbmxpZyBoaWxzZW4gLyBLaW5kIHJlZ2FyZHMsDQotTW9ydGVuIEJyw7hydXAN
Cg0KDQo+IEZyb206IE1vcnRlbiBCcsO4cnVwIFttYWlsdG86bWJAc21hcnRzaGFyZXN5c3RlbXMu
Y29tXQ0KPiBTZW50OiBTdW5kYXksIDMgQXVndXN0IDIwMjUgMjEuNDINCj4gDQo+IEVuYWJsaW5n
IHNvbWUgb2ZmbG9hZCBieSBkZWZhdWx0IG1heSBjb25mbGljdCB3aXRoIGEgbWFudWFsbHkgY29u
ZmlndXJlZA0KPiBvZmZsb2FkLg0KPiBTcGVjaWZpY2FsbHksIHRoZSBtYnVmIGZhc3QgcmVsZWFz
ZSBUWCBvZmZsb2FkLCB3aGljaCBjb25mbGljdHMgd2l0aCBtdWx0aQ0KPiBzZWdtZW50IHBhY2tl
dCBUWCBvZmZsb2FkLCB3YXMgZW5hYmxlZCBieSBkZWZhdWx0Lg0KPiBUaGVyZWZvcmUsIG1idWYg
ZmFzdCByZWxlYXNlIFRYIG9mZmxvYWQgKHRoZSBvbmx5IFRYIG9mZmxvYWQgd2hpY2ggd2FzDQo+
IGVuYWJsZWQgYnkgZGVmYXVsdCkgaXMgbm90IGVuYWJsZWQgYnkgZGVmYXVsdCBhbnltb3JlLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1z
LmNvbT4NCj4gLS0tDQo+ICBhcHAvdGVzdC1wbWQvdGVzdHBtZC5jIHwgMTEgKy0tLS0tLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXBwL3Rlc3QtcG1kL3Rlc3RwbWQuYyBiL2FwcC90ZXN0LXBtZC90ZXN0
cG1kLmMNCj4gaW5kZXggYmI4ODU1NTMyOC4uZjAwZWFlMzk5MiAxMDA2NDQNCj4gLS0tIGEvYXBw
L3Rlc3QtcG1kL3Rlc3RwbWQuYw0KPiArKysgYi9hcHAvdGVzdC1wbWQvdGVzdHBtZC5jDQo+IEBA
IC00OTAsOSArNDkwLDcgQEAgbGNvcmVpZF90IGxhdGVuY3lzdGF0c19sY29yZV9pZCA9IC0xOw0K
PiAgICovDQo+ICBzdHJ1Y3QgcnRlX2V0aF9yeG1vZGUgcnhfbW9kZTsNCj4gDQo+IC1zdHJ1Y3Qg
cnRlX2V0aF90eG1vZGUgdHhfbW9kZSA9IHsNCj4gLQkub2ZmbG9hZHMgPSBSVEVfRVRIX1RYX09G
RkxPQURfTUJVRl9GQVNUX0ZSRUUsDQo+IC19Ow0KPiArc3RydWN0IHJ0ZV9ldGhfdHhtb2RlIHR4
X21vZGU7DQo+IA0KPiAgdm9sYXRpbGUgaW50IHRlc3RfZG9uZSA9IDE7IC8qIHN0b3AgcGFja2V0
IGZvcndhcmRpbmcgd2hlbiBzZXQgdG8gMS4gKi8NCj4gDQo+IEBAIC0xNTkyLDEwICsxNTkwLDYg
QEAgaW5pdF9jb25maWdfcG9ydF9vZmZsb2Fkcyhwb3J0aWRfdCBwaWQsIHVpbnQzMl90DQo+IHNv
Y2tldF9pZCkNCj4gIAlpZiAocmV0ICE9IDApDQo+ICAJCXJ0ZV9leGl0KEVYSVRfRkFJTFVSRSwg
InJ0ZV9ldGhfZGV2X2luZm9fZ2V0KCkgZmFpbGVkXG4iKTsNCj4gDQo+IC0JaWYgKCEocG9ydC0+
ZGV2X2luZm8udHhfb2ZmbG9hZF9jYXBhICYNCj4gUlRFX0VUSF9UWF9PRkZMT0FEX01CVUZfRkFT
VF9GUkVFKSkNCj4gLQkJcG9ydC0+ZGV2X2NvbmYudHhtb2RlLm9mZmxvYWRzICY9DQo+IC0JCQl+
UlRFX0VUSF9UWF9PRkZMT0FEX01CVUZfRkFTVF9GUkVFOw0KPiAtDQo+ICAJLyogQXBwbHkgUngg
b2ZmbG9hZHMgY29uZmlndXJhdGlvbiAqLw0KPiAgCWZvciAoaSA9IDA7IGkgPCBwb3J0LT5kZXZf
aW5mby5tYXhfcnhfcXVldWVzOyBpKyspDQo+ICAJCXBvcnQtPnJ4cVtpXS5jb25mLm9mZmxvYWRz
ID0gcG9ydC0+ZGV2X2NvbmYucnhtb2RlLm9mZmxvYWRzOw0KPiBAQCAtMjg1Nyw5ICsyODUxLDYg
QEAgdXBkYXRlX2JvbmRpbmdfcG9ydF9kZXZfY29uZihwb3J0aWRfdCBib25kX3BpZCkNCj4gIAkJ
cmV0dXJuOw0KPiAgCX0NCj4gDQo+IC0JaWYgKHBvcnQtPmRldl9pbmZvLnR4X29mZmxvYWRfY2Fw
YSAmIFJURV9FVEhfVFhfT0ZGTE9BRF9NQlVGX0ZBU1RfRlJFRSkNCj4gLQkJcG9ydC0+ZGV2X2Nv
bmYudHhtb2RlLm9mZmxvYWRzIHw9DQo+IC0JCQkJUlRFX0VUSF9UWF9PRkZMT0FEX01CVUZfRkFT
VF9GUkVFOw0KPiAgCS8qIEFwcGx5IFR4IG9mZmxvYWRzIGNvbmZpZ3VyYXRpb24gKi8NCj4gIAlm
b3IgKGkgPSAwOyBpIDwgcG9ydC0+ZGV2X2luZm8ubWF4X3R4X3F1ZXVlczsgaSsrKQ0KPiAgCQlw
b3J0LT50eHFbaV0uY29uZi5vZmZsb2FkcyA9IHBvcnQtPmRldl9jb25mLnR4bW9kZS5vZmZsb2Fk
czsNCj4gLS0NCj4gMi40My4wDQoNCg==
