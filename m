Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9334CC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 09:52:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8A3F4060B;
	Wed, 26 Feb 2025 10:52:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6E5B04029A
 for <dev@dpdk.org>; Wed, 26 Feb 2025 10:51:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740563518; x=1772099518;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=OsghVyWnr0Do5TK0XfYPeVatNQzYD1gcOAxfMK0YM7M=;
 b=lkKBtsyi7aNdvfi9g+dx6oREuyqs0wcSyRvPMKfjVT5y1smF9AgaZn2z
 puf965uJNFROlOhK980K+iFOXGs0mb14vl0fIvQ+LWVZRRdBffcB4fzmw
 EyXdQedB33kTNrMKkMumUE28hqmmB7nQe6LnuIcyCdzundIOpa0NredN8
 Ob0jwb/dm9ACoTwq9SIWe7+d4Uc+Y1/RzaSLF7ja5dcvGgk0724KzrgVV
 TV90XPN9KwLXTob4XYEkuR4pe4Cn/qPBq+iGs1aINvBAMMIINZO57AGyH
 TRdqzEeaBY2AzAvDyBg7kmzcnbZFSxKKdh65rRbugpIDJ2JzVHTChC6Dx g==;
X-CSE-ConnectionGUID: YxTodm4QQPq0owXUf8coCA==
X-CSE-MsgGUID: tnIaGrCsTFmjbOK3Ox/TWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="28994198"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="28994198"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 01:51:57 -0800
X-CSE-ConnectionGUID: Z/PQf60vTk+C600ztxhEkQ==
X-CSE-MsgGUID: OlyO45V4QyOwmTbQs4QNtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="121757044"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Feb 2025 01:51:57 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Feb 2025 01:51:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Feb 2025 01:51:56 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 01:51:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ps6gN5xtS5rweyTBnbVHODYMEZWUfRYCrvPfeaYJx3gWCgkR0CexLXBQBTkZ+Hm/C+FQ9jyVGi9AAjgJQ11X2YqHY5dOofDO9XDKdREzjsiwjI0ZEM1H+8a8R9HZy7DVICU6nYhK6EUdoszios2c1lFPSg2eIapaIc7UCurMCjtXEwL39NnI9rH3Iy6cQJ+mawugEmOFd/JztskUpuDgG0rdHdWad01GlOQoeFM0KOBEhy3Hdi0AxXq2vJdwAx9le1rFXxLq9QxjMbjqoq1nGMNrFhAa6NeQ4tZj3TyqueVs3XYrbClEN/ZXIZ7lVXCfDb35GzIT/oA8ugo30AyyKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VMyenUFAZq7tn2md2WbulZwk6V1otWCUC5a3MmHSLA=;
 b=Y03vpT4fanDZNttFf83p0YkMlvq5GtqN38/liKMTqgvoXPmpBJV9wrE+P8yl7FVyksVOChizZCeOzuqWwJC/oUVh/+Kl+cTAkA4b7s0FtPSxrq2OJXDy4ARa9zmSkLxlECl/xpu0JFnNZ/7NPHubxXi/z+F88hBMlM0jrLK7gLXQ/eBjYVtWbvToGQLgGu0mK7UQD31c8Dvun9ISf68fSk5nD+MZTxTM8nba7tDQ1Syw5m37TtNGPCNNZ//imzK5j2HjYP0eH3waEERUZCsIwKRtyn5QZp+pplq2tqASYDoFpkRSPeN5nUMWKTiRbKpLHPskyNg468vDsb19qCPV9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV1PR11MB8820.namprd11.prod.outlook.com (2603:10b6:408:2b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 09:51:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 09:51:54 +0000
