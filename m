Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708DECCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 13:28:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2D26406B7;
	Tue, 30 Sep 2025 15:28:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id C2C2940A6D
 for <dev@dpdk.org>; Tue, 30 Sep 2025 15:28:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759238897; x=1790774897;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=PQ5ckoZEGtr+YAWAyaqo60RdfAGhX4dMQ2r0E8s6ZvQ=;
 b=FX8G6n986DyHJZtiNqXV+DD3prcaYDaOUQkdIeQRgX2HZREy37xnH5Lt
 Vuqs/JkfgGAUSK7duGK0y78qRmhO6yLXJeyD6kStCEE6OVo44xDYhO7Sm
 bx7ggMcyKwMcHAPEFI/WwS2Say59SmOPkvUKRnGekqfrrrQj8zH6iPgRh
 2xpXbUebOiHHZYsHDs1aPz/iewwgM8Bgv/Yv1gvFLI5qy95cUy+3x9kP0
 fBuVu6VFgUL8wFxF6YoJ4c3DqWODbWV2pc336fvaN7PxLQHiLOufUKO+P
 vF+jwUOqP/iFUrmmcvfsgRrmWLyOEhIFmNuVvdsabEW4uxKM3u5+u970o A==;
X-CSE-ConnectionGUID: XvjY9MUiQlSofaJOtFLAjg==
X-CSE-MsgGUID: YW+XbJ9zRH2UeHrCqHgTFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="65352932"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="65352932"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 06:28:16 -0700
X-CSE-ConnectionGUID: qgtQYP6CTTqwpBE3jIeUbQ==
X-CSE-MsgGUID: qkXdRYsiSz+J6qLEbVKT2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="177645297"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 06:28:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 06:28:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 06:28:15 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 06:28:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTwnnzkORjgjMltRpZ1CSMbkikJNqGCcyiBX7p/mnBTEJqE7WOjIhg1rctxYZM1Kb5uqoifHVLrL+nrySwLz4SqMxolJ4Nb8bPELX9/8ZTUGVyT865mYKXD4ffFdmRqttmCABmyeEs99vQpEOLPQI6vn15oVby5OjcFEIXlVhxPmKGZWTSgw+bAjx3PM+2TYIyB1mQbfSgvoNFSH2xJUFQd8sJMop69VnhTi4kHyZ1i/0JD5YtoBAePbYqKbZiVlcRQW5i2/LCc9sVZZcNUn59WIu9GRwQTLoOrmWWB9iAqFB6MzJGocYun3MZMYg9Xm04xesoDIKox32f69KBR5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZAKOegONjssDIjuDK7On7VQA7mlnz8kPwIJKFIWkHQ=;
 b=lRMKpxIUxHM88vMMkn7uNFS24+KzXQw6kwNuI/FAtUXaUT+tPrrTuBLT5y46IOv5ZviAYMG3XwhxT951EUJVfJmCrG3Xl0UHqyCPW7gG8R+UCdi6URludjIwuHOpcjIkOaIJmzfVW5JwKMrTnXdqmRkfx0tVNXBCYU2h/CQIk/lZynNQbPGez9+PFlp3BOxuOOKQQr0ysdEhqzPksGEs0+XIrEuU2hU0T9K1u0PCP20DC9HybbjJie8izpajD3199bj4mpL9NOkDQwADnJ1CZk3ooo5d5c2rA4EEiiUg9TZ7ojemDHWT4PC2n/SHgzCwaHg52ZKcxwfQGs57IlJURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM4PR11MB6287.namprd11.prod.outlook.com (2603:10b6:8:a6::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Tue, 30 Sep 2025 13:28:14 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9160.017; Tue, 30 Sep 2025
 13:28:14 +0000
Message-ID: <343f647e-6a25-4641-9328-544e817bb53a@intel.com>
Date: Tue, 30 Sep 2025 15:28:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] net/idpf: enable AVX2 for split queue Tx
To: Shaiq Wani <shaiq.wani@intel.com>, <dev@dpdk.org>,
 <bruce.richardson@intel.com>, <aman.deep.singh@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com/>
 <20250930090709.2521114-1-shaiq.wani@intel.com>
 <20250930090709.2521114-3-shaiq.wani@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250930090709.2521114-3-shaiq.wani@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0131.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::16) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM4PR11MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c835c7-15bc-4d70-0d96-08de00253506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnBmVE9LbU9QNUJjajBnZlFBOWdPakdGMmU5blhHUHFzd1FhZ2MzV0xZVDRD?=
 =?utf-8?B?UGQ4aGN0Y3V5blRiOU9WMmg4aEYvOHBFSjgvRWRZWlo2WDNxNUxCM3lEQWpT?=
 =?utf-8?B?a2xRUVBySXM1eklXakNIc2Vvb3Q1ZDQ0Sm9IelpCUTF2RytzVDdjMDJqODZr?=
 =?utf-8?B?S2FnaXhJamZjWEJvSWVqYWpFM3pVNmlVVUd3OGRuYWt3QTk4dG40N0NrSmpv?=
 =?utf-8?B?ald1OFFkU25nUHJXeDdxSVI1dWYwL2ZoaFN3aXJVSnhLemZsM1c4a1BhL3J1?=
 =?utf-8?B?ek4wblY5Mi9SSFcyY3I3QzRRRTFuTmcrWFo0Y0tKeXZsQVdFRkNXNXhsS0Nr?=
 =?utf-8?B?WVhMM1ZUQTg3WkV3TmlyaXN2QzRsdSsxSGpwRFgzbG8vQ3E4eCtpSk9FdnZN?=
 =?utf-8?B?TzJQWU5ZSnZ5ZGVLWWFOSVB4Tm5zekVvaWREMGt2QlNQWEFIcjdhNTZhWE5l?=
 =?utf-8?B?dHIwS0hzTW9ybU1ZUDVZTmlYMW9FWEdvNUhJY1hSSlR0YWdkcUJSc1Z6aCs1?=
 =?utf-8?B?ZGNFREZrekdoWDJEY1huSmtZbDkxZ0lpOXcvTUNyRUxiSlFOUjZaZGJ2WWdQ?=
 =?utf-8?B?QVAvNFFVRDdiUkJObWNkOTRWaFNlalJ1dFAyc0l6aHlxSmxrMXlwcFFQaGJT?=
 =?utf-8?B?aGE0Nm5BZzZaLzUvYldSYWZTWDR5YmJRZXVjTmJOTndvMlNBNSt4QXh2cVBG?=
 =?utf-8?B?MGtaS3F3RmFrdVRQUHEzTjlUc1R5Qkg1dVhtMlA1RFljU204c0dTM2IvazM0?=
 =?utf-8?B?ZzY2bG5MTVJ0dUJEbVF2T0s1QUZnZUJFejgzRld5cHFBQitxQ1ZpR1BqS1dI?=
 =?utf-8?B?UU9QMFkzN1VlcSt5TCt5cFRQWG1aTTg4RUJTY2FKQXE1MFB5ZkJmZDd2WjlT?=
 =?utf-8?B?RFhoYWxBQjE1UE1lWGp6OHNzWFRpMEdrK3MrWWZDVDByMlBmSGVhaHlDTGdU?=
 =?utf-8?B?N2VnOGpVM0hpa2VTc0pvRFNUdVJ3ZEowWEFWL25KZmVmeEFkY3ZOM3NGWVo4?=
 =?utf-8?B?UytPUHdhN2tqQUlRZGgvOWE3b21rdm1UWmlpelVsWkQ0TTEvYjNFeFhGN1NG?=
 =?utf-8?B?UnhMUjd2OFpHR2wwR2Jaak4zbFVkNWttUXZzWi96UkJyS3hCemdUUUNSZTA2?=
 =?utf-8?B?N1ZqOC9TWG5PL0Ureko4ZU52WkxHNkpEY2wyNWhjQkhveThsRHhoQS9OK0xY?=
 =?utf-8?B?L0YxdWZ4MFY3YkVoM01Vem5LbnEyVEt1UzFBNFhNdUJzMzZqbE43c0xyYTdH?=
 =?utf-8?B?ZjF1YXlQSU1aZFhQcEQ3dVVxYnhYaTZHM0pvdE5PL2xDN0k3TzFZYW5nUnFj?=
 =?utf-8?B?Rzg0THZ4czc4R0lLWFEwUUsvRE1Cb3R6aDFsc0dwM01saTE0MW16cjFlV3dj?=
 =?utf-8?B?d0toMUNsTXBBMVVEVUR3RERtNUhxbFVhOWF1dXhxSjRpTFdEQmVNbE5hbTlr?=
 =?utf-8?B?ejBNL2dtZmE3b0NkV3dqOHc3RDZqdk5raXlKQkdmOElBOEdnR21HeFZLc2Rr?=
 =?utf-8?B?ZExMQXdscEF3TURoMEltelFqWk9TNmdPSVZtdkpVMmRpcEJTa080d2pCeWJq?=
 =?utf-8?B?a3lPd0VHUHQ1MzVNWHlXbTF0cjA2bFpnNDlIVHlIQzd6OWhDMDhiUldMZTQ2?=
 =?utf-8?B?azVmVDEvcTNHdzY3WldvejBXaVlOSTJVS1BGS25oWXhrT3hOSWo1N2NjbkRJ?=
 =?utf-8?B?bEN0ZGdtR0RGQXJDOGNvSHhDYXVyNkZoN3p4NUVSRnBvSitrUnM0Y0JWamZ6?=
 =?utf-8?B?YUJDbXNmeXRmS1p3R2g3Y2ZYRlhCcnoxVFoyNjV3NHJrbGNBUDk1cXkxVHVq?=
 =?utf-8?B?NUJ2Y01tdkw2VTI4clZYdHc2dWRseDJnYmJaM1dZai9DeUk3NVo5UHdxaGd2?=
 =?utf-8?B?cHUzY3MybnlBb21mZ3hIS3BTR04zdWNXc1hYeFBkSUkzUUZwdnR5UWp5bUYz?=
 =?utf-8?Q?YEON8jwRWntvLXXsjf4bDlci17EIBjEV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWtGUmlCTVJTUzFiTHozR3NyQi9pWWM3dU1IWE1zUHd3VVl4RTNMTlZUKzFv?=
 =?utf-8?B?dVBRVklSZk9KMTZtdVRkSTEvbUk5R1dQajJrTFNWR21YUUVaaUpVVGN6Mnd0?=
 =?utf-8?B?OWxRSlNmSDZpclBqYWhtS0RtaDRZWXBhNC9PZTRYMVdIczN1R3NGQlVhc3d2?=
 =?utf-8?B?QnYzOUFsMmg2RGd1ZnBzVGRRVTR5czd5ZFdaeWE4NUo2K1FmV2d3a1RFWUx0?=
 =?utf-8?B?b3RyaU1SNWRkVzVkdmRLZzVTZ0NDdDBpZ2FtNTJKaUtRU01XT2JaTlVNNnQ2?=
 =?utf-8?B?MVlJUmpaTnJhV2xYd3JHTWVNQWhCLzNSdlhyQ2E5Y0JrOFhORFh5M0FDTldU?=
 =?utf-8?B?N003N3l0RlFWa1NVOWpmTjhicUZwaFdSZE5naCtCSXR6VHZoTTFtM3hMZnF1?=
 =?utf-8?B?K1FyZURKWWlmUDhoOVZKODhPWksrdXhlOTNMK3ZqeVlJZEZJWkRyTXIyWXpY?=
 =?utf-8?B?N2tnTmdiV21LQVlTdlA3c1RjZ1Q1b2RXQUJWTHZKQXVWT2RuUW5HN1cwM2Mv?=
 =?utf-8?B?SzdSbjJSanU1Q2dYQjllTk52dk1XQzRzbzl2bFRWa1kzbndYb3FBSTQvZWw3?=
 =?utf-8?B?WEE3bUd0UEFybnFaOFd3d1BvYit5T3d1ZHVkVERrWjRVcENQWCtpdmlSQStN?=
 =?utf-8?B?bkNjVmRpVDhoQWsrVmJrNHhTNFQ2VXBzZk9LZGh0S1Yyejg0dUpVUmd2ZWIw?=
 =?utf-8?B?ZHBVTE12bGloK2RUTUpDelBwWisxcUIzSGh3eEdXZXpkZGJ2SHBkS2RUbThT?=
 =?utf-8?B?S1RKNTRxcWN1RmxmRjlzaE9LOXFFNllGeGJhbnk5d08yWEU1TDVEM1ZqdzIz?=
 =?utf-8?B?dXV2d3lhL1NFZ3lyQzcyOGlrc2Y1Wm5Jc05MMFRTYkFGZmt6bFQ2SWk1aXBH?=
 =?utf-8?B?RXNybnN0MmRrTjFhMXRGSXpCNUNpeEIrUFpCVG0rcTlkUkp6NTV0cURnemwz?=
 =?utf-8?B?L2hiMVhuRGhYUm9rWmhKVlpKTmxPaWs1TXE2TU4yMTdNZTc4V25rSFVKWUhq?=
 =?utf-8?B?ay9nZ3d2QUhNVVRXUmFEcVFaMnlldUF1NkFPTkkwOFJwQ1FQVFppZzBENW5L?=
 =?utf-8?B?bHU1WDNqK0gyYmtCOTFtcWk2Vm5XSDBqdWdoMWtRdlZuMkFpR2Z4OEF1SlYx?=
 =?utf-8?B?VWxXSEhGSmRlR2dHUUVtd3NYTXl5S2srWW94Ukx1QmtDL1Y1amhpL0ZQZXdS?=
 =?utf-8?B?QlBuemJySWd5K0dGU3Y5WGVuQzM1ZTRjcXlqcVQ0Mm1sWGF4WWZQZExkc3o2?=
 =?utf-8?B?dEtScE5UbXhWaWhraFd4L3lqWk53eFRNUkJ1QXhrZ0NqalJMZDlOREVNM1Ra?=
 =?utf-8?B?dG5FRWtzczFUNEllRFNZbEpUUHNJMy9iQ0V6S1B0RFhNSWlXVEJFRmhUcFM1?=
 =?utf-8?B?SFZPUVFIN1hMakFKYnJBRWR5N0dyaUJnZ0JFMmFVUlM2Q2tnTHRkS3lCandt?=
 =?utf-8?B?R1VVWnNJRHFhdldndk94aVZMRjRLbEc2ekpQR1c2Z2pnZ2RJb21jTi9aK3N2?=
 =?utf-8?B?MVJHbUMxR2dRM2oyRHZ3dzd6OGVpM0hLS3NFY0l5b1ZnaDZlTUwzSFhHMmhh?=
 =?utf-8?B?UmRlQmZDNGU2UURPRE02aEsvUERFM0JvTUNUclZJMlgza242anRuUEdkb1Vt?=
 =?utf-8?B?dUIxZEVvRmx0WUM2cTh1ZG91OUxRb3pUQjJsak5Mc1hpZC91VCtSTEpkOTRE?=
 =?utf-8?B?OHljUnJEN3lTNXc1TnRQQmdETzFDU3FDTGdTL25Ya0pvK2pBbGRpSXRKVzVo?=
 =?utf-8?B?RHZZWWVrQkhhcW40R1dRb2JGTFM5THRKeVg5WXprTmNuTWJ2UUpnOUVTNjFt?=
 =?utf-8?B?Q2R0R2t3c0FtRHZrc25yZXc5YmIzUk1rT0c2TzQ2emtFdHRpNVJ5VnM1b3hL?=
 =?utf-8?B?VW1xNjlyZ2grMFp0aUlrdnV4Z2MrWlJDVlB6Y29QdHRJK0NKWVNRendoejd1?=
 =?utf-8?B?WHg3Wjk3WXVYUTlLWk1VaDZUc21GUS9MaFJkRjA4WmJDR2c2MGVIbnQ3aXNh?=
 =?utf-8?B?NUhOSjJFNXIrQndWOWplZ2IzL3A2UVBZQUJmelZJQUlBUGkyNzd0eWc1TGhi?=
 =?utf-8?B?bXdLTWRKNU9VMDUvc0ZOZHdqQk55STBHY0NVVmdTb01tQVBLMUp1UjZFTDNH?=
 =?utf-8?B?aHlSVExKK0RwTmxCY2xyWmZndENqQWc3SzVFZUplbWRPcE1KZGZHcGZYS1gw?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c835c7-15bc-4d70-0d96-08de00253506
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 13:28:13.9458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3AjL7ZQfE67fVLbxR+yamnfXHWBPPdA9JTPF2lPGkukYykd8MTIr+CgAeKEUxiC38rMFu7bkoohjhuhvgzn4wK9kqnRIeMFQRt5TYCVwiM=
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

