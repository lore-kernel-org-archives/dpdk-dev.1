Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09702D1171A
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 17:36:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 390284021F;
	Tue,  2 Dec 2025 18:36:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 615FC400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 18:36:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764696966; x=1796232966;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=B9P65TJy4kAitrtPPKC9NUxvpmPE8YS3qQPGWbTD1z4=;
 b=VeXeHQ/FpgzWdwB898FnxootpJmNYtMUg93mGxYSiMDqkMnM0ehtlygX
 kSvzxNBCwZfRvl4NUYlMrngEzgsnecpsyEzREaM6cuEEUJkm45i+VcM5z
 sjHOfmryLfypTAYtzOtnABVWsBiKzkeuCw9YH/ttrS3LnRX37f+h65dAa
 4eoyls8F0nUB8QmjIB8HrevSXoASudOnnOtNfWXSF7Qh2aXjiwRRJf3GC
 N+6KArdCJugI6mDwMSyMda2s59Tf7jTkByPG/1Tgjf82i+/nTs/Q2EYzb
 RM/Nkm/ja3Pa5t9EUO1zXyvrbfTLfQo3j+5PQrl5fP+jZpaiWYzpbbFjC Q==;
X-CSE-ConnectionGUID: 66yx8Jk/T0WgTF0fnPSNGw==
X-CSE-MsgGUID: pzw72F+BSSOKRMTDtzBeYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="84071923"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="84071923"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 09:36:05 -0800
X-CSE-ConnectionGUID: pNKsM7A+TQW4rWt75hIRFQ==
X-CSE-MsgGUID: OPVwXc5rSwuouUMXqg4ePg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="194267360"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 09:36:04 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 09:36:03 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 09:36:03 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 09:36:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWiKpgKjnv7YiQCXAYLPNqld7zzBC9AoeB9mUWf0/ZmDJyDzlvoHsLHkmuqtIblCnCTtPtMuuw0h8yry3LWpoNEnbp3EIQNcImvFnUASxleI15QvJMasnCzTswKj+OeetaXosW8NL35Jmy1NeLFHzPve+M/hPLwCHf2rR/VN4vNxroVlNBIYBDtyh1jI+8GL68nzy5/4EwSfZAGwd0+6QSp9BqAv/aIEAugloggv/7W82y+Naf9+Nd9lbeWiyze8En/x6LvPXrFMse8Pun3Or1dwMQVRk26pvNT9/Y8wLWJI5Ul5kM86vJfE0bQdDerOxXPXvawt2H+KmDec0hxwIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqECWxSRd66liDxw45mX6nHgnSPpealZ0YG83XTwSZw=;
 b=K4kcN06DSpQIAsaxKTt/WPC6fmaAyIoWn4uRKr9qeoxN03Uh0GeiT6pom78vZKZ7wn2bHqHNoKl53ue7S7CMGDDelv3hXGfDuz8QRKhKbOUSl7+TylXamuZULF6N9nS5rpI/hesaYY843JuRMT5/lAYnrOg1PGle/xXEM3t8uA9RzE2Svh+3ZbOvQbWYpTVb8MtqKOLTGgy3/RAVCTku7c2Pwrk46xglF0UdXSY51ASZ1/YHPnz945htDG00ltA0wDxudCvg6/Gaknv2JZCkw47uGGyd9VB3rrM0WArIk2EI2lrq1kwajo0Yl1horl9Zx0VIfuNFFDOsEZ6yDtXeww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA2PR11MB4987.namprd11.prod.outlook.com (2603:10b6:806:113::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 17:36:01 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 17:36:01 +0000
Message-ID: <c7b97f8d-8119-44f2-bf69-c24ecddfce42@intel.com>
Date: Tue, 2 Dec 2025 18:35:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] doc: add devargs documentation
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>
References: <f9c79b16f3f90c3521acabdcaa96a9e61dca705b.1763122378.git.anatoly.burakov@intel.com>
 <11158378.CDJkKcVGEf@thomas>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <11158378.CDJkKcVGEf@thomas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0086.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fa::16) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA2PR11MB4987:EE_
