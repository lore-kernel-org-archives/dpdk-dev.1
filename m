Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22AAD7237B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 11:54:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FF4A4026F;
	Fri, 23 Jan 2026 12:54:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 239AE40269
 for <dev@dpdk.org>; Fri, 23 Jan 2026 12:54:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769169246; x=1800705246;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HG7lg+5VsD2QSu/JdzinunCUikW9kPLV5mbPyGwt9zc=;
 b=gDykvL8hMOkMft8areYB8WoG1xIrDgQ/ARfixX30ixyt3VAHsxf+0ody
 R4mtwNnagMAW0sykk6cmFIro1E4xWfe8TCvQt8cfSaVIrHscoF8Vcjqjn
 hbndxvhA25FHBL8YyDtHQLQcYzHLxwkstW8bfodDkTALuyORfIpl5Uh5W
 Puv/JM+Mi4sd0OE6dNj1FdrKXwxJIdKPXJHc0oysn3nNg3Dj+4jGru+NP
 Q+IjqiiCmTmC3zf/r2wkLUaCcXC4gM/Vnkld+t1YHvt+pLXR+JXwGwiIX
 Pm7vLg7FOGCKzJEsb4wemn2HBpyvgeV/p0FG/meCUU2a20gDywYrUB7E+ Q==;
X-CSE-ConnectionGUID: rt+IPU+9Q4SDKjwvCOMQtw==
X-CSE-MsgGUID: xbOEqTqtTTKn2+B6Lhf0tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="57992504"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="57992504"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 03:54:05 -0800
X-CSE-ConnectionGUID: 0qygwuk+Sdy9efe6oewL6A==
X-CSE-MsgGUID: UvUx3oQ/Twyz9F+ag5sSPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="207433260"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 03:54:05 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 03:54:04 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 23 Jan 2026 03:54:04 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.23) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 03:54:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txjGG7175lLriG3dhPMB9IVzNPlgVLCcSLS9AmNcsZ32AgW/+dmUbB78Zr0xjWXhol4oF3RaZTD9MBz0prklZ7w5dzDAm5nAVFWSJVPTsw6dQiHmvGTCKXsLUV/nfjQyD0OCIYi+EIlF7K0J+PTuRsSh4anzPfMVgsds3TFYvfR/SkU0BvcOV40Va+t82YMHTuwtYePsH3qPiR+9gNoeMPio9Z6+/kAh7DaLc+tgjx07ImgAqJ78dJD4IHuFHeV5uVhllPmY19G6giVka8svErJcTNrlFMvzTBTZcSvHRV8c1uGdkrs6ldapsdLo1EAlAT6IvCgARm7OAPw3+YBQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bx+MrESISUaAST9gqd+c95Nzmw7FpoI+b9S8PuZuTtM=;
 b=gYRMKBeuZSRsqSIEqY4RUVZDCHJhrwqx8mdgLoJoqf+98EHgkjDUc89yClZV8cEDLCTbAGVzjY/4dubF5nYsQ4PIyujb+bQN0DGuVZ+r7xnmfSw3vH6kbcO/AtLXIf4L5ORlWOdigbpqQiZaBXPoiJpLFPMkIqIClMmmUy2E+MvHoL1fHAdS0IlcSR7il6B2rcaK01//RZHT0Ozc0viXbzujhTetdsYm0vuAL1IqimQ/kBP0lUBA2lSRgrhzNsCkERgwmCS7MdIvuXMhQ8wQ1HnpejXfeMeKCGHgSmT0o04ey3drlYNeHQ4UQwQQVBQ/dhkrc5y3yYzbco4ZwNKw6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN0PR11MB6036.namprd11.prod.outlook.com (2603:10b6:208:377::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 11:54:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 11:54:01 +0000
