Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646BCD2E038
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 08:37:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADF9440156;
	Fri,  5 Dec 2025 09:37:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id A490440144
 for <dev@dpdk.org>; Fri,  5 Dec 2025 09:37:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764923830; x=1796459830;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=q+uM0TBD6NJ711Wxz8AZDN6JWn9UaEZv7kz8pg5dnAs=;
 b=Ey3SodV33QAjo1ex4XY4RTYHBdbGbsvjxanfzEJRYtiOJD7SADRYOECE
 GIKufiz0xYYeQopyCfkbGDmradrtit7TMKJJXhJx4Aa9Icu1Z/SPrqYzH
 /248WkJ4AIsqCyDtNQLGgqAjSi4A8+PbW+Q/IiefJatrwijsWyR/z28nu
 dHhXdeSxBqE+0qEYK0qwnQUiGfCFh5UJk+LWi73DeDTIWa9he111Ty+IO
 hxAfd/vCBvO4GUkL1sbVK4uTK8LdIiK8p2RYhC5TCrJ4n9M0LSu3y9wp0
 GwxFAz/TSqdEccg7ZeVa70pyvI+HxijqfbgNC7FfuQn0lNml00E2dvLZd Q==;
X-CSE-ConnectionGUID: RSsYqR4rSmqtEhKylpqeUA==
X-CSE-MsgGUID: ag0uVc9RQJaffuc1SKodSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="66678903"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="66678903"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 00:37:09 -0800
X-CSE-ConnectionGUID: mqnuZi+YQa6x1RTzZKKRkA==
X-CSE-MsgGUID: 19ug+4vpTqaQn+jiPJcMfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="200192594"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 00:37:08 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 00:37:07 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 00:37:07 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 00:37:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USINqKkwPY24qz033xDwmboPcEsDhCirO/K6ZgyGgdq0ayWb4cc1fvBkhErXhdD3C8AVyvXkGWjCHNWRuwArf/OGzMPIVCc504h/ma3UnP1sNuQuGEEFVIPkeO/nnCadfo1VhXWz0+SF2fvzeT2D77Jxn75daZTBt/b+mhxaK31zo7s2+Yh/OAWzg9MwNIlruXyNg/zrLV20qntT24165Afmx18Gxxn6A4yA1aj2uitHl31DGtK9fjzOvmS4MWtwiGoDL6GxEy2Tw1tFHwpEWb8knc/gV4v+PrCV/hsGJYkvhZInx/lQCYI3DYXc0zDShNCHVva98+JA77uPbABmww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oscSIR4TmAiPufAkwiksX/5k6H2vqQZEizl5EuJH5dg=;
 b=cxRiXQR2JSd9w5BLXmfP3mueE13v5JC1ug0gwe+TTup/NEfaxRr4bjYYqF2VZyMMcj1m6PPOMNr868s8ME2MCUMgLXNHFS3YicYHR31yYFcxy81yWiFnDG+VCOSAiSr1n1ore4i+K/oAGWfxGSC+pWQmcoTCWdozsbX1feXGH8KyXFL8lD14kQDSuLp9X3PvyLJYdM+rgeEe8Sebhdkgfre0CavfGqGYI9Ml5I/GS/5OTtVbqJfC/EoQ9UY7R3TTmxdGGdvFXOvHg+7ZHjaeHgULXjkNn5VO1ImOohcvLsysLP399Rcbpt2klxnfsP0ueQBi4NIWueYklyt8uuB6Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Fri, 5 Dec
 2025 08:37:04 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 08:37:04 +0000
