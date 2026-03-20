Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040B31098786
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 14:03:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D5AD40613;
	Fri, 20 Mar 2026 15:03:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id ED053402BE;
 Fri, 20 Mar 2026 15:03:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774015392; x=1805551392;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6i+oHCyMWDYcAumhxJBMK/OMIcuiXlL7QzIk+zsiEyM=;
 b=M/1lgGd7nNhG9IusiaOKkjU2eXskOeJRNAXOPQyvGZRRMnPFhQSqHEjE
 jEEOAhgXV90YKRU36bs4CoWVhBocHRMrYsIRoNoxdvomYGtvXnfUvHgnx
 iRGauFHcxkPwxnxrlcmOzuS6oPel8yNiRb9cZvm2JJbTgD3tRT5MWgwsD
 rFGakM1+36wF7Nii+0YN87VJZ+AQScPgDhPbz/0kJb3WoZY8Aaje2h3tv
 UFMnftcunotOWhBrOWpCVLNPSS6ceu9pUk3yy/g69KoD+rm61pd6KV3bn
 i+gIIeOb5Yp0feTBmi5cI3TRaYFmsh7v9sFoBBOFj0BFCylaynjg3b2IF g==;
X-CSE-ConnectionGUID: ZXRO74mtR1K1rA6JRuMeZw==
X-CSE-MsgGUID: Zs3rbe2oQzWfx5jiNknOFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74989785"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="74989785"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 07:03:11 -0700
X-CSE-ConnectionGUID: ClSUe2WlTm2vTWhpSktDWg==
X-CSE-MsgGUID: NkrTO0NpQsmKBoSbGjw//g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="227417304"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 07:03:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 07:03:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 07:03:10 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 07:03:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMoYOzzUlekekoWZFUQYfgKnnwl7S6r3BUZ/QMOCtMDgsLDtd/SAyYSblQNWXzAY+ar1rFi3uvOLkYB5Ol3hjhyj7hm9P+jotS7AM8LhQBdDBcHMzGa4f1DrrvF0hkFIb4qDcNlEZ3eGi63kJWEt1xQ22UFdJpGW/HtQvbWNR7BzyInvFRwMYiOBtR8EzNpD6BFOH7r28VNmx81OPbw5OixswRjlMdLmCLlzPH8NcmZoYVPr/ibFu7jmq+upVnk6icnsr629E5KC+OYHydxfNe5jLFJVg2b9076uj9sO/r0Ii1/Vtbq4ja13rRP8qIILCbYuUrs3F3gAZ/8V9e4fIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVyUqLwV9olldM7Wxe6G/MkytIu75e5LGsfaRb6uz+s=;
 b=FyLD19j7ef0AjbaVPHc3Zu9Z1GVWUXwDu1O67n2uMnked0anINFje2Y8/S+R6PDVIoMEgjaI/XBONz1w8Ah9+IRavZdSRfK148mDMkPM+wN0lo8HL5D1IBaDsyrd/5b6npYSvylqsb4dw2r14nXlBNHkul2oq2zdC3Oh+ocx65st8O53NcIt+26xNqM/5oBYUwB8wC57u94306qO6JqohCVNUTkOKquE8zL1NG6LWbKoCH5VQYb/cUPHJTIDPIi5fV24ExrNGb+PY6XQkXEQXzKsvDQ5eh/Y2EHs45bfHWqNokXSyjMdvkhPTG4I5PJZ46Q8kpmSpem7DUFgJtrmvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM4PR11MB8132.namprd11.prod.outlook.com (2603:10b6:8:17e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Fri, 20 Mar 2026 14:03:03 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9723.014; Fri, 20 Mar 2026
 14:03:03 +0000
Message-ID: <82f4f20c-53d4-4ced-918f-2a293c50a921@intel.com>
Date: Fri, 20 Mar 2026 15:02:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] test/eal_flags: skip test on FreeBSD
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <lylavoie@iol.unh.edu>, <probb@iol.unh.edu>, <david.marchand@redhat.com>, 
 <stable@dpdk.org>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260319171334.1151425-3-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260319171334.1151425-3-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0009.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3::7) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM4PR11MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: b932af7c-658e-42c1-36bb-08de868966f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: UPA9NyKDUVFrv10JzjWjbbLTs0F3tnou3M14mDyWRlEVeypQVT7jyIl3bLJJyrQy2giXM3u9yhy8iRcBAxpDdwVrcvqvAnhhpdCdsX+rvS9JVFB7omH0pLbHE8+qTttxDv0jwhqlqPMxFJN5otlBa1ccR13FaDKQqw/C0oyJmh9qayeJ8RNsE+Lf6ldUd4aOzAoVk7O54tQJt5ok3kE76LbRRxdiipouMQj7ky36yGBZpJ+Xf16PyCX4t581pAXv1C/TUg6Sh5zQ7/CRSsnOrwaxWpx2kIe1LjMN0UZlFX4dvCCkj2eTKWSaAMkmGyuVv3Sc53SdrQIBbIAlcaQ13xkzkeljONPQAR5W7WeDmOCH4WjjllbAexdBMZklkTcI6AWfWEOrn8SCh1VwmHFJ1uwZ5QwXpdP3hDG/u9pwj7+JvPfPEh0C1SaTcuGepy6UNaCNieM+2ufgPBorgZw2VP2rOTciF3O7F/yA4RhXo1vbFM3gB1dxXI7zyiiPxwjJIiOoAc4g/9mS8vINMq6zJ5eFmqvx9YJN5SX7luH7SP2EUOuwunH/vzp0LSOJYT4oIRkUZAY9h1E4QDvfhOKNoBsKdn8p6i/Jk6f1hx5dYD9ft6dhKI9PP3mtcQ8dP0UlV/VPS0M29rqnD5/UTtXK1/6clgiSQMMaIB6Qss90HmvPS4/hfAHj8Z4cm79XuWPYYUeYrh9UO/HmpoNKHpfw6FXUUCCiw35vcokQt+bKkPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bml2andjMWJwTHJNOXNwSHB3Y0pCeFhudElUUzFLelFQMkFzcEFlaGNHMFJF?=
 =?utf-8?B?R0NGaXcwMGExOUhmd3RWbVhHd1Q3bHdIWWd6cEpUc0VMUkxhVDFzTUVzRGd4?=
 =?utf-8?B?YlI2bFBCTC8yamxmcTRCVmxmemNvSGNrS08wY1o2TVdyWmQ1c1RURXl6dVlT?=
 =?utf-8?B?aDduQWxjSStHWk94dmhEeVQxa2kzeWE0TFJQNFdOc3kwT25MN1ZvVm1COG1u?=
 =?utf-8?B?WWxqMDQ4SU8vOUh6S0U5ejBxNE5tMXAwYTBWV1ZtakFVSnphUzgrVFgvcTVq?=
 =?utf-8?B?WHF4RXJmb3ZrVS8rYXJab1hXZnM1TUNQQnA0WE1wTnRmdzRkSS9WS2VHMGV6?=
 =?utf-8?B?VmtoMDNWRjkxeUduUWEwMzRHYzk1cWtIV0ZRWEZNaTJaanRkUGJpQ0ZXS3JH?=
 =?utf-8?B?UmEvdWhRekUvbERWbTdneVJRTlRPQ09MNW90WUdDdU1mdVg0cW5BenFweWpu?=
 =?utf-8?B?d3VoUSsvUE5HNHkzSGpYcjNVQmd6RVdINldEUFE5Y2FYb0N5eDRSdVkrbGhF?=
 =?utf-8?B?OTRycDl1RWlsTXF6N2NzUGtxd3VLNCt1Smh4NnN4cmgzWHdNdVQ2aXRIbnR4?=
 =?utf-8?B?bWs0YXNxYTNFOHczOW5iRU5GREJkTUZBcUVpbkUzdEc2QzZ3NWFiVlBTRDVh?=
 =?utf-8?B?L2R5RG1oNVNrdXYyVFhBMzZOcm5xbkJnSEQ3eVE2QVhqQkVLVnBpVGh3N2hq?=
 =?utf-8?B?c3dieUF2SnQzeFA3NlVhb2VsazJja0xKelZSY2FFU0ZVNUxIYUVadG14S2tn?=
 =?utf-8?B?a05ueWRoTm9rOWlIaVdsNVhWc2hwejllZUtEQlJ5Nk5sR2huNFhUc3huckZ6?=
 =?utf-8?B?RzNmL1lZdHFtYnBrbkZMS3BsaDZzZjZpTFg4ZnpGK1hrYkpQOWc3eWZhMnJK?=
 =?utf-8?B?M2lBVCtYTVpUWmc1bEh0UWo5bHNaQnBRMU00T0pUeVFGaVl5V285WFczRXlW?=
 =?utf-8?B?bG1jR2pkbm5tRGdsbmF0KzVSMDB2L3AwUVQ4V1hXblBJczdqK0xHYkhzVk10?=
 =?utf-8?B?VEdMYURsK0IwUHQ5TmdURmNRcGVWVnpoNWtkSnJqSTRGT1dzeFE4WUpPcFVm?=
 =?utf-8?B?RXAyT1hkNkpyeFFaOFg2dTR1VXMySkwybDhycFIzazZoWGdGWW9uS3pRNVUz?=
 =?utf-8?B?ZGJxYXlZUC9mNVRBSHR3ZDJHeXhnTUp6ZHF0dUJua09yYjZDVWh5cXlhZW5l?=
 =?utf-8?B?bnpOU1FkVjhaVmVHNGsramdrVzNHL1hUV3JFYjg4SVhMKzZtdE1nQ0g2RUR1?=
 =?utf-8?B?SWtaREJQcDVXWFhGTWgwTHc4NFJBRDIwL3Bodng2ZHBIckFKL2crSUNTSmVQ?=
 =?utf-8?B?enRzOVZ0TUlZYWdub2UzL2FHc05wZGVnNm1TdTBxVzZTelBFZXIzS21qMita?=
 =?utf-8?B?dVB1eG1GVHpveEdkbFlqMEhqUnU3dnFKRU8vRlFpT2Y2L1A1MlIzLzc0U1dX?=
 =?utf-8?B?SDNXd1I4Q21UWTM1d2xwa2hoTDA5Rjk0UzdMc0lUNG1aK2hGQzNvMXhkWE9t?=
 =?utf-8?B?Z0Q1TERGUTBHQWpWemtVZlNNZkIrT2lkZHNRaHF4ZDNGWWF6WTVkQk4rMVJO?=
 =?utf-8?B?bFVQeGQxQk4yQmlEbnFXK1lJNGVCSVk1THZVZmlyVjBFUXRFNlAzRngwN3gy?=
 =?utf-8?B?bVFiVmlhS2VlZ1RyWjh1WWlINW5rOXpzcXlUdGp1OStOd0I2K1dZQVhSUzRZ?=
 =?utf-8?B?TklKQjd4S01qVDRuNDFhTSt6M1F1cDNaTGEweEFKV0Q2a1kvK1ByWlBlcW53?=
 =?utf-8?B?M1gwdU02NXlTYUdDUi9EZFJFRkVvUEhqSVdiem9RVUxYcHFQa2hhY3VOdi80?=
 =?utf-8?B?a01Oa29sTC9EWjQ1V2ZwUncyZ3dLV3JaanU0eVI4SUZaejRGRm10d21KUC9h?=
 =?utf-8?B?cFVTZVBaN3VGRGRCMzlhV2dsR1FZNVQyRS9SV1l4NEtGRm95aFB2eFVpM241?=
 =?utf-8?B?bDFRdGM4R0FpOFg4QjAwOFIxZGNvOXZqbGh6YTV1UG9waDU1QTdsemdmVXdX?=
 =?utf-8?B?cnV5WnMrMjdZeUhGSk10WEduK1pxN2o4OVQ5YjdxMjMxQk80WncwMGZRcWts?=
 =?utf-8?B?OTdIcXVjN0FIU2dyOGNQaHNBays1WXpHSU4yUWRxMDR0dkMySUVjZVlKSWdZ?=
 =?utf-8?B?WjZaTHkzYm81L245Y3NicWR0ZUhzaFBEWGtGZUs3SVNmU28rdFB5ME1BMk52?=
 =?utf-8?B?b2xwMkY1QnVEQmRXbzBLZTJEL0VwMzdWTmRjNWtnUU9PUFN5RGxRNUhoSEpD?=
 =?utf-8?B?RFhpUHluR21vSGlXcFVVa21uRkN6N1BtdXBKS3hSM3p4OHRYMEZrbHk0QnFx?=
 =?utf-8?B?VDh2enM5eTF3T1F0K25RamJhQjhvWW9jMWZjdlpZY3dMRWJNQ2VGZHVIcEdx?=
 =?utf-8?Q?4y1Byj9BJtgJL8uM=3D?=
