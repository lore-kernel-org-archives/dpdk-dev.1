Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06243606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GCEdjhfS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56BE2400D7;
	Wed, 21 Oct 2026 16:55:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id B79A140041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 16:55:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792594536; x=1824130536;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4uZ8jAvhJRtjOcdykA62zv3UX2HwQpbF+5EqDeV6fXE=;
 b=GCEdjhfSr9MghQzA7Inl1HC2Kqqvr71aHYGBrS1MpONKUNhe/0XztKim
 xl2fOfKjD9uKKySNGYkjT+nhYelehNkIyz7ZV5dyrUqQIq8cbtZKsbF+N
 /Z3oXUdT5K4AanSg1F82HF3Lfoc5UV7JtP48S2ZB+nLd6XrsjY971yCvZ
 fwsgoSaGUgEdLxl2+K1YbDRmfjHPL3bb7n2s4Ba6fD3mPU7vztOzVau0X
 644Fc3aQgmHiX4Ry7n+izFY0d1euOoHvcUHZXCy8on/9aq82PQUYYztR5
 lLHxnsRn5kPgLLJej8u5mvwtlH+hG3d4A10+/c/RQbvtVXLEdLGWmd1oP Q==;
X-CSE-ConnectionGUID: MnoH2SDsT3uuUtYBJfAvPQ==
X-CSE-MsgGUID: +aCwjUTnQjGlSpBcdf5YPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1194690"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1194690"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 07:55:35 -0700
X-CSE-ConnectionGUID: tEieZT5PQoyEUSrLgx2HIg==
X-CSE-MsgGUID: r6y+pku9SDeNVAhaI9mRAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3052290"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 07:55:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 07:55:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 07:55:34 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 07:55:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOLehLVfYrEyYi8EU5A7vY/b11qhwuAzO9C8UTc8UowhSzcYkUT2GErQ3HMrGVIQY2SS5mxUQEfeGGgNQncN7xPhnltQzqC4J5Glg5diIdezkEGNJE6MKzclw6//RWgWPHqwpPCzaHJLFBziWYbgITYbdn27H0ZK2DVUJ48QyC6dhl34QBxL+QfH5iFtPkVOfBB+PJSH8rmZu3YB+gQrmjt/7YBoj6eVcDQRS0EEz9MuZ/in/bF9rLJYtF0m8aZxcGnaFQfrT0ezSkWrwFGh6B4y9/YEZl4oMU3SiKBmBE34RtY8JEXJR4/45AlDvfvGTQ3/9t3EOOdbfYEvq1yvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rscbEV3zBQqDBzjIl+46pcRCgWkIox9LiqHXd1e397w=;
 b=Qp4QXcAITy2cF6PTuQyhX5uCs3trl+j0+ShGHYnhK4Z/mOuXHBi8XhLt2Y6UK9dOlbaxmUTVcvLgdT/moKGr/P4PWbhRaGeLjFRb9xOP8ir4oCFQZOUiDRJHojQeN15Pah3FS9Fr0dQUZocezB4ChsSn5L8n08kwcNhzIGVBLBPWCD64s56+//zw1dQpHDrkOVewWIfO4NmvWoCScLuhMIPVnxAWjAKQfnrw/BNA9Z2yv3U7l3OaMybBvKBn1jouUbjOuwmVryJ2JS/P1i0lkyop647TmOk+YfGgJv+aluaf/FKiUuWWH4mJ9ZA4AXTATY0Vw/USPLNmPPkICbL/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH8PR11MB6830.namprd11.prod.outlook.com (2603:10b6:510:22e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 14:55:31 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 14:55:30 +0000
