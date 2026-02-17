Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9B5E9A021
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 17:24:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B2AF40663;
	Tue, 17 Feb 2026 18:24:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id AE95C4065E
 for <dev@dpdk.org>; Tue, 17 Feb 2026 18:24:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771349074; x=1802885074;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=D2QHMnUDjXZ7QT+cmJNKLRziTAOmi7s0y0g9p5h3ltg=;
 b=HrIknLqFH6jfxfXePIGKhkfxPj9MCnN0q39/4mxd5v8JMbA0SfV2EQt8
 iyZMPW3WbfgfRDcBLiL6RgzjBnoXYDcJCVnTunsrfeBbMWmZzfKroIdB9
 S5e85zKpxW95d5DyfoIVTdZWdiyaPRW8tzIQcB12+5BeeUPzKy9ae5jZv
 23/L85QJdlQvjiHFerslaPICFp9xDRNM1+ISLKqPeBD+h3EwHAavX8J/q
 xcuxGlLO6CzzDcszjX8fKWxSpn6cYIco8UdlJzU56OajE99K0KYH1dxPz
 9qgr+QiMabBf8zEAs+lc7wOK6DWo0mJxeneXZt5hbf76HunDcNwmhQ/eS g==;
X-CSE-ConnectionGUID: /mSraluTTEmWOD+guG6akw==
X-CSE-MsgGUID: 80eRwzMKQAKFUGmUTuKhvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="59990520"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="59990520"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 09:24:32 -0800
X-CSE-ConnectionGUID: fb9j+ezqRvOcPGaRbDP6bw==
X-CSE-MsgGUID: epHPHd0AT5G5kbmywHWu0g==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 09:24:32 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 09:24:32 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 09:24:32 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 09:24:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfDtJZogQdjDMIGADu1xnLhfQW4fJ7A79haXb1YD8wSiQQy1HPgCr3dyYrYNrqjkYG9jP7Y3hpmpMLmylDY9ap33Qb4WVbg3XTkArFlBb00/0uhrDCZpYSBcr0MvDsUxu30V9dQVC0SWxbG4/nMJk/AQi6FKt5v5zC4en7fXCADKgxRzmaJVtcY5wjbcFtawtXSwJn0MSnvAdhMQlDs2Udb4j7xxrib4dJRgA2YjxmJgbLHhCpsGfu41wByOX7vG+qi7S9NbC5LtELe1xjC1BZf/Spongsgh8YaIgVxqkPkam6gamhOFj69UlNRRCh0swuOKMt+t8rMM6aSyuZoaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8wRPaEleRGcX4SsWe4YE3GJYJhCaSqP0hwgEa5yDgc=;
 b=KHHqKHdeKZygeINPVpOTNjAZHb4RZ5uhmTd206W5lpGoknbBY+6GhLg+R48YQ/lhdHaiChQPBsFX+kfYtF5qUzUHj+KWJ4ucI7qdL8bYo0s+rTZ6/roI8sb1jHewogGPksjW04M4XKJZTuLlq78nuyPY8b8m1Rd1UjJg2xmPqWiaIdiEmY85hX2GARKI/L1x5aoC9nZGS9vpo58aFlEcNuMkvkFUiTdbto3FIy3nrOY8fFXidqDLcHJKd3Ly4aFhwzIkrCUUIphVTFZ+odd8IjmC2W58PqysrzSwYWjohL85aMZHbFghIrpCf2moNkxqHvD2wnAvpTx1N8K/FVx59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by SA1PR11MB6686.namprd11.prod.outlook.com (2603:10b6:806:259::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 17:24:30 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Tue, 17 Feb 2026
 17:24:29 +0000
Message-ID: <9da0e1cd-7cf0-4cbb-951a-0e569bc069fd@intel.com>
Date: Tue, 17 Feb 2026 17:24:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/27] net/i40e: avoid rte malloc in tunnel set
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <bb6d5420279bcee1f82b2188841217594eafbaf7.1771330391.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <bb6d5420279bcee1f82b2188841217594eafbaf7.1771330391.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P250CA0029.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::34) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|SA1PR11MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f809ad5-7269-4328-7851-08de6e496853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFdsRWEvVnF6c0ZGTlBnUVBVOXpla0YxUzAxWVpmc0VXc0dTUE1va1FMUUJj?=
 =?utf-8?B?bFlXWUlnWWFocWx5UmZiUXlHR25PeEhrNTNSUGpGU2Z6b25uYlJmTTBJaEY4?=
 =?utf-8?B?UEFkWmtrVStHQUQ1YWdIOXhrNVVwaTJrZ2E0ckJ2S1d3V3VRSXRISytLTkN6?=
 =?utf-8?B?OVZjd3drUnJLdVZIVjl3bSszSFNLN3k1SWs4YkZCK1NWTklNdE1XMFdJUEF4?=
 =?utf-8?B?Z3pzWDZuSjFnUmxvSEw0dGV0T3MyY3h5bldLd3lzNlpKN3pocGI5R2lEQzhh?=
 =?utf-8?B?SGJiMzFza3VBQXdYek1IdXprQisyS3QyejlaTDBmSkxMUTA3T2JiSVExeFZo?=
 =?utf-8?B?OFRJQS8zR05haXNkbThmWDFPNFlFTzZzbFE5RE5vWlk4bGVBRjJxOUU2dS9x?=
 =?utf-8?B?N0FqRXpvTGgwSjkrR0FobGNaajBmeUl4bnQwRnhRVEw1M1l6SnBBSjJ2L01L?=
 =?utf-8?B?aWRBT0g4RzZWSjhTZ0NIVXZiMUhlTnZ1TkFuQ0tGRW5xMytpMk9KMFRDSi9q?=
 =?utf-8?B?a3FnSDJmYnBZV0F3VnZGTG9PZXVjU2tJNVZaaVVhOGRkRW5va3hUTXRYcmM5?=
 =?utf-8?B?YkM1NnIvQnNZQmEyVlMvWXFUSDhwdzlRaDdjRTlpUitDeXdLckc5OXlDTkt0?=
 =?utf-8?B?R0ZCQ28zRzZEVG5uaUtFdnFGMTg4NDZhQVYrR1htK1dkS3E4V0Y4M2NpT2tv?=
 =?utf-8?B?YWJsTWZaZE1wU0E3eUF0Y3NMQzFvRm01U1JYNEZtdktSTEljUFVDcXdCQ3Ny?=
 =?utf-8?B?VXBtRlhTUEtZUnd6ajFUdDkyQW81ZHljUS8vWnhGa2RueVlkL3pLUlRGWUFQ?=
 =?utf-8?B?Tis0RlBBUUoyWmhvdU1yN0wwQjFJQUF1NmpwSk5BRU10TGs2aldlUHBKbHg5?=
 =?utf-8?B?NU9HREhRVHc3YTM0c0xINjFZWUd0a2FJajR3UjMvQ0loVmQ2L2FoN2xIc0ZI?=
 =?utf-8?B?WjJWTEFEN1hHMlhVS2pWczNiTlFNaDFXYSt3SGhlQjFvd3BnOERZR2JYcCs2?=
 =?utf-8?B?WmJUbGFmL2JUTnBvUEFkZE9aVDBPVFZMSUkxZnl5YzNqUEplK2RmZ2ZKK0Ji?=
 =?utf-8?B?U1lJVWIyRzgrS2NqcENXUUxZWU1OYUFjbEJzVGVMYm5ZalRvZnllMXErbU9p?=
 =?utf-8?B?eWNuSzN2WTBremhPaU1QT1VCQSsxN3d4akd6RE1FWGtyWWpuTm1UVmdkR1k2?=
 =?utf-8?B?TEk5dHRlWVg5NDkydVZESDR2cDhvSGVHYXVQMEhUc254dUlVK3RlQlN4b1dZ?=
 =?utf-8?B?cEUxTGRYMlRYTzNnK1MwQ1Z4KzcvMzlGYkdWREFWNjU0ZVlJV1Urb2xmcHlR?=
 =?utf-8?B?ckJIbnBwcmk0MHl3aldBOHVaMEV5VXoyL1VPRjlaZ2V2dWk5QnRiTE1FN1J6?=
 =?utf-8?B?azlNcDNlTnhKNFN0aGZGbTdjZVFoZnNGUkgwOWpHYng3NDhVWTc2WEVCU0ZU?=
 =?utf-8?B?VXM2MTY4ZktQTjB1QVlEVjh1V1p3UWJKWTdVWk4ybUdWVDUrN1ArTnU2dWxI?=
 =?utf-8?B?Z2pFWE13c0J5M1hmNEtZNzRvRDhVSVhQTGJHZlVwL2hleGJrSnllaS9RODc0?=
 =?utf-8?B?SC9wdnJ1d1RaU3RVMkZUclZ1citvbWdOaW1Hd1FieVQ5bDhKdnJ1QklUZy9q?=
 =?utf-8?B?dk5FQzJrSU5qSHpKaGZlSTZMUzRWQ2tobE1BMmZzbzVLRWZwSWNRWERVNDR0?=
 =?utf-8?B?UmExbmU2TTdMNzhFbENJdUExTHZNZDdzeGVMeDNYQWZPWHJWOGRNNHJrOTRh?=
 =?utf-8?B?Wmh1YWVvRjRvTVM4ZEZxdERwOFFyZDhzcS9PYVlUK3BsNU40bk9sc0N3Q1I1?=
 =?utf-8?B?YVpYUVJxb00yMVBGK0Q4U0I3RUJlYU1qeUp2ejhaMnU3ekdhSFZEaTJ5d2RS?=
 =?utf-8?B?WktKL0tQRWpWelhpenp1RDNoT09LZHRZTmRsUXJINW5sOFd6UVpsUUNNT05z?=
 =?utf-8?B?ZFExV0Nha2JrL2o0OE5RRVNicTUzWDBRSDcvZllJWE1XUytxbDFIL1grc3FZ?=
 =?utf-8?B?VGxvd0xlS3pnb3dkQ1hrQk1renBETy9jSDNGbTBZeEtQbVNOdXhJL0xMbXRV?=
 =?utf-8?B?R3p4RXgxS05Cc3kvN2lSbGRseDgrVU5NUnkzZVVzemJNYXppTFhQTldiaVhU?=
 =?utf-8?Q?4dqM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2puZ0tsVm5hT3duV1RIR3locGxzMVZoNmp6LzlZb1VSa2ZDQTZVKzYvZGt5?=
 =?utf-8?B?cDJ1RUg0UGxCSUV5WERHdllNckFlMmQ4cnJDQzNmeWFyTTVUV1Eva0Ricncx?=
 =?utf-8?B?dmRDRmNGcVFWUVNmY2JlZUtlSlZTc0FQZ2JUL0dhM3R2aWxqOUJBdTR3MHBy?=
 =?utf-8?B?NHNjNThUdEJhS1k4RkRyVThZSk9sdFBBZDE4YTVTeGdpM1ZQMlpGT3hxak4x?=
 =?utf-8?B?YWZudnJJdmZjZ2lMQjJpRjBRbXRWZkZJa2FhQWw2WTh0aWFjMjBvNEwrVHov?=
 =?utf-8?B?V0hMdVNPaHptb09EL242L1lQTFlZUmd2M3o0d3RRSUhTRWZKOW8yajN0d3JO?=
 =?utf-8?B?UGVPL3BIOWJrbmVuclhweW5XT3NNYzVwTmVqTDRRNjhlVkd2WVlQTHJZSjdJ?=
 =?utf-8?B?K3BTbVR6NGtVcnQwZnAvWFlvQ1g1U1R6RGhSeDBtZ2JmaVcwZEREZDBCeUJs?=
 =?utf-8?B?ckNBU3lnS3FwbHhFSTFVVXJzN1R2M1hOamR6RWJ2RGplVmRVU3lhSkIzQVo5?=
 =?utf-8?B?WG9PZ3hmaTBYeThMS09HZTFIeWRKZFM0Y1l1Y3JPYXlDck0vY0RaTXY1eHJn?=
 =?utf-8?B?OXRCQ2pyb1ljRkdwNUh0R3dxcE5IbjZ3NEFZK283TjNmTUF4clcxS0dzYnZF?=
 =?utf-8?B?bWZHbTFzbjBDeVF4K0s3RktzQUxXMU56Yk1NMkZremRsVFM4TC8rS29Wd1Y3?=
 =?utf-8?B?T0hPVTRVOFRIWXN4UlhUbDFVUnVyZXVvTFluSzlsMUw1eHM3T1EzLzhNcnZQ?=
 =?utf-8?B?Q2Uwbm51eXBldUIrSDYxN2pkQTcyUmlZN2ZLSEZpamFnRk1uLzl2anRncUww?=
 =?utf-8?B?Y0hESkNxTDJ6SU9jdEp4NmdkNnFKYm1zTTdTRGg3bEVLdFc2eDh4bEVFMmhF?=
 =?utf-8?B?bUphWmNiQVB2NU90WFB4V0MxTGJmUUhFWkgzUzF1MVppb0IveXJHQi9mVCtD?=
 =?utf-8?B?NExIdW40WUZ5SzlvaGJjL1VoVVJncU4rbWE3K2l3V1R6NDhaanJ6MkF3SFh5?=
 =?utf-8?B?ck9YNU9RY0NvbldKT0tBNkljMlBYYTA4V1h3Z3pUUGRwMEZoenZ4cXJtMnVV?=
 =?utf-8?B?bTd4SEt3cHFseW1xT1ZZcm85NE1mdDNrUEp3aGNmS0NTcm5YRGREZW1wbXVC?=
 =?utf-8?B?aUtTcmZGb1o4dGJVVTJ3eG1vdkJIdVVuRnlWVnp0YXVLT2tUVHRFMTRHK1VG?=
 =?utf-8?B?bXpPdTdWNzM2SlVSTnNPRjNOa2dXT1lHb1k4U1VlTlF3SUVpM0tTZlQ2YThU?=
 =?utf-8?B?Q242WkhpUU1ZcXowWk4wcTdOZ2I1YjU1L3ZubVdRcGJ1T0lldjBkbWpQUlVu?=
 =?utf-8?B?L0taMXJKY00ydG55ZG5LSU9tODhhdDQ4UnY0YzJGbFZ5Q3NzV2dCMUV3V0xw?=
 =?utf-8?B?cWJISDB4Qk1GYnpZeUtrWkppQ3NiTUZERDN1YWxQa256ZUJSZGVTUHB4T2hV?=
 =?utf-8?B?anlxSW9ianV6TlFhS3c2RVlncUVBdVpkNHdyRThueEdWQWRVSGFZZVYyREMw?=
 =?utf-8?B?V1g3TCt0Tng3OGJNWmdLaCtEUjBzckdUSGZiamM4U0NrRVNYVHpQaHNjeTFz?=
 =?utf-8?B?V1B1RmIzTnJPU3dTb1FkNmxMdkxYOXd2SURRdXB6azJVa001MVhHTmR0ZjhB?=
 =?utf-8?B?UzZPUlZidkVldjFzeThhc0hQdEprY3o5eXlJTDJlbEZJN3lXd05maTV3UHIr?=
 =?utf-8?B?WUtDRFZCS3UrUFBncFBTMHJCOXVEUUpIZzlTSW5OTFpWZ1N3VGhsN1Z2ZjA5?=
 =?utf-8?B?azJxbDRJOUR5SGxUSkxreXZXclNrMCtGbVpzQzJxbVdQNFZERmhVMno0Z2Zh?=
 =?utf-8?B?a0NmUTdTUW54c3U4Q0FzRUZtZDV3ZG04V0V0NGpYVUdkNDhWZkhJK2k5NE5s?=
 =?utf-8?B?RkJQeU93VkM0T1lEbUgzUXNZblQ2L0dkaGdjUjVTZm40R0g5UzFWTEM1c1RO?=
 =?utf-8?B?RkJJMkJTZEg0TzFEZlZva245TTRjdzZDb1E1cWxSS1lFOXlMSGNNUXI4dEVs?=
 =?utf-8?B?Zlh2OW1kY1NlOWtHdlo4NWszVW5ubUFyZURyNHViRU1EQUtuSmw3T1ZLMURp?=
 =?utf-8?B?Qi93TDZSaVBrQUY4bzlOYWFVeTk5L0JyY3BSWFBLcmFDRm9VMlQrZUJKQnBM?=
 =?utf-8?B?QmVWc3VtVk96TzdOZnlxVUxscjVmRWpXTzRzQjJmS0dMd3dnUmJieHpjQnlv?=
 =?utf-8?B?MHNZcXp4RHNxRCtLZ2cxK0dwdkQ4SEl6dWY5SWZxS3BDU01YYlNCUVMzWS9I?=
 =?utf-8?B?a2ZFRE4zblVrRmMzWTBrMTNFSXVMSnVVQkhMZVY3RG1NRDRnUXVaOVQ4NXAr?=
 =?utf-8?B?SXIyNE51VGYvZTFuUlBxWTR5UmpMbE9semw5OE9UMUFJMHRVampycXIxTXJq?=
 =?utf-8?Q?4upTh4/5uxbkpLrY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f809ad5-7269-4328-7851-08de6e496853
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:24:29.7760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iK7nVfsAmhvDpN91ft/sL67QwW7HegUIyrDR/MNqxdo3PkqSVh+18TtDdHpJx1RbBjKFcCnlVZi9SDmMK5DdZ+T3fO5TmeQvWfbZDd+DTy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6686
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 2/17/2026 12:13 PM, Anatoly Burakov wrote:
> Currently, when setting tunnel configuration, we are using rte_zmalloc
> followed by an immediate rte_free. This is not needed as this memory is
> not being stored anywhere, so replace it with stack allocation.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/i40e/i40e_ethdev.c | 124 ++++++++++++---------------
>   1 file changed, 53 insertions(+), 71 deletions(-)
>
<snip>

-- 
Regards,
Vladimir

