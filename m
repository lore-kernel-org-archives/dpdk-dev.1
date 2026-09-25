Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59422C9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 13:29:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 467E7402D9;
	Fri, 25 Sep 2026 15:29:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 954C340294
 for <dev@dpdk.org>; Fri, 25 Sep 2026 15:29:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790342963; x=1821878963;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=IiNFbGIBE4PfIT39jS2ezXsry5OmkQOPPx0n8qUy51k=;
 b=Om6u6oKk5uRzVC2kjNMe/WCuH0Ec+A97U4jao4aUOZJsW+zXdCIN8zUH
 cQKXLpvu1lGqJGZkTbwo30wMO9hKgejk1c+cLTsH7iqFWooAY/xIMoro+
 Af0hZyrhID68JXjtXV28eagqK3XmTmyZTIlJdHeFmwoiJJI8Z91X+0kGB
 GOFAUsES3k8PPmKmd4DDkJujPFYOf2gum2EfYDp7EosTHOIop0dcMaTMQ
 6ORg3VA1hqcB8IMYZO1mj/UhwQnCwTWrqbW75m3Tu/uh1TDlHzb55U5gR
 /fE+ztnv/U/SVMFNJh0on8z8Rlv8CullG/vltC/v/5fAG76JLTdXReZwX g==;
X-CSE-ConnectionGUID: AKjeMHBlQcSh0KOVXUpfhQ==
X-CSE-MsgGUID: yvUthFbWT/CDKR8TCM3cOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101703314"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="101703314"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 06:29:23 -0700
X-CSE-ConnectionGUID: bIR7T9bTSjmIG9DKTx5VGw==
X-CSE-MsgGUID: 7EPn6h5/RVi7yxAHngCPJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="273566991"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 06:29:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 06:29:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 06:29:22 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 06:29:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nn5i8zLqa+ulV6GSXvAnmKX+p4TRDpHUfAvO2VOffplXhzwkDx7jSc7iZJkiYsh9V81zPRFXYxKl7Kyi+6Y7nmEXTxUZfUf7Za+qYMYs23PdRy4O6wUE5cSx5ExpXZNn6XKKy5kwvZPQ1C597+t5snx2EDFFuEuIndGat3QeQXMODn9mv+yrOqLUrFIMM77q1L7Q/TtRempW3/csjr8pIas0u6imuN7bmWiVlTj6+QIhpYKDuE12djwJhmy68nCRk9IxJK1SP4nUL8MvRYBVix4PpwwxvWxpQhfK8hELQmgq9FO6VAa7XqBJrSAdHBT0r2sD3m+GvIRFGOUDMNvGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGywpT/GULLY0WCFXr29VVWbktSgYr9L1xtJ+oN/jyo=;
 b=pWEXTS/oJFWsmnspWqM2QOIW7j6h1CZzPeXIpAiTGTZqVqXMehwvvkJikIJlwwT7L0HLhvnSHO5/KdVbnFF3Po11vAJ79HeABre3s93wg+g70wgisRzMmMVXpByAakNp3vbl22dsgsREc3QsH/il6K0yXvBgQyspPG2irpJQxBO3jRQji999Xarj2jtd3g0VndE9lKPQjMY6keCorHluAvYuDp+NjxeM58SWkfR1/GLJIPUEBgl0oDbYUAcojECnf1SrCzoQNPkGhvZGugtMu2SW7WUm1JDshUeOkbMLM5n+GxB34cObxaLR+uMwx/2mv9bGeyScEpPvWPXljEdvsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH7PR11MB7661.namprd11.prod.outlook.com (2603:10b6:510:27b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 13:29:19 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.018; Fri, 25 Sep 2026
 13:29:19 +0000
Date: Fri, 25 Sep 2026 14:29:13 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: Ciara Loftus <ciara.loftus@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH 0/6] Fix inconsistencies in offload masks
Message-ID: <arZ3Kd0BJUo1RfE2@bricha3-mobl1.ger.corp.intel.com>
References: <20260924131346.100156-1-ciara.loftus@intel.com>
 <7453e71e-877b-4446-9122-80d6ac609d86@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7453e71e-877b-4446-9122-80d6ac609d86@intel.com>
