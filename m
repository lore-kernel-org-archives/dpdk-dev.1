Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39905FF886F
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 May 2026 12:55:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 775CF40655;
	Mon,  4 May 2026 14:55:33 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 359E5402B2
 for <dev@dpdk.org>; Mon,  4 May 2026 14:55:32 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g8M6j4N6tzHnGhb;
 Mon,  4 May 2026 20:54:37 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 569EB40574;
 Mon,  4 May 2026 20:55:31 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 4 May 2026 13:55:30 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 4 May 2026 13:55:30 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
CC: David Marchand <david.marchand@redhat.com>
Subject: RE: [PATCH] ring: add cache guard after ring elements table
Thread-Topic: [PATCH] ring: add cache guard after ring elements table
Thread-Index: AQHc0XkQlTcfmwaszE+wFaHNWAZ9L7X358TAgAAS8tCAArdBsA==
Date: Mon, 4 May 2026 12:55:30 +0000
Message-ID: <452224d4ef25481b938a10b3d82b69a5@huawei.com>
References: <20260421102358.118204-1-mb@smartsharesystems.com>
 <e1fa27a3450f4bc5ab0c12bcfb07f694@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65835@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65835@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.175.232]
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

DQoNCj4gPiA+IEFkZGVkIGNhY2hlIGd1YXJkIGFmdGVyIHRoZSB0YWJsZSBob2xkaW5nIHRoZSBy
aW5nIGVsZW1lbnRzLCB0byBhdm9pZA0KPiA+ID4gZmFsc2Ugc2hhcmluZyBjb25mbGljdHMgY2F1
c2VkIGJ5IG5leHQtbGluZSBoYXJkd2FyZSBwcmVmZXRjaGVycyB3aGVuDQo+ID4gPiBhY2Nlc3Np
bmcgZWxlbWVudHMgYXQgdGhlIGVuZCBvZiB0aGUgcmluZyB0YWJsZS4NCj4gPg0KPiA+IEkgZG9u
J3Qgc2VlIGFueSBoYXJtIHdpdGggaXQsIGFuZCBpbiB0aGVvcnkgaXQgbWlnaHQgaGVscCBpbiBz
b21lDQo+ID4gY2FzZXMuLi4NCj4gPiBUaG91Z2ggSSB3b25kZXIgaG93IHJlYWwgaXMgdGhhdCBw
cm9ibGVtPw0KPiA+IERpZCB5b3UgZXZlciBvYnNlcnZlIHN1Y2ggY29udGVudGlvbiB0byBoYXBw
ZW4/DQo+IA0KPiBJIG5ldmVyIG9ic2VydmVkIGEgcHJvYmxlbSB3aXRoIHRoaXMuDQo+IFRoZSBy
aXNrIG9mIGNvbnRlbnRpb24gZGVwZW5kcyBvbiB3aGF0IGlzIGFsbG9jYXRlZCBpbiB0aGUgbWVt
b3J5IGFmdGVyIHRoZSByaW5nLg0KPiBXaGljaCBpcyBhcHBsaWNhdGlvbiBzcGVjaWZpYy4NCj4g
DQo+IEl0IHNlZW1zIGxpa2UgYSBwdXJlbHkgdGhlb3JldGljYWwgaXNzdWUsIGJ1dCBzaG91bGQg
YmUgZml4ZWQgYW55d2F5LCB0byBlbGltaW5hdGUNCj4gdGhhdCByaXNrLg0KDQpPaywgYXMgSSBz
YWlkIEkgc2VlIG5vIGhhcm0gd2l0aCBpdC4NClNob3VsZCB3ZSBkb2N1bWVudCB0aGlzIGNoYW5n
ZSBzb21ld2hlcmU/IFJOIG9yIFBHPw0KQWNrZWQtYnk6IEtvbnN0YW50aW4gQW5hbnlldiA8a29u
c3RhbnRpbi5hbmFueWV2QGh1YXdlaS5jb20+DQoNCj4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
TW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCj4gPiA+IC0tLQ0KPiA+
ID4gIGxpYi9yaW5nL3J0ZV9yaW5nLmMgfCAzICsrKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKykNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvbGliL3JpbmcvcnRlX3Jp
bmcuYyBiL2xpYi9yaW5nL3J0ZV9yaW5nLmMNCj4gPiA+IGluZGV4IGYxMDA1MGExYzQuLjljY2M2
MmNkNDIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9saWIvcmluZy9ydGVfcmluZy5jDQo+ID4gPiArKysg
Yi9saWIvcmluZy9ydGVfcmluZy5jDQo+ID4gPiBAQCAtNzMsOCArNzMsMTEgQEAgcnRlX3Jpbmdf
Z2V0X21lbXNpemVfZWxlbSh1bnNpZ25lZCBpbnQgZXNpemUsDQo+ID4gdW5zaWduZWQNCj4gPiA+
IGludCBjb3VudCkNCj4gPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+ID4gIAl9DQo+ID4gPg0K
PiA+ID4gKwlzdGF0aWNfYXNzZXJ0KHNpemVvZihzdHJ1Y3QgcnRlX3JpbmcpID09DQo+ID4gPiBS
VEVfQ0FDSEVfTElORV9ST1VORFVQKHNpemVvZihzdHJ1Y3QgcnRlX3JpbmcpKSwNCj4gPiA+ICsJ
CQkiU2l6ZSBvZiBzdHJ1Y3QgcnRlX3Jpbmcgbm90IGNhY2hlIGxpbmUgYWxpZ25lZCIpOw0KPiA+
ID4gIAlzeiA9IHNpemVvZihzdHJ1Y3QgcnRlX3JpbmcpICsgKHNzaXplX3QpY291bnQgKiBlc2l6
ZTsNCj4gPiA+ICAJc3ogPSBSVEVfQUxJR04oc3osIFJURV9DQUNIRV9MSU5FX1NJWkUpOw0KPiA+
ID4gKwlzeiArPSBSVEVfQ0FDSEVfR1VBUkRfTElORVMgKiBSVEVfQ0FDSEVfTElORV9TSVpFOw0K
PiA+ID4gIAlyZXR1cm4gc3o7DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+IC0tDQo+ID4gPiAyLjQz
LjANCg0K
