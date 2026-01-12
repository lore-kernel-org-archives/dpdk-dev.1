Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EC3C9EC6D
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 10:58:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96F3B40A6C;
	Mon, 12 Jan 2026 11:58:34 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 0D8F940288;
 Mon, 12 Jan 2026 11:58:33 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dqTr82GgKzHnGd8;
 Mon, 12 Jan 2026 18:58:16 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 2C13C40571;
 Mon, 12 Jan 2026 18:58:32 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Jan 2026 10:58:31 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 12 Jan 2026 10:58:31 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] mbuf: fix packet copy
Thread-Topic: [PATCH] mbuf: fix packet copy
Thread-Index: AQHcWUyxZC53baITAUi48xMVA9nXxbVA/w+AgA2y4aA=
Date: Mon, 12 Jan 2026 10:58:31 +0000
Message-ID: <b11197c7088a4634a49fa34484320043@huawei.com>
References: <20251119120403.907511-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6561A@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6561A@smartserver.smartshare.dk>
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

DQo+IFBJTkcgZm9yIHJldmlldy4NCj4gDQo+ID4gRnJvbTogTW9ydGVuIEJyw7hydXAgW21haWx0
bzptYkBzbWFydHNoYXJlc3lzdGVtcy5jb21dDQo+ID4gU2VudDogV2VkbmVzZGF5LCAxOSBOb3Zl
bWJlciAyMDI1IDEzLjA0DQo+ID4NCj4gPiBSZXF1ZXN0cyBmb3IgY29weWluZyB0aGUgYXQgdGhl
IGVuZCBvZiBhIHBhY2tldCBpbmNvcnJlY3RseSByZXR1cm5lZA0KPiA+IE5VTEwsDQo+ID4gYXMg
aWYgY29weWluZyBwYXN0IHRoZSBlbmQgb2YgYSBwYWNrZXQuDQo+ID4NCj4gPiBXaGVuIGFsbG9j
YXRpbmcgY29waWVzIGZyb20gYSBtZW1wb29sIHVzaW5nIHBpbm5lZCBleHRlcm5hbCBidWZmZXJz
LA0KPiA+IHRoZQ0KPiA+IGV4dGVybmFsIGZsYWcgd2FzIG5vdCBwcmVzZXJ2ZWQgaW4gdGhlc2Ug
bWJ1ZnMuDQo+ID4NCj4gPiBGaXhlczogYzNhOTBjMzgxZGFhICgibWJ1ZjogYWRkIGEgY29weSBy
b3V0aW5lIikNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFy
dHNoYXJlc3lzdGVtcy5jb20+DQo+ID4gLS0tDQo+ID4gIGxpYi9tYnVmL3J0ZV9tYnVmLmMgfCA2
ICsrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2xpYi9tYnVmL3J0ZV9tYnVmLmMgYi9saWIvbWJ1
Zi9ydGVfbWJ1Zi5jDQo+ID4gaW5kZXggMGQ5MzFjN2ExNS4uZTYzOWFmZjAzZSAxMDA2NDQNCj4g
PiAtLS0gYS9saWIvbWJ1Zi9ydGVfbWJ1Zi5jDQo+ID4gKysrIGIvbGliL21idWYvcnRlX21idWYu
Yw0KPiA+IEBAIC02NzUsNyArNjc1LDcgQEAgcnRlX3BrdG1idWZfY29weShjb25zdCBzdHJ1Y3Qg
cnRlX21idWYgKm0sIHN0cnVjdA0KPiA+IHJ0ZV9tZW1wb29sICptcCwNCj4gPiAgCV9fcnRlX21i
dWZfc2FuaXR5X2NoZWNrKG0sIDEpOw0KPiA+DQo+ID4gIAkvKiBjaGVjayBmb3IgcmVxdWVzdCB0
byBjb3B5IGF0IG9mZnNldCBwYXN0IGVuZCBvZiBtYnVmICovDQo+ID4gLQlpZiAodW5saWtlbHko
b2ZmID49IG0tPnBrdF9sZW4pKQ0KPiA+ICsJaWYgKHVubGlrZWx5KG9mZiA+IG0tPnBrdF9sZW4p
KQ0KPiA+ICAJCXJldHVybiBOVUxMOw0KPiA+DQo+ID4gIAltYyA9IHJ0ZV9wa3RtYnVmX2FsbG9j
KG1wKTsNCj4gPiBAQCAtNjg4LDggKzY4OCw4IEBAIHJ0ZV9wa3RtYnVmX2NvcHkoY29uc3Qgc3Ry
dWN0IHJ0ZV9tYnVmICptLCBzdHJ1Y3QNCj4gPiBydGVfbWVtcG9vbCAqbXAsDQo+ID4NCj4gPiAg
CV9fcnRlX3BrdG1idWZfY29weV9oZHIobWMsIG0pOw0KPiA+DQo+ID4gLQkvKiBjb3BpZWQgbWJ1
ZiBpcyBub3QgaW5kaXJlY3Qgb3IgZXh0ZXJuYWwgKi8NCj4gPiAtCW1jLT5vbF9mbGFncyA9IG0t
Pm9sX2ZsYWdzICYNCj4gPiB+KFJURV9NQlVGX0ZfSU5ESVJFQ1R8UlRFX01CVUZfRl9FWFRFUk5B
TCk7DQo+ID4gKwkvKiBjb3B5IGZsYWdzIGV4Y2VwdCBpbmRpcmVjdCBhbmQgZXh0ZXJuYWwsIGFu
ZCBwcmVzZXJ2ZSBmbGFncyBvZg0KPiA+IG5ld2x5IGFsbG9jYXRlZCBtYnVmICovDQo+ID4gKwlt
Yy0+b2xfZmxhZ3MgfD0gbS0+b2xfZmxhZ3MgJg0KPiA+IH4oUlRFX01CVUZfRl9JTkRJUkVDVHxS
VEVfTUJVRl9GX0VYVEVSTkFMKTsNCj4gPg0KPiA+ICAJcHJldiA9ICZtYy0+bmV4dDsNCj4gPiAg
CW1fbGFzdCA9IG1jOw0KPiA+IC0tDQoNCkFja2VkLWJ5OiBLb25zdGFudGluIEFuYW55ZXYgPGtv
bnN0YW50aW4uYW5hbnlldkBodWF3ZWkuY29tPg0KDQo+ID4gMi40My4wDQoNCg==
