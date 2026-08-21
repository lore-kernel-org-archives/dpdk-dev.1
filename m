Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A76BC5DF88
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 06:37:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A54804028C;
	Fri, 21 Aug 2026 08:37:02 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 4C45A4027B
 for <dev@dpdk.org>; Fri, 21 Aug 2026 08:37:01 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2072D20FDE;
 Fri, 21 Aug 2026 08:37:01 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH 03/61] test: use memcpy instead of rte_memcpy
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 21 Aug 2026 08:37:01 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A09@smartserver.smartshare.dk>
In-Reply-To: <20260820092248.06008fc0@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 03/61] test: use memcpy instead of rte_memcpy
Thread-Index: Ad0wwC9o2ukqM7MPTGSV+hnD7TwV2wAdtSNA
References: <20260820052251.1453273-1-stephen@networkplumber.org><20260820052251.1453273-4-stephen@networkplumber.org><98CBD80474FA8B44BF855DF32C47DC35F659FC@smartserver.smartshare.dk>
 <20260820092248.06008fc0@phoenix.local>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>, "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
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

PiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3BsdW1iZXIu
b3JnXQ0KPiBTZW50OiBUaHVyc2RheSwgMjAgQXVndXN0IDIwMjYgMTguMjMNCj4gDQo+IE9uIFRo
dSwgMjAgQXVnIDIwMjYgMDg6MjI6MDkgKzAyMDANCj4gTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0
c2hhcmVzeXN0ZW1zLmNvbT4gd3JvdGU6DQo+IA0KPiA+ID4NCj4gPiA+ICBzdGF0aWMgaW5saW5l
IHZvaWQNCj4gPiA+ICBjb3B5X2J1Zl90b19wa3Qodm9pZCAqYnVmLCB1bnNpZ25lZCBsZW4sIHN0
cnVjdCBydGVfbWJ1ZiAqcGt0LA0KPiA+ID4gdW5zaWduZWQgb2Zmc2V0KQ0KPiA+ID4gIHsNCj4g
PiA+ICAJaWYgKG9mZnNldCArIGxlbiA8PSBwa3QtPmRhdGFfbGVuKSB7DQo+ID4gPiAtCQlydGVf
bWVtY3B5KHJ0ZV9wa3RtYnVmX210b2Rfb2Zmc2V0KHBrdCwgY2hhciAqLCBvZmZzZXQpLA0KPiA+
ID4gYnVmLA0KPiA+ID4gKwkJbWVtY3B5KHJ0ZV9wa3RtYnVmX210b2Rfb2Zmc2V0KHBrdCwgY2hh
ciAqLCBvZmZzZXQpLCBidWYsDQo+ID4gPiAgCQkJICAgKHNpemVfdCkgbGVuKTsNCj4gPg0KPiA+
IEl0IGxvb2tzIGxpa2Ugc2l6ZSBpcyBub3QgY29uc3RhbnQgaW4gdGhlIGFib3ZlIGluc3RhbmNl
cy4NCj4gPg0KPiA+IFRyeSB3cml0aW5nIGFuIGludGVybWVkaWF0ZSB3cmFwcGVyIHVzaW5nIF9f
cnRlX2NvbnN0YW50KCkgdG8gdmVyaWZ5DQo+IGF0IGJ1aWxkIHRpbWUuDQo+ID4gU29tZXRoaW5n
IGxpa2UgKGFzc3VtaW5nIHRoZSByZXR1cm4gdmFsdWUgaXMgdW51c2VkKToNCj4gPg0KPiA+ICNk
ZWZpbmUgcnRlX21lbWNweV9jb25zdF9zaXplKGRzdCwgc3JjLCBuKSBcDQo+ID4gZG8geyBcDQo+
ID4gCVJURV9CVUlMRF9CVUdfT04oIV9fcnRlX2NvbnN0YW50KG4pKTsgXA0KPiA+IAltZW1jcHko
ZHN0LCBzcmMsIG4pOyBcDQo+ID4gfSB3aGlsZSAoMCkNCj4gDQo+IFRoZSBnb2FsIG9mIHRoaXMg
c2VyaWVzIGlzIHRvIGhpdCBhcyBtYW55IHBsYWNlcyB3aGVyZSBydGVfbWVtY3B5DQo+IGlzIHVu
bmVjZXNzYXJ5LiBGb3IgdGVzdHMsIHRoaXMgaW5jbHVkZXMgYWxsIHRlc3RzIGV4Y2VwdCB0aG9z
ZSB0ZXN0cw0KPiBzcGVjaWZpY2FsbHkgdGFyZ2V0aW5nIHRlc3RpbmcgcnRlX21lbWNweS4NCg0K
T0suIEkgYWdyZWUgd2l0aCB0aGF0Lg0KVGhlbiB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gbmVlZHMg
YW4gdXBkYXRlOyBpdCBvbmx5IG1lbnRpb25zIGZpeGVkLXNpemUgY29waWVzLg0KQWxzbyB0aGUg
Y292ZXIgbGV0dGVyIHNob3VsZCBtZW50aW9uIHRoYXQgdGVzdHMgcmVwbGFjZSBhbGwgdXNlcyBv
ZiBydGVfbWVtY3B5KCksIG5vdCBqdXN0IGZpeGVkLXNpemUgY29waWVzLg0KDQpBY2tlZC1ieTog
TW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCg0K
