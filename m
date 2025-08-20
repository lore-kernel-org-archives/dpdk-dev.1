Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222F8CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 10:36:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BCBD4065E;
	Wed, 20 Aug 2025 12:36:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id C0647402DD
 for <dev@dpdk.org>; Wed, 20 Aug 2025 12:36:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755686176; x=1787222176;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=EI7c9ftsa7JOuNWf95h6U0i8Cs/GyyGUUUe9ytfX6pI=;
 b=MIMs5KO45YF/iekM8vMcdlJybfgs/G5fMXmdS0fRU2oXWOpZNbz1Sgrz
 yS4bqGvLO1/x+pNCa82vkogXl81Rf5vt/mX4p6QIM+wsxmaiJAsq0Q3Qc
 5HVe4f3jumS7ogSN0Zw/Q1/jXhKFaAAEEfFQ41HT3RfgrhAO2BCilLlQt
 Rof6fBvMl9fQYpxOQLV5dfd6F4Qck4d920EtBqSq7j3Hf4NFoeKZAE07B
 2IvplUft1n76sv/+hoBCNXt/PW/bMxP9Ok319ClgwYSF5wwl1V3jox2Tq
 MQdHmv8cB/z/k9yKwHP2kL13cQlgvziGtbXxAxD+n+Dwvj9XI1SUEgxwv A==;
X-CSE-ConnectionGUID: TCftCOpKTdqdp0JWoSKOpQ==
X-CSE-MsgGUID: btmhaKDYSwm6VBwkWHhTBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="45522017"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; d="scan'208";a="45522017"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2025 03:36:15 -0700
X-CSE-ConnectionGUID: sm/SiNiyR0SbAH/x/rhE4g==
X-CSE-MsgGUID: rwvtfFfoQrygQcACyslRfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; d="scan'208";a="173451968"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2025 03:36:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 03:36:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 03:36:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.67)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 03:36:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiAfge+7O14FseIV2j0XWvQMmxAwhjJPyxYM4YOFpZsfwWXV5DUrx2mM2fbodisDrtyTXMVcSWiTvYQBcmT9LtatYYnuwAhT3om6NhtvAAB8BU+3XW0LRFa9gKVoVwL1W9HdVqCDDHhiv6edMDGfRhnnkYNlQN4T9ZTR/HIks+s8Y2RBQ5BbiZg6HU0Ydj+MBDw+Lx68rTjyr783lWN34LFy0dFzPfAR42yBjQdo/kdNkfm6Jnjg8ePmkekaRhbYvEwghYVyXWb77phM9j/7jySPJq5CS2XLUPJnpllinev2LkvqLnuRfgL5jwFZ+iGUiwAha9fjjVJRQelNWzLDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcFhFARBPnVtl2JMsbIndOpX9M8WCvg4JutBzPMXSuc=;
 b=n7p4vO52iEkZOlnXL2eFIlI+R7Uu/4phhnohkm5rfHxXd0Jyqx6wK2DNrM1xkzg9COrsj94QLihtAGvp9YJiXQFzm29gu9nc7yC2edMjWOlaVh61UJspuAHjdTnn0WuNZmHMb6GKeSB8bUdXhkar/VK3CI57C9ZGktSMAZ/AzOt672be5ziRnpbLD/dBfmwc+cKHgARnt+dyUySdFZExQq65HYoTA/Aejk7keE5ChL0Xu5lWZP0nO8mQNi0YqccN1PFp7DSYQ8a2FhUNyJRKN1+OuwBal+2VCnU4/+QomQO1yqcnEmmGLwgT/mGyj83n9q0AcGEdObdusqmlHKerkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 10:36:12 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 10:36:12 +0000
