Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3868DCC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:14:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DD3840430;
	Thu, 15 Oct 2026 13:14:02 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8CAB140041
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:14:00 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 8FD5E2080A;
 Thu, 15 Oct 2026 13:13:59 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v4 0/1] mbuf: add runtime metadata dynamic-field storage
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 15 Oct 2026 13:13:55 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65AB4@smartserver.smartshare.dk>
In-Reply-To: <20261009121603.1f97aca8@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4 0/1] mbuf: add runtime metadata dynamic-field storage
Thread-Index: Ad1YIrkqed0cbPBeSfm+jN9gE9YzSgEbWGFw
References: <179061941387.2.17741463412422386825.v3-0000-cover-letter.patch@cisco.com><179130207755.4.10786861462241375385.v4-0000-cover-letter.patch@cisco.com><20261006095123.3166b4dd@phoenix.local><PH0PR11MB7616A68AC3EA1349948CAC75A9932@PH0PR11MB7616.namprd11.prod.outlook.com><20261009091405.46b9f3bf@phoenix.local><PH0PR11MB76165F045BA8ECE8877446B9A9922@PH0PR11MB7616.namprd11.prod.outlook.com>
 <20261009121603.1f97aca8@phoenix.local>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Randy Tice (rtice)" <rtice@cisco.com>
