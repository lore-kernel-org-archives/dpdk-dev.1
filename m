Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F192AC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 10:42:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F0FD40EE3;
	Thu, 13 Mar 2025 11:42:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id CC67540E49
 for <dev@dpdk.org>; Thu, 13 Mar 2025 11:42:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741862550; x=1773398550;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=JDyMZsUyXFHtBZR+7gN4Wn6QskP9+hkglcA4rxXmG2Y=;
 b=EtgvZo+QSjeJtrr5XQOpLwGeqeQ7N2FM1Do4/YRMCof379uDVnvmwN+p
 ZA65SUxaBiKo6cEhNiQJDGaOsfwl8vzZRCxUyL5wwNKItuqDbodd3aQoP
 npENOhBl9sf/R5X1bAXPLSXABAv4DIQOowKZRclRmGwOg3jVRgHwWqZOY
 pGyVva82fXLX8LEVKQtz21qhF9VlmhBPxSy1QJ3hWNmWX5k34Ko7P2D/U
 Voidd0YLTMrhsDkHnNKlkJWVJTo4g6RKcupWgnMMHd7RkzWW3nAlTHfcp
 J+o0+AFdqKz7eNqdmQ0AYF0UN9zmQ1KLJTj8wyuL1oGAnTddGs+NegkCh w==;
