Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64919CD98F6
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 09:55:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C429B40671;
	Fri, 19 Jun 2026 11:55:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id DB20040279
 for <dev@dpdk.org>; Fri, 19 Jun 2026 11:55:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781862929; x=1813398929;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=MAu+3S5g75dxb09d+FxqT8Xh0TS6N8cSjPJLns4I0P4=;
 b=i9wsxtqD2P7q5P1dU1BLX3eER1UMx1m1akwalNZh5jl1EHwSnVj0RCCD
 xd0vwkP2R/2Mahb31UUpZVgnp54tF3dxb8wVVzSiUE9sd6rVcL+fGWBAv
 MtFZkFbAQ5OSJ7EsXUp+N5Ey2/XtZbfIIp6dpgo+HQzytQdMLFJl6AScB
 TjB4NrEVR0INLzxYtq2oCS6AUkKj0Ah9TsvHbjlpIjXCTVjRHOOGVElDK
 OErFWsiLMScrE5SKpe+l7cqts2KdS/d5iZDOTmqO3+OO7snrw1iudxr2S
 wprkZeDS3Rbu3+KrlEN99N8Vd0uAgI8j3y4k2qo108MnzQHO83kwPK/jx g==;
X-CSE-ConnectionGUID: IJPUpzPwSuesic58F4jIDw==
X-CSE-MsgGUID: mYI828O2St6YU2ivyNuUHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="100140843"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="100140843"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 02:55:28 -0700
X-CSE-ConnectionGUID: 6QuMdvHATb2mIaCzzqzN1w==
X-CSE-MsgGUID: KHlv0QKySTCOwpkfxTqZEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="278774924"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 02:55:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 02:55:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 19 Jun 2026 02:55:27 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 02:55:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfGUVCfXhaDmQwNSv7gbc7ECbd13BE+oqDNHv/P858rJzEv5ttBAjHYgAOJjqS+y0JhZvMY9RgZLjLAZxcMZlAH+d+JCP/zHTv8XK9JScmaMg2Gi8yeeSG4meeTOCTCrZPd5i8FUC1fnjctu67szsTkJ4ZUBqazwLt+VbdNAhfULKOvEVnCQ+ABOt3GEkXoRxOiciU8TeJLHuK5YVWu7wmanZYfP5I9kVWztRJ8KF5r6Kz9+w3XMCGsczyw30fupfdmYbshJGDZneJKyW5LOl+2nocj3+oqG/jv3FC1tTUA9GIFOMwd1XmX55VOHOKA+P5WdhRO3wurDY1WC617eXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHDfGwwzRQdSeOuygA/STJHBynrJvusaZsWhI6Lg5eU=;
 b=s9Dbzwz/8t6bfWSOoFex39/FypZRNc3FKkW5tL49lZ2ntW8v6/w+nynBFkFbs/phz0YiDMjTnW2/Gavxzf0JGipJuO96445G1ac1ESwz6ZY94UWRjGjLI2ni2SZjBNOzO7BSju3JWeq10UBQHjb2xF8HXTDUlioTCid58bISD+k6btq8znsQSIa9uhuqv1SFT7HKpb9EE5m+73bHQt7kZfz8ER0wwf4lxCcQ/1xZD9nxvBPGVY+ZfBojUqC7biKK3u6HYiWZl3bUe6kw+lFDRJsPxV2KGr7d6W0J6Pkp9ldXmKRWuQgXo61zDuK8TE6NFf+25Z+Pg56X5R44bws5Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PR11MB8734.namprd11.prod.outlook.com (2603:10b6:8:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 09:55:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 09:55:25 +0000
Date: Fri, 19 Jun 2026 10:55:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)"
 <humin29@huawei.com>
Subject: Re: [PATCH v2 4/4] net/bonding: remove redundant function names from
 log
Message-ID: <ajUSB1cO_LHocAIh@bricha3-mobl1.ger.corp.intel.com>
References: <20260417165530.653328-1-stephen@networkplumber.org>
 <20260529000157.235931-1-stephen@networkplumber.org>
 <20260529000157.235931-5-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260529000157.235931-5-stephen@networkplumber.org>
