Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9AFCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 10:16:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD87240663;
	Wed, 12 Nov 2025 11:16:47 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 5F65B402B0
 for <dev@dpdk.org>; Wed, 12 Nov 2025 11:16:46 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5zp26JVSzHnHFL;
 Wed, 12 Nov 2025 18:16:26 +0800 (CST)
Received: from frapema500002.china.huawei.com (unknown [7.182.19.148])
 by mail.maildlp.com (Postfix) with ESMTPS id BBA551402F1;
 Wed, 12 Nov 2025 18:16:45 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500002.china.huawei.com (7.182.19.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Nov 2025 11:16:45 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 12 Nov 2025 11:16:45 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Jerin Jacob <jerinjacobk@gmail.com>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Stephen Hemminger
 <stephen@networkplumber.org>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 1/3] bpf: fix signed shift overflows in ARM JIT
Thread-Topic: [PATCH 1/3] bpf: fix signed shift overflows in ARM JIT
Thread-Index: AQHcUlcr87G/2RlxX0m9Gw4mx1QmwbTs8noAgABNFRCAAFwvgIAAEVuwgADGi4CAAF6AcA==
Date: Wed, 12 Nov 2025 10:16:45 +0000
Message-ID: <0f7fdd71245e419491ea4047503a9bc6@huawei.com>
References: <20251110153046.63518-1-marat.khalili@huawei.com>
 <20251110153046.63518-2-marat.khalili@huawei.com>
 <CALBAE1O2VtvLV06-4hPCb5qHsRzqDM1iWWOaRcPKu9L-NMu2qg@mail.gmail.com>
 <e99e848a439e46c4bf9092c2c83de2a8@huawei.com>
 <CALBAE1OW-zbiJKQOgTOeEyE6R6CtGAfF__okaEypWMkt7hBENA@mail.gmail.com>
 <c1b06e0bf9084c93a52096ca5000290b@huawei.com>
 <CALBAE1MjtM+kVA31KEcge47F_J8qmUDH_q8eWzYjBZxqVppJiQ@mail.gmail.com>
In-Reply-To: <CALBAE1MjtM+kVA31KEcge47F_J8qmUDH_q8eWzYjBZxqVppJiQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.70]
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

PiA+ID4gPiBUaGF0IHRlc3RzIGRvIHRyaWdnZXIgaXQuDQo+ID4gPiA+DQo+ID4gPiA+IFJURT4+
YnBmX2F1dG90ZXN0DQo+ID4gPiA+IC4uLy4uL3NyYy9saWIvYnBmL2JwZl9qaXRfYXJtNjQuYzoz
MjA6MTg6IHJ1bnRpbWUgZXJyb3I6IGxlZnQgc2hpZnQgb2YgMSBieSAzMSBwbGFjZXMgY2Fubm90
IGJlDQo+ID4gPiByZXByZXNlbnRlZCBpbiB0eXBlICdpbnQnDQo+ID4gPg0KPiA+ID4gVGhpcyBp
cyB3aGVuIEFTQU4gaXMgZW5hYmxlZC4gUmlnaHQ/DQo+ID4NCj4gPiBNb3JlIGxpa2VseSBVQlNB
TiwgYnV0IHllcy4NCj4gPg0KPiA+ID4gSXMgaXQgcmVhbGx5IGdlbmVyYXRpbmcgQkFEDQo+ID4g
PiBvcGNvZGUoaS5lIGVtaXRlciBnZW5lcmF0aW5nIGJhZCBPUGNvZGUpIGFuZCB0ZXN0IGZhaWxz
Pw0KPiA+DQo+ID4gSWYgYWxsb3dlZCB0byBmaW5pc2ggdGhlIHRlc3QgZG9lcyBub3QgZmFpbC4N
Cj4gDQo+IERvZXMgdGhhdCBtZWFuLCBpdCBpcyBhIGZhbHNlIHBvc2l0aXZlPyBSaWdodD8NCg0K
SXQgZGVwZW5kcyBvbiB3aG8geW91IGFzay4gQ2VydGFpbiBjb21waWxlcnMgd2l0aCBjZXJ0YWlu
IGNvbXBpbGF0aW9uIG9wdGlvbnMNCnRlbmQgdG8gZGVsZXRlIGV4ZWN1dGlvbiBicmFuY2hlcyB0
aGF0IGNhdXNlIFVCLCBhbmQgdGhlIHRlc3QgbWF5IG5vdCBiZQ0KZGV0YWlsZWQgZW5vdWdoIHRv
IG5vdGljZSB0aGlzLg0KDQo+IEFueXdheSwgVGhlcmUgaXMgbm8gaGFybSBpbiB0aGUgbmV3IHBh
dGNoLCBDaGFuZ2UgdGhlIHBhdGNoIHRvIHVzZQ0KPiBTSElGVCBtYWNyb3MgZnJvbSBFQUwuDQoN
Ck9rLCB3aWxsIGRvLiBJdCBpcyBwcm9iYWJseSB0b28gbGF0ZSBmb3IgdGhlIGN1cnJlbnQgcmVs
ZWFzZSBhbnl3YXkuDQo=
