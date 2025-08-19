Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B711DCA0EE6
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 15:40:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDF5E40653;
	Tue, 19 Aug 2025 17:40:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id F0FC8402E4
 for <dev@dpdk.org>; Tue, 19 Aug 2025 17:40:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755618038; x=1787154038;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NdK6lblcENi7XW7dJhktY95xlGOKX4cq92zX1cLUDjg=;
 b=L22yLGG3lP0lzRaEh4iEDHMBJdeFwpaKGhimRoSlQl/wvt1msQ0l/3MH
 mhZJDiZkN+bcLky/cTaXIb9ziFfrETXafzekq/eCcvHIr7r7aBlmqBi5e
 YBbynZQ5mfj1W5QNage3QiX6Zuwz8nXe6+sC+OWqBmBsaTI+0tLs9BqxT
 4SPdH/MtxWt8LAT69aw9DwNZqigMIGStQGto2hf7/WI63UPkULOYaaRdM
 HMEFH7PHuD7yqFDYhwxvBQSbUspBzxD79ufLCGwn1VsMr30fCIl9nSrnN
 YoMuN7WpIV1BW/7f85yn9+RXeseRtXECLibSWJOgcD1ZDN/KgFhJg/xY1 A==;
X-CSE-ConnectionGUID: 9jiTtsFbRVm46EAk+v8l7g==
X-CSE-MsgGUID: dYr8l9PeRGy3tvU99XIRvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57792243"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; d="scan'208";a="57792243"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 08:40:37 -0700
X-CSE-ConnectionGUID: xJl755FHRlWRufjoUvlSJQ==
X-CSE-MsgGUID: RODAnplKRG6B5eA+1wqvAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; d="scan'208";a="168676068"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 08:40:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 08:40:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 08:40:36 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.42)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 08:40:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFY6wvRl3legPn/X7DnyCt6kSLgTLgIy8vFullgxuXNVXf0QbS8bSoVo32Kq6cc57jbplG3vVf0LhLDo1AV6MJFXfZIpRiWHOSRYfYPcneuwyNK9mMATMuXa0c8s3RZmnLcMO7Haz4q889WGVvNc+9nVB9dl23n97AT7focNnnPDbjdyn3AEeE75T0gBV+Q0mYWNQVXZmGDzeYYpPy8pMuXSmtfOLmF5D67Tfm8rc4gmH8qIQiGXTZDVF05nIrlPfn1TjgoEOHjxp4hxT7JuQ7DqLllP0qp3xpkws8/75oxwUa+O8u9p2WJos3TVP0K5IAm0Xw8XBciJUR1rEIoX9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQj/HC+w/xOXV4BVTrUCW2+kK17x+Cy+of7jFVKehKg=;
 b=SpViQxb3x5RIHE7/usES+NTSEK4PyyCm6ATTdMm6Iphm/ItsLTyxZfz67TNKf6WlMMJuEsGMthxOVC+2a4H3ERysqD3olxjnHwvzcTym2gWyg33iVL2rxImOCKIyWUBLFHEXU4gwDc7yFg1MRFaJpeGSPqrp/G+dlhW1foQsOn5k+jjDStE42Bhp25pVFhCIKxd2hGV9gVVEXkd6L20YapBuL+H/jrcOVj4Da/qBp7scK9aquk+DLdAOEd0xrHpSLRAj+j6ULuIYL7bWG/49d2E/4EkZx6LTtqYoDwTZqZqOZTg+6zDNfIqww4RskEHcIhKYVklpFHB0D6EqKlEIvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PPFF3F4DC26A.namprd11.prod.outlook.com (2603:10b6:f:fc00::f62) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Tue, 19 Aug
 2025 15:40:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 15:40:33 +0000
Date: Tue, 19 Aug 2025 16:40:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>, "Tyler
 Retzlaff" <roretzla@linux.microsoft.com>
