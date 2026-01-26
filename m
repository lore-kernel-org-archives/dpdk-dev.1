Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BE7C88E78
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 09:02:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21634402BA;
	Mon, 26 Jan 2026 10:02:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 9DEE0402B6
 for <dev@dpdk.org>; Mon, 26 Jan 2026 10:02:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769418174; x=1800954174;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=9gOmfcGsb+PWKTyRqDXSJRcjtIFslnRFVeKClto7108=;
 b=CzkehDsYkYVJAaHWBTaefEqa3QV05kljxI/IIqLtyP7VZ2VRUxoxaRUk
 vRhbITZsiCMo9xH8xHQLYoYH59jmBqu8DgRAXEWbe/mpbobv7IxWkAPRu
 vwYB8OqJw0LnjfaL8HyWEkeoNSwLPesO6FJKiw91gGCZllMUMz/wbdyd2
 kN9+jtNN6H+UzIdrBOPmkd2BvGRo8qjX328+LJvq7AaI4YGCh5ijLYnPM
 +fTeStofbsIyCxSA8Gz+byVL8Z+fPX3RVFYClw/XUNDq7mJPFlttAvFTZ
 hIqSM3hE30Mz/fFwlWpMms9ru1FR4Rc0+rwRx8FII4mt4/i9b5IUHWgtG w==;
X-CSE-ConnectionGUID: 2KzcCVPSS1SQQuXa9HXXAQ==
X-CSE-MsgGUID: F3m0g27GQ2SUKPPfBiXTkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="88174233"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; d="scan'208";a="88174233"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 01:02:52 -0800
X-CSE-ConnectionGUID: GS2/mBG2QxSFIcAshajJHA==
X-CSE-MsgGUID: NYqfZLBJTxGh3PO/PGbjxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; d="scan'208";a="212612622"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 01:02:52 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 01:02:50 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 01:02:50 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 01:02:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMhq4140GjaUAwfF8yQvc0wgDmAorrF+VtFfeCgZtHA5vBcEWeaXHVKyQEK1IwBVGKjch2tFLr8edgZT1H6e5UTYJ61vsCYIMc8uDU1hshWZMKGgxVO6PPVtTPSXhIEGXEYEjSo5httyVEph0kQv98Cskow9mjz0GshKtfKibgFMxORk4fCPly0yrVY29QFpcCg6iEYTotdMlA6w+vlcZW9N7A3ODyKgQiqKBRN42A/TAZLIyFoxPSimu9v969/zY1stt/T5zVe1pLKiQAdnyIhS0VDy8iDdCAyfBp1DAk7eBCikik9e+QfiPE2S62RVwM88DrfRnAEuOplbvConYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5I4LiiQfnS6Egav9esjBjUL8F2HVVphZ2X25KwHU7gY=;
 b=P5tuEjYN+nVUvRYMAjsIi5S3nblxQEvDhoQO3ouS5UTAaf1LNeIkqfP7jz3xWkhAYMHvvVHqWYjwnXebS6n+zX6ibGbJZVCOPUjib8Zm8/kHfG7iUnHsu/y2iKvJZV3Kk0mOmu0YElpCrgndvDwOCdFcwl9NbHnCcrmDV2uWXbrbc8FdPR52GQLr3fckJXSO8u3OzMAhj+Ac9WauuLobiDKiWp2RP1AjO6eVQj3922LIWp1g5k3RM0n5WN3qzG3LNWAufukdqwcj0sx/fD+i2LCSmQPT64S7bZi9pyac3B2r46zQATWBOtoJ90JTb3xJ5Ebz6DuWM2FZU2xYWGk/pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6347.namprd11.prod.outlook.com (2603:10b6:208:388::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 09:02:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 09:02:48 +0000
Date: Mon, 26 Jan 2026 09:02:43 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 00/36] combine multiple Intel scalar Tx paths
Message-ID: <aXcts-AhjuXinBhr@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260113151505.1871271-1-bruce.richardson@intel.com>
 <20260122222053.55cb8cbf@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260122222053.55cb8cbf@phoenix.local>
