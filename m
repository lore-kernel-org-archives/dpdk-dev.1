Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75214C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:12:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC4FF40661;
	Mon,  9 Jun 2025 12:12:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 9648A40658
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:12:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749463970; x=1780999970;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=HkRBBqISWCW+kVCLmekcLzx+xNuh6m5rlhiwBEtQ19c=;
 b=L6zxdf0hxsD3wr+oerKnj1p5VuNHeb1NwYPASZiM+cjNMkYXjOpzKlk1
 t2n79ZY5FlIbKX/iUMacptWTiLYBdcckXubxfmPZunp9HjDW3mUTZyx85
 A0kY/89WJPK1wiRucpRdXtDwnrh4aqHHq+6WfgjShUsO3K1cx+zIIiQlt
 hJnyXg1ND7qyxKR/yAZWA9sioTSS/HitNpVlRRqpPnlEl1zC8q2uIy+R4
 BOnE1i+/hNPZdlIIjubUbzUQCZ9sfXfiVezKJfU231at0KNMF8AU9XYhx
 YyIuEkUav14ve5YexEeCCoyZNDVh0fqjCgI3+tlAMEa2o0Re1Tw8iVbRk Q==;
X-CSE-ConnectionGUID: n7zZogbORjK6X1OraKYJUw==
X-CSE-MsgGUID: QlSb8ArFQKmKDOyZBlWFwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="62150644"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="62150644"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:12:49 -0700
X-CSE-ConnectionGUID: Ypwkm6DGRTOacgQ4DQyc0g==
X-CSE-MsgGUID: 4Me96qQHR9W+D/LpVOeZQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151467237"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:12:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 03:12:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 03:12:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.57) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 03:12:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGhZNPWKsi9mPoEQwJLDBrHgfjYEQxGvyz8Vny0+ImAkf+4W1C44M1peLVK3eNjw6Z5eAH3QF4wROD+lWWcqqD6QxnKQ4OwrDXLKw0HYa2y0/CxabtcJY3VC/u8Hvu2GbYPdG0P2616qfxZlZTmzJzdUNVDWvLycO5nwzy2RCnSM5FG4sp79nEpGjiY5EVGTjrjR47eWFJEcebxjn3j17IV3OEUj/v5T0LqdK4UMzAEbF3bJz17FBdAobQODNmWI2IKJTe2+o/q7SzkFzrZBK942yuKCnIOvd0IQG+0aQJJ7Zzi/+4gXzzQwnDFFTH7bXLSQ7VqyYoW13JI9+mS2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAWRSuynvNq6Q25Fk+HdBtVx6R8NW4Nm/EvcFpQd5Us=;
 b=pXBcfBDQRXEAHp9eomTHspl1B6z8lWxfRZe70+NqVQ1QV03+BC+JDC0nWYF7zLY5oSr5w3qK7XhT8++rMCj7wRJGQvpUMHkbe6Sm4Zd7KmbCZfqYL4cfdeqrVzr8yLa7YmFeU6652hyqcYF13P9TpkyradJENZlPi+oTbMKOv7RxNagBI6WntrNJ0P/CiM6bD15IJvbTwg6BBcJWSWnAe/IjeyUonwg/fdqbemYFK6aFKfAKGLCZyV75UagUUgN/yeP1IKA9ct/gBlXHJ52sZOIw8+4bSB0F4OzyyuF3xPIJ3+3s6RuuoG6tj6L9Jf/DedOikE/UMt6vGO1BsqVVxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 9 Jun
 2025 10:12:31 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%6]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 10:12:31 +0000
Message-ID: <4d8da5b6-10e1-465e-aac0-b353a8f9cf4e@intel.com>
Date: Mon, 9 Jun 2025 11:12:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc/contributing: remove obsolete advice in coding std
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20250327162839.2472573-1-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20250327162839.2472573-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0037.eurprd06.prod.outlook.com
 (2603:10a6:10:120::11) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|DM6PR11MB4754:EE_
