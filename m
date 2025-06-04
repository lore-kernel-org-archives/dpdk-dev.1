Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB66BC5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 10:29:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B91D427C3;
	Wed,  4 Jun 2025 12:29:35 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 062084029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 12:29:33 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C27AB21ECB;
 Wed,  4 Jun 2025 12:29:32 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v5 0/3] add portable version of __builtin_add_overflow
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 4 Jun 2025 12:29:30 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FCBF@smartserver.smartshare.dk>
In-Reply-To: <CAJFAV8z3zqxm_VLXkztjThS3XhuKrJ0kf_yjeSgx+VjXaoyh7w@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5 0/3] add portable version of __builtin_add_overflow
Thread-Index: AdvVOJnW53LYINpARBaqwpaNSGXVeAAAZIQA
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1741962820-27123-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8z3zqxm_VLXkztjThS3XhuKrJ0kf_yjeSgx+VjXaoyh7w@mail.gmail.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "David Marchand" <david.marchand@redhat.com>,
 "Andre Muezerie" <andremue@linux.microsoft.com>,
 "Thomas Monjalon" <thomas@monjalon.net>
Cc: <dev@dpdk.org>, "Stephen Hemminger" <stephen@networkplumber.org>,
 "Bruce Richardson" <bruce.richards@intel.com>
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
DQo+IFNlbnQ6IFdlZG5lc2RheSwgNCBKdW5lIDIwMjUgMTIuMDgNCj4gDQo+IE9uIEZyaSwgTWFy
IDE0LCAyMDI1IGF0IDM6MzTigK9QTSBBbmRyZSBNdWV6ZXJpZQ0KPiA8YW5kcmVtdWVAbGludXgu
bWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBfX2J1aWx0aW5fYWRkX292ZXJmbG93IGlz
IGdjYyBzcGVjaWZpYy4gVGhlcmUncyBhIG5lZWQgZm9yIGEgcG9ydGFibGUNCj4gPiB2ZXJzaW9u
IHRoYXQgY2FuIGFsc28gYmUgdXNlZCB3aXRoIG90aGVyIGNvbXBpbGVycy4NCj4gPg0KPiA+IHY1
Og0KPiA+IC0gQ29tYmluZWQgcGF0Y2hlcyAxIHdpdGggNSBhbmQgMiB3aXRoIDMuDQo+ID4NCj4g
PiB2NDoNCj4gPiAtIEFkZGVkIGRlZmluZSBpbiBpY2Vfb3NkZXAuaCB0byB1c2UgcG9ydGFibGUg
dmVyc2lvbiBvZg0KPiA+ICAgX19idWlsdGluX2FkZF9vdmVyZmxvdyB3aGVuIHVzaW5nIE1TVkMu
DQo+ID4gLSBVbmRpZCBhbGwgY2hhbmdlcyBmcm9tIGRyaXZlcnMvbmV0L2ludGVsL2ljZS9iYXNl
L2ljZV9udm0uYy4NCj4gPg0KPiA+IHYzOg0KPiA+IC0gUmViYXNlIG9uIHRvcCBvZiBsYXRlc3Qg
bWFpbi4NCj4gPg0KPiA+IEFuZHJlIE11ZXplcmllICgzKToNCj4gPiAgIGVhbDogYWRkIHBvcnRh
YmxlIHZlcnNpb24gb2YgX19idWlsdGluX2FkZF9vdmVyZmxvdw0KPiA+ICAgbmV0L2ludGVsOiB1
c2UgcG9ydGFibGUgdmVyc2lvbiBvZiBfX2J1aWx0aW5fYWRkX292ZXJmbG93DQo+ID4gICBhcHAv
dGVzdDogYWRkIHRlc3RzIGZvciBwb3J0YWJsZSB2ZXJzaW9uIG9mIF9fYnVpbHRpbl9hZGRfb3Zl
cmZsb3cNCj4gPg0KPiA+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgMSArDQo+ID4gIGFwcC90ZXN0L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgIHwgICAx
ICsNCj4gPiAgYXBwL3Rlc3QvdGVzdF9tYXRoLmMgICAgICAgICAgICAgICAgICAgfCAxNzANCj4g
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBkb2MvYXBpL2RveHktYXBpLWluZGV4Lm1k
ICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvbmV0L2ludGVsL2ljZS9iYXNlL2lj
ZV9vc2RlcC5oIHwgICA1ICsNCj4gPiAgbGliL2VhbC9pbmNsdWRlL21lc29uLmJ1aWxkICAgICAg
ICAgICAgfCAgIDEgKw0KPiA+ICBsaWIvZWFsL2luY2x1ZGUvcnRlX21hdGguaCAgICAgICAgICAg
ICB8ICA0NiArKysrKysrDQo+ID4gIDcgZmlsZXMgY2hhbmdlZCwgMjI1IGluc2VydGlvbnMoKykN
Cj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFwcC90ZXN0L3Rlc3RfbWF0aC5jDQo+ID4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBsaWIvZWFsL2luY2x1ZGUvcnRlX21hdGguaA0KPiANCj4gSSBhbSBub3Qg
YSBmYW4gb2YgYWRkaW5nIHN1Y2ggcHVibGljIEFQSSwgYW4gaW50ZXJuYWwgQVBJIHdvdWxkIGJl
DQo+IGVub3VnaC4NCj4gRG8geW91IHBsYW4gdG8gYWRkIG1vcmUgaGVscGVycyBmb3IgbWF0aCBv
cGVyYXRpb25zPw0KPiANCj4gRm9yIHRoZSBjdXJyZW50IGhlbHBlciwgdGhlIG9ubHkgdXNlciBp
cyBhIGRyaXZlciAoYmFzZSBjb2RlKS4NCj4gQ2FuJ3Qgd2UganVzdCB3cmFwIGEgX19idWlsdGlu
X2FkZF9vdmVyZmxvdyAodW5kZXIgI2lmZGVmIG1zdmMpIGluIHRoZQ0KPiBvc2RlcC5oIGhlYWRl
cj8NCg0KV2UgYWxyZWFkeSBoYXZlIHB1YmxpYyBBUElzIGZvciBiaXQgb3BlcmF0aW9ucyBpbiBy
dGVfYml0b3BzLmguDQpUaGlzIG1hdGggQVBJIGZvbGxvd3MgdGhlIHNhbWUgcHJpbmNpcGxlOyBh
bmQgbWF0aCBvcGVyYXRpb25zIC0ganVzdCBsaWtlIGJpdCBvcGVyYXRpb25zIC0gbWlnaHQgYmUg
dXNlZnVsIGZvciBEUERLIGFwcGxpY2F0aW9ucywgc28gbGV0J3Mga2VlcCBpdCBwdWJsaWMuDQoN
ClRoZSBvbmx5IGlzc3VlIEkgaGF2ZSB3aXRoIHRoZXNlIChpbmNsLiB0aGUgYml0IG9wZXJhdGlv
bnMpIGFyZSB0aGF0IHRoZXkgYXJlIGluIHRoZSBFQUwgbGlicmFyeSwgYWx0aG91Z2ggdGhleSBo
YXZlIGFic29sdXRlbHkgbm90aGluZyB0byBkbyB3aXRoIGhhcmR3YXJlIG9yIE8vUyBhYnN0cmFj
dGlvbiwgc28gdGhleSByZWFsbHkgc2hvdWxkIGJlIGluIGEgInV0aWxzIiBsaWJyYXJ5Lg0KQnV0
IHRoYXQncyBhbm90aGVyIHN0b3J5LCBzbyBsZXQncyBub3QgYnVyZGVuIEFuZHJlIHdpdGggdGhh
dC4NCg0K
