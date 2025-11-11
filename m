Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B5BCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 16:39:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9197D402B0;
	Tue, 11 Nov 2025 17:39:43 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 557C440280
 for <dev@dpdk.org>; Tue, 11 Nov 2025 17:39:42 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5XLM14CyzHnGj5;
 Wed, 12 Nov 2025 00:39:23 +0800 (CST)
Received: from frapema500001.china.huawei.com (unknown [7.182.19.243])
 by mail.maildlp.com (Postfix) with ESMTPS id 93C2B1402FB;
 Wed, 12 Nov 2025 00:39:40 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500001.china.huawei.com (7.182.19.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Nov 2025 17:39:40 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Tue, 11 Nov 2025 17:39:40 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Jerin Jacob <jerinjacobk@gmail.com>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Stephen Hemminger
 <stephen@networkplumber.org>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 1/3] bpf: fix signed shift overflows in ARM JIT
Thread-Topic: [PATCH 1/3] bpf: fix signed shift overflows in ARM JIT
Thread-Index: AQHcUlcr87G/2RlxX0m9Gw4mx1QmwbTs8noAgABNFRCAAFwvgIAAEVuw
Date: Tue, 11 Nov 2025 16:39:40 +0000
Message-ID: <c1b06e0bf9084c93a52096ca5000290b@huawei.com>
References: <20251110153046.63518-1-marat.khalili@huawei.com>
 <20251110153046.63518-2-marat.khalili@huawei.com>
 <CALBAE1O2VtvLV06-4hPCb5qHsRzqDM1iWWOaRcPKu9L-NMu2qg@mail.gmail.com>
 <e99e848a439e46c4bf9092c2c83de2a8@huawei.com>
 <CALBAE1OW-zbiJKQOgTOeEyE6R6CtGAfF__okaEypWMkt7hBENA@mail.gmail.com>
