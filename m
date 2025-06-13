Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22623C71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 13:37:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA8E542EDB;
	Fri, 13 Jun 2025 15:37:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id E44D842ECB
 for <dev@dpdk.org>; Fri, 13 Jun 2025 15:37:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749821830; x=1781357830;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jXWJFTq/5WMcP8upjKmvFJtJRFDIPIPc0EF2iLrO+CI=;
 b=S+yu9+JNmhHZmHLFBS9Z5qJRNV2NWWeyXpGCz5IdaU5bGWbaqSRPwP5L
 cDLrJ0Nzxj4HEaqBdQ7c+Arwt/bYeXlMtirEbVDdonlHktFo03U+YoKI6
 +NpV4oPL0+nCY3JCA0SxPrId+eo9w1/l2CMK18t/Ic2VdaUdzDpKzoq0b
 rDDJuYouE14NYIuxO8fRAEt+JmfZw1MY96xsEyuvZvqebxVXrPgiZ/ycg
 m75ZQY6sJQ4vTDAT+m1wUYL1dFPqlUqdHbytnfHZnHA6pZqQJ4h/PBurX
 pAixvrcuztbN+36N+XxgRH9WethQVUqL6iB8u5cbGPzK0gn58jDodnojk Q==;
X-CSE-ConnectionGUID: V6KzQprnTBSnbwDStYtzcA==
X-CSE-MsgGUID: AaZkthe5SRSEBnj/LK/MkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="55836185"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; d="scan'208";a="55836185"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2025 06:37:08 -0700
X-CSE-ConnectionGUID: +Js1+/ySTf6n1guztDvbHg==
X-CSE-MsgGUID: BEVTyIaVQDCoiQ5vZFfG7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; d="scan'208";a="171016038"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2025 06:37:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 06:37:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 06:37:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 06:37:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibflb6v65RhW/+vzQDUTYwkRfBF8MFGaG00nYmrdb2EZ/K3XNEAekmq/wIfb0IkKNOKLp1e9VPF1rjdZbrzcgw30vp2PlegoSX+y4XM0hnWBLAj3oHiaWFX620VijoDxkGgfj2gqVk0Fw+kGD3bphgLyNspyTxi6j/zkeyxXHxBaE5/ZFKPjRWzrnfm8JBm47t8oxNdK8TmaZT+8gUyUxci4utgLZIKbMnId6mOj/QsICWxR36gchk9kRM7p0v8v6SAbM/+jgW2SHKBQg8NLowOtgnLeH7cEZj4H/5GbWQlNSq8B7N7Dj672rrG3W0qQTtH26h1le3yje7mtlp47Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nmOwaWGczVCxtq/0hbZxmxvYaGYAE2wYnSKNEe6mFs=;
 b=k2pN98i68n6z23QiQEFl1YJ7cpm4zXQZ7zeJDBNHEP1oiK+Ll8G3zIUvRG0Fti1Vhc8FZiyAuhux5PxdOgYkIXLncu3ao3hSYHqhsgJprdpZrpYWfvHi66MObIl/+cxvZSUDeiGDKq0P0BUonxhj94l4Tk94Q/UmksGO9v5etOQBsFvFbcN4WUF3lo7HuPq3BJCa86iwVtvZlZw9iVAi2Dg60zWm4CDvJeGcf94wSmZSYjZjFHrRP5QKCBLd8LwW3G9KYvCkpNwH2OY/WjL43wtBJkyZFrVuXh2gDN+eD2GUyRxn7DWJuRGPQaDEMmgBxoX3BhKcJfHk3JCCqrbZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB8597.namprd11.prod.outlook.com (2603:10b6:510:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Fri, 13 Jun
 2025 13:36:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 13:36:55 +0000
Date: Fri, 13 Jun 2025 14:36:51 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v7 00/33] Intel PMD drivers Rx cleanup
Message-ID: <aEwpc7QLz_rN8xe_@bricha3-mobl1.ger.corp.intel.com>
References: <c92131e8fcce1901018450bdf97ae004253addf7.1746538072.git.anatoly.burakov@intel.com>
 <cover.1749726639.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1749726639.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: AM0P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::40) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e085a96-7923-470d-c601-08ddaa7f5d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7HSkpfJxWsqkJZv++Djze6hn7QLTZW8dNZ1NvDUjIN+R7rNK+1dQwgrII3QF?=
 =?us-ascii?Q?n24lq04YofpaIdvV2aRDXHyT0oVp0MoIr38CzYHsITIyvpHxNNG/dH14zjGH?=
 =?us-ascii?Q?PwQkZinuUDVBLk4BSDCgSzEpXoFSSd8SzMpO9RFWiXaCrU04fTmeiOxN5FrY?=
 =?us-ascii?Q?KQVovnYv4kLpMl66Yula4YtbTgwjI6Q9Z/ptXZpzVJxY8yRGigP1FDuRo6Lq?=
 =?us-ascii?Q?4Jjvj91GsvAwzxS/8q16gPoMmWSHEuhoPB6VPxXoqw6WN9u6D5phWILZZavl?=
 =?us-ascii?Q?g0U1lNdh9NiNuTVJavhbrpECwyJnic2ofoTRm3r0uT9rcAV5TFV9GcehGhWZ?=
 =?us-ascii?Q?bLyPtWDM65K66izLvFpIYkro/8ruy0YutbZibOykiae7HAjeHT4hZ2G7A9lZ?=
 =?us-ascii?Q?ppy17FIOfP1NlVypirkF/Z/6CKUtCXf2MlOeDzUdm17L5rxondfOXG1a31cM?=
 =?us-ascii?Q?shgUDaeSOZ8YhEusbZT8mbPhWtM6ZyBm+PSn7JGW5HyPSjtD8qvFS7hDt3ZG?=
 =?us-ascii?Q?per5Tpvv6Scx+jNNmupSzDAhETw1lguZfr7/aP3zjDtx6l90bAhUAsZxWESe?=
 =?us-ascii?Q?pDXKXJAn9qyq/KTapmbtCvk8PRiWqxjToWRsJH4U8hlv9Yp533VHOabOxicp?=
 =?us-ascii?Q?t8dmpjMYart8GWzHcSonpzUNN7ui88KQjuMnzRcecmlgt61YQexwtAq+0XJM?=
 =?us-ascii?Q?pd162iUIKEUKsdIg9jtgnyBcm3Kx4e8aFY1cz4MUjUyyQEpnkWjFchesDMWb?=
 =?us-ascii?Q?9MOxExAZX28bu5rUCZixwjlLLYGQB1FgvMJ/553dRwLDeN/cZW261G45OaUV?=
 =?us-ascii?Q?AKG1KvVtZQIRIF1HHjOVAcAWxr4YhqD1R9uSkrMOfv+eMz0lCX6XoCuUj+Bl?=
 =?us-ascii?Q?rjvBlog8kkVWbEjRoNYVL/nFzqz/uXjecBQiB6JHA6iTowCBAE2ZVoBBpGVk?=
 =?us-ascii?Q?/Nbsf56xh7tN8hj0WWh+Dmb1jSIzkZLOolj/JCt4m2gbGuLF7EhNa4jT1lUQ?=
 =?us-ascii?Q?tEAWV9zSyHJLT5WYWMWJqdoqx7EkPMVukfKQMPTE36yGQpoIsOhHsLKOWe+k?=
 =?us-ascii?Q?DBcelI6SKS6MflVDX8gmqWzlZKTKWqdhnYMAhB/e2FeZDUW+NAAC04Jp4p4i?=
 =?us-ascii?Q?+ww8zisFQRLrve+YPWe7l1tuO6upLOc2Kl5UA5Hl+NpPJ2dgsqgbZ5yyKIKG?=
 =?us-ascii?Q?XjH/S0RvcM3GPc9fi5eqLLzV1vk9BGvDAeH/Y1yivK8RlE10I2V2PNb58MEb?=
 =?us-ascii?Q?fzBKyRAedsIis888Vcz4AgpevOoEPHbHy7sZZ9ptKivzUqDw+HEO40x5dbyL?=
 =?us-ascii?Q?DJEGQuwgRuNJ6mvMMG04+/2OSkUjlqCqTAhPzCRsg3voJ6jdVbNPY3xbBHcY?=
 =?us-ascii?Q?y1ycdCv6TIEHprz6Q9TSYuDfEgBDv3fj5iySy1Zth48QEGfl7A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NEkQYSJHjqa+xA3nbU4rh9OLEGJnljVx3e6dkaVsDU+PHCMMkDsPsmOH0GqN?=
 =?us-ascii?Q?PIlFgI6HRDVb+osPRv1r1UNPdBFZlFvZ5QgcdeYXu+fddlQSZ2rrWbnhSHg6?=
 =?us-ascii?Q?5owu6HTVBjbDN5SvswYqlConi9G40Mx4WCroe83xwb9jOHEPiuwmKt1h1eYt?=
 =?us-ascii?Q?hnfc7N9Zv9u3+AqT45RReYMf3+LRQfRV1G8ISPuMlX2pCIdmM0Pggg5Uq/Ca?=
 =?us-ascii?Q?lAn29KpsUbFPO22K6dF38YQvrNhaAYn+aF0L8xeTezGx0XBHiDSo4DPsbgBq?=
 =?us-ascii?Q?rRFigW6lbAv7j145X/a03EIQIuBIQxZwprHMyt1Te5wTwWm4uh0mB49yz81h?=
 =?us-ascii?Q?DixHKdAzgNqAQ7vdm6hVf9vqqbDpRarji/URtMZt1dnEbIQdayDvaOmbr5sX?=
 =?us-ascii?Q?p8Uc8NLAC08V7RwI9VpWxYCPUayYX8wK9D8xj3ytTBNLU1ZCpdLZ1lGXvdOU?=
 =?us-ascii?Q?nchXv39hK3UypTNN6ADk7FznvH1H17SqVh4RbTRJqBqZO6oUWYpxlinExFAI?=
 =?us-ascii?Q?E2aOBgpP+mkHvBcuQD9fPlixZa4E3EHG177vZJN7+9XRildg9ZeDOeFB3wfO?=
 =?us-ascii?Q?Ho5FT7vUOlrliQ7eMqgDQTye3/L0aOsvn5wkR5omdOO1o/9GIBRgGi3Mv9Dy?=
 =?us-ascii?Q?VQsoiiTCheVzkEyp6yWXuxwKVi13XqoMSfY27aQ5SfVwg5EmMgBUkdflmaGL?=
 =?us-ascii?Q?U+p8gSW9m96fDtCf1xKqOtudPsRb5z0X9icQaueno5lHvkAVATAvARHWBfk9?=
 =?us-ascii?Q?6x0QTRm04FQCQjcLlxVb3Z6ByDuZDDPCqHh4dRBvTuOSFC03V431xEFUwSF/?=
 =?us-ascii?Q?pBd3cg2vG7yr22LjO42qSDH6Uaz3cKYc6qxhTMwtPISC7B0LImOd0pwyWhXo?=
 =?us-ascii?Q?k9QpPQjXwaKTHJGsfoIHVqnLpBfmeblpTXuC4hTlw4IhvSnzOy2tIx0uolLs?=
 =?us-ascii?Q?Sq1vbeO0oqzVsduiWchmqWMNgLvwLyjoHXmPJRKlJo2PX4KajUmCTY4GoNWg?=
 =?us-ascii?Q?MYFXZ15Sf3QzaE+mgaFqkS3MB1VAKzb2aFjzOV1e7l1bJPDKx3h9wUPh3+qJ?=
 =?us-ascii?Q?o5v/2PHPT4US3zTSu791+JXxTrW/M2CxHxNZOq/1J3YgkY8l9GTAFaXXcRba?=
 =?us-ascii?Q?aQHgxhAbWxUrcKMcz4y8PLlalH/Y8K6JeJIPtNUoTVVSWN5rf5KgKY3UYTzx?=
 =?us-ascii?Q?YVtS90hY3g+vdJHtkUpOQLxAheJ+JxGbp1myy2lEeJekDrxqyipTPPflfJNV?=
 =?us-ascii?Q?1GbhNvLAHGDArs966lQUoZ/r1bKlF8IHSicFLqlhVqFpfQbof7iPpHkZ5xks?=
 =?us-ascii?Q?MPJe2RjUtHeTfdY6F0gHPnusvKsXnn5H5VY46FsxQzjpXXyUj2rN4DLSKQrm?=
 =?us-ascii?Q?Oc+U6JDZHDPi0Bmcfa/5TEXirkDtWZoW3IeAUCr3zVDbw6lSXndTBJWnOTq6?=
 =?us-ascii?Q?xgsfvAFP+fGm8UH0SlGvRgODrzW4xztPCxv05MjBqQS23u+QYr5RP2fCevkD?=
 =?us-ascii?Q?gPuUFFFmdUo4yT7mSJbe2g45/vWt7jVV6rM+KogT2YdDnAk1mk+5JT4nMKQt?=
 =?us-ascii?Q?T1qf7V/m7mXqxWH8PTj+jvwx2iXWJ1ZlBhkReBty+/3GhLbKbVMnd3Mo18ST?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e085a96-7923-470d-c601-08ddaa7f5d1f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 13:36:55.9267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIMgI0tky/pQtaAJ908sqRiG1s8Vsl+nRhgtbyusEgFH9RdMf1JYkWKB9Q4LSZclvA9TrZyQNxWvPMvYY1GCA6EJWLcj4Uz1GZlKr+arMa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8597
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