Date: Wed, 21 Oct 2026 15:55:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2] net/ice: support Rx timestamp offload on vector path
Message-ID: <atjSXfuFpbTWxxha@bricha3-mobl1.ger.corp.intel.com>
References: <20260918210352.303512-1-sandeep.penigalapati@intel.com>
 <20261009003630.27749-1-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261009003630.27749-1-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DB9PR05CA0021.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::26) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH8PR11MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a249cf-6572-4b02-4fad-08df2f8359d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|10067099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: TJb2JKc3q6B5gNIg/O4OM+CEVQcfLDEkz424fgBA0V5VZmzI5tOTMG2ofyhu2B/8tRhZipata0K3oOBW42VX3vfn7jcyxeR4elV3rW/mSW1S2BOi4O6EWqsNaKM1azqYJG9b+D4tHfOWkqdQ7hCmO4MZI5UqG5uZkip4RM7kxubIVY811A2aNbpEplBhMunI9PPRLStF4MR62cVWcCYZzmOL4lxpE22OTp5cFWQJHD6NFtUCndqRLPyfwDJVHU8rtbebRkqmNIYLJStYc+KvG9cSAuPM/K378iGpYObaFUv9fLuNn29bKTcU6P3TRg2D9OhH8WAZbtj6l/5l0qZXn0NdGZt8kPlGN2sDMmBatdFFFqgCapVJY7rddz416i9ORMma8cW8VO7Vd1DoObIbg4dY3ERD7gZC5p3nt3SDlAU1mdg+K79Scf+Dv19wukN4kVE23DbdArK0lKWAhXAq6tTx+MB2S24OQdJNUBtoOTnVz7rHEtxdbcx0IIOs1jiTtSjtBbdbGKWVR2EoSQWc5iJW0D+EK1/y3QfEErjGeOH7UIkgc9Zns9bVv2+zmG4v0zAM+MtW5mhPIMdugqXwGY6lNC7SJLoI1w0ID9wyl3bVTrgz9Y9QmcgRmPe4h+E2gtF8H6Zd3x1N9rIwikFEzQYYTbWF9VS5VzXP1XUePQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eJL6kqKa8g3AizllfgXWetJFk+1L5ZmxV29jRAWk1qfBd61CV9ZV7Yw9EBPV?=
 =?us-ascii?Q?ODbVYFlF1TD+tV13xHAPN1zcDA9QpPMA039rk72FYULlFDygbMA3gX2pmFRH?=
 =?us-ascii?Q?laT/09GKpn306JlB/kxM2NRuno0FYtIyw5qxgjS5DRqAJW0pzJKjpaN3Ig2y?=
 =?us-ascii?Q?4t86LmYVFlbal+YmGoYCCXUl7KZgzT46hii+YTsjzTslp9g1Y8/xvI2+MKnv?=
 =?us-ascii?Q?hFls1s1YL3H+Rk2MCaRuvhKKL2YFM35+pJ5qsLeJfTJ9gmqivJP5rcaVGlbp?=
 =?us-ascii?Q?3AGiNWok1WRntOPpmTKYmPhNpIVjGTK8WI1hT4QMMzA0zdRYkzFxubuUG51z?=
 =?us-ascii?Q?WF4hWusBR2I6WtBv7hEb5EIlKITE9p3uWioUyTbRbnntwbSex4+9CCeVCsnP?=
 =?us-ascii?Q?wuL4QTPiNkZSxge8xsTYD3kFVslje93B/+V4uJA/Nu/b4kvqvrGj3j3lLzen?=
 =?us-ascii?Q?m3KQ7HRPZccQWZQHU0hTeYxVXzpK5Euj5QyuX8uPrXfRqVt8syHRjmsnCiEg?=
 =?us-ascii?Q?oSY1R1DlcDjFDfBhuk7etUouLPGx2cRZ/yt6Ov0shuJtooooJapkqwpgFnsd?=
 =?us-ascii?Q?qg5cQRdWAWzZXpkiWNbIXszlwV/t1uJN+xWGgauKKJKcc5xd7ZSpwh93UCZ9?=
 =?us-ascii?Q?zUqIOrFNyfrKu80Npuk1RyahMwBPd/dNbwsngxjzLX/T1TwJ9U18Th/IMhmF?=
 =?us-ascii?Q?wE4QPKNwtLpU+8CLBjur/btsEWN4WVXILRiE/aRSzzsr8t0xcGrnlSl5C1Gg?=
 =?us-ascii?Q?pfhelVD0YpAl0ELIWLTfP7MIxKQnEp0WcCyNW75lKOtyi/E9bfDpce036yBh?=
 =?us-ascii?Q?Yr4KMl1CKLMdnAkIiT/XmIwSVldIbtgx/pf7mCZMGw8T5PWLDVIU3+HbIrQo?=
 =?us-ascii?Q?flX0L86WlTHqLj6l7+BV0OI4wj9g7xY6f/C4Tof+ljimXzi/FkKEy9BZfnSB?=
 =?us-ascii?Q?wzdsXrPIftz4rSMiR1WT7xAVK5ZXbbi3iHfT/q+hiwTT42NdTPaNs8nX4Qww?=
 =?us-ascii?Q?i1apM1a1yaoC0Rrlz8wSS2kHdD1bLKSP7mXsqPZk3bSGRlNE3FI2Q1w9N8j9?=
 =?us-ascii?Q?gJXFwSAfF1FfTfs84M1j6W6JoidM9HSHPs7NfTVc+XAv9FTcBa2547oYhHHV?=
 =?us-ascii?Q?9Uu/Da6ILRF1lXjJKLD4PPSXVTYcuhotU3zhhMuEWQsdH9x8vwtKoglOFoau?=
 =?us-ascii?Q?yRriQjssPIbNwqNeZ2nToQ0IkbQmL9S0fEm69ZGYLmuMu38OCyac9N5rNfTc?=
 =?us-ascii?Q?53fq6wHL9nuR4yhLMnrhIp0PxEWpQpkcgfZNGsCASzzu/GHtl92OW96YLeio?=
 =?us-ascii?Q?INxuZVjqYifDsDEb5DpqV2i/3oilKhpXPTxEE00ad/4cxrjcjSxQZMucKqCD?=
 =?us-ascii?Q?8toNY32wRTBTUe8EfJhWOJOUuIPq/Wu100p+IpXEwKPwWP8KD9NJqKsNQUmg?=
 =?us-ascii?Q?WSx/Yrfxh/9abOSrEJIbhoEnu66JvGSweyFR912AHMy9iFdE+8UuKj0AVBKd?=
 =?us-ascii?Q?Tb68zPj3BuAO5tI8IHhWkFLE8f02l2zlw6MZDrzZDQRudq2mLRWlwuSfE5a7?=
 =?us-ascii?Q?t6ybMPzHTkUAMdy35hlmmXJlDgDBe7VMOHSVx6zi7Uu4eUGzkh8QMVHtglJ6?=
 =?us-ascii?Q?O9+EXtMmiKjCKjB/ynX+hSg5aBymxvRvok7MR+SljHeYvCpxtZEDARp2bJNF?=
 =?us-ascii?Q?FxAlOlCEv9Nf2P9nQFWfHQkvVLeAhhUgkivHLOu6VFsQcEtmKg2VvTv43lbw?=
 =?us-ascii?Q?SUzRjwPtHi98jWYuroZbXVhsyY2qhtA=3D?=
