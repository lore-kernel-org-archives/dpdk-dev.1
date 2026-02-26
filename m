Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0184FC5933
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 11:32:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 813C8402B2;
	Thu, 26 Feb 2026 12:32:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 118664021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 12:32:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772105530; x=1803641530;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pQ5HUKQqAUWEm0QovNm992nkaP3aeYAd0398BTTd6eY=;
 b=IVz/I9hQHhD++JtAyoLbZ0OSXlZ9Kxlaq2oXAk4vBSA0wN/++F5kizrC
 pDvh4NgLgHTvY1B4kCARhCtqpkJ5X9YnNBAwNj8pyTbNqZSGKg3ubFyhg
 DusXpAOz+iiSV8ABglLEBRM28OhldWpGmfsncrL1D2/mStvOQUYNqghyX
 ZPnFaWBTFxijA4uEelIIL+bHBupJO8xQ/5N++y3y8IatXtqMJNcGi8bPE
 MdnBt0tVZ6kJKFaNCHoxjx7M327nBgEDXLPLIJzRXrU2Da1v5AJXkoKb9
 oIsApKuo0NfNZ9cEWmc8dpq3RmHpcp/FsjEOCALqcG2slKYMngj2Qgpm7 w==;
X-CSE-ConnectionGUID: 1xtgOxwfTXC489TYVBZzDA==
X-CSE-MsgGUID: XbRXAxHaR/iWv2Efjdb8UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73233444"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="73233444"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 03:32:04 -0800
X-CSE-ConnectionGUID: MchnEnrzQeuvaznk+m4RjA==
X-CSE-MsgGUID: 7ssxObjoRMStb2jYjjYyug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="220680103"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 03:32:05 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 03:32:03 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 03:32:03 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 03:32:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlmzDRuyNZfugoRH4GKZgY4Sd7a77vDyEaTGNVAdfJQk/YtU+FC43KvVg/Fc03ZZ5EzcML1wQMUpTfdbtvrrAfhtwn5ED/UmyrUrTUsT4hIx6ro8TagMdPCIzn4BQo9Ex0uQV1Hhn/Qf7Ff5zuKLDEmdvvAB7YeTFlhV+EzC45zOZpFdeih7k4pBzPFl/H+RkFGJFSdL1oarP6NXxYdXbeBS7QudLaNK1y7m/m2iQ+TJbOS7W262SNVu8m/mvbawI4U/FfJakn1NhiCYYc7hoWOTGAzvbJIS5HSOZecSkOBnAaF9EWTGHH/1UlKmrUHE9xMQmQckDa1PKtiQqfdEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RilYtNlFyebHd/7fPg1mVOHfPVBgBkMXBF+5gYQGoJ0=;
 b=FOVrUDrvrHu2lckmByvGjVZFALQqbprU2H7HK+psBUuqTdm7u3SJiM1UFEZjpBnuldIyuA4P8k+MQxI/86TSvGu10bHIyN8+o5vW5gWaIMbFwmAcnK9FuzagLy9PCzouaw21RLv+OocgALOFfnwFEe7zsm4wyFmyGFgKDtR32iuwn6LOfnif7wZrOfQVI/Xw0P8BA4fUCJmc1W63NNK83vCs4Tq2nAguyT8flf36miSIEvhMZxqb2db2Eq5JW+B3pJS3TCCFFY7QCltl5Ilp8VnrGnD2lWJXESRJ16X6JDhkI/nsoDCT+gxVrjD9+KZMzYVO78qx/NkOYHpkKyaAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7779.namprd11.prod.outlook.com (2603:10b6:930:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 11:31:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 11:31:54 +0000
Date: Thu, 26 Feb 2026 11:31:49 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v14 0/3] net/idpf: enable AVX2 for split queue Rx/Tx
Message-ID: <aaAvJbhy7RUgHhgY@bricha3-mobl1.ger.corp.intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
 <20260226094222.1393288-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260226094222.1393288-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0340.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d45ff3-b39d-4355-dacc-08de752aa498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: VPnLXqJQVsQJQO19Q4S2vHpyiWtsC9+omp1cZqlu7VYWJR0ExQ4NulGsQdfC+SPZu9uzyOMx8g2rPMCIyCFL+NdptisUFyx/1l2bzxakv7eEyyI+nBbrXInwTxQXAoo+5TcnBesJ//6o7zdPoYb6seNHRkRNkXBTRoWru6ZvN3KM6bQCKcGGFXI1QPP03q6Yzg/3l73TmDFn8XYaKPSFoSNedp4V7ACvwzahU485W07YLExtl1qLC53faMje4D+xQVwIEpezAtx/zJLYo5E1eN833I/UixTtnOJ8cGHlO/pvLjNJwT6qeXfYSKUUEUndMuFHW/bRvRZ3c/FGCgK3cnTK0U6rCF6wAY1Ips+b3xOIVVHSR1PpH6E0ma9RCHPa4ie3in2yYhcvhmdNQBispoi3MD6XhcxTrmCPCzBXM13KO5uBSlDcq1PYs1eQnfmzRFPIF+pj4aWXERa4hUdX2ONlMtop72zIlTJSvpi+WyfKXxWY4jcFAG7XlWXut6CejISlkQ8qCc/B7B3Ni9BGuI0IfkizEWdD6vQkcEw7PAx0Lg5V4r6jMn/YFiSXWZk7hF2kjOCtjdrWYGWebViEehV2T0rrPyYw7FxB6dr9qedXbpuxuUv4/UoGYXGTc7A6mJbizwYZUWOMuhLD+1ymBRW+CqLtoENVXzZEb/g+oW07VXJyLx7UKX7o0Y0hga3yFvxa3lIg4VAsb8i4zJJGsa6i1EDkOtaLyQg0fkxc3IA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b4rbsp5pck2i9UhY6nYxpNNPD1jTy1eC5xLMuxr8qxAwRfXE5WfTynwf4pNi?=
 =?us-ascii?Q?HFw7qv43ENjVF+gx6HOqKdtBP4ZS0amRPpu/cHCPyQ3dfnzIoWuuxrUDlE7n?=
 =?us-ascii?Q?Pn5DDzQGGDDnoG0NefteICcJKpQd5vysuiDcqaEffjZflZg/eUEAok006cdt?=
 =?us-ascii?Q?sVwuWvdMuojouXLugscH2/y9a5gCBm5vczWbxFdZl6OKB8g3s8R85LXwZbPR?=
 =?us-ascii?Q?Ad8YB7JI9JNrQdXjPKdVNffoYOOyMzrUH218zR850121FhtDgsYIEWDuFhhM?=
 =?us-ascii?Q?rnUe6lgxqDFL77C/qvViQBds4HgNEP1efrfJY1Ad065w9g1ZkiI29/uCNW+m?=
 =?us-ascii?Q?X0BYdE8ETPXBG2Q44V1ul7uhfEiiJQ1+78W/ll4XdGh7P5vJ7BYrOcZ+Idg3?=
 =?us-ascii?Q?RmhXAU7Lhmi/lblog4BLX7Ka/lRhfHFyyajSoaSrNMwaRN9sN3NYohmffi6B?=
 =?us-ascii?Q?3/YobzNgX6RIR2WQTgY9Rats7z5hAi9JqSkyGevPwFub2Ea3HyEE7hJFtmdi?=
 =?us-ascii?Q?0QrrNynO3wr3ckIs5rGU1zWxYRIjsQrEoekvrSCfH6KmpOfYvNoTpdokMete?=
 =?us-ascii?Q?D9CjLBQMAANPyV6NOVa651YL4SmzEb/nAjpd3nnjwHF1KOlDI7sF/gqmNGA+?=
 =?us-ascii?Q?0VgcNaXBmsUCrAUwKqXdvrnmlfFOWU1iyUtDehsuXZ0SrivLzWjsuGhnQNPd?=
 =?us-ascii?Q?MgtYQpYsn+XnvQiQVp3iamDzgkB8USN53aFLEcvjLca7T6EImliR/TtQf6iV?=
 =?us-ascii?Q?WciFziDtnR7c+d1FXXCfslNBFi/F4GH4+cmeXwzG2eWngudfQ/DS2Dr2nGXE?=
 =?us-ascii?Q?EIAF3gfoZYMDdAWepDuuPUdZE+Oo6gqZ4FV3dtjvvStOK1lB3M4Zk6y8XpSI?=
 =?us-ascii?Q?yS+YVbZtD3n9MKuFfSCbJp1/akDD9hViIcdMjvDW2GKDACzP7pBwchvzik3R?=
 =?us-ascii?Q?wo/vLEbmOFa1FJs87ytXmfgOcN/sdWuTUNmqK7ca+ZcETiYklT8BTbQo7Ba+?=
 =?us-ascii?Q?xTfWrEK8iM3MUs8IvU+Hl+TWa83Kyq5yXebClvWZqlxD+5aq/LufkjdnG2QF?=
 =?us-ascii?Q?XF9yytBca7uZ7h1GtuoQ8Ki3L2VhUziNBXUv2GABIzZVSazpJxstEX3oPsZq?=
 =?us-ascii?Q?+GFtarsMzCTpUsBVXcU3rKj3BhuRrbgjqv+zjibMWZi0Z0/8nX2jcgdECelB?=
 =?us-ascii?Q?+/szgmB7tfN9dh7YQfouhSuR3Yol8VF+C8V0UThxSMLkLCEoUwmNTbIkYuYG?=
 =?us-ascii?Q?lo6XHJBN5pGKH+/rnJvZntJd6Oe1bJ9CP7yJHFDYqDJLH3g27GIdMQHGV267?=
 =?us-ascii?Q?LF76dfXLWUHjCPQ4H1ykUfgx+wENAg7LYKiA2L2jAztUXZHnOKZEbebh+Cc5?=
 =?us-ascii?Q?GT5PyaB4tURhQR4ZYAoPjEzUSWsUwF3doITcuPz/oAc5njwJ1pdMBLg2hkzC?=
 =?us-ascii?Q?dqldVfUyZp51XJZHoROEE3X2ChRqKJwh4gOmgsTdghnV7AF+h/zEMfngAY6w?=
 =?us-ascii?Q?BhiX0Hc8eG4xOHsxpmk86BuxbcAEOB02Cgr8tnGaSNYhezNSckrqlzmUk8d5?=
 =?us-ascii?Q?U+20Tt4dyDXX9ONqouVwoRtsgQQmHEq96BkwXtsbvFeFSRWrODFWtDWEHNBP?=
 =?us-ascii?Q?rFbiCrHsn14hqO8HO/j2opDVwducUvNwrZGrZt7SGc9UdGkceRt8UVDop6tb?=
 =?us-ascii?Q?8S23eUc1ZD/yk+x9qae8dQe5VqNFAoNfpLzbspRE2CDE5StEBbnnDXCA6NnR?=
 =?us-ascii?Q?PSyavxjOOMlDb/lELTI5tA5QdVGlQqU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d45ff3-b39d-4355-dacc-08de752aa498
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 11:31:54.5318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4o2NIHSSpHtaUxoq5ic4FdYjjf1A+TFUjx9jgipZicaS1NKKFODYlYuJlmOksghCgQfddfuJ2pNq8guNwXzcrAqIRaBT3B9uWL4n5M7SHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7779
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

On Thu, Feb 26, 2026 at 03:12:19PM +0530, Shaiq Wani wrote:
> In case some CPUs don't support AVX512. Enable AVX2 for them to
> get better per-core performance.
> 
> In the single queue model, the same descriptor queue is used by SW
> to post descriptors to the device and used by device to report completed
> descriptors to SW. While as the split queue model separates them into
> different queues for parallel processing and improved performance.
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
