Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B06CD342F
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 17:19:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D1EB40150;
	Fri,  8 May 2026 19:19:22 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012032.outbound.protection.outlook.com
 [40.107.200.32])
 by mails.dpdk.org (Postfix) with ESMTP id 0A4574013F;
 Fri,  8 May 2026 19:19:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecwuYLSFClmfc5NJw4ZOOcJwYCXKlUXW7OmTeCkS5KSQWOkC4retqjy6zDtcrAZgVzz3xIHPeH3iDhTfx4Y2Q4PleiQx1cVOBI4LA8p3pOL0lg940VG7+faRv+nfvLXy6Hwu2DSp9+Tbovhwcndbxe6J8SAhWbZlwkCllrwpjYPqwGzdPpfo8ZekRcpWvi5r2sDivc45sQPSy/mRgaTsgyO5aINDpgoVYHLLBgrDC4XCT4c4oahaGu7voD4it3w3sFxEc2CyLOiy8M0LxNgnQcPQSWSviaChMjyp9lIyeZLL+cTeudx2Q6/2Y8up+ZON5thKX0QFE9HDriP50+jGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnAKrw/KPVqVrP8cAHAi5KpVEppZWBkLO8ylY2jkIV8=;
 b=ayYh2FY2vJi9uf+uAO3mpnTnRonh7QUmxh4gekZ+TRZPoMwmgDCzeINgy4CRkOYQlOTxj5TKs5zzkDCuzlfEK14tM4hUWlaetVp/ncn5T/yRzVoQBKosmAEnJoU+wNhgWpOtIwmgDpzq14WkBbsLkviiH/8z5Py41RJVNCYo3F10iaCPaNUk+4NBW3ex4FVa8zo6Wmy7DuGkxBjlf6iTcpcpLp1VtFXiJ2kmZWYW53q04r9VX22TtaXwqMe38YbFTFAxg2+wMYTpEdGKwUn/36rw7R2w4TtFP/UO4sGph/KjrgPcB8FdlVXF3oigd6U/zCFo9s4SDv5Yd9REBQjjFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnAKrw/KPVqVrP8cAHAi5KpVEppZWBkLO8ylY2jkIV8=;
 b=dfzdyrYIowXFBFr8nBu9tKcnhFzyweZLM/VBErBSW1KJ4Gi5KchY6CiS1XhcCvjod1r6HfNOhwCe+6HaQkU29v6GRLDpDYYsN9BNeyCRMwY3VZxaxc2vSo4UZQMyHR5/fQP+eMe2n/tTVICs4Hbw5yJc2G09YygWtJCm3L8GdqHAys0RWtcZQ2WFlfxRYffdntLxQguqJ5iomPL6pDfuaxxDm2CyMiUrUUQg6UrfYMtIAtkGuo8timweFkfAFc7Roq1Wu8+2iPMIYSC0JVxDgIWyIJodT3KiFzoL/vVlUomLOjA84jRnHh52ztRaG2fOdYw3PPViA7RMr8yX+zlb0g==
