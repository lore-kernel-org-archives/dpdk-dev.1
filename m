Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF2FC83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 10:58:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F46A4021E;
	Mon, 21 Jul 2025 12:58:52 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
 by mails.dpdk.org (Postfix) with ESMTP id 9A6AA4014F;
 Mon, 21 Jul 2025 12:58:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZas7Va8N141mzPdX52CB3/sJTtAxU8NTOug6uvo6gCz60jwV5Xs1NiPvNkla/hIOQrZX1P1+nXh/8rJfrm4fgEHrl5aZMSQ/ukVJ+MJ34Pfy7YPazxIvKrfvNAj9WUFR4XjY2/fq1xTzJ2HQ4txyShstRIJHQ9x6YmYareRDnkwIj76KtN0mAPYWaxQWpQfkCM1yu8j2lTp5cN7E+ogVP1jbZLZWNXWpnkt2f4wthg5Th/dhnQiYSR3JvOUHRvHizawu/FlygpLmIPydXxnVgcHpLBIvhMZZ/g99Gb9ZqQE9jb/PrDYGNXHrX1f+8nXoWt9F++Ck9bAKyzJi4AwAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhJa59b+KG2oBWANRtVH+jVck51TvIwnkIws/vppFls=;
 b=dopnxKiG1gylpEgK/M3StZDpKCEMzUB+qQ8HA2LAx8w4erFtM8IWWcG/q8lp+FIh1IB7/UlavfHhjGhvQbFfHT76XIH7U9ZU/TfeqF286z5BGNVSyamIlvbcObxWMPL+SLqkqm7kpaqpKTfZ7cYBxp9cz3ZmpwhutWeYERs1MHZS6HEuqGVonHP5x3UI3mq+8W/wG84yRp2SB7TH7Xtyc+vcTgHJVJrhBihZEC8b6hpGUjUWWWz//oRAvR3lcF/C0x98SYzqeDtWlswPrmYG4jTzcNXOxlavuGW0kZk7hBq3BxvnKLheFbnSVnkmPK/nyar4RPlaaOam1fSrfuNXkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=uetpeshawar.edu.pk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhJa59b+KG2oBWANRtVH+jVck51TvIwnkIws/vppFls=;
 b=ks4v6RF+mHa8OPOneruf053Wz2u21eKlNk+hZXwMZTWv7/2u45JtoMQEbyq5kdsDgvQyIWQj8f+rEV+lAvgM8K8G+DDnhABrJ8clh2uGWvK8CYCsrP06rq8cor5yOBD+aPrQ2K0LLJw5oV6GPnMBykej0VFRPR8UsAzoXsoOp1x9N9gAtCo+8YTH99R4oLciY3veemTXgvksSrxJJMG6iWsTRP/aeqdC9rCbaGNzMX7+22PA8mWjRqWbIg+/7pktQuZrBlq4EuhNBJNBkuUFEzfLyQNZLu4UvGHlv1k3kbAxA3p+drOijvkjk3MZ2PkrdFveQ7BouiWPjc7tksIBKA==
