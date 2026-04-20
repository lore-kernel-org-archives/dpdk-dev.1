Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75235F588F2
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Apr 2026 16:54:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59720402A2;
	Mon, 20 Apr 2026 18:54:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id C05714028D
 for <dev@dpdk.org>; Mon, 20 Apr 2026 18:54:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776704061; x=1808240061;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qYYilTMmcKro0c75sKwkRN8lum+YYP4jeUw/AuoSAsU=;
 b=Jgb7q31LVTJ9gqbLzCgyjtUffFB69ikjSMPkrbvpwfyOMGvCeR6OubWW
 T5Cii2MCn+8zSf+Pr9iB8Ak/WYlISoAOfN0I5FqbUwdFLYbtJwf4y59+n
 7SuaF+M9RwqOEy/DGsuhjHzvzkrDdVJMiMfMjul3wnsUIxihZV9iqq2Y+
 J2/gZ/1JpBbKVuMdJH7DbJCVMSKe1n6BeRXkJLmcAo/fALjRhHOThOtle
 /aj+PeoAxi9HTwh0ExdxZXV2n1roDr7NzbRJtHHUDmpBk6ztZmPtyAZxs
 tAXJk+9Gb5SIxTgpVGlDI4GKHoRs6LY0K3jJDKJs2wmH0jpATCEblx6qj g==;
X-CSE-ConnectionGUID: +lFDSWZ4R/yoBiBI1v2mcQ==
X-CSE-MsgGUID: 3pHQ86guSXK4BfvYuTB45w==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="80215352"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="80215352"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 09:54:20 -0700
X-CSE-ConnectionGUID: DtafRgTBQxiaWH5LSY0srw==
X-CSE-MsgGUID: bzOPNaQkR4GmBOWqk/k/3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="230738056"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 09:54:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 09:54:19 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 09:54:19 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 09:54:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqfvIGfz0eQxjKkmSicJKQbsW6Rlnm1mauSbooX1eA3ANMqObIpsoS8BC0S630juF7E1eG6TRM8v23wiQigYnqAwUUOmI7o9D8BZYbCUB9Cs149yP6FSbarIsi0BvC2+Izos51pCEoIp6lzU7cMV7Vy7t/aT+S7b1oxB3YOhPrUEo9Lmcuf/3OXWmHLlO950/UgD6w5BaaJhSI71p4wt6Us+bW8nPfHBltqjTZNfGEiDnEiEjSvwyof2V/DfEBNL1uCHs4v9cqrLBmH0aMQLnfI1DBk/e5UcSkDRBnvHc8K3xwrVHDRbS8UVLF2Gk368OPcYGfcmystZsiTC4sW8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxSrGx+Lxz5P/+fb96THrjlkY51FWHBszovVrW5KUkE=;
 b=dMVr/WFReciTK2+undGetN3MOvBDg23Qvo/1r0y9ErEZG3u0nyoK1R4zeK4Fhbb4VkNIMTswi30A/gAhZSztgecnsGQcrm3mnUyaU2rGIbU7wOxb+vPbyES+o3GK4zljb/3JGrUb7jsM2W8oodUD9iCcmUK5XuwQMkJtAaiwo+1fuxR0zOWe3uMPQfrzRsO0rF3SRf2o/c7C1lsf+Y39uR7VGZWkYunvo2+VF7qS4vC20jE2+ISMhFB/lo06jaEOA5qP/Jzw0cm01/6wrI0r2yMQQ6IxCHH1CAQZxzx1BDukemvm0dii0xofZ4oTMs6dspLXaUGv1JTq8o3KXM0g/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 16:54:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 16:54:16 +0000
Date: Mon, 20 Apr 2026 17:54:11 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH 0/4] net/intel: demote path selection logs from NOTICE to
 DEBUG
