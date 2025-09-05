Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C36CA0FED
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 15:57:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E53A7402E7;
	Fri,  5 Sep 2025 17:57:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id E37DB402E5
 for <dev@dpdk.org>; Fri,  5 Sep 2025 17:57:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757087825; x=1788623825;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=V0koY/emUcXOjaVS5cGVe1TG7PCTCzvYMC1h7dEmxRI=;
 b=JWt38MHiml8RWgPEopIMRl/fwn1IYz37R8rhy3AmBrq5yqMaJanuNWe1
 TnI6UORdVmuWW12Lcq3K8Z1fzaC6TnJKk3C2jvrO4VJsaOsDi6/98LG0c
 DsPFD2lgxLZ2f7ENIimwajiIbkjuwSbBjjrhOz3vrk531m1kUzY+WCBNC
 7kS0iGUTI7+wIcU2pLEkUiPHEUU6Zetx9t+swoVv8ela4uZwl/reNI/ld
 eXd25jotsugZjDOJ+NbbAGi6SepTuYvGF0A5Q77wLGQX1D+2aHEpVBtRZ
 cFD+KWrdMAmDHdQ3tU5xLGuaYSwovjPWzAwk6j+DPp8Owe18NV7Tx6rQX g==;
X-CSE-ConnectionGUID: wC1ymAfJTdumWSVDh4OrCA==
X-CSE-MsgGUID: VWkBsqvZQRazaKhwkHCvXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59362892"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="59362892"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:57:03 -0700
X-CSE-ConnectionGUID: lsDzfGLVSMmGqkq1pbWyVw==
X-CSE-MsgGUID: keEs/WU4ST+KfUFuofalsA==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:57:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:57:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 08:57:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.54)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:57:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHTn+d5LcdWWmud6kdV4+tyGrcR9NOE+XvSgMT8UFlfPbIkP8msqfp+gZpUgWZyMTrbDXRrPoHUMswkPRZJVWfR7fY+sdA7xlfOzyg55eanzsaKNS7zzrd5nZZICfoPYQFA1ajyhMM2AgpVKQlfHXY+CXJrSyxu6eFHxSvfw7z8ecyUJG0ITUUXqW6tkxYgmOdCqHlVEAAgWFjtuJA5bO4inCtxTj3vw4kNQgwjZJDyHcQ2LP2keQeCdqceCWxgyfzH4czyYPtaaCfuOZ0UcLRqAo1OOTYO7hIxh9fFp6or82ItmdZuSJMrfNZH5ERh/R2tZbm0xQ6rL5TuSxoFv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qCi3HN8k8hVs61wrNHW8rcRPn/O2a9BJpKPs9XGIJM=;
 b=iQ1S9Qn37kqbKIaOmCmNNoKKtIfWTmmrUlo1WWspWRWEeHrJc9vUZknhE7HNF8jCMUg+yyrN7xqtEsN4lc6j1ELenwRWgV/rWdZzF50uZDZRC7y8iRtwwSNOiaG/aifZWniWcQE0SCMW03rzVB+g7jxNmFaa+sAjMy2RcQpRdw3nzsYs8qYRcN4r5+wYifmhBFzPP7xcqX6TBR9WWUKuMGZgnPwF3qrifiXR9BCc/BI+4GRBj9xz4YIehbYKo9pZq4imS3uDXnbneXju1hZAXBYj1tBkBTFecE03ln3xrUCUys5yBziLrg1scPpJ5KJCYO3nrJh5BcK4TiIwTbRTRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8443.namprd11.prod.outlook.com (2603:10b6:610:1bd::15)
 by IA3PR11MB8918.namprd11.prod.outlook.com (2603:10b6:208:57c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 15:56:59 +0000
Received: from CH3PR11MB8443.namprd11.prod.outlook.com
 ([fe80::7cb0:dd30:85d3:8f69]) by CH3PR11MB8443.namprd11.prod.outlook.com
 ([fe80::7cb0:dd30:85d3:8f69%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 15:56:59 +0000
Message-ID: <71261e26-1429-46da-abc5-a2e6c5c0f5bd@intel.com>
Date: Fri, 5 Sep 2025 08:56:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/12] net/ice: count drop-all filter stats in Rx stats
To: Bruce Richardson <bruce.richardson@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, <shaiq.wani@intel.com>
References: <cover.1756833701.git.anatoly.burakov@intel.com>
 <8b65313e9b85aa1a27e429c5dfbc2875d0ab724d.1756833701.git.anatoly.burakov@intel.com>
 <aLsDHFBtuya_1BBn@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Shaw, Jeffrey B" <jeffrey.b.shaw@intel.com>
In-Reply-To: <aLsDHFBtuya_1BBn@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:303:b4::35) To CH3PR11MB8443.namprd11.prod.outlook.com
 (2603:10b6:610:1bd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8443:EE_|IA3PR11MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 44dbd6af-ddef-42a6-354f-08ddec94d7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkUrRENTUjdvbWRuRFBwODdhWWRXZDJhMmJIanpzS01LN0s3MllacWphbERB?=
 =?utf-8?B?aGFmNTRnT1E0dUw1ek5TZDZ4d1Z3TENvbnVuaFlZbW15eEp3dTB1RmNNNnV2?=
 =?utf-8?B?UFlCeHIyY2F4MDAyWDIzd3l0UUpaZnhsMTRsRHQvc2V2MWZERTM0MzRtamhs?=
 =?utf-8?B?bUFzWUJjalhXdDUzbGhwVUpKZWtacUlDaDljWCtTR2VhUGh2UkN3NUtZdmlv?=
 =?utf-8?B?SXQwQS9Bb3NaWWJPU2ZlQnZHejBmKzlLVnVDOHh2U3RPZ05lSURreTNHbzE3?=
 =?utf-8?B?S2hBdmJILyt2THBmTFJsellqaHlsc1RqWjN2S0ZRMkYvT2JGZG56RTU0REc2?=
 =?utf-8?B?R3hlWDc4RlZwRnl6OWcxVkpVMXYrUmswT2J1NnNxWU1hN1pvZFJRck9hZTNq?=
 =?utf-8?B?bHArS21aWXR6M2daZ0kvZWhGN1R1cE1WdWFOMTRSNE8xalhqd2xLU21uRy81?=
 =?utf-8?B?YW5EN25BelNtUzNyNGEwSWZ5Mk1PU21RV0hHNy81UHh4WXN5MXVGdFZnbU1v?=
 =?utf-8?B?bTlJWU9xRWIzQTBYWHduSHNWckJpWEYwdnRlajhBYUptcWJpYzJZVm04YUVv?=
 =?utf-8?B?QWZGczZYakY1dVdaLzFubnB5M0dqYUpJRUhmOE03SFh0TEJVQ1EvZU5KQnZX?=
 =?utf-8?B?NmI4Y1JFdjBOSGxiTkFyUzhyNFUvS2xiMUpwcEtSc0pQQndGMWVRaTJxei9N?=
 =?utf-8?B?VHhXQlltVUxVOWw3Z3dvdmpaS08wNzg4dkV4Wm9BZTZINzg2OHdHK0J3Z1lP?=
 =?utf-8?B?UnVsVDVDdVV4L1VEcUUxZjNHZDQ4NS9PWHFGTkNVTDlxWFg0OWRKSHBGaGdp?=
 =?utf-8?B?THF2K3JDbDY4a2hHSVkrVTNYeHlPZUZSRi9wZmlxNW9TbllWMjRWcFFHZW52?=
 =?utf-8?B?bVRFTVJKb3RJWmNlRTBiWndBamRQaDBhTHBwcE9hODBRUGhuN3Q4N1hPdGt4?=
 =?utf-8?B?WHBIanZlOWxOQ0JyNHd3MXUvWDBiVldhamJNb0kyamZJSFhXQys5UXlpRFZ0?=
 =?utf-8?B?MjdxVVYwYlBBZ1ZoUzZ3ZkJuejJtRUlka0tHUVhPc2p1S0dYWkNPOWpYVzUw?=
 =?utf-8?B?Z2hKeDJ3aC9FT2w1U1BRUno1L0cwOWFmRzNhYk1sT2ozMTBJd1RCenl6eTR4?=
 =?utf-8?B?RGtrQjQ2WVYzWTJpSzI5Z1lBU3hBMDZWR0RGUWh6U2JuZSswQ05RRGJ5d0V0?=
 =?utf-8?B?Y0w5eTRKajZrY3BLZVY3djlEUCtGMTA3NWFuTVN3R3JQSVM1SDhURktadUpB?=
 =?utf-8?B?UktHUnhKaHhCRHRjTENBZFF6ZWs2N3E4Q2pNVVJxYVdHNnA0UFA1ays4RXdK?=
 =?utf-8?B?WHcxSDVxMk9pVFhVdkV5VnNFNlVzV2VCaEVIaWxOa3BHOXRRajNTUCt1QmRk?=
 =?utf-8?B?ZHJiNkpyOFFjTUxickV4eWdJRU9kckg5STAzcWMxUFdIV2QyeVBZR2RJVTJR?=
 =?utf-8?B?ZVZDWmZFTytEdkVJcjEwTFpOVTljb01rUlQ3Z3NYdUlTRStsZHpWT1VKRCs4?=
 =?utf-8?B?aHQzU1IwR2Zxb3hxRVBVdzB0S2pqUjZPZlhYb0hoSkNtTXdlcWtIYmVUM1No?=
 =?utf-8?B?Si9DNDc1dXdTK2lLSEpYTHFZVFNWRzdFQ3Q5ZGp2RXRMUE9EUVZKcEM5OHNy?=
 =?utf-8?B?ekdvNkdRWmJ3NktxT1lJUHdBSVNMOXdqOFNma2FWdzNsS0xLZERaWEtJUW9K?=
 =?utf-8?B?UmtOeXovcU13akF5Zjlaanc0MXpRZ0h3bXJJZ3lseFFOU2FBS2lRUHFnVVVV?=
 =?utf-8?B?VUcwaTdnbGFOSFQ3dm9FRlVhbXBSbGhHVnYrMUlnZHBlY1Nwazh4TEZCckhw?=
 =?utf-8?B?RHdpVVJub0hBdFVodzl6dXhiVUo1TmliKzNXWkpmTlRXY0YrN1lHOURDbnZm?=
 =?utf-8?B?aENnL3h6c2Y4NnpOWTQ1cTMvb2lwdWh3QTFFSnBOWTY3bXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB8443.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alc5dE5LQktJdjFIUmFSYzFmUXpaVDhMMWdobjBsQnVRcTBpYmM4cVlFcnBq?=
 =?utf-8?B?a0JCU3VQa2o0aHdFVXFUcG1SMjlFU0tTcEF5QlhUbzEzYXEyWjBSYXgzMGlG?=
 =?utf-8?B?MXYvdTJLR3lDR0QxWGxIMDBjUFpTR0JjeUpTSVRmUnhpUXoxa3BVeHFad1h2?=
 =?utf-8?B?RTBIY1R1UVlaNjhWZ0t3a2JyYTlpd2NNV1lhWDhFTEE2bVFhYUF3Lzd0WVp2?=
 =?utf-8?B?VForNC9xTGx0Ym54ekF2ay8ybjBZR2dDRjNoaFVtQ3BQN0k5ZnI0eEVxTTUr?=
 =?utf-8?B?REtMS1RmMEZFQ2tERDNRbWIvcGVJdFg2Unhqd2lYNkR1amF1WERvVTJuWlpm?=
 =?utf-8?B?cWg2MU1sMlFRdVJkbzIzY1NzSEpBa3RtUDlVMUJ1Vm1XejFIZkVCUnp3dTZM?=
 =?utf-8?B?VzZaYnJ2bWswM21TNTBTKzBlYlJqeXBRV2FJTi90QVFZREk0azk4YVI0WnV2?=
 =?utf-8?B?TStXK3p5SFA4Vng2Nnp4ZmFLM2QrS1JmQjJjOCtvMXh6OCtaQktVaitIZ21I?=
 =?utf-8?B?NCtKc0RONEcvcW9Bd1JYQXhLL3ZacmR5bVZuSEJrUTB3MmRoZUJ4bzlkSTM1?=
 =?utf-8?B?SnFBT3dlYmFLSmNGWFJHNEJiRU10REZtK2lzR1pNYlYrSE5MT2I4NjFJTFJC?=
 =?utf-8?B?VHl3ckRuVkpucVRRbVVwWDhWN1JnNzlVWVdmVEFhSjN3STBwREpUbjhmbFNN?=
 =?utf-8?B?a2Z1TjB1ZnZMWmpLZzdGNW9IUEN2ZHJueWFWRml2VGFQc0g5Nk1qVFR4d3VC?=
 =?utf-8?B?MDF5RklzMGhFWTFNWVNQTkxUMFArVDdVcEp0K2N5QW8rVFVuRElOU29jb21W?=
 =?utf-8?B?V21vSWVzeW92R1FRc0hQbld6a2M4QUdyM2k0L2hKaFZ6ZlFDT2dYMVY4UE5h?=
 =?utf-8?B?dDBGS1pPRmlJU3V1a0pseHdHWCtlbmd4UDREc1Y2YW43Z0Z6NTQ3cHdYT3Zq?=
 =?utf-8?B?NU80STJ1ZTJJSCtOZXUzZzAwN21jVmsxMDM2WjdtSGtSaGVoY1BlMGNhYy8w?=
 =?utf-8?B?VjRDUVN1d2pIV0JseE4vSlVqL2huZHpwZ0gzcTZVSHpDNXU1NWowbkV5YjZ1?=
 =?utf-8?B?RlVmZUkzYWVxbHVYNUl1UFVERU15OEFNQkcrM2pLUXErUW5xVEgvNFhvQita?=
 =?utf-8?B?emMrZGNad250NHp5WVFkeHpyVUpqcVRCZTgwYlRiMEN0Vm5NZDkxS2YrS1Bt?=
 =?utf-8?B?aXh2L3VhUktUQnVFU0NBR0lybllqdXRoenQyUTFBaTNZTTdNbVl4TEVIaDU1?=
 =?utf-8?B?NUVmOStqNFpOUjE2SHRrUmlVdDZmZ24wS0dDRDYzL1RvUTZDM1Z5Vm1jeGpK?=
 =?utf-8?B?cld3MHdtVDNmeEoybGt3Uy82RWdhaU5CbkE2eGlMQlhwangrWUMxV3dMSHZu?=
 =?utf-8?B?eUpma2JIRjJNMXNRWlFETTFkR3cyaWdOYVQxRXBYdmloRDdJZ0NSRUM3akxz?=
 =?utf-8?B?dkoyY2NKWlNmcSszbDQ5QnRLR0YxQTZQenFwUGQwZkliV0VlV3NnNE9yVlJH?=
 =?utf-8?B?RTVwZUl1K1FpdlRielZYVjJvdVhNVXFvQU9vT0g2TFFLOWhGaGtuNHNIbTN4?=
 =?utf-8?B?blI2VHBQSUdPUjUvZE11NFZ4cHVXRUhWWThRSTZROTA1UGw0VW5LTTV0Vk1m?=
 =?utf-8?B?OExXSmV6a0RsSW9OS2p3a2xKeG5GcVE0NjEvano0QW5KL1ppRXpibCtXM0hz?=
 =?utf-8?B?UVc3VlY3UDVyMDE1NERKUkVCNzAva1QxWTJiK01tYThFVVFiUzVTTVF1QkFo?=
 =?utf-8?B?MWlVYzF0ZXhiVG1YZDRGcFNLYjNQSDAwTmlxMjV3cXlvSUpLTk1wZCtxK3VY?=
 =?utf-8?B?YURwMWorTkgwTGZuQXAxLy9Ja2o4T25SbDM4K2lHM0wyaGFsYmU0VW1IRDFL?=
 =?utf-8?B?NDZ6SlQybjNhUFdnSGViQjlOZmJsak9DOUY2cnFHa3k4T3ZMYTg2aVg0QUN0?=
 =?utf-8?B?amMxVDlmbTUzQUh5clRvem1qRzIzQ3UzQmE4R3BtUnl1MnpxZHhFVUhVTXZv?=
 =?utf-8?B?TG5rQTJFdHlKenQvK0FqL1hVYXBIQ01xa0ttMndTcGdOdXI0SEZjZjFIUEhR?=
 =?utf-8?B?Q0R3YmIyaGZNS1ZQK1hZT3FRU0p6TmhhbkJWTXZycGFrUHZNN0p6cUt1Skxn?=
 =?utf-8?B?Y0I5Z0oxY2dQUGd3N3B1MFIwNTRjTU5OY3Rjcm5SYTU1czNxYU5hK1kyQmVo?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44dbd6af-ddef-42a6-354f-08ddec94d7b4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8443.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:56:59.4219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eR7PvspYg53sW7qZf5kzuYJ1ucRewyBADAIBUukAJtsQni3VPc2UFOQERz8zglHy5+9MknWjT0MXd1Ra4e07wPV7t2YX3ZWfSo9C/wnekA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8918
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



On 9/5/2025 8:34 AM, Bruce Richardson wrote:
> On Tue, Sep 02, 2025 at 06:27:00PM +0100, Anatoly Burakov wrote:
>> From: Shaiq Wani <shaiq.wani@intel.com>
>>
>> Packets dropped in the receive direction are counted as
>> "rx_unknown_protocol" (GLSWID_RUPP),these packets need to be added to the
>> "ipackets" and the GLV_GORCH/GLV_GORCL counters need to be added to
>> rx_bytes.
>>
> 
> I assume from the code below that for the latter change, we don't actually
> need to add them, but instead can just get them already included by reading
> a different stats source?

Correct, those statistics are not counted in the vsi stats but they are 
counted in the pf stats.

> 
>> Signed-off-by: Jeff Shaw <jeffrey.b.shaw@intel.com>
>> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   drivers/net/intel/ice/ice_ethdev.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
>> index 513777e372..0ebe58f858 100644
>> --- a/drivers/net/intel/ice/ice_ethdev.c
>> +++ b/drivers/net/intel/ice/ice_ethdev.c
>> @@ -6383,12 +6383,13 @@ ice_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
>>   
>>   	stats->ipackets = pf->main_vsi->eth_stats.rx_unicast +
>>   			  pf->main_vsi->eth_stats.rx_multicast +
>> +			  ns->eth.rx_unknown_protocol +
>>   			  pf->main_vsi->eth_stats.rx_broadcast -
>>   			  pf->main_vsi->eth_stats.rx_discards;
>>   	stats->opackets = ns->eth.tx_unicast +
>>   			  ns->eth.tx_multicast +
>>   			  ns->eth.tx_broadcast;
>> -	stats->ibytes   = pf->main_vsi->eth_stats.rx_bytes;
>> +	stats->ibytes   = ns->eth.rx_bytes;
>>   	stats->obytes   = ns->eth.tx_bytes;
>>   	stats->oerrors  = ns->eth.tx_errors +
>>   			  pf->main_vsi->eth_stats.tx_errors;
>> -- 
>> 2.47.3
>>

