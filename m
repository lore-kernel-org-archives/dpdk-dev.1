Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FB5C021BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 08:39:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89D2640290;
	Thu, 27 Feb 2025 09:39:25 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id AE03F4028C
 for <dev@dpdk.org>; Thu, 27 Feb 2025 09:39:23 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z3Pnt4n4Wz6M53D;
 Thu, 27 Feb 2025 16:36:34 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
 by mail.maildlp.com (Postfix) with ESMTPS id 89A84140442;
 Thu, 27 Feb 2025 16:39:22 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Feb 2025 09:39:22 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 27 Feb 2025 09:39:22 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v3 2/3] eal: only use numbers as align parameters for MSVC
Thread-Topic: [PATCH v3 2/3] eal: only use numbers as align parameters for MSVC
Thread-Index: AQHbiJR0HET0jkbdn0Csz/bmZ1y8WbNa1H2w
Date: Thu, 27 Feb 2025 08:39:22 +0000
Message-ID: <e6ddbd0565b346208b18306b3899466e@huawei.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740604866-6184-1-git-send-email-andremue@linux.microsoft.com>
 <1740604866-6184-3-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1740604866-6184-3-git-send-email-andremue@linux.microsoft.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.174.127]
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



>=20
> After the instruction set updates for MSVC the error below popped up:
>=20
> ..\lib\eal\x86\include\rte_vect.h(82): error C2059: syntax error: '('
>=20
> The issue is that MSVC does not allow __rte_aligned(RTE_X86_ZMM_SIZE).
> It only accepts numbers that are power of 2. So, even though
> RTE_X86_ZMM_SIZE represents a number that is a power of two it cannot
> be used directly.
> https://learn.microsoft.com/en-us/cpp/cpp/align-cpp?view=3Dmsvc-170
>=20
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  lib/eal/x86/include/rte_vect.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/eal/x86/include/rte_vect.h b/lib/eal/x86/include/rte_vec=
t.h
> index 70c78e9b77..9ea158b27e 100644
> --- a/lib/eal/x86/include/rte_vect.h
> +++ b/lib/eal/x86/include/rte_vect.h
> @@ -76,9 +76,18 @@ __extension__ ({                \
>=20
>  #ifdef __AVX512F__
>=20
> -#define RTE_X86_ZMM_SIZE	(sizeof(__m512i))
> +#define RTE_X86_ZMM_SIZE        64
>  #define RTE_X86_ZMM_MASK	(RTE_X86_ZMM_SIZE - 1)
>=20
> +/*
> + * MSVC does not allow __rte_aligned(sizeof(__m512i)). It only accepts
> + * numbers that are power of 2. So, even though sizeof(__m512i) represen=
ts a
> + * number that is a power of two it cannot be used directly.
> + * Ref: https://learn.microsoft.com/en-us/cpp/cpp/align-cpp?view=3Dmsvc-=
170
> + * The static assert below ensures that the hardcoded value defined as
> + * RTE_X86_ZMM_SIZE is equal to sizeof(__m512i).
> + */
> +static_assert(RTE_X86_ZMM_SIZE =3D=3D (sizeof(__m512i)), "Unexpected siz=
e of __m512i");
>  typedef union __rte_aligned(RTE_X86_ZMM_SIZE) __rte_x86_zmm {
>  	__m512i	 z;
>  	ymm_t    y[RTE_X86_ZMM_SIZE / sizeof(ymm_t)];
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.48.1.vfs.0.0

