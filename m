Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93339CD8CA4
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 10:13:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1375402BE;
	Tue,  9 Jun 2026 12:12:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id C14844025E;
 Tue,  9 Jun 2026 12:12:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780999979; x=1812535979;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VOLxW/0vDbufk3eXdoTKQ33aHmkmykiVh/KSmj3xM9Y=;
 b=eZy4QKDpRPcWN0oDvOtPMuQ5onwSVVU2xDkkgoJvPCONiQgZ+blSYbBP
 bmpvgBfA5UJorrKWcodsqFDyNW5r21+A+2SK1kY5LXBrn6l43eIjNrCZR
 ja6sVOYaBgm2ElD8SeHYlQCj4D3eA2Vxu9OyyziSxioVKBGAqSGNA0hDa
 Foivpwm2OdVN7BM6raJH6s2kxXlYjuyYIRpsTJqBxnae1aRmvFWSkuwZN
 yHOFmvlhGOpl+lCJtGgNfSRy3TTX7NsFaz9G1Vy4cf1YqTfvTncwV14aR
 XQz35fqJgvQ6CPqoRZTZnStCxPgEtaGW+1bK2lD/DBA2x105iaaFm619V g==;
X-CSE-ConnectionGUID: QaW8Sx9GTW+c+pNW43s/Rg==
X-CSE-MsgGUID: QK6xKIaMS+iTL6Zymr7doA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81733860"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="81733860"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 03:12:57 -0700
X-CSE-ConnectionGUID: glH+YN1BQJGoR5d8gQ667g==
X-CSE-MsgGUID: uOAOZmynT2OKjozS4AsOMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="245665823"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 03:12:58 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 03:12:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 03:12:57 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 03:12:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbeWd+7yIkz399H2oJ0JZQw4qNj6KMRdv+2yWKc6R6ksk3rsDrIObwG2gafTdcDbtfRtEpAd48gSbZiHHWv6cfiJOzP0aQXUeCKHijWbR+wmvNo5KBqGufFc5HpoZwVFXUpJlLnQS5lkwH1FAzsz6B4BI1pRndxaMK8pqz9yLYQRUC9Mldss3Bd9y8VNk27VwcPtf6wA4Th14GTKMTIaLSQZ8LNZ8SDCKfF0nDkmAPDLdZ09ZoCRffRQNdQjf84g17TPp9WwL+lYEweb/pUV1X6wZzoxXAZsuekmVBZsK7hM8bxW0CNpMtg9t5G917sCoLw8zyZv3L3ac+SJwCzgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBLHVT4p2DgeZ71CtN3GI0i3osdoZHZe26gADh4XVRU=;
 b=zBSGvN82WrIwfxz5cFtwxfqK+hgttfHkSNVSrfENer8xuEWGqFbiDom7a0AAk0X2vH9T+/GIzPUh+fNckgsBVOfSCk0la/OgyQY3UGYKl7+20dBvnBnHA7tFvxwj3+OBZEKCq5VC2vgtgFO8qhD0ZHczgzfMh4KkDOjUfe9BFllymQCfI/Lf5DRqXvBCMlv++/ihTaSDccPFlbDbi0hIPdw3YQIxSi/2T6ObxTbBQE6wKVrPMBvAwliyxbG79O0CJIETZ3WY/Mrbdn473e9mtEczFHX3+oZ5sbHLKYn3T/deVw4wcu+a01AYcIqp2TaFEM3eXKp+9KP5nNywc5b1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6478.namprd11.prod.outlook.com (2603:10b6:8:89::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 10:12:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 10:12:52 +0000
Date: Tue, 9 Jun 2026 11:12:48 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Artem Novikov <naa@amicon.ru>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Qi Zhang
 <qi.z.zhang@intel.com>, Jeff Guo <jia.guo@intel.com>, <dev@dpdk.org>,
 <stable@dpdk.org>
Subject: Re: [PATCH] net/iavf: remove unreachable hash action case
Message-ID: <aifnIF_BaQiR-K_1@bricha3-mobl1.ger.corp.intel.com>
References: <20260604161354.95602-1-naa@amicon.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260604161354.95602-1-naa@amicon.ru>
X-ClientProxiedBy: DUZPR01CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8abb61-c769-4299-d0b9-08dec60faad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: DaFwnGqEfh/RkPf+pBgy2OxHu1CVmJLX5ZMIfwQ9U3Irz9IEAi9gRFlHHGyuiRwo1J6onv0GAE9XVp8KoNQA9mkrZh44EiTClW1zZmMgw3YVMkGSZJ5W4C8ci3KXhxAP/NbJz3oh1+31NZdU/OoMWKolzgu+e9omOSkGI53RA6WnMKRJajXNxsWFTdIyHdB4hBeNSq8LH7vYBT6WjN4n2kXm6CzgxqyjgnMnvlusQJaix99jzDDTHK3mkiTH+5orFfafPF7DgaGiqw2mtGcAwRl1Cx/3QNFIMlEQto9odatCkHtzm+MHs3/V5g6M2u4TeNhp7d32aTbqrThwRhBUf6qZ7/t/hKmqeSQaOjOhjHXyUh9Efjj1k1oJs3dNViMPkA410l8djyG+0gt1zOApADveoEhd8bXYM7HlC1GpT6+CNhSlSI+H+i6/Hd6cJRJEl+QOLHxHNKRwcO0Ah/bWTMqyuTGj8hkYc5TySdbVyCtQkQ1orYSpX05VUmR6Os3hItmIs6mGfSfwC+onN3qU5EUgU68Zrlhc7Z0hZnuwzTK/yRsJVZfJNUbTWUFS68l+yQBFvuixLLLTW5Ai4LiXNyvTzGEpMlw977lQTchIfavt17+ofoeVLFDWA9dRZ+nj+YPNkCu4ky9jw2vmll31DIVyK1lU3B9+e84h0dOCoJGI2N73GYTPDtUSDXzLi+lA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zXVqy+ov6u1Q5yi2OYooTH7wSiRdj/67wUEv8m4HHQN2I11MYdrd+EILDpVK?=
 =?us-ascii?Q?OfGhXCRCuOXysjPqfNgIni7D5AX7lHCUia4LVTXHFQMA8po6WCpJNkQrtW0+?=
 =?us-ascii?Q?xQTj0N6Pg5Nuwz+J9FJplTo745Sofjk20kb4Ib32WEKtNCKIUT7RQxl6Vrdu?=
 =?us-ascii?Q?rSXYV1bZuTcDIuu1YatAIN6HUyhbpf/nNbgWgJqLMG+eiCT3sxVkKgigEHlf?=
 =?us-ascii?Q?derRQAhwR155kmYxv7LSSoQD2Syup1lWvaooqZgdVIpRzyppmWESnsXBLo40?=
 =?us-ascii?Q?Nr7tTAMKpfotScfawGC4oKQKG2CP+/VfekZZXRzGKS536TBvFOz8UQHA3YQK?=
 =?us-ascii?Q?pFC4Ybx2Mka0mPxY4K7EPQ21M4IicwDdjTFJA3WG38b6ylTLDDtpalSyoyE3?=
 =?us-ascii?Q?iXZNj28Ja0QGyuBx/rTaNhFoMV3hgtCiQ7KT8+xfPg7kmSYoZoB8w5frhXgb?=
 =?us-ascii?Q?ToJiA+iMs1VtWXGPu24jOV4wGCoScmGX76tGqwuEuVhfwGJefGRXSLRQ4S/I?=
 =?us-ascii?Q?FDaGeAx68HUrxBr9WjbjN7WiIxyK1cVMLaNkZGuPB1BmMPTHtqAT7VC3RrNQ?=
 =?us-ascii?Q?S++FuymFkbPEKy+cQDhE/k2E1GIgcJQSgKCr7v6dq1L1/2IUF2DXrod/nuts?=
 =?us-ascii?Q?GnW6vLksa7ZHIy12EHFlXNAEWv1Mr/Ic9HiJ+tuJTUgTgan9SemEYTLcBUPU?=
 =?us-ascii?Q?pTyuN2N94PH8dxDr2kijnn3E+M1p5//Zwf9OJVuSM9IKQKHJrlqg/idxxo67?=
 =?us-ascii?Q?eiyZJ04vrHWgn2KXZyag0epRQgA93TEvUvbjgYE39Sfbtzr2l6L8REBaU0dD?=
 =?us-ascii?Q?DT87JKcfJ3J6z19mP7ojTKtonzEx0mvHhhkBsRwAq/hOHJ3afF+nsL7hfEZO?=
 =?us-ascii?Q?24h4RksExkzgJ8umwom/W6DAP484e7GtTuHMmlqMRSKBCTR6X2CtyiPMDfE9?=
 =?us-ascii?Q?adUp/hjxsOBzIus9SObSXSVQZfzk53Eecgp/5ZE9lnqknqOeJ5cdk/rwC3wv?=
 =?us-ascii?Q?GCjr6KV8lpx25N2mRVmuLhMzkloasP3OmIs6v9VYhkXCcOvOT3GBLWsitR7Y?=
 =?us-ascii?Q?f5Solg/gaSmQRC3nIaefLiirZn4b3dOcByAoP096g9FC7pkS0+TzR229L9ls?=
 =?us-ascii?Q?xZgPyZNW1E7FUPat0ekP907tbIEtoYs+moFz94UTQUmx2S1kCeGg85qudO50?=
 =?us-ascii?Q?3vpyIlQ17zPqyySE3mhsI/6fuBmV8JkzWZfykKT5EgsU5ZcIaVekoj3c6brJ?=
 =?us-ascii?Q?Azvmhrk67hhcV+WIy3W/Pzav/Mwh/GT8rnzml8ec5ZsHzDl6dLeh7NwwZz8r?=
 =?us-ascii?Q?4ssthgnOH1hL680NXkTfp53abUFYF01gcteN970q4qjCsILtCvUY91DTPO0R?=
 =?us-ascii?Q?UpNXEf850oqlbT0zKwX3uoAgWOOKxwow/VBibhm1BRjdOx8VD9/ZFaKD1J/n?=
 =?us-ascii?Q?PD68qKSPI/bkDvxTtN6oBJQBFqzN1ELeI9FcSM02smPoCj/OSlFgS6ChcYj3?=
 =?us-ascii?Q?8OY1UokKRohgY6KSeZ1B5fl+NOG9VuuZDh5P6JjSlFClqCG5NuWV0q+PKH6h?=
 =?us-ascii?Q?RRIRla0ic6WdYYatAtXJRqqtp4S6EVpJr4RXtKN5PDjOFpWehAgE3oWNXk4n?=
 =?us-ascii?Q?cIiq0F2DAPcXzz02VDjzKZdNtr1GrvRJAObZC0sH6vDpruWrmg93SDwYeROc?=
 =?us-ascii?Q?+7+0Tc8Pu9J3Z207ZXsGrVyYEzCt9z6exVelscM8ZN3CfY4L8wQkJlb49ro4?=
 =?us-ascii?Q?vO0+i7EGhu9vjuVHlHCNW7CYQwN/Tlc=3D?=
X-Exchange-RoutingPolicyChecked: RGw3grNp7Go1krLAqd7ytOfU5E8gmy52COVzcgoE9XXh6caVJUeJj1usPwVldU1pjgqQaKYuGUrsIVS9qmfG7zu+4WbP1tyyl0AA9K2zrToFLKEwTg2mZmT6+EjccICyc8vs6e06LafI2xoMhiLwts6MOO7OxW1rY4Of5gwGITIG+dqYskmJphnTQ75Z2bRqWj9x5vutbmEsHV9iI7zplwl9KAwkb7FHXNKYHnVxhgUw4z56wGpFJvr7YEfGd+fHGonHtqDZbvvilrcr4wolbPCtIcaeEwjYFVC4rInrjJ7Au29OKFKh3dDEuyZCCdHfSdlDmFEZqGM6MI9f+j2kzw==
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8abb61-c769-4299-d0b9-08dec60faad1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 10:12:52.8250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMZT2wBIav8bvPa/0Yg7c1O4hk4seDrMdfrTlwYkB6NH7xTwLI2ZBMDZmExe3Mg7bDL6UWJHNFc7+rFsHvCKDFsDiLa5ZlVlWvkE5s7t89o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6478
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

On Thu, Jun 04, 2026 at 07:13:53PM +0300, Artem Novikov wrote:
> The hash action parser stops iterating when it reaches
> RTE_FLOW_ACTION_TYPE_END. The switch below uses action_type copied
> directly from action->type inside that loop, so the END case cannot be
> selected.
> 
> Remove the unreachable case. No functional change.
> 
> Fixes: 7be10c3004be ("net/iavf: add RSS configuration for VF")
> Cc: stable@dpdk.org
> Cc: jia.guo@intel.com
> 
> Signed-off-by: Artem Novikov <naa@amicon.ru>
> ---
>  drivers/net/intel/iavf/iavf_hash.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
> index 217f0500ab..7ce7b86d8e 100644
> --- a/drivers/net/intel/iavf/iavf_hash.c
> +++ b/drivers/net/intel/iavf/iavf_hash.c
> @@ -1490,8 +1490,6 @@ iavf_hash_parse_action(struct iavf_pattern_match_item *match_item,
>  					       rss_type, pattern_hint);
>  			break;
>  
> -		case RTE_FLOW_ACTION_TYPE_END:
> -			break;
>  
>  		default:
>  			rte_flow_error_set(error, EINVAL,

This code is no longer present, following the recent rework of Intel driver
flow parsing, done by Anatoly. Therefore marking this as "not applicable"
in patchwork.

Thanks,
/Bruce
