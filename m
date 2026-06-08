Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2C0CD8C92
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 07:57:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E88140658;
	Mon,  8 Jun 2026 09:57:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 1EC42402AD;
 Mon,  8 Jun 2026 09:57:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780905466; x=1812441466;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=eee3/j69bnpunCoDFQJbcE48tVsSym9H81EFitBkFx4=;
 b=LnuW6ebyZhqGQu+lpbmpZCY2/xT+B/nZzbnhoWvalvLhvmo7NAvqTFaW
 wfaD9L6E4sH2HN8WHLsWR+WE+0rHacV3msdO5W7qcJ0q9KErW28q2MA45
 sikJRVitNnU3oA2nJPfCdln31/M898pcgxp1kqkeUpNskz3i4wTeoSeGY
 85tjD1bigaJmnrnTZInnnhOrBKTqUgvJZrUOxcCD0K1mZVS7UQuQOamkH
 POGyMxAp2BHTogr4Svo2VtMXrDA8oyW1t+lYs1X4FDzCbbXqYH1mk5n0t
 0z1ki8R1RyO3C5UA7CLw9UAiYAYniZz2PVSQFuM+6+NMpRpb4Iuve2HQV Q==;
X-CSE-ConnectionGUID: EhDlJ3FeSSalffWhb2Whag==
X-CSE-MsgGUID: 5eBdt7arRSy22+AzoGfoLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="91959649"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="91959649"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 00:57:44 -0700
X-CSE-ConnectionGUID: btsmOt4ZRuWUCO1BKbkKOg==
X-CSE-MsgGUID: NNj6CRGLQmu4gu9TeH1QEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="275675732"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 00:57:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 00:57:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 00:57:43 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 00:57:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IP0wYgH8HsiGZNewP/zyVlSTU/9E3lywl/54780MAhWdDpI+yQhCUNHVWVKEjMtqnkf6WiGHXzgqwSb9Ss23cg7+6w114BNqzxvOZVZK9BWqd6yxgGhc0K5a6vTCv15IuwQ7+9iE/DBbeVqtek8lGoP5PMBrWRJHjMED3TYD82xrnftAD8aA/Uz/ksLPtPr6A4VhlBbxQYDpACEC8fxBrideQBkKsca5PIn5xU2qh46JoRb8tNAIeci4wdBznoSzbtlB35FSwLA0lH63iV6ItTPHPSqNmWW3JgwhTvU3a81C9qbmvl74YRps5HEv0xNrC58F0RwAtOs6H8o5yosihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4k8+LCA31J83gOGOPOQ8RRLBDtvGz5kaiwuM0tZ4PkA=;
 b=iEG7TJ8w0dDR0Tz0NIlOk3EzNlkkZnNX7xpN23xZU7tt26En3ZJ+H9Wk/X+/PiQVB+j/nU2kTat4xxgy+FVbC+1Xz3nfFFrdLtynzerZQS09k9veaMaKw2pim++9guHmXJwoq3Aj0ZeM1dz93hsaIywncKYJoJNcXDgJvSn1pQxPNsgM7J1fY10Qg+osAsK82wq+OLCvm18dNcvRWVs/Sg9nKLzju5QOD968a7A9hh3JmG2pKmPyaJorG0p7LGlkj1lAPO1tcrBItoZEcEzWkL+eYIU6no8J3warbvGpU/Xq8lasMZWnAWri0Ed1HhWqglUW8F8dirX8IR/XIF8mig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DSSPR11MB9641.namprd11.prod.outlook.com (2603:10b6:8:377::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 07:57:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 07:57:41 +0000
Date: Mon, 8 Jun 2026 08:57:37 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, David Marchand
 <david.marchand@redhat.com>, Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] eal: add destructor to unregister tailq on unload
