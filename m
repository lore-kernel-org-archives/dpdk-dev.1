Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1572C5B567
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 05:41:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73F61402B8;
	Wed, 12 Aug 2026 07:41:16 +0200 (CEST)
Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
 by mails.dpdk.org (Postfix) with ESMTP id 4C4EA40279
 for <dev@dpdk.org>; Wed, 12 Aug 2026 07:41:14 +0200 (CEST)
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4hKcmR1c19z1R3kL;
 Wed, 12 Aug 2026 13:41:11 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4hKcmN57T9zTZhW;
 Wed, 12 Aug 2026 13:41:08 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
 by maildlp1.hygon.cn (Postfix) with ESMTPS id 4DD3B91D7;
 Wed, 12 Aug 2026 13:41:02 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 12 Aug
 2026 13:41:08 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Wed, 12 Aug 2026 13:41:08 +0800
From: Liangxing Wang <wangliangxing@hygon.cn>
To: "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 "chenbox@nvidia.com" <chenbox@nvidia.com>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] net/vhost: support queue info query
Thread-Topic: [PATCH] net/vhost: support queue info query
Thread-Index: AQHdCSEDnHL9opyR602UyBgtrhFudbaaJtHw
Date: Wed, 12 Aug 2026 05:41:08 +0000
Message-ID: <82df644fbb164dff917617ac491c3c1a@hygon.cn>
References: <20260701061412.154739-1-wangliangxing@hygon.cn>
In-Reply-To: <20260701061412.154739-1-wangliangxing@hygon.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.19.25.231]
Content-Type: text/plain; charset="gb2312"
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

