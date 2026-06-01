Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4ACCD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 12:22:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B95E94025F;
	Mon,  1 Jun 2026 14:22:56 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 013DC4025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 14:22:54 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BBD7E208EE;
 Mon,  1 Jun 2026 14:22:54 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH 3/7] app/test/mempool_perf: size mempool by tested cores
Date: Mon, 1 Jun 2026 14:22:53 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658C9@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <a239680c-0042-4635-b038-6c0a545ba0e5@oktetlabs.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 3/7] app/test/mempool_perf: size mempool by tested cores
Thread-Index: AdzxnmbxyOlFgKo8SJ29IP6xkysp2gAItH+w
References: <20260529171417.526892-1-stephen@networkplumber.org>
 <20260529171417.526892-4-stephen@networkplumber.org>
 <a239680c-0042-4635-b038-6c0a545ba0e5@oktetlabs.ru>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>
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

PiBGcm9tOiBBbmRyZXcgUnliY2hlbmtvIFttYWlsdG86YW5kcmV3LnJ5YmNoZW5rb0Bva3RldGxh
YnMucnVdDQo+IFNlbnQ6IE1vbmRheSwgMSBKdW5lIDIwMjYgMTAuMTMNCj4gDQo+IE9uIDUvMjkv
MjYgODoxMCBQTSwgU3RlcGhlbiBIZW1taW5nZXIgd3JvdGU6DQo+ID4gVGhlIG1lbXBvb2wgc2l6
ZSBpcyBjb21wdXRlZCBmcm9tIHJ0ZV9sY29yZV9jb3VudCgpIHNvIG9uIHN5c3RlbXMNCj4gPiB3
aXRoIG1hbnkgbGNvcmVzIHRoZSB0ZXN0IHJlcXVpcmVzIG11bHRpcGxlIEdCIG9mIGh1Z2VwYWdl
cyBldmVuDQo+ID4gZm9yIHRoZSBzaW5nbGUtY29yZSBhbmQgZHVhbC1jb3JlIHZhcmlhbnRzLiAg
T24gYSAyMCBsY29yZSBzeXN0ZW0NCj4gPiB3aXRoIDIgR0Igb2YgaHVnZXBhZ2VzIHRoZSB0ZXN0
IGZhaWxzIHdpdGg6DQo+ID4NCj4gPiAgICBjYW5ub3QgcG9wdWxhdGUgcmluZ19tcF9tYyBtZW1w
b29sDQo+ID4gICAgVGVzdCBGYWlsZWQNCj4gPg0KPiA+IFNpemUgdGhlIGZvdXIgbWVtcG9vbHMg
YnkgdGhlIG51bWJlciBvZiBjb3JlcyBhY3R1YWxseSBleGVyY2lzZWQuDQo+ID4NCj4gPiBSZXR1
cm4gVEVTVF9TS0lQUEVEIHJhdGhlciB0aGFuIC0xIHdoZW4gYWxsb2NhdGlvbiBvciBwb3B1bGF0
ZSBvZg0KPiA+IGEgbWVtcG9vbCBmYWlscywgc28gaW5zdWZmaWNpZW50IG1lbW9yeSBpcyByZXBv
cnRlZCBhcyBhIHNraXAgYW5kDQo+ID4gbm90IGFzIGEgdGVzdCBmYWlsdXJlLiAgUHJvcGFnYXRl
IHRoZSBza2lwIHRocm91Z2ggdGhlIGNvbWJpbmVkDQo+ID4gbWVtcG9vbF9wZXJmX2F1dG90ZXN0
IHdyYXBwZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVwaGVuIEhlbW1pbmdlciA8c3Rl
cGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+IA0KPiBBY2tlZC1ieTogQW5kcmV3IFJ5YmNoZW5r
byA8YW5kcmV3LnJ5YmNoZW5rb0Bva3RldGxhYnMucnU+DQoNCkxHVE0gdG9vLg0KQWNrZWQtYnk6
IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQoNCg==
