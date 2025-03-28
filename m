Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDAFC28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 13:01:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BA70402C1;
	Fri, 28 Mar 2025 14:01:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id A9F7840269
 for <dev@dpdk.org>; Fri, 28 Mar 2025 14:01:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743166872; x=1774702872;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Znr6FoCOZN5d7r4z458NuziE9JOoCWB/Mf4G1AeEwm8=;
 b=CQWxnuqm3JK0o1mpv+gLWxDRgCI87KqmGYaeq8+otmCOXZbCcDtGQFXP
 jya8GloRq9TSeCW4EVV5GT4rSAQNS/iCv80kIc+vKFdG5dqlprqD0VnEU
 xLt18MTIUWKeFBfiF0oNoAzw6f7+U93QdfSi/IrGdDpjaQDlgJ9ElZrZg
 /KwRmu+deM3sW2RVBa3f2KMEe4o7xYdDVjxbwS5jtjekU4vBexBI7MSHs
 tvC3N5tr4ikV+FyyN/DfveorCSAdImm/kbENRMu3tVH8aKajvcyJELKyY
 fGsXyHv97ddGdkad7Fw5zdQWWlKrf1lt18tN5oc0F7WlZu2PAGf53940I A==;
X-CSE-ConnectionGUID: oY9B8edUTne/dR4bQHjyug==
X-CSE-MsgGUID: 8dOiFBJMTx+zyGWIf64xMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="69890274"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="69890274"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 06:01:10 -0700
X-CSE-ConnectionGUID: 6+HcuuN4RpePMMq45fcTXA==
X-CSE-MsgGUID: OKrCGuxeSi+n025s7xk5/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="162676897"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Mar 2025 06:01:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Mar 2025 06:01:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 06:01:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 06:01:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RP2GggllBXrv9jvpyjGZ6MOJWPmU2gpznKxihzn12yL8LTSLM7rWS9yXyIJXDNe1zLDTCZk51fZZGGbhWdeRaUdS9+7b7diCzz9ULkMNCSu7RoSVr8o3oR6JnGs8gtvqBGhKjxCEKDbse/8y264qiWyDKkBnIfCn7tI8P+Ggf+uQdfY/ObeS0ZOQh5x5BV9Ym3f2VC+9erK8Ii7HU85xoqqxZRTZvgSFFnapHCr5UST4SoL/6GRLPghH+QE8K1kkFAOBRZuq69uOfN34uZh9buGuNvQSIWcT7Kr2Zvo2DpBEXN5ZALEZUC67k0Tr7LonN7B44BPOe8o1Deb6EyEl5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGaotjaFEAKvQOlEg0zEtPAH+SJzvySkVa3y/Sfc4HE=;
 b=cVPmlwqhLd8jP4bJAUrmWu2UBPY+wHj1bUrdUjvIYsgH/3Vn+8ezSl7Dn75mvJdzbs+O1xRqFtS3VB6X4bPAW6t4heha2Azhi63nAHlXUpybjd3NaP8/o3BMFLXGnZuUS0qkDKu6JGptG/CE2CpZWIL5K1sgN+ORBfvfUL92JYtgo91JUJuMyS3cC8WGOwzEK1MKx8ilcMewRrcmhjcBYoz7uN/4swVluit81/Mp7ReosatbENb1hMU/vruQP3O4LpSBRzGl4c+YN5xXcqBz8u89QgyLOHBpXGPB19DXo3y5zh2BayVOAg4eGK7gpX5tbRNvofTAGU6puUf+Xfw1ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ2PR11MB7597.namprd11.prod.outlook.com (2603:10b6:a03:4c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 13:01:04 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 13:01:04 +0000
Message-ID: <10588143-b477-4847-be89-180671c71b78@intel.com>
Date: Fri, 28 Mar 2025 14:00:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] net/iavf/base: remove unused meson.build file
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250328111621.2665257-1-bruce.richardson@intel.com>
 <20250328111621.2665257-3-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250328111621.2665257-3-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR05CA0021.eurprd05.prod.outlook.com
 (2603:10a6:10:36::34) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ2PR11MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a536ea-f8fb-495f-de59-08dd6df89923
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHExY0NIOFJHR3QzSnBxeDBwZms1VDVjMGdvNDI5VzNTZCtWWGNCZFNZTFdS?=
 =?utf-8?B?R2x0anllemNJUnB6Y05HYlNheDA2UUY4enF5Yk54dkhoUWZreGpGVXpsRUl5?=
 =?utf-8?B?cVNqdWJ1ZEVWcFdHRk05QzI1MEczMyttYXE4M1NHeFd3c2hVbElWOGxKMldL?=
 =?utf-8?B?ZGl0R1VVL05EaHJ5TVFWY284dWd0R3pHRWRWYitTMWxvV3BJTjFOdlNwMTVk?=
 =?utf-8?B?VENDK2ZQY0RtcVBuUjhxU1NOeGlVL3pXUTZVUDArYkhhWmlaWnRWNXJHdEpX?=
 =?utf-8?B?NkxuODZXNVRkNUloRXBITWpWUUt5b1ZpdjRuMjFZNnBtOGFGa3ZLYytXdnJu?=
 =?utf-8?B?K0Mwd2JxOVVwdDRyRUIzSXg2ekJNMUZrUHU4d1I5RnhxUkdZVkpwRTRzMDJX?=
 =?utf-8?B?U1ZhUGlvMjJxem11ck9Bbjlsc2sySmFuNXpLQ1NxMGIzVWJKS080TjcvRW5u?=
 =?utf-8?B?eE0rdlBlVWFmbG4xK3VWSFFkNnd1RFFXRkNKU2NsMzZrQlArTXVpNXNXYUF1?=
 =?utf-8?B?SGw2akU4Sy9rNUQ2UEtrOCtBVHB4T3NBSmwzQnRsZzRRRldxQ1dzMlUzdE9L?=
 =?utf-8?B?a1ZuUDlTc3E2SXdiNnFCWTkwYmNnWngrNEtXNFFScnFiakxFQk42V2N1K3VT?=
 =?utf-8?B?MlZwZm1HSFNKeU5zM0wwclFRcWxjL0JmV3FjT3RlMWI4M2tqOGRHMSs2QWg2?=
 =?utf-8?B?VWwxZEVJRE1sNU5FeEFYekNoRlFUSi9XMnZncHdUSktGK1B3eTBjZ28rbWd0?=
 =?utf-8?B?QjBXSDVpUjRCT0FUMWJXcERqbzNqZVhualh6Q2xaUnFVKy9xTlJRVEM4TFZO?=
 =?utf-8?B?MzZYS0lRQVZrb3R3WUpTZ1IrRVh5VkpVT3NieHF2V3k3NlMvUEYzdTdMNmlH?=
 =?utf-8?B?aFlOS3Qvb21odENIRkxZN2JOREp3Mk1NcUY1akttSFhGd0YxWUlWTDJqU0VG?=
 =?utf-8?B?b3dVM2pjYzFKZm1hVGpZZ1BwZUhnWnNFeGpOUG0vZWJIaXNFdHZRQXlFcDRL?=
 =?utf-8?B?STY0Q0pVU01lb2ZQY2R4eThSZ3o2Um52VDBzekl2STlHUDhVeDNxcU5zOVNE?=
 =?utf-8?B?QWU2NDZ3UnphSmZkRGVzNjhOVW5GUWVEQjRFWkZSSklsMmJJS1VRNzB5bnhz?=
 =?utf-8?B?TXFWYituVEU3bHUwM2JHR0U5WlZHemh1UkREZGhHNC9iaktXTkQ2bzgwbGpH?=
 =?utf-8?B?ajQ1dFRUVmVkbnA4U0ZVcmU0QVF3dU42R1pOZWtCdEltMU91bFlTckVZaUpk?=
 =?utf-8?B?MlRad2E5SHpZaEhWK2FGN1dhMFowaVVmUEVESjZ1NUpUZllQamRtcWZBNzFP?=
 =?utf-8?B?UXBKT3FDWmlvaEVDNnhaU1ZFRWl6ZHh4MWpYZEJaQitNNzVaM2o3d2tIUzZy?=
 =?utf-8?B?QlhKMHd6ZFJTV0w1R1I3TGxsMVdPS1F4Qm1CSGY3MEg2bmVpYzZEVnE4UjlD?=
 =?utf-8?B?UUNucUMrbmtxQktUK2dFR2FGUW1oVktxeDZPeEZlcFNwb3NhYTAvdEZ2d3FK?=
 =?utf-8?B?T2xnNjN2dkEveDFNUVk2ZjlTeW50d3NJZDRxQ1NPWVNtOEFDZlpvQ0VxV05Y?=
 =?utf-8?B?VVZNUEt3MXlpQnQ5MnRtK2xEYkJ0WnpSRmpkdmtSUFc4RnM2dFBXMURoNjY1?=
 =?utf-8?B?OEp3dmt6NHRBL3pnRDBoelp1VFNDa0JrMzg3TVJUOW5SVTdoTDZVdkpWNUVP?=
 =?utf-8?B?WXhsbnFIVTNHN295ODZXZVdZVFVzRUR5bzY1R3JBQnJyaGxOWHdZNnVLR3E3?=
 =?utf-8?B?TXFqV0VxL0JneFB4bGZsVUsrTEJDRkxkRjlFRXZVdHNEOG8wZGY0ajJkN1ZV?=
 =?utf-8?B?UDZaOGs4Q3ZZMEVuVWdTYXl3cklVTE5uNHFaUVp4WG5FYytyTGQ0RS9ueEcr?=
 =?utf-8?Q?1li9YmHAEtJDg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWM0Mm9xeFhoRzFXNUJtaXFiZzJNVW8xMGJkU2ZLRmVWUUp2MmdZZU9jcHpP?=
 =?utf-8?B?dlRUWmk5WDBQRktHbldUSlh4YWdMTUFPRC9xY29qb1Q4aFQ2YkZ2ak5LUEs4?=
 =?utf-8?B?OWo2M3Q0aTZpNEFPMEV0ODYxUUZuemhUclBiNEVtRTF4Nld3bzJ4cHgxK2Qr?=
 =?utf-8?B?M1Q1cC9GV2loSXJxNHZjOHFhaUpFTnYxU1h5QjNZRDBEWlRYZlVxcUpoSDVI?=
 =?utf-8?B?Q0FhQ25XRTh6aG1mSitwV0xXTVB3VENKQ3JoT2d4K3dEMmVrSWpma0JneFNK?=
 =?utf-8?B?SlF6YVJKZ21HNEZvLzlDWmJpRUNUOUJvK2QybU9zWGNiSVBTWFZ2RnlFSmgx?=
 =?utf-8?B?blVIbXJKZlZHeS9CcER5ZG9ZRkk3c3FDL1JVejhwME1DdEVabElYTytEdFBV?=
 =?utf-8?B?QmtlNUE5cEFyUEJjWHVsTW5tSzRKSElkL3YrYThCOGMzMnUvWVIzVWQvUHlj?=
 =?utf-8?B?aGNBTGFPSXliQ3ZzUmFyZnVFeS9zdjFwRGxqQ2hxRk1PMXVFMUNHcjBsUW16?=
 =?utf-8?B?L2U1Z1ZpU0J0Qk5qaFhtUzNnbEZ0UytlL0tubUhmOU01M2hqcjZjTE5ZU0lE?=
 =?utf-8?B?WkN4WnhiVWI1NE9QcVpQd2xKTGpRQ05ITVZoeUVVY1ZsUmw2Z0t3VW1YSTFM?=
 =?utf-8?B?bjdKbHpablFGVko2YlE2QVJQU01tckR4WVp2enZrMVNySGJ5WXdkQXZPUWF4?=
 =?utf-8?B?VHRZanVPcTdneE5UZUlxK2Q2U1dZSzNSb3Z1cEwvbDVPMy9jWVdmUSt3N1Bi?=
 =?utf-8?B?cXM4YURPeFpGcWh1OUFtVjNlM2cwMEJEN0syZzYzRm5WV2NKMUtNOGI4eTdr?=
 =?utf-8?B?V3c0MnNaUWF2aTVpTGRkTHBySE8rdjJnNWRtb1ViTTkwSm9PdWNiYkd0bFZ6?=
 =?utf-8?B?SjdlRDVIazFySTNTajJQbDlNNGNvaXZnM1RlWVNCc0tRclNPRDcrRHU0SjI3?=
 =?utf-8?B?YitEZjFjUkN4di9JZVJrRUlzMFFZdWVXR1ZBQUoyTENUWkNOR1FnR2EvdUxC?=
 =?utf-8?B?YmRBckZONVJZSG5kZXF2YTFYSDBZVDVOOWNtUHZHU2diblJ6UzNjTnc3bHpi?=
 =?utf-8?B?VEFDU1pEU2pIK0s3MVJlbXlFbm5uelF3a0hkYUtmSFkxeEFjNmFYc3lOVDBn?=
 =?utf-8?B?c1gveHM1dUFONUV3QXNOVjJpS1UvSXViN2FjenFmUkxadlpOZnM4MkkrbXhM?=
 =?utf-8?B?MVEvaHQrVHpmVFUxOSswUDBiYlFKYys3ZkhjcmF1QmQ0QjZ6cTdwVUcwTkhY?=
 =?utf-8?B?eDh5TmRKaDRNTDErcGJlMDNFcFlZa1lYWk9EemdUNVI5ZVIrYTAwT2ZGeExW?=
 =?utf-8?B?YzhFUndsbjQ1cXNBcVVkaUJxeHd5a2hDbzVSUEtjN2J1ay9EYlNXWDIvL0V4?=
 =?utf-8?B?enlTeG51WkI5WGkzTkZFUHRDei9scVFKa3dUZllCZ1RXVG9pbldxTXU5Kysz?=
 =?utf-8?B?YlVPam5OTE01TEVHWHQzRXNySHBIS21ONCswVXhwdnJ3V3plcUZvSTVvZzVi?=
 =?utf-8?B?RDhrQ1dSM3p4d2RtTmhkdWp1M3FRMVRoQnRrWmN5WHhML2xjMlpMbE0wckJ5?=
 =?utf-8?B?Mnlyd1BaUjVPU1p5Z25samlod2FCTzVsSGpuTmFwY080U0thbXhKaE5xUDhT?=
 =?utf-8?B?UEQ0N0hjQVo5WGdDeG9kdWtRZURJSS93WmQ1ejVENkcyWFNwRmFLVE9lcldy?=
 =?utf-8?B?RXRsTGV5RXdMcXRXT1RxeTNSMHVEYyszUzVhMDNWbDh1MDBMNVBkNEZwRkJ4?=
 =?utf-8?B?ZlJGM3g5SVFqc1pnZ25Pc1RUQWlnOE9xMTgvT2lpNk9ic3VUWGRPV1V5QytO?=
 =?utf-8?B?K2NXWDIxWnROQ0J6L2RKRE85cHRreHJGcmhGdzI4ZGxuOC9rbDgxTVdUeDhD?=
 =?utf-8?B?N2FYWmlhU3A4OHZjMGtHTXhCejdRV2RtQzRBTFVDK2xXbzlub3VjTnEwaUJn?=
 =?utf-8?B?ajdSeG5wcUdsZFBqOFFGV1UxMHZuTE5FMVV2bWVFYUxUTU55MWlLQ3ppak9y?=
 =?utf-8?B?Znord2lpZnBxcWw0MUJsdVp4TThCRkNyUVRlT0JHWkoraFZuVFdsUEVhdlVn?=
 =?utf-8?B?NldUWkpPUXA3YklVbVZPckN0OU5JUnFFcGJsL0hUV3VrY2xZV2NpaElOUWpt?=
 =?utf-8?B?UGc2bHFwSDJ4V0JqSVVwR2R5K3c2TWlwdytIWDlPWGFxd01pSmNyYytPcVA2?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a536ea-f8fb-495f-de59-08dd6df89923
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 13:01:04.6711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZnjr11A4bkTY36yKSMZQ8e5IQZG18ZxMOw3UDJbVsLiLb8CaEpxbi6oRidu3zXH6WrLyCmL8gudrKnEo0o0r8byOcC4OYgzYKzLBLe151I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7597
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

On 3/28/2025 12:16 PM, Bruce Richardson wrote:
> The meson.build file in the base folder was never used, as the base
> files were just included in the main sources list for iavf.
> 
> Fixes: f1fdc9ddba5e ("drivers: move iavf common folder to iavf net")
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
