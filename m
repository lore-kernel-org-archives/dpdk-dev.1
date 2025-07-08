Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B3FC83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:44:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 534CB40677;
	Tue,  8 Jul 2025 14:44:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 585A0402A0
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:44:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751978662; x=1783514662;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=E4OIFM5TtYiqL7eLGh/UzPajyswFN2JAkw8ihd3tf/8=;
 b=E1wdnfKbPxZlLulPl2LKRzYYU3Z9hDh4P95masv56+BdsXGcaGTMY7Qv
 ZlCO20ZiNLKEScRmv22/df0be35J6vTZcd3XbLy5pEQzUvVmCkpQo8wz1
 nyahlemz4MLs+k8lGwKpLQ9WTyFUjSKtaYHlEVnNEzXBInyNYKD0RygW0
 5b9CZQPLIfbQ5gyQasWJjb8JQzfhuBaRhalXASYayffhMnvCTWcWnfnQk
 3AJJz5gXHBfTsUWOUFH02ZLZ9ng8t04WJDVCLhTvuvixHnSvdwVDgLw0C
 /h8WPouxLtSrQ2w1PN2PhOGzwZJORVk5Wc2rCLLiHguJPK/UMvXSsSvfV A==;
X-CSE-ConnectionGUID: Ws8sy26lTByrOKMt64BPDw==
X-CSE-MsgGUID: BRxe6BU1TNeCsfoK792aUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54145205"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="54145205"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 05:44:21 -0700
X-CSE-ConnectionGUID: yOVKQuvtRJypjZxVCT/EWg==
X-CSE-MsgGUID: P0dvq67OS0qCnvbvJb9STA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="155615878"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 05:44:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 05:44:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 05:44:19 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 05:44:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhQrDex8ialGGV7q+IL7TYvuNEaAwz0Ai1GCIi/Sl0ggNusW4S67WYg9kkXBPbniYyKiaD2WskoqJzyfdUpunNAIDVjjqYQZLjmcIWxI/I1/OS9nEd2cXvzR5jNbti8eP9Bktt6TRzPQG/LDiuOmLGI/pGMkBnu2q9yO3YiOpYF+/j0din3IOExzzZwVNaZF2hZf61wh/d7Yibo6CeDfHITxYIZxKu2QGxkUk3TgqJuM5bZewHeeko4QShTA3lD5yGU4r1eRKpifirl+dFq39ZjOpe+F0NWjtBEE/4Lun7o65kFrxi2YtD3JqTwurbZcpkSS7+Zo8d2p/hWEOMc7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnvDfV0A0QJFcK4vRbm+iwVabrX3Kz7ecg7wbWeExUA=;
 b=Z+AMtQi64NsgYPXrT8+nE3piSLIOHUkv7u6onviRrpe0Ou/7Te2uboLHec7kjMfuq6rQuRU7W7h3Q8VdOvLCK7qtH00xCvABVjOZc1gr44BqUXTsKoua42Qp/t/io36mfIwUKzpaXg7LhWZs5ZNu/szOQO+5cpl8sen20B7Vrr9lOg2gkRvPHUHavOSlWjn1noQpESXa1YQrUGm4che8c4sZmmsrd7s90sxsoeH/Pf6hOKRrS3jouhWrQN3cLj/fYht8JOOvzuzStk2OpVumCC9qQBlAgRG4Dc4s1ir6borUcbch1/OQb0BvJeG0geprkgAjyaFRrUqvijDaJ/7Dog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB7053.namprd11.prod.outlook.com (2603:10b6:303:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Tue, 8 Jul
 2025 12:44:14 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 12:44:13 +0000
Date: Tue, 8 Jul 2025 13:44:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Tyler
 Retzlaff" <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v3 12/18] malloc: fix mp message alignment
Message-ID: <aG0SmKmMAnW3hrfE@bricha3-mobl1.ger.corp.intel.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
 <20250708122823.3406288-13-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250708122823.3406288-13-david.marchand@redhat.com>
X-ClientProxiedBy: DU2PR04CA0163.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: ca04cd2c-cf9d-4eb7-e1b3-08ddbe1d24a7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CRtiVcrRKS49p+1NKYin19bqnkNFyQ9pXvBeXOpqcEi5tMOB0NsccP+hXc8G?=
 =?us-ascii?Q?+Yjymcj3mdlxVGFOH+p6pXMBx1gTLFoSpZAyo9k1tRJbUyc8WTzekWRLFUq+?=
 =?us-ascii?Q?5nazpFqhV/PtGrc6UE8i6AbSDigAMKNcnPe3TGYfR4fHDF3lHzkcWoEtNdzq?=
 =?us-ascii?Q?X9pveXEt0Lxy0aXNLf/cXszVdEFnG9Fbll3b4OroSxeR298ZWMZsbm3vqShk?=
 =?us-ascii?Q?YT7EnEm3/PcIRvEosa/Ouk8xJOD/uaSWHmPzUNhduPyCiSdbPSNhE4fdCbEA?=
 =?us-ascii?Q?/RTeKeVw1OVMmGodQv/ILgWzi85ecORRLQ88gthBf6yH0Ea4uLs8xwNmISji?=
 =?us-ascii?Q?vycpeJqqa9y+2BtL0wYzUGRd8v7ervPCsIcCD2YLp0UK+SevKZNsbJaAIzEX?=
 =?us-ascii?Q?heKBh2ttdawRxioI1/JtetVrE07S4C+GKkptdLWRvMSe18SwAdXxK0i+Tb/Y?=
 =?us-ascii?Q?WPn9wXq9y0vl8UAW2pqs0Oct9xptP0OAeGuDsWmVyQm/3CImyop/3nH7x6vL?=
 =?us-ascii?Q?eZ6D5n5aDUNPVjMMdEX9/w/L45ktSl4tK6nvZKFeQ+ohRUSRPUkY6LHMrFVH?=
 =?us-ascii?Q?IqjTNZ+v2iXwrA2KHutfEkFwWrVZa6/gxD9BmKTZNe3x7ZkmOCNgLQGceg+G?=
 =?us-ascii?Q?vOtAs2bV7aLvKVRrQcm3WNDWXWG9Wz/qifCov6w47WAnDhoNronbBIRgau+O?=
 =?us-ascii?Q?1tWsMP4W72D5ZeBy3usNw/PakJeUdYMhr4zvIYv4QZIekBtU+VGY+wLqlHXz?=
 =?us-ascii?Q?ilCfVymSAKbFk7Xf6H+2AVAWDLYMpiR0JEBKWEkCDvrYhu/W8abfxzjKPkVu?=
 =?us-ascii?Q?+dmVZzP2J4ihWi8lkLqWucwGiN3LQqSVkNNoFmtBUUByLAlh3ViXKHS64AyC?=
 =?us-ascii?Q?bQXUrN7Fmf6LwUXgYem5JHlWtGpyh+Elv/2Pjh4akkDfgpEfPz5XcLc7XDdB?=
 =?us-ascii?Q?fvNmYEfSpRkWnE05BcpLYojiyfyBEaVpHl9laYigKyF4dg5YWpcQR0BWehhd?=
 =?us-ascii?Q?ShOOI6ITiMhgiajI2+lAr/Wj7rDlUJOMpKE/oFrGxiEum7GMd+6vJJu+hK1S?=
 =?us-ascii?Q?8/HgWrFqwgzcjFai8U7AIqFtr9Kj3zsGcSOVn5eZWBUSFE1kcVpkuNSridhC?=
 =?us-ascii?Q?VhAXBwAO7RDE3eK+cZfkAqqL83r/2j6PZq36LmhTPkf7os7SJIa1hmws6Dad?=
 =?us-ascii?Q?5ZAIdcoHwVOkILl6MDwuzvNwZ8kgSTHkmAk+PYw/vaqn+q3TrOT3S2GEwSxt?=
 =?us-ascii?Q?mmAoDfTWdKD8eeJ8JJUT8DI8qP6EERl6X4nZ1D5KHCEana4qRAuGULayNJLX?=
 =?us-ascii?Q?Hp+tAMTd3VzKKn7TJXPwE7I2gTkw6Ej5vq8Rfe5XotnSxbxmgX9PevGptWTW?=
 =?us-ascii?Q?PIVgd5g9a4xKvCWyv3DyNlyvlCxxm4jVLIguXuNnrJrQsgCF8TbTIiRALOLN?=
 =?us-ascii?Q?+/YLF7IAQMw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KKNfUY8lEbVUiorj2CMQtCIYnaqYIxNsHTjIBC7ubYzoiV7RmcE/P7d2SnO4?=
 =?us-ascii?Q?45xO6F5XwVwQ8KZzdtWC5w9+5kMxE8alnIWyhdBFUWunwaXieIKT5oBo4HAs?=
 =?us-ascii?Q?ccbZxHZjgLi9gZ+AvlIB+MXC0UgQpo/kdj6mAG/acMFYFHVDyJVP73JkUMir?=
 =?us-ascii?Q?Cwfmzu/zS75+o14wKgJaqIY4xqgAergMItycChsSspcNDZVKArmdh4mf/vpg?=
 =?us-ascii?Q?MDlDuwb2Jml281VMumqK2UWpZSAjeKad+EpgGIAdqqpMCvnSNcllgnDGjlpk?=
 =?us-ascii?Q?iipZSkoUqGOrcEAGt/wTFNIXNszZbE4XT177gvQ4H53I8pmI+cYyFC75Or83?=
 =?us-ascii?Q?secVjOUU2fWOICmBhjLUnq03CeTsxIMnSnlINnZly4WV0SdWFyz6NJZ0ykSw?=
 =?us-ascii?Q?6dYPhU7vhco0MoTBJxY2ZtvfDl/hyLSQBZB7Sw56uaqlHM9epB8Nwy+oaw6M?=
 =?us-ascii?Q?OxDGu+5B2eZtZzPnlMjYtfBFKGchzCjukJ8Y+XehPv7NBOsVrplP6L1q5GjW?=
 =?us-ascii?Q?s2Kgqn1MulgbkIQLAaDRyKU4FOuvmNK/KLkkiwqY+oOnRgQfTovO429zIE6t?=
 =?us-ascii?Q?FjcJGZu4grNHFumbq1LDB4/c4jAzbMKi1jelrUEG6pbwhRIuD9iVcWt+WYbz?=
 =?us-ascii?Q?4qiq9dhhWShDntM9f0WZHUdv1G6OZmi5dpm4+nRdNs04HkkqjRuucWBC670N?=
 =?us-ascii?Q?0nMbcHb2bIDlUcIo0HE6EN6zdRnoyH3TVR/dFJAGda3BQRp3oMdP7jmktSI/?=
 =?us-ascii?Q?z8kXS8937Kzb4isVV4lWy1NsL8WcFqctoyJa6oTt84q8pOzLcJDceobNx2HS?=
 =?us-ascii?Q?K8DMAeifSRfeBktN8pHAoljQtkNXwZzdGoJZrkYU2YBes1+u5wUtZsHsTsKe?=
 =?us-ascii?Q?ccRISAjfVc7JI9Ufbn8hJn6SoMUbNic9qvwGo65TUCnOY3wdaKSCkMNZhaRW?=
 =?us-ascii?Q?nzWMxedeO02pvnkLcIg2M4Tmc/1zFVvgMNaCKEonpYBvpYYGxPmsxDdGnAnD?=
 =?us-ascii?Q?TUt8y2JiJCqOsQH+D73s7NkDXCSnvB83xdkL+Fo57vevbpefHmxNxhIZ+Kye?=
 =?us-ascii?Q?TALIfjs1i4WJFQNd4rxszFQNltkgxydYhwFu12XOOzDMj05LMIObVnj81kgt?=
 =?us-ascii?Q?4FuMpTWSxdfzE8x9JOqyhGs1AZto52ZSQyvg3N0XMLzWutKp8u8ZwvXELLya?=
 =?us-ascii?Q?h5Hwr7cCLqntAQJ0d4b1XKDGvGsRbD15PxgqDE9TAtS2mcL7DCVVUKc1Y0if?=
 =?us-ascii?Q?mkWEQvzWW5hj2gpOjGy5PbbHgSZWHSDEm36SgLWNQuouhSSM1F62I/Imb0AQ?=
 =?us-ascii?Q?KyZ1f+ZP53Pp2UTMAPu77VkxjVj9E9wGGbF1f/QKCuzsBjzgh9jkR7IQfy+Z?=
 =?us-ascii?Q?Fa76dDxaTTMGS3uQJMjiC3uewCqTA0uptkrBRcyGRPU+EvNC9fLS97MXF/+a?=
 =?us-ascii?Q?Wc3TTxWpUZPMV0siCq5g1Rgt+I5rti3zX/VdFcRMGXG+L1pZ6guwR7S+63D4?=
 =?us-ascii?Q?UY1+c5uXOqxf9QMuM/5QJXJxnFjzdCzc5q4GOFFedgh6e4281vmVXhIgneuN?=
 =?us-ascii?Q?MAGxqMhRP0loZwZhibw0JHPnB7X0ROcXFK0LdGTgyFOKVv2epQImUXC4XO4P?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca04cd2c-cf9d-4eb7-e1b3-08ddbe1d24a7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 12:44:13.7234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErFyGodyxyhzluz+4Pu5/syTYR/ripnBRYLY8JtyM1YEz9ptq0UgHzvOpCOQ6bM0o6ZdIMG4FnPgfrfgWjlZl0bvaka3KUORSOB8O5GLOq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7053
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

On Tue, Jul 08, 2025 at 02:28:16PM +0200, David Marchand wrote:
> Content (param[]) of received multiprocess messages are aligned with
> a 4 bytes constraint.
> 
> Before patch:
> struct mp_msg_internal {
>  int type;                                                     /*   0     4 */
>  struct rte_mp_msg {
>   char name[64];                                               /*   4    64 */
>   /* --- cacheline 1 boundary (64 bytes) was 4 bytes ago --- */
>   int len_param;                                               /*  68     4 */
>   int num_fds;                                                 /*  72     4 */
>   /* typedef uint8_t -> __uint8_t */ unsigned char param[256]; /*  76   256 */
>   /* --- cacheline 5 boundary (320 bytes) was 12 bytes ago --- */
>   int fds[253];                                                /* 332  1012 */
>  } msg;                                                        /*   4  1340 */
> 
>  /* size: 1344, cachelines: 21, members: 2 */
> };
> 
> This results in many unaligned accesses for multiprocess malloc requests.
> 
> Examples:
> ../lib/eal/common/malloc_mp.c:308:32: runtime error:
> 	member access within misaligned address 0x7f7b35df4684 for type
> 	'const struct malloc_mp_req', which requires 8 byte alignment
> 
> ../lib/eal/common/malloc_mp.c:158:9: runtime error:
> 	member access within misaligned address 0x7f36a535bb5c for type
> 	'const struct malloc_mp_req', which requires 8 byte alignment
> 
> ../lib/eal/common/malloc_mp.c:171:8: runtime error:
> 	member access within misaligned address 0x7f4ba65f296c for type
> 	'struct malloc_mp_req', which requires 8 byte alignment
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/eal/common/eal_common_proc.c |  2 +-
>  lib/eal/common/malloc_mp.c       | 18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
> index 0dea787e38..3846c7178d 100644
> --- a/lib/eal/common/eal_common_proc.c
> +++ b/lib/eal/common/eal_common_proc.c
> @@ -62,7 +62,7 @@ enum mp_type {
>  
>  struct mp_msg_internal {
>  	int type;
> -	struct rte_mp_msg msg;
> +	alignas(8) struct rte_mp_msg msg;
>  };
>  
>  struct async_request_param {
> diff --git a/lib/eal/common/malloc_mp.c b/lib/eal/common/malloc_mp.c
> index 9765277f5d..000c7f6b47 100644
> --- a/lib/eal/common/malloc_mp.c
> +++ b/lib/eal/common/malloc_mp.c
> @@ -148,7 +148,7 @@ get_unique_id(void)
>  static int
>  handle_sync(const struct rte_mp_msg *msg, const void *peer)
>  {
> -	struct rte_mp_msg reply;
> +	alignas(8) struct rte_mp_msg reply;
>  	const struct malloc_mp_req *req =
>  			(const struct malloc_mp_req *)msg->param;

This patch seems to have a lot of these definitions with alignas added to
them. Would it be simpler just to put the alignas inside the rte_mp_msg
definition?

More specifically, if its the "uint8_t param" element that needs alignment,
how about changing that specific field to make it aligned?

/Bruce
