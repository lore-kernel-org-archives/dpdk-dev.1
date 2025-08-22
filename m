Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015D8CA0EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 18:57:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1047340DD6;
	Fri, 22 Aug 2025 20:57:30 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B6EFB40DCB
 for <dev@dpdk.org>; Fri, 22 Aug 2025 20:57:28 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 8B8F9209AA;
 Fri, 22 Aug 2025 20:57:27 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [RFC 3/3] hash: add support for common small key sizes
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Fri, 22 Aug 2025 20:57:25 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE63@smartserver.smartshare.dk>
In-Reply-To: <90ad6122-467c-441d-8515-c043146a8a57@lysator.liu.se>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [RFC 3/3] hash: add support for common small key sizes
Thread-Index: AdwTdjQG/EYgDoQ3Smu/TFv01Vt0dgAAd26w
References: <20250821203646.133506-1-stephen@networkplumber.org>
 <20250821203646.133506-4-stephen@networkplumber.org>
 <5427c6f3-4446-4ee3-909e-5f2925d2b286@lysator.liu.se>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE61@smartserver.smartshare.dk>
 <90ad6122-467c-441d-8515-c043146a8a57@lysator.liu.se>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: =?UTF-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <hofors@lysator.liu.se>,
 "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>
Cc: =?UTF-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>,
 "Yipeng Wang" <yipeng1.wang@intel.com>,
 "Sameh Gobriel" <sameh.gobriel@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
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

