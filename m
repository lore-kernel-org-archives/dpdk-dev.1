Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F7BCAC598
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 01:22:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59FE44027A;
	Wed, 17 Sep 2025 03:22:50 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 12CA64025A
 for <dev@dpdk.org>; Wed, 17 Sep 2025 03:22:49 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 91C4F20CAD;
 Wed, 17 Sep 2025 03:22:48 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v2 1/4] mbuf: record mbuf operations history
Date: Wed, 17 Sep 2025 03:22:47 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6543A@smartserver.smartshare.dk>
In-Reply-To: <7063702.lOV4Wx5bFT@thomas>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 1/4] mbuf: record mbuf operations history
Thread-Index: AdwnUZRtH75TqrbrTsu18GDnFbO/HAAH7hBQ
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250916151207.556618-2-shperetz@nvidia.com>
 <20250916141731.4e140fcf@hermes.local> <7063702.lOV4Wx5bFT@thomas>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
 "Shani Peretz" <shperetz@nvidia.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>, <bruce.richardson@intel.com>, <ajit.khaparde@broadcom.com>,
 <jerinj@marvell.com>, <konstantin.v.ananyev@yandex.ru>,
 <david.marchand@redhat.com>, <maxime.coquelin@redhat.com>,
 <gakhil@marvell.com>, <viacheslavo@nvidia.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
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
ZW50OiBUdWVzZGF5LCAxNiBTZXB0ZW1iZXIgMjAyNSAyMy4zNA0KPiANCj4gMTYvMDkvMjAyNSAy
MzoxNywgU3RlcGhlbiBIZW1taW5nZXI6DQo+ID4gT24gVHVlLCAxNiBTZXAgMjAyNSAxODoxMjow
NCArMDMwMA0KPiA+IFNoYW5pIFBlcmV0eiA8c2hwZXJldHpAbnZpZGlhLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPiA+IEBAIC02MDcsNiArNjA4LDkgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgcnRlX21i
dWYNCj4gKnJ0ZV9tYnVmX3Jhd19hbGxvYyhzdHJ1Y3QgcnRlX21lbXBvb2wgKm1wKQ0KPiA+ID4g
IAlpZiAocnRlX21lbXBvb2xfZ2V0KG1wLCAmcmV0LnB0cikgPCAwKQ0KPiA+ID4gIAkJcmV0dXJu
IE5VTEw7DQo+ID4gPiAgCV9fcnRlX21idWZfcmF3X3Nhbml0eV9jaGVjayhyZXQubSk7DQo+ID4g
PiArI2lmIFJURV9NQlVGX0hJU1RPUllfREVCVUcNCj4gPiA+ICsJcnRlX21idWZfaGlzdG9yeV9t
YXJrKHJldC5tLCBSVEVfTUJVRl9BTExPQyk7DQo+ID4gPiArI2VuZGlmDQo+ID4gPiAgCXJldHVy
biByZXQubTsNCj4gPiA+ICB9DQo+ID4NCj4gPiBJZiB5b3UgbWFkZSBydGVfbWJ1Zl9oaXN0b3J5
X21hcmsgYSBkdW1teSBmdW5jdGlvbiBpZg0KPiBSVEVfTUJVRl9ISVNUT1JZX0RFQlVHDQo+ID4g
d2FzIG5vdCBkZWZpbmVkLCB0aGVuIHlvdSBjb3VsZCByZW1vdmUgbW9zdCBvZiB0aGUgI2lmZGVm
IGNsdXR0ZXIgYW5kDQo+ID4gd291bGQgZ2V0IHR5cGUgY2hlY2tpbmcgb24gbm9ybWFsIGJ1aWxk
cy4NCj4gDQo+IFllcyBnb29kIGlkZWEhDQoNCisxDQoNCj4gV2UgbmVlZCB0byBjaGVjayB3aGV0
aGVyIGFuIGVtcHR5IGlubGluZSBmdW5jdGlvbiB3aWxsIGJlIGNvbXBsZXRlbHkNCj4gb3B0aW1p
emVkIG91dCBieSB0aGUgY29tcGlsZXJzIChjbGFuZyBhbmQgR0NDKS4NCj4gDQpJdCB3b3JrcyBm
b3IgdHJhY2UuDQoNCg==
