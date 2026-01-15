Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F90D4116B
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 10:41:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EF2D40E2E;
	Thu, 15 Jan 2026 11:41:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id B4E32406B7;
 Thu, 15 Jan 2026 11:41:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768473711; x=1800009711;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WtMTKPMrsMwgw9dpuO+neWdfwDlSh2xr4Lq46T2fM64=;
 b=f737g3Gn7l1oobk1j8NUaA2GGHrdiSCJiwilO0Pz6FrpGBOrPvQIx/Oa
 Z1pszV24acSdYTdxi2VaImJ474Hh75Tow5qusumvh7NgEwd9ghPT/T91E
 8rS75Ipqhng7AUO6jbLmYK15FH1p/pCmE9f1pr2A/hlC30p4GMa/f/MjY
 1OVfi9Pw8Mt/QAR3raOPxlIvvYrqQ1Sf9jyO5yRk1c5KPtChiRgvKLBjU
 soMKs/zED9zHXu0r/iCJ0IDe8Kv2RcxnjexSHRWb55sMJ/0iCnmni0/KQ
 6ISQLTKkJorXjlyI5SCUdez2IhBTccHdnkmgh3rNVujtXdRvrEKyM6l93 A==;
X-CSE-ConnectionGUID: xjNJfooXQNiJbsAbjNXQ+w==
X-CSE-MsgGUID: tWKyAG25QcCfo1VSAkqe+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="73620546"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; d="scan'208";a="73620546"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 02:41:50 -0800
X-CSE-ConnectionGUID: 1Z4uG6GMT8WTZfQTy2cpQw==
X-CSE-MsgGUID: NjAEQ+LARV6UzQIAeJwmQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; d="scan'208";a="236179836"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 02:41:49 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 02:41:48 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 15 Jan 2026 02:41:48 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 02:41:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSHGdqiN1Geonzg53SDHbowMqwvwMnz5hush6XyPUU1X4g7sOOq98/y1K7s7s2VizCOg9c71cDzQxZzFxWJEmQFYli3vaHLBk8EuMHumbmhLdW8PPDzG3ZWlyksIoeHO0XZEABvTXbsDY49GiH+3EUj7WXnSRXmJrSiv/fmwHE0YXR8utrQnu2agbx/+N9byGrD1xN7N+Re8vyR+VNEvrrG0fA5C6Ax9FgGUEYHXrCG+YzR6enlO33JpnABFU1+UAJg2zzhVqlhM2H4ZE8+p8iwccgC6duQPNhBEphleu8cTd6xdqxCgxlGvRp0y+meSftA4/hnlGWtceLN0RM1Hbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idsPG3gcOx+LFGPkea+cjw5rC/Qy25bfomI1ViI8xk8=;
 b=uBUnJiJxsZElU0aax+caB2EUqXsrGLrFhB/f8rFXKj7a4QUddmhtVb+vvpJ4J5maTOmAyzH9NMHhYG8erhbv33Hg3yqopEx5R692bBNN5AL2iGKRO1dYNc6U02p54J66hEr/JfK6IHh0rY8azxi0B6+L4CRPasNxCY3KfbrsV7nh7QdfFMlhuOLOWP5sLYuA6/h5sH2PYbTmTx8QOq8tZgH0CD0MkklLInOtCBPdcKUL8E3KIxNDzCnnRSMJKI2UpT9DYMJwoQB1P2SAchBV9Y+mJeRdjG1/5MljkTnapWw0kDlaIZnnDNzc3mMz5Jy9DZteyQSonIVJ6AIjCThuqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB5106.namprd11.prod.outlook.com (2603:10b6:303:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 10:41:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 10:41:41 +0000
Date: Thu, 15 Jan 2026 10:41:36 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 1/3] net/ice: check for null before dereferencing
Message-ID: <aWjEYOd1-GEm8moW@bricha3-mobl1.ger.corp.intel.com>
References: <20260115103824.1982220-1-ciara.loftus@intel.com>
 <20260115103824.1982220-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260115103824.1982220-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DB9PR02CA0030.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: af4590c8-7dc5-40d9-5d2a-08de5422ab4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ju3O6pZmbtyiRiQjGIq3EiPWtFnizsiLZ+tCjaPp6CIdQ/aMSIbi8ivCEKQS?=
 =?us-ascii?Q?xCeKu67+guyoPYmfg+Ha4eoI7KzXVeuNop5w0/Uk5s20WgBaAiMB0Jbte5cV?=
 =?us-ascii?Q?zyGIdnmlZNx2yelOAsskDNl95Jj+oAEqhD4b/MntyhAyTcqLHyygQ6waznAF?=
 =?us-ascii?Q?1Nb6BpWlUFIJpIw3G08rqO82NJRv83gvDr+5aUYXv5z8t3cks028Oh6cS7Rk?=
 =?us-ascii?Q?Y3bmhaPezeq9EcJCARVIgyyUZwsRCLwuoecNQsX4K1bb449bSC0SEk1n4mqd?=
 =?us-ascii?Q?ek7oYQuBZO17FEzOiwBx1qKpbwaN07XFSMOn1aH61oFdY86og73q5UpRFOXG?=
 =?us-ascii?Q?y5r2WwMS5miwVOjZO+hktTJH0z4H4lC4bj12joch+W5GbJzPluJPONmKqeo8?=
 =?us-ascii?Q?nW7/EOVY4yTZ2oadAyWhlw5FMMKgnnH03JlOf4tABVEuH1oX9KOQ0EUG29ej?=
 =?us-ascii?Q?0Dr2d5ABapifmRA9+wQfqvboJiFEotGkZIeMBd+h1oXPN4QScUeBXw9DEwBe?=
 =?us-ascii?Q?iS/G4BFX0wxpBENzntFh9e+RWKUW9fsb6jRiP5kzHGGn9V0shwhBmuiPYH6o?=
 =?us-ascii?Q?C2B8gChEQt1o35IO/m9IdoUt6kHZDPVrmUggtNtc444T8uVGFMIG0Yfas/h/?=
 =?us-ascii?Q?HXsBNATSBA7Gp3EoDlXO8xxKG+poQSfXgfHe/ITryuVrnPGVu87uUIcc2I7R?=
 =?us-ascii?Q?6HMa89yLc4LVKln+rWBLPq8CN8e1YdKqHdCgDexHXPS/TxWt4HK+0y9az2D7?=
 =?us-ascii?Q?NqnxopJs9DmS8hWvWj1wy8l8kyYPCH83jsvuqBR7hfM+CBHbumurze+28rc1?=
 =?us-ascii?Q?D+V8F5aS9QjMYN/h/+wH9kTrS5dc0t/8Df1k9RDW9PRvfMv1YKTbuo7Jtabn?=
 =?us-ascii?Q?mH/m2o10ZgcUxKxJBfrhvGlVt8rkYbfhdu5woDRsrIwwoCGs3escslvfR2i3?=
 =?us-ascii?Q?l+PoUa31aI3pky6jR7vkc31S4Kc+tv95IZN3Wg7xrf/V4oa1xeiyXVqLm2no?=
 =?us-ascii?Q?gjzLG7SbSt9sPAKnnvAM6A7kBmhCaxxXQS3vXjMW3MkxFklWDR3vrzBGYTfG?=
 =?us-ascii?Q?gEDh+yZuB6fpX/dwUKB6iAqsE5x0Yhl1lax50oe9Al6V5ro2acHhBpenWUBG?=
 =?us-ascii?Q?xqLLlZoF8MZuQ6ODKcx0Zw2SdSuOh8V0Bg0ez3PtBpGxTbwZWuM3CSpsYSB3?=
 =?us-ascii?Q?L7QUJYkBHkdtJKCJ1w4iD/Xo4FdzDGtKhN461VuzLZt7NRP+fPs5e8fw2hOx?=
 =?us-ascii?Q?z7975YH3nbULwqVIZlptbOcgVl8vwX8KNcXJCil51jfPTJAe0SYxp5aSbabb?=
 =?us-ascii?Q?KaMV//HJ683MoRiZTgbZSeBnUE1K/3DMl3hsMJKtq4DtekIyHl/uFyLqK7gJ?=
 =?us-ascii?Q?E4YQddJMHFdATCbL2HNym59p1YDwl34H3ocNDUizwtkEFwC4bGkcYSmR7fdR?=
 =?us-ascii?Q?+F6NU40f5yX3/NkJwGqTtgFvJw134meNArAMYxi3q+NG+KiDs72QHPTcY041?=
 =?us-ascii?Q?8p9BC4aTGyB6TVIS9nO1+OhOAwdBfy4qrs5wji9oq0LLvGTzScmwBBOM2/K0?=
 =?us-ascii?Q?+RI5w7R9PaaMSjgW9z4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WDOA98vYvKQV9K1XKjguMEVUDRf3Dp+ThNJOfEbymNwNiNjm4FvnDZjqRw4E?=
 =?us-ascii?Q?tHSfukahvx5zDhaa4dYXk/osakbIqAtkwkJrZkUd1B7k99yoUx+akqQW25Rb?=
 =?us-ascii?Q?Hw2Vgs8cVAjpLmBJaFTB6qf+PXvryu64wgHvHkiIbwaVpuqB3eAq3IrX/p3D?=
 =?us-ascii?Q?MwEFXELp+dQ2phl3b5HCaQHrsqCZ7phK1HfMHfMXjDAEG7235IRrjzc0jP/1?=
 =?us-ascii?Q?ZzyXAqM/x1w/zrH0RcaT8sKk9prNdGiwTZ0mswicTf9ku890cM8PdprcjYb3?=
 =?us-ascii?Q?CKYaRXI55JZjZZmA3Z4F3n0MezmVPXb0FUWJQYidJwwdKmlwE2FixGAW719L?=
 =?us-ascii?Q?VQIvdkTseMWHrzcXu2FR+Aa28edFpZv5eUjYe7zVclVMvXTgyuVxW2DWEKFV?=
 =?us-ascii?Q?mJGESyLedgVzCDPb0k5Xn4qXDtAQmewrxfkGdEmwHwC3klwCYJ4GGiTAXE1V?=
 =?us-ascii?Q?2/nyiJhm3c1EzGdsRN1sjqymx2NtOBb695/C/bD9OEjKv/HYvtdZyxLJKuNG?=
 =?us-ascii?Q?t5209V9z3Enl/ao7j7+aQ2V1At8JzrjPJFv0MTdMKr95RqNmIYcM7VR03QU5?=
 =?us-ascii?Q?21pjPX+iAREno2nwR/26dk28QO4P+aKXuejEG9usgg9qrsthZTLJsGMUBYTS?=
 =?us-ascii?Q?owWSrizsNV/kwpq6JNqPN8XSU7Yx+DTjcO1s1A+Uf2bY9JRdZ9cP48JnEvHm?=
 =?us-ascii?Q?zTBWkRXSHTRm8GOeksZrG/T7tvfaDXB99GoNw+xPw7m9lwUoIv6nnEN1Pzwm?=
 =?us-ascii?Q?cozW+G27CVTa4ySw1uAmTpWfjVXT85vPeB+WlZ4XnqzYY0kxVs9OJY2w9Q5R?=
 =?us-ascii?Q?NBNLQPOyT5FKBzYAN/olUwCb0RdmfCEmzw7ZQVvum8rB+OBpCoVm99/1J/B8?=
 =?us-ascii?Q?9lcm2VUHikuWLiehlcRhpxoRuDllfEA+1jSDpnzEf46TBIRMZNBH2l/hSKXW?=
 =?us-ascii?Q?CC9xm6A4Cnv6Ne7rENtrNdACrY75iGxy76OXW7pOKH5l0NFdUtB7qE2FIeor?=
 =?us-ascii?Q?TNJaMfVhztuw2zJvFkWrQxPqrMCWVerdCNcBhVI3JzYaK7ZEMgvnb31y8eNo?=
 =?us-ascii?Q?0AXBWjreoIPBHP33uNes5Mk8kFwZfSdg2Ikw51tcay4u22D29uFPpRZmlrsW?=
 =?us-ascii?Q?F2SITTpppTrCw51uLhsa1yC8bWfHHsWPsKkg0RHt/QRG35gUvWk7oG8gCP8h?=
 =?us-ascii?Q?Wc9+cXOI+NjotJbmF3viw9emGZKHnfbO2WFU1QdtCDr6reShxi9YCoKUlcD5?=
 =?us-ascii?Q?kk7G+61iP6lSq/bGFGObMfgQHTdx3AlHvHp/l4mptda0fawS/7aqEkZZOwod?=
 =?us-ascii?Q?IjokhxOnrcgPA2SJ3a4v/zQb45C89NT/u9WHW5qjXszd399dni3t9lUJLxfX?=
 =?us-ascii?Q?yDl2RW7R7Wz5+x1WInJe0So165O4yzGE8+iEURH67FaUzWuq7ImIf1ESdfUk?=
 =?us-ascii?Q?dgPQBaLyrofWQSa8arzBEGZ6FBIVN8nhG8P8r36WJA6wTjXgM+gcm1ELZ9AC?=
 =?us-ascii?Q?eyPQZX742PK7aM+4QY8YKMZWio10ZgdF2NhYBAv/tdLmtIrqKduSnkcUeQBZ?=
 =?us-ascii?Q?DkNNcV9wjF/0e6yGvyE5V+XLVrS85f9GOo3wTHppizA4+omdViv8EX2YyCt+?=
 =?us-ascii?Q?Y4yJfpg009sL5hlYFMFUspNJB/EjqM7ixYB8F+FsPuDUboGRQT3aj1REnvR4?=
 =?us-ascii?Q?vgPMTySjG/cTHAGJWxfTolF5PzkvvOaTZqppabDSpu9HKIC2PTaeTK7lHxou?=
 =?us-ascii?Q?BMEDJj55pgN9kr/1FwiYSasb6feCGe8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af4590c8-7dc5-40d9-5d2a-08de5422ab4d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 10:41:41.3710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfoPugkMO1tu5g9gDQ2tB7Fx96r2X8afRUlQJZUpYQO442RAB5IUTASynazmPfzTIlFJDp7Kw2UW6LA4RVwhlfhMy0FAk3NwLAHrNJSnhy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5106
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

On Thu, Jan 15, 2026 at 10:38:21AM +0000, Ciara Loftus wrote:
> When commiting a new Tx scheduler hierarchy we assume the user has
> created a root node. However if they have not, it leads to an invalid
> memory access. While this would be an invalid configuration by the user
> we should still prevent the invalid memory access from happening. Do so
> by ensuring the root node is non null before dereferencing.
> 
> Fixes: 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

