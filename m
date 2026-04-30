Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E46CD13D3
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 18:35:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA7C74021F;
	Thu, 30 Apr 2026 20:35:02 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 70A4B400D6
 for <dev@dpdk.org>; Thu, 30 Apr 2026 20:35:01 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 531EE205F2;
 Thu, 30 Apr 2026 20:35:00 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] ring: add cache guard after ring elements table
Date: Thu, 30 Apr 2026 20:34:54 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65835@smartserver.smartshare.dk>
In-Reply-To: <e1fa27a3450f4bc5ab0c12bcfb07f694@huawei.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ring: add cache guard after ring elements table
Thread-Index: AQHc0XkQlTcfmwaszE+wFaHNWAZ9L7X358TAgAAS8tA=
References: <20260421102358.118204-1-mb@smartsharesystems.com>
 <e1fa27a3450f4bc5ab0c12bcfb07f694@huawei.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, <dev@dpdk.org>,
 "Konstantin Ananyev" <konstantin.v.ananyev@yandex.ru>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>
Cc: "David Marchand" <david.marchand@redhat.com>
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

PiBGcm9tOiBLb25zdGFudGluIEFuYW55ZXYgW21haWx0bzprb25zdGFudGluLmFuYW55ZXZAaHVh
d2VpLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIDMwIEFwcmlsIDIwMjYgMTkuMjINCj4gDQo+IEhp
IE1vcnRlbiwNCj4gDQo+ID4gQWRkZWQgY2FjaGUgZ3VhcmQgYWZ0ZXIgdGhlIHRhYmxlIGhvbGRp
bmcgdGhlIHJpbmcgZWxlbWVudHMsIHRvIGF2b2lkDQo+ID4gZmFsc2Ugc2hhcmluZyBjb25mbGlj
dHMgY2F1c2VkIGJ5IG5leHQtbGluZSBoYXJkd2FyZSBwcmVmZXRjaGVycyB3aGVuDQo+ID4gYWNj
ZXNzaW5nIGVsZW1lbnRzIGF0IHRoZSBlbmQgb2YgdGhlIHJpbmcgdGFibGUuDQo+IA0KPiBJIGRv
bid0IHNlZSBhbnkgaGFybSB3aXRoIGl0LCBhbmQgaW4gdGhlb3J5IGl0IG1pZ2h0IGhlbHAgaW4g
c29tZQ0KPiBjYXNlcy4uLg0KPiBUaG91Z2ggSSB3b25kZXIgaG93IHJlYWwgaXMgdGhhdCBwcm9i
bGVtPw0KPiBEaWQgeW91IGV2ZXIgb2JzZXJ2ZSBzdWNoIGNvbnRlbnRpb24gdG8gaGFwcGVuPw0K
DQpJIG5ldmVyIG9ic2VydmVkIGEgcHJvYmxlbSB3aXRoIHRoaXMuDQpUaGUgcmlzayBvZiBjb250
ZW50aW9uIGRlcGVuZHMgb24gd2hhdCBpcyBhbGxvY2F0ZWQgaW4gdGhlIG1lbW9yeSBhZnRlciB0
aGUgcmluZy4gV2hpY2ggaXMgYXBwbGljYXRpb24gc3BlY2lmaWMuDQoNCkl0IHNlZW1zIGxpa2Ug
YSBwdXJlbHkgdGhlb3JldGljYWwgaXNzdWUsIGJ1dCBzaG91bGQgYmUgZml4ZWQgYW55d2F5LCB0
byBlbGltaW5hdGUgdGhhdCByaXNrLg0KDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1vcnRlbiBC
csO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQo+ID4gLS0tDQo+ID4gIGxpYi9yaW5n
L3J0ZV9yaW5nLmMgfCAzICsrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbGliL3JpbmcvcnRlX3JpbmcuYyBiL2xpYi9yaW5nL3J0
ZV9yaW5nLmMNCj4gPiBpbmRleCBmMTAwNTBhMWM0Li45Y2NjNjJjZDQyIDEwMDY0NA0KPiA+IC0t
LSBhL2xpYi9yaW5nL3J0ZV9yaW5nLmMNCj4gPiArKysgYi9saWIvcmluZy9ydGVfcmluZy5jDQo+
ID4gQEAgLTczLDggKzczLDExIEBAIHJ0ZV9yaW5nX2dldF9tZW1zaXplX2VsZW0odW5zaWduZWQg
aW50IGVzaXplLA0KPiB1bnNpZ25lZA0KPiA+IGludCBjb3VudCkNCj4gPiAgCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gPiAgCX0NCj4gPg0KPiA+ICsJc3RhdGljX2Fzc2VydChzaXplb2Yoc3RydWN0IHJ0
ZV9yaW5nKSA9PQ0KPiA+IFJURV9DQUNIRV9MSU5FX1JPVU5EVVAoc2l6ZW9mKHN0cnVjdCBydGVf
cmluZykpLA0KPiA+ICsJCQkiU2l6ZSBvZiBzdHJ1Y3QgcnRlX3Jpbmcgbm90IGNhY2hlIGxpbmUg
YWxpZ25lZCIpOw0KPiA+ICAJc3ogPSBzaXplb2Yoc3RydWN0IHJ0ZV9yaW5nKSArIChzc2l6ZV90
KWNvdW50ICogZXNpemU7DQo+ID4gIAlzeiA9IFJURV9BTElHTihzeiwgUlRFX0NBQ0hFX0xJTkVf
U0laRSk7DQo+ID4gKwlzeiArPSBSVEVfQ0FDSEVfR1VBUkRfTElORVMgKiBSVEVfQ0FDSEVfTElO
RV9TSVpFOw0KPiA+ICAJcmV0dXJuIHN6Ow0KPiA+ICB9DQo+ID4NCj4gPiAtLQ0KPiA+IDIuNDMu
MA0KDQo=
