Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C29CCD195
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 14:32:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC22240E42;
	Thu, 16 Oct 2025 16:32:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 14DB74026D
 for <dev@dpdk.org>; Thu, 16 Oct 2025 16:32:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760625133; x=1792161133;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jqcDglsvZAlGghavjvnChNm7mcn2R5n42L6/0eGm6X0=;
 b=YCtVRCbTv3d3Bg2oVKm7ALwuukmeD963pUPwZmrvrJOPs2Pen2doG+4B
 wopnPTDHNE8uy1Fw2bAd3Ga8TJU5GAPyUnAlZDLVdxhXESAj+Kb9c30PL
 pgKRnfJ2Uddjr7rqiuMjKuzsjeGa4ngu5ECeNeQ73TuS9y4GNLIxdHMux
 fi4SqEleBBYNz19VOU/ratnoXM2WwL+0FyrRTT3K5SgnAm2OaHZhYjhu+
 HaMqRxKx8TEwkvORyvddm7fd/elHBbGS4g3wkNu48lRioFw/o7pbMKO7k
 SHmaYgrRGU2/K1nHyraUwe9KR3G/JYPL0ytyQ/6LK8k/Fl3POpD7cwOlc w==;
X-CSE-ConnectionGUID: O56nlmdXTIWH6dVkLHKLzA==
X-CSE-MsgGUID: Dglxn3GDTAyrjBuTQFSX7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62912621"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="62912621"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 07:32:12 -0700
X-CSE-ConnectionGUID: 52QHLLSxREKRXH16mTz1yw==
X-CSE-MsgGUID: 144OBbvCTkCs5w0HzMu4mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="182442720"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 07:32:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 07:32:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 07:32:11 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 07:32:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnoEdo+aTTcB5wRm0te0ldk1WHrlp1FmcZd7OuZ2dbYUlMU0HAGyLOxvukEXbZXmaDsuDVYFh9c72eEJMRxi4rrlFvg0SYJerM8idYkCtBe91tEK3Jdsd8gI8hxD7doB0Scq2aDiVHcA605kUKY08A6q71WcDYM52taK13umXU34bdl4KcR4TW8oYzeiHDBtwi20qtOatdSLzH7djiSe+CXief+iyViBEAGAIemrXwCGlj4Pr7FwjtbshBMbgTdyS518DyzEAWHJONaLVLWZf5Q2vXDtoGBe26V43sUm+uYEuLIrfWnysJS92AxoE2w8i+JOT9cco/BKJHVuFOBmKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4I8s5vBZMKHXrdwV4XXkGLQ8C3xRmYLxbRX5N5B6Qo=;
 b=odRT0EsI0XaZqq8oPd3zzocq+AiD29qhNz7QxVpJdJfOaOBJq31BBsR8SphUpcogJzMUelr207Wjp7RAsCOjZ12XqkcmJ/WHoGO+zIpVdG0a4zQr6scX2wf14joCZmycGH7rpKGHxP6lCRQ7xadsAIoFF9fc8Rh0uRb4Nsm4Un9xb6FE/Qti2ymu4Ej2tmXmzF+0y/ZgbCWBZRxpWfqsFmfbzeJZolmuG/rv8RM8sShSentMONJj7xFESnNCCb+80+35xIewCGNvG47WhFdt28ewKi24H3G8cUlnu9fyU3R8Jbf6P59OBt+wywduNLXz19Iipoaz4HON2Mj/kcjgwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PR11MB8684.namprd11.prod.outlook.com (2603:10b6:0:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 14:32:08 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 14:32:08 +0000
Date: Thu, 16 Oct 2025 15:32:03 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/iavf: ensure no polling during VF initiated reset
Message-ID: <aPEB41R031lSxlKp@bricha3-mobl1.ger.corp.intel.com>
References: <20251016113224.1652880-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251016113224.1652880-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0336.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PR11MB8684:EE_
X-MS-Office365-Filtering-Correlation-Id: e37834da-a924-49ea-abed-08de0cc0c8f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rxPpH7HLVjq9hJ6C9/62yc1A2kQdhpdTsOs6OVCgw0G4tNv6RKfP8fGi9l4i?=
 =?us-ascii?Q?AkIcwbsr9T0tosnMETgkbcEc7J2uXVZx2Awqfot+09FN3DjCHEFdZ9FlfTI+?=
 =?us-ascii?Q?3BdzpDWLGCvZDK9qCGDMfWBRkpf2fnMyM7/AihPip6AEGHDaEabqSIWbZId1?=
 =?us-ascii?Q?XiUEefy0mekEUz0KQP8ZsfukovFgR1iG+sgBmGv+CFRIBMx69CJ6vmT8RRY6?=
 =?us-ascii?Q?wzBdNBxg0BPwvmJpGHKjfbF7Uf4QkfwmPdmHop8Ubhwtehyslmv967rLJFue?=
 =?us-ascii?Q?Nit5NIlMUyrqpMjQu5efN5aCcLnEEZ713HLnz5nGyynHPqik5OdksB5vyCtv?=
 =?us-ascii?Q?Fsx0iD1b1Rsekgy2JExTtJED85gRrNLqF5c/0fxlc4nbS7IeFi54db8fUqPU?=
 =?us-ascii?Q?dLAhmBqeiPxoBYL+GgIvYAyfMtzEYtaQNPL+ZE6UVYxJVrvQ1iKLpBPq4k2h?=
 =?us-ascii?Q?U2ojtV5pHLqLrdZQD9rIL5HWjSBxCbBPeipZOroRxItp/D5u2cWpVJX828zl?=
 =?us-ascii?Q?PqYfHUbjWGAIRyk1Uta/VmrgUzRY5hU8zADa/pUYBguA866DpXUhO6AmAmz4?=
 =?us-ascii?Q?4CmcHxSd5XnUuRmJte7/JXlTAv7gC+T3C8wdV45/GwpWgNhpEAgHsF2apISK?=
 =?us-ascii?Q?Zk+mEw4X1eB3ctCRPDWCqA/XppG/73vGZq5Wm591fhtd6C2aRNGpMVnbuauj?=
 =?us-ascii?Q?l7C/NLAnjO8HyalZnyR3rFoe/61n3RV33NofFHdl47p82Ldp3a1wVo6m3I5d?=
 =?us-ascii?Q?QAdS7jzoBsyzXpTkO1TuV4Kcz00jIDbBOeq5E57oMgXEvpqhM8a0jzzbusEn?=
 =?us-ascii?Q?E7ADpSmxGm19BlsilNsgyl8SbAKlOe6Mdg+EPU9LLnmcLCRiqdYftRZnoJwI?=
 =?us-ascii?Q?bPK/2sdlWcrybcmw0hx++DypotzjHODQ+zG1jx4Ejkxd8KowXKx5dF78iGUa?=
 =?us-ascii?Q?H//WPLiOKVzXdnQTijSBLOhTy6WbNONq3azPWdymGVOmC+jkjRlBCrJjYrse?=
 =?us-ascii?Q?0GxiayFA/cH9qCzWgJLWXhrnI8RMXDb+C/qhdq+hrhlH+cbIntOojDQbo6Di?=
 =?us-ascii?Q?YovfVmU/Ibm2QumBm4XuyXENXQTM8I5QZ8oLA6dgEIb5x/qljQXLSDKOKOzF?=
 =?us-ascii?Q?RkJ7w8S+xoEBEcIjQEY+XK8CNfogGsusWBaMlje8SL5rTlmwooXMbRuEOgeH?=
 =?us-ascii?Q?Y9mkWkT2S4A6V3H26rqAqYnfB+2v0a42cXOy8vlAdjXfU8cyiZAQc5pGrhJV?=
 =?us-ascii?Q?xo4bqrah1XlbkqbhDgczkUDDADa5o7XcqUaqUV0/+urpXHQONNYJeiWvYJnK?=
 =?us-ascii?Q?enjqqFFRy3V8Ksu8KHcIk27rHNdxyruWKCDZXVxn8ylykacOrndFpQwDwuXS?=
 =?us-ascii?Q?/dLGxP+ICu2P9w204rFczY/3ib2NoQuMHu0QCnft03xG5jq3y9ds6HlsM5Ka?=
 =?us-ascii?Q?eP7ylh4+gmVGRa3wU+lXWQ41Y58ekHIK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zuEBifSqleEoPStF1sJZtriKa+Opn3evuFVTuPoipLsy+xtOj6wQ3+EzAwjm?=
 =?us-ascii?Q?qULe3DGEVyLTIp6BYoasq7o0yQsTwtoE1I/5+xYEnkIcNtto2ExFWMPLrwUd?=
 =?us-ascii?Q?Zk3hF9U060uj/1zb79sP6zywJ+3mETpcovrilK7zdnogTMXuMPGrZnAOWOh0?=
 =?us-ascii?Q?Y+5XTk69dEvdR0uat0KiWAPQzSoSXo4FhKAs2Gb+T9H/1AeczcmmvbiOFvN7?=
 =?us-ascii?Q?JK9HauSnBi0GNofde8pkGvIU/ZW3GAFVCfxfDY8L9yeOGQdtSkC5W63ek77j?=
 =?us-ascii?Q?A/lwHRcjQgsDMYXvwygUmUFKGe93LbXTB7gaZOWqJGlTUvrMv7CiwMnQla+R?=
 =?us-ascii?Q?pmBVy7AKuPHJoKCOMUi5HqwYhiih+nQJa7SvE8UsSykhS+RSyh3a4Q3dhK2C?=
 =?us-ascii?Q?y63lnwbGba+Yk7VwN7pKZl9LBfSGjfoh96nQywGykBQgIApv+Uxfu6xu89rd?=
 =?us-ascii?Q?3CB3fEnwKLxiQ3CRjqvixrH6ac9vc+AtWR8WVRnOQ7zpwwbQEO0+WJPNe8gg?=
 =?us-ascii?Q?HfHMBJbD279nORqkSh3kG1DWGAaUj/iv5+hSx3oPQHCjh+MpfN/1uEtiBpjU?=
 =?us-ascii?Q?hn2qp2WYlEsi+53tY+9Wvpa/YDO2cbUwDpqLcjHegCJcw6Sf7ojKuh8tuRkI?=
 =?us-ascii?Q?mj87QJiAQdy5qbUAHzoPHTb9IrAD081bJ4xaLdDyksmgPuKIERL41H9lkDoe?=
 =?us-ascii?Q?H8YQGA6M5e4LT/rpDplu78P4wVPhrSw69oHWEsnyeXSd4bbw07alIqizJ6LL?=
 =?us-ascii?Q?dC+KfaYwOkdf9ZTdhWiEQedt+qH8JK1Rl8pMSD5muVM8/ZeWP9f16+CAdMQ4?=
 =?us-ascii?Q?j14b3v2R+fH+1TiMbpF1gs+FPiiNIJoRv5/fwaQRmL/z9uJKuBUtij7gouxp?=
 =?us-ascii?Q?oYdKEGcCe+dqCKT/dEwPFBVMrizZ2xZAfmljEPca+yQMIe0A6rF5/kuiEAFo?=
 =?us-ascii?Q?s/L4i0Ug/IA1bat3myYiSzI9fP9VRh+Yhz34fOa9AciHtA4ALKdsdRF8F6ed?=
 =?us-ascii?Q?79RZc3kbt0aww4RsduipMkBWkE8G5wem1GNwZ1hvUGJjrZACA6Dy8sF63Xfz?=
 =?us-ascii?Q?2hriGre5SzpfCbiJjgHNxgnkurvnxFt/PPeFr39BBn/5qcLQPh1yMX1Pauy/?=
 =?us-ascii?Q?hH2fUms3z9Sl1F0cwr/jw22XRASX3vu/UYWeIv1D6IHi+xe3meSP6CEZ1iOD?=
 =?us-ascii?Q?fshsFuL0YdgcnuDAUjukIA7U8dK7CS8f2bsFB6dXlovHrHybVSM0Ids5wFd8?=
 =?us-ascii?Q?wQ1Qjyw5n246RjLQbFiQwA5RkSLytPBlA7tqXegJgBwOTXX1S16CWrVf2zuF?=
 =?us-ascii?Q?dYeqI74fADHGcag7/HayApKR/9XCCV+UwEBVdl4qkddhowZ/3s7Y/1k93EvY?=
 =?us-ascii?Q?EcNDH54sh+otkohiEZV1KGUgyIlNerOlfsT56ZjYFg9otV+r8FP4OAvpV8HC?=
 =?us-ascii?Q?kbuPgiRiPQOP5POWoCMFUep6vHPI12IgkXLYiDHmR2ddKuPjB7VeFoj573ra?=
 =?us-ascii?Q?ehXDWyPVg5P0wxyvinchVZD0bRuPlEoKHcb2B+tgBNCiI5r4ITU4SundFZBH?=
 =?us-ascii?Q?89ySkpTJDrbsr+f6u3eYjB8OHktSCNOc0n/87iQPX35V1FFQmVj1cmBQLLJ3?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e37834da-a924-49ea-abed-08de0cc0c8f1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 14:32:07.9865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEGFJuyu0YmV6L2fz2m94ur2Rn/VN2nXhWfxRpe/tY19seYknEJuTaWKD/5UiHLH4XOUb0GfdhFd6P2b0VEQlwtOK4jD79DWkFKXnu2xQf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8684
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

On Thu, Oct 16, 2025 at 11:32:24AM +0000, Ciara Loftus wrote:
> Ensure that the datapath functions will not poll during a vf initiated
> reset. Otherwise the datapath could access freed resources and cause a
> core dump. Achieve this by ensuring that the no-poll-on-link-down devarg
> is set when trying to reinit a started device. If it's not set, suggest
> stopping the port before the reinit.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 40 +++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 10 deletions(-)
> 
After discussing offline with Ciara, this patch is mostly a fix to the
previous iavf reset patch, which is not yet pulled to main. Therefore patch
squashed to original commit on next-net-intel tree.

Thanks,
/Bruce
