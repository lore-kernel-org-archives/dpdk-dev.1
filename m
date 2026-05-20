Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FB2CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 15:24:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B30140608;
	Wed, 20 May 2026 17:24:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id D5A2E4042F;
 Wed, 20 May 2026 17:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779290668; x=1810826668;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wLwT7Jhi/S3+pDhwQ2+Sx1yd+CUCQUJ0cV4MqEO+t4U=;
 b=TWARoXBWo+CpFMWeuMgi0slvQTjaavHNVd2eN3rWxHjQW5Td1zC9lCku
 iBMy9aGD7MggPtS+Zhegr7lE5hTCO2ljrGwoar72xv6SxlFDCQxOO5eah
 nZbEKWeuwB7Cg9A5jPtPtxqrrM07hh+q7KXnteEErDsaQ2kqD1qPWp7tO
 /vDntq6k2dF0bzoQHJj4AVb0upraqeIDccGyYc/LD+QwD0oH266gjyvFd
 MqOSaTVvH9+CZqGFv5APMaE0/9GfmMHZNNjEOIQSCHslHr6i0aDUx9kFs
 uRVYWpXpUB6b/f4PSpW/GANFRnD2MhBTHfD/I+Du9FxJT1+HWQkjTBt6p A==;
X-CSE-ConnectionGUID: TBra0ib/RHSkgmoZNlyyjA==
X-CSE-MsgGUID: L3A6S0W8SNOoDqxWxUs/JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="79922660"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="79922660"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 08:24:27 -0700
X-CSE-ConnectionGUID: e0zexNdGST+0bQWvMyRSHQ==
X-CSE-MsgGUID: YUK0mvxATXC2ahHXOEAgxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="233865224"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 08:24:26 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 08:24:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 08:24:26 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 08:24:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8lrDrc7765wYHxKpv/2j4Y8CfbQTFtYaCsFIguV55kvzRjbYdH796bjGYGSJjBTyv8humyDWDg/GvwUHketKo0OIXmfGxim9Drrk3HKsUrFsDxjI2YAsK4oKJ1sFr7lz2qY6DTXdi9tlYk8nR+oiPcgX1HSgInoYh+hRfl6/FlPfCDlES/Vbf/ImPoT2a5CuDmrtwPmLOnElfRW0NdJf6VRUsZZnuzFpSz1PDkr+CMiQ1ieXoJjGq+3kc7XSki+3h8FQWG3IBm9Yp/iU9dXQPNhYqI4jnc4Swg0QgtcU4GTjtgypipSp5Yo/Pw3qPBCo866rNMl1MmNmbkz0yGK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pww8wUC2EBVe1IcC7Ox/5y+yTMjDhTT8WjgOkv7LHWk=;
 b=JM4+T0tfh+oq17bXgPwO/0aSlzXfMaOv9Dz+VhASdfw+fYC5iTU0L5qWPuEEo69XQ418/dc7eMNAg1PCXAiEgHJPxSzxcgfWMalEnvgJOQLoz985dkXHBOVJds58oRvWKiHH87PI0jtMNLpZdwcrL9Mjq4UqIGGhsKVq35BCCVNZpOUYq+jikYdqjZLSE6OK8+n9VPXl96BKzlhJSffu+r0HMe90v2YZeeZ+AZdtpPdfhQIeZJoRk1wmn9t6bPNK2iXoRxrQ7WlkxGp/M99CGXOlexf6jKPGXp4vo4xA7OV9IvGnfhwIfohnKTQEVwFmW76D4m66PzgbyfqBAB73Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPFBC9025319.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::84e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 20 May
 2026 15:24:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 15:24:21 +0000
Date: Wed, 20 May 2026 16:24:16 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/ice: fix TM node ID validation against configured
 queues
