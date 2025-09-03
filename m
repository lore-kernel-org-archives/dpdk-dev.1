Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8203CA1009
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 14:16:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6036402BD;
	Wed,  3 Sep 2025 16:16:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id DB71940281;
 Wed,  3 Sep 2025 16:16:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756909016; x=1788445016;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Wxpwei1Z2E9CtbQnjaMk7c/wrfZlO3uvcd0SQ6vS3pI=;
 b=n8QGivpXI/pzg2b9HBC0Xw1Zl3ZX6Cs2StWq5En1W4uT4WsNn8uEwi15
 Uj4AT8CJS9gEMRfiBX323BivVZtwr0alUE0KXkvT6txXOSLV58ao9Nvuj
 LKLnnA1m2BMRgnB4DYCt9rvPLZDRCl8fev90Mmft5spPoab2L4SJrp0mU
 XoKz2jSyeBhkd//hSvg/7TmQ9FbfcaVSf1e3iqiksXAnT9KXZiiAAUO6g
 fFBMHp6qoXYRUnGwbz4k25x6Gmkp6GIC3BcfeImxhot3rZkwvJY2ccEAn
 8A6NPJgrzpQy1/NJ65Lg/TU1bCHqx+APJYfNuRdnPDZ/JyMvBUJHsPVyf g==;
