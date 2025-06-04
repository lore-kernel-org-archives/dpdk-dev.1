Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7D4C5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 14:59:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71DB342D66;
	Wed,  4 Jun 2025 16:59:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 421A8402B1
 for <dev@dpdk.org>; Wed,  4 Jun 2025 16:59:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749049161; x=1780585161;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Hoa8dwp87w//oaoi0IPNu1u55396KKc8HKhSwfKJntI=;
 b=Comm7Cd1SyHLobi0o18+blXZsaMQVEEehs7NHcy0glOqgYhAmtXE7mhL
 dpoM1a5UQzoGdBmd+5l2Cj3pTipEhNb6Ryo9iVVO2YYgZ3jOSHeIKXwF1
 Iuop4cgNMs1NpbcgqgMQOfr3+Hpj491CLDOOytb+Q67nRcuFJf7MSm5/e
 w1Wm3RUHT9XPO4ArkfnMM3lj5Ql4gQjD1o0+3KuztKaoCcv+wj8yxo0ah
 fHm/em4FVJmAgtw5pN+quPLGtyup+NbUABpXIpNPKX5o7cUMbY/iH2wXY
 5VXuFacv41DwhcwBjpiASzg01NFdBtAjypD8+u9Aek8NwE4QYsf7+Zb6A g==;
