Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA59CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 10:10:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A60A4026D;
	Tue, 11 Nov 2025 11:10:46 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id BBE3C4026A
 for <dev@dpdk.org>; Tue, 11 Nov 2025 11:10:45 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5MjK3d4bzJ46dq;
 Tue, 11 Nov 2025 18:10:13 +0800 (CST)
Received: from frapema500002.china.huawei.com (unknown [7.182.19.148])
 by mail.maildlp.com (Postfix) with ESMTPS id 3CCD3140122;
 Tue, 11 Nov 2025 18:10:44 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500002.china.huawei.com (7.182.19.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Nov 2025 11:10:44 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Tue, 11 Nov 2025 11:10:44 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Jerin Jacob <jerinjacobk@gmail.com>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Stephen Hemminger
 <stephen@networkplumber.org>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 1/3] bpf: fix signed shift overflows in ARM JIT
Thread-Topic: [PATCH 1/3] bpf: fix signed shift overflows in ARM JIT
Thread-Index: AQHcUlcr87G/2RlxX0m9Gw4mx1QmwbTs8noAgABNFRA=
Date: Tue, 11 Nov 2025 10:10:43 +0000
Message-ID: <e99e848a439e46c4bf9092c2c83de2a8@huawei.com>
References: <20251110153046.63518-1-marat.khalili@huawei.com>
 <20251110153046.63518-2-marat.khalili@huawei.com>
 <CALBAE1O2VtvLV06-4hPCb5qHsRzqDM1iWWOaRcPKu9L-NMu2qg@mail.gmail.com>
In-Reply-To: <CALBAE1O2VtvLV06-4hPCb5qHsRzqDM1iWWOaRcPKu9L-NMu2qg@mail.gmail.com>
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

