Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E25CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 10:11:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE95D4027A;
	Thu, 30 Oct 2025 11:11:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 53F394026F
 for <dev@dpdk.org>; Thu, 30 Oct 2025 11:11:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761819116; x=1793355116;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2MDl1YYdPfTeZyoqA93wAW84GpPuLTHSiHrF1Kh34dE=;
 b=VIqy3Rj/rHDNsRRBhJD9bVFnk+PSFYLbIeX383CKpb0xdHS9dqxOqxnM
 JIJgNDar1nezbPFGgUu8pnrbN2xu1uVkKBcgXwOKd70rJ9rAd7gl+8rXW
 qqcPT/DfbBGP6IDLzV7W4YdcyAr31dRQslTnBp5zjeP3+2brZ13EqKpP/
 sRjo7URwgl+7JEbgmkmnKjbqNAbhKaR24CHFj618Kupl4NxC8b0m8iHPq
 7o3aO6hBL4b45yaWAiyS8xnnkciDTnfkIeyNQVep47kCD0VQVaNkxUwmi
 3TCFe1hZXM/doOAfJdPqemOkD2Q7nKx+JY/N8a/0P5fk8liPfqbzGDjta Q==;
X-CSE-ConnectionGUID: ezL/W7saQnmOl7jcFGCEqQ==
X-CSE-MsgGUID: fLqHZXJgQVO5bYK2pjI/Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="81584302"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; d="scan'208";a="81584302"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 03:11:55 -0700
X-CSE-ConnectionGUID: HjQ/5CuITymNWNHKhaBBLQ==
X-CSE-MsgGUID: TJGdtFe0RFesVoPm1jn6Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; d="scan'208";a="186658109"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 03:11:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 03:11:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 03:11:53 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.50)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 03:11:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhHfpcMJjKfxrxoDb4psoB3A8ZroOn18zKODsa0rfoeTGrLOWtN8GfcV6UX2iJz3MTeGAenXF8pJxh6S/+owgnEsqdWamBimPhZmD/ClztRR9D9CvU8RggvtDYGghizdymrCwtRy3HLozFzTvnHtwwFHFI+8Sp5NqugbgfVhfRV3WiHXk9Z1Y6Ce3L8EQvR23YTQSIdtN6/9l8Pcz91qeC5bhHvozV3JcsqiCfxxhG2Glm9MVciS8VkW73komQv9jdN3/CnpA3kzc7T5cEaVXjbz7zZVjrjOEBDKPhY4mRPoYe6eEq/sd/1cQbBjF/nU4BlfxiaubTx48a6yythsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjT89trsMj33TBaijYHzREeMDpuMwOOkZj6HWycxsEo=;
 b=TijU07/HR5Us/m4qxy/nbRyfHbe2RtmPSsUru3+jv27C2S78Go2JyaEMVZAuJmbr912qwfYzTN2BOgRRANJELYqII2PbgHM1i+l3LUgJhQdx8CSQogXMQlNznefILyYY6jI3VRq+lLUnzyVXXlD0B029g3MdiayGdaFEL8xJMCZ0Gk1LJgkyuJqjWK/UZPNGr/JIqOn4VxbbRbOJhlvw+40FCPZpTdn1ZGHra9Gfl2YCRZonOyCQkf5bLjgQ/HTUnlLIJjsluP2wCLB7xCVSgUoo+Z6U0jIjEMk+CBRyF8PYCiSqvlRWajyzsMWMbVZHomkcO4YOtDtQj72Q2YLUmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS4PPF1B1B74C09.namprd11.prod.outlook.com (2603:10b6:f:fc02::e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 10:11:51 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 10:11:50 +0000
Message-ID: <ba7695ab-1233-45f9-a899-ab550af5c364@intel.com>
Date: Thu, 30 Oct 2025 11:11:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/8] Support VFIO cdev API in DPDK
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
References: <cover.1761669438.git.anatoly.burakov@intel.com>
 <CAJFAV8wQiRZoeZD0uOxi_aa05XsE50_LbAQLxa1b12-vet-WkQ@mail.gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <CAJFAV8wQiRZoeZD0uOxi_aa05XsE50_LbAQLxa1b12-vet-WkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0057.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::15) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS4PPF1B1B74C09:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb59b4c-e96d-47d0-e28d-08de179cbdef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzNOcmJHeXNjem1vYjNlOVZMeUJPMXp3ZGQ0TGRSTjFEZEZwYzJWdHFjTnRZ?=
 =?utf-8?B?bXIza296cE9tVks2b0Nuem82RUtSaDZBcTluMVA3TVk5eS9BWUpISHVmS0Fj?=
 =?utf-8?B?QS8wM0owU2VwR3gwRFlzRzR5NzFkckF2THkwcXM1UTE0RVM2UFFkb09MS3JS?=
 =?utf-8?B?Vkh4Y0dYbmZITFZqaWNjanV4YkZXSWJRM1hsRHFMZ0V2WWVjZ0xQUnc0U3Vt?=
 =?utf-8?B?c0pwTjYxRnY4dGpNMzBLN3gwRHc2bFk0UU1YSFNTT3lYNjA2Vk1JYlFZdUd3?=
 =?utf-8?B?NGJmc0t3R3BGcG5kWW9ZbDVpTEdDeHNlaHFKZld2ZEJQT3hiMk1kVENha1BD?=
 =?utf-8?B?dEF2dDVaMklhM0RCNjEyKzFYSXk2NmZsMGpGOGIxeTcvcEg0eUkrV1BJSHhH?=
 =?utf-8?B?ZEJZRTMyMlRqZDBueisrL2pUa2VoMGVCbysrTVpOVlI3bXZCTFJkck5VQXhY?=
 =?utf-8?B?Ti9EWVJkeGdlSlQwbFJXRVhuL2tYU2lrbG1zTWdQUWhyTnZKeFl3eGtRMjE2?=
 =?utf-8?B?Z0EzVnF3U0hQSWZ4MnN1QWlaL0F3OTEzdi9MUmdDalBSMklPdHhNWDNwSjFm?=
 =?utf-8?B?ZEg5RDR5dGFUUTRtRUhaTGJ6cVZmMUlwUnAwZ0xybUlYckhPck4rWENKWnpk?=
 =?utf-8?B?NWJSZVgvazF6aTRTSTFINzZ2eHE4aHpKaFhTTmlDcjN3U2NFWlNaTzBiYlFR?=
 =?utf-8?B?aUVWZU1vNmU3aUxNZ1oxZHFJVWlLY1plNDBUcXFxamd0TkRxbCtGdHNKNjVX?=
 =?utf-8?B?RkhkSlRoYmZ4ZEEwRnZpcVVsVVpzSndjU29pVWRwbnhLMk1QOWRMZzYrNmts?=
 =?utf-8?B?VUx3cTBVcUs4TWFYNU1WbkhzRmhSQTBwUWo5SEtPVUthU2JnTTMxWXhVZ3A0?=
 =?utf-8?B?VWdWMUlVVkNwUWNZcU1vakM5WUJWRlM2dnp4R2RUOWtvck1DTisreEY5VlBH?=
 =?utf-8?B?czViZHJJc2MxdUljbzB0OVpOejI5Tk13K0M1VTRWNm02SnJkeE94WldkNkdR?=
 =?utf-8?B?cDdvR0p0d3BkK1R5cWFyb2IzMWs0cHJwL3Bla2lTZzBhRnFYSS91OWptZTBh?=
 =?utf-8?B?WDV5VWJSbXZkZUJ4c3ZaMlZwZ0laaXY5TEhvWGwwMjFqOVZ3bDZZbWs1MU5n?=
 =?utf-8?B?NU5HNCtTT1VxNXN0TnFHNk56UEtacFczR0htNzJqY0U3WTk5NzFMbjJMM1hE?=
 =?utf-8?B?RU13UXRxVUp5cWY3NUh3cC9LdlgyY3o5NGhqcVpveloyOXBQVUUrMnkyRHpX?=
 =?utf-8?B?bElVV1owVEZ3OC9WZWh2ZnRFcEZpQk50OHVFaUJiUnVBQ3RNcFQyby9CbE83?=
 =?utf-8?B?T3FqM0E0RjRpOEZXU1A1bFpwcHR5TUpqUDZOWXhNQjREOExHVHcwWllNaU45?=
 =?utf-8?B?ZFB3ckpFVWV0UGRFMzJ5U0RidldkVkZiUHRPSWtLVUhTTFF2dkFwNTNTRjN2?=
 =?utf-8?B?RkhOSU1Dak5oTWhDbTRYS3BDTDIxaXpJanMzSUlqK2ZaOVpKZzFMS2RPc1hO?=
 =?utf-8?B?WUZSUzRVOUI0QUJKYklyVVBzQnNJUlhMU2wxWXErdDJyTG9xQXZTbkQwMzdE?=
 =?utf-8?B?NDRiU3VhOTdMeEZSSlo2L29KalhWZFprOVZFblJZS0FTY0Jkajl4cjNuWVd0?=
 =?utf-8?B?SFpPRFpNQ3RpVXVXQmZhT2NwT2dWNEcvd1VYcFJEZVk2aHBES1FnWHlLTERo?=
 =?utf-8?B?MlRyUEZzWGdFRXF3ZXFiY3ZvNXpMTmd1RUhJR3MzMFBYWERBQWFMaWRhVUFi?=
 =?utf-8?B?TFdNUUJvS1YvbFNDT1ZyVnlpQnE2QWg1N2lsUXc1MkxUVEhrU3dCT0NOOFhz?=
 =?utf-8?B?aDZ0UmpUVmRiYkZrVStmWGZvQnRGSjNrdmc3Rkkzc0Jvc0FvY1dFWXBHVlQ1?=
 =?utf-8?B?ZWFxRlZSaGRCSzR1MngyaHZrMjlPdjVyVG0wbzB4bVNpUDR5WmZnQ0FQT2Jp?=
 =?utf-8?Q?Yt8COpOgPMss1+32bsiDkC2VmqF2kku8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3cyTFdiMnZFaE5XWFVCdkJybkNJMkp4VnJkcDcrcGhtLy9hTUZIWFlzSTV6?=
 =?utf-8?B?TmpnZjZqOUJNdEpudmhYdlJXeThUbmtVY2grYTkxa096bVVoNTZhaGdWeUpB?=
 =?utf-8?B?SmZzR1YxYmR3MWwxcUdpVTQ4Kzd6UlhKSjNENjNRc0cwbWkxSXhZUElTYzQ0?=
 =?utf-8?B?d1ZFZm42OVJSSzBEYkZ6bUwzZStiVWVscVVIV2VSUU1MYlVQNFMzM3FtRy9y?=
 =?utf-8?B?UkR3WkFKemNxcDJCb04zUFlrWVRaUmJnRk5sR05OMzhqYzVpMmhLcG9uOWxF?=
 =?utf-8?B?bThxWVJvMWJIREVnckRUOHBPZkdDb1oydTRoSzB2U1Y3VjBiLzFGVm5UZ3Vv?=
 =?utf-8?B?YitnWlFwaHF3R3d2U2pwMVYveDY4dFBTSmx3UXFCQjVGajF4eGJOS3lTMnR3?=
 =?utf-8?B?SDJ6eXhKNVVpWVhWM0hKYjFNUmdpYXZrZU81YWt4T1JrS2lCaDZTSFZoeCs3?=
 =?utf-8?B?U2wzaUdFZXNyTEUwL2E5ejlvYmlEZWpiTFpJZXM0UXBmNzFST05Scy93WUNK?=
 =?utf-8?B?V0ttZDVVamhIaVRRN2FmdlQyQ1Vwb3lLbkw3RTZPMnRvVkplSklYSDE4SHlw?=
 =?utf-8?B?eEdSczZnVGQ3cjFpdHBpM284N01ZREJSMmZqRk5TZGNjaWtMZk9OTjUwSmF0?=
 =?utf-8?B?aFlLay9Zbk9iYWlrbzNLeTFQZ3YxODBvKzBBVU4zWnViQ0xWZ0kxUko2VWJF?=
 =?utf-8?B?Tlp3ZjNUd085RzhZNXFLRHN1WUUwYmpKVHduU1JZV213RXhQeGxzOFRCeUkw?=
 =?utf-8?B?SCtudXIwM3NlVVJETTFlY0tnbDg4alI3TXRYWTJ1UGlMR0RaOTFUV2VONFVF?=
 =?utf-8?B?ajZDUHBsWjRUZU42eXB1WC94M3BLbTNyUVdCWDhnRlh1VGZkQyszUWtXQklB?=
 =?utf-8?B?eVJBMElaUTZ1ZzBSRlEvell5VUlQK2NndHdlNnZrYzFsclFteEVMejJVbnBP?=
 =?utf-8?B?VU4vd2dVekZvZFZub1ZMQnc2ZzBrRi9USi9hbHJpZVJlT2dZcDBEVkhNTVBr?=
 =?utf-8?B?c2VEWTUyR1FsZHVXS3UrcnFSVHdzbENwK25NMWM3QWNxdWFUdkkrM3NvY2I5?=
 =?utf-8?B?Z2R2dHpVNzEyM3RUbWJtY0JWUTBHY2FUdnFVdGt1WXdiV0RIdkx4dlVGWUMv?=
 =?utf-8?B?akMxTEJEZ3VsV29laldtWmpHY1o1WkhjYnZCMTNYQnB1WWtpWHZIQmc1SDhk?=
 =?utf-8?B?L1RVbE13bGkzM1piV0xETklCTTkrN2dOTmF5U05RbitxOHN2Vm1MNmcxQmdD?=
 =?utf-8?B?ckJyOHVPZk1KT2hHRnY3MmZjTWFkN2V0TWgyZzBabHJTZUZRK3lzaTViZTMy?=
 =?utf-8?B?R3pCYjU2YmZ1RHdkRXFLRWJOWHhZeEQ2SVFpcTBuV3hZYUZwRnFwM2xpWTlR?=
 =?utf-8?B?S003ZTVoZ2hxWlJwUHI5c1RmeWlVeGlrQU5SZ2hhcE14Z2wwVnRpOUZJZGk3?=
 =?utf-8?B?RFJGVEZqUThSeGRROWNDaEs4US9kdk5VdGI4cTFRcXZEV0FoQm1ZQ0ZCQWRa?=
 =?utf-8?B?djhGbmVlVWlvKzZJYWNQc0EzWWJnY1dWWmNnLzRncyt2NWpWZElKeXpBTW8x?=
 =?utf-8?B?R0Vsd3RxbXUzcFdnZTdYQlQyaENFZWNFcmtRY2dybWdMVDFtZi85RGMvS1Nt?=
 =?utf-8?B?ejZmdVA1bmZldi95REEwbHFKYU5sNHJ5TERjMkxoVU9nY0tkV3FXQkRUcVBX?=
 =?utf-8?B?a1RaLytEU1FkZ3hHYTdsYjZPVFQwZStIK1g1Z0gyZGpRWUxTQU53T1A3WkpN?=
 =?utf-8?B?ci9WRmorU1dpWkM3OG5nQVZlKzF3L0x5cXR0T3ZaZEFMRjFKaDl3THFBcW1U?=
 =?utf-8?B?TCsyQjVZdm0wQTBYU2xMZTVqbDdqTDlwcXQvSlByVUdFQjAzNzJMNklsVnFi?=
 =?utf-8?B?VHVGVjNiLytqME0rYW1tdXZVaFlYYTkrOWlQRmFKRE9udzFoS29OcTFEejdz?=
 =?utf-8?B?eStDdnhVYTFRV08yY1JtcExqeHlSZEo5UlpncnQrTjNtVjFkSWtpbDdQc2VO?=
 =?utf-8?B?QVVsajlBV0NlMHI1T0Q0ZlV2L2VLZG80RjF2S3RkdXVTbjlmR3NyMnRjTWxi?=
 =?utf-8?B?NWtxMUxBSDNTQVcxc3Z5dk0yeHlNNE03WDNPYTVBNmhsMzY3MEFNUzJaSVEx?=
 =?utf-8?B?bFJkVDNpT0w4TnQ3dUcvYmlKQzczRG5La2ZvTkJFTEVhZHBQUUZuSzlNbnM5?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb59b4c-e96d-47d0-e28d-08de179cbdef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 10:11:50.4091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myHklAfwVBMaO2PCulCjrxqiOWfefSFJP547JM7R/d2KeOl/IF5DqrLff89Y7WFoPSprzTkaeW+UPSSW83ehwZ7fX4o/lsCms+CXGCdMt3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF1B1B74C09
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

