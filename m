Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE2CCFC269
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 12:10:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B9AE402EA;
	Fri, 21 Nov 2025 13:10:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id E79D84026F;
 Fri, 21 Nov 2025 13:10:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763727004; x=1795263004;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zG83cdFnscStbl/bIHveM33XJIpO7ynusVWZFDCwf4s=;
 b=ij3ZRlhMzdGMvFc++Tg8b7wD1+mjypdt8JeHiHkdAO/c0Iio93JZsqdo
 hz4lMaXuNFLb7cVn3PVaKAc7g0dqgn3I/HfRvqEvlXDd6vngSkyBGkOJE
 d9scEY9EXfTXqV5Ef22T1AOLmxvrh1E86238J12uQoY1Fy3/yb00h3Gcf
 n3fJIe9X8wkU9YrVNq3Osbvanj3ojMer6b37uRg9xVFFGnmZG2U1pPbeC
 e1LUGIql4TMQ5Xi2VzZjtIAOdk2E+U53hlW/ZGNpqTA6BrvVXMTAj2ctV
 LMqXRVjeecqzX9/WXHkffeG3IuodZ1slAVR3tT4KXMnzWmH5IGPK+hS4L Q==;
X-CSE-ConnectionGUID: NcKLH5QUQhuvFtivmKtlEg==
X-CSE-MsgGUID: Bj7R04HiR9ezEwukMKJwzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="88469757"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="88469757"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 04:10:02 -0800
X-CSE-ConnectionGUID: 1OlYiioLTCyHEK+Wbp2fLA==
X-CSE-MsgGUID: xEeH2l/yTJ2fiFwxCpmRTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="191927204"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 04:10:02 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 04:10:01 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 21 Nov 2025 04:10:01 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 04:10:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLw0GkcsekVRIDk8PxVeQBkJ5Oarsbn6mYzguZnUyUkMtxML1pqY/ZOX/STrlUWqZnH4XRxsPBCQnySFZhvcGGFOL+laFTj9YRHkcMhzIB2DMIaXkCZi84Eicdai+avDwDTJZa9aeiq7ccyCTVE877jVFcf2+fk6fg0fOfy65lKEnKcuaRBnvljtKUBgR0pG4DFaocN/fZrt4509UEl3dxUJJDnhTOhcqImh+bdUytmvfVYUk29TYxzxQgU7k/KjXy6W25aFWS7Mth7Tj0v13ATRXXgYiWaXxk2CMk1JB1nE3mgFF6TblDnjQYRigrLj/vaYkCGROTejCFFQFqJCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgDNIEp2U4MTz2xJsDshdG/hSZPyANtcwbNSRL5+/aQ=;
 b=IpX8mw77+JJsZUtNxi1cUzKdCGmyuRkXDnZQT6SFAQeuAynK9wCTPZBYppkkfTpz9IX1XF/x4pkJbyGcTrl5NC4aPyhUlVe/L+lQKN0kSyQNVRDIMbQodPATWu6LQXgUIAdMsrncMGNmX9Fsp126gSzbWUP/dsapnvb3DwpbEe19NjLC1P2whXY8UPMFqs0IquK96fJmwxMp9bQbyWy79lH/haFMQnooWavfRHiYnNDbAkowjTyj4IuxoFwdUHL9Cl4LSGNkkZQHqZDFz9PpQhWeLS2SaDrncBTPfSMdJhRezQaNgOem5tt4Qk3MVYlMBvlETrO67B4z85VZHmIUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Fri, 21 Nov 2025 12:09:59 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 12:09:59 +0000
