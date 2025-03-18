Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DFCC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 17:42:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE34A40612;
	Tue, 18 Mar 2025 18:42:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id B9FF9402D1;
 Tue, 18 Mar 2025 18:42:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742319735; x=1773855735;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=k6gnDEsEhGOYsO2kI1ENWSTuldvBqBS2pVTCYvfzVes=;
 b=n5vd6toK2YXUZeM/EEWpUFWwGCowOhjxFM0RE67II+VVgWjB7fhZErrA
 ymHEibf7bnyw3HNe7wKf9NGVZAlEygV2NaA4B1nbmlZMvb02qJxlyNq/8
 4Tu2CfQaw7csuk6eXkf/9P6QKCpuIQeiJRZdPiazzJsFMu3bYDKkDz5Wc
 eagcVwaTsatJ/ajjsHRRleDjHbCyPUsgVT7Iu2019NStxuKZCA3KiywYJ
 MQhE6PFME783u2GSowqquxddyhgmwvf5zaXyoLegbIPBVOekIbZ6OU91j
 broFDCLo0+wiiSstbU2LAD46XxkzOF0kHixO5wml4VwwLSxl6rX7r11Za A==;
X-CSE-ConnectionGUID: A/lO3ntgRxa1hXF3lP3g6A==
X-CSE-MsgGUID: USRLozkBTT+Ehnydadh7/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54470798"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="54470798"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:42:14 -0700
X-CSE-ConnectionGUID: hG/GG/haTXOxuqMKp4wlog==
X-CSE-MsgGUID: AvSDLFHMSTCzKJrpI/XICA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="127437035"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:42:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 10:42:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 10:42:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 10:42:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6hkCQ2mDjwxWVZuLm6/4VMPvJaa6ouKjAnQBc1KID75IhDDcjL9FRJzCRtseWWT5gSjvVK03E/ZgErr7b/K5wvAxcdk4BGB9Tl3oy/NDjQ35loaJUOLSrD3LkrPFirgEqeIn2Jmcr4bmDqu0onShP7ZCE25SlqcGGPc1DEn0YzL1vR8bkVwwQf77ten19vGZvOIE6iCflxSJ9JKrFvSlxlzrvuAiCwtJRR3cOA//iHhHPFc20IxFdGj1OzAY4fBDnJy79oITO7WnoL7SEQtZudX4WpQShfJqlZV1nPi+xM9YWtDJX4AUPDzqhjIoaBo2/uvlTaSAye2xK3PSSB9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5rSOyQeVTeNm06EiNE7dAf0ZJCTuTtgh4dnyZyaAiY=;
 b=bZ0gRRtZwFpFpVFwejFtlG58+IE+UI7cJROrbnshWozH5EOuAWz3LgUXxJxozfq5H7fswCp+G6o8OhaQJ7G7fao8GtGHwljBjRjUPPP0khA/xyx+veck4dsmYeRzSp6NnFaHxwslElwRatxONF4PcZ/DieMtmN5aGp1jomdEjhv1cUxZwp9m8A872LYud+HqhKq9zSf9DgUXD+YNli9CoajWKKlmevJZr3iVOWXStD7WK7jasX6RMMelcbjmmCsidXFkedL9TiUl4MxmJhAbpXS/KOB4f3qHM/0pxavyZTP/9RLn2XQgqyubtOoNGYlCeY7IhjuVJzO02K9FjvCK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7842.namprd11.prod.outlook.com (2603:10b6:610:128::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 17:42:06 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 17:42:05 +0000
Date: Tue, 18 Mar 2025 17:42:00 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2] eal: fix undetected NUMA nodes
Message-ID: <Z9mwaI1dYk_6UR64@bricha3-mobl1.ger.corp.intel.com>
References: <20250305134720.907347-1-bruce.richardson@intel.com>
 <20250305162458.1059282-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250305162458.1059282-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2P251CA0018.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d5e940-d371-4d90-057e-08dd664432eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b/DGoMHd2nvBQC5LYyhZEiq6CCUV6hQOZyl6zNLBosEaOwBUP7Wgix37H/TF?=
 =?us-ascii?Q?L1TXFejv7lwhohUsjMW9rvwAycpYEn1KPvvll5CnOwsvCsDX9nh8YNKLRJUE?=
 =?us-ascii?Q?83+8MYzh3Slt9tboSI2ZPuYinbSvp6S6EeReAR1obZ+x/PNMQORNhT086oBZ?=
 =?us-ascii?Q?Rc0rZZ3WfNH8oJp1nye9HE6MRV4d6//VEw6kWv3AzR3NFsGDmT/lHPT8F6Ef?=
 =?us-ascii?Q?+1hETA9/zlzwh7/fEbOH6qXN7eByfSp56RyCXq/NREtotVji3KPQu0njUGZq?=
 =?us-ascii?Q?fP/mHLfcii4c5nSVJNepdOl63yRqiCs1e+OoPKtniP/9fxzUuC3UxG42oOMN?=
 =?us-ascii?Q?Ot3fo/RcPvSfBdcnveYKLg5WtOJ2E0RlHLoIr7va129y0gjuzHOm6TRHPX+V?=
 =?us-ascii?Q?ErTLwMo1Hsr8Q28vO20sfMo1TEVQegRNtk12DpiQ25SkkLZquAFJ4cCi6L5o?=
 =?us-ascii?Q?C0mg5jgzVX7QuFmv6TmLtBWrTeqgtJqOiV04N5/kEDxbjRB5HynNnceLfraf?=
 =?us-ascii?Q?7pfeCyEkkfuBJGjBJC9dcJs/An92+ddPOkUadCpni/iQtUXzzctKjuEhcndC?=
 =?us-ascii?Q?eQEuu415e/4NqA2Bh16rCXTBGFfmG+nnZs3jaujdjF4Ab3Mhs8SAaU4byITi?=
 =?us-ascii?Q?Bkgbm62qcPrV5HLRaY51i+lwi1nP8CtT+xOunOEmPoM7BB9E7Nj6x8lsKYOv?=
 =?us-ascii?Q?2RruWS4B0skk9UvyaGCtXe9Hh9e4ibWojb8FEiba51ZDWwY1CF/fTrupdyh7?=
 =?us-ascii?Q?0HjeSJbRbzyqIbhussqu262ObE1pSqNh+7XMXx7ahZhb5b25269lZUJLbcRr?=
 =?us-ascii?Q?uivPNcl/foxj4noAM7WsFlKwCsWDX6l2gRld+z/1XXEW/0EwOGE4VMWKrOgW?=
 =?us-ascii?Q?unPFg5nb0GI4mYZ4m0OgD8zeee/tLlAsF/hr2O7JyDVnlq2ACmggFXj2wvIU?=
 =?us-ascii?Q?wtiWYmxYk7UXGzuWjbe9b601FRFQOakRT3vxsY03a2HfoccIEZGMgNnTZ6k4?=
 =?us-ascii?Q?NqSdY5aGQ6TInXcS3hZ3r4TeR7RI+k/rWSFecijHwskEoQcCHPkjA0h6YiEu?=
 =?us-ascii?Q?b8HRL1mBHxEGnqGxnVmcZmmbVOxlbQ/a5Eyh+eJy81AraRzQ+me/1wyr0n0z?=
 =?us-ascii?Q?i7S0TzWMd4pUX93OJn/HTKQF8rporGeDV9y1/6YLgH6rTjKbHwplfavYXkD+?=
 =?us-ascii?Q?VFiT5WFOIDqFXGxNqHRjjk3QBPeaKz4Oo/SVqww0eEoaoTlL6bAR0ECTCVIB?=
 =?us-ascii?Q?hKy9ZFKupmHhLTXZ659VSNVzQVXJfEtDxFLnrRSKM4J1aur6Bdn9K17TUCVZ?=
 =?us-ascii?Q?Vpf2qOEmvZc9kyDkz1+Mm9ZwVrSDwizZcwiVLwofX4/h0ufGvFBirLJkqz+n?=
 =?us-ascii?Q?hrI0zjRn9y0SpPabBB+dj3M5vo0Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qTH5J/rIawqjuKgHyVQJFo9dJ8Bgb5T2fKf4uYHaUsB4nuat5amm8ADAqaCt?=
 =?us-ascii?Q?bRG7ioVGzRPG6A+4IaD8ixz81e7eLsF2TtVrYkV6bb2I6u6VE5qcpPdqmnnv?=
 =?us-ascii?Q?ZCJfpp6MZGNH1xaBYK3AtHcy4KqrmKP+GUSzeaSpZrsliBOA6TdpRMX1S/6A?=
 =?us-ascii?Q?4EngDMsF+SuAx7BwDLpy6wY+ofFuutSsgDbKv/FJQKYdqVXVinqZSF8+rZez?=
 =?us-ascii?Q?13z1Gye/c0wIBDaJf36ySn1uiSeeDylNUGtGhqpxAtGZiEWqzuwZYh47GdDQ?=
 =?us-ascii?Q?rdhiQVirIagakLyJoOPg8UDIM3XHT1ymGg7vAW8wX7K9VyE47Ddbctrfle0x?=
 =?us-ascii?Q?r1yoAYZEg9r1k82Oos2W98ZGNTTtBT877Y2dB7Opl29TTAgj1No3mc/KPlQU?=
 =?us-ascii?Q?pAZAShErDyrXijQwQ7zbJOcG+XSYC8R3Y6aCBLmmiCNsq+/Ue1o4LM7taym8?=
 =?us-ascii?Q?yQOBys8qhlNkh3bCyvY+nAPupAXEy68KZvhQPF64/Z1T+E1T5qUQD7jOpUnS?=
 =?us-ascii?Q?mzVlQk3by0c+I7eKnm4Z295Bytb6PiShe/cSGmaNF9C3qnscCCEg/d5cmMUl?=
 =?us-ascii?Q?XA43agzESvofQXTyQcgUcbUdE5pIL7+CmwzxgRcGHDd0nj9Ldu8yHmpVYxqQ?=
 =?us-ascii?Q?rEHCBORiheIzCQamQvHsSeqxheqt6M7xuFI2BYqcA6SsH3I7kQvcxkJPCmO6?=
 =?us-ascii?Q?ClZLVqY/Hmx9ejX7TPi8w9Zy54hZ2/pdRVAbMgLgvR7DE6nd3IPHXXFTj8SQ?=
 =?us-ascii?Q?7czV45LZhUGIbffFvTYVejo+3TpXR0AxNyKF9FZM7pSqjrKQ9h+Xl0oc0K2B?=
 =?us-ascii?Q?x83e9q6z+AXPPROaeWnluJJ2vQt3Uhlac2fZe+hcoqV+Pd/SO67cS6Jjxdub?=
 =?us-ascii?Q?r4p0M2RWuCLKpTbq0s8d1RQ0yov018tV4r0wI+LWQLjONUI4d4A/qxjg55si?=
 =?us-ascii?Q?whxXKtJRe6/orvcKy9kdhvtkvHJhQbNNR7dnQ3+cTvghilGs27e/VkiArXdV?=
 =?us-ascii?Q?bAOGT+r+LS3dcjgDD406wRGTU/VgSaBj2XByINGOnDhFoaLfboZQr32fE5hI?=
 =?us-ascii?Q?WQumTpkt6+djmTsA+AElZ5z6alJEQ0lYnZ2aVEPdKSiu7Tf+LCWz2U15MNSg?=
 =?us-ascii?Q?6x9VJ/35UzA1+a7s5+yeZhhdosMpbMbVAPYgFXxcaN5bZ0IFDW9Pkc9zSD3o?=
 =?us-ascii?Q?U4JeeDg+s10uYF+/hYv/A3UWEz1lBTBnjcHedqOtxYDHrW2FNZKe68H8okU7?=
 =?us-ascii?Q?EuHNwzci687efWdH7Lr41CFNNe7v0ESk/Ov+DWx7PNkrCdGhCnUWoz3q+X3A?=
 =?us-ascii?Q?X2lDd1nJSiF70P2DPCkTQ5S6mnggOtA6tdic86abB/AOa7Ai7vZtgE/+FPF9?=
 =?us-ascii?Q?wYpKtO3iJqeRZ/0B4+pRwEhBIGtF8AC9ur36yVo3l3UYmQsl4pFj2QW3EVtn?=
 =?us-ascii?Q?brK/yglxl12NdTkeJtGYARrou3/lGmRb7x2LuVzYbnZj6viGJkRZRWQq3zGl?=
 =?us-ascii?Q?XpYNoYN2bil702bidpGDq0Eu4PCOcHoKQHJ1SZVNxeEqpRabZOJ3R209Peiq?=
 =?us-ascii?Q?l+LTuEKSC9n9QaOxIa/y0P2aWjeyi2mqgMsIFzYTGWXpIgY+TcygaGIYcLxR?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d5e940-d371-4d90-057e-08dd664432eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 17:42:05.7442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgSW2hLRD3J0i7K1hKlCjquEkRpIBzlE5DqzoKTEmvnIeIO9BQn1NLd+b2oSpyKNZdBimMLk5L7IIctGmL6j/fhhaBa5WPL1f1E/yKRcW3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7842
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

On Wed, Mar 05, 2025 at 04:24:58PM +0000, Bruce Richardson wrote:
> In cases where the number of cores on a given socket is greater than
> RTE_MAX_LCORES, then EAL will be unaware of all the sockets/numa nodes
> on a system. Fix this limitation by having the EAL probe the NUMA node
> for cores it isn't going to use, and recording that for completeness.
> 
> This is necessary as memory is tracked per node, and with the --lcores
> parameters our app lcores may be on different sockets than the lcore ids
> may imply. For example, lcore 0 is on socket zero, but if app is run
> with --lcores=0@64, then DPDK lcore 0 may be on socket one, so DPDK
> needs to be aware of that socket.
> 
> Fixes: 952b20777255 ("eal: provide API for querying valid socket ids")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> ---
> v2: handle case where RTE_MAX_LCORE > CPU_SETSIZE (i.e. >1024)
> ---
>  lib/eal/common/eal_common_lcore.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
Ping for review.

For anyone wanting to test:
	 To reproduce the issue, do a build of DPDK with max_lcores option
set to less than the number of physical cores you have on a socket.
Then when running DPDK, the number of NUMA nodes printed at startup
will be incorrect. Applying this patch will then correct that.

Thanks,
/Bruce
