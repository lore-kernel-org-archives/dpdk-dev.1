Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60189C5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 10:09:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74D2D4060C;
	Thu,  5 Jun 2025 12:09:06 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D0F704060C
 for <dev@dpdk.org>; Thu,  5 Jun 2025 12:09:04 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B188F20467;
 Thu,  5 Jun 2025 12:09:04 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v4 23/25] net/intel: support wider x86 vectors for Rx rearm
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 5 Jun 2025 12:09:02 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FCC9@smartserver.smartshare.dk>
In-Reply-To: <e9a7a3e8-2154-4c4f-9846-5d2241627d36@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4 23/25] net/intel: support wider x86 vectors for Rx
 rearm
Thread-Index: AdvV/F4ZUlXwWiGNR9yObrHKhiwx5QAA0L/w
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <b7864d189e468484a6af5aa774ed566b2a37818f.1748612804.git.anatoly.burakov@intel.com>
 <aEBfPb8Imy6nemXw@bricha3-mobl1.ger.corp.intel.com>
 <e9a7a3e8-2154-4c4f-9846-5d2241627d36@intel.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
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

PiBGcm9tOiBCdXJha292LCBBbmF0b2x5IFttYWlsdG86YW5hdG9seS5idXJha292QGludGVsLmNv
bV0NCj4gU2VudDogVGh1cnNkYXksIDUgSnVuZSAyMDI1IDExLjI5DQo+IA0KPiBPbiA2LzQvMjAy
NSA0OjU5IFBNLCBCcnVjZSBSaWNoYXJkc29uIHdyb3RlOg0KPiA+IE9uIEZyaSwgTWF5IDMwLCAy
MDI1IGF0IDAyOjU3OjE5UE0gKzAxMDAsIEFuYXRvbHkgQnVyYWtvdiB3cm90ZToNCj4gPj4gQ3Vy
cmVudGx5LCBmb3IgMzItYnl0ZSBkZXNjcmlwdG9yIGZvcm1hdCwgb25seSBTU0UgaW5zdHJ1Y3Rp
b24gc2V0DQo+IGlzDQo+ID4+IHN1cHBvcnRlZC4gQWRkIGltcGxlbWVudGF0aW9uIGZvciBBVlgy
IGFuZCBBVlg1MTIgaW5zdHJ1Y3Rpb24gc2V0cy4NCj4gU2luY2UNCj4gPj4gd2UgYXJlIHVzaW5n
IFJ4IGRlc2NyaXB0b3IgZGVmaW5pdGlvbnMgZnJvbSBjb21tb24gY29kZSwgd2UgY2FuIGp1c3QN
Cj4gdXNlDQo+ID4+IHRoZSBnZW5lcmljIGRlc2NyaXB0b3IgZGVmaW5pdGlvbiwgYXMgd2Ugb25s
eSBldmVyIHdyaXRlIHRoZSBmaXJzdA0KPiAxNiBieXRlcw0KPiA+PiBvZiBpdCwgYW5kIHRoZSBs
YXlvdXQgaXMgYWx3YXlzIHRoZSBzYW1lIGZvciB0aGF0IHBhcnQuDQo+ID4+DQo+ID4+IFNpZ25l
ZC1vZmYtYnk6IEFuYXRvbHkgQnVyYWtvdiA8YW5hdG9seS5idXJha292QGludGVsLmNvbT4NCj4g
Pj4gLS0tDQo+ID4+DQo+ID4NCj4gPiBMaWtlIHRoZSBpZGVhLiBGZWVkYmFjayBpbmxpbmUgYmVs
b3cuDQo+ID4NCj4gPiAvQnJ1Y2UNCj4gPg0KPiANCj4gPHNuaXA+DQo+IA0KPiA+PiAtCQkvKioN
Cj4gPj4gLQkJICogbWVyZ2UgMCAmIDEsIGJ5IGNhc3RpbmcgMCB0byAyNTYtYml0IGFuZCBpbnNl
cnRpbmcgMQ0KPiA+PiAtCQkgKiBpbnRvIHRoZSBoaWdoIGxhbmVzLiBTaW1pbGFybHkgZm9yIDIg
JiAzDQo+ID4+IC0JCSAqLw0KPiA+PiAtCQljb25zdCBfX20yNTZpIHZhZGRyMF8yNTYgPSBfbW0y
NTZfY2FzdHNpMTI4X3NpMjU2KHZhZGRyMCk7DQo+ID4+IC0JCWNvbnN0IF9fbTI1NmkgdmFkZHIy
XzI1NiA9IF9tbTI1Nl9jYXN0c2kxMjhfc2kyNTYodmFkZHIyKTsNCj4gPj4gKwkJCWNvbnN0IF9f
bTEyOGkgdmFkZHIwID0gX21tX2xvYWR1X3NpMTI4KChjb25zdCBfX20xMjhpDQo+ICopJm1iMC0+
YnVmX2FkZHIpOw0KPiA+PiArCQkJY29uc3QgX19tMTI4aSB2YWRkcjEgPSBfbW1fbG9hZHVfc2kx
MjgoKGNvbnN0IF9fbTEyOGkNCj4gKikmbWIxLT5idWZfYWRkcik7DQo+ID4NCj4gPiBNaW5vciBu
aXQsIGJ1dCBkbyB3ZSBuZWVkIHRvIHVzZSB1bmFsaWduZWQgbG9hZHMgaGVyZT8gVGhlIG1idWYg
aXMNCj4gbWFya2VkDQo+ID4gYXMgY2FjaGUtYWxpZ25lZCwgYW5kIGJ1Zl9hZGRyIGlzIHRoZSBm
aXJzdCBmaWVsZCBpbiBpdC4NCj4gDQo+IEl0IHdhcyBsaWtlIHRoYXQgaW4gdGhlIG9yaWdpbmFs
IGNvZGUgSSB0aGluayAodW5sZXNzIGl0IHdhcyBhDQo+IGNvcHlwYXN0ZQ0KPiBlcnJvciksIGJ1
dCBzdXJlLCBJIGNhbiBtYWtlIGl0IGFsaWduZWQuDQoNCkkgd29uZGVyIGlmIHRoZSBjb21waWxl
ciBlbWl0cyBhIHdhcm5pbmcgaWYgaXQgY2FuIGRldGVjdCB0aGF0IHRoZSBhZGRyZXNzIG9mIGFu
IGFsaWduZWQgbG9hZCBpbnN0cnVjdGlvbiBpcyBub3QgYWxpZ25lZC4NCg0KQXMgYSBzYWZlZ3Vh
cmQgYWdhaW5zdCBmdXR1cmUgbWJ1ZiBjaGFuZ2VzLCB5b3UgY291bGQgYWRkIGEgc3RhdGljX2Fz
c2VydCB0aGF0IHRoZSBidWZfYWRkciBmaWVsZCBpcyBwcm9wZXJseSBhbGlnbmVkLg0KDQpQUzoN
CkFjY29yZGluZyB0byB0aGUgSW50ZWwgSW50cmluc2ljcyBHdWlkZSBbMV0sIHVuYWxpZ25lZCBs
b2FkIGFwcGVhcnMgdG8gaGF2ZSB0aGUgZXhhY3Qgc2FtZSBwZXJmb3JtYW5jZSBhcyBhbGlnbmVk
IGxvYWQsIHNvIGl0IHNob3VsZG4ndCBtYWtlIGEgcHJhY3RpY2FsIGRpZmZlcmVuY2Ugd2l0aCBj
dXJyZW50IENQVXMuDQpCdXQgaXQgbWlnaHQgbWFrZSBhIGRpZmZlcmVuY2Ugb24gZnV0dXJlIENQ
VXMsIGFuZCB3aXRoIG5vIG5lZWQgZm9yIHVuYWxpZ25lZCBsb2FkLCBJJ20gYWxzbyBpbiBmYXZv
ciBvZiBhbGlnbmVkIGxvYWQgaGVyZS4NCg0KWzFdOiBodHRwczovL3d3dy5pbnRlbC5jb20vY29u
dGVudC93d3cvdXMvZW4vZG9jcy9pbnRyaW5zaWNzLWd1aWRlL2luZGV4Lmh0bWwNCiANCg==
