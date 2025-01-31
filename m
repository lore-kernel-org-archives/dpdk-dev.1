Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B563AC02190
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 15:06:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE7E240695;
	Fri, 31 Jan 2025 16:06:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 0984E402EE;
 Fri, 31 Jan 2025 16:06:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738335973; x=1769871973;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Ch2eqsfLPiJ8CSKhiXkQIlABrQWsMBlXlYpfGP1acnE=;
 b=GZzUxBttFn5Zn7+3/mvGUyV/hpJjSIMVoYePTJQPDrb3q6u3VU0vIGpF
 qZfpDHL8H/2ENLgX4cjZLsBSvhYplWx4+oXXB2u2EXMtAGsJTTG/XrW3k
 Hh0HTmJ7+5iDzd7auROOd4YP9c4x5PPPJ2xlNsCuMUG2BIQdJEbN3/vwZ
 mivvMQgA2fi7AJvaGg+DZyDtPxTi4Q1na6f110SsI12Iuc+IldQtKKTy6
 AErdZEW7ANPMqS7PM1Inhq7WVuBVC/PlUaLlBoSuUumIB9xyKXiKixCyS
 6Ie3FnISAUYMxuNGQlJ9gB+KxykldfrzieDaOqnnLwo/tyO+M9Du/CmMu g==;
