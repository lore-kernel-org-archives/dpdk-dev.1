Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E52D2ED12
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 15:01:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBD4940E3A;
	Tue, 20 Jan 2026 16:01:27 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id DFE5740E32
 for <dev@dpdk.org>; Tue, 20 Jan 2026 16:01:25 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0178920D99;
 Tue, 20 Jan 2026 16:01:24 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v3 1/6] test/soring: fix buffer overflow warnings with LTO
Date: Tue, 20 Jan 2026 16:01:21 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6567F@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260120063413.72e0d725@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 1/6] test/soring: fix buffer overflow warnings with LTO
Thread-Index: AdyKGd3/aQA5xuztSCChwPwpFDdm3QAAq/dg
References: <20251023194237.197681-1-stephen@networkplumber.org><20260116064646.224254-1-stephen@networkplumber.org><20260116064646.224254-2-stephen@networkplumber.org><98CBD80474FA8B44BF855DF32C47DC35F65669@smartserver.smartshare.dk><20260119144821.70e2ff35@phoenix.local><98CBD80474FA8B44BF855DF32C47DC35F65674@smartserver.smartshare.dk>
 <20260120063413.72e0d725@phoenix.local>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>
Cc: <dev@dpdk.org>,
	"Honnappa Nagarahalli" <honnappa.nagarahalli@arm.com>
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
b3JnXQ0KPiBTZW50OiBUdWVzZGF5LCAyMCBKYW51YXJ5IDIwMjYgMTUuMzQNCj4gDQo+IE9uIFR1
ZSwgMjAgSmFuIDIwMjYgMDk6NDk6NDQgKzAxMDANCj4gTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0
c2hhcmVzeXN0ZW1zLmNvbT4gd3JvdGU6DQo+IA0KPiA+ID4gRnJvbTogU3RlcGhlbiBIZW1taW5n
ZXIgW21haWx0bzpzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZ10NCj4gPiA+IFNlbnQ6IE1vbmRh
eSwgMTkgSmFudWFyeSAyMDI2IDIzLjQ4DQo+ID4gPg0KPiA+ID4gT24gRnJpLCAxNiBKYW4gMjAy
NiAxMDozMjo1MiArMDEwMA0KPiA+ID4gTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0
ZW1zLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gPiA+IEZyb206IFN0ZXBoZW4gSGVtbWluZ2Vy
IFttYWlsdG86c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmddDQo+ID4gPiA+ID4gU2VudDogRnJp
ZGF5LCAxNiBKYW51YXJ5IDIwMjYgMDcuNDYNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFdoZW4gYnVp
bGRpbmcgd2l0aCBMVE8gKExpbmsgVGltZSBPcHRpbWl6YXRpb24pLCBHQ0MgcGVyZm9ybXMNCj4g
PiA+ID4gPiBhZ2dyZXNzaXZlIGNyb3NzLWNvbXBpbGF0aW9uLXVuaXQgaW5saW5pbmcuIFRoaXMg
Y2F1c2VzIHRoZQ0KPiA+ID4gY29tcGlsZXINCj4gPiA+ID4gPiB0byBhbmFseXplIGFsbCBjb2Rl
IHBhdGhzIGluIF9fcnRlX3JpbmdfZG9fZGVxdWV1ZV9lbGVtcygpLA0KPiA+ID4gaW5jbHVkaW5n
DQo+ID4gPiA+ID4gdGhlIDE2LWJ5dGUgZWxlbWVudCBwYXRoIChfX3J0ZV9yaW5nX2RlcXVldWVf
ZWxlbXNfMTI4KSwgZXZlbg0KPiB3aGVuDQo+ID4gPiA+ID4gdGhlIHJ1bnRpbWUgZWxlbWVudCBz
aXplIGlzIG9ubHkgNCBieXRlcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZSBzdGF0aWMgYW5h
bHl6ZXIgc2VlcyB0aGF0IHRoZSAxNi1ieXRlIHBhdGggd291bGQgY29weQ0KPiA+ID4gPiA+IDMy
IGVsZW1lbnRzICogMTYgYnl0ZXMgPSA1MTIgYnl0ZXMgaW50byBhIDEyOC1ieXRlIGJ1ZmZlcg0K
PiA+ID4gPiA+ICh1aW50MzJfdFszMl0pLA0KPiA+ID4gPiA+IHRyaWdnZXJpbmcgLVdzdHJpbmdv
cC1vdmVyZmxvdyB3YXJuaW5ncy4NCj4gPg0KPiA+IFRoZSBlbGVtZW50IHNpemUgaXMgbm90IGFu
IGlubGluZSBmdW5jdGlvbiBwYXJhbWV0ZXIsIGJ1dCBmZXRjaGVkDQo+IGZyb20gdGhlICJlc2l6
ZSIgZmllbGQgaW4gdGhlIHJ0ZV9zb3Jpbmcgc3RydWN0dXJlLCBzbyB0aGUgY29tcGlsZXINCj4g
Y2Fubm90IHNlZSB0aGF0IHRoZSBlbGVtZW50IHNpemUgaXMgNCBieXRlcy4gQW5kIHRodXMgaXQg
bmVlZHMgdG8NCj4gY29uc2lkZXIgYWxsIHBvc3NpYmxlIGVsZW1lbnQgc2l6ZXMuDQo+ID4NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IFRoZSBleGlzdGluZyAjcHJhZ21hIEdDQyBkaWFnbm9zdGljIHN1
cHByZXNzaW9uIGluDQo+ID4gPiBydGVfcmluZ19lbGVtX3B2dC5oDQo+ID4gPiA+ID4gZG9lc24n
dCBoZWxwIGJlY2F1c2Ugd2l0aCBMVE8gdGhlIHdhcm5pbmcgY29udGV4dCBzaGlmdHMgdG8gdGhl
DQo+ID4gPiB0ZXN0DQo+ID4gPiA+ID4gZmlsZSB3aGVyZSB0aGUgaW5saW5lZCBjb2RlIGlzIGlu
c3RhbnRpYXRlZC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEZpeCBieSBzaXppbmcgYWxsIGJ1ZmZl
cnMgcGFzc2VkIHRvIHNvcmluZyBhY3F1aXJlL2RlcXVldWUNCj4gPiA+IGZ1bmN0aW9ucw0KPiA+
ID4gPiA+IGZvciB0aGUgd29yc3QtY2FzZSBlbGVtZW50IHNpemUgKDE2IGJ5dGVzID0gNCAqDQo+
IHNpemVvZih1aW50MzJfdCkpLg0KPiA+ID4gPiA+IFRoaXMgc2F0aXNmaWVzIHRoZSBzdGF0aWMg
YW5hbHl6ZXIgd2l0aG91dCBjaGFuZ2luZyBydW50aW1lDQo+ID4gPiBiZWhhdmlvci4NCj4gPiA+
ID4NCj4gPiA+ID4gVXNpbmcgd2lsZGx5IG92ZXJzaXplZCBidWZmZXJzIGRvZXNuJ3Qgc2VlbSBs
aWtlIGEgcmVjb21tZW5kYWJsZQ0KPiA+ID4gc29sdXRpb24uDQo+ID4gPiA+IElmIHRoZSByaW5n
IGxpYnJhcnkgaXMgZXZlciB1cGRhdGVkIHRvIHN1cHBvcnQgY2FjaGUgc2l6ZQ0KPiBlbGVtZW50
cw0KPiA+ID4gKDY0IGJ5dGUpLCB0aGUgYnVmZmVycyB3b3VsZCBoYXZlIHRvIGJlIG92ZXJzaXpl
IGJ5IGZhY3RvciAxNi4NCj4gPiA+DQo+ID4gPiBUaGUgYW5hbHlzaXMgKGZyb20gQUkpIGlzIHRo
YXQgY29tcGlsZXIgaXMgZ2V0dGluZyBjb25mdXNlZC4NCj4gPg0KPiA+IFRoYXQgd291bGQgYmUg
bXkgYW5hbHlzaXMgdG9vLg0KPiA+DQo+ID4gPiBTaW5jZSB0aGVyZSBpcyBubyBnb29kDQo+ID4g
PiB3YXkgb3RoZXIgdGhhbiB0dXJuaW5nIG9mIExUTyBmb3IgdGhlIHRlc3QgdG8gdGVsbCB0aGUg
Y29tcGlsZXINCj4gPg0KPiA+IFRoZXJlIGlzIGFub3RoZXIgd2F5IHRvIHRlbGwgdGhlIGNvbXBp
bGVyOiBfX3J0ZV9hc3N1bWUoKQ0KPiANCj4gVHJpZWQgdGhhdCBidXQgaXQgZG9lc24ndCB3b3Jr
IGJlY2F1c2UgZG9lc24ndCBnZXQgcHJvcGFnYXRlZCBkZWVwDQo+IGVub3VnaCB0byBpbXBhY3Qg
aGVyZS4NCg0KRG9lcyB0aGlzIGZpeCBnZW5lcmFsbHkgaW1wbHkgdGhhdCB3aGVuIHVzaW5nIExU
TywgdXNpbmcgYW4gU09SSU5HIHdpdGggZWxlbWVudHMgc21hbGxlciB0aGFuIDE2IGJ5dGVzIHJl
cXVpcmVzIG92ZXJzaXplIGJ1ZmZlcnM/DQpUaGF0J3Mgbm90IGdvb2QuIDotKA0KDQpUaGUgU09S
SU5HIGlzIHN0aWxsIGV4cGVyaW1lbnRhbC4NCk1heWJlIHRoZSBlbGVtZW50IHNpemUgYW5kIG1l
dGFkYXRhIHNpemUgbmVlZCB0byBiZSBwYXNzZWQgYXMgcGFyYW1ldGVycyB0byB0aGUgU09SSU5H
IGZ1bmN0aW9ucywgbGlrZSB0aGUgUklORyBmdW5jdGlvbnMgdGFrZSBlbGVtZW50IHNpemUgYXMg
cGFyYW1ldGVyIChleGNlcHQgdGhlIGZ1bmN0aW9ucyB0aGF0IGFyZSBoYXJkY29kZWQgZm9yIHVz
aW5nIHBvaW50ZXJzIGFzIGVsZW1lbnQgc2l6ZSkuDQoNCg==
