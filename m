Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAB1D62615
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 10:41:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84DB64021F;
	Thu, 22 Jan 2026 11:41:08 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 99B1540156;
 Thu, 22 Jan 2026 11:41:06 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxcz160xRzHnH6g;
 Thu, 22 Jan 2026 18:40:29 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id 5BFAB40574;
 Thu, 22 Jan 2026 18:41:05 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 22 Jan 2026 10:41:04 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 22 Jan 2026 10:41:04 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>, Phil Yang <phil.yang@arm.com>, Gavin Hu
 <gahu@nvidia.com>
Subject: RE: [PATCH v3 03/14] test/mcslock: scale test based on number of cores
Thread-Topic: [PATCH v3 03/14] test/mcslock: scale test based on number of
 cores
Thread-Index: AQHcizm0m04JeWyC9U+dtvYUodSDJLVd/yIA
Date: Thu, 22 Jan 2026 10:41:04 +0000
Message-ID: <a2a269c7f13043d0b948fa67769d88d2@huawei.com>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260122005356.1168221-1-stephen@networkplumber.org>
 <20260122005356.1168221-4-stephen@networkplumber.org>
In-Reply-To: <20260122005356.1168221-4-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.244.196]
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



> This test uses loops to synchronize but has problems on systems
> with high number of cores. Scale iterations to the number of
> cores.
>=20
> Fixes: 32dcb9fd2a22 ("test/mcslock: add MCS queued lock unit test")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_mcslock.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/app/test/test_mcslock.c b/app/test/test_mcslock.c
> index 245df99a5d..b182da72f1 100644
> --- a/app/test/test_mcslock.c
> +++ b/app/test/test_mcslock.c
> @@ -42,6 +42,10 @@ RTE_ATOMIC(rte_mcslock_t *) p_ml_perf;
>=20
>  static unsigned int count;
>=20
> +#define MAX_LOOP_BASE  1000000u
> +#define MAX_LOOP_MIN   10000u
> +static unsigned int max_loop;
> +
>  static RTE_ATOMIC(uint32_t) synchro;
>=20
>  static int
> @@ -60,8 +64,6 @@ test_mcslock_per_core(__rte_unused void *arg)
>=20
>  static uint64_t time_count[RTE_MAX_LCORE] =3D {0};
>=20
> -#define MAX_LOOP 1000000
> -
>  static int
>  load_loop_fn(void *func_param)
>  {
> @@ -78,7 +80,7 @@ load_loop_fn(void *func_param)
>  	rte_wait_until_equal_32((uint32_t *)(uintptr_t)&synchro, 1,
> rte_memory_order_relaxed);
>=20
>  	begin =3D rte_get_timer_cycles();
> -	while (lcount < MAX_LOOP) {
> +	while (lcount < max_loop) {
>  		if (use_lock)
>  			rte_mcslock_lock(&p_ml_perf, &ml_perf_me);
>=20
> @@ -175,6 +177,8 @@ test_mcslock(void)
>  	rte_mcslock_t ml_me;
>  	rte_mcslock_t ml_try_me;
>=20
> +	max_loop =3D test_scale_iterations(MAX_LOOP_BASE, MAX_LOOP_MIN);
> +

Here, and in other similar cases, would it make sense to terminate by timeo=
ut
(i.e. number of cycles passed since start of the test)?
=20

>  	/*
>  	 * Test mcs lock & unlock on each core
>  	 */
> --
> 2.51.0

