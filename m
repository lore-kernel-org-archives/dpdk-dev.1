Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E78C982CC
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 15:48:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A83942F03;
	Wed, 16 Sep 2026 17:48:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id AE72740264
 for <dev@dpdk.org>; Wed, 16 Sep 2026 17:48:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789573719; x=1821109719;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1n+KkoD497cGlOObkTr6NIueRxh0W+i+1ISsphmC6hU=;
 b=WqMy1DqazE+foEOfrs3hk9QCW0aKN8v0zxwPPy4vFYWfzbgFfjol7EOB
 /DDMg0DkmxZ0f63sbdGSc8mWBcEMY6e4fiqXaifHcp/GFBXF9Da3/cdAJ
 KW6WANmDqKfWhvX38YxCapKNtDEJD1eo6MeGW67QCvHvO6K2zOov6tYLl
 k75g1XobixShrCV9UuFxQRk2jt+ECepUJgEtnaW5ToR7cl16+54KBVB8a
 H+Q8RKcBH53+gFz6R4J6vyJnbUn/xoLAsze042iH83mV1y4mHCCHMa/7B
 O+M4wNpFYVEmjar4u1e8cnVp3COwRllGG5DewUujq9fpKLNMuqXQJCS45 A==;
X-CSE-ConnectionGUID: 9yCak3BTTYe+GejttxvL7Q==
X-CSE-MsgGUID: KV9c1/c2SOeQjt2jV43vbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89997623"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89997623"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 08:48:37 -0700
X-CSE-ConnectionGUID: tywkuFQYQw+OmSb8sd2SsA==
X-CSE-MsgGUID: 5UhAVmNVQiaQ1S9lKOMnwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="277116037"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 08:48:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 08:48:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 08:48:37 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 08:48:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cw5RYW913BOFfawpnR38UalzZJehW4hQCaH4xNl+kQpFcXzJg46u0t0WVtPy9eQIKVROpxTYcsLUvthmoXM9wXHVeLVTeGl0hAM6rwuWvRf18xbig4jQU4XNVqAGu5wQdUSYxK2YG3rZi2eAMmWP5NUK4LX7rrTmH81GeieeNv3Ga4v3YOpk7dbcJhPALL39lZB6Ju7z/okuRBEmeoMiISH4ZfO2usW0/CKbBOuRvStpchjydSSDhJ6Wb8alRANi5tpiPzCpbVQFo+k9i3UZOqbw5loqpUx47wfSFfX05pO2ccog8Xg+18MtxRdcJTRTicRl7kMqFZJaBLYjAHTfqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1kaBpG7qMHR9J8UYooH5Szv2Ed9q5wxQ8B/WMDGzbw=;
 b=bJKnLNsaFoV/W+XrmJymMWPhiquQ2PQ85++AhZ+P48OEzNb2R3NaIM6la+HnnoSvsu+mt17pMNBsie+J17t7I91U2lWOd4eaEjl7qG4PIKbuG01vc5pbgDw0Ew6WRepcviENlT5j11u3qDgfVnNrS9mfjcdt7lPVQoU0VNYsmNeRF7ZI98GzzfQJs+AZWgNsSJ0VDCH5Jc+bVueE17sbUskldq/Oqz7NeUhrrb36QC8xNzA9u6qBNcj9pTVIRmt7/9EQPkKzjjs4T1lbGe34qY/NrkCztvAZ2OI2wHuhj55lPHj8Ev++u6Q+BAvbpV8kGYF51un9Lt5cDVl82cF3sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM4PR11MB8158.namprd11.prod.outlook.com (2603:10b6:8:18b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 15:48:31 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 15:48:31 +0000
Date: Wed, 16 Sep 2026 16:48:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Omar Munchaev <omarmunchaev@gmail.com>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, <dev@dpdk.org>, Omar Munchaev
 <omar.munchaev@gmail.com>
Subject: Re: [PATCH] net/intel: use rte_validate_tx_offload function
 correctly for i40e/iavf/ice drivers
Message-ID: <aqq6SjXopFXqkYXY@bricha3-mobl1.ger.corp.intel.com>
References: <20260916141235.2074815-1-omar.munchaev@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260916141235.2074815-1-omar.munchaev@gmail.com>
X-ClientProxiedBy: DUZPR01CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::20) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM4PR11MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: b6288d73-cec2-40f3-562e-08df1409f572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wqMKdc3sW7yeSvR+c8PZOomU7ULEgtSEJdeHRXvqlqDxWXSoPHU7/XfVxrBRUle3juscJBeGBp6Bekky7/Y8yy6J3SGiom9eC5Fdww8uSLJ1/KGgF/4f6+a3L08MALoZBtQSX7ARJ2k1shsiLZqSkvgnal5YEN+VCvjpIJmd4Y7fn6dGhSIzUD0m2eWv7elxRU3G952ZS7iyAGF5cqsYvSHoyB2eGWWpT+cMy164OC5Zfj3Xj47EtmEHiVFYU4+u5LXdnMXYL+bdS6YdW+gidkK1G954Cg6ybiymBpt5b1GwdWkBUjhGf1aqZqQC/HLuRp7BQk6goypy/sXZp/rDZCwOVFJuNylJ0XGE9YVeXZgcq6arEBJx96ieFx+HcXYjmOZfpU7vXYTxX+eJUC+nMmocDC4L7kpTb2AZ4RFu2G0JvQ9G+ItI9rkc8+1TdqSBqeP8kAGPfZZhV94NYyX7bmUk+JiNX0kRx5nLp+n5rx5KDwmkCpgCNxtfsUM5ZvQmNyCtcte9TBSkk0+NN4CKbiX1DbhRSui2JkgfHwRshJJ6UxKoR9cB+6I3T3eR+RF0lrs6vQpmt6h9QR2fWEqXRAEbTJDKeMRZg8EnrG/yDWKwxAxsDeSo7RxVZAgWNIxl1yWZVlasUCN8nuwerDG6VUIEps1a4LbPsxpxvEC/tt8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9SY3M2QrSzOlCPnm5h/xx7c8pZDc4PkUBJ09TWY01ulecBG1Oz3nT3XZIbgR?=
 =?us-ascii?Q?RJRJkke/EK3NLYymaNMoQaRuhjhjP9cfPutrW13U+CiqfaJqlCvANgzk3jhO?=
 =?us-ascii?Q?llmAPGejwbjdv4GJVVI5cVt8zDGK9kP3Z2c7AoXWI6t4Y3RNPlPQvmD2D04W?=
 =?us-ascii?Q?AJeWIE3WjyjQpTTzLDpv7XEPoNvsRux2cA22CrnOht5X8NyfxSa+OnIKUzZp?=
 =?us-ascii?Q?uv8drroL+h1hZezU/S7bh+dnTBHR5Juw3mktHLT0QF1lTA5XEuV2NS8HsSSe?=
 =?us-ascii?Q?exJnasvMWBt0db2qs7efwzJyjiTINHhEdjDmekmHWohENkYzaL4VMadgM18f?=
 =?us-ascii?Q?83S3lyKgTVN+vfpPA9Ong935xes7ASARujGi/Ui3r2XRFztLi2puMhLNF175?=
 =?us-ascii?Q?yXaNUj4cWX9D5+oYBFhSfUsYk9tDpspBoJOco93GfS+d/3gFQK23IxJ+4Fhv?=
 =?us-ascii?Q?+cOYbNMfBZ9Io2Od8Il9RfP3tBC9BKmGk3vLX1FHLNB6XSmZe3jb+Q2WeGqo?=
 =?us-ascii?Q?5uVlbEi2Gyi2nM75j/rNdSwZQs+8W76IUX7tFHDqzH6erj5d5cv8Z/qXdNG2?=
 =?us-ascii?Q?3wVP5PDygyYzMY85SWMtZqKuW287o8F6Pnre/KNGYgvpt6KmHQpUSzdkTvSd?=
 =?us-ascii?Q?Yitt9RNwruDZSq532pONPVOTOWb47VR0zwdsuJB+Jalct9MZ7qRiArWm49xg?=
 =?us-ascii?Q?Z4aqS1QFV55EyQtKsaf9YXJTQY5tYFV5WYpNo76qzCWsz7D0b7FiuzI7P0g/?=
 =?us-ascii?Q?k27SeW0tB6XoDUA3VD2O6j0aRuiMvzOtWkO6bTIH72g/8X6fBX63mCh4N1zP?=
 =?us-ascii?Q?cr2M+iJWAfhpAdp89BHytzZYax694iDwUU+FqkXB+zm+7FaAm199k8X1xh9R?=
 =?us-ascii?Q?9+9Iz2nWC76b5Ts2oOwG6ZNpgoakZ4bKnKt/uv1eBcYbFnVfR6cX5+clIGWT?=
 =?us-ascii?Q?r0h28ISsxgLxnSW5Uc+yBGfy6CXUTTgi8vRpQFlMhE+q9jXYSZW+ATap0nz8?=
 =?us-ascii?Q?EwpKtgKVR+LIvL5CYRmpAmaPijSBiYOQt1kqTrzpOVX9KtRveQhvPnMsCKsr?=
 =?us-ascii?Q?CXh10iww4PhJY9RcINgO43RjDNp6+DPAwae0HTmI+ouBKvdMtP+WB4d1r5aH?=
 =?us-ascii?Q?1/zy+lXCzKRoJcuEmjItTiVqYzpPkXkHTJbVKMmJ1NW0zI/Ie0EK+tE8afX0?=
 =?us-ascii?Q?00HSOuCQCO/6Zt3bb0vKyG7yJRSrMzQJYDDHZgw+dTGAZgG0MXw1uwuNw6ZG?=
 =?us-ascii?Q?6aLpf5dZxIpHLvWY6Hmqr7sIk2rdPC/3n+yGPBC7Bc0u4/cb3+Dopf2y8Tb4?=
 =?us-ascii?Q?ErGUN577B0A2fhGqPGyiYdk4JGdpPXVafQwgi2Ly+c4yAvEMcYzy7glDz8rY?=
 =?us-ascii?Q?EtWVTuhjUXndEVrJs6ByuJoa349i2k6B0CDyQHeHur6mQXR4YUmwj56Njp5A?=
 =?us-ascii?Q?nur0DO0CAjFj9BSw3QamHTqGEClY7X8ByTVlAYr1PceekAkp1QNQkIoXQpM3?=
 =?us-ascii?Q?B18h42sy4ZwSlgzwPSjuaEpFa6OJFLBp1FpXzkqiSJdEA6GxmAEGSrbuBoZQ?=
 =?us-ascii?Q?kYXOgfTIJldmKoYTrmgAeImkCxeS0/ajOLBFnTtCMtV/A06ozK7OZX+O0vrh?=
 =?us-ascii?Q?3LQwO3bI1nBdAjasb/xhcWsgm9EHgn8RCKixB5Vv61bhg7tW08TmN4TzZcfl?=
 =?us-ascii?Q?IYUfq6kwapZqnyHYWyN7FplL5piR9N1cHP7CRWLuOMu3g6DmxM9vASyt2Ziw?=
 =?us-ascii?Q?TiwmJWPpYaAEiuTWNb/kswRijAg8i5g=3D?=
