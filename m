Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFF2CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 14:16:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55B93402AE;
	Tue, 14 Oct 2025 16:16:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 79D88402A8;
 Tue, 14 Oct 2025 16:16:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760451389; x=1791987389;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=mNvaZxtBKc0P/8bv/RpV3kwqDjj97+RGJrvavqWPxog=;
 b=jKZ9ebcFQ7N5MB5PC/coQsZEe0tJBUgdgfTeBtG8e6LgHJ0cew89COJk
 bnUO3lqUp00AXenDebzQRu6gG0Vjrl9zUcwkABtP9c8/Es7stQrigDum5
 NhtTE8blVh7oIiY32KST7GEiLg7D7Trpktl1rnExNTvABZsl0WolQrUhX
 SFdP+LcBZwjt0B31ZZ+ueqbdcpo/kiaZiFU10+3OcPjCins3JzR29HKXl
 ERHFKy7rOGGwOyzocKqfg8ZJZNFuaDVSaHvyOD5lyNbQy3Gk3AGBFotdq
 MppCoTPQQ8BoeQ0wldnRepI+YDmJh+n8NZ6IV6Mj5YzOTvyzZSOBCOYqT g==;
X-CSE-ConnectionGUID: iluPyN4mTWGZc+zamBUH7Q==
X-CSE-MsgGUID: 9iGABvCZT6OA2KDKfaJ+1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="88073692"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="88073692"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 07:16:28 -0700
X-CSE-ConnectionGUID: qH57zgpgRxuu/f6tjTOn6Q==
X-CSE-MsgGUID: vcynLjbHTbKLab26lbViFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="182690762"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 07:16:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:16:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 07:16:26 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:16:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onPxv7njXqd+JBf546p8p+5QdRQC6sdgPgH+5x084xP851+b00wwiBJalxyGrD4cHQGySEMuSFRu5qbTkVZztMmK5T4zCB52fFVakCNJd2SRbb8sVIl7ZkybAqVRer5I0rCz2UaEL9GAtPhGEDoq3r8/oQ3r3O3wXlzIQ/0CaV5O43IEexjEuKzItUI/pZn2DhGmphFyWmc4TQBJYKVdqgw+SZu7SP/TeaarEOiCY3xYD4K6H8Fu7aMwbcUGPyv9HOxmUqAxPz4+29P0cuARlX4gLEJfzVM6N9eNdA7C349KFS9JQsDRMtzoc0/PvRNDRpRvif+BaFWRKmz3v5M/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osYwEZmtKSB40GSOjEvVUNwL9MpSH0nrn6EC8tx7CDQ=;
 b=eFyrfA1w5MiSB/ulPx0M9bz4/x/7Wi9aR2ib8IxI2rIh0Jvg8MoxyBTAyV6XMW3W+V5v4OvtMx6RfuV956RbcgEt0kLEoLFT0e9FvJCr/SVVsD9QPdkbCpTuBjCB7C1UyOwTePXNh++Equwsste4dWx4XqtIAS486JSTiBKJDj1dYPEeIC+c5r2epOmuq7eDxPxl0SFgiFuB1J/w+4hwkAkuPP47tPhuySU1Sc6usrKQfTs07c7tpyFjelZe6Tej8iUAHJ66aBar5JieiKbXJIfOkaAKaRi2gf6xORU45JRp+9ND/p463jB/vs4EZkzKY/MbGkkPUeWAI8LZCsX7ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB7980.namprd11.prod.outlook.com (2603:10b6:806:2fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 14:16:24 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 14:16:24 +0000
Date: Tue, 14 Oct 2025 15:16:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 1/6] net/intel: fix Rx vector capability detection
Message-ID: <aO5bM-oLUIj828GQ@bricha3-mobl1.ger.corp.intel.com>
References: <20251014084517.1407407-1-ciara.loftus@intel.com>
 <20251014084517.1407407-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251014084517.1407407-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DU6P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa5618d-1270-4974-b868-08de0b2c415f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jMe1a19YooJ1kAsVqpOW58j5ultAa9cuNqQbiwNC5/G/X7AS+lTzDaXBd6IU?=
 =?us-ascii?Q?3CR19K2djMuY8jyY3szOzFxPkaCxv3rFZZ/TuIJ+V3/ODHNsaiCckwaT++X1?=
 =?us-ascii?Q?ZiiQTrWsAkAUX7GxskefKbPngfmBQVisyq4QyOOq1sEV7tX2pPq7rE2VaG3M?=
 =?us-ascii?Q?1BQzK24EO6d1EipDXcKuV7+NL6OfkFnI2m+rBWQZD96xkuHFkE0WSrNktb1C?=
 =?us-ascii?Q?fK0HZUGcJbo0AubS/x0Idt86JLbRMFytyx4kzdlOZqn2BK9UlRC65HiI4MVq?=
 =?us-ascii?Q?slB3ji+WSUfL5n4EedILGxm/gtBcZuPCdzBtf7mHnHwLj7KEUUC4aRmfXBXZ?=
 =?us-ascii?Q?LGGyI58SeRigVZLEutQyyqQEEDS0bILqiXBsio50LdZhEzimlndUsJX4a+fn?=
 =?us-ascii?Q?8H5ujM+hDCfuzydBZC7odlcCuzT+13khqxwPKQlfUMVylKbe3aufb6GMuesq?=
 =?us-ascii?Q?Jl9YDLRPJ+a5ARzzXyQzgt+QdSRfni7j2S4Y5GYgeH3Qmb7QEz+CwytOz70Q?=
 =?us-ascii?Q?DKfrzMPec/yyJm5YPtJ8mrWMxPRm0e+dnyfdN78Ox0cDQcV1dEW1uCNARKg8?=
 =?us-ascii?Q?Al97+vtwhD6aB8G6Mx4y+W1xRggF0uzGbfeF+oKHny0rkgtjhd/XSjI8o0vR?=
 =?us-ascii?Q?+fVO07+7dXyEKSgTf1K1wnS3dlU73SQPZx9tU5LLWLiKAg0AOkL58hUJTr75?=
 =?us-ascii?Q?4pzaEFgdqYj0pMFFD2c+pUbeS6hpizYHwLLJ/3ORVxttm6o4wwAMUIVp50H1?=
 =?us-ascii?Q?amIpVcS/V2c8NJjqGkN+WBmBzQXubnapnRo2UbBDFwdgCtLyVUDQ/MWk6TYg?=
 =?us-ascii?Q?QpPS8/4VI9EU/W4M871RqRXWJ6UF60peZ31usyTFav1fGtL5c0fqexsGYLUd?=
 =?us-ascii?Q?56F9Moi1mdEj8vFFmNXv9FdLBf23ONbGRNTsgAtpcqZsJQrQzH+1+X1OqD7f?=
 =?us-ascii?Q?WUjenE+v0SVqSbwB/3tuZ3CaWkNzWU9PDDPTWxk3q6/iwgBHb2TZRbzqijVZ?=
 =?us-ascii?Q?mzPgKr1is8HRoS/TCXZebmuGHk5j4rYQNfPUii8ej+PbkHkVZ8sR2VPG+0HD?=
 =?us-ascii?Q?R7l9RXN4SsgFrLsJkiqKRH2gbcwE9ONVH/GvWJ9ul26NtFjbOmZYAaiajhFs?=
 =?us-ascii?Q?v9klOuar2irCpVYGjLcnRFsPVMci1ngAsQ3xG2JyjU9WCkotkrUyrDDVLUnJ?=
 =?us-ascii?Q?6/mZak80lcuz0AHoYo5jnhsDzq0bWZzzGrWy6SZaPTipkdWbjeE1xNWcBuiE?=
 =?us-ascii?Q?NMFARvOWPp9AJ0WpqPt+NgwYGKM9YqxVmGgANJmXd9pbJ34XU0Efk6dKmxL7?=
 =?us-ascii?Q?iDqzIp2yBpxnBDw9orVoC2AN4/bVSckgUWuYdW7yI8kkF2FnhJKe8h3hzhEm?=
 =?us-ascii?Q?54N5D5GHFypV0/90cmyXFNVelWF9JgFJ91Wb6HTp3R5vW80aIQNRCCMUHAwU?=
 =?us-ascii?Q?oUxbGAasiSVeLW4ch4Tz8JfBRz/IOvf1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bhOm/vtZ/UxPdlh+FAQbEYfXDOgQdmPtpi2aOH1gKHIZbno+vYmklpxDRajx?=
 =?us-ascii?Q?XG2pzZp8Ao7/+RLZjdXhMA2ef2r9XjYWtmK6zzspuC4pMS+iklUENvyIbSkt?=
 =?us-ascii?Q?HufrRr5ab+D+Xy4Q9PFo2ve+TT9OrUsEaFr+DE9bB6kSY3HoPecm9u2yOzA2?=
 =?us-ascii?Q?CacxfpNSK/O3m879n09WeAPFibAGwiXUnySn6nll6cBEjR2jxw7c1cz3VvT1?=
 =?us-ascii?Q?I8r8GbOqJdMLeFSGiPgmdb1L4dNxqXKgLbryZKl7w94wX+KQFOcaDQ4YX97b?=
 =?us-ascii?Q?mGSs6oH44F0ZD6pyMk5ejuWJRamoPbtGKcDbBbklFVIRX6MItOzrO710CBCM?=
 =?us-ascii?Q?6lZ3h63UWK7M6DDSKCA0gt9gzHA6wMsgqUxdciPJwIq/2YsQc56TIysDjclJ?=
 =?us-ascii?Q?NFaLqDHUZ1x2Tit1zwFN4loWHdVhi7hcaMvUAzUU+ga0D8sHvdorQQg+wZv8?=
 =?us-ascii?Q?KUdgCGBlZZMIUwUNDOL3yg5vOUq3Dccqw68HxJbv6ULEJCm9W9wzP6BuZRrR?=
 =?us-ascii?Q?7vph3F9ngWdD6ys+Ra1qD9eOeha38eu9zoTF5itV1dvnzgPvKxHXtIGKaAL8?=
 =?us-ascii?Q?bGaxG8jG+ay4gJJ49ky8bgFEzXle4XHlBcN67MUy7yd4Qe3BvBXko7W2K9hR?=
 =?us-ascii?Q?dpAiInzCx1vkYN94wWgyTPm29aT2Pt5P+rlc15wp2zjzMJYvXJN+ZBoRRO4s?=
 =?us-ascii?Q?om2OwkdrDOAWIT0tQtoacOKxSbwDX3XCZ6ncLaFpLU4ccVLBYdw8Yu6x395z?=
 =?us-ascii?Q?oKMbY4eInjqqE9qOZtJqaKePaQ3cu1kwFWge7USZV69CHzI0sMcRcjqx1KWq?=
 =?us-ascii?Q?dbT9OBmfAs7At2kSAO+BaVzVuitoF9fUooz6Q9o95hT0JELVgeTYtpZ/AEls?=
 =?us-ascii?Q?a8jp10KT9XtL6UyRFUso7DtxteSPAc8B0SRtvsHBwuhBNrjreUTj1Gs5bdLt?=
 =?us-ascii?Q?yyWU6utkZfRJx7euqbUrwg55nxx9egfMPd+YWIXM97QgZ0QPAJqVbmtIgkAg?=
 =?us-ascii?Q?l5FKtFRQ8OsvfEl6HFkIUjEYlWO/vycGIHLrLp2LF9KyOMzYmLZ9tO89j7zV?=
 =?us-ascii?Q?KbkeGMpdL32wI0q5r7/ntvlePSmZVhPvQwWmAKXXBW2yKGAN36yif0XDl0RC?=
 =?us-ascii?Q?5WOmk7DVCu4Dbkjp/fiEXr7n9VC1QdHmgLl1VLacrX0Orp240UkRpKLyUMFA?=
 =?us-ascii?Q?kmD1DLspZhyH8krm0Nd6q7Atl6KprQT9YWrOejI2yunfNsmwRfYA6np2Kk9v?=
 =?us-ascii?Q?vIuULQ3GTzC6ePz+TWsnodv+gRqPXN7T0/1kYwMR/mB7RhXxMg+MEpIpym2h?=
 =?us-ascii?Q?6a6+0P4/cDW8VbpD04aC/KPi8OBtr2RpDDZInjavKCt9FGaHq/iLf74icLZy?=
 =?us-ascii?Q?raq4Pl5eLMIqoE95GkWLyun/BepjCHbAJktaLP8CDhLUS0Jlp5jz9soYK+uX?=
 =?us-ascii?Q?QS0w+0uLU3WpMVFILr2jDewFsxX3SeKUue1azDMGl4ORWjmswOIOtYhD/OQk?=
 =?us-ascii?Q?2Fz8insdDclPSlhb+O3bs4ZXK2K8MVg9SOsrJaFmYPErUUcxaSZlR49ULbgw?=
 =?us-ascii?Q?8a7sCrGEeWY6haMRFPuG0FwEv/oHRZcgGfPsj/mpAW6sP2kfhhEArMbbk88P?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa5618d-1270-4974-b868-08de0b2c415f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 14:16:23.9397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCfH2VVZ4dAFS+Ogh7P1Z6UtOM+Ui69JPNAd0JVVVp8QeTpXj51gFpYY21Mfjd2kIG5Er11Sd5m3aXDMQkNGazwKLPaYsQGUKPCUNhrEXCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7980
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

