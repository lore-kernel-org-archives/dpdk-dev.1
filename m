Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034B4D10362
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 22:07:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3A1A40672;
	Tue, 25 Nov 2025 23:07:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id F1EC8402E1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 23:07:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764108467; x=1795644467;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=xxdhlBimu22dJdEA7z0I4iHr6zZbVI+HKkXH9Yyfzbw=;
 b=WZA9NYPq0YYucK2mamkBPF6zl56Y/BvpdisYiRJq+2PswlKsxfQ5O26G
 Zpqdxvk+Uak4Pqoz5mXUvyWVwL7TbdZNuqchgncHJDnr9pAj8E5vo0Uy7
 hxicr6qj9qMiOtp9U9GfCbaA/WCwNXBrIF52hmj0ADqNTYD3FUpt4QO6w
 jA6q2RK/m6Y2GVv07slnDi6RIHl0/TSi3jreQy9TeZmBcJBRpTaQiRS4C
 4hnboms7sS34Te48fwSIt7B3jTTjtxFBEpKS/aVwzrrCZ/KU2CJXf7uLL
 n67pV1FiX5hL9p/hh8Os4llF4clWpul6IvDty6E/2iZva+nHrtPIFgDXe Q==;
X-CSE-ConnectionGUID: wgy3DrmURwygrusWsQHp/g==
X-CSE-MsgGUID: 8iQZFYLHQ/SjkUK+0oACsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="91624663"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
 d="asc'?scan'208";a="91624663"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 14:07:46 -0800
X-CSE-ConnectionGUID: aBMC8cyyRaOBoN+dxdADIg==
X-CSE-MsgGUID: DIIX8BCRQN+QLhYTVYffrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
 d="asc'?scan'208";a="192999533"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 14:07:46 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 14:07:45 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 14:07:45 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 14:07:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyD2A2OBkOjajTay+XKeyB1xGSerpg5DGzDidh56ArchRtEro4q6JoRxQiBaDn8JyH/aMR/natKDuwSE1zPfsOjauy3Zii7l/6EF0PlZMW2JT3d2dCj/W4jqOQeZ+jWWMdxpF+ftfpRk83Ymx2uDa6CdBNpHGCvsTm1XpYk8V+ZpHz3VojrEVG40nk0QNAXtS8da6XnEs+uwviVqwe5LGxINa7eBNFfabsZRqwhvsdkkO08+tRl++37BgvP1bsR5ubpZpb2WZO/I/PJVFTZlEfzUU1wBmvI3SDj8awl62WrRhe6Abh0XW1VAZdvvkeNSHXGmcqnm6qoqhuijYsvuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxdhlBimu22dJdEA7z0I4iHr6zZbVI+HKkXH9Yyfzbw=;
 b=TocbJnnZXVM4WZM/42O6LOedlLBhwkUtwiZseYwMaxubhMBbFikgp3Aq+wnz3tu7/mZ9xN60utHF2Vd4jb7tuNulBes4JyuXXcsnAtjf5T7t7xz5vd3RvUCQqRYzaxhO0gdtQZkJfyKCiZLoqkHgm95bh42bdTts//REeL+wyd4lnB06fKudrkKJe7BIJSk0I8NOI1gfNdGynEket0QxdZiKk2wsrZ5u55QiXtv6oqJI/GaNUOgcZoBbmqfwAb/ELAhrkaimnrg/CAPQrmUoI2yC1hy89SGerYWQwPtQ6HyJZY/z9aNHyNPQIuWQ8I18MJYrRvx1KseJbMlUx+3czw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB8456.namprd11.prod.outlook.com (2603:10b6:510:2fe::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 22:07:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 22:07:43 +0000
