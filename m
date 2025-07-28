Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C92C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 14:51:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E274240291;
	Mon, 28 Jul 2025 16:51:33 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8EDB54025A;
 Mon, 28 Jul 2025 16:51:32 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5D0B02221E;
 Mon, 28 Jul 2025 16:51:31 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 28 Jul 2025 16:51:30 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FDCD@smartserver.smartshare.dk>
In-Reply-To: <CABD7UXOqkROef0_BreD1GHC_R+7EwxRTL8LF-fXQJBECp7J9SA@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
Thread-Index: Adv35niI9T2FPUzRQp+kfTJXL1mX8wH52otQ
References: <20250714133014.44597-1-bruce.richardson@intel.com>
 <CABD7UXPVg56UwvmtOsssBwV2HzmgV4ZJZCb=FrnVQKkggtD2+Q@mail.gmail.com>
 <aHd6x3kT053EvX2g@bricha3-mobl1.ger.corp.intel.com>
 <CABD7UXPtChUUOdz3gfiyKqY4Rn2_0F8Ck4O6ypq9woATD7hfCw@mail.gmail.com>
 <aHgBs5DGU48mTnwz@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDB8@smartserver.smartshare.dk>
 <CABD7UXPccao=o1O=SessoAdEKUyA-dXP6HG5mnkpFSVNL_3dxw@mail.gmail.com>
 <aHoEUmesrg9Y8qtM@bricha3-mobl1.ger.corp.intel.com>
 <CABD7UXOqkROef0_BreD1GHC_R+7EwxRTL8LF-fXQJBECp7J9SA@mail.gmail.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, "Dengdui Huang" <huangdengdui@huawei.com>,
 "Vladimir Medvedkin" <medvedkinv@gmail.com>, <techboard@dpdk.org>,
 "Patrick Robb" <probb@iol.unh.edu>,
 "fengchengwen" <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <jasvinder.singh@intel.com>, <thomas@monjalon.net>,
 <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <liuyonglong@huawei.com>, "Dean Marx" <dmarx@iol.unh.edu>
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