X-ClientProxiedBy: DUZPR01CA0240.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 74fbe523-4683-420e-f4e8-08de5cb9ad7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ik4ct/TGnzOWqI6Lxiymn+pIdIgvKW2UOWfa5pt57/VgWekP8KiNCTiGRzl4?=
 =?us-ascii?Q?SAO1u2jARXwyQKEJ5DRrF2uySg9NXJ+I/TXcu+6zhSXTC8NFl56tRckXv+sj?=
 =?us-ascii?Q?8o1W4q17lhO13rfsAl7f1GjbpYi4MTB72ZubN2+6PxkL9aaM+8lv7A/FY+QB?=
 =?us-ascii?Q?7lFltNERuw5BZiBvfla++yr9GEiRqxpDznteV0WiPOs6aXt1P90MazUtFpiO?=
 =?us-ascii?Q?/8jaYwan9dWZogQl+Pyut3MGzb93TakKQ2KLTAMJpwzcknji6JLjwhZLGjPF?=
 =?us-ascii?Q?odOe4+4Tq+6Lt4JuFqoOt8tU9QxRxH4HVtnwamVTD6P06FZCmiNL0sy/UMMi?=
 =?us-ascii?Q?HNcvkqfq8+t0B003+J3C+OtlzxmKZI6o4IikFW1PaYw0RhtPCfilkRPR74UO?=
 =?us-ascii?Q?eVIEqfvfvgFhDIs+L3nvYMDqX6IY6eeTfidDq/Z7jtIo3ecEbAY1lFhu7Ygq?=
 =?us-ascii?Q?Vpikm7Stb3pIMOhRbjwdc/g4vY9mVuiwuT2a8maEbkqmyCyhXDs37X2GILLM?=
 =?us-ascii?Q?/he/Cxl5iJyCLH73DIqERvkhX6ktoEESbfk4z59nNhTAmA2clzFM4Yb5WIdL?=
 =?us-ascii?Q?KkoQ9bNUGqpP83LMemhakfu3KfhPC7i0vuS88YpJwhSgGuI3PFqrtY9Acbc5?=
 =?us-ascii?Q?WCh1epMr8wlp8xLec2j5CLd6nyw8OlieLh1tvIHIqN1VlbXCUbseDLW0GY/x?=
 =?us-ascii?Q?/sNvRXkLpzJcQNQp494JaXBX/5XWrIi3tYMH2gKOEv2+mjPx1IwXK9f4vG9y?=
 =?us-ascii?Q?mJ+92te9JuM1Mc2hR8VTEv/p6oWRcI3JXUG5LjblrDV/9OOKQXXH2+Nfn7wZ?=
 =?us-ascii?Q?TELHn0yqUn3AgSxeLZrUAMAcJ9dntZehQLvwTyzhk/Uj8I6Iaiu318jlStZa?=
 =?us-ascii?Q?IFZqKFZa0W1bETl7/IEPohNB1MUy/RZZvN6V7JABtWWOaxQGMsvW2NNpM25Z?=
 =?us-ascii?Q?kFje/aelN7+vXuiUVmLGiGKIy/dMn+yna45NQQqDGPmuWDx0vWvFPrN2M2je?=
 =?us-ascii?Q?OSENLog6U/GbLrJwNqejksuXSzkOD1cUyk07jAcTKIx0RnZApItLQTW4HU1W?=
 =?us-ascii?Q?GI6gXwGl5EhaxHVYwCOaFzKm1tw4OEg22HXAP9DDlLlh65sRrqIx9p13zZzI?=
 =?us-ascii?Q?SuuqZINQyXl1vdfvRX8vGEHgZWYuQo9vDQ6AZrNGOc9Y1qp0jkCV2MxgnWWc?=
 =?us-ascii?Q?UUd/FOOMjLag676R0sQn3ygiKJTakRESbNbCu1MS/29GMJzwN5/Fp5lhyaLe?=
 =?us-ascii?Q?mvUh8EdnBmCWFkOog13HT5AII19gi2bbMR713pHXX96FsYshDrrE3ig5/JrO?=
 =?us-ascii?Q?w3biCOXOrEGpcSE7qpZtsu4UoXe20BB2tv/epjJZMgRMzlZK0PBfLZTNd0Id?=
 =?us-ascii?Q?8w/pf/rSAU9HyR9o+WrOE+sPMqF38ANwD2tba0UWqZ8cfl5qobwZ01cjp23D?=
 =?us-ascii?Q?BGKZ4SF4sHKATZmMlQnABo3NEJBFlfmvZaW5AQ+6L5G3oU89cfkWnQZyDxx4?=
 =?us-ascii?Q?9NkaccNWx0Nq1xjgRtLtB7q7Qbn6kJPLkWfNSY56uCCfDpE/OXjjqF6I6bJW?=
 =?us-ascii?Q?0c3+ki7+nl2J84oPMqE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QvoYHlyqTV3MdzbarXHWn7o5sYrXoAIYFWAX7UP6UoUuZfQrZsYclge8Hgid?=
 =?us-ascii?Q?dheAd4fOcYXFCQL0AavhZLe0ftQm2H11lYlS6p+80p1SzJsSEufavoVxyeaD?=
 =?us-ascii?Q?KpTZKfbmOOpezuu+kFaUX7MoWQ5XV5iOYovlMiJZB4sxg+grTDn6eAehRC+7?=
 =?us-ascii?Q?duZPcLPVJN9pdF33P/81s4BtiPndAOFNf/rWetS25xUfxpQTq+8wjPdTkLXW?=
 =?us-ascii?Q?PmB46QvdUYc17QZ6zUr2hoOUIkx3xJbiOxt1Ax++5UzIXSwsZf+7sSkOM3r3?=
 =?us-ascii?Q?/tZb+QlG1q6AuyAfLgUG6XPCXHFWXYJYLJaw2CxSpwlhkOSiKTrNK3qT+ACq?=
 =?us-ascii?Q?2iUCJGaC5hJb/30+DKK9vcuqY5FwBakGj6Sped4Y2LAmOafXRpao0PaFA6BH?=
 =?us-ascii?Q?vDK+aI8Kb2pPe0WV/YPj55Cb3oc7eFf2LfP8fJF2XRu0riKTtQn1c1e60N6/?=
 =?us-ascii?Q?zM0pkTPFavopMNl0jLjPrTStuojudOCAbVyM0dsyEHM2RXnOlgl3rkWyUHh4?=
 =?us-ascii?Q?yWqlQbNea9k1YoXcNnTManhIfFuCaq4mCubvieaFzVQiKSYZp/sj5/O3QYnh?=
 =?us-ascii?Q?nOY//xCgFJcreCT47AKWqqx9CBjkz0CucvCCrqnS7AeoD1W5gMGzJuTlm1pZ?=
 =?us-ascii?Q?XncyvycNoKI0MlMrPydE1wnnpNL6zVhnj6dONq1fO0ACWJG/g0I93wmNwyUV?=
 =?us-ascii?Q?zLnOcUMVH9zieNcL7q0Fwe06fJrJVZ3pdlBonm8QP8ZFI4LPDjIG3kHSBxtx?=
 =?us-ascii?Q?mK6YOFYG5SzGz5WIfv0Hot4qMvdjoMvbaqFaJRAt1msq5O9kYgwLIRF7KjgC?=
 =?us-ascii?Q?uAeS/Qu0WXEGdETcKds9zLadxBrgftVodQ21gi6lWv6c8ArlfWmN3WgVqn8y?=
 =?us-ascii?Q?nlYjFgFxucXPJiww0kO2VEAABsLbRjEPBx3140/KUkSWZsUn3j1Qeu6D+0n+?=
 =?us-ascii?Q?q8S642njnAPgfutX4gfK3v3GeXTMRRW59mVSKXfX9g0A8pF0INaXW5BqBx9S?=
 =?us-ascii?Q?g83bB8+wOXXIMrjJgxCesMK32N3PGN67aHAMdZsJfe97Qgv3QOhuQr9tcL/1?=
 =?us-ascii?Q?rW9lczikSnRmfd/OJInSApmTLn4nfdRC0qAiuuFvCjWa+xbcd2yAD9Wtow1P?=
 =?us-ascii?Q?Hxc1E6fI5RdM1ZylKP8bVYds6yF1rvf1l9hgfZTsoeY1Ac6+4GXbhiViJIOi?=
 =?us-ascii?Q?gX3PNNN7x3ou7KFUVZX45xvTg1FjwfGwQUTmVmkcThOD5qHlJ4czl6QAHeAA?=
 =?us-ascii?Q?BABuhvlgkq7T5f9AyAUpqJCW2sFP6Ry5W0VR2Nk4Kr/tNnwe4W9g1djzqFc4?=
 =?us-ascii?Q?2HUosVLN0T/TJt6X1Rnwum9iY81TVQ8fqcXYVpSHLxFmIrax+1ApD2q5/+Ga?=
 =?us-ascii?Q?zuZCLQzCRslcmsAa9paeGnKIZ8vpo+IDhoEUZfzt6G33JEjUaG/fuHbkoCUh?=
 =?us-ascii?Q?8Y4v0liX16osIQitK++EX2HJSSE2AcvRhJNL7A6xkeS9Fq6fCaXIbs+PKdpW?=
 =?us-ascii?Q?6skoU3I/DTvk2nbi8gvprweMcK5F4ymvA7jmNp9DNJjbtkKcQXJuFmvxv//O?=
 =?us-ascii?Q?ACfLQEV8Mu+ZYeW2OaPWOphJ+XodoIjMAnhj4BEJ9c3yCzcIEy9GmyIUOsZQ?=
 =?us-ascii?Q?btaxE1EsKjKzKkV8DkMFygNX9HEgdHOnkKol7KvoR26f+R9v8IbqwU/eFUWL?=
 =?us-ascii?Q?2oq9dYVU9FPxEvIPyO4UHVDs08lxxEdPk3qZNd3uRc7fw14rM5Ih86JyFo6n?=
 =?us-ascii?Q?rDyihXg1X40ETX67+LhcJNCyqyg06QM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fbe523-4683-420e-f4e8-08de5cb9ad7d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 09:02:48.4746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzOGlvlev7BtKWbjlLE9no3bJ+ypom4IGf+OjWYcN24k9jlAgYKWW7PT5BHyI2x2e2yHBEORVjL9GGlTfWa/OoE04DOmM7nfL2z6Rphd/84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6347
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

