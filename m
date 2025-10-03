Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B247ACAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 11:04:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ADF2402BB;
	Fri,  3 Oct 2025 13:04:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 6D1EF40262
 for <dev@dpdk.org>; Fri,  3 Oct 2025 13:04:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759489464; x=1791025464;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6LOS71F9T2CdEQ1s/N1ORAAz0hyvnH+QJolKyOfThoI=;
 b=dKerawrvBT3SMDtK/Kr38OTkdpOxnqGGOE3IWFWU6lPPM89lD58qg472
 hsWNvRnoGhRk4ux3abxHZwFNL2tAWkD8pODe1tJ6zaNu2uX8dq2jLWh8C
 URrO+N5vRZqPxoWs73F/bgp2ynWmwND2zYsfE+P8a/l7RjFPW1bCsIVHA
 3ThobeIppPjjg9QW2Tdym12VNgnrfR+DmeDYRj3eQUDDxBroOmeZ9AIwm
 Cvs2uHJNBTB85afejN2Evg3WZvdnspjcjoxG++5lsO+I/GaYHFIYRmPOW
 /JdImc3T1n6lrhRVeh+b7nnXKmPvrVlwI0NIn9KmH6wqJW3F5sMvRMwXE A==;
X-CSE-ConnectionGUID: 92Xam2FXTtOXVYEqEqpTDQ==
X-CSE-MsgGUID: QhbA4YBXSKGqPhRZeMyiTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="72448532"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="72448532"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 04:04:23 -0700
X-CSE-ConnectionGUID: ylHTYhwaRRq/ksUlJosSjA==
X-CSE-MsgGUID: 64UjNby9TT2Fhn0q/+TYKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="179683310"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 04:04:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 04:04:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 3 Oct 2025 04:04:23 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 04:04:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDJ+YJp7HFdiSWcw3h57avpWYEh8adfhgxESCarZLc+3kpDjpMriM0UScRcOi5I1pghCJLJFnEtDKyCk8Hk5cszB34ldQGxO7c/AoX4rNFLZ4qBDkgo9yriRlRy9+VC4KviG+3UcSoV3wTOO9ZikFHQx57+lYLulzC/g7jpSn1LMPdcFqaEuBmuVW4SeOsAm3XaJjayq69sfqY8aANLj8fCuWp2cV6QPZuP3NccwAa8rBmtA4LsYLPRvHhjt5CAHLZTvxfdoucNJjNQZTJBg0MEXc1Ih6+mFeRL3HHl71PrJrNCcLnnNlnAyxYGnh2cryo1PGq1XB8uW2Pd903XciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNACGgINNxc/+SH22OuEjIdYvIhe9jEGx1sFjdcjo5o=;
 b=IOqOXRJbOE5lZqPpjAOj8uUOlrARFSPxVD+P+79KoN4sXW5VaNlfbPGFQs/XQw6I8fueOVeGyA4FGG/9bxweYBM4YSxEhsjow4qGPkXywa8U0f2y6OaA74jhpi/LExpM6XrNtIppbn1JA9Ce66waDDjA2PH+ry5Qxe67Yi7p8EIhqpx4kwo/o144eXeuqdivM2pNHJgQsBqaRHH4m79ZwGo83QW0DNwvR8srdQ/cUVTOY5cuImcue54wz2gIojsK0sBEBrbInD/M6RboSiwSH0LHWEL3EcaFfEqnjHME003JtdDpBnrqi2/M26MCIAFSrZySQd2s+a+mn/KlpKUGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB6811.namprd11.prod.outlook.com (2603:10b6:303:208::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 11:04:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 11:04:17 +0000
Date: Fri, 3 Oct 2025 12:04:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/6] remove deprecated queue stats
Message-ID: <aN-trAp5kl0AVccg@bricha3-mobl1.ger.corp.intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20250929150009.1542208-1-bruce.richardson@intel.com>
 <20250929094116.23d76e0d@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250929094116.23d76e0d@hermes.local>
