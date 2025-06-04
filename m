Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE59C5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 15:29:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFD2D42DF1;
	Wed,  4 Jun 2025 17:29:28 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by mails.dpdk.org (Postfix) with ESMTP id 5F06B402B1
 for <dev@dpdk.org>; Wed,  4 Jun 2025 17:29:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLKsR0W0N3ZnGe09Z5kHGayY/Ln+gbI7gCNV6gn1zTezHzcisqHv0TISIN1Za0hvXHtk/5qzTzOBIKk7k0dqCm8RaZqLrZYjWeCu2cEISnbRc1xuNjID7BAw4ZPZmld6M5ZH2PNeWNyr0MbvhQ5ZblcMNhSrZQ1MQmQx/4US54ufLXrkI+adW/qtdngpn0augk/Y2ufidEPCmQKyR99Tomedrk937ai35mw8THTmD3LNOvSazx/xWNw8N3DPnT0v/trCuZmtVZRowQC4/PmK1el8jrYvbuMitkXa1bBhyYcujQo8JNah1m/0Ej/Om3diBPyL2BGU/PLNvDi3eBKPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9js84FaGcXL5eq3hvCOyeDUhHoE+4PXhrQkjN3XegY=;
 b=c3c3v+PscB0UiNF3HSyPjr7bkzVMs1pKrzH3opm6ufYQQRnID2ooQvFWsd4lORq+jb5XkUJE1CJF2nkdr55Q/YPop8e/tUZ/jNeuBg5wpcP1v5eSUngcSrVAfKiZBrzEHgEBb+MI4sgiwMvUUb7YHZVDieQ+xoZO7RsVA1BBAW8+yfwD+r8Fn++SxWZsmN4oQr1cBCHRdftAJHtCf08okvGP8gxuwPuTb0ZVxzvQ3M2T7NzW9AR1st4g3wzGBW2YcBhZsjS4O19vuzbJC06sO3FVIrcgAdOc4XtoDEPBL5mzNz8RGz9CsIuau4VNb9ac84PJ1+sVGMwwekJBpX4dKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9js84FaGcXL5eq3hvCOyeDUhHoE+4PXhrQkjN3XegY=;
 b=Ss7IF2rhV2MjoLsNluHUtpgCt9CqXKk4j14uL9zMR7NB6MCpIphYaQIlEzYj5WObJToQ2tc7MT1p0ZxzFtHFC7XTw2RXDcfrrSxIlW0RG3fHYTOWgpmsxOCoaF6Ab5QALImhWYUbEh0JZ5iXEX9eB31oxZMgoCBZi4ZaJ8f4K0++BgZJHOwNMM9/BqJdQuT8GsoL5yif4XhYEzx14CPXmxVFffhKNtHnEGVL2zfiya6op6OQV4LspGyFeKww1owObnBP8RCX1uxIWIxDK8uQ+F8rkGnsLZNvKSMwQsxTmXXK7gfnvZ4BAQIiXKdExhciEo1m9BZtOIUClK3y+LSTJQ==
