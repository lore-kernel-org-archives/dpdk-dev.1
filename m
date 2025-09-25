Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5103CAC5B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 04:29:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF6B8402BE;
	Thu, 25 Sep 2025 06:29:35 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5DC0A402E0
 for <dev@dpdk.org>; Thu, 25 Sep 2025 06:29:34 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2278D205C8;
 Thu, 25 Sep 2025 06:29:34 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH 1/1] ring: safe partial ordering for head/tail update
Date: Thu, 25 Sep 2025 06:29:32 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65465@smartserver.smartshare.dk>
In-Reply-To: <4cec8b9ca5114f90b8ce1047abdaa936@huawei.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Index: AQHcJnJlB2Gj2xn6O0SOJRCJl7cS/rSWYP5wgABfdICAADf1oP///ZsAgATllsCABXDfAIAApMtQgAARVpCAAACagIAAJIKggAAHFQCAABO1wIAADi0AgAAmfOCAANzOcA==
References: <20250915185451.533039-1-wathsala.vithanage@arm.com>
 <20250915185451.533039-2-wathsala.vithanage@arm.com>
 <a5fae8a9edc947fdbaf4e2519c39f93e@huawei.com>
 <2a611c3cf926d752a54b7655c27d6df874a2d0de.camel@arm.com>
 <61a9d5b157be4816aa296194f9c0eabe@huawei.com>
 <4173E44D-BB31-45B9-AF6A-553B1E755604@arm.com>
 <64a7def62ee642139c3af31ce4fd94e9@huawei.com>
 <EF1C5BFC-B9C7-4D38-8FDC-FF412DD45C21@arm.com>
 <8eab3da6eb2944a4a4a197aeb38ee2f1@huawei.com>
 <d485010b97654d09a1921b97879faf90@huawei.com>
 <71C73931-11EA-4B4C-8FFF-F82A2B2F7520@arm.com>
 <2421eba5de7c4586a7b80dda29078eb2@huawei.com>
 <9B712773-4A39-4D09-9313-1623EE30F209@arm.com>
 <73287d6c09d049aa994a1d17962130b9@huawei.com>
 <BD3A1BB1-B778-46DE-94BA-6E27DA4B0B08@arm.com>
 <4cec8b9ca5114f90b8ce1047abdaa936@huawei.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Ola Liljedahl" <Ola.Liljedahl@arm.com>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Honnappa Nagarahalli" <Honnappa.Nagarahalli@arm.com>
Cc: <dev@dpdk.org>, "Dhruv Tripathi" <Dhruv.Tripathi@arm.com>,
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

