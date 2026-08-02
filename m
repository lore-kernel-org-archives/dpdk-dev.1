Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26859C55171
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 06:33:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43F7340269;
	Sun,  2 Aug 2026 08:33:43 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 20F6A400D6
 for <dev@dpdk.org>; Sun,  2 Aug 2026 08:33:40 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id CAE7E208F4;
 Sun,  2 Aug 2026 08:33:39 +0200 (CEST)
Subject: RE: [RFC 12/32] stack: always use C11 memory model implementation
Date: Sun, 2 Aug 2026 08:33:39 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659B0@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
In-Reply-To: <20260801100150.6e683948@phoenix.local>
X-MS-Has-Attach: 
Content-class: urn:content-classes:message
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC 12/32] stack: always use C11 memory model implementation
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Index: Ad0h13WZzS9ukO0nTSuRK8Mfv5vaoQAcSt3A
References: <20260729175715.165120-1-stephen@networkplumber.org><20260729175715.165120-13-stephen@networkplumber.org><98CBD80474FA8B44BF855DF32C47DC35F659AA@smartserver.smartshare.dk>
 <20260801100150.6e683948@phoenix.local>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>, <bruce.richardson@intel.com>,
 <konstantin.v.ananyev@yandex.ru>,
 "Vipin Varghese" <vipin.varghese@amd.com>, <jerinj@marvell.com>,
 "Maciej Czekaj" <mczekaj@marvell.com>
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
b3JnXQ0KPiBTZW50OiBTYXR1cmRheSwgMSBBdWd1c3QgMjAyNiAxOS4wMg0KDQo+IA0KPiBPbiBG
cmksIDMxIEp1bCAyMDI2IDE2OjUzOjQ1ICswMjAwDQo+IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFy
dHNoYXJlc3lzdGVtcy5jb20+IHdyb3RlOg0KPiANCj4gPiArVE86IHg4NiBtYWludGFpbmVycywg
VGh1bmRlclggbWFpbnRhaW5lcnMNCj4gPg0KPiA+ID4gRnJvbTogU3RlcGhlbiBIZW1taW5nZXIg
W21haWx0bzpzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZ10NCj4gPiA+IFNlbnQ6IFdlZG5lc2Rh
eSwgMjkgSnVseSAyMDI2IDE5LjU0DQo+ID4gPg0KPiA+ID4gVGhlIGdlbmVyaWMgYW5kIEMxMSBs
b2NrLWZyZWUgc3RhY2sgaW1wbGVtZW50YXRpb25zIGRpZmZlciBvbmx5IGluDQo+ID4gPiBtZW1v
cnkgb3JkZXJpbmcuIFRoZSBnZW5lcmljIHZlcnNpb24gdXNlcyBhIGZ1bGwgYmFycmllciB3aGVy
ZSBpdHMNCj4gPiA+IG93biBjb21tZW50cyBzdGF0ZSBhbiBhY3F1aXJlIGZlbmNlIGlzIHN1ZmZp
Y2llbnQsIGFuZCBzZXFfY3N0IGZvcg0KPiA+ID4gYWxsIGxlbmd0aCBjb3VudGVyIG9wZXJhdGlv
bnMuDQo+ID4gPg0KPiA+ID4gT25seSB4ODYgYW5kIFRodW5kZXJYIHN0aWxsIHVzZWQgdGhlIGdl
bmVyaWMgdmVyc2lvbi4gT24geDg2IHRoZQ0KPiA+ID4gc3dpdGNoIHJlbW92ZXMgYSBsb2NrZWQg
YWRkIHBlciBDQVMgYXR0ZW1wdCBpbiBwdXNoIGFuZCBwb3A7IFRTTw0KPiA+ID4gcHJvdmlkZXMg
dGhlIGFjcXVpcmUgc2VtYW50aWNzLiBPbiBUaHVuZGVyWCB0aGUgcG9wIGZlbmNlIHdlYWtlbnMN
Cj4gPiA+IGZyb20gZG1iIGlzaCB0byBkbWIgaXNobGQgYW5kIHRoZSBwdXNoIGZlbmNlIGdvZXMg
YXdheS4gVW5saWtlIHRoZQ0KPiA+ID4gcmluZywgbm8gcGxhdGZvcm0gc2VsZWN0ZWQgdGhlIGdl
bmVyaWMgc3RhY2sgZm9yIG1lYXN1cmVkDQo+ID4gPiBwZXJmb3JtYW5jZSByZWFzb25zLg0KPiA+
ID4NCj4gPiA+IFJlbW92ZSBpdCBhbmQgdXNlIHRoZSBDMTEgaW1wbGVtZW50YXRpb24gZXZlcnl3
aGVyZS4NCj4gPg0KPiA+IFRoZSBsYWNrIG9mIG1lYXN1cmVkIHBlcmZvcm1hbmNlIGRpZmZlcmVu
Y2UgZG9jdW1lbnRhdGlvbiBpcyBub3QgYQ0KPiB2YWxpZCByZWFzb24gdG8gcmVtb3ZlIHRoZSBn
ZW5lcmljIHZlcnNpb24hDQo+ID4NCj4gPiBJdCB3b3VsZCBiZSByZWFzb25hYmxlIHRvIGFzc3Vt
ZSB0aGF0IHg4NiAoYW5kIFRodW5kZXJYKSB1c2UgdGhlDQo+IGdlbmVyaWMgdmVyc2lvbiBmb3Ig
bm9uLWluc2lnbmlmaWNhbnQgcGVyZm9ybWFuY2UgcmVhc29ucy4NCj4gPg0KPiA+IElmIHRoZXJl
IGlzIG5vIHBlcmZvcm1hbmNlIGRpZmZlcmVuY2UsIEkgYWdyZWUgd2l0aCB0aGlzIHBhdGNoLg0K
PiBPdGhlcndpc2Ugbm90Lg0KPiA+IFRoaXMgY291bGQgYmUgdmVyaWZpZWQgYnkgcHJvdmlkaW5n
IHRoZSBtaXNzaW5nIG1lYXN1cmVtZW50cy4NCj4gPg0KPiANCj4gU3VycHJpc2luZ2x5LCB0aGUg
cGVyZm9ybWFuY2Ugb2YgdGhlIEMxMSB2ZXJzaW9uIGlzIGJldHRlciB0aGFuIHRoZSBvbGQNCj4g
Z2VuZXJpYw0KPiB2ZXJzaW9uIHRoYXQgaGFkIHNtcF9tYi4gIFRoYXQgaXMgYmVjYXVzZSBDMTEg
Y29kZSBnZW5lcmF0ZXMgbm8gbG9ja2VkDQo+IHByZWZpeGVzLg0KPiBHZXRzIHNwZWVkdXAgb2Yg
dXB0byA2MCUuDQo+IA0KPiBCZXR3ZWVuIG1haW4gKHdpdGggcnRlX3NtcF9tYikgYW5kIHRoZSB1
bmlmaWVkIEMxMSB2ZXJzaW9uIG9uIHRoZSAzMi0NCj4gY29yZSB4ODYgbWFjaGluZToNCj4gDQo+
IFRlc3QJbWFpbiAobj05KQl1bmlmaWVkIEMxMSAobj05KQlkZWx0YQ0KPiBzaW5nbGUgcHVzaC9w
b3AJNDYuNjIgwrEwLjMwCTMzLjQxIMKxMC4xMAktMjglDQo+IGVtcHR5IHBvcAkxLjQ3IMKxMC4w
MQkwLjk4IMKxMC4wMQktMzMlDQo+IDEgbGNvcmUsIGJ1bGsgOAk5LjA2IMKxMC4wNQk4LjIwIMKx
MC4wOAktMTAlDQo+IDEgbGNvcmUsIGJ1bGsgMzIJNi4wOSDCsTAuMDIJNi4xNSDCsTAuMDMJKzEl
DQo+IDIgSFQsIGJ1bGsgOAk0Mi4wNSDCsTAuMzEJMzkuMjQgwrEwLjUyCS03JQ0KPiAyIEhULCBi
dWxrIDMyCTExLjkyIMKxMC4xMwkxMS44OSDCsTAuMTAJMA0KPiAyIGNvcmVzLCBidWxrIDgJNzgu
OTAgwrEwLjYwCTcyLjk2IMKxMS4xMQktNyUNCj4gMiBjb3JlcywgYnVsayAzMgkyMC43NCDCsTEu
NTYJNy43MCDCsTAuMTMJLTYzJQ0KPiAzMiBjb3JlcywgYnVsayA4CTYxMjYgwrE3Mgk2MTIxIMKx
ODkJMA0KPiAzMiBjb3JlcywgYnVsayAzMgkxOTUzLjkgwrEyLjkJMTk4NC42IMKxMTMuMwkrMS42
JQ0KDQpUaGFuayB5b3UgZm9yIHRlc3RpbmcsIFN0ZXBoZW4uDQoNCkl0IGNsZWFybHkgc2hvd3Mg
dGhpcyBwYXRjaCBkZXNlcnZlcyBhIGJpZyBmYXQNCkFja2VkLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8
bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KDQo=
