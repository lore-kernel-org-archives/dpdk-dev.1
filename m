Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D701125856
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 17:25:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BEA7410D2;
	Wed, 11 Mar 2026 18:25:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id A58664060A;
 Wed, 11 Mar 2026 18:25:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773249954; x=1804785954;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=FhX6rjfkQSsQS6d30sif128zYgvPP5gfbH1M8wynNO8=;
 b=binMDmwKAprItJvPTBN5a+1RuZD5MkE4bYTx8C3ydKuTeK+fIajrIQ1T
 Ee0IUmbtFG8q8nl0ke11Hld0dHKOHq85O7Hg+V4+7ux4wEFIVy6W+5rZD
 Q8DWr0kdv6FThWCglisPooJsVaxGSHIa5utvj5QXd9JB6hOQefNqmaK2/
 e5LBnXPhgqplz35vlBClI0FIPyDbTugb9hDCo9c9Csi8M0lyRbX1/YTvn
 nNq7w2jBYmZ1CdYyH7/mU3M/kxezGaFT6+DwBJTPvJ7KahS3jwRqYr6qb
 BEYzKCyYyFKu/sQTIlDyIKxXsVB5C+9NZCx7SYI7TBfZhI1kqp/F+oKBA w==;
X-CSE-ConnectionGUID: w1UeGsdbTrisJ73UY2uA1Q==
X-CSE-MsgGUID: RcnsKuVkSmaLBA5YmjMYIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74409212"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="74409212"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 10:25:53 -0700
X-CSE-ConnectionGUID: 4toAduL1R/C8WS5y4da7/A==
X-CSE-MsgGUID: 6FunPOKHSXqhkViTfEl2Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="218407476"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 10:25:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 10:25:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 10:25:46 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 10:25:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEWDAOsVfNncDCWHn3wbFWSTRUigOQNzLqMWHFSkycYiFOgExpuyglw0h6FoVO+1jzvH/MSSZG+sWUBf7RyX5Ol+Lr6e1BW937bdcsOhljYWG6+efOec0aqAMIRYwo3/OtzWyfPLvjfAvpicmnUny8vMm+BMFryOW2HRtvpgQnqkIEJATw6GWklSY4Cte2xBYBoKg6k6hRt0dj5P3aI63apkDnaKLMtt8/Ll2GDHaFPs5lBj1NxHtYAXp3dnp+BD8Ap1LdI3Ub8ddp8KmViuNJUi7lYfWFUtGbIWMK6/MpGMATLo8pTB/N795t7sOMaPrDjWwA1lu8QSVj+DawJtdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mai4u8+uO+5xzIMXdQtaDza/hNMpa0NLBOgCXRLrEYA=;
 b=RIme8ViGbzxpjS78wW1CP+8wVMIZ18u6nvkZ2wYgN5XNudkUDABKwtaOYBh14z1maK1vSIwWX7r8UmBvASJBKtjcPbgSBKdQXoYEiybkuXhVoJRsb71es3FCtPQIoRAZLZGOPrfMYFuzJoWLplohMOdSLIPaxuMbQJJ9QtcUvcWnBG3BUFMzAb5Dtb4hqBeKqbPvoC1G+XlWlfrAc5I8+u6DqYufYHFbAUMcREM60mNlvD9SDFr26Ju3AQESobE5e3KyNBzvkHspV+jOzq479+YXQpxHoSw4W9QJyVtl6bilqJZzpdN8UF5zVIoD3s7g04hf9628dQNlSNoq/Fwywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB7551.namprd11.prod.outlook.com (2603:10b6:510:27c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 17:25:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 17:25:38 +0000
Date: Wed, 11 Mar 2026 17:25:32 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/iavf: fix order of tags for AVX512 Tx QinQ offload
Message-ID: <abGljHFUcP7JeO-T@bricha3-mobl1.ger.corp.intel.com>
References: <20260306151032.2640579-1-ciara.loftus@intel.com>
 <abFg_-lDPbGSTg3u@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abFg_-lDPbGSTg3u@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: ca942e56-bc3b-424b-232d-08de7f933625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: S9EQPBq9Gaoc070qF/8okrr7iZxg9yjNowZ5ORUIacQm/Ar+PXG0kccQUCXx8ylKdSCEfXu0LoYi7bhGFVgOtofeaEzGaeVtOEFezFubtzJ3AmEiV/+clix9FJbx5z+IrnLBULQb6ZM7tupdD5gYh1HrY6hRtrPYYA+nmlEs0lOZnteZjTAasgZG4+Esm1uUJhn6Kt1cMqd54qgaEepZ2YS1qHUGw7pLDzccP0phrnSlU4+/c1Odoh2iIkQ3JjHrW6+fO9m1NmeKs8LtTFH6ei8B0y9O7CaTKDtMsXeZsXsKrjSjlRl71kIUMdLLUCbhYfrqxji3Z/Vpki5SIfe4NTN3JKYVpgXjwL/QwA0iG6hjQC66lGxkEIKOS9SXbLCPetjcoMrq8MOSZQD953JJ506ahN4FDK51Whm9nvPzhwPfnTat9GfaMZp4aR2AQizWZz9oAQyzQhBnnM+zXFegwAuf4qHrHyV0icFhUWcrOekoBSgBqyE2Gfj5CNEwLxvDFOPHzFBLEsFCtFTZROnYlz7kUAYbYvDDyQN0+PpUNcjosXBqzxYQCmW9JUnVjAbpbQjT2Gox/JMFK6GoStNR5annuy1qjopV5h1UQokjncwyGMEJwNI5/3q7i1Zd5HHqt1ymz3hyMS6EH14hISIg0H03GqSjY95b7b/OF6j7cqQ0hyG3spF054GyEgNkLsEgCGdG0xllF4jBdHAFjq7BwYJECQTKqPvuI4pSUoxSJ7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bLoLDXv+pAODGSfLnc4lg2+A3p+x3nv/zNa9QE8Uz9yzsraT9ZuL1GQgpGZ7?=
 =?us-ascii?Q?/uaGVU3OHxuTGbzVJUjQhF4sw1Ci6/haucFahKascCVEvlwi7dKiG5cWy0qg?=
 =?us-ascii?Q?nez9PJzgIdbwisJWia6YdAk4eSeYO8MkZ/MH5fRqQMCCZdo56dL8k496S7j6?=
 =?us-ascii?Q?WQ/3OoemMie63wJjWXfMFYETb38drlcBz6YWwj/mMOXRAQxO+1oekTynzocW?=
 =?us-ascii?Q?wGb1wXxTnAw0zteoE/B45xkbO3w9nGqnlVWItiPdHvLvGXF+IJhQ63VQDzza?=
 =?us-ascii?Q?Ttc1dhbhI3iGiWxLchH7wEBl285pu6bYw+pPAGU/FqT7uASVks8kiNoaZMCo?=
 =?us-ascii?Q?crxUy2GNUmmb+PzMuf8P2F/d8HrvYwbs0Mj/f6q7GJW61d082BkgyUwgNYML?=
 =?us-ascii?Q?03fVxMrxoNh+2OVdQKDIZDCWLOqyvypXqS/R2z0Owsu4TANjHuoLzPyEVa/U?=
 =?us-ascii?Q?0ft/3ULsx5eCrjAqMjJwPEeZeA3oWzQ9PGzo6NPV/+zANabB7OXQodhFAPjr?=
 =?us-ascii?Q?Lc2zsjCNOUvlmloEN2KDeE1lRp2xk1sTqh7eA9LdiNTwR5xx5KuOfbMO+jC7?=
 =?us-ascii?Q?qXnIKVbBMprip+C5vF4ry4LMg23LrvwW+0bjAteXC51b8htl3WwxIZa0MJyZ?=
 =?us-ascii?Q?SC8L+kwr+RZaNR3sOKUSPBp3qXhVZgGAIt9afWeyPOo2T0v5brTyz8ZGQBQm?=
 =?us-ascii?Q?r3IrS2Ylvg1JRQqROj43j58p1Lx2lFD3MRo0VTQGuaxyxmtCmM4LHzxvdkzT?=
 =?us-ascii?Q?SMicmokKfWrjOnUd2FxHnmSJhzQELms/Jrq3p7DePNBuJumE6L2Ps7Y4Blas?=
 =?us-ascii?Q?MTAkmwWKDXsDOakfCphr76X5DmP3NSkQXzdqurMwkQx6V05eYsShnE3hpk4j?=
 =?us-ascii?Q?fLPoQmMm/L75Z1v7dW2+c/KnmLmgRtZZfnLTqozA4Ecl+72NRdX3RHL9SMJK?=
 =?us-ascii?Q?Rm8ZY//GCvy0NA8JjQFf2oa/sNmnKusoXiLJLosfgNoj3HT3Lzdd/JPuX3+6?=
 =?us-ascii?Q?/1GgWoamQttlfBGVlITWF3oUiFFWVA9Qn4lfc9NEhIKG2gY5GIU7vqFl8wQ9?=
 =?us-ascii?Q?pIWUcXgPl7IqcPyuvPdEydeYeW4IG1gsGbVNI+SDvBhuoyKesLS1qsQS+67/?=
 =?us-ascii?Q?2FOK9+vxfEtkDIlNcu05vQBnUQhkMmIHhan6oU5bc0Pg62sJxTImkGJUvRUV?=
 =?us-ascii?Q?SSFdmuF+xM2TXqLuJcax+0E2LDnJ7ZHn0/LoVJjHguFl5M3fic5rhDOi8m1S?=
 =?us-ascii?Q?fcW/EaDxV5el94SB3866ZYCHdnER5V0zFH1kJhTjatGl2pKc/ZNPL1CwUrVM?=
 =?us-ascii?Q?e93zdP7JmLKbvtk4PU1N6dYnj+9aIFVUHohZ55FkHY3DedppzbOjEhBK4shB?=
 =?us-ascii?Q?pzLECxaHYxr885PoZzOzcXJTfpUsfSSuq0DbOON1BTFLeQ5VPROvrBJj3VZ4?=
 =?us-ascii?Q?NtJ1ZW3Oi0TJVNuDHdEe87a2CRCsIK1IfVJs910zhvvJxfk8Czh1ojvkA/M/?=
 =?us-ascii?Q?iPtH20DD2MRgFpqxZMgNq7ytm2G7G9VoCNWuHKLcbs8EfauasTMrXKN66g2c?=
 =?us-ascii?Q?N6DinKFh045hQCiDYGLkZ8A9kxzlcWDcTJygS8QldfVj1lqXM0tIi7BnjYko?=
 =?us-ascii?Q?Cd64JXitDq1QucPygylr8cMvcfBuVBBX6LxHY8Q4Yb7oaqR41Xy2092Xr4es?=
 =?us-ascii?Q?ZC5e0JAm0AkeG9EjWOAq7TRp2Th+ThbLH++m1/SvL4vYmCuA18O8WD7RtETL?=
 =?us-ascii?Q?h0mb+W1WhAhnMPtlMHDPK6pjqYc0UGg=3D?=
X-Exchange-RoutingPolicyChecked: B9lBfIwD+Ao9Ax1qArCMUPfArbRJ5FrvTtblgYAK++q1/x0Ng1DeZN/JysdaRm6LFcWr/CowQFjcaCDcdpomv2ulsIrzxW4sNMAtbgm8AVibZn7CHskzhZyt9yRwqwQipVCaNqc+Vz0flb9D4kKufI7BN3jI5XLydCQlIT6j40GXtO2FXL70pO9hQajQbjwxudF71J37NsRp6PJcyfE/6/17ipx8SvXNa1d3WCmW+Yyj8u0aCyBIiK+ifDPVsn/s7lJUXC8ym4yi0Aav2iWVtNGxQLTQ4Hs5+V+mWAnX5p00zizON1AfRNFSoy3b0UUZGCeUKotFubeRSXQctBWXCQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ca942e56-bc3b-424b-232d-08de7f933625
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:25:38.2070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqe8U80QMwse0llk670uLpqB/qx6tdSYk+TZy5FUTOJDe7bPvAE/WDLDDL3Aff3TRM9wpOkRib+5VGhPmq/OjZumyDQDTt8setaZlj0PwKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7551
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

On Wed, Mar 11, 2026 at 12:33:03PM +0000, Bruce Richardson wrote:
> On Fri, Mar 06, 2026 at 03:10:32PM +0000, Ciara Loftus wrote:
> > The tags were not inserted the correct order in the bulk context
> > descriptor function on the AVX512 path. Fix it so that it is consistent
> > with the single packet function and the scalar path implementation.
> > 
> > Fixes: 23ef9b485dec ("net/iavf: fix conditions for AVX-512 VLAN offload")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> >  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel

Thanks,
/Bruce