Subject: Re: [RFC 01/47] eal: add BSD version of queue.h
Message-ID: <aKSa7Hjb-UIh-4Ak@bricha3-mobl1.ger.corp.intel.com>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <2598643.Sgy9Pd6rRy@thomas> <20250819082444.66718343@hermes.local>
 <2710899.tIAgqjz4sF@thomas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2710899.tIAgqjz4sF@thomas>
X-ClientProxiedBy: DU7P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PPFF3F4DC26A:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd0a579-05f2-4d21-24f3-08dddf36bc26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B89XW0Zchcy64sDLIiaE4HlFzrvoqBocGItAYDqtgtfsUwT1YK8bWtXH52Eq?=
 =?us-ascii?Q?PSlN0UD0e2oZf9+QKCKo2G5GFHV19clUweGkcYW8SNBpytl4E15+PCNugINd?=
 =?us-ascii?Q?lFK9vuMSRSC1oxut8hDiJJBkEUWD/xW103zWF6WT2vJo35Tt0mIiq7+n0Gx3?=
 =?us-ascii?Q?RYBNE0NKdr48j98toYuf8fHnGi3YJwBf2lkSsSBxb/+Yy66A+GNRgAkWpCTA?=
 =?us-ascii?Q?mfB5wg6MjuGC1YW5IwzDuV68BxY1RGuVvEbv4CGiifxiBMXlz+pIDa+ulbPR?=
 =?us-ascii?Q?sRpBofuWdP8VhRtQIj3/JtFqNn1A5fZAFnccdyuD1fQAHjFOYcGPKvtzBUMT?=
 =?us-ascii?Q?dwVqLt1xZifmiaenY3VCbOGia9KnUrOi1ieq+py+/W47Ax+MFiXIe922+Dej?=
 =?us-ascii?Q?JHjeOx1j51EyQZ/nycLFwvviQDblV51dhG5yNbCKHu5XOCHc8rXut+Nzoyhc?=
 =?us-ascii?Q?N1yFRK89Zdzsvfe9UaQl2BBEUqcg0zfVOpFip5/E/z2c7PBoC5mdezrG8q5F?=
 =?us-ascii?Q?xkCVfGz2V5m8cKg1zdNV/7buPxEC5sT5oFT+jJn58y+Mm2D+ZvVbl3K0yqh0?=
 =?us-ascii?Q?5JQnV9dL+U/GgwDE+5NsvxxLgSMgtZs3+Rl8KBS+ZoXbWVcnMPJphygO2s/I?=
 =?us-ascii?Q?emCds+HNnqfB28pR0cBiI5ZQNz2n+SsN7B9mybLKaAeQ5nlboBYOJc8vdddM?=
 =?us-ascii?Q?6WXplJwgSHoEeQ4iSo9H3wbfAKzc9oTsF7nsUT/AXPxMIUSvIndBMZyyKcP8?=
 =?us-ascii?Q?2x64OUeYspY2SkEQOJ9IaaJ9/+19G36Ha39dY0FoVyptkxoBw/Qrz+IEh7mZ?=
 =?us-ascii?Q?kCZ5nhmAHUALyqi4jEEkDy3zYPcsisCzxaG8hXc3tpLhLHwAgbEkiV6FL+TZ?=
 =?us-ascii?Q?G35EhxAxnSiXzK9zb9lAZKVcXEKigvixzhweJtXj59Nqq1jUE0u1oMh3TyP+?=
 =?us-ascii?Q?IdtF0DyTWY56uXA2DtD6VSSoqEKZbaLCQrmCsDWEWHdSkogxfBR7QODJRwKR?=
 =?us-ascii?Q?D77LTeyALK7fN++H3De7USERGcXbqVUXq3ZhGFrHMlxIMZCm8oD9+Wc6aBP6?=
 =?us-ascii?Q?jx/17Pw1iCo8xRKhiYgz9s2stEU9in4/HgvQGcZEPOV2uZxqueRdXVuzTlUj?=
 =?us-ascii?Q?HPqHlnCcq9xGc20tZfKMxW1iJugKH/vm4tFtbC6Qz0NTGePHYpl/fubWJmfO?=
 =?us-ascii?Q?KmhnuzXJT81+iKAALEeB1HSZ8GwGafj0G0LpcDUtQTwXPJVmEhcXPc7aUHoy?=
 =?us-ascii?Q?e4VJMXbzcjav5kUntMiaYUSaQdKboLIEtWC1wFYRpuQZwDluN3GRWhoZG4+k?=
 =?us-ascii?Q?ZrzNxfz8PU+wCXdJFjhSLhL5mIIluO5bHYvZ61TEZl1RwMSKXxCS/R8zxOFR?=
 =?us-ascii?Q?D4+yAmXqQuoTzpZFXhkUqm5NB9i2RnZrMPKT2LmaVt7MWvjdv9m8j+3pXXu1?=
 =?us-ascii?Q?CnRm7G00T/s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AZ66lMKD6TkSxqmrfujEfie5wlbc4R5Mnam4oGs1QEAGdRQNzrB+/Qx4ZNzO?=
 =?us-ascii?Q?jJqhF5c9HHk98riQj6x3yL6JGgtYRiV3EFb5TRqqbcv+5DwI3Nlw6v63fmi4?=
 =?us-ascii?Q?Sj7nMYztZi5Q60/sTqb9yge/tEhK7v2sqql+xCSl+DPiAuyeZHq9uMKzIIZl?=
 =?us-ascii?Q?a18XhiCjlyt7cLC/fzWC0rXpi5rG6/7bEQ0uAas+a0MrmIadgKHBnOOaqohc?=
 =?us-ascii?Q?Ce3eMwlKUJEQmzNykFsgVyZrp12YN1AKzhgsKd6dduU3hJzFzkAu8oMEsyRb?=
 =?us-ascii?Q?vQdjO2UMmqn5GTKg0PxiDdRt0Vb5zthSDZNzbpXhhgc7Eg9u7kjWfZlvyC0y?=
 =?us-ascii?Q?q1Bg+XLk/66Pv7EOCGQ0K55OB35c6xuKHmLsYrTm444OiOLPtS3828KjvR2t?=
 =?us-ascii?Q?cIV5Cigu6K7t64zrtsMr1U5cdlnmvgnsVqY7djmDupz0QvbCJXtL08weFYjJ?=
 =?us-ascii?Q?jrV1l7WFgXQTeZkzC5zieFF/JPOFXE0CTroef1oaLbHBbwwdN8GYCzoWXZ6l?=
 =?us-ascii?Q?iQD0f6cNIPpGo2WpfXZfyUvFajs7FqX0SSmTv4SimGYQJN6AJAIiQydAkra3?=
 =?us-ascii?Q?3GaEMgGSWJNKzFsbmv973QUILz4zre4tjOlNURiK1nytM82DJN3CKyAVrX41?=
 =?us-ascii?Q?ra3QxHKlzlj3XboJxdW5FaIuYM1EVU+LbrDDpcScuW1+DfT1zMqBaQUyWE6j?=
 =?us-ascii?Q?wNQJM7NV764Jj1It37oQIY/s2GeXoKfrfIxPydzvREORMXD2lQGVJkInBDwI?=
 =?us-ascii?Q?VtcN+/5qii6kcsVWtNwqBTSB11vLfAEGPHmukCtvykiq68dwdbPlgGF9AY2w?=
 =?us-ascii?Q?4/xQOpqXFGQtw782E8n0/93zw+sXmDHBel0LCiKBo31q9kr46VdxZDmZidNp?=
 =?us-ascii?Q?Zt3cn5tnKwBSzQZNWz/1TJL8W2C0MvjUcyEYsoH4ypWgmbHP+qD4tFc5ivI3?=
 =?us-ascii?Q?zhLiFXe6eP3xcbiHqJRe9eXIvkJ4uPycu74f/LdmLBJztbCEX/lSLi3EC7fe?=
 =?us-ascii?Q?zyXgDvOlf06KHsb9P+0Wmd3lF/HYW4W+z5vKVmzlzpw+g5PIF+v3XE6EumSZ?=
 =?us-ascii?Q?Gb1MpWqtIFi2PANz0xuY8CNcwhBDVlve8q+fPQQ2DFJ6s5yCUe9A9hcvlYFX?=
 =?us-ascii?Q?2JMELPHOc6e8gXi1GEm7VIUPjAAO0YSK3Xb2gaAICJpE1SPRSinR5mho1WWE?=
 =?us-ascii?Q?6P6eVE9B7FzkGSSHwYe7h29zoDoijHF5uI6qwezLeaAsH0KnCe7nOJjSD1pA?=
 =?us-ascii?Q?eJ67Jwo+jQKxDsDtU2MS79DK9bZbn2vYvXdA/ACuKEMbeGI0kBu3Tanc+V2s?=
 =?us-ascii?Q?OrMOA3y8Qvsa8xm2fVbRw+BX8dyYNmXjt0TprmfBBcJCreGj0r5HVOgba7Bc?=
 =?us-ascii?Q?YOHbLmHxIbxKjnIMciZdRDZ3Paw9gDmxgRHmwmWjowTb2Eu5vqHuY+Si4Hf+?=
 =?us-ascii?Q?OeXZjAjz/75HVEKFcG2JpfQkHCg/d4e4rr60nNXc/exnVYMjvQTX31KDTkC7?=
 =?us-ascii?Q?dCqs+lxkTiB7WdDm20NdgsIvUqYWtM/AT0gBhGZWJV5/1lSxeZdVysfJDkRV?=
 =?us-ascii?Q?3DVsyjG7uRyEGYJMGAfZDqqQc3E0GH3orp48HOLWrC7GhFfH3UFuaTbaGFT/?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd0a579-05f2-4d21-24f3-08dddf36bc26
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 15:40:33.6922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/t8XctGNgi1Ax9RKUqaQIjfrUP5hG2GIgaxJ2jzbY2rdNeHcaeC+cPsxpXFNX8DdUQR05AK8SA0RNaAstBjC3p9ZCLU2TjbOJoNqdnD1Do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF3F4DC26A
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

