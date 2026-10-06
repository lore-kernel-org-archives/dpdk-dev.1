Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0D9CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 14:01:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2337B402DF;
	Tue,  6 Oct 2026 16:01:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 046A74025A;
 Tue,  6 Oct 2026 16:01:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791295271; x=1822831271;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=eRxdGtliFHIrfUw1WJI6U7ydwe5UAWkspQSSJeezxv8=;
 b=bXSQCoSmSW/LVtMsFRCqbXc1Ru/hjObhThIpIoFEc2Hbb6pZpE2Fg1jg
 kS4Zgd72fcBXxMdmhH3pZyoeH+XGFdV/a0yWLCvnp9jKuqrQmO0HHRchN
 RSmxd48hiigYsEaH7GGNuvNugoKwwMYHQc8Ow38LhQuM0EujFawMyqOBB
 kW/MRHbREpThurjqlv2gCgMsBwQPmPdIMKYJZwihdQnKyiJrTV3yWDBOI
 qNalmwILV12zD4cW0ONR1wzC7rl/525HKdnA8kJrb0XWLmT0no5ctXaBh
 j1Icp9Lm8sq12SafWxdqKzXIeqdZ6LB/BUq0B32VgBuP49LwSC0nNa2Jp g==;
X-CSE-ConnectionGUID: 4/RKYhjESIKAYJFTh/3uow==
X-CSE-MsgGUID: EeNKd/unTSCy2yHLoo7AzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="109475256"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="109475256"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:01:10 -0700
X-CSE-ConnectionGUID: vNn6m7opSTefjpR+NRM7dg==
X-CSE-MsgGUID: bC32z22KQDmodF+4mnDFgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="285259314"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:01:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 07:01:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 07:01:09 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.46)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 07:01:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ba9U/F3TxzxMhP9ZUipmPv3WTc47cN9VkWeJV0qqfzJEypeo6Xuc9VeKF6P55PbUKWhcQLAKLVBnYy4bycrAwwznHkpvY9xdwQ6tJReysS33I0+JgXURYyIW8xueg/f7sErOLL0uQ7ymGSR3moLBzhEL5BYVhdSFfBo1cYLalaG4bw4urCdBIDa9thciXx4DILOOWDxSV89c+/ldEqMULK3S2oBcJufb13oXFlsZoRXVBmvYtfiaZEF5j3eOWATPgsazn0p8nJnHZ1jidO/Nm4PVP0w1hi636Qty9a55+SldTqQvHBXL3skhcgT6hxNRUj1amXZqZB7pWRVlJvWWUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/L0gX02aOZh0Oc0EAzSywdb63dc95sg2clZL7CwcXk=;
 b=gxkBJgZ8RsbXNUNJgF6jn3pTCLGfiCDa+sNicfmMxIpyi/73D4/j0oqQ8uiCiCI1CPoABgkGdVrp18/j+reRdkg5I4q7ML36bgxcQCWzRUP5+EN1CBPV4GUHveRmc6agnHm7hWINcoMXJ3Gi9kaa0QpLveI0vQJlRU49PrrAcetn7at2GM0FyoJR575zlL1wHufwQ3ExW5u+pzx98u+tV4BV2dWPlBNrjptVpDHFnUpQPbJiCD0cgAjBfuH+YtJKd/rCnop0lz9hEYKgM2rCV+wnpa+4jkTh5/N2vzlPaE091YdpELPV3nrJ3TrE9dQ9TAUlkcdz8v97FjJEsYE8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS4PPF6EA6DD735.namprd11.prod.outlook.com (2603:10b6:f:fc02::2d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 14:00:57 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Tue, 6 Oct 2026
 14:00:57 +0000
Date: Tue, 6 Oct 2026 15:00:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: Anurag Mandal <anurag.mandal@intel.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix PHY capabilities buffer leak
Message-ID: <asT_EQJH9ApGcYcl@bricha3-mobl1.ger.corp.intel.com>
References: <20260930165230.342989-1-anurag.mandal@intel.com>
 <ea668450-0d0f-4a7c-b591-3d5e76bf2d34@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ea668450-0d0f-4a7c-b591-3d5e76bf2d34@intel.com>
X-ClientProxiedBy: DB9PR02CA0020.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::25) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS4PPF6EA6DD735:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b4ee75-c162-46e0-c4e6-08df23b23e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: W8UKIZGR5Cys8hxbSKld9CwoLUFOM81KIK4vu/5cLJDHz6dSBZOScxVRkD52VES+ccUvwkcTDqsrLYp7UogGgiNynEF/Tj7ZvWk4Pv2vzW871ew7dR2yQ3Tp1zgMOHrsiP8AfDARa0CwKSfLGLXoP3uVlhOKKqrIZiLsf7oa6LDFiM3WM6IsfhlPWg1Gim5mqBJVXrvE/ZKAA4uLReuQp4XjVZQshl3Q7/XDPfKIi3lzGVcHwqeWJIA0y36kPodH4ldNne2/4g+kVXlASNm0isYUzqoqLGJoS+86Ftc+JRa1diVeAsCztMUH8n5JCUvI7bw+iwPa1uTG7R7IBkhC3z1iUn7uRGxQtna6Ktr3vDeUkp4RIP2v5Kf3wVjIlykKUnfxXvnmqIalF5gwuNDNiFLxF4ZGfXSyK5cvTu8O3yI9x2QVmNDc3Fp7+assqpYFJZPOHk5D4ACsGSHxLNlHjI02nJu03OJhiMG4F2lS3+IprUHACwP6EOIN1kjkRjCsASmkb4RR25tNwszSxz2x9/kFacWeX+nPpD6RwX72ZE3dsF0fCM9K+qMIXWpD2Y/tABKhWtl6r2iemA1XYBIpninSVB2YJmH5TKZpn+JWMprHCnap9M/fpATZhATtWml6hDfGLIx39nvv45i7Rzr40KC/qb7/A1tSakyOWWkMkXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CbGRBkmOimqspaJEhmFy4wTXbhIahAGlsQ7d4PEcUfyGDuDktVDwdDc+4DU9?=
 =?us-ascii?Q?lgSBicvERSSi8S83EKXvl5plkSdf1nBH7EYmLQFG2pMmsSNVy8XgrRUd/mEI?=
 =?us-ascii?Q?c6oDoGOXl32tlgoTajPIeY6hOMcFuosi4OulzfJIT7xK0lfZ5OXKTT4quJ4G?=
 =?us-ascii?Q?z/CSe6AUZNWqpCNJwhGNNVXGKnTDMXKxxPR0LOJSCz3RwPWnruS603efFtte?=
 =?us-ascii?Q?AStX1b5fGGIfEK49cl7l3NXkmK+6jbxVl4def18t/ltKoMWHRjdVHM4nyiH6?=
 =?us-ascii?Q?/sxJz6PO3xgXjlxZzYyiXWmaznNPyqWCgCIkuhn+TLGn3/ae4h6PIg6b1teg?=
 =?us-ascii?Q?U7h7WXBY8en+m2BULlyA2g79R51kxP5xE+BVtRlYTVOSZWEtosrz73GvxB/k?=
 =?us-ascii?Q?t8DI60R68BuSRfqf6LAx2hSgkHP/nEQzs0ftni/FeL1Jvkc/wkHTmb0EASEw?=
 =?us-ascii?Q?JYrHwt53y9VAx9ATnNv+l7heXH1vQnrLWlNgPHDavVvVXOuogJApNYWr6VdA?=
 =?us-ascii?Q?18XUxVEG6YdrCCy5/1GFt9EZNtSShLs//h97vnaJ81cqhZ6eP7Ymmqky8U78?=
 =?us-ascii?Q?JukQpdY3Ss55+nxFQs8mgigqRhL+QpVPeIfCf4LexbmmibAzOpsNwf+QVL6+?=
 =?us-ascii?Q?2d9P8eSOjOpnJrgbw8pQvmYTnNv9WWsshY8g88SjVButU/gMSjzqClnZp7yC?=
 =?us-ascii?Q?g2QNXyCgV4lCi3vA5UpAygJt0Y2vUwAn0PxESNbm2nG4QyNX+jbfb1/ESB9D?=
 =?us-ascii?Q?40sLj03lHFR9apdQcwkky/9Dj6JQ8x9WJ+sLmAoFV48Mnr1JoLiuqfAg9t+1?=
 =?us-ascii?Q?wYqc6Lmhg4nQ8uqcGY8qXyGYX1mxWYM2eLEkWPZ9aLkLZckA0jznLddUg6El?=
 =?us-ascii?Q?5eGi//js4fE2cBlx9DAjzVwUMl9NVf0X0bnVN+cKdYeXcW3faaWYQbEfgvR+?=
 =?us-ascii?Q?Fi65y31pOYxg+lPObHIGFjanJ4duCAJtjt6IphycFdszNxvNATL0kVdPKYGM?=
 =?us-ascii?Q?AAl+YY+uOv/mHWuC0/sTHrHKyDF3Ql8ZCEzGFmUjZiNrssKm9QSJJmw0R9OH?=
 =?us-ascii?Q?MBm9Km1tpO9/1MNcTd+F8gwDX2ma7AOQSl8MWeuBN6L63UUEKIs8zIpdNHAf?=
 =?us-ascii?Q?hFPpyDRdqFasnDV6CQJc6+SJ57D6JNkvK71ZNcVCvDVqCTvBOMwgCMotk7wG?=
 =?us-ascii?Q?2kJpTeHRYocUqjjhX+rCPIbIrGx6ODCLqW2+qpavXMNBfAaVcmeCKO6JWIas?=
 =?us-ascii?Q?hkNpJtj2lYdCzwstfUcz9qCeFfbj6gwKh8mqzm+Ur0hG0G5w8pzbVotOEnaj?=
 =?us-ascii?Q?0YBhwKRFlgAbLlTaDnFjjWCfZXmV5PcB2efd5WKYy26PeyebNk4FOsDs3iNS?=
 =?us-ascii?Q?PufUmHLLNM+iHJbjCbn9iLolvR0V8LHhJLrobUQiJylUVs5p4ZNP8MwAy2TJ?=
 =?us-ascii?Q?IzbV/bZ9C9akPQGxSN5vOHb38vbtkWwfOLiG6fTR7RhMBwUtffI9Kf59t8sd?=
 =?us-ascii?Q?XdjeVoBulBr6WY3YensYYvuSikgli+/mo2UVeP+8FyNgdN86XhWXOvzpis/a?=
 =?us-ascii?Q?SfdKTGJlODNIqje2nrnsLr8sdV+O7prwg+vbyteB91u5HCHnN1YyBsOrX+sn?=
 =?us-ascii?Q?iSKc7Kpep6RCEP1SnKXWDXQK3nBW6Zem8v1SlAm1EigLNI2DqS0s9XWEh2mE?=
 =?us-ascii?Q?zsBgmX+y6kJDF6GyyCV0DwROBeMP6D/yCm2Bw1wXgwRgVibARu6Dg5sk8RXc?=
 =?us-ascii?Q?F5FIEF7X0mYO8mdturV99fAJ1jByffQ=3D?=
