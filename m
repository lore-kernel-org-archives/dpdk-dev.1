Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C79C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 14:50:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FDFE42DA6;
	Thu, 13 Aug 2026 16:50:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8F9E8427E4
 for <dev@dpdk.org>; Thu, 13 Aug 2026 16:50:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786632629; x=1818168629;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=oGw5Z2VMPWu9zMTQIWc3H+4RWMA+RKN5qXUiMydAPAI=;
 b=GyhSMpvxzzohKRKeJ2YKdtAI3aTjTXyrFpdsumkjTaynrWZHygsNNtXi
 6VPfLhF9qXritt1Ux/a17lgwIRCRWYXlr/xvN3c1EwnocrXABlsZS6FPi
 3tEs2OI862ADVqrGJjP4Mn8n1U15V2Z7Too8ZTWw5YMr7XgcBlwER9DjS
 9nDzAIU4IH6t0SE43zn5TOuNo3J8otkq7Ralwk+P7TBjw/S3mecNuoTD5
 C7NL3IGKuxxISDBgzA2dBqxrV5tKUSs85NRSbzYKUkwdzD3eQryzPIr9Z
 yxUu30WlxjGITKrtHWtAo1VFLmkntnLsfY1Vuah6gCsSC/JHoQqUdl8jB A==;
