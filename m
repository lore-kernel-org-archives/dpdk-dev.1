Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27B8C9EC90
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 13:59:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D42640611;
	Mon, 12 Jan 2026 14:59:10 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 905EA40156;
 Mon, 12 Jan 2026 14:59:08 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id AF275206E5;
 Mon, 12 Jan 2026 14:59:07 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] net/af_xdp: fix external mbuf transmit
Date: Mon, 12 Jan 2026 14:59:03 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65655@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <CAJFAV8yvx_eLo9_wBDrzW-G+qiUYftGC1xUdAT6bLeCTVaxcoA@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net/af_xdp: fix external mbuf transmit
Thread-Index: AdyDmVAdvEOLpafwSTeBXF8d6lI2vAAMRNSg
References: <20260105125441.50447-1-david.marchand@redhat.com>
 <20260111170350.6fa88e03@phoenix.local>
 <CAJFAV8yvx_eLo9_wBDrzW-G+qiUYftGC1xUdAT6bLeCTVaxcoA@mail.gmail.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "David Marchand" <david.marchand@redhat.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, "Ciara Loftus" <ciara.loftus@intel.com>,
 "Maryam Tahhan" <mtahhan@redhat.com>,
 "Xiaolong Ye" <xiaolong.ye@intel.com>,
 "Kevin Laatz" <kevin.laatz@intel.com>,
 "Thomas Monjalon" <thomas@monjalon.net>
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
DQo+IFNlbnQ6IE1vbmRheSwgMTIgSmFudWFyeSAyMDI2IDA4LjU5DQo+IA0KPiBIZWxsbywNCj4g
DQo+IE9uIE1vbiwgMTIgSmFuIDIwMjYgYXQgMDI6MDQsIFN0ZXBoZW4gSGVtbWluZ2VyDQo+IDxz
dGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4gd3JvdGU6DQo+ID4gIyMjIyBXYXJuaW5nIChNaW5v
cikNCj4gPg0KPiA+ICoqSW1wbGljaXQgYm9vbGVhbiBjb21wYXJpc29uOioqIFRoZSBgUlRFX01C
VUZfRElSRUNUKG1idWYpYCBtYWNybw0KPiByZXR1cm5zIGFuIGludGVnZXItbGlrZSB2YWx1ZSAo
MCBvciBub24temVybykuIFBlciBEUERLIGd1aWRlbGluZXMsDQo+IGV4cGxpY2l0IGNvbXBhcmlz
b24gd2l0aCB6ZXJvIGlzIHByZWZlcnJlZCBmb3IgaW50ZWdlcnM6DQo+ID4NCj4gPiBgYGBjDQo+
ID4gLy8gU3VnZ2VzdGVkIChzdHJpY3QgaW50ZXJwcmV0YXRpb24pOg0KPiA+IGlmIChSVEVfTUJV
Rl9ESVJFQ1QobWJ1ZikgIT0gMCAmJiBtYnVmLT5wb29sID09IHVtZW0tPm1iX3Bvb2wpIHsNCj4g
PiBgYGANCj4gPg0KPiA+IEhvd2V2ZXIsIHRoaXMgbWFjcm8gaXMgc2VtYW50aWNhbGx5IGJvb2xl
YW4gYW5kIGlzIGNvbW1vbmx5IHVzZWQgaW4NCj4gZGlyZWN0IGZvcm0gdGhyb3VnaG91dCBEUERL
LiBUaGlzIGlzIGEgc3R5bGlzdGljIHByZWZlcmVuY2UsIG5vdCBhDQo+IGJsb2NraW5nIGlzc3Vl
Lg0KPiANCj4gQWxsIGNhbGxlcnMgaW4gRFBESyBhcmUgdXNpbmcgdGhpcyBtYWNybyBhcyBhIGJv
b2xlYW4sIGFuZCBJIGZvdW5kIG5vDQo+IG9wZW5zb3VyY2UgcHJvamVjdCBkb2luZyBkaWZmZXJl
bnRseS4NCj4gSSB3b3VsZCBlaXRoZXIgZml4IHRoZSBtYWNybyBvciBjaGFuZ2Ugbm90aGluZyBh
dCBhbGwuDQoNClRoZSBtYWNybydzIHJldHVybiB0eXBlIGlzIGludCwgbm90IGJvb2wuDQoNCkhv
d2V2ZXIsIGl0IGlzIGRlZmluZWQgYXMgIiFzb21ldGhpbmcoKSIsIHNvIGl0IHJldHVybnMgb25s
eSAwIG9yIDE6DQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9kcGRrL3YyNS4xMS9zb3VyY2Uv
bGliL21idWYvcnRlX21idWZfY29yZS5oI0w3MzINCg0KQWxzbyBpbiBEUERLIDI0LjExOg0KaHR0
cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vZHBkay92MjQuMTEvc291cmNlL2xpYi9tYnVmL3J0ZV9t
YnVmX2NvcmUuaCNMNzE1DQoNCkFuZCBpbiBEUERLIDE3LjExOg0KaHR0cHM6Ly9lbGl4aXIuYm9v
dGxpbi5jb20vZHBkay92MTcuMTEvc291cmNlL2xpYi9saWJydGVfbWJ1Zi9ydGVfbWJ1Zi5oI0w3
MTQNCg0KSGF2ZW4ndCBnb25lIGZ1cnRoZXIgYmFjayBpbiBoaXN0b3J5LiA6LSkNCg0K