Received: from SJ0PR03CA0226.namprd03.prod.outlook.com (2603:10b6:a03:39f::21)
 by MN0PR12MB5809.namprd12.prod.outlook.com (2603:10b6:208:375::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 17:19:16 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::c1) by SJ0PR03CA0226.outlook.office365.com
 (2603:10b6:a03:39f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.20 via Frontend Transport; Fri,
 8 May 2026 17:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 17:19:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 8 May
 2026 10:18:55 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 8 May
 2026 10:18:54 -0700
Date: Fri, 8 May 2026 19:18:36 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: <banoth.saikumar@oracle.com>
CC: <viacheslavo@nvidia.com>, <bingz@nvidia.com>, <dev@dpdk.org>,
 <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fallback to verbs for Tx memory allocation if
 devx unsupported
Message-ID: <ojacuve3ocnzdr4qylbpbyuobl4soe7w7bwft2pa4qecj63uih@xe6gn6dr4syn>
References: <20260323113403.1984-1-banoth.saikumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260323113403.1984-1-banoth.saikumar@oracle.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|MN0PR12MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0abd54-1f19-4c5c-d27b-08dead25eea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: zxAM1hKC2xCqPIRubI0HYsFB+F7gFasFIA0wx8vVCppoabVaP4x2WORNJh+OruiR8oxLurnbQrn94hQ9TrxAy5VN0NegvPXtJ39fFXLHMiQNpQdsocxn1KYC5ZIxlcgqBOqeQvE0u+sxy4brfmOWVJq6mYYv4I8PJg5BTqXXeItBPRLppVhAyPynrq9lBntmtt8wpHREtGrSjwucKU4soi2HbI1Pn3+iPr0S4PglV+rdXevMY/lhZuqRZRdmRnvEfc+6n5t8PFWnTeekywIsfbo3LEHVWum5hmhhVoBRvP6GaVimLNVxwGwLzpQIperEInS6/B+uvLEaKrP/2dWQYJWf4EBIb0ialDqKaJ+laAQAAlkqf3F4SFBTO2t8RhDUpPV4O2qurkgCr5w3CIxjur2A0YPti78WJk7BzOEE+7OMUIet8E9zlhUVrdeqgVhcIMcNBTd6RcIRWuO6X13M+NFGrL+fby5x/z8AmoYM7keD2UecJSppUOj4gP7TS5vez2AO8MCfbv8biapZU4VO3axsFnlBUokcZ8l2/RdGdncCfep4Ps6MPWA9rrf5GefY/fpzlE/7QZdp7jmbRfOzpUcSnxHmehKXNcsmrPizdmGs3+Ux4NV8abDD2MQQLrlapwtRZkGHI0Kqarh9O2g0jOI+Rch6DLE02IyEr77IqOZFW151OXfeYdS+Lq2QyZeKWpZfyeMAWN2fcasNqFatmtLd362OwQ1bVaZMeUKn1G8=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JrsqxFkjQI96KEGMlpy+ydhOlQPffYGL1QGyHtw6Rp71niXpKtTUaZGilJNn/KMkNH0Iyb3DNMu6Dw6BQf4HtBO4JTeK0dLqOSs9JfRgbzqFZqN3ClQk7yUbwnqzAWheMmmIjqNj2LXkYUg/j7VkntJnqHulz04vuBfCnMVqaSfIclknf6Vky6WBhqaVld0nrQO5W6/eGQtthDoeaviYQukwANTvl6uix32wQTgfq4Hj5332Gwhuz0rlKxzEZ9huwqMWelnDFT7bu3/CaXDgxvxT/KpmcLgdptO2u+x/54rIS934wUEjMcu2GR3l+iE79TS0QO82gVUHvIRYnkcmrpORFTzAvRcleUInj13AsPpnfwiBtyU9/IpoF27w/7EOmypcwK6y307oiZXUA+9964HUVV1/2Y7fIxs5v444PKHbqe1jkQVv6btoeNmdzaxo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 17:19:16.0483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0abd54-1f19-4c5c-d27b-08dead25eea2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5809
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

Hi,

Thank you for the contribution. Please see below.

On Mon, Mar 23, 2026 at 05:04:02PM +0530, banoth.saikumar@oracle.com wrote:
> From: Banoth Saikumar <banoth.saikumar@oracle.com>
> 
> Previously, the mlx5 PMD attempted to allocate consecutive Tx memory
> using DevX without checking whether the NIC actually supported DevX.
> This led to allocation failures on legacy or unsupported NICs.
> 
> This patch adds a fallback mechanism: if DevX is not available, the PMD
> skips DevX-based allocation and allows the verbs path to handle memory
> allocation and registration. This improves compatibility with older
> NICs and ensures Tx queue setup proceeds correctly.
> 
> Fixes: bbfab2eb2528 ("net/mlx5: allocate and release unique
> resources for Tx queues")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Banoth Saikumar <banoth.saikumar@oracle.com>
> ---
>  drivers/net/mlx5/mlx5_trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
> index 6c6f228..c9ce3d4 100644
> --- a/drivers/net/mlx5/mlx5_trigger.c
> +++ b/drivers/net/mlx5/mlx5_trigger.c
> @@ -1161,7 +1161,7 @@ static int mlx5_dev_allocate_consec_tx_mem(struct rte_eth_dev *dev)
>  	void *umem_buf = NULL;
>  
>  	/* Legacy per queue allocation, do nothing here. */
> -	if (priv->sh->config.txq_mem_algn == 0)
> +	if (priv->sh->config.txq_mem_algn == 0 || !priv->sh->cdev->config.devx)

Please use mlx5_devx_obj_ops_en() function instead of directly
checking priv->sh->cdev->config.devx field.

>  		return 0;
>  	alignment = (size_t)1 << priv->sh->config.txq_mem_algn;
>  	total_size = priv->consec_tx_mem.sq_total_size + priv->consec_tx_mem.cq_total_size;

Best regards,
Dariusz Sosnowski
