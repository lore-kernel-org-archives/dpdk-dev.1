Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3BACDB470
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 17:00:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14308402B0;
	Tue, 23 Jun 2026 19:00:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id AD14F402A2;
 Tue, 23 Jun 2026 19:00:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782234007; x=1813770007;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=AmYh35tXXY9pd2+iQgkQMnsn3RDKnMXIIry5fCPpxVk=;
 b=EkDnKlFDhusU5GW3UiK4WoBuwBarBJ4AaG7xkMbQW8mkD5Cq5IbZGiaS
 glCtxFwXJdRCSRtERZqZjM338UYbKY742MbHAf5Zh2scE22BSRROqkDql
 w8yhQMzuMRrKuog32Z9Y6a7ojRHRZ/doCMBCNkNcWXIUqvszHebsZZ2IY
 x5BwkE3Rufc71FtflPP9ZU49V/cKK2vWzISMQO/1mAunvPYcSDU+odUM5
 bLl09Pxw6YVTMD4ZtTOKQmslpeFhlC07ZOhFnM2gMJ3lJmEpsA8533eAh
 CbX1OhFJM4lvjTtboVO2INvxDHKp8bdwm91cY8m0/ze+GJFvCQnEnqRMx g==;
X-CSE-ConnectionGUID: rJBdR6pqQS+AHjtgs7y8eA==
X-CSE-MsgGUID: iuXkXhHYQ9+XnmmJoKYB/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83025702"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="83025702"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 10:00:06 -0700
X-CSE-ConnectionGUID: zbXvRyVlSsuYo/NSa4cHcA==
X-CSE-MsgGUID: VGzML6rnSqCqC5VP97LJPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="247236302"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 10:00:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 10:00:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 10:00:05 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.69)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 10:00:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIRIjx10GlbNlKjiCt4+uB1J8SLBwBN83rViJnQu6JyifGaq3HZ5qAjVkSJgRdFDPCM1n8iVBd2k8VAtsB5p5rTH8czMhIIOPkMD8Nh7S2Usq/g4pIWYdr5ZQQX6tHuNVi7YfMCa0wqWdqB7LTbfI59LLQVOj4GKntNUIwoTXYkjroifo7B08pjv/80TI/u3ygxWsTSHoWggb4Em0E2OCrVQC5+BE2XXcudvLIN5aOIE7a1cc+ABVZg4W1zEnXdmulmMhko9EtNoYB2TR9JKbEpLCs+BYsXSUtScDKjRO8ynF2QnlAl+qQi1G2ltbvMqs3rIYAVadamlUeA77svO3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkY72T7NorVczYrrNWovEzW8m40LpeYLRUkUrkbm1wQ=;
 b=pOT9dCalTwNz8f/aOuXAQCDkj+YG//fYKpXZ1FW2A0hx/pq7FWLtHCFpE21WYfqxd1oQM1M+XDCI5uw0wBWL2tmmu5lCQ2i8U8n+T411dl8ISbrpWezP7LI9p6eUV3VsDymI63zKDkmAuYxQlrSya4WgpivBQz4W1SJ15z6OEB0wkMkcM7ORpQbVAWHwb3Q2cr/6IgBB2iPWt5gRoNOSgt4A+skQjosijzHIc6AjhVA3GWCqLizwjtLmHU6ojnygZeD6tuN8OGGIsTF9DvAWNRXBybFpLcRaeqesOBvP8Vag9IXYdXcE7uPIt7+DN4r6li8fn1eRhMDQTBqVFbXIIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS0PR11MB7442.namprd11.prod.outlook.com (2603:10b6:8:14d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 16:59:59 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0113.015; Tue, 23 Jun 2026
 16:59:58 +0000
Date: Tue, 23 Jun 2026 17:59:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <stable@dpdk.org>, Kai Ji <kai.ji@intel.com>, Akhil Goyal
 <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>, Adam Dybkowski
 <adamx.dybkowski@intel.com>, Ruifeng Wang <ruifeng.wang@arm.com>
