Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37013606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LfPO1JLn
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92C8040659;
	Fri, 23 Oct 2026 16:48:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3890A40265
 for <dev@dpdk.org>; Fri, 23 Oct 2026 16:48:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792766925; x=1824302925;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zkqF2dDd3ZHg/1FsiksZIpykYQSSJT2lccV0j6ECUwA=;
 b=LfPO1JLngvMWfzItR9rInuBucHPbVayp0+0BDBqBgNF/jBIW69nPVt7b
 AoB7ZCVeirnm/1CmmCjccNVN95zDAeB800pQnNvpHvb1HyW0rO8YMkYif
 E4MELrIwO4bBu6ClNOTGOw/k/HXmK62oSyTlD8UCtZ1uZazulU4eRTYnL
 bNF+TsCyDBsOBXQ00MjYKkFAA2dG+3g0hH1dtnBt8idI/08N+BEh1NC+O
 H58SMUn1NxOw7gBN5bQdU0LS3AACWdVbBrDVUIcn3gQUT6odIjWjANTKl
 Ane4rLxJFKTP0E3uUkmCpV108x7PFRvvNCiAlk7DedEu+OOfDAqhQreoW Q==;
X-CSE-ConnectionGUID: q46FJAKMRwewksvZlDwePA==
X-CSE-MsgGUID: Ksmb8nxPS/uLh0EFO/vxyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1531163"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1531163"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 07:48:44 -0700
X-CSE-ConnectionGUID: kkzuVDBiS0aNz2/WkjLv6g==
X-CSE-MsgGUID: v8awqFPOSBW/qJ0RKx0Vlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3688577"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 07:48:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 07:48:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 07:48:43 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.68) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 07:48:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqGfpisKPyS3Pm1BmMwOSpJsHS7Ca2UJDvua7uIMlF0menaLXXnGxtmYurlpPC8PSQDApwU2DCDDer6H3tKAtYCfEW+Ddn8S+iGFYZPxgpMZpwUALW4+saE+65utrERVq13w1Uhc/wbUeVBbHH8Mwtv2vCA7DGTXykMJcvj8wd10Z4S/uo59Y/U2txqWORgoVSjRuomcQdSoyBKoOvC76wq2KRawXJ/4wAwMLks/gcFhV1SU7UWiJ1CL0yw48/kQY7GwhbJPaHrG0VjNh5PL7uXPKh0FRHnP9h47kFTgax1UH/qEI4NHyKCgZoClhXtsHvEywEc3Wfc8XiCGLiRBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlP4j5/BD9qsC8b3YBeBIkKfxM0J1ZKGrjmrwhd/e7I=;
 b=dVis350yhRlFwDtJ0fXoFv+GWjQY7aYqJ1XfGslStY1xxqGqNehSgtTcHEwGY2Wj+IDjE1HVVTgjK/ZbMmPAXeeOoaDlQc5hM/I82XPGDCPRUW9mBfeHPGiYjQ4hcQhfCDGAyTbnzrAnIACyXEmAO/3tAO1bTyAtqOSoHorTRTP6KH9M2VD/qFWOgQ+zhZ/XUR3oV/UJ54aqXBuyk0WjJHdA5+naBM09jPys/rH7K3dkPOhq45roGCW4N/kXaeFY+DUO/EIfudFGFQi6BKBshhcwAaqbOBFIqv0mUZQ7MSN+GIPAe7jgs4FLDhZlg7N/XjcvGbaD+hhpxykNrrvBcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ2PR11MB8369.namprd11.prod.outlook.com (2603:10b6:a03:53d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 14:48:41 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.017; Fri, 23 Oct 2026
 14:48:41 +0000
Message-ID: <6be57c4e-0c3d-4505-a64b-ac7f3037d7da@intel.com>
Date: Fri, 23 Oct 2026 16:48:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] interrupts: warn on leaked event FDs
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Harman Kalra <hkalra@marvell.com>
References: <5766e02ea3243de1f63eb68efc210719f11815b6.1792763492.git.anatoly.burakov@intel.com>
 <6313a2be1e6288e2844cb13e0c8523f7296c5b98.1792763492.git.anatoly.burakov@intel.com>
 <CAJFAV8zHmbL99Xi3REFd6P0WEewstUZ29=imnbVoxym9KTWA+w@mail.gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <CAJFAV8zHmbL99Xi3REFd6P0WEewstUZ29=imnbVoxym9KTWA+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0017.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::22) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ2PR11MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e819fe-a066-4729-4ddf-08df3114baab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|4143699003|11063799006|56012099006|10067099003|261009223027099003|18002099003|22082099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: XYJVfVFDJhGegZZ+v1udzaLVD2RYpcJeCZRCAI4wF75ubRBEIKKSiQWWT0rnPVYbamoDz82zVjaYSfkjys1l2dVHsof+YdjsL5gnYh5c8kycy5fsGAjxTVT8ePk8DsnBUfqjd4ZkIC3077azyAMnlzQ3yey5nWQnLcIzaCvgOI+JNAm+Lwwm/w9krZ0tOmvlqhJWgeUIAeNzJKrpHesZzTO792//chcNQ45ugamWOMnWW5byTiQvO4LZ6/4ZctRIU1Cvn3tkkkrJQnbBCSDugGGjxh8WUk1kMnjjp5iy6OWx7J1SkMOKW3ahGiKeYX2jUu83LtrHGJim6siQcf/X7nMqhLm8oT+OXZvTu4IXhG0DEXZSKeG3+xMdM1DaXhmZMkXGYVpYL01zlgNpVF9de2iW+jYEbVbAsf2j6wHuCjRz0+dpiH95da+PuLYeRMV3osMhdOm2R5VYP99gPW4FITWzCg3XaKFbsxNpSnaUqTPNGKYJKPLZ8NTdXovpTB3UnRlzAHd+Bmm4+robJG3RA3yl4SpuLqTCLfRUa7Tdyarvy36iQmVaMQYkD46bz6lAycS/ncWlc24BUYsfIqzZMGXxKHDXyXkHG/m93oVxMR10RsV/DkDkvom5ERmBJoK/Fe23OnV/Rv6kSnKhIba7hNy0Nee0AMyzYN9QZv23+14=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(11063799006)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEdKaCszaXJ3Tnl5eW4rSWwyVm5GaUV1NVFXQXI1S3Q5SmFKQ04rcmNDYkM1?=
 =?utf-8?B?Wm1pQ0dCbFlDRGtoczRQWjAxdDkxMEI5SnpZWmtzRjFGWEpxaXBkWlc2Wm1U?=
 =?utf-8?B?YjZZQ2xrQm1TSHJGRUd1akdTU3BCUVdXN2hENGdFZGNXYzJNRDJtZnZTSUxX?=
 =?utf-8?B?d2RsSkxvR0JpOVJSMjllalF1cGRnUUtlS2xHRGorYnhuT09ORHJvd2hTNjRr?=
 =?utf-8?B?bVBOVVR2cENiM1BJTk1PT2lEL0ExMHNXMSsrbUVkVnFQUEI4bUlWL015UkUx?=
 =?utf-8?B?SE5NY0NCQVRwZTBBUEpVY05SMDZiM3pieWVVcHVDSnZyNWRLY0ZjY1B2R1Zq?=
 =?utf-8?B?azV6WWllMklXU2VuYzRqZXRBb21uUFd6ZXVyVUt5bXRTc0xXZVd0cWdSRzlB?=
 =?utf-8?B?SlkvbXBORWxPVittUTlnL3ZmVU5OMzR0UWh6MkNWT0hUUGhZK3RHUUVjTDVJ?=
 =?utf-8?B?WnFvUnR0aUp1WGtqWnRFK2p6Y1h3L3E1ZnpiSjk1V0JsSERtNFNxQlQxY1Rw?=
 =?utf-8?B?cmFxUHhxOU5IbHR0WlU1NTQ0MmlDQ0diZk5wMElwalQyYzhKcUxabEJvdDh0?=
 =?utf-8?B?SVRUM0xNUmNmZ1g0dDlWa1UwTFR3eTBXVmthRkFDNUtINXhJa3h0Kyt5eUxR?=
 =?utf-8?B?WUpuMkVIbTBEMkRoeVJPcmxJWlI1YWIyWDVqMFJsQ2xLcEROTFBVMmVNaGRB?=
 =?utf-8?B?eXFQKy9lalQ1dEp6MjdRVUJVbHcva1krV2NJVG42ZmY4ZjRZTnh6Vmd1SVRy?=
 =?utf-8?B?RWZTYVZPajYvYXB5S040MXNKWXBwR0RGOHNlWjlGSWFQOVExOTZGS3RiR1d1?=
 =?utf-8?B?VG9Ba3hyY0pDZGdhTUVtMCt4a2Nia0x5UW0zYmVyZGxmVE43K1RZQmFWWjZu?=
 =?utf-8?B?YUlhaXhNNm1qTzJBbkRkOWNjNElsM2YydnVVdnNiMXVpU1E5cFdGcENZUlpw?=
 =?utf-8?B?R2lXTFZqb1FPYVY4ekFaeTNqN0dYN1JlK0Z4YWdDMy9Xa21kVEF1U1Y1L2o3?=
 =?utf-8?B?NDg3c3lmSUV2LzdOdUVvQTVFeW9FZzJMWWVpbkNyNDZicGdOMzRESEtXa1hT?=
 =?utf-8?B?d0xFWTUyVXdadmJrUXhOS2ZnblVyamJGNXZIaHBudGtjNDF2RlZtZ1ZEbWhN?=
 =?utf-8?B?c0xTMzNGaEtnbklzT3k3R2txeFBaa2IrQjZGcThpYlEvTnlMT3lTWVhhUHVi?=
 =?utf-8?B?OVNuVXcyWG12SmxUY2psT0phOEx3WWwxNmVKb1MwTTEySC9MSVVNL2VQbjIy?=
 =?utf-8?B?R1VYTjRTbTFrSDRpeEJ1ZVFFY2x2MXJwOVptTG1XNlpsbjJsbHpoeTBxbXFs?=
 =?utf-8?B?eDJHbDZzWGxrKytrUlFIQjBFZktoYWwxRThBb0pyRFdJYmVzMzMrcHg4RFQ2?=
 =?utf-8?B?c0xOQjNSNmllS0l5TVNIRElRVG51TDdDdUJWQkkxdzdzY2MyRk95bG8zNDBw?=
 =?utf-8?B?alZLaU5IWVprVlVwL2F5QjVHcVFzMTFYRHhlbGNjdHpYd3pITnA5QzBxcXQ3?=
 =?utf-8?B?RDRSdkVyalUrSmV1TE9KRHFMOTA1VXRualZVQ09NSDYybmdxOEJiWTJxd2I1?=
 =?utf-8?B?bVVLbWdGa1BOSlRxVDFOaExzV1BLODlTTWxzYUhrNnVsR3p0ZU1JMjAzWkZt?=
 =?utf-8?B?M3NMRTZyaVBoSUN5ZDdrWGdiWFB0T2xDcUxVbGs2dUd5cnRBSHpEZ3dpVEhB?=
 =?utf-8?B?VEIwMGQ2Y2JWSFYvUlZST1VaSUF0MmIvL0Q2ZXZNbkVnZGFqRFN4dnUzbDI4?=
 =?utf-8?B?YnZFMEd4RnM4VEQwS05vMzB4VVAzZFl1amJ6UHU5Y2tML0l2NEFoRHh6blVG?=
 =?utf-8?B?UVFhelppTTJadHgvdUJ0T2IzTXFBWm1IQmRHMmJwK2RXazBHRXNzSkV1VHlL?=
 =?utf-8?B?MGRjZXEwSUhXaldEeXZjQ01OcTVHUy84UUR4NmlSM2pDWEtMRmZlVHY4WmNY?=
 =?utf-8?B?T0trUE51WFh4MXJwbFZROTBsNHRCMG5YTDVsNjJ2YnpmelRRS3I2Tm04Mkts?=
 =?utf-8?B?MzhvNUlxYkIzOW1xMDRHN0Jzc0JyTXRKTTdyTmozbDRQS0VJb0pSajBpMEd0?=
 =?utf-8?B?eWdnc3lweG9vcVVSWGZlSDMvdC9BSnBaV3FXWFZEQ0xvaWVoT0VsenRTZ3dY?=
 =?utf-8?B?VFZYbFNaZ0NvZC9RNG96MHI5Q2dhMCtJZlhlbm1BaWZiZThObSs1eXFFTzhS?=
 =?utf-8?B?S0FFRE4yUkZGOUp4a3djK3BYSGs0bDErUldXNnFDTmZDTm5hUU9UNEFSTHBq?=
 =?utf-8?B?Q1ZCRStYOVNqSHBGQW5qU0xTWE04ZldpL2NaSEdrQ21FWkdla2FzREhVZzBp?=
 =?utf-8?B?YXE2aEVtTitwV3hLbkcyaVFjYk9vNjhOWnQzT2pwUXdJWmpFaEU3dG8vUWtz?=
 =?utf-8?Q?nuejPzJSCHD2toxg=3D?=
