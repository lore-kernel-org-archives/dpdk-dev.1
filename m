Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C850ECDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 10:26:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DF0C40150;
	Mon, 22 Jun 2026 12:26:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 8FF724003C
 for <dev@dpdk.org>; Mon, 22 Jun 2026 12:26:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782124005; x=1813660005;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6mjOIozS3XCW893RBvoxBB1KdEKuHNTbWLCn2jJ7gEM=;
 b=DjP1gTQNbeUoT/H2meNBv73dndWiXx1cUK643UbSISjxK6ich36dSx7B
 jFBvlXDUn0rbvkiQ3OCSNfYlbwfzgaWrwAiUt/uypvZqDT73/HXgPm3oG
 YLtMnXQMakUwK66xLD/bO4ZK8BYnVEpER0wgRrAEiY5o43Slw5ed6mAJM
 4hrtPFMpFE6yeg7uaVmLqEOWzKsAeq/uRHWwvf4BX2urBcU35BmlR2cXK
 fhmxsjkNFx+0R7f2sGiQ9KQH4PrEWrRdGCVsnjVKY29OC6IRsH/AE25zn
 dUrhOxbGNCOJXmUWzMggbEVb955S0St5jjQFcDd//CY8qEIsbJnO8PJ2Q A==;
X-CSE-ConnectionGUID: NK39vAIJTeqbjwIMJ67LNw==
X-CSE-MsgGUID: cpQOjr5PRMW08y5TODiaKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82853930"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="82853930"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 03:26:43 -0700
X-CSE-ConnectionGUID: qogJh7EMRfeoZk0uaV+v+A==
X-CSE-MsgGUID: +cZHBjqLTQ6gs/a+cksNxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="279376123"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 03:26:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 03:26:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 03:26:43 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.19) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 03:26:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxznbrH4THEIoxYwIrJ4Pnt+MChlcejYkKbL5zW49SadR5Kpyg2NLzf4fmDjLrGS3J8n4adApGBOJwNxrAoyssXDsua8CpGzzuLizHaIJuzr2h2htsCKQO1Pe70Eu1z0AK2WDq1HGwifNu9xDmMSIaOHCtwv/UMQpWEt9X1lubVfZuSFwxgwE5nc1a/AXny9GolTXNh7JR5SutPe4+YNCIVz+mxzDUUdFBDSsh5fY7c3wQBHtLStmK14HCm6uYF1jAy/L3Xxp3AvtuR1iTQPVqZXfpMH2c9Afn1Qq+pkkCD8umuf4KfiXtyd1Mhh6pVuR89kSwic0jGKUVo8AWhzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvNXMwNdnhOvT05+MIE/Ur2LKkKX1DVxr35+/uXHyVE=;
 b=Wjy+tx6AV/0Nlo7wAWhyomZ3/t3tCAXKrRjMWBgECVUKhybu6CxlBWgCwAAOG86N63cUXdcGK08k0n6sD0S6swFdGJ30eIUTGao+olGnoq7ipxv7iPI182cVSZlMwWg0u+siutQhqOUXrPZywuFs0/N5VAPjVr88SUDLCT/wn71RJamD/5LfAdicGl4Puxhvv8vKf18r+mXqwISJgc9qGQ/XVmzPGduzIYUJLqzDYwofuOFZJB5gg4q2yHVlAYQwVYBbh36t2G08dMcZvC/o7nQU4lDo6xfO5UqrbZ6bXa0NUKUqKMp6MDTingPI/RPbwZmol/vyYshGCXy5He8n3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by PH8PR11MB9606.namprd11.prod.outlook.com (2603:10b6:510:3a0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 10:26:38 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 10:26:38 +0000
Date: Mon, 22 Jun 2026 11:26:33 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <longli@microsoft.com>, <hemant.agrawal@nxp.com>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>, "Sachin
 Saxena" <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>, Chenbo Xia
 <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Tomasz Duszynski
 <tduszynski@marvell.com>, Wei Hu <weh@microsoft.com>
Subject: Re: [PATCH v2 08/10] bus: implement cleanup in EAL
Message-ID: <ajkN2cZp6lno9hpn@bricha3-mobl1.ger.corp.intel.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260618152826.490569-1-david.marchand@redhat.com>
 <20260618152826.490569-9-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260618152826.490569-9-david.marchand@redhat.com>
X-ClientProxiedBy: DU2PR04CA0196.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::21) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|PH8PR11MB9606:EE_
X-MS-Office365-Filtering-Correlation-Id: bd412fd3-5ef3-4f44-953d-08ded048be7b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: wFv6K+0RMJjbyeVQVLFUucFrKd3YWE/PjPFvDPfD51TWcaGhpk/3hqSCLSbR9LvNM8GaWUwxkKg/i10yLwaT7DX/jkVVAcS2mN6+bvS2Q+DDcRJL4Ck50Z/u4KZa7COKQnGkjd73eVSjNrFnm2K9DTJl3IDmDbqyX5s+Y58HoQYpkr/DF67hEwZ5go10qDXRZ4abxdy21n536CoPGd6sf1Hz71tN2DhWNydLppdpIHS7eH328l/vooslE7ok5zTtUrZZuSbpO/ZjIqg/at316hQ+iyJIg4bixjBrMj4IpDBB533IKJCPi1NtllHPdiVtTScVk+GnLkRK5yqUzDcaswh+HGrihTJbqH2kZJtVSkINKimyHiQQGt49NtHnHx3JWPFwYU5OHxfqZ4fxrTOGdV3bPRKZBXddq61SBRxcGYGZ0nJPJAlTLzhtk13WFecv7plsWHlsYYzPuHanAtnlmYQqCAM6gqkA8uVhZqflXyrVeH29u6eI+Y7u4PPtgNEMw49aJPKV2IfhmCyeLMuBK3hiOyTKMFFgyln4jyDr/cnZQi9zHStVgwW9qlJ4t8ClKV9v4kJ2e/UiYoZia+fSWab4N+ojHpPD/aW2YLXK2t1KKqrsmvjAOxVY+w3U0WQVjLLc8xFrwNehmjtlu9kmwc3fdbtKiB+kERsfMT/CpfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jzc3yogK+s5qDIqSf6qEcX89T95Sl/KcqOcYcRZqLmQck6o9U9F//nNcJNUB?=
 =?us-ascii?Q?uMM5u0OtMWtDu5MJShrRI6IRreubKkR+BC6IgqULnScmkgIXvC6UMjQyQUGi?=
 =?us-ascii?Q?+UYkXu7CcOVjE+uiv3uH472DFqBa/syZqMi884k2JR+gkq/gfxGYVBl9qt3g?=
 =?us-ascii?Q?IKrIhoIdulp+u+cQBNAKtSZxNVRAltjj8BWMIeizfEWuoqcycQTaWTTi+SUW?=
 =?us-ascii?Q?XfNd1mYKlXdiXpHcV9zGoaZRoDaPYP7bIxX95lxUUTwtnrQ48ZG5LgM1VJ61?=
 =?us-ascii?Q?LDmRqQsaaNQQDX2ndJf2dnGZSIlo0OJeRKZG5uC85bnqMvatcAM18ey3RhXS?=
 =?us-ascii?Q?Kpug1k01ZYyx7DGjy2Kmz+eNsL/O1H/NiuoJz5M5qJqAey0BCnWIdKDFDpY7?=
 =?us-ascii?Q?XFCtFHxEHwuyw0k5AvDTEiuYHcpw/pTN9sI8As5ecHQUpLqjkD955F+06MgW?=
 =?us-ascii?Q?W/FSOaSJV5js30h0DaCmR25pxmWhiJPurCyuHgZcosV2EPTuQw+LObIuhNjP?=
 =?us-ascii?Q?gk9LyY6TNOWSMuYsKBV/VRdDlgauOtganVv0j4l1LG+YhKBrwIHpL/v+6nuF?=
 =?us-ascii?Q?wYZK7jnaPtThWf4UuNjHZIasHhekHyZMEsb1bUuG4/ZeC57OlY+JlyqJpbu3?=
 =?us-ascii?Q?QpPJUTj7F7TbkN4Uh2qhDw4BviOQ8PaIZVldiXHeLvCkuerdgPgiv0lMvh8i?=
 =?us-ascii?Q?SijXUQbwhyzZ2F/EJ7ZN8JN7YIqt89Mcp/23EZdIYO/BgSg2ZH24Y6iWXkzc?=
 =?us-ascii?Q?MTSJSmyEWqc3lfvODvsEVVbl9Nk/ToJOhy5R2NM9M6N9fATToitCP0IaTO1T?=
 =?us-ascii?Q?SHOzCYqEZLiRitUccKtiC3DhoOE81xV9sPevuJNuJxyeRfV4SmTZzwb9bBOX?=
 =?us-ascii?Q?eybSSwNYprWXMVWvrVbjYEZnXSvvmmrbRf21GNYyqPex3fEFK32HiA1IoaEJ?=
 =?us-ascii?Q?aOTNnCxU9YA0jAMJNQdv9rVqh1s8dr1T/le2YESQoU6/caldYzk0AUUAprq+?=
 =?us-ascii?Q?9YMOXAFSVoGLPKlhO9pCFvKh7ZaI+WionT9X8VaR+lVlTWrgbnlNNo7G1ZG/?=
 =?us-ascii?Q?qJbuQn6LC3249n3G1GX04j6Mgv0jVk4GUXuM9T4bIPSZHEKgueKSROhnav1D?=
 =?us-ascii?Q?RajHbOTvvCqDHc7Vqm1wB8BkrtoRA+5oUBVsqRj4Zcv2pcmMkRhSPnUZS48f?=
 =?us-ascii?Q?ZAclwB1vYDRWZPd/dLD4W7dHC4mgExn6IG5Ye188/oAVicGMa5cZtbwKHAbY?=
 =?us-ascii?Q?qPzX3TbYhRpEafgZpdEIaH3blkPB2vPcsFdYUiiGvWvj2nivplVqo6PnQ/rL?=
 =?us-ascii?Q?5aph06n7Nh0OPro+CkoaByqg3uzBRXCZcibqdsQ/303DvrZ9HuZa/WLW6n+6?=
 =?us-ascii?Q?hUe7YudDas8/dASkE09DZV7zzuhBxn+X6PLDw0R6HXHUvrhyXSr1z2qnB0M9?=
 =?us-ascii?Q?LSAps93z6jK1uiAh+PDDYBCSqaG0WQYG/XVExyS+m+8/12zbG7C4H2sPWRO1?=
 =?us-ascii?Q?k+UPbarDXCnAIMBlKHdVETdKRI9FJJz3Zl6aSLj3x1wsgH3jeI4RVUqNEdeq?=
 =?us-ascii?Q?NnaICZihkUd4KwIzZIijHKUKMLhwtC0Qb514Kaehgb6n9w5Ft4mXokm/JI4u?=
 =?us-ascii?Q?1Og/8wmjQfoxuhWrtQFZ6M6PiJYmpOr6Wx1pUln0B09uTFbDuXcYAmH6U02w?=
 =?us-ascii?Q?gIPR9AG2PXVVa2LXVMS//9ivOwMzek1cQ4TRncnQ47UWXdpfoxeaaJK2vE2H?=
 =?us-ascii?Q?iowme4HARetO1iWx2p2kKveOecHXw28=3D?=
