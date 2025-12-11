Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD2AD41C26
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 11:40:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9613740A7A;
	Thu, 11 Dec 2025 12:40:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8002C40285
 for <dev@dpdk.org>; Thu, 11 Dec 2025 12:40:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765453211; x=1796989211;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gFAaOvNpSrUsm7KmHxFy/VLMfuphwCcAsuewGiXltL0=;
 b=Y+9kyxuYPeK4XnNjaOJHCko+4Ij7pee+4XnD2mkY2tvzjIQ3UH7vq7hV
 X5SRHwnPkmv94Eomo12Gdyxbnc5WB5DnO/Kx+SDP6Dgqo+tgIosj6EBvI
 oWt9oZkfGS0urdKR/x3pJRcABhUAw4zqf4002xDl04FzzAvGIXT18s4rm
 FEDVwt2TxjDi54qSNU9JA1dCQMJ8jYauAt50Nc3mbyJXwvv5tv+Xy4thZ
 k6253BdIZoghwRcjzPnMI/DEWC2XjtwzZM1cSNX3zUNoNJPWxmDcPzaH3
 xeQausSG0czXcILRUt975msXn33U21TlRtdFoOTdFyY9pVOUp/stSVPzy g==;
X-CSE-ConnectionGUID: 49yx2LA9S6W/54XgWisZ7g==
X-CSE-MsgGUID: A/Q7pRVVRHGnzEfzYfu0Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="66433525"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="66433525"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 03:40:09 -0800
X-CSE-ConnectionGUID: OwXCRHVgQB6f+Ze9vk8MSQ==
X-CSE-MsgGUID: z/BzNE1sTcifKXx5Y2zKsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="227429897"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 03:40:08 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 03:40:07 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 03:40:07 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 03:40:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omOw0utttNY88xW3vT6Qypc3bCGKKg8jj4CCmQtm99aQxSVIh51eCtG00bCjh95ce10Ok+hyvEpcWfR4rjZA99ARlqex4fnBx9/QVv594DZPbSxa/l9NwB6tjxBGiEYhuZEwfJIA705XEdivZYe4p++ijQtKkWKJs64C8cU/W9zXYa0SLLLQ7OyyK2A+vbMstk0EBceXUCWsQgxMHPZpbCRSuSwRrix6dqo0kKnfrH2rBNB4Pp+bJRysy2PIJUqgXwtL+zits2eAooPzbFVeZdLvhuc5RR0DGa56H6K+KRh5MUGrp41zoy3D53zDcpdRF90Mq5/lohsDKy2Qxocw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnK3sOHyovHzkAnsY3epSci+WWtdps2dV5iKF6xSkGU=;
 b=VeDymPOUNnMzuBbT6THJz6Krel2kaDvV1DExFlw0wzEBWVmZuRlV2xeQ37VsyH2PPbAbwImGJH0s+NNTovbNtR7SxzB7hhOQi61jJ5CDJR4o/11qYP0PS4dSGRGHIfFdQ6UcjbpC7CUJi8bJ5ZqW/TSPDkf/IwYodT6DzSTm1zxDY+I4gSoWm7F3L7qAz6aRNrGr4bG7oL7s3TxKxvouZGVN9eNJ6Po/K7HlkFV0nEDF4Ro45d3Gfsqp+BLqwYJ1XlV1m9F1u4oKK7z/h5fXYneYxvpuXL+ZIAsRewSvZ5ranLtuApYNQtpbMSyPgJCxHMFBcW+nKApTa338wtRTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF06F7EC6B5.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::807) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 11:40:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 11:40:05 +0000
