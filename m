Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83868C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 14:49:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94694402C8;
	Tue,  3 Jun 2025 16:49:45 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by mails.dpdk.org (Postfix) with ESMTP id A350B4028E
 for <dev@dpdk.org>; Tue,  3 Jun 2025 16:49:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHV/jo/k5+njk2wBruOgPfOL+T37vSIp8SdMlbFFpU5Tn22Q8feagoeBkzrxU8BzhMAy0Iug0yzhdtwkfu4wci7Ej1paiQ0Kba8ofAbB4nOe69VyNTDtklC2pEVfD37KQCRkK/spzeEn5wQ+xnPIvPhUCqZu38LS+/fa2cabeu2m/rtRrvTAAL7g98eG5laJcYdohaEmXPJ8wCvodOWIj4qMkwxCA7+zFn8XltcLimyzJ26+Ny4L7DwAg+ktBW52GdQ5NlBtVKn4n5TnjDUh+cY6iecWfzZWFc7BAdjoVBXQClYe71hGgHCe0RQ9Zk1SvfgMhO3nLUrFdgODKk0HCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P14Z2x6yqCmWiatLd7tqIrExAdfoOZr/C/HeO4GVed4=;
 b=K4wWimwG/299zQUKyaRVDRBSIjRewHjH5QhElCAc0Raa3hs4uWYFSXPepJfTE2ujG4zrB5p27jdUSmgY5bQoXdMyvX4wQufoOjMbNe61ob7Cun2MCJoJZPJ+FcbmYO9FXgmOeLjsHkBS4Wi81zE0jcYnnwF8VwwD0ABtoY6+9Mk+0jCbguj0IR7BzpL1HNYWCd3QYzJdFiaE54wo7pWlENHLiXQDFujnEDvjZONrxW3iTOftCyQ4ACMzmD2tolNUK3+eM4qnujkBGCxfARapqubFpU8aYzp3A+wiX4opWOjPMk7diXXi6xYqnOR633CIb/cI+LQVc4x9UMcXmZNFuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P14Z2x6yqCmWiatLd7tqIrExAdfoOZr/C/HeO4GVed4=;
 b=sikpvsUWKmaid3pYndX0gsDQ7eDEn9r52pHl7REiKIG19PZWX4nAkPvb+C1ub+ZPMukderey35a2xpai9hPKc7td2Apcb8iW+/ZPIBjlBh3KrEFzxv3b6zGbaj16TvJ13jIM71Lx8MNUIpG26Tv7OaGsARAz2mGvn+s5wRLQ6WPIcXXUitO2RRTG4mm9ppQdltQ7yZK45BdRvwtp6L/bBoEErcp/6nXlLNl+N2trJO8YjeR1cGExys9DUTNduGLzwg7q5dP1iUp1FpQmwgPHF/0uCMkCBIlefIACqqx3C5wPx1EZ7nnOryKOPAj2MI975WDjLTZd9GRq1I7yGk5DSw==
