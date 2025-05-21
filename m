Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3D2C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 13:07:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCD1C40144;
	Wed, 21 May 2025 15:07:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 41B63400EF;
 Wed, 21 May 2025 15:06:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747832819; x=1779368819;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=M4ASSqXDxCjRV71jDNjx+bLHhGj8K4oiu5Efja9ENXA=;
 b=CcJqbvEyKngLzycgRDe0krlyq8z+d7LgxZfdBv294eiKR0uZyso1ATPL
 u4mD3TLxGYncRESu3GJGzlMw9WUeVZoPPOPtxw6HBknayJaKzxdj3nrrg
 9EmnhQh4DHv9Fz3moUB6mg+fk3uBSBDl4CvVmF+E5YjhOOxCqJatCZIAv
 zYmZ1bY9yAN+Ko9mf4T8SPRaWEC17uWqvcG3UpwHElBuRMJLTdbLWOQtj
 aMREK4LarPGcyUf8+YQLrsoMyJkhrEvQfzGr3qTVcG32Pc+IhZPKO2Zje
 xPPwTrADhKamuzqE5R39MEXZjtJYGtQoFJMGFRlpL6hZPjHr+dZt/tJLA Q==;
X-CSE-ConnectionGUID: EiOT3VYKRK2FEBSh6c2alQ==
X-CSE-MsgGUID: XkIkuuS1R4qmMPQpk75NHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="52435950"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208,217";a="52435950"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 06:06:57 -0700
X-CSE-ConnectionGUID: 2Lk9kLOYQIu/MB3mujAapw==
X-CSE-MsgGUID: hIHd5Z6rSKGaPXG5cVoUIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
 d="scan'208,217";a="140478107"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 06:06:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 06:06:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 06:06:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 06:06:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRbz5SkPvIXUBg0eHL1yVNEgW54KwOCNNXRm0znFGAG/nw/2FkyoIdGABUUoYw7qzNsVraCliUP876SdMP+x0L2qsomCOALvDamjstbUKu0dgSNTPu7PSdwxSafhObAhd8yrkqmfG0qtSk5qwe9t/Q76eR2CNHkQkmvP0goioSTh+qqEgsBgMJ/NJBqdt7fVJhvFQbgcoIR91d7WYr49M0xI0jaU9IehhI2zJkXbnBG4+TUb7KBIDh0TPjSydUd+uQ/9YC5lJFkehd0sEhq6i9w+ZxXltWP0iW76YXJLSo+x6qmEktN9wg6itxI5dqJ19huetdam2VoQq0QQlPsYjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzTIuWEEOeiReBsKuY8soMuSjJYZC929v0wp+uBiZ78=;
 b=o+jXThJBOZ0p0KpV02joSIQCoqiGjjl5ESxhyRLAmL2LoI2tkVeNwcybHc2Zfkq8nXcr/cHqFq4tD0eNHPpfYUWlhDvnVh/Or4VqUTpHbDWRqGSsRa+uDnetUftJY/vBqxO0q4pW7eIz1gUgWNkci7L9ewy9duz3Kpe88/w8RHvS7/l4CBaxN0kt7VYWOPpoXAuhN2RkQ5QV5votMlik8EQ7T2DAYA8WzERjHUDKk2M/KfuJObL6I9H66DuERL1vJZejZWEaKlCrJqQk3qQUFFnp7IJUv55KO349FqX6a1s/y+1YXfphkUijLaeJAiQbmGGFfVXwro5jEnbn+FITBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14)
 by MW3PR11MB4524.namprd11.prod.outlook.com (2603:10b6:303:2c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 13:06:26 +0000
Received: from MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::6444:ca4c:aa3e:f8d2]) by MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::6444:ca4c:aa3e:f8d2%5]) with mapi id 15.20.8722.031; Wed, 21 May 2025
 13:06:26 +0000
Content-Type: multipart/alternative;
 boundary="------------0BQJatcEw0QKhu0ku9KIZKA4"
