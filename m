Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A744C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 15:14:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57748402C8;
	Tue,  3 Jun 2025 17:14:01 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
 by mails.dpdk.org (Postfix) with ESMTP id 356574028E
 for <dev@dpdk.org>; Tue,  3 Jun 2025 17:14:00 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5QZOxEla9XDFrBosTXDK2jfGfZ2R8Q2CuB3V3q7NbrhhtYYMPsbXX99VgsH48Ahj6i2sWlzyo8Ki3sBl7HAGMjjLxu2xBLCU3h/oTGWfOLS+2l9IRhDqBkomjkQmDHBXoklG11y5VWPjmDzvqsbHzPCw8dpqEHZ/EYIw/n0v/NSv+FJqjJcSbcvbDHkpktA1xEgtJVl1imWVRqr624BQr9hQunrzgzAF50ErTdow7Ug608oQPeiIIc1GaVALHT/Cyn6MmRcnVwqmSQI3OaK2xiZLS4aLaM+i81cELMRGJxy5IeOXgJl+NtMI15fgQz71YPcOFIiS+ch1cMwYKYC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7QYk0ni7pGKRKT81jY4j2tqGx/I7YsMbneUGWvNAFc=;
 b=DZyogu/5gqEaVE97Nb3aTn5bDhYRytSGFY/AZioLOLovhOVeeuvOta5jRby6aKS5cysyJq5ePBloIvYnOkxlnGE9/Q8n3yXHMFyniU4LsyBAyLFVFmDZ5jEZ2DsR3bhwAhIuaI20md38chKx5QKEcw/08CoRJ89Kf7VxsobPSBn32k2LzwqasV5WrLAdwz9dgHrj5bBGEGapoms3sm7ZMsJYANNw+UCZTZa3hRhD4sc+ZL9PsIWmldNnu4cmQcNMkEfYoTUnT1N+Qr5/yLBIoYyu6ggiOwLeFFrF/tlW1Amhwv/bV4l4wvbh8bXeLoYpLHUwMxJ6WymxCLKxiDIjVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7QYk0ni7pGKRKT81jY4j2tqGx/I7YsMbneUGWvNAFc=;
 b=jpCx3nX+a2iOaxSlm9ZjQtsbizH9uuMi5RG8YJvasXHbScpIQfYtWZbTPO5NOTQBVOtdaw66gsIeGDTw3zZ1oi7Th3rquVVowNWDcAeOzuPpFwDdgdnv3zxWvjDWYmWmKlP+/4/TTqslZM21RwZ/RIQkp/T7seAylD0HxMlbFm/i3PQhm2ZSXS+9kVqt2iicDpIAT/1kSZRO8rfT/QyLvXbhhYR7bRrEil/KsZn+17uyMpNHcsRZpNvuhSk6K0DMrwqOIYjrrFeE3tPNmSy8STMYuaEywcHsyB5n/AsJuarWzx0W0HpTqmcFdv+v9I6dRxcqO76ZXms+qoNF6y5mTA==
