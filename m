Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D09CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 15:18:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A1614042F;
	Wed, 29 Oct 2025 16:18:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 3A46B402D2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 16:18:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761751080; x=1793287080;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=4ArnKndM1l9kgbowTDuqneB14AZMsmWgeFz4STjIHp0=;
 b=NH7+4ES1MSErxfdjCNFCn4eSVbdZOC0EZ/Z178nGeGn7EWiXg5L6/N0l
 ND99+6rx3J8PiDHW3PAMV9v5/JOg6fKCmmhWzgdvezyNC5qzRDT0KXUp2
 MRgn6vzu4AT22HCStNdFYH58XYF0ZHQkD+Ggtj02YgrFBjTd13WbByn61
 MJUcOCzhgZFkC9/5bBXCHH8xeqezTy/6v3f0560JIcp5gwEN0FBID6+4v
 xrYFQpKbjUSCn2tcszLdtIIlThAN/4CtZByJteIj07p0WKficIVnA+hSG
 X/BxKGxeIdJwFYSAxY6pk3nOm1VuZ5VkjhW2fDhCDzT5BC9lzqlmgrC8i Q==;
X-CSE-ConnectionGUID: 0Z+Sv7DkRHyqpy61vEqkgA==
X-CSE-MsgGUID: sf0QQhV0T4mTcW6fckSYwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74552388"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; d="scan'208";a="74552388"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 08:17:59 -0700
X-CSE-ConnectionGUID: s1mWMuPGRs+xXzsEaCaqTA==
X-CSE-MsgGUID: KSEwoBcpSaSVJzkfPkXMaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; d="scan'208";a="216556761"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 08:17:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 08:17:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 08:17:58 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.24)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 08:17:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZX2nPCuReKzAswVUFD2cl/iXUMGJCO4GVnJbuLKeC5ohGpTwT9nJV8zetJ3xLfvJuGmcsQLm4BnPsfW3C8ezYFII2xgvnALwy9w/pCLz6mGGlBNGbHYMJ7n4AhLRlECVpyA+4uF45D+xfd0HldZNKs1LkhChU+QeSAtOnBLYWh1WNU5+4EOicZxO4vKiToQn6eF35YzVKe6/Vghw+C8JCNhx9or2+E9wIeYIJbpQn0DD8pvF9mWkICZjxdIyyXJ0OsbS23L0rtR48FL7zOJykprjlMhB9aJKoncHPF4k3xe68b8nYFzj3+/+9/jrdLiKhuSBgZ8YKhu297K4VNaUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDqvg7Of5I0jtkPa8jwSck+7vQBm8IYjGdy2McIXY9o=;
 b=nvMQh2Pz+cd1DZJq+yPwmAfrAJm5z0VuB1ubi5nTOMp/eNQb/KQteV5Le6kTzTol2/lVTbcZWBKAZFuVUq7Sb3KsjB6fLjih7r0pFz446zSayTD9cbcSce5XB2x+5uSu3Ay7tPFhfxikBz2zI8ztWyDLBU7xONIriHaRr0+94HQwwGZ2A9MSWDaHWHjUifmin+uu1ImuvsArKqQftzupYUYmcdz/DDvJt1N7OnjwY+ahVZNjpBDU2yACPUJVZE2QfmxrhD0pQgRG8hvo9Da/4oXrB6SK19LxQSCSikSF7eVgQbaHDUxVDSUnhmWI5AollCT8IklZpJfQUlN6Xw/5TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by SA3PR11MB7463.namprd11.prod.outlook.com (2603:10b6:806:304::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 15:17:54 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%3]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 15:17:48 +0000
