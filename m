Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777E0C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 13:03:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5A7B40657;
	Fri, 28 Mar 2025 14:03:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 7A2AA40269;
 Fri, 28 Mar 2025 14:03:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743166987; x=1774702987;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JGH8DpKuiohKCDqVgrsppK+v+abZ89HD0w5wLoLrg1s=;
 b=OQBA7RLsMwy2iJSBRVJAmfumYYZUmoZixEhgMF8uMYUKKcVXYV2arqCq
 Pv0WuZjLROez7+AqO67llv6+PasJhE97cCRjfZiqL0XZ1H9IZ1NeRMPnw
 UV3fteMU4v15WOCrs1V6vCUSh5qBhUCAifOBN4zzN2OPZAk7WpRx/J+fP
 Z2ar2jKORsXQfTmtRBOv+wZhtg/izB/LRMDVTB2F4NqA0XEoyJZffXfiN
 NpCjlRtyrKVJunXBWcP0RR05oc6Xcg+ckmpxnLp0XQMbVBVNx77wSJDMu
 G7+YTIzWwM56YkBhF8yRJkVFLnYvmbQ3Ok82qe9g7bBFrN9i4I1l3+yv4 w==;
X-CSE-ConnectionGUID: L0AwPqSWR2Cd+sO2W3Km9Q==
X-CSE-MsgGUID: ZHfEXiqxTtOAo+LrBZcYcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="55527659"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="55527659"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 06:03:06 -0700
X-CSE-ConnectionGUID: WVVj+O1yQK2+xxornJ7SHQ==
X-CSE-MsgGUID: Smmho7b6RdCG3IweeLOJRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="130493129"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 06:03:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Mar 2025 06:03:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 06:03:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 06:03:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TH0nvPVmO/7+v/aDxOgYmoM+GTzPrOKVxWWyliR+H3ePSBJPdz+2GJQEMc4qotc+FSOq1cDXKjebipb3RI7Okh6dNyEHEcK/Is5PH6MY4YOW3Z509fCn1TC4OEAvgD2WfOazHwwMOPoCVPUjZFjEjDhf/EaZ+zOqX8Ki+bANho60nP281DTeJMGACaW6oWtKXyqcN283OgWIZpkJBRf19SJp8YBRf9AsbPmN9QvmoAdewyXYifsNpuqFlbpbgEjm+9X4uHQaQGTNNpTG830QRCJ7UxBqCBFZFbmU9qFyQDisaLeWDSaH2fWFempr3xZzQtljkjipEZe1JFMajT99Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyJGXxdqQROp144EDJOE9SZ9J9F489wxIhS7fQw6DLw=;
 b=AvLGLonoYqiraqVAUZgWu1yH3Rg2pa4mfFB6HSe/GprU7P0gFX4zNkwUJ+jsA5MjiQ9GfGiKYDQ0hL8wP08wppzzNIp63fp1MJHotmYlCmkOnYPrgJmoBNUAWJSgWANn3iH7twtdL0iKuvnpESEubacGjp4PFEbm8BAxy6jokM8uwxD4J0RrAuQUAUg8NOnHJxFJdLF08O8MRbXokt84kcciKhea9B24oZ6PtaR7OrMJr/NfJXskCMkmUWGkttI8+Xwh+ozahpMobmOwVSsAxrfabbrjGdhHqYxBTTdE4OCJPn6LuuqE5vsYYhp/vaPEbyc577/MlTPdtOx0hj9gtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ2PR11MB7597.namprd11.prod.outlook.com (2603:10b6:a03:4c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 13:02:13 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 13:02:13 +0000
Message-ID: <675fceaf-011f-4996-a5b6-45e12f6a47cc@intel.com>
Date: Fri, 28 Mar 2025 14:02:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] net/ixgbe/base: fix compilation warnings
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, <stable@dpdk.org>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250328111621.2665257-1-bruce.richardson@intel.com>
 <20250328111621.2665257-5-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250328111621.2665257-5-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P250CA0023.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::28) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ2PR11MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 52072de0-4fbf-412e-22e0-08dd6df8c1e6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1VLYnJUZ3BpZjlZY1YwMDBJN3FQanhCZzFMdUd4YW5aUFVXanhuVHZYZk1Q?=
 =?utf-8?B?NHNIa0p3bGw2YVZnZkdNSXlGd1NaRnRlcEFDWmRsU3MyVjZRUHJGanBvNis2?=
 =?utf-8?B?RlpPVnZKcjJNSlVxbU5QakN4d1NIUHU5YzZ4eVBWUDhYbXptQmlXZU1JaE4y?=
 =?utf-8?B?bTBveDI4ZldKUk5NUUcrR3RkZmZrU0lYSHdtK0gvUm9DMWRCbEFld3o2ZWlW?=
 =?utf-8?B?R2xEdUpXM0tSNlp4UjhpVlNYL0o5RHd0Q3F6VHo1SWVrckpXZ0x0VHhCZitt?=
 =?utf-8?B?dUF2d1JOS29VbmZwMWxjK2FJS252M2llelE1TUVWZVRSbENvenZnWmw1b3hj?=
 =?utf-8?B?NndBY3o0ZTNhelA3TEhVMkVyQVBuZ3hOVkR2YlBoQittM2VFQlg4aDVxL2RJ?=
 =?utf-8?B?bENMMUVaWCtPWWNhbmg0OEtVSVJNdXo1RDlDbzRKWjh6VmFGMmQ3Q05Yc25n?=
 =?utf-8?B?QTYxaUdFR0ZaNjhHeFdHeldBSk1uZFB4MDF3YzFpZjhneWFLd1VhU1ZheTJm?=
 =?utf-8?B?TkdzN3hNOUNDMnF4NDhXNGZpM1E3WnVWOVFkQUpZQmpPL3ZlVUxLVjU0UXVJ?=
 =?utf-8?B?YXFuMWNmWGo1Rlo1NGhZeHpleGJBT2ZvUzROTUxzdVZuUlhqUUFXUk5yV0NZ?=
 =?utf-8?B?VnJKMEdQRzV0enBNa0VwRmUwOGQva2tHNUZMVnFjL3REalJFL1JlUEJ3Z2Ro?=
 =?utf-8?B?MlR0UXowL3M0Y1RHaElDcXdXdklzRTBFTXdwSEtlS1RRYlhuZVdtcU5aTG5R?=
 =?utf-8?B?bXpyQ0tMc2tFbU5MckZ0QW9sdGE1WG1FQVN5Y2I1Z3YwTUpKUFN2UVNTaFNS?=
 =?utf-8?B?dUxOaENreHhHSjhqMGNLZjVqdGxuaWRwZHdMOUZ6UkRtbjdwZUxiR3lBTkZV?=
 =?utf-8?B?R08zQ3lhSU5QUkVJNXZXbkxHNUh1eld3NENaZ3BGWEhXekRYOWFROVZnc0s5?=
 =?utf-8?B?aFFrV2RVcjJRVC9oS3lJbDJEbEd0TWc3VS9FeGQwcDZ4czByVWdVUHp3Y2c4?=
 =?utf-8?B?UytyYi9UK0tyZlZEdTBob0hFeWpoYjNycFUzWDBZOHhvVjA0Tm04WU40L29T?=
 =?utf-8?B?R21YWjVqZWc4SWk5TGZHUks4aStlaEFQRFBhdGtzeUlyMThuMU8rQ0ZUNUk5?=
 =?utf-8?B?aVY1YUx0bTR5Z3VZY25RaDVFdEdtZERLNTkxMEFtUUl1M3kwaXpoS3Exb0sr?=
 =?utf-8?B?N2dvR1hCY1grMTl2MS96K3NteGkwYkp4R1NHSEZEcHlSRHR4alFzbTIvbG92?=
 =?utf-8?B?YThmcXZoQ3BmY0pQUVYrS2ZqcEJpaTMzbjJPM0hjcXovRk1BaXFERmRRSGN0?=
 =?utf-8?B?cTJYZm43Q2xmb0tSeHdBYy9FcWVwWWFRREZld0ZhNFNqOEVxeW1oUXhrNzJM?=
 =?utf-8?B?Tmx0a3JYZHhDclZyWjFNNmNJRXpjc1dJOTBNbFlQVTFTV1c4a2RZSmloYXU5?=
 =?utf-8?B?b3RPOXpxUDZHTmNpamM5OW1Va2RCdDgwUjZoVFFHVnAyd0Q2b3Q5VGI1RjNT?=
 =?utf-8?B?Q3FwWDhIdEl6ZWwxeXhZNGhzcndKVTh2SGR4aGMyMHpJNEhTYlBUSVFSNlU4?=
 =?utf-8?B?NVhlVGRLNnFxOWlQQnhyV3c3OTA0WGQ1Q2o0Vkd0eDlGdXhYR2V6Mm8xcjJK?=
 =?utf-8?B?b1B5c0NnbHN2SEgwd3JOK0txMW5DaURuR2prajhaZjBIZE5Xc0dDVVNLL25t?=
 =?utf-8?B?TGNHZDNiRm8ySmE0MnIwOUgwK2FMSThQL2hlQmNmV2NGbUxiQjdTTENLVVdV?=
 =?utf-8?B?TmZncDZvTHhuWWMrdTV2Ym9mcm1wMndQS3FhZkNNaWJYOFJibStXaUNsdFJs?=
 =?utf-8?B?VFk1YUdhcTUwdE5rbnhxNXl5VW1BNzdiT3ZiZjZINFpzdWJoS21XYk9XVThx?=
 =?utf-8?Q?SJVwXvt7B4VU8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2w4Wm5OdVA0R3J0SWxaTUR5bGsyaU9wbjVkQ0FwU3V6eDNEeEdxUmhBanVt?=
 =?utf-8?B?L3JLbjNzSjBoTjNEeVZwS3Byb3dGN3JCbWd6aEF4NmxwbEFaZG55MTFBNmYw?=
 =?utf-8?B?NHE5bUlLWC8wclNXUlI2LzEzMWljeEQ1T3JzdUgyaTV0akllMzlMRnlsTWE1?=
 =?utf-8?B?K3hWb1NFOVA0RWdCRlFpOEdEUVpyT0l6R1dkR0NHK2JneVRRVWp4RHp6Yk5E?=
 =?utf-8?B?TlZCcHQ4R1ZTUjRJNUQxWHhhazhBN2crank1dzFGSUlBMjNiRDRYWWdmWEZP?=
 =?utf-8?B?ODg0dTZGYUswanVZak9VMTcwc3luMFdlM3RqeDN6ODI4UjVEemdoSEdQUTNB?=
 =?utf-8?B?Tzd6SElWYkNtN3FWWUtTeDZURFZYN09ISStGczhqUENtcy9qbGR4R2NmTHVZ?=
 =?utf-8?B?dTBDcjNjQXBXMkZFRkcrOUpoRmNHSXdxeEhtcTU2OSs4NVBvc0RpRUlxZ2hF?=
 =?utf-8?B?L1h4aHBiR096SHYybW1pMFhWaWN0dll2c3cyNXdqVTZPUGRnbjBRMVM1eVF4?=
 =?utf-8?B?Y09kOHhmQzhBemtjVWs5Vlp0THF5QXNJWDFTcUJXcm00dzJsWW5PZmFtRHRU?=
 =?utf-8?B?aVlVSWxyV3NBNFd1K2VPalRHNzhsOEhicDdDWGFSQTlXTlhxN1ZWakN5NVNa?=
 =?utf-8?B?YlB0QkkvY2JraU40eEtVRjBHSVEyUzhYdGY1RWYxdHJ3Zm1jN3lwVkZGVjR5?=
 =?utf-8?B?K1c4aDNpV1FyYlNIK2Qra0JISHExMlBEWGI5NkVtdXZKLzNYaERtdWhEdUNV?=
 =?utf-8?B?eUtQMitla0o3d21rcHl0RFQ2UUFBSllSMGFZc2U3eVFLM1NuZWRFKzQyMEVJ?=
 =?utf-8?B?dWxzZmozRTFiQ1dCMGZyUzdhdEQ5ZWVzVmNWYmNONFFBWG8xQk9DTnNpUU1R?=
 =?utf-8?B?eGNPWmdLZ1ZGazNJdTQ3WnZHek91UFBzT2NCemR2YVIwUTZJNkRRdFE0YnlW?=
 =?utf-8?B?TzlGbEdBQ2IxclcwZ0pnSVhLRTI4QlI4MG4vNmtsSzlTV010akw0RWJ3TjFS?=
 =?utf-8?B?WkNyZDFIMGprNXE1MThwc3RUNEJNTjlFL0hFMXJBWllZZllBbGJibTVIeUV2?=
 =?utf-8?B?UktHN1dieFhZdE1WVFE2dGVLcTViK0VmY0pUWnN3cGdhMmUrZzExWE8vMkx1?=
 =?utf-8?B?QjQ2ZW9OR3BEMnRvWlI3MkRqcGhQRmZLTmZxYnczaWZURHNHYllVNjVYRDIr?=
 =?utf-8?B?OHdBQ01LRGtpOWhlUnJ6QTByek9QekltbkF5NGhUZVpvelJwZzJTK1NCTmJa?=
 =?utf-8?B?MlZDdm5Wc09TTDNPdFMyUUZmYk9lNyszREpJTTUzaWlzY1hhNlhseHdSR3ly?=
 =?utf-8?B?anFuQkZFRjRodlBnQmRGUkJFcVVpUlFiRWMrY1d6WG9GRjRnOW1LKzRYQVYy?=
 =?utf-8?B?L2dzamVBNGJucjlUdkJnUXNEVy9VWGtSekYwYTF6TzJWdUJsUitORFdPVzNs?=
 =?utf-8?B?K3QvbWkraW0wUHpRS3EwaXVlaHNwVmQzTkR1OG5MOEh5UXBMOEhPZmNjVzRD?=
 =?utf-8?B?RTgrMmVqbEVic05JenhYOUozbjdNajNGdE1sUFRiYjUxRXFiUGRwMHM4NWg4?=
 =?utf-8?B?bTJZQ3kyak1EL1pscFN2UmFGZlAyL0NxVDNWQzBUTDZ5RlNuS2NIUWVuZkxy?=
 =?utf-8?B?NHN6cXBoWU9XQUlpQ2Z5Y0J6Q3BxOTZ6VkNJdE9QdG5Ia1dOMUVocGtaVlVW?=
 =?utf-8?B?NmZYM2Y3cFJzSnRXTGdiRjkrbWo4d0RCYTRNN0djczBHZGEvMURjOXpHajVT?=
 =?utf-8?B?MmwyWXdhL0JUR0IyclB3blRaWnMzeW95VmdGRzdTYkRzSlFKaVNQQmJ1cjhH?=
 =?utf-8?B?SFQzOGZ2akJWN0IybjZxWG9xaUJobitoNWwxSUF2c1BYT0w4V2FuSEo3NktG?=
 =?utf-8?B?TmVPbDJFQUNvZXJnelREVlFDeU1TSVVSTXdXTXNycjd5V2xBcU91b1VzdU5R?=
 =?utf-8?B?eSsxcmNUSXd1YldoR1BxK2ExaGtUOUx1K1BXMURvdHBXdjl4QXJpeVRycklY?=
 =?utf-8?B?VnZhQ3JiT2xzT01xMHh5VVg0R0Nid2ZRYmhKVzBhZ2Qya0ZZeGI3UnI5QTVM?=
 =?utf-8?B?SzYxanBXRTdnYW8weGZEQjQ2cGptUFozaHlHMThycUx6dk84enlEVFhRNWI0?=
 =?utf-8?B?b0NYMmpid2xrUW5NNGpjanJNdUMyR0tGWjFUc3pzUWV4ZnVib2hYNGluSi84?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52072de0-4fbf-412e-22e0-08dd6df8c1e6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 13:02:13.1986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NjnRn+S3VqVdU9CyD9nG4BjxqFhTby+7XXI04qBlbLtIsRxUxNEbrUkp6r2iOZl+MwFVO2W0LdXmCOOP2Hy+Rpir0mjk+qu8F0k4BcTfmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7597
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

On 3/28/2025 12:16 PM, Bruce Richardson wrote:
> We can remove almost all of the "unused parameter" and "unused variable"
> warnings by just improving the macro definitions in the osdep.h header.
> Remaining two instances can be fixed by just one-line additions to the
> code, so add those to give us a clean build with the warnings enabled.
> 
> Fixes: af75078fece3 ("first public release")
> Fixes: c6cb313da739 ("net/ixgbe/base: add link management for E610")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
