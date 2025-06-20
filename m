Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2E1C71155
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 09:59:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A8A342EB5;
	Fri, 20 Jun 2025 11:59:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 4BA92400D7;
 Fri, 20 Jun 2025 11:59:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750413565; x=1781949565;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0vHcwBEOrBU2F7LsgNbo20dN1XV+NhgmWrEjtcOTxxQ=;
 b=Wj2DanrjOyniD1b9LujwuQuSgqQfCUv/eeCYwH3uEtnDCgBJ7j4166tV
 P1b17Z3cdGV1z071kBrDMhLdryoF23SjJ2v541y1W2H7zfxXkWJmi/qb1
 +FDvYRVzhnDNQWrGJfpeEE5b4o8IMEoIeyxJVMh+Hi8Ea+Q8ZGDbo/GY4
 Vc9fS3QBWsS+n1LE2+iDWgsTtHQ6IvZQ5j9zuATe+8Gmsq2nivUQiDcAd
 BtsHNwVFE6CK45zJIqTXc/udRJY0xwaIs3alvfqUEreJlHpJ9YeKtgcHa
 fFD66oAI5SyQMOlG81/lGjTz9YiYd0wAIZXDolIpNfWTdKfQ/qJGBJa9J w==;
X-CSE-ConnectionGUID: McZOEogqRguuVsCB5L0/aQ==
X-CSE-MsgGUID: F2LojfoYQxu4bON2LSOG+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63277277"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="63277277"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 02:59:23 -0700
X-CSE-ConnectionGUID: 1/XX89DMQq+W41vSC2Xi8g==
X-CSE-MsgGUID: v47nRuIbT2ORUftjHccgxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="151080529"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 02:59:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 02:59:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 02:59:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.73) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 02:59:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+cziY2XQvKILvbvB0pIjZIklE7v9GVGzyjjiB3jtuypp4fxhhxIZ2lgMSwZmxMU1Ym+yzD5jWe2C3g8aPCCnqTMPplMDUHrU3lLR+CsRsltuHFbsS99QLzZyxQ4ZybU/IkV+mZsffN8otL2rhJRJNDvJwFnJ6/oiplEe1Rqh9ZZx3ejtVYsIxfgXOhpRIBvBGS7VkuVtnG9by6tC/9xTqDZcfkysjTL635wz9IfmeoNnPMFhJImd2W4qUjkFgRTPkAcoWwE+y2r371oMvngaj/IhG+f9v4Xbsty7xtUCs+BooInuVzsKhNb8WBx4YVihV4km444I+JDwwncRJ+7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lr8JyZcNJ7XXV583ToqKTqM5L9o3xiYkgCAQRs4C3Zc=;
 b=YnjW5fnGV01wS945sGyUhfjOyoYldtKGwpAysa0Z56fsScda3WhPKcLifitUFdWeumEzMSvC4IedifNfpsZdprc8MZXahI3jMw7i2z1BMVeX3KesBoV607inD4BYSnRXSeVYxtRTKGNPjc6Ocs70Nf671fQXySJKLnVYvpIB7atkiAyjvK1iB/5FrG0UFAdxfMK3Gth59dpj549FEDCGhy3DFa/fym0sGX2pgCoFDNddrpESSQmNG4qHcVRsHlmooWbhQtVeAe2oroQibJKI7Pa4IcQcDggCjmUdX0fEbRJb7/6JShj+B/t/kJQJ/w9I8FAw6RDmOPzUyetVOPNBkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7523.namprd11.prod.outlook.com (2603:10b6:510:280::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Fri, 20 Jun
 2025 09:58:52 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.020; Fri, 20 Jun 2025
 09:58:52 +0000
Date: Fri, 20 Jun 2025 10:58:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 05/10] cmdline: fix port list parsing
Message-ID: <aFUw1gDuJNuJBnIs@bricha3-mobl1.ger.corp.intel.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250619071037.37325-6-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250619071037.37325-6-david.marchand@redhat.com>
X-ClientProxiedBy: DUZP191CA0052.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5ad3ab-69de-4475-0b48-08ddafe10fb0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Oukq8dHvrAK5KTb9Vw5L6jso9jTdPG9eUglRAUD2GtEZALuSAUaZh31HF0AW?=
 =?us-ascii?Q?o/OfR/EGq+mq4SqoIgbAvZ7sVAngZo1li72almMq+QLIKcllhVTBNyFl4mfZ?=
 =?us-ascii?Q?E5EgRyRgXe1tGMtkdhMI5RRDL+FKU0M8NhBNAyRTh7NTCeau4HxOQsD6V2T1?=
 =?us-ascii?Q?MViVfwqtLPrq4Kbj17DWV2IkBZZNMzcAjWa4aT0gHSNTyA+t9jeWJMhdRbNz?=
 =?us-ascii?Q?Mxo99NCuX4DJkiv34h26eN6hTlvcBxq/9oWc6EiI9GLF6Ql1hCHoF1L1fg8b?=
 =?us-ascii?Q?/qfP8qLQqzmZuH8Y2rNhhZ5bJZZjI3R3fUG/rfyLYLpQEwiHn95s3sNEH1G8?=
 =?us-ascii?Q?peVQxtbovlJLTO9/3uHjYIU1SUKS9lS7uugFJzruJy8AVB6nC+ZItI9MOwej?=
 =?us-ascii?Q?F5JClIU6SWRQ9xOD7MU+bhWdzyL069SDmpaEtd8LvNLZiJhPGIvycSQWetpO?=
 =?us-ascii?Q?oY3RjY162YaFwbUAK3Dx+p3y5aHyKbKN8HeE0TS8hSLYAe2l4h3q48vk+8y+?=
 =?us-ascii?Q?vQRldRhqa3SCU6OpezccqDI4OXqnKNM6l53mLkzRkM+7kIap+7eR8AB0tHkJ?=
 =?us-ascii?Q?uO1zoWOIwdGCNlTkkbtj1pBW1lbY7zaHvYiZqMWJ9SUMgwmlJpJU2y0ovX+v?=
 =?us-ascii?Q?BiUIlnNe8KnTRFEnYlTJv1mweEt9P5oRLNRGtqS4tEGaM0dDtEv5otBGmPqw?=
 =?us-ascii?Q?7eAQY05bOAA/H+HwUp10cAt3PYSd0KUjPO1/rX8di+/fTEUqaepEra6cVNdU?=
 =?us-ascii?Q?YOcvE5k33vrR09YgLj0/fG51quM+JWhBUhw/oXObpXOf0vvJ7C+EgAGFpCAa?=
 =?us-ascii?Q?Fg9P93u1qO8QoErDhWKI77v+aqQMtp+LzxBggSaKW12qgvUuri3JYbqG8LaH?=
 =?us-ascii?Q?0sjoRlPBo0g8q3yZwupV54AUEEVj9/OX9s/10uxBijAB7XxNKj6tk0t2kdkW?=
 =?us-ascii?Q?vkgeA43ozl9y8rcq6FQFFAxljJW60Zxp2ilRt1ZY1RjyBhiMHU2dnrNY+3lG?=
 =?us-ascii?Q?vcbxXzFjFtyENtLOn0yUHRCyitmUN14bxOls1dor/Q2APq7VYbT7OqKxGtsz?=
 =?us-ascii?Q?hUdAcbUUzI40y4Wi4riO/yw7zcCa/u2DfWcmI3AGpSbMs4R6Hioe/ZYVwonL?=
 =?us-ascii?Q?8KnYN2+53qdodeooxf0i9Z9oVJ0Ax+eCuXcHzRzlXWOrj1RV2UFeGBeakhE5?=
 =?us-ascii?Q?E5224eJnbndJWIKVAjpBRzmx6y8esPdVHjg0Oj0JiSeWHaxPKZelvKhj6vKc?=
 =?us-ascii?Q?impjmyN4IIcdZE+diHWACia3fG9lhmuniBmRFXu1Me4//LpLplRH5iSnATHw?=
 =?us-ascii?Q?h+vkW43uLXvStbJHde29ElPGgV5kJ+rV3sIVmdKf9WLFil2dH4qjnr88W0kx?=
 =?us-ascii?Q?y0E/+1y3X0iFYnjIXqshLl26BHgy05sP91Nqe6m7im2LUurNuA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AFzBKqqy4m/niAflKQhAexV6K1UiOJ3MqIu0WeSjpFk2gsk0FubN7x9t+vwh?=
 =?us-ascii?Q?f4Gm7dhfcqnYf3Zo59fdtsr41gxemAAoskeXaPwnqkVKRxBWIMqskXesndsP?=
 =?us-ascii?Q?4s088W0+jbLo9dpEOMaXSt5jK4XjPmuqQitbExYLI9kubdui4zvgF14g46oS?=
 =?us-ascii?Q?IkXN4jPT573L4PCP7RPi8Andin+cRAFiFZdwRLDAVNqQiMWe8VVkeF2gbJYp?=
 =?us-ascii?Q?tP1Rez9u9fN3YKa34ywP4hxQ5+7JPCXua4cUKvrF1II4mN5SqPu1JHT+G2zh?=
 =?us-ascii?Q?ReIuVirmkZ38v0uU7dVkULyxxR3VkcSuK8PB45L9NC37O0ZY7lBfihYXLB8H?=
 =?us-ascii?Q?hegIRyVvohA7wUm+8DSVQAvUt4wlpKM2vZs9TCTg4HYDXG3cl3Bnguye2kOt?=
 =?us-ascii?Q?SUtdKH+KldHJnTfBNneycGNmaQIKfXEJaFPZdaLtTVPA2z8sJfMkFld627Nh?=
 =?us-ascii?Q?0UCyo5+jqjD+namhxaGS1JJW+3akVif6sV/YxoozGxZouyrHDZMhLtPDlUIj?=
 =?us-ascii?Q?fgUHzQ17mX8AEVZsz7gCUWUe/b+sBky0Fa7vPCqF63M+s3YiLtvbSR+A7x5q?=
 =?us-ascii?Q?wcfazUP9FE/Vh3d1uPXuau9SopO+8sxU89Fs84BT3rSIpP5cWc5jGTRiEkHe?=
 =?us-ascii?Q?nEZGPRL/r9MM51zb8ZkEn8sFH/Qs2oMn03Uxv6WDfGUCInQirkxkyMrmeolq?=
 =?us-ascii?Q?GZ2DdfGZQj7SUYo1DL4og6QUY1umwgKEQ/D3Iez7WqEF2ol6ohbBZ5UgUIrF?=
 =?us-ascii?Q?VC6uMFeVeOi0XrEXxJPh3UFceUQBT7e7JK6EsyWytKTVl0vsJOoT6P3I+BIv?=
 =?us-ascii?Q?rh53uswJDvbihov6mSruUWItHV8qF537GP0gJnR3SHJmpOH//NTsBDRcaV81?=
 =?us-ascii?Q?KtI32ihU3LbpY5zRiYEPXDBlZZ2uV9vGUQ0CX/KuQBAC1E3SdHtKfU92Br8/?=
 =?us-ascii?Q?4amRA7DfKCv9rLR8ROY9DZzdqZ6Midlb2kv6V6lFUkR+QbSZQWMu/FWkg16V?=
 =?us-ascii?Q?ysLPET3jOiFYRKuBjWpa80kNfRhE5WLMSVMWyTVe/EtnxxSSUgRyFaktRK9T?=
 =?us-ascii?Q?ozQqCTwuzXnOiMJaXzX35mGqHO+uhgzNQQ/gpG0LVz6SMd4a2q+cJCugtkMD?=
 =?us-ascii?Q?fmS6cJqss02JZ1PC/ip2BTuRre0DNdKeNynmMYg2iQonfBPwfG+ZdRkLMr5R?=
 =?us-ascii?Q?CsZG0Y48QP3jw75w18aeS+12KBSi0HVhwzxtkLqUttW8Neg8WFJjEc+OTKW1?=
 =?us-ascii?Q?4tgXj3vI7aFX0rzFkulTVFVdhADXyYCaYWK8szMubIb2qwwqkSVwyJxsWfSk?=
 =?us-ascii?Q?DyUh48/NkOBJXiODtDYfZUHNZKtfcfDkUkyla8lJksBh6rQ9D2Gr0e6VWu1Y?=
 =?us-ascii?Q?RxF1dZRF2umbSo8nYdMM7ge++LRTxOJKbvvldQZAyvFiX8cni3f4hNjj1lbw?=
 =?us-ascii?Q?tvlKdGJm//n6KppLhalSruftOM7vqJVycFI/omYi+W66c+xlNf6fyVF6CvWG?=
 =?us-ascii?Q?taztC2WqcpY8lrZ1ZWrror/AnJjsim5WFMPKXkZKbLsg4lZPkTnQQDqHCOA5?=
 =?us-ascii?Q?1WQwgmNe2UL5y7gQttZXbVcCVyuicIYKYcqtIwa4CLFZdp07ufwCDP0KhsVt?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5ad3ab-69de-4475-0b48-08ddafe10fb0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 09:58:52.4208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6GbhARrpMTq4kHe8SBtQabPbjRakBFKCy/V5fk15z8BzOZkMwKhV+xbTgzXe+XigaTvo4/HCpCo9i/UNQM6ch8BDM/3/cTOIccCplyUPHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7523
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

