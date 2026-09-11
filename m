Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDD2C88E50
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 09:00:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E08EE40269;
	Fri, 11 Sep 2026 11:00:11 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010006.outbound.protection.outlook.com
 [52.101.193.6]) by mails.dpdk.org (Postfix) with ESMTP id B403940264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 11:00:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEYaD0KD/Y6tNooBOvskW3Zi/GCyTteqhzw0yoaD398Orn9WI79CjwipuN+3j2pkKWQKSS8bufL2mpDCOIz72EZ/0VtWhm0GHyRwfkhGZO3SkmcK0eDz+//lxEV179pc6+zWkHWl/lEwF825ni3pWZD8ELHkeoB8xt5xOwzjXCdNQMUjovTkhAw6NrPDtlK12rYmp+ZlKUZP76Pv1k50rRqxgu/2g+FfeiYq+DmLz3f8SfA1lqWok5CJCEcH6yOSoDcLf+V/OykZhTR4OIxLZCL7EgyeiVe31xsUZ+YSji17UU6J4vlJfl/o37Ryx/mT7l3MJ8CuUaEV8ZH9pn4HYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dniqOErxHaHSCRNc0Fm0Nd7SBAZJ/Msec7b6Mpa4Rw=;
 b=FW2XafbItZnCRUxWtHdAhe054vyrcmHINEhFAUHIk8zvYmZxus6+6VOcKESl9lC5bgF2x5zQlc+0U3qdDZhlbFAP9SI6WihX/jDVRXENA4wP5lJXzJyMroy2zc/3t6jVEr2xd2p1/6YhujciAtrKHMcRHn4CGc7i+haiADB02/WsrYwugjGZzxEiC1ZkBA5BHkW3b5LbDP40l+pmxCS1p4c1SeFptZsg6BpwCe13vpDfrCxqFXjxOZzVynYLZNaSBTaQ+y1t2IGLraXb22eZDo7x4EtvXHqmcPI8UoQ9zcpF5z+nwWqp5Z6Hs8tLMcPP+kuycRbd+d8/04xorLkDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dniqOErxHaHSCRNc0Fm0Nd7SBAZJ/Msec7b6Mpa4Rw=;
 b=oNk1nSYE3B0IqnlE2myJogRW4HqdDZek94gEVH6z3cBQkdaH/1T3/hDxC4FM32oWijm3mVkcpOegVotFQ4vI6/P1AvwLVoRco+HH2TbLBwHcEojs0GlwWob0LJbCj47/uc28FqjM1wyRcjkrtyQ62Dz6xL45dv6msr7z80XvpDx5qJQCJJTXZHVrdYzuZ038oOQ74+zT8yKOxnqwf9wbYG9W2WsgkXv6h6IU6rRm8OotWFOhEY+xLP+Zne/7HQJwehxvK6kzJTaKiHrRzBYrIAVhJ++YY1G7WYsk/YHUEskjYJWcRPlMJnC4pQ9lOX5vulfUTeswiCW2jrfopYl1Xw==
