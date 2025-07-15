Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361DFC83F22
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 15:12:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50342402EE;
	Tue, 15 Jul 2025 17:12:31 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 21414402E3
 for <dev@dpdk.org>; Tue, 15 Jul 2025 17:12:30 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhN1M73rDz6L5Qt;
 Tue, 15 Jul 2025 23:11:03 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
 by mail.maildlp.com (Postfix) with ESMTPS id 04B1914038F;
 Tue, 15 Jul 2025 23:12:12 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Jul 2025 17:12:11 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 15 Jul 2025 17:12:11 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] doc: announce mbuf fast free configuration requirements
Thread-Topic: [PATCH] doc: announce mbuf fast free configuration requirements
Thread-Index: AQHb9AF4UULdn7QJREGq/trONM1rSbQzTW7g
Date: Tue, 15 Jul 2025 15:12:11 +0000
Message-ID: <50e97877dbc7422fbe6ba8e86e9ce2ae@huawei.com>
References: <20250713142127.349940-1-mb@smartsharesystems.com>
In-Reply-To: <20250713142127.349940-1-mb@smartsharesystems.com>
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

DQo+IEZvciBUWCBtYnVmIGZhc3QgcmVsZWFzZSBvZmZsb2FkLCB0aGUgbWJ1ZiBtZW1wb29sIHBv
aW50ZXIgd2lsbCBiZSBhZGRlZA0KPiB0byB0aGUgZXRoZGV2IHR4IHF1ZXVlIGNvbmZpZ3VyYXRp
b24gc3RydWN0dXJlLCBzbyB0aGUgZXRoZGV2IFRYIGJ1cnN0DQo+IG9wZXJhdGlvbiBkb2Vzbid0
IG5lZWQgdG8gZmV0Y2ggaXQgZnJvbSB0aGUgZmlyc3QgbWJ1ZiBvZiBlYWNoIGJ1cnN0IGJlaW5n
DQo+IGZhc3QgZnJlZSdkIHRvIHRoZSBtZW1wb29sLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTW9y
dGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCj4gLS0tDQo+ICBkb2MvZ3Vp
ZGVzL3JlbF9ub3Rlcy9kZXByZWNhdGlvbi5yc3QgfCA2ICsrKysrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RvYy9ndWlkZXMvcmVsX25v
dGVzL2RlcHJlY2F0aW9uLnJzdCBiL2RvYy9ndWlkZXMvcmVsX25vdGVzL2RlcHJlY2F0aW9uLnJz
dA0KPiBpbmRleCBlMmQ0MTI1MzA4Li5hN2I0NTA1YTI0IDEwMDY0NA0KPiAtLS0gYS9kb2MvZ3Vp
ZGVzL3JlbF9ub3Rlcy9kZXByZWNhdGlvbi5yc3QNCj4gKysrIGIvZG9jL2d1aWRlcy9yZWxfbm90
ZXMvZGVwcmVjYXRpb24ucnN0DQo+IEBAIC0xNTIsMyArMTUyLDkgQEAgRGVwcmVjYXRpb24gTm90
aWNlcw0KPiAgKiBidXMvdm1idXM6IFN0YXJ0aW5nIERQREsgMjUuMTEsIGFsbCB0aGUgdm1idXMg
QVBJIGRlZmluZWQgaW4NCj4gICAgYGBkcml2ZXJzL2J1cy92bWJ1cy9ydGVfYnVzX3ZtYnVzLmhg
YCB3aWxsIGJlY29tZSBpbnRlcm5hbCB0byBEUERLLg0KPiAgICBUaG9zZSBBUEkgZnVuY3Rpb25z
IGFyZSB1c2VkIGludGVybmFsbHkgYnkgRFBESyBjb3JlIGFuZCBuZXR2c2MgUE1ELg0KPiArDQo+
ICsqIGV0aGRldjogQ29uZmlndXJpbmcgYSB0cmFuc21pdCBxdWV1ZSBmb3IgZmFzdCBtYnVmIHJl
bGVhc2Ugd2lsbA0KPiArICByZXF1aXJlIHNwZWNpZnlpbmcgd2hpY2ggbWVtcG9vbCB0byBmcmVl
IHRoZSBtYnVmcyB0by4NCj4gKyAgRm9yIHRoaXMsIGEgbmV3IGZpZWxkIGBgc3RydWN0IHJ0ZV9t
ZW1wb29sICptcF9mYXN0X2ZyZWVgYCB3aWxsIGJlDQo+ICsgIGFkZGVkIHRvIGBgc3RydWN0IHJ0
ZV9ldGhfdHhjb25mYGAsIGFuZCBtdXN0IGJlIHNldCB3aGVuIHRoZQ0KPiArICBgYFJURV9FVEhf
VFhfT0ZGTE9BRF9NQlVGX0ZBU1RfRlJFRWBgIG9mZmxvYWQgZmxhZyBpcyBzZXQuDQo+IC0tDQoN
CkFja2VkLWJ5OiBLb25zdGFudGluIEFuYW55ZXYgPGtvbnN0YW50aW4uYW5hbnlldkBodWF3ZWku
Y29tPg0KIA0KDQo+IDIuNDMuMA0KPiANCg0K
