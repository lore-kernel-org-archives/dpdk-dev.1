Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1370C561E6
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 17:16:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7AE44027E;
	Wed,  5 Aug 2026 19:16:23 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 1CB374021F
 for <dev@dpdk.org>; Wed,  5 Aug 2026 19:16:22 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=e53PYQ8o7GW8S11chfkX7+WYg4nEfP8Xs4OcOO7K6sw=;
 b=VZXZLi1LmaI1BjvGtPcU4pmwc2sGrVY4hMSbIavhJEN8yvq6fdPIysKDAMRCh8zYKVnGazlpX
 Sb9aLa/t3Nk3p6xsEjNKQk4fS+ulAwKVqzjx2fAj/XF51v8NIMNM+FRIvbkGYeq+jP/I+S7ZlLX
 C1hayndZSRWFEv5E7jL7yqU=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hFcVv2mwdzJ46Yq;
 Thu,  6 Aug 2026 01:15:35 +0800 (CST)
Received: from dubpeml100003.china.huawei.com (unknown [7.214.147.98])
 by mail.maildlp.com (Postfix) with ESMTPS id AB33140577;
 Thu,  6 Aug 2026 01:16:20 +0800 (CST)
Received: from dubpemt500001.china.huawei.com (7.214.144.77) by
 dubpeml100003.china.huawei.com (7.214.147.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 5 Aug 2026 18:16:20 +0100
Received: from dubpeml100001.china.huawei.com (7.214.144.137) by
 dubpemt500001.china.huawei.com (7.214.144.77) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Aug 2026 18:16:19 +0100
Received: from dubpeml100001.china.huawei.com ([7.214.144.137]) by
 dubpeml100001.china.huawei.com ([7.214.144.137]) with mapi id 15.02.1544.036; 
 Wed, 5 Aug 2026 18:16:19 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>
Subject: RE: [PATCH] eal/x86: optimize memcpy of small 64-byte blocks
Thread-Topic: [PATCH] eal/x86: optimize memcpy of small 64-byte blocks
Thread-Index: AQHdJB42oNL4gJj070KJtRurBEIGmLaN+WoAgAAJXwCAAOt0oIAABRpAgAAL2ECAAB9NYIAAlEaw
Date: Wed, 5 Aug 2026 17:16:19 +0000
Message-ID: <3a96ca58a1e146758f5314202a04c3de@huawei.com>
References: <20260804143305.1344327-1-mb@smartsharesystems.com>
 <20260804085210.74763eb5@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F659B8@smartserver.smartshare.dk>
 <6f474724bc22441a8a4f516f3398ca76@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F659BD@smartserver.smartshare.dk>
 <3c7eea01416249e0aaeab0e8b6b4c157@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F659BF@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659BF@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.173.34]
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

