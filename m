Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6D1E9539E
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 13:34:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1B7E402F2;
	Wed,  4 Feb 2026 14:34:00 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 6D72E402E1
 for <dev@dpdk.org>; Wed,  4 Feb 2026 14:33:59 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5h9y1tGczHnGj5;
 Wed,  4 Feb 2026 21:32:54 +0800 (CST)
Received: from dubpeml500003.china.huawei.com (unknown [7.214.146.145])
 by mail.maildlp.com (Postfix) with ESMTPS id A304B40571;
 Wed,  4 Feb 2026 21:33:55 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500003.china.huawei.com (7.214.146.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Feb 2026 13:33:55 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 4 Feb 2026 13:33:55 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Thomas Monjalon <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: Marat Khalili <marat.khalili@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "jerinjacobk@gmail.com" <jerinjacobk@gmail.com>, "mb@smartsharesystems.com"
 <mb@smartsharesystems.com>
Subject: RE: [PATCH v4 0/6] bpf: simple tests and fixes
Thread-Topic: [PATCH v4 0/6] bpf: simple tests and fixes
Thread-Index: AQHcj4McLkdlRFFiNEiQBYHh8ef41LVmDDEAgAxsJ4CAAA3mUA==
Date: Wed, 4 Feb 2026 13:33:55 +0000
Message-ID: <77e90fde34ce4e42a51766b0e356883b@huawei.com>
References: <20251217180141.60227-1-marat.khalili@huawei.com>
 <20260127114944.35993-1-marat.khalili@huawei.com>
 <20260127060244.46b2cee6@phoenix.local> <4487716.QJadu78ljV@thomas>
In-Reply-To: <4487716.QJadu78ljV@thomas>
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

DQoNCj4gMjcvMDEvMjAyNiAxNTowMiwgU3RlcGhlbiBIZW1taW5nZXI6DQo+ID4gT24gVHVlLCAy
NyBKYW4gMjAyNiAxMTo0OTozNiArMDAwMA0KPiA+IE1hcmF0IEtoYWxpbGkgPG1hcmF0LmtoYWxp
bGlAaHVhd2VpLmNvbT4gd3JvdGU6DQo+ID4gPiBNYXJhdCBLaGFsaWxpICg2KToNCj4gPiA+ICAg
ZWFsOiB2YXJpYWJsZSBmaXJzdCBhcmd1bWVudHMgb2YgUlRFX1NISUZUX1ZBTHh4DQo+ID4gPiAg
IGJwZjogZml4IHNpZ25lZCBzaGlmdCBvdmVyZmxvd3MgaW4gQVJNIEpJVA0KPiA+ID4gICBicGY6
IG1hcmsgQVJNIG9wY29kZXMgd2l0aCBVSU5UMzJfQw0KPiA+ID4gICBicGY6IGRpc2FsbG93IGVt
cHR5IHByb2dyYW0NCj4gPiA+ICAgYnBmOiBtYWtlIGFkZC9zdWJ0cmFjdCBvbmUgcHJvZ3JhbSB2
YWxpZGF0ZQ0KPiA+ID4gICBicGY6IGZpeCB2YWxpZGF0aW9uIHdoZW4gY29uZGl0aW9uYWwganVt
cCBpcyBmaXJzdCBpbnN0cnVjdGlvbg0KPiA+ID4NCj4gPiA+ICBhcHAvdGVzdC90ZXN0X2JwZi5j
ICAgICAgICAgIHwgMjU0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4g
PiAgbGliL2JwZi9icGZfaml0X2FybTY0LmMgICAgICB8IDE4NCArKysrKysrKysrKystLS0tLS0t
LS0tLS0tDQo+ID4gPiAgbGliL2JwZi9icGZfbG9hZC5jICAgICAgICAgICB8ICAgMiArLQ0KPiA+
ID4gIGxpYi9icGYvYnBmX3ZhbGlkYXRlLmMgICAgICAgfCAgNDggKysrKy0tLQ0KPiA+ID4gIGxp
Yi9lYWwvaW5jbHVkZS9ydGVfYml0b3BzLmggfCAgIDQgKy0NCj4gPiA+ICA1IGZpbGVzIGNoYW5n
ZWQsIDM3NSBpbnNlcnRpb25zKCspLCAxMTcgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+DQo+ID4g
VGhpcyBpcyB3aGF0IGFuIGF1dG9tYXRlZCByZXZpZXcgbG9va3MgbGlrZSB3aGVuIGV2ZXJ5dGhp
bmcgaXMgZ29vZDoNCj4gDQo+IERvZXMgaXQgbWFrZSB0aGUgYXV0aG9yIGEgZ29vZCBjYW5kaWRh
dGUgdG8gYmUgY28tbWFpbnRhaW5lcj8NCg0KSSBiZWxpZXZlIGl0IGRvZXMgOikNCldpbGwgYXNr
IE1hcmF0IHRvIHN1Ym1pdCB0aGUgcGF0Y2guDQpLb25zdGFudGluDQo=
