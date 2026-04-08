Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6361BFD5F87
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 08:49:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3012F402A9;
	Wed,  8 Apr 2026 10:49:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 659054014F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 10:49:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775638144; x=1807174144;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jQZzZiwDFPJLJKOBNyFGoase578h93D6EpCbFNPdzdE=;
 b=R/jGntHao/spk2MD/AKaZoDT4ewQ06kLWvGAeeS9c9svDDjWXo5CoONy
 4K6dh5RWlcAr6cFiV9qgrs0Mg5OQISRLEMbw4zuAfGmIoFCCUyFAvm4RI
 4pZy8MFPalEfJjN6vjcs/gE1BTC3dBP6pSHvrJngO0V1NJVnEuEDbnirk
 MP4PquKMzkeOgXYGRo9u2BYKMmxNMwCawo66IKzmYG7vAWru5Ync/acTR
 C+6CprWAcI8uGzlz/oSaU65WVdham10xfDahg//toulonjWsrGvxR/J7s
 hhXUhSeEKUnlbk36uXNUCsTFGwjiu8f7YT5BMqs8ZQ8sD9NzJPzg16dhO w==;
X-CSE-ConnectionGUID: 6M1YoiIjTdmfb96YY2nmOg==
X-CSE-MsgGUID: GayaPaHUQ8S1nbiT68CVRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76627109"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="76627109"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:49:02 -0700
X-CSE-ConnectionGUID: ygV+JJl6SAabokKHh3ek3w==
X-CSE-MsgGUID: wZvd7Ss/T5ihfoQLpTK4UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="223652830"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:49:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 01:49:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 01:49:01 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 01:48:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWc6RiK2KK+9dkxoIagGLpvrOtnb8kydr7/tLoO2VBQnEM9npJtY1HwhpQRIwu8AtRglmRO+Aycm0vX7vfBH6J0Z7jxROw4jA1vC3poDE4MwHimULp4Akn8eE8Cx0VbiYu/FDYW/Axoozq8oMlyP5GkXnemWaVxFYHRDYiKWZ+cI1RAKlG/bIHL57kRpbnDsDI4DWt/bAlyY59vpYRys0KY4ILSmyTUND0efnU5dTikoCnM+AZ75pU/LVEvgOxQAMefSpYHM9c63Yfar2T1cO34cNTeyXycye+cE+6DaUqt0YoIVGK+Kb1EQ/Urch3jHgiTQg4/ZVZBAN45XZ/62+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=widEy1VE8hHMhsU7pf8kZrelt/Vy+29kO0Eltno/QtA=;
 b=fZCvU2eaXSZYO4Q3VZXalPaeLm9mKtBtea/EA2rJHbyXo5KZdFv3sydqShiDBB90OanoWQtQKtAQQxRv1cyrV8QteR6vaqg0CIfeOLqwsel9ZOYJpo9jNBjOZ1LJ47Ekl0hceEsvb+RspvcH+bHe9n+1Yk3e3VUAM0/0OAcXvoz90jqOU8JH98S1+oaC6W8oBk7zpynkGRFxz2AuRtHkU0PsMO07WaZpaSclY/PX3eXennGqmZT9ZY92TDey2sfJaJp+iKTww1d9VjVcL4zd9h+lsyGIvT98zrWU4lizpl71vd+7+MT2/jxGOwQuXlR8azJ4qxlQfE5b74euCWZ2uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS4PPF3FCD980E2.namprd11.prod.outlook.com (2603:10b6:f:fc02::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 08:48:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 08:48:46 +0000
Date: Wed, 8 Apr 2026 09:48:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Weijun Pan <wpan3636@gmail.com>
CC: Rosen Xu <rosen.xu@altera.com>, <dev@dpdk.org>, Weijun Pan
 <wpan36@wisc.edu>
Subject: Re: [PATCH v2] raw/ifpga: replace printf calls with logging
Message-ID: <adYWaVl8VPgzkVw8@bricha3-mobl1.ger.corp.intel.com>
References: <20260407143656.9960-1-wpan36@wisc.edu>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260407143656.9960-1-wpan36@wisc.edu>
X-ClientProxiedBy: DU7PR01CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS4PPF3FCD980E2:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a84aab-118f-462f-4403-08de954ba592
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: H3XK++6CRkx+uQZi0e80sFmSzCtmgp7j6cg50Cmb17VqdzG5S44+K1phBxHKGzAIbx7Tk0pu5AEne4GyeP8677lxNJ3KfYQ/v6diGSPUnEwg0WjdfnLq0VvxMVi8xEaYh9DQYnoZPMaitBr4pXuObLZI8aVP2+shTqB4FOs++tZEzVPvlb5ilPlGrBIaUn/+4gAfcIvTxBsTyVWZMWLv3Firo1ZEoonvDo2GVumarUwVgjbT0tht30jOQfmYdtzih/noLMuMImL1S3qNbOm1NfQKgDkVBHAoxuTd3DncAwlmtkpsLGKYeDzyTy31L7AYOUrixfPTAcxFA5ryTDliFYDF0IlVxsLAziaAXvnyv/4fLlgG6Cx4SkGTQZBxQdL/nnzF1crJNe5D0qWoNeHJ/kbzK+kfMVBHHbnqbuq3Dolalmn0itsiK4mcLUGELh9nX1jWofPH3uctmx+TpwnKEylN06CYSurRHee2kfXHgD7Pmri+oev1ccwISAz5SDn9L3kjzHTP/LoREYhcLsUjvliJT0zOBvov/LzRwEzv3LevVdIjMbyXiHmzrtgXIf5V/DxGshDeCtkpjwN5UAdMDygDkzEI7dU9vnr0T/Vxt1h3XFZzFSGHBnak4h90awe9kZw77g5zSjLJ6rwray9gUDMWzyHH/O0BxmNBbJqt4m8Fos/YciKmgXynnXuzrjs3dPlZtcDcS+EhXyJf3gPvnoYV0zOKsbAZOITTiHpvCtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B74CoIxGBJv9wR8w3urDCsDXr0vAFuoxOnz71DAleAy81kgT8QGPzmMgb0uE?=
 =?us-ascii?Q?WzybPleP8pZBo4QG0RqNhpxN7c57J42iWx+Q+P4w36drM24eGjLTIkNK5QkA?=
 =?us-ascii?Q?vrb8MN4b6q1mqIkSeQQPFIB5uNsyjgE4YebCROaTHUqkw7pcpfdjoJMpBGRF?=
 =?us-ascii?Q?bQR0gf7vmN9iGvqBtD+QE/p1Cbo7seTtSVoEX0Pku/yEwD3z921KbTeVbMtM?=
 =?us-ascii?Q?z4so9E9FTxVQJ0bFPwbEptB0J2wwk/J89VXc6c/aAd9Q44/t1i3cT0xsLYwc?=
 =?us-ascii?Q?GBA3sbPpR8awpJqIjho9ylEcy02g9Y4ofV4qGlvNtnd2kD6chsQvGfsJD97U?=
 =?us-ascii?Q?GAtkewhiOV91RfgUVMBqir97uDCyPRjzHKo0r8gJe4g0od0RpuQVEmuvp0DI?=
 =?us-ascii?Q?wjf0DFrQe7kXCzRzXhCs32PVx+tQpS0sQUA37afLaAM3i5SEKxxEwMtRjy3c?=
 =?us-ascii?Q?7+L24qeGp3iI4Ea2NnqalFbeAF8iMDcr8+4skx0OQ50AMw1seWGWQ5ybv8iZ?=
 =?us-ascii?Q?u4PoVvWB7m2Z3fTY3txBlFNoW5WDw06SeK11rq3lcEeLhGC8jxIsMMvwMmAp?=
 =?us-ascii?Q?NXG9C7YvkLFFV6B37doos/apv09NVyEKoXOkl3izZcNcJVTQKgvG19Hs5b2e?=
 =?us-ascii?Q?zCcg5cCuQdZEJOjcYoUNm+/1fgy6gbvpoXQi25AcRF+EIQauaLU6Nd5bntZL?=
 =?us-ascii?Q?xKC3zgvOpXeewxCScPJN9dsSKjP3qFcnFiEUxxFrCZwTNd6DWjYvxacgkglC?=
 =?us-ascii?Q?vtsVqZehxWn4UNUmEHVRSQpQDN7NocRt6Rm6DJpHUz5CTKUMsUXAytsM+W4D?=
 =?us-ascii?Q?5HPNMU6ncWagYCWJcNGCmiEjkBLWqv80RRNiu4soGH22zYqljNf5VkjeefCN?=
 =?us-ascii?Q?Bd6Q2aTDbVA5OzOH7n+lsOnzWn5tPiulvkNIfecM+weXSU/Dc5uyL6nGR5Qt?=
 =?us-ascii?Q?grAiJabP12AEVyPshTAnj/TM8QZTlvqcH9cpput8MKJ375Ub3ytEXEFyfEi6?=
 =?us-ascii?Q?NwAGAew5Ylgu0ySA3/1nxutvJjWMDHEUODlvAyQJ25LZ55mmXoA8BTCxNBQQ?=
 =?us-ascii?Q?53GMkrtup+H8jMMedh9TDjdeUBnb1oYsG1LOJ8zWJa1BTyYQhhAALxsVmkAJ?=
 =?us-ascii?Q?9+e0jSmHwUz5cHgwf0K2Sw6gntBR2dnbKDRf3x8O8wY/yUMaIihE0QQvK2NG?=
 =?us-ascii?Q?VLr12Ojv68QvQoR4lNX2i4D1hrctTn0vlZgxZ+IDsblaXcbLcbgqVEy/rkpZ?=
 =?us-ascii?Q?khyZnpLEH67mVJmPwPnSxahlyO5htato7/m4nVxUAC5m+d8FPHEKG0pEEs5i?=
 =?us-ascii?Q?HxB1F8BxIWLt5EaRyVD3FDUSUSF+K7jvv6PzUOyk994nXy7wSPx4wITR1emh?=
 =?us-ascii?Q?9kgFiSPHaJaXX/YGgzvxsZr/3bUu9UerLFPmuZhTR3Ee03Bj6ewjMZWP4xoE?=
 =?us-ascii?Q?U0BFT0sitA5lyBOkw083VkxrwoJjtbqraLsoW7H6W43u4UYxO+dvBl9gPuxq?=
 =?us-ascii?Q?qC9BcPebH1CDHQbsjqjRHOI1XAw2GOq/wzN5UHS96xoPzQhW7Xgtm4SqSAsX?=
 =?us-ascii?Q?OV9bhpFgNCgpy3OuM9zG7Sxv6M8QDcRWO6d1hSYa4PNNcIZqF3zKcxMKaeH8?=
 =?us-ascii?Q?4B4vGw/j3OqYAZ1G9hJvMCeNLObLO7iIWi0I6G7mwrF1huTUply9WpB57gWA?=
 =?us-ascii?Q?rkkW67Zn3GiJJ25426oNvBqQT/5wnwP6CSJJvZYYQkuM17C5+OR/xVEwMP/m?=
 =?us-ascii?Q?YJuUydlY3hSyO/Xn9KxZ3bApY0/BRCA=3D?=
X-Exchange-RoutingPolicyChecked: HXo2zTsjqlcUZwMGvLpw1PwijElbaDPABj7OgmLk5+NsD5Le1hp6YD74ohfR8s4C30nP/fzVwOzql2dLnnVu/jVwAOO3aTLbTxIMlsZ8cO/7jRZ9SiyDLxaSKneLrl5obb4kCiLT6HKDFG1w92Hf6/4niDfdSWYE/kZLVeqYkW0PRlPHptpMqrLULHqHCcal8EwiJF//0Yi2IQ0W29K+D8lEgFHhL8Chx2wb3f1Eco5Kdks6eVrJdGx6Gpw53zLqQ6n/gZWycGcu6ZR6kJWRoAGoGpjyq4nMAmpyvZauk7imCEhwtIcCRjamJTw4trboHTjt7KctAZD5XVA9BxuX0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a84aab-118f-462f-4403-08de954ba592
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:48:46.8244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roMkorscxvxNGpEkMkygsXbxoNegV5tDFoQQJ4r7l8A4hKkcXtIGUJvNZvbHo6xGEUixmQ75SmhF5PW4IbAR6Yo/25KUVBmlUCpn+vImXeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF3FCD980E2
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

On Tue, Apr 07, 2026 at 09:36:56AM -0500, Weijun Pan wrote:
> The ifpga rawdev driver uses printf() directly for runtime messages.
> DPDK drivers should use the logging framework instead of printing
> to standard output.
> 
> Replace the remaining direct printf() calls in ifpga_rawdev.c with
> the driver logging macros.
> 
> Resend as a standalone patch after the previous submission was
> accidentally sent together with an unrelated patch.

JFYI: details about resends or new versions are better put as a notes under
the cutline "---", so they get stripped automatically by git when patch is
applied.

> 
> Signed-off-by: Weijun Pan <wpan36@wisc.edu>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Agree that these should be properly logged. Only question is the log level
for each. One question inline below about that.


>  drivers/raw/ifpga/ifpga_rawdev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/raw/ifpga/ifpga_rawdev.c b/drivers/raw/ifpga/ifpga_rawdev.c
> index 5b9b596435..e004e002b7 100644
> --- a/drivers/raw/ifpga/ifpga_rawdev.c
> +++ b/drivers/raw/ifpga/ifpga_rawdev.c
> @@ -434,7 +434,7 @@ static int set_surprise_link_check_aer(
>  	uint32_t aer_new0, aer_new1;
>  
>  	if (!ifpga_rdev || !ifpga_rdev->rawdev) {
> -		printf("\n device does not exist\n");
> +		IFPGA_RAWDEV_PMD_ERR("device does not exist");
>  		return -EFAULT;
>  	}
>  
> @@ -491,7 +491,7 @@ static int set_surprise_link_check_aer(
>  		if (fd != -1)
>  			close(fd);
>  
> -		printf(">>>>>>Set AER %x,%x %x,%x\n",
> +		IFPGA_RAWDEV_PMD_INFO(">>>>>>Set AER %x,%x %x,%x",
>  			ifpga_rdev->aer_old[0], ifpga_rdev->aer_old[1],
>  			aer_new0, aer_new1);
>  

I wonder if this needs to be an info message. Might it be better as a debug
level one?

> @@ -527,7 +527,7 @@ ifpga_rawdev_gsd_handle(__rte_unused void *param)
>  		}
>  
>  		if (gsd_enable)
> -			printf(">>>>>>Pls Shutdown APP\n");
> +			IFPGA_RAWDEV_PMD_WARN(">>>>>>Pls Shutdown APP");
>  
>  		rte_delay_us(100 * MS);
>  	}
> -- 
> 2.34.1
> 
