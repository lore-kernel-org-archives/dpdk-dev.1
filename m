Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F98CA0EE6
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 13:55:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C052240277;
	Tue, 19 Aug 2025 15:54:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id DA1AC4026A
 for <dev@dpdk.org>; Tue, 19 Aug 2025 15:54:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755611698; x=1787147698;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=PzGCTNN81EprzSd1LJuEo03VIuMgIp/NlbJZmSnfXY4=;
 b=VwYbUOki8Hxvk2mDO2vrwW6qbd0a409yMvhLLggQiGEc8o+O4TN24aKK
 2BFfK6GZT/nPyq632V0Fx67DdHNAlNDyl8CSaP1FfBJvlPe6m/zXy1mlX
 1lE4d5bhrsiBWe50LO8yQz4gtokp7gnO2uqsqWCuPcFT40WlAr27B2TO0
 vivdutItQRkQUk0nA22OyMFBfghyViLUrrm1OT74D9dwrUrI8wXMA34eu
 PstQMwsG8FcdyEfMKlYmpyFfcVQojFLmMaE/qDsvlHh5WnVdpeLhUyEWl
 wSEzKOzphEFlH+2vqaF0yVPVau+kvtPY6BmXNFSuCBgneQ2fse46NMpIu Q==;
X-CSE-ConnectionGUID: 38riz/mdTmmyw6Ssx3dvhg==
X-CSE-MsgGUID: MCyRZuqXROqko9pWoKSJTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61486791"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="61486791"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 06:54:57 -0700
X-CSE-ConnectionGUID: x8mRQSaHSrqLmBWNlFwH/A==
X-CSE-MsgGUID: yLz7tBd6SGiybuEGD0YbHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="168207828"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 06:54:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 06:54:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 06:54:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.41)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 06:54:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEpbdfG3t6lmTwc3DxNunAqPr4Fmrf8b+Pwgm+GCHQMMTtBIKUJYv0NQQ9vhe4lKmVJ7voAIykmhqrp/WHz5Jdh3xbFqSXu5Iyo2adViQjot2+dq5uPLtyNTFSTHg53mlpHiJfyAyb7jSXLv56ynjN/ZA2m/8xCjzLr7HMPOA3saUDU44tqSg1KngTCUj4qaSDlOFGNBFGv5JaRSZwVKuHInb0apAmKtFAXVyioB5z6cMfsLwNda6GteS8hAkd4CO0CQDAxtouR7FI2Sze6wBDkUuykYRVS096TOpLktPrq68W7f5pHI9ZhCeWEanbrm3zyxh7nTjNVbcwh4JAjpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRBjdMGFQFGeYNwMEzh5/ZB7YTGrg4fp+EvHGFMocqs=;
 b=vZjMcGR/U15mZsWeuzVre0dfKyTcZQ/yBV034ssonng1WFPAKqP1fAreRZdiCH6xmqkvNZ5JqU0ij8BGQ0N/2tkTedTXOvnxl4XCxXpQDCP8HJfwujAW+pzHNXw5rwPD5h+FMxV9Hj5RB8uFOTfLr0d3hkmJfodD00SxeSj8bUWRGHBAVFeZ6aPsVNXyfm9KKkCLILYWvAtIVEUVK5tHNHIKHdiIud05TGhY6w/EWuF8G82HPERO6HDrYHVGcRkizcadhaISe/LZe5ybAZu1sTcqPextKGe3RUPXVOcgnJiLd1yLw9nd7jbtiOPn60KLRt7P9GeONyvklFEIvQRdAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 13:54:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 13:54:53 +0000
