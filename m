Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC0FC531F5
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 14:31:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11FEB4067A;
	Thu, 23 Jul 2026 16:31:30 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id BFB6D40679
 for <dev@dpdk.org>; Thu, 23 Jul 2026 16:31:27 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=JsNugnonVR9CgJQHpZmTAQZOssFtpHq+TUXOIEDFwEo=;
 b=5TpvB2qDIfNl6JDgQVCH0DX2FuHAEtLfK9R/DCLbfwB5rKuv9clar+CddVdbES3UbTWqui9Sh
 mwLRfN2H/Ar+DP0EgXjhsE2fnUo6QMPhWLGdUwfRa9TJqn/r40hw+cGgytGraCYYCogtG68jiCX
 A4L2SGmmgQpm5cHCoL5ufDs=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h5YSv6W9bzHnH4y;
 Thu, 23 Jul 2026 22:30:55 +0800 (CST)
Received: from frapema100004.china.huawei.com (unknown [7.182.19.128])
 by mail.maildlp.com (Postfix) with ESMTPS id 4997840569;
 Thu, 23 Jul 2026 22:31:24 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100004.china.huawei.com (7.182.19.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 23 Jul 2026 16:31:24 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Thu, 23 Jul 2026 16:31:24 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "hkalra@marvell.com" <hkalra@marvell.com>, 
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 "Tetsuya Mukawa" <mtetsuyah@gmail.com>
Subject: RE: [RFC 1/4] bus/pci: fix check on interrupt FD for FreeBSD
Thread-Topic: [RFC 1/4] bus/pci: fix check on interrupt FD for FreeBSD
Thread-Index: AQHdGqXwz3+f4lLLh0yaREbwkur6jbZ6+WuAgAAFSICAACdO0A==
Date: Thu, 23 Jul 2026 14:31:23 +0000
Message-ID: <1ece3c764a64471ab966dd324bc19d76@huawei.com>
References: <20260723131908.3313223-1-david.marchand@redhat.com>
 <20260723131908.3313223-2-david.marchand@redhat.com>
 <amIYn1U_a0WmjMSs@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8wqcNPWffRmFLcUNcSL4KD3T0v5v-kjLX886BqFiV4XWQ@mail.gmail.com>
In-Reply-To: <CAJFAV8wqcNPWffRmFLcUNcSL4KD3T0v5v-kjLX886BqFiV4XWQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
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

PiA+ID4gLS0tIGEvZHJpdmVycy9idXMvcGNpL2JzZC9wY2kuYw0KPiA+ID4gKysrIGIvZHJpdmVy
cy9idXMvcGNpL2JzZC9wY2kuYw0KPiA+ID4gQEAgLTkzLDcgKzkzLDcgQEAgcGNpX3Vpb19mcmVl
X3Jlc291cmNlKHN0cnVjdCBydGVfcGNpX2RldmljZSAqZGV2LA0KPiA+ID4gIHsNCj4gPiA+ICAg
ICAgIHJ0ZV9mcmVlKHVpb19yZXMpOw0KPiA+ID4NCj4gPiA+IC0gICAgIGlmIChydGVfaW50cl9m
ZF9nZXQoZGV2LT5pbnRyX2hhbmRsZSkpIHsNCj4gPiA+ICsgICAgIGlmIChydGVfaW50cl9mZF9n
ZXQoZGV2LT5pbnRyX2hhbmRsZSkgPj0gMCkgew0KPiA+ID4gICAgICAgICAgICAgICBjbG9zZShy
dGVfaW50cl9mZF9nZXQoZGV2LT5pbnRyX2hhbmRsZSkpOw0KPiA+ID4gICAgICAgICAgICAgICBy
dGVfaW50cl9mZF9zZXQoZGV2LT5pbnRyX2hhbmRsZSwgLTEpOw0KPiA+ID4gICAgICAgICAgICAg
ICBydGVfaW50cl90eXBlX3NldChkZXYtPmludHJfaGFuZGxlLCBSVEVfSU5UUl9IQU5ETEVfVU5L
Tk9XTik7DQo+ID4NCj4gPiBVbmxpa2VseSB0aGF0IHdlIGFjdHVhbGx5IGhhdmUgZmQgYXMgMCBm
b3IgdGhpcyBjYWxsLCBidXQgY2hhbmdlIGlzDQo+ID4gdGVjaG5pY2FsbHkgY29ycmVjdC4NCj4g
DQo+IFllcywgdGhpcyBpcyB3aHkgSSBkaWQgbm90IENjOiBzdGFibGUuDQo+IFRoYW5rcy4NCg0K
SnVzdCB0cnlpbmcgdG8gdW5kZXJzdGFuZCB3aGF0J3MgZ29pbmcgb24gaGVyZSBvdXQgb2YgY3Vy
aW9zaXR5Lg0KDQpaZXJvIGZkIGlzIHZhbGlkIGFuZCBuZWdhdGl2ZSAodHlwaWNhbGx5IC0xKSBp
bmRpY2F0aW5nIGVycm9yIGlzIGEgc3RhbmRhcmQNCmxvZ2ljIGluIExpbnV4LCBidXQgaGVyZSBp
bnRyX2hhbmRsZS0+ZmQgaXMgemVyby1maWxsZWQgYnkNCnJ0ZV9pbnRyX2luc3RhbmNlX2FsbG9j
LCBzbyBpdHMgaW5pdGlhbCBzdGF0ZSBpcyAwIGluc3RlYWQgb2YgLTEuIERvIHdlIGhhdmUNCnJl
YXNvbnMgdG8gYmVsaWV2ZSB0aGF0IHNvbWV0aGluZyBhbHdheXMgc2V0cyBmZCB0byBub24temVy
byB2YWx1ZSBiZWZvcmUNCnBjaV91aW9fZnJlZV9yZXNvdXJjZSBpcyBjYWxsZWQ/IFNob3VsZCBy
dGVfaW50cl9pbnN0YW5jZV9hbGxvYyBzZXQgaXQgdG8gLTE/DQo=
