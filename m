Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E6AC54FDF
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jul 2026 08:16:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7366340274;
	Thu, 30 Jul 2026 10:16:31 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id A339F40272
 for <dev@dpdk.org>; Thu, 30 Jul 2026 10:16:29 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=IaYXy89HbxvdYGgLAI5UEGES4YmE/W8pw2op4J/QXNc=;
 b=VNoHi12uzF5M0Bc/HD1K4Xo0q/LNZy3+RkcP+4IxnyMtU3cXDgmTrNKsJSgx5b/2WKnPJqmGJ
 gCTlzd5Q3f3G6QOltYYL/KGG/B8orr+ziNqgxyDiuiBowAe6UKg470BqoDHTfZw6p8phopDvK8G
 +loMjjI8ayBFBL1tjrJZUMc=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h9hpm5XnFzHnGgH;
 Thu, 30 Jul 2026 16:15:44 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 8CDC440571;
 Thu, 30 Jul 2026 16:16:26 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 30 Jul 2026 09:16:26 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 30 Jul 2026 09:16:26 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: RE: [RFC 13/32] ring: replace SMP read barrier with C11 acquire fence
Thread-Topic: [RFC 13/32] ring: replace SMP read barrier with C11 acquire fence
Thread-Index: AQHdH4O+9cOmsTSw30m7sfiHkIxx1baFt4yQ
Date: Thu, 30 Jul 2026 08:16:26 +0000
Message-ID: <bb96616d436e4761843b8b4b84c923d2@huawei.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260729175715.165120-14-stephen@networkplumber.org>
In-Reply-To: <20260729175715.165120-14-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.197.251]
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



> rte_smp_rmb() is deprecated. The acquire fence generates the same
> code everywhere the gcc implementation is used: a compiler barrier
> on x86 and dmb ishld on ThunderX.
>=20
> The gcc implementation itself is kept: unlike the lock-free stack,
> the in-tree comment records a 10% x86 performance drop with the
> C11 version, which needs re-measuring with current compilers
> before RTE_USE_C11_MEM_MODEL can be removed.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ring/rte_ring_gcc_pvt.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/ring/rte_ring_gcc_pvt.h b/lib/ring/rte_ring_gcc_pvt.h
> index 340ece28c7..9c2c58824d 100644
> --- a/lib/ring/rte_ring_gcc_pvt.h
> +++ b/lib/ring/rte_ring_gcc_pvt.h
> @@ -55,10 +55,10 @@ __rte_ring_headtail_move_head_st(struct
> rte_ring_headtail *d,
>=20
>  	*old_head =3D d->head;
>=20
> -	/* add rmb barrier to avoid load/load reorder in weak
> -	 * memory model. It is noop on x86
> +	/* Acquire fence to avoid load/load reorder in weak
> +	 * memory model. It is noop on x86.
>  	 */
> -	rte_smp_rmb();
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
>=20
>  	/*
>  	 *  The subtraction is done between two unsigned 32bits value
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

As a side note - do we really need two versions of __rte_ring_headtail_move=
_head_st()?
Might be just keep 2 versions of _mt, while _st can be merged into one?

> 2.53.0

