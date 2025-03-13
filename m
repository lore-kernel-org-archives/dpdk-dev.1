Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6C3C28B28
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 17:51:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B18A34114B;
	Thu, 13 Mar 2025 18:51:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 35A2241141
 for <dev@dpdk.org>; Thu, 13 Mar 2025 18:51:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741888268; x=1773424268;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=ti8oH/8P8BZCRUmqosQDyzLXbUsCsLMqAzIAO4kX6mk=;
 b=YAvzbJShW06S+D/grmkk9qb6oXTxwPCNhN37sfY/zWD66TTZNpyl7JTC
 8bj/acFzr7170L9ZXVLPLnFFKs0b9RUnEn1E+exL8vH98cOtZi7u5CKrs
 AM7UurzF/w0gEhwSfK3YCa7/niumor/5fipmObc4htWvwyiMP1XPSGkRr
 BtTJ419ETiFMY/wy1UUNHK5y7Ao9oeT1X9N/fzO3LA3R+vo/pBfmXmbuN
 sE4MhaH2zXvAzRiTiQ2tcwD9G2Do7Ps7xoJTCCUeH48jHSzAvidtNHjvx
 9lSATS99oUgsbIwzmeCdxaIL/vkj8ljq8SQVM3kTFp8HXxERQIE8p+08J A==;
