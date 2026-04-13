Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607E2F34C4C
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 12:24:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53D5D4021E;
	Mon, 13 Apr 2026 14:24:14 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id EE6D44014F;
 Mon, 13 Apr 2026 14:24:12 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fvRR31qWSzHnH45;
 Mon, 13 Apr 2026 20:23:59 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id 550AC40575;
 Mon, 13 Apr 2026 20:24:11 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Apr 2026 13:24:10 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 13 Apr 2026 13:24:00 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Allain Legacy
 <allain.legacy@windriver.com>
Subject: RE: [PATCH 1/2] ip_frag: fix unsafe TAILQ usage
Thread-Topic: [PATCH 1/2] ip_frag: fix unsafe TAILQ usage
Thread-Index: AQHcx3OKHmXQFsqYRkKbCsd3mb5XubXc8avg
Date: Mon, 13 Apr 2026 12:24:00 +0000
Message-ID: <554bb9752e4f4cda8969f6b4d20e1500@huawei.com>
References: <20260408161947.285185-1-stephen@networkplumber.org>
 <20260408161947.285185-2-stephen@networkplumber.org>
In-Reply-To: <20260408161947.285185-2-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.146.52]
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
> The frag table next pointer was being access after TAILQ_REMOVE().
> This is not safe since it depends on TAILQ_REMOVE() not changing
> next pointer. Fix by using RTE_TAILQ_FOREACH_SAFE().
>=20
> Fixes: 95908f52393d ("ip_frag: free mbufs on reassembly table destroy")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ip_frag/ip_frag_common.h     |  1 +
>  lib/ip_frag/rte_ip_frag_common.c | 20 ++++++++++----------
>  2 files changed, 11 insertions(+), 10 deletions(-)
>=20
> diff --git a/lib/ip_frag/ip_frag_common.h b/lib/ip_frag/ip_frag_common.h
> index 51fc9d47fb..34be5bb6ab 100644
> --- a/lib/ip_frag/ip_frag_common.h
> +++ b/lib/ip_frag/ip_frag_common.h
> @@ -8,6 +8,7 @@
>  #include <sys/queue.h>
>=20
>  #include <rte_common.h>
> +#include <rte_tailq.h>
>=20
>  #if defined(RTE_ARCH_ARM64)
>  #include <rte_cmp_arm64.h>
> diff --git a/lib/ip_frag/rte_ip_frag_common.c
> b/lib/ip_frag/rte_ip_frag_common.c
> index ee9aa93027..79ac45289b 100644
> --- a/lib/ip_frag/rte_ip_frag_common.c
> +++ b/lib/ip_frag/rte_ip_frag_common.c
> @@ -135,18 +135,18 @@ rte_ip_frag_table_del_expired_entries(struct
> rte_ip_frag_tbl *tbl,
>  	struct rte_ip_frag_death_row *dr, uint64_t tms)
>  {
>  	uint64_t max_cycles;
> -	struct ip_frag_pkt *fp;
> +	struct ip_frag_pkt *fp, *tmp;
>=20
>  	max_cycles =3D tbl->max_cycles;
>=20
> -	TAILQ_FOREACH(fp, &tbl->lru, lru)
> -		if (max_cycles + fp->start < tms) {
> -			/* check that death row has enough space */
> -			if (RTE_IP_FRAG_DEATH_ROW_MBUF_LEN - dr->cnt >=3D
> -					fp->last_idx)
> -				ip_frag_tbl_del(tbl, dr, fp);
> -			else
> -				return;
> -		} else
> +	RTE_TAILQ_FOREACH_SAFE(fp, &tbl->lru, lru, tmp) {
> +		if (max_cycles + fp->start >=3D tms)
> +			return;
> +
> +		/* check that death row has enough space */
> +		if (RTE_IP_FRAG_DEATH_ROW_MBUF_LEN - dr->cnt < fp-
> >last_idx)
>  			return;
> +
> +		ip_frag_tbl_del(tbl, dr, fp);
> +	}
>  }
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.53.0

