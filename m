Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99CCE6817E
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:52:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 303F3402AC;
	Tue, 17 Feb 2026 13:52:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 40312400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:52:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771332724; x=1802868724;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=r0pVNaTj8Eg8Op86FHjXKCy+p88lQZ8KeZfeUfP7sfU=;
 b=aelhXSqd0xBJpiUje1e1kHAYFWtd9uLXkII37kLnVeM2mFAKrNJN425W
 SHj9fRPhosflHBrWxJ1mCd8emCG8nCbu0K0YSOrtZWUm6j4Af8bAy+xzL
 VQyqmHtvPc7rHs0ysrXnl1EyfYEAM8gVufKEV/m+ZMjecLuPR+/Mtmjjd
 S7kyzZBRNTSFdN6ovJ3Wtlu+SK5GrL3qFoxMX+07MIWqXLB+h+2pnopr2
 Dk1wP3mMc1nz4VQPZNSsJ51qkDi5kQ0P3Wp7ato4Ob4UT1zfGI3568mch
 Gco9KaYmf6kP5j5BQI2Nkk63pE4bKKxTWshz4WEj98P2MFiGQaeX+cH4Q w==;
X-CSE-ConnectionGUID: XlX6gnkCQn2grUHIAJXjIg==
X-CSE-MsgGUID: 1VfheE3YTIyaaX9K68ppag==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83837678"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="83837678"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:52:03 -0800
X-CSE-ConnectionGUID: wBHApQQkQAm+XcXo8Kxfag==
X-CSE-MsgGUID: Q7uexcHPQz+gZGELygU7zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="212961822"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:52:03 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 04:52:01 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 04:52:01 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 04:52:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3x9Fux1H3FrryB543hJhQBoQZqTWyxYhvISfhF6Gb5aOdAc9picg3KfHv0/qEu6DBjyWITopWyUzeqYlXX+aO3vQKEpw9BbCl/E8g+m+PTtWRE+BymZ864luV8KbVtcCpPiDe4/5JrdbhxhdFfZ2ByVNAsyhOwObl+S0d43h+j1LYHNwv/twlfdoLyUyzQRqyiXuDBChCibCOBfww0CmyOsdJfDM5V6iSN/l0ZT1Xc2gE1I8P5pmBiMb+PyOpPw834+IlQ1nK/axqFOfna7Uyu2hyOc7czgYFuoDo3Du4mVlddx/4zsgeGs9TggRDf1hlmysUFt82HWZX+Qmp9bGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6+TkhDca7G/8Qf+neRuVX4KBUYm1HvyOxXuKjyKOS0=;
 b=k48f+GP9C+cU1SC4kMwx+VhZtarOnP+U/SI0cI45/uCLWqU9rMOeOnOSUiE46P7tKDupB4jJ3nYBojivnFUQ1Ma+wRaHYkze4rRmrTGOwE2Yq6g0Bkm1Kqs9ZIHhMtCbd1zD1+hlJHUb1isfwPHkKeYuqzwvvXJefQhGL4GttRUAobMGDr66noBp36mwpaKXcZiNl2MIRRPg9w1TdL4t6Jv8zrp4Y23QY+yA9/QCNQvicNdI7iC1AHyOLsZrMkyyHAbo66802PU1UMM7wiH8cU6CTydIB1Z5DewCxkpFFaj6FndQcBgsCAVm/o/ozAQV5aqJAjIvV//l5J2aeNIk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB5157.namprd11.prod.outlook.com (2603:10b6:510:3d::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.13; Tue, 17 Feb 2026 12:52:00 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 12:52:00 +0000
Message-ID: <3f6d1116-e3f6-470e-b87b-b2e0731a74c7@intel.com>
Date: Tue, 17 Feb 2026 13:51:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/27] net/iavf: remove remnants of pipeline mode
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <d54db10b682851454ef5ec632e415225dae6b993.1770978324.git.anatoly.burakov@intel.com>
 <aZNQ9zSmorlmiSmo@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aZNQ9zSmorlmiSmo@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0127.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::13) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB5157:EE_
