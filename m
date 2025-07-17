Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E01BC83F1B
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 09:52:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 897DC4013F;
	Thu, 17 Jul 2025 11:52:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 146A1400EF;
 Thu, 17 Jul 2025 11:52:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752745934; x=1784281934;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RW0nhssYt2vyJ0EyP3HW9U3sKUWd1KcrjFw1AC7+H2w=;
 b=fpwAUETymeCeG5p70f8oO1ZzNgQTEXFp3Jc6L3IrgAmFROw/NzwPAyg2
 mNc4xp7GV/vOzcT5QyzfBoAMbsc7t2kN5Q9Vdxr1w55tELX1YBfqT8Vvk
 kSCmVecXgeEvnOsgui2nyR+9uZZPAzKdpHn13rWcvnuJqJgyVFVNZQKCY
 TRE9Ab6dLy252yKBsKB10FmOhwGiaL0h9VdlIqcPbxLzt7deAh9GFujf1
 Z2hPFdrLcjuQN6qok853ip1rReskbvyd/JS7S80lERuQ1YoJp/Fwy+yGr
 Z1dDfpW2reKx/tHB0ozAListdovNL8FqNwtMODrYcxkIeRBF26HLcAh70 A==;
X-CSE-ConnectionGUID: dG9s2SXRSt6me6SaqfMHnA==
X-CSE-MsgGUID: Az0tbFdIS62WHLg4aAYMUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="80462035"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="80462035"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 02:52:13 -0700
X-CSE-ConnectionGUID: u2DiPAXLTACUIZgKHi3zHg==
X-CSE-MsgGUID: 2RF3KvrZToSZiK3ygL2RGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="158458771"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 02:52:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 02:52:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 02:52:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.85)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 02:52:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSGejGkV/VS++c/mfi0PmcTqBfU+GG/CQZ1IUmL3y1sGnR57SeodGiNm/FbpGrCmRlSG0vQ9EAPOOu/lEGUcYAUCcjKepOrED5GGO2+naHVyASYyM6iXEjL9/1aDr86dHb6q7k2K/7brr/a1En9DAeWsZNuqpY7Z0/rur3IsOcw3jvohrJ67RXd/G//dJfUP55YQHk8RF+zVuyAa3Yw+v6TE4/ePcufHms8XHAj0MFnBU6GGKBfYaO9Oo0RKw8RGo1AkjUFVrxHAu3CCbOP66VMUe4oHQVicznuG0Q9f/iR/7KxXBnW2sx6aXFYgK8C/Vo+8z0mCkjNOJ228PzOwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6SkMBaBJPUJ7b4JblQcOhv2pOWMEwIwKzf8OS9pySw=;
 b=npghv5u5ejnveDZKc/YhS7VzxTmHDOqmenvy5rfm01tm9LDweuuOGXneoJVvh+J/ijJbWWHzyQxoCytreyBrkccshmibRu2dIeRRQtEcWVV9bOOc3emnGraMzmNDA47/eZEQ6K+RPdckZ+k39ovL6uHyeuHQBO8XyobO8V9WBXczHb+AW7aY8srrDYc9XrLg3NzfSkaaFN2ym7ngEJq3dO+geas2FTvhTylqaQIvRt7IrIHZuiua9Jze8qRY8zy5+AFO7IeOjpei6YBBHaC5A4PzPZoibVqT43CExNHDnwNJZqjBmLXvTMN8YLJovhV+/ofiKVBy8bmKURNhvWUxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB6562.namprd11.prod.outlook.com (2603:10b6:510:1c1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:51:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 09:51:40 +0000
Date: Thu, 17 Jul 2025 10:51:34 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stable@dpdk.org>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Harry van Haaren <harry.van.haaren@intel.com>
Subject: Re: [PATCH] eal: add description of service corelist in usage
Message-ID: <aHjHpmnnifLtCXta@bricha3-mobl1.ger.corp.intel.com>
References: <20250717094232.2184783-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250717094232.2184783-1-david.marchand@redhat.com>
X-ClientProxiedBy: LO4P123CA0054.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: a7fd47b9-7bba-4849-aa1a-08ddc517874a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gzRM3H4WrINRJyCuYfOWJ3ZboTnUEbfj18wtw5NjYFZxGH/3EF0WnI0UZ1kb?=
 =?us-ascii?Q?RgAvI3AnmZMF0NUir9ZNgVf4p3kZ1E656Vi4iSBsyz1hdU0nhujp/CLWJGCy?=
 =?us-ascii?Q?S9k9Cy5THdExxFnUVogol3hfR6tCcRQQXySbMg3l6jy0bXo2jOHCjw56TTGa?=
 =?us-ascii?Q?TPYXkQefWk1s2Gaykj0TKY/GdHohRN6Qlug2ASzjXnfTqkyLqpAQuM4fH7hx?=
 =?us-ascii?Q?wrpMjI1e0hr3/+9jmtthbQvn6DERXEPaBJ14xTrO6Qbwew2O0TDZU5503cE7?=
 =?us-ascii?Q?R0jae0aTk/WtqN+ZHPRDXcnh9NNLeicW56emWmDU4H3YWvbOj3VCZVFlknyl?=
 =?us-ascii?Q?P4/rgBF3qQEzQ1N7OMpqE2op615qsauU46rE7A670X6oXo5Iqf38Pcx3Bb9y?=
 =?us-ascii?Q?NXEBfN+cW3cNcEtUJs959zjegqICxQWSQeli6YOHaWPiywoQvHw1lSPGaXL0?=
 =?us-ascii?Q?iBb+TrnNB0QC6lQIHwPIwZ/IuHVUU0whdHHyCos1bN6MYQwsy+O9ki9Exz+X?=
 =?us-ascii?Q?DYuiPmueMluytOus7x1RKsBndVIR+mVVIoDlskE11oMWaW3JGHPGlehOiTH9?=
 =?us-ascii?Q?Zcms23AnveWJ1rGjr+HzL8VCFtMKDz708+QlXl2Lx4k2Mbnohm+Y00sU2nqG?=
 =?us-ascii?Q?j7Nw9e/o56Q5bIRQJgAd9yVZRUKPyZovONK/3WE1ZrCZj7qLUdWu+bj+giHw?=
 =?us-ascii?Q?BqeSF57sRKkiPf+vWKH3EnZxrnV46YKoBe3rWl3SxV0Wr9vLz3HWpyAQQCr/?=
 =?us-ascii?Q?ii6zeOB0Rkdpz4MbOY505APGSDt46Uig1erA5g1b6Sfv7gUcZZv+yENmk0/T?=
 =?us-ascii?Q?OijSkaQJxx5oJsKUGTNLV7yC2FHF2kvfusbJT0V5p4FkNmrowF8VhTjEFx8y?=
 =?us-ascii?Q?pZAbqjvJrabTb2i401P1tVjXC+vc51Ro9HnLmX/LCZHRaEUKpDCrjFcRXwsv?=
 =?us-ascii?Q?QPXceLIlkaXwImsGFp78GFAav7V+nWLOVdJ9ZstdRUMtFhcmAO9KL3z+LvfU?=
 =?us-ascii?Q?VQcPt3hZu47mrx2f7bysBsLrB7BbNjZRXZqsD6jtMb8mlEuR0fYgyBlSfPT4?=
 =?us-ascii?Q?GNib8JMln1dmDjf8k43ocqOqSMJJeXKxx2t0246vs22p7gHJVPfBv7I7ac7I?=
 =?us-ascii?Q?mtndETtCjaL7zpM3VYN/WQzXkWKZFPLuJj88Rt+w4GXLoc+9XEHp9IOI7tMF?=
 =?us-ascii?Q?p2x0HjLDnhVw/om5E02MOb8od4R+Smbro7uy6tULtUuM0e/PqNC8PZyJoQV1?=
 =?us-ascii?Q?JMs8nrmEPMfcrDL3R8NeAN8ZaBA7nOITcz0EiIWnf8NSaqo0ChFkMGPvT3NG?=
 =?us-ascii?Q?AtJTVZE2FlJkin4/8G3tsJmV4lRPk6JN6BSy4fS/isMmhcrsrn7xjNF0IwlB?=
 =?us-ascii?Q?5AR/dts4amZxNhw2SsNoWLc65lmNGlfHGN22ZY25hJ6psm24qkzKbNkOSYZ2?=
 =?us-ascii?Q?sC28dy07y2M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pEPphd3qDF0rErTRsS1kV42oHgPb63qzZL9cCN+MAFs/uPhWJSFHkvnuglYb?=
 =?us-ascii?Q?YNWvXfZauHHZyd46mKUNa8lSmP5QZSbYn6SE/+NGE5IeW2EI/Thp3EC5p7tF?=
 =?us-ascii?Q?A369rIDWz9Tx6/7mXI2EX4Dme7RMyhSSbiq6a5uScCttmjNbXxes7u1/ipnJ?=
 =?us-ascii?Q?nJBu1v/4DVocsJxmdr07qvYme5WKuTUxM2+ea0GX7hxLfQ2HN6eQNeEHmjYV?=
 =?us-ascii?Q?ZWeT68YXCvLSjk/XUgf8BNPh83WOPkJ77+lV4vSDQkneshuYkrEoSXKsLMxC?=
 =?us-ascii?Q?e8R7DueMCLpbyfPLmznOsMJmSCaKkb+T/u1urwrEUnkSTa3HH+hoQbm0Gnhu?=
 =?us-ascii?Q?ZCICv+0ArJlVIUxNwHlqB9jn6IlsMlDPHxaSMJAiS5sYYFKJkNE/29R1v7CA?=
 =?us-ascii?Q?V/mY1r7WXhicICns1bTwmfGTv1MRgFIVwGxYk1LZ11GHpG8nCdO2Y6cTaBJP?=
 =?us-ascii?Q?o9GxRNiJ3eRlD9MTkjqOmtoqgvfseWT3NjaX0MQeAzS35A5Ienc6Ry3BbDfh?=
 =?us-ascii?Q?GEBzOnLDxPFoId6ya2h7Ql708wVDUXP8U4WnZp4ZtDO/whZXAcJgWRIB+leq?=
 =?us-ascii?Q?dwpQ6Ja9JZ9D/GgNgf+9ur45l15qddE9TxIz2Uf3i6WOMF3s3LJ4kyYj+UcH?=
 =?us-ascii?Q?JwVSIURxfR3PzowOhSvOb/DFcFV1F1asALCtnZNpCAttFYCesX9azM81w/fy?=
 =?us-ascii?Q?HI692I1aDLSqhrJalfcrXvwNVNnfQ3BAG241zj+pXiqCKlXHYIbuB2H6R6FT?=
 =?us-ascii?Q?2oNs59+skW6Kz7BBAyfyq23P0AbjmwtkqCvT187kpNK9aQLiOBbVarH0BW1q?=
 =?us-ascii?Q?jinPT+eAbau6mXOGQkw+8P2TtWiMkLMJwN7dAi6psM3IwUsYm5Jsueru38tP?=
 =?us-ascii?Q?v5etQ/DjH5+HycGxe9d9sLALvZ161hVT5DPwZa9WLYTKyX0G877DMLXOY2Lg?=
 =?us-ascii?Q?Xbb12Lb9cMpTGGhCqyYwAsJl0+2quRvyYMrrcy37ZaaaE5J1ALTafgLXXgpV?=
 =?us-ascii?Q?F/QybOjvmHUTTbktio1g5QCbTShHtX6oJJWiAnp+BM7V8kRfuMIZJF25A82K?=
 =?us-ascii?Q?Q0dJHWQyO57/Z77nyz1NjXeCBlU2Xtgf+pyWPXegGQaJLjUgc0CWoP5NByqS?=
 =?us-ascii?Q?43pQ8PxVt+wEOwZYBA6DoALaLRSy4E80Trfo/s+eQb7d2T2CsOwCqA+rAA9y?=
 =?us-ascii?Q?rlLXgNxvspdopqbSV8vl1a+hpfBjwsSB0th+RuM5SYv75gdY4KG76BiYnd7F?=
 =?us-ascii?Q?z+tnOxqhi9ygo49V9l2d3GeLUbhhROOa10isZ5/PvMByaLN+tELHsAdW418b?=
 =?us-ascii?Q?+9N8pdl7qdNbE47GcSPk+KqEQpPXXjLgSxH+gfmgbTZ2ICCC4AqDQKj98Zcz?=
 =?us-ascii?Q?N6Rv4/Q2CaBGseFTBAw5bWN/RvqvelWElpgZr2njEpcSS8bdIjjZmflB/kSJ?=
 =?us-ascii?Q?mNuN0WnayMiP/Rf0TO2a/17N8WUEAewg7qdbJdtY9Nd8UARbhwID+MRtSQ6x?=
 =?us-ascii?Q?afyWmk9IfHoIOMAfNlRhiw0eP8PDqwsoievzQsz/WIqHvDJtvTZdUoMCVwOY?=
 =?us-ascii?Q?TDhppnt5WJ1xi0jS70o5F/lkEZv4+AU4LQjD34VIFx5UwqvXah7TsWaPf1jx?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fd47b9-7bba-4849-aa1a-08ddc517874a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 09:51:40.2705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujc1MP1ZuEFb23AxoZLLrRU+TXBPFXUoB+71wxDBxWt9SKO1iHlDaxTtEpri1PDk4f5cglWwphmQtqWaxs4fRmghZVmkUL9CnCaFkkoSLO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6562
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

On Thu, Jul 17, 2025 at 11:42:32AM +0200, David Marchand wrote:
> The -S option is not described in EAL usage().
> 
> Fixes: 7dbd7a6413ef ("service: add -S corelist option")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  lib/eal/common/eal_common_options.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
> index f0a9ddeeb7..3169dd069f 100644
> --- a/lib/eal/common/eal_common_options.c
> +++ b/lib/eal/common/eal_common_options.c
> @@ -2127,6 +2127,7 @@ eal_common_usage(void)
>  	       "                      '( )' can be omitted for single element group,\n"
>  	       "                      '@' can be omitted if cpus and lcores have the same value\n"
>  	       "  -s SERVICE COREMASK Hexadecimal bitmask of cores to be used as service cores\n"
> +	       "  -S SERVICE CORELIST List of cores to run services on\n"
>  	       "  --"OPT_MAIN_LCORE" ID     Core ID that is used as main\n"
>  	       "  --"OPT_MBUF_POOL_OPS_NAME" Pool ops name for mbuf to use\n"
>  	       "  -n CHANNELS         Number of memory channels\n"
> -- 
> 2.50.0
> 
