Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CCCCD6E71
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 14:38:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 187AD402ED;
	Thu, 13 Nov 2025 15:38:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 290A440151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 15:38:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763044698; x=1794580698;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6PAGROs5OiuIYkGmKVFFLaoy6ZiYEYwlM+bN9ViyQuE=;
 b=Db1ovaQIIfwNnKkQVFr4U5BOZVO1SbWOG6rR/0z5e3gOkVEKKGT8Kflu
 D7Q3p4jeoXF7jEkK9VbysFQZEvCxbpR4WIsoUUlxRiQum5fGZdNiY3ke4
 oWYY2wpwLUMEapWvAiUthKtOipsJIRgIzmxkcqa/nlJkkkIF+m4KWi/uA
 xxD9VUBUMYKSVwCtv/Ldg4BdGDqm9kejK8xpPV0m2yM12iqPWWHZoGKtP
 KYfVmERsIdCMwDLPx9/G/GyjsSnxCjzSbdA2rtkCFGvOeaIzwfm5UFrEf
 0r4dyd6UXabPf9al34j3GmwKncwozFht30yfRN43UPfi9A7QzgsuDA/Hk w==;
X-CSE-ConnectionGUID: 2kqbAkzFQR6pWiUx2AOr2w==
X-CSE-MsgGUID: 8UZgsaG4TzW8S/Leo8X3Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65283163"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; d="scan'208";a="65283163"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 06:38:17 -0800
X-CSE-ConnectionGUID: WVhdoGkUQYCXWY/T30a73w==
X-CSE-MsgGUID: KMYaz+4xTk6Hnh89Gwgk1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; d="scan'208";a="189786842"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 06:38:16 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 06:38:15 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 06:38:15 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 06:38:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEUaKrhW3mEZQG29tFWkCZimiP6YDW9/ZrkFgWhlaz2VR5yoShuDTH7vPmVQ6eX4I2lSxIOKdh1cu5doZBAueRtT8M1MMgPPULvq+1tVetH41FSGTPI2wR/c/ZMHl+/540V94vHMqXP2fBEADs1kwWi05tl3FN+g2cZMaEAwksCKpLXOc/9aE9qtayp3A8Pqs65vs1sNDHLfnVsfAAuYJz4kWTizeu0DCiZjEwvrd0nJrsJVYNhX5LA1Dnuaqr0uToxhhsdhdRja8QlCWQRtSb3MryBPA4dVc7ft6bX3orrIOR+Wq311w81xsJ8s6tmDyQoZzFxxCLNvPVZe4hD5Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zFsBk6ksNqd34cWVgvtB+kA1Ypd28GyGFWi9Ohvy5U=;
 b=MPKj/6u4NBUgGHA+FIo3l8BkyxkrMoq4mlOF/pUvAFp3NYZHzlf+ooouOWyws8XEBlNu3mSllhQKzOKBtKUYhB9Erua6Y7v/SNlOAkJyPLiJ4j5Xj20q5U2dXbHIr98yRaMZf0cdKaugrPwJN1ayiUhsIbB9yMp+8JWZc3ZE3soyewFpEGM0gkcWTuR9XnIVkVMIFMpupktPY/t1X9EeiZGXwkJdN53X6+Fln09/1hNiqzoJLLimFQO6v9GaVEwE+Y/7FjsBBW6rmK/EYqqgalxcIdxXvXHBKt8H1C4CF+iR3ZJhqBM5bsiYGQ2dmWW3/v0VZ3BlAYxPJ+AvEzlK9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 14:38:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 14:38:13 +0000
