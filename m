Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514A5C44536
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 09:52:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D85CA4027A;
	Thu, 22 Jan 2026 10:52:46 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id B59884021F
 for <dev@dpdk.org>; Thu, 22 Jan 2026 10:52:45 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxbvF0hVPzHnHFg;
 Thu, 22 Jan 2026 17:52:09 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 8BFF840570;
 Thu, 22 Jan 2026 17:52:44 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 22 Jan 2026 09:52:44 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 22 Jan 2026 09:52:44 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Subject: RE: [PATCH v5 6/6] ring: use inline instead of always inline in soring
Thread-Topic: [PATCH v5 6/6] ring: use inline instead of always inline in
 soring
Thread-Index: AQHcikag8bMJdWJ7zUuHT+fw9FxQE7Vd9MYA
Date: Thu, 22 Jan 2026 09:52:43 +0000
Message-ID: <4228c7fda1614bea9e37d87bfdb84b1d@huawei.com>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260120195418.466318-1-stephen@networkplumber.org>
 <20260120195418.466318-7-stephen@networkplumber.org>
In-Reply-To: <20260120195418.466318-7-stephen@networkplumber.org>
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



>=20
> When LTO is enabled, GCC inlines through the entire soring call chain
> from test code into the ring element copy functions. With always_inline,
> the compiler is forced to inline __rte_ring_dequeue_elems_128() which
> copies 32 bytes per element. GCC's static analysis then warns about
> potential buffer overflow because it cannot prove the 128-bit element
> path is unreachable when the ring is configured for 4-byte elements:
>=20
>   warning: writing 32 bytes into a region of size 0 [-Wstringop-overflow=
=3D]
>=20
> By using plain inline instead of always_inline on the soring enqueue
> and dequeue functions, the compiler regains discretion over inlining
> decisions. This introduces an analysis boundary that prevents GCC from
> connecting the test's buffer sizes to the unreachable 128-bit code path,
> eliminating the false positive warning.
>=20
> Performance impact is expected to be negligible. At -O2/-O3, the
> compiler will still inline these small, hot functions based on its
> own heuristics. The difference only matters in debug builds or with
> -Os, where slightly less aggressive inlining is acceptable.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ring/soring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/ring/soring.c b/lib/ring/soring.c
> index 797484d6bf..3b90521bdb 100644
> --- a/lib/ring/soring.c
> +++ b/lib/ring/soring.c
> @@ -249,7 +249,7 @@ __rte_soring_stage_move_head(struct
> soring_stage_headtail *d,
>  	return n;
>  }
>=20
> -static __rte_always_inline uint32_t
> +static inline uint32_t
>  soring_enqueue(struct rte_soring *r, const void *objs,
>  	const void *meta, uint32_t n, enum rte_ring_queue_behavior behavior,
>  	uint32_t *free_space)
> @@ -278,7 +278,7 @@ soring_enqueue(struct rte_soring *r, const void *objs=
,
>  	return n;
>  }
>=20
> -static __rte_always_inline uint32_t
> +static inline uint32_t
>  soring_dequeue(struct rte_soring *r, void *objs, void *meta,
>  	uint32_t num, enum rte_ring_queue_behavior behavior,
>  	uint32_t *available)
> --

Run quick test, no perf degradation noticed.
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Tested-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
=20
> 2.51.0

