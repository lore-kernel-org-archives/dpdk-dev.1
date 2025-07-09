Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8392FC83F09
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 07:51:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7122A4021E;
	Wed,  9 Jul 2025 09:51:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id B48074013F
 for <dev@dpdk.org>; Wed,  9 Jul 2025 09:51:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752047486; x=1783583486;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Few2K0GwtstJVu2WcvIoUgHn/J+8c3apEHpqzbmmE2M=;
 b=MOo+hrAbc54JmSSdgVjYVEjpqTZdm28dbfRo0EBAcJNdlgyBw0bSm34D
 mIUCtwD2qlWNrwcGBEjQ/8oqmUK6oPszSMapIWvbZNrv8s0G3FPOsQ3/O
 Jza4NpfBgSUAS+jmD8SleWIJEzO32N+Jg60d3Lx94sy+AinvRAyNQea4X
 Azv1jiZFx5ExU02N6xCAyrX/41zLWcZA/R91oPwOTzWG5P9OVKiA1b73Z
 iop8tNZNDAHZvhI0pBQecBiQoSI5iQpCNfnMc6Fu7vDapjiPUaFTBnBEB
 SeXWliFKINtW7gfLQcnqcatC4VLMrir6+8IMPW68nkid0uYhd9HIjdFnP A==;
X-CSE-ConnectionGUID: gl7Tg4NDS1qM3Y0uIahatA==
X-CSE-MsgGUID: EyhBxcn3Q8K5MAUaaRGTTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54441097"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="54441097"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 00:51:24 -0700
X-CSE-ConnectionGUID: 4pp/gb4XTkeL9mrSQjFzkw==
X-CSE-MsgGUID: UffIbbzwTNytXgzbDUD6vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="186710960"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 00:51:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 00:51:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 00:51:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.83)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 00:51:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqDcRtSSpOmzpXE/93FwPKsMdVEK6q/mSImrA1pbyg2TdiRXYgPg6Pc03eutlZgjI8kUOdIrShL4cRsGVQHi+byOuLXUFVBRaMpAQR2gxGuvA6DIxPcVyLe3kLfIMGoRBRY8sO9IW5RAi6ufQKp94N+JwyaWWlx7n9pOBsF9AZld9Xc3blVKNdiN28zQjev3Av0lE6y32xt+X1Zx7QWRooiD5f++ZrOaDJlUvaiH6Uh/YtFVAhVHA1OlRPCEaHn65od+nd1m2u2HOUxniBCkSxTte/xVpNd8h2gwlxP7y69TRJ0FXYLgnp12R0T+PfncG3yymjNwcUG/ad/welrs4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/6CMj/cYbBQ/68h/axH4JGlSyhKx1BXXUBGZibYIj8=;
 b=TiktxOk6ec5qv3ok0ntIC1qdEgjmhH5rOS+xWkxghXc3PeRyFajBNBXf+qmbh1wks7s51Ts/GqlMM55tG5BlK2EKi23IZ2RjcIYaFt/D10JPhSBMnw2/y4u/UDzD2kxQciJLxOIdUYprLzdgBmqamcVX6JXzRqvzsnFdLE59Pr1k7iZ4QDe3waTxnzne5umsBI+vPxQr4lyh//NYm3EFwxwBEy5Fv6DbsTTh1D4/U41grnH4GXna32WSYp6bwpqbYqNSxEFJQP2QO9G2KwGgCIhYgt9ubnR6ttpvxor1AjuV6qZK8hczIrukoBOGlH4lZesHRcJfHaSDBzUpaz8Y1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB7432.namprd11.prod.outlook.com (2603:10b6:510:272::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 07:50:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 07:50:53 +0000
Date: Wed, 9 Jul 2025 08:50:48 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH v2 0/5] rework EAL argument parsing in DPDK
Message-ID: <aG4fWAy661CCNsg8@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250708172039.183989-1-bruce.richardson@intel.com>
 <20250708114101.22db6a9b@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250708114101.22db6a9b@hermes.local>
