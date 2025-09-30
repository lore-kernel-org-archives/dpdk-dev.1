Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF94CCA468
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 13:28:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6ECE0402A2;
	Tue, 30 Sep 2025 15:28:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id D2B6E4025F
 for <dev@dpdk.org>; Tue, 30 Sep 2025 15:28:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759238892; x=1790774892;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=ar5S1J6b3DqJnArDFJb5s8W5WwoIgu4SatgyPQW9zbU=;
 b=RyIx89j37xNWwUsv4S9oV4DDjqq+tu+7UzDLWzr3/ElMISDKcM6kc4BS
 TudKJlU/vdXgf2cTPic4HrgBaW5B9SO5SmFoXbu2WhLTkgDNWxZfc/ZbA
 Ze9K3Zs4DaDklffd01xuqJm1MUSPB6DYLYGvlwa3+9H9hCNElayvpOmHV
 ucfnW1qfyx2oK48UnOJrM1SwyncQUDNrDDMJHYdWrs2zxzP4axOJQ2iqd
 inb+pGnNMa+HfsxF9P6RwSYnuo6l9N5fKVyKqdjRHx2Rc427Vae7naFW1
 BB8DwJihjhMXbRvqGBfKf4kzzxVqeT3de3D0lCoZwjXx2pRkgTKwWxSVO g==;