Date: Thu, 13 Nov 2025 14:38:08 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>, <g@bricha3-mobl1.ger.corp.intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/intel: rename variable in Rx select to improve clarity
Message-ID: <aRXtUDn3kTtVA_Zn@bricha3-mobl1.ger.corp.intel.com>
References: <20251113103012.3782264-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251113103012.3782264-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0147.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d934d3-f599-4342-27e6-08de22c24639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fW7lvvL/jOvmy9Oefih8mJaCN2q0xJ1FAfappq4nbr04g+ucbBRgWo5G/ck8?=
 =?us-ascii?Q?uHmQsHRIh4oeidOU+z8/hFxfw5CkgCRdM5HBlAcc3JR+lbpHPft1bbkeNAE8?=
 =?us-ascii?Q?kUrkmRauDuYJ+eSa0iKMbrcfB9K1Sb6CxiQqXUCPyn1Qe1hau+/CbPaIf5n0?=
 =?us-ascii?Q?j9HsHgHOJW5WDhSo/nn/i5Mwj4f9/nSvotfi7UfnvfL1EA7YR180mQnPILH2?=
 =?us-ascii?Q?pO3gpiRKkoaDg7KYsdNLTYC+BGiH+7VWXl9UOOckrABCt5IWZFj+gw5o2YjS?=
 =?us-ascii?Q?LUvlubZjfBxqA8FLlOHprtCtX+7MQLSijQrHOpNRWqGuKz+Qce9k2yQH76Ey?=
 =?us-ascii?Q?ocZi7fIAQccQxxu8dfYWoORj6DWT60fwDb3/8txUOdXLAcLCGYvaT4qy6HRS?=
 =?us-ascii?Q?ErSBY8Gb7nEoMoHCwFRf4Y+HybRODNDWhzyt85jMXL4C4RIYFIPgos80ajWD?=
 =?us-ascii?Q?7h4rYqkA+swjMgmrDM9uga6mPqLJBDC2q2hYNTHmKQk9GqZ8ZV5Pz4COIN8A?=
 =?us-ascii?Q?PrdDI7sGeKPO9ttkKA+Xoj1UQTO51UPOKaTaOo/RLT+7jH6N6YRfGzU+EVcr?=
 =?us-ascii?Q?yd583iYs0am2OtaSkzGZBYFGU2snuQGJWNhnsodSaCQZq73J+1VR5ZUqhjh0?=
 =?us-ascii?Q?MVCS78kc/QV2t+wIijPErbQ914xmjpFtSEGOblMHx8MdsRpPv4k05BbmJdow?=
 =?us-ascii?Q?IK02eamMkeBI9s1IvfDt6P6xyF/JmK3fZJYZ+UVDxB4bDITY2fQvLTMMheZL?=
 =?us-ascii?Q?CPMpl1eK/z5mcCG2m+PVgIEaOadXripe07ySC+kDgXTaIjY3q4jKd779BEO0?=
 =?us-ascii?Q?JjbQiUb+q5XG+Z8ZxxoyEMNJZfozz67UCgxRZPhCWdFvx4SLrNaFgvw2kYZb?=
 =?us-ascii?Q?u+mDeP5NInvAxDCXRYgQOFUEVmsfQhIPvFSRNACKdUTGpaQz727CVZ0xm0tk?=
 =?us-ascii?Q?mHixhEm2Cu2zT+ia7M0VQnJOo7+OyvYqXskI1C+Fol52mvV1niSerMRMwdJB?=
 =?us-ascii?Q?Lzkhf9y+Fa9wD0KQlzFYL09g73xA/I8/R9D5iGYQXZQMCRpKdxRoweGuJBoN?=
 =?us-ascii?Q?A+CjZNBz/3BeEQbqQXz4RvIo6IvR4u5EkicknmPJAyn55Q9+AisL0cyAK7NA?=
 =?us-ascii?Q?TT3ESapqDprMmd+3RvRH3jU/EwqaiK0H+5FSG80mFuo4PL/yxFhn2FH5+hPo?=
 =?us-ascii?Q?C7/UP99kyhyYDpJr7QNn+OpReMgoPPTbo3sT0/MnmVVd5JgnbLFyOy8S0Tvb?=
 =?us-ascii?Q?12Lgzo6I9dYyxNtv1FAw8lQm4YjoEPeO5UBhTgZK8Ium+Tr0BH8Ymr9pqFgB?=
 =?us-ascii?Q?hRthxfhR9xONtNzjYrWOk5h/1ymJUG3q977zR4hEKqnb+e+DpNYg0AsW78W/?=
 =?us-ascii?Q?rWPvefeuWxSONvtnXw+rj/977BoKBeq5eXbEh/2zDHZBit48Ip50NDNj4EOY?=
 =?us-ascii?Q?qDkwZq49KYx9U02z28zzBWRywIniZ7xZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C0VoNsVfY52NgsW1yRFkdlcf3LdjjuuDgwXQ1neZ1F9VdWT8g18jSMBurTLY?=
 =?us-ascii?Q?BnYq4smaAkwY/PxKPp26LS2gbgssiN0GEfvrgZ/27WTT/72uSXYbS3gIp6tf?=
 =?us-ascii?Q?jysWCLFH4ql9K9hBpFCNrlRKGD/1WH+MOEMwCPsQo5RK6bRE5Tn9d1CMo6XT?=
 =?us-ascii?Q?khGvTCMmBswylrsFl4naavwsRjROZAsAKa3uTtN5GDfylo9JguYg70sTjEae?=
 =?us-ascii?Q?oHBLVEIpJ9Y8xAJ5U2p5qpMEXawg3w/2FJJTBu2FxaEjpqFmu4r+RAEtl/wc?=
 =?us-ascii?Q?6LRvFEU8+N5/ZlzsGbE8QGdFI6X/7EkPg2LMnuljDQHTuWMosYPyU9ltumqX?=
 =?us-ascii?Q?IcR7KddhXI4IXCyy7Qbe2V/SaSIqS8MOFuBnX4Inrm+FCWNEjMR3INldtiGh?=
 =?us-ascii?Q?XbBD2Ag2YJ3KDPvkwFXc9C36odmwJpAf0bfND3fs4JxC4IHfYHe9qMeH/OC9?=
 =?us-ascii?Q?aTOeC8EegRY15JoRx9DHYzomp4hJLZCFzqSv7BzxVAwpthueu33bbh4fdgG5?=
 =?us-ascii?Q?DbRpn2mAsyNsls8KJ5qTOnaZw12lxL9g2TRY5HX2lsXUgfMK+0B1OwuMXHQY?=
 =?us-ascii?Q?2GvyP29XtkA8Hk/brHpdnOJdZgVlKCO3sy7aw8upYtiG3yXxVmJCF7fUBhzT?=
 =?us-ascii?Q?vqegvS+/STX7sAm6RaHn7unAWy8ETrsqjFjvP5umXmIt9KiqTBDi+Yez0+ng?=
 =?us-ascii?Q?XDDdueaCmQ0kBi2CZvdK2G9WJKSx5Ugdb7tXwerZOsJvUF1PCcJlgmTovbAT?=
 =?us-ascii?Q?oeLstMF1Ywn9yjivt0UkOm+BRglAgsiIM8XLLCbHtrETPCyZy5IjsYwKiotI?=
 =?us-ascii?Q?kwA+MBZHLoVC8Fc1ljM1O7HQX3CBDukPXNPYGv+wpNPmAxjvSz0STo4mLlx/?=
 =?us-ascii?Q?8hhTwAyhne9G1aztDY69JyiRYhV5OtpxZDPp63li56Yo/8a+ON5UmZfNGMUf?=
 =?us-ascii?Q?1zFbD9XyiSYFPEzsKnPGwKMe22HGFn3dkUhwusrxaOtnLU1WTC5GnfJ9MoCZ?=
 =?us-ascii?Q?tddqXHlZ+MOn3Xh+l4lo8iIn/RLDNxYt/Ip89lp51sRg4D1HuRHfh1Eu07Du?=
 =?us-ascii?Q?pDxI64bv344tgS9SMXHSSZrqHHl22n/AbVkk4tQpS+o/by/M+aKcC6e8Geu6?=
 =?us-ascii?Q?0f1vvn8ONo0Ktb54o/5TwXXHpihUXd3MJByUctfCyFMlk8hUcoWmZoFifzS+?=
 =?us-ascii?Q?dfWohHdEo5P10IWS8t2zSv/MhJFKBpofIlUVicGd7nFtrJ5xoDg4pcA2ni2i?=
 =?us-ascii?Q?YuINqGBygj/jgwDMP4znYQrxZTg44kOOurz34aazsTJOV1ZaAXTWsBA/n0Qn?=
 =?us-ascii?Q?CrkUET96ATqnxR3ck8DNSDbt3vtN3V0WPhlV9oK87xrcdvbfo/XT70LzIZ9v?=
 =?us-ascii?Q?2E2YRSJoby1h4Cq+YZNcYCPb6zNvIItHRP5qwGp45Su+c3EnswSVFPGAB02T?=
 =?us-ascii?Q?pbJu53Rtr6/mj5I5BN/5/yTzqw8qm4xg1eZcWJAj5KPk/kGYh5KK1ODNf+Uu?=
 =?us-ascii?Q?yneAw7fILhh/m30UX+dQIxMVlLPiAY+vBIQmATDET+OsDb9P2b8TtVTrVXOW?=
 =?us-ascii?Q?8bxRpe7alSjLhaOq8OtPgeCsOKvaeIkXciNPZZMpVW9CWUXq6ZAZArw4ripK?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d934d3-f599-4342-27e6-08de22c24639
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 14:38:13.4241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/gRpuE58HiiTIL06hQmnWz4fQeV6q9hevEopMDYiFUKFzxDEnS3yqEq6R5kz3grOdQ2B9Y8pBU397Sk8rA2yBrRx4yTNnpzJ1OHgpLHlwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5925
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

On Thu, Nov 13, 2025 at 10:30:12AM +0000, Ciara Loftus wrote:
> The common rx path selection function contains logic that compares two
> rx paths:
> 1. the path selected as most suitable so far aka "current path"
> 2. a candidate path that has not yet been selected aka "path"
> 
> This naming could cause confusion, as the candidate path could also be
> considered the "current path". To rectify this, rename "current path" to
> "chosen path".
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/common/rx.h | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce
