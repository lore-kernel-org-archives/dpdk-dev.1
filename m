Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A441CCA476
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 15:05:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 985A3402DD;
	Tue,  7 Oct 2025 17:05:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id CCFA1402D1
 for <dev@dpdk.org>; Tue,  7 Oct 2025 17:05:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759849522; x=1791385522;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=kV7pzVyuhuybe2XmUvHJEm0BiGLhqvnbhNhVm3jKdlE=;
 b=dPdgRpOyGO5PSvyd+WarwmI7zVIYGSPwslYLNMne0gq0zdyLNleX/Bqd
 ydzH2urzFkAqO3Yeyz6CRqvPCynUy623aa7u/Ixs6bm+/3NC5OWAYjbOV
 CIziXEPap9uUW5OY6G2pv74ty7swPjzWigIS/u1QSrxUUAjU3Ij56Ouwd
 Kr430PYyn2bNqSEuw+eQ6oim4fLbX3Lz2Pev2iFVVZqgf6kY+c1mxnQdt
 MZzX90N1/oqxBJGfzRbt59RTR63MedCHDJquW4yZ/i8f5xlR678/LosNV
 l5QSIgKayKkrPJAdzJ+png6RUCCTcGMlUYFbBihdP6u8ET7ALR1P+0zWN g==;
X-CSE-ConnectionGUID: RbRSIOv7ROCwjkX99+WjuA==
X-CSE-MsgGUID: GxHIiEwkQJq2Nul4TzCl8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="73137605"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="73137605"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2025 08:05:21 -0700
X-CSE-ConnectionGUID: tMdiYHRBQbefy3rfE9/V2Q==
X-CSE-MsgGUID: Ykcs+btFTTa8Px+B6dxE1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="184546564"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2025 08:05:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 08:05:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 08:05:20 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.57)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 08:05:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6PLZW4txQHOGDtWL1vIvKp5vkHUAi62ir4OE6Q/y0gMUJAwGnzXrHHZeJZLx4vrCsrxoF4LmFkmUMH4i32Fv7X6kC7+bwetnT7vthMSAcpRoYnPOtiM6PVH/p9MDSlca7VbG82wXdEnTiXuz3VGP6EIyx11ngOZzuGz9vAw8QmyyKxtQ0JxwjDq3t3y9kKteh9eH3+QV2FJDt/Eu0fVsfZaISFebKqdMJ9qLPK9baeHJkf+EDYBTE2Tk2GX5MP1kX5BQLjLeZslSFneTE3YJRrJHFUzFHKFZNLSzpEa8vP60T2c5jsTXBa7LVG1InqSYFrZVP4DsxlxvNciFAqO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGkwbShumSuS9xykHRoz8Sl2OE3UL00Q9JUuy1UoU3M=;
 b=FKKmBaVV8TO6gPhLBnlY1KZz9LOb0cUhb5rEINR0elsQCsyLNmoMn4n/w5s08a+ItLY0PkOq0T+T8qqp8wiASDhatbxy++gnY5lLsfxbFhvjho9kbR/+HC1nQtval8/U1jrXQourtU7q8aAZjoGu0f6RooYGz63X5dgxGt46FX/VEOshRbgdODIayUrSpiJY80SORHd+nwiv9Q1OOLyFaFoGF5Hlpk1wehoI9S27klyFKfrDp8RgysDp77KTU7xv8UtSLdjHw6F4rLO0gp23pobau7LSPXmQ7HBT9rLadkyuuiP8ETW17uKOcRTTGEhRSrEJZMLKhFCr5WHcXx1JTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by CH3PR11MB8187.namprd11.prod.outlook.com (2603:10b6:610:160::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 7 Oct
 2025 15:05:14 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%3]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 15:05:14 +0000
Message-ID: <0eb6eb81-dafa-4f47-92c0-b83e8b04ffcf@intel.com>
Date: Tue, 7 Oct 2025 16:05:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Enable DCB/PFC support for ICE PMD
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
To: <dev@dpdk.org>
References: <20250817130152.682972-1-vladimir.medvedkin@intel.com>
 <20251003124037.342760-1-vladimir.medvedkin@intel.com>