X-MS-Office365-Filtering-Correlation-Id: ec00a4dc-e3b1-463b-636a-08de31c942ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clZFY1poM1pnR1JOSUJCZ3ZqQ3luY1FpaC9tTW9FRnNrdkdZVDBEWTlrUzFR?=
 =?utf-8?B?UzBOajMzbEk5bU51OWxIRzdXKzBXOC9PaXBoZkNBbFduNVRoK3BTcjhDZk5Y?=
 =?utf-8?B?M29qUE9ka1VFSXNGSFdoczFheHI5eFA0SklWSHd4cnJjMlozVGw1VVV4WlRq?=
 =?utf-8?B?eDV4REJzOXI3S2tiWk1vSi8yN0xDS251bm9pRHUwZ2tRK0lFTTdlRVNUTWNh?=
 =?utf-8?B?alVvTGloWHBob0diTks4bm5Ha0N5VWlKbHczVHhkbGxVMWxCV281K0krV2xR?=
 =?utf-8?B?V1ZQK2pKYktLcWNHbzFLV0xzQjR2eUI1OEVvUzBmbGVpeHJVUi8zaDZsR2Jq?=
 =?utf-8?B?d1NyT0FUZUhKWFBTYkNoaVJsN3lTS2oxM3NLTGNtcHBKcVdacGxWbnl5eVNB?=
 =?utf-8?B?R3VXMWltaS9kMTRyYmEzT3NFNDMwMHQvWnVmaFNSN1YzbnVqVXNaN2p1cWdr?=
 =?utf-8?B?dk01NFdTTWlseHlTb1p2c2ZydFNCT2t1a0NJSTJpRGNWUlJzTDdoclZiSktP?=
 =?utf-8?B?czA2Nk1iQUlFSm84SkVqbm1iQ0haSWN1M3dtYWpRMGdLYjVnaHpxMFUvRW9w?=
 =?utf-8?B?VnJCOGxhdU1SK28xakdEOEJVdjEyekhJYjZTV2NXT0dKMUhzTEpXQXJEVXdx?=
 =?utf-8?B?Wm4vNy9jNTQyVGdZSVBiY0ZzcXEvNWM4WTBBbzBrVFE5bmdBSEpid3ljZFNX?=
 =?utf-8?B?M1hxeUp5N2ZxS1U2YUIySXJvR09RUnZNbXQrc1FKcG1uYitsdFlUVTNkRUpu?=
 =?utf-8?B?ZVNpVGJDTUI1YzZVTnJoYjE4RXZWeDh5cVR0VFBvc1M1Njg4dnlEUml1c1dB?=
 =?utf-8?B?d1hJeC9YQTh5eHFoRHc3RmdiSkpFOXFmNUVoTGQ3SDUyV2t0N2FMdWZmYmdS?=
 =?utf-8?B?SUFDOUVQUWMwV3U5aFVQTVhBSkxKSXdpOVhKaXUwbnlhdlJJWjlIa0t3L05v?=
 =?utf-8?B?bXFYK3UwODR3bHVUTmxWc3Z2aG9GSlBLSW4rMDQ0RHBRLzlucU9PVHNSQjVk?=
 =?utf-8?B?b0JNMHNFbUxqSzlWWHc2MnhONEl0empMTlJuZ012WnB3SXFKM3R3UEIwV1R2?=
 =?utf-8?B?L2pWalFJaFZONzZjOEsvVFFvejlMTW1qOVU1a2JLNmdXTDA5amRVUTNvUVQw?=
 =?utf-8?B?MFMyUGZxUDViL2pVdkZwa2JuZ01qMHU0b0xielpUbk9WYUdjNW9WSmUzU0Uw?=
 =?utf-8?B?YWtVQ284RXE4cWdJUW5oVXBCbHl0UWoyZVUrVTdzdUJVc2JKV0dRVE4yMTMz?=
 =?utf-8?B?TG91MzJacS9VZ0x3TW9qdnY3QkptSW93S0JBQ21KMTc3c2R0ZHk3RWpxTXV3?=
 =?utf-8?B?WFZDZWhETkxsUmh4dW9vWStTTHkzTk0yV0gwYmpCcHBZWjlUUWFVcVRJQ1BO?=
 =?utf-8?B?b3lTQlZmMVpwR2FqN055Z0RXQnIrWVZ0Ym1ROGZyWGZBcVFLQVdSRlpDb2dL?=
 =?utf-8?B?RWJnR0doN0lJSUt3WUZMT0NpOCt2emgzWlZCU2JHVDlJd1BrNDIzY2NUeHla?=
 =?utf-8?B?WEE2dkh0UUF4dUhLeGFub2hLbVJ5VTZXLzV6MHUwS0xyeUIxTkEwSERsdkFm?=
 =?utf-8?B?ZHFhWXAxOVM1TE01dEczY2oxQmNXcHljU2JmcFVDY0dNWkZUUnBmeUwxWUVW?=
 =?utf-8?B?QitVbm9tVlFUSGpvOXAwc3AzdzU0QVYxV2syeXZtOU5Pa3hRN2NoRFQvS1Q2?=
 =?utf-8?B?Nmt5b2JDeVlZcUZwYytrY0lCcjFuYUpWYzhNQjRwazlPVU90Z2lFYjJlMCs3?=
 =?utf-8?B?TGJ4Qzlpa09SbkpCanNWajdDK1R1VGYyc1FtRGwvUzVRaXdrQ0JvNlRwQmhp?=
 =?utf-8?B?NGpUTDUwams3aEVGOEwwbFdUcVA3VEZWc2ZOUTJRY3hINTZEWStHSm56VHNl?=
 =?utf-8?B?OG1CNmI2NHFyQlk2VUZMSUZzL0JuYjl5M0lNMGM5SHJ4aXZGKzh4bnp4OHNw?=
 =?utf-8?Q?agsfqhScdDGOaQb4iaApGVKu8q/qdToG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2xHWFk4SG1OY1FIbEpWd1JhVDhXQmcwbk1rSGpPZThCWll6V3VmNDFEQWx2?=
 =?utf-8?B?bW5lWlNOOTRiUTlUd3AzSGFzQkF2Q1FXdTg2Wm93K1NpM2VKMTkrdWtTUWVr?=
 =?utf-8?B?TkRiQlUzekF4OWZuYzJxdyt4S3FUOWVhUWtabHZYZEc0eFdjRGJwcWxHUm5a?=
 =?utf-8?B?K25MUlVTQVBja2FoSElBTk9iVGx6L0ZUbWU4QW9kK1diTWd5RXV2MytlUHRC?=
 =?utf-8?B?VURpaWgrQVp0VE8vSHM3K2dLbDY5bnVQTzMxWk9ON2IzRWVHR2VFOGNRT3RV?=
 =?utf-8?B?N1hwZjZSN1ltN25zTTVTdVRiY3d5Tnd1Zngwb0NROHVORDNBN3BtVUJGTmJz?=
 =?utf-8?B?TXN6ekJocytEd1hIY2Jib0kxanovdDFIVHkzZlY5NUJYbmcxR0hsVXByWWF3?=
 =?utf-8?B?eDNLS05CajFYaHRDWDI0OVVCRUVIVXlUZEpEQk11aDRLalNZYVN5U2xZTlRv?=
 =?utf-8?B?MnJqWGo1RjY5ZnJxbmVDNS9HZHl6emNLYVR6L0w1OEFmTWNwR2h0MlBBYnBn?=
 =?utf-8?B?YUI1cm8wOWVXdE84MU1oYWVWTS9DTzY0TDBrOW4weTFoNWtzdk1DbExsc3Fi?=
 =?utf-8?B?SmNkWEJrVFBTanowS2pWODJCUXZaVDF6TFpBRkFrWDRaSndnVWNVVktiTHJE?=
 =?utf-8?B?bHJacUJnTGpoY1hvZXUrWlZVVkd0T2NJVW9vUXJIMUdvd05VQVZXWW1QRE41?=
 =?utf-8?B?UldkQWlEMjVXT3J5dG9vWEcvY2IrRjVPNEc0TlR3d2JRcTUyUkxvU2hVU2FG?=
 =?utf-8?B?RjFoSjNDNFYrS2RtRk9FQ3pUSzlKQ0M3d2tZdW9lWlNyMFk0d2RXQmtybFpL?=
 =?utf-8?B?YlJrazhtQTlpSDR1S1VUZUdrWTVFYVlTRlVPRElUR0hVTkE5SUV1NlVQMXcz?=
 =?utf-8?B?bFkrR3pobjRTaWtIazVQank0K0dkMU5Pd3FOTm9ZM3hKcFRFUEtYK0VITnBi?=
 =?utf-8?B?WCtwV2RxWi82UmlFbVJyQ3FsdDNXdklMT0VhejJsVUJOM25xbkpCN0g3SlQx?=
 =?utf-8?B?RjhNOHIrRVllVUtTSlgzOENJY0tSbmFITk5OL2xFbGFEL1JDZTZnemtXbGxS?=
 =?utf-8?B?V3BIZHZTb0NyTFptMmNHL3FlVWtsbGlFNlk2WlhVSTRPWFZla0RVSkpQcFhH?=
 =?utf-8?B?RW9ESitkbUJtak5FblBLYTUycENjb1JZUWVtYS9oWkpmTkJvV3hIYzZFZlJW?=
 =?utf-8?B?ZTBHNk9mSUsyL2lwcDYyaVZmVzhpLzFIekJHL1M0bU1nRzgrRnFqQk1BZlJ6?=
 =?utf-8?B?Z3FLRmI4dlN3a0g0ZDdjYk1acWtvVlo5MjZNYitrc05IbTVvRCs3aHpCNTNa?=
 =?utf-8?B?dzR5STdhcW9IMUYrTXg1Tk9WVng0dmNDK000eW45eHFmNUtJb3hoeWZJMmhq?=
 =?utf-8?B?ZElLRXlGN0FSTFZiRFptOFFrWXFLL0IvS21KeDN3bmpETVpyTDVES1lhajN3?=
 =?utf-8?B?YXp1NVB2ajk3RnU1MnFRRTVneDNJYlFRR2NwQ2JlczFKb1NjbWF5SkNWQVhr?=
 =?utf-8?B?K3J6ZmU0Z0JYS3gwbDNJRE80akRYc3p0K3kyNzNVdTJJZEQ1bXNudURzeTJ4?=
 =?utf-8?B?Q2Rjc1llTzUrS1Z5VnRZNi9KMVF0ek1xVmNiV29JT24xeVc0cDNYRm0xZlpP?=
 =?utf-8?B?cTZocHZvMGVGZ20xN1Z4ejErOEx3ZjR3NmhUWXlCNVVjVCtVL2NmT1RYT1lW?=
 =?utf-8?B?aGlXWHFYQTBQQ3UzbWEvRE14MWw1dG5LeGh5YUtURVVnWkEzaW9tcHBRdzZt?=
 =?utf-8?B?VmZHQkFFdGRHd1praEdKTUc1UXBXTzRHTGZCN1J1ODRMZE1PS2JJQzhhaU5r?=
 =?utf-8?B?M2Z3ZUJxOWk2R1RheFFTeCtPbWtDcW82YWVLbTIydnNzNEN5Rjg2a081SFZL?=
 =?utf-8?B?aGxaSU9YK3R2M2Y3eXR0RU1PWVpmU1Vjc2tJUmhxc2g4dDloYTNFSy9Yendq?=
 =?utf-8?B?YkNOWTkyWkRFekVUaDNkT0phdk9YZVBvVjYrQVQrNTF5T3d4bE85OGljQktp?=
 =?utf-8?B?N0RxSEt4ZGhXb0Vkb2RVeG5xUnNhZWFJYjAvaTNVMk9wTjBlaDRhNW1NL1N4?=
 =?utf-8?B?SkFIOWVSUjV6Y252NVhycTV3cU5VeGJyOXMvM2ljS1FFSksrSEVwa25UZlFN?=
 =?utf-8?B?UkdBRmViRmFNeGN4dFVXaTdUNXFUSWxLMEEvQnozTTN6aEpabjB5ZWJlZ09j?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec00a4dc-e3b1-463b-636a-08de31c942ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 17:36:01.1645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AoJ1tp3uSvc+0wAigvak58NENs1aYcn8ZRfn2pzpmnJhXsGXzofNlDJS1XRLy7K1/l+gxIb8afntb1rku+WPxehM/BmTTLnENq2tyBH4V3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4987
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

