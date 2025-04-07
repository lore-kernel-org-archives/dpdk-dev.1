Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A869EC36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 16:10:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B25A640DCB;
	Mon,  7 Apr 2025 18:10:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 4C9EE40A89
 for <dev@dpdk.org>; Mon,  7 Apr 2025 18:10:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744042217; x=1775578217;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Hpj82AMCiJseY10OWI6JgV/xPhHP4fUdttxNINhrMSM=;
 b=cTGc203s3dCnkt2jZZl+Pkpr2lV41UvarcjfmEo7y2B70wG75E3Bq9dB
 kknKqLfVhDXqh8Qg5tFotawBnVypcefBPtLAL6pC/+v39uaN0Z+/9R1oD
 eVgSdPkkr079Icceytbbq+dxuji54awKzBww4FlbbVK/YUqc+lsfN3oTs
 B18HNGtQyJJDKb9ELf+SiKE1TiNK8faEY4knZfecTFshlNew365IDmvjc
 4BApIgTm2O5etEuXZUwe0nJh2NAg7iKImsT/I1TkNU7UN6QkVAZSs0XRH
 SedIvHeE8TtJ2G5qa182+RdTL6olYJLLmx18GXwypnnoIXlc1zB6Yhnaj A==;
X-CSE-ConnectionGUID: SGsueQ7MTMG+bnxxDDBaow==
X-CSE-MsgGUID: BYMCiMp/T8WuWk/b6TOvQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="33042767"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="33042767"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 09:10:15 -0700
X-CSE-ConnectionGUID: c0RYvNP9RryTLd8UoUAfBw==
X-CSE-MsgGUID: Uxy6bqVCS5mcHSYyYO7+ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="132725232"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Apr 2025 09:10:15 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Apr 2025 09:10:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 7 Apr 2025 09:10:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 09:10:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtDY5R95zjq1ExPB46ZjGAcwk9hY5rivltWsgA+UGJql46qGKRFpxoyfAtLz3+mWWNrk0he3nrVogehP4/fm0tePCUz2NEUwmo8k6BC5Hdomimu40a1PMmDPDxsHG0msCLXZikOXHyiWErlLMn4OQmmJXlU/4hn39+NVEMYMPdv7bTX6TUj9XgXcGfrWKQ1IbD72eRDyde5ADEmDSJZedfzJJ89NaVifbIE/wNVZWwkLDrKmq68L35Jm8xVc554G6s38R253kb296kHlgXYvwv17xjcRRjDURgRMhizOtwtkJFEIYrdO9DaHLva9ToaOzhNvmlQmH7yICR6WUkShNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FjswO8he/+pruXkRixDfyOZQCFKy7neOfPMvOuFlZY=;
 b=vd1iewI4WotYi03RR/zwykQDkeMeyKIZ5OZs8EYnCb+FzhC+I3QGmmBWVaI+g0cwzy1Ss7WmBDNgl28laYT7k/pDfgDj5A5EouQHx/2ojAkcWC0Gc9qX32X5+inGitf9j80K/ARomMeEwdXp+kSKSoNFzVcTeERCVguTxVFo/Pe31P/Qve6r7qSa55DQiYve++Xu0uydPhhv7nPcgKKXHR7Oj/afT84ODY/hv9elWs8wzQIBWcin8bi9UL75VLt2aP+5o/yhliP3XSQB3MVuZ5Yiib6LkKODE3mLRbya/V7jzxEutTCBGYE9M0nTpjwK4YOTU/cDNc8M9eqlSA9YXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM6PR11MB4516.namprd11.prod.outlook.com (2603:10b6:5:2a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 16:10:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 16:10:09 +0000
Date: Mon, 7 Apr 2025 17:10:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Jie Hai <haijie1@huawei.com>
Subject: Re: [RFC PATCH] drivers: add generic build of SVE files
Message-ID: <Z_P43JHA4H4Mm4w0@bricha3-mobl1.ger.corp.intel.com>
References: <20250407152857.2203839-1-bruce.richardson@intel.com>
 <CAJFAV8zKFof8+_mDc7_Nmf=QkTdVDgBVYY2rc+DVZKXDoR8s8A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8zKFof8+_mDc7_Nmf=QkTdVDgBVYY2rc+DVZKXDoR8s8A@mail.gmail.com>
X-ClientProxiedBy: DB8PR03CA0005.eurprd03.prod.outlook.com
 (2603:10a6:10:be::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM6PR11MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6839b4-3fa5-4269-c768-08dd75eeab22
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHdLbDFZeVVTdUZ6N0d4VS9ua0FoSFNJZG9VWk13RmRpWitLQi9ZcTZsU011?=
 =?utf-8?B?eUw2Ylk5a2FjTjBaRXhYTk5ISEQ0TW5JV2lnYzJyOThQc0drY1ZWRE1iTjVV?=
 =?utf-8?B?NmxOYUNsc3NocXJhbnp0SldYUWhDMkNCQ1hrd25INTJUUHFMV1N1a3RmMlBn?=
 =?utf-8?B?bWt3Y0EvYkJoLzdCVHUzeVJKWVp5eTZjV3V0d0Z0RzJKT3MwdFdQNDRzZ3Iv?=
 =?utf-8?B?NitwRVdLYTdoYW01cmlFZXJQQ1ArK2UveXZ4WWxYNlhIeXVMNzg1NEQ3NTAy?=
 =?utf-8?B?Y2VUR1dVU2JidGNpc3o3Y09uMnZ5ZEJWV2JTRmExRU9EUExldXdSbHBxcS9w?=
 =?utf-8?B?YWluWG9xR3RMUlhJclF1ejhtZTcxTFQ5aW0rcTI5RTR0eFFaZm41TXFPeEVz?=
 =?utf-8?B?YUVNNWlXSC9lR2JocjFqMkkyMHA0WXJSNW9VZXRKRitISnhrcVFzWFVnaGda?=
 =?utf-8?B?S1k1LzBNcElXSm1ZMkdrTGdVeDJYZFQyU0Rad2YydVJpNjlRRitMWFIvMm10?=
 =?utf-8?B?SzV2Z3ZVNnBIY05OQStSQldtcEs2bExDakRhNnVEWWozSmZNY2xxN2pCYjdM?=
 =?utf-8?B?LytST0tZYlZndkYrNFg4eTgxaGlhQUpRZ202NVo1MFFPVmtjM2RIYmFYZkQ5?=
 =?utf-8?B?ZDk0Yk1TZDMvMnk2MUFjZ0FCQ05TL0graWxvUVF5ZjA4NEZQVmlWWjhXRTI3?=
 =?utf-8?B?ckxNTjJaTzQ1TGRiWlR0bkI2YW43VVpERXhVOVpLcHl1YWRtZTRLYW1KbXdp?=
 =?utf-8?B?d0hrNU9DOTZMZzgvbEtIQnhXMUd6VXVUcFloNkd4MnNyU1Z2dVg4VnlpeVNE?=
 =?utf-8?B?Y2d2SWw4WWRiODZ4VkpKRWw3Z2NpWnRwTnM1Rmd4TGk2UWdzS0pqU3AzaHk3?=
 =?utf-8?B?ME1Hd3NUM1JjNGVabFd6Q0l4OWhHUDJLNFBlbzNzOExkRlpvcFRKc2J3REhF?=
 =?utf-8?B?ejFERVU3ZG9xcTcrcTJKTG53Tlg1Nzd3UGUrTytGMXlybnlCR2dFTEZzY0cr?=
 =?utf-8?B?N3hWTTBiaTNtM2JmdXQrYno0N0pxQnRjYzFtNm4wblZvTFprWjVGOGdlMzh2?=
 =?utf-8?B?ZEJVNnZVblJ5NWd1L0ZCS2piMENneFNaa3lLZmFYcElCTmVvK1FBYy96QU1w?=
 =?utf-8?B?NWhPZXV6Nzc5RGhvVXlYVTg4aEZnOXVtZUJFc0dwcGJGYTVaYnBqWi83UDZ0?=
 =?utf-8?B?c05GTmNPQmhJRWgxWWI2UWxKRVNETU1vS2FHVjZ1YWs2ZG1hOWxKOEdMUDJh?=
 =?utf-8?B?WkowcUROdEZuMU1SQkJtU241QWdVanBsQnlVNUhya1JIQnQ2NGFDSEh6OEdS?=
 =?utf-8?B?WkVUY2FPNHRCSzBmU2Jjam9VcW5yaDFHMFNQSkkwNEdubnd6Y1RvOWZpcmkz?=
 =?utf-8?B?UHU2ZjdXT3paT3VoNTVDT0NoRzdTU3ZlWTRNaGw3TW5kOU9wMzVxTDRQMmJh?=
 =?utf-8?B?UXNHN0duM1NLejNKeHJLTmREY1hRTzdlKzBQTHFKbEVwUHRjQUE5QjFjaDRt?=
 =?utf-8?B?UHUxR3ZDT2JlcUdyY3puZk1sMGdISXE5U0JtYXFJRWYzUzdlSjExRzN5TnhZ?=
 =?utf-8?B?MmlKMW5hZjVtMWdLWU5qWlJBMkdjdHZnU2lUMzJ1NXM5NGJCMGZyWTFLV3Az?=
 =?utf-8?B?RmxiUktkRklNMnhuRW1HazBuVklRbXhoS2s4Ri9NZGh4dE5tM1NKVzVGZUJq?=
 =?utf-8?B?a2xENndlRnBHNEYyckxmTHNhMm82d243YUFmUldjNGVvdkRHejBleEU3NzhI?=
 =?utf-8?B?aEdpS0tYK3crRWNqclJ2UUpJKzczblhVMGdta0wwbDNaVHI2RDdCTlpnYmRL?=
 =?utf-8?B?TlQ3ckVwT2lDdkc2dU55OUtBdUhTQ04vaDVncHd5VDhTQ3B1RTJVVXFCalpN?=
 =?utf-8?Q?o6HaXfXLjWFUd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFQwN0lUWDZYbjZpM0R2bzE3QXNoV0dWY1dxS3AyOVV4RUJFU2hkNG9OUU5M?=
 =?utf-8?B?RkcyZml4djIzRUhXTW0vWTNxTkVTRWtxZWpjS1cxb2VOcDdFZDZFZlYxb3pC?=
 =?utf-8?B?c2Z2ZzNZc0hpRTBzanRaSXh2Z1VVZDlYMWR2YlR1SmdzdTZocWtCdE5BaXhP?=
 =?utf-8?B?Z3cxVmJBOE4rcGNydms3dlBpWVVFNmtvTUZ3SkNocjEzSnE2REVRYklXVWlh?=
 =?utf-8?B?dEJ0UzZTTmdhdXcyc3liQ1Rld0cvbldtQTM0R01rekJvVXVHWVJxMVlGTW9p?=
 =?utf-8?B?bVB1SkdMRkF5ZVFLN1NTNXo2Q3d6L0Zma2htTGlFZjRiVE9vdi9OZlZtUzZx?=
 =?utf-8?B?QURWOG1qTE92SVEzUkVack5MdHE3d2l0M1ZHYThzN3ZvWFlVcjQ4M3FUNldC?=
 =?utf-8?B?UGh5MndtNDNaMXE5VjY4R0VQL0RBNm5iWlBwZEVsdCtHcjlZaE1TNDJPNTdq?=
 =?utf-8?B?VHNBUjhmUXlFZkZvZzE4UEg4WW1BK1FQYVFiMjBJOVJhS08wS0RTaG92UHJF?=
 =?utf-8?B?QThFNDlzdS9NRlNxZFoyODVSUmtlRUZMNXV6RFRGbE5mbEQ4VGxyWW9vOVBS?=
 =?utf-8?B?anhBOC9sQ2Y1VnFwT1FtN3VrL0lnOWlxd0h4UmkxNVdCeUJnck9LbXNWYUFm?=
 =?utf-8?B?NnNybVFmZ0Fxdk1PMzF1ZEozWXVlWDh1c1FTcU1xNkxiMm5UU3g3VzFIazdB?=
 =?utf-8?B?QWRKN0hpWHcwelBkYVBJRWtOOUcwQjZIZHJyVEE0TlhQYU1OVGFKVitiLzBN?=
 =?utf-8?B?dnhjbkx3R3RUZGlQZ1VNMEpoRWI3SzZibTlmQm1rWldSclNXZHA0VXBZTUVu?=
 =?utf-8?B?SnlWYjZRRlhBTHZuWWhIcmtLYzJXTkZ6U0R4L1Z2dVFBRzdGUXFCUzlPTXFF?=
 =?utf-8?B?azFoUHhZc0JWbkJmVE1XNkh4YUsyM0NIa1B1YmR6T1JiY2VvMmc3R2UrdW5B?=
 =?utf-8?B?YWNpTWFMZ2VGdXNkU1hsWjdualJabWNrOXNub3ROczQ1UjlpWXA1WlpRblU5?=
 =?utf-8?B?L04xWE1aRk5Fb2ZpVTlGM01sL0ZlUy9XOGJZaHJtSmdlbGUrcWhqWTQzeHlI?=
 =?utf-8?B?anc0Nno2UHpQaWQyQkJ5aFI1ZlBCY0ZMUHpUTDd3NEl4OHFVK2pRd0Q3ZU0r?=
 =?utf-8?B?ei9kc3MvYWZ1dEZOV2tBM2NkSVNRZmFSQmhGUEE4Z09OY28yaGlUVHVYT3hy?=
 =?utf-8?B?bTNxVEgvZmZiV1h2bTdoL1dKWk9udDlyR2diS0Jjc1Q3cUxtOVpwQjk0TE9v?=
 =?utf-8?B?MjAxMkVwTTErOXFkQldHV0thcisyZ2hjVXAvVXA1aWRGaTVlM3NISDMzbXBu?=
 =?utf-8?B?bU9RdHpUTDB6RTdoajhOUjd1L1I3K0h1aU5TNVd3TjdxbnlWeDIvYnpQS0pR?=
 =?utf-8?B?TytnUGExZXVJOERZN1lLSndINUVaUUpGSFpTdzhya1o0a3c4VjEzNjVESk9C?=
 =?utf-8?B?cHhkUnVLSkJZODNSZEUwWWdTNzBQK2ZUZUMvVGwwckZ5bXpMMWdvU0Jvb0Nj?=
 =?utf-8?B?c2ExSndHbkFORnNFTlNVWGhwSFI2N1IxaUlUb0o4eHZ6c0tlVVdGRTkyb2xi?=
 =?utf-8?B?SjhzRmprS2JtWmpEUWZQZWR1aDVCQk1SVUI3cFRuMUVjSnpibXRtTGh0bGxp?=
 =?utf-8?B?L0FJeGc5TUxGNTdoYjBhZHJIVjlNMFdldlJyUkhIQXRJUGtXS2xXaUltL01q?=
 =?utf-8?B?eUt0eTBqek8xcDJTbjJYcTBBbW5GNURjMnRzR2xJQW9ZZWV6SnZ6ZVgyajdC?=
 =?utf-8?B?YVU3aGpzTkxDZ1dYSktmc3puZVlrdmJQcGVRVXVoVUdmQmtUWUxSbFZBNkVv?=
 =?utf-8?B?bmNqeXNvNnN4VDR2dFo5QXpmZ09KSTdXcmJTZmxDSFFQLytnR2xNemxIait3?=
 =?utf-8?B?SGpvZEQ4MC9IS0RxZ1krT0EyY0F5cEJidDNuTTJrSGhIQVRsK01IQlIrUWhs?=
 =?utf-8?B?dWtwaVdOYUZvTXdjbFF1RVlGL3dTVHBGOXp1SFh4dno5YTV6YWQ4L3F4Wk1t?=
 =?utf-8?B?cW5mOWl6S2IyRWd2RGtuNW1xdmlrbWxSa3A1TVlzNGU3dGVjMjNVOXdQUFZv?=
 =?utf-8?B?bGhTa2prS2R0bUlmQkV5eFFDQU1jRWFnYlpRMzd6V04xbkJ1NjlvcWhzalhh?=
 =?utf-8?B?NnVpYW9CdE01UUxBV1IxZmZoRVdybExmWEJ5V1Z1cmVYcFFLRzdzYmhWVVJJ?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6839b4-3fa5-4269-c768-08dd75eeab22
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 16:10:09.2941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFDLXlTZjJ+IoBOCAhj6irzORwImdRDyDFlTYgqeDKGgey2XgIDIkeIgEtd2czPQ+MmooA9owMT1YHA8YX2kBckzBFmVhSICS3PUbvXtbvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4516
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

On Mon, Apr 07, 2025 at 05:49:34PM +0200, David Marchand wrote:
> On Mon, Apr 7, 2025 at 5:29 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > For SVE, as for AVX2 and AVX-512, support building files for these ISAs
> > from the top-level drivers/meson.build file, rather than having each
> > driver re-implement it.
> >
> > This removes the remaining build task for drivers in DPDK which is
> > being done by a driver itself, rather than in the generic drivers'
> > build rules.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Thanks for working on this additional cleanup.
> 
> 
> > ---
> >  drivers/meson.build          | 27 +++++++++++++++++++++++++++
> >  drivers/net/hns3/meson.build | 22 +---------------------
> >  2 files changed, 28 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/meson.build b/drivers/meson.build
> > index b2d2537dc8..a6f0670a2f 100644
> > --- a/drivers/meson.build
> > +++ b/drivers/meson.build
> > @@ -128,6 +128,7 @@ foreach subpath:subdirs
> >          sources = []
> >          sources_avx2 = []
> >          sources_avx512 = []
> > +        sources_sve = []
> >          headers = []
> >          driver_sdk_headers = [] # public headers included by drivers
> >          objs = []
> > @@ -285,6 +286,32 @@ foreach subpath:subdirs
> >              endif
> >          endif
> >
> > +        if (arch_subdir == 'arm' and sources_sve.length() > 0
> > +                and cc.has_argument('-march=armv8.2-a+sve')
> > +                and cc.check_header('arm_sve.h'))
> > +
> > +            if dpdk_conf.has('RTE_HAS_SVE_ACLE')
> > +                sources += sources_sve
> 
> Do we need this special case?
> 

I put it there because it was in the original code. The handling of the
march/mcpu flags below are also different to what is done on x86, and being
unfamiliar with SVE compilation, I was very conservative in changing
things. Again, hopefully an SVE expert (or hns3 driver expert), can rework
this as necessary.

> 
> > +            else
> > +                cflags += ['-DRTE_HAS_SVE_ACLE=1']
> > +                sve_cflags = ['-march=armv8.2-a+sve']
> > +                foreach flag: cflags
> > +                    if (flag.startswith('-march=')
> > +                            or flag.startswith('-mcpu=')
> > +                            or flag.startswith('-mtune='))
> > +                        continue
> > +                    endif
> > +                    sve_cflags += flag
> > +                endforeach
> > +                sve_lib = static_library(libname + '_sve_lib',
> > +                        sources_sve,
> > +                        dependencies: static_deps,
> > +                        include_directories: includes,
> > +                        c_args: sve_cflags)
> > +                objs += sve_lib.extract_objects(sources_sve)
> > +            endif
> > +        endif
> > +
> >          # generate pmdinfo sources by building a temporary
> >          # lib and then running pmdinfogen on the contents of
> >          # that lib. The final lib reuses the object files and
> 
> On the principle, sources_sve must be passed to gen_version_map like
> other sources_XXX.
> 
Yep, missed that as I neglected to update from main the branch I was working
on. :(
