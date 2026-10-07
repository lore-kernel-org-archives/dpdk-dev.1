Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C25CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 10:39:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B890240265;
	Wed,  7 Oct 2026 12:39:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id D81E640144
 for <dev@dpdk.org>; Wed,  7 Oct 2026 12:39:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791369584; x=1822905584;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=z81qGAaPQOJkasCkwhxUvS6ecL6vL5RkmB4rbk5+amY=;
 b=F7VKezIelOBHc6E/mrUxRPDUdzj2HjYn29YTzb5W4EnX3E0sRDRkcVCQ
 7+LF9dHanjVBqPCTEQUDq0tO09xuLicFSOft5LhcKUAtFnJoGryVBrglK
 a+BeGueMCwU8+/40wCMygPsTqm4BSpvdxoPcCVck7Sl3tggQLfc37nSbn
 cly0GQIEzTGOXf9lxLYYTKikjBnjhKgrTcwd3F/+QPT5XKS/KnIKXvO1G
 3AzqyJ7JaONetLQvwjjBUQE5s08C+Gc2GjwFx8aM018dbANKkYngxzIRA
 HFcYw0ttW37ziRtlGfXZKwfhucboABjg2njeMBraHITDdTQoKl+L56vON Q==;
X-CSE-ConnectionGUID: g9X48M3KTSW+InrI25JeeQ==
X-CSE-MsgGUID: Mfq2KFY6T0O7uQBSsQwTEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="136019"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="136019"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 03:39:43 -0700
X-CSE-ConnectionGUID: NCkbj/lNRd2H6Rt70JcGtA==
X-CSE-MsgGUID: ighULLnXQOuKS28v+wFnyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="315433233"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 03:39:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 03:39:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 03:39:42 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 03:39:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKHDiY0gDE6LXsTBHXyrrEYtGgZ4RV9rTfYOn+yp1YmNFnb6jDbSexTDfr8UFPmhFdDMmHAkfU7y4CuyeuAPMmL/cDBEgcnMSUbWisPb5yHVYkaWM4Zz9weOjWqtgx4FFao83kcmNIJ4Ho4/S5kn5l8Z0KqTA0lYxqACZzv5BRZ/IcSeYF9jdePZjvVUFl0yEGI2mnvhtDWSZ7Hk4khW/krLSCs+RJrRJkjVzAq/XMz0MKeaReYwy5J1AlOliXxwpWOsv4b85KOq6Ay+AYVNSHaSDCi/zq8mPQZq15wgpI6tUv0SrthHAAens1g8Ocsy8dtuAcNeTPYMdkM7rjvZ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZOI0racpR4ZfoMG6Vc3M+cqZj4l6ZNVTcBE6s2WNoQ=;
 b=w/wbBSLeDRqEhFMumMyJ3JHYDNmColADFteKVkqK1cAfZhZfOvpmbAJjNHwlkXHlqAgPham6U4T5gf4Tf8l070zVukhrYjmNrQtDnUVbS3AR0pe2iuFse2AJhOXX/y3X9Q2KNjmoLCKFibgVJo4d6SC1ADplDrXqinSpF5cFsrysA6YaydmQzIMuhl9KgJFydWUqfrTV4nFRSirbNeMTJHoyO67NLlSza2CSP28iuIkfSpvhllz5yfFv0XzElM/2Toof6i6j9DozEB9d5ATPmGgFKMHILTk7iMPGDebywSRJSKybtsOBvyiAGJ02yEH14ba04CAaiI75XsTq/NAr9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS0PR11MB8136.namprd11.prod.outlook.com (2603:10b6:8:159::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Wed, 7 Oct
 2026 10:39:40 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Wed, 7 Oct 2026
 10:39:40 +0000
Date: Wed, 7 Oct 2026 11:39:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2] build: fix cross compilation to x86_64
Message-ID: <asYhZ4qBtarVLKng@bricha3-mobl1.ger.corp.intel.com>
References: <20261005125943.678879-1-a.schollmeyer@syseleven.de>
 <20261007092637.916513-1-a.schollmeyer@syseleven.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261007092637.916513-1-a.schollmeyer@syseleven.de>
