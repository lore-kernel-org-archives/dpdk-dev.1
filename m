Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F37FC71155
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 09:22:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A9F242EB2;
	Fri, 20 Jun 2025 11:22:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 28F39400D7;
 Fri, 20 Jun 2025 11:22:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750411324; x=1781947324;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=F2aOGvEpsHnBfYu3f+CIEMohO33lkPNail1frnwOjJA=;
 b=QV7Er07ZTZq8vcefyTKYVtibj+Jk5WUjzDb/OLYOfqYBFlCngvK2EHp2
 l+QDWjG8hbi49pKF+isL3RkbhVS8i4yCnBVy+ipQvIL2+0l5ZD17vKCGY
 lUVzryr6bt5ZHHT6phBPxF4jDdckAh3LuGESIm/fvG0BB0SwTBrkIUX1O
 zn27K8mmJNrdXU+gWajKjBTlPbzkBonylkfkVwLgUtGcSS/KKQsoacvaQ
 k2dStuY64d6Fj2gWek1OZMNwhJ9zRe3JpvwejrpYcSb4M1nJd39Fwhykw
 E+BW+5JqUN5BtumW5+pvzcRljMLKwsZ/BBj4iQgkUEuXNSbRXLimp1LSL g==;
X-CSE-ConnectionGUID: SG0VUUXORq6NmvtVIHbwXw==
X-CSE-MsgGUID: 3cQfD6K9Rzy1oVY99+sM/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52597694"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="52597694"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 02:22:03 -0700
X-CSE-ConnectionGUID: 4kayaTtGRB6JVUkWYBmGZg==
X-CSE-MsgGUID: e0uK0HbDQxmAtBPma+bDHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="150288535"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 02:22:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 02:22:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 02:22:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.83) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 02:22:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dibjdHMXpSzeQG3rER/YsD9DLsaBJuYMRC6vdfWKH5vLumqudaWSuLjUT/uWRT2Gerwf/i10htFQ/r812vpsI9qfyHhOMNkJmE8KHie+4Z+P726pcQUXCm2+B2CTl6JmR81wQJaPUFV9PHB0UWTNnRP3Wkg/AaG3JzRp0sN7wWC+2gp5z9RpVxhewgYEfiFrQ+/f37hIHsXkPOEJaiKGQyjqADoWiTtEQviw2IS6/2szYUw2LPA1XxbQcVCBu1b9njBqBZIf8VRfjiK+O1A3aSlXzYJahnoMvZaF6rvYaExTNN2v4X1UeNYDXbc/WOhEQ65LgWuF57aHgNfnlswG5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geMG3Mh2Z+e3WHVxvSJpPo3SW3jRc5KFwU8BVOq62Nw=;
 b=uTAhQBRWRFFVG2TMfdD6WMyRyn8cXDYRy+AIsANz9a+lXy43M27PuD592c/u5dLqPOStio/zGDcJONk7kAK3jMYE6OLbGOIY3HKAgOYSYjo2WejZTdQWqf8FAEWg+75+8Qx495eABDGEW6T5ye7VpXPkM+YaWC9BSXpXHOvM9/zdp7xRJ3YxB6lCKVPqiu9A9zsnQZBZvgB0FOfG2CYjCoI0scwuXNKwS8kdpmXOvuHwNf48ju8K0VZGGhG1MTwwnKPP2h3t+SfyqRep/w+6mNzDcPWqwNTB5UgS0Lu8uhwi0vbbwytT6OMk0p6OHErWQnaYSQW47RuWyHgxzTFRdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL4PR11MB8799.namprd11.prod.outlook.com (2603:10b6:208:5aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Fri, 20 Jun
 2025 09:21:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.020; Fri, 20 Jun 2025
 09:21:45 +0000
Date: Fri, 20 Jun 2025 10:21:40 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 06/10] cmdline: fix highest bit port list parsing
Message-ID: <aFUoJKk95dFnOy0Y@bricha3-mobl1.ger.corp.intel.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250619071037.37325-7-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250619071037.37325-7-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0237.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL4PR11MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d35823b-e823-469f-6990-08ddafdbe076
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cegbkIf9jTDGSSS4gcxDSVkUskdQ3lc94hZOYt/cL09QyX03e1VZzJCB+MIt?=
 =?us-ascii?Q?iefTyF/CqWsNyET/nRb/ZuYEmt4F5htQqejh0SH2DoUofCOrqiqOGtwN2WRT?=
 =?us-ascii?Q?2ZGwlHeBWgyPAx5JqQnNTZBE0pZpM6SO83geSHRPZBxww+7Y4i+I8123k+4U?=
 =?us-ascii?Q?b0QsutkSVFkNbFN2yuVY2Dj+jk77EkbEaaerNK2ohzkwPIUM9qW8xUGcS7Z7?=
 =?us-ascii?Q?d13v68TZn/AA4tPu0ynfiy+I607sRwV+wjkPhVAVaoLj3OhTKsHqqZ1x1ZpX?=
 =?us-ascii?Q?CZXWzbpWHd0Dh5y3nOtYcpWTeLtTKh1cI/SpuRt8IOJ7ADN3pKeAiYpRAqNy?=
 =?us-ascii?Q?fARK7+vZuXq1QtoMvGP5oOlRBoOhFbIMOLGie+iB5yetUy8OpFRhOAFKnAyR?=
 =?us-ascii?Q?G9a8m93zPF6ypZdouDYT6S/pZWHdvocaQ9qyvOc1aWvEhz6Y/pMW4fFuijZn?=
 =?us-ascii?Q?nj3lq68m+YPCArPtph/wvzwqBHDUkpYaFICu9n8R3i/GsinOAOEfxo0so8E+?=
 =?us-ascii?Q?yDYhaZZy1+ykfYZyY1JNn7/ydSRasXcs10skwbBvqi7DYVcegdlAFhyh0Por?=
 =?us-ascii?Q?xItEW1mJIdvvL0xEis7Ca7X08BxXviwBQRnu6G7xE/5tAgew5FfG61WBn3u9?=
 =?us-ascii?Q?eFi7in2B+2FDb8t9JnyQBp0wki5bLY/Y4H+1vyLYrDHBj9W4SUxONV37ZM4m?=
 =?us-ascii?Q?4icubQzmQEdCY9jDPJnCQ+ckcoV7nswJ3gFsiA7qyV5/5H7a2QiDyDlIbOZV?=
 =?us-ascii?Q?sK0V+BgaPwWPS2l8x/nDY/0/+IHrWquaih+uuH/neATXHIZH7eiK8iY8Rij/?=
 =?us-ascii?Q?+tQLWT23Goiyv29x8Xk8Spsf4CKUvquJPdTYPzMzvkYJfQu68poHABhyuh2/?=
 =?us-ascii?Q?/O71WMkSOsiKTPid9GNV1HfpHkZBlfpypMhImScs3HYVYvxeupQn8glkiuVz?=
 =?us-ascii?Q?qkXsDjIfODlaMhZTbZsA3Ji5L782Dt32hTM8lO4FLpzAcmkTHTKiIpPzjK63?=
 =?us-ascii?Q?8aOfSlGuquQ7U2jS/qvs0tohnUl+5wb+feQVY0rTjmnLSBHB2sHBrauIkQ6U?=
 =?us-ascii?Q?yosjIwD1jdrKrA1P/7rd/GybI+TRfmefHl8pzwl5t8PYrW1ayaONwSKvtime?=
 =?us-ascii?Q?HEUvGam6Z27GWnTXnGvsjo1qAJ7PQc0ppv5B0t9KIrTnPDpoP5qpJfDRNRXr?=
 =?us-ascii?Q?8Efih2OdNtbfnuY+sQrXhMaTEC9yK7DJw1gq6bXsCU2hhn7NDKwtvTjLvl47?=
 =?us-ascii?Q?Q+vwH0K35XQOMt4ljIrU1jMLlD/4C1wk3GTmakOl2UMbCz7MRfS8MeSB60h8?=
 =?us-ascii?Q?8hu0jMQIaIVTLgVIJJ/g4a8BbuLkmNBwB303m8tZYYGL/5I/UyUk5zHbmWLj?=
 =?us-ascii?Q?cqm5urJn1b1PZHwHMTw4RJdLKXWtlPZkfH0V4Pzsj/n7s4/BGuvvMIF8iY+G?=
 =?us-ascii?Q?zRUCU8L1pZM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C+cRN2ECi24JpLaCT/sYPj75T1HIFBWOS0jdIrOBqRN8Q8V7M9m1jZumgV+w?=
 =?us-ascii?Q?Bg5Mj/os3N8oJqZACDbdGRLIk4UfCYraHLgm7+oeoDCqo14eMjDX2EW84jkW?=
 =?us-ascii?Q?awbD+++7U9QYA0Vz0DB0rX/2qG8BRE8FHQI/oAic4doFj6RsMpbiWU9MVOSC?=
 =?us-ascii?Q?ytOblQFcSbIxUG1woKr/NKQs23H+YM5sdmut41NOH4HfJQVmcfNAIZKXzvKe?=
 =?us-ascii?Q?Fm2lcpK9Ifdm3woiMYsqhEUlCrUuxItEnVRLZnRG8slCkjxRxPH3twjaxQG+?=
 =?us-ascii?Q?SrzMVHBtAKq67CKDKMmyacSxopUr+WrOAoCSOy8smEg0dyI2Zf93/iHPp5HV?=
 =?us-ascii?Q?rFOHmvmPlVWqv+sy8xrqPdQUgqjU2TyKMJW33v8laGPXIzbqFwJeDmhc0MuZ?=
 =?us-ascii?Q?ikEJXOFyJNjNfbXdmvJT//JkNFECU4fV+BaAzWdlttCs3ri7EN0aBaxLaxV/?=
 =?us-ascii?Q?cmtEUWw4xx90tyDyPtJtdqR6HgwbhlbJCwLfj0eqK3Ne+iytad3OOCLD3Eqi?=
 =?us-ascii?Q?qe+7nkAnxxV+0iKfJJ6iuQL5JswTNac1PnUvbh3C/OVqBAB3P7kes1rTqBh0?=
 =?us-ascii?Q?KmOtQAoSgNhO9wC0LCy5eM9xep8DKx4NsGmPn13b1J4S0YtyyUHX1trB97p5?=
 =?us-ascii?Q?XXKUHIksSPgYUOfXXcLZduOiGcBoDHbzGfZmxSsOPYEHSn8Vs3LHqeOTOqie?=
 =?us-ascii?Q?Qi0D1A3i+SGldkyE7CPPGXhxIBL7f0rH4p4M1sWhSkcF8ZaxnHLcCaBofLk/?=
 =?us-ascii?Q?e0HpZ1wLJpOGPf7p2+7iByulzEkjx8ZpusEEvlAy1FX1xTYuFExtC08yNTr4?=
 =?us-ascii?Q?hwCU2e6IyL5EfwRieTUVyETgmbqZZe4uA8kqHpWtyDPEPq09HH0J918IJUXg?=
 =?us-ascii?Q?JkagHaisUdeUo4q1n71WRyy/HMocIS0Q5mZWh2G2hX4Mgm+1I3tgdtXbpklu?=
 =?us-ascii?Q?lqxYU710ZIjTAxOLeaj5EtJ2YiXh8/dHCmx9AbfM6RokgYAO6/EffnJTZKgt?=
 =?us-ascii?Q?XO1v7BlYwZdcLXlpMdEGFodaQ+BfCXj1zaPUadie34QuhdvDvY4wBWZUXruB?=
 =?us-ascii?Q?2NH3A4ipzNXD7r72vc5wDWoof8ZH8wOjzNdVfTZTN6Q+W5xQxPGOG/skehb3?=
 =?us-ascii?Q?bYCzUOeNoBpm4eTbH4l72mH48TyScS2tKbCApMLWB2QMkD7FcALRxnsf+FcS?=
 =?us-ascii?Q?AUKMJlRckyutzONUV9AmTctmre7pnBH45LUxyQGAecsRIm2NjKedJQAmluDC?=
 =?us-ascii?Q?zgglbDG6S5oQRwFMFGn5zvWTuCHzM6m9hUqkWKsN/pft7UXrxvP5OK9peX/0?=
 =?us-ascii?Q?I8wGfiM1sV4KXEssBXBCTcxWEDmAXkBy9cKSa96hazR3jW3+y0O6F4sJ4ljW?=
 =?us-ascii?Q?+XESRbt31BBxamg4sHQR92qgdXevFq03tn7ySVlMCwg355Ex0QT9fauengrQ?=
 =?us-ascii?Q?bRXmn6rGds1vbTkwqq9/O0ALpRmz1pFRWX7DD5fnBM4tVapRFEtRm7ugJvLJ?=
 =?us-ascii?Q?v8vtfrj1BxCihb5wZR1hf77FPW1ezEEwMyPlykgd47nJKQ4NNUsu6iGC7Ofs?=
 =?us-ascii?Q?DjakojZiouha19Q7RO0rWLLeDiDTyVIH73+sQj3An2kd9fwAh+LrCtNh1OQs?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d35823b-e823-469f-6990-08ddafdbe076
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 09:21:45.6981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udsSwi6C0LOJtAADnFy2NN0GYF/MM+UrEIsUUinDo8ochOKnk/0UXLD024Mo2k1aQ1t0R7r59tILYhhdJsCVFAsUsqA6s969beXJeA19VII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8799
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