Message-ID: <b80746cb-9093-4986-a490-391415a4a636@intel.com>
Date: Wed, 29 Oct 2025 15:17:45 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] doc/ice: document protocol agnostic filtering
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <f2bf17ce5b8f64dade7a5505ed0aaf30343e3888.1761751024.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <f2bf17ce5b8f64dade7a5505ed0aaf30343e3888.1761751024.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0019.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::24) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|SA3PR11MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ffdbe2-4148-41c4-7838-08de16fe51a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0FZbzlYaFgrTHRuMmhDc2NBQURwV01RYU9GQWlpeEdrVllOaWl2QnRTeVJC?=
 =?utf-8?B?WFZnUjdFd1BhSkZVQW4wQi9rVnlteGMyTEY1VzkwZzVQY2Q5eUtrb3FlNmI1?=
 =?utf-8?B?L3kyc3NOelFWSTJXWTBYczRVVElYT0J2ejdvVVZpaEMwb1J3QXdvRHBrMFdo?=
 =?utf-8?B?M1lpNVdINjV3NmlLNWRNckMrZE5lZGhxNXVKaHNIMHVRM3JHK3NiakZwdHM3?=
 =?utf-8?B?emNxMWFNcVZwRFRBTmIzcXNGRXpnbjN4cHVTcmc2MHdDTzNnajY3M0VBSU9q?=
 =?utf-8?B?YXkwenVBc1lQb0FJNlNRL2dYc1YzQmIvUVlBWVBhdEUvODVCWFRIUnU3ZjR6?=
 =?utf-8?B?TGRQSHJ6SkVLSVMyaGFrci9jK3dJWW8yYXI3b1ZaVGpoa0dSZzRyeThidmsr?=
 =?utf-8?B?SC9IWEErc0tCVUc5TUlxSnNQUzNPWmUvZGVhRWZFRERKMkhBY3BzNEpEb2x1?=
 =?utf-8?B?enRrQ1Uxa1FqeHRXQ2FKZktkR3RrUUtjUy82dFlxY1U5VXFnWDkrR1JWSGls?=
 =?utf-8?B?YXI4MnVWTWFqdGZldDNjRFVKMnBnbGJqbFN2QXdHVDhmQkx1TndVaU5yL1cx?=
 =?utf-8?B?Tk50endxZnBLOVdsR09UZzFyU1QzUFhFM3R3WGFTZkE5enA5UlBXQWpMT2sw?=
 =?utf-8?B?aEJBeTRZTGpRV21ScmRlUlREMWx0YnFCcVFPOVdtR29JUSt6S3hxcnhzc29z?=
 =?utf-8?B?dy81RkdSNUpZbjhGcDFVTFkreTk3U0d0WkRmNVJ4TURaSm9TODdQdXJ6bUlz?=
 =?utf-8?B?bUpPUElmZFpiNjRQMDhnOVM1MFVKN1pzcEtFbEVLVGV1SmxQeDc2a2g2Nkda?=
 =?utf-8?B?aUhBLy9nVXZJTUNvbnZab2RSaDIwZ1FzWmZIOE82VG5xZHZKK3owMFk3ekxz?=
 =?utf-8?B?TWtrRXpwaEhPTGNaZVFoRFVwQkZLL1M3M0JLb2pRY0ZodWJmQnk1R0Q5NGxE?=
 =?utf-8?B?cE84bDdIcVNaVlJBeHJwazdTSmZmNUVQNW1yVjZmd3ZzejgyNkVmOGNMcFhu?=
 =?utf-8?B?SG44MjF3cUdRSktpOG9BZi94djJtTWZOVHJ1ZnFpR0dLclNpNEw4czlHck9H?=
 =?utf-8?B?SFFYaDlreUVsYUpjdFlTN25KMENvbEFEaGRkUEp1OXo5QTdKQVMwTHEwaEov?=
 =?utf-8?B?bno5TU1KbVNyTzNuVWw5RWo4eVVaZm80NG9vU3Zoc2ZOS1NUQUZKYWVhWlZY?=
 =?utf-8?B?VlNOb0NpYW1CbjhCaWhJYWJzSVhDM0szTFZnQkRaK0kzSzZ1WmxMQlA0KzBC?=
 =?utf-8?B?a05GMWE1U3EzVHkxNjF5NU5mZFk3S2EzYm9TcWRBUzhTdzVRaG5FOHdmNlds?=
 =?utf-8?B?WXRuM2NQMEFmRTlwVFNMcmtGd0dOMVRqNHlPa1pONmNxTjA4OXVYQkJjYzZQ?=
 =?utf-8?B?WncrSHZ5VGFhK0NHQXRrU0svcnFMdzUxQzB3dkdJMWhzcnUvSkZFL1lNVTJH?=
 =?utf-8?B?WjdXOXRCWm5MN2M4Tm5sQWsydDNTSm5KT2MxZUdSdndpSzVJTFBpR0ltZ25j?=
 =?utf-8?B?M1pHK0w4bUNaSVlMMWVXaE9uMWIwaUZFUy9kaTFlQVhrTTZqSTFuVWk0Y3JN?=
 =?utf-8?B?bUpCRUVjWUNJR3llcHRMRG95QkhCZ0k0ZkxhNWJpaTIvbHVtTXFPbnpsQXQ2?=
 =?utf-8?B?WDh4Nk9wRXZ0K2RoL1hENnJpODh0VmwxT2dUck1DLzZlbzlmSGNpNXVTVWZa?=
 =?utf-8?B?eUhGSGxTYXVHUWZIZmFGWWtnSjZ5NXJPQUhpQ1dERVRWSkh4SmRNaWdic29u?=
 =?utf-8?B?UzlJYk95bWFhZ3VXbStIQ2NZejJOdTVFYUkrWUtuMnNveGJFNGZMeVA4bTNK?=
 =?utf-8?B?ZTlnNC9pTmNOWDU5Q3lJKzJ0c2hhUlBBVXhQRktMK0d1WWxiWVJHczhUaWVX?=
 =?utf-8?B?WjJlTmp4cWJmNmRHbGZDQTJGQ0RYYlk0M3B6U1BqNzlvL2haZkxlYXVCQ3Ba?=
 =?utf-8?Q?0MkH2X2TnRjX+PyzBO9P8DsX1F/8pmGs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkY0U01KMTZTRFNhdWlyYUhaN29CRDFKZ1ZKSTI3bEp2R3hDUTZ6T1pYUDJi?=
 =?utf-8?B?UWtOb0M4ZDh0RUtIOGg4cEFIdUVoS3I2NzZqSGdYTmU2ZTF2M25EWTI1RStu?=
 =?utf-8?B?TSthaFZETk5YdW9PUm5rK3plTG03K0RILzM3a04vWCtHWFc3SURuU09LbktJ?=
 =?utf-8?B?OXIyM0lrRkk5eUpxdjEzTEJyMlhqTlhBS0xGdzhtckFVZVV3OFlxWjBPM3JO?=
 =?utf-8?B?VHZnUUlpR2xhYXVFR09MY3RHNllJQXh0QlBLcTM2YzZnanhQcGpLNURyOWNI?=
 =?utf-8?B?K2l6QVV3Rmw1UjA5VFFzN0xEVzZIMXNTc3VKdzdXVHJORHhxNzE2eVV6dlcw?=
 =?utf-8?B?WGZNdFQzWEZHMnZTQ0l1L1oyUjNVY0l4YXRoTjIrS0dGTVdsTGFaSkJxT2I4?=
 =?utf-8?B?TEtHRyt1eXhRVEdTdXdvdUU3ck96SDkrS2JkV0xHOFNheW51T3ptQlRzNTJv?=
 =?utf-8?B?ek5JY2ZVWFZmbDBubzBnd1lzbEV1Tjl1NzMwblQ3a0dJWGt2SW5USDkxYUU1?=
 =?utf-8?B?YStmWklwNjMxUjVMcGxZTnR2dEVNNlJQd0o5ekx5ZEtWRXg1aGlIZFFXdUxU?=
 =?utf-8?B?eWZ4RUZna3RrTFlSQ3VoSFFNUWdveHlDSnNUSmxOUzk3TlJSRkY4c3BGek5Y?=
 =?utf-8?B?TzZmbnU4SnhZSUthcDA4TGN0QUlUenBhekRzd3FIVXZHQWE2aUFaaFg5L1V2?=
 =?utf-8?B?S1d3NkMyQVBjNngrU2hqam1yMHpZbGdudXY2ZWRQRmVPUnlNS1ViZjlNYXc4?=
 =?utf-8?B?VjVQWTRGRUtWTHVRaU5EOUNhR1U2SXQyUDk3R0M5NkVabmR4TVZSNjNKL2Ro?=
 =?utf-8?B?MzJ3ZDBDekJoeENGem1hSDhoOFQ4TGtkR0E1cmhNTENkVmVEV1d6ZEVna1l3?=
 =?utf-8?B?ZUlhM3hSQXh5a2NxMmJnWXJBTm5MbjNKamFQNlBGYmQvVXN2UVpZL2p6MTRp?=
 =?utf-8?B?eGhKQjRka3VlTkVjRjE1bk5ScXRoS3FteFF0aVJCY0paZ3dmdUNjN2xVc1oz?=
 =?utf-8?B?Z201ancxV2lwZkFsL1Zqa3BpUjFqYUY3eU1YYUdIVm4wUTM3VDB1WXZjV0k5?=
 =?utf-8?B?VWl4Sk9UOFB5UGhuU3RlMTNTaUd2bDcxc3BWU3JPOEpsczdGOUV1MGxHWC9w?=
 =?utf-8?B?K0hTWHN0ZUVKREdMQldYYWt0L0ZUL29aOFU1MHhLMGNMa2p5K3F0bUMyMjVB?=
 =?utf-8?B?a3lTclZEZzZiblpZVmxUbW9UQzlhR2djK3c1dlBvUnNYNW4wZ3l3aGhkL0R4?=
 =?utf-8?B?WUFnY0praVVHb0h0ZzkwZUxIK0dqOWJTSVdLQk5tWHlkS2ZRVFJtS2J6ZGcy?=
 =?utf-8?B?UUVFK0RhNVRucjVXZnZQQ1hub1RGSnFFL2NkaUVNTXd0TDFrUENzV1ZWVGNE?=
 =?utf-8?B?SEI5NXFEck5JOE1udTJkQlVhd3U4VEhRV3lPY0JBbVlpMW82cEZnKzJmK2Ro?=
 =?utf-8?B?VWE3V2gvelBSdzQzMGNXYjk3TnZ2bElTdkVHRlhnNm5SRzdSNUk5M3BRcGFk?=
 =?utf-8?B?dHg1am9QaHBmRGN6dU9KVm93ek4vMUN3ZmtWSVhCVVQvMkZkS096Qk1tc2JT?=
 =?utf-8?B?MklUdlNFZ0M4eGNKWm1oQ1R4R2ZxNkpjbXdXSFdsQmlabkMyRTduYnBTbHZj?=
 =?utf-8?B?L25NZ25RQUZxbmRSa1E0QzNwaDNzTnF2NU5LMmNsM24xc0tNWmdJSjQrQklQ?=
 =?utf-8?B?L2xsNEZaSE52SksxQzNiY3Fzd2t6WEsyTTNYQi9RZUtOd1dxL1dkRkc2QlpL?=
 =?utf-8?B?VDhJK2pLeC9lRXcxaUJZVjhPZFphcEFxNGNrQ1ZGRnhheERyN3htK0RBaFE0?=
 =?utf-8?B?VjFkYlY3L1p0MHZtTzhQQ3ZDYTIwSnIyY3k0MW01aDZvOXJoTEw4UnlodDM3?=
 =?utf-8?B?aHV3NWNPWnpGSDdNeXNPUi9kTVBrb3ovWkJPeTc1Vk5NVVlwWkdVTThlRENa?=
 =?utf-8?B?TEY3R09zRkVoQ0ZSNVJnaEdNNUQvQktzckxGV21sSWFUZWViOTNMUncrQmJF?=
 =?utf-8?B?NFI1MU5Wd2hxaVNlNDNJb2FkRU9POWp4L1R3b1JiT0sxbHU2U0EvZk5ZZHRZ?=
 =?utf-8?B?Q2syaTlRdTc5N1pqWFNDeDB5Q09xdENhc2QvQnByWHV4a1k5OWRFYTE4bVFU?=
 =?utf-8?B?akcydzN0WEt6bFp6NFdpMTlvVXBTRDBRSFpBU1FpM1NEdjIyWEFYeStaNlZT?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ffdbe2-4148-41c4-7838-08de16fe51a1
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:17:48.2905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAN8ZAWklEbMWgIA7I3Cy0Yj0by2jyFs92zc7kPM6hlqnsfKusmfnOQnJKT+lHtXUTpMPT8PX8/uSz86TGCCWtB2xFtM3QXT5Z5PkYRKDdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7463
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