X-CSE-ConnectionGUID: 9LqmaIs/S3eYxe6132/6Wg==
X-CSE-MsgGUID: VYR1q03VQtmZ8ohxkHw39g==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="61798893"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="61798893"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 07:59:19 -0700
X-CSE-ConnectionGUID: 4zAaiysgRIC5CmzIjqFbDA==
X-CSE-MsgGUID: 3l1j9zVWTqWZY2cZBTVk3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="145175456"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 07:59:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 07:59:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 07:59:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.49)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 07:59:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7jjs1BB8OG9ie/QnDj1endQsvImtVyjMkrz983jEZhTlWdAcgtF3mko751nFgztfVWktYfmAwVvsHDmsmd1CsjmwFnPKTLWF+ajwPoFbUIdAGUNjIZno9gqkdUnJSyYghE+ihQ5J6pqX47xCFUIDv+RlH1qb1M9xD6WyXzleAafm3R2LkB+jUfFl5W+NxEn4tNTpzZwb3u+mor513p2X7gQxIKfet8Nhxeb6efloOr1FmI7TX3/1DP82vgjTGlWcOJseACKP/bij3znsaHekv4WS5Uq/G9w8unw72kw2mANLCbs1g22ucn5iEyoc9qNiJ7+3bd9mrECpgxmtMNGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCvrgoQ6F2+T9FrVDHBptrzeji3ef861ZnIUVCRFc3Q=;
 b=uwknIT9IUml/IYxn8pUEb9y39rKlRCrEtuYXkY3dtXxXZDjr2eMrLh+iURlAK0A8lO8szjaDqAqrXAsKUMp9WpAKlsdMc0z4ADXs+KnG0J5VEBLWCEbfhNM2izbvmkB4wnanEUyhv+bXAI26c1F+X1Gao1uqIiEmss2H8UJfrrVVheSlNiO0r0c3ZdCdDMWKqyPUuY+J0moPMBx79iXf2jAfPYbd6MEFNF7Z72i3RJpTqMkZiWPSx6SFKykmHIAaRexPrerwAsgmBDYY6cShkg5hc/daNZo2sdGYRssFEbLo9mqLMDbVbRvW8f+YlV5ktbCNawLndbBfSJfAg6Au3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB5172.namprd11.prod.outlook.com (2603:10b6:303:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 14:59:14 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 14:59:14 +0000
Date: Wed, 4 Jun 2025 15:59:09 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 23/25] net/intel: support wider x86 vectors for Rx rearm
Message-ID: <aEBfPb8Imy6nemXw@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <b7864d189e468484a6af5aa774ed566b2a37818f.1748612804.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b7864d189e468484a6af5aa774ed566b2a37818f.1748612804.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DBBPR09CA0033.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: 2364a235-5123-4691-b7d1-08dda3785ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?64AHgTLZbNv12EAskTJFiL6EZx3f+X424L2ocBmPnk46OXEHlNzqLcs+BK71?=
 =?us-ascii?Q?Md3Ur2/bKPredNiNCJ/bRZYf9GyWH99MFluoslOZnvfVSj9hYEezUrJASfrl?=
 =?us-ascii?Q?rS5HFwWgpLPF7RUoE83lndTnVZnQzFHkeghge9u88LUhwhJ/RCA0GrcWDF4p?=
 =?us-ascii?Q?FJypdeHc7LrGGUO033UKzjzmdG7XulJzVQBRcADkcHi4N9B0uGdawz7Um9zT?=
 =?us-ascii?Q?cdpF2P/cpIgUssn2kL2pHOVMEE4kJAHeYg5RgAWSq1M6wgRcJtjUyFVaffJU?=
 =?us-ascii?Q?YdUALGoFBvJROP577+UNg1OIzzJkCwT6KF4fmpQDudDkN1soQ4/lG8eQcCYT?=
 =?us-ascii?Q?zTfSJU5gywF8FOOxjpc7aImyIYGgbrgcvpzp7MhtSCBMkUbOFkgNTyrPWIjb?=
 =?us-ascii?Q?LjCrcCnbEc7ifyCg8/w9s+DiM88TzNVzyj/tzrBmA5CiLKWj3Q6YMY+HFe0R?=
 =?us-ascii?Q?p29Rzas90hD7ZBq5UrMO7gjBE1rRmJ8hKVlvhczmlPC6y0vrlYHe+qTAfW/8?=
 =?us-ascii?Q?mme8YeaWCGhDtduZvqp4odTdZYZSCIVQxfUfVnxqxK6F/2pA7kK6cvVhEcuI?=
 =?us-ascii?Q?V/nUs+JKh5J9dldtfYmCYulNGtAqlewXfVlgvYlQHqmlEO9LHEGRY3THqMTG?=
 =?us-ascii?Q?YFWdHokFoAiNIZgdDOxAG63oV8CSTqcDJhcVgVRM/ok8jLSRpl0VV6sxfhyZ?=
 =?us-ascii?Q?E07bbHPSEo2uWLvDIaBdfC8i5m4JcR7CKpnwv6bHtuvUhFi1krHSenP/ebvj?=
 =?us-ascii?Q?QA61LxYAI4GdSfi0MpARGIwq/JYICKf47KSrRCWxH1NIaKDaooyC58wgJDq8?=
 =?us-ascii?Q?GmsW+ldDMKbEWaAbGoMF1e9ZHhpc73E933M4vPezwUGfgI2QT/muy6r6DxZi?=
 =?us-ascii?Q?yPEi+de3atUleQTMgOj9wPks2KNnp95mjUwnfFpayUywHD/XMQCCyCGFCCut?=
 =?us-ascii?Q?q1X6vdkVx4aMZ/nSQCXVKAxCGbkht3ufTbuxq7rhdUNVPxSvJ+sppDMRIFjr?=
 =?us-ascii?Q?tvIy+vPnEelXugNc+DJFIG0xVU03EkDxP+T4wut8UlmSNbOWvEnP63PqvLgk?=
 =?us-ascii?Q?A/jSKQ+x9DMVUMtdtaI3uSpF0PewVCYBnZwowY856NkoQ42WUt+gJCwnr5vg?=
 =?us-ascii?Q?W7jZ3TTkJVECPN1PdH7t0i4p5OydFNYFZy9Gdy7kq8p1dh27XFKApsNCdAlR?=
 =?us-ascii?Q?J5jfJbRa63WzCetwe25U1BWyJ/eR4kFj/BbE2wMGB40rnhoBEBzU2RJJhDL2?=
 =?us-ascii?Q?GW5nBUCjifjD4vqL1OsUVgtzo4osKLH5yDsaX4KKRQbLnzZPMTyCvjID1Zkc?=
 =?us-ascii?Q?Y0Ox6vArFZjQncKVkVzHRk+4SFNfGRsQp7/NodGulzp2uRr2NRSpOGnqPNit?=
 =?us-ascii?Q?7c6XRTLV1zCYYhihiWj8x34d3ULk/O4/Ra2ChAUxKyp2ESoy2V/wQtAeoZEt?=
 =?us-ascii?Q?NGvsq1q3RVc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?btzB89kWiSq/YbOUhZMUwVADMy/pSN4bwCiSTog1UsITwvVYYCAxLK36c4Zg?=
 =?us-ascii?Q?FVDXd18My+2ROoIM10KpOjybNqyUH5MgX5ezzfMAngM7i4rbh4mgVE4POvHS?=
 =?us-ascii?Q?s5jUrbbn1IpOhxSmFUxcoUemfO0JExq1XBvCoczuM+ufrlno3WWWU+i+Stbp?=
 =?us-ascii?Q?afVp6zHbCau+Z48t42VLsW5fgOwFlP2jQe/NeZjcsaAZgml7RKOIDgiqzOV5?=
 =?us-ascii?Q?45OLgbKQEQWTvj7R0PZcoFWLzIcytbL2UBRvv3BbQg3wX7Ctt/5g+KxK3Szw?=
 =?us-ascii?Q?ez4w5Af6eyh9+rGLyXI8UH2nf3+lmRBi7WcmSiUAibKEVaethTviGv6xptXP?=
 =?us-ascii?Q?u/K1AoSIQ/CygrcJ5pUMFll4STP7pf3DjmOYqCqvSdnm1ZFnd6xswlI9WVQ8?=
 =?us-ascii?Q?VWTiNe0/qv+ani/bemKwbgTFXvwcp6h5MxIIbR+gtdyTsz+FCzeuct9UXdS8?=
 =?us-ascii?Q?7o3Oul0sDB+krrxje+3rDN1Jh8yPdZb8rpLttHcV+eFimDcr2tCWAmtZAS3N?=
 =?us-ascii?Q?G92dV7v1VQ6e1oZ+SM4NoUMt8JEzievXyxJXoG7nLL+9kePUSJXd7GYcaE/7?=
 =?us-ascii?Q?RYAk/qdlOEGqWn2ZKqf+NLNDKuqSd3gxPm56qxukbmHIK+G/Yni5UkAVkoTm?=
 =?us-ascii?Q?ftki0uMukb75NN0BazOBJAfSu0ZBfC/auSwgV3jCIF3GUQ7eanarn7UxRECQ?=
 =?us-ascii?Q?JMsErbD1NzgICZCwcWF53Yad52PMX16be8t8SRIzPXoE1S+rH1p9bO7S9zXi?=
 =?us-ascii?Q?ZzN/XXeF6J8bNWswKeaTMitQrHkPs9br+cbQJkiASRLsH9UlbCfNobO0dRHr?=
 =?us-ascii?Q?lzM/Cf1Es5YIC8YKcCoFleMlUMgW7QBak7pHAKCGax+pyyOQCtSgBGxmeahA?=
 =?us-ascii?Q?wCwTBrXc2WzC3VAU8JKN2ez432l8o0BPzSrFJyg/HmUlHH42xj89bGjyG1Vy?=
 =?us-ascii?Q?bEELTr9TCH55VPDDPBuZs0LGyO4qpLatECQJc+I8GVxVsWGrQe36RBKwZ6Cb?=
 =?us-ascii?Q?D4wtNQ83yDJOaQj1mHQ9tSmhscCXtmqYABv2jZCQ6DuiaCZSIfc2CnaNiB9C?=
 =?us-ascii?Q?z3onalbI8MOS4uxTOuqysLt3hnGCoILIk/yzXWJNLFiuUMGbsnWb8r44c0Qs?=
 =?us-ascii?Q?MWJCP47YiEETUpaKzzv6G4tLyV7/MWpV8mQP4cRsut37bzR6LURb4DhXscHU?=
 =?us-ascii?Q?HB4m76ifAbFCRY87te6NkrVLFEc7hBH0v0VcdQBdMAXHb1oNm8b4B8D4tNQP?=
 =?us-ascii?Q?S23NmUMTiq1igTf+CmWZAhJrOVsOIHX3pDs6kRpz+T2YuI/pZnT/lKeLRChC?=
 =?us-ascii?Q?+0oa1LVCK/Ms3Xj5CPegth3GQxrDNixpS+rQDXVal4C/ng2fKkNdgpXeB7LL?=
 =?us-ascii?Q?g+OVmc8oKocTgTWZhF1aLQZL/DKHiQrs8b5BFM6qWlLgrgNAdD6B4GL273QY?=
 =?us-ascii?Q?UlmnxSr1SlSBh+KUFy8PdDipr9eYvkA43wCZsC8p1kxUyIA3rqd+Zqd6GBl7?=
 =?us-ascii?Q?gDleqzLBKeiZ05wnPwU79R2QOKlq5aXofdnTiOsGKLjCAFCr029QSQaB3ga5?=
 =?us-ascii?Q?m4+lyennJ9pju4cUNImiv+i/KCqDpCi0Ymzb9DdEo4nwcdyevW1L1CYgrbxh?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2364a235-5123-4691-b7d1-08dda3785ed9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 14:59:14.2658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZEPWbjD7CVkO/KIDodPJSA4GVDfMrTVXt6A766w3o/pbF/XLP8GrY9BO5nMxa2dVzEc5j4nI2FBpRtI3YUM9naEshfcQWNRFm96KHvNzxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5172
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

