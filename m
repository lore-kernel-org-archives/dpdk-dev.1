Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA07FE51E9
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 08:52:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01C58402A2;
	Fri, 24 Apr 2026 10:52:42 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
 by mails.dpdk.org (Postfix) with ESMTP id 8A605402A0
 for <dev@dpdk.org>; Fri, 24 Apr 2026 10:52:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9ar7qDuQMcjDskzTAu0S6gupiZrPbTUSXrQvytYCQ8BTGivJQJ8aSuJs9HtRnuOp/WkvkZrlI31YjaEcDT39Fihju7JR44sHCJxcWo39o82teyCLx7NfMkcQq9YFi9+Q6X3feM8S3/H2fCQiQbV9HHpJDLlOzueX5QFJkQZp7OKPBqwNS5jfFIrvX8/JJj0rqvtxLFyLsc1yjxmrHQf94qi4NX49ouaaBk4m4wPmS+uduHstecU+h1d2LdW8gpuu6PmiXHiZlV56Hn9bPTuCQJQKP8x40rJJnrNkxBWFx/nFwNMiDXKzGyyfA15boccWOpBsA+iffBrJXghhYv72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUPkQBpr6/1Y4oipU/xqfSWyl46voLjpxzjQQMnz8UM=;
 b=Neblx5J9wHkc6FpLaNZhaOhml81SbehrQG9YuAR0rpADpv358zo/7cEg48FoXJewqNjBdiou/NFHdMJbEXv0/5OuToPQSwVczN/1LO1FcDJtWPjy3Bq02vLT+IXwCBJNsd/4NU/zpm/nmee4uZxQ0v8maKTeW5dJHKuxKklw7Zf5a+NZuCjwTXVDbBycaBKqgIhf6R88iVw+15kY9S0fjNCsAGxJoc4jXV5+aLjYqxLeFC35Wv9lAnJjeCl/sPTe7Uq5dKMe4IEugMn74o0xlkRA6xQ1U78+op0Lwj+dAwnN7W9ufbZepXz2elDPfzfM5U1TrHAmreD85gsaAjnLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUPkQBpr6/1Y4oipU/xqfSWyl46voLjpxzjQQMnz8UM=;
 b=bDDNAapju6+V5DrOJ0DyvNIFRIztaF16lfFkOnpqDq+o+Bh/zzQxrjItfcK1rcnWwIZJEsHNEEHZWd6aCx0AEbR1cz3la/LpdbR9LgwXjhJZJfodN7DabLuFg98LgraXkqTlfqlRwVHV9ruhaTSSI8bikuksHBB3sTL8V+OpGZDvvG/mDwU9pfT61ZJWf1HavLTE8VE9SM3A5NVCWzkjQUYvW4vChVqLMkRk7ni83vPhdbfoxfgNsfUg3XM/6Agh/RE1jgTppgvUTSloEJ9Wlbrn1CaZqv7A6ke2M6KKqhG7SgvxxLIWySiUtWj/C+lKE19j38Xhj6rG+0/BOh4B5g==
