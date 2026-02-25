Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD61FCEE8A
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 12:04:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DA764028F;
	Wed, 25 Feb 2026 13:04:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3EBF840288
 for <dev@dpdk.org>; Wed, 25 Feb 2026 13:04:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772021091; x=1803557091;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TW5PXV7HjB9g7R0FMYMMHLFijM0EBE9TLoEI/h9SYI4=;
 b=IaljA1+spHznsr+cZM1rkpbVxv14l++YlOEqAONRICOPvbNjU35pKMHe
 +zCC/axj4/olvO6EmjA17fDDq/roCiCFKeSMp/RnalZqaQlRw0Z1rqNRV
 1qBQgG9frmlTeVipi0CE2xJlJ1Ts1BcBkoyYNdOP5QUpdCS8JsDm8B9hX
 CuHfeIt0QC7axKqj1q8rAA+3GbOBz1LbI8LI3RNU2MC0Gn5tnLAvKTGw2
 fl9fLhHQXaKFohteDLivzBTaUIzI+EGZ5D7ukZAwzqCdp1xAHAL3tp7+N
 L6EQUzuj7Qch/Dp+3tHqaO38645y394CvrsKXKkm6wPPlnN29zom/3VVh g==;
X-CSE-ConnectionGUID: v65N52OGTQKUmGz0BjK0iA==
X-CSE-MsgGUID: JDvbACj2Rcy60KcBEln+uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="76663074"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="76663074"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 04:04:50 -0800
X-CSE-ConnectionGUID: 7Of45fn4QrKOjJUHWPJD7g==
X-CSE-MsgGUID: XWvD0HLYTgaZujyLDuh28w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="216100434"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 04:04:51 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 04:04:50 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 04:04:50 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 04:04:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAD2RT0qMJqjZbyC5C1GihkzUx2g2CxPcxuAWEr0goMPJmhIBIr9Val70k9KX7mvtdVZElvEejND2Z5HvsZMxSMJ3G62rwgd98jSWrr3Iyx5DIzbVugIlybvDyZ0yX8uLw9TC+kMn9dsjnTJxGL3EiCqcKlpEJhA/Fth32h3r1EQf9DEXjjYFD+Jjsu3vZMN2V+HNd0go0LhKwC0h18anuzS7KvwzWFw1CSsFuG/0efIYB5oRd7LeqYuvd85OuzMfscIEHyWnCUXxwzspV6C8VlFXFlOQ5KT4kjq2pBFY0s104VbhMgEj88YJI6EQKtPNVpD1tiG4r8h/sSSfEG0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXiwfzrZ9uBos5U41iYaRVC//El2zeOiZXtF+gNgfw4=;
 b=QWckxf7jT4EkQllEsdFheLoCWB0SkmWuOw2xyWASDYZwxm8wmSw2EnqA4lquHyNE4mtz39FuG5ROl5bh4fEQcruTunZQMoXropnzIZVMetlPxkxeUvIFLkHNLs4IqVk6qtKiWvJ/ttNFjPaEk2hfLAs4/zm3Op5BddXq6F1ExsKAdwW/G8sabWp2FzG+PUxg+mGjEYKibOieW5LZlNMRsqPuLWw+9J1E6yqY+5rK54QMlp2MqXICeCtCbGS8dx7B2pc/YfwfRzy0lj9X+roy+Vk/OYVQJGDQoXVWBR8LYwFQUWSbZkC56UAq7DBsdOOvapLjcJPkAts6PpQQepqT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7337.namprd11.prod.outlook.com (2603:10b6:930:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 12:04:43 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 12:04:43 +0000
Date: Wed, 25 Feb 2026 12:04:38 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v9 00/26] Cleanups for ixgbe, i40e, iavf, and ice PMD's
Message-ID: <aZ7lVjvDRrU306F8@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770646012.git.anatoly.burakov@intel.com>
 <cover.1771945933.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1771945933.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P195CA0017.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 5631b52f-aec6-4363-a653-08de74660fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7142099003;
