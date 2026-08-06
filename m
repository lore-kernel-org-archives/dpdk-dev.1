Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B6FC55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 07:58:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B2A540276;
	Thu,  6 Aug 2026 09:58:23 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id D577040262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 09:58:21 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=eICgiK1niaPCPTA6AFKPvVoW5z10FgiJQZTPQNAgMKs=;
 b=gKG80tt7Hj9OMGL4BoTWA/kuPe2vnIxhaN3ciqfKDIWb0lSxelN+SOe3mVdVVohzPXCy2KInA
 QJWuzpvaXk0zkV63GAzn6KWRXcJigHvan7cuozyIq9bptX4lutxb2WxZViuDcs9iOKpFepK7xtQ
 WhnY3JsQrVDtj7hHCeY1O+k=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hG04T3QrczJ46F6;
 Thu,  6 Aug 2026 15:57:29 +0800 (CST)
Received: from dubpeml100004.china.huawei.com (unknown [7.214.146.78])
 by mail.maildlp.com (Postfix) with ESMTPS id C603240584;
 Thu,  6 Aug 2026 15:58:15 +0800 (CST)
Received: from dubpemt500001.china.huawei.com (7.214.144.77) by
 dubpeml100004.china.huawei.com (7.214.146.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 6 Aug 2026 08:58:15 +0100
Received: from dubpeml100001.china.huawei.com (7.214.144.137) by
 dubpemt500001.china.huawei.com (7.214.144.77) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Aug 2026 08:58:15 +0100
Received: from dubpeml100001.china.huawei.com ([7.214.144.137]) by
 dubpeml100001.china.huawei.com ([7.214.144.137]) with mapi id 15.02.1544.036; 
 Thu, 6 Aug 2026 08:58:15 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>
Subject: RE: [PATCH] eal/x86: optimize memcpy of small 64-byte blocks
Thread-Topic: [PATCH] eal/x86: optimize memcpy of small 64-byte blocks
Thread-Index: AQHdJB42oNL4gJj070KJtRurBEIGmLaN+WoAgAAJXwCAAOt0oIAABRpAgAAL2ECAAB9NYIAAlEawgAAzoeCAAMFNUA==
Date: Thu, 6 Aug 2026 07:58:14 +0000
Message-ID: <fc32ab5225194114bac9286fe82815e1@huawei.com>
References: <20260804143305.1344327-1-mb@smartsharesystems.com>
 <20260804085210.74763eb5@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F659B8@smartserver.smartshare.dk>
 <6f474724bc22441a8a4f516f3398ca76@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F659BD@smartserver.smartshare.dk>
 <3c7eea01416249e0aaeab0e8b6b4c157@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F659BF@smartserver.smartshare.dk>
 <3a96ca58a1e146758f5314202a04c3de@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F659C3@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659C3@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.173.237]
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

