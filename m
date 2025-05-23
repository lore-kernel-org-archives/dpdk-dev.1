Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A654C54ED0
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 11:16:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7763E4060F;
	Fri, 23 May 2025 13:16:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7ABCD400D7
 for <dev@dpdk.org>; Fri, 23 May 2025 13:16:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747999008; x=1779535008;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dkhT4IpaLXaJiI1sL1Y/djERm25VmMg/3td7jhvGKSU=;
 b=eV4TIOVXA+/hYNkUvU2ZrSDrVFC/1M0krTXghMX0BptD4yP+Cu/q0Vim
 /5mSgqiC+q0QRd8wNanbXlh5KgD9j09UOzxmgYfiFP4tX+Fvd/EuC48Xz
 Cbi7YtPNjMv0jTblcRv931rSb3v+pw0CmT/cRXQasAi6TvbMWR06eMNx2
 62QHttO6+MhhIDtu2hnXVA9HqGXxHz2i3bBqlVkPZ6FAskgub6MXtFxeQ
 oS010q3VYZHPCnD3nhECmccN356lxB4S9MV5qmr4Yu62tKvmAuMyjA5FN
 eFzSPx1mllGvABm07pOf1wGxAMV9mARIRYlxAQWrSEN/mAfZWgsuk2/zx g==;
