Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7A2CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 10:15:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2DF840659;
	Tue, 28 Oct 2025 11:15:55 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
 by mails.dpdk.org (Postfix) with ESMTP id 0DC454021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 11:15:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+5h8HDKQ4p6R6xPEqMzK0DWxURS9VEzTHotpuPevq/Ks9stnRcARP6KMd+A428LB5dJUxabGjkIc9E0r+pNyeysJkodadD72aNiMI1Y4V1nJRpcrlbust5QJxvbuNUZZCELB27tgzjWpdIFg6xk65tznaX19J7TWqEIkn6JJiXekxwXgOTeDX1X5MlDm2QKAXGVLYc9xQ4gtu+fi0GxVtv1p0b8stZfcZukaIRFWyy84TxUscIMUTLN3Orj5oRSajdjTUGlNQP9UEmUM7DyoKSiQ+kCaEW6clsiuO/zZLxobDSH9I8QXAs3Sx0hNFYKFvld804FKWph2h9hIGxpyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRdlM30uPp48YP//8empzRmIUlsU+p2rY+H+sp/+pJU=;
 b=Q2J0AymKu1Z6c38WfmRBRcmGdCw/gephrqaRMXiELSG3megpf0pUolBbC9AOPIN4rT52J/jafrjnkf2QUR0s+aDYM3fU7JKCWjI7/MZBqZBGjLDgadhu5KFsIS0p2T4K6bpIpcKMFQyyWUCWGfoKIDsQXdYBHpAC1FDdBl1BBqVNUsEREcoXd/kWFP9A/Jmo9NgGwRFfxSn103AaqdK/IBew+bt7SObbhIeihYDfWwoUDecWlEZyiY3OBMXTZFnLM2R87xXorpMNdNx/7oIJgaM5eaFLwN4vb9ON9GB3m4MyiF6I4B3/W1Iepp6HSLuS6O5OHiyAToZFsf0+HkSDdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRdlM30uPp48YP//8empzRmIUlsU+p2rY+H+sp/+pJU=;
 b=rggxImbjGSW/UOE0VkG+A6Gji2H/DhQjSnBs8z3H0e8do/BfOEJzP0QFCfkzfvH6Jllf86FCSRrvY5gn8X1yqzuUB35XhBymN74krHjM2UzFZ2jHCK++wInsZHbN1kFDGNIVBdBpMg48VfU2oaiK7dpbqY2dgIH4jyJ/60+roDh7cwrgjq2rukQrcoZ7acoXkqatnGCx2xiZtcuaARMsvqSCpQRA6BGZ7CbuA0FrfqOlyi8vJD1NdgO5RhVtplclGjG7xkF51q4OZVoSNyRdATVvPeDW5c4C+LkcPHLBobqMNZ6natzQXcXEcP3f7EP40LYWrO2EOBZWVi7hxmTHQA==
