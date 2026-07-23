Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B793EC531CB
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 10:29:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C9EB4028A;
	Thu, 23 Jul 2026 12:29:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 62BA14027C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 12:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784802566; x=1816338566;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=12AgkQu4VixjYa7bQZsM6HxpcFb+cKuCRUHKAeFgQ/g=;
 b=F/pYsM6SBYIUe2fDpaCG70HsHk12CPbVB3S/CYEI/uXBv8sFrws9Rki4
 QHGmiT8wy/A+ghGVaxrCw4zcG4pMd0NMiWqMeMQxiCCANPN46SuScvJ8i
 FOvPbg3DL/czfjxM66Frs0GYgfM2Di5beGh5H4u0qhd/L/tSKYjW7KOlU
 PpDz7wIHBuHmkYxMzNebPqYhGU13KFFQ45ufwbn0/FiaNpFhiauEjqOVv
 gR0LUbUvx3wx/P83POMAYyCKLXnO5GJeux328MQLFmCWbbY2qqEnu5k0E
 5SFqgZ0JeBe7wrMqaPfwpj6H4Sbz/j0n9dffDKfKQvsFUAOomilXmyQIq w==;
X-CSE-ConnectionGUID: sgdDM70LRquzU5pOjC+y+A==
X-CSE-MsgGUID: K2PXMMb1TNyQMyEFq/V9HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96971463"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="96971463"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:29:13 -0700
X-CSE-ConnectionGUID: qomjR8aRQUqalNYvOAn4uw==
X-CSE-MsgGUID: x0lF2dW1TnOJ4/uRkwu77A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="254442897"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:29:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:29:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 03:29:12 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:29:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qU5LV1uHNt9Ywkte6fKHjUVyzfyc05Ouw1PiM43HSg8fpkE+1/TwmEqMVAEoiemZqTmrKqaO+yW4lLmCEUcIuoJMOsYCFu8OeLStIWZxfhwTNdzljbjqysxq9y9z/ncjIGLTj7R/PDYq67ldQemoDIIcX3XwEaJtzwqHQbzFkVIKgqfs5J0DpyTsZL7Z1wancAFDwT78HbkQVwg1JU3ubtVowDnoDmts8QBafJykdOXY4ZXPmFVfywaj4xVrVS+WUlcjXzQ1a4/+axXRRhvJGVQBK3DvvBNkg6MJT2AE9zZPrJv2PoWG+cMJvfzJjfoECuzzzVeGjI8JYV6Fwo7NMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DNBz3GKOWRwath/ljvBJebZ7+AVGM+tEd9DLC9pGro=;
 b=sSGTwB6dnCS/m7/fttOpG5ZBO0H1dE1zgkhoSeNhaF0sAxKVB4c5TGZeDzM4Zd7jNfRLMMSkJCVzRf2OlWUEfGDDz2+VX98+Hv1zk9bwUDaMmjG0hdjxGDggZr/Y+dvvdiDquXAG0zmzgsq9xmNizneLZA6+Y7efGgEi7Wv+PY+w4KkvG9IPhhGvevnfZ9KkkH6RKf0dQVHADAR+/9T3JUDgDdldxL3us+ntsPM9plcyo6UoqPf+FEbl2HJaYQzrttFertM1FiLHkduXtBiZhR8WJCy61y67JdSlZdZwm6wCNVQeo+GEQVPBrfHyHDR+Qg7nCjg0MEbTUnuxqyAU8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DM4PR11MB6261.namprd11.prod.outlook.com (2603:10b6:8:a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:29:07 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 10:29:07 +0000
Date: Thu, 23 Jul 2026 11:29:01 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dawid Wesierski <dawid.wesierski@intel.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <marek.kasiewicz@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v6 2/2] net/iavf: disable runtime queue setup during
 queue rate limiting