Date: Thu, 11 Dec 2025 11:39:58 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 02/13] net/ice: use same Tx path across processes
Message-ID: <aTqtjmjRHjphXtK2@bricha3-mobl1.ger.corp.intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
 <20251209112652.963981-3-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251209112652.963981-3-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0134.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF06F7EC6B5:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c09f8ae-f71a-43f9-b826-08de38aa070b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SdT0S/nQGymVY69yVSizRPf06+Mbff+BTCafVqb27DPR+PdBoXErkze5KoBl?=
 =?us-ascii?Q?WY86aQvMzVycVH6v0m19/wxA52Dy97k+GHGwyeFoIGG0FVaX2Lm1ZNHIommL?=
 =?us-ascii?Q?DZ3x2QrhUxLsxblninLY0VS7PDU8H0pPBKIHaQFV1kfblY+1GD5cILUoutGl?=
 =?us-ascii?Q?NX1letyoStXvLcu/1PsbofPrlZoyFx+EqIQxsQzOJZeMzr6BelgVUsfA862y?=
 =?us-ascii?Q?xwOAJJ0Nz8Eugj/ONL+MknYdGzWtdSzAUQR2ObkKUZIWyLoFAr98SgxQ3Lmn?=
 =?us-ascii?Q?fORsfVAdCGyIxtBVVCEwe20klPKOSM+JHeTXYzqLVL5/fD7jA1N/plwwfdRT?=
 =?us-ascii?Q?BHojExN+L7Oywj8OwjmPkVfeLU2KzVNW1zAcAh07TfLN5H7vh9mlF4l7b4iY?=
 =?us-ascii?Q?Ch8U+EEh/dkghvzaBTA0Or+ZwhuOL1lTWmSP+WKip/YfRPqNjBRmki8MWTiX?=
 =?us-ascii?Q?PX+W/dNIrGdnYDFDrNRlFGnnDdkBzxc0O4Ohyg/9aN9KEoqkK3ckPZMHTPPe?=
 =?us-ascii?Q?pzu3AxcG2tuSSvf3SMQJtgN1uICpVFeOtFrtD6DqD5cgWlCH4i5WklkK9kV+?=
 =?us-ascii?Q?BarJqYerd7ntOf/iwVQKkk6UQIhA3o7aaRrJ1sCnlHe34ef814tMM+8Qg2xB?=
 =?us-ascii?Q?xAtiQjo/ONYSQFkpxQVlPkAgDEBRP+RiB0tfP+PyqD37DTu+VJyAmr1TseaK?=
 =?us-ascii?Q?S8TDS1DAQl9VaKuL03/+2uMYaas4UBzQBYRLJQi8ID3Ck5UqN55mjspOfFq7?=
 =?us-ascii?Q?ksijkSo6uYGOYBVy1RN2xWWOhXCeh4fltgTXEGh99cLWnkfQB+L23ykKmUN3?=
 =?us-ascii?Q?HOPmHFpSIuY6LR1vn1RoZ3eDwoCG22ex6koyBo7Riv3e0m3Act0sult3plva?=
 =?us-ascii?Q?C2mGGJrXamncApgOucfjfjTMpfB/FUoZ5z89aqePcgygnJYuasHT9ZmOlfwt?=
 =?us-ascii?Q?hyzSZNtPWtROgUZUXJ7BAHavUfZR9u6vYJykLuJcDeyiC5eTwspk3mCm8HE+?=
 =?us-ascii?Q?CE8fKyqUA8JvJ6JGtIh3mxgt9SQJqKX1xwEbN6mHoamvm4nCY53A7TKATdQ1?=
 =?us-ascii?Q?hvy4h9u5tEbl8DzQBGsH9KJ78TFEtqzX92eMDQJtkLMfxcZP7/L6k3K85UDY?=
 =?us-ascii?Q?1l/aB7iREoUfDT6u+mmQ3335qbCBwis9icAZ3TORKgW9wVH7TarBqwNgjlHH?=
 =?us-ascii?Q?JnNJmlEi7f4hy9mYGJ5GsqFImkrJBNmoqrzEazb6jqUjwB3p6hfAIi28YnMw?=
 =?us-ascii?Q?FS+71W0l5Ze7AxKzJBK8qYO9fS5i39BE7HzX6m96v82G6ifoiatdgeIL83Tr?=
 =?us-ascii?Q?UzzidBcSM4jxXDBt+Z0Cy1olTyqVDAnjcKSBx3JUMhgKm2Kh1swAptuwuIMq?=
 =?us-ascii?Q?l12AQnCQGkidVCX05/VzqprlUfaxIlK6raO8U5KPaggfVKTfsB0kwUJurtrS?=
 =?us-ascii?Q?mi+P/FMk5eEy1ulYfJ82SsWO+JdCYu4N?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kGhxie5AzAGIA3tNsVNHtnzzFwbf5iWdEzFC+rn5VGE47GszPFEF02UI1eim?=
 =?us-ascii?Q?OC70Yrlv4GP3Hnnz3Ovu7dGMFOuS3tutZ7PQ/vW/xXkv45Pc2wblxOC/1t1e?=
 =?us-ascii?Q?WJD01SHVRg4O/oJFe33mC5YBQXaIjYf3NYqVSjhpi8H5vy7FdjeLJHtCYqbZ?=
 =?us-ascii?Q?w2kqO6Xou07H35D526D9+CVUkILe75yFgbMoujtxCyk1PUHSjdUe/1v/J14r?=
 =?us-ascii?Q?Q45oMUU6kSi1hN4/1TFHPqLM74OyyJ/vfcR7Pu53SkPj/ohVlPvEVYxJ1iKR?=
 =?us-ascii?Q?2GqaYXen5rFgXZJPNkzu5u1KjMmUx9f+Pspk40PzXTBUwe9sVck7E5vKqm9O?=
 =?us-ascii?Q?WeiRQ7AabpuMKBaMhJxYint38he2XmS3mtaLjGqhC6qf7jihDFNfVUlLFfCk?=
 =?us-ascii?Q?KbsVw1k+V1RL8YnVx6Ml2OnAG5ggzpukMbAXLEDgryA1ehUe5S2750cFGhtz?=
 =?us-ascii?Q?oJk9Go2tLbb/Cmk3HxCGYR92OjMoMt630bxIw6yB5k4fI1Oknn/+/TZcqUyE?=
 =?us-ascii?Q?5Fc/2BM3if5xr8dbFsalD3GWiQ+m9qUENuU4D0cVVrYfknUrq6wT/9u1BNq7?=
 =?us-ascii?Q?MaMmNkmNXDsCPVmAc6LByMxA5xVkswBM55ukUhuxglmWJHQnIKA6QeM8G3Ad?=
 =?us-ascii?Q?/HGe8JHm7NMBFc9mcaCCle0n7NRz7m50IAYEJ1VMb6hxN3EYmZPr065riu2C?=
 =?us-ascii?Q?s9p1vpHpRxuug7e+fdW6wmATL1fSOErqSCZrb6nI1RsXacdAHgcF1x14Gaia?=
 =?us-ascii?Q?/4iPld1L2vP4AuCbBVNMqTgmY6RNYsZlsxOGGK++vPgLccHsoPppmIFrUA8h?=
 =?us-ascii?Q?DOygo7poLWUCSgWfGy+wx6meBY0kPKC8MBaigkejj7n1Y7iibVd7ZQD9TikS?=
 =?us-ascii?Q?HV+OHytgb7ErVuWMKvOyJ8+Zr70PAFybjRnOJilIfOrEMriaYo/+3sGBPkHa?=
 =?us-ascii?Q?PTJj7gWRZjIOrOKPRkN1zclznx77NFmN3RP29WVd2W4pN9pV/Z0WjZ32v7R5?=
 =?us-ascii?Q?Ne6Vx/OGml2DIpHi0iYpPRHA/6KKupzKMlBU1BY9YKd9gWpo3NDhDyoqRvQM?=
 =?us-ascii?Q?zGOFNY9h3fS4Y07jUbBFtGeSE//vTep/0F7PlUDavruPcpeBRSCFVb/UIjPg?=
 =?us-ascii?Q?vPJ8fYFVz9geIwODKEN4Vt1sOgVJw6GPjlJKx4Lk4cMatBJSl9fyvS2gmuYe?=
 =?us-ascii?Q?ji9TGCLx2qLD2aUej5vbuMP78HHAfCDW4ILl7kOaT8Ox/cSVdBFrcFAlIULn?=
 =?us-ascii?Q?aWCLhxJ1fSlVmRYlkQlVHscdbhIx9TAhciPWm0BxpRFF+eie8kWLFF2N/uvU?=
 =?us-ascii?Q?zYpja+RAjaZmCEDBs9z4f1YY1qzcWliQqEJZTBLtj7CFgICF39QzrZ26AbgY?=
 =?us-ascii?Q?R6uyARwmRE0I8q8AuXha6ZvwiPxbpvJfL01Z8/MAmbu+uLRPi/5bmSDDtEpA?=
 =?us-ascii?Q?16Toh2R3Rv1VpAuGO6SvRWpTmjxBcAudF1sKh2TZKDKgH1Lom5/CMW1QGyzU?=
 =?us-ascii?Q?efMalRALi8rcd8a7sAArsnop7/wexS9wPwl2Lh47pwT0Rg4vcNjFIs8VEc7R?=
 =?us-ascii?Q?oN0PJAzKWeZKb+Uad0pd1/C9vxwC/7k1eZ/83yFXVs73IFaxsej6xfK6nlbz?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c09f8ae-f71a-43f9-b826-08de38aa070b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 11:40:04.9599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUe/cvW93jUzetsBU74vD2emHRYOugLpS+ArtM4wgY0rCXKYmMoLDyK284RDFQEPT9cMPcKjSzUBgxP9iivzSBvN3XDjY8NXa9x4xGcHP3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF06F7EC6B5
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