Received: from MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::16)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 09:00:00 +0000
Received: from CO1PEPF00012E7E.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::85) by MW4P222CA0011.outlook.office365.com
 (2603:10b6:303:114::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:59:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E7E.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 08:59:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 01:59:44 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 01:59:43 -0700
Date: Fri, 11 Sep 2026 10:59:34 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <rjarry@redhat.com>, <cfontain@redhat.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH v6 5/5] net/mlx5: accept more unicast MAC addresses
Message-ID: <p2wa2mfhpzprrdekf4zc2lq5wcp3lit7vmqbidbkuklvanwjnh@jyzvzl5tpuwk>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260908092743.3439825-1-david.marchand@redhat.com>
 <20260908092743.3439825-5-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908092743.3439825-5-david.marchand@redhat.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7E:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: c7225ec1-a79b-44ac-e4d6-08df0fe30f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: xXVSiehITxuY8BMYUl9vi8M4uHbpW1F/q+DpNQ8bK0LWkRw0Gh+TTXt7XYL41P3JhCAQvGP02dvbN8ovt9uplXnU+FTgwsZ5Tcd59LYJAa1KsEmIWcD/Q9/K7CPrCgAceS3TmZPbcocQoj9GVNui0pGOLTkCeVS2P6sZeoA5ln7I6P/Y5rlhxPzKhgdgMh+mK9tgIok3boNp2pIrSnMhQrISA8A7JiIBKRq3vTuK/zHzakvSj+r5IQHLobo/L5dyTu3aq2EkEFgf85bfczIQ+JFHN1qtsxoWPhb2WZg0CosvUAbtKx/WggHsQD101d24C9OSGrRK/gOaGj3mz1grRsaQeHz6q4pgMJKCMva0HKXzf5DCYnxmrOSDcPoOWY1VY1SUAtJhK62HzB/wdgCpJBMUzfIxt6fLo6vu7dUfAZkhY3u2KNh4/wAqAqDMoR/X2h10c7WB2JJFJSQhkTWVv6MFeFm4y+KAbM+Ed8lua7lU9L+vlIcPbLgb5YSniF0TCEUAVm9TOTZoySaK3buxGNCSD6nKZCJF9QEVMlTGPjxLH8d3L5wIebQbIlpNZBjgiqfC0yN5CGjvDO+c5BUM8SVEFgSE3NhVdb/bCn4XQlZF6DH+sxX5ylSQsqhmmg3CLOnKjn6/GQkeQbBQqrYNwzNYWuPygSGKnS5yCdTqFDP18N8+SJbTKIYw6CrIvLXyhSxRlKM6Rz2aWOyHu8/tqA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r/tg2A+43yJer+j8sV2+Mc1vREdF7mVYnu01YrL5LLN3anbMc4O4bl+gjPK2Wy2EoWO3aubWsVEK1TAQCPYHV6M1jveooYO5NpBXBOpvVE/A0QoXcqHYs7M1EOIqnTYyQ2MdTqqqBGp7tktDB8PkJ38dmvjQLsec+vPaSC2DTP9/ncHhwjTVu+CVmHgm1+JVk2oMWFEOfPRqZT6R/sM4mdBKTbPY4qIzmfqHnqoz1IDK36grA5WMmRQsBi8UmqrmxDg6CdeN8Akq7rYxopK9aWrUZ9NhgMwVx/AIrCO2jsHuKokSn+Op/RR2Df/fR31seNApfsN6Bwe4SBidX4T6v7JNmQYRrl6+xBDm+JNF4ooajoLkCSQ2lz+PRRpyoTrofl1B6IZ9YPpqbCTau15K0KaD5tm+I+LPf+IxO9Dj8MobkwVQW8DzsCUCBA2SUYNK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:59:59.3959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7225ec1-a79b-44ac-e4d6-08df0fe30f15
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
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

