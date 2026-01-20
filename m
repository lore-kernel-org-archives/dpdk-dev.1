Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9143DCA5FB8
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 18:01:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AB1940ED9;
	Tue, 20 Jan 2026 19:01:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 0A82240E0C
 for <dev@dpdk.org>; Tue, 20 Jan 2026 19:01:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768932117; x=1800468117;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=f8+tqKY1Ejn96EG/wXM7S9Bai47eml3ribV9d/LWh8U=;
 b=OCH6F+HPZiYQeovRFNpqeGvl8ZWO0tylSwfqP1WVvAKV7dqUWrY3VYrn
 UWsKeQykCsTllZpY6lv79tyWUiu0MoKgqNVHYYzFANpCca/3LC9c62KSz
 PVrgIk9b6AtYPYQN/Q3TugANarNC3hDVdgijRMaxYN6MGkOKnTAC62KDs
 36A3HyIKfLkL17fh18F1AuT/siyLcEvEqrmbB8ulJPIjzYWWbiGoHz8dS
 lwenaGLYwU4JDJqmk7NJ6z7hZdl6kl5Nn5/M4v7urGhTImtt4DPtTjq3w
 qEcPPytJunbQtoe/VozxkaiZ1VBcDRlJoOlf98x4l5JC6eXAz7wgHHDE6 g==;
