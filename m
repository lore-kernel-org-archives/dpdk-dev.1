Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BA41098787
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 14:03:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C61D340649;
	Fri, 20 Mar 2026 15:03:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id C519C4060A;
 Fri, 20 Mar 2026 15:03:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774015411; x=1805551411;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dcSGbfn0wpddDBL/d5HYZUGC4+UfudslhOocFzRWB1Q=;
 b=RIWepxXBfHYqVH8c0xkjPBCyz3SCZibm75B+cFFc16XPjs6Cit9ireze
 ab+vmlEfD995Aa63DlbjA69cGx++/1qipWmAHyE4Nr1QYGigOaM1O5T23
 MxtXLY3e/IJB1CN6dkvata9ZO3GFtdLo9iY/Ga/71ldWpkcoyeoibzIBS
 KGtAvO+IaO/WBL6QOpgoMF4t3/MD8ZWfDttFxL80NL4F0HyIjzc5JgCRI
 nTzj3bwnOAGR5kiyRO4SW1IxX2rFjlIC90wSlfxB53OL9d1nxKeE+5bfE
 lgXNRTrfWjgPvhbtFVlXF7cCZ6H2f0BzN4NPz0M8/QX65SbJKk9mGO84O w==;
X-CSE-ConnectionGUID: /cxIhSudTAiXl1OhmdEAEA==
X-CSE-MsgGUID: kAGzZGztRFOgOEvUrcglxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74989888"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="74989888"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 07:03:30 -0700
X-CSE-ConnectionGUID: qPqBIf7sRmyrjymfN2lRkw==
X-CSE-MsgGUID: +jpdR10MR2ekISeaIWNBXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="227417438"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 07:03:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 07:03:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 07:03:29 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 07:03:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejXdh/hvcFxfP9GAt2UohIt44YzAtJ5a06vH/BtURz2tu9cMyevyORQuky/uUJO+NoBQda7Yk/xvISweBF7Ihn2tRZNsRRS4sK38LjdC+vyOOgm3LslrEBzKeCI2IXw4IJlJf0C2leApL0HS6i8W8a1aQ6Tl5I4VUc00heLS8o3zFee6DLjKpzNfYAwhe/hFYplmf0q8SZ00+He+Ts5OXQYjigytC6Bl/1wHZ4aV9Ol71Ca0myehy+D7QAMsw/qpd5BBFmNFgMSxdA2KsTAG026qLXfCozZlMXmY/5x7ED8UMejxOOFFp/1I9MlbuUGoLsyJSHXaKDucZmd00v5zjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkord/63CDbeqr9xXXSzNVQJcZnHRzFpjACuZcxacWo=;
 b=OL4CjMMqYrO8TjZXvSeTbt72t79fiUK2O9yCDeOF+GeLjiCKC4pRXzerY0MqfcdK0Mn+Kn+eWVBV0pWYsu55y0o9hujAmE0x5aGMOqJk/59tbNNMABDHqxPWO973Wn7MqE8GRXmgob5/jTRn/IEKms4aW6UnvcSx4l8KWIbg4beDRpUv4qVGycO/9MSED4Pz4qHaPivodpIhozA0CeKbQ1IOD0xmo2DNnPUvKzqXhvdtDwXZ6prvJYTyl2UHnyDW9AEXcbpKYYxQ9/NnR8/cZSKMeLy6LkFfjGTUNGn441L3BdiST7O7v8dthk/rDFJtpm3BLWu6LRkNQNT/fRx9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB7052.namprd11.prod.outlook.com (2603:10b6:510:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 14:03:23 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9723.014; Fri, 20 Mar 2026
 14:03:22 +0000
Message-ID: <1598e311-883c-406a-87f6-16a819bee88b@intel.com>
Date: Fri, 20 Mar 2026 15:03:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] test/timer_secondary: skip test on FreeBSD
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <lylavoie@iol.unh.edu>, <probb@iol.unh.edu>, <david.marchand@redhat.com>, 
 <stable@dpdk.org>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260319171334.1151425-2-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260319171334.1151425-2-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0035.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH7PR11MB7052:EE_
