Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4EBC677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 11:53:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BB5340670;
	Wed, 11 Jun 2025 13:53:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id B56C84066F
 for <dev@dpdk.org>; Wed, 11 Jun 2025 13:53:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749642812; x=1781178812;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=muhFQq0XMuAtpTX4lp3Zkh7qWDg6Aadx0vNVWOMMdJo=;
 b=d/lADL9e6nQ6NSEQj9c9ARPeh/F8wMw6ETnoBYpYbOClDEC8TZXOZVsj
 MlUVr/5soaWvWyUnMHPMzAHy4h5j1mGH+3GdIBitCKzjLb2nhwLGgYomg
 op3XTCGVJpoMf1CciLp5BHXWT5YqYwEwsyKpZpYU4e0fQwjqBRhOGxZdY
 OeT/jufxY0TqCSdQVS59hHDF10o9HI1Q0v22j2CBCMBXXKUPEKynJaLr8
 1zKIW2CT7DEjFZNdKlz9bhXMeg0C8cOAJ1SYX215LmnTkiODh1QAu5Tzk
 0b4H45XP0NlFzdVOcnS68mf2uMkQ1mSkxmEAktYuYWS+wIAaOjfNnvF7B w==;
X-CSE-ConnectionGUID: J+MN4rkFTnaXek5JpLSOcw==
X-CSE-MsgGUID: hM519+MPQHeccj2DGyLPSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51494833"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="51494833"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 04:53:30 -0700
X-CSE-ConnectionGUID: r7UdLGoCRVOXFO6N8DGLEQ==
X-CSE-MsgGUID: WtMTxeUmRmiL5UdH9xe97g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="147533132"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 04:53:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 04:53:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 11 Jun 2025 04:53:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.50)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 04:53:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fwcl88PzOg8ZgeylT3c0HHvmxJ3lKH8khsX3R+M3TP/GQ1VsXKPJ7h8qe4++0d1qxQ7pR8NFv7Uv75hIlenDCnYAj+96Rn0FLG8XTon15kFpGngXxb6slzXdv6/cO7RUvzbzyo0vCBW9VF/p8X0w+tlVnoKTAmfsw/GyMqeuGW2NwGz+SQCg5pFR/Hn1UgqiPS8yom/jEoVCsRbH/QOKCGUfGuzJOxYlUuwFsUEmxQF/pbnmxyURHSq6QnSblWtBEgrVXAf+LHXGnUla69TFtq/MB+zAklF7ZSskyu6mlCtA9RatdAPKKgNWuYd3mqTXzqrlURb62tAnwIVqPrUraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlQ9c1pfBqSVp+05z3uQX+HcgaxTlERWkRpFpF36rpE=;
 b=t62EG2mh6Gsx5of08hA4kHXDqk3TuPiF/ej6m0/G2zJWR20COk6kSMqIU62DqBfYGNQi2r2gugeBsphKOzOA2JQM/2Rsn4g7AscPSfNWzqtRgQGpxVNxDijxpJg5yT+jxWozJdBCJyKrVOnTXH79sfBrkm6kkiV5gUZRW905P4Nq23BY8DyAF+2RPf4p1e/Kr0KNPOMuTvQjipASnl8WokhMQj8sdE6Gbz8IBJdDy6Aofau4D4xsMUN+aMNdUVfFVI9jV05jMkU6YrFhdV5P2FmSqgqfMrocp4J5xWYGTyFeINsjLJYjPObflm7FQi4IzI6estcUBbExmslz02Hknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by CY8PR11MB6913.namprd11.prod.outlook.com (2603:10b6:930:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Wed, 11 Jun
 2025 11:53:00 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%6]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 11:53:00 +0000
Message-ID: <c2f7c2a6-d91e-46da-8cca-01df5cd313e2@intel.com>
Date: Wed, 11 Jun 2025 12:52:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] lib/lpm: R-V V rte_lpm_lookupx4
To: <uk7b@foxmail.com>, <dev@dpdk.org>
CC: Sun Yuechi <sunyuechi@iscas.ac.cn>, Thomas Monjalon <thomas@monjalon.net>, 
 Bruce Richardson <bruce.richardson@intel.com>, Stanislaw Kardach
 <stanislaw.kardach@gmail.com>