On 10/29/2025 3:17 PM, Anatoly Burakov wrote:
> Current documentation for protocol agnostic filtering for ICE driver is a
> bit terse and relies on a lot of assumed knowledge. Document the feature
> better and make all of the assumptions explicit.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   doc/guides/nics/ice.rst | 143 +++++++++++++++++++++++++++++++++++++---
>   1 file changed, 133 insertions(+), 10 deletions(-)
>
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index 7e9ba23102..cb06abcdbc 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -506,20 +506,143 @@ For each engine, a list of supported patterns is maintained in a global array
>   named ``ice_<engine>_supported_pattern``. The Ice PMD will reject any rule with
>   a pattern that is not included in the supported list.
>   
> +Protocol Agnostic Filtering
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
>   One notable feature is the ice PMD's ability to leverage the Raw pattern,
> -enabling protocol-agnostic flow offloading. Here is an example of creating
> -a rule that matches an IPv4 destination address of 1.2.3.4 and redirects it to
> -queue 3 using a raw pattern::
> -
> -  flow create 0 ingress group 2 pattern raw \
> -  pattern spec \
> -  00000000000000000000000008004500001400004000401000000000000001020304 \
> -  pattern mask \
> -  000000000000000000000000000000000000000000000000000000000000ffffffff \
> -  end actions queue index 3 / mark id 3 / end
> +enabling protocol-agnostic flow offloading. This feature allows users to create
> +flow rules for any protocol recognized by the hardware parser, by manually
> +specifying the raw packet structure. Therefore, flow offloading can be used even
> +in cases where desired protocol isn't explicitly supported by RTE_FLOW interface.
> +
> +Raw Pattern Components
> +++++++++++++++++++++++
> +
> +Raw patterns consist of two key components:
> +
> +**Pattern Spec**
> +  An ASCII hexadecimal string representing the complete packet structure that defines
> +  the packet type and protocol layout. The hardware parser analyzes this structure
> +  to determine the packet type (PTYPE) and identify protocol headers and their offsets.
> +  This specification must represent a valid packet structure that the hardware
> +  can parse and classify. If the hardware parser does not support a particular protocol
> +  stack, it may not correctly identify the packet type.
> +
> +**Pattern Mask**
> +  An ASCII hexadecimal string of the same length as the spec that determines which specific
> +  fields within the packet will be extracted and used for matching. The mask controls
> +  field extraction without affecting the packet type identification.
> +
> +It is important to note that raw pattern must be the only flow item in the flow item list.
> +
> +Generating Raw Pattern Values
> ++++++++++++++++++++++++++++++
> +
> +To create raw patterns, follow these steps:
> +
> +1. **Verify parser support**: Confirm that the hardware parser supports the protocol
> +   combination needed for the intended flow rule. This can be checked against
> +   the documentation for the DDP package currently in use.
> +
> +2. **Build the packet template**: Create a complete, valid packet header with all
> +   necessary sections (Ethernet, IP, UDP/TCP, etc.) using the exact field values
> +   that need to be matched.
> +
> +3. **Convert to hexadecimal**: Transform the entire header into a continuous
> +   ASCII hexadecimal string, with each byte represented as two hex characters.
> +
> +4. **Create the extraction mask**: Generate a mask of the same length as the spec, where set bits
> +   would indicate the fields used for extraction/matching.
> +
> +VPP project's `flow_parse.py` script can be used to generate packet templates and masks for raw patterns.
> +This tool takes a human-readable flow description and outputs the corresponding ASCII hexadecimal spec and mask.
> +
> +Example usage:
> +
> +.. code-block:: console
> +
> +   python3 flow_parse.py --show -p "mac()/ipv4(src=1.1.1.1,dst=2.2.2.2)/udp()"
> +
> +Output:
> +
> +   {'flow': {'generic': {'pattern': {'spec': b'00000000000100000000000208004500001c000000000011000001010101020202020000000000080000',
> +   'mask': b'0000000000000000000000000000000000000000000000000000ffffffffffffffff0000000000000000'}}}}
> +
> +.. note::
> +   Ensure the spec represents complete protocol headers, as the hardware parser processes
> +   fields at 16-bit boundaries. Incomplete or truncated headers may result in unpredictable
> +   field extraction behavior.
> +
> +Action Support and Usage
> +^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +After constructing the raw pattern spec and mask, they can be used in the flow API with pattern type "raw".
> +
> +The following is an example of a minimal Ethernet + IPv4 header template. Source and destination IPv4 addresses are
> +part of the match key; all other fields are ignored.
> +
> +Spec (packet template):
> +  000000000001              Destination MAC (6 bytes)
> +  000000000002              Source MAC (6 bytes)
> +  0800                      EtherType = IPv4
> +  4500001c0000000000110000  IPv4 header, protocol = UDP
> +  01010101                  Source IP = 1.1.1.1
> +  02020202                  Destination IP = 2.2.2.2
> +  0000000000080000          UDP header
> +
> +Mask:
> +  000000000000              Destination MAC (ignored)
> +  000000000000              Source MAC (ignored)
> +  0000                      EtherType (ignored)
> +  000000000000000000000000  IPv4/UDP header (ignored)
> +  ffffffff                  Source IP (match all 32 bits)
> +  ffffffff                  Destination IP (match all 32 bits)
> +  0000000000000000          UDP header (ignored)
> +
> +This spec will match any non-fragmented IPv4/UDP packet whose source IP is 1.1.1.1 and destination IP is 2.2.2.2.
> +
> +Currently, the following actions are supported:
> +
> +- **mark**: Attaches a user-defined integer value to matching packets. Can be specified together with another action.
> +
> +- **queue**: Directs matching packets to a specific receive queue.
> +
> +- **drop**: Discards matching packets at the hardware level.
> +
> +- **rss**: Enables Receive Side Scaling (RSS) for matching packets.
> +
> +Constraints:
> +  * For RSS, only the global configuration is used; per-rule queue lists or RSS keys are not supported.
> +
> +To direct matching packets to a specific queue, and set mbuf FDIR metadata:
> +
> +.. code-block:: console
> +
> +   flow create 0 ingress pattern raw \
> +     pattern spec 00000000000100000000000208004500001c000000000011000001010101020202020000000000080000 \
> +     pattern mask 0000000000000000000000000000000000000000000000000000ffffffffffffffff0000000000000000 / end \
> +     actions queue index 3 mark id 3 / end
> +
> +To use masked bits (IPv4 source/destination addresses) to distribute such packets via RSS:
> +
> +.. code-block:: console
> +
> +   flow create 0 ingress pattern raw \
> +     pattern spec 00000000000100000000000208004500001c000000000011000001010101020202020000000000080000 \
> +     pattern mask 0000000000000000000000000000000000000000000000000000ffffffffffffffff0000000000000000 / end \
> +     actions rss / end
> +
> +**Limitations**
>   
>   Currently, raw pattern support is limited to the FDIR and Hash engines.
>   
> +.. note::
> +
> +   **DDP Package Dependency**: Raw pattern functionality relies on the loaded
> +   DDP package to define available packet types and protocol parsing rules.
> +   Different DDP packages (OS Default, COMMS, Wireless) may support different
> +   protocol combinations and PTYPE mappings.
> +
>   Traffic Management Support
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~
>   

-- 
Regards,
Vladimir

