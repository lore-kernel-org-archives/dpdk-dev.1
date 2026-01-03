Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AD8FC6160
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Jan 2026 17:46:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23BCD40267;
	Sat,  3 Jan 2026 18:46:07 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id BB1AA40262;
 Sat,  3 Jan 2026 18:46:05 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E2C5B208CF;
 Sat,  3 Jan 2026 18:46:04 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] mbuf: fix packet copy
Date: Sat, 3 Jan 2026 18:46:03 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6561A@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20251119120403.907511-1-mb@smartsharesystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mbuf: fix packet copy
Thread-Index: AdxZTJorOUhx0EXzTH2tsl7JhzajBgjjB52w
References: <20251119120403.907511-1-mb@smartsharesystems.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: <stable@dpdk.org>
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

UElORyBmb3IgcmV2aWV3Lg0KDQo+IEZyb206IE1vcnRlbiBCcsO4cnVwIFttYWlsdG86bWJAc21h
cnRzaGFyZXN5c3RlbXMuY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIDE5IE5vdmVtYmVyIDIwMjUg
MTMuMDQNCj4gDQo+IFJlcXVlc3RzIGZvciBjb3B5aW5nIHRoZSBhdCB0aGUgZW5kIG9mIGEgcGFj
a2V0IGluY29ycmVjdGx5IHJldHVybmVkDQo+IE5VTEwsDQo+IGFzIGlmIGNvcHlpbmcgcGFzdCB0
aGUgZW5kIG9mIGEgcGFja2V0Lg0KPiANCj4gV2hlbiBhbGxvY2F0aW5nIGNvcGllcyBmcm9tIGEg
bWVtcG9vbCB1c2luZyBwaW5uZWQgZXh0ZXJuYWwgYnVmZmVycywNCj4gdGhlDQo+IGV4dGVybmFs
IGZsYWcgd2FzIG5vdCBwcmVzZXJ2ZWQgaW4gdGhlc2UgbWJ1ZnMuDQo+IA0KPiBGaXhlczogYzNh
OTBjMzgxZGFhICgibWJ1ZjogYWRkIGEgY29weSByb3V0aW5lIikNCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQo+IC0tLQ0KPiAg
bGliL21idWYvcnRlX21idWYuYyB8IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2xpYi9tYnVmL3J0
ZV9tYnVmLmMgYi9saWIvbWJ1Zi9ydGVfbWJ1Zi5jDQo+IGluZGV4IDBkOTMxYzdhMTUuLmU2Mzlh
ZmYwM2UgMTAwNjQ0DQo+IC0tLSBhL2xpYi9tYnVmL3J0ZV9tYnVmLmMNCj4gKysrIGIvbGliL21i
dWYvcnRlX21idWYuYw0KPiBAQCAtNjc1LDcgKzY3NSw3IEBAIHJ0ZV9wa3RtYnVmX2NvcHkoY29u
c3Qgc3RydWN0IHJ0ZV9tYnVmICptLCBzdHJ1Y3QNCj4gcnRlX21lbXBvb2wgKm1wLA0KPiAgCV9f
cnRlX21idWZfc2FuaXR5X2NoZWNrKG0sIDEpOw0KPiANCj4gIAkvKiBjaGVjayBmb3IgcmVxdWVz
dCB0byBjb3B5IGF0IG9mZnNldCBwYXN0IGVuZCBvZiBtYnVmICovDQo+IC0JaWYgKHVubGlrZWx5
KG9mZiA+PSBtLT5wa3RfbGVuKSkNCj4gKwlpZiAodW5saWtlbHkob2ZmID4gbS0+cGt0X2xlbikp
DQo+ICAJCXJldHVybiBOVUxMOw0KPiANCj4gIAltYyA9IHJ0ZV9wa3RtYnVmX2FsbG9jKG1wKTsN
Cj4gQEAgLTY4OCw4ICs2ODgsOCBAQCBydGVfcGt0bWJ1Zl9jb3B5KGNvbnN0IHN0cnVjdCBydGVf
bWJ1ZiAqbSwgc3RydWN0DQo+IHJ0ZV9tZW1wb29sICptcCwNCj4gDQo+ICAJX19ydGVfcGt0bWJ1
Zl9jb3B5X2hkcihtYywgbSk7DQo+IA0KPiAtCS8qIGNvcGllZCBtYnVmIGlzIG5vdCBpbmRpcmVj
dCBvciBleHRlcm5hbCAqLw0KPiAtCW1jLT5vbF9mbGFncyA9IG0tPm9sX2ZsYWdzICYNCj4gfihS
VEVfTUJVRl9GX0lORElSRUNUfFJURV9NQlVGX0ZfRVhURVJOQUwpOw0KPiArCS8qIGNvcHkgZmxh
Z3MgZXhjZXB0IGluZGlyZWN0IGFuZCBleHRlcm5hbCwgYW5kIHByZXNlcnZlIGZsYWdzIG9mDQo+
IG5ld2x5IGFsbG9jYXRlZCBtYnVmICovDQo+ICsJbWMtPm9sX2ZsYWdzIHw9IG0tPm9sX2ZsYWdz
ICYNCj4gfihSVEVfTUJVRl9GX0lORElSRUNUfFJURV9NQlVGX0ZfRVhURVJOQUwpOw0KPiANCj4g
IAlwcmV2ID0gJm1jLT5uZXh0Ow0KPiAgCW1fbGFzdCA9IG1jOw0KPiAtLQ0KPiAyLjQzLjANCg0K