X-ClientProxiedBy: LO2P123CA0085.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: fe9a90f4-3abd-4f77-4963-08ddbebd543d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iVeISpdiMfZ5mH7yv9Rf8NvImXdCArv9SEX8Vd0bAf86p8SFmfcrDWLl6tnf?=
 =?us-ascii?Q?cpPwFb6NuNgRO/hkmwgoG2u93xQmhTG4J1LEQBV2M0O/R6bA4BXMidtnkiCD?=
 =?us-ascii?Q?d4PI0B7Jw7iJEl1MSGMVlbliEOpJcthQHgHXPWt4xLoE1vt4F3TVjk1YYHhE?=
 =?us-ascii?Q?IH85QR3OMowp42nz2ygrnJTaVkXggDWKZQKr+0V/COWpotYij7hkahmV1oeu?=
 =?us-ascii?Q?mt/KYWKSYVJbjLIH2s9Mz+SpccwiqfrBViF1+9uK8MCokXIrzgqbbQvVNnF/?=
 =?us-ascii?Q?n3XYN8K0B4coh9uy4gE1jc+eXpWwUCLIMrO966E/JGsuz1vsq8AoxhgB8QNc?=
 =?us-ascii?Q?tJfgZ/Tt8SMknxg+41Rm59WDGENkmblAxOX5fw59o/N8/MvrNJLK5cZPD5+6?=
 =?us-ascii?Q?G/AlY8MuyZe7edkI6z9wLHiMw46IDCpLWyVfMfcal3dPG6Jv7+1VPr8BkxRi?=
 =?us-ascii?Q?A5MYqLKv5l0jEJt8xvKRJPSJOQHX0d7jNh/Yj4cMAy0prFftlf0OT5BEk+at?=
 =?us-ascii?Q?jDzPFjpLbZp2QFSH19nIdrJJM28Kgl86IcZ++ujdvPNFg2T+drLSbCSMOMP4?=
 =?us-ascii?Q?dFHYsZ0S7q8ZxYbCSTwHTBOgDfQpDrcWZzLUShhFGiM7n9xUVVQnYEUzPWX1?=
 =?us-ascii?Q?tbz9bIFKS0BZClB0FKpgHFwuUhld+XdzICnDKdgx9s6FMYSruA0VI3TC9RXA?=
 =?us-ascii?Q?RXPVbJEEjfc5N+IxYrJChUOGf9DHizzjhecN8r2+Z3xkrfPj0kTa+QqKRQnE?=
 =?us-ascii?Q?E2hMSuKSRIgPlMOiEu3RAwA1z3b3LX0duHDdB1uFaQKQz+A1Ly+nw9dqwbik?=
 =?us-ascii?Q?1ejko2Ww2fnJUvFjiFy/dWpaNpdULiYW/m0wMHa4xtF2gn+p3DO0uxO6b5mZ?=
 =?us-ascii?Q?B4OMQ0ezr0p6ooZzUPC4KYconwpmUVRgBNLifZXJGCoESmsaBu7NUfACjA/H?=
 =?us-ascii?Q?Lq9SorKUrW6TQ+YL0Nph0dRxBuL4DuyLYgsAuFvHEvWbubFdZsVCSRXd8XAa?=
 =?us-ascii?Q?z5PvSJq99bwXal7FV7DDKeK/qlCrg5vOYuWkmutKPv3VQY01ZJA3kmpNepC6?=
 =?us-ascii?Q?QwfXqpXgjE4VUBl7fZuY7qhpX/Umr4ApHbbx2X5UZyrUu0hZchD7IGpKD7Gq?=
 =?us-ascii?Q?FSN6Qs90SYB0RJs9yhvUjblToARj2tLC9ssfhAVQKZ5BLUKeEIgea9W7dR+n?=
 =?us-ascii?Q?qkaN6Af1E+CywOZMvhxSyR7ltOr2nU8GmKEExj8qW62cHc1rI+wd86e7MyWO?=
 =?us-ascii?Q?/jlvM54jP0KY3c6VnE5GzFlh0/cOD77FSWVfKtiVhtwycn6+JstWfVgvEVVG?=
 =?us-ascii?Q?z1806Q+HmR3d+TokZY+/swBlSPqK7qmsPK5IrvDH2yIuImQmU2Tkd/OcWkEm?=
 =?us-ascii?Q?ZcSwf6D82OYa0Vft398/67CqZfNJv2ipz+0JXwLrrcNd2ewhDtryRHlXNeOx?=
 =?us-ascii?Q?ckc7MXZgQ/g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6x4XS7JfsYBLpH9QuAjF/qWfrIlqf2kHQeLZhnUWhrgHlWC6Y0qklTvcKjTT?=
 =?us-ascii?Q?6KABzo+C0j7roLlw3LJKFrNgair2jEKcB0ofa+fhLzP5q+1QhAcdg8kbSRtf?=
 =?us-ascii?Q?TmI7tUha8kNUXpCA8NK6D1Oj9V0jTkNIvsShThkdW3ExI64q5MoTMe7qfxYj?=
 =?us-ascii?Q?ifhdyRePZ5SG9BuUrBlyUZ4mkIKj3Nz/v1So5AnXX7evCPg/fCEZAJL1RtMR?=
 =?us-ascii?Q?7V/pyiEwkvj9FuZImcnqypRL89Jqqq5JrmLEZBkSaAi5n/YtkbpLrEJ5TZY6?=
 =?us-ascii?Q?78eH3mSJF0BLemUdcSe520+z95BKd7Qlbjco47L2luSsgAYrlgTrty2dEozP?=
 =?us-ascii?Q?4gDBZiM6PmDh/19647mK03OqIAwK5w3w8/80Lvi2Q79qOVYRt3lUj9H7SE2W?=
 =?us-ascii?Q?sdrn6l7H0AxRSvdKk+8Ngycp7/SANaWirAhw3n928BLE4562CIwtqo4Kt6IC?=
 =?us-ascii?Q?/3Ha+d6dojGnX9c2hs2IBbBG6PSiIEH3bpdS0E2CYQge8oJe3UPEgxAUZbnY?=
 =?us-ascii?Q?JTNZ2583XtughhAX7XZRyT2sS6sjEwrs0/YyPaNAQ1lQQkv/KAtv1vvGojaj?=
 =?us-ascii?Q?554irgFOuCF4dZLOsjsmzxnTmCEg+krb6NMqG8opN/1t4RBwaXenzEO0Du2p?=
 =?us-ascii?Q?+3HjM2IvyvVrk9Lfev4GUz3AuXtQTaNbNrOd5DSuBH6JcvCLuOUNj990LIdE?=
 =?us-ascii?Q?aJKoao+QEvpewUbWuiTL3RX4qU/Z9yUjPjHMkNhOL54/TPEybTPzZ89UAh1k?=
 =?us-ascii?Q?hTFszqX6DEKAd9sgmpHw2WEa5WCyXs5stoLbhymvYDyQa0BLIiT/nKOqq35P?=
 =?us-ascii?Q?emhkkNOT9zDYqTD7ADe3ug8epiMPa5+gSDPd21ZKVdBf/fq5hiXvRY5Mn/aR?=
 =?us-ascii?Q?igm3kHwZdFWHgovM7vjY97yk0solQN3K089lEIkyO6+IEXUt7rH3nTFoRTJO?=
 =?us-ascii?Q?PMWX8q9NHz+np+JuLXvZJ76NzThwXyNHzbT4kh5VLniwjzj9n0VOZtNL/TQ/?=
 =?us-ascii?Q?EkSoS5Cm4bHyc2LKIapk9efKLRHWv59ecRyw+aT232rGhfJ1L2FRZkbaATT1?=
 =?us-ascii?Q?q5MK9HDxtnBaA+NQVIs7F/4UTAQRz9Ab2/cxV90HJe2PpFHvI+0yn+Qr8b0V?=
 =?us-ascii?Q?2XLrPtuWnZuDEl9qqKAActQEHDpMif5I/hJMYnkv+vAs7gfU4KdmY3V0t493?=
 =?us-ascii?Q?kkwSN7DR+Yzt/m7ot/t1cYTwxId43yTzz4ca8PIVfowmhR0EgpBxx2YgqIdX?=
 =?us-ascii?Q?SV8+DvMu5NQsgJC5cOIQH1jCeFUBTW1hsNLgvZfs1jCfU0YXIwl77HFiluhQ?=
 =?us-ascii?Q?UL/cXjj26rkYDnLgAd2o/ow7GfXilI6OPlvUHU4zxz7KIwZcXPmRoLRpL9Af?=
 =?us-ascii?Q?iBSPjjhTwAJNdQ23AICeBKqR09tylBR9zNj5bZJtWl0/netuhEcY1ycJIosx?=
 =?us-ascii?Q?5p5++MLBrsjasP/kCmOF8EAdNem/JYjWJnceKhuDXb/dxmX6yGdoESl6Dbl4?=
 =?us-ascii?Q?VrsYiUWOVPX53LimAKToISdba9pevLURLDpT8JQ8ga7dpxGxCpfdlJRE2UZm?=
 =?us-ascii?Q?fSHMaaeaBYsSHvxLBktcaHnFQi8TegTmg5Dtec/vdPWjwpOIiRrNil3dDicQ?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9a90f4-3abd-4f77-4963-08ddbebd543d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 07:50:52.9995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nE/+ZYh15RscPejyTLFmRHj/WlHAfXrzrL3wNamPSzV7A4hbRfBr2IXRpByeUNkt+dm/oxnDR6ut9OxE6yAWIUutirrmCVPWtVbkbP2vGI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7432
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

