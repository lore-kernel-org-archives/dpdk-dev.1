Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849D7C44514
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 08:18:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1B084028B;
	Fri, 17 Jul 2026 10:18:47 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 4D67A4028A
 for <dev@dpdk.org>; Fri, 17 Jul 2026 10:18:46 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Xn87Cs+sKEnrN5+ZwTHQgWcb86MEY+eTBO9Cx8CMQ90=;
 b=X3NTArdOz4SfFGOZ2RKFDd1Y1M8zjPHXcucrKhEjEuWpRp/CKkmOwqUoIBB/6npYVZnHdb1TZ
 oTJAm1M5Xk3WecT+uxY5E9akRqtaj0vgg+YH6TXtsGCLwJNedImIkUqS8jtcTMYl4xo65aibmbS
 xfqPiyS8JVd4EchgZRt/Z7c=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h1jTv4hZWzJ46Dn;
 Fri, 17 Jul 2026 16:18:27 +0800 (CST)
Received: from frapema500002.china.huawei.com (unknown [7.182.19.148])
 by mail.maildlp.com (Postfix) with ESMTPS id F00F84058B;
 Fri, 17 Jul 2026 16:18:40 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500002.china.huawei.com (7.182.19.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Jul 2026 10:18:40 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 17 Jul 2026 10:18:40 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH v3 6/8] doc: add missing globs to doxy-api.conf.in
Thread-Topic: [PATCH v3 6/8] doc: add missing globs to doxy-api.conf.in
Thread-Index: AQHdDe3ir2tqAGy+P0qQQH63+ayNk7ZxSaCAgAAjsHA=
Date: Fri, 17 Jul 2026 08:18:40 +0000
Message-ID: <3146b71600564d1fb36690091a1c5d6f@huawei.com>
References: <20260706105256.79904-1-marat.khalili@huawei.com>
 <20260707085048.15295-1-marat.khalili@huawei.com>
 <20260707085048.15295-7-marat.khalili@huawei.com>
 <89E6AkFFQ-mRyIB3PXdwvg@monjalon.net>
In-Reply-To: <89E6AkFFQ-mRyIB3PXdwvg@monjalon.net>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgTW9uamFsb24gPHRo
b21hc0Btb25qYWxvbi5uZXQ+DQo+IFNlbnQ6IEZyaWRheSAxNyBKdWx5IDIwMjYgMDk6MDkNCj4g
VG86IE1hcmF0IEtoYWxpbGkgPG1hcmF0LmtoYWxpbGlAaHVhd2VpLmNvbT4NCj4gQ2M6IGRldkBk
cGRrLm9yZzsgYnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb207IEtvbnN0YW50aW4gQW5hbnlldiA8
a29uc3RhbnRpbi5hbmFueWV2QGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMg
Ni84XSBkb2M6IGFkZCBtaXNzaW5nIGdsb2JzIHRvIGRveHktYXBpLmNvbmYuaW4NCj4gDQo+IDA3
LzA3LzIwMjYgMTA6NTAsIE1hcmF0IEtoYWxpbGk6DQo+ID4gUHVibGljIGhlYWRlcnMgc3RhcnRp
bmcgZnJvbSBgY21kbGluZWAgKGV4Y2VwdCBmb3IgYGNtZGxpbmUuaGAgaXRzZWxmKQ0KPiA+IGFu
ZCBgYnBmX2RlZi5oYCB3ZXJlIG5vdCBwcmV2aW91c2x5IGluY2x1ZGVkIGluIHRoZSBkb2N1bWVu
dGF0aW9uIGJ1aWxkLg0KPiANCj4gV2h5IGJwZl9kZWYuaCBpcyBub3QgcHJlZml4ZWQgd2l0aCAi
cnRlXyIgPw0KDQpJIGRvbid0IGtub3cgaGlzdG9yaWNhbCByZWFzb25zLCBidXQgSSB3b3VsZCBh
ZGQgdGhpcyAicnRlXyIgcHJlZml4LiBBcyBmYXIgYXMgSSB1bmRlcnN0YW5kIDI2LjExIGlzIHRo
ZSBuZXh0IG9wcG9ydHVuaXR5IHRvIGRvIGl0LCByaWdodD8NCg==
