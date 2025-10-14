Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497DECCD192
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 14:38:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 737CD402CE;
	Tue, 14 Oct 2025 16:38:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 995AF402A8
 for <dev@dpdk.org>; Tue, 14 Oct 2025 16:38:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760452703; x=1791988703;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=leSAtesQyTmlGE8jOi5AL0qGeVttZvp8p5Bgwj8RnPU=;
 b=hD9cpGdAEXD5fHUPonrvepePRv5LDyR4TgKv48xcmgiRNSTXzcge0Ag9
 3WedmTdNmHXSzkjjtsGDl4dB6WU/yj2neL435JAWtDUgPcZV/Njx59mgH
 j4RpuQ5GcAQ9MawQJQ7yaauRmEVJBfHN8duu8aqe8/iWd6XK91L2yKRqa
 zetlQCEXP8gfIIPFFJ9NLONKUONkauargfEkKvHBK/0V6lu5VSsum9B6y
 Nd+hSMOxWzCYMa24w2wNQH1mnfCueVFgqbUsRUeaMaAdg+AO/pgEn9PJt
 qv6H6YYZNq8UW+bRjCDK30jILhFNiCvglukc9mbxK8ciD02ckmNCeHcqr g==;
X-CSE-ConnectionGUID: v1BcX+aRRZKRi6K8Z8PKcA==
X-CSE-MsgGUID: YFy9bCWRRJKu3k3QvXrCIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73213796"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="73213796"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 07:38:22 -0700
X-CSE-ConnectionGUID: 9kbh2o6pSI+jLXagg24cww==
X-CSE-MsgGUID: 4U2nmcfiQ1K4jaV9oeP0uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="186993066"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 07:38:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:38:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 07:38:20 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.62) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:38:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTXgMpwe+EVVOnV/AuwRsZm18mpNSNfV5YV6G00ZLbUyZJ0ZYVP7LZW79FYJLElax11tVbDinuBHh7mSzhV5kiaxWkGMLQurCQsN5Rrk3kUGqeZQ2+lN2M3rGxUQ9FyGsz/mcr8MWqzBZazFltJgyAiM5u8RRsfg7m3SaR/Iz0ikUTGGr0rPLXGWh/zMzYhttQzH/sURoBPxWuwcXPQa/GdF1kAURt7yy97+TFaKJe4ishiLcdk3yVui/+I/UQZhp7YmoYMZot3lWur/yKbq2mcPkGemP1GrbGNnFwmLlOxRnq2QpBcjFI96iVukuAPchWzlQjB+ydF1zrd6LXWbhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSYTL6Q6aAsw4Sw9wnBs3Jb+DJLjkIIbGTqBhie1Ny4=;
 b=ktgnHRb91iATjELa1rxf2UrJK/TvZGOmQYPu6PCIpiZkNpfmdSN7d+CzW3My3uLEQDZvE8NYSV0XMQx5K4wqb2CMzft6fy+AaN/Ax4GfrFCuJANPh8DK91M0RTjAbHpyaZU0QRfR7gqSt5pWvQUtgBWsDCE1VH2gaqmEAoEMNRgmk9YrmR2QGol/YGde/zzuXMYt3lgbgiR7pLz3f6kPjNtWvLQBpKnZEu88pYdKlByvaF81YUFBl42RdHH6hKa9L8ROI4BwTZvSyw1hM/72k3aKt+K1B1GXUPZ9/r2lTCI6hoXsxSJeyNzRknlKu5zu2udTlBlCQrGTyqMeoRVH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7945.namprd11.prod.outlook.com (2603:10b6:930:7b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 14:38:15 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 14:38:15 +0000
Date: Tue, 14 Oct 2025 15:38:11 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 4/6] net/iavf: reformat the Rx path infos array
Message-ID: <aO5gU6sSP0axWOnw@bricha3-mobl1.ger.corp.intel.com>
References: <20251014084517.1407407-1-ciara.loftus@intel.com>
 <20251014084517.1407407-5-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251014084517.1407407-5-ciara.loftus@intel.com>
