Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F373C28B28
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 09:09:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FFE840EAB;
	Thu, 13 Mar 2025 10:09:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 41C6540E49
 for <dev@dpdk.org>; Thu, 13 Mar 2025 10:09:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741856997; x=1773392997;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jzN+Ts5O1lhwYIQNuBNOjgEIeQShjuCawbJIHorSVhg=;
 b=C5CC7AURXBDCwRuVSL0X4q0bPVnrhEjs8tuTiO4PM1xeES4D1bsX0KAt
 vdgdIL6u1QOF9dWFruJAQJiRoSSr2VuwA2N5sN0s6e2bwNI/gGeb5lYMe
 94eMvDuN/WO15EHRRd1+/UMtg3D9i4sqjAA7UOGmgw5YgD6M4VCF5Npaf
 3vSVGPzNKFF/rArxh++stW47U2Ajni6gbqFU195e/Vp+DnLBfbJOeguNW
 27qkg64GuCQdsbI3ljnG5HFcfTUzMfd6oNoxhXM/AAeKpOUZiwdOyxLp8
 oif/JYmQ2khGuvKQfTeCtG49S8c7K2LDJCK5TKSl7cix5mzAYcOuAgzz8 Q==;
X-CSE-ConnectionGUID: XjZ+HEbqRM+guJ/MlHlmig==
X-CSE-MsgGUID: Gh13a9FaQ3y6OA5yuOzQCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="60505250"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; d="scan'208";a="60505250"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 02:09:55 -0700
X-CSE-ConnectionGUID: /iXewWIUS9+3/E82XVvsKQ==
X-CSE-MsgGUID: eyoK2L57SAWLpY6+3vDNvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; d="scan'208";a="120695306"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 02:09:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 02:09:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 02:09:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 02:09:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s07dk14fYRdPKdiqFfmo3725BFIuyNkfBsrkNFlyk/MqxtMRwrVaRzTcRQv/daDTlbQL8invt8MVM8WKgSzzOdNlJ6h8ZVGLkxAYTARScbxAAA3/+tYGAzvWIWH4jbp8oIZ7b0fCtlw0RB5RbL8v18/OU8XF9uQNvl/96TPpG5sc821Soe89dMni735u0mJ5l33sw1vzuklVDqBQN0Eu3JAdz8yFDEaFVcDAzVmxbA/SmAO0RmrMohADfj9p91Kxnr9m+JicHRcYT1k9HhAUQxhuQTMWAhGBp7j9qPSLsD4NOH43HxBkSY5KgXDWAdLK0sPiRq2EJZfHpFqjSteLvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBewCM2MxCF6UTcMcXreeoUn6XWWD7swJ+1CtPW02Qs=;
 b=IlqYxv+ODbf4fP+NIrdsLhZOPmFuOajDIr/iWEOiLHWmk6aqOnwjmIrZz91AHE4ctBfRmp+XT9H6A0veZJ6H8rMSiar9+cx5tv8fRs1X9Rzrrjfpeac1knp0Tfy6s/x8P/vlRlkDmowiO+ZYZ/j91QFZ85bLFfwPHpFEmnUbSnVbwDwb9u7ejjQ16MYQI+NyfA2izSr/Y5wpi5bVnMuzy8gK59sj0SpaVP8W63HItU6pothI9LOm793NknsrrabGkB+v7TaTpn1d1Bo9huQyu0YcxOfQ3GySpp4ff9ug3HWosmi8imMWBMlDK9nmT1vPmOYejhB/GfjPUjx/vsk7Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7315.namprd11.prod.outlook.com (2603:10b6:930:9e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 09:09:52 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 09:09:52 +0000
Date: Thu, 13 Mar 2025 09:09:48 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, <sameh.gobriel@intel.com>, <vladimir.medvedkin@intel.com>, 
 <yipeng1.wang@intel.com>
Subject: Re: [PATCH v3 1/3] eal: add function rte_size_to_str
Message-ID: <Z9Kg3C-L22fTKebl@bricha3-mobl1.ger.corp.intel.com>
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
 <1741807714-26748-1-git-send-email-andremue@linux.microsoft.com>
 <1741807714-26748-2-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1741807714-26748-2-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DBBPR09CA0007.eurprd09.prod.outlook.com
 (2603:10a6:10:c0::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: ca22d30a-cc7f-4f1a-c11c-08dd620ed048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VPfmyOO+7G8VbJucSlQ9WRju9cs//HbMULYtmk7SrRxvb+ZmA2odcUjq+0rh?=
 =?us-ascii?Q?vLkwwvFUCCdUWFflARteuUZq+o2fJQULaMkNvf0R08QiW6tvpxMc/CTo955k?=
 =?us-ascii?Q?lRb9n94h2NRbRWGILLOXvC2/7oP8tU1JjYBEdBhE6FLvFRBQvXNknj5+nd43?=
 =?us-ascii?Q?6RbTBqUF85MGZy1RhbOkYAIey+WVJ6TTrWNyUOHK1FUlUd8U416jpzi6aQl7?=
 =?us-ascii?Q?UMDmXMiiXaAAOmFS1x919neBvJqT+2ene8E8/T1JVtq2bK5ad+tkcDF90vN0?=
 =?us-ascii?Q?CLNZCsy4U2vxIPJEa3SA768GfpFwXYg4UQQiRkS8rLuSPKN45FBXW3b/6SKe?=
 =?us-ascii?Q?PYbz8i0AWtomNOg0FmZBSbRGxr1Cp8dMGtX3OUwc7a8yQOE4nOms5fI2GK7b?=
 =?us-ascii?Q?rZLvKccC4wjxbHbwVQl17QwV+imKspudVUQgVeKpA1KClElPHnKJIO6mukjF?=
 =?us-ascii?Q?cwUsVvz/oj+v4tGP9s9R1oyhl15s+yv96YYNcVNcI+qWZaT6N962KDbdpfy2?=
 =?us-ascii?Q?LKLsjZ53i8Y+quviObjXanjjOPT74caJC2zypwhnsozSWQwXjUbSdPEMlnt0?=
 =?us-ascii?Q?CPBDNkNmdkeUgxWHe9kKRvA6f2cjSXPNxArZ+RN5VANjLyPzVymwbVYrti4C?=
 =?us-ascii?Q?fggdE0z2ZNq7jrx/TG1X+do1j3cUUSmINvwU8hujSpgUA0tdBVN/3ok4BM/z?=
 =?us-ascii?Q?gVKrNs74QVSfcVGubMIuDO9qxBp89V3OGN+gOHRkdTWyfj2RaAvp+Dc350nV?=
 =?us-ascii?Q?sMpwdAktdJlN5YuZtjC3sYVPCxESahVlFmB1fcR6xGcHAfrb5j257r9bnp9e?=
 =?us-ascii?Q?6xGH11ORbOjJwZ/md0ee3Z+GXBuWYwu4vYlBRcyD3sUxH9JkkkvTebJ2VD5z?=
 =?us-ascii?Q?nZlCGhOeKCbN7acg5PyPtEqRq5ZteqRmRCUdYann3HnGK10Nv2q5ZA1M/gOF?=
 =?us-ascii?Q?x2IXUwz8QM1iIbbf3yNQ6oTnjlx6pdAO2H7xCC7xKUYvnDpMfjpNHDDeXDDe?=
 =?us-ascii?Q?UDpxvJFIucmfqLTwsnUr1xHUwR9d+gNFFwzzT83fYt7Gu0LzXOyhCS9DEWzg?=
 =?us-ascii?Q?StIzjGNdPvF8hNfb1NEW9UMRbhUudo6XlN4obDsJEfI4NDHF4PzqKiS+fNQu?=
 =?us-ascii?Q?6ve70g6GpJfe9jWqFvuI3XxnJjSv+95czaQ7l+XY91kxVVV4m1J/aGplVZdI?=
 =?us-ascii?Q?j/KbOC9uObPT/TBHei6JlLGBpQMCIzTcTB19K1O32a3UpXMrk8gWCyiXoZDO?=
 =?us-ascii?Q?s/ctNqBy8C68DkTN/QGSCj35LWwmTXkkDDytc6zsHjW4993whkYir8RI7174?=
 =?us-ascii?Q?3Tljc6jcoOHlhYD/PHrAs/cUO80wDBBQJ+1QlZcx1MB21h/zE2WehSdaOyhl?=
 =?us-ascii?Q?m0LZsxHySViREoEJAysbX2SusBnO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?90jXOHX0Fu6ENcLz+PrXBQdeZEpA+AisPDH+Xa+s4i81qjW1P+ZZauqa6f8J?=
 =?us-ascii?Q?9y7wYy3usHrIEb+mPgKWiI/Ty58TfUsLONXBjIwlNFf6THOj0XOf9c4nKcC7?=
 =?us-ascii?Q?WwUsgkZ+iEuUo5V4ooGGkDxTQh0vwDyZNPRver1l27YEmXJG+v3akhuoR0xE?=
 =?us-ascii?Q?9olOqd9f5tq98aL7GjWuZUIoq9pYMOlq/IJraUMiO6hfOMQ88fj6ELJEDShs?=
 =?us-ascii?Q?DfjQIlvLXKl53X8zHp+B7dAH+H0XeuETrmwM0CdqkheP8Nw1u7zKvBSATFnW?=
 =?us-ascii?Q?uALGCZwqKRENc+X0GOGIrlYlVDkM8WFbh+alveQi6xaUL/FzRrYETUAlnQYQ?=
 =?us-ascii?Q?MXKcHPOoHUuaDjtg/+0vrp3HlgyNp0eGircw2msnYsfEf9DgyHLiWl5cUZWm?=
 =?us-ascii?Q?BMq8DF0717DvA7TdXb19pVc4rpy/K+J6/oCjqzakzcdZiS36BA26ncAjMVbO?=
 =?us-ascii?Q?bqBIiNGi4SuJu7eeu672TFCBkBs2szi/80fw0y1KI9hiyPAXfiFn/uFsql51?=
 =?us-ascii?Q?qsp8/20ceUv7DBP9Ejepp/g70mi7G1E+nqQP1Xk3iN33ehLE4zr3sFzRmQoa?=
 =?us-ascii?Q?KNEWRpINkVjD7OwFNBulbRN+nl0qDbreE7ygWbcDL5d2tDDCRTbzj4CYFmRX?=
 =?us-ascii?Q?0z4DcoEZzGYR1+kJ8Pd/DzdCmTepKz0lV0vGA8NkyArlvnF+rlfnMhhn+/0/?=
 =?us-ascii?Q?ZF6zRQGs4+i7Flbk5dpTuZ7r3FAUhaQxO7HdCYtVs0Bkr+jBCqVHMtRQiewr?=
 =?us-ascii?Q?4UxHblw6e6o3FgixSDQCytfXvagsB5fUxTbcqU0ffg9zsa6qIbdMqlj96Ln4?=
 =?us-ascii?Q?LuWY1n4lIZqW5ImQqkoiN377Pdhog5tyAzOphMeaifMwfe7HOmVKHEeNO6xG?=
 =?us-ascii?Q?vBUePip8z3nFJmwG4Pro+F6CDSh9izNjJAarVKgAJhNhZ4fCfEEe8R/JlkuY?=
 =?us-ascii?Q?shVp/rEZ5Shxov8Hlz3hrM6ljs1PPWHDUpSiChB/NEWzseaRLca8007TJ0nc?=
 =?us-ascii?Q?ZzO8C6sUyAtYfO9ucTUBz8t8Ot/tHtXApyAfEvGEzrfaBtjE9yFvCtgqqMkv?=
 =?us-ascii?Q?twJIV4X9dCZroPRAax6FJXfcILbARma8r253PesbqzPDOw/7R+wkaiOsHJ6a?=
 =?us-ascii?Q?1Iu/WxkpCiwXjCHWcug667lZdbSveddT4qhKMtTbsCAz6v7TICn7Vs5cs6RW?=
 =?us-ascii?Q?vovdsM837T9+CZzP4xZkNq81tcfu/9K/OHclFgZc3OLLzpeNe8lXgJRP1Eau?=
 =?us-ascii?Q?i+mvwF+jWOcz45ofqkTA8X59kh7rqzladIXb/6CNzOB6/Dl2e5saToIGRtux?=
 =?us-ascii?Q?54ENBvZPOzTUyUi1b3TU3Em6FcUhzSrLet8B/gcvfrqiWGH+w4URF2iq476w?=
 =?us-ascii?Q?MUaKNTNy+TRxg8m6JZYFELAoAFj4RUM6KlGb7EwSY2qCk3F60Xy68WzAKtsH?=
 =?us-ascii?Q?HMAm03z8pMYPDcojMb0nlEX5QzdwVMt0czuTBM9eO2XPzVx7RqHNV8x5XlQC?=
 =?us-ascii?Q?tjW6Y752S7mAC4+55XifoMI83CPvOgxQ8dNf4+uXc4DTZxEQj66iADw+bFBx?=
 =?us-ascii?Q?dJUDlWl1rMRwhkadL8dGEFnvYzfX4fECVXKtxWQVGh3M8CyCuyW0WNGgCRp8?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca22d30a-cc7f-4f1a-c11c-08dd620ed048
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 09:09:52.2403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUZ9F6luX8KJgP4JRrJBiNwi7UCDHNCW3KvoYQH/5Jb+Qh/aqJahzRNGtN8OtVdLbLubjgRLCQKuvhIw2c/4o+h+ugqsXiYu/aeitgMDC5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7315
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

On Wed, Mar 12, 2025 at 12:28:32PM -0700, Andre Muezerie wrote:
> It's common to use %' in the printf format specifier to make large numbers
> more easily readable by having the thousands grouped. However, this
> grouping does not work on Windows. Therefore, a function is needed to make
> uint64_t numbers more easily readable. There are at least two tests that
> can benefit from this new function.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---

Thanks Andre, comments inline below.

/Bruce

>  lib/eal/common/eal_common_string_fns.c | 44 ++++++++++++++++++++++++++
>  lib/eal/include/rte_common.h           | 31 ++++++++++++++++++
>  lib/eal/version.map                    |  3 ++
>  3 files changed, 78 insertions(+)
> 
> diff --git a/lib/eal/common/eal_common_string_fns.c b/lib/eal/common/eal_common_string_fns.c
> index 9ca2045b18..4cc7f35652 100644
> --- a/lib/eal/common/eal_common_string_fns.c
> +++ b/lib/eal/common/eal_common_string_fns.c
> @@ -4,6 +4,7 @@
>  
>  #include <ctype.h>
>  #include <errno.h>
> +#include <inttypes.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  
> @@ -87,6 +88,12 @@ rte_str_to_size(const char *str)
>  		endptr++; /* allow 1 space gap */
>  
>  	switch (*endptr) {
> +	case 'E': case 'e':
> +		size *= 1024; /* fall-through */
> +	case 'P': case 'p':
> +		size *= 1024; /* fall-through */
> +	case 'T': case 't':
> +		size *= 1024; /* fall-through */
>  	case 'G': case 'g':
>  		size *= 1024; /* fall-through */
>  	case 'M': case 'm':
> @@ -98,3 +105,40 @@ rte_str_to_size(const char *str)
>  	}
>  	return size;
>  }
> +
> +int
> +rte_size_to_str(char *buf, int buf_size,
> +		uint64_t count, bool use_iec)

Minor nit, I don't think you should need to wrap this, we can have lines up
to 100 chars long.

> +{
> +	const char *prefix = "kMGTPE";

Why is "k" in lower case compared to the others all in upper-case?
Also, these are suffixes not prefixes. :-)

> +	const unsigned int base = use_iec ? 1024 : 1000;
> +	uint64_t powi = 1;
> +	uint16_t powj = 1;
> +	uint8_t precision = 2;
> +
> +	if (count < base)
> +		return snprintf(buf, buf_size, "%"PRIu64" ", count);
> +
> +	/* increase value by a factor of 1000/1024 and store
> +	 * if result is something a human can read
> +	 */
> +	for (;;) {
> +		powi *= base;
> +		if (count / base < powi)

This would seem more logical to me as "count / powi < base" since it would
match the initial check for "count < base" (which is essentially the same
check since powi == 1).

> +			break;
> +
> +		if (!prefix[1])

Since prefix is character string, the comparison should be against '\0',
according to DPDK coding style. The "!" should only be used on bool values.
So "if (prefix[1] == '\0')" or "if (*(prefix + 1) == '\0')".

> +			break;
> +		++prefix;
> +	}
> +
> +	/* try to guess a good number of digits for precision */
> +	for (; precision > 0; precision--) {
> +		powj *= 10;
> +		if (count / powi < powj)
> +			break;
> +	}
> +
> +	return snprintf(buf, buf_size, "%.*f %c%s", precision,
> +			(double)count / powi, *prefix, use_iec ? "i" : "");
> +}
> diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
> index 386f11ae40..781c56adcd 100644
> --- a/lib/eal/include/rte_common.h
> +++ b/lib/eal/include/rte_common.h
> @@ -14,9 +14,11 @@
>  
>  #include <assert.h>
>  #include <limits.h>
> +#include <stdbool.h>
>  #include <stdint.h>
>  #include <stdalign.h>
>  
> +#include <rte_compat.h>
>  #include <rte_config.h>
>  
>  /* OS specific include */
> @@ -919,6 +921,35 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
>  uint64_t
>  rte_str_to_size(const char *str);
>  
> +/**
> + * Converts the uint64_t value provided to a human-readable string.
> + * It null-terminates the string, truncating the data if needed.
> + *
> + * Sample outputs with "use_iec" disabled and enabled:
> + * 0 : "0 ", "0 "
> + * 700 : "700 ", "700 "
> + * 1000 : "1.00 k", "1000 "
> + * 1024 : "1.02 k", "1.00 ki"
> + * 21474836480 : "21.5 G", "20.0 Gi"
> + * 109951162777600 : "110 T", "100 Ti"
> + *

I would omit the space before the suffixes in the output. As well as
looking better to me, it also solves the issue of the non-suffixed numbers
having a trailing space.

> + * @param buf
> + *     Buffer to write the string to.
> + * @param buf_size
> + *     Size of the buffer.
> + * @param count
> + *     Number to convert.
> + * @param use_iec
> + *     If true, use IEC units (1024-based), otherwise use SI units (1000-based).
> + * @return
> + *     Number of characters written (not including the null-terminator),
> + *     or that would have been required when the buffer is too small.
> + */
> +__rte_experimental
> +int
> +rte_size_to_str(char *buf, int buf_size,
> +		uint64_t count, bool use_iec);

Again, no need to wrap.

> +
>  /**
>   * Function to terminate the application immediately, printing an error
>   * message and returning the exit_code back to the shell.
> diff --git a/lib/eal/version.map b/lib/eal/version.map
> index a20c713eb1..01b6a7c190 100644
> --- a/lib/eal/version.map
> +++ b/lib/eal/version.map
> @@ -398,6 +398,9 @@ EXPERIMENTAL {
>  	# added in 24.11
>  	rte_bitset_to_str;
>  	rte_lcore_var_alloc;
> +
> +	# added in 25.07
> +	rte_size_to_str;
>  };
>  
>  INTERNAL {
> -- 
> 2.48.1.vfs.0.1
> 