X-MS-Office365-Filtering-Correlation-Id: 9283112c-aac0-4f29-a966-08de86897294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 1qFN3Sh/Xrxatd2WneK6u4T4L/bQl2avB7EgnGZgP0VjPHdRPd3tjDA6RmkHVO6KdUstj7AIwjdpE/hrNhCr6Dh7EE3TmG65xNkYhWhPivp8OqaYts28p/fPi8uh1YhdaPNvVHn5u735vaqVHtrN19X3J840S2dQLzkdp+GyFzR1y+ueAiJf07dL8BVDHWhzdLCS4vz6auLPUGNur7bYzs5c9RzZd+cgdl6HIuiYfn7IZV9zY0GP8ZTxxJHrkMvUtvLC3pnqkBKqXd/LXGSmKpRXYbg6sqi0L0qjTI/zPGzrLS+0myQxBV/Oc+k5mzXDFoHvbIiv1//kNr72BP8LUJ4BBu62wUYX93AlxJXgALxintHjg+Aee11yFdGND6gMm2V9FRFXz9WfDyk4v+LBOBX+l5/gaWyh0EP0C9VwywclLLmWw9ktKWGaTnsX5G1OG69UJXr7qr68yxs8JQNgzEPqZvsdiQKmvDGeKQ0SKFwmVp6D0MipVbvGQOBTmoohHLM2pw4ed4wfokkVpTFqdyssHXOzy9kpTCWZBzF2JCRkXewS243ckihbCzfaKSOIuk+UYbCOxFk/DFk1lXAdVFSYzmZtL4CEouGQ83HZK2a1/LwXyl4cdf1Vpj3VYqw/BKPPJJvOx0b0i8DZ0C1ITUkTRG9C7VMPjk/e9TZAqcuTWWgTYZJ5IUOoDGJEppn+yjaKQu6K4QhlcEGF+isLJgIHLKwTsYCrX4w3u8DG44w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djl0MW5VV1NXRmNpUVpNdERkUEVXaUlzV2dPZThBNDlOOGt6VllRcm9UbW1X?=
 =?utf-8?B?b1R0dEZmaG5rcnFveW1DQTRxbjBzWWs0ZUhPVVRRVm5QZVZybmRyZ0FvWjBj?=
 =?utf-8?B?K2I0SDNUUGdOMnJGb1E1eEVpdENmSUhLZ2F4dVU5aE8yd3JuQzRBb1pkSFFW?=
 =?utf-8?B?VmRmTjFtdHduWE5BWnJoVXlES2xYWE9kcFcralozUG9FSko3SlhCdGpyaXQy?=
 =?utf-8?B?c0d1dkdXdXFHbk9DejY2WFJEMDVlNlY3ZStldEpyU2swVmNNRG9DOWxvWjQ4?=
 =?utf-8?B?NzJKR0FickVRbzRXSmVjV29oM2lTbVBiSlVvMVlJYktvYlBqWi9DODdUSkFs?=
 =?utf-8?B?SHRWeGpHS05EeGVFTk45UzdDb1A2RWxvMlRhWVkrVTFtWjhXWlc3azl0d0RN?=
 =?utf-8?B?NjFQZEp6QUk0eDNOQUNnQ3QxZ1BreFovalVDamxlSW13WWRQeEJReWNBbE1D?=
 =?utf-8?B?enNiL0R4aEkwTFVnZzBhbEl6alNzMW45VklUNGhONldnQ2ZhR0Z5MDBhMUhU?=
 =?utf-8?B?ejljaUNpNHdPOGhTa05QanNBUUF1S0RpZUpCRkJhSUk1bDZ0L25oRDVmUmk1?=
 =?utf-8?B?OWFDRU5sY3VFbG9zRFdhekdrUlpjTkhuZk1FdjlDOXJlNmhvNWNuT2toMkN5?=
 =?utf-8?B?bGh2MXNLUjlJNDYxOVdiUU8ydWlIZlJHRzMrNDNWc21NSDg5MTZ2ejViK0M2?=
 =?utf-8?B?anFQMWxnMVdCdC9CbG94b0JLQjdpKzFjSng5MG8rU3ZDZzluc3dLeWFUM3ZB?=
 =?utf-8?B?cGRJYnVoTFhUTjZUSDBtSnl1cUVFUTBSamgyaklCSE5LUExRYUVNSTFXMCtK?=
 =?utf-8?B?aisrbmJUbDdSRzN0UXBYYW1SZ0xXenVuOGYxVXJ3TTRqbWlwdC9lNFRhcDhP?=
 =?utf-8?B?RE1pSlpKZ1Z4bXNPQkU0N09wZUQ4NnVxdTRMVU53SWM5M0I5UXlMdzBwajlv?=
 =?utf-8?B?d1BIalpYUWJJMzkyTWZwNHNtUWhjS1Zvd3g5L0U1c1dsUUtqaXFjRVcwRVFr?=
 =?utf-8?B?K0ZMSXJOanFzS0pBMVpKdmxwVDZ1ZmcxTWhOYUxJN01VaTJHcm1TbXdaWFhK?=
 =?utf-8?B?dmhncjlFSVFyY3pLN1QwMVJUN29DUEpTRXo5MXBoTTZrQldEL2RzRGxvdWVF?=
 =?utf-8?B?VDIvZU5HVWVCMTNHV0pxNVk1bTNkTFRsWnRsUks2R3kzbGVoaTROeFYzdkgz?=
 =?utf-8?B?SnZ6My9pRUpGZjdwY1Fqd29xN3ExWklzbmdBd0VSYXhUdnlOSThPMmMvMmhO?=
 =?utf-8?B?bnpndWVCR3RTSFhpMDI1RFhoS3JZd0F0MkhsL2dtR1RybW91bTR2bTZpa2xW?=
 =?utf-8?B?RjVQQkFRZThaSTFaUElIdFg5SEV6RWkxSlhid1RDMy9RRFMwWHNOVkdkSyta?=
 =?utf-8?B?WUJZSDkvN1dWVU1KK3NvWVprSkZ1bVFQSUw5M2Z3c1V3dFdtVFlmZU1TZ01t?=
 =?utf-8?B?ZEJySThPeVowT253bGV4azAwZTdUZlN4T2JLOWNPM1RVRHpVUFhlaXMvZXl2?=
 =?utf-8?B?cXh4d3pIZDU4T2p4a3pSN2g5MGVuc1c1aUlERm1vL013aUtwWEc2MzIxajh2?=
 =?utf-8?B?VEFjMjlTZjlRdExpelFMaDI3NGhUV0VuTFBEOC85M1dGOXRnMGFNMHFWZS9W?=
 =?utf-8?B?NkR1ME1FUnZVaXFrODJ5bnFuVFpBTGczd0o3bHpHTjZwS0QwanVCU0NJVGN2?=
 =?utf-8?B?dFBRalVIeDZnQzIrc3VrSTFDRkJUS1JsaGFFM1ZSb2hjZmxqMnhsT0dvZXMv?=
 =?utf-8?B?cjhLRWhYQUJBck5hMW95RFZNc1FGdDNDYlE0RTJ3Y1NTWStnL29jYTZIdEVx?=
 =?utf-8?B?aGlIK0RQZnJVS1dDci9SS1UvVHZ0WWl2UkRqdGRKRElXUisrU3VybzJtc2lQ?=
 =?utf-8?B?blFDZjJCTGVVamZXRnhwcW9vRFVGZStQTS9US1QzeHJQbkRmVEZORE4vVmNl?=
 =?utf-8?B?by9YOHMvZUpNajR4Ty9yVmZmRDR0M1UrbG15ZDAzcFE1cE1aWXNGdmRCMDJE?=
 =?utf-8?B?RnZQc0dmRyttRkJKY0FuM2MwWmtzUjd6a2xWamZpekNnc2FNbjg1eGV1VUMz?=
 =?utf-8?B?bzVrYVFNTWZ3MlNIM2orWTVnUXZscTgwaUVCWDNmdC9XMGVIODUwbzlrbWtj?=
 =?utf-8?B?NEh5UjhjZmxzbSt5WTdPdXRtZ1lMU0xXeUZvbzVYTjN2T3pKajBwcW5udy9k?=
 =?utf-8?B?QlQ1dzJtMjZIVER6TnFsUDU4cHRZd0J6T1lDRWdHRTBiZUZRRG1WcGY2NHR5?=
 =?utf-8?B?ekR3bUVaTExqUHQwalo1Ti9leEc5Tjh2YnloeXVpdFIyMWg4aStRZlkvSDA2?=
 =?utf-8?B?aFVhamRlY3JLSWJOZXJtcFRqbk9Hb1Q1NmFGekNMK3NLd21MbXY2SUFzaDUr?=
 =?utf-8?Q?Anbh1zXadbTPpL9M=3D?=