Message-ID: <aeZaM3DNu8GP0H58@bricha3-mobl1.ger.corp.intel.com>
References: <20260420062746.178145-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260420062746.178145-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0195.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW3PR11MB4748:EE_
X-MS-Office365-Filtering-Correlation-Id: 708808da-a0ae-4921-698d-08de9efd7521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 1WVtsx7Rr5aKuQd+c/8MYAeiuKrVNIBgojYVWl4lGjH9MKcLP80hq92eJ8/d4BKhu4fqiJtX0iQuE9zZI0lKvNnhPAKB3n1vkWMnKgVdiGDO5t8vdaMitPTBXTc9kTI1pklRVlTNsJQGIkbMtr73kWoReBt/zzqizjFkTP6ghMc9rdj8w6MDQE0pl4P+6ksvijhSX1afyuuCAUhbWrFkY0Nz8F+pMpPG4g6+tUBw6rGnVv7vnGw6UWQDr06nPFkynyy5a/ueDK6i8z9Hikblz+rHBEEgAIWrlYFkALe7nRXk/jY9KNehpxDaCrLulWYILyv/R1l3VqSwRlt+gAnMLrTax9N7pB/zjJ1YF9x8EirlX5UqATUWtlvhHPwT70H9ogncD9ME563QYYPsY+DGcKqAFvnOG/7GwyfYHotn/3pK4drmqyO6rK5xCBJOLoWetlPBY2Jgx0IBOclHqq3LiLNdHgZYuUwWlDvZimdTteiYsqQaBay3CKDdHdXWx1NCO34efoj2FmLk+a3da0FdqwVwfL/nLG6DzY0bsmAOFrhRlpiogDxbSKtHPHPdOwW7399V9hN56aNeXLtf9Arb2g+duDVQ4j7VRRrn6JdW+2D1JJIzO3zaccUm2Pw7HO+eblbBuEcEKSClGD88+frHqNbzZyNTyELuXgqCadwlraqMUjJlkK2/rbQr/dLW8BzScrAh3ZflAZd0c7gS38lXT6PcSmSP/KQP7yq09OGc+tM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v2A50DVxGzNN3Hm9ihjgpOBe9n1rxYpqSO5EHZuriMc/m22bTFWnHNMqT1lI?=
 =?us-ascii?Q?Cpbqf0jpRIV7bWOgCAQkcFGJeeipZG5VtBRv5uWfDoo0VW5Q/FyGC+sWQRE7?=
 =?us-ascii?Q?fhEyOQeMDGS5up3YUUTW1bQaym1qbllsT2ln166sXvykP8uDxwftk0HsXFGi?=
 =?us-ascii?Q?6mt3Z5x3pQKuH3MNKF6L+5JIn4XCyGL5Bhds0sJZx8ZArCmt4q2LbSZ0vBQN?=
 =?us-ascii?Q?4KtyWVH5V6UJWBHzbI80u8uNZVPwiaQJU8NGpAyzeFssYjXO3xnO/CeB2ab2?=
 =?us-ascii?Q?jA1YPcWlLcJz/L9kSORiL9EIe1LVIvH4DJ+p676UVvkAHCUpmPPmyN7SHuYI?=
 =?us-ascii?Q?40mcdgXaBvu41YYUgGyLrqqXhS2bCIBQYfkAZSosAMDyey5huDHZhkFmZfP1?=
 =?us-ascii?Q?sGCt4H+7PAI08JV4zMj9OD1gJzT5Pze9WM7OpyDlK7SwaQtZW3jsQpmQKfUw?=
 =?us-ascii?Q?MklB8BZDj4iCujbCWGgnF6Gw3QPP72T74AuALKqSmzO28aj4l4MdFILePBEZ?=
 =?us-ascii?Q?/w13Hs7WzA69N0PU1r2NGrdoj0NtK25SfMe3EKyapWk1ASXIHJeX4azj002/?=
 =?us-ascii?Q?fd7mOOmq56iue2ySrhQ9/xpMJiunOC44GQkkDvIuUkiT4SPR9XiaFdcCQHeG?=
 =?us-ascii?Q?4pmdMKnOg2fNndGdDtC1bBslc31SMtThX+tnUhTfsOHCvsrWAyDwH3EBB9+j?=
 =?us-ascii?Q?lrJarM62IROLsQWAgKTbYS7u7Fv4wfgQovFXTHK307+yxudvxD1ajz68z5oo?=
 =?us-ascii?Q?7DpZGgltfmQ9flRAuWMWCqoR0gzP8ITABTBBFJ5rTIPkcjYJNByqGHoTYJh2?=
 =?us-ascii?Q?R97cEwC2CF+jmeBK29UL5vo8Q93HX25f3D1uERTBi6NMQGJp6YRcwqTUAb1N?=
 =?us-ascii?Q?yqyNOH9f2Tq1w2v5ZAe6cDmjLZKj0VShU0dGj2M5Ad4zxg33cUudOKLwnkFh?=
 =?us-ascii?Q?47TzYzBMjZpLC37czPEkKKqHhQxrt4zNN3UOam99ZXGty0oYOi4goYp1BsP9?=
 =?us-ascii?Q?LQ3dWTKXZfgYJLgA1QkCF921/fyT7WINXUmVpmLRLR/IkL69l322s0OzGnaQ?=
 =?us-ascii?Q?omHKi4v2f3Oiqwz/19cnsmbqzeKsxWZEa/Sb0SL/8ZAhrOPfoiEp4B6jD9U1?=
 =?us-ascii?Q?umw98yfiO1Nt9cBjCjxlYf/EbvsWSREb0+qy1ucPg+q07rZ9sJwx2IFlVDhO?=
 =?us-ascii?Q?piKTH/Dw5LnCYWOPVO11S4JKHFqmsEWiNf6q24R1rGlqS5FVQKeAv43CmtKC?=
 =?us-ascii?Q?ZVXmHu77SDd2TX7qM/HSSP0HbJbhjAKMY848GyylbZtK7JteHfb75fj9vAnA?=
 =?us-ascii?Q?QZR1YsUFQJQJSlBOyufmDrkNEWLIE723bgIt1Dt/KdjtUDHn93LkvFLjITIu?=
 =?us-ascii?Q?zuV1lZy6BjtMlG/IIEOeJnomtzzMuEf7K1bIkObOeZuBQjLn7s9Y1KcqUsPQ?=
 =?us-ascii?Q?kvfD5TSI4tZ0IgFhiAxNVCXMMMiwwkJTvaJGjrk0Cj8GFBu2gyBe41asqTry?=
 =?us-ascii?Q?zgeh5ecaCMENu5Dp89V0os9FlapHPKCV584nOiU7IklDEsQjEPrDJ2XZkhRI?=
 =?us-ascii?Q?MuQlfLFIIj3FsFLsZ18V9OphTOrUoNLoYqku4IpPchNzOSGAiuboX1yATgxu?=
 =?us-ascii?Q?xEOLI2Zqs9fmQIeV331iHhjrTgY+tg0obTOq161V7p85lXWisTHfZ9x12BBc?=
 =?us-ascii?Q?3vu/oQLWzFNGCS6Einyia/+Oo7bpSbwYEmwKp4Tg4VoAWBcDesimTiWJM3CL?=
 =?us-ascii?Q?faMsuw/BSd9ozQFTtPG5W87WxCQcUjc=3D?=
