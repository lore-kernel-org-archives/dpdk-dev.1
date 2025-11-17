Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75418CEBF61
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 16:06:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FE9E40262;
	Mon, 17 Nov 2025 17:06:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 82D3C4025A
 for <dev@dpdk.org>; Mon, 17 Nov 2025 17:06:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763395618; x=1794931618;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=gCIiB1fX4AOFyDCNoFuGAKDnifJsmW6SAJPq0VBpXHg=;
 b=GLm+HcX+mxizwU9rbayzNmRuuK20kDExQelsOgUDPIjZ0tzB4iHq8JdQ
 Mb8z2ljm3WSA+TEECJ5p/YA7Y72bi+qbghyPB9giuy6+2Ax4hcnznIEgW
 E8MdrIBhpv4KsOwNDrWMCiSE0llF9ecKqG10dsxlMKB0ePhLX3AfgXjMJ
 cjteyGaoxEFPOSaR8baym1uoYRfFO2YSigBl9w1JzPBs3nEr2PWorHXWG
 OR+HOuHLQbhEQDLefT/zrV0Ev0R0coargY+6RdprxlYX+pbueweF2MDc0
 qKUaE9qvc5y4EeVJYjDQ4tn30VVBnpju/ty9J4SbwdNyn1NIQFv1kll9/ A==;
