Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BAB606A32A
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bfq8F8Lu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 630CE40689;
	Wed, 21 Oct 2026 12:58:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id A3BD840041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:58:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792580285; x=1824116285;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=uQst9xpBeHS1y57o8Kf1yqkrcluuHpRMSCqnmqrMiiE=;
 b=Bfq8F8LuKTKcgQFNFfni86QKLDDX9SVzSOy/zHO0IjfvPfDWTc3wdGZ9
 AGRhKKn/uRgv80RojwaQfhBSuZO1t3ugmsGOCnIEQgbT6BF9UKYpcFFsH
 R4iv8rdJJbfFSz23GvssWlUGgVBrX/jCCMcGl4QsP8tgtn2VEKMUPmUCo
 S7Tc7nzvgZcvgFE/H4abKx/u6rBaswuFDhv2Hpan1Wb1IHCP+4A7eKceh
 caE6e2qLKKPMcyxr32ts6u+b945bQLTeieOSk0CqAG1gRn0c29xZh1CJo
 wXaQeP3j9+F/otwxTkv6Vk7l8qhxVQuom1Y/eIZTFRDmlc+uwQYiY1/u8 Q==;
X-CSE-ConnectionGUID: zERDUyUYR92hkEVok5qwaw==
X-CSE-MsgGUID: j95zMGv6QHOhqQ3VQKe9kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1403717"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1403717"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:58:03 -0700
X-CSE-ConnectionGUID: XSo2nE/UT6mfjZDr0uOAxA==
X-CSE-MsgGUID: RyK3SXC/TsiwhHAHxgTmnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="2950125"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:58:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:58:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 03:58:02 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:58:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7lfxBf7FPwC9xpQY5i3/+PrkuKMfZy5KGtGZ6Chp0VObaA06FqU/2b7rVZG8Tdigi5N06HrMvlwltXog3a3vAoyWmLvW0CVKhP3m5pfxl7zLx+ewfvNzNkpuIl+QL5neJrhCtS50+IShWxl8cjAI88syCi8LdbpKAg/6PxjO9PUqTxPbTgaF40uq4YEblaljfYA8ri/L1GbWndCfbZjju5IkwAphRygjTfJT+R21ScSiZ4udaDnqtCn4pX0m2tJ5PJC1SFxZL7LQlu2KwLpwhcDYQhGCFwQ/AQxgHOMb1OF2Ljs4viCgP6b5UAMFi93s+odfleDbOt02aIdG5y73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdDbu74JyO+PK0aFEcG0mXi0keJvORVVQnY1GFhxfdo=;
 b=pzBun330fobP8ZvKUp/96hQoQG/ZWaQ3tO1j2fS5/AGEXaiFHMReVZopQ7Lu082M21p5rcFGhBMTC9Q7T9/p/wa4kUg7yDsxkcIIuPWzZTGwWXV/rASLEYCI5tlGk9O+4D1bPmELxmh5cRQAVc9SwSjZhHhMH01aCVXmTA+DbGo+5Sn6cqF6pXaq3eecpaUP2K3ADyRYf2xJEJ3JkXlM8XDwFnR3XZrWSK+VTDQqNDVEmcELt3im/dOh+jgJCb0uBQg8XZ5FcDS5J3erz67Wah0sMPWIKZzXuwxcoc0aTEC6+u7CqFbfL9U2+EIyu0AXPBjzig5BbdMxtasKpCLiSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS4PR11MB283782.namprd11.prod.outlook.com (2603:10b6:8:502::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 10:55:54 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 10:55:54 +0000
Date: Wed, 21 Oct 2026 11:55:48 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, Xingui Yang
 <yangxingui@huawei.com>, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v2 06/12] drivers/net: remove check on VMDq modes
Message-ID: <atiaNGKnrxLI6dRJ@bricha3-mobl1.ger.corp.intel.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261021103027.2050351-1-david.marchand@redhat.com>
 <20261021103027.2050351-7-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261021103027.2050351-7-david.marchand@redhat.com>