Date: Fri, 5 Dec 2025 08:37:00 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC v2 10/14] efd: avoid overflowing ring name
Message-ID: <aTKZrPSTuLvfZRkg@bricha3-mobl1.ger.corp.intel.com>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205022948.327743-11-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251205022948.327743-11-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0027.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: cc999161-8b43-4ad1-e534-08de33d977e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?daFzdzHbNe37jhePKF3dRY9AJa7p517pHXG4RIewyLmgWJP6n3vFpUTuUnKh?=
 =?us-ascii?Q?rjdzRuB8TDtkvirW7VpNNiq/aP8i0l4fi5ZAQ2z28Yvctrqa/K4ZgOCDUTTo?=
 =?us-ascii?Q?Jz5AJ2Kmj3DB7smpOMuxGmFG8bpUm/AnCOOoXz2kEMutUBD0hdbepw+MTQ+1?=
 =?us-ascii?Q?R/drkz+HHjSd4r/PTwYXokP1zRcEFgl4A0RPPJ8qS5GFDJNOMU8eMh8u+jy5?=
 =?us-ascii?Q?Atosgaw5E+FUaT9sZ9taZi+mEO3xyh2m7lOIxx1S6zlsucpxEkKm7R/Gs8uS?=
 =?us-ascii?Q?SP1yHQPKQLmGbbFvnk3g42pkmH/IK71JeQm/3a2hVeuApqDev0hvsabmVYnF?=
 =?us-ascii?Q?VTxqwgiv0tRYg4Y6qcdTEs7qLsTiWtxOUqnoY+tmKIRWCb5HYGGrzYwfDIbb?=
 =?us-ascii?Q?0pqemEZVAXDZV1ngBAUCmPHA3T9wqFUy1p/B+tDv70z0X4AQZ09xhG0jFKgf?=
 =?us-ascii?Q?1JtVqgoczRyqtTkeOiaVK+jDky1gFO0rbF5tURpjdKpcXOi16Gb3LR3b6UQD?=
 =?us-ascii?Q?Izn3lS5ugEN2o8TKFGVaI8xoTS2HH/N5re+RB60OgWmJ2qO1vQ3VGh+bkEYx?=
 =?us-ascii?Q?C5rRBZNE7DtwWN3QCRmXD0+1qd2wtkAnsCPji+UbqtDc1Tjew1NvmcilmD69?=
 =?us-ascii?Q?V+W3LDYB3eDG6M2uC6qWQ2RYaip3Q0qN4qbmv9PABI1cg6XjyHcb6GPUg5uh?=
 =?us-ascii?Q?N0SgWyZRYkjXtbiRaSW1aGcpV4jFbyUHLiKX66jKa9XSi5Cl2XiOAIlecU3e?=
 =?us-ascii?Q?N+nek5GaV+r0pWR050BKqPPYVvhM08sa7E4qhe2Eyql+zbGkg2jWZM+M+6/C?=
 =?us-ascii?Q?fk1yBRwlLQL0MSQW/pc5RApSZ/GPBPa04tHL2Qm7CoIiA7XKwfaW0kY3t/5S?=
 =?us-ascii?Q?pQ0MpcwnbsUyUDXMOFgXFCTxdb4qVl12O5RhExFTaAGilDi3vX5HZ421H41s?=
 =?us-ascii?Q?rBa9lSDwddX+CrDYkiyjJUyy2AWRAtgsvqJRrNtrbO1UHVrF2IFMDpBo5dPr?=
 =?us-ascii?Q?bATWgWU/6xbMkhU92mkrefpNcXwLVmorD/x/OnFp7YqyRa0JEZv70mrbYOtx?=
 =?us-ascii?Q?xeBUcpHgrbEWhAwq80WSuPOntn7cisNjW7Xz4XMVkT353ZOc78FlJDGfsBeC?=
 =?us-ascii?Q?RLONWUpzwxk7lBk0tcHdoojlfvCfKnImCQ+e6XmI5jja9niIiryvMDvWzgk7?=
 =?us-ascii?Q?VK9aTo4SH6VCkUftsJXQ9xYnYcN1Y5WAB1BiFU5crQrbI04iYf4lVMZhYqhX?=
 =?us-ascii?Q?ceXTxIPVvmepMYv21db3UTJ+pSkdgWLbT/CbuxcKj9NFtb5T8aQKNzl9S9e9?=
 =?us-ascii?Q?b1ZJ39R2deSzrLYAoQa094QSDNOWfI1YNSDP+ojCMH1OoZnHf1o8JJg2npDK?=
 =?us-ascii?Q?FT54fdDqmM5bcujYotU3YemZEDL4rBls69yWlsecXn6oJefC0WEBWomXa1O4?=
 =?us-ascii?Q?gm1p1grb3HLT4/1iVVuQy0gj/45acS8S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DQIseSq4BxDUk0EXTvy1KjCnY97JdVw85qbp/Zp4130butXCegr3o4mbNY54?=
 =?us-ascii?Q?K+VxaYqSrub/gKkQPIXlwW/vnB0b5xOfU4cNvElyVls507iUbCDjWOgyXtSC?=
 =?us-ascii?Q?8epQS91wgNTwXwzNTgFicCbyOT+crCAebIukmdNXZsHDXD2FCB1TJ/Tk1jL4?=
 =?us-ascii?Q?wOcRK8XsVPNo1K0mEsfkSSJUGfb96w6n0jt2B/bjA+thn4nvoW2zDQEcFO9D?=
 =?us-ascii?Q?3jazCEBzqbuDd8Wk/qOb6/0UH8TZAiAPbmMo3qvBy7oGNAblDwFKmz0+kwXg?=
 =?us-ascii?Q?zMzj6iMhjD/bDSJbtIW+RVjYKMOa21HP7JqLbcqhxa2GsfJl70vEwsa+/Atu?=
 =?us-ascii?Q?h/J1qD0BDR61Qbh4Xwdnf2xXwMH/Ytdp1nyo4gLkN8yDQdJyvqtQTVKaCaPg?=
 =?us-ascii?Q?iEwNpH1xWuUTySTDPfPLWsrt7N0JmHGLopM5n/kmPYylC/dkv8KnjCDr7abB?=
 =?us-ascii?Q?T8yfXqQ5VrBTlJj/03PBg/rHJwc+FfoaneVqiETf7aQ8tUkrhmCW6wgsKRU1?=
 =?us-ascii?Q?HrnI9RjdHb2osK0s0DX3vBrIDhkU6UtYaIgtzktjEQBxU5NoHNszUi1Ix69u?=
 =?us-ascii?Q?QyhQq2Lj+ztTz/vZG3DrdHwl2biT/gPVeLBwAOp5fu4Pg4Csr07EQzUQwrMg?=
 =?us-ascii?Q?XkMNxgwLzOiOBbF87UYiOnfQdEVimXEZvDMiGa+be1dlJtUt2PLVeQvHt3A3?=
 =?us-ascii?Q?3fukX2f9h5JdxqRwaMIgQC7X5EPvhnwUFJBQPxs05XcAk4dQle+oDBPNg8GA?=
 =?us-ascii?Q?6JrbORg8hxun2CYYiVjvU2NTJ4brYLaQ5d0KnHrfn8aSNSuqIIwMVUPjuase?=
 =?us-ascii?Q?VxxlHYl4IHqhy75vjehqEEHRV2sHttZkLFrOyxhm174ETqp7AkVc17FO0LCu?=
 =?us-ascii?Q?5yXWxAbN0ifU2+GJUOF3tiJoCsgY61J35evHuzII6+vtKjD8xpfDIhnZaiwT?=
 =?us-ascii?Q?UaR92nOjlZPpVGrvxdGVCniCZC/4MX0++ETMqaw90AJDEDy1cUxSUryy+e/4?=
 =?us-ascii?Q?+fDOzLFhRy8NzcMqVI1MPWhnXIbO74FfrvldwuJTpRGQjQfj5kPmpb0A8VWK?=
 =?us-ascii?Q?w4dw2Px+F8hCi9leme6KGk+hD/B79oo16SVhX6cjjEQvaqRpwd0CgXKgcHUV?=
 =?us-ascii?Q?haJbyUNd3YmhOTyCO3FzRDeO23pPkUjEvxPAsN0Y/8PhJYV7SheF13Ia34iI?=
 =?us-ascii?Q?nW12Xli+Ve+Yymo7A9ltppcTMjf57H4qvzMOEjiMTtPzenDldN6lMPTLNeRE?=
 =?us-ascii?Q?GKh8BCDWsFb//TNso4dtoxbkJBPIrFngdkh4wh4TNuPxE+t0LaaiaZZz26M4?=
 =?us-ascii?Q?Loc1bdsSKOl3RbJraQ7unU6A1bAoO2D0QmU9p/5MPAUVHDk64qBb48irRCgG?=
 =?us-ascii?Q?9UJOX2kMrwOCoTKLo/YzQhF/cSbeX0BAYrEHFm8Iohxh5R+GXzyRu183YdZS?=
 =?us-ascii?Q?fuoNXOm0xrmz4+Cn4ODXJ02bXJx9/hTg/jLAj5iYK4ZjATqlb9vpMJdnKE60?=
 =?us-ascii?Q?bIiKrNGJLed3G/pcTcseU0Z3falMKQjLAkSuORSrIKwYX2EpGmT1DD4RFv23?=
 =?us-ascii?Q?5w9fIGjiGqdDdT83O6MJaYDxBbP9mLanltyqfOqB0bQsg6Dhf9FIvMsv9YFW?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc999161-8b43-4ad1-e534-08de33d977e5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 08:37:04.7794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fT3loJ3gkIJbWF12G0uLy7ongugbD64NsXNohOzTsZOozp0GSPlRm/D2dqhmTjzFrF7H2SkB3TWUPHznbuaA7omK/ka+/rfxDHoZFcBaddI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5782
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

