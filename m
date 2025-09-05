Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337B4CA1015
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 08:09:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB95A40150;
	Fri,  5 Sep 2025 10:08:59 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id 09FAC400D5
 for <dev@dpdk.org>; Fri,  5 Sep 2025 10:08:57 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cJ8553Dtdz2Cg9D;
 Fri,  5 Sep 2025 16:04:25 +0800 (CST)
Received: from kwepemk200009.china.huawei.com (unknown [7.202.194.75])
 by mail.maildlp.com (Postfix) with ESMTPS id 5DEA2140143;
 Fri,  5 Sep 2025 16:08:55 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 kwepemk200009.china.huawei.com (7.202.194.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Sep 2025 16:08:54 +0800
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 5 Sep 2025 10:08:52 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Fengchengwen <fengchengwen@huawei.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] mempool: hide zero value items when dump cache
Thread-Topic: [PATCH] mempool: hide zero value items when dump cache
Thread-Index: AQHcHZTivhf5h7mqVUaE0V9x7t013rSEPUpA
Date: Fri, 5 Sep 2025 08:08:52 +0000
Message-ID: <c9e3b3f240f147288b474583902bd553@huawei.com>
References: <20250904120942.51729-1-fengchengwen@huawei.com>
In-Reply-To: <20250904120942.51729-1-fengchengwen@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
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

> Hide zero value items when dump mempool cache.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  lib/mempool/rte_mempool.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
> index 1021ede0c2..3042d94c14 100644
> --- a/lib/mempool/rte_mempool.c
> +++ b/lib/mempool/rte_mempool.c
> @@ -1057,7 +1057,7 @@ rte_mempool_dump_cache(FILE *f, const struct
> rte_mempool *mp)
>  	unsigned count =3D 0;
>  	unsigned cache_count;
>=20
> -	fprintf(f, "  internal cache infos:\n");
> +	fprintf(f, "  internal cache infos (hide zero value items):\n");
>  	fprintf(f, "    cache_size=3D%"PRIu32"\n", mp->cache_size);
>=20
>  	if (mp->cache_size =3D=3D 0)
> @@ -1065,6 +1065,8 @@ rte_mempool_dump_cache(FILE *f, const struct
> rte_mempool *mp)
>=20
>  	for (lcore_id =3D 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
>  		cache_count =3D mp->local_cache[lcore_id].len;
> +		if (cache_count =3D=3D 0)
> +			continue;
>  		fprintf(f, "    cache_count[%u]=3D%"PRIu32"\n",
>  			lcore_id, cache_count);
>  		count +=3D cache_count;
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.17.1

