Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1835FCB60B
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 15:17:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA2BA40A80;
	Fri,  6 Mar 2026 16:17:37 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 7983440262
 for <dev@dpdk.org>; Fri,  6 Mar 2026 16:17:36 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fS93m25H6zHnH3h;
 Fri,  6 Mar 2026 23:16:36 +0800 (CST)
Received: from frapema100004.china.huawei.com (unknown [7.182.19.128])
 by mail.maildlp.com (Postfix) with ESMTPS id 34B2340569;
 Fri,  6 Mar 2026 23:17:36 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100004.china.huawei.com (7.182.19.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 6 Mar 2026 16:17:35 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 6 Mar 2026 16:17:35 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "stephen@networkplumber.org" <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>, Su Sai <spiderdetective.ss@gmail.com>
Subject: RE: [v3] net/cksum: compute raw cksum for several segments
Thread-Topic: [v3] net/cksum: compute raw cksum for several segments
Thread-Index: AQHcA53XV6oX7VAYW0CVHDbi9bVUZrRQ+PqAgADFOQCAAgdooIE5M5OQgAAKKwCAABY0YIAADalAgBXHszA=
Date: Fri, 6 Mar 2026 15:17:35 +0000
Message-ID: <441935c548424cc1964f6fb237c085f9@huawei.com>
References: <20250803090837.15589edd@hermes.local>
 <7c1a559c1d4d4e9bb58c318a95399138@huawei.com>
 <ac1777c39e66443789e6d45fb1b9d7fd@huawei.com> <33965644.t2Qszz9eOc@thomas>
 <f33de0e613c44887a26fe8bf90022d2d@huawei.com>
 <db2579eb3b0a4476bd53d867ea1a8d04@huawei.com>
In-Reply-To: <db2579eb3b0a4476bd53d867ea1a8d04@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: thomas@monjalon.net
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
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

PiBGdW5jdGlvbiBydGVfcmF3X2Nrc3VtX21idWYgbWF5IHByb2R1Y2UgaW5jb3JyZWN0IHJlc3Vs
dCB3aGVuIG11bHRpcGxlIHNlZ21lbnRzIGFyZSBwcmVzZW50IGluIHRoZQ0KPiBjaGVja3N1bW1l
ZCByYW5nZSwgYW5kIHNvbWUgb2YgdGhlbSBoYXZlIG9kZCBjaGVja3N1bW1lZCBsZW5ndGguIE1v
cmUgcHJlY2lzZWx5LCBpZiBhbnkgc2VnbWVudCBiZWdpbnMNCj4gYXQgYW4gb2RkIG9mZnNldCBm
cm9tIHRoZSBzdGFydCwgYW5kIGFyaXRobWV0aWMgc3VtIG9mIGl0cyAxNi1iaXQgd29yZHMgb3Zl
cmZsb3dzLCB0aGUgcGFydCB0aGF0IGhhcw0KPiBvdmVyZmxvd24gd2lsbCBiZSBsb3N0LiBDYXNl
cyB3aGVuIHRoZXJlIGlzIG9ubHkgb25lIHNlZ21lbnQsIG9yIGFsbCBvZiB0aGUgc2VnbWVudCBz
aXplcyBhbmQgY2hlY2tzdW0NCj4gb2Zmc2V0cyBhcmUgZXZlbiwgYXJlIG5vdCBhZmZlY3RlZC4N
Cg0KSGkgYWdhaW4gZm9sa3MsIGFueXRoaW5nIGVsc2UgbmVlZGVkIGhlcmU/IFRoZXJlIGlzIGEg
dGVzdCwgYSBmaXgsIGFuZCBjb25kaXRpb25zIGZvciB0aGUgaXNzdWUuDQooTm8gcHJvYmxlbSBp
ZiBpdCBvbmx5IG5lZWRzIHRpbWUuKQ0KDQpCVFcgYXQgbGVhc3QgR2VtaW5pIFBybyBpcyBhYmxl
IHRvIHNlZSB0aGlzIGJ1ZyAobWF5YmUgcHJpbWVkIGJ5IG91ciBjb252ZXJzYXRpb24pIGFuZCBy
ZWFzb24gYWJvdXQgaXQuDQo=
