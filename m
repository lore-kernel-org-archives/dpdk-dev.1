Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2941BC369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 14:39:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63D1640695;
	Tue, 29 Apr 2025 16:39:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id B092A4069D
 for <dev@dpdk.org>; Tue, 29 Apr 2025 16:39:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745937558; x=1777473558;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QrPIvIybmlDMrPkHSkiCDczpihZ+lXk3Q+cPRel96z4=;
 b=e5FujfQopVM8uCUZlCVjp0hK7tysrxHdf9ZHyywT1Ny8mJKwMMTaoA2r
 WVvNUQ+B2XblAYxaVjaFDXVJF608q2zHRE6mKm5FlTwbmhg5CcQLYXChX
 g+icfdo4nPQ6R+2+NTAryL6/IGvqSSTdJbIon1jn/19PPVJa5ZLXIJ1W0
 I+Thl6j3yaume1VbBgwCWu9LZo3GjzyQBRHIHQ+4vsensIKpq4ObpwTas
 tt/13IOB0fIiX5iXVQw/dMoccZygH0TwZZJ///Pz7gUUvnX3JaTOZiFu2
 f+zoOGy1gwO5Kz1m7Rb3qgtAXJXT5E9PktLnr3AUleFK63aD3jXY9odEx g==;
X-CSE-ConnectionGUID: Ohq25JQlQkOT/DkJcaIZVQ==
X-CSE-MsgGUID: XoRR986YSP+Z237ujsmX5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="65100108"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; d="scan'208";a="65100108"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 07:39:16 -0700
X-CSE-ConnectionGUID: PK5q5FzGQt6CaCv0tZW6aw==
X-CSE-MsgGUID: sy/gA5uCS4iBxSwJVhE26w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; d="scan'208";a="133745297"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 07:39:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 07:39:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 07:39:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 07:39:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCHoko9zX7ZJz8IdHLd9akmGIPNQg498FySK2hxeomVa7hP1XzGT5w1ARXjkSi+VgTcf9Mry0kdfhbfAG0SrO8ebicw3MerzipgEHTSxZCDSyxGB0+I2ea65RwG9Fsj2ttA8NcG62F2Az2ACvcxfZ2imty+eKYRJDgWygPuH3bGoBav0rPSMTw69vAS5gLw8IazqGjdzhPgo2v61ejHGCw1KabrSCiUAaG7pj0dY5PkSz3M+Z+d/w5pf0YYUeS54oGerP/QxEHDeL+/mOKFs90CP8wwG6OICUnDT/9t5djVSbHOWMpUorbQo8z2lbD4B57rq/MOeM452kPRrTc/D+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y88p4jbZDp1FyyDV1hqpA0ZzvHx5h7WNFSF4YPJRbXw=;
 b=LcKpV/Omai0ETXirVwh8B+vUFhz+P17i3LbML3Xc7b1fDr+Z61oWiGw4TaltJI+mEqQaRprQR6TBrd6+J3FNBTb0tYeKInWzuFNpKYFmJx0zer+cKBFPX25RB7LwXkppapA2L2+6tGsTgltsU+2vsSJ6B7LQPSlAB0DRTzuysWhFFtrmYSOdhsWWHmJLWx/LZ8BczO0hlaWszpQgOf9qMtHUjmGkOxAwvZojbB9ASEfZr93jdlwZZQAqdPqgDZFJYYdSjOk4NYmKFit5eD1XlQybwOXsaaxlw/taDyOjWlVMgrF20upwB6XdeNaXb9QlaNx8dg5pDsiJFMhRvI80Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 14:39:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 14:39:13 +0000
Date: Tue, 29 Apr 2025 15:39:07 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Roger Melton <rmelton@cisco.com>
CC: <vladimir.medvedkin@intel.com>, <anatoly.burakov@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v4] net/ixgbe: support Rx/Tx burst mode info
Message-ID: <aBDki1j22AU1IuK4@bricha3-mobl1.ger.corp.intel.com>
References: <20250416172310.82448-1-rmelton@cisco.com>
 <20250428212921.3674799-1-rmelton@cisco.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250428212921.3674799-1-rmelton@cisco.com>
