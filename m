Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C974E7E371
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 11:11:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 228D840E30;
	Fri,  3 Apr 2026 13:11:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 2F55C40296
 for <dev@dpdk.org>; Fri,  3 Apr 2026 13:11:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775214696; x=1806750696;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=iXDvRE7WNwgTbFMJhAGpC0oPjSjni++m64JetKTxFSw=;
 b=nOVq1/ltW8H2xx8QqmqSdOIgvlCR45OCm9w4nl93gvyPJxDcaN0BcT6s
 cxdNgunBBSh8fqyaaD+W4FWwd4ft6hlHpgxSqErfSjqQ9Db7GyOTQzBw8
 7tD5I13tllKI9B76d7xYcvyB7uZO8PtQ6EKPHKc4303PP4vqDhKhs72Pb
 RJNcRt4h15QGA7I51Zz+9SNNfneM0k28oHWVeeEAQjalo/iI6DbBt531k
 q0Y1qL3BfKxcMuLSjWibiYg32Yr9XTzOyeg1T3lLTsDV8YxrJHDO5DOvP
 mhjm6r400KQLqSI5fQT5fe9Adwct3LnIr9eaweZNVhH1VqspKz6JpwbhI g==;
X-CSE-ConnectionGUID: /y3aIYtPQd245cgQLA3fXQ==
X-CSE-MsgGUID: Mc3N5/IARW++n2SW90A0fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="86981959"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="86981959"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 04:11:35 -0700
X-CSE-ConnectionGUID: 4HOg/4LYRQ2/8tux6nsJgQ==
X-CSE-MsgGUID: qTA60Ay/TGiLT83uSDZm+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="231627454"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 04:11:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 04:11:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 04:11:34 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.25) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 04:11:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ke4kQWu1Dqzu2RKXU6lmpXJfxLOO3cttRrr+Obkbc/buQ8xrLOviFQbCzyi0TMuSBycxFlnWrFTShGDbcVkghrsJ0oqdqBkMC1UqtgHvBlKI39N9dumErtkGH2Ej7LduhAWMCiKAsbfemrhL2WrToM0sCDgaizfJhyHFd/iZ5wVSvPPvHI8w+vY7l059TDQ8EZNZMFey06torHST8Ka1fp87gKbcMVdDKHJ2AGI9MnUUz84SdqmHoLbGXMqZAMWEB6tNl7BK/INjDUyIBebN5ExSg5HcyADKS9qWoIO+cU0EZjXV8uoV/N1GuIJkFcZavelvNkkV+x5CyGqAm9XgOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNLIkln2v5O8oTgUfaoqWFRqbXI9yUwwpiF+VObXKzI=;
 b=D1cV7HwWyE4xQd9XUCuxGu7Wo/qOG3uaz419XvqLtSig0KxbygmHskosd7rGeB82l4wcLvVhgUrCgzjIjRasI7HURazur4PBxXnRmudEP07Gcb16u1UB2YBozHMn3B6WxScn5gegrlSSaLQrhP9oNyDGxNVaU7Jmj/dIjGj3ksb8SStL3IZFTghPMNZ04oNmc74Tc69Gv2778aYhjtusPzbVx4tpgb6kBvaiVRez5uCfAlfq31C57ENLhTy7dBdlx4PDTHEsP6++VmqQthA0m+RgKbZWrYLzORYlQ8xaGd2WWRSMecYUlhQsyxEZbpaouCg0fm2fiwYJiIBkAfE45g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7357.namprd11.prod.outlook.com (2603:10b6:8:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 11:11:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 11:11:31 +0000
Date: Fri, 3 Apr 2026 12:11:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 8/8] net/iavf: embed virtchnl response buffer
Message-ID: <ac-gX8vByZoxxxJm@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1772794442.git.anatoly.burakov@intel.com>
 <cover.1772794442.git.anatoly.burakov@intel.com>
 <de81dff1166f097129de104ae46a04422313179a.1772794442.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <de81dff1166f097129de104ae46a04422313179a.1772794442.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0127.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: ea31a9e8-ad75-4ab5-403b-08de9171c2a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: ccPyrx/zQ977dOQoxb4WbkP0Hi0zTiUa2oFhKPPLnp3zhM0IzzFI2GDjrCXeq1UXSEeeQ0J9HE6hs3wgVufnWdG2KLYIIi3+AnuhmtMcPdRad3swTN+hf28jxOsLyVhos2mUbLJrzC2lxJUqeRbfrFhBILesYB6dEO3Cm2aPAj1ZX6RCJq3xhsrANmlexljJjK9JlhWraYYfb98GLVDaWjDDAk8twCkTZVNC/zDiPPK8LLjuuwhZHWI/edLLbedaZ2xAKaC+2nt174/2sxoFvs9kjpZp2ybtBh2w7ZRo8O5Ynpcfyls6SJ4u4EcGZ/gZ01W6pf0TVWX2nu4A/CblisIfKQWUYawwTrgIX1KS1BryDw3mkgaF2vx8DJAnZzi54eWe9Ddu87CgKUgvPBXJC/RYPalAROP+vsVYP1arMbmPcpnCk8qeZlR7Oj8m9EII3L0cnfXIj7ti+oxksRRMmInYeg+ABsRWb0aE4I4Htwrj9JMiEbs7Hv6E8bZvlIEOjpeZRn79yDBRuwsSWFlJGehehqSHCdK56u//2XDUhW7DF+BS6iM/X3SeimNLEVy61TdImZYU/6Gtp6WgEE+SsGJEeuT8zU45X+QcQSU7KYUTOXktBJnlCxgEBpk2IhEq+lwZRG/HIb5+bTdM2LCfMvvNBEFdbYJ7kW26F/bJbcDE2sxpKUgorBMxaWfa6d9/bICRct6ncIYydzZi6qM2AyrQpNcGCb1CrUNzihinTRE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vinvg8jOX3NMyrugRcX1iG2jOtbJRH3Lkk8bVDFdXuOAzizioiZp3qDyP692?=
 =?us-ascii?Q?oKCDnKI+yMFfdoLpgZRpj+nKhaLm1n5k4DAZjRvtDLk2dVqKNG78CGc9bcEc?=
 =?us-ascii?Q?0LNa+9QIYmjbJizZVwp2NwpSR0Qs8huM0hxx7ZCdhxB02e2iNg9WH9z5+Lnv?=
 =?us-ascii?Q?oypjZgeUwURHsIkLTdekdtc1NcnCkTp735NdjtabaKNanWAcgr7OOsp+1sed?=
 =?us-ascii?Q?kDhr3aOVEd69ZH6q3rS7IC9PdOtQkhBQfzn0IAIct3E4ebIpWPvsU2UGuDaP?=
 =?us-ascii?Q?ESzXPDklsfbGcezW+ifq7fi0UPadMgfG194FF/8/5WR8SZxnRr89ui50UIr5?=
 =?us-ascii?Q?JHuZNBL9fWWTGR/s8mQTblT20rYmZl1xj1i1Wl95urVpcy3imOG5NlxQ+0Z6?=
 =?us-ascii?Q?PQta3aUBoO5727oiwYjR4AzeHoSq4imwm9pxbpzrAHF2FkSU61BhzHb6VLLJ?=
 =?us-ascii?Q?FJ4aNuHnXF719CQbge4kDKyW4891ooX/dB+Fu18as4JnbNJcUl1M9+bNSm0X?=
 =?us-ascii?Q?UP8R1ItuBE/Tu7eSTHclIuOBIjGzvTgEyIUo8BNjvAREWkUq4zO+JyajK0Gi?=
 =?us-ascii?Q?a6dLeMd0/riD4Mw2z2uGg5s3D5Tg19T/co40Dz1T1Nyd7xnjeQKcnOqCWpJT?=
 =?us-ascii?Q?7WPrkVSM9Vil+qawSKq/te5yAeHDZ/f+6Ovaf27VI+rrswRWzQ4y+Ef/zuaF?=
 =?us-ascii?Q?tEb1I/Q0RYAuS9lv3QrrtOIc0Nvpo4J2mXtBEX0z6ktcAFAgHhR3lkMhg7Re?=
 =?us-ascii?Q?zr/UdnBIwY0PdUdLq+JafOM80kWd7hAMdxO59NwEqzDZD1C3IS84V6MSgWt1?=
 =?us-ascii?Q?qfDvvxaqNAf3FutPiJ4Q6k7h7HvK+O8maVLVRGIq5dvMmRzgkZvRwPuvImg7?=
 =?us-ascii?Q?qXP8C19n0QjQyPr1hmjE04f9kBFj48Jov5Gi049jowwVYsuo3wn2KqA8Ekx6?=
 =?us-ascii?Q?4rgoxMOhRVo2PHdsqRFvvMAB/5TMjWd7wNFKyNSFHpopVkw6gbCGWletOS84?=
 =?us-ascii?Q?D49zS7Qcwp1Qq/R+H/kXGPknP663n/tXoxFQBj6Fmdqb0Ks6B9J79C0zJsOE?=
 =?us-ascii?Q?1cHuLOUvVpXlpXGgO/c8wCewEELWTAxV2rDIqr0ZB1QAh3RsmCG+ghxmPfmk?=
 =?us-ascii?Q?iE0fdykwRRXHSxAGyFUJKsEQ6yGmX/ZsZLbsuGAmwWE9/pAA/WlinNDw4TtM?=
 =?us-ascii?Q?MoIhCjn0toEmVTa7silVHTSHJ+5R3+uU3DCbsxWRkzHqcGBdxgMyaWLIky31?=
 =?us-ascii?Q?tcerhFpTpMzbZL+6pZyj2BBpo1Ia+tgd4VQIdtf2mB1UVOOzHA2e2tl7kmko?=
 =?us-ascii?Q?k8ZjVlB5kxPH/FZMfGa3Ey+0uYDzY29psnikE0VdX+mDbbyEkH3ghlUslzBI?=
 =?us-ascii?Q?idSec2invNZo3sjbGO4KuOJ0bS18XL52qlgZzRzz30F7AEsdeOcfy8lGJDtt?=
 =?us-ascii?Q?HXNObT6z7c8sMc0BiHZ6PVs+XuZL/gyaFDubng1HE8uz0hzm9+7Gc7r59mUn?=
 =?us-ascii?Q?tsGBTXnW6m4lJ8lboUmO+5ylE9Bzipux/Pxu0l5jfbBOJMTsU361c0REa1Xv?=
 =?us-ascii?Q?1giv4n7jItwib0RW4eElP/BqcIVsoRIftwTA1XvSUpDyr0fWe25UCCRR6BL2?=
 =?us-ascii?Q?0ppDM4W3fNajQz5BlDm+AwzSLSSkLnjyabXn552BbqWFdZ+NvSi1rxcFSxv5?=
 =?us-ascii?Q?FXMvGY4breEVqdU+3SXd9bljkd3viNRuJcB4hj8LXY6lnP9+ARJBj9k0OpQc?=
 =?us-ascii?Q?HnnLf/wFnjNcOuBN7tdx1cDBbQ2UlC8=3D?=