X-CSE-ConnectionGUID: LPbT8RXPRhCH8P4Uo5HD7A==
X-CSE-MsgGUID: gHDO8MWLQrucIxN+/r1Zrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="42561255"
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; d="scan'208";a="42561255"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 07:06:10 -0800
X-CSE-ConnectionGUID: PPRPVkT7QbWBHDdLoG48wA==
X-CSE-MsgGUID: 13cAgBR3RAiA9BfDp67hVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="110531701"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 31 Jan 2025 07:06:06 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 31 Jan 2025 07:06:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 31 Jan 2025 07:06:04 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 31 Jan 2025 07:06:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zz8HMwUG223pFHOS+JV7cyf9BUmUHIGBI1g1gGXt9EPa3huigX+Q0lnYe4rGM9PSpP2XBE7rYYx2IIPG1FHwIgNGIPSZpVrVFVZWMKmiXtftjeYnicbtKNFhv2aT1sS3hEB9A6RVu7gJZcO2uS/pEOr5HUn7hUqn+eN/ffGCRAox28+wiBRM6sxHpysOiLeGbPFHUZn3btdCjzWySd26mG6TghOrxh/WDffUb1UQwEROr+xV+NdaRcMdbXXmuUqtu7U47wCrV6Nkj4IBQuLTWeW6OJauKuJYU/sD8jJ59Ugq6nYpHEZgIcoZgUzXCpvRAzN+d3lzd/X+vZIrOELxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ia/yCBmx7HGecr7gP0egXvQ9W40TFV1GMZz4A6kc8I8=;
 b=hoL1P7VTF1OaZBkJaOHy5UFTxtN7CwKncmulUDQEDKg0yA92emaePm9GywHCGbgvZVWuMGvZ7LC3nFDy24b1/z8OxkTXry8E91Tp0ZlvEyO9VO1uUc0DKAghjlcG7xrRjY/l4W2rQ/i1XBhTIMCPRDLc1YcYXfWqF2ZjDpYkDMLGrACfdLFsE0/dbwxB7OrNEOxU5WdIZp/602w2bPuWCzQGOUuAUIST61fXHKnqdRGZNX6WQTAS+J/VxW4FSsQHhx3rA43NWbekgg0Qj4JGxQVD64BbgMKswPnBu0hkDhnbTudx5COyFC+V9iSpr3tsfyx8gYi7ee+USv51aDtS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5143.namprd11.prod.outlook.com (2603:10b6:510:3f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Fri, 31 Jan
 2025 15:05:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8398.021; Fri, 31 Jan 2025
 15:05:47 +0000
Date: Fri, 31 Jan 2025 15:05:42 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <stable@dpdk.org>, Kevin Laatz <kevin.laatz@intel.com>, Robin Jarry
 <rjarry@redhat.com>
Subject: Re: [PATCH] dma/idxd: add device ids for new HW versions
Message-ID: <Z5zmxpAolwvVzIdT@bricha3-mobl1.ger.corp.intel.com>
References: <20250130172624.1450975-2-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250130172624.1450975-2-bruce.richardson@intel.com>
X-ClientProxiedBy: DB9PR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5143:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ca29fc-bcf6-4fde-48f0-08dd4208be56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qemVJd3N/G7o+VQZMrYYWFsSBpaRh6+iqbzE+bbPFIso8Eet5WIR+PqqogHM?=
 =?us-ascii?Q?AnnBihpvzLhzrrzo1X5RIbBE06tKaw1/v8GVEv6hjW62HMwXzyjzItgBk5dU?=
 =?us-ascii?Q?+eMZz9EEQhe6hzagUrw3YJmI9sKniUxaPPkLVQ52/N1Hq3WcD9eRLnrG08fP?=
 =?us-ascii?Q?080Ng/dvJxlSKCP69TN/EbLerxWLbHgae7i8/R02AOfFO0bPU+lPSM9qIIFO?=
 =?us-ascii?Q?2IY2bbS9GX9AwqfeE4dEg8aetXpM6EKJ8NgzmW6nfBunXbrNlMznnId87nh9?=
 =?us-ascii?Q?AcRL+XaIciwedjCxq/ZocQH/EU7NdsxCMMkw5I7iWogzACXHu9ts+Jv6Tc+f?=
 =?us-ascii?Q?W6z0jvxckxZ1xBImafP5hgRhHFU0oj+/gmW2mvH9GPWYioKSAcbXs1zicuim?=
 =?us-ascii?Q?RDy12FhrHpf2FAjaV87SmGGvnhhZvX+KgcxkH1jbfTOk3G9oQeP/d3yyew1L?=
 =?us-ascii?Q?WgA5kfUYLxUkIEkhXIrxroEHNpemL3RRBCJ0ocqWF4bWjjlVZTtF5ij2tD0j?=
 =?us-ascii?Q?GpQmQUULrGwK2CCEMmlL1e0oNP52pgEBuIPXM4/kh2ioZkt5ChAwSVlvkXqO?=
 =?us-ascii?Q?3mhRBBehoq5xU1BGQE8Y6PMByvR2zWTXpiTULcvuJA4EQ/RWPtsa6NruUaxH?=
 =?us-ascii?Q?AvwncYeUEbbQ04Pfue8fIW99nxom2lXxPgIVZS3jqXQI0QbRjwqw2lsWZ7lp?=
 =?us-ascii?Q?6JqTZ114qgZAXduSXAGG8CC0O0YUPkzrvlpdprHheOr/l0xoDIiiytmPo64F?=
 =?us-ascii?Q?+iSd25JZL50GO36k7QIJpy6kF+MWIXNFt6dOG9v4Qy2z6CVqDsjkAWukTT1/?=
 =?us-ascii?Q?UXouXiU2SdP90ppePYwtNZZLxgLFXL6ipDFqe84Ms9nGuckESWperk5lyiF7?=
 =?us-ascii?Q?QCrfcB5Z37ySq1uIb7O7wMpfKrCn3D/vJ9bcIiyrQU+FrbjN3tBLxUJ59X54?=
 =?us-ascii?Q?pnFNpy3bIscNCGRbWSzWZ94/M5+sC6gvMVdEhgZcqDqmiSrKTLJPGULWyXhH?=
 =?us-ascii?Q?YhLmzR1SRgPPQZTjcuFr4wcPYnep+SYQYId0wj6bElAMDdSfcpcmqaOeCSmi?=
 =?us-ascii?Q?iWSaZEA2Tj/0+pNEsWdNF7sYaoQ3GU6Y519wz0A8kFGayAxWi9Whgb6a3sg6?=
 =?us-ascii?Q?rOlrrFn6sRLwMw3qmSD8o9FL3DFMRoVQGhbgS9iwxu5Yw1GoR2wd38jlJKGF?=
 =?us-ascii?Q?0OBVvX68iwRTIqHPWo6Q2FByvSdTm9sSYqoCbDNrOvbKt0VZU8MRrH7HlsnM?=
 =?us-ascii?Q?ntRFuVtUNDuQveAvszIf1zAd4ClT8JSVe0XjKUCXcl/O8UHBXJCt8yfLEJTz?=
 =?us-ascii?Q?j4oH6ymomOK/cm7to+IJX1H4quEQW9O9ZhfqCfw0eHmpgA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p1pB3qxd43wreNVcPN7NZUG3+GEkXscGSwnChJzFMQp8RWhoB8s9KaqXi9Zd?=
 =?us-ascii?Q?EBtZcCczw0kRUfSqvKmpX5N53+kDSz9xZJ11G9AfQa/55FSlDDH7hh+w12uY?=
 =?us-ascii?Q?tGjzt4bYsqV1eDAXdl9OeR188UAkNiilSqCaUtp1KQBK9/9CgjQO6hyZtPTB?=
 =?us-ascii?Q?b+xkka6ckm8WAxckwhkbO55qlV+xS379bXeTxVMnGw9QkzZ6KQx+vRNqKvDc?=
 =?us-ascii?Q?fl/SPPDKiIbtZT5R1quJ6SAQ0D+XTNgqP5Jw7sH83rd29L03YOpjw0f11dMx?=
 =?us-ascii?Q?T91eWfW/GFDcyQ/v+3tIa1/+mHF6PEDO2E/3h4tcyld7zIUVcN/x/wQyF/Nb?=
 =?us-ascii?Q?qc2xXqAgxzYNXBTs4c66zUuu5fdFjVi48qbuIRTkmsYAFrxv29CcM81ToscH?=
 =?us-ascii?Q?9kk9wnFr0ngxeDGBE8UJTy1jMEoDhV+S2EpmXycsSt1DjRucNKdoYqkIIiOE?=
 =?us-ascii?Q?98THbRuN7xZHFdjcTno+jf7DTEpbP0Lo3x1M4WC6JDafS6MD8JNOmImVcwRa?=
 =?us-ascii?Q?h6FfX7Sa5+sNuyWZWTGgiywXYupXLeqG4yOObntL0BWgkf3ePDPn0H/ghQk+?=
 =?us-ascii?Q?r86V01xIMYLbI5mJ4cvdhApe7y/iNSocuM6nkTggJtDg5KuD/OEcpVGTJ7Dl?=
 =?us-ascii?Q?bh9guNWcuNgLEyOt1HETb8j23Sb0WWHN/Kw2C7LI6vfkGNX+g/UmZnAATjYa?=
 =?us-ascii?Q?VKMr5CpBDBAR5OXFxSt3ms3NUspKC3p2TStinyZLIgbQHMk1WpeGBeRWHo9N?=
 =?us-ascii?Q?07F5cFVt33ngbIMudTL13mR+i9291+dzg9uKs/RNFZf/90IB5gjLIlCtefGF?=
 =?us-ascii?Q?l0R5lP9DL5yipAXBFY0HPBwS9khvmfmmeF5qR5M9LL3hxLk2B+HF0alcyW4e?=
 =?us-ascii?Q?G6bfsQDMWWi5ZPBg+5Wjue0+4u3cwHx9HajBhsOe+XU/qMkBNgX1Og8wJ+JC?=
 =?us-ascii?Q?0la2wUVwJ2Aj0+jbo4UlGs/Im4REqYZ8Kn4TxhxZAxN4/5TuXqZU0JqZEFf4?=
 =?us-ascii?Q?YkaHkKiny1Hyup2uZUFeHCK3fPpDvzXqp4y39LtTHM4Xq6eJk6JiYx6zm2LK?=
 =?us-ascii?Q?fkRslROHqSeVuYAvfBo9Y54Pwb8njrLQSCyg7vggpS8bRFG4IcteEF80Pf2h?=
 =?us-ascii?Q?6IdmTXG4zkWYCK48Byol1TvpAB2fZXvVxHHV+tsR0EdZirPWmN62yy+9nbmE?=
 =?us-ascii?Q?BJc2Jl2KitJlVzR1wBqkyRBvdxa6gLHaWJQhc/itj5bhgRpo+3Cr06D3AJUx?=
 =?us-ascii?Q?QylR1FcI35YpxpZwAMuzV1nnXv3Qsww3KMJaDasZCLFDbqN5N/KzEos3D77m?=
 =?us-ascii?Q?QP+Ymrmz929P1NiMgbgUwWbsW6X9UOdjEbA7hXUh4hqo5wglv9PmC1qTzdGz?=
 =?us-ascii?Q?npTwqdrsDbSCtVwCUUl/mx6nLFPhxqmkVc1cBJE9aV2LT7MIxKgu9ZCrhBF4?=
 =?us-ascii?Q?eJQChOWwshiCBpt5j1V+030ShICXuj6oyh8uoAzoXCICk73D9Tq76GhaA+9Y?=
 =?us-ascii?Q?/TfvL9H9weah8amYQOd7/+jz4y7aBbSyrWjdnNoCHrAOJXR9wi9PUuHjlx40?=
 =?us-ascii?Q?EQVFOOrvVbg7I7BQZkzpVS2lGBbg3qCeqcfS7Nzn4xCYBs39oWJRWztQ8Mhg?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ca29fc-bcf6-4fde-48f0-08dd4208be56
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 15:05:47.8612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzeZeIwLhOUrMDMlrDiNo+Kh7NgUN0lVyfoAaeiRej/lZfYoLoKtJ80amUEOx30KZAQgxnAaFiAwD6MUet+LAKHLarNqeTEnV3dVjwX/EFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5143
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

On Thu, Jan 30, 2025 at 05:26:25PM +0000, Bruce Richardson wrote:
> Add in two extra PCI device id's for future HW versions to be
> supported by idxd driver. This aligns with the definitions present
> in kernel idxd driver [1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/idxd/registers.h#n9
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Recheck-request: iol-intel-Performance
