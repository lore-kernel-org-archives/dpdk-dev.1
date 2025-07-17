Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A35C83F1B
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 08:33:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D15954014F;
	Thu, 17 Jul 2025 10:33:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 93709400EF;
 Thu, 17 Jul 2025 10:33:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752741185; x=1784277185;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=I2SiakWcJDY/xaYc7YZ+leIurazVUuEcrAgd38d/Iwc=;
 b=iHKB1E7gVUYwBILh/fL3kojpdOWhT5tSCUWBKJj3O8ISDG+kVU1+7G2H
 wz79N8yqOs2jvwg5Ztc2hb/6Jd9ECDXfc3sTxDDxFKWU82ME76YlDGO2L
 grA9jV1CfWjOnmYSQbeZMjsUbmbGvHRmQjCSZ8kFTDwvCO99gMiRAXnzY
 suHdls4+uzGgoTFgYqchD4uFk2eJL79BOVd8/9ksrrnK1NmA1yATAqRDb
 +rk0iiTwlAeASPoljXCntLEyeRjx8RiNatpAhf4ISsFvPpJAZkW29ukZt
 2iOgb+ki+FRFxzi2uhvHp5q2nyoNW7o/pXw+dWfBNNfiKR4yWnsCqk0g6 g==;
X-CSE-ConnectionGUID: /fkECdUWSB+eYIWyc8rRGw==
X-CSE-MsgGUID: UkTeDOfNTeyU9ZbN93vyRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55096619"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="55096619"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 01:33:03 -0700
X-CSE-ConnectionGUID: k1cM9HkESQCCLQ0qVlolHQ==
X-CSE-MsgGUID: tmTYi4qFSB+qahSfuwO3Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="157543963"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 01:33:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 01:33:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 01:33:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.46)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Jul 2025 01:33:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfBR2xo4SVc5DmIHZAtC74gE81MaV40kr118F67D7FD3Madj/n41LuXMeUux4syzQYiEKGlXwaCFxIguOulWdWZKloY+oU8ha1rdWOQ2y1THGKdOLJ7XjxuLmEOhCXFkujdsFva+eAiT99E5Wsyj3rj2mgtFhAKn9E248ZCnHClXrbN3qDbt4PmN9eXisq2HiE8ofzHtCwFBT7vm3rxxPtmbiJbHF+qtvNtQhhR/V9VyRlwP9so9cJQwM8UvSxSD6t7MIsbIfoPp4clR6XP957U86hHvGx6b4eGufG4uD+B1MvrZbRrIUsavoImxkoHouVrS7wp6FYs+i2R7hPcsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0UJqYaM9Bq0nanpj5eZVOgBImCo0CQKg//k7BKAhmU=;
 b=NvCr6+gKvrkrzLsaDhlBSzfteboJ7I4Q5oXJ19P5OC5xGvL3q2Yi5GzsEbM4Kd6pQ6lPXCiOTy9l7WUc61hzDzD05sp5uYvlkUaYyaUAN8JroNTryC0aHqZT6C0KlVO9oKDCkdcdQx3TPTFUSHuXdy6zHARKDKKKRXkfSVImhTpjPE/z3wFrTseAAAGRz5fbBpmKZeFzLCLx+NV8aWZu8wkawKsJEY23Q47z1Pvz7JGtz/iiMraWmd7lBhmpzqI6wixa7tndxpXcKuhgIrZctRbgg+gMr1jBo4OIdApGTYF4GBBl4eTLYHgk7IirHGLf+Myj8mTnvDMBV6PoiDvwGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6407.namprd11.prod.outlook.com (2603:10b6:8:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 08:32:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 08:32:59 +0000
Date: Thu, 17 Jul 2025 09:32:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix assumption about tag placement order
Message-ID: <aHi1Nnvl4_ezD74S@bricha3-mobl1.ger.corp.intel.com>
References: <20250716173922.688476-1-bruce.richardson@intel.com>
 <CAJFAV8waeOp1euderd+t2VTfTfree-rratig_qq+eCGnJgTq5w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8waeOp1euderd+t2VTfTfree-rratig_qq+eCGnJgTq5w@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0037.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 94dedfcb-70ed-4048-f890-08ddc50c89b1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1YvVjVpNm5MUjE2RmZNUjQ2YjJSSVJtNm50MGxWNDhBc3FUZEFNTi9wRFN5?=
 =?utf-8?B?cWpHa0MxM1l2dWFxS3E5ZGRDQXFJZ0o1S0NtUUJuWWJKVk5CTk5tV2ordDNq?=
 =?utf-8?B?bTIrRy94RDF3NjFPZGxpYWFwY2ludy9IQ1BaZXFzWWlEZkxQZ0FBazlXbk4z?=
 =?utf-8?B?NXJJNFZwdWhQYUZHMXk1SEtRbUh2RDZ3SVpkYytoS3RWZ3gyRk5oWGVTTG5B?=
 =?utf-8?B?WXZqV0FQMW11UzNtd2lRVk5qMkdiR0xYVG1hRG5DQUtkdUErbWZHOHpORlV2?=
 =?utf-8?B?NWIzR3hodnRxYXhDUmpTdDFYNFd0bG00TjdCNlNRNzhpaGQrd2s4Z1ZVK0ll?=
 =?utf-8?B?NFoyMUJGdVJZaXJ2Rm5rdzl2VVJuL01uR1pjcFdjRE5YUDY4MGFOdzkvVmUw?=
 =?utf-8?B?ejYvSU1tdWVrMWNLZkdzcFFNY2xKVFJhKzZ0MzNzd2ZkVnMyN3MxQU1TZzJq?=
 =?utf-8?B?RGVWQkxsVlBZK0lqNDRDWEJVL2dKb3FrK0czVTNnczA4T0t0YTY4c1I5SS9C?=
 =?utf-8?B?ajZicE1GNFI2QWl3WjhHQnBhMXFGbzdHMGpkbWJVeXBrWVVHSmlNNGI1L2JQ?=
 =?utf-8?B?OHNrTzZNT3F1cENWWnN6bTdJUnRFbW9UUTFraExqRmZWWlFnK25vZENqUVhB?=
 =?utf-8?B?TDhWcnI0WlFGSEhZYmhJcWhka2htQ3d6aGk1eTB0TWtxc2lmZ0k3dnZzalVQ?=
 =?utf-8?B?ZFMzVWVSRjFGTU9iKzZRTVFLdzdPZTdsWW1KSENHUk1Sb2FCNzlzYWx1VHBy?=
 =?utf-8?B?dXV1R2g5VWtZQ01JRHo5VnRKVCticDVCdkZaTjgxeURXVThoQld2Zk9kd1ZK?=
 =?utf-8?B?Y1VtUy9XajQ4bXBwTUNzT2hIWnA2U1Ayc29iNm42WjdOWTNSSmoxSVBGUVRM?=
 =?utf-8?B?Q01VK3RpWlhrNlJpUXpHSFVNcEQ4ZTJhRS8wMFd0RUxCYXBNUlBmcnhrTWNV?=
 =?utf-8?B?Um56STh5enV5K3UxU2ZWU0ZxeWlvdFFnRFltcEYvRU94Yk9IbVIvQzFjekli?=
 =?utf-8?B?ZXdWOVB1QzBTZzNYcGNJSXd4WmdKQmtQUnNJbGxnTC9UUGc4RGZRVjlzakt6?=
 =?utf-8?B?VEV1eXF1dC91a0QvTnRBWWdKNUozQlNhblI2bWlTVkpjc2w4S2tUSi9FR2FO?=
 =?utf-8?B?amRDV3hONStnTHhwREIzOERnQlEySktYcXRpZXgzejFNZ3U0OE1rTGVNQlZE?=
 =?utf-8?B?Z1dqSEZsZjFTZkZVTHhNTWVwMFZQZzlOVitHRE1MWFJPN2o0Nk1CbVA5clJU?=
 =?utf-8?B?bkk2c0tyTWpqaWMvalJmRTh3SGhSTlJLaXJVWVFZc0ZwVG1SVlNKYWpOTUlO?=
 =?utf-8?B?TmhvQzhyQ0pRWHVya1JFOXoxalJrZGZHam8yazVQQmpFMzNlbEFLTFZYS0FU?=
 =?utf-8?B?SjRhY3hzMmExdno0SWNLZkZzYXFkaHRUZG5PZkd6UGZCaldPSFlJb3FEUmd1?=
 =?utf-8?B?N0o3aHJscGRUcTdjT21GOVpuc3RKNzhiQXMzVlJYNUNaeHZJR0h2OEM3Tlpz?=
 =?utf-8?B?M3VTT3AwTDFkVG9tdUZWVUZnSzRDbUFnUzJHU1A4ZlV1aWxyc1F0eUpsaEU5?=
 =?utf-8?B?NEh0SDNYWHE3UVpmZXBoRG9mVitidzk4ZnloNndOYWFTbXRsZlV3ZGxBdkw2?=
 =?utf-8?B?TWtjZFlhVzFNanRZWlJqa2dZTmZpMU9HUG04WnJzaE5MaWM4K2JDRDNyK3Jo?=
 =?utf-8?B?Q2lidC91RWhScm5aSlQ1QUgrVm5SQmozSkNkdjl5dzRYaWsyZStkY2Jvb293?=
 =?utf-8?B?MEJxYWtETEx5RzNOS3Q0eXBHR3grcEd2M1Y2YXMzMS9xSWl3dUZSQU1IYndI?=
 =?utf-8?B?RTdPZ2dXUnhlaGFpbDFuWTdqNklsVWFDYlpROVl3ZXpKMmpuc0t5UU80WnBn?=
 =?utf-8?B?Sk54elRSUTlsbm1wZ2thMG1ZUVZyQkI2eWptWWNkTWFBTFJPb3ZKck1wNGJh?=
 =?utf-8?Q?i7QptPo3vok=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmdlMnlNd09FcHZiLzRCRnowcE04OEVBMExjSm5QT3J4V0lBVytCN2lzTXFQ?=
 =?utf-8?B?RlBrTXIzWHhLZzltU0F2RzJCUnJKdlZQQllDNTI3WGlVY0ZYOHZuNjNLekQ4?=
 =?utf-8?B?NFVQVTNGeXYweml4ODRrcHE0MEUxM2ZxNlhVbkNSS1ArTnNtd3UreVpRMFNi?=
 =?utf-8?B?MkpVQmt3cWlLQ054TGtPMWZFWEJpWHlnKzNkTS83VXgvWFFZeXdtNGlSWUxk?=
 =?utf-8?B?K0JhamZFVElOWk8wcmE5Q0lPY29KVUdPR2JITlgwSVJWeldQNko1UzZhVWw4?=
 =?utf-8?B?bGQ2QmtFQVJoTEN4S0t3cHdzZFR4eUZWQ2d4bldpbVFHT2RPZk42d2NhRXJN?=
 =?utf-8?B?QWhlenBRVEFscmlpa3c4Vk5IWVRXa1FaczZWcDVQcGVBZWdNb1l3b0t5dGFW?=
 =?utf-8?B?TS85TEhDajFBOTgvMGhKNDBsSzQ3ZUpLcE9OeGV0K1BCeUJGN1B0SDBnZXBw?=
 =?utf-8?B?dUNaekRHVkxJbUNEK0h0K2FFQW9xQkFXbDNnbGdrMm03Y2pMSVFEbkl3L0lU?=
 =?utf-8?B?VWwwL1AvcjZZT29sTzc3UGE3ZXd3MGNDUlJzVDNsZmx3QkdNNHdWd0NJSnht?=
 =?utf-8?B?dW1tN2VtZWFYa2tOSGdTZndGOTVwdWxoVStlKzdubTdmT0w5MStzcDJRUFNy?=
 =?utf-8?B?Y2pWYzBUTSt1K0ZGaGJoajNIUHNETXJqdGhKYWV5aW9iZXQ0bFRvZWoweW5o?=
 =?utf-8?B?bUljZGJwWE15VjdENVcxL2NSMitpaWhaeXBnRmh0TjdzVzZiZmVwLzZ5M2o0?=
 =?utf-8?B?dEZOakRBbnN5QVo1aGF1TlJRTDlJekF6T0svQ0l5TXRmV0hOM1RJSXB2N0d6?=
 =?utf-8?B?MGt0Z242SmFUL2FYVEtLS0dNWU91SGo5RlViZ3ZZVFlUOEU5d0lSVXU5aEZT?=
 =?utf-8?B?bkNkNk1naGMwOUQvQ0Q3M1k1cUJmZXJuOGs0UDVUdm9OeGJDaUQ5NnJDM2xY?=
 =?utf-8?B?RkkxUWU0T2Z4djMvY2hiWS9IVEtjOVNUc3VSa2o4dUh5NzRPaHhRcEVkODB4?=
 =?utf-8?B?OHFoTExtNTRyOVgxbmY2RHJpYlYzVHpNSkV0L012VURzTlhjZlpoNU12Snpo?=
 =?utf-8?B?ejd4VThMRUJiT1ErMlZuak01ZmZhOVhzM084R2U2UjVPNkFnRVhuWUZmalln?=
 =?utf-8?B?V3dmR3RmMXFkUmRjUGFndDF1aGg4QzJteS9POTE4cDVGMUJ5RGJWVFB6aW95?=
 =?utf-8?B?N0hyQnNNQ1ZTdExZak01bFQvVWxiTC9rZEFkcHdwOXdDUnZxZXJXYm93aUlK?=
 =?utf-8?B?dFZrcW02Y1pXUTlDTDlxbjVGbkhSZ3I4RVVKWGZ4ZjJ6MFIralgrdk1HWHlE?=
 =?utf-8?B?U21XM0pNRFA0azFhQWNZbngvUkVlQzZIWmRyNWkvZHp5QkFtb3F1aFVHTVFZ?=
 =?utf-8?B?RlY0SWsydE9DWFJ1KzdSZnM1dzFTK1lTekNpY0luSUJ3WTROdHBlZXB6OWRG?=
 =?utf-8?B?WlBOaWgvYlhTNEFRamIxUklwQUhLcldqVW0rOHF2ZVROdE9pOFFpYkZnbEdx?=
 =?utf-8?B?aGQvY2JLTG5VcmR5Slh1bk9CaWZJQkNmVllPUllFRzhYM25YekFxUEJrNHQ0?=
 =?utf-8?B?WVZhamhieGZXRy90VjFLcmNkR3hqMXJQZmJTRkRFTzNOU2lMbGJ3RjJsZ1Ru?=
 =?utf-8?B?Y2R4ckNTM0RrV2ZheXpTYUYxWnRhZ1hiR2drUXc5OWNSWmNFVG0weUhZMjNm?=
 =?utf-8?B?dk5xQlhjZVQ4M3FjdTRGajliSkFqQVdlSlZYeXUvL0JkQnlqZXgxZ1BaNWkr?=
 =?utf-8?B?STNIVW1jbTVaRUc4Q1dyR1V6QUVhc2w5VFBVT2xTWTByekVGdFJmQ0o4eGVx?=
 =?utf-8?B?RjF2NnVpT0JrZTRIeTRjZTFUdlM5ZlJJZHFnM2NNSDNWRnpwV3hpQnJPTVpO?=
 =?utf-8?B?TEZCV2NOSVJ5NGhtSmJFVFpWU3NiV2l6bTd2Zm45Y0tsWEg5WTBOdzZCc3pk?=
 =?utf-8?B?YTVnRVFOaVc5WkorZ3IyMWNKUkRNZ0JnTGRVSk9zZ0JCMll4Ykl5cU9GMk9W?=
 =?utf-8?B?UHRocktKVmxselJqUENKNGJvUzBUdVhQSVNBTllJcjc3MzZ1TDhKeFJtK2Vo?=
 =?utf-8?B?eTJMMDBVeVhYNUpqYjh6RDVBUEY4TGZ6TjlHU3lYeHBqSnJCdi90ZUJBaS9r?=
 =?utf-8?B?MEtQMDRoNDdIblFZUHl1Y0J3M3pGVnZ4NTBvbzhreEZXZWJ1T2FFZVF5MDMx?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dedfcb-70ed-4048-f890-08ddc50c89b1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 08:32:59.8687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPjGJs/zYr0PzQs8c8mK/1CKMHrF8j1DO150fA2DHCSVmpq7akDkMq9EkHwl6xuAYEng6cN9Ol2EeKph8T58w2teYlL/Pel50wUdhfdUBNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6407
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

On Thu, Jul 17, 2025 at 10:19:24AM +0200, David Marchand wrote:
> On Wed, Jul 16, 2025 at 7:39 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > The specific placement of outer/inner VLAN tags in E810 and related NICs
> > is configurable. Therefore, remove the assumption that if the L2Tag2
> > field is filled in, that the L2Tag1 must also be. Instead, check the
> > existing mbuf VLAN flags, and move tags and set flags as appropriate.
> > This fixes an issue where, with QinQ packets with different Tag ethtypes
> > (0x88a8 vs 0x8100), we get an mbuf reporting two valid tags, but only
> > having had one tag stripped.
> >
> > Fixes: e0dcf94a0d7f ("net/ice: support VLAN ops")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> The ice code seems copy/pasted from i40e.
> So I guess i40e is affected as well.
> 

I'll investigate more. These fixes I intend for 25.11 anyway, since I'd
rather not risk them late in the 25.07 release cycle.

/Bruce
