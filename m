Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDC1107528A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 09:36:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E2C84025D;
	Thu, 19 Mar 2026 10:36:56 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 5E7AB4013F;
 Thu, 19 Mar 2026 10:36:54 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fc0td49XhzJ46hL;
 Thu, 19 Mar 2026 17:35:53 +0800 (CST)
Received: from frapema100003.china.huawei.com (unknown [7.182.19.100])
 by mail.maildlp.com (Postfix) with ESMTPS id BEB8140584;
 Thu, 19 Mar 2026 17:36:52 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100003.china.huawei.com (7.182.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 19 Mar 2026 10:36:52 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Thu, 19 Mar 2026 10:36:52 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Christophe Fontaine
 <cfontain@redhat.com>, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH] mbuf: fix read packet data
Thread-Topic: [PATCH] mbuf: fix read packet data
Thread-Index: AQHct3wiFcNsRRkFWk+tb6J7jsVeNLW1ltxA
Date: Thu, 19 Mar 2026 09:36:52 +0000
Message-ID: <6bda6389ce8e4ad5b081f53eb1241fc8@huawei.com>
References: <20260319084048.652493-1-mb@smartsharesystems.com>
In-Reply-To: <20260319084048.652493-1-mb@smartsharesystems.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
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

Rm9yIHRoZSBmaXg6DQoNCkFja2VkLWJ5OiBNYXJhdCBLaGFsaWxpIDxtYXJhdC5raGFsaWxpQGh1
YXdlaS5jb20+DQoNClRoZSB0ZXN0cyB3aWxsIGZhaWwgdGhvdWdoIGFuZCBuZWVkIHRvIGJlIGFk
anVzdGVkIHRvIHRoZSBjb3JyZWN0IGJlaGF2aW91ci4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29t
Pg0KPiBTZW50OiBUaHVyc2RheSAxOSBNYXJjaCAyMDI2IDA4OjQxDQo+IFRvOiBkZXZAZHBkay5v
cmcNCj4gQ2M6IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz47
IE1hcmF0IEtoYWxpbGkgPG1hcmF0LmtoYWxpbGlAaHVhd2VpLmNvbT47DQo+IENocmlzdG9waGUg
Rm9udGFpbmUgPGNmb250YWluQHJlZGhhdC5jb20+OyBLb25zdGFudGluIEFuYW55ZXYgPGtvbnN0
YW50aW4udi5hbmFueWV2QHlhbmRleC5ydT47DQo+IFdhdGhzYWxhIFZpdGhhbmFnZSA8d2F0aHNh
bGEudml0aGFuYWdlQGFybS5jb20+OyBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3Rl
bXMuY29tPjsNCj4gc3RhYmxlQGRwZGsub3JnDQo+IFN1YmplY3Q6IFtQQVRDSF0gbWJ1ZjogZml4
IHJlYWQgcGFja2V0IGRhdGENCj4gDQo+IFRoZSBzdW0gb2Ygb2Zmc2V0ICsgbGVuZ3RoLCBib3Ro
IDMyIGJpdCB1bnNpZ25lZCBpbnRlZ2VycywgY291bGQgd3JhcA0KPiBhcm91bmQsIGNhdXNpbmcg
Y29tcGFyaXNvbnMgdG8gZ2l2ZSB0aGUgd3JvbmcgcmVzdWx0Lg0KPiBUaGlzIHdhcyBmaXhlZCBi
eSB1c2luZyA2NCBiaXQgaW5zdGVhZCBvZiAzMiBiaXQgZm9yIGNhbGN1bGF0aW5nIHRoZSBzdW0u
DQo+IA0KPiBOb3RlOg0KPiBXaGVuIHRoZSBicmFuY2ggaXMgbm90IHRha2VuIGZvciB0aGUgaW5p
dGlhbCAiaWYgKCh1aW50NjRfdClvZmYgKyBsZW4gPg0KPiBydGVfcGt0bWJ1Zl9wa3RfbGVuKG0p
KSIgY29tcGFyaXNvbiwgdGhlIHN1bSBpcyBrbm93biB0byBub3QgZXhjZWVkIHRoZQ0KPiBtYXhp
bXVtIHBvc3NpYmxlIHZhbHVlIG9mIHJ0ZV9wa3RtYnVmX3BrdF9sZW4obSksIFVJTlQzMl9NQVgs
IGFuZA0KPiBmb2xsb3dpbmcgc3VtIGNhbGN1bGF0aW9ucyBjYW4gcHJvY2VlZCB1c2luZyAzMiBi
aXQuDQo+IA0KPiBGaXhlczogYjg0MTEwZTdiYWEyICgibWJ1ZjogYWRkIGZ1bmN0aW9uIHRvIHJl
YWQgcGFja2V0IGRhdGEiKQ0KPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KPiAtLS0NCj4g
IGxpYi9tYnVmL3J0ZV9tYnVmLmMgfCAyICstDQo+ICBsaWIvbWJ1Zi9ydGVfbWJ1Zi5oIHwgMiAr
LQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvbGliL21idWYvcnRlX21idWYuYyBiL2xpYi9tYnVmL3J0ZV9tYnVm
LmMNCj4gaW5kZXggYTVkMTZlNGM5Ny4uYzI0NzZlNzcwNCAxMDA2NDQNCj4gLS0tIGEvbGliL21i
dWYvcnRlX21idWYuYw0KPiArKysgYi9saWIvbWJ1Zi9ydGVfbWJ1Zi5jDQo+IEBAIC03OTUsNyAr
Nzk1LDcgQEAgY29uc3Qgdm9pZCAqX19ydGVfcGt0bWJ1Zl9yZWFkKGNvbnN0IHN0cnVjdCBydGVf
bWJ1ZiAqbSwgdWludDMyX3Qgb2ZmLA0KPiAgCWNvbnN0IHN0cnVjdCBydGVfbWJ1ZiAqc2VnID0g
bTsNCj4gIAl1aW50MzJfdCBidWZfb2ZmID0gMCwgY29weV9sZW47DQo+IA0KPiAtCWlmIChvZmYg
KyBsZW4gPiBydGVfcGt0bWJ1Zl9wa3RfbGVuKG0pKQ0KPiArCWlmICgodWludDY0X3Qpb2ZmICsg
bGVuID4gcnRlX3BrdG1idWZfcGt0X2xlbihtKSkNCj4gIAkJcmV0dXJuIE5VTEw7DQo+IA0KPiAg
CXdoaWxlIChvZmYgPj0gcnRlX3BrdG1idWZfZGF0YV9sZW4oc2VnKSkgew0KPiBkaWZmIC0tZ2l0
IGEvbGliL21idWYvcnRlX21idWYuaCBiL2xpYi9tYnVmL3J0ZV9tYnVmLmgNCj4gaW5kZXggNTky
YWYyMzg4Yy4uZDY2MDJmNzRiYyAxMDA2NDQNCj4gLS0tIGEvbGliL21idWYvcnRlX21idWYuaA0K
PiArKysgYi9saWIvbWJ1Zi9ydGVfbWJ1Zi5oDQo+IEBAIC0xODQzLDcgKzE4NDMsNyBAQCBjb25z
dCB2b2lkICpfX3J0ZV9wa3RtYnVmX3JlYWQoY29uc3Qgc3RydWN0IHJ0ZV9tYnVmICptLCB1aW50
MzJfdCBvZmYsDQo+ICBzdGF0aWMgaW5saW5lIGNvbnN0IHZvaWQgKnJ0ZV9wa3RtYnVmX3JlYWQo
Y29uc3Qgc3RydWN0IHJ0ZV9tYnVmICptLA0KPiAgCXVpbnQzMl90IG9mZiwgdWludDMyX3QgbGVu
LCB2b2lkICpidWYpDQo+ICB7DQo+IC0JaWYgKGxpa2VseShvZmYgKyBsZW4gPD0gcnRlX3BrdG1i
dWZfZGF0YV9sZW4obSkpKQ0KPiArCWlmIChsaWtlbHkoKHVpbnQ2NF90KW9mZiArIGxlbiA8PSBy
dGVfcGt0bWJ1Zl9kYXRhX2xlbihtKSkpDQo+ICAJCXJldHVybiBydGVfcGt0bWJ1Zl9tdG9kX29m
ZnNldChtLCBjaGFyICosIG9mZik7DQo+ICAJZWxzZQ0KPiAgCQlyZXR1cm4gX19ydGVfcGt0bWJ1
Zl9yZWFkKG0sIG9mZiwgbGVuLCBidWYpOw0KPiAtLQ0KPiAyLjQzLjANCj4gDQoNCg==
