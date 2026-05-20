Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC9BCD4F3D
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 14:53:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A91640608;
	Wed, 20 May 2026 16:53:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 05F434042F
 for <dev@dpdk.org>; Wed, 20 May 2026 16:53:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779288814; x=1810824814;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=3lVSk/Vol/YTpYNHBsFkO4lV+yckpnBhZZ857AL1s+k=;
 b=Tqp0w3FGVyANzI3trPdSWfJRH82fh1y+Dy6RPL5TK1d5W8w02s+2xeSk
 4LwaKYq3VLeCQgF/y3vy8coyeAIr3WTgSi40I+Azl1jh94OlLWWHtCK1N
 iRV/pdGSem6cUWmD4Dm9NMioUDPrMibl2Co+VMkOyAEELzT5i5qbQ60NR
 uQQEcGdEgWrv2Vp9XIlUk8iPOoy9hNKjZfFooNM5ZsFhqr3OnWsJ8lb1a
 XGSOpTW83l3ch8TmRyubc9aZAQWzFxn2p805kTlbzeLnMpIB36xgJsazL
 QmoCQ8YRNm/v22rqvp8kOT86PVavymBGptl8TXKKcm33n6rGqZ5PRLZt7 Q==;
X-CSE-ConnectionGUID: DKfLI+pSTT+TIxblW0EP8g==
X-CSE-MsgGUID: fvGqP5p/RGOqaBBSmiM7CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="67718988"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="67718988"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 07:53:33 -0700
X-CSE-ConnectionGUID: 1rQV8zBZTP65oyk/fuFmEg==
X-CSE-MsgGUID: Ap4jOl0QTv6GeRo4glbCAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="239204128"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 07:53:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 07:53:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 07:53:32 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 07:53:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EStgABWA7vpWaxaoLpbUt0gh8cc0uxbEHA49+N4uuoDLDNsQ3RLLEH12XxfH1QLww/NNzH5Ds1jh7aGIFf+UDiEo7FR58o3eM75agcZW6nnqBY0i2wd5dCbDLCzScGCzWwmz/PirPl4A7kuatyAYAyGhwpMFdK6H5JDZS//TW5z5DHvJUSaYtPXAiqsqZ2paJvHiQKcU2WpqsWuU16xymB0H2jXX8hSIsvoZ7FFbxLsklV7m7NbErf7cMrpULSHo8EwsI5Z5FJpbXozuJ9anR21rQ8VMkh0AbUuH4+QTCySpQag6PbCGPubjwFQPPZn6+7y7UMBRGbiDUNzjZxASMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taMuPuo08QIN3VIZZFIKdC1YzPESSEnj+DL5JU6rYSw=;
 b=Yte/5XICgFhMPW1iw7TkBxNPvQ2OHGRNvwv/NyrAvVLn06zTDc+lnAe+79kMczbcUUwUuUN8wkcIzTa3XeoPxMeJcoocnNwHAuM6GqidEw/oUOwwIzYAucBZIMKqEISAyUwt0Hl0czWpp+xZtBpkGl7ZSSKzLtSJrQF+O4GzURORqqty9edYZR+3QacZRbV6iKk3b3JN57hSmYRnL8P5zJs303wsZGcTQeYA4W5BK1i6QN78NUsqJq9QnDvCQOQXOV9G7lWmPT3y7/PsTA0TxLNEbTAbQn4BGMLaWJI+xbywLcyxUqZ+WPKcG4IVw5wd3D/sxAHFVqHXn25ZrC1S0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL4PR11MB8869.namprd11.prod.outlook.com (2603:10b6:208:5a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 14:53:29 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 14:53:29 +0000
Date: Wed, 20 May 2026 15:53:24 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
Subject: Re: [RFC PATCH 0/8] remove use of rte_memcpy from net/intel
Message-ID: <ag3K5IygXEb2QjCL@bricha3-mobl1.ger.corp.intel.com>
References: <20260519160823.1004973-1-bruce.richardson@intel.com>
 <20260519124332.5e68fd8f@phoenix.local>
 <ag1me_1XSByq3p9V@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65888@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65888@smartserver.smartshare.dk>
X-ClientProxiedBy: DU6P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL4PR11MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e801c1-3222-46b1-0a06-08deb67f8de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|6133799003|56012099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7ur0XGVtwGqkK0NWMLvChNoBBSq/jDeLGiU6I3iFcIYQuXXVIoCPCuQWaEjeqjlASZacnkl7JUBJLE+FqAyRRI2I39CNPDIRbJP4uqOZzh3cpI+OyAaDqZG8W+khka7UMC5o9hI5qrS4RSY1oWrRPPdHkxdfWzhf1SDq83im/uX1XnDH29zoG6AmnkXJAsRLoCjM/8V7NowL6a8DIt8dXPePoWi3L6XtSFYkh+FJi8iavyDQ29dp5rOvvIQ5RJuNHGuAnjFZSl1d0Nr95UoSkWJsAEIMHW9jNxGsprRqPKMh12g5TZU/bGNygo3NeNEw97amazdflwuJ8EGt8/LSd8tcdJyP2v0PRPm/Q1kRsWfZ5XIoI23pC/0I8ecYT2HhD3X3Jok3ltmKUXZ4fejr6tDgJS1SdA9rHkTmMLmcSj/yBlFuQW7RT65BpWebViBdJBaQZyag/bLUinwpS5FZSPvxky+A2WASWtQMDlpf/ITHCxSmfakXjJFMAuaCjDgdR2xefbVxqzj8UdHBQ5XzRgwPQ/Fxrv6NKDIAcOoIAZ73ckPsaGR3bfM+668ldYIqMrkrLE5R5V9FMlYRy3hhYW3vip7LMRda/zssG7RHKFt35BHAuLZF3tkwn3vnpdznlNJR5pHdTAfuQX3lUL1/jkbjhuQtRFxl3pZKx+FugWUaOtVvQ1IMHvqVbiMBJg5S
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(6133799003)(56012099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?pOPALDXf7hBQNo3/jlOLyBfEMa3rpvBol19yXn9NDcDirY2kzBjfHcnkdz?=
 =?iso-8859-1?Q?viKeJm2eqMTx7bdO++zoyKddDX1DUSVefIS8FvlDoXOe5lI731NEdtLbBa?=
 =?iso-8859-1?Q?jRsVS1fWdJcZrsN5u4OnL5gtbKxX2GaZz4uoaPn1VTTxCwHusB7aE+T6jx?=
 =?iso-8859-1?Q?FYzae9hmVxGWpLf4a/AQFAXDN1scgTPgTB/jIBcRPKz2eKwDf3bkX7Xjlq?=
 =?iso-8859-1?Q?EuRWSoXQINL0gEAyNC0iUPqgDh0gpcr5OfEDx/bBti/4nPp83UmPBBAvN9?=
 =?iso-8859-1?Q?GskArbm8BqNtznVcNhm2VvGOHnT6Lrj8dZzfztgzvbbeyczQSlVKLP4Yrq?=
 =?iso-8859-1?Q?tYt+Swkfz+CHGGCdVcXdIKWBI6QOwfBp/jVKQ6J+sKPRxIGYyTH1BaDQIW?=
 =?iso-8859-1?Q?GbIj2q3xu41ZO6fGRjGg13yockl987CmZrzyW6kSTvVUnZdUG2yG4dcRts?=
 =?iso-8859-1?Q?5Be8LUsIMG/MEYQrmUaYNVzOD5P7Ypmeypycg5BxtcZw2yYciWxYpMN0PY?=
 =?iso-8859-1?Q?A0NHwZxu0N+xXpIzVmQVXKI76RfaY1eGUcktEB3EQqikyjIKjnp1FCagum?=
 =?iso-8859-1?Q?3h4B162cjj5WHeHwJbeelO3NpB/VMptbIVoUaDH1mn56VfWeqNQBJfx02G?=
 =?iso-8859-1?Q?U+X8wrPihi32ZNEJ0QamHIems3vKILn+VSdffX869SjcFUYSsCwIjplfIt?=
 =?iso-8859-1?Q?VbR8qeV7TNvGMNNq1wq4/gIKxdQRIG6VFPBury52Pu9NhpH/IB/kG6DqZ0?=
 =?iso-8859-1?Q?+CnrRsPBlm11aAWDLj8jZvQ/1GfesA33LJuOhtJJFGnQwD1G2/G/1HG32V?=
 =?iso-8859-1?Q?lxSbmMxJxpNh6GYkYnOSEEMFo8HlaSZ7eqydrFDIGkVtXiNcUfz1SX/rbR?=
 =?iso-8859-1?Q?K5brk/C8bdvzLqt5iSBUjDV/IQNI5q9zSvzA1zG0dR+XJNYs3T6Jw6tq19?=
 =?iso-8859-1?Q?aLkycpup4UqZaBJlZnsApzOgt2Umth6dctS+ikzanCJcRnAdCooBgoemcS?=
 =?iso-8859-1?Q?Sm1TV05/XiLoN4vfv0e/vvMMnQ/T9TNfSxlA3CHqWJkxkP1/FwGvCzYHxx?=
 =?iso-8859-1?Q?OLRQSSw/1mNoDirY0J9Fg8g0lhXMhkAUAp6PHu7adxyWSPgzjiPxcgDNIB?=
 =?iso-8859-1?Q?JcQdMz84L5UnJaBj/TwXWmfwqZpT8s4kAsMMHKfA91jysyUp2vATvEfNc/?=
 =?iso-8859-1?Q?sE8YIYYtjxY7zp3aXPRoSw1GJWrrqMxcbhijcgOwfWzUF9WvEOWI57zO7J?=
 =?iso-8859-1?Q?hYfo2QtVIMiq6L+KrdlSdCgqJKqoXH8iJSY7yv+VbW1zjjhbOXYPAu70hr?=
 =?iso-8859-1?Q?YSq5Qzau0rWJyysYO5DHdSKboWiy8KyllYIMIeyfSVWbR8TVmnAbVghRmO?=
 =?iso-8859-1?Q?sDeakvzcvhp44lDoLwdqWO71+ThO4a7w16bSV8tBjfZUj/UN1VvUeEdFSe?=
 =?iso-8859-1?Q?HbTCfC9SP/v1UnJ1uMSxBBGYC2cxx14b4VRR8HUASFE+Jvd047cvjryaZY?=
 =?iso-8859-1?Q?tb5J+FFGaXV/OzyenLJ8nUMKb+KbZtSqxOfWQ8H+wUthqiTPIsQDwmBpSz?=
 =?iso-8859-1?Q?IY1aAavUntHzdgVNZ7DRgOnQa8LnL0nGYTASvYAthzud+vYCxNwSq7Yh+t?=
 =?iso-8859-1?Q?t9hm3gRLPR6r+SRltcbcD4zcTB8fJf8rXTsS/HB0suHzSnP852Iwv7eLDO?=
 =?iso-8859-1?Q?BshaGLQ5DTFGFxIgchj88DTQ710v9DHaXXkubzmGporuq8QjHusx1w7rLk?=
 =?iso-8859-1?Q?AZMlmXaAMswiSImrb99HWvH3tDnk9XQaF7f90rJ6/E+Fs8Lvc/mjvFc/Wx?=
 =?iso-8859-1?Q?W5A8/Z202fo6wJugO5fMVWuLIcnGtwQ=3D?=
X-Exchange-RoutingPolicyChecked: KkYz/6XoY97RcvZjF0c9vFPyNYEP7/kok44ZK5GyUwyvSfXKlO0uMfgJQcSlud0Zrm8TfzTQ0KQJSID+vVOwBIV4M9yRb/AyXlSV5Bdnqf7fiYqpKmlLQQrtFGMf58GsvpehuJqGlwTTjmSjqzTDm3p0+Gi6k8yE5g3jg8xFBXh4/ujwmcWpsQzodp7pupDt00CBa7W/5bPcKw1A8WpzhSXrwXcwcwGielzzmGn3jzWCn4f3cIt/T/bTaJGm6W/+3JQCFA+jX8gG4M7UVBlcHVhoQ/uASmyENN/KbL4Cv/5SC683tm1yAHDIzHhKLJ8WcQb4QIO34js5lUfbzzqR9w==
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e801c1-3222-46b1-0a06-08deb67f8de3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 14:53:29.2872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zm1sBw+qXs/+W0r9nmm5n6by2Y0IeVOGBpbXSCHf4IAaiLPEpyt+8TmivsPeRyRddxK+5E2f5dPX42OS3Wo1MMcz8atOkOWp4/VD5yAQGnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8869
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

On Wed, May 20, 2026 at 03:50:34PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Wednesday, 20 May 2026 09.45
> PATCH 0/8] remove use of rte_memcpy from net/intel
> > 
> > On Tue, May 19, 2026 at 12:43:32PM -0700, Stephen Hemminger wrote:
> > > On Tue, 19 May 2026 16:05:57 +0000
> > > Bruce Richardson <bruce.richardson@intel.com> wrote:
> > >
> > > > This RFC proposed to replace all instances of rte_memcpy in Intel
> > > > (and former-Intel) net drivers with just regular memcpy. This is
> > > > done on the basis that the memcpy use is not datapath, but is used
> > > > for flow configuration, virt-channel (to firmware or PF) messaging
> > > > and other control path functions.
> > >
> > > Makes sense. You might also want to look for where structure
> > > assignment can be used instead of memcpy. Keeping data types
> > > is a good thing.
> > 
> > Yes, it would be nice to use in places. However, it's not a mechanical
> > change so I've not taken the time to do the analysis. Just a quick set
> > of sed replacements for this RFC.
> 
> If you consider structure assignment, look out for fixed-size structures ending with field[1]; they are really (ill defined) flex-arrays.
> 

Yep, they were mentioned in a previous discussion on-list with Anatoly too.
Three is always more cleanup to be done! :-)