Received: from CH0P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::28)
 by LV8PR12MB9617.namprd12.prod.outlook.com (2603:10b6:408:2a0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 10:15:48 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::7) by CH0P221CA0011.outlook.office365.com
 (2603:10b6:610:11c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 10:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 10:15:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 28 Oct
 2025 03:15:33 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 03:15:33 -0700
Date: Tue, 28 Oct 2025 11:14:27 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Rongwei Liu <rongweil@nvidia.com>
CC: <dev@dpdk.org>, <matan@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <thomas@monjalon.net>, Bing Zhao
 <bingz@nvidia.com>
Subject: Re: [PATCH v1] net/mlx5: remove counter alignment
Message-ID: <20251028101427.7swzqvc5o3ofzdxg@ds-vm-debian.local>
References: <20251028092611.1755141-1-rongweil@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028092611.1755141-1-rongweil@nvidia.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|LV8PR12MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e420485-2217-42a1-fdb0-08de160af700
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jn3FO3CB+5hEqw319cOuGtY1enLmpQfPqO93jJdupW8iighc2G9EOi5jbZdv?=
 =?us-ascii?Q?LWScZE0lftKuMS9C8ZdX4aquiQSPeVV+h/S/ij3A8b3NR9wzP6yKcC9kg5LR?=
 =?us-ascii?Q?KN7zfwFVC+/NKxqf2gKh37wrteCHRHSBbbotqSXIUYbRWqS40RNgzwM7efER?=
 =?us-ascii?Q?Cy6Pr9h4AkwX6cE8RSRSJtkTE+Nd/JneJCc5Itay9jnXut8xih491KtaNRg3?=
 =?us-ascii?Q?WheBJxPDnFi0Fzh90BuFCZZFVChEs3iwCMhhe2MVp88n31azTWBQqGDcXCwX?=
 =?us-ascii?Q?s2FNUuen5SCmRNBkdrr5gVDiYDCdMSu6yJCNGFcdfYVZe+CuYL0hdCTzvu2N?=
 =?us-ascii?Q?hRpSKuGyj39ldTqWt1fFQlQ/+6BebgnwPz2QpaLAG+N6O3M98TGiYq/FxP5F?=
 =?us-ascii?Q?Y2Dt4zPdtEWl/ZnbUIiiaoPLugLLsiIsJ4sILz6bn2rpve5u/WfMH9rDkIPP?=
 =?us-ascii?Q?cs0mlgMADgFLQ10/NSW8rCiNPE6K10ZW+TTyxcGwxN5ZLKNa/ifjWI8C3xW4?=
 =?us-ascii?Q?Hh2P+TG0LLwB29ZKEClCdXhThCGB6/7Hz+NnDNsmgkUShYJl9NdPkQoADt/3?=
 =?us-ascii?Q?E9ys5xaE3uzuyi4Bs9Gkf4L7WcJ1uBuX+oDHz9ib99QfCoJkJqnCdkRNCo2O?=
 =?us-ascii?Q?Xwmz/4Wxzz+SeJVsyrsi92qhVjqdmnUD1EQ+E2nbXLKpNLZJ+Gs5JskPGILS?=
 =?us-ascii?Q?GEhiRgQG0+gNG8J8Kwo40D8RiRayPNzRkfhN7tc0E4NNF3w0L4oAp/JWtrjG?=
 =?us-ascii?Q?Jd87KM0D+9CuaNUUyFj2gi1Td7p7EhK6SSZigyye3cGgvUHelLB0MhyuzJfd?=
 =?us-ascii?Q?kZSVCdCWZ0RfsfhA1b+Lcfz5SSycxx3QJwLhJgccv+2DmjzglPPwdacd8A36?=
 =?us-ascii?Q?4Z7E6GnKZHRdXkgW8Fcbyy2Hp7+dct/U4BUzFjsB3l/ME97ZwA57zOsxKlfY?=
 =?us-ascii?Q?n5UywmLY55P1wpX35+oQm4PRZKyAJILWFRFLhTqM6GX5NjuSuJqOfplTJH+T?=
 =?us-ascii?Q?DTN04AdwC176LtjPUmH8od6oK85Mr/ymL6oDc/QF/uKN1MY0LIQwRZK+92qZ?=
 =?us-ascii?Q?paedknTNf1TyMvyr0AbfFph/5D4RVCVFqHRQMJFyBRL0r8LYWFgLlHQV2GyD?=
 =?us-ascii?Q?vjSaPCcF11o2lIUSLkT0lHZl/iPVWYx4AAQPdvbuhk9/xE3QssxaNayjM+f/?=
 =?us-ascii?Q?rWPh25ursOgT7HZMHsIJMkQe93tULKaaJfuv17scyz6jqpP4US8rksoO5yjt?=
 =?us-ascii?Q?fbR2YT1WKnqDCYsMdMebQDWjZagx4eWJz8FEzxu6/FCrbsn/cI6oYqNG3LSP?=
 =?us-ascii?Q?cNa9c1rApjBy53C+ZHpUO4ijbvs09+09HmhJexmyNFybZy1wOIdDrVL4w/1v?=
 =?us-ascii?Q?HKuYU2CTHrw049OVgiexyQbaRAPk2AVrJNNeCKpF0KWE8F0Sb2NkWCdOeUiN?=
 =?us-ascii?Q?pUZ8dpIm4fbO3RlpjOj84528AtyvsV+oKBwkJUmvmJUA5w6QR1oU7A2NCx28?=
 =?us-ascii?Q?KCsdqAezuqr1HYXTz/kQSNqwy3ziG82KJLlGQbjvtuuY6v3Vv+GDfsfSr+ki?=
 =?us-ascii?Q?TcPdVKtga3krZwBFWiw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 10:15:48.1068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e420485-2217-42a1-fdb0-08de160af700
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9617
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

On Tue, Oct 28, 2025 at 11:26:11AM +0200, Rongwei Liu wrote:
> The memory footprint was increased due to the alignment.

s/alignment/overalignment/

For clarity that the relevant fields were overaligned.

> 
> Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
> ---

Since this is a bug fix, please add Fixes tag for the following commit:

	820ca7361bb7 ("net/mlx5: fix flow aging race condition")

Cc-ing to stable mailing list won't be needed,
because the offending patch is only in 25.11-rc1

>  drivers/net/mlx5/mlx5_hws_cnt.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/mlx5/mlx5_hws_cnt.h b/drivers/net/mlx5/mlx5_hws_cnt.h
> index f5b7e8f643..d19a7bf37e 100644
> --- a/drivers/net/mlx5/mlx5_hws_cnt.h
> +++ b/drivers/net/mlx5/mlx5_hws_cnt.h
> @@ -43,7 +43,7 @@ struct mlx5_hws_cnt_dcs_mng {
>  };
>  
>  union mlx5_hws_cnt_state {
> -	alignas(RTE_CACHE_LINE_SIZE) RTE_ATOMIC(uint32_t)data;
> +	RTE_ATOMIC(uint32_t)data;

Please add a space between `RTE_ATOMIC(uint32_t)` and `data`.

>  	struct {
>  		uint32_t in_used:1;
>  		/* Indicator whether this counter in used or in pool. */
> @@ -64,7 +64,7 @@ struct mlx5_hws_cnt {
>  	struct flow_counter_stats reset;
>  	union mlx5_hws_cnt_state cnt_state;
>  	/* This struct is only meaningful when user own this counter. */
> -	alignas(RTE_CACHE_LINE_SIZE) RTE_ATOMIC(uint32_t)query_gen_when_free;
> +	RTE_ATOMIC(uint32_t)query_gen_when_free;

Same as above.

>  	/*
>  	 * When PMD own this counter (user put back counter to PMD
>  	 * counter pool, i.e), this field recorded value of counter
> -- 
> 2.27.0
> 

Best regards,
Dariusz Sosnowski
