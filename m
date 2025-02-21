Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F14C021B5
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 17:06:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50A3340ED3;
	Fri, 21 Feb 2025 18:06:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 8FE8F402BB
 for <dev@dpdk.org>; Fri, 21 Feb 2025 18:06:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740157573; x=1771693573;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=z0nHDdmL89WZItzKUEdnaRYyWXF5b9yqUqKREv920Ek=;
 b=b0cRpW6eppDe0hJHGBVLnmdQ8lSM9VLAMR+4a0w2sk33hHvpx7BtfPmQ
 Sx18iua/ksy8YGKZB+BLy2zuArz5dGmvS/sWA/6bF4EMlDXsEAS0ce0Sl
 SOLSfXjpyTj+auwvriMSv2hCKWGg8FCAUUq37Pc1gWMQoXrpuFfkb3F3b
 bhaVYZtJ1xSdEAbfyC9CW+h3SnWG+9JAs/q4F89HnQ36d5HEq/La2Q2+k
 ducE+NUUgM9OxNAEoVXPuhuipIQIvGksGb5g+Xb0WB2BzKD2YA6gSNt6p
 hL39PQiWkWthuEXsuTiYotjjfc/xQgYxM2wQKzcQs53jas3WU+MDIs4a6 g==;
X-CSE-ConnectionGUID: V0ONRzlBQ3q0HDXZb0zWRw==
X-CSE-MsgGUID: DObts1waTo+pjGyZ8EuhHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="52384480"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; d="scan'208";a="52384480"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 09:06:11 -0800
X-CSE-ConnectionGUID: JOGyTqK3TB+VbBKOggJQwQ==
X-CSE-MsgGUID: Czjm+kKDRz+fWTqhrNFcDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; d="scan'208";a="138644279"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 09:06:11 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Feb 2025 09:06:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 09:06:10 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 09:06:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ez0mK9aq7ngrJoExMmdv9gi67CTOYJ7jC7l/DE2tHIDBVamao/KDlhz7hPu15E/qsuLVA6hsQ5ATzVMtOT+IpRPSZIxGhOKsOLYvluJRZJ9UvYoNlNyeUW8DWxXz4XGIMqkqf8JShSqVZl6wgZEu1ZdM5B3lpNytTP3zTBpG/OaFu56oV0bozLJ5s1m7PSVO1uDBu7yPWB08e4zHTQHbjU8M9N4iQCFlvJltSnagp87Er6M6XoXiWU0drpjTAqTc52QG1zn28yuXiNK+QWse0nt/TglaiA4olwvadGduJcNUTXpIlZHFJDJlBG/IbL6t8sc+EgQ+7BNdObFSPeAP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bJX4UDjiVg/27pxhi8hwNNJVm9pRTQrp4GgEWDokAg=;
 b=IpEK6LE1psBdQgXB6wp/kjAXsiLvAd/6rjy8xMlR2lpn0Fux56dOZ1+zkNlliylswq4RmdN73NFQP7WLxSktfT611YspZy3RrgukBK9vM+VYGTWTKp7CTj1nySK3/AUcmMyq/XHty6bdsXLXNISfGZXuE1vzqR/SnPbSF4Eb/Dz5JFn/WkAotpYcSIXs4DRzJdf0fy6pVxycfdPgTUAIyqS6qjhdf4ZMQFmjE/dPf5udPEICjAfQ+6cXesz99cv1nTcBnGvZdAiZYcEtF3lA+vQjfcpEyUuEQf9xGFGA2UJ1vaTHFbEsr5d9XaoCtLkXoxbjcuJvcIbgBKIPJFLuAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7202.namprd11.prod.outlook.com (2603:10b6:610:142::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 17:06:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 17:06:05 +0000
Date: Fri, 21 Feb 2025 17:06:00 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Chris MacNamara <chris.macnamara@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1] doc/guides: update monitor PMD mode description
Message-ID: <Z7iyeA_rjLVa-Ueu@bricha3-mobl1.ger.corp.intel.com>
References: <20250221165440.832528-1-chris.macnamara@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250221165440.832528-1-chris.macnamara@intel.com>
X-ClientProxiedBy: DB8PR04CA0020.eurprd04.prod.outlook.com
 (2603:10a6:10:110::30) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c24938e-6764-4ff3-54c3-08dd529a0732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6yPh9Z0WnPBKqLDZBHCIQJOf5quUgM1vyMQVSof5T3wDBX4uqr9/S4DgQQQe?=
 =?us-ascii?Q?dihiwKGe3kA8QIxpbeQwJUuZ8zriKwdYoZ+Z3o9sCcPn72FP97wcV4iOKdSF?=
 =?us-ascii?Q?pOpamlzYc4RYDIux+Bta699trxBqRE2dQjmknm1IJ1/r/+SXjtd6jYsxivzf?=
 =?us-ascii?Q?CWf88u2MRxePcPdcbehr8jvBcL+wEBz6dhmM68iZP4r+7avTCA3oYu9IeQ7d?=
 =?us-ascii?Q?4BP4+RwN+RPtC/3KdQenmtf/qmH5pGglrRrGzjp1Uld6SRevhFPOcday8YG0?=
 =?us-ascii?Q?zszF17aneyOInXEfdNWsUZA8DWqU5JC3g0rUJI/vr3Kjdb0W1gCMqPuNMKdq?=
 =?us-ascii?Q?ctkFNxjnRtlm6KBK39fOsp/7W3ABEu4xjkAcO5HKa4abJumdjNlKj3P2D5vY?=
 =?us-ascii?Q?9Zp25fNb1n9UHZOMS2KOuhIuJ4Vpflw49lGQKbRmQ/ZGxK7SSI64ZMYz0Jfx?=
 =?us-ascii?Q?WWBv4wbKgIuaEkBAYWLGQOoh3T6YOwGfhFWYnw4uSLJpz063486oi44Mu0bI?=
 =?us-ascii?Q?d/qhdtYImA6SJhPUqeTCwr7Siu/sbtq/YyMKnaDsjTz7FiO1VFiZEbUHU12v?=
 =?us-ascii?Q?GkVHbOER3hwyc2gTrJW/XPMsx6yB1YSajB4qBTMetmz8cQnmf+RcCRsraR+H?=
 =?us-ascii?Q?OMVQAvapzGRBv/iuHynrisvloCjlYaAvSUSZ5ILZRQJ7Ramvo0fLzBX4a1gx?=
 =?us-ascii?Q?BE897EBdVOBK01YH+7dk9epESXwCiD1uvugjPo39I2XopsUZeNCxuQ6KMNeE?=
 =?us-ascii?Q?FTqonBwJ7BbZOvPxepVllxt/UBLY3ZxfyCAyZ1eOfdtK3gla0HD2f4hQciIS?=
 =?us-ascii?Q?ZAlCz+DX75hHwTcW5R/DKz9sAfm94vhJmUU/x/JxYXNQHh45TLYhz442YSBK?=
 =?us-ascii?Q?g1VmMkVTkZZQK+Qi2a4MBZ9yVFYFdKbRnTtkYAqY5p7snO+tJ1ox20x2gxeC?=
 =?us-ascii?Q?WudN9iME98evpB8u5nNatyLtdi91x0yogq5kPgEhunr8NT5pey7io6npEz/o?=
 =?us-ascii?Q?KccjgzBDKnw3isyXyVdWAvlvLVkRfS05+voq+vNOyRQEQfqeNPyONtEi1HcU?=
 =?us-ascii?Q?DfU9pHN0+y2xWKkz+inRJ+Y05TpTB/bAPAs+GM2fe1EUhFJWeKohSYnQABEU?=
 =?us-ascii?Q?88KEkhxDbiI2zOXofh44l/vTjaexNfOkfyMD7+Jl9VK2EyKImRK+U8ra/zDM?=
 =?us-ascii?Q?zrAXIxQyrURg064rivYkX15O86ZwZx+nAR0bYsR0Xd3L2L24YVjWSrkVNe0Q?=
 =?us-ascii?Q?s9PViHQPUdiKzZsW9qzDKg8XD/+h4wO1oSHe/OGzfttHyvxOjvxv+iuVhFhT?=
 =?us-ascii?Q?tFGk+7KcI0ydo/+tZA7VxxPMiGrtX/vrfGOLGI1gf5ZyyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aRBm0YUl+bi3PdTrVXHo3XJ+XdG/Gko3GsBLdTrXodlmLC4cy3TkOu0qZHpd?=
 =?us-ascii?Q?ab5/lyo9hFEdYsvX12caKaEg24xfJmbY8fL720j7bgikky5hT86+/OYXOW4H?=
 =?us-ascii?Q?gjPEkZTSrbdvV1llR1yUHcWo+J4WnOVXnZUceTVHB9CGchb9xJ2NVL+3I8tL?=
 =?us-ascii?Q?hMcx/GOGk2CZzXMfC0VdnwO4bDNSScZDpzUP74LG/aqqfk2xv/DIebuv69rj?=
 =?us-ascii?Q?seskVgg8gi86rIAEJZg/TZIIL+1fZtNcDFAdOq8l+Vhl2R+PLx+nTdQ341or?=
 =?us-ascii?Q?9fRMH4txdk3cenhDNBx4pqmjEB/PScfBbs2S8h543oiRhl7QTCYH6cQJeb2u?=
 =?us-ascii?Q?RlfrQqD+fJMztH1MJiSYbP8npNrxzNa3ytlgHvGvBGfNDXOv0QUwnSRiVw4F?=
 =?us-ascii?Q?im26sYOd1wetDTIZkokR30HUBhtG+v7nmweggwJd0Fr53k+T5xDdmY61MJPs?=
 =?us-ascii?Q?y6ZkWDtDi4/CaVEmSS/GRWFnFzQLI1WLiBObNeFaEFMU5kYugOyA1wMRTo3r?=
 =?us-ascii?Q?i9LcGZCG/0vufIUzYFiYOhuQm+di25NYFfG+jQNKrW8KZ9XVyvqpHWpMDrTs?=
 =?us-ascii?Q?fIgqALbRk1Bth02dQKuiwdb/kPIk3BbkoA3EYmOjreDwaD4jM+puLImcWazC?=
 =?us-ascii?Q?+DnBXp/9Krc+5eX1NeYodKl5TOLik2TqBp84zCJpLDQOlWR/WwQ5I/2vC8Kt?=
 =?us-ascii?Q?2u2PrwbH3SigpBhHdCIuQBBXjBS/Urf/cDm7mkA6sd222Jca1tUIJfLYn98z?=
 =?us-ascii?Q?i6HoZIsxBUd1qlhp/uHPBh/X+AGufdOKakJOw5/txpgcrgm7h6UJODWThzrr?=
 =?us-ascii?Q?ww68kXI2fO7CiEB1VgLh0HJfhfPpPBuBEWIeokbe7pDcLY8QTbnI+lx4Z7O9?=
 =?us-ascii?Q?MLfMlUObDVUe5ZoC62mIP8iEBwsyL+px+Jc5VygWwgbj9xWObvKgRb5uGDJV?=
 =?us-ascii?Q?9ltNpuWd5CDLibX7MQZKSAVfYJkaL4C25Y9WV5gKpiO3fZiCxNJTcEzlkJ3L?=
 =?us-ascii?Q?2Yspun5ew6+regl4l8/wEOpcVnvxTYcNSAGumu12851K2TXTJb4MF7rA2kWm?=
 =?us-ascii?Q?gXql5EL6EbpW3Aln4ITupYtd7F7NPLYph2CwLq4PhnWESq71yGWFmzimVkML?=
 =?us-ascii?Q?UkeVMp0U5Qak4GKaVelTEIdHcsLXmCsl94+1mVRT0MvEhtCZFbin7ncyTzFw?=
 =?us-ascii?Q?jatoLuekryscZcyaRi3RwBrGhLpSkqQ9zVsO53nsG/zCZHeRuEgdUE1fjkhI?=
 =?us-ascii?Q?g3PDwXViqsP/noyb3uKPnsm5pR7r6sF/TzVjLb/YFmALkoPO7eknDr99PUny?=
 =?us-ascii?Q?MoVWNfq4dFS897kpRnNYXipET0ZTdYd4Tom/5VaEGbcyPlpWUcjSxpnFLZcB?=
 =?us-ascii?Q?6lCyHyGXY50zzACbdovhGeGPXqRvqVpiiC1A1MeD7IKigTsbVJVNSitHXn8n?=
 =?us-ascii?Q?gB5C3O2Ng+CWbivC2+olErDQwBYbP2utnpr0aWikSB7TcQrTkgd3NL6CUfn1?=
 =?us-ascii?Q?6htwo+TTKbSj37w5O5IR7C7f1K25aAOCNW1m/pADUI18xSZvXeK1xt21ZzYA?=
 =?us-ascii?Q?HDWalrEPnSLupakZV7ngDTUFsOsRbvEQ8yFKltfPZwyVnstuNWhVR+bGpDtH?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c24938e-6764-4ff3-54c3-08dd529a0732
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:06:05.7462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyiPjrH2OpjtrKXABgwFavevMqGkWKbqYbtrZgPMEDokLn8gf8+UesscsNTtit/hSHAgfc7lJWoiySLjQSKjEffBP/mB6v7QBBFUE0IIC/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7202
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