X-Exchange-RoutingPolicyChecked: XhJsywX4uf3oX2d7O7D5j1sPbprq9L8buGE9TcqSnOcI+rE61tZBxNNqoC4TxEXJOhz/SDpW5JNjmGPcoaXhqFHk/MFCXVjl9f29d1XUmSmXRQHqkBbgBSh7GudXvRxPMExti+omsfZo8DJR4IFZ1+8pMfM21Fhgj5RgllckLMPPAnhYE/ZiGHya5XPrNEL+twRASKxDq0xDBfznYdy1+5km26CqvPIRinIJz5B755VHxQngsPQdAr2UIc+nzpGB307fgygcYnpYVf4IRCheIIYIBduaHruYis1M3kGD0ex1fSDgSKLrrp19F4vOXFSXKW6Vd7Gq7toE5zC4PdJOrw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9283112c-aac0-4f29-a966-08de86897294
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:03:22.7624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QLclOdhIfTSkKujVmDdlqgTkEBSa/hfo3CRubPYVpWqKIk7+qzqwLu1XQM4cXg4JECD/DD3VcnXA1K2zmuZTfFSdmK+VErAyV+S7Q+tHbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7052
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
> FreeBSD does not have multiprocess support, so skip the secondary timer
> autotest.
> 
> Bugzilla ID: 761 (partial fix)
> Fixes: 50247fe03fe0 ("test/timer: exercise new APIs in secondary process")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
