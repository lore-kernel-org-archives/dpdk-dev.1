Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F739C3ABA3
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 May 2025 07:45:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47C2F4028E;
	Thu,  1 May 2025 09:45:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 2D40E40279
 for <dev@dpdk.org>; Thu,  1 May 2025 09:45:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746085512; x=1777621512;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=aoXgmymysm0pVtg1anZi+FJFyNSCLedu2VtSDgEQHPo=;
 b=PTMMWMUDikf91YysIjMuueZwYLyMRhUy0W3SpOQyI9/a2QmmuGXJQhzX
 WGCKicRU21h+oiN/kWQ/R0CbLcsvFnJ2IwQhbecFeeTL9xTmH45GkNzGp
 M8+EShq8n1djY8ZwIRLuBzSwTVgz7rfmG1jf54p0Npcu5VJM6z9vemxbK
 mbwcmwFL3XMbeZsbOA5fJ86vIF74PiFU4Ug7i7232ie0VbQtVInyNRIXL
 BKb5z2cLeosTw+j6VmMRSHAetaEKN0Z9kLKuI8ZxO0LU6mvrJGGn4I7aF
 83SJovMMMguWrFHBMIOL6uOW8iLnFE+Woz9lK2uajix6VuasrBoPjWhr8 Q==;
X-CSE-ConnectionGUID: ThafebpbR3+l8cbpUJcFiA==
X-CSE-MsgGUID: IqbsAeG1TLmdDMb1UGTXfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51419845"
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; d="scan'208";a="51419845"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2025 00:45:10 -0700
X-CSE-ConnectionGUID: KWdTHRpMQJ+Sy3Ifr01jiQ==
X-CSE-MsgGUID: xZKdCkEzQQyWgHzTR8kYvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; d="scan'208";a="134240978"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2025 00:45:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 00:45:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 1 May 2025 00:45:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 1 May 2025 00:45:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIyB28+gtNJ+aHRcpLKaLMaHMS4JHjIkxfRTV6U9QpBTdLBQzORCnTMHO5gc2kX1CcayLcHpl9+yAuYx5BM7dSOd7S7CUjCqxgLH2w3VYPaG2tCOokWWeES199JDdcPOOCHI7jKlVKT/sLADE3I+iez0REMVXVEmo1MeRoRx89RkEvZXf/XQXPi3PfG4kwxzcAydCGn/DolIVdf6q2qB/KR0qvLBdrITzM+JqHhRm0jsGy6ZGIV5O7wEuk6v8K9Ecm305PeyELHZozQgroDbQemz660LOYJUQZ7RrPNJbvuAYy8LmdwrpCYEwPVVNIqO2U9Q6yZLN5VTrgbPrRDl0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAW70HYjECGlcoZOS1wr1TaWJS74sHM+nIpIhGWdGdY=;
 b=vT5Q6VVGTTtK4jQKTJd603u+jH0IoMoXXvqfM7NtfDurN0sl5p/xMFKjeuAXlaWyEZEMT4UFmWyIMtzKet88rLWOeh4/4SFAUpS5DN5exTUSrsxpxtrV0E97Fle3kom3bg9fRE7BoR/LjmMyKr0JX4k6bYbelrd1lBeU7CN5VlaSf5D22wTHaNspJpnYW+lqoU3p1hCUnBT94YilFS5rUQOdTNXmq9slzL9kmhU42LIGikgVQcL4812YHODmZXUjHJ6tTXVJrM/PQw1ETSOvwoNs6BE6RdcHFMP3FU2c8FPLxs+aVVcykRGGwnVfUNsmYR0+On/aCjaceKmc9noWnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Thu, 1 May
 2025 07:44:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.012; Thu, 1 May 2025
 07:44:22 +0000
