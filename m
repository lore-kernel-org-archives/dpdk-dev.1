Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6076E10775FC
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 18:10:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E9E24026F;
	Wed, 18 Mar 2026 19:10:45 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 1994640150
 for <dev@dpdk.org>; Wed, 18 Mar 2026 19:10:42 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fbcKz2l8xzJ467f;
 Thu, 19 Mar 2026 02:09:43 +0800 (CST)
Received: from dubpeml500003.china.huawei.com (unknown [7.214.146.145])
 by mail.maildlp.com (Postfix) with ESMTPS id 7985B40572;
 Thu, 19 Mar 2026 02:10:41 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500003.china.huawei.com (7.214.146.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Mar 2026 18:10:41 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 18 Mar 2026 18:10:40 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>, =?utf-8?B?TW9ydGVuIEJyw7hydXA=?=
 <mb@smartsharesystems.com>, Christophe Fontaine <cfontain@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
Subject: RE: [PATCH] bpf/arm64: support packet data load instructions
Thread-Topic: [PATCH] bpf/arm64: support packet data load instructions
Thread-Index: AQHctXjmQX8WarddCE6NszBJkCRgkLW0Ml8AgAAPe4CAAAOKgIAACP4AgAAgGACAAAvWAIAABb8AgAABxQCAABNiEA==
Date: Wed, 18 Mar 2026 18:10:40 +0000
Message-ID: <78da248e82a54be6882d37efeff23add@huawei.com>
References: <20260310122045.4057836-1-cfontain@redhat.com>
 <b10d0edcdaac4fd9a4f5a0261205670c@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6579F@smartserver.smartshare.dk>
 <4942136acefe4fc3b5157191749fe3d5@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657A0@smartserver.smartshare.dk>
 <CAHVr2NmXSAhKO6EGjh_DDvdaUShPTWH-Eb1y1VrriQBAVnay4w@mail.gmail.com>
 <ea715be437174fa782f3ceb031debe0d@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657A1@smartserver.smartshare.dk>
 <ba8f317961494ce9af15a9108aa3693b@huawei.com>
In-Reply-To: <ba8f317961494ce9af15a9108aa3693b@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
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

DQoNCj4gDQo+ID4gPiBJIHN1Z2dlc3QgdGhlIGZvbGxvd2luZyBsb2dpYyBpbiBwc2V1ZG8tY29k
ZToNCj4gPiA+DQo+ID4gPiBzdGF0aWMgdm9pZA0KPiA+ID4gZW1pdF9sZF9tYnVmKHN0cnVjdCBh
NjRfaml0X2N0eCAqY3R4LCB1aW50MzJfdCBvcCwgdWludDhfdCB0bXAxLA0KPiA+ID4gdWludDhf
dCB0bXAyLA0KPiA+ID4gCXVpbnQ4X3Qgc3JjLCBpbnQzMl90IGltbSkNCj4gPiA+IHsNCj4gPiA+
IAkvLyAuLi4NCj4gPiA+DQo+ID4gPiAJLyogcjEgPSBvZmY6IGZvciBBQlMgdXNlIGltbSwgZm9y
IElORCB1c2Ugc3JjICsgaW1tICovDQo+ID4gPiAJaWYgKG1vZGUgPT0gQlBGX0FCUykgew0KPiA+
ID4gCQlhc3NlcnQgaW1tID49IDAsICJ2ZXJpZmllZCBieSB2ZXJpZmllciINCj4gPiA+IAkJZW1p
dCBNT1YgVzEsICM8aW1tPg0KPiA+ID4gCX0gZWxzZSB7DQo+ID4gPiAJCS8qIGFkZCBzaWduZWQg
aW1tIHRvIHRoZSBzb3VyY2UgcmVnaXN0ZXIgKi8NCj4gPiA+IAkJZW1pdChzKSBYMSA9IHNyYyAr
ICM8aW1tPg0KPiA+ID4gCQkvKiB2ZXJpZnkgZHluYW1pY2FsbHkgdGhhdCBvZmZzZXQgaXMgd2l0
aGluIHRoZSBkb21haW4gb2YNCj4gPiA+IF9fcnRlX3BrdG1idWZfcmVhZCAqLw0KPiA+ID4gCQll
bWl0KHMpIGp1bXBfdG9fZXBpbG9ndWUgaWYgWDEgPHMgMCB8fCBYMSA+IElOVDMyX01BWA0KDQpT
aG91bGRuJ3QgaXQgYmUgVUlOVDMyX01BWD8NCg0KPiA+ID4gCX0NCj4gPiA+DQo+ID4gPiAJLy8g
Li4uDQo+ID4gPiB9DQoNCkkgd29uZGVyIGRvZXMgeDg2IGppdCBhbmQgVk0gcGVyZm9ybSB0aGF0
IGNoZWNrPw0KSWYgbm90LCB0aGVuIGl0IGlzIHByb2JhYmx5IG5vdCBmYWlyIHRvIGRlbWFuZCB0
aGF0IHBhdGNoIHRvIGZpeCB0aGVzZSB0aGluZ3MgZm9yIGFybToNCkl0IHByb2JhYmx5IGhhcyB0
byBiZSBhbm90aGVyIHBhdGNoIHRoYXQgd2lsbCBmaXggdGhhdCBpc3N1ZSBmb3IgYWxsIHRhcmdl
dHMgKHZtLCB4ODYsIGFybSkuDQpBZnRlciBhbGwgLSBpdCB3b3VsZG4ndCBjYXVzZSBhbnkgbWVt
b3J5IGNvcnJ1cHRpb24sIHJpZ2h0Pw0KSW4gdGhlIHdvcnN0IGNhc2UgKHdyYXBhcm91bmQpIGJw
ZiB3aWxsIHJlYWQgc29tZSB2YWxpZCBkYXRhIGZyb20gdGhlDQp1bmV4cGVjdGVkIGxvY2F0aW9u
IGluIHRoZSBwYWNrZXQgaW5zdGVhZCBvZiBzaW1wbHkgcmV0dXJuaW5nIDAuDQpCVFcsIEkgdGhp
bmsgd2Ugc3RpbGwgbmVlZCB0byBhZGQgY2hlY2sgZm9yIG92ZXJmbG93IGluIF9fcnRlX3BrdG1i
dWZfcmVhZCgpIC0NCmJwZiBqaXQgaXMgbm90IHRoZSBvbmx5IHVzZXIgb2YgaXQuIA0KVW5sZXNz
LCBvZi1jb3Vyc2UsIHdlIHdhbnQgcnRlX3BrdG1idWZfcmVhZCgpIHRvIHdvcmsgd2l0aCB3cmFw
cGVkLWFyb3VuZCB2YWx1ZXMuIA0KDQo+ID4NCj4gPiBJIGRvbid0IGtub3cgaWYgaXQncyB0aGUg
c3VtIG9mIHNyYytpbW0gdGhhdCBkZXRlcm1pbmVzIHNwZWNpYWwgbWVhbmluZywgb3IgaXQncw0K
PiB0aGUgaW1tIGl0c2VsZi4NCj4gPiBJZiBpdCdzIHRoZSBpbW0gaXRzZWxmLCBhIHNpbXBsZSBm
aXggd291bGQgYmUgdG8gdXBkYXRlIHRoZSB2YWxpZGF0b3IncyAuaW1tLm1heA0KPiB2YWx1ZXMg
Zm9yIEJQRl9JTkQNCj4gPiBmcm9tIFVJTlQzMl9NQVggdG8gSU5UMzJfTUFYLg0KPiA+DQo+IA0K
PiBFdmVuIGlmIHdlIGRvIGl0IChJIGhhdmUgbm8gcGFydGljdWxhciBvcGluaW9uKSwgaXQgd29u
J3QgcHJldmVudCBzdW0gb2YgNjQtYml0DQo+IHJlZ2lzdGVyIGFuZCBpbW1lZGlhdGUgZnJvbSBi
ZWluZyBuZWdhdGl2ZSBvciBncmVhdGVyIHRoYW4gdGhlIHJhbmdlIG9mIHZhbHVlcw0KPiBzdXBw
b3J0ZWQgYnkgMzItYml0IGFyZ3VtZW50IG9mIF9fcnRlX3BrdG1idWZfcmVhZC4NCg==
