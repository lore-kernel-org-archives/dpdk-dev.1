Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E13FC54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 16:54:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 787C3402A0;
	Tue, 27 May 2025 18:54:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 65E4A4028D
 for <dev@dpdk.org>; Tue, 27 May 2025 18:54:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748364857; x=1779900857;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=q/zva3j0AzYCu1kxJPpje2aZhcN+msedsWAqz6mL2Dg=;
 b=C9Sp1GWOwDhCeqnWbh+9XYb46kzlpKAj7VUDx3xzaYYx4vm+nhxPHLEq
 zRQNnTmTikg20uQkBtRpL1vBajXcDuXKfnEiTO2RPA9Zb5RSZBz1W/FLm
 99/fMPYQiaOuVgSup2HhzG45Y6tU7cfaLnPfRRIwWhzX0E6FTIW7IxNDS
 5icMMQjVYSP1i2zKSMm0jv8iBuEQrmCsgaazBkwHtKT4UrHiZfZ3t5L5R
 jEkhMZkWxxlmgA3gbNUR0wZ+i/krVK4wuV6BjzL751GsdPfMrERarOc3g
 4nfpwjYtjDD7vBAhPVhNK6GJNkBRYWyCgV8nv5ZUGsTAG5oZT0+JXmvcx Q==;
X-CSE-ConnectionGUID: WDRTrvMBQAScVSNTCbfx2w==
X-CSE-MsgGUID: WN+V3n0uSYG2namXL8/usQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="61025991"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="61025991"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 09:54:16 -0700
X-CSE-ConnectionGUID: mavt/UnBQgqIf5q1prOacQ==
X-CSE-MsgGUID: OwNFdTanTAe3skQV1HnCWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="143864679"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 09:54:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 09:54:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 09:54:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.85) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 09:54:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQqPgAtgW7xcksu8QZoMylPCBb5TCqya6HB74JtpTn+MambMOAOI/LC1d7Axr9PT12oEdQ/K51EXZlOS31LADwgOXG+d07C/zHSJaabPMWN+vyLc/l299yrmr5wgA7fvBVzDisDRfkGwYzF3zgOL1NUQPxbMqOKXFoF9zKM6O9DTltdD8oyvld3I2/Ir/dHayQNN25bbghFwVPxXYHwC8OGhoPJEl7XjbFDao2F8QUke5i8ZpCc7ed9VCbUS9ukTkQucpPwkrE8YGIP7czb3KLWMG6JqrvN6zz/FbA5VYLls31KRpDK4vsCgxDxzbWd3xLzKwIAeWOr71L/tTndXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jF93+uxJyx1QqevW52vXbHkmYYJAiZLqnsSivHiabVY=;
 b=Tyi0usaSNJcHlFcjJFjUIiAJa2USf2AUmVPEqbvcj82CSHJpfjm56AoMwWqAJ8TOfxuyYHQwMizWMPdHqQjhugyMgDYQloZZ7cqx5904pPFakht+LTqjkU17dybKYpSpRAKdwKteRcYW/HsQB8du/98cjwTNSv9rfh/DP68jFI1RNBb36MIn8qdwatOBc62EJeFsDP0My1pDe9rFfUGEk8xFgbdlgP7Yz/z0FjMLW1CmsoXwqY/IF+Hhqpa+B+q/PwWMesJiPeNyVGPRjmfonEaocZdZGoZzfnXK5ZqKC4JHCgvZiJvV4qCkDcY5LO02bqwpJ6kA+uNBJ1saqPMA2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB8987.namprd11.prod.outlook.com (2603:10b6:208:574::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 27 May
 2025 16:54:12 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8746.030; Tue, 27 May 2025
 16:54:12 +0000
Date: Tue, 27 May 2025 17:54:07 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dhanya Pillai <dhanya.r.pillai@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 01/10] net/ice/base: fix type conversion
Message-ID: <aDXuLxx0vAAVFxoz@bricha3-mobl1.ger.corp.intel.com>
References: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
 <20250527131741.7606-2-dhanya.r.pillai@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250527131741.7606-2-dhanya.r.pillai@intel.com>
