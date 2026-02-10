Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA75EA8115
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:27:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A8B9400D7;
	Tue, 10 Feb 2026 14:27:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 78319400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 14:27:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770730053; x=1802266053;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TYgk8F+K7aPu8gewAXW2/0333ZJGpuyO662KG0TkOBg=;
 b=W0ygWCja4z84Vt5yplZXFJakgDepQZjvzEzBuWCU2hHYglbax/P/WVRr
 kpabV17XsI8mnFeVFdBfocKjerWRyGPp393+ijcObHIL8y/aCxGMtGWFS
 D9CuWnq4Ifq7dXq46IQqXfElX4rXBJ0pZXE/DudOBFAoaqtGjj0ziUZQO
 dvLQ5kk97bAGHuvCdAImqUg7Rz/0W1wB+P8jKlVCVRmggwdMqchKcrHtB
 ZqJPl0xndiGXP0zMwTAxC8SNXNqBVIlxNQ+Z7tGQNdSCa74FGpVseyz5x
 ov+oYhk0jcHZ9j6X9Ffs0XOsuJxqBcuo92gbXGC0AqUeQEUoSZ3l0uOwC w==;
X-CSE-ConnectionGUID: jz8p5MRRRVWx/zP0il/r+Q==
X-CSE-MsgGUID: VwuQE03dRiOR6iA0sGOEaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71067648"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71067648"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:27:32 -0800
X-CSE-ConnectionGUID: n5skrYZSScq/mSFTm771DQ==
X-CSE-MsgGUID: sKun9M0cSBuHmwRHpU5hoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211997450"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:27:32 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:27:31 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 05:27:31 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.27) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:27:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpXXjtrkAHuQght6E6GitHNFSNLFnnEV3raABakD5dl+h3eD83UnKMU8/xSeYkQ9gGzYI1e2Two/mBSCLd+U84uYbZSU4xAtwBACxMBcwC2k1ygvJH4hAZO5ptWg1FFroyGRP6NMvJXJppJQJaFtSIoXpv+fe9l/UnPlfjSvK8m/Skgowm+v1X/BR0I1NwwHdL8H36FLxLQbxN6wSG1gaJn6I9301s9gSuFK0yNlo8E+Z76wOCOAWSHBo6tcLvtEHSwKJF5XW3gPTJqgM8u1JCPOeNrPbK2ifWn3b1eaGpcQ8FvHFCWnEcSQ7gy+ZV1730YoBjwoAxHpvSxpXl2VAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMgyuJR4+wpJhXto8b1RiYOSBAVHmh9QGhlh5dNeEIA=;
 b=oeBwIyna2mbM6jW5uLWgQrEWBh3ZLgS8qG5dt5zn9JxMbeJnLonOh2eQbGeI5RxmqgbjDgGHABIRY38K6FFKd9sO3pEfDFvTAikAxmHf1Qtu8kPRp47DyLU+r4i41ufiQ8z8MY96kRz8aGcEQmacT8IwJFQRdyfxdTxBWzIwie6Hjm3hW/eYFp12hnH7AhEsHyp4WBnbO0rn0atADW8WO23zriCjOUgFuFXMIhBH9s3E1JROoogwZq5zSlWpX+X5i2QxNgCJgFpC8nD6HunGfw5VPibzJE8cGM/4JjYTgukMDWyKCOWDOmDCv8COiMWfLZMXeNhfeiFUuM9YajlTCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS4PPF9E4E1C227.namprd11.prod.outlook.com (2603:10b6:f:fc02::3e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 13:27:24 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 13:27:24 +0000
Message-ID: <c6f38b5e-f3c9-40e3-aa6e-bf2f620b02bc@intel.com>
Date: Tue, 10 Feb 2026 14:27:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/35] net/iavf: use common scalar Tx function
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-16-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-16-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0192.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::7) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS4PPF9E4E1C227:EE_
X-MS-Office365-Filtering-Correlation-Id: c74a90e6-b8ea-4c54-c78f-08de68a82033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzZrVUZNNHNlOXNad2tSQzlnMWZHR3VROFlsVU11SHdtYmxWano1clNhTXFZ?=
 =?utf-8?B?ZVlmYzZSQzdIMDJCNGZvNHQwUnVIb2U4Zy9wT3J3Sm4wZXhRNzl3RFFvdUtk?=
 =?utf-8?B?ZVEyclhtdkdZdFg0emNQTHBkL1JYdzhXZ1dEQkV5RlloMW52ZzZYK1BGc2o2?=
 =?utf-8?B?UjRlRE9wQmdsZ1dEZFV5cno1THpvNTBhVytVK3VwMTFROG9qb0JaeVB6SGln?=
 =?utf-8?B?d09tM1R0S0gvY0puL0ZSRmttWE5uQlNrVU03NmtwTlFvcUMzT01pU1Q2MFBO?=
 =?utf-8?B?Q091SCs2VFdERGtWVkhYdVh3eURKTS9LZ2VmQ3g1a3JiTGVxRFVKNmxETU51?=
 =?utf-8?B?UUVpMll1WW5MNzJyWHJ5YnpSYmZLOFBwVWZyTEw0aksvdnV1NjdQbjkycFVX?=
 =?utf-8?B?NzlvcVl0amZVQmU1V0hTbmI3VFkwRUdMMnAvSzRCRXoyVEZ4THh3RjliY1Nx?=
 =?utf-8?B?U2tSZk42WEJOc2V2Z1Y2VzhodGJKQ0JycWRrOU5wYUIxcHNSVWczbmxsZ212?=
 =?utf-8?B?Q3o4L3Vma241V0xiTVRhZXI4SmJBSTdmaktJdmhZL1B6aU15SGhmMXR5M1Q2?=
 =?utf-8?B?TmI0bmo4SExES0VZbFRZcXNFeXdRZTg1S2Q1ZHVYR0Q4OWxjNG1qSzM1ZVhh?=
 =?utf-8?B?RmxFWktGcmpvR1FYWmYwOXExcSsxcy81MDFhV3dNYWYwVGZBNXhaMHZGaG5D?=
 =?utf-8?B?Zm1KZUI5ay9Ta3B4bzF2VHRUZml5VnpnZ21SQmE2dWFrTWwrTi8vMTU5UGdF?=
 =?utf-8?B?ZkFXNnoxaGZveHlzWjJBQ3M4Wi9GdmxOV29pbEgwNkpvMzFjNVlPSlJ6T245?=
 =?utf-8?B?blJ3TDR3Wnp5ZVp5c1JlbWdxZDJIYlllZkhJMGlJbFZMZ3NrQWZIV0ZwOHpp?=
 =?utf-8?B?VEl6Q0F0ZExtbFd2dW1EQUVUUFNlTXlDbnBSNEtyOGdyRzlIQWIrb0dmWGNp?=
 =?utf-8?B?NjN3S2pObDI5TTJLQkFucmpOeWN3NVYvMGhZTlBSbGFvS0NHdG9yS1U2cG5R?=
 =?utf-8?B?akpOSnZRQjFWWlRRSGphMjIxOUEvZWtWSXQza056NU5lMGxPWk1BdjlIMGpz?=
 =?utf-8?B?SmQ4alRPRHFaSC9LeGorQVl4OEhBRW9nOExSaFVJZzQzMmN5ZHQ4a1JhYjhF?=
 =?utf-8?B?bVRYRGpjLzVDTHlNc0RLMlJKakhHTGtkNGlyZEdjbmZPaFZzeUVBekpQYWEy?=
 =?utf-8?B?TnlKM2U5aWpidXZrZi9YWmJTSDE2U0ZMVjFHVmdoNndxbGxWN0VpTWJqdkRt?=
 =?utf-8?B?V0ZYRGVZZ1BxUUdRWjFjNFZ2Ykc3a1p2anE1eFRNYXF5cC9UUUErMCtjUWwz?=
 =?utf-8?B?d3N6ZVliN0pkT2d3WmJiL1lUbEoydVRndW50RHdNQU9Wa0JkVXB1NGxCbjdP?=
 =?utf-8?B?UzFkVnIwcFBHU2MvYmt6UUpneE42NkdmUmFqeUppQ29GNURmaldVR01CcG42?=
 =?utf-8?B?bzlObFdwMXBqU0RqNWdFd2E3MDVVOTc5SnllRnpSeEZoWDdnZmJyZExIdzNu?=
 =?utf-8?B?bndlYnpCWk1VM1hmc0dPZ3pUaWFVd1Jhb3hmbHNhL0FXd3h2Yk5CNzdEN0hm?=
 =?utf-8?B?YXowVE9SQWFQQmcxRlRtZUxSV01hb2k2S2Rrd1BBbEJmd2thR0dVY2ZNV0sw?=
 =?utf-8?B?U0hYZ3BoVGN3a0ZyRndtTE51RjZSdWxyODR5OW1ZcWN5YnRBWnNiL1oxcGpR?=
 =?utf-8?B?TVdDa1hoSzMyNXZ4MUVxTThVMDdZWCsycFJVc1VzZ0tMS3VGU0hhbWQxdGtU?=
 =?utf-8?B?MXpucEVENGlJWkRzSjRzekpnaU95M21xUmc2NkxlS2RWOUNTbnFLZUVPejVk?=
 =?utf-8?B?MVhCTnhhSGs5RnhQaVowa2drZFNhQXcyeGh1a3hCcklYampiL04vNTdGWWlF?=
 =?utf-8?B?Z2xJcXR2YzBCRU53UE9tYmUvelJXeE5WSEE0UzR3ZGhyODE0S1R2VzVrWHRZ?=
 =?utf-8?B?dVhlSisrR3k0WHJ4WGFZMUQ4dE0zSDZhVGFHYU1Ic1p3aGh4TkdvaTVhK0Nr?=
 =?utf-8?B?ZFJFOEZHZXdTajVqSjU2cWRpUVBsb1hYSzNlcEpZRm16VVRkanUzeVpPSEJh?=
 =?utf-8?B?U3IzNDF5ZWE2NDRJdDc0aFMzS3ZmV1djUmpIVDJYanRVc2JkSWwvWFVNV1lT?=
 =?utf-8?Q?zprM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmlhV0N6V05INE1RUDVQMG5RZERuOEwrRTREYVBrdHNUQlZVNnhvL2VmWWhX?=
 =?utf-8?B?b1BtQXVSSFUzbjdGSzJOYkxhdGhuVDZ1SFVtWm1aMjZWbFdDa3BKNzNnYVIw?=
 =?utf-8?B?cHpwcVVlQjBOeGhvaTRrNmxGZWJkNHRyS1R5RlBMNXpKQy95eDVDWUdsUjVP?=
 =?utf-8?B?RFQyVXhvVHRVbHlGandPODB4bFYySEtFQVpibVB4ZmUxSzF6RURUNnZld24y?=
 =?utf-8?B?bEM0bnNWdjJlNDFLRDk1Q2x1OW5tdFVNUlRoMkdhbVJobVBKWDFWSnhzNFBN?=
 =?utf-8?B?MGZ0L3M4WUtkZklmRkxNd3UxVWpNbmZyT2c4UzhYOGZ3dXlTVXJzODJiaVpj?=
 =?utf-8?B?MktSNG5RUVlpaWxka29jR0YrMXVWU01lbWZGc2sxdGkxNnRiSHVBQ01QKy9r?=
 =?utf-8?B?Qi8xbGVOZFQ2UVZuSTFzdzEzOWNWT1o5elBZNVlOcldhNjB1MXB6QWNNUlkr?=
 =?utf-8?B?cnZKeUJwMHJHSVJudVRyMDZMU050cDVGbzN3dVMyUzVMdlN5blU0cGF3UFJa?=
 =?utf-8?B?bkVxMVkzZThqWjRvbjRQNHE1WGNtd3I5Rmd3ODNESXNLbVJ2SmRaeWVRczB1?=
 =?utf-8?B?ZHpQS1dBUk1DUGl0RnlrditwYzMrZHZ1a01Qay9FZUZwSWZHQ2pHZ1ZQc28r?=
 =?utf-8?B?YWFkSWp1RXQ3M05WYmFsdDhPeVY2MVpGVm1NeDdlc1ZJWHZzdndsd0praTlX?=
 =?utf-8?B?MGNDeWtnWVZ0WHNMaTRjTTFLQWpaWHlMOWt3Uldpc0FFS2k1NWtnOTE3WVhO?=
 =?utf-8?B?Rjd3UVBMRjB3R1loaldML1F1VjJ0YWJkV2p4OWViZFVFSko2RkhPOUo3ZVNO?=
 =?utf-8?B?dmx6SUpTajZUcFlYbkd1Q2RNdFJRbVRHL0M4ZWRYSU9VNldReG5keVM2NHZi?=
 =?utf-8?B?L2hsL29pQk5rdHh4Y0pZbENQSEpZdlhmOUdERnR1a0RYZFdUNUhLSmltT2lJ?=
 =?utf-8?B?Uk1RSW1BQWd3bllFKzhBZnFCbmhNOFRyOXVGajIyWWo3NEtOd1A2RzhNbytC?=
 =?utf-8?B?S1RMSzlUczZpVzRsbS9zUWRoeklmVTNEZ2xTcUJaUkRSMVJOS3o4WHpYUERF?=
 =?utf-8?B?MS9HOUYzU0x1b2ZvdEIvWGZzZTdIZE1hR2pSWkdmVVBHRVgraDdyaGpUVDJ0?=
 =?utf-8?B?cnRNbCtsQWhHVEdqMTRRMENXajViRi9NcnA4SXE4dnhoeHpRTkF6R3puSkdZ?=
 =?utf-8?B?bk1kSS9rNGxjU3MxVjJyTlFqbitRWG1ncmNNVE5Pa1RKWGpGbHZMWjA4R1hN?=
 =?utf-8?B?R0ttMytwcjIvQTFmR0hVVDAwYjZQSVg0S04wNGpwT21JOTNONzA0WXEyY3Jw?=
 =?utf-8?B?aGk0S0ZaOWM3ZUZNN2dLcldHdVpqU2dlUVhCYWVuc1UvcWk3VE9iNklNQ3Ar?=
 =?utf-8?B?Nmxxbm9zWDNndHdyeXJkQkZOa3QrOENTN0cxZGpxa08rS0J1akI4WjVpOVVK?=
 =?utf-8?B?cExRQWJqWDBSbXJQNmZJZGZwWnpjWFhPS2VJYU1kK0YweUFvT3JGazhrWUwv?=
 =?utf-8?B?Qk95bnRaZlJ4dG5tL3crbkpaekdia0ZIZHBQQUpCMlVXZzNJSlBpT0pLL01l?=
 =?utf-8?B?RG9NRE12Y2pRamM0ZFpFd0NZYkN5K1pWUWd4UmxnRzhzMkJLSStMVEZOTDY4?=
 =?utf-8?B?YnZIMUpqc1lnYklpT250TVp5L2FxNURObGcvd0ltVVU1NTJJRnFaMm1KU3ow?=
 =?utf-8?B?YjNDcGl4UExLbXFhaGxLbEJ4QkF5MFhOQzVFc1llQnQ5VDVEMlVWdGltMkc4?=
 =?utf-8?B?Z1RBVjdFUitQbjhiamNXaEZTeE5GWTVvUXlReWJRckhrYkp1QlloSUNjNG5v?=
 =?utf-8?B?MzJ3dkpvOXhJdzlLTWRYaHFkb1MxQnZJeE9yOE1lb3NWYXpQeG5weDZOcGhz?=
 =?utf-8?B?QSthZHYyZTJDZ1BjZlZtYjlXMUJEaUlkZU0wanpMdlJhUjd6NU1xQkxTM2Zi?=
 =?utf-8?B?YndrYUVWbTd4SW1jcHZ3emZxQ1loVUlJNFQvejVZUWQycEZxcmxiVmZBYmtU?=
 =?utf-8?B?NEZndGtCWUNDSWF0MzdDSldGRDllUy93aDZuK3lNc2lyb2l3emxMZ2F2bWpw?=
 =?utf-8?B?bzZVYURrQjF3bHJtODdWZjV1NGd5cld6bWlLUStORlRNYUNLbW90MFp4MUFW?=
 =?utf-8?B?bEVpQ3RaSThya3dqZjhDTVhpekZVZjJQSmw5bXhEOFF2MXJVTFpkN1FzYVd2?=
 =?utf-8?B?amFMVStvTXpFTjVJL3RTNUZZQng1OUZCN1Z5Q09wVEZHSjF2WEtxYmRFVTlx?=
 =?utf-8?B?YStpbnBQUFE4aktpSFJIZ3JJanc5a1oyVVZ5ZVNlSHZlUjlKSE9BcHZSNHV3?=
 =?utf-8?B?NVhQR09ubnpyL0I5cktZZnhvaFdiS2hRNXFQRFh2dkVhOXd6MHd6MUtJT3M5?=
 =?utf-8?Q?j4qUKJkxCxPjSHMs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c74a90e6-b8ea-4c54-c78f-08de68a82033
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:27:23.9670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcVj3NNXBzTgwNZ7RLwHKbWUFtNFtsT/A3yM1jyDSartueH+hJ2rj7kZuzgUy4mK5m1xv3vBy/yYCkW3PKefd/FFrjDxBD6MDZOsjJT9+0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF9E4E1C227
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

On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> Now that the common scalar Tx function has all necessary hooks for the
> features supported by the iavf driver, use the common function to avoid
> duplicated code.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---


> +		}
>   
> -		return;
> +		/* TSO segmentation field */
> +		tlen = iavf_fill_ctx_desc_segmentation_field(&cd_type_cmd,
> +							     mbuf, ipsec_md);
> +		(void)tlen; /* Suppress unused variable warning */

RTE_SET_USED?

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
