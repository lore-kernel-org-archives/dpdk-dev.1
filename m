Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DBECCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 08:12:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D9F4402E8;
	Thu, 16 Oct 2025 10:12:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id BCCDE402C3
 for <dev@dpdk.org>; Thu, 16 Oct 2025 10:12:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760602341; x=1792138341;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=tDelGk5UpjqdEE4fpdru8HrAAFzgOxdpw/SqGWMCPIo=;
 b=Mv+I4CzgWdJdhEfC5c69YS/ULXftqN0V27ioN3GzFw1kLpa8+QJNmPkR
 T1XQ4tMyQdlCwAEUpYr5yvuB8vGreyhdNU4csPbkjxMXJTYjmM0vpHemK
 FIURdvax/i6OA76drEcns+lPkRtbfZ+QSxauZsVVyGVIVSM8i+n6RXsjp
 6Ilx/hOutP2Dtx8oxFt7gCY/z5rHcuV2ln5qY4mNui2ESv0JgB3bTnU2A
 8XIXtO28cDdmQk9a3ku9xfADyWMVn3KRGVQqsQYPmNbzUiLyqSuPacEPz
 cMmjxGqYv5Q0SC5ozcSvFLoZVMQh0uwyCh11iN+8OzwdaA8JKo/tp+aTa w==;
