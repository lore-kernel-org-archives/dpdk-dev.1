Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2090BCCD184
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 18:45:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC68A402B9;
	Sun, 19 Oct 2025 20:45:30 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8724B400D5
 for <dev@dpdk.org>; Sun, 19 Oct 2025 20:45:29 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 523BB202CC;
 Sun, 19 Oct 2025 20:45:28 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v8 3/3] mbuf: optimize reset of reinitialized mbufs
Date: Sun, 19 Oct 2025 20:45:26 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654DD@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <2602540.zToM8qfIzz@thomas>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v8 3/3] mbuf: optimize reset of reinitialized mbufs
Thread-Index: AdxBGbWow+ZRBez0Qoil9ep/fLNgVQADlxTA
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <aOftoMl0edarmSGB@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F654B7@smartserver.smartshare.dk>
 <2602540.zToM8qfIzz@thomas>
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
ZW50OiBTdW5kYXksIDE5IE9jdG9iZXIgMjAyNSAxOC41OQ0KPiANCj4gMDkvMTAvMjAyNSAxOToz
NSwgTW9ydGVuIEJyw7hydXA6DQo+ID4gPiBGcm9tOiBCcnVjZSBSaWNoYXJkc29uIFttYWlsdG86
YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb21dDQo+ID4gPiA+ICsJCW0tPnBrdF9sZW4gPSAwOw0K
PiA+ID4gPiArCQltLT50eF9vZmZsb2FkID0gMDsNCj4gPiA+ID4gKwkJbS0+dmxhbl90Y2kgPSAw
Ow0KPiA+ID4gPiArCQltLT52bGFuX3RjaV9vdXRlciA9IDA7DQo+ID4gPiA+ICsJCW0tPnBvcnQg
PSBSVEVfTUJVRl9QT1JUX0lOVkFMSUQ7DQo+ID4gPg0KPiA+ID4gSGF2ZSB5b3UgY29uc2lkZXJl
ZCBkb2luZyBhbGwgaW5pdGlhbGl6YXRpb24gdXNpbmcgNjQtYml0IHN0b3Jlcz8NCj4gSXQncw0K
PiA+ID4gZ2VuZXJhbGx5IGNoZWFwZXIgdG8gZG8gYSBzaW5nbGUgNjQtYml0IHN0b3JlIHRoYW4g
ZS5nLiBzZXQgb2YgMTYtDQo+IGJpdA0KPiA+ID4gb25lcy4NCj4gPg0KPiA+IFRoZSBjb2RlIGlz
IGJhc2ljYWxseSBjb3B5LXBhc3RlIGZyb20gcnRlX3BrdG1idWZfcmVzZXQoKS4NCj4gPiBJIGtl
cHQgaXQgdGhlIHNhbWUgd2F5IGZvciByZWFkYWJpbGl0eS4NCj4gPg0KPiA+ID4gVGhpcyBhbHNv
IG1lYW5zIHRoYXQgd2UgY291bGQgcmVtb3ZlIHRoZSByZXN0cmljdGlvbiBvbiBoYXZpbmcNCj4g
cmVmY250DQo+ID4gPiBhbmQNCj4gPiA+IG5iX3NlZ3MgYWxyZWFkeSBzZXQuIEFzIGluIFBNRHMs
IGEgc2luZ2xlIHN0b3JlIGNhbiBpbml0IGRhdGFfb2ZmLA0KPiA+ID4gcmVmX2NudCwNCj4gPiA+
IG5iX3NlZ3MgYW5kIHBvcnQuDQo+ID4NCj4gPiBZZXMsIEkgaGF2ZSBnaXZlbiB0aGUgY29uY2Vw
dCBhIGxvdCBvZiB0aG91Z2h0IGFscmVhZHkuDQo+ID4gSWYgd2UgZGlkbid0IHJlcXVpcmUgbWJ1
ZnMgcmVzaWRpbmcgaW4gdGhlIG1lbXBvb2wgdG8gaGF2ZSBhbnkgZmllbGRzDQo+IGluaXRpYWxp
emVkLCBzcGVjaWZpY2FsbHkgIm5leHQiIGFuZCAibmJfc2VncyIsIGl0IHdvdWxkIGltcHJvdmUN
Cj4gcGVyZm9ybWFuY2UgZm9yIGRyaXZlcnMgZnJlZWluZyBtYnVmcyBiYWNrIHRvIHRoZSBtZW1w
b29sLCBiZWNhdXNlDQo+IHdyaXRpbmcgdG8gdGhlIG1idWZzIHdvdWxkIG5vIGxvbmdlciBiZSBy
ZXF1aXJlZCBhdCB0aGF0IHBvaW50OyB0aGUNCj4gbWJ1ZnMgY291bGQgc2ltcGx5IGJlIGZyZWVk
IGJhY2sgdG8gdGhlIG1lbXBvb2wuIEluc3RlYWQsIHdlIHdvdWxkDQo+IHJlcXVpcmUgdGhlIGRy
aXZlciB0byBpbml0aWFsaXplIHRoZXNlIGZpZWxkcyAtIHdoaWNoIGl0IHByb2JhYmx5IGRvZXMN
Cj4gb24gUlggYW55d2F5LCBpZiBpdCBzdXBwb3J0cyBzZWdtZW50ZWQgcGFja2V0cy4NCj4gPiBC
dXQgSSBjb25zaWRlciB0aGlzIGNvbmNlcHQgYSBtYWpvciBBUEkgY2hhbmdlLCBhbHNvIGFmZmVj
dGluZw0KPiBhcHBsaWNhdGlvbnMgYXNzdW1pbmcgdGhhdCB0aGVzZSBmaWVsZHMgYXJlIGluaXRp
YWxpemVkIHdoZW4gYWxsb2NhdGluZw0KPiByYXcgbWJ1ZnMgZnJvbSB0aGUgbWVtcG9vbC4gU28g
SSBoYXZlbid0IHB1cnN1ZWQgaXQuDQo+ID4NCj4gPiA+DQo+ID4gPiBTaW1pbGFybHkgZm9yIHBh
Y2tldF90eXBlIGFuZCBwa3RfbGVuLCBhbmQgZGF0YV9sZW4vdmxhbl90Y2kgYW5kDQo+IHJzcw0K
PiA+ID4gZmllbGRzDQo+ID4gPiBldGMuIEZvciBtYXggcGVyZm9ybWFuY2UsIHRoZSB3aG9sZSBv
ZiB0aGUgbWJ1ZiBjbGVhcmVkIGhlcmUgY2FuIGJlDQo+ID4gPiBkb25lIGluDQo+ID4gPiA0MCBi
eXRlcywgb3IgNSA2NC1iaXQgc3RvcmVzLiBJZiB3ZSBkbyB0aGUgc3RvcmVzIGluIG9yZGVyLA0K
PiBwb3NzaWJseQ0KPiA+ID4gdGhlDQo+ID4gPiBjb21waWxlciBjYW4gZXZlbiBvcHBvcnR1bmlz
dGljYWxseSBjb2FsZXNjZSBtb3JlIHN0b3Jlcywgc28gd2UNCj4gY291bGQNCj4gPiA+IGV2ZW4N
Cj4gPiA+IGVuZCB1cCBnZXR0aW5nIDEyOC1iaXQgb3IgbGFyZ2VyIHN0b3JlcyBkZXBlbmRpbmcg
b24gdGhlIElTQQ0KPiBjb21waWxlZA0KPiA+ID4gZm9yLg0KPiA+ID4gW01heWJlIHRoZSBjb21w
aWxlciB3aWxsIGRvIHRoaXMgZXZlbiBpZiB0aGV5IGFyZSBub3QgaW4gb3JkZXIsIGJ1dA0KPiBJ
J2QNCj4gPiA+IGxpa2UgdG8gbWF4aW1pemUgbXkgY2hhbmNlcyBoZXJlISA6LSldDQo+IA0KPiBN
b3J0ZW4sIHlvdSBkaWRuJ3QgcmVwbHkgdG8gdGhpcy4NCj4gQ2FuIHdlIG9wdGltaXplIG1vcmUg
d2l0aCBiaWcgc3RvcmVzPw0KPiANCg0KSSBkaWQgcmVwbHk6DQpodHRwczovL2luYm94LmRwZGsu
b3JnL2Rldi85OENCRDgwNDc0RkE4QjQ0QkY4NTVERjMyQzQ3REMzNUY2NTRCQkBzbWFydHNlcnZl
ci5zbWFydHNoYXJlLmRrLw0KDQpFc3NlbnRpYWxseSwgaXQncyBhIGRpZmZlcmVudCB0eXBlIG9m
IG9wdGltaXphdGlvbiwgd2hpY2ggc2hvdWxkIGFsc28gYmUgYXBwbGllZCB0byBydGVfcGt0bWJ1
Zl9yZXNldCgpLg0KSSBoYXZlIHBvc3Rwb25lZCBzdWNoIG9wdGltaXphdGlvbiBmb3IgbGF0ZXIu
IERvbid0IGhhdmUgdGltZSB0byBkbyBpdCBwcm9wZXJseSBub3cuDQoNCi1Nb3J0ZW4NCg0K