X-Exchange-RoutingPolicyChecked: m6NoopN6PDHcGJtgvwBMulQc/zyte8MD180L0RHcyK7X+aYpW4K2tM4cquAa42f7sdC2M8SIxuG+54prd91jAeF2A3BqzfardwI2xcr9BZ/pYzWW+qGz+mwU4V9yGBAR1CUn6TfE57j9dy14kQhcQqAtBY5ldyCGZ5uJbRSCvtbPHsKLOwrHp9hj4HwUcQrxipsfLfWG/eOmImsnkZmmYVaItzmc3QeiHQpELCYiDBCwIFPjCNihzTM9Juln5Qm610T5WoHUhC8rSHecUfHkIWaDiYp6oRPLMneLaJp/nHam53XNz2FfB3MMpifFDo5njDYySxJuqCGZM9Lxasje1Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: b932af7c-658e-42c1-36bb-08de868966f9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:03:03.2366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWXOxOypUKLzi5XiczPseZ98nTlgLCudd+hUQCvL0E7vga1tHgUSfL+1RR72Kbrb5euyxvu7I5iSSwgKHLh2L0gHO0mSnQjmDQWhbiyk+aQ=
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
> EAL flags tests depend on running secondary or multiple DPDK instances
> so will not work on FreeBSD. Report these as SKIPPED tests on that
> OS.
> 
> Bugzilla ID: 761 (partial fix)
> Fixes: 764bf26873b9 ("add FreeBSD support")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
