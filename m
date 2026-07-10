Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5FEC44501
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 14:00:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E64944060F;
	Fri, 10 Jul 2026 16:00:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id C8C05400D5
 for <dev@dpdk.org>; Fri, 10 Jul 2026 16:00:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783692054; x=1815228054;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ySRoJ1RyvnwGe0C453eHGKJzCXeTB/sBjVikOgdIra8=;
 b=jg/cuze4Oqp2jRtdMuHFSgK0qW5T//2gO5/bl6KPjO6PkoDmk2HKb+9F
 RnQxSE1M+VWKJTbVv8EuORN8VdTjqHvvK5eLA263P2A0gfSAbhcDjZllL
 Z2TDl66Wf0PM7/Tfe8HdXjeR9tfKTnKH3XslFyZ9SVhR8r5at+6EixNEM
 +IAsv+7VnY6dNseyaJSLdUbBM4Q2zDiaxFr3b9PXmOErnwusvzMQ1Ljwa
 JggUpPNWuKU1geed9B4LzNXHgjbh+6WTXihUS5w+/OUXZyRpdk4gqvKGb
 HhyYm/DMMN27Km62Z7vKdi0TatT9n2KwcfmRFPHBiNiPe8EoLKxtK4DBl A==;
X-CSE-ConnectionGUID: 9nG1/O4RSGCkFqGfqhtLPw==
X-CSE-MsgGUID: eiooUYw2RzS2LMPd+chMPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84503021"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84503021"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 07:00:53 -0700
X-CSE-ConnectionGUID: wFDKJSorRBO1N+UwuHk+mg==
X-CSE-MsgGUID: SpCx+Lp/R9ya83MCicG7JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="250896142"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 07:00:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 07:00:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 07:00:52 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 07:00:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veUBzuecCtExqmWWbgLu/5FPyYRDvoYLFSXG/DxXncBtcUa8f2fdcozg0dLuC5FMWP1fLCt/SpT/zyUAbJ8l8uQ4RdA8UEV9T0Ih9CEOztOtnGgqDptoBf3ytgjCXPQ+4ZxzZHOhfJrFA4TkCigwgo43NzNUBF5ZoGlhWyqUqMuYu2rK375TE6M0ie7AGg4wZakeNT7NYw0Mz3ZgAg+jVInWOgRM/ZRX8rCQRychuwPJ5WyTTVUuEh1h/4EanVODcs0bFHVlhpCQR6hdgX41WgBsRcYLpkF9BRjnYwaZV4V3AlLdxMnfTnCQoJ3jexbXnU1fMRMgt3fXiTxbh7PNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnbJdAbe9EfMCiIRi8rBa37u3lXniLwcEg46y8I2ySM=;
 b=uPlL2aIv/qSjb8jM8Ic+pdCOtDxLt/egOmASgJ6LgzLz8pGHeWwAZh8gxYqYfVLHYZqR8aRTflgraBJQdXnpWtBC5ChUTCR6FMpRSI6TRNab+sac7p6r92RXg49PpaFZKlJ54dBQ2eobqrZvHU3AA6MR60ryskh5Wue6qMJ8X2u5lz5O5UrIUTZm8LncOjS1E4NVBvewWX3BuaoyMZpKXpkfEXeNUEJ95Yijl6oBO8Q/vnnPBhNAWzCq+ZZ3JFvvnyy47LZS76H8Dhg/RBfBDjYQMuPyUbK6TIC8LmKSza+l5+YIRvPA2L5AmgIv8O6syE+JU17QtRhTisAWyDxFCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA3PR11MB9014.namprd11.prod.outlook.com (2603:10b6:208:583::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Fri, 10 Jul
 2026 14:00:46 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 14:00:46 +0000
Date: Fri, 10 Jul 2026 15:00:40 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v3 0/6] net/intel: fix some small memory leaks
Message-ID: <alD7CNlvbfMgsESZ@bricha3-mobl1.ger.corp.intel.com>
References: <20260703083335.4058936-1-bruce.richardson@intel.com>
 <20260710103403.1548864-1-bruce.richardson@intel.com>
 <IA4PR11MB92780E0AC2DEECB77E23DD7A8EFD2@IA4PR11MB9278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA4PR11MB92780E0AC2DEECB77E23DD7A8EFD2@IA4PR11MB9278.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0222.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::17) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA3PR11MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: 536fb4e9-f11d-4032-1d4e-08dede8ba377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: uHXCR7JlNaqxE0UEo/a2i2v7r6bH2/P7afoiZXLy9UjXqsVOtqAzysRA6YfkqsQ616Ep+ZdD6BXcw8zK6+QsrFszthn/GENca624alNUNNvd6+EKmYxUpLx2MYIC5AaHXAfHIiSKbp0u39F/q1lj3cN+AHeD8yZb1wunQ8kw9I3en28ItDyh5skIxqhJIMWxYawuIIAaZ6e0XHB8fiEV1eJfA0izlWQOzKevxYBZ1tNVI0mndRcbtEgCMsLgeRmFMxUbh7kCQt0AhwCqsJuXTENUC/uHW9rX34UzyUWi3+m5K7Umy7kyXzbPbC1MA5yXhbLafNmCGm1DcACHLEZm6HK4zLR8xkpHwaDyUUXmrhkIwea24yEf86db5jbPzPFeHAUHhkC/MWf6+r7wG1uNBTaiF3KhkCl9klnU70/tw3Ta5jBZE+eSyXoOqYDbVTN9Q8owgtO4Crc3Z5NpK4IyBxRFoN2hTGonB3oBY3D51SnrP5y9WziVwXEzfauRbo8FjDAre0syuJ38nzKcrshC5LQc0K8qUmgjHxOMw3YNk5bbPhIhmpZUTxPVTZxhgzdzsgQijGEILET3JHY2zQMsibUTUehsyb6ErcjA3fDQ/R08xBupY/sgryinfJbPOKpHR3kiL/fnP8DyZVm9wuBS9UrqJ3XDq8MAHHb8GxyYOQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dV06xiUJ1VBUwD99vxx5lDiO9TJ2TjqKLBLQQvWWcHscbhX6gMTg4TAaqf8D?=
 =?us-ascii?Q?E7OKPcs8v7oIEkOi3+VEaIyjDdUuC+y/rS4Sr5ttQishN22MehP0gQZV4iVM?=
 =?us-ascii?Q?/Wyq14KDTLAMVTrqVJWkN+P3Rc7cxWoqUbdGr/dl6XdEq+Ocj12YGLd0TGTY?=
 =?us-ascii?Q?ZM3yB+e3F3/HpExaBAkuxq3lkbaWqCnzlorZpE6nOAOrDItlG9yTJsKXXOCX?=
 =?us-ascii?Q?8YMO8/WRSXTWGaQAP757x3wMzt7oLitSei4i3OOeOEVZ3Cp0cbPoEON+IsGS?=
 =?us-ascii?Q?6A2/FfDbzcQg7ggJTyuBAzrWzJsjoReHhjV8g8G5KtHpSLpzhDITKoAA9GqK?=
 =?us-ascii?Q?rSqFUa5xRpvBg0HgOEjE7USxP/teJyYLQL9Fj3u3mJKD3RMmQkKpW5Fe7VAW?=
 =?us-ascii?Q?Md+INMtBUcmhO3OmAJM62IhmwhThfCmA1P5srPGFFFHAPRuLFDxObZU5OzEA?=
 =?us-ascii?Q?JL6LOfJPcSJ6uCDRUnBAiS3LW1p+PnQY7R/TtW3d0W9vMxeQqYhlktL/ye2g?=
 =?us-ascii?Q?fNltmam6AzqxXostczIQIHQtjt3JhAq364aTtuyOmI2hZuT6VfjvSzgRvWNo?=
 =?us-ascii?Q?l4nWJ5eI2C6bJFYr3HplxqjkqOhTsJu2NnN21bUTXpk6eLRv2LtBjg7jxj5m?=
 =?us-ascii?Q?g9Y/IeP1AWgJ7DJ/5Kk5pBw6PI9FZwxhoGNXastUuquPds/NEyEK8wF+rFDm?=
 =?us-ascii?Q?L7aBiHEwd0p81HFA21bTzCM87h1rD8hl+7tgfFRA6gBkbBR9Vx6ZXNqyVjuG?=
 =?us-ascii?Q?HPYkUn2GKiljteCiDtyXCCO4rCwEZ4hM9rs/R7GjxiBTeFJKaKxpBekgjDTX?=
 =?us-ascii?Q?v9MtMbyFjJllWIItnIuj9OVerc1Bppwfc3nTomHQNmqXPU9jfM+qdsbx7LFq?=
 =?us-ascii?Q?UWnFj3lq/BMbhXTuPep8ZEX45htZw9qcoe5Lhixp9SYyvnvTXqRAn84rrDrV?=
 =?us-ascii?Q?KPOYcfrP2ttMLsQHQY3pU7X/bpV3M+NTptLERy9z3YQbUKPq0AddHn7CobBQ?=
 =?us-ascii?Q?Kj/vvee1+g5zF+ijdk+pnZvOKzCyJSTclq181CMFN1hNdFZPdjgA4uDGquKU?=
 =?us-ascii?Q?5qGdumLu+mvrSSSZROc6SymNdLgwdR4ZKBHG4sHzfjP0wxM2yZg3e8pf78QY?=
 =?us-ascii?Q?Swx3KNj6fLDhKyPvedcJvjzzvU+EYrSsnBhFKqZx3V8KutEy3yTeR1EFHraH?=
 =?us-ascii?Q?Mu2haqt3faw97l0bBOIJNHT0gjshgqAAY86krisjM/c1Ujk0qYvobjEo0MUf?=
 =?us-ascii?Q?JYlEH/11YgMclZwUWkAHYZfSo6YhO3zgraoJbvQjbtBVMRGwQG2RVL6Iz3s8?=
 =?us-ascii?Q?WLw4FPmSHqWNK0iRLjI6xeIOc4+9xfA9otzc6fildbM2aBsULdEID+yYaTL1?=
 =?us-ascii?Q?rxzCqQcPGykHRbO8wLiw3zDgF0RIPuhKRJghExAbKkNIb15ZqRQEpHMjiXlI?=
 =?us-ascii?Q?7X5HrTyYj0KY4aEViH4S8YoEc5l5qUKG9Hvt1xTgQeV+/Z2ZqJLSgA9Mulsr?=
 =?us-ascii?Q?l20aUU1rUO4MQh3p/p7YsoLTIFFC/BFGCIdvJSDHt2EipQto2JpC5crYDKye?=
 =?us-ascii?Q?sS2agOp+k8m5HPVJayfAdE3KSukwlyHaBOAu5KW4QI8j8jI0GbM3LhSx8+83?=
 =?us-ascii?Q?ReEsVX5FyV8XS1PtoyYWqCtwndjP5XuAgmWROPrHo7qK7OJH98Amsgn4ymlx?=
 =?us-ascii?Q?0q3MQH6dFwfHrEjkOX7O6mNWuLV75ukTYA+FyHF4ANptLtVWbG27vjkOJYj1?=
 =?us-ascii?Q?HtYkjQmL6XNaP7kEDSF7OSFc4qWw5mc=3D?=