Message-ID: <ag3SIFeXpwhWKocg@bricha3-mobl1.ger.corp.intel.com>
References: <20260505123157.1387791-1-ciara.loftus@intel.com>
 <20260520150717.365942-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520150717.365942-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2P251CA0014.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPFBC9025319:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f42bfdb-bb29-4711-593e-08deb683de21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|4143699003|56012099003|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: jHVDa30Mu+/wnSIOg9L45dIdRiITONImtMR8iTLHZ+4RNx3cSWbZuwrBC6jnRVFqkGn+973ptidakUDrgGeUDpGg3eHZj8bNJtmPf0GFEOJNyTljdEJRJ0Ng4GyoTaqwVHo20xXUUjV0L35dR7yD2dEuzwtdveDYY9MvbhOC6a2BnXlAPXJrjl3/CdlnVP0Jpf46O2UnJ+K76T2OXCWQoYVYQWgkC8ZM7PANbDLfMQzwwfA6c/zWKz2lJ9ZkUilm91qUM/cNRQUa5l8ahO5gQ4+Hmthd9jMZ/SpPKUsgUtsy/pBM3jF4v2xTD1cUB7UZ6JfvMnZWg0hcAYtttyyn9+lh6viKo5dxiezMfVmHG/L3fuSPiK18kp0FQ3HFEVvCpfjNTtAHeObPB58WqRa2wkpXX10731wZUkGsGp463wi+wNEtHC0P2uVOU+s4hXoEqM9RvXGMBonnFc9D8QQZSCglmIzveLj8rjloC9PrmsJF34DGw2UDSHbzcUHuZMevZp+pJaKoIFeGQyBXm44DubX4X6T/Ca5uTgR2wHtmJBdhvDGLVv89wNbgHTGfT48ljeFNjAOIDrVZfLvpMag3s7CdM04bh0XtEh2DXyNVbZKMxx7Yzb8+k1P8g+PrOh77zcUstwxeAUyiIa+RpZAgQt3lIE3gne3YcWAikjBJFKA6UQY88JgEr0LlqNwxGQXA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(4143699003)(56012099003)(11063799006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eP/EVSU5fVsiYRTXnJNzaK07bCGlxBQvFTPHjMCr80OFMmMPDyWABpnHXSsg?=
 =?us-ascii?Q?yRdelMVpUmzmTBGL3mCWK1XUezmleE1ihwEtYCIg6VFf7do4XHNysPTRiGyF?=
 =?us-ascii?Q?QnC/vKnKihVrDt8ycutc+UUlXbgVoIUwj35Zrn27kk3JB9e0bPEH5bWT2wnL?=
 =?us-ascii?Q?oyniaUYHowBCSuISKATlKQhhnCRRo9qsa0jwD2jiNDIdXWULLk6w+sXj/0Hu?=
 =?us-ascii?Q?4SeC1QcODDjo2JDCJOlXyYfqWi+l+4D9HUZfHJLfTr/fNf4KP85NBhiXH5tk?=
 =?us-ascii?Q?/aGS5nJkx2ZEqgYehQbBcpwBQWSilc8Iw6swS0r/GzCJqiaslzctwGZRUBZ7?=
 =?us-ascii?Q?UNNavxP2y0AWH3G85uwFFQs57UM+pfu3u96pKT8LoLdM5aUt2tUF5C21pR0S?=
 =?us-ascii?Q?9qyhG/gTZbrGwTNIn/uwu/ZmW8rDBV/9r+i8A4aeYVwNAVztwPAM9Vml9vfg?=
 =?us-ascii?Q?bRoHd4Fgbe7Y4geKh+7kCF+0EEz64TRwqPRTu4ggsR6ca3oKDesJOYLuEP3W?=
 =?us-ascii?Q?89p2wLosHxXjYnTT6UXlYVhT/MIkd2viFgSlS48dt51265B/0Ae7nFehssz4?=
 =?us-ascii?Q?9Y4igqU369serWJj2EGnmWvyTHQttbnsoDUPeFO7D1bHqxIP3sbVMAmtkdbt?=
 =?us-ascii?Q?vi6tpyHflLyhTCqkk4jqglI7Y9fhOZDit1LgYj7t/Q5fyUEm1pp89upOhsbE?=
 =?us-ascii?Q?DqwgzCvLogBAqg1auAyAU2yU71X/vbj2j2MdZty4kA/t2Q8JMUQv1Fbye7Cl?=
 =?us-ascii?Q?mHniRqQAbY7h0ywIWSnn6FIGgXeG7hetNGMbYMQWm8Z2X5u2USLZVbTabwfh?=
 =?us-ascii?Q?Sp1t4ksKx0AgIzcozzMUQevhoxwJCElGGHnskr20qq060bsshpRnwHbVDweT?=
 =?us-ascii?Q?f8TYRh9j0+ZbTYO6hf9ytm7tzj79jgDMJEKCb37xjXZlPQrE6EkBYHBIxPUB?=
 =?us-ascii?Q?ZBcszSTzNH5FAwoJAb1uEQiX1EC4Kc2wlPQpP3XoI5OVeng9od2Vx+7jvl+L?=
 =?us-ascii?Q?c6SFohYu3YE19VGbqrZO1u2MCYXSnWK3A33sEgxR05/QBiCIIfo9TS8nJ1lF?=
 =?us-ascii?Q?U6DavavMyN1WTXqROsVAFVXa/rPY46uHlII/zJcr3SkqS04SMLKuiM2Za54P?=
 =?us-ascii?Q?6UvnmPoWCql4XzwCUdaR20pCZBjF/yUGL0dH6TvPESARYfMXtL+hCno5K5LG?=
 =?us-ascii?Q?HAmt0AvL3i2b/N+vdkmx9FRne7OzH7Ng7w4hRDkJQx7InJnbrmzbOCOg4wcx?=
 =?us-ascii?Q?TG9Sw5bWxbOc/Vbq+Dp8ZDqNPPG0IRt7RdgjQ2bO5uHfuqlC9drlv36KC8dG?=
 =?us-ascii?Q?+hQ9JJiKxRBBWmXtCVZN3wztpzFWyI9nSpOsiZkL4YTHPss2OgJhgTxj0deA?=
 =?us-ascii?Q?58IBAB9JcdJbkNZPy4GvC1xNqbMoJ0zbvbSKxCIQBS+vJBWQLvjobTN9VuH7?=
 =?us-ascii?Q?mzpGHW26vnGe0MZCe14LY17zGcxrdsGskKEtwVPNlBSTMSpAQmeT43t7Im7A?=
 =?us-ascii?Q?VsThUtd30ekOKA5KfHkkpHUpEPW3+nd/tw9u+rbfaBTaGeP95YcoPrDj8e23?=
 =?us-ascii?Q?ua48b+qlYbPobWZf7n3+Np6o4pIf2PVH1O1P7TBUu7lJ/cw4nFMCJS6ibX8z?=
 =?us-ascii?Q?/hzKb+ICohio/rW/uYb9MdcL5urHZafx8mYRImRNIeePKFOTccZmHfMGrCJU?=
 =?us-ascii?Q?qJpSVQjAi2r4HKKykMgaccXaJp2cuecOVTAoYlekg9s7mAcExOtVC84fFV8A?=
 =?us-ascii?Q?SndJVUp2XORFDEukclnoD/5+wxj8dLk=3D?=
X-Exchange-RoutingPolicyChecked: TabVUpMM332fKWv9HrT6EZxbhEWXmx+sqO3YhHmWHhg2l/ptkBOLEdMzcdY/z8rWWVrj4f4rfQpHdR6dULNYp+E0NQVLG4rHgx88PjfFUxSQiDkVNS+r4PCZM5axhFLGzVE3HlBQXXwEm6E4JE/G0zFxbmzUYtFizMv6WkYahiNkQiPHonMig0StmmowAc/6mt9Xht3oiQhsv2B2KDBgF9E6akJBZ71f5YoHP3JtiQWX6e8BR5RNQUyR/hisSqRMs298rfUS6AtTX69EuXZ5HbPBP/7+HlKHd+UnVCkKxQAb0f6QWiceYlCSuNZb08I/Y1yDNJxeIntmpc6w808hFg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f42bfdb-bb29-4711-593e-08deb683de21
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 15:24:21.8227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDvp/2acBlvoXNGMIwbckZSg3xWnWIwYKEIZMUn/LDVnK54CXe9ha3Px5dwtQ75ZsU7PXSYVuJGNui1Ht/55ssSEHwEKaxx8lfj5YNRdm/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFBC9025319
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

On Wed, May 20, 2026 at 03:07:16PM +0000, Ciara Loftus wrote:
> The leaf node ID boundary is checked against the compile-time constant
> `RTE_MAX_QUEUES_PER_PORT` (1024) rather than the number of configured Tx
> queues. The rte_tm specification reserves IDs 0 to N-1 for leaf nodes
> where N is the configured queue count, so using the constant produces
> wrong results whenever N is less than 1024.
> 
> Fix by using `nb_tx_queues` as the boundary when queues have been
> configured, falling back to `RTE_MAX_QUEUES_PER_PORT` when `nb_tx_queues`
> is zero. The zero case arises when the TM hierarchy is built before port
> queue configuration, which is required to support queue counts beyond
> the hardware default.
> 
> Also add an explicit check in the non-leaf validation path that rejects
> IDs in the leaf-reserved range. This condition can be triggered two ways:
> adding a leaf node before its parent chain is complete (the node resolves
> to a non-leaf level), or assigning a leaf-range ID to a node intended
> as non-leaf.
> 
> Fixes: 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