X-CSE-ConnectionGUID: K4vdDBpkSdGopBUwAPXXRg==
X-CSE-MsgGUID: jUqKxL+/Ta+UjnRsJGGnaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="60513578"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; d="scan'208";a="60513578"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 03:42:29 -0700
X-CSE-ConnectionGUID: HsbGOFJdS8uCazxRyapYkA==
X-CSE-MsgGUID: pRSu8A9KTZe+N5HU5kvqSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; d="scan'208";a="125987396"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Mar 2025 03:42:29 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Mar 2025 03:42:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Mar 2025 03:42:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 03:42:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1nXfNoKNmNqbOe78EDqcqarYMswQjgdVlwxQTD/cmJHOEyLGVJPh39scUIc96gW8cUq8YF63vOXyu8Dlawtyqez9w0Kmmt56Si4+GOwgtFp9l4cbtlIoCIRAIHlfM+OT3fb6yxVqy7rjgPbH/8Yl9mTHI/1qSsR6+dQlK4ek7hSan5wenNVBeye27XLUz0ZlG6o7SnTB0xYDGb3C8EvlicF3cZ1Fz7cDFEVzNAm5WNGZMWKL2PRtgjf7u4rfAwW1cyq3poxJZtiv5ejliEKWJDNhlnz/RWjS1pD3TwyXnpRTmKbnqz8ypOtI34EdM0qwxMcaXP+Ncx4kUV7J1eoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7i8Y1rVmgf9XXiM8nQxB38NGOQFJyavRwBPNF7acvkg=;
 b=YdLzJrdbkSdqqDBUgowcbDfya5OSFBpXcpri8xP1c5TFQ/j8NHQe2B0z5yYU7NPh3bACiyfWmo8QkJQtpr0O48iiAU7YNr/ng6erPmsu1QeHDqQ0yuywKcf90QpThMecU/pz65tJG3wO2942iLlQlYrv9JXNRMnzeF+caUfvgdPGeMNTkqxWSrMHv2I8Qf4ISXX7DbmqoQSwIZAHhTRSVs8aSnpawCzmfymHJfKt74+4uHBgBQvqMnGTTQyQ0vcBRjLaWW9NcqhxBGYe9RsBFjxksO/SZQ32TgHLLtZsvtJTCarzTJ7gunq3z5Cr0S9SnXmxZWusE1JQcRze1ngh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7284.namprd11.prod.outlook.com (2603:10b6:208:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 10:41:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 10:41:58 +0000
Date: Thu, 13 Mar 2025 10:41:53 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, <sameh.gobriel@intel.com>, <vladimir.medvedkin@intel.com>, 
 <yipeng1.wang@intel.com>
Subject: Re: [PATCH v3 1/3] eal: add function rte_size_to_str
Message-ID: <Z9K2cdB-nL9CSXaP@bricha3-mobl1.ger.corp.intel.com>
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
 <1741807714-26748-1-git-send-email-andremue@linux.microsoft.com>
 <1741807714-26748-2-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1741807714-26748-2-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DB8PR06CA0034.eurprd06.prod.outlook.com
 (2603:10a6:10:100::47) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 8534696c-c41f-4a06-63ea-08dd621bae1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yP1tyvA0ZpfD+9n/nxaREyu/MutySZL8MvhHZvVhbwSVsa1FuI5GSC2EKkB3?=
 =?us-ascii?Q?coJNJEwV+FuI8cd9JSKdaHLWH+L7RC+1T4qPxi8F3/bzY9g3GxtJzvRXiowi?=
 =?us-ascii?Q?eVxQsE1qLM2pOOq5g9wyClPLzcEjBprPMMMR9VyHdrhAR2t2bO+6hRtkMMTA?=
 =?us-ascii?Q?ypjVYqXJYJrF9PNIy792WxoGX5ikjwcvOX90GdGRT0t5qAZbt1G2EC9Y0Qxy?=
 =?us-ascii?Q?auCZHUdmeYdTaqSuC4fep4jyhdVwB0zkDtyPVYM+HeQtjUzG9QQeuA5pfDgx?=
 =?us-ascii?Q?dq/1P/B3r3E4g8xvPdTkiUk9l9IlPach6FJr1cGjqbs7x9lpOmA6aYCS2G3O?=
 =?us-ascii?Q?oVXvet2HZAQGtMn6620OZJCDX4Nf1dYzXx/GP0vMcPBRdycsycS0KqHASZxT?=
 =?us-ascii?Q?sqp3WugIQy/Me58LWxsACLW4MstFumKTTcSNixLWVx9Skr2PNwlV+ANFtMSS?=
 =?us-ascii?Q?4zwQhJaHD0AlHrxiGH2dsjzDUUklXpPuhrWvDMgkr4j4s7b/leZRNPGIxM7w?=
 =?us-ascii?Q?gtNpVwI1qLMcrBtp1idmDy1dQcGA7//XKIyMh+ZtMkHoTQMiX+vtXQ4fhjmd?=
 =?us-ascii?Q?7dCIlL8qIap9aroDpTpyWDp16hZ+E59NTTV4UshUsZer4ZL81TO+DgVojsAG?=
 =?us-ascii?Q?3OCT+BysdZf9KaJfKEf9b80rCnMF3e1uOkeaL5SziM6sctyVDnEjE1CeDxhS?=
 =?us-ascii?Q?US13yzofxniWJyd69Z0LSMYpVx6RgXW34yIsLnhsVHqrdgM8NgKJ+smx/wps?=
 =?us-ascii?Q?qIjHuTURxXVddg+fiL5zhsqvdyboXjAreaiCkzNrIezYeJetXuBVsTx5Q/0Z?=
 =?us-ascii?Q?1h98OnJy1LglRCHSd8HKD7UZoLv7K4ClMjJTtFaAe6URJduYqSwLO6j/+1xO?=
 =?us-ascii?Q?09fKHiRpqIblvrmlVwNA3DAGAGrzsniEbR6MzxHIFG5Gd3lA0w65BzJq94fG?=
 =?us-ascii?Q?iwxidmFLk79TcPSt//5Nh3Y4GZD5Zs0CB6HN5FxUHDJSBnsopLjBHKow+Udy?=
 =?us-ascii?Q?aVtM4akXPhonFuVQewk8Cta3ZIf4EXNwgEMKpf1udjyLV/1/TUq6RE/jZSuv?=
 =?us-ascii?Q?yYnJBAI5D2QeWVl6GB761wUyDYb3OIu7S9t1VMXSCXC1Myhpqjgc7cjB5iLU?=
 =?us-ascii?Q?wWUHv7bbnr71GGDfxVFZt2CJYz42JKhPod6ICBWth3wVegADB8oUMTzjSvHc?=
 =?us-ascii?Q?XstSeUQC52iUl3JaupD0QNvlITpHOENAVgw81JNWh/iCl2YOolC30dwfWoks?=
 =?us-ascii?Q?rb7huFHBJrXBTAQODZT/JdnnXUhrUAKkBZBv/sdHKhq2VjA9lRzhtOunsVUJ?=
 =?us-ascii?Q?wxYgeOj1NWJxArKf7fKGkX+rghCkG/XzdGpaGPPdEBuuTBQ/tiib+ziCbR1D?=
 =?us-ascii?Q?Ffig9qT/T+d4XAW/fwUgjUYGPvFo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iMh0vH1Li1wvADXHIUv38K0aQOxpEFNiIHeZhtzYBGREzK5W1B4pHXG+qUcj?=
 =?us-ascii?Q?oZ3FZwPBEEP4Z8jungpzH9eOeieEhtT6FO1FT0fnYZlr2ckRAnEWvARpXI7d?=
 =?us-ascii?Q?V5z6zhNn+O1CWjrXQvjflYnkfmF5yi7Y7ixNfysdK7WsBiv8zihZ5APTkXna?=
 =?us-ascii?Q?AjD7UFv2t8FMcPk4VBMGDhcEi3Ilad5cHP2SNtCeAYkgrsPLDSctsV1nen9r?=
 =?us-ascii?Q?NDJT+5V+rzLqvLG1X2A70uNcXwCvPhKSZxogZV7+kP3e6hof7bxcvvde5rcU?=
 =?us-ascii?Q?fE9x+tt2I2Lpeo/zz6h3YnAc3VhV8dMhkWzyYzJTUmsiAIAXI47Ry4hHH87r?=
 =?us-ascii?Q?rN53irpRwj+d0JMA2WW2DRMV2rn0vIuYcO2jMRI+uQ1I19rEo4KomFX5fSDa?=
 =?us-ascii?Q?KKz7YQjpMfrQERkj1ENhBQx/96GO2bIHfdfJCFCCrH4KjdkHtNNvPuhi7n3U?=
 =?us-ascii?Q?3xe+XbDpSwjvLPkTM0rxn5T6IrSoVK5I7s1ugUlmy2utxIEbptWb4VqHqxyR?=
 =?us-ascii?Q?mxEPD3sEGxxwwLjvKkFZ8OT2RQBYTyWFiq9aMpMOM9l71rUDjXT8KRQ3tGFw?=
 =?us-ascii?Q?NpnHTKe9z/UHTzenHaHPvSASUQ9OIjW9n4wHSgE0JMVI34NuPrepIh5EbMXB?=
 =?us-ascii?Q?XraQ+7kqhoz2hu9mYY7XtLlKBZPBT8b4Lu+gVCiirbmexejDUjrs9h5hNaLf?=
 =?us-ascii?Q?J0/4cA1ITGoba85j4m67ufzqvpeuVcKOlZR5Za9+NMSZGnecVmTUT3NGgwZV?=
 =?us-ascii?Q?+K4cR7I/LfgP5K7INcFk7WkJ6HROpG2UFmdWiFlrmSUHjolBHEmLlg0+Kvwm?=
 =?us-ascii?Q?ESfyCZdKaEOKv03Oa+TGbDHNH9+rWMwrl0/9NWKYyVtV/9mAgPB6B33syYPc?=
 =?us-ascii?Q?R0MGVWWOWJs6vK4FQ8lfW9MccaBm6/QRfL2srr0Jg0LvH40xEMEOM60Rzupg?=
 =?us-ascii?Q?9xDfVUwJDVJc3BGlgBCt19xpao0N+MsbhEdAJdJZkNIjLf/un6UrB3cmJZ0S?=
 =?us-ascii?Q?wP4dQpE+KS6exehYS/z4n3ZTFEAUXmYLCOiGNXbX3gNpP7txnQDFYG+hs1to?=
 =?us-ascii?Q?8XbZgDeUFdUBr+TygZhxoVf0xTOHHWHyu/9piDU1NC1kR1HEX6XQvEKarhyS?=
 =?us-ascii?Q?qQUbxXkzveV3IHsCMI18UfzZGHudSYXCXGlnpHQefi1M+AHoHPM5AUG/dLhF?=
 =?us-ascii?Q?+o6tPKaxBASx4MdEOYQjVRJBBNuzDkwHtEfR10gTWOVPZ+yxgACr86lxowxB?=
 =?us-ascii?Q?LGRZQesQtnW3j+TaXwE2L59ht5mlflEIo2O0iaYHLbWMRFjk1eHMQYOOnNFG?=
 =?us-ascii?Q?ETEwE/TizLQSh6aR6FY9P18rkmo3x8RsQevtRNRMl75r2cDZ6uNDil4rBkPG?=
 =?us-ascii?Q?2NGlJby1shC053vr+KPw8YULcKWnDQd8mF260KYLUowYQW+nEBzh4orwow6H?=
 =?us-ascii?Q?fSTMnV2QeaxpdiArBpFfYR3r/cAY4qkek2Ocgcui60IWnoe7bnfqx3qdbJF5?=
 =?us-ascii?Q?lM61soPx2v3dIu2vRWGcxdsdTtbsn/pOGoVg01VldXiSkgYRgYxB+qYEfSNY?=
 =?us-ascii?Q?abGt+bcUGN0nEjzJdEbx/4K54MmO3g3TMQ96ngppNzepr0Z6tLZMjlvCQq7q?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8534696c-c41f-4a06-63ea-08dd621bae1f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 10:41:58.3305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwUi9aCV9kyacKF/OBu0J6hoFgR21NbZBymXFiUziedlmxJb6TqjqAl+T2/LMTV+eW5CSoqHLcSc8r840XHdRNdumeFZcQCg7CgMmsStGxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7284
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
> +{
> +	const char *prefix = "kMGTPE";
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
> +			break;
> +
> +		if (!prefix[1])
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

Just one further minor query on the API return value.

While this is a good return value for handling error cases, for
convenience I wonder if it might be better to have the function return
"buf" or NULL on error. For basic usage where the buffer is known to be
sufficiently big, that would allow use inline in printfs/logs, rather than
requiring a separate call e.g.:

printf("Value is %sB/s\n", rte_size_to_str(buf, RTE_DIM(buf), value, true));

WDYT?
/Bruce
