Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB30B10775E1
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 16:43:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0E314026F;
	Wed, 18 Mar 2026 17:43:49 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 8BB8040150
 for <dev@dpdk.org>; Wed, 18 Mar 2026 17:43:48 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fbZQN6kqFzHnGf1;
 Thu, 19 Mar 2026 00:43:24 +0800 (CST)
Received: from frapema500002.china.huawei.com (unknown [7.182.19.148])
 by mail.maildlp.com (Postfix) with ESMTPS id CB5AF4056E;
 Thu, 19 Mar 2026 00:43:46 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500002.china.huawei.com (7.182.19.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Mar 2026 17:43:46 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 18 Mar 2026 17:43:46 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, "Christophe
 Fontaine" <cfontain@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
Subject: RE: [PATCH] bpf/arm64: support packet data load instructions
Thread-Topic: [PATCH] bpf/arm64: support packet data load instructions
Thread-Index: AQHctXjoFxWXyTh3g0OC9SlGIQcTMrW0I+zwgAAX+/CAAAZ24IAABL0ggAAWnQCAABUq0IAACOLggAAEr0A=
Date: Wed, 18 Mar 2026 16:43:46 +0000
Message-ID: <ba8f317961494ce9af15a9108aa3693b@huawei.com>
References: <20260310122045.4057836-1-cfontain@redhat.com>
 <b10d0edcdaac4fd9a4f5a0261205670c@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6579F@smartserver.smartshare.dk>
 <4942136acefe4fc3b5157191749fe3d5@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657A0@smartserver.smartshare.dk>
 <CAHVr2NmXSAhKO6EGjh_DDvdaUShPTWH-Eb1y1VrriQBAVnay4w@mail.gmail.com>
 <ea715be437174fa782f3ceb031debe0d@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657A1@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F657A1@smartserver.smartshare.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.74]
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

PiA+IEkgc3VnZ2VzdCB0aGUgZm9sbG93aW5nIGxvZ2ljIGluIHBzZXVkby1jb2RlOg0KPiA+DQo+
ID4gc3RhdGljIHZvaWQNCj4gPiBlbWl0X2xkX21idWYoc3RydWN0IGE2NF9qaXRfY3R4ICpjdHgs
IHVpbnQzMl90IG9wLCB1aW50OF90IHRtcDEsDQo+ID4gdWludDhfdCB0bXAyLA0KPiA+IAl1aW50
OF90IHNyYywgaW50MzJfdCBpbW0pDQo+ID4gew0KPiA+IAkvLyAuLi4NCj4gPg0KPiA+IAkvKiBy
MSA9IG9mZjogZm9yIEFCUyB1c2UgaW1tLCBmb3IgSU5EIHVzZSBzcmMgKyBpbW0gKi8NCj4gPiAJ
aWYgKG1vZGUgPT0gQlBGX0FCUykgew0KPiA+IAkJYXNzZXJ0IGltbSA+PSAwLCAidmVyaWZpZWQg
YnkgdmVyaWZpZXIiDQo+ID4gCQllbWl0IE1PViBXMSwgIzxpbW0+DQo+ID4gCX0gZWxzZSB7DQo+
ID4gCQkvKiBhZGQgc2lnbmVkIGltbSB0byB0aGUgc291cmNlIHJlZ2lzdGVyICovDQo+ID4gCQll
bWl0KHMpIFgxID0gc3JjICsgIzxpbW0+DQo+ID4gCQkvKiB2ZXJpZnkgZHluYW1pY2FsbHkgdGhh
dCBvZmZzZXQgaXMgd2l0aGluIHRoZSBkb21haW4gb2YNCj4gPiBfX3J0ZV9wa3RtYnVmX3JlYWQg
Ki8NCj4gPiAJCWVtaXQocykganVtcF90b19lcGlsb2d1ZSBpZiBYMSA8cyAwIHx8IFgxID4gSU5U
MzJfTUFYDQo+ID4gCX0NCj4gPg0KPiA+IAkvLyAuLi4NCj4gPiB9DQo+IA0KPiBJIGRvbid0IGtu
b3cgaWYgaXQncyB0aGUgc3VtIG9mIHNyYytpbW0gdGhhdCBkZXRlcm1pbmVzIHNwZWNpYWwgbWVh
bmluZywgb3IgaXQncyB0aGUgaW1tIGl0c2VsZi4NCj4gSWYgaXQncyB0aGUgaW1tIGl0c2VsZiwg
YSBzaW1wbGUgZml4IHdvdWxkIGJlIHRvIHVwZGF0ZSB0aGUgdmFsaWRhdG9yJ3MgLmltbS5tYXgg
dmFsdWVzIGZvciBCUEZfSU5EDQo+IGZyb20gVUlOVDMyX01BWCB0byBJTlQzMl9NQVguDQo+IA0K
DQpFdmVuIGlmIHdlIGRvIGl0IChJIGhhdmUgbm8gcGFydGljdWxhciBvcGluaW9uKSwgaXQgd29u
J3QgcHJldmVudCBzdW0gb2YgNjQtYml0DQpyZWdpc3RlciBhbmQgaW1tZWRpYXRlIGZyb20gYmVp
bmcgbmVnYXRpdmUgb3IgZ3JlYXRlciB0aGFuIHRoZSByYW5nZSBvZiB2YWx1ZXMNCnN1cHBvcnRl
ZCBieSAzMi1iaXQgYXJndW1lbnQgb2YgX19ydGVfcGt0bWJ1Zl9yZWFkLg0K
