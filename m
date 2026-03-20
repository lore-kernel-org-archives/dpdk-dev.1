Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096461098787
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 14:02:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1238A402F0;
	Fri, 20 Mar 2026 15:02:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id CB1524060C;
 Fri, 20 Mar 2026 15:02:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774015352; x=1805551352;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7NvswbmHjJGPk0gTJKfKKTnvPoUWq8XwluBtjfYnVEc=;
 b=l1Zwi3I+vclJ9JCNyTJMdn7SjGeUUFDSGFOGBk0kZpy+XhDI7EtVrWg7
 zevUB/BHYMIMWJrMdnmtnmSQrv5PpzF5yEEjm5qT5dp0q+rZqFhskGdXN
 gjXx1Ru+a6vPf09zH1OIxd5RJke3R6jGicZbrs/Vufn2p/yPTKEIFdnxW
 UHtVjukyc0JyfuRgWnq19bKbyqnLzjakLcYcVFFtrVJVBkI4cWZJBywxF
 TZv4uLpNXbURb3MPvys0k3XXCnKNxi6OVJIVbxMSkuyE+s97znxKyx11D
 Iuaqqspg7T34vCT1jZbDEL15OGvrhmsUOAggGuNYdR21SZhlEIpmNg4tQ A==;
X-CSE-ConnectionGUID: ihZ8d6WXRdyYje1pT8KedA==
X-CSE-MsgGUID: bUNA1GntRB2GIwQb6w3baw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="75286522"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="75286522"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 07:02:31 -0700
X-CSE-ConnectionGUID: hdXKBFOKRYCCCy1YGJc11w==
X-CSE-MsgGUID: xmJ/VtyuTg2S5RIHt+L2Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="253794762"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 07:02:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 07:02:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 07:02:30 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 07:02:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igVCcstrMoCvNCPU2SyQB/yVY3b+xDTo1UFj6YGg6v5l7E2u/IIMPi0mQ5vah13ePARmKrJIH3YdpddMi0eNw4OWxQyIb4rtSKXcNgxDaPhFZvYwEE22YPuElzvaaQ8PJgsuilxt+xUpxqSfQvwEqsOY/F2FWeruEQhKtTYny6iM0BfLQDsgTykMMtroQCg3eph7qreKOlnNaMTgx/o3ZqvFdmsi0zUwQ+zUNRrF7hrdbIvLIFTv06Vvjc2Kuh6MB5p7kv113agr14RFDdKi20XVUNE4rCD12SZxOhKSfuSLq13unhSATwcdWB/7b35VffPQglsRSfk3q9YDmpKtjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLgu4dK8Lx/1UZkzzHKsjUJ4govSJ8h2shX2QtQomhY=;
 b=Yw0riQnOK1678AeqplORxTUBT8rTRNjgKMAqvUKx8FXVDaoWOfz+ym1fLcVOr58TOi/aZ+XxvJzu90GsASQ6d3uPH/G90V3vX9FFxO2Y7mgXMBk+pFHeqcyIpHZMSwgZoUnqwm6EiSS4vwZgXoyLKqlsmZN41X98pWlnBwcZcMBECEtsjNFhOAF6ZEx4FYwvZz04kf0VBzag2+iiI1ldb2OFYcflKcNtH9puHU18P4ZY/c7W1rDB/bizUmQ4CBGdXVmn1nnM+ZeRTMLS5l2Z9mvFuXdCknNyHVOcitw1pH40RJzfUEjtHdvODnCqzUKBpBZWntwjW4AO6fWJV8M+5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM4PR11MB8132.namprd11.prod.outlook.com (2603:10b6:8:17e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Fri, 20 Mar 2026 14:02:18 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9723.014; Fri, 20 Mar 2026
 14:02:18 +0000
Message-ID: <b686c8b4-5e6f-4e87-9fe7-1c678bd9c514@intel.com>
Date: Fri, 20 Mar 2026 15:02:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] test/secondary_process: skip test on FreeBSD
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <lylavoie@iol.unh.edu>, <probb@iol.unh.edu>, <david.marchand@redhat.com>, 
 <stable@dpdk.org>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260319171334.1151425-5-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260319171334.1151425-5-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0153.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::6) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM4PR11MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe5f379-79dc-41c3-f73d-08de86894c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: iLh+kMxWBWulklEE5ge4AMj726USHQXYLs3JjtZlQ6GCvTy3R2n+dwmaOnZ4Q1zhw4j+2W8PMeQRY52XEfg9hQsa/rSxRq8EffoNcM6A9tRyQ62eaATJQdwnpWck2lIi67ZugZvrrVcghBT7+7xuPh06ivhgf4p1dWsE7ExTYjcBSDQHyVdQdpAq4febE+PsUtBxicEkLPy+vjQuksuHvE0ueKAbcZzjpbdr+WU7o83iOOs1vhjdiJKgjaWNgzBjUxkhWs+6dunFheldv+qXp46wBGbk28pUU4KVG0KLO5/YC+JDLdw2hVPxSvisnKmJrRvlS9gBl17hdGOw0qIoRvfW1AJFQLXq6WrZ1ZqFOkK4KG79PFcQOnZkiWMBhd3NouAjWUIE1T1zoy3GM3xSzyH4QaV5KHDXIsKgtI8OvA4QSU02bkxCBmNtrJyEUk95u7nFTWFEU1kordJHIuN37IhTqfSbne63aziXGHnkCAwrARD7XR6rvG+sajbqIifUXluLVGF3V4EyO675BIVcKOZPkT0aIIOxYRbIA+vNM+rYVmp/qxnV8KQ2XHuZ8uX75bzBclV+GX6mQUDXzOb/9FhCmi3ubr9qpX4gXF/74AMnMNoGbUFanRXZ16+gflQJvoQjutIE5CmL93SQ9I0q2HdVryJDSwcWOsBGnBbItyS1qvZ2KHzuJ/mKyNb6UPIFotla5H/gJh7dQkF3tj9ewuVPdGSkVqv5+qdxfpTvK4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2lxTk9rZ3FVMDRDYy9vVHc2blBHdFB3Y2lvNUh2YnBjZFBaRld3NGtUTEdl?=
 =?utf-8?B?QjFuTU1jR3dVU3V4cEtyQVROVFdnTXhMczdiUUI4RDEyRTdjNGwvWUhnTjlj?=
 =?utf-8?B?b3V3b2M3dHVmKzNhR2FocVViVDRZUk9pOHFONGJuOFBKRTlZbmxjR3MyVWFz?=
 =?utf-8?B?MzQyYnFCbXVIUTNUMFk0RFBpZmUvLzRTbVBxbE81Snc5QVlxeGFTWk8rell0?=
 =?utf-8?B?M1ZvSFdpVGJOcXJTdUs3UXpFSmVVM0pKMkNaUER3dGFKZHNkV0Rpb3lqS2ox?=
 =?utf-8?B?SDlaL2FPbHhBYUFPcndEUi9pazE2NGZKeG03V0tVR09BWWVndGdvU2dEWCt5?=
 =?utf-8?B?UkViZ2tIK1NtRklYVmlkVFppcHVUK1hsRFV5cUU2V0NxMDlSN1I4THJsbU1P?=
 =?utf-8?B?RnAzcFZxcklLQ0VYUGJvNVlCbmV0VXlSbjRDa0V2V2l1aytlK3hvZ3JBTXZY?=
 =?utf-8?B?Zk9UV0dGZFNqU0Y1NUJ5aG53dGRMUzQ3QkRJMjhPVm9BM0FTdTRNd1ZVTHVL?=
 =?utf-8?B?cDhzTTFJVEcycU5YNGFKSTRraEpSbHhqZnFvMlZyQ0JzT3F4Wnl6cXlQUktE?=
 =?utf-8?B?YW40ekhqc3hGQ01WRHA0a2tWcFdYRVg5TGlSeHNTYUJocUNPM0ZoVkxuUHIx?=
 =?utf-8?B?bWxkYXlUNy8xaUJMeFJOSXpsREJ1Z0dpWlcwblZPZ0hyYU8weGp6RzJkbXoy?=
 =?utf-8?B?ZlhmRUNkSFAzbUVEWHJ1VWJ1V01zV2pMd2hVSjVnNlErbXppZ2xmYmdYQzJa?=
 =?utf-8?B?OG14eDk4MnB2bU5PNVhnNDBkS2xLaTVXQmhGYzZ6THI2V3Vjck1LdUx5QVQ1?=
 =?utf-8?B?ZitndDNiVGRzNXVWUDkyaTduTGRreFlXYVBBVURLTmd6N0o5RmV4bWtLZUJD?=
 =?utf-8?B?MXFVSVp1ckJqQ2RLVlZLZlpOb2VCaFoyTDNDS2VZTlZNUTNZOFBGcG1EOThu?=
 =?utf-8?B?UmJtTG95cnNXQ0EyN1lMQ1dFVzZtNVpQeXEycWNQT0piV2QwZ29XNWhITCtw?=
 =?utf-8?B?VVh4RTVxam5KUXZsY2JhTFZDRVlVOHp0SVUvVHpoMENwS3pHaDZSbjRNcTBy?=
 =?utf-8?B?ZmVHS1htR1pzWVBaZ0hwRnMvcDJkaElUNWR5alAvZWFuT2N4MGtERkFZUklG?=
 =?utf-8?B?SG1aK0hKdjByVE5xeEhCUENkcStOMGJEa2wzZDJURWVKaTJyM29XdTZsL2Qw?=
 =?utf-8?B?cEl1ZGl4VThETDFPMDFJYmNhdVlQY002R3FPdktYMi9UaGdYYnFuQXkxd3dh?=
 =?utf-8?B?ODl6Ynp4YThJL3NodkY1ZEQwVDV1bDFaeGk1YWsvKzloNkw2VjRXaUFNV3VX?=
 =?utf-8?B?L3ZRbnc2SnBvUWVFTWRxZk90aHJYdFRWR0VuVzE2VTdKMWFhZVhrRVlQTTZE?=
 =?utf-8?B?OGw4YUxpb1cySFRnWUNXQnlvU2srYmpwcDNqYjF0YVM3eTBwTmJiUWNaTnZp?=
 =?utf-8?B?b1l5Q1ZpbmFxVlBabG9hS3BPOWJTT2dadnp6dVcyVEI2WVZGS1JZa0lKMEl3?=
 =?utf-8?B?NDN3VWFBeUsrN3R6M0J6R3F1b21pK0h5QVhKVVlmTTdLN2dncFNyek5EeHJ4?=
 =?utf-8?B?VHJwc04zTi9NSndZQWxKL0M5TGxDTVo4Mys1UVBRL2RNMnZKbS9JYVlEaFdn?=
 =?utf-8?B?NkNJV0hJcnpVZWNSZ3BRR1Joa20wZFk3VTFHak5DaVY3ZTdNZHJ3SnJCRVFr?=
 =?utf-8?B?azlrUTVwU1pDQS8zZUNKcklxVVBtTUpLNHZQSWs2eUhDNFAvbnpScndsVjRa?=
 =?utf-8?B?ampnb1gyanBiUC9rbWRBVE5sQ3BldUtsN3JsZzZzOTRsNnBIZ0lrRXQ2Ylkx?=
 =?utf-8?B?UVA3WXR0bkthWjBHdWtVcHVLMHp2aG85OWJpTkhpR2M2TUM3WjVlaFIwTG5j?=
 =?utf-8?B?bzVFQmpUcE9ndXlEYk5aK29aRjdIa1pONlJIR0pkcys1ZHo5Z1NMNTV1MUxO?=
 =?utf-8?B?YUhRZWhacWloaHRCenpjemFFVlRlVk84cUxLakxMVnc5dE16UzRUenVoWVpZ?=
 =?utf-8?B?Mk1BaGxwMWlVWFFrUHNRenY0SzNuMjVmOFN5by9oRTkzZ09ETndBejRhcFZG?=
 =?utf-8?B?bVNQSmZUSk1ER2dzRTYrVVZrTVErdVc1cytsVW1LRVRjUC84NVRYSU9mUngy?=
 =?utf-8?B?S29TTHBGOE1oZG1GdTVmTmRTRHY3TUNlSmtpeWhhVk1mU051eFFINzNiV092?=
 =?utf-8?B?TWtJRXJNeDljRmR6cFl3TW9YWkNESldJOGI0dHMvc2kzWGQrK3Y5TjJhMVpX?=
 =?utf-8?B?TmE3R2YwR2RHY1VLTWVBRUxacG1OZVlLWHZMN0hkWWlSeUFYT1IxNVJaem85?=
 =?utf-8?B?aE16TUtTRHZzemxYVFRtY3c1Ym1KRW1pMis2YjF2TTJNVmptSXRXelpVSW5m?=
 =?utf-8?Q?a/FIN79Kc0aiMKT0=3D?=
