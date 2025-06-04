Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB50C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 12:33:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C57642D80;
	Wed,  4 Jun 2025 14:33:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 725D3402D8
 for <dev@dpdk.org>; Wed,  4 Jun 2025 14:33:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749040420; x=1780576420;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1Z/BnK/vS3uHb69fI2FamDK/llqOmjK7gB3m/mEV/hs=;
 b=FI1f9NB3cVPmQmxzpjdGpnooE68FqUPpgcwhiJH616sRdfEpKWCSRM2d
 I/SnSB75E51C7632sOYCxF9U23uhUZ/U3mRbvBBvpiv/SfEYgdlhhySzP
 vl34JsE3L69aoQjNX8j2UIzcy05eF0lQwE0FIZG9uJk2rSuhpr4a7oXu+
 C5JV1ohmdeDbVrPOFpkWaDqQC53q7AJmwHRlrfDmogQNP/aL3Q+z77RyM
 aF4qRwR8L5KSgwmN+FhrzssKxHiFCYFgR/t5wmgLmfbn4Y+d/IsJtRvyL
 Z87Hvxf1ZUDavUD4JpXbcj2DNkEtWd/KC9tez7KSXb+GTchOAgi64xcwg Q==;
X-CSE-ConnectionGUID: For2XBp1SzmHQxbYZU40xg==
X-CSE-MsgGUID: qHcIDLkORjiOAxWWDoCY9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="61779383"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="61779383"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 05:32:58 -0700
X-CSE-ConnectionGUID: rnZwr3SCTRW4SrQClI9sdw==
X-CSE-MsgGUID: MGEL4RafRsqIgmjRwwqzLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="150058444"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 05:32:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 05:32:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 05:32:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 05:32:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ax7Yxj31KF4ogyDsPa9dqDbii3JX4twShgtenIs7CL9Q3n58+oqIxzScxmzVACET+t+7x4RFfBwhiPkUu8sRL2ookw4pivETuj9tqyZajMawEl7fOck/Rlr0tTrtxnnQDg0qJ2az5fPSh3t6s63rtyeKrSKf/Jt3EZBK1wbVPG95BGKuUjdWKZm9/ycHXmEuWhF0bW4o9oCLh80lfvJLSvMuEVydiCA3++mMnFhL5LdBHsMjjdzIViqHHjaUUnYCU45bl+V7cHPliffWBWer0LJPzp7nz0uKUjXpY+m7r2cfgM7yVHTCUk5Zvti7U8UlKfxzAQRyW50aRN3zLd1pJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nULP4aYlIK7EphO6vvQ8lA9fay9DtibGDxfk1RFyGMo=;
 b=i7tXtdqKTAKE87d4pTWI5bE/24AZj46cXh0aYb+fqBOrIAHPN3vHb6N7Gadfzp24DXOCJOQ1UvMVRshtfVZ0pG+iyOaeUjgBUPuDeABy4f4UR7iQKsjNURTZKRvMz6AjEE02AOQ5mfnLj+3ChF8DzEt4F4+j+VOnZci/D+/yYjpZJOqZFAztHUqzPFmtC0zp783giK2PYn40rOFbh9GZhXwrXPWKgaG+/1HW6MzNypxSBfBkQdetejKv7APmxzuvTnrUXUvGuRuN2Ku4BcnR7RIVRyKkWgtdXiQDpsql1/QHfB4Dogd9JWHwXTwWJRBLY0p7KSUX1BYXYBLhf/AG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB4946.namprd11.prod.outlook.com (2603:10b6:303:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Wed, 4 Jun
 2025 12:32:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 12:32:54 +0000
Date: Wed, 4 Jun 2025 13:32:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 23/25] net/intel: support wider x86 vectors for Rx rearm
Message-ID: <aEA88Z1N-Z2B2EB2@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <b7864d189e468484a6af5aa774ed566b2a37818f.1748612804.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b7864d189e468484a6af5aa774ed566b2a37818f.1748612804.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1c36d2-4a99-48aa-d0c0-08dda363edde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sWUxLgLFV8OcpXMVF/XrJX5E97HEeVG+ecu2RN3KhzuJccEt4aeV+aiLlmpI?=
 =?us-ascii?Q?53oLAVqwoXHbnk65Dng0q/YuCNcnZOSR8S+220UOIve5+rmDcqr321W4z+fq?=
 =?us-ascii?Q?KQgQrczniWQ3YzgejR8SjmYLFREu9++rxQkPYJEiojtS0/1rq7ySfcHXs4Ah?=
 =?us-ascii?Q?R8it/Mtw21BkFPdoEw4vVJ+PGfAK32nsDyC63xdB9rNM/ouVFLraOpeQGQ5a?=
 =?us-ascii?Q?5V8c/xoQKyvMorearYWJqokMhxCYXKjVgzI7m3Pp5E5vCH8zLxqjTBokOtkz?=
 =?us-ascii?Q?5hvnkGTStJwFJy3KIR1orHT00VHMOoZiu4nRt2BnOaSOZhaVBnXNdd2XhH5b?=
 =?us-ascii?Q?ceUl0RVOk7b/Uut2rRtqRnWR/c0Y29dqeOWEgRHXXnOJp2KlTcRHCmZlOTOh?=
 =?us-ascii?Q?ng+cEp008RoQRpvwUgAYspDQgKOAjr8v+JcLTzU6iRYVc0VfeDH5Bs4cNVWz?=
 =?us-ascii?Q?zcakRlwDWNcrgrl4mgp5FIegYl25gNYM24YjdwkV4z5625HdKEBGaWMAeLED?=
 =?us-ascii?Q?2eLqt9Mhr0FPzdDmxadtySUVdlHTLma5jrdleq1JpWQShukCy+G/X2K89vgq?=
 =?us-ascii?Q?sB+CBvp80V0BvDhpSc9tu5oeMyop8moyizKgrAgrn2uU9XQua3hsT9iv0qly?=
 =?us-ascii?Q?6oKL4c5EAaAYjdFXg87RNqPmUOlPdu64HOhv9wB78Ii51QjsBH/WhYUjH0eo?=
 =?us-ascii?Q?JtW3fQthgrHxcCq9Dz0GeYJFAKxjFPV656k0OQdRdhRcGRa6D5PmvQCXbvlO?=
 =?us-ascii?Q?prbC/AuopiZDTxzQJyb9ZXKnZUIm7DLtGwb2F2n8qTTXRfSbQIzeffKiP/kU?=
 =?us-ascii?Q?8XbTkt4yAT11DPZqhfa7ZZZW5l5StigZfIXLMIIWugm7GCFTIZv4Vo58WTyQ?=
 =?us-ascii?Q?taQrwLkLhpQnx9MSzkD9hBl0YxyKiziCJrRS4FzP+WmYIoerNr66+2n8EoIQ?=
 =?us-ascii?Q?Fo9ZFt641tJpkaLyfubjzXS+apbISIk7K02ls59q3wgUsHYZS01xIDlU0R0R?=
 =?us-ascii?Q?NLJe8lwLwiVMN0kVLmjebbgEiM7y6aBHP9EWQyg6UdoL35Tks7cRXStFwZ4f?=
 =?us-ascii?Q?zd3U2DIU2HT9qnkkvS+JWA8EpN/DojIAg31toOHm2vB5ScwkALfWVsLp+4ud?=
 =?us-ascii?Q?KXjex7N2S2t/q8x8CkfDiElIVxav2r6BXmtHJlshVmuwVnRZtG6z4gmXVhUw?=
 =?us-ascii?Q?VIrM4eju8lw4miyQQL47km9VSZYcfLjB/Hh/YfwLh9nbXijsFFEuY4akesLK?=
 =?us-ascii?Q?9CXGJyGYAQabLMd9hd277gtuxPK7WaBf5wW0JF4EH/H2da/Bx2CxzPiIFKZJ?=
 =?us-ascii?Q?r8+Ao+xE3SG8c1epiAutpCJHBE1PHpbesTe/YtNjvq3DAAodr00XfOum12w/?=
 =?us-ascii?Q?JjJqSk2sCL0Sq8D8VdNbZAZ8h1O8XyxxnECfJlzw19KOKEs85O9UDLHwDujW?=
 =?us-ascii?Q?CfkqoGAVC+I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IqnfRTx7k8EJgPcdJq8Z3P3ucZ6j/RV+qXfA2XXldgr9l9p95WZA1mm/68xe?=
 =?us-ascii?Q?Bnr4DaX4B9IQrA9/EMa1YLPXl9H5tuxjX36xWAIDfJYRNntWksHkK0tWr3no?=
 =?us-ascii?Q?sWaujS/2+iepC0rlvZp8f19ad1zSHv6RoHygzUWbQABHG5/vzo+Zz1CfcHKS?=
 =?us-ascii?Q?7UEpUVk3TGBS4bsZtjkW/Xe+L6nGTCIb7BU8oURXmFwL63co/9GVstr8vGuj?=
 =?us-ascii?Q?tfR6xF8aaEVx45G5RhSG6nalzj2UGnVx805ujPL8xFz8OZGTIJFBHrQP1Aif?=
 =?us-ascii?Q?UYsoNfV54gcoDNhSwTvMIXqYE91sEp8qPEtPisnKiLBMofV3mdNSP423y/Id?=
 =?us-ascii?Q?1YwQSCcQLU7l14oBbbjC3QsoXeta89EQyz49u/PJZhBkvrnoSxsOURXomkz8?=
 =?us-ascii?Q?oW6i9JxFPOmvTzNKKqF5rnH1jyxXr/ou4uKGeFAWaUvufx9yK81vTbExhlZe?=
 =?us-ascii?Q?/lEpdbQup2IWwWLGJkY25EDX+KPqxvUigws/cO+laiKskSZ2gyvPy+TH71Gv?=
 =?us-ascii?Q?0E3W9O0j9fJ4jZIniRt2CJUVcKnckmF97idRLjGCAArEtlxhftFb66+zsXB7?=
 =?us-ascii?Q?7LHgsv/WYdLsQjV0wEVy0nCq6b8gLwW/epal7GFMTwd881aAsxosklzu7OPx?=
 =?us-ascii?Q?rkAoFNCWPDU1PbwcjCOPRBGO4CVKf9mF9Z/JUhCUg1tMFEibIGwmEKd3pZZK?=
 =?us-ascii?Q?T8iIzhhb0xluRpWeL4mFcei/HZ14EtLyyyK/a982vzhFi+ouPlByFaJf+jak?=
 =?us-ascii?Q?ZfiPNrQPG/ICIJ3KkWfNHLZtlP2oHiw1pF27spXzAH3tciAKv2hJ4j+Nufuq?=
 =?us-ascii?Q?EmaoyvsKl/Qy/FV41Q76vZQCDguI8BM5wijVZlaGSOOSG2Avm/5xdTvQFgD6?=
 =?us-ascii?Q?xYOrtQZoqkNcHFDafkV/7AFvjrO2xStuJcoYRQG+Ii5kgUPu6ZqQzya0Bxnt?=
 =?us-ascii?Q?YCHy6w0FQ1eeHJiKdtSKUvWBTUoaw+pikWsKqyTiWfpr0zXMLRhwfjXnnvxL?=
 =?us-ascii?Q?APF+iqsIg18JrOr+RWciwPdaXiZPIhPkyqARyXNczuBr8m5ILjDasLrppx8s?=
 =?us-ascii?Q?GZPce+1nieNhBz0mA6rM+LasCVv2sWKJvsnEAdiC+Yc1L7MCh9/ws9Tfjzmt?=
 =?us-ascii?Q?PP6+QEBlKtXBdinQwdC0lYc8VZyixb0+v75A9n3/EfgVta9OmkSeTvaF7Qmt?=
 =?us-ascii?Q?RId9Ii7tiUE4doIscEK9AuOmZXww/GtLslo3i7Kt9FCfr96Ao0K6WsNC7zgi?=
 =?us-ascii?Q?TcHTWZbhXLvwIu9TMzvsAp6FlUZZT3Cp9mwpLObq1prg5FgMnfD2c4w+NvJk?=
 =?us-ascii?Q?pVSXPjWBDHmOTmg4d+qNwE1MhNT2yD3v/LLFGpuxaQLrIxjOqDHhgfqbAmLc?=
 =?us-ascii?Q?0rJkYstzrci8/bbM7tNzts0RCIDPRwtz86QTOxTB9b75RPlV66lLgHdRxrMT?=
 =?us-ascii?Q?3QM5mU3Cb6Lpo2sA4K6VDzssXm27RrsF3MfOgRS+wFlWphI8qbliuyCHuJMs?=
 =?us-ascii?Q?zfecJE0m4j8lizsRB7MhpJLD9Lh86Dipukusl6iarfkYFy71xgYyQO2Ebwsq?=
 =?us-ascii?Q?TPGtH/8K7kuJR9MT9V5PfMBneaEj7zw/rV+n74IAA3wM0P+izsNrGmXjAYAm?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1c36d2-4a99-48aa-d0c0-08dda363edde
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:32:54.7309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQniWJhykvoJzyCiSG6AxmZ5CZNAxYxmAgcrjqhKqiE6La70cstwEFnmmEjR2Jv4SG/Rmjo7kwjHi5kRT7RzXW6cqR4fOty1c+a0D8iRh7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4946
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

This function needs a comment, describing the inputs and outputs.
From my reading, the input is 16bytes of mbuf header starting from the
buffer address, with second 8 bytes being the iova, if we have separate
iova field.
Output is 16B of descriptor to write.

/Bruce