Received: from BYAPR08CA0051.namprd08.prod.outlook.com (2603:10b6:a03:117::28)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Mon, 21 Jul
 2025 10:58:46 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::df) by BYAPR08CA0051.outlook.office365.com
 (2603:10b6:a03:117::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 10:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 10:58:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Jul
 2025 03:58:31 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 21 Jul
 2025 03:58:30 -0700
Date: Mon, 21 Jul 2025 12:58:19 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>, Thomas Monjalon
 <thomas@monjalon.net>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix crash when secondary queries dev info
 after primary exits
Message-ID: <20250721105819.2ci66fl7bzikwb22@ds-vm-debian.local>
References: <20250721073851.963141-1-14pwcse1224@uetpeshawar.edu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250721073851.963141-1-14pwcse1224@uetpeshawar.edu.pk>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: a3388a14-5af3-4554-19b9-08ddc84590aa
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iCKywfHmVtidCM/DtsoIE8KaQZ9yWIlT9CSGjI+W8xzsNpuWnPsmhFoHjJGp?=
 =?us-ascii?Q?3XX3yu4zdwzOY00pCIbcm5OtKdb6YPZXJ9kocxJnJ27ynee3Q+b5KXqKwQUf?=
 =?us-ascii?Q?2Ud7TkPdOX0vAuIk5tFHnE6PL3KCSkMdwgjUPeLJcWSY8e3r/5kNDLezMdNF?=
 =?us-ascii?Q?fQDlIirwunISvI2JoGwVihxk202Ge82hUpbcTNtcD1xfOBG73DDL6GKhhJGz?=
 =?us-ascii?Q?IcUoke5HB8LuCBgVy8LmySCt1pJViQZYBcr9L1Dov0S8I22SFfwAOgHkKU71?=
 =?us-ascii?Q?GQTOCgeTMlutkVKrqLoGj2HIv894T//+0sezEH1shG9W+yO+E55EWybGAy8Z?=
 =?us-ascii?Q?LlEQKdBddlvXMq8doM5KhcCgYYMEspxsN2E5prVm9syelxUeDjZiZxBe4ktb?=
 =?us-ascii?Q?qVCf9/HpL8MJ1LepPK1/t9Pa8ipfg40PLJufcIUeKB7pIownYyrGVg9XItpp?=
 =?us-ascii?Q?3V599vn5y/2TtqLPscRBXpzRMyOEc9OLKKCYqtfmmD9+AVzx6uJ1Udqug6/d?=
 =?us-ascii?Q?cvpqUH1GMppi5bN6G9+TqTv7UsZnVvQCVz6dapdNM2/iuMT+rDkZFrdV1Lez?=
 =?us-ascii?Q?xOqTRLj6wl2DBCfOmoe+5kCmPLHc6ooVHPvEB6b588x9NCZir7HrVrPRh/Ek?=
 =?us-ascii?Q?k9czu4qAvhMKtMQA9d1PhUv1hTOqsHOLBuxZ0rJhqLNAdxgrXpEHTwjKL4kh?=
 =?us-ascii?Q?R1mZl2pQYyV3PKjn5m8hnPtkehgnYQHeVuNBiHffAxOo7sVCWju2pVnto4VK?=
 =?us-ascii?Q?cwfjTFm3ZX4eEXUfFRG6ZY+9WVoLbNlJ83BvryOsJ1m3zzNoRzFYOqiBrftt?=
 =?us-ascii?Q?66At1A+mZCDz3adOdWhhSvgWLaxs+CcShflKoKeg3m0yCqNDp+4E9cQcqmCo?=
 =?us-ascii?Q?ufnGqabgMoMt3We4D+A19Qc6353Hz5S1/xB7fDUDBY1A6FWme3h9LNUVKMLY?=
 =?us-ascii?Q?eSz+sOJbey4DRmXQ8fHEAZnEPYZ7LsU05yW4lU6RX6CYT2l4kDOn9k/cxQT/?=
 =?us-ascii?Q?tT7n6AG4cgGMC/eugqeRjJdc35m9POf0oT7if3sUZA1jXQejSL8zKX41J9jo?=
 =?us-ascii?Q?UlE6n5zAZmxYK/jWoocsHpEnRZinjmDF72Q/dQcDaAQtQLhQqHFJbGDJeDNI?=
 =?us-ascii?Q?awMjyO2+jrjKd82azcMh1Fo+seRi32wQgV8oM0lpcuSE5k/g5rJdUsvK8Fme?=
 =?us-ascii?Q?fpHxm5SW9+3SJ+89JtXwq6HORHdai0Whaill/zveWbXNE6wtorxZ5hOvkqYP?=
 =?us-ascii?Q?x+apCtQ9zGCdTC7WnsGYo3WmqkScms2+ajxoROqyjWqbc9Q3lyngI9pbYzqi?=
 =?us-ascii?Q?3hLmn3eFKoBW2gApmYYS+3ULssWVW3iMxMetXMYP2PpfC3Snr9UeTg8sEC5H?=
 =?us-ascii?Q?CBPfrF793eQoEZM/smRu0N9Rz/Zv8uPUgAZtIOwh3AriY/FecOx4I1DWJxuW?=
 =?us-ascii?Q?Pxas2JODNJHePlnzi/zR/FPhY7NX3LmuFZX1cFg481skxKQbFc0ntbPv6GMv?=
 =?us-ascii?Q?1ADChF8hFDCjHuVqCErnW077jJh3erZM4ukhKF42Bpe8KnSuYhoTLTxVfw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7053199007)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 10:58:46.0393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3388a14-5af3-4554-19b9-08ddc84590aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257
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

+ mlx5 maintainers

Thank you for the patch.

Could you please include other PMD maintainers (or other maintainers, depending on changed code)
in the future patches?
There is a script which automatically adds maintainers while sending a patch.
It is described in: https://doc.dpdk.org/guides/contributing/patches.html#sending-patches

On Mon, Jul 21, 2025 at 03:38:51AM -0400, Khadem Ullah wrote:
> When the primary process exits, the shared mlx5 state becomes
> unavailable to secondary processes. If a secondary process attempts
> to query device information (e.g., via testpmd), a NULL dereference
> may occur due to missing shared data.
> 
> This patch adds a check for shared context availability and fails
> gracefully while preventing a crash.
> 
> Fixes: e60fbd5b24fc ("mlx5: add device configure/start/stop")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---
>  drivers/net/mlx5/mlx5_ethdev.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
> index 68d1c1bfa7..1848f6536a 100644
> --- a/drivers/net/mlx5/mlx5_ethdev.c
> +++ b/drivers/net/mlx5/mlx5_ethdev.c
> @@ -368,6 +368,12 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
>  	 * Since we need one CQ per QP, the limit is the minimum number
>  	 * between the two values.
>  	 */
> +	if (priv == NULL || priv->sh == NULL) {
> +		DRV_LOG(ERR,
> +		"mlx5 shared data unavailable (primary process likely exited)");
> +		rte_errno = ENODEV;
> +		return -rte_errno;
> +	}

I don't think it's an issue on PMD level, but rather on
ethdev/multi-process handling level.

When primary process closes the port, ethdev library zeroes and frees
device data shared between processes.
ethdev port data (rte_eth_dev) on secondary is not updated so it now points to
invalid data. rte_eth_dev_info_get() is not the only API call affected.

If the primary process closes the port before exiting
(like testpmd does) and it exits before the secondary,
the any driver call seems invalid because of that use-after-free behavior.

@Thomas, @Andrew - Do you happen to know if doing anything on ethdev ports
in secondary process after primary has gracefully exited is supported?

>  	max = RTE_MIN(priv->sh->dev_cap.max_cq, priv->sh->dev_cap.max_qp);
>  	/* max_rx_queues is uint16_t. */
>  	max = RTE_MIN(max, (unsigned int)UINT16_MAX);
> -- 
> 2.43.0
> 