On Tue, Oct 14, 2025 at 08:45:12AM +0000, Ciara Loftus wrote:
> The common function for detecting whether an rxq could use a vector
> rx path would automatically disqualify rx queues that had the
> timestamp offload enabled. This was incorrect behaviour because the
> iavf driver which uses this common function supports timestamp offload
> on its vector paths. Fix this by removing the conditional check for
> timestamp offload.
> 
> Fixes: 9eb60580d155 ("net/intel: extract common Rx vector criteria")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/common/rx.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
> index 741808f573..d3e4492ff1 100644
> --- a/drivers/net/intel/common/rx.h
> +++ b/drivers/net/intel/common/rx.h
> @@ -235,9 +235,8 @@ ci_rxq_vec_capable(uint16_t nb_desc, uint16_t rx_free_thresh, uint64_t offloads)
>  			(nb_desc % rx_free_thresh) != 0)
>  		return false;
>  
> -	/* no driver supports timestamping or buffer split on vector path */
> -	if ((offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) ||
> -			(offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT))
> +	/* no driver supports buffer split on vector path */
> +	if (offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT)
>  		return false;
>  
>  	return true;

Given that we check all offload flags later when doing final path
selection, can we drop the flags check here completely? Just have this
funciont check on the non-feature-related conditions, such as ring size
etc.

/Bruce