X-ClientProxiedBy: DB9PR01CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::14) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS4PR11MB283782:EE_
X-MS-Office365-Filtering-Correlation-Id: 368d2e1e-4b84-4e15-67ef-08df2f61e11c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: s+DuwINu2X76mW93JER2piociMI15iIYGyGKhIWHACYCF+e6vR40ayIkV6cEqb0lDpq8fm6udUJEPw6D4x+Wkdz+vMHC60BxcmxjLGi8uVG/wsVoPXl0xw8BBEmsfI2FpTZrfVy9Uy6YoDabTWllsmbOJYrz78j4nJpseUnGKquUjuTjpHw9SeuH5ycs8siY6Wq3/kR2vQLzvW9xLLqv6f6L5b8y1b30CUXO+NWcCmOlVduB/P/wDd7DA0dWWTnRP7oZE+7Rv4U1w7vLpcXYYQlfD5bcZNBAx1ifHZE2pZKApAt2KaVKZCZvYuNwuwv6suw/Mw1aDpkB9VB0ZtUhpVtZ9ATd4N3EuvIo537RgM+Mg4qBeUyGtmVo/KbiV7huRNcuDqG2LYReX/iZY7CcqwwrwA/yYRvMtITMp4WST5O6p3o7httgNzOBpZPeKFk56LwS4zhnHRHLBo9ZmuQ1L8tLly8UycC7tCB0TAgLxnfgbf1C9hI8P9SgoKJ45C4ae0AzynwEoMvC8cKeXA2Bqfn0VkV3OJhBwb/Y4PtZA1thLzoIowiI5Dk8LY85WT64MIcm2uJAC7dwhlhl9/i6LnjSP7t1JI2VNEtUzzGucM81jOFFxxug/m4rxkRncQnuXAsBsMn7IMtl8WTDh8uFV9XmbL3uUdWkOwVNQ2vlutg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/gbIIhzHrqFwKCtZ18xEMvb8nw/sW7LpJ0PYjPEWHwkZIjgYwLFVdgnkTZL7?=
 =?us-ascii?Q?ZtIaZz3JkLHx/oCCFFywHwGNS8F36hxm030AH3xp/2QXBgEHAjKVEiaT6+ek?=
 =?us-ascii?Q?u+8DjtlRP5o14xUBGG3pNQCmQm0HWCnptR4Ug3LXcLUNGeGEAhDhKu/DG/oi?=
 =?us-ascii?Q?/pWimNs/pFJa5f5TxgB4v8xOL2klENCeL6yUOyEGUb22mMOQVkpqk+0aX4D8?=
 =?us-ascii?Q?r1oAejMCFcR6wZRJSPPDMsjBNfj2kQS2yk9lJZOSC7rzoSmxbYyIRnLCg9U/?=
 =?us-ascii?Q?R4deeeJ+YUDSTKyZBmRVDArGt48QWF7RQOURIsAwJTmjULscs4xd9lKrmco9?=
 =?us-ascii?Q?HvzFuLOZUjH6/275dan0eJpitOPrqyV2aR2RTYdgifEEUoiRzKkdmWIprkI4?=
 =?us-ascii?Q?jAPFOdpsFms4M+A6oF3tDxV9VUCUcoFurJAXgA0VU3XnUiET5BiypgzTlfBn?=
 =?us-ascii?Q?jUUJZf5l/1nxgG8tvl2JPr6BJEQCqvQulG7snepZiaF7qWYiCvcmLORT0dxo?=
 =?us-ascii?Q?B4CoI+WpHg6/O6ryCOYhL6/fGw+PMOJxCZJ1VZLRbl+yq5ATy/yLePEAlOgH?=
 =?us-ascii?Q?X2g9fKCLMmWKJANxkdpyv/w2IBXu0kodVHCBLFuQR3xxXDqX3OOF53+AiTs5?=
 =?us-ascii?Q?5qkH156414HDjFz+3sabRcUTjI37O5t0zVHoWre7dC4+z+bSrzdOEw1E20Eg?=
 =?us-ascii?Q?pl1j/nHQs/lIrmUzETo0L+Dcb3crVeBWeL8ReohMgNiY5vfrBfoeR5mIWZz5?=
 =?us-ascii?Q?bnnNlTnNsqfWgtXkoS/iP1OZ3zB7+b2s1K3DYKArInRLWuRCcW/+F/2Vdv6E?=
 =?us-ascii?Q?bFy81T5oc5GuuD2rMRUYwD5j28a92pWubXz3sx7LPZz6qHrbYlNetuJwaHD9?=
 =?us-ascii?Q?kherh5l/9iSskuOY7hqMOJCiptSwfMGpJhFjSOnyrMUzDwNafcQhg4jHQ6EE?=
 =?us-ascii?Q?Xz9mtj2A9xz+zwkfPttVFDiwnd+sW0kuqiZYYIc/FpxeAjk79i6NPXjr1weq?=
 =?us-ascii?Q?Bojf6b3vfRxkGBxt8dawv6YLQY3QeLr+KXjudlTKkIa33t5QTfWjQZIlcryh?=
 =?us-ascii?Q?q0tA3kvzGJjOoJTEjRoSw1c6CuososrdMmsFBVShjEuQBO+WAvAQwrhIGaX1?=
 =?us-ascii?Q?zOuM3AxdAZ6erbwPNmSUsl/wfg5peU7rmiy0pSVZVZmRTFDyBqGitYEruSR1?=
 =?us-ascii?Q?IZh/YtzRdWQukbH06rKWtqxCJEei6tKOEMPJ5n5FI0fSiGIFGXfTx3piX0ej?=
 =?us-ascii?Q?W3HgciP2QmaLF+ekMMfhK6sBwbMZn9fAA71wp7Lr5XMwzGOlHGEA3BeLHK+/?=
 =?us-ascii?Q?Q2vq9RimlwLLG6ggq88UcylVaFjyCE4HbXh9IbMIEyqm1lqD1WlkDbt2PHZQ?=
 =?us-ascii?Q?UdPUeYDzriI/Q1oPm0ta9y/INQ4W95ZZeWaxNZdtDsMWTvMD3ZHjvOMwWtQV?=
 =?us-ascii?Q?41A+I87g42dG6cutg614x43AEadiUUT+1jh9s8Yhy1CPlFCuw1kz9vFySftT?=
 =?us-ascii?Q?Dqh/qn8cbhzMyLTOR8A7slMmxUg5vxZEwm5i8X0fOe4dnCeHs+8Ijq3TIyfr?=
 =?us-ascii?Q?IahcM9lSbpYEXrmy218EiAy50qx8EZl+vTWyQdkERjCiTy3I+y0MnXstecg9?=
 =?us-ascii?Q?/YpK/f1U56mk1eqmv+iUMJWV+8RdRQZc+bNaR2eJzH7SY6PtdZPFSdWBZ+6Y?=
 =?us-ascii?Q?fXbht1eKTXllL3JRJ2pmr3HdxcPkB+a41rZS7mkLSM6jroNm/vhxwv0mCGTL?=
 =?us-ascii?Q?C9DhGw+EgbFPYPO7ps6cDWTik6GT0Yo=3D?=