Message-ID: <aiZ18XzZEOvf-aas@bricha3-mobl1.ger.corp.intel.com>
References: <20260607150418.30885-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260607150418.30885-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0291.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DSSPR11MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 5584f623-2397-4086-db92-08dec5339dfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +75XP3bV69ueduerAKw07tAxccBeAdBP1mG9ZE05j3otjbKgSnwlNXGWwDKTR769gFR4sf203K2AdeoQq/tBSsMm44jUpfMiXPtyPCwZwxhDmxz3ngPXCCT3tt9/SJ7vZAro6TBWQNqDYMItsLlRB8IzFxH7kQNgG0ijqS3V4yXkAg0PXUzXY1g20/XtGpEm1CIoAUfI0jobuT9FLPOsTHwLeHESo3idX+39b0AQ9KOoM5+MGYwlxEZ7rbfdfcuoX6ZsveOWQxlyKrA0Sx27FJcAVGLlwVNZrV+SJzd2xGigA3/fgoHEPYfIHxQXaivsPVYrxeD7ua9B/FLAeSJTqVLHc9FX94XPuuZQfx2l70rv784pt8uvUoGKWVWf49CORNbc9xNKmJbnNJwks06eV5ZJYN3zXk7ijaSCJWWFzlTyLVNwR2bmbjwUBNBmLC5UdnRE1EBV6+ab4NsB4Wd9nvrUnle7rAuaFnKs8VwI/pArirrmLs2ETtLkQyi8mYqES97bOe18q4LpSQ9aaHJJmrVR+arX4sq0rLmAXoQDbwH6BZMbjlTePwALfX/gHmh+lfXp2PVQDjAJwW2TwB9CBCiH0QwUL6LIocwNz6IPhNPvrZ9Cea13CIPlKwCL1x6JIvV2szJGJjfrOPpehYgyLATWXZdqDsjMvgoT/Rklc/9N35SspMKhGo8YLSM/gs3O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6WYwkWfBjcDWkE4YQUfrizDmpGWmjUcPW9zDne/R7n8zmlgNInOnmWDpKxDe?=
 =?us-ascii?Q?9UAbk460pQP8pi+owjuGTsnmBGr6/8r8ro7oI8Vwg3iVppSLEFw5oqhp8UWz?=
 =?us-ascii?Q?CjYUBWo1eU/0x4awXXayLeoxKmho2mZ7fEvoUExKMobewA1qQFzzfQgbXn9V?=
 =?us-ascii?Q?XIkyaTNp9F/j6g/GIpPGA/FImADUnNJnDL3nCYdwcfaf9lJvv+nPr0CZe1Al?=
 =?us-ascii?Q?tnVf0NsIMYS5yag7kOtcqptk8rIQMMqg6XfkorHwzgLVID1Oh6dO75oOMCc2?=
 =?us-ascii?Q?kBkCrXhgt9AnH8uKYFI1eBLsOt8hJfr4Ealo379V6LtioKNvyHap2HkwthQy?=
 =?us-ascii?Q?Fs0y/RFyTXR5xixtsBdcqCRpsDsE4pJcgRruPd9xtIHdgkK9i3akyN02Q+Hb?=
 =?us-ascii?Q?vij8EogEWDrXASSKNHNZ8BkMMMsqzHhYTB9tZF6Elq7z8qIS710COydYvNro?=
 =?us-ascii?Q?TBx1TIM6/o5dpEhQEgft5agpq597vrvbLAPjmEXZ+E+g2+zdkD18nD6ohKXz?=
 =?us-ascii?Q?UX8UECCiLkLVh16yp8keKQAxKv/PeHggbnxhmnyz/ZKeX0MhuI0/X8Czw+OA?=
 =?us-ascii?Q?9S2mdxtE3pm8guCZ4H3Y3BFClInuEqzqR1ktCXnjbdQQNk0ayi4mPgZP/DWb?=
 =?us-ascii?Q?CQSpBDL7ql6dFtkhHY3Uvuo96mc9m5MroZ7qYBBjBF8ksh3INaq+1rQB2P8e?=
 =?us-ascii?Q?uk2Zk/Bhb6Urli8wnpniPJ0v/6fZ7bwmgAPRTL5XNt7Xh065dsVCHGnpJfVs?=
 =?us-ascii?Q?9gnDO/H+/b3k95/vcF64UNpeYfci2DeRds6cmFIs/3QcuCn2ZQGVcy0DrLiD?=
 =?us-ascii?Q?AZGZYEF43XdSLcJgyP8kU0zT4XItGcjq/i+RFqJ6F34HeQsRZuk0uYpPVpCz?=
 =?us-ascii?Q?hU6FYJys9dX87XlpMZ8m6bSIcQX75PuIicisrtnejw3UoUQfESa0+6PZ4r9H?=
 =?us-ascii?Q?xNWTEwUo9Tw3FOop52Q6nOKb4qTEKQ18mfQakXtPRNCzppk+P5fgru2tcgP/?=
 =?us-ascii?Q?3gRpsTTDtLGyJ2MCG8K0Ogmspbl5guf8S2g4TUmXU9eDy3vbbewic5yTef/T?=
 =?us-ascii?Q?jsFigKqejsesvYmaJ5tpTlF/bKOzzMFbhW7yuFEyIM4IdfMJqSuxmBfqaAke?=
 =?us-ascii?Q?4HgQ3z3N74iQjOdnoSTxY/1IRz7EbQLfzDbm9NupT2Gx5bxwsDkfyeVy5oA3?=
 =?us-ascii?Q?J0feo/4kj5rnpUHWt4kQD/Naq6qW3rNDwULLnHHxn/iwNR01ymiZ/TwjESfV?=
 =?us-ascii?Q?h2CY3LYZ2tHJipS78jNTt0dSPpnYcToMT4UaU2PenK/c2/R6b3rZWTsOWb2a?=
 =?us-ascii?Q?aaFjxOJVGphLHQW2qb0lKdZ/S73cdrW7PTz1J0hONnz5qB2ehWA0Bd8rXDi5?=
 =?us-ascii?Q?BmAjb1ZZFjuUBhUHFB7Cj1kBA85OgnC4oqv0mzGkWothBN2Rin1DWMun5UwC?=
 =?us-ascii?Q?LTJfLjF+31PVeusDaSCrIZg05vHcumdsHEBXffD2UU1GjbYkeISWj1Wn920Y?=
 =?us-ascii?Q?+Grwx0IfVEpzY8OBVykK00PxOnpZKVNvc/IYplJm+JaQENEyCFnizcMg1AZq?=
 =?us-ascii?Q?eqogh3nPA9a+g1GxfpWjnE71CO+yo0ya5NzPye6p0CG878wPTSkVC+BhhInm?=
 =?us-ascii?Q?LAnSPXeLj1NujJZQ1TuR+XhDfIF7/CjCpz87x5Cfwf60CkS9bjL4kAmyPSM0?=
 =?us-ascii?Q?k/MsrXtO2dWe6cM3D2MZ5mK9Ohz/kh7Q1Is3ZrfrFWujYdOiC2Mdaogahf8G?=
 =?us-ascii?Q?ucA+g9343HKndxfM+w0I9GN343wrMos=3D?=
