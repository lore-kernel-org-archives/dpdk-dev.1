Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF22C0219D
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 09:18:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF45942EA9;
	Thu, 13 Feb 2025 10:18:38 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id AAB4E40287
 for <dev@dpdk.org>; Thu, 13 Feb 2025 10:18:37 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5BB252077A;
 Thu, 13 Feb 2025 10:18:37 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v4 0/4] Introduce Topology NUMA grouping for lcores
Date: Thu, 13 Feb 2025 10:18:34 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FA33@smartserver.smartshare.dk>
In-Reply-To: <2097299.UkFFEUeh36@thomas>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4 0/4] Introduce Topology NUMA grouping for lcores
Thread-Index: Adt98hEc6oNQCuI4RniFo+9v9gOU9QAA6F+w
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <PH7PR12MB85960CB35BB467CEBBC2CA2F82FF2@PH7PR12MB8596.namprd12.prod.outlook.com>
 <2097299.UkFFEUeh36@thomas>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>,
 "Thomas Monjalon" <thomas@monjalon.net>
Cc: <dev@dpdk.org>, <roretzla@linux.microsoft.com>,
 <bruce.richardson@intel.com>, <john.mcnamara@intel.com>,
 <dmitry.kozliuk@gmail.com>, <ajit.khaparde@broadcom.com>,
 "Song, Keesang" <Keesang.Song@amd.com>, <pbhagavatula@marvell.com>,
 <jerinj@marvell.com>, <ruifeng.wang@arm.com>,
 <mattias.ronnblom@ericsson.com>, <anatoly.burakov@intel.com>,
 <stephen@networkplumber.org>, "Yigit, Ferruh" <Ferruh.Yigit@amd.com>,
 <honnappa.nagarahalli@arm.com>, <wathsala.vithanage@arm.com>,
 <konstantin.ananyev@huawei.com>
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
ZW50OiBUaHVyc2RheSwgMTMgRmVicnVhcnkgMjAyNSAwOS4zNA0KPiANCj4gMTMvMDIvMjAyNSAw
NDowOSwgVmFyZ2hlc2UsIFZpcGluOg0KPiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQg
SW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+ID4NCj4gPiBBZGRpbmcgVGhvbWFzIGFuZCBB
aml0IHRvIHRoZSBsb29wLg0KPiA+DQo+ID4gSGkgQWppdCwgd2UgaGF2ZSBiZWVuIHVzaW5nIHRo
ZSBwYXRjaCBzZXJpZXMgZm9yIGlkZW50aWZ5aW5nIHRoZQ0KPiB0b3BvbG9neSBhbmQgZ2V0dGlu
ZyBsMyBjYWNoZSBpZCBmb3IgcG9wdWxhdGluZyB0aGUgc3RlZXJpbmcgdGFnIGZvcg0KPiBEZXZp
Y2UgU3BlY2lmaWMgTW9kZWwgJiBNU0kteCBkcml2ZW4gYWYteGRwIGZvciB0aGUgZXhwZXJpbWVu
dGFsIFNUQUcNCj4gZmlybXdhcmUgb24gVGhvci4NCg0KRXhjZWxsZW50LiBBIHJlYWwgbGlmZSBl
eGFtcGxlIHVzZSBjYXNlIGhlbHBzIHRoZSByZXZpZXcgcHJvY2VzcyBhIGxvdCENCg0KPiA+DQo+
ID4gSGVuY2UgY3VycmVudCB1c2Ugb2YgdG9wb2xvZ3kgbGlicmFyeSBoZWxwcyBpbg0KPiA+IDEu
IHdvcmtsb2FkIHBsYWNlbWVudCBpbiBzYW1lIENhY2hlIG9yIElPIGRvbWFpbg0KPiA+IDIuIHBv
cHVsYXRpbmcgaWQgZm9yIE1TSXggb3IgRGV2aWNlIHNwZWNpZmljIG1vZGVsIGZvciBzdGVlcmlu
ZyB0YWdzLg0KPiA+DQo+ID4gVGhvbWFzIGFuZCBBaml0aCBjYW4gd2UgZ2V0IHNvbWUgaGVscCB0
byBnZXQgdGhpcyBtYWlubGluZSB0b28/DQo+IA0KPiBZZXMsIHNvcnJ5IHRoZSByZXZpZXcgZGlz
Y3Vzc2lvbnMgZGlkIG5vdCBzdGFydC4NCj4gSXQgaGFzIGJlZW4gZm9yZ290dGVuLg0KDQpJIHRo
aW5rIHRoZSB0b3BvbG9neS9kb21haW4gQVBJIGluIHRoZSBFQUwgc2hvdWxkIGJlIGNvLWRlc2ln
bmVkIHdpdGggdGhlIHN0ZWVyaW5nIHRhZyBBUEkgaW4gdGhlIGV0aGRldiBsaWJyYXJ5LCBzbyB0
aGUgZGVzaWduIGNhbiBiZSByZXZpZXdlZC9kaXNjdXNzZWQgaW4gaXRzIGVudGlyZXR5Lg0KDQpU
byBoZWxwIHRoZSByZXZpZXcgZGlzY3Vzc2lvbiwgcGxlYXNlIGNvbnNpZGVyIGRlc2NyaWJpbmcg
dGhlIGZvbGxvd2luZzoNCldoaWNoIEFQSXMgYXJlIGZvciBzbG93IHBhdGgsIGFuZCB3aGljaCBh
cmUgZm9yIGZhc3QgcGF0aD8NCldoaWNoIEFQSXMgYXJlICJtdXN0IGhhdmUiLCBpLmUuIGNvcmUg
dG8gbWFraW5nIGl0IHdvcmsgYXQgYWxsLCBhbmQgd2hpY2ggQVBJcyBhcmUgIm5pY2UgdG8gaGF2
ZSIsIGkuZS4gc3VwcG9ydCBBUElzIHRvIGVhc2UgdXNlIG9mIHRoZSBuZXcgZmVhdHVyZXM/DQoN
CkkgaGF2ZW4ndCBsb29rZWQgYXQgdGhlIGh3bG9jIGxpYnJhcnkncyBBUEk7IGJ1dCBJIGd1ZXNz
IHRoZXNlIG5ldyBFQUwgZnVuY3Rpb25zIGFyZSBjbG9zZWx5IHJlbGF0ZWQuIElzIGl0IGEgdGhp
biB3cmFwcGVyIGFyb3VuZCB0aGUgaHdsb2MgbGlicmFyeSwgb3IgaXMgaXQgdmVyeSBkaWZmZXJl
bnQ/DQoNCg==
