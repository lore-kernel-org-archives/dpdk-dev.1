Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F74C61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 09:38:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85E0D4025A;
	Mon, 31 Aug 2026 11:38:19 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 98312400D5
 for <dev@dpdk.org>; Mon, 31 Aug 2026 11:38:18 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=jA+V6O9FsD/p7XcUFez/g1+mrtskAK1ugMya23zevAw=;
 b=UUJFV8dLGVT5bk1Y1lu29i90MpY9lc5o9/P72gLWUBT65UhjhO36zxV1yZqyUq+oBxL18lxOr
 TIZZL5p6ekjW8kkkBmGjpafimWReuw/zCfL+5eXEHsSUWJrrGdqtOmgA3fmNdeEfnHiF+O5/bYR
 6U6TDwiqg2KeeHtbLv2IkxM=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hYP6J222wzHnGcj;
 Mon, 31 Aug 2026 17:37:28 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id B46FC4057D;
 Mon, 31 Aug 2026 17:38:11 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 31 Aug 2026 10:38:11 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.2562.045; 
 Mon, 31 Aug 2026 10:38:11 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>
Subject: RE: [PATCH v3 1/2] stack: introduce pile
Thread-Topic: [PATCH v3 1/2] stack: introduce pile
Thread-Index: AQHdNivZlPLzR2W88UagmX4dOkumu7a33NkwgAACqiCAAAumgA==
Date: Mon, 31 Aug 2026 09:38:11 +0000
Message-ID: <b34c20e4e0a043adb0ed7ad13a3e7352@huawei.com>
References: <20260812134756.1829613-1-mb@smartsharesystems.com>
 <20260827135556.522443-1-mb@smartsharesystems.com>
 <20260827135556.522443-2-mb@smartsharesystems.com>
 <ec4ba9b4d8f34eb78e86a5ccc2a01a89@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65A23@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65A23@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.172.158]
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

