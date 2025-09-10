Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F28CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 12:16:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B85C740270;
	Wed, 10 Sep 2025 14:16:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id B93D2400D5
 for <dev@dpdk.org>; Wed, 10 Sep 2025 14:16:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757506563; x=1789042563;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GRq6aFFQ8Ra+37XqMlXhiYYH5f7n/p/AHyrnt/VeQlA=;
 b=ZLThAJIDoZjOhTtiv2C9e3pogLnGx3NfYf50JEkIKu8+/IUHGnW8WkJE
 yJ3CjcXegf2xj+NZUpluoh7Ffpmh1KSwsCI8xwx/Jgd8cVcdwpdRQuNAq
 77fiqvkAnaKMs0bp5ookC3R82qNSDFD68NCh5Pr+yc/Jz3Z9cXjYVUrPt
 qUJSBgnmLLt49NPjhZBRsYy454BnrJom61MHBzHmw9YNjhLzfyZ7rqPB/
 Alz+JDtsgp9R2RNhID5BbvypnYP7+HKL0z9ZaPBNPkbum+4AFq4LTnXl3
 nDmSdSh533lnO3XePuzuLh8ukAJxVGJwqIgcHXhZk46aElkrN5ZFaOAN1 A==;
X-CSE-ConnectionGUID: OYKCMMfSTdWTNQuV/7AsFQ==
X-CSE-MsgGUID: 3YqZXNvHS7KI7aU9YLFhhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59889028"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; d="scan'208";a="59889028"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2025 05:16:02 -0700
X-CSE-ConnectionGUID: SBl9lUNAQF+cQa9xSKnliA==
X-CSE-MsgGUID: 7tUkrj3rRtOGsGVGh5glTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; d="scan'208";a="178579025"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2025 05:16:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 05:16:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 10 Sep 2025 05:16:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 05:15:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5EucecpCe2lr7q17V9R61hlGwUCgGMFo2Uo41C+VUr2XUj3IyiaWM00PQJooCpw2Xs0ttPJreaDDENLpxu4S06Is4wnpCKl44E1MXDM33/cN5Y45sqtembovXzUc9uFiwBLy10Tv+klonl+Wdmu/t9PPSFLzebvyfdY/4hLQ3MrZdi9i5CmIniqbHyb72bwUKictI+J1nlCLqQMseRKFW50D/5NFx9XVO4n4X99IeLP3ON+ASNbAk0UbQ7nKk4djvhxJ8zUlUrfE92mmRni0PxB1VnaFeuLp92KWRXlvCYFLkbsb4NGN1/NsJ3ZJNH2qBxbXM2FYL8cOQOtJDcKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pTC0K0hpfCp79xYgfICztP2ZrzAFFGXx5hfVvPS6UE=;
 b=h7I/N0MGsg0IQyyK0RlBTfjIyOqO2/iSWoRG72srvKPlmt8f3yu/msIBJalSB8s7MBcHjDHrQm2Gqolc/c5hdgabOBvx/EAEEZWzIgu0g2sVyEpVtxa++haZZ7B/qDTC8T8ECdDcSj0q4vj3T04DEWGA5DsAOpsRAhngUECo+nWcHpWUzcZTz5g888UkyLl8Yc/VDT3JpwC6qKEkDiNLjY9LXc51Kj0GPQWkunfYjfk5Fy5kxHljxKsmQ69ADXsxMsG3hkPzSQGz3zY34wRyXl1kkwrF4pVJIF6zRICckvjAssCXWtF28TIaSBZwU/SI657xSIl51vuQPE+esTH5SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA2PR11MB4826.namprd11.prod.outlook.com (2603:10b6:806:11c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 12:15:39 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 12:15:39 +0000
Message-ID: <a003d3ae-79d7-4d9f-b703-70427f78654d@intel.com>
Date: Wed, 10 Sep 2025 14:15:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 5/9] eal/linux: remove more internal VFIO macros
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <maxime.coquelin@redhat.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151800.1965006-1-david.marchand@redhat.com>
 <20250903151800.1965006-6-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250903151800.1965006-6-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::15) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA2PR11MB4826:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7e5fed-6fb4-4f69-579f-08ddf063c165
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEIzSXA1Qk1qVUxxNXlFL1RRUURzZnBSbDJ2REJ5S1QxZ3ZPbURHcGR5cnNV?=
 =?utf-8?B?ZDR5MGhNMDhvaXRMYU9TVkVBeU1udnBKcHVWN2tGbGp4dklrUHZpSUpFM3lJ?=
 =?utf-8?B?NDJadG9ZV1ZXRWJqRmk1d01HQWxUN1NYQ3l0dDBrcVlFOFdJcVROdFpISzg0?=
 =?utf-8?B?Z0JRTUsraW1NSnp6bURYdkpDWDJGTlF3akR4QVV5aGxmWkoyZHhCTVB5R3hw?=
 =?utf-8?B?QjJaclpDSDZjekI2TThKTTNJNUVUODBoNEdDeVJtczRFWnlNSlBoNEN2d3Ar?=
 =?utf-8?B?N0tnajVJWWRUNHU1NStQTWZld0hIM3ZZaGtYR21TWkdYV2k1eCt6WElMbkJ4?=
 =?utf-8?B?YzNUcS9MS21QbUFHUkcvcm5jQ0RvNVo4MHZPNXhpWDVTakw3WENsdnlBcTA0?=
 =?utf-8?B?b0puOFFnTzNMZXRrSWRpMEN3QmNIWkNCZTUyZ004c1l5Q09NMEJXMjA3N3FG?=
 =?utf-8?B?bGJUbTBwT05HOEpmTTZFU0s0SUR1bGlpZnJyelR1YVRadHZ2N0gvNzJ3cXFT?=
 =?utf-8?B?VG9RT05hMHJLMlE5SlRQM0l1SVMwcTRoOEtwd21rVWhlSWhscXd5bHpVSkRR?=
 =?utf-8?B?VGUyOWlrL2F0Nk5JbG1BamRETXJKdEtWSlp6bjc0ZG9ydno4NzFMTm9DZ0cx?=
 =?utf-8?B?RlR4MEVVLzZMdzF1TW5IdWFPRnVqVVVPVTVoNVNmV3JvYWRvNHkyV0NaNjFs?=
 =?utf-8?B?SnN4SDZIbDFNbSs0TkJYL0xWczltUjVXWVlPR1c3Zml0UDRzNlZMSEZwSFV1?=
 =?utf-8?B?QXVnVlBoaW5pcXhkZlRWWjR0S1JpTlNlTVU5MmZUbVhvaDQyLzRkZ0k5bExZ?=
 =?utf-8?B?TUkxWjZndngvbitkOUVWR0dKb3ZrWDR4NnprQkk5NzVldWZNSG5nMjRxWVMv?=
 =?utf-8?B?UitLM3h1YUdPVk5kb3hWeUxRd0o4aHI3eEJyUngzZFl4dnpQQTlOeTErTEtK?=
 =?utf-8?B?aTRUMjNjRkRjaFFabkw0dnh5eXVITEVVV2s2RkRpbG9oSU9udUdYWENJeHpB?=
 =?utf-8?B?UEs3TXZXQVBoV296VVl2ME11a2FJMFJsRndlbDA3SWVZR3l0aTRIblhoM05O?=
 =?utf-8?B?Y29RNXdPL01KY0dlUUxhc0Y5aXptME9pYzVsL2Y0azJwRXI0RFZib25HMnY0?=
 =?utf-8?B?Mm9QUWZ6VVh1ZFhPam1ZOTNON3YzTlJlRHdQUTIwSjViY0lSUklQR0VOR1FX?=
 =?utf-8?B?MXlKZ0hyeFVQOEV6YURWL1poVlg0RVdSL0E4ZFA0ZmhObnZvU2RzZFJtRlc5?=
 =?utf-8?B?OUJNblpHSlVvaXVBdkNyZmtyL0VLQkhycUM5R2Q3c0IwZC82MWhnQnZtdlVt?=
 =?utf-8?B?WDJTTWRraVYrekV5SDFwUmtuU05WM0Q1YVFqeEZKQ1R5K0xRcURTZXBVVWxC?=
 =?utf-8?B?NmhlV1dKTUZUTUd4V01zM1IyYUFKeW5NdkdQVENjbzVvZFZuWFZBWmlyTnZH?=
 =?utf-8?B?b2VSUHVyK2paZHRiZ2tmTGV1cDA4aUxYaTMxblhXZmZ6OEtkdzFMd3VhYjRB?=
 =?utf-8?B?ejBhL3VORXlxM1NhTzVreVNGNGJJN1ZYYVlGTDE3dEhNamI1RDRxUzU2Z21G?=
 =?utf-8?B?R0c0ME51elRlREdMeGd4MzlPZmxJUkhBMkZpZUJXTk84TjBTYkgwdGdKOUk1?=
 =?utf-8?B?YStJQVU3SmNLa0lBbFJEbi9kNkdWeWN1c0VBUmJnczRQVDAxaFd3SklHR2xR?=
 =?utf-8?B?eXhabmUrcis3akJ4dzJ1WElrOG9PNEZXV2tha292aFR4V3hmaThRaUZJYVpl?=
 =?utf-8?B?TTNmekhLQS9OSVdnWWprVWw2OXJjV3J1TS9tblpvaDZIL2NsMnVzcStqdFZI?=
 =?utf-8?B?aWk2elBubFJhanNCRytkK2pQRHI5R0dvaGtjaGRtei84dnJJUWh4MHJJUExJ?=
 =?utf-8?B?TkJWekV2V3R5NG9IWDVVTVZjOUR0Nk4vazgxWnY2NmdTNnJrNXhEbVRQdXRJ?=
 =?utf-8?Q?XuMcilYbY54=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NksyZXVIUzgwMk1VR1FYZmwvVk5qRzcrYy9wakNFQ2oxclRLOU8zUnUzWVdl?=
 =?utf-8?B?TXJ2V2NlRHFmNUR1WWtRU1l4dGxQMXBDbEVGSXk1L3EwYkxicVBraEhlS0kv?=
 =?utf-8?B?Q2FjSUptMCtaZ2hOdGM5SU1MNTNRSjhxczZZc0l6SlpiT3EwR2cwRkVrT1dF?=
 =?utf-8?B?YThKQlFKc3VoaGlhbUN1bzVZUm9OTFc2dDBVTTJKNzdtQ05OTFZKZXczdG56?=
 =?utf-8?B?WHp5R1FTQ2hLMGc4ZmdjRTE4OGl6eERBcUlRNnZpallXUEdPSk9IL0NGbVY0?=
 =?utf-8?B?a0pDQlN0TVo2QWtIb3h2Q21pNWxMeExDTHJ2aHhqYnBwcWVzaTNZNnNTdkx6?=
 =?utf-8?B?Unoza1pUZElIdW0yM0UwYmIwVllidXRiRUNzL3ExMWdlWmRMNjdUcnJQT01X?=
 =?utf-8?B?MFlNS1RkdlYzNk4vYnZ3SUpEMHZzcEpoVlluS3dna0pzUlV0SWFMMXlRTVhm?=
 =?utf-8?B?Lzc4MUJ4dW9RYUVDaURucWhzMDhGcE9kcEFBTlpYM3JVdzhFcWx2NmY0enB5?=
 =?utf-8?B?ckFaWlo1LzRYZlUrVVVOTjFiTU5EUXF5b3NwYU0yRVIveUJ4bHlZODRNZnZQ?=
 =?utf-8?B?S0FGVXZtWnpDdjU1MUp3c0lzU0NkSUNkUzZmQ0gwS2tydWFuUDZIc3hwdXFD?=
 =?utf-8?B?c09YbVJFRFdmRjAyZTQ3TXRlcm5seVl2ZnloQ25xbGFmVkxoc1p6bzE0djF1?=
 =?utf-8?B?TVdvNnZmYUJJME5FYmZuZ05EMVRVUU1pTjhaZVc1eXhDV2JmanlvZVA3RU9B?=
 =?utf-8?B?WTBNRG4yNVlNUkpNQytrM1paNDhxTU5UQm9FNUpKSmlEa2l2MkIyL3pmRklr?=
 =?utf-8?B?NkNLalQrekFIcUc4SnJVcFIxaW5pK1ppM2x1YzRCTFZxVTBlc29scm11Y1Ba?=
 =?utf-8?B?NXFzaXRGZndNdUxUaHNHMngxcnJ4VEI2YkRtQW1kbWkvRGV5N0ZEaFRROC8r?=
 =?utf-8?B?RWptNGJWZGRGVXUyZXRzdHVKbHFFb094M2k2L1hwNnRFNjdqR3d0aGdEa1Rp?=
 =?utf-8?B?aEU3bEdYMGhhd2NPbFQvSm1mUVpsUlE2WUY5RE9zd1Y2MjZyNlZHTEsrdzYx?=
 =?utf-8?B?d1VLVURHdHV6blFIZHFyTnZtaWdNT2NSYnhnZ3JQN3A3M0VMdkFianNEekk2?=
 =?utf-8?B?cXhGUXBzVjlNU0xhUnN1dW8yeHp2RHJsbnNhRFkycndCNUQxWFJUelZvRFNV?=
 =?utf-8?B?TFMyNkFTWlU0aU5OMFdiVkFzd3gwYW5LMitvNVNmWmFKbit5OEhPazBPb1kv?=
 =?utf-8?B?VjZuZFBoK01FY1RwQ2p1N2t1OHdUMXFsWnNnNXdJc1ZSRWFrMlpHWHUrMjVH?=
 =?utf-8?B?VEt2N2FhS0dMTEh5LzcrNkNjZG1Ha2VVYXNQZzdMYmJPY0c1d3c1eVcvUVh6?=
 =?utf-8?B?M0hPTy8ydG42RUVjbGRLT29WK2Frczc3eGt6bCs1Tm56SmxUTVBPK1pxdTY0?=
 =?utf-8?B?TmtKY3cxdTdzSXU2MEJQSSt1SkFtZ3lrWklsWlh6SEZhVkJ2eS9paHNEREhT?=
 =?utf-8?B?V2k4VTJpa011d21iSjVIT1cyaFNHTzlNVmZnOVl2ck9sUlZwMmQxQ3JhUis3?=
 =?utf-8?B?R3pSWlk2enFhUEI0T2ZFdXJzZzgrNXZvZHRyUGswVldaeVU5T2luTmc2KzdJ?=
 =?utf-8?B?VkFMdkpOenY4ZnU1MHlKbnRxMzJtQjhON3lCWTJUQUpWbmZ2TE9lUFkxc3BC?=
 =?utf-8?B?WGRiejRGbGZmeFhMWjY3bzRDdFJkM1ZsRDVPbGpXQzJKWW13WlpGdzA4cC9I?=
 =?utf-8?B?T0VtekQyUmRpT3kzL2J2cFM5dzlxS2VCQmlVYUxPQnBIdWNwMFVZOW1jaHVO?=
 =?utf-8?B?TjhhNVZmN0dKT3FGV3VHMXdYaEEvSGZrMGt1RE41Nk9sem56ZlA0Mm53NEJU?=
 =?utf-8?B?SVlNR1lEWGFUdjQvVzZDeHdRQStyQ2I1NmhaRjB6QUs1aHdpMlI2MFlDWHgr?=
 =?utf-8?B?c3VQVW9WOWEyNnR3VG93K20zN282YzNKeEhsNGNZVFA4TWliNkZZR2pzSnRw?=
 =?utf-8?B?citNTEpOcHo0Q1l3cUJ1MGhrZDNwdzkrb0daVVBXTXA1K3lHQnkzVEozell2?=
 =?utf-8?B?aDlPa2NBejVPSFliZ3BpSmJXRjhEMVNkUjBwOVhpNThSUkhzRjVma05tUFBU?=
 =?utf-8?B?NlZ1bkJiZ1ZBUGFmTlkrdUJibCt0Rkc0TFJmWjh2aVNFQWI5TVhwM1daTGEy?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7e5fed-6fb4-4f69-579f-08ddf063c165
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 12:15:39.6229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IH9VDTZIB3NZfI1qHx4SiNWVrigDsTXh3vVOa9Hp8UUT5AqK/P4GSzapfuBlkN2WxWrsJJugJXsPfohWsRTQXKkK+nIUgvl5KBhDwt+qeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4826
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

On 9/3/2025 5:17 PM, David Marchand wrote:
> No need to redefine some VFIO_* macros that look like a define coming
> from standard linux/vfio.h header.
> Use RTE_DIM() and remove unneeded checks (like in get_vfio_group_idx()
> where j can't be >= RTE_DIM(vfio_cfg->vfio_groups)).
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
