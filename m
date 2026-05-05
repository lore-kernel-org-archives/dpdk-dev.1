Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C84FF885A
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 10:33:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A0B940272;
	Tue,  5 May 2026 12:33:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id B5EC54026C
 for <dev@dpdk.org>; Tue,  5 May 2026 12:33:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777977226; x=1809513226;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lNnD41M42QgZkiWmEAuH5yEYf4gWaKX6ggf9MlQ7DRs=;
 b=AIElBA1T+IAaI3fCqHpzTgQlrakfOQ0BtR1JaNwABVXweR5V3DbY4xw4
 vwoWiuCZk5AzIcwjnju/FP5D5DqLTIJJ7Ep7fT/rI8c3lr252k1j25G7/
 e97BOYP/bKr7fv5EemHDoO/FVucfByhMzQ67NvC6jCPmpLF8eS7uOwguF
 KAOopx7gCHSqRcoaAGyikAU4Y//ZLRSy8TUO66acUcWHBs34jJcX6fu6c
 JxGXy0kXNPp6i7U9xwdE1l1k7K2V7a48taRy2p+kTRsqmRHsp6QvB3aB0
 f6+uvverx9SGJ3Oh4GniRWfwSyUpJSENGEzR6OoKrLk30zTNw6D+NZOqT g==;
