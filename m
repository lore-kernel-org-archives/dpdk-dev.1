Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8006FD3B9A9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Dec 2025 09:44:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FD274028F;
	Wed, 10 Dec 2025 10:44:09 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 57CC240285;
 Wed, 10 Dec 2025 10:44:08 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 25C27206A1;
 Wed, 10 Dec 2025 10:44:08 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: Indirect mbuf handling
Date: Wed, 10 Dec 2025 10:44:06 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F655D0@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <CAFLDJDoVgNj9JjUbDEUP=gaXOMKS2jYiYVFFPULWOthfPqzwFg@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Indirect mbuf handling
Thread-Index: AdxpLgidfioQh6o0SxaFVXJjcxlLCgAifipw
References: <CAFLDJDprPRB8mjybypwuvHOEp+MfXjSK6W1YJD=Db2CURUhLNA@mail.gmail.com>
 <CAFLDJDoVgNj9JjUbDEUP=gaXOMKS2jYiYVFFPULWOthfPqzwFg@mail.gmail.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "narsimharaj pentam" <pnarsimharaj@gmail.com>, <users@dpdk.org>,
 <dev@dpdk.org>
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

PiBGcm9tOiBuYXJzaW1oYXJhaiBwZW50YW0gW21haWx0bzpwbmFyc2ltaGFyYWpAZ21haWwuY29t
XSANCj4gU2VudDogVHVlc2RheSwgOSBEZWNlbWJlciAyMDI1IDE4LjA1DQo+IA0KPiBBZGRlZCBk
ZXYgZ3JvdXAuDQo+IA0KPiBPbiBUdWUsIERlYyA5LCAyMDI1IGF0IDEwOjEx4oCvUE0gbmFyc2lt
aGFyYWogcGVudGFtIDxwbmFyc2ltaGFyYWpAZ21haWwuY29tPiB3cm90ZToNCj4gSGkgDQo+IA0K
PiBJIGhhdmUgYSBxdWVyeSByZWxhdGVkIHRvIGlwIGZyYWdtZW50YXRpb24gaGFuZGxpbmcgaW4g
RFBESy4NCj4gDQo+IFRoZSBEUERLIGFwcGxpY2F0aW9uIGlzIHRyeWluZyB0byBzZW5kIGEgbGFy
Z2VyIHBhY2tldCB0aGFuIHRoZSBjb25maWd1cmVkIE1UVSBvbiB0aGUgaW50ZXJmYWNlLCBiZWZv
cmUgc2VuZGluZyB0aGUgcGFja2V0IHRvIHRoZSAgaTQwZSBQTUQgdGhlIHBhY2tldCB3aWxsDQo+
IHVuZGVyZ28gZnJhZ21lbnRhdGlvbiAuIFRoZSBEUERLIGxpYnJhcnkgZnVuY3Rpb24gInJ0ZV9p
cHY0X2ZyYWdtZW50X3BhY2tldCIgaXMgdXNlZCBmb3IgZnJhZ21lbnRhdGlvbi4gRnVuY3Rpb24g
cnRlX2lwdjRfZnJhZ21lbnRfcGFja2V0IHdpbGwgY3JlYXRlDQo+IGRpcmVjdCBhbmQgaW5kaXJl
Y3QgbWJ1ZidzICBmb3IgYSBmcmFnbWVudCAsIHRoZSBpbmRpcmVjdCBidWZmZXJzIHdpbGwgaGF2
ZSByZWZlcmVuY2UgdG8gdGhlIG1idWYgb2YgdGhlIGFjdHVhbCBwYWNrZXQgKHplcm8gY29weSku
DQo+IA0KPiBUaGUgYXBwbGljYXRpb24gd2lsbCBjYWxsIGZ1bmN0aW9uIHJ0ZV9ldGhfdHhfYnVy
c3QgdG8gdHJhbnNtaXQgZnJhZ21lbnRzICwgd2hpY2ggaW50ZXJuYWxseSBpbnZva2VzIGk0MGVf
eG1pdF9wa3RzICwgdGhlIHF1ZXN0aW9uIGhlcmUgIGlzIHdoZW4gc2hvdWxkIG1haW4gYXBwbGlj
YXRpb24NCj4gbWJ1ZiBzaG91bGQgYmUgZnJlZWQgLCBjYW4gSXQgYmUgZnJlZWQgaW1tZWRpYXRl
bHkgIGFmdGVyIGk0MGVfeG1pdF9wa3RzIHJldHVybnMgc3VjY2Vzcywgbm90IHN1cmUgYmVjYXVz
ZSB0aGUgbWJ1ZidzIGFyZSBxdWV1ZWQgdXAgaW4gc29mdHdhcmUgcmluZyBiZWZvcmUgYWN0dWFs
IHRyYW5zbWl0LCANCj4gSSBhbSB3b3JyaWVkIGFib3V0IHRoZSBmcmFnbWVudHMgaG9sZGluZyBy
ZWZlcmVuY2VzIHRvIHRoZSBtYWluIGFwcGxpY2F0aW9uIGJ1ZmZlci4NCg0KVGhlIG9yaWdpbmFs
IHBhY2tldCBjYW4gYmUgZnJlZWQgaW1tZWRpYXRlbHkgd2hlbiB0aGVuIGZyYWdtZW50cyBoYXZl
IGJlZW4gY3JlYXRlZC4NCg0KVGhpcyBpcyB3aGF0IHRoZSBmcmFnbWVudGF0aW9uIGV4YW1wbGUg
ZG9lczoNCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2RwZGsvdjI1LjExL3NvdXJjZS9leGFt
cGxlcy9pcF9mcmFnbWVudGF0aW9uL21haW4uYyNMMjg5DQoNClRoaXMgaXMgd2hhdCBoYXBwZW5z
Og0KVGhlIG9yaWdpbmFsIHBhY2tldCBoYXMgYSByZWZlcmVuY2UgY291bnRlciAod2hpY2ggd2Fz
IGluY3JlbWVudGVkIGZvciBlYWNoIG9mIHRoZSBpbmRpcmVjdCBtYnVmcyByZWZlcnJpbmcgdG8g
aXQpLCBzbyBmcmVlaW5nIGl0IGF0IHRoYXQgcG9pbnQgZG9lc24ndCBwdXQgaXQgYmFjayBpbiB0
aGUgcG9vbC4NCldoZW4gdGhlIGxhc3Qgb2YgdGhlIGluZGlyZWN0IG1idWZzIGlzIGZyZWVkIChi
eSB0aGUgZHJpdmVyIGNhbGxlZCBieSBydGVfZXRoX3R4X2J1cnN0KCkpLCB0aGUgb3JpZ2luYWwg
cGFja2V0J3MgcmVmZXJlbmNlIGNvdW50ZXIgcmVhY2hlcyB6ZXJvLCBhbmQgdGhlbiB0aGUgb3Jp
Z2luYWwgbWJ1ZiBpcyBwdXQgYmFjayBpbiB0aGUgcG9vbC4NCg0KPiANCj4gVGhhbmtzLg0KPiAN
Cj4gQlINCj4gTmFyc2ltaGENCg0K