On Thu, Jun 19, 2025 at 09:10:32AM +0200, David Marchand wrote:
> pl->map is a uint32_t.
> 
> Caught by UBSan:
> 
> ../lib/cmdline/cmdline_parse_portlist.c:27:17: runtime error:
> 	left shift of 1 by 31 places cannot be represented in type 'int'
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> 	../lib/cmdline/cmdline_parse_portlist.c:27:17 in
> 
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/cmdline/cmdline_parse_portlist.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/cmdline/cmdline_parse_portlist.c b/lib/cmdline/cmdline_parse_portlist.c
> index 0c07cc02b5..3ef427d32a 100644
> --- a/lib/cmdline/cmdline_parse_portlist.c
> +++ b/lib/cmdline/cmdline_parse_portlist.c
> @@ -11,7 +11,9 @@
>  #include <errno.h>
>  
>  #include <eal_export.h>
> +#include <rte_bitops.h>
>  #include <rte_string_fns.h>
> +
>  #include "cmdline_parse.h"
>  #include "cmdline_parse_portlist.h"
>  
> @@ -27,7 +29,7 @@ static void
>  parse_set_list(cmdline_portlist_t *pl, size_t low, size_t high)
>  {
>  	do {
> -		pl->map |= (1 << low++);
> +		pl->map |= RTE_BIT32(low++);
>  	} while (low <= high);
>  }
>
While this is correct, the use of "++" in a call to a macro sets off some
alarm bells for me!
Can we put the "++" in the while instead, as "++low"?

/Bruce