On Thu, Jun 12, 2025 at 12:11:06PM +0100, Anatoly Burakov wrote:
> There is certain amount of duplication between different ixgbe, i40e, ice, and
> iavf. This patchset specifically focuses on laying groundwork for deduplicating
> the Rx side of things - providing common queue definitions, using common Rx
> descriptor formats, and some low hanging fruit in terms of Rx code
> deduplication, including vectorized implementations.
> 
> The first bunch of patches focus on small cleanups:
> 
> - variable renames
> - definition renames
> - using one definition for 16-byte descriptors instead per-driver
> - fixing some cruft in IXGBE headers and source code
> - refactoring of IXGBE vector code
> - removing support for 16-byte descriptors from IAVF
> 
> Starting with patch 23 comes the meat of the patchset:
> 
> - creating common Rx queue structure
> - unifying Rx rearm code to make use of new unified structures and definitions
> - expanding Rx rearm code to have SSE, AVX2, and AVX512 implementations
> 
> At the end, there are a couple of patches that unify Rx and Tx mbuf recycle
> for some drivers, but more work is needed on that front because we only touch
> two drivers in each case - the others do have them, but they're implemented
> differently from the ones that were deduplicated.
> 

<snip>

>  53 files changed, 2104 insertions(+), 3163 deletions(-)

Series applied to dpdk-next-net intel.

Great to see the driver codebase lightened by an extra 1k LOC.

Thanks,
/Bruce
