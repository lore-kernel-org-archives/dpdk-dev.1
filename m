Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559BBD41D4D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 14:41:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20AED406FF;
	Thu, 11 Dec 2025 15:41:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id B036940151;
 Thu, 11 Dec 2025 15:41:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765464105; x=1797000105;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+sWGeq4RKLsgl7plL+AFaDAcLETS1A/RAyS3QARB2Wo=;
 b=Av84yTmYIRHRVsjjWOmRY28nZYCDKcP4FB4Mt9eQv2uUlEhZNz88wGqh
 aK6i3PgZ8VpnLQsRvyT3ySg2qiAhu9tTb1U+HrvgtKoVyxQZuDrrJ1lVQ
 QldKwZfcxLJ1KmHjuLNRfmnf7TpdrZkufT2746sv5JipAnhsDb5WpYPJM
 h3HGJdO4VdWAoBKk3jZuH61hetEOwZeP11M7UHNoHCclfqCFEPUc1wgIJ
 j/MzHVVQNULbxkLZyALhSafzcKB/qURJ6wnX91ERFaIj83pIKIJL9ATVW
 CLb2N2m6dAloh3hVerzCvBrlqamkwHtzpUzwyrr6DfrlFPRcL2AuSScUG A==;
X-CSE-ConnectionGUID: Koaeq0+3Q8+EP9ODL+bxKA==
X-CSE-MsgGUID: lvQPDEhLQqqdTo/wzM/n9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="67486114"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="67486114"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 06:41:43 -0800
X-CSE-ConnectionGUID: jyyVCr/ESbKAkBpr3fCNSw==
X-CSE-MsgGUID: UxD8DiDJSZu3L3KNLNfXdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="196584306"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 06:41:43 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 06:41:42 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 06:41:42 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.11) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 06:41:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y47LITRn2Ux8c367pPL3YgIYR4k86mbloE1IygbPR5OyjbxUSEv+QKfNI1xnODeeemLPbTz4CGCl1goxh0++tdulJ1dHR9fHRy8vepJrac/+8HeyHiLt5H5vjAKjB1XAELc8Vbi/4zFkTFrkuhDgZKYTqP3ftYQaej6g8G9oe6BnpoAX7D1lqH9XUZ57+NxLK7+KEo66La5xraZ49LTuK7No12hBeqSStOqMEackZXmZ33RzbwijZJRnggaS25H2NwLGWzqO4+gnaqSJPlPtYSGv8pQuMb60sN8xJo5Cykb0/FEHOQyzlpVSEdGfQc38YFZN5Sqw8zr9l4Rp6AaHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3fD0ajsOJf5xevyUISWZHoMSOV9OwHvXNm6cnZP5X4=;
 b=polv0s/LwJvKrBDh6unkigbZSo1pxUycewGYNgWbAHmO9J1vEk9QgtNt1Gt2/FjY4rr0x83fMXIzYNQ/NCO7l2GHZtnemFkA1xpv1wzi3kxsESaAOVnANmJHKRUlh0T7TH2ZKIhcUWjOUOBwg5bZ5XyJFsu9nIjV2X9hsn39EaVhJmC7AdVzrZj93+sMBIlEyiOjoTjSjtzv7UleJstG6uqppQCUp/zTwVvnytcyADlH0x4rK52R2c7Ram5kfv9S6LVJtGdjQcyVsdMuZ6tZzEe0f/ZIbGY3S/gEbSKmWYyFqNN8A9PeVTuFBLHSEGpDNyCvswC9rnhTdyNyfM1STQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6565.namprd11.prod.outlook.com (2603:10b6:806:250::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Thu, 11 Dec
 2025 14:41:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 14:41:35 +0000
Date: Thu, 11 Dec 2025 14:41:25 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/i40e: fix QinQ stripping
Message-ID: <aTrYFe7rmsCyUfFp@bricha3-mobl1.ger.corp.intel.com>
References: <20251206184312.69020-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251206184312.69020-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 9224d715-1ce1-49f5-005d-08de38c35f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8z5L9FJoyYlvoW6daCdthn6iYoj3Q97ZMAONDV3PbBV4OiPO1tDcwWBobbWm?=
 =?us-ascii?Q?fNvIFHJIA8xFotAx910H9gvB1yhYoDZvg7IkpaTfKfjQSdNnoCRSTQqR+yzU?=
 =?us-ascii?Q?ghzHrAy4QxLgH78uWCErOLKB7in2gps4qu8hcgv27L/VK/9BjDWKYRBrlmm8?=
 =?us-ascii?Q?wGVM+GvodgvnuVOhR3NYbelE0YmgA9OpqxcusqUXrRVMeL0tn93qQKdEwCFT?=
 =?us-ascii?Q?0Y2uiQneIyEMRActLdaAA1YS1Gac1cfyZU5iBwNwHZHoShVpDeo8PI6CX+mQ?=
 =?us-ascii?Q?eISNwvVUsgdP2M20+rOctHN3Gsch4vSJChDWCCetr6orejqrNPQNRPr5Q3mP?=
 =?us-ascii?Q?OCAEql3PcRQAu2bonXK2CP4cyHJO1Se+vzLr2BLj9V6FrizATv3haGHXU0Yl?=
 =?us-ascii?Q?F5JfCwITJQaYWEtMyjtOYPYNdRZjLAD90qCNdsXFPyyXo7hAk2UpeiJoKnyA?=
 =?us-ascii?Q?+zokgnxbq7Vt6zeww0eDAGg9zXVWvroZOMvUV2TtnHnBG4iBjiRPfzQS2iuT?=
 =?us-ascii?Q?q3V2FWrjQjpGZTWuwYAVBg1EaLmcmMex3V58ixe/HX3TuTmGUVtgoCyjciAA?=
 =?us-ascii?Q?dp8BU9Cr/sh/Pdvv5xYsIyLawPnGxGYDPFA7yeW9JwqJiI7aJmjzz5s/2cnT?=
 =?us-ascii?Q?XD5vE15VWEPQ4nT8qBO58u0RkxkAnF/+erFq9jGCX//j2UUU1a3VxlUPKpNQ?=
 =?us-ascii?Q?AAeDgCbwzs7NH170G9X9eVHC7yIHs5FCUs/MkqQ5i7xmDKdhsFZpOLS9aXPZ?=
 =?us-ascii?Q?kTlhG1oAI209qVRaoTaMOP7R1PS8q47vHAq3lUbgVIwWkuBBmRE7x+nqX0Mw?=
 =?us-ascii?Q?TIPmxUP+oHb9W6vVRRI1g2NoRujn0xmHyV+HoYvjXUszJJudMXku3I/ik+jQ?=
 =?us-ascii?Q?DgEH4Bgj+Qz7efydzYLrLSrjMtFGv38UvLB8uEYUgbvzRrBP0SW7pJHU4Owe?=
 =?us-ascii?Q?LmzbcvytXX6O+1EaWUzwhD4ncKoYRRuCMKO1BOSi6E1tWhMEYlAanAJfutGJ?=
 =?us-ascii?Q?8ojrkCVjB642U9frFxm0KMnG42eNCe3EbNqm8Ec66VLZcyl4Dgw/ucxrZnVw?=
 =?us-ascii?Q?rPVYgYrd9ngP0GnklFRFQu4JDRUQTspYOljSUW4eMzhR1ZEfGF//awJkZkCF?=
 =?us-ascii?Q?Up/xcnYt56osVIQbEPRlkZkf6sQCQx3fQcH0AB/6BkiUsam8v5eIJIg69KgL?=
 =?us-ascii?Q?fMh+KEbWADnNZjcDZx35Zp8Z20g+ArNHg6jkKscLVXfQeVbk0zhaaot7PVYw?=
 =?us-ascii?Q?drzxA123yiTrAMfE0SCcsILjr8X4yObrp27lfZOSqAAkJb1OwelHUbQUzZ5O?=
 =?us-ascii?Q?QgspUzExyz0pCid9y194RKPgEBuUk4iKVnSYln5PffXHymBVGRsmwXIg611A?=
 =?us-ascii?Q?1GCHYdRaBH4svRCwfDStSrxzDo6K9VG7Qxxa+RhBfVOibP10KLKAlf7Gpg1y?=
 =?us-ascii?Q?/DsbuYvM27LOzaTR9RWRMBV9E2vDwzCQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RoRmC2CEaLhjjt2TqehCheO89jg3Kdw2HTDwSbZFPi7Jf+GGzSdmknDvkw0R?=
 =?us-ascii?Q?YkboJsXex0QYz0FZQNDHexgBvqTtLgy7LaohWQXgNy+i69U/erhIzJ/YsCtS?=
 =?us-ascii?Q?bxr9TIpLt49L4B+V66lcdHl65SeatK/Old/EBaJgV0W0m2RZHwh/vAFkhMMm?=
 =?us-ascii?Q?D/pX8KlSohOhywjcH5dEE1lCdyOtIerkNolG24AFlMyMlDwV6dGE1Qh+O+wR?=
 =?us-ascii?Q?LUjVOw2x2TjoBpnsf8+F1IY8AiyYAx2RnF7bwrLiVU2c1Mj79a5vlkux9tm2?=
 =?us-ascii?Q?CPN7OtiUgkQ1c8U8iQod+prFkZxymqpBuFIQ0QNLQggprfgufbsmls1axdkh?=
 =?us-ascii?Q?1dDuX51bYrCYCQNgk291KayHgi87136+Ye/6J6HfUJoWyEFSJGF+GtYTZsg6?=
 =?us-ascii?Q?qSlaunUBn0q/EUq3k18fiEN/zj045vv8G5G+e/sz4JBtrHGBmo2ulSd2u4b6?=
 =?us-ascii?Q?ljdS9q7AH8hZhr17IrQaQLqwhve2LHHPvJV6q4sP7kqEoLu+ASCNIGCgnivX?=
 =?us-ascii?Q?4h2gX4vzwc/blDuGiw3xz+u+oy1kCTn1qwd60i6vZpcyQ+FVlJhoGgwxbOG4?=
 =?us-ascii?Q?IApHLFpdAN5OJZRMOUL1dkQybWG9VYI+VFmFKwH8AtYakqtO32KB0pHnkE/S?=
 =?us-ascii?Q?k18qzyoDIwmMlNsNs//xXQXj/gAyCcYOUjDSCRiouYftOtZWnwPZf/ekO0Ig?=
 =?us-ascii?Q?5QboyD1ImVYOT3sWd628GNX2MbiAzOY+1Gyn3ncoZlVHzI5eBdlc2k/aRSNr?=
 =?us-ascii?Q?rvgmgaZWdz2niey/3jpCgFmO8XXjyOFYrI1Z18NsJH+BKDexhsH4GZHANB0Q?=
 =?us-ascii?Q?9mrM3vfsqPgwjzM5BfG6LyVK62qNKzlcqAH81WTspTv9ncS3NuFvaPzO2VSe?=
 =?us-ascii?Q?yY2m7AaouLq4jVu1SUBuNpd+5UcFQfuI0DzPRYfXq3kPcVXPTAommTt2r1S6?=
 =?us-ascii?Q?wjGSnlfhOFtLaz/3SnNK5J2TdkbQ8n5wiLN/vM26/+UwWdMBqew4j8y2HMyG?=
 =?us-ascii?Q?7UBdZWbhQ7IYD3/kyaggeOlXYb5ekMaw4O3+V5W2N17lroTnPF7ftz1srBpB?=
 =?us-ascii?Q?IJQNXAs+hipBuKFQ/zAXya2tAgJJ4MAYgOVY+9CE2SpXTK3mWvzad0Qbp0qj?=
 =?us-ascii?Q?A45TL14kwRpMkNxy5I1MhC/5RfxD+1fY1t40wddJnRwmHdLczEYY+TpYPluO?=
 =?us-ascii?Q?VfyOjFPgkWRkYOq3wylD4b3wpWLtabjeYI/PbDyf4jiaGeqbb8daAqK2IWYu?=
 =?us-ascii?Q?aNfQfUIDnVsUWbrcIvMCtjoRSJzYLbtrW2R00N3VT+IXpv/z9zIFpdejiy2Z?=
 =?us-ascii?Q?lTuQOJhhklBibHI7hjsWzZdh+rfWPXqlYcr4hATuSFtRuGPfF8EOmaxMr9lm?=
 =?us-ascii?Q?r/7lWsT/V5AdrFLlXVh7sqcYR+oIt0hrg931bqQyuA/bzmd+A7a7ofoV4ua7?=
 =?us-ascii?Q?ELM4pdcJmVWW6guVddXSh3JZGXCbG5KdTtOfmbhjglx4MNMlQZRJrwjvjn/x?=
 =?us-ascii?Q?innsfdqA6oBpsvvNrGkhgClZ05/ozrxp7MPoSZTedbG2nqqdpt0eokXBVsyg?=
 =?us-ascii?Q?o6WdCusxPA6BFvYsaeKmRcgMWXq2T9zEQcxXIEjYN65+MCHAQjJqOmfGd1tS?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9224d715-1ce1-49f5-005d-08de38c35f4a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 14:41:35.5686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNmKOaHjgAlssU3jdkT03XTw/2hLOGsU2Flo326lzcbeLNyG+TI3u4xubsQatKoR4mXKqbrnukZjhquOWZPdak+eEBH09tlYh8rD1BfETws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6565
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

On Sat, Dec 06, 2025 at 06:43:11PM +0000, Anurag Mandal wrote:
> Outer VLAN strip gets disabled when inner
> VLAN stripping is enabled/disabled after
> enabling outer VLAN stripping.
> This happens because the respective register
> is overridden by the vsi params update of
> inner VLAN stripping.
> 
> This patch fixes the issue by re-enabling
> outer VLAN stripping after modification
> of inner VLAN stripping.
> 
> Fixes: c52ff36686a4 ("net/i40e: enable QinQ stripping")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_ethdev.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
> index b8ce79061b..c8153f3351 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.c
> +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> @@ -4150,6 +4150,16 @@ i40e_vlan_offload_set(struct rte_eth_dev *dev, int mask)
>  			i40e_vsi_config_vlan_stripping(vsi, TRUE);
>  		else
>  			i40e_vsi_config_vlan_stripping(vsi, FALSE);
> +
> +		/* When VLAN strip is enabled/disabled
> +		 * after enabling outer VLAN stripping,
> +		 * outer VLAN stripping gets disabled
> +		 * as the register gets overridden by
> +		 * VLAN's strip vsi param update.
> +		 * Hence, re-enable outer VLAN stripping.
> +		 */
> +		if (rxmode->offloads & RTE_ETH_RX_OFFLOAD_QINQ_STRIP)
> +			i40e_vsi_config_outer_vlan_stripping(vsi, TRUE);
>  	}
>  
Hi,

to help me test this patch, can you provide a set of instructions as to how
to demonstrate the issue with i40e and how to verify the fix?

Thanks,
/Bruce
