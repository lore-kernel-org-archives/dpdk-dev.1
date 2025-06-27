Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D083FC77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 14:53:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 355F94066C;
	Fri, 27 Jun 2025 16:53:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id F1ABF40665;
 Fri, 27 Jun 2025 16:53:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751035981; x=1782571981;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SdtJdzKfYYyOkq8dUc168VU6QtBU+CEpfHv/BrYNzXo=;
 b=ane4QqZoUoBLi+7DcMxGzAf3XFEc9RBgBhuazctcvjQWyA5rnXKS+EKm
 aQCOGDgpbUYQyJ0zifQZwauvgFc9xJTOLwfPyKrdH4xfqXXEZX/SnLcx5
 +eWrPitbFKWHnVHogk/MKMI/2IOv2tp3K4pN4TaRczy52vOxGJ/a1Y/4i
 1+TAVFSKhE3a4F3vb1Wvi/LmqShnYXRiS6oxWbbWSl97YARzRWgBCMlAy
 w0wwuxwFCQt1yhSW3AQqTGf+0dTgLMDJJNTrtqlzwrOcPVAfCANw7oCug
 RSCqbaBEE0g4MbkXH9ZHawgwsf2J+B6iCWYZ+p4IfTz6VmOm4nja5sDXb g==;
X-CSE-ConnectionGUID: YNU+xrInQjyR3SkvfLXrJw==
X-CSE-MsgGUID: Ev9QaTV5SkCenk5tLruLLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53446000"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="53446000"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 07:53:00 -0700
X-CSE-ConnectionGUID: RkYrrI9eS/qrGFAGYcV5SQ==
X-CSE-MsgGUID: yfh27D/SR56Nq9rjtxF7lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="158308815"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 07:53:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 07:52:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 27 Jun 2025 07:52:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 07:52:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKOxvIY39WhFz2UqYBAbeKBTKR1e7rFUoNlRbTa+5ZQqBGyXUXvACNhodC1/7emJ2gArH64akMaE8/CgDci/+fAoJUYISrYL8onDeLb8JJszTkg3NS765WPQC9YU2/unmuoJP9v5PfR/dnBn+oTZjDu/z/UWtsBds2kapf4r7DHxb1SIZ3hVQSQZn2ZMDIXquiQDqlU9maxqdplx/gBaVBgP5vjddUS41tZPL7VUGZhOoe+Osepo9ujn9LBT1xYHc44DBFZAzEMSHZxdHzBieVj47LR9O12N9m/1D3arJNd7GbTBTL8bl4nrDPQBInCvupuNv6hBh5urPkblA1a5ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PM0Cdu90VIKFRo145bqems+/64TFildp2p7LvjiE0Y0=;
 b=Y0Cc5mw/LuupgCH5RJhmsdBvDioSZAet45v/sA5shBTy1HuReXiwRTuLbS75TIwn6apk25QTZMpA0chS8lG6Sr4tQU8xyGPUuMRXa3SwGSgkiwh00g4EnIZDhbxNBf3Ddpl+AfQLwQwI/mA+WBjoDh6VhTRe6FzS2hM34oIn48Tz9TMpoUhCkppz64ao4/YgKdmWhhGTd7lPTg93YPXpv9a2ZSJB0np/gnHDmTem8eUDDx4s4xFtLllp/cP9m5xFfYB3dSIl9lvlFEdB550cYOnpxYD9gCqgd7pTq7a2iNUdZ4fBP09BJq8DXW57D3pfr1ftFXAWKclwsmeJmB+21g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.21; Fri, 27 Jun 2025 14:52:29 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 14:52:29 +0000
Message-ID: <800e49b4-fbfe-45d3-9594-d572463ba766@intel.com>
Date: Fri, 27 Jun 2025 16:52:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eal: deprecate old coremask-based EAL parameters
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <thomas@monjalon.net>, <techboard@dpdk.org>, 
 Vipin Varghese <vipin.varghese@amd.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
