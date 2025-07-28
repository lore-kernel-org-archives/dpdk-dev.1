Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B000AC83F26
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 08:35:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0F8C402E9;
	Mon, 28 Jul 2025 10:35:37 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 81F00400D5
 for <dev@dpdk.org>; Mon, 28 Jul 2025 10:35:36 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4brBZz1hjLz6L5TJ;
 Mon, 28 Jul 2025 16:33:47 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
 by mail.maildlp.com (Postfix) with ESMTPS id 089EC1400D3;
 Mon, 28 Jul 2025 16:35:36 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Jul 2025 10:35:35 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 28 Jul 2025 10:35:35 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Huichao Cai <chcchc88@163.com>, "konstantin.v.ananyev@yandex.ru"
 <konstantin.v.ananyev@yandex.ru>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] acl: fix the value of the trans table
Thread-Topic: [PATCH] acl: fix the value of the trans table
Thread-Index: AQHb/U4E1ExqpzjH+USW2wWj4iz59rRGyjIAgABvSiA=
Date: Mon, 28 Jul 2025 08:35:35 +0000
Message-ID: <7ae2883da6e44e3bb6800bb2f1fa4fd0@huawei.com>
References: <20250725102151.6677-1-chcchc88@163.com>
 <20250728035324.3136-1-chcchc88@163.com>
In-Reply-To: <20250728035324.3136-1-chcchc88@163.com>
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

