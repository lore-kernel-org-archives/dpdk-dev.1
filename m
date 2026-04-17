Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9526F4369A
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 13:00:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD9EE402F1;
	Fri, 17 Apr 2026 15:00:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 92879402F1
 for <dev@dpdk.org>; Fri, 17 Apr 2026 15:00:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776430838; x=1807966838;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lmWYDwYBYwU8qHBn/NT43KfRVKWN403XVjeym1iTlss=;
 b=jYrEvlytDZEmK7Xes7hoYY0SFfjtYDTC7+hFzh6698F29dOfTGgvvHIk
 hzF2bhblQZ6oOVjcCKgmKWJvXSBrkSmtvYbGiGMcMCFOq3nghcOvWTY2o
 KCHA+pvA4+rBtAH1lCfg2WqqacLRSYIM9XLk5DR0XAqooeiICG+ttdHOA
 3aX9Uwm63pBVBVzKY5uZDXauyJwucjiAF4WXMPYvJF3GbPEDj7yIh2WBr
 X19b8K75VT8uApd/fPi46Y/zWw6hhtLlBUaYq1dcGzanExAXncnNcBF2g
 BQYmGWdPu27Ld7vkEY4kX51mZTNFPDnD+tOklYUCiDm/oI4rpNF/BmiRp w==;
X-CSE-ConnectionGUID: oEO1ydXUTrm6A//X0q9Sew==
X-CSE-MsgGUID: JyU1TrVdS8aJqIpuckg3QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="94844286"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="94844286"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 06:00:36 -0700
X-CSE-ConnectionGUID: cAzhltnhQLSG0+YiFst0VA==
X-CSE-MsgGUID: xOJF4gB+QIeDWHOBglFwHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="254502132"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 06:00:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 06:00:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 17 Apr 2026 06:00:35 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 06:00:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJXp37Z9WgNososZcM2siXPcjeiyqjQZ5w2RhLMLfzDy4+spXAGQ/rP05JUfJkKKsR+TY+2Md3tMA0nXFlURo9qPTAXg8/ibi5TOaAYpL2dzwrNdpDf+GVRCs/6YrWLZfJX3NV8bTrQpJVEyqrGPDEmShGq23vhVjDao04JbWwLxZiQCqO1qVotFxLrSdBVmQU5XuzFd0qhzDg0Tk3vjgHWDQiclLcxC5trVN1cMyZY34fcJGAgg3dMeDdIM8yTr+blhTGKgyquaM059iIbRB5/iAeqpcXaf/3BcXYPvGAKSnopomLRp7Tu+2I8d+XynMm+EsrxgKd2wex55TG0GGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/y61Egy0ALaKA4mC8Dk6r5y7X4AgIPD3Q6/mGVUUEaY=;
 b=IfMjDGzaokfEdPt/H9I0VtaFAsDW6Q3OfZUF5ZDfvKuUUCRcwI+Ll3/lvN/dIu56qzWA8DjqnflkhnvLEe+H6cu2lQo+QAlmJrpboKOIh/qvk+Y4s70VjWOYt40QZvmCoKSjW1YHgu/uFYotRnqmW7z1Q1efGm1HOnLrJwtCEezH1YnVzPEN2Ttzxs6ZXBol0EF4hHM7L3G0k17EvKOD5KiQNkySMhusOPkYtRW+32KTd7umT0thqQgjP/pmwi58wuTo/Bw35DwKDv3gL1DpUNqii2zaMNyY8rMQlg3/LUZVuFcqxBjkck9dMjoKv1d/8PSSRPYktYgHSYGw6HMa5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB9801.namprd11.prod.outlook.com (2603:10b6:806:4da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 13:00:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 13:00:33 +0000
Date: Fri, 17 Apr 2026 14:00:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 1/3] net/iavf: support LLDP Tx via mbuf ptype or
 dynfield
Message-ID: <aeIu7NDFotr45PKf@bricha3-mobl1.ger.corp.intel.com>
References: <20260417100804.1143121-1-ciara.loftus@intel.com>
 <20260417105610.1161242-1-ciara.loftus@intel.com>
 <20260417105610.1161242-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260417105610.1161242-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P195CA0002.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB9801:EE_
