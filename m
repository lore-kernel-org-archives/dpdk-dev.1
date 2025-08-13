Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A5EC87FCF
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 14:17:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37DF140657;
	Wed, 13 Aug 2025 16:17:57 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by mails.dpdk.org (Postfix) with ESMTP id 5F7B840265;
 Wed, 13 Aug 2025 16:17:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJ3FT0jCmQqVBFNFBxA4I0E4Tw4oshEG+wbqHLi4SsVuV4DTYF5lNFSy9DuRvIM6CelW4VL/s25ZsmN6WUHjeCrddqwXhhOMVas/jy3wRWTVu5yh/BVaKHcl05hReKrgjdQZ1I1wOnxlHwRpYkspgivQAyhX0s6pTMiYJ9UnOiEepMw8uCO24YxIcEUUV3anLN3hEP8U3PEg+BUCNDAQsyKT50zHJ0YZHgg+FGcAcn299j3tvAEvkh8c5mEVLdcPsX4ZhKEim9lGmPqr/tIPZqW8c8INlugWNC/3DVgNx5zAu81tTywEomUBbJafxGxU/W+4vlgVGgMy5JK+i5JH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ND4rJXMCg9MLha+USgwmHixWOZwumRTtakuMHt6cXNw=;
 b=wfaZErKZJtfQVH3TJncH2Xv883W+iBmrP5yj2WikWx9+Dn1pNUpODaPrmK+20i+eUxYQcpDCS1hEZa551Pv8VC42djJzmhJsQx6r0evo6aWpMqekRF3Hg9hgGj74TCPV1nRrD18VAGeCemhg5NpKjVrgoPnz5zRoOnRwLTrdmBmRrdxyzWF+AItG9ikiTwrTHu/3yBLtu3Ue5edcG9F9B1CGf38/fcpKEa8xxyeQrRbquIrImItfVoDsOxtRgk6F9B5NKH11GBKx7s1C14tLOcl2isPdCAWaMbRx97ezMGH/bfw9SpdFaNvL0cWCDRql/bZYiirqesu+q7dRqmji+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=uetpeshawar.edu.pk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND4rJXMCg9MLha+USgwmHixWOZwumRTtakuMHt6cXNw=;
 b=UrrGVyWFIahMuNGuCLvAtiHgRtsWSwt+W7g6uAE/BpD8yw2MFaPrXsW85ktrYP7P7zKgNRqcPKnZPUI+IY0CeMuh+tnotMuGGprfGMGKy8YHiPt8Of22PdcJQxFvjtwwkdh8JiOQuVFbWJVrYRvjgOn25N241fsTOc0jN3etUOgPLGcCLTJsYuwnhJBxkbqzabbOzFdAhyEyP+yIBqWt6w5oVvUVwxe6WihhtVREaE2jxxjeNH4hEy4tDkRVFGCH2R9iOUSac9iEEKNyFTYxORLRdSi/jfXZ5BiB+pydLzFjCBejghj60zZqucvbiYjszvVLuWBLyz1fReaKpb06Ww==
