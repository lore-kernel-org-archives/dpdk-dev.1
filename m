Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5E7E63F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 05:57:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FF5D40289;
	Mon, 16 Feb 2026 06:57:00 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 98F5940269
 for <dev@dpdk.org>; Mon, 16 Feb 2026 06:56:58 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5550D20F80;
 Mon, 16 Feb 2026 06:56:58 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH 03/10] net/tap: clarify TUN/TAP flag assignment
Date: Mon, 16 Feb 2026 06:56:54 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6571D@smartserver.smartshare.dk>
In-Reply-To: <20260215164730.0f36bdf4@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 03/10] net/tap: clarify TUN/TAP flag assignment
Thread-Index: Adye3dxCbtnZu2E+QUGNAS6cBrvOWgAKrVPQ
References: <20260215195348.557945-1-stephen@networkplumber.org><20260215195348.557945-4-stephen@networkplumber.org><98CBD80474FA8B44BF855DF32C47DC35F6571C@smartserver.smartshare.dk>
 <20260215164730.0f36bdf4@phoenix.local>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
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

PiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3BsdW1iZXIu
b3JnXQ0KPiBTZW50OiBNb25kYXksIDE2IEZlYnJ1YXJ5IDIwMjYgMDEuNDgNCj4gDQo+IE9uIFN1
biwgMTUgRmViIDIwMjYgMjI6NDU6NTMgKzAxMDANCj4gTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0
c2hhcmVzeXN0ZW1zLmNvbT4gd3JvdGU6DQo+IA0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4NCj4gPiA+IC0t
LQ0KPiA+ID4gIGRyaXZlcnMvbmV0L3RhcC9ydGVfZXRoX3RhcC5jIHwgNyArKysrKy0tDQo+ID4g
PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+
DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdGFwL3J0ZV9ldGhfdGFwLmMNCj4gPiA+
IGIvZHJpdmVycy9uZXQvdGFwL3J0ZV9ldGhfdGFwLmMNCj4gPiA+IGluZGV4IGFhMjM2Y2Y5Njcu
LjMxYzhjMTg1ZTkgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC90YXAvcnRlX2V0aF90
YXAuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdGFwL3J0ZV9ldGhfdGFwLmMNCj4gPiA+IEBA
IC0xNTQsOCArMTU0LDExIEBAIHR1bl9hbGxvYyhzdHJ1Y3QgcG1kX2ludGVybmFscyAqcG1kLCBp
bnQNCj4gPiA+IGlzX2tlZXBhbGl2ZSwgaW50IHBlcnNpc3RlbnQpDQo+ID4gPiAgCSAqIERvIG5v
dCBzZXQgSUZGX05PX1BJIGFzIHBhY2tldCBpbmZvcm1hdGlvbiBoZWFkZXIgd2lsbCBiZQ0KPiA+
ID4gbmVlZGVkDQo+ID4gPiAgCSAqIHRvIGNoZWNrIGlmIGEgcmVjZWl2ZWQgcGFja2V0IGhhcyBi
ZWVuIHRydW5jYXRlZC4NCj4gPiA+ICAJICovDQo+ID4gPiAtCWlmci5pZnJfZmxhZ3MgPSAocG1k
LT50eXBlID09IEVUSF9UVU5UQVBfVFlQRV9UQVApID8NCj4gPiA+IC0JCUlGRl9UQVAgOiBJRkZf
VFVOIHwgSUZGX1BPSU5UT1BPSU5UOw0KPiA+DQo+ID4gRm9yIHVuY29uZGl0aW9uYWwgYXNzaWdu
bWVudCwgSSBwcmVmZXIgdGVybmFyeSBleHByZXNzaW9uIG92ZXINCj4gaWYvZWxzZS4NCj4gPiBJ
ZiB5b3Ugd2FudCB0byBpbXByb3ZlIHJlYWRhYmlsaXR5IGluc3RlYWQgb2YgcmVseWluZyBvbiBv
cGVyYXRvcg0KPiBwcmVjZWRlbmNlLCBzdWdnZXN0Og0KPiA+DQo+ID4gCWlmci5pZnJfZmxhZ3Mg
PSAocG1kLT50eXBlID09IEVUSF9UVU5UQVBfVFlQRV9UQVApID8NCj4gPiAJCQlJRkZfVEFQIDog
KElGRl9UVU4gfCBJRkZfUE9JTlRPUE9JTlQpOw0KPiANCj4gDQo+IEkgd2FzIHByZS1jb25kaXRp
b25lZCBieSBNUyBzdHlsZSBndWlkZSBsaW5lcyB0aGF0IGFsd2F5cyBjYWxsZWQgb3V0DQo+IGV4
Y2Vzc2l2ZSB1c2Ugb2YgdGVybmFyeSBhcyBjb25mdXNpbmcNCg0KSnVzdCB0ZXN0ZWQgb24gR29k
Ym9sdDsgR0NDLCBDbGFuZyBhbmQgTVNWQyBlbWl0cyBzaW1pbGFyIGNvZGUgZm9yIHRlcm5hcnkg
YW5kIGlmL2Vsc2UsIHNvIGl0J3Mgb25seSBhIG1hdHRlciBvZiBwcmVmZXJlbmNlLg0KDQpTaW5j
ZSBpdCdzIGFuIHVuY29uZGl0aW9uYWwgYXNzaWdubWVudCwgSSBwcmVmZXIgdGVybmFyeS4NClRl
cm5hcnkgYWxzbyB3b3JrcyB3aGVuIGluaXRpYWxpemluZyBhIHZhcmlhYmxlIHdpdGggaXRzIGRl
Y2xhcmF0aW9uLiBBbmQgd2l0aCBhc3NpZ25pbmcgZmllbGQgdmFsdWVzIHRvIHN0cnVjdHVyZXMu
DQoNCldlbGwuLi4gaXQncyB5b3VyIGNvZGUsIHNvIEknbGwgbGVhdmUgeW91IHdpdGggdGhlIGRl
Y2lzaW9uLiA7LSkNCg0K
