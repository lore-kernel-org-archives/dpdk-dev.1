Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7BACA0EF5
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 08:00:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D5E7402C9;
	Tue, 19 Aug 2025 10:00:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0A84A402C9
 for <dev@dpdk.org>; Tue, 19 Aug 2025 10:00:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755590414; x=1787126414;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4J83rEbvGix3rghhgs4BPpbno72KihGndbPlB4o1Oqc=;
 b=nKa84zWcA7evptpux4T8zOSnG9f69eUci8w6C9FAO4A5+lywRwfqGsMh
 Eb1zmzHfwOOMof8H2kpZD27SGxui9W57EJLuiSif0V8HxO/Z7O3mycmAn
 /v8Z7UdJSMJwZcaJzsIvpwXmOl6O25NCE19JEqcHpf7PBet2CL51qMG3U
 KQrOPijomS+efPsQtrgQUtmw+DNFHtZIJ7c0VHs2dP05IwG4GltTbrrj0
 70DzNippU3CGqsAqiIvc7cGIMB6kfcNIz5B77o0CPt8xi4X9/yyP8qAqo
 44uznGMfNrageWNX9oiSGpigMiibEa64ENQZ+K4CTjvfmd+XNGUpNXt/f g==;
X-CSE-ConnectionGUID: VOfkBtUCQPegOaSGXSpFDw==
X-CSE-MsgGUID: xp32Kv48QgqE8wUtXXdn8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="68091420"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="68091420"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 01:00:12 -0700
X-CSE-ConnectionGUID: eCNzvbyPQsenRqvQAt01lw==
X-CSE-MsgGUID: rW9IpIm7QtqUbexooGJ/rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="167688309"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 01:00:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 01:00:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 01:00:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.71)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 01:00:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldc0MqI/JfRE2wvniXK5UrElJyANl0wUIYJFaa5FyawAUflniWxkDSIazv3Hx8glSFVKmO2QY64GYHW4v1ScL9M+wxlRYi1RQ7+gy/KEKggFCFGQ3+9UnkY5KWqZOhZ23x0+AU4XTps+DPgnoPvGrbTwH2u3GphjjDxAQn64BE4p5HtKOkN+5pQ67lf9pWf6B6/ZVKmwzUW1MNRRXkPJatH6Uq8tyHsWFz8eLpr5mjWerjV1zEixYMCgjbDis5OT7MbXH8Tg4wgBQFjP6U7WnYIEFE8Csz5AGKhBmYRwnnB7iRUiREVz7R1T01QN5grLQElQFNifLHkFHgJITWirMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QY3T2D6K854rOd2nEEkGW+Zjnb1GBwOlk3bgkj5hBQ8=;
 b=guJZuTP2pl1e/FEvF9BqSVHXW4ausEDQj9SEJ1VjsOgmW6DP1etLa5957AjfNJyLBa2If3tzOTq9R0vPCaQXAzKCvjVEX3snezNnD/BGhnc80L20P4y6ldr9/+8++8bJpFAFzIcMjUEc0knpMnF1pLn0jtVjIS3EZuQNZoIEeLXFsflheeBDalO2+LbQTM6Boif4GVSJoKRkM9rww0/Fo6EngkI9Ahjfo6E/D1XlauKlk7zW/mgTooflxontAg56o9tQ8O7mvH8bfjthzXacBPsrC9CxXmw/gKg191AD+26haqAhvMu641wXooKGzFrsfOTlza/0ZCORJ1tlajZ6Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7842.namprd11.prod.outlook.com (2603:10b6:610:128::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Tue, 19 Aug
 2025 08:00:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 08:00:09 +0000
Date: Tue, 19 Aug 2025 09:00:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [RFC 01/47] eal: add BSD version of queue.h
Message-ID: <aKQvBa_ZYxjpf_Xn@bricha3-mobl1.ger.corp.intel.com>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250818233102.180207-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250818233102.180207-2-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 2965bbed-7cff-4f22-2bac-08dddef66ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sUb/N63Wx2MBtwxqqmccfhMXMQ8JYvZGlU5Ox+wi4n99yJuuFEh00pB0EuNC?=
 =?us-ascii?Q?L2tsurhUpg9gUF0/6eLUoAyO89y2rirsYIBwpMCnw4C0pedK4wmjCq2M5EgJ?=
 =?us-ascii?Q?IRlW3CxDFteeJcpTUGglwqz8C4GEpyqQ0owUK/us0pAIJ+fwP/9oU7+CtBnK?=
 =?us-ascii?Q?X3OUP5oTQDJ/AcZZMzG4myFW+3aXGC+c3jRnYsTZ2KXtPdjrbjozsoD7b/Vf?=
 =?us-ascii?Q?JnRpM2m65Vxvg1G2JiY9zkTxu9y0daPD0IxhBlMbTgahBlLFz+WPOiDFwH+9?=
 =?us-ascii?Q?B9Y2XPySK5Zvjzxn1XY/Dk/jzXl7by3Ei4awdQ3MzgaMlY6uZ/FYXG8W7kRv?=
 =?us-ascii?Q?aXQupXq7b73WPxY2jzLgfWQCMBQnXdC+efl7m9QDu4bWIJ/l4TTD4YWT9ci4?=
 =?us-ascii?Q?BzXPu8AC/kY5PmmP/HCvOyIcOpo1SYHtPF8VQPgZ+euIHE+LPY1uYnK2tTrJ?=
 =?us-ascii?Q?pOWhHcfnlc7N/24kx0OW1kR6zpam6/ixtfXST9/xSfzlzrF3OvFrdXN7x3BL?=
 =?us-ascii?Q?SdA5gGTsQrp5IT72M761l87/7yrYPP3ipxS9Q7MGa21cvefLM8GP6nEsOJIB?=
 =?us-ascii?Q?sFQJHpwiACojqBhRLKqj39JSX5cFypGGHTo3MPKKd1BQStFn1z2xpikTOrnu?=
 =?us-ascii?Q?XUUU3/k//cBR3L0ljhplELdt22K3ZZRs7JNw3GkiEl+O8UYL6Qn/7l7DclqY?=
 =?us-ascii?Q?wM21XM2dUj44YybFnaj2On+7vd4Bm2MmQM4Ana1cmrWa9Uz/YWQS+pBzGyvO?=
 =?us-ascii?Q?EWdzVqFz18yNkNU7vmBDY7N7VTja9N01LF+vHx2FLmtJ38bQ67FfVTCmXsn7?=
 =?us-ascii?Q?kPIW1zO1B4UFSWhoJZQaJK6yDP2ZlOpiu9I+7AsSgQXVOq4ZviWu7MwVJz0/?=
 =?us-ascii?Q?E9IM0iytaQjU909VT7SFpsy+9zZaIf2vXWmMvZHRgpAS3kuS7NhcJvP2iSjq?=
 =?us-ascii?Q?85fAvLccwzlurTRqGmrlI36hl2tably3KSnpy8dnZmyjPHEfxu6A9GFHlU4P?=
 =?us-ascii?Q?X7LycLt5TSHH9YBOY8LP+2ez/myMI5+82ycec+56rTiP291IYPJsq5cNRrcv?=
 =?us-ascii?Q?HBGtsrooNMs0cR7You6+OrKmAJmZkMiqFicuXtKvCGl47NwT3Rubs49famMm?=
 =?us-ascii?Q?T7YEfmU+FpEpsG895CHBvz/PKIs9Pfn/IdEJl0oxf0q509RGTlNxZVogT+bd?=
 =?us-ascii?Q?Grq5mKit/qFZmfm1KFIXV/itzhQ+/ijmS/S6h00RLfAO2rrUOHZESDjxMFKH?=
 =?us-ascii?Q?7HgdG5TF21svdturWjkTSaqwcLFpEzxr5pjTzlky7AL5Tr6ORxz8jcvQ3EkN?=
 =?us-ascii?Q?NTrtg5W+ENqKPp0YcGdeYZUMGEHYB2QVfSZ9ofhmGrz8EtsQlzql+thEkfwL?=
 =?us-ascii?Q?KWbIfxhgl5GCN5+Vlw3wOXcNfqN6JzWiOm34kghMgH9Jsc6ewtVA2OOQn7Vp?=
 =?us-ascii?Q?RGdDwAT9w/8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y/FYASJguaMwfr64xwUH6AM7e8Ezwg67DM082JTf+Pr1VJ3+m6+l4lUbo9OB?=
 =?us-ascii?Q?5GzZRTOAZIL2YIowUKLuZdovXCKqcFMqeSuv895MZGWcWN7H4u721Wj7w4Fo?=
 =?us-ascii?Q?tvsEP7RRouDflmxiedtgq1XT5n1gWbmoRD9yAGfWxiiQIZR2BrKXn8/lmjPQ?=
 =?us-ascii?Q?fWTsMRPdxfeOmq8i5Vy5qiajlQnwu2peKzpjKnLZG0X9LNq5mUGSLCTYazy2?=
 =?us-ascii?Q?xUWreuO+x8mwd1tmjMZwqAp8ANdDd31tXVIexY+grxw3fSuNlb7Ee1n3G/vU?=
 =?us-ascii?Q?KxQ5stCGIseTBuWIr1bAb7jFhAJOAw3z4RM9UmdvfGN9eSadW1vBAfEWuFFN?=
 =?us-ascii?Q?AgVQuz6eYapDRMC6WLjEXFGXe+ES/ffFz8kEfsBIZNlu13nIgpox/JHuIYJg?=
 =?us-ascii?Q?WYWkplvItHGZ+4PCm5aYQeE58fD1Us9cHBUe9DSoXSIVwKPvz2VrZu5nsACo?=
 =?us-ascii?Q?0GM0+UrbwoKach70ngqWHkj8NFfJ+OJcckftjBCiOQWVu/p2clKb+WM+LbYj?=
 =?us-ascii?Q?UK7eGT74+Mde+bRW8I9uMN7pO7ygu9YQ3+e8ugEhdvDgVb3MonJD5y2ESYrU?=
 =?us-ascii?Q?p/KXyvki76pe+ttU+BVF9asqKdtKkTyPW7FPYdPPKEVo/Ax/lJFGqIZetk1J?=
 =?us-ascii?Q?42WmtgcZlY+Sn6Qel2m2lyr4rd5qnwdW3PfgXxVHcZWnyI28++ZdOd/fJJxw?=
 =?us-ascii?Q?z11TsZHZirDP2S/3Nr9lzCzKhz4lJtXGhNoYotvd9PT6XMFxwHb0KneacXTM?=
 =?us-ascii?Q?toUMdUMLfXpVkALex/+6JOkpPSNmsyPHSgzoyhfHqkWsz+zKp4L8YVCehubl?=
 =?us-ascii?Q?ZZAuQ8LhXEkTbgOWJQv+GAAG/OrhSnaUCxRHacoynI9/UHZroP9V/ylut3OU?=
 =?us-ascii?Q?MFw8DjkzXyoG7k9sct+YUKjL7D9TW34zYe62l79GSE18XbdWSAUnTqs8Ceo3?=
 =?us-ascii?Q?kJgKb7EwmgSOPwQTesn6k3OdMjYD9YEM+xwjgRBhpOu0scKiijFBWblt6UBK?=
 =?us-ascii?Q?FZ9+kmFblPqxCxhJXyLR8XMPgYf2SWdbbxpNLWralqVqsgMIwGBZmUsj13FR?=
 =?us-ascii?Q?DjR7KgI/iCkT94+LaOT0loRqw/7pmah+PJs0epaEBnDj+aUOJN21BoiEWOKx?=
 =?us-ascii?Q?xR+0Jio+85jb/DrKnFlH9gxfN2uomAQ4gLCraoSadLPh8Cn2Cp1tw1WF8TAM?=
 =?us-ascii?Q?Xla3P0/XAq+Or95Oijs+RtFPCGZ2KTzREGe7mgltv5H50Xt1QxJ5+V65Bk1/?=
 =?us-ascii?Q?dwixZe+P3xIhZd/aWZ/1gN8M6F9AMnpwlXjs9SSW1V3E0CyP7JKS4R8xvifu?=
 =?us-ascii?Q?FJItgAPIE3/XuOZvIt6vRej/dmV8g9mjG2rO3mAqHTFIpdDeMx31YoVFPhGy?=
 =?us-ascii?Q?xooCNpy3Ye6ruzGXJkfQ9xbBxxTR91kpss6GictHwxjjpcXXVNuS7m5hFQul?=
 =?us-ascii?Q?uFVSEnMo2qclpTvHnDhXmv+q5vBnq6X9/r81g5t3EU/nM/J0hR7id/c8n7VL?=
 =?us-ascii?Q?hpStQbTNlUqDi2NF+YRMhjpqkpJjEL/cT9PEVmu47d+dU8LIKdzVOA59cZWp?=
 =?us-ascii?Q?0dRzyOig6nmHZT2zR3M6qR61LYkYdPA9ajSEx4cyXSth4Yz4i3GrIk6SDCVF?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2965bbed-7cff-4f22-2bac-08dddef66ad3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 08:00:09.4712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jDfXWIpDnsVAL4ZQN8NECcW8QcHR6xffpXBKjIX+2+Mc0vb/5cwpiYvq2idyqSKS1m1yPPHftVy0ThN6HF1Lc4H2RTXWJzTCNyG7rGPNaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7842
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

On Mon, Aug 18, 2025 at 04:27:12PM -0700, Stephen Hemminger wrote:
> The version of sys/queue.h on Linux from glibc was derived
> from an older version of BSD and is missing several key macros
> such as LIST_FOREACH_SAFE. This leads to drivers re-implementing
> the macros (sometimes badly) and other bugs.
> 
> Introduce a version of queue.h derived from the current FreeBSD
> header (only comments changed).
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/eal/include/bsd_queue.h | 1075 +++++++++++++++++++++++++++++++++++
>  lib/eal/include/meson.build |    1 +
>  2 files changed, 1076 insertions(+)
>  create mode 100644 lib/eal/include/bsd_queue.h
> 

<snip>

> diff --git a/lib/eal/include/meson.build b/lib/eal/include/meson.build
> index d903577caa..c10b2f09e0 100644
> --- a/lib/eal/include/meson.build
> +++ b/lib/eal/include/meson.build
> @@ -4,6 +4,7 @@
>  includes += include_directories('.')
>  
>  headers += files(
> +        'bsd_queue.h',
>          'rte_alarm.h',
>          'rte_bitmap.h',
>          'rte_bitops.h',
> -- 

While I agree that bsd_queue is a good name for this file, since it's
exported by DPDK, I would tend to think that it should still have the
rte_prefix on it to avoid any naming conflicts. Therefore, I'd rather it be
called "rte_bsd_queue.h".

/Bruce
