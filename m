Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8F8CD8CB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 11:31:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 876034026D;
	Wed, 10 Jun 2026 13:31:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1F54640269
 for <dev@dpdk.org>; Wed, 10 Jun 2026 13:31:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781091095; x=1812627095;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=4RQMMgJFVIfaJsLV2jsa3vzf5G4JedyeY5tK/2RT+h0=;
 b=A7FS2cX0WR3PChjw0zVc/3pjJRRAi0sI2JxoSjSRNx9JbOAGwbCiJRqG
 8bAPH3sfAre21UHfExcQAQetsEspzL81nD9s3eu1VOXiaaLPqzN5QlcbJ
 fF4Mp3mkpeR2yipZpRc3kJW/Y7bv47tZ4tgUxd0m2aRZCn0QEp7NEYR/J
 HWDKGyq4J1l0MiCAvIgwCG4OcBJAberppENGLcFT9C9jMxcklf4Dq11fR
 t9maXbq6iYAStTdGw2psmnPjRliEBKQqJKL7xAkyTZQeUvwe+ZaZ/Bqay
 Xdkef/qev/2sWsSNyCsSUdPbMlllegPaVmF7qCD8q8FohIT2e5/G0HtC2 g==;
X-CSE-ConnectionGUID: MiyQuLIAT56QLTrhgdyIcg==
X-CSE-MsgGUID: lYdfY/PWTMWggHpSZtInJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81884020"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="81884020"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 04:31:34 -0700
X-CSE-ConnectionGUID: VabLjgWMTNGl88FLKyGrdA==
X-CSE-MsgGUID: ka/bVkNnREKB/aV1tNLlDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="276347613"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 04:31:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 04:31:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 04:31:33 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 04:31:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1KFng2CyMvJvyWkE6hrXRR5xI9xozwD5kppBmdaQhH2t8IZsPw/htyd/qZnGmgNjQegljw1N64bLFs9QVSZre7QTYcfyyBoPBrwbDEEEez4Q48oViytpI7gKJYqysko3bQgc4MUxRebYNg7WihWynydKhcvssYI4PJmzhSO/kTjt/1KDt31R0M/Tg9eBKJ0N0BG/xESv9/NI+vZ88zRYLuFDSjPM3k5zEuI8WYSale6TPjRJ2aC9UzUYIrklKUP8PVDbm3Ke+8lATYT7LpIXIbKa9wdtucIV5d9GTf8zP5jKxugXJsTuKUsbCg7UyWpC3P8lVs5u67p+j5hkmYyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7UlplsiJfyXcgIGNJMO4oXupDwFNmbJnN+ZJkJO/tI=;
 b=aZ3qJqE6ULpfyrKnzQKXIR/x2TSHN8WjVej8vLTGrfeGk1ePs1SVThYvxHiZoRMn4th2ePZ6Ceo5nGLAMbSJVsLKauCgEGjH8pAsg5tt7+Am/hZTGZmM+JLlPQyva53D9qa2fgdKmcv4lbuAE1Dac1BNlRXW2lpSVgW5+0Kl+LI8Os+8OXubm8UNM09EDQIbdLLX7iErJ+2eYeWepU35L1pHohhbL7zEdhg5uRz2fd5UVcv4zObwyfkVE4dIgnd+Ziekgb2pf8TzHmyX+6H540Db1qNeOsoRSH48isBdxGehl13FLEpD0I/1Ur58Axj5MV2DfdS4gLbuO+BBsuBDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LVUPR11MB9812.namprd11.prod.outlook.com (2603:10b6:408:39c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 11:31:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 11:31:31 +0000
Date: Wed, 10 Jun 2026 12:31:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v7] net/idpf: update for new mempool cache algorithm
Message-ID: <ailLDte3Xo8jsUWf@bricha3-mobl1.ger.corp.intel.com>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260601183621.252920-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65902@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65902@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2PR04CA0292.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LVUPR11MB9812:EE_
X-MS-Office365-Filtering-Correlation-Id: 919a08bb-e877-46c7-8f5a-08dec6e3d1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|4143699003|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: B4R8E2JZrhTQrXGTrYwRvJH7Ko/B3YS1F7Zc7z6O6swuXpJUdqUkS/I77QkZnRjZYjIqlH/FlzYwkyRUsXOD9VeJEK3nNbvBbzFWLuKvWv7urartpu1s4Xc8S4WZ5fkpltt3hO0pjOzZ536UxgpEpTb0EE0ElIsgAzbkmUKrWeiJNoDY/nANdgM5a3sSaN2oh89vfwcbwyDr1HEIhe+i9uqvXTzZmngphm3b/1BHWiNvGN776uI+WUTXazraAbdxEkEugX8+VhvL6Z3vDPd9TjbbfGMDCrRSyw1gO8x1LBA7pyu7GYyUO7QHER+pdOUHdJAOZpeiVs+zUq2Gvr6MP8Wn5B3ijmrmxY3QnmODUOE5gEdDgXS4OVTM6EvwCY3Ouf0o6tG/ROacj85oL1stCWqB/wLKEPyB/rUywz176pP6UxhlotHBRYrLcnNxNzhPt4TJ4nXSg+7pbsvvkbPlRivRP/+LXpLBaLnHVeS43Uk+IzvGWm6r4Eug+QmUFsRvjQ3E1XT+8JODopVXcsSeWbZYDT/h4QJby3dHh3VXW+pXqfXacil9MxXT7jnkq9cVSUK9slp8dEDfFNFdstxUCSS5Im1X83tKxeXEcE1/cIc25RQ13KKAhNVmK1cgMvB+WuTaQHnRljBExSKDmRzkOxvLX44EYcAXnEkatUCCDrF/3+KsnbJQDPPTbaHLni6e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(56012099006)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?7ZQoZB8QH3ikPISOyw0LvJB876psd9AysNhTDvRpd/+MujV/76VO7OvhwB?=
 =?iso-8859-1?Q?Wf/Z9iCW+DHN6FncmgEyH9bBNTuGyWieiBu79rdaELIMJpUfCmyjL++Ql7?=
 =?iso-8859-1?Q?wJRddBI8rAlL4+9/8KWCYo1jK1Akn9cS2U+0HvXn3PpV1PI2HkFRICZOB5?=
 =?iso-8859-1?Q?Pu6Fhw6IYMJmv52my5VIhovzbyc/DKDN4D1snJgqkgg2nETxjd52OLlzOP?=
 =?iso-8859-1?Q?/P2NJRAQQY8UP/Uz92oNDilJgFoZJibPFThr1GEzRIK0fj6YBZxqlAI5LZ?=
 =?iso-8859-1?Q?J7eUh8Xi8q2xNO4PNGpQc4D2oWcGxG7kpvkLL7VIXd4rp5wsfjun9NaSYW?=
 =?iso-8859-1?Q?x14qCi8ZGF9befqdMrmpQDAu8R5NRVXJr8w5mVARjlpy0Y0sw7WWKHBzI2?=
 =?iso-8859-1?Q?9wnSBncRXn4Gbw1eFSuCcf1bW49c5Ay1W79eVTerm4hn78pXkIzXECmz6z?=
 =?iso-8859-1?Q?z5pUmgJLgK6fVd8kCpr9XQC4IASfjnU2yD53yHwKU4qLbZiPOWq+AHj+go?=
 =?iso-8859-1?Q?c23VVPHIt541S+7Xp/ICVuxBrBgLieoVR+wqmxG+/sg/ssDPZd0zVuEeUn?=
 =?iso-8859-1?Q?yhh6AcToYArz2aMIzjnfvqGI9NdqO8BbbMeMvZcKln2F2SqRqIDl3749KP?=
 =?iso-8859-1?Q?N/F6iq6WYSq0/OAOvPtEUBud74/kIH68LR0Q1YAgGsuND9vjw8Tg2YI6D+?=
 =?iso-8859-1?Q?l0qpqA0naBBQwe/4qCZEOTt43lVLsLm/bqwM4dKxtcG5o/1MNhIEqRh9eJ?=
 =?iso-8859-1?Q?dpR0LQ+fINUAxylj492u05U8oVOkMqyfEOtwk5GRp9dBitcWtoFnUw2+N8?=
 =?iso-8859-1?Q?uD94EbIe1pV+rvpJMahORZQqEnaO6ujhSSqDFOgoiFzAaOLUM0Wd73NChM?=
 =?iso-8859-1?Q?Ed7/7Ip0qKjpBNXlaDH78pvyIJJvObE/VZe3EF6o78M2XDs/RCHGChONp8?=
 =?iso-8859-1?Q?Zn3bWU52py+jE8cKGmB0xUeUnpuyQL+xr94qrI8jMXzgEd7dA6TCrTLz4w?=
 =?iso-8859-1?Q?3xsRMnuI5jW00YyzrK3rwEiyAv9R5L0ufIu++cHsysq2waH5HfbImv7ndQ?=
 =?iso-8859-1?Q?qnRYW3cZZ2SlqSNajqmVvv+fZFen/3FeIqNclN3Hpfn9gfcTK6ErkZ+dww?=
 =?iso-8859-1?Q?CpMqIgVEYrD83imfjNpHst13apUyOrbybVGcyJCSEuuisDsVjJNfTAsJ0u?=
 =?iso-8859-1?Q?PqwAlgnfWVnUXrThdcysD6RXBS3282zFsm9+ih/j03GRWbKr3dsVlKpV34?=
 =?iso-8859-1?Q?DmrdjezC3BYDktdOe2Q4l8uDKnBiIhsuArZI1bOCUaT/LNoRm/3fQqOLW8?=
 =?iso-8859-1?Q?kijXKbGfNgg8CCrnFr3K3y5rsS5V4Yl7UdyL62Pe8WPAwQA0UQLs+oeSpo?=
 =?iso-8859-1?Q?qIOPDWvI2ac8j0SCMYcXzWyUerfUOYLq/J9TtGFKWisAUGdR/C1Kc8hRPR?=
 =?iso-8859-1?Q?CRK7pwGsC8FhRitg8pt1iFeaXLIl3BkK9y3ooVCz9E0ZAzTTK1vUu1VNGy?=
 =?iso-8859-1?Q?08a//qCjEDffge8c5Uj6cV2PdFT/JqXSmO7QoHCdKK0Lwg4f8lH6uSYkto?=
 =?iso-8859-1?Q?RGQ3jQZJiZCbUz+/N+sjHeNlX/bIRAisd4mLZjeq1qfGc0tVvo7fLSm6KA?=
 =?iso-8859-1?Q?x+DtxE/p4s+I78tg4lhe3OF9Uljl5BXKbvGjdbN2uSotmiNuYyII6QhiLx?=
 =?iso-8859-1?Q?DlAKcDcvEitDmz1X+ujtXvfRk1vswpMW5fL63bKv++4pTrrJXDOs0z9Nkj?=
 =?iso-8859-1?Q?HRww2zeauBF40HejqOQuTZRQviMyIkA5xPHNGUs3/ZPmeoSpU7JnrL3Im6?=
 =?iso-8859-1?Q?WgnLf4+kaSNg8ILg+8qk6HjurCoUcwY=3D?=