On Fri, Feb 21, 2025 at 04:54:40PM +0000, Chris MacNamara wrote:
> A recent CPU change requires an extra enabling step for
> the umonitor instruction on Intel CPUs.
> This is now detailed in the l3 fwd power manager doc.
> 
> Signed-off-by: Chris MacNamara <chris.macnamara@intel.com>
> ---
>  .mailmap                                          | 1 +
>  doc/guides/sample_app_ug/l3_forward_power_man.rst | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/.mailmap b/.mailmap
> index a03d3cfb59..c4bc38752f 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -263,6 +263,7 @@ Christopher Reder <christopher.reder@broadcom.com>
>  Christoph Gysin <christoph.gysin@gmail.com>
>  Christos Ricudis <ricudis@niometrics.com>
>  Chris Wright <chrisw@redhat.com>
> +Chris MacNamara <chris.macnamara@intel.com>

Minor nit, this is kept in alphabetical order, so your name should go just
above Chris Wright's one.

>  Chuanshe Zhang <zhangchuanshe@icloudshield.com>
>  Chuanyu Xue <chuanyu.xue@uconn.edu>
>  Chuhong Yao <ych@panath.cn>
> diff --git a/doc/guides/sample_app_ug/l3_forward_power_man.rst b/doc/guides/sample_app_ug/l3_forward_power_man.rst
> index 3271bc2154..d0af28e0ec 100644
> --- a/doc/guides/sample_app_ug/l3_forward_power_man.rst
> +++ b/doc/guides/sample_app_ug/l3_forward_power_man.rst
> @@ -293,6 +293,11 @@ and has three available power management schemes:
>  ``monitor``
>    This will use ``rte_power_monitor()`` function to enter
>    a power-optimized state (subject to platform support).
> +  On recent Gen 4 Xeon Scalable Processors the umonitor instruction
> +  is disabled by default.
> +  An additional step is required to enable the umonitor instruction.
> +  Writing 0 to bit 6 of register 0x123 will enable umonitor.
> +  `More details are available via Monitor and Umonitor Performance Guidance <https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/monitor-umonitor-performance-guidance.html>`_
>  
>  ``pause``
>    This will use ``rte_power_pause()`` or ``rte_pause()``
> -- 

I'd suggest this extra info be added as a note, rather than inline in the
text, since it's not applicable to all systems. I'd also suggest that an
equivalent note needs to be added to the programmer's guide doc, in [1].
The info is relevant for those using the library, as well as those just
using the sample app.

/Bruce

[1] https://doc.dpdk.org/guides/prog_guide/power_man.html#ethernet-pmd-power-management-api