Received: from SA9PR03CA0009.namprd03.prod.outlook.com (2603:10b6:806:20::14)
 by PH7PR12MB7305.namprd12.prod.outlook.com (2603:10b6:510:209::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 3 Jun
 2025 14:49:38 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::b7) by SA9PR03CA0009.outlook.office365.com
 (2603:10b6:806:20::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 3 Jun 2025 14:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 14:49:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Jun 2025
 07:49:25 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 07:49:24 -0700
Date: Tue, 3 Jun 2025 16:49:04 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Wenbo Liu <liuwenbo109@gmail.com>
CC: <rasland@nvidia.com>, <dev@dpdk.org>, <viacheslavo@nvidia.com>,
 <bingz@nvidia.com>, <orika@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>
Subject: Re: [PATCH] drivers/net/mlx5: fix mlx5 send packet failed
Message-ID: <20250603144830.4scggdn33lfmiuqy@ds-vm-debian.local>
References: <1742899140-2013-1-git-send-email-liuwenbo109@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1742899140-2013-1-git-send-email-liuwenbo109@gmail.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|PH7PR12MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d108520-ba48-4a76-de0e-08dda2addd97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+6dO6gC8O6n9iCvJCGUsEUIRgvJKIcLBCUlEiOvgpuc4FYIpFJIpT3tikhqg?=
 =?us-ascii?Q?O4enTj4CU9Kl232tZNFijAIM1uPYEQS0+qfbW4VMYbEklQ8mE72ccrtH6dLe?=
 =?us-ascii?Q?3XIqvzvOeGl7PD+vv1R767x0jZYNBraLZxpngat+EnuEtTvNZ556CSmdxhX5?=
 =?us-ascii?Q?7c++lqJ3mzzbe4BY9BFOfCXipu9Hy1MroKLFI88ZDCx3/h0T1PHZ3Hr5Ii2/?=
 =?us-ascii?Q?T9X8lYGNfl1bnGY8k461qQYF66Na35JGBgkJ9Kk1VKXj8m6UuRh2INSy+wSM?=
 =?us-ascii?Q?Qez9YDrZlU4CXE/8/HfcU1sjPtWDtMb49SvD28hsyYGJ6GFCGSfdtyJBLNcw?=
 =?us-ascii?Q?3D697zkM7LG9XmiG/UAUaxKQc5JzMQejvUctU8g6naKwnfbQGUoMmxGyvq5O?=
 =?us-ascii?Q?EzOeqY8BEA8Ge3s5Bhvc7jdqpO91lLd7OJvDGdHGYk+PJxjJwMsxFbRouUHr?=
 =?us-ascii?Q?DpX3bB1gp2kjrFDDX4hg/69XsmnwXkd5MtA+C5mGN86dEvhYDBp4gHWD6W0y?=
 =?us-ascii?Q?wowIFG7TAE1TP4SzruCkXjoTT5nT7BsG2vOMj0n/HwF0QMDeI7ZDhVcf0kkC?=
 =?us-ascii?Q?cdW77G/KJ26N/1hAl2IHMgiBsX/4BDRxvzoYptQ+raD3j5p63g/vhIXQigfs?=
 =?us-ascii?Q?AIPhhYo2vGU45R8JBMBlUSLUdmlVvpg4AmjFmVE6m/9mEXKdDNMj0qALgIDA?=
 =?us-ascii?Q?qusJef5jnVSPETpQz3SVCg+SxzLe8ZZUIn8iYp1CHiwhyACRVXEPGaz/EShG?=
 =?us-ascii?Q?zPSiDvaWBU/LhgCxkDPw20TckjwR3teg5eZoVxXOmknexe/fcns5fgIoyo/M?=
 =?us-ascii?Q?Y/bDFJvxKfaVF9Yp2lS2uMB0fXvFJYwvzRGaO67iAM5n9Qr8dzRIeAzSs+0Q?=
 =?us-ascii?Q?9kC6S/qP9EPl5UlAuRFCg1F1CiKVDtCjklBQybDkZ2d+q7Hq3crEgU8Fimfw?=
 =?us-ascii?Q?P/DLXEjlxNqNEqiiT2GjvYZEOsKNu1SU5AX/jEilXdMhA/X7y84YPXqy7mkd?=
 =?us-ascii?Q?LsDu6H86zXmL0T/vO6/NPHeeeLRD/l8NkBhYvD+JMhbES5e9VEH3AklJwBoP?=
 =?us-ascii?Q?5/+g7HgSHDwidm7K1dnTgb9bpvKtyPlBgGTOOqQyGZmNdz/yGUOVt82PSSBW?=
 =?us-ascii?Q?XlS0L7MdqyvKTorx9YXFd77nW0+PKWjKJm+8EZqKyKYuFbuzFXoLNTDEuypb?=
 =?us-ascii?Q?qtdnqGi2imXpkYucICdGpXHKW27NR/2werjvzAc6jyfw4q1uviLyMuyeFtum?=
 =?us-ascii?Q?i6vZGiIgB/rhcs27c+6hh0NmPs+Qmi3IJeXLI0A8Zk89/gIQ0HubCQxv5TnK?=
 =?us-ascii?Q?N/jmPY/l4qwJXKyPeVW+HomovciL64bOtcY1KjbakEJ8Xh63YiKOVbzx60En?=
 =?us-ascii?Q?9c57DXfPFfyiE1umN/QZWCkgQXal5Dv3DJL/VeChH/LOa/Thogj1rZYLmZ6X?=
 =?us-ascii?Q?xNn8EMrRzLRQvGKA86aCH2HE1uXcS3RfTXkzG+0M6UMU1IPdHloDuwdVqHsT?=
 =?us-ascii?Q?gme9Y/Kb263+xR1ucmsc2lE+J1SGEs6uojW1QiVQPx3UPhCd7NUASzBSog?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 14:49:38.5994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d108520-ba48-4a76-de0e-08dda2addd97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305
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

Adding all mlx5 maintainers.

On Tue, Mar 25, 2025 at 06:39:00PM +0800, Wenbo Liu wrote:
> Test Environment: ARM architecture, OpenEuler operating system
> CPU: HUAWEI Kunpeng 920 5220, BIOS Vendor ID: HiSilicon
> Network Card: Mellanox Technologies MT27800 Family [ConnectX-5]
> DPDK program sending self-encapsulated packets with MAC, IP, and UDP headers
> continuously prints the following errors and ceases packet transmission
> 
> mlx5_common: Failed to modify SQ using DevX
> mlx5_net: Cannot change the Tx SQ state to RESET Remote I/O error
> 
> Signed-off-by: Wenbo Liu <liuwenbo109@gmail.com>
> ---
>  drivers/net/mlx5/mlx5_tx.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mlx5/mlx5_tx.c b/drivers/net/mlx5/mlx5_tx.c
> index 4286876..5cf9873 100644
> --- a/drivers/net/mlx5/mlx5_tx.c
> +++ b/drivers/net/mlx5/mlx5_tx.c
> @@ -186,6 +186,7 @@
>  	volatile struct mlx5_cqe *last_cqe = NULL;
>  	bool ring_doorbell = false;
>  	int ret;
> +	int offset = 0;
>  
>  	do {
>  		volatile struct mlx5_cqe *cqe;
> @@ -205,8 +206,11 @@
>  			 * here, before we might perform SQ reset.
>  			 */
>  			rte_wmb();
> +#if (RTE_CACHE_LINE_SIZE == 128)
> +                        offset = 64;
> +#endif
>  			ret = mlx5_tx_error_cqe_handle
> -				(txq, (volatile struct mlx5_error_cqe *)cqe);
> +				(txq, (volatile struct mlx5_err_cqe *)(((char *)cqe) + offset));

Could you please elaborate what exactly that changes?
I think I'm missing something.
mlx5_error_cqe, used here originally, takes into account the
possibility of cache line being 128B
(https://github.com/DPDK/dpdk/blob/main/drivers/common/mlx5/mlx5_prm.h#L427)
and this achieves the equivalent to the above diff.

>  			if (unlikely(ret < 0)) {
>  				/*
>  				 * Some error occurred on queue error
> -- 
> 1.8.3.1
> 

Best regards,
Dariusz Sosnowski