X-ClientProxiedBy: DUZP191CA0043.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::26) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH7PR11MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf8b703-7cc2-4178-78b6-08df1b090084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GXmLOsWxuWqryj/ZtoUhKBjH2/6LpHOvsZItSxPR2K8vmmemykav6YXN/u6PQvoHEhbuPJH1u03eoQ+uWORRfycnEBc9PCT0l0JWGwu1QZorKZg6Ek70ZaUgHX+frdjF08i2ZeOfPx++09KbxF7f2ZGqM2i9wWp0unZre9c5o+FIfzYK5pgHHKj6c6mkEjfaxSJILuLxuQDTdbgMCU+m0DSgVh53r+K9a1iLOuyO91N9Z9eEug6G+KAGebzIQ2VTSUwSj0QhbsgL9srnMkWOXpI6NUcriCKH5qEuDNbpF6ggJuP0kTsJjGzGKP1o/dpcn6yO0oPOLZuxq4PpmLVJZFGH0FPJuXuYrHH3t/jtryDuJAmKxh2nt9FN/v7Lh9Z551U/DpkagRZu8uSGvGC2NaD+rWfz4sincz7v97TTPXuLdsGGgfCpBKSXBRRc+mQXzFY8nL6lyGs7hXHv6fnxhtu76FlSqdM4o1G4F9EJjxYe4kuvGm65uB6TT3VJ2m6W36gZuqAovH3xIDoIEBVxC5IaNnyE3AH8wVh8ZR8UtuGWV35AhzU5Ss/KW4GpirHcFHe3fUWimeyYpvkKqpnn4V1jaVjK1pBi965kN7t8Nelz4uMJZlHt7asZvHZ6RqdGqb/ulY4BvdhJhl2aLs8dekkq0gP9aDmJ48JJSfxI1/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/deWdrSVK2AexbsaT+SVib2Vc4JFky54T8Z2IqRBPdDFQQGEUd3fJQWo1FtJ?=
 =?us-ascii?Q?URIjyzj/xJxeb2g6M15Nz7M0EVSOcONZz75p7qG3Y5tOMRIXM07aqsQ0gNrq?=
 =?us-ascii?Q?44aomkzpM6V6URIfrtxfIKWmUdGHlztq2vvLasqI2xL9zDgzPEsRJB5kCGxK?=
 =?us-ascii?Q?56VZlOUYdfK9Q/LhW5hOkbZvUEV3ANcLD5iEkJxVhqpaE10+FtuU0S6B+kg8?=
 =?us-ascii?Q?KcMNNBJ8O6aEiA0jG3xDf8GdyIjlFua/LrNXmxR2y8vv6uF5kDArasfD82rG?=
 =?us-ascii?Q?wG1G45LQNrXPtm34YUsvyFRZYqU01KNQigwTS1OdS+ee1KbtPx6a+WUYt+he?=
 =?us-ascii?Q?vk5rR41Qikx/MtiUb8KJGDoNQ+SQ8J00+1Ej5qG0V/57RcUs79AUNQzgjaj/?=
 =?us-ascii?Q?PmegoWSOPmbPkK0f6pCQfBP89CP2glq9YBwvF5W1v7CQSyAATADLd+jneyc2?=
 =?us-ascii?Q?dS1zXbL5bv5ntsMjho+VoaquoCz3Qq32t0RxNSapRotQ3Jut1kSaiEgaqJiK?=
 =?us-ascii?Q?L3FkASaneoVT99q1hQe6znrLn19Z9UC9Amt1+WRbYYFtE2W7z0bhH239zl87?=
 =?us-ascii?Q?k0BgS4jLZGTLcGwST/1GalKy1J5bd0AFRdblfKpRGZ9hjXlc/cypCBQA/bfz?=
 =?us-ascii?Q?PvFik/LXQ6SAbGHTsG4GkMFRvguStWF2dcI96d+wB5olLjFB6tjEhcW/7hlE?=
 =?us-ascii?Q?FOQt34SbZA0yWjJDd+rhLrGYP/iMaTwrz/u7dZTtSPOv8KLHekeZm02XGtxW?=
 =?us-ascii?Q?M46WRiUgWqLIvrA9vq7ZTA+JCqgV1W7HGvKYDrxpV2b8dWg2GNf9rycNZU4h?=
 =?us-ascii?Q?nYqbyZNSdczMY5zryhXcwBOIs+3AoNEk92lNQdstmYzZhmjQX5u4JYuEjnXd?=
 =?us-ascii?Q?ZzyLORgZqFYI94Cn6q1r6o/dyQI/MdwewBkfQKrPTEsQ9ZwMEkucgz0iisNx?=
 =?us-ascii?Q?zOXtkUp/JttMxTnKy7dQ3Xa86ElxYwplM1JLL6S0L9arIfWGAFB1i1gMH6Hr?=
 =?us-ascii?Q?N729fJPA9Bxm8idRiee6wRiuZqb6A2LiEczScO/ADsBgs3kMrWS2aqIHN0HY?=
 =?us-ascii?Q?/ZQct5WVVS4xBMJW6Attv1UO3hqOE2Tseg2q866NEsNchrpY652A2ZDAQloz?=
 =?us-ascii?Q?DHzcL+xl1FH4EY6uyLcHR9eE1ElKuTf180wJhQMKFvX6IZL30vF4mR2GhVYT?=
 =?us-ascii?Q?qCyCY4RUsUWcb59z1BhWK7A1xaey6qE865bKj0AKuXSZLoq5/xiM0hYK1zkV?=
 =?us-ascii?Q?qE626ggigwDstSZIVmcnfdGOTuafFMYa+BpnvAIp6aF9DT9Tdv0PN7qeRE6e?=
 =?us-ascii?Q?UUCTW+TDbrVhFCxBZ9ErZRYpE8F8QlEN+Vx0VkfGokNoYAqIO3qrBOOHlEcJ?=
 =?us-ascii?Q?y3wn0b5p3IxPcoKrQjo6W3xxJSGJG3P+Zlz3GjpV3rjlEKMAL+XCY5QD7JgE?=
 =?us-ascii?Q?qn4K63kXhf/0wINQ5OhuHWD53nKfijINVptR080RTGuIgI7EZCCi6N+jJLV6?=
 =?us-ascii?Q?T1SZq/0laDOB/dpX7vw39fgnVkupddfF5ytBCkED5hQvXgraUbiqUkZOz/IV?=
 =?us-ascii?Q?Z26Wbz4Cd3gQjROihXwqx0TdkojaQnOAzMTcn67FC9njUq8gVqmYxbSW/e0L?=
 =?us-ascii?Q?FYEglSK1/HEQCVRGb4vP65g9FN6aP0AfrzOdFFF548h5aDE09qr1Zvg2X7aa?=
 =?us-ascii?Q?tQpITm/E1rU+TeQFbA5iUcYy44yQndbjLjH++CCsx2DsUxvAfzljBD9fc5ys?=
 =?us-ascii?Q?iYvdo0lj9+U2fCSa0aakw1NRUY7HOds=3D?=