X-MS-Office365-Filtering-Correlation-Id: 10bdf2bf-25c7-4c2e-62d6-08de9c814f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: lw+7/VstNLH+4WVNOWWl6Xns6YDe7EOnVuM1EQqZtvJQUA40Heu/nQbaEoPW8m+7VeMW9Ie/NwcOkJdvmtUeAn9McNXVhvIApz29GUQnIbY6hblHTgTc4DptuxFrZPVWH6l3NqeAEJqMDi+SqWPImLdlIOXjK3DEVPP1PXKTnr0x8asJ4WXVVw6IQhKM40cMpPKaFGJWeSv1Mbirmw6DA/BfXeKcgUXseDNhgszxJQwf6ToZWK2Flb4jXvPhbHjwJq0BCkofjISr8nXROMgSL7J9fcKqzZL5w9f3bJnR+DS7XsSRZyfqZJ8WycLsjj5oLUTVYDzuKbS8Z9dAMPCYbywRW7HuDvRu0DwRKLh9VAddheNsl1Cly+AuQlHjqMN/X4PuPTrjZMgigMUYA9L1OpFtxNM7/Be0thHGosQ07YEV1bI3ySMWWcSYr2nKeXaTrSLnk9KDxvdgNdsXnsPH2ObMoW3zzbdTFCEwe9dn5h/l1CZWTLUuTb7UjIP0sgjTGMGaKnaMwjj77/k07nhimhqEx0GazEqvEn4n/ZO2MfPCGbh9xY5HqmfvV5XtPTNyDm0/hRcY1fTyBM6hSttj0EkVNvrhQCvrUPYybqeRJZUhda03qMtSEuC/UnEC4lnoI61c4MCaUW/81PKPFfOSrUnCR/jsgYRD8CDDz4pxobCrXkbpFwJy+klb+UagvGfpKcA3fiMQMaJ6Pkp6a69UOZRYmLAbfUhnm+h+2gY6ZH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LetZ5J0z3xKFofieGI0SkJE+szIb0uYRe/yRQxxz9hKvXk7IgnBPWvnL/9np?=
 =?us-ascii?Q?bqJoTVHEuwUcfZQ/B9kDGYAyn1APvoOoajCltZXHEZFeUxJEinWnKGTzuFlT?=
 =?us-ascii?Q?C6o8jvvKOCeFsIZEF5PQPfGGf8SWV7uOKrxnc1do7ReX73mV1ki5GJMEbokO?=
 =?us-ascii?Q?xXOZ0sVPySZUZT2br9LCBuoYFyJjITmSgqH1FXvcV+NPD4/ljZ58GkJInqFF?=
 =?us-ascii?Q?BHNyOdzdrTeSvQ/IifG15ezHyKV6Ouqoy9itPIENaJ9Or0IPRCNf1Z++6UeY?=
 =?us-ascii?Q?nb7WMedLdNGQMUemq/+LabC/89npUCIvRJES9nMdD9l6Ps6Zj6Mo/HwA5G5d?=
 =?us-ascii?Q?0oqfWKFsF0uNPdexms2iZIuxbHcV2kj/rTVXdp7SwdJUbijtNecXBwhqpaDt?=
 =?us-ascii?Q?q9n+AoVQYaYRTYvZ5kiIP4xMFHBGHyypcQJkm8xZA+lXbsJ+wMbPT5Acjqns?=
 =?us-ascii?Q?onJLXRD9HNuOkAkTVknpHqkwYxdkb32qiVJ9iP8LmFZ97WKXx5WRtnDUgpMn?=
 =?us-ascii?Q?SC0LuEp89Dk++/Usm+1GYa0klqmyLX0pSQoL+ajdikfGfBGA9fnnbiW62tHN?=
 =?us-ascii?Q?K5FXwXNMR/Kk9LgEdHQj9Cd9L/RwON0r0hqmNEfxTdPR9N3UJPHfDaPtSacO?=
 =?us-ascii?Q?XcI3hAdzCQDzZB3ZeoND6iEC+V7otCn4rQLSc0/16lnoiCLwFaatqXXBV3SD?=
 =?us-ascii?Q?BZRLH6dNIEwL1HwpNzstHqSfsSV2rr9W8fVZW62HyCbkC9XLC7GGZ7NpJ9L4?=
 =?us-ascii?Q?9GTKDbKMvFGak7ABZqLd8hFtxHFv9Fe+CtMUaLi4OyQODE9Bj5AY1uLSs5tU?=
 =?us-ascii?Q?3a2liUcAnUGQvn6EFmfbK0YDDo0JcfPkFu2o1pf0ZOto2ZFb2BQKR8etBTQS?=
 =?us-ascii?Q?JixUmwvJ7xd9JeWKpWQJdALQUSg011J5B7DZe5o1lby0hEDKY5LdH10xep30?=
 =?us-ascii?Q?dQH6qYtD0yoVsB4z1juWohBZbu4IoPGFRYswx3s6aNwFZbmNJdksq743+Zfa?=
 =?us-ascii?Q?4Y80dG8XaYVrM5ixrLMDInAdn4WHRwPgwPPUnDy2/qdKUVhe8eN9jp1bNK3W?=
 =?us-ascii?Q?7D7fVLzQKEjDc1sfv/AObPGMgDfBhphRLmjj8vnzWFTv5KFgAvkZ3JdpOB/m?=
 =?us-ascii?Q?JEtQYRHAOabGWkTvrhqJY81VQVV/936j6pnbN4yodL7wr68ewbiUYVwz5oKF?=
 =?us-ascii?Q?P82m87kNcDj89c42Vp1Yznf+Eb6BN7UZmju64FSlQ1j4q80bD8zDTRsapEyl?=
 =?us-ascii?Q?OKS6qTg62TiNtKl9hrcgGnSEUxBLTQq+VIVsEJBIN60s1ix4AIMPI5sOBs9O?=
 =?us-ascii?Q?V5mhU9jhsV1uG88AxaaXenD0MwM9vZ0Jyr8fg+T3RKXnWrIxZzTE8yka4QCm?=
 =?us-ascii?Q?gPO+1JezFHa/arj41e4KlWbXVq0zCxVqlHCJ8+fhgqIpFGAjMNNjQE0NMtCT?=
 =?us-ascii?Q?Gn5eAEZX822bwE/SGFeeeIdao2X5E5BYiqDtc3XD6k9kVuAWQF2Ccb5xhixe?=
 =?us-ascii?Q?A8FzW6pKnJknwgLJjH25Yyd3ymboXcQnkjnl4fJFO/WK7NPFi7v5NNuGlANt?=
 =?us-ascii?Q?lMxaqEAyR6esMSDHvMUoLBCO+B0hdjLZUYAZIe7jC2hQAvcS33lHMYB25iUH?=
 =?us-ascii?Q?vFIaF88fsx03exGGSfMxLC02H5JbqkM+1teqmOTrFVOKFrbrPKOqOvbOHD2x?=
 =?us-ascii?Q?1CM3tj5uypFffrlSJH4Rt00mwOEkHQrIuDsc4/BjkEvZz2jLp9UEC21aYD1m?=
 =?us-ascii?Q?5gL8gnDhg8EdhqXTz05mDjJKYqGBOc0=3D?=