X-ClientProxiedBy: DU7PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::18) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS0PR11MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c4fc13-14bc-4ec3-8b1a-08df245f4a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|4143699003|22082099003|6133799003|18002099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: 1A1DuxejPhB59V1tj+lLbKdePEOqJURtP8YS330F5FOEiyC/kwpJAt3rJYAMd4CAX2KiZ8q6yNb9yWqtg3pU9T75mDuLaWmdc57WpMLcWBsLPGu1pffgByR9ee9XWpml5v9qthdkZQL0ZH7E3Jk6UgfX+rPCm78qipIKNq2XUs/RVZii/4sbe2oqjBh0sOGJw2LgmJ/NFDHV5dT9TFKENr61v1gVnTU5qxlFLBdihyFobjpUaGpj5cDYWf2b+DnT/+JhRjzLFor8/L0Ozm70rGoYyzaejDy9mLzo67bMFgr+DxwImwNFMjyfFZOK822XxVJARY+7GIimcHqOsTtYZBf+BhbKLsJre7dYrV/FBzEIV4kteAV1i57rAA7fT2xi/GAFB6jsCAOieM40j7OJ7e0GsLbIk9wY2kSZ5eb4rras3W4iYeHv7DNkolvao0Lbzdhr5127v1yaUSz/Yf6aQIDcdH5Phig6/KLitm+btK/uqN2CN2NVegxyoqhl8IpKAsw9NPyt4mDH0fp0uegkNLIRuajYJvr+MHYsaS6tInS4r26hvNHhJoTyMGDXSX9KAClQvCklS1nAZZfrc2860TGioaQTgBGC0uSZ2bJHXak3ZtpS238NZKmyB4mFh6Bzhq3Aqj7VzbbmBAgWs0yrOBHTdecvwHagRHrmGLxf90k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(22082099003)(6133799003)(18002099003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QfZ+Zr+7EAt2meCU7QG4sxQCsX4xkIXi27cDJd/jPhYpr2+z3aLf+oV5a0F5?=
 =?us-ascii?Q?dHp/LXuvC0qFe2D7SHhLcpArocmrXs4KQn8Rnyd0PfbQLNRP8gh2p/wBgtRo?=
 =?us-ascii?Q?gcmDP1DTGLtTDDcMyJssEFmyfAmBjAJfSi4MpJSVrBrfvPrHXNu49ifJNL0R?=
 =?us-ascii?Q?ZhLupncQNzMiVzUNUXDYl1R11SHtdmIvFWO9nrfbWHI4iwVjxm0F0h5sPqSf?=
 =?us-ascii?Q?pw63GpbsMgGPXRhsa2z3Ubfiq43g2yJsue0bNTW4FdSWE3vro88E/ClredDX?=
 =?us-ascii?Q?Equ2LGmrVevkUcYmXAemy6zt/B0A5SuW8bIxn+qr1eLqdr1Y1TxSLL6SRynE?=
 =?us-ascii?Q?OetAvsIaN6nt2/LtfktPEUsmOjCwzGrPItjMG7AUAVu8+5jGMR3m37GkL6hg?=
 =?us-ascii?Q?bOeO+i+08pZZeZFl6htRcTXnC4moaBUSWafYYEyXJAEwP8rCBMbqceJwOPzZ?=
 =?us-ascii?Q?+nzBvPS+gXZz7ti50I51D+hAsD+Y2VdrhuaFcFyQKB3X4j/45nMWPLZVdBZ1?=
 =?us-ascii?Q?/UfOwSUNgSTmZosW2uPDglWIZ4BJe5RjfSsjI1TuxkDHGQOAreR7OO9/ermM?=
 =?us-ascii?Q?IUNCFyOid4GgXHeICMFqt1MUG25Q2KonxzKcep/RltVyaqSOQVNW34PBgIOt?=
 =?us-ascii?Q?fXJ/U2xF825U3ThToOZffw11tpNmZ/3eLRY25Rcvoch+ha48mkFQtCuTjDMH?=
 =?us-ascii?Q?r4ZZ+8R+bvkVqPeSoVVGOqGjHzh4Qe1CV1Fl38nKNhn3lF0XwNcbtZfMEBZG?=
 =?us-ascii?Q?iVu8d3btDSgygb0mPOQiXL1HyZUT8WsmPiicjw3GjeAm4DpxCY7eQY0sEF1B?=
 =?us-ascii?Q?DbevUBCuCr3+v204k+br+oVJrlzZ0kHQH4+lm21+axyN9/CYwMAUYKP551Zn?=
 =?us-ascii?Q?RHJ6zMv4eXUGq78GgIP0btGwp5JYkoxnqIDj4sJFfmZPAIvQEhvzdKiUpqqQ?=
 =?us-ascii?Q?6VKbVxmVbZBEz5bOgcukdvdWm0Syc/CKynEheXSnrULsff90XOM0SRr/yXNQ?=
 =?us-ascii?Q?8e98g7mSPYPD1x9GAMZ8+VLXqDqPpB0LDsiobSM6+/wYTJ77Bre6Woeq2zpB?=
 =?us-ascii?Q?wZuNqvyPPo3FjVRrheiatpTRdGIQRCErTBHCnhJXyz7fSyolEZrDguKiKMr2?=
 =?us-ascii?Q?8U1hNOBo5NRM+btuJyyCPz9BPNrhQ9FDiSOIgwxpU+o6WPRyidnrmg4yQ3+q?=
 =?us-ascii?Q?D4CGTvdaV3jsdvmur6nWNOLjMEdyqBf/y2Pm1FnSyVy61oT/zVqF07Q2o9Ri?=
 =?us-ascii?Q?wTjT70c5ZF1gUBRy4PPLaraaub/BflB/e4xHQu9tFNSQ8sPl1/4udumlUm3O?=
 =?us-ascii?Q?NbYqEBxCmHGEeWcjZYN+aQlvpH4gdt3huq8PXDF+2xmYr8KHSDtR8ETumKBN?=
 =?us-ascii?Q?1MzOj9Scz/CaWA2TRnJRkM2q2Zugccx9VhV41iSLJMY0KK7yY/0bLQRE48Bo?=
 =?us-ascii?Q?lBDd/r6boLn4JhU7dT32c4swz9C+0SKi3nMFIi+VL5Rsv6N3C0VCLxENoLEb?=
 =?us-ascii?Q?GQIl4Mgg5QZJY+gVcd2GLvaUheVVuR6UZuPUDR58l0ADRLcFB9d3zFtTz0uq?=
 =?us-ascii?Q?FcWalFE4LOJotT9ofpw9Wnr6751NNnLtp9Q6jPTA29A7k0QRevPcDjTlgpPO?=
 =?us-ascii?Q?yehKNFswCiBiUOoFNDupKLY+X+rTa1ibsYMpm6zkecXh1vyTE+JfpEZXZrZ8?=
 =?us-ascii?Q?8XkRWfRk4TKxZ1+rgigMaOgmEXeJzDj+QhCmXWKtGF/yqDkD7U1t3ALR8izi?=
 =?us-ascii?Q?FU26Qp08NAQDwUjrWGEIRIf6i6tDUcQ=3D?=
X-Exchange-RoutingPolicyChecked: 5MYldmCgkBeaFN3cN2gc+/cvdeHXmbTfiAErnH7+/9q0UTF5zozlss1SBSpCzdNSCWYWvrJk3tdvrQa4lT1mtLQ1pIeWrunYJepLGcTjzV9z88Q5Epx6G64o985KiIMhb+H/XxXSPV7kslT+upC/3HLhi60fR8eA9BTe9v63Ptw0/qJSI914Fz0535/8bptLA+2ZfaEpV6NZFb5S/6OHiBCRqfyWb23oW1mAPyRpYA5/dpBvBFKUpn31DT5M3h79lBKOI6aYEsLZ23DTf13YFm/P5VTxn6mdouP1lTJjbIMFqJAeWpuIqx8mN42VUpLa9VZssZfA+ULjzU5NTFvTbw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c4fc13-14bc-4ec3-8b1a-08df245f4a77
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 10:39:40.1379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKGaCkE0MnZaykENzn8jHFtnoQy87xoYP5Rzpf2tQYvwd32it0EXXgI6+onguQ2LjsNN8NRuUNH9vX/dUk2O0WpIC6Yee9sgDiZWu3+RHiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8136
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

On Wed, Oct 07, 2026 at 11:26:29AM +0200, Adrian Schollmeyer wrote:
> If x86_64 is specified as target CPU instruction set (e.g. when
> cross-compiling *to* x86_64), the cpu_instruction_set may be set to
> x86_64, e.g. if it is derived from a Meson crossfile. However, while
> Meson uses "x86_64" as name for the x86_64 architecture, compiler
> options accept only "x86-64".
> 
> Introduce a conditional for handling this special case by changing
> cpu_instruction_set to the march-compatible value.
> 
> Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
> ---
> 
> v2 changes:
> 
>  * more explicit comment about GCC/Clang requiring x86-64
>  * switch to x86-64-v2 feature level
> 
>  config/meson.build | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