DQoNCj4gPiA+ID4gPiA+ID4gPiA+ICsJLyogQ29tbW9uIHdheSBmb3Igc21hbGwgY29weSBzaXpl
IG9mIDY0LWJ5dGUgYmxvY2tzLg0KPiA+ID4gPiA+ID4gVW5saWtlbHksIHNvDQo+ID4gPiA+ID4g
PiA+ID4gY29uc3RhbnQgc2l6ZSBvbmx5ICovDQo+ID4gPiA+ID4gPiA+ID4gPiArCWlmIChfX3J0
ZV9jb25zdGFudChuKSAmJiAobiAmIDYzKSA9PSAwICYmIG4gPD0NCj4gPiA+ID4gPiA+ID4gPiBS
VEVfTUVNQ1BZX0JMT0NLXzY0X01BWCkgew0KPiA+ID4gPiA+ID4gPiA+ID4gKwkJdm9pZCAqcmV0
ID0gZHN0Ow0KPiA+ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiA+ID4gTWF5YmUganVzdCBsZXQgY29tcGlsZXIgZGVjaWRlLCBpdCB3aWxsIGdlbmVyYXRlIHZl
Y3Rvcg0KPiA+ID4gPiA+ID4gaW5zdHJ1Y3Rpb25zIGluDQo+ID4gPiA+ID4gPiA+ID4gbW9zdCBj
YXNlcy4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IAlpZiAoX19ydGVfY29uc3Rh
bnQobikpDQo+ID4gPiA+ID4gPiA+ID4gCQlyZXR1cm4gbWVtcGNweShkc3QsIHNyYywgbik7DQo+
ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IE1heWJlIGluIG1vc3QsIGJ1dCBub3QgaW4gYWxs
Og0KPiA+ID4gPiA+ID4gPiBodHRwczovL2dvZGJvbHQub3JnL3ovS3ZkS3FUNXJZDQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gV2l0aCAnLW1hdngnIG9yICctbWF2eDUxMmYnIGl0IGxvb2tzIGxp
a2UgaXQgZG9lcyBmb3IgeW91cg0KPiA+IHNhbXBsZQ0KPiA+ID4gPiBjb2RlLg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gSXQgYWxzbyBkb2VzIHdpdGggLW1zc2U0LjIgd2hlbiBTWiBpcyByZWR1Y2Vk
IHRvIDI1NiBieXRlcy4NCj4gPiA+ID4gPiBDbGFuZyBzd2l0Y2hlcyB0byBpbmxpbmUgd2hlbiBT
WiBpcyByZWR1Y2VkIHRvIDEyOCBieXRlcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEl0IHNlZW1z
IHRoZSBjb21waWxlciBoYXMgYSB0aHJlc2hvbGQgZm9yIHdoZW4gdG8gaW5saW5lIGFuZCB3aGVu
DQo+ID4gdG8NCj4gPiA+ID4gY2FsbCB0aGUgQw0KPiA+ID4gPiA+IGxpYnJhcnkncyBtZW1jcHkg
c3Vicm91dGluZS4NCj4gPiA+ID4gPiBUaGUgdGhyZXNob2xkIGRlcGVuZHMgb24gYm90aCBjb3B5
IHNpemUgYW5kIHZlY3RvciByZWdpc3RlciBzaXplLg0KPiA+ID4gPiA+IEFuZCBpdCBpcyBjb21w
aWxlciBkZXBlbmRlbnQuDQo+ID4gPiA+DQo+ID4gPiA+IEkgdGhpbmsgdGhlcmUgYXJlIGNvbXBp
bGVyIG9wdGlvbnMgdG8gc3BlY2lmeSBkZXNpcmVkIHRocmVzaG9sZA0KPiA+IHZhbHVlcy4NCj4g
PiA+ID4gTGV0IHNheSBmb3IgZ2NjIHRoZXJlIGlzICAnIC1tbWVtY3B5LXN0cmF0ZWd5PXN0cmF0
ZWd5Jy4NCj4gPiA+ID4gRm9yIHRoYXQgZXhhbXBsZSBpbiB0aGF0IHBhcnRpY3VsYXIgY2FzZQ0K
PiA+ID4gPiAtbW1lbWNweS1zdHJhdGVneT12ZWN0b3JfbG9vcDo1MTI6YWxpZ24sbG9vcDotMTph
bGlnbg0KPiA+ID4gPiBnZW5lcmF0ZXMgc3NlIGxvYWRzL3N0b3Jlcy4NCj4gPiA+ID4gTWlnaHQg
YmUgd2UgY2FuIGV4cGxvaXQgaXQgc29tZWhvdz8NCj4gPiA+DQo+ID4gPiBUaGF0IGNvdWxkIGdp
dmUgdXMgaGlnaGVyIGdyYW51bGFyaXR5L2NvbnRyb2wgb3ZlciBtZW1jcHkgZm9yDQo+ID4gaW5k
aXZpZHVhbA0KPiA+ID4gbWVtY3B5IGluc3RhbmNlczsgbWlnaHQgYmUgdXNlZnVsIGZvciBob3Qg
Y29kZSBwYXRocyB3aGVyZSB3ZSBoYXZlDQo+ID4gbW9yZQ0KPiA+ID4ga25vd2xlZGdlIGFib3V0
IHRoZSBjb3B5IG9wZXJhdGlvbiB0aGFuIHRoZSBjb21waWxlciBjYW4gaW5mZXIuDQo+ID4gPiBI
b3dldmVyLCBwcmFnbWFzIGFyZSBkaXNjb3VyYWdlZCBpbiBEUERLLCBhbmQgdGhpcyBsb29rcyBs
aWtlIGEgdmVyeQ0KPiA+IHNpbWlsYXINCj4gPiA+IHBhdGguDQo+ID4NCj4gPiBXZWxsLCByaWdo
dCBub3cgIHJ0ZV9tZW1jcHkuaCBpcyA3MDArIGxpbmVzIGFuZCBrZWVwcyBncm93aW5nLg0KPiA+
IENvbnNpZGVyaW5nIHRoYXQgcHJvYmFibHkgcHJhZ21hcyBhcmUgbm90IHRoYXQgYmFkLg0KPiA+
IE9mIGNvdXJzZSwgcHJhZ21hcyBoYXZlIHRoZWlyIG93biBpc3N1ZXMgYW5kIGl0IGlzIGhhcmQg
dG8gZW5zdXJlIHRoYXQNCj4gPiB0aGV5IHdpbGwgcHJvZHVjZSBzYW1lIGNvZGUgYmV0d2VlbiBk
aWZmZXJlbnQgY29tcGlsZXJzL3ZlcnNpb25zLCBldGMuDQo+ID4NCj4gPiA+ID4gSSBhbSBub3Qg
cmVhbGx5IGhhcHB5IHRoYXQgb3VyIGhvbWUtYnJld2VkIG1lbWNweSBjb2RlLWJsb2NrIGtlZXBz
DQo+ID4gPiA+IGdyb3dpbmcsDQo+ID4gPiA+IHdoaWxlIHdlIGtlZXAgdGFsa2luZyB0aGF0IGl0
IHdvdWxkIGJlIGdvb2QgdG8gZWxpbWluYXRlIGl0DQo+ID4gY29tcGxldGVseS4NCj4gPiA+DQo+
ID4gPiBJIGFncmVlIGluIHByaW5jaXBsZS4NCj4gPiA+IEhvd2V2ZXIsIHRoaXMgcnRlX21lbWNw
eSgpIG9wdGltaXphdGlvbiBpcyBmb3IgdGhlIHBpbGUvbWVtcG9vbA0KPiA+IG9wdGltaXphdGlv
bnMNCj4gPiA+IEknbSB3b3JraW5nIG9uLCBzbyB0aGVyZSBpcyBhIHNwZWNpZmljIHVzZSBjYXNl
IG1vdGl2YXRpbmcgdGhlIGFkZGVkDQo+ID4gY29kZS4NCj4gPg0KPiA+IEkgdW5kZXJzdGFuZCB0
aGF0IHlvdSBwcm9iYWJseSBoYXZlIHNvbWUgc3BlY2lmaWMgdXNlLWNhc2UgaW4gbWluZC4NCj4g
PiBCVFcgZm9yIHRoaXMgb3B0aW1pemF0aW9uIHlvdSBtZW50aW9uZWQgYWJvdmU6IHdoYXQgaXMg
dGhlIGdhaW4gd2l0aA0KPiA+IHRoZXNlIGNoYW5nZXM/DQo+IA0KPiBJTU8sIHRoZSBwcmltYXJ5
IGJlbmVmaXQgaXMgdGhlIG11Y2ggc2ltcGxlciAoYW5kIHNtYWxsZXIpIGFzc2VtYmx5IG91dHB1
dCBkdWUNCj4gdG8gYXZvaWRpbmcgdGhlIGFkZHJlc3MgYWxpZ25tZW50IGNoZWNrIChhbmQgdGhl
IHJlc3VsdGluZyBkdXBsaWNhdGVkIGNvZGUpLg0KDQpJIHRoaW5rIHRoYXQgc2hvdWxkIGJlIG1l
YXN1cmFibGUgdG9vOiB3aG9sZSBiaW5hcnkgIGFuZC9vciBob3QgcGF0aCBmdW5jdGlvbiBzaXpl
IHJlZHVjdGlvbiwgZXRjLiANCg0KPiBJIGhhdmVuJ3QgbWVhc3VyZWQgdGhlIHBlcmZvcm1hbmNl
IGdhaW4uDQo+IEJhc2VkIG9uIHRoZSBwZXJmIGdhaW4gaW4gYSBwcmV2aW91cyBtZW1wb29sIG9w
dGltaXphdGlvbiBwYXRjaCBbMV0sIGl0IHNlZW1zDQo+IGF2b2lkaW5nIHRoZSBhZGRyZXNzIGFs
aWdubWVudCBjaGVjayBzaGF2ZXMgfjIgY3ljbGVzIG9mZiB0aGUgY29weSBvcGVyYXRpb24gKGZv
cg0KPiBjYWNoZS10by1jYWNoZSBjb3B5KS4NCj4gSSBleHBlY3QgdGhhdCB0aGUgc2FtZSBnYWlu
IChmcm9tIGF2b2lkaW5nIHRoZSBhZGRyZXNzIGFsaWdubWVudCBjaGVjaykgYXBwbGllcw0KPiBo
ZXJlLg0KDQpPaywgdGhlbiBJIHN1Z2dlc3Qgd2UgZG8gc29tZSBtZWFzdXJlbWVudHMgZmlyc3Qs
IGJlZm9yZSBnb2luZyBmb3J3YXJkIHdpdGggaXQuIA0KDQo+IFsxXTogaHR0cHM6Ly9wYXRjaHdv
cmsuZHBkay5vcmcvcHJvamVjdC9kcGRrL3BhdGNoLzIwMjYwNTIxMTg1NjMxLjExNjA0Ni0xLQ0K
PiBtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20vDQoNCg==