Message-ID: <2106ff3c-0990-4d87-8fd5-e320af4f71f3@intel.com>
Date: Fri, 21 Nov 2025 13:09:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] test: fix impossible format-truncation in cfgfiles
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
References: <0251115193409.99740-1-stephen@networkplumber.org>
 <20251120165713.120238-1-stephen@networkplumber.org>
 <20251120165713.120238-7-stephen@networkplumber.org>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20251120165713.120238-7-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P189CA0030.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::34) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS0PR11MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f47f1e-7d63-44fa-d1c0-08de28f6e491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWtnR2dZVlJGY3Y4am9zSjJPSzZqYmRFVk9YZjdVS1o3alR0TlVyaGJpaDlI?=
 =?utf-8?B?SEFtczFlVjQ2QnczdnROOFBuQytiZ2RpcDJGVUhOV21RQmNlY2lKanpEaWtJ?=
 =?utf-8?B?SWlrN0xhb1FkT1dIcFdoTThZOC8rSFpuTDl2RkJGOUE2NVBGVFMrWjRIT1BB?=
 =?utf-8?B?L3IvejgwTFV0VFYzdytoSm1qYXdiMENkdExSdTdTZk1vNUt4RStFQ0JaZitr?=
 =?utf-8?B?MWswcW5kNVlmaE8vWnFGQXE0S0tqL3h2bkQ1V3RGNzg3OGhHRWE2NVZkWnU1?=
 =?utf-8?B?Tkx1elhnZU1RcUhhSU4yZ00vWTJOOEM1WkFHeUN0KzRWdnZoVC8wRG9nN2li?=
 =?utf-8?B?TDB6dTNwaGtRNjBFQ0NEVmRuTzZ4b0hscW1qQ04xQ2JnYkFFbFRsKzB1c1FC?=
 =?utf-8?B?SE5SVVdHNzR1SHZnTFVya0k3bTN2UWxwZEJhWVV2UTBNOGRLSzA5SnlWMU8z?=
 =?utf-8?B?UjQvVURjM2ZQTlpWRmRPTzdWVDBTQUJRU1NLQm1tTzVBYXlsdnJIcHJBR1dN?=
 =?utf-8?B?UHhnY0xlSndhYmZPNjA2WEZaYkhDUWxNenJGZnJ6aTZublBvZW1OV0hkS20z?=
 =?utf-8?B?ZDZWTHVyeTFoZnBmVTBUNk9TZkRnekp6dWhnYnplZEZGdG9NVlZRZ0djN3Ja?=
 =?utf-8?B?d21aVDZHdDlTMTB2SmorYmpwZkFYZ3Bla0tuQXVudXRTa0Rjd0xwN1luV002?=
 =?utf-8?B?RjZlcVFYRTFxR0tPTEswTlZtSlZhZyt0SnBmeEYvcXQzOGErQ1Y2MjJZL2dj?=
 =?utf-8?B?UUZqS3lMRlg0clNrZjhuNDBRQTdWM2lCMTB3bXJVUFNMMmZEQVBrc0t5WVcz?=
 =?utf-8?B?LzNYQ1lCVUN2b2NMWit2SG9FYzE3WmFiNlJ6YWI0N3hDWWIxZXhjRXdIb0VN?=
 =?utf-8?B?bkQ5cTZLYVlQaFhnUHA3QXZsTnZ3S29ta0RxcFZFamRlUkJNR3k0TEFKTmsz?=
 =?utf-8?B?MlpUQjBMd09OS2JWZmZTeGloL2JpU1NIMGFkNTM1Y0dXS2xHQzA5NUhwb25x?=
 =?utf-8?B?ejRlcHAwcG9aeDd4YnZldlpWclNZQUdldGtGbGVOQ3QwZCs5QkZpTC9FWE1U?=
 =?utf-8?B?N1d2Zy9WTDZjZFNoNXJVaUo4ZE4zMktYV3RtSEVIYlBGOTVEa0hRSlduOHZj?=
 =?utf-8?B?K0JDc1UwYkFsSVl2RXhiTHFFWlJkZjBsYTVFbk0vcUJFU3pmNlEvVjdadGhh?=
 =?utf-8?B?dzJwSHJBT1pPVzFvVjRvQ3hVdTNYQUF3dEtSSFZTMGxJRHJHeFpCbTRwUW8z?=
 =?utf-8?B?bnRDTXBLYTdxd1FHMG9tRWVNd2pkZnloZXlFbGt4RDdHM09YOU4vWk9SaGEy?=
 =?utf-8?B?clYxVUpOTDBLVndaVEgxWVN1RnFRVzNtaWsxUUJwa3RHZW5RWDdINmdwcmJV?=
 =?utf-8?B?WjZ6RlR6amcySWxkS0ozcHFvaHBKT3Jra0ZqNGJFMjF4ZUVKeWFoekVTd1Vn?=
 =?utf-8?B?RVFvejEyak5NRkhMMGhqOTg3SVlDNzJZb1FLYkVXc0lzZ3k1WGUrM3BTK1BI?=
 =?utf-8?B?NkZpeHliZ0w2RDY0UjdGMVZWbnU5UFNEdU0xYW1oVFc3K3I0REtpNkdjdTVO?=
 =?utf-8?B?Y0s4bWx0YXJSU3BvQm51TjhFUDc1Vi9rZmxFSTFCVXhCclhoQ2M3SnpBbWdU?=
 =?utf-8?B?SFdLbHhudFowVk5WZWVsamJveWFOdGNmYTNja2NtdjhBTmpMQWlCSkdsbU5P?=
 =?utf-8?B?YWw2V2JQa295b1R6NzJXVHJEOG9CaU1hQWN5T3pzNVB4bmZEWnNhdFYweUhi?=
 =?utf-8?B?bERKWWpMd2FIVzV4Yjh5V3pCckVZVmlwd0tUcG14OEk5N0RjYVlmQWk1L1Bl?=
 =?utf-8?B?cXNQc0J1Y0FyR1JKWm1FUFhmMnZDRnBNUUVUbDluZFFReCtTeFBTN1ZWK1lP?=
 =?utf-8?B?YU80eFYwcGFmOVZlczVjQ2syR2FZa0hoMEhUYUxoaWMxbk9ReEtubjJsRndt?=
 =?utf-8?Q?/uT7uzN8IYUdNw8iAUL4FmnKR0iMPfqA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHoxY21MYVRwcmdncXFmNWN1ZXRjZ24zVVNuQU1reHBuVGNSbGxZOWhZbHdG?=
 =?utf-8?B?d0d5M2hxM0F2NzB0cXJQN1FMK2tlYzRia21xY2N5bi80WFJtU0dJUTFqUGtT?=
 =?utf-8?B?WTN2NWVrMy83U2JldU1oTkJ4bXI2V3QxU0JPaG91UG9BTG8zS0Uwei9TTnBa?=
 =?utf-8?B?ZVBYeldkeUlSMXpuU0s3NnBWVzlnVEgvWGIzcTFZMTJaS2lLT21tNGRJSEha?=
 =?utf-8?B?NlFiSFZlRmZURG1JejBnaTV4M0dwZ3dYLytZOG4vT2wzWFFtajVMdE81VWl0?=
 =?utf-8?B?MFBnZXF6MUZTanE2WUc4dHcwTXE2Q2g0SWxUbEcrRmJQSkJicDhyTDFWVXYx?=
 =?utf-8?B?Z1lHdHdoNHo4bXdhT3BKbzNmSTE2R0x6dk5GUmVab002VzQrM0R4djhxRWti?=
 =?utf-8?B?VlhLTHN3OG1pbVpQYkU3M0xhaVlrVE03S3NGcVRYUWNkTzRKV0VCTzJDNkhr?=
 =?utf-8?B?ejd2YmRNVitVVzFyUG0wYUJWRTNDMDlTbTR1c3E3NVh5QTZjVXI1b3N2WHNT?=
 =?utf-8?B?NHdldVFGLzBtSHExeUxaMkNYRjhITVV6dHNTNnJmS3hJYytiU29XaFhlc3ho?=
 =?utf-8?B?TkI3b21BcWYvMVhmKzE2NHJhTUk4TkJlWVZidEI3UFRYM3FVYTR5aEhCSTl0?=
 =?utf-8?B?N1VRTEdad2lPeWRxQkl4UFFhdnh5QkhJQWdoYStQOWZXYjRHU0gwWXlTRVN0?=
 =?utf-8?B?WmVZV2tid1lObEtIQ0tGcndUL1ozdEtYdXVVRzVtUklla3djSjQyWCsrNWZX?=
 =?utf-8?B?VkIwNGltRVhmaktTTU9FK2pjSHpac2JXQWEzTi9HYkFjN2MwZkNaTVdLL1NK?=
 =?utf-8?B?QSs4TFh4akdVSTgvMm1uOXpxSnlVWGlrcGxjY0xWQjV1VWVIMXdMZGFVSVlh?=
 =?utf-8?B?QXM4Q1I0MHR1WFpQS1pJa0VadGJqSTlteGpmZ0lVQzJNSS9HZG9seDVOMkE0?=
 =?utf-8?B?enI4L1MwYzhkejU4YW1IWlhxZ3E2Zm0yN0s0ZEV4Y21LbXMrMmNONjIzdTlk?=
 =?utf-8?B?Nm92UU9qbG5Ia1dNM3hzRGVvTUQ2c0xDTUFGa0x0VEFUSVJWeWVpM1Y1RzNw?=
 =?utf-8?B?TE1obHVHOGd2eGdhSG1Fa1VqL3NSKzhnNyt2OUFkL1IzSnIrdWZ0KzNXWlVa?=
 =?utf-8?B?Q3BqelpEdTEwbmpMTFpiN2VReTYrTkd2YVEvSmZScVBnQVJtbUhhNDJFdllW?=
 =?utf-8?B?U3FLbDNKdTVXMEliQW1zam9pVjk1aS90bk1ENUw3MlFpeUJkV3lGY0srOWUz?=
 =?utf-8?B?K01TZ2FyRlZuOHBCdXpkMjNUOTZzaEMyTHA0SVFOYUZkWFRKSFVNVkx1WE9O?=
 =?utf-8?B?NnpZU2VTUU9iUkVSenk2WnBpQjRTNi9CQXplL1ZXWm5QRmU5OXo4dmhGd01J?=
 =?utf-8?B?RmJ4R1NrSGI0cWZJTzZHKzNQOHBNREllNkc3aTRQV0FJOTVHRnd3elJGRU45?=
 =?utf-8?B?elEzMld4a0lTaHBIM3pJQStYK3RIU2xoZ3ZlYVEyMDJRTjlEb1ZDTU9IYmt6?=
 =?utf-8?B?WGVrSm9xZ2R4cXhvaE1FV3k1cTdGWGN6bHNERGc0Y0RYU3l4KzdRc0w4WXBs?=
 =?utf-8?B?eDNpTTJqNXJ2dUpuSWErcmIwOTQ1TGsvMk1HQkRBSjl0enZ5STdqa3IxelRB?=
 =?utf-8?B?YnlTY1k4VWlUUTNkaUZSV2JiODliWFNOVWNVR3VjeCtncFZIVlduaE5iZUly?=
 =?utf-8?B?MVVDeXY0SEVzT2Y4aE45ekdpSGZlZmFMTXUvVVhOVnVKby8zWGtSZjZrTG5r?=
 =?utf-8?B?Znl4a1psNWtwa0NPQ0tDa2lFVkdpWDBZQmxZckdvUWh5RVZBQmtrTm4vSlkz?=
 =?utf-8?B?blZ0aTlhZEV1d3JJdWMrQ1k1R2FOZmNjM0hqSzh0V2hmQkxhL1BDYUd6Ri8w?=
 =?utf-8?B?cDZHVUFKZlRKSTl1S1pNcmlQOUlKQWZRNzVtNmlPTzFwRmdPdkhXWFZWeTdI?=
 =?utf-8?B?azYzZUJIb3dvOUxCRlJqYTluVHAxMDd5ajVqSkRmaS9WSC9CSDhTVUMvRnda?=
 =?utf-8?B?YTBMZ0tUR1hqZ3A1VFVNUGY5eVkwcGZjSzJHbU94aE5vQXhTUGFsOG85K3dt?=
 =?utf-8?B?Q3BUQ0c5UFE3NXFCOUtCb3JuRDBkRHU1NzI2SFE3bXBUSm5xbFlsbCtHMEFM?=
 =?utf-8?B?QSt4Q1JYWjZPcGV2U1loa2lhRVNZTVQ4c3BBckRkMEN3R1p5RmZvODlxcnhE?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f47f1e-7d63-44fa-d1c0-08de28f6e491
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 12:09:59.8210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/MnP0WP/RffDsQh7ziATeiv4FIJWI3ng1TijeU9bQGNfC2ycjsZ4cyjeqiJlLVKNiFrbXas6a4PLjwNjEOi+nDeM0aJAMTOt7whjqJbWik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7215
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

On 11/20/2025 5:55 PM, Stephen Hemminger wrote:
> Although, it is not possible on Linux (which always uses /tmp)
> the compiler complains about possible snprintf() truncation.
> 
> Use existing code to make empty tmp file which puts the
> OS specific code in one spot and avoids any races if
> two tests are run at once.
> 
> Fixes: be22019a58c4 ("test: restore cfgfile tests")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