References: <tencent_3C14F3CE0963698675F04CA9725B540D5D0A@qq.com>
 <20250605105844.3931758-1-uk7b@foxmail.com>
 <tencent_B17E58054F806ABA85EFD05EF1E25C191606@qq.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <tencent_B17E58054F806ABA85EFD05EF1E25C191606@qq.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB7PR03CA0108.eurprd03.prod.outlook.com
 (2603:10a6:10:72::49) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|CY8PR11MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bce5d77-f2d0-49f4-efa0-08dda8de83b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVFGaWpXUjlkb08zdS9yZTFRUmdmYXBXWVRsWVFkYjJud0JxVkxMbDRIWXIx?=
 =?utf-8?B?cGwwWFNkVFlsd21zd2d6NEV2TGVjTkM5cDM2Z3YweHlYVUMwQjJlQ0JKRG4x?=
 =?utf-8?B?eGxRdnBQVGVzOEVGQWhWV3plZXR4ekVBd3p2TzJtWHc1dGRtOXZTakpqdHRH?=
 =?utf-8?B?WVJyMGNWVnYwbHlGcDlocnlHODBxWGl2OURERGxoVitoeGxUb3NLTmptQ0NY?=
 =?utf-8?B?ek1md0RMTTQ1ZUVJd0YwWlFyRndKR1RmYStaN0x0UlRseEV4S202SWhuaGxE?=
 =?utf-8?B?Z0d5blV4N1ZwdzdUczRIbzA5VTNrR1hTZ3dvbHdyMnRSYVhtbHhlK0M4b3I4?=
 =?utf-8?B?VzEwcGI1K2hISTVqc2Z1MnVuUS92UFVVQTVIdWc4U2lHSGZNUnd5S2E3bnBF?=
 =?utf-8?B?Y01ETGtLd2RPNDRpcWgyNVI1OFlwTTRBUWQ3d2QzYU16NFAzVTZZZTdOZTd5?=
 =?utf-8?B?L2ROR0JNampGRzJrQldtdXRQSDkvU1lOemZwaVZlaFpKaXdhT1NsOEZsVEtv?=
 =?utf-8?B?aGFnUXA1LzNZK1lvK3M2RGhTZVVBbVNNS3d4aDZUdE15eGlvQnhkMVBwaGQ2?=
 =?utf-8?B?TnFDenJwdDkrRlZvWGxzZzN0Rmhlc1YvQ0UvOG5BbzZxTytvVVM2bkc5RVND?=
 =?utf-8?B?TjZuak82U1JWblBmUUtnSVFHOTRSNkxEb3o5OEdGMGQwT3JSUUlZNk5QbG1h?=
 =?utf-8?B?UkROdHh1bVV0ZXhKbFpSS0dUcGRwckVadm1WOHpxYUNvaGY4aEVjbW9HY0hy?=
 =?utf-8?B?Q2RaZ3R0cmVwOEdtUkRSRmJ1RnBaaDZFM1EybC9vTUsybit5cTM5VGhwbUxi?=
 =?utf-8?B?T2NxVXl3NGtwYUJtNzNsc1kxdlozYWh2dHpub09mc2hEZFBQcHNlWFh0SU5I?=
 =?utf-8?B?UjZ2SmNONitnYzdLMjYrL05YYUlnTVFlSjVqV1g1cGU2VXE5WkVNWHRwUXVl?=
 =?utf-8?B?UGk3NUQ0R0cyMlkxak9ISmxLbFhJOEswZmo5VG9nUXdMUThSQkVUQ2dCYU52?=
 =?utf-8?B?VkdaZVpXNHBLOEo4S2xGMzBQUlpKejcyc1ZDallidDFxdE1ncFMyd2JOSllI?=
 =?utf-8?B?aW5NanBmM1JOZUN3Z3ZOdWJwVVM2eHpSRDlrQ1dKZGx5OXZqQ0pldXlHRFN6?=
 =?utf-8?B?M1NDTWNjNnlrWnNwUnZBRHlleThPTVNucmpUejc3ajI3M3JXbmJTbzZJZWl5?=
 =?utf-8?B?VW1td1M1eU9XaWdSL2R6cmtaR1U4UFpLbnFrVitPV0hiYytEdmUyY3l1VU9h?=
 =?utf-8?B?cXVBbUJ1VzVnNEN5RTFEZDZ0YkVQcmo4RUZnVEt5SnFzKytKYzFRcnJnTjlZ?=
 =?utf-8?B?cUQwOHFIMVg5SFBEYlJWaWJGejEyWW9FZGZ0eDArVVFNbW1HU1VJMVdVL0Zu?=
 =?utf-8?B?N3BzWWlnNE44djVrSEJDdjdXWjVtR1ViV3Z2NS9ydlJnaGhORTVTL3pkSUJQ?=
 =?utf-8?B?MlJtY1FwNnFkSmxGdTB2UW01YnExNDJySUduUjY3ZWtVRFpDeTBGVWJuRUJz?=
 =?utf-8?B?cE10Nk01dGdzSllLdkJabDFWZ2pCNDg3Zm9saG9jaWFtOXMwbGE2Z2k4WU1I?=
 =?utf-8?B?dnZLZ1EwUXRhVmFRWVlPdncwWmpoM2JLTVIzUXFXS2ljcW5va2diUFRTRTV1?=
 =?utf-8?B?djRYSTlXOW5adVF2ZnEyd0QyTlJGVWpMNnZ0V2NWelJaN1BIOG1zMnZaUEpX?=
 =?utf-8?B?c2N2MjAxamhvalRDWTNOMER5RVBVdm5jREpEVnEyVlpsZnF1dnJuTFNUcHhw?=
 =?utf-8?B?QlRMSGJjdjBVQ2x5OS9DVHRhdFluRkZocVFLQmFOcDk0M0svTnMyWkQ3c0Zy?=
 =?utf-8?Q?oPGLYoTjED80HzbKY0PKv/9miRWTqWXp2OAno=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVQ1MU0rcjNNSnhiU3BkaVoyNU1oWmc2K1dLNUx3NHA1b3k5WXhVSjJBcjYv?=
 =?utf-8?B?K2hxRzhNTzBzNDYxMXFTL1ZWZTRMZ050aGZic3E1dTVwQlZwYXNKVUQyZTJW?=
 =?utf-8?B?K211Wk8zV3AzK3ZkbDZHbUxxRHZQMWNkWncvVTZsRm56K2kwdXBFVFV5Tjdy?=
 =?utf-8?B?Nzd1d3NuTFBkWThkcHlpVEZ6OVRWSkNPRktCSWdsYzZRbXljc2JZRWxFZnRQ?=
 =?utf-8?B?eTF3d0kxekhLM2wwNTdYNi9mZkVEcERtUFZIUTdMTkFseFN6Y0YyRVk1M3Z5?=
 =?utf-8?B?K0RjNWRIUmtuR3BFTTFaMEtKRG5uZlo4ZmFWZnRtWXl1V2VhRTYwek1ETHJJ?=
 =?utf-8?B?VTVheFhndHBwL2hqV1lRck5YMHl5UW05OGQxaVJjYnFCb1JUZTk4UUJ0OUFj?=
 =?utf-8?B?SmVhU0FRL3ppVlhQOGtwQW1lSi9pQUhvS3dHdzQ1V0UwZzUzR3lKdytGN2lD?=
 =?utf-8?B?UHl2MW0zNFo1c3lUWmVZaEVBbGdCRFZCUU01VnVWQWNGakNsQ1dTcGtQdHJ6?=
 =?utf-8?B?amdqb01JU1dUNzVtQXJSVXl1YXowNGpNZWpHbGNkdnloVEh1VGZWbVQvR2Vq?=
 =?utf-8?B?Rk8vK1pZRUdSaEdzS0FRN3MzeEt5N2xFZ0FWU3ZlZjk5UDFScUhEODRUWE5Z?=
 =?utf-8?B?VVFXUGxFUGFGTm1mbXNsNHJ6bUhSUnI1QmNKVTFjWTlyTjFYbUdVM1Q5b0p3?=
 =?utf-8?B?WVl4aXY2TitpOUhjU0h3TjlIYlBTM0RpdXArY1dMYi8zTDZlMkxZMlFZbXhx?=
 =?utf-8?B?SlpNN08rNVRxRVdGcHo2OGRNUXZjVkUrNDB1U0dtd0tueFE1VWxXS0h0ZTJZ?=
 =?utf-8?B?NFN2bjdxeHJ1T1RmNlRVUnhGNkF0d0lTNjY0Qk5uc2ZNWE1aRkQ1WTdUL0kv?=
 =?utf-8?B?MFZuTTJLdTZmQU0rZ0Y3amYrNjBNU0ZVUnhuUjAxb01JNVdrb0dNdkxCazRG?=
 =?utf-8?B?Nkx0K2h3ZUJsV2E1K2llcmJudFV1L1RZMDZyWkEwM2VtU0h3eTJlQnBDRkw4?=
 =?utf-8?B?YWNrNXhnUXdGSmN5R2k2dTJsR3ZubXNzNFRXdmlQTGQ0Q241eDVscjNNcjhp?=
 =?utf-8?B?ZnFlNFZDOHRGZ0FWdjY0NXlxa0M5TzhDMlI3Zjg3NEhTWkFaL2ZxcHcxUjAz?=
 =?utf-8?B?RElwU3lIMW9YSzZ3SFZIRzViWFpPR1BoTEFXaEZacmo0WGc4T0F3dzFHRjcy?=
 =?utf-8?B?elV3a1RIZGJFL01pbGxnakYyaDZVY0ZRRktwcWs3Zk1lZzB0Q0dqNUx4UTZm?=
 =?utf-8?B?YnkyTm1teVpmVHRoVTM5NE03MGlQZjdHV1EwalZyeS91bGNqM2VMNjc2NHhu?=
 =?utf-8?B?NDM4Vm41K0V0TDRTOGc2Rk1mN3ZLUmRPRWRJNTFYZzJweW9XV3hsUXNaVGln?=
 =?utf-8?B?M1IyWjgxVStvSm9xWTFYbjZjRTdaZ1FBMWVmaVIrMi9HK1JwdGNjRUxlYXhM?=
 =?utf-8?B?bTQ5Q2dVQ0Y2QnY3SXA1R3hNRWJBR3Nkd0JHWTFQQTUxYkladTA2UTFPVncr?=
 =?utf-8?B?RDVZeHF0c1EybUxSdnZOV3FQaExRNFpSTkV2NVJQdzl2bWE1RzJUOWIyVWxz?=
 =?utf-8?B?Vi9RSXdYK1pCUlh1Skt2KzBNdmpWUDQvamx0aHF5aFphYjYxdWlxQkxMb0h0?=
 =?utf-8?B?UGRwR3lqd1VqQlpOOERaMzR1RjhQQlhjeGxoRStyM1IrR091cmhZNWkrNEta?=
 =?utf-8?B?NXVaUUZJTHdzSjBZdUZpQVZaRXl6aTYrK095QUV5cC9zL3JHazlCdVFsK1R1?=
 =?utf-8?B?VnZGdU9xa2JHd2hvbXdoVkhJUjZKd2VHT2FOSWg5dzFZcVd0U0pLYU9OdVcw?=
 =?utf-8?B?aTVsRVJvZDdRRjZEcTRwbXQrOGFKTGRaekRaWXRPeTUxTnJ0SnFiYkcrUmVW?=
 =?utf-8?B?bmlkYWY3eFpiUjhQeFllbGJKRjdIVmlrcHVwY0ZoOWJWYlNLNnhGcFRkMWZW?=
 =?utf-8?B?czJrSWFueS9RbEs0eWwyTjBOT0dMdHJyNkY5QUN3Y3hEbHk3Q0FYOWhzNTdj?=
 =?utf-8?B?TEVPTzl5QkF6aUQ0NmhTMEJYV045MVNBWjFrRGprMTlWQTdtM1ZVRWQzQkN5?=
 =?utf-8?B?THRSeWtBQkU4VFd3YWtNTHFyc29vVk1qWGxVQlQzV2QrNGd5V0haWnlsNnp4?=
 =?utf-8?B?cFFuRkJ1YmFTbjkwL1RYUUFhK3NHaW5tTlNFMDhUaVZzV3RXMlUvazg4Ulcv?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bce5d77-f2d0-49f4-efa0-08dda8de83b4
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 11:53:00.4331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yn5uhGH/ILS9NZyZGlS0bSx4pHou1hmIRDRagwh09m6+ho5lXqwkAbiOwxQOiptZxnGxKwMyJBHX85/4ec/9k3jrOrqH/i8eRgI93cieQW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6913
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