On Tue, Sep 08, 2026 at 11:27:43AM +0200, David Marchand wrote:
> Starting firmware version 22.49.1014, the number of mac addresses
> per VF is not capped to 128 anymore.
> 
> The value can be increased via devlink:
> $ devlink dev param set pci/0000:3b:00.2 name max_macs value 4096 \
> 	cmode driverinit
> $ devlink dev reload pci/0000:3b:00.2
> 
> On the DPDK side, we must retrieve the maximum number of unicast
> and multicast addresses supported with a query to the firmware.
> 
> Then, dynamically allocate the mac addresses arrays and report the
> limit instead of the previous hardcoded value.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v4:
> - added RN update,
> - fixed types of fields added to mlx5_hca_attr and mlx5_dev_cap,
> - used RTE_BIT32,
> - fixed mlx5_nl_mac_addr_sync inverted arguments,
> 
> ---
>  doc/guides/rel_notes/release_26_11.rst |  5 +++
>  drivers/common/mlx5/mlx5_devx_cmds.c   |  4 +++
>  drivers/common/mlx5/mlx5_devx_cmds.h   |  2 ++
>  drivers/net/mlx5/linux/mlx5_os.c       | 42 ++++++++++++++++++++------
>  drivers/net/mlx5/mlx5.c                |  9 ++----
>  drivers/net/mlx5/mlx5.h                |  8 +++--
>  drivers/net/mlx5/mlx5_ethdev.c         |  2 +-
>  drivers/net/mlx5/mlx5_mac.c            | 22 +++++++++-----
>  drivers/net/mlx5/mlx5_trigger.c        | 10 +++---
>  drivers/net/mlx5/windows/mlx5_os.c     | 40 +++++++++++++++++++-----
>  10 files changed, 104 insertions(+), 40 deletions(-)
> 
> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
> index 87c7e81bde..43043cd579 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -55,6 +55,11 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =======================================================
>  
> +* **Updated NVIDIA mlx5 ethernet driver.**
> +
> +  * Increased the maximum number of secondary unicast MAC addresses from 128 to up to 4096
> +    (depending on devlink configuration on the associated kernel netdevice).
> +
>  
>  Removed Items
>  -------------
> diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
> index 140b057ab4..e5d9c92779 100644
> --- a/drivers/common/mlx5/mlx5_devx_cmds.c
> +++ b/drivers/common/mlx5/mlx5_devx_cmds.c
> @@ -1110,6 +1110,10 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
>  	attr->log_max_pd = MLX5_GET(cmd_hca_cap, hcattr, log_max_pd);
>  	attr->log_max_srq = MLX5_GET(cmd_hca_cap, hcattr, log_max_srq);
>  	attr->log_max_srq_sz = MLX5_GET(cmd_hca_cap, hcattr, log_max_srq_sz);
> +	attr->log_max_current_uc_list = MLX5_GET(cmd_hca_cap, hcattr,
> +						 log_max_current_uc_list);
> +	attr->log_max_current_mc_list = MLX5_GET(cmd_hca_cap, hcattr,
> +						 log_max_current_mc_list);
>  	attr->reg_c_preserve =
>  		MLX5_GET(cmd_hca_cap, hcattr, reg_c_preserve);
>  	attr->mmo_regex_qp_en = MLX5_GET(cmd_hca_cap, hcattr, regexp_mmo_qp);
> diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h b/drivers/common/mlx5/mlx5_devx_cmds.h
> index 90beb2e9e6..504b4a4f64 100644
> --- a/drivers/common/mlx5/mlx5_devx_cmds.h
> +++ b/drivers/common/mlx5/mlx5_devx_cmds.h
> @@ -356,6 +356,8 @@ struct mlx5_hca_attr {
>  	uint8_t tx_sw_owner_v2:1;
>  	uint8_t esw_sw_owner:1;
>  	uint8_t esw_sw_owner_v2:1;
> +	uint8_t log_max_current_uc_list:5;
> +	uint8_t log_max_current_mc_list:5;
>  };
>  
>  /* LAG Context. */
> diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
> index 7d8ea4acba..35efb1d572 100644
> --- a/drivers/net/mlx5/linux/mlx5_os.c
> +++ b/drivers/net/mlx5/linux/mlx5_os.c
> @@ -389,6 +389,16 @@ mlx5_os_capabilities_prepare(struct mlx5_dev_ctx_shared *sh)
>  	sh->dev_cap.esw_info.regc_mask = 0;
>  #endif
>  	sh->dev_cap.esw_info.is_set = 1;
> +	if (hca_attr->log_max_current_uc_list > 0)
> +		sh->dev_cap.max_uc_mac_addrs = RTE_BIT32(hca_attr->log_max_current_uc_list);
> +	else
> +		sh->dev_cap.max_uc_mac_addrs = MLX5_MAX_UC_MAC_ADDRESSES;
> +	if (hca_attr->log_max_current_mc_list > 0)
> +		sh->dev_cap.max_mc_mac_addrs = RTE_BIT32(hca_attr->log_max_current_mc_list);
> +	else
> +		sh->dev_cap.max_mc_mac_addrs = MLX5_MAX_MC_MAC_ADDRESSES;
> +	sh->dev_cap.max_mac_addrs =
> +		sh->dev_cap.max_uc_mac_addrs + sh->dev_cap.max_mc_mac_addrs;
>  	return 0;
>  }
>  
> @@ -1464,6 +1474,22 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
>  	priv->sh = sh;
>  	priv->dev_port = spawn->phys_port;
>  	priv->pci_dev = spawn->pci_dev;
> +	priv->mac = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
> +				sizeof(*priv->mac) * sh->dev_cap.max_mac_addrs,
> +				RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
> +	if (priv->mac == NULL) {
> +		DRV_LOG(ERR, "Failed to allocate MAC address array.");
> +		err = ENOMEM;
> +		goto error;
> +	}
> +	priv->mac_own = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
> +				    RTE_BITSET_SIZE(sh->dev_cap.max_mac_addrs),
> +				    RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
> +	if (priv->mac_own == NULL) {
> +		DRV_LOG(ERR, "Failed to allocate MAC ownership bitmap.");
> +		err = ENOMEM;
> +		goto error;
> +	}
>  	/* Some internal functions rely on Netlink sockets, open them now. */
>  	priv->nl_socket_rdma = nl_rdma;
>  	priv->nl_socket_route =	mlx5_nl_init(NETLINK_ROUTE, 0);
> @@ -1762,8 +1788,8 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
>  		mlx5_nl_mac_addr_sync(priv->nl_socket_route,
>  				      mlx5_ifindex(eth_dev),
>  				      eth_dev->data->mac_addrs,
> -				      MLX5_MAX_UC_MAC_ADDRESSES,
> -				      MLX5_MAX_MAC_ADDRESSES);
> +				      sh->dev_cap.max_uc_mac_addrs,
> +				      sh->dev_cap.max_mac_addrs);
>  	priv->ctrl_flows = 0;
>  	rte_spinlock_init(&priv->flow_list_lock);
>  	TAILQ_INIT(&priv->flow_meters);
> @@ -1963,17 +1989,15 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
>  			mlx5_flex_item_port_cleanup(eth_dev);
>  		mlx5_free(priv->ext_rxqs);
>  		mlx5_free(priv->ext_txqs);
> +		mlx5_free(priv->mac);
> +		eth_dev->data->mac_addrs = NULL;

