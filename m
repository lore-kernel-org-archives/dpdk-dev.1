Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA0BC54ED0
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 10:21:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBA544060F;
	Fri, 23 May 2025 12:21:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 5E035400D7
 for <dev@dpdk.org>; Fri, 23 May 2025 12:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747995685; x=1779531685;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ykizDJBTJEV0Fz8dBNyaNy/aBZDm7tYNq18Q74sL+Ig=;
 b=C2jAPwrJ7ziu88i1gLMJ4rY2GzWVhqWZewOTieBrPhW2t7RzVnUrOIrh
 dpvB23TVq29wKO0oGA6Y68OyNuV/k/hmZXDrC+kErLwul2BH9s7B6sJUy
 b+lRALKctGnc0aqQqd9mRio+5Sjc9ZCoMbAfqddyuwvFwO490BAnQ+/XI
 pVs7ugTYccJoGMnGmM66tB9E1vCciKKdEhWgJ0QB68qYkabp6lj2WJTmO
 E7MeaFIvIhcMpr5zspDqo4NNYk62+OlMHtZgmoQWN/MivKy20fTaYVV/K
 Dyu1y/UN6YGXh/YhPwIBwEYVXwhDL3GvGi+fgSewT9igL1IpIXXvUyK/+ g==;
X-CSE-ConnectionGUID: Iw3w8zifSVKH1rbP6yY4Qg==
X-CSE-MsgGUID: S3DE4Oo5TJyq+eku8P9wFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50212919"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="50212919"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2025 03:21:24 -0700
X-CSE-ConnectionGUID: JSBNxzUbS6qG802i87fr4A==
X-CSE-MsgGUID: U80FpbZ9QnyrL2POYqqX5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="178225760"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2025 03:21:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 03:21:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 03:21:23 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.58)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 03:21:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTcOb05GJRs+B8SNyocyQHZ40H3Z2UjYprxG/9OFg0pQAa92xV5+6cMoiFzKAKh/6fU+E23PGsqc3I4UgPFPJ+gdu8lu1bMKKsDkJfc5MBQNSQ1YlhEdQI9dUck9hmZbCShJtm/9ApyL6GnsdMeAsp8v2bAg+5VX9op2zN6cgM9ZkiDpWMApvXE61Ksx+gy+DOW3O7xBPB7U4zCTM7aAChq1OqfBafij6zwPM3srGt2ZpaBS1+7wL2OYIH4gD1eHz5OLcVI92hi2Smom1tAWkIMJg2beawPe3cMbM5ejt95GvFYPXqVEsP3Iz2vsuXBGtzghppvVVe4u7K8fjs4yig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJXovJEeBABWRtWaTUYJb11A6awxNAev9o2Jte6/cGs=;
 b=O10oOYqjZOn2429VoyrObAHnDpqRGEwOFFGjYztBLT7zUrorBYoi8qFtc4nP8XeFQgq7Aivv21PPkLiHrN2idWp7BZQCywIqWLycqwSRhm2qPlDJwVPNBElFXPw+fDLNU7PCEQvehp/ik0mbxhLb7ECsG/KDZrP+WXBFqtBz0JAT2VCyM+uG7UUhvmT3JHDQjdfrTsCDWg45lOqjstw17J+rmxb/tnGp+Hq2unoccaW3TO8UysQ5pqvus1716QeQQMkw2ZFZUYgVcoE5oj8x/gr5a2lS75IJONVRSPaPCoox2n+QPfchr9aNRRBoVxmZc+kXsvQb9iDuMB5JQPV+eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CY5PR11MB6488.namprd11.prod.outlook.com (2603:10b6:930:30::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.33; Fri, 23 May 2025 10:21:20 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8722.031; Fri, 23 May 2025
 10:21:20 +0000
Message-ID: <762c8bb2-f0b3-4cf5-837c-8297851aa417@intel.com>
Date: Fri, 23 May 2025 12:21:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] cmdline: add floating point support
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
References: <ec8528874aad76348f27c551289e1729b2fdcd25.1746631324.git.anatoly.burakov@intel.com>
 <b9f8ac77e4eeecd67a83d72cdf52ef3e08539bab.1746631324.git.anatoly.burakov@intel.com>
 <20250521070538.29f64bc2@hermes.local>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250521070538.29f64bc2@hermes.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P189CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::21) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CY5PR11MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c37c07-22bb-40f0-dd6f-08dd99e38f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3JpOUswL3labUZWay9hNERIWWdaczM5U21TMU1SaFdrNE9xY1UxRU5xTDNB?=
 =?utf-8?B?TGVZYWJNTTV4elZQZUxURUJmaDRaUGhzNWIxVlFHUDRiS2pyWnhGaWFZc2NT?=
 =?utf-8?B?Uk9HeFFCRUpqbEluT1FqWFM2SXpjbkJFWG05R2NQc0VDdkJrUk9WZjh3Mi94?=
 =?utf-8?B?MnhDaTRpcTEvNEFPYU9Nc2pibG0rd0dXaWpCWDFLUzRLRE44UGdhTE04WEVq?=
 =?utf-8?B?cDJCaStnYTROZnJuWnJSay9QNFl6Rmw3Ri9OdGVSMlpkUzZhSG10SnpQODNQ?=
 =?utf-8?B?dG9oc0o0N1UydXBicWh4OER2KzI3dVR0WDZDdnBIM1hxeUgyZWRuZEVacFNw?=
 =?utf-8?B?Um9qaW11L1c0Y1BtSUpMY0RaRFkrOU12cFQ1L2hxeTlsb2lWK25Dc0xEQXU1?=
 =?utf-8?B?Wm5reGNEaWJLZEl0NGJaNTZ1dzZOWG8xL0tGTGdEWG1YbHZHbUh2ejQxc2hm?=
 =?utf-8?B?cDFiL2RsNlBUMGZFU2ZtanNHRlV1TXlRK0tHR0RLS1JCYy9BWjBROVZFL0dp?=
 =?utf-8?B?MHFnTmNwWi9nUzNGU3BPZk5uTTNXbjF0ZjZjSG1jNkszVjZONlRsb25sOUs3?=
 =?utf-8?B?Q2k0bFNmbmhFYVNSNWg4Y3o5QW5ab0JUZzNpd3J0TnUzWXUyUUwrYU9pVzFm?=
 =?utf-8?B?VjRUTG1jdkRraVBjUFJLR1lOeEtLUjZIcmx3SHZTTGtDVWFTWjhaWlM3d3FP?=
 =?utf-8?B?V1N6R1huKzRsTW1YUTFWeFNtUzBlcnZsMnE0N0hNVm56ejJvUHBGZXg5MXVN?=
 =?utf-8?B?SlAxZC9NV21LNTZTbWw3d1dLT2tTWnR5eGtwZnBiblczN0Q3K054K00yMnBB?=
 =?utf-8?B?dDZ1QXgxQTIraWgxSzJTRjRPRWErLzlTeFl0MlEwRk01QXdCYkhqMFlva0pY?=
 =?utf-8?B?U0dQQkxNcVk0cnZQT3V2MVR4bkEwbm96VGwySGVhbUlhNjNkZWU0RDlReVBR?=
 =?utf-8?B?eTluRDRieXFhaFlYWm9EaUVsakl0ajR3UEc2TnB6Z3FYV29FbmZYWGpOYmly?=
 =?utf-8?B?YmN4bkp6amhwODBaQ3NPZXRpNGhCRGUzVkhCK01waUF1RlJ0bXB4bC9ES1Qz?=
 =?utf-8?B?dUN6RmFwcGhoTVVCcnZ4RFNWMlgzdGZLQ1BiZ1RtT3B0MFhqNy80U00rQ2xJ?=
 =?utf-8?B?Znluc2tnMld2SVlDR1d5a2d2LzdPR0xBSWVDK1h4Z3lDVTZRc0xFS09UaVN3?=
 =?utf-8?B?aEN3QlZJUnVnVjlqRmhTN1BsUGswMCt4Y1F2RmxxYlBnSkxZRXZXNjF2UkFq?=
 =?utf-8?B?Zkc0V1lwWXpab1ZKWjc0b1NvUU0wQWN5UWtheUs1STg4LzVyc2NqVU9sN2lw?=
 =?utf-8?B?dXphTkVValV3NXk2T3hNZjlLa3d5c0YwaUQ5WnZDQ2tiUEMyVFhOZ2JVWWJL?=
 =?utf-8?B?Qk1pM0tuc3djaHozd1hOam5XUkovWS82SHdGMVBtMUV3RlJZcDZicjNXVGxo?=
 =?utf-8?B?QWdhWjN2b2tSUEkxam80TCtBSndHRjVUK3krVm5EWDZVejFWSjNEd3A0TVho?=
 =?utf-8?B?a25FZ2NvcTc4V3RDYzNmckI3N0RDQVdMMHpqaWNVYnFBK04xMjNkVnZxdW9a?=
 =?utf-8?B?TUFrZ2R4cjllZFRXVEhlZTFwaGpIVU43bjUrKzhKM0tXcExhMytDdkU2dE9X?=
 =?utf-8?B?VHJqSmR2dy83d3FZdHJQcktrcm5vcTFQMnJoQmF2NVRUSzZLZTltOTJadkhK?=
 =?utf-8?B?ZXVYcG5zUFU3Y2wweWs2djRCSjljNFNRSHM1dkxPbnhBN05JT3orK3pYcHFZ?=
 =?utf-8?B?SFhkZkE5OEJ1bVd4WW5qckhVZHdvRjZuUUh6Mk9iK1dFMHdwSFM3aFhRTUFL?=
 =?utf-8?B?K2p3Z2pZMW52bkJ4ZEc3ZVYwdGgvSnVBNXc4VHkwR1I5MEpjNUVKeTN2L2J2?=
 =?utf-8?B?R0xZaHZTbDVTcjJOZWNrQ0FjcjdzcTExMGhoWG53Z3dQdXRkZnIvWk5nOHJq?=
 =?utf-8?Q?dNWXQIuSn8E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmlPOC9ZNGlzZlAwOWx4TFNweVUzSHh3bmtIYVNoeXVhL1dqNzNUYlJISjJu?=
 =?utf-8?B?YksxUno1d09yQXZRWVkrS05EaW53WmFBV3ZoNmd0ZkRZNTV1VkNVZUtVSlJp?=
 =?utf-8?B?alhmaTFOYjFLSzdOZ3duczNIeHVQVis1cUIrZUt5OEx5a0RiSDhSNkN6a0g0?=
 =?utf-8?B?U3BFbXRoVHRSaDdYK1owYUlwaGRsZGQzeVpjV3Y4U0RWd1ZwNlpWSitOb0J4?=
 =?utf-8?B?Ri9YNlBaZzJCSk9NZk8wNWc0MlI0a05LNk9Rc3BmQ0lVeDV1R3I5bHlqVE5T?=
 =?utf-8?B?dWZ0Z1cvSlZmRVRGTHpiUVJKeG1CNG9MZndtUGo0RThUdVhrMER2dEdHa1Bv?=
 =?utf-8?B?aitvOUYzVXV4YWVQV1BwT3FJTHpOSUY1OGVrWTN6QnVodkZlMUZWM0Fzd1Zx?=
 =?utf-8?B?ZVo3QnZBRlFGd01xMkdkbmJRTkZkdGlYcitqRUdoSFdKYUtVT3M3Um1OVTlr?=
 =?utf-8?B?bVJ5Q0p6OVQ0YjBpVkZMZ0gvQlM5UkYrNG15d1JVeVladnViQnZldlJMMmxm?=
 =?utf-8?B?dEU3cVlGN1gwSjFZVXdMZmgxYXhNZkwzOVI1aVVPNHMvZWpkVXJNeVFWQm5i?=
 =?utf-8?B?N00xN3NCaDF4R2JEWFVNWXdkdU1JU2lmR1B4R3BqelUxeHB5L2tTMlhaUUwr?=
 =?utf-8?B?K0t5U0dlcExpK3g4UE1ESGVVc21xbzFNcFFaVndMdGs3TzRiWG05Vmd1allu?=
 =?utf-8?B?YzNYeTlnVGRxQzBxbDI5VmRYbU0zaEdXVG1GUTE3cXZjQ2NzOFJlYkF5UXZ6?=
 =?utf-8?B?cXlweUkwTUZjWTFzZFhya1dsYlV0K0pZeHZhL3FyODZyTWFJMmNzUWlUWXBW?=
 =?utf-8?B?SGo0TmFUMUpYUTMxa2tnVm9yOEdWYTRRSmE1dEJ1dEVnaFUrVk1XdERCUUgv?=
 =?utf-8?B?elFBdkVRLzVUVnkwZVhoL1pxakdteTdUb2toT29OQS9xQUF6bXFjRUt4UkNO?=
 =?utf-8?B?U3FJL1VQQm5vOHBJTXdwU1o0bEtrclZNRWt2T0pjZDBCalAzVGFIQlp4MlFz?=
 =?utf-8?B?RUxuMS9QeHI5TGp5SWlnRGlTait4dHFBdDV6Qm5xc2sxeVZpOFpleDVLWW9U?=
 =?utf-8?B?Ulo3akg1dGlWcXo2NFdoSWJGY2ZnRnlOeUZSNHlzU0VjUmJlcXY4eTNNeDFP?=
 =?utf-8?B?SitHOHI5TGRzM0VpNDhjMUQ1V3pvUU9wL1kwVkRMbUNQbmNOY2hDUEV4QWJh?=
 =?utf-8?B?Sms5a0w3Wk1rR3diTHdaWFcyaWhFV3UvSXh1QkdaZ3JKazErUG9mbU1OUDk0?=
 =?utf-8?B?aGp3QUZpeHdzSXlFdUpLRk9qdzNiRGhDR3U4Mk9ydEU5eFIwTzhjQWNyNmJD?=
 =?utf-8?B?NEYrd3B5bUt2NSt4MkE4UDNKYjkyREdSdVVweS82TXZTMCs2MlMzWUc2aDRy?=
 =?utf-8?B?ajliWFVPZ29zTjBDSXlKL0czaFUwOHppcjN6KzMxd3dkeU1KVWtXZU1aSG5S?=
 =?utf-8?B?T1JZamJxdXozeUxTNTB3R0lHZEN0MVU0Q091NTJpTTNYL3drMEVLSm5YTTRV?=
 =?utf-8?B?eStwL1Btbm5JWVgvQnAyRkJCRTlyT2hPbkVjSGJpTWVRMFZ4Q1k3cEt1dThn?=
 =?utf-8?B?ZGdNak1Fa2pyZnI3Q0Y5TWxISllrSSsxOWtsd3JMM2ZZbUhpSmNBZlN3MFdm?=
 =?utf-8?B?UHdMWm9wc1NHU0lWUytTMU95WndSVW9RYXorZStSZXpFOEdEV1QrZy9iS1ZU?=
 =?utf-8?B?a0ZLcHBpV3NNQ0F0RVZNRmFGbzhqcGNVdHZQTHhpVDh1K01OK2pqNy9yTWY3?=
 =?utf-8?B?em8vOTV5OGtMTW5TODVueE53VGg2c2Fxc2sxMWZYUGpSajR0MmRiR3ZsYWJ0?=
 =?utf-8?B?aDU4UGV6Q0tpVmdKcGd6RUs4UklSMjlsZDBBYk95bFdIcUM2TCs1MnBLRnlS?=
 =?utf-8?B?UHlQclRmSy9rMWtaOXk5dWRObXRFQnd3WDZCY1p0WFV5SkI4WEZjMy9TTnc3?=
 =?utf-8?B?eWR0WllOZjk2RzNNdi9LdEl6eTluZlZhV2c1OFA3emlqclYySFZEUG5DRXhL?=
 =?utf-8?B?VGxFSlU2VW9KT0RnemRwTmZrcTFBa0hiWFN3L0czSDlkMmMyYlhxaWw3d1VV?=
 =?utf-8?B?YWxteXVkQmRSSHVyRHk5SktyYXJ2b3k2V1pucFpnY254NUcxQ1lxd214VFdr?=
 =?utf-8?B?TUhmMkp1bFRTb2F2TWR5MXMzZXc5QjlzL2hBZE1jWnJvRU41VGVDaU5yaytZ?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c37c07-22bb-40f0-dd6f-08dd99e38f5c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 10:21:20.0582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2FDJeWoR0ixlcLGRnmkYbwgJzZo0OC7Nb5Tc/NqczJ/n6MuTroTX1o/yJwyqYB/HxG88eGYpvDZQH/uDDBO8Mbunv+9gnGJcgBjnRTg1Jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6488
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

