Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA9ECF3185
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 10:43:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3EC6402C3;
	Wed, 19 Nov 2025 11:43:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 99DA040265
 for <dev@dpdk.org>; Wed, 19 Nov 2025 11:43:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763549031; x=1795085031;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=m+3zlV3vJJyhF8l3GggT2n6N+okVe8InQYIQGKnMt+8=;
 b=ZwsHSL9h4GIUtBwuAyuGH09gTJelrKe8YE/lHN4Yu0qHGhAafIJ72792
 8OwKNjBgyhScZFSYEMdFs3BxAeQpsPbzKS2qIEVkFohAZkP36MWBnpFuQ
 1rqqvq1UclF3EArmKx3NyJFBoC1h1loGNhPPtg237EBju7UZb9VjZEPck
 2o3ueoxPYscf1raGEyC4wNPsPU1MN01MO/Pi3ZuC9otMWiRA1IDtqntXE
 37NdfAQLdqycMgnRFGRjo68Q/LuKst+NCfAoI8t3yLVtqjonl88KK/ZJ9
 YYLlCTdG5XROe5Roqzi91YQ+lxjb2C3SSE0sWWB+lTMrCatlaApcpPVFc Q==;
X-CSE-ConnectionGUID: ywsJ+QPxT3KURQXf671mRg==
X-CSE-MsgGUID: AKZmmKQKRamzlPmKH/uCEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65287512"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="65287512"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 02:43:50 -0800
X-CSE-ConnectionGUID: Uh4MJmVqTwuA3yS9j7/zVw==
X-CSE-MsgGUID: tqbISmKdQMuc01irvhXHhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="195327152"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 02:43:50 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 02:43:50 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 02:43:50 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 02:43:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vquVSlY1zxtLFuGHVM6t3APjSWjpApZ+LarIaeOAp7tkOiL4yT5vmK4/tKYT6p/bJ1aWWBJ0FP3UlrrapmOQRTqziiB/9SxPgW5FspU4AeHsryEs/73r6WAWwJQx/aymxzutMQqwNMYFKvM2hDrEqnKwO6bASOQ0J5MBhbkR35VrK2/icxi1cYPKhI8kBmTVrRTbiB8u0cTaQiCUhNn3uhi2IxqaotL6MzSJXGMAcheYtghvRaSsaCeonzKoFZ3EHaVUjiCBcYKmj/1mo1gKr28B5kDsAatHhQ6u9P+GiUyqCGlGxRwGcd2BHdtI2bwn6h6C76djskH82qomEOGjsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IONnDLARWxugsCPT8juKWNpRfZM9kmlJuA5kKS1tIYU=;
 b=Btt1xtuzDAmlSSixDBVGlLvxO0e/kCBYZI/XuhUHMRtrodzRM1UItFyfzUHXW7CpWMqGlrzlepoCrmKXv94tAY7llEUlQ8lf2mNCVpnN3LXKGazWjW/x2p0eYETHQ0Kvc6LfQ13srkNbjlTzHxi1+s0uWXyonzjVwfiI3scRgMkEP5PS7eSGYmFFd491Sk9ATDSnuglOOP4Cmev1bCTLCoSll2ikLNQD8QM2YDN3Ke2rC8ssMMsurqN45lGw2MmJ9fntxJZTT2RWhp/8NmsrIzSlm7bq+glbGEOmOn6ajMtVufPHfrSJiYbqdn+h9RTtbAgjhhxobGwV0ERQXlppPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH0PR11MB5249.namprd11.prod.outlook.com (2603:10b6:610:e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:43:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 10:43:48 +0000
Date: Wed, 19 Nov 2025 10:43:43 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 0/2] Deprecation notices for VFIO
Message-ID: <aR2fX4LRIdOKlsKs@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1763548356.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1763548356.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0127.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH0PR11MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e7f51aa-bc26-4494-2d31-08de27588545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I0DUMSDuU4JKcPr0UvuSHOEb7JmXUnMo0Gu3r4uWn+9fuJAxzUKhZIqK166b?=
 =?us-ascii?Q?jm/RNupFt7OZ6aF5+htmj5AdcJEOSonPB4HizGqDiw775cqcYyeUhsCHYUtV?=
 =?us-ascii?Q?n3d79bxEFj7N/ES1uwfVhB8QUtanSBGVIeADaSOiCX9US+CStOmUgl1hNMR4?=
 =?us-ascii?Q?Ib+0faVMZVvjX98QctzIbGFTNue/IS+WMVanfASlgGSj6yhIqtIBULh8voNp?=
 =?us-ascii?Q?8w3AO2P5pRS2L6tlvu386sG/3Lt4sa8n67SD4tzrRp5npGjHGFpb23585Loy?=
 =?us-ascii?Q?ZqVFgXTAXJlVzMxtgHEfpSQ/QGz9yXMTvKVT3bQCz7ps1XA0qz0tW7IKy2NU?=
 =?us-ascii?Q?j1i8dPFLTYQO7RoimxiePeqneFATbNpdYlGvbAzImO2fdLvchlc5tZOvrhxI?=
 =?us-ascii?Q?JoKLh9iNW0x8lKKzUG4mTcr7M9kUsnRj5KucPo2D+JqbrOGXRANURdaXMHO2?=
 =?us-ascii?Q?aYRJV7awi2ToU/Hsfs+Tr0XS7c02RbKO3s3hNjxYv6safIzQEiwuUA0MaW7M?=
 =?us-ascii?Q?g3QXhjOTmfm4G7Nu1DSLy/GDOC/OOcO2hjt12L7GvCKJOW8vnWO3I4++egSR?=
 =?us-ascii?Q?Yp1UyL6CoX973s8tiTLth1JP/8mqImfd9fn7nyBD+Ldrl4MV0uQWkT0mVuKQ?=
 =?us-ascii?Q?aKO/jDAPuhIxdCfjcrDwp1UBlq6K0SQ3jVkxI3i39B4XREm97FF5Zn5SDfrB?=
 =?us-ascii?Q?VBi55BFUovoP6QHkx+3BR81DCQ4BfKZMZ1bOCxdEvvKJN1eXDLEOAEM01uSo?=
 =?us-ascii?Q?2urNg90uNzzztpB0jr58B0nipIaFxt5fQZIQ7o9iT2TDAv9g/f5EYmFdyJaM?=
 =?us-ascii?Q?PsIe7i0J5Y7LwpIAP2YvLs1vNkDaS/KMqvIu4QB2m32Uny+f40DnAWNLSPLX?=
 =?us-ascii?Q?j0LhNz6Oa4atL3Q5Arabfrk3ogU2y1s9fzVP5/3e+Pu523xLFtHZ88Kdg2XW?=
 =?us-ascii?Q?TifXwR7ZUe8t0n8sWUpwkFHV/0gSvN6FYpqudU4Vv9mzOnmMNMerBdNxQUp0?=
 =?us-ascii?Q?8d9j8rIKEMTd4HOn2PI61UCR5YWZeXkbbjsqgYLr3j4uNxl4zqovNmKe6X/B?=
 =?us-ascii?Q?O8+lqD7bS/E1JZZm2plQ4ZOWOXsFEsv2g0DcMSAulcfb1MfbIq1ri8MYNqx5?=
 =?us-ascii?Q?LRB30q0zexLIeFvsOPGhv/9aQOo5EOJNCbkeTeJwIIu22Mi4T+fqUprVeKz1?=
 =?us-ascii?Q?AF0hEf2+SaCk7BEyNSd9RkxeLigUs6KygpAfZdcfVItraJykuBEfME+p4lmv?=
 =?us-ascii?Q?9p7OudM9An5SAOHrJYVoBOJ9qju0BGY/wojxi69rVPc8/xkYXqnYSTu4SPnW?=
 =?us-ascii?Q?vo954/QbYKjNRsbwsfwB/MwkGdahFlEF+A/IO0fI9OCiGf5cG4lkb9q+Q03G?=
 =?us-ascii?Q?4gm84vUhWt7nXhBGuQhDYfr4H0MCKLWlDwNy9ZKKZmoOHnnsA6Cyr2+LeRz3?=
 =?us-ascii?Q?VUsLSZkY6UDLuPBZFNDsHoqSDTXPaNgP7orSHfT0UQs0gIVjak/Dcw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3BJvBXmrt9qAAUGjVbvbnrsGm7MlHWP8yXMA26Qax0ZfadKQCPKNU9P4zX27?=
 =?us-ascii?Q?/U0x/rCaIkiLei59besblQ8QDFvuUyZT20TI27do2Uqa0QmvAmPwO98xC98L?=
 =?us-ascii?Q?5oINaVkgxiX0DLoSwGTl5CKZNedx6CJOnL563/pQZFofKMhin4eo9BmryKIf?=
 =?us-ascii?Q?avnwvEszY+8S6RhhiTQHwIVxWE8YwFUoCdfxlMIe9LmPceP9w3aPh+iT2YfU?=
 =?us-ascii?Q?k5TPKurAY6BBiwbh3oeNcFu3fNtIwL+FVDLRtXBhAT821ez1lqm95F3B85fg?=
 =?us-ascii?Q?V29AgcPk1hquyioWf9+fKVF+QjxsKxbgntP/9qJPGTs5szDwyxlt72KaG3M3?=
 =?us-ascii?Q?WE5zv06DL/FgmSFutMKv75/ZKEcMR2qEh8AslJFJPtLEXDUlDcZ3rhH284fL?=
 =?us-ascii?Q?SKhKjwKmJ3cyFMnNKWSWiXCdJU73xdXEp2IZBATdmlLoDsYLSfgeGBuF1+/7?=
 =?us-ascii?Q?JU3TAb0JlMdXvXa3BO31Lb9IR4YfjNSViVbCLHTDXrJiy6cvWc+Z2Hid6fH/?=
 =?us-ascii?Q?VDfByx+AIlFPGuocOIXly149uPB1UrdZrnpaZh/HuqHI0ijFCBI6IDjBIHYX?=
 =?us-ascii?Q?jN4wPIMQYAyZ7kUE2LOgYs/bWhcwUuI0+LTaLddH1yNA8kooCp2c2/xoOFMr?=
 =?us-ascii?Q?akIRyce8HFVgQ7qK2y/LlFZAbhJj4EiMFMrjm++we9Pb/jz43YsmWQNeJtH2?=
 =?us-ascii?Q?dtOYrylBisGyRGZ9qVB8hEGskeajjqL6VBGzPJ/8MD1Ae73OxtOALZRX0/Bk?=
 =?us-ascii?Q?TJ0mFb46UeWjfWZOkBvys7L0L+42Q+yByBpmI3/qNz01wxByOK6PcTm1cQzb?=
 =?us-ascii?Q?VVlSHP01jYE0QfjCIEhJS8nfKjJ44Xl9u5vQkqWqdF1OP2iTxcbvBctASGQl?=
 =?us-ascii?Q?YZx/OQAlAcXjuzREcXnk5OZlhAZIrateRX52RtiCuI8NLvak3BfPMeuTHXTo?=
 =?us-ascii?Q?3SuISmKWGZLKG3eKENPtkMYo6uhJtW86X+D8P9r8p4VtcUJiG8yf1xJ6tIAx?=
 =?us-ascii?Q?3vFEB4Ip2yg27nEpzRGrdcGZQy1enSBvsVlcKPsB2u/851VxwFqfUaPszqF1?=
 =?us-ascii?Q?35zJQRuFNJOMqfJ8JN+8P0wEOeRH1JlqGZ9gU6k8ALdXiXnqokwQ9tZocG2j?=
 =?us-ascii?Q?e7TQi/c7CljjsfbQAZfekZUXdnr3wl8BRvvgEZ1fuztknf0TvOrbJ2kojTrS?=
 =?us-ascii?Q?6rU/WLR0DWuTPqrIeza8IPsyGL3MkcGaWaOR9fAaqb2aXYkh0O8EddQFzaAn?=
 =?us-ascii?Q?IEVuVWvf7RyP7aamIcDNwYseJrzSp31IjH0b5TjLgt0LhMdmUn3HPV1/gqKO?=
 =?us-ascii?Q?qZZ4LCF1WD1zEyr1NlW1+Ah1wxFzqsrdLzUXZ3iy/cdrdzOZMpXL+IuRp4o+?=
 =?us-ascii?Q?dqJtR9LeQy2xOk9xCQOvNHKm3O7sLOJMYb33kZ8cFnnHg7SmLyHWVvfUZs9x?=
 =?us-ascii?Q?SfcPYclnHoaf9gTXkFdAcRKdffL2+qz6+GT2wuHsl/xG2bAAmwX8+RlnJeJZ?=
 =?us-ascii?Q?AjYrIyLeSkODcOwgnRTPcsmnimf0PcVZUOdOGoGYJ5sgiuXG+LOdrHUtrmdN?=
 =?us-ascii?Q?3e7MIhLc2wWu48IPjWOeSnG9WmhPmvIvaHatNT9Aqroh+Jk/8RKf9g8QPH32?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7f51aa-bc26-4494-2d31-08de27588545
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 10:43:48.1527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+gbPpzi1IeLpymj/cfT76zQpAiQyvzFJXIWEO+ifn3Uv4dspDBN48+dIeDudj7hlJSqHEhJEqyQNOoVAVm/mQXngs+gjxRUopQPIpc+zEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5249
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

On Wed, Nov 19, 2025 at 10:35:36AM +0000, Anatoly Burakov wrote:
> There's ongoing work to rework VFIO in DPDK [1]. These deprecation
> notices originally were part of that patchset, but were split off
> to easy review and acceptance.
> 
> [1] https://patches.dpdk.org/project/dpdk/list/?series=36746
> 
> Anatoly Burakov (2):
>   doc: add deprecation notice for VFIO API
>   doc: add deprecation notice for vDPA driver API
> 
>  doc/guides/rel_notes/deprecation.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
>
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>
