Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBEFC9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 12:05:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47F62402D9;
	Fri, 25 Sep 2026 14:05:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7CABF40294
 for <dev@dpdk.org>; Fri, 25 Sep 2026 14:04:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790337899; x=1821873899;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=g9BsmBg6p7O+UTAmIqGoZyjiYBjsEjshttq5MlwzSks=;
 b=Qn95rQ8d0WBdc2Z/KEONrn0khEL5OUgbZ3UH9yEMBV+22WSNqOxI6y/A
 ZGrRSTrqzRmEQaylIrfPi4atFDM6+FOjgR1bTPepG3uUsKDcDuFd7ZIs3
 vI3a+US0RcCKeCudhNQqBfy0iPDVTBWRl/rL3JHkY6LhavTlwwTIB1Ih7
 rHsqx/rWULSDv4bPcmZdEzDgeMQ5PwUoeOoWKszPGLsdiExmh51+Ntoi4
 Wu3H4tSXEmraNUyvR32kvAkvpZ5grN54kUCkujJjKVRv+oJIDNygrLPew
 yBNAmLzCNW0uvW7XYWOgpu3Nvr3OVJzucGm7XAoh25yKtPQHUxtL8+p7C w==;
X-CSE-ConnectionGUID: ZOyzLGiwQ82KffY1zNto+Q==
X-CSE-MsgGUID: KErx/eWAQOiMqLSb26OoEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101648929"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="101648929"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 05:04:58 -0700
X-CSE-ConnectionGUID: v3n+jSJSRpiwzha1LDx6+g==
X-CSE-MsgGUID: WsC2fcEoRA6zFCxoFrkJZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="274487796"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 05:04:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 05:04:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 05:04:57 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.54)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 05:04:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+JWqYqb50lBGHybTMJMgj3jaRDyWFKgdmp9ZEZWTOb9dTi+I4Nvcfsi4iMvjMLOPZmbUAn4kd0tvwkDzdk4GOlHkBeK9iMur5tXCXW27CEz1nbZlYUXgdwAqkVXEzx6NgAFaMfcWQ+OHJ4A9GbCyUD8hCc6kGVMNnRby4m5rjTF8qx8vb97+9ANa5SVj9kDK1e4hbMbhS3zWs+dIKziKlZeq5NObusPMbhdkwOp39jaXF5kxGpdzugpTv/DK2jZ8YzHTcy8BCYcDc0a0ZdmbZeHJuspoA3sm/pZU13uieBRTRlzG5/Gd1J4v0Nm4LIYIO5EU3txMPf0HLxp8+37kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iz1LihMHUhqNnMEnp9XfPiok1e08S25Z2qLE8QM+A18=;
 b=Bt4iWuQlXF3NiNonfiwevfXG/CB9umRwhj2w45K+VD//AhwCNADDsrSofN7jfggYDjy87rbamqH4cucFDVNzbFNw74ktK75NAHs6vWV8BuR/fqvelQiAjCX8QFD1AljddYh6QA7TdO3LX7ylIWVa+PQ/fPQrEiauuDIRS5aogirc9whbOGsQLSx8W9BplkKR1PN2rH04N5zEk8RboHbbSHACOF2K4zawRyn0xIxTky+4AScsg/1oSBEiMFIbfLl3CtbCdDmaXhCRv00iL8sQSO3GMrhz+WzfbwSi8J8SBkPOBW3yqlaQj7NOTLYJSJGSCkqTAWLi4ZwgNOiM5+NzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 BL1PR11MB5979.namprd11.prod.outlook.com (2603:10b6:208:386::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.18; Fri, 25 Sep 2026 12:04:53 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 12:04:53 +0000
