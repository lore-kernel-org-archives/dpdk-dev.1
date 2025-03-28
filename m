Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08AAC28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 17:58:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01A3A4028B;
	Fri, 28 Mar 2025 18:58:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 6FAFC4021E
 for <dev@dpdk.org>; Fri, 28 Mar 2025 18:58:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743184701; x=1774720701;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/bnWxFM9iPdYrATbG/q5yLLZQiO+nqwKJ393xame9r8=;
 b=Wc9wCBeXpqFC6upC5OTmBsHvDKA5iV42tC+bWLbvLgELA4CITcamDHG+
 o8Muj5dKVsDALK2ZUYzbhlDyRpHYYiqz9UwZq2OmIkv6xW4cE3vDKgjCI
 ZupQAXchoE3pSHWzoRYxAlJcvnmEQeQsKez6QFGM7Fbqcqv7f3ibbK9eK
 f9hnZ0g9AvbNvakbxuynskOq61i/2qdYH8hzFYId6zqWyORb3lZxyyeIg
 cM0D/jJU8iNgWBcCHNkmvaUM/H4yqi8f57dABxb76e4jzwNeDZnWZT7II
 BmIl6lz7xhtmc0eZv3hUBXdYN1qt0l91toAUj/muN2xRwaVYSiRhli044 Q==;
X-CSE-ConnectionGUID: +WrLovnRSeCucMvytIrOJA==
X-CSE-MsgGUID: w3n/KwhzQpOH52RyaNvrlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="44449560"
X-IronPort-AV: E=Sophos;i="6.14,284,1736841600"; d="scan'208";a="44449560"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 10:58:19 -0700
X-CSE-ConnectionGUID: Ra/oDyu5RDK1b+1THss6Mg==
X-CSE-MsgGUID: s4juo1DzQ7qEJi6VmnceLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,284,1736841600"; d="scan'208";a="125274007"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Mar 2025 10:58:20 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Mar 2025 10:58:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 28 Mar 2025 10:58:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 10:58:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOTOUGNmKM9xSGhWhEJAYCMtVk8yKZgGZ6tFSjnNCr7iRotCkU/Hp40hLjCfak+2DpCfGyzvxw5CdJamf+oC9wY1KlkccnUVMk9q6X2IGdE5MC/YxX/L6zTPg7S0A8bmx3iBQWb/yyyd9K5O0mKnYv6NV3fAUaKittk9CcsHKdbykAJbcGlMn8Gd1l27dxo7XhwFlKeWUBCR/RIc643ptnymfwaMCA7bXIXlMiuyVls+2qt6795UgF2sy9ADgUeZA44aO0hkEuodHRxxARiFq6WNdHK5b0xl91SzFzzN/VHbVbN1dIa6MLXq8mE2rTQKSZpmQQ1zxGLNg4f3SbQI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSFwQC1c1ubuzGSEqi4ezHxK/AJhlrOiNqOG1qGwxmk=;
 b=XMYSXTTJgZv001Mxi8niTnahp0O2chyBu1qHdetP1C4+FxWsyu+nsG7KjqZjsEihNvzRZLfVwW2zlZEwtyqk+tld5wqhWP47SNNOE+PrB/jTXwZDWNvc4jL2y5RuQn4bDor7pvIMkjJALgY0Vf6QLLIkp+Q7xmOBSy69mHvKCq797gtkaUuHmyvmxgMsG/s7sCPFLmLvaBxeCA2qhGCl7V2V0T5hqXACFNAfpTqi0+qyFh5BrOs4ecZ8HBRGb0tWWo8QeKQBeQVZ4OSA5p2cFzO7xAr+Cs+i6OY18+ysDYEt0JqLGDkegmU26bTZGX+dH5Ax1BSKm9IizQli6k6I5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 17:58:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 17:58:17 +0000