Date: Wed, 26 Feb 2025 09:51:50 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 2/5] eal: only use numbers as align parameters for MSVC
Message-ID: <Z77kNkselIoT2_l7@bricha3-mobl1.ger.corp.intel.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740532016-6789-1-git-send-email-andremue@linux.microsoft.com>
 <1740532016-6789-3-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1740532016-6789-3-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU6P191CA0056.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV1PR11MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c76e16b-a191-4103-69f9-08dd564b337e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?47lq65IzFpEVVweUam45pzdOrpSFqfoi30X1QQ6NioZ3d32zJxQyysNrJhlA?=
 =?us-ascii?Q?XqI13m5HwbEfoogon6THGwZcdaUAlvV2o9GJS9LtWnrv6JkfhnZhPD2mT3W+?=
 =?us-ascii?Q?jXqFOiQrkpR7A5mKKFIWyTObRQG1Aw40St9TNNF4F9GlAihBhanTwpq7/5tW?=
 =?us-ascii?Q?X1E6fgP9/ZerTfhlo2RhCOolNVCnFxQc/ubp021ToUHuEscff6g/Ggya8O0h?=
 =?us-ascii?Q?iAFXuWZKDFwwWi77TQShaiepMXrFZfL1jo3ctdgFz2BCPI+5UWtok7Oxjl0P?=
 =?us-ascii?Q?joJIYcrvBGQ/tri6Ypi5tnmxUTG8J2E+ak6tRuVFWg75te+UbQSvm4N7LVCG?=
 =?us-ascii?Q?Q/PrWCPzGP+rUxpsAwjJ+ETYBd0y0XG3T+MNLUXQlyavy8n+Hi/v63Tm66kN?=
 =?us-ascii?Q?HZDXh5lJ5xb/KruUpXUSg4kiYrENvYYxaYKlxdLTEoa1nzZZIFujwM3x4RDf?=
 =?us-ascii?Q?StnmjZoiw17AvynLN/9R2nDtEpJH7MMf90W//2vZtE+JGVPhpXz8OPOIbP5i?=
 =?us-ascii?Q?ZL6IffOYVYmXbfrp0Ouoba1cmhJCOAGdONJZ2+eUg4Yt3YKg3rx9EzF5bE35?=
 =?us-ascii?Q?QOoaWWyXRI1NymPDAsPea9f9kxzpEs7lO/WPg5/OnshHlkOuVagUsnX04wXo?=
 =?us-ascii?Q?3qKIY9oRb8ShsmzNJGOaH2qfElvuekTmeOlYrqZlq7gzf0OljIRFQkqNm3H9?=
 =?us-ascii?Q?YQBM2eSiuH97N45O3dBjVyL+KFaVFeDz2aRl56Jcgcp3/tuKUWflwX8d9cvK?=
 =?us-ascii?Q?nUJwgnqtSmMay695mw2pNjZMAbwU211WRIFanYV6jXiAyGmS9RhwHQ0t9Aui?=
 =?us-ascii?Q?ekiyv9pDT6DavebK+0NlFhR06xOHeZUfQ/tOLkDEwYqmEBH0J5G3Kd0sww8y?=
 =?us-ascii?Q?xkeR2z+b4kwjV6NWdlqRQSULpVD3xBIOXRDulP8CJvWOmb/4OULWJJ0f04LS?=
 =?us-ascii?Q?ycqseZQ45hlUB5xPq44EpGe6zWPftXtNpnM0n8kuTSgReBMnreVzJmucC09M?=
 =?us-ascii?Q?/hWr0YLEUkZWDZoXZ/APi+KHMbibFNXttY8fFcyzjWgoVNWNDzr+T1Znz0Ln?=
 =?us-ascii?Q?PVF8/E82tprQGYdvp5TFOIURPrUsx9qmzFkkK8dWbnviGKWknAjIW/b8ISv5?=
 =?us-ascii?Q?en0aKEz5uNOozk5XUbX2Hwvur14jCMEziirmTmeBz5+vruUd9YujeM+EhBrk?=
 =?us-ascii?Q?tIadjfA30DYgz49qc7yyi7fDsWpNOv0yjI9rI42n2QjnUQjGy1MkMkQRjYZT?=
 =?us-ascii?Q?G28OCWAEq7i/r/FwK4dBcZrdxwlQtVudhKHgrTxi0HLqQlRvbYELPcvG1rbG?=
 =?us-ascii?Q?SX/qkal5gwD10TDfgEz+L2craIm8XN5HoeXtRDZBsKmVG0x5tkebPBIdps1W?=
 =?us-ascii?Q?y7k1dDQI3gwc38MIOGnabcDR/m1w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cgG1SxQC9fVa2HBlXd5yuYN0LPFnu1JOlje9CQoMgN417BhWOtGAX7be07LT?=
 =?us-ascii?Q?zfV/Epav/5/6xDotKtzFH84WnAf6hk58TlgYPGsJaNqg6UWJo664QwbArNWF?=
 =?us-ascii?Q?HPBYMyyNkAG+01tZWB23JPYfeFdHR9RUiyNKKVKygYfe1ppUGpKOIoNL/Wjl?=
 =?us-ascii?Q?cZoODyJ9PRNXfROA7TdywHLHChZC4Z07U1d/rww4Yz6iLh39C2o59OZcUZVO?=
 =?us-ascii?Q?rZDTKrCjRrEtV2jMMy6Jau6MY8yUCXa13fo1TFCPCNX+KFGwsV9VEi0tBl/G?=
 =?us-ascii?Q?+/f0/0Dy4GpL1lQOPe7QJautcKkI4Hely8aVGWEYM/sEnmvfUm/lRc2JOpAJ?=
 =?us-ascii?Q?Ohb8RbaL7x6/V977QlgNM+ZXhu+d5qAyqGBa7Hu7PBIfyhqc077lqnxgQCx5?=
 =?us-ascii?Q?l02NPLGwGMvsqfhE9H+H56iIcLKSoEKhjpmKy5pRbmjlFx2HJVbtLJ9zZzjm?=
 =?us-ascii?Q?rPCZY0fFj0/uq2lnLMi4if3pxgUIzvURoDrEX6iuPhfe/xZEX+P9OqtJZbj9?=
 =?us-ascii?Q?1VgL0avu4xH762X+heDQLmTTHhonkiLI1XavScz7xDYYBPavKVFvcE4JiAxQ?=
 =?us-ascii?Q?zi6DNuZElsLtaQa1/Ly4ykgivu/OJzFUnJEnl7jPET1olR/+eTt2kEiThdmJ?=
 =?us-ascii?Q?M6wX/H6MQIuo3mBBAjiMHp2lPChLrifAYPueiJEX3bGFdJjLh6momMpGLooN?=
 =?us-ascii?Q?W3ql1uxrOpWVAcbasqDiI5f/oWZW8u0KdJ4Gzl2wWW06LYuOpZyNbpLYgS4v?=
 =?us-ascii?Q?5Hfpn1FNfXGIyEk3cMz+v/XwBrqddgK22fAOkLLpMCi9HhPkkXaOtJoqAzxh?=
 =?us-ascii?Q?5WMpZSAcu5UpXHfaQXGCN2IVWSzhDWNgyyB/eqOQ1KnHRktHoKNOH4E5B+Ek?=
 =?us-ascii?Q?RCAo9yod4WSbUwUQ4yT1jb1DBZj+QCTctjqT5ET8al33qK4lvQL+q7oW83RY?=
 =?us-ascii?Q?PDapQvumTeO8vhyr6PFHPZQlD9tMiamJNIhDOiJaeRKjekamjwBlRP7aD7+X?=
 =?us-ascii?Q?C1u02NRvup+JHKQO18JprV+iIaTZ5ojhQRfjY70QA15tSi2MJfIMjVMhgtWi?=
 =?us-ascii?Q?/+Uo1BV8Mub5QWNqjLqj/ysBSBX9lZYgIp/76IbwilmboQt/epp4yW9J5rDv?=
 =?us-ascii?Q?68Zei2g1idqxZeNh3VfXtc6kE1bzTZ5VN+HXiGfWIBKf44gfRzJF/6UHSd3d?=
 =?us-ascii?Q?OFCfSMynJ7fDfb8nSxvg9W/ybHLwl97a4m9SLrh+vtgLyl4Uh9ZoBFNrOnOc?=
 =?us-ascii?Q?CgruovN20x4HMMCdK084F4FPxCqqGCcevPwuG2VpC83QFAi8mmTJNhBNF6+0?=
 =?us-ascii?Q?lOYbc1Cfq8vE9vwk5mvv6Bz/ZrYeoMTuTKU/jgY1KeZutyZ1SzKUFw6exy5Q?=
 =?us-ascii?Q?ykS/L1+KHglWfEhyX1zUUmA2+YssWrQVmSk5aXntwpHbqaln8iSneYqdH2Me?=
 =?us-ascii?Q?SWGvc/l57F1HtyL6K68DL67d+vJvk7paPUyZzV8+Wt3Yw1bGRywzQEqD4KYl?=
 =?us-ascii?Q?2L2VjEaItIMw1kkwvTbxuHZ1htocwyM0dvAp5ls4ColWWKr9uWl8/Ued/xrY?=
 =?us-ascii?Q?oroDcrVfFZZJAXyRbXQDSF+AQy3y+KQP3MPEsoGDoYAmZn/iVhmU+6BVYAuA?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c76e16b-a191-4103-69f9-08dd564b337e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 09:51:54.3808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CKFxDdT361cAxz0SbXbBSb5jsKn3HnStjMUe7bxHoPtWEvzxynN9Y4dvNgPQpGGqeyOMyYbKMdcdIp6asFFSnmVrVzedarL5qxS4l+uahg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8820
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

On Tue, Feb 25, 2025 at 05:06:53PM -0800, Andre Muezerie wrote:
> After the instruction set updates for MSVC the error below popped up:
> 
> ..\lib\eal\x86\include\rte_vect.h(82): error C2059: syntax error: '('
> 
> The issue is that MSVC does not allow __rte_aligned(RTE_X86_ZMM_SIZE).
> It only accepts numbers that are power of 2. So, even though
> RTE_X86_ZMM_SIZE represents a number that is a power of two it cannot
> be used directly.
> https://learn.microsoft.com/en-us/cpp/cpp/align-cpp?view=msvc-170
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

