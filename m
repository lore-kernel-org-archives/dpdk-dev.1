Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F78CA0FF2
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 13:27:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D99E402BD;
	Wed,  3 Sep 2025 15:27:28 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 37B7940281
 for <dev@dpdk.org>; Wed,  3 Sep 2025 15:27:26 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cH3Kh59KHz6L5DG;
 Wed,  3 Sep 2025 21:26:32 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
 by mail.maildlp.com (Postfix) with ESMTPS id DAA8B14020C;
 Wed,  3 Sep 2025 21:27:25 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Sep 2025 15:27:25 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 3 Sep 2025 15:27:25 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] maintainers: update for packet buffer library
Thread-Topic: [PATCH] maintainers: update for packet buffer library
Thread-Index: AQHcHMIC3g2PvWQXV0CJobCvaRwC7rSBcz5Q
Date: Wed, 3 Sep 2025 13:27:25 +0000
Message-ID: <42276cc4394f4eb59ebfc8e89d16ed83@huawei.com>
References: <20250903110006.44202-1-mb@smartsharesystems.com>
In-Reply-To: <20250903110006.44202-1-mb@smartsharesystems.com>
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

DQo+IEFkZCBteXNlbGYgYXMgbWFpbnRhaW5lciBmb3IgdGhlIHBhY2tldCBidWZmZXIgKG1idWYp
IGxpYnJhcnkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRz
aGFyZXN5c3RlbXMuY29tPg0KPiAtLS0NCj4gIE1BSU5UQUlORVJTIHwgMSArDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBi
L01BSU5UQUlORVJTDQo+IGluZGV4IDdhY2E5OGM1MzcuLmM2NGExMjNlNzYgMTAwNjQ0DQo+IC0t
LSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC00MjksNiArNDI5LDcg
QEAgRjogYXBwL3Rlc3QvdGVzdF9zdGFjayoNCj4gIEY6IGRvYy9ndWlkZXMvcHJvZ19ndWlkZS9z
dGFja19saWIucnN0DQo+IA0KPiAgUGFja2V0IGJ1ZmZlcg0KPiArTTogTW9ydGVuIEJyw7hydXAg
PG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCj4gIEY6IGxpYi9tYnVmLw0KPiAgRjogZG9jL2d1
aWRlcy9wcm9nX2d1aWRlL21idWZfbGliLnJzdA0KPiAgRjogYXBwL3Rlc3QvdGVzdF9tYnVmLmMN
Cj4gLS0NCg0KQWNrZWQtYnk6IEtvbnN0YW50aW4gQW5hbnlldiA8a29uc3RhbnRpbi5hbmFueWV2
QGh1YXdlaS5jb20+DQoNCj4gMi40My4wDQoNCg==
