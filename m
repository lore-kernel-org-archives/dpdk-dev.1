Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D79CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 14:30:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B51C402EB;
	Mon,  5 Oct 2026 16:30:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id E02484029D
 for <dev@dpdk.org>; Mon,  5 Oct 2026 16:30:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791210643; x=1822746643;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=8tBKOr7zH+6jRK17pFxoy/L0cK9gUb2hG5WFUoYHay8=;
 b=Rz6z+mJAZjsiLz0w9ATgogE5GTUBvvYfeQvORUhPN4GSbQsOUGzIHzho
 GUJ6NsTrqNnxFy5sJgHrjEQURMrUmED+Yv6StFXVIV2vj/L5UfFuxUVgl
 r4+qSYuOaJoV1hN6FU/UKFesYKKJ+M5ssU3zDZ5HC5ewLKeB+bcvbe78I
 uLD5iwcUttrHvmslRi5Mwg+0ja0iQVG73chZYM6aNgU3lxnw5lhWFOFSs
 SikONAkvn01D53RTuNE0e/K1hKM95qtvWoFbu3rS+BxAXVSehSPrtE7zH
 Vjyn5CuhcgGsSS/ePQrWV3/3/Y18A+7LZ/LrBNvgQIuA2O4fzukfPnArN Q==;
X-CSE-ConnectionGUID: UZyUVD6LQRWwyXJRFNXF8w==
X-CSE-MsgGUID: i/r9PJUhTsqsJYdTa5C3Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="94593025"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="94593025"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 07:30:41 -0700
X-CSE-ConnectionGUID: m7nA6ggLRXK4bRI13Hsgcw==
X-CSE-MsgGUID: N0S0tmb3QrO2ta5MqthfMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="60695"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 07:30:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 07:30:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 07:30:39 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 07:30:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSCPGtynQ/i9P2yRTBM+90/imWk9vt6ugR4UmKdhwYwcjuvVQJFULr3NpDF+UuPjrbAzZxAsnS7hV0uORlFRFdD7iq8asB/JeNVp7IHfNcNtXXO9U9Bv0xoFhZa3o0S6k+q7wVSIj7ha0PF5fCDPL8cGTWnL71vcKd5l+rt369y0cz15fItK291r34O+0yNrdEGlsZt4T8p+eIbMaZ/Nn/SNuf/PwBvs/ObY6f216o6URRU/Z4J6/Dl6nS/+2aDb4i/U3BD4M9doUi1QFcgQaCN+ZpwQtdIbKuT2MIaIAnFMfbH/DRTtgdw3wFkqzgFEZjRZSSAV3mztnc26WwdDLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JWIHUEATpkEKFPFlrAh5EBbpLMGbjsvcWUTTlIjp5w=;
 b=nusg//vVP20e6qynOStDiq/ZpT3j9X5uWNaTSvSKe2FMBF13zucczGmvPTo24YnDpwwAhrf647bha85kmhMlXfRht65MEvTFZtAc6Hw8F0xBqkEx6ROB761RNVeB//ItiF6zCIxkt8Z9Ln/QqN4wPA89LCc5psoYRELQyq7kca3GlV2LgSR1yB4zIT3/tbMmG3BliQIgXqt3oZwzEzn9lBe0NX+SuZ0EN1rK0gVnKf3YrZJRTAYyR6G+FgJXGNWAz49bHljczJv0lSu0GIa3Hyc5DO8Ol63++3165PT+vLW2P7CJHhv+vbRGtCk3RzUuLI5zCZg9XJ3N5fcdxkp7+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM4PR11MB6068.namprd11.prod.outlook.com (2603:10b6:8:64::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.18; Mon, 5 Oct 2026 14:30:32 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Mon, 5 Oct 2026
 14:30:32 +0000
