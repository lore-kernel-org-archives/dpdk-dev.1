Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587F3C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 15:30:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0695427E4;
	Thu, 13 Aug 2026 17:30:54 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 14524402D3
 for <dev@dpdk.org>; Thu, 13 Aug 2026 17:30:54 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E6579206E1;
 Thu, 13 Aug 2026 17:30:52 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: RE: [RFC v4 2/3] lib: add fastmem library
Content-Transfer-Encoding: base64
Date: Thu, 13 Aug 2026 17:30:50 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659E3@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC v4 2/3] lib: add fastmem library
Thread-Index: AdzwFnduO8ADyuMOTX+x0l7ZVybrXQ6+qRFgAAm/rFA=
References: <20260527173042.93867-2-hofors@lysator.liu.se>
 <20260530092634.46218-1-hofors@lysator.liu.se>
 <20260530092634.46218-3-hofors@lysator.liu.se> 
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <hofors@lysator.liu.se>,
 <dev@dpdk.org>
Cc: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>,
 "Yogaraj Baskaravel" <yogaraj.baskaravel@ericsson.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>
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

PiBJbml0aWFsaXphdGlvbiBzaG91bGQgYmUgZG9uZSBhdCB0aGUgcHJvcGVyIERQREsgc3RhcnR1
cCBzdGFnZSwgbm90DQo+IGxhemlseSBhdCBhbGwgZmFzdG1lbSBmdW5jdGlvbnMuDQo+IEluIHRo
ZSBmYXN0bWVtIGZ1bmN0aW9ucywgY2FsbGluZyBmYXN0bWVtX2Fzc3VyZSgpIHNob3VsZCBiZSBy
ZXBsYWNlZA0KPiBieSBhIHNpbXBsZSBSVEVfQVNTRVJUKGZhc3RtZW0gIT0gTlVMTCkuDQo+IA0K
PiBJIHdhcyB3b25kZXJpbmcgaG93IGRvIG90aGVyIGxpYnMgaGFuZGxlIHRoZSBzaXR1YXRpb24g
d2hlcmUgYQ0KPiBzZWNvbmRhcnkgcHJvY2VzcyBkZXBlbmRzIG9uIGluaXQgcGVyZm9ybWVkIGJ5
IHRoZSBwcmltYXJ5IGZ1bmN0aW9uPw0KPiBJdCBsb29rcyBsaWtlIHRoZXkgZG8gc29tZXRoaW5n
IHNpbWlsaWFyIHRvIGZhc3RtZW1fYXNzdXJlKCkuIFRoaXMNCj4gc3Vja3MhDQo+IFRoYXQncyBh
biBpbXBvcnRhbnQgZmVhdHVyZSBnYXAgaW4gRFBESywgd2hpY2ggSSBhbHJlYWR5IHJlZ2lzdGVy
ZWQgYXMNCj4gYSBidWcgb24gdGhlIHdpc2hsaXN0OiBodHRwczovL2J1Z3MuZHBkay5vcmcvc2hv
d19idWcuY2dpP2lkPTE5MTMNCj4gDQo+IFVudGlsIHdlIGdldCB0aGF0IHdpc2ggZml4ZWQsIHdl
IHNob3VsZCBtYWtlIGVhbCBkZXBlbmQgb24gZmFzdG1lbSwgYW5kDQo+IGNhbGwgdGhlIGZhc3Rt
ZW0gaW5pdCBmdW5jdGlvbiBmcm9tIGluc2lkZSBydGVfZWFsX2luaXQoKS4NCg0KT3IgbWF5YmUg
anVzdCBrZWVwIHRoZSBsYXp5LWluaXQgZm9yIG5vdywgc28gd2UgZG9uJ3QgaGF2ZSB0byBkaXNj
dXNzIEVBTCBkZXBlbmRlbmNpZXMuDQpZb3Ugc2FpZCBpdDogIlBhdGggb2YgbGVhc3QgcmVzaXN0
YW5jZS4iDQoNCldlIGNhbiBzd2l0Y2ggdG8gc3RhcnR1cC1pbml0IGxhdGVyLCBhbmQgZWxpbWlu
YXRlIHRoZSBsYXp5LWluaXQgY29zdCB0aGVuLg0KDQo=
