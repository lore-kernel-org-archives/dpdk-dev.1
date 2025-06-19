Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A810C7115A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 10:41:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DAD842D72;
	Thu, 19 Jun 2025 12:41:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 165B64025E
 for <dev@dpdk.org>; Thu, 19 Jun 2025 12:41:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750329678; x=1781865678;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=tOACQWGMrSMOGpQelBQ8qUOS2Fm6GiXhjNOWF7OKm7A=;
 b=EWPpdp0dVoVFEWLACXTgCKn6Ir2IRKrlnFiCW8huA8KRcGVRV/LeZVKM
 m9vXeUqn+4ObtoVFDjkJ3bw3piMesWRaW0AM3JR3dTKOPRO5owwxa0ZEV
 QxQ1YJS/aTZ3JPD7/ggICY2w6ffCJK+wFzEN0N4TpRE0yueasnS8+KxET
 Kpta0hAomNIHcoq4pQq17mXwNCyin3geO/ed8jODkYc1UMkWPM3eCBLaX
 lnZmzEZu/f+lKzzS3D/T3RjAmNIeaRTKonXY5sAt1PfscLwZXVfYtLf95
 o8Dq94jRVlLouqChERHWij5WCR3OFJQxpj839YFoYowXyGcgEE3i5HR49 g==;