X-Exchange-RoutingPolicyChecked: kB0WjpOUp52N96SOfRJnlQGwwY+RXcHkkUytM2jo+COoFzrEiFPRwYQ8O2+zdpdhQLE+mwgMGXPMmsqWkcpEelFu6IIKJfoLQT4w4ZqfOd6yPpJzvyt1yG7GciDytCNPO5n170ze6P3uelY+ulMk4p4tV7DWD1GvbLha+f00rSnrniQWF8mbDCi/Mxc0DbwubxeQBwYmWR3C+UBOkx3fVU8sfRGVyKSF7tPZiI/G7NsmWO4bVgL5CHFT7a9yiYSOEFJ26roXSLoqJqaiML1JuhjsQFkc4bjElpcaewjYY+/uoMFt8NvGHUZf+HdlKUWpgJbQ3xjJpVHVzuBrgvkgIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 368d2e1e-4b84-4e15-67ef-08df2f61e11c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 10:55:54.5918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6f/LSYOH9EkKQezpN/7i3RI5HZUrm6HYJXVL2nOan+MrJHYhWdCQpYcimsk4CMIQUkp6RN1GqljxBMigC9iyKDnZqWOgZgtpIR1EfL/QVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB283782
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 12:30:20PM +0200, David Marchand wrote:
> ethdev now validates requests for VMDq Rx and Tx modes.
> No need to validate again in the driver.
> 
> Note:
> - for igb, max_vmdq_pools is already 0 for models that do not support
>   VMDq, so checking the VMDq modes is unneeded,
> - for i40e, the FW flag was already checked to populate max_vmdq_pools,
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/net/hns3/hns3_dcb.c          |  9 -------
>  drivers/net/intel/e1000/igb_rxtx.c   | 39 ----------------------------
>  drivers/net/intel/i40e/i40e_ethdev.c |  5 ----
>  3 files changed, 53 deletions(-)
> 

For intel driver changes:
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