X-CSE-ConnectionGUID: QeMRnkZuQImPlxPRWBdq2Q==
X-CSE-MsgGUID: sE4BUkb2TQ6fGpPEFCszvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="66371189"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="66371189"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 03:33:45 -0700
X-CSE-ConnectionGUID: OVGF73TWTw+EIT0GdxAvwQ==
X-CSE-MsgGUID: dfI9l0ilS+2GSvYmRKejpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="229296843"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 03:33:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 03:33:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 03:33:44 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 03:33:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWn9Oin6HnkN7aQ7jMaaX+gYNG7yyQni+4nanOnhq/WlO8PjYrJMgjy9Ram55zaDcq2g09CPnHd5Jv4ig86bMJplvb+bOTmurwV8OmNPMHKJeUjVGOO0ODYXCPkxRzEpeXCkCp3uhG6bqy1WlxsYIkoChOUkoIXNrcv9cj5JpOCw0HQxF++2N7IRTXWx7j9OlNBTD/L2WrKjcQF1VDnfzTxkdGgNRAwZ89scO7WyQHnjbHqIvYlPHtNzaV2PW+KTjXsxYOibyVATqM79kRC2e+9gQyn7vqBDzKGDJ2kluJioTqb0RbaFJhlCoEyBjnJ1xiuuTqZOuz8ZTIefjS/lYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hi/CgyiwkhN2nyZwzDbYNvgy1AX5OJq9AYoyYrwKNNE=;
 b=fXa2hDeFSHy6do1Kv2UTkhZnYANlb4zNgE2nH3laqGc02ChByCmM7cCL6HUOtjL9SI5EOvH04bPIfd9oeR7adhuBwIUlXqKJgi9n/I5ju4s5ZSBiSNOdRk7aCZD10HokYhuFAbTtDtTNpB1ANaRKaSeDR8zx0Z4SbMNk6kTd85t14N774OMWK2V+kpckPEdNMKU8LfzNleQmMdP248AaTICst5CQCIkaL42KKUg1bD4xkXzhyrUM6eChyUDwzgmg7BDpCtSN3Kxj3a4up+i0grLHR1GsAp3oR48nNw8QUfaJ0oSxRqnlm3GtVWs48Q/Vl1C9jsxsZI3MjyOUfCks6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB5803.namprd11.prod.outlook.com (2603:10b6:806:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 10:33:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:33:36 +0000
Date: Tue, 5 May 2026 11:33:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4] net/iavf: add support for QinQ strip
Message-ID: <afnHe9aTS2aB-gWJ@bricha3-mobl1.ger.corp.intel.com>
References: <20260216103710.195777-1-anurag.mandal@intel.com>
 <20260409101951.114492-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260409101951.114492-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DU2PR04CA0208.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::33) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: b005df83-02ca-43a8-1175-08deaa91c357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: U+zIvfvTWaihrqo2wWb2BzO0nhN/g4U6W4Kn6ShUp2pjrEL9VxMhXbTOoudLwLH3nGLAFAznccsaQ0yZctm3Mc/rWd9M2raQZQGtrax0DtNHATOftaeAd32PpSdg4JUcHkxH2/ZZjIFV0DPM+SPBCD/aZj9SXgYAlgZLip2TeaSW0BLSRHOKX9GXa7Ner/so5LfzNEmVtMXMaGHMkxST7E/Kx31pxcQZKg4iXVHapVEZGWnY4tvEtCiRXXl/YWy913uw+04CxDdmQec7FQ846DF8Z9wXmdEfOebZOqnAfGDp/4kyDwWxqB/Jj3bLB7t/2O1KyCKjcrDSd5h12QyG7KV2sXN+1MhEEM/1+tdvOMKnGW+q2u6MnRuYnseA0gvbGnu3a0VZk57UmnaWKXqcVpYbFlGAAhbsjCunE6CLDXSlsA0a/MQvHnFfbqxLmBIfmyRIbCtuPos2xyxW8Lkbs4tv1NCttDWwHpP+TZmqwyrpUT6to1n7xBbZ9b71G7togn4Knh0CkieANZexa/AQUXxACC/BOcMojMG+czTqNk682vVSQ2n1WYjgmUN7d2kacpaDVECvxjDW7dwEEljI0ATfkHu2fZq3LcaG53ORfsGOID6uHRqTa5zE3kSlX/rlrGNYN2pDI/UCmsdO8I9aw3FEj6BpBBmkLl7FuC+b7YjHuOu81D+eW2Qbi0UHmmtC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dq+mx16VtAVBQ5FdQmmtvZTPl4opHF2mHX0itrwwV1bdWijfbueZmXGVV8bl?=
 =?us-ascii?Q?zdYyhKi8TKlUG4AldMfF4sBolb1NbuJ8zYgXHoh76lHqAMKpxx4F14iL4miR?=
 =?us-ascii?Q?vA4uWJ0yO9sQ++hjeQBQQpnWMowureyXDznP9NPUbWsdikmuBioHvBsKVNgZ?=
 =?us-ascii?Q?exwYuVpPGeYUJuvKnJpOwwI7fvM+2GfnBqTaG1QO6dz+ZBrDUNiHc0OctZ8P?=
 =?us-ascii?Q?cOBJs+fUoWkVHzAuVfhOVCl5XO3OWWmFO+l2yCde5ePR4EmcoBEm/IlmpT0l?=
 =?us-ascii?Q?dtpcy1MOdngDzEoBm22Zd/dbxjIye1XjWaZg7sV3gQIXApIAw1/8UKV8tk7C?=
 =?us-ascii?Q?LGIVgslHA5a1Puflqn/Vax7f0t4QEE6OTkgb8DA8+pBoZVxZ6ABI+QCVdObN?=
 =?us-ascii?Q?4FjT7Zt2dgoQ/fUFH7h48owXUCjuQffrYGIXcfNLBqsR6Wjm3656mCIr96mp?=
 =?us-ascii?Q?MLPtPMJgp2omGICl3x2sEdbO+fY9vjYuzkV+GivfJxtcPzf0gBBaEgdSrt26?=
 =?us-ascii?Q?aZNdjYdMIp7AeBOy44jnIeeE2zgugGGM9Yt8wy1gnwiUL+md3chhYyRTJ4nS?=
 =?us-ascii?Q?F5Jc4ocAtoUkrylR1Utb4Buh9o+xswI7+RgiDv7Ghqn9N9+IJTaWsQf0fEUB?=
 =?us-ascii?Q?138ZEUVQd7t9p+1p9TR4fYd6VJaVogrbvVL0QZg3B94O3AZv2KbdpE0TQrAH?=
 =?us-ascii?Q?l9SnOfDX6XUCB2HjjtMJ0IwKKSyryPkGFlOpDMRcVZEmBO7wB2T5ZsLZvGsL?=
 =?us-ascii?Q?9w0fzgY58PUkfsosM1tXFXDwcz3AjWYU496lJWuSZayXcRTZ2BeYatRNG6Ij?=
 =?us-ascii?Q?gBayN8VWvmmxnJ229XPbkGr8Bkg4UAvd5TYGERMgjPR+gspVoZLFrIBnpg4d?=
 =?us-ascii?Q?IWUDhDxLaqVMCxZOfnvIrp+WU5F1XKkCWKOOWw5TEcY92Rjjp70QhiTwONlN?=
 =?us-ascii?Q?IzGvaFj8FXy+GXwkKIFLC58P9X/GZr7QBftPksjqTVAv877ZFSscphYbey6y?=
 =?us-ascii?Q?MKkM0k6a+ri1G/aQvFSfLqAZvmXdkXomjq9pDVtoLNeTskeefdkzCvfuVUgH?=
 =?us-ascii?Q?wMakClirJ8Hp5yi5bc1lqmRGNcLaARdBWLN48irVHci+oNhUDCE9bYW03mOd?=
 =?us-ascii?Q?3CSRXKD3IL0eH/XN0x82EHH+34BkSRXgg34qp1+R+xY0OmogpmXtCBArtB0t?=
 =?us-ascii?Q?IMF+fXBJRiwoe/sjQeJfJ+rVFDAPs/QWDEcnNXmJ7UY6fcw1czSjMitvSQnh?=
 =?us-ascii?Q?exFyZn4SXmMGrbScCqU9sYepjwi/YDJ5UaoE4z7KbMeH/x7ghxMttgz0x3+x?=
 =?us-ascii?Q?srcZJF8IhATmd4/h0pXeQ7Yty6I5hDqdVx1eOrcRoF4icmD160Z88YjcCrXt?=
 =?us-ascii?Q?6SWYFumsMLScg4kWhZgEnzklS9L0hTgnpk/Wi3WpaM8CasRQM0Ju0fK7dGDy?=
 =?us-ascii?Q?rgHqpBXqllIngFYr3ZpKM0n815cfBrVCfJXfD2mKbjigzFnxp46IDrKlF4mh?=
 =?us-ascii?Q?1jnfR/+nTbT3rowf6xtOsGBc40aJjqsS3lE8ue8Zb0N1lDxhIWJG8mTqsZJt?=
 =?us-ascii?Q?38Qvwh+dgk2Q0e5+hqlev+nmqfLIDP/9fCKLcHqQjb7blwdkUYcfYj1KJpnz?=
 =?us-ascii?Q?zlZgvPAE7HbQSddXsijlOJ1/+6uykQfzqTOFR91UG4r+nJcB6B8Qer21KoTD?=
 =?us-ascii?Q?G+jYTpdqMIfpMuwMuYapjbjPnwXdNut8VLtg53XmZ59Tiw3Xcc2EVXao/Rvq?=
 =?us-ascii?Q?KXlyd8Ey7I4Xf7qMSYYAvkFy5s1BToE=3D?=