X-Exchange-RoutingPolicyChecked: IiKWsOptVicMPkwOClyf0tm/BXSJq/HHKjwqz+GBUzZGPKjaasPecZUKFzc69OULTg/MaSaH4sm5HIDwmBTeQiXHug8T9UN6AydL1SZU/zqcPuZFq76iPjI6XTeqbQvAuPXifokJqeQ2SSi7JVwGU1GzPJw7GwCF1fm4yOZklYsx3rk0f/OF/eKnZFHiEzJjeMNO9dlbHQafopaSnJo7EmwYDTHbxMQe2ii5BBNAb93Ya/HdpMzw1hy2BFz4aGNmKxl5PN+Q9F/wPSLtZ60Qrzp7GMBHPDDnuDn1J+I1N/GeOfRUAjnJGEl28aGbRF1cmStRMxwb/dde0OLOh64XIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b6288d73-cec2-40f3-562e-08df1409f572
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:48:31.7130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2+iupsgndRwXVsBVxb4YdN+TTMVtAD0JcBGwbJ4oH2XruYbBpS8nOKWM2UWdSr4kFzzpkHGPrjDT5xoofdnw1mu6euembOotWrlQj/K47U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8158
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

On Wed, Sep 16, 2026 at 05:12:35PM +0300, Omar Munchaev wrote:
> rte_validate_tx_offload() returns 0 on success.
> The i40e, iavf and ice drivers treat any non-zero