Received: from SA0PR11CA0162.namprd11.prod.outlook.com (2603:10b6:806:1bb::17)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 08:52:33 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::68) by SA0PR11CA0162.outlook.office365.com
 (2603:10b6:806:1bb::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 08:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 08:52:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 01:52:17 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 01:52:16 -0700
Date: Fri, 24 Apr 2026 10:52:14 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Rayane Boussanni <rboussanni@gmail.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: query hardware capability for max lro size
Message-ID: <7z76boxf6nf3hzvspmc76ldy6idbynhusjcvlik2trkccupfiw@5ldoyqampej3>
References: <20260420184808.751-1-rboussanni@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260420184808.751-1-rboussanni@gmail.com>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: f610a4a8-2c2c-45e4-5612-08dea1ded338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SuhbnyhaN04T6a8MLMKREueBUDYqjDU0OpNohywP1FGmICiavd7j1CEeu+1vkUbY5It0BOnCGOlw1Jsuzh+cICYX6rXGa/vrivgSIJ0m4BWDAeNXOLhzQJAelmVt5iaIJeC9sAu6lpUdxjNXM6wbOF8cJyBnkTYfkoaAok5dkN4W5J9PovkuEAgR06JWLrGPYcLa75gMXwaj32K8dEJ48IvDPcMUQw2ZYTXdGON+C0WpvAjA/2PV0LQPsqGy6XP3xcojD4J9Bn5e6P6SLB0bIkah6kUs4xQwm7BVBgaCN/6qGn/Hdvpa1Omqx1av5NGong/5S/So/onsW6e69ksIXAVKYQ+Whnq1hUoIF9NL7l3efLk7KAejvbwUyXrT2ZhIsxRoxJJLax6QTZ1QpPuC/GtVymL/QYrquXxBR/sngSGgJlCmybBV/F7VTd4tqjgjmZFGonVVDroDdHsUk0Bi28FqOJtzKYVIP0EDj422tbwVJaJAnemJNYnRcSFZZX9wuGQPrYwGd4foSLTZLdHfP+twq8Kd3Ou4jL9gjPb+nI7qPseQ2wp31uN6w1dfaCYpSdbVl+zUBPhvUb7A4LWp3ZNxkPosENQgb/QdrMB6mJjt0YRBMsqgtDgGm+3nELO1ENa2isSyuzzBf5BTwDCkMBvKif4KzlW4bmz1fWmDABYj7MVWPjNa8a4ITlS1h1FhYJ8Ac7dtnpB8x5ECoaDRjNYaGHdAmDComc1FP7t6Q64n8zqVEtDbp7zENIVYD+Z2nZuJPuY8Z+F0YVD58EIUtQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FdtGeBDzLyJlDTIObb+G22923tmrJggMCCctI6+j4t6++FmrP4QDwwkB32MhkcFubNERKolyAD8/wSuDxoQXXMCJUtDQ4UIS5UQnugeUqfp4ACGMxepDPL2ZAJvDZgbcxm3vi3LObTV6fpoehzMeTWk9bNpNIFg6jIzmBBJNNbQFyl+Nk2GV6x//VKWgflQajXvu09lfp50VoqQyZ4BGoUCm0KZ7+c7VgGfh4s5vux/ReKZ0e9iHhp+uWv0WD/k5rZfQlY5TszGyDoUWBa+uYukvYhN4O0Ngtv3wvoEsRUcNQgYg7asYy1FJChksE9jseneJOlTAE70OOUVe8UTe27XzY0UguSoyPONxhB5gX7yBq6aJYQvHquwKSCAAJ4UtIBkzbDnUmmO5EgFNxAAOhIQsS1/idCn/m+oyhm+/T5GDnWl3ls2XMbEnRpF9HMzV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 08:52:33.0331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f610a4a8-2c2c-45e4-5612-08dea1ded338
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
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

Thank you for the contribution.

+cc mlx5 maintainers

On Mon, Apr 20, 2026 at 02:48:08PM -0400, Rayane Boussanni wrote:
> Resolve a FIXME in mlx5_dev_infos_get() by dynamically checking the
> hardware lro_cap flag instead of unconditionally advertising
> MLX5_MAX_LRO_SIZE. Retains the standard 32-byte fallback for
> min_rx_bufsize.
> 
> Signed-off-by: Rayane Boussanni <rboussanni@gmail.com>
> ---
>  drivers/net/mlx5/mlx5_ethdev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
> index a29cdeeb50..fb51de031b 100644
> --- a/drivers/net/mlx5/mlx5_ethdev.c
> +++ b/drivers/net/mlx5/mlx5_ethdev.c
> @@ -363,9 +363,9 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
>  	info->min_mtu = priv->min_mtu;
>  	info->max_mtu = priv->max_mtu;
>  	info->max_rx_pktlen = info->max_mtu + MLX5_ETH_OVERHEAD;
> -	/* FIXME: we should ask the device for these values. */
>  	info->min_rx_bufsize = 32;
> -	info->max_lro_pkt_size = MLX5_MAX_LRO_SIZE;
> +	info->max_lro_pkt_size = priv->sh->cdev->config.hca_attr.lro_cap ?
> +				 MLX5_MAX_LRO_SIZE : 0;

Could you please change the condition to use priv->sh->config.lro_allowed?
This field is used in other cases where LRO capability is checked,
since it covers both hca_attr and DevX support checks.

>  	/*
>  	 * Since we need one CQ per QP, the limit is the minimum number
>  	 * between the two values.

Best regards,
Dariusz Sosnowski