On Thu, Jun 19, 2025 at 09:10:31AM +0200, David Marchand wrote:
> Doing arithmetics with the NULL pointer is undefined.
> 
> Caught by UBSan:
> 
> ../lib/cmdline/cmdline_parse_portlist.c:40:19: runtime error:
> 	applying non-zero offset 1 to null pointer
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> 	../lib/cmdline/cmdline_parse_portlist.c:40:19 in
> 
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/cmdline/cmdline_parse_portlist.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/cmdline/cmdline_parse_portlist.c b/lib/cmdline/cmdline_parse_portlist.c
> index ef6ce223b5..0c07cc02b5 100644
> --- a/lib/cmdline/cmdline_parse_portlist.c
> +++ b/lib/cmdline/cmdline_parse_portlist.c
> @@ -4,6 +4,7 @@
>   * All rights reserved.
>   */
>  
> +#include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -37,10 +38,11 @@ parse_ports(cmdline_portlist_t *pl, const char *str)
>  	const char *first, *last;
>  	char *end;
>  
> -	for (first = str, last = first;
> -	    first != NULL && last != NULL;
> -	    first = last + 1) {

Maybe I'm a little slow this morning, but I can't see how this is actually
a problem. By my understanding, the check for "first != NULL && last !=
NULL" happens before any increment of "first = last + 1", meaning we are
guaranteed that the last is never null when we increment it.

/Bruce

> +	if (str == NULL)
> +		return 0;
>  
> +	last = first = str;
> +	do {
>  		last = strchr(first, ',');
>  
>  		errno = 0;
> @@ -65,7 +67,10 @@ parse_ports(cmdline_portlist_t *pl, const char *str)
>  			return -1;
>  
>  		parse_set_list(pl, ps, pe);
> -	}
> +		if (last == NULL)
> +			break;
> +		first = last + 1;
> +	} while (true);
>  
>  	return 0;
>  }
> -- 
> 2.49.0
> 