Message-ID: <amHs7Wd9JP72tmDj@bricha3-mobl1.ger.corp.intel.com>
References: <20260708231926.1550698-1-dawid.wesierski@intel.com>
 <20260713094259.1721234-1-dawid.wesierski@intel.com>
 <20260713094259.1721234-3-dawid.wesierski@intel.com>
 <alS5ZHqcu-rumZoX@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alS5ZHqcu-rumZoX@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DB9PR05CA0014.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::19) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DM4PR11MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: c496f666-5e45-4909-5f05-08dee8a539b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|6133799003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: W9xnkSruhZhNOI4XyJ3vcTv/59rcTVqjnApKq2ppcV9VvM9XehroJOxCSzyG3tJveYtKtNdP2DcEGI6qlrXZiqbfAXaChtZGu5LTGI3vN9mwXobWdnarr7fLb6exqvR+o1PCOY6pid5SeSCQx7aD3uYN5tBHY/QfIYG0LBMcSvRzFDxxiqbaC9z1BIBqJXulQR8NgiOKd+krKt7VWkBmnTTKbEBGl6iu5W/S/IRCkn7eb1SLOJS7SNCPRUABQDFXZg1akfMV6taiv6jaMLEgtzr0zeLyUMxls7W9hGj+UH8g6Zcg7CHx09MOimsOwuSSNeV9luqv+2kFajBvmV/UgD8X98JqGtC8qlBRqTrteBTok42Rcb+skDsB0IsW7nuhnffYfxQLsYAUTPgQf+kzEFDSHLqW1uYIm0ozQdjWGZMRSCpFnZKZIiJYSYz5oWpUeSHgKWwWcpkd6exLPP+wFEYKogw+EewggL9Xe1SmGPnTAEEPy03/It6AhmAzynrnS/uCGR5GP9pR+NIYWNCQkmZTpuAOJztWHJ11lopjjxPEvQyJfnJfXhSSZUY9Axt7L5vqNegyp/0nN8fG0TC13PQ1Kh0KY75R+F6jfF+ueP3oLUvHt2c+CJggl18WoRxWa6wZyk67NEOnIvLqvmlJXgrPvk0bMwtSDXyc8gc08Bw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SwG3+kRmBH6nLORLO/Y2SWXhBpLVwwrHURdEv1EKDILyfh6D/1kL1GuaEWPg?=
 =?us-ascii?Q?ccP8+H+8b8S+js0B5PWWwIwuOMTTDR+m7PLpTxBqvkP7gLLIgDefNsfiQXhN?=
 =?us-ascii?Q?oMSgofOnFB/nOORyaaq/WgfEBHmlbkOvhE4EybaSB5psBVBAC6Bb9fRSqogO?=
 =?us-ascii?Q?veTOuRg7BilxBPZVN3wS6N8XvfOyl5YJUBqZFSymMFPVpsHQ+s4yplHqkY9h?=
 =?us-ascii?Q?EPPOJJbQIMFYvpP/KCtEr5Ze9JNQvjwMGsayLBEEEhj/j2ZlLLAcF+RGG7VB?=
 =?us-ascii?Q?+n8ZiDyjStX008HLXx/9yQegFiwpcc823LZZx8aDZIGe6q/wUftYcgvxxQQY?=
 =?us-ascii?Q?7V18VzYEp03AZqk4p9v6/RmnHLSQdQcuraDYKJE2obf6CqXNpZluCSekDgmb?=
 =?us-ascii?Q?Ho1L1SbsgrfQfGfFYM8ujepVQcjg0GNOi0VDQeZ/MYvPsh0cXGtf9g7znOyS?=
 =?us-ascii?Q?trlWTfbEDt2GXG/Pabo9JUU7QeTV+2GxQtzz0LoLFGyn8c3T0B9CKHBTQkJ0?=
 =?us-ascii?Q?yvfxF4D4/s3GS/ldoEj+Vs5Zz8V/u6j0e4QIn1woZhwHD0DJV+tbFxAq4hwP?=
 =?us-ascii?Q?FGruvPlXbCMPvxl6lev7lGXl/W7J4575rKJ8xRlY22pVcwFeUez4XHz16ULw?=
 =?us-ascii?Q?EmDAM6O9AQJmTKFpFRzuBJV8V3V6tCxsFsHbBHh5FFD3csegBGqtYxa0cnE+?=
 =?us-ascii?Q?1Q6hEmcUYbn/yN2piUW6pznRISX3eufgnXsJ81k5mtIOFV1Kb+gu0dox5xps?=
 =?us-ascii?Q?h6KN/CHVc5ShZHjvSLwYn3SEUv3/H1gShmqRbgJIbI80QxSSTETEsmL3RByy?=
 =?us-ascii?Q?O4v0UOV841MKkjrHF33XsZ8ox6I9UO7y5sZYELGWqsNF+869Hy5iq/qzUFdN?=
 =?us-ascii?Q?oYVJC7ANi4lZOdBbpP3n2zeIqFg9t93kWXkyffUKsWWa0ymHohfuO51Gc9Ag?=
 =?us-ascii?Q?jZuWvKTihF29I4yVOSq7zk2AgDs4vg5hZKERYj1gj4PBea0HphPhSvdJpmGz?=
 =?us-ascii?Q?3CYxo3ZW29ZB9Phopf8tod/3kVffgMd0JhNQCyABqIuF1WcyTyhG1gcWYIfy?=
 =?us-ascii?Q?qyE9PUh1nQBOx+9rUnY+NeFQjCkKv7rYExwvW4JNnj0kZyeHa0rx0RgS+klh?=
 =?us-ascii?Q?mVBDMCWdme4qRdHxmp/vr2f6fVN67MYiHZZDfk+0n1tNBrnxGChgQZT0+v7t?=
 =?us-ascii?Q?3BSEyvGIskDfLks5uECvH2Vdck5Eggwt8DAOGdoS38b/D9Aq5xX8BoAqjz/J?=
 =?us-ascii?Q?2/Owvmp8z9aeqFrzOzIFhdz4SWhL2b//cR1VDy6bBZi4kwnz04E7NMUrXbW7?=
 =?us-ascii?Q?ewzOhrt/KGbrjrpwjDct8FFwqUzMuaoaps5Ndxe19DcFzlV+nnZEJmQtltFW?=
 =?us-ascii?Q?Ykjvsh5DPSrg9/z4KTQ1XQdskxakK1KbGT/Mis1MgoizAXw2P6KmX6pLHAqn?=
 =?us-ascii?Q?H94JHbvY19TVtc+psrMeCoLH8SrGZYKOwfhWXP/gvK5LSpAVErc0/Ldl0buY?=
 =?us-ascii?Q?txr1N8d1Y7zYcQPZF0M1/t4aLEf1M43J3wXwH+pW19zCpO2Q9LaRPH1WK1ja?=
 =?us-ascii?Q?oH2VhM18F5u4WZz+zu2suQSxB2wzlrS9lnsIhlj/GT6ddxsVPnJ75IPIO0c7?=
 =?us-ascii?Q?Y5EemW+4IU4bK7YwYHJP7PxBuDW6qOkQVKLY7pt6AyftXkFA4D1wl1tTvY7I?=
 =?us-ascii?Q?jLRPZNJ5mnz1rCulwMJ4OUd9FqJR0WnOkrDrs3vyzFNJcxliI6FKnu9H2hDc?=
 =?us-ascii?Q?d67bztRGtQP1veIZVfW/rUUY4CWyPBc=3D?=