SSBoYXZlIGJlZW4gZm9sbG93aW5nIHRoaXMgaW50ZXJlc3RpbmcgZGlzY3Vzc2lvbiwgYW5kIHdh
bnQgdG8gY2xhcmlmeToNCg0KRm9yIGEgZ2VuZXJpYyByaW5nLCBlbnF1ZXVlIGNhbiBmYWlsIGlm
IHRoZSByaW5nIGRvZXNuJ3QgaGF2ZSBzdWZmaWNpZW50IGZyZWUgc3BhY2UsIGFuZCBkZXF1ZXVl
IGNhbiBmYWlsIGlmIGl0IGRvZXNuJ3QgaGF2ZSBzdWZmaWNpZW50IG9iamVjdHMgaW4gcXVldWUu
DQoNCkhvd2V2ZXIsIHdoZW4gYSByaW5nIGlzIHVzZWQgYXMgdGhlIGJhY2tpbmcgc3RvcmUgZm9y
IGEgbWVtcG9vbCwgZW5xdWV1ZSBjYW4gbmV2ZXIgZmFpbC4gKERlcXVldWUgY2FuIHN0aWxsIGZh
aWwgaWYgdGhlIG1lbXBvb2wgaGFzIGJlZW4gZGVwbGV0ZWQuKQ0KDQpUaGUgcmVhc29uIGVucXVl
dWUgaW50byBhIG1lbXBvb2wgcmluZyBjYW4gbmV2ZXIgZmFpbCBpczoNCk9uIGNyZWF0aW9uIG9m
IHRoZSBtZW1wb29sIHJpbmcsIHRoZSBvYmplY3RzIGhlbGQgYnkgdGhlIG1lbXBvb2wgKGUuZy4g
bWJ1ZnMpIGFyZSBhbGxvY2F0ZWQgaW4gbWVtb3J5IGFuZCBlbnF1ZXVlZCBpbnRvIHRoZSByaW5n
LiBJZiB0aGUgbWVtcG9vbCByaW5nIGhhcyBzaXplIFNJWkUsIHRoZW4gU0laRSBvYmplY3RzIGFy
ZSBhbGxvY2F0ZWQgaW4gbWVtb3J5IGFuZCBlbnF1ZXVlZCBpbnRvIHRoZSBtZW1wb29sIHJpbmcu
DQpTbywgc2luY2Ugb25seSBTSVpFIG9iamVjdHMgZXhpc3QgaW4gdGhlIHdob2xlIHdvcmxkLCBh
bmQgdGhlIG1lbXBvb2wgcmluZyBoYXMgc2l6ZSBTSVpFLCBlbnF1ZXVlIG9mIHRob3NlIG9iamVj
dHMgaW50byB0aGUgbWVtcG9vbCByaW5nIGNhbm5vdCBmYWlsLCBhbmQgdGhlIG1lbXBvb2wgInB1
dCIgQVBJIHJlZmxlY3RzIHRoaXMuDQoNCk5vdGUgdGhhdCB0aGlzIGlzIGEgcmVxdWlyZW1lbnQg
Zm9yIHRoZSBtZW1wb29sIEFQSSwgbm90IHRoZSByaW5nIEFQSS4NClNvLCBpZiB0aGUgcmluZyBB
UEkgZG9lc24ndCBwcm92aWRlIHRoaXMgZ3VhcmFudGVlICh0aGF0IGlmIG9ubHkgU0laRSBvYmpl
Y3RzIGV4aXN0LCBlbnF1ZXVlIGNhbm5vdCBmYWlsKSwgdGhlbiB0aGlzIGd1YXJhbnRlZSBjb3Vs
ZCBiZSBpbXBsZW1lbnRlZCBpbiB0aGUgbWVtcG9vbCBsaWJyYXJ5IHdoZXJlIGl0IGludGVyZmFj
ZXMgdG8gdGhlIHJpbmcgImVucXVldWUiIEFQSSAoaW5zdGVhZCBvZiBoYXZpbmcgdGhlIHJpbmcg
QVBJIHByb3ZpZGUgdGhpcyBndWFyYW50ZWUpLg0KDQpIb3dldmVyLCBvdGhlciBsaWJyYXJpZXMg
b3IgYXBwbGljYXRpb25zIG1pZ2h0IGFzc3VtZSB0aGUgc2FtZSBndWFyYW50ZWUgZm9yIGEgcmlu
ZyB3aGVuIG5vIG1vcmUgdGhhbiBTSVpFIG9iamVjdHMgZXhpc3QuIChJIGRvbid0IGtub3chKSBJ
ZiB0aGlzIGlzIHRoZSBjYXNlLCB0aGVuIGl0IGlzIGEgcmluZyBBUEkgcmVxdWlyZW1lbnQsIG5v
dCBqdXN0IGEgbWVtcG9vbCBBUEkgcmVxdWlyZW1lbnQuDQpPbmUgcG9zc2libGUgc29sdXRpb24g
dG8gdGhpcyBjb3VsZCBiZSBvZmZlcmluZyB0d28gcmluZyBlbnF1ZXVlIEFQSXMsIGEgImZhc3Qi
IEFQSSB3aXRob3V0IHRoZSBndWFyYW50ZWUgYW5kIGEgInNhZmUiIEFQSSB3aXRoIHRoZSBndWFy
YW50ZWUuDQpTb21ld2hhdCBsaWtlIHRoZSBpdGVyYXRpb24gbWFjcm9zIGZvciBsaW5rZWQgbGlz
dHM6IGZvcmVhY2goKSBhbmQgZm9yZWFjaF9zYWZlKCkuDQoNCg==
