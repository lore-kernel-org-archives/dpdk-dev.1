Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26278CCD193
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 08:08:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EE44402E2;
	Mon, 20 Oct 2025 10:08:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 2E88D402E2
 for <dev@dpdk.org>; Mon, 20 Oct 2025 10:08:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760947710; x=1792483710;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Vr+6Oe6KgLiHRisqake2XXozkUsQYCNUk4koPiGr1BU=;
 b=gQD0sAJ4Q25e9KU2tELUCllN4mS6wYEC44yshgJpNIIgqVB6QNAtF9+l
 kVodQ5gjPe7kBv8svbwCYz5zlL1r7qAzEmorkxTYvu/zEmJDAR6u6dx+4
 T2eA5FfYrSHiD+ZUFx5y49PCFLWqpw59EHvSni2zM4F1kC57hZy893MVa
 Bq7UU5yv1i1weqcofkiMvTv8MNz4/aslPLWuEyqSTukFpK3+P6uPYKiWF
 eGLE4K1e2mCgp3WqJNH92YyfBKRbtMns+yVHP8Ys0hHexkPQk1lrgWLzM
 HYMlMJYTyAmz/EcQ7zgTrYB33/sIYDLE19FzRroKAM3Q5dBgr0LTcsIZM A==;
X-CSE-ConnectionGUID: x73gfzMTQGCee6rHsr2ILw==
X-CSE-MsgGUID: 6OV0e56nTqmJGQFLvdF4dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="63206951"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="63206951"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 01:08:13 -0700
X-CSE-ConnectionGUID: ibhUVCvQQmSVVJ/RNzgsEw==
X-CSE-MsgGUID: 9S4h6I7EQGq7F5xOZFgoRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="182460043"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 01:08:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 01:08:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 01:08:12 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.57)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 01:08:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWpuSPnxrhCxLBO6jX+FdTS5MIACJwtj+VlsMA3TiQjFkxLs9JFnw8lx58G6lJI9FsrmJzPa/TCneTsjbq3vZ3Gp4UhTreew8Tj1pjcybDH9xWY+AHB+WoSMIZu/6ZADY3Q9U4uelIGqqfUVImKLVFp8DytvLXp/PoF158/cmLz82zmdm0+YLI1h0CeAsds5MigRSz3rsHurJSmQOIAny1r5jZrTo5f3hchdykqjsm/cAQMMatYlNda79srT2rxtmy9sY/oGZPphw/taUu1e1aHGo7zv3tcOrL5jRBWVcWRykmUjNdJxsmcOTWtAO35F7BKTeXktIfup2FLl5zpdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8e6ud/Z+LHGvkv3Ofi2ln5RBINWdvXF8zgoIXcz6Pc=;
 b=C9eGKESsEkeoIO7nHXYxKZ76DQMrG43Hev59r3hD+/7zswgDyRUyvkh3di3PR12slUTyYGQKczRBeMEOuOasrsd2UhwD1bHdK6F/F109QYLkJAUoDrFrRj+2OqUcFbTu022OsdX9XHSywGkr1VqDcNDfy3UDGX26LBDeRMM7GzMhmsRbLhyYDIPBbmfKDED0OkfMeu1h7MQ39n8EwLN3Fvk3gWTaNR1zusOdZf14/vyPeKEKJ4lx/XTleQGnMr86age8bY1qlhFgjSv1A4zR7Ey2xNqrNYKfuoVjHx9HS2zijsBukIBU4PAh7sKZvudmN4A0itSJPI5DCUseROIBxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PPF9623118BD.namprd11.prod.outlook.com (2603:10b6:f:fc00::f3a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 08:08:10 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 08:08:09 +0000
Date: Mon, 20 Oct 2025 09:08:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>
Subject: Re: [PATCH v10 00/21] Simplify running with high-numbered CPUs
Message-ID: <aPXt5SFqR3L8Wl3X@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251008204244.2288583-1-bruce.richardson@intel.com>
 <20251017181349.27f6c394@phoenix.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251017181349.27f6c394@phoenix.lan>
X-ClientProxiedBy: DUZPR01CA0132.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PPF9623118BD:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d98b34-ef8c-4c9b-cecd-08de0fafceb1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cvj8FYc7g40LLuSkhY5VBRjgI7y4wdGFzBBOKdqb37XPgm34R6yQEzwAxxzH?=
 =?us-ascii?Q?nyhymEfSSHGXCKFmPalLcTyZbZ66cGjMJ7z0JUAauOKlUJ3eRp/VvgsZlXo9?=
 =?us-ascii?Q?zVz5waJ3rbzYwdkyGqsne11d7YyQg4ETgwnIE+Ol4908Aodv7Rlco6LwCaWq?=
 =?us-ascii?Q?fTrMQvsMaCIZBGDQIpN8ph+Rll35ZSF58eJh3DIcCD+Och8mvDUzCem8hxng?=
 =?us-ascii?Q?QaL3NZnfeSATxkrnAFeYIyk6dVXTRgJVd6v5F1VAT9Bp8xwd3IoUk1f4zzhN?=
 =?us-ascii?Q?BECiGYJBMwxVBLSKZjjGMtOG7024cTfCsgqy5uMUDa2s8MvjgsG3QN5Tis3s?=
 =?us-ascii?Q?/WBlolttWoYKqhDRIjOuBFNVCFmWDlHBBW/EDi+EKg0mbbvJ2lXRAUnAv/3B?=
 =?us-ascii?Q?5YTGaYhB+eQZTHa73PwINvHjWorem2Hgz1eAmtfYoz+pR97Y29vHBxVGXQti?=
 =?us-ascii?Q?7aaMhziK4JQcTCaCwSyxiVccXJ0iZw9myxek+xslyYr00OlTLdkbT/ybvryX?=
 =?us-ascii?Q?YhPVggS/v7X1v8zfGKTi8+JANxi0aKhLg5dciNzl6/efk6be/xS/F4zlraee?=
 =?us-ascii?Q?GkM4m+B/NxKqqnkYGE5wCgOKiVFrFej6LZGG+pHCcjFZNfz3N/dcgjjgfoDY?=
 =?us-ascii?Q?LF9A6D9PuB4IVxlb7Bq8atWu7dgaOFoWLzLMY4qMyCdZrWDVwddHSpX9nvkh?=
 =?us-ascii?Q?7mY22Eeya/OB+ppis/biKg0RPSQTobJZ/CDIz7WwJtZqaLKlmExO5RFTo0w1?=
 =?us-ascii?Q?dCPPTsnMQkiYYTtGXGB6DDWJWfqFZsEiLMExk6t9oK/TNY/YOf5HjQ2DBxjc?=
 =?us-ascii?Q?54dLvEhTqrPupi/cArENYeoWYPbUGJyyb4lsslaEAQV25yQjD9q2Z2uy4DCO?=
 =?us-ascii?Q?jMLvn/3XSmiDwtmMDnCf//nSkO/x8QcLFG3igD+FQQ1t3B93U/VXV0BmU739?=
 =?us-ascii?Q?PKKekTfLxUmTaNqG16OOftB38AC3hS381rOWl6BzwrcPa6KgUGGVWARtEsyC?=
 =?us-ascii?Q?TIQqqXzp7gUqjt2PH7ln0wHB5ezk4/JMkRfgWSmI35Gds9Gss1OFIJGiOKhh?=
 =?us-ascii?Q?K4MJ2yeWQxIujtdU7WvjMrnJ7iI+0XzifVtUHStW7cjgXPyAYc/WD6emnOLB?=
 =?us-ascii?Q?xX9mgNJV8FAKoOcq5+rqqkIj9/W8lM+ShvztHdTlvW18qfG5/mNkjg4ZL/fN?=
 =?us-ascii?Q?4ITzPNtvwaf5KDNwVWB3J9qgj1nGifs1dp5qZz+wlwh2T7dA4EBFtTirdGrn?=
 =?us-ascii?Q?U18A//mDsd4ooyo9wq9oCw4gHg4GSvXzRBZPaYqlkBgJoL3a11qSbBc1oZCI?=
 =?us-ascii?Q?vDsrjPQZpeo+nyMLFnTJ6x041e9iDvv2UhVKKARgfAm8MILOai0rwDLJERMd?=
 =?us-ascii?Q?WDgNTmQAfO4u/KcBFgGydN3ZA9PLdDgfBixM37OM48OMfVjLdBkfsEF0cLGp?=
 =?us-ascii?Q?7WMdPr2JrKKr4GOpNlFRWFX5TYhzaa/x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FON3mNkDgxTvvCtyORiMF8zhd/Ic8VLVCHJC45KgiSYoMGrkpls5I1FrZ44b?=
 =?us-ascii?Q?f3Wd+Ke0/8/B0CJhCvZdMNQUf4IkVKb6iZN0wRwaKeKppIhGcCz6vp3pOfdh?=
 =?us-ascii?Q?ovp7eeHDhnJR1THhw9pr/MucKl0zJZqz5eBEycMNzNAYM4qsXm0nzFWGspKs?=
 =?us-ascii?Q?tGBWKGc/48KogfZyNbNuvbKsHT1IRLNbo0731ElL9r0us6zEgn5fmQQOLUtn?=
 =?us-ascii?Q?Yv/rLREUtMCPEBuJfAlHY7u7dBYnKiW8Tgv+YA/xKgXIfpfEJcyk+eoL7aX9?=
 =?us-ascii?Q?njw9v2cFf2gtdt1mLdkIc1rbsqTeiwLz28gwN123PZI7LLmA7xSl3TcrPrWo?=
 =?us-ascii?Q?NSnDnDpO80tQG+jSRvX/iMPXqKuDLKCTxdQj5PDiHRLCt0Huiw7tkrJAaNFw?=
 =?us-ascii?Q?Ed/JK5RN7bHbzqFCYNyVKWQJYM/hF06SZtVqD0K/1hGHbjixe8eTtdfP5fi4?=
 =?us-ascii?Q?CPJd8wNieUjD0sYg4KK6nvnAGGtVFhz1eSmVMcuV4mjK25cyCcWsF2fVxFAo?=
 =?us-ascii?Q?3iXWgvMJOWis+Cu+/K1x4uFhiz4FRV0EoMxpcBxBiUK4tk09kuvWHHWXOSHY?=
 =?us-ascii?Q?RhL5idKrS0NLcs8le2XgxMiCE7oE0vcfMH/FAykQdeZ7SLRLPhG+cfcEnhJQ?=
 =?us-ascii?Q?fcHuVle9yrH/r8s31no5DP1ZCYzNtUw3Dfz3RoKiTa46LtBqCJebfB3o8tjt?=
 =?us-ascii?Q?0V9j6GlNYv7sigw3aRxda86WvHFQ9rJTFiLy1NtOirqNuV5FNISocAXYGPmB?=
 =?us-ascii?Q?oJuRgtTZ92lCX6rh9MxXM7enxu2B7+oTzFv4dOedYL3rwqvwhoQAcpJfNcWF?=
 =?us-ascii?Q?3tdCLsjh4PsSPoA2TkdfCwkL8tVR+bxOFVmgUYGQ9ObmbOzNmLwREYDFp/8X?=
 =?us-ascii?Q?itIICAsn8RWn1m1LKwq3PhWeNYE+fiypwvDHOdY7oc/HXmkzrGEEYxlnIZPF?=
 =?us-ascii?Q?BwDG214uxNlB8lyYU4mN48TNxYCw13IFjUXTDb6X/odTdVx5T0D5vHqGlkIp?=
 =?us-ascii?Q?ep53hOXwIZriALBo0hAHlWWZAtDF+TAZdxjMQjSSjG1Zpsv/fudzZcmqCXch?=
 =?us-ascii?Q?HFKyewnAcByplBt48I6jyy9t/XVSRU4VYWRCCjXPse0tqVw+6bCIxQjBMdUi?=
 =?us-ascii?Q?Vu7mxOFhp0g+bjW42c9WFkOsQgzXiPkYWM2MS3k0mhI77GmomZV7rEj/EYfc?=
 =?us-ascii?Q?PYvZYtTwiw6X/1gE1FchW/OT6vDsuPf7Eoi6iQDXuJ9QqW6eTo5FI6HOEJJs?=
 =?us-ascii?Q?TUhRYsDXW5Aeqdoo/ODpxkKZCaO9CNWPoYVbTdPqEs61rylzd54DT6JRZbrd?=
 =?us-ascii?Q?mGUOcCff4b1LuNhMSCzpX1nAv+IkE9ztidPwG19g4mR5ekG3AOjSyoyhMwHY?=
 =?us-ascii?Q?UxkzBsOQwzQq/nN9rWM8ezi5ArBnVt6YXcxpAMS0UNSvOZIGvuamSoefgagN?=
 =?us-ascii?Q?vyneby0m/1VQ68Ye2GEit5dM5Ko0yBm360HYPm8oURCQbbk+d+BOPN0ckb1Q?=
 =?us-ascii?Q?uSOU+05D4dRe4qpgRioe6ZPgwdtOAep12FkpWecCL5vxreCfvIGWJTsWL6ca?=
 =?us-ascii?Q?R10yocrrb/WxJ7k5rue6W/KBru5TlXvwNr5l6vdCM3XcggBFmRLRSOQp44sV?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d98b34-ef8c-4c9b-cecd-08de0fafceb1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 08:08:09.7129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Isrd2nCKwbt3K11j5QNgKPwg+zFhpyDOXLRmdQVyst61OGpbPOyQCYuOq4CA97t2WBoiAac74NYXX4zHFInCy+59aet9r3zzgwy50nRBh6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF9623118BD
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

On Fri, Oct 17, 2025 at 06:13:49PM -0700, Stephen Hemminger wrote:
> On Wed,  8 Oct 2025 21:42:23 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > The ultimate of this patchset is to make it easier to run on systems
> > with large numbers of cores, by simplifying the process of using core
> > numbers >RTE_MAX_LCORE. The new EAL arg ``-remap-lcore-ids``, also
> > shortened to ``-R``, is added to DPDK to support this.
> > 
> > However, in order to add this new flag easily, the first dozen or more
> > patches rework the argument handling in EAL to simplify things, using
> > the argparse library for argument handling.
> > 
> > When processing cmdline arguments in DPDK, we always do so with very
> > little context. So, for example, when processing the "-l" flag, we have
> > no idea whether there will be later a --proc-type=secondary flag. We
> > have all sorts of post-arg-processing checks in place to try and catch
> > these scenarios.
> > 
> > To improve this situation, this patchset tries to simplify the handling
> > of argument processing, by explicitly doing an initial pass to collate
> > all arguments into a structure. Thereafter, the actual arg parsing is
> > done in a fixed order, meaning that e.g. when processing the
> > --main-lcore flag, we have already processed the service core flags. We
> > also can far quicker and easier check for conflicting options, since
> > they can all be checked for NULL/non-NULL in the arg structure
> > immediately after the struct has been populated.
> > 
> > An additional benefit of this work is that the argument parsing for EAL
> > is much more centralised into common options and the options list file.
> > This single list with ifdefs makes it clear to the viewer what options
> > are common across OS's, vs what are unix-only or linux-only.
> > 
> > Once the cleanup and rework is done, adding the new options for
> > remapping cores becomes a lot simpler, since we can very easily check
> > for scenarios like multi-process and handle those appropriately.
> > 
> > 
> > V10:
> > * add patch 2 to fix func_reentrancy test bug reported mid-way through
> >   the series.
> > * added patches 7 & 8 to resolve arg parsing compat issues:
> >    - support reordering args to have non-flag parameters at the end so
> >      we can e.g. mix autotest names in with EAL args
> >    - support having optional params with single-letter args without
> >      having to use "=" syntax, i.e. -l4 rather than -l=4
> > * fixed issues with the final patch when the autodetected range of cores
> >   was >RTE_MAX_LCORE
> > 
> > V9: rebase to latest main. CI complains cannot apply v8 patches.
> > 
> > V8:
> > * dropped the final two patches from the series, dropping the new -L
> >   option in favour of the -R modifier.
> > * reordered patch 11 to be with the other argparse patches (now patch 5)
> > * added patch 12, which uses macros to initialize the args structure
> >   from the arguments header file, avoiding potential issues when we add
> >   new args.
> > * simplified and consolidated lcore mask and core list parsing to always
> >   work off cpusets rather than arrays of uint8
> > * enhanced debug printouts to also work better with cpusets and handle
> >   core values in those sets >= RTE_MAX_LCORE
> > * for completeness, ensure the new -R option works for coremasks, and
> >   for cases where no explicit core-list or coremask is specified.
> > 
> > V7:
> > * expand the scope of the patchset beyond just cleanup to add in the
> >   extra 3 patches for -L and --lcoreid-base option.
> > 
> > V6:
> > * Rebase to apply cleanly on latest main
> > 
> > V5:
> > * Resubmit of V4, which didn't get sent correctly, or picked up correctly
> >   in patchwork.
> > 
> > V4:
> > * Updated patch 5 to auto-generate the arg struct definition from the same
> >   list of defines used to construct the argument list.
> > 
> > V3:
> > * Added 3 new initial patches, one for minor build-system addition, and two
> >   for functionality in argparse to allow the user-callback help function to
> >   be maintained as we move to argparse.
> > * Added doc updates in the first EAL patch adding the long options
> > * Fixed ASAN issues by adding a patch to properly clean up EAL init - both
> >   memory allocations and fixing the run-once flag
> > * Put ifdefs around the linux-only or unix-only options in EAL patch 2
> > * Updated args to handle numa-mem and numa-limit as equivalent socket-mem
> >   and socket-limit
> > 
> > Bruce Richardson (21):
> >   build: add define for the OS environment name
> >   test/func_reentrancy: fix args to EAL init call
> >   argparse: export function to print help text for object
> >   argparse: allow user-override of help printing
> >   argparse: add documentation on supported value types
> >   argparse: add support for parsing core lists
> >   argparse: allow optional flag reordering
> >   argparse: support parameters to short options without "="
> >   eal: add long options for each short option
> >   eal: define the EAL parameters in argparse format
> >   eal: gather EAL args before processing
> >   eal: ensure proper cleanup on EAL init failure
> >   eal: combine parameter validation checks
> >   eal: simplify handling of conflicting cmdline options
> >   eal: automatically init arg list options
> >   eal: add internal fn for converting cpuset to string
> >   eal: use common cpuset to string function
> >   eal: introduce lcore remapping option for coremasks
> >   eal: rework internal coremask parsing to use cpu sets
> >   eal: allow lcore ID remapping with core lists
> >   eal: allow lcore remapping with autodetected core affinity
> > 
> >  app/test/test_argparse.c                   |  695 ++++++++++
> >  app/test/test_func_reentrancy.c            |    5 +-
> >  config/meson.build                         |    1 +
> >  doc/guides/contributing/design.rst         |    2 +-
> >  doc/guides/linux_gsg/eal_args.include.rst  |   42 +-
> >  doc/guides/prog_guide/argparse_lib.rst     |  138 +-
> >  doc/guides/rel_notes/release_25_11.rst     |   18 +
> >  drivers/event/dlb2/dlb2_priv.h             |    2 +-
> >  drivers/event/dlb2/pf/base/dlb2_resource.c |   11 +-
> >  lib/argparse/rte_argparse.c                |  181 ++-
> >  lib/argparse/rte_argparse.h                |   29 +-
> >  lib/eal/common/eal_common_lcore.c          |   13 +-
> >  lib/eal/common/eal_common_memory.c         |    3 +-
> >  lib/eal/common/eal_common_options.c        | 1439 +++++++++++---------
> >  lib/eal/common/eal_common_thread.c         |   43 +-
> >  lib/eal/common/eal_option_list.h           |   98 ++
> >  lib/eal/common/eal_options.h               |  104 +-
> >  lib/eal/common/eal_private.h               |   21 +
> >  lib/eal/common/eal_thread.h                |   13 +-
> >  lib/eal/freebsd/eal.c                      |  245 +---
> >  lib/eal/include/rte_eal.h                  |   20 -
> >  lib/eal/linux/eal.c                        |  470 +------
> >  lib/eal/linux/eal_memory.c                 |    2 +-
> >  lib/eal/meson.build                        |    2 +-
> >  lib/eal/windows/eal.c                      |  156 +--
> >  lib/meson.build                            |    1 +
> >  26 files changed, 2148 insertions(+), 1606 deletions(-)
> >  create mode 100644 lib/eal/common/eal_option_list.h
> > 
> > --
> > 2.48.1
> > 
> 
> There is one other thing about eal_init. The arguments in argv can not be const
> right now, since there are cases where args are modified. Could we fix that.
> Code like dpdk-dumpcap has to strdup() the args.

I looked a little at adding some const-ness when looking at this. Two
things are preventing this:
1. While ideally we should not be modifying the individual args themselves,
   simply changing the argv type to "const char **argv" won't work, as you
   can't safely cast "char **argv" to that and you get the compiler complaining.
   [Took a bit of googling on my part to understand why this is not
   allowed, it's non-obvious IMHO!]
2. We can't make the pointers const because of getopt behaviour now
   optionally mirrored in argparse too, where it reorders non-option
   arguments to the end of the argv list.

/Bruce