PiBGcm9tOiBEZWFuIE1hcnggW21haWx0bzpkbWFyeEBpb2wudW5oLmVkdV0NCj4gU2VudDogRnJp
ZGF5LCAxOCBKdWx5IDIwMjUgMTUuMTgNCj4gDQo+IE9uIEZyaSwgSnVsIDE4LCAyMDI1IGF0IDQ6
MjPigK9BTSBCcnVjZSBSaWNoYXJkc29uDQo+IDxicnVjZS5yaWNoYXJkc29uQGludGVsLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBPbiBUaHUsIEp1bCAxNywgMjAyNSBhdCAwNTowMzoxM1BNIC0wNDAw
LCBEZWFuIE1hcnggd3JvdGU6DQo+ID4gPiBJJ3ZlIGNyZWF0ZWQgYSB2MSBvZiBhIFFpblEgdGVz
dCBzdWl0ZSBhcm91bmQgdGhlIHNldCBvZiB0ZXN0IGNhc2VzDQo+ID4gPiBkaXNjdXNzZWQgZWFy
bGllciAod2hpY2ggaXMgbm90IHNldCBpbiBzdG9uZSwgYW5kIEkgZXhwZWN0IGl0IHRvDQo+ID4g
PiBjaGFuZ2Ugc2lnbmlmaWNhbnRseSBhY3Jvc3MgbWFueSBmdXR1cmUgdmVyc2lvbnMuKSBUaGUg
UEFTUy9GQUlMDQo+ID4gPiB2YWx1ZXMgY2FuIGJlIG1vc3RseSBkaXNyZWdhcmRlZCBpbiB0aGUg
Y29udGV4dCBvZiB0aGlzIGNvbnZlcnNhdGlvbiwNCj4gPiA+IGJ1dCBJJ3ZlIGFkZGVkIGxvZ2dp
bmcgdG8gZXhwbGFpbiB3aGljaCBwYWNrZXRzIGFyZSBzZW50LCBhbmQgd2hhdA0KPiA+ID4gaGFw
cGVuZWQgdXBvbiByZWNlcHRpb24sIHdoaWNoIEkgaG9wZSB3aWxsIGJlIG1vcmUgaW5mb3JtYXRp
dmUuIEFmdGVyDQo+ID4gPiBydW5uaW5nIG9uIG1seDUvaTQwZSBkcml2ZXJzLCBJIGdvdCB0aGUg
Zm9sbG93aW5nIHJlc3VsdHM6DQo+ID4gPg0KPiA+ID4gdGVzdF92bGFuX3N0cmlwOiBRaW5RIHN0
cmlwIE9GRiBhbmQgVkxBTiBzdHJpcCBPTg0KPiA+ID4gdGVzdF9xaW5xX3N0cmlwOiBRaW5RIHN0
cmlwIE9OIGFuZCBWTEFOIHN0cmlwIE9ODQo+ID4gPg0KPiA+ID4gaTQwZToNCj4gPiA+ICAgICB0
ZXN0X3FpbnFfc3RyaXAgKHNlbnQgcGFja2V0OiBTaW5nbGUgVkxBTik6IEZBSUwNCj4gPiA+ICAg
ICAgIHJlYXNvbjogVkxBTiB0YWdzIGZvdW5kIGluIHBhY2tldCB3aGVuIHNob3VsZCBoYXZlIGJl
ZW4NCj4gPiA+IHN0cmlwcGVkOiBFdGhlciAvIERvdDFRIC8gODAyLjFxICgweDFjKSB2bGFuIDEy
ODAgLyBMTEMgLyBSYXcgLw0KPiA+ID4gUGFkZGluZw0KPiA+ID4gICAgIHRlc3RfcWlucV9zdHJp
cCAoc2VudCBwYWNrZXQ6IFN0YWNrZWQgVkxBTik6IEZBSUwNCj4gPiA+ICAgICAgIHJlYXNvbjog
RXhwZWN0ZWQgb25lIFZMQU4gdGFnIGJ1dCBmb3VuZCAyOiBFdGhlciAvIERvdDFRIC8gRG90MVEN
Cj4gPiA+IC8gODAyLjFxICgweDFjKSB2bGFuIDEyODAgLyBMTEMgLyBSYXcgLyBQYWRkaW5nDQo+
ID4gPiAgICAgdGVzdF9xaW5xX3N0cmlwIChzZW50IHBhY2tldDogU2luZ2xlIFMtVkxBTik6IEZB
SUwNCj4gPiA+ICAgICAgIHJlYXNvbjogVkxBTiB0YWdzIGZvdW5kIGluIHBhY2tldCB3aGVuIHNo
b3VsZCBoYXZlIGJlZW4NCj4gPiA+IHN0cmlwcGVkOiBFdGhlciAvIERvdDFRIC8gODAyLjFxICg/
PykgdmxhbiA/PyAvIExMQyAvIFJhdyAvIFBhZGRpbmcNCj4gPiA+ICAgICB0ZXN0X3FpbnFfc3Ry
aXAgKHNlbnQgcGFja2V0OiBRaW5RKTogRkFJTA0KPiA+ID4gICAgICAgcmVhc29uOiBWTEFOIHRh
Z3MgZm91bmQgaW4gcGFja2V0IHdoZW4gc2hvdWxkIGhhdmUgYmVlbg0KPiA+ID4gc3RyaXBwZWQ6
IEV0aGVyIC8gRG90MVEgLyBEb3QxQUQgLyA4MDIuMXEgKDB4MWMpIHZsYW4gMTI4MCAvIExMQyAv
IFJhdw0KPiA+ID4gLyBQYWRkaW5nDQo+ID4gPiAgICAgdGVzdF92bGFuX3N0cmlwIChzZW50IHBh
Y2tldDogU2luZ2xlIFZMQU4pOiBQQVNTDQo+ID4gPiAgICAgICByZWFzb246IFZMQU4gdGFnIHN0
cmlwcGVkIGZyb20gcGFja2V0DQo+ID4gPiAgICAgdGVzdF92bGFuX3N0cmlwIChzZW50IHBhY2tl
dDogU3RhY2tlZCBWTEFOKTogUEFTUw0KPiA+ID4gICAgICAgcmVhc29uOiBSZWNlaXZlZCBwYWNr
ZXQgaGFkIG91dGVyIFZMQU4gc3RyaXBwZWQsIHdpdGggaW5uZXIgVkxBTg0KPiBpbnRhY3QNCj4g
PiA+ICAgICB0ZXN0X3ZsYW5fc3RyaXAgKHNlbnQgcGFja2V0OiBTaW5nbGUgUy1WTEFOKTogUEFT
Uw0KPiA+ID4gICAgICAgcmVhc29uOiBTLVZMQU4gdGFnIHN0cmlwcGVkIGZyb20gcGFja2V0DQo+
ID4gPiAgICAgdGVzdF92bGFuX3N0cmlwIChzZW50IHBhY2tldDogUWluUSk6IEZBSUwNCj4gPiA+
ICAgICAgIHJlYXNvbjogTmVpdGhlciB0YWcgc3RyaXBwZWQNCj4gPiA+DQo+ID4NCj4gPiBDYW4g
eW91IGNvbmZpcm0gZXhhY3RseSB3aGF0IGlzIGJlaW5nIHNlbnQgaW4gZWFjaCBjYXNlIGZvciB0
aGUgZXRoZXJ0eXBlDQo+ID4gb2YgdGhlIFZMQU4gdGFnPyBXaGVuIHlvdSBzYXkgc2luZ2xlIGFu
ZCBzdGFja2VkIFZMQU5zLCB0aGF0IGlzIFZMQU5zIHdpdGgNCj4gPiAweDgxMDAgdHlwZSwgY29y
cmVjdD8gSXMgc2luZ2xlIFMtVkxBTiBhIHRhZyB3aXRoIGV0aGVydHlwZSAweDg4YTgsIGFuZA0K
PiA+IFFpblEgcGFja2V0IGEgcGFja2V0IHdpdGggb25lIDB4ODhhOCBhbmQgb25lIDB4ODEwMD8g
Tm8gb3RoZXIgdHlwZSBvcHRpb25zLA0KPiA+IGUuZy4gMHg5MTAwIHdlcmUgY2hlY2tlZCwgcmln
aHQ/DQo+ID4NCj4gPiAvQnJ1Y2UNCj4gDQo+IFRoYXQncyBjb3JyZWN0LCBzaW5nbGUgVkxBTiBp
cyBvbmUgMHg4MTAwIHRhZywgc3RhY2tlZCBpcyB0d28sIHNpbmdsZQ0KPiBTLVZMQU4gaXMgb25l
IDB4ODhhOCwgYW5kIFFpblEgaXMgMHg4OGE4IGFuZCAweDgxMDAuIE5vIG90aGVyIHR5cGVzDQo+
IHdlcmUgdGVzdGVkIGluIHRoZSBzdHJpcHBpbmcgY2FzZQ0KDQoNCkJydWNlLA0KDQpJdCBzZWVt
cyB0aGUgZHJpdmVycyBoYXZlIHRoZSBhYmlsaXR5IHRvIHNldCB0aGUgRXRoZXJUeXBlIG9mIHRo
ZSBPdXRlciAoYW5kIHNvbWV0aW1lcyBJbm5lcikgdGFnOg0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxp
bi5jb20vZHBkay92MjUuMDcvc291cmNlL2xpYi9ldGhkZXYvcnRlX2V0aGRldi5oI0wzNzUyDQpo
dHRwczovL2VsaXhpci5ib290bGluLmNvbS9kcGRrL3YyNS4wNy9zb3VyY2UvZHJpdmVycy9uZXQv
aW50ZWwvZTEwMDAvaWdiX2V0aGRldi5jI0wyNzM5DQpodHRwczovL2VsaXhpci5ib290bGluLmNv
bS9kcGRrL3YyNS4wNy9zb3VyY2UvZHJpdmVycy9uZXQvaW50ZWwvaTQwZS9pNDBlX2V0aGRldi5j
I0w0MDM4DQoNCi1Nb3J0ZW4NCg0K