X-CSE-ConnectionGUID: fRtBG5m1TIus9R1/RXg9iw==
X-CSE-MsgGUID: LfmVDh8BQDK1qIJbRZRuSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59292832"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="59292832"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 07:16:54 -0700
X-CSE-ConnectionGUID: 8r/yoQfITVOPGLYiTqe7vw==
X-CSE-MsgGUID: +gW7XqzmRLCWp0HmnqHvrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; d="scan'208";a="176846482"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 07:16:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 07:16:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 07:16:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.66)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 07:16:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLusCAYbgTfV9KynmCANtamGmIts90UHoussIDpGuJoMxmePfhkAfkERtoK8qR+8M97cj2gYrppqTMa3BlbV0osxTQppS3HAebsD7SzQxSPspnVpw63Kpp1Z/WEFEbHMyogzlPUmoH7Tqy6FfPzXQ+ltxUyGRfNJinF8YBJLRTfKEgD4DyUOFgllj9nHpWm5D9xz4T3unTnt/aARnRjE7vN72WtPRqwGfvi1Azt0ctoTzu9+4tJzioWSfJmE5daFS963xa3N3uq95P/f+Gj/MZ82SLuQSQFxByek4oQqYvp7zoJh7YvTfqkDKA8F6ZoaULasFgvnfBLFZjQ8VOkToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIincmwyj282QdagJ4u753lW6/UoDyC6zScpoiKqeYs=;
 b=lT7Cpgo2D5Jo5Evda47XQteLR1N6zXZsVxnUH+rQLATlOpDXLOb2lEn3EKk9yc82728DW9U0SKdo4NGTAZkJnAq1zZWj8izyxXq+49ygZeKvmdQxOcKW7Kk7CPOsAIGYOSvUahPwAmxgyyyYxCkUa2tRq8+Cvnh+8UPDx8ceKxpgEw+Y3mTsacpt8nmgKI49MelkCih/byOwii/dY9WswTeWugLckRCpqikD01soKBZs6K9FwxG35OgKOpg3ydiMIsuXDMDZXrtK3Wz2cp8vymE8qeSIEmiZk1cVaN9AtYvyc1SFB/AWYMHQMoxhNnJVBXJXLZeeOWKjr8Ji7uoDSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM4PR11MB7206.namprd11.prod.outlook.com (2603:10b6:8:112::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Wed, 3 Sep 2025 14:16:50 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 14:16:50 +0000
Message-ID: <7175fd56-407a-4e65-a858-faa9b1f4e89a@intel.com>
Date: Wed, 3 Sep 2025 16:16:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: pci_vfio: Retry vfio setup device reset, if device
 is busy
To: Thanushree Sreerama <thanushree.sreerama@nokia.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>
References: <20250903111723.5111-1-thanushree.sreerama@nokia.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250903111723.5111-1-thanushree.sreerama@nokia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::13) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM4PR11MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: e6753c55-3b13-4365-a4d8-08ddeaf48636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2VQZU1Qdlo3TWhNdXZ3SmlabktPWHRtZkc1anJrS0FTbGMxT1pMZTBPQlVt?=
 =?utf-8?B?NEhabzRLeE9jdWNDSW5IZjF3UzlrQ0VvUjQzRVJPcU1rdlBpRHU0aDFkWkN3?=
 =?utf-8?B?UjhRdUczSTNZWEVScC9Nd0FCT2J1L2dIU3lGeisreVJKbVBucWxKNG1rZFMw?=
 =?utf-8?B?Z1NVNDRpdkczcVhJZGVPN09ad2RyeEJrcXlRK0pTdG4yeFVWRzI5dW9ZVXJO?=
 =?utf-8?B?c0RJVE1Sc3Q4dGljMUlRdWFpUGNQb3d5eXRkZXpwOFM0TDNSNE1JcHlJdE1D?=
 =?utf-8?B?K1pYdXBJZXJWNEl6UUdnSytndis3OXA1OVB2cHR3S3JKNjkyRXN0TDhuSnJD?=
 =?utf-8?B?VUdhak1KUmZHSm5PeHlOQVR2eUJDeERFWmpkK3VOZTl6QTFtZ01NQU03eElq?=
 =?utf-8?B?SHlFbFkwWnRCME5uRFBZdmp3N2FhY0NNcXhTWlpIcFNUN1RVMlg1ZkdqbldT?=
 =?utf-8?B?NDNRV1lza0J3M1VKQXVSalVPcC9YMWs5QVJ5cHp4dEhqMTk1VUpvR25kWER4?=
 =?utf-8?B?TTNwemU5dkhtTW4razJsYVJTOXBYamxvTnQxWm9Ca0kzU0NBNUpLRnR2ZHQ3?=
 =?utf-8?B?NXUyR2lRaXR4ZWFEZW4rWkVTMFlpUWFlcUgzdVpwWFYvcHovZWNGMnlYbGEx?=
 =?utf-8?B?Q2xRdytUbEJoYm1sZzdjaGZlTGhKdUNsOWpjKzdkVDNkRU5oUDYwTzQ1ZzFR?=
 =?utf-8?B?dlU2bzFxZmRRWi9RT09KRXdYQU9QNU5HdzR4UnplWWtEUjNMTnFmYUZQa2FG?=
 =?utf-8?B?N1BUWTg4UEprcmFiRVBWZkMyYkV0cVRXZXpYYndKcHY5aEpaVXdZTXRDaTdZ?=
 =?utf-8?B?QjlzcHRQS29yUGQ1OHVwL05Xb3FiQ0tQYUluN1A1SmVrcGRzSTREdzFuRE1I?=
 =?utf-8?B?dUJ6ekJTNXFxK1M0ZTh3eDdyaFNCTWEyV0RvWUtmNkMwZTM2azVEQkNLOHJm?=
 =?utf-8?B?UmF5MEtkbTNNZ0hvUjBxay9jblE1V0toZy9FOWdkTEVZWHZwNFNMUUhOMHhR?=
 =?utf-8?B?SytQZHlIZU40T1QyeDFCNktldWhEdk9MMCs3bXMzY3R5MTkyRldnTzlDR1Rn?=
 =?utf-8?B?UzdrYngwYmY4ZFYvelhhV0w1ZDg3SFU4RjhZLzFwVzdTWDl4YlRuakZESTRK?=
 =?utf-8?B?dzhiSEMvR214YlRoeUQ5aVZLQ3Z1Tmo3NGRoQUx4K0NwcXh5bysvNW1mbGFR?=
 =?utf-8?B?cDNMcmU5d2pqaXN5T2I4N055Unpvc2haNStvbkR3MlhLbHdmZGl2Mk9ya212?=
 =?utf-8?B?aFhrcFdoaHFQVE5EVkFFUDNZRUUrcGlQNk9BSWZxWGdGSGVWL2UzMHFVU2hY?=
 =?utf-8?B?SWhocUhxcU1hQ2tEbDRsR2c4S0tmdzNKRzl3QWs5WEFNU0VJa1JHNyswS2dG?=
 =?utf-8?B?WnZhVHFQd0F5Q2VYZW9RRzR5VVFxb0g0MUh0VS9HOFJPd0wzVTdSZ01CZVJx?=
 =?utf-8?B?dGdUZkF1Mm5pM0hiMEo2bWtqWkkxbVNwNVJWZTEyMHV4Z0xjYWVwZC9KZU5x?=
 =?utf-8?B?ZkFuSEIvbXFVUFhqNW5ub3E4bUc4aFNnd2k1SFFCQ1BQRGFia1FDaGQzRWVz?=
 =?utf-8?B?VUF5dkROYzdjVEs4b1A1VFZHdlpjUG9JYWUwR05pVXpxcnJLb1RhWWlMZ2JH?=
 =?utf-8?B?NnQ1STJzYTZWYjAyRGVJMEVVNmhsaHEvVkU4UmNxblJ6SzVvZWIzR0hyTEZN?=
 =?utf-8?B?MmtNYmdCZ0d2Vm85M09pRytZdS9aaDQwRE1ES3JGQ1NlNnBEcE9QSmsyMU1T?=
 =?utf-8?B?bWJJMzR4Q2QwV2lPNFFPQ0MxNEJnc0pnL0dpb05JM0ZJTHZQYXMyR3Z4MFBs?=
 =?utf-8?B?cWJNVWJVcGlacDNwR3k4REVjQVh6UktBL3pHMXNNZHRGQkt4cEJGN0NCdlJW?=
 =?utf-8?B?Qi9WektyS1dhUVZtY1dXdDF6NEV2ZWxNM0R4NlVxZWcwVU1iWWQ1clZpTXZG?=
 =?utf-8?Q?xEkHc5A+tXc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djBnYXlVd3E3MDBKSktiN1FjN091M2pEVk5SY2ZiQnlicWoxUlFFRVJ4c2hT?=
 =?utf-8?B?Q2VMa2ZNeGc4N2t6Mnc3eEZHaDBQZml6RnJMa1JPMWFTUHNuVUhtcU0zZmk1?=
 =?utf-8?B?dm9Lb1FHTWZNdmRnajJsMGp5cDZlVEMyRzVZN2txdmdQeC9yQldKNUtBTld0?=
 =?utf-8?B?TkUzY0Q5RXgrQkttSWRHZlg4eWJDT0FEaDlqM2xUR1NLNmRZZnV6WGJrRzIw?=
 =?utf-8?B?VjRmcXp0NWlkd2luNUZ1RGNINElZcW9JeEJaOGJsNlpWdjk2aVRTTTJmcUxR?=
 =?utf-8?B?NFpvb2dENitza2Q5OG5GTkg1S2hsUnhXK1dqNi9kbEd2c01vT2REOFZPMDgx?=
 =?utf-8?B?OEtGMXg0a2JxempWaGR1NHN6WmZ2RTBFUFd1UkpWT09HR016Q1B3a210OXFp?=
 =?utf-8?B?V04rUjI2UFpqMjdzV214MkxSUFI1bmdaMHNNT3hnVmlYWDM5bDhMMDRZWHZD?=
 =?utf-8?B?VkFYZ0xzYitCek40dGpNTlVJYjN6Njh2QlJRN0JiL3RQN1p4RkFIYVBaaEZN?=
 =?utf-8?B?dzV1SWtGMUlGR0owdlc5eGVoMG1Ld05hdkMxMDlaczZ4aTFTMnJpY1EvdHY3?=
 =?utf-8?B?K2I5TnhUZGQ1ZUVhWDRRRUpRRlB3KzF1SmRSZXF1bmVQUVRvdmM3SzFoaDRi?=
 =?utf-8?B?bWh3ZHJnd3ovdWlDNUJjZG5FMkhxb1BmaHF1LzIyQkp0eHFLOGRjWnFtSW5I?=
 =?utf-8?B?dk5lS1ZRdWcxNUMvQ1Zzc3p2dnRtQlJaMW1FNUIzbkxxM0F6Wi9tNVNVNXox?=
 =?utf-8?B?YlB1Znh3SFNPemdIVU1BbXMvUHR6MGFqekNRMElMQ2EzOGdWeTJqQm5GVk9x?=
 =?utf-8?B?WXVNMG4waW9idUVhTndwSnRZZ1NtelRwengzWEgwMTQycDVIM2NyT1U4cEp2?=
 =?utf-8?B?TzNzMTVCSXYzSlN5WjIyWEo5K1VwQ3hQQzUwNzB3WkNaOHZuTzRoSkVtSlB1?=
 =?utf-8?B?a2RQMVZNYnJ4MVZvY3hYQmpqTVJqenFXWjBSbEZBRmw1VkhKQUJvaFAzUDZN?=
 =?utf-8?B?VVJvNW12M2lyVzNKSTkrQ05peHVjT1o2SzkvY3hlbnRiSHBFcTRILzNQVk9C?=
 =?utf-8?B?V2dXQjZBK2EySDRBS2NMNldvZFNjZGFSVFZPZHZxOGo3TDlqWEFYeE02dUVo?=
 =?utf-8?B?MkdaQlZBRmRIdVlqRnhYbWFxSU1rMlRGaWtKL0o1NWhzUEZCNVZXLzc3czFq?=
 =?utf-8?B?Mk9NaGJPMVJMaC9WZXFTaEprVkhjRTNWY1JHaDlHRWVxeEdKOWpmUTJWMERz?=
 =?utf-8?B?MC9TczNZVE1MaDBkdnYwVUlIY2hVTUxObG1vKzlBSlVhdDZoenpYb1RrQnJk?=
 =?utf-8?B?NlFiakVaamMxWXk1c2YxR1F6eG9vUjV6VTZ5RjVUbExnYk9NUmlBNWtCWTJX?=
 =?utf-8?B?cmlXUTJQc3UzYmxjNXhmeXl4bnM3RGwzZkZFc2Y3YTdSTjAreVloSEgramVH?=
 =?utf-8?B?SExTaVBaTzlyeURLam1jaVFUeDZGLzVZNVl3VDBNNjhkWlZmUk1ubUlPc1dY?=
 =?utf-8?B?Um9UWHVyZ0YxMnhYV2htUy82cjd4MjJ5RWtpaUpqVkQvNTFiZCtsRlpqekxz?=
 =?utf-8?B?eEhQU3dXb0g1QjFLTWw5TFVFRXN0ejhFOGloRkp0czh6Y295TVJrZFI5Mm5T?=
 =?utf-8?B?TDNveWl0bXVHSjJ1a205TTRxbStaQmNHZzl6SnJMYWRMTHRna0ZkalI0QjBX?=
 =?utf-8?B?YjdGUVVqUlY0Skw4UEVwMzErU3p2S0RxbXVRT2xpcGlLb2FiclBKanM1Q1dm?=
 =?utf-8?B?WENBM1g1dTQvTFhFcFh2NWk1bFJjWERCUHhXNjJpbnRtdDRUZzFsbHRNTzV0?=
 =?utf-8?B?azJIQnNvTTFhS3hJZ1Q1QmJIWUFRMmhwU0RBdThmVDVuckxRSVJzWVo3ODF6?=
 =?utf-8?B?VldOV0NYQnpDWDhjSzR0YjRSdmZDYlNLYkZyUVNKSzJOMGhtc3d4RHFKcHR0?=
 =?utf-8?B?Y0ZtczhER1JFK01LdHFQWndRekNhNnF1bjVScnQ4WXNXWC9yeWIxc213bjVN?=
 =?utf-8?B?NEpmbkNzaVRiekVEWFY2eHJKdTcvYmFMUmNycEJYZmw3UCs3RWpCWEFNMUxk?=
 =?utf-8?B?Z1g5UU1VeXZybUIxNEQxQ1lQRG1DRkliYW04bHczTnlsUCtURXUwZnQ3b0xn?=
 =?utf-8?B?WWpwamM0Yk1OMkFpalZkM0x5Rk9EOXVxM2l1dVhDdFVwQUNSUVlnbE9ZKzJu?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6753c55-3b13-4365-a4d8-08ddeaf48636
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 14:16:50.3492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgd5oueR1cO4yWpkvClIRzJEry4T6v1xK2/HKqZl2/OI7uLAvrEjQSMrLB8dEZuzvF0hBzKNRQUdD0XXhqtAHSUe2YI36MqkZ1f8G1Dp9uQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7206
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