X-CSE-ConnectionGUID: sT2CyB7ZS4KZCK1tbwEhHw==
X-CSE-MsgGUID: 88FkzZ6YTpurM81+paxU1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62937259"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="62937259"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 01:12:18 -0700
X-CSE-ConnectionGUID: 1OwTP7LWTMS2do+XXf/+dw==
X-CSE-MsgGUID: dxdb+6vzQriYR5ccu3LB5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="181599358"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 01:12:17 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 01:12:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 01:12:17 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 01:12:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmg90U9M7aNnDvVNShOfMR4JI980BHwmmVq8qC3zVYLDuODZxPhd0l+6nk5JbW0jF79wZ2NyzbWJdlXIkkgr1d0cGzJ27tMfYAd6DgbnbXYQQ+jM1ZMnG+AGg6eJhmYakoii+qWyT+efOf1nq32/29s88dwqq+kvz9rHK/7CzBNdoyDOO7ISItK0+urQ0Gr+lmOW3GtZUKYKFf0DOOrs4rF6bs85AcTFUJnPZhQ74v3lg0pn6bVgFMbNCNtKMSSYtGoEWhAE+MWEiNpe9EoS++/3QT4aeIC0TeIUzVxWtECO15vtIBCeZWtqXwPqDZi9nlsJVJ1LaigErguih5sawA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXg32IxN119z6g4iN3m89ZLUCLxW8u2F+wL4N4eqK5Q=;
 b=m+NUVO8QiXRPcUh9WZV1kcJVjFogBp6gBlINtg4KwH7puMXr33eUm/bd7P4HCF9lBSxWdUncDvn3fGmuxXSJh3C9rRbXyEhVFakTxNFDFhPrVgX2pcjQun1FH7fiBiQ6v9JFDR3Yz9+QYLfG9YJOnxHq5v8ItZ4MReNpu9Zpv+O8BtNqASh4YLjGAl/0drNk6dzFoP3nKssQmKzmIz/CHyzU314rpRAYSg0bYPUUSzrcuhqM0nF536ajUiU0cWTUYez8hR8yj0pZgUqlHhwScyMK110ylsn/evXJm9dckrTimFabU/UvFJ6JD0Xe4a6WHtIs6Q0ARsdfxpK1fKtH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7736.namprd11.prod.outlook.com (2603:10b6:8:f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 08:12:14 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 08:12:14 +0000
Date: Thu, 16 Oct 2025 09:12:09 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <thomas@monjalon.net>
Subject: Re: [PATCH v3 0/7] remove deprecated queue stats
Message-ID: <aPCo2dDI1mZjopuY@bricha3-mobl1.ger.corp.intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20251003110201.1541183-1-bruce.richardson@intel.com>
 <20251015151700.09304190@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251015151700.09304190@hermes.local>
X-ClientProxiedBy: DU2PR04CA0246.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: d36853f4-7f2f-479b-a4b3-08de0c8bb6a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZSr+nQ6JrsPV/LU3dt3sBTMRBtxXcBbKDrVJkNI+AnlQ0N6amAdc1ICBrICT?=
 =?us-ascii?Q?9QtTTj0q3i9lIi1Xo+HQa7sg1Zdk8oGlpfgEeH9Qqq2noHcJ2aVBxw/X0q7B?=
 =?us-ascii?Q?Ihfj8JeiDMxrpmgZJor2t+xuxYQU8kt+6PwDf2vIaeb9a96iGjYbFADKeaVJ?=
 =?us-ascii?Q?uqGjqH2HxEFvbquiCgK35+7WzoqJ+xZKNA8o5ANo6/NpMsttLetvfhj4JuoW?=
 =?us-ascii?Q?KDuc9rgTvifcFAgET7f6S1rQqllQUkcJ1LpYfK8RtHL/rvRC/kgcZpCopa8f?=
 =?us-ascii?Q?X8NVLpKr9i7JsqnfmgPWC5L8DbWhFoj1QlwYHjRLZLWOy1WZLNK2VbU7CFD9?=
 =?us-ascii?Q?bU2o1Q4dVe7OrNPje//bk2YQwsvX2BMG81mwtvjCCsxWxQyJQjywi02AkG2F?=
 =?us-ascii?Q?9YAjt1rBd2zUdPSIK01vL2AkJhlbJz6hM2GnhwxWExgH6TZti58vGPqqkjED?=
 =?us-ascii?Q?gsYl4lcR1vF3woYr9SGXoxE5Yu9uRFgNNjsVWSlvieMqiXRAKt6wp8mln+T+?=
 =?us-ascii?Q?V/1kXv02hv14xNfTNiM3a3JhCIem6Mp69EW1YCTNGQ95IpfYV+kPtv0BXUyb?=
 =?us-ascii?Q?w8pC4+JZqtO9v3DJUsa6g3Ax6d8sLQ9Zyb0JgI4qoVwia+VPgxXpKbUoi9GP?=
 =?us-ascii?Q?ZS/nVFuF2jaCqLJ9RnB1JaLVYxET4Mz+r/Zw3YRic191FFSH1ltWE4R9lwMf?=
 =?us-ascii?Q?nPieSCirbQQdeb6aquqsH31NQLdodDmgqaxZfO4IN/IhpH5WCSeGKgdrZRy/?=
 =?us-ascii?Q?dMqlaIRB858jgBpItKLciWoeWqc1D1Aly8gI5aUidJdTOcIXKHN22NN/X727?=
 =?us-ascii?Q?NrNZY1DXLkss1zIL+b66xewr4RN47K1EKUcQYhLZd1829z3tAU82eM+bgcvO?=
 =?us-ascii?Q?SMQ3ijreqZyXj1IR6GzP9RRe+PXrir/snENrvMwUM9Q/88nxRll+cC9V9QEZ?=
 =?us-ascii?Q?zJpXAfMVJqL+OQBmPCzFR3RIrFwwxzZ7FVQxqv16Rj+OzzQ39p4owd+Dd5qN?=
 =?us-ascii?Q?85WwJ480ZnMBESzEMoivjUzLRTJZOX1YKxs7JOVgvKoiYOseoSU7WXzQXBuZ?=
 =?us-ascii?Q?IwtzAgMcBlsvc1Cy0hLrtviR/qmIPFWhaq+jhOOT2WwLsqBhLOkkE2u+tHhy?=
 =?us-ascii?Q?idYNpkgz3KTn9rd3x+o1r91rLOXGUrI1GMp9JShQkyelDz4pQacYDOcVNCKP?=
 =?us-ascii?Q?60OgRbFj//U2RphEcDQPkUO7jysrj+Z4FgrttE1nfZcgX0IvRxjDiQXZQyey?=
 =?us-ascii?Q?SlpzvcJYsdsIugNcdGORXU2l8eWrLTflTZ8dFQpbgwuPNaH7T1wxTlLB85Rt?=
 =?us-ascii?Q?jcy9401kod/brMe9bJGh+KEl3jMVPEDOzfU3SCOpqoRF/rImV2xcFB2fgy3K?=
 =?us-ascii?Q?Zn/sT+JAeo9hXn5qUJ4HB8HK2YReihykCCBPagjCZjV3gW3PsYFJi33nZD+U?=
 =?us-ascii?Q?Vn3enw6+RgITRRY2wOcaMz8m37x1swcL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X3wSLpuXiRcRo0FBqPkuqvC4zO6vBo8crUf9D0rjGd+5cvuPbm0btsZtoWve?=
 =?us-ascii?Q?UAZPtH+HznYGL79lHa2ftfD3nmrQsqYwVgp+3B1L7/wk7JQvpsozMz4T3kF0?=
 =?us-ascii?Q?Gl6LvZnmM9+nptp25h6aYYwpv6hA4kGlg1/QMHdWIbQm5bQa6/UF5Wr30GUX?=
 =?us-ascii?Q?pReKeJtkTdOoQp4USZ2npd1GhvGL1HN7hujamVNUGeooRnhucx/PgZHYG+pf?=
 =?us-ascii?Q?r1gj7FZ8JA6pmQQ6y5qy8wUuPMQHK9rK3Ljsswkir3Caw8xFc3GFAZEU5ZDc?=
 =?us-ascii?Q?E48tq/CjiyBDwG3swpkKhUvYN/Vtnyhg8QmH60LdAxH6/Qm/jrWakWoo5dhb?=
 =?us-ascii?Q?/HlXCIQ0mx7B0q3qOlINk7cGHLi/UvRSr/O1T/OJ+EVV9WnnOM/UB6+Hbdr+?=
 =?us-ascii?Q?gqXw7TaiGnEmgpIXiHya52ZO3S9AWqAC6BMdJJ0yMglxNZNuLBragVwsWacW?=
 =?us-ascii?Q?5kCVmQhPyS6JnNB3vbp/SMqJ+Gzki9CNgbjo+YAvH8g7JUx2KIhSvDnW65L7?=
 =?us-ascii?Q?rDR8t2ZddPSQgTeAQvb5+04T3WD8Motnw0C9r32ORQ+j+DhroaKXJ9h9MJv4?=
 =?us-ascii?Q?cIRAxPWiXGR401XBGwN1Ngahw06IYBGEDvZjqjD0svCRrrTKWl5s8WbD+P0w?=
 =?us-ascii?Q?1urFuro2e2JHE56NM3Kvta0BCg1U2xD4ffy8zdX8Q3/3NH0YYAjvs2burH9c?=
 =?us-ascii?Q?yLk+n/Vr1SgIOuYUKQBqqbiAq6cuzPZX9e+sv422shUzuBIwkBGlIstGx6gT?=
 =?us-ascii?Q?uKcS/5V2rx1fOADNAa7xzXMP24jGHrDJE1oN8VZKwsQ74zzvURJRB4RmcbUH?=
 =?us-ascii?Q?4FODKMvOtix7t1En+aHt914YGoeF+dhH1KmpCnzMv0MMQTcvb/vHPki5sbVo?=
 =?us-ascii?Q?ezp9hX1URMo6q66Rsv0/3WHiDrQzUThOp2PtJh1J+rBKhxGQpgieN8vIg/oD?=
 =?us-ascii?Q?ak6V14E5M8Adqgaqne1TNUohXeET4IXT8blcX4EaIcjYk7iAhHLZF+hrAfRz?=
 =?us-ascii?Q?znzFyo51ne7BSn9HLHOUyl1IkrTD/Q07hTuZarUWOOC5voC153N/vVdSCM5W?=
 =?us-ascii?Q?8yXDkdA1m9hFX7f2h8rcPtHjiaTCnIM0k8aOqSeOFN7VwbawWWB3LhusA7hz?=
 =?us-ascii?Q?qe+3OMJyhf2zTbe149WD7ZpP57i2drY8hIvGTRU2NWgfoUT3xqOJ4nzWndyg?=
 =?us-ascii?Q?MM6XhXn8YTzY7MP0tmUwin+OSYjmfHbXfQSksGtWwz5mSr8AoerUUHXEJ28h?=
 =?us-ascii?Q?RUB7RdtwIh6AojPQNmiYgMmgO36Q9vKIIgauUaKXYcW8QSWoXG9bhWyrS04R?=
 =?us-ascii?Q?BCj46xa1QccAu9+NvCUMceWRpwOm8uEIZyaMzfXnBabY0BNboYjYd9usjVcK?=
 =?us-ascii?Q?yivVf8cubaVP7LX7bRcTqm8SMri3qJiw9TqvdAlzRMkItYweVW6C0VQk04Fg?=
 =?us-ascii?Q?88N+ADqsW3k54XbOO+pUktm8EBsBdXY6adabBd8vaigAkshZEeAlG8UjmnW8?=
 =?us-ascii?Q?n9Rh2SLUZhCarLJ5aRHj5ryJJxx++sScXyLxnf9JIXqLhDvV/C0giWMPrUwQ?=
 =?us-ascii?Q?R6Upy/UV2ymC6stiXEERbOMbIVZSKlRK95DfuSk1j9Sb/cN6w9ys3znpESvs?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d36853f4-7f2f-479b-a4b3-08de0c8bb6a5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 08:12:13.9847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHUHVzmzd63mcPyCpuuAUT/azJ3EDCF+xUQX0vE9JcznVLbgYjsYDagEKyp9mcoYA55deL0tsb61elRQE4NBZSQ7HR1l+CKD4p1i95KpdhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7736
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

On Wed, Oct 15, 2025 at 03:17:00PM -0700, Stephen Hemminger wrote:
> On Fri,  3 Oct 2025 12:01:54 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > NOTE: as called out below, on apply patches 3-6 should be squashed. They
> >       are separated out here for easier review!
> > 
> > Since DPDK 20.11 release, the use of queue stats inside the rte_eth_stats
> > structure has been deprecated with the intention to remove them. Sadly,
> > despite 5 years passing that has still not been done. This patchset
> > finally attempts to fix that situation and remove the queue stats fields.
> > 
> > The biggest complication here is the fact that, as part of the deprecation,
> > a new driver flag was added which caused ethdev to automatically add the
> > queue stats into xstats. While this was good, in that it allowed quick use
> > of xstats for getting queue statistics, it now causes lots of problems
> > because we have 35 drivers (by a rough count using grep) which rely on this
> > functionality to export their queue stats via xstats. This means that if we
> > drop the queue stats fields from the regular stats structure, then 35
> > drivers will lose *all* queue stats reporting functionality! This is not an
> > acceptable situation IMHO. [And in one patchset trying to change all 35
> > drivers to directly export via xstats is not feasible either, since adding
> > extra xstats can be very complicated at times.]
> > 
> > Therefore, we need to make changes that a) removes the queue fields from
> > the regular stats structure, while also b) continuing to allow the
> > individual driver stats_get functions return those stats to ethdev for
> > filling in. I tried a number of approaches here to find one that was most
> > feasible to implement for large numbers of drivers, so that either scripts
> > or AI assistants could automate a lot of the changes. The most feasible
> > approach I found was to define a DPDK-internal queue-stats-only structure,
> > which would be passed as a 3rd parameter to the drivers' stats_get
> > functions. When calling stats_get from ethdev, this third parameter would
> > be NULL, but for gathering xstats, it would be non-NULL for drivers which
> > have the RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS flag set.
> > 
> > For this set, I've separated out the driver changes from the ethdev changes
> > and the app changes, since the driver changes are so numerous, making the
> > rest hard to review. In order to ensure clean compilation and git history,
> > patches 3 through 6 should be squashed into a single one on apply.
> > 
> > Beyond these patches, more cleanup should/could be done:
> > * ensure that any drivers which don't set the AUTOFILL flag have the qstats
> >   parameter set as __rte_unused.
> > * For those that do use the AUTOFILL flag, we should ensure that they
> >   actually do fill in the stats, and not just set them to zero. (First two
> >   patches here fix that for a couple of Intel drivers)
> > * then work to reduce the number of drivers which use the flag to set the
> >   xstats, with a view to completely removing the queue stats from regular
> >   stats functions.
> > 
> > ---
> > 
> > V3:
> > * added deprecation of the queue stats mapping functions at as final
> >   patch at the end.
> > 
> > Bruce Richardson (7):
> >   net/ice: don't report empty queue xstats
> >   net/ipn3ke: drop unsupported per-queue xstats
> >   ethdev: remove queue stats from ethdev stats structure
> >   drivers/net: update to remove queue stats from eth stats
> >   app: remove queue stats from eth stats
> >   doc: update docs for ethdev changes
> >   ethdev: deprecate queue stats mapping functions
> > 
> >  app/proc-info/main.c                          |  16 ---
> >  app/test-pmd/cmdline.c                        |  57 --------
> >  app/test-pmd/config.c                         |  36 -----
> >  app/test/virtual_pmd.c                        |   3 +-
> >  config/rte_config.h                           |   1 -
> >  doc/guides/rel_notes/deprecation.rst          |  13 +-
> >  doc/guides/rel_notes/release_25_11.rst        |   6 +
> >  drivers/net/af_packet/rte_eth_af_packet.c     |  13 +-
> >  drivers/net/af_xdp/rte_eth_af_xdp.c           |  35 +++--
> >  drivers/net/ark/ark_ethdev.c                  |  36 +++--
> >  drivers/net/ark/ark_ethdev_rx.c               |  14 +-
> >  drivers/net/ark/ark_ethdev_rx.h               |   3 +-
> >  drivers/net/ark/ark_ethdev_tx.c               |  12 +-
> >  drivers/net/ark/ark_ethdev_tx.h               |   3 +-
> >  drivers/net/atlantic/atl_ethdev.c             |  19 +--
> >  drivers/net/atlantic/atl_types.h              |   1 +
> >  drivers/net/avp/avp_ethdev.c                  |  20 ++-
> >  drivers/net/axgbe/axgbe_ethdev.c              |  22 +--
> >  drivers/net/axgbe/axgbe_ethdev.h              |   1 +
> >  drivers/net/bnx2x/bnx2x_ethdev.c              |   3 +-
> >  drivers/net/bnxt/bnxt_reps.c                  |  14 +-
> >  drivers/net/bnxt/bnxt_reps.h                  |   2 +-
> >  drivers/net/bnxt/bnxt_stats.c                 | 133 ++++++++++--------
> >  drivers/net/bnxt/bnxt_stats.h                 |   2 +-
> >  drivers/net/bonding/rte_eth_bond_pmd.c        |  14 +-
> >  drivers/net/cnxk/cnxk_ethdev.h                |   3 +-
> >  drivers/net/cnxk/cnxk_rep.h                   |   3 +-
> >  drivers/net/cnxk/cnxk_rep_ops.c               |  15 +-
> >  drivers/net/cnxk/cnxk_stats.c                 |  49 ++++---
> >  drivers/net/cxgbe/cxgbe_ethdev.c              |   3 +-
> >  drivers/net/cxgbe/cxgbevf_ethdev.c            |   3 +-
> >  drivers/net/dpaa/dpaa_ethdev.c                |   3 +-
> >  drivers/net/dpaa2/dpaa2_ethdev.c              |  28 ++--
> >  drivers/net/ena/ena_ethdev.c                  |  46 +++---
> >  drivers/net/enetc/enetc_ethdev.c              |   4 +-
> >  drivers/net/enetfec/enet_ethdev.c             |   3 +-
> >  drivers/net/enic/enic.h                       |   3 +-
> >  drivers/net/enic/enic_ethdev.c                |   4 +-
> >  drivers/net/enic/enic_main.c                  |   3 +-
> >  drivers/net/enic/enic_vf_representor.c        |   3 +-
> >  drivers/net/failsafe/failsafe_ether.c         |   9 --
> >  drivers/net/failsafe/failsafe_ops.c           |   3 +-
> >  drivers/net/gve/gve_ethdev.c                  |   4 +-
> >  drivers/net/hinic/hinic_pmd_ethdev.c          |  64 ++++++---
> >  drivers/net/hns3/hns3_stats.c                 |   4 +-
> >  drivers/net/hns3/hns3_stats.h                 |   3 +-
> >  drivers/net/intel/cpfl/cpfl_ethdev.c          |   3 +-
> >  drivers/net/intel/e1000/em_ethdev.c           |   7 +-
> >  drivers/net/intel/e1000/igb_ethdev.c          |  14 +-
> >  drivers/net/intel/e1000/igc_ethdev.c          |  33 +++--
> >  drivers/net/intel/fm10k/fm10k_ethdev.c        |  27 ++--
> >  drivers/net/intel/i40e/i40e_ethdev.c          |   5 +-
> >  drivers/net/intel/i40e/i40e_vf_representor.c  |   2 +-
> >  drivers/net/intel/iavf/iavf_ethdev.c          |   5 +-
> >  drivers/net/intel/ice/ice_dcf_ethdev.c        |   3 +-
> >  drivers/net/intel/ice/ice_ethdev.c            |   7 +-
> >  drivers/net/intel/idpf/idpf_ethdev.c          |   3 +-
> >  drivers/net/intel/ipn3ke/ipn3ke_representor.c |  14 +-
> >  drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  29 ++--
> >  drivers/net/ionic/ionic_ethdev.c              |   6 +-
> >  drivers/net/ionic/ionic_lif.c                 |  35 +++--
> >  drivers/net/ionic/ionic_lif.h                 |   3 +-
> >  drivers/net/mana/mana.c                       |  15 +-
> >  drivers/net/memif/rte_eth_memif.c             |  15 +-
> >  drivers/net/mlx4/mlx4.h                       |   3 +-
> >  drivers/net/mlx4/mlx4_ethdev.c                |  17 +--
> >  drivers/net/mlx5/mlx5.h                       |   3 +-
> >  drivers/net/mlx5/mlx5_stats.c                 |  17 +--
> >  drivers/net/mvneta/mvneta_ethdev.c            |   5 +-
> >  drivers/net/mvpp2/mrvl_ethdev.c               |  23 +--
> >  drivers/net/netvsc/hn_ethdev.c                |  17 +--
> >  drivers/net/netvsc/hn_var.h                   |   3 +-
> >  drivers/net/netvsc/hn_vf.c                    |   3 +-
> >  drivers/net/nfp/flower/nfp_flower.c           |   8 +-
> >  .../net/nfp/flower/nfp_flower_representor.c   |  19 +--
> >  .../net/nfp/flower/nfp_flower_representor.h   |   3 +
> >  drivers/net/nfp/nfp_net_common.c              |  46 +++---
> >  drivers/net/nfp/nfp_net_common.h              |   4 +-
> >  drivers/net/ngbe/ngbe_ethdev.c                |  53 +++----
> >  drivers/net/ngbe/ngbe_ethdev_vf.c             |   5 +-
> >  drivers/net/ntnic/ntnic_ethdev.c              |  22 +--
> >  drivers/net/null/rte_eth_null.c               |  15 +-
> >  drivers/net/octeon_ep/otx_ep_ethdev.c         |  17 ++-
> >  drivers/net/octeontx/octeontx_ethdev.c        |   3 +-
> >  drivers/net/pcap/pcap_ethdev.c                |  23 +--
> >  drivers/net/pfe/pfe_ethdev.c                  |   3 +-
> >  drivers/net/qede/qede_ethdev.c                |  23 ++-
> >  drivers/net/r8169/r8169_ethdev.c              |   6 +-
> >  drivers/net/ring/rte_eth_ring.c               |  13 +-
> >  drivers/net/rnp/rnp_ethdev.c                  |  15 +-
> >  drivers/net/sfc/sfc_ethdev.c                  |   3 +-
> >  drivers/net/sfc/sfc_repr.c                    |   3 +-
> >  drivers/net/tap/rte_eth_tap.c                 |  23 +--
> >  drivers/net/thunderx/nicvf_ethdev.c           |  27 ++--
> >  drivers/net/txgbe/txgbe_ethdev.c              |  53 +++----
> >  drivers/net/txgbe/txgbe_ethdev_vf.c           |   5 +-
> >  drivers/net/vhost/rte_eth_vhost.c             |  26 ++--
> >  drivers/net/virtio/virtio_ethdev.c            |  23 +--
> >  drivers/net/vmxnet3/vmxnet3_ethdev.c          |  20 +--
> >  drivers/net/xsc/xsc_ethdev.c                  |  19 +--
> >  drivers/net/zxdh/zxdh_ethdev_ops.c            |  39 ++---
> >  drivers/net/zxdh/zxdh_ethdev_ops.h            |   3 +-
> >  lib/ethdev/ethdev_driver.h                    |  35 ++++-
> >  lib/ethdev/ethdev_private.c                   |  27 ++++
> >  lib/ethdev/ethdev_private.h                   |   5 +
> >  lib/ethdev/rte_ethdev.c                       |  37 ++---
> >  lib/ethdev/rte_ethdev.h                       |  13 +-
> >  lib/ethdev/rte_ethdev_telemetry.c             |  20 +--
> >  108 files changed, 921 insertions(+), 794 deletions(-)
> > 
> > --
> > 2.48.1
> > 
> 
> 
> LGTM
> Do you want me to fix the checkpatch stuff or do you want to send
> a new version.

If you can just fix on apply it's probably easiest, please.