X-Exchange-RoutingPolicyChecked: aBybf8X+r7/gsA8BMyU8ffo+n13oqFcfnpPHd+Ogb9/STskAW5yA0AiQDxBxgT7rJReMF3AUu8mcuOGFJ7V1sbIexTivfl8a49PEnnB+wlZnxiYaPjBr4nlTKHlesVO85K6H8IAKCmP+VU5eOWjG+dNW4RgfWqyzQfDJS2Y4i7CacTERpjJF0dvnFHkOGClf2hG/66F9olObxRHN9bva9EGQ++9zSe5Y6D5T/grgAD7ASimZH0Nyt0DnmaZW7X3Yxb64bzVaG27vXnqADlvorRgdLnVDttagSP/Vi2bjKT2EmqxMYcbBJdLd4xQp8nj4KDmub+LkbT2Ok2YXqfrVhA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 708808da-a0ae-4921-698d-08de9efd7521
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 16:54:16.4687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydq8lP1q6+752fjpY9OwWe3IXpYfDmGT4eM0uUByhzAQo1I8TAtCY8GTMJ1GfIAxiZrK3HpbNA7ahuM4UH47XemRD4ptPIDJ3l2yl/UyCn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4748
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

On Mon, Apr 20, 2026 at 11:57:42AM +0530, Shaiq Wani wrote:
> Demote Rx/Tx path selection messages from NOTICE to DEBUG level
> to reduce noise across ice, iavf, idpf and cpfl drivers.
> 
> Shaiq Wani (4):
>   net/ice: demote path selection logs from NOTICE to DEBUG
>   net/iavf: demote path selection logs from NOTICE to DEBUG
>   net/idpf: demote path selection logs from NOTICE to DEBUG
>   net/cpfl: demote path selection logs from NOTICE to DEBUG
> 
>  drivers/net/intel/cpfl/cpfl_rxtx.c | 4 ++--
>  drivers/net/intel/iavf/iavf_rxtx.c | 4 ++--
>  drivers/net/intel/ice/ice_rxtx.c   | 4 ++--
>  drivers/net/intel/idpf/idpf_rxtx.c | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
Reasonable change, to match those proposed by Stephen for i40e.
However, I don't view these as bugfixes and don't believe they should be
backported, so dropping the fixes lines and Cc of stable in each patch.

Series-Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
