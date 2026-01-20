Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D78D2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 12:45:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63EA540268;
	Tue, 20 Jan 2026 13:45:24 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9AC854013F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 13:45:22 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 89DD820D99;
 Tue, 20 Jan 2026 13:45:21 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v15 0/2] net: optimize __rte_raw_cksum
Date: Tue, 20 Jan 2026 13:45:18 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65678@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260117140848.49104c2b@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v15 0/2] net: optimize __rte_raw_cksum
Thread-Index: AdyH/eCwSGj3HMMFRiuTDUI5p30SWACDGVFQ
References: <20260112120411.27314-1-scott.k.mitch1@gmail.com><20260117212114.10466-1-scott.k.mitch1@gmail.com>
 <20260117140848.49104c2b@phoenix.local>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: <scott.k.mitch1@gmail.com>
Cc: <dev@dpdk.org>,
	"Stephen Hemminger" <stephen@networkplumber.org>
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

PiA+IEZyb206IFNjb3R0IE1pdGNoZWxsIDxzY290dC5rLm1pdGNoMUBnbWFpbC5jb20+DQo+ID4N
Cj4gPiBUaGlzIHNlcmllcyBvcHRpbWl6ZXMgX19ydGVfcmF3X2Nrc3VtIGJ5IHJlcGxhY2luZyBt
ZW1jcHkgd2l0aCBkaXJlY3QNCj4gPiBwb2ludGVyIGFjY2VzcywgZW5hYmxpbmcgY29tcGlsZXIg
dmVjdG9yaXphdGlvbiBvbiBib3RoIEdDQyBhbmQNCj4gQ2xhbmcuDQo+ID4NCj4gPiBQYXRjaCAx
IGFkZHMgX19ydGVfbWF5X2FsaWFzIHRvIHVuYWxpZ25lZCB0eXBlZGVmcyB0byBwcmV2ZW50IGEg
R0NDDQo+ID4gc3RyaWN0LWFsaWFzaW5nIGJ1ZyB3aGVyZSBzdHJ1Y3QgaW5pdGlhbGl6YXRpb24g
aXMgaW5jb3JyZWN0bHkNCj4gZWxpZGVkLg0KPiA+DQo+ID4gUGF0Y2ggMiB1c2VzIHRoZSBpbXBy
b3ZlZCB1bmFsaWduZWRfdWludDE2X3QgdHlwZSBpbiBfX3J0ZV9yYXdfY2tzdW0NCj4gPiB0byBl
bmFibGUgY29tcGlsZXIgb3B0aW1pemF0aW9ucyB3aGlsZSBtYWludGFpbmluZyBjb3JyZWN0bmVz
cyBhY3Jvc3MNCj4gPiBhbGwgYXJjaGl0ZWN0dXJlcyAoaW5jbHVkaW5nIHN0cmljdC1hbGlnbm1l
bnQgcGxhdGZvcm1zKS4NCj4gPg0KPiA+IFBlcmZvcm1hbmNlIHJlc3VsdHMgc2hvdyBzaWduaWZp
Y2FudCBpbXByb3ZlbWVudHMgKDQwJSBmb3Igc21hbGwNCj4gYnVmZmVycywNCj4gPiB1cCB0byA4
eCBmb3IgbGFyZ2VyIGJ1ZmZlcnMpIG9uIEludGVsIFhlb24gd2l0aCBDbGFuZyAxOC4xLg0KPiA+
DQo+ID4gQ2hhbmdlcyBpbiB2MTU6DQo+ID4gLSBVc2UgTk9IVUdFX09LIGFuZCBBU0FOX09LIGNv
bnN0YW50cyBpbiBSRUdJU1RFUl9GQVNUX1RFU1QNCj4gPg0KPiA+IENoYW5nZXMgaW4gdjE0Og0K
PiA+IC0gU3BsaXQgaW50byB0d28gcGF0Y2hlczogRUFMIHR5cGVkZWYgZml4IGFuZCBjaGVja3N1
bSBvcHRpbWl6YXRpb24NCj4gPiAtIFVzZSB1bmFsaWduZWRfdWludDE2X3QgZGlyZWN0bHkgaW5z
dGVhZCBvZiB3cmFwcGVyIHN0cnVjdA0KPiA+IC0gQWRkZWQgX19ydGVfbWF5X2FsaWFzIHRvIHVu
YWxpZ25lZCB0eXBlZGVmcyB0byBwcmV2ZW50IEdDQyBidWcNCj4gPg0KPiA+IFNjb3R0IE1pdGNo
ZWxsICgyKToNCj4gPiAgIGVhbDogYWRkIF9fcnRlX21heV9hbGlhcyB0byB1bmFsaWduZWQgdHlw
ZWRlZnMNCj4gPiAgIG5ldDogX19ydGVfcmF3X2Nrc3VtIHBvaW50ZXJzIGVuYWJsZSBjb21waWxl
ciBvcHRpbWl6YXRpb25zDQo+ID4NCj4gPiAgYXBwL3Rlc3QvbWVzb24uYnVpbGQgICAgICAgICB8
ICAgMSArDQo+ID4gIGFwcC90ZXN0L3Rlc3RfY2tzdW1fZnV6ei5jICAgfCAyNDANCj4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgYXBwL3Rlc3QvdGVzdF9ja3N1bV9w
ZXJmLmMgICB8ICAgMiArLQ0KPiA+ICBsaWIvZWFsL2luY2x1ZGUvcnRlX2NvbW1vbi5oIHwgIDM0
ICsrLS0tDQo+ID4gIGxpYi9uZXQvcnRlX2Nrc3VtLmggICAgICAgICAgfCAgMTQgKy0NCj4gPiAg
NSBmaWxlcyBjaGFuZ2VkLCAyNjYgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pDQo+ID4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBhcHAvdGVzdC90ZXN0X2Nrc3VtX2Z1enouYw0KPiA+DQo+ID4g
LS0NCj4gPiAyLjM5LjUgKEFwcGxlIEdpdC0xNTQpDQo+ID4NCj4gDQo+IExvb2tzIGdvb2Qgbm93
Lg0KPiBBY2tlZC1ieTogU3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIu
b3JnPg0KDQpMR1RNIHRvby4NCkFja2VkLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFy
ZXN5c3RlbXMuY29tPg0KDQpUaGFuayB5b3UgZm9yIHRoZSBlZmZvcnQgYW5kIHByb21wdCByZWFj
dGlvbiB0byBmZWVkYmFjaywgU2NvdHQuDQpJdCBoYXMgYmVlbiBhIHBsZWFzdXJlIHJldmlld2lu
ZyB0aGlzIHNlcmllcyENCg0K
