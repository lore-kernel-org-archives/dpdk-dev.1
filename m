Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE301C02199
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 14:31:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B86142DC1;
	Fri,  7 Feb 2025 15:31:07 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id EE640410E3;
 Fri,  7 Feb 2025 15:31:05 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqGb0263zz6HJZN;
 Fri,  7 Feb 2025 22:30:04 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id 96C881401F4;
 Fri,  7 Feb 2025 22:31:05 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Feb 2025 15:31:05 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 7 Feb 2025 15:31:05 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Ariel Otilibili <ariel.otilibili@6wind.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Thomas Monjalon
 <thomas@monjalon.net>, David Marchand <david.marchand@redhat.com>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>, =?utf-8?B?TW9ydGVuIEJyw7hydXA=?=
 <mb@smartsharesystems.com>
Subject: RE: [PATCH v2 2/2] mempool: make rte_mempool_create_empty a
 single-exit
Thread-Topic: [PATCH v2 2/2] mempool: make rte_mempool_create_empty a
 single-exit
Thread-Index: AQHbazX6X1GWG4vZvk+jeE9aITm/8rM8AzNQ
Date: Fri, 7 Feb 2025 14:31:05 +0000
Message-ID: <f0371b52754c44c789fa8b1250bfc023@huawei.com>
References: <20250119174643.2162110-1-ariel.otilibili@6wind.com>
 <20250120122156.2480524-1-ariel.otilibili@6wind.com>
 <20250120122156.2480524-3-ariel.otilibili@6wind.com>
In-Reply-To: <20250120122156.2480524-3-ariel.otilibili@6wind.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.146.145]
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