X-CSE-ConnectionGUID: 055m2LjPTvWBNMZlEwoLBg==
X-CSE-MsgGUID: R9cko9E3TmqaZ2NnlfKUjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="64009699"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; d="scan'208";a="64009699"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 03:41:17 -0700
X-CSE-ConnectionGUID: V+oCZXYZQGSgXPowkamfBQ==
X-CSE-MsgGUID: sVyP3UmFTwC/nXotIz228Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; d="scan'208";a="181644182"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 03:41:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 03:41:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 19 Jun 2025 03:41:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.74)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 03:41:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDFCw5AuRJuIzRW//Qpx5m8Vdko9vAJVA60ILJqTNzhlD/R40Ksmrsdc7jXNZTG5qqIZIY4DldfX4C9wJontY0e+ABKZ0KPJK6jKZTadzegASm5qyyovXT2fkO3ZEi0pgdkF+QsjLR9zn7VlQKR5n97SYUmVGLbRYkG2AscvLq1emTpHo5/Q0POI1gxcZ/8LlB7X5IobpE0MXqwzM/vN5p/2sokQc4S/cSzVsEOcW3+H3QCZWM3HAbltIOmA5waBy56aCYQ5VkGcGM40hvTMdORc3NZdNpF/LdX2n+hAmCJ9t1W9VwVmrs9/SFDXRDL1kM4DMEW6UI1Vgiw3OArRRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOACQWGMrSMOGpQelBQ8qUOS2Fm6GiXhjNOWF7OKm7A=;
 b=V6MEDFwTPsfK+FZnh/bsFAgM5jN0EFnNh6T8Ew/EtIyc4+QEPQlA9NUJVGLJOi4dmHBQWMnhKqEdOpkquvk/01q6cH1ybqqcNlDck2vE8iETssCHD0fHVGX4nBqPQxz6x64pp2LoMDOLmXncaCzbvfYS1Tnbm5I1sXd1/hWnLMWSiLl+8GWVk+gJtEm86doyGYDp8l3PyiFiNFvuInapBeIjRprQ975LooqUJhrSDTh5nX0G2K0lsIvZkjZWHMHx/HCEdb3LORIvfnWo6z1oHgQCFc57ybTCjnajn4Fx2PnaAor59xD/g62D6M8YcoQE6Mgsiby6QpdWzN2SW5gPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB8084.namprd11.prod.outlook.com (2603:10b6:8:158::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.38; Thu, 19 Jun
 2025 10:41:14 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 10:41:14 +0000
Date: Thu, 19 Jun 2025 11:41:09 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v7 0/4] Add TxPP Support for E830
Message-ID: <aFPpRQIBrkL5DmTG@bricha3-mobl1.ger.corp.intel.com>
References: <20250617051337.563233-5-soumyadeep.hore@intel.com>
 <20250617223614.568996-1-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250617223614.568996-1-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DU2PR04CA0204.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ce07c3-d4bb-4517-0de0-08ddaf1dd0b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+/vb1SAbTRApO+4EMmXQT1+4TtMGTwcq8ccGhs6cOmPSsAZOc4Bip+2NEzTo?=
 =?us-ascii?Q?3GNRut0C4DB6Ogug9zUtSHvpHpngebiuBhpAY0XkldBQt0HqWdV4Ccfc4Z0r?=
 =?us-ascii?Q?hiwAmQ0fAf6zBPf69wLYMK97YlXluV9NuhzfK1RJ9pq+UZkXMZb79PmKbmsC?=
 =?us-ascii?Q?61XS75vvMTDkG9FusR4R11da6xEg9EWlDIY0zAFA08GVei1n3KqNfogAh8II?=
 =?us-ascii?Q?Zseg+v3323juvDboiYfSgLPoRn0FQzIZRybzJTLp1khIg9gtVJhVumq3EKL+?=
 =?us-ascii?Q?D4mLiB/hpeTFNPrbyqo72ar726T35ymZpGLDbhV/El61XsGgK774vJSEOJkL?=
 =?us-ascii?Q?WHzgoBAvvOyWd+woUjX+ywjcRx1N/K0Bq4ZlhIq44jXl3faDXiQrkxVZ0dyQ?=
 =?us-ascii?Q?hUeVJO2IzVHqY7C667sP4ULuI2xUOE3AlucYmKzIY70I0WcZq/aCsGGRgdgR?=
 =?us-ascii?Q?g5Gr1nuUhSygdlrMZstH+REUvzpiR3VjGfElREl0gKC5KD6yfrdI7OiQKU6p?=
 =?us-ascii?Q?uIehdeRESOljQE+nhfhRJZC3Pe55N2V+eVUkmsPefCzSSy9ROrFkgAZ3hAr+?=
 =?us-ascii?Q?yVmez229zMuiC3oR/AJHq2ynVA6kBKFGbonFIK2GQUBA2rOGXET95AZ8YDup?=
 =?us-ascii?Q?76i3k5blvXa0NmFdz1KCD5aWSavIKS2FELh+xz8GPSKQCujCWBQx+eaeFc/Z?=
 =?us-ascii?Q?bGvIrdAqX0hhRtOhQIIBDu4qUp+wF4lvdL58+lbe4gzXftGnKtoHO317OzY5?=
 =?us-ascii?Q?qiTxDQDpdEWIRVLzegYhcQB9Yr1wWYlGZgVP8cnFuuc7aid30MYY2SCd+C2y?=
 =?us-ascii?Q?QmuNXE9//I5l2eKJva5mCYaEQy+tXY5HsrxuIOBbioVDBAtQXgBFJsiZU1Kg?=
 =?us-ascii?Q?NzE5I4yRdCxefwF7So1fZsHCNRh3bQXGeCQPIwHOtFn36UUQF3AkCrhvwv3m?=
 =?us-ascii?Q?9bGEzjkXJHBzcBqoEUp5CWbBcTrAmOuAjTiZ6ofWs3U6KNlLogoD40Ap86CX?=
 =?us-ascii?Q?nlBWHy5TrCfQYeydlnOjImXB0Oq45Sigc9WbFcCKcaP4Ai/gkfTfTLwSptSQ?=
 =?us-ascii?Q?U9P7wGcpXDmoFfp/Fml4O4MBfYaAmKeT3dh+yHmio7NNNE4jId5WZ+LNbvPs?=
 =?us-ascii?Q?sskwk1hVyS4hQcE+hIIkfKHthhOzBbgjdvdcSDOtQa8DiSd7lHIzG8rLbYA5?=
 =?us-ascii?Q?vSltmM+ohYfCq8Fx0+6OKb3tbDQncA47SPBJQzhPdLVJXlnGR8U6NMOqBJaE?=
 =?us-ascii?Q?Uj1i2s9oOU2ebhbpkGMxPv7vp4w816vUYG6Argf5VEhvmS95reiCKRczHQG+?=
 =?us-ascii?Q?6SeB77YTrwIBRMa0SIKhdpuqsVQ8a+JS4Y8gtNvruRSbMpa9+QYC1XRzmGK6?=
 =?us-ascii?Q?+RDeLq9CHoq8Q3viLA+JaIN8tiQoj3fkhn9g1LtDsNhU/FjUyNHgUTe8gH1M?=
 =?us-ascii?Q?PSM+gp3CgUw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P3Gks7OKa+eKloyfop/QYnZS5gxNjWZjWNuYkE7yh5fQZTXfaEbrbYF5HrjK?=
 =?us-ascii?Q?DlE53pM4M60I8VhqeVINXXIrByEHJ0uDcNVG86MboQ1zurkEqB3/WBjnDrzi?=
 =?us-ascii?Q?4Wgxek8T7YqX/7w26iGoZJ15L9S8MaAO8yXQUwxO2hzyawK5RiEEkoabe9t6?=
 =?us-ascii?Q?n3VOFd5MaCjEEGw4ei/ezGrzYZi0LngrLkoF/dRaZIemJd6+Lw0FYxjtuRb0?=
 =?us-ascii?Q?5W7cW2thm5aTvLqn4aiQWQvwwoQFZT9ilfLJP55hUpe29XB3tNUcL2JMfs/E?=
 =?us-ascii?Q?l+twA5rydlsSxTs1SJFslTa2+/ukbMEERO80rJ4RQFXa/jIShoUkLsQrJeIM?=
 =?us-ascii?Q?x4Dm9u3pdAHvapi2EWNuxdvSUD+Hz7dATSm6aTw4Spaim36a8V/Xv5X/i77t?=
 =?us-ascii?Q?8szCon33X4YK25sMuhhueGsvkES1qt1bH2QFns7M9mfGKLjRN0YvQ6T98Cjp?=
 =?us-ascii?Q?f6AtMEEB5CSzEpjQeCIe8NbW302QvQ4GyqGxlVgls53AylToDrehV98D4dFu?=
 =?us-ascii?Q?rrR2KG0ZYjFsOSnB0v3HwyBDD1l5duiLOO5P53zVRFKB/NiWE0BzBADpi6oP?=
 =?us-ascii?Q?Vwf5KLXQeAI0zUDevZG41vkTi3QrqdNefxyEUKNf71xgOmXDGqEomWJ8oClU?=
 =?us-ascii?Q?dabcYWAbYXbHXXStsakdxxblDg6p1I0UKOMqhdOzDMakiS/KmKyf3aOCtrua?=
 =?us-ascii?Q?HPxgH5hsoRZ5VfYeYFacsG/BXBTzBvUwTJPwJh7kh0Ur8YcmzEK6ZIsrK6di?=
 =?us-ascii?Q?T9ZYtEHNsxVvYUUI8uyn2LwyoHbK+UgsTR9ZWNmUsdqxMN3c9vrQUqWWD1NE?=
 =?us-ascii?Q?3PmO3W63fxkMrzlWlR0IOvzT4s9+fAxnQU9RS0QNjPUkZGGM3mWJ2IMG6qxC?=
 =?us-ascii?Q?bKPa7cnZzHXqywNxLAYQ4Dd0ngHIxM5FTX5uoUWl29uPnf7goUdWRQCXKnC1?=
 =?us-ascii?Q?hI+kbvzD7JhvvoR4cp8z0M1t+OU3MssviInRfXbV8Cm9Cb7bUKSOAMtcJLGq?=
 =?us-ascii?Q?U+Ur8U0Vy9RUHVFKS513SDMcrRG6RDmcOx22Wwg1t9Zz75KEWpmloMX8KtCw?=
 =?us-ascii?Q?39xl3CwPGihkHrTVQDmj9HV0E3sucKI3YZiHmr8aJ/Ua8LrfX2NarKp68dLI?=
 =?us-ascii?Q?bRIaTlh/3NZriEkcwrMg7YFFb6kerzukMim28Xi2sHazvCkMwCz45RE+gd2h?=
 =?us-ascii?Q?gg292S1vhXSgVLejKbO/TOrAvbouffPIy0PQyjpixz0J62uGk4t+fIHxFS7c?=
 =?us-ascii?Q?P4q7QkeFxigffC+YlqSPIY/P09b23IHDXizJucF6wCGC3nauJRjWyiUxhXH+?=
 =?us-ascii?Q?GFxFVNPlSs0r0GBLLH6oJBOvth6bgDGxrj7sQdBS/qmFDk8cf8vAcotEnFdK?=
 =?us-ascii?Q?GUaKn7TrTGaym3nOOIpmMsOVUrjDmhIeoHZOKMy8/Qev+o4q5RjTPC9rSncY?=
 =?us-ascii?Q?D7rCE5zs2YUAG29SNjCQz1V6lXPA1HnmuaRv+7xp22PXhVtp1oqXrJ/0YGUm?=
 =?us-ascii?Q?X0VPrJZZ7mdqHdVhK/k8wpHHCutRfn+GoLPY0+j0M0Gsi6Zj1tTqf13sBPsX?=
 =?us-ascii?Q?gkslei83p3RGbC93UfmnoNNmdLlUWlMKQSAErf7dAQWCvARx5n6A8j0T1+pr?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ce07c3-d4bb-4517-0de0-08ddaf1dd0b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 10:41:14.8119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNBxUEcur2bYQSjxSVRb4etPvTRH0fGX4/Bq6NPH7Gj0bnX9LV8Ts4KkkYfc28NIH4z1PMHCsDJFAatShwODzziv1/VeYTwX02DsLpCyw5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8084
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

On Tue, Jun 17, 2025 at 10:36:10PM +0000, Soumyadeep Hore wrote:
> Added TxPP support for E830 adapters.
> ---
> v2:
> - Fixed Compilation warnings
> ---
> v3:
> - Fixed further Compilation warnings (uinitialised one)
> ---
> v4:
> - Addressed Bruce's comments
> ---
> v5:
> - Addressed Bruce's and Ciara's comments
> ---
> v6:
> - Addressed Bruce's comments
> - Fixed compilation warnings
> ---
> v7:
> - Addressed Bruce's comments
> - Fixed Windows Compilation Warnings
> ---

Recheck-request: loongarch-unit-testing, iol-compile-amd64-testing

