Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4731098787
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 14:00:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F9A9402BE;
	Fri, 20 Mar 2026 15:00:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id B1DB4402B2;
 Fri, 20 Mar 2026 15:00:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774015225; x=1805551225;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QQsrItfDKOnooD9NUP66yaKDc/NV2I6/GGS2MHNFe9k=;
 b=bkcCo0G/MiJURXqbc9cwaclbmTPsDdsNN/4FdImpQ9FZDm5h+iZHCDI/
 PaZYVkhQZ994hbAlqBilHS2M3YC04dmvEcTfl0pO1iwhMR8eeIQ7rIlO9
 NgySVTcdWt5mjHUeFS/N/9bXUbvJRK5DR7s0tf1+NLmAWf5cAQD4Ky17a
 zSnEhXA0D/QbwyxK13BO0i45S5Y01ewWrNeebYhxxnyJgWEolWVcA4H9/
 oMZNjvmSwsD4cb5+Zh73u2h7fO/Z4DeTSVhFO3g9YFuzdsGKBg4gQbJEV
 Bgk0ON27Xwe3jXE5NF2aEO++pqej83L73qpLduFPqS7/S80lzFevy2DNU Q==;
X-CSE-ConnectionGUID: f3cd6DcJTuWDXhh51XTSYQ==
X-CSE-MsgGUID: llvKXtrjQVutV1cPx+zDvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="75130551"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="75130551"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 07:00:23 -0700
X-CSE-ConnectionGUID: 51ue/vmoQKKu2SrQuhM5bw==
X-CSE-MsgGUID: Rj3qPHVrTzm0HOoB7pAH4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="261198473"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 07:00:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 07:00:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 07:00:20 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 07:00:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+3+1p39Hz51zD55pdKvwdS16r3FTueztzgagjhetPSgkHTyK67N3RtW+B9xuu47u5vEAZOtKgd/fqM8vosDTG533xF7TTGadQLkEJDdXybD/g0UFwao0JdzX3iAIvKktvbIGWGWRoL0w741ZyIfprTvssn1tAwjc4kHlHAdE25kZhh03cfBWORYgF8FVtjmCpOQdUGfInVTlZHkFb7djNW/ZXJ6os+05tmvgUWtSyb+NVaCee7a4zZ/PjVOiQdFO2BDMCsoy1N+wi3MBr20NIY2QbqJCCq109u798FXgO7KUWcYKvfjAk9vpw+BYFN+LpJKQZNewsIzI/l/RlJWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43MrlTtoEvo1NVALzxDG5an+Ep5FiD1T/xN5e9f5OCo=;
 b=RqSSQtBvs+2dl3hCCIU3VepVJ5SBk6SPx+w6OfjaNRgJTNFVPW72DjlY7Ko8RLqxbw1LfyEtMe/zJc5rhVLUW4kS3yJCIK57vzoGbou2yrN58pjbvlj5ZSXH5TxbE1iltOTP3cdwyO8OdkjgTr64b5+jFPPTWgzfM9yDDXqqaULRkd30332AIWdJPlepTGqlC2vF4lwtgtSHYCjttWmvxD8SHJEZevuvpWdmEeMD/Du+GUl9iWhATC5Sf4itBky4GpfEdA7DH7lhTKIU602LeVOfgYR2Jam+PsgML1DQi4VhVuUh084UxQh+Iaj3pY8jYcT5gaFK/feM3Cs/1HEdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA1PR11MB8224.namprd11.prod.outlook.com (2603:10b6:208:44f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 14:00:18 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9723.014; Fri, 20 Mar 2026
 14:00:17 +0000
Message-ID: <892b42f6-24ab-4072-848a-1b9f7f03e39b@intel.com>
Date: Fri, 20 Mar 2026 15:00:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] test/debug: fix unit test on FreeBSD
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <lylavoie@iol.unh.edu>, <probb@iol.unh.edu>, <david.marchand@redhat.com>, 
 <stable@dpdk.org>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260319171334.1151425-8-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260319171334.1151425-8-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0368.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37c::16) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA1PR11MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: ea02c2d7-08d8-4d70-b3c4-08de86890456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: g6lPmxBEm9Z6pASVWptAwzVEyXQ0TELywUUB+d2OxKYl8J5T16UNv7a7TBOL3j663wrJN+gCDtM57THt43qj884jSDtXWGkYOk0qw5P+1YBkwiU0MV2WK3isERkKmYdeagd3hdV7BHRyRy4QovPnR4bw/QUD0MTnj/5dQVIUjEQF2X3LAgk5DXxZm65OWYz1olfpABm7ioySpEeO2yE0GIeXEZIlVmnZ6TSi0rDo4fUTAagwPdpKmOIv3EboIIRomri88IYXnSD6QFDP6Wbh5uoWUUKSPshuNiwW1OOdcer1HCJmYvDtK6n4ZkTi7hy/hqcMd43octm+S/hOe8x3/YsWKVASK9jUA0Q0gYV+gilST8AJhGF7yVGP80hd/pOxH+P/QtXehSEhb+gspzZ8jVaMl/OMupa0Fy1Cvk9OOzhmqg2wXF9mSWIw7AM2MFsrS49EzK5Gph7jeDQ8465zAlMYEuiMVmhAZkGSphjRQxMnNsrKbzmYwhnlSJbrHJt4I3+In3e7ft6ZvUFWn8T+xe0POINyZk9Q9CEOYzp/t34hOZUSEOVKsTBKg1XLYyJ2xX+ggoC1OOZ5GZQggCqbMsB/XOPkyvWrAnupLr/VWOvnTZATrXjoDns76LL6EvadLGuqmsucCkr3LFs3l/GND4n3RUR/ukHCa3UmmPIkcP0GwdtpPn/MbFO+Sxptw5AP3Owut2BN6eSp4Ccokg9GD7heUF98hBGJOzXa2vVnvLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cExmaXdzQyt1U3ArTnNLc2JIYkgvTnhHL013UVFERlNmNStuV2RWaWs5QjUv?=
 =?utf-8?B?czgrRlgzbVh1c0l4K3hISERYZS80ZWE5SFkxcWM5bWVEalMySjVjWWxvNVlq?=
 =?utf-8?B?K3lXZVF1T0JxYmV0SzIxaHpTVGMxbVZwdE0yRGxxRkFyZkkwbnR6TnhWRHA5?=
 =?utf-8?B?V3huT1ZEQURQTHA3VVQxdk1VdVJ0U3RkblNjUDNHK29RLzE0dzVncEtLVUNl?=
 =?utf-8?B?T2gvSEUzMDJEallzYVZERWhRdGY2ZGZ0TkZoNlRkQlAvZE5CVGlKTTNONnM5?=
 =?utf-8?B?dHo2Wjg2TWE0QW0rdTZ0SUcyOGFMVWV4WlhaaWhiZ1JaenpIS2pRNTcyaDE5?=
 =?utf-8?B?WXNyRXZtRGU3UVNKdUdYNWVkT3I4M2JacDgwK0NmaXBzS3lBTTVRVnRiMG1O?=
 =?utf-8?B?YW1CeTFScXJ4N1lualRNY2J0SzJ4SUpsTWNVS1JleUI4YkFkbW1wbWI4R0JH?=
 =?utf-8?B?dFlBZXZuSHlvK2hOR2tWT1ZJUjJpWDBBSGI3R0p1V1FhcGNHUi9nYjVDTWxz?=
 =?utf-8?B?TnFXQkhzQU5ERU41RnNEY3NXQkhDMWJpYkI5cVhjS2lza05Yb0Y4M09QNkpt?=
 =?utf-8?B?L3N2eU5PK3pmZVBZWEMvM2tScWZPU0ludDkwSDBmY0pMTzU0ZW5rRHpPMlE1?=
 =?utf-8?B?R21CTkpPb3d3WkdXSlNJbzNlQVplck5aYmF0V01pWC9YamJheVBaVW5tOXYw?=
 =?utf-8?B?d3d6QnlHd0NtSFNKR2lBdEpkRGRpRS9ML0V2aytSVDRCNXBIdk9VWVA3Nzhs?=
 =?utf-8?B?eHlzODJjNEt3Snl2ZU56aUczR0JPUDFiZkdOSDRVd0c4bk8yb1RwaGRod08y?=
 =?utf-8?B?em9aNEZwNW1VNk0xWHVnVkk4NFQzYUZoUGFQcnlGMVI3Z0ZDbWczV1h0YnJC?=
 =?utf-8?B?NTUvbXpFU0Z4LzFuNEEvUWp3TjRzTHA3NE5RMGtSZ0NCNm5UOVZ2cjNBbGRW?=
 =?utf-8?B?eElTUzVONjQzanI0aS9xNFhlLzVIRTJjeVBlUnpiMW5aWm0zZU9ra3J5OWIv?=
 =?utf-8?B?WC9jcGxRbXV2UlNVam1RZGdiamhGWGJ6Y09UeEJLY21yYnJ3aDc5MlRxL04y?=
 =?utf-8?B?ajFkeUdpMGI5N1gwUHM1RGhLbG1qY2ZCU2IxMGtPblFDek8rY0dSeEtIWEt6?=
 =?utf-8?B?QXVTMnYreFh5bTZZeVo3ZlhFR3JtSkJKek1mWHlBbHJ5Q0tvVmtTZXJwUXNP?=
 =?utf-8?B?ampuK2R1UnJtMHhiVko5dEN2REJXc2FYS2hMMDZlUU5HQ2ZvVWFsTmpuT28w?=
 =?utf-8?B?V2t0REh2OXZKK2t3bHFpN0lMZzdxT21GNjRKS2RXUzFoK1crUlk3NXJiT0hH?=
 =?utf-8?B?amlxd3JWTVhVbjVGRWY5WFdjdmk0QlBzampIejNrSERSWjJPdWJRSlJOaGpQ?=
 =?utf-8?B?V3BFQVU1ZGVOM1pCVnQ5NyswVnVhZGtWNmhFcjlPc0cwNXpwLzUrQWNLS1Vx?=
 =?utf-8?B?dlVYR1pKMm5rWW9RN2JaMGlXbXNtUnRNbjQrQVVqR0VSMVNFSWpBbWg3UW9w?=
 =?utf-8?B?SmtpUHMrSlpUdzFJNGxQaWQ1Tk9vRDRTcEFvZkdIcURVem9PV3ZkM01aNkt0?=
 =?utf-8?B?NmZIUnNLV3kzMllpNnF0TkxZMWZ5TlF4SEpWbW5zQ0pYUmlsbWRFdUVOM0Qv?=
 =?utf-8?B?bXg0QUJ0VkQydW9sTUQrRllYUEZ3WkhhUnAvOGJONU5RdXk1SzdXc2ZQVjdl?=
 =?utf-8?B?V1g3Y0tucUIxcDlHY09GSXRSYnJjb0lndHdqVnQ4RTJTT0p1bTl1YU0wT3Yr?=
 =?utf-8?B?Um1zaG9YNXFQSnNqYUEwZUZWMy9YNkRzcW1rakViNFZUdVVYa0kxT2txSzF2?=
 =?utf-8?B?ZUlpZWZkQUZ3QTJ6VUEySmk1ek5Qb1pLeG1PYnNEMkdxalRORkcvVkJEY2V5?=
 =?utf-8?B?ZkkzNWRpV3B3MEZ2UFFaUCsxd0dmUDRnN3JWQnV3SmYxZVREVFcvSndoYThK?=
 =?utf-8?B?RWdrMGJPYUh1VUpqcU5GemtBcUxERHNTYStSK0xMUXNiUEw2a3lPMTJDbjIw?=
 =?utf-8?B?VTkxTThvS1pZNlNUdWJad3dsQTN6Mml6R0JtdnVIRDZPdVl2YnpwaW5lV1JG?=
 =?utf-8?B?eWtSYy96NWdLZ3pXeHM0T0NMWk9zcTlHWnFJOFFyN3IzN2VudGIvU0JvRkRZ?=
 =?utf-8?B?U2xyRTl5S2pROVpXTTQ0czJzQWRNU0hxT0pvMGtYNEc4bmVQMEtJOG5wQi9C?=
 =?utf-8?B?MnhnZHZyY1B6elgwcDhEMXBwaDk0dm5KRmNrVmJiL3dYSGhNNmlKSm5kSldD?=
 =?utf-8?B?NC8wNE9nbGlXQnJqSzdVdXdZTW04Y3Ywem9zR0JxZGNYYjhOeXNQZWJCemdW?=
 =?utf-8?B?VGFWTnp6bE1td3kwL21VVUpXYStvQjBidlB4VkpOcUxFV3BnS3UySkIzK2lK?=
 =?utf-8?Q?px0ZMcpW19mc9XUU=3D?=
