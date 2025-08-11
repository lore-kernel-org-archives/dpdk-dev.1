Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44927CA0EC0
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 09:03:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 510464025D;
	Mon, 11 Aug 2025 11:03:42 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 56A2F400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 11:03:41 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c0pXn64l1z6M57v;
 Mon, 11 Aug 2025 17:01:45 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
 by mail.maildlp.com (Postfix) with ESMTPS id 66145140278;
 Mon, 11 Aug 2025 17:03:40 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Aug 2025 11:03:40 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 11 Aug 2025 11:03:40 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>,
 "Thomas Monjalon" <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Ivan Malov <ivan.malov@arknetworks.am>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH v3 1/3] testpmd: Do not enable mbuf fast release TX
 offload by default
Thread-Topic: [PATCH v3 1/3] testpmd: Do not enable mbuf fast release TX
 offload by default
Thread-Index: AQHcBK7E9kdkWU/qLky+OG/tJw1BJbRdNAIg
Date: Mon, 11 Aug 2025 09:03:40 +0000
Message-ID: <96cde45006fa4c0a89bd3c517a4049db@huawei.com>
References: <20250731090731.671589-1-mb@smartsharesystems.com>
 <20250803194218.683318-1-mb@smartsharesystems.com>
In-Reply-To: <20250803194218.683318-1-mb@smartsharesystems.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.73]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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

