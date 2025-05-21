Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B67C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 10:14:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFB4B42708;
	Wed, 21 May 2025 12:14:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 491B64065D;
 Wed, 21 May 2025 12:14:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747822472; x=1779358472;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=byrddTAsGkC/1srlbiN6lNdf9AlR/TJnu2FeHkExgxI=;
 b=S8anZ4u/aqM0QDnKkTg3mMInXlzLjhuy9lEW7xAAvgq3dS/qdPfWlQpA
 bNEIXNRZ9lvosOPHa6f44F5b32Wgh6maKDBw5PtlUnfCMSdgM5Z7ibEgx
 NDHvtuIxKyOG+PPL3omyiKxOd5H5vB6LviqQ2o+8p6hyHCZIZ2GOMy/79
 ZoqvSg3YGWkb6uHOhAZprdZZsibFeAbiF0XWfSomKVu/GlUW6NlTQqBm8
 +F/HhTRvBtJXPtjRJ6gKe9OAMtEUcARwYnSDlQP9FVvZLHAT3OX1ltMpy
 COgngtM2EhEtelhBhsGCFgsGyqu2Zt52nCSn0E90BPhJLVKc6DF4YPHfO A==;
X-CSE-ConnectionGUID: K9rNQfjgSsud9pCpZsmO8Q==
X-CSE-MsgGUID: Jt306kOTQoeo+BuEnZYIXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="67207240"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="67207240"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 03:14:30 -0700
X-CSE-ConnectionGUID: UZtak9i6QMC8VWSXQ4+Y7g==
X-CSE-MsgGUID: d5VF+ENjTkWQD+OYe0MVIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="140068735"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 03:14:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 03:14:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 03:14:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 03:14:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqh38nUaRxqwjFCA9nrn7XAshEDhxaMIsrsq3STrqRuRTLBjNAwJOX4XtbRWOdSWwh2JWVLCDT+KhjW70XI5FoMD7bPETs7ubuMyAK9TpzIFwlQEy6RV1gc0PnGaXXCgRpnCkFlTT/7jM0eWfdQUnLO0dgW1HxYUbPnd8YaKiGSCSWWjkKoWcJbMK3rOvAa1gqS4j1LkwUsNvCN773sx2PWyE2EGPY2P4+YzzBhlj9caafTDlB0yyl+tr0/14yVYkiYhgRf+/dck3sCHoUNc9i6yuuAtkuHfHgaQmU6OCxxbEbPBpwWKAh2LMDN6jpyDp2WSNnlA2vXJrQDa8K5Wrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZW4+OGIWPf0igSwjGL6TBxNdJoddZB+EnvEztBgC+mY=;
 b=E9ug2QZwBIN3TEP+wkKGZ2Cby5c2216P/GOKYzz4yRltGN4cHZtKVWoOKXU2etRXrfnv0fc/4OdWoG1i+Kc/RjeYA+dDBSdVUjhZB81Lfgx3b+XI5UDNqQU8G199qG9BmOyxqXRUggSAWYhGuXCo9mZwubyfXuBjnmeICGrp8raReqFdUhtWHAj55BsBtTVeqJL26wmG71DgXQEiE1t0g9p2I7FqMo/ypr9DaNcv7AcEWytMPMu0AsJVGXFjzTtNtFligmaTJQsspdInZy9h0kUQZ9Ub+qVC4NFTvzBdm38+MNRYvghvgMjW6TBloS0qDhJaJ+qj5KdaeJN7Diyzkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF06F7EC6B5.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::807) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 10:14:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 10:14:27 +0000
Date: Wed, 21 May 2025 11:14:21 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Kaiwen Deng <kaiwenx.deng@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Qi Zhang <qi.z.zhang@intel.com>,
 Yaroslav Brustinov <ybrustin@cisco.com>
