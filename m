Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C62C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 16:53:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15B6E406BB;
	Thu, 27 Mar 2025 17:53:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id BD52340654
 for <dev@dpdk.org>; Thu, 27 Mar 2025 17:53:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743094437; x=1774630437;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NGYaZTak7HSzbG/tAC4mZx0/0cLr5kB691U0WyKaacU=;
 b=mX4eaGBILCltWt5Iwe6nmrjABQAgv/WoHPSmbi6tK10LKzCAelnXLJeu
 F/t93HVP8codIO/0Txl8cQ8YF2KFQ7TH6A8pNb6MfqnSPJg0MbXRN6Q4I
 Z1ekSbR5zTPpRM5FSIdB6k+cK+OckCt2XZm6Qw9cqq6T9rwHIwwVUFaRw
 KUE+D/KH1+S1QXDyCs/eIrEQylNf5gelJWzA26QM/2v7WVD+koNpBT37w
 ay6tbDMO9poq4cMr5TwKW4LeQKghu9JpP2OVjkxCDIkKWueUCqDBecgGU
 N3cFWxFPSaT/42xfbNFbAycQSRvuVmAJkrPE7paUoLnKJMapFUwUY9A2a w==;
X-CSE-ConnectionGUID: GWHpvKkcTJi6mHsp++cmQA==
X-CSE-MsgGUID: us6I0fUmQIa7gpnq1QQlXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44159233"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; d="scan'208";a="44159233"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 09:53:56 -0700
X-CSE-ConnectionGUID: 3Z+b6V4AT3aPfwPTMCGPYQ==
X-CSE-MsgGUID: 0nKpOw4zTrSW4w5U0w7Zig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; d="scan'208";a="130061515"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 09:53:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 09:53:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 09:53:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 09:53:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWhQa3LN+1dyu1CrjaCrRtYiH85OqdAXcy6OqXh/9MEAL3byAvxxkcv06rtqvyoP2Jp7+HZEmgOM9M3WKZrLEioS+cj3occ6IMTkjitPzub/C6xPAsCy2TDjqI7CWOBOvckmuUv6exQph2Lrekw5A6mAEhCEglD+UQJFIHtbCiy4ENIcUoId9icixGHoAKjhfdnLH6MfyYxYFypX4Di27f3SELxT9LJdv1PuQlBeVG7tjLv12a96K3/KzNPzDS9nwHb+FPDyS9KuWjZXFsfH78hGdgFYLuBmjdsSUeMOdq2B8yAzKWzTw+rzGru6nyr1rN9VKhNcMhFjkIn9FWWk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhF/5rscEGo3yXz3YNvLCO6f5h9e8z2dpvcHuj5LBcM=;
 b=bWIsxcuT7q5jzcjTaOL0EUIfUqHMDdL67ps4b0Irs8/u5bZPCuhc/onYzBYC4v+AdakAx198qjTQrZRJ4Z9lkLaHT5HcDaFPzPr/gJoZm8na34H1pFMIfsUwmdROX4y3A3ScribsctS2UWBIv41K5jN7ij78/WmC9xRTwPzuaJ5G6CmZCx5z4NWKi+GEoOsmmuVIDhx7ukBxxnOciMxW6y61tkDbuF2yIZ2Ubp9hfH7QDUxhIjJ5nnZYp1sk0UqJ5VXbXoRsiXWMPNfe9NE+MfFJjQujiW/t9tbLVfTi2wxsieOGbdRPtz1I4qRbjWFpSD6nDH5dmaKifpWPAFIhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7741.namprd11.prod.outlook.com (2603:10b6:208:400::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 16:53:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 16:53:50 +0000
Date: Thu, 27 Mar 2025 16:53:45 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: tirthendu.sarkar <tirthend@txanpdk03.an.intel.com>
CC: <dev@dpdk.org>, <pravin.pathak@intel.com>, Tirthendu Sarkar
 <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH] event/dlb2: consolidate AVX512 and SSE changes
