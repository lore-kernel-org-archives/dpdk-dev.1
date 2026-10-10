Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED6ECA6017
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:30:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D15E94064A;
	Sat, 10 Oct 2026 20:30:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id C8B004026D
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:30:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791657021; x=1823193021;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=sRBZsEDXnRJa8TDnjhAjt82vo87geU0H1FhN8pipyx0=;
 b=VRJm5BtgfUP9fshfzW36NBS2NsNEmQnbcmtta7+q6pW/s9GqVcYwZbdD
 n4zqjwsBYeqW8ccnDaBH5APYjH5CNr2XqWjiuZFHZhPwa11hDln3N1Us6
 HVdj5TvDgl91laZFVUOhP7j8Desjgikth8L3CNq1RPjjXfOGvjzJjow/Y
 PcNf2ZKP0G0pmV+MAbe2cmvKyDdVRoSr6+EOIRuTyMUuc6RiWpYF8GUa8
 B0RfYZ43MjvpkyIruLCRMD8J35gYvDgW89no1XIv8zf4igpl7kvgmROup
 +j7lMptKLvzsTCr3gcQdTpM5/ixXcsarzfHn+FNoz/PEIs8RmMHkTgjrp Q==;
X-CSE-ConnectionGUID: HCZU28FHTsO7YPk0rllfzg==
X-CSE-MsgGUID: KIc1fVuPTUShXRRpTecaFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="307717"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="307717"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:30:20 -0700
X-CSE-ConnectionGUID: 8XD4GsG8TveRW4U5nZ2VAQ==
X-CSE-MsgGUID: dfO0tVVJTgyMafNq3u8rGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="544346"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:30:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:30:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:30:19 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.38) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:30:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0pouJBnRmqGSCK+2jiFAMdrXrp2qLDMN3YePRwHJhCec7fgRxiNM9fDOtIkdqH/MDcKEtErCGyOEnAocZP2flLgoGO57vquqrokea3vLHJS+GmidS5cEWalzHQJODh6R1RjBUZld+CdddfDPMjHymUB1iuJAIa4SWKn0I0rav1+HWQlj/11p+bIJ+y3vKuu3vuCQOtLTt6+3/LrLls8Wh2YEhhVGByvjqwOjSHVxb00l24+XFa+lVYXtp0w7HPDWm+0Sfj7c7J/KwX6mui7byJKSqST9wYg4Z/5kPQPTPqigNiE55RaKMnZ50snse0oWPPyMPA+msF+fUJ8SwLHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrOg1JBaCmty6pPU66zdl8FC7LzwkdbncQAJ27fgrX8=;
 b=CMDvRy8hnpZ00V2bysRBu/OcCUtz2pix9KpPytYGDWnqo60X4+mwL4X2lYIYUybagAhZCjUkbQaVxLv7YoLe8Tu2BSPQM+KLlCZI7LfR4WKh30knrthYOT65xxUw3BEWHfN6IR/8WNflUr4f7sNI8iOfp70szDjRfpFK0q6fAU4ZXUTJmuWKZSF4CkJgKGD+36slbxjmth3RtKYyimTt8OFar2hruANctgFEIeP6dGJeXfLM0YQmOGJ0xygg55QBJc2YBMPryIwXOUqbIuzeSFgGx1q4QB6aLEWQO/u+eh2UDulQzHM7XuskNl5kaDqOfVnZdJNTYGF5R2UmcWIrRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SJ5PPF524F3F9FA.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::829) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sat, 10 Oct
 2026 18:30:11 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:30:11 +0000
Message-ID: <ee635742-7e7c-48a9-8374-f85d50ca3065@intel.com>
Date: Sat, 10 Oct 2026 19:30:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/25] net/ixgbe: make ethertype filter table dynamic
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, Wenzhuo Lu
 <wenzhuo.lu@intel.com>, Wei Zhao <wei.zhao1@intel.com>, Beilei Xing
 <beilei.xing@intel.com>, Wei Dai <wei.dai@picocom.com>
