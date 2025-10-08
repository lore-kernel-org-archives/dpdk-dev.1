Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ADECCA472
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 12:36:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6FE840285;
	Wed,  8 Oct 2025 14:36:30 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 32AE84026F;
 Wed,  8 Oct 2025 14:36:30 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1202F202CC;
 Wed,  8 Oct 2025 14:36:29 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: Use of TX offload flags MBUF_FAST_FREE and MULTI_SEGS
Date: Wed, 8 Oct 2025 14:36:27 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654B1@smartserver.smartshare.dk>
In-Reply-To: <CAOaVG14WRb0YDk6UzzQ6zJ1iwjU2KFdMBVH6_Aypvq7yotYfSA@mail.gmail.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Use of TX offload flags MBUF_FAST_FREE and MULTI_SEGS
Thread-Index: Adw3YDrBAtQy+QrRQymnonAL3PFEPQAFklQg
References: <aN-Use5rigF3tQc9@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6549F@smartserver.smartshare.dk>
 <CAOaVG14WRb0YDk6UzzQ6zJ1iwjU2KFdMBVH6_Aypvq7yotYfSA@mail.gmail.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: "dev" <dev@dpdk.org>, "dpdk-techboard" <techboard@dpdk.org>,
 "Thomas Monjalon" <thomas@monjalon.net>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Patrick Robb" <probb@iol.unh.edu>
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

