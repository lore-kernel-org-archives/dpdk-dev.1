Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9549103E305
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Mar 2026 15:36:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C501440279;
	Fri, 13 Mar 2026 16:36:05 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id CBCBC4026C
 for <dev@dpdk.org>; Fri, 13 Mar 2026 16:36:04 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 9EF42209EC;
 Fri, 13 Mar 2026 16:36:04 +0100 (CET)
Content-class: urn:content-classes:message
Subject: RE: [RFC PATCH v3 1/2] mempool: simplify get objects
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 13 Mar 2026 16:36:02 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65791@smartserver.smartshare.dk>
In-Reply-To: <24cc7908-f8f4-4bbe-944f-885169f0f68b@oktetlabs.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [RFC PATCH v3 1/2] mempool: simplify get objects
Thread-Index: Adyf1VXg0GdbUv3lQgiGn4JFgCWujgTKTsMw
References: <20260216115813.103515-1-mb@smartsharesystems.com>
 <20260216152320.105312-1-mb@smartsharesystems.com>
 <20260216152320.105312-2-mb@smartsharesystems.com>
 <24cc7908-f8f4-4bbe-944f-885169f0f68b@oktetlabs.ru>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: <dev@dpdk.org>
Cc: "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
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
YnMucnVdDQo+IFNlbnQ6IFR1ZXNkYXksIDE3IEZlYnJ1YXJ5IDIwMjYgMDcuMTkNCj4gDQo+IEhp
IE1vcnRlbiwNCj4gDQo+IE9uIDIvMTYvMjYgNjoyMyBQTSwgTW9ydGVuIEJyw7hydXAgd3JvdGU6
DQo+ID4gUmVtb3ZlZCBleHBsaWNpdCB0ZXN0IGZvciBidWlsZCB0aW1lIGNvbnN0YW50IHJlcXVl
c3Qgc2l6ZSwNCj4gPiBhbmQgYWRkZWQgY29tbWVudCB0aGF0IHRoZSBjb21waWxlciBsb29wIHVu
cm9sbHMgd2hlbiByZXF1ZXN0IHNpemUgaXMNCj4gPiBidWlsZCB0aW1lIGNvbnN0YW50LCB0byBp
bXByb3ZlIHNvdXJjZSBjb2RlIHJlYWRhYmlsaXR5Lg0KPiA+DQo+ID4gTW92ZWQgc2V0dGluZyBj
YWNoZS0+bGVuIHVwIGJlZm9yZSB0aGUgY29weSBsb29wOyBub3Qgb25seSBmb3IgY29kZQ0KPiA+
IHNpbWlsYXJpdHkgKGNhY2hlLT5sZW4gaXMgbm93IHNldCBiZWZvcmUgZWFjaCBjb3B5IGxvb3Ap
LCBidXQgYWxzbyBhcw0KPiBhbg0KPiA+IG9wdGltaXphdGlvbjoNCj4gPiBUaGUgZnVuY3Rpb24n
cyBwb2ludGVyIHBhcmFtZXRlcnMgYXJlIG5vdCBtYXJrZWQgcmVzdHJpY3QsIHNvIHdyaXRpbmcN
Cj4gdG8NCj4gPiBvYmpfdGFibGUgaW4gdGhlIGNvcHkgbG9vcCBtaWdodCBmb3JtYWxseSBtb2Rp
ZnkgY2FjaGUtPnNpemUuIEFuZA0KPiB0aHVzLA0KPiA+IHNldHRpbmcgY2FjaGUtPmxlbiA9IGNh
Y2hlLT5zaXplIGFmdGVyIHRoZSBjb3B5IGxvb3AgcmVxdWlyZXMgbG9hZGluZw0KPiA+IGNhY2hl
LT5zaXplIGFnYWluIGFmdGVyIGNvcHlpbmcgdGhlIG9iamVjdHMuDQo+ID4gTW92aW5nIHRoaXMg
bGluZSB1cCBiZWZvcmUgdGhlIGNvcHkgbG9vcCBhdm9pZHMgdGhhdCBleHRyYSBsb2FkIG9mDQo+
ID4gY2FjaGUtPnNpemUgd2hlbiBzZXR0aW5nIGNhY2hlLT5sZW4uDQo+ID4NCj4gPiBTaW1pbGFy
bHksIG1vdmVkIHN0YXRpc3RpY3MgdXBkYXRlIHVwIGJlZm9yZSB0aGUgY29weSBsb29wcy4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVt
cy5jb20+DQo+IA0KPiBMR1RNLCB0aGUgcmVzdWx0IGxvb2tzIHNpbXBsZXIsIGVhc2llciB0byBy
ZWFkIGFuZCB1bmRlcnN0YW5kLg0KPiBJZiB0aGVyZSBpcyBubyBtZWFzdXJhYmxlIHBlcmZvcm1h
bmNlIGRlZ3JhZGF0aW9uIGFmdGVyIHRoZSBwYXRjaA0KPiANCj4gUmV2aWV3ZWQtYnk6IEFuZHJl
dyBSeWJjaGVua28gPGFuZHJldy5yeWJjaGVua29Ab2t0ZXRsYWJzLnJ1Pg0KPiANCg0KVGhlcmUn
cyBhIHJlYWwgcGF0Y2ggWzFdIGZvciB0aGlzIFJGQyBwYXRjaCAxLzIuDQpNYXJraW5nIHRoaXMg
UkZDIHBhdGNoIDEvMiBhcyBTdXBlcnNlZGVkLg0KDQpbMV06IGh0dHBzOi8vcGF0Y2h3b3JrLmRw
ZGsub3JnL3Byb2plY3QvZHBkay9wYXRjaC8yMDI2MDIxNjA5Mjc1MC45NDEzNy0xLW1iQHNtYXJ0
c2hhcmVzeXN0ZW1zLmNvbS8NCg0K
