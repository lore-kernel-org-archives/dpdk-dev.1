Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDE7C55822
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 06:50:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 503BF40144;
	Wed,  5 Aug 2026 08:50:28 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 989FE4003C
 for <dev@dpdk.org>; Wed,  5 Aug 2026 08:50:27 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=GLcpb9R+Yg4GNgwAysOnNEtm3WS1yclUmm6oVWsGTI0=;
 b=b+iBXGYRsXnXQnr/KEVUe+v4yWLMDE6CJwWFK9TEv6dP3uWJ6z7eaUk7mfnuVUZBngwrwVTdE
 ScuCGEfL4ykhOS83PrIU+UqRipVpH9qQ9iDWf4TAqNTDvN1TdtpthPWRcV+ww4b1SiZ7upFzFU5
 yWYLS+0s8F5v+m6hiSTbyqY=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hFLcS4y2czHnGd4;
 Wed,  5 Aug 2026 14:49:28 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 51ADC40570;
 Wed,  5 Aug 2026 14:50:22 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (7.214.144.137) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 5 Aug 2026 07:50:21 +0100
Received: from dubpeml100001.china.huawei.com ([7.214.144.137]) by
 dubpeml100001.china.huawei.com ([7.214.144.137]) with mapi id 15.02.1544.036; 
 Wed, 5 Aug 2026 07:50:21 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>
