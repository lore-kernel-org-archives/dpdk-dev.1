Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E50EC3ABBF
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 12:36:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AECAC40269;
	Tue,  6 May 2025 14:36:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id EA80940150
 for <dev@dpdk.org>; Tue,  6 May 2025 14:36:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746535008; x=1778071008;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DI/KP8qDMjtynkk02U3fTnlxQPjlOV/VaCWiZE5EDsU=;
 b=Pv4lTf+3VfkE6vgopbV90e3hirfRnckK0Cb4b3ujGNr/oc+dGBGHUs33
 NN/z9108WRxdCd/rs/njJgHWYEtmkwPS0/oeO4p306J5SMwZAhbj+o256
 b+jBFl6Adk1aE4GfG+0N9VIHwbVtFozFezJXjV7btttovLngrWg8CUNpf
 KZ2r77hm8GoW3bEEN+o8PbbcPiw1NSY/qnSjjiuNrNwcDuNZmTX51KpZl
 ybIp84jOFiiMnsQLVH1/h0sM+hO8rNSSR4OreP5wGN+hGP+gT2noWwpDP
 q+2KeaLaVkruXPqschrxe+VIRMnwJV9T2Fg/Do7VW9U2QgyL7UsVACaRp w==;
X-CSE-ConnectionGUID: OR5iTGHSTJuH0LYdp1FKkA==
X-CSE-MsgGUID: mmAZgCFFSliCR/RcF3d8mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48108829"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="48108829"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 05:36:46 -0700
X-CSE-ConnectionGUID: 1YdMXn5XRe+xm4ilfg6bww==
X-CSE-MsgGUID: v0ezIF0AQQWUo3w5XQh/Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="140430958"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 05:36:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 05:36:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 05:36:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 05:36:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxbKaRyn9pLr7kjL0O58SWzivJ/YPNSX4N9Kvp7vRntLGPM4fPrKWm+8+gbo4vvvCHaAq9NZaXHPwHvtzTWuIaNX1Pp/jKnI0KeCWBvjSAcgplZQebDseUwHrP/YVeJTN4CNqo2RXBUkq54XNOHdPPlUEaasHgW7f9aUHntSnYKC/h25Bt3hJJZER64IWVCHr2NLfXTEL/2C1VaVok0bWrYZK2xF4S/hH+cPIRWhs6CFZdIBAUiO10GUJY4ReDJZIIq1bkBGgFZowQZ6xBRsm3RkwdHDpDe33AC9bMKSi0qKVkf4/Kdvnhz0YeNMxkSB3Df52uAbUtGAugGfu9h6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqalBUEla5PU2rJDJKRaz00ll71lccbi4rDUwFOTApI=;
 b=lR0hSRBMN4sb4Irp08dtj70zINaTKa3DeesQU4S8Pc90k39Cyj6AQSzPwzGJ+RtqjAzToGrmw3rNvn/OuFUf2R7i3ry8XdSccZYYbwdbvp8WRroO3HKI9xEeYyPLzPeqsG4XGQsJ8ySRhmwDQ2sVwt/AyDFOBDXm+ObioT3sua1vwNt553pxHahBwExkMsFcr9OyQvw5T7wx/fB81uruNMHU7J+kHp5zutEbZcXNGzaVLATZ0BKTZOw0GPtxVum6giD+AaoZhI5LNzdAbsdZQYPFWxC8xg9A0OV8QR9lYuYJk4nXn1ZXaUKHXRhX5kHSLfqUX/myKcE4LHTYJrKMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA1PR11MB5947.namprd11.prod.outlook.com (2603:10b6:806:23b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.23; Tue, 6 May 2025 12:36:28 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Tue, 6 May 2025
 12:36:28 +0000
Message-ID: <f2bdc62a-abbd-4652-9cd6-7c8d40868f2e@intel.com>
Date: Tue, 6 May 2025 14:36:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] app/testpmd: add sleep command
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
 <20250502084213.02b1198a@hermes.local>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250502084213.02b1198a@hermes.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0001.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::16) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA1PR11MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: 76cfbf6c-9326-4a81-6295-08dd8c9a9f2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzVzQXBSTDhhMGIrMkx4ZjZZSjJmOUI5eFVnVVg2Q0gxdXJXVW1tdW5jZTVm?=
 =?utf-8?B?Q0hpenBLTXdVL2gzdHA3bWQzSUs5MmV6WFRNd1ViUCsrZkk4THJWUTdTM214?=
 =?utf-8?B?R1FodHdiUlhhSUtrQjM1MWdjQTBTajlXcXNtZ0Izd054SmJLOWhhbzBlYmVZ?=
 =?utf-8?B?SnNSaytGNEZsTFQ1RDUydHRiMkUybmo5TlJFcis1dFRONEU5QjhJMmtNdFQ5?=
 =?utf-8?B?Z0lGREdYU1dKTEp1MjlacDdtd0VYVll0QVVYY0FDVlNzZFJBVloxMVYrUjd0?=
 =?utf-8?B?LzNDYWVWaU5BaTFxU2RYL0ZjMWhBUXh1ZlE4a2ZPQkJUVkZUam0vMUVwT0Er?=
 =?utf-8?B?dlM3a3RabzlpV2crQXNiK0ZWbHBETGVxb1pIbXd3dEt5MSsrZ3pNVm5IRFQ3?=
 =?utf-8?B?QXZ3TlVCck1lck0wb2lVR2VmNlJ2OW9QbGNlNDFtRDlST2FNakVIYWxGTG5D?=
 =?utf-8?B?WEwvNFpOVGQ5cEN4ZkJXOEV0eTE3SUJEYXJkSnoyL0FlTFVWUnZBUFBLR05C?=
 =?utf-8?B?ZjFpYVJPUnBqZ3lVLzRIZ09pM0xTWkwrSHE1aGdNTzB6NTI2b3Y2ODB4UHJy?=
 =?utf-8?B?TVJ2czUrU3lpQ2l1cXc5djlnWWRUU3VURXRuY2w4a0k1T0ErSUIzSTdOZGtL?=
 =?utf-8?B?ZkQ3cnlrYURwUkNHdkJ2SktDM3VQd2U1Z0JyLzZZTDVDYkhZWFlqaTd5ajhw?=
 =?utf-8?B?dGh0Y0lGTVJHSmQ0dDFxSzRzWktjZDl2WEIwYVh5TVhNUEJUYnF2SFZCeGRC?=
 =?utf-8?B?KzNIckpKWmpHc2VUcmV3OHhsQXZSSVlwNExTVk5vaEptY3VtTms1aEoxeXZh?=
 =?utf-8?B?akQ5dENFKzBPeUhlWlJTdjU4Zit6emZRYk1sTXpSdit4SjVWSStrdGhFd0Ro?=
 =?utf-8?B?N1lvajQ0cVY2enhYQzJRSXBXWEd5UjJCTkFyNEhFMHMzNDdoK0JXV1FjYkl1?=
 =?utf-8?B?VHRHaTRYMzJEQy9VL0ZoVzQ1cGFFWFlSSEFBdzB2MHZMM2hRSExSZFdCMERL?=
 =?utf-8?B?ckU2WVJ5YnVNdFFsemVVN0dsNXoyQWlTVkh5NzNMc0NOWldZY0orMTJ3aWRi?=
 =?utf-8?B?Q1QwbXNPY09TZGhrRUl6YnZ4Z1JZRVJGSmJPZ04zcDRrVGJST3R1cG5pWHVQ?=
 =?utf-8?B?UHh3dXVVdytFTG5VZ1pPblBqNjdIYWlUSk92WUMvSit5RVNGZFRoRzJGcVh2?=
 =?utf-8?B?Mnl1SElYT2o3b3dYc3ZhU2xiNk1aMFlianNZeTVqWExWblJEbjJaUHg5SHlq?=
 =?utf-8?B?VTR0ekhhcmNnWEkrY08zcWREbXJTbWxjMWFNL2ZiNlBWNm5SbEdKTW5lTlJ1?=
 =?utf-8?B?ZEZRRDMyMFpBVEJTbExpbkJnTW14RHhaOFYyb01VU2R6SjIzNVJrcDlSTmN1?=
 =?utf-8?B?OTZJb2VvK0tVMzIyK2dZaCtVMVU5UHhBVmZqMWN6N2ErVkR1TnFSVGQ2dDV6?=
 =?utf-8?B?V3R2T0pWYktBZUtTZEpoSC9QR0hLOW5VeUpWbWpScUtGSGRGS0swQ05SSTA1?=
 =?utf-8?B?ZTRSYTNLcUh0WlBnRG9GWGJDdWVWc1d2Z0xGSDNlUXNMSTRNZzlNWjZWZzI4?=
 =?utf-8?B?dytma09GZndaMVVXTTZ2cGJJd1ZDRXl1M3dPbmZnMWgvelJTU1dscTNHOHFk?=
 =?utf-8?B?Wi81MW40RHU1SzJXSWM1L2c4R0RYTCtvb0NNU0NhTzhUbDNDOTc3amhiUUVO?=
 =?utf-8?B?UmNXdHBPTVEvcXlxaGh3QllNY244UWREaFc3VnB4emdiMmJrYXEwZ2hjcWVj?=
 =?utf-8?B?UU5naXA0TDAzcHdPR3lCMWhRT21GUEtKYkFyTFF4cU1BTVlIYWpxMGE0bnc0?=
 =?utf-8?B?bHZ3Sk1HQjZEMVdNT21tNmhpVU8wQ2tSRGUvQWlubTJ5WmN0cytTU2NZVUJN?=
 =?utf-8?B?Rk5sVzVsS1dGNno5czhRemNoeDgyeFpzWkc4VlVUZDhUMkE2STFzdEl4WmNB?=
 =?utf-8?Q?oar1qXumRIM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEhCSW4rbUliS3BMeFlQWmtpcEdrbmUrUERwbWFoNXpsVUltOXdlK2RiYkIy?=
 =?utf-8?B?UW5pdW92cWxEWDhaL3FQV3NkVVE2WnorbHVNNlpxaWR3TzMyd0JxbHd2bFRo?=
 =?utf-8?B?MjJYUWZ3RVRraENDUHFVN0ZLaE1RdW1JTG5EelA0bFo2b1hFMmRhL2pLSlVp?=
 =?utf-8?B?YVkyUWo3bXorOHkvOEg1cWF6RVl3MjEyUmplZkxoTllIYlFONDMzWjNpMTUy?=
 =?utf-8?B?TEdPWEpJL292WUJnQ1lPdmV4eDRMSFkwSGxXNFh2WmRiWXQvcWlnaGg2UUE0?=
 =?utf-8?B?SkVETmhiS25mWEN2TU8zcXJZdEZxVFFmaE1qd05wSGVzSDY2UzBMN0dsWTBN?=
 =?utf-8?B?OU56S3dQZ2dwS2dMYnFGV1haL0JiZWF0ZjlHVnY0dE43eWtvY0JrMWdldG9Y?=
 =?utf-8?B?YXg5bnVObXA0VTRMbUpHVWNoT1JibTNac3dUbWdTdXFZanhGbmFYcXlxR080?=
 =?utf-8?B?VDdnTzdZc2tqVHNadnVDR0hWOXNONmJSMStTV2VjSlpKbWJzdVJocmluVi9y?=
 =?utf-8?B?N2dnUVBWamlhOFlCeGVlb3Z4MmtxL3h4eGRRaENaaFE3cjRFWTFCRFFKTXpF?=
 =?utf-8?B?d0JIUWs2WFA0TENYN3BCMVJhcXc0T0g0Z1RyREpBb05sVDN0Y2ZCdjhCSTFx?=
 =?utf-8?B?MDdqM08wV21yV1BrbkZkbHlsdkRHK3AzWEQ5SjlwOXBsTjB6b29UNjJoeUV0?=
 =?utf-8?B?WDhsYms2T0FLZitZcC8xUHRod2x0clN6UEM5cEV4bldENWVBdnhoWk4zN3la?=
 =?utf-8?B?ZkJUSFhWc3VWQ3h5eGhQN3YvdHZqZXlUVDJGQ1pnT04rUFNMMnFDaTRURjRm?=
 =?utf-8?B?d3lJQklEQ0dGYnV2d0hYMjVLT0I3TlJvZm4wazJPVkRLNTVMcWdVNHlhOTJN?=
 =?utf-8?B?bytZYmVPdlI5Y2RPTkc3TnpUYXB1aTVXOWxGcmZBSjNZWE5nZm5MK3d0eVVL?=
 =?utf-8?B?Wm9McnRLUUdjNzc4RzlYdUJkb0x2Njdscm9HcTVENllIeWY0eXhrdy9mbkw4?=
 =?utf-8?B?RjlMR2NUZEhPZ09hU0FzZkpOTVpHeVFmRXBJano4b2hmOWYzWlZtb203UmV5?=
 =?utf-8?B?QmRnSVhwT1BKUlMvUklqenJGYVdZRVZ3M3d4TWpjTHkwcndQLzhkdER0QzY2?=
 =?utf-8?B?czE1VW9lWk02UU5RQ2pRRytKL3RDaDlHbUIwNkQ3dEhKeG85MTdIVTBrNUN4?=
 =?utf-8?B?RENxMlhoNFRIZzQ3RisrdzhvSjkrQ3RTcVBZbUVGYlBLS1p1NzljdjRZcWVw?=
 =?utf-8?B?L2dXckRXS3FEQ1FNenVZckV0UmE4T2lkK0pNMGRhN1ZhWVpCMzJYelhWWk54?=
 =?utf-8?B?cmNKcmgzeWIvU01HaXc0TWN3bzh2UU4xU2JGWDFxN3JROFphem5VbXBIVkN3?=
 =?utf-8?B?ZUo1eVdVUEdNTTVUZXJDNG5JWFdRU3NvdmNWSmdpaitybkc5cXZnMGRacG9S?=
 =?utf-8?B?V1MrNGlCSDdQbmNOK2RMUlBBQ1hWWWFjdTcvVjNLVCtDeFdOM1BZRVdmOXVz?=
 =?utf-8?B?cE9uaDErVUtOUmxQSHN4OForenlZeFpFODNyZjBwc2prSG5QL0JPRmJ0YzBW?=
 =?utf-8?B?cG9uVFVFcTVhYm11b1RFYUZ2K2g0NjZ3QUZCaGJ2TE8zMTZCOUhWN2xNT3o3?=
 =?utf-8?B?VmVpVEs5L3ljNlJHWm9KTFNsWlVXeWR2OFgyOU1mait0dndBTmlWQldpT1Yr?=
 =?utf-8?B?enZxMGdQZzBiS2tsTE9mTzNGT0RWekg1c01GWXlBOGxXcm41eW03THBVbDRJ?=
 =?utf-8?B?Vzg1bUE5aUJSdWlBQnBSd3hkbHgxNmswTmVpbFg5bWMzQTRwNERDZXJPMUZu?=
 =?utf-8?B?U0tCMjFuVFlZTC9QN2daUDhPem1WeWNCTXhIekkyYmZTWmlpd09NS3JZWS9x?=
 =?utf-8?B?Rm0yNkkrRmh5R21sWlNBY3VUdkZBOEJLVS9tTGdPdnR0Rzd2YXpYOGJIb1gx?=
 =?utf-8?B?eEFHemRZRjIxdzJaWVpjNGdLbDFxZklad3g2L3U0TkU4dHduM3Fvc0RRdUFR?=
 =?utf-8?B?WGtmWFdDTXNyZkRZOGgvL1hlcmh0M2tJM2xWL0lNN3B0N1UyNXM2ckJsS3N3?=
 =?utf-8?B?YjlFcytQb1JUTmVRandSZDhyaGxSYkQ0R3JUMmFtUnJTZi9TaWJXSUtGVW9v?=
 =?utf-8?B?OGw5Zm5GZGY4MlMrMS9maWt2YWZPSHB0SmtRUmVBSUtvcEpKcXJvMmV4amtG?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cfbf6c-9326-4a81-6295-08dd8c9a9f2c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 12:36:28.2291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZByEYIW0990/yz2hZUAbhonhn7vSuewB7JR3+yF9dY/G123q8bimipK+5nrXuIu58+aI1Z552wWobSbfeo+3WMFpo84gM+OviZG+SN2OpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5947
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

On 5/2/2025 5:42 PM, Stephen Hemminger wrote:
> On Fri,  2 May 2025 13:27:29 +0100
> Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> 
>> @@ -13701,6 +13735,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
>>   	&cmd_help_brief,
>>   	&cmd_help_long,
>>   	&cmd_quit,
>> +	&cmd_sleep,
>>   	&cmd_load_from_file,
>>   	&cmd_showport,
>>   	&cmd_showqueue,
>> -- 
> 
> Looks like original list was in alphabetic order.
> Please preserve that

It really wasn't, but I've moved it further down the list to reflect 
help message ordering.

-- 
Thanks,
Anatoly