X-CSE-ConnectionGUID: 6dBxpzJ3Sg2ydHZ60KkSMg==
X-CSE-MsgGUID: YD1hRCTAQcahvk0DpmipWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43125055"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; d="scan'208";a="43125055"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 10:51:06 -0700
X-CSE-ConnectionGUID: N9bmyAwjQP+ETibpIHqIxA==
X-CSE-MsgGUID: V+AvmYz4SqWS3rHP/YIsiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; d="scan'208";a="120815748"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 10:51:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 10:51:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 10:51:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 10:51:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOFBimKvZ4/IjL2AqHLJcnqFOEBTVGP1ZlzJBX8EaFkQ9LjkJQe9GRytny6Z6dA8ZxEuFXno7iCBwsDvzMPoqJxVhhozsXf8EnsUn5/vo8MNupd7ZQs0nk1pieFE1/y0NUevlIbY3byNog3h+vOCDdFky4FRNtrFUuW2k/2fA2iMRdNGx8PRku9C30tLYhn2YFS/zbijMJe0OAsG7mztEK/KWuwicPweUc9XTWYvIkyKt3NfUlaoRE5S8FDJQHUQClYmBcRkfFoiW4oZP+/8ZdsizGwulQI+Mhh3u29t1M2FKENdnEeVYdw3L6WCmNhoVdnS4kjVjr0XLnylSiL9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP3Jjm9b21bjsOEoxMTMR2dlXIFuYuuCxuT7cEET19Q=;
 b=qNjWzu3u1SB5VA7nmt8NMLv7wXE5IIKryVZrrrSWTMzMvgPUbwQW757yRiMKKX5vMycDBgslqsdQnahx/YjO6WtO0sJSOe1jJTK5K0nUIlXKfRVQkN9YM8jDulf57udRDD6GGP1JC5zm14taIRun+zMhz/HE/zlQsoX4H+8chz10REE+ODSKZ4P22t9tnSmieq7VKh+Ioxugpn1pSwcetYEFXrR2WfW3qhtKlp85j1x+WRWylQxDz0nUc0sZMYssPGfe3LACRDlrn+iVxPgl0Uk90lCv0PcO9dmb5tKnh//NJvEa27XbF7STt7bcEquZtzLstNJYgmOEQRuz2kA8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8)
 by CH3PR11MB7370.namprd11.prod.outlook.com (2603:10b6:610:14e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 17:50:59 +0000
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b]) by SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b%5]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:50:59 +0000
Message-ID: <877bda27-4f86-4c47-8f78-f7fab1c20d34@intel.com>
Date: Thu, 13 Mar 2025 17:50:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ice: set flags while adding vsi
To: Matthew Smith <mgsmith@netgate.com>, <dev@dpdk.org>
References: <20250311214031.2217808-1-mgsmith@netgate.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20250311214031.2217808-1-mgsmith@netgate.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0041.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::21) To SJ0PR11MB5772.namprd11.prod.outlook.com
 (2603:10b6:a03:422::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5772:EE_|CH3PR11MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 73fda439-2f63-4780-dd6b-08dd62579cee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ai81MnBGazRMUTJLRWJMK1liRHgwVkF3ZTJ5cXVjS04yek1udVlOMVZNOUs0?=
 =?utf-8?B?YzhPWDdKdW5EOU13eTZ1OG41THNVZDEwYWZVWFhhbS83cFAyUG5ROXU1Ty9C?=
 =?utf-8?B?YmRwQVdyTWh5Vlk1MGtveCtwOHVYNDRyc2ppOE81Q0VJcTVCTTRsaG1wZnpr?=
 =?utf-8?B?d1VYQldLUTY3NUF5RmFFaDRLUkpqSTkxYUtYWHJZUVFTeE9vTWlPNXk2MHRp?=
 =?utf-8?B?VUJGWmVJZnU3dWJwTnVrc2ZlTzZHZGlhS2ZmQVpLTXpIRGRJOUdoRWZRaU1s?=
 =?utf-8?B?VUhYc2N4WDVuT3Zva25BakR5aTBuUEFZcGNzTjhQZ29Odk1CelJVay9nYUpo?=
 =?utf-8?B?VnNsMzl3MHBGOFlYWVpOYU9YejZrZTV2Vkk1dTltNHdvRlNOeExVNFhsUE1w?=
 =?utf-8?B?Ykg2RDlKSE1ITUdac2JCWVJUdzRXcUZCWjIrdUVnTy9DbDR0RVE4NjRmNEts?=
 =?utf-8?B?MmxBUWI0TkpOejRBd3BRNm1ReVgyY3d5ZU1LZXdHQVlVWXpiTm5BblhZaUtN?=
 =?utf-8?B?aWoyU2ViUzdXc3lXb3NrUks2ZmY1Uy84UTQvdFF1djZXc2liS1kxTzZmVk45?=
 =?utf-8?B?bWszYmg2MlZkbExSNVdUMWRoTEdKblJxcTlJOUkxK1hKTDFRd011MloyTlRU?=
 =?utf-8?B?RVRpczMraE9OOGFrcEhJdE9TWXphdFRQdEloakVIOVdxN2xBTlpQdjFRaE9o?=
 =?utf-8?B?cUhxYjNvQzRqZ0FOb2ZCbU1NZXIzcUVOcjNlMGZFYzBZTk0wcE1FMHJRRjY2?=
 =?utf-8?B?UWlSZ054TUVGRUc2SFZvbmxIWUNYUFJkU01PeVZwL21wdlhmRmMwV1hhSFVR?=
 =?utf-8?B?S21wdm56eDRadk5KL3B1bC9yMFdoWTJHcDY3UzNiblVZdjhmT3hic1JwS0dL?=
 =?utf-8?B?WDFQd2UwdGhtT3hveFlvZ1ZZL01wUTBrcVVYSDV2SmNRYnRWNGpiUUlqRHJn?=
 =?utf-8?B?Nk05VDRrRDRHUk9ySHY3NGVoN3RnMGxxUzdkQnNrdFluSEowT2t4YjJpL3ZJ?=
 =?utf-8?B?bUtyVzhiTEtoQVVwajhpcGMrU3pCbEV3SnVaZEUvZy9jSVNvMm9Kdjc5SFFB?=
 =?utf-8?B?RGZuNFJRT2hqYzNhRHFNTjluUWg3TjBKT0FmWTRWWXM1a2pUb1FDM0J3UkpL?=
 =?utf-8?B?UFFUUTFwS2JVZjdZWUZjbWI0Rkw4OW92dUdiSDBsUisyVUVFZjNwK09vZnhS?=
 =?utf-8?B?ODVrNjhQNXR0WXJJSnVuK3dPai95eDRKZnVJYjBtVnBuK0RFR1FMV0pMaU9B?=
 =?utf-8?B?QXRJdEdnZDhGTGFHSkhsWkoxQ05RRzA1QXhxUjhFM1RiOUNSUDJCM0x5THM2?=
 =?utf-8?B?Qk0zMHNXbFA5a2hBQnJZZkpJK2FYcldLZ0YzQlNseUVYV1BidFBTay82NHAy?=
 =?utf-8?B?OHpBRE5jVXpWenZlazJWaHNueWNKdldmcnVNOG0vVG9QeHNibnowWlFGdkEy?=
 =?utf-8?B?WThYcDVyQ09pcVZpb0RsT1JHRnVuQVBwRzJLaDZhdERNdlo3Zlo4dmNRNS9s?=
 =?utf-8?B?d21TRlFaazdJZ1V6TXliaEpSc3RNZ01JWERtM3VvWWdJajU5L21lVGtmRXJi?=
 =?utf-8?B?dWRXSXJUdUdrazZ6amEwc2NZSzBqK3hmRFByR2lZT2JQbkNDN3ozWWozSW9v?=
 =?utf-8?B?UjRPMno3d2p2RC92K21QaDhacTBWajBzMjFQZForckx2N3hiNW5qOStDZXNp?=
 =?utf-8?B?RlZwdWdPQmtjYXhwZG1QUU82NCtaWFJtREpDVGZZQk1ZNkFiMkZjS0hiSVBj?=
 =?utf-8?B?YzhaaFVtZlNPQ2JVRnFhZ1VVcy8vY3pDTjgvM3kyS01SZjdmOEdaMTB0K3FU?=
 =?utf-8?B?dXNyMGZoUEhVVTJnOXdoTTVxai9aOTVjQk55SHdFcEtpd2ZaUHdXSEE3a0Yy?=
 =?utf-8?Q?QFBZfKj1ykjjT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5772.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEZvbXpYMXNiTzRCcWJIMzZPNDc5US82aUI2Q1dUNWhvSVM4Wno2cWVkZ0pS?=
 =?utf-8?B?U0tDcVRLWndIdm0ydjh5bGE0RDZSMUtWTXhwektBQmFwU0ZzMXEvQTRkS1FU?=
 =?utf-8?B?RjRVTjV4Y2lhRkQxNlAwZ2ViL0haT0g5aU9JVk9yd3VlNStQYVFzeEo4T2sz?=
 =?utf-8?B?ckhzUW8rVWxhUlZIZXZkTE1PZmJVemc2QjFlUFMxTjJZdGlHaUlYdlJPMmVF?=
 =?utf-8?B?amhSWDlSTENOZDNZSEZtcjJmUE1zUUNKcU0rbW9BemFEM0FwNmhBdWhKYld2?=
 =?utf-8?B?MXVMZGRvanV0V2JnYkRqRmVLbnZRK3pPeEs4LzA2MUZ3Tm9jWm1DMGxoM2tV?=
 =?utf-8?B?cmJQNzRCa2c2QUg1SDBlQ0RIRU1ZRzNWMU5ScU9LRGMwM2ZaSks0bGNVYkh2?=
 =?utf-8?B?WG0xV05DY3RlZDAvbVdTdWNVdUNCZVVTUjdSdXFoV05tRWJtUGJuSWI3R2lB?=
 =?utf-8?B?bk54ZTBzWGQwYlBFVEFmNVllUFBEdFlPQXpOazlFR01tOFFQVnZQVXNYajdp?=
 =?utf-8?B?SFl0dURsMG5BVTZ3UGdadzVKMm9jSkhqQmgrbVA3dCtOYXkrQjdIOGFTOUoy?=
 =?utf-8?B?a2xuNklyQ2Uya2F2UmdqbG5tYm1Ub0FqdGxjWDdLeGVMcXpaMEZFYVowT0Jn?=
 =?utf-8?B?dW5EejBLNEprbFZpVW5RVUtUdllQSGRCcWhxaVkxRllKZCtqek9ab3duREo1?=
 =?utf-8?B?M1N6QzJHUEw3cGE3VnRyTXByakpxUUxkQ0FPMm9TYjlibEJFS0NaNzlMeU5L?=
 =?utf-8?B?c0FhSjFNS3dwbEk4Z1NhQ3NlcDNWY0psVkl0V1lVa2VtbGdKVDVyRnNlbUVJ?=
 =?utf-8?B?S3Zxa1U4dG94anZoRkttQXJJMjBlVmRmaEFzd2hhRW9vM3IwRUNhSUNocG1M?=
 =?utf-8?B?ZzV2dndIWkNxNTRSOFVVaEwvaURZRjhwTVlobXJ6Tk5sOWhoQ0lmODFLVGNL?=
 =?utf-8?B?QkRxZUhvYi8vcUlMbUhrU2F0WU5TWU4wQzk1TW9QQUh3TmQvNDNFeW42M1By?=
 =?utf-8?B?TEY0eWRSYUVIaVNEaFM5a2tzbmQrdlJkck1RcVhMM3Y2TFJVUFRBR1Era3Nm?=
 =?utf-8?B?Q0pDYW9SeGt3K1JaVjBpdlp4WjdJZFZmRjAzTSt0eDdWd0d0QWQ1dnczRlZj?=
 =?utf-8?B?bnYweWR1SWcwaCtXeWpBQlB2OGtJUXBwTStCMW1vcUJmNU1BcGZ5WXBidTlW?=
 =?utf-8?B?QkRRUERFR3FtRzFveEdGWWdISThBU0FWWFBuemhSRW9ralNFRXZRV0tLakdC?=
 =?utf-8?B?U2IrdWQxc0d3ZVVnbTA4SVV6OENqaktsMHMxa2dkZFRwa0x2SlkzMlhueHBR?=
 =?utf-8?B?bG1FUlF2UnF4Q1JnOHJGblBKWS85eGRMcjdiZUtXNVlNNDk3QmlmTDFzQ1Ew?=
 =?utf-8?B?eExKa1RrT3I2eVdPeW5oSU93Sk8yYTVaWHVCUy85cUFDUUl2MU84VW1scGhX?=
 =?utf-8?B?L1lZdnNtQ3kxUWhzTVhWU0crZFdHMVhLSzdzZ3o4TzAreDZWL0xuK3lxL09q?=
 =?utf-8?B?VDF4MDg5ZHlaZGJISXlmSW1pbENtbmZUWUc5Q0kvNnFBYy9MeWRoNFZyMFo3?=
 =?utf-8?B?aDMwbWtQRUp5L0lmdGNmbG16d1RWUGJiQU1zYTJTUnVvRGhCbDZaclZ3dFNR?=
 =?utf-8?B?OE5sa2EzUk1QT2hVOVJlNXZaV1Z2ZmNSZWZmQ01tVVpWeDE3MkJxUU5WM3F4?=
 =?utf-8?B?eW9pSTZKYmN4eXJKZTBuR1pnbXVqV1NGWmRyM2VrS2dmdkJ4dDgwT3JUUHpa?=
 =?utf-8?B?UUlkQ3lJcmswVVg5R0xYN2pOSGpxT1BCYUE0Q3NVQVlpQVJodms1aTN0czRS?=
 =?utf-8?B?b1o5RzlIVkxnaWx6aTRVTVp0T1N0a2VMYzdGbG82bVFROTRnNEgvSlFES1ZK?=
 =?utf-8?B?b05leEpjOXpjTlloNm95dXhXZ1BOd3pYYUNvbGxwRCtrSzRWV0VOeTZPTWk5?=
 =?utf-8?B?Vy8vcmRlZWl0dCtyTmhoME01V215YmVoS1VIZXNERWJ4U0FLVVM3dmEvSmZm?=
 =?utf-8?B?QWg4KzFBK1J0bDczeUk1UkVLZkQyRk5SR3Radzh5b2hZZ0JEWkJ4dDN6SWRR?=
 =?utf-8?B?NUZTSW9HNmM5LzdKNVlyNU1XenlXMjV3UzdNcll6UUg4azBxRmxmYm81Z2po?=
 =?utf-8?B?QjljekRHeXBaWGNlUHA0elJlVXZTWlZPVnJBeHpXZHhkMk9TNVVjcUh4N1Fr?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fda439-2f63-4780-dd6b-08dd62579cee
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5772.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:50:59.3659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /t38A6x150k8gvxrg5gxjfq4BSPvOZH28902SuSHWvi4BbK4FwMMLSZS3Ay9FSpEQA8bklokImwXD8SNY2Wapl2pjnmfmM5wYE1R+E7mRls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7370
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

On 11/03/2025 21:40, Matthew Smith wrote:
> While adding a vsi for an ice PF, set the ICE_AQ_VSI_SW_FLAG_LOCAL_LB
> flag. This will prevent packets from being dropped when using a virtual
> MAC address with VRRP.
>
> Also set the ICE_AQ_VSI_SW_FLAG_SRC_PRUNE flag to prevent transmitted
> packets from being looped back in some circumstances.
>
> Fixes: f9cf4f864150 ("net/ice: support device initialization")
>
> Signed-off-by: Matthew Smith <mgsmith@netgate.com>
> ---
>   drivers/net/intel/ice/ice_ethdev.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 3cdfa16f77..21d3795954 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -1696,6 +1696,10 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
>   		 * by ice_init_hw
>   		 */
>   		vsi_ctx.info.sw_id = hw->port_info->sw_id;
> +		vsi_ctx.info.sw_flags = ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
> +		vsi_ctx.info.sw_flags |= ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
> +		cfg = ICE_AQ_VSI_PROP_SW_VALID;
> +		vsi_ctx.info.valid_sections |= rte_cpu_to_le_16(cfg);
>   		vsi_ctx.info.sw_flags2 = ICE_AQ_VSI_SW_FLAG_LAN_ENA;
>   		/* Allow all untagged or tagged packets */
>   		vsi_ctx.info.inner_vlan_flags = ICE_AQ_VSI_INNER_VLAN_TX_MODE_ALL;

-- 
Regards,
Vladimir