On Tue, Jul 08, 2025 at 11:41:01AM -0700, Stephen Hemminger wrote:
> On Tue,  8 Jul 2025 17:20:34 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > This RFC is a second, more complete, prototype of one approach we may
> > want to take to help improve management of EAL cmdline arguments.
> > 
> > BACKGROUND:
> > - The first problem that led to this work was that of providing a
> >   way for users to easily provide a set of CPU cores to DPDK where the
> >   CPU ids are >= RTE_MAX_LCORE
> > - There are a number of solutions which were discussed for this, most
> >   of which involved automatically remapping CPU ids to lcore ids
> >   starting at zero.
> > - However, in discussion with David M. at the last DPDK Summit in
> >   Prague, he pointed out the main difficulty with all these approaches
> >   in that they don't work with multi-process, since we can't reuse lcore
> >   id numbers in secondary process.
> > - This in turn lead to a realisation that when processing cmdline
> >   arguments in DPDK, we always do so with very little context. So, for
> >   example, when processing the "-l" flag, we have no idea whether there
> >   will be later a --proc-type=secondary flag. We have all sorts of
> >   post-arg-processing checks in place to try and catch these scenarios.
> > 
> > This patchset therefore tries to simplify the handling of argument
> > processing, by explicitly doing an initial pass to collate all arguments
> > into a structure. Thereafter, the actual arg parsing is done in a fixed
> > order, meaning that e.g. when processing the --main-lcore flag, we have
> > already processed the service core flags. We also can far quicker and
> > easier check for conflicting options, since they can all be checked for
> > NULL/non-NULL in the arg structure immediately after the struct has been
> > populated.
> > 
> > To do the initial argument gathering, this RFC uses the existing argparse
> > library in DPDK. With recent changes, this now meets our needs for EAL
> > argument parsing and allows us to not need to do direct getopt argument
> > processing inside EAL at all.
> > 
> > An additional benefit of this work, is that the argument parsing for EAL
> > is much more centralised into common options. This reduces code a bit.
> > However, what is missing here is proper handling for unsupported options
> > across BSD and Windows. We can either take two approaches:
> > 1. just ifdef them out so they don't appear in the argparse list on
> >    unsupported platforms, giving errors when used.
> > 2. keep them in the list of arguments, and ignore them (with warning) when
> >    used on unsupported platforms.
> > The advantage of #1 is that it is simple and correct, but the advantage
> > of #2 is that is makes it easier to move scripts and commandline args
> > between platforms - but at the cost of the arg list shown by help to be
> > less accurate.
> > 
> > Bruce Richardson (5):
> >   eal: add long options for each short option
> >   eal: define the EAL parameters in argparse format
> >   eal: gather EAL args before processing
> >   eal: combine parameter validation checks
> >   eal: simplify handling of conflicting cmdline options
> > 
> >  lib/eal/common/eal_common_memory.c  |    3 +-
> >  lib/eal/common/eal_common_options.c | 1236 ++++++++++++++-------------
> >  lib/eal/common/eal_options.h        |  101 +--
> >  lib/eal/common/eal_private.h        |   11 +
> >  lib/eal/freebsd/eal.c               |  164 +---
> >  lib/eal/linux/eal.c                 |  384 +--------
> >  lib/eal/linux/eal_memory.c          |    2 +-
> >  lib/eal/meson.build                 |    2 +-
> >  lib/eal/windows/eal.c               |  113 +--
> >  lib/meson.build                     |    1 +
> >  10 files changed, 726 insertions(+), 1291 deletions(-)
> > 
> 
> Could DPDK use a better 3rd party library for arparse like:
>   https://github.com/cofyc/argparse
> that one is MIT license so free to reuse, etc.
> 
> The project does have a bad habit of reinventing existing more complete
> existing libraries (for example RCU).

It could, but that would be a separate effort. Since we have the argparse
library already in DPDK, I don't see the point in using a third-party one.
Now, if we want to take the decision to remove our argparse library and
recommend an alternative, that's fine, and I'm sure I'll be able to rework
this patchset to use it. For now, while we have our own argparse, I think
it makes sense to us it rather than have another dependency.

/Bruce