SGksDQoNCg0KPiBIaSwgS29uc3RhbnRpbg0KPiANCj4gVG8gaWxsdXN0cmF0ZSB0aGlzIGlzc3Vl
LCBJIG1hZGUgdGhlIGZvbGxvd2luZyBtb2RpZmljYXRpb25zIHRvIHRoZSB0ZXN0IGNhc2VzOg0K
PiBNb2RpZnkgdGhlIOKAnHRlc3RfZGF0YeKAnSBjb250ZW50IG9mIHRoZSBmdW5jdGlvbiAidGVz
dF9hY2wuYzogdGVzdF9idWlsZF9wb3J0c19yYW5nZSI6DQo+IGRlbGV0ZSB0aGUgc2Vjb25kIHRl
c3QgZGF0YSwgYW5kIGxlYXZlIG9ubHkgb25lIHRlc3QgbWVzc2FnZSBkYXRhLiBUaGlzIHdheSwg
d2hlbg0KPiB0aGUgZnVuY3Rpb24gImFjbF9ydW5fc2NhbGFyLmM6IHJ0ZV9hY2xfY2xhc3NpZnlf
c2NhbGFyIiBwcm9jZXNzZXMgdGhlIHNlY29uZCBtZXNzYWdlDQo+IGRhdGEsIGl0IHdpbGwgdXNl
IHRoZSBpZGxlIGRhdGEuIFRoZW4gbW9kaWZ5IHRoZSBpZGxlIGRhdGEgaW4gdGhlIGZ1bmN0aW9u
ICJhY2xfcnVuLmg6DQo+IGFjbF9zdGFydF9uZXh0X3RyaWUiIHRvICh0byBtb2RpZnkgdGhlIGlk
bGUsIHRoZSBjb25zdCBhdHRyaWJ1dGUgd2FzIHJlbW92ZWQpOg0KPiBwYXJtc1tuXS5kYXRhID0g
KHVpbnQ4X3QgKilpZGxlOw0KPiBwYXJtc1tuXS5kYXRhWzBdID0gMHgwNDsNCj4gcGFybXNbbl0u
ZGF0YVs0XSA9IDB4MDE7DQo+IFdoZW4gdGhlIGZ1bmN0aW9uICJhY2xfcnVuX3NjYWxhci5jOiBz
Y2FsYXJfdHJhbnNpdGlvbiIgcHJvY2Vzc2luZyB0aGlzIGlkbGUgbWVzc2FnZSwNCj4gYmVjYXVz
ZSB0aGUgcmFuZ2VzIGFyZSAwIGFuZCB0aGUgbWVzc2FnZSBkYXRhIGlzIG5vdCAwKDB4MDEpLCB0
aGUgbWVzc2FnZSBkYXRhIHdpbGwNCj4gZXhjZWVkIGFsbCByYW5nZXMuIFRoZSBjYWxjdWxhdGVk
IHJlc3VsdCB4IGlzIDQsIHdoaWxlIHRoZSBjb3JyZWN0IHJlc3VsdCBzaG91bGQgYmUgMC4gVGhl
DQo+IGZvbGxvd2luZyBpcyBhIGNvbXBhcmlzb24gb2YgdGhlIHNldHRsZW1lbnQgcmVzdWx0cyBv
ZiB4IGJlZm9yZSBhbmQgYWZ0ZXIgbW9kaWZpY2F0aW9uDQo+IChJIGhhdmUgcHJpbnRlZCBlYWNo
IGxpbmUgb2YgdGhlIGNhbGN1bGF0aW9uIHJlc3VsdHMgb2YgdGhlIGZ1bmN0aW9uICJhY2xfcnVu
X3N0Y2FsYXIuIGM6IHNjYWxhcl90cmFuc2xhdGlvbiIpOg0KDQpTb3JyeSwgaXQgaXMgYSBiaXQg
dG9vIGNyeXB0aWMgZm9yIG1lLg0KV2h5IGRvIHlvdSBtb2RpZnkgdGhlIGludGVybmFsIEFDTCB0
YWJsZXMgY29udGVudHM/DQpJZiB5b3UgY2FuLCBwbGVhc2UgY3JlYXRlIGEgbmV3IHRlc3QtY2Fz
ZSBpbiAgYXBwL3Rlc3QvdGVzdF9hY2wuYyB0byBkZW1vbnN0cmF0ZSB0aGUgaXNzdWUuDQpUaGFu
a3MNCktvbnN0YW50aW4gDQoNCj4gPT1iZWZvcmU9PToNCj4gTGluZSA4NzogdHJhbnNpdGlvbjog
MHgyMDAwMDEwMA0KPiBMaW5lIDg4OiByYW5nZXM6IDB4MA0KPiBMaW5lIDg5OiBpbmRleDogMHgy
MDAwMDAwMA0KPiBMaW5lIDkwOiBhZGRyOiAweDEwMA0KPiBMaW5lIDkxOiBpbnB1dDogMHgwDQo+
IExpbmUgOTY6IGM6IDB4MA0KPiBMaW5lIDk5OiBhOiAweDgwODA4MDgwDQo+IExpbmUgMTAyOiBh
OiAweDgwODA4MDgwDQo+IExpbmUgMTA1OiBiOiAweDANCj4gTGluZSAxMDg6IGE6IDB4ODA4MDgw
ODANCj4gTGluZSAxMTE6IGE6IDB4ODA4MDgwODANCj4gTGluZSAxMTQ6IHg6IDB4MA0KPiBMaW5l
IDEyNTogYWRkcjogMHgxMDANCj4gDQo+ID09YWZ0ZXI9PToNCj4gTGluZSA4NzogdHJhbnNpdGlv
bjogMHgyMDAwMDEwMA0KPiBMaW5lIDg4OiByYW5nZXM6IDB4MA0KPiBMaW5lIDg5OiBpbmRleDog
MHgyMDAwMDAwMA0KPiBMaW5lIDkwOiBhZGRyOiAweDEwMA0KPiBMaW5lIDkxOiBpbnB1dDogMHgx
DQo+IExpbmUgOTY6IGM6IDB4MTAxMDEwMQ0KPiBMaW5lIDk5OiBhOiAweDgwODA4MDgwDQo+IExp
bmUgMTAyOiBhOiAweDdmN2Y3ZjdmDQo+IExpbmUgMTA1OiBiOiAweDANCj4gTGluZSAxMDg6IGE6
IDB4MA0KPiBMaW5lIDExMTogYTogMHgwDQo+IExpbmUgMTE0OiB4OiAweDQNCj4gTGluZSAxMjU6
IGFkZHI6IDB4MTA0DQoNCg==
