Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B014FC5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 14:39:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F77640EE7;
	Mon,  9 Jun 2025 16:39:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 8DD1940EDB
 for <dev@dpdk.org>; Mon,  9 Jun 2025 16:39:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749479956; x=1781015956;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=PJDVFFlcwbFQ1DLgqD3StCaNxaFirseuloX4GWP0uaU=;
 b=XbvYasQ4ZK2ku48o67OjndPN/9hiwCDDljRRkT1zeKiQuHGyQZA80enO
 jI3WXBJ0oG01XbgeCIkc7Y1cqhs23Mma8T55wJzK6nrau/eVOJ/6a9AWt
 M1pqmKY4dybx2jiwZQoi0m/lvA24RGQPItMy1+EJYQXCf9I/6RNYPl/Le
 CPRipVNbXQd/QtpNsg6aBalXnH+IsxKqNXxKlXUFRnpouHEdwCIdVB6nn
 VKIFqyTPZGMMxk7u7qPYDPGY12Ws0PxFXFj849Aae0THone6t0J0gGtPE
 gnXTRdla6Cp9SYWVMs03Ea6lh1ljCp2JinBzU19iLlaeMWxA8xP2IGo34 A==;
X-CSE-ConnectionGUID: RWQDjL5rTpOvvfBuXmvMJA==
X-CSE-MsgGUID: QixPvEWfR4mw4ILsRH7ZAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55350786"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="55350786"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 07:39:13 -0700
X-CSE-ConnectionGUID: QSzTRFBKTJuQplMcxE6PXw==
X-CSE-MsgGUID: Qn55mZ2fSK6I/xJMDOiLhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="147498009"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 07:39:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 07:39:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 07:39:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.70) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 07:39:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WureYWN+uvqIZVYsD8uyhjWsavLSGzMbYnKmV7+9xXAiVCKNtwLR98lUWpeARIJsyD21VEyUTOvQSa2XD3bFQD7cVkf0vUCaCa3DS5TwqEF9DahiqUjZEiDSx8e8UOQfhlf9YGJV5L+NDyoPxmhnWSM1ydDpBaQJGTJUxkI/kS+Yjiq4T8fwtoyNRqI0CawjQuomCyLNjfcq07Wq2CYtBLfEA/5YIecNjXe+89sC+Hq9OYviGtKCrZA4W19lPCrRVsKnu97q7IGD7cx4d8+qF2+Mg6J69rbj2G+gqCn/fKQWDduZ4KxNNHdXrBdjilUVX5A9mDj3DOCt1SgWg4gzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cLxV9BA9TciyPI1VqGy/Z5iqJDLc5vu5Lk8IHtsicE=;
 b=NCLfWesHETjE5ltd4yYkBR3/pgyLLhYFxCRkYl3YfRDePPALBwstmiB+67NYpynTHi5caYwuauLXiHS8c6Bs5y8KhiacCL8ZFJtQls4Fy08hzg4raidB3n6blJZBom7om0ODsHIwHQclMZlopD1NCjAFKjbptwTr8FlhLin0xG2Kw79kTfKpIG4bCb3XEd7Hhpc2Hvr9cfLzOjYzmRyJf8VF5xct5Rj/Yhx4t1tPAQLxrVsLsQy+IDX89VSg93SOsy51wIk9f9VF2GmyhrlW4bLfvYTxbdKtZEu+4Z624wMpnEw5PVkvjKJdE8qnHeWi2Ih2YnoYqLvoho4sYJSV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8749.namprd11.prod.outlook.com (2603:10b6:610:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 14:39:07 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 14:39:07 +0000
Date: Mon, 9 Jun 2025 15:39:01 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v3 3/6] net/intel: add TxPP Support for E830
Message-ID: <aEbyBWWVn1IYv-_I@bricha3-mobl1.ger.corp.intel.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250608113223.487043-1-soumyadeep.hore@intel.com>
 <20250608113223.487043-4-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250608113223.487043-4-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DUZPR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d56e0c-0323-464f-8492-08dda76363b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xxoc0fHiAvm3LF+tQve/dL7xQXh87bv+p3T/yvnP8ixmkUQTMhSFS985kNUT?=
 =?us-ascii?Q?XZ2AUeOWvMxpn2uHdoXmG9Wwp2KCqRq92qtH2RdwlqmhMWf8jSxZrjAbufiF?=
 =?us-ascii?Q?akosuJAhITnc1MOE3RSqFQ8x5FvUI6K8xSZMaSoskOxMc80q6WW8e9G63sjj?=
 =?us-ascii?Q?N9EAJ5MBo0/eMlNw9XH3Aa2rHL3gY/Z9aJd8Go0oXdJUnuhd1td+hORvevr5?=
 =?us-ascii?Q?hnVs8HFk64HBhOf3G7sDq8KoMn+c/nvKj+yKgrf+NsTU65NiYMsIQm4Hfbj9?=
 =?us-ascii?Q?QSmnbfcZIRaLA7rMCMQiqPYAXLLyyKNfULHx+JYNfG/cAhzuz61B9NFxY+e8?=
 =?us-ascii?Q?gFt9bhZcrOd7lx6V/KwrzOMAlTaNEa4md0/21uhFe7VnxuFuv5iWH5WJjksU?=
 =?us-ascii?Q?Xg+cb0ziMsWSgohDi1xS6CmqdrS3n/BJfUyDlie6XT3OvWvl7TclJkFo3XSU?=
 =?us-ascii?Q?XSTb1WOp/BXRLzWvtnu8nW5QHp4L8nktw/dTcaarxhZGxu3uRJvGPQLuKoFE?=
 =?us-ascii?Q?5p50vr/+PZNFCA71l1eFUS1GS8xatrLbjDy9a4ccL6a4FBrD6q/x2gkOLIp/?=
 =?us-ascii?Q?wTvBBy7cM3Xt+ksPVyOCxtR4G0GxdDaKKdHkVNG6+sqeeKuxpd8l+AquJ1Zy?=
 =?us-ascii?Q?DvhGds7Uhsz9M0isJbXbqwrI1yUv74io9Ycdu9zOvqc9TwcmvOHZ1WmEANzc?=
 =?us-ascii?Q?We9oqFAcd74wyhlTd38+r1i0TOHVtWsdzHfS4bwJ6brosBt1UhOYXikS5Oll?=
 =?us-ascii?Q?yTLW0iu77zqTRmvthN86l1ZPvZMc57jnriNyeCbi0kH7/wqYwkjQdU1uSllE?=
 =?us-ascii?Q?tJGES3OUz1VShBGS/lzq48wRzdhM2ZFJyqIwTWsE6S33FIihXlE3ACIHQxYe?=
 =?us-ascii?Q?dlECSi3LZmVWYCvhP/96L9/5/l3LXCFpPw1/350daCyI6SyAQqQ/vVCKG2jC?=
 =?us-ascii?Q?AJa7QHGRoM7uTvRsm6Vi75yM5ARxVK9hYGshYH+b7+/c1niEyvLgHvkrqPy8?=
 =?us-ascii?Q?g/PKicB8en1f6v/AP6+Ee64MV+R2K7vZXztwzp9wNcR7pQvTOFeCUHw1zWJ0?=
 =?us-ascii?Q?527prgrduqR3qpnmqy5qBjQ5bC3P4s8wXiA8FmEH18gfvPRQrSHx7xAE8UsD?=
 =?us-ascii?Q?ElXAkvfeT7bDSBvMF0pyzCKP12W47aHXcYrYqMXXZfPTuLk4Ns30jY/26CkD?=
 =?us-ascii?Q?GJdTohjgcvb2mX8ypr2nFfnYe4VwHBA8W9PILtUeKHJg4pHyk5b7Ktkq0Me0?=
 =?us-ascii?Q?wREXE73+hpLGw4aLAbjqu2eNKfHywqeBxSbTJMs+ighMyhzt4Z3+BPp6ycJv?=
 =?us-ascii?Q?+S72XCZjaoBud6TklEOi9StBXNQOkqqEvOdNW2auORgDuP5AaB/NidG6j5zN?=
 =?us-ascii?Q?Bkn3lIn+cxZAl6wtctOQ9oihDkfnDiNVxD53E3TvhCZTpoLu7WRYJpgGnZ4f?=
 =?us-ascii?Q?8bmqnuebrMM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KxFPS5P5Ezn6wtAjNOM6d1Ckj5YgyV2dsTmmMgM+bg5hyUu86IS0RwYxfghT?=
 =?us-ascii?Q?Aeqyqfby9Vx4MTcEtYuL6NAjzI5TpCYm6Qgz1l7iiRFrlDsacqG1+pWHGnJI?=
 =?us-ascii?Q?xH1kK57QjkHFYQI/qsTg76nyJEMX1EG4WGksQ3Lkvkgnk83pdkC6fXmxLh8i?=
 =?us-ascii?Q?bjI1zalDZZRa9YzVbGQcWCNDBmaOZlqlMKObL7/0UdgwaxWaqOob3Zbr74vc?=
 =?us-ascii?Q?ROlaRk4czbsTUkY5K3nb/KDS44swN+qnJk/7E8X+/mDoFltg06TkTic2eDWB?=
 =?us-ascii?Q?pV+f2Rendq73+IK7iPcZM3TxJVnhvNbFsiqr8gKe7BJ6nkeTARGpCNYf5B4B?=
 =?us-ascii?Q?yEQTMx5RMOHE4zxhPLR+tsemQU6yHkJsdCK4eq3cwcze1BYX0ujT2OIGvle0?=
 =?us-ascii?Q?ZXJFaoSfx3Zw+Udw83nYVVG1R5BxsJIQPS+t3gB/DWkW4WY1PnOrMZ/xD9u+?=
 =?us-ascii?Q?KrQKYBseJOaiA/+4BzPfdu2Rl8aSRNpi0mAWC/7aCx/7H2A8jqrczK4vh6N0?=
 =?us-ascii?Q?TjiVyXaUkyr9FxVpzO8ynL+7aj3mI0BjuoZHfSezdzDyyp1is9q9FTvBUP1Z?=
 =?us-ascii?Q?l3l9lucHLZpi0k6FKJYBINNuHij3qH7/lcbjP9+NejYTjaPiAkHsmdJ1cnjv?=
 =?us-ascii?Q?iGzv0JPnufudiQhlrfOJ2OapU3ZibZcOVTT/yGO4C22ONryDZrZUwq3SlC+w?=
 =?us-ascii?Q?7eIcx8tRz81CGcQZgSA7td+JUlekxlC1PLmW32rS78aOc0PhO6g1FXNSwzib?=
 =?us-ascii?Q?oNHwPXqbhV/nznMjKdjsSwA7HJbweYPZ/U+Jr5zQzxtfkXgnIRLMULaovrKa?=
 =?us-ascii?Q?kn+NK505rTnCwLBMJEY4d4LxI6wDcZR4uCQp0eoByKnoFvLmwbr4s76w/a9P?=
 =?us-ascii?Q?wt91KQ3HKE2CaySfB1f+KnZ6IkJL0OCOz+Gho1E72rhsNc8uPj4irv2+99cb?=
 =?us-ascii?Q?Gl/ls3d/t0t8Jw3I/rnyN3iXsUrm3VfbEiVvJqe0/BN3wWz5TLhzJNOqJBUT?=
 =?us-ascii?Q?++LRHFzoCjK9U7Fr/RAivEsgkb4IhViYmO90FmVSb0/VV41yURdIhdL2NduF?=
 =?us-ascii?Q?B2HLQgEwuEnWONH6ZpJNTU7Q37XJMFrq2ncqPNMCLlK8D8pqXFuZx0cS9An9?=
 =?us-ascii?Q?RflbLIN/DVE/Vuvwn1HMtrEd7wMEa6av7ERV1OSr7+JdPic4kAxfB9hqBGF5?=
 =?us-ascii?Q?mQ8vlvkrIQZ0vwqV92jy+xOQXEdrH8+i2wzBahV6rGL8iz9CPL9jWNqDYEAB?=
 =?us-ascii?Q?3hHn2lz/J0TZMUGf7UODonhdpYGNMqlH5j06o9XWtB490ICGrY5o0mcv9EMe?=
 =?us-ascii?Q?mgXkHT9vPlBTnjRzwap1EHLt9eXQoQBa6bGMmDBXgrJsg9VM7j3nTtbWDfte?=
 =?us-ascii?Q?WYWu/FwzfuN9AazLYBlEqgtxafn//pg3s+Qdxlj7gB3NG8uUZHNCEGjL/B1u?=
 =?us-ascii?Q?2C4jxJHTNFS1N3TSUuiuuXRR+tfzc3eYBgioKco7hIeXXpHLyDJj58aXf4fn?=
 =?us-ascii?Q?GsHgIy009O7U9lULvR+s3yNEBFYpQgZSAEVZM6nhNrpdQLGc8srctKCg679b?=
 =?us-ascii?Q?qFZ5H3oTk/Y4pMwn27Y10DqeS/5NUacn9Bs93tnKoURTuuAiqY8lJv/zskQk?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d56e0c-0323-464f-8492-08dda76363b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:39:07.5178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmE3U4dIImo5YqW3U9Kbc25NQxJXz/lPh0I9wb1QU87wKoG/TO4aubjDi1hHZqsJGBfZIHiLPP/rhm1Cm3tlyKNUJ7o6+DwG52g3GCgdwVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8749
