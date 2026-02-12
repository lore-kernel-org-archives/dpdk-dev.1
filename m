Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3290EB4913
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 12:30:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1812F4027A;
	Thu, 12 Feb 2026 13:30:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id A819640268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:30:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770899420; x=1802435420;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=obw4mfRQYWEu+pLbLy84EdyU0sfgTfIbMj+U3l3/UXQ=;
 b=du8fZ1MHGRiNToXwrIhfrx2yJjBRasx1dBTmbI7u1LmbKnWI9MWtXufh
 jbePtQR7X6Q+COAfuePBoruCG78leF0VAJ34icvysXHQoqY/fEcRmSVI2
 kzYhMcjYM1RNM096mATvFg4HgoLzXsDgSxlBArzR7yk5Q/TMkeAZm9UUI
 3RtCyWsu9HVa7v1wzj821TNWx0B15pLCLLriaP44pkFuwbaHieEUaVwmv
 5/+wPS+7FeE+c7cAbMY/CiHzaarjCqiGNCPpmEYv74wE3EoaNbl4GWjV5
 2wjUstlrRwMvViMrR+gf/cfEed+CCtMcIftWGtzzeGI+bmXqbblVofk8i A==;
X-CSE-ConnectionGUID: xiV6MV34RKONpBttwyYGhA==
X-CSE-MsgGUID: twSs61doTX+Br0FWy9+/Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="75913134"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="75913134"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:30:19 -0800
X-CSE-ConnectionGUID: nr4Zm4yPQIKmjq8CLes+RA==
X-CSE-MsgGUID: YWh/hvLrTJ+8gCWMA59qTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="217063295"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:30:19 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 04:30:18 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 04:30:18 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 04:30:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0TdjzAYgjaR5IZrbmK2YM+JXX9p6uERHdyWlg8ZLNLxVO1QLx1UDAE9etonc5YfVMNgwvT/BSeqSfi/VUsW6l/kDLTPUkwe5NqmbARyLQ88TvljaFNQdWlZGB53ZppxXxTg0HPXcrSANr4bhGtzhW0Ny7r9r724cmsqV6FpkSbgno7z0LgLmhlzGE0CWiBfTdKW73N2ohEsjh/J7HMXTXcTsx2YWwDEscALiHzqAUef+FvgClmRUkDma9aq4zLuX63l7IXUK133gdHpCdr8BuS7LQ//F320s7i/5n25srzM3eEbS3VcUZv773xY7tiHjtkCMfzcLHwfmsAsgpHj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gokdtzBgjiV1wGzngvylWBrJlAdkXLju1QN7w7nM09U=;
 b=rq+mHAdJswCBT8LMhwafoDymh6VOSt9o61Mzz0c7VVDQ4DTgmOECM540ugbNr5CsQwFwt6Ew7uJOy74xWB2+9cZAjDTJPTv/RXIpkS3TaTqGUbKdWY0SKvZebszlAZhvmesC5IA8p50T4lQcIYghl47qFRlpY6pjyWrZ3eIdu+uJtvXvKB+wBW33Q2qG9TwqCC910ddoK1nZdCNw4yooXskKnVGql+a+9+BmgeewEKbsBdoy4ugoGallRmy4JwLqCW95KlgClvr1F4VLrHGfjLnHE26xNJ8vFOCkzs2h447F7WRnzc4KSloOoUcBtPqtp3SuqHVrvluu71vXOBMSVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA0PR11MB7934.namprd11.prod.outlook.com (2603:10b6:208:40d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.20; Thu, 12 Feb
 2026 12:30:16 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 12:30:15 +0000
Message-ID: <3f8ffa56-e902-47de-a39f-68ec6c3ab05a@intel.com>
Date: Thu, 12 Feb 2026 13:30:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 35/35] net/cpfl: enable simple Tx function
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Praveen Shetty <praveen.shetty@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
 <20260211181309.2838042-36-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260211181309.2838042-36-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0564.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::17) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA0PR11MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf014d2-b83e-4da0-e314-08de6a3279ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXEzdytieEh3anVod3FuSmVqM1IrSGdOeFU5WmZId1N0aHV6V0ttYlJGZW1j?=
 =?utf-8?B?SlU0aUluS2RoSXBNUnV2WDNPSmRQRzYrYWdIYUloSEdtRGxyNkc0RzRYbi93?=
 =?utf-8?B?TlB4RzFtdmd2OG5YdXhuenNhc2M0eHRRVFovUFFYcGFZUms4Y2cwNWpXZnFF?=
 =?utf-8?B?cTBnQlZnZlkyR2t0L1kxOFB4bTRxN0VwNVVyZVBZM080Y245NTQ5MlA0MklK?=
 =?utf-8?B?WTQyOE5YcEo0VGpoRDhsd0RJS2VTZlBEU3R4dkhVV2xNaXpSTUR4OSt1Smo5?=
 =?utf-8?B?K1ArZ0pKMVE1T0tQejFmcXdXSmtZeTdacUprdUZIeXpXc2NWZmJzUnN3M0lu?=
 =?utf-8?B?YmhYZ3BmVys3bWUvb2ZtV2grb3hVaHl1T3piV2xBbldDenl4a0FLMDNqMytC?=
 =?utf-8?B?ZVBRbmhRcEZzaWJNS1RwOHFjWGJxNDZDQm5iUnZ0WFoweldnN1VDQkVVblFq?=
 =?utf-8?B?ejhqZ3p6NVJIZC8vd2RPbENPb1dCT1lCMkhZOVRPMlJMWjBYbHA5M0owUWJB?=
 =?utf-8?B?Q3krbDJ0K3M0cHhSSkdMZ0l0RUFabGNRSC9HSlNaMHIrSlFJQ0g4aGgyL0xl?=
 =?utf-8?B?Zks4OHBYb0xXalBzMUhWdUNwOWlKSTk2R3ZLTkhab05OSklVL05iZWJlU2E4?=
 =?utf-8?B?RmNZbXl1OSt3OGhNOWhTNmovY2l3Yk94d0p4Wk1VQWV2VDdhbVJtN1VDa09a?=
 =?utf-8?B?UDM4ZWlGWnNRTjhuKzRBM25xMEViMC9VOENJZnN5Zmo0S1pIc2V3LzR0clQ5?=
 =?utf-8?B?RkZyb0NxUDdWWnhsT2FxTlc2d0l5akkxUW5HczQ3OTFHa0hCY0JrbE5jTlRJ?=
 =?utf-8?B?R25MTXg2VzJYWWhyUzNPai9LNnFqMmx0TTlFZzV5dnpsYlJmZlA3WTRreENN?=
 =?utf-8?B?SUt3bVBFTk1NbWRCU29SQk5hKzhsVm1mK2V1Yjdkb00yT2FUcFlYaTlteUlI?=
 =?utf-8?B?UHlhdGhlenZkdHFCcmRtQ2hNdmQ1bEt4WXFDNitXQ1ozTXdsT0JWQ0NLUWlG?=
 =?utf-8?B?c2JqbmQyOHlTQjVON1Y5bjZnbWJIMzBJa3NtQmphek9qODY4VkdyUkFvekxL?=
 =?utf-8?B?bktvNFdiS1QrWnFCTWovdE1yV3NwV2dnRHZjQ0dYVjIzTk1qemFZZFFIakNi?=
 =?utf-8?B?WXR0cTRYeDEwMWo5aHZUSWFNUHFQc0xaOFRIRENaZFZWMG1PdDdjczlVY3NX?=
 =?utf-8?B?VzhZZWtvaWlXY3dqTmhXU1p3WW1qelFKWmpoQjhYWFo1bk9EVFlkK0lMTDRG?=
 =?utf-8?B?eDBFN1Q3YkNjb1pKdXVrK1lqNVZvQTZUbTVnVko5bmVJVWQ5OUk3WDJDTXlv?=
 =?utf-8?B?NE1ZUW1haWxlR1RWQWM3NGRnLy92Wmc5UW4rQVlqQU1QVlJ2VmdqNThOUTFN?=
 =?utf-8?B?dmp5eVVwaVZ1WWlid0NQNzZFUjVIN2ZQT1dnZERJbDZVWURZWFg3Mm5kRk1V?=
 =?utf-8?B?K1p3RG1MelljZVV6TWo1cWg5UEZTNlFKdTZkRXRacFlDSzdtU3dyN2tNeEVv?=
 =?utf-8?B?MktsMVpmTHkvUm5YWDI1ZVJKY1N3QkltUWovUzl5RmVNc1I0T1Y2TE9VMm80?=
 =?utf-8?B?U2IzbGdBT2JGdENydmhKeDRJM01KeFRxclJmWk1JOHQ0MXdIVDZpQ3c3V1J2?=
 =?utf-8?B?UTk4RHhvMk5WQ2VmcUdXOUpjOWFUMHg4OFRNWlg3L3FrdFZvcFhXMVphWHBw?=
 =?utf-8?B?R3ZIYXpqbjNnTk41TnpwQXk5T2ZHUHJHRmhUUUIrOUR3OGZ3OUJscEVZT2gy?=
 =?utf-8?B?VHR1d2FqM2lSa0s4MWJxeVhyQndZeDJ4dE9WdGo0TittRTRjME5VTHIzTjV1?=
 =?utf-8?B?N05tM1ZtTnhZVGxVZlpzZDFZT1lWSEJqbVdrSUFTNDNQZXNSMmZMNDdqQTJ0?=
 =?utf-8?B?VWoreDZlWlZGcG0zRUhrK1ZFbDNYdkp5TDJvUW85MUJCdSt0MjlUaU9TQ2VQ?=
 =?utf-8?B?c1l6SFVwR0Q4SURkeVl3ZGdWOUdrWlg2SVA3NStUTWNvbUtSN1oyY0d2OHly?=
 =?utf-8?B?d1Bnc2VGQ1FoVUxXVVgwWHhpYllRSVhBVDhSNGppUDJQQzcxdnR6dVg5WE1u?=
 =?utf-8?B?YXk5K3Z2eFBxVUxHQlFkT25GWFZrQXhleitlSlhTaUVWMmp5QjBVK2dpZFl4?=
 =?utf-8?Q?5a+U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHRtOXRMRVhtOUhWRE9GZjd3U1hjSkpaWTlJdnVhUENKQm9JdjlQckVoT3FZ?=
 =?utf-8?B?WG1IbkpZS093RDhqMlVTd0c4N1RKVUIrMGpzY0dWWkgweDY5TkdWQStaVzFu?=
 =?utf-8?B?Tk4yLy8zU0dJbEM2MXpzem9JUmNwWjd0VWQ5WEVDK3BpSk9aMy9QSTZrMEth?=
 =?utf-8?B?ai9Ld05CSU9adS9mSmNIRDdDUGtrZzVPdTlobmJBRlptek9Yd0FMclUza3BL?=
 =?utf-8?B?YmxlRHluWnlQSUwzU3VGNFhGV283M2ZVbXpJTXdHZzI1MHVKdlo4Q1pMNHVQ?=
 =?utf-8?B?aTlnVmlnbkFhL0RSd21reGh1YUxlTU5qWTFXR3BNMCsvOS9oVVRvdWZicUV6?=
 =?utf-8?B?Z3ppeWt6dm5uQ2Z2aU4wZ2FSQlJCWTNWNDgvdzN2a0pKc2dWbGRETFE4WDl1?=
 =?utf-8?B?eG1qU0NsbWFiZzNrYXJpaXNra2VOckJLOUJMekxwYXU3cm5mdjFTcktaMEdx?=
 =?utf-8?B?R1NORjBqWHo2U3F1K1YxNzQzUHRLNktXRHJOYklrNFZyRDZJUFhRUFZKaGl1?=
 =?utf-8?B?ZlRKcWdzdmRrTmdzNTQyemxUZkdZU0s0RXNYTnZOc2Z4c01oMTlBNjRMN2Jh?=
 =?utf-8?B?bGtPT1hHZVhldWQvWjluNjl5VHhCWjhLMlgwNHRESWp2RFlKZlRxT1lnRUw3?=
 =?utf-8?B?Y3g0K0ZkM0pWWGR2RXozRHdFOFRWaEhxbnNyNGx3SklxRm84Wmdteld2Z2xE?=
 =?utf-8?B?b094cjkzU2txS0ZKT2RqZHY1cy9uT0NOQTBOSW9obXJwUVpwQ0NKMDRqT2Fs?=
 =?utf-8?B?ZmlJTEk5VFcwUWpPTFYxeEFoeXlDM25yTlNsN2dNY251VUxGNEY3R3p3K3VZ?=
 =?utf-8?B?ZmhhekZRc2FaSHJIVVRvbG51aW1pNHZNOVptbk82WFVzOCtINCtSWk91UGsr?=
 =?utf-8?B?K0xLLzBIRFNWUlhhMGYyOTY5U2FGcGxJTC9VTWs1aVRPdFJZMTdhZHRiOVZm?=
 =?utf-8?B?c3dBMUprajVvOXZPc2dqZWFucDZaY2lUaWJuWG42ajZNQW1odktEMHJ6Mzlh?=
 =?utf-8?B?eUxZVUVpMy95MC9zWGNKaUVwcm5pTEovVVhQTHp4Rk1hbDRiMjlRV2F0MVJR?=
 =?utf-8?B?bkVPRGJBSlFteHNOSG1VNmRtWkk4YjZHN2VUanVlWEZteWFnZ01maEV4ZnBw?=
 =?utf-8?B?QlBMS3hqMGJkYXo5QmNzSU92NnJnWXE2dmIwcHFmTFRjeFVDTkIwNFJCSVpH?=
 =?utf-8?B?WVdvWXAzRHZwTHNybW43SWxtY2EyaWgyLzBQeW81Rm5ZRit3eDUzNXRtVW9O?=
 =?utf-8?B?K3U0QkxvQVFvSjliS0dqVVozTGVZcEE5c2hGQm1XQnZ3MUc4M0diTDRYTkVB?=
 =?utf-8?B?WFIyZUFsZkRYVnVQSWptS0tNT0phTWxLeW5WY3NiUUhlWm5heXg5S1JBNkdv?=
 =?utf-8?B?NnQwQm0yNzN4NEJVMUlBZ21SUXl6L0xIZ3lhdGd1Q2x4VzRMclhBaG5zOFpn?=
 =?utf-8?B?c1EycVZnQXphUXlPTHRXWVpmWHRDenB4ZzViSmY2d3lsMTZtVmhUQXpaem9E?=
 =?utf-8?B?ZHNRempjZmYvR1krdmZiZXhkK01FaWY3TVBIU3hTMVljcjVFcVEweFpSbWVj?=
 =?utf-8?B?T2xVVmRNNllvRTd3UjIyS3lOdkc1L1pvdlFLd2IydGVkcXM5RHJKMXFGRks3?=
 =?utf-8?B?Q21sc3gyaHFTaTY0TldvMjEvV2FGTmpGd29ROW52cVJoMTBXQk14TnRtRlRU?=
 =?utf-8?B?UTQ5U0hJN1I2ampESmVIQS95S3dYemFjdHFwYnRyZVg5R2hvazFLd1ErWHE5?=
 =?utf-8?B?OHQxaGZrN3k3ZWFUK2xIZkZSRTZlNE1WMURsN1kzODlFbFVRbXFMMCs4MlVY?=
 =?utf-8?B?MnhaS0ZUUWs3d2wxMHdLbVZBV09WTHRsZGJaeVNRMzJsT1JUeHV3MkErR0VW?=
 =?utf-8?B?K3cxaVF5Y1R6Nlc2Y3FsV1NIbmVRTVRURUpDMG9Za3N2WmdLVk1td2JVY2Iw?=
 =?utf-8?B?USsxTEZRMzlxb0tDN09LUC9jZThla0VzUzUwN0xEYlg0cHIyK0g3RnI1SVla?=
 =?utf-8?B?V1FkQ2xKNy9LY0FpTUdpc1F4VEx5YjhrS0lLd05pNXpTZlZQdXUxUVkyRW85?=
 =?utf-8?B?eWxnbzVMdjk4WWM5c1dOS1Q3eFk3Vzl1blJ6eHJHazA0TWVTcVcrWkZ3MVpk?=
 =?utf-8?B?S1pTWUQ3c2dMUjQ3RzNqdTBlTkd0NFJZcUhGeFFnR1pQU1JHSDJTbXVNdDUx?=
 =?utf-8?B?QVNsUjR4YThYcTMzems1OWdBcWE0QWNTYW5HZjRVZVZBb1hobnVHUDRHU002?=
 =?utf-8?B?WHJ5aGNsdXBocm5OQUNwcTR5d05nZjg5LzJ2YzhwMU1UQWEvMENTR0hhL0FI?=
 =?utf-8?B?Q1ZwT1RtTy9tdUJpYUVISXNjNk13cFJpVVRKcVdFdGwwWCtsNE5VY09DR0dp?=
 =?utf-8?Q?7Ne9gHbf1q2p1o7g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf014d2-b83e-4da0-e314-08de6a3279ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 12:30:15.7957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8AvmOSUrLR7ANw8DvmF963H7oAV5kQWjZdHQZVPdyDVkjl5ndZ+4czmzl2YNQDTHORoHyydqvS4LaZ8B9QjrSHvor9QR5mjFmb5vuB1G6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7934
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

On 2/11/2026 7:13 PM, Bruce Richardson wrote:
> The common "simple Tx" function - in some ways a scalar version of the
> vector Tx functions - can be used by the cpfl driver in the same way as
> the idpf driver does.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
