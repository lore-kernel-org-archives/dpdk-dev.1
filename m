Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9F0FF887E
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 16:36:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3800D4066C;
	Wed, 29 Apr 2026 18:36:03 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 8D95C400EF;
 Wed, 29 Apr 2026 18:36:01 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g5NGL4fQ8zJ468F;
 Thu, 30 Apr 2026 00:35:54 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id 7790A40570;
 Thu, 30 Apr 2026 00:36:00 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Apr 2026 17:36:00 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 29 Apr 2026 17:36:00 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Shani Peretz <shperetz@nvidia.com>, "Thomas
 Monjalon" <thomas@monjalon.net>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] mbuf: fix mbuf operations history recording
Thread-Topic: [PATCH] mbuf: fix mbuf operations history recording
Thread-Index: AQHc0EmplZUi2H/I7kyjBultZ4gZULX2S4ZQ
Date: Wed, 29 Apr 2026 16:35:59 +0000
Message-ID: <d2df72bd1f7e46629511bbfb63612c05@huawei.com>
References: <20260419221220.86455-1-mb@smartsharesystems.com>
In-Reply-To: <20260419221220.86455-1-mb@smartsharesystems.com>
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

DQo+IFRoaXMgYWRkcmVzc2VzIHR3byBidWdzIGluIG1idWYgb3BlcmF0aW9ucyBoaXN0b3J5IHJl
Y29yZGluZy4NCj4gDQo+IDEuIFdpdGggbWJ1ZiBvcGVyYXRpb25zIGhpc3RvcnkgcmVjb3JkaW5n
IGVuYWJsZWQsIHdoZW4gYWxsb2NhdGluZyBtYnVmcw0KPiBmcm9tIGEgbWVtcG9vbCBmYWlsZWQs
IHRoZSBhcnJheSBvZiBmZXRjaGVkIG1idWYgcG9pbnRlcnMgd2FzIG5vdCBzZXQsIGJ1dA0KPiBp
dCB3YXMgZGVyZWZlcmVuY2VkIGZvciBtYnVmIG9wZXJhdGlvbnMgaGlzdG9yeSByZWNvcmRpbmcg
YW55d2F5LCB3aGljaA0KPiB3b3VsZCB0cmlnZ2VyIGEgc2VnbWVudGF0aW9uIGZhdWx0IG9yIGNh
dXNlIHVuZGVmaW5lZCBiZWhhdmlvci4NCj4gDQo+IFRoaXMgd2FzIGZpeGVkIGJ5IGNoYW5naW5n
IGhvdyB0aGUgcmV0dXJuIHZhbHVlIGZyb20gdGhlIG1lbXBvb2wNCj4gYWxsb2NhdGlvbiBpcyBj
aGVja2VkLCBzbyB0aGUgZnVuY3Rpb24gcmV0dXJucyBlYXJseSBvbiBmYWlsdXJlLCBhbmQgb25s
eQ0KPiBwcm9jZWVkcyBvbiBzdWNjZXNzLg0KPiANCj4gMi4gV2hlbiBhbGxvY2F0aW5nIGEgYnVs
ayBvZiBtYnVmcyB1c2luZyBydGVfcGt0bWJ1Zl9hbGxvY19idWxrKCksIHR3bw0KPiBtYnVmIGxp
YnJhcnkgYWxsb2NhdGlvbiBvcGVyYXRpb25zIHdlcmUgcmVjb3JkZWQgb24gdGhlIG1idWYsIGJl
Y2F1c2UgdGhlDQo+IGZ1bmN0aW9uIGNhbGxzIHJ0ZV9tYnVmX3Jhd19hbGxvY19idWxrKCkgZm9y
IGFsbG9jYXRpb24sIGFuZCBib3RoDQo+IGZ1bmN0aW9ucyByZWNvcmQgYSBtYnVmIGxpYnJhcnkg
YWxsb2NhdGlvbiBvcGVyYXRpb24uDQo+IA0KPiBUaGlzIHdhcyBmaXhlZCBieSBub3QgcmVjb3Jk
aW5nIGEgbWJ1ZiBsaWJyYXJ5IGFsbG9jYXRpb24gb3BlcmF0aW9uIGluDQo+IHJ0ZV9wa3RtYnVm
X2FsbG9jX2J1bGsoKS4NCj4gDQo+IEZpeGVzOiBkMjY1YTI0YTMyYTQgKCJtYnVmOiByZWNvcmQg
bWJ1ZiBvcGVyYXRpb25zIGhpc3RvcnkiKQ0KPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0K
PiAtLS0NCj4gIGxpYi9tYnVmL3J0ZV9tYnVmLmggfCAxMiArKysrKy0tLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvbGliL21idWYvcnRlX21idWYuaCBiL2xpYi9tYnVmL3J0ZV9tYnVmLmgNCj4gaW5kZXgg
ZTdjM2JiYWRkNC4uNjBlYzgxNThjZCAxMDA2NDQNCj4gLS0tIGEvbGliL21idWYvcnRlX21idWYu
aA0KPiArKysgYi9saWIvbWJ1Zi9ydGVfbWJ1Zi5oDQo+IEBAIC02NjMsMTQgKzY2MywxNCBAQCBz
dGF0aWMgX19ydGVfYWx3YXlzX2lubGluZSBpbnQNCj4gIHJ0ZV9tYnVmX3Jhd19hbGxvY19idWxr
KHN0cnVjdCBydGVfbWVtcG9vbCAqbXAsIHN0cnVjdCBydGVfbWJ1ZiAqKm1idWZzLA0KPiB1bnNp
Z25lZCBpbnQgY291bnQpDQo+ICB7DQo+ICAJaW50IHJjID0gcnRlX21lbXBvb2xfZ2V0X2J1bGso
bXAsICh2b2lkICoqKW1idWZzLCBjb3VudCk7DQo+IC0JaWYgKGxpa2VseShyYyA9PSAwKSkgew0K
PiAtCQlmb3IgKHVuc2lnbmVkIGludCBpZHggPSAwOyBpZHggPCBjb3VudDsgaWR4KyspDQo+IC0J
CQlfX3J0ZV9tYnVmX3Jhd19zYW5pdHlfY2hlY2tfbXAobWJ1ZnNbaWR4XSwgbXApOw0KPiAtCX0N
Cj4gKwlpZiAodW5saWtlbHkocmMpKQ0KPiArCQlyZXR1cm4gcmM7DQo+ICsJZm9yICh1bnNpZ25l
ZCBpbnQgaWR4ID0gMDsgaWR4IDwgY291bnQ7IGlkeCsrKQ0KPiArCQlfX3J0ZV9tYnVmX3Jhd19z
YW5pdHlfY2hlY2tfbXAobWJ1ZnNbaWR4XSwgbXApOw0KPiANCj4gIAlydGVfbWJ1Zl9oaXN0b3J5
X21hcmtfYnVsayhtYnVmcywgY291bnQsDQo+IFJURV9NQlVGX0hJU1RPUllfT1BfTElCX0FMTE9D
KTsNCj4gDQo+IC0JcmV0dXJuIHJjOw0KPiArCXJldHVybiAwOw0KPiAgfQ0KPiANCj4gIC8qKg0K
PiBAQCAtMTA2OCw4ICsxMDY4LDYgQEAgc3RhdGljIGlubGluZSBpbnQgcnRlX3BrdG1idWZfYWxs
b2NfYnVsayhzdHJ1Y3QNCj4gcnRlX21lbXBvb2wgKnBvb2wsDQo+ICAJaWYgKHVubGlrZWx5KHJj
KSkNCj4gIAkJcmV0dXJuIHJjOw0KPiANCj4gLQlydGVfbWJ1Zl9oaXN0b3J5X21hcmtfYnVsayht
YnVmcywgY291bnQsDQo+IFJURV9NQlVGX0hJU1RPUllfT1BfTElCX0FMTE9DKTsNCj4gLQ0KPiAg
CXJ0ZV9tYnVmX3Jhd19yZXNldF9idWxrKHBvb2wsIG1idWZzLCBjb3VudCk7DQo+IA0KPiAgCXJl
dHVybiAwOw0KPiAtLQ0KDQpBY2tlZC1ieTogS29uc3RhbnRpbiBBbmFueWV2IDxrb25zdGFudGlu
LmFuYW55ZXZAaHVhd2VpLmNvbT4NCg0KPiAyLjQzLjANCg0K
