Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E04DE94623
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 23:19:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E6684027F;
	Tue, 10 Feb 2026 00:19:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 93DF6400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 00:19:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770679147; x=1802215147;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=0nT8oCCHixvmxfWe4/+0O/O/kfjIkiYmkc8sMsUfyCY=;
 b=BPP2sKJCalCAIOZeu/dfabOnqPJbcKsWFFQA1drqfOD5JFTEcT/eGKMV
 VywReT27Gm0lkxgRY2U0+3hPKgwpXmntx4oL9z319sVWZn7bV4855OVTn
 ZU/fuSkQBfWdtR8SRVxb3rMzC+rP1PnUSERxLbJWuejLAtDiGg2mHPTg+
 R6AMYDu+O4LlfvAkp7O2q3n3IMImUoUYdUXoej5OrWT1mQKgr9EBe5HqQ
 efqGeT4glNgucgmEUDVlG8zoeIyTR/NInMIO6qPQa8b4tPWElfdkNW0qP
 KCaPeQwwXL1/UiOo21Hy67oHVSUg3GRNyaX/fw3tx/IbZ5/sVvDGzRMkQ w==;
X-CSE-ConnectionGUID: l+hl6RZeTz6PNUX6N6tTlA==
X-CSE-MsgGUID: +EuNdJztRTiSGPpTni0Xgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71840300"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208,217";a="71840300"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 15:19:06 -0800
X-CSE-ConnectionGUID: Jv5BYGr2QCOnvC6NKfT4gw==
X-CSE-MsgGUID: 7AwL1OyjTWGoLwtuCQV6QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
 d="scan'208,217";a="211749754"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 15:19:06 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 15:19:05 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 15:19:05 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 15:19:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBUJoyv2HTF3dxPTRUoUTeItKj/LIx8r5qt98+HiAQiXzBHm8ff2czG/+2DoFhjnh0x0R1jIbZtH4zT2PmruwRyvtKWjhyu5l9jgCF79gbR+EW4XtOJqPm9dUbQgKbeqqKT2IFwz/0XU0f0x08U0Abpy7iq2mqai1tIcbbuKnl5DhVywk6ph02aeQH1fn5Tb8wkDyLTWTf5Ck1W8BJyUG+U/jkUnItvI++QvMc/dIfEPKzj9Gm3ETMgoDI5PEmyITUslTrJUDIcg1xxbe7FKatopuyqwZ7menpMbEOdTJsk3bgcbXQUdixkSuq7oMk1HFd8FWp6WF98w+9unKJ/IdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mALhLzuk38xar8uL8krHkn1fNQp6YQhRYs2QGXZV7dU=;
 b=qNx4TTVQfjkxqoW5dClATyooGsSbKHaA7XuCmdq+27SzqB1ZLNEl0e3EsfBkfL5uwLONGVbwFaxCrxe/bQZ4xLCSI+bm189bQYm7ecGaTPPjXyLpp9ThGFsUklelkFE0g/bDembG8GVMSH6nuHmlQDjqL4BdxsfOG39CuRS2X+Uo2qQziJtSQE2Vc4IOEftuv8VOtiwtTed1QGM+zTpnU8VSJMVL6Wv8J32EcfHbC5cUIK6I2LNH5uyhnEhtFtRnSjn8OfTPyMDNKzChCYnyH3+x+I5Jo114GrCA7rz2R9PNdo/qZkbvYUNLqGJyd6S5+k+zvyk2bQjr+MeBFpXnWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by CO1PR11MB4898.namprd11.prod.outlook.com (2603:10b6:303:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 23:19:02 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Mon, 9 Feb 2026
 23:19:02 +0000
Content-Type: multipart/alternative;
 boundary="------------jbkwroUwnYJNufC6wFOnnmcQ"
Message-ID: <684329d1-3da1-4871-aa02-0a4b5a1e9c28@intel.com>
Date: Mon, 9 Feb 2026 23:18:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 28/35] net/intel: merge ring writes in simple Tx for
 ice and i40e
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Anatoly Burakov <anatoly.burakov@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-29-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260209164538.1428499-29-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:10:234::28) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|CO1PR11MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: ca910a90-d907-47f1-a023-08de68319c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wm0ybE1aUllCUytvZlFHeGJmQ0dwQmQwUmRlOTR3MkhMTDlPbjJ3bXZzUVRD?=
 =?utf-8?B?ditFdnJpMGhZQ1kxbU1mdDlvZjIzb2t0eG5lSnlSeHVWSDZvb0YxcDFWTzhu?=
 =?utf-8?B?bGV6bHc3SXVKTnhOS21JVU9rbHdubkVQeWQ0Y1d0SWFIVi9HU2pTK0lvcjRw?=
 =?utf-8?B?dmpGOFlCOFMvcmxrYWN1ZUpMR3pPWGVvSk1PV0hVdnR2UGdVRmhuYm5IVzRl?=
 =?utf-8?B?Q3BDMG0xZnkzT0JPZ0dBV1pQc01yUE16SCtkMld2bE1PRyt4UEUxTDRnemVQ?=
 =?utf-8?B?WndXN3BPdEJvcHNxdjgrL0pjOTZtNXZaQWVTLzZYbS9zakVEVWFVUjBJWHQw?=
 =?utf-8?B?cWpGNk1oaW1weHVyeWtQZ0VJWlhNdlBNZ3F2UlA0TDF3akZMU0daNElqWDNh?=
 =?utf-8?B?Wks1QytDOVF5bWF5UEw2elRBaTJ2ZVZrVnR3aHdjWjZsenVvUkFSb2NWU2U0?=
 =?utf-8?B?WXlwVzZCbTFXbHdhM1c2dytReW9Rc0FrNHE4MTRsY0M5YTdBYjhMUldGalQ3?=
 =?utf-8?B?RFVhbWMycFU5U1dxakxDd25EdWsrSFloNDFzL0V6MlB2UnNCK2pPVmlqQXlC?=
 =?utf-8?B?dkI3Y2hYZDJGZVYveVZCTC82NWJSMXVqTjM5YU5XbGlFUVJSSlZwUXNwaStm?=
 =?utf-8?B?ME9DQzgvOXZnUCtBcHZ5eDVvUmR4Mnc4Ukhvc0U3cTJJd2piaW9jNDlXVjRT?=
 =?utf-8?B?cTVSUTlvbzhNbE9sUTdaeHNGSkY0aWdaM0pLWEdsTlgxemNzZmw1UnRsY0E4?=
 =?utf-8?B?MG91K1A2RG54TjhydEt4OWk2MkxlSzlSbSt6Y0ppNVN0MThnTFZmWDBIR1Fh?=
 =?utf-8?B?cTFaMFVZNm8zamNhUXZwRlRVUHVjTlN5OW9iS3FIR09nVE9wZ0xFLzVwNlNz?=
 =?utf-8?B?S0doQ2ZRdE9TdlYweVVUWjZpVlNsNVlsS1pZNnNnZTZnbEhQaWVtMEhKa2xq?=
 =?utf-8?B?VUZvMmVjOTdjVnpiWDhUdWd4NSs1ZUVYR1VDUmowVm9JSlBLTklPbmwreXZs?=
 =?utf-8?B?K2RKU3o2UTBybk1naVB6V2p2czFxZ0YrQ2pndzR6andDaTdOT0pSUlRUQnVw?=
 =?utf-8?B?ZFVkY3Q5V0tvZHEyR1lwa0RPVXRYZ2NYK09ha0VEQXNqL2ZWVFNLRWhORzhL?=
 =?utf-8?B?a3lUMGtiR0pha2pZK3M3dUJIam5sSytEME95TE5XeEcydzVrazQrNzZDdmxG?=
 =?utf-8?B?VzhGdHlZNmdmdTFkdGxSeldiNndYQzR2WW52VElWL0ROQk1OZXVUekd0K0wx?=
 =?utf-8?B?R0xac1E0YjlVOTV3UHFrRTFyM1VUZlo4OU5YSWM5MnNKdDhFOEc0OXhiRHBT?=
 =?utf-8?B?SEJQam9PSHluOUtieXk3SkhFV1ZuME9NWDVMNjY3NEk2NmRoRDZxcWNJVDZ4?=
 =?utf-8?B?S1UrMG1nZ0pmYmdqRUM1STdIVlEvcXQxdEo2VmhmRU9VQXJYNjN6cEM5Q0h2?=
 =?utf-8?B?YlZnL3BQdVZ1ZSsxU3J6Rys3UmYyQUJjVi83aXY1ZmRGQ2tLTmVtMXo1UkhH?=
 =?utf-8?B?RStCSjBsOFhrN0hJelVkc2RNUERZb1J0VGh1dUdsK3hFU1JMcmdVTUoyRTI1?=
 =?utf-8?B?L1U5ZVRkWjlJWENndkZMMXdHanFMY0Z0M1pLbjhQdU5pVWFSNHJpVXJZa08x?=
 =?utf-8?B?RTN0dmVuSXFMeTFzTWZ5dTVyM3NzTkMwNldZRzhxdVNjU1gvTllhdG0xRWFs?=
 =?utf-8?B?a2tPc1ZudDU1Q3pLMTBuYnYyZnBxcXFSM29NeTVKRVkyclBPMzd6K29mWUtD?=
 =?utf-8?B?UHpHY2pwNlNmbGd6S0xZcVBPN3AzKzBKR2M1dWRQeGNNSnZlNEVKNXRwcE91?=
 =?utf-8?B?ckFGRFhKc3UrcUFESU44ZDdja21waHlqT3duMGdrK0UwMk9SVHZ2TFY5OEha?=
 =?utf-8?B?YkVGaEpIQ214dkJjV29sNXJ0dkxaelZTdk8vV01iRTFJdnJGeFMzSmdXNmVT?=
 =?utf-8?B?dnNPTm4vT0VzOC9RQk9qTHVleUlGMU1obXU4TWoraUxIbVQ1dVMwZUFkR1pW?=
 =?utf-8?B?Sm1kdDlWbUdESExrVStJbTN1amdRMktYdjJJOUtSZXZFUHh3WFZqUEtqNTFj?=
 =?utf-8?B?c1JEL3dRZVRSN2x4YmhhWFNsektkMVB0Rk9Sa3Y4Y29xditlR3VuczdwNnds?=
 =?utf-8?Q?snuM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDRVeGV5NEdrM3BGQVk2dENNbnNFVXdFRE9UT3hFR3BqQTh6L2oydHBGdGMv?=
 =?utf-8?B?VVdPR0RZQ3pOME5MZVVBdEdaL1JuSU1zem5KMGg0NGNza3Y4ODZGckdTYW1Q?=
 =?utf-8?B?OWlwUWt3RGdSODRrcnlRZm5NRE81L0xrNDlsYVhFL1Y2cVc4T000aGgxU0tp?=
 =?utf-8?B?aFJHT1QrUFVqV1EvdnByc0dIMGhIY0F5Mm9rYWJvd0ppRk9XU1g0SmhZbGsv?=
 =?utf-8?B?WHV2anA5cDhvK1NFQjFCYkZjMlR0QUtjNk15TkkvREczOXpjdk1OT25MOVdt?=
 =?utf-8?B?dzNJUXJ3WERIR2Z6b3hMcTBDVzliUEQvc2I2aDhZUndNd2pjSHlqWEE3Z3lm?=
 =?utf-8?B?V0RSUlZ1NTZCNEJuSUlhRDByOEwzeWNWWUlTcE94QW8vUnVZZm9WZzNtZkJn?=
 =?utf-8?B?TVNFcWVPSkh0UmxkZWhuaHlNYUF2UGkwbUx6VUllVWRwcjV1RTJtZkpqaC9X?=
 =?utf-8?B?clJpbzBDY2dhMitoYXkzMmVsckZlc3ZsVkF0NVl1NzI3Ulk0RXp4T2hzZm9L?=
 =?utf-8?B?TExsQWw1bWN2NDN5OW81aWRwSlUvUVNYZjlGMlh6c0J3Sm5pdnZVcHhBL3NR?=
 =?utf-8?B?NTJJUmpEWUJNUTNyYnAvYk91bWE3R0hnV2RKTjVST0ZmMzM2bUJzRDcwaUFP?=
 =?utf-8?B?N0VHUG1hNCtvR0RwckYzcmxCMjJSTDJ0OHB6clFUOERxb0RETzRsVXlNQ2xz?=
 =?utf-8?B?TFVXNGluaWkxWGQ3UGFjZEFYUG96NmlDb2M4R2xOZkFLUXRPUjdYRkxNQWlJ?=
 =?utf-8?B?Ni9CNFdRODUyeTgzcFM5a2FsTktTSDFJL2FRaXA2WVQwNHJDWXpxdVZDOHZ1?=
 =?utf-8?B?ZG0yVitMZ1E1bUV2bk81TDhpWElHdGNXWW9ERGJLb1JlSzRBY3VKdmVPbzFY?=
 =?utf-8?B?REZjVGNValNyZmZMOTlsR1Fqczg3a2NWSG41QUdBMDd2MVo5N21lbmdhUkdC?=
 =?utf-8?B?UDFwOE9pdVJjZWl2dksyKzBaaXZCTStHdUtmTk1QVzN3ejZPRVZReldmbXJv?=
 =?utf-8?B?eGl6aTBRN2dPS1dmNEpsWnFlcTZpbXZEQzFBTWhEVlVqUk81NnFoQVRNWkdK?=
 =?utf-8?B?SXR6M1RPbHkxcHlMdG13blBDaW9NV0lhaDUraXpjMkVaQ0xCaWp1eU1HZEFT?=
 =?utf-8?B?cmkzQTIrdWU0R3dDeGlVc296L0pqZURZVTVmYjJKR21GNUJONzFIdXVwOGtR?=
 =?utf-8?B?d1JGb1NlQlAzSDZtbmZLY1hFcjdsYVR1RzJhVmd2QXhjSXAzMXVhb2xyUFFK?=
 =?utf-8?B?VDYvcktiamtQdVJFSXpNRVpUZXNLcGxwOU5pVWdNdW9ObWRhSHUrQUpFOG9p?=
 =?utf-8?B?THZxb1JPcHUvY0N3TVF1SzJENEhVek9oSUsvcEp4RzBQeTRPRW5haXJtcjR3?=
 =?utf-8?B?bEdyUkRLTU9aK3c5T1BhZ1VyT3RGdkkxZUg4N3ZXTFpCblFyRktOejgvSytp?=
 =?utf-8?B?R2NmT2ErVDVOMGIxUjVuOS9RbFBCWFZ5TUZxby85WTFpUUFiWG9JRzllWTNV?=
 =?utf-8?B?Y0ExdEkvcVZlT2RBcndUM2RVQ3VvOWY2VW13NFFRZWdXVXhrWWh6Y1E3b0o3?=
 =?utf-8?B?YlEycjQvalJsZU5BaEY3TnhVaDdtYkovckJMZjVPTVVEak1USVBpREIvWjFH?=
 =?utf-8?B?K09XR1pRN3BkMEthMUpORGp0a2dzUHdGYTUwZGxxbkRiUlRsY3JOZ3kvYXky?=
 =?utf-8?B?cWc4WGtXQ3Y5L25wcTRMeXVOS24wWG5UVlJuUDBGa2hxUHhWcXdKcEt0TXVK?=
 =?utf-8?B?eWFTdjlxaUZzZndaK0xDUVQxbmk0RlBZdzNUaWJSbEl2MW9zYW9FcU1ucXBO?=
 =?utf-8?B?QVhscUFXMXplNTdPN1NxZjByMG9WczNLa1d4UEtqQjN1endjbEptd21VTWQw?=
 =?utf-8?B?NWtnYktCS1ZnOVcxc0FDU3hhUVBuSUQzZUJ1ZSt1MEpmMjJFS2xZekJ1eEEx?=
 =?utf-8?B?aWFsc1RrTFZXc054NlZxUDhYakNhWko1ZkpNbGh4Vi9WbHpkNEtPeWJKeEl4?=
 =?utf-8?B?UHVoNkI5dStVK0plbXNrR3BwRnFUQVFLdUJCSXE1QVlRajlyQWltbkVueHN4?=
 =?utf-8?B?dHRqWVlqalA3bklTbjZUZUw2dnptVlR1NW1CVGdRaGZGWmpkODg1eE5zWlJL?=
 =?utf-8?B?Yk9BNGlvODlYUms2SWZlajJJMFJob3RCMzJ6ODYyOE5Pd3grKzlwcTN1WXNl?=
 =?utf-8?B?ZkF3QzFHMVZkNmgvTEtyMTJGa3dRY1MzWld3UGNudCsyTVAzOGd5OEgzSS9C?=
 =?utf-8?B?MStEKzZwMW1qNWZ0Z09iaUVhbWt5akt5UFIrYnUyYlJibGpmSHdrOEpMMEdN?=
 =?utf-8?B?NllhdmtiZ0FuajFGZmYvUDIxRkQ3elhvenludW14d00yMWd4bXAwam9mU0l2?=
 =?utf-8?Q?13ysRM8UBict/Mg8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca910a90-d907-47f1-a023-08de68319c8c
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 23:19:02.3856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ni8nIA1X0uU9dh3JNNrM+0rueBA2KLb6J1FMBzMzneJi50723BeLAUpJ0fxMXaTVOzZQ+nNw4x9iTcgrNA3lL+ZGS0uSJZnlpjeN0ZayuWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4898
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