On 9/3/2025 1:17 PM, Thanushree Sreerama wrote:
> From: "Thanushree.Sreerama" <thanushree.sreerama@nokia.com>
> 
> Add proper EAGAIN handling for the device setup by retrying the device reset
> 
> Issue:
> asc-0a Disp_0[18237]: EAL: Unable to reset device! Error: 11 (Resource temporarily unavailable)
> asc-0a Disp_0[18237]: EAL: 0000:f4:02.3 setup device failed
> asc-0a Disp_0[18237]: EAL: Requested device 0000:f4:02.3 cannot be used
> 
> Caused due to:
> 92d847a35e1 ("Revert "driver core: Fix uevent_show() vs driver detach race"")
> Cc: stable@dpdk.org
> 
> Change-Id: Ic3ae8701fccdbf1e8e2a575d48e707b4c58e939a
> Signed-off-by: Thanushree Sreerama <thanushree.sreerama@nokia.com>
> ---
>   drivers/bus/pci/linux/pci_vfio.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
> index fab3483d9f..20e212c9f1 100644
> --- a/drivers/bus/pci/linux/pci_vfio.c
> +++ b/drivers/bus/pci/linux/pci_vfio.c
> @@ -478,6 +478,8 @@ pci_vfio_is_ioport_bar(int vfio_dev_fd, int bar_index)
>   static int
>   pci_rte_vfio_setup_device(struct rte_pci_device *dev, int vfio_dev_fd)
>   {
> +	int i, ret = 0, max_retries = 5, retry_delay_ms = 20;
> +
>   	if (pci_vfio_setup_interrupts(dev, vfio_dev_fd) != 0) {
>   		RTE_LOG(ERR, EAL, "Error setting up interrupts!\n");
>   		return -1;
> @@ -498,7 +500,19 @@ pci_rte_vfio_setup_device(struct rte_pci_device *dev, int vfio_dev_fd)
>   	 * Reset the device. If the device is not capable of resetting,
>   	 * then it updates errno as EINVAL.
>   	 */
> -	if (ioctl(vfio_dev_fd, VFIO_DEVICE_RESET) && errno != EINVAL) {
> +	for (i = 0; i < max_retries; i++) {
> +		errno = 0;
> +		ret = ioctl(vfio_dev_fd, VFIO_DEVICE_RESET);
> +		if (!ret || errno == EINVAL)
> +			break;
> +
> +		if (errno == EAGAIN) {
> +			RTE_LOG(DEBUG, EAL, "Device busy, sleep %d ms and retry to reset %d of %d times\n",
> +				retry_delay_ms, i + 1, max_retries);
> +			usleep(retry_delay_ms * 1000);

Perhaps use one of the rte_delay_* functions for portability?

> +			continue;
> +		}
> +
>   		RTE_LOG(ERR, EAL, "Unable to reset device! Error: %d (%s)\n",
>   				errno, strerror(errno));
>   		return -1;


-- 
Thanks,
Anatoly
