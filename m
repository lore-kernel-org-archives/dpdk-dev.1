Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7538C5AD4D
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 18:17:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3508402AA;
	Fri, 20 Feb 2026 19:17:36 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id B97414026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 19:17:34 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fHdkN474xzHnGcw;
 Sat, 21 Feb 2026 02:17:00 +0800 (CST)
Received: from frapema100003.china.huawei.com (unknown [7.182.19.100])
 by mail.maildlp.com (Postfix) with ESMTPS id 1D02740539;
 Sat, 21 Feb 2026 02:17:33 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100003.china.huawei.com (7.182.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 20 Feb 2026 19:17:32 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 20 Feb 2026 19:17:32 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "stephen@networkplumber.org" <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>, Su Sai <spiderdetective.ss@gmail.com>
Subject: RE: [v3] net/cksum: compute raw cksum for several segments
Thread-Topic: [v3] net/cksum: compute raw cksum for several segments
Thread-Index: AQHcA53XV6oX7VAYW0CVHDbi9bVUZrRQ+PqAgADFOQCAAgdooIE5M5OQgAAKKwCAABY0YA==
Date: Fri, 20 Feb 2026 18:17:32 +0000
Message-ID: <f33de0e613c44887a26fe8bf90022d2d@huawei.com>
References: <20250803090837.15589edd@hermes.local>
 <7c1a559c1d4d4e9bb58c318a95399138@huawei.com>
 <ac1777c39e66443789e6d45fb1b9d7fd@huawei.com> <33965644.t2Qszz9eOc@thomas>
In-Reply-To: <33965644.t2Qszz9eOc@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.74]
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

PiBJIGRpZG4ndCB0YWtlIHRpbWUgdG8gcmV2aWV3IHRoZSBmdWxsIGV4cGxhbmF0aW9uIGFuZCBj
b2RlLg0KPiANCj4gUGxlYXNlIGNvdWxkIHlvdSByZXZpZXc/DQo+IA0KPiBodHRwczovL2luYm94
LmRwZGsub3JnL2Rldi9DQUZRZW9LaThXOFdBWVVZMU91U24rcU1nRzFjMlY3UGpMakVINjA4bTg5
NFRwTE9WdndAbWFpbC5nbWFpbC5jb20vDQo+IA0KDQpJIGNhbiBzdWdnZXN0IG15IGNvbmRpdGlv
biB0byBnZXQgYSB3cm9uZyBjaGVja3N1bSwgd2hpY2ggZG9lcyBub3QgZ28gaW50byB0aGUgZGV0
YWlscyBvZiBob3cgaXQgd2FzIG9ic2VydmVkIGluIHRoZSB3aWxkOg0KDQpGdW5jdGlvbiBydGVf
cmF3X2Nrc3VtX21idWYgbWF5IHByb2R1Y2UgaW5jb3JyZWN0IHJlc3VsdCB3aGVuIG11bHRpcGxl
IHNlZ21lbnRzIGFyZSBwcmVzZW50IGluIHRoZSBjaGVja3N1bW1lZCByYW5nZSwgYW5kIHNvbWUg
b2YgdGhlbSBoYXZlIG9kZCBjaGVja3N1bW1lZCBsZW5ndGguIE1vcmUgcHJlY2lzZWx5LCBpZiBh
bnkgc2VnbWVudCBleGNlcHQgdGhlIGxhc3Qgb25lIGJlZ2lucyBhdCBhbiBvZGQgb2Zmc2V0IGZy
b20gdGhlIHN0YXJ0LCBhbmQgYXJpdGhtZXRpYyBzdW0gb2YgaXRzIDE2LWJpdCB3b3JkcyBvdmVy
Zmxvd3MsIHRoZSBwYXJ0IHRoYXQgaGFzIG92ZXJmbG93biB3aWxsIGJlIGxvc3QuIENhc2VzIHdo
ZW4gdGhlcmUgaXMgb25seSBvbmUgc2VnbWVudCwgb3IgYWxsIG9mIHRoZSBzZWdtZW50IHNpemVz
IGFuZCBjaGVja3N1bSBvZmZzZXRzIGFyZSBldmVuLCBhcmUgbm90IGFmZmVjdGVkLg0K