Subject: RE: [PATCH] eal/x86: optimize memcpy of small 64-byte blocks
Thread-Topic: [PATCH] eal/x86: optimize memcpy of small 64-byte blocks
Thread-Index: AQHdJB42oNL4gJj070KJtRurBEIGmLaN+WoAgAAJXwCAAOt0oIAABRpAgAAL2EA=
Date: Wed, 5 Aug 2026 06:50:21 +0000
Message-ID: <3c7eea01416249e0aaeab0e8b6b4c157@huawei.com>
References: <20260804143305.1344327-1-mb@smartsharesystems.com>
 <20260804085210.74763eb5@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F659B8@smartserver.smartshare.dk>
 <6f474724bc22441a8a4f516f3398ca76@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F659BD@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659BD@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.173.34]
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTW9ydGVuIEJyw7hydXAg
PG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgNSwg
MjAyNiA2OjU2IEFNDQo+IFRvOiBLb25zdGFudGluIEFuYW55ZXYgPGtvbnN0YW50aW4uYW5hbnll
dkBodWF3ZWkuY29tPjsgU3RlcGhlbg0KPiBIZW1taW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1i
ZXIub3JnPg0KPiBDYzogZGV2QGRwZGsub3JnOyBCcnVjZSBSaWNoYXJkc29uIDxicnVjZS5yaWNo
YXJkc29uQGludGVsLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gZWFsL3g4Njogb3B0aW1p
emUgbWVtY3B5IG9mIHNtYWxsIDY0LWJ5dGUgYmxvY2tzDQo+IA0KPiA+IEZyb206IEtvbnN0YW50
aW4gQW5hbnlldiBbbWFpbHRvOmtvbnN0YW50aW4uYW5hbnlldkBodWF3ZWkuY29tXQ0KPiA+IFNl
bnQ6IFdlZG5lc2RheSwgNSBBdWd1c3QgMjAyNiAwNy40Ng0KPiA+DQo+ID4gPiA+IEZyb206IFN0
ZXBoZW4gSGVtbWluZ2VyIFttYWlsdG86c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmddDQo+ID4g
PiA+IFNlbnQ6IFR1ZXNkYXksIDQgQXVndXN0IDIwMjYgMTcuNTINCj4gPiA+ID4NCj4gPiA+ID4g
T24gVHVlLCAgNCBBdWcgMjAyNiAxNDozMzowNCArMDAwMA0KPiA+ID4gPiBNb3J0ZW4gQnLDuHJ1
cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gPiAr
CS8qIENvbW1vbiB3YXkgZm9yIHNtYWxsIGNvcHkgc2l6ZSBvZiA2NC1ieXRlIGJsb2Nrcy4NCj4g
PiBVbmxpa2VseSwgc28NCj4gPiA+ID4gY29uc3RhbnQgc2l6ZSBvbmx5ICovDQo+ID4gPiA+ID4g
KwlpZiAoX19ydGVfY29uc3RhbnQobikgJiYgKG4gJiA2MykgPT0gMCAmJiBuIDw9DQo+ID4gPiA+
IFJURV9NRU1DUFlfQkxPQ0tfNjRfTUFYKSB7DQo+ID4gPiA+ID4gKwkJdm9pZCAqcmV0ID0gZHN0
Ow0KPiA+ID4gPiA+ICsNCj4gPiA+ID4NCj4gPiA+ID4gTWF5YmUganVzdCBsZXQgY29tcGlsZXIg
ZGVjaWRlLCBpdCB3aWxsIGdlbmVyYXRlIHZlY3Rvcg0KPiA+IGluc3RydWN0aW9ucyBpbg0KPiA+
ID4gPiBtb3N0IGNhc2VzLg0KPiA+ID4gPg0KPiA+ID4gPiAJaWYgKF9fcnRlX2NvbnN0YW50KG4p
KQ0KPiA+ID4gPiAJCXJldHVybiBtZW1wY3B5KGRzdCwgc3JjLCBuKTsNCj4gPiA+DQo+ID4gPiBN
YXliZSBpbiBtb3N0LCBidXQgbm90IGluIGFsbDoNCj4gPiA+IGh0dHBzOi8vZ29kYm9sdC5vcmcv
ei9LdmRLcVQ1clkNCj4gPg0KPiA+IFdpdGggJy1tYXZ4JyBvciAnLW1hdng1MTJmJyBpdCBsb29r
cyBsaWtlIGl0IGRvZXMgZm9yIHlvdXIgc2FtcGxlIGNvZGUuDQo+IA0KPiBJdCBhbHNvIGRvZXMg
d2l0aCAtbXNzZTQuMiB3aGVuIFNaIGlzIHJlZHVjZWQgdG8gMjU2IGJ5dGVzLg0KPiBDbGFuZyBz
d2l0Y2hlcyB0byBpbmxpbmUgd2hlbiBTWiBpcyByZWR1Y2VkIHRvIDEyOCBieXRlcy4NCj4gDQo+
IEl0IHNlZW1zIHRoZSBjb21waWxlciBoYXMgYSB0aHJlc2hvbGQgZm9yIHdoZW4gdG8gaW5saW5l
IGFuZCB3aGVuIHRvIGNhbGwgdGhlIEMNCj4gbGlicmFyeSdzIG1lbWNweSBzdWJyb3V0aW5lLg0K
PiBUaGUgdGhyZXNob2xkIGRlcGVuZHMgb24gYm90aCBjb3B5IHNpemUgYW5kIHZlY3RvciByZWdp
c3RlciBzaXplLg0KPiBBbmQgaXQgaXMgY29tcGlsZXIgZGVwZW5kZW50Lg0KDQpJIHRoaW5rIHRo
ZXJlIGFyZSBjb21waWxlciBvcHRpb25zIHRvIHNwZWNpZnkgZGVzaXJlZCB0aHJlc2hvbGQgdmFs
dWVzLg0KTGV0IHNheSBmb3IgZ2NjIHRoZXJlIGlzICAnIC1tbWVtY3B5LXN0cmF0ZWd5PXN0cmF0
ZWd5Jy4NCkZvciB0aGF0IGV4YW1wbGUgaW4gdGhhdCBwYXJ0aWN1bGFyIGNhc2UNCi1tbWVtY3B5
LXN0cmF0ZWd5PXZlY3Rvcl9sb29wOjUxMjphbGlnbixsb29wOi0xOmFsaWduDQpnZW5lcmF0ZXMg
c3NlIGxvYWRzL3N0b3Jlcy4NCk1pZ2h0IGJlIHdlIGNhbiBleHBsb2l0IGl0IHNvbWVob3c/DQpJ
IGFtIG5vdCByZWFsbHkgaGFwcHkgdGhhdCBvdXIgaG9tZS1icmV3ZWQgbWVtY3B5IGNvZGUtYmxv
Y2sga2VlcHMgZ3Jvd2luZywNCndoaWxlIHdlIGtlZXAgdGFsa2luZyB0aGF0IGl0IHdvdWxkIGJl
IGdvb2QgdG8gZWxpbWluYXRlIGl0IGNvbXBsZXRlbHkuDQoNCg0KDQoNCj4gV2l0aCBydGVfbWVt
Y3B5KCkgaXQgaXMgYWx3YXlzIGlubGluZS4NCg0K