Message-ID: <fc8d48f2-d451-4113-8c25-ba1df670cff7@intel.com>
Date: Fri, 25 Sep 2026 14:04:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/iavf: fix dead store on reset path
To: Ciara Loftus <ciara.loftus@intel.com>, <dev@dpdk.org>
CC: <anurag.mandal@intel.com>
References: <20260925085832.6780-1-ciara.loftus@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260925085832.6780-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0212.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::9) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|BL1PR11MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d74392-3532-470f-d874-08df1afd3503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eNR/Wm5/gylAQxI+Y9HpqdQWV6nVJgMtLXM3uJ+TaiIpzAy/PLdRrTkcyq9NUHLryy71MB1Sh7wZqsVZmfHGspWvAidJ6npqWZyxhfafuhOsujALTAOIMPBd+Vnr9X8465sUr1Fr2/wgUcxtqwkJBLnaPsuzNj+T4LTa0USFE4C3nrwQbgxYc1nQW/svHVdZHuKNZeNaZsDJuL7EDJBGW1T8lzVeBJykks0EEh8q6EedwVkEhTU1vb0z7CWZnEGqEr3lETQlGSuETpznsYqcC/Uv8EdQlDEdeWjjk8wcuk2MGoNjdsIYbXYApZdVB/xYzG3eDqCL2+mN0eCx/BtaZWqddPtMwScShOpCWaT6sL7TVUuQsCMa4zCxgDCPwktkgM6OcbnX+8SK9Lb7iIdSmF/vRCjE2AAwgGhLyX7erx0llIA4m+HzCmkfcstjSnnfMiyPLikzbax2Zbn5rMIuV6dPeg7t9NoeBNkhRPfd6pj8HJjmt/hiAOlZgJK+dgyPdCmlXkgAIw7kPy2jJRRdp/Cv9H2lLCH3iM1AkDexvN6+IanXG1D1TNA+iURJkq/WUA9BTv0p2zfrTKLOgwcwtag+q8LtJzZZD3+X4yguQXmyx+9iUYeA873KfEM1wnho6uy1gjCiLJFW9VaCv2USvC1oe86sjXAn8i/8EJXc7qs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm50bFllRDVKV083TGg1NS9aM1VhcEY3aEJrMXRULzQ2UUdlSnR4aVN0K1Fi?=
 =?utf-8?B?YmpYaFIrL3FCWVBERXllL3FmUTRDd1BPZ0ZlM2ZhQkthMFV0a0hWeDJZeU5Z?=
 =?utf-8?B?RlJwSCtqdmRTdXh6b0hMczUwRkd4Sm9tTUdjbm9reDFocnVZaWZkMFBKNEFo?=
 =?utf-8?B?bTNOVlFQTkZsZi9kUk1MNHhiVC9mUWtkSkNmZHNBZnNwb3FsaE9scGNHbEU1?=
 =?utf-8?B?NHhSblF3ZWJ0M1lUbUd3QyttdEp0ZVd4elBpYVRYRVBYTlcvQlJuTTlaY1Yx?=
 =?utf-8?B?eWpQNzE2WHdZbklOazBLTWd5MFhBNUFmVjVMeVpuVSs4NGp5a0RpK1JQL3Bw?=
 =?utf-8?B?ZTJ4NE1Md1owMFdjWkJxL3lnV2gxbzBWNFF6aXErNk1aTVZhcGJkSk5lNit4?=
 =?utf-8?B?Zkh4R3dtdnhIYk1Iek1BVWs3cmdBa1VwZWFBNTYrbTdRczZqSFB5RUhSTFZy?=
 =?utf-8?B?N0pMKytkc1JhZW9naFN4MUdhekJISmN6NUdLa3RLSyt4MkR4VmQ0VmUxKzVM?=
 =?utf-8?B?aFRrS3V5czRPQU1wck9PT1hqaUF6TmxQYU1OdWJTWWQwVWFJcnZvYytrUWJR?=
 =?utf-8?B?V05JRHFERU53dy9vMGp0YTg2MkZOUGdtOGo4eXQ4VDNWSmx0R09LUHVrc3N1?=
 =?utf-8?B?TWo1N09kMStlVnYwMTltdldDQ3phZzk3OFdWZ1N5bCt4SGxNRU9qdjRwOTVK?=
 =?utf-8?B?a3JSbVJyaFU1dkJFNWkyaWtlQ1Y3ZFBtZXlwZnY4QnhPL21hd3VveXJxeExs?=
 =?utf-8?B?NEZ4ckRaaHY4bWJJOWxQZ3AvUU00YkNMbVNsTHVaeW5jVVVIZ3hYM3pReUJK?=
 =?utf-8?B?TG5uNm1vR2l5R2RZdDZ3eklaQ2IvcDk1WlV3bGlIZHppUmRNVUdqQWMwSjYy?=
 =?utf-8?B?SDJFbUJyZkwxVmpWbnh1cVNuZ1R5eCtvdkMrTmgwS1JBY2ZyeFAvaGpQZUNj?=
 =?utf-8?B?UWtLYXpja2FMZmVTcWRnL1hyNUtCTUExV2NsRWd4OXFyT2IrejNhQXlWcFdZ?=
 =?utf-8?B?aVIyS2VtdzRjR3pIcUVGcytPVkFueHRZaDVNcjJXTHhtRkIzUy91bEVCK1NU?=
 =?utf-8?B?TUd3ZUVjbTJwazA3L3RWTDN1Z2o4bzZNejMxWXVrN1duMjBHSFcwbWM2Wkh3?=
 =?utf-8?B?Y0NLUW5oRUVZcWxtL0w3cjFnYkpKOXhtTXY2amNZWktteUp0N3hPZGUxRTlt?=
 =?utf-8?B?S0U2dFZTRk9qck50M0RpeGJXdlNOMHYrV1ZEV0Q3SGlZSnUzbWQzcDhTL2l4?=
 =?utf-8?B?TUUyT2VQbFdiWlZaWnU3ZVllcS85VjZkM2dGWW5kN0VIVmtGV3BhNWg3aURN?=
 =?utf-8?B?S3l0MVNEMmtOTVFwck0xaTVXNDNTUDlSdk9IUndVMm1JYmpWeTZhVjJ5NmRs?=
 =?utf-8?B?dkdFdzllaVNXSlNPd2tYVEkxMy9kaXd1WjNiM0R1dVZCaXdjN0ZVNDBVVnd1?=
 =?utf-8?B?VHpLVUFBbmNJK2R5NWRnbFdpMkFxUDNkWDE4Q28rMDNjM0pKVll4aVZ6dTZW?=
 =?utf-8?B?OEFyVVRTWnIyQ1RtRkZpeWp5YnhyeHUzNFJxUWZ3Vll6Y045Y3hPbURqT1gz?=
 =?utf-8?B?M3JNMFRHY1NrTjNnVWpocHZzN0thV1RLVG1YWm1oN2ZFb0lvQnQ4UTZVNGh2?=
 =?utf-8?B?ZU5zOWtDU1pPa2VmQnh0cTdkUC9zRnZQdkpqWTJLYWx0YWwwN1RNbEVKa0RT?=
 =?utf-8?B?UFhuelhvR1pXSTZXQVRnN0EydDg2bllUek5LUU1zTkpESFBLN2VYblIzL1JE?=
 =?utf-8?B?WlpWRm1sU3RQVk5DRjVqVk1KRndJd3N2dlE4VWFzNEVTVTlNSDdSeWFYMGNX?=
 =?utf-8?B?VVovVXFiNjNmd0JSS0ljaXgzdUY1dmlvVHpETE11Tm1KbjR5QnRvNGNNeS9Y?=
 =?utf-8?B?elJHMUZVL0svMlFwU3NUdGNSZUNRYUt3Y213SFdPUGRKb2pxVkZwNW9CVVVa?=
 =?utf-8?B?TGFVS0o3MjVSaFFZRjdzcW85RGNZem5wcUN3S2hOM3ZuSlV0T21QQ1JnTGNn?=
 =?utf-8?B?SjhwS2orU1laREh5OUttREoyS1dRMnV6ZWJLRm9pRVNjUjZWRE5qSmw4M0tO?=
 =?utf-8?B?aEY1NFFJUXJrOWkxenFuVzN2VjFlb2c3K2NjeHE2N3dMVTZIdVFuMHN2V1JK?=
 =?utf-8?B?alpRRUhWOXM1Q3A5TUVtbHhPMEFlUVN4bEtIVm1rL3FzY0FUQjAvckpsRUdo?=
 =?utf-8?B?R1l3dXA4b2dESGVvbG02STBLZGtaSTVCdy9VbGJpamd1SGpVWVNoTnJKa0kv?=
 =?utf-8?B?MWxvNmVsWWlHMkZES0luTVRmZXlBalBLdm02b2hxMGVyVEt4ZTVMUEZrcmcr?=
 =?utf-8?B?WkxHa1Q5TG85Mk1jV0ZSZGpkTmtTcHNPZnRuZFVCTmlKS2VPK3I4YzRMNVFx?=
 =?utf-8?Q?VGoGmTNtjaHSVJSY=3D?=