Cc: <dev@dpdk.org>, "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 "Harman Kalra" <hkalra@marvell.com>
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
b3JnXQ0KPiBTZW50OiBGcmlkYXksIDkgT2N0b2JlciAyMDI2IDIxLjE2DQo+IA0KPiBPbiBGcmks
IDkgT2N0IDIwMjYgMTg6MTI6MjAgKzAwMDANCj4gIlJhbmR5IFRpY2UgKHJ0aWNlKSIgPHJ0aWNl
QGNpc2NvLmNvbT4gd3JvdGU6DQo+IA0KPiA+IFN0ZXBoZW4sDQo+ID4gSeKAmW0gdGhpbmtpbmcs
IHBlcmhhcHMgdGhlIGJlc3QgcGF0aCBmb3J3YXJkIGZvciBub3csIGlzIHRvIGNvbnRpbnVlDQo+
IHVzaW5nIGEgcHJpdmF0ZSBtYnVmIGxheW91dCBhbmQgY2FycnkgdGhlIGNvbGxhdGVyYWwgaW50
ZXJuYWxseSDigJQgYXQNCj4gbGVhc3QgZm9yIG5vdy4gVGhlIGNoYW5nZXMgYXJlIGdldHRpbmcg
d2VsbCBiZXlvbmQgdGhlIGluaXRpYWwgZGVzaXJlZA0KPiBpbXBhY3RzIGFuZCBoYXMgcG90ZW50
aWFsIG1ha2UgdGhpbmdzIGJlY29tZSB1bnN0YWJsZS4NCj4gPg0KPiA+IEkgd291bGQgbG92ZSB0
byBzZWUgc29tZSBzb3J0IG9mIHNvbHV0aW9uIGFsb25nIHRoZXNlIGxpbmVzIGluIHRoZQ0KPiBm
dXR1cmUgc28gd2UgY2FuIGRpc2NvbnRpbnVlIHRoZSB1c2Ugb2YgYSBwcml2YXRlIHBhdGNoLiBU
byBiZSBjbGVhciwNCj4gdGhlIHNvbHV0aW9uIGlzIG5vdCBidWlsdCBhcm91bmQgY254aywgY254
ayBpcyBqdXN0IGltcGFjdGVkIOKAlCB3ZSBoYXZlDQo+IHNldmVyYWwgb3RoZXIgcGxhdGZvcm0g
YnVpbGRzIHRoYXQgZG8gbm90IHVzZSBjbnhrIGJ1dCB3ZSBzdGlsbCBjYXJyeQ0KPiB0aGUgbWV0
YWRhdGEgaW4gdGhlIG1idWYgaXRzZWxmIGZvciBwZXJmb3JtYW5jZSByZWFzb25zLg0KPiA+DQo+
ID4gV1JUIHRoZSBza2lwIGZ1bmN0aW9ucywgd2UgZml0IHVuZGVyIHRoZSAzODQgbWF4IGZvciB3
cWUgYnV0IHRoZXJl4oCZcw0KPiBubyByb29tIGZvciBhZGRpdGlvbmFsIGdyb3d0aCBiZXlvbmQg
dGhhdCB3aXRoIGhvdyBpdOKAmXMgbGFpZCBvdXQuIFRoZQ0KPiBvdGhlciAyIGFyZSBub3QgYXMg
c2Vuc2l0aXZlIHRvIHRoZSBzaXplIGJ1dCBzdGlsbCBoYXZlIHZhbGlkIGxpbWl0cw0KPiB3aGlj
aCBhcmUgd2VsbCBiZXlvbmQgb3VyIHVzZSBjYXNlLiBUb2RheSB3ZSBjYXJyeSAyNTYgYnl0ZXMg
d2hpY2ggY2Fwcw0KPiB1cyBvbiB3cWUuDQo+ID4NCj4gPiBUaGF0IHNhaWQsIHdlIHBsYW4gdG8g
ZGlzY3VzcyBpbnRlcm5hbGx5IG5leHQgd2VlayBvbiBob3cgdG8gbW92ZQ0KPiBmb3J3YXJkIGFz
IHdlIHByZXAgZm9yIG91ciB2MjUuMTEgdXBncmFkZSB3b3JrLiBJIHdhbnQgdG8gdGhhbmsgeW91
IGFuZA0KPiBNb3J0ZW4sIGhvd2V2ZXIsIGZvciB5b3VyIHRpbWUgYW5kIHN1cHBvcnQgb24gdGhp
cyB3b3JrLg0KPiA+IFJlZ2FyZHMsDQo+ID4gLXJ0DQo+IA0KPiBJIGRvIHRoaW5rIENOWEsgbmVl
ZHMgZml4aW5nLg0KDQpJIHdvdWxkIGxpa2UgdG8gc2VlIHRoaXMgZmVhdHVyZSBnbyBpbnRvIHRo
ZSBtYnVmIGxpYnJhcnkuDQpBIGxvdCBvZiBlZmZvcnQgaGFzIGJlZW4gcHV0IGludG8gbWFraW5n
IGl0IGdlbmVyYWxseSB1c2VmdWwuDQpVbmZvcnR1bmF0ZWx5LCBpdCBpcyBwcm9iYWJseSB0b28g
bGF0ZSBmb3IgMjYuMTEsIGJ1dCBtYXliZSAyNy4xMS4NCg0KSU1PLCBpZiBvbmUgTklDIGRyaXZl
ciBoYXMgd2VpcmQgYmVoYXZpb3Igb3IgYXNzdW1wdGlvbnMsIGl0IHNob3VsZCBub3QgYmUgYSBi
YXJyaWVyIHRvIGV4dGVuZGluZyB0aGUgbWJ1ZiBsaWJyYXJ5IHdpdGggdGhpcyBuZXcgZmVhdHVy
ZS4NCkVzcGVjaWFsbHkgaWYgdGhlIGRyaXZlciBjYW4gYmUgZml4ZWQuDQpNeSBvcGluaW9uIHdv
dWxkIGJlIGRpZmZlcmVudCBpZiBtYW55IGRyaXZlcnMgd2VyZSBpbmNvbXBhdGlibGUuDQoNCkZ1
cnRoZXJtb3JlLCBmaXhpbmcgYSBkcml2ZXIgd2l0aCB3ZWlyZCBiZWhhdmlvciAob3Igd2VpcmQg
YXNzdW1wdGlvbnMpIHNob3VsZCBub3QgYmUgdGhlIGpvYiBvZiBzb21lb25lIGNvbnRyaWJ1dGlu
ZyB0byBhIGNvcmUgbGlicmFyeSENCkkgdGhpbmsgaXQgaXMgZ3JlYXQgdGhhdCBSYW5keSBpZGVu
dGlmaWVkIHRoZSBDTlhLIGRyaXZlciBpc3N1ZS4NCkFuZCBJIGNvbnNpZGVyIGl0IGEgcGVyZmVj
dGx5IHJlYXNvbmFibGUgd29ya2Fyb3VuZCB0byBzYXkgdGhhdCB0aGUgZHJpdmVyIGlzIG5vdCBj
b21wYXRpYmxlIHdpdGggdGhpcyBmZWF0dXJlLCBzbyBlaXRoZXIgZG9uJ3QgdXNlIHRoZSBmZWF0
dXJlLCBvciBkb24ndCB1c2UgdGhlIGRyaXZlci4NCg0KSWYgdGhlIGRyaXZlciBoYXNuJ3QgYmVl
biBmaXhlZCBieSB0aGUgdGltZSB0aGlzIGZlYXR1cmUgZ2V0cyBpbnRvIGFuIExUUyByZWxlYXNl
LCB0aGUgZHJpdmVyIGNhbiBiZSBmaXhlZCBpbiBhbnkgbGF0ZXIgKG5vbi1MVFMpIHJlbGVhc2Us
IGFuZCB0aGUgaW5jb21wYXRpYmlsaXR5IHdvcmthcm91bmQgY2FuIGJlIHJlbW92ZWQgYXQgdGhh
dCBwb2ludC4NCg0KLU1vcnRlbg0KDQo=
