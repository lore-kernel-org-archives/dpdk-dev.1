Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F389C54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 11:26:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63E8E427B6;
	Wed, 21 May 2025 13:26:16 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id A827E40041;
 Wed, 21 May 2025 13:26:14 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2TcJ5SSRz6L54Q;
 Wed, 21 May 2025 19:25:20 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
 by mail.maildlp.com (Postfix) with ESMTPS id 9E2661400F4;
 Wed, 21 May 2025 19:26:13 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 May 2025 13:26:13 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 21 May 2025 13:26:13 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: "pbhagavatula@marvell.com" <pbhagavatula@marvell.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>,
 "erik.g.carrillo@intel.com" <erik.g.carrillo@intel.com>,
 "mb@smartsharesystems.com" <mb@smartsharesystems.com>, "jerinj@marvell.com"
 <jerinj@marvell.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] eal: fix return value of lcore role
Thread-Topic: [PATCH] eal: fix return value of lcore role
Thread-Index: AQHbycROpJg3qFKLdku72Ez8QXY6grPc8ovA
Date: Wed, 21 May 2025 11:26:13 +0000
Message-ID: <77ea61e96ce54cbeb46eb440e30fd19e@huawei.com>
References: <20250520201726.7420-1-pbhagavatula@marvell.com>
In-Reply-To: <20250520201726.7420-1-pbhagavatula@marvell.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.73]
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

DQoNCj4gDQo+IEZyb206IFBhdmFuIE5pa2hpbGVzaCA8cGJoYWdhdmF0dWxhQG1hcnZlbGwuY29t
Pg0KPiANCj4gVXBkYXRlIHJ0ZV9sY29yZV9oYXNfcm9sZSgpIHRvIHJldHVybiBmYWxzZSBpbnN0
ZWFkIG9mIGENCj4gbmVnYXRpdmUgdmFsdWUgZm9yIGludmFsaWQgbGNvcmUgSURzLCByZW1vdmlu
ZyB0aGUgbmVlZA0KPiBmb3IgY2FsbGVycyB0byBwcmUtdmFsaWRhdGUgdGhlIElELg0KPiANCj4g
Rml4ZXM6IGIwYTE1MDJhMjc3YyAoImVhbDogbWFrZSBzZW1hbnRpY3Mgb2YgbGNvcmUgcm9sZSBm
dW5jdGlvbiBtb3JlIGludHVpdGl2ZSIpDQo+IENjOiBzdGFibGVAZHBkay5vcmcNCj4gDQo+IFN1
Z2dlc3RlZC1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogUGF2YW4gTmlraGlsZXNoIDxwYmhhZ2F2YXR1bGFAbWFydmVsbC5jb20+
DQo+IC0tLQ0KPiAgbGliL2VhbC9jb21tb24vZWFsX2NvbW1vbl9sY29yZS5jIHwgMiArLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvbGliL2VhbC9jb21tb24vZWFsX2NvbW1vbl9sY29yZS5jIGIvbGliL2VhbC9jb21t
b24vZWFsX2NvbW1vbl9sY29yZS5jDQo+IGluZGV4IDI5NDI2NzE3N2QuLjlkZDZjNzIwNTUgMTAw
NjQ0DQo+IC0tLSBhL2xpYi9lYWwvY29tbW9uL2VhbF9jb21tb25fbGNvcmUuYw0KPiArKysgYi9s
aWIvZWFsL2NvbW1vbi9lYWxfY29tbW9uX2xjb3JlLmMNCj4gQEAgLTg3LDcgKzg3LDcgQEAgcnRl
X2xjb3JlX2hhc19yb2xlKHVuc2lnbmVkIGludCBsY29yZV9pZCwgZW51bSBydGVfbGNvcmVfcm9s
ZV90IHJvbGUpDQo+ICAJc3RydWN0IHJ0ZV9jb25maWcgKmNmZyA9IHJ0ZV9lYWxfZ2V0X2NvbmZp
Z3VyYXRpb24oKTsNCj4gDQo+ICAJaWYgKGxjb3JlX2lkID49IFJURV9NQVhfTENPUkUpDQo+IC0J
CXJldHVybiAtRUlOVkFMOw0KPiArCQlyZXR1cm4gMDsNCj4gDQo+ICAJcmV0dXJuIGNmZy0+bGNv
cmVfcm9sZVtsY29yZV9pZF0gPT0gcm9sZTsNCj4gIH0NCj4gLS0NCg0KQWNrZWQtYnk6IEtvbnN0
YW50aW4gQW5hbnlldiA8a29uc3RhbnRpbi5hbmFueWV2QGh1YXdlaS5jb20+DQogDQo+IDIuNDMu
MA0KDQo=