On Thu, Jan 22, 2026 at 10:26:33PM -0800, Stephen Hemminger wrote:
> On Tue, 13 Jan 2026 15:14:24 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > The scalar Tx paths, with support for offloads and multiple mbufs
> > per packet, are almost identical across drivers ice, i40e, iavf and
> > the single-queue mode of idpf. Therefore, we can do some rework to
> > combine these code paths into a single function which is parameterized
> > by compile-time constants, allowing code saving to give us a single
> > path to optimize and maintain - apart from edge cases like IPSec
> > support in iavf.
> > 
> > The ixgbe driver has a number of similarities too, which we take
> > advantage of where we can, but the overall descriptor format is
> > sufficiently different that its main scalar code path is kept
> > separate.
> > 
> > Once merged, we can then optimize the drivers a bit to improve
> > performance, and also easily extend some drivers to use additional
> > paths for better performance, e.g. add the "simple scalar" path
> > to IDPF driver for better performance on platforms without AVX.
> > 
> > V2:
> >  - reworked the simple-scalar path as well as full scalar one
> >  - added simple scalar path support to idpf driver
> >  - small cleanups, e.g. issues flagged by checkpatch
> > 
> > Bruce Richardson (36):
> >   net/intel: create common Tx descriptor structure
> >   net/intel: use common Tx ring structure
> >   net/intel: create common post-Tx cleanup function
> >   net/intel: consolidate definitions for Tx desc fields
> >   net/intel: create separate header for Tx scalar fns
> >   net/intel: add common fn to calculate needed descriptors
> >   net/ice: refactor context descriptor handling
> >   net/i40e: refactor context descriptor handling
> >   net/idpf: refactor context descriptor handling
> >   net/intel: consolidate checksum mask definition
> >   net/intel: create common checksum Tx offload function
> >   net/intel: create a common scalar Tx function
> >   net/i40e: use common scalar Tx function
> >   net/intel: add IPsec hooks to common Tx function
> >   net/intel: support configurable VLAN tag insertion on Tx
> >   net/iavf: use common scalar Tx function
> >   net/i40e: document requirement for QinQ support
> >   net/idpf: use common scalar Tx function
> >   net/intel: avoid writing the final pkt descriptor twice
> >   eal: add macro for marking assumed alignment
> >   net/intel: write descriptors using non-volatile pointers
> >   net/intel: remove unnecessary flag clearing
> >   net/intel: mark mid-burst ring cleanup as unlikely
> >   net/intel: add special handling for single desc packets
> >   net/intel: use separate array for desc status tracking
> >   net/ixgbe: use separate array for desc status tracking
> >   net/intel: drop unused Tx queue used count
> >   net/intel: remove index for tracking end of packet
> >   net/intel: merge ring writes in simple Tx for ice and i40e
> >   net/intel: consolidate ice and i40e buffer free function
> >   net/intel: complete merging simple Tx paths
> >   net/intel: use non-volatile stores in simple Tx function
> >   net/intel: align scalar simple Tx path with vector logic
> >   net/intel: use vector SW ring entry for simple path
> >   net/intel: use vector mbuf cleanup from simple scalar path
> >   net/idpf: enable simple Tx function
> > 
> >  doc/guides/nics/i40e.rst                      |  18 +
> >  drivers/net/intel/common/tx.h                 | 116 ++-
> >  drivers/net/intel/common/tx_scalar_fns.h      | 595 ++++++++++++++
> >  drivers/net/intel/cpfl/cpfl_rxtx.c            |   8 +-
> >  drivers/net/intel/i40e/i40e_fdir.c            |  34 +-
> >  drivers/net/intel/i40e/i40e_rxtx.c            | 670 +++-------------
> >  drivers/net/intel/i40e/i40e_rxtx.h            |  16 -
> >  .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |  25 +-
> >  drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  36 +-
> >  drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  52 +-
> >  drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   6 +-
> >  drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  25 +-
> >  drivers/net/intel/iavf/iavf_rxtx.c            | 642 ++++-----------
> >  drivers/net/intel/iavf/iavf_rxtx.h            |  30 +-
> >  drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  55 +-
> >  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 104 +--
> >  drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  36 +-
> >  drivers/net/intel/ice/ice_dcf_ethdev.c        |  10 +-
> >  drivers/net/intel/ice/ice_rxtx.c              | 737 ++++--------------
> >  drivers/net/intel/ice/ice_rxtx.h              |  15 -
> >  drivers/net/intel/ice/ice_rxtx_vec_avx2.c     |  55 +-
> >  drivers/net/intel/ice/ice_rxtx_vec_avx512.c   |  53 +-
> >  drivers/net/intel/ice/ice_rxtx_vec_common.h   |  43 +-
> >  drivers/net/intel/idpf/idpf_common_device.h   |   2 +
> >  drivers/net/intel/idpf/idpf_common_rxtx.c     | 315 ++------
> >  drivers/net/intel/idpf/idpf_common_rxtx.h     |  24 +-
> >  .../net/intel/idpf/idpf_common_rxtx_avx2.c    |  53 +-
> >  .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  55 +-
> >  drivers/net/intel/idpf/idpf_rxtx.c            |  43 +-
> >  drivers/net/intel/idpf/idpf_rxtx_vec_common.h |   6 +-
> >  drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 103 ++-
> >  .../net/intel/ixgbe/ixgbe_rxtx_vec_common.c   |   3 +-
> >  lib/eal/include/rte_common.h                  |   6 +
> >  33 files changed, 1565 insertions(+), 2426 deletions(-)
> >  create mode 100644 drivers/net/intel/common/tx_scalar_fns.h
> > 
> 
> Series-Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> Love to see common code and "fix it once"
> It was too large for the batch scripts, but here is AI review.
> It sees only minor stuff which you could fix (or skip).
> 