Message-ID: <47850b29-0ed2-4a24-9047-e73905657535@intel.com>
Date: Tue, 25 Nov 2025 14:07:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/iavf: check PTP capabilities during init
To: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Greenwalt, Paul" <paul.greenwalt@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Jiale, SongX" <songx.jiale@intel.com>
References: <20251121-jk-dpdk-iavf-rx-timestamping-fix-v1-1-21c9a337a6f2@intel.com>
 <CY8PR11MB774717DEAC152077562DB837F9D1A@CY8PR11MB7747.namprd11.prod.outlook.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <CY8PR11MB774717DEAC152077562DB837F9D1A@CY8PR11MB7747.namprd11.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------LOfbErn7oGKed5jOFAXZ3uWY"
X-ClientProxiedBy: MW4PR04CA0324.namprd04.prod.outlook.com
 (2603:10b6:303:82::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 75641965-0646-4078-80c5-08de2c6f0e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkt6bDBNQlBYSTREdUtOSmp3VkZEYUZTd2tXdlpCUFkwY3JGUDRsV1dzNTd2?=
 =?utf-8?B?czhIZzNOMVZrZkUyRVU5N1Nsd1VwRnBEbzViOTRpMVlyUVB3cXgzREZ5Q2xm?=
 =?utf-8?B?Ujk5VGhRSzNZWThoNVFxZFdGbE1Zc2ZSSXNaNFYyRzM3YW1Bd2poaDRscFdO?=
 =?utf-8?B?bDRMMENRdmhDMHVoQ1FwN1pNeXMzekZqTXhLRHJmYTRMN1VjYkFIZWpWcVc3?=
 =?utf-8?B?aWU0T3dYbExLVXBJNitJd0c0R0dLSkVwcHdqZ0xZMzZDNjMwRnJsNG1DSFov?=
 =?utf-8?B?ZGxPYW96RU43c2thNUV5Ykw4WlhOME1JVkpQOSs3YXdHYUtyL0FvTjAveUdq?=
 =?utf-8?B?d00yR2UvYXIzcHJHakZ2M2xtc1lycllkMHpCZmZHc3lDVmsxS2doZitnRHFM?=
 =?utf-8?B?Tk5BeW85aUVNTTRoQW83aXNNWGdUenJRaENxRVdLNHV5cE1BMk1sa2U3dkJj?=
 =?utf-8?B?QkRWTFJYRWdnL3ZldDllMHY1QVJjdFE3WndwU1VvTEREakg3VmYzellRemVq?=
 =?utf-8?B?SUZ3cVJLbHZjVmpsM0Z4SStEaWdCdWQrcldrWDFWZXNtYUlhZWh5U0w2am5M?=
 =?utf-8?B?aENRYkR4Tm1vQStSNzdUWUFPR2NYc0x2N1BwdW1hc3dLRE5TckNLamFKcXEr?=
 =?utf-8?B?aWRKRUlQc3pUOFA4WUUwczNyUG9JRzgwNjFsWklwSGFNWDN4ZEJpeFg1dUtS?=
 =?utf-8?B?VmNBaHZ2cENHbmRmelpxSFF0VWpOS3JaSGR5eGdyZ3JqbWxPelRFeDBWckRU?=
 =?utf-8?B?bjU5M3paRlMvSjRqV2swdkpuNUdZRGdNQ1BLQW9XVjNJZjRDeUI2bW5Zc2VP?=
 =?utf-8?B?SFRBakNjbTZXZUhuN3AzYkJNWjRlUXdjdjdzU256TmdVV04xNy9Na1JNVWc2?=
 =?utf-8?B?VTZGbnRxaUlsMkpSLzgyTlJmRG5KT2FpUGxZK0hmWkg5OExpVmJweDMwWmNv?=
 =?utf-8?B?djdiTG80cGFQdkloMWllYld4ZGhBa1crMURTcncwcVoxZVVZMHVJWW1XdkhS?=
 =?utf-8?B?ZVNDd0NpMU81a285azh0Yks4RkpzNXR0YURiMUVsOUVtWUVVZWttbVMrbFdN?=
 =?utf-8?B?OERFQnlNQ2tNUXNOeDh0QWc5US9tQnJ0SXlIdDFZQTM2MU9mbHB6ZGY1SXdv?=
 =?utf-8?B?aWlwOXgwNDJwQThpTlFMN24vMEVrTjVGaU91NWJBQUV1SVVBQ3BrUnE2V2VD?=
 =?utf-8?B?S1pNZ1EzMnI1blozUDlmZ3k5WG5JYlFsRWxGQ0lDY2lMdnpBTkZ2RUVySWxL?=
 =?utf-8?B?QndDeDBNYXErdDROTVBQcHZxbVpFMVBacEg0b0x2azFHVFRmQ2pkOHkzaWt5?=
 =?utf-8?B?UmsrbVdlUlZpVlY0cWlqOUdSNVVmNGpaT2gwelVOTCs5Q2ZwTGZJTzlZbGtr?=
 =?utf-8?B?dWI0VzYvdmVxTHVFUFU1TWsweW5CTGxIRWRBaHRSL2ZJRUlCbU1WYWk2MlJC?=
 =?utf-8?B?RTJFMXVUMTA5UE44ZHZxSDhnRHdiNGliM1V2cjZmOGp5L0FhdEtTdkI1NEFv?=
 =?utf-8?B?N1FrMFRUMEtLa0U0bGM0Y3hnNkNwcjlwS0lZMnFpbCtETTNFeDVoU0Y3dGto?=
 =?utf-8?B?VFZ2NmtzNStHeTkrQmtEM29zV3p2d3NJRmxqYTlLVngwMVQrK1hrV1BBaUYz?=
 =?utf-8?B?Qy81MVQ3aGFObllFRTJML3doSEJoLzE5cTI1ejRnVGlEeWFOL2lhN2k0alBX?=
 =?utf-8?B?c05tUWZScUMwWCs0eDBvbDM3ZGl1ZVBxTVNrTk4wbzgxQlRTSU1kOFlCWmJv?=
 =?utf-8?B?aDFPb0k0MUVCa3lGd0srUm9uTVZTdnl2OXZGMnkrU04xMVQyK2VWUzQ4dTRi?=
 =?utf-8?B?T1ZidHEzeVZjQ3VtemFvSEs5YTA2WkMvNlBkaUt4bmhKVm13TFNnSitwei82?=
 =?utf-8?B?QkhtUlEwK3YyMnBwTlg5K2JpSFkwMEhuWllibURHODVuQXFwTXl6THVpU0VH?=
 =?utf-8?Q?2RwL8PYfFTrendiIMA52L0tLiQxn77+y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5089.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3JOZnU1U0JMWi91UkFzUkNLN0g3TEgyZVl0Y0x3TGRhV003dEpCeWVDV3Ni?=
 =?utf-8?B?cTRTZysyVHhhaDJnU1NZZm9BK1RscjUwWkQzeUFSTGhxSlYzaTNJbTdtRzRk?=
 =?utf-8?B?OXd2VHovT1NzL3Y2UGVrVXcyZ1pybXJDNEsreEFyNWtaN0t3NE9teE84ZGIz?=
 =?utf-8?B?S284TzAra0ZON0MrUzE1NFFlUlc0QVpIVERhQnd6L2dKY042ajRNRmNYMGxW?=
 =?utf-8?B?ZFlnRk1ZOWdTMUhIZk1FNHhUZEMyRTRKMTVuSCtxcUZ6NzhhaFM3Q1ZudG54?=
 =?utf-8?B?azhSNm1DUENlbUJuZlFyTjB6TDhxVU5jdVhTVWdzSHVVS2F6ZmFiN2NGZnQ3?=
 =?utf-8?B?QStQSnBxenRFODFML2s1MTFnVXhva2VmZEhubUtsL0lmRUo1S2Qvdk1uVkVB?=
 =?utf-8?B?QzBSMDd3S2hmaDNMUVpGREtOd0RrZWJHTStEOHZoV3hXQU9TRGN3dy9HNTcz?=
 =?utf-8?B?UU4wTThuNDBacUlaanVwVnhkK2hyMEttbGZPazZFN25tYVVDb3pmUjdMeXdL?=
 =?utf-8?B?ZTRJWW00VkVoRmhsbmJiQmE1MGJWOWszREx6SWpRRTNJa2lFZGMvaXhMUU9C?=
 =?utf-8?B?NkpqWW1zNlVFR1JodnFJMEpLSUYvY0gySFJ4UmZ0Qk9OY3krdTFmRnlEeVVI?=
 =?utf-8?B?bTB6UHorNmtxVUhFazRHMU44ai9pRWxpcmpSSm80dDlCRXIyUHNYOEpXVlhp?=
 =?utf-8?B?M0F2UllRRjZWWmxPUW9iSVdlTTVXSkloemNmcUFuaTkrRTN0RHFsNnE3eFBG?=
 =?utf-8?B?L3p1RkJUZXZYSThFcE9Ham5tbSt1cEVCcEYvV0JidHVmb1V6UEQ3SWJadld4?=
 =?utf-8?B?ZG9vR3laZGVQT1hlRGN2RmVZZmNwQkdqcmI5RUJKWHdZSzhTSDd1QkdqZzVy?=
 =?utf-8?B?M2I0bUk4T2o5U2tKU1JqblZhZnVjbnpEUWNlTkdyb2FOeHAyZWE1QmhDcjlK?=
 =?utf-8?B?TWdBODAyeHFndXAwdXF4dUVWT3gwWHdQaWtIbGU1MEtwN2RPNGxqcHJLZld5?=
 =?utf-8?B?blR1bU9lZWMwc2p0cTlCZjEyaVQ2amZvcVJ2a2ZtbmZ6WHlFOStPWTQ0YzZ6?=
 =?utf-8?B?ZWl2ZXRlWVFZNkdUdW1aRmtKUm1hVmVNSGFCbTlSMWNFZzJLK1FTdU5QS1BZ?=
 =?utf-8?B?NVJYQ2FobFIzQW9VQkxHWnJFdU5LRjllaEczbGVSSVo5N1ozbnpmYitiWG91?=
 =?utf-8?B?MGMwUTFEQXJ6TW9BVHp5SXhBSFNQaGt0STIvSHEwejhWWEdZazFQeVdadVNU?=
 =?utf-8?B?NjlsanB6cnZubSt6S2xBYzE2Q2o2OFRac3YyajhvTHNaUWt0bEFyZnZRcG5E?=
 =?utf-8?B?UzV6S3RoSU5iU0ZMZHZzWW82WWFyTkdqZW1QSU1YRlo5Y1Bqc1hQYTNZYXN5?=
 =?utf-8?B?ZXhLYjREL0kweWxkQkRNeUxQZjAwdEo0M2xjNElISVl3cTJFV0gzMWxvYWhz?=
 =?utf-8?B?ZUw4OUVONk5hS3VrSkdUVjVhN0pFT096TVZEU3lUSEh5RmVXMGk0VnNWamFa?=
 =?utf-8?B?UlBZNzh0ZW8xK2drOHZSQzRTMHgxU3U2OGhWQ240c3Vza0dVMzJpdGc3c2Fw?=
 =?utf-8?B?VXdoa3dnY1piZnRsdjJZdnc0WTBEanJKcVBmQitPLzN1dm1zdWZ0VGZlaExm?=
 =?utf-8?B?WWIxeFFvdXo4SUVINGlCMGt1WXJXL0V3UVRMbDNxV0U0Tm13NDlxTHFRb2dw?=
 =?utf-8?B?aFRpWENNNTdSRnZJbE83QStnMGVrMDc2ZU1US1NLb3VQcWtndkZlRi9vdk1m?=
 =?utf-8?B?SlNHYW1xdGk4azN2ZlQzUzUyOTVaUWNta1laN3NROXlUczRRRnFMWEZDZm82?=
 =?utf-8?B?RVhIc1lWbzdUOHpMK2txRHpRemxtVmh1ME1ONGFvUWk3TjkrWjRyLzVnaVBZ?=
 =?utf-8?B?UVE1S1Z0cnpPQUd1b3h4U1VXYVJVQitsR2tLSlBuUk9MWjhwL0RWMmVOV084?=
 =?utf-8?B?ZHFTY25RVkhMMi83aUQ5eERSYVNlUjd1eVZicm5XZ1lLY3VFV3pYS1g3T21h?=
 =?utf-8?B?RU1JWWlmWko3Y2R6c3RYYWlZUXIrV09uN2JJSm1MWjhEYTZzOWpBb040NUF2?=
 =?utf-8?B?Qjl2NXpVdWlOWFNzRFl4dVZRN0pkMm0xNTdSbzRUMFpUU2hVSW1YYnJwQmZy?=
 =?utf-8?B?d1FLQzYrTlFqTzZMTmkrQlFPd3BjaHlQdXdJUWtaR2dBNDNNU3ljV1EvK21y?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75641965-0646-4078-80c5-08de2c6f0e8c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 22:07:43.2715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTFKmpVm9L04RltYJ60soN86js+LCsXmfMkyKakTcf/CX6ZcKfTX4R8oZ0ngjE5O4qymXNYnhl/ey3heAkLB9nhY0SbSK290O+WDG74nhuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8456
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

--------------LOfbErn7oGKed5jOFAXZ3uWY
Content-Type: multipart/mixed; boundary="------------uq24CY9W1f7X2t6FyXObr2f0";
 protected-headers="v1"
Message-ID: <47850b29-0ed2-4a24-9047-e73905657535@intel.com>
Date: Tue, 25 Nov 2025 14:07:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/iavf: check PTP capabilities during init
To: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Cc: "Greenwalt, Paul" <paul.greenwalt@intel.com>,
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>,
 "Jiale, SongX" <songx.jiale@intel.com>
References: <20251121-jk-dpdk-iavf-rx-timestamping-fix-v1-1-21c9a337a6f2@intel.com>
 <CY8PR11MB774717DEAC152077562DB837F9D1A@CY8PR11MB7747.namprd11.prod.outlook.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <CY8PR11MB774717DEAC152077562DB837F9D1A@CY8PR11MB7747.namprd11.prod.outlook.com>

--------------uq24CY9W1f7X2t6FyXObr2f0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/25/2025 2:30 AM, Hore, Soumyadeep wrote:
> Hi Jacob,
>=20
> Currently PTP features are not enabled in DPDK. We only have the Rx tim=
estamp API in place. Typically the change that you want needs to be imple=
mented in ethdev_ops.timesync_enable(), which is not implemented.
>=20

I'm not sure I follow you here. For iAVF Rx timestamping is considered
part of the PTP capabilities. We shouldn't be reporting Rx timestamp
offload if Rx timestamping is not available. There are some
circumstances where the PF will not report Rx timestampding (and will
not enable it) because of capabilities mismatch. However, DPDK driver is
saying Rx timestamp offload works, and trying (and failing) to enable it
in those cases.

However, the check for where we report Rx timestamp offload was before
we negotiated properly with the PF, which is what this change is trying
to fix.

This has nothing to do with other PTP features.

Thanks,
Jake

--------------uq24CY9W1f7X2t6FyXObr2f0--

--------------LOfbErn7oGKed5jOFAXZ3uWY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaSYorQUDAAAAAAAKCRBqll0+bw8o6EGG
AQDUSeGnmKS4haRp4L0eHXB/olAXp7rlg8eEbrjRXmj1owEA4dVrz+XKnCSVF5x9Zxh4FEXLmj+F
XfrZ+P4T1NEjmQo=
=xgzL
-----END PGP SIGNATURE-----

--------------LOfbErn7oGKed5jOFAXZ3uWY--
