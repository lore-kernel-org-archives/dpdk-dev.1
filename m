Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC17CA9EC0
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:45:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 305CC4027A;
	Sat, 10 Oct 2026 20:45:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id ADCD3400D7
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:45:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791657912; x=1823193912;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=DAEmnm8FYX3t4gAiG5yaTXgS1Kj6c52Fr1kGQefw0UA=;
 b=mqviJ0etew+F+bA+wU92G6T4xKFKgT5dpMTBtdTJcz1DWlf/vQuJWpoq
 hfqcDAYpNUGnxFgOH/0+aH024keKfGlMfyoklMipMWXgpZ2dVULjkoGMe
 Bczjx9/rQY4nTcCaR4g0ao66jWgTtlHT94d5NYxyfAEF2DEzj+qQHrNZq
 BjiDX5OwmpoUz7hG0UkzncpMXRq1RjPVGhEX40h+wzbWiiwx7NODBnawH
 noUMutre7hxAtXY0q6IGXbPeQ1bTfjnWXg1IgR41Zcm2J7T1acGQ7uy01
 AjB8T6V40MksVNYAmbaBGXqfPz2kAUPo1jVvJNF1QePfFZlJcWOJ89c6i A==;
X-CSE-ConnectionGUID: 6qkOmMY1Tz+JN/Ubu1NiSw==
X-CSE-MsgGUID: POeZpBbfSKypgl55kr14HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="419177"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="419177"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:45:11 -0700
X-CSE-ConnectionGUID: bRROxbMfQY+26+tRExTycg==
X-CSE-MsgGUID: db18Uwb8QwOER4Pt8LUJeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="655263"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:45:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:45:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:45:10 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8kwFR9VijUKWE45SHgarOnv9EsAsGEGLG1Ru+KdTyCtfCz8AxBEzDPvPu7z7UVO4+oQ1CjHEuV7Y4pbsd0kxMbMyFoTskJ4zDaAcPU97df3IZQnQebRA4qwNTY15fGAJHtfCPtiOpUlJjhzJB2i3S15+1XYHUwe5iqDRSXldF/B3ZhijCaiMXzwj+QSwUrH4k3HnTS1efIt8zocBuCRPZpNxLmFH79zWDmrbQTwALcSosPIL98ooXG+RcwKEJgMRu77/2Q01VnZp5g2Bf1MgnHpgua9NK+t1ikW2/oVFlxVqGn2gFDxw2oRQVSBcZO2dH6GcTrgg9wmPCnagywjrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBnrYgbiVv6TmUZfjjLjgBx2hwoKR42tv+cC1P1VvTA=;
 b=t12MkqjBFcLjOSYLVOoauvh665C+oFkL7TGYFPSE+epcdoFQCoLEXSX2fuRscGCj0JzyuGhO6dxILzgbCHWRrVXOcQemkY3GUMk2BcIZcT7kpYJcJfJvIYkS4Sec0kpkXNUJmZlqNikeLqipY1a9PeSfs89Wqcu0GgCQ0WssKwYcnG35TeY0AScF5qA5wirtL2kL5FapCWOMFnusyNxHnlWOGCr/jwtLQM6S8hpHCw36d/QGpomYPRbi0jpWwZPsUt9ktzPs3dRbpBr+xhjG1Fj8yEI+H+uGkw4xfYrl337UF542uOWhkscxX8XkmugYQdbwNziJiO+hhmr/3yVcRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sat, 10 Oct
 2026 18:45:08 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:45:08 +0000
