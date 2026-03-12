Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B442FED2F3
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 09:15:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4577A40430;
	Thu, 12 Mar 2026 10:15:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 60FB7402E0
 for <dev@dpdk.org>; Thu, 12 Mar 2026 10:15:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773306943; x=1804842943;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4dHbvPucYsUJvWV0ATK8k7rMpmkWF+oRiAWzrYMj6e8=;
 b=FDN5glyf+RB38AD1VBpdajP/pdpqqramz5vEIlYgZoFsNPLgJtOZkmeY
 miYomhjvcyy7B+oMZDIWJZRNdGfZw87eOq4DoG3XyhfsGEqAl6tcsuqkg
 OogagobLjZCgEs1DAI2PBzjsYT6A5hoktTLoRyC71VaZ7urix9RF/qAl7
 qP2qwFejscfry1nhlp+rh8cN+gx3df8GR1VJMaZaLTPNFg4tpfh3T+vuM
 lsXWhEL2JkXx60J3DNKMaFpj08DVgmdi5Ozrj8vQDJON0LldwOxDg0TL0
 gpq0i2BskXkMYWV8p349+vGv9pxEzGIkEb9JsJGk4ZqugM92rfwaFvlji Q==;
X-CSE-ConnectionGUID: A/CyotR8RBecxNO/xpX5JA==
X-CSE-MsgGUID: rda9T8svTb69VnGA24NNJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74581675"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="74581675"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 02:15:41 -0700
X-CSE-ConnectionGUID: kB8R4wEyQ9eGmAHgPyWwvQ==
X-CSE-MsgGUID: AmskeV6rS6SkcBjrJV6/pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="258661504"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 02:15:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 02:15:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 02:15:39 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 02:15:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZPuy16jXmuOWhoHfPPjgpb3LCd3A+oZjnsuInyp5EypMT84EBf39m+QsBHzHmBaeBz8Bcic9/cdRDvscJJ5/sZmjT9yHvTQjrI6PfcWCs2SKOP92sX8Y4CJH/UvJIrQyrj8EFlovWFX7+pmZpjWF0MjlHrugK5AbdNf3VzksQdM/IAQxKFuzrObg4zzWQGT/kEz7uyBoXOcYFuxg8eaGE+wd0cWF9C9utnnK+oJqHLW2CpmKORliFluy0kktZypzCCQhxLCDGLL/J4t9v/jFmmIbpb6VSG4BS4ZX7LqrFKXq2BD2F7QG8RVyWjgp8YA8pum/bfr4cR6ZJhjo3iaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIXopaM+aAQ5yj9X4XD8sUAHJhcYJjARmAOX9z5lOX4=;
 b=iTXCzqXISpXhBrP1EsVyy1Pe+ARW7DI/EMlL2tRHMc5J4VUzd3n5bWjPPrUSro4eHWs+OUy09wsnu69uHd7GHWiSFXnvX0enoOv/QYYymXiTvKsCve9bQAtWEWwbxTTzW90Nz50YGSNb7bfLZAmyzmrFyQeE/JgMWwbWppZXDYUG/lgMBEWanmUiWQ73zNEAqzFS0TqoOF3lytfBAMFJqYuoOwMEFYSZtIOmEvSlKDX1azLHsMZ5CwH+0IB5ZOTMdKCaPFaNR0bBRC1w/5BncWJnfwpzld9CNfX3Qc2nCVClA10TV+qGVWzqpYNguF1N14poBw9vIrtlU0TVPA2TsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB7549.namprd11.prod.outlook.com (2603:10b6:510:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 09:15:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:15:31 +0000
Date: Thu, 12 Mar 2026 09:15:26 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Rosen Xu <rosen.xu@altera.com>
Subject: Re: [PATCH] raw/ifpga: fix comma warnings
Message-ID: <abKELl_UQ8uLhSTY@bricha3-mobl1.ger.corp.intel.com>
References: <20260312002337.867771-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260312002337.867771-1-stephen@networkplumber.org>
X-ClientProxiedBy: DUZP191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: ce64d215-bd27-40fe-cabe-08de8017e8fc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|7053199007|56012099003;
X-Microsoft-Antispam-Message-Info: m0YpP2xZpkotz+bpB9MXbOdFZLu1pACXgBG03E5LYhrlSjo2q+hbJc1zrM9Pu+wcWcueEaFLst72rRm3IUyjHOJKtjnIS7HeoN/8TRZIFq+U/oBaLDaDD9S3Z7ze52gWXy6R3guHBQOPZyp0J/o9wV+DVhrM3zlaWRye18BekgnnjnATr7gs95bHS65q/fvF/HyBDrLMJh6R8qFlPitxB9o/Cajv9O7dyzk/Yv9MkDEKcEuAqz9dMqcpMU+UuArrMn55/rILPJg/v2UAfTyiOkZ4qaIPPef2AhJjVmed+yJULHLs7sXSl/SgUgBdmWFl80LI/UbpkKSIN9bg0c30xA884DeczudLJpJOAHEkY7YYmnL1INRN+GYKSC/1i/NMUvlshcoKxivaC6UlG+G+yi1FE1bYaacCeFNk0bh8SWpnpV8UD+VnPRV5XPXhiw7x13My3CHL7GURW3iEfBvdWxWvcp/zYOE/OdURvNozayJVgYcjoRgbYVimgQ3/KHaKfv99crVrMulO6kGMUDLgqt3PaSvRgM/QI16kcsdfWANxhyYKnCiF0zEwvKKhbIWKecq6SdbDyxCCswVL8NiRtnbK5tpUrdPBlJIb8KOijQGiMfHoKwvtuj9YAVxqCVAONp3F/heEla7C6Tc+TLBfbga83BiAHkknrWXm/i/AaKnswTbGB6sMzRRQlU4PPSu5IDSXXX/RQo1K4LRyzshkYArpd5dL7dJOeCU9JNWqVFE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(7053199007)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OGC9xs65EJHz+A417poMqhhGGxkXNGSb8Q2Nudx5Drx7g39gTp6u2WcYkhYi?=
 =?us-ascii?Q?X6QfXY6M5io+QRbcmIG/wMT0nCLv0CenyLcGdMzF0SDtfxn20NLLKJDAUG5U?=
 =?us-ascii?Q?s8CE/f7mhnOsMZ2rRUwhjhDMgro98YcAgQ3bLMPv+VCU0FgOu845GJKgVfZl?=
 =?us-ascii?Q?hvefXFKycEFsqVD77EFDrywLHJ1uTAyk/rh3biw1/IuzEGMnAX8W63+9eJj7?=
 =?us-ascii?Q?DzFIVKnUr4MTY5Fu+iZITH8Xy1tB8ifEnEOzoEjAOdHv0LEXIcxs53yuzb5E?=
 =?us-ascii?Q?w/KZsY62TwSYXqfwrSnORYHKHn/pIuNz2Z+1M3ChJBqCs+Ea0/SPOh3SzobY?=
 =?us-ascii?Q?DTCG/uS9GqfTvYtWzrtji9PcE9xXPLTr9HnCQKPe4xFaGx8CekyYFbYBxwxB?=
 =?us-ascii?Q?bZYN9N3lza74mJN4V3Vf/Wkmt7USmo2rd3T0mer21QhuCDktXxgSbXUg1ZYO?=
 =?us-ascii?Q?CCz1DDIDssQO54O9CdZOolqSCD6F7UQt31PftKJ5Q+XJFEOrD2IvtER6uXqj?=
 =?us-ascii?Q?cAXo+HTqNRuoMVHewTcmdNPNnj5a1EO6qD/a+w0RB602WjOzfPLUNmeR3PqH?=
 =?us-ascii?Q?NjJmGEwf29wt2dhPpLL3vWPW79Af8ikHrobeHc7Itp3hRIPvTtxtC3chQlBL?=
 =?us-ascii?Q?UnjLrdmohtSjHjiDmsvSjgu5xHIFfU4OJh9te1RfWkOpjumaEfn94/mQ+bvq?=
 =?us-ascii?Q?/2nt+kdz6a7NzjyVBuxdcNZhE4vCbAVVh52l/QDy0uQ/9gBN8ssm74RdGXzI?=
 =?us-ascii?Q?RWGqXMf3dQSeQL5lzzhu6GVW/e7RJjmN5Akzmm01sHbjVduUYgTg8A7qCbRK?=
 =?us-ascii?Q?9SRQ2pqUuvBvN1QndP5s8HqiUDfIc2hMD9wVrBk0jGjBwHKC7BaxaAHfa3OC?=
 =?us-ascii?Q?jH+icP13HkVv76IxWwtRLE4DZPFTKk8FoWjkZGsFmaifXKMG9fad1cqSisNT?=
 =?us-ascii?Q?dfPgkI0549ydxARj7xCk6GCyB8dHq1z92lqrojFTZ0cvzYorAhQY22RMpggB?=
 =?us-ascii?Q?wu1jH+GXcOicUxVuQtmG615T24PV42nBESj7Nc+efOaLKcl/3CIfkPG9c6yq?=
 =?us-ascii?Q?Wwk3eljvlL2WesCXnWTwRPgIhRRdhQX1UvtqgvbtZS8MK/fJEdq17Cq2vDOL?=
 =?us-ascii?Q?ur1GlsgPIpiqWISQFSKHU3xkz+Afx0rrWNmX56T4grJicEeqsckMYLGLsoeN?=
 =?us-ascii?Q?wNRv8/XOoeqkFq0YwWj668ChL+IUC5P1C62tjoickqjCeLYUD0YSMNIam4fC?=
 =?us-ascii?Q?q0lRHSgDoEM2oj0HDcfsxjsvZwOn1xqATgb4UyGFo7WF+vOBrbA3pbjZhf6Y?=
 =?us-ascii?Q?LBJvuWv38pt0fIWlbRcMD1SYFucVOWV4ICGb1ZKBHkgZiCz5t/cgLLeCrjl9?=
 =?us-ascii?Q?vy57pS0biPAi752i3JQOvAgZQKAQPCb6JzLjVKZYD0KP1SAuWx1Dy1y6aVyP?=
 =?us-ascii?Q?HrYpMgUce+ASEWHCjBnE+3IwhRkKCCoyQoP3122mZPHeLrvRbmr6JqLdIbzM?=
 =?us-ascii?Q?Xeks4bW5rl98BJtCvQlZ77Z/Ids9BnPCJfN/nVKS29fYayrzuh/HXdzm7Fx+?=
 =?us-ascii?Q?QMutS30XsX7wSUmMgRG9TjFGMpVMdtQZym1gYBkqKpV5iM2sbkadksL/AkCW?=
 =?us-ascii?Q?YigL95RmXpqCNe0A6LSHqP1zKRmdl+dMxCZ5BeG/ZjnLSct5576EShf6YAF1?=
 =?us-ascii?Q?Xq8IBI2apGj0v6vodBtwNZ705rLn7WWTGge/bwTAem3Tmf9Cil4qNQj/r3wk?=
 =?us-ascii?Q?a6/trUsyWsHqv2Zq5Vxb10nz8KBhFQw=3D?=
X-Exchange-RoutingPolicyChecked: QXeOlJx7204et9M4Z3n7/PBT5HMEeikNMk/WHXmTF3CVm+80mtNzSl2x2137POTQ2DM4O4CCLel+MStNxXemYqTnmB/RU5aYYsBehL1HeHhc1wB385937JEWMv/6pXNjSqEY3ywUsm+rdlxMRqpXlevdKvxx18/9w1jYP4QdOG3fBiGwFgzwTlZo/YOB1Vq0t/ra+Kcc7bAPHRxCYsjPYGBWRSuH/k2+4Saozj4fWJEH34gl9UuP4B6deavtC0PcpBdVEEGw+2oqpXpGwZRpKHce5pwWkQDxggysFR26j2XfrpvIOH65U8H6M2kJBKswb+5CpT870dr1I/NZngypWw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce64d215-bd27-40fe-cabe-08de8017e8fc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:15:31.6838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFD2cn9Ltcq0gkOluOtDlUFWde3id5ynKP0TXcISFnj49ZpQRYO7z/OYi0nuPI7PR9AEfO6Z1D7+nvZ63pyVz0AC+hbO88ez49tfFqoplh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7549
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

On Wed, Mar 11, 2026 at 05:23:36PM -0700, Stephen Hemminger wrote:
> The driver was open coding TAILQ_FOREACH_SAFE() in a manner
> that triggered warnings. Replace it with the standard one
> from bsd queue.h.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/raw/ifpga/base/ifpga_enumerate.c | 4 +---
>  drivers/raw/ifpga/base/opae_hw_api.h     | 7 +++++++
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/raw/ifpga/base/ifpga_enumerate.c b/drivers/raw/ifpga/base/ifpga_enumerate.c
> index 61eb6601ea..085fb6db40 100644
> --- a/drivers/raw/ifpga/base/ifpga_enumerate.c
> +++ b/drivers/raw/ifpga/base/ifpga_enumerate.c
> @@ -725,9 +725,7 @@ static void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info)
>  		return;
>  
>  	/* remove all device feature lists in the list. */
> -	for (dfl = TAILQ_FIRST(&info->dfls);
> -		dfl && (tmp = TAILQ_NEXT(dfl, node), 1);
> -		dfl = tmp) {
> +	TAILQ_FOREACH_SAFE(dfl, &info->dfls, node, tmp) {
>  		TAILQ_REMOVE(&info->dfls, dfl, node);
>  		opae_free(dfl);
>  	}
> diff --git a/drivers/raw/ifpga/base/opae_hw_api.h b/drivers/raw/ifpga/base/opae_hw_api.h
> index 57750022dd..63cb616731 100644
> --- a/drivers/raw/ifpga/base/opae_hw_api.h
> +++ b/drivers/raw/ifpga/base/opae_hw_api.h
> @@ -10,6 +10,13 @@
>  #include <stdio.h>
>  #include <sys/queue.h>
>  
> +#ifndef TAILQ_FOREACH_SAFE
> +#define	TAILQ_FOREACH_SAFE(var, head, field, tvar)			\
> +	for ((var) = TAILQ_FIRST((head));				\
> +	    (var) && ((tvar) = TAILQ_NEXT((var), field), 1);		\
> +	    (var) = (tvar))
> +#endif
> +

I am curious as to how this is not causing warnings but the original code
is. Have we got builds where we are triggering this macro definition, or is
ever build tested already got the define?