X-MS-Office365-Filtering-Correlation-Id: 097dd904-664b-47b4-b0d8-08dda73e2543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3F0eDNnVVk5cWRaS0o2THVzQlp0Y1d5R0R2Q3lHcERneTBybys3WUVRMmQ2?=
 =?utf-8?B?dExaUitmdE5QWXE3QS9tMloxRFcrU21VN0ZwZStjVmgyMUhXRXpCS3JnZ29n?=
 =?utf-8?B?SGhKK2FlZ2h0UEV0TlZxNGN2eEZaTHkzOHBDdVljRkhmTlZlOWZFcWlQdjNS?=
 =?utf-8?B?UWVrVzVBL2c0ZUNTaDZ0NG56ZWdqTkE0R0lKVFJhMVhMV1VYUW9HQ0VXb1pv?=
 =?utf-8?B?T1RNWFBMSmM2RHQySlZMdHk2L0RadjdSLzEyUnl2Z1JXWkNicTZwMXZSZU5Z?=
 =?utf-8?B?alpueTQ0NGhySWJRU0lpemp5cEkvTGpmVDFOK0ZxNTVBV3d0SjVCdzBLUlJ1?=
 =?utf-8?B?QmxzYjRFYU1OY3krVnQxSEl5dWNJQ3VaaHFwVjR1ZmVYRVQwVXZDYjNOV3NT?=
 =?utf-8?B?c09OaDJRaGF6L2RSbGlYbkJ4ckJIaCt4MkZjTjRQRkJkTm5PcDFrUlczQlU1?=
 =?utf-8?B?TytBdzhia1dreWRtTitIU0VaMXVvNnFINVBUZGRCWmhyY1BOVWNrWnoxanor?=
 =?utf-8?B?U1ZjZTdpUmVlVmtEdGJjTkpYNzB4aFcvc2JVOEYxbjhhOVZBbmtjNURkVHkz?=
 =?utf-8?B?U3M1K01qeDh5RDlTRjhkT05GVmFMbnd4S0tGa3RCVFlEZ05kZU8yUlJUR3Fn?=
 =?utf-8?B?RGNjK0dsUTJMQzN2RXowNXM0RVl0V2pFYmJ5aTlxbE1ZVkUxWFRvSi8vUitk?=
 =?utf-8?B?NGRpT3VVVVBhNitkcWRnS3E4cUE3c2NpUG9vU0hJaTFIcmJxZ1V3OEhad0Rv?=
 =?utf-8?B?MHhUaUxnY2tvaTlJL1B1bWs4VE00dE00RWJ5eHk4cFRWWS9DajVXeHNwSCsr?=
 =?utf-8?B?VTBZeC9MU2l6b2hDUFpkSmhzbDNybEc2UWJ1RE5mMnZtRHRPZ1k0QVhQMjJT?=
 =?utf-8?B?ZU5Xb3Nid21nLytZbTV1OCtya1BDaGQ3V00zV25DZkkxakVNWU1XVGV2aWxS?=
 =?utf-8?B?dk9JMUtyYzhjZXp1UExDWnFlTElNL0kyMlhMUHVZSkM4UWxOL3AxYW1MUW1X?=
 =?utf-8?B?T0xKWDZqQjh1dkhwUWhSTmVwSFh2aGJxREppeUpqUEN0VE5pODdrNm1uSFlp?=
 =?utf-8?B?dUpjMmY1cUZCNnVXK1dNeDVrQzlnL0FqN0E2eENFbjRvMjJHeG16b2w4RzRQ?=
 =?utf-8?B?MUJWajRHZVdaUUJ4NVVoYUVjQ1pwYkRVU3QwT0RXcTB4ZHlsd2ZQVEVaRmJr?=
 =?utf-8?B?aGdZUVpWM1JlMWxTc1Q1WktGUDNUb25rMGFMQTkwYmowTU5PUHMyS21QRGh3?=
 =?utf-8?B?VVNHYVZmcDRQWi93NWQxMGtQSHhoUXJnSVk5OEFrMzdQbG95K1dnOE1taTBo?=
 =?utf-8?B?N3A4eU1rcFYvN0VPOXBrTDVTVXgyUWx1UWJvUWg3RFRodDFRWW8zeGhST2sy?=
 =?utf-8?B?YVZkZEhJeE45SlZtUTRjV2xXcXJ0RmVoRUJCSGJRQkxjYjZhNk5TWmdmenJE?=
 =?utf-8?B?Vmd5WWF5WWFXcGEwaWZvYTJxM3Y0cUtYOW9MQ3llY2szeEgyRko1MXo3WDVh?=
 =?utf-8?B?RFJ4aTg3aTlEUlMyTFpYZzh6VTBwbVBHVXF4QnNKaFY1RVBGZGk5VWxsNjZ0?=
 =?utf-8?B?Unk3MUh1SXVuVnpZRmRoZUUwT3c0REhXTUU2YVB4cEp5SzN3YVJEczNGaUFP?=
 =?utf-8?B?dklpem5zMU5ZWDFaYWMwdmwrQjR3Z0NKZVN4RFQrMWZha2lVV2UxekFoUk1D?=
 =?utf-8?B?YTFObTkrN0tGQ1lwV215NDFlWTVkdE5kR3MxcjZ0SFJ5R1duSEV6VFJScXl3?=
 =?utf-8?B?bnlWeWFNUFh0cnVhVGZDS0JlWUFQVzgzMlFZaEZpejkxSHlaOXBPd1dSdmsz?=
 =?utf-8?B?V0lTVTBQaGdlc2tXcG5IMVhjSzNBOXJCUVZLRkhiN3I0NGlocDVraVJFQlU0?=
 =?utf-8?B?OVR4SUl2MEJhSGwzS3VSSUxYb3dzSEg0MGxBZEFzeG00QTE3em92Yys3Q3p5?=
 =?utf-8?Q?5f2Da+yF+L8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTRTdnJmMnZwUnFPWlFWdnI2Y1pNSEpIRE1KbkRCN2gxMnB0a2RERDNrVXdP?=
 =?utf-8?B?emNMVEdlVENwTlFrMllIUGFnOXdsdG51eHZBQmF0MVFReEhWMmd3SVo3Ynp0?=
 =?utf-8?B?SkppT3UzMVhqdHJ5UVFnditaK3ZYcmhVcW5sbis5bU5QVDc0T1Zod3phRy8x?=
 =?utf-8?B?cmdDbzZlNHN4MzNiOHgvbDUrMm8zZFkrVzJ0TlVZSWtKZ2xMcTZYeWZjWTdO?=
 =?utf-8?B?c3UvNDZDVklONHdrZmZpclZwTUdEWGZ4NFZvMm9HTGw4Mm5ldytSYXNUaVdo?=
 =?utf-8?B?cnU5VVBLV2N1bEc3RjFCdkpqbFJOWUhaYkQ4NU55SFZxWlVCWWdjWnExQTBq?=
 =?utf-8?B?WTVTSCtNRGpNRFAwSVdIMG03WEhwNWJiL3pZWDVmbGdpYnF2ckpGT2FxSG1T?=
 =?utf-8?B?SHhKL2VnWEg5OE83bWp2U29sY01OSm82bnFYRkJXTVVzaCtaWWR6U1lMMnZz?=
 =?utf-8?B?R203TnYya1daa21ucnhLQ1JRa0Y4M1h1NFVreHIwN1ZSMW8vQnlxSU1HSTg2?=
 =?utf-8?B?azhKSkZUV3B1MTRMZHhULzgrdDNWYldKRlVlK1pJVXowVlRUdmZZc2ozVWNx?=
 =?utf-8?B?Q0RiOW5za3AxeUthdEQ1dmhCSjEwUXFGTGh5YVZLbjdyaU94QU4ySDg0aEpk?=
 =?utf-8?B?MXBobXljV1k3TzkxbnFLNUVEV3ZldHRPWlFaTGxYbVF5K0x5QWZVV1VOT0ZM?=
 =?utf-8?B?RUJpS0xsNm44ZlZVbGIrVS9ZQmtBTDVUTHFrTzNuU1l2OG0xVys3eWtrQTI0?=
 =?utf-8?B?N2tpSDZwbUZrUXdJR1cwVUNUS1gzZjNhZmRIVDFYQk85Nnd0V2pSK29lWHpY?=
 =?utf-8?B?TSt3K0lYUmM4RFRDMEdCdytLNThqdGt3ZjlBRlF1TW1PR1pPZDZSV3p6VXhC?=
 =?utf-8?B?Q3BvRytDMTZGdkJvUFlxVlJPNzZNWkExYTFWeFZnMGM1ZFhlcmg0QjhPVnp0?=
 =?utf-8?B?SnFQT1FmbjhPMEhCaWRrMzRhNGRRZHdSVU80R3pNeUtuajZSUk1XZGdTT0Fa?=
 =?utf-8?B?Q2NUSXRHenVmVE9zTzNFN1BvOTZDWUE2YzR1NWcyWTZBMm9XWnczSlBiOUlE?=
 =?utf-8?B?Z2hSRWUwM1ZjaUxCOFM1SWpnNGFFekxoMjhFSmUySGtQVzVOL3VhTUREL3ZY?=
 =?utf-8?B?WDZPa3N5YVk0b3hMbWZncklRWHE0UzhSMzJ3a1p5Z0FwNXRBLzlZalhVQkhh?=
 =?utf-8?B?OU91WjBiYzJ5SWk5Y3YzUkF4NzRWR2JwL3hzR1ZSbStLY3RRM0kxUHRPYTlj?=
 =?utf-8?B?djkrTlppSkkrY0lxekZRa21lc2JJSkJ1Ni9CdUcxTlV0c3U5ZGlLT0hVQlpD?=
 =?utf-8?B?WmZaM0NYZEZqNm9qNE56Z3BMNjF5K0dUcEdXRGJmTjMzelRVZGJXcmhIOXNk?=
 =?utf-8?B?ZEw4eDY4RExzR2tHR1VTWWg2QjdER1NTUmpQcFd0SGhSbis2bkxrWStrcHVE?=
 =?utf-8?B?SkRLRU9IN1J3cFJqNGhENXlVanljRVpMRUVTcFVVaVk3TTIzTXJ1VWo3R0pl?=
 =?utf-8?B?WjJsZDBVUU1GY1JkS1Q4WHI0SXUzY2RlV0JIQUxaUUZVNjJUN1liazArbm5B?=
 =?utf-8?B?Vjl1RGZzWWtNTkdweVFWU1k3eURjTzlGa0VJK3A3bDZ6Ui8xOTh6aENqdEJQ?=
 =?utf-8?B?aUIxS2lrcysySVZnOGtCV01uVDRVTThNbDNBeHY3NTU2M3VWeXFjYXFmNS9p?=
 =?utf-8?B?c3R4VHdmcWxUS1ExcmNvb3pSUklIbnVtR2VqZGRLaG5xUDl5N1ZqSUc4eTN1?=
 =?utf-8?B?T1IxYmpyUVUrTUg1Y3ErUFUxb04yN1dwREdrL3k1bGQrL0pQcEVJeFNwNTdE?=
 =?utf-8?B?cmVHaTdObjI5bkIvY09uWk1VRmxnUVFsT0ZIc3hQdjlQZC9uTkJwWWJuSkky?=
 =?utf-8?B?cmxpRGhXMFg0d0dobitXN09iRDVYQVNEWkU1MDlOa1VJd3BRYWhtY3NsZ1VW?=
 =?utf-8?B?bklHR3NMak45RkI0ekU1YkphUDVKdm16Q1lZQ1ZyOE01aTFGVFNYL3BYUEhx?=
 =?utf-8?B?S040bGJhLzFRYS9ZQ3NIQkU0OXA3cUNKTGY2djhYMnlBaHZCRHNFVnJiVlBB?=
 =?utf-8?B?azliUm5vcTRNY1ZPdHlXSk5EZE81V0pJVHJGY3loZjF0Y1R0Y3hUem5MaWZk?=
 =?utf-8?B?aXg1QWlaci9yeWc4YUlhWjZSRkZCSFA0ME12RjNuWFFEMU54UVZaeUYrSG4x?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 097dd904-664b-47b4-b0d8-08dda73e2543
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 10:12:31.3722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0EarKyFmreKO6OxjhojXSgHK9j8jRXx8kVqfsybjKB+U6Mj3RNBz/2pO9DMb2AiQ1cMedvNBeLHQ8x6MqPC72F7jLhNFCY838nnkFvgZjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
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