Content-Language: en-US
In-Reply-To: <20251003124037.342760-1-vladimir.medvedkin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0219.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::14) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|CH3PR11MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da4b102-aa53-4809-44b2-08de05b2eb1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3JRUi8vOG1JRmNnOXFOVGl0bzlKOVNMOTA5L1RGWHlseGZaVW00MzBiYTV3?=
 =?utf-8?B?aDEwSWN5TDZoN2NUalB2VGdDdmVpMEJqNkxQcDVDaVV1OTR4c0JmNGVDU2pJ?=
 =?utf-8?B?c3dGNFRHbHpkelFDU0hNSVB2bjR2YTMxVDlSNG9uL2dwQmJMVjM5Ky83M0tZ?=
 =?utf-8?B?MmlING5qVGR5Z1dmb3ZERkdDN1UxSHBLVzFIOWRyRjhpYVlPUXNrdGJYalhQ?=
 =?utf-8?B?OGZRZnV2bDNKK052MUh4YTNFblA0d3BrWTFwNTNJOXA5eDNqOTdmOHl6UEMz?=
 =?utf-8?B?anlhOXBONUltTmxhK1pwWVE0MnJkSURaTGp2UmF4ai9jQlZlQmc5aTNBYzBV?=
 =?utf-8?B?TC9LTGdudTlKRDRTY1QrTnVzdWFLZXhtR09YQi9JY2VTVHFyS09ITHlnL3J5?=
 =?utf-8?B?ZEx2dWJHSjR5OVhnT2tGYlFNaWRtQnVncGtBaFZKMi9ybWMwamh3Qld3WHli?=
 =?utf-8?B?OGNNSmdSc3FtbHNOclRHU1NqdDJtVXJXUDNNNTU1eWMxVUVRblNJeC9GbS9y?=
 =?utf-8?B?aCs2Y0YrdDhaV3pWd21ZVldVaU5aV29ZclVES0h4VjF0eEt2cEtSMCsxNW1Q?=
 =?utf-8?B?Q1AyQjgvVjJwTXl3VzFrMS9LQ29haGxSUDdIL1dkR0UrLy9wYm16anFNWWpI?=
 =?utf-8?B?eGtUOFJQS2xUQ25xT2NOVGdNQ2E4dG9YRjRuNG1pMk9xSDIvV1FWWVZQd3lY?=
 =?utf-8?B?MitOYWFmeWFZTTdIRC9nbXg1N1l1c21jSFNiaVZoMVJKNmxiRjN5alZQUitv?=
 =?utf-8?B?TUg0TVlPN3d6Nk1wTm9aQXk4NVMvRldBQzhWMERtSkZTWkZkeG5HT1ZEREc0?=
 =?utf-8?B?WGFReFlodTBQNW5QNGVrUVVoOXdSa3RlUHc5UGpVY3ErNXFRTE1oK1F6ZzdR?=
 =?utf-8?B?bTQ4UklhcE0raHBPQk1jaUpleEtxRG5DdGc5cTFpVTA2a1VERUVINk5EYU9L?=
 =?utf-8?B?YzI1bmxEYTE4SHZGVjBoUHd2bHZ0NXd5NVMyMzVBakc2WFhWakd4eXlJbmEx?=
 =?utf-8?B?NXJ3dTduVFpqMzhNVjJQZmxMWWZpKzc0ck9SSk5LbEp3RHF0a05DQnlCQ2xi?=
 =?utf-8?B?THkwY1IzU0JIZ0ZycG1JTkVHM0x1dDNsd1A1N3hQWUpVL2VsdUlMdDhjU2JN?=
 =?utf-8?B?aytHSHF1ckJWTjlzVFlaZGwyaU1rcFljQk1NM2U1ZUZvWVREZDJJNWRKM0k2?=
 =?utf-8?B?VGtiRmE5NGxhRFVVcnZWY0d1SjBlK1RvRnE1Qmp3NTR4bWFDc1cyT01NTkhQ?=
 =?utf-8?B?ZHZiQnBTam1NakFoemR5VGpoemFUSUFpUUpPTHlIcFY5M094T1oxalVwQmRX?=
 =?utf-8?B?YURWVm5WdTNFTGZ0TkJiZGg0NlFLd0ZjNEFNUGJFMjdFeTI4QUVRVmlQcDB5?=
 =?utf-8?B?QklCLzVPSTRERVJNRnhOVmkwTEdPM3NiTTFHaitueVQ2T1pDZUYwRGxqaE45?=
 =?utf-8?B?YVZRRllnUEpTdGo1bXBIYTBvYTBQYWNBTHRHdEJsYlM4ZXo5SUFGejlSSm1P?=
 =?utf-8?B?U2FLT2d5eFBFSnNJOG82S1lqRlNRa29kTk0vTEtqK0I3aWJWaGMzZmdpTjNX?=
 =?utf-8?B?THRqOTl1V1R0THozb0k5a2gzcDJmM2tHOGFoZFpITHBORFlHKzZjWjdJcm04?=
 =?utf-8?B?WHNpcDMwNnRMYTNFV0ZuSHpYdlc5SDZqbU9LNmxPTnprRFdVWGM5akk1Ukdn?=
 =?utf-8?B?TS91RWtFNSsrWmhkRlgzYlZ3NFU3TW4zVXNMVkp4d1B3U2lSNGc3QnR4cCtB?=
 =?utf-8?B?d2pNWVZ5UzhXdmh2ZXRIdXR5SWFRSG9aRTU1aVZnZTAxRGV2UkdpK29HbFhU?=
 =?utf-8?B?blhSckNMc2g4T1QxcmhEY0R6WXJYQW04ODRTUmxpcjNRWjdwT0xURjZmbzJr?=
 =?utf-8?B?ckhNbkRzdWJjUFlkNUJXeGV4emtBbXcvck5iT1htYWdhc2F6TjRhWTlPT3Zi?=
 =?utf-8?Q?klwmV/bGshYk3GfRmhvNIsPu7oKjzyQd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZThzQ0VyYlZPMnR4bHN1SXJzVENqZXJwbWdKWWpCZlpaM1hWblkrUSt4RlRs?=
 =?utf-8?B?L09YR1dPTHNaUVdoa3VQRTFkZVFMd21LZ2pWQ1A3NWNOOGdmM2lqSGtpL2pD?=
 =?utf-8?B?NEVCd1hGU0xvYy9XZXpyT2Q2Z0NMNnd0YUFFOXVHQVVvZzB0Nkk5OTA5QkI5?=
 =?utf-8?B?Z2ZSQXhjTitMakRiZWNCUk4zbi95dC9lSUZmelFtQy96dC9IbVQ5cjZWTVBL?=
 =?utf-8?B?a2pnOXFZM3hwVWkvVmVBTHNraldTeW0vbjd0cEFmcmRhUm00NnB4WTJqbmky?=
 =?utf-8?B?eEE3ZmFUZG9MNC9SYkVYQUdlaDFzR0hyRVJtellWRWxuNUZnTDd1U0xGcXBa?=
 =?utf-8?B?Uzl0M2E5c3lrUDdxdDd3aXgxVGcwazc5UjF4THF1SFJtTUdDYU5WajhlWklo?=
 =?utf-8?B?bENqRVBEaEZRdy9GZzNUMkErQWxBOGZybmh4VEdLTUFMOXllSVQzWE1FaTBH?=
 =?utf-8?B?KzFnT2ZSN29LU3ZUTHpUNFdrcGQ0bVVqZHJxMElaYld3REd5T3g2UlpyUDFv?=
 =?utf-8?B?Ni9rWGlIMkE0T1dWUEM1cGJhUFZkcVMzYlNXVHFYdjJESzRKN1p0NlQ1czJM?=
 =?utf-8?B?TnlYM2cwRlVkR3FOcHA5Qng3NjhIU2hzWm5pSmpqNTVkT3Jpc3FNb0U4U2gv?=
 =?utf-8?B?YTVDdlRYMmJtME03emFXL0NvZ3d2MVFaejh1V1ZXUys5TitXYmhNdmxOVEtH?=
 =?utf-8?B?SnloejhjajVwUjE1aDRMU0hpUUdKWGlTZU9ya0dwR1hhU1VxbW0xdk56azRN?=
 =?utf-8?B?dHhHOFRqT0t3bm5aZUVPQWpKL2xQQ0hnSlBvTUJVbmJGZmJ5d1FvR0Y2emZ3?=
 =?utf-8?B?TEphOSt4UG5TYzVzREtqdEJqSjVrcjM4MkFPbWdRdHNmT2YvaU00YlV0dnF1?=
 =?utf-8?B?TTRTM1VjODBrZnlsOGcwM3hJMW1JSzZhS0hzYzJMRkdpcHZRMzlrVW5ZNjJr?=
 =?utf-8?B?dkhYbHlUSnFYNGFyZFJFMThBZmdQZHkwY1FMMnFjMHdkMjJ5L2I2TXpFbXdM?=
 =?utf-8?B?OEY4ZThwZWpEZVV3dlBUaWlnZ29mSGcya0QvOFdneCs5ZTdWdHpGM3JpS3My?=
 =?utf-8?B?RGhZUEk2RFEvRmlhSWxZNkNTWUdrREtlT0JpQVZmUUVQcitoQStZS080bi8r?=
 =?utf-8?B?UHhxQlpNL2VmaURmT2Qva09ZUFdHT2Q5cXJvNTQ2aUtxZXNqOG9vOVBSTFJE?=
 =?utf-8?B?Qi9oN0VuTGJVYUdUQmFFUmo2UEdwZ0EzMXZ6Yis4aEJlUXNhUEFBWVU5ek11?=
 =?utf-8?B?d1R3RXRMT0ZGSnVKOWx4eE84clEwVDBKU25nODVsMUl2T2dEZDVCMjZUcFRx?=
 =?utf-8?B?a0ptL1pCVnVTOFdaZS8wdi9OdmE2c0syWGtuUEI4emthb1lXaFdyUDV5dEM4?=
 =?utf-8?B?d1lBdzJ2OXlWNThSQ0Zlcm9PWElIa0NaamkxRnQxNEJscEhnWUsvbEFEM3Ru?=
 =?utf-8?B?NC8rdTFPdHRrTXprd05xTWJ2Q2NGOTB4ZWQvS2ZhTE5nOGtIbmVNT0lFbGQr?=
 =?utf-8?B?Zm83eUNRd1ByV0VsUS9iQUdWRVc5Z1lpbE1jOHk4S2tRWWRZUFRONW5oM0xy?=
 =?utf-8?B?R0VMenVqRWMrVzN5UDFVMFRObzFoOFVpQmE1NnZTcFlVOFZ4SjZ5elZVdTdS?=
 =?utf-8?B?SUdHQ0ZIMGxQNk9UcHAxM3k5a01yMEtNQURpd1BnMjdYSVZ0NzJSYVppd2xx?=
 =?utf-8?B?aGUwZk5DT0FXLzhIbTVYTW51a0FydHB6eWE1Q3FuMndlaVR2S01LWk5ER1h3?=
 =?utf-8?B?Z2dRdFd1NFdpR3o0d2J2cDdKU2g1cGt5Q21UZGxmb3VId3V3WnM2SDB2THhw?=
 =?utf-8?B?aGpqa3g1Y29kQTNveUF4b3F4d2ZLbFRhWXMwdzd5REtQbVFBV3J2ZkhHQ2Qv?=
 =?utf-8?B?QVZlNXRoK2dtenVqdXk0cnN2MHB0UW9TTTNsQ0FwV2VJaXh6Z3U4MWpUSTNk?=
 =?utf-8?B?eGo3aitMc3l0bUdENktaRXgrRXhNL1d5dG5VL3dqbVY3dUplUVd5UUJabk51?=
 =?utf-8?B?UVBVV3BKUmVuTnQzTVdUNTYramVUcWVyT1RGV2E5MGNZczhrcWhTZ0xWekx4?=
 =?utf-8?B?cG1RUGM1OG1ybUl2VkY5NGZoTmpxQkgvNnNvTDJmd1hhQnNDQ1Y3Y2R0dnlY?=
 =?utf-8?B?djYvNjRZUWxqODRyZitWckt6MXpZcDArVmJlVEtXRWtVbi9kbWlzcmlHWFM3?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da4b102-aa53-4809-44b2-08de05b2eb1f
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 15:05:14.2478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lvez1jcZ0LfaUEoRcWxnaAgtttBuK+EUKRRJYvazM7k98o/IhIPInkebQ0OMLvGbD++IlNh/TPygbfb7UXzT7uXdp/ABPYIHwKFMG3dxmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8187
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