--------------jbkwroUwnYJNufC6wFOnnmcQ
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 2/9/2026 4:45 PM, Bruce Richardson wrote:
> The ice and i40e drivers have identical code for writing ring entries in
> the simple Tx path, so merge in the descriptor writing code.
>
> Signed-off-by: Bruce Richardson<bruce.richardson@intel.com>
> ---
>   drivers/net/intel/common/tx.h                 |  6 ++
>   drivers/net/intel/common/tx_scalar.h          | 60 ++++++++++++++
>   drivers/net/intel/i40e/i40e_rxtx.c            | 79 +------------------
>   drivers/net/intel/i40e/i40e_rxtx.h            |  3 -
>   .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |  4 +-
>   drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  4 +-
>   drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  4 +-
>   drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  4 +-
>   drivers/net/intel/ice/ice_rxtx.c              | 69 +---------------
>   drivers/net/intel/ice/ice_rxtx.h              |  2 -
>   drivers/net/intel/ice/ice_rxtx_vec_avx2.c     |  4 +-
>   drivers/net/intel/ice/ice_rxtx_vec_avx512.c   |  4 +-
>   12 files changed, 86 insertions(+), 157 deletions(-)
>
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index 203938180b..ef6d543e7a 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -63,6 +63,12 @@ enum ci_tx_l2tag1_field {
>   /* Common maximum data per TX descriptor */
>   #define CI_MAX_DATA_PER_TXD     (CI_TXD_QW1_TX_BUF_SZ_M >> CI_TXD_QW1_TX_BUF_SZ_S)
>   
> +/* Common TX maximum burst size for chunked transmission in simple paths */
> +#define CI_TX_MAX_BURST 32
eventually it would be good to replace all the rest {IXGBE, I40E, ICE, 
IDPF_VPMD}_TX_MAX_BURST with this
<snip>
>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

-- 
Regards,
Vladimir

--------------jbkwroUwnYJNufC6wFOnnmcQ
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2/9/2026 4:45 PM, Bruce Richardson
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260209164538.1428499-29-bruce.richardson@intel.com">
      <pre wrap="" class="moz-quote-pre">The ice and i40e drivers have identical code for writing ring entries in
the simple Tx path, so merge in the descriptor writing code.

Signed-off-by: Bruce Richardson <a class="moz-txt-link-rfc2396E" href="mailto:bruce.richardson@intel.com">&lt;bruce.richardson@intel.com&gt;</a>
---
 drivers/net/intel/common/tx.h                 |  6 ++
 drivers/net/intel/common/tx_scalar.h          | 60 ++++++++++++++
 drivers/net/intel/i40e/i40e_rxtx.c            | 79 +------------------
 drivers/net/intel/i40e/i40e_rxtx.h            |  3 -
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |  4 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  4 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  4 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  4 +-
 drivers/net/intel/ice/ice_rxtx.c              | 69 +---------------
 drivers/net/intel/ice/ice_rxtx.h              |  2 -
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c     |  4 +-
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c   |  4 +-
 12 files changed, 86 insertions(+), 157 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 203938180b..ef6d543e7a 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -63,6 +63,12 @@ enum ci_tx_l2tag1_field {
 /* Common maximum data per TX descriptor */
 #define CI_MAX_DATA_PER_TXD     (CI_TXD_QW1_TX_BUF_SZ_M &gt;&gt; CI_TXD_QW1_TX_BUF_SZ_S)
 
+/* Common TX maximum burst size for chunked transmission in simple paths */
+#define CI_TX_MAX_BURST 32</pre>
    </blockquote>
    eventually it would be good to replace all the rest {IXGBE, I40E,
    ICE, IDPF_VPMD}<span style="white-space: pre-wrap">_TX_MAX_BURST</span>&nbsp;with
    this
    <blockquote type="cite" cite="mid:20260209164538.1428499-29-bruce.richardson@intel.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
    &lt;snip&gt;<br>
    <blockquote type="cite" cite="mid:20260209164538.1428499-29-bruce.richardson@intel.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
    </blockquote>
    Acked-by: Vladimir Medvedkin <a class="moz-txt-link-rfc2396E" href="mailto:vladimir.medvedkin@intel.com">&lt;vladimir.medvedkin@intel.com&gt;</a>
    <blockquote type="cite" cite="mid:20260209164538.1428499-29-bruce.richardson@intel.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
    <pre class="moz-signature" cols="72">-- 
Regards,
Vladimir</pre>
  </body>
</html>

--------------jbkwroUwnYJNufC6wFOnnmcQ--