DQo+ID4gRnJvbTogS29uc3RhbnRpbiBBbmFueWV2IFttYWlsdG86a29uc3RhbnRpbi5hbmFueWV2
QGh1YXdlaS5jb21dDQo+ID4gU2VudDogTW9uZGF5LCAzMSBBdWd1c3QgMjAyNiAxMC41MA0KPiA+
DQo+ID4gPiBBZGRlZCBhIG5ldyBoaWdoLXBlcmZvcm1hbmNlIGxvY2stZnJlZSAicGlsZSIsIHVz
aW5nIHRoZSBTdGFjayBBUEkuDQo+ID4gPiBUaGUgcGlsZSBiZWhhdmVzIHJvdWdobHkgbGlrZSBh
IHN0YWNrLCBidXQgaXMgbm90IHN0cmljdGx5IExJRk8uDQo+ID4gPg0KPiA+ID4gVGhlIHBpbGUg
aXMgb3B0aW1pemVkIGZvciBwdXNoaW5nL3BvcHBpbmcgYnVsa3Mgb2Ygb2JqZWN0cywgd2hpY2gN
Cj4gPiA+IGl0IGRvZXMgc2lnbmlmaWNhbnRseSBmYXN0ZXIgdGhhbiB0aGUgbG9jay1mcmVlIHN0
YWNrLg0KPiA+ID4NCj4gPiA+IFB1c2hpbmcvcG9wcGluZyBhIG51bWJlciBvZiBvYmplY3RzIG5v
dCBkaXZpc2libGUgYnkgdGhlIGNvbXBpbGUgdGltZQ0KPiA+ID4gY29uZmlndXJhYmxlIGJ1bGsg
c2l6ZSBpcyBoYW5kbGVkIGdyYWNlZnVsbHksIGJ1dCBub3QgYXMgZmFzdCBhcw0KPiA+ID4gY29t
cGxldGUgYnVsa3MuDQo+ID4gPg0KPiA+ID4gUGVyZm9ybWFuY2UgZXhhbXBsZXMsIHN0YWNrX3Bp
bGVfcGVyZl9hdXRvdGVzdCB2cy4gc3RhY2tfbGZfYXV0b3Rlc3Q6DQo+ID4gPg0KPiA+ID4gT24g
YSBzaW5nbGUgY29yZSwgcHVzaGluZy9wb3BwaW5nIDEgb3IgOCBvYmplY3RzIGlzIHNpbWlsYXIg
c3BlZWQuDQo+ID4gPiBPbiBhIHNpbmdsZSBjb3JlLCBwdXNoaW5nL3BvcHBpbmcgMzIgb2JqZWN0
cyBpcyAyeCBmYXN0ZXIuDQo+ID4gPiBPbiBhIHNpbmdsZSBjb3JlLCBwdXNoaW5nL3BvcHBpbmcg
NTEyIG9iamVjdHMgaXMgMTB4IGZhc3Rlci4NCj4gPiA+DQo+ID4gPiBPbiBmb3VyIGNvcmVzLCBw
dXNoaW5nL3BvcHBpbmcgMSwgOCBvciAzMiBvYmplY3RzIGlzIHNsaWdodGx5IGZhc3Rlci4NCj4g
PiA+IE9uIGZvdXIgY29yZXMsIHB1c2hpbmcvcG9wcGluZyA1MTIgb2JqZWN0cyBpcyA0eCBmYXN0
ZXIuDQo+ID4NCj4gPiBBY2tlZC1ieTogS29uc3RhbnRpbiBBbmFueWV2IDxrb25zdGFudGluLmFu
YW55ZXZAaHVhd2VpLmNvbT4NCj4gPg0KPiA+IFRoZSBjb2RlIGl0c2VsZiBsb29rcyBvayB0byBt
ZSwgdGhvdWdodCBJIHN0aWxsIHRoaW5rIGl0IGlzIHdvcnRoIHRvDQo+ID4gY29uc2lkZXINCj4g
PiBtb3ZpbmcgbGZfcGlsZSAoYW5kIGxmX3N0YWNrKSBEUCBpbXBsZW1lbnRhdGlvbiBpbiAuYywg
dG8gYXZvaWQgZWFjaA0KPiA+IHJ0ZV9zdGFja19wdXMvcG9wDQo+ID4gdG8gaW5saW5lIGFsbCB0
aHJlZSBvZiB0aGVtLg0KPiANCj4gSWYgYSB1c2UgY2FzZSBrbm93cyB0aGUgc2VsZWN0ZWQgc3Rh
Y2sgaW1wbGVtZW50IGF0IGJ1aWxkIHRpbWUsIGl0IGNhbiBjYWxsIHRoZQ0KPiBpbXBsZW1lbnRh
dGlvbidzIHB1c2gvcG9wIGZ1bmN0aW9ucyBkaXJlY3RseS4NCj4gSSB1cGRhdGVkIHRoZSBtZW1w
b29sIHN0YWNrIGRyaXZlciB2MyBwYXRjaCBbMV0gdG8gZG8gdGhpcyBmb3IgYWxsIHRocmVlIHN0
YWNrDQo+IGltcGxlbWVudGF0aW9ucy4NCg0KVGhhdCdzIGdvb2QgdGhpbmcgZm9yIHN1cmUuDQpU
aG91Z2ggSSBhbSB0YWxraW5nIGFib3V0Og0KI2lmZGVmIF9fY3BsdXNwbHVzDQogZXh0ZXJuICJD
IiB7DQpAQCAtMTE1LDYgKzE3NCw4IEBAIHJ0ZV9zdGFja19wdXNoKHN0cnVjdCBydGVfc3RhY2sg
KnMsIHZvaWQgKiBjb25zdCAqb2JqX3RhYmxlLCB1bnNpZ25lZCBpbnQgbikNCiANCiAJaWYgKHMt
PmZsYWdzICYgUlRFX1NUQUNLX0ZfTEYpDQogCQlyZXR1cm4gX19ydGVfc3RhY2tfbGZfcHVzaChz
LCBvYmpfdGFibGUsIG4pOw0KKwllbHNlIGlmIChzLT5mbGFncyAmIFJURV9TVEFDS19GX1BJTEUp
DQorCQlyZXR1cm4gX19ydGVfc3RhY2tfcGlsZV9wdXNoKHMsIG9ial90YWJsZSwgbik7DQogCWVs
c2UNCiAJCXJldHVybiBfX3J0ZV9zdGFja19zdGRfcHVzaChzLCBvYmpfdGFibGUsIG4pOw0KIH0N
CkBAIC0xMzksNiArMjAwLDggQEAgcnRlX3N0YWNrX3BvcChzdHJ1Y3QgcnRlX3N0YWNrICpzLCB2
b2lkICoqb2JqX3RhYmxlLCB1bnNpZ25lZCBpbnQgbikNCiANCiAJaWYgKHMtPmZsYWdzICYgUlRF
X1NUQUNLX0ZfTEYpDQogCQlyZXR1cm4gX19ydGVfc3RhY2tfbGZfcG9wKHMsIG9ial90YWJsZSwg
bik7DQorCWVsc2UgaWYgKHMtPmZsYWdzICYgUlRFX1NUQUNLX0ZfUElMRSkNCisJCXJldHVybiBf
X3J0ZV9zdGFja19waWxlX3BvcChzLCBvYmpfdGFibGUsIG4pOw0KIAllbHNlDQogCQlyZXR1cm4g
X19ydGVfc3RhY2tfc3RkX3BvcChzLCBvYmpfdGFibGUsIG4pOw0KIH0NCg0KSW4gcnRlX3N0YWNr
LmgNCldlIHN0aWxsIGNhbiBoYXZlIG91ciBfX3J0ZV9zdGFja19waWxlX3B1c2gvcG8gYXMgaW5s
aW5lIGZ1bmN0aW9ucyBpbiB0aGUgaW50ZXJuYWwgaGVhZGVycywNCnNvIG1lbXBvb2wgKGFuZCB3
aG9ldmVyIGVsc2UgbmVlZHMgdGhlbSkgY2FuIGluY2x1ZGUgdGhlbSBkaXJlY3RseS4NCk15IHN1
Z2dlc3Rpb24gdG8gaGF2ZSBydGVfc3RhY2tfcGlsZV9wb3AoKSBpbiAuYyBhbmQgaW52b2tlIGl0
IChub3QtaW5saW5lZCBvbmUpIGZyb20NCmdlbmVyaWMgcnRlX3N0YWNrX3BvcCgpLiAgDQoNCj4g
WzFdOiBodHRwczovL3BhdGNod29yay5kcGRrLm9yZy9wcm9qZWN0L2RwZGsvcGF0Y2gvMjAyNjA4
MjcxMzU1NTYuNTIyNDQzLTMtDQo+IG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbS8NCj4gDQo+ID4g
TXkgc3BlY3VsYXRpb24gaXMgdGhhdCB0aGUgcGVyZiBkaWZmIGZvciBidWxrIGVucXVldWUvZGVx
dWV1ZSBiZWNhdXNlDQo+ID4gb2YNCj4gPiB0aGF0IHdvdWxkIGJlIG5lZ2xpZ2libGUsIHdoaWxl
IGJvdGggYXJlIHF1aXRlIGJpZyBmb3IgaW5saW5pbmcgdGhlbQ0KPiA+IGFsd2F5cw0KPiA+IChz
cGVjaWFsbHkgbGZfcGlsZSkuDQo+IA0KPiBJZiB0aGUgbnVtYmVyIG9mIG9iamVjdHMgYmVpbmcg
cHVzaGVkL3BvcHBlZCBpcyBrbm93biBhdCBidWlsZCB0aW1lLCB0aGUNCj4gY29tcGlsZXIgY2Fu
IG9wdGltaXplIHRoZSBmdW5jdGlvbnMgd2hlbiBpbmxpbmVkLg0KPiANCj4gSSB0cmllZCBleHBl
cmltZW50ZWQgd2l0aCBjb25kaXRpb25hbCBpbmxpbmluZyBkZXBlbmRpbmcgb24gdGhlIG51bWJl
ciBvZg0KPiBvYmplY3RzIGJlaW5nIGtub3duIGF0IGJ1aWxkIHRpbWUsIGJ1dCBJIHdhc24ndCBy
ZWFsbHkgcGxlYXNlZCB3aXRoIGl0Lg0KDQo=
