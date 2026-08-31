Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9F1C61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 09:05:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9E4D4025A;
	Mon, 31 Aug 2026 11:05:46 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 07406400D5
 for <dev@dpdk.org>; Mon, 31 Aug 2026 11:05:46 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D819920441;
 Mon, 31 Aug 2026 11:05:45 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v3 1/2] stack: introduce pile
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 31 Aug 2026 11:05:44 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A23@smartserver.smartshare.dk>
In-Reply-To: <ec4ba9b4d8f34eb78e86a5ccc2a01a89@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 1/2] stack: introduce pile
Thread-Index: AQHdNivZlPLzR2W88UagmX4dOkumu7a33NkwgAACqiA=
References: <20260812134756.1829613-1-mb@smartsharesystems.com>
 <20260827135556.522443-1-mb@smartsharesystems.com>
 <20260827135556.522443-2-mb@smartsharesystems.com>
 <ec4ba9b4d8f34eb78e86a5ccc2a01a89@huawei.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, <dev@dpdk.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>
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
d2VpLmNvbV0NCj4gU2VudDogTW9uZGF5LCAzMSBBdWd1c3QgMjAyNiAxMC41MA0KPiANCj4gPiBB
ZGRlZCBhIG5ldyBoaWdoLXBlcmZvcm1hbmNlIGxvY2stZnJlZSAicGlsZSIsIHVzaW5nIHRoZSBT
dGFjayBBUEkuDQo+ID4gVGhlIHBpbGUgYmVoYXZlcyByb3VnaGx5IGxpa2UgYSBzdGFjaywgYnV0
IGlzIG5vdCBzdHJpY3RseSBMSUZPLg0KPiA+DQo+ID4gVGhlIHBpbGUgaXMgb3B0aW1pemVkIGZv
ciBwdXNoaW5nL3BvcHBpbmcgYnVsa3Mgb2Ygb2JqZWN0cywgd2hpY2gNCj4gPiBpdCBkb2VzIHNp
Z25pZmljYW50bHkgZmFzdGVyIHRoYW4gdGhlIGxvY2stZnJlZSBzdGFjay4NCj4gPg0KPiA+IFB1
c2hpbmcvcG9wcGluZyBhIG51bWJlciBvZiBvYmplY3RzIG5vdCBkaXZpc2libGUgYnkgdGhlIGNv
bXBpbGUgdGltZQ0KPiA+IGNvbmZpZ3VyYWJsZSBidWxrIHNpemUgaXMgaGFuZGxlZCBncmFjZWZ1
bGx5LCBidXQgbm90IGFzIGZhc3QgYXMNCj4gPiBjb21wbGV0ZSBidWxrcy4NCj4gPg0KPiA+IFBl
cmZvcm1hbmNlIGV4YW1wbGVzLCBzdGFja19waWxlX3BlcmZfYXV0b3Rlc3QgdnMuIHN0YWNrX2xm
X2F1dG90ZXN0Og0KPiA+DQo+ID4gT24gYSBzaW5nbGUgY29yZSwgcHVzaGluZy9wb3BwaW5nIDEg
b3IgOCBvYmplY3RzIGlzIHNpbWlsYXIgc3BlZWQuDQo+ID4gT24gYSBzaW5nbGUgY29yZSwgcHVz
aGluZy9wb3BwaW5nIDMyIG9iamVjdHMgaXMgMnggZmFzdGVyLg0KPiA+IE9uIGEgc2luZ2xlIGNv
cmUsIHB1c2hpbmcvcG9wcGluZyA1MTIgb2JqZWN0cyBpcyAxMHggZmFzdGVyLg0KPiA+DQo+ID4g
T24gZm91ciBjb3JlcywgcHVzaGluZy9wb3BwaW5nIDEsIDggb3IgMzIgb2JqZWN0cyBpcyBzbGln
aHRseSBmYXN0ZXIuDQo+ID4gT24gZm91ciBjb3JlcywgcHVzaGluZy9wb3BwaW5nIDUxMiBvYmpl
Y3RzIGlzIDR4IGZhc3Rlci4NCj4gDQo+IEFja2VkLWJ5OiBLb25zdGFudGluIEFuYW55ZXYgPGtv
bnN0YW50aW4uYW5hbnlldkBodWF3ZWkuY29tPg0KPiANCj4gVGhlIGNvZGUgaXRzZWxmIGxvb2tz
IG9rIHRvIG1lLCB0aG91Z2h0IEkgc3RpbGwgdGhpbmsgaXQgaXMgd29ydGggdG8NCj4gY29uc2lk
ZXINCj4gbW92aW5nIGxmX3BpbGUgKGFuZCBsZl9zdGFjaykgRFAgaW1wbGVtZW50YXRpb24gaW4g
LmMsIHRvIGF2b2lkIGVhY2gNCj4gcnRlX3N0YWNrX3B1cy9wb3ANCj4gdG8gaW5saW5lIGFsbCB0
aHJlZSBvZiB0aGVtLg0KDQpJZiBhIHVzZSBjYXNlIGtub3dzIHRoZSBzZWxlY3RlZCBzdGFjayBp
bXBsZW1lbnQgYXQgYnVpbGQgdGltZSwgaXQgY2FuIGNhbGwgdGhlIGltcGxlbWVudGF0aW9uJ3Mg
cHVzaC9wb3AgZnVuY3Rpb25zIGRpcmVjdGx5Lg0KSSB1cGRhdGVkIHRoZSBtZW1wb29sIHN0YWNr
IGRyaXZlciB2MyBwYXRjaCBbMV0gdG8gZG8gdGhpcyBmb3IgYWxsIHRocmVlIHN0YWNrIGltcGxl
bWVudGF0aW9ucy4NCg0KWzFdOiBodHRwczovL3BhdGNod29yay5kcGRrLm9yZy9wcm9qZWN0L2Rw
ZGsvcGF0Y2gvMjAyNjA4MjcxMzU1NTYuNTIyNDQzLTMtbWJAc21hcnRzaGFyZXN5c3RlbXMuY29t
Lw0KDQo+IE15IHNwZWN1bGF0aW9uIGlzIHRoYXQgdGhlIHBlcmYgZGlmZiBmb3IgYnVsayBlbnF1
ZXVlL2RlcXVldWUgYmVjYXVzZQ0KPiBvZg0KPiB0aGF0IHdvdWxkIGJlIG5lZ2xpZ2libGUsIHdo
aWxlIGJvdGggYXJlIHF1aXRlIGJpZyBmb3IgaW5saW5pbmcgdGhlbQ0KPiBhbHdheXMNCj4gKHNw
ZWNpYWxseSBsZl9waWxlKS4NCg0KSWYgdGhlIG51bWJlciBvZiBvYmplY3RzIGJlaW5nIHB1c2hl
ZC9wb3BwZWQgaXMga25vd24gYXQgYnVpbGQgdGltZSwgdGhlIGNvbXBpbGVyIGNhbiBvcHRpbWl6
ZSB0aGUgZnVuY3Rpb25zIHdoZW4gaW5saW5lZC4NCg0KSSB0cmllZCBleHBlcmltZW50ZWQgd2l0
aCBjb25kaXRpb25hbCBpbmxpbmluZyBkZXBlbmRpbmcgb24gdGhlIG51bWJlciBvZiBvYmplY3Rz
IGJlaW5nIGtub3duIGF0IGJ1aWxkIHRpbWUsIGJ1dCBJIHdhc24ndCByZWFsbHkgcGxlYXNlZCB3
aXRoIGl0Lg0KDQo=