X-Exchange-RoutingPolicyChecked: X3WwUlNLJnv1lmHTyHvEEj6XYq2Iuw8RvcxfDMwptQtP1g+caM0fs5TTum+kW08hFIlIokyAR99xlBZN0TcPbhM/1v6mxiyWXfYcd/NkNKSE23c4ZYg7rFi9B3F69ce3MZdheq7ULMY4NCEn7UCZ60TQuZEsU3u4f6jg6TNjUJ2eP3r/kwu8PhDXe31jRdUBNKarqkUMEZGaRTF0p5OFFCYHRPe5CDMaBs678bIkGIlsZ3IpTyIeDB3s/vGo0C+zSLivwPP/SanpCK7Btn2FblXgzP8td5yvabPOH0VIUo21ZNQQG5B2JEYTe+sTQ9EsfvwadxQgJB8aEZNUoERU1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 536fb4e9-f11d-4032-1d4e-08dede8ba377
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 14:00:45.9943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxhFW1Acd0kub0jbN/4wTRKPxNzzf/To1ixmn0MUSLUufIPHf0r664Hmchf2Ca1RJE6OHuG5XlA4h4fuA9JvlLlDvnkyDXBhH+I7wo0RyxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9014
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

On Fri, Jul 10, 2026 at 11:52:08AM +0100, Loftus, Ciara wrote:
> > Subject: [PATCH v3 0/6] net/intel: fix some small memory leaks
> > 
> > AI review of a patch to traffic management code identified a couple of
> > small memory leaks in that function. When fixing those, I then asked AI
> > to identify other similar leaks other Intel drivers, leading to this
> > patchset.
> > 
> > V3: update based on feedback on v2:
> >     - fix log message on patch 3,
> >     - add additional free on close in patch 5
> > V2: expand from 2 patches to 6 to cover some more leaks
> > 
> > Bruce Richardson (6):
> >   net/iavf: fix local memory leaks in TM hierarchy commit
> >   net/iavf: fix leak of queue to traffic class mapping data
> >   net/iavf: fix memory leak on error when adding flow parser
> >   net/ice: fix buffer leak in config of Tx queue TM node
> >   net/iavf: fix leak of flex metadata extraction field
> >   net/iavf: fix leak of IPsec crypto capabilities array
> > 
> >  drivers/net/intel/iavf/iavf_ethdev.c       |  7 +++++
> >  drivers/net/intel/iavf/iavf_generic_flow.c |  1 +
> >  drivers/net/intel/iavf/iavf_ipsec_crypto.c |  2 ++
> >  drivers/net/intel/iavf/iavf_tm.c           | 31 +++++++++++++++-------
> >  drivers/net/intel/ice/ice_tm.c             |  6 +++--
> >  5 files changed, 36 insertions(+), 11 deletions(-)
> > 
> > --
> > 2.53.0
> 
> Series-acked-by: Ciara Loftus <ciara.loftus@intel.com>
> 
Applied to dpdk-next-net-intel.

/Bruce