Date: Mon, 5 Oct 2026 15:30:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Adrian Schollmeyer <a.schollmeyer@syseleven.de>, <dev@dpdk.org>
Subject: Re: [PATCH] build: fix cross compilation to x86_64
Message-ID: <asO0gl6hB1s2MMtV@bricha3-mobl1.ger.corp.intel.com>
References: <20261005125943.678879-1-a.schollmeyer@syseleven.de>
 <98CBD80474FA8B44BF855DF32C47DC35F65A97@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65A97@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7PR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::14) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM4PR11MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: a5fb5f64-090f-46c9-fbbc-08df22ed35ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|3023799007|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 42BhudLICUl1Py9UOGSxDqcTicR3cnNTxwNRyNMtJdG6tR6Ow3TosLqU6r7thZiJbUBjACN/nIpCEz6JFeUyu0c9x0xE+k2xGmeaEkIATp4sZrN3L96dDaFfND8V5PjsH9IXZHwuAvGRUlcLFgSYyRPUtibHdZIsqtFhyDMK/Zy+juusDXjYyqQf2ZBkRF+Tv/1aJMj0RnBNpa2vZDhTgWF6BShhAN8VQ0e3M1PypLLuPU4ezrgwtH+kjSzZPuWezpKEI5vE1HaBphKy6a6f0H+sRjr3WqK3+Iq+laLRGW+3etSeKxAnUIlSk5aL6PMi/6lyhwGkGSQ6FH8o0i4PTpxqkDx+dA5AbgTBiAej9TR3kScIYNusGW4bqAQHbDC1VSfKM17SR8jWDCJxhqxigw/NdHSIMMiM693BV0v8qCsIgRc99EQj95b5wO7X48ob6bPKglChWGs5QCVyWQss+pJM/FG/hhSRtVGgvlCX136RlrEqvMrwFr/zsc8qok5gqpBUhKrpKf/SKjTFpjTB/3RTzj4O0j3f1xHvEFNsv7udlY1sRqZpSymc661QHQVamkLQhjbg+88Evc1i8ohoBlU5snPjMDnsuBKDSxfrVio=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(3023799007)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?7FSG9LSBLSAhKHeK4310fipjfosBoEYyiYLRXvmtbZVhQPsfwrJM1qShf1?=
 =?iso-8859-1?Q?i65uQ4A7vxFi5g8r0Wi2Z680fRXwtlT0iUXJEQ40ikiduhYcX4275AGxrO?=
 =?iso-8859-1?Q?QX5j+kt7uZEpJlvcZtUWJq4+rptNOqlfJus+f01YhQw8mNTfKS5B3mjlXO?=
 =?iso-8859-1?Q?z/k//2i0ZZIgULMxRDNTefl94zh3/1IBqtH4zjxUE4qoxDT8Z4THPYi+t+?=
 =?iso-8859-1?Q?S4w2Xj1CuIjcs+w+vjm1mwOOxk7FWX5aBdbFJ6ghSwH1mlPFOycIjbB/kZ?=
 =?iso-8859-1?Q?Xz94+kUPi7PzPlTh1Srp3G1qnj9LFbux5UIZSnCRF2MTgwybh+jMtAEbOy?=
 =?iso-8859-1?Q?a0qYOSUkGbpbBdtaTpbp6tiw4yzC68rk6hCCuENCAkQUZE1IGrPbWvkdd2?=
 =?iso-8859-1?Q?SBn5WgFv+OF3Iz5dLzwYjanoXOck2t7Rp4I2/MznPiM3KKU7IlQrUYIWai?=
 =?iso-8859-1?Q?s/yR1RG9C/aet8slBlF4fcFNLtjbsHO2I7ssDxReMmjiyQeGBVzUnPzrdw?=
 =?iso-8859-1?Q?DO1GDu1nQKy6da1xMg/JYo9IGfYEKLgF4/VryN+pO5dyjfIswuQwfua79y?=
 =?iso-8859-1?Q?B4uZc41Y5lTUjYaw6rezF4pki8Sjai6Gz5BVrTu9DOQ4zwdMUorbUpz3dl?=
 =?iso-8859-1?Q?rfY9J8PEs5wlgbb5is7D/ZqHdYP8C+u+LOBqTzWAdMYuCglahDQvXVHUSm?=
 =?iso-8859-1?Q?k2RNeDQyjOWGRPrJ1nzT4juSJvXWiSyhAS0jRk/LpUR2r10S95YPEEvlKM?=
 =?iso-8859-1?Q?Bcw7clupuJExMhq9+vPsjvZQYQG1R5cH+265MxNsAvgQJFExEoRQYh9IJe?=
 =?iso-8859-1?Q?RDoonlhQjs48/hWnOvIHK6VIFeDej5jXnL9a5IoQcV3NQiUkNCvBPUeDPb?=
 =?iso-8859-1?Q?niZ8TH30JeMhBLVw0T3oLVB7ofUqf0VO9GyI9BPvHgvV3uS9gpW/f7dmOq?=
 =?iso-8859-1?Q?3FWw7ttBSUigoCazm73Y59LeDfkvV0m0rckBbBy5xal4UHnABO7xfx3GTi?=
 =?iso-8859-1?Q?B6BAwWe8gw0SG32FLBxdPrbIiK1bAALUUowA6vlUMcWrwWg3c573YUY3ku?=
 =?iso-8859-1?Q?lN8ACauxB+caGttzMIHsgXlQczbliO2acx32S+bK6LegpkoEoQHtPX5e9C?=
 =?iso-8859-1?Q?OXm4IqHYQ2ZuX6aJ7i8HA8iuB/I96WvHF5FYso0sVjnwwktusyHRTF3xSU?=
 =?iso-8859-1?Q?wA38HjwizvjGuwpUdIfTC3lTOa8WMbM0JWwmV8NPObFEAMoU6AGB7hnLgz?=
 =?iso-8859-1?Q?RKHrjT08C72Es5VAfF9coOGj7uf+JcaMekd16airftqrWY43M3ZU1QBlXc?=
 =?iso-8859-1?Q?j6PlCeLbaGLzk+2xoU+NrkaiFqlXsCMbi0jeTRI8NP1XAwSup8beizKawL?=
 =?iso-8859-1?Q?IxfEprZU90bZKtykSzcH/8LypaK0eJXqUjlYcgIWk1jgwjl3baW3PtBcd/?=
 =?iso-8859-1?Q?+4gp3j/YP5+D6GI/xG6pKgGrsi2+Kn9t4EnNPHINiy/wbgOqBO6cQpdV3f?=
 =?iso-8859-1?Q?eHLK2Xu+Ujdn/fa2N9mrcb/lB63zD7LoqQShXlbwXdY38XyfTGITwNIt4y?=
 =?iso-8859-1?Q?ccakNhJhovdvDcX9qoR6I26TpAetQ4uRCIRTZ2EoxiqifUTTXsXCTUxwVx?=
 =?iso-8859-1?Q?skHPSIKJ52n78ytRXrZTIp58pn30oF3H2Gd1ThP5Z9RARrlK16DsNcrHxh?=
 =?iso-8859-1?Q?o0RgGEFV0rQk0rIlSqWM4/wFnnojfThPOZngaHj1eKtGZXX15EX3pqm/1R?=
 =?iso-8859-1?Q?Xs3efgDV/gBp2yxHQFWo/1rcIfl5uE7n666gXEXtcOpW6RcvhTYHSMQAfc?=
 =?iso-8859-1?Q?xgRfOspvWxd32c0tkVTRVjXtZXDVNoc=3D?=