Message-ID: <c4352c31-dbe1-4790-94b4-018a32628aba@intel.com>
Date: Wed, 21 May 2025 14:06:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] power/intel_uncore: fix crash closing uninitialized
 driver
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, David Hunt
 <david.hunt@intel.com>, Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Tadhg Kearney <tadhg.kearney@intel.com>
References: <20250515165854.1087247-1-bruce.richardson@intel.com>
Content-Language: en-US
From: Kevin Laatz <kevin.laatz@intel.com>
In-Reply-To: <20250515165854.1087247-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DB8PR09CA0007.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::20) To MW4PR11MB5872.namprd11.prod.outlook.com
 (2603:10b6:303:169::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5872:EE_|MW3PR11MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: c6dc6d60-7a81-4ec8-5d1f-08dd98684b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djVVaU1pM0JNc1Z3Q0RsUU9oc0Z5aEZkbVJqVmoxVTBRTEdZaXlaWXNUUFNl?=
 =?utf-8?B?eVRqL1JHMlpZQVRCa3g4NzFZaXMxWUpsT3lNYk9aWm9yZCtmeUo5dzluSHZ2?=
 =?utf-8?B?TjlaWlh3MWJhaVhMVGovOEZSUzZHeHI1d0NwTGFVTUk0ZkdFWnpaV2U2b3Fi?=
 =?utf-8?B?dUg5Vk14WG5EWFhUOUhQSlpOTjJZaHdUM29tWll1Rlg3WXdxNG5PdDU4NUlq?=
 =?utf-8?B?c1RBVVlsajhYc2FacEIydG9BWU1CVFpjck1LR20xdTNwaEdZdVd1ZTJXVVNZ?=
 =?utf-8?B?N09Sai81T016dTRWa0NUdnZEeWJ6c1ZRNXBNc2lCVXJ0dUtFVGNNdUd5YkNM?=
 =?utf-8?B?WHpaNTVza3J6UDJKRVkyM2xISnJ0SHhIVE5rdkhDbm1yY2Z3SUdSQTdsbFd6?=
 =?utf-8?B?U3VxOW9zOXV2V0gyMmJ6cU00Tkw5TG9SdXpwRnBieTA4V09CMlN1ZklRR3lG?=
 =?utf-8?B?NlNsTDJoRXFyRjlHSk1vWTE1emV4c3ZVRk94Zm1nWkNFN0R4c1A4NTl0dVpr?=
 =?utf-8?B?bGs0TGVaRUMvcTlYVUZqSjFnL3dES1BpcmlFenVsNi9qbEN5N3FDWTY2VVo3?=
 =?utf-8?B?TmFpelFuTis5bHZsUjY3blVTQjJKaEJlMkV1R2tEUUgrZXRPTHZBWVlhM1c0?=
 =?utf-8?B?a1BTdFk1bUJIV01ZS0Z4blZ1Q0FCWmFmbjlOMjZLVnhsVUhCUURMTGRTNElu?=
 =?utf-8?B?Rm04OGoxSzZTUGRHL0l4OE1FUXVUWUNtRGQ3VFM5VHVZSlhkSUQ0R0F5T2Q5?=
 =?utf-8?B?dDNWVTM1bmNFcmF0NyswcHNtYTNPZzZqOWVMK2ZheEw3Y094bHpBRkdDMHRa?=
 =?utf-8?B?cEJRdGF2dVF2YmY1cVVqZURVeDYrdmptQkZPbm5CdGJEbnRSV3ltZ3J1QnZH?=
 =?utf-8?B?UVJ4cTVHa0R3NTgvajJsdlNIbCtXcmpaeTR5djdNVVhVSk9MQkE3YUlJdzFt?=
 =?utf-8?B?RitHQjU3RlQ0ek0wU293dkcyb2lvdE5RMzNXODdXdDczWFBvcmhYZ1ZoVVlQ?=
 =?utf-8?B?djJvUGc3OWV6YXFoQ0t2QnREd0xuaUIyMU92RGFwNUkwSVZXZU80TEo1WGRL?=
 =?utf-8?B?ME84THk5K2VGTGZEcTFwa3ZCdHZWckVnSHhVeHdHY3NvdStEVzVxSjB5VGdy?=
 =?utf-8?B?WE1aN0Q1NDhmRlp4akxzZno4UmVXN3lkOEo4M2dOcGgydldURzJoRlMrSmd2?=
 =?utf-8?B?R1ozeEZsbkdUVWJnODAyK1N6NzRLMVFDbmdQbk81d0kxQlpQTWpiMzEvZ1Fp?=
 =?utf-8?B?cU15M0JEZGJqOXJEM1J1V29RNkk5WjhoWmpkRDVnS1hZNjFiQjhKSWlYM3JS?=
 =?utf-8?B?WWJEQnlFdHBIMFVBb2lwaXpzQTYvZGx3YlZHamUwOFMxNzRMWXdpcWt1Qllp?=
 =?utf-8?B?NkJMcndYS2ZuR25VcEhxM09GUFF6SDFab3YwL1BhN2pwNUo0djNsZElIdCsx?=
 =?utf-8?B?WTdVZTlOcTUxQ3p6cStHbVp6a2lrTUxDR25CTkp6ME14THgzN0hpZERVeFZU?=
 =?utf-8?B?a29lcGp4NVFINWdWUitMUkdmRTUxMzQrNENkMmxpK2p4c0F1R3BEWmU4cjBt?=
 =?utf-8?B?eHVWOWxPVDJCR1ZBS21NWnI3am9Ic3VCRzV0VnRtVFdYVDJrb3RwSTNIZ0Vh?=
 =?utf-8?B?SmdEOVVpTFNxNUl2SGVxNzlxYnAwb3h0YzlnS01rNjdSTWZ2SmpNUjkvUEh4?=
 =?utf-8?B?N0VhcGljeGZUZXRDUW81eGlDdDYxUDVlRzUyOTdxOXAzTlVVcG8zV2hSZVlW?=
 =?utf-8?B?MUtYd2xtRHBxWXpOb3BWajFVT0IvZWkzTWFINUIwUXV0K21aczZNNzdCblFL?=
 =?utf-8?B?NW9xWUltU3E2b3VOV1JwcnF4UDZuV3JTbzA4dzQxcnM1OEV0NE9xNGxIM2VS?=
 =?utf-8?B?VU0rUWxmYnNUaTZDSnEreEFFd09XRDhlWndPNy9lZmtQK1NJcTZ4V25IY3lV?=
 =?utf-8?Q?VkAGsQKI4EY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5872.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWRQRUZSMFd3M3UzKzBjMmM4US9PdGxvSkF6eUgyNG5RTlNrRUFLZ21oSWhH?=
 =?utf-8?B?NnAxYitTZkMzT3p3RitvQWNseWZkdkVrTGhZRjdUaXFCKzVadHMwaTk5KytS?=
 =?utf-8?B?azh5RW55Vk9ZYXBrdmhpWmR5dGJSbUZ6N0dIVEcxNmo4VGxOWjZTT2JLZWRG?=
 =?utf-8?B?QnN0cmlYWFFNZVBhbFUvc09KWkF3ZGFKa2RPdVkwSU1wdXRkRHh5ZkU3U2pR?=
 =?utf-8?B?c2hsNnJab3VTa25MenZVTzR3WWQ0dW5Jek5jM0QzVUU5NVVzVWcyWHBjZVRT?=
 =?utf-8?B?cHZnQldDRFFnb2ZiVkNLTlYydThKVWUrZHp3OE5nWmJUUEZ3Mi9PcWIrNTZ5?=
 =?utf-8?B?ZVhTSmN0U3BpS01nR2hPalNFeUJNTzR6VGRmUWJsVnU4Q2Fmc3k4VUg0K3RW?=
 =?utf-8?B?WGxRdnpIbUFSb25LekRpR05zZzByMnBTQWw3aVd6TWkrV1R3MFhFT21scEVm?=
 =?utf-8?B?UEhycEdjcTkrSnUvQU5FRE1rRk9LaEtmTnhhVkdZeFY5Y0lYOTlkankrcThm?=
 =?utf-8?B?NEsxOFRMVXJjdURQRTlzMEhWRlZiMWdOc3NDMTA1WFV1OXBRdE92aURUTDMx?=
 =?utf-8?B?L2JJZkNEQnQrcHhpY1BORW1jZzhFcGRGS0xYcjBDbUJXV1JabVhVMmFpN1RY?=
 =?utf-8?B?TUtnbU5CZGVPeE5ES1RIb0R2cFFPTmtTdWJOWERzWHRFdjZ0aGdMd0tPWkw0?=
 =?utf-8?B?Qnhrd3pFM2prQ0F0TFJrTFZiNXRFMkNmNXNZWW51cnZsN1FycHFtMnAxZ1F3?=
 =?utf-8?B?aHJHcVE0M01kbndOV1BQd2ZaL1piL1ZXcnQ4VHgydnNMK3RsbWlnR0ZQcTZy?=
 =?utf-8?B?NE8zU0JzZUhTMit1MGtJeno1ZnBIU2ZXcjM4Z3ZybWc0VnF1V2lwbnYwREtn?=
 =?utf-8?B?ZWRTT0Jmak5vYk1YN1c2WmpFS1Z2UXg5eU15NC9qQW9WS0RBQkdwbHozaU9l?=
 =?utf-8?B?STdFK2NzMXZJWWh0c0liRFE4dWJEV0FhZG8xUXVWdldpYzN0RitqQ3dXb2k2?=
 =?utf-8?B?OWYzRXMrS2paTVN0Z0NiTmpWenVIQ2dTaEphK2YxZHEzWWtIZmlSVHF1M3Rz?=
 =?utf-8?B?eER3VnYwUmFaakJVRllwWlRRYldsR0tURm5IYTJZemJmN2FCOWJiZ2tPT0VH?=
 =?utf-8?B?TWlLWkZYa1ZqU1BmUU84bG0xZ05JQU9QM2F1ZDJIT0JrZHNlbTJTT3NOWFFk?=
 =?utf-8?B?M0ZKVTdOZHpuR0FjY2tGQmt2QnZTcmx0WFVuaXdsQThINGc5YXBtcGpFTFoy?=
 =?utf-8?B?V0Q4K2crTHNMZVRiZDBYd1dLblB4Z3VFYkdkaXhFQzMyNG81M013ZjNIZk1M?=
 =?utf-8?B?RjBybUlqUU9iQ3lEaEJUUUZCV1VjWFRaOE55RkRUU2VXMnBLZStQUFVnWGx1?=
 =?utf-8?B?Tmp4K1orYUpYVWNGSGY1ZUU3bE5TR0kzWjV0OEVaK0c2b2Y0ZllBKzArMkF1?=
 =?utf-8?B?dzhWVm4wUEhjdHB1T01xUGxmUHpha1N3clA0NjRQd2JEaFRJMS9QOE1uUlNp?=
 =?utf-8?B?ajNLTDBWYzRWelRjZHRwbURBOEE5cW1SK2trWWIxUWxNazZjbDZIM01SY1NO?=
 =?utf-8?B?MDczeURDdU01bzcrQjJzalJoc2J6dFd0MVVoNWpzMDkzRUdHUmJ5YXYwL0Zs?=
 =?utf-8?B?RE4xQ3J5TVZ5YTFaa2VCZEZDKzY2UXdydWwyQ201dDNyVTc5OWMxUktXS21V?=
 =?utf-8?B?ejk0OHNLV3hGMXR2MGU0Uy9admV6eENhTVhXSTROV0J6cWRKVmI5ejNhWlJq?=
 =?utf-8?B?OEV5Z3BqYVV5TFI4anZna1UzZVRzRmF2bkkxUUw1L2hLVlRIRWNSWC9od2xw?=
 =?utf-8?B?Ui9vSkFmUGIyallxYkdMY3orZm5hYnlZY3VzMWFnUlUxbGhhUHBLS2Vlc2Rl?=
 =?utf-8?B?Zm1oUGk2OUxNUnFqN0ZLZnFKR0dST3BTMlZDaWF4NmZlOFFSQlFTVEx4L2VE?=
 =?utf-8?B?QS9mN1N6QlhPbTdMaURHWEQyYktFQ0FVQTBTOGhlUHhwTFlRRFBudUw4WHQr?=
 =?utf-8?B?UXVkanJuRjRJYlVuUEhxNzlxNEovZlNDVDU1WTE0cUtVMFl5cWhwTS9iZEVI?=
 =?utf-8?B?VGUvcy8yQzZBRy9qaXFSNHlnSytnTHhwQ0drLzgxc015SmhjdDB0Nis2UXU5?=
 =?utf-8?B?amtJdGJLZkRTYkNrN010TkJId1k1OXZSdU82Zm80Nno0Vm1CRlZuK3o3Kzcv?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dc6d60-7a81-4ec8-5d1f-08dd98684b41
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5872.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 13:06:26.7626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sS2idFEXbvN92jFs1cAqNm4gG8UKTnqyTGXKtTP4AjeA2MQZlass0Od+iWzRhkJ5M94PPMxT/zaZF3NY3qdZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4524
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

--------------0BQJatcEw0QKhu0ku9KIZKA4
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 15/05/2025 17:58, Bruce Richardson wrote:
> When the power_intel_uncore_autotest unit test is run as an unprivileged
> user which cannot init the power library, it crashes the unit test
> binary due to calling "rte_power_uncore_exit" after the first test case
> (initialization) fails. This crash is due to trying to write to NULL
> file handles.
>
> Fix the crash by checking each file handle is non-null before writing to
> it and closing it.
>
> Fixes: 60b8a661a957 ("power: add Intel uncore frequency control")
> Cc:stable@dpdk.org
>
> Signed-off-by: Bruce Richardson<bruce.richardson@intel.com>
> ---
>   drivers/power/intel_uncore/intel_uncore.c | 35 ++++++++++++-----------
>   1 file changed, 18 insertions(+), 17 deletions(-)
>
Acked-by: Kevin Laatz <kevin.laatz@intel.com>

--------------0BQJatcEw0QKhu0ku9KIZKA4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 15/05/2025 17:58, Bruce Richardson
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250515165854.1087247-1-bruce.richardson@intel.com">
      <pre wrap="" class="moz-quote-pre">When the power_intel_uncore_autotest unit test is run as an unprivileged
user which cannot init the power library, it crashes the unit test
binary due to calling &quot;rte_power_uncore_exit&quot; after the first test case
(initialization) fails. This crash is due to trying to write to NULL
file handles.

Fix the crash by checking each file handle is non-null before writing to
it and closing it.

Fixes: 60b8a661a957 (&quot;power: add Intel uncore frequency control&quot;)
Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@dpdk.org">stable@dpdk.org</a>

Signed-off-by: Bruce Richardson <a class="moz-txt-link-rfc2396E" href="mailto:bruce.richardson@intel.com">&lt;bruce.richardson@intel.com&gt;</a>
---
 drivers/power/intel_uncore/intel_uncore.c | 35 ++++++++++++-----------
 1 file changed, 18 insertions(+), 17 deletions(-)

</pre>
    </blockquote>
    <p><span style="white-space: pre-wrap">Acked-by: Kevin Laatz <a class="moz-txt-link-rfc2396E" href="mailto:kevin.laatz@intel.com">&lt;kevin.laatz@intel.com&gt;</a></span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------0BQJatcEw0QKhu0ku9KIZKA4--
