Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F96110775E7
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 16:37:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D1434026F;
	Wed, 18 Mar 2026 17:37:29 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 32DFC40150
 for <dev@dpdk.org>; Wed, 18 Mar 2026 17:37:28 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 140B320849;
 Wed, 18 Mar 2026 17:37:28 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] bpf/arm64: support packet data load instructions
Date: Wed, 18 Mar 2026 17:37:26 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657A1@smartserver.smartshare.dk>
In-Reply-To: <ea715be437174fa782f3ceb031debe0d@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [PATCH] bpf/arm64: support packet data load instructions
Thread-Index: AQHctXjoFxWXyTh3g0OC9SlGIQcTMrW0I+zwgAAX+/CAAAZ24IAABL0ggAAWnQCAABUq0IAACOLg
References: <20260310122045.4057836-1-cfontain@redhat.com><b10d0edcdaac4fd9a4f5a0261205670c@huawei.com><98CBD80474FA8B44BF855DF32C47DC35F6579F@smartserver.smartshare.dk><4942136acefe4fc3b5157191749fe3d5@huawei.com><98CBD80474FA8B44BF855DF32C47DC35F657A0@smartserver.smartshare.dk>
 <CAHVr2NmXSAhKO6EGjh_DDvdaUShPTWH-Eb1y1VrriQBAVnay4w@mail.gmail.com>
 <ea715be437174fa782f3ceb031debe0d@huawei.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Marat Khalili" <marat.khalili@huawei.com>,
 "Christophe Fontaine" <cfontain@redhat.com>
Cc: <dev@dpdk.org>, "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>
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

