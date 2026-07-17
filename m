Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B926BC44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 08:30:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2E854028B;
	Fri, 17 Jul 2026 10:30:31 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 4D7604028A
 for <dev@dpdk.org>; Fri, 17 Jul 2026 10:30:31 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=YCA41IZbAYU8HUj3qnYWegzpYCzOqB+KsSg7ul4bxYA=;
 b=wuxQl1s2+UC//KQ9HKatznNOHW+XBTtpPeAdO+Z8uSSq9++9+CsrAFUttOHTmGsjz2EqxxSP7
 NPCPwXaNF7n5hpVpte/w2YGqBOU2Miw21oQi05BEYwOw+aOp+s+8xA+uFF013hshnVolwdD1yB3
 E9QVVx2LUCmZ4vuy5QrYIbY=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h1jlQ61y5zHnGhy;
 Fri, 17 Jul 2026 16:30:10 +0800 (CST)
Received: from frapema100003.china.huawei.com (unknown [7.182.19.100])
 by mail.maildlp.com (Postfix) with ESMTPS id BE0CB40569;
 Fri, 17 Jul 2026 16:30:26 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100003.china.huawei.com (7.182.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 17 Jul 2026 10:30:26 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 17 Jul 2026 10:30:26 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>
Subject: RE: [PATCH v3 8/8] doc: add missing headers to doxy-api-index.md
Thread-Topic: [PATCH v3 8/8] doc: add missing headers to doxy-api-index.md
Thread-Index: AQHdDe3pW2TQu72w4EC9WF5tUtslgbZxSkYAgAAjobA=
Date: Fri, 17 Jul 2026 08:30:26 +0000
Message-ID: <5803e998c8404b5387ba9ef0bcb530b9@huawei.com>
References: <20260706105256.79904-1-marat.khalili@huawei.com>
 <20260707085048.15295-1-marat.khalili@huawei.com>
 <20260707085048.15295-9-marat.khalili@huawei.com>
 <--xEtZJ0Sj2LGPVvl3IDnQ@monjalon.net>
In-Reply-To: <--xEtZJ0Sj2LGPVvl3IDnQ@monjalon.net>
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

PiBJJ20gbm90IHN1cmUgd2Ugc2hvdWxkIGFkZCBhbGwgaW4gdGhpcyBpbmRleCwNCj4gZXNwZWNp
YWxseSB0aGUgKl90cmFjZS5oIHdoaWNoIGFyZSBub3QgcmVhbGx5IGludGVyZXN0aW5nLg0KDQpU
aGVzZSBhcmUgYWxsIHB1YmxpYyBoZWFkZXJzLCBhbGwgb2YgdGhlbSBoYXZlIGEgbWFuIHBhZ2Ug
YW5kIGFuIEhUTUwgZG9jdW1lbnRhdGlvbiBwYWdlIGdlbmVyYXRlZC4gWWV0IHdoZW4gYSB1c2Vy
IGNsaWNrcyBgQVBJIFJlZmVyZW5jZWAgb24gZHBkay5vcmcgdGhleSBhcnJpdmUgaGVyZTogaHR0
cHM6Ly9kb2MuZHBkay5vcmcvYXBpLyAuIFdpdGhvdXQgbGlzdGluZyBhbGwgcHVibGljIGhlYWRl
cnMgdGhpcyBwYWdlIGlzIG1lYW5pbmdsZXNzIGFuZCBtaXNsZWFkaW5nOyB3ZWIgY3Jhd2xlcnMg
Y291bGQgYWxzbyBiZSBjb25mdXNlZCBieSBsYWNrIG9mIGRpcmVjdCBhY2Nlc3MgdG8gaW5uZXIg
cGFnZXMuDQoNCkkgZG9uJ3Qga25vdyBzcGVjaWZpY3Mgb2YgKl90cmFjZS5oIHBhZ2VzLCBtYXli
ZSB0aGV5IGFyZSBzcGVjaWFsIGFuZCBzaG91bGQgbm90IGJlIGV4cG9zZWQuIEluIHRoaXMgY2Fz
ZSB3ZSBjYW4gYWRkIGFuIGV4Y2VwdGlvbiwgYWx0aG91Z2ggSSdkIHJhdGhlciBwdXQgdGhlbSBp
biBhIHNlcGFyYXRlIHNlY3Rpb24gZXhwbGFpbmluZyB3aHkgdGhleSBhcmUgc3BlY2lhbCBhbmQg
bm90IHdvcnRoIGJvdGhlcmluZyB3aXRoLiBBZnRlciBhbGwgdXNlcnMgbWlnaHQgYmUgc2ltaWxh
cmx5IHB1enpsZWQuDQo=