On Tue, Dec 09, 2025 at 11:26:41AM +0000, Ciara Loftus wrote:
> In the interest of simplicity, let the primary process select the Tx
> path to be used by all processes using the given device.
> 
> The many logs which report individual Tx path selections have been
> consolidated into one single log.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c |   1 +
>  drivers/net/intel/ice/ice_ethdev.h |  12 ++-
>  drivers/net/intel/ice/ice_rxtx.c   | 139 ++++++++++++++++-------------
>  3 files changed, 87 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index c721d135f5..a805e78d03 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -3900,6 +3900,7 @@ ice_dev_configure(struct rte_eth_dev *dev)
>  	ad->tx_simple_allowed = true;
>  
>  	ad->rx_func_type = ICE_RX_DEFAULT;
> +	ad->tx_func_type = ICE_TX_DEFAULT;
>  
>  	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
>  		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index 72ed65f13b..0b8af339d1 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -208,6 +208,16 @@ enum ice_rx_func_type {
>  	ICE_RX_AVX512_SCATTERED_OFFLOAD,
>  };
>  
> +enum ice_tx_func_type {
> +	ICE_TX_DEFAULT,
> +	ICE_TX_SIMPLE,
> +	ICE_TX_SSE,
> +	ICE_TX_AVX2,
> +	ICE_TX_AVX2_OFFLOAD,
> +	ICE_TX_AVX512,
> +	ICE_TX_AVX512_OFFLOAD,
> +};
> +
>  struct ice_adapter;
>  
>  /**
> @@ -658,6 +668,7 @@ struct ice_adapter {
>  	bool tx_vec_allowed;

Can tx_vec_allowed by dropped at this point?

>  	bool tx_simple_allowed;
>  	enum ice_rx_func_type rx_func_type;
> +	enum ice_tx_func_type tx_func_type;
>  	/* ptype mapping table */
>  	alignas(RTE_CACHE_LINE_MIN_SIZE) uint32_t ptype_tbl[ICE_MAX_PKT_TYPE];
>  	bool is_safe_mode;
> @@ -679,7 +690,6 @@ struct ice_adapter {
>  	/* Set bit if the engine is disabled */
>  	unsigned long disabled_engine_mask;
>  	struct ice_parser *psr;
> -	enum rte_vect_max_simd tx_simd_width;
>  	bool rx_vec_offload_support;
>  };
>  
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index 74db0fbec9..f05ca83e5b 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -4091,6 +4091,44 @@ ice_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>  	return i;
>  }
>  
> +static const struct {
> +	eth_tx_burst_t pkt_burst;
> +	const char *info;
> +} ice_tx_burst_infos[] = {
> +	[ICE_TX_DEFAULT] = {
> +		.pkt_burst = ice_xmit_pkts,
> +		.info = "Scalar"
> +	},
> +	[ICE_TX_SIMPLE] = {
> +		.pkt_burst = ice_xmit_pkts_simple,
> +		.info = "Scalar Simple"
> +	},
> +#ifdef RTE_ARCH_X86
> +	[ICE_TX_SSE] = {
> +		.pkt_burst = ice_xmit_pkts_vec,
> +		.info = "Vector SSE"
> +	},
> +	[ICE_TX_AVX2] = {
> +		.pkt_burst = ice_xmit_pkts_vec_avx2,
> +		.info = "Vector AVX2"
> +	},
> +	[ICE_TX_AVX2_OFFLOAD] = {
> +		.pkt_burst = ice_xmit_pkts_vec_avx2_offload,
> +		.info = "Offload Vector AVX2"
> +	},
> +#ifdef CC_AVX512_SUPPORT
> +	[ICE_TX_AVX512] = {
> +		.pkt_burst = ice_xmit_pkts_vec_avx512,
> +		.info = "Vector AVX512"
> +	},
> +	[ICE_TX_AVX512_OFFLOAD] = {
> +		.pkt_burst = ice_xmit_pkts_vec_avx512_offload,
> +		.info = "Offload Vector AVX512"
> +	},
> +#endif
> +#endif
> +};
> +
>  void __rte_cold
>  ice_set_tx_function(struct rte_eth_dev *dev)
>  {
> @@ -4101,74 +4139,58 @@ ice_set_tx_function(struct rte_eth_dev *dev)
>  	struct ci_tx_queue *txq;
>  	int i;
>  	int tx_check_ret = -1;
> +	enum rte_vect_max_simd tx_simd_width = RTE_VECT_SIMD_DISABLED;
>  
> -	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
> -		ad->tx_simd_width = RTE_VECT_SIMD_DISABLED;
> -		tx_check_ret = ice_tx_vec_dev_check(dev);
> -		ad->tx_simd_width = ice_get_max_simd_bitwidth();
> -		if (tx_check_ret >= 0 &&
> -		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
> -			ad->tx_vec_allowed = true;
> -
> -			if (ad->tx_simd_width < RTE_VECT_SIMD_256 &&
> -				tx_check_ret == ICE_VECTOR_OFFLOAD_PATH)
> -				ad->tx_vec_allowed = false;
> -
> -			if (ad->tx_vec_allowed) {
> -				for (i = 0; i < dev->data->nb_tx_queues; i++) {
> -					txq = dev->data->tx_queues[i];
> -					if (txq && ice_txq_vec_setup(txq)) {
> -						ad->tx_vec_allowed = false;
> -						break;
> -					}
> +	/* The primary process selects the tx path for all processes. */
> +	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
> +		goto out;
> +
> +	tx_check_ret = ice_tx_vec_dev_check(dev);
> +	tx_simd_width = ice_get_max_simd_bitwidth();
> +	if (tx_check_ret >= 0 &&
> +		rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
> +		ad->tx_vec_allowed = true;
> +
> +		if (tx_simd_width < RTE_VECT_SIMD_256 &&
> +			tx_check_ret == ICE_VECTOR_OFFLOAD_PATH)
> +			ad->tx_vec_allowed = false;
> +
> +		if (ad->tx_vec_allowed) {
> +			for (i = 0; i < dev->data->nb_tx_queues; i++) {
> +				txq = dev->data->tx_queues[i];
> +				if (txq && ice_txq_vec_setup(txq)) {
> +					ad->tx_vec_allowed = false;
> +					break;
>  				}
>  			}
> -		} else {
> -			ad->tx_vec_allowed = false;
>  		}
> +	} else {
> +		ad->tx_vec_allowed = false;
>  	}
>  
>  	if (ad->tx_vec_allowed) {
>  		dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
> -		if (ad->tx_simd_width == RTE_VECT_SIMD_512) {
> +		if (tx_simd_width == RTE_VECT_SIMD_512) {
>  #ifdef CC_AVX512_SUPPORT
>  			if (tx_check_ret == ICE_VECTOR_OFFLOAD_PATH) {
> -				PMD_DRV_LOG(NOTICE,
> -					    "Using AVX512 OFFLOAD Vector Tx (port %d).",
> -					    dev->data->port_id);
> -				dev->tx_pkt_burst =
> -					ice_xmit_pkts_vec_avx512_offload;
> +				ad->tx_func_type = ICE_TX_AVX512_OFFLOAD;
>  				dev->tx_pkt_prepare = ice_prep_pkts;
>  			} else {
> -				PMD_DRV_LOG(NOTICE,
> -					    "Using AVX512 Vector Tx (port %d).",
> -					    dev->data->port_id);
> -				dev->tx_pkt_burst = ice_xmit_pkts_vec_avx512;
> +				ad->tx_func_type = ICE_TX_AVX512;
>  			}
>  #endif
>  		} else {
>  			if (tx_check_ret == ICE_VECTOR_OFFLOAD_PATH) {
> -				PMD_DRV_LOG(NOTICE,
> -					    "Using AVX2 OFFLOAD Vector Tx (port %d).",
> -					    dev->data->port_id);
> -				dev->tx_pkt_burst =
> -					ice_xmit_pkts_vec_avx2_offload;
> +				ad->tx_func_type = ICE_TX_AVX2_OFFLOAD;
>  				dev->tx_pkt_prepare = ice_prep_pkts;
>  			} else {
> -				PMD_DRV_LOG(DEBUG, "Using %sVector Tx (port %d).",
> -					    ad->tx_simd_width == RTE_VECT_SIMD_256 ? "avx2 " : "",
> -					    dev->data->port_id);
> -				dev->tx_pkt_burst = ad->tx_simd_width == RTE_VECT_SIMD_256 ?
> -						    ice_xmit_pkts_vec_avx2 :
> -						    ice_xmit_pkts_vec;
> +				ad->tx_func_type = tx_simd_width == RTE_VECT_SIMD_256 ?
> +						    ICE_TX_AVX2 :
> +						    ICE_TX_SSE;
>  			}
>  		}
>  
> -		if (mbuf_check) {
> -			ad->tx_pkt_burst = dev->tx_pkt_burst;
> -			dev->tx_pkt_burst = ice_xmit_pkts_check;
> -		}
> -		return;
> +		goto out;
>  	}
>  #endif
>  
> @@ -4186,24 +4208,13 @@ ice_set_tx_function(struct rte_eth_dev *dev)
>  		ad->tx_pkt_burst = dev->tx_pkt_burst;
>  		dev->tx_pkt_burst = ice_xmit_pkts_check;
>  	}
> -}
>  
> -static const struct {
> -	eth_tx_burst_t pkt_burst;
> -	const char *info;
> -} ice_tx_burst_infos[] = {
> -	{ ice_xmit_pkts_simple,   "Scalar Simple" },
> -	{ ice_xmit_pkts,          "Scalar" },
> -#ifdef RTE_ARCH_X86
> -#ifdef CC_AVX512_SUPPORT
> -	{ ice_xmit_pkts_vec_avx512, "Vector AVX512" },
> -	{ ice_xmit_pkts_vec_avx512_offload, "Offload Vector AVX512" },
> -#endif
> -	{ ice_xmit_pkts_vec_avx2,         "Vector AVX2" },
> -	{ ice_xmit_pkts_vec_avx2_offload, "Offload Vector AVX2" },
> -	{ ice_xmit_pkts_vec,              "Vector SSE" },
> -#endif
> -};

Looking at the code with this patch applied, I think there may be an issue
with the scalar case in this version. At line 4197 we have a block which
assigns a value to tx_pkt_burst and tx_burst_prepare, but does not assign a
value to the tx_func_type values. That means when it falls through into the
"out" section, the function point for pkt_burst get overwritten.

> +out:
> +	dev->tx_pkt_burst = mbuf_check ? ice_xmit_pkts_check :
> +					 ice_tx_burst_infos[ad->tx_func_type].pkt_burst;
> +	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
> +		ice_tx_burst_infos[ad->tx_func_type].info, dev->data->port_id);
> +}
>  
>  int
>  ice_tx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id,
> -- 
> 2.43.0
> 
