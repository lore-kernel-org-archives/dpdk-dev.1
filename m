Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC41AC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 11:16:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DAF5402DC;
	Thu, 15 May 2025 13:16:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id EAE7E40289
 for <dev@dpdk.org>; Thu, 15 May 2025 13:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747307766; x=1778843766;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gc6IT28H9MG5/Yf/mxnzKdrQVA+xkco+IWZ8X/0YkQU=;
 b=fC0W2nwGqWKeFpg6t3fvb8AMojtcASUarLGokVKLM3QGFmYpSctnDbaK
 SDRhBnIdM28rNHXTtJrQ5QKESzdqDSYC1mtCWCxVUKmD0HVIDxJd73F54
 DOHlSZ57hooitg758Cme6jjNLM5rS2X3eQCb1IZTOk4rylIRH4+VNd3o4
 Noi8uElqA3ngMwFRQroL28TKndi7pMLDxITTDR4cjZ74mPCsLGUymGQjd
 5OLduuPMwBDfuEbUsXOX1rKYaH57Dh4IsyKBOALiHbQw3MpTbQE4AOFz8
 JSzdR5OM/YtR7nNBe70qM4gqr84TW3T1a/XXijQilr8JgoCFUJ3M4aT5B w==;
X-CSE-ConnectionGUID: KtWWdCCFQpm4+mODMYGfQw==
X-CSE-MsgGUID: MxGNDi4xQn22R5ocoYSxgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="60574459"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="60574459"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 04:16:05 -0700
X-CSE-ConnectionGUID: gamZRfz1TOS5giUKaIPiCA==
X-CSE-MsgGUID: jYZETk3CRdyWFiuNnhDKtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="169273095"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 04:16:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 04:16:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 04:16:04 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 04:16:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPNt8TdM5XOeHSeIF1ut9oLD7rE3Z21yLt/4MCtwWVl2PdVLLiL+zDtjh9zIoJU1HQzITZnimRU1d3FbMBbTdecWv9jNZtrAjE5Wc0j054pRONNVvqsQ+YjI53XQp3wq1FFkEhD8zDvpRIBUyMZJJnXrdpyg2wjQ4yTI0YIPT7U6C0QV6GkgSQJY+m6D2jp1tg4dg7U8K2x/XBpqSBalK5PcreKZdq8gBlnPsDVDJlnePqplr4a5zftR4aUNd3CFzOwORUEIwzL5zlDXKCnWuy+ZWTBhEOnPinR8Sx75xdNPsGkn4WnR/WQMw7wJFTD/b4rawhFoVctA9GA6OlVW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFqfwQB1JH7tqUmk0UGh4lXQWtQbeTkxl7MXn9W4y+o=;
 b=e8smwsfKb4Gb0bqfydZ6OQdJrZWLvMKO1XDP64qqFxx7bpNAYZhUGO9elmnv0IUPWdFocZ2DBf+biyUKg103C1jlItN732u714uZXU/XKDe1R3B4Ljn8tlipJdfpmJOI8SKbe1XD0taEIheP5KzRLU9bMBagrwbA/bZdIA8QCpSj4M/8UC5iHs0UTQ2Gqy0IAPwqhvgAuzlRgwXfgOTguMi0NgGyzM2V10lWNXzOn54Acmlzwf3OBRCcDju2fpDOW3NOdXZGpvkAg+/hQtMyuQo1ay3m7eLcVTk6vo9M1X+7qNQ1opHqxNAG1BcodPGCqESk3Hv+jXbxsLODaQ8nAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH3PR11MB7299.namprd11.prod.outlook.com (2603:10b6:610:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 11:15:49 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Thu, 15 May 2025
 11:15:49 +0000
Message-ID: <6e507daa-a34b-4e3d-94fa-1560fc9cfdc6@intel.com>
Date: Thu, 15 May 2025 13:15:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/13] net/ixgbe: remove unused field in Rx queue struct
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <c92131e8fcce1901018450bdf97ae004253addf7.1746538072.git.anatoly.burakov@intel.com>
 <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
 <aCTFhfkYJUbYALMm@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aCTFhfkYJUbYALMm@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0249.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::20) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH3PR11MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 4feee3ac-7565-4d5c-686b-08dd93a1d882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEtrNHV5dkJ3ZDZnRE1ONmVWemcrcjBhbzBlNmg1cm1KRWFDM3N2Q2dvOXdM?=
 =?utf-8?B?NEZ0Z2ozVmhFOGNaUHkxSVE5cjk3RFNjQ2RyQytmMnVRWE9uMjdNUDg5clRK?=
 =?utf-8?B?ejRQWXdJTVJOR1dxWm1jVDgvSnBTSDFpTE9ZYnpQQ1pYamtCeUZQQlZBMU5v?=
 =?utf-8?B?Q0dvU3RPZCtzeHZUSE9PbHpTUkRhbFd4eElFbXRaQ050Y2ZTa2x6eHlEMkNZ?=
 =?utf-8?B?SStMY21malAwMFY4ZWpZT2hVVnhtYnJBNFl1VHJqOXVVcWZEMFYwemdUMW4w?=
 =?utf-8?B?T1VJSkNFZGVVanpQdjZQUmJMendzSFpZdUpIamZ5T0ZPcWt4VS9yN2FVSUVx?=
 =?utf-8?B?blJGZzl4c0d1YmMzTEozY2tzNzk1WFRHaGZleWg2SCs5NWhrMG5Ya28rZmMx?=
 =?utf-8?B?STlQQ0I4Z2c1Qm4vK2x3cWVpOUFjVjRLanZkM0ZuUEN0Nnl2N1NtWGp4WDVJ?=
 =?utf-8?B?ZWUwK3Ruank5azNiYkFQQ3ArZEVnNXEzdWM3WlpmaVUzUlp6NUJpYWM4NVFF?=
 =?utf-8?B?ajBEWDhONytySmp2eHBUZiswd1NHMHN0VWl3SUpyL3pJSERsb3JJQ3hCR0JY?=
 =?utf-8?B?eFpGVnd2OXRRQXJMVG5rbnlwc0lLdlJWeURCWEhkNGxtZGFTZjFCR2U2N3Uz?=
 =?utf-8?B?U016VVdWRFN6UUpSbjF3cUlReGIwNVZJOEdlL1R5THRJTG9WRTNwYVJFR3FH?=
 =?utf-8?B?U2U3RXB1RmxiYmNQNFdpT1RVNVcyMHFHVmtpS2xPV1p0MUI1aEpqQjZPc3BJ?=
 =?utf-8?B?bzcyaWw5TzRBVW51UzFKb2hmMXJjcXZ5UitGZXdERlErZWRzVmxYcS9DQ2xy?=
 =?utf-8?B?OVh4a2ZQOVFTZXEvUmwzT2xZdGJOL2ZnYzBhd0lOcjBITkNUMXFYU1JhUTYz?=
 =?utf-8?B?V3NHNXZneHVvV0p2eTJTMkZkdG05U1BmWC9xTHVRZVBzbktTQy9LY0lrRUxj?=
 =?utf-8?B?eDV5bUVGejNwbE1VcHZjeHg4OHAwZDJlYXZObzJoMEhLb1JXa09RLzBManF3?=
 =?utf-8?B?OWg5WlFnckxkMVM2a1A1cTlHOEROb2MvMjJMQm9yNGFJcDg4Vnk5NnFtbWs5?=
 =?utf-8?B?WEYyR3FuN3FXT2tOdUFxSWs3RXY0MEtMWEd6OVdkWGY2TThNN0lqV01SUDk1?=
 =?utf-8?B?L3Q3ZkcvOXJ0dXpnRVNhYVBNYVRDMm5pWlVlbFJSbXdnVEh4Qy9JQklLaTU4?=
 =?utf-8?B?M0VFZXRqTWt0UUQ5cmh3T0JzLzhPVkl5NGRrV3lQdmIyT2NWd012d3M2ZE13?=
 =?utf-8?B?VzhQSC92SmphbGEzVHlTQmtnckJuRlhDMW1TY21ERk10MDhlbE1ZM3Q0WEZp?=
 =?utf-8?B?akcyRy9wcmhHZnVXK0g0dSs3Qm8zTjBCb3I2bmxhL0t2NmFzOWNVdStuTGdW?=
 =?utf-8?B?UVpLc2dZYm9tNU1zS0FuNnY2SElwWVlLS3Q3VmJaZGNJSloxMWtKczF3eUI0?=
 =?utf-8?B?YVFaZGk3eFFzVUhNTGlPc24rVVRkUGQrWGxZUnVjOTR4MjBwTnNDVHpoMVFD?=
 =?utf-8?B?azNkSlNBcVByOHpiUVJJc3hOWjRnZENjY2xxaEFTVnNuK01OWXZiOTAvUzhi?=
 =?utf-8?B?TUhvWXBMQWoxN0Nwd1dhd25OSCt4S0dYa2RkRkpQSUhwR3U3bUtUSXdiYnk0?=
 =?utf-8?B?VHA3eGcveS9keFVLRVJjMThKWHVXNnFNanVubkVnU0dMQWxodTZOR0QyZXl2?=
 =?utf-8?B?bm1mYm1wbDMyWDVrY0Fabk5YTnVvN0Y1UDJ3Q3RISVhMakw5L2lMVFRJeHhh?=
 =?utf-8?B?OXl5RXl1ekRiNkcxMGlXOWQxdkY3OFhGamllMC9SdG5BR05XeUVQRUFJaThN?=
 =?utf-8?B?a0JMM1JvUHArRFZDQW1oTVhPanZJVi9zc1phTDZuRU84N2o2dmNBcE1HMmMw?=
 =?utf-8?B?QkpPZ1hHb2FQSU5nbVJqTW5IK2p3d2FQM3ZmNVNOSlZhSVk3eDFpRDNJZ1Fi?=
 =?utf-8?Q?SpKvgFaJSKU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nng3aWdkdHZnOW52QWNhSUZQdWU5M2J4QTlkZUNPdE1henlaeWZBVEQ2b0ht?=
 =?utf-8?B?TzVHbWZYNU1DQVZOYzNWT2c0cy91aEVYMmMwaGdTSTZINmgyOGxpYnZDVmxp?=
 =?utf-8?B?MVhNemNjQWs3V21HdnJOcU9pRFVMcW9jMDFYdExlR0hiOFJnaEloMStCZ3pS?=
 =?utf-8?B?bVJYWFBqbW5yMXJhV2diM1c2ekJvQXpjcjlzZmZ1Y3ZrZHJTdTVuV0d1MGdN?=
 =?utf-8?B?RGdFY25wRXNFQ2drVHg3TGxtZnJMeWdYb1ppNzVBMWxqdVZUeW1aWUZsQStH?=
 =?utf-8?B?eDVWaHVFM0tQUFJOaHN0M2owUlJPRk5oZWppcjVCNCt1L1czbnJYR25BNWMr?=
 =?utf-8?B?Zi9YS3NmeFkvV1ZvYVRXaDlLQkVlTjNZOXhzdzQzZ0tmSE1mNjBvRWpVQlB4?=
 =?utf-8?B?cEdyRkJaM1FJaEpUUW5SZFNHTmtpYTQ3cWZRTzRSOXFhd25OdHZnWEZza1VK?=
 =?utf-8?B?Mi9rREtCN1FRNzl5UVFVcHpnaXdCckZEc0F0Z0ViL2p5SjlPZ1hKUncrWTcy?=
 =?utf-8?B?cDlKMFlKRkZadnJCU0dMbWI5SmFtWnFJMVFlOGFsTm9nY0VCeDBVcU5rNlNr?=
 =?utf-8?B?YmlTQWR4VVZHWlpRK2Vmb1YyTStJNEVpRnNmVnk1YXI1Y3ZqbERZcERjNEJH?=
 =?utf-8?B?TDdnUldQUUY4RTBHTC8xUFlGYVpPY1Y0WUlOQ3FWSnhvTlhSZ292dXlrTk9Q?=
 =?utf-8?B?bTZDSjA0ZWZDSVlYa2tFMDRHeVRLWlNsVjg4R2dNZEd5ZWQyVXNCUGtVRTNy?=
 =?utf-8?B?T3pCcDB5WDFoNDF5TXl5ckU4OUNuaHhZZVpoV2hFNHppTVIzdkNLT2svR2hB?=
 =?utf-8?B?UC8rUm9wa05zMVEwZnFLQWpuVTZFaVE2ZzJEOEJCd09hdzVKNWFLTlRIU0VS?=
 =?utf-8?B?NkxQRkxmbE1sdTZTd2ltVHRISkNGa2FRcHpFbFRFUXhhdkYyOHRQcmRpZUpj?=
 =?utf-8?B?eCtYcmZhMzkvQUtjNWZjN3Vzd2FoYUo1bDVRV1d5TkFSdUFQYlAwcHZRN2dK?=
 =?utf-8?B?bDQydUxFTE8vS1NjTVcwZHRHbDk2U0N2K0wwSURHWjlyakFvZ2dGN2dHSFJZ?=
 =?utf-8?B?L0NjQzZSWGY3QjNxY2tnYzlqSzNGZFVjaHVmRTRUbUhjQzFvTmlaU0JRN3Fx?=
 =?utf-8?B?WkhYbjlwenRjTEdYSFlVenAzYVRyRjlvT0F1a2dFWm1NVUZDR0QrWlZ2b3JC?=
 =?utf-8?B?MWtnOGg5d0lydXplUXA1U1U4c2JwL3dhVWQzU0ZHbGo2QXk4SWxkZ1JyVFp6?=
 =?utf-8?B?MjJWQ0tWdjEzZUo1dDg4NCsxTElhSTA4K0NZRStwS3ZGazVPcGs2MFhxVkpv?=
 =?utf-8?B?Yk1wYXlCYWF3K1RtUDBlOVJmbHVJYUQ1WkJYL05NZTlQZXl2Mnp6NDUvSXd6?=
 =?utf-8?B?YUVNR3FZTDN5NGJ4QUg4NkJUaHZvSm94MGM1V3ZBb3JNZG1EWGc0QUNuWTlM?=
 =?utf-8?B?ekhmeDZkNU5STGZSUExGU2RGUVFGYXcwVEhWWkFYOE56NWVVNjVnYmpjbVk3?=
 =?utf-8?B?cTNjaU8rNmZQbHV0SmtKQS9neDJuUGNmWkVHRWhEeTVMSkNRd2loOUVlM0NU?=
 =?utf-8?B?WnA1ankyNTRMQkMySDAydGNWL2VOMlJpQUZQdE11cHU2ekJOQU41VzRHa1dY?=
 =?utf-8?B?QzZmRDFUQmRaRXpBUitDSTJnRjJjTXptLzIwaGlDK2RkaHZBRUQyeEFzR2hC?=
 =?utf-8?B?VTRnWGVFZG8vQnlkQ3F6UFVhcXE0UmZPcnVJN0N6SjBHbFNvOUFWRUpabCs1?=
 =?utf-8?B?MmhJQzE4NkF3V0FkcE5Ua0I2bHRYc1NpL3IvejU1TVhPc3ZsUU5pU3BiN3Ns?=
 =?utf-8?B?TVZhY2J4Y1crMStFUEhWTnNjck1OeHNCKzc5aDJZdFlsYytWWDdxcDdCUjll?=
 =?utf-8?B?MGxpOWFaOS9iZU5yUHE0V3NValkvbEZSZko3aWE1azRTRVM4QW5xRGNTcmMv?=
 =?utf-8?B?QVBSVi9hUWl2cjl2cFhlNEdPeFoyWE1JM3lCREpWbEEvekR2YVBVUHRaNEFR?=
 =?utf-8?B?NXBXMzFPZmwycXlXMFFrbG85TkFUc091MXBaN2tYRTluMkFMeU5BVjRjZFdj?=
 =?utf-8?B?R1pGUXdFZkNsMlEyakxVcThmSmtHRFJvM0pyM3JBYjgzMUhzNisyV3BVVGFs?=
 =?utf-8?B?M0dZV0kxVFByRUZHWFE1ZG5FcmV6RzJEc2NBR3NDcEVzbkg0ODZQeG1DVW56?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4feee3ac-7565-4d5c-686b-08dd93a1d882
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 11:15:49.0360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iv3pE+9Zdc+wI9uPCpcxezF6a4rfdlL6n6ll2CTdGHcKvkwTHNO8daGPq4N2GmongmzQ+wSYODIEE0qaj6kunM8hTqFytwJ8udDWlPLGnoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7299
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