X-Exchange-RoutingPolicyChecked: hEVZ4b0DfatCCp15SThAW6YNwg3fP8qYv2ZadzW2XLZF2nLNMGJvcvIeEFf0QPcGt7C/rfymcDtmVeSke6eYAbg90tPVPvbFUimPg8ATajlm1Gj/q1mNZps9nqcJjq9hTSQh+nlEvTPaz3tYTJAPwk1PqFvZWUVsaO/FCAI7Z+tNP4bRya6owWZ80F2jJkNxQD8F6tMsq0f/rzpR6C04A5yXfhOgWBk6/LPHKrnVtFdU3IVQTeswKDoq/YYXPCqJvYpfgJS/HGRAskttO+PI5bwiCXny0eutVaI8olmaIBjiB3xBF1DzGVNj2/LJ1BoDw2qRTCcAdHogH5P1kXeeXA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a249cf-6572-4b02-4fad-08df2f8359d8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 14:55:30.7063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyb01BkVpkqOPW5AB+Ve48yfxXaaqs4J1WUsBGXU103g7AFrvUL4dFmFG3wJ5gpXt14N5ddGm80n9gEcJvJaCUH9mmwPJTI33NYAIzWDlew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6830
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 09, 2026 at 12:36:30AM +0000, Sandeep Penigalapati wrote:
> The ice PMD only supported Rx hardware timestamp offload
> (RTE_ETH_RX_OFFLOAD_TIMESTAMP) on the scalar Rx path. Enabling the
> offload forced a fallback from the AVX2/AVX512 vector Rx paths to the
> scalar path, causing a significant performance drop on 800 series
> adapters.
> 
> Add Rx timestamp support to the AVX2 and AVX512 vector Rx paths,
> mirroring the existing iavf implementation: the 32-bit timestamp is
> read from the flex descriptor in the vectorized loop and converted to
> 64 bits, with register rollover tracking, in a scalar pass over the
> received packets after the loop.
> 
> Advertise the timestamp offload only on the x86 vector paths that
> implement it, via a new ICE_RX_VECTOR_OFFLOAD_TS_OFFLOADS mask, so on
> Arm the request still falls back to the scalar path.
> 
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
> ---
> v2:
> - rebased to current main; fixed release notes and ice.ini conflicts
> - kept the offload check on two lines
> 
