Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73608C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 11:24:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A536740272;
	Mon, 14 Sep 2026 13:24:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 215A840144;
 Mon, 14 Sep 2026 13:24:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789385049; x=1820921049;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Y4sgixHEVuMloWAU9O1aoKthg7jvAyye+koAJutloY4=;
 b=Z7mXAbG72WfbE2vZ2bJgD3ggrrFKR34OsLFDAo+y0On9gmORYdkjvhrg
 CFWDcsuDHIkLqSiORZdfyNFbDpJLbTpUK3+86K1AGSZ4bLVBBPzw1K/6m
 DxPS6/ubHtT+S+Jt/IjRWn+EBoaSQjfG5XdrjbgNqH9bPcL6nTjYCEzPH
 vSTZRDKUER/DgjadLiwF7dKCEVX5rjBgNkuW+VMjDWpVEsx/I06zDO1O5
 4dQVNMPykNduQGX14uUY8ds9WmML4VUgLxIWGb57SvVCOGpFWcQ4FVuqj
 6A2v+86ow2M9gP6Sm+v0srAEQ5hWLtoY6T/1OxEdFRAnnFVQ3F8oTPlfp Q==;
X-CSE-ConnectionGUID: PTw3b3EUS7GqUkRO8BW33Q==
X-CSE-MsgGUID: 8P0j42VlSsqPStBejrrnYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="92244267"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="92244267"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 04:24:08 -0700
X-CSE-ConnectionGUID: tZirgmOUS2uqxzwJsB6lGw==
X-CSE-MsgGUID: j56ZeVk4RLSg757RE5qk1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="276772292"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 04:24:08 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 04:24:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 04:24:07 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 04:24:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+UCcLRZ96F1NDwxmpHBNSj5RQtOBiw3IBFVP0iJcm2yPtWhXxoXbTgChIigZEY+bYi8K7oPE3/HS5o3y21/TIUXRxBhkoc2VMri1RhcprU8p3HiJwa8smCRnnrNdO/Fn/IC9PIDoUZm/HTaEW304C7HIVVoJrXKfhKzVVRydXoG2iozgus3Clbz197ajRPgEFSmLirqIFrLj2hDVhRqRfMkp7LzGeglMpcwIVc8jdLaJfS3BrRhxhKTNSlXxfS1xQVu+WrVLrTvI0s1mngDGGKbScx9JWFNjw7tdGL9VeJswDS6bPbnruaEsDwV+h8aFjYocaNhl1m1ufsrouRT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JA3szTgPk1DOvYVLCkd0AyHyFo5zqE5AoquE3XYzZg=;
 b=iv6Gnndx+0e9Q9Az6czDnIleF/NKccjQd/3ZuTD5UMieolQgPoRlBobj/2nTsmZX0YZ2gUxCLPB60E0Y9B7t0GyP2zpOiWcrrk7HH3SHR2db5xrero/7IVEYIoU9HuFMKQvmH52Oz3CXiGzEx0fzyxmAWH9OICXwcU0ZpKVEcVzO4LDMhiwyIjOHwZ8i9i/oMF/F3+Y8x8ytceg7etyPIxzTAgkONAnk07R2bUrfoPGCSnMoVNd8ubr6jVwXf2ZTliaeOFtJwuyFNTmuWoMc7/LglmlBM0cprEUvQVDh6OYZGpBX+yQxnKmI16jSsELtB8KKi7B1X6XiRkFs+HqV6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by IA0PR11MB7402.namprd11.prod.outlook.com (2603:10b6:208:432::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 11:24:03 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 11:24:03 +0000
Date: Mon, 14 Sep 2026 12:23:58 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Artem Novikov <naa@amicon.ru>
CC: <dev@dpdk.org>, <rrv@amicon.ru>, <lvc-project@linuxtesting.org>,
 <stable@dpdk.org>
Subject: Re: [PATCH] net/intel/common: avoid field pointer arithmetic
Message-ID: <aqfZThcX6bbSqi35@bricha3-mobl1.ger.corp.intel.com>
References: <20260914100433.53971-1-naa@amicon.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260914100433.53971-1-naa@amicon.ru>
X-ClientProxiedBy: DUZPR01CA0305.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::26) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|IA0PR11MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c422a3-416a-4ced-7773-08df1252ae15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: SHWUSqhYH7VvVfxX7OUcF/iRQ/53If/0dRcgQhFARt0rT4pndKNwzI/+zxKS+tBIGj3CXqsRhHbK7sShQHUCECw+VzICz3EZNAtLb988e7jB3ngWnUA3ne43FVWFB6EpDk4Jt9hRSUVMrjKmdbBXGg6Dddr4FiTJhKneVCFvY+m52WyOQcF5JuqymCTxji2uygRvDc0MEuzeUeHsycPNpr2A6ya5BZIJZmIAIA8JjD4+FPmSIdTNdAgmdy8VdvUGghWf2Yf9x/7fiNwlj/u4iexhk3ZVIOo6GwqHAnwVxaxiR/4C326ylkcRiSap/wyuqx0+K+B+XjkxK6d342y8yNeo3+HdOtOsNn+vAXhPgT+46yy5tF7bizJdsw+ZoIIs0Cnb2mBEJ5Vp95/zvbomEibf55/K1atzfRTE6kyZi/dFudp7dNjwxMgQJezFID6JrnjiUojzc4kznc64TVWpJOsLBzdOoIdK1nUqNS/SRzeyR4KAYcy51oFgca8ao+t4OupAb1ZAVxKALnLWTLIxit2WhfAD4sM9JNsTwVLTZisBl78w2BqbWKj9eXbNPXuXhcF2RmFrWN9HKrl57zjsjIG3OILdD6JlQcK7IaChYxp8oSw4JhBTlQjt96ZepJYE+LEaGIb5iIHyi1AnPnt7tUv40WpHYiUy49Yj66l/i5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?do7td/5bvg2n8Q3R3Rq93qYVhKP12nbtukl6tH8LBfmKDWDWyLGlaACkw3bM?=
 =?us-ascii?Q?fkSEqdDYElTPI/C0wwvdm/rIkpLFBMCcdysFtQ52Ti6uGw4vlcF+ReI7V2/+?=
 =?us-ascii?Q?uIrl66E7EA2uTE/JvAH3QysSpP+9DvATyPUkWqXUgzOpLJI181QuSB7qN2wT?=
 =?us-ascii?Q?MjGIQAixcfMS3Gb1ruPiQhqf6Q7cLaPwsmdVh+d6A4odWZv0P72+7sToCjlq?=
 =?us-ascii?Q?71jZrAV307Ez6zKQ6CUgAYOZhq71URI1S6n07RSK89TkGpRj/H4r9FXd8Bv+?=
 =?us-ascii?Q?o5gE+Iqkws/UE38Gs2Rtl2y+kQOpyAOZUAExDqfdj6aZQUneBT1HUg2kL6mA?=
 =?us-ascii?Q?wmo3lNkZSNESdbyfyWFRxmm1R9HP7aNQbD+2tUb69VKrF8GvqCxGhObEzE0O?=
 =?us-ascii?Q?zd8pVl0J84Tg9UavAXBGKTVMNuQ/8ms+UXBq7kImWzNwL9BR1pOLcsEuNP/J?=
 =?us-ascii?Q?t71BPh++Qv3DAFCpKkdmG2W18MUG6ujbTnlIlcEYaGCgo88rfiuGFO/mJWqE?=
 =?us-ascii?Q?lGmJMwh9G4vIfyXskJ9EBV6xL4LWViN6HTN+Pl+zHT4GAYtpmhf2PGPSLMCZ?=
 =?us-ascii?Q?R1OGIDuO4zClFy3HjaIvQJV097XB1WLULCNYysoxYicENblN7LlPSdxIOrKO?=
 =?us-ascii?Q?+rmvtqFmS/kMLJ1YAYY7zqCngIjS0ewf2Bp2wbcL0hLdX/CDn+Q3V7adUU0m?=
 =?us-ascii?Q?vBT6fDn6GpRoVi4bdpP4ZLopipHQC+/7h8uW93DmYgulQ2cvFraQyA1gu2S5?=
 =?us-ascii?Q?ViYc+YROPEG7VvHaPtZQRbV+bFLa5Bdinirs1FxqtMrH14rUMOtkA2DWwgOl?=
 =?us-ascii?Q?QtHC8Q/rDlzFKJY8Iicz5z77vZS+Ax+rDM0e8XTrpc3jGq0Ps+NQq3hvAhcP?=
 =?us-ascii?Q?29aLTTD9tX/xmb7vnCwjSR+7rNHuR22s85L8YA5qavFGel1vzJrzKH3Hy8LM?=
 =?us-ascii?Q?pqJmT+CsRrNgrEz+DPjJ03tb3RhDHlheQ3Ea273kgL7QaEzNnEyFnbY6odlB?=
 =?us-ascii?Q?MT6RGl+my1jEVAC+jmwrA8qKHaNeyeN9WBeOHwfcHwMmKIDoLzDehYHWH69u?=
 =?us-ascii?Q?oN4NeebcoQUbFNlsug6PfBIgfSDERxd2QlFP6SJqSwCzUKPnlirLnwbJhQAk?=
 =?us-ascii?Q?Rxy0YxX7engsTmCRVFKMPhTNud+HsNGFtMbomI03xtVSbeQzIoRE4YhDfOaZ?=
 =?us-ascii?Q?SX1k3cVov7CmJ627TlpWBasOJuxEaYYr8I6cYOhiiTZEpFItxeH2fv72rv5C?=
 =?us-ascii?Q?lRD1/X0ZAyjVb7rFC4RjrULY3T97+UlBJG82IwLjVhh5wnbf68MV1BMDFECu?=
 =?us-ascii?Q?DQR4yLWhEeU7X2kqdsgHeeZ5QkrRfqg00aGBvmWytkP4y434hNi9sv77diHo?=
 =?us-ascii?Q?3/H91wboyn4vQL7fyRz7IfVviAfC64BlXmkJD29LHplOpoCZeF0r9vSU+L+y?=
 =?us-ascii?Q?3wAfaso4bhvXVwinsDD7Oc/ASOu2KrXxiB+Tnnet/tD80K/gCigoZVn9HRbr?=
 =?us-ascii?Q?5wSDkDyUDYa5ThCdNvvMMN0X5RsgA57Z7dJJeFzA0P+6hfs+MgMWqxgKLPzG?=
 =?us-ascii?Q?VFqVOxiXdzWXQQQA+9hIQIyHY8XSKDN67RcaFSw5YqmPPfd001SmpruRdUJk?=
 =?us-ascii?Q?2VzcHwWDEV/l7in16LSzvhZInlHIKUbtZVSMTUIO2PLIRymUdfKFJCLOhhUl?=
 =?us-ascii?Q?AIBHIFl55i33BjvKLvPU4k9B/ZtAq0Y2QUbWGm3NufPJ2oOWTPdKrBuTeYHy?=
 =?us-ascii?Q?MmZ7vbS4LScODbKq+1MpaY73W11oGsY=3D?=
