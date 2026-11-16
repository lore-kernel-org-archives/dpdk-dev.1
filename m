Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FC2606A332
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oJX0gGEM;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=mQwMwepN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8932840294;
	Mon, 16 Nov 2026 12:23:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id EFD51400EF;
 Mon, 16 Nov 2026 12:23:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794828200; x=1826364200;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ax8fmD/bpnCAXzn2n53/QK+qxgEBgQAODNgB3pG0Ots=;
 b=oJX0gGEMH2C0m3mwFe8ABOK11KDG1YOxEucsLMdvGisS69U3jrtFTnJ/
 vv6XvRRcri3k+b21uMn0l7qWWBslRpsoPLgKU7vSayh0Wtsg/9xHfEmGt
 UZMTbeO51iQOkWHqa5JP4eqVjWS3qLzk0CKqxjNghwWetOUDp31epdjnj
 lpHdhMSLgoBIVSQQf+VoCY4vGaONgn62dmp1TzkVkganN8r8+vmjV+4lh
 n7nDctj/jc5sYJ4TB7qEj9wrtHdQIcofPNE1a4C9x6zuYbepqQhGiN41I
 MLutARSwzWUfdbqfpmuqZP2eRJse4jJvbeqOuT4C0v4KEaZvmay4uQB74 g==;
X-CSE-ConnectionGUID: yEPbCyzeQQ+7Vl+Qhc5Nhw==
X-CSE-MsgGUID: lrUQJWC1S6yzs/tKaBc14g==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3635663"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3635663"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 03:23:18 -0800
X-CSE-ConnectionGUID: PmoqMt6NSheOjtnKoZa20Q==
X-CSE-MsgGUID: yUAufPaoR8Cbf69KhP71Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9658005"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 03:23:17 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 03:23:16 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 16 Nov 2026 03:23:16 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 03:23:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLAV9txuRJ9UIz3rgk6WzwGj30GxdH+FfRABUWhtOmyK2k45foEhvczSYJp18zarBDkL0OFw8T92wQ52DeCBSRkdLumP/tgnurFHsg4EUFY3WKB5GwFpRZCOzxTvG/jnT3LE3fnmxBwXv5FKpTS7j4SYVGzzx+aTR0f6s1GVNBVhQ40oCmnMyelz3YQoTga6eOH+haMn/rR+itZrE7upeZjGC0rvayDAL8b3pyYWBPC0ix3MUNF3azz8631hqUejt6CqUHNkzvSIv1WBQZzf5hzvghWmNCBmqYLIrDvOjxg1HYk6L5stBJym3yY3iDZ0UZntBWG/n/nGVu3ELAcpyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OK2fIb/q4IFuDQL1zToxb4ZNDDHmqZpv+OqmZRCt88A=;
 b=ERl0YFyYZNTjvlHTdE6tEvB6XNE/8R4JHjLSX3IVQ9J5S0IVRwyzqwhQMQnLlB0G1lsQ1h99ufjLUl3a/EuGcfB922mK26W36TKCQwV6OMTcyEs7otDb2J9j7fUqEG/gpr54ILeSL99QsI3NxMl629PaerGiMb+GaWOltjF+DnMcrfbe/WLtqkjbPaeeNY8ufSi+QMr4yqUNl5PiDZyJLccG/+o4m59CwzM3RNuK1tRshWsKZcdlo8iLg/eSK8VnSyOi1AeHBoH/qHEINt1DXuKTNDsfH1U5eSc/z3UVJKCOkpFROqOCsBTKs2Z+R7aTH0snH/vNyMgBtZKY/Oa74w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OK2fIb/q4IFuDQL1zToxb4ZNDDHmqZpv+OqmZRCt88A=;
 b=mQwMwepNJqa9vhs1DHkrpk72lsZ9J2+0ikGfl2Jf1LnJcTHI7EsBYQvJBpWEbBtlG0yKyRXp9+3R5hBq7cHEn6Q2zoy2cSG/wb7WtnX6jpg2XpcRAdQAyrjF9mmzZFCUjKNjTByggSbEeFSXT+joZW7oA56TE0LqAixNf5XvOFQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MN6PR11MB8171.namprd11.prod.outlook.com (2603:10b6:208:471::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 11:22:14 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 11:22:14 +0000
Date: Mon, 16 Nov 2026 11:22:09 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>,
 <vladimir.medvedkin@intel.com>, <brian.johnson@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v3 4/4] doc: fix intel VF guide
