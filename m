Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21161CD6E55
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 14:19:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37CF44025F;
	Mon,  1 Jun 2026 16:19:11 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5D8524025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 16:19:09 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1432C208EE;
 Mon,  1 Jun 2026 16:19:09 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v11] eal/x86: optimize memcpy of small sizes
Date: Mon, 1 Jun 2026 16:19:03 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658CD@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <JAYuDo5qT4OWJH9lfTRFKA@monjalon.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v11] eal/x86: optimize memcpy of small sizes
Thread-Index: Adzxy/A2+98Q2MV4QmKCWXcpPMW0ZQAAyh3w
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20260521185631.116046-1-mb@smartsharesystems.com>
 <20260521154214.1c171a74@phoenix.local> <JAYuDo5qT4OWJH9lfTRFKA@monjalon.net>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
 "Stephen Hemminger" <stephen@networkplumber.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>
Cc: <dev@dpdk.org>, "Konstantin Ananyev" <konstantin.v.ananyev@yandex.ru>,
 "Vipin Varghese" <vipin.varghese@amd.com>,
 "Liangxing Wang" <wangliangxing@hygon.cn>,
 "Thiyagarajan P" <Thiyagarajan.P@amd.com>,
 "Bala Murali Krishna" <Bala.MuraliKrishna@amd.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>
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
ZW50OiBNb25kYXksIDEgSnVuZSAyMDI2IDE1LjM4DQo+IA0KPiAyMi8wNS8yMDI2IDAwOjQyLCBT
dGVwaGVuIEhlbW1pbmdlcjoNCj4gPiBPbiBUaHUsIDIxIE1heSAyMDI2IDE4OjU2OjMxICswMDAw
DQo+ID4gTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPiA+IFRoZSBpbXBsZW1lbnRhdGlvbiBmb3IgY29weWluZyB1cCB0byA2NCBieXRlcyBk
b2VzIG5vdCBkZXBlbmQgb24NCj4gYWRkcmVzcw0KPiA+ID4gYWxpZ25tZW50IHdpdGggdGhlIHNp
emUgb2YgdGhlIENQVSdzIHZlY3RvciByZWdpc3RlcnMuIE5vbmV0aGVsZXNzLA0KPiB0aGUNCj4g
PiA+IGV4YWN0IHNhbWUgY29kZSBmb3IgY29weWluZyB1cCB0byA2NCBieXRlcyB3YXMgcHJlc2Vu
dCBpbiBib3RoIHRoZQ0KPiBhbGlnbmVkDQo+ID4gPiBjb3B5IGZ1bmN0aW9uIGFuZCBhbGwgdGhl
IENQVSB2ZWN0b3IgcmVnaXN0ZXIgc2l6ZSBzcGVjaWZpYw0KPiB2YXJpYW50cyBvZg0KPiA+ID4g
dGhlIHVuYWxpZ25lZCBjb3B5IGZ1bmN0aW9ucy4NCj4gPiA+IFdpdGggdGhpcyBwYXRjaCwgdGhl
IGltcGxlbWVudGF0aW9uIGZvciBjb3B5aW5nIHVwIHRvIDY0IGJ5dGVzIHdhcw0KPiA+ID4gY29u
c29saWRhdGVkIGludG8gb25lIGluc3RhbmNlLCBsb2NhdGVkIGluIHRoZSBjb21tb24gY29weQ0K
PiBmdW5jdGlvbiwNCj4gPiA+IGJlZm9yZSBjaGVja2luZyBhbGlnbm1lbnQgcmVxdWlyZW1lbnRz
Lg0KPiA+ID4gVGhpcyBwcm92aWRlcyB0aHJlZSBiZW5lZml0czoNCj4gPiA+IDEuIE5vIGNvcHkt
cGFzdGUgaW4gdGhlIHNvdXJjZSBjb2RlLg0KPiA+ID4gMi4gQSBwZXJmb3JtYW5jZSBnYWluIGZv
ciBjb3B5aW5nIHVwIHRvIDY0IGJ5dGVzLCBiZWNhdXNlIHRoZQ0KPiA+ID4gYWRkcmVzcyBhbGln
bm1lbnQgY2hlY2sgaXMgYXZvaWRlZCBpbiB0aGlzIGNhc2UuDQo+ID4gPiAzLiBSZWR1Y2VkIGlu
c3RydWN0aW9uIG1lbW9yeSBmb290cHJpbnQsIGJlY2F1c2UgdGhlIGNvbXBpbGVyIG9ubHkNCj4g
PiA+IGdlbmVyYXRlcyBvbmUgaW5zdGFuY2Ugb2YgdGhlIGZ1bmN0aW9uIGZvciBjb3B5aW5nIHVw
IHRvIDY0IGJ5dGVzLA0KPiBpbnN0ZWFkDQo+ID4gPiBvZiB0d28gaW5zdGFuY2VzIChvbmUgaW4g
dGhlIHVuYWxpZ25lZCBjb3B5IGZ1bmN0aW9uLCBhbmQgb25lIGluDQo+IHRoZQ0KPiA+ID4gYWxp
Z25lZCBjb3B5IGZ1bmN0aW9uKS4NCj4gPiA+DQo+ID4gPiBGdXJ0aGVybW9yZSwgX19ydGVfcmVz
dHJpY3Qgd2FzIGFkZGVkIHRvIHNvdXJjZSBhbmQgZGVzdGluYXRpb24NCj4gYWRkcmVzc2VzLg0K
PiA+ID4NCj4gPiA+IEFsc28sIHRoZSBtaXNzaW5nIGltcGxlbWVudGF0aW9uIG9mIHJ0ZV9tb3Y0
OCgpIHdhcyBhZGRlZC4NCj4gPiA+DQo+ID4gPiBVbnRpbCByZWNlbnRseSwgc29tZSBkcml2ZXJz
IHJlcXVpcmVkIGRpc2FibGluZyBzdHJpbmdvcC1vdmVyZmxvdw0KPiB3YXJuaW5ncw0KPiA+ID4g
d2hlbiB1c2luZyBydGVfbWVtY3B5KCkuDQo+ID4gPiBGb3Igc29tZSBzdHJhbmdlIHJlYXNvbiwg
dGhlc2Ugd2FybmluZ3Mgd2VyZSBkaXNhYmxlZCBpbiB0aGUNCj4gcnRlX21lbWNweQ0KPiA+ID4g
aGVhZGVyIGZpbGUsIGluc3RlYWQgb2YgaW4gdGhlIHByb2JsZW1hdGljIGRyaXZlcnMuDQo+ID4g
PiBXaXRoIHNlcmllcy0zODE3NCAoInJlbW92ZSB1c2Ugb2YgcnRlX21lbWNweSBmcm9tIG5ldC9p
bnRlbCIpLCB0aGUNCj4gPiA+IHByb2JsZW1hdGljIGRyaXZlcnMgd2VyZSB1cGRhdGVkIHRvIHVz
ZSBtZW1jcHkoKSBpbnN0ZWFkIG9mDQo+IHJ0ZV9tZW1jcHkoKSwNCj4gPiA+IHNvIGRpc2FibGlu
ZyB0aGVzZSB3YXJuaW5ncyBpcyBubyBsb25nZXIgcmVxdWlyZWQsIGFuZCB3YXMgcmVtb3ZlZC4N
Cj4gPiA+DQo+ID4gPiBSZWdhcmRpbmcgcGVyZm9ybWFuY2UuLi4NCj4gPiA+IFRoZSBtZW1jcHkg
cGVyZm9ybWFuY2UgdGVzdCAoY2FjaGUtdG8tY2FjaGUgY29weSkgc2hvd3M6DQo+ID4gPiBDb3B5
aW5nIHVwIHRvIDE1IGJ5dGVzIHRha2VzIGNhLiA0LjUgY3ljbGVzLCB2ZXJzdXMgY2EuIDYuNSBj
eWNsZXMNCj4gYmVmb3JlLg0KPiA+ID4gQ29weWluZyA4IGJ5dGVzIHRha2VzIDQgY3ljbGVzLCB2
ZXJzdXMgNyBjeWNsZXMgYmVmb3JlLg0KPiA+ID4gQ29weWluZyAxNiBieXRlcyB0YWtlcyAyIGN5
Y2xlcywgdmVyc3VzIDQgY3ljbGVzIGJlZm9yZS4NCj4gPiA+IENvcHlpbmcgNjQgYnl0ZXMgdGFr
ZXMgNCBjeWNsZXMsIHZlcnN1cyA3IGN5Y2xlcyBiZWZvcmUuDQo+ID4gPg0KPiA+ID4gRGVwZW5k
cy1vbjogc2VyaWVzLTM4MTc0ICgicmVtb3ZlIHVzZSBvZiBydGVfbWVtY3B5IGZyb20NCj4gbmV0
L2ludGVsIikNCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8bWJA
c21hcnRzaGFyZXN5c3RlbXMuY29tPg0KPiA+ID4gQWNrZWQtYnk6IEJydWNlIFJpY2hhcmRzb24g
PGJydWNlLnJpY2hhcmRzb25AaW50ZWwuY29tPg0KPiA+ID4gQWNrZWQtYnk6IEtvbnN0YW50aW4g
QW5hbnlldiA8a29uc3RhbnRpbi5hbmFueWV2QGh1YXdlaS5jb20+DQo+ID4NCj4gPiBIZXJlIGlz
IHRoZSBmdWxsIHdvcmR5IGFsbCBwcm92aWRlcnMgcmV2aWV3cy4NCj4gWy4uLl0NCj4gPiBTdW1t
YXJ5IGFjcm9zcyA0IHByb3ZpZGVyKHMpOiBjbGVhbj0wIHdhcm5pbmdzPTEgZXJyb3JzPTMgZmFp
bGVkPTANCj4gDQo+IFdoYXQgaXMgdGhlIGZvbGxvd3VwPw0KDQpBSSB3YW50cyBtZSB0byBmaXgg
ZXhpc3RpbmcgY29kZS4NCkkgaGFkIGNob3NlbiB0byBzdGljayB0byB0aGUgZmlsZSdzIGV4aXN0
aW5nIGNvZGluZyBzdHlsZSBldGMuLCBpbmNsdWRpbmcgc29tZSB1bm5lY2Vzc2FyeSB0eXBlIGNh
c3RzLg0KU28gQUkgYWxzbyBjb21wbGFpbnMgYWJvdXQgbXkgY29kZSBkb2luZyB0aGluZ3MgdGhl
IHNhbWUgd2F5IGV4aXN0aW5nIGNvZGUgaW4gdGhlIGZpbGUgZG9lcyBpdC4NCkZpeGluZyBleGlz
dGluZyBjb2RlIGlzIG91dCBvZiBzY29wZSBmb3IgdGhpcyBwYXRjaC4gQW5kIHVzaW5nIGEgZGlm
ZmVyZW50IHN0eWxlIGZvciBteSBjaGFuZ2VzIHdvdWxkIGJlIGNvbmZ1c2luZy4NCg0KVGhlIHBh
dGNoIGRlc2NyaXB0aW9uIG1lbnRpb25zIHRoYXQgc3RyaW5nb3Atb3ZlcmZsb3cgd2FybmluZ3Mg
YXJlIG5vIGxvbmdlciBkaXNhYmxlZCBmb3IgcnRlX21lbXBjeSgpLg0KQUkgd2FudHMgdGhpcyB0
byBnbyBpbnRvIHRoZSByZWxlYXNlIG5vdGVzIChhbHRob3VnaCBpdCBpcyB4ODYgYXJjaGl0ZWN0
dXJlIG9ubHkpLg0KQnV0IElNTywgdGhpcyBpcyBmYXIgYmVsb3cgdGhlIHRocmVzaG9sZCBmb3Ig
d2hhdCBzaG91bGQgZ28gaW50byB0aGUgcmVsZWFzZSBub3Rlcy4NCg0KPiBEbyB3ZSB0YXJnZXQg
RFBESyAyNi4wNz8NCg0KSU1PLCB5ZXMsIHRoaXMgdjExIHBhdGNoIGlzIGdvb2QuDQoNCg==
