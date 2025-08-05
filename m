Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC0EC87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 05:48:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48F3840A4B;
	Tue,  5 Aug 2025 07:48:45 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 81F3E402E3
 for <dev@dpdk.org>; Tue,  5 Aug 2025 07:48:43 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 601ED20446;
 Tue,  5 Aug 2025 07:48:42 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v3 1/3] testpmd: Do not enable mbuf fast release TX
 offload by default
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 5 Aug 2025 07:48:41 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FDFF@smartserver.smartshare.dk>
In-Reply-To: <4102ec21-46b6-4512-bc2f-3cd61f63f8c2@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 1/3] testpmd: Do not enable mbuf fast release TX
 offload by default
Thread-Index: AdwFpB+kx3JFgyZJSzSkmL6d9tImWAAJsLeg
References: <20250731090731.671589-1-mb@smartsharesystems.com>
 <20250803194218.683318-1-mb@smartsharesystems.com>
 <4102ec21-46b6-4512-bc2f-3cd61f63f8c2@huawei.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "fengchengwen" <fengchengwen@huawei.com>, <dev@dpdk.org>,
 "Aman Singh" <aman.deep.singh@intel.com>,
 "Thomas Monjalon" <thomas@monjalon.net>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Ivan Malov" <ivan.malov@arknetworks.am>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>
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

PiBGcm9tOiBmZW5nY2hlbmd3ZW4gW21haWx0bzpmZW5nY2hlbmd3ZW5AaHVhd2VpLmNvbV0NCj4g
U2VudDogVHVlc2RheSwgNSBBdWd1c3QgMjAyNSAwMi41OQ0KPiANCj4gT24gOC80LzIwMjUgMzo0
MiBBTSwgTW9ydGVuIEJyw7hydXAgd3JvdGU6DQo+ID4gRW5hYmxpbmcgc29tZSBvZmZsb2FkIGJ5
IGRlZmF1bHQgbWF5IGNvbmZsaWN0IHdpdGggYSBtYW51YWxseQ0KPiBjb25maWd1cmVkDQo+ID4g
b2ZmbG9hZC4NCj4gPiBTcGVjaWZpY2FsbHksIHRoZSBtYnVmIGZhc3QgcmVsZWFzZSBUWCBvZmZs
b2FkLCB3aGljaCBjb25mbGljdHMgd2l0aA0KPiBtdWx0aQ0KPiA+IHNlZ21lbnQgcGFja2V0IFRY
IG9mZmxvYWQsIHdhcyBlbmFibGVkIGJ5IGRlZmF1bHQuDQo+ID4gVGhlcmVmb3JlLCBtYnVmIGZh
c3QgcmVsZWFzZSBUWCBvZmZsb2FkICh0aGUgb25seSBUWCBvZmZsb2FkIHdoaWNoIHdhcw0KPiA+
IGVuYWJsZWQgYnkgZGVmYXVsdCkgaXMgbm90IGVuYWJsZWQgYnkgZGVmYXVsdCBhbnltb3JlLg0K
PiANCj4gVGhpcyBtYXkgaW1wYWN0IGRlZmF1bHQgcGVyZm9ybWFuY2UsIG1hbnkgdmVuZG9yIHBl
cmZvcm1hbmNlIHJlcG9ydCBoYXMNCj4gdGVzdHBtZCBpb2Z3ZCBvciBtYWNmd2QgY2FzZS4NCg0K
WWVzLg0KDQpJTU8sIGFueSBvcHRpbWl6YXRpb25zLCBtYnVmLWZhc3QtZnJlZSBvciBtYnVmLXJl
Y3ljbGUsIG11c3QgYmUgZXhwbGljaXRseSBlbmFibGVkLCBhbmQgZG9jdW1lbnRlZCBpbiB0aGUg
cGVyZm9ybWFuY2UgcmVwb3J0cyB3aGVuIHVzZWQuDQpPdGhlcndpc2UgdGhlIHBlcmZvcm1hbmNl
IHJlcG9ydHMgZ2l2ZSBhIGZhbHNlIGltcHJlc3Npb24gb2YgaGlnaGVyIHBlcmZvcm1hbmNlLCB3
aGljaCBpcyBvbmx5IGF2YWlsYWJsZSB1bmRlciBjZXJ0YWluIGNpcmN1bXN0YW5jZXMuDQpJIGhh
dmUgY29tcGxhaW5lZCBhYm91dCB0aGlzIGJlZm9yZS4NCldoaWNoIGlzIGFsc28gd2h5IG1idWYt
cmVjeWNsZSBtdXN0IGJlIGV4cGxpY2l0bHkgZW5hYmxlZC4NCldpdGggdGhpcyBwYXRjaCwgdGhl
IHNhbWUgZmluYWxseSBhcHBsaWVzIHRvIG1idWYtZmFzdC1mcmVlIHRvby4NCkkgY291bGQgYWRk
IGEgRml4ZXMgdGFnLCBidXQgSSB0aGluayBpdCBpcyBiZXR0ZXIgdG8gY2F0ZWdvcml6ZSB0aGlz
IHBhdGNoIGFzIGFuIGltcHJvdmVtZW50IHJhdGhlciB0aGFuIGEgYnVnIGZpeC4NCg0K