X-CSE-ConnectionGUID: HUSZh2iEQ5+mZS1B+TvwJQ==
X-CSE-MsgGUID: oHvpK9jlSuSq9dwdZDcRFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="86169826"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="86169826"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 07:50:28 -0700
X-CSE-ConnectionGUID: eA9gF0ZnQveMzQIRYREIcw==
X-CSE-MsgGUID: B8JRXkGIQNi3Mxc8s6zhFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="257741722"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 07:50:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 07:50:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 07:50:27 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 07:50:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxdRb2sANFjCAteNCFmlHeYlDSa5QSzXp8Wo25zL4RsVc1bnITiICR5cZJNcWzt0N4D1GVad4ZC55KGQHoEBm0W9LtgwuoOsH9NNFDJ9RZj7dWF3cEdboy8d/buTGUr6lHyeaSeLokvlm/qcZGCDDpxZbUU0afl02J2QmAzRFXuRdP1yMFAK41fAMm2K83ANspjg98MC1URXPGiFNXDcjNrRw10PszoIKd6Cs2rd+kmYQtILHHtAEFkWFanw0q+NPupfJ/jBaVAnp/muux3GGyaz/XWJsQk2Mki02oH3agFp/6btDQO9VvooXa5UNIaMlxhgHrwsZWeBcOWtvRNtrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8s2psFoXH/Jzc4POkQnq+FxldJ988twIvSuk7eZC7I=;
 b=hJer4TKinLDNog1xVEJ0CsULfSC9/xKf+6H+J4GOExNTGH5wLtYhBER6/5VKgGhPJm640u6XxhNH5KMmBQRABGrpnCcAYD/fnXuczQpQLKMG3UWLrvURalsJijEg6gffrDSsB0Sn7tNwtWfYsk+sCS+sfo3OeCIdQuxbtB4/WlNCZ+4f1eIe9zEHB0nD+5pv5pdWLchlpwEeslkdneWy5Kn6kCDJIGGhgI1H2Qe9607S0+AuegG3qi9W+nd+PAwd4KtmclhYyIciT44pmuymqj0/ShXz4Xqwp4Aiezb3UO4zAzu2swOHONx00tRBeZmOv+0voUH2IC81suN2QsvJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS7PR11MB8807.namprd11.prod.outlook.com (2603:10b6:8:255::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Thu, 13 Aug
 2026 14:50:23 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 14:50:23 +0000
Date: Thu, 13 Aug 2026 15:50:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/2] iavf post-reset state restoration updates
Message-ID: <an3ZqplYMmofuVWT@bricha3-mobl1.ger.corp.intel.com>
References: <20260721130814.2950332-1-ciara.loftus@intel.com>
 <20260805125735.3900483-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260805125735.3900483-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DB9PR01CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::35) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS7PR11MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1b6d3d-b09c-4bbc-00e7-08def94a342c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LWzjNDMFp1PrsHbjecSHoD1Y0aFJzD1Xp0gWwp3u+raw8AjbAHbpChQuyS+2mKBg4dVqoeOeFKdqvyyuCpa+8s7NB/jVPJ3e9tTvte9jKY0luSVVQ0282Zc/Ls9spjFnXDUNHIuvCta8cJbPPXnY167Vmn2CJlAhl7Yeh71iyGNLSKBhvRMFSo3E0FnOJHTNzk4WfL31BHqiJpgND6XjSlAklWFOEcjlywmtaCyL3TJVyVFFhieyalYoXFMa41RnWjsMxLbVsFHe3uRn7OsUtppHSWngiPO0Qvyd6BrGiluK4II25u+fZMTt2/5/WLc0FUzf1jq5eeQP940r/IKhlhqEDUftOGoggWrHHmaxYJVmNIkl3LtjC1Uxr3krvqQXHOOoBM9I0F6eYcVEBnfieo/FvFubfIWarKnxHtCNf6Y/vujJYHa69kfEki3s8GCaK+H5GMN7vlnha4Y85dWIoZ/rBrn6GfUiRiWE2yRxppKQ/A6WkiePD4LGbMavffyj09KQcP+3QUraL1yPUZgl4VusWYrvYmkqCsrN2k/Im9SD1IxjdiqSWarue3q7APtmAH1C7Rlr24YL/LHO4cO7P6BraGU/rLMoMozTiGwR+SjSKYSGnlUVixfzrmsGQPeqL+defgSL77uzux/hWeWgrxJEcSlX/+vjVjokuQQ5pTg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2uAZNwvHDmKpPosVJn/yRn7nSxkw2IuIkGBoODVI9wWp53+2+9m9qAtqBobx?=
 =?us-ascii?Q?OJWVPDZWOWJbHAGMFk6XSWRS1BiyceKL7NpddM/lgse2X4GpgsEJDGPNE6SK?=
 =?us-ascii?Q?RRSqCPec2qQlKseY0Okfk3OLxDP4juM6UJyOniR3n/cTc8j3sNJYRAsywXsr?=
 =?us-ascii?Q?B0gxO2Y94VwK6kQuKek+XzkZmP26/5sosK44hNXOaLNnolk3BGsw0jXbRAy9?=
 =?us-ascii?Q?0tOiN3GggKl7Xpt9/4U3HDjW9ETLjcrAfWdkKhj3Nz8qYE2nHm6QbEo+RaPS?=
 =?us-ascii?Q?PqpBZyJLyZ7pUfJOwgZ0vZfN/tDhA++gCrz3KMoB1qlLWm8gNmt2vpMhWiry?=
 =?us-ascii?Q?1J3YkWGjJE8dzXik9KWu3O9Fj1URsnWdic5jJoqhS5F8w3UbBqs7elrsqPhJ?=
 =?us-ascii?Q?3AFZ038T3th3FvLgXMAZ2Bxx+09tCcaSltZaTKDMfHrL+ch21u18K6s4dULK?=
 =?us-ascii?Q?rW4vrXdVELBSMrVoWGVNKcxjK/HuNZobu48UgYLlZOVNmOAOXqPBuzo7rLKx?=
 =?us-ascii?Q?3mMKQatPtC6fgHBNMHcDGMC2o9Nd/5av2mCugKyThRuUifeGtCH4ouftcVqz?=
 =?us-ascii?Q?0A87AERXj71u60pzCajn1jQ7PpYjF5181DZULvAdqZiq2bAcbceTQCBm/v+U?=
 =?us-ascii?Q?rP6GTHEnit5ywOSwx5yLoLO5i0XR76a36yXnFK2eOWSeHOJXoVWj/X9NpiSy?=
 =?us-ascii?Q?aopjodht+e81kQAykeJ83V5tTTfB7DclU7K/RGANueeGKrWmIdvf8m4WYUqD?=
 =?us-ascii?Q?WXkqU+zKz2ReXjzLXZJfiDFbeq8g37rNy6AWwp98wAouvdDKyZktVRu97+St?=
 =?us-ascii?Q?B81oJiVnBvRcw+DfkP4apXPZm1uDcmqYmhwvix7Ws2gfAzlQGcOjNeLs4Wsj?=
 =?us-ascii?Q?11sTcq8qz4VmSJck9lBPIkZ47z9uT3P0lQAS0T22ONgr4JpNuQP/6KDxHyEl?=
 =?us-ascii?Q?QEZI2puaMUnTYM/jLnLGB/yshz+5gN6TcXigyw8kzrHePwFbkXWxYXa0Sk0W?=
 =?us-ascii?Q?QgS/6XAwRSol/PIBxVQ+lLTt9qLw8XXkxeN6xuSw/c9uhbrGH1JbfZRid1Vy?=
 =?us-ascii?Q?r+MjH/F9MWHDp/Z4qHOTmEVXHZ6DeEijKDN0YOEhAb7o58kwsywgMu3VJXoe?=
 =?us-ascii?Q?f2N89lyx1j5tyPY5sqBaZvfCwDvM1Z7yRnn71EzRbIpISrYHcMPkwBKv0ZfF?=
 =?us-ascii?Q?d0myYtq5K+Arv5wUE9G87khrOCef+NCNgekjlyP5/WJOh+8fQIQOphNzWHGh?=
 =?us-ascii?Q?5Hcdmg/0ll0TE4YXEO0uv5EMbiTKau0Hl/pQQUWow9LkiioQWDUjlua1yZKV?=
 =?us-ascii?Q?cbNt+GaS6bbHzdknmNgV16y75rKT4hVdHdOkxiaee3J/nKpZ32B29GZEA6gQ?=
 =?us-ascii?Q?/wdkdmrh9EvTJIm7UQIwBNMHduNAa6+wW5VmSsX4+jjjb884nRcIJw+27IQc?=
 =?us-ascii?Q?iSQ7N/50CvfsiieiKL8ljdgxPjHWE1fN5RvOpIvietiffO+iq+2l6HT++kVP?=
 =?us-ascii?Q?YuqwZahTsVXVLetKABjuZj6X/EYQIh9E9aP3eZze9tQ4ciKpMo0Rz7c7Jd4x?=
 =?us-ascii?Q?F8v9bPA9eU61C87CQOMMQW/tLYcKryZuWMqVjSRT/GMQf8v6zrXkakeXrbvB?=
 =?us-ascii?Q?R2FIWJ+75HC9AMb9hmw2heF6wcOc+85Vb1oqS3DvEeW+QWSw6AhyyUme0xpY?=
 =?us-ascii?Q?iYQqV0KtBOf2RsSCoGSrVfHmvmv/fePW36wEE9AiWA0T1IvlUTwvgb0biRLn?=
 =?us-ascii?Q?+DUDjWFQV+4rpDibC5IBPVgQ6tQiVWk=3D?=