X-ClientProxiedBy: DB9PR02CA0015.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 803e79d0-58ca-4436-3d31-08de0b2f4f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SfF3E+Yhusx9FuUa5sOHzjPujU5SIMC8v60Cf8hWe0J8MEni36tbXc7qWqpm?=
 =?us-ascii?Q?3j9mMSL+ius3PQRukbD4Giiv1r5u+6tOjdRdu/mJV7tPP41TZecNvYZtU2Mt?=
 =?us-ascii?Q?mGXty3HsLfqWG1UuEIja7befjqtvLIBW945+Q1H73rFcoyXsA0LooOwXre8L?=
 =?us-ascii?Q?JOpuHgV3A8Tj3mpY8im9jzy0DFo0oyJCPb0da+GzFto1qf2dl/7O0l2lHo1w?=
 =?us-ascii?Q?5h0Ik5eLY13WKF+hcwrVikRwb8lXx9ybK7cbBXmKXSAjFg1cCNwcy9mpHGBt?=
 =?us-ascii?Q?5bTMoTsXXPQ5hb51+EuNpZvZU9SlZ/H41OROfA1jg+snlb1eoQXKY2S0ieGA?=
 =?us-ascii?Q?ionyHdjZQjQcu5WsGYTYHZpRE4AVEKznjOu7MjglETb8+LXlx/aMpq99qGfb?=
 =?us-ascii?Q?ghNp588Cl1ACiIzXEal3fSliG0iKjNgrfAGFdy7auCysC6LKGKVYnVDim60U?=
 =?us-ascii?Q?iIEpkBaCU+pzNm5pI1SjCNlLq+yqZPyu/OehXYlg2a0+gIoJI+mF1UWxDAe1?=
 =?us-ascii?Q?6FxcrwF31vRbVfe2J5B+mbbD1dUHZd/A/z5QlgDCYaMZcy4Qi53cnLyStegz?=
 =?us-ascii?Q?f9JGqBdRI1pgJwjap6vP7Qobl0kmn9WojgnHsJO6d1wCb8IEpufnS2dLJRhh?=
 =?us-ascii?Q?BxdYPmJasjDOAxO5GzBCxUCuloRz8s3EXMFIyyEsPquAq/CAeCKaCNjylYB7?=
 =?us-ascii?Q?rgRAhlgaDYg6A/DfjwMRT1P/jYbEm4S3qvRpb4oh5uEbIY9KgBhRL9FrC+wh?=
 =?us-ascii?Q?4X9gg3lRGg9brQTo5TFdGJC67VSSzJskfnZuo3yMXC60ZkUmMAV/NKlejlLO?=
 =?us-ascii?Q?127BvPYhofwGCBKh/9Z8jKJrYd2pNYIfwwYaOcSXxD1zsYqSM8yi/WcFMc2i?=
 =?us-ascii?Q?Ka8OmgWenn3OI+KseXv0u/uTORkjrHziDuf12kMpFaVK+9BTst52Bva6Y3lJ?=
 =?us-ascii?Q?3cexOKy19Wtcq43iAb9pXwuXgW8dEWk/9xuse5aagC+k7LepkMOe9MBcQ4D1?=
 =?us-ascii?Q?ZFnieN5F1WjOWkPV6iATFDcm4jaKmxXgmWkSIbAQxXskpM6AVcY/bX1/Wdhy?=
 =?us-ascii?Q?1SGMcy5TLJq6AWvoGiXEJECs60qaTOOtjcEVwg5gk/TRvc4gd33yQjLrkFlm?=
 =?us-ascii?Q?ntEpfyT49UW9LMFROJAlOWUDBQ1gVsjEE243Zry94RQTe/ORijjSjXHlv2Nx?=
 =?us-ascii?Q?Xa3jgRF31LhhLFpcuAs6OHvOjVhtUSATKQzA2qQeHg3Rf63SFucDwIsW+XyV?=
 =?us-ascii?Q?INWxjZtKb47IzDuzwPaeyorblL5yFZzbIGNMG2h03mNrgzJYCLLtklA99ed3?=
 =?us-ascii?Q?azMdBKofIPL07Jrr7uR0XV3r4VLgLeJpwE2I3kiG1Jlg3R4c5nEqodVTuBCL?=
 =?us-ascii?Q?mgzlbT7ldR+Rh8vTSLkMAY7meOHg4Z+VnyrXDD+47LUxwHBgYMukVKG/pwAO?=
 =?us-ascii?Q?nc0dEoYdHsJKKzbvuqmKjjSzjoooFZEU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l+0LOn0RZ+f2RyVDoNjnxE4Iw3eVfVw5gWV+/3gpGvmg9fVL6WOaVECQXI0d?=
 =?us-ascii?Q?MtUZxxJW3p2+cd3uSBCxlA2CvmEIYGLKYKC9r1J95DcssZ4M9LH/PPAfjdUQ?=
 =?us-ascii?Q?QzNdNrITxDmq5mKiVv6KGS/c0QC1WE17IUfgjy9ZUNC6jDfaW4QrS2Q48SWO?=
 =?us-ascii?Q?E75GvZ7v13QaNGGAKvupALQFgXbvItniMMGRUzXNJbI34wgl3d78Cp2+O+dD?=
 =?us-ascii?Q?XF7h3OteTfS15cDYRgwXkYh+JHD2LgapIrp/nUposCpPqk75okiDtlN0VrZ+?=
 =?us-ascii?Q?93IWqkeepyJOq2tdHT7Pk/L/pPVyDU/nD88cyFDeQA1iIVToqEimLskGY4Et?=
 =?us-ascii?Q?whqSfH4qHVk097SBySb54MxWOkNB0/GanbSPJlXcwuxYChhvQqdJOCcRM2JW?=
 =?us-ascii?Q?RM5I+TlmIJIav7w3bat83xWbKIme+gI5zLSln7iL4cJhoUOftg2KSVdY2xDZ?=
 =?us-ascii?Q?J17r/4QW7AFDB8PMoBCNvLDnJBRe9YWcZDf635HRfbqYNRPYYIV52b/53K6h?=
 =?us-ascii?Q?6sy5BFMmL5PkvNhFGVxNAdXF899XRxVVTno+N7cuROt4ebFpmI3WQj6DAReV?=
 =?us-ascii?Q?ZRThDcb/bzPZ+FVko2QzwJvr9o27c28gVN2mOdR+9V6TQAyWcz9XG8axd9SL?=
 =?us-ascii?Q?NzbcB7uERB368XlAnCh9pX1TCGXP/zfsMvTnSYB/kEk0FGQdjqNIiIJo090Z?=
 =?us-ascii?Q?1ZgPkqyWXZuTT0Dwu2WK7SLZ9wNAfr7Ig1YzM2WzTvzaXI5zenvzYVDKQYtb?=
 =?us-ascii?Q?xxuPRY3bMwrbHalHwS4CULtcb/yGwQI3Z3ozRQiG0Q/7NhKq69Pl5ZFZlEps?=
 =?us-ascii?Q?qXGD49wY8VbNYgz7pVYp/QWeXTKRalzrQYZBPJwqywC7Qb7bWYzFPXt0zgFy?=
 =?us-ascii?Q?jCZYbl/dVcqTGQ7yTzVvNe9/1n3uNVhlraOH4FLRd4gQitCZJ+5+dHA1z3k7?=
 =?us-ascii?Q?VWJQoSwLiIMPKwrLwKJ5fOkspXPSfKSEjCb6YGDdHf6ZhnsyE/IPzLKlTuay?=
 =?us-ascii?Q?zr7wlFvs8LZ/xopRWezylD4MYorHjQZJCwxtOU7wetD55bl73Ykv47VJmPfF?=
 =?us-ascii?Q?2XkSX+0p4YMGEbe7VpTMdlbcoiL6LqbJkDqEUa7QtWLkBo0c0h0Oqpqtsog2?=
 =?us-ascii?Q?txwc5xT934SkCdNmIZCHKnerbngmBSHd2xadaMZVZC6N5mL1i5QYr3BU7lPM?=
 =?us-ascii?Q?JR3QogUe9NogbcCniMPEWbkwqL8xRMI6Vt332MIXvP62AKmXmIMPWwvwQJ6K?=
 =?us-ascii?Q?Bh1exYvPlsKkB3g8H/tIIFrqSHMF80hs3Dd9t26i8wIZXPik7Eu1ajhoXJfZ?=
 =?us-ascii?Q?bsEAdfJA88gpu2c58WfLnd8JaLckf2oK67QxHtGtYjjCHaVRUMfG0MbcISLF?=
 =?us-ascii?Q?SenYUdlWZLTK4kisCct/TzgR6//u5TdzXg0ex5WQChb1EBtjb5nS09QKpqGM?=
 =?us-ascii?Q?FQmkPiqQBsAi9g/smbS3OTe+zLn/bmbWS7RyTanZrpBPjiHHGflc6W7L+gqj?=
 =?us-ascii?Q?7GZbh306BFsDqazxohT9l09eHiwPWIhpHxk50y8X0JilgxspwCU20DVxULxR?=
 =?us-ascii?Q?DDgCKp86gOB6uQjDdHShuRAVWbz9G4tw+Rw0KaddB+Wbx4q/lXKurzbTrZJv?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 803e79d0-58ca-4436-3d31-08de0b2f4f42
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 14:38:15.6457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zj3Zum5Gt1NUZGXhl04aDvRXZHbhQImvgFAEmolfGhLiFTWR8F1Djka94mL/J79l/3+dORb6a6Jhx1/nukJCRINjqUQtiRMObJI/Ncleooc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7945
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