Subject: Re: [PATCH 04/17] crypto/scheduler: replace strncpy with strlcpy
Message-ID: <ajq7ipfrfZ79XZia@bricha3-mobl1.ger.corp.intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260623165150.765443-5-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260623165150.765443-5-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZPR01CA0242.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::14) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS0PR11MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 5919e4da-5dcf-4321-9bb4-08ded148dba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|11063799006|56012099006|4143699003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ayFjEdVd6zXzhJO2eyBslgWe8yNB3shBFF2ytehYluVED20ifRB327NyTwIYntGCcUzp08tijgw5/ZGNHyRi7U0Qc/qctWTbDGkQEqf4GRraSVh8tkw7pSVTfHfHbH+7YICm4vvx8nbBJ0E28rZv9lD11XfkkD7LkEgVmY1l+T4MPPqNmRYs4saspPw5jEACJJYAGVNbuReH90/zTaPu1O1JBPntW0i9ygbTJHA3N2SuOM1nS9JeJko8P4LPo45An9+6jxc9Feomk7w5t6t9xAe81MTNkDVd9OMq1/+vHgjeQLU7HOIX8i65SsPACI1gNQmJ7GjiSYZE+2cKjkYmvfQoNwxZ9yRMWhYl5iYO2lwHSFSZwqjwuQ/hQRC3luftLW+i8Xqlw3BqtI+8e0fYbMtVSba0SEZjzuEh+yhNiwUo1Bm5dqJrL2EBzFRf1MOSjlWOwYKZkgT/5ipb5ohXQ1zlNK8mjrWHj9qxiJ4vtPQzrf9DukkaG0rMeZ7XMD/9dNUa+tWPRdyor0jYDuoPmOMS5nbkkigIdlF7O2Dcvdm9z778+NOK3RvC7jycPpQX49BHW+Q4gyvTB4jF9ZX4tx6vCX6qgWOZZqY2/uzs26gG1LdA8ACn42DFngg4BshHbZvBHONYMtWc9c++IqGQFrKNNUwo3XtHSTH2exlWrYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(56012099006)(4143699003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p0msxW11kEsA+00+IM/zzM4YLkv4xMDe6KPU5rDSMEZZ288S+HmA7D1+UbVb?=
 =?us-ascii?Q?VXFhvolF6yzO9VexNDPCHkpFOj/q91tR0YcropWnQO+WQx+BhTlsURdAOSrt?=
 =?us-ascii?Q?XHhcVK5F7fqC11UqxotDzrVM8o/FwfywkdDpi60RUFAoxzkyBpsmhGU/vxzB?=
 =?us-ascii?Q?FQ0SLh+97VUZ6vTCANJK5J1TY4dZJQyO6T1jSWc2L3d9e4nyfoO5Sy+W3voD?=
 =?us-ascii?Q?YSMWg2IG7VbBiUEA2cFyD5QiQMu4J1Cak6duPK6339xAQ3l5cj81bjQx8kFD?=
 =?us-ascii?Q?n1gjpqUGq2r17UOy92avGhrDwzlQcbMWEzJextE7nVkcWNd8lbWZpeBTGF8F?=
 =?us-ascii?Q?IMSr54FUer4qkZZ76b67olRwoLkuxvIJxux7P9j+LIv8KXJblQHIKbjStwuO?=
 =?us-ascii?Q?PHfhbOyWdlvTVLRJEhKLHNhH/ajSQeKOzNFqAa0rlJX+/uv65Q/RItHimSeQ?=
 =?us-ascii?Q?Yg9ckUPibWCzS71e1J9ijOu1vrf01gcTYZdC3pe192EWXAaSRZ/2T32HTvwW?=
 =?us-ascii?Q?gQNkZ8C5hO65gjohH1hpEew8k4twVVY6BvBirgbfMQtPBAy+9MlEF0pp5kbl?=
 =?us-ascii?Q?aOFDpWAvMdoa6VgeUe+Wu4BuURAqTzDPKVG0FlyZfqkR75tnqCEI13XPldzJ?=
 =?us-ascii?Q?4Zhxo+DOkkW4DIZ8cTE1tRMg9TQA7wRxZD5yMQVEE3SY4nDTERW0rEdT63ma?=
 =?us-ascii?Q?Ql/GIlJPdRVXAdmYm2P2G1b9lzV7/KCeKj+r5Q0Ys1osp8RMJdnw7MSvjUC1?=
 =?us-ascii?Q?1OAHqEb4otxr1D089cfQ2N07NkWldl//XEYTp5gKYEoPRshaNg0eVyn1gka4?=
 =?us-ascii?Q?av2dapuy2sbksRRbrevP0AeHG1/EvaXlryNvymCM8b27EhZt20J/IURQyINo?=
 =?us-ascii?Q?pFO3Fp1HWMmPX0DPm+3oLgoS0dRGlwGY1lo3S2GchfDeu1hH7MtbLARXSXWq?=
 =?us-ascii?Q?uhGzopYA8QgGdBwmh8tnBUGoLPVOYq5hmu1PZ2f+XbZqI+1YqjpyV/Www1ai?=
 =?us-ascii?Q?r10HFLj37742E6bJVha4Q+bL8+xc9wmRzCEmq3F8giw1HJdrG1DgXV64EYlB?=
 =?us-ascii?Q?CYDc8KukLND+c437Rj6PETH27/BsAM2UYNCD5WXPtDPSk5FQzLlfs+eZwy/L?=
 =?us-ascii?Q?/vlhcI4r8BP30kYKDChlJWgZoKnCZZoBsus9iYrZ5GSFu2IZAFiSndJHpu4j?=
 =?us-ascii?Q?JW6/T83bOfWC1Xtgzoxcsht9gVGZmD6dbsnyi98apn5QhXncDb7miAcSmcAB?=
 =?us-ascii?Q?S0k7XlAby1y6cjsvBwnTcESfgEvFcZtdxdEtUk9IKM9XNs2mDtk8BDwVKjIE?=
 =?us-ascii?Q?YcVxuPLnXQr27h++RETXfMGWvyGDLCZDT34OsXdQGlIHuEGKJ4Tsb0OF1uSa?=
 =?us-ascii?Q?CVbWv0xcA4wun6tXkJjhuTJn0EcSK636Gx4bcDnF6T+vQ3rNZwMDRVciJfEg?=
 =?us-ascii?Q?dih9KeyO5yv9vwc8SJ/FlYcg0cDKlHj2Qbda/1JnjR/af+a+9r0Bzn+2Utit?=
 =?us-ascii?Q?pHjcVVzxoSdJfIMi5axolfYsA5HJV6FTssNJ+Uj/wDx8x18Vo7XUDqf273IP?=
 =?us-ascii?Q?rM45mpL84BGZcOnoat9mSTUC521FWCijTp3RFn5NFnb7j2A9BqsJrzun45TN?=
 =?us-ascii?Q?rSssvLsh8XXQGu2M5CS9IOz/kYWk1a/yN1s1Ka/JkwTa24nyUBjm4Jnm9KpR?=
 =?us-ascii?Q?FuLih21Q/KkNeXbnEExQiPa73TcgrpaRROGQMluugN07dDr0ZpXA974F4eTG?=
 =?us-ascii?Q?9oxTGMxWG1KtCvwiHEA4z8XdLcpSADA=3D?=
X-Exchange-RoutingPolicyChecked: o/WDHGpZLIqohTwNHJpAM14rB7P0QM8aNgdy3IvPLCVrkDV7pER43wVKdrsE93oJ2Pe1oo2lnIuztim5hmlcLfdr0yXF5nlPrayC5GxGyms0/q0jDeEd9EUpCTbgIrifhZfut97l2cq5Hc0qJSBnDtipHlxu8EI4Q+DoS5tTm5iB4suQFbU9wNOIYz1j2TG6Qbh7wDuMiIo4RJOyZV50cvtQL45pseVu6LJVx2s3eOyqaYK1Lj+c+MGOeX5DN0TYPOhOZA3wfpmHmw9LxJS4vKkLmoLEw/lpxbie7tglAwkCyuCtAN1QjkbCdd9qKz1LOt66bTycTBCC/pKHFN3nWw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5919e4da-5dcf-4321-9bb4-08ded148dba8
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:59:58.8428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzwTbWCfJKr6uR37kZnfTOFm4ibTfTDmKjXwjFBBqx+Csgx+1IrhrhxC8UzaDOvHZIf7+D/BjnNyXuR2YnbqjJc0wSABVXvNo2lvCuDwvio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7442
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

On Tue, Jun 23, 2026 at 05:51:34PM +0100, Bruce Richardson wrote:
> Replace strncpy() with safer strlcpy() which always null-terminates.
> 
> Fixes: 85b00824aeef ("crypto/scheduler: rename slave to worker")

Correction, this is not the introducer commit. Instead it's:

Fixes: 50e14527b9d1 ("crypto/scheduler: improve parameters parsing")


> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/crypto/scheduler/scheduler_pmd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/scheduler/scheduler_pmd.c b/drivers/crypto/scheduler/scheduler_pmd.c
> index 95ce893f05..ceaefa329b 100644
> --- a/drivers/crypto/scheduler/scheduler_pmd.c
> +++ b/drivers/crypto/scheduler/scheduler_pmd.c
> @@ -229,10 +229,10 @@ cryptodev_scheduler_create(const char *name,
>  			return -ENOMEM;
>  		}
>  
> -		strncpy(sched_ctx->init_worker_names[
> +		strlcpy(sched_ctx->init_worker_names[
>  					sched_ctx->nb_init_workers],
>  				init_params->worker_names[i],
> -				RTE_CRYPTODEV_SCHEDULER_NAME_MAX_LEN - 1);
> +				RTE_CRYPTODEV_SCHEDULER_NAME_MAX_LEN);
>  
>  		sched_ctx->nb_init_workers++;
>  	}
> @@ -443,8 +443,8 @@ parse_worker_arg(const char *key __rte_unused,
>  		return -ENOMEM;
>  	}
>  
> -	strncpy(param->worker_names[param->nb_workers++], value,
> -			RTE_CRYPTODEV_SCHEDULER_NAME_MAX_LEN - 1);
> +	strlcpy(param->worker_names[param->nb_workers++], value,
> +			RTE_CRYPTODEV_SCHEDULER_NAME_MAX_LEN);
>  
>  	return 0;
>  }
> -- 
> 2.53.0
> 