Subject: Re: [PATCH] net/intel: fix igb tx queue offloads capability
Message-ID: <aC2nfWi3-27ibs61@bricha3-mobl1.ger.corp.intel.com>
References: <20250414085353.848901-1-kaiwenx.deng@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250414085353.848901-1-kaiwenx.deng@intel.com>
X-ClientProxiedBy: DU6P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF06F7EC6B5:EE_
X-MS-Office365-Filtering-Correlation-Id: 9811cb8b-108f-469f-be3d-08dd9850449f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CiZsfzQVun9oaJ4MpZuLYQ5UKPA7z887+1TFpQyp9kqS/zb1Ah4nq7yW3pgC?=
 =?us-ascii?Q?uxDgWaScxjGsSznxNGwmpZUKakESezIbFi8MqBfFzpuVVNXohj0opcNDftD6?=
 =?us-ascii?Q?sL2NwXYUR1dNBvguxoS3guhfEl7ceK3Ucu3TodLMZX6MZl7cz2vy+6n8alzO?=
 =?us-ascii?Q?IlM+ofhWYZEWHtA0mITwPlKvjNHH39vVbBd6XSIJ8EyP91H61Npz/tafZWCK?=
 =?us-ascii?Q?a1pVI97mJYpvQva5IiVKpRXTOGBjdZ3Wb6pqQP+CWr6Bx2bCbrCdw+bAT1R4?=
 =?us-ascii?Q?7UBe3XNlaVzU7KcfdVQknCTuDPhlTvE7D1w1Bn3MaU1hAUZX0C/Mb2Nke2DE?=
 =?us-ascii?Q?BNrYDI8v7KOXmHYNgD3r49K4MB2tQ3B3PbW0bP6leuK629qSRTwikozndIKn?=
 =?us-ascii?Q?zqjMay28LUP2MogkOkXudoxPeOdMWtflo00rv/uYuB6fjuUVrTlvzFcHOvQd?=
 =?us-ascii?Q?sdOS2m1IDtcYfmcoaF/DCtRnMpkYphCGVfGzek1Sk4HIa/qjYmviaCmjWx4D?=
 =?us-ascii?Q?C827IxEItpmunpa8Lm74iC9qTlbUf3GS5ImYJ88t9Y5hYWfWAFsvNOz5d9pl?=
 =?us-ascii?Q?dxp6FiXG81Z5FM9HqkYUm7Jd9eFqgeqK2Jq/ccSXgUJlkK7gIObYG9cisLQv?=
 =?us-ascii?Q?UklJ/l8B0BVa3hbVv5uJhaaK4Oc3Mlr572OKnDyrZDH+TDzpM6u0eCOuJV9E?=
 =?us-ascii?Q?q6tM3KcVs/TQ/zzdqkjFAOIYZX3An4q2imgNHr6r7D6U9cbtBwNmJXSSOWNz?=
 =?us-ascii?Q?eAJvm6+M3hMsC5gNuZbKXL1xx8UfZ1y4qmpduCxsPH3yreIxR/woPe/kv6d5?=
 =?us-ascii?Q?+2Q0dOBiKBv4EoKxSK8X3/u1cU8gTTjff+oLG0R+twIOmAZBV5Fsa4ZJI0gw?=
 =?us-ascii?Q?P2P2Vod882vKiymr+KtvoqkdsAGCAJCUCH2RLZJ11IRkOKstL++np2cDE+tN?=
 =?us-ascii?Q?37wIZv9bffAtUaBA3fwqS0ciPwAJvwkKtzHXhsMNWmiNYKlOoPnBqSililgK?=
 =?us-ascii?Q?7TBoSQLwDr8J4eiAMNOs/G3L7kwiS5A27QfWWu88XOrnQFICgQPJGxi1/IhX?=
 =?us-ascii?Q?7F6gQcPfDN8Nu891n5j+2Uz7f4UfSZ+NQBxJJy1efbqG7blwKq6A8UN7zWp6?=
 =?us-ascii?Q?o8BTT/2QGpVy7KAAfHZ34VbNE+AjhSoYztEntdzjJ958+l/ZF/lVG9YCaON6?=
 =?us-ascii?Q?GnQA9z2TiC34QMKBvxaaDFUlN/hy74DAyHlyX+S8d6+pTkceDATwrYy6yXp7?=
 =?us-ascii?Q?AjaMG3K/Xf934IHwFI0ngEp2GI94O0UZSNUA6WBpDTVd8COQ1+IrTqHfCtbN?=
 =?us-ascii?Q?8YWhdbc8tn1T/pAvAQIT2eCpbzVdwxotpaT+9Y5qgETkzI/fmojhD32wPOgo?=
 =?us-ascii?Q?Ttp+66aF0WOgYeBrEUJV3wVEY2bBnqukdOyw4yGIxlczE4xSB9SEdgZfX0JI?=
 =?us-ascii?Q?6kjDcyK7gEc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EfCuG6+pGWDbTScTSv2mP74vo2Aa5rjmcD9GpAUEB4aqpK/2ixSc1ZH5fO0L?=
 =?us-ascii?Q?3EvG9f9fmyOsHFjhe/ykHbXJpVAh1YEBEVo27pL+POJbgoArGbEj6p3o6EGw?=
 =?us-ascii?Q?pAZpsNrjrQTY8Vi6p+MYuGCuP4fWRuiXqp04q+RPeRAOr6om5AK6CT/OE7SG?=
 =?us-ascii?Q?8PvSOi9NFMgdo0wnILPJ/NMkgJMzBMdfZqLQv76WKwGvac8znqV16ug69DSX?=
 =?us-ascii?Q?yE1SclZAM8PJwechRSKsKKHr5IwRzPa2AKexkC4dKl11I8tlOLCPgh2OFZ/k?=
 =?us-ascii?Q?4dFSiMnOzyr+T7n1lOCeilL5np8M9XXm7ke/ybTkvPbcY81wqYsOTzyc/VAA?=
 =?us-ascii?Q?s3Tr9zpqu7maliWHncG7f0SQQZRZx14BmjqGuGJDA+qfCS3edakxmAJhrKf3?=
 =?us-ascii?Q?0ujNd1hRXHAtwOQ5ixUv7d2tgnAmPqzHhMWHOPwbBRdFFjyh7yan4hmRTvOB?=
 =?us-ascii?Q?7fVI9TYdFJHDHld7HpaQHQ1FOA0e4izRM7Mfm35vJNDyuTwvI5HiHIoL5j9B?=
 =?us-ascii?Q?PXcTAW+v2pEPOQpqlhBWrYRmRhuAeJMPP3U8yxQ1bS3DKEovL976HqTDdrV5?=
 =?us-ascii?Q?2GUympuZu7AqtKImgXdr5yb6yelJmQ/SZymmIHfHa29cqs9/sDVx2364DM/r?=
 =?us-ascii?Q?UyI1bO1zEDfZ/6sy4vz67v9I3oe18i4WHNnUZ/7w/dRw9YjH5Rl2vCJe1sHa?=
 =?us-ascii?Q?0H0MtJc39noKoRg1GYkwZOR7Kb3hfOGLQIuTujcIeyCXKkreD3NrDmTrnvCr?=
 =?us-ascii?Q?oBf8dkGDsBF4zpQ+HkhKIWs0BNw3UAvGHNMel4e8ZceRhYFkB7xUoryxhQtv?=
 =?us-ascii?Q?soKZFdpq9YmyceT4Hd4u+7H783UmuFatwWeScW4+/sAQEb87nvh0wgh4TvXt?=
 =?us-ascii?Q?0viA61QaH6J4yI+u9OM4mM6dhjLnr8cYsbEppfoyS+dKYVurqyzmHgjVDi7p?=
 =?us-ascii?Q?ASlAzuNYLKfQN5gKvYj4RoxJ20b0cbqaTRuw1TnfMwOlCnGeH47MvBqqzaBQ?=
 =?us-ascii?Q?4/ZWsWeJDnz3ObjffkBe0VUibuSoQf9wnVA1bDX7CN8SGoMOhU4KsodI2Wbu?=
 =?us-ascii?Q?lPO44yr6SCse11jsVve7v7AuUWYbdSTVrQ7K/rrACFV4DjuwNqNZoYWtMl7T?=
 =?us-ascii?Q?d45SPIyNoXvvg/WKUtLFnJW7Pjqy4nzNXF2zRjlgqpcdV7raeodjSSOtBCQk?=
 =?us-ascii?Q?lbKFf/YW1ocVzetCEAH+4HckxqzqMQUwwrMkJWwU8aUw79C9mT5HEroEnU1/?=
 =?us-ascii?Q?iIBs9KsV+LXNGzV6UxVrJ8lS61W0I7QUyRX4SK6zQx6MjEGwnghGc5qo6j/2?=
 =?us-ascii?Q?1Hq8PoX9U6JyFuJzyuBkVVleMN5N4aRxQJxb4iiftpOzhlcHSGPBDf7JW805?=
 =?us-ascii?Q?ZS2mD1SWFLLyfY4nbnIIeeGwXplzsdI5WfkHrrouAHm3cUtfwq1yybA6tcYF?=
 =?us-ascii?Q?j8l1FxifHR+V40Sz/7MHUk4g/6VSoMlpUrLEMbDYY0CTZasALiThurFjWuMC?=
 =?us-ascii?Q?UJVzXuT9pPhH9QaUq2f0JhvhT2fi3bkXrAEFrVR2N0TVV+oWI7XrePH4dVsI?=
 =?us-ascii?Q?2rLkcGCzKmOuqpaKphkz0+3iC+RipHMvgs0EPpFADxJxuH7nYccbCjWbsmqb?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9811cb8b-108f-469f-be3d-08dd9850449f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 10:14:27.4120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: db5fpoH+4aZH2knL8gJDMsSRubspgp0XVw5m7vwZ11UeaAy3fWZSSKbKMxjecUmaPyxATFvi+BFBwysDi5vpg42RpSPnIT4ZjRkZOAdR30g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF06F7EC6B5
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

patch prefix should be "net/e1000" rather than "net/intel". Even though
patches are moved to an "intel" subdir, we still use the prefix of the
actual driver name. As a general guideline, only use "intel" when modifying
multiple intel drivers or the common directory.

On Mon, Apr 14, 2025 at 04:53:52PM +0800, Kaiwen Deng wrote:
> The igb driver assigns the tx port offload capability to the
> tx queue offload capability.
> 
> This commit will fix this issue.
> 
> Fixes: daa3b0833f08 ("net/e1000: fix Tx offload capability typos")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Kaiwen Deng <kaiwenx.deng@intel.com>
Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce
