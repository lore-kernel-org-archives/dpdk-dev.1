Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373B7109024D
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 16:06:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 273DE4025D;
	Thu, 19 Mar 2026 17:06:51 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
 by mails.dpdk.org (Postfix) with ESMTP id 46DB34013F;
 Thu, 19 Mar 2026 17:06:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPCdAs+qTPrNtp9BBeiNQkKaHOv18SgXnnTHunBwygSKfQHE+Fg5FWGuezxZdcw26RrnQ8IE79IhfLE6Lm0i5kl0gpAA2W213QUvURnjrD98Bhp3s4WFKSumyke4odLVugb2eTVXFUDq6vmzVmt7oeCzXiv9O5XRAfMgkQqU+rXErOzIr+W8D47VQ9Mw4e7LsZAPlxclQSE29/kgj+BRU7j01xNcfbVwn6VwATO/VqiSfjS7M1vhgiK9MWrzY7XlSRrfP6RvJirapi/t3p2Swhc6Udz3oY1xGlp3ZJjbzjt8itKFxQyq+i7ZzGOCZb6IhUJV5dKFmX2EReev4VpUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dW6AXuKP7wqs7q4U4lyJP/DlkqA5dX3uLICsr7HujSE=;
 b=R7C6iOwPTNKsG3ycngDBO30RKdFvFAAgQi8gQCfAXJLyKTyahow3cm+8rYWqKRwkxIz/sBC2p2P8xuPzqlBNYgaPssQM9FqdT3LoXRF0ny7z3kxPzN9rxXpmyqJRfTz/3ilDlIUGP8U31Vg9f0xXnHQGDVEoOdrnkqL40Uu3jPrzA8v5IzdnVU6+y0sO1S6Ettn3mo1DFMY1ssbIh0HkQfLtdcJ9dB9gbm4fJtumZ4MfMO6kjRv3GDuQkNoE4Uzh0G6F+F0u4aqsBRGpgx0cdYhIVMVPLeTd54Y8mp7ETsFvE4UIc+8vZ1jwP+wtTGzJ/z2WVU/tCFwurjXRrVM9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dW6AXuKP7wqs7q4U4lyJP/DlkqA5dX3uLICsr7HujSE=;
 b=f4DPPvc7Lf20qpdCLVRp//mEnrLVedAvq5Qr+cxBuzhJBraj8y9kgMG8C7WTQLRkGYFdh+dQaDQKrSZMn2PeR9XBg4aSKuYflus0rQtwM4MyQsQMINsTR2OhF8eEw2wdme9xLeATZMNXoVXAsFR1woQ7r9Z1kFuCwBmGfpxyRtkMzybgRuWGy7GuqBIiuE+QgQKbM9fpPNy+RLtTbFmwaChkKeu9Oqy/C/Gs71M+61RyKFCT7MXctKm2L91Rcj7nsjdlY2zaCcBlP11bLdRf14ACzkLDlhmn2ek7v29R9Edi1S0YFbZMFkjkgjT68YvPYlta/g6gNf6BKdVnK3pN7Q==
