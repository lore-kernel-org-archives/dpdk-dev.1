Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13E7EA7954
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 01:56:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E70BC4028E;
	Thu,  5 Feb 2026 02:56:14 +0100 (CET)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 166AA40264;
 Thu,  5 Feb 2026 02:56:12 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=sQP6PrprpRXqZC1BNqVvAzKP1v8q6gSQmqhpYxYT8Do=;
 b=zba5+iM3y6TMUoz5+ZSChfWu/ytR2L0UErWIh7nace5K05wgj65YbgPDYytxsKLi15A3IGmA8
 j8MYKi914F5jN/pBSiK/WX2WP1vFQkEMM2A6SfUgdXAOuVAH2qi5qY2yo84BeAXiux+U8PwHwCO
 CpEnhJ0Rp3KvKFABE7KMPFA=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4f60Zk4Vv2zpSvW;
 Thu,  5 Feb 2026 09:51:58 +0800 (CST)
Received: from kwepemf500001.china.huawei.com (unknown [7.202.181.239])
 by mail.maildlp.com (Postfix) with ESMTPS id 7C60840538;
 Thu,  5 Feb 2026 09:56:10 +0800 (CST)
Received: from kwepemq100013.china.huawei.com (7.202.195.192) by
 kwepemf500001.china.huawei.com (7.202.181.239) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Feb 2026 09:56:10 +0800
Received: from kwepemq100013.china.huawei.com ([7.202.195.192]) by
 kwepemq100013.china.huawei.com ([7.202.195.192]) with mapi id 15.02.1544.011; 
 Thu, 5 Feb 2026 09:56:10 +0800
From: Wangyunjian <wangyunjian@huawei.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "matan@nvidia.com" <matan@nvidia.com>, "suanmingm@nvidia.com"
 <suanmingm@nvidia.com>, "Lilijun (Jerry)" <jerry.lilijun@huawei.com>,
 "stable@dpdk.org" <stable@dpdk.org>, "dsosnowski@nvidia.com"
 <dsosnowski@nvidia.com>, "viacheslavo@nvidia.com" <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, "orika@nvidia.com" <orika@nvidia.com>,
 "rasland@nvidia.com" <rasland@nvidia.com>
Subject: RE: [PATCH v2] net/mlx5: fix memoy leak after device spawn failure
Thread-Topic: [PATCH v2] net/mlx5: fix memoy leak after device spawn failure
Thread-Index: AQHccA0gn5KbQmtapESNF/K5Q2oMcrVzpBsg
Date: Thu, 5 Feb 2026 01:56:09 +0000
Message-ID: <3a252aace4b640689122e2c03b102679@huawei.com>
References: <1766050280-21036-1-git-send-email-wangyunjian@huawei.com>
 <1766055446-41476-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1766055446-41476-1-git-send-email-wangyunjian@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.243.191]
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

Friendly ping

> -----Original Message-----
> From: Wangyunjian <wangyunjian@huawei.com>
> Sent: Thursday, December 18, 2025 6:57 PM
> To: dev@dpdk.org
> Cc: matan@nvidia.com; suanmingm@nvidia.com; Lilijun (Jerry)
> <jerry.lilijun@huawei.com>; Wangyunjian <wangyunjian@huawei.com>;
> stable@dpdk.org
> Subject: [PATCH v2] net/mlx5: fix memoy leak after device spawn failure
>=20
> In mlx5_dev_spawn() allocated memory for the 'priv->flows', we should fre=
e it
> when errors occur, otherwise it will lead to memory leak.
>=20
> Fixes: b4edeaf3efd5 ("net/mlx5: replace flow list with indexed pool")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
> v2: fix code styles
> ---
>  drivers/net/mlx5/linux/mlx5_os.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/ml=
x5_os.c
> index 7f73183bb1..7624b2aba2 100644
> --- a/drivers/net/mlx5/linux/mlx5_os.c
> +++ b/drivers/net/mlx5/linux/mlx5_os.c
> @@ -1831,6 +1831,11 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
>  			close(priv->nl_socket_route);
>  		if (priv->vmwa_context)
>  			mlx5_vlan_vmwa_exit(priv->vmwa_context);
> +		for (i =3D 0; i < MLX5_FLOW_TYPE_MAXI; i++) {
> +			if (!priv->flows[i])
> +				continue;
> +			mlx5_ipool_destroy(priv->flows[i]);
> +		}
>  		if (eth_dev && priv->drop_queue.hrxq)
>  			mlx5_drop_action_destroy(eth_dev);
>  		if (priv->mtr_profile_tbl)
> --
> 2.33.0