X-Microsoft-Antispam-Message-Info: mNqED7QpTk6QZcr06q5pMpm3Zk8fD+wwAM7c5d/w3n0gU8yw1A5MsOPel+/aUxiLBLAU1Stx8L1ylLgvrn9mcNV9Xk3+obUQM6iZzdiS0y/Nks9HtRSA1rYz8p+UIB1A6pVPV40s94w+QI/4w4f6+mqhdErPMB1Q1OCMyv/125hLup7hhwtYDhcsIujbob2GdekZ9aomc32bm5ph86SbKfbNwwl3FHlrULZwOstPjc69Kms2jBrEC2TVg6sZ6GwyafHv+znbIxgWto4UIypXoAC+w0PGFFOXoI8iWKMYJYCWPbn7PiysSdbZCG4M2U519DfglwqFn1zG0UoyyFKgZYPJlse62tv/uyqxD/biDxegBl+ClWbWNoivaYkr864UWml6AIQsvs0CTq4PVOIQ/ae1Mf8ys5XJXS/ciSH1g3xU3eZF5sN1pJBXswJEBvZejoYocq693U11uFRNu/2c4UuJUnj4xcQGOVVjn6YDOoizpXnzQ4467pjiPoS9mwJ0vDTU2JqnAEAnsnQRc+kZsXtZRpF1VP1StPahj8MI4WSUS6buk2SRu3t3g3OuSjOo4Vv/gxI8GF3xeJobJmFam249/bXVddTOD+dv9Nw46pTgxYOGJdOFrKKSHj64SsCP5A1fieN6ff/hdy+xy3X2Dm/0NcXI7SKT0uIdDFPhlvxneMPAt4TSIfXKSxuMDq9IJzqzqSzAFudObCOYWOwL7LFkmi/BSkb87cz5T27lXOiXJgBDvnUxhtiIqA2ugAsq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MyoFiO2kqWBsPimtKn4w6XT87ScjPervVEW2TVkRr5niq/v+mNfo7wWflAEB?=
 =?us-ascii?Q?TBKJb91iTQYkc+l5x7hh4t0eH5J35hdZvY3y6DGmCeettvVEJU6hvwVgx35y?=
 =?us-ascii?Q?VGOXYC9OQaQXcIYxGoxDDFfycAS3W4ZKMXhsSJmlgSnIiXdjodXjfF4yXsSt?=
 =?us-ascii?Q?pz2TTU0gxLt+pKb51zBxW1eu2MC0OsmQZqnh2NNOExwdhhNF7oDkcCpRGfhN?=
 =?us-ascii?Q?wps+eOXTjARW+FsGvAn/74H/UoMssZnkEF9Byo2eag38mQTPSWQe6SRwO0SZ?=
 =?us-ascii?Q?T2homa/iD/380SBg6MMVkkiygp82qA2QjYncPqWN6Iu75GBX3MZF+UKc/x6p?=
 =?us-ascii?Q?12kQJhOCB+7bMWoFwF8IwYlSwoXCpDcFDSLRMrqbYe+jRoEj6cmWMejyoNDg?=
 =?us-ascii?Q?lyeEOqi8+cRPK7T/KRjHrsI7DWvkx6QGNQ+HabmvieYmiOb+W3fDCFEhQlEl?=
 =?us-ascii?Q?p6E+2PF7x6tANWsezchsfebQ3CH4GlaSQZTGlScJpksmU6JALERhSnJgk5ob?=
 =?us-ascii?Q?eqglAFUMIyHtluxFItpHzEzwfGanH/km7tTdlnNSyOO7ezdnOImH+Cn7Fc0R?=
 =?us-ascii?Q?AJh7zp9YBxiVhxOR0xGf7d3ABPjq2L+WJuFIiq7MalR+UPG6UvuW1f/8Obs3?=
 =?us-ascii?Q?4lKsrSh04lWkunPAKIy1ws2w5ZvKcHRqRg6VokAsrdtnUWCofcf7qGaFn9bK?=
 =?us-ascii?Q?Sj/qmjkHDKLm6tWZ/UAcaruMaZnklK06weqjXQRr3ANdDUIGjrnQZ/ZX77WP?=
 =?us-ascii?Q?LJ/XCj6zMdGY7JWGC3r5YCLpHGV7JQUYdrtE7FZ9Nf/NpxtVLy2zyJF/KxOW?=
 =?us-ascii?Q?iy1Zl57QsiQepOzEQp1+tw/zo7xYFR5T7bH8me5y/oZup7ywLCvG7UsZxohC?=
 =?us-ascii?Q?IHBYLqr60SM4b0kS+d2GUg4YTA4QPHm+cArwQoR2tba4ptPkl6rQqVjuCMjY?=
 =?us-ascii?Q?Tpi8UrUsV8ZfjK38bmfPFzBs8necfgSQNPKR6Db5vLDaVoAKmpMy4jgu6pUn?=
 =?us-ascii?Q?Ld1e9dqGsvSmTe4PEZQRPZMAgkJ1UcEGIeA0D18zMMYx2h8uqNTrMD7g7LDl?=
 =?us-ascii?Q?Bw/21hGYTNeozOAnNPfoWBcmL7l3HVREBU+woqPbEiR6GhG6eMxWQy0+3DXr?=
 =?us-ascii?Q?uSz87WDpTTmSO3RlGkm1ZUgZYLMHkIt6kIZuG6pAoJx4EvgoBpvI7R+ab0S/?=
 =?us-ascii?Q?4U8qCg0fbiQZj1NVEZjRosdYMjEBatMyl1ksChRYO6N+gS1uzWQvAcLFM/Qa?=
 =?us-ascii?Q?J8kTK5/aa5NWaglfvBJEEI34NW7vFpDqh82Z9Ve2cZPHlGH4K8um3ootioRe?=
 =?us-ascii?Q?pN4Pvq8QSjwTgK9RgIRId0VLdELli6jXz4KrzNxhY/tPHZ9vbuPY898lince?=
 =?us-ascii?Q?iNvMF4wgjKps9PMRaYC3jorNT/mGHkhoqjJvT8vyqVQKUjUtOwvfBzH4uS1c?=
 =?us-ascii?Q?3PB+WwzboGBUXMTIy+N0nQDrgC3BqezHJpDSp05iHsA6YEBcq1Thrn5UL86h?=
 =?us-ascii?Q?IKBSltxAvh8DFvKamKI9PmldTekg49lhkGECdgOtnLt/UT7M499pGMWpI+j9?=
 =?us-ascii?Q?qje2ndD4LzYB6/U7D9YIqpge2x8gSoDBy4RdNQ71Zd/M1CO5F5AshLkd44aF?=
 =?us-ascii?Q?n13SyiV07k1Sr5Oz0sJ5+M71OJTR5rDdsQR4uqc3WBqbN5CLBzSDPp+vsR/N?=
 =?us-ascii?Q?DMEOIfaEQmfe4Kg/j8JlpgEOY6kxXvRz/4gXVzyRZZ/2loYbIfnddUJopDnR?=
 =?us-ascii?Q?OfMAqgzcYbvb/hRTHxUKJjxDQyESHXY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5631b52f-aec6-4363-a653-08de74660fab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:04:43.4414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BF87AwRp1gqrm9tm+FpvgH1fmfEE9HFK2cIHpCXABw0kwLU8ZPlDAcNXwQEeyZklVwdjA4dMDdba2A+u9gK4JL9eGTS6OjsHteXBoqPefUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7337
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

