Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2635C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 11:39:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 871E0402DF;
	Fri,  3 Jul 2026 13:39:13 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 9BAC3402D4
 for <dev@dpdk.org>; Fri,  3 Jul 2026 13:39:12 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gsBb02NMFzJ46b5;
 Fri,  3 Jul 2026 19:38:20 +0800 (CST)
Received: from frapema500001.china.huawei.com (unknown [7.182.19.243])
 by mail.maildlp.com (Postfix) with ESMTPS id C1BB740575;
 Fri,  3 Jul 2026 19:39:11 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500001.china.huawei.com (7.182.19.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 3 Jul 2026 13:39:11 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 3 Jul 2026 13:39:11 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH] test/bpf: remove validation tests from CI
Thread-Topic: [PATCH] test/bpf: remove validation tests from CI
Thread-Index: AQHdCpOjP+hLcrkGmEaD3wdn4zMoLLZbee4AgAAOlgCAACHJoA==
Date: Fri, 3 Jul 2026 11:39:11 +0000
Message-ID: <68a929aed7fb4ce69e8cf81e9d09dfa7@huawei.com>
References: <20260703022738.2574548-1-thomas@monjalon.net>
 <2751fd1fa6d648a9b7f95797f13ef28b@huawei.com>
 <uL3Gmts1SCa1M0sJvOuIOQ@monjalon.net>
In-Reply-To: <uL3Gmts1SCa1M0sJvOuIOQ@monjalon.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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

PiA+IEkgdGhpbmsgSSBrbm93IHRoZSBpc3N1ZSwgaXQncyB0bXBmcyBleGhhdXN0aW9uLiBBZnRl
ciBzb21lIHJlY2VudCBjaGFuZ2VzIGVhY2gNCj4gPiB0ZXN0IGNvbnN1bWVzIDI1TUIgaW4gdGhl
IC0tZmlsZS1wcmVmaXggZGlyZWN0b3J5IGluZGVwZW5kZW50bHksIGVhc2lseSBkcml2aW5nDQo+
ID4gc21hbGwgVk1zIG91dCBvZiBzcGFjZS4gTXkgfjMwIG5ldyB0ZXN0cyB3ZXJlIHRoZSBsYXN0
IGRyb3AgZm9yIHRoZSBDSS4NCj4gDQo+IEkgZG9uJ3Qgd2hldGhlciBpdCB3b3VsZCBpbXByb3Zl
LCBidXQgaXQgaXMgYSBsb3Qgb2YgdGVzdHMsDQo+IGNvdWxkIHlvdSB0YWtlIHRoaXMgb3Bwb3J0
dW5pdHkgdG8gZ3JvdXAgYWxsIEJQRiB2YWxpZGF0aW9uIHRlc3RzDQo+IGluIGEgc2luZ2xlIHJl
Z2lzdGVyZWQgdGVzdD8NCj4gQXQgbGVhc3QgaXQgd291bGQgcmVkdWNlIHRoZSBub2lzZSBpbiB0
ZXN0IHJlcG9ydHMuDQoNClRCSCB3YXN0aW5nIG1hbnkgR0JzIG9mIC9ydW4gZm9yIG5vIHJlYXNv
biBpcyBhIHByb2JsZW0gYW55d2F5Lg0KSSBoYWQgcHJvYmxlbXMgd2l0aCBydW5uaW5nIERQREsg
dGVzdHMgaW4gc21hbGwgY29udGFpbmVycyBhZnRlcg0KLS1maWxlLXByZWZpeCBiZWNhbWUgdGVz
dC1zcGVjaWZpYywgYnV0IGRpZCBub3QgY29ubmVjdCB0aGUgZG90cy4NCg0KSSB3aWxsIHRyeSB0
byBtZXJnZSBuZXcgdGVzdHMgaW50byBvbmUgdG9vIGlmIGl0IGhlbHBzIHRlc3QgcmVwb3J0cw0K
KGhvcGVmdWxseSB0aGV5IHdvbid0IGV4Y2VlZCBmYXN0IHRlc3QgdGltZW91dCBhcyBhIHJlc3Vs
dCkuDQo=
