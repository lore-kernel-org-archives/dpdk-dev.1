Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B366BC61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 10:40:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAA99402D8;
	Thu,  3 Sep 2026 12:40:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id B9AE94028D
 for <dev@dpdk.org>; Thu,  3 Sep 2026 12:40:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788432047; x=1819968047;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vczdXiAjaaCpBVdJ3NlwizwQ+6LBMagiwO/wT+E1nC8=;
 b=Zl3f1Db3zKqk4ApUD/WkzlFTtid2KrbnrJJTuDrNeq+fZFINt7dywtlJ
 ZVlDLJ4+0Pb0VeIrUYYMrZlJzenCj6Dwwi9S59LnCEuUbOK4+dYsUv0xP
 QpkngY1ztCD3+jj1Uxc/tCpKWJ1PoQTY4etKKHkQp3krgiOpmHSg4aQrL
 461LprS8vwDEyZENPXAX+uJoSyX5DLB01/Xpm8DJbQtCb+wkhT47ByAV9
 AZGpaJlicICGsrFSDlnrkYmQoNmbcDiw3FrwL37SJ9oGIa8aDiij9WF3d
 UzpLKgG8WZifMi0ztDd94S8tuZtU7BGAMid3SGwIz8cQxmOL2SyQsKP// g==;
X-CSE-ConnectionGUID: T4bIKU5sTPuUDood0kTTbA==
X-CSE-MsgGUID: DHk5aTmbS76+ehN9Wo+pPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="114455922"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="114455922"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:40:46 -0700
X-CSE-ConnectionGUID: L36Mk/PbS2+8X3Pc7rkGPg==
X-CSE-MsgGUID: R7LdVzvGRsCHYlE0JL3Ybw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="273438706"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:40:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:40:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 03:40:45 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.34) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:40:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Igh5WoRaJvzJtiiVk7h9DZKR+XR4dJavQ87GX9+gy06b52litAVQuZWl9+48W1lzMRzFMGbdtLb/oPTR5XT1WIoJxbv9DwW10+BetovDDMaG812T/vJpQwg3Lvxwn9ZgNOM5X+4SJwutSLr3WtD2xMBzbJuIOJLhW3FewyOTEfAzalqdyOFeWDFnatjZBgO9fP50m9krH2JewF0R2cDqg2IqwEJiET72Hr+kL0tBCXPnT2yJ+QLH6CRkDUadLULPFiJGBM3qYcT3lRV6IvtR7URA8SdYb0n4DHwn1qBtQqGVaPiDfjk0QLq9/h4X0IHxeegpvUna5V7PCNO7s5D22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SynxxP+toGHsXZdsZJxuKf+uGXOC4CHfJC9NhTVs+vc=;
 b=X5MZlnSHiV2MuKKBk22jgtGdM3otkrMCmhDbLBvZAS3WWew2McdozD/U8XWADVjoORst3S+WPDDHhRkO4CYRgE4uh/Lq8/xv7wc4oLw920TqugcR+Z5zlYktt+S0OFNZRcHjFjekX+9UMD/y6GAiOwcoKxCc8lrsLVqZLT5btnvP1GMk4HMephdrAkMHD0FvDGUqqNiwFIo8+zhMOzkWI4KvtahcO6uJYvrh8GKNhyA4QAmfukJFi9R4k04/GCgELzQ0S0eKbZkrJ4Q6rV5H0p2TcopJtjkIAuTVhgm3U+BUbalXmsmTNbHztmYebsDiAFJiMxtUyXI474ifriTxVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by MW4PR11MB7053.namprd11.prod.outlook.com (2603:10b6:303:221::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:40:37 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:40:37 +0000
Date: Thu, 3 Sep 2026 11:40:33 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, "Nithin
 Dabilpuram" <ndabilpuram@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v4 17/23] examples: include network headers
Message-ID: <aplOoQRwjPSnQHf7@bricha3-mobl1.ger.corp.intel.com>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
 <20260806051004.166778-18-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260806051004.166778-18-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0276.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::25) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|MW4PR11MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: f39f7ed8-21fe-4ccd-a088-08df09a7ca98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|3023799007|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Bu3/r6zLd9Ps9yCk72esyWPx1Vq87GlWQ4F/v2JbeM3VC5XNIZuB/oZfQ47I66dXdoIbLalvQF0QW5cRcbyzQg0qH56ddRy4+P2a2JOB/N20jP5Qkbc7F4z+xVVQFsVUpY2PYL3P/5vHbrJz8TjsftmqSPRo0VkI7DanpY5YVOLKjVY6SdgEIcQkgL1qaHjKqaLJSTl/TT4JiZioZXo66ufkdKj/i8ugWipneVE6Zu/WzI47nf3ylIaYMoaySPm74jSQy0qoioGM60SonrtKxfo7/FrlDNtFHw/krhoqGaAcvuvp99MeXtpad0bJ8KhYBcZr9ZQFFQGW8oUxE9nbT4fICs6CQ95Ih47qDnQWGI7PUpuPeW4zVl91osz49cPp/e0UePB3qCcvsBV8Fe6eHTGfRnGxwAOrlsGSCPuPj146F/l6xPAaBxlbJjci8sDjxOrxXEp43d/czRfdDDgb78FiKH2/cRoIlBGM6sjkw/ZJBE7chwU2QfxDNtycw1nm/DI4KKwMdGj1UGnBBKXCH76pqg6jGZaWt22Is3RLm68XPYNsPNMnxwkr13dY7rhfnAcnwDTXdY6x1wHbKM0PnNgizP/rCh3VWJoICDi4QO6+uVGCKj/lXXF19JN+aE+5mU6Aa05FRJs2QqgG1bDahYfTL3nGH0NZNywg2Y/7ZPw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(3023799007)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aJjirnrkIcw2ajF4B3yZW6lfYPxupLJRKYyohmejpBHUUcsitpgaKTruIplJ?=
 =?us-ascii?Q?AJKkb9C9B3mlCr0Wvi3ICj4uQcT/1zNtdnSNqCX3eI4Y6wCwpjAYM3e9af4R?=
 =?us-ascii?Q?nwzfkbaBGaO+i46lBYI9zA/rnwMMca3yPXf/B1y4UBGdoM83yBS+SWTGB1vM?=
 =?us-ascii?Q?uRKKRE+9yTH6TPRdYFFvDSydD/hzTKgZIq+tkWsLoOXeQ/5SCLF/3K31B/yC?=
 =?us-ascii?Q?Q9+OAe77YzixfRRC0Ec0txTaunYgVTI99nhMbslWuNrNlX/wwm01/4G5YP1q?=
 =?us-ascii?Q?v33PR/ounfaLs5vKAUIEXezEDe0W8RB+oim3pBvgek5oTSksALGSA8btwQvr?=
 =?us-ascii?Q?95oThMtTHiFRI679p37IRW+WUvvu24ahkqZDKiFOEWRqD7txgbSX3kI61dXa?=
 =?us-ascii?Q?K5gadx+Oy1VSeBLDHTgojgk1gcjJCmGJMIkQPWdsusS19NP3BakTih/D6ntt?=
 =?us-ascii?Q?GO9U2qiIVicTVxsXDKVb9z3Oy4dI5NnPIGm5KLv3+IvbMWqKSLdBKkxPjTTF?=
 =?us-ascii?Q?K4B8VsSQ4ib1ALjZ5iWXUvy78/PtmA+Y6G/vCfVLWibNDwWkEFenUwahXb3F?=
 =?us-ascii?Q?3mzyBxiaHiQyCdugltEMTfieygnNRQ/L7bnq36y095wYFcwjMbDNgwoKQkw/?=
 =?us-ascii?Q?QeGknWGSq/MHuknQbMmlDV7NyTDx8gUE5hXckBtvioBoxcIXSPYtyIQ2PCpc?=
 =?us-ascii?Q?dS5QshnltY9oPOfrRxdYu/ul8MP1m5SbrUiVy//qmpZzJeuVU/LioUnfp9LN?=
 =?us-ascii?Q?caWXXqVL7OxTg6GkVT3Dk2ID4WMOLp6dY4j3NmpkMsurpGePEf46vg2VngMm?=
 =?us-ascii?Q?dmfel5iTh6xjDBpg1/8fp9ZCiRfRnalGWTm0uOqczUseGU3gkilC2Si5XIc9?=
 =?us-ascii?Q?EejGHv74xWnubUaP1vq6qWlT01jGqMnqQ2IetiyhZhVn86An1j68i99rAbzg?=
 =?us-ascii?Q?8HoBkgoB4H+2n9v8XZDCEej3sciZkzEt7jPvrbVmiJ/Eau97O7n9LhJhA+2W?=
 =?us-ascii?Q?DFspUudlLYe+sTp1MVmdXFv319EAwGkL2V+RVITqO2smXhmEpiS1fQZO3qFe?=
 =?us-ascii?Q?WKkyKsbwr/XzM+L46SQP3Jl2QnL1zvBkyrZnSy3NjcZ+1NgeWKIYla4bjZ46?=
 =?us-ascii?Q?LNQpXcIiUoqn9wYcTtWf2MZt1r48BGENWa57xlt3lig+zsZE0ktWCJpSbUOp?=
 =?us-ascii?Q?kOsId5XUQqbtfBXJpwKLtszY895f/LzCdYt8gvW1tGVcNGboVrJJrAhy3ibr?=
 =?us-ascii?Q?C/hvMgtUl2pF9B67A21eEdqQEyPXStBC0HMlrjP7fkRaCQgVcMDKqwEMyrek?=
 =?us-ascii?Q?RJIX+SlGdFQlWh9bReNq83xj6KFDI9l2YFg8o9JDlrq6rdFyZS2hB0+KHT4d?=
 =?us-ascii?Q?vs8b2y6T++DPjsOwvU6XOk/iy8qG4dXqcE8ZEQn701Xm1y0RX7Zv9klJ8GE7?=
 =?us-ascii?Q?j3gIrxFek7iE63w4X0rjKIjrSarUCFXdXVOlEjrdOJseWAQC0qgftwi5MDaI?=
 =?us-ascii?Q?/xh5H7Zom9m3XZeCXKhHp6/SDcJAgb8VJ54dO3UVGCeyDlyThveLVj+Q0cc4?=
 =?us-ascii?Q?mY9WrNAHNnOQHq0k0p3rZfjLCZgOWAqzZLpoA3vKze/bLWi0O6WGMIgNLw0V?=
 =?us-ascii?Q?zB4FvVo3anf6chNeC0cgPngMCrz0H6Tl+hud7bpZuhzXLQpyw9ZvLIn0wqSO?=
 =?us-ascii?Q?SYhzywLrvpsslYgKGfXVIEpZmF99YArWpUTsYFwLIxSYJH79NWc643N+t1ru?=
 =?us-ascii?Q?TOX0SqM8gGKyzQ6VcB2ObPAtecm7Dxo=3D?=
