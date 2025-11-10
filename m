Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272AACCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 10:25:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 611804026D;
	Mon, 10 Nov 2025 11:25:45 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id F218C400D6
 for <dev@dpdk.org>; Mon, 10 Nov 2025 11:25:44 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4m5705D0zJ46s7;
 Mon, 10 Nov 2025 18:25:15 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 1DC81140257;
 Mon, 10 Nov 2025 18:25:44 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 10:25:43 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 10 Nov 2025 10:25:43 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: David Marchand <david.marchand@redhat.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
CC: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Ola Liljedahl <ola.liljedahl@arm.com>, Dhruv Tripathi
 <dhruv.tripathi@arm.com>
Subject: RE: [PATCH v2 1/1] ring: safe partial ordering for head/tail update
Thread-Topic: [PATCH v2 1/1] ring: safe partial ordering for head/tail update
Thread-Index: AQHcM8PjEkYGhEvMM0eJIFohOEcAbbS36DDQgAh4pACAJSK0gIAGbN4Q
Date: Mon, 10 Nov 2025 10:25:43 +0000
Message-ID: <7b9710689ad44caba2c9868967ac97d7@huawei.com>
References: <20251002174137.3612042-1-wathsala.vithanage@arm.com>
 <20251002174137.3612042-2-wathsala.vithanage@arm.com>
 <cfc073b8137541f1be3e01650d6bcf14@huawei.com>
 <566b4c6c-f081-4db8-bc8b-2a576a82e1c3@arm.com>
 <CAJFAV8yumnbPjakBAtkoqrZvWCo90F51Ri9Eje44sAmm_S43gw@mail.gmail.com>
In-Reply-To: <CAJFAV8yumnbPjakBAtkoqrZvWCo90F51Ri9Eje44sAmm_S43gw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.192.108]
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

DQpIaSBEYXZpZCwNCg0KPiANCj4gSGVsbG8gV2F0aHNhbGEsDQo+IA0KPiBPbiBNb24sIDEzIE9j
dCAyMDI1IGF0IDIwOjEwLCBXYXRoc2FsYSBWaXRoYW5hZ2UNCj4gPHdhdGhzYWxhLnZpdGhhbmFn
ZUBhcm0uY29tPiB3cm90ZToNCj4gPiA+IExHVE0sIHRob3VnaC4gSSB0aGluayB0aGF0IHdlIGFs
c28gbmVlZCB0byBtYWtlIHNpbWlsYXIgY2hhbmdlcyBpbg0KPiA+ID4gcnRlX3JpbmdfaHRzX2Vs
ZW1fcHZ0LmggYW5kIHJ0ZV9yaW5nX3J0c19lbGVtX3B2dC5oOg0KPiA+ID4gZm9yIENBUyB1c2Ug
J2FjcV9yZWwnIG9yZGVyIGluc3RlYWQgb2Ygc2ltcGxlICdhY3F1aXJlJy4NCj4gPiA+IExldCBt
ZSBrbm93IHdvdWxkIHlvdSBoYXZlIGEgYmFuZHdpZHRoIHRvIGRvIHRoYXQuDQo+ID4NCj4gPiBN
eSBiYWQsIEkgZm9yZ290IHRob3NlIHR3byBjYXNlcy4gSSB3aWxsIHNlbmQgYSB2My4NCj4gDQo+
IFNob3VsZCB3ZSB3YWl0IGZvciB0aGlzIHYzPw0KPiBXZSB3YW50IHRvIGNsb3NlIHJjMiB0aGlz
IHdlZWsuDQo+IA0KDQpKdXN0IHN1Ym1pdHRlZCB2MyB3aXRoIGRpc2N1c3NlZCBleHRyYSBjaGFu
Z2VzLg0KQWxzbyBhZGRlZCBmaXhlcywgY2MgdG8gc3RhYmxlLCBldGMuDQpIb3BlIGl0IHN0aWxs
IGNhbiBtYWtlIDI1LjExDQpXYXRoc2FsYSwgcGxzIHNob3V0IG9yIHN1Ym1pdCB2NCBpZiB5b3Ug
ZmVlbCBzb21ldGhpbmcgaXMgbWlzc2luZy4NClRoYW5rcw0KS29uc3RhbnRpbiANCg0K