On Fri, May 30, 2025 at 02:57:19PM +0100, Anatoly Burakov wrote:
> Currently, for 32-byte descriptor format, only SSE instruction set is
> supported. Add implementation for AVX2 and AVX512 instruction sets. Since
> we are using Rx descriptor definitions from common code, we can just use
> the generic descriptor definition, as we only ever write the first 16 bytes
> of it, and the layout is always the same for that part.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 

Like the idea. Feedback inline below.

/Bruce

> Notes:
>     v3 -> v4:
>     - Use the common descriptor format instead of constant propagation
>     - Syntax and whitespace cleanups
> 
>  drivers/net/intel/common/rx_vec_x86.h | 339 ++++++++++++++------------
>  1 file changed, 183 insertions(+), 156 deletions(-)
> 
> diff --git a/drivers/net/intel/common/rx_vec_x86.h b/drivers/net/intel/common/rx_vec_x86.h
> index 7c57016df7..43f7c59449 100644
> --- a/drivers/net/intel/common/rx_vec_x86.h
> +++ b/drivers/net/intel/common/rx_vec_x86.h
> @@ -43,206 +43,244 @@ _ci_rxq_rearm_get_bufs(struct ci_rx_queue *rxq)
>  	return 0;
>  }
>  
> -/*
> - * SSE code path can handle both 16-byte and 32-byte descriptors with one code
> - * path, as we only ever write 16 bytes at a time.
> - */
> -static __rte_always_inline void
> -_ci_rxq_rearm_sse(struct ci_rx_queue *rxq)
> +static __rte_always_inline __m128i
> +_ci_rxq_rearm_desc_sse(const __m128i vaddr)
>  {
>  	const __m128i hdroom = _mm_set1_epi64x(RTE_PKTMBUF_HEADROOM);
>  	const __m128i zero = _mm_setzero_si128();
> +
> +	/* add headroom to address values */
> +	__m128i reg = _mm_add_epi64(vaddr, hdroom);
> +
> +#if RTE_IOVA_IN_MBUF
> +	/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
> +	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
> +			 offsetof(struct rte_mbuf, buf_addr) + 8);
> +	/* move IOVA to Packet Buffer Address, erase Header Buffer Address */
> +	reg = _mm_unpackhi_epi64(reg, zero);
> +#else
> +	/* erase Header Buffer Address */
> +	reg = _mm_unpacklo_epi64(reg, zero);
> +#endif
> +	return reg;
> +}
> +
> +static __rte_always_inline void
> +_ci_rxq_rearm_sse(struct ci_rx_queue *rxq)
> +{
>  	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
>  	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
> +	/* SSE writes 16-bytes regardless of descriptor size */
> +	const uint8_t desc_per_reg = 1;
> +	const uint8_t desc_per_iter = desc_per_reg * 2;
>  	volatile union ci_rx_desc *rxdp;
>  	int i;
>  
>  	rxdp = &rxq->rx_ring[rxq->rxrearm_start];
>  
>  	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
> -	for (i = 0; i < rearm_thresh; i += 2, rxp += 2, rxdp += 2) {
> +	for (i = 0; i < rearm_thresh;
> +			i += desc_per_iter,
> +			rxp += desc_per_iter,
> +			rxdp += desc_per_iter) {
>  		struct rte_mbuf *mb0 = rxp[0].mbuf;
>  		struct rte_mbuf *mb1 = rxp[1].mbuf;
>  
> -#if RTE_IOVA_IN_MBUF
> -		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
> -		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
> -				offsetof(struct rte_mbuf, buf_addr) + 8);
> -#endif
> -		__m128i addr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
> -		__m128i addr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
> +		const __m128i vaddr0 = _mm_loadu_si128((const __m128i *)&mb0->buf_addr);
> +		const __m128i vaddr1 = _mm_loadu_si128((const __m128i *)&mb1->buf_addr);
>  
> -		/* add headroom to address values */
> -		addr0 = _mm_add_epi64(addr0, hdroom);
> -		addr1 = _mm_add_epi64(addr1, hdroom);
> +		const __m128i reg0 = _ci_rxq_rearm_desc_sse(vaddr0);
> +		const __m128i reg1 = _ci_rxq_rearm_desc_sse(vaddr1);
> 
> -#if RTE_IOVA_IN_MBUF
> -		/* move IOVA to Packet Buffer Address, erase Header Buffer Address */
> -		addr0 = _mm_unpackhi_epi64(addr0, zero);
> -		addr0 = _mm_unpackhi_epi64(addr1, zero);
> -#else
> -		/* erase Header Buffer Address */
> -		addr0 = _mm_unpacklo_epi64(addr0, zero);
> -		addr1 = _mm_unpacklo_epi64(addr1, zero);
> -#endif
> -
> -		/* flush desc with pa dma_addr */
> -		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[0]), addr0);
> -		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[1]), addr1);
> +		/* flush descriptors */
> +		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[0]), reg0);
> +		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[1]), reg1);
>  	}
>  }
>  
> -#ifdef RTE_NET_INTEL_USE_16BYTE_DESC
>  #ifdef __AVX2__
> -/* AVX2 version for 16-byte descriptors, handles 4 buffers at a time */
> -static __rte_always_inline void
> -_ci_rxq_rearm_avx2(struct ci_rx_queue *rxq)
> +static __rte_always_inline __m256i
> +_ci_rxq_rearm_desc_avx2(const __m128i vaddr0, const __m128i vaddr1)
>  {
> -	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
> -	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
> -	const __m256i hdroom = _mm256_set1_epi64x(RTE_PKTMBUF_HEADROOM);
> +	const __m256i hdr_room = _mm256_set1_epi64x(RTE_PKTMBUF_HEADROOM);
>  	const __m256i zero = _mm256_setzero_si256();
> +
> +	/* merge by casting 0 to 256-bit and inserting 1 into the high lanes */
> +	__m256i reg = _mm256_inserti128_si256(_mm256_castsi128_si256(vaddr0), vaddr1, 1);
> +
> +	/* add headroom to address values */
> +	reg = _mm256_add_epi64(reg, hdr_room);
> +
> +#if RTE_IOVA_IN_MBUF
> +	/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
> +	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
> +			offsetof(struct rte_mbuf, buf_addr) + 8);
> +	/* extract IOVA addr into Packet Buffer Address, erase Header Buffer Address */
> +	reg = _mm256_unpackhi_epi64(reg, zero);
> +#else
> +	/* erase Header Buffer Address */
> +	reg = _mm256_unpacklo_epi64(reg, zero);
> +#endif
> +	return reg;
> +}
> +
> +static __rte_always_inline void
> +_ci_rxq_rearm_avx2(struct ci_rx_queue *rxq)
> +{
> +	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
> +	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
> +	/* how many descriptors can fit into a register */
> +	const uint8_t desc_per_reg = sizeof(__m256i) / sizeof(union ci_rx_desc);
> +	/* how many descriptors can fit into one loop iteration */
> +	const uint8_t desc_per_iter = desc_per_reg * 2;
>  	volatile union ci_rx_desc *rxdp;
>  	int i;
>  
> -	RTE_BUILD_BUG_ON(sizeof(union ci_rx_desc) != 16);
> -
>  	rxdp = &rxq->rx_ring[rxq->rxrearm_start];
>  
> -	/* Initialize the mbufs in vector, process 4 mbufs in one loop */
> -	for (i = 0; i < rearm_thresh; i += 4, rxp += 4, rxdp += 4) {
> -		struct rte_mbuf *mb0 = rxp[0].mbuf;
> -		struct rte_mbuf *mb1 = rxp[1].mbuf;
> -		struct rte_mbuf *mb2 = rxp[2].mbuf;
> -		struct rte_mbuf *mb3 = rxp[3].mbuf;
> +	/* Initialize the mbufs in vector, process 2 or 4 mbufs in one loop */
> +	for (i = 0; i < rearm_thresh;
> +			i += desc_per_iter,
> +			rxp += desc_per_iter,
> +			rxdp += desc_per_iter) {
> +		__m256i reg0, reg1;
>  
> -#if RTE_IOVA_IN_MBUF
> -		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
> -		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
> -				offsetof(struct rte_mbuf, buf_addr) + 8);
> -#endif
> -		const __m128i vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
> -		const __m128i vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
> -		const __m128i vaddr2 = _mm_loadu_si128((__m128i *)&mb2->buf_addr);
> -		const __m128i vaddr3 = _mm_loadu_si128((__m128i *)&mb3->buf_addr);
> +		if (desc_per_iter == 2) {
> +			/* 16 byte descriptor, 16 byte zero, times two */
> +			const __m128i zero = _mm_setzero_si128();
> +			const struct rte_mbuf *mb0 = rxp[0].mbuf;
> +			const struct rte_mbuf *mb1 = rxp[1].mbuf;
>  
> -		/**
> -		 * merge 0 & 1, by casting 0 to 256-bit and inserting 1
> -		 * into the high lanes. Similarly for 2 & 3
> -		 */
> -		const __m256i vaddr0_256 = _mm256_castsi128_si256(vaddr0);
> -		const __m256i vaddr2_256 = _mm256_castsi128_si256(vaddr2);
> +			const __m128i vaddr0 = _mm_loadu_si128((const __m128i *)&mb0->buf_addr);
> +			const __m128i vaddr1 = _mm_loadu_si128((const __m128i *)&mb1->buf_addr);

Minor nit, but do we need to use unaligned loads here? The mbuf is marked
as cache-aligned, and buf_addr is the first field in it.

>  
> -		__m256i addr0_1 = _mm256_inserti128_si256(vaddr0_256, vaddr1, 1);
> -		__m256i addr2_3 = _mm256_inserti128_si256(vaddr2_256, vaddr3, 1);
> +			reg0 = _ci_rxq_rearm_desc_avx2(vaddr0, zero);
> +			reg1 = _ci_rxq_rearm_desc_avx2(vaddr1, zero);

The compiler may optimize this away, but rather than calling this function
with a zero register, we can save the call to insert the zero into the high
register half by just using the SSE/AVX-128 function, and casting the
result (which should be a no-op).

> +		} else {
> +			/* 16 byte descriptor times four */
> +			const struct rte_mbuf *mb0 = rxp[0].mbuf;
> +			const struct rte_mbuf *mb1 = rxp[1].mbuf;
> +			const struct rte_mbuf *mb2 = rxp[2].mbuf;
> +			const struct rte_mbuf *mb3 = rxp[3].mbuf;
>  
> -		/* add headroom to address values */
> -		addr0_1 = _mm256_add_epi64(addr0_1, hdroom);
> -		addr0_1 = _mm256_add_epi64(addr0_1, hdroom);
> +			const __m128i vaddr0 = _mm_loadu_si128((const __m128i *)&mb0->buf_addr);
> +			const __m128i vaddr1 = _mm_loadu_si128((const __m128i *)&mb1->buf_addr);
> +			const __m128i vaddr2 = _mm_loadu_si128((const __m128i *)&mb2->buf_addr);
> +			const __m128i vaddr3 = _mm_loadu_si128((const __m128i *)&mb3->buf_addr);
>  
> -#if RTE_IOVA_IN_MBUF
> -		/* extract IOVA addr into Packet Buffer Address, erase Header Buffer Address */
> -		addr0_1 = _mm256_unpackhi_epi64(addr0_1, zero);
> -		addr2_3 = _mm256_unpackhi_epi64(addr2_3, zero);
> -#else
> -		/* erase Header Buffer Address */
> -		addr0_1 = _mm256_unpacklo_epi64(addr0_1, zero);
> -		addr2_3 = _mm256_unpacklo_epi64(addr2_3, zero);
> -#endif
> +			reg0 = _ci_rxq_rearm_desc_avx2(vaddr0, vaddr1);
> +			reg1 = _ci_rxq_rearm_desc_avx2(vaddr2, vaddr3);
> +		}
>  
> -		/* flush desc with pa dma_addr */
> -		_mm256_store_si256(RTE_CAST_PTR(__m256i *, &rxdp[0]), addr0_1);
> -		_mm256_store_si256(RTE_CAST_PTR(__m256i *, &rxdp[2]), addr2_3);
> +		/* flush descriptors */
> +		_mm256_store_si256(RTE_CAST_PTR(__m256i *, &rxdp[0]), reg0);
> +		_mm256_store_si256(RTE_CAST_PTR(__m256i *, &rxdp[2]), reg1);

This should be rxdp[desc_per_reg], not rxdp[2].

>  	}
>  }
>  #endif /* __AVX2__ */
>  
>  #ifdef __AVX512VL__
> -/* AVX512 version for 16-byte descriptors, handles 8 buffers at a time */
> -static __rte_always_inline void
> -_ci_rxq_rearm_avx512(struct ci_rx_queue *rxq)
> +static __rte_always_inline __m512i
> +_ci_rxq_rearm_desc_avx512(const __m128i vaddr0, const __m128i vaddr1,
> +		const __m128i vaddr2, const __m128i vaddr3)
>  {
> -	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
> -	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
> -	const __m512i hdroom = _mm512_set1_epi64(RTE_PKTMBUF_HEADROOM);
>  	const __m512i zero = _mm512_setzero_si512();
> +	const __m512i hdroom = _mm512_set1_epi64(RTE_PKTMBUF_HEADROOM);
> +
> +	/**
> +	 * merge 0 & 1, by casting 0 to 256-bit and inserting 1 into the high
> +	 * lanes. Similarly for 2 & 3.
> +	 */
> +	const __m256i vaddr0_1 = _mm256_inserti128_si256(_mm256_castsi128_si256(vaddr0), vaddr1, 1);
> +	const __m256i vaddr2_3 = _mm256_inserti128_si256(_mm256_castsi128_si256(vaddr2), vaddr3, 1);
> +	/*
> +	 * merge 0+1 & 2+3, by casting 0+1 to 512-bit and inserting 2+3 into the
> +	 * high lanes.
> +	 */
> +	__m512i reg = _mm512_inserti64x4(_mm512_castsi256_si512(vaddr0_1), vaddr2_3, 1);
> +
> +	/* add headroom to address values */
> +	reg = _mm512_add_epi64(reg, hdroom);
> +
> +#if RTE_IOVA_IN_MBUF
> +	/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
> +	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
> +			offsetof(struct rte_mbuf, buf_addr) + 8);
> +	/* extract IOVA addr into Packet Buffer Address, erase Header Buffer Address */
> +	reg = _mm512_unpackhi_epi64(reg, zero);
> +#else
> +	/* erase Header Buffer Address */
> +	reg = _mm512_unpacklo_epi64(reg, zero);
> +#endif
> +	return reg;
> +}
> +
> +static __rte_always_inline void
> +_ci_rxq_rearm_avx512(struct ci_rx_queue *rxq)
> +{
> +	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
> +	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
> +	/* how many descriptors can fit into a register */
> +	const uint8_t desc_per_reg = sizeof(__m512i) / sizeof(union ci_rx_desc);
> +	/* how many descriptors can fit into one loop iteration */
> +	const uint8_t desc_per_iter = desc_per_reg * 2;
>  	volatile union ci_rx_desc *rxdp;
>  	int i;
>  
> -	RTE_BUILD_BUG_ON(sizeof(union ci_rx_desc) != 16);
> -
>  	rxdp = &rxq->rx_ring[rxq->rxrearm_start];
>  
> -	/* Initialize the mbufs in vector, process 8 mbufs in one loop */
> -	for (i = 0; i < rearm_thresh; i += 8, rxp += 8, rxdp += 8) {
> -		struct rte_mbuf *mb0 = rxp[0].mbuf;
> -		struct rte_mbuf *mb1 = rxp[1].mbuf;
> -		struct rte_mbuf *mb2 = rxp[2].mbuf;
> -		struct rte_mbuf *mb3 = rxp[3].mbuf;
> -		struct rte_mbuf *mb4 = rxp[4].mbuf;
> -		struct rte_mbuf *mb5 = rxp[5].mbuf;
> -		struct rte_mbuf *mb6 = rxp[6].mbuf;
> -		struct rte_mbuf *mb7 = rxp[7].mbuf;
> +	/* Initialize the mbufs in vector, process 4 or 8 mbufs in one loop */
> +	for (i = 0; i < rearm_thresh;
> +			i += desc_per_iter,
> +			rxp += desc_per_iter,
> +			rxdp += desc_per_iter) {
> +		__m512i reg0, reg1;
>  
> -#if RTE_IOVA_IN_MBUF
> -		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
> -		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
> -				offsetof(struct rte_mbuf, buf_addr) + 8);
> -#endif
> -		const __m128i vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
> -		const __m128i vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
> -		const __m128i vaddr2 = _mm_loadu_si128((__m128i *)&mb2->buf_addr);
> -		const __m128i vaddr3 = _mm_loadu_si128((__m128i *)&mb3->buf_addr);
> -		const __m128i vaddr4 = _mm_loadu_si128((__m128i *)&mb4->buf_addr);
> -		const __m128i vaddr5 = _mm_loadu_si128((__m128i *)&mb5->buf_addr);
> -		const __m128i vaddr6 = _mm_loadu_si128((__m128i *)&mb6->buf_addr);
> -		const __m128i vaddr7 = _mm_loadu_si128((__m128i *)&mb7->buf_addr);
> +		if (desc_per_iter == 4) {
> +			/* 16-byte descriptor, 16 byte zero, times four */
> +			const __m128i zero = _mm_setzero_si128();
> +			const struct rte_mbuf *mb0 = rxp[0].mbuf;
> +			const struct rte_mbuf *mb1 = rxp[1].mbuf;
> +			const struct rte_mbuf *mb2 = rxp[2].mbuf;
> +			const struct rte_mbuf *mb3 = rxp[3].mbuf;
>  
> -		/**
> -		 * merge 0 & 1, by casting 0 to 256-bit and inserting 1
> -		 * into the high lanes. Similarly for 2 & 3, and so on.
> -		 */
> -		const __m256i addr0_256 = _mm256_castsi128_si256(vaddr0);
> -		const __m256i addr2_256 = _mm256_castsi128_si256(vaddr2);
> -		const __m256i addr4_256 = _mm256_castsi128_si256(vaddr4);
> -		const __m256i addr6_256 = _mm256_castsi128_si256(vaddr6);
> +			const __m128i vaddr0 = _mm_loadu_si128((const __m128i *)&mb0->buf_addr);
> +			const __m128i vaddr1 = _mm_loadu_si128((const __m128i *)&mb1->buf_addr);
> +			const __m128i vaddr2 = _mm_loadu_si128((const __m128i *)&mb2->buf_addr);
> +			const __m128i vaddr3 = _mm_loadu_si128((const __m128i *)&mb3->buf_addr);
>  
> -		const __m256i addr0_1 = _mm256_inserti128_si256(addr0_256, vaddr1, 1);
> -		const __m256i addr2_3 = _mm256_inserti128_si256(addr2_256, vaddr3, 1);
> -		const __m256i addr4_5 = _mm256_inserti128_si256(addr4_256, vaddr5, 1);
> -		const __m256i addr6_7 = _mm256_inserti128_si256(addr6_256, vaddr7, 1);
> +			reg0 = _ci_rxq_rearm_desc_avx512(vaddr0, zero, vaddr1, zero);
> +			reg1 = _ci_rxq_rearm_desc_avx512(vaddr2, zero, vaddr3, zero);

I can't help but thinking we can probably do a little better than this
merging in zeros using AVX-512 mask registers, e.g. using
 _mm256_maskz_broadcastq_epi64()  intrinsic, but it will be ok for now! :-)

> +		} else {
> +			/* 16-byte descriptor times eight */
> +			const struct rte_mbuf *mb0 = rxp[0].mbuf;
> +			const struct rte_mbuf *mb1 = rxp[1].mbuf;
> +			const struct rte_mbuf *mb2 = rxp[2].mbuf;
> +			const struct rte_mbuf *mb3 = rxp[3].mbuf;
> +			const struct rte_mbuf *mb4 = rxp[4].mbuf;
> +			const struct rte_mbuf *mb5 = rxp[5].mbuf;
> +			const struct rte_mbuf *mb6 = rxp[6].mbuf;
> +			const struct rte_mbuf *mb7 = rxp[7].mbuf;
>  
> -		/**
> -		 * merge 0_1 & 2_3, by casting 0_1 to 512-bit and inserting 2_3
> -		 * into the high lanes. Similarly for 4_5 & 6_7, and so on.
> -		 */
> -		const __m512i addr0_1_512 = _mm512_castsi256_si512(addr0_1);
> -		const __m512i addr4_5_512 = _mm512_castsi256_si512(addr4_5);
> +			const __m128i vaddr0 = _mm_loadu_si128((const __m128i *)&mb0->buf_addr);
> +			const __m128i vaddr1 = _mm_loadu_si128((const __m128i *)&mb1->buf_addr);
> +			const __m128i vaddr2 = _mm_loadu_si128((const __m128i *)&mb2->buf_addr);
> +			const __m128i vaddr3 = _mm_loadu_si128((const __m128i *)&mb3->buf_addr);
> +			const __m128i vaddr4 = _mm_loadu_si128((const __m128i *)&mb4->buf_addr);
> +			const __m128i vaddr5 = _mm_loadu_si128((const __m128i *)&mb5->buf_addr);
> +			const __m128i vaddr6 = _mm_loadu_si128((const __m128i *)&mb6->buf_addr);
> +			const __m128i vaddr7 = _mm_loadu_si128((const __m128i *)&mb7->buf_addr);
>  
> -		__m512i addr0_3 = _mm512_inserti64x4(addr0_1_512, addr2_3, 1);
> -		__m512i addr4_7 = _mm512_inserti64x4(addr4_5_512, addr6_7, 1);
> -
> -		/* add headroom to address values */
> -		addr0_3 = _mm512_add_epi64(addr0_3, hdroom);
> -		addr4_7 = _mm512_add_epi64(addr4_7, hdroom);
> -
> -#if RTE_IOVA_IN_MBUF
> -		/* extract IOVA addr into Packet Buffer Address, erase Header Buffer Address */
> -		addr0_3 = _mm512_unpackhi_epi64(addr0_3, zero);
> -		addr4_7 = _mm512_unpackhi_epi64(addr4_7, zero);
> -#else
> -		/* erase Header Buffer Address */
> -		addr0_3 = _mm512_unpacklo_epi64(addr0_3, zero);
> -		addr4_7 = _mm512_unpacklo_epi64(addr4_7, zero);
> -#endif
> +			reg0 = _ci_rxq_rearm_desc_avx512(vaddr0, vaddr1, vaddr2, vaddr3);
> +			reg1 = _ci_rxq_rearm_desc_avx512(vaddr4, vaddr5, vaddr6, vaddr7);

To shorten the code (and this applies elsewhere too), we can remove the
vaddr* temporary variables and just do the loads implicitly in the function
calls, e.g.

reg0 = _ci_rxq_rearm_desc_avx512((const __m128i *)&mb0->buf_addr,
				(const __m128i *)&mb1->buf_addr,
				(const __m128i *)&mb2->buf_addr,
				(const __m128i *)&mb3->buf_addr);

> +		}
>  
>  		/* flush desc with pa dma_addr */
> -		_mm512_store_si512(RTE_CAST_PTR(__m512i *, &rxdp[0]), addr0_3);
> -		_mm512_store_si512(RTE_CAST_PTR(__m512i *, &rxdp[4]), addr4_7);
> +		_mm512_store_si512(RTE_CAST_PTR(__m512i *, &rxdp[0]), reg0);
> +		_mm512_store_si512(RTE_CAST_PTR(__m512i *, &rxdp[4]), reg1);

Again, the "4" needs to be adjusted based on desc size.

>  	}
>  }
>  #endif /* __AVX512VL__ */
> -#endif /* RTE_NET_INTEL_USE_16BYTE_DESC */
>  
>  static __rte_always_inline void
>  ci_rxq_rearm(struct ci_rx_queue *rxq, const enum ci_rx_vec_level vec_level)
> @@ -254,7 +292,6 @@ ci_rxq_rearm(struct ci_rx_queue *rxq, const enum ci_rx_vec_level vec_level)
>  	if (_ci_rxq_rearm_get_bufs(rxq) < 0)
>  		return;
>  

<snip>
