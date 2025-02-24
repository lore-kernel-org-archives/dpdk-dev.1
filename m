Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA0BC021A6
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 10:04:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94E3F40B9C;
	Mon, 24 Feb 2025 11:04:16 +0100 (CET)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id 190DE40B9C
 for <dev@dpdk.org>; Mon, 24 Feb 2025 11:04:15 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z1bps5RG5z21p29;
 Mon, 24 Feb 2025 18:01:09 +0800 (CST)
Received: from kwepemk100009.china.huawei.com (unknown [7.202.194.57])
 by mail.maildlp.com (Postfix) with ESMTPS id 797FC1A0171;
 Mon, 24 Feb 2025 18:04:13 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 kwepemk100009.china.huawei.com (7.202.194.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 24 Feb 2025 18:04:12 +0800
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 24 Feb 2025 11:04:10 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Fengchengwen <fengchengwen@huawei.com>
Subject: RE: [PATCH v5 08/10] test-pmd: declare lcore_count atomic
Thread-Topic: [PATCH v5 08/10] test-pmd: declare lcore_count atomic
Thread-Index: AQHbhJpSsl+fLX8sx0eHM2Rr4xVtDrNWPVtw
Date: Mon, 24 Feb 2025 10:04:10 +0000
Message-ID: <a9ee27507dfa4a60b1a9d24a19f8cb33@huawei.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740167563-12332-1-git-send-email-andremue@linux.microsoft.com>
 <1740167563-12332-9-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1740167563-12332-9-git-send-email-andremue@linux.microsoft.com>
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



> Subject: [PATCH v5 08/10] test-pmd: declare lcore_count atomic

As a nit, the changes are not in testpmd, bit in the UT.=20
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
=20
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
> index 57cd04a124..921aa902c5 100644
> --- a/app/test/test_ring_perf.c
> +++ b/app/test/test_ring_perf.c
> @@ -34,7 +34,7 @@ struct lcore_pair {
>  	unsigned c1, c2;
>  };
>=20
> -static volatile unsigned lcore_count =3D 0;
> +static volatile RTE_ATOMIC(unsigned int) lcore_count;
>=20
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