PiBPbiBNb24sIE5vdiAxMCwgMjAyNSBhdCA5OjAx4oCvUE0gTWFyYXQgS2hhbGlsaSA8bWFyYXQu
a2hhbGlsaUBodWF3ZWkuY29tPiB3cm90ZToNCj4gPg0KPiA+IExlZnQgc2hpZnRzIG9mIGludGVn
ZXIgbGl0ZXJhbHMgYW5kIGJvb2wgdmFsdWVzIG92ZXJ3cml0aW5nIHRoZSBzaWduIGJpdA0KPiA+
IHdlcmUgdXNlZCBtdWx0aXBsZSB0aW1lcyBpbiBicGZfaml0X2FybTY0LmMuIEUuZy46DQo+ID4N
Cj4gPiAgICAgaW5zbiA9ICghIWlzNjQpIDw8IDMxOw0KPiA+DQo+ID4gd2hlcmUgaXM2NCBoYXMg
dHlwZSBib29sIChkb3VibGUgYmFuZyBpcyBhIG5vLW9wIGhlcmUpLiBUaGUgb3BlcmFuZCBvZg0K
PiA+IGxlZnQgc2hpZnQgd2FzIHByb21vdGVkIHRvIHR5cGUgaW50LCB3aGljaCB3aGVuIDMyLWJp
dCB3aWRlIGNhbm5vdA0KPiA+IHJlcHJlc2VudCB0aGUgcmVzdWx0LiBTaW1pbGFybHkgbGl0ZXJh
bCBpbnRlZ2VycyBoYXZlIGludCB0eXBlIGJ5DQo+ID4gZGVmYXVsdC4gIFNhbml0aXplciBwcm9k
dWNlZCB0aGUgZm9sbG93aW5nIGRpYWdub3N0aWMgZHVyaW5nIHJ1bnRpbWUNCj4gPiAoZm9yIHZh
cmlvdXMgbGluZXMpOg0KPiA+DQo+ID4gICAgIGxpYi9icGYvYnBmX2ppdF9hcm02NC5jOjI0MTox
ODogcnVudGltZSBlcnJvcjogbGVmdCBzaGlmdCBvZiAxIGJ5IDMxDQo+ID4gICAgIHBsYWNlcyBj
YW5ub3QgYmUgcmVwcmVzZW50ZWQgaW4gdHlwZSAnaW50Jw0KPiANCj4gV29uZGVyIHdoeSBub25l
IG9mIHRoZSB0ZXN0cyBpbiBhcHAvdGVzdC90ZXN0X2JwZi5jIGFibGUgdG8gY2F0Y2gNCj4gdGhp
cz8gVGhlIGdlbmVyYXRlZCBBUk0gb3Bjb2RlIGxvb2tzIE9LIChvdGhlcndpc2UgdGVzdHMgd29u
dCBwYXNzKS4NCj4gQ291bGQgeW91IGNoZWNrIHdoYXQgaXMgbWlzc2luZyBpbiB0aGUgYXBwL3Rl
c3QvdGVzdF9icGYuYz8NCg0KVGhhdCB0ZXN0cyBkbyB0cmlnZ2VyIGl0Lg0KDQpSVEU+PmJwZl9h
dXRvdGVzdA0KLi4vLi4vc3JjL2xpYi9icGYvYnBmX2ppdF9hcm02NC5jOjMyMDoxODogcnVudGlt
ZSBlcnJvcjogbGVmdCBzaGlmdCBvZiAxIGJ5IDMxIHBsYWNlcyBjYW5ub3QgYmUgcmVwcmVzZW50
ZWQgaW4gdHlwZSAnaW50Jw0KICAgICMwIDB4MjJiZjU5YyBpbiBtb3ZfaW1tIC4uLy4uL3NyYy9s
aWIvYnBmL2JwZl9qaXRfYXJtNjQuYzozMjANCiAgICAjMSAweDIyYmZhZTAgaW4gZW1pdF9tb3Zf
aW1tIC4uLy4uL3NyYy9saWIvYnBmL2JwZl9qaXRfYXJtNjQuYzozNzgNCiAgICAjMiAweDIyYzNi
ZmMgaW4gZW1pdCAuLi8uLi9zcmMvbGliL2JwZi9icGZfaml0X2FybTY0LmM6MTMyMQ0KICAgICMz
IDB4MjJjNDMxNCBpbiBfX3J0ZV9icGZfaml0X2FybTY0IC4uLy4uL3NyYy9saWIvYnBmL2JwZl9q
aXRfYXJtNjQuYzoxNDE0DQogICAgIzQgMHgyMjc3NWMwIGluIF9fcnRlX2JwZl9qaXQgLi4vLi4v
c3JjL2xpYi9icGYvYnBmLmM6NDQNCiAgICAjNSAweDIyOGZiZGMgaW4gcnRlX2JwZl9sb2FkIC4u
Ly4uL3NyYy9saWIvYnBmL2JwZl9sb2FkLmM6MTE1DQogICAgIzYgMHg2MzEyZjggaW4gcnVuX3Rl
c3QgLi4vLi4vc3JjL2FwcC90ZXN0L3Rlc3RfYnBmLmM6MzIyNQ0KICAgICM3IDB4NjMxODQ4IGlu
IHRlc3RfYnBmIC4uLy4uL3NyYy9hcHAvdGVzdC90ZXN0X2JwZi5jOjMyNjkNClsuLi5dDQoNClJU
RT4+YnBmX2NvbnZlcnRfYXV0b3Rlc3QNCi4uLy4uL3NyYy9saWIvYnBmL2JwZl9qaXRfYXJtNjQu
YzoyNDE6MTg6IHJ1bnRpbWUgZXJyb3I6IGxlZnQgc2hpZnQgb2YgMSBieSAzMSBwbGFjZXMgY2Fu
bm90IGJlIHJlcHJlc2VudGVkIGluIHR5cGUgJ2ludCcNCiAgICAjMCAweDIyYmYwNGMgaW4gZW1p
dF9hZGRfc3ViX2ltbSAuLi8uLi9zcmMvbGliL2JwZi9icGZfaml0X2FybTY0LmM6MjQxDQogICAg
IzEgMHgyMmJmMjcwIGluIGVtaXRfbW92IC4uLy4uL3NyYy9saWIvYnBmL2JwZl9qaXRfYXJtNjQu
YzoyNjcNCiAgICAjMiAweDIyYmYyYTQgaW4gZW1pdF9tb3ZfNjQgLi4vLi4vc3JjL2xpYi9icGYv
YnBmX2ppdF9hcm02NC5jOjI3Mw0KICAgICMzIDB4MjJjMWE2OCBpbiBlbWl0X3Byb2xvZ3VlX25v
X2NhbGwgLi4vLi4vc3JjL2xpYi9icGYvYnBmX2ppdF9hcm02NC5jOjg4NA0KICAgICM0IDB4MjJj
MWM5YyBpbiBlbWl0X3Byb2xvZ3VlIC4uLy4uL3NyYy9saWIvYnBmL2JwZl9qaXRfYXJtNjQuYzo5
MDQNCiAgICAjNSAweDIyYzMyN2MgaW4gZW1pdCAuLi8uLi9zcmMvbGliL2JwZi9icGZfaml0X2Fy
bTY0LmM6MTEzNg0KICAgICM2IDB4MjJjNDMxNCBpbiBfX3J0ZV9icGZfaml0X2FybTY0IC4uLy4u
L3NyYy9saWIvYnBmL2JwZl9qaXRfYXJtNjQuYzoxNDE0DQogICAgIzcgMHgyMjc3NWMwIGluIF9f
cnRlX2JwZl9qaXQgLi4vLi4vc3JjL2xpYi9icGYvYnBmLmM6NDQNCiAgICAjOCAweDIyOGZiZGMg
aW4gcnRlX2JwZl9sb2FkIC4uLy4uL3NyYy9saWIvYnBmL2JwZl9sb2FkLmM6MTE1DQogICAgIzkg
MHg2MzFlN2MgaW4gdGVzdF9icGZfbWF0Y2ggLi4vLi4vc3JjL2FwcC90ZXN0L3Rlc3RfYnBmLmM6
MzMyOA0KICAgICMxMCAweDYzMmNlOCBpbiB0ZXN0X2JwZl9maWx0ZXJfc2FuaXR5IC4uLy4uL3Ny
Yy9hcHAvdGVzdC90ZXN0X2JwZi5jOjMzNzYNCiAgICAjMTEgMHg2MzMxYzQgaW4gdGVzdF9icGZf
Y29udmVydCAuLi8uLi9zcmMvYXBwL3Rlc3QvdGVzdF9icGYuYzozNDg3DQpbLi4uXQ0K