Date: Fri, 23 Jan 2026 11:53:56 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3] net/iavf: support pre and post reset callbacks
Message-ID: <aXNhVGHTidM8f3-n@bricha3-mobl1.ger.corp.intel.com>
References: <20260114132159.644359-1-ciara.loftus@intel.com>
 <20260121124250.1999260-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260121124250.1999260-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P195CA0001.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN0PR11MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: af74f0d8-115e-429b-5827-08de5a761940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HxN7MF9e1YyRyCHFS6oW7m04FAKYuKmZrbKwTYobFeppyijhg5JmA0lTci0a?=
 =?us-ascii?Q?N9jULD3FaCImchacFv7wwR2eSoYiB2OlRc6Wc9yxWdbMKH8SH7rvCGk9aLge?=
 =?us-ascii?Q?EDfGOpQf0+emgNt3f3lqrHErApGaChJbHKgY291CKKHfJQdXLwz4oDGdZ2Zi?=
 =?us-ascii?Q?j68tP8myzzGztepYqbM5d4BOKevxyK7Czjh9E4PwBlgNxmZ4C+kgRCXuMDeu?=
 =?us-ascii?Q?0JnEagat1aSajuY+gWrkQT/R1/YYa4CASCQycXKsnd1YOi+EpNW4j6UsB2BD?=
 =?us-ascii?Q?i7r+mVAkKM2I7jLNoESqnyz+Xkg83GHHrEVZdvej5QWABkkxh3cwYyeI3LyR?=
 =?us-ascii?Q?BFaw8gqfI3c6NMZKfofRNQ85Spn+H6aMEBxAAjTAHF4UFC9KSHWGkmlai32m?=
 =?us-ascii?Q?JyfFSaRr4Lvw22wwNHmhVOw17pw4lv/qf4hNSzv/0y+xTNEEaGUsmfFgaK3z?=
 =?us-ascii?Q?c5AwdV6MzZyuH8fN76zctmfJKR3YbREj6shVefk8USK0jYOkWzZrhqxqTE7a?=
 =?us-ascii?Q?dEdQAJMH5knAY7TtBECOSw1B2w6X4F3lD/SOjzk6VVKVEtgPMcvoyeaS6rhM?=
 =?us-ascii?Q?w30Qv0I3SAzv7dVpzRaiBPSLQM6UMZr1xs2gMOM8Ek8/OVQ8ffsZW7tMpgwE?=
 =?us-ascii?Q?V28bp6nFhGFbrQeGYCihPDcfAWF/DLcY4Zi2s09zWvHEiKcWQj8Bse51umcu?=
 =?us-ascii?Q?NpZol3L+I3fjv4Uvz6y/e3EzZpkrxtkkgAyLTq/1S+3XI25iypDlJ3pyoS5t?=
 =?us-ascii?Q?Nsy3D1r+Cf9uUObqW3jS/A/n47xCL32nC/StABOPm2yJmHUCu4c29MvxqcBy?=
 =?us-ascii?Q?omK7WUW/1iX3JLoMsQhpwi5LifrX9Jo4fqcBjYukeQcJWLK0JDJx3RBoGTvU?=
 =?us-ascii?Q?5gDBYUyl8Y5Ny28UdCKt+N94tyRKagbzamUi8EpO8vwN3EqVouP5JiALygxC?=
 =?us-ascii?Q?PeFpRq/V8F/MgE4QEY5PTQEKzNpwOxqmrf36rAlNK4LBANpFNs83wjI1Bqok?=
 =?us-ascii?Q?aDwCCp3HEiVqX1QVcsbVPWeb3HXX5vDcOz3f/EFcxr5m22rUD7dgefQXoyOe?=
 =?us-ascii?Q?qQ7EDIiyPE7vORPd3ItVdHNQYvX/4GVxciQ2N/ghNixEEnN1lskJc8tginr2?=
 =?us-ascii?Q?n55dWR44HlRttFsXlcwpgX53kfJtRfC/NgJsVIrQZpUAuO4GNfbxsisk4R8O?=
 =?us-ascii?Q?du9OJzXszZETMOz28tcKqxSjJvBOAStPP8Zw57S0HQL6yxzdJcfwH3G1fKUM?=
 =?us-ascii?Q?WyxgnPVdY4fSYaJWJH0GV7XJKIg0ckOSuuzJCqktvm9jP7S4nteXYwpQ1RyU?=
 =?us-ascii?Q?MgYS/z/dVaM07iOMiCay3hCS7WkcUjQH/kt8nIJYhFCvyfPFWvGucInddJD9?=
 =?us-ascii?Q?7XH2kNMmj7z6r94K/mFuVvE8wPY3CyW/B2dgjsoNJImL23oe53GFPswSNeHh?=
 =?us-ascii?Q?gMVqnyhavvnToBLEi/EqRh3MjqWcxgbN7nziYbCKvJIe5qvJMgnFB7yF5ToL?=
 =?us-ascii?Q?bXGzZ96iRUx7nkgy42kLpjJMXJHbUaqqbyHre/y9TGzpgQADx61Z6jX96FmG?=
 =?us-ascii?Q?YtaqQVK42Qojb7XtJ6w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2jI46bNd/Nm+Ln0eAtORVgsp7+qQSOjwFDrhbUm8lZT8WQCbUkRxUzAWOFOC?=
 =?us-ascii?Q?B6Ig0aC2zj8MJ9nlJivvjCDmjLSBMmh7FjxB7L9PPoUM/cuopY5YDWZUEaZQ?=
 =?us-ascii?Q?QTXZqIW9LIUJsz27ZIqQumElnR+b26AesSVJtun4HC5yI9oNnD2RJJ2w8CFy?=
 =?us-ascii?Q?rnhuju02UPpM9Q4kjKL4kXRKsJ0D8a1ehMvmEzIPRv6/YTATRD6UZcxpOc4/?=
 =?us-ascii?Q?qy7BrWvLAAI20lzLE8RNHNU8B9V0QP49T9H5tkG8N0TJKl107Yq199YOTNkY?=
 =?us-ascii?Q?votZwPgkVJvu1x4tllCnyxRp7v5gvou1jUQPRpC1a0KtCbEdCD1aHdLqJcF1?=
 =?us-ascii?Q?xVm4yTRecdUsou6LRLcRC69zWE43tZGOjp4lktxoKOgP2tr23KLeeb6ueqSz?=
 =?us-ascii?Q?cm/Za7xHnap8OsYgNH/VkvU81WfdYb1VImWEizKXDPL65FJVohWj/vX/oPfQ?=
 =?us-ascii?Q?ItfvMEIH2HV+SkTPB60T3kl1Aq4ve1BxzYvuuBV70Q6pWET5sqdQHQNvQ+wl?=
 =?us-ascii?Q?+OyS2o9/uLGl1r2OKVdVbPaW86QyCx8gpTVSsE7HRN0So7VgMKFGQ84tHaJt?=
 =?us-ascii?Q?W9+nUsh/mkLj4TFp6PtCueXbndWbL6bJgW+iKlMseKdMXQSdAo/gqq8IDHxL?=
 =?us-ascii?Q?KQWol1t9seRTrbsYqeRcQB3f8sNkI0cl+0yM8TSfCcWOaQg2dUpKoZH7k5rZ?=
 =?us-ascii?Q?rt3y5T7XjBpl8PEeOpgfNAzG0fJxMlHm/Sv3cWZhwQvK4wFb/lM7If9vA/hV?=
 =?us-ascii?Q?17cy/ahOd0LfG+n7vQsU1nrEIyEumc+EvU7frn2hfjOqStbeFLbhtiQesgqM?=
 =?us-ascii?Q?LIy7k39ZpkYUXlCShhYVe/yNTgEnmKPlMqF6wS/NRRVaQlqSOnHgJpWsLB1Q?=
 =?us-ascii?Q?Q/Df2tPLSAGmZWran2L1toMzJbxRH77xMOdpZpV9lrcWNC3zcYmfJA86c2Lw?=
 =?us-ascii?Q?TVv/Q6+mC+R44QKwtXr/uv2EaLj8y7NlAJRoyNywTpEH7VyhKjpXR5LidoTI?=
 =?us-ascii?Q?Hv36rQZBcfnLVF3u67Yab/q3HUlAxXcNCQTDtRy6Hed5Q3V1HjzAJMmIxigF?=
 =?us-ascii?Q?XKlv0XMuNAAnsjdbTTu3SBC2l9CLxQvJ7vCCDsK+Xt8kYPIbm1AyKPWUvnaz?=
 =?us-ascii?Q?LkQVbxHabUmq8euV2n/igwZHrVZ7xEUD1POS/dL6AQwCTnMis7/WDlXhquGy?=
 =?us-ascii?Q?L/DCEy6jzB/Gu15KswR3tuEB1ZjF+HwU5MHM+uAjUdGkNfGpExZ11UN7gx98?=
 =?us-ascii?Q?8XsRyc9Qu6+ee/Oyr3TqMpTyQT2wWKHYPNvwgT3MXamshLrVw4x0w8aKcT1g?=
 =?us-ascii?Q?y6BMyb40sTLeEJdb55CYwpK0NhxAB+xfeBMoglfcckC74Qna68BBcEG6j1fh?=
 =?us-ascii?Q?TfnE8Yv6HmrDrMEhxXKb/gRFAk+33iA/c1SYooSgoIa+2LyInUhom7HXsNah?=
 =?us-ascii?Q?cGaoqFKQfWZL6htUG38JjKiEcfhts5lcxxTvNVhKB21+x7ayqGW7NHEidWuS?=
 =?us-ascii?Q?nHzUMEMNVeNlDv7MBW1sbmB1IHZGwvKWog16jneJljsp9YcxVspDfRrOuueN?=
 =?us-ascii?Q?3HireFat/MhqMswPXwP/p0C51p+Ug85ca1GdpIxaABGD1JFabSSDmMvTJamo?=
 =?us-ascii?Q?oU3Ptx6o0h0ml/YNRA9ObE7oB9OEdht3VW2SmxdFDptk6FaWkF0tT14NSmNB?=
 =?us-ascii?Q?fHnH9H+upwAnPUu1sKwoZEAlKZG+nnfRT97YcQmHa8gPfwBCv6YeaCIbvILf?=
 =?us-ascii?Q?TbSwebW43rXnlPoJGboTgDr88unE6E8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af74f0d8-115e-429b-5827-08de5a761940
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 11:54:01.0915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8iy29HdVT1/yFXkmVxJAaEfLSd2Nlvr9O8LQyzSrkFQ/VZPdgc34JPfXMeOmbtYgA5JXA+ilB7H+ctzxZyQx+Yrg3/mhZD32E90CHfoc9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6036
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

On Wed, Jan 21, 2026 at 12:42:50PM +0000, Ciara Loftus wrote:
> The user may want to perform some actions before and/or after a VF
> reset, for example storing settings that may be lost during the reset
> and restoring them after the reset. To facilitate this, introduce two
> new functions which allow the user to register either a pre or post
> reset callback, which will be executed before or after the VF has been
> reset. To unregister the callback, simply use the register functions
> with a NULL callback and argument.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