On Tue, Aug 19, 2025 at 05:29:28PM +0200, Thomas Monjalon wrote:
> 19/08/2025 17:24, Stephen Hemminger:
> > On Tue, 19 Aug 2025 10:37:27 +0200
> > Thomas Monjalon <thomas@monjalon.net> wrote:
> > 
> > > 19/08/2025 01:27, Stephen Hemminger:
> > > > +++ b/lib/eal/include/bsd_queue.h
> > > > @@ -0,0 +1,1075 @@
> > > > +/*-
> > > > + * SPDX-License-Identifier: BSD-3-Clause
> > > > + *
> > > > + * Copyright (c) 1991, 1993
> > > > + *     The Regents of the University of California.  All rights reserved.
> > > > + *
> > > > + * This is a copy of sys/queue.h which is used to overcome
> > > > + * missing parts in the glibc version (and Windows).
> > > > + */
> > > > +
> > > > +#ifndef _SYS_QUEUE_H_
> > > > +#define _SYS_QUEUE_H_  
> > > 
> > > Shouldn't we rename this include flag? with RTE_ prefix?
> > 
> > 
> > No, by keeping the same prefix if the user includes both sys/queue.h and bsd_queue.h
> > there will be no confilcts.
> 
> You mean by checking _SYS_QUEUE_H_ which is the same as sys/queue.h?
> So if I include sys/queue.h first, I will have a limited version.
> It means we should not include it before any DPDK include.
> It looks like a limitation for DPDK users.
> 
I think we should define two defines for our header, and warn if
sys/queue.h is included first.

#ifndef _RTE_BSD_QUEUE_H_
#ifdef _SYS_QUEUE_H_
#warning ...
#endif

#define _RTE_BSD_QUEUE_H_
#define _SYS_QUEUE_H_

...

#endif

This way, sys/queue.h contents will be skipped after our header, but if
it's included first, the user gets a warning about incomplete
implementation.

/Bruce
