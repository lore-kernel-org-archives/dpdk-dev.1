Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AC2C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 10:15:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17EE14029F;
	Wed, 26 Feb 2025 11:15:20 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 8F5544029A
 for <dev@dpdk.org>; Wed, 26 Feb 2025 11:15:18 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z2r012Ss1z6K9Fk;
 Wed, 26 Feb 2025 18:13:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id A4C6714097D;
 Wed, 26 Feb 2025 18:15:16 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Feb 2025 11:15:16 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 26 Feb 2025 11:15:16 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 2/5] eal: only use numbers as align parameters for MSVC
Thread-Topic: [PATCH v2 2/5] eal: only use numbers as align parameters for MSVC
Thread-Index: AQHbh+rbmRXoHaz940Od/98k6d1Pu7NZXj2A
Date: Wed, 26 Feb 2025 10:15:16 +0000
Message-ID: <62dfa97ba3d04ad1a8321815993c3464@huawei.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740532016-6789-1-git-send-email-andremue@linux.microsoft.com>
 <1740532016-6789-3-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1740532016-6789-3-git-send-email-andremue@linux.microsoft.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.73]
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



> -----Original Message-----
> From: Andre Muezerie <andremue@linux.microsoft.com>
> Sent: Wednesday, February 26, 2025 1:07 AM
> To: andremue@linux.microsoft.com
> Cc: dev@dpdk.org
> Subject: [PATCH v2 2/5] eal: only use numbers as align parameters for MSV=
C
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
> ---
>  lib/eal/x86/include/rte_vect.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/eal/x86/include/rte_vect.h b/lib/eal/x86/include/rte_vec=
t.h
> index 70c78e9b77..0a51c539a4 100644
> --- a/lib/eal/x86/include/rte_vect.h
> +++ b/lib/eal/x86/include/rte_vect.h
> @@ -79,7 +79,16 @@ __extension__ ({                \
>  #define RTE_X86_ZMM_SIZE	(sizeof(__m512i))
>  #define RTE_X86_ZMM_MASK	(RTE_X86_ZMM_SIZE - 1)
>=20
> -typedef union __rte_aligned(RTE_X86_ZMM_SIZE) __rte_x86_zmm {
> +/*
> + * MSVC does not allow __rte_aligned(RTE_X86_ZMM_SIZE). It only accepts
> + * numbers that are power of 2. So, even though RTE_X86_ZMM_SIZE represe=
nts a
> + * number that is a power of two it cannot be used directly.
> + * Ref: https://learn.microsoft.com/en-us/cpp/cpp/align-cpp?view=3Dmsvc-=
170
> + * The static assert below ensures that RTE_X86_ZMM_SIZE is equal to wha=
t is
> + * used in the __rte_aligned() expression.
> + */
> +static_assert(RTE_X86_ZMM_SIZE =3D=3D 64, "Unexpected size of __m512i");
> +typedef union __rte_aligned(64) __rte_x86_zmm {

Just wonder, would then MSVC understand something like:
#define RTE_X86_ZMM_SIZE	64
static_assert(RTE_X86_ZMM_SIZE =3D=3D sizeof((__m512i), "Unexpected size of=
 __m512i");
typedef union __rte_aligned(RTE_X86_ZMM_SIZE) __rte_x86_zmm {
?=20

>  	__m512i	 z;
>  	ymm_t    y[RTE_X86_ZMM_SIZE / sizeof(ymm_t)];
>  	xmm_t    x[RTE_X86_ZMM_SIZE / sizeof(xmm_t)];
> --
> 2.48.1.vfs.0.0

