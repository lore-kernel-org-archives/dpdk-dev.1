Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA12ACD6E55
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 14:27:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 084254025F;
	Mon,  1 Jun 2026 16:27:12 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1BA694025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 16:27:11 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1A0B9208EE;
 Mon,  1 Jun 2026 16:27:10 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v6] mempool: improve cache behaviour and performance
Date: Mon, 1 Jun 2026 16:27:07 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658CE@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <6w4sxDwSRYyFMvKExI5ztQ@monjalon.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v6] mempool: improve cache behaviour and performance
Thread-Index: Adzx0a8P7SLkCvcNSHCgh2Wgrh+aNgAANdLg
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <0b8SMRhASVKQeU9e_kqJHQ@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F658CC@smartserver.smartshare.dk>
 <6w4sxDwSRYyFMvKExI5ztQ@monjalon.net>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
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

PiA+ID4gPiA+IERlcGVuZHMtb246IHBhdGNoLTE2MzE4MSAoIm5ldC9pbnRlbDogZG8gbm90IGJ5
cGFzcyBtYnVmIGxpYg0KPiBmb3INCj4gPiA+IG1idWYNCj4gPiA+ID4gPiBmYXN0LWZyZWUiKQ0K
PiA+ID4gPg0KPiA+ID4gPiBUaGlzIGRlcGVuZGVuY3kgc2VlbXMgdG8gY2F1c2UgQ0kgYXBwbHkg
ZmFpbHVyZXMuDQo+ID4gPiA+IFRoZSBkZXBlbmRlbmN5IGlzIGJhc2VkIG9uIGFuIG9sZGVyIHNu
YXBzaG90IG9mIG1haW4sDQo+ID4gPiA+IGFuZCB0aGlzIHBhdGNoIGlzIGJhc2VkIG9uIGEgbmV3
IHNuYXBzaG90IG9mIG1haW4uDQo+ID4gPg0KPiA+ID4gVGhlIGRlcGVuZGVuY3kgc2hvdWxkIGJl
IHJlc29sdmVkIG5vdy4NCj4gPiA+IFBsZWFzZSBjb3VsZCB5b3Ugc2VuZCBhIHY3Pw0KPiA+ID4N
Cj4gPg0KPiA+IEknbSBub3QgMTAwICUgc3VyZSwgYnV0IEkgdGhpbmsgdGhlIHByb2JsZW0gaXMg
Q0kgb25seS4uLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBpcyBiYXNlZCBvbiBtYWluLCBzbyBpdCBz
aG91bGQgYXBwbHkgYXMtaXMuDQo+ID4NCj4gPiBCcnVjZSBoYXMgYWxyZWFkeSBhcHBsaWVkIHRo
ZSBvdGhlciBwYXRjaCAodGhhdCB0aGlzIG9uZSBkZXBlbmRzIG9uKQ0KPiB0byB0aGUgaW50ZWwt
bmV4dC1uZXQgdHJlZS4NCj4gPiBUaGUgb3RoZXIgcGF0Y2ggaXMgYmFzZWQgb24gYW4gb2xkZXIg
c25hcHNob3Qgb2YgbWFpbiwgc28gd2hlbiB1c2luZw0KPiAiRGVwZW5kcy1vbiIsIEkgZ3Vlc3Mg
dGhlIENJIGJhc2VzIGl0cyBzZXJpZXMgb24gdGhlIG90aGVyIHBhdGNoOyBhbmQNCj4gdGhlbiB0
aGUgQ0kgZmFpbHMgdG8gYXBwbHkgdGhpcyBwYXRjaCAoYmVjYXVzZSBpdCdzIGJhc2VkIG9uIGEg
bmV3ZXINCj4gc25hcHNob3Qgb2YgbWFpbikuDQo+IA0KPiBUaGUgcGF0Y2ggaXMgaW4gbWFpbiBz
aW5jZSBsYXN0IHdlZWsuDQo+IA0KPiBTbyB5b3UgY291bGQgc2VuZCBhIG5ldyB2ZXJzaW9uIHdp
dGggdGhlIGFjayBhbmQgaXQgd2lsbCBydW4gaW4gQ0kuDQo+IA0KDQpPSy4gV2lsbCBkby4NCg0K