X-CSE-ConnectionGUID: 6+bw/6SORECNrEwWoMJBwQ==
X-CSE-MsgGUID: yG9U9pysSkq0M5UtG8aTRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49170018"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="49170018"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2025 04:16:46 -0700
X-CSE-ConnectionGUID: XcZvuhhxQP6oA0fytCugUA==
X-CSE-MsgGUID: mroQ225eSnKCsTLqSoMpCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="171996752"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2025 04:16:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 04:16:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 04:16:46 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.65)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 04:16:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOKw/B4Y9qtTaQFO4lwl61cVvz8xQsP80/VpGqLcTPo1WCsomIJiFtgTsyz0sMlIMT89UA1iz9aAk00sTkugJjTP9Oh3JJw9yTARRXSi0x3qpbuSX+kNGsW+NpSZG21GT15vbWb3j2sYp1uJvZEwJdkajL3X7ql79ADQYbJtHJvgs2fQqAsFuNAiHXy81FU/s6l6XgL5jZua25x9CrC1DMi+ca7C+62DAQ5YZbyZVJTATYgBjF9kweh7KdPbQeaGaVfRW3MpLKQdKxYGpq20Ruqx49Jt9+lqNLrP3S/WnTjHQozlSo4fUxTcVcVgpUaUE6CrrMHSE5usEgc7OrsjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQ5WY77t20JlaP/RSWjGyLC9mR5PusK2w/xTVteI/9s=;
 b=eK5S23v5Vv5gg2XES6QZ8gls+784gaOj0dNjYfhrwVPCDN2CMtiYtTLYsdZnzdnBYgWfTEZonQ7KyRh+W14uhwpEQg5EXG5fR081A3hdSR7Z1TareYFIf5F8p1G5t3SN658cWmoxfdYPkSNL4N+JhxlEnXt1fGCoXsdmxgdufh1vnfPpnFGDNysLt2rw7V4P1V2xcHYdh+UnQYFyFh1Kk82ZCmXgm7LtmwWahgG/I3uVB8N5MWT7jB2zuwcLNRCq3jGU9OvVQRpRTr9irkMQfejiUSr6L2S3yNkMgMAAOCXe9laC5bp/lXsv2xcD3+kpgIB745bbJsBaL10DJQDWUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB8503.namprd11.prod.outlook.com (2603:10b6:510:30d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 11:16:42 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8722.031; Fri, 23 May 2025
 11:16:41 +0000
Message-ID: <3e018253-521b-4ba9-b03f-586915b401cd@intel.com>
Date: Fri, 23 May 2025 13:16:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] net/ice: use the common Rx queue structure
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
 <aed76e2a2c5c8be3ef968291db2720fc07eba633.1747054471.git.anatoly.burakov@intel.com>
 <aCTLW9HoAXOPd6Sg@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aCTLW9HoAXOPd6Sg@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::8) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH7PR11MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: b063c2b0-963f-48d4-afad-08dd99eb4b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L285NXVNY25wa2pzSFRwL3FnSExQM1ZsWGtjWHdQcXFiaGtZR1FudkZGcCty?=
 =?utf-8?B?bytwR1BYSUZVK1d4NCs1UkR2YTN2cExEWG9KMktSUWhxNWFTbjNoaSs4MXVF?=
 =?utf-8?B?MC8vc29IM2Q3ZWIremZscE1LUFBxN00vYytZZ1hFY2RINzBiMUlDbkNBUStO?=
 =?utf-8?B?aWQzMXlhcU5yM2xYa3ZtcVAwZmlSRTVqM3pKbUdObmVtN24yYWgyck9hc0ho?=
 =?utf-8?B?R1V5VUZZR2ZuTEVnY0pmSHlzbWoyaU1Mdk5VWkNqRGh2UDhEV1JtQkw5dzhk?=
 =?utf-8?B?a3B4R2ViK0w0MElwUGF3bHVxdGd0ZjVYK0JTL3dLSGFHTlNkQmM5QzJzN0d2?=
 =?utf-8?B?YjNubC9VTGYrazRGc2tuSWhWY0gwNHMzZDBKU3kzWXl6WW1pc1VScjhzWkYz?=
 =?utf-8?B?QjdWYWU4YWhtUHVCWk90eHRQRWY2WFhXQ2t6eWtjOHZZcXdtZTBUOU9iRHE4?=
 =?utf-8?B?L3o5ZVR3Q2VjUFdQTmJVVVB2c2F2SGIvcnRlQ2FIMDlrcnJ3MzhBM3RkTHQ3?=
 =?utf-8?B?VGhTNld3alpvWEp1NEN6ek5TU29NbzU4Qi9xeE92QUgwMHJQR0dSNFk3UVNs?=
 =?utf-8?B?TTA5Rm01empzazQrTHVSWW1VQ0I3dXBpUEtkbzRBN2pFWGtFRVJ4SGhueXYv?=
 =?utf-8?B?QkZ6dmZzRW01d3BZTjdtKzVpVVNGYlFnT05iK0UveDBhbm56RHBPWWJwV0hy?=
 =?utf-8?B?QWFlUHdUSWJ1cHhkQ0J3TTV0Y3FSYnJEZkVxem1pQXBXb1dic29SeSs3d3RS?=
 =?utf-8?B?cm9HOWIyRmlxb0g2N3Z0VmRoZWdFY3VuTHE2cUpaeVFZWnBuc0NGUVlXTG1G?=
 =?utf-8?B?M1JzaHdMSzhDZDJLUDRoSEcxdjFRSUlZN0JjUGFsUVYydENnR0ExNjVob2p2?=
 =?utf-8?B?M1hUU1QrbW5LeUFwWTkyNGVSeGN3VGN2VVR5WXdrSFQ2VkhPMkp6V0hhclJa?=
 =?utf-8?B?MkJtZ0FNWGNQRFFES1Y4dS9sYTNZR2U0cU1icmpqbGlYOHJ1WVZtSUpsNm5L?=
 =?utf-8?B?SnRQd0M2NWwyOVgzb2dUMTU1NWVvdmd2dHh4UlV2L040a0gwWkZ4SkMwRWxR?=
 =?utf-8?B?ektHcWoyZ2VsTjc3RlppaE05QTVtdkhlZ3Q3Y2NsNEdxWTMzV2xscERjU2la?=
 =?utf-8?B?RlNHZm43TVlyVnI1SElycDBmemMvKzJScjRLMnRNaWpWdGRMWXdPUVM5MUlr?=
 =?utf-8?B?ZENMc2pRVklVUERaSXF5YkE0WXZvYlIrVjlIcU40eDJVUW1wdkJKY3R0dTV5?=
 =?utf-8?B?cUZsdTdHREZ2R3MrQTlLTHJUZnVKVEVRZm1pQ3NRd29lRXJSYXJYcUxvSmg3?=
 =?utf-8?B?NFhCSHNwZG42ZkxiKzdyNFFYZEkvZlM5dkxsUzZzQzk1MDdOZ2txZnZmSitK?=
 =?utf-8?B?ZkhJYUVzNXVNUEpIblN2U0tHWE1FT2RPSWpDTWtpb2Z3cXZvWkprdzJUUzU4?=
 =?utf-8?B?NnNtOEFZd3Q0SmlGNkYvZ21Da2U0VWRiVjE3dURHdnFZME4zckdJeFhjNkFs?=
 =?utf-8?B?cVVRVnhDSzkvUUliZHI5NkZ6ZkxTbW5ybVBobzFCSFJoQUVISlUvZ2MzT2U2?=
 =?utf-8?B?UXI4Nm5YVURaY3JpcWk4bUR3NnFEa3BNSzZnMHd4dk9nc3c1UkRac05vOHIy?=
 =?utf-8?B?d0pHN1JGcU1QaFlYL2N3Rm1aTWFVdjd2ODEzQWNDb29MU2JtRjdic254UTc5?=
 =?utf-8?B?b3l1YTZlSjBnSW5iQlZkMWE2NXk0SVQxTU11MEZUOFh1TXpaN2Q0MEpyYUVX?=
 =?utf-8?B?emxhMndGVFJuQzE4VUpuQVB0TVhLeC9PbEdIZGk3akN3dXVZSko0NFp3TjVt?=
 =?utf-8?B?TFpEaEhYak0vY1ZTellndXBGZ0hHWXorVmJreERnZDcrSW1QeXVNNzFFR1ht?=
 =?utf-8?B?R0tFNFVOMWRUTHZXazg0UlRGa2R6Ym8rM25hSDA5d0crb2NaaUV4TUUrc0o0?=
 =?utf-8?Q?OTO/YZ6WXq4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlhRd3B3azZ6OEk3ZEVhcm8rWGo0bDlwSVY3NDNBUEF3RE1wWUcwTC9TUUxs?=
 =?utf-8?B?RzRZRTBFeG9QZkx1ekRNbFJUMFpuK04ycHhmaWYySklTZ2gwQnRVdWFBTTN1?=
 =?utf-8?B?SmVSTXlTSm9jdE5OcmJJZUw1cnk0akZRck5uRTBxWllwRi9nbDBoTDNVM2hH?=
 =?utf-8?B?VENNNlhFZ3g3bkdwZk5mZUlvdEhzWHZCdUMxbjdKOWo3Sjc4TkxqWWZqcFZs?=
 =?utf-8?B?bDFEbUhsVy8rMFNvTWtyTnBzUmY3V1lkOWRUVUc0NVhuWDhleFp1Ni82RVNk?=
 =?utf-8?B?YUFtMnBtRzVHLzdqMFlVMGRpUnNqZDMreHVYUWR5K2h1Y3FTUWlCOVJtY2k4?=
 =?utf-8?B?d3NDREdPSG81MEVEU3hQWGtiSk9xcE02cmFoWkNFL0lFZkYyNWcyNkFjaUI4?=
 =?utf-8?B?bVB3bytJUjQ2RGQwRTJDZ3BIclJoNmFXL3hseWo0NUtJVWxPR1l1T2Qyck9k?=
 =?utf-8?B?UzBLL1g1S1VobktrNEk4UCtVaUQrT2ZnaVBVUWZsTXJQaHhNMGNHWkdmSjJP?=
 =?utf-8?B?TldKU25mTUl5WERVazZpMGR0U3Y5N1pNNlF1ekZoei9SdlFtZVRnY3dTTVBQ?=
 =?utf-8?B?SWhmREtveWR6MnpJS05NWEVzaDVRS2JidzVGZVBFL3E3L08vdlFySTViM1FE?=
 =?utf-8?B?L3BJSUg0RTdWaitkY3FtZDV4elcvU2VSUjdKRkY2Q1AwQ285bUtNVUVPMWl6?=
 =?utf-8?B?c3lUWlBBK2plUDQvQmczOGptUUxtejJHU21VMGdHY09SZk1ZcmhWMVBCcTBL?=
 =?utf-8?B?bFNrZjNReS9iZTFkMW5xZlExb2ZiL2R1ME5RVGtSd3BDbWpXTEtzanQ1QjR2?=
 =?utf-8?B?YUF5WXJVSTNWVmpKNkpqczc5V0RVR2RITHB1UjRuWjVvN3pNdUpTbkZsMGpD?=
 =?utf-8?B?RnNERWVkWWxMWFBHUEdKUTM3bTR0NndQNDNUUHZXU2IzQzlGQW5vOTRSZm9j?=
 =?utf-8?B?TmEra3lHLyttSWlsZm9OSmxKMnZYNU9iQ1ErTzUyWXN2UDNteDkwZlQzZXAz?=
 =?utf-8?B?aFltT1RaN2dsQlhmdGwyYUJhc3VZejlhUHkrckZwRDZ1YWJiUUZqNENoejl0?=
 =?utf-8?B?NmNXcUlpMkQzeFI2ejJSbEFVamRCUU9Ta0NSTGpZUkcxdTBranllcW5ySTFG?=
 =?utf-8?B?cVc4VTZNdFJseGZxVjBiaEQ4REpUK0RyZXlMalVNVXQ5bG9BNmhOSW5pT2k0?=
 =?utf-8?B?THRVbzVYZXhjNXIwM05PK2pqS3RYOEJIZFo5bUtwNitwTHZTMXhBZk5XWGJH?=
 =?utf-8?B?MjVGQVQwT3NFRnRFOStvNGJWMjQvamdMNG1DalhEeVAwNnRNUnBPVEUxd2l0?=
 =?utf-8?B?V05CaDJyb2ExYUoxQUR4NFIxbHRveDRyRFl2U3lMM29GdGRGMk1jcXRCamJS?=
 =?utf-8?B?bEpGZ0xEaGZFWVNXNjVwSHFEWmRWVVB3ZG91NkthdS9SWW9YM3FUSDgwQ0Z0?=
 =?utf-8?B?QUZwUWxDS2FaYVhMQlVRYjNpNG95OHJiRmdPdmdKOFdjR05oNnpqM3gzS3Qr?=
 =?utf-8?B?OUx0dHk4bi95QWJhZ2RvVVJaeEFRdEhNR0VJaGJyWFF1OGNtc1BDZkY1dmp2?=
 =?utf-8?B?eTMvSkFvOHdBTnZXUVh6cDhIOG9NNFprM1UvZlI0bDVTbkxlL1RzK1dFalZD?=
 =?utf-8?B?blAxYUlxOWVsZ0JpbHpCemtKWi9wdGtMRWpWdmF6YUFJa1d6RU1PWTVPOE1M?=
 =?utf-8?B?b2xFSDREeFpRSmd3bDZlVHpOVGtiZW51d2lNRDkwdGxFMHZ2NWU5MW5CWjY0?=
 =?utf-8?B?S0Z1bVNWdWVmUWlkSWd6aWd0Sm12cGxvMWpkQlBEY01lMVE0dzMxRjN2ZkZK?=
 =?utf-8?B?MTROMkkzVXNxYXp0Z3lWU3ZtTW5LN3ZuL2RWYUtTcEdCSTUxczcwcG80amlR?=
 =?utf-8?B?QmV6RVYzRTVjTk41dU1odkFVdm0vNGx3UU1xU1duak9ZUmVEU1VJTWlJRVJ0?=
 =?utf-8?B?ZUgxaFB0blRidFRpYVNJcEhlaWQ5N0IzMm1aaENjNmFGSldiU2ZjUjZZZXJH?=
 =?utf-8?B?dGtlN2p1aHl4dVdOQXdQWG9ncW0zMWNTZk9MQkIvb3M2bEF6L2w3bkFQem11?=
 =?utf-8?B?QjZpdVdrMk13K2wzZklLUDZaY0w5NlVzaWx6V0o5bno3M3hLWE1GUGh2cTA2?=
 =?utf-8?B?b2IyQTF2bVhiU1JuaDY4NGt2bUJ3ZFNsYU1KUzJSb1ppbVBtTVZmbmRDcmVX?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b063c2b0-963f-48d4-afad-08dd99eb4b51
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 11:16:41.9297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJRb6tJ28tholPf8TJmhlGl55z6jYP+BI+GwVu+rViLTsyhbryb1wQTy4sysmkDi9V6xEpfQplPCTJaoc6yZVcxdZ/6JxDLiozxdZSVS9GA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8503
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

