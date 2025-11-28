Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F82D116F1
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 14:02:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B365D402C5;
	Fri, 28 Nov 2025 15:02:38 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id B8D35402B0
 for <dev@dpdk.org>; Fri, 28 Nov 2025 15:02:37 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dHw2d621NzHnGj6;
 Fri, 28 Nov 2025 22:01:45 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id 6670E1402FE;
 Fri, 28 Nov 2025 22:02:36 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Nov 2025 14:02:36 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Fri, 28 Nov 2025 14:02:35 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, 
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, Vipin Varghese
 <vipin.varghese@amd.com>
CC: Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH v3] eal/x86: optimize memcpy of small sizes
Thread-Topic: [PATCH v3] eal/x86: optimize memcpy of small sizes
Thread-Index: AQHcWtNXD+EKJWk0k0O6HEmUv7nh0LUIKREQ
Date: Fri, 28 Nov 2025 14:02:35 +0000
Message-ID: <59db9d3d83d94ec9a7c26ae506fd4813@huawei.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20251121104052.1273637-1-mb@smartsharesystems.com>
In-Reply-To: <20251121104052.1273637-1-mb@smartsharesystems.com>
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

PiArLyoqDQo+ICsgKiBDb3B5IGJ5dGVzIGZyb20gb25lIGxvY2F0aW9uIHRvIGFub3RoZXIsDQo+
ICsgKiBsb2NhdGlvbnMgc2hvdWxkIG5vdCBvdmVybGFwLg0KPiArICogVXNlIHdpdGggbiA8PSAx
Ni4NCj4gKyAqDQo+ICsgKiBOb3RlOiBDb3B5aW5nIHVuaW5pdGlhbGl6ZWQgbWVtb3J5IGlzIHBl
cmZlY3RseSBhY2NlcHRhYmxlLg0KPiArICogVXNpbmcgZS5nLiBtZW1jcHkoZHN0LCBzcmMsIDgp
IGluc3RlYWQgb2YNCj4gKyAqICoodW5hbGlnbmVkX3VpbnQ2NF90KikgPSAqKGNvbnN0IHVuYWxp
Z25lZF91aW50NjRfdCAqKXNyYw0KPiArICogYXZvaWRzIGNvbXBpbGVyIHdhcm5pbmdzIGFib3V0
IHNvdXJjZSBkYXRhIG1heSBiZSB1bmluaXRpYWxpemVkDQo+ICsgKiBbLVdtYXliZS11bmluaXRp
YWxpemVkXS4NCj4gKyAqDQo+ICsgKiBOb3RlOiBVc2luZyAibiAmIFgiIGdlbmVyYXRlcyAzLWJ5
dGUgInRlc3QiIGluc3RydWN0aW9ucywNCj4gKyAqIGluc3RlYWQgb2YgIm4gPj0gWCIsIHdoaWNo
IHdvdWxkIGdlbmVyYXRlIDQtYnl0ZSAiY21wIiBpbnN0cnVjdGlvbnMuDQo+ICsgKi8NCj4gK3N0
YXRpYyBfX3J0ZV9hbHdheXNfaW5saW5lIHZvaWQgKg0KPiArcnRlX21vdjE2X29yX2xlc3Modm9p
ZCAqZHN0LCBjb25zdCB2b2lkICpzcmMsIHNpemVfdCBuKQ0KPiArew0KPiArCS8qIEZhc3RlciB3
YXkgd2hlbiBzaXplIGlzIGtub3duIGF0IGJ1aWxkIHRpbWUuICovDQo+ICsJaWYgKF9fcnRlX2Nv
bnN0YW50KG4pKSB7DQo+ICsJCWlmIChuID09IDIpDQo+ICsJCQlyZXR1cm4gbWVtY3B5KGRzdCwg
c3JjLCAyKTsNCj4gKwkJaWYgKG4gPT0gNCkNCj4gKwkJCXJldHVybiBtZW1jcHkoZHN0LCBzcmMs
IDQpOw0KPiArCQlpZiAobiA9PSA2KSAvKiA0ICsgMiAqLw0KPiArCQkJcmV0dXJuIG1lbWNweShk
c3QsIHNyYywgNik7DQo+ICsJCWlmIChuID09IDgpDQo+ICsJCQlyZXR1cm4gbWVtY3B5KGRzdCwg
c3JjLCA4KTsNCj4gKwkJaWYgKG4gPT0gMTApIC8qIDggKyAyICovDQo+ICsJCQlyZXR1cm4gbWVt
Y3B5KGRzdCwgc3JjLCAxMCk7DQo+ICsJCWlmIChuID09IDEyKSAvKiA4ICsgNCAqLw0KPiArCQkJ
cmV0dXJuIG1lbWNweShkc3QsIHNyYywgMTIpOw0KPiArCQlpZiAobiA9PSAxNikgew0KPiArCQkJ
cnRlX21vdjE2KCh1aW50OF90ICopZHN0LCAoY29uc3QgdWludDhfdCAqKXNyYyk7DQo+ICsJCQly
ZXR1cm4gZHN0Ow0KPiArCQl9DQo+ICsJfQ0KPiArDQo+ICsJaWYgKG4gJiAweDE4KSB7IC8qIG4g
Pj0gOCAqLw0KDQpQcm9iYWJseSAnbiAmIDB4OCc/DQogDQo+ICsJCS8qIGNvcHkgOCB+IDE2IGJ5
dGVzICovDQo+ICsJCW1lbWNweShkc3QsIHNyYywgOCk7DQo+ICsJCW1lbWNweSgodWludDhfdCAq
KWRzdCAtIDggKyBuLCAoY29uc3QgdWludDhfdCAqKXNyYyAtIDggKyBuLCA4KTsNCj4gKwl9IGVs
c2UgaWYgKG4gJiAweDQpIHsNCj4gKwkJLyogY29weSA0IH4gNyBieXRlcyAqLw0KPiArCQltZW1j
cHkoZHN0LCBzcmMsIDQpOw0KPiArCQltZW1jcHkoKHVpbnQ4X3QgKilkc3QgLSA0ICsgbiwgKGNv
bnN0IHVpbnQ4X3QgKilzcmMgLSA0ICsgbiwgNCk7DQo+ICsJfSBlbHNlIGlmIChuICYgMHgyKSB7
DQo+ICsJCS8qIGNvcHkgMiB+IDMgYnl0ZXMgKi8NCj4gKwkJbWVtY3B5KGRzdCwgc3JjLCAyKTsN
Cj4gKwkJbWVtY3B5KCh1aW50OF90ICopZHN0IC0gMiArIG4sIChjb25zdCB1aW50OF90ICopc3Jj
IC0gMiArIG4sIDIpOw0KPiArCX0gZWxzZSBpZiAobiAmIDB4MSkgew0KPiArCQkvKiBjb3B5IDEg
Ynl0ZSAqLw0KPiArCQltZW1jcHkoZHN0LCBzcmMsIDEpOw0KPiArCX0NCj4gKwlyZXR1cm4gZHN0
Ow0KPiArfQ0K