On Tue, Oct 14, 2025 at 08:45:15AM +0000, Ciara Loftus wrote:
> In order to improve readability, reformat the rx path infos array.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---

Thanks, I find this format much more readable.

Some comments inline below.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  drivers/net/intel/iavf/iavf_rxtx.c | 289 +++++++++++++++++++++--------
>  1 file changed, 210 insertions(+), 79 deletions(-)
> 
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
> index bbf3a1737e..58d5747c40 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -3720,99 +3720,230 @@ iavf_xmit_pkts_no_poll(void *tx_queue, struct rte_mbuf **tx_pkts,
>  				uint16_t nb_pkts);
>  
>  static const struct ci_rx_path_info iavf_rx_path_infos[] = {
> -	[IAVF_RX_DISABLED] = {iavf_recv_pkts_no_poll, "Disabled",
> -		{IAVF_RX_NO_OFFLOADS, RTE_VECT_SIMD_DISABLED, {.disabled = true}}},
> -	[IAVF_RX_DEFAULT] = {iavf_recv_pkts, "Scalar",
> -		{IAVF_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED}},
> -	[IAVF_RX_SCATTERED] = {iavf_recv_scattered_pkts, "Scalar Scattered",
> -		{IAVF_RX_SCALAR_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_DISABLED,
> -			{.scattered = true}}},
> -	[IAVF_RX_FLEX_RXD] = {iavf_recv_pkts_flex_rxd, "Scalar Flex",
> -		{IAVF_RX_SCALAR_FLEX_OFFLOADS, RTE_VECT_SIMD_DISABLED, {.flex_desc = true}}},
> -	[IAVF_RX_SCATTERED_FLEX_RXD] = {iavf_recv_scattered_pkts_flex_rxd, "Scalar Scattered Flex",
> -		{IAVF_RX_SCALAR_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_DISABLED,
> -				{.scattered = true, .flex_desc = true}}},
> -	[IAVF_RX_BULK_ALLOC] = {iavf_recv_pkts_bulk_alloc, "Scalar Bulk Alloc",
> -		{IAVF_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, {.bulk_alloc = true}}},
> -	[IAVF_RX_BULK_ALLOC_FLEX_RXD] = {iavf_recv_pkts_bulk_alloc, "Scalar Bulk Alloc Flex",
> -			{IAVF_RX_SCALAR_FLEX_OFFLOADS, RTE_VECT_SIMD_DISABLED,
> -			{.flex_desc = true, .bulk_alloc = true}}},
> +	[IAVF_RX_DISABLED] = {
> +		.pkt_burst = iavf_recv_pkts_no_poll,
> +		.info = "Disabled",
> +		.features = {
> +			.rx_offloads = IAVF_RX_NO_OFFLOADS,

This is zero, so I would tend to omit it.

> +			.simd_width = RTE_VECT_SIMD_DISABLED,

Can our logic selection all work, if we have the simd_width set as zero for
these paths, also indicating SIMD is disabled? Again, it would allow us to
omit the SIMD value altogether for non-vector paths.

> +			.extra.disabled = true}},

Space before the closing braces? Maybe put them on new line?

> +	[IAVF_RX_DEFAULT] = {
> +		.pkt_burst = iavf_recv_pkts,
> +		.info = "Scalar",
> +		.features = {
> +			.rx_offloads = IAVF_RX_SCALAR_OFFLOADS,
> +			.simd_width = RTE_VECT_SIMD_DISABLED}},
<snip>
