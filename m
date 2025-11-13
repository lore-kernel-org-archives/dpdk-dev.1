Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84987CD4F5F
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 08:43:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C082402D1;
	Thu, 13 Nov 2025 09:43:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 144074003C;
 Thu, 13 Nov 2025 09:43:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763023389; x=1794559389;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/ftQhR8LuRd74pi82RoEk8IsIrw/5pVf/y0PG+5r+5A=;
 b=IRKo0hQ0QpPl8TPrnHFxYZ/Ce1sv5Ms/UVzzdRklEBYio3uTARBonTP4
 Yl610PaqeI/1E/T/ukAQLVB8is01lg9WnSrpWRKoCTXmCug7ci98Mbmf3
 clUrrBReYp6okw1uQ+ggpRKxYrxuMNa0vIwZCRUNv/9Ry74ISO2Nufd2r
 0ip/S9EtFW5dSOX33n+fAy0gsUwMqf5OEnI/RzcFMpg/QJP9z/K/O8dGT
 mw4nue8xuM+i9/9hyZKAnk8EwivVViEN8XjWv4PmxDlWzA28UQjJYpK4r
 g1+sdJ1o7gRTINM8ruMWgIDmQRPRuut7jxmK30lg7BwxWWg/DSZpir7BW A==;
X-CSE-ConnectionGUID: lIq2YIoPSaGsOSVV2C8aEg==
X-CSE-MsgGUID: r8dc0dPJSRe05KOU1/a1eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="75412071"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="75412071"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 00:43:08 -0800
X-CSE-ConnectionGUID: tA37dG9qQL6zS11owaQOfA==
X-CSE-MsgGUID: +cTtZSioQKatK9/rx7srmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="220216617"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 00:43:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 00:43:07 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 00:43:07 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 00:43:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jE4UkT2UfWDuB9mLMgoWKkAhbznm/38CHseMVya08zuZ43djcxAid/W8eKWq/cyKpea+5muIHbk6IPTB2Tp8SEv9PjIZNzevX3/NQZMrMnW421MFrc+cmdgE+sVvxZffc0wd+FumSk7MK+oASX6cBG/j6VE6IMARDGNx2553MMRkqSw61TSVMFJUBPSUIpfodbwric2/wWjXtsCPtZtSV/bx/Ij93BXmT+LP4YQeECVUZFMcW6jvf2TnQwuhZvmCk9Pwwm+M+KsvJRkPa5I3vEAC+4489s253Ld+bS2dP5xFk2xxdEOO8suVV9/NwUimlhf0F7iif2nadss3QjdiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNHvEIy5AfwxVouZc1PBOHy2mEEAH4usmoNsVitktjc=;
 b=JCG6WT9k7N0zoYU2OJh4v282Fg/4PhLw5r8DTHYAybhEDtzvSmW47cniT2X0qDbSpMYGExHC8jWTbE7PnW8GVy1m3aYBHJf5bDs5/xucc0eQsCjpTAaXrvSZUgX6DHYGtc36GC+iMFnkkArBEAGO6AYd8mT6A0QyLdnoXWaSFE6bWEVQCK0bS8qoxs71L9cHJqcRE+4Y6MSr9ClsiMrg50KXaz1WnvLA9K4rOz74P61uXKftibpTBr4NTcF+fuOZHilFvW1djFtJkPKNUJ/GuLSGTL3cWZF0wRSTrGU8NLRJTJs7iKTTwTTk+2JMCQqsSHDqgZzxxE3J9wOT0rn+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB5180.namprd11.prod.outlook.com (2603:10b6:806:fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 08:43:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 08:43:00 +0000
Date: Thu, 13 Nov 2025 08:42:55 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Zhichao Zeng <zhichaox.zeng@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Ferruh Yigit <ferruh.yigit@amd.com>, Wenzhuo Lu
 <wenzhuo.lu@intel.com>, Jeff Guo <jia.guo@intel.com>
Subject: Re: [PATCH v3] net/ice: fix statistics read error
Message-ID: <aRWaD_fb2kG4Mxvr@bricha3-mobl1.ger.corp.intel.com>
References: <20251110080514.2506769-1-zhichaox.zeng@intel.com>
 <20251113074710.8251-1-zhichaox.zeng@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251113074710.8251-1-zhichaox.zeng@intel.com>
X-ClientProxiedBy: DB3PR06CA0016.eurprd06.prod.outlook.com (2603:10a6:8:1::29)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a927d3-12a0-484a-8e12-08de2290a6a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/URID/cemFMGv6Rcqful3BBBRN49l904H3O4M2kTBfL6Zxyl6ENQVfXPdKM7?=
 =?us-ascii?Q?YaDaWZ1bVzTlXxMc6GTcIWoLzDhgFoSxTgq/aa4gp84IIkK5um4XZ92NUqtz?=
 =?us-ascii?Q?Ipm4JjFaFZTwFXw7psH2w0VWYX6xkoPuJzm8hCQO4LplKCnGVVe2gvoHLaUP?=
 =?us-ascii?Q?GmdWkHzh7xLcDUzv475VvKl9o1+Rcwvs0wb2RL7YcwoZf1Cr/vhdKg9n2lzU?=
 =?us-ascii?Q?5XDkEWOByKoJZhSy5f2VpnHJmAhekeNnnEDOJudcSxPII9lU73f0adYMWJh/?=
 =?us-ascii?Q?a2AisDU2oNHpUl4zLbZfS+Agrgyek4oC+QMlw8EzT8YifAHXcY7EFC1HUQB/?=
 =?us-ascii?Q?sPYhJBdLv+C0sk6jyCS8jZSpka0NoGHGaZsE5v/rXFVOyeTqLRXivE8ngRK5?=
 =?us-ascii?Q?6Zsu72h7hsEbuEsik/5uPh5vO8He5FITgDfLC1rWg9CMAUwda3F+8m2NZ5QB?=
 =?us-ascii?Q?9kRuMIZ2JD16P6vqf19/H+BYgySE4xZV761TveAw1BHPQhKE6h92FOo9hGyy?=
 =?us-ascii?Q?uOTLDMOODieaekqDyIOLmqi7CZuBPFu1AfoHoC8mh3gFUPAowpMpv1Ge/eN/?=
 =?us-ascii?Q?ip1C2aNi0R0FP9vEROIUJ7TOmbmxHnbKGK+QhtiStbsNL8Ix38cjVUpeosKV?=
 =?us-ascii?Q?tcZcEEUpn31xpsWxU1lLz3jTHHnx4KzijfZ01mVHylJjMO6InEHnGme/1T5M?=
 =?us-ascii?Q?6ggdXvlbsZUCOzCDptuHxZQ78QH/tka+0PgvtB1sBtt11lpTeVsOn5j9lSRc?=
 =?us-ascii?Q?r1T7YdA7SSB8OsFDxY/rJZBjCc/wRKko4DYZixjiGaW90G1rpbNSmpQyHqiB?=
 =?us-ascii?Q?M4jGGcjFyGQzMtYKFR1e5hJrOXMeU+W7StQuOfKkwHAVqFCcro5yjjvoco7m?=
 =?us-ascii?Q?zrMZUnT3kOX9uA98JFjoCQB4dxRFvKrcxW7N41bbZFsRNpS5rOlcPteFuS51?=
 =?us-ascii?Q?CqjErRM3PgO8wOQP6lqQJYGtz65gSNGBSUDHRXm6UOxPsTrSOw3/Bfv+BPyI?=
 =?us-ascii?Q?cssgsB52gTiy6ySEjYlpp/epQWSXdt/wG+w4bUl/h402DwOkMD5HVrDslggJ?=
 =?us-ascii?Q?9Lr+d1YK69Lu/tsu1TCUv54BlC9CgFCiUYwSURfv2FOQ0SOBAhLhZWx5hk3n?=
 =?us-ascii?Q?Z9dflz4W6sVc9vmE7ho9FzkQWP4TV6zFcvmwTW4Po2HyXnZwOVt/9lHj4rgj?=
 =?us-ascii?Q?ZPp2Jl2CuH8ZFzrqEaaJ/puCzjOORsTndeZXgB6COoYRuyGTeQAOYxt5CxvV?=
 =?us-ascii?Q?o4FD4AWitunz4aOa/w1RKuo6YHBFefs++wnqo2ILf6IJkvuOF8FdMXQ2j3Cs?=
 =?us-ascii?Q?Pzp4WZgFnXnF0F/heHA0uqeRV0ewEb/twOIJq9KHyiDHRnqVoVZBij/V31qZ?=
 =?us-ascii?Q?nZ/47q6x6DaNqC/AQgKa3SfEj6pniA5lmtLxpySGif1qhJYPkmsj9Bofe1jZ?=
 =?us-ascii?Q?0JzCFlcqDm3EY0r7A9lsb/I9oetfkbg8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?foxRwMdEkfKaOZVR192MZhxRO+do/mOeU6T+ZJKMVVCH7zL25NN9EBtp0fTA?=
 =?us-ascii?Q?pvFXU2y6Y5sXIHUsAEkFIqAuiJIklS1g70/yb47UKxaV3/s3aiC+rL3QhK1g?=
 =?us-ascii?Q?+Eqx9ZKGNMR6deFCD9Gc3P9FSinmCfpjxf9G8rvikJgVv6jaOoGEMFaDePqA?=
 =?us-ascii?Q?Ql7jBCey5oox65d9ZYwhBEAjB5fFwZJGDYC3auShMY3zDrLAt80EPNbXaPF9?=
 =?us-ascii?Q?3SYYMs1k1bFJikrRPc/PWYJn+r82TMR8en7awHGzxSPSl/nsnMuPKTxm8FYC?=
 =?us-ascii?Q?i0RFlw/Zg1w7ga788GiotNSZ+xvEX6pW0MMd5Sb6KT2rJyEq53F8hXcbQWTU?=
 =?us-ascii?Q?18r77sjAPKcksBCRhy8lTnzB5wV6O7IKg4lL9k70HNIzhvZOzoxArdwEDsA0?=
 =?us-ascii?Q?m6PK4KYKPif6R7jxRws8qQOHpH3Qt2lCIj+k3hAOylznS2qSm2H94XIPa1x4?=
 =?us-ascii?Q?JsF0CtRw6eO9tAaB8oPKGupmBpjpxhkSXixxETEPF57rMNDsDfe0ZDaEo6Z0?=
 =?us-ascii?Q?Ai1X9Bt+df/BTQGvXKpo29/NJ6uzEUeDMoSGIj3FOAGG6v5E2XA2vqRiKUFI?=
 =?us-ascii?Q?CARIQrP8xllnZqu8Cj45RPtVhk5O1QoQ30nHetDHyTCwx/puA0Or76yISv8/?=
 =?us-ascii?Q?z3gqMUJCijwNHW6cXk4FzTWI/FLzmDOLITt/7994suZ/nMR1Nvb5lwCzjeX/?=
 =?us-ascii?Q?Er1kYBju5nT96kKKR1z9nob1dcpBkxRCowgT+y4s09kMqJkcZCUKN1lcBRz3?=
 =?us-ascii?Q?aHpNs8sgTq34ru+/T7hQxXbIOWq5wRsk9HD2mbQKhdEANRiQvetij0cTN999?=
 =?us-ascii?Q?jO9EpNz/Ats+M0uEyqPb54Ikn+LE8/SDLslC2a26carBgbX454P0OkrszT6m?=
 =?us-ascii?Q?353Lkhabmwn9Yop7JOv3kqYEipdgqZ/bNH8U7g2ppx4H41xYSBRch2NAPboy?=
 =?us-ascii?Q?lM2G8CujjRnjjUFHRSdkS19Jv45BiKDQqMa+zoGxB1GPIurQxG8ZMi6VyjrU?=
 =?us-ascii?Q?CGZdnAtcn/Rv5JcBzQQUh1t+y0h1xBGuzbN6f2zYvQjzb/MMrEJluUWePs7Z?=
 =?us-ascii?Q?zEISHV6Sof6NE5TVMStsQz6P8E4AO0mFxI0kH6seBQBjD5pSd5awDiNffoNJ?=
 =?us-ascii?Q?SKWr/FQqdi7plKKIsF/7BJfZEYHiKtqDZO16thM7Yw7IGKLJPEgL915NIiWL?=
 =?us-ascii?Q?5UjFtOJWwiGZAgesK2FcZinwcBwhhefYAurzIatmmUY8RBFCBUFMCAd8pz9O?=
 =?us-ascii?Q?8De7UJRMwfmKJZh/SNZgVtQW+svWBC9bP39/O3WHqIHSlw3YvqpzMa8r2yVh?=
 =?us-ascii?Q?oxn7tvHUD2kKV/6G4oqCzgcTeroHfs3XZtE3XHhHj3tnKu9OIOmQ27Wmux/D?=
 =?us-ascii?Q?QtQqo+vVpZ8unnk5N1JQ0oaJkdpv+5GcoKGE3i8H2C4wSJ8NhOY9dankTZbn?=
 =?us-ascii?Q?0Oy0gBnwQvPO0RKOxy1YH5uZo7wtZ5Ij3/3FkcUaYgf68JYt+LVq3SyvnaSJ?=
 =?us-ascii?Q?SW+E43oyClwuQ/htZ1HAYoD/yEjfztnSMAQb+EavKuS1et1eY2O9+4L6DK0z?=
 =?us-ascii?Q?rfxPBt99JKKQDgy614yR/tT4Th4yAOVNQ7R/TgrSde6/71t5gUNdubcH2xHp?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a927d3-12a0-484a-8e12-08de2290a6a7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 08:43:00.1635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abXrddMpvDUApDQv2JLKeDkFKZNn88VCc5D61BVuomkYmXrTn2+h+FAn2GETIy+myfmgNzaylOUz9O3NExu0aYbhSdQ+AvHWO4t6OWtXUHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5180
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

On Thu, Nov 13, 2025 at 03:47:10PM +0800, Zhichao Zeng wrote:
> The statistics contain 40 bits. The lower 32 bits are read first, followed
> by the upper 8 bits.
> 
> In some cases, after reading the lower 32 bits, a carry occurs from
> the lower bits, which causes the final statistics to be incorrect.
> 
> This commit fixes this issue.
> 
> Fixes: a37bde56314d ("net/ice: support statistics")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zhichao Zeng <zhichaox.zeng@intel.com>
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
