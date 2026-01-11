Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F69D2502E
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Jan 2026 16:01:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 423344065B;
	Sun, 11 Jan 2026 17:01:44 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id F3D8C40655
 for <dev@dpdk.org>; Sun, 11 Jan 2026 17:01:41 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dq0cW12F5zJ4681;
 Mon, 12 Jan 2026 00:01:31 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id 1F1DF40584;
 Mon, 12 Jan 2026 00:01:41 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 11 Jan 2026 16:01:40 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Sun, 11 Jan 2026 16:01:40 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] mbuf: optimize detach direct buffer
Thread-Topic: [PATCH] mbuf: optimize detach direct buffer
Thread-Index: AQHcfNg4Y2Kx2wgdr0CIlI1ySEci6rVNLU7w
Date: Sun, 11 Jan 2026 16:01:40 +0000
Message-ID: <6ce9a070d9964ba5b8468be88e9974c5@huawei.com>
References: <20260103174054.121246-1-mb@smartsharesystems.com>
In-Reply-To: <20260103174054.121246-1-mb@smartsharesystems.com>
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

DQoNCj4gV2hlbiBydGVfcGt0bWJ1Zl9wcmVmcmVlX3NlZygpIHJlc2V0cyBhbiBtYnVmIGFib3V0
IHRvIGJlIGZyZWVkLCBpdA0KPiBkb2Vzbid0IHdyaXRlIHRoZSBmaWVsZHMgdGhhdCBhbHJlYWR5
IGhhdmUgdGhlIHJlcXVpcmVkIHZhbHVlcy4gVGhpcw0KPiBzYXZlcyBhIG1lbW9yeSBzdG9yZSBv
cGVyYXRpb24gd2hlbiBhbGwgdGhlIGZpZWxkcyBhbHJlYWR5IGhhdmUgdGhlDQo+IHJlcXVpcmVk
IHZhbHVlcy4NCj4gDQo+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgc2FtZSBvcHRpbWl6YXRpb24gdG8g
X19ydGVfcGt0bWJ1Zl9mcmVlX2RpcmVjdCgpLA0KPiB0byBpbXByb3ZlIHRoZSBwZXJmb3JtYW5j
ZSBmb3IgZnJlZWluZyBhIGRpcmVjdCBidWZmZXIgYmVpbmcgZGV0YWNoZWQgZnJvbQ0KPiBhIHBh
Y2tldCBtYnVmLCBpLmUuIHNhdmluZyBhIG1lbW9yeSBzdG9yZSBvcGVyYXRpb24gd2hlbiBhbGwg
dGhlIGZpZWxkcw0KPiAob2YgdGhlIGJ1ZmZlciBiZWluZyBmcmVlZCkgYWxyZWFkeSBoYXZlIHRo
ZSByZXF1aXJlZCB2YWx1ZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8
bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KPiAtLS0NCj4gIGxpYi9tYnVmL3J0ZV9tYnVmLmgg
fCAxNiArKysrKysrKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9saWIvbWJ1Zi9ydGVfbWJ1Zi5o
IGIvbGliL21idWYvcnRlX21idWYuaA0KPiBpbmRleCAyMDA0MzkxZjU3Li41OTJhZjIzODhjIDEw
MDY0NA0KPiAtLS0gYS9saWIvbWJ1Zi9ydGVfbWJ1Zi5oDQo+ICsrKyBiL2xpYi9tYnVmL3J0ZV9t
YnVmLmgNCj4gQEAgLTEzMzQsMTcgKzEzMzQsMjMgQEAgc3RhdGljIGlubGluZSB2b2lkDQo+ICBf
X3J0ZV9wa3RtYnVmX2ZyZWVfZGlyZWN0KHN0cnVjdCBydGVfbWJ1ZiAqbSkNCj4gIHsNCj4gIAlz
dHJ1Y3QgcnRlX21idWYgKm1kOw0KPiArCWJvb2wgcmVmY250X25vdF9vbmU7DQo+IA0KPiAgCVJU
RV9BU1NFUlQoUlRFX01CVUZfQ0xPTkVEKG0pKTsNCj4gDQo+ICAJbWQgPSBydGVfbWJ1Zl9mcm9t
X2luZGlyZWN0KG0pOw0KPiANCj4gLQlpZiAocnRlX21idWZfcmVmY250X3VwZGF0ZShtZCwgLTEp
ID09IDApIHsNCj4gLQkJbWQtPm5leHQgPSBOVUxMOw0KPiAtCQltZC0+bmJfc2VncyA9IDE7DQo+
ICsJcmVmY250X25vdF9vbmUgPSB1bmxpa2VseShydGVfbWJ1Zl9yZWZjbnRfcmVhZChtZCkgIT0g
MSk7DQo+ICsJaWYgKHJlZmNudF9ub3Rfb25lICYmIF9fcnRlX21idWZfcmVmY250X3VwZGF0ZSht
ZCwgLTEpICE9IDApDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCWlmIChyZWZjbnRfbm90X29uZSkN
Cj4gIAkJcnRlX21idWZfcmVmY250X3NldChtZCwgMSk7DQo+IC0JCXJ0ZV9tYnVmX3Jhd19mcmVl
KG1kKTsNCj4gLQl9DQo+ICsJaWYgKG1kLT5uYl9zZWdzICE9IDEpDQo+ICsJCW1kLT5uYl9zZWdz
ID0gMTsNCj4gKwlpZiAobWQtPm5leHQgIT0gTlVMTCkNCj4gKwkJbWQtPm5leHQgPSBOVUxMOw0K
PiArCXJ0ZV9tYnVmX3Jhd19mcmVlKG1kKTsNCj4gIH0NCj4gDQo+ICAvKioNCj4gLS0NCg0KQWNr
ZWQtYnk6IEtvbnN0YW50aW4gQW5hbnlldiA8a29uc3RhbnRpbi5hbmFueWV2QGh1YXdlaS5jb20+
DQogDQoNCj4gMi40My4wDQoNCg==