X-CSE-ConnectionGUID: /eg52qOVS/ybNnPdxB2wWA==
X-CSE-MsgGUID: ujR/ThwvTqmMO3OV0ZLxdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="92815164"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; d="scan'208";a="92815164"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 10:01:52 -0800
X-CSE-ConnectionGUID: FgujcJ/bQ9izMnPWZkhT9g==
X-CSE-MsgGUID: HMNNE04TTeSJArXb8JqjHw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 10:01:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 10:01:51 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 10:01:51 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 10:01:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LS0tQoNOiKhRJuequ8cdb74qlw5jQ/mWmVwIQA5GHYmc0iDdbtcX43t9K0mDKqV0CGncmtyWO9hp0P/DBuKGstAdWaZdc1IvMTFSwRMDZdDPbf6HVFirw0pm+9Zzi0JozXN5rmNGVz3VN7Bs9wp3xRQLLrOr7/l5c1EHY2gtaMLYnYiAcB8NyfuArsuTab8mY0tJjcWrBPnDEbvTmHXld91GFQ7jjoYuj0e7bTiYABmamq6Nfe1KLFxLpiG/V948fNVg5DphF6GYqtUEsfnAl1wMa3Tljn2mPwMcONuhHhq0ngvfBGoZL3XxHdUE10jHcDmCbbaY1uzJtmiBMiUUGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puFa1ZqlYSfxLvlBXgfZ8trmUOwawTj1B2a6SHzITFE=;
 b=Bi1Kaggqo0rTV6TGRcO0Dljem5Y7zznqCdI2UyZtZaNy+4cgsPBcOUroSSpxMNhou79LPz1mX2nEaTv0zOkDhLdeZ0AFPfy74xYmtoViuh+Qlu8VqmP8ptVPptwblXW+0bmQU6k4a0F5TiYIRhjHb6NlB7s8DllglH3WcpptStQOt9r1YBCQdrAbcjR8RJr6h4vSOKNZHQOvQJQvga8ieP6qz+v5u28aXavEKOd1ejXRBvDdsqHEW4y1ZiM/sByrYXCsBZKJ9EWmApIxtC8dMI9QX0AfWUZp0pfPnEhWrt8jFmNCKKhgXKBcUePSinSjEw9/iXYztHZ4/a1gLYrSTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM6PR11MB4579.namprd11.prod.outlook.com (2603:10b6:5:2ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 18:01:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 18:01:44 +0000
Date: Tue, 20 Jan 2026 18:01:39 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2] net/iavf: support pre and post reset callbacks
Message-ID: <aW_DA9TtPD5cSc_u@bricha3-mobl1.ger.corp.intel.com>
References: <20260113151757.567234-1-ciara.loftus@intel.com>
 <20260114132159.644359-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260114132159.644359-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0089.eurprd04.prod.outlook.com
 (2603:10a6:10:232::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM6PR11MB4579:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e2a1f2-9504-4b24-8ff1-08de584df8ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SOQlb5qF4zpR2at1G+hhjxZ6A6qi+UKF+X2h6YMjo6dpGiYCKMyHXSX9OBF+?=
 =?us-ascii?Q?DBFScQwMQLiFLWya5rJYe0OSK3+CMu4li7FQO01QCdInb4yymDWG3DcmpL46?=
 =?us-ascii?Q?0HSL1lCVUunR8WeGZ6GiWcfQLP81Uh0BIxiDZYGJr1nlHGPq8VYjL2x5VYPF?=
 =?us-ascii?Q?s1NM9EpdIDTclAkzZLjijH98NUbKm7TlsH64qj4RczUrcOkCm3ZvKRsoLAHJ?=
 =?us-ascii?Q?WdreqwGWjpDU3p/bnZuGaTB1FWhcLxKTvE815pGR5540EBD9FW5ws/Hm5QPW?=
 =?us-ascii?Q?4JkikuHwsCfXWw8i481PqVR80LuI6IA18oXVeDDiPmf9I2Q8P7H/65BbDzZs?=
 =?us-ascii?Q?jEC8vAo4CBmhe9yYyjkZCMsNsbWExPH1AYjZIvPVmVtRi/zdu8GxFz6sMh6r?=
 =?us-ascii?Q?aDkOyoXYKg28sSeHuXNBDVMg+pVSUAt3nqY4lkrut+RKXvINH94WL4fSYXCj?=
 =?us-ascii?Q?YCvGGvPSr1ZQT6vP+TetfmDPiOLCFpUgziXh7EhD6eWPGG8vnMYgF/ZYt3ne?=
 =?us-ascii?Q?m9Ja8VLtninvgA6IsikZ9LrePMCzr+I6GYyxxUaWzUUuo/AclaLV0FqUomuH?=
 =?us-ascii?Q?xaOvs6wFkLOUT2+sXwbrr68FuW/aFUa3EId71re1zSY41XPjbCnjLZj6hGtS?=
 =?us-ascii?Q?nsNXveVPgUD6+BP2yc8zWTiNoWEAhna/A4L7v2RVNtso0nWjEFnPthkJVClg?=
 =?us-ascii?Q?17bOyOP4jxH5w3IkR0K5Smq50MZ9pQZWdM6ChM9p+JzpE4jbkW2G56tsdpmC?=
 =?us-ascii?Q?YLLLZFjiG2HnV28pTiYRjKyMNe/mE8vQVsgzYcHxcP2PQz6Ncv22FYd2N69x?=
 =?us-ascii?Q?bX5wzgbf+4Z/yN+Fw6kOvndMYybpRmdOJ3wN6aAhR6iLXe3lOJdzCNc3dUPq?=
 =?us-ascii?Q?BScDNgV01CAUDkX1TSihkyKfQk8wu827QgASfe46oX/bEA1sElKr/Lw0VZkJ?=
 =?us-ascii?Q?6ryEwwoRIZfkJM1IeWr/v87sp6zNtvwRQiGOPGyisyuTMkulywd026dGgoDq?=
 =?us-ascii?Q?+OAHhSUnecbph2sjhOVsh2PPRN8xpgDboa6Bh/Vuul+y3UEzXvQjQS0u+r08?=
 =?us-ascii?Q?KBchk8nrMEFS/l6eDh7Tf3VAQVApbVjnXWQ9SUDDrrjgc+8uYC3UP1m43RTW?=
 =?us-ascii?Q?CnfDamM7MZdf4KwURTZ1Xdg94tnAD/zyFgoJ/tqjzkg/Hqyw60B/V6+KSM4g?=
 =?us-ascii?Q?jdO/Z5cnk2Bl7nAbh+a4inRs244GtafyhQ7ra/N7OSBlIR3l//6yxQkqkEgz?=
 =?us-ascii?Q?ZujpDAFEniQGQAM+CIkX2MAi0roOOFqQae7q9T9F1SjvDKrTaCzMgXXtI2y4?=
 =?us-ascii?Q?ta+Cc5rvvo+v21hFZ83nxRCr3YIVCLFl3gFQWUv30A1JV7Ygjs7MZ3Byz7fB?=
 =?us-ascii?Q?FsjIE/3lXPhyApSd1uECwDHS0Qx30DO5OIpSqYYNqMB/5ZrL8fuYMK8BvTzG?=
 =?us-ascii?Q?v49icrsqe4DLpjUXHLtCx2xOiM7DnTCTu18cpvrJH+vVbqHA+8K0UCzceLuG?=
 =?us-ascii?Q?gSsAftsW2WSO8wJ61PcZVV8WPdOq5jWp9QucpwbHMBHteqrTM/sX1ETFWWYl?=
 =?us-ascii?Q?rkKpPIBf3uvMRaByw0w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TdIuchwjQbjeTGx5cAdG1BX3cqLUqNj8BzRYNwXlwscnDotqK/wImOYTxY9V?=
 =?us-ascii?Q?fNXd8m+W6W6/ykFo6W+W8zYQaPDWBQGTUf5EoNfUE1QYjTMnxTO2G+B+MzeA?=
 =?us-ascii?Q?FT05vhdS7rtayxFgrD4OO36/zGCFnSnFa2Y2AW1SihWH6xeQWqukXDmNX7rl?=
 =?us-ascii?Q?vmH1WZ9CBONlPJ88Hq8UzF5ak+IIrwbnii1Uhb14IyXEmI4+/JMVBJyPSblB?=
 =?us-ascii?Q?tNBD4v2N0j0EXyUDFmYfJWJcOwYDTGg6y1Dqp2r4FZO1JLnQS+YuzD8flF/O?=
 =?us-ascii?Q?+RVQKjujcbLI68idAWEw/tq9N1Y3NSo2IGQOUJJEYdG/OHnI/BytA1KYGF2j?=
 =?us-ascii?Q?q82zaIyGLJ+Iypg2ZaYo8xcPB6xdDNntbU89+9uht1PRKCX2sS9Szvaev9qe?=
 =?us-ascii?Q?fGA6blZQgzrSZ4Ut3TZR/LdPlAiGuLuLZHFWe3g20hBB5/s66rr0kgpMyuiI?=
 =?us-ascii?Q?iB6+Juvupc9NBsur2mXrnO/pxLYHTr2YILP60G0Ofgix+PuxldSMYTse/5te?=
 =?us-ascii?Q?28B2c5KLneXZBq+VK6X4kRgSadh+pR3EwW9gwtfddzCYoU9FZfeBlzg9GzlZ?=
 =?us-ascii?Q?MN4yucKr/x0utgEsp4278YTCCpDVJGxjtEEW3HrmcOU8wfPTKVNHj3etgyVa?=
 =?us-ascii?Q?LsMOff4KGCZ2RTGL2QYaa41FpP3BAJSVHNZppUf0IztG7VHd0N1puwNFgAEt?=
 =?us-ascii?Q?thvsUX5k8SdXi3pzmB326PUpMm86v9Ka2DwyOa1NpUY1JSguUi8q2sJAzdTG?=
 =?us-ascii?Q?HZo5ZjH2JKBvkEJNEM/oce7gtgkSlCaWUJb0THtNBN0gtT3bQvtvwUOPWdyp?=
 =?us-ascii?Q?AVLZk29XgN/kZWzlAofKspZV4e0IhqUjBnBvQi2gSXpeYNE0cachgeYxknij?=
 =?us-ascii?Q?SBKUKDhh9wMXjj3GRtur3zYbeLTAPweBCrR0MIHpNiC850/TH9f0znT3eZZd?=
 =?us-ascii?Q?ruy8kWr1auDQ3N6dakRscKasWqCRIp+rziPGMkKNA1LN9tNtuTVBFwvbKVwZ?=
 =?us-ascii?Q?Qfy0pA6aV/9hGfxLt30SSsgWXb44uMx2rNonIzNt/fk9NuuhaVk7+4mpS7gu?=
 =?us-ascii?Q?mdkl1zB2LeHCcZvhWlnaAKRSIJeGhzKz0Oby1On5U2U8MSITePUN3dor568c?=
 =?us-ascii?Q?aNALc70No1Mu3AoUpDJSIWjqIiuTzdd9Mb1p+y80ZnbAB4i+UNh5afZaRRMI?=
 =?us-ascii?Q?Y4vhSlhnUqOax5z/OD5D6aI5EINWMOFCa3nRAOr2qW9y+j4kuYnCC++wG6in?=
 =?us-ascii?Q?xXlQAL8+QIrhO0o/iztq1iBrpg1x+kmCn7r+ya5CM2Idz7T4fRrJ/WjVUWCN?=
 =?us-ascii?Q?6IxtrX4MFKo6f+so5t4sFGW5iS6SYQVX9Rg0G9rdfltBaJpsWcAiAMj+cHPu?=
 =?us-ascii?Q?oXt0WXpoxh2JZifC8IF4cX+FE2tgcRRF1UGtfQGVInB+swpuChyR6OrMXFSo?=
 =?us-ascii?Q?fztQAJUK/QM2+RwqBTjOFMDgHhTNxuFcKYlbMMAnKuXhhwWCLLBzOw6sPBdJ?=
 =?us-ascii?Q?E5WBH43unfv8o6S1hgk+4EBs/HSSY0qAZg0c/fr4AFf/60lG19UySr+7sEo/?=
 =?us-ascii?Q?jD5S4osCA+zSa3AYuWb6Lm4bD+N5dp9bPfrBuHai9cRTAPo3bnl+u06PS//9?=
 =?us-ascii?Q?azWAchdmvVX/S19hfCRVAEOAMm0ylI5etEnHC+tjGrGL1AuaJS0L9CX6ctcv?=
 =?us-ascii?Q?5MSGX9W6XXwlsBxya0v7I7O6LxSQGh/n/Hta9A6QLfovOR3wPbA5JfJV+soT?=
 =?us-ascii?Q?e8+9I+BAG+bDyL6atKVjw4f5BtS6Okc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e2a1f2-9504-4b24-8ff1-08de584df8ef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 18:01:44.8249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktfTpFC6q0fxXYnancsfH6RnMtisoFuiStJkpObE30Cr0Ls/OMvD3YmXh3pDOvEmJpNIE5V4u+bF3vVqh8iQdjQrtx7+PYYxTa8AaovKhco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4579
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

On Wed, Jan 14, 2026 at 01:21:59PM +0000, Ciara Loftus wrote:
> The user may want to perform some actions before and/or after a VF
> reset, for example storing settings that may be lost during the reset
> and restoring them after the reset. To facilitate this, introduce two
> new functions which allow the user to register either a pre or post
> reset callback, which will be executed before or after the VF has been
> reset. To unregister the callback, simply use the register functions
> with a NULL callback and argument.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
> v2:
> * Changed the function parameters of each cb
> * Created separate register functions for each type of cb
> * Use typedefs for the callbacks
> * Fixed some style issues
> * Permit NULL cb args when registering, application may just want to be
> notified of the event and not require further processing.
> ---
>  doc/guides/rel_notes/release_26_03.rst |  4 ++
>  drivers/net/intel/iavf/iavf.h          |  8 +++
>  drivers/net/intel/iavf/iavf_ethdev.c   | 80 ++++++++++++++++++++++++++
>  drivers/net/intel/iavf/rte_pmd_iavf.h  | 42 ++++++++++++++
>  4 files changed, 134 insertions(+)
> 
> diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
> index 15dabee7a1..770f9933ee 100644
> --- a/doc/guides/rel_notes/release_26_03.rst
> +++ b/doc/guides/rel_notes/release_26_03.rst
> @@ -55,6 +55,10 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =======================================================
>  
> +* **Updated Intel iavf driver.**
> +
> +  * Added support for pre and post VF reset callbacks.
> +
>  
>  Removed Items
>  -------------
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
> index d78582e05c..50ca14e41c 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -100,6 +100,10 @@ struct iavf_adapter;
>  struct ci_rx_queue;
>  struct ci_tx_queue;
>  
> +/** Callback function pointer for pre VF reset event */
> +typedef void (*iavf_pre_reset_cb_t)(uint16_t port_id, void *arg);
> +/** Callback function pointer for post VF reset event */
> +typedef void (*iavf_post_reset_cb_t)(uint16_t port_id, int reset_state, void *arg);
>  
>  struct iavf_ipsec_crypto_stats {
>  	uint64_t icount;
> @@ -257,6 +261,10 @@ struct iavf_info {
>  
>  	struct iavf_vsi vsi;
>  	bool vf_reset;	/* true for VF reset pending, false for no VF reset */
> +	iavf_pre_reset_cb_t pre_reset_cb; /* Pre reset callback function ptr */
> +	iavf_post_reset_cb_t post_reset_cb; /* Post reset callback function ptr */
> +	void *pre_reset_cb_arg; /* Pre reset callback argument */
> +	void *post_reset_cb_arg; /* Post reset callback argument */
>  	uint64_t flags;
>  
>  	uint8_t *rss_lut;
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index 15e49fe248..83e3486572 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -3120,6 +3120,10 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
>  	vf->in_reset_recovery = true;
>  	iavf_set_no_poll(adapter, false);
>  
> +	/* Call the pre reset callback */
> +	if (vf->pre_reset_cb != NULL)
> +		vf->pre_reset_cb(dev->data->port_id, vf->pre_reset_cb_arg);
> +
>  	ret = iavf_dev_reset(dev);
>  	if (ret)
>  		goto error;
> @@ -3144,6 +3148,10 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
>  error:
>  	PMD_DRV_LOG(DEBUG, "RESET recover with error code=%dn", ret);
>  exit:
> +	/* Call the post reset callback */
> +	if (vf->post_reset_cb != NULL)
> +		vf->post_reset_cb(dev->data->port_id, ret, vf->post_reset_cb_arg);
> +
>  	vf->in_reset_recovery = false;
>  	iavf_set_no_poll(adapter, false);
>  
> @@ -3183,6 +3191,78 @@ rte_pmd_iavf_reinit(uint16_t port)
>  	return 0;
>  }
>  
> +static int
> +iavf_validate_reset_cb(uint16_t port, void *cb, void *cb_arg)
> +{
> +	struct rte_eth_dev *dev;
> +	struct iavf_info *vf;
> +
> +	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
> +
> +	if (cb == NULL && cb_arg != NULL) {
> +		PMD_DRV_LOG(ERR, "Cannot unregister reset cb on port %u, arg must be NULL.", port);
> +		return -EINVAL;
> +	}
> +
> +	dev = &rte_eth_devices[port];
> +	if (!is_iavf_supported(dev)) {
> +		PMD_DRV_LOG(ERR, "Cannot modify reset cb, port %u not an IAVF device.", port);
> +		return -ENOTSUP;
> +	}
> +
> +	vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
> +	if (vf->in_reset_recovery) {
> +		PMD_DRV_LOG(ERR, "Cannot modify reset cb on port %u, VF is resetting.", port);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_iavf_register_pre_reset_cb, 26.03)
> +int
> +rte_pmd_iavf_register_pre_reset_cb(uint16_t port,
> +				   iavf_pre_reset_cb_t pre_reset_cb,
> +				   void *pre_reset_cb_arg)
> +{
> +	struct rte_eth_dev *dev;
> +	struct iavf_info *vf;
> +	int ret;
> +
> +	ret = iavf_validate_reset_cb(port, pre_reset_cb, pre_reset_cb_arg);
> +	if (ret)
> +		return ret;
> +
> +	dev = &rte_eth_devices[port];
> +	vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
> +	vf->pre_reset_cb = pre_reset_cb;
> +	vf->pre_reset_cb_arg = pre_reset_cb_arg;
> +
> +	return 0;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_iavf_register_post_reset_cb, 26.03)
> +int
> +rte_pmd_iavf_register_post_reset_cb(uint16_t port,
> +				    iavf_post_reset_cb_t post_reset_cb,
> +				    void *post_reset_cb_arg)
> +{
> +	struct rte_eth_dev *dev;
> +	struct iavf_info *vf;
> +	int ret;
> +
> +	ret = iavf_validate_reset_cb(port, post_reset_cb, post_reset_cb_arg);
> +	if (ret)
> +		return ret;
> +
> +	dev = &rte_eth_devices[port];
> +	vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
> +	vf->post_reset_cb = post_reset_cb;
> +	vf->post_reset_cb_arg = post_reset_cb_arg;
> +
> +	return 0;
> +}
> +
>  void
>  iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change)
>  {
> diff --git a/drivers/net/intel/iavf/rte_pmd_iavf.h b/drivers/net/intel/iavf/rte_pmd_iavf.h
> index dea1bd2789..d13417eb08 100644
> --- a/drivers/net/intel/iavf/rte_pmd_iavf.h
> +++ b/drivers/net/intel/iavf/rte_pmd_iavf.h
> @@ -20,6 +20,8 @@
>  #include <rte_mbuf.h>
>  #include <rte_mbuf_dyn.h>
>  
> +#include "iavf.h"
> +
This include is an issue, because it's an exported i.e. installed, header
including a private header that will not be installed as part of DPDK. This
gets picked up by running chkincs from test-meson-builds.sh script. [I'm
surprised this wasn't caught in the CI].

I think you may need to invert the dependency, the private iavf.h can
instead depend on the public rte_pmd_iavf.h header file.

/Bruce