Message-ID: <5228a3a1-7212-4240-92d7-02644865943a@intel.com>
Date: Sat, 10 Oct 2026 19:45:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/25] net/i40e: refactor FDIR engine infrastructure
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <231aa787615b7e595ed585e3d2569dbe307fe9c8.1791543155.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <231aa787615b7e595ed585e3d2569dbe307fe9c8.1791543155.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::18) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SA0PR11MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fad1d8a-b8d5-4435-25c7-08df26fe9bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: DsXJWCRb6rW1xtJU82XuUH4+aWjtUtR6n77DDU2iGIOBClUMRlYKnH5BemtX6HtaMN/HY4VZH+N0TWlxCQRZuHqTFRaeiRKt6N3XFtSnHXdaRmLWxLNYzuJqBNpz3xc6p4DOGGnvY221qoIjQtmMJtkQWjBgteAyp2o9yk3rUELgkhwg3P/0/QQh+Z+PJ1FvJ/+XgEPNs2CLXBrC04Z00AMX+jjY9IeZkgAwP9ekASsvMUubO5tY+H25zKFE9n94kbIfVDwkMSz/C8uU03bf/IKb9JPmYCgx7B+ucpE992VPmc4LkS2r6nN96h21lf19Kr4ImikSeIvB8p1RuZr8tIJmQveRySFpcwUWWfXAz4OFjPQl4p4J7OzVffTXJelPJ5V6Q/HzsQ9Hr+cKS3eYmL70TtkUpiKcUvkZ05xecm/WY57JSyUSeMbIzz7SbhDtW6NMH36d+o2I+CKnxEY9NwS9bKNvjbueL+9ul+TzPVza4pOpTx2+jxJa+6BcLPJ1m9n5vgK07R/Ay6a4J+VDLWl+4ei8Nj3xQAzuf8uzrcWnR6N3N/zRAVegkIiTqlp09wXddiqDDng8TFtmRO0mROIU6uEbFQHgKbQlWsPF3IJpTTh+mZx7TafaT9sV014RCmwp/uRCHyFlCZtjs35+LaQucds9XvAY73MlWsXrCf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elVIeHpTNE9oS3hYalhZRnRBSHVId3YxbzUxZm9zRTdsVnVieHpOaUFJNnNI?=
 =?utf-8?B?cE4rZEtPcFdWR3lTenlCUS9RbnVaSGtVRVZ4ZVNpQmxycE9PU2czQ3k0bFRC?=
 =?utf-8?B?dm5tajZYQ2UvNTVKcDQwRFVXaDBuY2Q1anpacDZDaFJnRDh3Y3hvVDFnUHQz?=
 =?utf-8?B?M0dxazFUaDBMYzhyOXAzRTRXMHBSRXJxN2p2RjVlbGU3WFBEU2IxQzhBcklW?=
 =?utf-8?B?djJ4T0l6S2ozMUZBdjNvNkJ3M1JZcWZOSm9RVVJpSUFsTjZOTmRRVE9LeHk5?=
 =?utf-8?B?bm9JdFJMQkNhU1Qra2wzekp0Wmg5WmR3c2NvYzc1SlpWdW4zbmF0dmY0TUNZ?=
 =?utf-8?B?UmFGcVU3dWl0N2QveDZKSXNVSnZZWmRUZ1oyWU9TSGg0bmVvbjIvUnhNZWdj?=
 =?utf-8?B?anc0aXJWTlRXalhCUGppV1NYek5iMXNsMFRVQTdzRGZ2UGUzRklGbk1tMnZP?=
 =?utf-8?B?OHhKcjFGVUNXdWdyL1h4Z3ZNNDhYMnJQVjNNeDNQNHoxL1RQQUszRCtOdW5Q?=
 =?utf-8?B?UEY0LzNwNURKSjJoRWVNQjBjbW9VQ2NIYXhadVpKVmlQU0xaUTZ1ZjNocmRy?=
 =?utf-8?B?M29RYWNvaldQVUxwNmNsdkV1cmtOSUNpc0hnc3RoQ1luZ0xZNjUrbmJtaCtY?=
 =?utf-8?B?SzY0RTRKWVVBcjBFdG55RElaSkJLcmhpeWxJQ0piYWl0SC8vSnpsMkltSm9F?=
 =?utf-8?B?NDk0NTE3T1BLaUp1TkNaenhZWFdNN3VRb2RsTVZSQU5yaUdnNG9DbFFiQm1Y?=
 =?utf-8?B?OUpyQmhpREI2VnpLMDVPT013cURpQmdueVdiQ3k2SjhJV29kaUlocm5Rd21q?=
 =?utf-8?B?Z1BsazRnZVY2OTNTOUlQNUphNy8xenZUb1Q3YlVPWThnWE1vdFFkakI1NXVY?=
 =?utf-8?B?UmV5T1NzRWM5UXdxWWpidlZSdXBWY2RxNUY1WTFjRFlKUXhEajNDdHRnM2Zm?=
 =?utf-8?B?TGx1bWE5dDc2OERiQkJxODYvOVYyTUQ3aG96SEpueGNGaldZeDJVSGhrbzBt?=
 =?utf-8?B?MDdsM2NBMHRRYXBpbHZ6UFpIMzJZVFNzZG4wYWwrWjNoeDlDVStiZWFLbDVh?=
 =?utf-8?B?T3lieW8vb1U1RjU5ZnpkS2RrNlEyNDJSYzBMaVBjVjFWTWIwM2VQbm9TbWlU?=
 =?utf-8?B?Q1k2SHBqSXorRVNtbUhPd1RCTXNRTnRFQkdYZVU2SFIwQzk5cmh1eEQxZUp1?=
 =?utf-8?B?MHJ6QkhlRzlvdDJJR2orK2E3Zy9LMFlmVFoxRFZnUFQxVEprK2JQS2J5dklp?=
 =?utf-8?B?bkcvQldkMjBtbUJFRjRSVWx5Yk9FODRXcmZIaVJPaEdaNDViTDFnYlJRd0E1?=
 =?utf-8?B?MHRNejFmVkJNNGFQTWZkMHJpK0FUOFVmVGZRMDJVUDNoSDFpSGhnbFJUM3or?=
 =?utf-8?B?b0YzNk01cUtkUldHWm5yNGtWYUwwNEtEMkg3SE1pSG16Q2hQYk5sc0N0R1Rs?=
 =?utf-8?B?S0FGNzZ3NnRGU3FadEtIdWVudzlCOHF2TE5wdmtLSm81ZDBxS3lXQzdJKzdK?=
 =?utf-8?B?dFBLWWRUOU9sNjdXQmxIQnNiM0ZIS2hOQXdjYmhqL2xRSWRPaXJHRDJvK0pi?=
 =?utf-8?B?cStNV2VML0VoaFozQ2dZa3RKUEJJUHRMWmpUemxWWldHaVI0cnlYcFN4WDdy?=
 =?utf-8?B?OWQweTduQnJEV2RVQlpoajZZSHhEUEFIT2RFc1pDazVuMDh6cFdtbkxsYlFJ?=
 =?utf-8?B?Uzd1eWYzOWVxSVlVNHpZMWs0SUtNVENnZUNEbHF3eVdZdDRVRW5IM3FGdDNa?=
 =?utf-8?B?VjgxbjVHcU11VHZFejViYU9OaGhGN3ozc1hGLzR6SmF6WUdtTVNwTE8wdEFl?=
 =?utf-8?B?WVdpb1FIeWZZYkI2MWlGMWhmQU0yTHVqRHdjZFdwZXJ1Wnp5VjFLa3dPOUFJ?=
 =?utf-8?B?TllrMmNHcHRGVk9NSkUyWjB6RGR0MHJubVo3SUJkRVkxTHdsYm82ZzYvbTB2?=
 =?utf-8?B?UXpjczd2ZHJrNjNqNlFJa1dCVENMSng3KzRFa3dpQWRsRldoRVRwWGZXSHZY?=
 =?utf-8?B?RXcyQm9rV3FiaHdjbldZeE05NTdzTzFxWXJySUY1ZUg2dWh4cjc2ekRQdGVC?=
 =?utf-8?B?TXZySEVycEpEc0FVU1JvamZCbUFRelhqWGUrMUN2K0ExMVA5clR2YjZLcDRM?=
 =?utf-8?B?bHcrU1dSdTgrdll3cXNyV3pWaC9VQyt0aGhrS1pMVXp1L21KTUlscjJrL2kr?=
 =?utf-8?B?akVMMmZXSTc5ajJEZWVWUFVkMTN0V1R3all5U240UEhpUHd3cTRYTUI1R3NJ?=
 =?utf-8?B?RkZ3aWdQVk5tT0FVMjdDc1pGcXNVRmRSbWF5ZFNZRzJkZ2tCenp6bHpvdVdS?=
 =?utf-8?B?QVVNMFJEME85ME1vY255M3pFUWVlUzZONU9qMjNPWEErZUZTSkJrWnIrN1E4?=
 =?utf-8?Q?+V3uBxNtc3JyMWSA=3D?=