X-Exchange-RoutingPolicyChecked: dUtDXxV2FdqOgz5qwy91eK6VhOnEHLXLJXV0JOD2Dexg1BrUvL0Gu1B5rCOAFYm9NrLi5XZCaJ3v5KabtqCX/iPxkDEca2YhT5VdrJ/a9Z0tTIboGtQbVJB/+FUxDZeTmGhqUuW2/SPS9ebWsVyamqElPSDyNYRih/E6vPMpaVVyEJlzv6qFb2prQsyBxYIFPc/6Gv1eax+4aZwWXDXe7BHLAs6LQ6UMAv5IDnW1Nc1vM8NopwJ5s7vFCOwzGv/ZlXpVVNO79aaS5IMwRGG7jb9yud9vOBeMmkjeT2wWMcUhyLdFapYkGK1zrGU6FyZjkwNEim5/IKxh4ULZfITsAA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b005df83-02ca-43a8-1175-08deaa91c357
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:33:36.0226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WYx/2+g+w0RIpSSbmxbVvsbxWf/r7sjwPMQ22eSoK0WPENz+uWWpDqZDBawqog0pEyTzrXszy9MzWU61JndDf+1i6oND9cn9pXmjAZ+5YI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5803
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

On Thu, Apr 09, 2026 at 10:19:51AM +0000, Anurag Mandal wrote:
> QinQ strip with VLAN TPID 0x88a8 & 0x8100 support was absent.
> 
> This patch adds support for QinQ strip with both Outer VLAN
> TPIDs 0x88a8 (802.1ad) & 0x8100 (802.1Q).
> VLAN Extend should be enabled for the same and Outer VLAN
> TPID should be set properly.
> 
> 1. Tested QinQ stripping with TPIDs 0x88a8 as well as 0x8100.
> 2. Tested Double VLAN stripping i.e. QinQ (802.1ad/802.1Q) &
>    VLAN (802.1Q) stripping simultaneously.
> 3. Tested Single VLAN (802.1Q) stripping.
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce

> ---
> V4: Addressed ai-code-review suggestions
> V3: Rebased onto next-net-intel-for-next-net
> V2: Addressed Coding Style Warnings
> 
>  doc/guides/nics/intel_vf.rst         | 31 ++++++++++++++
>  drivers/net/intel/iavf/iavf.h        |  2 +
>  drivers/net/intel/iavf/iavf_ethdev.c | 50 +++++++++++++++++++++++
>  drivers/net/intel/iavf/iavf_vchnl.c  | 61 ++++++++++++++++++++++++++--
>  4 files changed, 141 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
> index 5fa2ddc9ea..dfff69b982 100644
> --- a/doc/guides/nics/intel_vf.rst
> +++ b/doc/guides/nics/intel_vf.rst
> @@ -771,3 +771,34 @@ the VLAN header tag length will be automatically added to MTU when configuring q
>  As a consequence, when attempting to configure a VF port with MTU that,
>  together with a VLAN tag header, exceeds maximum supported MTU,
>  port configuration will fail if kernel driver has configured VLAN filtering on that VF.
> +
> +QinQ strip
> +~~~~~~~~~~
> +
> +QinQ TPID is set as 0x8100 IEEE 802.1Q by default.
> +For QinQ strip with TPID 0x88A8 IEEE 802.1ad,
> +extend VLAN is enabled and VLAN outer TPID is set to 0x88A8.
> +VLAN filter steps can be added before or after.
> +
> +To start ``testpmd``, and enable QinQ strip for TPID 0x88A8 on port 0:
> +
> +.. code-block:: console
> +
> +   ./<build_dir>/app/dpdk-testpmd -l 0-15 -- -i --forward-mode=mac
> +   ...
> +
> +   testpmd> vlan set extend on 0
> +   testpmd> vlan set outer tpid 0x88A8 0
> +   testpmd> vlan set qinq_strip on 0
> +
> +For QinQ strip with TPID 0x8100, extend VLAN is enabled only.
> +
> +To start ``testpmd``, and enable QinQ strip for default TPID on port 0:
> +
> +.. code-block:: console
> +
> +   ./<build_dir>/app/dpdk-testpmd -l 0-15 -- -i --forward-mode=mac
> +   ...
> +
> +   testpmd> vlan set extend on 0
> +   testpmd> vlan set qinq_strip on 0
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
> index f8008d0fda..6a77dacf59 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -387,6 +387,7 @@ struct iavf_adapter {
>  	uint16_t fdir_ref_cnt;
>  	struct iavf_devargs devargs;
>  	bool mac_primary_set;
> +	uint16_t tpid;  /* VLAN tag identifier */
>  };
>  
>  /* IAVF_DEV_PRIVATE_TO */
> @@ -456,6 +457,7 @@ int iavf_configure_rss_key(struct iavf_adapter *adapter);
>  int iavf_configure_queues(struct iavf_adapter *adapter, uint16_t num_queue_pairs);
>  int iavf_get_supported_rxdid(struct iavf_adapter *adapter);
>  int iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable);
> +int iavf_config_outer_vlan_strip_v2(struct iavf_adapter *adapter, bool enable);
>  int iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable);
>  int iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid,
>  			 bool add);
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index 3126d9b644..5da2cd43c2 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -127,6 +127,8 @@ static int iavf_dev_add_mac_addr(struct rte_eth_dev *dev,
>  static void iavf_dev_del_mac_addr(struct rte_eth_dev *dev, uint32_t index);
>  static int iavf_dev_vlan_filter_set(struct rte_eth_dev *dev,
>  				   uint16_t vlan_id, int on);
> +static int iavf_vlan_tpid_set(struct rte_eth_dev *dev,
> +			     enum rte_vlan_type vlan_type, uint16_t tpid);
>  static int iavf_dev_vlan_offload_set(struct rte_eth_dev *dev, int mask);
>  static int iavf_dev_rss_reta_update(struct rte_eth_dev *dev,
>  				   struct rte_eth_rss_reta_entry64 *reta_conf,
> @@ -226,6 +228,7 @@ static const struct eth_dev_ops iavf_eth_dev_ops = {
>  	.mac_addr_remove            = iavf_dev_del_mac_addr,
>  	.set_mc_addr_list			= iavf_set_mc_addr_list,
>  	.vlan_filter_set            = iavf_dev_vlan_filter_set,
> +	.vlan_tpid_set              = iavf_vlan_tpid_set,
>  	.vlan_offload_set           = iavf_dev_vlan_offload_set,
>  	.rx_queue_start             = iavf_dev_rx_queue_start,
>  	.rx_queue_stop              = iavf_dev_rx_queue_stop,
> @@ -1365,6 +1368,36 @@ iavf_dev_del_mac_addr(struct rte_eth_dev *dev, uint32_t index)
>  	vf->mac_num--;
>  }
>  
> +static int
> +iavf_vlan_tpid_set(struct rte_eth_dev *dev, enum rte_vlan_type vlan_type, uint16_t tpid)
> +{
> +	struct iavf_adapter *adapter =
> +		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
> +	int qinq = dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
> +
> +	if (vlan_type != RTE_ETH_VLAN_TYPE_OUTER) {
> +		PMD_DRV_LOG(ERR, "Unsupported vlan type.");
> +		return -EINVAL;
> +	} else if (!qinq) {
> +		PMD_DRV_LOG(ERR, "VLAN-extend disabled.");
> +		return -ENOSYS;
> +	} else if (tpid != RTE_ETHER_TYPE_VLAN &&
> +		   tpid != RTE_ETHER_TYPE_QINQ) {
> +		PMD_DRV_LOG(ERR, "tpid supported 0x8100/0x88A8");
> +		return -ENOTSUP;
> +	}
> +
> +	/* This API only fills internal iavf_adapter structure
> +	 * and does not send any signal to hardware.
> +	 * Inner VLAN always 0x8100, so not set explicitly.
> +	 */
> +	if (qinq && vlan_type == RTE_ETH_VLAN_TYPE_OUTER)
> +		adapter->tpid = tpid; /* Outer VLAN can be 0x88a8 or 0x8100 */
> +
> +	return 0;
> +}
> +
>  static int
>  iavf_disable_vlan_strip_ex(struct rte_eth_dev *dev, int on)
>  {
> @@ -1453,6 +1486,8 @@ iavf_dev_vlan_offload_set_v2(struct rte_eth_dev *dev, int mask)
>  	struct iavf_adapter *adapter =
>  		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>  	bool enable;
> +	int qinq = dev->data->dev_conf.rxmode.offloads &
> +		RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
>  	int err;
>  
>  	if (mask & RTE_ETH_VLAN_FILTER_MASK) {
> @@ -1472,6 +1507,20 @@ iavf_dev_vlan_offload_set_v2(struct rte_eth_dev *dev, int mask)
>  			return -EIO;
>  	}
>  
> +	if (mask & RTE_ETH_QINQ_STRIP_MASK) {
> +		if (!qinq) {
> +			PMD_DRV_LOG(ERR, "VLAN-extend disabled");
> +			return -ENOSYS;
> +		}
> +		enable = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_QINQ_STRIP);
> +		err = iavf_config_outer_vlan_strip_v2(adapter, enable);
> +		/* If not support, the stripping is already disabled by PF */
> +		if (err == -ENOTSUP && !enable)
> +			err = 0;
> +		if (err)
> +			return -EIO;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -2812,6 +2861,7 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
>  	adapter->dev_data = eth_dev->data;
>  	adapter->stopped = 1;
>  	adapter->mac_primary_set = false;
> +	adapter->tpid = RTE_ETHER_TYPE_VLAN; /* VLAN TPID set to 0x8100 by default */
>  
>  	if (iavf_dev_event_handler_init())
>  		goto init_vf_err;
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
> index 23d115298c..c2f340db81 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -829,6 +829,50 @@ iavf_get_supported_rxdid(struct iavf_adapter *adapter)
>  	return 0;
>  }
>  
> +int
> +iavf_config_outer_vlan_strip_v2(struct iavf_adapter *adapter, bool enable)
> +{
> +	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
> +	struct virtchnl_vlan_supported_caps *stripping_caps;
> +	struct virtchnl_vlan_setting vlan_strip;
> +	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
> +	struct iavf_cmd_info args;
> +	uint32_t *ethertype;
> +	int ret;
> +
> +	memset(&vlan_strip, 0, sizeof(vlan_strip));
> +	stripping_caps = &vf->vlan_v2_caps.offloads.stripping_support;
> +	if ((stripping_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_88A8) &&
> +	    (stripping_caps->outer & VIRTCHNL_VLAN_TOGGLE) &&
> +	    adapter->tpid == RTE_ETHER_TYPE_QINQ) {
> +		ethertype = &vlan_strip.outer_ethertype_setting;
> +		*ethertype = VIRTCHNL_VLAN_ETHERTYPE_88A8;
> +	} else if ((stripping_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
> +		   (stripping_caps->outer & VIRTCHNL_VLAN_TOGGLE) &&
> +		   adapter->tpid == RTE_ETHER_TYPE_VLAN) {
> +		ethertype = &vlan_strip.outer_ethertype_setting;
> +		*ethertype = VIRTCHNL_VLAN_ETHERTYPE_8100;
> +	} else {
> +		return -ENOTSUP;
> +	}
> +
> +	vlan_strip.vport_id = vf->vsi_res->vsi_id;
> +
> +	args.ops = enable ? VIRTCHNL_OP_ENABLE_VLAN_STRIPPING_V2 :
> +			    VIRTCHNL_OP_DISABLE_VLAN_STRIPPING_V2;
> +	args.in_args = (uint8_t *)&vlan_strip;
> +	args.in_args_size = sizeof(vlan_strip);
> +	args.out_buffer = msg_buf;
> +	args.out_size = IAVF_AQ_BUF_SZ;
> +	ret = iavf_execute_vf_cmd_safe(adapter, &args);
> +	if (ret)
> +		PMD_DRV_LOG(ERR, "fail to execute command %s",
> +			    enable ? "VIRTCHNL_OP_ENABLE_VLAN_STRIPPING_V2" :
> +				     "VIRTCHNL_OP_DISABLE_VLAN_STRIPPING_V2");
> +
> +	return ret;
> +}
> +
>  int
>  iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable)
>  {
> @@ -838,14 +882,20 @@ iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable)
>  	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
>  	struct iavf_cmd_info args;
>  	uint32_t *ethertype;
> +	int qinq = adapter->dev_data->dev_conf.rxmode.offloads &
> +		   RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
>  	int ret;
>  
>  	stripping_caps = &vf->vlan_v2_caps.offloads.stripping_support;
>  
> -	if ((stripping_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
> +	/* When VLAN extend is disabled, Single VLAN mode which is Outer VLAN
> +	 * When VLAN extend is enabled, QinQ mode, this API works only on
> +	 * Inner VLAN strip which is always 0x8100.
> +	 */
> +	if (!qinq && (stripping_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
>  	    (stripping_caps->outer & VIRTCHNL_VLAN_TOGGLE))
>  		ethertype = &vlan_strip.outer_ethertype_setting;
> -	else if ((stripping_caps->inner & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
> +	else if (qinq && (stripping_caps->inner & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
>  		 (stripping_caps->inner & VIRTCHNL_VLAN_TOGGLE))
>  		ethertype = &vlan_strip.inner_ethertype_setting;
>  	else
> @@ -921,6 +971,8 @@ iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid, bool add)
>  	struct virtchnl_vlan *vlan_setting;
>  	struct iavf_cmd_info args;
>  	uint32_t filtering_caps;
> +	int qinq = adapter->dev_data->dev_conf.rxmode.offloads &
> +		   RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
>  	int err;
>  
>  	supported_caps = &vf->vlan_v2_caps.filtering.filtering_support;
> @@ -938,7 +990,10 @@ iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid, bool add)
>  	memset(&vlan_filter, 0, sizeof(vlan_filter));
>  	vlan_filter.vport_id = vf->vsi_res->vsi_id;
>  	vlan_filter.num_elements = 1;
> -	vlan_setting->tpid = RTE_ETHER_TYPE_VLAN;
> +	if (qinq && adapter->tpid == RTE_ETHER_TYPE_QINQ)
> +		vlan_setting->tpid = RTE_ETHER_TYPE_QINQ;
> +	else
> +		vlan_setting->tpid = RTE_ETHER_TYPE_VLAN;
>  	vlan_setting->tci = vlanid;
>  
>  	args.ops = add ? VIRTCHNL_OP_ADD_VLAN_V2 : VIRTCHNL_OP_DEL_VLAN_V2;
> -- 
> 2.34.1
> 