X-CSE-ConnectionGUID: jhCwy2FrRSWPi+6m8a+9Cg==
X-CSE-MsgGUID: /MdYYVgXS3KAG8l8VZXLVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="65352917"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="65352917"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 06:28:10 -0700
X-CSE-ConnectionGUID: LINWXuK9TvyUgAw0yLN9wQ==
X-CSE-MsgGUID: GBtmbYOwRjK5hr4d9I5Kgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="177645286"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 06:28:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 06:28:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 06:28:10 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 06:28:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCpLYEAO5u0/Ua1LPneQsuFPlDnvJaUzcFVl/IrT+za44e1vbOoQegcDLTjrhPCDsYFmiWvcuot/rq0q4vJinGfAOvB2z9pOpINT4KLM1X/WTpMyj5vmJxeOmIUzt4IFrq7k2t/f5t0pwkiSV2vLz1u8/2ujyRpjut3xecUIipz7j/blhWbIQjbcFzd70bBHfTQ+H2ogf5TC5e2dfNItx6mC/VKXGwxYIBuzoj2AlGuX8F0cRGdTpEhq3s6etpS9jEVSDwhRJhX70un3oLnkqZ9PMp9tdymc68AhLvAilnbB2ZlYLH7tddlp/jD3x3kLo4y98n+mSaqlnM7675EMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cy7faRH6Xjvsym4IUaG/8Q6QZyW7bCgJQVkLOm9wq8c=;
 b=IvIq2uHpAZulLLkoglCj8GM/rQ/9sIcY2O8/+I2VmrrWglGreEKkZ890EYFtSwFPwXFzuv48EbS4F0CJs+qIBZglXcWJ7GP1lTTJ2VGYgHuWKidcW9wdrF5Fnq7P7/K8eQ54484Ft8bjafGMx0KJ6ZSSmDn1K/y5ip2rELG5ULBq0v5aiQCs/Jl4YyzxeJutFHYaLCCXOGYr22U9d0EfZBs3qyGIM8DqfmBHl1FitoX0624M++Q7sRwjHRnKAH6hJCzXvGCj/TgxQwUj25zqxHaL7z5BQgrY3pKFVOeucfM+YeB3e0SaLE1JdXhGmTEmHfQMsq9d0dhFl72sKR93dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM4PR11MB6287.namprd11.prod.outlook.com (2603:10b6:8:a6::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Tue, 30 Sep 2025 13:28:08 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9160.017; Tue, 30 Sep 2025
 13:28:08 +0000
Message-ID: <92e70131-828d-4422-ba9b-24ab1859d8b7@intel.com>
Date: Tue, 30 Sep 2025 15:28:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] net/idpf: enable AVX2 for split queue Rx
To: Shaiq Wani <shaiq.wani@intel.com>, <dev@dpdk.org>,
 <bruce.richardson@intel.com>, <aman.deep.singh@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com/>
 <20250930090709.2521114-1-shaiq.wani@intel.com>
 <20250930090709.2521114-2-shaiq.wani@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250930090709.2521114-2-shaiq.wani@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0131.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::16) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM4PR11MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: 68325b3d-e75b-4f70-1708-08de002531c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkNkcEgyanZpZStSdFUyYnlxdWxpWFBkTmtKL2dPV2crWDYveHQwNThCcW9O?=
 =?utf-8?B?bzRtaDMzT3RKY2FrUWtMdGdIUWZDMEZrNjUvVzZmcnU2cFZOQUpGQnBKdkY3?=
 =?utf-8?B?WlpLOVR3ZGxiN2FjY2Y2aVBabGRicXZwTE9xWmtjYmJicnV4c0s0NzZXTitX?=
 =?utf-8?B?cG16eTJlMU9WTXg3NFBZa0M4ZFVaak8vZCs4M3h3TUNnK050Um9aVzlGWXRX?=
 =?utf-8?B?NHhXb2c3WERySkcycy9Vekh0YWpsZEFvbmk2Sk5YeStzRTZEUVZSVitxSFBi?=
 =?utf-8?B?TUx2TjM2eHRMMWVRSTBFQ21mUWtBYzBMT1lJOXM5NUk4ZlNBbTBlNkQvRyt0?=
 =?utf-8?B?YlN1aUFBNTYzU1R4Y2lGTmh2eE9JVVFybUZWK3daTTVtL0JHdXFFOUtlWjA4?=
 =?utf-8?B?Rk5Hb1dKRWltaDZFTEpiSjNGczhzZGhBaGpNdFlMb0l6bGVFaWJZNHFia2Ju?=
 =?utf-8?B?Z3pTZ2ZkNk9xQVI5ZVhWcnJqb2E1ZTZjd0lPbFdmbzBQaHN5b3BNRGxLSU9u?=
 =?utf-8?B?YnZ5akFmcnQ1M2M4NDRCQndFaTlCa2xwcnZwZ3I2ZHBuQk5ldFB6dVk1NEpO?=
 =?utf-8?B?a1p2TE41T0Zlb1ovVCtsd3MwanVoUXR2QWp0VlNtSHFFb3NTdTJsK0g0a1BN?=
 =?utf-8?B?VjFwaXFCdi9SQi9qcUcyaVA4UDRTVlE0Z1N4T1dXc2s0TFRGL0pPM0FSRFZ5?=
 =?utf-8?B?SHRTeksxaDVoODFqWTJMaDUwLzlVV1QrSXpxS25CWGRpZkZvekVmWk91Nktn?=
 =?utf-8?B?SXVOb1hFR01BVGNybHdqdW5ybzNwVGUvbnl1UmFyNG82dnkxV3FjU0dJejYz?=
 =?utf-8?B?ZzNFRCtwZ3B1QVZRTGg3QkprLzJONnJCOXg1V3BPNDNTY01YdmMyODBockxP?=
 =?utf-8?B?TnFHSUdITWJCRHFSNUVxNkREV09LOHAwZEg0QlBoM2phWkd1M3gwdEpWRk5L?=
 =?utf-8?B?b2kzUHpUc2tNakNjNWFVQXBrWHJTQzBIL3pJWE5hUUZyT1dxQmR1MzVZd0o1?=
 =?utf-8?B?c1lOWm81Q1ZsN0pXbFg0MFNFTXlFQmFMNnpNbmd3Z3gxOVA3T2VjbEFBMXd3?=
 =?utf-8?B?RnlYQVJ2b1paL2lCcW9BNTJJeE1VUkVrM01RZGg2R1FhKy9MeS9ralo5ZCtL?=
 =?utf-8?B?YWhoQVFIamJUM2hDaUprZHB6dmJ1MUJRMUZUTWNJQTJYenAxU2E4K3RPRmty?=
 =?utf-8?B?M1U0d2dZd0tpUWlqMUk2bWs3MUtQRkJUWEhXditjSjB2S3VvanJEb1ZRTTlW?=
 =?utf-8?B?UnBGMEhlanhRUWlCcXl2dHV3RHF0aE9BSGk0aGRDZGFkSEUyK2wzd3pYQ1I3?=
 =?utf-8?B?Sk9qMUdnZE1Ja3dlcWUxbGtCazJLTjhHcFk0TzlEUVJrdFh6eFp0VUxoU3dy?=
 =?utf-8?B?K3NWNEIyTlVISjVXZGY2VktCWkdhVDlVaXBIcWVVMTUweWNyVmcrQmdZbmx2?=
 =?utf-8?B?T2x4VUhiYTcxam9sSjBmZGh1dm9pRGdRWElDN2ZvT2JsVUFFTVNPdk53QXdE?=
 =?utf-8?B?bUlvUithVHRkZ1NTTEhjSVViQkRUeGtYREM0ZUJsKzVzMVJFRzVRQUJmOEVu?=
 =?utf-8?B?eXd2QWh0SktlNEFhL0VwUGVRL1RHQ3U4WGQ3am9KMTR0Wit6ZlUyREh3d3JF?=
 =?utf-8?B?aTFVbENWSkNWK1F3R2E5a1lFMU5IeUh6dDBoVGVhQi9xb3R0L3NPTEhKMXIz?=
 =?utf-8?B?ZCtQaUxvL3J1R2lvNWhJaCtVZUo0Zm5LTjNBeE1wTHh2UFhLQld2cjNRUVJB?=
 =?utf-8?B?eVlzOVo4Rm9xNHZvcmlucHc3QU11T0pLbTlWdVVzT21tTHJzaFd3N0c1RUVV?=
 =?utf-8?B?Zk5QWm9Bd2RjU1R0bDMxa21QTmtJSDBSdFZUeU1ObE4xNVJqbGwyb0NCdGVY?=
 =?utf-8?B?aFY1RmNsa09naG1GTG9kaUZuM3R0M2RRSFlJeFhyTXF4cHZNSllUNHhkV0tZ?=
 =?utf-8?Q?0D2NPgpBmSmusjbCrLaoqd7ibZi3gBZL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3RqV21SU24zWE9TMzA0d0phUlFTK091S1prSnU5NmR1S0grb3hTYURLbTJt?=
 =?utf-8?B?Smt0c0h2WUtiNlVoS0RCcGdPUGRYdGY5ZVpQZVZMVDFTQ045cmRYTGp1d1dL?=
 =?utf-8?B?TGF4SWRObHk5elNhaWd0REREdVE5T1hPUEVLWFRVNGZhd0ZKaHM0SzlwQ0ow?=
 =?utf-8?B?REk4NXJ4dHFPc2d6aEpPaUtIVERWUm5oa012RHFURVo5eDNYOFZqL0thNlVE?=
 =?utf-8?B?bjdIS0pwMWtsNXI4VE9lanFML3dEZzNxUnBBVEpSK1F4Vkw4b3Z5K2VWRlVu?=
 =?utf-8?B?REVGT3h3alVPOU8rSWtOWGwxeEtLZldyUTZ1SHVsWFJ0RWJYcjl6ZktXRGRv?=
 =?utf-8?B?eEY1ckdFWTJSem9nbmhxeExnakxTZmZvOVUrK1BVMXFIZnRLWldwUnVzYzBr?=
 =?utf-8?B?TGNNZG05RlRRdjVKZHRlZmswMmFhblJIa1JPaERtWTVNak5LQXE5aDNxdTQw?=
 =?utf-8?B?SG5qL1dDQzU5MndvUFl0cFZlVnEvSnk3d041UGZxVnV4Wk5UM0t4U0pxOGxN?=
 =?utf-8?B?dENKYlBzcnIwRG9QcGVQcGh3YnRKOCtWT0MyYmllVUg1RFFKMjVVeWR0R2xR?=
 =?utf-8?B?b21ZV09YS1F2Mkh0WnZKZTgzSUhuRzhYUXZ0NWRma21uK05KT1BmUG54NTVl?=
 =?utf-8?B?QVJqQ2pudHZKaWdFQ2p1ekhwK1hYMXczcFJJNG1YeWIwWjlzS2JXNHNDMmNh?=
 =?utf-8?B?eTA0TXdjK0FiQ0xKRFR0ekp2NkNYdFNHQkx2bGFNbTN6ZzhqcXRTTDN0RUVZ?=
 =?utf-8?B?eFk5MURjelR5dng5YytxeUNGaE12REpFUEQ2eUpRc1FmcjJlNUFIbFIzSStD?=
 =?utf-8?B?ZXJhVm90SXlPUExqazRpYnpROFJreTYwNjdzM1lROTlSb05hUDJOc0JSV0F1?=
 =?utf-8?B?QlRpbExUM3lPMiswbldGbUcyajdSZ2xhYU85ZkdBd0ZPU05YZ0NQU0ExbnVX?=
 =?utf-8?B?Yko0KzVVd1FqcjlwcmY2WG1acFRiWWRMbVFWdkRLczFOOUU1ODk4cVhkd3RP?=
 =?utf-8?B?MXlqYlR4Wi9va1BYNU4rUWZnYWNRbUlGZVBqWVZCUGxhR0MxZXlQc0lsODQz?=
 =?utf-8?B?UXR2czArcElvbGdjWTY0QTQzb3NuV2VXblRjUGFuUldOa1o1a1F6M0pTc2o1?=
 =?utf-8?B?UFZGd1haa3IxcHJLTzBDTlZEeDQySjlzUVBHaHZEQmRwRGUxTks3dVUzYkV2?=
 =?utf-8?B?UHZFMWRyZjc1UDhEMXFtcEFOZzZBZmZVVytUaU5SNWswZ1Y3QU1ZM0Npd3pO?=
 =?utf-8?B?RDE2SkhoSlJJRzh3TW45MXJvVWdpdFFCRkg4dnpiYW50NDlSS2x1RWNxN3Fh?=
 =?utf-8?B?QldyWjZKLzBGa0lhejdDYVN1dDNYc3MySnJWekFVbTRlclhvTUZTK3RjdGVV?=
 =?utf-8?B?aGMvbmJkbjFrN0dPMTZmNkhGMFRNb0hnMUpKeFhhTHlHbTZ6SmFabW1aZ0NG?=
 =?utf-8?B?OTE5SFAwTElibDV1R1hDeUthb001bjBCMC9uU0RBZHFVa1FwQlFoanhZaHBR?=
 =?utf-8?B?Q244b0l3d0xPUnVJak1qZzJ0UDVvSFVLTkpvc0FsUVlFZWd3MVJ4MGN0ZTdC?=
 =?utf-8?B?RThJQUdhWUxVL3BEWEYxV1JwSmhuZ1pDanc0Yzg4eDVxMzUzYkFscDM5MFpQ?=
 =?utf-8?B?R2tOWWNFeFhUMSs5UFQ1RDdmT3dsNSs4RGhDRlFYaS9TbXdsMzBxTUxBZ3M1?=
 =?utf-8?B?THFGMUY5VVNJUWo2OEsvY1h5czVyUUNRb0dGdW9oNTZEQW1KL0Jxem9FUVBW?=
 =?utf-8?B?dlNMUTlJajNXU1pSWWlSTWk3bmRaVHEvY2M0YVNJNlBOYmNWY2V3RUFSR0pX?=
 =?utf-8?B?L2luUkdUWHZzRHlHa0x0QklWeXRCd1JUeU9wQWxCQjV1RkdlaDRKWDRlWHhM?=
 =?utf-8?B?ZHJZWjMyL29GeXdNUWFGWUdYVUFYZjYwNGx1bmFLRWU0YUlMdUVYbWFoNzRO?=
 =?utf-8?B?T0hmSXhNMWM0NGNlVnpaZ1FyRFdGY0ZKNEVXcVB6MFRPQjBNNlQvSmlTSnFk?=
 =?utf-8?B?TTJQK1E1WUQ4YllSblh0OGVaZDkybytBdW5MajcvUkw1bXNVNGRqOWE4NWdW?=
 =?utf-8?B?R01qZW1PaDI1ZURHS2ljeFdXdFo4QlYvWkJZZXJqZ2lhNVU3ejNqSUFWRUlN?=
 =?utf-8?B?dU1STWFleE5GNGUzMnJsOENJaXJzN2pyYURiSWcwR3Q3TDVGNXI1dG44VjMr?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68325b3d-e75b-4f70-1708-08de002531c5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 13:28:08.4901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ULD9oaVVIZjzzxf2cbiEkhJtr7a277T27S5EBm9Iec48QsQXguDEVb64/I+mVqZeTkojw2AxKUoVwjQo3hDv8ESXY42kgFt9uva8XEmjvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6287
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

