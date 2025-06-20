Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E13AC7115D
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 09:16:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7726942EA0;
	Fri, 20 Jun 2025 11:16:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 11DF2400D7;
 Fri, 20 Jun 2025 11:16:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750410999; x=1781946999;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lrSevIzxz2J1zRU650T2OYh3vAr28BRJd5+PDcYHZEE=;
 b=WFoneqH8fVxaxwS6wqB5PCbVCOpndUQY30HpPDrX2q/gDP3ecdDoiyLy
 g3iokAZVIgOs0K/5iS2rGn0E4eczNyE6HFm95kDccvMScn/HnWT1goaDj
 Xo3JXSW3Qtk4y8mLuB3DY8GbN1ymva2xbfcpQdhQhHCi5UFZk4xkuHsHp
 dZ/CCO/fq6oo5K4ijNQ9pdz8F5QYsZDnHftKlNkyk5TwXYPAWBk7EVKZ4
 /rhF2mM+hQ8xV309jTTFy4GDaFWfufHzWCDCp9vvgHGjd+heEb2gpiGn3
 +ajLUBSmiUfJdxkFpMVbAMjBFd3Zyp/fjnTYceGXH1aEvrURodQQnDH/y A==;
X-CSE-ConnectionGUID: JPOQ3P9jSiunIuoxvIc0KQ==
X-CSE-MsgGUID: aaVgm+cAQ0SExsXrL4ZHRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52596954"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="52596954"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 02:16:38 -0700
X-CSE-ConnectionGUID: gBPsl5I+STKHzdzgFR6fuQ==
X-CSE-MsgGUID: 1G6agZpJSCGKtH1vlA+N4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="150458425"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 02:16:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 02:16:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 02:16:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 02:16:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJjGxc+97hUI+pIIIg5KccFBIFy06RRl+rArUJHMWW1BmftmWCgEariecsg6yzpQyXSvNntF4VphpZyO1DvmB/WEdOdbTGzAt8JzSQczYXFZ+XUqUGdTebNCb2olRxlbG6swID9RMkKlYigCVsBgRLUaf/1GeFPDqFVSKBGQNMrQB/L4r/0g/QKeR7KJbplspmGEH4Ry1474gp9UVySyu7d5E6ctPh/CtOxZBOhzUkTE65uJjLPu8oKaoaJcMnHhMK6TntsE10NhQ1F6u4cAF5n0uEe07RwB/lyLWyO9iAPBxzj9bAI58/MtbiUnXwTE6G7/IdO8WV+lTI7ElzPcQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rs6OmMxMuAntSrREdzj083doClrZuGj9VRYc/J8Yjz0=;
 b=oHfH14sEpfcVs8oeiCTQjDyCuOn3dq8dL/1u/OTpP0pXem7kLT4ZWGgEOptyL6C8HLYEFmPszZMUuv9aok2VOwgotj3FR1mlfsWRxJ2hYdiz1I8ODVSO8qrwCPwKtEWxqzr+VZYuCM1xxtBadR0XbqWfgAVChT7Y6C8oa86J+LQeGpLrYOC1NHEkpFwRIvLQvzYnT8bK0cY7O6358wpY40nimVDYYRqbOscfhaNgjR7ogSIMosQNXBlzGLw5xBnjfPzANaRB0b2CL3MgZIz0XbWYO11x2LG9PyYZetnWM9h4LtAKv+f7/mS6h4v2EucM9K9Fwnq+UHyXFWTcnfnsng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL4PR11MB8799.namprd11.prod.outlook.com (2603:10b6:208:5aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Fri, 20 Jun
 2025 09:16:28 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.020; Fri, 20 Jun 2025
 09:16:27 +0000
Date: Fri, 20 Jun 2025 10:16:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 02/10] test/telemetry: fix test calling all commands
Message-ID: <aFUm5iuof9Lt7cGQ@bricha3-mobl1.ger.corp.intel.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250619071037.37325-3-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250619071037.37325-3-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0155.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL4PR11MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: f257fc83-903c-43e6-abbb-08ddafdb22d3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fNs8Fv0+8CiWL4a7qZ5gfjAcWV5PVo0Nwty+4ILUaOfcWpr+Ernl/a9laHyJ?=
 =?us-ascii?Q?EoSgTNzYfvxn9GaXuzlwTwsd4p48Itu16to12qDBcPrS0BpfEjE1UKU2wotg?=
 =?us-ascii?Q?3kxEo4svi9Xp8taIxjO9vnQTDjsBEz+MLDx27CQuvRCYfaFbq9na99ytGdmO?=
 =?us-ascii?Q?lufLggkZOY7OCEDGoISaIrbk+YHWTx3Ms+K5MhHzo4jjHR8bn0Atxie1iOl3?=
 =?us-ascii?Q?/HbpcvLmxUwmP+a3rTwpfevALbaXJnncUO3v8ET2iOpQTOcCwm/aHbQ28Srk?=
 =?us-ascii?Q?7wYqDmdyY5ZhBtI1F67nDISmkJS58kzaoV072QRighvl4XcMxzKasM6Qq72Y?=
 =?us-ascii?Q?yKRmFIMIzE/ootXEV4+zUAlYR0BQiq1z2o8opKym23PJuYJbu7+wx61WplJE?=
 =?us-ascii?Q?gYza6VlA9rGa9YPeqELh8YykinMBpVvaSjuFyy80YhoXxdHeeC0VjpOsSuzY?=
 =?us-ascii?Q?Q9rGdQO9qYYOZvMQwemwziUbJl/SWFH1la+EaAOfijtJzvCtR4NQuON8iB/2?=
 =?us-ascii?Q?t4G8UV8gsBjnkc5saF0pTzdYQYuUBaqaD6CiE2VOtSLcMc4JryEt7a5LWKxk?=
 =?us-ascii?Q?LojIK8iljRPGevsfNPXhmaBrcNn2da/1ZfbnvWthfzrhbGUmpGiP8HTyzlcr?=
 =?us-ascii?Q?h54SwvmJZqzIhO/erg4EQM1znylKN5NqvB5IbpJ/XIpMsYIoHkxBuiC+neYz?=
 =?us-ascii?Q?8vCgnCq0F/l1jTQD/pF7qV5NWWnl6k86YtIedWgLDxb1f4viAhOh4heckKhg?=
 =?us-ascii?Q?LXYDH3DNozwnbbnpid6F2ASF9XFCbiaXLvhrmiG+bgR6lEAeljqpAuTkwKOv?=
 =?us-ascii?Q?8V1UMJwzx2M/2HjNtMfYsHJ0pRMQNWMJMppIFqlVfSA29ZkR5/kcPEhONedP?=
 =?us-ascii?Q?WouMM1u9u1l7cFr7AKLmS6m263BeqVzBpk6aZE4jiYFa5WhYUBPYF2mnd0w2?=
 =?us-ascii?Q?fKQvmHPR2a8Y4wuwd4wSeq28jvFxPsR+1er89oCE53sVGwzGNUytXSpRdPPB?=
 =?us-ascii?Q?+5C1JGr6iuhxubVAU4FBzUoAFljc5KDToVAQ7iSljY86aNpiiFzAaT3kI6Pw?=
 =?us-ascii?Q?7D0h7YrCJPJxCtFgbCKbzsV6ZGVhmTJd6UvHuGbfMEsnYqX8ud6grHpF6QE0?=
 =?us-ascii?Q?7GrIZL+v1phJEEeGjn7m2+jqbO6AuSjZj8MyyvUV2zw2DtPMW841Nn84u6bs?=
 =?us-ascii?Q?+Lbd/BM2HbRNa/wg9spnm3aWpkGYX7CudNBZHZJH36Rc6Q6y9nB5T5AlWR6V?=
 =?us-ascii?Q?fDxIRiynZLL+pe1HnJNFdnqTb6QhLaXBkQrGxy4UftoznhNUfTm/myMuZa44?=
 =?us-ascii?Q?TexSV6twpQKirGihSr/w/4XQdYf4gkn2IY9e4RAqck+l1uSriYpl088IE3Uj?=
 =?us-ascii?Q?X6KmYG3UhDTFTM4K6VBfLjDsEfPdl+CYnbdzuLXHtWXEueJMxiBDG7XXu8Ld?=
 =?us-ascii?Q?+Db7Nv7Kc/A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PQQ3m+08wqAcyMTuoyGehcHAtC2id9Q/CEpoBdrfLsAg5DEHZVOlgyFwxKBr?=
 =?us-ascii?Q?6vRmmAh2o+L3u9svEOeyBx8H33cx0OxLX806hZWsUbjxD1uJxkSxqCS4O2Cr?=
 =?us-ascii?Q?H5Hp+/9jKRyPgC9RsUZQpa3fUDdLp1UJtTwbGtwOWrl091clpC7l4/mLGGm6?=
 =?us-ascii?Q?jYZPZv0PRPsjpecgwCDuWeBiJkwPa4dl5QurIbFrkPUiPbINeeKrp4nGHMsB?=
 =?us-ascii?Q?EhXejStxVuA5y6DvRkKjRm3SZ/aUOlDDl7OiUoM9gtYxRPpcMWt4AEJ4wRoc?=
 =?us-ascii?Q?lNbo+RbMqpoddSQ/4iyJ4Rf/eq54hvzAz9rlosXgXAA9/7wID9PHXpfKyjAP?=
 =?us-ascii?Q?2infape+KSSRA4AZ3axqa7z6lyEJLTqHzL5adZ2PPDZHUAKCp3ubPcMzWPkF?=
 =?us-ascii?Q?9nosHJyh5iVqSheQx/0Ao87a/akYeKR4oX4BuK+GYXC1DuAVmVMNkH91IIao?=
 =?us-ascii?Q?7nC2V2D8mV4VZvtA/Ze4RTngKG8iwPYnfEkTmtrxvnJ4ZVS+j/Nm6Zq6nntD?=
 =?us-ascii?Q?KdsCysDFtuupr8m37/TLp0aL094VZRx/wo+1hOMtuiX1sT/MqHNowkn9pkSG?=
 =?us-ascii?Q?o5hfvc+sUnDGYbCBkKMlHg8yXtVoyXumoqN4ycdtYzJLCeZU5QuA6XBTNox3?=
 =?us-ascii?Q?EqPCENxJdP+CgomJMwUUCB/mN6WBgpzPStS29VUQtJ5yQ5oV3dCdPXnvtZCF?=
 =?us-ascii?Q?6w9Lbp5TJBxl4x+7YpCYwxodt08JqwpwdPTG0u3Zdei1SG82DjOeReIZVgfJ?=
 =?us-ascii?Q?gK8gICDByThToFTJqOWxeew2H0aC4VQbCdB3KKemjaxb9qok0LO2goOMAwp4?=
 =?us-ascii?Q?Rsh4cajMz/EF8t/Rvbgk1vuT/DIM0QtgXsmKGOBe7/88TX1o/uvUruf/sl90?=
 =?us-ascii?Q?ISjrfckL65fzzHRvU0Mh3ACS4PMFkL0nbjQuuNRercCToUiVb6zy64jOnjwS?=
 =?us-ascii?Q?pClyVAnBK6pHZmSZG8ZRMuVBUiIgbEnhWpWVsNdMi84FAyYdJv4p10gHn0ze?=
 =?us-ascii?Q?LKqma2z1bIxitV7EmOAKZuAvLgO9gTQhn+dfX4TsF3yrZD2Py39pb+akOVpK?=
 =?us-ascii?Q?xoWAxkZvrVT2uGBg1u6+Fdfy5HqWkvlgdKww2nuC8Xuys8d7rFIOYY+G9J9o?=
 =?us-ascii?Q?7j/Mcbf5W+kI7yy2bMGnZHIB3+R0d3P5VDkNsc4LtDBzaJd9slkxjMTXCVWm?=
 =?us-ascii?Q?Vr/xYQ/8q9CbpypXy1V8+W+Tdb7jZO5g/8GlW+EfCUDjWBqE5FOAo2KdAzay?=
 =?us-ascii?Q?KvfEmp5womOtnxxzR/sDmb38UbnCyh2HI9NDXIketjXOdhaveJ9lQB+y9wQl?=
 =?us-ascii?Q?T0AwETsSUAMzNeLtfOytxCCuGlCS1pmf0MZVmcle9+0Jr4UNca4VZYUjeSuW?=
 =?us-ascii?Q?AwulUZlgE//E32d4LdTdDAvF77TcHKo/obMZalLQdEMCFbgPP5Wi/5S6JEwb?=
 =?us-ascii?Q?ttTkutrisBy88VHJdi/+5b0+4PVskf2iSmakrQwB7K7qYcDRUlAe3UF309J0?=
 =?us-ascii?Q?I/4I0KQVZHMsqcYLGtqMYSDW7LhPTHHbsNtyuYWnBuAS++gak893l+l+JZ0p?=
 =?us-ascii?Q?vtXKMemROOQQU1aexcMg+AWBAldiKW+De5+XmR6p3leYRCpvLzIGcG+l/3L+?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f257fc83-903c-43e6-abbb-08ddafdb22d3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 09:16:27.4774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvXfyCmEC7gQDOIWAQkJVqzd1cf0RJ0txv3gdDZ9t30MSzMTM6Vfihg8e0RqwPDd8aruBpPqShTcdmYCqAGpnAZFGq8OIuRri2KaoKoWBIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8799
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

On Thu, Jun 19, 2025 at 09:10:28AM +0200, David Marchand wrote:
> This test was doing nothing as it could not find the telemetry client
> script following the test suite rework.
> 
> Caught while looking at UNH unit test logs:
> 
> /root/workspace/Generic-Unit-Test-DPDK/dpdk/app/test/suites/test_telemetry.sh:
> 18: /root/workspace/Generic-Unit-Test-DPDK/dpdk/app/usertools/dpdk-telemetry.py:
> not found
> 
> Fixes: 9da71dc4f96e ("test: add test case for scripted telemetry commands")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  app/test/suites/test_telemetry.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/app/test/suites/test_telemetry.sh b/app/test/suites/test_telemetry.sh
> index ca6abe266e..20806b43e4 100755
> --- a/app/test/suites/test_telemetry.sh
> +++ b/app/test/suites/test_telemetry.sh
> @@ -7,7 +7,7 @@ which jq || {
>      exit 77
>  }
>  
> -rootdir=$(readlink -f $(dirname $(readlink -f $0))/../..)
> +rootdir=$(readlink -f $(dirname $(readlink -f $0))/../../..)
>  tmpoutput=$(mktemp -t dpdk.test_telemetry.XXXXXX)
>  trap "cat $tmpoutput; rm -f $tmpoutput" EXIT
>  
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
