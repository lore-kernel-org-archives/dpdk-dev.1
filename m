Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30675D116E2
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 15:55:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B6E140281;
	Fri, 28 Nov 2025 16:55:26 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D7F77400EF
 for <dev@dpdk.org>; Fri, 28 Nov 2025 16:55:24 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A6FE220698;
 Fri, 28 Nov 2025 16:55:24 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Subject: RE: [PATCH v3] eal/x86: optimize memcpy of small sizes
Content-Transfer-Encoding: base64
Date: Fri, 28 Nov 2025 16:55:23 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6559E@smartserver.smartshare.dk>
In-Reply-To: <59db9d3d83d94ec9a7c26ae506fd4813@huawei.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3] eal/x86: optimize memcpy of small sizes
Thread-Index: AQHcWtNXD+EKJWk0k0O6HEmUv7nh0LUIKREQgAAduhA=
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20251121104052.1273637-1-mb@smartsharesystems.com>
 <59db9d3d83d94ec9a7c26ae506fd4813@huawei.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, <dev@dpdk.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Konstantin Ananyev" <konstantin.v.ananyev@yandex.ru>,
 "Vipin Varghese" <vipin.varghese@amd.com>
Cc: "Stephen Hemminger" <stephen@networkplumber.org>
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
d2VpLmNvbV0NCj4gU2VudDogRnJpZGF5LCAyOCBOb3ZlbWJlciAyMDI1IDE1LjAzDQo+IA0KPiA+
ICsvKioNCj4gPiArICogQ29weSBieXRlcyBmcm9tIG9uZSBsb2NhdGlvbiB0byBhbm90aGVyLA0K
PiA+ICsgKiBsb2NhdGlvbnMgc2hvdWxkIG5vdCBvdmVybGFwLg0KPiA+ICsgKiBVc2Ugd2l0aCBu
IDw9IDE2Lg0KPiA+ICsgKg0KPiA+ICsgKiBOb3RlOiBDb3B5aW5nIHVuaW5pdGlhbGl6ZWQgbWVt
b3J5IGlzIHBlcmZlY3RseSBhY2NlcHRhYmxlLg0KPiA+ICsgKiBVc2luZyBlLmcuIG1lbWNweShk
c3QsIHNyYywgOCkgaW5zdGVhZCBvZg0KPiA+ICsgKiAqKHVuYWxpZ25lZF91aW50NjRfdCopID0g
Kihjb25zdCB1bmFsaWduZWRfdWludDY0X3QgKilzcmMNCj4gPiArICogYXZvaWRzIGNvbXBpbGVy
IHdhcm5pbmdzIGFib3V0IHNvdXJjZSBkYXRhIG1heSBiZSB1bmluaXRpYWxpemVkDQo+ID4gKyAq
IFstV21heWJlLXVuaW5pdGlhbGl6ZWRdLg0KPiA+ICsgKg0KPiA+ICsgKiBOb3RlOiBVc2luZyAi
biAmIFgiIGdlbmVyYXRlcyAzLWJ5dGUgInRlc3QiIGluc3RydWN0aW9ucywNCj4gPiArICogaW5z
dGVhZCBvZiAibiA+PSBYIiwgd2hpY2ggd291bGQgZ2VuZXJhdGUgNC1ieXRlICJjbXAiDQo+IGlu
c3RydWN0aW9ucy4NCj4gPiArICovDQo+ID4gK3N0YXRpYyBfX3J0ZV9hbHdheXNfaW5saW5lIHZv
aWQgKg0KPiA+ICtydGVfbW92MTZfb3JfbGVzcyh2b2lkICpkc3QsIGNvbnN0IHZvaWQgKnNyYywg
c2l6ZV90IG4pDQo+ID4gK3sNCj4gPiArCS8qIEZhc3RlciB3YXkgd2hlbiBzaXplIGlzIGtub3du
IGF0IGJ1aWxkIHRpbWUuICovDQo+ID4gKwlpZiAoX19ydGVfY29uc3RhbnQobikpIHsNCj4gPiAr
CQlpZiAobiA9PSAyKQ0KPiA+ICsJCQlyZXR1cm4gbWVtY3B5KGRzdCwgc3JjLCAyKTsNCj4gPiAr
CQlpZiAobiA9PSA0KQ0KPiA+ICsJCQlyZXR1cm4gbWVtY3B5KGRzdCwgc3JjLCA0KTsNCj4gPiAr
CQlpZiAobiA9PSA2KSAvKiA0ICsgMiAqLw0KPiA+ICsJCQlyZXR1cm4gbWVtY3B5KGRzdCwgc3Jj
LCA2KTsNCj4gPiArCQlpZiAobiA9PSA4KQ0KPiA+ICsJCQlyZXR1cm4gbWVtY3B5KGRzdCwgc3Jj
LCA4KTsNCj4gPiArCQlpZiAobiA9PSAxMCkgLyogOCArIDIgKi8NCj4gPiArCQkJcmV0dXJuIG1l
bWNweShkc3QsIHNyYywgMTApOw0KPiA+ICsJCWlmIChuID09IDEyKSAvKiA4ICsgNCAqLw0KPiA+
ICsJCQlyZXR1cm4gbWVtY3B5KGRzdCwgc3JjLCAxMik7DQo+ID4gKwkJaWYgKG4gPT0gMTYpIHsN
Cj4gPiArCQkJcnRlX21vdjE2KCh1aW50OF90ICopZHN0LCAoY29uc3QgdWludDhfdCAqKXNyYyk7
DQo+ID4gKwkJCXJldHVybiBkc3Q7DQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWlm
IChuICYgMHgxOCkgeyAvKiBuID49IDggKi8NCj4gDQo+IFByb2JhYmx5ICduICYgMHg4Jz8NCg0K
SXQncyBpbnRlbnRpb25hbCwgdG8gY2F0Y2ggbiA9PSAweDEwIHRvby4NCkl0IHNlZW1zIHRoZSBh
c3NvY2lhdGVkIGNvbW1lbnQgc2hvdWxkIGJlIG1vcmUgdmVyYm9zZS4gSG93IGFib3V0Og0KaWYg
KG4gJiAweDE4KSB7IC8qIG4gPj0gOCwgaW5jbHVkaW5nIG4gPT0gMHgxMCwgaGVuY2UgbiAmIDB4
MTggKi8NCg0KPiANCj4gPiArCQkvKiBjb3B5IDggfiAxNiBieXRlcyAqLw0KPiA+ICsJCW1lbWNw
eShkc3QsIHNyYywgOCk7DQo+ID4gKwkJbWVtY3B5KCh1aW50OF90ICopZHN0IC0gOCArIG4sIChj
b25zdCB1aW50OF90ICopc3JjIC0gOCArDQo+IG4sIDgpOw0KPiA+ICsJfSBlbHNlIGlmIChuICYg
MHg0KSB7DQo+ID4gKwkJLyogY29weSA0IH4gNyBieXRlcyAqLw0KPiA+ICsJCW1lbWNweShkc3Qs
IHNyYywgNCk7DQo+ID4gKwkJbWVtY3B5KCh1aW50OF90ICopZHN0IC0gNCArIG4sIChjb25zdCB1
aW50OF90ICopc3JjIC0gNCArDQo+IG4sIDQpOw0KPiA+ICsJfSBlbHNlIGlmIChuICYgMHgyKSB7
DQo+ID4gKwkJLyogY29weSAyIH4gMyBieXRlcyAqLw0KPiA+ICsJCW1lbWNweShkc3QsIHNyYywg
Mik7DQo+ID4gKwkJbWVtY3B5KCh1aW50OF90ICopZHN0IC0gMiArIG4sIChjb25zdCB1aW50OF90
ICopc3JjIC0gMiArDQo+IG4sIDIpOw0KPiA+ICsJfSBlbHNlIGlmIChuICYgMHgxKSB7DQo+ID4g
KwkJLyogY29weSAxIGJ5dGUgKi8NCj4gPiArCQltZW1jcHkoZHN0LCBzcmMsIDEpOw0KPiA+ICsJ
fQ0KPiA+ICsJcmV0dXJuIGRzdDsNCj4gPiArfQ0K