This can segfault because eth_dev is allocated later than priv.
Previous version of the error rollback accounted for that
(where mac_addrs was reset only if eth_dev != NULL).
The same logic applies in Windows code.

Could you please revert that?

> +		mlx5_free(priv->mac_own);
>  		mlx5_free(priv);
>  		if (eth_dev != NULL)
>  			eth_dev->data->dev_private = NULL;
>  	}
> -	if (eth_dev != NULL) {
> -		/* mac_addrs must not be freed alone because part of
> -		 * dev_private
> -		 **/
> -		eth_dev->data->mac_addrs = NULL;
> +	if (eth_dev != NULL)
>  		rte_eth_dev_release_port(eth_dev);
> -	}
>  	if (sh)
>  		mlx5_free_shared_dev_ctx(sh);
>  	if (nl_rdma >= 0)
> @@ -3531,7 +3555,7 @@ mlx5_os_mac_addr_flush(struct rte_eth_dev *dev)
>  	const int vf = priv->sh->dev_cap.vf;
>  	int i;
>  
> -	for (i = MLX5_MAX_MAC_ADDRESSES - 1; i >= 0; --i) {
> +	for (i = priv->sh->dev_cap.max_mac_addrs - 1; i >= 0; --i) {
>  		if (rte_bitset_test(priv->mac_own, i)) {
>  			if (vf)
>  				mlx5_nl_mac_addr_remove(priv->nl_socket_route,
> diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
> index c7b0d3ef8b..4bd1c6d1c0 100644
> --- a/drivers/net/mlx5/mlx5.c
> +++ b/drivers/net/mlx5/mlx5.c
> @@ -2556,6 +2556,9 @@ mlx5_dev_close(struct rte_eth_dev *dev)
>  		mlx5_list_destroy(priv->hrxqs);
>  	mlx5_free(priv->ext_rxqs);
>  	mlx5_free(priv->ext_txqs);
> +	mlx5_free(priv->mac);
> +	dev->data->mac_addrs = NULL;
> +	mlx5_free(priv->mac_own);
>  	sh->port[priv->dev_port - 1].nl_ih_port_id = RTE_MAX_ETHPORTS;
>  	/*
>  	 * The interrupt handler port id must be reset before priv is reset
> @@ -2590,12 +2593,6 @@ mlx5_dev_close(struct rte_eth_dev *dev)
>  	mlx5_flow_pools_destroy(priv);
>  	memset(priv, 0, sizeof(*priv));
>  	priv->domain_id = RTE_ETH_DEV_SWITCH_DOMAIN_ID_INVALID;
> -	/*
> -	 * Reset mac_addrs to NULL such that it is not freed as part of
> -	 * rte_eth_dev_release_port(). mac_addrs is part of dev_private so
> -	 * it is freed when dev_private is freed.
> -	 */
> -	dev->data->mac_addrs = NULL;
>  	return 0;
>  }
>  
> diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
> index 7f20c811f3..70efcda9bb 100644
> --- a/drivers/net/mlx5/mlx5.h
> +++ b/drivers/net/mlx5/mlx5.h
> @@ -217,6 +217,9 @@ struct mlx5_dev_cap {
>  	} mprq; /* Capability for Multi-Packet RQ. */
>  	char fw_ver[64]; /* Firmware version of this device. */
>  	struct flow_hw_port_info esw_info; /* E-switch manager reg_c0. */
> +	uint32_t max_uc_mac_addrs; /* Maximum unicast MAC addresses. */
> +	uint32_t max_mc_mac_addrs; /* Maximum multicast MAC addresses. */
> +	uint32_t max_mac_addrs; /* Total maximum MAC addresses. */
>  };
>  
>  #define MLX5_MPESW_PORT_INVALID (-1)
> @@ -2018,9 +2021,8 @@ struct mlx5_priv {
>  	struct mlx5_dev_ctx_shared *sh; /* Shared device context. */
>  	uint32_t dev_port; /* Device port number. */
>  	struct rte_pci_device *pci_dev; /* Backend PCI device. */
> -	struct rte_ether_addr mac[MLX5_MAX_MAC_ADDRESSES]; /* MAC addresses. */
> -	RTE_BITSET_DECLARE(mac_own, MLX5_MAX_MAC_ADDRESSES);
> -	/* Bit-field of MAC addresses owned by the PMD. */
> +	struct rte_ether_addr *mac; /* MAC addresses. */
> +	uint64_t *mac_own; /* Bit-field of MAC addresses owned by the PMD. */
>  	uint16_t vlan_filter[MLX5_MAX_VLAN_IDS]; /* VLAN filters table. */
>  	unsigned int vlan_filter_n; /* Number of configured VLAN filters. */
>  	/* Device properties. */
> diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
> index 8160d10e7e..306c1cd734 100644
> --- a/drivers/net/mlx5/mlx5_ethdev.c
> +++ b/drivers/net/mlx5/mlx5_ethdev.c
> @@ -392,7 +392,7 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
>  	max = RTE_MIN(max, (unsigned int)UINT16_MAX);
>  	info->max_rx_queues = max;
>  	info->max_tx_queues = max;
> -	info->max_mac_addrs = MLX5_MAX_UC_MAC_ADDRESSES;
> +	info->max_mac_addrs = priv->sh->dev_cap.max_uc_mac_addrs;
>  	info->rx_queue_offload_capa = mlx5_get_rx_queue_offloads(dev);
>  	info->rx_seg_capa.max_nseg = MLX5_MAX_RXQ_NSEG;
>  	info->rx_seg_capa.multi_pools = !priv->config.mprq.enabled;
> diff --git a/drivers/net/mlx5/mlx5_mac.c b/drivers/net/mlx5/mlx5_mac.c
> index 0e5d2be530..2ce7cfd407 100644
> --- a/drivers/net/mlx5/mlx5_mac.c
> +++ b/drivers/net/mlx5/mlx5_mac.c
> @@ -36,7 +36,9 @@ mlx5_internal_mac_addr_remove(struct rte_eth_dev *dev,
>  			      uint32_t index,
>  			      struct rte_ether_addr *addr)
>  {
> -	MLX5_ASSERT(index < MLX5_MAX_MAC_ADDRESSES);
> +	struct mlx5_priv *priv = dev->data->dev_private;
> +
> +	MLX5_ASSERT(index < priv->sh->dev_cap.max_mac_addrs);

Coverity in our internal CI reports the following:

	drivers/net/mlx5/mlx5_mac.c:39:20: CID 910875 (#1 of 1):
	  Type: Parse warning (PW.SET_BUT_NOT_USED)
	  Classification: Unclassified
	  Severity: Unspecified
	  Action: Undecided
	  Owner: Unassigned
	  Defect only exists locally.
	drivers/net/mlx5/mlx5_mac.c:39:20:
	  1. set_but_not_used: variable "priv" was set but never used

priv variable can be removed using MLX5_SH macro:

	MLX5_ASSERT(index < MLX5_SH(dev)->dev_cap.max_mac_addrs);

>  	if (rte_is_zero_ether_addr(&dev->data->mac_addrs[index]))
>  		return false;
>  	mlx5_os_mac_addr_remove(dev, index);
> @@ -63,16 +65,17 @@ static int
>  mlx5_internal_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac,
>  			   uint32_t index)
>  {
> +	struct mlx5_priv *priv = dev->data->dev_private;
>  	unsigned int i;
>  	int ret;
>  
> -	MLX5_ASSERT(index < MLX5_MAX_MAC_ADDRESSES);
> +	MLX5_ASSERT(index < priv->sh->dev_cap.max_mac_addrs);
>  	if (rte_is_zero_ether_addr(mac)) {
>  		rte_errno = EINVAL;
>  		return -rte_errno;
>  	}
>  	/* First, make sure this address isn't already configured. */
> -	for (i = 0; (i != MLX5_MAX_MAC_ADDRESSES); ++i) {
> +	for (i = 0; i != priv->sh->dev_cap.max_mac_addrs; ++i) {
>  		/* Skip this index, it's going to be reconfigured. */
>  		if (i == index)
>  			continue;
> @@ -101,10 +104,11 @@ mlx5_internal_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac,
>  void
>  mlx5_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
>  {
> +	struct mlx5_priv *priv = dev->data->dev_private;
>  	struct rte_ether_addr addr = { 0 };
>  	int ret;
>  
> -	if (index >= MLX5_MAX_UC_MAC_ADDRESSES)
> +	if (index >= priv->sh->dev_cap.max_uc_mac_addrs)
>  		return;
>  	if (mlx5_internal_mac_addr_remove(dev, index, &addr)) {
>  		ret = mlx5_traffic_mac_remove(dev, &addr);
> @@ -133,9 +137,10 @@ int
>  mlx5_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac,
>  		  uint32_t index, uint32_t vmdq __rte_unused)
>  {
> +	struct mlx5_priv *priv = dev->data->dev_private;
>  	int ret;
>  
> -	if (index >= MLX5_MAX_UC_MAC_ADDRESSES) {
> +	if (index >= priv->sh->dev_cap.max_uc_mac_addrs) {
>  		rte_errno = EINVAL;
>  		return -rte_errno;
>  	}
> @@ -217,16 +222,17 @@ int
>  mlx5_set_mc_addr_list(struct rte_eth_dev *dev,
>  		      struct rte_ether_addr *mc_addr_set, uint32_t nb_mc_addr)
>  {
> +	struct mlx5_priv *priv = dev->data->dev_private;
>  	uint32_t i;
>  	int ret;
>  
> -	if (nb_mc_addr >= MLX5_MAX_MC_MAC_ADDRESSES) {
> +	if (nb_mc_addr >= priv->sh->dev_cap.max_mc_mac_addrs) {
>  		rte_errno = ENOSPC;
>  		return -rte_errno;
>  	}
> -	for (i = MLX5_MAX_UC_MAC_ADDRESSES; i != MLX5_MAX_MAC_ADDRESSES; ++i)
> +	for (i = priv->sh->dev_cap.max_uc_mac_addrs; i != priv->sh->dev_cap.max_mac_addrs; ++i)
>  		mlx5_internal_mac_addr_remove(dev, i, NULL);
> -	i = MLX5_MAX_UC_MAC_ADDRESSES;
> +	i = priv->sh->dev_cap.max_uc_mac_addrs;
>  	while (nb_mc_addr--) {
>  		ret = mlx5_internal_mac_addr_add(dev, mc_addr_set++, i++);
>  		if (ret)
> diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
> index 7f6148f4e1..c5f493117b 100644
> --- a/drivers/net/mlx5/mlx5_trigger.c
> +++ b/drivers/net/mlx5/mlx5_trigger.c
> @@ -1916,7 +1916,7 @@ mlx5_traffic_enable(struct rte_eth_dev *dev)
>  		}
>  	}
>  	/* Add MAC address flows. */
> -	for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
> +	for (i = 0; i != priv->sh->dev_cap.max_mac_addrs; ++i) {
>  		struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
>  
>  		/* Add flows for unicast and multicast mac addresses added by API. */
> @@ -2186,7 +2186,7 @@ mlx5_traffic_vlan_add(struct rte_eth_dev *dev, const uint16_t vid)
>  		return 0;
>  
>  	/* Add all unicast DMAC flow rules with new VLAN attached. */
> -	for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
> +	for (i = 0; i != priv->sh->dev_cap.max_mac_addrs; ++i) {
>  		struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
>  
>  		if (rte_is_zero_ether_addr(mac))
> @@ -2203,7 +2203,7 @@ mlx5_traffic_vlan_add(struct rte_eth_dev *dev, const uint16_t vid)
>  		 * Removing after creating VLAN rules so that traffic "gap" is not introduced.
>  		 */
>  
> -		for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
> +		for (i = 0; i != priv->sh->dev_cap.max_mac_addrs; ++i) {
>  			struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
>  
>  			if (rte_is_zero_ether_addr(mac))
> @@ -2241,7 +2241,7 @@ mlx5_traffic_vlan_remove(struct rte_eth_dev *dev, const uint16_t vid)
>  		 * Recreating first to ensure no traffic "gap".
>  		 */
>  
> -		for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
> +		for (i = 0; i != priv->sh->dev_cap.max_mac_addrs; ++i) {
>  			struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
>  
>  			if (rte_is_zero_ether_addr(mac))
> @@ -2254,7 +2254,7 @@ mlx5_traffic_vlan_remove(struct rte_eth_dev *dev, const uint16_t vid)
>  	}
>  
>  	/* Remove all unicast DMAC flow rules with this VLAN. */
> -	for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
> +	for (i = 0; i != priv->sh->dev_cap.max_mac_addrs; ++i) {
>  		struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
>  
>  		if (rte_is_zero_ether_addr(mac))
> diff --git a/drivers/net/mlx5/windows/mlx5_os.c b/drivers/net/mlx5/windows/mlx5_os.c
> index eaa6c25c09..fa429a824b 100644
> --- a/drivers/net/mlx5/windows/mlx5_os.c
> +++ b/drivers/net/mlx5/windows/mlx5_os.c
> @@ -261,6 +261,16 @@ mlx5_os_capabilities_prepare(struct mlx5_dev_ctx_shared *sh)
>  		 MLX5_GET(initial_seg, pv_iseg, fw_rev_subminor));
>  	DRV_LOG(DEBUG, "Packet pacing is not supported.");
>  	mlx5_rt_timestamp_config(sh, hca_attr);
> +	if (hca_attr->log_max_current_uc_list > 0)
> +		sh->dev_cap.max_uc_mac_addrs = RTE_BIT32(hca_attr->log_max_current_uc_list);
> +	else
> +		sh->dev_cap.max_uc_mac_addrs = MLX5_MAX_UC_MAC_ADDRESSES;
> +	if (hca_attr->log_max_current_mc_list > 0)
> +		sh->dev_cap.max_mc_mac_addrs = RTE_BIT32(hca_attr->log_max_current_mc_list);
> +	else
> +		sh->dev_cap.max_mc_mac_addrs = MLX5_MAX_MC_MAC_ADDRESSES;
> +	sh->dev_cap.max_mac_addrs =
> +		sh->dev_cap.max_uc_mac_addrs + sh->dev_cap.max_mc_mac_addrs;
>  	return 0;
>  }
>  
> @@ -396,6 +406,22 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
>  	priv->sh = sh;
>  	priv->dev_port = spawn->phys_port;
>  	priv->pci_dev = spawn->pci_dev;
> +	priv->mac = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
> +				sizeof(*priv->mac) * sh->dev_cap.max_mac_addrs,
> +				RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
> +	if (priv->mac == NULL) {
> +		DRV_LOG(ERR, "Failed to allocate MAC address array.");
> +		err = ENOMEM;
> +		goto error;
> +	}
> +	priv->mac_own = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
> +				    RTE_BITSET_SIZE(sh->dev_cap.max_mac_addrs),
> +				    RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
> +	if (priv->mac_own == NULL) {
> +		DRV_LOG(ERR, "Failed to allocate MAC ownership bitmap.");
> +		err = ENOMEM;
> +		goto error;
> +	}
>  	priv->mp_id.port_id = port_id;
>  	strlcpy(priv->mp_id.name, MLX5_MP_NAME, RTE_MP_MAX_NAME_LEN);
>  	priv->representor = !!switch_info->representor;
> @@ -612,17 +638,15 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
>  			mlx5_l3t_destroy(priv->mtr_profile_tbl);
>  		if (own_domain_id)
>  			claim_zero(rte_eth_switch_domain_free(priv->domain_id));
> +		mlx5_free(priv->mac);
> +		eth_dev->data->mac_addrs = NULL;
> +		mlx5_free(priv->mac_own);
>  		mlx5_free(priv);
>  		if (eth_dev != NULL)
>  			eth_dev->data->dev_private = NULL;
>  	}
> -	if (eth_dev != NULL) {
> -		/* mac_addrs must not be freed alone because part of
> -		 * dev_private
> -		 **/
> -		eth_dev->data->mac_addrs = NULL;
> +	if (eth_dev != NULL)
>  		rte_eth_dev_release_port(eth_dev);
> -	}
>  	if (sh)
>  		mlx5_free_shared_dev_ctx(sh);
>  	MLX5_ASSERT(err > 0);
> @@ -698,7 +722,7 @@ mlx5_os_mac_addr_flush(struct rte_eth_dev *dev)
>  	struct mlx5_priv *priv = dev->data->dev_private;
>  	int i;
>  
> -	for (i = MLX5_MAX_MAC_ADDRESSES - 1; i >= 0; --i) {
> +	for (i = priv->sh->dev_cap.max_mac_addrs - 1; i >= 0; --i) {
>  		if (rte_bitset_test(priv->mac_own, i))
>  			rte_bitset_clear(priv->mac_own, i);
>  	}
> @@ -718,7 +742,7 @@ mlx5_os_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
>  {
>  	struct mlx5_priv *priv = dev->data->dev_private;
>  
> -	if (index < MLX5_MAX_MAC_ADDRESSES)
> +	if (index < priv->sh->dev_cap.max_mac_addrs)
>  		rte_bitset_clear(priv->mac_own, index);
>  }
>  
> -- 
> 2.54.0
> 
