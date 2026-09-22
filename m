Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF45C982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 14:25:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AF4742E55;
	Tue, 22 Sep 2026 16:25:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 12EAA42E55;
 Tue, 22 Sep 2026 16:25:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790087123; x=1821623123;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ZObkCbgH/L6j0sXLHpHVmQaeFXCrAR3X41mp2W+ltjc=;
 b=IHq8LyKGhoLLZHW74BGEAK4ANoEfXEQwrU25JefGhOvKb6y/3aRQZ72M
 pEzasZyTUaKeqAs1bkW9XdOvP4/+iI3/xD/zoxjWruMt0PlEIE/kJNaUQ
 ICLpJZ+X27fzVQD99xJc8Egi3JAk87fUCMoCtm6xMnxFkqX4BSgnBQsns
 kJABHZwyKV2Pp5+P4TcQOfsBgx240p9+OEhEZQURTD0WrUj1ys8sSZRKM
 67VxPWVt33lVtEIzYIGvnYMQHYghnxBa7Ki5nxy5TAZQ0AbKKgnlGXCjZ
 dekyJWZUM1zQDksyB4Kn28zb2BUH+ySLn5R3J+tKZw5yI7rxRPM5gMgp/ A==;
X-CSE-ConnectionGUID: 3Vh2RGoaRumwvp3oVI44fw==
X-CSE-MsgGUID: o85uknNYS9iMiQv0gPUxow==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90562215"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="90562215"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 07:25:12 -0700
X-CSE-ConnectionGUID: 5Uu6vIxQTwGvXbIx9XiUrQ==
X-CSE-MsgGUID: bAUFaMAnRYyXL2T8t6j2/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="281216185"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 07:25:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 07:25:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 07:25:11 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 07:25:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dG4IqJMRk36oGdg2fX8Vv+a38klMZ6VnZ1H4ys8HbJv5zLkyu2fCJ4nEEPivnkTTU/RPLs0i5ZAWlzSqYKxj+ELR2bkE2aicifB5FiAgI3AYs8O3shZ8fuvq7eVUJt7CEbAvq42jViq3RvpTV1Xw0zrOyD++P4hwYxlQjpHr13uGHAfyIfWouerHS6OdKfhNEiPldYzcpPmKZ39ksTvTNMRZKp7+FutfLOu3q/afLKu+7lueFgOnswvse9yPRipjTOXUbuNJvpbfXrw7lGi1Me3WvKG7MgOjeak89n5STdfZBMCz5JYTbQduS8zgAB/+jMTDxYWdLpiDZL3kAF7wJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKlRvWe9RbyRm08iXzLxBb3/FN9NMQ2xbtJrT9Kw2+8=;
 b=SXe7eLtZMaSC40W/rzmdSLZaLmaTcyDhgNJIcZ9+MgazXB8j3F8+A3fx4oSg+mZnEVPddkYibMyBTU2hlMEby8Jq+nDDWBtvsZiIvNBIHkwdOkQCM1VNr8axuOIX/6uQwzAE2r/jYJmT6uk2cW2nTENvuUmoJrltWLsFcl+tQylyUho42PeraVYr4httvXF3G2RYtcz7KvO7Hv+8y41M4YIJfOr/Csb4251Mt1kKQ3T8mxA7ZIhpfqTLwPJ7VVZsT4U9ZmYMpFyP7obxiMol1vP0C+O63U2iCOBINMMnOBxi+WK+Ngpw+3fQuMCThdnLS9CO4iqsidfQn5zmAhUr+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH0PR11MB5928.namprd11.prod.outlook.com (2603:10b6:510:144::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 14:25:08 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 14:25:08 +0000
Date: Tue, 22 Sep 2026 15:25:02 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ring: remove internal devarg
Message-ID: <arKPvvEKWglunNHz@bricha3-mobl1.ger.corp.intel.com>
References: <20260922113614.2952557-1-bruce.richardson@intel.com>
 <20260922063401.6f2faa98@phoenix.local>
 <arKMN5dwo0PD6teP@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <arKMN5dwo0PD6teP@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0081.eurprd04.prod.outlook.com
 (2603:10a6:10:232::26) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH0PR11MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 0251cba5-5b29-470c-c98c-08df18b54d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|4143699003|11063799006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xBlf3yA+8pQmX+XVmOVKwc+3JJUvq0nZiFsOAQWWDCajogSWQFUZGH8xUH9rsQ5N7PosZ81ymSgxh97FEl60Qa8n9eA4VYradBPOCEWijr305Dwitcod+4hg0F9ie5ExmYJWk4lN7GbLMJZEZC1BwWuCGX9dyZwbygu2an4FVeZLfooxZO/KMWGr0s+XbzAup5saWQQakAy5fg1sQJrQ1Z7k6nMbkNeZQ+6pexjc9+pxPPRZ6+zE3KlDELG+3cAGsHBkm6c1g0UYKSJl0GHqe4Dlf5kTjbifx9g0/8rztPIb8S1H3k8tVyXlP0XZUn4s+ns6zDW2odNGTMmKoGI+vkNX1tGA1uLXBwP9yKvu3QarZ6qyTu7c6vy0ujyW/26zaKd+O51UzanC/qSLRveJy1RYSB7xnURb4eZNgkobTlbKEGseG+XaAKCB7w2bmv5HZc1dZNQoZsDFN4E3vZsicKNb/LJXa9PcDbOpvfgOo4q0hrM8Dfpz+pzc/qVXzlVVTOgdFZSgjrsv/23c2pOfbcKlCExJN8N0pP3Xk+3IJgj8JBwmeJQSpsdfl9MtI1YK//QN6/2RHJHGHCtT6vFmW3RpeY6k9y9OVYRPKUsqZW/C0/3rTuqxeR0/CS5KCQobjmy6oAxDprM8mss2/LXnWIKS1YXdZn44z54HaNCmQ3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ATRVwEZ48hDsRk3s16PBJQSaAejYI32jluM9ev951g4WFSJ7s6kmf0pKnw1C?=
 =?us-ascii?Q?as/+BCON+meV+WjNyYvxP8rVi9q8uI76WHtQ0GMUgEXH4PiVakiRBMML0GO0?=
 =?us-ascii?Q?VNGOyntHTGMoHvZYrbS65NRzH9D/vg7i8LuCH0Hdi7O/1CIi4B/Z9ZOfBhow?=
 =?us-ascii?Q?lF/NqG6+ZFm3TQhqug4mMvqx0HHCJEtnheV5kFapjJaUj2l0loSUZ07JmwrZ?=
 =?us-ascii?Q?E6jMMxcn9XlAdn9/O809HP5lqMzLtktHFos9HXkdQY1CzfG4UK5NMo9dvSlF?=
 =?us-ascii?Q?DP7iHJ9FayVxo9xOo3rjX7XBkrP5MTZHd9ssHkswOsE8XDCt1AMK+kFLFy98?=
 =?us-ascii?Q?xvT2I5DcFNdLdsVPS1dcDQt4dTsWs+Ugdg4XGTvP9gvL3gVHgupxcTgu1Ygj?=
 =?us-ascii?Q?+NnmT22mI2o/svNbhwvmPC5vy9GVkKvp3BBUzS/rOrjwqc/c2NEpZyyhyuZm?=
 =?us-ascii?Q?JJ15qGofPMLeKQyqJtUWEjf1LtB0Vsz9fz/YuVjoic3Z8HGOgc7piBS/SF2P?=
 =?us-ascii?Q?8vB3gg6xeq53g+sXw7UhbknE/BOi47Kxa1XTk4xdS8b2HMm2CN5bvYQkR+Bq?=
 =?us-ascii?Q?RJS64N8mov6yhHVTk2vl+NacYnxINEW2KZ8tv8Ns6GJqV/XHTfVFChLee4EX?=
 =?us-ascii?Q?0njzBhzfk4cvXI2VH7laOELpN7qs8nPNc8saMUBYoitE8BgNGkq8qyeO/DL5?=
 =?us-ascii?Q?tNO65DwaAEPk4gz13P/mvXOlR8IaBuJ2uvfRA8Pm8UiuxqIQkGMujZl6pAZx?=
 =?us-ascii?Q?XcY+nilOgIyIXZirhQKaE0MeGeRPS14Feao79oowCXgffC59IVkB8C7/aCho?=
 =?us-ascii?Q?1mLP6PleN0m4WQPUqL4wevBxo0/CP1fEz4D+ghHRWrU2IHdTT1dy6y65Nm+b?=
 =?us-ascii?Q?7wi2OPf7Z58liRaaAaWoR/lh93txmI02zXgpNurdQprJotDLDX1I5jLGFv++?=
 =?us-ascii?Q?NIIIL0/jmxr8QYOsWUBXc+8mMIeV7P8xEAlibLzGYGgQW1dTC7iOFopQzdrg?=
 =?us-ascii?Q?ppsBgkNoAMBZ/iZNxELPUC5JU1wCNSpnPirFJExSTtnpYHRpZP2lWqSU9QfZ?=
 =?us-ascii?Q?nmtGX3xywvoBg46pbfwurWUJNky1IScoMD2mVVhheF605I3IFK5yoFURMF3P?=
 =?us-ascii?Q?A7ilZwNAlp8AWAxC68pGv6Nf2mA4ArGXVD1OMtIBWlXKqDr0Qn4w6bHETUtU?=
 =?us-ascii?Q?SUafhf3w9Y+BzUlSEWrSLMPKaQ8vN6nnz/hP2gNyQOki/VdXk8GkhBRkLVzg?=
 =?us-ascii?Q?EFYN2+sGgCA0Kz5JIBtTHKAJ25t8cTpOh1wQDf3HIRwFS0VgHioIp/I50U5E?=
 =?us-ascii?Q?KXqph+jX+jJK+puN68UAUznd5tcwOXswncldbE+C1peuXbI3sRw/04kELwuY?=
 =?us-ascii?Q?UfA4uSO5bEKpcidbL4u/D7593OHXKmPT/uRfkNwksRwTxO/hbW0MNamhj9JD?=
 =?us-ascii?Q?/uYkovotT/rbg1B7IIJtju0pZZowbD/WIGrbE8lcn1SH+qekutNhQQ5xbADs?=
 =?us-ascii?Q?ekvIBQAvOk1K46ViSPZThGawWSjqtq3R1Nth2h3JaQx7PUIhUVTKa14E4lei?=
 =?us-ascii?Q?9PsSab3C5tT9+MXZHjRu6LVP4aj+hogMSDRsYq/1akVR3yy3ZNFdUve+kgT9?=
 =?us-ascii?Q?UF/ok2n1W5A4AadPTCgUGgZgStX7ZEw+rgyxkn7dLVA6GBM6SlF+4qUGHirb?=
 =?us-ascii?Q?LYcKDCdQBt+4Jfti825R0vyzsOubZwC1k9kZpHHRMPRxFLSyi874h8e4zt4s?=
 =?us-ascii?Q?zgSqM+KEYCcrCdKhCF8XTG2+2p1do/M=3D?=
X-Exchange-RoutingPolicyChecked: 3j3RLN0/l80QHeU3aevDSGLF74EKSrxjmrBVHTM1rZPRvcyDYJStnPJ7rKe5K04hAFgi/wP8nbdEKmuP2r3e3fKofCn2QQiAuleOInF/Obv1kRh5KXvbdibwL0n6bZqa7eN+791pTvy/I3p/3+x35qUXj3zYHh1KOsjrrKO7dQd3Blvo77NAm3D8m5xeZ1sCvorlcFRthy9PExudXSHMBv6GrB26Bgf9UxJ2l3My2ihX+IAYM2i85aYo92kAbOtRHP2+D2bWdV7oIZGPJVG2hJ83L+1kF/58GXy2ssRss503JjV8Yvoyk6XFB2WFXHb3zKBYFqN8NyYhUz56QfPVlA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0251cba5-5b29-470c-c98c-08df18b54d66
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:25:08.0119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGncIfzwIRDGDCbHO9PgCogpT8YJx61Dp5UvZ0us0wXL4DdV2VYbYfJgJYe3FJTuv/VtkvF8CgbzufUHqI9370/HfhVI5ZuQlTb1S7IyDLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5928
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

On Tue, Sep 22, 2026 at 03:09:59PM +0100, Bruce Richardson wrote:
> On Tue, Sep 22, 2026 at 06:34:01AM -0700, Stephen Hemminger wrote:
> > On Tue, 22 Sep 2026 12:36:14 +0100
> > Bruce Richardson <bruce.richardson@intel.com> wrote:
> > 
> > > The devarg "internal" was used to pass a pointer to the creation
> > > function to reuse set parameters. However, this meant it could also be
> > > used as a devarg on the commandline leading to incorrect behaviour.
> > > Redesign the passing of the args parameters to use a per-thread global
> > > instead. The wrapper function sets the global to a valid value before
> > > calling the main creation function, skipping passing a devarg, before
> > > resetting the pointer back to NULL when the function returns.
> > > 
> > > Bugzilla ID: 1687
> > > Fixes: 96cb19521147 ("net/ring: use EAL APIs in PMD specific API")
> > > Cc: stable@dpdk.org
> > > 
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > ---
> > 
> > Minor nits from Opus review:
> > 
> > Review: [PATCH] net/ring: remove internal devarg
> > Patchwork: 169914
> > 
> > Applies cleanly to main, builds with -Dwerror=true. Fixes tag hash
> > 96cb19521147 verified. Removing a user-reachable devarg that is
> > dereferenced as a raw pointer is the right fix.
> > 
> > Warning
> > 
> > The per-lcore pointer is still set while user callbacks run.
> > do_eth_dev_ring_create() calls rte_eth_dev_probing_finish(), which
> > fires RTE_ETH_EVENT_NEW callbacks synchronously on the same thread.
> > If a callback calls rte_vdev_init("net_ring_foo", "nodeaction=...")
> > the nested probe sees eth_ring_internal_args != NULL, ignores the
> > user's devargs, and attaches net_ring_foo to the outer caller's
> > rings.
> > 
> 
> That's an unrealistic scenario, is it not? Having an ethdev creation
> callback which creates another ethdev just leads to an infinite chain of
> callbacks.
> 

Since it's a one-line change, decided to fix in v2 anyway.

> > Clear the pointer in probe right after reading it:
> > 
> > 	internal_args = RTE_PER_LCORE(eth_ring_internal_args);
> > 	RTE_PER_LCORE(eth_ring_internal_args) = NULL;
> > 	if (internal_args != NULL) {
> > 
> > Keep the reset after rte_vdev_init() in rte_eth_from_rings() to
> > cover the paths where probe is never reached (-EEXIST, no driver
> > match). This also makes the comment "consumed and cleared by probe"
> > true; as written, probe does not clear it.
> > 
> > Alternatively add the vdev name to struct ring_internal_args and
> > require a match in probe. Either works; clearing is simpler.
> > 
> > Info
> > 
> > No test coverage. app/test/test_pmd_ring.c could add a case that
> > "net_ring_x,internal=0x1" no longer dereferences the value (it now
> > falls into the "Ignoring unsupported parameters" path).
> > 
> 
> Since there is no "internal" parameter any more, I don't see this as being
> necessary.
> 
> > Double space before "*/" in the comment above
> > RTE_DEFINE_PER_LCORE.
> 
> Something that can be fixed on apply, I think, if it's a concern.
> 
Fixed also in v2.

/Bruce
