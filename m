Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF2FCA1017
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 01:42:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEBF040264;
	Mon,  8 Sep 2025 03:42:39 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id 8C282400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 03:42:36 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cKqMt0VSpz2CgP5;
 Mon,  8 Sep 2025 09:38:02 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 3ABAB1A0188;
 Mon,  8 Sep 2025 09:42:33 +0800 (CST)
Received: from kwepemn200007.china.huawei.com (7.202.194.130) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Sep 2025 09:42:33 +0800
Received: from kwepemn500008.china.huawei.com (7.202.194.149) by
 kwepemn200007.china.huawei.com (7.202.194.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Sep 2025 09:42:32 +0800
Received: from kwepemn500008.china.huawei.com ([7.202.194.149]) by
 kwepemn500008.china.huawei.com ([7.202.194.149]) with mapi id 15.02.1544.011; 
 Mon, 8 Sep 2025 09:42:32 +0800
From: "wangfeifei (J)" <wangfeifei40@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Feifei Wang
 <wff_light@vip.163.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: =?gb2312?B?u9i4tDogW1Y3IDAwLzE3XSBhZGQtaGluaWMzLVBNRC1kcml2ZXI=?=
Thread-Topic: [V7 00/17] add-hinic3-PMD-driver
Thread-Index: AQHcG756Zwju9nEO2EG04rVmVOUZM7SFC2sAgAOADwA=
Date: Mon, 8 Sep 2025 01:42:32 +0000
Message-ID: <89648e7317b04360b88970178b3bd0bf@huawei.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250902040204.9572-1-wff_light@vip.163.com>
 <20250905211250.4ffab14b@hermes.local>
In-Reply-To: <20250905211250.4ffab14b@hermes.local>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [100.105.34.252]
Content-Type: text/plain; charset="gb2312"
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

DQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhl
bkBuZXR3b3JrcGx1bWJlci5vcmc+IA0Kt6LLzcqxvOQ6IDIwMjXE6jnUwjbI1SAxMjoxMw0KytW8
/sjLOiBGZWlmZWkgV2FuZyA8d2ZmX2xpZ2h0QHZpcC4xNjMuY29tPg0Ks63LzTogZGV2QGRwZGsu
b3JnDQrW98ziOiBSZTogW1Y3IDAwLzE3XSBhZGQtaGluaWMzLVBNRC1kcml2ZXINCg0KT24gVHVl
LCAgMiBTZXAgMjAyNSAxMjowMTozNCArMDgwMA0KRmVpZmVpIFdhbmcgPHdmZl9saWdodEB2aXAu
MTYzLmNvbT4gd3JvdGU6DQoNCj4gVGhlIGhpbmljMyBQTUQgKCoqbGlicnRlX25ldF9oaW5pYzMq
KikgcHJvdmlkZXMgcG9sbCBtb2RlIGRyaXZlciANCj4gc3VwcG9ydCBmb3IgMjVHYnBzLzEwMEdi
cHMvMjAwR2JwcyBIdWF3ZWkgU1B4IHNlcmllcyBOZXR3b3JrIEFkYXB0ZXJzLg0KPiANCj4gdjc6
DQo+IC1yZW1vdmUgdW51c2VkLWZ1bmN0aW9ucw0KDQoNCllvdXIgbWFpbGVyIGdsaXRjaGVkIGFu
ZCBzZW50IGl0IHR3aWNlLg0KW0ZlaWZlaV0gT2ssIFdlIHdpbGwgZG8gc29tZSBjaGFuZ2UgYW5k
IHNlbmQgYWdhaW4gYXMgVjggdmVyc2lvbi4NCg==