DQoNCj4gPiA+ID4gPiA+ID4gKwkvKiBDb21tb24gd2F5IGZvciBzbWFsbCBjb3B5IHNpemUgb2Yg
NjQtYnl0ZSBibG9ja3MuDQo+ID4gPiA+IFVubGlrZWx5LCBzbw0KPiA+ID4gPiA+ID4gY29uc3Rh
bnQgc2l6ZSBvbmx5ICovDQo+ID4gPiA+ID4gPiA+ICsJaWYgKF9fcnRlX2NvbnN0YW50KG4pICYm
IChuICYgNjMpID09IDAgJiYgbiA8PQ0KPiA+ID4gPiA+ID4gUlRFX01FTUNQWV9CTE9DS182NF9N
QVgpIHsNCj4gPiA+ID4gPiA+ID4gKwkJdm9pZCAqcmV0ID0gZHN0Ow0KPiA+ID4gPiA+ID4gPiAr
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gTWF5YmUganVzdCBsZXQgY29tcGlsZXIgZGVjaWRl
LCBpdCB3aWxsIGdlbmVyYXRlIHZlY3Rvcg0KPiA+ID4gPiBpbnN0cnVjdGlvbnMgaW4NCj4gPiA+
ID4gPiA+IG1vc3QgY2FzZXMuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gCWlmIChfX3J0ZV9j
b25zdGFudChuKSkNCj4gPiA+ID4gPiA+IAkJcmV0dXJuIG1lbXBjcHkoZHN0LCBzcmMsIG4pOw0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gTWF5YmUgaW4gbW9zdCwgYnV0IG5vdCBpbiBhbGw6DQo+ID4g
PiA+ID4gaHR0cHM6Ly9nb2Rib2x0Lm9yZy96L0t2ZEtxVDVyWQ0KPiA+ID4gPg0KPiA+ID4gPiBX
aXRoICctbWF2eCcgb3IgJy1tYXZ4NTEyZicgaXQgbG9va3MgbGlrZSBpdCBkb2VzIGZvciB5b3Vy
IHNhbXBsZQ0KPiA+IGNvZGUuDQo+ID4gPg0KPiA+ID4gSXQgYWxzbyBkb2VzIHdpdGggLW1zc2U0
LjIgd2hlbiBTWiBpcyByZWR1Y2VkIHRvIDI1NiBieXRlcy4NCj4gPiA+IENsYW5nIHN3aXRjaGVz
IHRvIGlubGluZSB3aGVuIFNaIGlzIHJlZHVjZWQgdG8gMTI4IGJ5dGVzLg0KPiA+ID4NCj4gPiA+
IEl0IHNlZW1zIHRoZSBjb21waWxlciBoYXMgYSB0aHJlc2hvbGQgZm9yIHdoZW4gdG8gaW5saW5l
IGFuZCB3aGVuIHRvDQo+ID4gY2FsbCB0aGUgQw0KPiA+ID4gbGlicmFyeSdzIG1lbWNweSBzdWJy
b3V0aW5lLg0KPiA+ID4gVGhlIHRocmVzaG9sZCBkZXBlbmRzIG9uIGJvdGggY29weSBzaXplIGFu
ZCB2ZWN0b3IgcmVnaXN0ZXIgc2l6ZS4NCj4gPiA+IEFuZCBpdCBpcyBjb21waWxlciBkZXBlbmRl
bnQuDQo+ID4NCj4gPiBJIHRoaW5rIHRoZXJlIGFyZSBjb21waWxlciBvcHRpb25zIHRvIHNwZWNp
ZnkgZGVzaXJlZCB0aHJlc2hvbGQgdmFsdWVzLg0KPiA+IExldCBzYXkgZm9yIGdjYyB0aGVyZSBp
cyAgJyAtbW1lbWNweS1zdHJhdGVneT1zdHJhdGVneScuDQo+ID4gRm9yIHRoYXQgZXhhbXBsZSBp
biB0aGF0IHBhcnRpY3VsYXIgY2FzZQ0KPiA+IC1tbWVtY3B5LXN0cmF0ZWd5PXZlY3Rvcl9sb29w
OjUxMjphbGlnbixsb29wOi0xOmFsaWduDQo+ID4gZ2VuZXJhdGVzIHNzZSBsb2Fkcy9zdG9yZXMu
DQo+ID4gTWlnaHQgYmUgd2UgY2FuIGV4cGxvaXQgaXQgc29tZWhvdz8NCj4gDQo+IFRoYXQgY291
bGQgZ2l2ZSB1cyBoaWdoZXIgZ3JhbnVsYXJpdHkvY29udHJvbCBvdmVyIG1lbWNweSBmb3IgaW5k
aXZpZHVhbA0KPiBtZW1jcHkgaW5zdGFuY2VzOyBtaWdodCBiZSB1c2VmdWwgZm9yIGhvdCBjb2Rl
IHBhdGhzIHdoZXJlIHdlIGhhdmUgbW9yZQ0KPiBrbm93bGVkZ2UgYWJvdXQgdGhlIGNvcHkgb3Bl
cmF0aW9uIHRoYW4gdGhlIGNvbXBpbGVyIGNhbiBpbmZlci4NCj4gSG93ZXZlciwgcHJhZ21hcyBh
cmUgZGlzY291cmFnZWQgaW4gRFBESywgYW5kIHRoaXMgbG9va3MgbGlrZSBhIHZlcnkgc2ltaWxh
cg0KPiBwYXRoLg0KDQpXZWxsLCByaWdodCBub3cgIHJ0ZV9tZW1jcHkuaCBpcyA3MDArIGxpbmVz
IGFuZCBrZWVwcyBncm93aW5nLg0KQ29uc2lkZXJpbmcgdGhhdCBwcm9iYWJseSBwcmFnbWFzIGFy
ZSBub3QgdGhhdCBiYWQuDQpPZiBjb3Vyc2UsIHByYWdtYXMgaGF2ZSB0aGVpciBvd24gaXNzdWVz
IGFuZCBpdCBpcyBoYXJkIHRvIGVuc3VyZSB0aGF0DQp0aGV5IHdpbGwgcHJvZHVjZSBzYW1lIGNv
ZGUgYmV0d2VlbiBkaWZmZXJlbnQgY29tcGlsZXJzL3ZlcnNpb25zLCBldGMuICANCg0KPiA+IEkg
YW0gbm90IHJlYWxseSBoYXBweSB0aGF0IG91ciBob21lLWJyZXdlZCBtZW1jcHkgY29kZS1ibG9j
ayBrZWVwcw0KPiA+IGdyb3dpbmcsDQo+ID4gd2hpbGUgd2Uga2VlcCB0YWxraW5nIHRoYXQgaXQg
d291bGQgYmUgZ29vZCB0byBlbGltaW5hdGUgaXQgY29tcGxldGVseS4NCj4gDQo+IEkgYWdyZWUg
aW4gcHJpbmNpcGxlLg0KPiBIb3dldmVyLCB0aGlzIHJ0ZV9tZW1jcHkoKSBvcHRpbWl6YXRpb24g
aXMgZm9yIHRoZSBwaWxlL21lbXBvb2wgb3B0aW1pemF0aW9ucw0KPiBJJ20gd29ya2luZyBvbiwg
c28gdGhlcmUgaXMgYSBzcGVjaWZpYyB1c2UgY2FzZSBtb3RpdmF0aW5nIHRoZSBhZGRlZCBjb2Rl
Lg0KDQpJIHVuZGVyc3RhbmQgdGhhdCB5b3UgcHJvYmFibHkgaGF2ZSBzb21lIHNwZWNpZmljIHVz
ZS1jYXNlIGluIG1pbmQuDQpCVFcgZm9yIHRoaXMgb3B0aW1pemF0aW9uIHlvdSBtZW50aW9uZWQg
YWJvdmU6IHdoYXQgaXMgdGhlIGdhaW4gd2l0aCB0aGVzZSBjaGFuZ2VzPw0K
