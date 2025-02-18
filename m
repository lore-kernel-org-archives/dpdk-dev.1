Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46D4C021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 16:48:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F7A040674;
	Tue, 18 Feb 2025 17:48:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id CEEE5402CF
 for <dev@dpdk.org>; Tue, 18 Feb 2025 17:48:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739897286; x=1771433286;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1LWuHFO14i5w1MdtCIceQbHeZOJ4Sv+L4pJVc95g9Iw=;
 b=NbE+LE4QcJzPaa+VHXGAvdi3TWAB0du2OKhrtwmHEdKuLKoG5JAl9orY
 H/RK77qjWeTzYY4bLFPDUOJatBXbBjskxT+pJDvLxosxmv9h1ht7peVg2
 loM+oeASwFI1+vSINhvy3pU83VhxB1DMD/hv2WPvq/jhv+l/vhEIh1oJP
 IOOMS3MJQs5+SoBDipDBao+dt14ta5wsZonXaJcaUvTTyRSADdgdjrjiS
 8M9cLoTikbDece0RoO3sMY/IZx+U/UiStq9JNPPnAVMVY/ZuKquFOGWxM
 nGTRrd9wAsrPkgX2IGdVkhDBxRxkylN/S6H+dmwzciF5oBVNWU1mKOtCz w==;
X-CSE-ConnectionGUID: GfVb+JyYSmePpatcMbeIcg==
X-CSE-MsgGUID: dCfYv3KuT0azTW6ImIDZ8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40624980"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="40624980"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 08:48:00 -0800
X-CSE-ConnectionGUID: ClOP+jilTOObr/SqYuLkRg==
X-CSE-MsgGUID: 1nhbNdl2S8eAaD0FjKtppw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="115336132"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Feb 2025 08:47:58 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Feb 2025 08:47:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 08:47:57 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 08:47:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nv/yxKceGVq6eReCj/t2AlsjUDNy06BsoCaqZRonRxlJ+2+GjbHFRNlIFnN27HUANc2E/h+pV946Dna8iMpp/HYGKE5A9rUUdotPCPwdWVodyt51xYmFr6k84DfTjDpyZLn3/JmxBVZBsx1aN+y7qvHFw7DO8K9NMalgwHtlJ4j5CHXYvy/C9deFnsCMcbKIuYu/PR9Y9XCx8Sk30WV9dgGn8UiH12P0wWE0jHW+b7htkamUApNjfJU1hnuWwQLvpxrynFA615uF2pPnfoYefRhehdfNpwE4dhPRaw8Jp1hINJk45lguoiagceSOJtL778k0NRlPpNibPJ4auq/1zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Qyrv7WUomyEjlIh/0/lOu0kTVf8cp1/jdDiduYbNwA=;
 b=etvgke3gNVSyj3RiiTEiSxtF0MsgO7TfsJNBcuhDl0e7ufhHw0+K/SE8vM8mANBLg+ZNJLvjYRmCEcdRasDA7VtEBxArj76owD18NcR01wk7nXBfx1jljZYntMDdmf7FYWS26/daKVvvlsIArSY2Yjx+wG2X6Mur+XNfPDLkjjgXWM2JQqQV3TFpNVQ3gL95xY1gct83zyuAZtXzWoBQB9HuqgN1pOwBApIjum0VIIcw6NM21qsjqhs8yCgqqeg+VcLogwZs8fJ7+0/SwfHoF5FcevjmDFG+HMPvRm/pSdbRxiqf1cvoXXbgzdMp3iUS2WhWgH6A3xnLGW7lGWVzxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB8400.namprd11.prod.outlook.com (2603:10b6:208:482::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 16:47:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:47:44 +0000
Date: Tue, 18 Feb 2025 16:47:38 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v2 04/10] test-pmd: do explicit 64-bit shift to avoid
 implicit conversion
