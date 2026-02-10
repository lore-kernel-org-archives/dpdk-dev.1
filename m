Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B326DEA810F
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:14:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12F8240652;
	Tue, 10 Feb 2026 14:14:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 0B813400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 14:14:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770729286; x=1802265286;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=T0isTek2SU2IRcezFi5nC26uNso0cKcd3XYOj3lyCwc=;
 b=DWYtBxAh0+Z/Q0i6NEFdqOW0cFpS+NxevJ3fnXzKcYYCvMrdeFEDzehy
 Ik7uYJDnAG6FR4m+W2hc6g4TARtsnFI4fUlcpMMj2islk7r7zIDTFlgXk
 8QSYjGzG7uEt8R51uaPle8aD0M0hWB2rPy2rRQ4NXnjoPSdFtQdKzUJBs
 6bkI18LcZaCR12cypAJuuuHieK+o1NRRfQyX01/VcQoATPGIzuDWu5qhU
 LchXIqTa92yO2myWcvrxertP4KVz2CrRjl6oSnXUaSlD4HgVDTmsX4niB
 5eTRVw624UymSsBkzHv+wxLuC1Y4jT+2DYVxHLKt16kLWx1UpgLpeJsMt Q==;
X-CSE-ConnectionGUID: lVJsoI6OR3im2Sjbb5aqEg==
X-CSE-MsgGUID: sBx21UONSGaesstLbxmkeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="82586268"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="82586268"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:14:45 -0800
X-CSE-ConnectionGUID: c9FuupQCSrWSsfumCSO/0w==
X-CSE-MsgGUID: SxxjwSn7S4OOJztTAl4CaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211566303"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:14:45 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:14:44 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 05:14:44 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:14:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1ZkvmCDDldpMXbYemo6zanrCtwO0NVMRoYboX9znTWfDi9VLqmSIyKR6YEArW4JunBlb5oo7Heeml+9YshiIB7BAg97rgWJIqYALppcec+VfHAUx7LhMpimOY2TFTv3ULDh4tCFXyJDj6ISqhqQp+USJijByeUeDs++gb9flp87Lg032/7jc4KAzN2UVLMp5yRQHzxN++kdJXF6caq154sMEPtBgLPgjBeVukxPOnpXVI4re++uwim5Vr1r8g9zFg3YEXMSznsDb65MPvlgSvEjrWpt42q1Au4eX3SDPBETkKCUmc8ZptJ9/gQ1rQKZeW3A5pTwTO1ahE9MjGX7rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xs01MPAZpqswFO7xTEetdHyaBTE9De9GCEWX1mcv9Ew=;
 b=eAAu0gY1V0YSG+XJ3lTqI25b4hc4MyqG1yWl1uICAvG1k9v/69vBcfrDlwA+lmsHOTo+BGbKuNpqiY1h8LP/5vEpPo0TFBo8aflBDlCXRiaGCMAPbR5zNgbwEFg/4inCq33SxPFdQDhl9AHc9A6pxlcvYPxqvHlIC+yplkAsS+8ASepJVH/XUYkOtbek13XUv8tWOiXoi4au8Ju2Hz6ygiKxE/unGvsobL+f8UtUYky/a5Lw+POGQNY0Ot1zji0VTYNltelZGYw7/gv4M8QdxwFtel+XuS3xNt15fAF7/qahHj7p5hwjKsZFVgEF699UCl0clpIQ+gGZHeYlXajYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MN0PR11MB6279.namprd11.prod.outlook.com (2603:10b6:208:3c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 13:14:41 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 13:14:41 +0000
Message-ID: <bbee8f0a-381b-421b-9601-4a9220048b88@intel.com>
Date: Tue, 10 Feb 2026 14:14:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/35] net/i40e: use common scalar Tx function
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-13-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-13-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0030.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::40) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MN0PR11MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 6715fffb-d867-4665-715a-08de68a659f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXJjRVhQL1BJVzVIMkl1TUgxd2Uwd0VEL3IvU09mTnRWaHhleTBFY3hzUW56?=
 =?utf-8?B?c1pscmlPc09NOGlsZE9zcmM2Ukp5NGRMQk5wdjNxczVENSt2bkk2WnhaMFBS?=
 =?utf-8?B?WkFZeTBSNUdMZTdNMEREcFJveEtUOElWSG1DLzdROTlEaFdTcHdoTC9pTmM2?=
 =?utf-8?B?aDNtNHk1aGp1UDkzSW9JUklGSDhiQUIxSldVNmQ2UEozZW5TMGhtWXQyQzh4?=
 =?utf-8?B?MXZXY080V0dseEJKVjEyUk5Iam1ZWmVwR1IvNy93c3U0dTF4Q05KK0RBUzZM?=
 =?utf-8?B?NDlrVHhFNEhCR3VjZGQ3WjJUMDdhUUNVelFabFlTTUhRMWd4Y1ZhQldJb0Ur?=
 =?utf-8?B?YndEWWQ5WVdFYjZTN2dIR2dxWDZCSUQ0OEpOaDJiMFVNU2JhbE1CT2M2Uk85?=
 =?utf-8?B?cXFXSVdaUE1WTVlvcTdBenJuZjVhT3hPWkJPb3ZaSjhEeUNIcFpYL3dDNDln?=
 =?utf-8?B?cE5kQnNQZ3Q2bHA1ZjBobU81Q1JTZ1NGcHg0d3hBMW02aTlDTGxYMXZicnpV?=
 =?utf-8?B?cnEwWjBuYXVUekxxcS9td29nQ21oNmFuQ1hTM2Z3b1N6NCtvM21nNEdsbDhj?=
 =?utf-8?B?Z0kzMnkwUU5BTVZwT0V3Rlh6dk80dVQxU1UrRGZsTFE3Qlc3ajJibm5iMnpx?=
 =?utf-8?B?OWZjdTdoR0FkNXRhTnpjRllJUG9vR2xSUWkrQlNXTVJLZWwxQnhXbm1iZC9j?=
 =?utf-8?B?cWE2b3Rucjc3TWRmOFFueUxoS0phc2VkcXpDbnlCTG9TK05NOHQzbHBLMm53?=
 =?utf-8?B?Wm15bmczd201bG5LZUk2TFRXNi9COTFNb0xpYVNHaHROUWpGTmZJT21JZWVE?=
 =?utf-8?B?RDN4Qml5TDR6VVFUNXVWVmNSeGNSN3BYUFVNUks5dTZtTU9GRjRwTm9jekFt?=
 =?utf-8?B?YTQzeG9QMlRmVWZFSDROWVVZYmhES2VDNk9sRWNlQnRzM2UzTitYU2FnVUc5?=
 =?utf-8?B?V0JHM05zaG1vNDdIZDJWRWZ6TGcvUTBQcUpnVnVIc1RIZG5mWE5TTHNDWVpI?=
 =?utf-8?B?T1BCNkZFbk5hc05NbVNDcTk1Zmx1ZGtreGsxRDBkTWhHcDZjVEpCc3hReXRM?=
 =?utf-8?B?VkJkaDlEZkxNajVoVkl4KzdLQkxPQzg2a0JGemhUd3M3SE12U1BGQ3RiSDNy?=
 =?utf-8?B?VWJnWFhHVFlwU2Z0MHZPa1VLaHBvQWtOOHdTTFdUT2pwR1lRakV4R3ROVER4?=
 =?utf-8?B?bDBjT3hLbDBZMG1DUURKZmdMUm4rYXQ2Y1ZWcmNlR3J6elliL1dwQ2ZmdFJn?=
 =?utf-8?B?WEFtSExDT1IzSUJLMWlETHVUNE5Cb0NPZFVsZkFlb0diTFV3NnJueDFBcTc1?=
 =?utf-8?B?RERwOEV2eTUzSlhSR010eXhsQ3AwbG5Mdkc4czRaaEhHRGFOQWFoZkl3UTdR?=
 =?utf-8?B?a2h4RzNXcjhJYVNFK01aR1Q1bUxUc2FKSDZqTkpoeVRFam1uWVZObTlrS1Jt?=
 =?utf-8?B?eUJoWm1vUzJUY05SakhRSkR5QjVyaHU5clA2SnVPU2pQdzBUSWNwa3VPVGE0?=
 =?utf-8?B?VHFzbE5sNWNNbnJDMU9Ka3JjNFFZYVozazNFRW5pVHJjamFSUElmZEpNTXhm?=
 =?utf-8?B?Q3pRMU1Dc3o5Y0xXbXBTUkJ3d3MwUlpXWGtBQVZ2K3c5RVp0ZzlQU0MxK3lr?=
 =?utf-8?B?eGtSVCtKUnU4aU00Q0x0NkV3RUpMRXZMTVZGSTVPQWFmVi8rUzNRSVJhYWFh?=
 =?utf-8?B?b3Y1b0laZXJCY0VCUU5QRDVVWlZ1UllGcmJDbTVhbFZXT3BiYURoWVpxdTAr?=
 =?utf-8?B?c2czY3dSVVgwekQrNEs2QnFteGs0dW9SNS9abTNGdHpld1RLWGFWbnlWSmVH?=
 =?utf-8?B?MmE3bENlRmdJemMwVzhMZnk3b1loVXIzMFJXaHJwVDFqeXdFbGU3dkhkWjNV?=
 =?utf-8?B?ZGwrSm5lTXBZU1hycGFpQkdUY3NkMEFuL3R3UlZ6TVM5VEF3QU5ERDJseVVh?=
 =?utf-8?B?eFQ1MXBrV3J2WGpwWFBrM3JFTkFsdTRqd1E2bG5iUTFpdGQyK3JwTlo4cVBu?=
 =?utf-8?B?anU0dnRmS05TTGpWbUk4SHhTS2dFL2hQcmVVWTZXU1JrUDhFbk9HR0ZRTEZm?=
 =?utf-8?B?bjNCMEVtYnI3YkxpV3lTUkRZYzRaTGJHWEtMZG11WXAyWTNrQ2NZSFRJY3pi?=
 =?utf-8?Q?0YhE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3cySmVyamQ5UkpaY1hlNXAzTEpvT1JVcFFxQUhuUld3U2xPVUxqSVVLL05w?=
 =?utf-8?B?Y3RRa2FsaG1XTTZML3BEZEZ2Q2pacGpQMmpyYzBMRGUzekpCc3lFelNFb0dr?=
 =?utf-8?B?TVhGL0V5a2NtWnZsOUNGUGR3ekhqQkZGb2dEYXU2NGJic1pJUVZlNExuUE8y?=
 =?utf-8?B?K0htMG5YT1NudVB5TzlvcklBU0FIaFlhclZHV0J5Z25YWXJIb3dtSmNFbDJW?=
 =?utf-8?B?ek5rWDVoUHJoOXN3Y1dlZVB6TlBxOWgvdDFrODdrb3BNMXRRdFZySUFXUTho?=
 =?utf-8?B?T2pKekQyZElKR3ZSZll5NkxGSzQ3anhGd1hYUk1qcWRyOEt0MDQ0RXkvSnJr?=
 =?utf-8?B?TTEwVi82b25jZnYzYzQzZWVudTNmR01yVmlNYTE0TE1OenRQYnp2Y3Vzbi9V?=
 =?utf-8?B?S0YyNjdOT3p0YklFcGFZQlF5RWFXaFZVbEJXLzdJb3JMZEZnUWs2dlRtMjFy?=
 =?utf-8?B?cjgvK3VzZzFqTU1VNXFERTZPS0dyTmdaQXRCdC9vV0JKMnJvU2UyemUwMjVO?=
 =?utf-8?B?ZG9ZUFVTZGtZUEFMZWw1YkFnMDgyNmZkNGlvTFNQUEJhMTZYREdDa1A3NXJa?=
 =?utf-8?B?NWVRdkRXaE4xcm95VlBNaWY3eVQzS1RKdko0WTN0RjJYVHF6dHRFbWt1ZHdv?=
 =?utf-8?B?ZFNYbk1NUDJnbUgvOHhRMkQxSVMvRE9lT01OQkRKeTFiSTRHZmRhalVaOWRy?=
 =?utf-8?B?VU9CV0hTZEFpL0kweHd4Qkd3ZFdEcStQVkxDTEZMNEp2TWxXSm5NaVQ2WW5W?=
 =?utf-8?B?eWdLNnlhaXZPUXFtbHBWU0VQVXJ3VnpKWHEwUFB1OGsxekFZNW0zM0laVFBN?=
 =?utf-8?B?bk5RcFVES1daREt5aFdrMitIU1NQU0JDRjJ4UGgrOFBJVFhUa0t6RVA0OE4z?=
 =?utf-8?B?K0o4MldpcUpMMmp1Ym5JVGhUY0FwOVNmUGlmN3hSWTlvR2xyZUFncHRGQzBK?=
 =?utf-8?B?VGpsSnUwSzlJTHhVVXl0aXFNQUszUDVBbDFtS3dGZS9yMGt3TnEzdHNuRDAy?=
 =?utf-8?B?RTQ0RUJJS1lvcXk4Vnp2WExyNDZZaUR2TG5oNkNjM21ncEhmM253SXltaXk1?=
 =?utf-8?B?YkI3MlY3cUluRElKRHdxK0lnNi9oT2RydVJMY3dKcFRQVFQxd2RXb0s1WFdP?=
 =?utf-8?B?QkhSa2NoeUtiNldEYisrNVZJZjNMYUh3b21VRXF6MG0wQ0U0YUNxZXZRZzBT?=
 =?utf-8?B?MWV1ZHMwQVhsemx5VWU1cDEvRU1ZWlV0TXRpZUxnTm9QVUVHUVpSam5xRjd4?=
 =?utf-8?B?ZzJER05wS0FHeEpxb1pacndveGx3dEZKcjhuY2ptdnNhOHUyYUdNMlF5cEww?=
 =?utf-8?B?eUtwNTVQcGdPUGZvQjBINTlwNk9jRG1OOGlYYUFoZ0F1Z0VRWk5wWGExdDdn?=
 =?utf-8?B?eWxHelFMb3hlMlhuejJKc3IyQ1V1czFndGZYbEt4d3FaMk9XVm9ud2hoaXg2?=
 =?utf-8?B?TVV2bEhjVzJLcUt4K3RHbUQ0ckpYQisrSVN6WGJQMUppRXNJd1U1blFBblJF?=
 =?utf-8?B?M0syNDdqdjJFTUdiR3dZdEg5TkNia0puRzR1azl4aGtyb2tPMHIwNWZlQWp4?=
 =?utf-8?B?Ulc1UjNsRHpKWGYxZnNEWjdvaS9pV0ZFbVl1YkhvUXR4YmZLZWpkZ05uR2Vl?=
 =?utf-8?B?b3RxRGY1QTVWRmtJYS8zOHV4dmFrRTlIcmlHb2oyZkJzRnk1bkRtU3ZVeHE4?=
 =?utf-8?B?azRtUGlaODFCL2I2VlNTZytSU1Fma21EYm01K21Gd0JsU3cydnRuRzR3bi9H?=
 =?utf-8?B?azVzQzlGeWV4eHdEUUNPdFozeTc4ZzV4RGtkYUJ2U0loQVZvcUFyWXowWWls?=
 =?utf-8?B?dlJzQjh3YTg2YWNpVitNQnB3dXNKMHFpTXJTWjlySTZjc0IrbHRsaE9BWXJx?=
 =?utf-8?B?anhMbnJ6Qm0yellkYmNoM2N2ejV6TzFHdFEyT3djcmFxYVg4QjdpQnpIY0pl?=
 =?utf-8?B?eWR3bEU4blRFeDd3dGRYNGRqMFlVVkFOdkQ1MkgxVU5TSGh6c3hUTXEyYXJT?=
 =?utf-8?B?WjZ3Ylk5TFN1SG5RUzBnYTJkTWRFaW9RNlhzd3dtT3h3c3h6QXJuMnVGaEhN?=
 =?utf-8?B?cTFIUmRRSVV2Rmh6TWZZQ0dGY01ZRTB3ekpsdUJNOTdtQmo4U0hYckpYbUFN?=
 =?utf-8?B?NWpSTjVBQlpEcnE0WmVVWExOMFc1dWhxTXk3U29CRUVodmlpcENtNi9lOVZ2?=
 =?utf-8?B?NmEzSTlFQjRoL0tPcU1iVEtWV3BNcFBibzNUR3lKSGtvMCsvY2hyRzI1alI2?=
 =?utf-8?B?SjF4bFZFa28xSm5BeG1zV2J0MHVtcENNVEFhSmlNWEVGeVUxcnVFczU1TlhL?=
 =?utf-8?B?dTI5eFpDZFU2U0Q1aDdLclNxckt3cmtXcnk4TFMvOVpKUzhQU1VCUVNXS1U5?=
 =?utf-8?Q?H1A+st1jV0tQEXXQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6715fffb-d867-4665-715a-08de68a659f6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:14:41.8836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbCmFzarAWxgKa54k5HZc5X2LqUPb6BG9Emp5D9JMmoeDheSPdUN4p+cdRI8k0D9v7rOv5m+QWM2YkkTHdQJkh3wPZ90qcaLSciSDZHyffI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6279
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

On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> Following earlier rework, the scalar transmit function for i40e can use
> the common function previously moved over from ice driver. This saves
> hundreds of duplicated lines of code.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
