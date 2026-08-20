Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED92C5DF82
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 06:22:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4019240150;
	Thu, 20 Aug 2026 08:22:16 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 4A36F400EF
 for <dev@dpdk.org>; Thu, 20 Aug 2026 08:22:14 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C89F6207DD;
 Thu, 20 Aug 2026 08:22:11 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH 03/61] test: use memcpy instead of rte_memcpy
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 20 Aug 2026 08:22:09 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659FC@smartserver.smartshare.dk>
In-Reply-To: <20260820052251.1453273-4-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 03/61] test: use memcpy instead of rte_memcpy
Thread-Index: Ad0wZAOYtShxTr/WSI2yCIuS5fsBCAABk9tw
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260820052251.1453273-4-stephen@networkplumber.org>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Marat Khalili" <marat.khalili@huawei.com>,
 "Jasvinder Singh" <jasvinder.singh@intel.com>,
 "Akhil Goyal" <gakhil@marvell.com>, "Fan Zhang" <fanzhang.oss@gmail.com>,
 "Yipeng Wang" <yipeng1.wang@intel.com>,
 "Abhinandan Gujjar" <abhinandan.gujjar@intel.com>,
 "Jerin Jacob" <jerinj@marvell.com>, "Chas Williams" <3chas3@gmail.com>,
 "Min Hu (Connor)" <humin29@huawei.com>,
 "Sameh Gobriel" <sameh.gobriel@intel.com>,
 "Sachin Saxena" <sachin.saxena@nxp.com>,
 "Hemant Agrawal" <hemant.agrawal@nxp.com>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Anoob Joseph" <anoobj@marvell.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>
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

PiBkaWZmIC0tZ2l0IGEvYXBwL3Rlc3QvcGFja2V0X2J1cnN0X2dlbmVyYXRvci5jDQo+IGIvYXBw
L3Rlc3QvcGFja2V0X2J1cnN0X2dlbmVyYXRvci5jDQo+IGluZGV4IDRjMTc3Mzc3MzkuLjJmMWQ3
NWM1YmMgMTAwNjQ0DQo+IC0tLSBhL2FwcC90ZXN0L3BhY2tldF9idXJzdF9nZW5lcmF0b3IuYw0K
PiArKysgYi9hcHAvdGVzdC9wYWNrZXRfYnVyc3RfZ2VuZXJhdG9yLmMNCj4gQEAgLTMxLDIwICsz
MSwyMCBAQCBjb3B5X2J1Zl90b19wa3Rfc2Vncyh2b2lkICpidWYsIHVuc2lnbmVkIGxlbiwNCj4g
c3RydWN0IHJ0ZV9tYnVmICpwa3QsDQo+ICAJY29weV9sZW4gPSBzZWctPmRhdGFfbGVuIC0gb2Zm
c2V0Ow0KPiAgCXNlZ19idWYgPSBydGVfcGt0bWJ1Zl9tdG9kX29mZnNldChzZWcsIGNoYXIgKiwg
b2Zmc2V0KTsNCj4gIAl3aGlsZSAobGVuID4gY29weV9sZW4pIHsNCj4gLQkJcnRlX21lbWNweShz
ZWdfYnVmLCBidWYsIChzaXplX3QpIGNvcHlfbGVuKTsNCj4gKwkJbWVtY3B5KHNlZ19idWYsIGJ1
ZiwgKHNpemVfdCkgY29weV9sZW4pOw0KPiAgCQlsZW4gLT0gY29weV9sZW47DQo+ICAJCWJ1ZiA9
ICgoY2hhciAqKSBidWYgKyBjb3B5X2xlbik7DQo+ICAJCXNlZyA9IHNlZy0+bmV4dDsNCj4gIAkJ
c2VnX2J1ZiA9IHJ0ZV9wa3RtYnVmX210b2Qoc2VnLCB2b2lkICopOw0KPiAgCX0NCj4gLQlydGVf
bWVtY3B5KHNlZ19idWYsIGJ1ZiwgKHNpemVfdCkgbGVuKTsNCj4gKwltZW1jcHkoc2VnX2J1Ziwg
YnVmLCAoc2l6ZV90KSBsZW4pOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyBpbmxpbmUgdm9pZA0KPiAg
Y29weV9idWZfdG9fcGt0KHZvaWQgKmJ1ZiwgdW5zaWduZWQgbGVuLCBzdHJ1Y3QgcnRlX21idWYg
KnBrdCwNCj4gdW5zaWduZWQgb2Zmc2V0KQ0KPiAgew0KPiAgCWlmIChvZmZzZXQgKyBsZW4gPD0g
cGt0LT5kYXRhX2xlbikgew0KPiAtCQlydGVfbWVtY3B5KHJ0ZV9wa3RtYnVmX210b2Rfb2Zmc2V0
KHBrdCwgY2hhciAqLCBvZmZzZXQpLA0KPiBidWYsDQo+ICsJCW1lbWNweShydGVfcGt0bWJ1Zl9t
dG9kX29mZnNldChwa3QsIGNoYXIgKiwgb2Zmc2V0KSwgYnVmLA0KPiAgCQkJICAgKHNpemVfdCkg
bGVuKTsNCg0KSXQgbG9va3MgbGlrZSBzaXplIGlzIG5vdCBjb25zdGFudCBpbiB0aGUgYWJvdmUg
aW5zdGFuY2VzLg0KDQpUcnkgd3JpdGluZyBhbiBpbnRlcm1lZGlhdGUgd3JhcHBlciB1c2luZyBf
X3J0ZV9jb25zdGFudCgpIHRvIHZlcmlmeSBhdCBidWlsZCB0aW1lLg0KU29tZXRoaW5nIGxpa2Ug
KGFzc3VtaW5nIHRoZSByZXR1cm4gdmFsdWUgaXMgdW51c2VkKToNCg0KI2RlZmluZSBydGVfbWVt
Y3B5X2NvbnN0X3NpemUoZHN0LCBzcmMsIG4pIFwNCmRvIHsgXA0KCVJURV9CVUlMRF9CVUdfT04o
IV9fcnRlX2NvbnN0YW50KG4pKTsgXA0KCW1lbWNweShkc3QsIHNyYywgbik7IFwNCn0gd2hpbGUg
KDApDQoNCg0K
