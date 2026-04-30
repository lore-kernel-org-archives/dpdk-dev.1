Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFECFF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:53:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FB47402A0;
	Thu, 30 Apr 2026 13:53:12 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id C71CB4021F;
 Thu, 30 Apr 2026 13:53:11 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g5sxW6BR1zJ46YL;
 Thu, 30 Apr 2026 19:53:03 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 0EBAC40569;
 Thu, 30 Apr 2026 19:53:11 +0800 (CST)
Received: from frapema100003.china.huawei.com (7.182.19.100) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Apr 2026 13:53:10 +0200
Received: from frapema100003.china.huawei.com ([7.182.19.100]) by
 frapema100003.china.huawei.com ([7.182.19.100]) with mapi id 15.02.1544.036;
 Thu, 30 Apr 2026 13:53:10 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Weijun Pan <wpan3636@gmail.com>, "stable@dpdk.org" <stable@dpdk.org>,
 Thomas Monjalon <thomas@monjalon.net>, Jerin Jacob <jerinj@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: RE: [PATCH 2/2] test: parenthesize assertion macro parameters
Thread-Topic: [PATCH 2/2] test: parenthesize assertion macro parameters
Thread-Index: AQHc1+cWixQ9khiHkU6S2lgvRDQXmbX3f+lg
Date: Thu, 30 Apr 2026 11:53:10 +0000
Message-ID: <c52612ebd8364fcda06598fcf631ce29@huawei.com>
References: <20260419164818.20609-1-wpan36@wisc.edu>
 <20260429144632.164970-1-stephen@networkplumber.org>
 <20260429144632.164970-3-stephen@networkplumber.org>
In-Reply-To: <20260429144632.164970-3-stephen@networkplumber.org>
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Wednesday 29 April 2026 15:42
> To: dev@dpdk.org
> Cc: Weijun Pan <wpan3636@gmail.com>; stable@dpdk.org; Thomas Monjalon <th=
omas@monjalon.net>; Jerin
> Jacob <jerinj@marvell.com>; Pavan Nikhilesh <pbhagavatula@marvell.com>
> Subject: [PATCH 2/2] test: parenthesize assertion macro parameters
>=20
> From: Weijun Pan <wpan3636@gmail.com>
>=20
> Some test assertion macros use parameters directly in expressions,
> which can lead to unexpected evaluation due to operator precedence
> after macro substitution.
>=20
> Fix this by parenthesizing macro parameters and the resulting
> expressions in rte_test.h
>=20
> Bugzilla ID: 1925
> Fixes: 5afc521eac6a ("eal: add test assert macros")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Weijun Pan <wpan3636@gmail.com>
> ---
>  .mailmap                   |  1 +
>  lib/eal/include/rte_test.h | 12 ++++++------
>  2 files changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/.mailmap b/.mailmap
> index 0e0d83e1c6..a72bba5fb8 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1771,6 +1771,7 @@ Weichun Chen <weichunx.chen@intel.com>
>  Weifeng Li <liweifeng96@126.com>
>  Weiguo Li <liweiguo@xencore.cn> <liwg06@foxmail.com>
>  WeiJie Zhuang <zhuangwj@gmail.com>
> +Weijun Pan <wpan3636@gmail.com> <wpan36@wisc.edu>
>  Weiliang Luo <droidluo@gmail.com>
>  Weiyuan Li <weiyuanx.li@intel.com>
>  Wen Chiu <wchiu@brocade.com>
> diff --git a/lib/eal/include/rte_test.h b/lib/eal/include/rte_test.h
> index 62c8f165af..d132d3156b 100644
> --- a/lib/eal/include/rte_test.h
> +++ b/lib/eal/include/rte_test.h
> @@ -26,21 +26,21 @@
>  } while (0)
>=20
>  #define RTE_TEST_ASSERT_EQUAL(a, b, msg, ...) \
> -	RTE_TEST_ASSERT(a =3D=3D b, msg, ##__VA_ARGS__)
> +	RTE_TEST_ASSERT((a) =3D=3D (b), msg, ##__VA_ARGS__)
>=20
>  #define RTE_TEST_ASSERT_NOT_EQUAL(a, b, msg, ...) \
> -	RTE_TEST_ASSERT(a !=3D b, msg, ##__VA_ARGS__)
> +	RTE_TEST_ASSERT((a) !=3D (b), msg, ##__VA_ARGS__)
>=20
>  #define RTE_TEST_ASSERT_SUCCESS(val, msg, ...) \
> -	RTE_TEST_ASSERT(val =3D=3D 0, msg, ##__VA_ARGS__)
> +	RTE_TEST_ASSERT((val) =3D=3D 0, msg, ##__VA_ARGS__)
>=20
>  #define RTE_TEST_ASSERT_FAIL(val, msg, ...) \
> -	RTE_TEST_ASSERT(val !=3D 0, msg, ##__VA_ARGS__)
> +	RTE_TEST_ASSERT((val) !=3D 0, msg, ##__VA_ARGS__)
>=20
>  #define RTE_TEST_ASSERT_NULL(val, msg, ...) \
> -	RTE_TEST_ASSERT(val =3D=3D NULL, msg, ##__VA_ARGS__)
> +	RTE_TEST_ASSERT((val) =3D=3D NULL, msg, ##__VA_ARGS__)
>=20
>  #define RTE_TEST_ASSERT_NOT_NULL(val, msg, ...) \
> -	RTE_TEST_ASSERT(val !=3D NULL, msg, ##__VA_ARGS__)
> +	RTE_TEST_ASSERT((val) !=3D NULL, msg, ##__VA_ARGS__)
>=20
>  #endif /* _RTE_TEST_H_ */
> --
> 2.53.0

