Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71387E81BCF
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 14:40:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95DC2402C4;
	Mon,  9 Feb 2026 15:40:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 94D6F4028F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 15:40:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770648052; x=1802184052;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=YgDhGmooJI9mtcv5eKpm1Fo+JMj6ph83UC8pO8HbA/A=;
 b=MI2DNaw8r3HmJEc2+r2yc3VQsi9g0KfmfbI8xFX9aO+ml1+Fwz/Dlet8
 o4fwXo/E/kpc8VMuE1ouLTqCBm2No4mgwGxBADzXq9lDG5y0SAWshxjHj
 0RygwB1XVFNg/pB26m9lbaA03+/tr99Ad7kYn7OuEXyZL0rS5XgejcdX7
 fy7mcjL5DCMpD0iWFB+CgomYWpn+sghgcifA+oDk797oEodayXDaHRn0R
 R6r9lRxHKSieRQUaMZWvk5AXMsahfs/i+lXaCeRn/Be661hSFaWsS9oCP
 OlYIuEY4jIwCK4bC2pF+bFmU+0h17e3AqKeYJ0FoJlQwv9fuIg3jZZxup Q==;
X-CSE-ConnectionGUID: 3mO67Kp2QeqTC2Eai6YX4g==
X-CSE-MsgGUID: KMns7bYKTF2onBQFwLu+cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71481269"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71481269"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 06:40:51 -0800
X-CSE-ConnectionGUID: bJcZQV0OTvGFCSElBn1Gvw==
X-CSE-MsgGUID: HZIXLt2YTNOekYh02O7Onw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="211615105"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 06:40:51 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 06:40:50 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 06:40:50 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.19) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 06:40:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlzSRbguDR3MkC8hkcSPdAyBNikjxMSsI9IhKR75LYTKIs6I3gOlGgQ9xcY/r3FkrlktTaEQJ9325U0UCviu3U1eOHcKlQ40lplosaUcd1QL3dB/7vlBYEmtZBzeWo0ZKoc3gHunbBv7BaIKjG1FD0+Z9oC8zbE+NpKYdFfX07tXSGYHUSuAJil6ziHzvrUk9F0HnLgrIk+ij3lJ9N+0h22JuW2yey88WuU7orpGiffJEULfBZOhhAw+q4QdRBz7BRdcgaD9B09lpfSbNP831NUTrFPI8lrSEHor0umf+4XryGDd/AmTTdJekFGyvwiUHRua1h+err5MSUAu1avBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgDhGmooJI9mtcv5eKpm1Fo+JMj6ph83UC8pO8HbA/A=;
 b=YiVWCKl/eDHgsRmIhhdD+uUwCf5WlVj7CEdyTkILGuEsBfK6sOHw2GawC5k5VeZKyPn9iqIkeeV7zXlwNk6c6wv3nphn5mtX4+zLjNUavufM22POxFw4nlczdXjhRp4iYhU6TpI2ULMYETO2motTj0e4olkX8i0Y75FP8d4GZYSjHQVjbktmWfiYSZgM5ADzUb5EbtIfKjWBJ1acrJPbxhpXUVLi3F6jYabLc1+d7dlP+EQUMn5c8uspR8DkZcnkzHM8Te4mXqmlq9PJ6DMyF2uDMEjNquvnT5RVzmUonPXneZuMAV94JtOZBNo09m9f6QppJpGWmBe//e1jftX6ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 SN7PR11MB6851.namprd11.prod.outlook.com (2603:10b6:806:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 14:40:46 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%5]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 14:40:46 +0000
Message-ID: <d0aa8bad-2108-4097-977e-a594a64a36da@intel.com>
Date: Mon, 9 Feb 2026 14:40:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] net/iavf: fix memory leak on uninit
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Declan Doherty
 <declan.doherty@intel.com>, Abhijit Sinha <abhijit.sinha@intel.com>,
 "Jingjing Wu" <jingjing.wu@intel.com>