X-Exchange-RoutingPolicyChecked: Hh9IixpYsGgLDKHJb+LMUO7jGHjgOCfvwHtguOScs8ugmdV0i8U+nMWWqsNyBLHwsL1In1FYpwnIsZ2vu596vxbpzdSnNnG/S0dHD2OqU4J5YcG6L3J84F4e2CIkWKHbfQXkzNtm15uxLk+V99K/IthITp2N0ZrOau4J+nX/ZX1qmp5wCPd/kUEAmrUlUUWJGl6TwtbefdUAhcXYXOG1RnYjcUWXqJor3s/Jxd92DjKoFDfNlfzcCXLsfWvTAs6TNPe/dlvJp7YQLVSofCysYEymt44ukFWqjoT7xwmyDN3bgpgMV3/9/yigeHtihBcf+7Rx1ijnXAo2m0PqeWZENQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c496f666-5e45-4909-5f05-08dee8a539b2
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:29:07.2134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Unx1GvHcoZ5nScoCByrOsAyu8mPGppm2cHZi+Cx0UQna8dhnNq1AKqMFx4SBQofYTffvy2GNRleMpXYXJ+R/7CP+bvn0X2An8N089pTWAko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6261
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

On Mon, Jul 13, 2026 at 11:09:40AM +0100, Bruce Richardson wrote:
> On Mon, Jul 13, 2026 at 05:42:58AM -0400, Dawid Wesierski wrote:
> > Runtime queue setup on E810 VFs causes queue state corruption when
> > queues are dynamically reconfigured while the hardware rate limiter
> > is actively pacing TX queues. Queue configuration messages to the PF
> > via virtchnl can race with ongoing TX operations, leading to undefined
> > behavior.
> > 
> > Rather than gating this behind a devarg that an application would have
> > to know to set (and could just as easily avoid triggering the race by
> > not calling rte_eth_{rx,tx}_queue_setup() on a running port), stop
> > advertising RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP and
> > RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP as soon as the application
> > commits a per-queue bandwidth rte_tm hierarchy, i.e. as soon as the
> > condition that causes the race actually exists. iavf_dev_info_get() is
> > re-queried by the ethdev layer on every rx/tx_queue_setup() call, so
> > this is enough for the generic layer to start rejecting runtime queue
> > (re)configuration with -EBUSY once queue rate limiting is active, and
> > to automatically allow it again once the rte_tm hierarchy is torn
> > down.
> > 
> > vf->qtc_map, already used elsewhere to look up a queue's TC mapping,
> > is repurposed as the "queue bandwidth committed" signal since it's set
> > by iavf_hierarchy_commit() exactly when a per-queue bandwidth mapping
> > has been pushed to the PF, regardless of whether the port was stopped
> > at the time. Fix two related issues found while making it load-bearing
> > for this check:
> > 
> > - iavf_hierarchy_commit() replaced vf->qtc_map on every successful
> >   commit without freeing the previous allocation, leaking memory.
> > - vf->qtc_map was never released on VF teardown, so
> >   iavf_uninit_vf()/iavf_init_vf() (e.g. across a VF reset) could leave
> >   a stale pointer referencing freed unrelated memory, and the runtime
> >   queue setup capability would never be re-advertised after a reset.
> > 
> > Both are fixed by freeing vf->qtc_map before replacing it in
> > iavf_hierarchy_commit(), and freeing and clearing it in
> > iavf_uninit_vf().
> > 
> > Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
> > Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Unfortunately, since we are now past RC3 for 26.07, I'm not going to take
> this change for this release. [For RC4, we limit changes to critical fixes
> and doc changes, so as to avoid last-minute issues]. I'm doing to mark this
> as deferred and will take it in 26.11 whenever my tree opens for patches
> for that release.
> 
Changed release note update to target the 26.11 one and applied patch to
next-net-intel.

Thanks,
/Bruce
