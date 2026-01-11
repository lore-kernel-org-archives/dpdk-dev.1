Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73388D2502E
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Jan 2026 15:19:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C28DF4028F;
	Sun, 11 Jan 2026 16:19:47 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id B849D40281;
 Sun, 11 Jan 2026 16:19:45 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dpzh65HPxzJ467T;
 Sun, 11 Jan 2026 23:19:34 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id A4DB740539;
 Sun, 11 Jan 2026 23:19:44 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sun, 11 Jan 2026 15:19:44 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Sun, 11 Jan 2026 15:19:43 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] mbuf: fix packet copy
Thread-Topic: [PATCH] mbuf: fix packet copy
Thread-Index: AQHcWUyxZC53baITAUi48xMVA9nXxbVA/w+AgAxm98A=
Date: Sun, 11 Jan 2026 15:19:43 +0000
Message-ID: <212f88e700fa4a6a97a421cb3b84e03a@huawei.com>
References: <20251119120403.907511-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6561A@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6561A@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.35.80]
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

DQoNCj4gDQo+IFBJTkcgZm9yIHJldmlldy4NCj4gDQo+ID4gRnJvbTogTW9ydGVuIEJyw7hydXAg
W21haWx0bzptYkBzbWFydHNoYXJlc3lzdGVtcy5jb21dDQo+ID4gU2VudDogV2VkbmVzZGF5LCAx
OSBOb3ZlbWJlciAyMDI1IDEzLjA0DQo+ID4NCj4gPiBSZXF1ZXN0cyBmb3IgY29weWluZyB0aGUg
YXQgdGhlIGVuZCBvZiBhIHBhY2tldCBpbmNvcnJlY3RseSByZXR1cm5lZA0KPiA+IE5VTEwsDQo+
ID4gYXMgaWYgY29weWluZyBwYXN0IHRoZSBlbmQgb2YgYSBwYWNrZXQuDQo+ID4NCj4gPiBXaGVu
IGFsbG9jYXRpbmcgY29waWVzIGZyb20gYSBtZW1wb29sIHVzaW5nIHBpbm5lZCBleHRlcm5hbCBi
dWZmZXJzLA0KPiA+IHRoZQ0KPiA+IGV4dGVybmFsIGZsYWcgd2FzIG5vdCBwcmVzZXJ2ZWQgaW4g
dGhlc2UgbWJ1ZnMuDQo+ID4NCj4gPiBGaXhlczogYzNhOTBjMzgxZGFhICgibWJ1ZjogYWRkIGEg
Y29weSByb3V0aW5lIikNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1vcnRlbiBCcsO4cnVwIDxt
YkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQo+ID4gLS0tDQo+ID4gIGxpYi9tYnVmL3J0ZV9tYnVm
LmMgfCA2ICsrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2xpYi9tYnVmL3J0ZV9tYnVmLmMgYi9s
aWIvbWJ1Zi9ydGVfbWJ1Zi5jDQo+ID4gaW5kZXggMGQ5MzFjN2ExNS4uZTYzOWFmZjAzZSAxMDA2
NDQNCj4gPiAtLS0gYS9saWIvbWJ1Zi9ydGVfbWJ1Zi5jDQo+ID4gKysrIGIvbGliL21idWYvcnRl
X21idWYuYw0KPiA+IEBAIC02NzUsNyArNjc1LDcgQEAgcnRlX3BrdG1idWZfY29weShjb25zdCBz
dHJ1Y3QgcnRlX21idWYgKm0sIHN0cnVjdA0KPiA+IHJ0ZV9tZW1wb29sICptcCwNCj4gPiAgCV9f
cnRlX21idWZfc2FuaXR5X2NoZWNrKG0sIDEpOw0KPiA+DQo+ID4gIAkvKiBjaGVjayBmb3IgcmVx
dWVzdCB0byBjb3B5IGF0IG9mZnNldCBwYXN0IGVuZCBvZiBtYnVmICovDQo+ID4gLQlpZiAodW5s
aWtlbHkob2ZmID49IG0tPnBrdF9sZW4pKQ0KPiA+ICsJaWYgKHVubGlrZWx5KG9mZiA+IG0tPnBr
dF9sZW4pKQ0KPiA+ICAJCXJldHVybiBOVUxMOw0KDQpTbywgd2hlbiBvZmY9IG0tPnBrdF9sZW4s
IHdoYXQgZG8gd2Ugd2FudCBpdCB0byByZXR1cm4/DQpOZXcgbWJ1ZiB3aXRoIHBrdF9sZW4gPT0g
MD8NCkFueSBwb2ludCBvZiBzdWNoIGNvcHlpbmcgdGhlbj8gDQoNCj4gPiAgCW1jID0gcnRlX3Br
dG1idWZfYWxsb2MobXApOw0KPiA+IEBAIC02ODgsOCArNjg4LDggQEAgcnRlX3BrdG1idWZfY29w
eShjb25zdCBzdHJ1Y3QgcnRlX21idWYgKm0sIHN0cnVjdA0KPiA+IHJ0ZV9tZW1wb29sICptcCwN
Cj4gPg0KPiA+ICAJX19ydGVfcGt0bWJ1Zl9jb3B5X2hkcihtYywgbSk7DQo+ID4NCj4gPiAtCS8q
IGNvcGllZCBtYnVmIGlzIG5vdCBpbmRpcmVjdCBvciBleHRlcm5hbCAqLw0KPiA+IC0JbWMtPm9s
X2ZsYWdzID0gbS0+b2xfZmxhZ3MgJg0KPiA+IH4oUlRFX01CVUZfRl9JTkRJUkVDVHxSVEVfTUJV
Rl9GX0VYVEVSTkFMKTsNCj4gPiArCS8qIGNvcHkgZmxhZ3MgZXhjZXB0IGluZGlyZWN0IGFuZCBl
eHRlcm5hbCwgYW5kIHByZXNlcnZlIGZsYWdzIG9mDQo+ID4gbmV3bHkgYWxsb2NhdGVkIG1idWYg
Ki8NCj4gPiArCW1jLT5vbF9mbGFncyB8PSBtLT5vbF9mbGFncyAmDQo+ID4gfihSVEVfTUJVRl9G
X0lORElSRUNUfFJURV9NQlVGX0ZfRVhURVJOQUwpOw0KDQpXaGljaCBmbGFncyBpbiB0aGUgbmV3
IG1idWYgd2Ugd2FudCB0byBwcmVzZXJ2ZT8NCkFGQUlLIG1idWZfYWxsb2MoKSBkb2Vzbid0IHNl
dCBhbnkgZmxhZ3MuDQpCVFcsIGlmIHRoZXJlIGFyZSBzb21lIGZsYWdzIHRoYXQgd2Ugd291bGQg
bGlrZSB0byBwcmVzZXJ2ZSwNCndvdWxkbid0IHRoYXQgYmUgYSAgY2hhbmdlIGluIHB1YmxpYyBB
UEkgYmVoYXZpb3I/DQoNCj4gPg0KPiA+ICAJcHJldiA9ICZtYy0+bmV4dDsNCj4gPiAgCW1fbGFz
dCA9IG1jOw0KPiA+IC0tDQo+ID4gMi40My4wDQoNCg==