On 5/14/2025 6:32 PM, Bruce Richardson wrote:
> On Mon, May 12, 2025 at 01:54:27PM +0100, Anatoly Burakov wrote:
>> The `rdh` (read head) field in the `ixgbe_rx_queue` struct is not used
>> anywhere in the codebase, and can be removed.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
> With the one comment below fixed.
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> 
>> ---
>>   drivers/net/intel/ixgbe/ixgbe_rxtx.c | 9 ++-------
>>   drivers/net/intel/ixgbe/ixgbe_rxtx.h | 1 -
>>   2 files changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
>> index 95c80ac1b8..0c07ce3186 100644
>> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
>> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
>> @@ -3296,17 +3296,12 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
>>   	/*
>>   	 * Modified to setup VFRDT for Virtual Function
>>   	 */
>> -	if (ixgbe_is_vf(dev)) {
>> +	if (ixgbe_is_vf(dev))
>>   		rxq->rdt_reg_addr =
>>   			IXGBE_PCI_REG_ADDR(hw, IXGBE_VFRDT(queue_idx));
>> -		rxq->rdh_reg_addr =
>> -			IXGBE_PCI_REG_ADDR(hw, IXGBE_VFRDH(queue_idx));
>> -	} else {
>> +	else
>>   		rxq->rdt_reg_addr =
>>   			IXGBE_PCI_REG_ADDR(hw, IXGBE_RDT(rxq->reg_idx));
>> -		rxq->rdh_reg_addr =
>> -			IXGBE_PCI_REG_ADDR(hw, IXGBE_RDH(rxq->reg_idx));
>> -	}
>>   
> 
> Unrelated code change. Please remove from this patch in any subsequent
> versions - it's not worth fixing this unless we are otherwise modifying
> this function.