X-ClientProxiedBy: DB3PR06CA0021.eurprd06.prod.outlook.com (2603:10a6:8:1::34)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a8a14a-e2f1-4288-7d0f-08dd872b9c0d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lEq2+cmrQPXlA1yOLY0JThL+Ee7yrhyOQ0A9ZiBoJ50m4SMe/046+YIzBMcW?=
 =?us-ascii?Q?pLPg+Zrj/KYSRKyHnmzTILOrt+tr320h5sx6Zx53W3U0TgcSVY1tibnOrIgo?=
 =?us-ascii?Q?EjAvQQO2t1wIj5G+gaSqwk04EA7XacIQbId0hcFob9Bu3PY+Nfp7p+odzIJo?=
 =?us-ascii?Q?ai6ZdFhTOcUS018XFwwMG1yxIewmp3GSAzjL1Isxdy+AqfBw7xWs+6yaI8M/?=
 =?us-ascii?Q?XAnKNFfJHe5W9+nLEWA2IYsmxYdUWhLCKxn3s+HMJgB9ZNsBjsN60fX175rA?=
 =?us-ascii?Q?GcsfDORCHHiHBEFm0Hk80kUoO7LSEcjET2ZnXXqywqnDyM2RYURetM3Dxs/t?=
 =?us-ascii?Q?kyFRVCR02e1FsRIHr9aJ0dmH22YbB0Au4zaqjsb8g9BYoAWmMu1CaT4LsWIi?=
 =?us-ascii?Q?ymzeiW0IkRISZdI8vVUzk2rVVI/LQTlebWCFUHRwzxuNeQybBK6l7A9KllXh?=
 =?us-ascii?Q?bh7qv0oya+JnLYdrEHYAnLtb/lAqU9XHcdw/j+OHbkkabW6UOEmcfWwVEIlB?=
 =?us-ascii?Q?0Dsd4PqLNXPOKHZuQl0cnQlc15gW4bldRhJJLiB6hQQgOhTwFpQCPfYOnXsn?=
 =?us-ascii?Q?ybtEPnFKmrbr5JUjjbQRjCZJeVj62q2si1uY8s7PT87nSPqr0OtuW3CSxfCR?=
 =?us-ascii?Q?pCHBrcZoqHG/0SXkoReIEyK/vnK8W3UbmEyCuurG9MPjb7G1Yt0P1HijHxCE?=
 =?us-ascii?Q?ohSwsKCl8aClNQ4EzGgHvErdIbCyPvX68t2u+ggYnSOYQJlWqtZlsqUbatH7?=
 =?us-ascii?Q?D1nn7JP1QInHE6gJQ3g24aYjFJ4IXMVJ/+QTKTyTQDraUC0PJrK7wJ2npS2j?=
 =?us-ascii?Q?rIz77Vf3Q/JvvwoZX53My/Z+1PA91RFhGDYmMC0v8nfCTXxXpt0/Q2ZjlKlO?=
 =?us-ascii?Q?Gu33AZjfLmtm7S+vQ9q9qqWwx/yzcAqDpbPM4AlK3bG7cKtN9dlpvcMbaUtZ?=
 =?us-ascii?Q?c48yCTmQPMnjIgneksn8BD2e5sMRq/ARF5tno/ATg149c0HtNnlYr+xXB/j8?=
 =?us-ascii?Q?nk4zoUivvAJ2WwNbWRl9T6qLy+b69rhmu+1OcbHvdcUlrtxvc7lIJ28nV3L3?=
 =?us-ascii?Q?otwsiPdLYPNZPLqMQok9NHV9+CCbLe15gAHXUeq3xAYVc0XbhwtzGQ+d3JNd?=
 =?us-ascii?Q?+dUP2zALhUoMR770qEg+BxTea8W53qnmFDjQzQdjsxQGEWRt1CgVBOwpNYnd?=
 =?us-ascii?Q?+Um7v/6df1YTVpkIwntqQYFV08dkOuK8tladBimReIJ138q74fJlyHmrtw3a?=
 =?us-ascii?Q?BxGVlBuemvBmDclUlDTuLpkFydxQk793Sc7FwBo8SKQSxIcyvcSlx9HaagQ0?=
 =?us-ascii?Q?H9uPD59Vuhcog4WYAvRETQydQaN0AVeAUWAWVXr8+G5jWipQzsz0Xy009qcY?=
 =?us-ascii?Q?HAwZBGwMf23cSMgCT9DuHgn93Ye3PtgaNGrQPziJSFfYyy9L7w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v/9vNeghGi2wYleYiCDOagCECefuhFN/GQGooVgjg+PpzG4czmwnjXRHRU3s?=
 =?us-ascii?Q?GL62VOSRwXj/Uecy2S0cGzbpbW45XFYOCayzdvrTfJyQD3jTjupXEdwo2TJ/?=
 =?us-ascii?Q?3hlvVL42lfCSVockCfXP8/O4c/Szsu+6lnPlOghEvIrIwA4sWiwMol/hqSE9?=
 =?us-ascii?Q?rwlKRfsXdefyiba2abA/FSBibCYgqBVce2AGZSpSzhTalT3f1r6YH0LAgEk6?=
 =?us-ascii?Q?pQ+ZUerkQp5b/aGJx9s0vN6vpwQVedlfKhJtfDLee1a/SjBT5rvSgfgjiJSX?=
 =?us-ascii?Q?9Oa2Lr/njbeYM6oC+HPFWBVt5u8x7oFv0irEfrphqfvwF2xvNssyIFRfCLrY?=
 =?us-ascii?Q?lGXwwbwpkvDq9vto4xuf2nxGu93wjrmAjri+FAhMdeB1aKbIAZMmSNsmNY1P?=
 =?us-ascii?Q?YNgfhDgYsmWRMb0/Spy7dt3tChBEIYSEAiLAD4V8jmrbHL28PolDBWVvfN0M?=
 =?us-ascii?Q?6cCd0HBoTBooQPrcjX/9nDhbHaDrJavlAs5lDFs9iv1OGR6X2WQFJtiHu8ww?=
 =?us-ascii?Q?3kKxLYne+oSc/sDliLZQNDQD63XyHSlTUx3HhIy+yDikjNM6zqd3nayJQcaf?=
 =?us-ascii?Q?GL0DLgn0oUTaTC2OdC06rkFDmIJFpy5Jgq0tx0G1h02dIfvRd3ImFLfG+yBb?=
 =?us-ascii?Q?SzKLmCznUU38OXulZLfYyYiHMriGLIWTr1T4pstb1g059DmwtQjeHtVz02AW?=
 =?us-ascii?Q?KFWaa2dvszLL87ih/TZm/S5YOSkLq0pRT0JvP5tuF4QwQuMQRHQI0tKJHcO5?=
 =?us-ascii?Q?BNlobf1qAkQ02EpW27oDe8NRGGQ1QbLhJAnFg9FUl6IbpuzCxyD4Re/3jqYC?=
 =?us-ascii?Q?s8fjipBJKJ60IK5Z4duriyr3HsSTLYdGC1eZ2wQaHs09ryQ1s+xuo/UNaoXt?=
 =?us-ascii?Q?/7JIeLzFYTOASGXeIfOvA9wfszvuaZaBDuQsdM57lPeaS0hLuuYr6K6VvHoJ?=
 =?us-ascii?Q?YEgVLq2rncbqIBph5VWcK4k/1m9qe7Sre/M3xTRG+n/RpTcUJtPm7Fd25Wi5?=
 =?us-ascii?Q?d52ys1NLpGEaj3xv2nBTWE5VJUCuKkI+NBTClJVuFaEjj1SoMMH7+ZjJnoHk?=
 =?us-ascii?Q?MfB8GYmI/9+JFmaT9UrGFQUzwlMSc/9Gb4J2KKR3kvIol6daTE0xQdNB/aWn?=
 =?us-ascii?Q?8JRVCJbJKVefgDdQYY1ljMxe5ubMJdYTGTLgnvr3Wrncct0TQA+vWCotXFAj?=
 =?us-ascii?Q?+SeZ/hnZ5hNZZCT6fZWcgNDM/XOqgS/rW0isv7RsPKLJKENyA/7Q1ClHvxR4?=
 =?us-ascii?Q?x95DAJhkLqUpCFxMm8ZPsVnjOs2aqJtRCJeG5CVa1+YahOGOdidKuXLsdd80?=
 =?us-ascii?Q?J8QKIUqRg2rB+uyE4a5YcUIsdo0DeF2NRsNQNMmC0NYTr1enk+875AV17Hm8?=
 =?us-ascii?Q?Mxd3yg3oAi1f3vQRtRoHZHvEoNqTCzrgwyRLwcLOn7CxrVhhtmiCKgXERfaR?=
 =?us-ascii?Q?s/1uQllReoe01sGKY8uj4TMP7hx8ckH/EPRHUXFHwq82aGStpcum3+CiG/iw?=
 =?us-ascii?Q?8FZnUnFHl9mudNS9meNWRLVzWqzgZRWC49ZBYwcXYtnQl2I1gkOWZ1zt0y7q?=
 =?us-ascii?Q?+DB78kxoXtD1HpYJCAaULcmSxJM0ACA5vjovvDzsA/XIliyBMea/NKAO9JrY?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a8a14a-e2f1-4288-7d0f-08dd872b9c0d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 14:39:12.9647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WgFoppT9As61v5h7oiTUu/lMh8fxtK9YEdVcbyWwTm6KFu6nooDWDRbEcRQlJJTSP27YmGMAC8iTNfDslgAyVoIoFsCdBeCjJvgWgOPNNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5013
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

On Mon, Apr 28, 2025 at 05:29:22PM -0400, Roger Melton wrote:
> Return burst mode according to the selected Rx/Tx burst
> function name.
> Update 25.07 release notes with this information.
> 
> Signed-off-by: Roger Melton <rmelton@cisco.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce

