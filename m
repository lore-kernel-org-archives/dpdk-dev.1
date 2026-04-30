Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660F5CD13D3
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 17:22:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C7C34021F;
	Thu, 30 Apr 2026 19:22:28 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id ED056400D6
 for <dev@dpdk.org>; Thu, 30 Apr 2026 19:22:27 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g61FR0PfszJ46BB;
 Fri,  1 May 2026 01:22:19 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 917C440571;
 Fri,  1 May 2026 01:22:26 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 30 Apr 2026 18:22:26 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 30 Apr 2026 18:22:26 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
CC: David Marchand <david.marchand@redhat.com>
Subject: RE: [PATCH] ring: add cache guard after ring elements table
Thread-Topic: [PATCH] ring: add cache guard after ring elements table
Thread-Index: AQHc0XkQlTcfmwaszE+wFaHNWAZ9L7X358TA
Date: Thu, 30 Apr 2026 17:22:26 +0000
Message-ID: <e1fa27a3450f4bc5ab0c12bcfb07f694@huawei.com>
References: <20260421102358.118204-1-mb@smartsharesystems.com>
In-Reply-To: <20260421102358.118204-1-mb@smartsharesystems.com>
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

DQpIaSBNb3J0ZW4sDQoNCj4gQWRkZWQgY2FjaGUgZ3VhcmQgYWZ0ZXIgdGhlIHRhYmxlIGhvbGRp
bmcgdGhlIHJpbmcgZWxlbWVudHMsIHRvIGF2b2lkDQo+IGZhbHNlIHNoYXJpbmcgY29uZmxpY3Rz
IGNhdXNlZCBieSBuZXh0LWxpbmUgaGFyZHdhcmUgcHJlZmV0Y2hlcnMgd2hlbg0KPiBhY2Nlc3Np
bmcgZWxlbWVudHMgYXQgdGhlIGVuZCBvZiB0aGUgcmluZyB0YWJsZS4NCg0KSSBkb24ndCBzZWUg
YW55IGhhcm0gd2l0aCBpdCwgYW5kIGluIHRoZW9yeSBpdCBtaWdodCBoZWxwIGluIHNvbWUgY2Fz
ZXMuLi4NClRob3VnaCBJIHdvbmRlciBob3cgcmVhbCBpcyB0aGF0IHByb2JsZW0/DQpEaWQgeW91
IGV2ZXIgb2JzZXJ2ZSBzdWNoIGNvbnRlbnRpb24gdG8gaGFwcGVuPw0KDQo+IFNpZ25lZC1vZmYt
Ynk6IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQo+IC0tLQ0KPiAg
bGliL3JpbmcvcnRlX3JpbmcuYyB8IDMgKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbGliL3JpbmcvcnRlX3JpbmcuYyBiL2xpYi9yaW5n
L3J0ZV9yaW5nLmMNCj4gaW5kZXggZjEwMDUwYTFjNC4uOWNjYzYyY2Q0MiAxMDA2NDQNCj4gLS0t
IGEvbGliL3JpbmcvcnRlX3JpbmcuYw0KPiArKysgYi9saWIvcmluZy9ydGVfcmluZy5jDQo+IEBA
IC03Myw4ICs3MywxMSBAQCBydGVfcmluZ19nZXRfbWVtc2l6ZV9lbGVtKHVuc2lnbmVkIGludCBl
c2l6ZSwgdW5zaWduZWQNCj4gaW50IGNvdW50KQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gIAl9
DQo+IA0KPiArCXN0YXRpY19hc3NlcnQoc2l6ZW9mKHN0cnVjdCBydGVfcmluZykgPT0NCj4gUlRF
X0NBQ0hFX0xJTkVfUk9VTkRVUChzaXplb2Yoc3RydWN0IHJ0ZV9yaW5nKSksDQo+ICsJCQkiU2l6
ZSBvZiBzdHJ1Y3QgcnRlX3Jpbmcgbm90IGNhY2hlIGxpbmUgYWxpZ25lZCIpOw0KPiAgCXN6ID0g
c2l6ZW9mKHN0cnVjdCBydGVfcmluZykgKyAoc3NpemVfdCljb3VudCAqIGVzaXplOw0KPiAgCXN6
ID0gUlRFX0FMSUdOKHN6LCBSVEVfQ0FDSEVfTElORV9TSVpFKTsNCj4gKwlzeiArPSBSVEVfQ0FD
SEVfR1VBUkRfTElORVMgKiBSVEVfQ0FDSEVfTElORV9TSVpFOw0KPiAgCXJldHVybiBzejsNCj4g
IH0NCj4gDQo+IC0tDQo+IDIuNDMuMA0KDQo=