X-ClientProxiedBy: DB3PR08CA0020.eurprd08.prod.outlook.com (2603:10a6:8::33)
 To DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PR11MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 30aecef0-b39d-4e1d-8313-08decde8e280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: hhdPFKufD0j8Rc+gbLZPrXDRbZvW7ZJxtxd0cEY11deulXsJofZ0NVQ4YSQIKgiDX4fSFAE6YIF4GkyJMJrFaABDlRs4/bnFGeP/gJG8uFrHd0+pQ7eT5GQ5Eh6sH08ZiS0N7kVUM6232JXnRBJxxrU5G1hh06aH0oC2dxIXjfv8QNNNolKjvnkhp81iWFUynYghFZWnl+8oitHWK3/wkD0OSYNPKzjqpaXlLXRc8nYLf8e3U45duU8wTXULsuyBpK9WsKQfU35LT5KZNCsKE1FctraYkrwbydhzzhZ5EgEVUgNzlQB6x+vJAQoNltDgnWUmUdH/ovn2OI0r3n0AvEFfJ57OmEJ5rcdkWkl0cEvTA4vhUR+jc+tgKUWn5QTwQ1BIkyfMA7lDK+z7z5dnX4AfDDzRABVsHNyIlX0cH0NdsUt3vUYCcDZG3cdo+3ebrkuucNLm0+njpljmmmpgD2luqQB1mN5n8X5MtnNkzJkzMKYvOKpG9uum1QkaAOAIReDChLizOdGf6wAbaYLoqdHhkLyc/MJEZYenDB9JT6853giJ9WrMhPnHSgkT2PLAKk9QXj86hCVii9YlvUT/OsHVDNtXcYDVVraZaYcpE/dN3Lse2lNkTk5DP9gQF694HuB7htmPxc/qhgOAOcCJt7IvJMP3SmIgzUzEhsMB7/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DGEWRBqmdaCCu8igzz6AELGCmCk44i5f7+y3NLUg3T00KbuYwGZG4eFgnlRs?=
 =?us-ascii?Q?HU3oYGJEw4z9VBwwOS1WJgJX5z+c3xd8LvmHwReX9lkry0rh2Bk/U2OckYrW?=
 =?us-ascii?Q?iYWmPxzCE7wfgefM9Q0Ia/kopt4H+Hnc++bAZo9Cqgz265xPybtcvlISIk0O?=
 =?us-ascii?Q?SMAoYdBl0T6TU6DUninK/V4/ltOOBegU22UEqF+h3ynov/damTyo1qAbwudM?=
 =?us-ascii?Q?HydkKptqoHPPhAOOV7Hs7SWc+HJmcvEZarmta9IeLJjKJgQoutf/GAfV8bg6?=
 =?us-ascii?Q?a/LTQS7xIrEt3WjLN/ptwljb7hyG6ZU5H6I548KYeGcTDIEhv9q1z/X0SPcE?=
 =?us-ascii?Q?EIWLk3CiNO4c1IBg1wUewEFSsq0RD6fo9T6PgvDxSSyWmJzGKbdmQb2jID+q?=
 =?us-ascii?Q?ptJdweUjuRidXs6qKQ4yVwGP7TEPKIOmJoGmbRy521+grH0cQmdkmpTVOIHG?=
 =?us-ascii?Q?lggRH1BobHuJRsJaXdSQVCeVKjTdf9TPFrWRtfmK9jG3nE8fTRt7IXCGhcXt?=
 =?us-ascii?Q?ZKfYUzdWKR5yBvg3srfHMPI0j+hUozO2OX++nEK+wG/vLBTl1d8kTGAW0eDn?=
 =?us-ascii?Q?ZpPosFgH3DwEdGNHlrX/cYoOPyzDzBA5szwqYQo/VeTzE3Dp10f68QWUIC9Z?=
 =?us-ascii?Q?F5nD6Yx3iGUEVBMwLoKN5MlrT5NgYHeNTbT7xim/4oAHWFD4OAUj1CNCk27/?=
 =?us-ascii?Q?K8gFk3Zd96CZcVF+5r1y3Huw96J96CeZQYZYaJLGfgdrWVWCnMnCiUZ821hz?=
 =?us-ascii?Q?YoGmpTIl3IrA/7PgdAz2XFE5TeiviKo+/0EXpQUkd9GgXkoQfO8hybfl/Q5o?=
 =?us-ascii?Q?I4FeuCzLfA1IGvDeYmRklcfHNsF7TMOYKIpreBhtZxczGDaT7M5/Yr6608ze?=
 =?us-ascii?Q?O7p+Zs8vj/gshYPdMbpgr5vgZDkU8FxPfWW7KUmHikZworZYMaoJDcFLpi56?=
 =?us-ascii?Q?7oITVWt8RvZPeAJEuoTIKJHvNGKBcVDBX3hErRXiWx++xJWD5TeMu/4c7//r?=
 =?us-ascii?Q?PNlAcNEUaGoJGvGUDmu7qo+yhIyV4EgIRcEfi3MhFaK3ZXVQy7CoU1uHvHGh?=
 =?us-ascii?Q?7fJOUnxsN9brwnUxpdvh/+YzVkH7n8f6n166sCvl9b5ox7dAd5+5/ycKmHhf?=
 =?us-ascii?Q?ffb+J1cIbPL14UXfUckEuXlgJWafLBLeWphiDOohocTIbehS/RfmC3vXOcjR?=
 =?us-ascii?Q?bppKi5WzyVyV6vO4j+w6ub1jLJEgR2/XoJaNF/BCgQayc/3RNnViQq8Bm+CW?=
 =?us-ascii?Q?nE+tglR5klxWeLl1ojGP7Y7Zdql4nePd8EhRnq0IGhwcGNGDKtj3nHum1Zt9?=
 =?us-ascii?Q?3/izB7YT3jMBoVOiPosmF6Ia7SY0RnbWJRhr+i06yQD351SSxkNpEKeKN8ch?=
 =?us-ascii?Q?YtO/FBA9FZozQYJ+izG1joozro3rOJTVUsBoJfAeIDB9EZEAqRp57gAaperq?=
 =?us-ascii?Q?UK3eRX31WFQ/PE9wXl8415lYSTyDuItmYuxnjpz5SUhcDRNik+uo8xkBRfaT?=
 =?us-ascii?Q?/wQ/779v2gzTcmqpnrcsqS4l3dQ07bjpjyIaHaZd/Ibm1whRtDc+MbhLI/Y0?=
 =?us-ascii?Q?kWS8mYGXynKeIzOdhcThWoeLKr6fK5H4F3rsKd6YyAq1yZJOUTAFLjw/jpKp?=
 =?us-ascii?Q?eZ30aYtiMmjFNBMT++xExG8gNLRJqjcfhpMw4z7jWB9agoEE74bQzUr3AZoH?=
 =?us-ascii?Q?zII/4Mz8yIQKgeHJXajepegQSBNbUv3KnSX/JES1CfPWnie4Arv8NKuMvkxY?=
 =?us-ascii?Q?AtGasaBxKKq5OWeYcKsYoNq1znD9gOA=3D?=
