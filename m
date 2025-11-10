Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C50CCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 08:53:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1619F402C8;
	Mon, 10 Nov 2025 09:53:28 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D8B13400D5
 for <dev@dpdk.org>; Mon, 10 Nov 2025 09:53:25 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D3C80206DC;
 Mon, 10 Nov 2025 09:53:24 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [RFC PATCH v2 01/33] eal: add more min/max helpers
Date: Mon, 10 Nov 2025 09:53:22 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65545@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <b03c5c49-c1a7-4003-a350-587e0e6b8341@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH v2 01/33] eal: add more min/max helpers
Thread-Index: AdxR3UzSXIFkq/8tRL6G+3qU1PauBwAQByqQ
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
 <20251107155034.436809-2-bruce.richardson@intel.com>
 <b03c5c49-c1a7-4003-a350-587e0e6b8341@huawei.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "fengchengwen" <fengchengwen@huawei.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>, <dev@dpdk.org>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: "Tyler Retzlaff" <roretzla@linux.microsoft.com>
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

PiBGcm9tOiBmZW5nY2hlbmd3ZW4gW21haWx0bzpmZW5nY2hlbmd3ZW5AaHVhd2VpLmNvbV0NCj4g
DQo+IEFja2VkLWJ5OiBDaGVuZ3dlbiBGZW5nIDxmZW5nY2hlbmd3ZW5AaHVhd2VpLmNvbT4NCj4g
DQo+IE9uIDExLzcvMjAyNSAxMTo0OSBQTSwgQnJ1Y2UgUmljaGFyZHNvbiB3cm90ZToNCj4gPiBG
cm9tOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+ID4N
Cj4gPiBBZGQgUlRFX01JTjMoKSB0byBoYW5kbGUgY2FzZSBvZiBSVEVfTUlOKFJURV9NSU4oLi4u
KSksIGFuZCBzaW1pbGFybHkNCj4gPiBhZGQgUlRFX01BWDMoKS4NCg0KRG8gd2UgbmVlZCBSVEVf
TUlOM19UKCkvUlRFX01BWDNfVCgpIG1hY3JvcyB0b28/DQoNCj4gPiBDaGFuZ2UgbmFtZSBvZiBs
b2NhbCB0ZW1wb3JhcnkgdmFyaWFibGVzIGluIFJURV9NQVgoKQ0KPiA+IHRvIGFsbG93IGZvciBj
b21iaW5hdGlvbnMgb2YgUlRFX01JTihSVEVfTUFYKC4uLikpIHdpdGhvdXQgY2F1c2luZw0KPiA+
IHNoYWRvdyBkZWNsYXJhdGlvbiB3YXJuaW5ncy4NCg0KQ29uc2lkZXIgbWFraW5nIHRoZSBsb2Nh
bCB0ZW1wb3JhcnkgdmFyaWFibGVzIGluIFJURV9NSU4oKSBtb3JlIHVuaXF1ZSB0b28sIGluIGNh
c2UgdGhlIG1hY3JvIGlzIGNvbWJpbmVkIHdpdGggc29tZSBvdGhlciBtYWNybyBhbHNvIHVzaW5n
IF9hIGFuZCBfYi4NCg0KPGZlYXR1cmUgY3JlZXA+DQpNYXliZSBhbiBSVEVfTUlOTUFYKG1pbixt
YXgsdmFsKSB3b3VsZCBiZSB1c2VmdWw/DQpTYW1lIGFib3V0IFJURV9NSU5NQVhfVChtaW4sbWF4
LHZhbCx0eXBlKT8NCjwvZmVhdHVyZSBjcmVlcD4NCg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
U3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEJydWNlIFJpY2hhcmRzb24gPGJydWNlLnJpY2hhcmRzb25AaW50ZWwuY29tPg0K
DQpXaXRoIG9yIHdpdGhvdXQgc3VnZ2VzdGVkIGFkZGl0aW9ucywNCkFja2VkLWJ5OiBNb3J0ZW4g
QnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KDQo=
