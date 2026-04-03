Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47BEE7E36D
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 10:55:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABA3940296;
	Fri,  3 Apr 2026 12:55:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 90F7A4028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 12:55:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775213732; x=1806749732;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=m1ehHrIBMU2OsfbRFfkScdGvEyLb/eFiUA1D2oeY+hw=;
 b=P5u4X6GFH11olwuWP1Lc2nYH84iPQwFnIG5VsJ8fDj+qqIJhdtMi1+vf
 ManerbKxNvjCQYJTMAJyKem1mWcYPkDoSjZADHPxtQAiAsmMlMq2zn1VZ
 fY1d2t9djCDFfB+APEbeHIvb9ajEccIUJbwsgyqO1Jvh/wRHgPbDFjUtb
 VNv1Z9igAIaehOFIEmiPGSRUYFzEXdYS8MVWdrtJcEhX2mRkE1KyuGuRH
 63zLDrPF5rT3mzp62kRiOTzBPeZ2pAskL8prNWOuGJnjPS8y/O8dbvt5L
 ua4quQqM5QeCXIZ0dmYCEjDoytxuRP/aFHNAqQobUXnvv+5DigDQOoBrk w==;
X-CSE-ConnectionGUID: zviAxvzPQCeihIX/ic8dRA==
X-CSE-MsgGUID: VVbOTemYQgu40LAgsK6yJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75999521"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="75999521"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 03:55:31 -0700
X-CSE-ConnectionGUID: DrQYSj6PRayRpgjT/cwiCw==
X-CSE-MsgGUID: eOhhHPjMRkat9cIK4N1zRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="257698747"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 03:55:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 03:55:29 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 03:55:29 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 03:55:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZyzxEu+pJQASP+RFhotkHrLuTD4hrPixNc3wZ8mE96503G4KQcmFfjVuI/l73CZSIuJQ3CuewjSVC3BkHhGVtXFxfLhAPidG/O5p6BQdzib3rQK9EyL2Hu/e4DkeidCXekVMqRn83SGcyclNuIgf4rPMnLSCXqlZa59gXzU+qL7nVZ9WylIX6bD9HSMLZDc7CKApr3W6TliA578F5PmZyAHhQ0Yvrju/bV0FDEY6MmaQj9eK350l9Gqen5uyM4RGLMsU2PeZU7hdUBhCLbmuW/SPb7ABHInOJOK+ENKzBQRP5EXAQiiKYLn1/CCBBIaTxY8m9/BPRk7sP5KCdtIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbqGV13oLxPDsQuiivklQU0jX1SdlS4IOX3h/H4Ra0c=;
 b=KHZNX/G72x+s0fey11YMRjsTtN74PQ10sM0HGRmiA+JTf/IQzYwsZa0cjRnYiwQK61yfA0QV3Qa/KzOVC52/5o9PTy2b5bzOjfEJCOCRqFpLtsbX04wWh3Tb2LC5d0M3mRT1s9A/AQVYIj5KPEDWerxxPeiz0WMIBsd+rJA2G2ueqT/vMW7dv9li4dUj6Ecst6ULdGQP6bncDI+Yv3Wp0wxtTHOPD/wZazJfyaF3Vr0vGhYT2Q2SsWqR+hnaF+D7WaxSCTlox/W4Mz7y2ABcEQzH8r213X6KCeOjM/wEIWqdEC5nsNQM5kxoV6uhd7HhcaFnMNBfbE9bGHJNL9oNKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB8254.namprd11.prod.outlook.com (2603:10b6:806:251::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 10:55:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 10:55:27 +0000
Date: Fri, 3 Apr 2026 11:55:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 5/8] net/iavf: refactor sending virtchnl messages
Message-ID: <ac-cmsavhQdiBfWY@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1772794442.git.anatoly.burakov@intel.com>
 <cover.1772794442.git.anatoly.burakov@intel.com>
 <bade49dcf585835d368baaf2ee85d9a7ae1b19da.1772794442.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bade49dcf585835d368baaf2ee85d9a7ae1b19da.1772794442.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU6P191CA0071.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ac0aaf-7b8b-4de5-6f05-08de916f8391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: rvLX6wUlmDc8nIke4TANJe5jzaOlMj/PtOfOIS0IPqC8jaZ1G6Ek1iH41VTLSoaJcbKLIXmCIS0AabEvYPxpVgiOMAOpRopRLULhVo06vsoo7LklK2XtRLNuCFBfW1N7e0zrbTDx90ZS2tyGC3Mr82wBJdN+Qwmwp7WEuAjwt1/xmGMg6U4dHq5W9++nQREzSEbo73NK0ytUEd3DoajM3YmaLhVzn6LGo1gIAKgPhOTt8Hg3xVIXHvcY4lAyelCcRe4+u3kj9bErIgI9O1wv3lM8fSHynhcy1qB/DwUYHW8zA2rapb4ZR9xu7dV7UAuIpWut682HTEejS6ev1v6Z2GeoVIq1DOuNGKiIY9EaxdrZH+T17EPH/4gP80IMdwJrenc47BlKbptZsRiev+Y/0iXOWI4LKZDvK7wjjQlnq+K5djzN4DWCC7yMYznpuqQnuNEl8Uy3rP36MmHn3E3cxed6I86jLnDYKoZqnwftUeHlfR8J8CvRqKCRXJPPD9y5mVEI9AFZ8tOlawHw0LF/7eMwkKRotFeex0CBkyjwxP4jbY/Mb2kXjw25gFS8kqwgT3M7YXwwhS8ccfbMG/2P+Qy++cYyRwcORs0TBLYp2KaN3So39WOQxO6bUFY3SiD2cSdKainc8ZwjCvX1qKpHbC97eP+0a75HYjiazy/eIaKWvssmC1aXM4vNtSZtj7lRs9fqouyb7HmpOfK85PJ19fBRNVJJOk/TvPrUo77mQlM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?78+ydHJzimNdBOJ4O7JRIGXp9QJhJEyQsrD0hkBgV0wBf0l168mkYqfuzPQc?=
 =?us-ascii?Q?k64erRaQV4OZDEEavMCOnLR1dLk0DQ8lVRMv9RxqPZ147WEqPN7j2hTYpZ6U?=
 =?us-ascii?Q?UbGhQ5kI61RR4vxfJ0C2AsPjZTBM0PF1jL3PzrJzexFSp1yTg9ll5ZaVy98R?=
 =?us-ascii?Q?U5HqQXv9ynzXFl4Gg7cNF19g0iKgkyj615BeH5Ggjla7ChgysgCskVYD/rvY?=
 =?us-ascii?Q?fDX/zX06qxzfWJrUtqCeem+8Ryo9a5OsVDt8SGqfywhCwtYlbH2sBE6kAEar?=
 =?us-ascii?Q?FKH9jWMpNEF5BOayoX0hXN1AdOA4tBUeOnbgIjGSZDXjMBVim18mpVrsPSvB?=
 =?us-ascii?Q?/F9UUmyRIimI1vzi/U7794ZBVDs6HXVzeWpPrkP2xQHVvI46Wiuhxww+Ekr4?=
 =?us-ascii?Q?jPchrbwvbxDC6QrtBHBIT8GaZJuWjPQ4KgG4/QX7sLitSidr30NHbK4V2sd/?=
 =?us-ascii?Q?Ns0MmIhCMJr1IACJgIdQGdXb/wAcfcw+pVTzXdUrlf0bsj6242Ha0WPLoxaj?=
 =?us-ascii?Q?v38lb1PYeGs5NkhNPaYOHW64HziICYDRK6cXvEQIkPJkDtMqkJdDqopkHH9v?=
 =?us-ascii?Q?NvVj19ptyTVbDkxvdVdtJ6lsfxwq8RUzPi5nLBIgN3La3ZfkVPf12Kyfyk4X?=
 =?us-ascii?Q?QH9PDmYIbhdYUDzrvkSPEz/RteFwl9O78p7PM7o4J1IsojIl9H1FtBOvDCls?=
 =?us-ascii?Q?e4blvANv4qF4OgfYYCBE+t/kxrxVI+njH/9ycoqcp7cgIq+WurpkS40lBatS?=
 =?us-ascii?Q?aSwIkJFGvAb6xJ2REaGqbyikn7OLgJfnPtRx548WPbfA/Svkk9rfPPPfjCr1?=
 =?us-ascii?Q?64QbrmpnwbnPoRr6cwmZtTJnbCs+7rpYvIqordyxul48IsMnp7YtKe/2ciBe?=
 =?us-ascii?Q?aEPZ3yzFFvIpORcJOXUnochh+MuB5PsjyRJbaDg+nxLEi5eLUleprgG1Vn/E?=
 =?us-ascii?Q?lZY6hhxNNcv8cOcgfcaY0wZpHX5QcWMToJR7X8iqXf55dHiVD5OD0DDN2uM0?=
 =?us-ascii?Q?Ujs1MEAJULnhBTpfliy8v9wvK0zWTS+x0tsVzS/dAxcrc4WCB/yvX0cIWLeV?=
 =?us-ascii?Q?h82+evW64OHDqPoSVjvFGpNgi+Gv8/FhXDuZ62fmLzWyRaXkTApfr5FI2aUg?=
 =?us-ascii?Q?mB24aJBIjhdLDC9FK/6nHbiu8z9bcKFa/lev3JQmTWVd60rHgwXoXJ3Xr46a?=
 =?us-ascii?Q?bI3u5jtrPHq+mIIHp5z4byZIYsw2u1WTb7KoRwvqY+jDHLLt8E7cWn6oQlgl?=
 =?us-ascii?Q?YXdkOqPkzFklzuf7OTxwMeFZg+lsvv0zEdNmPAmmnIObl98ux+EV/7poGtVi?=
 =?us-ascii?Q?ndXOX25xG7MzbK2xTQfTTIsyKf3JoNYHk294sYoEhZlFRZWcg/Cb51SwKDrs?=
 =?us-ascii?Q?NXn8RnU7hs6S4U4us/95wTgsJBkSEtpvJ/VJrY0rf4JVXSzFnph/XUU5aGBY?=
 =?us-ascii?Q?wc3exBwq0zgqQ2tf9OmNGED0xRB1K9ieSq7doZvhazoYcEkz5c1co088gnW8?=
 =?us-ascii?Q?P/0bFXpuGsnO/IxkTU7sVkkcFvKXw6cF+vuAYyrcYrGn7+W0wQd4kKxxRIPD?=
 =?us-ascii?Q?ytXuKghQaCWBHgbF302AJD4VrMZqMrV3UCdwzbxGAxMNvV+uNfkxBolu6UNO?=
 =?us-ascii?Q?tAPBoTXphRQR0VltwelOvzeIBsoLsM0GNapbjex+qNjffdQS8mosokLxQayL?=
 =?us-ascii?Q?YBNndOSsumr1+laqMSHbiYgbK8DPojlNTYL6O8PpNXRtDIbkhmwBmnXPpv+/?=
 =?us-ascii?Q?CSFsCtobDmGsQP9WESX76kEUDeeeNN4=3D?=