Message-ID: <Z-WCmeXHFyCcVupk@bricha3-mobl1.ger.corp.intel.com>
References: <20250327095327.2095303-1-tirthendu.sarkar@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250327095327.2095303-1-tirthendu.sarkar@intel.com>
X-ClientProxiedBy: DU7P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d07fcc-4a3b-4d5e-76b7-08dd6d4ff329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yrauz2RGItPkzAiV9hvf359dnHiuGXDP5FwHgIbcFBeF6UxikucfSVOpN443?=
 =?us-ascii?Q?yAJJv7m3DEEL9wO33NhaZ6cCrLWwhX4wYFzQ/zUHLYjscFbaCaJ5/7TxuzS0?=
 =?us-ascii?Q?cJrdu2SnxTBM4aHh/+aop8S378HUf5rWdYpOFY9apM0BzXBZL5ddLqMmhwZO?=
 =?us-ascii?Q?L1/a4Z3fY/QNiGovobYB6Xw0RCzYa6HsKBXaRi6HSXmLkEZN6JTEJOxDpZfS?=
 =?us-ascii?Q?3c+YZDnZmRuoVTc1j5/UQW+NRcle06l2E6U160LWkkHVEv0GE/oLp7/Bn3H4?=
 =?us-ascii?Q?704Yt3W0JmxZF0J8Ytr4d0TFDSpZjhL8i+/2xxoDDBgL55/OJp4nSxaCjCep?=
 =?us-ascii?Q?7Ofta0DmZ6eV0fsxNbaf7pSFxbmOn8fGNW3vViR6WkWf/2w/j3H1+IMPEYsh?=
 =?us-ascii?Q?CYNYFskw38m38g+UPhpt8zgmNE/6aEjCIqllm08ybkNEdx0QNjf030PZYuyA?=
 =?us-ascii?Q?6mo3I6txAAGJRdALKA+8MAohyO1EusjC2S1ootdC5IaH59P7tBSBWzgLwE7W?=
 =?us-ascii?Q?yApj0V2Ne6nVmubHFNazEp3Rfq6ScOmGgkLPRnWOW0R1foWmdXhe4/bw+02Z?=
 =?us-ascii?Q?gJkUhihAk5bNDT1kMvnrTCReAQrr62qE2di3AqnFJT4a6OCam2YqvF/G2e8a?=
 =?us-ascii?Q?hQMYyGVay0GdhCdXjd5c1NbDzvhZKBkInaTDFNHF0YIb7efwlJnYBE1oUs27?=
 =?us-ascii?Q?uP6y+RUu4tvfrlRvb+T8DEKe+jRN/aeR/YFRZ9IKlrdukyCkUIdL+OCDdiz0?=
 =?us-ascii?Q?XBnPaWJsRE5oOWvof00ADtRbb11IZ1f9emoGkgYZsLSzrTc0efWn9tulLY9n?=
 =?us-ascii?Q?5UOx/s7SBWjFuaJhWRLN9lw/aFqel4+lzA9wF+8vtpucuqMtCfqroUAndBKM?=
 =?us-ascii?Q?Pev+dLVg4+1ufkgpsA4vP0OqXX9cji4DDh+DNAQMC24qag3URJVHvA6q2j3h?=
 =?us-ascii?Q?O2maxfIifPVA/tyVUzFcSCwGLLQ9vJj5gVJrWsn5rFX5M34OV5mDeSrXktbP?=
 =?us-ascii?Q?N50WpdGMN5R1VzRCpjYUgaRN8r+Kej3kEuvIumgzAr532FT0dMpY2YoZfMQL?=
 =?us-ascii?Q?eEI9Go7BdefzyEQO9qe98roa7IIZcaag1q5otAlW2El+ZN3p3BMW/3Of/XI7?=
 =?us-ascii?Q?AuHDhsV/O7WdCkJS0gN/70DBGd6ITcGpiTeHYVgqc3S/suK4CJLaHDKVmgzl?=
 =?us-ascii?Q?9jJa2N42i8PJgjS8RLtSUypqfZYy3UDb/H2ebvsGBCHB/U4UzCNTNHWwu5sb?=
 =?us-ascii?Q?ejaPY7nJIc8sVQ6wuamV2BG8xuKap7OlS8Gd/SrSlaXrqAbiCuqhVHbchOHN?=
 =?us-ascii?Q?3dHUgUWkA7F2IehCeZe91MkoIt360M4vnd+RsvSkP0uNZInLKNuLM64BBlFo?=
 =?us-ascii?Q?C6J6bKIYeQV4ME8b/OfJPYy8HQ1Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W8lXaSTcG/12Fo71McR1IH/mavKloZjjVHbJJiAmh5SQk+R/DlpPPXwHKtA/?=
 =?us-ascii?Q?tKZwG3r7iHHenX8jrYCPmc7m+StQbF3srDLEyZ591EZsSWxZV+mxZNGPN18R?=
 =?us-ascii?Q?+xIQnmuMKLsVaZDLh9j1lXhzPoRf5yrxEqd9Y8bguQUauiDCZN3ZkGHBBVMn?=
 =?us-ascii?Q?0F1TGKorG3GZ9xkSbCqrtQFMsUk0qyVkx5JeISXhYm9Kg0Hr0pU+ObcIDKCx?=
 =?us-ascii?Q?35NB98OLpuTTdChPl18PSVsBybWI7KkPKH0w3GGI10rb9iUmbh2GXnqiWSRL?=
 =?us-ascii?Q?WtG4legcqFWxX5wRzASoxmfUdmorxG82bpvy+1qau/lYn/MeAdjxCS6a8jyo?=
 =?us-ascii?Q?tGDvusimD37trKC9q4dvEsIlSFy4E3LTitlkoZBHZ0mSs4nkyvuYLs2c/t4M?=
 =?us-ascii?Q?uoBsNJi0d4tFXYSeQWOn/g0u3rAd11Y3e98dyWMLd5oCc5oJccvzI293SazY?=
 =?us-ascii?Q?WFKFeclfPiDIM5pbFXdE5CPqV7/ciGqIbHiXdwJfdO5XRO1s+0gCxoFm+AcN?=
 =?us-ascii?Q?GeKDG5ccP37hHx42MEGBNf8yaiaQKoN/bGrBhdyUKsnrePxOeHrtz4nWPxdw?=
 =?us-ascii?Q?5q7e/z+xd+B9xw3WFakg14zt+lPQizZr6+JWNGMHyzZqRBWyOd41dE6p4NAl?=
 =?us-ascii?Q?It6h8yKXEMei6yo7viSn0B8fV4dV5nYrpohJ/WVNVn57nyfbAZrDlWez4dqH?=
 =?us-ascii?Q?vXvSOiEjHwfOgxv5fMZ0GySy9PU2EkiH/iL71nMGQF2maMeRQ+6qpFZW0hZQ?=
 =?us-ascii?Q?FxQzZKxPYR//BlKdInqxpPntRyjEn7afOnA6gqL/QMPR0ZSHpuh/MMUqrKeK?=
 =?us-ascii?Q?5Cx2AwNHlnZrTThS3i5Np7P8DTNAukhy8TXM+hejEZ+Ku4ST5sczYtQZ8iV2?=
 =?us-ascii?Q?LbG0ErkZu/QToZI6it8B48EN3QANGOe6IUmg21lvMh9wnMOTmBDQyGg1uDwk?=
 =?us-ascii?Q?RsPh5w9ivJt9B4S7IJECHgkN8E9ijqOgXj1nB5qryzWyt5z8hv5vvwOEJBHb?=
 =?us-ascii?Q?AAim0iOkK68o1VplH6hHHftSzImDZrYzOk3qBZbbtlv3xe4K/npJFe5am2XS?=
 =?us-ascii?Q?HqvHUsNIhUPmI+HhIC4xjBRja92Hezq175kVMSMP+cgnvD/piROHQsyrO7cW?=
 =?us-ascii?Q?RAWHwsuwWngIDGE6RJqFc6UtHV0Fe/Qgbs1F6LB3IO89Qqffza5HeW51P+ki?=
 =?us-ascii?Q?lgjf5lRFm7+3iNcj4XLzI/wbuMsNfBZCMd0l8h3d5KXfCW4jgwoHp19YitYq?=
 =?us-ascii?Q?jXLQVVsgQ/VxpkVqq/GxAiKbWyaSoJ3fSTd53Sn7xOUcY6B+2GGNbzW1dXw2?=
 =?us-ascii?Q?Dpzpc0qvSPGlTcOTI25ZZE8nVdD3AOKJMSxIqDRY6AxCIX2YlU2CLCog7H0c?=
 =?us-ascii?Q?QUm/qnPwa8OqMkOgTyUba0xMHLJTjxCP3BWHR9ZSAb/w+2wP0BCLa/00qSMn?=
 =?us-ascii?Q?nfMvzfTnryvcxRJKySp+dCR9VQ81oXXoq5fIP9f0CdrQNCxyZQE0PUJ3/CRd?=
 =?us-ascii?Q?zUFWU6uMQfnnRJTHMP0rAlBg9QvfWD15vtSQwQPO+EAokYqe9euetEPaAGAg?=
 =?us-ascii?Q?7DHq/ql6SQGtfwPd9v8jqGXjM/SZ8dGnvjGtqCtFCGD97SqdRRTffvZ3KerQ?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d07fcc-4a3b-4d5e-76b7-08dd6d4ff329
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 16:53:50.7320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnzN872q8jS9A4PSy1CGbvN+uwmciK81ypJIM0FxiV3M6zLSk7vUXrXBAGwMsLMus5d/JK726sjGEEz8ezP39syHhAvSqgxwHLnqLWZ8u6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7741
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