Date: Wed, 20 Aug 2025 11:35:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
CC: Thomas Monjalon <thomas@monjalon.net>, <dev@dpdk.org>
Subject: Re: [PATCH] devtools: ignore new warnings on reported-by tag
Message-ID: <aKWk7kDCTWbj2MKd@bricha3-mobl1.ger.corp.intel.com>
References: <20250820095050.1090859-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250820095050.1090859-1-dsosnowski@nvidia.com>
X-ClientProxiedBy: DU7P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA0PR11MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ded0e6-cf66-403c-1d2c-08dddfd5620b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5FuDds+YiqUKT/k1XKbu39O3+mz4DdWuEPjblItceKbYthpJY0JZbG2PmzYa?=
 =?us-ascii?Q?GK4rSM189vDOSjen6qKWkyy12WY5cRTpU53T3Pjd07JsHj67Vp9WidQsHALP?=
 =?us-ascii?Q?WCekaTah0PNihf9AnntxqFsmOFE7zcGJW8XU2ZGjYJyfHNEI1umAEqj1JrEZ?=
 =?us-ascii?Q?KgM9knUdk+LeCm1srqwnxTBU6WgyE0hvAD+fKecjbKTNQ/5tbMbio1tSrCWx?=
 =?us-ascii?Q?f8Wct6pX2e6pwsAemNdt7ja3rSIuuGraG30DFwcLTlVdoSHucMCbcvbjmChR?=
 =?us-ascii?Q?X1C/Lksh8+K2JGWLWOiSJ3mZSUWCcgiTHRbW+uHu3FVqvrsUMvfe1NK6tELm?=
 =?us-ascii?Q?xuQIjuj2JcqroUBk/mNLswUnf8t+WVPW5+Io8UBKOE05xXLpiyCFsUFuoMo/?=
 =?us-ascii?Q?WPLQh8evf7iFKUkzV1uNjBaj6w9B43KBXF07eXI4j2KTvEXA7ukgIhI+ayUt?=
 =?us-ascii?Q?NwEOGZFiWrU1MUAH4YWdNLQ0NO/xaX8aKp/oYhYZm0eyBfRq18VIfToO9ATo?=
 =?us-ascii?Q?JVEXabRoraMjcE5z/wpusSm3uc7IS+fPQpQXhyFBDq6KrapU7pdyt+JlziIb?=
 =?us-ascii?Q?GVoXlOkxlDAO8iCttHD2ePw02ioYNgRp28+S+rMJZtpEx/VByVZRhXrcROfz?=
 =?us-ascii?Q?XY3kTJ0VHjf52OTLyzvZFyej2KVbKE0QxS1lacggyYIU1ElR1SNxKpxKtRqp?=
 =?us-ascii?Q?nmivD086CYA//gyjx3csy5F7qic9ProlAfnBSOgWBS1eoroV2jLvSyMK8CyT?=
 =?us-ascii?Q?V7lZ+F0oEsODKmAxAIN3JbnjrugHIQrfbjUGqUpCWCsBtHzrBa4F44QgA65L?=
 =?us-ascii?Q?hC9c2PzwkTHUdtSf5dNcxa4LvgZqBrV2WFGeRmoyGJL8Wrou2lB6hIjAVu/S?=
 =?us-ascii?Q?2dQ+hxHSCV7blS+JgXE6tvoFTyrW4GJYwEIJFTUaSXffba08KpyFTnkEJ3PG?=
 =?us-ascii?Q?WYaRID8ulNnVITB/sClY0rABSLr52yLlB6S15hVnlEWZheiuaNo1Cve/NnZY?=
 =?us-ascii?Q?N7gC7bBmD0UKtYu1uES7/jlgJXlMfcZ35Q5wlb56SqspGcFUu4Y/vIkQWcVV?=
 =?us-ascii?Q?XST75qpk+CQ3fyoqJ9DgnSmAWWM3LVMnfpKkn9cCVibWtHSAewa+POGZayl3?=
 =?us-ascii?Q?5T5gtW+FcCTywJ307CRQzqhbm1luWcBfunPLe8vbu5yqO7hvjRXjpUutJGL/?=
 =?us-ascii?Q?y2KhNh+sKhcfSwae6s/Jv107avi+YwQZtK8Ol93xFqNMybgqGHrBlmBSXYCZ?=
 =?us-ascii?Q?+2M0C1TqMOVsBZfqGmuBFosYJDFzRh41XrW2UaPgOCSzBxlPS0l6bKVQ6PJ6?=
 =?us-ascii?Q?2bKGknWwOz0A5eQcWv9cnz2WObnL4wwSgQnf9jY9iacVpsoLWFnLgTDJS6xt?=
 =?us-ascii?Q?XWwQ2TsajDIwOgxfIdGikVfs/PEF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JHckriqoPtlm7QqFcwOlzuZQRO7J48hO74Xyl98NYLstuWPHrKIQLYRGNC0f?=
 =?us-ascii?Q?UNrRSxwxgDixS5RgJrY7UgQKEucxbpA/VeUGk32SBLcnCi3I+43Zj86B4Izx?=
 =?us-ascii?Q?Jzie9NekdKLswObH5IiUzskYe9aFp+kC8MS3es0zt6UcO+HqvTlLhTmCFnrZ?=
 =?us-ascii?Q?oM6oSkQ91xeWpxfzI7kB02YLNjyrxkHImYMEOAaedkCFYU28hwbbD1E/sR+K?=
 =?us-ascii?Q?g7gcvnGXh1t0C9sdT1DsjgiZr6elewSPtApgm1XuPgGfWKojuLCBuG/PPbSQ?=
 =?us-ascii?Q?ieTcHOgkuuJLYVzuZiv7WFsqMjDOnXPQ6fkmFIqCLAg/5m2F2Pd354r/fLkt?=
 =?us-ascii?Q?SRuDbnmszdmaswkXu+8bSEdDemJVnyK7JBqm1vKT3/9ve+ea+0fQwXl7SfAo?=
 =?us-ascii?Q?wOx2ZhWlbQFkIJBZf+Mw7CH1ILtfWBXQcIU/pJaIWSexJ9QHQsnSTX5BVfwv?=
 =?us-ascii?Q?VSpCCP4Ilenbhipt6ROztRzof2ojF3TVYPDHKouwmf88mj1ueNlch7D34c9A?=
 =?us-ascii?Q?kMbcBTfThwwFlntJYlgl7KqHEkvmPhlPO4IJMdEr9YUATlNww4DvOW3hmw37?=
 =?us-ascii?Q?MNN6z2rVFZYyH5bPYLo01ElE5A3wje0eoqurrw5Nms5rOXYy8l9O7ZsM6SDM?=
 =?us-ascii?Q?LitP0cnSvZlPd0QI3p8LvoQwtc4yJM5uSepmYvO2VE4ShRWJBeP69w7PItiN?=
 =?us-ascii?Q?TztIEN0qM5aZ3+VwYHuSrM840MOdT0mCSXWzj20vGUtFDb6/eSdJzC6Xug7F?=
 =?us-ascii?Q?Bu5stbWjdtVyhQXDCMpTfPC4W9tz8LG3Bh/x7/6TgsoGpnoj538en0diUs2Z?=
 =?us-ascii?Q?oAGsT8/yvlCD9sZrt3TULUf2jIJyakftNodS3FVIFjWGOed1l5sFe/xothMt?=
 =?us-ascii?Q?bF2I0s6U7Z3fYnuMe0ZlNro7o0LkDlndGCgzrBQnZZzpeK0R+jsC2md0sVui?=
 =?us-ascii?Q?Nl6j31MSLJz+IkAiGnILzAxcHM0hruXp7dLQbmHXFAyVdYrWl+tMkZBQJF5X?=
 =?us-ascii?Q?U1LmeOJp7c0cl/OMTCPPjj1Qm3v+P6xI0E1GX4QEYAIXIvoVjtQ3IYfda0Zi?=
 =?us-ascii?Q?NeWpHQB0DaOgWYXcqW+H+4fE+4bPmEAwIm1ga/6ncgy259JAi+KMt26zpfsb?=
 =?us-ascii?Q?Vw2xKAojOXp3ys1BEh9nimkcn7mh99pGZRhvPmc3bEz9CRTWVQPl0OVB1rNp?=
 =?us-ascii?Q?zlEYD+gx0hTdb0ujM1erAXR7e3AHWg1z024wpVHcr8nWkNfCbwPdFOgYDJoH?=
 =?us-ascii?Q?MSPu27ZdSBytPJnKVZBslyJ3OBCzPSb6DNYZZCLY1f92t286xGegvCUjt8iJ?=
 =?us-ascii?Q?7JteeqJpyINbWqqAs3k5vEHKAD4SYcojRvYoEvAjt7/8cFvGMuSVopwJw0zQ?=
 =?us-ascii?Q?OXEiyBxTGuW2pNJu0nWHa8PvMYWq1BfVgTk1QhvpsTkQ68QkoXuRN7KYpGZz?=
 =?us-ascii?Q?efqidEeC3cAKBnyEM0v/BL3oSVUpyT1nAMWSWngjupcSvb3dGUzdQGuGbmcM?=
 =?us-ascii?Q?/EBUGH9PesXx53uLZjHz3fMRFeUmaunkeYv3Zch02PiQbVQwzqd+9GOunsHA?=
 =?us-ascii?Q?qBxTvzutjkAxOn0vZqgGHsos4zFolGlwKaa/g5zsKBiLaU8miANliXt+CtIx?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ded0e6-cf66-403c-1d2c-08dddfd5620b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 10:36:12.3973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xy4Fl252LJPZvtXY9QR8DmjyKUqY0cJlMfN9NkIplWt1OvgIgmFiWVWeXEQuYtLE4o2qHYwPaMSDVPOsTIuMKISA4ymI9MbpWV1kjDp8W3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7160
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

