Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247FBC3ABAA
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 15:58:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A48C402F0;
	Fri,  2 May 2025 17:58:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 322A3402E6
 for <dev@dpdk.org>; Fri,  2 May 2025 17:58:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746201496; x=1777737496;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=A9ReGToPgFdv5VkUICnZ5nDGFIb8AZZ+IlcGUoJDCfI=;
 b=g5Jwz5x2bUNz1bR1D48RTEfIxPaX4qwHzFOh9bCI0ZODBPYt08svotxy
 SQ13GFEOezvMD7n+7AuJG9R+9x4xi/itYBGCSRb8AxgYBsveeAIPDrOGc
 smFljCe5/wJcZ4zfbwM7ph5jpNvGLDGVEyFvZT95OthiJXzOD7YYSBxrE
 4P5e5BqhDPFHTkxo3OMXzSkg0mtP8Wyq1Jazaa3LbH/DWrOaMhDXOOjzc
 ygvYhkmR9PKuBYJ5Tjy+JaIQEoPl8Z7WPpY+C8A9Y+GlfVI6NNiRHPC4B
 XPQ6/RMGXD4iA79oHdzUYDqwxyjU7dWkfmBqr6ejCnw+j92YU6lghXLMI A==;
X-CSE-ConnectionGUID: LRToFaJiRlmAAvW6XmpHCg==
X-CSE-MsgGUID: q/tpRmDGRpOrzTOeMEG5Xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48029159"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="48029159"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 08:58:15 -0700
X-CSE-ConnectionGUID: iU1ePumRSRajsfuTgzqkRA==
X-CSE-MsgGUID: /W+4r9+qT4yE98lZNwcsTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="139457642"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 08:58:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 2 May 2025 08:58:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 2 May 2025 08:58:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 2 May 2025 08:58:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cb+TfqmMIwq82OjN8CVs0IZ0kdG8BXmT7XqnFnclzbGPVI0gsixeoIrO5AcHWTBiGV3II4/T8KArOf8oaVM7oc0iuEZ88q5yNAGSd1tSs0WWkj1sYkW8yuGFV2YvbWkn4PX9ki6sSTxzIckWuE79Ib9a9LdNm3zRYFqYKHiT3AB1f1wHdiBUEKeelNqQ4WXXkWVPRbi09OPX2gYJCsBpGMbYkx4Tv4iuGy5thjuxlQNIAjAZ5JSO6F48+1Bdp45wc1Vwayw1r2eUwbzMmQ8CNpVrxP9NPdMGRhvUH32Sudd/r3SlRw1kbXZ7RtAy6pojxpJdz47AlqjqnQJDvI11og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13ES6t1c5N+y5YzmrQeAsfDHL/Nv6zSBv3zvC7fjym4=;
 b=N7oKpyqdmywoSR/9Fx/Q46Dp1uZ8CDpUpsY07rh3dVZFKSLgZn+wowG5iFpedjJLw2stQR1+PVJkLFG2DW4BccqyyOWUKr44wpvD17dpi0jJyJtCYIbSfS0ZNqpLs14qkhNEqLo56ZvT39Iz8c6OwSSd/cFhszodakorktRyplVX/eq4Yv0ruFRXwkRwTv3TPA7DD0On8XpLNz2O/e9XKuewC1h9FhTaC8q2d9PxnNlVjJuLDXQu5vP0i1x4PQTJA3JcuLv93grt0m9hst9KFKjlv/1xQxUczB9km7xFLtkMnkeq8D7G9u9CLWXivoOAbZgfMnqt+tJ4+HOORLvs0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB6063.namprd11.prod.outlook.com (2603:10b6:8:76::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Fri, 2 May
 2025 15:57:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 15:57:55 +0000
Date: Fri, 2 May 2025 16:57:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Gregory Etelson <getelson@nvidia.com>
CC: "Van Haaren, Harry" <harry.van.haaren@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "owen.hilyard@unh.edu" <owen.hilyard@unh.edu>
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Message-ID: <aBTrfeHginZgVGwS@bricha3-mobl1.ger.corp.intel.com>
References: <9c4a970a-576c-7b0b-7685-791c4dd2689d@nvidia.com>
 <PH8PR11MB6803458E6348B4D167C47C91D7BF2@PH8PR11MB6803.namprd11.prod.outlook.com>
 <IA1PR12MB63308A2F69036E3ACCC605D0A5B92@IA1PR12MB6330.namprd12.prod.outlook.com>
 <PH8PR11MB680363E200616CBB39DDDCB6D7852@PH8PR11MB6803.namprd11.prod.outlook.com>
 <c5387a8c-b560-3fde-3453-c2478d8e6969@nvidia.com>
 <IA1PR12MB6330872DB96BB9D83EF7EFF2A5832@IA1PR12MB6330.namprd12.prod.outlook.com>
 <aBMmUZ2RDSXQOHXg@bricha3-mobl1.ger.corp.intel.com>
 <a1161f7d-1a55-6200-7440-d615d5a41a6c@nvidia.com>
 <PH8PR11MB6803B2CD0BF276C6164C3D97D78D2@PH8PR11MB6803.namprd11.prod.outlook.com>
 <IA1PR12MB6330B75B3A6E4781EB147F78A58D2@IA1PR12MB6330.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA1PR12MB6330B75B3A6E4781EB147F78A58D2@IA1PR12MB6330.namprd12.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0301.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5485be-f15e-4822-c95c-08dd89921993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2kQJYIPE2sjBlPVJzwRVINeGDDxcrpO6RkaIq45XCvaDtXjbuxA4AibQpdqD?=
 =?us-ascii?Q?VLWnb5O0SoVxZUGTSj4lOy16oV6r5xnjcyDis2rPOUqI3qW/8RKRI+ck2oVc?=
 =?us-ascii?Q?zkl13zL9hhTSLazbXTHrpgUlKTufo13zGaSQmu4M7GlBF6C2L+yQ+ZRtxqj7?=
 =?us-ascii?Q?Yi4OCrf8rPWVyupPjj994UZbUfMaXkXm5JFaQ9CXhTJvH7qEIQGmTtINVCVm?=
 =?us-ascii?Q?8eg4CVdghmObQQyw2MpSKJM6TYs/RliYBac1VA2xF23OJ17mbA3xpHD3KZXf?=
 =?us-ascii?Q?Bj3csz0UKN6hCAEOJiiX5i2flCjYGtQR8UOoD9g3cdPbgVOaJlAsvgFBTYm9?=
 =?us-ascii?Q?ZpMlOkKzYOtBryY+O3lMxlFJqJWezjKuEBRJJaDtKlBnyT6zXmp7H163jIWG?=
 =?us-ascii?Q?jWuShP7Rf0+7ocSOjvf0MJHhyjLFxlCs92wJh0c+ZSEIZfTB+x1Hpl4rECu3?=
 =?us-ascii?Q?2rpCKpdUEgfDYEGCWJjApxowWXk1hK2M9sB+8gyFBVAEPZEur6OLVr74wPRW?=
 =?us-ascii?Q?ZvBDoK4uwoMB+/h7a7mRYqVsfO5Vt44lV29jukUyS1qAIEVvHNfGX2xhg+Cm?=
 =?us-ascii?Q?+XVtuFulLUqvOQy0MJpujTNXj/RJ1VxD8C4zGMz6+XOQuyoBsI5bs+ONBt7G?=
 =?us-ascii?Q?x+um3tzh/KEpGvWYiufRHfq+pxtRRuLeIgV/DvXPuC+Goqt9JKNgAerThxLk?=
 =?us-ascii?Q?AAH5WHB3XEjp/YrFRfJALT3lQjGOtiB9IrjoaxiAH44Sq9zU3MBh3Bn6AnJG?=
 =?us-ascii?Q?JRXgYUmp+jEBkjByCxIDd6C5DDFRsSeIoUFpEQ2ZbXvdVIp5cl/7jWdMU1N6?=
 =?us-ascii?Q?51BdriBe4bpOOz+YjQRmtG6pD2MQo/DgOjoXkovlZiVp49AprFWcY7NndIS9?=
 =?us-ascii?Q?/rP+xLHZdcNtTj2DXGn+89r0z2CJFQ/Az2vCngSh0lLukqtKgaPGsZrburZp?=
 =?us-ascii?Q?/3zEi2y8XT/jAy7PzjV5QYZdH/LRGCy7rraFX8mk2v1Z2KUC7NdMJC5BNsHA?=
 =?us-ascii?Q?X4vKZFy4+89iC7GgwJ181/pCDnGgxOgjl1LQB6qzQlxtsFG/QNjnimqxRT6O?=
 =?us-ascii?Q?OO0T9A2/gwJUo49ydkyTNoHbizA/7OzHgvpJUjh1G6owIH1TTgLqEjxfwXh9?=
 =?us-ascii?Q?KE33MUOhFpX7oNiIlrXAoGgYxIC5GM5tBKW7Huz+5xkzsN1Z6MFdoLLB221N?=
 =?us-ascii?Q?TfD++4GugKh57gJ7THZZB3ktLzcd9edqcYRokVJE29wWvg78a8OBoD3A6jSI?=
 =?us-ascii?Q?2cYE4F2YeZb12olw5g5mQKAxHUauf+OKO547Ka6kYpfrCU0qRSSWqlg96ldA?=
 =?us-ascii?Q?XqQ+tjHnxsuuTJtm6DQT2MzJERqGzgqupy/+NEImjn7nlxxrmCM4HKaUsyF9?=
 =?us-ascii?Q?0sNGrGI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?coQdUdhb9fRj4mOMlWTo54g42cnJBLplfs2FFClUpv7NQx8aF/eKouDdKJDQ?=
 =?us-ascii?Q?hroJmnkTsAS20MgFbtAgkO8zijmGnoZ472A4BdqD4APjNIl11V74brnJZ7Kx?=
 =?us-ascii?Q?/pBPQ/yvou6NDShntX5MtpBmWjIi48vNnu0y/n07lrp6LDoNaT+ws7iNFXYR?=
 =?us-ascii?Q?vx/ckeyaE5+VoXzOrY8yyOR3+hiNFON4F64sochywt0N+eUa/YNj67hX3hMI?=
 =?us-ascii?Q?EF8klqypKi4B9f5BN1JtgcrRnESYaGY4MPShDCGQBq4ljBroixGW4oQ/lWNV?=
 =?us-ascii?Q?Kj94KDAUNxC/D4GQ3LKaX+jO48TS+RvSqRKjXqv6zq9noBbEKidlhe7wsNKW?=
 =?us-ascii?Q?0MpLpz9CYmYT1kgnGWJ3NVCj3fMPBwMrZaepTxw/qgHnIhpDhfFf5EdEMkej?=
 =?us-ascii?Q?CLf67tYY8B1fI+6iDu3OWO8d2Ii/2+B+ZJq8EBEeG1+HWd4IDlNwV72rqcPw?=
 =?us-ascii?Q?XwWEvCn07MbSSLca4xOe5ZxDHh4MLVglPmJL/tmJInZh0UpEH5FDmWDb64Si?=
 =?us-ascii?Q?SO0uuJWHBuR6NgO8O2MOXRcpdmBIdjHQY96dbCaC/QhPp2qJNIpkbZhWk9Tl?=
 =?us-ascii?Q?UIqPkq2QDQx6DEQUuwkaPXZkhObgAeV+XDMCT2aqvJPZIUV5mI9s4FLfMqzI?=
 =?us-ascii?Q?VMkZb6NJ7iNgn/15cFiETs18CVIWuphLI/U+ykQ5gdslWxJmcH9nUT+4iLVe?=
 =?us-ascii?Q?EdM+cZK3oWU31gfdji0j7N4eAcA2gudXXcVlt9vZoldqGyWnF1g62sEwzofe?=
 =?us-ascii?Q?a2k8FnQzjKon3zgKGf7FGsVs5Xlc8Ulbb6LSFUU5x3mKigPoTNImPsVEavi/?=
 =?us-ascii?Q?1xkjZ2Yi9tz+VDNxcpwDB9+C/VW+DXK2Ug2w5e6Hlzb6f/l1V0ovMbb8sg1I?=
 =?us-ascii?Q?bQFOzTrQJC8gv5kXj6EBdjGjVsMVCeruJ0kE+VvYIlj6LQjcyUCrbSauHg+4?=
 =?us-ascii?Q?7FVyTfOreQOora/vv61Te55FGCb0EPcBfMhrrjOiQQ3LPMIjZEcn33A5EZC0?=
 =?us-ascii?Q?LaOY4gFHO36nRw+ophBreWHN7YZRXUITI6YTQuNOoFnZaVkKL0sLrSVdHt/3?=
 =?us-ascii?Q?Ve+7EPz+u60ZMo6Ssj/F9EXgdv5l1cYHjmXCoswDrQ860/J3s3xv0KgWPiuw?=
 =?us-ascii?Q?5A2MNl7N6tUO4fJJ6wk3YRtpLws+oUhfWqNGgNeB2ooVN5cP0HQwn1HEMZWy?=
 =?us-ascii?Q?TsuGDOUkXywZlWg6RZ2SbKfEScTCgQYKe/vwkmuKEF5Dnv7cgfyJP1a3ZqXW?=
 =?us-ascii?Q?bnkzEwXcZm/M5YWOFT6aOfc8Wv4RiaxGc0tzJi53QN2zJPQJw/6JKv/U+nGG?=
 =?us-ascii?Q?cUXwH9aoJHufd8bISF2GTLGVfnxPPW27+wmz6rJOCKob9nIV/PRh2qyE0BhD?=
 =?us-ascii?Q?DzK2obBjnQY+9F0IMkEeiQIVfJ4Dxm8WV8R2q4DsqvqjjAxhreDGbFqSkZQn?=
 =?us-ascii?Q?AgitfAX5WCnHVgG9Z8/OOnCLOznlUIGWX7oxnoCAFhRh5FHOxXLhFoBNbv6E?=
 =?us-ascii?Q?KkkGg+3HiixiktBeHclLHW83uKgSL1CIWYLakpZJeJOmG3e8891eOkGxPv85?=
 =?us-ascii?Q?m0ByE7QocwMZ8i7E5X5IHLEeSjQ85VRft+PpwTyLOvof3mCle0gbv0rdF+r6?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5485be-f15e-4822-c95c-08dd89921993
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 15:57:54.9622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /q27KCLNd/8/w6cUmGdr5Q8XqSSlDOdQQFj6lSAHQBV7MVyyB/c+KggNU1oWplc2DqlSpED8ZnGMXCOIOY+f8bGU2sGET9oxPwUQ49qaWsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6063
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

On Fri, May 02, 2025 at 03:41:33PM +0000, Gregory Etelson wrote:
>    Hello Bruce & Harry,
> 
>    There is an aspect we've not discussed yet.
> 
>    DPDK is a framework. It's integrated into a network application.
> 
>    From the application perspective what is a ratio between "pure"
>    application code and DPDK API ?
>    The exact numbers differ, but it's clear that most of application code
>    is not about DPDK.
> 
>    Another question to consider - what is more complicated
> 
>    rewrite entire application from C to Rust or, while having Rust
>    application, upgrade or even replace DPDK API ?
> 
>    DPDK provides a solid framework for both stability and performance.
> 
>    In my opinion, binding DPDK as it is today with Rust can significantly
>    improve application design.
> 

I would have initially agreed with that assertion. However, "binding DPDK
as it is today with Rust" has already been done many times and never got
any real traction that I have seen. Just look at the number of crates
coming up when you search crates.io for DPDK[1] - and from a quick scan,
many of these are not crates using DPDK, but wrappers around DPDK as it is
now (or was a couple of years ago!).

Given that it's been attempted so many times before, I really don't see the
value in doing it "one more time". If we want to offer support for DPDK
through rust, we need to offer something different and better. Any rust
developer can already use bindgen to wrap DPDK themselves.

That's why I'm trying to see how we can offer something that will be longer
term maintainable and usable from rust - rather than just exposing the C
APIs. For maintainability we don't want to expose anything that's not
absolutely necessary, and for usability we don't want to expose anything
that may conflict with what is already there is rust, and for both
maintainablity and usability we only should expose that which can't already
be done in rust itself or in an existing crate. So I'd view (almost) all
thread-management, and most of what EAL provides as not to be exposed to
Rust, because Rust already has other ways of doing all that. Similarly for
the non-device management libs (i.e. those not like ethdev), functionality
for rib/fib/packet rordering/etc. are all better handled by separate crates
than by wrapping DPDK.

Furthermore, I also tend to be skeptical of the longer-term maintenance of
anything that is outside the DPDK repo itself. That's why in my initial
RFC, I looked to add to the DPDK repo the minimum hooks needed to make the
repo itself a rust crate, rather than having a rust crate that pulls in and
wraps DPDK. (Again, there are already a handful of those for users to
choose from!)

Just my 2c., and where I am coming from.

/Bruce

[1] https://crates.io/search?q=dpdk