PiA+Pj4gK3N0YXRpYyBpbmxpbmUgaW50DQo+ID4+PiArcnRlX2hhc2hfazJfY21wX2VxKGNvbnN0
IHZvaWQgKmtleTEsIGNvbnN0IHZvaWQgKmtleTIsIHNpemVfdCBrZXlfbGVuDQo+ID4+IF9fcnRl
X3VudXNlZCkNCj4gPj4+ICt7DQo+ID4+PiArCWNvbnN0IHVpbnQxNl90ICprMSA9IGtleTE7DQo+
ID4+PiArCWNvbnN0IHVpbnQxNl90ICprMiA9IGtleTI7DQo+ID4+PiArDQo+ID4+DQo+ID4+IFdo
YXQgd2UgZG8gbm93IGlzIHRvIHJlcXVpcmUgdGhlIGtleXMgYXJlIDE2LWJpdCBhbGlnbmVkICh3
aGljaCB3YXNuJ3QNCj4gPj4gdGhlIGNhc2UgYmVmb3JlKS4NCj4gPj4NCj4gPj4gWW91IGNvdWxk
DQo+ID4+DQo+ID4+IHVpbnQxNl90IGsxOw0KPiA+PiBtZW1jcHkoJmsxLCBrZXkxLCBzaXplb2Yo
dWludDE2X3QpKTsNCj4gPj4gaW5zdGVhZC4NCj4gPj4NCj4gPj4gV291bGQgZ2VuZXJhdGUgdGhl
IHNhbWUgY29kZSwgYnV0IGJlIHNhZmUgZnJvbSBhbnkgZnV0dXJlIGFsaWdubWVudCBpc3N1ZXMu
DQo+ID4NCj4gPiBPciB1c2UgdGhlIHVuYWxpZ25lZCB0eXBlcywgZS5nLjoNCj4gPiAJY29uc3Qg
dW5hbGlnbmVkX3VpbnQxNl90ICprMSA9IGtleTE7DQo+ID4gCWNvbnN0IHVuYWxpZ25lZF91aW50
MTZfdCAqazIgPSBrZXkyOw0KPiA+DQo+IA0KPiBDb3VsZCB5b3UgZXhwbGFpbiB3aHkgdGhhdCBp
cyBzYWZlPyBEb2Vzbid0DQo+IF9fYXR0cmlidXRlX18oKF9fYWxpZ25lZF9fKDEpKSkNCj4ganVz
dCBzYXkgc3BlY2lmeSB0aGUgb2JqZWN0IGRvZXNuJ3QgaGF2ZSBhbnkgYWxpZ25tZW50IHJlcXVp
cmVtZW50cywNCj4gd2l0aG91dCBhc2tpbmcgdGhlIGNvbXBpbGVyIHRvIGRlYWwgd2l0aCBpdD8N
Cg0KSXQgaXMgc2FmZSBiZWNhdXNlIHRoZSBjb21waWxlciBkb2VzIGRlYWwgd2l0aCBpdC4NCkhl
cmUncyBhIHNpbXBsZSBleGFtcGxlOg0KaHR0cHM6Ly9nb2Rib2x0Lm9yZy96L3IzOXpkZUVjeA0K
DQpJIGRvbid0IGtub3cgaG93IE1TVkMgZGVhbHMgd2l0aCBpdCwgYnV0IGl0IGRvZXNuJ3Qgc3Vw
cG9ydCBhbGlnbm1lbnQgc2Vuc2l0aXZlIGFyY2hpdGVjdHVyZXMsIHNvIG5vIHJlYWwgcHJvYmxl
bS4NCg0KPiANCj4gPj4NCj4gPj4gQW55d2F5LCBtYXliZSBpdCdzIHNhZmUgdG8gYXNzdW1lIHRo
ZSBrZXlzIGFyZSBhbGlnbmVkLCBzbyB0aGlzIGlzIG5vdA0KPiA+PiBhbiBpc3N1ZS4NCj4gPg0K
PiA+IExvdHMgb2YgRFBESyBjb2RlIGlnbm9yZXMgYWxpZ25tZW50IGlzc3Vlcy4NCj4gPg0KPiA+
Pg0KPiA+Pj4gKwlyZXR1cm4gazFbMF0gXiBrMlswXTsNCj4gPj4+ICt9DQo+ID4+DQo+ID4+IEhh
dmVuJ3QgeW91IGltcGxlbWVudGVkICJuZXEiIHJhdGhlciB0aGFuICJlcSIgaGVyZT8gSWYgdGhl
IGtleXMgYXJlDQo+ID4+IGVxdWFsLCB0aGUgcmVzdWx0IGlzIDAuIFNob3VsZCBiZSAhPSAwLg0K
PiA+DQo+ID4gTm90IGEgYnVnLg0KPiANCj4gV2VsbCwgdGhlIGZ1bmN0aW9uIGJvZHkgZG9lc24n
dCBkbyB3aGF0IHRoZSBmdW5jdGlvbiBuYW1lIHRlbGxzIGl0LiA6KQ0KDQpBZ3JlZS4gVGhleSBy
ZWFsbHkgc2hvdWxkIGJlIHJlbmFtZWQgdG8gX2NtcF9uZXEuDQpBbmQgX2NtcF9lcSB3cmFwcGVy
cyBjb3VsZCBiZSBrZXB0IGZvciBiYWNrd2FyZHMgQVBJIGNvbXBhdGliaWxpdHkuIFBvc3NpYmx5
IG1hcmtlZCBkZXByZWNhdGVkLg0KDQo+IA0KPiA+IFRoZXNlIGhhc2ggY29tcGFyZSBmdW5jdGlv
bnMgYXJlIGluIGZhY3QgIm5lcSIsIG5vdCAiZXEiLg0KPiA+IEhhdmluZyAiX2NtcF9lcSIgaW4g
dGhlIGZ1bmN0aW9uIG5hbWVzIGlzIGV4dHJlbWVseSB1bmZvcnR1bmF0ZSBhbmQNCj4gbWlzbGVh
ZGluZy4NCj4gPg0KPiA+Pg0KPiA+PiBXb3VsZCBpdCBiZSB3b3J0aCBhZGRpbmcgYSBjb21tZW50
IGxpa2UgInVzZSBYT1IgdG8gbWFrZSB0aGlzDQo+ID4+IGJyYW5jaC1mcmVlIj8gSXQgbWF5IG5v
dCBiZSBvYnZpb3VzIHRvIGFsbCByZWFkZXJzLg0KPiA+Pg0KPiA+PiBUaGF0IHNhaWQsIEnigJlt
IG5vdCBzdXJlIHRoaXMgdHJpY2sgd2lsbCBhY3R1YWxseSBjaGFuZ2UgdGhlIGdlbmVyYXRlZA0K
PiA+PiBvYmplY3QgY29kZSAtIGVzcGVjaWFsbHkgaWYgdGhlIHJlc3VsdCBvZiB0aGUgZXEgZnVu
Y3Rpb24gaXMgc3RpbGwgdXNlZA0KPiA+PiBpbiBhIGNvbmRpdGlvbmFsIGFmdGVyd2FyZC4gQW55
d2F5LCBrZWVwaW5nIGl0IHNlZW1zIGxpa2UgYSBnb29kDQo+ID4+IGNvbnNlcnZhdGl2ZSBhcHBy
b2FjaC4NCj4gPg0KPiA+IEkgd29uZGVyIGlmIGFueSBjb21waWxlciBpcyBjbGV2ZXIgZW5vdWdo
IHRvIHVzZSBhIGRpZmZlcmVudCBtZW1jbXANCj4gaW1wbGVtZW50YXRpb24gaWYgd2UgaW5mb3Jt
IHRoZSBjb21waWxlciBhdCBidWlsZCB0aW1lIHRoYXQgd2UgZG9uJ3QgY2FyZSBpZg0KPiBrZXkx
IGlzIGxlc3MgdGhhbiBvciBncmVhdGVyIGtleTIsIG9ubHkgaWYgdGhleSBkaWZmZXIgb3Igbm90
Lg0KPiANCj4gQWxsIHdoYXQgaXMgbmVlZGVkIGlzIGEgY29uc3RhbnQtc2l6ZSBsZW5ndGguIChP
bmx5IHRlc3RlZCB3aXRoIHRoZSBtb3N0DQo+IHJlY2VudCBHQ0MgYW5kIGNsYW5nLikNCg0KWWVz
LiBCdXQgdGhhdCB3YXMgbm90IHdoYXQgSSB3YXMgdGhpbmtpbmcgYWJvdXQuLi4gSSB3YXMgd29u
ZGVyaW5nIGlmICJtZW1jbXAoKSE9MCIgY29tcGlsZXMgdG8gY29kZSB0aGF0IGNhbGxzIHNvbWUg
b3RoZXIgbWVtY21wIGltcGxlbWVudGF0aW9uIHRoYXQgZG9lc24ndCBjaGVjayB3aGljaCBvZiB0
aGUgdHdvIHN0cmluZ3MgaXMgbG93ZXIsIGJ1dCBvbmx5IHRlc3RzIGlmIHRoZXkgZGlmZmVyLg0K
DQo+IA0KPiBBdCBsZWFzdCBHQ0Mgd2lsbCBlbWl0IGEgY21wIGluc3RydWN0aW9uIHRob3VnaCAo
c28gbm90IGJyYW5jaCBmcmVlKSwgaWYNCj4gdGhhdCBtYXR0ZXJzLg0KPiANCj4gPiBJZiBzbywg
dGhlIE9USEVSX0JZVEVTIGhhbmRsZXIgc2hvdWxkbid0IGNhbGwgbWVtY21wKCkgZGlyZWN0bHks
IGJ1dCBhDQo+IHdyYXBwZXIgYXJvdW5kIGl0Og0KPiA+DQo+ID4gcnRlX2hhc2hfa19jbXBfZXEo
Y29uc3Qgdm9pZCAqa2V5MSwgY29uc3Qgdm9pZCAqa2V5Miwgc2l6ZV90IGtleV9sZW4NCj4gX19y
dGVfdW51c2VkKQ0KPiA+IHsNCj4gPiAJcmV0dXJuIG1lbWNtcChrZXkxLCBrZXkyLCBrZXlfbGVu
KSAhPSAwOw0KPiA+IH0NCj4gPg0KPiANCj4gU2hvdWxkIHdvcmsuIChSZW1vdmUgX19ydGVfdW51
c2VkLikNCg0KSSBqdXN0IHRlc3RlZCBpdCBpbiBDb21waWxlciBFeHBsb3JlciwgYW5kIHRoZSBm
dW5jdGlvbiBjYWxscyB0aGUgc2FtZSBtZW1jbXAoKSwgcmVnYXJkbGVzcyBvZiB0aGUgIT0wLg0K
U28gbm8gYmVuZWZpdCBjb21wYXJlZCB0byBjYWxsaW5nIG1lbWNtcCgpIGRpcmVjdGx5IGZyb20g
dGhlIGp1bXAgdGFibGUuDQoNCg==
