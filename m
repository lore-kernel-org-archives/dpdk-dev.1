Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AC6C87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 12:47:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0172A4042E;
	Mon, 11 Aug 2025 14:47:23 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 44C714013F
 for <dev@dpdk.org>; Mon, 11 Aug 2025 14:47:21 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E1FD620752;
 Mon, 11 Aug 2025 14:47:20 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] net/i40e: Fast release optimizations
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 11 Aug 2025 14:47:17 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE25@smartserver.smartshare.dk>
In-Reply-To: <20250624061238.89259-1-mb@smartsharesystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net/i40e: Fast release optimizations
Thread-Index: AdvkzwHQ1YID0dAUShyROJldEe/bDQl7obvA
References: <20250624061238.89259-1-mb@smartsharesystems.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>,
	"Konstantin Ananyev" <konstantin.ananyev@huawei.com>
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

PiBGcm9tOiBNb3J0ZW4gQnLDuHJ1cCBbbWFpbHRvOm1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbV0N
Cj4gU2VudDogVHVlc2RheSwgMjQgSnVuZSAyMDI1IDA4LjEzDQo+IA0KPiBXaGVuIGZhc3QgcmVs
ZWFzaW5nIG1idWZzLCB0aGUgbWJ1ZnMgYXJlIG5vdCBhY2Nlc3NlZCwgc28gZG8gbm90IHByZWZl
dGNoDQo+IHRoZW0uDQo+IFRoaXMgc2F2ZXMgYSBtYnVmIGxvYWQgb3BlcmF0aW9uIGZvciBlYWNo
IGZhc3QgcmVsZWFzZWQgVFggbWJ1Zi4NCj4gDQo+IFdoZW4gZmFzdCByZWxlYXNlIG9mIG1idWZz
IGlzIGVuYWJsZWQgZm9yIGEgVFggcXVldWUsIGNhY2hlIHRoZSBtYnVmDQo+IG1lbXBvb2wgcG9p
bnRlciBpbiB0aGUgVFggcXVldWUgc3RydWN0dXJlLg0KPiBUaGlzIHNhdmVzIG9uZSBtYnVmIGxv
YWQgb3BlcmF0aW9uIGZvciBlYWNoIGJ1cnN0IG9mIGZhc3QgcmVsZWFzZWQgVFgNCj4gbWJ1ZnMu
DQo+IA0KPiBUaGUgdHhlcC0+bWJ1ZiBwb2ludGVyIGlzIG5vdCB1c2VkIGFmdGVyIHRoZSBtYnVm
IGhhcyBiZWVuIGZyZWVkLCBzbyBkbw0KPiBub3QgcmVzZXQgdGhlIHBvaW50ZXIuDQo+IFRoaXMg
c2F2ZXMgYSB0eGVwIHN0b3JlIG9wZXJhdGlvbiBmb3IgZWFjaCBUWCBtYnVmIGZyZWVkLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNv
bT4NCj4gLS0tDQoNCkFmdGVyIGZ1cnRoZXIgY29uc2lkZXJhdGlvbiwgSSB0aGluayB0aGlzIHBh
dGNoIHNob3VsZCBiZSBzcGxpdCBpbiB0d286DQoxLiBSZW1vdmUgc3VwZXJmbHVvdXMgY29kZTog
cHJlZmV0Y2hpbmcgbWJ1ZnMgYW5kIHJlc2V0dGluZyB0eGVwLT5tYnVmIHBvaW50ZXJzLg0KMi4g
Q2FjaGUgdGhlIG1idWYgbWVtcG9vbCBwb2ludGVyIGZvciBGQVNUX0ZSRUUuDQoNCi1Nb3J0ZW4N
Cg0K
