Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F205CD98F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 19:48:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C02A40276;
	Wed, 17 Jun 2026 21:48:49 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id C48DA40268
 for <dev@dpdk.org>; Wed, 17 Jun 2026 21:48:47 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ggZCv1F2jzHnGdC;
 Thu, 18 Jun 2026 03:48:27 +0800 (CST)
Received: from frapema100004.china.huawei.com (unknown [7.182.19.128])
 by mail.maildlp.com (Postfix) with ESMTPS id 2014040569;
 Thu, 18 Jun 2026 03:48:46 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100004.china.huawei.com (7.182.19.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 21:48:45 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 17 Jun 2026 21:48:45 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: "thomas@monjalon.net" <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: RE: [PATCH v5 00/11] bpf: introduce extensible load API
Thread-Topic: [PATCH v5 00/11] bpf: introduce extensible load API
Thread-Index: AQHc+keGIAnM6Uv4h0OP1TxLH0oxaLY69M0AgAg6hdA=
Date: Wed, 17 Jun 2026 19:48:45 +0000
Message-ID: <952748915ba04062aa508bcb8103d93e@huawei.com>
References: <20260520124922.42445-1-marat.khalili@huawei.com>
 <20260612084219.38399-1-marat.khalili@huawei.com>
 <20260612090636.10d8bf26@phoenix.local>
In-Reply-To: <20260612090636.10d8bf26@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.72.97]
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

PiBEZXRhaWxlZCBBSSByZXZpZXcgZm91bmQgc29tZSBtaW5vciB0aGluZ3M6DQo+IA0KPiAwMi8x
MTogY29tbWVudCBncmFtbWFyIG5pdHMg4oCUICJBbnkgZmVhdHVyZXMgdGhhdCBub3Qga25vd24g
dG8NCj4gdGhlIGFwcGxpY2F0aW9uIiAtPiAidGhhdCBhcmUgbm90IGtub3duIiAodHdpY2UpOyAi
dGhlIHNpemUgb2YNCj4gc2FtZSBzdHJ1Y3QiIC0+ICJ0aGUgc2l6ZSBvZiB0aGUgc2FtZSBzdHJ1
Y3QiLg0KPiANCj4gMDUvMTE6IERveHlnZW4gZm9yIHJ0ZV9icGZfZXRoX3J4X2luc3RhbGwgYW5k
DQo+IHJ0ZV9icGZfZXRoX3R4X2luc3RhbGwgcmVmZXJlbmNlcyBydGVfYnBmX2V0aF91bmxvYWQs
IHdoaWNoIGRvZXMNCj4gbm90IGV4aXN0LiBVc2UgcnRlX2JwZl9ldGhfcnhfdW5sb2FkIGFuZCBy
dGVfYnBmX2V0aF90eF91bmxvYWQNCj4gcmVzcGVjdGl2ZWx5Lg0KPiANCj4gMDcvMTE6IHN0cmF5
IHNwYWNlIGJlZm9yZSBjb21tYSBpbiB0aGUgdGVzdF9icGZfZmlsdGVyIGxvZw0KPiBzdHJpbmcg
KCJmb3IgXCIlc1wiICwiKS4NCg0KU2VudCB2NiB3aXRoIHR5cG9zIGNvcnJlY3RlZC4NCg0KV2ls
bCBub3QgcmUtc2VuZCBkZXBlbmRlbnQgcGF0Y2hzZXQgd2l0aCB1cGRhdGVkIERlcGVuZHMtb24g
DQpGb3Igbm93IHNpbmNlIGl0IGRvZXNuJ3QgZG8gbXVjaCBhbnl3YXkuDQo=
