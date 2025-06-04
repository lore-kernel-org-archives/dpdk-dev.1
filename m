Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F02C5B552
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 09:33:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B3F84042E;
	Wed,  4 Jun 2025 11:33:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 0CAB94029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 11:33:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749029635; x=1780565635;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=c0c0JLc6ZV8EInZ7t6gMWrlxtuhHdFgGmD28eljWE5s=;
 b=K4L4LTk2h3FNvzLS2F/ySznRw1kEz7xUcTU75af75+VNUFtJVH4fvF+z
 2v3W9I64Qbd/WXLWwRHpd1+0NijCrEA21t221DUiaLOQrSUChOUFdRa8N
 IMsdI4aoACUDOfRWz/CwnKTjWST69LYnvIKMxRGBT//+cwq7tFu7ssoLD
 lhQUhioFLpa8+7AWW2w25vzAxHPaR6fd+ik0bXaZxyg8NEr8i+waLpR/x
 1j+KxEk4icaP6OpI3XNJ3F4SiVpT7W9ja0Mua9zj0ZKls8BMLhiuKn1aN
 YHbbwq3UTEvtuhFby3YHxNG5trjfvs8B5ARjUZT3NTpuOmveiG1f8YZFI A==;
X-CSE-ConnectionGUID: vEIV8nBGRq+6TjlhEJcApg==
X-CSE-MsgGUID: 4ZyF6eu3SkmyDwXUnjtiBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="38734513"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="38734513"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 02:33:54 -0700
X-CSE-ConnectionGUID: AfYgyt9/T3epVb6YE2+uog==
X-CSE-MsgGUID: pm3Ir3LeRH+k9ZFsURmZyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="168308158"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 02:33:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 02:33:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 02:33:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 02:33:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKocD4s+9jPsg9yIqJ6+u4bmB9ptvURb2WagbeMzMqBmazQY0LsHoz0UqK9+bTf2sZse4Ckx426zhspGNvbbK5D+Ad8FCnL+7BeWI5a2TndIS2JMtR4/V26uwtPNFBJpcMtVPtmo2+j6RL/2Jp/5RNUlZB6xW6A44obWRL5cJsdOSTUH09LWKrXCgCUG+kHdRufzdiGuewk0bA51sUGCr94kHm5PmkvK+b3Xvma1iDM8Vvr71FZLB3Plya2vj17t7aVxcURrcdBRolD5yL+qfOoSxVXoVHxYEq3GDwod67aAHKUy4GV7NwZVSzNZKxCob7lmQMK78qVRZQ8pIJotcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4tN0IZckCSfxLcMrv6BdtkhqL4q3omifCt3KHkY5mo=;
 b=av3kEUeNYz2YO+Zc8un+8i4roifz5tsk81SWgpmum3FMWkygKRwqq9dqASnQme7vRSCMiUDRrq+ejFmNqrFmuAhLirT2ZIgZNFz/3V7+PoAIlcf2FhXY7J+6pO9/1WppDQKBm5f9Qdq3TN79qCMVKp9K0Ffbqn7OQSJWug5GFoV/idBMNI99kRrTIZknToMHj8ZonM2bYBOHbJEHa9Gi7Gpw/AXrhBPeaWD/hpWjaO6yS7sh71xmYbqaZvYkjQRfevLrbRp0EqYAeRS3R6vhNbMsUr9HPnA2AVejZvqFuaFZAHWAZwB4qoXFeShj8aD27ZPNv7j3UJZY7QQtD5R1FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF632600ADB.namprd11.prod.outlook.com (2603:10b6:518:1::d27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Wed, 4 Jun
 2025 09:33:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 09:33:51 +0000
Date: Wed, 4 Jun 2025 10:33:47 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Ian Stokes <ian.stokes@intel.com>
Subject: Re: [PATCH v4 20/25] net/i40e: use common Rx rearm code
Message-ID: <aEAS-566wfPwsA34@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <e8974cdecace4e2d1c8c88c5aa7437ed0cb57da6.1748612804.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e8974cdecace4e2d1c8c88c5aa7437ed0cb57da6.1748612804.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF632600ADB:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e029d0d-690c-457b-6074-08dda34aeaa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qyl8Z4/dAV/9vXvMFO5BrzS/dtNmHsYQdDvDaS0iWry3thIHpk+VPPYuVk2V?=
 =?us-ascii?Q?oZ9TiXie5OlvtAacDW7hkVsNJA6o/9+pSYPgIIB23K0cn4tYlM8AVjtD2dCf?=
 =?us-ascii?Q?tRarBdm9FML/0rhBZauGQrrCbWjWA6dYPQeGYfGOg8rs58joygYKUEq1WwvY?=
 =?us-ascii?Q?8SNHq6XP4WOZantHKP7OtR18z3YHAtpHjf5jT8mW8nIvhxsA0UcVdjGTi5Rd?=
 =?us-ascii?Q?S4/45m0dvAfx5hG0WkH3qHW/qG6j7eoQMMZfkHV+VK3G6Xh27pTs9+VFW6aP?=
 =?us-ascii?Q?Pyefp7klwkPBwGHTuiw7UbB+l/SlBAkkZlXE7IL9uMJVrPt4oNqiob0NmDJ+?=
 =?us-ascii?Q?qzTuh+eFAuYIUuJiY1c5GeaSba9GXC7AMgAjHT039Vvy7Q/sP6HZyLtz3zEe?=
 =?us-ascii?Q?ZGJw/GVdYyvRPv2r836pygjV8XFi4oiT16Rmo7KtB0QEI5G0fAuWLITeFt4X?=
 =?us-ascii?Q?8C6BuGjiplpPce+QIxW/NT8+ra6VTcARDzy28NwYJDWWq/oEOD6g8PNrmCqR?=
 =?us-ascii?Q?D1XGZi5Sp7vTtOcVWGMnBdF8mdeTla5ZL1+KdDEohV7nSltdc/BD3jieP+gg?=
 =?us-ascii?Q?/xgjtCUKAyN6ARrsr+gxToIIMSri1hlKlnrZr93tWkuPPSecMXcFZuESXq2y?=
 =?us-ascii?Q?juweHWixnNlEBtoOHCmfs70d2O5rT9oKJMqjWK16wuo+bcyAk1+54f//Lcso?=
 =?us-ascii?Q?W/RcRmP3dvcmasds8Fp34CjS0pPSiFwqhLutWha9JrCoEJlOUraHN2olAW9u?=
 =?us-ascii?Q?IW/theNrNjuxQHb3RtSP9KQ57AEzSM+3r3teyp0RlSXJt3+M/eTssbJvPY48?=
 =?us-ascii?Q?8roksih7VWqDSfCMzlTdOyhRK2vGQj7Ce8w9vpiibkaOsbd+S9N7l/at51Le?=
 =?us-ascii?Q?KYfvDi7Gv73m87tw+UhRu76u9MWpeJ+EGX+0Ie5AkcW/Z49wUNkEn49Z1KqG?=
 =?us-ascii?Q?+/vi7VtdC5hw2CxRqBDvukZx5G9bPbJ3LYBJCUOToEEYN/w+LC7WQ3gD2dax?=
 =?us-ascii?Q?xU7SreBoSSeHXGt4s67u0uFWtzO6CWpQxFz4v5aIxSmVTS2JWUOUcQSOdhuA?=
 =?us-ascii?Q?3siFtXCfEH+AQvOkYgWFgtsGquQKCijfL8/zbWzZu0ia+XEsfxVXbBCWeDdD?=
 =?us-ascii?Q?QIbXps2359/iKZwJMfqcAgjj2eol6DXSgyYQ1LYNqKf4PsyASp08IMpjA5PQ?=
 =?us-ascii?Q?kCWPJjzQz0NL5nSomjgwN03TJlaJegISr5MP9ecmia5BMsPGXAGUS0IKL7RV?=
 =?us-ascii?Q?YxOLiYdRiuQ7AzaP+N9eYzwprMdCmYrMIVpliCdwBuCrqi7qx6pc5WAXqfUM?=
 =?us-ascii?Q?uD+eRkH6SfxYVsw1u0mAarZTYA7CKqEzD7NlXcv+ETVfZfZMH4Lw9iCRR02Q?=
 =?us-ascii?Q?tmaOpfzwAPkjBrDzFZBW9Mf08RbSKz17XtXiq1PGKvsqFEu+1v55fTyK0FIm?=
 =?us-ascii?Q?uZaqlg/oOqY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YvzIwtXBpVz71ecIyNr6EtVA7GX/MBBvNbpLtHfVoUGisDadzxhIRtnjVL8u?=
 =?us-ascii?Q?GaXBKZnuJcy5dogkaMXvKseQaKA23S9Mz4qFqIVAbiGEkQloeqIF2dljrP6M?=
 =?us-ascii?Q?qo4bowak40I+FNCDnkdQiqHgR7/CWfXvyOetozTzxxngEvLH/ndYGIWh2bFn?=
 =?us-ascii?Q?ZNI90Q4BXbo1372NHW8dlO7c0TtDpYQFo9KF8vYrFkqN9d87SczbSQrQBY7q?=
 =?us-ascii?Q?qoxy5zMCC6nnP6mxL6sKYCObtyUMZxFWlTMZy26YaVk3FSA55/QSmdlC/pj7?=
 =?us-ascii?Q?HVr2vlqZF1Ww7gaZ3NY4vxXcBcJyYIeHfuA6ScFyknC94RQnsirEYARAYoUx?=
 =?us-ascii?Q?BNZ3Oi51xqKfIVViAP0gm6npgwALsgpPIJR4D5KDkQN/w2EjxikuMtqlvogP?=
 =?us-ascii?Q?X3GcwMpMJlrH/RH/q4wdJzsED2ji/Uj0UBVO2OrwaqDPllgfJf0BjPhp6SZo?=
 =?us-ascii?Q?/bFJ4jp7CdcjmmOCigz1xMBuSFo0/moliT5su4kUMg7/sIpxHK7ngHCFQxGZ?=
 =?us-ascii?Q?EhmGujjqYyiHRXU1+s5xIyTb/V6KOeVkUMzYad6ua+toKlLVj8lMiWM/tQ9K?=
 =?us-ascii?Q?ZfIXZo1X43zWWc6gkLQjbAyOZSuyzrSQ3pT2dXCbv2VbF8iqaGhoPFa4BtYp?=
 =?us-ascii?Q?qhdFZZGkSu7yN2FvjBdVeO/8Pyr6SKWfDKwiI4InBU5qbZCg5GSt11Ow45oC?=
 =?us-ascii?Q?dUA4orI1Ew18gn9cg2ZcxZXMsZF96ecr0Gn9/vPdDFmMvvHA2A5ADXgpvMpz?=
 =?us-ascii?Q?YwzweGkByqyEeSSNGGQAsn53/qw4IcTRbaYXMIyvxhsFFVKHFGZYEi9yc2w6?=
 =?us-ascii?Q?S3cmA/HAh+FM7o+AhWl8TUrohkZtHk7W/k5ZqxYi5UT5CpXXGqEuE2Xzedd2?=
 =?us-ascii?Q?ukWDuV+AZsAV/G/7cuzrdq/S0nqYJN5SJym4UOAyMsXSOm2kIAP9TY6wKqrf?=
 =?us-ascii?Q?BSN/RRZlgbuh9QRhwYpUOUQfOVr+k/X4wJfNF3YymlTlRLXLQb4q1jL3zyWe?=
 =?us-ascii?Q?bluoiJHz4wONtFSK4ToXrzptWlbw9sunf7AaE0Y+Egj/Y0W1CuGYHfunzNFW?=
 =?us-ascii?Q?50BTcfLOeJP4CEg3Dv8fu/9yHlf/Owo9264X9bomJ4OhtM0oVq8jn79Jm/Sw?=
 =?us-ascii?Q?YSqTrwWh9YXBoYaDMdAUUKwUrm1XCfMXTn4TWqFRRAXU3wJfYEGX+dIwjMSi?=
 =?us-ascii?Q?o29taky9WZ8qWNW/w+5YJTxyffROqhT4VNIfFA+yZ33QMhN10EiNzl7H8ltM?=
 =?us-ascii?Q?dfvfL4VAkWeQPpDDMWK1ieDFtt1+bvPE+kPjQsvTywhOAzzLkZw2NuBo8j23?=
 =?us-ascii?Q?VIebBIMD0lxojZKYAQ7BwbHcxu/RtGQpF70KABRjwi7TNbYfKiExCRvjFLJT?=
 =?us-ascii?Q?bx2zK/dKXQxd3n0Ev+Qd+/DDGCcyTSr0Uyjn5gmxBZsCqm4WxVjX2rX7fOGD?=
 =?us-ascii?Q?JOygof9WYYRbVFjRDi7+EyCw/XOVwGpMq7514tzVV/FSzQavhX8HnVSTy5M/?=
 =?us-ascii?Q?fAMEHZgoimE7ImmaFly6+L37ADcucSS60OayNQ891jXv022VCtvM3/a/t2H0?=
 =?us-ascii?Q?VLccd6V42P3LlhKY5tVd/ff5EVpL4+VtGkGkmin6AQ2wjOcl6TfCkTAPORqd?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e029d0d-690c-457b-6074-08dda34aeaa8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 09:33:51.7485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5mfBzrnJD+HF1nlXtwJR82TMNrnQEdyreWT7MmfpIDdZqb4QWEuMcN1mmz7zOv5axhRnbYRRlFc8LC8lJQEZrVUK1PFmhDfnUvHfoIoCRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF632600ADB
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

On Fri, May 30, 2025 at 02:57:16PM +0100, Anatoly Burakov wrote:
> The i40e driver has an implementation of vectorized mbuf rearm code that
> is identical to the one in the common code, so just use that.
> 
> In addition, the i40e has implementations of Rx queue rearm for Neon and
> AltiVec instruction sets, so create a common headers for each of the
> instruction sets, and use that in respective i40e code.
> 
> While we're at it, also make sure to use common definitions for things like
> burst size, rearm threshold, and descriptors per loop, which is currently
> defined separately in each driver.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
