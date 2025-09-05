Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEA0CA0FED
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 15:15:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87DDB402E7;
	Fri,  5 Sep 2025 17:15:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 28632402E5
 for <dev@dpdk.org>; Fri,  5 Sep 2025 17:15:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757085311; x=1788621311;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0v/iod5r6/5lVv7e+z+e+tLus17BefKp1BkGvLTLDfA=;
 b=RJh8C/S5HkRT1QrF+hZEZxNqsYjiXYvqKBPBqt4RjnWRJUKwJJXA53qT
 N5qBC8N8Ufodk+i1D+l/b2TBb3QgWDP+UdAkE4egqu5DSJvE/MEl2jX/r
 BlgsKjHDj1XP5Ij+ZGiJ4gQZAQ41hJDOw3+nfsIYt98egxg1YjtiKiV0w
 5iNiXRi8R7Dy/U06tW+Qe9KEWVlr5SJMXdsHvlteS3IU1v+VSaJITXi59
 CSkqId5xl38pDSoNZ96r+S5lFBwc1eUaRvWIdrp60zixJJ7LrS4FAuLPD
 RwdEYD8KyKmh29j3aZ2JQaKY0XNxxcoP3Nzp8iKIy5/DAezuUQyLV2ah9 A==;
X-CSE-ConnectionGUID: /36CogCxSgudhtaQDA3/kA==
X-CSE-MsgGUID: 74Nsip/bT/ewx+S/Io7k/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59359269"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="59359269"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:15:10 -0700
X-CSE-ConnectionGUID: YR1kNlaVQW+dM8ovwWKgbQ==
X-CSE-MsgGUID: s+PWXVRNQLWgq2NlbVWRLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="176282264"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:15:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:15:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 08:15:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.60)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:15:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhW0k+kTcqVdhPgOE+KC8TpO0nlMfIEsBjKee7jtifjzNUdovnkpOqz8lVxQnt/vHySn8B5hj1wTKaIIJy0R1la0Waa2RRJUm3O4F3dwKjZOP9tRnwRsdeRVhSIChmu/rBL+vCtOjqH3reWWk2sJqTzZc7vvzK7s1eAxLrPidzVGwSHrObsjLigvy/3gf4wlcui2t+hklCQto4R5N1CbUxBPh83HnZ1YQOesS3jlWozNZL+K/UZXahhS3x2FGINjo4YmA9oZUCILC95zdiikibG80WIsUh0cerO+kmqLpMBEi8L0KbkDSGK2ClS7FsrXd8XASIV8GPCXEGss5/Rupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqxmQX3sSyxNGDxMrM8zXshA3Ra0ZVfOw5kUW7fXmfc=;
 b=h+mnUQQg1/V5qRn7irTjoFf2nCPbfgKJPtBGQfhlgdJ66RivM7xJQj4Ey/lIEiJKWi7trenqLATWBGSSLEmnCHY0bA0ccufOCELD8iaEKgnLVD/4DYwJ5MeFAS0+EHfCvK9AyyWInMkR1hZQCoiIdjVCmtu0x1xkTZJOy0gX9krIwfMz5OGuxsw3yp2+HemYQh66hqv/z4z4+get+dDfqsKbk7P0O2T92sZaCqiNbKQLlJ/dA/GL3iNYrUHU9lQLuYvQsHJniROYU41qShx4/3yRUi8PkFky3/H9vHkrRhMVfd+8tuWlHPFSa3o3tAFHh+hB6EEbA1ELRTXY1umaOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB4932.namprd11.prod.outlook.com (2603:10b6:303:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 15:15:07 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 15:15:07 +0000
Date: Fri, 5 Sep 2025 16:15:02 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 07/12] net/ice/base: allow overriding recipe ID
Message-ID: <aLr-doQhdYNWW7uC@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1756833701.git.anatoly.burakov@intel.com>
 <ac3baaf70490565b39dafd2aaf488e63df76174c.1756833701.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac3baaf70490565b39dafd2aaf488e63df76174c.1756833701.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0343.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: e4320abe-31ce-473a-02c1-08ddec8eff74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VXEogMVN48l+I7v9swcD0k/zJ39UwjtqYjq0uWF/p2j4DN4Foohh95uuW7Uo?=
 =?us-ascii?Q?AJb/+wfC8/d5DLoAEs2nw3WDR0iw7YavxXmhLWgUSpASKrP4kVJ4QSghO9ir?=
 =?us-ascii?Q?5mYjm9ppBV8w4UTHyWfUq5EtU5tWlYJucsgfUNRLyRnfx/tmxsCTIimBxcPw?=
 =?us-ascii?Q?LsGpW9gs1hzx/PRSCCOgLbvzBCsJGXM2/Vw1pg+aKG/BTxirNlhnn7L2W0aF?=
 =?us-ascii?Q?dwePNB6qAhsIK/26qKWCPuX/fi3sraqFkA6n9LZ9yw/n8OxW8Af/eZhV1Rhn?=
 =?us-ascii?Q?ynEiS/QOP5TGyLZqVzKlBwj2I/xHXNEBKNLwsBJsMJLItru1RctfU5TzSNDu?=
 =?us-ascii?Q?7lWE2rr0lx7r8YfZ60JhDMHNLmrgD3SvuGhiIiRDn8Q6Uf6/HAXI79U1UR69?=
 =?us-ascii?Q?9VaUdrixHxQn/AwU8BJnGHaUwZLISAULvKf+jwU8LAfN8Qbd/qO+rJt8oXyC?=
 =?us-ascii?Q?q2rSD9y9Ppulky7IvrgZCn5ghgW2FO+D9tNqYuRQ2t3IeO4/CLJ8OPNUM+/e?=
 =?us-ascii?Q?4lwi0PWxbzKtVaOMWaJTCA+aytn9h2odHOt8/KDSf4sU9E9cFd7VcGGCqetX?=
 =?us-ascii?Q?HSfsc+vN3ttPnS84Ua3Mn3C2ycyWR6Cu4qafWHML86Pjok0u+4A/7MnbU9tH?=
 =?us-ascii?Q?OxuMvtcHGZDdA8BNPv01ztSU5drLAoyoveaW7YKXf09T9LcrYQoLPU0bK6FF?=
 =?us-ascii?Q?0wp3ckb5sxxm9/XzLC3Gy1nIgJwjovoj3rQOspcvQOkaREmhhKpaB+KM5HGe?=
 =?us-ascii?Q?VZ5gSYfluWyT4TN/Ku7uTgkqgfiBMbVZsiPrWWNoTx+Y90AJgyIe6eTzkwjb?=
 =?us-ascii?Q?1tecq2Y7IOECZJlYpjDPhhxrPMXYZ8dxbam7Efm18Ys6AS7usSgduntILiq2?=
 =?us-ascii?Q?ZYcmYpuW58A3kbYhtBOJjgwxrsXrBrFjrvBLJybkWvI6ADO9zhx3nSigjxMY?=
 =?us-ascii?Q?i655NyXFGRrIVDIPud/SoPZd+XSutBz94+LX0qqS/vHaVvM/kGV5AsB5NDjU?=
 =?us-ascii?Q?esBRy3TM03gj2L5FXEVgoRZH1dCjawd7T1yHpn34GySRM1Phbtc+kxAoYvvi?=
 =?us-ascii?Q?OYX0k/+Z0doMB82yrYkAAjtyeb8OxL65ajB5FgSpUJySc65SkUYojx1u4j2M?=
 =?us-ascii?Q?/7mc+5AJhtVhRzJqYuAWs8q6LauB0sI+m6p2cgPqnjUzTBig8skjphpbI7MA?=
 =?us-ascii?Q?2EeoNPLFm+mjp4ZXO7POUIW3MFGVGVwgBWVZ3EUEYCh3lSzIerbaYkYsvEJ7?=
 =?us-ascii?Q?gT0FHQSTWjqEXfa8Vo5gzkTFZBalelxAQsY44zm27t2txQUQnSgvh9WpZxB1?=
 =?us-ascii?Q?ffNq3XIjKBE4fEI2cSSYV733CaEpdxzP4RhQRA/vX1+0830BfsUmNb8/fTiT?=
 =?us-ascii?Q?AC+NQNinpOUGjXK3diyNOv/QxMQ41kI9bHjNc/vBvy7WIFNG5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kViAdGPeUnYLHOdKC+Qf6xjGhn+s2Giq6DICHu83sQkw3dSUi0okRBiz2/4i?=
 =?us-ascii?Q?y1ekcuqm0HwFmLCCBclK1VvAX0BZH+cczWuQLsxU5nuq1aYmqCPB4IaqYbA2?=
 =?us-ascii?Q?S2AFEvbpzMjTbcA1IwlXKwkmJwm+Ha05GdfEg2FgUpM/V2XoT82Yd0pcZBpX?=
 =?us-ascii?Q?jXGh6Kx+FR33281wrkpPjfpctYpP88BSmp4Dj5dd/AIdtRsIsvM2DoprQLiI?=
 =?us-ascii?Q?aEeVT5h1iiCrk3XOoSOLwzJB9ma7xldGMQOSNDSdVe/yjankOSSwErFWnIlC?=
 =?us-ascii?Q?CIZFlGAHJVbDTaRwXzB6UY8PDg8Yg43BpLraUis95prqaANKbrql8YLv5mbJ?=
 =?us-ascii?Q?2YsDfGhyMevh8slY1kMYg0v0dIfdg13VfulRIuMnL6Y0zrnPqqbEGWGdekCp?=
 =?us-ascii?Q?V7K9NcU7IoZnQMr4NOYvIDwL239JAT/EahpT5y5cNz0V1c+gIKDdJKRulXVd?=
 =?us-ascii?Q?yJKxxLSnClGpJU53fZNbWrDd4Fc6uRUqMOKV7veayYTI431lSa3BTS5vgYES?=
 =?us-ascii?Q?xTLB/YrJCvkCRH38WQCK2NKFHjY+WMPGR/PfSWxNbWFlwx1ESJ91f4q2lqy5?=
 =?us-ascii?Q?dUuiOodrBBAy2a1a375f3kom4vOmMBp1AIi4QyCUY8UvuTVvVUF2L51WiY5r?=
 =?us-ascii?Q?qaL/FsnK6EDOzSUljnerF/tkVhYVJgYaym8OIfex3v5cQa1CWF0cHsAh5OkI?=
 =?us-ascii?Q?3TYtH6GHiOJuAA9E6s7+LaeGL0/Lvu4O8R6H2FyauC2N5EhIgjtBs++X+5yL?=
 =?us-ascii?Q?D5QzyZIxERwEG5CeZY9i+6tb2Uj4MMnfsO4W86k3LaiVXSSZGFLw6new8DFL?=
 =?us-ascii?Q?CK7PIu7SLPp28VL/w+vefsUlGmgb0hrKyAJEPFjowem6NlVuIzx2UEthdS7C?=
 =?us-ascii?Q?4plnkEljrPGAOjOPhptX904bvARSbk7RiKBySyP9wXfVYGS3uqNrATRoxafz?=
 =?us-ascii?Q?LahQFJU2EpGH7E4oykohqvIrgBdYWfuOAU72t93sRT+Wit7XDrRmiXB61Zdv?=
 =?us-ascii?Q?APUuy2MpMwyIzYU4WqUTEiiKlfUmDmXYrXiFpfuMkTs7irZ1thiZna9oA0bM?=
 =?us-ascii?Q?tWIrE1Rq0LBJv5DdvilYSfIg7VLjcxKuj3B230nxd5JrVOedtRel+8Z8+j0M?=
 =?us-ascii?Q?HdUIsqug7xhA5qlvSxrdaAu0q69SRwXnwTAJVi/3Bo1mx0jsceUV+2vkZtqp?=
 =?us-ascii?Q?Cdq8zxgcnvd8JN8jl64zNCXzDtT0r3kFIG+Xu0zjtI51JxvvBPsqKlyVo3FJ?=
 =?us-ascii?Q?/XbQp9IOg3nZbKhRqurQDDc1XZvTUQvguHBUcdNcwOhiE9g877Vo2Qcur4dK?=
 =?us-ascii?Q?wgoCWXDrvfznLkxhClE0uTJ5+FoltTc9MoulL8ey2meDluH1QhorgMXbchu8?=
 =?us-ascii?Q?XcgqDA9Vvb0tpeh8SkxGSTkMyrcEdt41EShNx0TVHadCIhFFiKiTOI3E4+Ha?=
 =?us-ascii?Q?74F3bhUfZj2h6sRmFd2WYpq+MoKZbH87OIo4qUNx9aX09ldscupjKsgQ5Mb4?=
 =?us-ascii?Q?YF2oCHxLdFLMPWZkwpl0WXe09cbTdEAIr3mRfBYy8Zn4P4406OaIYLVszzcd?=
 =?us-ascii?Q?yedbUF6S2OeHVxS2y/v9JR0ut7ld2LHM+Rr394klXV1fUEzfTkTA5EzeuSJo?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4320abe-31ce-473a-02c1-08ddec8eff74
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:15:07.3196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyRsouljq/9ido0Oh2y7s0qWSLEFwC0OUGc+tZGcrCIivjCnN+++5Va4aCf7HtD7L5iLfE71e8dAzw9CoLYaynWi2ZIIL7ahOHV+e1PmwTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4932
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

On Tue, Sep 02, 2025 at 06:26:57PM +0100, Anatoly Burakov wrote:
> From: Pandi Kumar Maharajan <pandi.maharajan@intel.com>
> 
> With the addition of double VLAN mode on the device, the MAC VLAN filter
> add rule was previously matching only the inner VLAN, rather than the
> intended outer VLAN. This patch resolves the issue by introducing a new
> software recipe ID as part of ice_fltr_info, allowing the base code to
> send the newly created recipe ID. This ensures that the filter correctly
> matches the outer VLAN when processing packets. Issue is observed in ESXi
> environment but this patch introduces a generic solution for all
> operating systems by adding a rid_override flag. If the base driver needs
> to use a recipe ID different from the shared code default, it can set the
> rid variable and enable the rid_override flag. This instructs the shared
> code to use the specified rid instead of the default value.
> 
> Signed-off-by: Pandi Kumar Maharajan <pandi.maharajan@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ice/base/ice_switch.c | 6 +++++-
>  drivers/net/intel/ice/base/ice_switch.h | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
