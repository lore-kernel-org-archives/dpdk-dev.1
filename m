Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCEEC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 08:55:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51D3E40275;
	Thu, 27 Mar 2025 09:55:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 1C98840261;
 Thu, 27 Mar 2025 09:55:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743065743; x=1774601743;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ZkADEahZ4euZ+GPBxNV9CHyz0iEBti/BTZ/Lf1u3TXs=;
 b=gCLvAxtVXeZdI9LxwjbV6UyTm6ym1qx6OHlajdnQxCnzzfMPZeU9LckH
 OXwEA6P3D0pC1trI5HP+9SsKDYwPJT1aK/N9KVGU9Uf5OjGdy0Tgy6cjm
 9ZiB3Wf9WcnL3+6JsbVy725HSB/lWvK0oilRlqqAl6/ZcJ0K1/40Iz4y7
 fkjXGTKORkosGbXGH3hz5BU71X5ZY6QfYPV+WzKSHTiCx6ob8pul5/Nc0
 LkXtG912zQOThEceInFl+c6EAcvRP48kB9HnuMYL38+Q2qBhA+Mm57DL8
 xyV/XITHmnjik+tlkJ/Aba8QgSQGcFnwDNWiMet0lKDscsnHGiE7nLbCP A==;
X-CSE-ConnectionGUID: nsqA2UXUTfmARhU3sZpgvA==
X-CSE-MsgGUID: k3z1SjpsTNuecdFGSxyBjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="66855236"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="66855236"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 01:55:41 -0700
X-CSE-ConnectionGUID: pqML0fqAQE6jplbLu0P3bQ==
X-CSE-MsgGUID: J5ze6YEKSrqAw5TYrEolpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="130173664"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 01:55:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 01:55:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 01:55:40 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 01:55:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhvHsMw2KtCogKKBN7BsFCoUqp2W9FIqr4Fr0SZfMCaA59K81kcpA3zPABHcXuq5w4u/5AwCYWDJsxhNCOCGtXpoq2d0R6U/zsXP6u0uCRZNPnvxQBTSq6KXwKoB/W7eQMu1e81RA1KaEByLldHOIZDpR4URa30vW6LjweDZBqWwO/rWsd02kyTc0RLbVwTZIqov2yRxvo5G7D5yaeHloEQRV+a4DliMmyGRtWDs4KQtv+LCXQTO25RYBk/K+WvMXYa/P7MyYkqRHfHhzF48K4Jvs3TsG6vnUlRHu+cBuNP9oBQ1jNSPO5uYtaiMpaXt/7+qFXKPIi9xkjP46rVtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FKj4x7U6aXEB9wb5pml/mG8zODgY+G4UjgiSssa96M=;
 b=PkRo2PVNN8saerw/5uPKdFDduTph3Ny1sVXmxKvPYxLS262gPqh4NmMauLfFhmUPZUHZyzujcvZ8C4MD18KosVtUTLyUnoNYG7lmWMlJesRsF8PXXPikSZB43Y2O5SjUjQavvhI10E3wkhj6l4KQTlnV2YZkJS/sZBOi3xCiJ+qM7uJWPC3mZh69Ajg8S+Q/F/ukzjy87BzzYkdT5vO6qwGrwZFBCX3LpvRjEOrsDDKQVy8acY8XECjO71t/7iZ7dLWway9o5N5GYjmMVXn08FKG7o7HRmjulnT5HS851c5PAChb549cc5NkLB8axW7/lj1S8Y1lVx4WpozliRDGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM6PR11MB4626.namprd11.prod.outlook.com (2603:10b6:5:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 08:55:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 08:55:36 +0000
Date: Thu, 27 Mar 2025 08:55:30 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <bluca@debian.org>, <stable@dpdk.org>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>, David Christensen <drc@linux.ibm.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: Re: [PATCH] acl: fix build with GCC 15 on aarch64
Message-ID: <Z-USgmK7lRZsjcIn@bricha3-mobl1.ger.corp.intel.com>
References: <20250326103928.1189243-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326103928.1189243-1-david.marchand@redhat.com>
X-ClientProxiedBy: DUZP191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM6PR11MB4626:EE_
X-MS-Office365-Filtering-Correlation-Id: c23153b9-1a17-4d1f-f65a-08dd6d0d23e0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXV2cUJrQU9iMnRVQU5mOEcrZElRV2RYM3FJR0NpOUQ5bDJWU2NyNlNQdWY1?=
 =?utf-8?B?V2VZSDVCRXpOWE5saGdjWkk3L3NOSVRsZzJVa2lqaHloNjFmR3Zxc1JYVUtH?=
 =?utf-8?B?Y01lT0xIZENIMjhVZzBRWTVZNnZNK05IRVIvL0tDeEJGSmFDUTgxcS84eHNs?=
 =?utf-8?B?SWhpdWpZZWs4Q2tHUFkwcVlhYm04T2VGR010VWhTY2ZGdVBpZmdwVGV2SmYv?=
 =?utf-8?B?bmoxVU00d3Y0MmdDVy9GZkdlSUpzY3hVRzZHTCtXaXUxbm4zNDVWTFFISzBH?=
 =?utf-8?B?c1VBbDdDdWVGV3FTNVdKUXg0TU1JekFObVpnemJoWisyRXU3cDF6U2p5K3Br?=
 =?utf-8?B?Y1ZHd0VVNFpjNUdzOGllMkxBNFdYdG9jQWRVblZGM2hsQWRrS0pyOVZISG9Q?=
 =?utf-8?B?Y0JmM21WTmUxaXU1Snl2NlhoUTBLUlR3WDI4YXdGeDJpT3oyeUhtcjg4M0Vl?=
 =?utf-8?B?a1pYWFEreFliZkMxR2M3d1dsSGVUeTNhNTUyeEVMRUdYNkI1N0dLcG1nczMy?=
 =?utf-8?B?ZU1OemcrSGgrK29CbkZMYU5LY0doLzVmOGE0eW56Yno0WXFVaXpPd0Y5dXpE?=
 =?utf-8?B?WUo2Ti8vbEh0UE1xT2RkN1BjV0JETVhRMUN0bjdrMXRCTWptWFJPb2FkcEZa?=
 =?utf-8?B?akc0ZFk1ZFhSc0pjK2ZPa0FyZXpxYVgxRzErNDVCYjlyQXZKUnlFdzFlY0s0?=
 =?utf-8?B?Q245WFFsL1NrNUw4Z0VYdFJpc2pNTU1EQ1NhYVE0ZllXMjk5SkhUN25JdWNI?=
 =?utf-8?B?QVhSUmgxS0dzbkdUR1dZV0Y4bzAxeXNPWU9FbmYvVFpEWVBuSVZ5TzlQb1VL?=
 =?utf-8?B?bzBweXB0bUEwQnlSbnUrWjZOMm9WNTdKeGFzaEFMQjhVWTMxRHNBT2ZNcnVM?=
 =?utf-8?B?eWVzMkhQQlhSMTZYNTV1UTAwRXFxYWM5ZWxwa1FYMktxdjdHdjNwckEzOXBU?=
 =?utf-8?B?aEFqcjVidHJyWUdwSXlIbjRzSXhCRDBoWms1ZEhkTlRNQ0RuRUN1NFNXekhs?=
 =?utf-8?B?dWVlOUFPckg3OE9MRFpFalJ6a3lSblFwVzZlbjRGRElTNGR1aG1YbmJsZzJ2?=
 =?utf-8?B?ZUNQZ0lkYmZiYkpNOEdQOG9LTW8zNWFDUUZ4eDhiUGdGWE5PZDZyY2pnc2Ny?=
 =?utf-8?B?Z0M3TTA4Vzg1UzFrckIrc3gvOE9GVXhvS0IyQWttQXBuWjR1ZE53ekQyQXFl?=
 =?utf-8?B?aG5vVDZ0VlJkcUtEU2J0U2NrUkFpcENkbmFXaVdRUlY5NTdVdC9kQTJzK0xa?=
 =?utf-8?B?ZEFRVHlsU1JzMjZYVmtDK2wwSTZUUzYxdXYzc3dXNkQ4bEF1NjRzRnU4OUVh?=
 =?utf-8?B?RWQrcno2U1EyNVF6aStKcU9pYWR1R0lhdmhaL2VLUkc3TWNSejFBdklWTC9V?=
 =?utf-8?B?T2ozLytGZ2kxb0oxa2FwbGl5Nmc4S1hrTTd3ZTBHRE56dExXWEdaVFZvSzNU?=
 =?utf-8?B?QzZiU29EakUrbGRoTUlpWFZSRkZFZTgvMlN4cU9XaEVoeStwcVNVcWVCMUpC?=
 =?utf-8?B?cHNBSUFFZWlFZWpKQUNPWVBMVk10Sk0wMEZvNUwySjNyODJrYzU3WmthWFpH?=
 =?utf-8?B?aHVEN1pxRHRRZUF4dVF1cDBNNWxnZ2JhVnF5d2VNcHJqU0NvZ3l2cVlYZGkr?=
 =?utf-8?B?WXBkOXZQWm56S2QyRGpwejVwNlpjQ09mVVhaYzNSTUFvVU9pTjRhMDZZblBi?=
 =?utf-8?B?Y1I3SFpkZFMveUsvWVRrSU5LUFFEbm5qdDZOdXJJWERZZ3hjRGlJcFExREJ2?=
 =?utf-8?B?RU4ycCtxZDAwaGRJNnBHTk5MY1RJc1hpQU1QOHdQOC95Zi90b1ZndnErRy9T?=
 =?utf-8?B?TzBreS9WRENVSnhyNHRwUVlQT2VSWGh5aVFTMTdzZ3FDd2p2KzVJaUszVnda?=
 =?utf-8?Q?45WCbvyE8oWXj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjZiRzY2cTJBa2tmeGR4Wlc1S0FocXE2VEd2VTNKemxOVjNpL1pLVWdZKzR0?=
 =?utf-8?B?UGh4RDFNTFRObXFxWVNORTlFZ2VxWGZZQU1NRFdqaFdhSVRKY1FjZVpyaUo2?=
 =?utf-8?B?djhPZDJjVnh1a3hVRDliQ1NBUVRKVmRpaE5TQTNsNC9STzlsenRyWEIxUVBO?=
 =?utf-8?B?WXFuamx4NUtjZUpjWDJvN3lVY0IvSDluemliSi9xQzVaVE1KRmNUKzd5Y1RO?=
 =?utf-8?B?WFdtb3hQbzVuRmRYWXlVaTlUSlBuSFVDemQvdzdZL0o2WjF6TUZSZUJ0NkNy?=
 =?utf-8?B?U1RZS1ZVanczb0tROERZZTUxaEZobkYwM0MwWldOeDhQYTR4dzQ1VUsrZlcr?=
 =?utf-8?B?M3YwU1IwSHRiYXBNUERxVjQ3WXQ4MXdUTTBIcUIxZlQxMFZscmF0Z0tXZTBE?=
 =?utf-8?B?K0NCbUs1QnNpU0xvSHAvS3V5cWtsTkJMZVJ4NDdFNGdZQW1CSlpONzRCWFp3?=
 =?utf-8?B?Y3czbFZjRE9FU044RUFrTjdnTC9Cdk9VZWFPczk5YTFGek5mN3pYeEhHamZs?=
 =?utf-8?B?UUZtZzFFcjNKMUsrUWh3NmhhYUlHdU15VnlrWHhzMjRXWkpWUFlna2dRbHhS?=
 =?utf-8?B?d0VxdU5OTXdwUlRLRjBwTWdZVW1LenFrVm1Ya1RON3FEZWNnS1lHYTRzWUFp?=
 =?utf-8?B?c0J4UkQ0cGV3RGNPUEg5K1Q3d2JnQWtwOXU5RnU2Qjg3bGFYd3crOERNVzZT?=
 =?utf-8?B?OHcyeEJwU1NnVXFnbkt6NmNGUG5VVGRyWUVFTnRKTHJDTlU1eUZ6eEVENXhy?=
 =?utf-8?B?NXdGeTlmWVE1a1ZCdjZTQWx1NEFzV0lGR00rU0dDS043bThRa09lelYyVi9n?=
 =?utf-8?B?dTgvcW9Ldmw2WkJ2Mkp3LzJlbzVrb1orYi9kdE5RV0FZWWRZSVdCUHlCSGJs?=
 =?utf-8?B?Um5PeTg0S1hJdlVscEpsb1NZNkhubFdUcisyaGt0WVlJc1dwY29xREhQRlMr?=
 =?utf-8?B?MmpKVnlUSGNuUzVZcEQ5bGZDcldXeDZYYm13ZlhublpPZmp2VzcrRTJnU3N5?=
 =?utf-8?B?U2xORXRLLzZ3MzhGTnBwNENMNXNQMXhzOG1hbTNRZXpJcnRLQ3J4M2dPVTdJ?=
 =?utf-8?B?cE9HdUpaZW1OYTEraHhaa1RpSGw1V21aaGY0VXJpOS9aT21QTHJSUzFRRWhO?=
 =?utf-8?B?RFIvSXFaRTlUaUlpWS9HY1VuaFBnd3NCakIvNVZHelJONC93ZGNZNWVyN2lB?=
 =?utf-8?B?eGdxSy9WUlBqaUg0Sm0vRlBBem9Pd09oMVJEZE1KUjdxTHZNQjNCT2FueW1C?=
 =?utf-8?B?M0w0Q1lzaVRTcVU0NHFld21ocUUwc1Y5aW9oNUlWb1BjUEhLRnZ3S3p5KzFy?=
 =?utf-8?B?YVdQcWYwWTE4Y3pub3VqNWtMYXUyWG9yMzNmSldvZlhacHJkanhHeXVJMVI0?=
 =?utf-8?B?cGZJeVhLbU9EbERvTEIrWmMzVXBhcmZJMTV6S3BNN2RSQ09YNDdVVk5zQjZE?=
 =?utf-8?B?ckJjSGI1d1o5TW81S2tTZTlPeHA2dVkxU1VnaTNmSDFCS1FWVy96OHB0bzYv?=
 =?utf-8?B?ZXk2dHd2NlhTRVJWTld2cXIxUExKTUdyL2F6ajZOUHJzamFhbTd1QlozVDlH?=
 =?utf-8?B?SVV0RjRCWi9CSkdMdTNzejg0L0l3SDRGMkpkaVNEUDJuckdQY3RYMWQyZGpJ?=
 =?utf-8?B?bHNCQlY1R3EwZENlNHBEVFZraDdOcmZMOWZkaWVzU0MvUlFxbExaVGhNczZv?=
 =?utf-8?B?U1d3dm9tRkcrM2QybGlnSW1idjhFYUd2MU9BOXFTdVMxTjJVTmJRV3h4MFdk?=
 =?utf-8?B?YzhGUG9lWk5zODN0SUEyTnprMzl0TGRHTU1Jek9wZGpEdUp3OVVmcVhTZnRZ?=
 =?utf-8?B?ZFRqUnNpZXhSeHk3QmFzanJ2VXEzWXNDd0tGeWtSY3g3ZzU2UUlUS0pjMTZC?=
 =?utf-8?B?ZGN6ZjJiUERvbE0vM1ZnSkNqaVRicWY1Y3dwRUV5RUt2Z3k4dXdSL2k1VlRV?=
 =?utf-8?B?dHJ3YmN2ZnBNbkIzZVpWWXREWXR2YjZIQmhSdk5WOWRweFVkc0FUMk14Tnc3?=
 =?utf-8?B?K2tGUjZhalVCclU0RWZCTllpWVBxVjVud3dVSklUVmFORjVVbkVnRllPQ3BD?=
 =?utf-8?B?cERPVDF3UkIwMUp2MEcySjRmY1pVNllPMWQvcWpVZXVWTnBVNjBOV1I5bm9T?=
 =?utf-8?B?TEI5Z0VwM1ZlWktYbjQ5U0RvN2F6RE1vakY5WnBGZGlRVllRQ1RwdklRZGFy?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c23153b9-1a17-4d1f-f65a-08dd6d0d23e0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 08:55:36.2711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ky11HQu9tcJ1AeDfMMIOas2Mk70toUxuH8nYnYBLVKSDaVCWtnCIHzsuu7laLIcy7dxw+STYxz2EhPHPfxOTIYHaW5UtDFA4xIaz09G9Jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4626
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

On Wed, Mar 26, 2025 at 11:39:28AM +0100, David Marchand wrote:
> Caught in OBS for Fedora Rawhide on aarch64:
> 
> [  198s] In file included from ../lib/acl/acl_run_neon.h:7,
> [  198s]                  from ../lib/acl/acl_run_neon.c:5:
> [  198s] In function ‘alloc_completion’,
> [  198s]     inlined from ‘acl_start_next_trie’ at
> 	../lib/acl/acl_run.h:140:24,
> [  198s]     inlined from ‘search_neon_4.isra’ at
> 	../lib/acl/acl_run_neon.h:239:20:
> [  198s] ../lib/acl/acl_run.h:93:25: error: ‘cmplt’ may be used
> 	uninitialized [-Werror=maybe-uninitialized]
> [  198s]    93 |                 if (p[n].count == 0) {
> [  198s]       |                     ~~~~^~~~~~
> [  198s] ../lib/acl/acl_run_neon.h: In function ‘search_neon_4.isra’:
> [  198s] ../lib/acl/acl_run_neon.h:230:27: note: ‘cmplt’ declared here
> [  198s]   230 |         struct completion cmplt[4];
> [  198s]       |                           ^~~~~
> 
> The code was resetting sequentially cmpl[].count at the exact index that
> later call to alloc_completion uses.
> While this code seems correct, GCC 15 does not understand this (probably
> when applying some optimisations).
> 
> Instead, reset cmpl[].count all at once in acl_set_flow, and cleanup the
> various vectorized implementations accordingly.
> 
> Bugzilla ID: 1678
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/acl/acl_run.h         | 5 +++++
>  lib/acl/acl_run_altivec.h | 8 ++------
>  lib/acl/acl_run_avx2.h    | 4 +---
>  lib/acl/acl_run_neon.h    | 8 ++------
>  lib/acl/acl_run_scalar.c  | 4 +---
>  lib/acl/acl_run_sse.h     | 8 ++------
>  6 files changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/lib/acl/acl_run.h b/lib/acl/acl_run.h
> index 7f092413cd..9fd3e60021 100644
> --- a/lib/acl/acl_run.h
> +++ b/lib/acl/acl_run.h
> @@ -176,6 +176,8 @@ acl_set_flow(struct acl_flow_data *flows, struct completion *cmplt,
>  	uint32_t cmplt_size, const uint8_t **data, uint32_t *results,
>  	uint32_t data_num, uint32_t categories, const uint64_t *trans)
>  {
> +	unsigned int i;
> +
>  	flows->num_packets = 0;
>  	flows->started = 0;
>  	flows->trie = 0;
> @@ -187,6 +189,9 @@ acl_set_flow(struct acl_flow_data *flows, struct completion *cmplt,
>  	flows->data = data;
>  	flows->results = results;
>  	flows->trans = trans;
> +
> +	for (i = 0; i < cmplt_size; i++)
> +		cmplt[i].count = 0;
>  }

Minor nit, but since we are using c11 standard, is it not better to declare
"i" inside the "for" statement. Keeps diffs simpler for adding/removing
code, I think.

For the rest of the code, I need to take a bit more time reviewing to be
sure I understand the change. I'll try and get to it later.

/Bruce

>  
>  typedef void (*resolve_priority_t)
> diff --git a/lib/acl/acl_run_altivec.h b/lib/acl/acl_run_altivec.h
> index 2d398ffded..d5ccdb94f0 100644
> --- a/lib/acl/acl_run_altivec.h
> +++ b/lib/acl/acl_run_altivec.h
> @@ -199,10 +199,8 @@ search_altivec_8(const struct rte_acl_ctx *ctx, const uint8_t **data,
>  	acl_set_flow(&flows, cmplt, RTE_DIM(cmplt), data, results,
>  		total_packets, categories, ctx->trans_table);
>  
> -	for (n = 0; n < MAX_SEARCHES_ALTIVEC8; n++) {
> -		cmplt[n].count = 0;
> +	for (n = 0; n < MAX_SEARCHES_ALTIVEC8; n++)
>  		index_array[n] = acl_start_next_trie(&flows, parms, n, ctx);
> -	}
>
<snip>