DQo+IEVuYWJsaW5nIHNvbWUgb2ZmbG9hZCBieSBkZWZhdWx0IG1heSBjb25mbGljdCB3aXRoIGEg
bWFudWFsbHkgY29uZmlndXJlZA0KPiBvZmZsb2FkLg0KPiBTcGVjaWZpY2FsbHksIHRoZSBtYnVm
IGZhc3QgcmVsZWFzZSBUWCBvZmZsb2FkLCB3aGljaCBjb25mbGljdHMgd2l0aCBtdWx0aQ0KPiBz
ZWdtZW50IHBhY2tldCBUWCBvZmZsb2FkLCB3YXMgZW5hYmxlZCBieSBkZWZhdWx0Lg0KPiBUaGVy
ZWZvcmUsIG1idWYgZmFzdCByZWxlYXNlIFRYIG9mZmxvYWQgKHRoZSBvbmx5IFRYIG9mZmxvYWQg
d2hpY2ggd2FzDQo+IGVuYWJsZWQgYnkgZGVmYXVsdCkgaXMgbm90IGVuYWJsZWQgYnkgZGVmYXVs
dCBhbnltb3JlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0
c2hhcmVzeXN0ZW1zLmNvbT4NCj4gLS0tDQo+ICBhcHAvdGVzdC1wbWQvdGVzdHBtZC5jIHwgMTEg
Ky0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTAgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXBwL3Rlc3QtcG1kL3Rlc3RwbWQuYyBiL2FwcC90
ZXN0LXBtZC90ZXN0cG1kLmMNCj4gaW5kZXggYmI4ODU1NTMyOC4uZjAwZWFlMzk5MiAxMDA2NDQN
Cj4gLS0tIGEvYXBwL3Rlc3QtcG1kL3Rlc3RwbWQuYw0KPiArKysgYi9hcHAvdGVzdC1wbWQvdGVz
dHBtZC5jDQo+IEBAIC00OTAsOSArNDkwLDcgQEAgbGNvcmVpZF90IGxhdGVuY3lzdGF0c19sY29y
ZV9pZCA9IC0xOw0KPiAgICovDQo+ICBzdHJ1Y3QgcnRlX2V0aF9yeG1vZGUgcnhfbW9kZTsNCj4g
DQo+IC1zdHJ1Y3QgcnRlX2V0aF90eG1vZGUgdHhfbW9kZSA9IHsNCj4gLQkub2ZmbG9hZHMgPSBS
VEVfRVRIX1RYX09GRkxPQURfTUJVRl9GQVNUX0ZSRUUsDQo+IC19Ow0KPiArc3RydWN0IHJ0ZV9l
dGhfdHhtb2RlIHR4X21vZGU7DQo+IA0KPiAgdm9sYXRpbGUgaW50IHRlc3RfZG9uZSA9IDE7IC8q
IHN0b3AgcGFja2V0IGZvcndhcmRpbmcgd2hlbiBzZXQgdG8gMS4gKi8NCj4gDQo+IEBAIC0xNTky
LDEwICsxNTkwLDYgQEAgaW5pdF9jb25maWdfcG9ydF9vZmZsb2Fkcyhwb3J0aWRfdCBwaWQsIHVp
bnQzMl90IHNvY2tldF9pZCkNCj4gIAlpZiAocmV0ICE9IDApDQo+ICAJCXJ0ZV9leGl0KEVYSVRf
RkFJTFVSRSwgInJ0ZV9ldGhfZGV2X2luZm9fZ2V0KCkgZmFpbGVkXG4iKTsNCj4gDQo+IC0JaWYg
KCEocG9ydC0+ZGV2X2luZm8udHhfb2ZmbG9hZF9jYXBhICYgUlRFX0VUSF9UWF9PRkZMT0FEX01C
VUZfRkFTVF9GUkVFKSkNCj4gLQkJcG9ydC0+ZGV2X2NvbmYudHhtb2RlLm9mZmxvYWRzICY9DQo+
IC0JCQl+UlRFX0VUSF9UWF9PRkZMT0FEX01CVUZfRkFTVF9GUkVFOw0KPiAtDQo+ICAJLyogQXBw
bHkgUnggb2ZmbG9hZHMgY29uZmlndXJhdGlvbiAqLw0KPiAgCWZvciAoaSA9IDA7IGkgPCBwb3J0
LT5kZXZfaW5mby5tYXhfcnhfcXVldWVzOyBpKyspDQo+ICAJCXBvcnQtPnJ4cVtpXS5jb25mLm9m
ZmxvYWRzID0gcG9ydC0+ZGV2X2NvbmYucnhtb2RlLm9mZmxvYWRzOw0KPiBAQCAtMjg1Nyw5ICsy
ODUxLDYgQEAgdXBkYXRlX2JvbmRpbmdfcG9ydF9kZXZfY29uZihwb3J0aWRfdCBib25kX3BpZCkN
Cj4gIAkJcmV0dXJuOw0KPiAgCX0NCj4gDQo+IC0JaWYgKHBvcnQtPmRldl9pbmZvLnR4X29mZmxv
YWRfY2FwYSAmIFJURV9FVEhfVFhfT0ZGTE9BRF9NQlVGX0ZBU1RfRlJFRSkNCj4gLQkJcG9ydC0+
ZGV2X2NvbmYudHhtb2RlLm9mZmxvYWRzIHw9DQo+IC0JCQkJUlRFX0VUSF9UWF9PRkZMT0FEX01C
VUZfRkFTVF9GUkVFOw0KPiAgCS8qIEFwcGx5IFR4IG9mZmxvYWRzIGNvbmZpZ3VyYXRpb24gKi8N
Cj4gIAlmb3IgKGkgPSAwOyBpIDwgcG9ydC0+ZGV2X2luZm8ubWF4X3R4X3F1ZXVlczsgaSsrKQ0K
PiAgCQlwb3J0LT50eHFbaV0uY29uZi5vZmZsb2FkcyA9IHBvcnQtPmRldl9jb25mLnR4bW9kZS5v
ZmZsb2FkczsNCj4gLS0NCg0KQWNrZWQtYnk6IEtvbnN0YW50aW4gQW5hbnlldiA8a29uc3RhbnRp
bi5hbmFueWV2QGh1YXdlaS5jb20+DQogDQoNCj4gMi40My4wDQo+IA0KDQo=
