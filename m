Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6A5D12D6D
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Dec 2025 14:47:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDFBF402B7;
	Wed,  3 Dec 2025 15:47:11 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D9D414029D
 for <dev@dpdk.org>; Wed,  3 Dec 2025 15:47:09 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id AB6EF20B9F;
 Wed,  3 Dec 2025 15:47:09 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v3] net/ice: add MAC anti-spoof option
Date: Wed, 3 Dec 2025 15:47:08 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F655BA@smartserver.smartshare.dk>
In-Reply-To: <CY5PR11MB61160E99ADCBFDE1182D6BABE4D9A@CY5PR11MB6116.namprd11.prod.outlook.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3] net/ice: add MAC anti-spoof option
Thread-Index: AQHcZEGAPn5qQK3460OIGurf0zTObLUPyuyAgAAkB/CAAA4vQA==
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251203104126.75935-1-anurag.mandal@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655B7@smartserver.smartshare.dk>
 <CY5PR11MB61160E99ADCBFDE1182D6BABE4D9A@CY5PR11MB6116.namprd11.prod.outlook.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>,
	<dev@dpdk.org>
Cc: "Richardson, Bruce" <bruce.richardson@intel.com>,
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
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

PiBGcm9tOiBNYW5kYWwsIEFudXJhZyBbbWFpbHRvOmFudXJhZy5tYW5kYWxAaW50ZWwuY29tXQ0K
PiBTZW50OiBXZWRuZXNkYXksIDMgRGVjZW1iZXIgMjAyNSAxNS4zNg0KPiANCj4gSGkgTW9ydGVu
IEJyw7hydXAsDQo+IA0KPiBGcm9tOiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3Rl
bXMuY29tPg0KPiBTZW50OiAwMyBEZWNlbWJlciAyMDI1IDE3OjExDQo+ID4gQEAgLTE3NjEsMTMg
KzE3NjMsMzkgQEAgaWNlX3NldHVwX3ZzaShzdHJ1Y3QgaWNlX3BmICpwZiwgZW51bQ0KPiA+IGlj
ZV92c2lfdHlwZSB0eXBlKQ0KPiA+ICAJCS8qIFNvdXJjZSBQcnVuZSAqLw0KPiA+ICAJCWlmIChh
ZC0+ZGV2YXJncy5zb3VyY2VfcHJ1bmUgIT0gMSkgew0KPiA+ICAJCQkvKiBEaXNhYmxlIHNvdXJj
ZSBwcnVuZSB0byBzdXBwb3J0IFZSUlANCj4gPiAtCQkJICogd2hlbiBzb3VyY2UtcHJ1bmUgZGV2
YXJnIGlzIG5vdCBzZXQNCj4gPiArCQkJICogd2hlbiBzb3VyY2UtcHJ1bmUgZGV2YXJncyBpcyBu
b3Qgc2V0DQo+ID4gIAkJCSAqLw0KPiA+ICAJCQl2c2lfY3R4LmluZm8uc3dfZmxhZ3MgPQ0KPiA+
ICAJCQkJSUNFX0FRX1ZTSV9TV19GTEFHX0xPQ0FMX0xCOw0KPiA+IC0JCQl2c2lfY3R4LmluZm8u
c3dfZmxhZ3MgfD0NCj4gPiArCQl9IGVsc2UgeyAvKiBFbmFibGUgU291cmNlIFBydW5lIGluIFJ4
ICovDQo+ID4gKwkJCXZzaV9jdHguaW5mby5zd19mbGFncyA9DQo+ID4gIAkJCQlJQ0VfQVFfVlNJ
X1NXX0ZMQUdfU1JDX1BSVU5FOw0KPiA+ICAJCX0NCj4gDQo+IFRoaXMgbG9va3MgbGlrZSBhIGJ1
ZyBmaXggcmVsYXRlZCB0byBTb3VyY2UgUHJ1bmU/DQo+IA0KPiBBbnM6IE5vdCBleGFjdGx5Lg0K
PiBJbml0aWFsbHksIFNvdXJjZSBQcnVuZSB3YXMgZGlzYWJsZWQsIGFuZCBNQUMgQW50aS1zcG9v
ZiBjaGVjayB3YXMNCj4gZW5hYmxlZCBieSBkZWZhdWx0LiBUaGlzIHdhcyBkb25lIGJ5IGZvbGxv
d2luZzotDQo+IFNvdXJjZSBQcnVuZSBpcyBkaXNhYmxlZCBieSBzZXR0aW5nIGxvY2FsIGxvb3Bi
YWNrIHdpdGgNCj4gSUNFX0FRX1ZTSV9TV19GTEFHX0xPQ0FMX0xCIGZsYWcgaW4gdGhlIFJ4IGRp
cmVjdGlvbi4NCj4gSUNFX0FRX1ZTSV9TV19GTEFHX1NSQ19QUlVORSBpcyBhZGRlZCB0byBwcmV2
ZW50IHRyYW5zbWl0dGVkIHBhY2tldHMNCj4gZnJvbSBiZWluZyBsb29wZWQgYmFjayBpbiBzb21l
IGNpcmN1bXN0YW5jZXMuDQo+IE5vdywgTUFDIEFudGktc3Bvb2YgY2hlY2sgY2FuIGJlIGRpc2Fi
bGVkIGJ5IGNsZWFyaW5nIGJvdGgNCj4gSUNFX0FRX1ZTSV9TV19GTEFHX1NSQ19QUlVORSBhbmQN
Cj4gSUNFX0FRX1ZTSV9TRUNfRkxBR19FTkFfTUFDX0FOVElfU1BPT0YgZmxhZ3MgYW5kIHNldHRp
bmcgVHggbG9vcGJhY2sNCj4gd2l0aA0KPiBJQ0VfQVFfVlNJX1NXX0ZMQUdfQUxMT1dfTEIgZmxh
ZyBpbiB0aGUgVHggZGlyZWN0aW9uLg0KPiANCj4gQXMgd2UgbW92ZWQgdG8gbWFraW5nIGJvdGgg
c291cmNlIHBydW5lIGFuZCBtYWMgYW50aS1zcG9vZiBjaGVjaw0KPiBkaXNhYmxlZCBieSBkZWZh
dWx0LCBJIHRob3VnaHQgbm8gcG9pbnQgdG8gc2V0DQo+IElDRV9BUV9WU0lfU1dfRkxBR19TUkNf
UFJVTkUgZHVyaW5nIHNvdXJjZSBwcnVuZSBkaXNhYmxlIGFuZCB0aGVuDQo+IGNsZWFyaW5nIGl0
IHRvIGRpc2FibGUgbWFjIGFudGktc3Bvb2YuDQoNCk9LLiBUaGFuayB5b3UgZm9yIGVsYWJvcmF0
aW5nLg0KDQo+IA0KPiBUaGFuayB5b3UuDQo+IA0KPiBSZWdhcmRzLA0KPiBBbnVyYWcgTQ0KDQpO
b3RlIHRvIG1haW50YWluZXJzOg0KVGhpcyBkZXZhcmcgaXMgbGlrZSB0aGUgU291cmNlIFBydW5l
IGRldmFyZy4NCklmIHdlIHdhbnQgdG8gZWxldmF0ZSB0aGVzZSBleG90aWMgZmVhdHVyZXMgaW50
byBwcm9wZXIgRXRoZGV2IEFQSXMsIGl0IHNob3VsZCBiZSBkb25lIGZvciBib3RoIGRldmFyZ3Mg
aW4gYSBzZXBhcmF0ZSBwYXRjaC4NCg0KQWNrZWQtYnk6IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFy
dHNoYXJlc3lzdGVtcy5jb20+DQoNCg==