X-Exchange-RoutingPolicyChecked: FJ70ulfiXROJSGzMWunwYg42qa2jyx9Gi++Zg7uhZ7qHkyXLc632ThNCsIksCW0qYgU/WRKjbwx8ErN5v2D1VWH/+QoovHP3bconKM403SclGTbdl4fW2M30HZQYejzYNz4UVfclWNYj/vvj1IKNC8AgDF5AII1vxA7VpnZrqeF3dXxYlgYEIMpACdZsxXKNKREY5BMqkEqjPf1sn/PloxPhRVDg035VZSVzRHpmYiS70a7ud7oJ2le0sK8MBG9Yi2VtYFFsGDt9OAmk1wDdKX0tQni/Nrx0WQVkxj1tAJ2d5LE5TIRCiUKl3wiZM0XpeFnUxYYMe2mKj+viKyZNSA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ea31a9e8-ad75-4ab5-403b-08de9171c2a3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 11:11:31.7293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgQv1K4Awhg9IulK6tbHGNz1oweGDxTCbYyNkiDeVNHSdOrxhUzB8wp/hCx3ZZxLHO8OYNKfi8Xxq2AB/3aZ0eGJ+CeGVo2QCJgigNNqFac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7357
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

On Fri, Mar 06, 2026 at 10:58:24AM +0000, Anatoly Burakov wrote:
> There is no need to dynamically allocate this buffer separately as it is
> fixed in size and is always allocated for all driver instances no matter
> the configuration. Embed it in `iavf_info` struct.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf.h        |  2 +-
>  drivers/net/intel/iavf/iavf_ethdev.c | 13 -------------
>  drivers/net/intel/iavf/iavf_vchnl.c  |  4 ----
>  3 files changed, 1 insertion(+), 18 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

