Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EECC5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 08:43:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCF594028E;
	Tue,  3 Jun 2025 10:43:16 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5D4FD4025A
 for <dev@dpdk.org>; Tue,  3 Jun 2025 10:43:16 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 35D5720100;
 Tue,  3 Jun 2025 10:43:15 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v5 3/4] ethdev: introduce the cache stashing hints API
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 3 Jun 2025 10:43:11 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FCB2@smartserver.smartshare.dk>
In-Reply-To: <20250602223805.816816-4-wathsala.vithanage@arm.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5 3/4] ethdev: introduce the cache stashing hints API
Thread-Index: AdvUDxazfuPtZbRaRoinhIqOax92sgAUU49w
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-4-wathsala.vithanage@arm.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Thomas Monjalon" <thomas@monjalon.net>,
 "Ferruh Yigit" <ferruh.yigit@amd.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
Cc: <dev@dpdk.org>, <nd@arm.com>,
 "Honnappa Nagarahalli" <honnappa.nagarahalli@arm.com>,
 "Dhruv Tripathi" <dhruv.tripathi@arm.com>
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

PiBGcm9tOiBXYXRoc2FsYSBWaXRoYW5hZ2UgW21haWx0bzp3YXRoc2FsYS52aXRoYW5hZ2VAYXJt
LmNvbV0NCj4gU2VudDogVHVlc2RheSwgMyBKdW5lIDIwMjUgMDAuMzgNCj4gDQo+IEV4dGVuZCB0
aGUgZXRoZGV2IGxpYnJhcnkgdG8gZW5hYmxlIHRoZSBzdGFzaGluZyBvZiBkaWZmZXJlbnQgZGF0
YQ0KPiBvYmplY3RzLCBzdWNoIGFzIHRoZSBvbmVzIGxpc3RlZCBiZWxvdywgaW50byBDUFUgY2Fj
aGVzIGRpcmVjdGx5DQo+IGZyb20gdGhlIE5JQy4NCj4gDQo+IC0gUngvVHggcXVldWUgZGVzY3Jp
cHRvcnMNCj4gLSBSeCBwYWNrZXRzDQo+IC0gUGFja2V0IGhlYWRlcnMNCj4gLSBwYWNrZXQgcGF5
bG9hZHMNCj4gLSBEYXRhIG9mIGEgcGFja2V0IGF0IGFuIG9mZnNldCBmcm9tIHRoZSBzdGFydCBv
ZiB0aGUgcGFja2V0DQo+IA0KPiBUaGUgQVBJcyBhcmUgZGVzaWduZWQgaW4gYSBoYXJkd2FyZS92
ZW5kb3IgYWdub3N0aWMgbWFubmVyIHN1Y2ggdGhhdA0KPiBzdXBwb3J0aW5nIFBNRHMgY291bGQg
dXNlIGFueSBjYXBhYmlsaXRpZXMgYXZhaWxhYmxlIGluIHRoZSB1bmRlcmx5aW5nDQo+IGhhcmR3
YXJlIGZvciBmaW5lLWdyYWluZWQgc3Rhc2hpbmcgb2YgZGF0YSBvYmplY3RzIGludG8gYSBDUFUg
Y2FjaGUNCj4gDQo+IFRoZSBBUEkgcHJvdmlkZXMgYW4gaW50ZXJmYWNlIHRvIHF1ZXJ5IHRoZSBh
dmFpbGFiaWxpdHkgb2Ygc3Rhc2hpbmcNCj4gY2FwYWJpbGl0aWVzLCBpLmUuLCBwbGF0Zm9ybS9O
SUMgc3VwcG9ydCwgc3Rhc2hhYmxlIG9iamVjdCB0eXBlcywgZXRjLA0KPiB2aWEgdGhlIHJ0ZV9l
dGhfZGV2X3N0YXNoaW5nX2NhcGFiaWxpdGllc19nZXQgaW50ZXJmYWNlLg0KPiANCj4gVGhlIGZ1
bmN0aW9uIHBhaXIgcnRlX2V0aF9kZXZfc3Rhc2hpbmdfcnhfY29uZmlnX3NldCBhbmQNCj4gcnRl
X2V0aF9kZXZfc3Rhc2hpbmdfdHhfY29uZmlnX3NldCBzZXRzIHRoZSBzdGFzaGluZyBoaW50ICh0
aGUgQ1BVLA0KPiBjYWNoZSBsZXZlbCwgYW5kIGRhdGEgb2JqZWN0IHR5cGVzKSBvbiB0aGUgUngg
YW5kIFR4IHF1ZXVlcy4NCj4gDQo+IFBNRHMgdGhhdCBzdXBwb3J0IHN0YXNoaW5nIG11c3QgcmVn
aXN0ZXIgdGhlaXIgaW1wbGVtZW50YXRpb25zIHdpdGggdGhlDQo+IGZvbGxvd2luZyBldGhfZGV2
X29wcyBjYWxsYmFja3MsIHdoaWNoIGFyZSBpbnZva2VkIGJ5IHRoZSBldGhkZXYNCj4gZnVuY3Rp
b25zIGxpc3RlZCBhYm92ZS4NCj4gDQo+IC0gc3Rhc2hpbmdfY2FwYWJpbGl0aWVzX2dldA0KPiAt
IHN0YXNoaW5nX3J4X2hpbnRzX3NldA0KPiAtIHN0YXNoaW5nX3R4X2hpbnRzX3NldA0KPiANCj4g
U2lnbmVkLW9mZi1ieTogV2F0aHNhbGEgVml0aGFuYWdlIDx3YXRoc2FsYS52aXRoYW5hZ2VAYXJt
LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEhvbm5hcHBhIE5hZ2FyYWhhbGxpIDxob25uYXBwYS5uYWdh
cmFoYWxsaUBhcm0uY29tPg0KPiBSZXZpZXdlZC1ieTogRGhydXYgVHJpcGF0aGkgPGRocnV2LnRy
aXBhdGhpQGFybS5jb20+DQoNCk5pdHBpY2tpbmc6DQoNCkluIERQREssICJvYmplY3RzIiB1c3Vh
bGx5IHJlZmVyIHRvIG1idWZzLCBtZW1wb29sIGVsZW1lbnRzIG9yIHNpbWlsYXIuDQpTbyBwbGVh
c2UgdXNlIHRoZSB0ZXJtICJmbGFncyIgaW5zdGVhZCBvZiAib2JqZWN0cyIuIEFsc28gaW4gdGhl
IG1hY3JvcywgZGVmaW5pdGlvbnMgYW5kIGNvbW1lbnRzLg0KDQpBbmQgRFBESyB1c3VhbGx5IHVz
ZXMgNjQgYml0IGZvciBmbGFncywgc28gdGhleSBzaG91bGQgYmUgdWludDY0X3QuIFVubGVzcyB0
aGVyZSBpcyBhIGZhc3QgcGF0aCBwZXJmb3JtYW5jZSByZWxhdGVkIHJlYXNvbiB0byBtYWtlIHRo
ZW0gc2hvcnRlci4NCg0KSWYgeW91IHVzZSB0aGUgc2FtZSBmbGFncyBmb3IgYm90aCBSWCBhbmQg
VFgsIGluc3RlYWQgb2YgcHJvdmlkaW5nIHNlcGFyYXRlIGRlZmluaXRpb25zIGZvciBUWCBmbGFn
cywgdGhlIGRlc2NyaXB0aW9ucyBvZiB0aGUgZmxhZ3Mgc2hvdWxkIHJlZmxlY3QgdGhpcy4NCg0K
VGhlIGNhcGFiaWxpdGllcyBBUElzIHNob3VsZCBvdXRwdXQgdGhlIGxpc3QvcmFuZ2Ugb2YgdmFs
aWQgIm9mZnNldCIgdmFsdWVzIGZvciBSWCBhbmQgVFguDQoNCkFuZCBpZiB0aGUgb2Zmc2V0IGNh
bm5vdCBiZSBuZWdhdGl2ZSwgcGxlYXNlIHVzZSBhbiB1bnNpZ25lZCB0eXBlIGZvciBpdC4NCg0K
VGhlIGxpYi9ldGhkZXYvcnRlX2V0aGRldi5jIGZvbGxvd3MgdGhlIGRlc2lnbiBwYXR0ZXJuIG9m
IHNldHRpbmcgcnRlX2Vycm5vIGFuZCByZXR1cm5pbmcgLTEgb24gZXJyb3IuDQpQbGVhc2UgZm9s
bG93IHRoZSBzYW1lIGRlc2lnbiBwYXR0ZXJuIGluIHRoZSBuZXcgZnVuY3Rpb25zIGFkZGVkIHRv
IHRoZSBydGVfZXRoZGV2IGxpYnJhcnkuDQoNCg==