X-Exchange-RoutingPolicyChecked: 5Y/Q3ZVVz5HZSSdpLVWLLSVXRqsUwhwAZ21n6Q0e2vi5U9lhsXlRM2rX5Due1Mu5uVf6UpvkgJUMEagpVRH2yt9RvrlFf//qFOeWJcaY9t183+btsBsDrJ4NZQNJvqMnLUdqY2SxlyabutEQlyoXAc+o2d4eKmZuKIvKreX1JG26BPA2LLXHrwby7HkMyN20LsjPpXogkBxBz4ynDSBboPWTfHw8MSkXgWjjeNDjbG9Mzu3+Fi2iOmx6bH0KD4pxOX6IVh4hC2VG6KEC4QKpSKFsE/aO586FrikFW1tUMB5GVZMGJ5QRINOyEZKKM9c7g7rnY4eHKArcbU9oBza+RQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b4ee75-c162-46e0-c4e6-08df23b23e56
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 14:00:57.1329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7r1+dPI+yPnoKLpiRd/xAHScWA1Vn4qgTRihgn9rIyL1rOWO1SLFgl7q8YP6x2jcE45xHFlKQ9m/x+PvGnpW8PkDCdyijr8HGzIUouz1LQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6EA6DD735
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

On Tue, Oct 06, 2026 at 11:57:33AM +0200, Burakov, Anatoly wrote:
> On 9/30/2026 6:52 PM, Anurag Mandal wrote:
> > ice_phy_conf_link() allocates the PHY capabilities buffer and only
> > then validates hw->port_info.
> > If hw->port_info is NULL,it returns directly without freeing
> > PHY capabilities buffer causing the buffer leak.
> > 
> > This patch fixes the issue by moving the hw->port_info NULL check
> > above the PHY capabilities buffer allocation.
> > 
> > Fixes: 36afbc269081 ("net/ice: support link speed change")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > ---
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
Applied to dpdk-next-net-intel.

Thanks,
/Bruce