On 9/30/2025 11:07 AM, Shaiq Wani wrote:
> In case some CPUs don't support AVX512. Enable AVX2 for them to
> get better per-core performance.
> 
> In the single queue model, the same descriptor queue is used by SW
> to post descriptors to the device and used by device to report completed
> descriptors to SW. While as the split queue model separates them into
> different queues for parallel processing and improved performance.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---

Hi Shaiq,

<snip>
> +
> +	/* Shuffle mask: picks fields from each 16-byte descriptor pair into the
> +	 * layout that will be merged into mbuf->rearm_data candidates.
> +	 */
> +	const __m256i shuf = _mm256_set_epi8(
> +		/* high 128 bits (desc 3 then desc 2 lanes) */
> +		(char)0xFF, (char)0xFF, (char)0xFF, (char)0xFF, 11, 10, 5, 4,
> +		(char)0xFF, (char)0xFF, 5, 4, (char)0xFF, (char)0xFF, (char)0xFF, (char)0xFF,
> +		/* low 128 bits (desc 1 then desc 0 lanes) */
> +		(char)0xFF, (char)0xFF, (char)0xFF, (char)0xFF, 11, 10, 5, 4,
> +		(char)0xFF, (char)0xFF, 5, 4, (char)0xFF, (char)0xFF, (char)0xFF, (char)0xFF
> +	);
> +
> +	/* mask that clears the high 16 bits of packet length word */
> +	const __m256i len_mask = _mm256_set_epi32(
> +		0xffffffff, 0xffffffff, 0xffff3fff, 0xffffffff,
> +		0xffffffff, 0xffffffff, 0xffff3fff, 0xffffffff
> +	);
> +
> +	const __m256i ptype_mask = _mm256_set1_epi16(VIRTCHNL2_RX_FLEX_DESC_PTYPE_M);
> +
> +	for (uint16_t i = 0; i < nb_pkts; i += 4, rxdp += 4) {

Same suggestion as in the other patch: I would prefer us using defined 
constants rather than raw numbers, as it makes it easier to make changes 
down the line.

> +		/* Step 1: copy 4 mbuf pointers (64-bit each) into rx_pkts[] */
> +		__m128i ptrs_lo = _mm_loadu_si128((const __m128i *)&sw_ring[i]);
> +		__m128i ptrs_hi = _mm_loadu_si128((const __m128i *)&sw_ring[i + 2]);
> +		_mm_storeu_si128((__m128i *)&rx_pkts[i], ptrs_lo);
> +		_mm_storeu_si128((__m128i *)&rx_pkts[i + 2], ptrs_hi);

Please correct me if I'm wrong here, but pointers are only 64-bit on 
64-bit platforms, so this code will not work correctly on 32-bit platforms.

> +
> +		/* Step 2: load four 128-bit descriptors */
> +		__m128i d0 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[0]));
> +		rte_compiler_barrier();
> +		__m128i d1 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[1]));
> +		rte_compiler_barrier();
> +		__m128i d2 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[2]));
> +		rte_compiler_barrier();
> +		__m128i d3 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[3]));
> +
> +		/* Build 256-bit descriptor-pairs */
> +		__m256i d01 = _mm256_set_m128i(d1, d0); /* low lane: d0, d1 */
> +		__m256i d23 = _mm256_set_m128i(d3, d2); /* high lane: d2, d3 */
> +
> +		/* mask off high pkt_len bits  */
> +		__m256i desc01 = _mm256_and_si256(d01, len_mask);
> +		__m256i desc23 = _mm256_and_si256(d23, len_mask);
> +
> +		/* Step 3: shuffle relevant bytes into mbuf rearm candidates */
> +		__m256i mb01 = _mm256_shuffle_epi8(desc01, shuf);
> +		__m256i mb23 = _mm256_shuffle_epi8(desc23, shuf);
> +
> +		/* Step 4: extract ptypes from descriptors and translate via table */
> +		__m256i pt01 = _mm256_and_si256(d01, ptype_mask);
> +		__m256i pt23 = _mm256_and_si256(d23, ptype_mask);
> +
> +		uint16_t ptype0 = (uint16_t)_mm256_extract_epi16(pt01, 1);
> +		uint16_t ptype1 = (uint16_t)_mm256_extract_epi16(pt01, 9);
> +		uint16_t ptype2 = (uint16_t)_mm256_extract_epi16(pt23, 1);
> +		uint16_t ptype3 = (uint16_t)_mm256_extract_epi16(pt23, 9);
> +
> +		mb01 = _mm256_insert_epi32(mb01, (int)ptype_tbl[ptype1], 2);
> +		mb01 = _mm256_insert_epi32(mb01, (int)ptype_tbl[ptype0], 0);
> +		mb23 = _mm256_insert_epi32(mb23, (int)ptype_tbl[ptype3], 2);
> +		mb23 = _mm256_insert_epi32(mb23, (int)ptype_tbl[ptype2], 0);
> +
> +		/* Step 5: build rearm vectors */
> +		__m128i mb01_lo = _mm256_castsi256_si128(mb01);
> +		__m128i mb01_hi = _mm256_extracti128_si256(mb01, 1);
> +		__m128i mb23_lo = _mm256_castsi256_si128(mb23);
> +		__m128i mb23_hi = _mm256_extracti128_si256(mb23, 1);
> +
> +		__m256i rearm0 = _mm256_permute2f128_si256(mbuf_init, _mm256_set_m128i
> +							(mb01_hi, mb01_lo), 0x20);
> +		__m256i rearm1 = _mm256_blend_epi32(mbuf_init, _mm256_set_m128i
> +							(mb01_hi, mb01_lo), 0xF0);
> +		__m256i rearm2 = _mm256_permute2f128_si256(mbuf_init, _mm256_set_m128i
> +							(mb23_hi, mb23_lo), 0x20);
> +		__m256i rearm3 = _mm256_blend_epi32(mbuf_init, _mm256_set_m128i
> +							(mb23_hi, mb23_lo), 0xF0);

