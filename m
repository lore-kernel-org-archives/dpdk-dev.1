Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC4AC7EE39
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Jun 2025 16:45:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B1324025D;
	Sat, 28 Jun 2025 18:45:46 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 096BA40144
 for <dev@dpdk.org>; Sat, 28 Jun 2025 18:45:44 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C297120625;
 Sat, 28 Jun 2025 18:45:44 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [PATCH v3 2/3] eal: handle sysconf(_SC_PAGESIZE) negative return
 value
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Sat, 28 Jun 2025 18:45:44 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD5B@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <21665758.gIjEHFZm8d@thomas>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 2/3] eal: handle sysconf(_SC_PAGESIZE) negative return
 value
Thread-Index: AdvnkYb5EJV7jtcOQfyb5/V1MG+qfQAtktRQ
References: <20250610131348.248800-1-mb@smartsharesystems.com>
 <6180155.ReJHH8Nr61@thomas>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD53@smartserver.smartshare.dk>
 <21665758.gIjEHFZm8d@thomas>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: "Tyler Retzlaff" <roretzla@linux.microsoft.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Maxime Coquelin" <maxime.coquelin@redhat.com>,
 "Chenbo Xia" <chenbox@nvidia.com>,
 "Tomasz Duszynski" <tduszynski@marvell.com>,
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

PiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0bzp0aG9tYXNAbW9uamFsb24ubmV0XQ0KPiBT
ZW50OiBGcmlkYXksIDI3IEp1bmUgMjAyNSAyMC4zMA0KPiANCj4gMjcvMDYvMjAyNSAxOTo0OSwg
TW9ydGVuIEJyw7hydXA6DQo+ID4gPiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0bzp0aG9t
YXNAbW9uamFsb24ubmV0XQ0KPiA+ID4gU2VudDogRnJpZGF5LCAyNyBKdW5lIDIwMjUgMTkuMzUN
Cj4gPiA+DQo+ID4gPiAyNy8wNi8yMDI1IDE4OjM4LCBNb3J0ZW4gQnLDuHJ1cDoNCj4gPiA+ID4g
PiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0bzp0aG9tYXNAbW9uamFsb24ubmV0XQ0KPiA+
ID4gPiA+IFNlbnQ6IEZyaWRheSwgMjcgSnVuZSAyMDI1IDE3LjU4DQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiAyNC8wNi8yMDI1IDEwOjAzLCBNb3J0ZW4gQnLDuHJ1cDoNCj4gPiA+ID4gPiA+ICsJCWlm
ICgoc3NpemVfdClwYWdlX3NpemUgPCAwKQ0KPiA+ID4gPiA+ID4gKwkJCXJ0ZV9wYW5pYygic3lz
Y29uZihfU0NfUEFHRVNJWkUpIGZhaWxlZDogJXMiLA0KPiA+ID4gPiA+ID4gKwkJCQkJZXJybm8g
PT0gMCA/ICJJbmRldGVybWluYXRlIiA6DQo+ID4gPiA+ID4gc3RyZXJyb3IoZXJybm8pKTsNCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IFdlIGRvbid0IHdhbnQgbW9yZSBydGVfcGFuaWMoKS4NCj4gPiA+
ID4gPiBZb3UgY291bGQgbG9nIHRoZSBwcm9ibGVtIGFuZCByZXR1cm4gMCBoZXJlLg0KPiA+ID4g
PiA+IEl0IHdpbGwgYmUgYSBwcm9ibGVtIGxhdGVyLCBidXQgaXQgbWF5IGFsbG93IHRoZSBhcHBs
aWNhdGlvbiB0bw0KPiA+ID4gY2xlYW51cA0KPiA+ID4gPiA+IGluc3RlYWQgb2YgYWJydXB0aW5n
IGNyYXNoaW5nLg0KPiA+ID4gPg0KPiA+ID4gPiBEaXNhZ3JlZS4NCj4gPiA+ID4gVGhhdCB3b3Vs
ZCBiZSBsaWtlbHkgdG8gY2F1c2UgY3Jhc2ggd2l0aCBkaXZpc2lvbiBieSB6ZXJvIGxhdGVyLg0K
PiA+ID4gPiBCZXR0ZXIgdG8gZmFpbCBlYXJseS4NCj4gPiA+DQo+ID4gPiBXaGljaCBkaXZpc2lv
biBieSB6ZXJvPw0KPiA+DQo+ID4gRnVuY3Rpb25zIGRpdmlkaW5nIGJ5IHBhZ2Ugc2l6ZS4gRS5n
LjoNCj4gPg0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9kcGRrL3YyNS4wMy9zb3VyY2Uv
bGliL2VhbC9jb21tb24vZWFsX2NvbW1vbl8NCj4gbWVtb3J5LmMjTDMxMw0KPiA+DQo+ID4gPg0K
PiA+ID4gSSBkb24ndCB0aGluayBhIGxpYnJhcnkgc2hvdWxkIHRha2UgdGhpcyBkZWNpc2lvbiBv
biBiZWhhbGYgb2YgdGhlDQo+IGFwcC4NCj4gPg0KPiA+IEkgZXhwZWN0IGxvdHMgb2YgdGhpbmdz
IHRvIGJyZWFrIGlmIHN5c2NvbmYoX1NDX1BBR0VTSVpFKSBmYWlscywgc28NCj4gdGhlIHB1cnBv
c2Ugb2YgdGhpcyBwYXRjaCBpcyB0byBjZW50cmFsaXplIGVycm9yIGhhbmRsaW5nIGhlcmUsIGFu
ZCBvbmx5DQo+IGNvbnRpbnVlL3JldHVybiB3aXRoIG5vbi1mYWlsaW5nIHZhbHVlcy4NCj4gPg0K
PiA+IE90aGVyd2lzZSwgZXZlcnl3aGVyZSB1c2luZyBydGVfbWVtX3BhZ2Vfc2l6ZSgpIG9yDQo+
IHN5c2NvbmYoX1NDX1BBR0VTSVpFKSBzaG91bGQgaW1wbGVtZW50IGVycm9yIGhhbmRsaW5nIChv
ciBpZ25vcmUNCj4gZXJyb3JzKS4NCj4gPiBUaGF0J3MgYSBsb3Qgb2YgcGxhY2VzLCBzbyBJJ20g
bm90IGdvaW5nIHRvIHByb3ZpZGUgYSBwYXRjaCBkb2luZw0KPiB0aGF0Lg0KPiANCj4gSSB1bmRl
cnN0YW5kLg0KPiANCj4gVGhlIHByb2JsZW0gaXMgdGhhdCB3ZSBkb24ndCBoYXZlIGFuIGV4Y2Vw
dGlvbiBtZWNoYW5pc20gaW4gdGhpcw0KPiBsYW5ndWFnZS4NCg0KWWVwLg0KQW5kIGV2ZXJ5b25l
IGFzc3VtZXMgc3lzY29uZihfU0NfUEFHRVNJWkUpIG5ldmVyIGZhaWxzLCB3aGljaCBpcyBwcm9i
YWJseSBjb3JyZWN0LCBzbyBub2JvZHkgaW1wbGVtZW50ZWQgZXJyb3IgaGFuZGxpbmcgZm9yIGl0
LiBOb3QgZXZlbiBpbiBydGVfbWVtX3BhZ2Vfc2l6ZSgpLg0KQ292ZXJpdHkgZGV0ZWN0ZWQgdGhl
IG1pc3NpbmcgZXJyb3IgaGFuZGxpbmcsIGFuZCB3YXJuczogIkFsdGhvdWdoIHJ0ZV9tZW1fcGFn
ZV9zaXplKCkgaXMgZGVjbGFyZWQgdG8gcmV0dXJuIHVuc2lnbmVkIGludCwgaXQgbWF5IGFjdHVh
bGx5IHJldHVybiBhIG5lZ2F0aXZlIHZhbHVlLiIgVGhpcyBkZWZlY3QgYXBwbGllcyB0byBhbGwg
ZnVuY3Rpb25zIGNhbGxpbmcgcnRlX21lbV9wYWdlX3NpemUoKS4NClRoaXMgcGF0Y2ggYWRkcyBl
cnJvciBoYW5kbGluZyB0byBlbnN1cmUgdGhhdCBydGVfbWVtX3BhZ2Vfc2l6ZSgpIG9ubHkgcmV0
dXJucyBub24tbmVnYXRpdmUgdmFsdWVzLCBvciBkb2VzbuKAmXQgcmV0dXJuIGF0IGFsbCAtIGku
ZS4gZmFpbHMgd2l0aCBydGVfcGFuaWMoKSAtIHNvIENvdmVyaXR5IGlzIHNhdGlzZmllZCB3aXRo
IGNhbGxlcnMgbm90IGltcGxlbWVudGluZyBlcnJvciBoYW5kbGluZyBmb3IgaXQuDQoNCkl0IHdv
dWxkIGJlIGJvcmRlcmxpbmUgd2FzdGUgb2YgdGltZSBmaXhpbmcgYWxsIHRoZSBjYWxsZXJzLCBz
byBJIGZpeGVkIHRoZSByb290IGNhdXNlIHRvIHNhdGlzZnkgQ292ZXJpdHkuDQoNCkZyb20gYW4g
aGlnaGVyIGxldmVsIHBlcnNwZWN0aXZlOg0KVGhpcyBpcyBhIGxvdyBsZXZlbCBFQUwgZnVuY3Rp
b24gdG8gZGV0ZXJtaW5lIHRoZSBwYWdlIHNpemUuIEkgd291bGQgY29uc2lkZXIgaXQgcmVhc29u
YWJsZSBmb3Igc3VjaCBhIGxvdyBsZXZlbCBFQUwgZnVuY3Rpb24gdG8gbmV2ZXIgZmFpbC4NCklm
IHNvbWUgTy9TIGRlY2lkZXMgdG8gbm90IGhhdmUgYSAic3lzdGVtIHBhZ2Ugc2l6ZSIsIGFuZCBm
YWlsIHdpdGggIkluZGV0ZXJtaW5hdGUiLCBlLmcuIHRvIHN1cHBvcnQgbXVsdGlwbGUgcGFnZSBz
aXplcywgd2Ugd291bGQgbmVlZCB0byBoYW5kbGUgdGhhdCBzb21laG93LiBCdXQgbGV0J3MgaWdu
b3JlIHRoYXQgdW50aWwgaXQgYWN0dWFsbHkgaGFwcGVucywgaWYgZXZlci4NCg0KSWYgeW91IGFy
ZSBza2VwdGljYWwgYWJvdXQgdGhpcyBwYXRjaCAyLzMgaW4gdGhlIHNlcmllcywgd2UgY2FuIGVz
Y2FsYXRlIHRoZSBkaXNjdXNzaW9uIHRvIHRoZSB0ZWNoIGJvYXJkLiBJZiB5b3UgcmVhbGx5IGhh
dGUgdGhpcyBwYXRjaCAyLzMsIEkgd2lsbCBob25vciBhIE5BSyBmcm9tIHlvdS4gVGhlIHBhdGNo
IGlzIG5vdCBpbXBvcnRhbnQgZm9yIG1lOyBJJ20ganVzdCB0cnlpbmcgdG8gY2xlYW4gdXAuDQoN
Cg==
