Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DCBCDE008
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 08:48:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F9B2402F0;
	Fri, 26 Jun 2026 10:48:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 0D6CA400D6
 for <dev@dpdk.org>; Fri, 26 Jun 2026 10:48:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782463705; x=1813999705;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QGWn2makUR5uaKLptQSKtecc4r6sNaOEX2NH9CQP4D4=;
 b=eKQMQBT3nc0jkGdw+NnbQsvBMCCAX8Tf9+/rdS/0tw6A2RCbUEK3Jmt1
 1ynmTVu80pDEc5gbht8yMll+eaymLajUlFqfiJo8IQUnOMmYxvfcGomeW
 hbqYcWesadO/lC28miVNrtwxDuBH0+yMYcqlswMHZmuCDDcK0f6MlQ4cu
 Z1QycaAvoZm1P86JLLgK6RnUtidFtkR5HbTLD/ID4fzZsC9uQYjS7NnJJ
 0lcX5k23QLlavXuOyvR5C6Qha0awR7Uf+kzXAUKvz/IwUgrXVNGlsJxJU
 z70978RZfUWSUP7qhAedHtfhUweOBvwH/pSpfPumHQM5V6eF+L0FMOF+2 A==;
X-CSE-ConnectionGUID: QuINMuolT+OrsUPsFFX2fw==
X-CSE-MsgGUID: CVlKnipsQN+tQejv1ceHLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="87102514"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="87102514"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:48:24 -0700
X-CSE-ConnectionGUID: vOibK3ifQ2ysWHnALfW68Q==
X-CSE-MsgGUID: pSfNMII9R3uTJQR2TmvJQA==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:48:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:48:24 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 01:48:23 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.9) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:48:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7u7Dxo0R3I8jXDHbLUeUMZt3S9GzwhwgtTGUQVpPw2eg3JgsJNSplg5lLhfO8PC1XZeTRkTMKuyPHxtvKzo0mzSrQVT6omcJpdMaEjuE707en1a5rdp5jn2cVMyraz+3MoWLCqZ/OOt75phYjWw2xtzyq2XLAxLr17otbDJeLenDQBDwt8ONBxMi4q19eUFDhuY+hRzPpAQ19GTO1PYpbejSwVCfwB6s7RW4x4xhfMYEjJAiSgjwn8THh9eZ2+jArslgU4UZeMMuj3DgqkNGG3rUqC2oIpTufeFdzKjw7NM5TWNzqNveu5TNCm8BuE0140l2fVKOiMhwaaT02MBag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/NX/rzifMRAwdKcvnMDwY3qLWp9be9GpxK/ldI6oPg=;
 b=l5XIH79doovWKQ9+48Air6eWMEXS/Z30qBrSib5B/avPeCPHVgbwoB6chNSJPuoFJrslKnNhTyJCC2QgaNvgPsMcgTGk8tztKsZsIYEaxfL2Nd3XVTeriFdZVQpXbkANLJ3TitjBfaexABiVZsAqRpmnQ4IaIaCIGlQu3PM+yJSH0URT/sG8KlVUM3ZDW/3zgG5Q2bO4pl4nwcjSgVTc6v50k3mJyq/UCwD8ouDOU0hG3BvfniH/MaorKILH7bzg8Z5GUZGFDyAIQEigRv86rTUIUvGZi9EgCwYjPTU26kN/keb4kFPAO7yZraHTSUXVwHfTYsK5RG6Zlq2QTERVUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SA2PR11MB5051.namprd11.prod.outlook.com (2603:10b6:806:11f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 08:48:16 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 08:48:16 +0000
Date: Fri, 26 Jun 2026 09:48:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v1 2/4] net/ixgbe: fix potential NULL dereference
Message-ID: <aj48zLQLqe0iam9Y@bricha3-mobl1.ger.corp.intel.com>
References: <c42d6f4efb83f4962ea096a702ed320a3d0a5eed.1782402484.git.anatoly.burakov@intel.com>
 <736dc471f3da92e420259a8ec14a77b92de7de4c.1782402484.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <736dc471f3da92e420259a8ec14a77b92de7de4c.1782402484.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0058.eurprd04.prod.outlook.com
 (2603:10a6:10:234::33) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SA2PR11MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: f8568955-a75e-4ac3-7745-08ded35faa0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: ySZvNf4A7br32KIeOXMGBP2goIzXh6MbglVJ3PWUnXlDFYgSEcPDUOX6IRPNCuSIIogrpriN8vZIOeF971zzvRgI+jVTW+L99PDulnGM4OrIIUZeb21equkP7NRNCQYflGjMa9BgNppuSDfEpeJ07wggjtwkzy+CvkszOPhLbHlXtsYXe+G+4nOih3BPYeV8rPAE07LP4GcPTAwYGPz9ShOM68+OwCIEQqXdoTzNSSNPcszudIBlTXkTzY3dlsg6Ybq4jVWZe8O0P2GyamiONmh4tFK5Qb4agfSZ9bpkRAYKn0TMGku9nh3sXasyqgMixDBENIuJAFbWP08oqxyJxde/g4Q5Y/z0MB27wxsIPg3IUPCUSHfZbwSbvfulkJJE1fTt8BDpqDVkbIF1cYUv4GPoTz2RSJNXOt9QXQILAMay4GhxmqRe+0xWpqNnlX2SSrtagNjSVbj5hZQedNaA3Dz7SGlkmMFLS30LH5fGShowbgUro7fQ2Nbjdisnb8BJdwL+HVsYu2s/Y6roOj7DEQ9D1CqlwaGKgEpxjmD0LZZ/7tik04L3WluERsjK5rEnp4GEawR5TkfIbLnxE5T134cYRwjBnIOEBYuNeMxuBdSqReRkOgQj2C7BeN+B12OimWNwzFfK1co4sVFT2Aq8P4qLxft5uIoUrEhNcYrTBZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cxamb0f5O37a3PoCMNMZi58kTkNHg3sD6tPrUsASMcz9KeyUJhVzXdFd0pmQ?=
 =?us-ascii?Q?D+B4/bqqUayDOyivqERPdM9+wggUZkqULa/R4dMcs4ZaAEpeyrQ0MPcxtWTd?=
 =?us-ascii?Q?ZpB38M+CX5L2ocI05oUr8tPFgc3AF2OJqsH1jrJzRKCK36QkLdToE+cpxs22?=
 =?us-ascii?Q?59xihUy9AHQWfFvTWRVD6K1n5hRZq0/cFloReP2N5Gxmo5bCIZKRtcSnh0dV?=
 =?us-ascii?Q?OIwP478yparBI6ontY6u1N+zrAkEeZyNAOaxdeoyspkfXabs3khmPRj4p8w+?=
 =?us-ascii?Q?9CdfxU/erbKQtlcmg/qUp5O4hPnr4VfrIS3E9HxVDmFoRG8kwB4jmM3c7btm?=
 =?us-ascii?Q?ZSW14z0JCpXKMywwglC3VmsOUXup+W77QL7a64p/CpofVYXn0SU2O/UvwnhK?=
 =?us-ascii?Q?bosDSrBWyrBB4lpVzM3rm1GAZWmMO76ffjoV1FQpEa9I1ldlb4HcrKD1DpA1?=
 =?us-ascii?Q?AKhWk4sz1d+snXN6mJQJ/+njvk+877CotW8RS313s/WOHjgupWSlaE28tmsz?=
 =?us-ascii?Q?L06K/rkyA43iaRP1lT/Uro3vQfGkgvfn/GGMnL1UoKRtYpylFPpxVK+0oO+6?=
 =?us-ascii?Q?KzcqMvFDjwu0E32Q7crphGp64NmHlWj2W/NoJ43jWyq2pzt8C2UnPgEoU2KW?=
 =?us-ascii?Q?Mt6/cNyk92ZDoqwOTrU6aFocsryryG1HCnWmL6oX3RgNeBqW+zzYyJMfrQd4?=
 =?us-ascii?Q?MhUCNYwbf/LXkqVZmFs+4lPTdpF0PjubjXLvN/FW90wcVezqalMgaSzgvj3+?=
 =?us-ascii?Q?7Sv3nPcfFaEmJPULaR4L0bZ0fRrMOgZPJ9zWGi+0JU0KzujwjzsXrxL+UfyE?=
 =?us-ascii?Q?b+tI/L1SkVLcdKYKg1yvrBk/wqJu4fmeUWfMZsOFO96j4RDpnOUICXkZ4HBs?=
 =?us-ascii?Q?iL9o3yA8UW/g6H5GDKM+jiql3nZJTHWV55Y9bEp7XJEruM3Os6v+WmDzk0ha?=
 =?us-ascii?Q?Te+U97CsEMg7i5JTQylHNZ+iRFGVDVk4JkDfAMAsUAsfiLy4vLD8ZAoOa3/l?=
 =?us-ascii?Q?LJep47PDlq2JT1dO/MBV/PtRs2y2wWNrG7ygutcDN4jCvhLCcGgqQ/e3HpRC?=
 =?us-ascii?Q?1Ocb8O3Qv+8BRgD3ie+eIJuHp082YS5yZDuxFL867xeveb8jRg4cD0zzKG11?=
 =?us-ascii?Q?/pc6AkRD9sjtNWopkPusIn7K+Vct0aALXoNx18XeenObWZEgFevhMFOLJgzR?=
 =?us-ascii?Q?7QIO0jaWfF8JadardiNDxjPzY/y/z6MYte2Juns8uHgP0NDK68p4NofpNjro?=
 =?us-ascii?Q?Go3o+3OLIKa967wejXyadN+BKvX2xI3qj241thjBZm66X96QoeMsZqFRRVb+?=
 =?us-ascii?Q?t4Cj0TPCbOhLzOZeUnwJiJ4qQ74eMD+620NBqNZRLi1fNawudxp6IITPkXDE?=
 =?us-ascii?Q?tjDWaisJ/1eyLzXukOpfLkzy1t2HlGnYOR1GT0yBOF/AyFspVL/Im1dxDDUH?=
 =?us-ascii?Q?3rw1KGbmmz2mgeKQZ2z7vPlMwNPFxxYESO9HtOLST9mJUK9ty1fLF6KotyPC?=
 =?us-ascii?Q?BYQgF+YTT5ADHgOWrnUOjBrcnF1QA7w7Th4/ITMmIkp3vFCfnbIIBZK8O5am?=
 =?us-ascii?Q?syfpopbfcMA7GKbqBz4yJBBnFqexS1yKIXoldq2EoHIPDwsXzSIcOYzsLcFC?=
 =?us-ascii?Q?flGJuk+wFcrQhPdvYREm71QV+aRDeL7ssXDBALhe9dPdsWZxsRjsjwVqEES9?=
 =?us-ascii?Q?MSiZKmYqrO6Jf1X6q5EpY/z34unbeSp48EJm9vJ/LRD5udjRxpAvZO+drmzH?=
 =?us-ascii?Q?Jw7xqEWr/KKfOn1lbfR4KDvG5JYbYsk=3D?=