References: <20250624134139.552315-1-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250624134139.552315-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0323.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS7PR11MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: c045a31a-6c7a-45a2-46c1-08ddb58a3d2a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWdzalBUSEFtbllVUUZxMnFTMDRzei81Qjk1MEI5R1BKaG1WbjhMM1N1Q2ZT?=
 =?utf-8?B?VzEvaGgvdmlkNXdneGFjblk2UHVMS0tZMW0vWHB4akFmWGw5ZWY4NmtHOHZ2?=
 =?utf-8?B?MXE1SjV1OUdUMi9FN0hDc0hPVmlCL3pzeXNhTEdrQU83VXhxR3o1S1FjbEVC?=
 =?utf-8?B?VUNNYUdwSG9td3czOG5MSTJpWEd1bXFDemdTVFNXaTZ5N25DeURNemN3U1Iw?=
 =?utf-8?B?UzdYNG8xQWRxbm9WZ0xuNmNXeXU2L0Q2dEtHNk90QytGMktVVHJkenFWYU9w?=
 =?utf-8?B?cVI4WlBNaGM5ME95SnpNM1VYb0RSMmdmcGk5QWZBOTFOWXpKOEJBZ0ZZR3hB?=
 =?utf-8?B?Q3YzWHZZcEdnbWVFZnJqR0ZVY0x3cmRaTEhpNGcxQWdlQjQrRFBWL2VrYVRl?=
 =?utf-8?B?ZHFNckRKWEsxM3NQbDRwUHNnMHU0T1Mxdm5rTFY1ZEZxL3ZmUmdMbDJKY0xW?=
 =?utf-8?B?dXpSM0llR21qVm5ZV1VCcFAyd09CRndIWDJRZEczbGMwNVMxSkdGU21ncjNy?=
 =?utf-8?B?R1FLeDZTVWptNXZubStRUTNCcWhySG1OOVdzZmlCenhoZTUrNFBuWUxVRlhD?=
 =?utf-8?B?dGphMDg2SS9XY0l5SndzSmZyUFE1OWN3MXdXSWZZcEdyMUtpYmxmUHUrNWVs?=
 =?utf-8?B?ckx1WUVIWGI0RXVMQVNROHJFSjl1NXdjb2tWdVRRdkZCZzlnUjdVOEh0NEJa?=
 =?utf-8?B?N1prVFhGc1JJbTAxK1JUVUdQeHZSQlFMTWU1ZUs5UWpoeWR1SlhyVnZWQkcr?=
 =?utf-8?B?aVdNQjBLQ0VUTTBNY1BlRnVUVXZwYW8reEpGbjFtZ2tKb3pGZDRkcUFzVHk3?=
 =?utf-8?B?RW5pMDFDK2hlS2RvVjJka24xemdxSjloM1FFb0UzK3hXMjRQcVdXQ1g0Z2tW?=
 =?utf-8?B?eW9Ya2V4U2JSZEU5eXY1cU5iZ1J3d1FOZnl2NzU2MkdNTVlvS1ZRbEkwWXZs?=
 =?utf-8?B?NkZUc3Y4Q3ZLNVBmRGIwa1JsSjdwUDV3WkRKNnBnYmlVRENYcDR3OUttaEda?=
 =?utf-8?B?L2s2ZURFbGlCQzJieTUzdktLYUR0Z1h2ckNmRlBMUkpTOGZUbDRDSzFRbzlp?=
 =?utf-8?B?ZjY1djJwSXpzdjFkUWRVSnlUeFZFVHhBZnAyOXBQN0xiL3JjU21BcVJqZGRY?=
 =?utf-8?B?S1oxdUx5NFNrd2hZN2EvZDk0YWx5UmpUTFZlQ3djNG5iRzB6WWVxUCtUOHRS?=
 =?utf-8?B?dnhKdnc3VWEzSWVZRGhNQy9xK2RwZmNEZ3BCaE05OE0xeWEyOFo0aU5LWlJs?=
 =?utf-8?B?YWNGTE5wb0NFK1dpMFRwMDMvR3NmLzk1V1J2SU1IYXNmV2tCTDRlVXI2Mk1l?=
 =?utf-8?B?OThWeUN2UDlQMGRHVmJtdTVxT3dqOW9xcHAwTnp2ZTdENnQ1dGFGU2xVWEhH?=
 =?utf-8?B?NnZRMGlCOWE3WVR6bUpqM2R1UkpwaFBrM0ZOcGZwWjB3T3hmVWZMU0dKTGZQ?=
 =?utf-8?B?MTd1bjNLdHA0RElQamRycDNGU1lTR29WT1dnKzhkdTNETlBoVEtwdmpRTngw?=
 =?utf-8?B?eUlac3h5d2tmY2Q1QnlLeWFhSmhOc3lMRGRlREkrM0xFZThxUHdsS3o1alNV?=
 =?utf-8?B?K2J5cFFFTXgrTVNqcFVSL1UvWEdJd1pqQVZsdVMwakxnSFJ3U2E4d0VBSlRM?=
 =?utf-8?B?WVdIY09GeDFlN1ViTEhnOStOT0dOdXFBTW0wdWxUTTUxdDRuZTBnT3gxSWNs?=
 =?utf-8?B?MzNTZzV0R0NOMStHK0IzRFdIY2U5MVd3d00rMVVKRFE2b0cyL0laakplSkJ1?=
 =?utf-8?B?VWhMckFuTTJ1UU50UVFWRXpjaUQzb1hPQkpDWjlxbWR3dGxTdWM4S1dZeWhP?=
 =?utf-8?B?cXJHTndqT210Y21nT2pRZ01yNjdlWEV2QWV5ZTRaRmZKSW1DRGNnTUZ4dmlD?=
 =?utf-8?B?cjZFd0RYL1ZyMm91QkhOOWxEY1VQRlIzT0lCdlhmWHVKckN5bFFYOTZTOStX?=
 =?utf-8?Q?wGKOIhW4UvU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1Q1ZUFSTzlXVEplbytobzlaZjBUTVhSZnNBNVIwaTRpNnQvcUg2Y3RyRjJV?=
 =?utf-8?B?Y2RlL0JSVVVnY2UvOFZIamZyUEUyd0wwZVNramtmZi9nNjFSYTBiNTVhOGw3?=
 =?utf-8?B?dVQ1SUtEbTZrQ29iNE5CMVAvR0tGT3ByRDZ2YklhWlZCY2ZqaVo1eGlqZFB1?=
 =?utf-8?B?K0EvNlBGYmhhd3JXSVlSOTcwTTZRMFBoMU5PMzdhZVJSc25DWTFFNXNqNHQy?=
 =?utf-8?B?b0I1QTdPcGk5a3A2MUVzT0lFOUN1Kzg4T2JZUjJRS01UZTNTZE5YSUp5dXlO?=
 =?utf-8?B?OUlLd2cwcXRJUzk3ak5zMFVqUkpRdEd0RE85bnJleVJkM1FVeVB4dldSNzNj?=
 =?utf-8?B?RGZBK2xkV3Vkam8ya05NSnNGalRvM1VKRHo5SFB5TVNmeWJWeTIxdXJ6VWF6?=
 =?utf-8?B?RVBjTzVDT2VwbVF5MWhJeExLODdFMitoZ0JlV0hjb3NiTnRXNUN4czF2dlJY?=
 =?utf-8?B?RVhsNHBpNUl6L3ZQMFJzNFl2dzVZSDhVUmNYd1dNNHE3OU0xUUlMQXJCQkw1?=
 =?utf-8?B?YVA5KzJrK0ZiYUdETkJOSm9oSXJXR1VWQmhhek5pK0huamVIdU13NUFJL0hH?=
 =?utf-8?B?Z3BYOFo2WEd5ZGlqVTU0VW02NTdtbE40d2xVYkxDaU9EMzNXL2dkWGhSbDlL?=
 =?utf-8?B?S3czbFRmQmNURnRwUXd0akJ4QmpIUmRteGtDV3daOTlxWUdaQ2o3SlJIZGsy?=
 =?utf-8?B?bUFHb3FoSGxWciswV3dmVkxYeGM1akhQREZ6Uit3aDFIWDNWbUN0K1hEMjho?=
 =?utf-8?B?UmxsMDE0ZEVOeFF5YmcvTXB4aDBhNk5jU1I1OXg5M3Z1MnV6RUhuNC8xdDJD?=
 =?utf-8?B?RDlwVjNJU0xPM3RqTjh6ZlNRWmI3a1g4Q2VaOFFPRTNnVk1wdzNwU0pzVGx5?=
 =?utf-8?B?YkFkUDdjWWQ2Szl6aDR1QkozYmhUWWlxd0llalNxdEJ0QTV3VDc4K0dFa3c2?=
 =?utf-8?B?ZllCMlA2WFJRYU4yYmdkY0p0c3lacGZYTkZ3K2tuKzlmK2N2UkF2RDJvN2xI?=
 =?utf-8?B?VkVqZ3FBTTNFUHlLeXdDcFhFdTlFYjdjMTl5c0lvcVFSVS9pOFoxZ1dFK3VH?=
 =?utf-8?B?M0xBSENoR3VucmJNTm9nMkl3Y1ZMRm5EbzNzM1MyWUV2WDUrMEU5YVRrNTRN?=
 =?utf-8?B?OU93aWhaUmZoYk04dmV1V2M0eFBrN0R4bWs1akFaTlRPSG82ZWQ3UGg2K2Zl?=
 =?utf-8?B?Q3BZbVhGYXYyK0FUd2hQQnZWS0ZQNG1nWHhXOUZZU0llckJxTXlSTXl3Z2Fm?=
 =?utf-8?B?R3FUNGErL0E3VDlJYkdyOU5tRUE4cnBDem5STVlHOG0xNjVxNWJ6TElZeUFH?=
 =?utf-8?B?ZnJlcHFTSmNyOUdMRm1UUWVpSXBINmk4dDBhaGprRjUycUpEUGNDNkRkT2V5?=
 =?utf-8?B?QkpaKzRCcEVteSthNlhPVnBuL1hocjV5VnRiR0N4TlhaR0piU29oV2ZGS0V0?=
 =?utf-8?B?RytaZWh2Y1pGRmlKZjVMdUl1UEY0T2FnbWhmR1V4ZkJVREdrdlhmZVlBcktS?=
 =?utf-8?B?cXc4WmxQbmYvTGNkdU9OUmRXTjZaTS9nNld5TVV1dUhDS1U1WVpBWTQ2YUl6?=
 =?utf-8?B?MC8xYjBNZEdSTXZUbjUzM09RZUcyVDdxZUNiRE1NaTNZbGptUUhUR3A2Zjhk?=
 =?utf-8?B?N21MYUJxSG0xaWFnd28xdXdLMnoyMEpyNzc4cW51WGlXcWNXRVM0cGVhais4?=
 =?utf-8?B?ODMyc0NZc0pQVWlHYmhuYy9aNm1tcGVqQWhkSkdNVWtJa2JCTWdyZnB6SExN?=
 =?utf-8?B?T21ZcUpPZW00OXByczhuaVVNTlRXTTFiazlxdlVZanlaZ0hsZ2l1WWpsbXVR?=
 =?utf-8?B?ck9LK1BlTWxqS3ZGQVBGOGRZK0h6OW5rcjJYNmQ2MUZKQlUwc2llNUNnbW43?=
 =?utf-8?B?eTRrU2FQcXRMNmRwdEJ4MDc1TmFHNTY2NmdiWGE5K0pvQ3hMTzRqMVozVCtF?=
 =?utf-8?B?YXpTWGdyQkJ2dEViTWI3NmtJY2d2RWxSaXBKWjY1ajFwWlZmNWxvZG9XRkc5?=
 =?utf-8?B?WThJbzJYMUg2TzUydHZKeG9OVkpkdTNUQmpPS0RETXdBU0h2MFREQXBESWdu?=
 =?utf-8?B?RnY4Ukc1cGtwYjBNVjVubkxqd2k3NDZ4Zm15WCt1SEVqSmwwNUg5U2l6L2ZY?=
 =?utf-8?B?eEpwYUErbXlpaHFGN1JYZFhpN1E0RjQzb1BuNU1Jbmg5WGhRNGFXOGV2Yk43?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c045a31a-6c7a-45a2-46c1-08ddb58a3d2a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:52:29.4226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZn72pzQngJSXdaPxzwflDQA682kPOXY9EWIT87Ovtf6BvV11pi9nsZiKaCJ3AcFah5uOQbUYeTajYFefAxI9KuXPiFH3d2KqKN4g7WNRqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6269
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

On 6/24/2025 3:41 PM, Bruce Richardson wrote:
> As the number of cores/cpus on platforms has increased over the years,
> the use of coremasks rather than core-lists for identifying DPDK cores
> has become more and more unwieldy. At this point, let's deprecate the
> coremask-based EAL parameters for future removal, and point users to the
> core-list based versions instead.
> 
> Depends-on: series-35540 ("use core lists not masks in documentation")
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Vipin Varghese <vipin.varghese@amd.com>
> ---

Acked-By: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