Message-ID: <Z7S5qjkNbNNSjGEl@bricha3-mobl1.ger.corp.intel.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-5-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1739896329-1946-5-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU6P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB8400:EE_
X-MS-Office365-Filtering-Correlation-Id: 677a96f1-111b-4243-87b6-08dd503bf72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jtAridQXylNPt2b/dDAoInerO7/dMtRJgaH1KXZs1bUJHWdKTvjPPXLeaeHK?=
 =?us-ascii?Q?Z2WBYRCLkOKZJOqWUnHH33wU1WBE0f21ZX5bex5EswFIK+IuJsb6zLcb6Dki?=
 =?us-ascii?Q?YjtfsI3H3LH+3HGmm44ooVoRDgX5O9o2AwwXBj6LvqoDuE8kPa4pDHAPkF6+?=
 =?us-ascii?Q?ezkYRTPfgxFoCcwdYdfJOPl/6DYz9IbwKCOLsHAAc7HUjyhCYGqH9oK3RGmY?=
 =?us-ascii?Q?7ALRHChjVpCP3GyhiIUlCiSydvs9mvMYU2bUq930050SRu5/oHlKJ6VA8bq/?=
 =?us-ascii?Q?zBgF62YnwDB6C2H6nE1ciNfgmzU2WuIh02r6WyNUgPSII1bNWg/xbfPQRuH5?=
 =?us-ascii?Q?6QPOXP+dogIiJh6uoRCEw83tfYV8HQjVIKs1PksmSba5IruXk4d6675VorlU?=
 =?us-ascii?Q?J0hVc+mbKE2FR8WV21FJS5SYDc0GpAPaMsMBaKpevCGzK8zE0GqubrFVMUEG?=
 =?us-ascii?Q?vICRiWMc1ri+ArCtCSVkiMVj8P6H/b4LWKcXSCobFgK4PP8bSdLwDbygbluB?=
 =?us-ascii?Q?wLT1LSMAo/cNj055inGKUjQX49OvKOTbigtzs+B0HMJAZez083fQede3Qlc9?=
 =?us-ascii?Q?mvK3OaVbIgirgnHHTi4ezYe0MaR0L2eHBHXt98nGZ/ugOSfOllkScUCANaSK?=
 =?us-ascii?Q?fl4Nbo8EEutLMdK7sQkrphhM+oFxbrRl0pcSd4HHWnDVJHalnkqpn1CSpyDg?=
 =?us-ascii?Q?PDyy+Mz9GYY9eHY0ZH9Hjx3W/3fRcvtfSXTBkt1BMDn/Kuvwp6j5jwKPXNTM?=
 =?us-ascii?Q?DXOQy91PpzNrCS6jpvaIe6SGaC46CqvGTDm/e67xdmw0P4zbHJR4/l/Rx5bi?=
 =?us-ascii?Q?8XKw7BR/Paj3qLFm8ZIuT5UQ7ZlckQRnl3zCqgNjSBe6QpgeDrnwqZJ9+K+f?=
 =?us-ascii?Q?7KrgvUgQdTz6eaMerUeqLGYif5C8aVLBIgxVwRKmwlSEaXZEKIEl3VPbac20?=
 =?us-ascii?Q?z1Nir729ne2zA8nnf2RUf7YCKgsUVaZCJos0p1x/bJfGb6Ih0foVGKCxmhqj?=
 =?us-ascii?Q?TB8ONDITqJSK1jgKYFR59vHprOjaPX2V82IEv+mnYMZclKn02egXImpxNv0x?=
 =?us-ascii?Q?ymoaUaSJw2VNc2wuzG0f7qFrPwRk30k8siyu8fFmdvXCfoLNF4RwP1PLHrBh?=
 =?us-ascii?Q?GsNaH7QpAwugoTviUkgf7+isgZVaxLRLRIacBpINp0awAIkBFZDZPQwTrVa9?=
 =?us-ascii?Q?829mwtI5x9wYGiihShqMCd6mhvvxd4Glm95qvCXznz74s09D9mhrYe3nbKDa?=
 =?us-ascii?Q?BLz8GAlvyHVP7qIXOCCPtuFgtpE8YE1FqJtodO8NRq7Dg0WgCiLQPi2QTxNB?=
 =?us-ascii?Q?R/XoYf5Psq/9Bg4HCBMsDIIBO51sC74pLnGnh+qpS/RMLTEFBafBjPie/gr1?=
 =?us-ascii?Q?ekSMSiek66thYBiiKflC/zCdJRiu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oea06BmTKVeh97f7fqQSJvggVlG3j1obDv0ucXPgGvFTgqP0Jjb/UrhLovTz?=
 =?us-ascii?Q?ggPfVpD/FcZodDze1SkL0RDm0wwh8jwZgbuDv/YRMxFlbba0zK18pMDCc+LA?=
 =?us-ascii?Q?iNORqOSQOU27FT2mXUyYivcNsTyKNUTVk/934goaNbhJsSy9AWFcnAEeG2NV?=
 =?us-ascii?Q?Br83N0XEvSCnxapV4K7Vd5UltiXEncW5gBwkUzdheMFpgmJ9IsKgiTi//mIf?=
 =?us-ascii?Q?pCpKfO0TYNr9Mj/xjorBdiP0mLUJc5YI6itbzU6Dzj33bSsZNzrfFfkU8pfi?=
 =?us-ascii?Q?w7lU3hLvLDBbBMqZu9wuddBf0xcLIES7DiDyEvxSPNXECHyxxYJmhDrolJoJ?=
 =?us-ascii?Q?zKRHQ/zFdvVtX7VxGfNRSi8xAMCmq7fSEb+UxQyYppkwvj+oDMe8TohHB6HJ?=
 =?us-ascii?Q?1OPGFx8yIMzAgh+BiOAflp3ubLzjrkxng/3gfmI80+RJnO4Ui8ZRc34mBZE/?=
 =?us-ascii?Q?GLaE/wKdg+y8BIJSMC3etev0ODZw7Uti0HpZG4uFRlXLd9m94xHe2sF69YPe?=
 =?us-ascii?Q?2bmmLUDCoH4+ImC3Qh8/dN+0MzPb1AiFDkkP8jKF63a5w4HkmSEuHCG8jqCw?=
 =?us-ascii?Q?7vzftjk1rvOcaJz/bz/yADfF2SfAGL+6s+gMlSV4X5oWQt0C9+HacGNOzhmv?=
 =?us-ascii?Q?MnUvIjueXj0LZkcgmUluGjLNRwzRVm4PMWEIrvD28u7eaHVn1+liKRUc0vdY?=
 =?us-ascii?Q?qUoFsRLOm6v+Z40YK1tiTFb5Xfi13As3vjJAa2KX8Rq57iUr5Os1MDrbM7p4?=
 =?us-ascii?Q?xw1VaqaF0OSHMrJB2PkJvbsYd+7PqQe/e7lba/8gQ30Mi/B90kn+b/tHL/+T?=
 =?us-ascii?Q?F3zlG+e0LPbVcHED1a4GqtGtGUr3RHKEJ6vY09WQL4yGQOL0CGxzXzAYG+zR?=
 =?us-ascii?Q?lKrhU69xwK4EHucM2K/FdI7g1J72oOO6ofMc5iRGDor0I8gSZ+YbOeSxOdP9?=
 =?us-ascii?Q?d7eGYqoFB9en0IGK6m6R37ARi9Z9ZKqYkRSATCNyb9Az5p87BYyBvgpjKtY3?=
 =?us-ascii?Q?8s7+J+v1/XcOKMC/86w3bdBNs61HcFLZMJt0aYR9o647u31xNsnS5Yv04psi?=
 =?us-ascii?Q?iTp2GQgDBCxvpUhYlqWA8IigXRrJiDpc5gNQmw9eKIRqziACQqPElpHEs9ZM?=
 =?us-ascii?Q?9wND0GOYxHbu/P9/ijzXCW17UC1b4Wk1w5Bbf22HP3ns2g10szWOYuVj5E83?=
 =?us-ascii?Q?qSm+yvGmkXxXcfS3wVLEtVTUNnXrE1oOVI+p3pR2fEUV7rKsqdn06s1bUUN7?=
 =?us-ascii?Q?OWWzZ7I8NxuZykdImD463N3MUNNbZ7bIo2tLjySBtFbJb+JvuAXsWDBtVd6f?=
 =?us-ascii?Q?O/5eJddP2X2xbbM9evNwlmf5oue6D84k/vCw8IhBCGGEAqaUbj9fYB4PIxtW?=
 =?us-ascii?Q?nmDc0VaE+uGmHXfhKyI60f3KrPX4/Dx2dIa+CP/EQd3AHbzjR1g0SMXPM0cT?=
 =?us-ascii?Q?11twHUvlTc1le3ULtKx2Vkg+MIeimIIMyt82zq8mQuWatdfWTA+LmcG2uxbi?=
 =?us-ascii?Q?2OuL0C7LslDRhKMmfm3XqmC64LTDdvGvjctSgaQxdhN57d0HOa4EQq+ive1c?=
 =?us-ascii?Q?iafwPm6Luj5xcFuA7hJUl4U1vF6Ockeyw6IstnD2740f4nqzgaXRs0BxVDAf?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 677a96f1-111b-4243-87b6-08dd503bf72d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:47:43.9425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6rbtszRP5fraxQrI6fg4Fisdxtx6c0IKAveYpzgqNEbAItIVFzrkYufNko4Wr4feYKzWMCo9L/yfm4DQlPMSNaBA9ZPtHbxwfOjeEk2GAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8400
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

On Tue, Feb 18, 2025 at 08:32:03AM -0800, Andre Muezerie wrote:
> Compiling with MSVC results in warnings like the one below:
> 
> app/test-pmd/util.c(201): warning C4334: '<<': result of 32-bit shift
>     implicitly converted to 64 bits (was 64-bit shift intended?)
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

