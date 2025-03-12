Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B88AC28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 10:30:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C2D0402CE;
	Wed, 12 Mar 2025 11:29:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 7963940265
 for <dev@dpdk.org>; Wed, 12 Mar 2025 11:29:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741775397; x=1773311397;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+J2Svva8d5PR1lA+ty0/T+4bw/kQIfizNT/im/7JSas=;
 b=AbY3r6doGE/aw7VlkMWdhweLIoS3EQOXYyzuSiOAWdJ+7Y25rVF2Q59y
 AY97dpptaKYem4vasO3X0Fqc6hwyX6uwZdVk6W8pkC4v89WHl2XgNTYqI
 dS1W9yNzMiFVrO46s05hFsqhIDionrSLh03Wr9oV7ocnICrZj150L+K55
 Z05vXd1QwvKHsSp2NVr0wGCbf95YmC+7MMtyRxjbP1TmrDLb1+AvrBv/7
 kAzlOyO95OHDthFGfc4cie0Ao9tTLYGiOOBTpUQ8ul2m7s6pO6GwLBqEY
 XpCxy7RabYQw+2ctVsbXfke7T+ROxRwDgl9ejAnFI5SDbwW1taeW2XSz1 w==;
X-CSE-ConnectionGUID: rlHrsCMkQi+gS3c2KBeq6Q==
X-CSE-MsgGUID: OPxK9SYORnKJ47tQYWI2Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="53470602"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; d="scan'208";a="53470602"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2025 03:29:56 -0700
X-CSE-ConnectionGUID: 0Hd1ErbKRfC7dVM/B1Hsog==
X-CSE-MsgGUID: 1gMvKpgmQ8264nSjpTThiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; d="scan'208";a="125787619"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Mar 2025 03:29:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Mar 2025 03:29:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 03:29:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 03:29:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFS+Z/TqCFV1G8DCoz62jQmEWzS1Xnli8GEJyb9HXo/gUMLywqZq8Ff0DCYgnwxKwEILGoWgScYANBO4pTEI8dFtOP2YTVYxrinRSVOzzjwBjsKDygqN+YWRvyxNkNk+DdVZvSpEvA5D4uBwVlZM+nZuCkv4pM/xfXgtC4z6lrbdVhB0niPlnJuMLbUZ0yZ8MmyWjQq1/Mfvl3E3v579quWzw7rzO1Ldw03hqGrMxxbxvpBWajkCcSdHkRzVNFrEBCVU8nbjlSr2ojrvH+0wiFiqmWFm/sYt6FWoCa23/j4ugtyyuZtayukTStvPkTy4iaQ5sdF7zCJ/wmw8leI2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leS4pd0Z/srvQUoyLAlv4qHMJnWsRufx2QRK0C5ZgsQ=;
 b=OM0rR4YaLP4Q1byfpt98h9kT3dXUcl0o30zByYCuSmS5kwFz67YgpkZGWp1ZiOWzH/6nxO+rHQkP+I3R62W9i4jJ3lxzQRmPOTcj1WTbRy9cww+kALO47FwrhC49l3MsS54rNt/VhDwcVY/zgfLsS/OCp9Ox2Y2/HKhd5l298XJZmr8alGeGvkHM6bU/NveBGSx/y/H0SQ9LAuOvf82IH3uvikLjhgBTDhWCSd62YWkY2WJJhXN+TPnkUEojA/Jv692NgViSXKtQa3TEFE41TpiQYq1EBzNd94CsGk7CZc0JSLHnF7ey4TPNv336nZKQFEG/awXVsLST/VGG967bzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7674.namprd11.prod.outlook.com (2603:10b6:610:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 10:29:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 10:29:53 +0000
Date: Wed, 12 Mar 2025 10:29:48 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, <dev@dpdk.org>
Subject: Re: [PATCH] buildtools: remove invalid option for Microsoft linker
Message-ID: <Z9FiHEa3B0v5ceqW@bricha3-mobl1.ger.corp.intel.com>
References: <1741744388-2290-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1741744388-2290-1-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DB8PR09CA0023.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::36) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de0e66b-8215-4b5f-de68-08dd6150d3b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pM/Fzx5QHrlCuRKnkAl7/gjldYwnmzoBJOF7OGSSRhzjMG2DBqxqzw6ThJRF?=
 =?us-ascii?Q?CPcAf/CdEMCLdMBrAe8RDLOkCNnIZPQE2X6OmhSR7ntxm961uG2l+2sQQ5iN?=
 =?us-ascii?Q?v5YwH3nbzZ4df/qsqEs0/R/ixseS0o3ZeMKKnBJDN/ttyA5bq0Or3AFt/wK+?=
 =?us-ascii?Q?JOEFhFn3hAID7lb3U2rYEzOPUalRvCGuGqt6wEHIgL2Dc1VhBqH3e+SRpx3P?=
 =?us-ascii?Q?ekdajc5UGh/ktAUAfJc5URPxWBpunZhBLMBYIPL9fKFtOhEuYeEXHvXEjzbR?=
 =?us-ascii?Q?dz/mo+n0v3c4v5Jg+TnRIhQDO1QtaP4kjCAwY3R/ZFuxKhm3FvaQF++DjjsV?=
 =?us-ascii?Q?Lptf5mjOy/EQ5NFxMfjimgCYBwWTqvaxKJtdjIIX0N6wdwb175UpEIQMr9Zz?=
 =?us-ascii?Q?aEnH4PIdKp+elwPrisclSNF9AxP4o/hxrWKpCnSRVgPztff7wJkARGIWFb2r?=
 =?us-ascii?Q?/9OviKdJ4k9u1g6JfjisMf6YpRLIqCAp4NhteLEO3DpeMSH1eSuQi7VaYhdY?=
 =?us-ascii?Q?/lafdAAWu5HnSnmkVy3YDdmp7lSodFoROgQ+nIGlopBUteC6OQ4ECW7K4bSP?=
 =?us-ascii?Q?BxjyX54SD6nBaHhnFHXp0pnIRRG5iBS1iuSUaCHe/xt47S/FishB4/dTjPD+?=
 =?us-ascii?Q?Ly/EVB4y94wFyyqhG7bKRkDFZYAccfSauDzbqoxxHSV1ZK4xayGbgsMcN5gE?=
 =?us-ascii?Q?lQKA4Bw5QzseEVXw/n7mAVqhhvDevRYots//xeRVLxBxAN+kSQDIT04ZCu1a?=
 =?us-ascii?Q?DNB7jQb5VQ/h1owsxDlJHLiVb5X/3ogVxl52XYKKshIt8Ky3FW+Co6Sw8uYH?=
 =?us-ascii?Q?yVUgMDUk8zVp13Et39TstlceBRvFlMzdFEOzQxk7xxDGM5QnaYjIyDo5VXNA?=
 =?us-ascii?Q?F3/HAa9ygcrB8/jiOUC3BgK1aM91axUoiE2A5wuBvwc1e1IpaRsxA+HNvgCP?=
 =?us-ascii?Q?c9qPIoSstkYj3LKmAg9fEj84wdk8lWdaZiSLiCECh1BP/mSnW88nQ2XTyef7?=
 =?us-ascii?Q?ElNwMzd4g9bnrN67SdLFUjoNQ5VWfHblCVVHIEmZ8xoHlqb9b49Y878/0G9P?=
 =?us-ascii?Q?Jq9lIs4/bh69kwq7LQzUJB2402ZuWjuNtjfau9xRRq2BDUKDcvcaU+ACFMy4?=
 =?us-ascii?Q?gf/B6qQQGCWg+/+I3G456aYTIAH3QdwU9M3DKnzC4MDPOJCvnFNSAldO3J6V?=
 =?us-ascii?Q?MpbetHktAWOtUW1SrntMGZm/wDEGhjCJyTCzWiROX28rvyRfGm0iWBYMXZf0?=
 =?us-ascii?Q?9OCA7x+E81ehQwco/qz9jk1ot4QjwnYjiNMFqfG4HtpobrqQicegGy09Vqg9?=
 =?us-ascii?Q?i1aCCP0vIWWdrgCwD5DTIZotLBmgmVvr1djArk9FERsPQpe7SJJpB1fdGILE?=
 =?us-ascii?Q?zcBmVpFXyN7sd/du+sj8CUU3+tSG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gOmkEu/SGzSrFrTHFZAEQTUkcQ6E4Gm9R/mDPW9JZRkqsSwv0QqgXiB+tvVJ?=
 =?us-ascii?Q?I4Kzxsv7DxrWfl2pxUnrmpvV6M51xC71OxPpasbmlEM2XO4hiu1jvW6oYgXA?=
 =?us-ascii?Q?zTZXDDVASkhJLQgEiEVWzFNDGhKWDVFz+sY8XlJW1isRcjT7dxcke4L1OaZA?=
 =?us-ascii?Q?nVxviQ03wXRZBnIk0c4c01S0bjRuIicaVu2wMtUuhrJQihQ7jJRKuj4Ke3rw?=
 =?us-ascii?Q?aT4AOinRQ4l1bLx9pUay4EXKNsL1B5fZBRzUK+hC2i6mxiE0Uqk3l922Nw1X?=
 =?us-ascii?Q?AKYQNpsWEdqXsMc1NfAbIS0SCtcortIxCzphzMUU+I/6rG41uZkbn2xH4aDo?=
 =?us-ascii?Q?qANZERzSh4qZKkwcdZcCvzOiwcm6JA/M93E8tEsEcktjf6LweGOcjCi+VPhH?=
 =?us-ascii?Q?EM2eV6WrzclBNBYVOy0T87yQ/Oz5A6ZChKx5SP7dxy7EdkC8oot8TDkijK5U?=
 =?us-ascii?Q?ajjLbKqV6S0vh4fmosDMpVFvdk/ChYlOAqcLL//CEwPhQ2MbsI6mLfAmHttp?=
 =?us-ascii?Q?S1uyS/5rDZPSbPRa23AS73rFiuTNC7p3erXBjOVSOLUeULWRpHMExfvD5DdG?=
 =?us-ascii?Q?KNwySDwU7vZ2F6779094ouVd34kKJfnfDGGlh8DxwMhIW2PpgezkgNVTnnYv?=
 =?us-ascii?Q?w7lVWUDfGUjsT1WR5uTbJL3j/Dt2VpitSOGctaV9l4bmcZrMlxAOttfloIpH?=
 =?us-ascii?Q?ALErJ606bPMcprBd1ibBEmj1YPOEaDleV9uEAnFyOVpar/G1zQu46Bk2oV+G?=
 =?us-ascii?Q?P7X65Pzm6UAnAZwed+iLhbL/K398rAbyNUi2PYbmXgOTDRgVKNcTpl3uFQiE?=
 =?us-ascii?Q?iH1nZkBcIRih5G9ACUAfkS7T/7Z1/cRbkqfYkLfN99sXBBWarxrOrzHtUeOb?=
 =?us-ascii?Q?UbJ+6gR2THzsmV00TUKMxdxDG/0YKEW+NANgRh4a1TD5veJr/bwdqzkHyYP/?=
 =?us-ascii?Q?3FaIZz8OyJBbKvxM+xuaR+2dcBw2e7UbiEAx9AkXii0VUBTjXr11UR9gAAtv?=
 =?us-ascii?Q?dBAWV+k0BYU5kZKfzdNaS0UYguMV2XMRlgHWMVclIMw+Ek6xfh5qQqvNnopm?=
 =?us-ascii?Q?NuhwFh2TWiDkwT8yuGrVl9unR7ES7OJJ7yIrFGnrpIgp/wkOT9mkwgbQf/63?=
 =?us-ascii?Q?iTp3GHER6yP5KwcH2O5USfpwo2V5QyWqJdRLuQP2Pf/9G4uNCvd+4mlR0H9d?=
 =?us-ascii?Q?mHhM2GLcDlTOakvcGhJ7VtXI5AEH/sMx72SKJ1dc2A2Hso86sQ6VpS/Hv6L3?=
 =?us-ascii?Q?1y0ASo/hgyxGERXpyXf8RNXVERkN1GLyBI4NgiyPKzpFH7Yg0no/BcK1hjRg?=
 =?us-ascii?Q?NK90QoKPzZobwXnVgobsPIgeqNevnvdTWAtNoI3JpqnBwOa8AqvXFOPUnkeZ?=
 =?us-ascii?Q?eLBMDmm8NKQMx83jtuJmZj5zmsorAVUE9OM5E7j0inQibVFGxOstcAWNMeQ+?=
 =?us-ascii?Q?7wuSMpIVu9FFGS1AEv9VZhRnINF7lK0lf2UgzLWJb2nULAaVQqxS45IyGUp9?=
 =?us-ascii?Q?J80agZvDyaHLuMnExIFgAYPJcl8pgp5dqhmW2y9Lw8vRY+xZwb6cP/Ms7w11?=
 =?us-ascii?Q?PPx7xM6lSpRR2kaUQSVpDsBuCa1FPRJVwtNH2cCVWuCHt9KeMSfkfSTZk57q?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de0e66b-8215-4b5f-de68-08dd6150d3b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 10:29:53.4845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckIrHajXQQv60fvvqdNhQVkACt2AXLNHk7r7pNAmAAuGx06tjOVkQsA3q1LpDWznFlWXHqlcTFqOq61LhuweG5Wa/mXFCKNh9Y0cqyV+j0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7674
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

On Tue, Mar 11, 2025 at 06:53:08PM -0700, Andre Muezerie wrote:
> When compiling "drivers" directory with MSVC the errors below popped up:
> 
> drivers/rte_mempool_stack.pmd.c(1): error C2143: syntax error:
>     missing ')' before '('
> drivers/rte_mempool_stack.pmd.c(1): error C2059: syntax error: ')'
> drivers/rte_mempool_stack.pmd.c(1): error C2059: syntax error: ')'
> drivers/rte_mempool_stack.pmd.c(1): error C2143: syntax error:
>     missing ')' before 'const'
> drivers/rte_mempool_stack.pmd.c(1): error C2091: function returns function
> 
> The fix is to use common macros compatible with MSVC.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