Thanks for running the AI review.

> # DPDK Patch Review: Intel Tx Consolidation Series
> 
> **Series:** [PATCH v2 01-36/36] Intel Tx driver consolidation  
> **Author:** Bruce Richardson <bruce.richardson@intel.com>  
> **Review Date:** 2026-01-22  
> **Review Against:** AGENTS.md (DPDK Code Review Guidelines)
> 
> ---
> 
> ## Executive Summary
> 
> This 36-patch series consolidates Tx descriptor handling across Intel network drivers (i40e, iavf, ice, idpf, ixgbe). Overall the patches are **well-structured** with proper code organization, but there are several **issues requiring attention** before merge.
> 
> | Severity | Count | Summary |
> |----------|-------|---------|
> | **Error** | 1 | Source code line exceeds 100 characters |
> | **Warning** | 5 | Commit message style issues, double blank lines |
> | **Info** | 2 | Minor style observations |
> 
> ---
> 
> ## Detailed Findings
> 
> ### ERRORS (Must Fix)
> 
> #### 1. Source Code Line Length Violation
> **Patch 17/36:** `net/i40e: document requirement for QinQ support`  
> **Location:** `drivers/net/intel/i40e/i40e_rxtx.c`  
> **Issue:** Line exceeds 100-character limit (135 characters)
> 
> ```c
> PMD_DRV_LOG(WARNING, "Double VLAN insertion may not work correctly without RTE_ETH_RX_OFFLOAD_VLAN_EXTEND set in Rx configuration.");
> ```
> 
> **Fix:** Split the log message across multiple lines or into multiple log calls:
> ```c
> PMD_DRV_LOG(WARNING, "Double VLAN insertion may not work correctly "
>             "without RTE_ETH_RX_OFFLOAD_VLAN_EXTEND in Rx config.");
> ```
> 

This is one where the AI guidelines need an update. We need to teach it
that it's better to have a long line than to split error messages.

/Bruce