> +static inline void
> +idpf_splitq_vtx_avx2(struct idpf_flex_tx_sched_desc *txdp,
> +				struct rte_mbuf **pkt, uint16_t nb_pkts, uint64_t flags)
> +{
> +	const uint64_t hi_qw_tmpl = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE |
> +		((uint64_t)flags);
> +
> +	/* align if needed */
> +	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
> +		idpf_splitq_vtx1_avx2(txdp, *pkt, flags);
> +		txdp++, pkt++, nb_pkts--;
> +	}
> +
> +	for (; nb_pkts > 3; txdp += 4, pkt += 4, nb_pkts -= 4) {

Nitpicking, but in some other places these '4' constants are used as 
IDPF_VPMD_DESCS_PER_LOOP (or IDPF_DESCS_PER_LOOP_AVX which is 8), so it 
would be nice to reflect that in the loop header, e.g.

for (; nb_pkts >= IDPF_VPMD_DESCS_PER_LOOP;
		txdp += IDPF_VPMD_DESCS_PER_LOOP,
		pkt += IDPF_VPMD_DESCS_PER_LOOP,
		nb_pkts -= IDPF_VPMD_DESCS_PER_LOOP)

Then again, looking at other places in the same file, we do not do this 
consistently so either way would be fine.

-- 
Thanks,
Anatoly