Date: Tue, 19 Aug 2025 14:54:48 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 0/3] fix build with MinGW 13
Message-ID: <aKSCKJBbVfe6qKSM@bricha3-mobl1.ger.corp.intel.com>
References: <20250813152829.457463-1-thomas@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250813152829.457463-1-thomas@monjalon.net>
X-ClientProxiedBy: DUZPR01CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: 8694f087-454f-4948-f18a-08dddf27f8fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KxkVBxSnScRRSrz1UVcyEmgUqfxCpt2IBaaPKE1UBL86rkCsmCOZ5RZUuSjj?=
 =?us-ascii?Q?aHTVUxID9jAPev5nFzA3Vz95/Wy6xPeCpHvZKd85nAAhrBjPPtF2X80m3JFl?=
 =?us-ascii?Q?fElq/L4WO5ORc48BiDiFf+1MY/CH+RtM9F5en8vonRu62cd5JNSd3i+aTIfK?=
 =?us-ascii?Q?gQAoRSNNZdwckO1CeIVdvTn2AJIMzR26ptMzFbiyo9ZxiIJbK/n5jCiSlrVE?=
 =?us-ascii?Q?7vBLgMmhEMPgvJAQ4U0MF+4b6KQ4is1jVeZiZt6ovhZDBWyBf3t3/S0E7UIJ?=
 =?us-ascii?Q?YydvLDYGtIVZo/qLWE+EKb5ctjuGxzdyUWhPEd0YJuyvF1jfpyoVqpF+uP17?=
 =?us-ascii?Q?gdGKneBTIteHR10t+DbreD47B0E2lB45EvnG69Ncjo828ijBdrM7r3CAVIYa?=
 =?us-ascii?Q?tL+zPGq1jcMQIWf0Dfs5Fa2Cv52yMitk48v8oPKXFoboqhNKeO04gwg7nmPu?=
 =?us-ascii?Q?xLOeGa4dD+KI5rvdpiSYtLaQig6zWl5HfEbxN8iLCvlRSm13K6FSmO+wELTK?=
 =?us-ascii?Q?thQTzKJNX0kBSH1+V7LjdC5S/pV9wRwV9i9QTz3z9KOzw3hRYZGFgMY2bwCB?=
 =?us-ascii?Q?B5uvtGLMwkUKgPYKsMAlYdJiHH/wmKEZbmGOvPRMJx2hX/h1hENL5sY5KzVB?=
 =?us-ascii?Q?xdVX8qhoG11TtRY12wF524S+2PFWirnB4iL00XYSg9TN2RoAFUCWdQT+kOM8?=
 =?us-ascii?Q?X90ryZ7pv+uargjwwFrhA7Im7z/hoYN9IxibhGIY1xCBP2KkVO7NBUi0OMYp?=
 =?us-ascii?Q?j1vv/8miFQ0gF8CC7kFzRBpZIILSa2DReyF7EnEB+6HL9Q0qGWEMbxLj4MeU?=
 =?us-ascii?Q?alSx+J/O8RF99PV0FJavcjhpyfaKoH0wIgcQPosSm+zGvP42otow1drriAaW?=
 =?us-ascii?Q?ec4rODdbOiLou8KrIMLolZtqCr57sbaWHudfhPB8Daf4lZUwjL3aajlEtUrC?=
 =?us-ascii?Q?kLTL8TYZalFcpaKhkPxfEMtT2l9bHex7BhE4hZSe02CxXOSaETZputUaD/n7?=
 =?us-ascii?Q?fCpvF/Ze0hLjr/ABV/6gopqz73Qmh5PMH5RW6ekajMjZNjjBEbHST/W04Xvu?=
 =?us-ascii?Q?YJPDQpOk465lqaicTqjdyWaHfjG3NQnRl46IBJr3YLnv1Nt26vDUqW5K1zZY?=
 =?us-ascii?Q?l+mNbpoOdNn7eTWYppPdat51ILOOMcFNHVVw1qn0No1Px/E8kZmiEeq6bcx+?=
 =?us-ascii?Q?S5MCdmVKkCCKfJVU/zGTbGw4iDJLz8+wm3wFIHdYANDWX2If+V/N0ys5hKG6?=
 =?us-ascii?Q?+19BEmtxJCk5ZJbGA6qrEbom4kPsKVyqCKqKoaPrlI9tRlI505/v/8UnSbun?=
 =?us-ascii?Q?d36z9HdzePafs3we5rglw3ACkimCUZ1xiFkiC03VgaHyWcV33a7aiFjSrurr?=
 =?us-ascii?Q?ZApKxB7BLrF7CapfBhRHYIyu9jFV4aV5zXLMcyVhpXiHL63h9A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fvQ5QvhWKv8lM4zCdML8WRARfkGE+iGSeqom5X6bG0VhZj74nqyVgLroKS1S?=
 =?us-ascii?Q?4o6C9Lzque2iwOjo2qy1pACgVeWvMqmYnqC4ZWh40m46i4IoJj0sKuXSU+6G?=
 =?us-ascii?Q?gmSAt9lVqKTR1RNJzEHa3apf5yTsI7yu5ZcTUanJqxEN662W3O1qzHuXn/DG?=
 =?us-ascii?Q?9Ls6ncRVi0AlYvz85k+UJ29CnzbmHiUclDrV5OZDRh+smZSXI295js1/dNDO?=
 =?us-ascii?Q?VZyrDRdSPERrKAjVyKLeZQaLEWLh1yhV8MYGyMygLYb9VtOR7DYrPh9Oy/7o?=
 =?us-ascii?Q?4etcC8bsa7HeV7IA2g+I8vm/vMiU6McIK7Cy72W5MjFagttZcxXpdPtbJQtz?=
 =?us-ascii?Q?4IW6sVnrI/95v4H5YRdZgt4Gpe9JlZE96PGje0kzrmINvc4CbHXqtTGyDOqJ?=
 =?us-ascii?Q?a+lX7x86QtrMKaj1gPfhC9V3BNLInGs8Kdog8S+3LPnWtcEhFN3N2zA5xPqz?=
 =?us-ascii?Q?DIijjSmpgnK4jfEBb3aeFI9M8aoE3y58WV/i9m82Az1M7oQFTMlLxKbYGB5g?=
 =?us-ascii?Q?Tf1wHrOcp1N/upN0iE6Gw7PwNKKjGw/OtbPtmsdSVruKQsysnodm2oQoP4ZH?=
 =?us-ascii?Q?65PJMxY7vW4FpoJLRaftF2YUcpIT2+w/bS0KMkzU1rWSr6y0J/YEAwRZP680?=
 =?us-ascii?Q?2DZ+Axmgp1iWih8gqOeF30tS6ek1bk6h58DeT39sLHE7zDjluDzlx/U258fJ?=
 =?us-ascii?Q?xtzPEliMGo6UBw0WG3V07s9afeQHuMU3kbsfTvnyRz7R5B1oj+XclVvIHzbq?=
 =?us-ascii?Q?Jk4Tari6vjZngwaGy174Y3PywOHScxdxHCikD7iOrdAhr4CRrIph8qoaqlKg?=
 =?us-ascii?Q?8ZSBLEaUsQh9KTxaTljrsOjW91UKEbOYvhd+MXymrfZfOq3Wsvy6HrI58EV6?=
 =?us-ascii?Q?36NGrzIkc4c1YyRF1iAODtsliZJ2xUNCLCN3G7WfnTCMcZZ/Ht0PPaHSYw5/?=
 =?us-ascii?Q?+Y9UIS1SiH4vcl6cMtySiGpsRN7vw2kU9yFUACxOrDExyPMvZMNEB81ZgblK?=
 =?us-ascii?Q?1o8m5xsKcnY1VJtO2wqwbyKM4JzGV4knrJXxHwFD/jS/4pwOY6eb9PFnIWHQ?=
 =?us-ascii?Q?b4elGIoF8SqGSRX/FwccKa4CJWs+JSpblP3qmq2fBuRPEG6uHcOgD1SKn3FK?=
 =?us-ascii?Q?+3Wc+5Etk2Pttzu5fZlF5N0PF305+wpTIpX9uLCc3HEvA00nMId+O4h3jNBb?=
 =?us-ascii?Q?4+/XKRvgheDskQrkEoBzO0Ic4FdakNR/DvRVfpPPZBkkb9q1vwrf/CIA2GbT?=
 =?us-ascii?Q?eZzjSkJgywbq10J+5tqkfVweDuNZDMdQz59dezXAhE97mz4P1ZSVQkDbeHii?=
 =?us-ascii?Q?P1A7n2I7REMc8aUwfS/vhnt+x8vHm8HvOtILZ3fcxFu/YezO548I88YGGmO9?=
 =?us-ascii?Q?JywtF8Jyk/tCmlAq7wlm0c0gQ0QfS+oxovKaGNzVarsXCMSal6jG5w1xlpm1?=
 =?us-ascii?Q?dgeBWLIAK4qbcbRjVJoNOmLzvTfpAlkl0y9Rw+zgKC++sdGqmATJzFwaddQc?=
 =?us-ascii?Q?phuV+5dhTXki0flN+SnZv6bdYI2bcdAr7GXGrweMbAqOxHuHMaUFVXdifTXY?=
 =?us-ascii?Q?C2y9+4zmOKFFMmxNoMYDiMuhCyswR9xQcAerCvW8TKvi8ikeyuBPLAmtCOKS?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8694f087-454f-4948-f18a-08dddf27f8fe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 13:54:53.2144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgIxe1ncABHS4SPW9P8xdzQMnSUvtRWPcS63cZQvFsfJZiOxetYK8J0O/xxWkPkjRR+Y4nKvOLeCM3RvtS3BH9jk6FRe1JV6U2xuOMb5uOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
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

On Wed, Aug 13, 2025 at 05:25:22PM +0200, Thomas Monjalon wrote:
> After an upgrade to MinGW version 13, some compilation errors appear
> in PCI, mlx5 and bbdev code.
> This series fixes them all.
> 
> Thomas Monjalon (3):
>   bus/pci: fix build with MinGW 13
>   net/mlx5: fix build with MinGW 13
>   bbdev: wrong fix for MinGW 13
> 
>  drivers/bus/pci/windows/pci_netuio.c      | 6 ------
>  drivers/bus/pci/windows/pci_netuio.h      | 4 +++-
>  drivers/net/mlx5/windows/mlx5_ethdev_os.c | 2 +-
>  lib/bbdev/rte_bbdev.c                     | 9 +++++++--
>  4 files changed, 11 insertions(+), 10 deletions(-)
> 

I don't see these issues with mingw 13.2 on OpenSUSE Tumbleweed, but
perhaps I'm just missing some dependencies. No issue with the fixes
proposed:

Series-Acked-by: Bruce Richardson <bruce.richardson@intel.com>