DQoNCj4gRm9yIHByb3Blcmx5IHNldHRpbmcgcnRlX2Vycm5vLCBhbmQgZXhpdGluZyBydGVfbWVt
cG9vbF9jcmVhdGVfZW1wdHkoKQ0KPiBmcm9tIGEgc2luZ2xlIHBsYWNlLg0KPiANCj4gQnVnemls
bGEgSUQ6IDE1NTkNCj4gU2lnbmVkLW9mZi1ieTogQXJpZWwgT3RpbGliaWxpIDxhcmllbC5vdGls
aWJpbGlANndpbmQuY29tPg0KPiAtLS0NCj4gIGxpYi9tZW1wb29sL3J0ZV9tZW1wb29sLmMgfCAy
NyArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNl
cnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9saWIvbWVtcG9v
bC9ydGVfbWVtcG9vbC5jIGIvbGliL21lbXBvb2wvcnRlX21lbXBvb2wuYw0KPiBpbmRleCAxZTRm
MjQ3ODNjMGIuLjNmOWE0YTE3NzFkMyAxMDA2NDQNCj4gLS0tIGEvbGliL21lbXBvb2wvcnRlX21l
bXBvb2wuYw0KPiArKysgYi9saWIvbWVtcG9vbC9ydGVfbWVtcG9vbC5jDQo+IEBAIC04MzEsMjAg
KzgzMSwyMCBAQCBydGVfbWVtcG9vbF9jcmVhdGVfZW1wdHkoY29uc3QgY2hhciAqbmFtZSwgdW5z
aWduZWQgbiwgdW5zaWduZWQgZWx0X3NpemUsDQo+ICAJLyogYXNrZWQgZm9yIHplcm8gaXRlbXMg
Ki8NCj4gIAlpZiAobiA9PSAwKSB7DQo+ICAJCXJ0ZV9lcnJubyA9IEVJTlZBTDsNCj4gLQkJcmV0
dXJuIE5VTEw7DQo+ICsJCWdvdG8gZXhpdDsNCj4gIAl9DQo+IA0KPiAgCS8qIGFza2VkIGNhY2hl
IHRvbyBiaWcgKi8NCj4gIAlpZiAoY2FjaGVfc2l6ZSA+IFJURV9NRU1QT09MX0NBQ0hFX01BWF9T
SVpFIHx8DQo+ICAJICAgIENBTENfQ0FDSEVfRkxVU0hUSFJFU0goY2FjaGVfc2l6ZSkgPiBuKSB7
DQo+ICAJCXJ0ZV9lcnJubyA9IEVJTlZBTDsNCj4gLQkJcmV0dXJuIE5VTEw7DQo+ICsJCWdvdG8g
ZXhpdDsNCj4gIAl9DQo+IA0KPiAgCS8qIGVuZm9yY2Ugb25seSB1c2VyIGZsYWdzIGFyZSBwYXNz
ZWQgYnkgdGhlIGFwcGxpY2F0aW9uICovDQo+ICAJaWYgKChmbGFncyAmIH5SVEVfTUVNUE9PTF9W
QUxJRF9VU0VSX0ZMQUdTKSAhPSAwKSB7DQo+ICAJCXJ0ZV9lcnJubyA9IEVJTlZBTDsNCj4gLQkJ
cmV0dXJuIE5VTEw7DQo+ICsJCWdvdG8gZXhpdDsNCj4gIAl9DQo+IA0KPiAgCS8qDQo+IEBAIC04
NjAsNyArODYwLDcgQEAgcnRlX21lbXBvb2xfY3JlYXRlX2VtcHR5KGNvbnN0IGNoYXIgKm5hbWUs
IHVuc2lnbmVkIG4sIHVuc2lnbmVkIGVsdF9zaXplLA0KPiAgCS8qIGNhbGN1bGF0ZSBtZW1wb29s
IG9iamVjdCBzaXplcy4gKi8NCj4gIAlpZiAoIXJ0ZV9tZW1wb29sX2NhbGNfb2JqX3NpemUoZWx0
X3NpemUsIGZsYWdzLCAmb2Jqc3opKSB7DQo+ICAJCXJ0ZV9lcnJubyA9IEVJTlZBTDsNCj4gLQkJ
cmV0dXJuIE5VTEw7DQo+ICsJCWdvdG8gZXhpdDsNCj4gIAl9DQo+IA0KPiAgCXJ0ZV9tY2ZnX21l
bXBvb2xfd3JpdGVfbG9jaygpOw0KPiBAQCAtODc3LDcgKzg3Nyw3IEBAIHJ0ZV9tZW1wb29sX2Ny
ZWF0ZV9lbXB0eShjb25zdCBjaGFyICpuYW1lLCB1bnNpZ25lZCBuLCB1bnNpZ25lZCBlbHRfc2l6
ZSwNCj4gIAl0ZSA9IHJ0ZV96bWFsbG9jKCJNRU1QT09MX1RBSUxRX0VOVFJZIiwgc2l6ZW9mKCp0
ZSksIDApOw0KPiAgCWlmICh0ZSA9PSBOVUxMKSB7DQo+ICAJCVJURV9NRU1QT09MX0xPRyhFUlIs
ICJDYW5ub3QgYWxsb2NhdGUgdGFpbHEgZW50cnkhIik7DQo+IC0JCWdvdG8gZXhpdF91bmxvY2s7
DQo+ICsJCWdvdG8gdW5sb2NrOw0KPiAgCX0NCj4gDQo+ICAJbWVtcG9vbF9zaXplID0gUlRFX01F
TVBPT0xfSEVBREVSX1NJWkUobXAsIGNhY2hlX3NpemUpOw0KPiBAQCAtODg3LDEyICs4ODcsMTIg
QEAgcnRlX21lbXBvb2xfY3JlYXRlX2VtcHR5KGNvbnN0IGNoYXIgKm5hbWUsIHVuc2lnbmVkIG4s
IHVuc2lnbmVkIGVsdF9zaXplLA0KPiAgCXJldCA9IHNucHJpbnRmKG16X25hbWUsIHNpemVvZiht
el9uYW1lKSwgUlRFX01FTVBPT0xfTVpfRk9STUFULCBuYW1lKTsNCj4gIAlpZiAocmV0IDwgMCB8
fCByZXQgPj0gKGludClzaXplb2YobXpfbmFtZSkpIHsNCj4gIAkJcnRlX2Vycm5vID0gRU5BTUVU
T09MT05HOw0KPiAtCQlnb3RvIGV4aXRfdW5sb2NrOw0KPiArCQlnb3RvIHVubG9jazsNCj4gIAl9
DQo+IA0KPiAgCW16ID0gcnRlX21lbXpvbmVfcmVzZXJ2ZShtel9uYW1lLCBtZW1wb29sX3NpemUs
IHNvY2tldF9pZCwgbXpfZmxhZ3MpOw0KPiAgCWlmIChteiA9PSBOVUxMKQ0KPiAtCQlnb3RvIGV4
aXRfdW5sb2NrOw0KPiArCQlnb3RvIHVubG9jazsNCj4gDQo+ICAJLyogaW5pdCB0aGUgbWVtcG9v
bCBzdHJ1Y3R1cmUgKi8NCj4gIAltcCA9IG16LT5hZGRyOw0KPiBAQCAtOTAwLDcgKzkwMCw3IEBA
IHJ0ZV9tZW1wb29sX2NyZWF0ZV9lbXB0eShjb25zdCBjaGFyICpuYW1lLCB1bnNpZ25lZCBuLCB1
bnNpZ25lZCBlbHRfc2l6ZSwNCj4gIAlyZXQgPSBzdHJsY3B5KG1wLT5uYW1lLCBuYW1lLCBzaXpl
b2YobXAtPm5hbWUpKTsNCj4gIAlpZiAocmV0IDwgMCB8fCByZXQgPj0gKGludClzaXplb2YobXAt
Pm5hbWUpKSB7DQo+ICAJCXJ0ZV9lcnJubyA9IEVOQU1FVE9PTE9ORzsNCj4gLQkJZ290byBleGl0
X3VubG9jazsNCj4gKwkJZ290byB1bmxvY2s7DQo+ICAJfQ0KPiAgCW1wLT5teiA9IG16Ow0KPiAg
CW1wLT5zaXplID0gbjsNCj4gQEAgLTkzMCw3ICs5MzAsNyBAQCBydGVfbWVtcG9vbF9jcmVhdGVf
ZW1wdHkoY29uc3QgY2hhciAqbmFtZSwgdW5zaWduZWQgbiwgdW5zaWduZWQgZWx0X3NpemUsDQo+
IA0KPiAgCWlmIChyZXQpIHsNCj4gIAkJcnRlX2Vycm5vID0gLXJldDsNCj4gLQkJZ290byBleGl0
X3VubG9jazsNCj4gKwkJZ290byB1bmxvY2s7DQo+ICAJfQ0KPiANCj4gIAkvKg0KPiBAQCAtOTU2
LDEzICs5NTYsMTYgQEAgcnRlX21lbXBvb2xfY3JlYXRlX2VtcHR5KGNvbnN0IGNoYXIgKm5hbWUs
IHVuc2lnbmVkIG4sIHVuc2lnbmVkIGVsdF9zaXplLA0KPiANCj4gIAlydGVfbWVtcG9vbF90cmFj
ZV9jcmVhdGVfZW1wdHkobmFtZSwgbiwgZWx0X3NpemUsIGNhY2hlX3NpemUsDQo+ICAJCXByaXZh
dGVfZGF0YV9zaXplLCBmbGFncywgbXApOw0KPiAtCXJldHVybiBtcDsNCj4gKwlnb3RvIGV4aXQ7
DQo+IA0KPiAtZXhpdF91bmxvY2s6DQo+ICt1bmxvY2s6DQo+ICAJcnRlX21jZmdfbWVtcG9vbF93
cml0ZV91bmxvY2soKTsNCj4gIAlydGVfZnJlZSh0ZSk7DQo+ICAJcnRlX21lbXBvb2xfZnJlZSht
cCk7DQo+IC0JcmV0dXJuIE5VTEw7DQo+ICsJbXAgPSBOVUxMOw0KPiArDQo+ICtleGl0Og0KPiAr
CXJldHVybiBtcDsNCj4gIH0NCj4gDQo+ICAvKiBjcmVhdGUgdGhlIG1lbXBvb2wgKi8NCj4gLS0N
Cg0KUGVyc29uYWxseSwgSSBkb24ndCBzZWUgbXVjaCBwcm9maXQgaW4gc3VjaCByZWZhY3Rvcmlu
Zy4NCg0KPiAyLjMwLjINCj4gPA0K