On 10/30/2025 10:21 AM, David Marchand wrote:
> On Tue, 28 Oct 2025 at 17:43, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>>

Hi David,

<snip>

> 
> Do we really need to expose all this as "applications" API?
> All I see is EAL and/or drivers concerns.
> Could we hide all of this as drivers API or at least clearly separate
> what is driver-only stuff from other API that do make sense for an
> application?

These are indeed mostly driver-related API's, so I agree that this would 
be better. The problem is that VFIO is in EAL, and drivers depend on EAL 
not the other way around, so we can't do any driver-related stuff in 
VFIO directly.

If you're suggesting to make most of this API exported as internal 
symbols and deal with it on a bus level, sure, we can do that. It would 
require some plumbing change in bus, because buses would need to keep 
metadata around to know which device is supposed to use which container, 
and be explicitly aware of the concept of DMA mapping - buses already do 
have DMA map/unmap API, but it's not custom container-aware and always 
uses default container for everything.

The original idea was to give "the user" control over containers and DMA 
mapping in context of other memory types (external memory, some specific 
device memory etc), but perhaps we can observe that pretty much all such 
usage happens in drivers anyway so we don't lose anything by just making 
all of this driver-internal. Thoughts?

> But we can't break ABI during 26.03, so maybe my suggestion would have
> to wait 26.11.

The deprecation notice would have to go in in any case, that was the 
intention. The patchset is developed around the idea of getting the 
changes in as soon as possible, but obviously it's subject to ABI policy 
etc so if that can only go in during 26.11, so be it. We can get it 
right till then.

> 
> 
> Two nits on the series:
> - you'll have to update the vhost documentation, for the vDPA driver API update.

Yep, will come in v2.

> - I also saw those inconsistencies: double check the experimental
> symbol marks, the next release is 26.03, not 26.02 (this is no warning
> in checkpatch atm, maybe something to add).
> 

Yes, I noticed that after submitting, will be fixed in v2 (already fixed 
in fact).

-- 
Thanks,
Anatoly