X-MS-Office365-Filtering-Correlation-Id: 02100dbc-b10f-4b0f-e834-08de6e235727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmFuMWQxeElLbXdHYlQzK2ovdTkwR1VvSUtpOGZSdU5RaXdwY1BCdjZXY0xy?=
 =?utf-8?B?TUlITFZCbS82WVRQVk5kZ3Vlci95TjBGbGVqdG9FK3kwK0dWdlhFWk5YTm9u?=
 =?utf-8?B?Y1dnM3pjcXB1SWJ6MVNnVHd2RDdmWDhyOElyUTQ3QTZlSVpjSEExTHVCb3NM?=
 =?utf-8?B?UjhrK1RBOGtOMUVDcVhDVEtuVXg0N0phWG82d1hCWS95WHBoT283d0lxRytV?=
 =?utf-8?B?RUVJOVgyaWRHb0dLdHZsQmxFMHY3UlVFWVM2alpuaUplT0xjWlJQNXZIWUhN?=
 =?utf-8?B?UmtzRXY0R2dXSmNDbEhxdlpkUzMrMXRyczIzeUk5ODhuV01USERncDFsS1dS?=
 =?utf-8?B?aUhlRmNTU0pQU1R0MW1FMjA4MmI1cU9MN1pURHhNRGo1Z29YVFFlckRMMXl2?=
 =?utf-8?B?Vk0zYUxjSXJsdy9mMWIzcTJYSTBhYkdWNy8zTTR1YTd6NXZWR3lDejNOWjdj?=
 =?utf-8?B?WjNEOFJLSEtzS2pETWxBWUFpa01RTHdYVEFXSmRBZ2x4Mm5HNk5CRTdyQ21U?=
 =?utf-8?B?WTM1WVRVNzhtdDZjNDZab3M4QzZZZndNOGMwZjRXcFpqWTFxK1hleTlwWDlq?=
 =?utf-8?B?N0toM2tqQ3JXYjhBYnVwaFNra04rOWdjdU0vRTFablY0SmtaSEIvTFlTT1h1?=
 =?utf-8?B?cEpoa1pTK1RaZW5MTWVaQVZEa0cyZHJjT3F5Mld2SG9Zc3B6M0M0RENTb0Fi?=
 =?utf-8?B?OUJRZlJHV3hYN1F5RUZLTFJZa1A0TE5OS09rd29tOUJNVTFxUkZlbzZkUkg3?=
 =?utf-8?B?dWFGR1ZhbTE5QTRYSjJTNmJqMjdsbmpVdFRhTTJZeUtFY0ZnUE5aaUxNYXM5?=
 =?utf-8?B?QWkweU1ma3FaR0x0SFdUaW50Tkd5M1BCWDRkSG1JOEZ6Um5xQTNKZjJ1cFdF?=
 =?utf-8?B?TU9YRWtSZUU5T2JUZWl5dExuQUpmYTdHSlBaY0RoakdKOXgyaWsrQlVMMUVn?=
 =?utf-8?B?ZXZKeWZTQjdReXo3Y1BEd0FHZ09ibWRyNmFINXdWZHVHYkdJTjIvQks3b3lF?=
 =?utf-8?B?ODRzZTFVUmFHUzhuM3NXZnNVeEM0bmhTd01hNGdIYXhMUWg1ZG4vUkY2RW9y?=
 =?utf-8?B?WS9VclFyQll0V1VXZTFBY1FzQjhVYzRmRnZodmtvVndLbHNLb0NRNWhXZmJC?=
 =?utf-8?B?OG40VkJZNEovWFZIZXhlb1ZjbXdPY0lqd3ZBZ1VqK1RXTjNZN1NkSTRpMFJm?=
 =?utf-8?B?S3NmZy9zL3RxS2Zwck5FYmMwYXpGd2t6bjFPN29tblR1cmhCVU1rTzRURkI5?=
 =?utf-8?B?dERpT2VMeVN3am1pM3RGYktoUFZtYkJsUk54NmdiYW9BZjRDL1NGcEZ4bW1I?=
 =?utf-8?B?YUVsbzE0NnhiaGtHdjVja0FhV3VaTkZUc2owcDZ4TDVYejVIRE13RzJHZDFM?=
 =?utf-8?B?bytNMmIzMm5UZVhwREs1UnJMTHJNU1BqZnc0blU0VXBIczZ4bDNJVTJ5c1A3?=
 =?utf-8?B?NndzZ3FmNnZjRmpiY3I5RVU1a2NteFBkYXdLWlBjdWFObVNNRGZxaXpEd2J2?=
 =?utf-8?B?b1B3aFVRc0EvT2xibXJqRUMxKzBxK1UyY1BaamJoQ1czQzl0Qlpibm5VRzUw?=
 =?utf-8?B?ZFFXM3MxTGtSdDAyd1NvWk5BSjBKRFY3bnZaSGwwempyRG9EL0NyYWl3Tkp0?=
 =?utf-8?B?QldDeWIrZm02ZGE2NlVSK3kvdlJMMU9sNmRXR0xweUxsRUE1azJ0MlBhenZO?=
 =?utf-8?B?K0FUR0xpdDVveDlVa2hNK3E5MExLSHZWOTlNT2FKaU1nQU5mS05KU2hqeVM3?=
 =?utf-8?B?VkZjTlo2SHVhbVlWbUpKYklTbkxUeHNXMEZNaGl0Z2kyM2EzekR5dEFhZnZp?=
 =?utf-8?B?WklwWXkxRSttRm0yZThMbGtQKzYrY0dIMG5BNWk1dzZmcllVcU0vaHpIbDFR?=
 =?utf-8?B?T0dnZ3JwRGd2eEVHUDBxWG05MXFKS3FNSWtBZzVVLzdRbTdRM3RYVktldmth?=
 =?utf-8?B?TGpGOExTVTRjMzN0dzNmMGZxNFlPc3Y1NzkwekdyUDJhL1ZvRGRQODdweTdv?=
 =?utf-8?B?Qi9OS3pyK2tBYzJGdFhQZDRJODluYUpUN2NVc3NIUGJtaStYazMyNE0veStW?=
 =?utf-8?B?VEUzSDhVVkNjaXdhaWV0RitOaFl2YXdHaEt0TUh3WTBVTGtrVk1KT1J6NW1Z?=
 =?utf-8?Q?Xp5I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emZ6VnZPMlVlVnhHZldqRmJiSEJlRlFycTdyelI2RmF5NU1jNnZKeTYrZVRo?=
 =?utf-8?B?M2hHcklFOFJSZ010VjRINkdrS3gzVWsrSnlldUFTbmZFVU5vRkJlT2N1MFlm?=
 =?utf-8?B?cmxjNFF5VFNYRVdyL0FxL0x3SXlOMm9Ha2dDb1Noc0FnenpUUHVMTkl5YWM4?=
 =?utf-8?B?SXZWSy9YdVp2S09LdUJrSms2VHdycjdPaWNnVzlNclNDenh6RGxqdTNheXpm?=
 =?utf-8?B?OUg4amYySnU1cUtKMUVtR2FFMHNFMTdqYnQyTzBkMHBOa3poYXh1TUhkak9B?=
 =?utf-8?B?K1VWZmZLOEx2ejNzN2JEelR6V2VudFVEZW1sWkN4am04QkJ3dzdFbkFWbDJu?=
 =?utf-8?B?Y29pSTFhMDZRVnF0dFEwaGIwWXNJQmFLMHVqNlc2YjN1cTZaaExseTNPZk1F?=
 =?utf-8?B?WTBBMGo4YzY2cU5PTktBaGorSHowcmdFSmdERTJLMEZzRVhkcElJOEpXQmFk?=
 =?utf-8?B?cTdCWURTc1RQODVRZ2t5RDFOaHBBUUs0RFpRUzhvL1krSHBjS25OUFNVdXFL?=
 =?utf-8?B?dlVOR3EvKy9vRTlqc0ZzNFJraEVIQ2VYREJGWjhLNGh6YURmMnkrV1lEeitO?=
 =?utf-8?B?SFNEMXNCSVRxaU1hR2dVU1E5c0hOaENaaURXRGl3OE40Qk54SlQvQ0VYZldk?=
 =?utf-8?B?SUN3UjhlQzl5U1ZlTy9KYUM2VC9lQVB1b1BNZUIwVnppeEtaWXAxeG5VQ3NJ?=
 =?utf-8?B?dkgrbVVHOXI0ZlQxQ3EyVVhvam1IK0NBWUZtR214Q084VWk2bXFlREZHZGhw?=
 =?utf-8?B?NytLTDRvOG15SkErSW9jS0hNMjA4dGQxZjB6RmF5U01hS2xyTDNYVm9GRnBS?=
 =?utf-8?B?SlM2V1ZaVEJ4VktTOU5OSEF0aUx4ZHV0VWNGT1ZVbFd3MzZwN2tReUpqZUpG?=
 =?utf-8?B?T0UrVi93S1VBR09PTGY5Z1UrNEF5RmNGTTdmdTA1N0R1bkFGemdhbzhHRXY3?=
 =?utf-8?B?R1BRQU12bG1NN0p5T1h1cXozOWZZeW9meWFqczdYR1o1dzgxL0dNNXZtVjVx?=
 =?utf-8?B?bUcza3FpdG1uRDhFMGE0ZktRVjY5OEFNYUtHVzltRUx6SkVzTTVIeGRyUWFG?=
 =?utf-8?B?Uk9oT205Z3NzYUMrSU5ieWhObjRBRURNYk04Q0hFSCtjZTBtdmsrb25qS2p5?=
 =?utf-8?B?N04rbXdVYUhqbUlQeGxKR3JXaU5lemM3WW1YWjMvL0VHbjhTSng2cWNnL1RF?=
 =?utf-8?B?WVI1U0ZmVzB6WWo1cFZycUpDWTcwUHIyQUVyQUVjSjY1S21HMnpGQzFpc0tK?=
 =?utf-8?B?SGhTYU80WjN4MlhyNVdRWm9DWnNoOFllaWVvK2tpNlI1RkRMdUZtQ0ZDcUlK?=
 =?utf-8?B?emlXRXF3LzBvR0lEVC92YTFYdGpOZUF1OEpQOHpGS2tXaGVPMllJQTlUMWpQ?=
 =?utf-8?B?WHhpb0tzd1EydndHVWpFQVh4UFc5Y3Jrc3NBWktyOHd4S3lCZHNJM1k5dGNT?=
 =?utf-8?B?TkxPWWhhRWFFUHVtN21TOVhWWWE2ZHFSNnNhVkw1UVB6VlprYy9xVmV6bnFI?=
 =?utf-8?B?OHJoNk1rdGpmbmw0MDdscjVNR0Q2U1J3cFNlSWVoREMzMWVSbVNmRkphZFZj?=
 =?utf-8?B?Z2Jycm03RzROREgvbU55RUtFbEM0ZmVaRlA0OFhyY202eFFrNmxkZ3FhOE1O?=
 =?utf-8?B?SUFzQTBueW5BMENKRjBScFZ3UDdVZFRLMDd3WVlGMGJsME8vWUlvV0hSWnhZ?=
 =?utf-8?B?bVB6czBMWE5icUlBZmJxdGtpejdaN0JZUDFtZnBQYlFsY21neDZPbEFON2kz?=
 =?utf-8?B?YlNrLzBsM0hrZlBrbzZpRjdsWkZJTFVkMndpTDlwWjlhTWtDT3kwbGxjNXFN?=
 =?utf-8?B?dDN0SmlraUZkeTdZM0R0ckMzSERtMVZ1Z0pVclpsRjg3STFuUEpGWWNjS2ZJ?=
 =?utf-8?B?N1REQkNUaU9hWjZ1R0E4YXI2QTBjR2ZtMm5aNUhRYzhZSWRXMWlQM0t1VThQ?=
 =?utf-8?B?eFNRLzRHclNqajdObWJRZURORnRKWVVXQTRDS2pvSmEwRU90cTB6Q3ZNOXBV?=
 =?utf-8?B?STRkdVRvbGtyMWdOQjF1Q3N3MEh1bnU4V2YzRk1nSStJMkxwRXpodXdIVE50?=
 =?utf-8?B?aXVLc0UwWXZkT296Q1FUUTlkbUtzc0puem8vMVBMV0lKVTU2T2lYTFNja3hI?=
 =?utf-8?B?a09vTUM0TmJyaVFZTjIvTmRYb25VSm9LSzRMOFZsSmdlSDJmVnFSMTJsMWdJ?=
 =?utf-8?B?OTg3M3lRUzAzaG9KazNQd1ZyTWtOWU5TRzNPb2xmNCtwOFVNNndoMzB2Unoy?=
 =?utf-8?B?WlhwcnQ2dnpVdGp5WTU1MFlFWE5DVUkwcTFzcGlwTWwzK2hvQnR6c3VWbytY?=
 =?utf-8?B?a3VsdXN6SldLMjNBMGY5ZWNzTUszTFB4UTh4T3RXRlBwN0owekhZUnFybWRG?=
 =?utf-8?Q?RSi5dMs/35jRzOF8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02100dbc-b10f-4b0f-e834-08de6e235727
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 12:52:00.0113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAFRyn/RXGOqmwNw+qZF52k34ZA6LyryH2mRFAdu5kW3Jr5syFcSRkxYd8zGE1Ud69VOGuOUtZ+U42yd5YXujFGpWdNAGkCq5cufsnYvEIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5157
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

On 2/16/2026 6:16 PM, Bruce Richardson wrote:
> On Fri, Feb 13, 2026 at 10:26:27AM +0000, Anatoly Burakov wrote:
>> When pipeline mode was removed, some of the things used by pipelines were
>> left in the code. Remove them as they are unused.
>>
> 
> This needs a fixes tag to point to the removal.
> 
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   drivers/net/intel/iavf/iavf_fdir.c         |  1 -
>>   drivers/net/intel/iavf/iavf_fsub.c         |  1 -
>>   drivers/net/intel/iavf/iavf_generic_flow.h | 15 ---------------
>>   drivers/net/intel/iavf/iavf_hash.c         |  1 -
>>   drivers/net/intel/iavf/iavf_ipsec_crypto.c |  1 -
>>   5 files changed, 19 deletions(-)
>>

Well it's technically not a *bug* so I'm not sure if having a Fixes: tag 
is worth it here. We're not fixing anything that is broken.

-- 
Thanks,
Anatoly