Date: Thu, 1 May 2025 08:44:17 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Gregory Etelson <getelson@nvidia.com>
CC: "Van Haaren, Harry" <harry.van.haaren@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "owen.hilyard@unh.edu" <owen.hilyard@unh.edu>
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Message-ID: <aBMmUZ2RDSXQOHXg@bricha3-mobl1.ger.corp.intel.com>
References: <20250417151039.186448-1-harry.van.haaren@intel.com>
 <9c4a970a-576c-7b0b-7685-791c4dd2689d@nvidia.com>
 <PH8PR11MB6803458E6348B4D167C47C91D7BF2@PH8PR11MB6803.namprd11.prod.outlook.com>
 <IA1PR12MB63308A2F69036E3ACCC605D0A5B92@IA1PR12MB6330.namprd12.prod.outlook.com>
 <PH8PR11MB680363E200616CBB39DDDCB6D7852@PH8PR11MB6803.namprd11.prod.outlook.com>
 <c5387a8c-b560-3fde-3453-c2478d8e6969@nvidia.com>
 <IA1PR12MB6330872DB96BB9D83EF7EFF2A5832@IA1PR12MB6330.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA1PR12MB6330872DB96BB9D83EF7EFF2A5832@IA1PR12MB6330.namprd12.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0280.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: a2739087-5b42-4869-b6d1-08dd8883fce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mr5Y7n8NNPTsXXnsVUHNJV97zKPlfkUkw+ASEtJZk7Ggd9mH9bbJOQ0MWuE3?=
 =?us-ascii?Q?6sR4k+mc590D+6nLOwLFB6OkYWOsQafpRiNhSdiRgiNhT8sSiunZCVN4zIb8?=
 =?us-ascii?Q?mT7JdRw7Z1u3me+z7etVQ/On+BtXiTXEQytUVojwqp1W6Let30KD1qwgl6XC?=
 =?us-ascii?Q?VGhYMe4Ue5i0fyXB9qpHW+BldoqVQhkz/s6d6iWGJHlNDziw/kQ5LG2szxCg?=
 =?us-ascii?Q?UEHFSqIILrjlKI8bulNe/wxn6PdK4AZzKQ33dpRDEqJ2ZE1CSZHH1ttal1ZG?=
 =?us-ascii?Q?fg0lSqWn1QaQK7BdFmULBKh8PnUD5tx8GddQWDeLC3wpJQ+/h3FagzbeLqGj?=
 =?us-ascii?Q?oFZ9EaXdt7Q8ZAA+p1bzH85uh43z/nHZ9h5LkB7Kwob8j+NzrDxUwuUk8LGZ?=
 =?us-ascii?Q?0nRNZkhyCI8WNlQNWUt0Fs+pRrGuDlwUXA9KJA8htaIX6cvyeNZHDvyexJmp?=
 =?us-ascii?Q?Dhq6tay0d2Tga4BIGakyfBpyfnnpYPE0iCDvBmTw6GmTl29K71MEJeAM6uXe?=
 =?us-ascii?Q?BZV9zT4s59MZ/9Wsnt8KOkXF2FHyQ8GfeD3dEWIGpMHBcb5ySCGokqcztlhI?=
 =?us-ascii?Q?4hWo0O6wEnqgqzsi4qbYyLlXpx1MW9Me5Zr/cFEOk889UE0w2a26mMX5o2jw?=
 =?us-ascii?Q?d050ZCPXmDgnt/SqFptsCxliUrmOebqd4YLXfsn5Lwy/PbJL/6p8mA29Pu4I?=
 =?us-ascii?Q?TVr7oyMGIqfO8by/hNeIzA2a33FgpVdZSuGSojgma3TsFa5F1TKcmtFiIRzi?=
 =?us-ascii?Q?yXbnig6CBjj/ezlAwYFZ02wZR3CZWk1j1QMaQGeyNS46ExJEMCI0T+p5TOAC?=
 =?us-ascii?Q?gZ/LVkLvb1qygb667KDRbzs528UphNACNMKU7DaKs/TBcvQZWJFEcSbELpIY?=
 =?us-ascii?Q?n8ATQJCg5YuTBzrtmOC8a/Ia9+Rx4BwMLAl0SiE5Snuj0z5MK7ke7Zps/K5d?=
 =?us-ascii?Q?nTYoi72JW1S/guR+q6RWBONGL7JZh7NX/sAIoziwIVFRIpzKPFpVAhKueCzH?=
 =?us-ascii?Q?2w6Tj6S+if5Z4sbHxf79IAIteM6yq1+ZjO4iGsI0sW3rKwPlv43ud2BkPSa+?=
 =?us-ascii?Q?JyR3Jy8HBDORIDfroEivjx8EYke6FlofIY+dNhriM4z+xM4OyqpSfNmxpykc?=
 =?us-ascii?Q?XUTggti8B0fJQuaZwA5uMgPhCnyFwjcqy5ovLJyflnb/S/QMz0fuzB7iLaFF?=
 =?us-ascii?Q?qbP/WA0VeWdtkTo1SyZRGZgB7d/IiJaUFmuNQhIDgYof9aaFDUKYkmw/v4ic?=
 =?us-ascii?Q?CbpOQIIb+S4VLq5OPucBefuowYlAJj3nCXq2aR6ngQdVCzqkOKJzTCD/SHWr?=
 =?us-ascii?Q?HkppPASGGyhY6JwIWsLN9Lb1RFwi/JJxo1CLSkz+qPWVlX6oMHdbiuIUG9En?=
 =?us-ascii?Q?fbNLaVY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W+fkpI5mftv/SBwAzC/KwkN9D/e1vGK3VJQber8vaiCv3jBcW0csdAxOA4kD?=
 =?us-ascii?Q?3tebZzcaB7zZ9O+MfECc5ozO6cBP0tmETRFpz60+F7Pl5kH59HzoRtvA226Q?=
 =?us-ascii?Q?dCg7ZJvh0Qta300FYhncReGiHPLySmbfbdc2p2yGm3x2CjvJgOtotyTq1WKg?=
 =?us-ascii?Q?nBg7Dpnxvdn6Gcz+xsJjt2MKn1tv+aHJIwbhPo5VuNzdfmVbzxyMJJ1e8OQB?=
 =?us-ascii?Q?a7xBRNEH3sTH0/LtTxf39j2pJZ+zVsiFdZppCRKtev1j3YIuVIPJHcBd5IMd?=
 =?us-ascii?Q?I1MnWgHnNf9Izg338unBIMMhbLBrkzcDP3sIskk0oguhWW9/p6e/d8LIZ2A7?=
 =?us-ascii?Q?hU8/pzl01b4TmI5zjr5GzfN0LDJNCdF61R8dzCXuau2bxJhOP2b3UMj+AuC/?=
 =?us-ascii?Q?DWXcEA8NdeP+q2iIdRHYKVPjcF3pha9QI3xOvJboK8bDR7HLlMrc099nlt9K?=
 =?us-ascii?Q?gL1sa7c6l4UEEP3uuM8SR5pjmasJ1zI72wGYPUD6e0JUpzywD5klkJRBezxa?=
 =?us-ascii?Q?VbLWSMIVI5iO/Th+dNHjFBIlwqTh3ilYJcyF1ahKeoNgF3v9AtKykWKZDhY5?=
 =?us-ascii?Q?RQi7iGC2quTRRF48e4zTetokysuw+69WIHElLMBNSN32LHLnyxSUXNpdr434?=
 =?us-ascii?Q?Ne+lSmu+CzhYxb2HlfCrHSUfHj+JEEfzx6gupN1LApIOoyegYIUvHh0PV7I1?=
 =?us-ascii?Q?3f2dy7CyDbCpK3Z5Gb2v55vqr+Bnu2P5rIpo7kSc6/YEwlo3MIFjv6FWzGbu?=
 =?us-ascii?Q?LubADwKyE2ryGS8/jCVZ10DuYGpNhAvcM6MvKV4sVwNq/973wthBE5b/avqj?=
 =?us-ascii?Q?lRAPKWzFxgTu+RNmvqL9f5vre3oAhpkT324DWjLF9e3RZPifBtiFoRp5Tqo8?=
 =?us-ascii?Q?PeqyMoOZvQTi7jv/UHggfDdB8zr2MIA+sQgFlycDJyerNfPD6xn8b679kIxm?=
 =?us-ascii?Q?L+xLdM0iarg5IR8r0Pz0ZV6jGcU8bmwFIdgho17By40XQU57vU/KzLnDuU62?=
 =?us-ascii?Q?R4kcFno7dHlxmNR2hIFMyGB3HJxPXwfzPCNGsIDTi8A+q7jFJneiqqqmY5h0?=
 =?us-ascii?Q?QCdbF/xnd22MywiAbjEkkZBzkLUIufQh2SwrEV90tvub6hjbHOnYK+UPTen3?=
 =?us-ascii?Q?YId2CinCADxa0W/C+CGKhMetvdP+5dQgkgAfge/o2Su4apMWYBCj0kqf50dh?=
 =?us-ascii?Q?ICkFkxuGEqqTPE0z0EsnhldwwtEj1EXZ3IbgX60VtveLEfweH0A/xFmIClr1?=
 =?us-ascii?Q?3a47flgi4LtVu6G8MYhVH/pAOg6ePIpx19zIU4WC4MUB+pooWSbpd9DcCGOy?=
 =?us-ascii?Q?vHBcmUE2vPQ9hBizfFU4pqEB8GfO4E9pUxRYmYS8cq4w3lvVktItI5Diijh+?=
 =?us-ascii?Q?S2BaLIHZ84QSZTsfe5kfX6BChzOjooFlpozHEU0QfYCRHijNagnqy30SeKMB?=
 =?us-ascii?Q?sJZs2c9KEVqNHzta9MR5awf4BuB/IKg+cf2Bb1Chyli9MwmkJmub4BU2AJO1?=
 =?us-ascii?Q?W1bT8U8f2ne3b7YS0pxdX0OUZGy3IhaEodGIOgqYY/czvWklW2fQgUU8TnkA?=
 =?us-ascii?Q?/mQZueCAfQwwBgI/v3dtNUh0+otAC1ZVqtpo6dpTPhA7TcjCaRyn6ce5hGnV?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2739087-5b42-4869-b6d1-08dd8883fce0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 07:44:22.6590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0EPRBSruRksrvKxJOFDMUHs7eUTGDB24yU/7hYpR+R8VWye3JJry08ClV3E1a8UrPWVv3iOZ9+Wij+dQovqeilPTemeEhghWNQpc5TOFTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6005
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

On Wed, Apr 30, 2025 at 06:28:49PM +0000, Gregory Etelson wrote:
>    Hello Harry,
> 
>    I've been experimenting with lcore workers.
> 
>    Please check out the new helloworld example:
>    [1]https://github.com/getelson-at-mellanox/rdpdk/blob/safe-q/examples/h
>    elloworld.rs
> 
>    There are 2 options for the example configuration:
> 
>    1 Start RDPDK workers on the same cores as EAL:
>        cargo run --example helloworld -- -a <PCI address> -l 0,1,3,5
>    2 Start RDPDK workers on dedicated cores:
>        cargo run --example helloworld -- -a 0000:43:00.0 -l 0,1,3,5 -- -l
>    2-8
> 

Thanks for sharing. However, IMHO using EAL for thread management in rust
is the wrong interface to expose. Instead, I believe we should be
encouraging native rust thread management, and not exposing any DPDK
threading APIs except those necessary to have rust threads work with DPDK,
i.e. with an lcore ID. Many years ago when DPDK started, and in the C
world, having DPDK as a runtime environment made sense, but times have
changed and for Rust, there is a whole ecosystem out there already that we
need to "play nice with", so having Rust (not DPDK) do all thread
management is the way to go (again IMHO).

/Bruce