X-CSE-ConnectionGUID: BL8Ea9lNTreNTS3RwE9fUg==
X-CSE-MsgGUID: xDBFxLZxRwS0CA0NK4wHtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65493366"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; d="scan'208";a="65493366"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 08:06:57 -0800
X-CSE-ConnectionGUID: vyjNclzJTGG84Me5E53auw==
X-CSE-MsgGUID: 5Da0gHdbR3+Bo2rn0qByfQ==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 08:06:56 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 08:06:56 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 08:06:56 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 08:06:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgehP1CFoZvGPbUkzUXkf9lZtgJSCtdg/u4i3Qfk2VsD08VM5gr3t9UzDuQCqX8r4/F++ZgMBATb9mWWFsq8saYpnprwU/PZPaB5O6kcSwphOHz8gtJIc5ijVIJF0Oe/iQFE/XtUCWudA/NtZ69LQWoh7IMtPEf2sltre5H6gLkBygRrBC/afj6RGbnHimoehCcbmH5oHBTxJ2Q5SZv4LqfSdfEOxSuTdlsegSR0kRxT32G7yz+Va8fNm9cjCbgYx0Rx5LJe0/MPk0vI6JyG7Jhuf0UhYdGKUFecYmJQHfgtPz4J3XjZelqncQvN+eavVw8TrO3kUpVncYYSM2O2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOUutmAN6KyL3/5UUoxR1cjqmSSS8A7QykfiGDmJhx4=;
 b=CemoN8KwQDqZTUQ86ReCYb/Afc/SgXCw36bbRqy/pICMKvPT1WgGrojnqscMOFifqrnGtzaUNh4SxocjGeJYpCVzM7rT/84eDdtyhS5+xlygjfKxw6iHQXiitIhtxG/rEcxqfGSNVHtcnzMtRipS8YJ8OCrXMJVDODdYC6yMHHtmIXDNM2Rqp0cy9nHB/vAIJAc21ozAy/0PlJYpMUPkPEkr4HbztcwAJFr0aKOWgP2b/psoQC8nCb7PjaZAQsVEnDi6LFBmJe8nfObJBdgl57BsRR8ONGm2sc5DvDe2mX+aldcOCkTotvOUdQNiNLxMQ9jI/KTgToDUXgBl01jFlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SN7PR11MB7591.namprd11.prod.outlook.com (2603:10b6:806:32b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 16:06:51 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9320.019; Mon, 17 Nov 2025
 16:06:51 +0000
Message-ID: <192cd9cd-ac37-40fd-a5e6-2b51d5399b2f@intel.com>
Date: Mon, 17 Nov 2025 17:06:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/e1000: add check for filter mask range
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
References: <20251114182131.1296580-1-stephen@networkplumber.org>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20251114182131.1296580-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB3PR06CA0035.eurprd06.prod.outlook.com (2603:10a6:8:1::48)
 To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SN7PR11MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: faa8fe86-170f-4957-a8ca-08de25f35174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlRrWkd5M3FVV0xUdDAvZFI4UXF4Zlhkek50VTFrYUJWbGNFZ3dFWC9JbnBj?=
 =?utf-8?B?bEJrTEFxWU0wQ240M2dSVTRhYjBhc3hsdlVrcDl6TUR6TkpSUk9yRE5zK2M1?=
 =?utf-8?B?czYxdlFKRm5MQWxORzgvNHQrWG05K2RpUmZYUDNvNHdVWDlrY21weXVvOHM2?=
 =?utf-8?B?cjNxR0FEdTF1NGkvSlpzc09uS2dwajAzdHRLTTk2b0ZjVkYveUZxSC85ejhI?=
 =?utf-8?B?QTI1TTlPVnFzUFFEa0xOYUdPNU1sTE1NNVhnd3h2Vm5UcmgwNVVBWDVwbGVm?=
 =?utf-8?B?ZzcyMEo2RHZFUGp2UjFPaVplbS94cENIZjNJM2VPTTBZNTRtUGY3RmhDV3A4?=
 =?utf-8?B?TytpN3hFMk1RcEwrY2JPM0M0U2hrNk1VS0d0RTJ0QjJMeWZTQ0U2TU5UNGc5?=
 =?utf-8?B?QVg1WTZ6UUZJOVlhV0QwNnpkalA2aXFyelliVi9tMDVhYnZ5ZFM0Um1WbC9t?=
 =?utf-8?B?RUp6aW1jSnlUdis1UDJTYmV3MWFMYXkvck1nT0syYVI2bEpCR3dIR1k5U0Fp?=
 =?utf-8?B?TWl3d0ZaRVNUamFZTmNlM2JrQ01HOG5wK291QU5FaFdOc2FqMC9KVmFMY0JT?=
 =?utf-8?B?YzQrb3I2aFBhQ0tzcFZHTVdlNGpWajhiMHpwdDJ0eGdpU0xmTUVMSkMvQkxN?=
 =?utf-8?B?RmF1ZVE5RElSaXhZaG9PTXNFektQNXVhOUNhK1FVKzRlT09uMG5pRXVoS1p3?=
 =?utf-8?B?bDNPVndWcDZnZERKcDE5UXJvdlV2YW1rTDBaT2xPSW9Hazg4clIyVmRuVk9m?=
 =?utf-8?B?Sit2ZEtkUDFyYjBiZlJsVVdxdlNzV1NGeGxXWkVMUnEySkNvcThGWEthMGRy?=
 =?utf-8?B?WE9OZFVJN2VzY2xSWXc1S1ZpR1Z0TFM0d1JWdk9kcHo3eVU3MnAzcmhvTUVy?=
 =?utf-8?B?bTZBZEdlNGQyU1FLRnk1ZW1XREJlZWdvbU5FR0RPc1B6aWxidDJwc0lJS0Vu?=
 =?utf-8?B?LzdOZ0paOEt4d0ZKMEtDVHNvcThLbTZvZU9YdkxLWDRuN2VCUm9IM1RQK1k5?=
 =?utf-8?B?WEJtZE00UlBnL0xqeGplZ2lZS1RwVm4wUXBQZFFoVmEyYzZlTzJVUnlic3Q5?=
 =?utf-8?B?SnBJeVlkRXNOQ3FLMW1tYkpYc3h5MjRIR0hEdDFhS0dsUExuYUpCMnI5c3lH?=
 =?utf-8?B?VDJxcGxvd2NrdFN0MGluRW83YkxQN1RSc2x4dmNWRzI5NlN1WVpSK01TaWty?=
 =?utf-8?B?b2xHSHBwNVpKNXNxaGMzR0FxVUhYNW5GdXJ0VmJyRmgrNjhFbktzZHJmb0FU?=
 =?utf-8?B?Tlc2eDlEWXg4cG1PYU9YS0twVWp6QUVtT3JXTzFMSitsbUVSME04VnI5MUFr?=
 =?utf-8?B?cGI4MFNjdzhBVjJlYTdXSGtPRXpBbE1CZjFRQmZVd2lSai9xQk9JOWtMWTh5?=
 =?utf-8?B?TFBQMUtHemk4bktlNlBuek1YL0FyN3grOU16OWVYRks0SXV6Q3NvVGdOVFhq?=
 =?utf-8?B?emwyenUveGR1aGtvVjJxVXNVM01kRENXb0NTRDVJY3M2UUlKeVRiakFiWCtQ?=
 =?utf-8?B?RlRkemJjZ0JOaWJOcEdxaTk4cWpDbHhDVVVDcEhkUzAzT2VhYXdudEJLMjJa?=
 =?utf-8?B?YVZxSURXbi9BLzBxeTlYMmlzV215RGVQMnhHNXJxdGxmOURYVkk3RWtHdk1F?=
 =?utf-8?B?eFZwZEVrSjVYWlBjTjRHMU9VVUkybEdHVnI0US9QU2dDSkZxQ0dGKzIzdG1t?=
 =?utf-8?B?a25idnlXdUEyT1dyZCtUS1YxZEordXFXLzVzd1hSNEpWZVl3cWMyZmRDblhR?=
 =?utf-8?B?dW03L1lCdmFxK1lMNTQrWE9oaFN2MDZock81enhZMEo2TnJDZjA2VnZnM2p0?=
 =?utf-8?B?TnhyL3R0RXkzd05DMDY1R2xWcUVPYlJjZWRLbkFLbHB3VzRIMGM4cEhGVGtJ?=
 =?utf-8?B?cmNIUldUMExpb1lzQkZlQzQ0d2FqVFJ5YTRpZW5lbkdKMFdUbWF1bTNIRmFq?=
 =?utf-8?Q?JpjCwdHaW6XZk+2/J9dW3lhl9F25o8Wa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WC9kczVTYmo2LzJnbmtkS1NEa0k5azkvZW5wOFJDVWp0L1FUR0NTZGpDSUM5?=
 =?utf-8?B?YThuME0wSVpZL2lCQTdjOEViTEhPZm5oM3JkZ1RhWjhHYXliM004d2pRWTNt?=
 =?utf-8?B?Y3o1c2txeGJLV2FrQWwxNDFTdmkyVld3cnRwdlYxayt2T2N3a213OW1NcGdL?=
 =?utf-8?B?RXdscnBldHdvb00zZGpWRzhzcWVYMlQwV2JycW9jRU8wSHZvZkxUUHdVQ0Nu?=
 =?utf-8?B?bE5FeWxGMVFNdjVIRXBLTU9QT1c2aTkyNWRWTEk2bkdiSm0rdGVXek1WcGpG?=
 =?utf-8?B?SzdyRXJMOGR1N0Y2QnJ3QUJzdkVSNW80TTBhS2d2Yzd6WnR5c2d4ZlpGalU1?=
 =?utf-8?B?OXduRThybER2MWhYVnFvekw1Qm5nMkZ1UGo1SVk4aGZ1OXVQWHYyaFZ1c0hN?=
 =?utf-8?B?dFVjeVJZb3F6Z01hWThUNmhHYkw3YlVwOEx2NUJTM3JVeUxaQll1WWYxZE1w?=
 =?utf-8?B?ZTdudGZndm83MHNBWlMrSnV1cTV2WTdkeHhDYWg1SEsrdTNkZExmWWVEankx?=
 =?utf-8?B?aXd5bXBUblRITG54S3RSVVFDUGpCTGFKTTQxRVFPYlBVdU1SVVRjaWZ4cXNX?=
 =?utf-8?B?dnpMZ2pmc1EwYjYzTUVjUkF3d2xkd01HWGlibE9xVnFJN0ZWcEVYK3V0aFRV?=
 =?utf-8?B?ZlpxU3o0ak1ZZk9TVnRzV3kvVndBYlZQR3AySjZTYVpYZUluQ0hFd1VCS2pB?=
 =?utf-8?B?U2ZUL3gxOHUvN09DVHhWbnpzWXZDbHdJQTN4OE9hcW1TRXZVQnFZR2NKdjZQ?=
 =?utf-8?B?eXZGeVFvVnpJOTFrYWs1bXowaGRqcWdWZE45anErZzVaeGhXa0piWDd5enRs?=
 =?utf-8?B?eHgxTzJxWUh2YS9uVHhIRzZucC9NdFNuNzFVcUJKMEJzUURrRjJIVWpHNFRN?=
 =?utf-8?B?WWZOd1BrRlhqZldsdVhLTkZiYnN1MmhKVWJDMW1zcWVXdXcrQjVEbVNMUFVq?=
 =?utf-8?B?ZEd4L0hhRlEyaEtjUjJjMTJoL1dCRDMrVkc0TTFpcHNMZC9TV3Fsc254TEps?=
 =?utf-8?B?alVkOGhZVnFvczFiUFZINVkrUGlodU9KNmxlOHBnRkdEOVJUcldlS21ESHU5?=
 =?utf-8?B?WktnNkJud0ZtTHlZMVQ1eG5MSlhBMnF5Mjg1QVlmTjJJNEtDNTNMaHNpY0RV?=
 =?utf-8?B?bjg5eUJRd1p5OER6dHhPdEhXU0tlRC9IeTFQNy9XamVMeDJHZ3I3aE1kbW9I?=
 =?utf-8?B?ZUxkUXpJUE85YWdrMDNFZ09oSFhVVDkvZm5Edi9ZYnUvbkxTMHVMaTR1RFpV?=
 =?utf-8?B?bm5rd3ppY1VIOE5VeXlCRDZEcHFCY3BrRGJ2VlVlNjJxNHBUVG42Zjc1S0hZ?=
 =?utf-8?B?NjM1VFJHMlZxSGcwcm85QlpDMHVLd1pPWWJsQXlWTEpOWnd5SE1GcGIxTXJJ?=
 =?utf-8?B?cXZ6MEpBYnVPeWdJK253bEs1bGJFRHQyTFlQaUJobFNZZGhxOUdGWkYybE8x?=
 =?utf-8?B?NUNjWFJDWDhhQzNTbkZuUWVvYXBuVkVtMWpINUNIckE2aEp4aCsyaEZRcURM?=
 =?utf-8?B?cDRzaVp1dGJCT2FrZGhrbDdvc1g4Y1gxQWJTc1Z4cXpJYjdyN01TdVY2Zmxo?=
 =?utf-8?B?TmJ3cDVkUm1MZEtsNXE4Uk9tWUw3ZHMzS0tQdlpHd1hweXZYWHdHRElFcXVz?=
 =?utf-8?B?L0xDajBKZ3c2ZU9kM1UyQUlLTTRINTF5VVhXSGJONjdXVGtqL3J5RUlrKzhP?=
 =?utf-8?B?Rm82NnhLT21reml1elBmY09FYTNkcHpxc3pHeDErd2E3Q0xxUTVCeit1b29Y?=
 =?utf-8?B?NEl6SVhNR2dMZEhOS1RINkIxbmlTU3I2anpDSlVmZTlZcDlzdTVpOG9tTUgx?=
 =?utf-8?B?b2NHaDk3akREejR2dzVpWjA5Uld4ZTJRRXUrWUI5RmsrWWppNldOSld4Yitn?=
 =?utf-8?B?bkg3KzBXd3VvTy8rN3pXSllPWVhXcGJZeEZSUjErcmxyaEgxK20vQzl5Z2pa?=
 =?utf-8?B?eWJiamlTOFg1VGNyOGZLQm54QWt5NFdLUS92SGxaYVZ1RUIxQzlwWkpmWUpV?=
 =?utf-8?B?VkF1bmVwazdMNlQ0OXpxYSs2Q3F3bWFnY0ZkUTZ5Vi85L0dXWGhTQWovNDE3?=
 =?utf-8?B?VXBsdlRMNWVyUGtJSzhxVlF6WkNUUlkzbU8xcTRvOXZ4RzZ6MkE4K2dtbmlv?=
 =?utf-8?B?aDRxK29ER3BKQ21IcmJTTjV5RmlrblBXMVc3ZTJ4b0hRK2czU0ZkUnRXVEp5?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: faa8fe86-170f-4957-a8ca-08de25f35174
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 16:06:51.6842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ss5uza7TTpXx97VWOu3AoOHGRVADTbEl+UI3mccodu5KuC6LuuCeKGY7od49y5PZpQ3gfuIlZY2Mcz3vU8ld8U3Ebw5CXplAqtKCeIblC1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7591
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

On 11/14/2025 7:21 PM, Stephen Hemminger wrote:
> Gcc-16 complains about possible reference outside of array
> when managing flex filter. This is a false positive because the
> filter length can never be that long, but compiler can't detect
> that. Add guard rail check to only loop over possible array.
> 
> ../drivers/net/intel/e1000/igb_ethdev.c:4265:23: note: at offset 152 into destination object of size 176 allocated by ‘rte_zmalloc’
>   4265 |         flex_filter = rte_zmalloc("e1000_flex_filter",
>        |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   4266 |                         sizeof(struct e1000_flex_filter), 0);
>        |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/net/intel/e1000/igb_ethdev.c:4280:50: warning: writing 64 bytes into a region of size 0 [-Wstringop-overflow=]
>   4280 |                 flex_filter->filter_info.mask[i] = mask;
>        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Reviewed-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