Received: from MN2PR22CA0030.namprd22.prod.outlook.com (2603:10b6:208:238::35)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 15:29:21 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::c1) by MN2PR22CA0030.outlook.office365.com
 (2603:10b6:208:238::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Wed,
 4 Jun 2025 15:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 15:29:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Jun 2025
 08:29:04 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 4 Jun
 2025 08:29:03 -0700
Date: Wed, 4 Jun 2025 17:28:57 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <bingz@nvidia.com>, <dev@dpdk.org>, <matan@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <viacheslavo@nvidia.com>,
 <mkashani@nvidia.com>
Subject: Re: [PATCH v2] net/mlx5: declare size of rte_v128u32_t
Message-ID: <20250604152857.fnsui4nwbr5tyjqn@ds-vm-debian.local>
References: <1746457823-11135-1-git-send-email-andremue@linux.microsoft.com>
 <1748650917-31700-1-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1748650917-31700-1-git-send-email-andremue@linux.microsoft.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SA0PR12MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3a58e1-d90b-4205-654c-08dda37c9419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TDSWqf/ZiVYH/I0boIYtXHMoU7kEuKwgnbxqeVXlIVqAHIDC3mpe05gAq8/6?=
 =?us-ascii?Q?BJVsJu7+U8OF+5gqb6wJo+9Q/6VYbu2C3EJXzSiky348I2SmthIzv8FkMv+k?=
 =?us-ascii?Q?Dht/v9KMn8sAQq8fcKvR++DOnArHEbDFKMAEGojDKXBQwb5DUCHQZS7NCLFt?=
 =?us-ascii?Q?hT6LHR73YfBE4eNwhxpeIOGhqnhPTY7LODvqIy0VZyFfUdb0hfXpqf/NOUwa?=
 =?us-ascii?Q?/QNFXDk5Cpl3wneHY5CYvZlMcUPXjd2qufIMDuPNHh3Jo8X7Wn9x/QeHRWKG?=
 =?us-ascii?Q?7CNPNQxepb2r1BAqgq/UTFc8KpSJ1YZhWVkfsVpBUTlivkZY2VfpMzL9NXQH?=
 =?us-ascii?Q?mCv/JnLtn8vwCKyfL3yDx1t4qoGN9dyocbr1l2nqqQ89ur9HkemkouRxBiqv?=
 =?us-ascii?Q?WDQIH+B/wcw2hQR4D7eZKr9EvWypXg7E2m8xysCV4rnCaMrVkRv5P1r0Z/pz?=
 =?us-ascii?Q?AN859OHuEgVT47o078OgkOXKV5lm+N62uSZ5O66H81KvyNeJ+w+v+HLjbDij?=
 =?us-ascii?Q?RNIixEARsfeIwvsPd/NNNXs1SbNFxuWb2HXb4XL2iE7Q67/apVDXmd0Xdzi5?=
 =?us-ascii?Q?XLESdUkZ617FkY6qJu846l+mfPIplh5rcwNyO83YZnlOu1llc6fsLHSQrul8?=
 =?us-ascii?Q?8jIbqW2frmap0rfwrvlIYx+puClsfBcA8byeOjVCslXMfZsLY2eqB7BdWw2Q?=
 =?us-ascii?Q?DfKn/bQMVtovWW2vwWN2AafxHuFR9NRqyppQFsTqa56fCYzKIdoj33237QjZ?=
 =?us-ascii?Q?nivHbirrbiXTIbsZew7Mdcc5qcodAZymTt1ZN/1q8pmqY4cS31YI3wCyDFBy?=
 =?us-ascii?Q?6JXViyv2g2MWNB11nHll6nmPFnV6YJg6p5VW8ds3+AEAKm2dfnzXXFN+SBLt?=
 =?us-ascii?Q?nPr+TskgzkKNevU4SvFQvU9GIV5gaEXWZpBJBbFrSO19J9lhNNvDKK88XpnM?=
 =?us-ascii?Q?Dx7vYenhHgsYh3nKzaFKT+pKYgih6sgmg3iRRydxTY3n508ecthYLATegmmE?=
 =?us-ascii?Q?1lz0f8LtEPUqB9LeGAqTuFN3jRH3rPiyQwIfSLMhWGfQXlYsPP0uVeG+6zSb?=
 =?us-ascii?Q?SdB/vVPXv5TXP20uVEqMGm9RaowrEJMpq1l0jz5m3wKkG6Ir/BN2RTTXZ7N/?=
 =?us-ascii?Q?h0vqRgyythKT8UvdP5JH7jkDUczRlRQ7oJV3VXb8di8T9uUwHve4ixq1IctY?=
 =?us-ascii?Q?v8gPFUaCsAdJvs7/A3BVvscHKzQbX2n/N46X3Jf8igrP/mrGUhF3y/UujfDV?=
 =?us-ascii?Q?2BKVaSZgpQJEeooLXIC2IxsDurABIE6KDLsLlRfWnwH0ZgAZjs7cqzNg0jG/?=
 =?us-ascii?Q?PMtyOeO7YMfsTy+X5styo5mjgUyUurDialvuZ92hEEttd134UAd9zfYXUe3B?=
 =?us-ascii?Q?43pu+0rVp1zpnVtlaO0W5aLIaW8VeeWidI5jEpIAzZwkDxWGeQR2F4PTa49N?=
 =?us-ascii?Q?Y1dU5svpvFUPf6qwLNI9Y7gQOSqQdkKi6vkfJOhzkhtLGUYghWHGAyKmWw+x?=
 =?us-ascii?Q?iei9pVHZXjIGYO/6FGYTDJQyHyu+rhTZwZHf?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 15:29:21.0454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3a58e1-d90b-4205-654c-08dda37c9419
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
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

On Fri, May 30, 2025 at 05:21:57PM -0700, Andre Muezerie wrote:
> When compiling with MSVC the error below is hit:
> 
> drivers\net\mlx5\mlx5_tx.h(1148): error C2065: 'rte_v128u32_t':
>     undeclared identifier
> 
> Turns out that with MSVC the data type rte_v128u32_t is not used, but
> its size needs to be known. This patch defines a macro to store that
> size and replaces instances of sizeof(rte_v128u32_t) with that macro.
> 
> A static assert is added to ensure the new macro never diverges from
> sizeof(rte_v128u32_t).
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  drivers/net/mlx5/mlx5_defs.h |  2 ++
>  drivers/net/mlx5/mlx5_rxtx.c | 11 ++++++++---
>  drivers/net/mlx5/mlx5_tx.h   |  2 +-
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/mlx5/mlx5_defs.h b/drivers/net/mlx5/mlx5_defs.h
> index 9c454983be..c5e2c59309 100644
> --- a/drivers/net/mlx5/mlx5_defs.h
> +++ b/drivers/net/mlx5/mlx5_defs.h
> @@ -196,4 +196,6 @@
>  
>  #define MLX5_CNT_SVC_CYCLE_TIME_DEFAULT 500
>  
> +#define MLX5_SIZEOF_V128U32_T 16
> +
>  #endif /* RTE_PMD_MLX5_DEFS_H_ */
> diff --git a/drivers/net/mlx5/mlx5_rxtx.c b/drivers/net/mlx5/mlx5_rxtx.c
> index 9c075f6a56..3f4942e225 100644
> --- a/drivers/net/mlx5/mlx5_rxtx.c
> +++ b/drivers/net/mlx5/mlx5_rxtx.c
> @@ -28,11 +28,16 @@
>  #include "mlx5_tx.h"
>  
>  /* static asserts */
> +#ifndef RTE_TOOLCHAIN_MSVC
> +static_assert(sizeof(rte_v128u32_t) == MLX5_SIZEOF_V128U32_T,
> +		"MLX5_SIZEOF_V128U32_T must hold sizeof(rte_v128u32_t)");
> +#endif

Thank you for the patch.
This proposal is ok, but I think it can be slightly improved.

The reference to rte_v128u32_t (in code and in names) can be removed, because
the code which relies on MLX5_ESEG_MIN_INLINE_SIZE does not really use
rte_v128u32_t type. The relevant code e.g., in mlx5_tx_eseg_dmin(),
always copies first 2 bytes of the packet (through uint16_t pointer,
these would be first 2 bytes of destination MAC address)
and then does one of the two:

1. Copies following 16 bytes using rte_mov16().
   (Corresponds to first static_assert for MLX5_ESEG_MIN_INLINE_SIZE).
2. If there is a VLAN defined in mbuf, then:
   - the rest of destination MAC address is copied,
   - source MAC address is copied,
   - VLAN is inserted,
   - 2 bytes appearing after VLAN header are copied.
   (Corresponds to 2nd static_assert for MLX5_ESEG_MIN_INLINE_SIZE).

Amount of data copied is inferred from HW arch and packet descriptor
layout, not rte_v128u32_t.

Since rte_mov16() is used in real code and rte_v128u32_t is only used to
carry over the length of the copy, I would propose to:

- Replace instances of sizeof(rte_v128u32_t) with a macro named MLX5_SIZE_MOV16
  to better reflect the real usage in mlx5 PMD.
- Remove static_assert for
  "sizeof(rte_v128u32_t) == MLX5_SIZEOF_V128U32_T".

Would you be able to apply these changes?

> +
>  static_assert(MLX5_CQE_STATUS_HW_OWN < 0, "Must be negative value");
>  static_assert(MLX5_CQE_STATUS_SW_OWN < 0, "Must be negative value");
>  static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
>  		(sizeof(uint16_t) +
> -		 sizeof(rte_v128u32_t)),
> +		MLX5_SIZEOF_V128U32_T),
>  		"invalid Ethernet Segment data size");
>  static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
>  		(sizeof(uint16_t) +
> @@ -41,7 +46,7 @@ static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
>  		"invalid Ethernet Segment data size");
>  static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
>  		(sizeof(uint16_t) +
> -		 sizeof(rte_v128u32_t)),
> +		MLX5_SIZEOF_V128U32_T),
>  		"invalid Ethernet Segment data size");
>  static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
>  		(sizeof(uint16_t) +
> @@ -50,7 +55,7 @@ static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
>  		"invalid Ethernet Segment data size");
>  static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
>  		(sizeof(uint16_t) +
> -		 sizeof(rte_v128u32_t)),
> +		MLX5_SIZEOF_V128U32_T),
>  		"invalid Ethernet Segment data size");
>  static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
>  		(sizeof(uint16_t) +
> diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
> index 55568c41b1..5647f6a37d 100644
> --- a/drivers/net/mlx5/mlx5_tx.h
> +++ b/drivers/net/mlx5/mlx5_tx.h
> @@ -1145,7 +1145,7 @@ mlx5_tx_eseg_data(struct mlx5_txq_data *__rte_restrict txq,
>  	} else {
>  		/* Fill the gap in the title WQEBB with inline data. */
>  		rte_mov16(pdst, psrc);
> -		psrc += sizeof(rte_v128u32_t);
> +		psrc += MLX5_SIZEOF_V128U32_T;
>  	}
>  	pdst = (uint8_t *)(es + 2);
>  	MLX5_ASSERT(inlen >= MLX5_ESEG_MIN_INLINE_SIZE);
> -- 
> 2.49.0.vfs.0.3
> 

Best regards,
Dariusz Sosnowski
