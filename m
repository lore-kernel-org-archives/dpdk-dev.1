Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374A6FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 12:31:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E86E40151;
	Wed, 29 Apr 2026 14:31:56 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 27B82400EF
 for <dev@dpdk.org>; Wed, 29 Apr 2026 14:31:54 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g5Grg0hzjzJ46C9
 for <dev@dpdk.org>; Wed, 29 Apr 2026 20:31:47 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id A740A40584
 for <dev@dpdk.org>; Wed, 29 Apr 2026 20:31:52 +0800 (CST)
Received: from frapema100003.china.huawei.com (7.182.19.100) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Apr 2026 14:31:46 +0200
Received: from frapema100003.china.huawei.com ([7.182.19.100]) by
 frapema100003.china.huawei.com ([7.182.19.100]) with mapi id 15.02.1544.036;
 Wed, 29 Apr 2026 14:31:41 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Weijun Pan <wpan3636@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2] test: parenthesize assertion macro parameters
Thread-Topic: [PATCH v2] test: parenthesize assertion macro parameters
Thread-Index: AQHc177dznSDd8kMWESYre7AOswU8LX1+DSA
Date: Wed, 29 Apr 2026 12:31:41 +0000
Message-ID: <ff686c47deab445eb5ac06fb33352874@huawei.com>
References: <20260419164818.20609-1-wpan36@wisc.edu>
 <20260427171714.9887-1-wpan3636@gmail.com>
In-Reply-To: <20260427171714.9887-1-wpan3636@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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

Acked-by: Marat Khalili <marat.khalili@huawei.com>

> -----Original Message-----
> From: Weijun Pan <wpan3636@gmail.com>
> Sent: Monday 27 April 2026 18:17
> Cc: dev@dpdk.org; Weijun Pan <wpan3636@gmail.com>
> Subject: [PATCH v2] test: parenthesize assertion macro parameters
>=20
> Some test assertion macros use parameters directly in expressions,
> which can lead to unexpected evaluation due to operator precedence
> after macro substitution.
>=20
> Fix this by parenthesizing macro parameters and the resulting
> expressions in rte_test.h and app/test/test.h.
>=20
> This is a test macro robustness fix and does not fix a runtime issue
> in DPDK, so no Fixes or stable tags are added.
>=20
> Bugzilla ID: 1925
>=20
> Signed-off-by: Weijun Pan <wpan3636@gmail.com>
>=20
> ---
> v2:
> - Remove unnecessary parentheses surrounded by commas
> - Keep parenthesize substitutions even in unambiguous places in rte_test.=
h
>   to maintain coding style: parenthesize a condition
> - Keep msg unparenthesized to preserve string literal concatenation
> ---
>  app/test/test.h            | 30 +++++++++++++++---------------
>  lib/eal/include/rte_test.h | 12 ++++++------
>  2 files changed, 21 insertions(+), 21 deletions(-)
>=20
