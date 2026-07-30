Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B52C531D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jul 2026 07:25:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 796C840274;
	Thu, 30 Jul 2026 09:25:34 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id A474A40272
 for <dev@dpdk.org>; Thu, 30 Jul 2026 09:25:32 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=KRLhvwCjlpGMijVF9xjWPv9zSHhDkBOcfz5kWmVHUDE=;
 b=6E1OaUcSblMJ1AaWqrGDCOA9S4YpjR60+DUk0tbafc7P4AD8wQtPNRshgrRBOl19BWIyC+Q4o
 Jdepwuf9VqczlbKsTMZ4ETAMKeU53I8n/49BU3wsH7e/RvR0dmfEGwVIdR5F4PLmMwM0pXyFwD8
 b2cl9hAE2+EJAdrRrUYyCp0=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h9gh638CBzJ46Ds;
 Thu, 30 Jul 2026 15:24:54 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id 2890640574;
 Thu, 30 Jul 2026 15:25:29 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 30 Jul 2026 08:25:28 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 30 Jul 2026 08:25:28 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [RFC 02/32] test: remove test for rte_smp_mb
Thread-Topic: [RFC 02/32] test: remove test for rte_smp_mb
Thread-Index: AQHdH4PD76TpYwnrEUKY4hrTLRUvnLaFqKQg
Date: Thu, 30 Jul 2026 07:25:28 +0000
Message-ID: <6cc178b410da423d96e80e98eb444231@huawei.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260729175715.165120-3-stephen@networkplumber.org>
In-Reply-To: <20260729175715.165120-3-stephen@networkplumber.org>
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



> The DPDK version of SMP barriers is deprecated and
> being removed. Drop the test as no longer relevant.

Why to remove the whole test?=20
I believe it is still useful for testing our custom x86 implementation
of rte_atomic_thread_fence(rte_memory_order_seq_cst).
See patch 17 in this series:
[RFC 17/32] eal/x86: move optimized fence out of SMP barrier
Instead of removing it we can replace rte_smp_mb() with
rte_atomic_thread_fence(rte_memory_order_seq_cst)
In one function below, i.e.:=20

static inline void
store_load_barrier(uint32_t utype)
{
	if (utype =3D=3D USE_MB)
		rte_mb();
	else if (utype =3D=3D USE_SMP_MB)
 -		rte_smp_mb();
+		rte_atomic_thread_fence(rte_memory_order_seq_cst);
	else
		RTE_VERIFY(0);
}

> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/meson.build    |   1 -
>  app/test/test_barrier.c | 288 ----------------------------------------
>  2 files changed, 289 deletions(-)
>  delete mode 100644 app/test/test_barrier.c
>=20
> diff --git a/app/test/meson.build b/app/test/meson.build
> index 51abeeb732..6df9dfa222 100644
> --- a/app/test/meson.build
> +++ b/app/test/meson.build
> @@ -28,7 +28,6 @@ source_file_deps =3D {
>      'test_alarm.c': [],
>      'test_argparse.c': ['argparse'],
>      'test_atomic.c': ['hash'],
> -    'test_barrier.c': [],
>      'test_bitcount.c': [],
>      'test_bitmap.c': [],
>      'test_bitops.c': [],
> diff --git a/app/test/test_barrier.c b/app/test/test_barrier.c
> deleted file mode 100644
> index 925a88b68a..0000000000
> --- a/app/test/test_barrier.c
> +++ /dev/null
> @@ -1,288 +0,0 @@
> -/* SPDX-License-Identifier: BSD-3-Clause
> - * Copyright(c) 2010-2018 Intel Corporation
> - */
> -
> - /*
> -  * This is a simple functional test for rte_smp_mb() implementation.
> -  * I.E. make sure that LOAD and STORE operations that precede the
> -  * rte_smp_mb() call are globally visible across the lcores
> -  * before the LOAD and STORE operations that follows it.
> -  * The test uses simple implementation of Peterson's lock algorithm
> -  * (https://en.wikipedia.org/wiki/Peterson%27s_algorithm)
> -  * for two execution units to make sure that rte_smp_mb() prevents
> -  * store-load reordering to happen.
> -  * Also when executed on a single lcore could be used as a approximate
> -  * estimation of number of cycles particular implementation of rte_smp_=
mb()
> -  * will take.
> -  */
> -
> -#include <stdio.h>
> -#include <string.h>
> -#include <stdint.h>
> -#include <inttypes.h>
> -
> -#include <rte_memory.h>
> -#include <rte_per_lcore.h>
> -#include <rte_launch.h>
> -#include <rte_eal.h>
> -#include <rte_lcore.h>
> -#include <rte_pause.h>
> -#include <rte_random.h>
> -#include <rte_cycles.h>
> -#include <rte_vect.h>
> -#include <rte_debug.h>
> -
> -#include "test.h"
> -
> -#define ADD_MAX		8
> -#define ITER_MAX	0x1000000
> -
> -enum plock_use_type {
> -	USE_MB,
> -	USE_SMP_MB,
> -	USE_NUM
> -};
> -
> -struct plock {
> -	volatile uint32_t flag[2];
> -	volatile uint32_t victim;
> -	enum plock_use_type utype;
> -};
> -
> -/*
> - * Lock plus protected by it two counters.
> - */
> -struct plock_test {
> -	struct plock lock;
> -	uint64_t val;
> -	uint64_t iter;
> -};
> -
> -/*
> - * Each active lcore shares plock_test struct with it's left and right
> - * neighbours.
> - */
> -struct lcore_plock_test {
> -	struct plock_test *pt[2]; /* shared, lock-protected data */
> -	uint64_t sum[2];          /* local copy of the shared data */
> -	uint64_t iter;            /* number of iterations to perform */
> -	uint32_t lc;              /* given lcore id */
> -};
> -
> -static inline void
> -store_load_barrier(uint32_t utype)
> -{
> -	if (utype =3D=3D USE_MB)
> -		rte_mb();
> -	else if (utype =3D=3D USE_SMP_MB)
> -		rte_smp_mb();
> -	else
> -		RTE_VERIFY(0);
> -}
> -
> -/*
> - * Peterson lock implementation.
> - */
> -static void
> -plock_lock(struct plock *l, uint32_t self)
> -{
> -	uint32_t other;
> -
> -	other =3D self ^ 1;
> -
> -	l->flag[self] =3D 1;
> -	rte_smp_wmb();
> -	l->victim =3D self;
> -
> -	store_load_barrier(l->utype);
> -
> -	while (l->flag[other] =3D=3D 1 && l->victim =3D=3D self)
> -		rte_pause();
> -	rte_smp_rmb();
> -}
> -
> -static void
> -plock_unlock(struct plock *l, uint32_t self)
> -{
> -	rte_smp_wmb();
> -	l->flag[self] =3D 0;
> -}
> -
> -static void
> -plock_reset(struct plock *l, enum plock_use_type utype)
> -{
> -	memset(l, 0, sizeof(*l));
> -	l->utype =3D utype;
> -}
> -
> -/*
> - * grab the lock, update both counters, release the lock.
> - */
> -static void
> -plock_add(struct plock_test *pt, uint32_t self, uint32_t n)
> -{
> -	plock_lock(&pt->lock, self);
> -	pt->iter++;
> -	pt->val +=3D n;
> -	plock_unlock(&pt->lock, self);
> -}
> -
> -static int
> -plock_test1_lcore(void *data)
> -{
> -	uint64_t tm;
> -	uint32_t lc, ln;
> -	uint64_t i, n;
> -	struct lcore_plock_test *lpt;
> -
> -	lpt =3D data;
> -	lc =3D rte_lcore_id();
> -
> -	/* find lcore_plock_test struct for given lcore */
> -	for (ln =3D rte_lcore_count(); ln !=3D 0 && lpt->lc !=3D lc; lpt++, ln-=
-)
> -		;
> -
> -	if (ln =3D=3D 0) {
> -		printf("%s(%u) error at init\n", __func__, lc);
> -		return -1;
> -	}
> -
> -	n =3D rte_rand() % ADD_MAX;
> -	tm =3D rte_get_timer_cycles();
> -
> -	/*
> -	 * for each iteration:
> -	 * - update shared, locked protected data in a safe manner
> -	 * - update local copy of the shared data
> -	 */
> -	for (i =3D 0; i !=3D lpt->iter; i++) {
> -
> -		plock_add(lpt->pt[0], 0, n);
> -		plock_add(lpt->pt[1], 1, n);
> -
> -		lpt->sum[0] +=3D n;
> -		lpt->sum[1] +=3D n;
> -
> -		n =3D (n + 1) % ADD_MAX;
> -	}
> -
> -	tm =3D rte_get_timer_cycles() - tm;
> -
> -	printf("%s(%u): %" PRIu64 " iterations finished, in %" PRIu64
> -		" cycles, %#Lf cycles/iteration, "
> -		"local sum=3D{%" PRIu64 ", %" PRIu64 "}\n",
> -		__func__, lc, i, tm, (long double)tm / i,
> -		lpt->sum[0], lpt->sum[1]);
> -	return 0;
> -}
> -
> -/*
> - * For N active lcores we allocate N+1 lcore_plock_test structures.
> - * Each active lcore shares one lcore_plock_test structure with its
> - * left lcore neighbor and one lcore_plock_test structure with its
> - * right lcore neighbor.
> - * During the test each lcore updates data in both shared structures and
> - * its local copies. Then at validation phase we check that our shared
> - * and local data are the same.
> - */
> -static int
> -plock_test(uint64_t iter, enum plock_use_type utype)
> -{
> -	int32_t rc;
> -	uint32_t i, lc, n;
> -	uint64_t *sum;
> -	struct plock_test *pt;
> -	struct lcore_plock_test *lpt;
> -
> -	/* init phase, allocate and initialize shared data */
> -
> -	n =3D rte_lcore_count();
> -	pt =3D calloc(n + 1, sizeof(*pt));
> -	lpt =3D calloc(n, sizeof(*lpt));
> -	sum =3D calloc(n + 1, sizeof(*sum));
> -
> -	printf("%s(iter=3D%" PRIu64 ", utype=3D%u) started on %u lcores\n",
> -		__func__, iter, utype, n);
> -
> -	if (pt =3D=3D NULL || lpt =3D=3D NULL || sum =3D=3D NULL) {
> -		printf("%s: failed to allocate memory for %u lcores\n",
> -			__func__, n);
> -		free(pt);
> -		free(lpt);
> -		free(sum);
> -		return -ENOMEM;
> -	}
> -
> -	for (i =3D 0; i !=3D n + 1; i++)
> -		plock_reset(&pt[i].lock, utype);
> -
> -	i =3D 0;
> -	RTE_LCORE_FOREACH(lc) {
> -
> -		lpt[i].lc =3D lc;
> -		lpt[i].iter =3D iter;
> -		lpt[i].pt[0] =3D pt + i;
> -		lpt[i].pt[1] =3D pt + i + 1;
> -		i++;
> -	}
> -
> -	lpt[i - 1].pt[1] =3D pt;
> -
> -	for (i =3D 0; i !=3D n; i++)
> -		printf("lpt[%u]=3D{lc=3D%u, pt=3D{%p, %p},};\n",
> -			i, lpt[i].lc, lpt[i].pt[0], lpt[i].pt[1]);
> -
> -
> -	/* test phase - start and wait for completion on each active lcore */
> -
> -	rte_eal_mp_remote_launch(plock_test1_lcore, lpt, CALL_MAIN);
> -	rte_eal_mp_wait_lcore();
> -
> -	/* validation phase - make sure that shared and local data match */
> -
> -	for (i =3D 0; i !=3D n; i++) {
> -		sum[i] +=3D lpt[i].sum[0];
> -		sum[i + 1] +=3D lpt[i].sum[1];
> -	}
> -
> -	sum[0] +=3D sum[i];
> -
> -	rc =3D 0;
> -	for (i =3D 0; i !=3D n; i++) {
> -		printf("%s: sum[%u]=3D%" PRIu64 ", pt[%u].val=3D%" PRIu64 ",
> pt[%u].iter=3D%" PRIu64 ";\n",
> -			__func__, i, sum[i], i, pt[i].val, i, pt[i].iter);
> -
> -		/* race condition occurred, lock doesn't work properly */
> -		if (sum[i] !=3D pt[i].val || 2 * iter !=3D pt[i].iter) {
> -			printf("error: local and shared sums don't match\n");
> -			rc =3D -1;
> -		}
> -	}
> -
> -	free(pt);
> -	free(lpt);
> -	free(sum);
> -
> -	printf("%s(utype=3D%u) returns %d\n", __func__, utype, rc);
> -	return rc;
> -}
> -
> -static int
> -test_barrier(void)
> -{
> -	int32_t i, ret, rc[USE_NUM];
> -
> -	for (i =3D 0; i !=3D RTE_DIM(rc); i++)
> -		rc[i] =3D plock_test(ITER_MAX, i);
> -
> -	ret =3D 0;
> -	for (i =3D 0; i !=3D RTE_DIM(rc); i++) {
> -		printf("%s for utype=3D%d %s\n",
> -			__func__, i, rc[i] =3D=3D 0 ? "passed" : "failed");
> -		ret |=3D rc[i];
> -	}
> -
> -	return ret;
> -}
> -
> -REGISTER_PERF_TEST(barrier_autotest, test_barrier);
> --
> 2.53.0