On Tue, Feb 24, 2026 at 03:14:05PM +0000, Anatoly Burakov wrote:
> This patchset is an assortment of cleanups for ixgbe, i40e, iavf, and ice PMD.
> 
> IXGBE:
> 
> - Remove unnecessary macros and #ifdef's
> - Disentangle unrelated flow API code paths
> 
> I40E:
> 
> - Get rid of global variables and unnecessary allocations
> - Reduce code duplication around default RSS keys
> - Use more appropriate integer types and definitions
> 
> IAVF:
> 
> - Remove dead code
> - Remove unnecessary allocations
> - Separate RSS uninit from hash flow parser uninit
> 
> ICE:
> 
> - Remove unnecessary allocations
> 
> This is done in preparation for further rework.
> 
> Note that this patchset depends on driver bug fix patchset [1] as well as an
> IPsec struct fix [2] (both already integrated into next-net-intel).
> 
> [1] https://patches.dpdk.org/project/dpdk/list/?series=37350
> [2] https://patches.dpdk.org/project/dpdk/patch/c87355f75826ec90a506dc8d4548e3f6af2b7e93.1771581658.git.anatoly.burakov@intel.com/
> 
Series-Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to next-net-intel with the following small adjustments:
* fixed the build issues due to missing stdlib.h include for calloc/free
  calls
* merged the various fixes removing rte_malloc calls so that we just have
  one commit per driver for this, cutting the set down to 13 patches.

Thanks for all the effort on this cleanup.

/Bruce