Received: from SJ0PR03CA0188.namprd03.prod.outlook.com (2603:10b6:a03:2ef::13)
 by SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 16:06:44 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::29) by SJ0PR03CA0188.outlook.office365.com
 (2603:10b6:a03:2ef::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 16:06:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 16:06:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 09:06:22 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 09:06:21 -0700
Date: Thu, 19 Mar 2026 17:06:20 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Adrien Mazarguil <adrien.mazarguil@6wind.com>, "Nelio
 Laranjeiro" <nelio.laranjeiro@6wind.com>
Subject: Re: [PATCH] common/mlx5: fix mac deletion on Linux
Message-ID: <jnenabfqrgsmz4erfktd7osqcjw3vewajffyjwmuxhf6s4r4yw@zmlfmipdrpnr>
References: <20260318163628.609968-1-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260318163628.609968-1-david.marchand@redhat.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|SA1PR12MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: df7e2cb1-b38e-4cbe-36c0-08de85d18448
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|7053199007|56012099003|22082099003|18002099003|27256017;
X-Microsoft-Antispam-Message-Info: 3lw+4vkpX2LntmVe1lDImXz3/yQ4sZ6xk8A8qsEzaawM0x5vur4Zioz4WRqGz/ggvGroiJz2D9+ldabcbNUyCb47s3h3oMg/IL+tSsIBAF5xJkze1Javxph0VB4DbbWMZI97JGvTWryyx38cKIULP5F+cri2OJCRPoUam7Rb1FeVhJ7pkyJCfPIpEDJt3MY8x0lOIaWGbJZBVoayrLYvj79m4DUXyiJmgTTt+eWHOAG/rE/0Q7Ga8xTNyIHeTuDslFeTHi44U3h8s5NTzBnOjYkrInYL7g9iLWyiZTJh/7mfkhRDEg2Ovrz7gxkmBO5r18JL0cqeuNReg+Iq8dkcgAKfVLmTHpNCI/abdk3oEWWTqA15BSn11Dz6Vt/2l8LiuZXcBMrYX7dJCHIDOci4HJty3yB6btv8Vq170aeYvEpfh9jnDEZflnI18Ts77501TyLORMO+4luluAjAFZeZE0W1sN1xc31Fcqk2f8xHBDy5jnib0frNNj113B0Cy+g8j5VgKeF+KStZWj6vhleanDcVXwXTBmog4nNYkliFgDNypn0ki57DM9pgZUyYxunCWnKubhgMDmO4D1g0vjzuvkeKQ4/9kNzxEfAA+I0OK3EugEo2xlrJxpbiqeQZVvGrfc9hRckuoQFgnOQ6Ps0D/oGpcuHOxCCJxMrpfDH9tExTjwkQcvprKB7nDU1L8zNjS1Ss0SvOc7wZiGExKnhFY3+BblRbdg9s2h0xaq9XU7Md9z4PxNwkUv84m0n1NqnCiIU29/QEodvBlXPFlFudcVHLSq1vHXWljFhmAXoz/t7gyfro9hYNh6yETXX8UMPcQo4cVsCg/Rx0gFaTv+AGvg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(7053199007)(56012099003)(22082099003)(18002099003)(27256017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Be/5DmMUdtNZkfVB6C2bBWgk1baq3/exh1k04yh5dTf91Z2yi1gMrwOCLRcqVkMYgqynJ6/oQTBtppSTIo7yH7uv3TKvcGZhhKITjcht8M1+Wrm2UaBcWzronfx5LcEaGIsw1yFL/uhXiwtEgeb0IW7BzsIXYyoPX5NELmVX4KsRZn4HoJkZRTvVgC3cskqcI4ctQx6oOPIwdEdaUmKTVjDCDL6aVX7P30Ud1HOxK3g07Fm0v/BFau/v/WqgXOMo6O2iMMKqGRES3jyqp1U50D0sOrfPl4H5MlwzZMbIvHuF6CYvZESBkOYgS0boLs+19au8F8p6PtO/kMoP701sfxyTA5Wgb3v7+pWHvZ4TTlm+wARdn6U4+tg2N9s9dgvhX7NgKkYeLNY4tCNIC6VyA1un/YqW4Mdxx6vcoLO8/7aDWNOxIe/C26Ts/08mhpt1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:06:44.5731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df7e2cb1-b38e-4cbe-36c0-08de85d18448
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173
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

On Wed, Mar 18, 2026 at 05:36:28PM +0100, David Marchand wrote:
> Re-enable debug logs unconditionally, this helps understanding why mac
> deletions were silently failing (while a bridge fdb del command was
> working fine).
> 
> testpmd> mac_addr add 0 FA:35:44:3F:58:31
> testpmd> mac_addr remove 0 FA:35:44:3F:58:31
> mlx5_common: Interface 35 cannot remove MAC address FA:35:44:3F:58:31
> 	Operation not supported
> 
> Then, fix mac deletion as the NLM_F_CREATE == 0x200 flag is relevant
> with a RTM_NEWNEIGH op.
> For a RTM_DELNEIGH op, 0x200 == NLM_F_BULK and passing this flag
> makes the deletion fail miserably for a single mac.
> 
> Fixes: ccdcba53a3f4 ("net/mlx5: use Netlink to add/remove MAC addresses")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/common/mlx5/linux/mlx5_nl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
> index eceb3d796f..b50431fb61 100644
> --- a/drivers/common/mlx5/linux/mlx5_nl.c
> +++ b/drivers/common/mlx5/linux/mlx5_nl.c
> @@ -581,8 +581,8 @@ mlx5_nl_mac_addr_modify(int nlsk_fd, unsigned int iface_idx,
>  	} req = {
>  		.hdr = {
>  			.nlmsg_len = NLMSG_LENGTH(sizeof(struct ndmsg)),
> -			.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE |
> -				NLM_F_EXCL | NLM_F_ACK,
> +			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK |
> +				add ? NLM_F_CREATE | NLM_F_EXCL : 0,

It seems that this expression is constructed incorrectly.
IIUC this will be "parenthesised" as follows:

	((NLM_F_REQUEST | NLM_F_ACK) | add) ? (NLM_F_CREATE | NLM_F_EXCL) : 0

Since bitwise OR has higher precendence.
So "add" value will be ignored and only "NLM_F_CREATE | NLM_F_EXCL"
will be returned.

Could you please add parenthesis around the ternary?

>  			.nlmsg_type = add ? RTM_NEWNEIGH : RTM_DELNEIGH,
>  		},
>  		.ndm = {
> @@ -612,7 +612,6 @@ mlx5_nl_mac_addr_modify(int nlsk_fd, unsigned int iface_idx,
>  		goto error;
>  	return 0;
>  error:
> -#ifdef RTE_PMD_MLX5_DEBUG
>  	{
>  		char m[RTE_ETHER_ADDR_FMT_SIZE];
>  
> @@ -622,7 +621,6 @@ mlx5_nl_mac_addr_modify(int nlsk_fd, unsigned int iface_idx,
>  			iface_idx,
>  			add ? "add" : "remove", m, strerror(rte_errno));
>  	}
> -#endif
>  	return -rte_errno;
>  }
>  

Best regards,
Dariusz Sosnowski