Message-ID: <avrnYXzzz_c5jPw7@bricha3-mobl1.ger.corp.intel.com>
References: <20261114075732.183996-1-sandeep.penigalapati@intel.com>
 <20261114084619.190251-1-sandeep.penigalapati@intel.com>
 <20261114084619.190251-5-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114084619.190251-5-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DB9PR02CA0007.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::12) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MN6PR11MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f1185c8-3081-4729-57d0-08df43d3ddbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|261009223027099003|11063799006|4143699003|56012099006|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261021135927099003|261021121427099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: SsVpcRtkf84yQHgYJdH8+zq0xkz7ShawAJLEJ+qNTRRm7hCk/CDR8dkq+V/j3M+H0Y0FIcwwYF3xUx/ZbarS8k8cAVzfmDJf6Mlt8kIN7ui0/38Smh7trMKLW2c06FGEFAr5haGMmchMivdzgwOYLhR7QbnDfKw8U+z/EBqjWSMac0K7/lY39YcJERfgC7usVfS4FYUaFWxI1r/30vsZJN/v7/mWeXNIipbLNSQJc2Osby/Rv+De594ES6Wi1sVCp1DPVbfEKP8zHAGYlvvKsX6nVG30r9410DlbINUsjMb2NKc/r+ugjgj8vkGZjvNyz/iPICX5AjwbZ/iyrAc1jS2jcKTEF/Vv4o3ms4ED3Xr6KsZVvkhtcnVCRQ1reXRZh0rKWisWQ9tDw0vwvXhmCDdTxR0GKsSDbAqS9s9teIIPXzFoYELCWNgqU7oD5T84Waah5pOTipEJ0141cqooYe/l0ieiNpz5K2a0sZmlyZ2wg58FbLUW5n0faC7xcZCLqs8/SRQiBCHlOUQ3wnAutjzYOW7juziWp/S0Nonpz+jyeJ73ihwE9iGOpYGZUZ9tei43GdbrjQEAq6ZU2/J4c2SsmmSMLlWEvhXeP5fjtaCIHuamCkFalEBjxz5Uni6ZeZJa4LFwT+BmXghOl7isOSLXQhVMGzIk3+incUD2B+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(261009223027099003)(11063799006)(4143699003)(56012099006)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021135927099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?szO1owxeZ8tyPPCiwtUgsdTMjauFawldvdFaMQcOzUBQ/5yS+SZb7cduL+wj?=
 =?us-ascii?Q?6EL/+IKdKY5mz0HDgZdja0pzdxF76/0RCTMxDkL2smWFzunftAiVXiXWRlM5?=
 =?us-ascii?Q?XIfaSYBjS5cV/G0NwqXW6pDzeYCYiEItsZQqqFv/JAyhzrNkynHqjDdB1rGo?=
 =?us-ascii?Q?sDSCh1Hj1PiJlM1CdCmsZHu59EBw1gq9jq6V3SZyruMkCS9d5BEG56yCl9qx?=
 =?us-ascii?Q?SHChnfW7PlIMuR3BnED3oHsRvY+qMiUr9nb4tIRu9qaDLZP9a5/HNQ9ZElaQ?=
 =?us-ascii?Q?Byvp0Yy2ui178Y49DvNlcIq5uU26GG/UpnMrfIq/f7ZILTLNFqKZOVOLNz2/?=
 =?us-ascii?Q?Y57q74QOwdWM/PXsndKwDDcyTMoj01iiAKpKWmcG0O5ogTo6nzzePlcOWpya?=
 =?us-ascii?Q?4II6SGROQDaJIFlmFDa2rLCCr4SyQ3R/PSqV9x0HlaDBYGEfJU36Melzw+b8?=
 =?us-ascii?Q?odppYWUJ3JT2qAeLeJkhReRt1lynDiLkscNIqkk5bxZyrwaXhTSq97suJGA6?=
 =?us-ascii?Q?Bsk4qRnzN0nNvCB2T+ivVgIoIpBZEY5OUKFNJwOCOLBLwNmUbpozGjuMWwts?=
 =?us-ascii?Q?xbyek0Ka84nAj3YMguM4pIQJlfje2nJzEduIxcsdzmuSSfq4H2ilDM8cu5qd?=
 =?us-ascii?Q?SoIObr4xjDn34SAMupGQDw5RoGCkMN3+5XCjlO2i3OxP4bs/AvhirFYg6wZk?=
 =?us-ascii?Q?TjfqRtI+4Vjb/kWMKZtZQDLakIbHWrLI67eZnz2UEyElxrB7CstlxqyZixmI?=
 =?us-ascii?Q?/ZNGRhHunWZW9agsGesnAS7ACXb/qcrevy4kf/NPCULmuFv1+g42bPnwZdP3?=
 =?us-ascii?Q?gZodTOAd9JNnt6N2c9msAiAAzAfDpD7s2u4MBcJkaDFF9fgvqpy5LJgWQZLq?=
 =?us-ascii?Q?Enh4pzQ8krS1xB1yiYFHbSGx0kwZkXvLSOwcST0gEy1n7Y9ydrNn3T23Ofmm?=
 =?us-ascii?Q?ySiSWBZczJyBz52bDZJhhTaC/zxAiwc7gdz1tDgTQYj2Z1XsxKCftLqzb7/o?=
 =?us-ascii?Q?da6emkmvNKIOVKdtyxO3AxIGLmlj6Mqn7/ZjYQYQxLm2LrUSWg9nimhykfMI?=
 =?us-ascii?Q?we97aNMeAdXwWlWrujlIy9KiVJ1pcCNgDdrEBO4oUJfcKttJTIjcOA4gBZ3k?=
 =?us-ascii?Q?A9wiX5lfablJdC4eOP2FFpPoOsfSRHXZpqS7g808ysJ25VKPE0bBBbIrGz8D?=
 =?us-ascii?Q?MX0W7OosXBT2bneTL5we9+pFCi6nNmR97A5K0pMFAZ+8QEdERq1z4+ISwABJ?=
 =?us-ascii?Q?7rS6/oRW1r4VKtSYz6q1LtlshsI1WnwrkhDFhqTKNg6+DngPe0JPO/YdMgpu?=
 =?us-ascii?Q?FR4wA2597dSX8wLHceaK8KV44j240CEDbCaPW0npIDc29+JrVR2shpSjt3Q+?=
 =?us-ascii?Q?hY758E+f9ciDl51vuu5Q5h/0ubAwzmaU/TSy/tc5sn+/xrq0zbOCKaOrcc7B?=
 =?us-ascii?Q?67x9kLXwdvX+1bNUsXeAY1Q0pivwMz+773cBh69h2s+1kr2OLOwquA40fyMU?=
 =?us-ascii?Q?OP+GNueuPevm2SW9ddQoV6wN12G/U4wFrtTD8uh1EePnRy9EVSomXXMeJ7LS?=
 =?us-ascii?Q?bDBVByfUAZX4RvC+erP81Fg0/Xe9dj8CMClb2TRMpuOlKHeypKZtTMnt3+J0?=
 =?us-ascii?Q?qvjTE+jVr/nMx1h+MalfoxNakQbKAyXCwEudlclZ18z7LPxpnxiVKCBP9wIL?=
 =?us-ascii?Q?ZV0YYoHbREoa8bujTKhlLhb/GWRGCVo/S4m1nBAaKa6j1Pmk1TcgmbNsyCSz?=
 =?us-ascii?Q?tQb//j1wPlaazrs1/82d+8wmT4FQG94=3D?=