X-Exchange-RoutingPolicyChecked: kzPGNAtubw+POByw/7cXldppKhbfwAwbdw5/ryc8mnnwZp9Ui9dRwbZxQwF2FyaHccKP/dzbTz+kQCmjnfIaXHWWU5zI+Ry9aHskGoMPxNCjb0qNHEbEMGGgUxM0uZXQF9xquYdxx09PDbjxlzMbPeklfNT5mDxRdTSC+QWLgu2mOjk7uz/nV/Sn7rNBK7mNRxuHZqK0XcGhOIx6dDHPruOTN+YLUFN5e9YYW8hVKJ7vbinqy5QmZVWgDc44w7tEvIzeyvOWerCrt8nYIe/KNbYEvrIC53kHmFy1isf0g89XoqGR8YJnlusD+jlKKyezvF2HJpeTxIcSZEDlhYvkEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: bd412fd3-5ef3-4f44-953d-08ded048be7b
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:26:38.6786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TUS7F7cxD6IYK4HEIlC2wllLagNR60LK7jE7L7Up1v0yqyxF8kueogOUkUTww0tZIGnvKN3VQA9kHEcSI/tAa9ezE2Y8AgYcRDcwf+yHFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9606
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

On Thu, Jun 18, 2026 at 05:28:23PM +0200, David Marchand wrote:
> Introduce a generic cleanup helper rte_bus_generic_cleanup() that
> eliminates code duplication across bus cleanup implementations:
> unplug probed devices, remove devargs, remove from bus list,
> and free device structures.
> 
> Add .free_device operation to struct rte_bus to allow buses to specify
> how to free their device structures.
> Update all buses for the new .cleanup and RTE_REGISTER_BUS prototypes.
> 
> Convert to rte_bus_generic_cleanup() the buses that have both a .cleanup
> and .unplug_device: this requires implementing .free_device for them.
> 
> Untouched buses are:
> - dma/idxd which has no unplug support,
> - bus/cdx which has unplug support, but no cleanup was implemented so
>   far,
> - NXP buses:
>   - bus/dpaa and bus/fslmc have many issues on interrupt
>     allocation/setup/freeing or VFIO setup/release,
>   - bus/fslmc cleanup callback is actually implemented in its internal
>     VFIO layer and requires too much refactoring,
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
