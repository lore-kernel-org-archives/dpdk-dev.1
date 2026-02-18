Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633C2E9A02C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 17:32:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D14C40269;
	Wed, 18 Feb 2026 18:32:34 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 414294014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 18:32:33 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0C3B620C18;
 Wed, 18 Feb 2026 18:32:33 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [RFC] ethdev: clarify rte_eth_tx_burst() return value and
 ownership semantics
Date: Wed, 18 Feb 2026 18:32:29 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6572B@smartserver.smartshare.dk>
In-Reply-To: <20260218091324.17a671dd@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] ethdev: clarify rte_eth_tx_burst() return value and
 ownership semantics
Thread-Index: Adyg+efjHSK/Y8YdQme6dVjxtJXdGAAAQY4A
References: <20260216180011.393782-1-stephen@networkplumber.org><98CBD80474FA8B44BF855DF32C47DC35F65728@smartserver.smartshare.dk>
 <20260218091324.17a671dd@phoenix.local>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>, "Thomas Monjalon" <thomas@monjalon.net>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 <bruce.richardson@intel.com>
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
b3JnXQ0KPiBTZW50OiBXZWRuZXNkYXksIDE4IEZlYnJ1YXJ5IDIwMjYgMTguMTMNCj4gDQo+IE9u
IFdlZCwgMTggRmViIDIwMjYgMDk6NDg6MDQgKzAxMDANCj4gTW9ydGVuIEJyw7hydXAgPG1iQHNt
YXJ0c2hhcmVzeXN0ZW1zLmNvbT4gd3JvdGU6DQo+IA0KPiA+ID4gKyAqDQo+ID4gPiArICogQSBy
ZXR1cm4gdmFsdWUgZXF1YWwgdG8gKm5iX3BrdHMqIG1lYW5zIHRoYXQgYWxsIHBhY2tldHMgaGF2
ZQ0KPiBiZWVuDQo+ID4gPiArICogY29uc3VtZWQsIGFuZCB0aGlzIGlzIGxpa2VseSB0byBzaWdu
aWZ5IHRoYXQgb3RoZXIgb3V0cHV0DQo+IHBhY2tldHMNCj4gPiA+ICAgKiBjb3VsZCBiZSBpbW1l
ZGlhdGVseSB0cmFuc21pdHRlZCBhZ2Fpbi4gQXBwbGljYXRpb25zIHRoYXQNCj4gaW1wbGVtZW50
DQo+ID4gPiBhDQo+ID4gPiAgICogInNlbmQgYXMgbWFueSBwYWNrZXRzIHRvIHRyYW5zbWl0IGFz
IHBvc3NpYmxlIiBwb2xpY3kgY2FuIGNoZWNrDQo+ID4gPiB0aGlzDQo+ID4gPiAgICogc3BlY2lm
aWMgY2FzZSBhbmQga2VlcCBpbnZva2luZyB0aGUgcnRlX2V0aF90eF9idXJzdCgpIGZ1bmN0aW9u
DQo+ID4gPiB1bnRpbA0KPiA+ID4gICAqIGEgdmFsdWUgbGVzcyB0aGFuICpuYl9wa3RzKiBpcyBy
ZXR1cm5lZC4NCj4gPiA+ICAgKg0KPiA+ID4gKyAqIElmIGEgcGFja2V0IGNhbm5vdCBiZSB0cmFu
c21pdHRlZCBkdWUgdG8gYW4gZXJyb3IgKGZvciBleGFtcGxlLA0KPiBhbg0KPiA+ID4gKyAqIGlu
dmFsaWQgb2ZmbG9hZCBmbGFnKSwgdGhlIGRyaXZlciBtdXN0IHN0aWxsIGNvbnN1bWUgaXQgYW5k
DQo+IGZyZWUNCj4gPiA+IHRoZQ0KPiA+ID4gKyAqIG1idWYsIHJhdGhlciB0aGFuIHN0b3BwaW5n
IGF0IHRoYXQgcG9pbnQuIFN1Y2ggcGFja2V0cyBzaG91bGQNCj4gYmUNCj4gPiA+ICsgKiBjb3Vu
dGVkIGluIHRoZSAqdHhfZXJyb3JzKiBwb3J0IHN0YXRpc3RpYy4NCj4gPg0KPiA+IFRoZSBhYm92
ZSBwYXJhZ3JhcGggaXMgZHJpdmVyIGNlbnRyaWMsIGl0IHNob3VsZCBiZSBhcHBsaWNhdGlvbg0K
PiBjZW50cmljLg0KPiANCj4gTW9zdCBvZiB0aGUgYXBwbGljYXRpb25zIGFyZSBkb2luZyBpdCBy
aWdodCBhbHJlYWR5IHNpbmNlIGV2ZXJ5Ym9keQ0KPiBzdGFydHMgd2l0aCBsMmZ3ZCwgb3IgbDNm
d2QuIFRoZSBwcm9ibGVtIEkgc2VlIGlzIGJ1Z2d5IGRyaXZlcnMuDQoNCkkgYWdyZWUuDQpCdXQg
dGhpcyBBUEkgaXMgZm9yIGFwcGxpY2F0aW9ucywgc28gaXRzIGRvY3VtZW50YXRpb24gc2hvdWxk
IGJlIHdyaXR0ZW4gZm9yIGFwcGxpY2F0aW9uIGRldmVsb3BlcnMuDQoNCkRyaXZlcnMgYXJlIGRv
aW5nIGl0IHdyb25nIGJlY2F1c2UgZHJpdmVyIEFQSXMgYXJlIGxhcmdlbHkgdW5kb2N1bWVudGVk
LCBlLmcuIFsyXSBhbmQgWzNdLg0KWzJdOiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9kcGRr
L3YyNS4xMS9zb3VyY2UvbGliL2V0aGRldi9ydGVfZXRoZGV2X2NvcmUuaCNMMzMNClszXTogaHR0
cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vZHBkay92MjUuMTEvc291cmNlL2xpYi9tZW1wb29sL3J0
ZV9tZW1wb29sLmgjTDQ3OA0KDQpJdCB3b3VsZCBiZSBhbiBpbXByb3ZlbWVudCBpZiBkcml2ZXIg
QVBJIGRvY3VtZW50YXRpb24gYXQgbGVhc3QgcmVmZXJyZWQgdG8gdGhlIGFwcGxpY2F0aW9uIEFQ
SXMgdGhhdCB3cmFwIHRoZW0uDQoNCj4gDQo+ID4gU3VnZ2VzdCByZXBocmFzaW5nIGFzOg0KPiA+
DQo+ID4gSWYgYSBwYWNrZXQgY2Fubm90IGJlIHRyYW5zbWl0dGVkIGR1ZSB0byBhbiBlcnJvciAo
Zm9yIGV4YW1wbGUsIGFuDQo+IGludmFsaWQgb2ZmbG9hZCBmbGFnKSwgdGhlIHJ0ZV9ldGhfdHhf
YnVyc3QoKSBmdW5jdGlvbiB3aWxsIHN0aWxsDQo+IGNvbnN1bWUgaXQsIHJhdGhlciB0aGFuIHN0
b3BwaW5nIGF0IHRoYXQgcG9pbnQuDQo+ID4gU3VjaCBwYWNrZXRzIGFyZSBjb3VudGVkIGluIHRo
ZSAqb2Vycm9ycyogcG9ydCBzdGF0aXN0aWMuDQo+ID4NCj4gPiBOQjogSW4gc3RydWN0IHJ0ZV9l
dGhfc3RhdHMgWzFdLCB0aGUgZXJyb3IgY291bnRlciBpcyBuYW1lZA0KPiAib2Vycm9ycyIsIG5v
dCAidHhfZXJyb3JzIi4NCj4gPg0KPiA+IFsxXToNCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5j
b20vZHBkay92MjUuMTEvc291cmNlL2xpYi9ldGhkZXYvcnRlX2V0aGRldi5oI0wNCj4gMjczDQo+
IA0KPiBHb29kIHBvaW50LCBJIHdhcyB0aGlua2luZyBvZiB0aGUgcGVyLXF1ZXVlIHN0YXRzIGFu
ZCB4c3RhdHMuDQo+IA0KPiA+IFdoaWxlIGRpc2N1c3NpbmcgZGV0YWlscy4uLg0KPiA+IExldCdz
IHNheSBhIHBhY2tldCBoYXMgNCBzZWdtZW50cywgYW5kIHRoZSBkcml2ZXIgb25seSBoYXMgMg0K
PiBkZXNjcmlwdG9ycyByZW1haW5pbmcgYXZhaWxhYmxlLg0KPiA+IEluIHRoYXQgY2FzZSwgSSB0
aGluayB0aGUgZHJpdmVyIHNob3VsZCBub3QgY29uc3VtZSB0aGUgcGFja2V0LCBidXQNCj4gbGVh
dmUgaXQgZm9yIHRoZSBhcHBsaWNhdGlvbiB0byBlaXRoZXIgZHJvcCBpdCBvciByZXRyeSB0cmFu
c21pdHRpbmcgaXQNCj4gbGF0ZXIuDQo+ID4gRG8gd2Ugd2FudCB0byBtZW50aW9uIHRoaXMgY2Fz
ZSB0b28sIG9yIGlzIGl0IGEgc2VtaS1vYnZpb3VzIGNhc2Ugb2YNCj4gdGhlIGRlc2NyaXB0b3Ig
cmluZyBoYXZpbmcgbm8gbW9yZSByb29tPw0KPiANCj4gVGhlcmUgYXJlIGFsc28gb3RoZXIgY2Fz
ZXMgb2YgYmFja3ByZXNzdXJlIGxpa2Ugd2hlbiBkcml2ZXIgdGFsa3MgdG8NCj4ga2VybmVsIGFu
ZCBnZXRzIEVBR0FJTiBvciBFQlVTWQ0KDQo=
