Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A01ACD5BD1
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 09:11:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 152884026F;
	Thu, 28 May 2026 11:11:39 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A25B04021F
 for <dev@dpdk.org>; Thu, 28 May 2026 11:11:37 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 6B5EA20ADC;
 Thu, 28 May 2026 11:11:37 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [RFC v3 2/3] lib: add fastmem library
Date: Thu, 28 May 2026 11:11:34 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658AD@smartserver.smartshare.dk>
In-Reply-To: <20260527173042.93867-3-hofors@lysator.liu.se>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC v3 2/3] lib: add fastmem library
Thread-Index: Adzt/pkOsft8UXZISPmGN/6q9HIIBwAgl3ug
References: <20260526085743.64396-4-hofors@lysator.liu.se>
 <20260527173042.93867-1-hofors@lysator.liu.se>
 <20260527173042.93867-3-hofors@lysator.liu.se>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "Vipin Varghese" <vipin.varghese@amd.com>,
 =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <hofors@lysator.liu.se>,
 <dev@dpdk.org>
Cc: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>,
 "Yogaraj Baskaravel" <yogaraj.baskaravel@ericsson.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
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

PiArLyoqDQo+ICsgKiBQcmUtcmVzZXJ2ZSBiYWNraW5nIG1lbW9yeS4NCj4gKyAqDQo+ICsgKiBF
bnN1cmVzIHRoYXQgYXQgbGVhc3QgQHAgc2l6ZSBieXRlcyBvZiBtZW16b25lLWJhY2tlZCBtZW1v
cnkgYXJlDQo+ICsgKiBhdmFpbGFibGUgdG8gdGhlIGFsbG9jYXRvciBvbiBAcCBzb2NrZXRfaWQs
IHJlc2VydmluZyBhZGRpdGlvbmFsDQo+ICsgKiBtZW16b25lcyBmcm9tIEVBTCBhcyBuZWVkZWQg
dG8gcmVhY2ggdGhhdCB0b3RhbC4gU3Vic2VxdWVudA0KPiArICogYWxsb2NhdGlvbnMgc2VydmVk
IGZyb20gdGhlIHByZS1yZXNlcnZlZCBtZW1vcnkgZG8gbm90IGluY3VyDQo+ICsgKiBtZW16b25l
LXJlc2VydmF0aW9uIGNvc3QuDQo+ICsgKg0KPiArICogVGhlIHJlc2VydmF0aW9uIGlzIGN1bXVs
YXRpdmU6IHJlcGVhdGVkIGNhbGxzIHRvDQo+ICsgKiBydGVfZmFzdG1lbV9yZXNlcnZlKCkgd2l0
aCB0aGUgc2FtZSBAcCBzb2NrZXRfaWQgZ3JvdyB0aGUNCj4gKyAqIHJlc2VydmF0aW9uIG1vbm90
b25pY2FsbHkuIFJlc2VydmVkIG1lbW9yeSBpcyBuZXZlciByZXR1cm5lZCB0bw0KPiArICogdGhl
IHN5c3RlbSBkdXJpbmcgdGhlIGFsbG9jYXRvcidzIGxpZmV0aW1lLg0KPiArICoNCj4gKyAqIEEg
dHlwaWNhbCB1c2UgaXMgdG8gY2FsbCBydGVfZmFzdG1lbV9yZXNlcnZlKCkgb25jZSBhdA0KPiAr
ICogYXBwbGljYXRpb24gc3RhcnR1cCwgd2l0aCBhIHNpemUgY2hvc2VuIHRvIGNvdmVyIHRoZSBl
eHBlY3RlZA0KPiArICogc3RlYWR5LXN0YXRlIHdvcmtpbmcgc2V0LiBBbGxvY2F0aW9ucyBhbmQg
ZnJlZXMgZHVyaW5nDQo+ICsgKiBzdGVhZHktc3RhdGUgb3BlcmF0aW9uIHRoZW4gYXZvaWQgbWVt
em9uZSByZXNlcnZhdGlvbnMgZW50aXJlbHkuDQo+ICsgKg0KPiArICogQHBhcmFtIHNpemUNCj4g
KyAqICBUaGUgbWluaW11bSBhbW91bnQgb2YgYmFja2luZyBtZW1vcnksIGluIGJ5dGVzLCB0byBt
YWtlDQo+ICsgKiAgYXZhaWxhYmxlIG9uIEBwIHNvY2tldF9pZC4gVGhlIGFsbG9jYXRvciBtYXkg
cmVzZXJ2ZSBtb3JlIHRoYW4NCj4gKyAqICB0aGUgcmVxdWVzdGVkIGFtb3VudCBkdWUgdG8gaW50
ZXJuYWwgcm91bmRpbmcgKGUuZy4sIHRvIG1lbXpvbmUNCj4gKyAqICBvciBibG9jayBncmFudWxh
cml0eSkuDQo+ICsgKg0KPiArICogQHBhcmFtIHNvY2tldF9pZA0KPiArICogIFRoZSBOVU1BIHNv
Y2tldCBvbiB3aGljaCB0byByZXNlcnZlIG1lbW9yeSwgb3IgU09DS0VUX0lEX0FOWQ0KPiArICog
IHRvIGxlYXZlIHRoZSBjaG9pY2UgdG8gdGhlIGFsbG9jYXRvci4gV2l0aCBTT0NLRVRfSURfQU5Z
LCB0aGUNCj4gKyAqICBhbGxvY2F0b3Igc3RhcnRzIG9uIHRoZSBjYWxsaW5nIGxjb3JlJ3Mgc29j
a2V0IChvciB0aGUgZmlyc3QNCj4gKyAqICBjb25maWd1cmVkIHNvY2tldCBpZiB0aGUgY2FsbGVy
IGlzIG5vdCBib3VuZCB0byBvbmUpIGFuZCBmYWxscw0KPiArICogIGJhY2sgdG8gb3RoZXIgc29j
a2V0cyBpZiB0aGUgcHJlZmVycmVkIHNvY2tldCBjYW5ub3Qgc2F0aXNmeQ0KPiArICogIHRoZSBy
ZXNlcnZhdGlvbi4NCj4gKyAqDQo+ICsgKiBAcmV0dXJuDQo+ICsgKiAgLSAwOiBTdWNjZXNzLg0K
PiArICogIC0gLUVOT01FTTogSW5zdWZmaWNpZW50IGh1Z2UtcGFnZSBtZW1vcnkgdG8gc2F0aXNm
eSB0aGUgcmVxdWVzdC4NCj4gKyAqICAtIC1FSU5WQUw6IEludmFsaWQgQHAgc29ja2V0X2lkLg0K
PiArICovDQo+ICtfX3J0ZV9leHBlcmltZW50YWwNCj4gK2ludA0KPiArcnRlX2Zhc3RtZW1fcmVz
ZXJ2ZShzaXplX3Qgc2l6ZSwgaW50IHNvY2tldF9pZCk7DQoNCkBCcnVjZSwNCkkgdmFndWVseSBy
ZWNhbGwgdGhhdCB3ZSBkaXNjdXNzZWQgc29tZXRoaW5nIGFib3V0IGJ1c3NlcyBhbmQgc29ja2V0
cyBhIGxvbmcgdGltZSBhZ28sIGJ1dCBJIGNhbm5vdCByZW1lbWJlciB0aGUgZGV0YWlscy4NCklz
IHNvY2tldF9pZCB0aGUgcmlnaHQgdHlwZSAoYW5kIHBhcmFtZXRlciBuYW1lKSB0byBpZGVudGlm
eSBhIG1lbW9yeSBidXM/DQoNCkBWaXBpbiwNCllvdSBoYXZlIGJlZW4gd29ya2luZyBvbiB0b3Bv
bG9neSBhd2FyZW5lc3MuIFNhbWUgcXVlc3Rpb24gdG8geW91Og0KSXMgc29ja2V0X2lkIHRoZSBy
aWdodCB0eXBlIChhbmQgcGFyYW1ldGVyIG5hbWUpIHRvIGlkZW50aWZ5IGEgbWVtb3J5IGJ1cz8N
Cg0K
