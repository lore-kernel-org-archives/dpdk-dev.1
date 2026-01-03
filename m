Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E174EFC617C
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Jan 2026 17:41:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BA0A40267;
	Sat,  3 Jan 2026 18:41:32 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1595140262
 for <dev@dpdk.org>; Sat,  3 Jan 2026 18:41:31 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 021ED208CF
 for <dev@dpdk.org>; Sat,  3 Jan 2026 18:41:31 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] mbuf: optimize detach direct buffer
Date: Sat, 3 Jan 2026 18:41:29 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65619@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260103173454.121220-1-mb@smartsharesystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mbuf: optimize detach direct buffer
Thread-Index: Adx810qgw9amoHBqSWuU2D8jpYjUpgAANmXw
References: <20260103173454.121220-1-mb@smartsharesystems.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, <dev@dpdk.org>
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

UGxlYXNlIGlnbm9yZSB0aGlzIG9uZS4NCkl0IGhhcyBhIGNvcHktcGFzdGUgZXJyb3IgaW4gdGhl
IGRlc2NyaXB0aW9uLg0KDQpWZW5saWcgaGlsc2VuIC8gS2luZCByZWdhcmRzLA0KLU1vcnRlbiBC
csO4cnVwDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTW9ydGVuIEJy
w7hydXAgW21haWx0bzptYkBzbWFydHNoYXJlc3lzdGVtcy5jb21dDQo+IFNlbnQ6IFNhdHVyZGF5
LCAzIEphbnVhcnkgMjAyNiAxOC4zNQ0KPiBUbzogZGV2QGRwZGsub3JnDQo+IENjOiBNb3J0ZW4g
QnLDuHJ1cA0KPiBTdWJqZWN0OiBbUEFUQ0hdIG1idWY6IG9wdGltaXplIGRldGFjaCBkaXJlY3Qg
YnVmZmVyDQo+IA0KPiBkb2Vzbid0IHdyaXRlIHRoZSBmaWVsZHMgdGhhdCBhbHJlYWR5IGhhdmUg
dGhlIHJlcXVpcmVkIHZhbHVlcy4gVGhpcw0KPiBzYXZlcyBhIG1lbW9yeSBzdG9yZSBvcGVyYXRp
b24gd2hlbiBhbGwgdGhlIGZpZWxkcyBhbHJlYWR5IGhhdmUgdGhlDQo+IHJlcXVpcmVkIHZhbHVl
cy4NCj4gDQo+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgc2FtZSBvcHRpbWl6YXRpb24gdG8gX19ydGVf
cGt0bWJ1Zl9mcmVlX2RpcmVjdCgpLA0KPiB0byBpbXByb3ZlIHRoZSBwZXJmb3JtYW5jZSBmb3Ig
ZnJlZWluZyBhIGRpcmVjdCBidWZmZXIgYmVpbmcgZGV0YWNoZWQNCj4gZnJvbQ0KPiBhIHBhY2tl
dCBtYnVmLCBpLmUuIHNhdmluZyBhIG1lbW9yeSBzdG9yZSBvcGVyYXRpb24gd2hlbiBhbGwgdGhl
IGZpZWxkcw0KPiAob2YgdGhlIGJ1ZmZlciBiZWluZyBmcmVlZCkgYWxyZWFkeSBoYXZlIHRoZSBy
ZXF1aXJlZCB2YWx1ZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8bWJA
c21hcnRzaGFyZXN5c3RlbXMuY29tPg0KPiAtLS0NCj4gIGxpYi9tYnVmL3J0ZV9tYnVmLmggfCAx
NiArKysrKysrKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwg
NSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9saWIvbWJ1Zi9ydGVfbWJ1Zi5oIGIv
bGliL21idWYvcnRlX21idWYuaA0KPiBpbmRleCAyMDA0MzkxZjU3Li41OTJhZjIzODhjIDEwMDY0
NA0KPiAtLS0gYS9saWIvbWJ1Zi9ydGVfbWJ1Zi5oDQo+ICsrKyBiL2xpYi9tYnVmL3J0ZV9tYnVm
LmgNCj4gQEAgLTEzMzQsMTcgKzEzMzQsMjMgQEAgc3RhdGljIGlubGluZSB2b2lkDQo+ICBfX3J0
ZV9wa3RtYnVmX2ZyZWVfZGlyZWN0KHN0cnVjdCBydGVfbWJ1ZiAqbSkNCj4gIHsNCj4gIAlzdHJ1
Y3QgcnRlX21idWYgKm1kOw0KPiArCWJvb2wgcmVmY250X25vdF9vbmU7DQo+IA0KPiAgCVJURV9B
U1NFUlQoUlRFX01CVUZfQ0xPTkVEKG0pKTsNCj4gDQo+ICAJbWQgPSBydGVfbWJ1Zl9mcm9tX2lu
ZGlyZWN0KG0pOw0KPiANCj4gLQlpZiAocnRlX21idWZfcmVmY250X3VwZGF0ZShtZCwgLTEpID09
IDApIHsNCj4gLQkJbWQtPm5leHQgPSBOVUxMOw0KPiAtCQltZC0+bmJfc2VncyA9IDE7DQo+ICsJ
cmVmY250X25vdF9vbmUgPSB1bmxpa2VseShydGVfbWJ1Zl9yZWZjbnRfcmVhZChtZCkgIT0gMSk7
DQo+ICsJaWYgKHJlZmNudF9ub3Rfb25lICYmIF9fcnRlX21idWZfcmVmY250X3VwZGF0ZShtZCwg
LTEpICE9IDApDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCWlmIChyZWZjbnRfbm90X29uZSkNCj4g
IAkJcnRlX21idWZfcmVmY250X3NldChtZCwgMSk7DQo+IC0JCXJ0ZV9tYnVmX3Jhd19mcmVlKG1k
KTsNCj4gLQl9DQo+ICsJaWYgKG1kLT5uYl9zZWdzICE9IDEpDQo+ICsJCW1kLT5uYl9zZWdzID0g
MTsNCj4gKwlpZiAobWQtPm5leHQgIT0gTlVMTCkNCj4gKwkJbWQtPm5leHQgPSBOVUxMOw0KPiAr
CXJ0ZV9tYnVmX3Jhd19mcmVlKG1kKTsNCj4gIH0NCj4gDQo+ICAvKioNCj4gLS0NCj4gMi40My4w
DQoNCg==