X-Exchange-RoutingPolicyChecked: BLlPW0BW+u4A+J1l0eJVd+UQQB/7qavJ6Xv6a3PT2R68h2KJoWT95P7nDrj40kV6WuFTnbkH9oLPxlJMjr0+aNCK9wc3TttSawIrRFY8VNGj637DrCEW6BH7sQvBe7bN7SI+1o7Eya9uogKc6i6Ba+LroyMMyBW7ZI0pLjYuMkmlq0Ua5477zzxK6pF6Ml0Vf0bHJQuxx8f1OnjKtUbY57AGmhzbe5VNNrm/0QlI8h4JZ4lmEuG6cIUan+OT29DsvI4KVqoIuayO95VggcvXZPrQU/W+UliFiMZsoWiVP8AWu8B4ufOBYKkQM5O1E6MIjCiJp4Erk5rkymGwur8B4Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 10bdf2bf-25c7-4c2e-62d6-08de9c814f5c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 13:00:33.0478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/gb3kHsUE9xeqpwyGHm3kaGmIXXaKgBn8VYtNrH5bMm8jKNg+AQLr2WTFxpsPCeFUgNhmMXb6AZy2I7AWFc9T4wLYPedigwHdwGeCOxA/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9801
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

On Fri, Apr 17, 2026 at 10:56:08AM +0000, Ciara Loftus wrote:
> Previously, the only way to transmit LLDP packets via the iavf PMD
> was to register the IAVF_TX_LLDP_DYNFIELD dynamic mbuf field and set
> it to a non-zero value on each LLDP mbuf before Tx.
> 
> This patch adds an alternative. If the new devarg `enable_ptype_lldp` is
> set to 1, and if the mbuf packet type is set to RTE_PTYPE_L2_ETHER_LLDP
> then a Tx path with context descriptor support will be selected and any
> packets with the LLDP ptype will be transmitted.
> 
> The dynamic mbuf field support is still present however it is intended
> that it will be removed in a future release, at which point only the
> packet type approach will be supported.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  doc/guides/nics/intel_vf.rst           | 21 ++++++++++++++++-----
>  doc/guides/rel_notes/release_26_07.rst |  5 +++++
>  drivers/net/intel/iavf/iavf.h          |  1 +
>  drivers/net/intel/iavf/iavf_ethdev.c   | 15 +++++++++++++++
>  drivers/net/intel/iavf/iavf_rxtx.c     |  2 +-
>  drivers/net/intel/iavf/iavf_rxtx.h     |  9 +++++----
>  6 files changed, 43 insertions(+), 10 deletions(-)
> 
Comments from v3 still apply, I believe.
