Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DE4CD5BC8
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 09:42:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03909402E1;
	Tue, 26 May 2026 11:42:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id B3AFE402D7
 for <dev@dpdk.org>; Tue, 26 May 2026 11:42:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779788553; x=1811324553;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HIGNReGq1UK2cNzbiUUvOdBdK/q1bov0etHo6eh99+M=;
 b=CQexTuifOTi+C++Lb2qc0UjQcoxtvLoyHnIiVJdiHi17RP/Duqqtc6+k
 KdsKeK9w6U2OT6NE2GEn1pde4qN65n/RXCfz/oVoldISxIndQFlFiMXg+
 +v899w5IH+g5dfjAGsl8Z7MvGN4Ol+g7z1EFvhROCB/vmzwqkiRjvL4+8
 2hiFgUfQX3uVAR9DX+w23BpCqgood+2SgbEa9VNfs6cSnaKtSDPcNcYYy
 Oz3J8z2e6mcPC44fAgNRbgMgeEO5gTiTh0BeLFahtc/AbVfronVkOm9Jp
 icK6SOZqACRR53MCvi/c3p7hvd2YWWnNY9jWhutZU23Prr10JdNpFApiZ w==;
X-CSE-ConnectionGUID: 3IO3QCFgQpW0tDpSS0ha8A==
X-CSE-MsgGUID: rR+kxLDNSP+LmS5d1GtIBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="92068389"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="92068389"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 02:42:22 -0700
X-CSE-ConnectionGUID: UBGI7spXR+CwHwWOOgJDOA==
X-CSE-MsgGUID: VZBmuDtUQpupLUD+Kb4lMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="237454764"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 02:42:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 02:42:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 02:42:20 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 02:42:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Spx6Tdq6fEa2TJ0jUrowRkGlmKOrtsQ82DnPUvHepAX9sOG5VelV1tZbGD5sJVxs58290NG4txrnXElN/4lc4TFrMArTsdLaB4h4VuCYVM/dZ+Qu9Sl5aMNiX78F7Y+w71KnManUYw+u8LNInnIL+IHZ4hJWZbXvXsLrg3mDNsC//Rh4mZ2Bx0UaoTknlqp/WO46Zw5uAIRNr1/CO16H+J6K8CcHPCDjTphKTrB0rqBmfLhD48q8yHI6rcDYZz124o3ZaznXMCgvYdbbRjK/mk+s1jktz+Haajg17AMZF2C94dUH0jOf5gBRyP794I20cfenJCMSFhLnS3ej/4GNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omkS5VRfekY4H+GrwfIw2gWYLu4nK+QWxjpzdW2SH+4=;
 b=YFzWez0OyAnI90NUvi5obJTR2T2q4/Yr6LrPzSt7Rv/nXyvsrmcKxCpRkqEwujNBwFn/HbRsoYxVFchxTdSJNoIa7PsJByNArS9tTKdyO7CBxLXOBoj/AfpYmVVrYGgDIo5WImJ4bN7cpWJPELrIecooF/HTDSCQwnIa5+jii7DGwQaCbIcjHQej5exojLQsP3gYkZCNj95c9kVtemN8z73uBciECJt3Sp24j5oRfrenfQDA5XzHYafYZmNYVz5Z4ZJlL9sYcrM82uPs2lPHwuJf04MV7pg5F0FUNR8ubyVFBFVvJJA5zXxgZrp6muuy+REjHhIjEo9Y4v3g+mheyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN0PR11MB6301.namprd11.prod.outlook.com (2603:10b6:208:3c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 26 May
 2026 09:42:18 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 09:42:18 +0000
Date: Tue, 26 May 2026 10:42:13 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 "Kevin Laatz" <kevin.laatz@intel.com>
Subject: Re: [PATCH v3 04/25] dma/idxd: clear device at scan
Message-ID: <ahVq9dJrOK04Ujwd@bricha3-mobl1.ger.corp.intel.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260526084212.3145685-1-david.marchand@redhat.com>
 <20260526084212.3145685-5-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526084212.3145685-5-david.marchand@redhat.com>
X-ClientProxiedBy: DU6P191CA0031.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN0PR11MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c9f719-b1d5-40ba-5807-08debb0b1388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: ZJ0K5j1Xg1NVOZUUsc3vSdk3l8+LnkWHzdTMwUE8YLCR0ZNCPIi+yQbe8lqG/m0RHv1cDJwwunzRk178qGgx1w0jxmk6bQAQjHHtkk2tPMJOp8gV/9ihX3NYbwvLGEwRVVBWkWwiZykmd+Y+Tbz2uqkKblPDD0tv/ouLw0HCjyZAwtyk7SzH/oq5J4+Z9Lr0+t2pBTjBYpxkyIM4v54sHU+np7M0y/2e+D1Sw4wRSojukUrgHcJySpO0HayZrpynmtLltWJDbmM8KYhnuz6jyndux2yiXFoWlW97K/w9/v3vZLxaPYDkZmC1axDCtARL855V06onNQ1q1P+cLcXH+CUtN30sdpMGKveUD380a9pTCMW4VOTaM3VaSJLPtp1jddwai1EWvpGiQs8Kbjour91wqQ1LqXuFDAnl71mq/pPrxCYBkc43qcU1aWVgVdfPspyz/KjDYwh4TYwqOHSKot+X2CucBwLqIkDoxeFVMG5VsdVPSE83T1gqb8EQJP/kBVP3CWyOMxsgo0f24Nh1QH/hLuWX/sapWqxQJH3K5VlY7Isi6J3DMXn5wel1Mt5zdfYNz1GgaylXzH0N3HNaDXlOg2y2HZ0qnq7jnkWjCfiNdKyUxNaRHvYrR/jbNNf1m3GkQjHJDGFH3UdigGlqMwQ8Tsf7dK3iievTMfKC+Cbk8nStKTwY9QqoDCzSfAJj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BBJ/GnhenkhwxCr6XaCJfGPrCWEfeYGMkWxfyJdB9a+hdrkL9SQ3ZdbChEtE?=
 =?us-ascii?Q?d69aE7HcVpjPFglJbGZ0nKR4gtKGvaZ66YR51OxAO+VL5H8vSXpBVgUmJEJJ?=
 =?us-ascii?Q?v/ApK7C7vyTMO6EKXUUmkmy5YZvZ6g+k9F4F8TnnFNBEUYz9+fA3bW+/L0ra?=
 =?us-ascii?Q?MChciC/EKyjZleHo+Me22kA2lR9/XeWaUCNae15qewDvSBlLbRKjax+jAPO4?=
 =?us-ascii?Q?20RiWzyOcj4I2D2DTTfS+1daIp7jddGacTZTSSLGk9K1HtBlNur7pWjiBbzk?=
 =?us-ascii?Q?aQxNOM2v0DJ8DPAESWjprbcD/ukg0UxtWBNFbGzj6OpvBlORaYJc6zKU391U?=
 =?us-ascii?Q?8679PlSkkIfp3A//m2r5aslIBzA9kP7AbH+5RcFXAX5WflQsJGBNDs3OZ65q?=
 =?us-ascii?Q?xIUozb3YjbrPa2fhDnkXD8Jnyh56/YgsCpXcPSlXfp+ldlZ1ndIfLPNJ5hWG?=
 =?us-ascii?Q?9331nqwsdY7tMsZPnXGqpPtBy7F+Y46QYlIu/EXRIHUm0MV9TasUDYz/WV7g?=
 =?us-ascii?Q?0fXqctIWIFfFfmOcy/93YSdH56Ig9yCkGZx0X0oZPpIvI3MYJC4aVn8PNywR?=
 =?us-ascii?Q?OVaNwDSqVL26twsxk3VvrSv8PLpCaHLjiaE6R/FMVhPZuLB8oVav5RHmIDLl?=
 =?us-ascii?Q?T1neRBIHNWiizNDQCYcd+t0yx3b90yxCgFySoNHh3Ou7Asueoq12+HZr4bfJ?=
 =?us-ascii?Q?8Kn859qX3w9kPZzUnlCvXoQTfwx9EoEEjDs4i1AlvhnpXoDKhUtLDhqkqSR4?=
 =?us-ascii?Q?VELnIeukI142JefT9jB8tbguyUz7JTDA5j5M+WWkAV3DkkLR2xgBA8ThWAr4?=
 =?us-ascii?Q?zlwxg3X1QG5Kv+OSBSjunTbPlJkaR7FOmHQ27TN3400MPE9vvXYV/nECit6X?=
 =?us-ascii?Q?jp3dzVKyhOc+bDbigdc4RnjUSgfa/qBZ3Y7ZxYSZqJXSM2umvvj5DQy8CGJP?=
 =?us-ascii?Q?XUflBBxrfLjBpG+rF56MXwNVviHC2h3l/w1ukuhVldtxwxwIe3urmoErJBkR?=
 =?us-ascii?Q?muF3PvqgRtJR1giIT2E5IvVlvXselmg3618D4J4Ll5Fq/AWcxZ2EjKGsNp/F?=
 =?us-ascii?Q?v42EkO8/M7yKrOeEVdF4NDZS6fXhxOugXhhmLyHsdtfSeqTzoQfaEac7OCbH?=
 =?us-ascii?Q?jWMbK05lZyBEoB1tmCjS1zEjeiSmBz+KcxcOXKOAWQqZUCKqew1hciV8jY0Z?=
 =?us-ascii?Q?yjvmXonbhjH/jCHsJX1gpMCPeyD4oDnOaUMg/KZ2QlAN2ncG+L4ZFF/uY/GY?=
 =?us-ascii?Q?5iTUc6Z/nfA/wk9w6kUGRlebWrkSFefC1/s7c/v6HxvV8nL7hvpkqu5HQgqh?=
 =?us-ascii?Q?hlRboqLd3uSTQz2UGGwgD67YNHR45ZLDzmgrlmupKzmnzUMhY12PzeMRkmJ9?=
 =?us-ascii?Q?vJzDU45+TsFd7oYCCHCQiX07ewXGs/y7TPERVwXHRv7pa/qjTMzSXZD+IzAy?=
 =?us-ascii?Q?eoA/eHP9IJZyF81PV2Is+YzHSwb8AI5kVHT3cUHRVVF5XoaSmvGNZz9RVAfa?=
 =?us-ascii?Q?/XOheTRwXyy4oDkmTZ+qejroU3fBUbNQrhtVCbwJCApLdAIAI/GZmFP6BqGm?=
 =?us-ascii?Q?FItd3GcYMQcM9rucf72Y0RTbkkxkdJTbIRWpcUVXkqExTa1m3RC7ajMfj+WM?=
 =?us-ascii?Q?zRk21Or3WFXUL/MgO+6mCNDNVk8DhOnfjR7Mq9xnF0nFUY0b4CUgUYCS1Pwu?=
 =?us-ascii?Q?sUY3FglmASoA8Ab8X55Fla4SyqYS7ErceguJxffKrk980tjo4pXdk30ikoSh?=
 =?us-ascii?Q?xnGaOfPyTtX2+TBMiYYKgt4rlbtMPn4=3D?=
X-Exchange-RoutingPolicyChecked: Ufssb5do8KNB4zopD+NDQ8aIx0A8OLwCHMcpJIvb/rztsohSev0MsMiWN/TEaoMBfb7K/K/m9SBjVgsxrhUC/dhoHpB1GUs4v8aJf3R4yDXNFt32gHtZRHQywjJ0yXoC4suH6oBG9QgBZkxV3aOC/0AjarQZIZ2bVHlKUccqstHzlnBL5/EM61a01rmakBbep/yMJB0eigyzmumgS98Rgl3S+f3Jwj3Yqi0Tnl8iiAUAU3WrbggUzkpIs1LhpdyEO2yhrxJTzQ7uJ1TZqxqDW+Kx+XkKYq1i2/wXhL9wD64qRW8ugP+lwLp6T/fggDKzYwtDVSlXsD3xGI46tAbHlQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c9f719-b1d5-40ba-5807-08debb0b1388
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 09:42:18.1858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NWeW7YlV69qP8Qg5WzSghysXC1b7wiCc7uS7/TmSqsIaOZqo3LtF6aVv57lmdgW7opdMtoJIAo54vg3oH8DcwVhnswI++1/8af57lvSOCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6301
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

On Tue, May 26, 2026 at 10:41:44AM +0200, David Marchand wrote:
> Currently, the device object is only manipulated by the dma/idxd bus
> callbacks and EAL is not looking too much into this object.
> 
> However, in the next refactoring, EAL will expect a clean object, like
> when checking that the device has been already probed
> (iow dev->driver != NULL).
> 
> Request a 0'd object when allocating.
> 
> Reported-by: Bruce Richardson <bruce.richardson@intel.com>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/dma/idxd/idxd_bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Out of interest, did you (or Claude :-) ) run a scan over the other bus
drivers to see if any others are similarly not properly zeroed on init?

/Bruce

> diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
> index 291cd6c707..f267c20a59 100644
> --- a/drivers/dma/idxd/idxd_bus.c
> +++ b/drivers/dma/idxd/idxd_bus.c
> @@ -322,7 +322,7 @@ dsa_scan(void)
>  		}
>  		IDXD_PMD_DEBUG("%s(): found %s/%s", __func__, path, wq->d_name);
>  
> -		dev = malloc(sizeof(*dev));
> +		dev = calloc(1, sizeof(*dev));
>  		if (dev == NULL) {
>  			closedir(dev_dir);
>  			return -ENOMEM;
> -- 
> 2.53.0
> 
