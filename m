Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF26DCA0FE7
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 13:22:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 004034021E;
	Mon, 25 Aug 2025 15:22:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 1F25C40156
 for <dev@dpdk.org>; Mon, 25 Aug 2025 15:22:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756128171; x=1787664171;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HPKEfEcSvSilYspK88kD3XEVCraPuvdJ42repVyZ3Fg=;
 b=b5dN/+yz7dpq8viw84TPfyXHb1Z4Jcfl0/BMY1BXv/ians2ixFoVwzEW
 zc667VVA6rxSBhYE9D72I7HamrwjlGVdj1S9zQQ0J2qY4YIlbR7tNbNln
 2FHpdkGFXJdHF8GDNDZMKeikn41MWPlL6MF9OZgb1wiI0IM6JnT/xXRla
 hj4mVKQQzJlsfWgyh5Ck/Z2q5dEG35zeQhl3XdXfK6ZG7d5MdpV+pZPZM
 b71VvB2a9i7GeZUM1um9AIqjOTM7tUdDWetfGULxi+O9uL3KCDVZz/ILH
 w0efDzdZc4qxRoKJMRVGmdW0JtW2qZN5t793H1VglQFVtYoZJE3rgrcn8 A==;
X-CSE-ConnectionGUID: 1DuMmf+7RbWUOdbSzLKuyA==
X-CSE-MsgGUID: ZcMpNoaYTFCeeR5GsaiTkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="69053227"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; d="scan'208";a="69053227"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2025 06:20:24 -0700
X-CSE-ConnectionGUID: VPId/wm8RC26Z/Jz2l93ng==
X-CSE-MsgGUID: xwFTsD95Sw+u/E8bnsyXlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; d="scan'208";a="170120378"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2025 06:20:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 06:20:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 06:20:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.47)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 06:20:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSJaivO1r72B38blbQUOlJR6i4qVbPjr6cJrD1jyRSwSczX1j4cJRu79fxFQ5YLH6nr6DpXHXrHE2OFZ53iBQKwLotctuY9XjLvQuuUDnMUkEYnA2EfxQLUyR/Nh74CjJUtIejsdwDrpY16QtGK23ULt/DgJl9FVO6ygkmDvz3xLt7d4Mz9Y9ExojvG1LPAYPuxvMZyGMfH0SFUrE6DLeFxGprQxxkDNiiDYnnoGOqfFESnCNXzJ3acTgrKSfJMeaLDrDN6ovcbVBl1m4gTW0DVDgHO/oZ6VjW1Rw0XAtW6Xt/971+Ql6TQU4fHXikJYwUWNQi9hxFq59j4ozl6z8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQJtMBhWsBge40jtwgiJCFMLF/9DRqsXXRXokhjPzPE=;
 b=Ch9oKFM1q3o8/ANwQSRsTWfz/QG+zNYWCGKuKiFbCnxW9yLGNaAJRtD6zO1cA6c9OFFfSuY91n8jKNI7l/lZQytTCDPj3py63+n5UOVTnE6f05jXfS5e9mofDRt47+t+wH+L7Jk2Ccur/PufsLCSF0xDISE7Yu17M+6acpFjJMl1HVt3IemPQRla8IjPilWsz/U4Oqn+1wuHtAQOr6QRabndJr1ZS3cVgup0WOzEyFmc6or13uFlQOsxVRGXci7Twaa/+usjJq943ihkipSP/LZ++Xt4LUlFlTWUE7/COsuDNKot5S9nypOT7Er3ratRYTFnxjP0eD1f1h6mk57R6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB8687.namprd11.prod.outlook.com (2603:10b6:8:1be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Mon, 25 Aug
 2025 13:20:19 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 13:20:19 +0000
Date: Mon, 25 Aug 2025 14:20:14 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 4/4] doc: add release note entry for SSE removal
Message-ID: <aKxjDpR8d75HtxvW@bricha3-mobl1.ger.corp.intel.com>
References: <20250825123548.1177090-1-ciara.loftus@intel.com>
 <20250825123548.1177090-5-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250825123548.1177090-5-ciara.loftus@intel.com>
