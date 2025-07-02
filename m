Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4471CC77B7C
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 13:56:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B550402A0;
	Wed,  2 Jul 2025 15:56:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id DC03140285;
 Wed,  2 Jul 2025 15:56:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751464588; x=1783000588;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=c8C9hHiL0vhaydmiVNNGOeejQ183/mWZ3BkS3kc5+LE=;
 b=XrxUmPaB7ZpflauVwjrPmdwqghqOs2oDhOFRNxuzNoOK0uEqNphZlxdT
 o3nzAVell5ZH0WtvTW5kq9HmmIuL9Y1/0e4nj35hdlK51kthXaK8gf0KZ
 aktiBIOv+sIoYzEnWQLra9tl8b9qo2x3D94NCfsc0Cyj7WhiuzR48SWlf
 jvl+6Th7WI4ZhgC7axVyBAO/QeBYxmQJl5nazm2Mj4Em+GW+1SRaDZYUw
 In1G96Q2kwNiZCdULPyy41MnlttsVcsgnLuOwLpCWKHid54RjUiz6Vsdp
 CVi+43XTmuHeX+LLeQLEMbEy8ngREApLJQtZcs9Bwk2DbA2dlwF0AEVxH Q==;
X-CSE-ConnectionGUID: mco+l4NNR1m35zyI1DrRgg==
X-CSE-MsgGUID: +187r3QqT3ioaY2s6L1xWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53484205"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="53484205"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 06:56:27 -0700
X-CSE-ConnectionGUID: BmDZ2lQlR5WnjVxLquct9w==
X-CSE-MsgGUID: BOYf1l89SsWd73qwQugCLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="153855491"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 06:56:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 06:56:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 06:56:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.79)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 06:56:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIR5b/br4rtXdz3NRgznJtjwvvpyoXZELn2VmNT0GKgjSonSoStD0K1x8ttPDhe+JIEJ/Q4a4MOXsvFXRw5BUH8EPV6gh+JLWef23ffer3ekl/hzilHVrb/VrYXeb9qTSFhbMrX3jyHU+ctHT7x1dgBVrjNs0VoDyJsC5Yz7799V5dO3I0ZHFsjdPmTfP9s4ftZXmVBXlLWuDVEfPgs9VXnqyf/+lrl4kJ/rTzUoh1KvDnMbjqf7+krsvrI32aRTIyC9/xzmzocr84cV9HfHS1g+5L/0dm7025Q8aStJqJB/zMH0Q0TuPm6BXML2O7BF5wtDsTehK8TJDX730boJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCzFVGgpGC90XP91qBYkWmi9oQudA5YNwg2zDEBe4c8=;
 b=gFVBLcesmJxg30INb2GqgKFdn9P04RTRIEnkzeDo2YlKC3vBQXzMMHhSV+N2vOkBj6KmR0MT8vMAcF9ethPvbSv/B5piae3PUqhZVJoPNYVjOWaCvPUl/nhWumXKDk/vDkONSAjkHvA1AX/1jxaQXPbOfPSsE74JyjqadPCMFH5+gguFHH5z/Gp16VK0LucBquxYV++F+mjXFuVogkbYuAP+kXTWjmsRPhwoU0wOcKJvW1skXwc9MSFJFX47bEVjhVJa+igWYdX1oCZukEocdvMXIr/5eaB+hQu6X6elZaBja2pH33v9ymhvSg1GzxZT4B3EjR9Ykp0v6GF75/Ec4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB4969.namprd11.prod.outlook.com (2603:10b6:806:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 13:56:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 13:56:23 +0000
Date: Wed, 2 Jul 2025 14:56:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] doc: clarify disabling AVX-512 when building on Haswell
 CPUs