On Thu, Mar 27, 2025 at 04:53:27AM -0500, tirthendu.sarkar wrote:
> Streamline code for AVX512 and SSE by removing separate files for them
> and adding runtime checks for selecting appropriate paths based on CPU
> capability. Also, update meson build file.
> 
> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> ---
>  drivers/event/dlb2/dlb2.c        | 248 +++++++++++++++++++++++++++
>  drivers/event/dlb2/dlb2_avx512.c | 276 -------------------------------
>  drivers/event/dlb2/dlb2_priv.h   |   6 -
>  drivers/event/dlb2/dlb2_sse.c    | 232 --------------------------
>  drivers/event/dlb2/meson.build   |   3 -
>  5 files changed, 248 insertions(+), 517 deletions(-)
>  delete mode 100644 drivers/event/dlb2/dlb2_avx512.c
>  delete mode 100644 drivers/event/dlb2/dlb2_sse.c
> 
> diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
> index 934fcafcfe..ac0eb3fb24 100644
> --- a/drivers/event/dlb2/dlb2.c
> +++ b/drivers/event/dlb2/dlb2.c
> @@ -2669,6 +2669,21 @@ dlb2_eventdev_start(struct rte_eventdev *dev)
>  	return 0;
>  }
>  

<snip>

> +		 */
> +#define DLB2_QE_EV_TYPE_WORD 0
> +		sse_qe[0] = _mm_insert_epi16(sse_qe[0],
> +					     ev[0].sub_event_type << 4 |
> +						ev[0].event_type << 12,
> +					     DLB2_QE_EV_TYPE_WORD);
> +		sse_qe[0] = _mm_insert_epi16(sse_qe[0],
> +					     ev[1].sub_event_type << 4 |
> +						ev[1].event_type << 12,
> +					     DLB2_QE_EV_TYPE_WORD + 4);
> +		sse_qe[1] = _mm_insert_epi16(sse_qe[1],
> +					     ev[2].sub_event_type << 4 |
> +						ev[2].event_type << 12,
> +					     DLB2_QE_EV_TYPE_WORD);
> +		sse_qe[1] = _mm_insert_epi16(sse_qe[1],
> +					     ev[3].sub_event_type << 4 |
> +						ev[3].event_type << 12,
> +					     DLB2_QE_EV_TYPE_WORD + 4);
> +#ifdef __AVX512VL__
> +		if (qm_port->use_avx512) {
> +			/*

Hi Tirthendu,

This runtime detection is not really correct, and not fully completely,
for a number of reasons:

* if doing a "default" or generic build, __AVX512VL__ flag will not be
  defined at build time, unless you explicitly add the AVX512 flags.
  Therefore, unlike other drivers, we won't have a generic build that can
  opportunistically use accelerated code paths at runtime.
* On the flip side, if we do have a build with AVX512 enabled, then AVX
  code can (and possibly will) be used by the compiler anywhere in the
  output code. Therefore, the "SSE" code paths outside this ifdefs may well
  be converted to the compiler into AVX equivalents, and as such may not run
  on a non-AVX capable machine.

To have proper runtime support, you need to build both SSE and AVX512 paths
separately with different compiler flags, and then do a runtime check to
choose between them, using a function pointer or similar.

Regards,
/Bruce