X-Exchange-RoutingPolicyChecked: kyCYENuHN3HdJ40l0qn8+6Gkg9bscsREVibjUGLR0m/Q8860ZCANd72tdYO7Ngn8ooX3Qz0+W8MzCfJCWPLDmLdCOfpfdjxvhTjY3DpUHW48H4VVY51FVrXD95RLQENWYak8d7xc98NPaCP0FwOdvszsS7YIvWq7MJqRztHe/FvL0hBtzWmDPkw5hIgOVpzOCAlKRj6t0mY8NAj2iv7blpfl9t91/5RwzsjX61cgzBbR4yVZb8O+iGvKzsf+diSFAU67rwepTkoF+uHgoGlB/opfFq4NnMG6LlZ72X6IGwquoewElu0r5VIUALabpoy46H8NkPflZp4fuhoOcgGuQA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ac0aaf-7b8b-4de5-6f05-08de916f8391
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 10:55:26.9021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuXwPoEjy52+mxrSDV9vI8y/wFMU1nsxpsZWS75t3FDKo5wymFPfxFz3vZuk81ncPiE/zi3rxIdeqDsYqvYKr9+tFKNLSEemOFGXhIFnYKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8254
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

On Fri, Mar 06, 2026 at 10:58:21AM +0000, Anatoly Burakov wrote:
> Currently, there is a certain amount of duplication and unnecessary
> branching in the virtchnl message handling function which makes it
> difficult to read and reason about.
> 
> Refactor the function to achieve the following:
> 
> - clean and explicit distinction between synchronous and asynchronous ops
> - common looping and error handling logic
> - fewer and clearer special cases
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_vchnl.c | 151 +++++++++++++---------------
>  1 file changed, 70 insertions(+), 81 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