X-Exchange-RoutingPolicyChecked: H3bxIXXcDQ0mLOmUp7E3NMgUU8h1F+L3orcCpEavPzmA2fQ04tKWUUEBI5/od5QvpVMzEC12TZJoLOFr9kcyV9Vo5goNPzktDKYmqRy0ONe3JMqVkkqj2qOIazt/6wSjLgzd/7jdS2HOt+dBGKfaP20rMoZBY7tkccT7a5ZidCgPCdui7fJV0KewhkKCc1KQQMeURjkbPXFHGxzVnuQOSQLGLjaSAzga7VY0tu7jGXa6NX05ws+waOfOP0JnZ1zuFKIk7lrjRPKHkId8ikdZp7/19NH/wZDq0SQfzYhdu5SP3mXSSypiJijRgHRu7PyhYz+L9KWSjIs/olr87NefeQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1b6d3d-b09c-4bbc-00e7-08def94a342c
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 14:50:23.2976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ti7E7cCOt39bXZ0guKI8mUfX4JfSYR0gZr1mqPitDOXiTfm6KzQd0C+E4425eMQZA6PJaZLiBNSTMSPXqQ61nKyTkAyFjslyt8LYjN2/Ffk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8807
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

On Wed, Aug 05, 2026 at 12:57:33PM +0000, Ciara Loftus wrote:
> The iavf auto_reconfig devarg was marked for deprecation in the last release.
> The first patch in this series removes the devarg, restoring promiscuous and
> all-multicast modes unconditionally after a VF reset. The second patch limits
> this restoration to VF reset only, avoiding unnecessary work on dev_start.
> 
> v2:
> * Remove deprecation notice
> * Move release note update from 26.07 to 26.11
> 
> Ciara Loftus (2):
>   net/iavf: remove auto reconfig devarg
>   net/iavf: restore promiscuous mode only after VF reset
> 

Series applied to dpdk-next-net-intel

Thanks,
/Bruce