Hi Sun,

You did not address my previous comments regarding commit message. You 
can put everything you've wrote in this commit as a note and add 
meaningful description about what commit generally does, like (please 
correct if needed):

"Implement LPM lookupx4 routine for RISC-V architecture using RISC-V 
Vector Extension instruction set"

Everything else (performance tests, implementation thoughts and 
considerations, etc.) should be in the patch notes. For more information 
on what "patch notes" are, you may want refer to Git documentation [1].

[1] https://git-scm.com/docs/git-notes

On 05/06/2025 11:58, uk7b@foxmail.com wrote:

> From: Sun Yuechi <sunyuechi@iscas.ac.cn>
>
> The initialization of vtbl_entry is not fully vectorized here because
> doing so would require __riscv_vluxei32_v_u32m1, which is slower
> than the scalar approach in this small-scale scenario.
>
> - Test: app/test/lpm_perf_autotest
> - Platform: Banana Pi(BPI-F3)
> - SoC: Spacemit X60 (8 cores with Vector extension)
> - CPU Frequency: up to 1.6 GHz
> - Cache: 256 KiB L1d ×8, 256 KiB L1i ×8, 1 MiB L2 ×2
> - Memory: 16 GiB
> - Kernel: Linux 6.6.36
> - Compiler: GCC 14.2.0 (with RVV intrinsic support)
>
> Test results(LPM LookupX4):
>      scalar: 5.7 cycles
>      rvv:    4.6 cycles
>
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
> ---
>   MAINTAINERS           |  2 ++
>   lib/lpm/meson.build   |  1 +
>   lib/lpm/rte_lpm.h     |  2 ++
>   lib/lpm/rte_lpm_rvv.h | 62 +++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 67 insertions(+)
>   create mode 100644 lib/lpm/rte_lpm_rvv.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e16789250..0f207ac129 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -340,6 +340,8 @@ M: Stanislaw Kardach <stanislaw.kardach@gmail.com>
>   F: config/riscv/
>   F: doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst
>   F: lib/eal/riscv/
> +M: sunyuechi <sunyuechi@iscas.ac.cn>
> +F: lib/**/*rvv*
>   
>   Intel x86
>   M: Bruce Richardson <bruce.richardson@intel.com>
> diff --git a/lib/lpm/meson.build b/lib/lpm/meson.build
> index fae4f79fb9..09133061e5 100644
> --- a/lib/lpm/meson.build
> +++ b/lib/lpm/meson.build
> @@ -17,6 +17,7 @@ indirect_headers += files(
>           'rte_lpm_scalar.h',
>           'rte_lpm_sse.h',
>           'rte_lpm_sve.h',
> +        'rte_lpm_rvv.h',
>   )
>   deps += ['hash']
>   deps += ['rcu']
> diff --git a/lib/lpm/rte_lpm.h b/lib/lpm/rte_lpm.h
> index 7df64f06b1..b06517206f 100644
> --- a/lib/lpm/rte_lpm.h
> +++ b/lib/lpm/rte_lpm.h
> @@ -408,6 +408,8 @@ rte_lpm_lookupx4(const struct rte_lpm *lpm, xmm_t ip, uint32_t hop[4],
>   #include "rte_lpm_altivec.h"
>   #elif defined(RTE_ARCH_X86)
>   #include "rte_lpm_sse.h"
> +#elif defined(RTE_ARCH_RISCV) && defined(RTE_RISCV_FEATURE_V)
> +#include "rte_lpm_rvv.h"
>   #else
>   #include "rte_lpm_scalar.h"
>   #endif
> diff --git a/lib/lpm/rte_lpm_rvv.h b/lib/lpm/rte_lpm_rvv.h
> new file mode 100644
> index 0000000000..5f48fb2b32
> --- /dev/null
> +++ b/lib/lpm/rte_lpm_rvv.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright (c) 2025 Institute of Software Chinese Academy of Sciences (ISCAS).
> + */
> +
> +#ifndef _RTE_LPM_RVV_H_
> +#define _RTE_LPM_RVV_H_
> +
> +#include <rte_vect.h>
> +
> +#include <rte_cpuflags.h>
> +#include <riscv_vector.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#define RTE_LPM_LOOKUP_SUCCESS 0x01000000
> +#define RTE_LPM_VALID_EXT_ENTRY_BITMASK 0x03000000
> +
> +static inline void rte_lpm_lookupx4(
> +	const struct rte_lpm *lpm, xmm_t ip, uint32_t hop[4], uint32_t defv)
> +{
> +	size_t vl = 4;
> +
> +	const uint32_t *tbl24_p = (const uint32_t *)lpm->tbl24;
> +	uint32_t tbl_entries[4] = {
> +		tbl24_p[((uint32_t)ip[0]) >> 8],
> +		tbl24_p[((uint32_t)ip[1]) >> 8],
> +		tbl24_p[((uint32_t)ip[2]) >> 8],
> +		tbl24_p[((uint32_t)ip[3]) >> 8],
> +	};
> +	vuint32m1_t vtbl_entry = __riscv_vle32_v_u32m1(tbl_entries, vl);
> +
> +	vbool32_t mask = __riscv_vmseq_vx_u32m1_b32(
> +	    __riscv_vand_vx_u32m1(vtbl_entry, RTE_LPM_VALID_EXT_ENTRY_BITMASK, vl),
> +	    RTE_LPM_VALID_EXT_ENTRY_BITMASK, vl);
> +
> +	vuint32m1_t vtbl8_index = __riscv_vsll_vx_u32m1(
> +	    __riscv_vadd_vv_u32m1(
> +		__riscv_vsll_vx_u32m1(__riscv_vand_vx_u32m1(vtbl_entry, 0x00FFFFFF, vl), 8, vl),
> +		__riscv_vand_vx_u32m1(
> +		    __riscv_vle32_v_u32m1((const uint32_t *)&ip, vl), 0x000000FF, vl),
> +		vl),
> +	    2, vl);
> +
> +	vtbl_entry = __riscv_vluxei32_v_u32m1_mu(
> +	    mask, vtbl_entry, (const uint32_t *)(lpm->tbl8), vtbl8_index, vl);
> +
> +	vuint32m1_t vnext_hop = __riscv_vand_vx_u32m1(vtbl_entry, 0x00FFFFFF, vl);
> +	mask = __riscv_vmseq_vx_u32m1_b32(
> +	    __riscv_vand_vx_u32m1(vtbl_entry, RTE_LPM_LOOKUP_SUCCESS, vl), 0, vl);
> +
> +	vnext_hop = __riscv_vmerge_vxm_u32m1(vnext_hop, defv, mask, vl);
> +
> +	__riscv_vse32_v_u32m1(hop, vnext_hop, vl);
> +}
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* _RTE_LPM_RVV_H_ */

-- 
Regards,
Vladimir