Message-ID: <aGU6gytRyMaNaZQg@bricha3-mobl1.ger.corp.intel.com>
References: <20250702133649.1931134-1-14pwcse1224@uetpeshawar.edu.pk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250702133649.1931134-1-14pwcse1224@uetpeshawar.edu.pk>
X-ClientProxiedBy: DUZPR01CA0052.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB4969:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd48818-539f-4c9a-da34-08ddb9703b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jFpij89mgILRDW4vyWSBi2oS1QnzrozcqM8gmBYjd8olW9A2WFD9icpOHBO8?=
 =?us-ascii?Q?pIEsBuHJcKIEnT88PEv5yOsRMHX/tLHdbdJ9FudUjNXNs7W9alJXtgeiaDEP?=
 =?us-ascii?Q?jmxSw0nyIsK43uG4ZyB8zDw/feYhXh09eJGmxtG9JavO3Qd+Zf1Hdrbf8VvE?=
 =?us-ascii?Q?i5jgU6UpxcgWBd+steSiMeQ1q5US/inuKi3JrIhSlmotzo77x1zw5jQWBsdx?=
 =?us-ascii?Q?W/9/M7WyIFINx8TEnU5D2RyPsIbKH9Fk1+PwvYqG+6QfH/8MQeFUS6QC/52Z?=
 =?us-ascii?Q?216SQZrbSRXyr38PVNksT5IYrJkn1t6L2KsoqZTZU4dcIdxww7cbVaz2cQJ/?=
 =?us-ascii?Q?7B8o1eLGohRdxrn1CGyreL1fMHyMKHrTLbXc3kdxU38knYBQL8NsHQ1Af6K6?=
 =?us-ascii?Q?IqpD46ZgTw/kegZHiVeRAqrjL4J3HWMCC2Bpv6BR6GrSbiz0IJIx3WZY0XDw?=
 =?us-ascii?Q?GP9tIv6T+lPtjjYXlJjRgF4RBYWZmRKywXeS/WjWOwKqLfDJR7ynrKX4lBXt?=
 =?us-ascii?Q?nqpl4QqukV5yvgDU3s6QIfjFYH+rXGzoD+iX8OQu0DXo7m88Nc/NPzNU+aeF?=
 =?us-ascii?Q?xHysrQf1KD/DiBVN1Tm/tyjcbTeIgqPD6xgIBx1xgtI/tT6WUajfLxRdD4bO?=
 =?us-ascii?Q?4nMla5VTDaSTqomdqQJSWwTGKjWzTTttE4fzf4CAwi/gPpgzGhkoK+DesMP4?=
 =?us-ascii?Q?Lb2C1zN6Sv4ml1Lcfz6WfVgWVHjM5yd/UZmc2netpGr+aeK+X2QOFAWp6pK0?=
 =?us-ascii?Q?gaHZHLBcDLKvGTxUdAiWFqBAJngvcBizmjmr2zVfxWLYzvPidv5ludDpUyAt?=
 =?us-ascii?Q?FrjsEY06EowycwaY9wAjF49rX1C+pLN+Sxghfy6orHt9JhBASPWHdiz73lAv?=
 =?us-ascii?Q?wXo/EFX+2mzeV38xp7OpqaUlgfBe4r6TeqHYkWI9EPWDnzoJo0ph0m7a4LpG?=
 =?us-ascii?Q?Ox30tv6CxZEnKf/z9i8NYBjNYySFUCIUjtFmp7UYgzbFjUchOzbaixylHzFc?=
 =?us-ascii?Q?nhlziSiToSd3eM/bc/Sj0B4388qNsm+U9ELFymPHH9v8A+QJUwgvDgqLrvKF?=
 =?us-ascii?Q?KR/bIrmHCcO4lyW86s9meNycd6Pz2JvpRCgV+oO1rlb0h4Njk6YIWQv07+wz?=
 =?us-ascii?Q?NNfT3TsBMtbQbpc/ltUvMm8SKexVZdBM/1VrhJycoVMxenzcH9UcM2+mk9fK?=
 =?us-ascii?Q?vKxQWReJdP0SL74SwYW8ey6xObQEo73MccwCGPuOP1tmw7W4OuRSzZ9RwzUL?=
 =?us-ascii?Q?XWuVa0c0WpWfMYVxN2FJlIjNcdi6vNzp8/L7SxffzRJdbWESZd6PUQYJQDwD?=
 =?us-ascii?Q?quXvPEVTPvnSA5iweqndcLE3gL7AXgqbt3Wo2RlpIifKYoSTWgQXCbgrXBBT?=
 =?us-ascii?Q?xJHdNHWWXRn+7KFf5HfzMrNIAgodelW1B2ZjuVgFWVBsmCtEUg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UTxzBfDbc7WqRZ71zd2WL2pFQ/p0VdmWwexop+kSF5nFVjBKhKRyjRXYOoS9?=
 =?us-ascii?Q?SVbQMrZlpaemXtow/mrbUCmKDovj1jjffI6yRQbbmVNK5gOjQn28IH8e3AJq?=
 =?us-ascii?Q?mO/pafdDA4wC5exrUX+Vhw9/tjw4OCCyu3utgiICLgaNQoYBcKeGkfMlBwY7?=
 =?us-ascii?Q?+WzYAXU21Mp75JdkNtK90xf0QCv/jo0/k+PM9vpvjW46jlgUcco+aF0bProK?=
 =?us-ascii?Q?o3Wf6KxsjztLrEbvqkmX6XfFbY8OQcFz7lIqq3D0s6FPDbeTwnuVNF8a8WJp?=
 =?us-ascii?Q?Yiu48MN3DXl4eAXlt86XaD8lNsliiCIh54r2YoofFws5qFmWvadrvQHDEIBV?=
 =?us-ascii?Q?lItU3F7CD0LPfV7BgDM9bBREZVEU+Rd7oGxtQXj0+GJY0FG+L9Y53o5nVlt2?=
 =?us-ascii?Q?TEZvae7w0c83stapgB6snVqLwvtgIMUf75orwdVamiAyoRqsWjicpDyYhj6I?=
 =?us-ascii?Q?moY+avy8DRNdrAaYi7ObzZkVNGLLfW5kXuTYSNuFL7Ngngp/2ATo/CFsLb18?=
 =?us-ascii?Q?5gQiFzfOk5nFBK4SMKV8zTqc2lb5x1sfmwai+RMmnhqocrFEeAYk1S7uYMRD?=
 =?us-ascii?Q?Nrqu1nyuQGaYopOvZUmJk0peCGTVh2Mo4Wd1UAffuCzHDzTYzlkTLx8aXwK+?=
 =?us-ascii?Q?sf/Hnp6It6CjDk7Bl6XL9IfuiAOz9JzTgr681+9wDS5U1S3qW3wOOQVo14Cf?=
 =?us-ascii?Q?yp0gTJur55hB5hpRRjwKXXXiJGzu60p9vHKEJM7X6DplQkxH8fil4ewtBLWa?=
 =?us-ascii?Q?BjinARhV32DqboRKYOyZnv4NzeIcHjk0EW5swSKhKzNJFAGrGZ6WcNYEIwf0?=
 =?us-ascii?Q?VD6qc7XqratNUV1f77zpnh395UHQ6JK8XNEhLNWKIPRSePKYodbnnRDUPVOS?=
 =?us-ascii?Q?3Q9AmkKEhg/14iz1+yzoHG4QIDrczmt4wkXo/KoAYDLlPPD4Nmg06YnQG34d?=
 =?us-ascii?Q?SCamkzcuRuTCJn1Rm1w8x0W6j8OD0Iv8/c2LCS0IOLAqP+QLcFtW0YSIDBZ6?=
 =?us-ascii?Q?TDtwrBVx/6Wip1K3VyWx+m7pRsLR+ZIYKIneIz8byaFvPaRSx/kbdZiS/C+/?=
 =?us-ascii?Q?BdSx2sMqgU1AYx2ZZmb2QYVUQjCvhAwuiiEZ7RQwGNR2ktfLcCPcB7ss2+0s?=
 =?us-ascii?Q?2EAzZtWVCC0D3oojDyly9zf/dPVZs3O/FrXvM7WLXi8gJZ/Y7vr0ylf/yv34?=
 =?us-ascii?Q?+4B6nPMzm66TG+D3QPQbtAb452nG2M9f392noW2MAx3tK/jFSxoVerNex9Tw?=
 =?us-ascii?Q?cilM49juSqK0vyiVabIirnCFBja0BTjTritqbOrApb64ET0uEpizrugVWHV6?=
 =?us-ascii?Q?I52osBxN3RbViSP9HVsliLou8I04IixTx6gZmtCx2pzsh/D4BR6fJD55LWVK?=
 =?us-ascii?Q?nrgD2O9RPVdxQJLNl4GKm8XHqN3a7wex6dyqX4k4FX5/IgWA5YVrUhR07DrX?=
 =?us-ascii?Q?0COQ9qA/xNBKB/owVMJ2SZwqiu1h7TENe0JC7dDWiqsgcPmPyrUA+1Ko54/V?=
 =?us-ascii?Q?vP7tziGqpBpyMG32lD5ld+w6RvIN9GN3Kp6yU1UfjZ4IicTDQaC4CE20CF3z?=
 =?us-ascii?Q?6XgfKpqSAZBNRK5PMddxu/4T5UIMwXXcddTT2q9CU9vxf17AxE/Djr2FmjEm?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd48818-539f-4c9a-da34-08ddb9703b27
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 13:56:23.7696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4G24OifsIjbQlMEmcdlGMLiIGUsDgGg2OJAYuw9WNUyModlpR2pQMwhtzUtdDbw6185280a8Vxk/uDE3hg7/Rq6trjJrERMEuM4BhyvgLTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4969
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

On Wed, Jul 02, 2025 at 09:36:49AM -0400, Khadem Ullah wrote:
> Some Intel Xeon processors (e.g., E5 v3 Haswell) do not support AVX-512
> instructions, and building DPDK targeting 'native' instruction set can
> fail with 'target specific option mismatch' errors.
> 
> This patch updates the build guide with instructions for configuring
> Meson to disable AVX-512 and target the Haswell architecture.
> 
> Bugzilla ID: 1736
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---
>  doc/guides/linux_gsg/build_dpdk.rst | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
This should not be necessary, and investigation seems to point towards an
issue with older gcc-8.5 compiler. Builds on machines without AVX-512, e.g.
my old i7-4770 desktop machine, work fine with latest Ubuntu, and also with
clang on centos-stream 8. Only the build with gcc 8.5 fails.

/Bruce
