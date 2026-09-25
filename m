Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1DFC98321
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 12:48:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10CB7402D9;
	Fri, 25 Sep 2026 14:48:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 3BCBF40294;
 Fri, 25 Sep 2026 14:48:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790340526; x=1821876526;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VRJJDVdb8YFSkD0NJpPk6wtb6Ijv5h15SQDKcKOF7zU=;
 b=XNagla9//+aY97RxBIELNv/R/Hq2KhVkIcR0+jaSMZapyRgdbpl7pwiw
 5pqQhehemVGgxzxxAFHwF/0L8MwinBriP5PqMWoiF9t01EPgLQbCvQEmV
 JqItQ0SpNyyfEbQCX/pHjLifDxOHmV8t9EbRnEQCvkIMKgcaRKaFpG6PW
 NGkaPyWd2kOiA2gmmoi6Eoa5f0Iosvhjn5O387868fOMB/h+GhS5b6X+r
 /N1PGVgFfDps8l0U2cQYW9nvfwhttXW3JhytHDZ8zMPoYemIQEpefTHco
 5sRzM210X3g+BLrXzXrWVD0thkgWbxMJaxpXjhKNIs6EdiVtxT1/ZdLCe Q==;
X-CSE-ConnectionGUID: y6LD37LuQtmBqzie/rTGOg==
X-CSE-MsgGUID: TL6ruk9/SRSXEA4GESjEVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="89988283"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="89988283"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 05:48:45 -0700
X-CSE-ConnectionGUID: +mBX+2ceQOyftHb3XfMrqw==
X-CSE-MsgGUID: W0rfGpXETuei0z+0vy9gew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="273559233"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 05:48:45 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 05:48:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 05:48:44 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.30)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 05:48:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTnUU6We0mBckNLeLxvbzp8NJ4ScFNtPp6t3Qv8C+fqAUY8U7vrDAt8s8mexJM5yk5esAKVAeZUPrGAucizUqrrufFajeTn3I8uwmokDQ5fppyg2lB0ihVO33TVBZCWaoQ8msEI2zQcW0Lk0fxyqD0OovJ7q5EUlhyL6DYv2kGTtmP+lPDxVuybLHuyBNEZoYNo3vWsD/h/uSgj0rD/MTPX63OJcGgN7Pm51NkFoMiYstZu0Qc1/zfqv581CWcBMAeBCB+El8CCLhQmXIRFR41m5wCGqBOSRZs8ivriai//2FW2oQjL5CjEotW8/UV17Ubx7ZbLG2W/vzpBF0m/h0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uUtFWPokVuK9SLwaxJAjkCixkEmg8eWOlamQWMLKoQ=;
 b=CmOKJG5Fgk4FemnZSMtO6CUwndnCIvRNeBpHkndhgA1O3Bl34aef42OOBTAagcVYbhGnDJQydCDA1XZIIQSxe01EKFYvH58aChjZf2dsT71+ckDftP+WOoJ/lDnoGA1rtIHQOzhM4znZbdm352/LzYvIIfqRmMENNV0lX6vOm1ZoL4EUrMybS+HgX27phjSo16Ciyq3nSZ0GwAW/cF1ppGH3RDLXqS5hY57U7hdjG0ceYZcxRdkuccKyShg0xs3BhQkD89thng0ofEL20sZVxfHq31fjUx3XuU1EcPh5VO0Zvw5K3chmOInz2IVwJSP+0jn6/ATcmgRnWXHMpW2cVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CO1PR11MB4818.namprd11.prod.outlook.com (2603:10b6:303:93::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.19; Fri, 25 Sep 2026 12:48:42 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 12:48:42 +0000
Message-ID: <34f41bbb-5a3f-46b9-a728-5ce48ab69caf@intel.com>
Date: Fri, 25 Sep 2026 14:48:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] Removing comparison enum to bool
To: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <ting.xu@intel.com>
References: <20260915075549.429013-1-Evgeny.Sokolov@infotecs.ru>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260915075549.429013-1-Evgeny.Sokolov@infotecs.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P192CA0011.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::16) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CO1PR11MB4818:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ec4c54-0c96-48e9-6e53-08df1b035434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: swTXqseA4EIaun6tnH7ngy4L69qz3I0rdyBjR2bWVw8jSNy9Pwkhn/c0vZJbrodWU2yU/kkNVCdFQaRjyVn0mLTzd2HBl7bjlT5pso64fat409mls8Jfvoy98sy3fUy4mxT8ReSd3sSB6haXfwCEcDNjaDugTnTvul2tqaBPzHfe7T4/U0tFi1w5MMu7wCeoTsjAjzQgigV0vfOiNgJcPV7xhr2I5MT86z4Enu+KY0DXIs++Vn/ehz//oMo57UAUC1EgCPDvDaajOmwwdz4qWj0etdep3DZPIs20aw2IQIdISMEHN7HYLnSZ4nUvOmTSh87d6ID1E0yPBLib4DOhc3OA6Bs6P4Ffw6GY70Hu5EbD+a1gwxko7qPvp3/KsM/8zw5XKZbfYTf1X5JNgOdwV7FTB1vU983+SqPzw759YtCpjkoowwGRhC9qeYaq3UUYVxkelUeFiBk/iIUpV6yAIQ7H0yJZQA6pioiPNg1HZ7adZ34mq2JSwsGKf9pOfFAcHJkxYNNy2uM25JEvvIqo6BPXWxvOesZ0+H+i1i8o+4wC7EPOsvrN5hz5rptv2r8kBLqFexktdZYc2/SNhKJp5RLkegqm8EwBw35ZuXbparsgEy6QpawTkXMSwlYUw6St1zZAXOWZYdiKaHMQURxi+ujw8pwDxxRSjRDSH6oh0cM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEVsRUNrdXRrTDAvVExUYXpncnFXMW5hQVVyQ0dvNWI1Q1VHNWd2M0N3M0Vm?=
 =?utf-8?B?cS93bmJETWV2YmZuUkV3S3ZDTGxLQjI5NXdiQUdyUi9EOVBSNFIxV2I5V0xH?=
 =?utf-8?B?c1YzUnE4K2xab1NKUlJvQ05UOHFVNWVoTWJhZTBKZ2I4b1BEZk9LUGMzcjFy?=
 =?utf-8?B?NHRtNlU2a2pteTNWVkc3U2EvY280aGF5YTdweGxFMWNpeEh5TFpnN2d0YXpU?=
 =?utf-8?B?K2pZUjIxVlJxOXFucUh2Yko3NEU2QXpGVTRSa1J6SmxtWE4reE5QUUZvekVr?=
 =?utf-8?B?UGV0Q09TM3FTUmdhZnBSMi82VHFXbnU3R2FqWWphTStvY0xTKzZuRDNiSi9Z?=
 =?utf-8?B?QTFMZTlMdFgvQjExSWwyaSs5a0Q2aW96cFFaTGpjUmZ1dkNDTGFRV2xCSGpZ?=
 =?utf-8?B?ZGdSa2c5SjdmUDFxRFBjdUQ1WlVFL2VMcDNSN3VRYm5GRnNpakt5OWZnNUNB?=
 =?utf-8?B?aU01Mklta0drS2V0L0xXYUhKNEQyQ1dYYVp5TDFCMEg4NlZ4TG5WTkpNbFpV?=
 =?utf-8?B?Y1oxZk9OWjBiUFJ5Z2x0ZGxHdU4wd254ak1KU2Y2dlRaUFJYZXdGQ2dudVFC?=
 =?utf-8?B?cVBFdm1UQlJ1a1orQlk1M21DUUl2RWpZd24zTGxZaGZkNzNFdm1xNitnL25r?=
 =?utf-8?B?anlTR3IvaGRlSGtIWXg1eUFFVmR2Qm9lNUt0SElLYUtka0xYVUJaR0V1ak1Z?=
 =?utf-8?B?UHJqNzYwcndOcmt1eEF0OVBzZW5kdDB3MWppNXRQemFiVGczS21rb0NldHhk?=
 =?utf-8?B?VTZvaHBBTktiWkZ5NVZwazJmMklmME1JTllXU2F6SVRwOW1FeEE5aDZzVnVX?=
 =?utf-8?B?S2lxd2ZEZWlqZFRMVnNQejRYYTdkeTNpYlJJUE1DVGR6Q3YrT0lnR3RrZHFs?=
 =?utf-8?B?TFhGdHZMSHJ1Vk1kUkVNaFh2akxWVkdLL2FUMllpWjhDd2FFVTBmTmt2VGx1?=
 =?utf-8?B?aUxnWlFwTTVpMXpZeUlOOGpzczBOeWVhaXNNWmhnbkVoQ2hkZjNSczdBWS81?=
 =?utf-8?B?NUFhTGNsdkxzSnZURWtYQzBKZHhyL09mUXptOFpkMzJubkFJRXdaR1daY3B6?=
 =?utf-8?B?ZDJLNmYwb1BhVXpMT0pPK3l2Ri8zRUgrZ1hZREdrOXg5OS81V3VucGdMNVZH?=
 =?utf-8?B?ekV1OGV2QmJpQS8rVURLZjJKWE9QWHJycjd1MWxOTXR2TG00YUt3aFBya1BB?=
 =?utf-8?B?ZlhmUUsySVMrSzFoNnM2NEdEd2w1RUhKanY1OUppSGt4S2NETzZCZlgvMWl6?=
 =?utf-8?B?M0hkWUwrQ3VRRHd1am5CSjJ2UjhrbUVRMUhIbDlXdjNwOUlkRTVlZTdONXoz?=
 =?utf-8?B?VDVmMlZoUjZLL28xNWk3K0tqWElSNVBTSWVKdXZ5WFh3bnN2c1B3eHM2Nisr?=
 =?utf-8?B?TVh4Qi9saUc4QTY1MUFzUS9WS0dzTXdhUG5CWXNXK3ZFQUtwell2Y3pYbytH?=
 =?utf-8?B?TThOOE5DTkUyNUFVbFZSQ01vTWpMWTVhUUVKVHlETUU1Mjc4SHp5dURDMmRy?=
 =?utf-8?B?S0NtaHVucEN3MGtta3g5aCtpZEdLR0YrQzBjYngyQ0lCTVFIampNL1R0V0g2?=
 =?utf-8?B?UDN0dStVOEVUSEhqTWYzOWNUb0M0Vk54anF1QjhQZDA2aHlQVm9GMXJLa0xO?=
 =?utf-8?B?RmJROGV5akVrWDU4QnRTTUlWRHhzamR0cmtjUkxRNDI3RmhDYmV2bW1Jc0ZB?=
 =?utf-8?B?ejV0VlNMNm42QkJrUXFBN0hsd2VLT1pVbDFuTTFlRlpPSWNtTVhqaVNISUt2?=
 =?utf-8?B?L3djcjFhYW5rR0NhMlRNNVFheTBtRzJIZEZ3OGd0QloxTHFnWGs4MkNYeDNp?=
 =?utf-8?B?RFBkT2tJU1piUCt6Wnh5SFNhRGlkS0U4Z25JQzFlenp5emg2TXNCMm9VL09z?=
 =?utf-8?B?NGJZWjQ1WnRIZXMrbjZpL1k3RUNGaDFnRjdxclFzZ1o5bVYyQnF3RzhaR2h1?=
 =?utf-8?B?MndkYit2OUZpeXFJaWgrZFRYNzhYZmJZQngrM3RmR3d5RVpNUWNmLy9ndU01?=
 =?utf-8?B?TFpSRFF2OGpxQ3gwZS9IOUQ5L25vQjVUK3FMdFFDV2JqUHFNYUV2QnNiTlkx?=
 =?utf-8?B?cStaQ3c1RmFFM2lvZStpSnpYNDNQKzdpSGl3UU1yMU90WGxZUEU1R1RqVGhY?=
 =?utf-8?B?YktSTW1mcnVnbVZJMncvMmV0U0w5VkVyUW9ibjNGN0lzcmNYR3gzdGdnNUpG?=
 =?utf-8?B?dktsaThBbmRsNko1Tmw0dHl4OS82OWg2d3VLNE1FakhzaUpFU05FeVM4WHNW?=
 =?utf-8?B?MlluK1RrSFk5dEFrSGhQWERXeVI4aGdGZ2JQbTRLU25FUWhTTjYyKzh3MUlm?=
 =?utf-8?B?ZktCbis4U2I4SFZBTkpZek1iZmlLcldjcWlmQ0NnY3lxeXI5cmg1ZlM5RWtZ?=
 =?utf-8?Q?jqIWz78z4CN9YsJc=3D?=