On Wed, Aug 20, 2025 at 11:50:50AM +0200, Dariusz Sosnowski wrote:
> There were 2 changes introduced in checkpatch.pl script [1][2]
> which verify if Reported-by tag is followed by Link or Closes tag.
> Example of the warning output:
> 
>     WARNING:BAD_REPORTED_BY_LINK:
>       Reported-by: should be immediately followed by Closes:
>       with a URL to the report
> 
> Original purpose is to link the patch to the mailing list discussion
> and/or a bug report.
> 
> Since in DPDK these tags are not used, these warnings are false
> positives and can be ignored in devtools/checkpatches.sh.
> 
> [1]: https://github.com/torvalds/linux/commit/d7f1d71e5ef630ab9e15b5821d297a9e1a5fa1da
> [2]: https://github.com/torvalds/linux/commit/44c31888098a590b8ec5ba37009e5a983f7c4b46
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
>  devtools/checkpatches.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
> index 35037aa8f1..8c5b5d1380 100755
> --- a/devtools/checkpatches.sh
> +++ b/devtools/checkpatches.sh
> @@ -33,7 +33,7 @@ VOLATILE,PREFER_PACKED,PREFER_ALIGNED,PREFER_PRINTF,STRLCPY,\
>  PREFER_KERNEL_TYPES,PREFER_FALLTHROUGH,BIT_MACRO,CONST_STRUCT,\
>  SPLIT_STRING,LONG_LINE_STRING,C99_COMMENT_TOLERANCE,\
>  LINE_SPACING,PARENTHESIS_ALIGNMENT,NETWORKING_BLOCK_COMMENT_STYLE,\
> -NEW_TYPEDEFS,COMPARISON_TO_NULL,AVOID_BUG,EXPORT_SYMBOL"
> +NEW_TYPEDEFS,COMPARISON_TO_NULL,AVOID_BUG,EXPORT_SYMBOL,BAD_REPORTED_BY_LINK"
>  options="$options $DPDK_CHECKPATCH_OPTIONS"
>  
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