References: <d4016e2ef9550ace3d5d00fafa7d32905ad3d998.1791543154.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <d4016e2ef9550ace3d5d00fafa7d32905ad3d998.1791543154.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::7) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SJ5PPF524F3F9FA:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e9b3c8-f7e3-4437-1389-08df26fc84f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: j3yiU4vEFPKwq8Ph+O7Uc8h2njlh12DCpj+xfMGWvXdRDdnjU03G/DzgZXKHl2IB3sgZjFVHMXob2UislOkuBZPs5snyqtPQwMOHI8zbY1LZSDBKN/eyNAwZCyTFkNb5tCcnYFJBOTuGL036fR/YE4Kj6fw9qeMnV5fBvzCtfRmUaUuE0bCMfb7PpUllUiwjI/9Dqd3L2QkBBF0N933/GjYGQ++lzz3fnFGkSPs7evsRZ1yvuruUlTqg3g7sHZzwG5HWIDybjq2t/9F3k2r7wqm4h//T+dhm4MBd6uz9UUQG5eXocDBvazaCshCXKpyOEzMlz8XwAypugptwGkhiR8Q9hVJFwHp+eGkpFVvpbpgJJU55weI3KL7TS1nDYy3EOV0ganGmvMyglwfb8a+jZpSWq/Jd/PMZv9XAHqzDRn2TuOdFaXbzqkg9QvTj9EfDW8tZrhQAtPoNEATCO35Xm38A/3eVZvfxy1/rmPFhG3HfWS3VgZrkJQGYVHKb/xxbN4gv/6TkNos/+Hl9dvytgjkZMCqkV2divpDKDLD+MN2qwq4tt/edxKW9rAqtWM4ayv4obcVAhcXTwO4GX3+CM42tMHZOYnhqhsc9Fe4xKzp7xVxYyCIh0ovNuCAWM6ahcAJ3BNlWODPMNLpUW/KO21pvGdljzO3ptC64sPzlzs8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDkxRkVzZ2FjcGFsQU9yVDV5Y1FOTUd1bWU3aHRWbFhuaHlFYzJzSnp1dGww?=
 =?utf-8?B?MWVjZ2ZtVDVRZVpDaTZybml5RXQrcWNZQVJhcGl3QnFrTjdoUGtqVlJ1SXRX?=
 =?utf-8?B?RlZSTTBKQ3BpcTZMSGVNd2FDZndnb2tCMlg1L1VaVHJONmVKcTZvaTE1c3o5?=
 =?utf-8?B?ZE1SeTBndXV3Mnd5Q3hYUVJLNUdiNnVybW9nVThTbmZNN004VzlJMG5UVzJa?=
 =?utf-8?B?NGhMUC8veGw3b01PQU9hYjBaMFVvUW54ZGNjQ25NUWxrSmxoWE9iSXFtU1VZ?=
 =?utf-8?B?dVBDWGpOeENRdDZzM3ZHMTczTGNsRU1GTFVEdUJPbTBwUmgybmRRS3Yvc1Y0?=
 =?utf-8?B?OG9FdTNJY1JmdUFaTEdXSnFOeEJ2QncxS3hLYTlIT0xtUUxNSk5EZVk2blRY?=
 =?utf-8?B?dldJSmlyLzRieWcxTnBGTW5BaDV6WjA0dHBNRHpEVmZKaG9YWXFZeDBTQnRC?=
 =?utf-8?B?TXlEZnR4VDQwMzFoNFlsdUpSY2hIZUdPdlh2UFJtTXJLMzVqdi9qbUhwNVdw?=
 =?utf-8?B?dDJKY3haaHFkcnY5RzBJbVl6VXFCcXVvS05IbmRHRlpSMWdJNlNIdHM2ajUr?=
 =?utf-8?B?cG5tTzc5eUN3OTVVQVliRS9McVgxWmo1OFZuRkc0bHRjM0NtQ1lqOGtVZ0Ny?=
 =?utf-8?B?TDkyMHRZd1ZucjBUaUlRT3VIZVZBeXBMaXUvSXd1OGFnUUNGclhZZ3kzaXZr?=
 =?utf-8?B?TGtXbzJhNlN0L3JnNjI1Q0Q1ci9nUHErMVNETktlK3lhUFd6bWJpWm9tc2NH?=
 =?utf-8?B?UUU5NThhaTJCdkRqM0dhZVY2TjN2akZRM2QvK1ByZkZVdXM1T3JYTEk5ZjJY?=
 =?utf-8?B?dUxsUk1XdHMxUlNLbkRITis3UURUYnZ1eVBCQStsZWcybjVhaXF4SzdacjNG?=
 =?utf-8?B?UFJBdU8yNHowMk9NTUhESzVMbHlYcGxFcTFKUDlBZUZIcFd0WU5kSnpTRFkx?=
 =?utf-8?B?eE81dHMyWWhBVCtSS1phR3JhdWQvNVZDZnJRMTVFV3pBbzFOejd6KzFNTENq?=
 =?utf-8?B?dUY3TWxNWnJWQ0NVR0JHcXN5MWZoaHNtR3NPNXRlQjZKTEgxdHJJQUtVbmJP?=
 =?utf-8?B?WG9HVTIvNDBZbC9MekJmY3hlV3c0OW9BZG5Uc1krek56Sk1HSEZ5WXQ5Y1JO?=
 =?utf-8?B?VDh5TmVOb3NzcHdNam54MWNrMVB6dVJyVkhRM0FBYUpCbmcyTnJ3S1Y1eDZ3?=
 =?utf-8?B?RlVHbzBEU0c0U0xnL0FSRTQxWUdObzNQVGJ3UUpKZzdYL0J6eEFaZEVDUkha?=
 =?utf-8?B?L3cwejB5VXJzMkF3NWRLSm5EdGVYVEZ5N1NOak1qSzl1WEgyT1dJdDBTUUMx?=
 =?utf-8?B?RlpoUEJaWHJQTng4MTdwMW9CNTJvVEFtVTZXdXhUa3FNNmxTQ2MwQWkvc1p2?=
 =?utf-8?B?VlJIZUZGdEhkc2FGVFh5bThFWllZYStOZ2FXM2R1SmNTaDhqRnltWEJqY0RD?=
 =?utf-8?B?WWxHWWowaWJ6QUh5L3BraTlGUlljaVYxU29uTjJ3cWpyN0VyUWVsN296N3hJ?=
 =?utf-8?B?czhnYzU1RVNLeGx2VGE4cEVxa3F1bTFrOEo2Vll5aUlreGxib0NFVUxldTZB?=
 =?utf-8?B?WnlRVHdVTW10Tnd0OGJZM3JVSUhjN3BHK1pWazdNdlIwMjdDdjNWeU44dTIw?=
 =?utf-8?B?Tll6S2d3SWxMKzhyckUraXJtRjRDU0NaMDYyNGJ4S0VKeTJTQ2kyenFmMnU4?=
 =?utf-8?B?dGptY3VhdEdhTmxadmFpeStQdEFCa1VrQ1Mrd2xIeHJQbkZCcFN6djlHeGJO?=
 =?utf-8?B?WmZCem9oREt2OHdUOHpQWTNqMzFjMHhtNmxIUDJWUzFqVGM5YW1UNWtHeGZK?=
 =?utf-8?B?d3VaQzhJNEFSaExyQ0djQTRNbnM2SnBkcGhnaTVJRHRnZmdUelJFL2NyQ0pP?=
 =?utf-8?B?MUFWTHFJeEE4cmRKS254dkR1SExVb2RtdHZ3YTFpNVk0RlRMU3lVTGJOMVpk?=
 =?utf-8?B?L1o4QnRUZitPakFSMmFJWVIzK3JHRm81S2xUa0g5M0N5QlZ5RFhZWldBMVRr?=
 =?utf-8?B?ZGwrc0wyemdNaDBmL0xNWWxNOGRiQ3pEOTNmaUVJZEtjaVlxOXFMVFdGSDVl?=
 =?utf-8?B?Mjc0RElMWjZyMFlqRmJQSEJ6WWdyMU9tVmlmb3VQL0xtb3FlWUl3b2xneWVJ?=
 =?utf-8?B?b2VSRmFVSmNrNUUxRE5venowZzhiQm1uSUxSNzhyMnovOVI1MjZhczdOWEsy?=
 =?utf-8?B?VFI1ZHZJeWswdXQvTmt4UFZSdTBzQmt1TW5kNmZmTW05ODVCbU04QzVYWVMz?=
 =?utf-8?B?VEYvbXpLWGZJMW5ycHpWR29rc0lMek1ZU252UUF0ekFNMk9KUjR6S0ZsZGN0?=
 =?utf-8?B?eSt6Yk96OFVEVjhNMjZjVU1DRXBicFdIY1Q3KzRZR2hjRTJrbThOc21mZHJX?=
 =?utf-8?Q?+ule/BoFYvMEu5OM=3D?=