X-Exchange-RoutingPolicyChecked: OkbvPNqG35TpV8T+HdgKsz+u/qvoooDVJfZ/YbiWSr8ojzTUQIhMddkUa1Ax7UBIsan8qRwyS355hHtHAE9CeH0M4pH46zOrfTPhHNn9Ke1dj2AW1jdW3wnL9FoRFUv3Q8U6x/ibksOFcoeu955u0nmv/9t49+bbaHnJH0+6Z2ywfa92+XKrppYJ+UL5kbYyI2VZ+j14ahi489e8glIW+wO9/MUKZF46QBDA6Nra1PFPJS7AebMhfby2V1FEN4KV23vOi7Dp3Y5+O4NyUwaqNUVGTuFA8wHwnFRS1EUyldueJqG69j+1vCGWew9HuTpyCBdej5t8QPw1keYaPdAcpA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1185c8-3081-4729-57d0-08df43d3ddbe
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 11:22:14.8597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MonzCJKgiUdltVjCr47/Er08QGd8IqfKWT874yGo7G5ZzHtqhJ3jhAcA7KFt62gUx9GripofuCuBsZ5RkjPXhPHCJLfYEavwOQdrfNByT54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8171
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 08:46:19AM +0000, Sandeep Penigalapati wrote:
> Correct several errors in the Intel VF guide:
> 
> - correct the kernel module file names in the insmod examples
>   (fm10k.ko, ixgbe.ko, igb.ko).
> - correct the qemu-system-x86_64 command name.
> - correct the "8 TX and 8 RX queues" description.
> - correct the rss_lut_vf_attr sysfs attribute name.
> - minor spacing and hyphenation fixes (SR-IOV).
> 
> Fixes: fc1f2750a3ec ("doc: programmers guide")
> Fixes: 48624fd96e7c ("doc: remove Intel references from prog guide")
> Fixes: a49ae04e853f ("doc: update fm10k prog guide")
> Fixes: 627edcef93dd ("doc: explain how to create large VFs for iavf")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> ---
>  doc/guides/nics/intel_vf.rst | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
