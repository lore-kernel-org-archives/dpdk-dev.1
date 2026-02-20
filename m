Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571DCC5AD48
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 18:35:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70A5B402AA;
	Fri, 20 Feb 2026 19:35:35 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 540C44026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 19:35:34 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fHf774Dp0zHnGd1;
 Sat, 21 Feb 2026 02:34:59 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 265E240539;
 Sat, 21 Feb 2026 02:35:32 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Feb 2026 19:35:31 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 20 Feb 2026 19:35:31 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>, Thomas Monjalon
 <thomas@monjalon.net>
CC: "stephen@networkplumber.org" <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>, Su Sai <spiderdetective.ss@gmail.com>
Subject: RE: [v3] net/cksum: compute raw cksum for several segments
Thread-Topic: [v3] net/cksum: compute raw cksum for several segments
Thread-Index: AQHcA53XV6oX7VAYW0CVHDbi9bVUZrRQ+PqAgADFOQCAAgdooIE5M5OQgAAKKwCAABY0YIAADalA
Date: Fri, 20 Feb 2026 18:35:31 +0000
Message-ID: <db2579eb3b0a4476bd53d867ea1a8d04@huawei.com>
References: <20250803090837.15589edd@hermes.local>
 <7c1a559c1d4d4e9bb58c318a95399138@huawei.com>
 <ac1777c39e66443789e6d45fb1b9d7fd@huawei.com> <33965644.t2Qszz9eOc@thomas>
 <f33de0e613c44887a26fe8bf90022d2d@huawei.com>
In-Reply-To: <f33de0e613c44887a26fe8bf90022d2d@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.72.161]
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

PiBJIGNhbiBzdWdnZXN0IG15IGNvbmRpdGlvbiB0byBnZXQgYSB3cm9uZyBjaGVja3N1bSwgd2hp
Y2ggZG9lcyBub3QgZ28gaW50byB0aGUgZGV0YWlscyBvZiBob3cgaXQgd2FzDQo+IG9ic2VydmVk
IGluIHRoZSB3aWxkOg0KPiANCj4gRnVuY3Rpb24gcnRlX3Jhd19ja3N1bV9tYnVmIG1heSBwcm9k
dWNlIGluY29ycmVjdCByZXN1bHQgd2hlbiBtdWx0aXBsZSBzZWdtZW50cyBhcmUgcHJlc2VudCBp
biB0aGUNCj4gY2hlY2tzdW1tZWQgcmFuZ2UsIGFuZCBzb21lIG9mIHRoZW0gaGF2ZSBvZGQgY2hl
Y2tzdW1tZWQgbGVuZ3RoLiBNb3JlIHByZWNpc2VseSwgaWYgYW55IHNlZ21lbnQgZXhjZXB0DQo+
IHRoZSBsYXN0IG9uZSBiZWdpbnMgYXQgYW4gb2RkIG9mZnNldCBmcm9tIHRoZSBzdGFydCwgYW5k
IGFyaXRobWV0aWMgc3VtIG9mIGl0cyAxNi1iaXQgd29yZHMgb3ZlcmZsb3dzLA0KPiB0aGUgcGFy
dCB0aGF0IGhhcyBvdmVyZmxvd24gd2lsbCBiZSBsb3N0LiBDYXNlcyB3aGVuIHRoZXJlIGlzIG9u
bHkgb25lIHNlZ21lbnQsIG9yIGFsbCBvZiB0aGUgc2VnbWVudA0KPiBzaXplcyBhbmQgY2hlY2tz
dW0gb2Zmc2V0cyBhcmUgZXZlbiwgYXJlIG5vdCBhZmZlY3RlZC4NCg0KQXBvbG9naWVzLCBydXNo
ZWQgdG8gc2VuZC4gVGhlICJleGNlcHQgdGhlIGxhc3Qgb25lIiBjb25kaXRpb24gaXMgdW5uZWNl
c3NhcnkuIENvcnJlY3RlZCB2ZXJzaW9uOg0KDQpGdW5jdGlvbiBydGVfcmF3X2Nrc3VtX21idWYg
bWF5IHByb2R1Y2UgaW5jb3JyZWN0IHJlc3VsdCB3aGVuIG11bHRpcGxlIHNlZ21lbnRzIGFyZSBw
cmVzZW50IGluIHRoZSBjaGVja3N1bW1lZCByYW5nZSwgYW5kIHNvbWUgb2YgdGhlbSBoYXZlIG9k
ZCBjaGVja3N1bW1lZCBsZW5ndGguIE1vcmUgcHJlY2lzZWx5LCBpZiBhbnkgc2VnbWVudCBiZWdp
bnMgYXQgYW4gb2RkIG9mZnNldCBmcm9tIHRoZSBzdGFydCwgYW5kIGFyaXRobWV0aWMgc3VtIG9m
IGl0cyAxNi1iaXQgd29yZHMgb3ZlcmZsb3dzLCB0aGUgcGFydCB0aGF0IGhhcyBvdmVyZmxvd24g
d2lsbCBiZSBsb3N0LiBDYXNlcyB3aGVuIHRoZXJlIGlzIG9ubHkgb25lIHNlZ21lbnQsIG9yIGFs
bCBvZiB0aGUgc2VnbWVudCBzaXplcyBhbmQgY2hlY2tzdW0gb2Zmc2V0cyBhcmUgZXZlbiwgYXJl
IG5vdCBhZmZlY3RlZC4gDQo=
