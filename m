Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D40C9830E
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 10:11:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E6614326A;
	Fri, 25 Sep 2026 12:11:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id EB92A40B9F
 for <dev@dpdk.org>; Fri, 25 Sep 2026 12:11:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790331071; x=1821867071;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=79gOOLQH9NgRzKGhZi5hJYdB0hl8qC3gMUABfyDun9o=;
 b=VkyKtX8W4lDa5x7b3SZyZqhEX4mb2VNrXSHJrXOfjLwSTKzs00/Bu+kM
 XZjsL85ptKiCklTnb1bQ3syOSQaSoosVSApp+nKBNCQl0H+dcTUkLspGV
 GLtC3nPIXDrIumr1x4JLOdUE7fKJnLv+MDGXtbLWGEguRAC8o7YfzwHFL
 7Wls7nolZIEVZYurE42r/SP6wjshiQ+5rsJFe3Mm1gf/WHhfUu4V/Ywk5
 RHIl2BhpLJlKLZFBdFWivUiTqGuayTSKY9tWLV7GvzegRZqA1HrJE8lgk
 ZDOi2w4pWRiv4Ep+jhxWjVjj9lGSBGgOlHBzXr3OfVa4+knofyBdv/bXK A==;
X-CSE-ConnectionGUID: CV0uUxlBRpqYVYaNaK/e3w==
X-CSE-MsgGUID: m/mdo5kFShuVx1R2HVCLSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="89882782"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="89882782"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:11:10 -0700
X-CSE-ConnectionGUID: hWGYxPtBRCmdbZnFybum0w==
X-CSE-MsgGUID: uHHuWNMpQO6WohR8hBFO8Q==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:11:09 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 03:11:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 03:11:09 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 03:11:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUPohILOOnN4+I7sJEJTzNKNNY0AEp9Dp1kLCzB5b4H98u7JzxsrUYilWdKZ8YLrONrbdPDqaJcfFavgT7GM8D00lT+M3WbR7zjUotqQe1sHIyVFjKSjMiaTdpM/m/djagOrnyIvVwtGe+z39scz2BOan8gGMwiToUYMMdA1uZ55bNr6a0GEUasOnP9qHDtPZzNx5/z7eUF8aFPaFi8TZNCw8IadXW/DhTM/6+UkdgtRGBKGgqKgVxG2iizbZLSfw38+lzormzfa4VhSDFWmbOUm1Oyd0Ky/B6jKFQD3+OrdckaxxA+BI8ayrardkeZ3Az6sV0nB3CBhTNJfCiZxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjIt7+xSnfWbCHHSLzh4tYt3fTZWNKvVxkvb8mspvhk=;
 b=J1MLG/vmTo+2hPF/r9aeZfZFromNLzdPsZSrZDpWaOsWrmOhZ717Hebm9j64wTvTyH8Hf221BWRuZqrNFVax8B5p8ahxX/4dm2g7LyE/J7H0cCndQh8ik/MhB3b49k6K/KqPu9gBjaRm7FU9XUFLFkeoKnn3IpaVtnp5P+sjg7VompDzZr/TQaDONaT6/hf2JfLDP0AB64MeWOhxrqtX5xAG6RL0W9z14VAvGJ5Go3HUOycj4i1gk1pyZAMhhfoBFnf/vb0Iv3fq2gDQcVoR2PnY9NNQCGGBxCbGIk8YdoJwKoLzQGFK+gTiD6dm26wAaayGYknlLRaFMnJ9GZicKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA3PR11MB610523.namprd11.prod.outlook.com (2603:10b6:806:589::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 25 Sep
 2026 10:11:02 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 10:11:02 +0000
Message-ID: <1fa2e254-1ae7-45e3-8400-55878e1cd826@intel.com>
Date: Fri, 25 Sep 2026 12:10:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net/i40e: use common AVX2 Tx function
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20260923135146.3527913-1-bruce.richardson@intel.com>
 <20260923135146.3527913-2-bruce.richardson@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260923135146.3527913-2-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0211.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::24) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA3PR11MB610523:EE_