X-Exchange-RoutingPolicyChecked: GNwg3JKTj3CymPpccUIWTv8LF2Kqie4Wng3u86DC9+ImhYK5l1F92RI7Et9y5V860CQlWauYeNj23vDaPJgkH0sN2e3xPt7tbX7rVXhxWWMQziR/eJYsY9u8zTfpGC/e6YrOGOgHZ2fTGm2lO8bNur5YYgs99lgxS5Hb3ewDBLW8seZoIPH1y4JaL50aCKP+i3d6BA0nTt7tE26a+hCKs4n/2DGpr+3+k5dkEbe6fBMKIHSXrf+7IapsIIhqlxFqwqN92mkXtYWjy45/EWALbuYjnkOGf8BY7mFy0cNgE6eHw8wiiv+c7asFTL0GX4D6KHU5ycMdAyJmd9G3RqUYcA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f8568955-a75e-4ac3-7745-08ded35faa0a
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 08:48:16.2340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMw3yt2oUvobKVJTB17eYpfjXnEO/R8H3KlH4Vtr2vrxWKEfBc3m/rJq6gvvzOH1v7rKNThidmZBhofa8tgg6krCQ54lLcIzS6oMdQTqc1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5051
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

On Thu, Jun 25, 2026 at 04:48:11PM +0100, Anatoly Burakov wrote:
> Static analysis reports that a rule dump may trigger NULL dereference. This
> cannot actually happen because dump_blob will not dereference the rule_data
> when rule_size is 0, but it's a good defensive check anyway, so add it.
> 
> Coverity issue: 503773
> 
> Fixes: 51f505a4090f ("net/ixgbe: support flow dump")
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