X-Exchange-RoutingPolicyChecked: p4W3J8GiK26CaR3wPBzXbhYRWa7+lEl3WOK3QCsYlb0n/eivou0NTVijUzQ4E6KF9vhkQld25bGWGh5lJ9rE+eCPfXmA+fTpU3BnwKQ7aBRJCdKrK/tm5M+cOVtea6HSe7IDZFH6yoy//dIfkz8L49LNCw3wJaA0U2BisUkP2EIwJmPtmkNt7Aw0SB7mA96cfgft99rvgaiSrpWH8YHgIgjq9fEzwjL7Njq/34LARySylIkxcIn6jwCfkQtSE+ZBTvQwlgs8ORVEaBJsdWYGRysUDxEr4ZQRiHrV2UoFxvwWTtXAWCfbm4PplB+XdGtc06yIKUbzPwH0dLaFk/CYPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5584f623-2397-4086-db92-08dec5339dfa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 07:57:41.8738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H51+O86VJUWN4IKhBXkZpCPQMoMCuHvjkXYyjALw5a1CxbSM9wYgDjbzDcM1ZOcyDRLpFVRDNbce5ZzBstGxT/e/gDccs/uTX4rkjD9Fvjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR11MB9641
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

On Sun, Jun 07, 2026 at 08:04:17AM -0700, Stephen Hemminger wrote:
> Libraries that use EAL_REGISTER_TAILQ insert a pointer to a static
> struct rte_tailq_elem into the process-local tailq list via a
> constructor, but have no matching destructor. When such a library
> is loaded as a dependency of a plugin via dlopen() and later
> unloaded via dlclose(), the list retains a dangling pointer to the
> now-unmapped static. Reloading the plugin crashes in
> rte_eal_tailq_local_register() when it traverses the stale entry.
> 
> Add rte_eal_tailq_unregister() and extend the EAL_REGISTER_TAILQ
> macro to emit an RTE_FINI destructor alongside the existing
> RTE_INIT constructor. Every library that uses the macro
> automatically gets both sides; no per-library changes are needed.
> 
> Bugzilla ID: 1081
> Fixes: 873a61c7526b ("tailq: introduce dynamic register system")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