Received: from BY5PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:1e0::34)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 14:17:52 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::28) by BY5PR03CA0024.outlook.office365.com
 (2603:10b6:a03:1e0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 14:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 14:17:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 07:17:32 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 07:17:31 -0700
Date: Wed, 13 Aug 2025 16:16:14 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>, Thomas Monjalon
 <thomas@monjalon.net>, David Marchand <david.marchand@redhat.com>, "Ali
 Alnubani" <alialnu@nvidia.com>
CC: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, <dev@dpdk.org>,
 <stable@dpdk.org>
Subject: Re: [PATCH v2] net/mlx5: fix connection tracking state item validation
Message-ID: <20250813141614.yiwou5lbd4exybnv@ds-vm-debian.local>
References: <20250805132318.480413-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250812124630.2916225-1-14pwcse1224@uetpeshawar.edu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250812124630.2916225-1-14pwcse1224@uetpeshawar.edu.pk>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: ed575b1d-b091-484c-490c-08ddda74302c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q+oAnDYg2ufsV4vtqvUURUpZ+nqC6z/sT0rB9xkszHkYCjml1WZF4jWzCsTG?=
 =?us-ascii?Q?ky6Pm5+JSHhhTN/JEorbuOBQfhKaJ/nz+EwM+xHDeHZNlaJ2dfybJGhiiIvK?=
 =?us-ascii?Q?CPG2tBpZYEKmVcvupgdHp88akDl5bFpZJ8D9U77UZV4OPaUk/BWi7VTHIoOM?=
 =?us-ascii?Q?4pkXCs1TXWSK7AZmKrUO86CHRVZQdO5lS/sEO25DX+4Ll2Jp1XnucJanuSIh?=
 =?us-ascii?Q?+0reAs+m1zn+vuK0c1HipiJ714vI6Sj9f8MwgOtNlKuYXNuvWrh0hxLRfc8X?=
 =?us-ascii?Q?K6EoHxokilaZLhbRbKRrvLBgCnmWLvgnlS7BKvKO9z985XxgD5L7X7awdO1f?=
 =?us-ascii?Q?DhX0AX0OvDCcpCrbpf+9YGGZHtEURJrB3PV6KL4ZzMQBcFzw83j86k1TiNVf?=
 =?us-ascii?Q?6zqZTp5d40vUY2xtX6QNaJ1jpKsXj7dA/JGAPrhad8hSbcdL74lRUJcmJOvX?=
 =?us-ascii?Q?tAB5bdu/iWTsEBdyaAjqsnR+RiDSktf/fuNCXY0R9mAhy3SFiVtYc0L3pyfd?=
 =?us-ascii?Q?axtavH6gTNwme5V1fTS4TRlKxJDDZPyZoB+FJ/xl4XyBUQa1wmHmukjSw05I?=
 =?us-ascii?Q?5B57Cb2jwKlqtjbSXUP7n+N2iUpRu19tcE937odWxsMlJTJuMN1dfqYvRiiv?=
 =?us-ascii?Q?+pKA8I5UlOkgx6W0B5s7tpNU27zrRQhafE2l/bSlbFlXJXkIMlutPHse1LK/?=
 =?us-ascii?Q?ViSp6R8i9hOH2aRtVgL47S7biNpgPQSeOsEOMW6eCiUcX9GOfmU4a/8Rr7Po?=
 =?us-ascii?Q?PI2jncCtNC40fVYA8jIKfBX0btgVdwtE/DAXTkAv4FLSLtScT7yrGGk5t8jQ?=
 =?us-ascii?Q?ShAMuhvdCFMhNjfb7NnKGMtkAtefsQUOchLxUHapd5p5+f82G76+rygXkyAX?=
 =?us-ascii?Q?fAhTwcYtM781IKC6eOrfKsle+qjCj5+2eGYfNG2NArnmbxf37zwdyZ3VWZlv?=
 =?us-ascii?Q?8vUfr3Z86vReqsfnLuexkPosTTyuK5o5e2Q6SMXLTIwpat3HSJndXTr74PZC?=
 =?us-ascii?Q?vM+c/lhri9bEn3hlQYnD+xAJD8oSgi7snsB4zOZMM3OBhj2nQZJxRq6NdQmM?=
 =?us-ascii?Q?qRpLuaGbxGwu8x2HW2qW8PNsoidHriilVSxVqFEtVdm5e903LGbKaBtn7QaA?=
 =?us-ascii?Q?argJcP89zzkaEmBjWwKUiIGz3gyTHnjM83bGdBpnpjiuforfO9+DgmreoMmW?=
 =?us-ascii?Q?n0Q2KAJIBNa+B1a64KvAmXph18N10RDEgkcXul969KbW/9irmZdaUpWdUqMd?=
 =?us-ascii?Q?SWL/X+I9A6Zd64ngZIRfvwepydK05n2TkbrjGG10yXzGB1VG4II2HmmMSx8E?=
 =?us-ascii?Q?73V6B2WdTtS+VroE/Cj/ZVZtzHLjokpX2tcPB648rZCm/hZ+oKb5NbsGrHXE?=
 =?us-ascii?Q?NJmZXUNv+iEyNc4ob+PayN3eBZ36K4wyeiPxPAyUTg7YlYHsh8+jsTRyuaid?=
 =?us-ascii?Q?n/DrmEl1zp7/IjczDeI2burBXBH31abnEOwx23aPJEk4rddV4syvq1QEzqwH?=
 =?us-ascii?Q?/vrMVZR93ho6zF7mMkI7TVnHuWEUG+grY18MKQuzmLww/3YGG94yMvnxDg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 14:17:51.4771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed575b1d-b091-484c-490c-08ddda74302c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078
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

Thank you for the patch. Please see comments inline.

On Tue, Aug 12, 2025 at 08:46:30AM -0400, Khadem Ullah wrote:
> This patch validate a connection tracking state when matching
> 'conntrack is' in rte_flow rules. Since conntrack item flags
> is a bitmap, then any combination of RTE_FLOW_CONNTRACK_PKT_STATE_*
> flags is a valid value to match on.
> 
> This patch validate the CT state item.
> Fixes: aca19061e4b9 ('net/mlx5: validate connection tracking item')

When used locally ./devtool/checkpatches.sh reports the following:

	WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes: <12+ chars of sha1> ("<title line>")' - ie: 'Fixes: aca19061e4b9 ("net/mlx5: validate connection tracking item")'
	#12:
	Fixes: aca19061e4b9 ('net/mlx5: validate connection tracking item')

but it's not reported in "ci/checkpatch" job in Patchwork.
This check was added in Linux 6.1: https://github.com/torvalds/linux/commit/bd17e036b495bebbf07a5fc814c868e30e1dc131
so it appears that checkpatch.pl version used in CI is older than that.
Locally, I have a version from Linux 6.16.

Ali, Thomas, David: What do you think about updating the version of
checkpatch.pl used in community CI?

Khadem: Could you please fix the quotations marks in Fixes tag according to the error?

For the future, you can set up a git alias, which can be used
to automatically generate a correct tag.
It is described in: https://doc.dpdk.org/guides/contributing/patches.html#commit-messages-body

> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---
>  drivers/net/mlx5/mlx5_flow_dv.c | 12 +++++++++++-
>  drivers/net/mlx5/mlx5_flow_hw.c | 17 ++++++++++++++++-
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
> index 7b9e5018b8..19475b931f 100644
> --- a/drivers/net/mlx5/mlx5_flow_dv.c
> +++ b/drivers/net/mlx5/mlx5_flow_dv.c
> @@ -3271,7 +3271,7 @@ mlx5_flow_dv_validate_item_aso_ct(struct rte_eth_dev *dev,
>  {
>  	const struct rte_flow_item_conntrack *spec = item->spec;
>  	const struct rte_flow_item_conntrack *mask = item->mask;
> -	uint32_t flags;
> +	uint32_t flags, flags_all;
>  
>  	if (*item_flags & MLX5_FLOW_LAYER_ASO_CT)
>  		return rte_flow_error_set(error, EINVAL,
> @@ -3289,6 +3289,16 @@ mlx5_flow_dv_validate_item_aso_ct(struct rte_eth_dev *dev,
>  						  RTE_FLOW_ERROR_TYPE_ITEM,
>  						  NULL,
>  						  "Conflict status bits");
> +		flags_all = (RTE_FLOW_CONNTRACK_PKT_STATE_VALID |
> +				RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED |
> +				RTE_FLOW_CONNTRACK_PKT_STATE_INVALID |
> +				RTE_FLOW_CONNTRACK_PKT_STATE_DISABLED |
> +				RTE_FLOW_CONNTRACK_PKT_STATE_BAD);

I think it would be better to define a macro for "all possible packet state
flags", because now the definition of all flags is repeated in 2 places.
Could you please add MLX5_FLOW_CONNTRACK_PKT_STATE_ALL macro to mlx5_flow.h?

> +		if (spec->flags & ~flags_all)
> +			return rte_flow_error_set(error, EINVAL,
> +					RTE_FLOW_ERROR_TYPE_ITEM,
> +					NULL,
> +					"Invalid CT item matching \n");

Please remove the new line character and preceding space from error message here.
rte_flow_error_set() does not print the message, it only stores
the pointer to error message in rte_flow_error struct.
Users later can print it/log it however they like.

I also propose to change the message itself, so it better pinpoints
the exact error. For example: "Invalid CT item flags".

Please apply the same to the second instance of that error.

>  	}
>  	/* State change also needs to be considered. */
>  	*item_flags |= MLX5_FLOW_LAYER_ASO_CT;
> diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
> index 6dc16f80d3..6dbbc44819 100644
> --- a/drivers/net/mlx5/mlx5_flow_hw.c
> +++ b/drivers/net/mlx5/mlx5_flow_hw.c
> @@ -16957,7 +16957,6 @@ flow_hw_validate_rule_pattern(struct rte_eth_dev *dev,
>  {
>  	const struct rte_flow_pattern_template *pt;
>  	const struct rte_flow_item *pt_item;
> -

When you'll be sending a new version, could you reapply this empty line?
It's removal is not needed.

> /* snip rest of the diff */

Best regards,
Dariusz Sosnowski
