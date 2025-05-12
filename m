Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B72DC3ABCB
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 14:46:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2085B402CA;
	Mon, 12 May 2025 16:46:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 2BD0E402C9
 for <dev@dpdk.org>; Mon, 12 May 2025 16:46:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747061190; x=1778597190;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Z8LbdXA8T9LN3vCmHvX0e4c7XLmZ95Hj3hMe4ARgnOI=;
 b=fjsCiq2xkLupqGuF37o3XYxql3/TLLpJ8LdL2GMQscWfI8l97fEhK//d
 9ruYUT6MxFQfK69bk9JUHADX0sh221Nz8IGBFqEQiPyUwRlJ0Y8XBh+UD
 r/Ix7pF/i5OQy+AZuLX2bur1WvDlYSPxfBBUe7tbS0C6n1/7tln3mtRzU
 HeKMqrumhSHOFLPExx23+j3JpKGnEq8FoU/tFOptu+xTnv7rawqESokNt
 TzmQO0hhAVM7QHTUxiix2/QEtC2JB3g0+nwBQsD7j3KbmMwnDTMx2CVtN
 sftqs2q5634MX2XLWCjmEcbJZmZOcbdM2fAbLbUqsUIfklPyTCfJVVVr9 Q==;
X-CSE-ConnectionGUID: P7Kod/6oT/KmCj0kJYMrqA==
X-CSE-MsgGUID: PK1sNNkfTrmQbwhFJnA38g==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48939796"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="48939796"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 07:43:25 -0700
X-CSE-ConnectionGUID: 9ssS10sbRdOhbAEFSVtlnw==
X-CSE-MsgGUID: 1DIsaU3WQ0mTWExtHRPvsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="137100946"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 07:43:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 07:43:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 07:43:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 07:43:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4xTuYCJM5LNTdH1pUFeTX/ZtrDJhv2GVcgriHjsGdkQsPuX17jbDM2XkzfnlA53U4GHhw2TG4wcez8+Sw9eg8qkW96Ikl8jemN6AFh8DFW4dSYHx8A/bxo5HeLqFD3Z00qyTGidClxlrlrIuqFKEkyTYREjBijc5hiPER82U5up9ay1BYKcrn0Lh3f/Mc/uFN01Du3m3BxTU3GhVJcGlgaObtEvBmlkWIXdJjbK7my04nbdALvoaW1wkB9LCeA9in6paysglre+G9dVnBrRdknKUn6hHdt7MGkfNwl/UJRecxY4XrLlWx2wFKdbUVAk4FuPHiP11ycq2IevEzYrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UNkNRjyqZ1xgdxKkpkRvTkkj9sJL6cIZiM0Fu2NeeQ=;
 b=Iajb0ykbLV3QXN59trKDDGjGRRREXj18HuiGQUjTtheclzVv1zx9nTggY9fZY6isa2JRwUQCU6S63ZqyB6eUQOwTLVjUqIX5HNd6qy+FCbRXNNhQejwhbHCo97iFQmSPdrQC1nMEZ1+2PmyCmOiZSWFrE92NEeScgXpq0Kl1h0w22RjWokuzHcKHCrge4YIcmTeGRNOtXVEP54SkUEHv92vcrWZqbQBj2dUyszwrY5jkHboJKsxyiqd0Flbdahb8Ei0gY06ncYxx2+SKbJwlTlRa7ARpifEro5DHhqqUepAtX9hCgLcCzsL3JdIqViT6eCJs6z/xlyJavTeHGToBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PPF341F90799.namprd11.prod.outlook.com (2603:10b6:f:fc00::f19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 14:42:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 14:42:52 +0000
Date: Mon, 12 May 2025 15:42:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: Jake Freeland <jfree@FreeBSD.org>, Chenbo Xia <chenbox@nvidia.com>, "Nipun
 Gupta" <nipun.gupta@amd.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>,
 <dev@dpdk.org>
Subject: Re: [PATCH 1/4] bus/pci: Use force-noreplace flag when mapping PCI
 resources
Message-ID: <aCII5pgaDvgMXGvM@bricha3-mobl1.ger.corp.intel.com>
References: <20250506174046.1136711-1-jfree@FreeBSD.org>
 <20250506174046.1136711-2-jfree@FreeBSD.org>
 <53d50d81-75ae-4d23-89b2-bfd6e5733550@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <53d50d81-75ae-4d23-89b2-bfd6e5733550@intel.com>
X-ClientProxiedBy: DU7PR01CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PPF341F90799:EE_
X-MS-Office365-Filtering-Correlation-Id: 94374a2c-d457-492b-cb08-08dd9163465c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7siIDl5+7Pgng/gUZt59GIrMNGKENYtnJAL6qmlezOZnvHKZJE9JqZe7DZG5?=
 =?us-ascii?Q?PHCDH1pVQsjzSE2ALYMBlojyuy1LAN7BRpFOCPcaSF2PPdqd+wJkxzL8kaee?=
 =?us-ascii?Q?amoMzL3a+FZNpIwDDcWMFdpf6vi5o/lpdI5jWKE1mghDezuaYV3X/FXAkj8g?=
 =?us-ascii?Q?begD6Moh0CSWahGW/d5nUJOavG9oaxiS/3iJoVfMiU6e3KVw+ZzDavCjy9MY?=
 =?us-ascii?Q?chp8KgQIVEE/51qgot+JDchiHkDuvCto561PeTzaAdohftvS48uPqmfS9kkh?=
 =?us-ascii?Q?EvmqRTmmGf8X83p4oKqPocIsc3bGX3BuqBZIxe8Z8o7WQi9cUH5QBgCbMox+?=
 =?us-ascii?Q?mDeAlmTa4KLVhTGo2MB4fdeWA2NRJcoHmv4AuEKZRxxaYJyUEfnEkI4wMAXn?=
 =?us-ascii?Q?0i3LEagGS4zEiN84y+4i6ZvoijD3hnc+KD5fts3SkjvZN8UpoepykypZFX1J?=
 =?us-ascii?Q?cOlXKgJ31dXvLqjCoyus/wbrGFY6xSpdILRCO//B7tViJkNX0yfeLzY9HJkv?=
 =?us-ascii?Q?kdHzZQM1b24/oa5RH6CiuKvDP+ZaxdXFtio+Xw/0E98iyoVIqW1dyP/bjgkt?=
 =?us-ascii?Q?9j7YtQmECY7uLrsvheF/eHo9tAgVmHHEBjqTN56aQvD1OXxwDKO+mA7ApRON?=
 =?us-ascii?Q?9PJ0mAnoNKQEXOSAmTE7j65g/VbA12RNjci88VDWIUhC2O5weVVsCriOzWw1?=
 =?us-ascii?Q?wSiCSoqLfU3CMBw3eUhLRWO3CXnTnKEeN8LD1ziriy3d48m0SfRep+ciF1nw?=
 =?us-ascii?Q?ft1/o1ZS2T+TJYrq9SXfcMzp82wrga7qshdgRe0N3B0RQDtxefnwVh8jqJLq?=
 =?us-ascii?Q?OUZZYouZhzvFe5JIkO6m2NWy1657reHNtxWbDRycg2G1n6djDo5NrWp2gOUy?=
 =?us-ascii?Q?SL0t5vclSX/WvWZy8kfPQnqAeC1USw08XqKLB+VIM2OUEtsJOcx8WZxbgIeu?=
 =?us-ascii?Q?3fIjRS1EIdj4q/Vc6fkc//REZDNgiwfv+KNWgLEFJw1cpjfdCK//HgF1iOej?=
 =?us-ascii?Q?EqmW9IJboXYoOpdJ1Xc2jpIdhq/0OTqVwF6vmEZFizPO0H+1vnf06vZZ5j49?=
 =?us-ascii?Q?+6oLAvrGxlNiSCy26iPGurqPfMadWyz4zIRrzmnB+5DxX4SqiRsgg+NvlG7p?=
 =?us-ascii?Q?lB8wYLH6yU0OqoM+XxMHMeg6KN/LABqnCs8Yq3WiQN8Ha5BZ7ZLoMd7sA5id?=
 =?us-ascii?Q?PLwBiuqmPU9C2T0CrDSQseaTNSD5UNDqUsueubL5d4BD9DmY2bqIqwew0LT2?=
 =?us-ascii?Q?x4655sBv23ggrcYHeIpxRPnefia3sj2+rN+UzvSok51ji1QIyKZA0dTPnY2v?=
 =?us-ascii?Q?/b5mij/iomZPS2t64Mruw7iIjdkhe5aI9zb5VMu6o37QQD7EV1dHLuzU6xUJ?=
 =?us-ascii?Q?uddKXf8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L7CZGrfDvMBWswOT8oLr07hS52rzQYnZNpe/+uuOUktpvBXH+9CILFl0tGWT?=
 =?us-ascii?Q?ue6D2mSBZzDNF7MSXMM3EJTqVjh4KiVAf24S3XjSdAbXQqpEVLmmtuPl99u9?=
 =?us-ascii?Q?mdYKlYgG14dV7aE01ES4K65CPY4U8iC4uztMtqwvqteWI6Fvnn94RPkY8g/Q?=
 =?us-ascii?Q?p+EEvMNtXV3Z/bCva5s69kdyMCGM8vJBN6h5VjNpUbQu57l/l2pVLiOeI1HT?=
 =?us-ascii?Q?JMLHNdcgoEC7A7fB/SDXfBjZZWR+6u+ywH1IFMTakZLk/H52YC5VBgU19uMC?=
 =?us-ascii?Q?pfmDpGFvi4CMbnzhDrb+knCACBHtsL1rSkGIjKWoXIkIPOgQqbQojrDmyp5Q?=
 =?us-ascii?Q?7RBGHaZilj9krEtAkH1pYEegEMjr0B252TsCy2A1+XIIoT4vRw9sKvUjASyT?=
 =?us-ascii?Q?ITbpV0Jmcvu68zzQdfintFNf62afHrrmWT0SvigOqRVUjAy3lbhwe2A0yqW+?=
 =?us-ascii?Q?IHgWh2l3Il/5qu1wI+Kdrna7uPCvPKZgNucE25j7hc9YIEb9dcxW+tksmbaa?=
 =?us-ascii?Q?E4kOwB56FN5cbvkfsaCw+/1Z7/iNmjvPJLNdC35noBFH/pDn7pZkWRK66jRv?=
 =?us-ascii?Q?SvQc0JfRZTYzEJKsDrO5zq/4Z/84e0VxMI96Y8uI6mjgGIzjunU2VA9q39Wh?=
 =?us-ascii?Q?y6IZWWPyLGeaNXGuv77IN7CBdCCpZsKjVFOwvPcb4DEWl0k2a4eBwRpayEih?=
 =?us-ascii?Q?//5SNVFMTu//0jBDNq/JfH4N8DN6qqSKgKKncON1p5lTcsCxdrR1dU5isO+g?=
 =?us-ascii?Q?kF4e2uTu1ooLp71dGT+7nO9H1kU/yEU9jRH5BFLmvJNtlBpwE+CX8p3RJbv9?=
 =?us-ascii?Q?yuPwghT/NfZcs8R4cMc64FjzwxsZ9tkpWOB7cBtq1eJHPQNnzirzf4f18sEs?=
 =?us-ascii?Q?21hYSOzMjErycHqICF/16lgBG+OsKRW+ieGesDdoBMZJ4TIaOlF05W7IlNfD?=
 =?us-ascii?Q?7KHhI0vzC/XM5Fh6NCUvsh2dwvgXLE5sdBaO2hAkTgg80T2zXLUcYM5WTp8p?=
 =?us-ascii?Q?drFqp0xD0E1TNWj5OIyTx2WcMpZ5UltTUiEBXtrpvczyBlrTxlRb1mbvS+xj?=
 =?us-ascii?Q?S0MVU1NSjTlZMbbcYrNi8uwiDoJt//XDgKriDWPyltmqv18gtICHfsnqmXyv?=
 =?us-ascii?Q?rKu8jPYVoFvdMVwPuS9hrQ4odyN5EMGOaPubGsYliMaDiMJ0Vt5F8TzFKw01?=
 =?us-ascii?Q?kpXXgaOLtkWwKzAYJIG4hsXZKAwnayf0sazYwAV6ZiVdX59SNaafRgKVxTuF?=
 =?us-ascii?Q?lCHeEeBwZSj7219dmSwKx2EeDdRxvodFJUbjEywmUJUpCzG54Ta/pCopXxmT?=
 =?us-ascii?Q?/39GAPN9EPUpXYuG2SFcz52R4HbCMfhVpPBxJbHiZa40WcwHGvEtwZOafas5?=
 =?us-ascii?Q?ujeQBl7p8skGDymts4prRtZf2lz/tv9xRnCbEUrmX7nPSCeBpElh5+XBJE62?=
 =?us-ascii?Q?EfMKw1Y0mwg23u22vqAZ8Ok2ZxFB1UgicdVAReOTsTrkU0tDmCrAJMPJkMP2?=
 =?us-ascii?Q?B0rFpSRNWmCGia8j0wD8rHoIEuCwkSR2dKAe1WCpnUcNweUJ6gdMndxfh6Ib?=
 =?us-ascii?Q?/JLRDyqNjvFEGTK3J794a00x8UYhQ1pBRs2lCen3DUwB40v9jYNVtJ6suEpw?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94374a2c-d457-492b-cb08-08dd9163465c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 14:42:52.7859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQ4kKO/LdjzOe+IoRszJ78SKnsoRU1I8cmYGbRychhUf41x+wpOtxQHNYSmNsdaK9Ucm9PJuDky64nBbPHhOgkVI77c7jMgMTPKFWb7hKfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF341F90799
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

On Thu, May 08, 2025 at 01:32:50PM +0200, Burakov, Anatoly wrote:
> On 5/6/2025 7:40 PM, Jake Freeland wrote:
> > When mapping PCI resources in secondary processes, use the
> > RTE_MAP_FORCE_ADDRESS_NOREPLACE flag to indicate that the
> > mapping must be made at the provided address.
> > 
> > Without this flag, the kernel might return a different address for
> > the mapping, even if the requested region was available.
> > 
> > Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
> > ---
> >   drivers/bus/pci/pci_common_uio.c | 4 +++-
> >   lib/eal/common/eal_private.h     | 7 ++++++-
> >   lib/eal/include/rte_eal_paging.h | 7 ++++++-
> >   lib/eal/unix/eal_unix_memory.c   | 8 +++++++-
> >   4 files changed, 22 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/bus/pci/pci_common_uio.c b/drivers/bus/pci/pci_common_uio.c
> > index 30503bd23a..71974e9f56 100644
> > --- a/drivers/bus/pci/pci_common_uio.c
> > +++ b/drivers/bus/pci/pci_common_uio.c
> > @@ -10,6 +10,7 @@
> >   #include <sys/mman.h>
> >   #include <rte_eal.h>
> > +#include <rte_eal_paging.h>
> >   #include <rte_pci.h>
> >   #include <rte_bus_pci.h>
> >   #include <rte_tailq.h>
> > @@ -58,7 +59,8 @@ pci_uio_map_secondary(struct rte_pci_device *dev)
> >   			void *mapaddr = pci_map_resource(uio_res->maps[i].addr,
> >   					fd, (off_t)uio_res->maps[i].offset,
> > -					(size_t)uio_res->maps[i].size, 0);
> > +					(size_t)uio_res->maps[i].size,
> > +					RTE_MAP_FORCE_ADDRESS_NOREPLACE);
> >   			/* fd is not needed in secondary process, close it */
> >   			close(fd);
> > diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
> > index 04ba8ddb86..aaeb140eaf 100644
> > --- a/lib/eal/common/eal_private.h
> > +++ b/lib/eal/common/eal_private.h
> > @@ -211,7 +211,12 @@ enum eal_mem_reserve_flags {
> >   	 * @see RTE_MAP_FORCE_ADDRESS for description of possible consequences
> >   	 *      (although implementations are not required to use it).
> >   	 */
> > -	EAL_RESERVE_FORCE_ADDRESS = 1 << 1
> > +	EAL_RESERVE_FORCE_ADDRESS = 1 << 1,
> > +	/**
> > +	 * Force reserving memory at the requested address, but fail if a
> > +	 * preexisting mapping collides with the request.
> > +	 */
> > +	EAL_RESERVE_FORCE_ADDRESS_NOREPLACE = 1 << 2,
> >   };
> >   /**
> > diff --git a/lib/eal/include/rte_eal_paging.h b/lib/eal/include/rte_eal_paging.h
> > index c60317d0f5..7b1983b615 100644
> > --- a/lib/eal/include/rte_eal_paging.h
> > +++ b/lib/eal/include/rte_eal_paging.h
> > @@ -34,7 +34,12 @@ enum rte_map_flags {
> >   	 * may remove all other mappings in the requested region. However,
> >   	 * it is not required to do so, thus mapping with this flag may fail.
> >   	 */
> > -	RTE_MAP_FORCE_ADDRESS = 1 << 3
> > +	RTE_MAP_FORCE_ADDRESS = 1 << 3,
> > +	/**
> > +	 * Force mapping to the requested address, but fail if a preexisting
> > +	 * mapping collides with the request.
> > +	 */
> > +	RTE_MAP_FORCE_ADDRESS_NOREPLACE = 1 << 4,
> >   };
> >   /**
> > diff --git a/lib/eal/unix/eal_unix_memory.c b/lib/eal/unix/eal_unix_memory.c
> > index c540f1e838..61e914b8db 100644
> > --- a/lib/eal/unix/eal_unix_memory.c
> > +++ b/lib/eal/unix/eal_unix_memory.c
> > @@ -17,11 +17,13 @@
> >   #ifdef RTE_EXEC_ENV_LINUX
> >   #define EAL_DONTDUMP MADV_DONTDUMP
> >   #define EAL_DODUMP   MADV_DODUMP
> > +#define EAL_FIXED_NOREPLACE MAP_FIXED_NOREPLACE
> 
> Is this available in all supported Linux kernel versions?
> 
Checking the mmap man page [1] indicates that this is available from 4.17.
That means that it's both in the oldest supported DPDK kernel (4.19), and
also the kernel version in the oldest supported linux distro, which should
now be RHEL 8, with 4.18 kernel. Therefore the addition of this define
LGTM.

/Bruce

[1] https://man7.org/linux/man-pages/man2/mmap.2.html
