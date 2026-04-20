Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750D5F5581D
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Apr 2026 11:24:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C42494028D;
	Mon, 20 Apr 2026 13:24:21 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 6690940278;
 Mon, 20 Apr 2026 13:24:20 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 28FD523C33;
 Mon, 20 Apr 2026 13:24:20 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] mbuf: fix mbuf operations history recording
Date: Mon, 20 Apr 2026 13:24:17 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65802@smartserver.smartshare.dk>
In-Reply-To: <23075230.EfDdHjke4D@thomas>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mbuf: fix mbuf operations history recording
Thread-Index: AdzQrVntIUdjhyujSneTExpNRsNmJwACe88A
References: <20260419221220.86455-1-mb@smartsharesystems.com>
 <23075230.EfDdHjke4D@thomas>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: <dev@dpdk.org>,
	"Shani Peretz" <shperetz@nvidia.com>,
	<stable@dpdk.org>
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

PiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0bzp0aG9tYXNAbW9uamFsb24ubmV0XQ0KPiBT
ZW50OiBNb25kYXksIDIwIEFwcmlsIDIwMjYgMTIuMDYNCj4gDQo+IDIwLzA0LzIwMjYgMDA6MTIs
IE1vcnRlbiBCcsO4cnVwOg0KPiA+IFRoaXMgYWRkcmVzc2VzIHR3byBidWdzIGluIG1idWYgb3Bl
cmF0aW9ucyBoaXN0b3J5IHJlY29yZGluZy4NCj4gPg0KPiA+IDEuIFdpdGggbWJ1ZiBvcGVyYXRp
b25zIGhpc3RvcnkgcmVjb3JkaW5nIGVuYWJsZWQsIHdoZW4gYWxsb2NhdGluZw0KPiBtYnVmcw0K
PiA+IGZyb20gYSBtZW1wb29sIGZhaWxlZCwgdGhlIGFycmF5IG9mIGZldGNoZWQgbWJ1ZiBwb2lu
dGVycyB3YXMgbm90DQo+IHNldCwgYnV0DQo+ID4gaXQgd2FzIGRlcmVmZXJlbmNlZCBmb3IgbWJ1
ZiBvcGVyYXRpb25zIGhpc3RvcnkgcmVjb3JkaW5nIGFueXdheSwNCj4gd2hpY2gNCj4gPiB3b3Vs
ZCB0cmlnZ2VyIGEgc2VnbWVudGF0aW9uIGZhdWx0IG9yIGNhdXNlIHVuZGVmaW5lZCBiZWhhdmlv
ci4NCj4gPg0KPiA+IFRoaXMgd2FzIGZpeGVkIGJ5IGNoYW5naW5nIGhvdyB0aGUgcmV0dXJuIHZh
bHVlIGZyb20gdGhlIG1lbXBvb2wNCj4gPiBhbGxvY2F0aW9uIGlzIGNoZWNrZWQsIHNvIHRoZSBm
dW5jdGlvbiByZXR1cm5zIGVhcmx5IG9uIGZhaWx1cmUsIGFuZA0KPiBvbmx5DQo+ID4gcHJvY2Vl
ZHMgb24gc3VjY2Vzcy4NCj4gPg0KPiA+IDIuIFdoZW4gYWxsb2NhdGluZyBhIGJ1bGsgb2YgbWJ1
ZnMgdXNpbmcgcnRlX3BrdG1idWZfYWxsb2NfYnVsaygpLA0KPiB0d28NCj4gPiBtYnVmIGxpYnJh
cnkgYWxsb2NhdGlvbiBvcGVyYXRpb25zIHdlcmUgcmVjb3JkZWQgb24gdGhlIG1idWYsIGJlY2F1
c2UNCj4gdGhlDQo+ID4gZnVuY3Rpb24gY2FsbHMgcnRlX21idWZfcmF3X2FsbG9jX2J1bGsoKSBm
b3IgYWxsb2NhdGlvbiwgYW5kIGJvdGgNCj4gPiBmdW5jdGlvbnMgcmVjb3JkIGEgbWJ1ZiBsaWJy
YXJ5IGFsbG9jYXRpb24gb3BlcmF0aW9uLg0KPiA+DQo+ID4gVGhpcyB3YXMgZml4ZWQgYnkgbm90
IHJlY29yZGluZyBhIG1idWYgbGlicmFyeSBhbGxvY2F0aW9uIG9wZXJhdGlvbg0KPiBpbg0KPiA+
IHJ0ZV9wa3RtYnVmX2FsbG9jX2J1bGsoKS4NCj4gPg0KPiA+IEZpeGVzOiBkMjY1YTI0YTMyYTQg
KCJtYnVmOiByZWNvcmQgbWJ1ZiBvcGVyYXRpb25zIGhpc3RvcnkiKQ0KPiA+IENjOiBzdGFibGVA
ZHBkay5vcmcNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFy
dHNoYXJlc3lzdGVtcy5jb20+DQo+IFsuLi5dDQo+IA0KPiBJdCB3b3VsZCBiZSBiZXR0ZXIgdG8g
bWFrZSBhbiBleHBsaWNpdCBjb21wYXJpc29uICE9IDAgYmVsb3c6DQo+IA0KPiA+ICsJaWYgKHVu
bGlrZWx5KHJjKSkNCj4gPiArCQlyZXR1cm4gcmM7DQoNCkkgd291bGQgbm9ybWFsbHkgaGF2ZSBk
b25lIHRoYXQsIGJ1dCBkZWNpZGVkIHRvIGRvIGl0IGxpa2UgcnRlX3BrdG1idWZfYWxsb2NfYnVs
aygpLg0KSWYgaXQgd2FzIGEgcG9pbnRlciwgSSB3b3VsZCBwcm9iYWJseSBoYXZlIGNvbXBhcmVk
ICE9IE5VTEwgcmVnYXJkbGVzcyBvZiBjb252ZW50aW9ucyBpbiB0aGUgZmlsZS4NCg0KPiANCj4g
VGhhbmsgeW91IGZvciB0aGUgZml4ZXMuDQo+IA0KPiBBY2tlZC1ieTogVGhvbWFzIE1vbmphbG9u
IDx0aG9tYXNAbW9uamFsb24ubmV0Pg0KDQpUaGFua3MgZm9yIHRoZSBmYXN0IHJldmlldyByZXNw
b25zZS4NCg0K