X-ClientProxiedBy: DU7P194CA0009.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdbcabe-9cbd-4da6-3a11-08dd9d3f1b7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?55CQsHiW9Zz6yRtddrJ8Mee1Iniv0Qpm72r/HQP5IsVDm+J0TYDC8czEqUgG?=
 =?us-ascii?Q?OxMCx3NiBo3l+S2ybmblV99aS3w0FdG3AMjI4fd0efgW9B69Gkl79Sp/VDs4?=
 =?us-ascii?Q?CgaHevITgCwr6NhN9DKwCd8lNCt6zfL8VU6hploGPADzD9+zwKGlJaxA9XnU?=
 =?us-ascii?Q?hxevHG/G5meCl6AULJf7q0gyzLg5uNgd/6JP4yepIeaGrPtnR3xTyBQ17IJK?=
 =?us-ascii?Q?ROZ4Hf3nyNZR+KXtQzvD6bfl4Z3itTM4i8jrXw1HHWA/qi+JjtHaEl4C6tvT?=
 =?us-ascii?Q?tMk/9/2mep4GtXVUP2Te8q8CCr/IC4nETW9Y/SMht8DF0Bb61AOwQALtzc4Q?=
 =?us-ascii?Q?hbljiS8yRQdTWmRTltr7v0eWoQHxDCtrVidEq1bUyFQkLjkAPn3B5c7gLqxx?=
 =?us-ascii?Q?kSNg4dsGYA2yqexc29uaAu8FLrvaE4Nt4u53KHEUYdbJ7+MGul327Xj0R8Gt?=
 =?us-ascii?Q?mVICFhbJOGTubh6EoSY5fAb7b/IYDPvDSr7VOsyjxxuZw7lQsa2IYsM5fqY9?=
 =?us-ascii?Q?E95/bhMD6+1XbZ4Z2tLggLqI7t1ormjh5iHV0lPaGX5JdNt3CfIVXs6Qt80n?=
 =?us-ascii?Q?z0oJ1oh0Nx2GOs9YmwbQmaIsdbPuzFlTNbXGJY0eBUeMeLjvTBp7eMrh6u+1?=
 =?us-ascii?Q?0BneWI0IeHrk5sxGOYmrWTCBhiPN3WmKN+Wg2VHjpFFmfkTt32TAzL8lnbCl?=
 =?us-ascii?Q?hKrmdNGvIzTBHLupXeiIQOM0F1knwBY+SPtoguOzM0n9oxOtCunyeo1ArvVv?=
 =?us-ascii?Q?jt3o/JN04XmNxtPE/qaxsXVuse4YyJ3Op05hZ3zVsaDWFZAyxAKZE4jh8rLU?=
 =?us-ascii?Q?WCB/LNM+QpR8N8sg7E9zAGD3SVVuylFX1DtNGmK+N6XAGgLI6WLXWDvbAtIl?=
 =?us-ascii?Q?7z/2Y0e6CiSauGR3RkB+6ZuxYALlIcapT2MurUS0Ehpx3YGfaBgya6jLWq1q?=
 =?us-ascii?Q?4JfOiouGJ3BdSxL5Bs9MAYrY0ZWkI9DRLIrE8VjJLJzeIaKW1atBitFbskfK?=
 =?us-ascii?Q?nWGOj8JtiS30MP8URjGd5a8hPU3lF37CHigexbAGiydff+kfJMAhb32R3Ye0?=
 =?us-ascii?Q?WK/C6SLxvgwDVsqmEBQmPfgy9LoRJBN82VXXfYjYCAcK9m8U9a1Qr1PT0PbX?=
 =?us-ascii?Q?DOPObH4zS29mCyLMYtvdxw2F651UThz0Z6x/XTw/3Jn8HJnkO9gzZo9RQ1ff?=
 =?us-ascii?Q?UNhZ9sj2aLfMVthjvkCb9r6n/Fi4amJOYPCz7up/mCoPad/R+apfc2a7cezL?=
 =?us-ascii?Q?qSFMBcMlHkLyNtDtOyJahyDU81PFLErsV+XtENlDRcXIzYh6Xye4m8HaTNYA?=
 =?us-ascii?Q?GOE/oOPLW0Uy5rb/XRhKD/1uIwWU/m/EUfP05RdDSa11eNQHjNOHYLlWSUOV?=
 =?us-ascii?Q?WzY4u0cltGUYsCJcr2SD8FiIiVrV/6fe3VDeHrP4yE2HWNF2qnlZ2z5w06/y?=
 =?us-ascii?Q?+CAzid3Ptx4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kGiX+6Tn14kZGOx1U3qbpWG8ts5nHDXHxK3EkGHPTTjPTmnHGFxtOyKrmwN/?=
 =?us-ascii?Q?lHuRYYSJocco4uBk2uFCCUHgF8+pTZXoycEfgFRacJlF+prDYjJ3tUC9SN/Y?=
 =?us-ascii?Q?aoxf1kAkRMF+fE8s+8ngcLaTnig8g6MHCupjcqtMmsDAftQLysXSbCsTKbbU?=
 =?us-ascii?Q?0mi0z44IS37GRwySNhYQYKKqod8s/j20JPhWH8Y44aIMnpeB2LMoOTg5KyFo?=
 =?us-ascii?Q?96AJD6yRm7S4pdf/889FupUARpDhDjbWhRbz0zkd+L+OzpLohPBN+ciie2R7?=
 =?us-ascii?Q?SH4eA1p8/KzBgHHm32VKAS4NIBG4Ej4BZFiutb6hBvefGqkcZxLEVgX4VMLg?=
 =?us-ascii?Q?ObBJCrpLlGwaBAyX4J4/d870LQbD8vmyg4WA3DRNZqIzaB+fJBpR8Hvz0hUc?=
 =?us-ascii?Q?L8voKOHwX78X3zL7A8BFtFb3Oz79NC/DvBp2SzhxLN1lGo0z/eLH97cs2nZw?=
 =?us-ascii?Q?L5AdEBjlR9CEnsOfHZpf7hiK/RRQ+NfYgHGROmL3OjADLV06FHONt2FAo5wL?=
 =?us-ascii?Q?AGw/w0AHdAQRU9omEIr2rFYkPxIctt26v1MKFFDYORoBy/DCFBX+C/z+JnDf?=
 =?us-ascii?Q?alI1UE8LDr05g+c6GDgmJ4YfI7tT92Lf/Lwlk02fYqjjb3MxOHRtGm7ysV6D?=
 =?us-ascii?Q?RV7UQiNQR1DJJthrSisDewG65ItzRwSG1ukhwJ1PQJCk4L3bFjhUqKB90lLk?=
 =?us-ascii?Q?HHCoBPuIen2n2l6ejNku3IWvc8qN0BCzkBaE0lrnmqq7jVsoP3PkDCqsEfsj?=
 =?us-ascii?Q?g4v+kXe0WeFULa2uNh+sSUjqCVrsjgnuBRjbmr4SxwSpuhrOZaAh+QOS3xDC?=
 =?us-ascii?Q?HsEDYSlLTjXZPT4C+nxk9BPHvlvy8+mwEmag8bE2cCuzKBILgzZGHOxdpxFK?=
 =?us-ascii?Q?8o9C+GZbqaqQLgqXrH93epVHzuWfePAIL9bqDDTtwrHiB0lC4ZX7nxHHklMg?=
 =?us-ascii?Q?qen/+5HDfjssRPuXSbAWpjBzCEZ5pqcuywuHKW+NQf6iZxqxGSTqeJK+wtt7?=
 =?us-ascii?Q?vkNdPp29UnYP8YdUmq5cWsxhpCI58buoSzbRmbkYBy1ofpnzyi8X94mZjY+H?=
 =?us-ascii?Q?UKg1B1gB/TqRor1oXEMiyX/xNlGX7VXY31yXVWpSCipzGK2JNReYS1Fe+UCO?=
 =?us-ascii?Q?ghY89IBD6hgP8Jp1gav3Ca8IwimTGQJ6hFVsA8MhAy+hXD9V8L7lAZD8mS3L?=
 =?us-ascii?Q?DBDXX1yd4YuPP1hojj6AQ/yjzS4jBr6tBEKI+ht/tvFEadvnwC1fgVhSQLLP?=
 =?us-ascii?Q?4h9LicGs2F16lx9j5fOvozumfz1dgwqI2D97RQzBZF1oLHjb2DijA81ZRLsc?=
 =?us-ascii?Q?qwdctiW51C/iDBjjpki20AIme+7npFMEVI60VH8wteFkMTdGnAkHIj6g1LHn?=
 =?us-ascii?Q?XHY2A6VawUodZTUQhkw9vEgCIXYKYo5VSgJH+NV9EwmOjaF0l/tbrrv17/7F?=
 =?us-ascii?Q?GTBNXanZDZbStja6HyrGUy/8NrSTWCcVmdWfmS3gAt4gnzBSx3TsCVNuDMJ6?=
 =?us-ascii?Q?NrkrRKyr9s/jTdqv+KK2tG4+7/ovK1+Ysnmc8qg+1IgF5X8R2PmcMJ8n3L7u?=
 =?us-ascii?Q?3iIsTotHSC2QjP8C3mA8vsf0waMqnXrHBwWwFRVHRQKG+fvbgWfaTgJbM/8z?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdbcabe-9cbd-4da6-3a11-08dd9d3f1b7c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 16:54:12.8065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fg34fL7BYKNf3oxpovcD+QOUm1oER+Iz68pb9I+yN9+tp/kMceUceX1ZHD+J7IcmMPkmo/8M/DnTnp5Z35nZeyiLXnDdo9wJqPFF/I5yxBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8987
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

On Tue, May 27, 2025 at 01:17:20PM +0000, Dhanya Pillai wrote:
> From: Waldemar Dworakowski <waldemar.dworakowski@intel.com>
> 
> In ice_sched_move_vsi_to_agg() int16 is used to pass 8 bit value
> what causes compiler warning:
> warning C4244: 'function' : conversion from 'UINT16' to 'UINT8',
> possible loss of data
> Changed variable type to avoid conversion
> 
> Fixes: 29a0c11489ef ("net/ice/base: clean code")

Actually, I think one of my changes broke it, since that was when the 'u8 i' was
changed to a u16.

Fixes: aff06930682c ("net/ice/base: remove 255 limit on sched child nodes")

> Cc: stable@dpdk.org
> Signed-off-by: Waldemar Dworakowski <waldemar.dworakowski@intel.com>
> Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
> ---