PkZyb206IFN0ZXBoZW4gSGVtbWluZ2VyIFttYWlsdG86c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5v
cmddIA0KPlNlbnQ6IFR1ZXNkYXksIDcgT2N0b2JlciAyMDI1IDA5LjU5DQo+DQo+VG8gaGVscCB3
aXRoIGRlZmluaXRpb24gb2YgZmFzdCBmcmVlIGZsYWcsIEkgd291bGQgbGlrZSB0aGUgZG9jdW1l
bnRhdGlvbiB0byBiZSBiZXR0ZXIuDQo+DQo+U29tZXRoaW5nIGxpa2U6DQo+RmFzdCBmcmVlIGZs
YWcgYWxsb3dzIGRyaXZlciB0byBhdm9pZCBleHBlbnNpdmUgYXRvbWljIG9wZXJhdG9ycyBvbiBy
ZWYgY291bnQgYW5kIGFzc3VtZSBhbGwgbWJ1ZnMgaW4gYSBidXJzdCBhcmUgZnJvbSB0aGUgc2Ft
ZSBwb29sLg0KDQpJTU8sIGZvciBhIGRyaXZlciB0byByZWFsbHkgYmVuZWZpdCwgdGhlIG1idWZz
IG11c3QgYWxzbyBiZSBkaXJlY3QsIHNvIHRoZSBkcml2ZXIgY2FuIHNpbXBseSBmcmVlIGFsbCB0
aGUgbWJ1ZnMgYWZ0ZXIgdGhleSBoYXZlIGJlZW4gdHJhbnNtaXR0ZWQsIGFuZCBhdm9pZCB0aGlz
IGNvbXBsZXggcGFydCBvZiBydGVfcGt0bWJ1Zl9wcmVmcmVlX3NlZygpIFsyXToNCglpZiAoIVJU
RV9NQlVGX0RJUkVDVChtKSkgew0KCQlydGVfcGt0bWJ1Zl9kZXRhY2gobSk7DQoJCWlmIChSVEVf
TUJVRl9IQVNfRVhUQlVGKG0pICYmDQoJCSAgICBSVEVfTUJVRl9IQVNfUElOTkVEX0VYVEJVRiht
KSAmJg0KCQkgICAgX19ydGVfcGt0bWJ1Zl9waW5uZWRfZXh0YnVmX2RlY3JlZihtKSkNCgkJCXJl
dHVybiBOVUxMOw0KCX0NCg0KWzJdOiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9kcGRrL3Yy
NS4wNy9zb3VyY2UvbGliL21idWYvcnRlX21idWYuaCNMMTQzMA0KDQo+DQo+U2hvdWxkIGFsc28g
YWRkIGRlYnVnIGFzc2VydHMgaW4gZHJpdmVycyBpbXBsZW50aW5nIGZhc3QgZnJlZS4NCj4NCj5P
biBNb24sIE9jdCA2LCAyMDI1LCAxNjo0MCBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5
c3RlbXMuY29tPiB3cm90ZToNCj4+PiBGcm9tOiBCcnVjZSBSaWNoYXJkc29uIFttYWlsdG86YnJ1
Y2UucmljaGFyZHNvbkBpbnRlbC5jb21dDQo+Pj4gU2VudDogRnJpZGF5LCAzIE9jdG9iZXIgMjAy
NSAxMS4xOA0KPj4+IFN1YmplY3Q6IE1pbnV0ZXMgb2YgdGVjaGJvYXJkIG1lZXRpbmcsIDIwMjUt
MTAtMDENCj4+DQo+Pj4gKiBVc2Ugb2YgRkFTVF9GUkVFIGFuZCBtdWx0aS1idWZmZXIvc2NhdHRl
cmVkIG1idWYgZmxhZ3MNCj4+PiAgIC0gVGhlIGZsYWdzIGZvciBlbmFibGluZyBmYXN0LWZyZWUg
YW5kIHN1cHBvcnRpbmcgbXVsdGktbWJ1ZiBwYWNrZXRzDQo+Pj4gYXJlDQo+Pj4gICAgIG5vdyBk
b2N1bWVudGVkIGluY29tcGF0aWJsZQ0KPj4+ICAgLSBQcmV2aW91c2x5IHRoZXkgd2VyZSBub3Qg
ZGVmaW5lZCBhcyBpbmNvbXBhdGlibGUsIGJ1dCB0aGF0IHNlZW1zIHRvDQo+Pj4gICAgIGhhdmUg
YmVlbiBhc3N1bWVkIGZvciBzb21lIHVzYWdlcy4NCj4+PiAgIC0gVGVjaGJvYXJkIGRpc2N1c3Nl
ZCBob3cgYmVzdCB0byByZXNvbHZlIHRoaXMgaW5jb21wYXRpYmlsaXR5IHdpdGgNCj4+PiAgICAg
cmVnYXJkcyB0bzoNCj4+PiAgICAgLSBlbnN1cmluZyBjb3JyZWN0bmVzcw0KPj4+ICAgICAtIGF2
b2lkaW5nIG1ham9yIGNodXJuIHRvIERQREsgY29kZQ0KPj4+ICAgICAtIGF2b2lkaW5nIGNodXJu
IHRvIGVuZC11c2VyIGNvZGUNCj4+PiAgIC0gT3B0aW9ucyBkaXNjdXNzZWQ6DQo+Pj4gICAgIDEg
Y2hhbmdlIGRlZmluaXRpb24gYmFjayB0byBub3QgaGF2ZSB0aGUgc2V0dGluZ3MgaW5jb21wYXRp
YmxlOg0KPj4+IHRoaXMNCj4+PiAgICAgICBuZWNlc3NpdGF0ZXMgY2hlY2tpbmcgZHJpdmVycyBm
b3IgY29ycmVjdG5lc3MNCj4+PiAgICAgMiBrZWVwIGFzIGV4cGxpY2l0bHkgaW5jb21wYXRpYmxl
IGFuZCByZXBvcnQgZXJyb3IgaWYgYm90aA0KPj4+IHNwZWNpZmllZDoNCj4+PiAgICAgICB0aGlz
IGNvdWxkIGJyZWFrIGVuZC11c2VyIGFwcHMsIGFuZCByZXF1aXJlcyBjaGFuZ2VzIHRvIGV4YW1w
bGUNCj4+PiBhcHBzDQo+Pj4gICAgIDMgZHJvcCB0aGUgZmFzdC1mcmVlIGZsYWcgaWYgbXVsdGkt
c2VnbWVudCBtYnVmcyBhcmUgYWxzbw0KPj4+IHNwZWNpZmllZDoNCj4+PiAgICAgICAiaGlkZXMi
IHRoZSBpc3N1ZSwgYnV0IHByb2JhYmx5IG1pbmltaXNlcyBjaGFuZ2VzLiBXb3VsZCBuZWVkIHRv
DQo+Pj4gICAgICAgZGVjaWRlIHdoZXRoZXIgdGhlIGRyb3BwaW5nIG9mIGZsYWcgZG9uZSBpbiBk
cml2ZXJzIHZzIGV0aGRldg0KPj4+IGxldmVsLg0KPj4+ICAgICAgIFByb3MgYW5kIGNvbnMgdG8g
Ym90aCBvcHRpb25zLiBOZWVkcyBjbGVhciBkb2N1bWVudGluZy4NCj4+PiAgIC0gTm8gZmlybSBk
ZWNpc2lvbiByZWFjaGVkLCB3aWxsIGRpc2N1c3MgbW9yZSBvdmVyIGVtYWlsLg0KPj4NCj4+SU1P
LCB0aGUgcGF0Y2ggWzFdIG1ha2luZyBNQlVGX0ZBU1RfRlJFRSBhbmQgTVVMVElfU0VHUyBleHBs
aWNpdGx5IGluY29tcGF0aWJsZSBzaG91bGQgYmUgcmV2ZXJ0ZWQsIGF0IGxlYXN0IGZvciBSQzEu
DQo+PlRoYXQgd2lsbCB0YWtlIHRoZSBwcm9qZWN0IGJhY2sgdG8gdGhlIHN0YXRlIGl0IHdhcyBp
biBiZWZvcmUgd2Ugc3RhcnRlZCB0aGlzIGRpc2N1c3Npb24uDQo+PkFuZCBhbGwgdGhlIGV4YW1w
bGVzIGJyb2tlbiBieSB0aGUgcGF0Y2ggKGJlY2F1c2UgdGhleSB1c2UgYm90aCBUWCBvZmZsb2Fk
cykgd2lsbCBub3QgbmVlZCBmaXhpbmcuDQo+Pg0KPj5bMV06IGh0dHBzOi8vcGF0Y2h3b3JrLmRw
ZGsub3JnL3Byb2plY3QvZHBkay9wYXRjaC8yMDI1MDgwMzE5NDIxOC42ODMzMTgtMy1tYkBzbWFy
dHNoYXJlc3lzdGVtcy5jb20vDQo+Pg0K