X-ClientProxiedBy: DB8PR09CA0035.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::48) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB8687:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc9166e-4951-4d38-2027-08dde3da2389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CDk/0dSMDTYiHIxeEyZiD7i4BjFnHPT13r19VAYyNBN4VtLua/0wKOKstGBa?=
 =?us-ascii?Q?rK8GsOXlzfl04KZ8kQw2iIl5Z733AYovnYP4Qkgvws/DFyQoREWvW5UQL6cX?=
 =?us-ascii?Q?ZX0HnZs83hezL99oXZN76jm2EusAtwvBSvbnIwVLGAWp3PQLwOjy8zSNz7sX?=
 =?us-ascii?Q?aLuSd4DGv455bdD8oHV06KhYtLcHeyJk2j7Zq3APYFT3uAyohy860iFlHnYr?=
 =?us-ascii?Q?we1BFLduTmLgCkBvZdclXPMvTtrTsTYG7hqElH4FO7nI/ZfUMK+5H3CIHZCd?=
 =?us-ascii?Q?NoJCSZNKI2+IJwEkcyz5C6FXCvlmlUalTsddPJE6xYg2oqjqFRknuVjgWNKa?=
 =?us-ascii?Q?o9I14jIQZ64vBFz5Xb+ibrHvZl8++nk8rzBZdj/KQn4XYGryPcK8JUuqtEpT?=
 =?us-ascii?Q?Imo1In5JZtjxSChfJ25sJAJTAYbU0OBvNGpByv1OWpqT7LEX6MxWlGCHhrBG?=
 =?us-ascii?Q?P9OClOPSNjb9v+1HvCttkCpfpDOBdvs73ukZjQohSsqe7V+eAq+VCrYwAxmw?=
 =?us-ascii?Q?2uu2H0yMttseW+69wKU0cVE0LQ6xlfAbkJ74JTJhM9lcrEreKF10IdzCvRjr?=
 =?us-ascii?Q?bz88d7jNm5+G03a52NqOIlvbDsixzu4fnKxVMCJyANvtA7+HunArcSkZ1XET?=
 =?us-ascii?Q?bhQ/7clatk0i1stb6ftYrsNf4AHsQtjb363aT3R/s32LgpvZG0wK5FEUdQrY?=
 =?us-ascii?Q?mxNvkTBCGAcV2Lhbl1DdiugPccKUejH6808Rjb4ZG7uActYQ/+QX+G2nOeZZ?=
 =?us-ascii?Q?utGOWNwBenDBIykYvu/C/5CFAHYvw2Lha6fLWJkjdEsEUy6pzvqa8Yp79q59?=
 =?us-ascii?Q?2R3C42ryfVOyMTFrDaHZDxudzKJKJFoCa+nww54qZpXcAjy2jTVhU0cLX8pl?=
 =?us-ascii?Q?3NduUXfUGbDXvzX2jWSOjjnEtv8MwF9tZrYNWvwKv+nqUwK+DCJatmKi5yOe?=
 =?us-ascii?Q?t0B2/s9IQh3A5X6XIVifHV+sejPFItaA2gKyPlwDVgVvXgBze9NqRCSFfWW/?=
 =?us-ascii?Q?4ijzUrDiDoMPN9O1373i4wNIP4qSpdbILj4ruDoJnnOONWCl6Fwag4LwcI7G?=
 =?us-ascii?Q?yhsRxxPl2ofJ5jS0v+v+XAS1bgAU9QE+xUGe8iE1WYY6HFXJhUsgDwwxg5Vr?=
 =?us-ascii?Q?I8SuGigYB6EDqRwK4OifjmNSzgiyPDhzuxbjt5L7Ct0YsI0DzqnmEtF5xrdK?=
 =?us-ascii?Q?dFYroq1sxux571yJ+qOftPXrzcm6gXhRLBO+GmHIHwGl6HEfMrwxppmA4U7Y?=
 =?us-ascii?Q?ceAPUNxAcktVKahcE9DEqkvGMfvdXIs16ES1qJOS72GqfO+Bjvfinxy+4zmL?=
 =?us-ascii?Q?yaeCVKegdIdpokVd1XpRRBMPhI9l1zslZnibIHMRqbf+whZxki8yeD+F0+Wg?=
 =?us-ascii?Q?p1U2WJRv0C50ivjlS1PEqbTUEEbqTK43V4tYtnLv+TJhMx1U5yhGKMDfULlV?=
 =?us-ascii?Q?BBvjmyVcYFQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9kLGHfzc0ssUgzMPxXrXqZ8nguVnY9D2HcxePXUD/Eanfc/i1+Yunr5xmso/?=
 =?us-ascii?Q?cFbBlW6VIzSsNlSrds8zHHvmUwvUeCU9Ush2PerQnH7jy/F0rfbRH/3Q0d9N?=
 =?us-ascii?Q?1beJFDnrY018qFQy8jyYNaKKz/Nd/R+WDe0ZvoHV5yhx8sj7NZ0SOjnpAa9Z?=
 =?us-ascii?Q?IwmqoiVLpGI9kyT6+AsMUFEUY1wJq2m2je0EP7EGVwCWpD4HuTOB5HJ2Xa7R?=
 =?us-ascii?Q?IRuAO79xpgME7A0zLlxfP+W2ewzj3msPvPL6FPc4WKva+1gYSJ5ejzT1QIwF?=
 =?us-ascii?Q?C83HC6LUeAg95ojk1+cZlQydKCtdcAo1mDS/o8/yMWym0m5fWOfNt4cBJi0s?=
 =?us-ascii?Q?FuM8vKtdbe8FXmkRZbw34hY3dkvEto4YSlGL/Gl634ZDy8y8S85bgsRoJCzi?=
 =?us-ascii?Q?XhDwqvHx4nY1gNhk6sYdpwJafsUluIaOt03V8tZ0sjSzXTE7WvN0R+nShbGM?=
 =?us-ascii?Q?1J6G97VU3h52H03bpeeRmGmSfNsRuEg1seJYpDzZaNir5AIm8eOQmDYNAOOt?=
 =?us-ascii?Q?SLKU5Ya3eLbNlu3B55j3tTcKwCYa2yCdPYGz/W7hs9YImcYi9EWEHnoVXIrN?=
 =?us-ascii?Q?+Spj8yLlfZogzfm1Ef0SAk9rBtL2+CFRLPhXC7UGhkS3Ges02v3yZLNCS9H+?=
 =?us-ascii?Q?YhGRlb+s5boc08eXzMAPspY0O4L+SCh7tbKZ62vCQi3iPmH/8cFMZdn4ZtUm?=
 =?us-ascii?Q?+Mp53ObCy2zExxl+PkF0OU+wIWXCmZELnEg8aJzsFt8rXoYf7HOdNABBd8Eg?=
 =?us-ascii?Q?JmXprc46i/n7ROxndeNVNf+MvIvBAd91vxuG46YS9Xmy+kFI/LQqHRfBx9M7?=
 =?us-ascii?Q?N/lGo/lRTvegSGQaUd1RhfTNAc56jvKJYvIJiGn6JBMaR0qj4cS/7VxFR5L7?=
 =?us-ascii?Q?A+SUXwBoOFBe3hKDyoKuSQvpPHa808/yaJD+2CUIjiO579/9DQXW8xs2sqIo?=
 =?us-ascii?Q?ShILDrfjfMxO20mb6sIS+Pq68tgCRq8wzp06lUgilYc6rzu/KcTTCcDStvr7?=
 =?us-ascii?Q?y/+utDdXUTrC7nIigymDMBnOrniMXTT2HUy1J5FVce9EilJzKB9azt+KCEgI?=
 =?us-ascii?Q?JHC47MvDoJ3Tfdj6NC6OyLTWJ17EpsGxwLSkfTFrWUGtuw2USl1SltHPVh0Y?=
 =?us-ascii?Q?A6b0gzWZOMJN3JhrI7zm94WUhfvlP6GOunb+bul3xde3jbMuAjW1jsa/yi0W?=
 =?us-ascii?Q?JTe9y5aGs7IPkwmZtnB7FPOZuqJU7kSO+rBaXuHF8ojf8z5WJ9hD6QJjsfNL?=
 =?us-ascii?Q?q8/B4wHRzNlTKZnI1T5OoY+3yj5pQvPysR9UwPBVxCd6ThSfJQPjU7f1ak0y?=
 =?us-ascii?Q?hq0ljUlQ9CRmptkafyKEKgGyz+Gf320GQVjnqllx/hHXETbDGcwonSBkBPt4?=
 =?us-ascii?Q?JsfR5+TtQkSBysejx5WDrTCAOUvB7LaSRf0A9gDlxyZSUEnZYPKK6K5C/1nf?=
 =?us-ascii?Q?f8yVdy0bAbBjm2jyoawuvgobCYSMu/CI7BNrCrPmFLRvIWIeAKeGEVVhP0IZ?=
 =?us-ascii?Q?FMRJdfG6OJOfwK4j6NYtqxerONSzhecLM8k8bl3GH7PkigVUC5q+3YKRVn25?=
 =?us-ascii?Q?JIioG1+i4yJqEDn8m/Z7VGXjDM2jXUTBuBZcybxgY5uApwrfs80K57ReSVh+?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc9166e-4951-4d38-2027-08dde3da2389
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 13:20:19.6424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qxacATzikjjrSTOT2aYFlEauj+rOhZ5XprdTVciv6/bwuLxdHI03dEgw+FoqFP+F+WUmOTkE9XICT1DoJQWtY/h+lKOm2NK5YvT576MUgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8687
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

On Mon, Aug 25, 2025 at 12:35:48PM +0000, Ciara Loftus wrote:
> The SSE paths have been removed from the i40e, iavf and ice Intel
> drivers. Add a release note documenting their removal.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  doc/guides/rel_notes/release_25_11.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
> index ccad6d89ff..d2749f2e4b 100644
> --- a/doc/guides/rel_notes/release_25_11.rst
> +++ b/doc/guides/rel_notes/release_25_11.rst
> @@ -55,6 +55,11 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =======================================================
>  
> +* **Removed the SSE vector paths from some Intel drivers.**
> +
> +  The SSE path was not widely used, so it was removed from the i40e,
> +  iavf and ice drivers.
> +
>  
>  Removed Items
>  -------------
> -- 
I think the deprecation notice can be removed, too.

Also, like with the cover letter, it's worth explaining that the SSE paths
are replaced by the AVX2 and AVX-512 paths which offer better performance.

/Bruce