X-ClientProxiedBy: DUZPR01CA0074.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: cc86c638-1c70-4c4f-be53-08de026c9848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vj3qCUsfJmJFwt/L+ah/sa+c/TJdz0dhUmtJt+1gdX0UtpdG9F9hrtjB/ZLj?=
 =?us-ascii?Q?yn/HY6ox8CLzRuvG7Xvhf43UrNTHueIHr82+RSW38wW3C7RksNsj4z+FExPF?=
 =?us-ascii?Q?+LA9gJQFFsclXnWu9kzgsGEKOfOSEhYqyvHxiqSxWpS5vekGiBWVOqAaLZwW?=
 =?us-ascii?Q?TFHhyLDfYPWQWjopMhRFtT3nsFiHMO4AjZ4w0ozUVqE095jPfEOSXFO1DUFg?=
 =?us-ascii?Q?8AH7iMwAJN12INnPWCFHkIXJolVb3LAZ7EmzUQDL9GiWNboMNv0aBVwIcdtS?=
 =?us-ascii?Q?u2mDZDK5U1t+ag8RXDhvj+8pfV84080VbyZ92ysqK8Q5yV2GngoCIRjQBwr6?=
 =?us-ascii?Q?w02jQnW1LpDp/+ljBipDwzQDotDCT+vMd3geWNmV0++61749deMWvlxhMnAg?=
 =?us-ascii?Q?eEXgnfvUwJwYkmjdjsXQcWTBPcYER06/eFTvbhxcEuP/CVimZ1YFANdm5W8V?=
 =?us-ascii?Q?6d2TeURRgxrzWsYPzbLGLtqmCaDqiVax44Ec/tayzgwO3Ka2yeR/Y0PSuAKk?=
 =?us-ascii?Q?gdZVHXS0ZMz7E7E62/D1hge2cyF429/18zvLN01ryGGcKICM7HfLEzCDMsVN?=
 =?us-ascii?Q?vPOjcRpEEf+cvt/cwUl/tNHpyOt6ycHiqLjQLisH5wgZY6cuaYOXoGRE1Jod?=
 =?us-ascii?Q?TN7AqUzLw2OoPtB3E+vnt6sR44/O3k/bruxh1ep+lGTOhUw1ZNWVto4to4dj?=
 =?us-ascii?Q?Mc0xWi9/dXp2pqDcbwvyvMEJYenl2vIF4NyHXqEyXDmu8ZrvZBHzhZGpy4oZ?=
 =?us-ascii?Q?lwcxZ60g5CfAxrzOXFS6x9OE2umoGTIPCidusW+2qZbzBiUhK4wfXgrMZX62?=
 =?us-ascii?Q?fJNoCQuAZxppiw+kyeNWW2t+JJqVRYPINJ1dZaA0sZ0g/tzR3B9QXbBaXsUM?=
 =?us-ascii?Q?TRsCq/VjHneSbs32YJXw6nzBLrvEsRgjWNeqyEhgCb1unY70SWXAQ+Bp5Jub?=
 =?us-ascii?Q?8SdIfRJnfXv9AtkVZUEwqeGgDmClM0RB50ag+JNmabXCe4xX7W3ZgLb7XTtm?=
 =?us-ascii?Q?IKK/VzaTUCqO7Dj72nndImKexzReNxRVT1+m+rbE+dNsFVJ28tdb/ZmlbtUg?=
 =?us-ascii?Q?95tEESRmK06p/xH61u2Tr9r4OV81LgKR9KOL0MHT9ZnTVy3aVxQ/YuPVyjSR?=
 =?us-ascii?Q?twHXTEb+XMS9jRbVRhFBp4+jJxZN/BBQZsY96JQgfC5yTj1nJW5BqmK9SbIB?=
 =?us-ascii?Q?Jwn7v3OM3dwY0322FZXTzKSW6GO/P7fyy/zUc0+0E7sJ/1R5dJzAkLtbJJki?=
 =?us-ascii?Q?dxN3hq8TRN1foMAiE8M1sH5IOB6lVmrZwr95cNIrrsk6Yiq937+rxKlcQbTI?=
 =?us-ascii?Q?OH3bF/ypwv2tcwAVWty0BAARp0iD11NqoNdnr8Rw2mw/CkaTbIMTVLo98NdV?=
 =?us-ascii?Q?/nGUFvKfb8Ox0g1r884ev3KZh+uE/kr1vAkJ7/hwHOawDDgkwPR9e20wbG2h?=
 =?us-ascii?Q?wbrIH6m2k5gJTUN2BzQWxss9neVXsfH2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EuetVdTyoarIk7DTBznvCXXT58gFwGjkvWzY2ulpDDuZ1JrZR/mjbZXeMNWk?=
 =?us-ascii?Q?lX22AJhwag1AMyYOOWjPVKfGxvgtNfWquqPBG8koA4b1RAo84uOIe80GAttL?=
 =?us-ascii?Q?atJbC9UXf26bs2dUhaaxHVtENAhOHezaXHOmpQy1FdpgAX8P5qePjR5nvBkv?=
 =?us-ascii?Q?bBYk/MH/oAZ93XZf19XVg/oo4xpIKoMikQwbjeWssj0kauUd+fIegbciL6ST?=
 =?us-ascii?Q?ydr+qIINKl2pcOIIjfaBfGZM15TQpfduVBTvuBmc93dUyr6z/evKDcwX7buh?=
 =?us-ascii?Q?DFrrjNIgH7GisAnSylazrD+uOWOwsfMmX6KlpvHIj/PrDkb+iuPW+q2Sgdns?=
 =?us-ascii?Q?6GuzCBlrPYKKfH4ahWiNoSL2FfsSegakzFEUn7LL2ZVOA5SE9OdH8qHtnBA4?=
 =?us-ascii?Q?TZAdaklvPXusNpXgfgAeNTr1V6jOuILhois490baWWNOyKRNHLNI4uf07+lx?=
 =?us-ascii?Q?oDF4w1xvGNA74Oi6Yz/PoTU1vT7DDu3HTzh5RCzLopDVJwFXQoaxNzV3aoMb?=
 =?us-ascii?Q?crBBWxIjoK6exp/Tu+m6+j2MvmOjGdbwOZZyxtILcx2TFVGu6iuuKIpNOmK4?=
 =?us-ascii?Q?93dIYOQp8KEKUMHWKoBoL3iiihcd8FGH43n07NPLvN+ubyLt6m699u+fMfwr?=
 =?us-ascii?Q?h+3dQmr0vWg1XBt4zAB11TWoCplNA82xJUYRH2Qxjws4c/LsvnSsaYxtsPn/?=
 =?us-ascii?Q?oiGl54PuG1ekENchcn97Ah79YoSQOCoAcVQtBvD9ntU3ajqKQ4UaDqoW7DZk?=
 =?us-ascii?Q?4RjC4wKBYBrUi8refvgkSHzojXa50MRYVkiUvlbns+uiyKjkjsGdrYhVe2EL?=
 =?us-ascii?Q?sBmN97TR20auuQpHV3wTO0/j1pDmScD6Rfyk0gfxcuFnHJNfjLDmR6K2C+NR?=
 =?us-ascii?Q?7I6/ZZYo7z261Wzx3S+toAFGj5SggXQo2uxMFNMgeZVcvEvnYl6Y+4xt29xv?=
 =?us-ascii?Q?i96rA5CVL7xZh9VaCeLKv3zo2dU46nLSYub9zeir0p87m/w891UgvRwDm0we?=
 =?us-ascii?Q?DsWZ8C4xRT8uGcnpvyj2/xc8M4eYVT1iaQsgwKopa51N66d4/EQF1f7OYAeX?=
 =?us-ascii?Q?mlDL3+2L6sUFN9cqfdVh5ZFmIofvyMQtthUfXO4VLwWCUMNiYyqSl0tpohfn?=
 =?us-ascii?Q?7BBXEEnK+Y5arvwUazreBhvJtxptOJWuhcFbRvf6iL1ENk6mgE2EZQydGl5M?=
 =?us-ascii?Q?xeDr7TcyGFGFTric/osze9x1RS6aavQlTeNd2JycG0G0HmsMAOzi9W/VZkEp?=
 =?us-ascii?Q?3qFSVjxXgRRYtSZdq1u+BJvf2K6FOxIk0miMthu1cS9FDtGOWXGBX9p2JWKm?=
 =?us-ascii?Q?36QDHOz0OgaOpXXzU1rpJuiSalTqvPXKkZ4GWKf6n16jFzyk8LpANuGtyqWQ?=
 =?us-ascii?Q?j5MQOUXFYscMhvT9wkquTEhd4V/90FdDQV4qFkjMuo/RlzWSfefDhkfKefc0?=
 =?us-ascii?Q?Dxw+WGDW4vkvxHOYf9yR/+ejpUKsa1foTknJmetyP2yF69Ga3LDFzl1f1cgp?=
 =?us-ascii?Q?zIigIuvQ81qT7hvAL4xIPhBqVcOkYurFsCjdMi1zKsspUXhjNLvJAvazv9zF?=
 =?us-ascii?Q?NBBp7pUB20SoqHDH5VMbsdmBublgYk0lQkpG3dOAw1Al0yxnsIpwXtzees70?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc86c638-1c70-4c4f-be53-08de026c9848
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 11:04:17.0142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iskx5ZZzPzMqolpfbTtqXUin7XfoHBQ8K5+asfMa5mieQfvWXt7CCjLrkIOp8erkKjMLFdKgONqg25TceYfECB/n1t7kJNJ23VsjiMuwy4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6811
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