X-Exchange-RoutingPolicyChecked: OEpMtucujWi8q/heVd46Vee1Yej2lV8O3Zu140DZ5kZLRZI0r/pX6/6GBK10ey9RRHB5s4qEMsqkTCcbNm7pgUq58oUyRy3HWOxyRp9j6cvfclXQdKkvo0W+wAisLJqduE2f05xT3jN1mOJqXzqZjFgECxVHJxmKnGIUaWbhxwtQeaPJUTW6VHkdY4HU9BXw1xQToXSLYaobtebb0RNQ/TzbYNgccNWTLaWDJBe5hzH6HgkzF+WswzK+X4Sm1sPVysCRflWsSYsNnFUn9AqSmSuVjpr98cmMsXte8W5qqsvRH5HkNMj6Tl3qGKMSHAODPzBhe3F8HVt39fH+4nVNpA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ea02c2d7-08d8-4d70-b3c4-08de86890456
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:00:17.8070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxGlu3L81N8KpInmHDhgHffacE/3iswtRS/5WYiqk9Sv74hNZ+Qwm/mTMJ6/uVa85XkGaXuOUBaCqieSkO1BaIGdKFJdbucCL+eqarpzNQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8224
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
> Fix the test_debug unit test on FreeBSD by:
> * passing no-telemetry to the additional process calls
> * ensuring that we always use the no-huge and no-shconf params
> * removing the dependency on procfs to get the exe and using argv[0]
>    instead
> 
> Bugzilla ID: 761 (partial fix)
> Fixes: 764bf26873b9 ("add FreeBSD support")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   app/test/process.h    | 11 ++++++++---
>   app/test/test_debug.c |  6 +++---
>   2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/app/test/process.h b/app/test/process.h
> index df43966a2a..46b69ce330 100644
> --- a/app/test/process.h
> +++ b/app/test/process.h
> @@ -96,7 +96,7 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
>   	int driver_path_num;
>   	int argv_num;
>   	int i, status;
> -	char path[32];
> +	char *path;
>   #ifdef RTE_LIB_PDUMP
>   #ifdef RTE_NET_RING
>   	rte_thread_t thread;
> @@ -188,8 +188,13 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
>   		/* set the environment variable */
>   		if (setenv(RECURSIVE_ENV_VAR, env_value, 1) != 0)
>   			rte_panic("Cannot export environment variable\n");
> -
> -		strlcpy(path, "/proc/" self "/" exe, sizeof(path));
> +#ifdef RTE_EXEC_ENV_LINUX
> +		char path_buf[32];
> +		strlcpy(path_buf, "/proc/" self "/" exe, sizeof(path_buf));
> +		path = path_buf;
> +#else
> +		path = argv_cpy[0];

Why can't we just use argv_cpy everywhere?

Otherwise,

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
-- 
Thanks,
Anatoly
