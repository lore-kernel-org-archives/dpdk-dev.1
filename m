Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BD4C02199
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Feb 2025 14:47:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0896F402B7;
	Sun,  9 Feb 2025 15:47:09 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 6DB73402A0
 for <dev@dpdk.org>; Sun,  9 Feb 2025 15:47:07 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YrVrR0127z6K5WC;
 Sun,  9 Feb 2025 22:45:59 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
 by mail.maildlp.com (Postfix) with ESMTPS id 5AE6C140516;
 Sun,  9 Feb 2025 22:47:06 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 9 Feb 2025 15:47:05 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Sun, 9 Feb 2025 15:47:05 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Andre Muezerie <andremue@linux.microsoft.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v6] eal: define __SIZEOF_LONG__ when using MSVC
Thread-Topic: [PATCH v6] eal: define __SIZEOF_LONG__ when using MSVC
Thread-Index: AQHbeXGjgjjkJx6NrEGyWbaeJi/BrrM/Do3Q
Date: Sun, 9 Feb 2025 14:47:05 +0000
Message-ID: <315e3ca94e844571b5e7f9cb629a3d26@huawei.com>
References: <1733342995-3722-2-git-send-email-andremue@linux.microsoft.com>
 <1738940668-21653-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1738940668-21653-1-git-send-email-andremue@linux.microsoft.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.32.250]
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


> Macro __SIZEOF_LONG__ is not standardized and MSVC does not define it.
> Therefore the errors below are seen with MSVC:
>=20
> ../lib/mldev/mldev_utils_scalar.c(465): error C2065:
>     '__SIZEOF_LONG__': undeclared identifier
> ../lib/mldev/mldev_utils_scalar.c(478): error C2051:
>     case expression not constant
>=20
> ../lib/mldev/mldev_utils_scalar_bfloat16.c(33): error C2065:
>     '__SIZEOF_LONG__': undeclared identifier
> ../lib/mldev/mldev_utils_scalar_bfloat16.c(49): error C2051:
>     case expression not constant
>=20
> The fix is to define __SIZEOF_LONG__ in a common header when
> MSVC is used.
>=20
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  lib/eal/windows/include/rte_os.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/lib/eal/windows/include/rte_os.h b/lib/eal/windows/include/r=
te_os.h
> index d09adeb3b4..c787027866 100644
> --- a/lib/eal/windows/include/rte_os.h
> +++ b/lib/eal/windows/include/rte_os.h
> @@ -56,4 +56,9 @@ struct { \
>   */
>  typedef long long ssize_t;
>=20
> +#ifdef RTE_TOOLCHAIN_MSVC
> +#define __SIZEOF_LONG__		(sizeof(long))
> +#define __SIZEOF_LONG_LONG__	(sizeof(long long))
> +#endif
> +
>  #endif /* _RTE_OS_H_ */
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
=20

> 2.47.2.vfs.0.1

