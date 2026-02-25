Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B4EFCEE95
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 12:09:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29FBB40609;
	Wed, 25 Feb 2026 13:09:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id A0CFB402EE
 for <dev@dpdk.org>; Wed, 25 Feb 2026 13:09:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772021369; x=1803557369;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=iGWH094BVu7Rmvm/GaIK/NA+PIZq2rAb3GUNmOAEESo=;
 b=V0v4Zg2SI9fjagcKX32/JrKG1L0uPYxaZrJqF3tJ+VU46stHNIhywBMa
 36tW2Q2LATLzQoAZOUH++cvzEQ6FLSLE3YKtUvrP1x9s+B94FrSVCEJVy
 isJmsFdCSIZ3JR+skpzASOxE8K1g1F8j+7+k9EJJIQwzDmaKD+r6IUMCy
 R/rExA+WOsdZN7OJo61Fru4xNb6rZUYXzON9kn3zzkO3r3BmkwJwBckjd
 AD0fKjZgjHvy9zMuJ6iBpAD4wKad456laHGDLZUpJxO5EWbx0WAv+5R/+
 Q28KFcGGAhGFfi0xcOrX4PWAA16JxyFhFJMV2iUTJAmouIOYuiPOqmJrl A==;
X-CSE-ConnectionGUID: 0CMiCIgjQcWZd2Z/jIxb1Q==
X-CSE-MsgGUID: HVDSNWaNQSWDP5cpaHFvTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72095555"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="72095555"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 04:09:27 -0800
X-CSE-ConnectionGUID: VIFCIlZLSYqKZD1FiWZcDw==
X-CSE-MsgGUID: dFTDe/9MSKqKIEwghWZy0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="214512787"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 04:09:27 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 04:09:26 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 04:09:26 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 04:09:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KX0LRyMEa4jq1ez/CJLG+Z+HYw3oZAct65JehgD/kFut0SN5zkBktnKfVhUKngYLWJu4aEa01dc1Nq8kzLCBTBv4rTmiClAa7ziuXWxCi2dVDrooddXbh+MdGaR2CeoeXJa/Vh66jz539JCodISvvqAUgC5IRTsZKFetybel+njwoaamDeYH3qonkFag6W3RFhoGFVHP7LPoQn/ykbr2L4UBOgAIJ92wTviT7L11HJpCtKvt3D7ktNtaAvIJCwNW9rp9fnuavLrAQXmRaSgGRpZ9AbeRD2LdKypUhw5rWjVPBd/hSXq8td0zL3fKmT+6FAtJVT1++iFJ4It56kyxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVkofSXWEoFvx1RtgQh+l8up/J3L+XncPqe6CGExsYw=;
 b=WY12mXS3DqJZzK8CMVaXviF3Gj0jlavqAacVm/PZbz5BVmJNlAPR4IhcNc8tMZzrexr5a+O4C60/oKM1iYlKzPyd0fulKgOtiFxzyQ1IWsmWuM5DVSaHzFGQ73+MDsJMsIqs6u+5u7OurTSpicQGgLUwGzSKg2PCQ2ENyHDGIjyoP4UFu2EMh1jiAnmU7Ur5cf0uY7lBrOnmlOcyirzFOtfPWbQFUR7rxbW+kJ/vYp/elFgc9Sp3Wf1B8DAOXxNtBgZzUcJRZg/rJHm4PukM6jA73gRK+lAoPipkvHBXrmU8Fm4vCB6pS72Nrwvs5D9/TdFYFwU7UTEyZLxSz3+zjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 12:09:18 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 12:09:18 +0000
