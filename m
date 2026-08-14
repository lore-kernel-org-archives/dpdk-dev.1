Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CD3C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:12:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBF9D4013F;
	Fri, 14 Aug 2026 14:12:14 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 40ADD400D5
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:12:13 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0A585206DF;
 Fri, 14 Aug 2026 14:12:13 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [RFC] increase name sizes and reorder structures
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 14 Aug 2026 14:12:11 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659E4@smartserver.smartshare.dk>
In-Reply-To: <20260813171418.568620-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] increase name sizes and reorder structures
Thread-Index: Ad0rRzTS15DWuUJGRBuGN5G5Hnl2xwAnFFtQ
References: <20260813171418.568620-1-stephen@networkplumber.org>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
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

PiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3BsdW1iZXIu
b3JnXQ0KPiBTZW50OiBUaHVyc2RheSwgMTMgQXVndXN0IDIwMjYgMTkuMTMNCj4gDQo+IFRoaXMg
aXMgYSB0cmlhbCBiYWxsb29uIHRvIHNlZSB3aGF0IE1vcnRlbidzIHN1Z2dlc3Rpb24gd291bGQN
Cj4gbG9vayBsaWtlLg0KPiANCj4gSW5jcmVhc2UgbWVtem9uZSBuYW1lIHNpemUgdG8gNjQgYW5k
IHJlb3JkZXIgc3RydWN0dXJlDQo+IHRvIGtlZXAgaXQgY2FjaGUgZnJpZW5kbHkuICBNb3ZlIHRo
ZSB6b25lIG5hbWUgdG8gdGhlIGVuZCBvZg0KPiBzdHJ1Y3QgcnRlX21lbXpvbmUgYW5kIG9yZGVy
IHRoZSByZW1haW5pbmcgbWVtYmVycyBieSBzaXplLg0KPiBUaGUgc3RydWN0dXJlIGlzIHRoZW4g
bmF0dXJhbGx5IGFsaWduZWQNCj4gd2l0aCBubyBpbnRlcm5hbCBwYWRkaW5nIG9uIGJvdGggNjQt
Yml0IGFuZCAzMi1iaXQgdGFyZ2V0cywgc28gdGhlDQo+IF9fcnRlX3BhY2tlZF9iZWdpbi9lbmQg
bWFya2VycyBjYW4gYmUgcmVtb3ZlZC4NCj4gDQo+IFdpdGggbWVtem9uZSBzaXplIG9mIDY0IGJ1
dCBkb24ndCBuZWVkIGFsbCB0aGF0IGZvciBzdGFjayBuYW1lcy4NCj4gSW5jcmVhc2UgdGhlIHNp
emUgdG8gMzIgd2hpY2ggYWRkcyBzb21lIHNwYWNlIHdpdGhvdXQgaW1wYWN0aW5nDQo+IGNhY2hl
IGxheW91dC4NCj4gDQo+IFRoZSBtZW16b25lIGluY3JlYXNlIHRvIDY0IGFsbG93cyByaW5nIG5h
bWVzIHRvIGdyb3cgdG8gMzIgY2hhcmFjdGVycy4NCj4gRG9uJ3QgbmVlZCB0byBnbyBsYXJnZXIg
d2hpY2ggY291bGQgY2F1c2UgY2FjaGUgY2hhbmdlcyB3aGVuIHJpbmcgaXMNCj4gZW1iZWRkZWQg
aW4gc3RydWN0dXJlcy4NCj4gDQo+IEJ1Z3ppbGxhIElEOiAxOTg0DQo+IA0KPiBSZXBvcnRlZC1i
eTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogU3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiAt
LS0NCg0KTm90IGFzIG11Y2ggYXMgSSBob3BlZCBmb3IsIGJ1dCBub24taW50cnVzaXZlLg0KQSBz
bWFsbCBpbXByb3ZlbWVudCBpcyBzdGlsbCBhbiBpbXByb3ZlbWVudCENCg0KVHlwbyBpbiB0aGUg
cmVsZWFzZSBub3RlczoNCiJpbmNyZSAgICIgLT4gImluY3JlYXNlZCINCg0KUmV2aWV3ZWQtYnk6
IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQoNCg==