On Thu, Dec 04, 2025 at 06:28:19PM -0800, Stephen Hemminger wrote:
> The efd library allowed table name to be longer than would be
> safe when prefix was added for a ring name.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/efd/rte_efd.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 

Again, not convinced that truncating is a problem here, if we document that
only N characters of the name are preserved. We can warn and continue
rather than returning error.

/Bruce

> diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
> index ebf1e0655f..b4ea8fdf33 100644
> --- a/lib/efd/rte_efd.c
> +++ b/lib/efd/rte_efd.c
> @@ -36,6 +36,9 @@ RTE_LOG_REGISTER_DEFAULT(efd_logtype, INFO);
>  #define EFD_LOG(level, ...) \
>  	RTE_LOG_LINE(level, EFD, "" __VA_ARGS__)
>  
> +/** Prefix used on ring name for hash */
> +#define EFD_HASH_PREFIX "HT_"
> +
>  #define EFD_KEY(key_idx, table) (table->keys + ((key_idx) * table->key_len))
>  /** Hash function used to determine chunk_id and bin_id for a group */
>  #define EFD_HASH(key, table) \
> @@ -527,6 +530,17 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
>  		return NULL;
>  	}
>  
> +	if (name == NULL) {
> +		EFD_LOG(ERR, "Invalid name '%s'", name);
> +		return NULL;
> +	}
> +
> +	if (snprintf(ring_name, sizeof(ring_name),
> +		     EFD_HASH_PREFIX "%s", name) >= (int)sizeof(ring_name)) {
> +		EFD_LOG(ERR, "ring name '%s%s' overflow", EFD_HASH_PREFIX, table->name);
> +		return NULL;
> +	}
> +
>  	/*
>  	 * Compute the minimum number of chunks (smallest power of 2)
>  	 * that can hold all of the rules
> @@ -698,7 +712,6 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
>  	TAILQ_INSERT_TAIL(efd_list, te, next);
>  	rte_mcfg_tailq_write_unlock();
>  
> -	snprintf(ring_name, sizeof(ring_name), "HT_%s", table->name);
>  	/* Create ring (Dummy slot index is not enqueued) */
>  	r = rte_ring_create(ring_name, rte_align32pow2(table->max_num_rules),
>  			offline_cpu_socket, 0);
> -- 
> 2.51.0
> 
