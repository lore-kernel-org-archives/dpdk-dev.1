Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5686C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 14:17:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9064D40BA4;
	Tue,  3 Jun 2025 16:17:45 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1603B40B97
 for <dev@dpdk.org>; Tue,  3 Jun 2025 16:17:44 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D3D8720100;
 Tue,  3 Jun 2025 16:17:43 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v17 0/4] add support for self monitoring
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 3 Jun 2025 16:17:38 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FCB8@smartserver.smartshare.dk>
In-Reply-To: <15762368.uLZWGnKmhe@thomas>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v17 0/4] add support for self monitoring
Thread-Index: AdvUi1y2W2STKl4zTi+cXuxn3Ak69wAALmXg
References: <20241118073706.3129423-1-tduszynski@marvell.com>
 <20250117090033.2807073-1-tduszynski@marvell.com>
 <15762368.uLZWGnKmhe@thomas>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
 "Tomasz Duszynski" <tduszynski@marvell.com>
Cc: <dev@dpdk.org>, <Ruifeng.Wang@arm.com>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, <jerinj@marvell.com>,
 <konstantin.v.ananyev@yandex.ru>, <mattias.ronnblom@ericsson.com>,
 <roretzla@linux.microsoft.com>, <stephen@networkplumber.org>,
 <zhoumin@loongson.cn>
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
ZW50OiBUdWVzZGF5LCAzIEp1bmUgMjAyNSAxNS4yOA0KPiANCj4gSGVsbG8sDQo+IA0KPiAxNy8w
MS8yMDI1IDEwOjAwLCBUb21hc3ogRHVzenluc2tpOg0KPiA+ICBsaWIvcG11L21lc29uLmJ1aWxk
ICAgICAgICAgICAgICAgICAgICAgIHwgIDIyICsNCj4gPiAgbGliL3BtdS9wbXVfYXJtNjQuYyAg
ICAgICAgICAgICAgICAgICAgICB8ICA5NCArKysrDQo+ID4gIGxpYi9wbXUvcG11X3ByaXZhdGUu
aCAgICAgICAgICAgICAgICAgICAgfCAgMzIgKysNCj4gPiAgbGliL3BtdS9ydGVfcG11LmMgICAg
ICAgICAgICAgICAgICAgICAgICB8IDUzNw0KPiArKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
ICBsaWIvcG11L3J0ZV9wbXUuaCAgICAgICAgICAgICAgICAgICAgICAgIHwgMjUxICsrKysrKysr
KysrDQo+ID4gIGxpYi9wbXUvcnRlX3BtdV9wbWNfYXJtNjQuaCAgICAgICAgICAgICAgfCAgMzAg
KysNCj4gPiAgbGliL3BtdS9ydGVfcG11X3BtY194ODZfNjQuaCAgICAgICAgICAgICB8ICAyNCAr
DQo+IA0KPiBSZWFkaW5nIGl0IGFnYWluLCBJIHdvbmRlciB3aHkgaXQgaXMgYSBzZXBhcmF0ZSBs
aWJyYXJ5Lg0KPiBJbiBnZW5lcmFsIHdlIGdpdmUgYWNjZXNzIHRvIHRoZSBoYXJkd2FyZSBpbiBF
QUwuDQo+IFdoeSBub3QgaGF2aW5nIFBNVSBpbiBFQUw/DQo+IA0KDQpJTU8sIHRoZSBFQUwgc2hv
dWxkIGJlIGEgdGhpbiBzaGltIGxheWVyLCBwcm92aWRpbmcgYWJzdHJhY3Rpb25zIHRvIG9ubHkg
dGhlICJtdXN0IGhhdmUiIHBhcnRzIG9mIGFueSB1bmRlcmx5aW5nIGhhcmR3YXJlIGFuZCBPL1Mg
cnVubmluZyB0aGUgRFBESyBhcHBsaWNhdGlvbiwgbm90IGF1eGlsaWFyeSBoYXJkd2FyZSBvciBP
L1MgZmVhdHVyZXMuIFRoZSBFQUwgaXMgYWxyZWFkeSBibG9hdGVkIHdpdGggc3R1ZmYgdGhhdCBp
cyBub3QgYWJzb2x1dGVseSByZXF1aXJlZCB0byBydW4gc2ltcGxlIERQREsgYXBwbGljYXRpb25z
Lg0KDQpBcyBhbiBhZHZvY2F0ZSBmb3IgYSBzbGltbWVyIEVBTCwgaGF2aW5nIFBNVSBhcyBhIHNl
cGFyYXRlIGxpYnJhcnkgbWFrZXMgc2Vuc2UgdG8gbWUuDQoNCk5vdCBhbGwgaGFyZHdhcmUgYWNj
ZXNzIGlzIHByb3ZpZGVkIHRocm91Z2ggdGhlIEVBTC4NCkUuZy4sIGFjY2VzcyB0byBoYXJkd2Fy
ZSBwb3dlciBtYW5hZ2VtZW50IGNvbnRyb2xzIGlzIHByb3ZpZGVkIHRocm91Z2ggdGhlIFBvd2Vy
IGxpYnJhcnkvZHJpdmVyIGNvbWJvLg0KVGhlIFBNVSBmZWF0dXJlIGNvdWxkIGJlIGNvbnNpZGVy
ZWQgYSB0eXBlIG9mICJsaWJyYXJ5L2RyaXZlciIgY29tYm8sIGxpa2UgdGhlIFBvd2VyIGxpYnJh
cnkvZHJpdmVyIGNvbWJvOyBidXQgdGhhdCBtaWdodCBjb21lIHdpdGggdW5uZWNlc3NhcnkgY29t
cGxleGl0eSBhbmQgcGVyZm9ybWFuY2Ugb3ZlcmhlYWQgZnJvbSBhZGRpdGlvbmFsIGFic3RyYWN0
aW9ucyBhbmQgaW5kaXJlY3QgZnVuY3Rpb24gY2FsbGluZywgc28gSSBkb24ndCBsaWtlIHRoaXMg
YWx0ZXJuYXRpdmUuDQoNCi1Nb3J0ZW4NCg0K
