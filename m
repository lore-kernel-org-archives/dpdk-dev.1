Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E29CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 07:53:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8B2C4026D;
	Tue, 11 Nov 2025 08:53:13 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id EF83F4026A
 for <dev@dpdk.org>; Tue, 11 Nov 2025 08:53:11 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C70F8206DC;
 Tue, 11 Nov 2025 08:53:11 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH 1/3] bpf: fix signed shift overflows in ARM JIT
Date: Tue, 11 Nov 2025 08:53:09 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65556@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <CALBAE1O2VtvLV06-4hPCb5qHsRzqDM1iWWOaRcPKu9L-NMu2qg@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/3] bpf: fix signed shift overflows in ARM JIT
Thread-Index: AdxS1AlRyzdopIPHRgazw3s3Q96I7wACp/rA
References: <20251110153046.63518-1-marat.khalili@huawei.com>
 <20251110153046.63518-2-marat.khalili@huawei.com>
 <CALBAE1O2VtvLV06-4hPCb5qHsRzqDM1iWWOaRcPKu9L-NMu2qg@mail.gmail.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Jerin Jacob" <jerinjacobk@gmail.com>,
 "Marat Khalili" <marat.khalili@huawei.com>
Cc: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>
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

PiBGcm9tOiBKZXJpbiBKYWNvYiBbbWFpbHRvOmplcmluamFjb2JrQGdtYWlsLmNvbV0NCj4gU2Vu
dDogVHVlc2RheSwgMTEgTm92ZW1iZXIgMjAyNSAwNy4yNQ0KPiANCj4gT24gTW9uLCBOb3YgMTAs
IDIwMjUgYXQgOTowMeKAr1BNIE1hcmF0IEtoYWxpbGkNCj4gPG1hcmF0LmtoYWxpbGlAaHVhd2Vp
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBMZWZ0IHNoaWZ0cyBvZiBpbnRlZ2VyIGxpdGVyYWxzIGFu
ZCBib29sIHZhbHVlcyBvdmVyd3JpdGluZyB0aGUgc2lnbg0KPiBiaXQNCj4gPiB3ZXJlIHVzZWQg
bXVsdGlwbGUgdGltZXMgaW4gYnBmX2ppdF9hcm02NC5jLiBFLmcuOg0KPiA+DQo+ID4gICAgIGlu
c24gPSAoISFpczY0KSA8PCAzMTsNCj4gPg0KPiA+IHdoZXJlIGlzNjQgaGFzIHR5cGUgYm9vbCAo
ZG91YmxlIGJhbmcgaXMgYSBuby1vcCBoZXJlKS4gVGhlIG9wZXJhbmQNCj4gb2YNCj4gPiBsZWZ0
IHNoaWZ0IHdhcyBwcm9tb3RlZCB0byB0eXBlIGludCwgd2hpY2ggd2hlbiAzMi1iaXQgd2lkZSBj
YW5ub3QNCj4gPiByZXByZXNlbnQgdGhlIHJlc3VsdC4gU2ltaWxhcmx5IGxpdGVyYWwgaW50ZWdl
cnMgaGF2ZSBpbnQgdHlwZSBieQ0KPiA+IGRlZmF1bHQuICBTYW5pdGl6ZXIgcHJvZHVjZWQgdGhl
IGZvbGxvd2luZyBkaWFnbm9zdGljIGR1cmluZyBydW50aW1lDQo+ID4gKGZvciB2YXJpb3VzIGxp
bmVzKToNCj4gPg0KPiA+ICAgICBsaWIvYnBmL2JwZl9qaXRfYXJtNjQuYzoyNDE6MTg6IHJ1bnRp
bWUgZXJyb3I6IGxlZnQgc2hpZnQgb2YgMSBieQ0KPiAzMQ0KPiA+ICAgICBwbGFjZXMgY2Fubm90
IGJlIHJlcHJlc2VudGVkIGluIHR5cGUgJ2ludCcNCj4gDQo+IFdvbmRlciB3aHkgbm9uZSBvZiB0
aGUgdGVzdHMgaW4gYXBwL3Rlc3QvdGVzdF9icGYuYyBhYmxlIHRvIGNhdGNoDQo+IHRoaXM/IFRo
ZSBnZW5lcmF0ZWQgQVJNIG9wY29kZSBsb29rcyBPSyAob3RoZXJ3aXNlIHRlc3RzIHdvbnQgcGFz
cykuDQo+IENvdWxkIHlvdSBjaGVjayB3aGF0IGlzIG1pc3NpbmcgaW4gdGhlIGFwcC90ZXN0L3Rl
c3RfYnBmLmM/DQo+IA0KPiBBbHNvIFNISUZUX1ZBUjMyIG5lZWRzIGdvdG8gY29tbW9uIGNvZGUu
DQo+IA0KPiANCj4gPg0KPiA+IFRvIGZpeCB0aGUgaXNzdWUgdXNlIFJURV9CSVQzMiBhbmQgc2lt
aWxhciBtYWNyb3MgaW5zdGVhZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmF0IEtoYWxp
bGkgPG1hcmF0LmtoYWxpbGlAaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiAgbGliL2JwZi9icGZf
aml0X2FybTY0LmMgfCAxODggKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0N
Cj4gLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwNyBpbnNlcnRpb25zKCspLCA4MSBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9saWIvYnBmL2JwZl9qaXRfYXJtNjQuYyBiL2xp
Yi9icGYvYnBmX2ppdF9hcm02NC5jDQo+ID4gaW5kZXggOTZiOGNkMmUwMy4uNWY0M2RiMDE3MCAx
MDA2NDQNCj4gPiAtLS0gYS9saWIvYnBmL2JwZl9qaXRfYXJtNjQuYw0KPiA+ICsrKyBiL2xpYi9i
cGYvYnBmX2ppdF9hcm02NC5jDQo+ID4gQEAgLTI4LDcgKzI4LDMzIEBADQo+ID4gICNkZWZpbmUg
QTY0X1pSICAgICAgICAgICAgICAgICAzMQ0KPiA+DQo+ID4gICNkZWZpbmUgY2hlY2tfaW1tKG4s
IHZhbCkgKCgodmFsKSA+PSAwKSA/ICEhKCh2YWwpID4+IChuKSkgOg0KPiAhISgofnZhbCkgPj4g
KG4pKSkNCj4gPiAtI2RlZmluZSBtYXNrX2ltbShuLCB2YWwpICgodmFsKSAmICgoMSA8PCAobikp
IC0gMSkpDQo+ID4gKyNkZWZpbmUgbWFza19pbW0obiwgdmFsKSAoKHZhbCkgJiAoUlRFX0JJVDMy
KG4pIC0gMSkpDQo+ID4gKw0KPiA+ICsvKioNCj4gPiArICogR2V0IHRoZSB1aW50MzJfdCBzaGlm
dGVkIHZhbHVlLg0KPiA+ICsgKg0KPiA+ICsgKiBXb3JrcyBzaW1pbGFybHkgdG8gUlRFX1NISUZU
X1ZBTDMyIGJ1dCBhY2NlcHRzIG5vbi1saXRlcmFsDQo+IGFyZ3VtZW50cy4NCj4gPiArICogUGVy
Zm9ybXMgaWRlbnRpY2FsbHkgdG8gUlRFX1NISUZUX1ZBTDMyIHdpdGggbGl0ZXJhbCBhcmd1bWVu
dHMuDQo+ID4gKyAqDQo+ID4gKyAqIEBwYXJhbSB2YWwNCj4gPiArICogICBUaGUgdmFsdWUgdG8g
YmUgc2hpZnRlZCwgY2FuIGJlIG5vbi1saXRlcmFsLg0KPiA+ICsgKiBAcGFyYW0gbnINCj4gPiAr
ICogICBUaGUgc2hpZnQgbnVtYmVyIGluIHJhbmdlIG9mIDAgdG8gKDMyIC0gd2lkdGggb2YgdmFs
KS4NCj4gPiArICovDQo+ID4gKyNkZWZpbmUgU0hJRlRfVkFSMzIodmFsLCBucikgKCh1aW50MzJf
dCkodmFsKSA8PCAobnIpKQ0KPiA+ICsNCj4gPiArLyoqDQo+ID4gKyAqIEdldCB0aGUgdWludDY0
X3Qgc2hpZnRlZCB2YWx1ZS4NCj4gPiArICoNCj4gPiArICogV29ya3Mgc2ltaWxhcmx5IHRvIFJU
RV9TSElGVF9WQUw2NCBidXQgYWNjZXB0cyBub24tbGl0ZXJhbA0KPiBhcmd1bWVudHMuDQo+ID4g
KyAqIFBlcmZvcm1zIGlkZW50aWNhbGx5IHRvIFJURV9TSElGVF9WQUw2NCB3aXRoIGxpdGVyYWwg
YXJndW1lbnRzLg0KPiA+ICsgKg0KPiA+ICsgKiBAcGFyYW0gdmFsDQo+ID4gKyAqICAgVGhlIHZh
bHVlIHRvIGJlIHNoaWZ0ZWQsIGNhbiBiZSBub24tbGl0ZXJhbC4NCj4gPiArICogQHBhcmFtIG5y
DQo+ID4gKyAqICAgVGhlIHNoaWZ0IG51bWJlciBpbiByYW5nZSBvZiAwIHRvICg2NCAtIHdpZHRo
IG9mIHZhbCkuDQo+ID4gKyAqLw0KPiA+ICsjZGVmaW5lIFNISUZUX1ZBUjY0KHZhbCwgbnIpICgo
dWludDY0X3QpKHZhbCkgPDwgKG5yKSkNCg0KQmV0dGVyIHJlcGxhY2UgdGhlIFJURV9TSElGVF9W
QUwzMi9WQUw2NCBtYWNyb3Mgd2l0aCB0aGVzZSwgdG8gc3VwcG9ydCBib3RoIGxpdGVyYWwgYW5k
IG5vbi1saXRlcmFsIGFyZ3VtZW50cy4NCg0K
