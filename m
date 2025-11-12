Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569D9CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 14:50:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C79D4060F;
	Wed, 12 Nov 2025 15:50:44 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id B83BF402B0
 for <dev@dpdk.org>; Wed, 12 Nov 2025 15:50:42 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d65t55XfPzHnGdW;
 Wed, 12 Nov 2025 22:50:21 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id 023C91400D9;
 Wed, 12 Nov 2025 22:50:41 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 12 Nov 2025 14:50:40 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 12 Nov 2025 14:50:40 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v2 3/7] examples/ip_reassembly: add check before
 formatting name
Thread-Topic: [PATCH v2 3/7] examples/ip_reassembly: add check before
 formatting name
Thread-Index: AQHcU1k6e6HbWXRX6EODqw/yikbrLLTvIKNQ
Date: Wed, 12 Nov 2025 14:50:40 +0000
Message-ID: <13bac5880e79482a98a2db5b7bb852bb@huawei.com>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251111221857.443752-1-stephen@networkplumber.org>
 <20251111221857.443752-4-stephen@networkplumber.org>
In-Reply-To: <20251111221857.443752-4-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.199.148]
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
> In theory, lcore and queue could be so large that mbuf pool name
> could overflow. But that can never happen since lcore and queue
> will be in range. Add a check so that static tools know that.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  examples/ip_reassembly/main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/examples/ip_reassembly/main.c b/examples/ip_reassembly/main.=
c
> index 17ae76d4ba..25b904dbd4 100644
> --- a/examples/ip_reassembly/main.c
> +++ b/examples/ip_reassembly/main.c
> @@ -884,6 +884,13 @@ setup_queue_tbl(struct rx_queue *rxq, uint32_t lcore=
,
> uint32_t queue)
>=20
>  	nb_mbuf =3D RTE_MAX(nb_mbuf, (uint32_t)NB_MBUF);
>=20
> +	/* Should never happen but check so that pool name won't be too long. *=
/
> +	if (lcore > RTE_MAX_LCORE || queue > RTE_MAX_QUEUES_PER_PORT) {
> +		RTE_LOG(ERR, IP_RSMBL, "invalid lcore %u or queue %u",
> +			lcore, queue);
> +		return -1;
> +	}
> +
>  	snprintf(buf, sizeof(buf), "mbuf_pool_%u_%u", lcore, queue);
>=20
>  	rxq->pool =3D rte_pktmbuf_pool_create(buf, nb_mbuf,
> MEMPOOL_CACHE_SIZE, 0,
> --
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> 2.51.0