On 11/30/2025 4:44 PM, Thomas Monjalon wrote:
> 14/11/2025 13:13, Anatoly Burakov:
>> Currently, the devargs syntax documentation is missing from the
>> programmer's guide, and is only documented implicitly through the devargs
>> API headers. Add a detailed description of the two supported devargs
>> syntaxes.
> 
> Thank you for writing this. It is really important.
> 
>> +* **Bus identifier and arguments**: Which bus handles the device (e.g., ``pci``, ``vdev``) and bus-level parameters
>> +* **Class identifier and arguments**: Device class (e.g., ``eth``, ``crypto``) and class-level parameters
>> +* **Driver identifier and arguments**: The specific driver and its driver-specific parameters
>> +
>> +DPDK supports two devargs syntaxes:
>> +
>> +1. **Simplified syntax** - For common case targeting a specific device.
>> +2. **Multi-layer syntax** - For device filtering by bus, class, or driver.
> 
> I would prefer we see the last one as a generic syntax.
> Others are shortcuts.
> 
>> +
>> +
>> +Devargs Syntax
>> +--------------
>> +
>> +Device-centric syntax
>> +~~~~~~~~~~~~~~~~~~~~~
>> +
>> +In most cases, devargs can be used with simplified format that targets specific devices:
>> +
>> +.. code-block:: none
>> +
>> +   [bus:]device_identifier[,arg1=val1,arg2=val2,...]
> [...]
>> +Driver-centric Syntax
>> +~~~~~~~~~~~~~~~~~~~~~
> 
> If you give a PCI address or a vdev name, it targets a device.
> 
>> +
>> +For advanced use cases that need to pass arguments to bus and/or class layers, or when matching multiple devices is required, DPDK supports a multi-layer syntax with three slash-separated segments:
>> +
>> +.. code-block:: none
>> +
>> +   bus=<busname>,<bus_args>/class=<classname>,<class_args>/driver=<drvname>,<driver_args>
> 
> I think we should present this syntax first, with supported bus and class args.
> Then we can present shortcuts equivalents with the old syntax.
> 
> [...]
>> +Summary
>> +-------
>> +
>> +Device arguments provide a flexible and standardized way to specify and configure devices in DPDK:
>> +
>> +* **Unified syntax**: Works across different bus types
>> +* **Runtime and initialization**: Can be used both at EAL init and for hotplug
>> +* **Driver configuration**: Supports arbitrary driver-specific parameters
>> +* **Complex specifications**: Multi-layer syntax allows device filtering and configuration at bus, class, and driver levels
> 
> I'm not sur a summary is a good idea in such a documentation.
> General statements are better viewed as intro.
> 
> You did a good job, but I think we should move things around to avoid confusion.
> Please let's work on it together.
> Thank you

Hi Thomas,

Agreed on all points. I'll prepare a v2 addressing feedback. Thanks for 
your review!

-- 
Thanks,
Anatoly
