Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FABC5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 11:05:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FE0A40E34;
	Mon,  9 Jun 2025 13:05:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id C2F1C40E17
 for <dev@dpdk.org>; Mon,  9 Jun 2025 13:05:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749467129; x=1781003129;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vrvGnNP8hODw5I602nb8oMD5TPxRmXIYzN+pcX4j+ak=;
 b=NFZX9tFZE2yYhiyT1LhexWtWcmiAqFBVigYV5L19j4GOKBHsftFw/mj8
 IIxsh3VH6+GVyZwD3w10KD5oihsktTwNijuHffy7eaKRBn/xYjRQb6MrP
 m0TJJrQurPvLGaIbAW/jtJj7ZkpH7DOQcCuDRDeksnMWALZdhzH7UQtvG
 5Mfi6ZVqeGczufwEWeGq4MuSvprn8SBEUqCZnBLB41DE7qP3y1D+NeYy2
 JWolsP7XYHKWskzdkCQP5kpmP92Lc2Kq6m1/SixnIV2Me2nv4Sa5Lxo9J
 WQxrR1JgEs41Zh/EWdUZnBI3vrp8PiIMlF7lt7Rs3i7TC2epaN6By9ead g==;
X-CSE-ConnectionGUID: 1M7K5GL6QXaOQkXaQiWLvg==
X-CSE-MsgGUID: VXz/2Lx1Rt6gVtyvKhpdAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="76935161"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="76935161"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 04:05:28 -0700
X-CSE-ConnectionGUID: pf/WLUvRT32WfvsN1zcYZA==
X-CSE-MsgGUID: N7ByIJo2SNycrcPITIB+CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151298014"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 04:05:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 04:05:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 04:05:27 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.45)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 04:05:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JE2DdMrfne+NVOYzeX4qayd1aP3cmi5bDGxXl+hHKVq5SfuTPvb2E5EAhyIKGNAz/trlsM+qvbh+feZmj5DmqR4C6v0XjOIkSB1SloJAq3rBC4LQlH/NnAU9/eiN0wZbrg3tcmoMG51v/RIX/nW5R4oy1u/7Q93IPb7TxD6QYyjRrEyVWqStW3z2Af7g+GEquBSiNpyyqzXxRMig+5Feu5j5PlxRBCxOFiOoC9ptIS/U4WV26aEr2hcMvNt4ECqrgr3oTAcJCI0n0/K9IKfFpenjbJ7XacENr7FaMVoVct1yl3S0ZtqOCsgf0mIWkZjbb9LIOeavNi7zr81RYIECuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8idt49kR6B9DHNyMjrinmF0nuf72S8M3t2tTtN5C5f8=;
 b=NCOCxSoSvQQDVfFH6N3sBVQur0DR6f6cZTdb1RBWamiNfYVtUsr18Tb/4IYegHTsBze4QTpPdp0NJT4PhKwXBvtdkRJF7ZJAFAzEqeKheyw1I5ll4TUNkThySBY0AiVV7XBUrc4bPlSRD5sVug+SFU64xtqtx42nFO0DSqqI9AE9fG8foTgqlfcZW62BO4k4Mnrqw/figrZkEiavgB4G8MPs+uf06Ql1vktf4OgfUBcFOLmX6oCqb2iy5CyZjm629AGccWzwkQ/UViUdtex8sOlbrawgdEU1xvjz0FPSh1kEcYj8/u1tvI8yQ0/zyv1fKSQcFuaqiMed0T2ZjFruow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6167.namprd11.prod.outlook.com (2603:10b6:8:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 11:05:24 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 11:05:24 +0000
Date: Mon, 9 Jun 2025 12:05:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v5 16/34] net/ixgbe: move vector Rx/Tx code to vec common
Message-ID: <aEa_70Pyc242hKEO@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
 <017e1cf466bab5c9a30c8b75d3cb902a2d02cf36.1749229650.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <017e1cf466bab5c9a30c8b75d3cb902a2d02cf36.1749229650.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB7PR02CA0009.eurprd02.prod.outlook.com
 (2603:10a6:10:52::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 36db0b7f-a4ff-46fe-429a-08dda7458882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?viVHbge1mCQ+KCNt3WRafHVvK6adGaAbL2u2WYZxJlsfaAD/pJ5KnDVSX+Hu?=
 =?us-ascii?Q?yJpQ+mnAZ8mZtwpoUjQZf8W+TMFRpcJVWt6vy38Qu6qozNfZ0n6gRCvoKibQ?=
 =?us-ascii?Q?xWWyKAYfWvSkTNBXyVPIM0wahTxJQLO5IVnlb6h0t7Gg0InBsXwA7V/Dm3Fz?=
 =?us-ascii?Q?sbKEhbID3pG1t/Rfy7bAte9VbPyIEMVYSD/ys2DVqeF4pErxu/XIKVnFy6W8?=
 =?us-ascii?Q?bth4WeWcYyadoKp3E52ds/QkGnWhStwBNtupTt3WyESWx+mfVPvVPJQ+cxQE?=
 =?us-ascii?Q?Y9SNssrLYanEPai8leI/NxNBMVyo8EoJJHOzPyMlt0/yVo4GY71oMLhux+Ia?=
 =?us-ascii?Q?ZroQenzjMsIeOpLtVE0mjoQCUXhI/iESrFKOaygzNLGWP0DqCkNIzLEyjozr?=
 =?us-ascii?Q?80tm+EQMyt8+drsj48L1R7ajmSx5/afnGTn9v0j95Ilq6Xuo362Ee7i0GP9W?=
 =?us-ascii?Q?oHYAWOQyAsWS2bCEb20xfPvXswtkBq828acXuSygRi3UV72QLxmJ2rLpP2BA?=
 =?us-ascii?Q?DvuQvoSv908BRoldstgncRtBLT8JgHI25pwMeX4VxUbPEEIDFaqSHkkBQBNe?=
 =?us-ascii?Q?dbARuF+/yXJ8aQdAdJ51vfltYDFb8oo7HJIj2pyd/1qLji5oeMXJJ+kf3Vce?=
 =?us-ascii?Q?Q0gFy9d9+O1q77uZZKPH9mQIbjpqnyk9bTHrKi9+H8Eq1fKr1SvbVX3W3XIv?=
 =?us-ascii?Q?VDYKjS5ba+2IBWiUBEOAK6bfgcxNN6reYdV6qsVk+BFh9WtOADuRF74M58W2?=
 =?us-ascii?Q?6QxDhKFf5JGd7aaI+MJdRWQsEFA2zZSJ6W0PRmpzdCdoId7JZbhHz0UVhOQf?=
 =?us-ascii?Q?VD5f9MckSb3jPTtCDBE0PQLhhH6DvVjcOKHmf+yozysVtKjyG3Wn5cLv2N4/?=
 =?us-ascii?Q?jjsd2iqRyxd9rLSHVT5F/7c3jxTtk3faENQqGvAzCx5ylH2/yuG0AoZlB75W?=
 =?us-ascii?Q?wYDgFnttZwh23Fo5InOUa0ifyHG5i0AZqVdPYMJT9RlcilapN6GGHi+3340e?=
 =?us-ascii?Q?IPn0svuzlOsKHOjUhA5s1JXbzqWag5NlnsmEq1koaiHNdrh9UViyPWCv07Qv?=
 =?us-ascii?Q?puNa7yumnxIdiUr4cBAyOqT65f72hSpWxH9sKytAnl7IePdMPI7JoFB8zC4F?=
 =?us-ascii?Q?u5EffS5l8e8+FOejkhOwmxFD6gwngMwDWS+/JqNc4v7oi+1nKyogXZrJMCFm?=
 =?us-ascii?Q?paPpzxPu48fwubHut7lrajflv2ZWVHwd4tTjrZYrOLjVYhf/17CKyAlHHMah?=
 =?us-ascii?Q?vrFeB9zxCwKV1Wjd73JINGk2MuMqLMx6qffA+Vk60hkkw1qFV0yYtEaDRP7w?=
 =?us-ascii?Q?jzgVCZ6KZwTk0xxF3SaEXQI5+apJqD+FVyu3xX++MNykpr9afSUAFTnyr/Qu?=
 =?us-ascii?Q?DtgsynxRa+yj+DagJEqEMWpcnUKdvMomiYDPCJK/Ib4hFywq+g1A5JnHJanL?=
 =?us-ascii?Q?tc14jJ9ektA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?spwJRqOFi6AIu3rgoM0lxN57eVL6nzI5BaHNH5FqvvdxKuJLP5drkEoBvkKK?=
 =?us-ascii?Q?qDO4DnBrG7FRWDgyeyN/0Xe+q2OsUx2rhvxnoJiQZJeX5MJiHFLLttIOKQZl?=
 =?us-ascii?Q?YystruBPCwIXY3ueMki2HW6Ad4hIHU0U5e4T4j0obyzxznKmg9Y+vJblmGjH?=
 =?us-ascii?Q?k80P7JUJnNuBediLzTNMFpETpywOqRQAr/ZHH5IIIqffCtSB2tJwfMPbvNtv?=
 =?us-ascii?Q?svYUNecXs2JZHHXjJeVnA4xQk+yhJYY7xejR++CIzdvbsIe6KDqPAFEpD8cY?=
 =?us-ascii?Q?qOT4L2kWW5fLnDyUP5pmF6fC4oPopWEI1RfVg6cT/5nHb+FKBMjndnDAnqmI?=
 =?us-ascii?Q?/btgXGr+JxHs/4ZLwh3wNzcCRcQusLH1v1whkf8ToptT+6A6KO9NgjVs8fyk?=
 =?us-ascii?Q?ZZ2sGsyC8lGVlQJGaVexvlQy8B6MZdg5hfugZkzz7nEHgDPurmsHc2PJ5zj1?=
 =?us-ascii?Q?xGgTktMlroRdoKpkkcEB7UUIyn48TGSDTu9QkkO2K2e/ZrMDGMusIJ9T8Fxo?=
 =?us-ascii?Q?tldjVHUAnHhKm7O7p3h6D2kP+46zXV04gpuIQS5zRaEfrrLOfrxUmy7V3VxC?=
 =?us-ascii?Q?YiVytUg0O451TmkeGEa1QdtW+evax5U0du0gquT1odnNQDR+rdqDzPjEpjs/?=
 =?us-ascii?Q?Jv2UhL8NAibnJmWizYAolDMB+Ae0cyBVQlZCx4CUXYLvKd+w35Kl4lCHHwhj?=
 =?us-ascii?Q?cq/amcHkOhYEGZIgYxRndGMhI2Wte92GTXiFLEFI6AelOQ/l7LbB93vgVsE/?=
 =?us-ascii?Q?OZwhtJRDb8zlhR0k5rRRDVTPw5iz/JUfd60jJqosPCqF5R+9/41tERi8VcRd?=
 =?us-ascii?Q?kowiHKSU9DjiWUaVR7lCmLZTnQL/VNarR6+75DbR96+M5zcxlkMkNlTCFfVs?=
 =?us-ascii?Q?DrEPT9zC8HkSuO+EANXrAxQewjTVxLk/UKSTQmRrF+I1DE1ZxRurS+Ay0eyx?=
 =?us-ascii?Q?YS2hRRxVpfeQvluqtg5j3H9h7wcQa7xPiYq2cxifBF6HJsVz3LNLR18xnr4/?=
 =?us-ascii?Q?g/X6YhNfv5xqjLbdV8e2gGkStUizMpyQ8As3SIE+BAL4oxcaDKxuP9wm3diS?=
 =?us-ascii?Q?9xtkcQHlg68bQ75CLbw3UZf3Py250xStxj/yB1+8fAmLrw9YMW2OLwBDDpae?=
 =?us-ascii?Q?3N9+LvunTIHmKhEuaoJZ2Gr9IzGlLgAXChQLJRuR9YU5WfR5RYGFTnGzomM8?=
 =?us-ascii?Q?Pevt3XunALBKtFa+0pZvatecByf8aG0cMkqhDDwUSWcsU4WSKHRiz+XxAn/S?=
 =?us-ascii?Q?E1dboK42HwioTmg6aHaJzMJ/BpYJrupj9zuQ+p31PuEwhO7jUpE3sNlVs7uC?=
 =?us-ascii?Q?A9U1fy0JF0oowVJEcpPpoRJxXRcH8CupOi4B5EUjCIq/IFIFEPTJ7BKmmtXS?=
 =?us-ascii?Q?A+CeXInYgw6810J2MvvZy+9oxe4vZ37VdcnW7BXbaehXUyYoHFtlrlqjMnJf?=
 =?us-ascii?Q?bjraN4ayJFsoMcYphK5acVDx9mRIFhFVnwqyQRw+fnX1LC0fmk+itbWpV7hx?=
 =?us-ascii?Q?BHbk8Cd/SeSht7Jp/n7IGoRq8mPfLwlP7E1fJwavewHTV7nxA+RF5Pf6FzNa?=
 =?us-ascii?Q?1T8rZTmq+fttFSpGQhoCuTkqwnM5vGTcUn7RXVUqJxOVeDr0A/i3qA5kOJre?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36db0b7f-a4ff-46fe-429a-08dda7458882
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 11:05:24.2698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAVrqTPsl0tD2P7aLjp2cxXFky30cDeAlOln60Dzq5KFNWLX4rWQViV8NQ7/MsTjGGvSDiznSTbv8IYLbT9tTXBtUbYLmMUIrq1x8pIiZcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6167
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

On Fri, Jun 06, 2025 at 06:08:55PM +0100, Anatoly Burakov wrote:
> There is no reason why bits and pieces of vectorized code should be
> defined in `ixgbe_rxtx.c`, so move them to the vec common file.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 38 ++++---------------
>  drivers/net/intel/ixgbe/ixgbe_rxtx.h          |  6 ---
>  .../net/intel/ixgbe/ixgbe_rxtx_vec_common.c   | 31 +++++++++++++++
>  .../net/intel/ixgbe/ixgbe_rxtx_vec_common.h   |  4 ++
>  4 files changed, 42 insertions(+), 37 deletions(-)

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
