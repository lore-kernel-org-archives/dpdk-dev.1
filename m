Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8097AC9EC6D
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 10:56:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3873940A6C;
	Mon, 12 Jan 2026 11:56:39 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 1516C40288;
 Mon, 12 Jan 2026 11:56:37 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dqTnx0smZzHnH5x;
 Mon, 12 Jan 2026 18:56:21 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id F0F0440086;
 Mon, 12 Jan 2026 18:56:36 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Jan 2026 10:56:36 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 12 Jan 2026 10:56:36 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] mbuf: fix packet copy
Thread-Topic: [PATCH] mbuf: fix packet copy
Thread-Index: AQHcWUyxZC53baITAUi48xMVA9nXxbVA/w+AgAxm98CAACY5MIABJSFA
Date: Mon, 12 Jan 2026 10:56:36 +0000
Message-ID: <85c7bfd62ec04587bb19d0219b9960ca@huawei.com>
References: <20251119120403.907511-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6561A@smartserver.smartshare.dk>
 <212f88e700fa4a6a97a421cb3b84e03a@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6564B@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6564B@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.168.96]
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

DQo+ID4gPiA+IEZyb206IE1vcnRlbiBCcsO4cnVwIFttYWlsdG86bWJAc21hcnRzaGFyZXN5c3Rl
bXMuY29tXQ0KPiA+ID4gPiBTZW50OiBXZWRuZXNkYXksIDE5IE5vdmVtYmVyIDIwMjUgMTMuMDQN
Cj4gPiA+ID4NCj4gPiA+ID4gUmVxdWVzdHMgZm9yIGNvcHlpbmcgdGhlIGF0IHRoZSBlbmQgb2Yg
YSBwYWNrZXQgaW5jb3JyZWN0bHkNCj4gPiByZXR1cm5lZA0KPiA+ID4gPiBOVUxMLA0KPiA+ID4g
PiBhcyBpZiBjb3B5aW5nIHBhc3QgdGhlIGVuZCBvZiBhIHBhY2tldC4NCj4gPiA+ID4NCj4gPiA+
ID4gV2hlbiBhbGxvY2F0aW5nIGNvcGllcyBmcm9tIGEgbWVtcG9vbCB1c2luZyBwaW5uZWQgZXh0
ZXJuYWwNCj4gPiBidWZmZXJzLA0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gZXh0ZXJuYWwgZmxhZyB3
YXMgbm90IHByZXNlcnZlZCBpbiB0aGVzZSBtYnVmcy4NCj4gPiA+ID4NCj4gPiA+ID4gRml4ZXM6
IGMzYTkwYzM4MWRhYSAoIm1idWY6IGFkZCBhIGNvcHkgcm91dGluZSIpDQo+ID4gPiA+DQo+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5j
b20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgbGliL21idWYvcnRlX21idWYuYyB8IDYgKysrLS0t
DQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvbGliL21idWYvcnRlX21idWYuYyBiL2xp
Yi9tYnVmL3J0ZV9tYnVmLmMNCj4gPiA+ID4gaW5kZXggMGQ5MzFjN2ExNS4uZTYzOWFmZjAzZSAx
MDA2NDQNCj4gPiA+ID4gLS0tIGEvbGliL21idWYvcnRlX21idWYuYw0KPiA+ID4gPiArKysgYi9s
aWIvbWJ1Zi9ydGVfbWJ1Zi5jDQo+ID4gPiA+IEBAIC02NzUsNyArNjc1LDcgQEAgcnRlX3BrdG1i
dWZfY29weShjb25zdCBzdHJ1Y3QgcnRlX21idWYgKm0sDQo+ID4gc3RydWN0DQo+ID4gPiA+IHJ0
ZV9tZW1wb29sICptcCwNCj4gPiA+ID4gIAlfX3J0ZV9tYnVmX3Nhbml0eV9jaGVjayhtLCAxKTsN
Cj4gPiA+ID4NCj4gPiA+ID4gIAkvKiBjaGVjayBmb3IgcmVxdWVzdCB0byBjb3B5IGF0IG9mZnNl
dCBwYXN0IGVuZCBvZiBtYnVmICovDQo+ID4gPiA+IC0JaWYgKHVubGlrZWx5KG9mZiA+PSBtLT5w
a3RfbGVuKSkNCj4gPiA+ID4gKwlpZiAodW5saWtlbHkob2ZmID4gbS0+cGt0X2xlbikpDQo+ID4g
PiA+ICAJCXJldHVybiBOVUxMOw0KPiA+DQo+ID4gU28sIHdoZW4gb2ZmPSBtLT5wa3RfbGVuLCB3
aGF0IGRvIHdlIHdhbnQgaXQgdG8gcmV0dXJuPw0KPiA+IE5ldyBtYnVmIHdpdGggcGt0X2xlbiA9
PSAwPw0KPiA+IEFueSBwb2ludCBvZiBzdWNoIGNvcHlpbmcgdGhlbj8NCj4gDQo+IEVtcHR5IHBh
Y2tldHMgYXJlIHBlcmZlY3RseSB2YWxpZC4NCj4gQSBsaWJyYXJ5IHNob3VsZCBub3Qgb3B0aW1p
emUgdGhlbSBhd2F5OyBpdCBpcyB0aGUgYXBwbGljYXRpb24ncyBjaG9pY2UgaG93IHRvIGhhbmRs
ZQ0KPiBlbXB0eSBwYWNrZXRzLg0KPiANCj4gPg0KPiA+ID4gPiAgCW1jID0gcnRlX3BrdG1idWZf
YWxsb2MobXApOw0KPiA+ID4gPiBAQCAtNjg4LDggKzY4OCw4IEBAIHJ0ZV9wa3RtYnVmX2NvcHko
Y29uc3Qgc3RydWN0IHJ0ZV9tYnVmICptLA0KPiA+IHN0cnVjdA0KPiA+ID4gPiBydGVfbWVtcG9v
bCAqbXAsDQo+ID4gPiA+DQo+ID4gPiA+ICAJX19ydGVfcGt0bWJ1Zl9jb3B5X2hkcihtYywgbSk7
DQo+ID4gPiA+DQo+ID4gPiA+IC0JLyogY29waWVkIG1idWYgaXMgbm90IGluZGlyZWN0IG9yIGV4
dGVybmFsICovDQo+ID4gPiA+IC0JbWMtPm9sX2ZsYWdzID0gbS0+b2xfZmxhZ3MgJg0KPiA+ID4g
PiB+KFJURV9NQlVGX0ZfSU5ESVJFQ1R8UlRFX01CVUZfRl9FWFRFUk5BTCk7DQo+ID4gPiA+ICsJ
LyogY29weSBmbGFncyBleGNlcHQgaW5kaXJlY3QgYW5kIGV4dGVybmFsLCBhbmQgcHJlc2VydmUg
ZmxhZ3Mgb2YNCj4gPiA+ID4gbmV3bHkgYWxsb2NhdGVkIG1idWYgKi8NCj4gPiA+ID4gKwltYy0+
b2xfZmxhZ3MgfD0gbS0+b2xfZmxhZ3MgJg0KPiA+ID4gPiB+KFJURV9NQlVGX0ZfSU5ESVJFQ1R8
UlRFX01CVUZfRl9FWFRFUk5BTCk7DQo+ID4NCj4gPiBXaGljaCBmbGFncyBpbiB0aGUgbmV3IG1i
dWYgd2Ugd2FudCB0byBwcmVzZXJ2ZT8NCj4gPiBBRkFJSyBtYnVmX2FsbG9jKCkgZG9lc24ndCBz
ZXQgYW55IGZsYWdzLg0KPiANCj4gQ29ycmVjdDogdGhlIG5ld2x5IGFsbG9jYXRlZCBtYnVmIHJl
dHVybmVkIGJ5IG1idWZfYWxsb2MoKSBub3JtYWxseSBoYXMgbm8gZmxhZ3MNCj4gc2V0Lg0KPiBI
b3dldmVyLCBpZiBpdCBpcyBhbGxvY2F0ZWQgZnJvbSBhbiBtYnVmIHBvb2wgaG9sZGluZyBtYnVm
cyB1c2luZyBwaW5uZWQgZXh0ZXJuYWwNCj4gYnVmZmVycywgdGhlIFJURV9NQlVGX0ZfRVhURVJO
QUwgaXMgYWxyZWFkeSBzZXQgaW4gdGhlIG1idWZzIGhlbGQgaW4gdGhhdCBwb29sLA0KPiBhbmQg
d2lsbCByZW1haW4gc2V0IHdoZW4gcmV0dXJuaW5nIHRoZSBtYnVmIGJ5IG1idWZfYWxsb2MoKS4g
V2Ugd2FudCB0byBwcmVzZXJ2ZQ0KPiB0aGF0IGZsYWcuDQo+IA0KPiA+IEJUVywgaWYgdGhlcmUg
YXJlIHNvbWUgZmxhZ3MgdGhhdCB3ZSB3b3VsZCBsaWtlIHRvIHByZXNlcnZlLA0KPiA+IHdvdWxk
bid0IHRoYXQgYmUgYSAgY2hhbmdlIGluIHB1YmxpYyBBUEkgYmVoYXZpb3I/DQo+IA0KPiBUaGlz
IHBhdGNoIGRvZXMgbm90IGNoYW5nZSB3aGljaCBmbGFncyB0byBwcmVzZXJ2ZSBmcm9tIHRoZSBz
b3VyY2UgbWJ1Zi4NCj4gVGhlIHBhdGNoIG9ubHkgYWRkcyB0aGF0IHRoZSBmbGFncyBvZiB0aGUg
bmV3bHkgYWxsb2NhdGVkIG1idWYgYXJlIG5vdCBjbGVhcmVkIHdoZW4NCj4gY29weWluZyB0aGUg
ZmxhZ3MgZnJvbSB0aGUgc291cmNlIG1idWYuDQoNCk1ha2VzIHNlbnNlLCB0aGFua3MgZm9yIGNs
YXJpZnlpbmcuDQo=