In-Reply-To: <CALBAE1OW-zbiJKQOgTOeEyE6R6CtGAfF__okaEypWMkt7hBENA@mail.gmail.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZXJpbiBKYWNvYiA8amVyaW5q
YWNvYmtAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5IDExIE5vdmVtYmVyIDIwMjUgMTY6MzEN
Cj4gVG86IE1hcmF0IEtoYWxpbGkgPG1hcmF0LmtoYWxpbGlAaHVhd2VpLmNvbT4NCj4gQ2M6IEtv
bnN0YW50aW4gQW5hbnlldiA8a29uc3RhbnRpbi5hbmFueWV2QGh1YXdlaS5jb20+OyBTdGVwaGVu
IEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+Ow0KPiBkZXZAZHBkay5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGJwZjogZml4IHNpZ25lZCBzaGlmdCBvdmVyZmxv
d3MgaW4gQVJNIEpJVA0KPiANCj4gT24gVHVlLCBOb3YgMTEsIDIwMjUgYXQgMzo0MOKAr1BNIE1h
cmF0IEtoYWxpbGkgPG1hcmF0LmtoYWxpbGlAaHVhd2VpLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+
IE9uIE1vbiwgTm92IDEwLCAyMDI1IGF0IDk6MDHigK9QTSBNYXJhdCBLaGFsaWxpIDxtYXJhdC5r
aGFsaWxpQGh1YXdlaS5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBMZWZ0IHNoaWZ0cyBv
ZiBpbnRlZ2VyIGxpdGVyYWxzIGFuZCBib29sIHZhbHVlcyBvdmVyd3JpdGluZyB0aGUgc2lnbiBi
aXQNCj4gPiA+ID4gd2VyZSB1c2VkIG11bHRpcGxlIHRpbWVzIGluIGJwZl9qaXRfYXJtNjQuYy4g
RS5nLjoNCj4gPiA+ID4NCj4gPiA+ID4gICAgIGluc24gPSAoISFpczY0KSA8PCAzMTsNCj4gPiA+
ID4NCj4gPiA+ID4gd2hlcmUgaXM2NCBoYXMgdHlwZSBib29sIChkb3VibGUgYmFuZyBpcyBhIG5v
LW9wIGhlcmUpLiBUaGUgb3BlcmFuZCBvZg0KPiA+ID4gPiBsZWZ0IHNoaWZ0IHdhcyBwcm9tb3Rl
ZCB0byB0eXBlIGludCwgd2hpY2ggd2hlbiAzMi1iaXQgd2lkZSBjYW5ub3QNCj4gPiA+ID4gcmVw
cmVzZW50IHRoZSByZXN1bHQuIFNpbWlsYXJseSBsaXRlcmFsIGludGVnZXJzIGhhdmUgaW50IHR5
cGUgYnkNCj4gPiA+ID4gZGVmYXVsdC4gIFNhbml0aXplciBwcm9kdWNlZCB0aGUgZm9sbG93aW5n
IGRpYWdub3N0aWMgZHVyaW5nIHJ1bnRpbWUNCj4gPiA+ID4gKGZvciB2YXJpb3VzIGxpbmVzKToN
Cj4gPiA+ID4NCj4gPiA+ID4gICAgIGxpYi9icGYvYnBmX2ppdF9hcm02NC5jOjI0MToxODogcnVu
dGltZSBlcnJvcjogbGVmdCBzaGlmdCBvZiAxIGJ5IDMxDQo+ID4gPiA+ICAgICBwbGFjZXMgY2Fu
bm90IGJlIHJlcHJlc2VudGVkIGluIHR5cGUgJ2ludCcNCj4gPiA+DQo+ID4gPiBXb25kZXIgd2h5
IG5vbmUgb2YgdGhlIHRlc3RzIGluIGFwcC90ZXN0L3Rlc3RfYnBmLmMgYWJsZSB0byBjYXRjaA0K
PiA+ID4gdGhpcz8gVGhlIGdlbmVyYXRlZCBBUk0gb3Bjb2RlIGxvb2tzIE9LIChvdGhlcndpc2Ug
dGVzdHMgd29udCBwYXNzKS4NCj4gPiA+IENvdWxkIHlvdSBjaGVjayB3aGF0IGlzIG1pc3Npbmcg
aW4gdGhlIGFwcC90ZXN0L3Rlc3RfYnBmLmM/DQo+ID4NCj4gPiBUaGF0IHRlc3RzIGRvIHRyaWdn
ZXIgaXQuDQo+ID4NCj4gPiBSVEU+PmJwZl9hdXRvdGVzdA0KPiA+IC4uLy4uL3NyYy9saWIvYnBm
L2JwZl9qaXRfYXJtNjQuYzozMjA6MTg6IHJ1bnRpbWUgZXJyb3I6IGxlZnQgc2hpZnQgb2YgMSBi
eSAzMSBwbGFjZXMgY2Fubm90IGJlDQo+IHJlcHJlc2VudGVkIGluIHR5cGUgJ2ludCcNCj4gDQo+
IFRoaXMgaXMgd2hlbiBBU0FOIGlzIGVuYWJsZWQuIFJpZ2h0Pw0KDQpNb3JlIGxpa2VseSBVQlNB
TiwgYnV0IHllcy4NCg0KPiBJcyBpdCByZWFsbHkgZ2VuZXJhdGluZyBCQUQNCj4gb3Bjb2RlKGku
ZSBlbWl0ZXIgZ2VuZXJhdGluZyBiYWQgT1Bjb2RlKSBhbmQgdGVzdCBmYWlscz8NCg0KSWYgYWxs
b3dlZCB0byBmaW5pc2ggdGhlIHRlc3QgZG9lcyBub3QgZmFpbC4NCkhvd2V2ZXIsIEkgaGF2ZSBu
b3QgY29tcGFyZWQgRFBESyBvciBKSVQgY29tcGlsZWQgY29kZSB3aXRoIGFuZCB3aXRob3V0IGNo
YW5nZXMuDQo=