X-Exchange-RoutingPolicyChecked: OHseCc92D3bilnXCDwJSsxdY4neEqFozPviPXk1h0PusROId552JGPMwPWydrr7sPqeo/vV2VD9bkDLvJIgbJ1nct30O8CnwnNwrNFMQfDEmqaG8PDhVvXXJS1weztCZfi0OlsuOXq2EIkKuZ+htCLmJ3m521VJ+5qQgqCtIHZmxOFeM06xbe3kaoCksP5MZ8+7/ozssUNpEPNMUGUDy/0oT0HxPvKwYHsqkvH02rCLgTPBsSt/MNFLpY1ydg7/FClwUOlQ7Dqbn7bZdYQQY0KyMUISh2VwYxSfg9ODiUKR6p5DhjQc4c8ojmuqF3XH2ToSH1mBZbBaKPK0ViybcCQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 919a08bb-e877-46c7-8f5a-08dec6e3d1d4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 11:31:31.5224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsyLXnRzCZuE/SuniEzmwgO+qI3M1STLWsTkXoAsXU4yoWMYBiCCHwEQ9mqgis+HQkJgRiVwc++zodmmL7eTBe2OTjiMLIE9taoW+c+gEf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9812
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

On Wed, Jun 10, 2026 at 01:21:38PM +0200, Morten Brørup wrote:
> Intel idpf maintainers,
> 
> PING for review.
> 
> The mempool library has been improved [1], so the idpf PMD - which bypasses the mempool API - must be updated to match the library implementation. This patch does that.
> 
> [1]: https://git.dpdk.org/dpdk/commit/?id=f5e1310f16e0909e7e7f71807123644c63b23cba
> 
> 
> Venlig hilsen / Kind regards,
> -Morten Brørup
> 
Yep. I was waiting to see what happened to the mempool patch before
considering this for next-net-intel.

/Bruce