X-Exchange-RoutingPolicyChecked: 5DX8vpeYTu+jKVcsDlXp6uGkaHam0NyVzH30OImTade5loW0zU/fyFVaed3z07V9t2yB3hQZSIV+fZ67vyNvvDSEupICJDR1c8uAjyl4dRL+jDkKKGRFMqZOpZiBhx62G+518NgkV+KNfDO7bDRSk6eGzev5hhViHONThbGxuoOA6vI+ya9e78A1XOVA+ywfs5YkbwrGBMGJLgBu8lYZPaAOj40sPV6EQT5ytWnLNzjzfSrCgkZy6EXDzAfQYhz+vJWJH2EhzDxFAzBDJD227cVOcqkU9OStfSKwjjtS1R7PdtT8+zA0Eq4mMCsoPNFChEZLfFzTwQMwaadl7lc5qg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fad1d8a-b8d5-4435-25c7-08df26fe9bb1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:45:08.7115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lm27YW9ivdMsH5aS+GCbo29uAQW2n/hVQFW1DJd2dARzJz4YG9zWLmoGaijd8ehXKNE72FZ+C0e32VvLYa2+R4x/HVh+cWHZyrmB0gaDrZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4527
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 10/9/2026 11:59 AM, Anatoly Burakov wrote:
> Currently, there are multiple problems with how i40e flow directory feature
> is implemented, both in terms of how it works with rte_flow, and how it
> integrates with the PMD-specific packet template API.
>
> For one, these two subsystems, while using shared infrastructure, do not
> really interact or cooperate, and are built on top of special cases in FDIR
> path. More specifically, the packet template code does not store its
> packet in the hash map, and has a different hashing scheme, yet it still
> registers itself in FDIR flow list, hash table, and hash map. This list
> is then used by `dev_start` to restore FDIR filters that user has
> inserted into the list. These filters, as written, cannot be reprogrammed
> that way because the information a filter restore function would need is
> lost on insert (the packet pointer is not added to the hash map).
>
> Another issue is that while rte_flow FDIR code does lazy FDIR init on first
> added flow, the packet template API does not, even though it too relies on
> the same hardware feature, nor does it ever do teardown on last FDIR flow.
>
> Yet another issue is how the "filter restore" code itself is implemented,
> namely that currently it simply does not work. When doing filter restore,
> the driver will walk every FDIR filter stored in the TAILQ, and attempt to
> program it. However, inside the program function, there is a deduplication
> check (to see if flow being installed is already present in the flow hash
> table), which fails because the flows we are programming come from the same
> list that is being checked for deduplication, which makes the entire filter
> restore a no-op.
>
> The FDIR filter programming code itself also has a number of readability
> problems as well as being otherwise hard to use - SW bookkeeping,
> validation, and flow programming is interspersed within the code, and it
> is difficult to reason about what happens when the code is called from
> this or that context.
>
> So, this refactor does the following:
>
> - Reorganize FDIR internals to track packet templates and rte_flow FDIR
>    flows separately
> - Refactor FDIR init/teardown to always happen on first/last rule, so that
>    whichever API happens to call FDIR first, the state is consistent
> - Rework the FDIR code to disentangle FDIR flow rule programming, Flex PIT
>    checks, SW bookkeeping, etc. from each other
> - Remove both the rte_flow FDIR TAILQ and the hash map (filter array)
>    structure, because they are redundant (information about the flow is
>    already stored in the rte_flow flow list, and hash_map structure only
>    stored pointers to data we also have in that same list)
> - Fix FDIR filter restore to replay all configuration correctly, as well as
>    re-init the FDIR queue enablement tracking
> - Rework the internal FDIR global state data structure to make a little
>    more sense by grouping things that belong together into structures
>
> Additionally, there was a delay mechanism at flow director rule program
> time, as when programming a rule we might not know if it's actually
> possible to install the rule, because space for the rules may come either
> from our own pool, or it may come from a pool that is shared with other
> VSI's. However, it only makes sense to wait on rule create (i.e. when it is
> programmed into the hardware for the first time), but not when we are
> replaying or removing these rules. So, adjust the waiting mechanism to only
> wait on FDIR rule creation.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>
-- 
Regards,
Vladimir