S2luZGx5IHBpbmcgZm9yIHJldmlldy4gVGhhbmtzLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IExpYW5neGluZyBXYW5nIDx3YW5nbGlhbmd4aW5nQGh5Z29uLmNuPg0K
PiBTZW50OiAyMDI2xOo31MIxyNUgMTQ6MTQNCj4gVG86IG1heGltZS5jb3F1ZWxpbkByZWRoYXQu
Y29tOyBjaGVuYm94QG52aWRpYS5jb20NCj4gQ2M6IGRldkBkcGRrLm9yZzsgTGlhbmd4aW5nIFdh
bmcgPHdhbmdsaWFuZ3hpbmdAaHlnb24uY24+DQo+IFN1YmplY3Q6IFtQQVRDSF0gbmV0L3Zob3N0
OiBzdXBwb3J0IHF1ZXVlIGluZm8gcXVlcnkNCj4gDQo+IEFkZCBSeCBhbmQgVHggcXVldWUgaW5m
byBjYWxsYmFja3MgdG8gcmVwb3J0IHRoZSB2aG9zdC11c2VyIHZyaW5nIHNpemUgYXMgdGhlDQo+
IHF1ZXVlIGRlc2NyaXB0b3IgbnVtYmVyLg0KPiANCj4gVGhlIHZob3N0LXVzZXIgUE1EIGRvZXMg
bm90IHVzZSB0aGUgZGVzY3JpcHRvciBjb3VudCBwYXNzZWQgYnkNCj4gcnRlX2V0aF9yeF9xdWV1
ZV9zZXR1cCgpIGFuZCBydGVfZXRoX3R4X3F1ZXVlX3NldHVwKCkuIFRoZSBhY3R1YWwgcXVldWUN
Cj4gZGVwdGggaXMgbmVnb3RpYXRlZCB3aXRoIHRoZSB2aXJ0aW8gZnJvbnRlbmQgYW5kIG1haW50
YWluZWQgYnkgdGhlIHZob3N0DQo+IGxpYnJhcnkuIFF1ZXJ5IHRoZSB2aG9zdCB2cmluZyBhbmQg
cmVwb3J0IGl0cyBzaXplIHRocm91Z2ggcnhxX2luZm9fZ2V0IGFuZA0KPiB0eHFfaW5mb19nZXQu
DQo+IA0KPiBXaXRoIHRoaXMgY2hhbmdlLCB0ZXN0cG1kIHVzaW5nIHZob3N0LXVzZXIgUE1EIGNh
biBkaXNwbGF5IHRoZSBjb3JyZWN0IFJ4IGFuZA0KPiBUeCBxdWV1ZSBkZXNjcmlwdG9yIG51bWJl
ciBpbiB0aGUgcG9ydCBzdGFydCBsb2cuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMaWFuZ3hpbmcg
V2FuZyA8d2FuZ2xpYW5neGluZ0BoeWdvbi5jbj4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC92aG9z
dC9ydGVfZXRoX3Zob3N0LmMgfCAzOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3Zob3N0L3J0ZV9ldGhfdmhvc3QuYw0KPiBiL2RyaXZlcnMvbmV0L3Zob3N0L3J0
ZV9ldGhfdmhvc3QuYw0KPiBpbmRleCAwNTk0MGYyNDYxLi5hZjAyM2M3NjM5IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL25ldC92aG9zdC9ydGVfZXRoX3Zob3N0LmMNCj4gKysrIGIvZHJpdmVycy9u
ZXQvdmhvc3QvcnRlX2V0aF92aG9zdC5jDQo+IEBAIC0xNDgwLDEyICsxNDgwLDUwIEBAIHZob3N0
X2Rldl9wcml2X2R1bXAoc3RydWN0IHJ0ZV9ldGhfZGV2ICpkZXYsDQo+IEZJTEUgKmYpDQo+ICAJ
cmV0dXJuIDA7DQo+ICB9DQo+IA0KPiArc3RhdGljIHZvaWQNCj4gK2V0aF9yeHFfaW5mb19nZXQo
c3RydWN0IHJ0ZV9ldGhfZGV2ICpkZXYsIHVpbnQxNl90IHJ4X3F1ZXVlX2lkLA0KPiArCQkgc3Ry
dWN0IHJ0ZV9ldGhfcnhxX2luZm8gKnFpbmZvKQ0KPiArew0KPiArCXN0cnVjdCBydGVfdmhvc3Rf
dnJpbmcgdnJpbmc7DQo+ICsJc3RydWN0IHZob3N0X3F1ZXVlICp2cSA9IGRldi0+ZGF0YS0+cnhf
cXVldWVzW3J4X3F1ZXVlX2lkXTsNCj4gKw0KPiArCXFpbmZvLT5uYl9kZXNjID0gMDsNCj4gKw0K
PiArCWlmICh2cSA9PSBOVUxMIHx8IHZxLT52aWQgPCAwKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4g
KwlpZiAocnRlX3Zob3N0X2dldF92aG9zdF92cmluZyh2cS0+dmlkLCB2cS0+dmlydHF1ZXVlX2lk
LCAmdnJpbmcpIDwgMCkNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJcWluZm8tPm5iX2Rlc2MgPSB2
cmluZy5zaXplOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZA0KPiArZXRoX3R4cV9pbmZvX2dl
dChzdHJ1Y3QgcnRlX2V0aF9kZXYgKmRldiwgdWludDE2X3QgdHhfcXVldWVfaWQsDQo+ICsJCSBz
dHJ1Y3QgcnRlX2V0aF90eHFfaW5mbyAqcWluZm8pDQo+ICt7DQo+ICsJc3RydWN0IHJ0ZV92aG9z
dF92cmluZyB2cmluZzsNCj4gKwlzdHJ1Y3Qgdmhvc3RfcXVldWUgKnZxID0gZGV2LT5kYXRhLT50
eF9xdWV1ZXNbdHhfcXVldWVfaWRdOw0KPiArDQo+ICsJcWluZm8tPm5iX2Rlc2MgPSAwOw0KPiAr
DQo+ICsJaWYgKHZxID09IE5VTEwgfHwgdnEtPnZpZCA8IDApDQo+ICsJCXJldHVybjsNCj4gKw0K
PiArCWlmIChydGVfdmhvc3RfZ2V0X3Zob3N0X3ZyaW5nKHZxLT52aWQsIHZxLT52aXJ0cXVldWVf
aWQsICZ2cmluZykgPCAwKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwlxaW5mby0+bmJfZGVzYyA9
IHZyaW5nLnNpemU7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZXRoX2Rldl9v
cHMgb3BzID0gew0KPiAgCS5kZXZfc3RhcnQgPSBldGhfZGV2X3N0YXJ0LA0KPiAgCS5kZXZfc3Rv
cCA9IGV0aF9kZXZfc3RvcCwNCj4gIAkuZGV2X2Nsb3NlID0gZXRoX2Rldl9jbG9zZSwNCj4gIAku
ZGV2X2NvbmZpZ3VyZSA9IGV0aF9kZXZfY29uZmlndXJlLA0KPiAgCS5kZXZfaW5mb3NfZ2V0ID0g
ZXRoX2Rldl9pbmZvLA0KPiArCS5yeHFfaW5mb19nZXQgPSBldGhfcnhxX2luZm9fZ2V0LA0KPiAr
CS50eHFfaW5mb19nZXQgPSBldGhfdHhxX2luZm9fZ2V0LA0KPiAgCS5yeF9xdWV1ZV9zZXR1cCA9
IGV0aF9yeF9xdWV1ZV9zZXR1cCwNCj4gIAkudHhfcXVldWVfc2V0dXAgPSBldGhfdHhfcXVldWVf
c2V0dXAsDQo+ICAJLnJ4X3F1ZXVlX3JlbGVhc2UgPSBldGhfcnhfcXVldWVfcmVsZWFzZSwNCj4g
LS0NCj4gMi40My4wDQoNCg==