Date: Fri, 28 Mar 2025 17:58:12 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v5 0/4] net/intel: using common functions in idpf driver
Message-ID: <Z-bjNMOgyAmQJgOx@bricha3-mobl1.ger.corp.intel.com>
References: <20250327104502.2107300-2-shaiq.wani@intel.com>
 <20250327160437.2296127-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250327160437.2296127-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DB8PR03CA0004.eurprd03.prod.outlook.com
 (2603:10a6:10:be::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BY1PR11MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: ab19de02-7694-4470-027f-08dd6e221e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pkqtG7v8cdCBylsGkGYQl4z5jh7IKIHZUgusJVWV05s3+IZErT0EdiC8PmEw?=
 =?us-ascii?Q?+yalmE8PNBJEh6mUx2Vimjmn+y4dmcR2z+ozueKY3Kocj+PJgm/Xy7u+jRD7?=
 =?us-ascii?Q?Jykuu+XwAV+J0HWMBNQ4AZp6Lz/RgmZiQyHhTaii0uLNXzfOvS4Y/kn7AKM/?=
 =?us-ascii?Q?rMXlcJZAonYWbkoBpD6kKUW4g/byeG+I/K3cODU2hadBigkd+2vXNxeLbzGE?=
 =?us-ascii?Q?WcMAwd+Bx/Haclkd3hO7Ol94TPLV0fq3H87qk+fEPWn34nDezmzSy75mLKg+?=
 =?us-ascii?Q?dNzI0wVYosnsgf6EboAk1GZ8N8Pw63unCIDckuxB1jYV7sszOYw8zl+a/gCc?=
 =?us-ascii?Q?707VQhICVol3dY7pYbw456waR5pf3tC+5jd/Zx9cl1zq1juxWcF9tg9byY/I?=
 =?us-ascii?Q?9qlEs58dTFvrOtdmkla43KTIzDWqPf8W1lh1hRXl17u8lGteUGrqUkANeJZ+?=
 =?us-ascii?Q?qMT3MFZdVY33NrPkrtIjL29Cb/6hnRnzu1IWNBp+/LSmc3iSlUPXkEvJCSfd?=
 =?us-ascii?Q?FwB8rrLtsTa5Ie1OQdM0QzXPo34wST84vehN4bo4g2sL04bQ0jlsMOnazOww?=
 =?us-ascii?Q?KDaOtjylEeVXtLuSi4uIzl1Axb4qQ7wdCrqW/zcZZcOH6PiQqk/PPz5PDne4?=
 =?us-ascii?Q?euuBkvTEyNydUzgpdKdvcSZBQkrw2XI+snG/7/VYrlFMKA74KC2tKxIfBS6o?=
 =?us-ascii?Q?ZlaCUNd8PefM7WUYvihGgH7MTNOXf0he33y6HFAQ+/sQcNU0Q/1QovP9fsz3?=
 =?us-ascii?Q?ramnWQFtILcs6OofnAlk4QAZZIhOhgLpLAaQOmRJOSk+Lmee3kwi/YvRcR2/?=
 =?us-ascii?Q?n0OITO7bd2PebIveo4SmibLaVQZlTE3sPJ3QfHHHDy6SytIFFz7S7p+o0INt?=
 =?us-ascii?Q?RI6PT8ALl0bVBvRSv/GvEMBI/xy/Zs+VaWNj+4lwp/hWsbA5WFu2VAVyuOSw?=
 =?us-ascii?Q?iBi9048XVJW6wBl9xYtWAx7+K510l1fHS2G1aktthpJ29ZxLzIu6dh7nhgbG?=
 =?us-ascii?Q?akLIeTsecnTwOkDwpaAIbVOXEE9TdfXYgJZIh9Iw/dW4UrUm8dbhq1fS6nDP?=
 =?us-ascii?Q?GmFVFVRqjQ8530lOcJsHJnLB9GGImMSRPaJ98+EwzsMQZkmyhhdu8t1b+7f4?=
 =?us-ascii?Q?F/OViuwzgdgLSNoGpqLmt295KnHoXubX6xThXxxtDIN/sUlA41+UrOH5YBgy?=
 =?us-ascii?Q?4wBKXmdNZpgTvLl1cmfgNc+TVpUcvIMmoKJui8BhFP9jGQeruzYYWrCFhSF2?=
 =?us-ascii?Q?Orb2VgZZFXE3G50R6NmFbZvdtwALB8P73WEa8qE11riRU+XIdMn6Na3c6M+B?=
 =?us-ascii?Q?/1QaR8Qcnu72+zs1F+DjIVYo7krVKPtQZqxtp9YxW5dqcgPVjylHF1Qlo6RE?=
 =?us-ascii?Q?y6gHCbsqqOf8JqH5nU9sF1fh1g5d?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7hWhcS0T/H5/NyaIe6mAe0mw5qds8c2PIFX7epxl0GBfzUcA/2Tw1aFhm7Jf?=
 =?us-ascii?Q?pOFptgsk8OQxgJJZsYPgLKhl7jXp1EZzILSq/9RxeGYnp/eZwQigKbhjSg1a?=
 =?us-ascii?Q?/I4TdnbvCs9Tlc28JhAqlU1lmK5DPxe8gNAov8hNrTFQsuRJ0eqORhybDG0c?=
 =?us-ascii?Q?KIKSDv5KuYx9Ai84l2xHDRcK/3wn8LuMcLNyKdDxzFjDgPq8OGVPFLj1tUio?=
 =?us-ascii?Q?ebYvx+Eba1Q2OZTnPPYiCdeS44I7TmPN5vLHjlTWK3N2Jwu5XDoPe0fAvEG3?=
 =?us-ascii?Q?ivIveDh8nMBjPtygZJ5+f/tOsk2wb5KT8bQMW3JqsUJamCtp4WtdK7kxeq0G?=
 =?us-ascii?Q?AmHOAC1EDmPqYN+fG1P0AxSH3FIdi49BUJ0lq//J3QxkT4KKwMY9+1Ewlg4K?=
 =?us-ascii?Q?bbTtnpZh5wkP9VDKfg4y8dZ1cnSiw6222pql9IKYBlpAueVZYggtMU5YLXIY?=
 =?us-ascii?Q?vRz6F1lIHK1wZeUqeHYHB8N/r/+YX0Rb88OIytJAwKU+EnvR6tvAzMgZTtmn?=
 =?us-ascii?Q?vlKwkJpzq2U6ij4oUUPkK+E9cNGqnL8C951eA+4lS8SmDHuV1EcIIngnPBct?=
 =?us-ascii?Q?nihBkBTPkaeXt2TQtzFvnSCu5AKmlePuNFDEjojQ5ZRrdnPQo5ODF/VBIAzL?=
 =?us-ascii?Q?p09NyJVKUH5N1TlMJrC3BgcoNWvdOEq+AOJEjgzmlXHoS0YXlLB16UC/0Kpf?=
 =?us-ascii?Q?QMUcxoiIMKhR8pHMnw97lyFWFSHQJfVcGkI4Lbll8KHGZzdKllZqURmv9CZ4?=
 =?us-ascii?Q?zEtA33H7KDt0LYImXEYq7zE7wX7Krc+kqOXHoOaAa/hcmsgJm8L1RNMGGBav?=
 =?us-ascii?Q?j6+nlPvqlVVZTFcePUBFGkl2RACVOPA3QTOn06TsWvZ9arGXj0FZckRm5Xhd?=
 =?us-ascii?Q?Kwp/lWW4BJIbr+hPMDSfz0w/lQUHlMNUaNtL1VvibW4MmgUqiLotS4RuQe+w?=
 =?us-ascii?Q?SvQy2DysWq3klsx3srfnYp/MHJB+OIqmzy716bDKPRiXE20cQcRN9OK9ETIn?=
 =?us-ascii?Q?VZ6Ym3WwRqCQpSQfIiZTtLKmftNIeXZZ/KdSNpBFyyprp8sI5FPwrfg4ALVz?=
 =?us-ascii?Q?qGt3wMfz0yvOHx232oDaBLz7rUegbaRM5tyvAteqSo9SdY0Y/4Vo4RvSq168?=
 =?us-ascii?Q?HD+X4IOvAavEvmmlKLSLN310wR6j4x2fErAJU4sUlet+60mP6+Brvc8NVoYS?=
 =?us-ascii?Q?ThUF+lHn4YxW1d9wvMUun7BVMvwYLiRoWUcBDGRVG3y0ar+VlJja3u+k+JId?=
 =?us-ascii?Q?j3yvODok/kbph3Bb/v7/XLckGcqcthGSH87vYOl5G/BRNqW9+i6fEMlcvBGR?=
 =?us-ascii?Q?/9yhmNszvAe1n8vm0y3vZh2u6WUNc26yDZ8bgo1MMgZHilpuf5WWynRksyLo?=
 =?us-ascii?Q?XB9iiGgZ3skGtwITio3tJEJbdJ4U6mQX0ZafnJqgNO5mn/akg4cK+NpM8fKl?=
 =?us-ascii?Q?thh0903o3msvvf+Pe1yK4YaI6aqu58ehwyYoAO4TxNscvfspr6menaY+7hOW?=
 =?us-ascii?Q?is7ayRIP8Yle+Wganps/MUBsQO7HQf50r25kq23uYXfTNyk5cawhbkPq7FX6?=
 =?us-ascii?Q?lboyoEci7wF+5vUntYfLmokp2OHDlBFXahZFYtvNAQ1+bkAeAklWnFa5D3vq?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab19de02-7694-4470-027f-08dd6e221e0b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 17:58:16.9594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDLv9/A4bG8O+BuJL+BBnaMbDhjSPROoNUN2YZzOQcCuCLzEWRQXmBbN6H5QZzyTGFe/aQybg9cDNMn6unXRmD+9MJsQNea13DYs7RgNZdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
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

On Thu, Mar 27, 2025 at 09:34:33PM +0530, Shaiq Wani wrote:
> reworked the drivers to use the common functions
> and structures from drivers/net/intel/common.
> 
> Shaiq Wani (4):
>   net/intel: align Tx queue struct field names
>   net/intel: use common Tx queue structure
>   net/intel: use common Tx entry structure
>   net/idpf: use common Tx free fn in idpf
> 
I like the idea behind these changes, so please keep my acks on v6 of this
set, to fix some of the minor issues I've highlighted in the comments on the
individual patches.

Thanks,
/Bruce
