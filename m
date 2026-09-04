Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032FCC79F85
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 11:25:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFF7D42F35;
	Fri,  4 Sep 2026 13:25:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id CA1AF42F23
 for <dev@dpdk.org>; Fri,  4 Sep 2026 13:25:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788521136; x=1820057136;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=VDFW8l9u6gaFqDYsBEsmEnP3FDzvZ/fGhao5mZM5GYA=;
 b=ROB5oyZhZg28t54EeNYZ3d+i2Df3yu//HMyn4CL0b94lSyILeBzEe6Vm
 BD7lbwRU0zoSFJolPtuuEk5v/BNjA+3rvpsPBWaUNXkagGZPJIxW01c3h
 IDvotQn9MDAgszLJgmngi1YI0ytud6G5MlcRefp8tNG404CbPnot+8dOC
 bYG8/nZjEWBDeVCFa1YYm7SFgE1K5fC1Ms7R/f0OlIrtam0NZZbosGixa
 AliyCy4R8k7Hlw9deb6MOrJwf65obPiY3fF/S/SeZrmowEy/npI9qf/6C
 5BTdNrktgvHl11fmroH61pRzJS7+52d6Og3kWKuoAc/Pz9LIb1PzhTdNY A==;
X-CSE-ConnectionGUID: dZHM1ScMRJCJ2FbIv+p6VA==
X-CSE-MsgGUID: QsQrmfduSaym4OFk40DeEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="99350967"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="99350967"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 04:25:35 -0700
X-CSE-ConnectionGUID: IJbSijYzQ1+JqyMsPzdNDw==
X-CSE-MsgGUID: sxJQHqr5Rj+CMzUalZOfgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="273537799"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 04:25:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 04:25:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 04:25:34 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 04:25:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbQfnSJ4sKB8+LI9LFgXT7Noa0MoOJ4YyZk7q0YiK+P2zRUf0jybq7SuTrK4nNovm2ODCCRf5cmaGBNfhcEa7IjP5V/O3nAQ/UxvN6VqzP2nkHyRua3wEChHNlpZe7eXM06tn58kLxyw84Y9PZo6/ivB2D6dRTTuXvV8nWkHXLnNCyD5N5kGMecFbrAGC6bq7jCHYKkinXzqZeL5HxrMixG37BKUt+BofNXkqXZ5/yT1Yr689zbklEcDqfcggGf7Z7RZi2WfeFFzS8Xv2S0GPRXnkrXik1gln4VP07Z00CmNfmrc7bDVGVyBy+pG2GO1E9p5GUUqCq+zUIev6OOvNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCTHYMjyavPrxKtaG4vHDo8Oq0n20iEOm/tidASKn2c=;
 b=UdSPOttoiCIk28EoVfSLwFDIMX3uvU6VfylIBhw+ukNgPAegXGd59hoveQVj9sER3oB2DvXhujfp0PTirAccwi0B1mRoWTO0zAgI3W6v+TTnJPJVNX0G/k7QchgeYDZ/hzpTOc930kt7oK73G4Y6XSZ+wKNVb7GpADusfe2hed7LfqIYWRvFvoUY2JXCWzx0sFeFDkpIDOaxiFp0wNJtpVCHQqpHKs3qbrzWPbIjtecgsyR/aIiR5HbT/fvEFNQF6D9AXT4TTgS48L2dGpHtvGtBeUvOA5HMSD1g0SQJi9ny5d5R4aw61Grpt2qBxDy8+Xw56b1cfkO2EpxTAMTZWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by PH7PR11MB8011.namprd11.prod.outlook.com (2603:10b6:510:24a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 11:25:24 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 11:25:24 +0000
Date: Fri, 4 Sep 2026 12:25:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>, "Vipin
 Varghese" <vipin.varghese@amd.com>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: Re: [PATCH v2] eal/x86: fix memcpy alignment mask definition
Message-ID: <apqqoMEC2AUBTYoL@bricha3-mobl1.ger.corp.intel.com>
References: <20260904092028.856816-1-mb@smartsharesystems.com>
 <20260904111912.857547-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904111912.857547-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DU2PR04CA0056.eurprd04.prod.outlook.com
 (2603:10a6:10:234::31) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|PH7PR11MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 910bb250-c1ce-497b-bad0-08df0a773656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xCtCPp8yJSCeGovdOpWzyDndw8cIqmZgLE8mncFPG4cndw4lC9a85hwaIDzMwtxdt5JdTxliokgrxBwU7LIHluXIuSKYQTHKRC+NlQ3+G5UaJ/cP+b4kEqu9EOmX0mEUtuBHWaOGSQOcdbbiv+3LemnFe7AbnCMGqWgO7icuaOl28JZrg99ljAh0pYfam1TiiUW+6rVaqBgpzEAGXtQV+aktFWAqmm+6MgE7LdfOXKnhUgp5mAv7LPLIxQgkHvZVkBi1VzyJxCrqN+8o9EKesmIpAAtsfQcqkUzrU6Pk9BtOgB4NfoXJDQFVEOL0//D106CXgltUyzmzQu9ftVp9k2zdScJoIXf9jyeGeuOD0lDgqNlk9Zlo+mE6EvZIB/x+wdBVIJ3OD7uJaRDq1xSaOkO+a6Sgb/0Dwxcz9YjKzSqlScxTaYNdMOcTrIYVBHEkvlyjAzNENcHRX1hUv1t9r84hbEkFxdSCmNgRqnAlVmKH6Wjbj2X+zI4vnIz8zFpyswiA5Ng6eB6wnX5rLZqC7jnDleqLR3cVwgmnPxhM9e5eaul8zSQGCt+9DiCybRTy3EmYGNrEX/5sUiCCNu6godXt8FOtfFmERXHjjTTGVlZALXgncjWd9Cl3rEubaN5X6n2bPssDjfcuN17VM2frWt3Wo5mxZacLYvntEwoCdO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?quiNUCp+g5i5pmIZS6zw5GrKrAVRPOL3ktxdfBrRxvu5CKSKVEh41tl6dC?=
 =?iso-8859-1?Q?HgWYiYGShXt/vS5tIBpquB6ntwSHEv9zONXNIhiG8y6JdRb8OCV4a3e1cD?=
 =?iso-8859-1?Q?VzVjfeCMyPBXE/9Q3Co3Rfx4C+pT9FG+WJ7mDBY28lhy9Ih2Gx2Lr5f17G?=
 =?iso-8859-1?Q?BbuZua316iIKjDAUMCKjZXsS4HSX0E8GCEIo5hFQDnVLLEQzc42cnUOMWU?=
 =?iso-8859-1?Q?BGsszl9BX5iqReXhmYg5Vgz8NloRJhludCd0+sAuUYTe99LwCxY1vBmbgs?=
 =?iso-8859-1?Q?QSHh10C6EP6bB4fER2l4WJhQGFOfeA4OclWuLhE4bKAdfJlqVSZlfRl9i6?=
 =?iso-8859-1?Q?S6bXM1uY/I0pP75trZLSGvtfEwc95Mg8G8RWhx7652EqqcOl65iAIM+vZy?=
 =?iso-8859-1?Q?1IeCA2mmEOoSm84wvyKBNA7BppmeNPEx6p2bSKi0lHg89cOqT/HgqgUzlZ?=
 =?iso-8859-1?Q?3P8FJjrJQE1fUU+ttwzeNFEQNvjDoKi8r+aYNWJzDdWQP2OcGOdbTPo3Qs?=
 =?iso-8859-1?Q?2LXVa1XWitrTDM0T1vCElmpNODDYnm/2TzHvdWmGOLwFIjDLyPaShawCAr?=
 =?iso-8859-1?Q?wSqFlHRwPRZR8VnD4Jdsyi6eCzZ62bKInTvPf7N2XzBBwY3UNka/xeRYr6?=
 =?iso-8859-1?Q?mSxtMT/Y4Fl74G10ALb2fTllI6b2LbfM5GeUskPdsD7z/0wux5vpsj4TuB?=
 =?iso-8859-1?Q?FRsfxx6HUmsBFd1Jr4A2ry+WwLuple02CJ3afGSUGEaiSCFyI+lN2qPVRb?=
 =?iso-8859-1?Q?ggMHvelnTccJDSRNe3aHWBYQv/OeLY0zf3M4IIhH1swh2kGPBJPV0a53Ha?=
 =?iso-8859-1?Q?GaAvmzzMjmZuZEoSuKW8JSG5exjWVMgyutUNiB96g1/9JgwaNjyKZRWzbZ?=
 =?iso-8859-1?Q?C8tQrtnswef0wly8IBbKLGuZ76Pvy+QVnuKqLNniRzfvl1sOAVKK3E0mfD?=
 =?iso-8859-1?Q?4hOPL+sWo/3cn6nyqCGUc6WBRTCiUXCPUJ+I7Vhz1AOrmaPZniIXwjCxjB?=
 =?iso-8859-1?Q?n3Ze27CHNyXyWMJgtsQToubdcKKGwMnM80GYqVrez6rkjE5dCp2C0wTndw?=
 =?iso-8859-1?Q?yGP2cvU9sYjUEcIC5c1SZrWWsL5DMp/BHiRfY6/wZRxlz7nNjEB0ixVDbI?=
 =?iso-8859-1?Q?gUwGcVvVbUKjb48eMGph7exCN8WLv9o+aeepIqRREb5fWQcFyJiVAYsZkD?=
 =?iso-8859-1?Q?bv19fxojfupbw1ctkgiCaE1VlqpWHY/FFPY5m3CdmxN6FiEpay84hrIUzE?=
 =?iso-8859-1?Q?+0vPbOzxpFC8z/2NNc7fm75OlmI6aSu0/fQ/A1S4QLjoaTFLr8egVKxCbI?=
 =?iso-8859-1?Q?qPLtljMM70dlK1rVPQFZXrJCPDlgOs6gpROVYxQdkArwEDERiWAjDB6bef?=
 =?iso-8859-1?Q?a+OZoFsB7yjBcOFZ8zHDHvkklAHpDgWZGxYrWMDDhE02KeEM/hk04nX7am?=
 =?iso-8859-1?Q?QVcqIRGuLvSwRtfnf4AQMxaT7ojQCdhDI7dltbEvZza3q/X4+HjrZwOXNT?=
 =?iso-8859-1?Q?r5uBhcr6DYeWf8FBa1zDk4KhFC+96csOOMarhuMeBAuXtVHLedKYKwWjWI?=
 =?iso-8859-1?Q?oc/TEZVtRwMbq+XlVYkqdtPcAtlCX31e9q/z+hosf366ttobRKR/eCrmm6?=
 =?iso-8859-1?Q?0/Cy4qSft8p+JTUcKbtinnJ28QO98lsO8Ccl1gw50umHMO+oZBaV8gdtyb?=
 =?iso-8859-1?Q?bbqdt/TTq9EzMJRA++ydr6hal3D7dP10bXeKyI4ZEX7LmkZnnQiz4OkCiK?=
 =?iso-8859-1?Q?+FhDIP+MYULqEMjyxuLNXeR2ZVOCh3gEhQa2f9iM1fQRrdmaRaUCwLuzPc?=
 =?iso-8859-1?Q?cHleLzk6rIFcUQc6wiZhUzySjHagWro=3D?=
X-Exchange-RoutingPolicyChecked: C0BcD/F56pyZHmwV6TZ/r4gRuYO85bb7yvo7RNFUCAMnVwu715r2VuD46gCECix6HwgEMW6cnE0p/8LQtWdVl5VqrHkAthZnEnjQ5ELrj/XfUAoiRr1hPXsE/QfXlXib5K2+NjpFASwB9n0riN4pRijPUUVuPfH57Y9eqNdhGcoMAnnGe/WdP5Gd6I2BWVKk4FK1OqgoS7SFrP1/fc7FPH3PK9sktgvAcb7uaFmT4yePEaVazTQP4bFtQmIIE/AnG1WjtTxwMDTQtP1yYlD+oFKCWJhanuZ/acApPE35gNylXEvyZj0kWox/IKLd4DcZhp2NvdiWE/0P7o1IGVPJBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 910bb250-c1ce-497b-bad0-08df0a773656
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 11:25:24.0521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYsczfLDrWb+tqg9jki3n1EHa8VYcC0MMJbB60Buc/KViBd0EXTPqSSjm79Gp6U+z8F8fgzTMPPDsdVPPMeoBt9eBRx/aTllJBbIPd1j+ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8011
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

On Fri, Sep 04, 2026 at 11:19:12AM +0000, Morten Brørup wrote:
> An alignment mask (ALIGNMENT_MASK) is temporarily defined for internal
> purposes, but it is publicly exposed when including the header file,
> potentially colliding with existing definitions with the same name.
> Fixed this potential issue by adding the RTE_MEMCPY_ prefix to the
> definition.
> 
> Furthermore, the superfluous function declaration at the top of the file
> was removed, and its description was moved to the function definition,
> to improve search results with source code browsers.
> 
> Also, changed "!(addrs & MASK)" to "(addrs & MASK) == 0" to follow DPDK
> coding style.
> 
> None of these changes should have any practical effect.
> 
> Fixes: f5472703c0bd ("eal: optimize aligned memcpy on x86")
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> v2:
> * Changed "!(addrs & MASK)" to "(addrs & MASK) == 0". (AI)

Did you miss this change in v2? I still see the "!" below.
> ---
>  lib/eal/x86/include/rte_memcpy.h | 37 +++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/lib/eal/x86/include/rte_memcpy.h b/lib/eal/x86/include/rte_memcpy.h
> index 8ed8c55010..41fb08ab95 100644
> --- a/lib/eal/x86/include/rte_memcpy.h
> +++ b/lib/eal/x86/include/rte_memcpy.h
> @@ -32,21 +32,6 @@ extern "C" {
>  #define RTE_MEMCPY_AVX
>  #endif
>  
> -/**
> - * Copy bytes from one location to another. The locations must not overlap.
> - *
> - * @param dst
> - *   Pointer to the destination of the data.
> - * @param src
> - *   Pointer to the source data.
> - * @param n
> - *   Number of bytes to copy.
> - * @return
> - *   Pointer to the destination data.
> - */
> -static __rte_always_inline void *
> -rte_memcpy(void *__rte_restrict dst, const void *__rte_restrict src, size_t n);
> -
>  /**
>   * Copy bytes from one location to another,
>   * locations must not overlap.
> @@ -187,7 +172,7 @@ rte_mov256(uint8_t *__rte_restrict dst, const uint8_t *__rte_restrict src)
>   * AVX512 implementation below
>   */
>  
> -#define ALIGNMENT_MASK 0x3F
> +#define RTE_MEMCPY_ALIGNMENT_MASK 0x3F
>  
>  /**
>   * Copy 128-byte blocks from one location to another,
> @@ -333,7 +318,7 @@ rte_memcpy_generic_more_than_64(void *__rte_restrict dst, const void *__rte_rest
>   * AVX implementation below
>   */
>  
> -#define ALIGNMENT_MASK 0x1F
> +#define RTE_MEMCPY_ALIGNMENT_MASK 0x1F
>  
>  /**
>   * Copy 128-byte blocks from one location to another,
> @@ -444,7 +429,7 @@ rte_memcpy_generic_more_than_64(void *__rte_restrict dst, const void *__rte_rest
>   * SSE implementation below
>   */
>  
> -#define ALIGNMENT_MASK 0x0F
> +#define RTE_MEMCPY_ALIGNMENT_MASK 0x0F
>  
>  /**
>   * Macro for copying unaligned block from one location to another with constant load offset,
> @@ -673,6 +658,18 @@ rte_memcpy_aligned_more_than_64(void *__rte_restrict dst, const void *__rte_rest
>  	return ret;
>  }
>  
> +/**
> + * Copy bytes from one location to another. The locations must not overlap.
> + *
> + * @param dst
> + *   Pointer to the destination of the data.
> + * @param src
> + *   Pointer to the source data.
> + * @param n
> + *   Number of bytes to copy.
> + * @return
> + *   Pointer to the destination data.
> + */
>  static __rte_always_inline void *
>  rte_memcpy(void *__rte_restrict dst, const void *__rte_restrict src, size_t n)
>  {
> @@ -709,13 +706,13 @@ rte_memcpy(void *__rte_restrict dst, const void *__rte_restrict src, size_t n)
>  	}
>  
>  	/* Implementation for size > 64 bytes depends on alignment with vector register size. */
> -	if (!(((uintptr_t)dst | (uintptr_t)src) & ALIGNMENT_MASK))
> +	if (!(((uintptr_t)dst | (uintptr_t)src) & RTE_MEMCPY_ALIGNMENT_MASK))
>  		return rte_memcpy_aligned_more_than_64(dst, src, n);
>  	else
>  		return rte_memcpy_generic_more_than_64(dst, src, n);
>  }
>  
> -#undef ALIGNMENT_MASK
> +#undef RTE_MEMCPY_ALIGNMENT_MASK
>  
>  #ifdef __cplusplus
>  }
> -- 
> 2.43.0
> 