On Mon, Sep 29, 2025 at 09:41:16AM -0700, Stephen Hemminger wrote:
> On Mon, 29 Sep 2025 16:00:03 +0100
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
> > * Within ethdev (and testpmd), we should consider what to do with any other
> >   legacy queue stats related functions, for example, do we still keep the
> >   queue mappings functions.
> > 
> > Bruce Richardson (6):
> >   net/ice: don't report empty queue xstats
> >   net/ipn3ke: drop unsupported per-queue xstats
> >   ethdev: remove queue stats from ethdev stats structure
> >   drivers/net: update to remove queue stats from eth stats
> >   app: remove queue stats from eth stats
> >   doc: update docs for ethdev changes
> > 
> >  app/proc-info/main.c                          |  16 ---
> >  app/test-pmd/config.c                         |   6 -
> >  app/test/virtual_pmd.c                        |   3 +-
> >  config/rte_config.h                           |   1 -
> >  doc/guides/rel_notes/deprecation.rst          |   7 -
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
> >  lib/ethdev/rte_ethdev.h                       |  11 --
> >  lib/ethdev/rte_ethdev_telemetry.c             |  20 +--
> >  107 files changed, 913 insertions(+), 707 deletions(-)
> > 
> 
> Great! but need to keep going.
> 
> Should also remove 
> 	rte_eth_dev_set_tx_queue_stats_mapping
> 	rte_eth_dev_set_rx_queue_stats_mapping
> 
> Then pull
> 	dev_ops->queue_stats_mapping_set
> and related trace points.
> 

Added a deprecation notice for these removals in v3.

/Bruce