X-Exchange-RoutingPolicyChecked: SNWwkSge0okXTfv97l46OKOeg1DWfJ+LHaL/40OowYgffqh1mXFCiMk5ky9a2wdDp8meY6HYofjJPURwhwfa+9r4YdC0PpwIG9kWvvu2pA+/cLH1vlIKRk3LSd5Cj7m0wanYNUcjeRlDjmu71RddqT5Ljx+kBobBbziX7szA2ezxu2y6YfLapBmPvQX4BinKjkog6LjBhvSlhBFCigZYE51dVUk5OtsP5CX40mWeIIBJyoQwe+ruNWy34LWn65FZBQd2nHjGO5ywYOc7vbvx/6SfK4FsaqN0tOPZVyLJH0z9oVr/ZzSz8BCrtyyo8qq7nOK9+1yatbAp57KqD/7jcg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e9b3c8-f7e3-4437-1389-08df26fc84f1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:30:11.5323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVQcgnLVAvC1MreC3iDjp6cjlhIReon7XGsLPRI8quE9MN0QKSmgkWhybGuH1ln8ezGM19DQDw9v6WZheStWsh4ozehVwpDpsgivpR02xBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF524F3F9FA
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

On 10/9/2026 11:58 AM, Anatoly Burakov wrote:
> Currently, when installing Ethertype filters, some of the filters will be
> installed at a fixed offset into the Ethertype filter table (such as
> timesync filter), which interferes with rte_flow-provided Ethertype flows
> which install into "first available slot" without checking if the slot was
> actually "available".
>
> Rework the Ethertype filter infrastructure to reserve Ethertype filter
> slots dynamically in a centralized manner, so that timesync, anti-spoof,
> and rte_flow provided Ethertype filters do not step on each others' toes.
>
> Fixes: 72c135a89f80 ("net/ixgbe: create consistent filter")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>
-- 
Regards,
Vladimir