It was removed because we either keep rdh_reg_addr in common Rx queue 
structure, or we get rid of both the field and all its usages. If we 
don't remove this, we'll have to include rdh_reg_addr in common Rx queue 
structure and since it's not used anywhere except here it would be 
pretty pointless to do so.

> 
>>   	rxq->rx_ring_phys_addr = rz->iova;
>>   	rxq->rx_ring = (union ixgbe_adv_rx_desc *) rz->addr;
>> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
>> index 641f982b01..20a5c5a0af 100644
>> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
>> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
>> @@ -85,7 +85,6 @@ struct ixgbe_rx_queue {
>>   	volatile union ixgbe_adv_rx_desc *rx_ring; /**< RX ring virtual address. */
>>   	uint64_t            rx_ring_phys_addr; /**< RX ring DMA address. */
>>   	volatile uint32_t   *rdt_reg_addr; /**< RDT register address. */
>> -	volatile uint32_t   *rdh_reg_addr; /**< RDH register address. */
>>   	struct ixgbe_rx_entry *sw_ring; /**< address of RX software ring. */
>>   	struct ixgbe_scattered_rx_entry *sw_sc_ring; /**< address of scattered Rx software ring. */
>>   	struct rte_mbuf *pkt_first_seg; /**< First segment of current packet. */
>> -- 
>> 2.47.1
>>


-- 
Thanks,
Anatoly
