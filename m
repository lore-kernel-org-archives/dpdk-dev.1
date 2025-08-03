Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802F3C87FCB
	for <dpdk-dev@archiver.kernel.org>; Sun,  3 Aug 2025 10:52:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50A4240291;
	Sun,  3 Aug 2025 12:52:04 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B987240270
 for <dev@dpdk.org>; Sun,  3 Aug 2025 12:52:00 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 9EDF220446;
 Sun,  3 Aug 2025 12:51:59 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] ethdev: Reject conflicting TX offloads configuration
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sun, 3 Aug 2025 12:51:59 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FDE2@smartserver.smartshare.dk>
In-Reply-To: <66e365f2-8398-43b2-58a6-cda29bae08e1@arknetworks.am>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ethdev: Reject conflicting TX offloads configuration
Thread-Index: AdwD9SVsl3FH41HoQ0mgIPjselFYVwAbUYBg
References: <20250731090731.671589-1-mb@smartsharesystems.com>
 <20250802135354.158d8561@hermes.local>
 <66e365f2-8398-43b2-58a6-cda29bae08e1@arknetworks.am>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Ivan Malov" <ivan.malov@arknetworks.am>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>, "Thomas Monjalon" <thomas@monjalon.net>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
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

PiBGcm9tOiBJdmFuIE1hbG92IFttYWlsdG86aXZhbi5tYWxvdkBhcmtuZXR3b3Jrcy5hbV0NCj4g
U2VudDogU2F0dXJkYXksIDIgQXVndXN0IDIwMjUgMjMuMzQNCj4gDQo+IEhpLA0KPiANCj4gT24g
U2F0LCAyIEF1ZyAyMDI1LCBTdGVwaGVuIEhlbW1pbmdlciB3cm90ZToNCj4gDQo+ID4gT24gVGh1
LCAzMSBKdWwgMjAyNSAwOTowNzozMSArMDAwMA0KPiA+IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFy
dHNoYXJlc3lzdGVtcy5jb20+IHdyb3RlOg0KPiA+DQo+ID4+ICsJCVJURV9FVEhERVZfTE9HX0xJ
TkUoREVCVUcsDQo+ID4+ICsJCQkiRXRoZGV2IHBvcnRfaWQ9JWQgdHhfcXVldWVfaWQ9JWQsIFR4
IG9mZmxvYWQgJXMNCj4gcG90ZW50aWFsIGNvbmZsaWN0IHdpdGggcGVyLXBvcnQgVHggb2ZmbG9h
ZCAlcywgIg0KPiA+PiArCQkJInJ1bnRpbWUgc3VwcG9ydCBkZXBlbmRzIG9uIHRoZSBkcml2ZXIi
LA0KPiA+DQo+ID4gU2hvcnRlbiB0aGUgbWVzc2FnZSwgYW5kIGdldCBpdCBvbiBvbmUgbGluZS4N
Cj4gPiBXaGVuIGEgbWVzc2FnZSBpcyBzbyBsb25nIGl0IHdvbid0IGZpdCBvbiBvbmUgbGluZSwg
aXQgaXMgdG9vIHZlcmJvc2UuDQo+IA0KPiBJIGFtIG5vdCBhbiBleHBlcnQgaW4gbmFtaW5nLCBi
dXQgb24gdGhlIHByZW1pc2UgdGhhdCAnZXRoZGV2JyBpcw0KPiBhbHJlYWR5DQo+IHByaW50ZWQg
YnkgJ1JURV9FVEhERVZfTE9HX0xJTkUnLCBwZXJoYXBzIGNvbnNpZGVyIHRoaXMgdmFyaWFudDoN
Cj4gDQo+ICJpZD0lZCB0eHE9JWQgb2ZmbG9hZCBjbGFzaCAlcyB2cyBkZXYgJXM6IFBNRCB0byBk
ZWNpZGUiDQo+IA0KPiBUaGFuayB5b3UuDQoNCkl2YW4ncyBzdWdnZXN0aW9uIGlzIGdvb2QsIGJ1
dCB0aGlzIGZpbGUgaGFzIHBsZW50eSBvZiBsb25nIChhbmQgZXZlbiBtdWx0aS1saW5lKSBsb2cg
bWVzc2FnZXMsIGUuZy4gWzFdOg0KDQoJaWYgKChsb2NhbF9jb25mLm9mZmxvYWRzICYgZGV2X2lu
Zm8udHhfcXVldWVfb2ZmbG9hZF9jYXBhKSAhPQ0KCSAgICAgbG9jYWxfY29uZi5vZmZsb2Fkcykg
ew0KCQlSVEVfRVRIREVWX0xPR19MSU5FKEVSUiwNCgkJCSJFdGhkZXYgcG9ydF9pZD0lZCB0eF9x
dWV1ZV9pZD0lZCwgbmV3IGFkZGVkIG9mZmxvYWRzIDB4JSJQUkl4NjQiIG11c3QgYmUgIg0KCQkJ
IndpdGhpbiBwZXItcXVldWUgb2ZmbG9hZCBjYXBhYmlsaXRpZXMgMHglIlBSSXg2NCIgaW4gJXMo
KSIsDQoJCQlwb3J0X2lkLCB0eF9xdWV1ZV9pZCwgbG9jYWxfY29uZi5vZmZsb2FkcywNCgkJCWRl
dl9pbmZvLnR4X3F1ZXVlX29mZmxvYWRfY2FwYSwNCgkJCV9fZnVuY19fKTsNCgkJcmV0dXJuIC1F
SU5WQUw7DQoJfQ0KDQpbMV06IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2RwZGsvdjI1LjA3
L3NvdXJjZS9saWIvZXRoZGV2L3J0ZV9ldGhkZXYuYyNMMjcwMw0KDQpXaGljaCBkbyB5b3UgcHJl
ZmVyOg0KYSkgRm9sbG93IHRoZSBsb2NhbCBjb2Rpbmcgc3R5bGUgZm9yIGxvZyBtZXNzYWdlcywg
b3INCmIpIEZvbGxvdyBvdXIgZ2VuZXJhbCBjb2Rpbmcgc3R5bGUsIGFuZCBsb2cgYXMgSXZhbiBz
dWdnZXN0ZWQ/DQoNCg0K