PiA+ID4gSW4gQ2xhc3NpYyBCUEYsIG5lZ2F0aXZlICJrIiBoYXMgc3BlY2lhbCBtZWFuaW5nIGZv
ciBib3RoIEJQRl9BQlMNCj4gYW5kIEJQRl9JTkQuDQo+ID4gPiBTbyB3ZSBzaG91bGQgY29uc2lk
ZXIgaXQgaW52YWxpZCBmb3IgYm90aCBjYXNlcy4NCj4gPiA+DQo+ID4gPiBUaGF0IHByZXZlbnRz
IGFwcGxpY2F0aW9ucyBmcm9tIHVzaW5nIGl0IHRoZSB3YXkgeW91IGRlc2NyaWJlLg0KPiA+ID4g
QW5kIGl0IHdpbGwgYWxsb3cgdXMgdG8gYWRkIEJQRiBsaWJyYXJ5IHN1cHBvcnQgZm9yIExpbnV4
LQ0KPiBjb21wYXRpYmxlIHNwZWNpYWwgbWVhbmluZ3MgbGF0ZXIsIHdpdGhvdXQNCj4gPiBicmVh
a2luZyB0aGUgQUJJLg0KPiA+ID4NCj4gPg0KPiA+IEFyZW4ndCB0aGVzZSBpbnZhbGlkIG9mZnNl
dHMgYWxyZWFkeSB0YWtlbiBjYXJlIGR1cmluZyB0aGUgc3ludGF4DQo+ID4gY2hlY2sgd2hlbiB3
ZSB2YWxpZGF0ZSB0aGUgQlBGIHByb2dyYW0gPw0KPiA+IGluIGJwZl92YWxpZGF0ZS5jICsxNDk5
Og0KPiA+ICAgICAgICAgLyogbG9hZCBhYnNvbHV0ZSBpbnN0cnVjdGlvbnMgKi8NCj4gPiAgICAg
ICAgIFsoQlBGX0xEIHwgQlBGX0FCUyB8IEJQRl9CKV0gPSB7DQo+ID4gICAgICAgICAgICAgICAg
IC5tYXNrID0gey4gZHJlZyA9IFpFUk9fUkVHLCAuc3JlZyA9IFpFUk9fUkVHfSwNCj4gPiAgICAg
ICAgICAgICAgICAgLm9mZiA9IHsgLm1pbiA9IDAsIC5tYXggPSAwfSwNCj4gPiAgICAgICAgICAg
ICAgICAgLmltbSA9IHsgLm1pbiA9IDAsIC5tYXggPSBJTlQzMl9NQVh9LA0KPiA+ICAgICAgICAg
ICAgICAgICAuZXZhbCA9IGV2YWxfbGRfbWJ1ZiwNCj4gPiAgICAgICAgIH0sDQo+ID4NCj4gPiBJ
SVVDLCBhcyBfX3J0ZV9icGZfdmFsaWRhdGUgZmFpbHMgd2hlbiB3ZSBjYWwgcnRlX2JwZl9sb2Fk
ICggaW4NCj4gPiBicGZfbG9hZC5jICsxMTMpLCB3ZSBjYW4ndCBldmVuIGludGVycHJldCB0aGUg
Y0JQRiBwcm9ncmFtLg0KPiANCj4gR29vZCBwb2ludCwgd2UgY2FuIHByb2JhYmx5IGNvbnNpZGVy
IEJQRl9BQlMgY2FzZSBjb3ZlcmVkIGJ5IHRoaXMuDQoNCkFncmVlLg0KDQo+IA0KPiBGb3IgQlBG
X0lORCBob3dldmVyIGl0IGRvZXMgbm90IHNlZW0gdG8gZXhjbHVkZSBhbnkgdmFsdWVzLCBhbmQg
ZXZlbiBpZg0KPiBpdCBkaWQNCj4gd2UgZG9uJ3Qga25vdyB3aGF0J3MgaW4gdGhlIHJlZ2lzdGVy
LiBTcGVha2luZyBvZiB3aGljaCwgSSBqdXN0IG5vdGljZWQNCj4gdGhhdA0KPiB3ZSdyZSB0cnVu
Y2F0aW5nIGl0Lg0KPiANCj4gSSBzdWdnZXN0IHRoZSBmb2xsb3dpbmcgbG9naWMgaW4gcHNldWRv
LWNvZGU6DQo+IA0KPiBzdGF0aWMgdm9pZA0KPiBlbWl0X2xkX21idWYoc3RydWN0IGE2NF9qaXRf
Y3R4ICpjdHgsIHVpbnQzMl90IG9wLCB1aW50OF90IHRtcDEsDQo+IHVpbnQ4X3QgdG1wMiwNCj4g
CXVpbnQ4X3Qgc3JjLCBpbnQzMl90IGltbSkNCj4gew0KPiAJLy8gLi4uDQo+IA0KPiAJLyogcjEg
PSBvZmY6IGZvciBBQlMgdXNlIGltbSwgZm9yIElORCB1c2Ugc3JjICsgaW1tICovDQo+IAlpZiAo
bW9kZSA9PSBCUEZfQUJTKSB7DQo+IAkJYXNzZXJ0IGltbSA+PSAwLCAidmVyaWZpZWQgYnkgdmVy
aWZpZXIiDQo+IAkJZW1pdCBNT1YgVzEsICM8aW1tPg0KPiAJfSBlbHNlIHsNCj4gCQkvKiBhZGQg
c2lnbmVkIGltbSB0byB0aGUgc291cmNlIHJlZ2lzdGVyICovDQo+IAkJZW1pdChzKSBYMSA9IHNy
YyArICM8aW1tPg0KPiAJCS8qIHZlcmlmeSBkeW5hbWljYWxseSB0aGF0IG9mZnNldCBpcyB3aXRo
aW4gdGhlIGRvbWFpbiBvZg0KPiBfX3J0ZV9wa3RtYnVmX3JlYWQgKi8NCj4gCQllbWl0KHMpIGp1
bXBfdG9fZXBpbG9ndWUgaWYgWDEgPHMgMCB8fCBYMSA+IElOVDMyX01BWA0KPiAJfQ0KPiANCj4g
CS8vIC4uLg0KPiB9DQoNCkkgZG9uJ3Qga25vdyBpZiBpdCdzIHRoZSBzdW0gb2Ygc3JjK2ltbSB0
aGF0IGRldGVybWluZXMgc3BlY2lhbCBtZWFuaW5nLCBvciBpdCdzIHRoZSBpbW0gaXRzZWxmLg0K
SWYgaXQncyB0aGUgaW1tIGl0c2VsZiwgYSBzaW1wbGUgZml4IHdvdWxkIGJlIHRvIHVwZGF0ZSB0
aGUgdmFsaWRhdG9yJ3MgLmltbS5tYXggdmFsdWVzIGZvciBCUEZfSU5EIGZyb20gVUlOVDMyX01B
WCB0byBJTlQzMl9NQVguDQoNCg0K
