Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB81CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 17:55:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DCBF40297;
	Thu,  9 Oct 2025 19:55:19 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 97B654027A
 for <dev@dpdk.org>; Thu,  9 Oct 2025 19:55:18 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4D5C2202CC;
 Thu,  9 Oct 2025 19:55:18 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v8 1/3] mbuf: de-inline sanity checking a reinitialized
 mbuf
Date: Thu, 9 Oct 2025 19:55:16 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654B8@smartserver.smartshare.dk>
In-Reply-To: <3916365.44csPzL39Z@thomas>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v8 1/3] mbuf: de-inline sanity checking a reinitialized
 mbuf
Thread-Index: Adw5QjoVJrVXfu4wSE+4ogrozTPfKQAAQm6A
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <aOfnq0bx0py_XTQz@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F654B6@smartserver.smartshare.dk>
 <3916365.44csPzL39Z@thomas>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: "Bruce Richardson" <bruce.richardson@intel.com>, <dev@dpdk.org>,
 "Stephen Hemminger" <stephen@networkplumber.org>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Ivan Malov" <ivan.malov@arknetworks.am>,
 "Chengwen Feng" <fengchengwen@huawei.com>
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
ZW50OiBUaHVyc2RheSwgOSBPY3RvYmVyIDIwMjUgMTkuMjkNCj4gDQo+IDA5LzEwLzIwMjUgMTk6
MTIsIE1vcnRlbiBCcsO4cnVwOg0KPiA+IEZyb206IEJydWNlIFJpY2hhcmRzb24gW21haWx0bzpi
cnVjZS5yaWNoYXJkc29uQGludGVsLmNvbV0NCj4gPiA+IE9uIFNhdCwgQXVnIDIzLCAyMDI1IGF0
IDA2OjMwOjAwQU0gKzAwMDAsIE1vcnRlbiBCcsO4cnVwIHdyb3RlOg0KPiA+ID4gPiArLyoqICBj
aGVjayByZWluaXRpYWxpemVkIG1idWYgdHlwZSBpbiBkZWJ1ZyBtb2RlICovDQo+ID4gPg0KPiA+
ID4gVGhpcyBpcyBpbiByZWxlYXNlIG1vZGUsIG5vdCBkZWJ1ZyBtb2RlLiBDb21tZW50IGJlbG93
IHNlZW1zIHdyb25nDQo+IHRvby4NCj4gPg0KPiA+IFllcywgSSBub3RpY2VkIHRoZSBjb21tZW50
IHdhcyBwcmVzZW50IGluIGJvdGggZGVidWcgYW5kIHJlbGVhc2UNCj4gbW9kZSwNCj4gPiB3aGlj
aCBJIGNvdWxkbid0IHVuZGVyc3RhbmQuIFNvIEkgZ3Vlc3NlZCBpdCB3YXMgZm9yIERveHlnZW4g
b3Igc29tZQ0KPiBvdGhlciBwYXJzZXIuDQo+ID4gSSBoYXZlIHNlZW4gd2VpcmQgc3R1ZmYgZm9y
IERveHlnZW4sIGUuZy4gIiNpZmRlZiBfX0RPWFlHRU5fXyINCj4gPiBmb3IgZG9jdW1lbnRpbmcg
YSBmdW5jdGlvbiBbMV0sDQo+ID4gc28gSSBkaWRuJ3QgYXR0ZW1wdCB0byB1bmRlcnN0YW5kIHRo
ZSByZWFzb24gZm9yIGl0LA0KPiA+IGJ1dCBqdXN0IGZvbGxvd2VkIHRoZSBzYW1lIHBhdHRlcm4u
DQo+IA0KPiBIdW0sIGFzIGEgbWFpbnRhaW5lciwgSSB3b3VsZCBwcmVmZXIgeW91IHRyeSB0byB1
bmRlcnN0YW5kLCBvciBhc2sNCj4gcGxlYXNlLg0KPiBOb3RlOiB3ZSBjYW4gdXNlIFNsYWNrIGZv
ciBzdWNoIHF1ZXN0aW9ucy4NCg0KUG9pbnQgdGFrZW4uIEdvb2QgZ3VpZGFuY2UhDQpJJ2xsIHRy
eSB0byBicm9hZGVuIG15IHNjb3BlIG9mIGtub3dsZWRnZSB0byBpbmNsdWRlIHByZXByb2Nlc3Np
bmcgZm9yIERveHlnZW4uDQoNCj4gDQo+IF9fRE9YWUdFTl9fIGlzIGRlZmluZWQgb25seSBieSBE
b3h5Z2VuLA0KPiBzbyBhbnkgY29kZSBpbnNpZGUgI2lmZGVmIF9fRE9YWUdFTl9fIGlzIGZvciBk
b2N1bWVudGF0aW9uIG9ubHkuDQo+IEl0IHdhcyBzdXBwb3NlZCB0byBiZSB1c2VkIGluIGxpYi9l
YWwvaW5jbHVkZS9nZW5lcmljDQo+IGZvciBmdW5jdGlvbnMgd2hpY2ggYXJlIHJlYWxseSBkZWZp
bmVkIGlubGluZSBwZXIgQ1BVIGltcGxlbWVudGF0aW9uLg0KPiANClllcywgSSBnZXQgdGhhdC4N
CkJ1dCBJIGRvbid0IGdldCAtIHdoZW4gdGhlcmUgYXJlIHR3byBkZWZpbml0aW9ucyBvZiBhIG1h
Y3JvIC0gd2h5IGlzIHRoZSBzYW1lIGNvbW1lbnQvZG9jdW1lbnRhdGlvbiBwcmVzZW50IGluIGJv
dGggaW5zdGFuY2VzPw0KQW5kIGlmIHRoZSBpbnN0YW5jZXMgaGF2ZSBkaWZmZXJlbnQgY29tbWVu
dHMvZG9jdW1lbnRhdGlvbiwgaG93IGlzIHRoYXQgcmVmbGVjdGVkIGluIHRoZSBkb2N1bWVudGF0
aW9uIG91dHB1dCBmcm9tIERveHlnZW4/DQoNCkluIHRoaXMgc3BlY2lmaWMgY2FzZSwgaG93IHNo
b3VsZCB0aGUgY29kZSBsb29rIHRvIGJvdGggMSkgZ2V0IHRoZSB3YW50ZWQgRG94eWdlbiBkb2N1
bWVudGF0aW9uIG91dHB1dCwgYW5kIDIpIGhhdmUgcmVsZXZhbnQgY29tbWVudHMgaW5saW5lIGlu
IHRoZSBzb3VyY2UgY29kZSBmb3IgYm90aCBpbnN0YW5jZXM/DQoNCg==
