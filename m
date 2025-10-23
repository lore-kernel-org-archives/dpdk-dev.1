Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F285CCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 11:17:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7803402C3;
	Thu, 23 Oct 2025 13:17:23 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A25F640151
 for <dev@dpdk.org>; Thu, 23 Oct 2025 13:17:22 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4D9AA2041E;
 Thu, 23 Oct 2025 13:17:22 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v5] mbuf: optimize segment prefree
Date: Thu, 23 Oct 2025 13:17:20 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654F7@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <c556ea7b92a24bc09ac5240da39bc36c@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5] mbuf: optimize segment prefree
Thread-Index: AQHcQ/NUxCpzFpnLEUCegFLyVmlwCLTPa7AAgAAngXA=
References: <20250827213535.21602-1-mb@smartsharesystems.com>
 <20251023080136.165513-1-mb@smartsharesystems.com>
 <c556ea7b92a24bc09ac5240da39bc36c@huawei.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, <dev@dpdk.org>,
 "Stephen Hemminger" <stephen@networkplumber.org>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Fengchengwen" <fengchengwen@huawei.com>,
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
d2VpLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIDIzIE9jdG9iZXIgMjAyNSAxMC41MQ0KPiANCj4g
PiAtI2RlZmluZSBSVEVfTUJVRl9ESVJFQ1QobWIpIFwNCj4gPiAtCSghKChtYiktPm9sX2ZsYWdz
ICYgKFJURV9NQlVGX0ZfSU5ESVJFQ1QgfCBSVEVfTUJVRl9GX0VYVEVSTkFMKSkpDQo+ID4gKyAq
DQo+ID4gKyAqIE5vdGU6IE1hY3JvIG9wdGltaXplZCBmb3IgY29kZSBzaXplLg0KPiA+ICsgKg0K
PiA+ICsgKiBUaGUgcGxhaW4gbWFjcm8gd291bGQgYmU6DQo+ID4gKyAqICAgICAgI2RlZmluZSBS
VEVfTUJVRl9ESVJFQ1QobWIpIFwNCj4gPiArICogICAgICAgICAgKCEoKG1iKS0+b2xfZmxhZ3Mg
JiAoUlRFX01CVUZfRl9JTkRJUkVDVCB8DQo+IFJURV9NQlVGX0ZfRVhURVJOQUwpKSkNCj4gPiAr
ICoNCj4gPiArICogVGhlIGZsYWdzIFJURV9NQlVGX0ZfSU5ESVJFQ1QgYW5kIFJURV9NQlVGX0Zf
RVhURVJOQUwgYXJlIGJvdGggaW4NCj4gdGhlDQo+ID4gTVNCIChtb3N0IHNpZ25pZmljYW50DQo+
ID4gKyAqIGJ5dGUpIG9mIHRoZSA2NC1iaXQgb2xfZmxhZ3MgZmllbGQsIHNvIHdlIG9ubHkgY29t
cGFyZSB0aGlzIG9uZQ0KPiBieXRlIGluc3RlYWQgb2YgYWxsDQo+ID4gNjQgYml0cy4NCj4gPiAr
ICoNCj4gPiArICogRS5nLiwgR0NDIHZlcnNpb24gMTYuMC4wIDIwMjUxMDE5IChleHBlcmltZW50
YWwpIGdlbmVyYXRlcyB0aGUNCj4gZm9sbG93aW5nIGNvZGUNCj4gPiBmb3IgeDg2LTY0Lg0KPiA+
ICsgKg0KPiA+ICsgKiBXaXRoIHRoZSBwbGFpbiBtYWNybywgMTcgYnl0ZXMgb2YgaW5zdHJ1Y3Rp
b25zOg0KPiA+ICsgKiAgICAgIG1vdmFicyByYXgsMHg2MDAwMDAwMDAwMDAwMDAwICAgICAgIC8v
IDEwIGJ5dGVzDQo+ID4gKyAqICAgICAgYW5kICAgIHJheCxRV09SRCBQVFIgW3JkaSsweDE4XSAg
ICAgLy8gNCBieXRlcw0KPiA+ICsgKiAgICAgIHNldGUgICBhbCAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC8vIDMgYnl0ZXMNCj4gPiArICogV2l0aCB0aGlzIG9wdGltaXplZCBtYWNybywgb25s
eSA3IGJ5dGVzIG9mIGluc3RydWN0aW9uczoNCj4gPiArICogICAgICB0ZXN0ICAgQllURSBQVFIg
W3JkaSsweDFmXSwweDYwICAgICAvLyA0IGJ5dGVzDQo+ID4gKyAqICAgICAgc2V0ZSAgIGFsICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLy8gMyBieXRlcw0KPiA+ICsgKi8NCj4gPiArI2lmIFJU
RV9CWVRFX09SREVSID09IFJURV9MSVRUTEVfRU5ESUFODQo+ID4gKy8qIE9uIGxpdHRsZSBlbmRp
YW4gYXJjaGl0ZWN0dXJlLCB0aGUgTVNCIG9mIGEgNjQtYml0IGludGVnZXIgaXMgYXQNCj4gYnl0
ZSBvZmZzZXQgNy4gKi8NCj4gPiArI2RlZmluZSBSVEVfTUJVRl9ESVJFQ1QobWIpICAgICAhKCgo
Y29uc3QgY2hhciAqKSgmKG1iKS0NCj4gPm9sX2ZsYWdzKSlbN10gJiAweDYwKQ0KPiA+ICsjZWxp
ZiBSVEVfQllURV9PUkRFUiA9PSBSVEVfQklHX0VORElBTg0KPiA+ICsvKiBPbiBiaWcgZW5kaWFu
IGFyY2hpdGVjdHVyZSwgdGhlIE1TQiBvZiBhIDY0LWJpdCBpbnRlZ2VyIGlzIGF0DQo+IGJ5dGUg
b2Zmc2V0IDAuICovDQo+ID4gKyNkZWZpbmUgUlRFX01CVUZfRElSRUNUKG1iKSAgICAgISgoKGNv
bnN0IGNoYXIgKikoJihtYiktDQo+ID5vbF9mbGFncykpWzBdICYgMHg2MCkNCj4gDQo+IEEgc3R1
cGlkIHE6IHdoeSB0aGVuIG5vdCBzaW1wbHkgZG86DQo+IChtYi0+b2xfZmxhZ3MgPj4gNTYpICYg
MHg2MA0KPiB0aGVuPw0KPiBTaG91bGQgaGVscCB0byBhbGwgdGhlc2UgTEUvQkUgY2FzdHMsIGV0
Yy4NCg0KR0NDIGlzIHRvbyBzdHVwaWQgZm9yIHRoYXQgdG9vLg0KDQpQbGF5aW5nIGFyb3VuZCB3
aXRoIEdvZGJvbHQgc2hvd3MgdGhhdA0KCXJldHVybiAhKChjaGFyKShwWzNdID4+IDU2KSAmIDB4
NjApOw0KYmVjb21lcw0KCW1vdnp4ICBlYXgsQllURSBQVFIgW3JkaSsweDFmXQkvLyA0IGJ5dGVz
DQoJdGVzdCAgIGFsLDB4NjAJCQkJLy8gMiBieXRlcw0KSW5zdGVhZCBvZiBzaW1wbHkNCgl0ZXN0
ICAgQllURSBQVFIgW3JkaSsweDFmXSwweDYwCS8vIDQgYnl0ZXMNCg0KR29vZCBzdWdnZXN0aW9u
LCB0aG91Z2guDQoNCj4gDQo+ID4gKyNlbmRpZg0KPiA+ICsvKiBWZXJpZnkgdGhlIG9wdGltaXph
dGlvbiBhYm92ZS4gKi8NCj4gPiArc3RhdGljX2Fzc2VydCgoUlRFX01CVUZfRl9JTkRJUkVDVCB8
IFJURV9NQlVGX0ZfRVhURVJOQUwpID09DQo+ID4gVUlOVDY0X0MoMHg2MCkgPDwgKDcgKiBDSEFS
X0JJVCksDQo+ID4gKwkiKFJURV9NQlVGX0ZfSU5ESVJFQ1QgfCBSVEVfTUJVRl9GX0VYVEVSTkFM
KSBpcyBub3QgMHg2MCBhdA0KPiBNU0IiKTsNCj4gPg0KPiA+ICAvKiogVW5pbml0aWFsaXplZCBv
ciB1bnNwZWNpZmllZCBwb3J0LiAqLw0KPiA+ICAjZGVmaW5lIFJURV9NQlVGX1BPUlRfSU5WQUxJ
RCBVSU5UMTZfTUFYDQo+ID4gLS0NCj4gPiAyLjQzLjANCg0K