On 10/3/2025 1:40 PM, Vladimir Medvedkin wrote:
> This series introduces an initial implementation of DCB and PFC to the ICE PMD.
> This includes adding support for TCs in ice_aq_set_mac_cfg() and asymmetric DCB/PFC configuration in base code.
>
> Current implementation relies on current API and has a number of limitation and assumptions such as:
>
> - Symmetric DCB configuration with respect to RX/TX, only dcb_rx_conf is used
> - All TCs are configured equally with respect to BW they share
> - No support for Low Latency TCs
> - All existing queues are split evenly across TCs. Number of queues must be power of 2 and be no less than configured nb_tcs
> - TX queues assigned to TCs the same way as RX queues
>
> v5:
> - drop base code patches
> - rebase on top of the next-net
>
> v4:
> - fix more endianness
>
> v3:
>   - ice_get_tc_by_up() is renamed to ice_get_tc_by_priority() for better clarity
>   - added ice_aq_set_mac_pfc_cfg(). Old ice_aq_set_mac_cfg() is a wrapper around a new function to keep better backward compatibility with an old code
>   - removed rte_memcpy() and memcry() with direct assignment
>   - addressed various style-related comments
>
> v2:
>   - fix spelling
>   - replace rte_memcpy with memcpy()
>   - fix endianness in several places
>
> Vladimir Medvedkin (3):
>    net/ice: enable DCB support
>    net/ice: enable PFC support
>    net/ice: add PFC statistics
>
>   drivers/net/intel/ice/ice_ethdev.c | 370 +++++++++++++++++++++++++++++
>   drivers/net/intel/ice/ice_rxtx.c   |  21 ++
>   2 files changed, 391 insertions(+)

Recheck-request: rebase=next-net-intel, iol-compile-amd64-testing, 
iol-compile-arm64-testing, iol-unit-arm64-testing, github-robot

-- 
Regards,
Vladimir

