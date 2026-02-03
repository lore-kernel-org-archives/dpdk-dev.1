Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED295E8305C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 07:31:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32B67402C0;
	Tue,  3 Feb 2026 08:31:07 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B06BC402A2
 for <dev@dpdk.org>; Tue,  3 Feb 2026 08:31:05 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7BD5D206EC;
 Tue,  3 Feb 2026 08:31:05 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [RFC 4/4] net/af_packet: add VPP-style prefetching to receive path
Date: Tue, 3 Feb 2026 08:31:03 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656E1@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260202104330.27156f31@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC 4/4] net/af_packet: add VPP-style prefetching to receive
 path
Thread-Index: AdyUc9dCjF4rlYRkTpKJA7Fb8o41/gAabvsg
References: <20260128173138.151837-1-stephen@networkplumber.org><20260128173138.151837-5-stephen@networkplumber.org><20260128170612.648cd657@phoenix.local><98CBD80474FA8B44BF855DF32C47DC35F656C7@smartserver.smartshare.dk>
 <20260202104330.27156f31@phoenix.local>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>,
	"John W. Linville" <linville@tuxdriver.com>
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
b3JnXQ0KPiBTZW50OiBNb25kYXksIDIgRmVicnVhcnkgMjAyNiAxOS40NA0KPiANCj4gT24gVGh1
LCAyOSBKYW4gMjAyNiAxMDowMDoxNSArMDEwMA0KPiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRz
aGFyZXN5c3RlbXMuY29tPiB3cm90ZToNCj4gDQo+ID4gPiBUaGlzIGFuZCBwcmV2aW91cyBwcm9w
b3NhbCB0byBwcmVmZXRjaCBoYXZlIG5vIGltcGFjdCBvbg0KPiBwZXJmb3JtYW5jZS4NCj4gPiA+
IFJvbGxlZCBhIHNpbXBsZSBwZXJmIHRlc3QgYW5kIGFsbCB0aHJlZSB2ZXJzaW9ucyBjb21lIG91
dCB0aGUgc2FtZS4NCj4gPg0KPiA+IFBsZWFzZSBiZSBhd2FyZSB0aGF0IG1hbnkgdGVzdCBjYXNl
cyBhcmUgaW5hZHZlcnRlbnRseSBkZXNpZ25lZCBpbiBhDQo+IHdheSB3aGVyZSBtYnVmcyB1bmlu
dGVuZGVkbHkgYXJlIGhvdCBpbiB0aGUgY2FjaGUsIHNvIHByZWZldGNoaW5nIGRvZXMNCj4gbm90
IHByb3ZpZGUgdGhlIGV4cGVjdGVkIHBlcmZvcm1hbmNlIGdhaW4uDQo+ID4gRS5nLiB3aGVuIHdv
cmtpbmcgb24gYSBuZXdseSBhbGxvY2F0ZWQgbWJ1ZiwgdGhlIG1idWYgc2hvdWxkIGJlIGNvbGQu
DQo+ID4gQnV0IGlmIGl0IGNhbWUgZnJvbSB0aGUgbWVtcG9vbCBjYWNoZSwgYW5kIHdhcyByZWNl
bnRseSB3b3JrZWQgb24gYW5kDQo+IHRoZW4gZnJlZWQgaW50byB0aGUgbWVtcG9vbCBjYWNoZSwg
dGhlbiBpdCB3aWxsIGJlIGhvdC4NCj4gPg0KPiA+ID4gVGhlIGJvdHRsZW5lY2sgaXMgbm90IGhl
cmUsIHByb2JhYmx5IGF0IHN5c3RlbSBjYWxsIGFuZCBjb3BpZXMgbm93Lg0KPiA+DQo+ID4gVGhl
IG1vc3QgaW1wb3J0YW50IGJvdHRsZW5lY2sgbWlnaHQgYmUgZWxzZXdoZXJlLg0KPiA+IEJ1dCB0
aGlzIG9wdGltaXphdGlvbiBtaWdodCBub3QgYmUgYXMgaXJyZWxldmFudCBhcyB0aGUgdGVzdCBy
ZXN1bHRzDQo+IGluZGljYXRlLg0KPiA+DQo+ID4gQW55d2F5LCBJIGFncmVlIHRoYXQgZHJvcHBp
bmcgdGhlIHBhdGNoIChmb3Igbm93KSBtYWtlcyBzZW5zZS4NCj4gDQo+IEkgZG91YnQgcHJlLWZl
dGNoIHdpbGwgbWF0dGVyIG11Y2ggaW4gYSBkcml2ZXIgbGlrZSB0aGlzIGJlY2F1c2U6DQo+ICAt
IG9uIHR4IHRoZSBkYXRhIGlzIHN0aWxsIGluIGNhY2hlIHNpbmNlIGp1c3Qgc2V0dXAgYnkgY2Fs
bGVyDQpJZiB0aGUgcGFja2V0IGhhcyBiZWVuIHNpdHRpbmcgaW4gYSBxdWV1ZSwgZS5nLiBmb3Ig
UW9TIGJ1ZmZlcmluZywgaXQgbWF5IGhhdmUgYmVlbiBldmljdGVkIGZyb20gdGhlIGNhY2hlLg0K
PiAgLSBvbiByeCB0aGUgZGF0YSBpcyBzdGlsbCBpbiBjYWNoZSBzaW5jZSBrZXJuZWwganVzdCBj
b3BpZWQNCj4gICAgaXQgaW50byB0aGUgYnVmZmVyLg0KSWYgdGhlcmUncyBhbnkgZGVsYXkgYmV0
d2VlbiB0aGUgc2lnbmFsaW5nIGFuZCB0aGUgaGFuZGxpbmcsIGl0IGNvdWxkIGJlIGV2aWN0ZWQg
ZnJvbSB0aGUgY2FjaGUgaW4gdGhlIG1lYW50aW1lLg0KKFRoZSBkZWxheSBjb3VsZCBjb21lIGZy
b20gZS5nLiB0aGUgaGFuZGxpbmcgQ1BVIGNvcmUgYmVpbmcgYnVzeSB3aXRoIHNvbWV0aGluZyBl
bHNlIGJlZm9yZSBoYW5kbGluZyB0aGUgUlggcmVhZHkgc2lnbmFsLikNCkFuZCBpdCBjb3VsZCBi
ZSBpbiB0aGUgY2FjaGUgb2YgYSBkaWZmZXJlbnQgQ1BVIGNvcmUuDQoNCkFueXdheSwgSSBzdGls
bCBhZ3JlZSB3aXRoIGRyb3BwaW5nIHRoZSBwYXRjaCBmb3Igbm93LCBzaW5jZSB0ZXN0aW5nIHNo
b3dzIG5vIGRpZmZlcmVuY2UuDQoNCg==