X-Exchange-RoutingPolicyChecked: 2I68z34HnPl6YXdcemFwuJ+TVMVgS8duNJQhkHltMSrNTJcUGAKDV69XWN2ftrkErwUnQXCFriBRmUd3W/3TN+u1SZ4k+bqPe0x26G8vltgnVot5ajH1OYSwrMA3J9Zr5H3OqG1F3V6o2vMWabVhxJZMi9Gke8JmY2Mrw7Uaz0PJDDUkX1Io/FrjhJPZyY7+R6z1BIokiV3bdUmKelf/0C8RFGbiGVCJIp0Hkq9biYZ+E5TR+/lAZgOzRM5OW3nEBzBY1rw1fAkkBht5Zzj85Hk6v9i63IdEJdnOnXcA0hmqgctegEF5jjSMTPsv15DmJb0V32N6WT/ts+zXj2xQfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f39f7ed8-21fe-4ccd-a088-08df09a7ca98
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 10:40:37.5060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAYWmoLbdizCs73deCZYQUg9RKq40lyoIoxNUbeqRw+2vtjNTf3tRjiAkQsoWGBtj+fe69liY0KJ3Xi2Lt20o5gTHFNjAYJX6BwmUsrrksE=
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

On Wed, Aug 05, 2026 at 10:09:11PM -0700, Stephen Hemminger wrote:
> Don't depend on network protocol headers getting indirectly
> included via rte_ethdev.h.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  examples/l2fwd-macsec/main.c | 2 ++
>  examples/l3fwd-graph/main.c  | 1 +
>  examples/l3fwd/l3fwd.h       | 2 ++
>  3 files changed, 5 insertions(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
