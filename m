Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897C4CFD2F6
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Nov 2025 14:10:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E20340DDA;
	Thu, 27 Nov 2025 15:10:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id A075140658
 for <dev@dpdk.org>; Thu, 27 Nov 2025 15:10:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764252651; x=1795788651;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=u0OqxBrR6xQ8KYSRsyb5fzB86+ICxCs6/1LpPmMAhj8=;
 b=XBRwfyD+2rO+WiI8pX/PEioS8Qa471wUMUkfL33SRg31FGY+qe4f0dc6
 Nad5AJqFDqA4d6tNzsmu3F323eengv6Ip31q2dkqbkUvhUptqzK5LnY/8
 k0P6T7iGbfIVpurK6jGyjYyRlnYVfzfZdxvBhQQOtDKDJOVUjZWfoEEWV
 jTn9jlZSMIyrj1gO+hif4p2ZVkYe3Rm67K5TTvfibdD/XW1Omsg6Oa1wj
 oDSTpEnAmIvEDgJUg7yfMxX9wMY8emmkdOwnpYHoSGrcVrKBNZPTlkOFE
 Fc4tcWF4AunGs38mRHrc6hNlMSmNglAVusYKdKvy5P8b52rt4UHd1SebC g==;
X-CSE-ConnectionGUID: Qpvwvr0lQRiaIMBQVOufzg==
X-CSE-MsgGUID: XgsspPrWQcSb3RbO6EqT2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66010743"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; d="scan'208";a="66010743"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 06:10:50 -0800
X-CSE-ConnectionGUID: a7YZ0zU+R+yuCTMbpKEKRw==
X-CSE-MsgGUID: oDjHhX+XRCSnQ2LcSeKENQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; d="scan'208";a="192366619"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 06:10:50 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 06:10:49 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 27 Nov 2025 06:10:49 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 06:10:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYMW2S2HDAwInEDUhx4YWLdKTMqBqFgWTBbyFA+Llx07uxIyzbFYaEXFVFldOod4Tu5lW2f3RziLpqHu9m5d57KYP017X4VQZfAy67da/mejB4SoxSgNZfE7XB5QR37raYxYGZEPZ6XJRNoLy5kMHkeADgXHAzo6td0kt6eBvope96ojGSFcFZ8YUx7pR1AgsG9uUkXs7uN4/ip/b+ufDpESKI4RsBCAe8EzM/mwBa71Prl6f0ZWlRx6IXN/q1Y0GP9S+HsrP/apsu+7uodXjYYAHtnAHLyqoWRGnTH+JX+OyCxwGfbg9gC5hCvhxOVOzKYYzpZ/Dh2zhUD0uZEOcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqt9UKqLMORdhEj8Afxy03bxoS0KC/HeM++V2/3tCKQ=;
 b=NQdycaNaF1C5SMb8THIVwtdzbfNEfd/yheDymWYpPbO0qqJDPooO+AIgwljMUDJ6wLcGs2mKZJ4te65W70eyYlAhDI1n4hpWfaopMgul4huIY2UvWjB0zIGoMwINKrWc5NOpWBAz2+m5y0/ZnHUozHHpVdmap3pr5RXqGZpblunUfOiSqHeNeqqhi2J2GB14F1Uv38VUl/75QgQpvoxC0pCRRA6ot1gsNqaWUiH2KMJQTy/rkNI5bPhrNMeVCqZKTeQonOV7X+83vijiWkCNjzcz8mvQw0Yx4bCC0YN9vAI7IDUNa2uhaXMqXen1z+POaEPxS/+Pwg8+6YNFNf4pqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7940.namprd11.prod.outlook.com (2603:10b6:610:130::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Thu, 27 Nov
 2025 14:10:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9343.016; Thu, 27 Nov 2025
 14:10:48 +0000
Date: Thu, 27 Nov 2025 14:10:44 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <luca.boccassi@gmail.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] test/debug: fix test failure on ppc64
Message-ID: <aShb5MBcGuyTbb1T@bricha3-mobl1.ger.corp.intel.com>
References: <20251125103935.1729434-1-luca.boccassi@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251125103935.1729434-1-luca.boccassi@gmail.com>
X-ClientProxiedBy: DU7P195CA0014.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3bb5f2-7e01-44fd-36a4-08de2dbec3aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+sxCDbwK7pBOe17vNo5YmwKzrbrRbhfFygGm+Y1tUDAwaVRMK5UuePAEEKsN?=
 =?us-ascii?Q?kr9OGdBPn30N5mx6EolmFtmcJchv59+ZPx3hzBRIvVNcyseZvcZY+EbM/LnS?=
 =?us-ascii?Q?qbGj6uAKNbqP0wxsyi9vdtZ6NkZdNIGdKsrBIv9nC8kC3d5drv7aF3TpA9C2?=
 =?us-ascii?Q?Ahbp+EL4bgv6+ooRBYJpfyTPhf8vBjln6Yammyp799nfs9NyPxQv7oFozZK0?=
 =?us-ascii?Q?DTxXg2SjoUA0B8eGKZmthkjAGG1rJe+68my3LMD8ec6qtDm2uBIvBuQWQqQA?=
 =?us-ascii?Q?xVcH6VyUNPEvMeijHq5EaqJD/yXX8fsuToVR4gzc1HMBpF+mQJ9pnxO3xV0i?=
 =?us-ascii?Q?vMkTFS0bQIFYy4TIwfVShz5KTU4yHoEavyDwmYje/wSAJTdh1hPD+CUOje+Z?=
 =?us-ascii?Q?bv8ValSX1k6WkDMLtY8EIMs1iYKLZXw0u005C1X19WcJJ4OE6vN7ZC/n3ahu?=
 =?us-ascii?Q?Wui8VVIpIXWEGO4ovrPA/EnjFUDWBZeRQ0kQAxTCqkV6WfxKO1bv/Ck/6PwQ?=
 =?us-ascii?Q?zC1d40QUqqEfJmbOLvc+Sav619HBQtk9EMT9IgvPQQbroc84Y3X43FecXcVf?=
 =?us-ascii?Q?j0ntWghfcAShIEpuIf5rkHqqOe+IFgFZwo12n6SA2oxN704Uz2Qnn7YYPDLQ?=
 =?us-ascii?Q?PFJfwqb4CuDKv649FiOhAFpA4mFGoSL3kD1aroZ3b4W+FGf8ZubTqOXcJfVI?=
 =?us-ascii?Q?rTP5dYrdneEOcVSwoAUb7vUSH7lLiIs6nfy/9Q1wQNl2Ao6BMD4wOwXtxNwG?=
 =?us-ascii?Q?5Et95bDaSa0vt/AsPD2NKRQsWPQNfHEaUCz/a7SWazr7ZkKfN5uHOFjtCR2k?=
 =?us-ascii?Q?7s2lxawTj5CZsTwFdY+1OqODYzIdwQTUGOewBwEKTRmefQOWzWTvTIgONAHC?=
 =?us-ascii?Q?HpjUVNmvoXSbFHmYJziQi2aUnCjdY5prHXy+oZ73JcoR9n5IM9LEfp0PxGxS?=
 =?us-ascii?Q?2BarPvf36QCAuqpv1ZnSgPTblKkTJUQdwLJybSkeoT7niRj9M0tqi5M52ll0?=
 =?us-ascii?Q?6Dqhik3jKl16jcY9czUiLxW33qn+9YnaRUn2ZCmbB/JSSFbyEFOQJ9n6ed1F?=
 =?us-ascii?Q?VeKr5lPETaRmfrctZC7yNp5C6DRq/2izoHN/NKuxlQBWvUHfSYFKCgbrMMa2?=
 =?us-ascii?Q?T2t0OdO3ZUugUlCkkn/kTR2rFOk1ownVbQAX/7cEP0IdZrv4WM0i/Sso/HhF?=
 =?us-ascii?Q?ABC48polrgG+Ya7iuSmGAN46Iok8hkpLyNR7iCgJOd9zuH22BmDy7ES6Cb0f?=
 =?us-ascii?Q?nfPzY1LfF9przIape363GX6x30uUZytOB/KbOiTkFojXxH6IZiFVo1OY93w9?=
 =?us-ascii?Q?ivmHnYzy37KUGgys6XCtdA7/J+rT7/WE4uVjxt3R1G6a+2IniZnEFijpMIaR?=
 =?us-ascii?Q?h20fjsWJwqrp7Oyr0BvSgZodEBY/kLT+pJB/OnuG+2kdW7zwXfjfafG3sXKK?=
 =?us-ascii?Q?9UpbJ+ft8oO7YFFeAzs5DPZjH7Q+Sicc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GGr+bfG/rYEjypyhIMTJ+311OAVNmS9rC3cdCguEd9GgK8Yqhrtha9bhHOxE?=
 =?us-ascii?Q?7cmdo6opTSEmhlHpa0C4itbq6tChC5+kvIJfhTQaNEERc5IpVtvzdVLT9D++?=
 =?us-ascii?Q?Fj1nf1jruMV+NT2fDd/rViVb7Yh8NQi6gkt2mIIWqbdfrcoWwG/82jjLBOnL?=
 =?us-ascii?Q?0AcuZ7Qul+PIopAj95Igt00iWU9TK99tx9bcn2BAGbO3aqO5Ok4wTuswAGRf?=
 =?us-ascii?Q?o6Or+NKqs6EqyZbGcStLV/sLb5Tg0ZKCihjqQkiDic2aHLhBAbrim4boS25U?=
 =?us-ascii?Q?YLyarUf4BSaxh4iVYGWKcfqGu1QdpuDZ58hauvByTh4I9pzQltBPdGRq5Tlt?=
 =?us-ascii?Q?jXbBEhO4O9ZwzOzGAsV/XpeOJeXy6wn5h8mlWq3T051SiHaia4bTUwCQlebf?=
 =?us-ascii?Q?HZEa4DM7E+wj1Y+KEBg1G1mCnaWkssqtYybeKAnmbfJwmihyWyuWrAijHu7E?=
 =?us-ascii?Q?5pqIbufH0I86tpUPkRqRcYvHvIaq0pj77LoaL/UL35M1ZCXE2vh+Kk2erq/K?=
 =?us-ascii?Q?SibACmQjMg8lqSbyGOrEW9wu1qJeYhwAZY87yXHRX5ndtCwa0XvoRDX52t6o?=
 =?us-ascii?Q?MjCrxc//ME1o9EIDLzpAelJTpL03sbd6U00DDMW6TTtowjbwmAWwnJFqDV+Y?=
 =?us-ascii?Q?ftAOjgC7vfduu5CE2Zn8owmaQlxF2GxkBAU22UeVzkBQeypTRQqhN6HHLYy3?=
 =?us-ascii?Q?7OtdKAfDg5+rRt2X3yZE1cIaK4IR6L0i0gfqskaeyRgaSUF81ugjfMzzk9PC?=
 =?us-ascii?Q?L86KxECBgfOfuliMURbEg9OPvEEgw0MutbNI7jeeus8EwPayhayxsuOC4M6V?=
 =?us-ascii?Q?BQurk82v+nHMupbAYeVYXKv07ZzWA4uAU7mJHIgmtf5QbdJGuohwVzp04ZNg?=
 =?us-ascii?Q?iqPYL6j2xVtNW0OaNnkLlsqvTfTDbI6PkWgU1uTMoO3XcLxq4HyIMz75b+cf?=
 =?us-ascii?Q?/zKoTRgUYKihx9fmQsZNn1VGECHMwdtbIFBB+tHTXnB2Mm/knPlPOpW98TlB?=
 =?us-ascii?Q?U6tF0cjlusd//+O2iHsuq0ZddcxotvPvbslV3FhEvBv0r/UR/RaN1Ml8eHWk?=
 =?us-ascii?Q?8HrwBS27fP4EfV4C8hxVM1lDW1wYHKEP1tad6R51vaWE8UQJMdG5KekggFZ+?=
 =?us-ascii?Q?gjanz7oeJre7ufhvXepkt5f3xc4LlpeApPMX8ZhbFLrRZ/l6U0/aHOisN0N0?=
 =?us-ascii?Q?7eG67td7ffImOH8awo7f2aD4xSYaD32HaQSdosTxuQE/ED9QEbdt2R4j0bRg?=
 =?us-ascii?Q?nDzZXeHPRCIyotGYm1A/hWHqGPs1NcvqZRy4p5gPMUnJHGf5Bj3jrLd0qcXi?=
 =?us-ascii?Q?rE/QhT6YfW/Cp9YCObJcY/zIgxOKIpVG2ZTeYV10kUtz4Jta3RCrUktvRsoO?=
 =?us-ascii?Q?NccRBQ/a4WiMHYWijlC2IJFDzc1uu2dCA1UY5Y52KqIOweqI/a3DSybMuRdh?=
 =?us-ascii?Q?W7ZnFe6wEPbo5+VBqVvSYYKtLe9ITevMX1DtQ7RHCxjewi5ElEp6WStdN7Hz?=
 =?us-ascii?Q?5MMCnJeq10P0hfQrHie+JGZglaxECmIv1F/alh1wISPNdrOPeiZLgLEOX9ST?=
 =?us-ascii?Q?Z+eNF+pY5sf/0urOs+08UeJ7Qvmp5U3HGCIVQ/hdq91ZQTwut1zTCAidb65Q?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3bb5f2-7e01-44fd-36a4-08de2dbec3aa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 14:10:48.5507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAhXKVAeIHUHkgo5rZGbfwhkXaFawb/ewVD1jOI36nSSx0nLzxJfTDP1MG3Ih+QYYJEBSfHEcbp6Zw4ElSBZnDSufOii1IShS0iMKfGuGKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7940
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

On Tue, Nov 25, 2025 at 10:39:13AM +0000, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <bluca@debian.org>
> 
> 1001s Running binary with argv[]:'/tmp/autopkgtest.LvdXhc/build.6vT/src/build/app/dpdk-test' '--file-prefix=debug' '-l' '0' '--no-huge' '-m' '2048'
> <...>
> 1001s EAL: Cannot use IOVA as 'PA' since physical addresses are not available
> 
> This is similar to 6b07762e949036389030cf5a1a9bb8a1e4d6ee2d,
> on ppc64 iova-mode=pa is the default, but it doesn't work with --no-huge,
> so add --iova-mode=va to the test arguments.
> 
> Fixes: 2b403dd8fb37 ("test/debug: fix crash with mlx5 devices")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

One comment inline below.
/Bruce

>  app/test/test_debug.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/app/test/test_debug.c b/app/test/test_debug.c
> index fe5dd5b02d..5ff9068e2b 100644
> --- a/app/test/test_debug.c
> +++ b/app/test/test_debug.c
> @@ -46,7 +46,7 @@ test_debug(void)
>   * ==========
>   */
>  
> -static const char *test_args[7];
> +static const char *test_args[8];
>  
>  int
>  test_panic(void)
> @@ -158,10 +158,17 @@ test_debug(void)
>  		test_args[4] = "";
>  		test_args[5] = "";
>  		test_args[6] = "";
> +		test_args[7] = "";
>  	} else {
>  		test_args[4] = "--no-huge";
>  		test_args[5] = "-m";
>  		test_args[6] = "2048";
> +#ifdef RTE_ARCH_PPC_64
> +		/* iova=pa is the default, but fails on ppc64 with --no-huge */
> +		test_args[7] = "--iova-mode=va";
> +#else
> +		test_args[7] = "";
> +#endif

Next release we should maybe see if we can remove the #ifdefs and just
iova=va for all architectures.