X-OriginatorOrg: intel.com
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

On Sun, Jun 08, 2025 at 11:32:20AM +0000, Soumyadeep Hore wrote:
> Add support for Tx Time based queues. This is used to schedule
> packets based on Tx timestamp.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>

Hi

more review comments inline below.

> ---
>  drivers/net/intel/common/tx.h              |  14 ++
>  drivers/net/intel/ice/base/ice_lan_tx_rx.h |   4 +
>  drivers/net/intel/ice/ice_ethdev.c         |   3 +-
>  drivers/net/intel/ice/ice_ethdev.h         |  12 ++
>  drivers/net/intel/ice/ice_rxtx.c           | 232 ++++++++++++++++++++-
>  drivers/net/intel/ice/ice_rxtx.h           |   9 +
>  6 files changed, 265 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index b0a68bae44..8b958bf8e5 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -30,6 +30,19 @@ struct ci_tx_entry_vec {
>  
>  typedef void (*ice_tx_release_mbufs_t)(struct ci_tx_queue *txq);
>  
> +/**
> + * Structure associated with Tx Time based queue
> + */
> +struct ice_txtime {
> +	volatile struct ice_ts_desc	*ice_ts_ring;  /* Tx time ring virtual address */
> +	uint16_t nb_ts_desc;	/* number of Tx Time descriptors */
> +	uint16_t ts_tail;  /* current value of tail register */
> +	rte_iova_t ts_ring_dma;	/* TX time ring DMA address */
> +	const struct rte_memzone *ts_mz;
> +	int ts_offset;	/* dynamic mbuf Tx timestamp field offset */
> +	uint64_t ts_flag;	/* dynamic mbuf Tx timestamp flag */
> +};
> +
>  struct ci_tx_queue {
>  	union { /* TX ring virtual address */
>  		volatile struct i40e_tx_desc *i40e_tx_ring;
> @@ -77,6 +90,7 @@ struct ci_tx_queue {
>  	union {
>  		struct { /* ICE driver specific values */
>  			uint32_t q_teid; /* TX schedule node id. */
> +			struct ice_txtime tsq; /* Tx Time based queue */
>  		};
>  		struct { /* I40E driver specific values */
>  			uint8_t dcb_tc;
> diff --git a/drivers/net/intel/ice/base/ice_lan_tx_rx.h b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> index f92382346f..8b6c1a07a3 100644
> --- a/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> +++ b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> @@ -1278,6 +1278,8 @@ struct ice_ts_desc {
>  #define ICE_TXTIME_MAX_QUEUE		2047
>  #define ICE_SET_TXTIME_MAX_Q_AMOUNT	127
>  #define ICE_OP_TXTIME_MAX_Q_AMOUNT	2047
> +#define ICE_TXTIME_FETCH_TS_DESC_DFLT	8
> +#define ICE_TXTIME_FETCH_PROFILE_CNT	16
>  /* Tx Time queue context data
>   *
>   * The sizes of the variables may be larger than needed due to crossing byte
> @@ -1303,8 +1305,10 @@ struct ice_txtime_ctx {
>  	u8 drbell_mode_32;
>  #define ICE_TXTIME_CTX_DRBELL_MODE_32	1
>  	u8 ts_res;
> +#define ICE_TXTIME_CTX_RESOLUTION_128NS 7
>  	u8 ts_round_type;
>  	u8 ts_pacing_slot;
> +#define ICE_TXTIME_CTX_FETCH_PROF_ID_0 0
>  	u8 merging_ena;
>  	u8 ts_fetch_prof_id;
>  	u8 ts_fetch_cache_line_aln_thld;
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 9478ba92df..3af9f6ba38 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -4139,7 +4139,8 @@ ice_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
>  			RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |
>  			RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |
>  			RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |
> -			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
> +			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |
> +			RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP;
>  		dev_info->flow_type_rss_offloads |= ICE_RSS_OFFLOAD_ALL;
>  	}
>  
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index bfe093afca..dd86bd030c 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -17,6 +17,18 @@
>  #include "base/ice_flow.h"
>  #include "base/ice_sched.h"
>  
> +#define __bf_shf(x) rte_bsf32(x)
> +#define FIELD_GET(_mask, _reg) \
> +	(__extension__ ({ \
> +		typeof(_mask) _x = (_mask); \
> +		(typeof(_x))(((_reg) & (_x)) >> __bf_shf(_x)); \
> +	}))
> +#define FIELD_PREP(_mask, _val) \
> +	(__extension__ ({ \
> +		typeof(_mask) _x = (_mask); \
> +		((typeof(_x))(_val) << __bf_shf(_x)) & (_x); \
> +	}))
> +

__bf_shf() macro is only used in this driver in these two macros. Therefore
there is no reason to use the alias at all - just call rte_bsf32 directly,
and make the code more readable.

>  #define ICE_ADMINQ_LEN               32
>  #define ICE_SBIOQ_LEN                32
>  #define ICE_MAILBOXQ_LEN             32
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index ba1435b9de..0c5844e067 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -740,6 +740,53 @@ ice_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
>  	return 0;
>  }
>  
> +/**
> + * ice_setup_txtime_ctx - setup a struct ice_txtime_ctx instance
> + * @txq: The queue on which tstamp ring to configure
> + * @txtime_ctx: Pointer to the Tx time queue context structure to be initialized
> + * @txtime_ena: Tx time enable flag, set to true if Tx time should be enabled
> + */
> +static int
> +ice_setup_txtime_ctx(struct ci_tx_queue *txq,
> +		     struct ice_txtime_ctx *txtime_ctx, bool txtime_ena)
> +{
> +	struct ice_vsi *vsi = txq->ice_vsi;
> +	struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
> +
> +	txtime_ctx->base = txq->tsq.ts_ring_dma >> ICE_TX_CMPLTNQ_CTX_BASE_S;
> +
> +	/* Tx time Queue Length */
> +	txtime_ctx->qlen = txq->tsq.nb_ts_desc;
> +
> +	if (txtime_ena)
> +		txtime_ctx->txtime_ena_q = 1;
> +
> +	/* PF number */
> +	txtime_ctx->pf_num = hw->pf_id;
> +
> +	switch (vsi->type) {
> +	case ICE_VSI_LB:
> +	case ICE_VSI_CTRL:
> +	case ICE_VSI_ADI:
> +	case ICE_VSI_PF:
> +		txtime_ctx->vmvf_type = ICE_TLAN_CTX_VMVF_TYPE_PF;
> +		break;
> +	default:
> +		PMD_DRV_LOG(ERR, "Unable to set VMVF type for VSI type %d",
> +				vsi->type);
> +		return -EINVAL;
> +	}
> +
> +	/* make sure the context is associated with the right VSI */
> +	txtime_ctx->src_vsi = vsi->vsi_id;
> +
> +	txtime_ctx->ts_res = ICE_TXTIME_CTX_RESOLUTION_128NS;
> +	txtime_ctx->drbell_mode_32 = ICE_TXTIME_CTX_DRBELL_MODE_32;
> +	txtime_ctx->ts_fetch_prof_id = ICE_TXTIME_CTX_FETCH_PROF_ID_0;
> +
> +	return 0;
> +}
> +
>  int
>  ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  {
> @@ -799,11 +846,6 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  	ice_set_ctx(hw, (uint8_t *)&tx_ctx, txq_elem->txqs[0].txq_ctx,
>  		    ice_tlan_ctx_info);
>  
> -	txq->qtx_tail = hw->hw_addr + QTX_COMM_DBELL(txq->reg_idx);
> -
> -	/* Init the Tx tail register*/
> -	ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> -
>  	/* Fix me, we assume TC always 0 here */
>  	err = ice_ena_vsi_txq(hw->port_info, vsi->idx, 0, tx_queue_id, 1,
>  			txq_elem, buf_len, NULL);
> @@ -826,6 +868,40 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  	/* record what kind of descriptor cleanup we need on teardown */
>  	txq->vector_tx = ad->tx_vec_allowed;
>  
> +	if (txq->tsq.ts_flag > 0) {
> +		struct ice_aqc_set_txtime_qgrp *ts_elem;
> +		u8 ts_buf_len = ice_struct_size(ts_elem, txtimeqs, 1);
> +		struct ice_txtime_ctx txtime_ctx = { 0 };
> +
> +		ts_elem = ice_malloc(hw, ts_buf_len);
> +		ice_setup_txtime_ctx(txq, &txtime_ctx,
> +						true);
> +		ice_set_ctx(hw, (u8 *)&txtime_ctx,
> +				ts_elem->txtimeqs[0].txtime_ctx,
> +				ice_txtime_ctx_info);
> +
> +		txq->qtx_tail = hw->hw_addr +
> +					E830_GLQTX_TXTIME_DBELL_LSB(txq->reg_idx);
> +
> +		/* Init the Tx time tail register*/
> +		ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> +
> +		err = ice_aq_set_txtimeq(hw, txq->reg_idx, 1, ts_elem,
> +								ts_buf_len, NULL);
> +		if (err) {
> +			PMD_DRV_LOG(ERR, "Failed to set Tx Time queue context, error: %d", err);
> +			rte_free(txq_elem);
> +			rte_free(ts_elem);
> +			return err;
> +		}
> +		rte_free(ts_elem);

Small suggestion - if you move the rte_free up immediately after the
set_txtimeq call, you can avoid having to repeat the same op in the error
leg and in the non-error case.

> +	} else {
> +		txq->qtx_tail = hw->hw_addr + QTX_COMM_DBELL(txq->reg_idx);
> +
> +		/* Init the Tx tail register*/
> +		ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> +	}
> +
>  	dev->data->tx_queue_state[tx_queue_id] = RTE_ETH_QUEUE_STATE_STARTED;
>  
>  	rte_free(txq_elem);
> @@ -1046,6 +1122,20 @@ ice_reset_tx_queue(struct ci_tx_queue *txq)
>  
>  	txq->last_desc_cleaned = (uint16_t)(txq->nb_tx_desc - 1);
>  	txq->nb_tx_free = (uint16_t)(txq->nb_tx_desc - 1);
> +
> +	if (txq->tsq.ts_flag > 0) {
> +		size = sizeof(struct ice_ts_desc) * txq->tsq.nb_ts_desc;
> +		for (i = 0; i < size; i++)
> +			((volatile char *)txq->tsq.ice_ts_ring)[i] = 0;

Why not just use memset here?

> +
> +		for (i = 0; i < txq->tsq.nb_ts_desc; i++) {
> +			volatile struct ice_ts_desc *tsd =
> +							&txq->tsq.ice_ts_ring[i];
> +			tsd->tx_desc_idx_tstamp = 0;
> +		}

Should the tx_desc_idx_tstamp not already be zero from the clearing op done
just above?

> +
> +		txq->tsq.ts_tail = 0;
> +	}
>  }
>  
>  int
> @@ -1080,6 +1170,19 @@ ice_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  	q_ids[0] = txq->reg_idx;
>  	q_teids[0] = txq->q_teid;
>  
> +	if (txq->tsq.ts_flag > 0) {
> +		struct ice_aqc_ena_dis_txtime_qgrp txtime_pg;
> +		status = ice_aq_ena_dis_txtimeq(hw, q_ids[0], 1, 0,
> +					     &txtime_pg, NULL);
> +		if (status != ICE_SUCCESS) {
> +			PMD_DRV_LOG(DEBUG, "Failed to disable Tx time queue");
> +			return -EINVAL;
> +		}
> +		txq->tsq.ts_flag = 0;
> +		txq->tsq.ts_offset = -1;
> +		dev->dev_ops->timesync_disable(dev);
> +	}
> +
>  	/* Fix me, we assume TC always 0 here */
>  	status = ice_dis_vsi_txq(hw->port_info, vsi->idx, 0, 1, &q_handle,
>  				q_ids, q_teids, ICE_NO_RESET, 0, NULL);
> @@ -1166,6 +1269,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
>  		   struct rte_mempool *mp)
>  {
>  	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
>  	struct ice_adapter *ad =
>  		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>  	struct ice_vsi *vsi = pf->main_vsi;
> @@ -1249,7 +1353,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
>  	rxq->xtr_field_offs = ad->devargs.xtr_field_offs;
>  
>  	/* Allocate the maximum number of RX ring hardware descriptor. */
> -	len = ICE_MAX_RING_DESC;
> +	len = ICE_MAX_NUM_DESC_BY_MAC(hw);
>  
>  	/**
>  	 * Allocating a little more memory because vectorized/bulk_alloc Rx
> @@ -1337,6 +1441,36 @@ ice_rx_queue_release(void *rxq)
>  	rte_free(q);
>  }
>  
> +/**
> + * ice_calc_ts_ring_count - Calculate the number of timestamp descriptors
> + * @hw: pointer to the hardware structure
> + * @tx_desc_count: number of Tx descriptors in the ring
> + *
> + * Return: the number of timestamp descriptors
> + */
> +static uint16_t ice_calc_ts_ring_count(struct ice_hw *hw, u16 tx_desc_count)

Use DPDK style for declarations, putting the "static uint16_t" on its own
line.

> +{
> +	u16 prof = ICE_TXTIME_CTX_FETCH_PROF_ID_0;
> +	u16 max_fetch_desc = 0;
> +	u16 fetch;
> +	u32 reg;
> +	u16 i;
> +
> +	for (i = 0; i < ICE_TXTIME_FETCH_PROFILE_CNT; i++) {
> +		reg = rd32(hw, E830_GLTXTIME_FETCH_PROFILE(prof, 0));
> +		fetch = FIELD_GET(E830_GLTXTIME_FETCH_PROFILE_FETCH_TS_DESC_M,
> +				  reg);
> +		max_fetch_desc = max(fetch, max_fetch_desc);
> +	}
> +
> +	if (!max_fetch_desc)
> +		max_fetch_desc = ICE_TXTIME_FETCH_TS_DESC_DFLT;
> +
> +	max_fetch_desc = RTE_ALIGN(max_fetch_desc, ICE_REQ_DESC_MULTIPLE);
> +
> +	return tx_desc_count + max_fetch_desc;
> +}
> +
>  int
>  ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		   uint16_t queue_idx,
> @@ -1345,6 +1479,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		   const struct rte_eth_txconf *tx_conf)
>  {
>  	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
>  	struct ice_vsi *vsi = pf->main_vsi;
>  	struct ci_tx_queue *txq;
>  	const struct rte_memzone *tz;
> @@ -1469,7 +1604,8 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  	}
>  
>  	/* Allocate TX hardware ring descriptors. */
> -	ring_size = sizeof(struct ice_tx_desc) * ICE_MAX_RING_DESC;
> +	ring_size = sizeof(struct ice_tx_desc) *
> +				ICE_MAX_NUM_DESC_BY_MAC(hw);
>  	ring_size = RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
>  	tz = rte_eth_dma_zone_reserve(dev, "ice_tx_ring", queue_idx,
>  				      ring_size, ICE_RING_BASE_ALIGN,
> @@ -1507,6 +1643,42 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		return -ENOMEM;
>  	}
>  
> +	if (vsi->type == ICE_VSI_PF &&
> +		(offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP) &&
> +		txq->tsq.ts_offset == 0 && hw->phy_model == ICE_PHY_E830) {
> +		int ret =
> +			rte_mbuf_dyn_tx_timestamp_register(&txq->tsq.ts_offset,
> +							 &txq->tsq.ts_flag);
> +		if (ret) {
> +			PMD_INIT_LOG(ERR, "Cannot register Tx mbuf field/flag "
> +							"for timestamp");
> +			return -EINVAL;
> +		}
> +		dev->dev_ops->timesync_enable(dev);
> +
> +		ring_size = sizeof(struct ice_ts_desc) *
> +					ICE_MAX_NUM_DESC_BY_MAC(hw);
> +		ring_size = RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
> +		const struct rte_memzone *ts_z =
> +					rte_eth_dma_zone_reserve(dev, "ice_tstamp_ring",
> +					queue_idx, ring_size, ICE_RING_BASE_ALIGN,
> +				    socket_id);
> +		if (!ts_z) {
> +			ice_tx_queue_release(txq);
> +			PMD_INIT_LOG(ERR, "Failed to reserve DMA memory "
> +							"for TX timestamp");
> +			return -ENOMEM;
> +		}
> +		txq->tsq.ts_mz = ts_z;
> +		txq->tsq.ice_ts_ring = ts_z->addr;
> +		txq->tsq.ts_ring_dma = ts_z->iova;
> +		txq->tsq.nb_ts_desc =
> +				ice_calc_ts_ring_count(ICE_VSI_TO_HW(vsi),
> +							txq->nb_tx_desc);

This looks wrong, and leading to overflow. What happens if:
 txq->nb_tx_desc == ICE_MAX_NUM_DESC_BY_MAC(hw)
Since ice_calc_ts_ring_count always returns a value greater than
txq->nb_tx_desc, you will overwrite other data on reset.

> +	} else {
> +		txq->tsq.ice_ts_ring = NULL;
> +	}
> +
>  	ice_reset_tx_queue(txq);
>  	txq->q_set = true;
>  	dev->data->tx_queues[queue_idx] = txq;
> @@ -1539,6 +1711,8 @@ ice_tx_queue_release(void *txq)
>  
>  	ci_txq_release_all_mbufs(q, false);
>  	rte_free(q->sw_ring);
> +	if (q->tsq.ts_mz)
> +		rte_memzone_free(q->tsq.ts_mz);
>  	rte_memzone_free(q->mz);
>  	rte_free(q);
>  }
> @@ -2961,6 +3135,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
>  	struct rte_mbuf *m_seg;
>  	uint32_t cd_tunneling_params;
>  	uint16_t tx_id;
> +	uint16_t ts_id = -1;
>  	uint16_t nb_tx;
>  	uint16_t nb_used;
>  	uint16_t nb_ctx;
> @@ -2979,6 +3154,9 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
>  	tx_id = txq->tx_tail;
>  	txe = &sw_ring[tx_id];
>  
> +	if (txq->tsq.ts_flag > 0)
> +		ts_id = txq->tsq.ts_tail;
> +
>  	/* Check if the descriptor ring needs to be cleaned. */
>  	if (txq->nb_tx_free < txq->tx_free_thresh)
>  		(void)ice_xmit_cleanup(txq);
> @@ -3166,10 +3344,48 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
>  		txd->cmd_type_offset_bsz |=
>  			rte_cpu_to_le_64(((uint64_t)td_cmd) <<
>  					 ICE_TXD_QW1_CMD_S);
> +
> +		if (txq->tsq.ts_flag > 0) {
> +			uint64_t txtime = *RTE_MBUF_DYNFIELD(tx_pkt,
> +					txq->tsq.ts_offset, uint64_t *);
> +			uint32_t tstamp = (uint32_t)(txtime % NS_PER_S) >>
> +						ICE_TXTIME_CTX_RESOLUTION_128NS;
> +			if (tx_id == 0)
> +				txq->tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =
> +				rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +				txq->nb_tx_desc) | FIELD_PREP(ICE_TXTIME_STAMP_M,
> +				tstamp));

This indentation needs fixing. It looks like a block of 4 statements!

> +			else
> +				txq->tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =
> +				rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +				tx_id) | FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));

Same here, and below also.

> +			ts_id++;
> +			/* Handling MDD issue causing Tx Hang */
> +			if (ts_id == txq->tsq.nb_ts_desc) {
> +				uint16_t fetch = txq->tsq.nb_ts_desc - txq->nb_tx_desc;
> +				ts_id = 0;
> +				for (; ts_id < fetch; ts_id++) {
> +					if (tx_id == 0)
> +						txq->tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =
> +						rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +						txq->nb_tx_desc) | FIELD_PREP(ICE_TXTIME_STAMP_M,
> +						tstamp));
> +					else
> +						txq->tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =
> +						rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +						tx_id) | FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));
> +				}
> +			}
> +		}
>  	}
<snip>