X-Exchange-RoutingPolicyChecked: nbgVxfyobte9cphJyrzFgeeMAFA8yw507fw98FypOJt/dihsp1wEwpd43URZF7gkH8ymGvuijpoHPSKJyao/8213cMlyJeCn8n7eensVV4QqvILFO5gwfWnhISESRbcpaYvehzUKuu2wwhS/hlHy4UH9Fkuu5coDEpOTvpKPA6qXafv1J6PS5YajSb7TQlgqAx/zCAIVtroWUiXt6NDlIRzt0fLNtprQ+D6UvCm2awyaZgsrvV6DU0RkoBOV/ETCHUkIt0cAfSfkm/TVk5kGm/m27U2VxLN1jb/iVxYql25m+utSDhq9AEh1Lp5wkX60+aw/jDGHpbtHz5vVm+r2nw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fb5f64-090f-46c9-fbbc-08df22ed35ea
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 14:30:32.1129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8yIFy56tyGIN6ZCv2HTv1cokIOcipMctNupyha+P60tUo5f2Y7CHHbnvhf59eIRLZG2gc8/n6b5CRZNfD2Tk6lUXgCSF0JrraOOtJ+b8eE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6068
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

On Mon, Oct 05, 2026 at 03:14:17PM +0200, Morten Brørup wrote:
> > If x86_64 is specified as target CPU instruction set (e.g. when
> > cross-compiling *to* x86_64), the cpu_instruction_set may be set to
> > x86_64, e.g. if it is derived from a Meson crossfile. However, while
> > Meson uses "x86_64" as name for the x86_64 architecture, compiler
> > options accept only "x86-64".
> > 
> > Introduce a conditional for handling this special case by changing
> > cpu_instruction_set to the march-compatible value.
> > 
> > Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
> > ---
> >  config/meson.build | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/config/meson.build b/config/meson.build
> > index dcb84ebd13..238d6cae0c 100644
> > --- a/config/meson.build
> > +++ b/config/meson.build
> > @@ -177,6 +177,11 @@ if not is_ms_compiler
> >          machine_args += '-mtune=' + cpu_instruction_set
> >          compiler_arch_support = cc.has_argument('-mcpu=' +
> > cpu_instruction_set)
> >      else
> > +        # Meson uses x86_64, but compilers expect x86-64.
> > +        # See https://mesonbuild.com/Reference-tables.html#cpu-
> > families
> > +        if cpu_instruction_set == 'x86_64'
> > +            cpu_instruction_set = 'x86-64'
> 
> Not sure, but maybe: 'x86-64-v2'?
> 
> Ref:
> https://www.phoronix.com/news/GCC-11-x86-64-Feature-Levels
> 
Yes, probably best to use that. We require SSE4 as a minimum instruction
set for DPDK build.

/Bruce