X-Exchange-RoutingPolicyChecked: vsUHTwVrXWZpVzcdxhROQcqxemBqWaSiBP+FLiZpL80swsZ27MjFN63mykQ6HPiMdriJsoeUkxewCDYw6KP71X1+swMVnSupZ/cmro1k/P0pmZ3hC/176bmAYhy9J4Efl8EXsVc/HLfvqHQ/gNHiDYjJlbcR4aOzQsIAcWrZtQlAq0M2eqmC6lQoihabspu3WF3zHWbfok0+pWB3X37v3pg/XWoSONYsolL9I5VTBwsTi03ptgkZWc76hkuxZa86v6Hwo0uGyLDYc+pYICx0dXYr+TnEfEZXJhn6w/jGiQOq0ZBP6iZog5qE31kdyH1aJmocLxxVJtY++9/Ej9deFw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf8b703-7cc2-4178-78b6-08df1b090084
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:29:18.9418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVcGtHFRno+i8be4GZxAnpyTVCDxZ6Y/ZBQMopnf1OF+KtxXiAjSgN3jp2ukZoem5GZC5Ozfv35H8i9/Zdn0f3V8cLL0NnAX8z89PyokLMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7661
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

On Fri, Sep 25, 2026 at 12:50:14PM +0200, Burakov, Anatoly wrote:
> On 9/24/2026 3:13 PM, Ciara Loftus wrote:
> > This series fixes some inconsistencies in the path offload masks and
> > dev_info offload capabilities for the ice, iavf and i40e drivers.
> > The first 3 patches are concerned with fixing the path offload masks.
> > The last 3 patches change how offloads are derived for the dev_info offload
> > capabilities. Instead of defining an explicit list of offloads, reuse the
> > information that is already available in the path offload masks. It should
> > help prevent further inconsistencies in the future.
> > 
> 
> Series-acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
Series applied to dpdk-next-net-intel

Thanks,
/Bruce