s/any non-zero/a zero/

> return as an error and drop the packet, causing valid packets to be
> dropped when Tx offload checking is enabled via EAL, e.g.:
> 
>     -a 81:00.0,mbuf_check=offload
> 
> Only reject the packet when the return value is not 0.
>

Fixes: 82b03af55a1b ("net/i40e: support mbuf checks in Tx path")
Fixes: 21dad1fc78cb ("net/iavf: support mbuf checks in Tx path")
Fixes: 2a0244d611b4 ("net/ice: support mbuf checks in Tx path")
Cc: stable@dpdk.org

> Signed-off-by: Omar Munchaev <omar.munchaev@gmail.com>

Fixes look correct to me.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> ---
>  drivers/net/intel/i40e/i40e_rxtx.c | 2 +-
>  drivers/net/intel/iavf/iavf_rxtx.c | 2 +-
>  drivers/net/intel/ice/ice_rxtx.c   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
> index e29fcff661..ee70f7ce4f 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> @@ -1194,7 +1194,7 @@ i40e_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts
>  				break;
>  			}
>  
> -			if (!rte_validate_tx_offload(mb)) {
> +			if (rte_validate_tx_offload(mb) != 0) {
>  				PMD_TX_LOG(ERR, "INVALID mbuf: TX offload setup error");
>  				pkt_error = true;
>  				break;
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
> index 4f2ffe6188..10d33660d9 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -3813,7 +3813,7 @@ iavf_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts,
>  				break;
>  			}
>  
> -			if (!rte_validate_tx_offload(mb)) {
> +			if (rte_validate_tx_offload(mb) != 0) {
>  				PMD_TX_LOG(ERR, "INVALID mbuf: TX offload setup error");
>  				pkt_error = true;
>  				break;
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index c4b5454c53..3d98d821b2 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -3669,7 +3669,7 @@ ice_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
>  				break;
>  			}
>  
> -			if (!rte_validate_tx_offload(mb)) {
> +			if (rte_validate_tx_offload(mb) != 0) {
>  				PMD_TX_LOG(ERR, "INVALID mbuf: TX offload setup error");
>  				pkt_error = true;
>  				break;
> -- 
> 2.54.0
> 
