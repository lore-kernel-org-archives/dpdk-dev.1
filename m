Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E33BEA8112
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:30:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58864400D7;
	Tue, 10 Feb 2026 14:30:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 5F1FE400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 14:30:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770730211; x=1802266211;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dPhr9fTE5r1bfZUUqEUjdF48ZH/Sw3TTpX6ZQmjofjU=;
 b=m4OXitYW4QznkQJYi2Z7g0Ncq6lTTNV6/bkYYfz9gbxBRlliG3ZqHXVB
 s6oz8GGXOANwDBSnDArTc6Tm7J35YaXi0rI+QllMg/NPDmzc8NLLNt+y+
 5CfhOSjn1t7UL5FCNvGtjKBjTPYTmy2+CmCrpE0Y8db70ylkBLWB7bFWQ
 oRcLpQZl2u3jDGRJTmhkqlvwvxrfNgzMvo35QcyxDZkHvLWG6trERDyd1
 /10/eUDhOtWC+YWhxxOhbg8RqIacBDF7pyN7J7Twu1h7Y9cOEOh1nG1l5
 Kf1YWu4Vp+DikKkdr2RtquYGghaBa2CaQIrzq2B3Q58f9l+o2VTRjrKp5 g==;
X-CSE-ConnectionGUID: 3hHYoJGQTv2hX8/XAW9mfg==
X-CSE-MsgGUID: vUMB2MOYR9+dv0i8veVxYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71927865"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71927865"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:30:10 -0800
X-CSE-ConnectionGUID: 8dUy9aIGQEiDkxuH3aathQ==
X-CSE-MsgGUID: Soje0mHERgaLLrZmaX0LLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211998132"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:30:11 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:30:09 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 05:30:09 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:30:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkeI/mmZK3hOCw2bBv4JjZM6+aDWVAaKGcD70x5lTjYd5HM6ZsxVN3GJM8Tv87YTF9+IzyPsWjPd7cP9d6/V50fdLJ5qlr4yuU42c7JxvpVjXXtsJWoKzynz7nRpCKIK2TiFkkNgD9mGuMMbJgyTxLQLUzmp4fISS21eJZnjfboFYAvd/NEcIWwnHz5NA48U9WRKWtbsgzsJwWJnnbBsie5AUFrWM535u/+d6KazKBKpgfb+zvroX1g7oj+lDeq4MiMnpeimJLQ36cbR+qVca/wNNGJTp4aSXGL728u4vU9808i8qytAv/qI+JmGIKASnoppVvgk/HOmTdk253kTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwmAGQADCZOgUckV1SSHWJ8QHmWZgc1n2kzHeahRO84=;
 b=UbJY3JTnReTRckY2/BKiHqj7OWboHKBT6KN6mv2UfUeYFCCRe0D9Wl0d23kCkbPbA1FgB0/2yFbXEBi0pSe1ES5csdVtoIxqU2SS3ipVzApYzejxrwS5Q/YxfGKX2/+W5xvX5bNBsdkKaT+cEvn/PpgZd9+ZzQ7P4k1x2vvk/fCw2JU+QyiEgIBxLMWE9jlLpImNf5fzW7EgrdWllNKlExfVcBnAZ51n5/rYaeJ0vbf7OK1Mx98CZFOF4gPPuRHC+Z953skJBmgXwftorn4cMsyL9Ox+B9c7BOckJiM7uaT8CF0aQew6SCJyLeoUzJYR7Sgv1ketTnQ2HoSwWu4dhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ0PR11MB6766.namprd11.prod.outlook.com (2603:10b6:a03:47c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 13:30:07 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 13:30:07 +0000
Message-ID: <014e744c-45a3-4765-97b9-5f861d722633@intel.com>
Date: Tue, 10 Feb 2026 14:30:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/35] net/idpf: use common scalar Tx function
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-18-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-18-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0078.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::20) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ0PR11MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: a256afe4-4cc9-4c06-0a63-08de68a88196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b09xQnBnMmljcUZmL2JLbkQwTWpVbEk2RXhwVXpNYUp6S3pJYW02allzMXBB?=
 =?utf-8?B?UjhiMmszYzIyRk5rZllYYUZDV3VoYmIydDk1aGx5a1V1cnNNV3ArdTA3NUtt?=
 =?utf-8?B?alVsY0N2Rzc0czVLVWRmZlhwVEk2a3FYemd0ckxRNXJ3anBCZkRCU3BXUUsx?=
 =?utf-8?B?T3hoM2YrOEt5TFByZVlzeGJrSGJ4Z05TV0JDU2psbjVoWElqYmhEc2tHcmNj?=
 =?utf-8?B?U1FWVDRUQnV3NitxVWxkYWFFSzRsMGwwZ1RrZzNyQ2Y1eGN3SmpDMGdnbk5E?=
 =?utf-8?B?VFBmZ3BkRFhJSzZNcVB4KzcramthaXZFOU5MamRpTE9YbWw2MDZnQ2lZWXlK?=
 =?utf-8?B?RC9HVUN3RU8zaUZCV29zR1JnNE1zMHVwSDcxQ1hrcmh6anMrYXpWRXZEd1Zs?=
 =?utf-8?B?OWh4TXVHWXBFYnRpOFk4YzAyTjYvK1I4WFRvRitxMUFmUjcwb1BNd0VSMlBT?=
 =?utf-8?B?L1JCaWY1TGUrK3diZHBNbThnYStZdTNHKy8rZjcyS2dmTkU5SDhhc1NuM1R3?=
 =?utf-8?B?akVIL3g0dHFHRXptdXVpZ2d4ZStuLzZrUllGZG03U2xuZHVGa0JKSDJtNFdl?=
 =?utf-8?B?VjlZYmdDVk9qalpUVUY0TmN0VWJrd1NQZjQvNFBxR1N2QUZNMFNpQXZIYVVZ?=
 =?utf-8?B?ZE1XK3lZbFBpUE5DOFJDZjgvVG5YQ2lyYnQ2RXQycHcxR3M1eDBvaXN2TitX?=
 =?utf-8?B?dnpsa3hMdkFPUFFFdE5wSkZjNUd3Q2diMFpJTnhZbWtCVlBtajJFS0NMd1ht?=
 =?utf-8?B?aHZDblNuQnRnYTFwaEdzdnBlQzNzeGV3eGtwQmJJK1hRSVdBbTlDV3FNYXBj?=
 =?utf-8?B?YW9lUmdCRGtnWVNEU0dXWGtISUs1c0RYUS9wRlhRRllOSjlhbys1V1l4ZmpF?=
 =?utf-8?B?VVhZa3BRMTRGZXhRc3g0cm8rT0V4U0lORTRzb1l1bUhYQmRYM1ZBcjJFYkpK?=
 =?utf-8?B?cExoOGhVVUFtTGRPS2NYc3h2bWZ4eUVWUy9HclY1akM3UWVRMWxrcGxWZE5u?=
 =?utf-8?B?ZmlmZXpoOFROaTdSd1dwVXlsQTdDdW5lSkQ3RWZCR0lkU1ozZC9ZeWx6RnJC?=
 =?utf-8?B?andGZ3dqbW1XY0YxRlpscUdQeENoZE1qTEcyK3R1Z1AvYVRoa1VESTlTZTln?=
 =?utf-8?B?RlRNWFRWQlE1Skw2NlpXRmZQcDZMMDVjUHBUZ3BVMGNLcFBzZ3NOUEQ0cWR1?=
 =?utf-8?B?OWhxT3hxVU93MW41b1d1bDhQdWZmalBDNk0rU3lCNHh6ZEc0WlpRenRXSzZa?=
 =?utf-8?B?ZFpCTVNIMVNxTFhYQ3Z4QnZjWWd5Zk8vY3ZibVZCcG81SDlkazZTa3JwRFJv?=
 =?utf-8?B?dG5Gd0hpMkZuYWhJRFRIR0xKUXpBdGxxS3BQaVhPSFh1RW1GdWNVWUZBdk5l?=
 =?utf-8?B?c2pLZk5KOE9QNTBGMjVlNkhiemxKdlBTVzZOOTNXSWxZUzVvMXo2VEpNUzUv?=
 =?utf-8?B?YzJEV0o0YmdYSGp6dWE4bnpCOVRjL1VkQm1XOGJRQS9VOTNaV09raERsa2k3?=
 =?utf-8?B?S0JLNjRYRjU0a1JxWVVEWXpWaEpEWG1NSVJrTFBuNVByQytMZi9OUmIvbzZH?=
 =?utf-8?B?NU4zcTZjOFo5Y3hoR2pMMEtBRzFGRGpVZ2wrQnUwZUg5RHJGTytwckhMNkJt?=
 =?utf-8?B?bGVFQUsvNFRFSm40dWxiZGhCT3FRRjVtMk9SK1lqaW11Z2FSTVpybkVwcjdm?=
 =?utf-8?B?VHEvemJjMG1SQzAxTzBNaEgva3p6b0x5UXZXekFHNkZjV1lwTE41SlNpNnN1?=
 =?utf-8?B?cW9kRmM0eVJMQkxJWkkxMEZqeU80YkNkUDc0alhyNWJ5QzdZS3lEMkIxejdM?=
 =?utf-8?B?V05yR2JRS1c2MC9oNW81Q05YSlFTS2V3MUlPVExvSXdzcldRTUV3VmVyRnNY?=
 =?utf-8?B?NXh2NUIrK3pyUGpqUUlnRG1qNEc3RDN2M1hoelM0VEpXZmdzRFl2cnJkUUFO?=
 =?utf-8?B?Z2hFWGoramhUNzFhRHBxVVc5S2V5WTRFbTJ2a2ZseUlERzVjRUZCM2hmOENy?=
 =?utf-8?B?U20rSURhZEVqM2F0YmlWRUJaWEpyV1NSTEFtNk84UzhOdWNqLzZNOEZNL1Zw?=
 =?utf-8?B?MVQ4bFpOSk9Hb2V1cUtNY0huVFVzaHhKK01hZ2ducVZpQ3lWWW1jWUQ3Yjc5?=
 =?utf-8?Q?PltI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2dNRUpuMklmcHpFaUNaVVY3MzFuenFvbjFYRnVEUVZBL1lyd3J1NWFpUjYr?=
 =?utf-8?B?R2JobENQNlVZL2pNK2FSS21yZ1IyUWNwRjNUWk54QmxYbEJQSGRYeVlsWi80?=
 =?utf-8?B?RkJKMXRTbVlhMmlYKzFkQzZLK0xZaXIvWjhCZGRYZk9aaXR6WDRza0JpZmlP?=
 =?utf-8?B?OWZSY2l4V0xhUmRNOW9yeG51dzhKVTRXZW80QzUvUCtzMnFvTGdjYmJSNTNj?=
 =?utf-8?B?aXVmMHBjcVhyaVhON29RUzJOK2QvbmJMWXU0NTdHZVY1WVFxZ0pHcktRMytG?=
 =?utf-8?B?Z0JjZU85Z09DNFRrVU1SQzkrNUw3R1VESGVOVDdSOXZZc3hDdVo0UHA1REJt?=
 =?utf-8?B?QkppR1NoUlQvMElJU0M0YjVjd1ZuNUdaMTN3L3Zrcmd4T0lUSHVEbFd1Z2w4?=
 =?utf-8?B?djdsS2ZGV3h2dit0WWJZR2hJc09RckM4ZDVBbnNERUltZlZEM0lMMFVzYk1q?=
 =?utf-8?B?QVkrTFFIV2U2bEg0aEI3cnZSMlNZWXFocHV6S2k0M2MyVUY0UmsvWjBkQ25t?=
 =?utf-8?B?N0xqM3VtZnVmWXR5VGhxdC8wS0ZYU1FmQXB4VnBjMDJjY01HLzJKWE1TU0g5?=
 =?utf-8?B?bXRPVGxIQkorZmloUVNrWS81ZEd1ZnNkQ3Z0NURNdndkdkMvbVhMNllPTjcw?=
 =?utf-8?B?aTBuSVJRMTJ2azBHQVNmWHZ3QzhjR2hndU8vVXh5aUFyaW9JWW94WDhJR3JL?=
 =?utf-8?B?SEJFcXJ5dG9ER1NnUXhWUHg0TU1hVFdIVkZVeUVaMnY5b0lhcTI0TUZPamMx?=
 =?utf-8?B?ZHJyWDFlTEo3NnhycThDZFhYdm0xNFpjZlNiOXZ6dzJSbEphMmdiZ3dtblh2?=
 =?utf-8?B?YWZFUmQwUS9pZmhmYTl2K29EL0wyM2EzdXBuMHRFdWJMY0dndWh0ZjBHQjJY?=
 =?utf-8?B?cnY0T05HTzNpVDJiOXNPNTV1bzd2U2dVRW92YnJsWHJKK2ZPem1jZDFVMzlH?=
 =?utf-8?B?RXNzT2ZHUjJ6dlZYanJrSDZZM3VFdVpobEVhZWtNOUExQVNJaVRQa1dVQ2Ew?=
 =?utf-8?B?ODhCNGJkdjFDdWFYMlFwNmVBajZXdCtqQldGdDFrdGV6RTFWdGVYUVpRbVc0?=
 =?utf-8?B?bS9Eamg3eUExZTlVMU95THl6dUl6WXNwWTdwdkUwK3ZvZVdScmQ5S3ZhMWRT?=
 =?utf-8?B?b2thbXpodWRxNmUxWThTV2E0K1lzNUI3NjNQUXdablZmb2ZoaGxHbVR0MDFE?=
 =?utf-8?B?cXlPaS9sZnIxNmRwQTQ3YytxZlVKMUtQTGhlb1VaZFM0dHYzaVZHZmNkWURL?=
 =?utf-8?B?aHg0UnhMSytjV0lKUUtkOTBFdFB4bTJNQzQ5TTd4ejBMUzZueFNEelBoOGF1?=
 =?utf-8?B?NHN5RW10ZUt3eUVYTlgxRlpGaWczTFM0eDlwWU5zUGhuZjEwd25tYTJjNDNl?=
 =?utf-8?B?akhXeUhhUmUxYmxkaEpRaTlQejFzVmRHRlB0dzdmSVBmWFZYdXlzUEVtZWlI?=
 =?utf-8?B?T1pjdTJBNVU4emhTOWlURzkvNCtEUzdNQ0xkWW1NaW1hWkwvZk1zeTNEUzdS?=
 =?utf-8?B?VnlHTDdNUUhLbHJtNzh1TnpxMENkeU1ZdXE2c2tibFpCY0lTZ1J6SXNaaC9B?=
 =?utf-8?B?dUQrSVZmWmN6cHUrQ0gxUUc0bjExa3dqYmxDR0swWVRSQTdOTmdDVmdOMCs1?=
 =?utf-8?B?Q05RWlFKUncydkhEMEJJQlkrc29jenpNdWNSZWRZT29zakg3Z0RhWDBCaHV5?=
 =?utf-8?B?YkowUzQ5TkExdk56OEFQRi9ReFYxbWhDYk5GOTRHTDVMTWZsaDVPM2NzdS9p?=
 =?utf-8?B?OXJlS1dMOTZ3Rm9Jbkt4L0dTMHQzd0l3RnRiVFFQRFZSK1V1YUU0c1dyMEVN?=
 =?utf-8?B?N3duOXlKOXJEZkJTTXZtMTNwYWR3UFR4STl6Y0JQYkk3VFJ5UzBSeEQ1U2RV?=
 =?utf-8?B?YkJ6djJWdHRiZTYwcVJvUmJxK0NvWmQ3b2ZVcG5sZWQ3dDhVVzJzKzhXS1dm?=
 =?utf-8?B?Snk3cXhGYXlnMllONjdRd2plTEhEb2g3TFVQL2R5cE1oYTArYjkxUEhVRnVG?=
 =?utf-8?B?U2pyTnptRGxKKzRCRHNrM1QwN1YveDZta3BjS1Rpc0EzNC9tNjRUa2VZM3RH?=
 =?utf-8?B?QUIrenI4L3k5dSs3cFpibkZZN2xZTWZDTG04NUthTVZ1U3ZjbjdCNzAzNm9X?=
 =?utf-8?B?MFAycExtc2VHclAwUnFYNmI5Z0QrTEQrOE00N05xZldWYzNYZ2RrVnVQSytC?=
 =?utf-8?B?Mllpekt3ZHpwekcrRkg3WU0yRmdxbTA3Rzhaa3F2bEliL3g1ZVJra0ZsVFVt?=
 =?utf-8?B?MTBBQm1kK3lzeTVJanQ3V0pWcTdBVUJzZ29odnlYVXFlaUdJMDhkNDRNL3hr?=
 =?utf-8?B?NDg4RE9ncWF3a1JwcGo2Zjl3U3pmL1A5Y1hKWEtxZ1FiTHNDRWR5SWlMQ1NI?=
 =?utf-8?Q?jVUcZYtGHVYFXSrI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a256afe4-4cc9-4c06-0a63-08de68a88196
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:30:07.4303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDNKW4P2ndIuGTBXni95v8YP4QXDztCf1n/EVMbKfelttQsZaCp+u9FdxKyuFAfkfXSkcLMu7IVXDiiQuUFpfwjrGLVwixb4Wj88bCdG4I0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6766
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
> Update idpf driver to use the common scalar Tx function in single-queue
> configuration.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
