Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D61C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 11:04:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DB8D427C3;
	Wed,  4 Jun 2025 13:04:48 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 059164029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 13:04:48 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D682A21ED6;
 Wed,  4 Jun 2025 13:04:47 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v5 0/3] add portable version of __builtin_add_overflow
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 4 Jun 2025 13:04:44 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FCC0@smartserver.smartshare.dk>
In-Reply-To: <CAJFAV8wboVDP8fp=CyQwi6nD7bbu11RjBa35un5yr0faAp2i1g@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5 0/3] add portable version of __builtin_add_overflow
Thread-Index: AdvVPUTKQBnCMqg6QX6E32y3VUvf2wAAKWbQ
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1741962820-27123-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8z3zqxm_VLXkztjThS3XhuKrJ0kf_yjeSgx+VjXaoyh7w@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FCBF@smartserver.smartshare.dk>
 <CAJFAV8wboVDP8fp=CyQwi6nD7bbu11RjBa35un5yr0faAp2i1g@mail.gmail.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "David Marchand" <david.marchand@redhat.com>
Cc: "Andre Muezerie" <andremue@linux.microsoft.com>,
 "Thomas Monjalon" <thomas@monjalon.net>, <dev@dpdk.org>,
 "Stephen Hemminger" <stephen@networkplumber.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>
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

