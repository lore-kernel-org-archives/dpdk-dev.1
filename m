Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B50FCAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 07:14:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A0E040611;
	Fri, 19 Sep 2025 09:14:00 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 4BAA0402B7;
 Fri, 19 Sep 2025 09:13:59 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cSkGX4j4kz6K9Nt;
 Fri, 19 Sep 2025 15:12:20 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 9089814037D;
 Fri, 19 Sep 2025 15:13:58 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Sep 2025 09:13:58 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 19 Sep 2025 09:13:58 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Zhichao Zeng <zhichaox.zeng@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Ferruh Yigit <ferruh.yigit@amd.com>, 
 Shahaf Shuler <shahafs@nvidia.com>
Subject: RE: [PATCH] examples/ip_reassembly: remove conflicting Tx offload
Thread-Topic: [PATCH] examples/ip_reassembly: remove conflicting Tx offload
Thread-Index: AQHcKTHw7dzhTnfouECPGa+67CHFfLSaFvhg
Date: Fri, 19 Sep 2025 07:13:58 +0000
Message-ID: <1b34bebb0c2544468c31e4a566e7335d@huawei.com>
References: <20250919071213.818567-1-zhichaox.zeng@intel.com>
In-Reply-To: <20250919071213.818567-1-zhichaox.zeng@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.173.56]
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
> IP packet reassembly requires the MULTI_SEGS offload to be enabled in ord=
er
> to handle fragmented packets across multiple memory segments. However, th=
e
> MBUF_FAST_FREE offload conflicts with MULTI_SEGS and cannot be enabled
> simultaneously.
>=20
> Remove the MBUF_FAST_FREE offload to avoid conflicts with MULTI_SEGS.
>=20
> Fixes: 9df56e69ee3f ("examples/ip_reassembly: convert to new ethdev offlo=
ads
> API")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Zhichao Zeng <zhichaox.zeng@intel.com>
> ---
>  examples/ip_reassembly/main.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/examples/ip_reassembly/main.c b/examples/ip_reassembly/main.=
c
> index 17ae76d4ba..294fd38889 100644
> --- a/examples/ip_reassembly/main.c
> +++ b/examples/ip_reassembly/main.c
> @@ -1093,9 +1093,6 @@ main(int argc, char **argv)
>  		n_tx_queue =3D nb_lcores;
>  		if (n_tx_queue > MAX_TX_QUEUE_PER_PORT)
>  			n_tx_queue =3D MAX_TX_QUEUE_PER_PORT;
> -		if (dev_info.tx_offload_capa &
> RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
> -			local_port_conf.txmode.offloads |=3D
> -				RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
>=20
>  		local_port_conf.rx_adv_conf.rss_conf.rss_hf &=3D
>  			dev_info.flow_type_rss_offloads;
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.34.1
>=20

