Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF26C021B5
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 08:40:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED8E440647;
	Fri, 21 Feb 2025 09:40:25 +0100 (CET)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by mails.dpdk.org (Postfix) with ESMTP id 42AE84029A
 for <dev@dpdk.org>; Fri, 21 Feb 2025 09:40:24 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Yzk3f052wz1GBx3;
 Fri, 21 Feb 2025 16:35:42 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
 by mail.maildlp.com (Postfix) with ESMTPS id 7F5E21400CA;
 Fri, 21 Feb 2025 16:40:20 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 kwepemk500007.china.huawei.com (7.202.194.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Feb 2025 16:40:19 +0800
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 21 Feb 2025 09:40:17 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Fengchengwen <fengchengwen@huawei.com>
Subject: RE: [PATCH v4 08/10] test-pmd: declare lcore_count atomic
Thread-Topic: [PATCH v4 08/10] test-pmd: declare lcore_count atomic
Thread-Index: AQHbg97ohkNrLPQyCki13NulL+Yfq7NRb4BA
Date: Fri, 21 Feb 2025 08:40:17 +0000
Message-ID: <b6eaefbdba2c46228c1330d2afb81d3f@huawei.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740087064-18680-1-git-send-email-andremue@linux.microsoft.com>
 <1740087064-18680-9-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1740087064-18680-9-git-send-email-andremue@linux.microsoft.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.35.11]
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



> Compiling with MSVC results in the error below:
>=20
> app/test/test_ring_perf.c(197): error C7712: address argument to atomic
>     operation must be a pointer to an atomic integer,
>     'volatile unsigned int *' is not valid
>=20
> The fix is to mark lcore_count as atomic.
>=20
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  app/test/test_ring_perf.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/app/test/test_ring_perf.c b/app/test/test_ring_perf.c
> index 57cd04a124..366e256323 100644
> --- a/app/test/test_ring_perf.c
> +++ b/app/test/test_ring_perf.c
> @@ -34,7 +34,7 @@ struct lcore_pair {
>  	unsigned c1, c2;
>  };
>=20
> -static volatile unsigned lcore_count =3D 0;
> +static RTE_ATOMIC(unsigned int) lcore_count;

But for not-MSVC builds RTE_ATOMIC() by default means nothing.
If you are removing volatile, then I think, you need to fix the code to ens=
ure
that all reads/writes to this var are done with atomic ops.
Or have both -  volatile and RTE_ATOMIC()


>  static void
>  test_ring_print_test_string(unsigned int api_type, int esize,
> @@ -193,11 +193,7 @@ enqueue_dequeue_bulk_helper(const unsigned int flag,=
 struct thread_params *p)
>  	unsigned int n_remaining;
>  	const unsigned int bulk_n =3D bulk_sizes[p->ring_params->bulk_sizes_i];
>=20
> -#ifdef RTE_USE_C11_MEM_MODEL
>  	if (rte_atomic_fetch_add_explicit(&lcore_count, 1, rte_memory_order_rel=
axed) + 1 !=3D 2)
> -#else
> -	if (__sync_add_and_fetch(&lcore_count, 1) !=3D 2)
> -#endif
>  		while(lcore_count !=3D 2)
>  			rte_pause();
>=20
> --
> 2.48.1.vfs.0.0
>=20