X-Exchange-RoutingPolicyChecked: D9gJiaMdcRXbotE2QtBenvOq8ZRvdZBX69bPEFRE0OG7t21sEPOxuou1yK0A0hGgnjHi+cB/RFK0h8+IZCfjfQgk6RkgqsTW89xnSpusmluIfk5lFVF3v7pbko0oAHnpYRTCM2Cjn8bP6dF81JgEhh0CRU3gDbKbdWRVGs9i2absI+OsQHoZb6uvHPlphhHa+EDC0s2sLM9qYvGlFj6ewD3t+4GskHKcotVulnbhcXHfFGwnroT7CYtavZWfskErAoH4UrImKO23RNMJlOUigajv9K6MgXFxY0tfMYrm9ScpW5Gx50WIL/uhxe9br/r2WEmkYXD6cZNO+4euJiTbqw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe5f379-79dc-41c3-f73d-08de86894c52
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:02:18.4562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Es2cQLt1AoJwV6o1NgJJ3oYCSElu1vtzP9TUINYhR6dI5g2JrnSGkGNedXxTjwGew+JxStWfpcTbztac3+30uBaj5nrjoUfP4qxAuuu/la0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8132
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

On 3/19/2026 6:11 PM, Bruce Richardson wrote:
> Since there is no secondary process support on FreeBSD skip the unit
> tests for that feature.
> 
> Bugzilla ID: 761 (partial fix)
> Fixes: 764bf26873b9 ("add FreeBSD support")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   app/test/test_mp_secondary.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/app/test/test_mp_secondary.c b/app/test/test_mp_secondary.c
> index 218eacb3bf..93fcfd735b 100644
> --- a/app/test/test_mp_secondary.c
> +++ b/app/test/test_mp_secondary.c
> @@ -15,11 +15,11 @@
>   #include <string.h>
>   #include <unistd.h>
>   
> -#ifdef RTE_EXEC_ENV_WINDOWS
> +#ifndef RTE_EXEC_ENV_LINUX
>   int
>   test_mp_secondary(void)
>   {
> -	printf("mp_secondary not supported on Windows, skipping test\n");
> +	printf("Multiprocess support on present on Linux, skipping test\n");
>   	return TEST_SKIPPED;
>   }
>   #else

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