Received: from BN0PR10CA0019.namprd10.prod.outlook.com (2603:10b6:408:143::8)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 15:13:57 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:143:cafe::f5) by BN0PR10CA0019.outlook.office365.com
 (2603:10b6:408:143::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.32 via Frontend Transport; Tue,
 3 Jun 2025 15:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 15:13:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Jun 2025
 08:13:35 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 08:13:34 -0700
Date: Tue, 3 Jun 2025 17:13:14 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, <dev@dpdk.org>
Subject: Re: [PATCH] common/mlx5: use intrinsics instead of inline assembly
Message-ID: <20250603151253.jjctszshwamnepdy@ds-vm-debian.local>
References: <1746457062-8502-1-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1746457062-8502-1-git-send-email-andremue@linux.microsoft.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1f4209-005f-4515-e07e-08dda2b142fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/b1TAbzMCykvfNhImcMlmxIPEXU2LBhFvsVuZY+jTOtfvCH8gC90PSwKmrKI?=
 =?us-ascii?Q?dNDVYfAt4p0gW631Ox82s+qh0XiGFA3A7Mnd4tMtHgr7Ek/Er4VKnqU5X83l?=
 =?us-ascii?Q?0QUJIlJjXwkUPIeZmSA3yZyZX4EnZpFELskWKlO0Io15XJlj8RfOGFCc0//O?=
 =?us-ascii?Q?zI/Wbcdd80+zD02Bw7r/wzwOYpVT0K94CEBus2sEtJ3REetj0sm9xFKBXNSg?=
 =?us-ascii?Q?xh9KPjw/6T3uFQ8n7D98seAaJsWchdg0H29JqHv2YD7fUWtLgB0YfbGLlUsl?=
 =?us-ascii?Q?lAHFRnP2OS35vuYxjyI9o35mQaiqp/H1dTcnOZUr+7LEjEibqEMFDEZKsbwd?=
 =?us-ascii?Q?1bfe525EYSJgDFU4JZxKVZ/BD2y9+BjBsj2QAivLl8RzO/GaSZRpe1eRF1lp?=
 =?us-ascii?Q?/XTWF0qHEMJiHOyVKXTPzJWD9IOAJUFacAYT7mVxiHBMwkl5PZSuuFGZ1atW?=
 =?us-ascii?Q?rjU3Vkw1vCQ5YZ8LM452G7PfimhHIhwHgMXAGr3Pm3yuOtd4D8FmhPYolbD8?=
 =?us-ascii?Q?Rk5nni6SmO2YVHiiMTopnDuOZ0qMB9gJnhIACyYlHxdtAhkyDFjvNwLxRW9R?=
 =?us-ascii?Q?/SqdefA2N84f8fEZcoCFscdLck8sl2im8IYX7bkfc3ue1CvH4kPB2BBzxxWI?=
 =?us-ascii?Q?hp2MQ4NDz9ooIa0mzKTqAheWPS3VphkEg51i1htj150Ft+GxQ708BfbQXZfm?=
 =?us-ascii?Q?p1eHvhRJ5SiQ3ZVBZuo2lt5i6pQ/GV/gWQ/hvfzqz6aHfiNYh/5kKmMyCByr?=
 =?us-ascii?Q?uNnNIXd3RSvshSft9LCgcCwJdDkFRwaxQuprBKmERB4k0AG11q/Qu/XEtpc/?=
 =?us-ascii?Q?yACkpFNqqHJHDy7na4EwzPi5hYQ0Dx7ds8TCdXV/M7ILKbqg516HwJPRC/i0?=
 =?us-ascii?Q?vaKLvFFSNAVVtMu7skW4kog1z/8J1m/zYLabZhdGHMZwxZaFu8lSFu51sYKU?=
 =?us-ascii?Q?rC/DR/iZBTrUKDelvPxroQUrOO/GzNGrpJt3/Ha+aD/Q9Ue8nEd5Cfw6ulZ7?=
 =?us-ascii?Q?tM3NwMU8lI8KBscy4Vbn7KEMVfqvOws2ENebyh3Dx1TWDUShdWHH3fwAQGF4?=
 =?us-ascii?Q?/mfsXFf+Y83hXR1xhYVgSVSPSkX8Rxh+C7cgC+icYuulFWTi7L6jkyU2gdOy?=
 =?us-ascii?Q?hr4GLTXc2zd3R9NAI+Y+VZD3KPQikLVYzMacTKMPa8YMeRas3zrrDgnaWASX?=
 =?us-ascii?Q?OLrHfM9f/Q04loeyehu94qk3HTA9lcqGBLDirdWO+/nTq8UJeN58j+Ri4jrR?=
 =?us-ascii?Q?mOkU5Daqjz0X31lYMGAm/GJ9UefN7cnn3zAGH/7xaoYKHwP0891ZqEMoTJ9o?=
 =?us-ascii?Q?OaVUm6UCNiGRJv3jwl5HuXpdcqdCEsMwg8gHJV9GCPALvxET8lnypV/VPvek?=
 =?us-ascii?Q?uhuQjs7yYr6uWG/+4ZBCECVE+qhd2Z9Rkc5Wk6WD3tr5nUfnIiZuaPWsA2mW?=
 =?us-ascii?Q?wVMTjzzXYUPiSIfZZQLuJ2gJ9MimpX3SytazWIHqip5O0z4jcNA6a0CfxcWf?=
 =?us-ascii?Q?JyTTX9OOTvkO4dRIvpdPU2iPEIvJOs+lXxoT?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 15:13:57.1234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1f4209-005f-4515-e07e-08dda2b142fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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

On Mon, May 05, 2025 at 07:57:42AM -0700, Andre Muezerie wrote:
> When compiling with MSVC the errors below are hit because msvc does not
> support inline assembly:
> 
> 1)
> ../drivers/common/mlx5/mlx5_common.c(86): warning C4013: '__asm__'
>     undefined; assuming extern returning int
> ../drivers/common/mlx5/mlx5_common.c(87): error C2143: syntax error:
>      missing ')' before ':'
> 
> 2)
> ../drivers/net/mlx5/mlx5_txpp.c(510): error C2065: '__asm__':
>     undeclared identifier
> ../drivers/net/mlx5/mlx5_txpp.c(510): error C2143: syntax error:
>     missing ';' before 'volatile'
> 
> The fix for (1) is to use compiler intrinsic __cpuid and for (2)
> intrinsic _InterlockedCompareExchange128 can be used.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

*snip*

> diff --git a/drivers/net/mlx5/mlx5_txpp.c b/drivers/net/mlx5/mlx5_txpp.c
> index e6d3ad83e9..5bbaf668e6 100644
> --- a/drivers/net/mlx5/mlx5_txpp.c
> +++ b/drivers/net/mlx5/mlx5_txpp.c
> @@ -486,6 +486,20 @@ mlx5_txpp_cq_arm(struct mlx5_dev_ctx_shared *sh)
>  }
>  
>  #if defined(RTE_ARCH_X86_64)
> +#ifdef RTE_TOOLCHAIN_MSVC
> +static inline int
> +mlx5_atomic128_compare_exchange(rte_int128_t *dst,
> +				rte_int128_t *exp,
> +				const rte_int128_t *src)
> +{
> +	return (int)_InterlockedCompareExchange128(
> +		(int64_t volatile *)dst,
> +		src->val[1], /* exchange high */
> +		src->val[0], /* exchange low */
> +		(int64_t *)exp /* comparand result */
> +	);

There is one checkpatch warning to fix here:

	CHECK:OPEN_ENDED_LINE: Lines should not end with a '('
	#117: FILE: drivers/net/mlx5/mlx5_txpp.c:495:
	+	return (int)_InterlockedCompareExchange128(

Also, I don't think that comments for arguments are needed here.

Could you please organize the code as follows:

	return (int)_InterlockedCompareExchange128((int64_t volatile *)dst,
		src->val[1], src->val[0], (int64_t *)exp);

> +}
> +#else
>  static inline int
>  mlx5_atomic128_compare_exchange(rte_int128_t *dst,
>  				rte_int128_t *exp,
> @@ -510,6 +524,7 @@ mlx5_atomic128_compare_exchange(rte_int128_t *dst,
>  	return res;
>  }
>  #endif
> +#endif
>  
>  static inline void
>  mlx5_atomic_read_cqe(rte_int128_t *from, rte_int128_t *ts)

Best regards,
Dariusz Sosnowski