PiBGcm9tOiBEYXZpZCBNYXJjaGFuZCBbbWFpbHRvOmRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb21d
DQo+IFNlbnQ6IFdlZG5lc2RheSwgNCBKdW5lIDIwMjUgMTIuNDENCj4gDQo+IE9uIFdlZCwgSnVu
IDQsIDIwMjUgYXQgMTI6MjnigK9QTSBNb3J0ZW4gQnLDuHJ1cA0KPiA8bWJAc21hcnRzaGFyZXN5
c3RlbXMuY29tPiB3cm90ZToNCj4gPiA+IEkgYW0gbm90IGEgZmFuIG9mIGFkZGluZyBzdWNoIHB1
YmxpYyBBUEksIGFuIGludGVybmFsIEFQSSB3b3VsZCBiZQ0KPiA+ID4gZW5vdWdoLg0KPiA+ID4g
RG8geW91IHBsYW4gdG8gYWRkIG1vcmUgaGVscGVycyBmb3IgbWF0aCBvcGVyYXRpb25zPw0KPiA+
ID4NCj4gPiA+IEZvciB0aGUgY3VycmVudCBoZWxwZXIsIHRoZSBvbmx5IHVzZXIgaXMgYSBkcml2
ZXIgKGJhc2UgY29kZSkuDQo+ID4gPiBDYW4ndCB3ZSBqdXN0IHdyYXAgYSBfX2J1aWx0aW5fYWRk
X292ZXJmbG93ICh1bmRlciAjaWZkZWYgbXN2YykgaW4NCj4gdGhlDQo+ID4gPiBvc2RlcC5oIGhl
YWRlcj8NCj4gPg0KPiA+IFdlIGFscmVhZHkgaGF2ZSBwdWJsaWMgQVBJcyBmb3IgYml0IG9wZXJh
dGlvbnMgaW4gcnRlX2JpdG9wcy5oLg0KPiA+IFRoaXMgbWF0aCBBUEkgZm9sbG93cyB0aGUgc2Ft
ZSBwcmluY2lwbGU7IGFuZCBtYXRoIG9wZXJhdGlvbnMgLSBqdXN0DQo+IGxpa2UgYml0IG9wZXJh
dGlvbnMgLSBtaWdodCBiZSB1c2VmdWwgZm9yIERQREsgYXBwbGljYXRpb25zLCBzbyBsZXQncw0K
PiBrZWVwIGl0IHB1YmxpYy4NCj4gDQo+IFRoaXMgY29tcGFyaXNvbiBpcyBwb29yLg0KPiANCj4g
VGhlcmUgYXJlIG1hbnkgdXNlcnMgb2YgYml0b3BzIGluIGRwZGssIGFuZCAqcHVibGljKiBoZWFk
ZXJzIG5lZWRlZCBpdC4NCg0KSSBkb24ndCB0aGluayB0aGUgbnVtYmVyIG9mIHVzZXMgb2YgYSBn
ZW5lcmljIGZ1bmN0aW9uIHNob3VsZCBkZXRlcm1pbmUgaWYgaXQgc2hvdWxkIGJlIHB1YmxpYyBv
ciBwcml2YXRlLg0KVGhlIGltcG9ydGFudCB0aGluZyBpcyBhdm9pZGluZyBjb3B5LXBhc3Rpbmcu
DQoNCj4gDQo+IEhlcmUsIHdlIGhhdmUgb25lIHNpbmdsZSBmdW5jdGlvbiBpbiBhIGRyaXZlciBp
bXBsZW1lbnRhdGlvbi4NCj4gQW5kIHRoaXMgY29kZSBpcyB1bnVzZWQgKF9fYnVpbHRpbl9hZGRf
b3ZlcmZsb3cgLT4gY2hlY2tfYWRkX292ZXJmbG93DQo+IC0+IGljZV9nZXRfcGZhX21vZHVsZV90
bHYgLT4gaWNlX2dldF9saW5rX2RlZmF1bHRfb3ZlcnJpZGUgLT4NCj4gaWNlX2NmZ19waHlfZmVj
LCB3aXRoIG5vIGludHJlZSB1c2VyKS4NCj4gDQoNCkknbSBtYWlubHkgc2F5aW5nIHRoYXQgQW5k
cmUgaXMgZG9pbmcgbm90aGluZyB3cm9uZyBoZXJlOyBpdCdzIGEgbWF0dGVyIG9mIHNldHRpbmcg
dGhlIGJhciBmb3IgbWFraW5nIGdlbmVyaWMgZnVuY3Rpb25zIHBhcnQgb2YgRFBESydzIHB1Ymxp
YyBBUEkuDQoNCkluIHRoaXMgcGFydGljdWxhciBjYXNlLCBJIGRvbid0IGhhdmUgYSBzdHJvbmcg
b3BpbmlvbiBvbiBob3cgcHVibGljIHRoZSBuZXcgZnVuY3Rpb24gaXMuDQpQdXR0aW5nIGl0IGlu
IHNvbWUgZ2VuZXJpYyBwcml2YXRlIGhlYWRlciBpcyBhbHNvIHBlcmZlY3RseSBhY2NlcHRhYmxl
IGZvciBtZS4NCkp1c3QgZG9uJ3QgcHV0IGl0IGRpcmVjdGx5IGluIHRoZSBkcml2ZXI7IHRoYXQg
d291bGQgbGVhZCB0byBjb3B5LXBhc3RlIGludG8gb3RoZXIgZHJpdmVycy4NCg0KPiANCj4gPg0K
PiA+IFRoZSBvbmx5IGlzc3VlIEkgaGF2ZSB3aXRoIHRoZXNlIChpbmNsLiB0aGUgYml0IG9wZXJh
dGlvbnMpIGFyZSB0aGF0DQo+IHRoZXkgYXJlIGluIHRoZSBFQUwgbGlicmFyeSwgYWx0aG91Z2gg
dGhleSBoYXZlIGFic29sdXRlbHkgbm90aGluZyB0bw0KPiBkbyB3aXRoIGhhcmR3YXJlIG9yIE8v
UyBhYnN0cmFjdGlvbiwgc28gdGhleSByZWFsbHkgc2hvdWxkIGJlIGluIGENCj4gInV0aWxzIiBs
aWJyYXJ5Lg0KPiA+IEJ1dCB0aGF0J3MgYW5vdGhlciBzdG9yeSwgc28gbGV0J3Mgbm90IGJ1cmRl
biBBbmRyZSB3aXRoIHRoYXQuDQo+IA0KPiBPcnRob2dvbmFsIHRvIHRoZSBxdWVzdGlvbi4NCg0K
UGFydGx5LCB5ZXMuDQpCdXQgaWYgd2UgaGFkIGEgZ2VuZXJpYyAidXRpbHMiIGxpYnJhcnksIHRo
ZXJlIHdvdWxkIGJlIGxlc3MgcmVzaXN0YW5jZSB0byBhZGRpbmcgdGhlIG5ldyBmdW5jdGlvbiB0
aGVyZSB0aGFuIHRoZXJlIGlzIHRvIGFkZGluZyBpdCB0byB0aGUgRUFMIEFQSS4NCg0K