I don't particularly like the newlines here, I would prefer having 
_mm256_set_m128i on the same line as its arguments, as this looks very 
misleading.

> +
> +		/* Step 6: per-descriptor scalar validity checks */
> +		bool valid0 = false, valid1 = false, valid2 = false, valid3 = false;
> +		{
> +			uint64_t g0 = rxdp[0].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +			uint64_t g1 = rxdp[1].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +			uint64_t g2 = rxdp[2].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +			uint64_t g3 = rxdp[3].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +
> +			bool dd0 = (g0 & 1ULL) != 0ULL;
> +			bool dd1 = (g1 & 1ULL) != 0ULL;
> +			bool dd2 = (g2 & 1ULL) != 0ULL;
> +			bool dd3 = (g3 & 1ULL) != 0ULL;
> +
> +			uint64_t gen0 = (g0 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +						VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
> +			uint64_t gen1 = (g1 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +						VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
> +			uint64_t gen2 = (g2 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +						VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
> +			uint64_t gen3 = (g3 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +						VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
> +
> +			valid0 = dd0 && (gen0 == queue->expected_gen_id);
> +			valid1 = dd1 && (gen1 == queue->expected_gen_id);
> +			valid2 = dd2 && (gen2 == queue->expected_gen_id);
> +			valid3 = dd3 && (gen3 == queue->expected_gen_id);
> +		}
> +
> +		unsigned int mask =	(valid0 ? 1U : 0U) | (valid1 ? 2U : 0U)
> +						| (valid2 ? 4U : 0U) | (valid3 ? 8U : 0U);

Whitespace is a bit weird here

-- 
Thanks,
Anatoly
