Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008BAC3ABC0
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 12:24:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69D684025D;
	Wed,  7 May 2025 14:24:25 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 295AF4025A
 for <dev@dpdk.org>; Wed,  7 May 2025 14:24:23 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZsvX35vM7z6L59n;
 Wed,  7 May 2025 20:21:55 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id D4CD31402FD;
 Wed,  7 May 2025 20:24:22 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 May 2025 14:24:22 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 7 May 2025 14:24:22 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v4 1/2] cmdline: add floating point support
Thread-Topic: [PATCH v4 1/2] cmdline: add floating point support
Thread-Index: AQHbvzcTeT1qaAd3QECXN7tR6Oj62LPG+Myg///ngICAADa1AA==
Date: Wed, 7 May 2025 12:24:22 +0000
Message-ID: <0beab7dd888e4a0cb100a7ef92c90a35@huawei.com>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
 <e8234c26b5dd91aaa9e7b1e38887b1d6fdb2d053.1746612074.git.anatoly.burakov@intel.com>
 <73248ba4775b4b95b117890851b8257e@huawei.com>
 <142c9203-11ee-4310-adfc-7657fc8e224d@intel.com>
In-Reply-To: <142c9203-11ee-4310-adfc-7657fc8e224d@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.33.35]
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQnVyYWtvdiwgQW5hdG9s
eSA8YW5hdG9seS5idXJha292QGludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgNywg
MjAyNSAxMjowNyBQTQ0KPiBUbzogS29uc3RhbnRpbiBBbmFueWV2IDxrb25zdGFudGluLmFuYW55
ZXZAaHVhd2VpLmNvbT47IGRldkBkcGRrLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEv
Ml0gY21kbGluZTogYWRkIGZsb2F0aW5nIHBvaW50IHN1cHBvcnQNCj4gDQo+IE9uIDUvNy8yMDI1
IDEyOjM1IFBNLCBLb25zdGFudGluIEFuYW55ZXYgd3JvdGU6DQo+ID4NCj4gPg0KPiA+PiBBZGQg
c3VwcG9ydCBmb3IgcGFyc2luZyBmbG9hdGluZyBwb2ludCBudW1iZXJzIGluIGNtZGxpbmUgbGli
cmFyeSwgYXMgd2VsbA0KPiA+PiBhcyB1bml0IHRlc3RzIGZvciB0aGUgbmV3IGZ1bmN0aW9uYWxp
dHkuIFRoZSBwYXJzZXIgc3VwcG9ydHMgc2luZ2xlIGFuZA0KPiA+PiBkb3VibGUgcHJlY2lzaW9u
IGZsb2F0cywgYW5kIHdpbGwgdW5kZXJzdGFuZCBkZWNpbWFsIGZyYWN0aW9ucyBhcyB3ZWxsIGFz
DQo+ID4+IHNjaWVudGlmaWMgbm90YXRpb24uDQo+ID4NCj4gPiBUaGVyZSBhcmUgc3RhbmRhcmQg
ZnVuY3Rpb25zIGZvciB0aGF0OiBzdHJ0b2Qvc3RydG9mIC0gY2FuJ3Qgd2Ugc2ltcGx5IHVzZSB0
aGVtPw0KPiANCj4gSSBjYW4gYXNrIHRoZSBzYW1lIHF1ZXN0aW9uIG9mIHRoZSBlbnRpcmUgZXhp
c3RlbmNlIG9mIHRoaXMgcGFydCBvZiB0aGUNCj4gbGlicmFyeTogdGhlcmUgYXJlIHN0cnRvdWxs
LXR5cGUgZnVuY3Rpb25zIHRoYXQgc2hvdWxkIGJlIGF2YWlsYWJsZSB0bw0KPiBhbGwgdGFyZ2V0
cywgDQoNClByb2JhYmx5IGR1ZSB0byBoaXN0b3JpY2FsIHJlYXNvbnMgLSBhIHdoaWxlIGFnbyBE
UERLIHdhcyBhYmxlIHRvIHJ1biBvbiBiYXJlLW1ldGFsIChub3QgYW55IG1vcmUpLg0KDQo+IHNv
IGlmIHdlJ3JlIGdvaW5nIHRvIHVzZSB0aGVtIGZvciBmbG9hdGluZyBwb2ludCBwYXJzaW5nLA0K
PiB3ZSBtaWdodCBhcyB3ZWxsIHJlbW92ZSB0aGUgbnVtYmVyIHBhcnNpbmcgcGFydCBvZiB0aGUg
bGlicmFyeSBlbnRpcmVseS4NCg0KU291bmRzIGxpa2UgYSBnb29kIGNsZWFudXAgZm9yIG1lLg0K
KzEgZm9yIGl0LiANCg0KDQo+IEVpdGhlciB3YXkgaXMgZmluZSBieSBtZS4NCj4gDQo+IC0tDQo+
IFRoYW5rcywNCj4gQW5hdG9seQ0KDQo=
