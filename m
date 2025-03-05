Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802B3C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 16:52:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 921F040275;
	Wed,  5 Mar 2025 17:52:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id AA67A4025F
 for <dev@dpdk.org>; Wed,  5 Mar 2025 17:52:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741193541; x=1772729541;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=C9VCOOppqrRKoa+i3GdeR8XIZIlnhqrnkMZJi8GvMSk=;
 b=mI1558Kmi3qLVj3j0fI4DRAcqNq9A8uFoTzyEjwpNR8QJ0MKJlJ0kAm6
 SxCNFmuVqxe77CtAd7H0e7wx4+3R49bzOw+dhL1o9/CJgVjL+Je9w9+Ai
 GuqS/Q5NjGbZindN5oC/MheioO3agG24BbARNVjM4yy6YKoxibZp/pGTx
 05JV0V+xCLto51EWJm15e9eaYWLl6wJv/nwGyX16HFIIu8V62pi48N+rO
 ctEDVBy/v7yBVkwhN51t4+xeyrtpxfEQDQqV8dXA7tuj069JHguz4I4NI
 xIGDBrR3VKh+BsXdsUwAMk3y8t83a/L7GLjXNNo6Llkkg1fkDkh1+1Iq3 w==;
X-CSE-ConnectionGUID: PzAnJuJsS4yUhdHqfYR2fw==
X-CSE-MsgGUID: KCcIToBdRU6Vz2poXJZhuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="67537668"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; d="scan'208";a="67537668"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 08:52:19 -0800
X-CSE-ConnectionGUID: +qJEebqATaWomDeRZcnHpQ==
X-CSE-MsgGUID: 0gmsrMERQO6O8ceOoGm7Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; d="scan'208";a="123772830"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Mar 2025 08:52:19 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Mar 2025 08:52:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 08:52:18 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 08:52:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiUSSioKgJPWDlXLXFAHiTgxKXhtqEVovuPXdX7xF+Dh1tV439YTEmoqmgZVvTYosq2EVv4p2hxsddvaYys1VpnB2ww9ZPlEKBSVcxtwYiUEL33rvpjYWnQnTaYSfB5y/cd661jPKmEqRm4foJvjW9iUaL/vaY2OKdaRJ7Hn+h7s/5vMEL9SwfYhRWtPsKjF/XsODysQJnGZt0Hb249mstT6Qu6C4T3xt6vdjZ6GymlGWwWwDMTBIFw7luWjkS+g4ZTe7QX4xN5CuDEs4wZ6yxAUrcFt/QOrLmO64BmYbKEPFWUe07lR/1PrCoMHksxpU0ivhEXM/3xMB+lurkE7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PpVjXjVFNuiYSjEKfg0RPLyDTWCCGMNptTqjZsb4wU=;
 b=j3qDIvBBNZOoy0iDGSK87eZLLdmynInxpTLa8UaSswkrFtRt85MTt3SJ5zRveUJKbpSkZAMtgLbE9CD1VmaNi0G0WpaVgBujJG77PWdAG2hUtshdIo5XXiJEuGlAILSiOrUPGmiA58DxWr+dcBD0puh1T0v3WYP5K1l7bhw7Ix97PIsWbSQA7mKUUYNzo5NntXeHo6VNh313Rv6k6lyqiAZHurfrrR7Rh2+Uu73lZX3hPkmvqXCi96RhRfN631FdxY6SqsuwJ1Z1pyIHDZ6t+sqLN/bwG707vKUXU+gDo0G5pIBipLJJ2DFxMd9Q04wV7BJfxfonbbAzH0ZHGtgWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7777.namprd11.prod.outlook.com (2603:10b6:930:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 16:52:15 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 16:52:15 +0000
Date: Wed, 5 Mar 2025 16:52:09 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, <mb@smartsharesystems.com>
Subject: Re: [PATCH v3 4/5] net/intel: use portable version of
 __builtin_add_overflow
Message-ID: <Z8iBOZuIq-Zael91@bricha3-mobl1.ger.corp.intel.com>
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1741192690-26243-1-git-send-email-andremue@linux.microsoft.com>
 <1741192690-26243-5-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1741192690-26243-5-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DUZPR01CA0105.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d5e5a1-4d36-4707-da95-08dd5c0614fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?65zaHXMGqRSLN6tqo7BYSV0K2NAOLXJNneLFOnLBmcSoRDv9+s6PGs4nKOeU?=
 =?us-ascii?Q?vdgys0DsKGADd8ebmavSktgiQ8NMYrD69/E7BDdV+j0NvyUUnk4vAWPGUgNi?=
 =?us-ascii?Q?HZg8OYKROQ96ty39WM2pxPu6xmqFK4gB2LK+qJn/NzHBPpJZ1xqyU+3m6hiF?=
 =?us-ascii?Q?WaACyPCjyFRjWNFUa2BptoEVDI0deJ+3s/nr8Od4oo5W1v5bfgV13BCjMai1?=
 =?us-ascii?Q?PXx7aVALg5qhECMXECM//G9k5zz3U03jD3BEeDB7BOy3mq4t/kHpC22sogEk?=
 =?us-ascii?Q?lnPS0m7VLZthmuj8Bo15aT747xkEDuCcVKS6DMVW89GiDIw+Q+Ds0EES/DIM?=
 =?us-ascii?Q?vY1VMoQH8dPBT/LbrNi4JOzpKXXN7VXjvNjUd4Juid2Tq3SdiieN+MkjetPK?=
 =?us-ascii?Q?b2jr2NVa/x3USqZtLDyCxWqgw2K/axrBIFIat3NH8epeFaapQTou7SdzU1kb?=
 =?us-ascii?Q?401yDBaqwjZxmEMqyxfdYCxnIJvhDb1TIQTzGEh/Ah2h/qI939NKrWpjbp8d?=
 =?us-ascii?Q?1QrYtDMn6RnfNBadQqgDyyAlFTcLk6q2v3rrey/qkuAmkzoLWLGGG6MKct1O?=
 =?us-ascii?Q?BR7mvVe/wQZkZzvBfPKpFYpM6BB5IlkFGeZgwu+LV4fUsfq0FtazAVmbcE9n?=
 =?us-ascii?Q?NVliKe2BWqEAtZcSzkWoROPiPItPza8V9oxpmswIdgvM2IwBplPDD1f4uNHY?=
 =?us-ascii?Q?IGYqIsNmaoeD1XJsER8HXUkoqPtAYECiRkTMdA86l4E2aKdrA4DWt9GMrlQ+?=
 =?us-ascii?Q?QR6p25ickCynTEXWHe/NCAXnYPvoyX82/Z+HSLkvaf9eNpY8i3OGzSLWpLrZ?=
 =?us-ascii?Q?aUZ5zKTsgFysRxBAiONREIS45I6Y6Gsg6LO6f6W//tIKlc7TcJTjsmFUZW2w?=
 =?us-ascii?Q?63tfXw9NFb9ookMb2t2dtWJD5H0Ce6cxUcc+CxpwduwXc70tr7evESEAzLVH?=
 =?us-ascii?Q?mXNdZ7NcpUkGOvUglSlA+jAjg4QraDT5BIcGOEXKuQJuNAqsgDS8z8oyj/xI?=
 =?us-ascii?Q?ZFjRHn7xVOBvC14/ALSslWUd6+kExBFaQFiZQzJGspPG/dQ4c4anYqSR6X+4?=
 =?us-ascii?Q?Cawh0S6T/IRy3cuXvTURLLDw+G+TO4PSgBa5xyzHnsSqoerzexXFkiAFiDqu?=
 =?us-ascii?Q?keNecetu3UjkHVUNkfEy0f3pQuyg3iNZ26rtfglFsrmLh77LFw2fofeTLNXh?=
 =?us-ascii?Q?W/V36BwlXZvA3ienbp1uIQTmHNhGq7BUhFIqZNkkwO0Jx2QqOrsvee2MHDdx?=
 =?us-ascii?Q?9xsze5Yltxve8zj1KI/3A1mEEKBYwJj7d8qvpAjkebJOEdEKrZ+pI0UrtX20?=
 =?us-ascii?Q?ojRTzKQqla6dGcgsdUy/mQLmLbNdZY1N6RZZFxg9yHhzhKrKXfcacCOHmsTO?=
 =?us-ascii?Q?+tM+XCiOgxhx829B82vGWkLp3bbN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4aMkr6RF0Ck3zmHEZ012c+yd+iS5dw9oFOxK+JcSZ81pyrfBoFprUgpjj4Xj?=
 =?us-ascii?Q?MdgW2IVCFKTaTDtFwm3SoIqp5YC/SMq0pE7vGkb6qJ6lkvCTDYj0KJ+MximA?=
 =?us-ascii?Q?KycAa/K0BueSD/WSMcDs+1UvXA9/w00mkYgqvrwOdTbEyqy/xVcPsqGL2ctg?=
 =?us-ascii?Q?37MgMGqIHUJAjjdfSHNe8cFaRZXO8hKd+LX7H3+TnOy28QOAYE6dExy8MybC?=
 =?us-ascii?Q?1UXt2z7WnCZkQyUi1Wcs4DoU+q/o515C+g8GQIIYsL0PPcmW7q/w/DORq87B?=
 =?us-ascii?Q?FCFi3h5IZ7sTbc3N6l6ayjvwnNZpjRj6+NwfndqTJSZjnFO3cGEbmv8R4+89?=
 =?us-ascii?Q?o8s1XEG05qoU/DREib5p0c7LzWcJCdELalBGmUQnr6l6gdqC/MmKRQ4F96Lf?=
 =?us-ascii?Q?TfWDnYL0DqBAG+Pj9M1qS1wpvPjqCzpktWft9/Ze+37+u2r42qv+3rKW5CYg?=
 =?us-ascii?Q?FaQHhdGeIMThdO9MWv97zmLIOkyCEWX+4a6q5BgxDqiUbuzgqsMmU8kH5BiU?=
 =?us-ascii?Q?n6oRfsraDyNVcrHGKwlr7mC/IRH5UZzg/QZztrYa67PAKbi7XYz13X896sXR?=
 =?us-ascii?Q?Akxm8r/P01qABwfncP2MyFqbC5WeJhr8COrJI/YgiG/swHHseVdUwQSwuTH9?=
 =?us-ascii?Q?+SCMwmqyxPUiAKkvYnwQh8OdqbfoabAUIl6imHTMs/uHP9OHw44XSmVKgIsm?=
 =?us-ascii?Q?FoOmHunN5u8gFAL9m09UuQxFqXBmTGpf+psNErZBoduZrH17ljzEC5Dfcn4w?=
 =?us-ascii?Q?UqTFIxzM0LKI3Lj2AELSXMePdUpgUnsa1ULbXdlwYES8l4A3/XsxHwNTXv/z?=
 =?us-ascii?Q?+3HToUFTAVR4z65QA/KucpG40ZmTPlwEw2jEN6JumvzXVTbMMl32GxW2nGtS?=
 =?us-ascii?Q?BJwHmc7wo+RJIlPOR3RM/3yYW1phVjM8IGQsqR5bMAYAMiy70T/CHhcUm6Ek?=
 =?us-ascii?Q?Lwz+ZiiPanMToHMsijEd30eEyxbLH5aBVOGSAiXrOGBQ9dHiiR2SNqv7sp5V?=
 =?us-ascii?Q?Sjk1R7ClCXSwj5DKuVw0DJq1eUf8SCzah5VLBWDURqSmC20g5reeAbcWoKlw?=
 =?us-ascii?Q?ImXC7/HiP89NbscVEclh4WQSvQXk4gfwyTczURQcjhihtdMvKDFWqtXGpDIM?=
 =?us-ascii?Q?bPExxeYWF2fb51gR4CnL21fI06fLn2Nm8ZO3ytbjNOw5u+mMn6IBviuZ0PSd?=
 =?us-ascii?Q?lFGXweoNCVpb7j75r1HEgkbTEsXVW41nDBUjWU1JqZ9I+JgFfSG7CN2lBAQO?=
 =?us-ascii?Q?R5/MWHHY+jiBenfEEqpaHSLe59QM7gtD2atQmgtUAc1oOfch/wUtNXZMHSi1?=
 =?us-ascii?Q?iIvTMxW9Ljy9B0ePtdhiqv5FgeQgL4TZyXxhA0LfKdARx+/hKXaGg9zDLnJe?=
 =?us-ascii?Q?VqTvGUvRIlGPx4JEHdTrT25JIowNQ8bt2GEb8YlA/vOO/fIzr0ygvpAWwG4W?=
 =?us-ascii?Q?f4y0sgoXBnVjTBlvNlQEPmnp0p2CSDsKL3txtq1OX/4X9rusjk2p1376xHry?=
 =?us-ascii?Q?ynQoV7BJ6Uxu6Ipjv6dyrqMDyaEJNtQ/yjk3F+0JuOwUERiXRqwaaj+wZYQV?=
 =?us-ascii?Q?dFNXe2WkgG4Mt8AYkUklGfwQ4YqZcI3EJSdaj9FLTK8++vz1rs+cyT7zCaRr?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d5e5a1-4d36-4707-da95-08dd5c0614fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 16:52:15.0514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aERtaej8JiRkdxeh2f48jRBvRUydcrnvVUYJj9D4NDb3pZMYMC7tZ3088ijqIkhLqTor6m4yIT0fORDvP3qv1sCbr+iiNX0WJlhHy4i0RUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7777
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

On Wed, Mar 05, 2025 at 08:38:09AM -0800, Andre Muezerie wrote:
> __builtin_add_overflow is gcc specific. It should be replaced with
> a portable version that can also be used with other compilers.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  drivers/net/intel/ice/base/ice_nvm.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/base/ice_nvm.c b/drivers/net/intel/ice/base/ice_nvm.c
> index 56c6c96a95..1002a6b59f 100644
> --- a/drivers/net/intel/ice/base/ice_nvm.c
> +++ b/drivers/net/intel/ice/base/ice_nvm.c
> @@ -3,6 +3,7 @@
>   */
>  
>  #include "ice_common.h"
> +#include <rte_math.h>
>  
>  #define GL_MNG_DEF_DEVID 0x000B611C
>  
> @@ -469,8 +470,6 @@ int ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data)
>  	return status;
>  }
>  
> -#define check_add_overflow __builtin_add_overflow
> -

Rather than modifying the base code, can you instead add a #define to the
osdep.h file in the base directory to alias the new function to
__builtin_add_overflow for MSVC. The other files (other than osdep.h) in
the base directory, come from a common/shared source that is not DPDK
specific, so we try to avoid modifying them where possible.

/Bruce
