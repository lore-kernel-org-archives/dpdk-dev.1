Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E49C3ABC0
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 09:54:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57D5F4025D;
	Wed,  7 May 2025 11:54:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id E7F414025A
 for <dev@dpdk.org>; Wed,  7 May 2025 11:53:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746611640; x=1778147640;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=nZ8PbWBsZbClkZMtLd/Ul466ucTQIBM55OLwetFiH38=;
 b=QqcWfprjQ+3+Bg//1eXdJZ4m1XP4uZqR1e/kC/XOEApugnTRvZ0+gefw
 hPHCmG77gbhwCZl4V1A8Myl6hbe+mC5OscMXXy4w5AFH0F1n4Nw28NGMY
 mDbDsRp9aO365QOAkPfHeWWnesfasXUvvgEwQa/B7YaimDitNkVNHRk2Y
 eKOyk/SOheFa7T6raarmmS7Hd/DU8/2f3ypt59BUW6Ni4nrGiY6Z20QQ1
 cga6I3Odiqs1Osr9sf0WR/HNwNdXpRKGJuDaGn3L9Tm0U5aYKgGpmsRx7
 j3zw9aPGXhWq2kKhcG8Rm05TIL8sKynBs7MdbOnIM1DadLIdzkeBu3sFp Q==;
X-CSE-ConnectionGUID: I3WJqJNpR32hgRgynYYEPw==
X-CSE-MsgGUID: tCj+AtlHQ+eaDwIcO/Q4Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48342604"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="48342604"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 02:53:54 -0700
X-CSE-ConnectionGUID: 4kU4PiGZRs+sIG9IeCKJ0g==
X-CSE-MsgGUID: KwJfeYyYR0uccbFHOBZdbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="136427995"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 02:53:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 02:53:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 02:53:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 02:53:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oB+0ynpvFSvW64mTPunUmpw+sNSLBMkg2YSzd6WodQD9xqr/3p3kzjVvbwFvJ4fhbDdOq7NzJlo3SifWzOwkIN0NOMYIw9JDpvY69bFsHcJhpIBK6YbSfTgLmoH8JoepThHRKV/VcGmd8zurTuSultzPBbSEWBWKADzrnO7Ce/Bdm+sOqqGWtSkPB/6PTn74ngHCTPU/uVowLu7pmk26pNxg5MvF9x7PA8tRCs2LIKjgMyDbZmYEjibAsfZQ18Hg1A60J+aRMdqnXDcsOFUZu2087jC1xWNRX3QP9TRUzFqcx+ZyoHp7CysWB3IRn8GOp/v0gtdKuCBfZCEP9ov1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOVSkkDfBD1ENPjVHmIRb0/FOOQw3luRZ5tpuM4G48Q=;
 b=hIAXVJywyHufzQDKXDloCkAiXY+MP2qLbmShRTe8Tv3KhYnaUaQCUVnHgQwlDTFikQF6XXNlTSXk+QYGATBuA9s1J5M9W3oE5nKXiI7gxHK2TmuZKnsRt4BuLk112bGz1AwQysAE6uByOh2IrEamZPKE6FlNouS54HNDY0ngNhP54xh81HjT5UxOstO3+MYWrHp6tcAnt+fktwHg5/1gXwYiHrTj4IoZWidTG2V89j24663rKuxcSI8j+8P4nfZZ2CR00lfqivNHnDIIkYQdFHEgkHUb8pKIu8sXH4e1lplyEePDkyxAMTkZVHH3QvmbxvAB7256Lb/CNfYDEL7TBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ5PPF6806D69E4.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::831)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.32; Wed, 7 May
 2025 09:53:44 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Wed, 7 May 2025
 09:53:44 +0000
Message-ID: <99a0fe20-00b9-4cf7-b8b8-b9a80469073f@intel.com>
Date: Wed, 7 May 2025 11:53:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cmdline: add floating point support
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
 <f9054c20d6ac09b82a4c03df268541118e8e9222.1746611372.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <f9054c20d6ac09b82a4c03df268541118e8e9222.1746611372.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR06CA0031.eurprd06.prod.outlook.com (2603:10a6:8:1::44)
 To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ5PPF6806D69E4:EE_
