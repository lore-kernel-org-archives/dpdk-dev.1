Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E44CEBF92
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 09:16:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AECF40281;
	Tue, 18 Nov 2025 10:16:20 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 51C3F40150
 for <dev@dpdk.org>; Tue, 18 Nov 2025 10:16:19 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4E76A214DA;
 Tue, 18 Nov 2025 10:16:18 +0100 (CET)
Content-class: urn:content-classes:message
Subject: RE: bugs in rte_pktmbuf_copy
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Tue, 18 Nov 2025 10:16:17 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6556F@smartserver.smartshare.dk>
In-Reply-To: <20251117154320.1fe3c651@phoenix>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: bugs in rte_pktmbuf_copy
Thread-Index: AdxYG/ejYy5I8jwdSU2VTXLTY8XgxgAR+76Q
References: <98CBD80474FA8B44BF855DF32C47DC35F65567@smartserver.smartshare.dk>
 <20251117154320.1fe3c651@phoenix>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
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

PiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3BsdW1iZXIu
b3JnXQ0KPiBTZW50OiBUdWVzZGF5LCAxOCBOb3ZlbWJlciAyMDI1IDAwLjQzDQo+IA0KPiBPbiBN
b24sIDE3IE5vdiAyMDI1IDEyOjUxOjUxICswMTAwDQo+IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFy
dHNoYXJlc3lzdGVtcy5jb20+IHdyb3RlOg0KPiANCj4gPiBXaGlsZSB3b3JraW5nIG9uIGEgcnRl
X3BrdG1idWZfY29weV9idWxrKCkgZnVuY3Rpb24sIEkgbm90aWNlZCBhDQo+IGNvdXBsZSBvZiBi
dWdzIGluIHJ0ZV9wa3RtYnVmX2NvcHkoKToNCj4gPg0KPiA+IDEuIElmIHRoZSBjb3B5IGlzIGFs
bG9jYXRlZCBmcm9tIGEgbWVtcG9vbCB1c2luZyBwaW5uZWQgZXh0ZXJuYWwNCj4gYnVmZmVycywg
dGhlIGNvcHkncyBSVEVfTUJVRl9GX0VYVEVSTkFMIGZsYWcgaXMgbG9zdC4NCj4gPiBUaGlzIGlz
IHNpbXBsZSB0byBmaXg6DQo+ID4NCj4gPiAtCS8qIGNvcGllZCBtYnVmIGlzIG5vdCBpbmRpcmVj
dCBvciBleHRlcm5hbCAqLw0KPiA+IC0JbWMtPm9sX2ZsYWdzID0gbS0+b2xfZmxhZ3MgJg0KPiB+
KFJURV9NQlVGX0ZfSU5ESVJFQ1R8UlRFX01CVUZfRl9FWFRFUk5BTCk7DQo+ID4gKwkvKiBjb3B5
IGZsYWdzIGV4Y2VwdCBpbmRpcmVjdCBhbmQgZXh0ZXJuYWwgKi8NCj4gPiArCW1jLT5vbF9mbGFn
cyB8PSBtLT5vbF9mbGFncyAmDQo+IH4oUlRFX01CVUZfRl9JTkRJUkVDVHxSVEVfTUJVRl9GX0VY
VEVSTkFMKTsNCj4gDQo+IEdvb2QgY2F0Y2gsIGV4dGVybmFsIGZsYWcgbmVlZHMgdG8gYmUgcHJl
c2VydmVkLg0KPiANCj4gDQo+ID4gMi4gSWYgdGhlIHBhY2tldCBpcyBjb3BpZWQgd2l0aCBub24t
emVybyBvZmZzZXQsIG11Y2ggb2YgdGhlIG1ldGFkYXRhDQo+IGRvIG5vdCBhcHBseSB0byB0aGUg
Y29weSwgZS5nLiBtYW55IG9mIHRoZSBvZmZsb2FkIGZsYWdzIGFuZCB0aGUNCj4gcGFja2V0X3R5
cGUgZmllbGQuDQo+ID4gTWF5YmUgbWV0YWRhdGEgc2hvdWxkIGJlIHJlc2V0IHdoZW4gY29weWlu
ZyB3aXRoIGEgbm9uLXplcm8gb2Zmc2V0Pw0KPiA+IE9yIG1heWJlIHJ0ZV9wa3RtYnVmX2NvcHko
KSBzaG91bGQgYmUgY29uc2lkZXJlZCAicGF5bG9hZCBjb3B5Iiwgc28NCj4gdGhlIGNvcHkgc2hv
dWxkIGhhdmUgYWxsIG1ldGFkYXRhIHJlc2V0Pw0KPiANCj4gVGhlIHVzZSBjYXNlIGZvciB1c2lu
ZyBvZmZzZXQsIGlzIGZvciByZW1vdmluZyB0dW5uZWwgaGVhZGVycy4gSSBleHBlY3QNCj4gdGhh
dCB0aGUgY29kZSBkb2luZyBzbw0KPiB3b3VsZCBrbm93IHdoYXQgbWFuaXB1bGF0aW9uIG9mIG9m
ZmxvYWRzIHdhcyByZXF1aXJlZC4NCg0KSU1PLCBydGVfcGt0bWJ1Zl9jb3B5KCkgc2hvdWxkIGJl
aGF2ZSB0aGUgc2FtZSB3YXkgYXMgcnRlX3BrdG1idWZfY2xvbmUoKSwgd2hpY2ggZG9lc24ndCBj
b3B5IGFueSBtZXRhZGF0YSB0byB0aGUgY2xvbmUuDQpSZXVzaW5nIHlvdXIgYXJndW1lbnQ6IHRo
ZSBhcHBsaWNhdGlvbiB3b3VsZCBrbm93IHdoYXQgbWFuaXB1bGF0aW9uIG9mIG1ldGFkYXRhIHdh
cyByZXF1aXJlZC4NCldEWVQ/DQoNCkhhdmluZyBsb29rZWQgZGVlcGVyIGludG8gcnRlX3BrdG1i
dWZfY29weSgpIG5vdywgSSB0aGluayB0aGUgc3VwcG9ydCBmb3IgcGFydGlhbCBjb3B5IChvZmZz
ZXQgYW5kIGxlbmd0aCBwYXJhbWV0ZXJzKSBtaWdodCBoYXZlIGJlZW4gYSBtaXN0YWtlLCBmb3Ig
bXVsdGlwbGUgcmVhc29uczoNCi0gVGhlIHJ0ZV9wa3RtYnVmX2Nsb25lKCkgZG9lc24ndCBzdXBw
b3J0IHBhcnRpYWwgcGF5bG9hZCBjbG9uaW5nLg0KLSBUaGUgS2VybmVsJ3Mgc2tiX2NvcHkoKSBk
b2Vzbid0IHN1cHBvcnQgcGFydGlhbCBjb3B5LiBUaGVyZSBhcmUgb3RoZXIgZnVuY3Rpb25zIGZv
ciB0aGF0Lg0KLSBJZiB1c2VkIGZvciB0dW5uZWxzLCBpdCBvbmx5IHN1cHBvcnRzIGRlY2Fwc3Vs
YXRpb247IGl0IGxhY2tzIHN1cHBvcnQgZm9yIGVuY2Fwc3VsYXRpb24sIGkuZS4gYSBwYXJhbWV0
ZXIgZm9yIHNwZWNpZnlpbmcgZXh0cmEgaGVhZHJvb20gaW4gdGhlIGFsbG9jYXRlZCAiY29weSIg
cGFja2V0IG1idWYuDQpPbiB0aGUgcG9zaXRpdmUgc2lkZSwgcGFydGlhbCBjb3B5IGlzIHVzZWZ1
bCBmb3IgcGFja2V0IGNhcHR1cmluZyB3aXRoIGhlYWRlciBzdHJpcHBpbmcgYW5kIHNuYXAgbGVu
Z3RoLiBTbyBub3QgYWxsIGJhZC4gOi0pDQoNCkFueXdheSwgcmVtb3ZpbmcgdGhlIG9mZnNldCBh
bmQgbGVuZ3RoIHBhcmFtZXRlcnMgd291bGQgYnJlYWsgdGhlIEFQSSBhbmQgQUJJLCBzbyB0aGF0
J3MgdG9vIGxhdGUgbm93Lg0KDQo=
