Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271B8EA8112
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:31:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 742D240659;
	Tue, 10 Feb 2026 14:31:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 6D5BE400D7
 for <dev@dpdk.org>; Tue, 10 Feb 2026 14:31:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770730310; x=1802266310;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=nl+lqwWv5l0Ey07HFG85GGwf9tT1xpcNeSjyenNW9VA=;
 b=J+p+UKydbLThjyVpDFPY8Dm7OOh53/R5+mEdHamvBVxh7Ziz5Wx7Au/1
 KI4IrIzTzE7Nifcl4/GxPb0J9SBuFSczLeWEq+lNCuh7rdCrAOWsNvxaV
 1DG5+R9HCAFJyqzZwQ9he/15rO9C8qQerAoueyfBiGstazAI1o9LY8p5t
 vdmswGmFsqu5LGcvD4MFIEuNTvFZkwigljxDlcZUVYxvLBY9IYSOrBYgp
 OK3Huw3+y+8W30x/bRn05tLf9EG0mE/MyYZQoDNvR0thkvsOsdUzya166
 TFFxoiQ1se6HXPgO918WJCEBaP6EbJCFJeFB4ciBLj4TO01wKdulk2qnG A==;
X-CSE-ConnectionGUID: Xd9/PX0BTOikdL3Xv6uERw==
X-CSE-MsgGUID: zWzxLyuvROOqnHQVzVZpkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="94498621"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="94498621"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:31:49 -0800
X-CSE-ConnectionGUID: voYFueZmTVq3rGcvlgOusg==
X-CSE-MsgGUID: jHbxoiB/QPyPRu7H6y8UIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211022374"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:31:49 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:31:48 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 05:31:48 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:31:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZ5cta2C+QF/CB+8BXqYidHEetsXEAtaPsNdXeDY/yrh+e62v2/hBkgSrLWuNmEtPBkgQYLl2VycpCv20/NCzUS30RWg7vp+lbEFvFoUFrxeunPMcS5nvdPNcMHRF+1dthqvUW/F0cwdRxGfnwEZf+glmIyubedXutzaDJdvEzBrx6MVGAyCPH9pJoylM15juI4TfXLIcstfL0e66i1+SQu1xQsD8UAn6Iy6+DdM1j1Qqrn1X48AVnVbni4/TjcT4GG9c9AVxv6i6si/D90moI6jd0W3L8Z8QaF3ZXI479boW0AdfOchB0Txbwic+LmekhhOhKQ1f/5tZAKrvGMyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRQOw0gRGTTcXmwqQKi2M9ksSR6ND6fYb0qjSUAhTDU=;
 b=MgSZryKQH0H+7fabrEW/1NhQ4VziFJey026JgIGJmItdX8QFYtXZmT/jwhZayk5tRFTtwfge5GdX5QAD9NIETsBiuyKFX7Y5PGst42WurkD5teP84gDUdKw8dx2KdtavfNqVVNM+raJAf8q9mBlOJerbTQTX6LllSmSzIQmTv+AbWSChea9apbGOifgIC6PV5Gjys3rWdCYbtchIWiehLk1ZcSVMt5zcgZJtVzR8uPpGB2zQYBQszUUyB9VHJrdWCMbfDSijgSnW2utAVPaiZDTLquQQ0YXDfyCqEpr25+eWjGYq5XDuW+WU1COOagrgAaTp+WoPdMj1GghzS6shCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ0PR11MB6766.namprd11.prod.outlook.com (2603:10b6:a03:47c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 13:31:45 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 13:31:44 +0000
Message-ID: <0f5bdde5-bab3-4c8f-9a76-e141c229e611@intel.com>
Date: Tue, 10 Feb 2026 14:31:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/35] net/intel: avoid writing the final pkt
 descriptor twice
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-19-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-19-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0281.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::9) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ0PR11MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: ea67b8f7-6cb7-4b21-2555-08de68a8bb4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3d2K1AzbWI3RlVOK2hLazhSK1V2UzAxVW1DbzdMdzFYakpRZUdtazlMWXg3?=
 =?utf-8?B?TXlhRE5ySlRvNTNiUmRQZ3NVUUFHTTVyL3JNR1IwSkhwbEpQWnNaeVkwemtF?=
 =?utf-8?B?K1NtVTA4ZmFFRXZ3SGtySGtmMFUrczk0SXVSVC8vbzlUOHBVTjZpZzhVRFRO?=
 =?utf-8?B?S2tPditIeVgyaUNHSGRncU5seFRIR2NuOTd4Y0NBRXRxWm9EcGlGWE1WYzc0?=
 =?utf-8?B?YlZadG14YWVVN2tVOFN2dHd4Z2RMeVZFbUNMalJyckk4am1SNGNOOGhFbHRS?=
 =?utf-8?B?bGN2Wm1oK0pnbnNtbHJTRjNKZXl4cjRkK1hLaWM0WTR3YXZ3cGEyT3FsQnBN?=
 =?utf-8?B?cTFZREplTWs3aG5ZQWFGakx6U2xBV24xbzZpOUpHWlFXekNtdXlVSWRGTERu?=
 =?utf-8?B?UVE0N0Z0QWhpYUVUbG5ZcmZyTjExOVZ0RFBrSndOQnZBbFp5RVc0Yks4M3o3?=
 =?utf-8?B?MXZ6aWJpVEFEWmc3aEF6RGtIWm9JTmJOaGZBbC94Rmw1MWx4emJKOCt5b0FX?=
 =?utf-8?B?M042TlE2bENDY3VrZksxS1RXc3htUjJSL212MmI1NU9QSm5uWDZVZEJHZDFG?=
 =?utf-8?B?dTF3Ui9LVEVwcmRrMGhIUGxpbzVhZmFhTjM5MElZcmF3dCtJNHphbEtQaTZO?=
 =?utf-8?B?N0VEa0VsREVyaFZ0WTdGUzFxZlV6NEk1ZTN6REhTNVFSM2ZsY0Q0T0VqOXdS?=
 =?utf-8?B?SmUxY1N4VjFVd3Q5ZEZiN2tBUXJCVXdVd0hOZmcyVG9GckR4V1RqaWswT2ZO?=
 =?utf-8?B?Tm1BWmFITzYzZGxqWkJ3Z096cjVrdG1MTlZPTGw0bWZPdGVuejFSUlFpNGNX?=
 =?utf-8?B?R3VFdEtQYXB6bUpZMSs0SCtZQ3lieEtveTU1QWVCdzR6cURJOWR2REJKVjIr?=
 =?utf-8?B?YmxmOUg2Y1B4bUMxbGVYZi84bFMrQVc2bjVXQUZ1VUJvbFJUNTU2WW1oaWUw?=
 =?utf-8?B?U2gxUGRxV2c5SDZBU3Q0SjF4OU5EeXR0c2h0Rm04YUpMUU1EUFczQ2k2U1No?=
 =?utf-8?B?T2tUVTVESzFjRzRlRk1hOFFOWlMwYlR5RjU4d01wTDZneHcwdmY4bGpsb3ZP?=
 =?utf-8?B?KzMvT3BINVdVN3ZhNzRYNVMxaUptamRGOGZNYmNNNnBWVWlTMnVlRmtTNU1z?=
 =?utf-8?B?ZENOWEpzRWJlRXVvOTIraHZpNDFnaWFqSHUrcGVVUnhSLzQxUVNOcGtUOVZt?=
 =?utf-8?B?bWt3MXBUSG1IOVp4SVFNaVlkM2RCd2h3Nkk1MW0vNkdYdlkrVEtoK0pwaW1H?=
 =?utf-8?B?VEkvUTNwRzNCUkp4MWk3dFRUek1rdkNSc3VzNlAyczFOQXNtQ3FTdk9wM2pN?=
 =?utf-8?B?anJlakw3L0J5aG5xblhXbzRRZXhCZkpyVllHcktpeW84MDJuVXRNOUp3YnVk?=
 =?utf-8?B?WENlREEzN3oyOVF1MFd5Y3kvbVV3SUl2T0c0cm5KR0dyNXZaaHFIVTZKb3pY?=
 =?utf-8?B?K1NNN3VESzJydHhCNkljSHhBbU1NWVNuY21oK3hHMENVWlBGSHBjb3kvaVJZ?=
 =?utf-8?B?M1BHa2hqWFloYzV0MmFvaGErZjdTSHU1S0UxQWVaaFptWUVnYlJsU1pLNFQ4?=
 =?utf-8?B?ZEVSbnk2NW1CMExCZVlhckJZNjc0QkpIL0Z5NFJiYU45Sm5EeThwY1pXcHk4?=
 =?utf-8?B?d3dNQXl5dFdsa3JsQ2dxYXlMQzR5cVVOZjNJNHIxOWhBL3l1ZVRaZk5XRkw5?=
 =?utf-8?B?c2Y0V1dhdmhRa1M5b1JCVzdjMVp1OTByTWszZUdRVUhBckJGNDV6NCt2djEr?=
 =?utf-8?B?WHZKRk1FdzlJME9GUStFdFpXT3VSckp5VUVUcmxOaFd6S09abTNjMEE2ak9u?=
 =?utf-8?B?N1o0R2MrQnNUTktERWQ3UmNIUTU2MzhMU3p1YmozS1hFeGlYUmM3UEt5dkt6?=
 =?utf-8?B?NFJ5b0JWWFE3THBTQ2NnNUloMGVNL0lXNjZ6T2orYnBLYmladzZkRksyMGxs?=
 =?utf-8?B?NkQxbGRMY0Vod2VXUnZCWWduTlAyQ01aV0MvYjdxVFFVN24reXlxcG53OHYw?=
 =?utf-8?B?UVBNY3dMTHU2Q0dueUxjS1dDT29GSzFHT0pHVnRLZDBORndiWGprbjl3aHJl?=
 =?utf-8?B?ei9taXc2Y2Q2OThiY2tveG5rRmJlWXEvMlZ0eDVNbk5ldEIzUXhjSHlsUDBK?=
 =?utf-8?Q?q7bk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG00S1hvd3pWTjZGeDExYnJiZlg3OUE1d2habkhUUkVaaFYvMEpzUGZoTnhh?=
 =?utf-8?B?bHBwK1VtUDRxSDh3aHd1aWIwQnRNMGMzYkI5TEJQdXFGOVl6NzArZ3lSMUUy?=
 =?utf-8?B?d1hkL0xDaTlseFI3QjJmYmlCNTVTc3RiNHJkclFSNTgrbFg2dTBicW0vOWEx?=
 =?utf-8?B?R1FTMmllVTVxTlZYRy9CNGRjak5HcXpRVW0rTWR0aTd6NjRlSUR3RFNqdk9z?=
 =?utf-8?B?ODlPYWhNY2Q3cmhUMHVXZnNSNkhpSnhSZUZOcFlLYkhhUmFmcDlnalFRM283?=
 =?utf-8?B?RmJ4MXU5V1BBSlRLTkpLZ3d2RW1FNURzNFV6d2t3QkVwUG5McHpLNmxZaGp1?=
 =?utf-8?B?VWlWOHc5NldCK1V0WnpCNFUxS2hjdHoxOEFUL2t3bFZxcFBzTGRRQWkxV3g1?=
 =?utf-8?B?Q3VKTnRIZmVhWlQ0czBXelR2U1dMbWJZTDdPNFdkeUQxblZxT3ExYmkrbDUv?=
 =?utf-8?B?RHhuZWZxcmg4N2ozb1k0bFFiSG5ra3FzUzZ6bHB6VFlpSmNVdXpUTVBOMXc4?=
 =?utf-8?B?SmU0cCtrdThoYk1LakU3VXJjNWJyT2xlRGlFRnc2c041NFAvcWU4eFhmMytG?=
 =?utf-8?B?a3VtcHVjR25PVFhaYUttOWxwaUYyWXFUM0FtUWJVNEZvVzN2bHZWcDNNRHB5?=
 =?utf-8?B?YXh1R2VuVUw5MnIwSVdYSXRCQU1TODZ1UWo3RE1teDk3Y3RBQU5hYVFpTWRr?=
 =?utf-8?B?cjVEZHM5WGdzQU14YnJ4V2lUWkVwZWp6ek14QTNhNG91dzAzOWN1cjc3bjBM?=
 =?utf-8?B?RUp1RFB2endCSTZ0NUlVMlhDTW1TUUFmdlBjbjdtb3Rzd1RHTWRmVitDOXVH?=
 =?utf-8?B?b3BsVUs5bDRidklnL3VOc3N2V2pkTnFlSGpqTmhWSTdEYlI2RVpscVdZRXEr?=
 =?utf-8?B?aktLNXpNTDhQNm8xdWM3TGx5cTkxbm4yN0ExMVBNai9idXFVbk9FWTlyM0Fi?=
 =?utf-8?B?RWpZNVdpQnRVeG5qcXg4TVQ0clRCRmVXWjlOdW1GT0t0TzV5WWM2VlNzOThk?=
 =?utf-8?B?Z3JtbEttcm4yemdBUWJ6R3N0c254RXBLbHQ1enlKU01rSGRGeUFaTHNPdWRN?=
 =?utf-8?B?VEg2cnRoQWxpcEtWYlJYdHFlQU5jNFZhTTZwb09jK0h3R3l1MWFkKzVPZnFQ?=
 =?utf-8?B?M3M0czNsU3JjUklPRE1jSU5MczBYOHFlT01HUkd3MkNzMHRQV0o0bDVISTBz?=
 =?utf-8?B?R2wxMUhXQ0gzMGZZdXpCWi8waW5RMWY2RG5wUDB3MU1BODBPZ2w2YWxEc09X?=
 =?utf-8?B?NzVGcm9KR3VRbjFrS0VBK1UwWEtOY0NLL2FWdmtJYkFuR3E4MmNjb2hTR0J6?=
 =?utf-8?B?ZWV2bjRHRjV4d0orWUxtSDQ4UW5KbU1rMFdKdEpVVkJXTlEzTFZSazJtdTlJ?=
 =?utf-8?B?WVplcE9aWG9nc01JZVZFSURWOXdCbzVtdU5tVzJnWWM1S29VSm1CTFR2VzV3?=
 =?utf-8?B?aXREaEprTnU5S0diYzA2d3ZXVStLTS9IVngxY0xrS1JUU2NnSW91eTMrUGRw?=
 =?utf-8?B?OU8zc2VhOHJZZmlqK3ljS045TVRDZDVBdGhJaDM2L0d6Q0dVc2lnc2U0ZmRq?=
 =?utf-8?B?U1dXcmFMUlB3dWMzZDBtcGtCTVhRWGNYL0MxWlRaVVRLL2VnOVNPVlA4OEVh?=
 =?utf-8?B?RjVOR3RDWmIyWUxuOU1lQlhHQk9sVGhDL2p5VE40YytKS3NZWXBDWTY2MnJD?=
 =?utf-8?B?RGV1UERRZFdzb1JuZW53VDd3ckR6Z0hqMHZjVlVDYTRJMGVkS205MVhtbUhp?=
 =?utf-8?B?MmNKcHZkZHRVMEVxRVkyUzNncG5HRUlaMVBtMkNXUG1TRWJuWk8yTjNVWWo5?=
 =?utf-8?B?VW9XaVVnQ2tGOWlBUnJGRWZSc2xZejBML01QNWtTVkV5QW95VkdxYmdjOUtQ?=
 =?utf-8?B?d0Z5SXFIbkJTd3FUcmtpRVh5VDRpbStVbURwbXpFUEFjS1BSb3hqRVFsQjJU?=
 =?utf-8?B?R1JPMlV0MjlnQ0JNU0FPbllqYmZmTE9hU2doZkZUNHd1d0pKdHByOHcxQ2FV?=
 =?utf-8?B?SFdQYXN3RkdHTUFvSU5VdjdUbzhicVNTLzlPR3hzY3pZcXM1ZUJweGJEQjk5?=
 =?utf-8?B?M2cwK1VoOW9EcWVmUXNnd1RqM0QwYVNZQjJOaVdGQStVTXBlUEFWRTJkbmpx?=
 =?utf-8?B?cjMwUmRpckI5cWdxbTRRbVI5ZlNYZVFHTDNSK3FjY0VPK3ROMVU2NDVLQ25o?=
 =?utf-8?B?NnIrNURtZTVHTnZKZ0I1R3JVclRCWVhZU2g0Z3lnaktCbHJWYkhHTmNOUmk2?=
 =?utf-8?B?ZW0rVUxHZm1BVTB5Ungzd2g4WGI5YzNEWnE4cVpESXJYUm83TzRDNkdFMjY1?=
 =?utf-8?B?dVlBdlJJQ1VKblplMU8yU25XMHV4c1dHRkFZcTJPZi9RTmQzNG9OU0ZUemRY?=
 =?utf-8?Q?UGAW3KPQwkEFlrR0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea67b8f7-6cb7-4b21-2555-08de68a8bb4b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:31:44.1619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gH/aUpO/+MVvf8qBzKytwX2jdWkBH6OR7ZbIKdJCN6/JneXtSYUwe1qAjPFLo8SpKBkQtYYiTp+CInmzfZHulaj5w2mOIGvCg743Rh+ITnY=
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
> In the scalar datapath, there is a loop to handle multi-segment, and
> multi-descriptor packets on Tx. After that loop, the end-of-packet bit
> was written to the descriptor separately, meaning that for each
> single-descriptor packet there were two writes to the second quad-word -
> basically 3 x 64-bit writes rather than just 2. Adjusting the code to
> compute the EOP bit inside the loop saves that extra write per packet
> and so improves performance.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
