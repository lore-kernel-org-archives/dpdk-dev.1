Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E14EFD20B
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 09:05:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B05C34021E;
	Wed, 25 Feb 2026 10:05:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 74467400D6;
 Wed, 25 Feb 2026 10:05:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772010320; x=1803546320;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Gt9AEVcEChnZlS/iZWJW4VZm/HOGWmKiNLDlN8DgmFM=;
 b=Dl6H0kY17xzgd06i3R/MXiY+hseHQsKSByHYOVfkgv6qc3OrtKFMT8Fh
 /ES6jLMO2kyT/QZrZ2xkmklwamSH5DAgEsfvTCVDxNF2Ya5haSJ+c/6rc
 xnsiYxOhf2lW4fhp75fb1bYsdUqqiGoYHDyte1ifxggPZidgBfkXQfysI
 pXNr4IGg6R7y6BHXJMt2MlNcZ+5HyWxivQlnNxS8fxVMc3L/2PIYKUqo/
 3HgGqIr1N29CFjBqx+AQ57JIsMM/ChIP0HeRzoo4tevMNx47htJXr8NAH
 72enSGF93aciFRb3N0/QixYdoQnjKKcMKaEdsgIInNMcZUnRLBjTrPbJy g==;
X-CSE-ConnectionGUID: T0GJFbFYTT2HvZ/l3vnm7A==
X-CSE-MsgGUID: P0Xka+87TW6XCq5mutSOrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72948911"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="72948911"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 01:05:19 -0800
X-CSE-ConnectionGUID: MywDL7BBQ+iqnO8jp474Lw==
X-CSE-MsgGUID: CQV6a+5jQO+KzFHCnfj5Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="214483734"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 01:05:18 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 01:05:18 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 01:05:18 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 01:05:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l35Deo9sLNVc9+fFCC/HQqC7RLlu7rGx602NadIoRN8OmSRDkSISPbJOtpBDDsMhstlJ/bmvKpIJpZTZX1AdG/7F4G4abZl7Lg7K5+gJgn9C7GeKDop+O87z/eezbR1YJUmhN4nNEmt2tBjpHNacq/WQ62yPYbAmwM0FsD+eSOQPgYMTU8SQDARai3v400tWJilFEjkotc4OfloYy9m+gu7Cy12RSLX4ZhRhMEk8p0YEYT1NiD1QvBKVUy24fCdeyRmRQXEK1ipHltVAJpr9RlErEecQ3lBJHysAodhq/4Ska4/N2qp4OEpjipNtUbwraUz0gT4jq9njIZv8ZUWdjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBPqL5QjTcd0pruKuSdPld/K5hc6I60TGqhl2wtsEP0=;
 b=erNx3gjM5ArbXxZrbEvWCaPFLraBCUmrPQ8E7ZzPqIfgRSAmWpCkmckQnDGlKAc5GazYduWUDFWKOq8jLAWbvKEGmVXWCqgvdadrgFOG+KtHopQaeeopbw47JBf4A2Zn+gdmkCVUj2OKp7JVaR2pPWyl7RJ9tzgMIHmqBOBemYqS4UIpxaTR/YLNqQ4Dv4tyiTVQMUR8cGnKhI43DWGfRnMENeIAM1+OZZHBOTOKpbHrPdZ2YApL9VmMuDgdazGbeDmDXGG/jzx8Bx7SfbuR17Oavj1eVus1EQrz6eftPWxTGBKWQlowLJ4qjmZAWRX2mTS30iyNRsmedCuhaa6dzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN6PR11MB8218.namprd11.prod.outlook.com (2603:10b6:208:47c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Wed, 25 Feb
 2026 09:05:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 09:05:15 +0000
Date: Wed, 25 Feb 2026 09:05:10 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/idpf: fix typo in CQ scan threshold macro name
Message-ID: <aZ67Rt3Oz9kBXUDp@bricha3-mobl1.ger.corp.intel.com>
References: <20260225085333.2740447-1-shaiq.wani@intel.com>
 <aZ66RPUsOpEpq1MU@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aZ66RPUsOpEpq1MU@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU6P191CA0062.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN6PR11MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b4918f-01ca-4b2e-1a72-08de744cfdcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: Vdo/sgZnTOmBRCBZN1aEjHq6w2oxxauljWLU4MjqyehqIe9iqXDTWBuDGO5tDrgO+BESMdg3Uu+re5IvEL3kD35lN+V4/H9ozQI075fbvfitXk/1FNk7m2ix7gfHhEeAS9Oks27VqMgOn9R9GbPAwcEs3zP9fh2wvChvuIs/bkbUQ5SXnUE3XmBA1NXF6bijV6hkeu8vF/JQv0RMeTnA02iDKj36ovbvXA1C0ZPHizwt/Jao6XlwceUSFeGAbFgC4DJSoXogVN8bjx+tCA9Pj69wAozp7cNI2PEw/0eA1qLcg1DvGRu0WBYOLRNpj5aj7nsAwlhVlWz1+wscXd7mr+D0A+gXeFFx347A8tlL4tUDRNElpBg9huOTKYq/4KMuVxqrZyQfn+NKvZajpT1xQG0CFajtD5yEf+vVdHod2iWeYsqfwod2v/JPartd8OmHcDoX9GRJDw2Bt+wQfUaEIM+oWQT4+H20uNjdObxaJqFo3DGsxSVxO18P57MuQsPptlU7QWStqrrKzdfbuBx/jJCwVIYksDIEI5Zn485U8WEJt9JPLsqRwIIBd7Dm51gmD3YotpRHcLu7TMZs7AuVVcnbNpVGl4xU4IkQZ/pCbhxzx/ZMMwD9aMy5PXRM4HJRBlac8edFrHLL+UHZaS6bCnR4YsNo1Nw2bd5zp0eWWq5Hhdp/ZbNANw7ecvfDfADgo72MTHkTFp30EjP+1XX3UUy+dasohMEUAKPkhIzMnYU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ECQhr27Gyg0fr5OHFqCrdqw4g7MZvDCckPqGFGkOzDcxU4zVBRjglARF86dG?=
 =?us-ascii?Q?CJRVB1RV8XQ9WeaT1Nai6iKgRObu3J0RyQqUbRGx+rLqVAw5OzEZT6oNpzqu?=
 =?us-ascii?Q?CqFVObFWh8++zhHc8ZS+NCuWq/q2PDrT0PGa4P7wTdb3Gd41VdTeiuwYoljU?=
 =?us-ascii?Q?BDDEhchc9vNvrJy9OKg1vwRlzKZs7N1cxDbeBCs58ZmKV1yp4JDep6bgjSWS?=
 =?us-ascii?Q?aVxk7evMIg0ktUvLSLcVeHF5VkReOdR6UrFuxxKui0VcPPZLkLXBN5taLdQI?=
 =?us-ascii?Q?XN/4vfKR0Y6j/f/ocK5Da8jFMTseLdH4ShMi2qG8JV/Trwexgbdjp6gluFAA?=
 =?us-ascii?Q?WIAShtgUbTp7xH6KIx3cEVyKA94yeVafYWW3/cXs4ssxMAqCildjuSmQTWlw?=
 =?us-ascii?Q?/D6fO7NwhpcDVAChlbTfmA7DZRCWTk3DgFqJ64Yg7mklhUNHKSGW5QrpTb3O?=
 =?us-ascii?Q?py3Bv9qlJNMXXak5P3kai+TAcCRqUN8RNsQ+X3h3UIfqYcIUqg3VguGIXkxo?=
 =?us-ascii?Q?g1DTZJ0g/fhgmNC0IssTRY0eHZR7vgDUP+HkNBbRn1UEvTMuy4+VMWmdlqz2?=
 =?us-ascii?Q?0LHjddEzmZZwogaThPmYIae0rdgH20H6VEk0ji/lOMcu8oFvt29djmJrqSug?=
 =?us-ascii?Q?8cvAAzJtWgMJcqI0PoNfifQNIQhXDOd0WDrcxHOwqtlzI8/UjtP81mQP0EB0?=
 =?us-ascii?Q?YF6k6CN8lzmMd2DkuWPA1l27M1RrtIvWj9LFEAhYe8ckmhIyIFeQrbzWX9XX?=
 =?us-ascii?Q?ypNAeq2e3SPnQ80W24U7SkVrLmaLR326TsjxUBTzZQHwscSitZJ7oG+Qhqd1?=
 =?us-ascii?Q?7V4TXKWpoK7pQgCSYgUeaBCWfdv/IK4diFLieFARg0D2R5NJPuPU8N7HAenG?=
 =?us-ascii?Q?hVZ5noOr7HwQRrcSftDvYhPg9nv0rImdGpAYTnANNULiVaJ+A+w1KNz4n1yj?=
 =?us-ascii?Q?WwX7A//US3AnYwivjk5Ar4RSBg6bacnrz17p0f50Zg60wySm1MqQkcafbyre?=
 =?us-ascii?Q?Apk9enockoQEfQRsDIVPbiw8XWGvyfTBaW5SVcQZS0x+fi3EQqWlEJJQ0YVw?=
 =?us-ascii?Q?AVe2AKV7i+D+dPb9fvp/5q/SgqSgzcTtZOdT09D76Kt3jwiqMbeSqqRHEYcS?=
 =?us-ascii?Q?XcM6qasab5/Af6vjrTLb4Zoro0t7VtNUT/pW3XLnUIwCGWLiY71OJk1Ae9lZ?=
 =?us-ascii?Q?K3r5YMJI+AE7ty4ckYSjRTOtQjIAbyYyEQV/VhjOgeoH47DLKQQKVkezqdMs?=
 =?us-ascii?Q?yNzcRv4ySgQ04zGgMQL7zn6qLZSQ7V76/nGNizJMd8VJB1otcngEIh2CgaZu?=
 =?us-ascii?Q?1qgznHuPo9XN94MH//ym8SwE32xmA1rehZrsYo3gdvOhvDXkgSzyIEvrIOk4?=
 =?us-ascii?Q?YxR1olnfguKSKqmOnSpyFyvqIU0uxV3JWPYP3UpwMz9im/r0NPNqQ9k6Z/YO?=
 =?us-ascii?Q?rlOSF/VKyheCu6t1J0dz3KlQlKRmZVq916DW7EakXUBCcJEB4ttErIPrZFpP?=
 =?us-ascii?Q?i73CItuwr7IYhY96Jl4cSlx3Zq8rwbEY9c4syfThE2IG1ub2SHVJZIj817CR?=
 =?us-ascii?Q?aBQ86rb1IFA72rFPUSCSa1UtGRgrBa7ZD441OYN8sQpEYFb3XTFG9WnlTVkd?=
 =?us-ascii?Q?F+fpx2bNaq0HbL7t7PGQgLNqTFd9f01lQD/+BNq02gpUVx/5IKtSJC3XEut9?=
 =?us-ascii?Q?uKx+kR2w4Pny+fdtWV+DuiOZXc/2JsFtCTpHyq2R39z3qqGJQvi6GucLQfGS?=
 =?us-ascii?Q?/Rr/A4l74Y9gSpibJcnPyJLyYCIrJFQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b4918f-01ca-4b2e-1a72-08de744cfdcf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 09:05:15.9004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygMURYK1EzVthQ+0Dp9GvTzyERCAl869SfdlfgoHK99pbpdvVgkP7GKevqZ0bw91xDMndfFx1XYI+oDrIl7Cp5XqVXOejZDTxz/UnCAOO00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8218
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

On Wed, Feb 25, 2026 at 09:00:52AM +0000, Bruce Richardson wrote:
> On Wed, Feb 25, 2026 at 02:23:33PM +0530, Shaiq Wani wrote:
> > Fix the misspelled macro IDPD_TXQ_SCAN_CQ_THRESH to
> > IDPF_TXQ_SCAN_CQ_THRESH in the header and its usage
> > in the AVX512 split queue Tx path.
> > 
> > Fixes: e528d7c74819 ("common/idpf: add AVX512 data path for split queue model")
> Cc: stable@dpdk.org
> 
> > Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> > ---
> >  drivers/net/intel/idpf/idpf_common_rxtx.h        | 2 +-
> >  drivers/net/intel/idpf/idpf_common_rxtx_avx512.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Applied to dpdk-next-net-intel.

Thanks,
/Bruce