References: <a28f0e16fb83ef776eb5147ddda862d9ea742841.1770641909.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <a28f0e16fb83ef776eb5147ddda862d9ea742841.1770641909.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0190.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::8) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|SN7PR11MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e9bf0f4-a15b-4e66-64d6-08de67e93587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUFmVFl1VXhnbU5zUG4relo5S0JUOHAvaFByZnY2M1dlUlRXSFhNeW51Rldw?=
 =?utf-8?B?Y0FGQjdpV09tMndXQ0JlR1UrV2hyQmVTNk5tOTdhWVFlczA1ZmZTck96cEJ4?=
 =?utf-8?B?STVvY0lSa1ZuM3M5dTNId0tOMzJ0UlZwWmdKYzl1ajdaZEpnbFVaT1ArRlZO?=
 =?utf-8?B?TmV1SGxma0JsRERNQXRNa1I0NktyM0VhVEFIWkVZYUY5UnNXOE1CY2dPVXcy?=
 =?utf-8?B?dmVHWnFEZ0x0ZkxJc216VVN6WE5MeDFldUFEdER0aG1scURwUnNGTGIyelRS?=
 =?utf-8?B?cHV0R2daUVZ0QS8wdkx2R0tSQzFqTWYzZTc5RDVFQmY3aGFYZjIzUlZ1RWlq?=
 =?utf-8?B?MVZEY0trWS9vZDRReTBPd2FINzdRY2IraE1nS2wyN2NCQk5SQUNFeTI4Vmda?=
 =?utf-8?B?a3JYWjRIME5tU0t4NThEckM1dDdjZjlaVlM1cU9BNUg4TUpUcm4rdU9pYkNn?=
 =?utf-8?B?bUVWWTRhMllHYjBaNXVLS2ttY3EyaWVpZTRHemk5T0QrQ1g2TWNLWVFGNEdZ?=
 =?utf-8?B?ZjUrSGY4dnRUenU4WnJmamNsU3ZGOGJhenUzVXNWL3Q3bnhQZG1IUHl6dkFY?=
 =?utf-8?B?RTBXdUdMTGRNOTQrSUJFUnJRdVJtamp2Ly9pbDMrbFVtOU4zeXJEQXk1U0p5?=
 =?utf-8?B?Tmd0VXczV1EwdlFzajBuSGlHNkFtSVZyWjIya3h1ZUJFbEU2dy92eHRsSm83?=
 =?utf-8?B?NnNIdGk3U1ZObVZJZjNsMVdTQmkxNFN0ajRGMlVVdit1UXFYNXVPdlkwdzR4?=
 =?utf-8?B?ODFCMlErblNIbGUzaXIyL1lIaVZzRnpZY0tTU0N2bmdQWWFWK1B1VXNpd3gz?=
 =?utf-8?B?SVNWSXFkRGlQQ3Z5eHdiOWZ5elphWUFsTC80d3p2MU9hc09odTFBY00zdVM3?=
 =?utf-8?B?bzNGVXR4MjJGck5EZHhERGRXbldsL0h2MUU3Mkd0QUhWblFkc3ltMU5TOEpm?=
 =?utf-8?B?VStpVWdhVUpub2JFY0gwUUY2RUsvdnNYaUl4b2xCRXdmaFJON3JkeTJnMkhk?=
 =?utf-8?B?Vmw3ZktoUWx5V0hxL1VVekpQTDVkVWIySnZGTGNwUEdkRzhGUjkzb2VJbUg2?=
 =?utf-8?B?ZEpxWklvNnpvcysrOHlVa2hTQmw0NnRncmpsM25rY2F4S2Npb3l3MlJhMGNV?=
 =?utf-8?B?bTZKMTV2Tk43bFJLUjN3UEhVMXg4RlhOeXBCQjZLdHRoMlNDZlB0L2ZjU3VI?=
 =?utf-8?B?ck4yN2d6Qk5MaTNTZWptYlRsblVLSjZKQ0hLcGhLdW0yWEtYYTNadkxSY1pH?=
 =?utf-8?B?SVFyeFlpQU8yWTBFRENRQ2hWc0J4VW9Dc3I2M0l5NC9TLzVlalB0aysyYzBD?=
 =?utf-8?B?TlllaXVkMENtbGMxTU5QL01OVHRJMkVLVWVIQmV6N3dveWtYcWwrRjJMUHIz?=
 =?utf-8?B?NzVZaUV5NVpMWnAzOWZWVTg5R0crbXorZnNsMXRSU1FQbDlWT2hWYy9jZ1F3?=
 =?utf-8?B?TUZQaU5oNURlbEhvbFRTNk4zeVpWRld3REROWG5scUd2WGNKZlRBTlBpTCtG?=
 =?utf-8?B?UnRRV01ibWlhOHd3a3VERm5tUXNkMmlZS2dkM1dVZ21FVlNEVnV2N3I3YlB2?=
 =?utf-8?B?OU4wNTlFT1lmclhwTHJpNWk3dFFmVktxRGkvU0E4Y3BuU0lrVGhMNkF3VHN4?=
 =?utf-8?B?amNORFVWbmdMOXV2YVVrYjAreGxXUEZWRjY3a3kwMGZlaFNHOEVFckJ3bmhV?=
 =?utf-8?B?VXdFWVNqS3hqMVFPWWdCWjVjTjJZVGpZWWJDVVNMT2dWRVFwb0hWL2lmT1ZF?=
 =?utf-8?B?c1N4Y1BOTlRYY0ZzQTIxK3JITGFGR1lLY1VUdWdYN3hqTmQrUzZPbEVsckZS?=
 =?utf-8?B?bWJrOGs1TUZqYzJOMUE0MFB1OVk5VTFLV2kvU0dKVVJhczRVMlFOaXAydCt2?=
 =?utf-8?B?L0tEdTN0ZTRUR1JjSGVsOVJSNFBMSFRUSXpiSG5sK1EyOUtmVW4ydzVxYXNq?=
 =?utf-8?B?TzZOWlhWWElnMHREOUU4VmhQMm0vYk1ZMEJjeG1yU3UwcWx6WkVjZmNUSmZJ?=
 =?utf-8?B?QnhqOUtnbkluSk1mYUgyR2F5NEhlcmlEcFpIa0tuVFpJVDVWUGxwc05WWEVs?=
 =?utf-8?B?dVVtOEN2TXdpVno4ZjZZZWJVYlY3ZG0yNU9MRjA4UUtEZjNkb1lXUEtsQUZs?=
 =?utf-8?Q?v5tE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU0vS1BsK1dmbm1RdmhMSHZCalk4cXluVHhqbHZMcHlLNjNUajVGV2QyRVA1?=
 =?utf-8?B?UXVXYk1lWHN6TGc3aTJ1M04zM2lROTRZRWtRdks2eFcrWFZOdzQwKzhwUysz?=
 =?utf-8?B?UERjMmtiV1NpVUtMVDFXTkU0UjBIYVB1ODJrZWNvQ0ZKeEpLbHRkbCtPNW91?=
 =?utf-8?B?azVlK3N3WjVtTFlPT2NHalpCNUlMcDhkYzR1bklhNkFwWitwSU1BWUFhMkJ6?=
 =?utf-8?B?LzBkcGRGV3R2dzMvMzNCNkVJYzlLNkNiZ21GNDd0ODJ3SlZVNWJrMm5PbDI5?=
 =?utf-8?B?RXk3ck5lRG4rMVV0Nm1JN3d5YVFjam1vLzlPZi9TNzh2RUtBNEZFWmVlbWVS?=
 =?utf-8?B?a240eVl1QnlGUTg2a2pwNi82bVVjT1J4NGMwOE9IYzFRdW9kVVp5K0dkenh6?=
 =?utf-8?B?SGpmYWRGVFdHYmpvZmpQRHJPNURISTlQSll5a0VmMTVBOHFWbkZMeWZSQlpZ?=
 =?utf-8?B?SFN2NXVCVHVyYy9veWhVaFdpT3FmTnJGVkVtc3lya0ZVVVlRS2trUlRtNXFr?=
 =?utf-8?B?Z0l2TjQvMEh2S2JSdEtNY3lSL3hrRHBhZHJ6SXhpYXU2TW84QXBkdmNaUkI5?=
 =?utf-8?B?N3pGZUExTUNwWkZBTzdBVTlGb2pRVkcwem9MMS9YRmhHdXlWQ0RhTDVJbUVD?=
 =?utf-8?B?VVI1THNHTHpuY2ZFc3dVN1RiekFEY0gzbGoza0kzVi9rM0xleSs2bjVSWWhm?=
 =?utf-8?B?ci82dC9CdEpQai91T0hMSlIvbktwK211WnlWMVpFM25XcnMxMmIxaU1PKzVm?=
 =?utf-8?B?bnk4ZzhrSE80QlU5M1Rka2o3TU9ZQnp4TjF6cVJvMWRLTmRGbGRsb3NsMkNG?=
 =?utf-8?B?TGRQWHpXYjdUWFM1RS9JM1hIMjNRTnFsSnQ1QzhBRVZrTkp6YlVqK09DYjFw?=
 =?utf-8?B?V3phN0dWTk5aRlpuRmltKzhNYmordlpGYUdjckFldWQxUExoa3MzRndCRnN2?=
 =?utf-8?B?SnVQb2EwU3JZc09ZSWd3cEtoV2cyOFR4WG9iM05HTjU5QkRaZFNCUGNjM1VT?=
 =?utf-8?B?cTI0U0k4c2QrbVdjbUhuYWhiLzBheXF5TVJHNjVFbGxwdGdVazR1TXEzQjBD?=
 =?utf-8?B?ck5BWDhxZTl6U3ZHU3FBMytoYVVJaE5WM2x3c0Z4bDdneVhxanp5bDVJVGUv?=
 =?utf-8?B?VDRhRGZJUzhOSnVxUnNUOEZ6WEJXSEd6NWtDb2J4b1pNVEUwME4wNTg0QTFp?=
 =?utf-8?B?eVZDU3E1QVI0clRRcU1Zc0cxT1RGVXdBZzdMa2s4aE1acC9pWVdHTy95WlRw?=
 =?utf-8?B?S1pDeWU5b21kdGVnTmh0OUw4UWh6RlQyb0N6TlY0NllBQjBFNGE5U1c4a1VR?=
 =?utf-8?B?V3lyUnZDTDdkcDkxdVFHcjFibWJkVHZrVHhzMm8wN1BETkI1akgvUkNiOUYx?=
 =?utf-8?B?T1REME84V2YrVHc2eEpxRVdqaTBmanBiRXRUdmdjU0U5VDduTXppUVhldlJR?=
 =?utf-8?B?ZUVGWGZJTTJjRTFvanJiUVVpZmlqd0xPejhrVFpSWHN2cXZyRTlSNWFBcmx1?=
 =?utf-8?B?RTZxbGxiZGYwTFpJaGc5aUlhc3ZXUjVkeGVBQXh0VWlRUGtHRE9zTzhZaURS?=
 =?utf-8?B?RVd2cy9mWXBBM1dSUGJ4bm0ybG53UzNReVlrRVBhZ3NMaDhURDI4ejdSdGkv?=
 =?utf-8?B?cnBkQkx6WHZtdVZlL29XVDJ2RVI1dW1FYVNENlJrN2hjR3dYZTdZWnZKM3pG?=
 =?utf-8?B?UU9EQ21JeUltblFaaURrUXRQcUR6YjNxOEhxd25MUGoyZzgzU3dJUHJjY2xQ?=
 =?utf-8?B?UXg5bnhncWQ1cjVKd0FFdUdmcWNOVE9zVHlSNTZIMXpJQ0JDbHNIZllSWlAv?=
 =?utf-8?B?VHdUTlNpd0lHeTY2cVNZcWV4SUZpZ3JWR2R4N2V4Q0J5R0VsSFZlTm9YWmZp?=
 =?utf-8?B?Sm1oWWJza3lkdnloMGdMN2E1YW5GckNCWU5jZnl3MTFBWitMZ2lPNXViM01L?=
 =?utf-8?B?WVBsSzdwbUJ6ZS91eWZKeXRPbVQrbWMxN2l3cENBRk9mYkRRYzl0TGNYY0Z4?=
 =?utf-8?B?TWljNW54TEJ1aVJaYmlLTXJPbVU0aVQ5NTM2MDAwb1ZlT1JJQzRFRXVVV0I4?=
 =?utf-8?B?NUtrNElNcmEwai9HQUlHemo1NUdPbWg5ZDU3WWtHWmFDaXRseVREcXJvV1lt?=
 =?utf-8?B?OWZVMjllL2pxQ1BwRVNKemJaOWtHUm1iSDFVMGV0MGdHMEYxYkNzSGlTTEp4?=
 =?utf-8?B?SHVGQmdQMUhFanVUaFR6ckZ3OUR6b1UreS82bW9wckJOb0JHMFJSQnZ1MkJz?=
 =?utf-8?B?OWtuN0ptenZGd2ZDSm5WZzNHTDBZQUdobHd5MmN2V2Rtb0tsSEJuYktNTXdY?=
 =?utf-8?B?RGdRVmhpYWI0TWdzb1gwaFBtSjFnQmRmYkM1WkU1ams5MzAxYVFIdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9bf0f4-a15b-4e66-64d6-08de67e93587
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 14:40:45.9465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9NJXu3uZ8rD77tcepLj1V/SdB4noK+S836hkwFM0LgaVIZltNT11lgKQSecQDHDbfrAYg9hoDgG6GFqp1mHBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6851
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


On 09-Feb-26 12:58 PM, Anatoly Burakov wrote:
> When IPsec is initialized, parsers and engines are registered into the
> common infrastructure. However, during deinitialization, they are not
> cleaned up. Fix it by including IPsec engines in the cleanup.
>
> Fixes: 6bc987ecb860 ("net/iavf: support IPsec inline crypto")
> Cc: radu.nicolau@intel.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
