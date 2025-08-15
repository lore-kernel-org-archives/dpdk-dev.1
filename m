Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF95DCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 13:49:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28C28402D9;
	Fri, 15 Aug 2025 15:49:22 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 937604026C
 for <dev@dpdk.org>; Fri, 15 Aug 2025 15:49:21 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3NgY6lXYz6L4xG;
 Fri, 15 Aug 2025 21:46:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 44653140279;
 Fri, 15 Aug 2025 21:49:21 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Aug 2025 15:49:21 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 15 Aug 2025 15:49:20 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>
Subject: RE: [PATCH v2 3/6] graph: replace unnecessary comma operator
Thread-Topic: [PATCH v2 3/6] graph: replace unnecessary comma operator
Thread-Index: AQHcDWKb8CBJqVhskkm7BAb//LShzrRju+Dw
Date: Fri, 15 Aug 2025 13:49:20 +0000
Message-ID: <2a6815ac2e1f4fafbe71ee869513d02c@huawei.com>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250814212901.88863-1-stephen@networkplumber.org>
 <20250814212901.88863-4-stephen@networkplumber.org>
In-Reply-To: <20250814212901.88863-4-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.146.251]
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



> Use of comma as statement separator is discouraged and
> reported as warning by clang with -Wcomma
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/graph/graph_stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/graph/graph_stats.c b/lib/graph/graph_stats.c
> index eac73cbf71..588508b473 100644
> --- a/lib/graph/graph_stats.c
> +++ b/lib/graph/graph_stats.c
> @@ -254,7 +254,7 @@ stats_mem_populate(struct rte_graph_cluster_stats **s=
tats_in,
>  	*stats_in =3D NULL;
>=20
>  	/* Clear the new struct cluster_node area */
> -	cluster =3D RTE_PTR_ADD(stats, stats->sz),
> +	cluster =3D RTE_PTR_ADD(stats, stats->sz);
>  	memset(cluster, 0, stats->cluster_node_size);
>  	memcpy(cluster->stat.name, graph_node->node->name, RTE_NODE_NAMESIZE);
>  	cluster->stat.id =3D graph_node->node->id;
> --


Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>=20

> 2.47.2
>=20