On 27/03/2025 16:28, Bruce Richardson wrote:
> Remove obsolete, and generally not followed, advice in the coding
> standards doc, around local variables.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   doc/guides/contributing/coding_style.rst | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/doc/guides/contributing/coding_style.rst b/doc/guides/contributing/coding_style.rst
> index 1ebc79ca3c..0d8821b325 100644
> --- a/doc/guides/contributing/coding_style.rst
> +++ b/doc/guides/contributing/coding_style.rst
> @@ -556,14 +556,10 @@ Exits should be 0 on success, or 1 on failure.
>   Local Variables
>   ~~~~~~~~~~~~~~~
>   
> -* Variables should be declared at the start of a block of code rather than in the middle.
> -  The exception to this is when the variable is ``const`` in which case the declaration must be at the point of first use/assignment.
> -  Declaring variable inside a for loop is OK.
>   * When declaring variables in functions, multiple variables per line are OK.
>     However, if multiple declarations would cause the line to exceed a reasonable line length, begin a new set of declarations on the next line rather than using a line continuation.
>   * Be careful to not obfuscate the code by initializing variables in the declarations, only the last variable on a line should be initialized.
>     If multiple variables are to be initialized when defined, put one per line.
> -* Do not use function calls in initializers, except for ``const`` variables.
>   
>   .. code-block:: c
>   

-- 
Regards,
Vladimir