X-MS-Office365-Filtering-Correlation-Id: 9466f621-7c39-479d-cd18-08dd8d4d0ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXp5ZXdNUlFTYlltaDJWMzROTzIrd3lXdVgyL2VXSjhsaCsvVGtZRzRwUFl6?=
 =?utf-8?B?VkcrM0RjRjFVMDVPbUg3QytUNzdYWkhlVFhCeEg5N05iWjAyZWo5VnpRdkRz?=
 =?utf-8?B?ZWdLMzlnaHhWbDZXTmpUTkk2V25wbGE5NTZzeXk1QjBrVHhMemlXQlREYVhY?=
 =?utf-8?B?WlhiZ05KVUZwQzJUTE5OaXRkOTRxcUJlRWorVmNTR0FZa3Y5cCt6TzdDaWxZ?=
 =?utf-8?B?dllGWEtRVTVyeFB6MURteFh4dFVHQkpQcHN6c3BXMXlCSDlUemNQb0pyWlBB?=
 =?utf-8?B?cUlGVWVEa1J4Qk5iMnBidXByMUlEVitEcmwxVU1vbk51b2JDcUZGZHYrQ1VJ?=
 =?utf-8?B?d29TUGUxbzkrai9La05xYkdnclhNVlBxZXpxRnpQUCtzbXdLY2RlNWFiUTVu?=
 =?utf-8?B?cFZ3QytlWU90RnNqQmtQWFBmSCtoWkdoMVB2OCtEY1VjT3dIaG42NW8zTU1L?=
 =?utf-8?B?Ty95NjFwNkxNcm1XTlpoMXY0bC9Cc28rdEZwKy9vSGcwdDM2RXplUitvTUJY?=
 =?utf-8?B?aU04NlhUZkZwNUlKa3QwMjRURnZyUCtTWVU4bzJ1RzRtNUNrbTRWdERiYUdK?=
 =?utf-8?B?ZE4yMTEvaVd2WEtRclVMU0dDaGhjdWgwQW1pQU1wTlhGMGZkUGQvbHpnUCtl?=
 =?utf-8?B?R3c2TlVnWXp1Rms5eTgrcHZIaWVEZnpMakVLMzVXM2FudUFBYjkzOGYxU3hD?=
 =?utf-8?B?OVllWkNFZEdwT2c2VDhIdmRCN3czRUU3dmtsdlRxc0JHSFRObGVuakp6cmdl?=
 =?utf-8?B?UktqMWhkTHp3ellXaytyRWtsVlJoeFZ4b3MzRVdhUk4yZ3llR1lrb0djak1I?=
 =?utf-8?B?MEZrZk1XMmViQ003bzd3aXQ4QjdCWjFOUk0ybVRSN1laN25ESmRtOUdhZnpB?=
 =?utf-8?B?MHBrVk1zYU5IdzkwQk94QXcvazZSMGMwWlRUekVSSVpsMmd5dDM4dnhhMGRX?=
 =?utf-8?B?SjNONzUzWDVneE9kMmxVK2F2ODlEWGtZY1RpNFM4VUpOc3I3U3FZbXFJcFMy?=
 =?utf-8?B?MEMwT3lHZlR5SE1WSTBCbXRMY2pkcW9mUFpKem1UUXpJdVhJVnRqNTR0TktT?=
 =?utf-8?B?ODQ1dFQzZE1pQ2o2eWdneHJidGVheVFMR1VEK3NpRUZrMTlpbkFZNENaRkNn?=
 =?utf-8?B?SEdObjJsaXZlOWJQZTgwdDVKMUV6WTNKNzFNTTdZSUZCVjF1ck5KeHNxb1Fq?=
 =?utf-8?B?VnMrbkU0bHphNDJ3Z1lLZXBSL2lnejBwa2I1OTd3cFJISTgzSWNrZ0J0eVJP?=
 =?utf-8?B?UndiQnIrUTVmOEp5aVZWZnlKcFRRdnNIaXRkbi94SVJycFA0SXhnMFVYbXJh?=
 =?utf-8?B?YXExYS9DaXlYaXFXa1pHaVlBS2tTNStUK3Yyd1luOUFIS2Y5VTR2TklFL1dh?=
 =?utf-8?B?dlp1eFFaM0RZc1VhU0JRWjBjdGttNnRBZXJnbCt1NGJDSTNEOS9UeUFmZ3Mr?=
 =?utf-8?B?QmRjYVA2Q1NlK2drV0hXeG1lWjNsa2FhYlRTQitKL0kvR1hpNDdvaVd4VWxi?=
 =?utf-8?B?SVhTTkRNT3h1Y0RFTlduMm5LY1dURTJVMTNLR3B2cVZVdWtzblhTUDlKM2l5?=
 =?utf-8?B?WEljTm9sQU43YUJneHZuUWU4RGZmVE1iV1U2ZWErS2lKU0FJWnZtUkIvMnZ6?=
 =?utf-8?B?ZmYxNFpNYXVHQWEwWEpMNElJU01CcnEwUXhtV1Y5WDI5QlV5akg1enZPdEVV?=
 =?utf-8?B?V1cvMGM5czFJeHUxZFdlSCtrWHNncHYrOC8vcER5aGs2OVVUem9ZazRSY1Rr?=
 =?utf-8?B?NHQrYWsrWDFlRHNOT2FlL0Rib09ZbjFJTnh5alZQRzV6TTdRSE16LzEzaUZn?=
 =?utf-8?B?R2xWVUhoa21hK1J0cFBmdUx4VEtySE1iWEZhemxTQTZ2d0xCYVVDM29SRHFU?=
 =?utf-8?B?bUNsZ2FmK1hjd1dhQkRjenlaS1JhVlFSZDNKeEYxRXFjb2ZjcDFEQnEzL1RY?=
 =?utf-8?Q?1XV6trsqxkM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkR0MVRjdWxRTlJIb0Z6NGRqSjVzYkFqMGoxRGhITVA1MThmbWRCd2Q2TTcw?=
 =?utf-8?B?TkhLOFRYZ3VUekl3VEllb3Izb0VTaVdHa3hGMmk1cHlneFRFQ2RlblZTazR6?=
 =?utf-8?B?L3Jub2huWGEzSWduczV2RkFHRmYyQ3NqWkUyTnZpNC9kci9VUVNYdmZzckxK?=
 =?utf-8?B?dWp3eStaOHpvdCszdmNkQzlEUzVMZjN5a1FWc3hLUWVWSXFueEM1UGhUNWh6?=
 =?utf-8?B?NDdSVm9OQUdZL2hpcFpodm8vaHp5S1pxaDB4T0h2TlFGand5c1RvVHV0SXA3?=
 =?utf-8?B?bjd4Ny9vcmdBUW5GaFRVeHBWUDA0MWZCMnVRbHFvejdWNWw2SWxjYmlDZnQy?=
 =?utf-8?B?aXJmOUR2b0tPRkJIUjlFMFR4L2FoZURRbXBUNGw1am9wbzBxWHJncStQYVFM?=
 =?utf-8?B?dUQ3REcrRlNLeGh5bmtyMEhGZjh3U2NoSWNPenA4YUVyWHZxbTZkMGRKSHJZ?=
 =?utf-8?B?UmVlbm1acHduaU0rekdpZnY0cC9CdjBJektialdsRDBsdllWQXlja04rNUI0?=
 =?utf-8?B?aHgrWmF1VGIxR2J4dlNnWWRRY21nd2pzNDZMeFJpQkhLZVllamJnUzFzUjBI?=
 =?utf-8?B?ejVqQW5ob2JBV1JNeDBrZll4UXpLUURYeXhYUHlDYk1UUnEvYnlCSHAxSU9R?=
 =?utf-8?B?TUhrOVhtU1ArcHBHbTd3VDZuNmNQTW92ZUgvRGVCd0cveENCeE1DNVVudm1K?=
 =?utf-8?B?d0FNVVpwaHI4M0QrRitCNWJGSCtwWG1JTE5IbzdxNVlDTHo4dEZJY1BZdVlB?=
 =?utf-8?B?aFA0ekpMOEVoV3NMdFAxVE9tN2VnSFBaWlJ6VWlUdW9TNTZhYVZrS2xCRHhF?=
 =?utf-8?B?NThKT0RBQ2dSTzBoT1RzOTNPbEJBYmNaY0RZajVGWFQ3ODNobGlIZDRoUUMz?=
 =?utf-8?B?TWk5UVdqSnZIR3lBSGNYQXBTT1lzU0RZK2dIY3A5UStHa0lrZXJ6ajRRSHNt?=
 =?utf-8?B?UnY2clpiMk8vSlB6Y2JCOGhKaEQ5eDZuVDdxeWFmbnVSSnAzOHE4Vk9WVzBV?=
 =?utf-8?B?d2dabmxDakd5cjkyeVRjekxNanlCWmxYVEF5dlpWOWpsT05FUDBiTDRkcFlC?=
 =?utf-8?B?dVVCTDdGaU10UmdTU21udjhxNlhJckE4cmRxMHl2M3BYQ0dhUUVyNnloQk9m?=
 =?utf-8?B?SG1rMWR4UDN0ejhMbkxrVGxLMHN2b1ZRRDI2S1VNZ3ppSVAxMnBwWmRvcDBH?=
 =?utf-8?B?Mkx6eENYYVpOaWJRNFZWY3FheEVBVUpoR1V0bHFrVExRS3JhbmVQTnViNU12?=
 =?utf-8?B?S3FQNWIxMmxURUtVVEJHQjdUWWNWOVhBaThPNFdoL2pNK2htZWFPd2xmQ095?=
 =?utf-8?B?bkRzVGt3RkxacnFJNklLN0t2SWEyUTEreE1wYkN5TGZqeExRVkIxRVlHVng3?=
 =?utf-8?B?eXdOYUcrRU9Sb3dmN25sYTNKd3p6UlJwdjYxWVE0dVFOZS9MT3NyTWpZS2lr?=
 =?utf-8?B?UWtWeTdVTGtMSXBCQWZNUjFtdUVtUGI2bkJkZEZ3YjRyQzFhS3BiR0dYVDkv?=
 =?utf-8?B?elNNSnhkYXNMVzJYZEpHeXFMUzhjYStVTHFKckoyN1o1SU5xWmx5TSt4bS9M?=
 =?utf-8?B?WXhsMDBMb2cwdFVSYkV4UmlFT3hCUS9oU0xwL1ViNDVpbFAvdlhDanU0VndU?=
 =?utf-8?B?VTFUelJhczVtbHVRNWQyK0VyY2J4SHZNc09FZDFBN25UVm9PU1VNSWlvbmpE?=
 =?utf-8?B?YmMwUEVUcFhVdW03THhxMlB1eFBISUw3dUpLQy9tYlgxdm5UT3o3eWUwRWtW?=
 =?utf-8?B?K0I2SnFhc0w3d2ViNDN5cVpWbkJpeEJ6UkI3TkZtK3RPb0o5d1FhQzMydjdx?=
 =?utf-8?B?VkkySytqdlBZTUx5VlhxQzdvZnJSaXFYZ3FEam5KU2Rac2MwdWlGMkVxdndq?=
 =?utf-8?B?bFFqcWpqSEJFRTlKZHBobUo4YlRGazBNQ0RPN09FNG42aVY0akFLSkRIR3Jz?=
 =?utf-8?B?ZlpaRnhJWGxGVjRvL2ZNbFpIZTUyQUI4RS9xRHh3WjI3NDdKRVlTY3hhRzN0?=
 =?utf-8?B?Y05XeU90VVpWa0pNWW5EcTBFUXRMMjlhM1h2TGt1UVA1RnV0UlhVNWlTaTl6?=
 =?utf-8?B?UHdNL0FhdW9BaDFBWDh5aDRoODMxUjhncVNKQ2NEd0QrQnBnV2pKZTRubmtB?=
 =?utf-8?B?MS90OFFqYjVtdFdQVWJTTFRTcmlEaDBTWTNkVGNnQXdrRXRPY2dNVGM0Wk1Y?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9466f621-7c39-479d-cd18-08dd8d4d0ddc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 09:53:44.2579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eruQmTNPl9Rm4p1VwI1VSuhhYIG7e4wIUNVV6OIzX3KfGLCnzc7OuyAnDc7jZr+3UPuRml4d1fu6XmNO4PSYhLIPoxqZfZi39Oves4y53jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6806D69E4
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

On 5/7/2025 11:50 AM, Anatoly Burakov wrote:
> Add support for parsing floating point numbers in cmdline library, as well
> as unit tests for the new functionality. The parser supports single and
> double precision floats, and will understand decimal fractions as well as
> scientific notation.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Missed patchnotes:

v2 -> v3:
- Fixed a bug where a free-standing negative exponent ("1e-") would 
attempt to be
   parsed, and added unit tests for this case
- Added support for floats in dpdk-cmdline-gen script
- Added documentation updates to call out float support

-- 
Thanks,
Anatoly