Date: Wed, 25 Feb 2026 12:09:13 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: Re: [RFC 2/2] eal: configure initial device probing
Message-ID: <aZ7mabhJYLYiWJOu@bricha3-mobl1.ger.corp.intel.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260225112922.3982104-2-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260225112922.3982104-2-david.marchand@redhat.com>
X-ClientProxiedBy: DU7P250CA0019.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a9cb5d-456e-4ee4-a0c7-08de7466b3ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: sJG2gOlC9ftSLcka5gpokMwfCZC9YIalaKzlEMR3B/qhfhGfEL42Zcem+uQDusxayRYg3zSaIdk2ZKIA8KcQIP2x+xw+p+hXWB9mIAZ8J0aM/NiB5g3XGNNt+GEyMdTitDLGpvaPMBcnWc+cz0QwGRvchYE+sU6g/O786+5rCzkwk7xri6PfPD6Z7u83qFYs3zm129smPqso5su41G+OfnBLoL8SJeahxaOr/seg3PRZOAmVrsVMdvc0TSacxf+qv1sVlnd2muY6AyGInw3ZFK+YQ5zjqmgyB+sBpIwe5wnveon5eXEZiqYNdT54WRh9f+VgtHXgdD5rHawWMOqbQFPw+pGi8pD/yEbdennngqJFbvL+/dUZC6Kovxexvp8MiS0xsF0xORbIP7eE2XocKSlAv+wioimHlZsU+O+i+mGJ4POdLTfTYDr9AXghhaH2VF2K6QRG8rSvh2Wh3NXUu+3G1Vgwwjmykq9EMyr3td7fwJKudJ5l2gU4/FnoDwgpSz4JN3j37scu3mFF/1bAh6MPiW+TqKKh7EPAmKSGjNWKsDaZFwvjbx+sVoEz6/gUf2y50jKtryZoRnfAS/6qgI9uRVupqIq3AUoOTUtz1VjWagZ/LCKwgpRsRqZwFR8STX85LnWkrmz4+cVZvxVpe27kr+UFqmP4eNSHx6i3nyA/DN8E7N2eLcs7rEZvjS3FlydbPHl6f6mp4YTlcEQeYO2yyQaATNMIOYPVc/W9x8Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0nse1skHsaZPD4vCFpBwmMIvdjbBSfQIP6X+/+mEO6xojZFuI74OsXSK1oWN?=
 =?us-ascii?Q?sJjJ/KFaC1+pZ9SXTR0OkOaYNCghYZusZxOgDZU7g/EcmIgQ67rQBBcw0c3h?=
 =?us-ascii?Q?pJCRcSLOApjVsVoL7EtP/H5t8q6NragBTakBOXpv0ObxcX1oKtzp+u7EFkRM?=
 =?us-ascii?Q?xLr8i1y+0vt8wqqH57dlO0VN7OCcifx3zxZIecSPSsTjjSg1rJzqBxQqzLSW?=
 =?us-ascii?Q?mZ5T3pfzrpd21C6NZN+yknPLzUmEPh4sf0YWhzlKeRyKoV8DhkgBvQy8fTk5?=
 =?us-ascii?Q?41lsyeUGd1N7YpGaOxYUsD8Ku5jROfnoh1lXtAqEjQVLWGD86GahKm4hhwl4?=
 =?us-ascii?Q?IRaySeFdPycP4b634zPm4ZjQyZ6Lh8sM/OyJWr1F/vmjIeUIxYH/PXbPI2IH?=
 =?us-ascii?Q?N2BXi2tbOpTQQii+OHSrxCz/1AHoyqM9F1K9eEqASGo8baiuxCGCrBUsjP0r?=
 =?us-ascii?Q?KLH8w67E8FmLVbXj03UY9YBXnAhLk9aaKSrFNrPcPGny5O3qeItea8PZbWhG?=
 =?us-ascii?Q?l5kKeVcBfvfYqpT3NGNN9WeL1AnYSqaFDKX0UCx8D4qkWeVZAlocPVOAlt+i?=
 =?us-ascii?Q?lli0rqu9z8wIyZYsbMJTgfb7W/vXEmDweBj7tZkhZXnQ5M6G9h1bgyKjG8ai?=
 =?us-ascii?Q?5xwWuFg6LnSnGwUF+nuKeExyv/5nkWOtCSgEVy6AmJFq8W5e3okzKRsVLeF9?=
 =?us-ascii?Q?H23AnJA5Cd/MPmUwA9Wxg6FX5/nuM3b/zLJ01hHTg1odHcu3CiXSds8TJrt9?=
 =?us-ascii?Q?jCItIOnLellIXkQUzea3331+iXpZFw8HEwLIJ2laUfctcBEG2VlKUunCcBKh?=
 =?us-ascii?Q?JeEkUfukJM3681cBCSSfbx4ZPNsl7lRxvJfzhULEZ2/WNLLExiWqCUb6G6Hd?=
 =?us-ascii?Q?hUYGTisUeEvndtMh0WwnIpAZYM0Eo0ZbNlkabXCCe1O1RolItzILF58VOKrp?=
 =?us-ascii?Q?33QpdCt6a5aZr4McJP3lQa405qgbbg+sP9Lk7Lo5zgBLP7QsgOqxh/Dy4jS0?=
 =?us-ascii?Q?/rDKS24jVUAdvJNjK9j1uAfdz0BFkZJb7DhY4eaGVrO0YAkCDod6gQZJZz30?=
 =?us-ascii?Q?P6ECevio9rTKmwdcK8rMw8I5JCl1qK8YbyGCPfNB6AtUaS+/QI4D5OUVPkyA?=
 =?us-ascii?Q?ohrfTDmbQ7J92W4p9lLi/Yhf5dAoLWZt4ZHYnhMvnv9LB6yDWRwazWS7LzKJ?=
 =?us-ascii?Q?BBqEt5MmuTz0PXIaAKnNyViAmsv6JFVs/V46JBk7LcOUZlDgCB1w1ubKMYoP?=
 =?us-ascii?Q?rOr5PHXkxqM2G861hnZtUwtjoKKpZAGsDfBxDcvNLi/qJ1U67eDB83M/v5Tk?=
 =?us-ascii?Q?Wj48X9WcX63rKkxx0n/NcwZZ/1E40uWhQpaSp7zZYZj76WxHAGKEd18JeYdb?=
 =?us-ascii?Q?XTvDytdc8yMVsVRfCm5sCLDbSwqyKJH1x8/svASmaSdLEhQOD+1Ax8K6WsiL?=
 =?us-ascii?Q?JdjnNR6D4FjyFFif1Im+kdBf5ZsymP4ykRWPQDD7pOTquSSYp7UNU7rX90sM?=
 =?us-ascii?Q?pbEBTJlUFbymOIHEP2U101VFLMoopLBAmuIwlPqVlGvpjoLAf4pbOWGSIeEL?=
 =?us-ascii?Q?I1wk/XeCHhwgsSOG18nikh4omTuAWo0GvAXgY796yWGz1woAJ89L6YHyzlwu?=
 =?us-ascii?Q?j/w4lhPC7a2OlckAZul+uHZlZ0+Mqd3rkahVsj+WkG2WGTcNqTrn57PZEv6Y?=
 =?us-ascii?Q?XQY3T3PZgGL7C2rs/TOHCCx+8ivhjB/La4bNmO21k2N4XS2qNhY8cky7/CKi?=
 =?us-ascii?Q?hWMIDw6IuxuENGmpJFAjczhO7PBb+u0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a9cb5d-456e-4ee4-a0c7-08de7466b3ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:09:18.5388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+6Ej5iSchc9ljNuAO7MjHED+PkxXd+uv61Own/1RsWmkoapcBGNPq6uVF4BSwWUbbHRqQZ3lKxi24WZKNq3AZVoKTEN85bRVPfcJKhVE9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5772
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

On Wed, Feb 25, 2026 at 12:29:21PM +0100, David Marchand wrote:
> Some applications use port hotplug as their primary way for using DPDK
> resources.
> Having a systematic device probing is a problem when not all available
> resources will be used by the application, as such applications won't set
> an explicit allow list at startup.
> 
> This is the case for OVS on systems with multiple mlx5 devices:
> one device can be used by the kernel while the other(s) are used by DPDK.
> In such a setup, the kernel used device may get reconfigured in
> unexpected ways and trigger issues like the one described by Kevin
> not so long ago in bugzilla 1873.
> 
> Add an EAL option to disable device probing, allowing to select per bus.
> 
> Note: the current implementation does not take combinations of the new
> option with -a/-b.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Wondering about this problem and fix options. Rather than a new flag for
no-probe, would an alternative flag to switch the default mode from
block-listing to allow-listing work? 

Right now, by default, EAL probes all buses and tries to take all
non-blocklisted devices. We could add a flag to switch that so that we
allow-list by default, which I think should have the same effect as this if
no -a flags are passed. We already have support for managing -a and -b flag
interactions, which should make interacting with the new flag easier.

WDYT?
/Bruce