On 5/14/2025 6:56 PM, Bruce Richardson wrote:
> On Mon, May 12, 2025 at 01:54:31PM +0100, Anatoly Burakov wrote:
>> Make the ice driver use the new common Rx queue structure.
>>
>> Because the ice driver supports both 16-byte and 32-byte descriptor
>> formats (controlled by RTE_LIBRTE_ICE_16BYTE_RX_DESC define), the common
>> queue structure has to take that into account, so the ring queue
>> structure will have both, while the actual descriptor format is picked by
>> ice at compile time using the above macro. Direct usage of Rx queue
>> structure is now meant to be replaced with a macro access that takes
>> descriptor size into account.
> 
> I'd have the same comment as on the previous patch. I think it would be
> better to not have to use a macro at each reference, but have the struct
> type aliased as is done now.
> 
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>
>> Notes:
>>      v2:
>>      - Make xtr_field_offs of type ptrdiff_t instead of off_t to fix 32-bit compile
>>        issues
>>
>>   drivers/net/intel/common/rx.h               |  23 +++
>>   drivers/net/intel/ice/ice_dcf.c             |   6 +-
>>   drivers/net/intel/ice/ice_dcf_ethdev.c      |  22 +--
>>   drivers/net/intel/ice/ice_ethdev.c          |   2 +-
>>   drivers/net/intel/ice/ice_ethdev.h          |   5 +-
>>   drivers/net/intel/ice/ice_rxtx.c            | 158 ++++++++++----------
>>   drivers/net/intel/ice/ice_rxtx.h            |  78 ++--------
>>   drivers/net/intel/ice/ice_rxtx_common_avx.h |   6 +-
>>   drivers/net/intel/ice/ice_rxtx_vec_avx2.c   |  14 +-
>>   drivers/net/intel/ice/ice_rxtx_vec_avx512.c |  16 +-
>>   drivers/net/intel/ice/ice_rxtx_vec_common.h |   6 +-
>>   drivers/net/intel/ice/ice_rxtx_vec_sse.c    |  22 +--
>>   12 files changed, 164 insertions(+), 194 deletions(-)
>>
>> diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
>> index db49db57d0..9a691971bc 100644
>> --- a/drivers/net/intel/common/rx.h
>> +++ b/drivers/net/intel/common/rx.h
>> @@ -5,6 +5,7 @@
>>   #ifndef _COMMON_INTEL_RX_H_
>>   #define _COMMON_INTEL_RX_H_
>>   
>> +#include <stddef.h>
>>   #include <stdint.h>
>>   #include <unistd.h>
>>   #include <rte_mbuf.h>
>> @@ -12,6 +13,7 @@
>>   
>>   #define CI_RX_BURST 32
>>   #define CI_RX_MAX_BURST 32
>> +#define CI_RX_MAX_NSEG 2
>>   
>>   struct ci_rx_queue;
>>   
>> @@ -23,6 +25,8 @@ struct ci_rx_entry_sc {
>>   	struct rte_mbuf *fbuf; /* First segment of the fragmented packet.*/
>>   };
>>   
>> +typedef void (*ci_rx_release_mbufs_t)(struct ci_rx_queue *rxq);
>> +
>>   /**
>>    * Structure associated with each RX queue.
>>    */
>> @@ -32,6 +36,8 @@ struct ci_rx_queue {
>>   		volatile union ixgbe_adv_rx_desc *ixgbe_rx_ring;
>>   		volatile union i40e_16byte_rx_desc *i40e_rx_16b_ring;
>>   		volatile union i40e_32byte_rx_desc *i40e_rx_32b_ring;
>> +		volatile union ice_16b_rx_flex_desc *ice_rx_16b_ring;
>> +		volatile union ice_32b_rx_flex_desc *ice_rx_32b_ring;
>>   	};
>>   	volatile uint8_t *qrx_tail;   /**< register address of tail */
>>   	struct ci_rx_entry *sw_ring; /**< address of RX software ring. */
>> @@ -64,10 +70,16 @@ struct ci_rx_queue {
>>   	bool drop_en;  /**< if 1, drop packets if no descriptors are available. */
>>   	uint64_t mbuf_initializer; /**< value to init mbufs */
>>   	uint64_t offloads; /**< Rx offloads with RTE_ETH_RX_OFFLOAD_* */
>> +	uint32_t rxdid; /**< RX descriptor format ID. */
>> +	uint32_t proto_xtr; /* protocol extraction type */
>> +	uint64_t xtr_ol_flag; /* flexible descriptor metadata extraction offload flag */
>> +	ptrdiff_t xtr_field_offs; /* Protocol extraction matedata offset*/
>> +	uint64_t hw_time_update; /**< Last time HW timestamp was updated */
> 
> Just to confirm - these are not in the ice-specific section because they
> are also used by iavf?

Yes, it is for that reason. Any fields moved to common parts are present 
in multiple drivers. There will be some instances where driver specific 
fields do the same things slightly differently (prime example is 
timestamping support), this can be future work.

-- 
Thanks,
Anatoly