X-Exchange-RoutingPolicyChecked: qRBUp7MuMGLXysR6UBQ9jYcyQ5ld50wmhwkMw1+akiW4YYsLXDNqXdkqxA47hpX8otTBxT6VifS53LZT+mdAq+Gfqyq5hbhlJXRNERN+MJ8EzKbRm6AzgHGZehYf+G7uKPJYLxr2jR/fw3YfbI3+Ua/x7KABT4vZtMcWBHL9RTYKjg/DlYLkcrDKIhssyvd1VaTS+K1je3GTMQpe7eATwkX5cr32yEH9pEA58/Ggmpm6ISDmFP+LQXVOap3NszLvZtYncPanyRw4ouFGncfKsdQ9ZkTO3u90WQYcN5eeca2Q0b9T/vPNNP/NLrGRIU+1TDPisYzs/nO4CrGN9dD0Zg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d74392-3532-470f-d874-08df1afd3503
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 12:04:53.0190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrXCKYlIAizUjAfAoSVeH3VIxOmfziOpPAqBZgzma0pi0bhNSCMi1YViFWJg6HoscuUMhx5D/HO8ibeSCngHs9lBQ0xrn7R2qhnBcz2S/kU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5979
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

On 9/25/2026 10:58 AM, Ciara Loftus wrote:
> When dev_start fails during reset recovery, the code defers the start
> to the next link-up event and resets ret to 0 to avoid treating this
> as an error. This is redundant since ret is unconditionally
> overwritten by the return value of iavf_post_reset_reconfig()
> immediately after. Remove the dead assignment.
> 
> Fixes: 9aac2219dc2a ("net/iavf: defer device start when PF VSI not ready")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---

I wouldn't really qualify this as a bug fix except maybe static analysis 
tools might flag it so perhaps having a Fixes tag is worth it.

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
