Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ED0C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 08:29:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19360402D2;
	Mon, 14 Sep 2026 10:29:51 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 54545402C4;
 Mon, 14 Sep 2026 10:29:49 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=EzfeEb3I9dREDXAYxg/PIaQY3YWGhDbHP5yv9ZeXPdc=;
 b=WFOF84IL3W5cZQS+7RiUsNHtSdyXrDlokNZEvYa/8d8izNI2CbpxxwWkekKmBzKbYSQj7dGS3
 Wjtl/qDLFxM6Sm67YyMTX08je/esWaInQWvzFRyPb1vDzvt6Dfk8Z41Zwe09D8s7oFmOckcdsF/
 T9A7gU5Ovav3JPdp3d1+SC0=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hjywg6C0qzJ46DX;
 Mon, 14 Sep 2026 16:28:51 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id C11D940584;
 Mon, 14 Sep 2026 16:29:42 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 09:29:42 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.2562.046; 
 Mon, 14 Sep 2026 09:29:42 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] eal: fix pointer add/sub macros for large offsets values
Thread-Topic: [PATCH] eal: fix pointer add/sub macros for large offsets values
Thread-Index: AQHdQg0LVX5yQmHzGEKGObXHlronG7bNvt2Q
Date: Mon, 14 Sep 2026 08:29:42 +0000
Message-ID: <2ef8efd39dd54b22ae0c007dfa397a99@huawei.com>
References: <20260911164030.2465043-1-bruce.richardson@intel.com>
In-Reply-To: <20260911164030.2465043-1-bruce.richardson@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.159.26]
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



> The macros for adding or subtracting from pointers cast the pointer type
> to uintptr_t before doing the arithmetic. However, for 32-bit builds, if
> the value being added or subtracted is larger than uintptr_t, then we
> get errors when casting back to "void *" type.

But probably error here in such case is a good thing, as it flags an overfl=
ow?
Can't user explicitly convert x then to 32-bit type, if that was an intenti=
on?

> We fix this by casting
> the result to uintptr_t before casting to pointer.
>=20
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  lib/eal/include/rte_common.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
> index f872d3eabb..c17f50e2fd 100644
> --- a/lib/eal/include/rte_common.h
> +++ b/lib/eal/include/rte_common.h
> @@ -572,12 +572,12 @@ static void __attribute__((destructor(RTE_PRIO(prio=
)),
> used)) func(void)
>  /**
>   * add a byte-value offset to a pointer
>   */
> -#define RTE_PTR_ADD(ptr, x) ((void*)((uintptr_t)(ptr) + (x)))
> +#define RTE_PTR_ADD(ptr, x) ((void *)(uintptr_t)((uintptr_t)(ptr) + (x))=
)
>=20
>  /**
>   * subtract a byte-value offset from a pointer
>   */
> -#define RTE_PTR_SUB(ptr, x) ((void *)((uintptr_t)(ptr) - (x)))
> +#define RTE_PTR_SUB(ptr, x) ((void *)(uintptr_t)((uintptr_t)(ptr) - (x))=
)
>=20
>  /**
>   * get the difference between two pointer values, i.e. how far apart
> --
> 2.53.0