X-MS-Office365-Filtering-Correlation-Id: 30242eb0-2089-4556-0124-08df1aed4d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|22082099003|11063799006|4143699003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: B/6MOTg1oZrqwIPnBKPg+l3iwUqb1nx2tLtJYf53koISEjcbMzs1Puz6lGkLb1CuPuw5nkOOr0vLGBTmJG669P13RGteI3ecgtwQnFux05RKj2rPjcLUJbQ3S4LUEWet8aOVYxh+EqmU70Mc8zgnbAReBFSSjfH39Qi8qntG1rb2CnTICrN7x5eNjnP7eSVhYIu1WKrSXdAU/pEzBdoVwV5/V2yjeMizSS4kgCLLXCSHVSZybk9FkYKECX1q95CAtbf1+rvba4n0tX0XG32zCc9t1lx2F/eYb1TPNnACKzuRrcWX3Sd+fn9KTnVCJxqn4e+hlryeyNdzAjCDJC7gOiD6gwetiMNvHovEzjlfQXv2YnTNMF0jpJaN6ag9Du33K8l4rYtzX3wYcaMerv/sMC4ZtkDt1ZpnXcUaScEyO1cc6+PWbx3s940B0cCWYgUSHDLRmSIm/L4iJIDVFGY8uGknKJqPPYDltZhNrg6fZtWpUIm8q1xE2/541Ny3VOuQBY32njvTtRSxn17MFhVHTlYfy4VRAZuJGvNOZV7pzkuFMJy0Md+Ekucvby/owmlTyNxH6rj0+vVMmuIhlXwYo4YIAx5e/pyxh5Du6gkCxZuIFuDFaHp6UUkLIOFWrR/j7wsWbNCbHsBBQsJue0d++eFr0+eQ/LtPqE03SLGBM78=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(22082099003)(11063799006)(4143699003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUNJTkJvR0pZU1pvRE1hdlhQOHdLSlpFeit2bzFjK1JnS2c1RjFZaXdNUkp6?=
 =?utf-8?B?RnhZOFRVTTE0M2xOME1WcVlSZzlxdnRkQVlwM3dWVmQxQ0x5dEFXWDY1SitN?=
 =?utf-8?B?M1hsSTJGOUNGUlRFLzdSWWtZUkRxRjZuTWtnM01aNDFVd201ZnB0YUE0cmhH?=
 =?utf-8?B?L0hqaWpsTmQ2S3ZjbjQyY2tpM2xHS2xSeW8rOWcya3RyVjZFczJyR3pMRW1Z?=
 =?utf-8?B?UEcyWGJmckxBcjdPcDNHb2owZmplUDhLRFVSaGJnRzExNUd5b3B2U0F6VGJF?=
 =?utf-8?B?YUpjb1B1TWhvYmlJZDFvaU9tVWhBMldFOGlyMHBhdEhneUJoMTY1aThQRzBO?=
 =?utf-8?B?YTNobkJUWVIyUHloelRSZmg0aXRha05hYUtpd3BlWmJjdG9tYS9NejlzYkJO?=
 =?utf-8?B?MmlEL2EyV24xM0UvbjNVZ1ZVYW5ZcUVMSER5NFpRM1I0OWh0cUQyT0pud0VZ?=
 =?utf-8?B?a3hoNHpDVVZGaUVReXYyV29GOEpjbHN0R3RhSUd4WjE5dHg3clk5K2IwM281?=
 =?utf-8?B?aDVUa2RHTzZPZ25mQ0xsT0xpMmZ5Uk9ISVVBYXlWMlBxVE0xSVdmYWtHeE9I?=
 =?utf-8?B?UU5OWktzT1lKaThLV09qMGNld0hERXZyVXpGQWFrMEttYzQvOWJTY0hFTmRC?=
 =?utf-8?B?Mm1UeHd4bitBN09SN1JuZ1NGT0NFMTZGSWZjWDEvd0d6bkR3a25OTERQS24v?=
 =?utf-8?B?eHpzb2pmb0QrcDd4VTVZcXlsS01hL0xPeXB3YkhsVisrRDJJN1MrNjJYdUlq?=
 =?utf-8?B?aUVEcFRQNjVUOGxKeFNTUU1WMDY1OGNDZmE1VjVLejczSTQ1Z3M5bFFGY0tV?=
 =?utf-8?B?NGh2aVZKdTc2RkwwbUUyRnQ3bkFYTjFkNXZkaDlZbjBwSUdVbS8wU25TNVBB?=
 =?utf-8?B?WUpzcUMrSFFLTE1OS1p6N0lpd0kyZnlEUytnS1g4ais2QzBBQTZvQnh3alB3?=
 =?utf-8?B?eFk0MWZVZU42QkhGQ1dGeE9nbnN3NFBsM1BqUktLbGR1dGlZVkNUQXpobkpj?=
 =?utf-8?B?NnQwVzAyb1lra21MbXhtUFAyZE8zYzlvTDZHMmllbU5iTUlNUm9EZWVjVzdP?=
 =?utf-8?B?YTErSmNJeEUyQUIvajQrbUI1UHdySnFFVXR4QW9GWG5zcVFNOFNMcFk2ZE5I?=
 =?utf-8?B?eUl6WFRhTm9Yb09xN3FQUW1sNGhYaUhaRjFRa285WWxqUzBlN3Aya3JJYjh3?=
 =?utf-8?B?bEtHenIyS2xUMG8yeVlhMHQ5T1NOZFhXam5taDZXaWNCaEM1d0M0Ky9FU1Bv?=
 =?utf-8?B?bC9IeWdocTBqSmdrem11bXZvQWdBR2ZKcEllRlNwc2w1a0tSeHRVRHJPM3Mw?=
 =?utf-8?B?eWRFalJuTXN5NFNjckkyUDB4Z2Nzc25KM0t0U1Z6RHlWUytyY1N4OVZnSXRs?=
 =?utf-8?B?SjlWWDd5azgwNHA3SWRSOGU3K0lZakYwNDhobFZwUVZnYWlQSjAvWXIzRHdR?=
 =?utf-8?B?bUl4RG9jejhTRmJMeDJ6NDhkdW1MWWJIWk1GZnRsK2hqL3RGT0I1Rjd6Y1Br?=
 =?utf-8?B?TnBzcEozVzZZVmMvRVlnV091blRTOG1nTTYwN1c1aDdnY2I3dEdpcE9Scm1o?=
 =?utf-8?B?ZTZEUkxiOWhZKzcyL0N2YkJGL0RDVU41bHdYVEtJOTcwQ1RMbkVQa093TW05?=
 =?utf-8?B?UmFWdmNWbTFRWEVWL2FaZXEwREEvYWlJWTB6T1ViUDZKcllHTE04MFBlbktO?=
 =?utf-8?B?Z0hhVkJLYlZCS283UGFvRFpSV291ekU5MEprNGl4c0hZYUVHMW5tM3ZROE9P?=
 =?utf-8?B?N0pWbDhjcDRVK1VUbG5ITjA0U0FxUHF2M2t6YTJ1bzc1RW05SmFuRElkVmpO?=
 =?utf-8?B?ZVlRckJRTThJKzhpKzRDYUhRaG9SMy9EV2x4Vjg1SXV6OEpvMVZEMDlTZ2pl?=
 =?utf-8?B?akhhTlc0TWJMNnMrekY4T2s0UGpkN2lvbm5IYmdtY1NhNEM3cDNzODkwVXNG?=
 =?utf-8?B?ZHQvVFV0aDViZDBFRDEvZU9PbC9rRlVMWTEwcUd2VHJPaFBCYnpqV2taMnRz?=
 =?utf-8?B?ckY4TnVsd2NHdDdJS2hrWlZTQUdFOXhjOWJxRzhEZ2hldGN2dGJ4R1YxcDM2?=
 =?utf-8?B?TkM1dVdyOWt2c0EvSmYyTkQ2TFE2Z3NwV2kyS3drWUNvYjBYQVJmcld0YkZC?=
 =?utf-8?B?T2VDVUJ6TWJLZGNhOUJHUTUvOGRtRHV5TDVRTzhyRWtJUExFcnZQQWVmUk5E?=
 =?utf-8?B?a2prU29lbUtWUVpDTjV5THFSWFdNdWVnVnQxMWtQM0dZcmRQZlRxdDkydkcv?=
 =?utf-8?B?dDc1RWNZQUp6cUx1b2R2TWNaQnM2WXhnNWtQSkJlYTRhSzNiOHU3VlE5aXdz?=
 =?utf-8?B?emlaYWNXeSs5VWJJS0R2Q2c3UEp1MGhuT1RBOGx0K0hWd3BqQk1OS2lpTEtT?=
 =?utf-8?Q?1G0t2Z+0FrX8gWc0=3D?=
X-Exchange-RoutingPolicyChecked: oEehbS1rbLcQ+uEb/bhQrUplL8LvSy+t2CYAPmV3+qIHSyYUvxoJJjk8L++rTjDicCI9MPCi6seJ8DKWQTdCdTi/osuSLe3boh0FdOxwe3eb+PLRqtzHP17gBsxI8qUOTsBH6hg4+mkDpfNZjPNV1b6p2e1rS811dDdfHKVRdF1TvmDYSr/50r8PobuqEf+6UVzN8fKSqyuAG9yREKMW+FuKk9kFSrENyljaKgSDY8fKuRGcySUNtuGwlTQv8Tijb4IR9dQoKI318zNZnpB5XS8gKSioV2s9ikY/FuEOFfgNQcf1YvdiNXCZnd8JX1PTCLLzGaaB9bcoGl2LgFwCrg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 30242eb0-2089-4556-0124-08df1aed4d8e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 10:11:02.3187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsX3+7/YKtaj5hu9oHPETbaq620ZqOK7qw0Dd6ZWxS5itix9umIekONYh6UwhO24sdHmQ5C7o0X9PewRqcCJ6tooiPcBKwpqJTW4n15veDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB610523
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

On 9/23/2026 3:51 PM, Bruce Richardson wrote:
> Replace the standard (non-offloading) AVX2 Tx function with the one from
> the intel/common folder. Both old and new code paths have identical
> behaviour.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