On 5/21/2025 4:05 PM, Stephen Hemminger wrote:
> On Wed,  7 May 2025 16:22:11 +0100
> Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> 
>> +NUMERIC_TYPES = {
>> +    "UINT8": "uint8_t",
>> +    "UINT16": "uint16_t",
>> +    "UINT32": "uint32_t",
>> +    "UINT64": "uint64_t",
>> +    "INT8": "int8_t",
>> +    "INT16": "int16_t",
>> +    "INT32": "int32_t",
>> +    "INT64": "int64_t",
>> +    "FLOAT_SINGLE": "float",
>> +    "FLOAT_DOUBLE": "double",
>> +}
>>   
> 
> Is it really worth having both single and double versions.
> Seems like unnecessary complexity at this point.

I'd argue the same about the various int types. I was just being 
consistent. I can remove the single (or double) if that's desired.

> 
>> @@ -291,6 +302,25 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
>>   			return -1;
>>   		}
>>   		return ret;
>> +	/* float parsing */
>> +	} else if (nd.type >= RTE_FLOAT_SINGLE && nd.type <= RTE_FLOAT_DOUBLE) {
>> +		char *end;
>> +		double dres = strtod(srcbuf, &end);
>> +
>> +		if (end == srcbuf || !cmdline_isendoftoken(*end) || isinf(dres))
>> +			return -1;
>> +
>> +		/* we parsed something, now let's ensure it fits */
>> +		if (nd.type == RTE_FLOAT_SINGLE) {
>> +			float flt = (float)dres;
>> +			if (isinf(flt))
>> +				return -1;
>> +			if (res) *(float *)res = flt;
>> +			return end-srcbuf;
>> +		} else if (nd.type == RTE_FLOAT_DOUBLE) {
>> +			if (res) *(double *)res = dres;
>> +			return end-srcbuf;
> 
> Space around - please


-- 
Thanks,
Anatoly