X-Exchange-RoutingPolicyChecked: KGn9+8l996JqIvXGH2S5uiSzi/0g1RPyuWi/Sc99bvPFxLEqsZ5zT/FYG7ILPJOhsW8h/AJHKQYH2zhVsCzD7toI5136bZd468p9jjSx7xBajBEDtyZQTrUqaheZPsFLgiqIFAWwuoa1vamrpFBY0ATuttcbaur3G84cbsneJQ96wvcLl3mmLdiRZ2qSocCvQPBJU9BfveLk7ymEaZLJ66qSNjbdWiKX0JQmSzoRlHYDCMd9Y5rS31dfIR4n/1VtwRnyyvkxONcs3N8t2NfUtyb+8zikA6H6bNbnrvlhl+6wBlFkooPFK5kZSFmjVFyXhp06Cq0uj1r7PzjaMBs8vA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 30aecef0-b39d-4e1d-8313-08decde8e280
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 09:55:25.0691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhcUt8ft7G0/E7MAUtNMdF8omRXp2DARGpJZTDpPUtpZiTneBHsPtBAuW685IQhrXlrc2PCY+JFH2tJudF6qxxQJuE2kG5UY1g5CUdwF8QI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8734
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

On Thu, May 28, 2026 at 04:59:16PM -0700, Stephen Hemminger wrote:
> The function name is already printed as part of RTE_BOND_LOG().
> Fix grammar in log messages.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