X-Exchange-RoutingPolicyChecked: s+4Qskzp4B9IkSNAaHH6W9jtE9R7HrN4+UMQSASV6oONrjIzgI4i/2V1fccV1WxGdUO/XS3XN7tAMfXg3pj+DvT/OPoBU1jCLnFpe2uEmEfsCaBl/E9oPGNrfL+WVWoi+sTdAwN6c4cK6WvXQQRE/x1/ZwE/yZZMZJ82bJNVhargeqgwk38yg4JymkLfYC3AziMTss6ns0nG0TkGmlauxr+O3JukK4iEZDP2RA/Cb6HW196THBg8UXcS4z+JoNCmWttW6Vnytl5sYuDzNZ8uqWXqgjU70zz5BVRJKkPdMgPkXAvxMGUl+oI3Uqf0M6OFWyGRvMQbN88BEHnKCoZQlQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ec4c54-0c96-48e9-6e53-08df1b035434
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 12:48:42.4305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0V1xdvWa7C0r7r3xvSxQDzBW9GDw6j1vl9gUvatJMAg1axVGDbhYBguvnkf6x4huQUaRZaQ9uC+y+xGGKKeoDK2jIVDibRJvo9LjPeDz2Dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4818
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

On 9/15/2026 9:55 AM, Evgeny Sokolov wrote:
> From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
> 
> ---
Missing signoff, missing commit message, bad patch heading.

-- 
Thanks,
Anatoly