X-Exchange-RoutingPolicyChecked: l6J0Le3HWFHK5LuWzZtH27NAAzcJ5+Fy5ELzLMuRSLBPYn6pQ+qrSzgJdXjY6CSRV+Ki1JMvybX6isKna2Jjln+YrWfDY1m4TkktTFgHdVMjW8g0/fHRontASjWQXl14c34XFcEJeVvR7sIdoIrh8I0zcZi3XtIXGunWZru2yquGWTkseLCrAB/D0g3oREAkX+/meEv1Evs4w8kGNSJop/1vYNo2pDpETarLiJ+mSrngGrVwRHPhsj0V28h22HR0SrsDA8Wg8rAg4v9Lke72NQb3Zf3zxubuXI3CVyeua3QinfsoriSRvZ+n1k0FOg8jhNihyyFnXYksbaZi9smB4g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e819fe-a066-4729-4ddf-08df3114baab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:48:41.2153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNL1sMoLcbh0S2AiV1fhzfYQBya5gSA7PtO3ELRDWjiIaucJwU3LUypiwYeoBcULWIxNU9zfW0UImoa8pifdVmeZmjpjiqcZpPhVJjvkGgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8369
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/2026 4:41 PM, David Marchand wrote:
> On Fri, 23 Oct 2026 at 15:52, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>> diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
>> index aadb7b84a22..f6f51ba53c0 100644
>> --- a/lib/eal/linux/eal_interrupts.c
>> +++ b/lib/eal/linux/eal_interrupts.c
>> @@ -1667,6 +1667,8 @@ rte_intr_efd_disable(struct rte_intr_handle *intr_handle)
>>                  for (i = 0; i < (uint32_t)rte_intr_nb_efd_get(intr_handle); i++)
>>                          close(rte_intr_efds_index_get(intr_handle, i));
>>          }
>> +       for (i = 0; i < (uint32_t)rte_intr_nb_efd_get(intr_handle); i++)
>> +               rte_intr_efds_index_set(intr_handle, i, -1);
> 
> We don't want to waive for types != VFIO_MSIX, do we?
> 

Looking into this further, I suspectwe want to check for != VDEV 
instead. All handle types except VDEV will write into the handle.

> 
>>          rte_intr_nb_efd_set(intr_handle, 0);
>>          rte_intr_max_intr_set(intr_handle, 0);
>>   }
> 
> The rest lgtm.
> 
> 


-- 
Thanks,
Anatoly