X-Exchange-RoutingPolicyChecked: iSW91iErz35CMgfZ8kKnkVA2CN5Iu0/QDjwDE0Z3fBaLZHWsdW/Ypt+7Qx0TbLZiHAstn23O/K9Cjx/gxqiAR14hYDsaGuNkoT/81pc/2RBTR7rxz1tChFu0SJusx3xP6RXOwoY07Wpy1CPksH9M3Eyj1zPq+xPSdugncHec6cnedhq6CIkHmWiQn7aSAh75dAkUc6krMn2I6+HBSuSI8aftGJu+5RwEMSj9uCyjSNXT3jsDVIJNFaPjYc3a5hjYtqiyym/AiOs0TBuFno6o3cqQS1ngp9zkVjcrspnurty9VvBJL8Rl8BzkCzITdPN9lTop10ztwlrHZof3B48FIg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c422a3-416a-4ced-7773-08df1252ae15
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 11:24:02.9980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwI3n6ShcBx4LGRKj64uKky5HgsNyfFPQvwFLaJ8DicUrFNEyzvO8l/AsvIQ2J3AqkqlVn105UUYwiyuJQG0dD/5YF8sVfA9rG9h7URDSBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7402
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

On Mon, Sep 14, 2026 at 01:04:33PM +0300, Artem Novikov wrote:
> The Rx rearm failure path assigns fake mbufs through rxp, but rxp is the
> address of the mbuf field in a single software ring entry.
> 
> Use the software ring array for indexed access so pointer arithmetic is
> done on struct ci_rx_entry instead of on the address of a field.
> 
> Fixes: 773cbaf2ad38 ("net/intel: avoid allocating from mempool directly")
> Cc: stable@dpdk.org
> Cc: bruce.richardson@intel.com
> 
> Signed-off-by: Artem Novikov <naa@amicon.ru>
> ---
>  drivers/net/intel/common/rx_vec_x86.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/common/rx_vec_x86.h b/drivers/net/intel/common/rx_vec_x86.h
> index 8d497e7196..9670a21fa4 100644
> --- a/drivers/net/intel/common/rx_vec_x86.h
> +++ b/drivers/net/intel/common/rx_vec_x86.h
> @@ -33,7 +33,7 @@ _ci_rxq_rearm_get_bufs(struct ci_rx_queue *rxq)
>  			const __m128i zero = _mm_setzero_si128();
>  
>  			for (i = 0; i < CI_VPMD_DESCS_PER_LOOP; i++) {
> -				rxp[i] = &rxq->fake_mbuf;
> +				rxq->sw_ring[rxq->rxrearm_start + i].mbuf = &rxq->fake_mbuf;
>  				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i]), zero);
>  			}

The existing code here is correct, because the SW ring elements are just 1
mbuf in themselves. While the change you propose does make things "more
correct" from a theoretical viewpoint, I would prefer to keep the existing
code because it means that the assignments to both HW and SW ring are done
similarly, by indexing into rxdp[i] and rxp[i].

/Bruce

>  		}
> -- 
> 2.43.0
> 
