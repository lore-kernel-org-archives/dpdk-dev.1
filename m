Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953B8EFCD99
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 11:49:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DFAA40647;
	Mon,  9 Mar 2026 12:49:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 9B4C640261;
 Mon,  9 Mar 2026 12:49:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773056949; x=1804592949;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=K4Y0K5VplDlnu1Mbb0fZ7zBnwaPHjmun9ugjs7Z4X9w=;
 b=dNhcx8WwuRoA0rg6XefeoLiKBYWTRS8BTqS2hKIKy5m/IlPlpb1wZ2Wv
 abattMCtMpjnwXYZXSV4Me4+RPZgUPzFsI20OB/m80QSdBDvb6kFR7CmL
 HT+GD0xqz8CeQs9Qc8k93cs1Np0m/eC7+hbx/nU+wmUsfYnYn9zp26Ipu
 y1Fk9yCxO1Vfd3VbmB9dGA0wfEKnWCNSpcFkIP7W+PGPRwMcSDP9PusXj
 eJf1Rr4+joIhVsxIC0GGt/tlBv+j2zrChP6QCat5h0KLILYV4tW4L80Yw
 TekJ255Xti42YX+c2hPlioiUNPG9FtG/f84HHXCrRXvLxRv7SIz3p/SGC g==;
X-CSE-ConnectionGUID: 0PwmkhBFQFqhf5NRuJ6fZA==
X-CSE-MsgGUID: cRpLdWrERveDUaV4m5GwgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="77678525"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="77678525"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 04:49:08 -0700
X-CSE-ConnectionGUID: 5NkMBVkfTVutfXuPhZBmWw==
X-CSE-MsgGUID: zjwkKuLrTAmpvLSKMAy/Uw==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 04:49:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 04:49:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 04:49:06 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.64)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 04:49:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoTQ+R2VO8LxefaPsfkg3dc+CtL267MzLx58aHj4+E9xSbc0t8yq/88BDTOmkoN9wTXPjm5FwVSIHx/R4uISxYPxGZcOQyiT4c/OPzF6P5bfnM8/ppNS5IG3ViZVLLNByAXDOiR4I75Vakl4Cdt8gAHWI/vgn/YIaov3F9ChzakRd0y38j+XY2u4GrPrPrtwUpcTSITAz8OdNyeDgW4T9qo2Tisx7oaLoi8fsNUO7xyygmozvztBltiSBobK0z3rT3Zcihw3c8vAp2Cx7u4gmrTiBgs3uY3326wmHRhR7cxhDU457pUxW+CbpB/1Bwf5//mFjdyxC7GUmXjXn/uwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdWokZ5ZDIQLmMVznCfu3mRg55vxpFsPNFlsLiyQvgQ=;
 b=s+h+WA/wRR7e2133rkEZ9fzee8zGxXwbxKEcc37hpKVMVtQ8qWvhd/Eq68YAw8Sp3A0m2PGX27b6TJutoGtlqNFgZoYMSxBEt5V0PTmOyiSNYF/Q8ZtJDfGeVtL/S5SdHdmUjQW4BXji+aOsi/Dve33Sk9wnsLm3kdPctt94W/cMlnR7rx1lV1tlRuGw/B2HL/PTEJOZIOv0BjclZyXBUcQBxuzfApJNuO2FhSJGRDyILMRlYTgy/dQ8Ir9R1t4MJE3z/Woq8IgfEpuKYZQul3NT010WwpV6x1t2E+msglImhCLQEcN1Br++Kn9k5g5ECZFSeDnYwhssf31vLP/s0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 LV3PR11MB8674.namprd11.prod.outlook.com (2603:10b6:408:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 11:49:04 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 11:49:04 +0000
Message-ID: <c6739905-2f99-46a1-81b5-d97464cb01e8@intel.com>
Date: Mon, 9 Mar 2026 12:48:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ice: fix rss simple_xor hash function
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "alex.chapman@arm.com"
 <alex.chapman@arm.com>, "stable@dpdk.org" <stable@dpdk.org>
References: <20260309023255.308526-1-anurag.mandal@intel.com>
 <eb020e6c-8298-4041-9b16-fa12948dcf62@intel.com>
 <CY5PR11MB61167F0FA868B64B355F1670E479A@CY5PR11MB6116.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <CY5PR11MB61167F0FA868B64B355F1670E479A@CY5PR11MB6116.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0016.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::24) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|LV3PR11MB8674:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c411613-367a-4c92-e1b4-08de7dd1dd01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7142099003|7053199007; 
X-Microsoft-Antispam-Message-Info: iIMoCjN6/JvlYe2Ua8EOdrxgRFdmeJR4RJ26gCCm05HdEfYSphm3dPvnthMwjzQc7+rOBDM8BDhKjX3m+Ky4eS5LgU70yccrPvjRJ5JhksvRwZLeUtP3mC4LJjDZl6NiL8I6X5IIuORkqgGOvspfKnf2upA0ZG3rFOCh20AjU5F64QcrGXUYMqEJHQF7qV1bOSQEbfvNNf/TT5tfWW8wbV5LKJ3J5Jp+pBMGs6Z/vm7qxjEv9YDQ2vyFiDqjyzY1+V2qCFu1xIE8nu2GV8x4hX1GrkmbB+wMXYlP5vWQavtZy0yI36F/PMOfvWBfY+ayg4sc+5GMwvH61pGNCcyZ0bSXm189RmP4NZV17ufCyRc56d6QQNNLo3X8fhyYPPIckpVHU+LzIA1Cmquo9HRV1eJB/dvWSrfYUsBdk1Q+MamUfiYu6xLPsk0V4bQujupI0nfvp11hISrKXAmHLr2o06MB4R3uHxcS6oVkYMgRNrw+tmY61ZR8T2+3skvBP6LsvmU2JCbjxHqKkb4jRIauB++yT5TMm6pWxi3lX2Pg1MJnsF0bKA4HbUlhMGG01FovY3INHJgyU83Q+BQyaekCZaBq0nvFIcAJBLFayVuFQlY5fjNBLQUR8pxH+ShBhJPXg8LrUtHXl5NEZKv2STmFn9woSP0ecX9b3bdOuYEAdfeGD1sn41qY+qPQ1uVC1c+2dh5bFQLZqQCE7x5Ov0zUdSfIb97APxlKBg6Mnbxhyfo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7142099003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2xYK1pDbFhaV0FrejZYU0lndFFLRnZBSVNGTVhBRm4vOWJyVUNQNUkxYit2?=
 =?utf-8?B?cHZod1VpSWQySzUyTjdBWk5aQk90YXA4Q3RrSVRYUi81UEw5MUorUFZnc3o5?=
 =?utf-8?B?YzZvNlBsRWh5WUlhZ2N0SmhOVy9iZkt2bnRZdGdHVmVURjJnRll5bWNEUXlJ?=
 =?utf-8?B?dktXcytiN0lSQ3h5RUxZbklDbmZmdHV1NUk5Z2hpSzNWVlNOdGg2NHpUTjhI?=
 =?utf-8?B?YXBLVWl1bGhia3BjTmZKRCtNbmdMRis1SElVbGJlQ3pHSmo1THlLMUZ0czly?=
 =?utf-8?B?a3FpU3h2Q0kxdWpmcDBaSUQ2NGhEaGQ5MVRzbmRVZUxiNEdHNHpEV1EwRXdY?=
 =?utf-8?B?a1d3cmQvdDUyU1B4VG8ydmJGNTZJMmJoNC9PSmxyRndodUpaT2grNTlSQ2Jt?=
 =?utf-8?B?QldRRXliR1BxOTcvcmtKT3FjcW95bSszQ1pVSTAxSTAyN2ZTVVhIa1B0SGtp?=
 =?utf-8?B?cVZDZmZxZWd2dVRidFRFTlI3UVR1SGdCQ1JWb0N3WUZTK05GdGdRZWQrMXB3?=
 =?utf-8?B?U2E4MXFwM25aNzMxMlVObkZ5bFIzR25iWFViV09zNnF6azA2N0M0Rm5tU242?=
 =?utf-8?B?cXRwSEs0WUYzWFAzamh4WkFPT3Nmenh5Y0NpVkVxemhGcUpVaVRYSCtzT216?=
 =?utf-8?B?OHlwdnh1SkhrWFdOUlRtVDdZSC9hcHdFTU9sNFpMZk43NmdaeS9VNkRqNi82?=
 =?utf-8?B?aWVFV2YvQUswUVo5RXhTWnVvSldtdGVtNUtNU05odktoZUpUdFpiRHJmVlFs?=
 =?utf-8?B?Y0dCUnZnaG54Q0pKR0lLMkZxZDlRd0doN2huY2FabGswbzY0aUlFdmd5V3Ur?=
 =?utf-8?B?UlVJdlNCbzlrNEFNUTU5NnQrWEpxLzZ4UGw2U3YyalUvY3V0SHhUaE5ObkFK?=
 =?utf-8?B?MGIwNEUxU2RNWmMyUys5TThZL0djZXB0U0lUS0VHQk1aREp3R0Fwb2t4dXNQ?=
 =?utf-8?B?N1hkVThsTytKaVhoVXJQTEtyekpOSVNvS202ZElvOC83eGo1Ym5LODArSFg2?=
 =?utf-8?B?Y1JCZ1h2bHRKaGtVazBqaTBnVXV3dWRaZkhvWkozM3hWYlo2c1ZaWjk2bDhs?=
 =?utf-8?B?VXNlUnJCUEppVjFkY1FkemlpNGE3L29LOTZUdHJPOG9kTjl5NmQySEpZVUNW?=
 =?utf-8?B?V205WHV1dk8yazllVG96S0ZZTXRvckZtSVROM09hN0xRandEc0dNcmlycGNL?=
 =?utf-8?B?czFLNVlHZUJURUw4WmJoQ2NuR2h3L0dlUmtPZk1aQTdoM3FLcmRudGU1VHdB?=
 =?utf-8?B?c1crWEhpWlJ1YXBEV3RKYkNuQkNuNldqSW83N2tJSWZMdzE2S0YvUnlobnp1?=
 =?utf-8?B?anBxQlBlZ0pPREpyY0VwMk1zSWJnODd6ejRxU1BLS3NKM0M4cVRrQXIwd3R1?=
 =?utf-8?B?MFpaMGsxRjBWcVd4emZMV1ZQUmZaWkwxaUxrOVV5NmlMMVZEVG1Kd2ZIMzFE?=
 =?utf-8?B?UGRFSno3NlYwOUJFdmYzeE45REVCdC93TldzSmFmOFcrdGJCQ0FiclRQZGIr?=
 =?utf-8?B?SEdsaSt3bkZuMGtsNjFNMHJ2dm5wUmwrMGIyczNhYnJUM21Yd3A3VFU4cFpu?=
 =?utf-8?B?UEVjREJkQjZYWXNNbXVsWXVoSkFCNjdRY3F6VXM2MXYzdDl5QktjYVFCMitF?=
 =?utf-8?B?UzRCZHpZZHpzRWNSbGNqcSs0eDZ1K2V4TVQzNmt3dWZGYkxFUmQzb096RUNu?=
 =?utf-8?B?bXc4ZVVhZWRVT29pK043bkZWZmF6SENQM2ZZWjhyNHpIajdHTVNKbjZoRW9D?=
 =?utf-8?B?d3pDL3ZFcVNZc3d6a2RLRE1YcmdkRGhUdWJVT1Y4Ukc2dmtPaDJ5azRrVXRo?=
 =?utf-8?B?QnJtaWcraW9PS04xVXdLOGFVM0tCYmluSzBNeERXUENWa0x5bE1Vemt6UVdM?=
 =?utf-8?B?cWl1Y2xTTE56LzRtK3R6bHVRL1hHbzBxaVVUdDJLL2VGUkZGU2IvRU5LSGlD?=
 =?utf-8?B?V3B6NkxXdGFkd3lNWEZWQ1JTbjRVak5tRkxMdUtVVjdpSFZRUEpOaFFFNXRu?=
 =?utf-8?B?QUo2ZFZRRTMwZlRYZlBCV2J0T3FZMVV4eXBpcjJyQVRhazlLbUFDbXExRm9T?=
 =?utf-8?B?K1U1L0dpUGJhVWJBUjVldDFGK1p0aTJoTGpWK0tLVHRLVFltMmdTYkVtYW03?=
 =?utf-8?B?emhjT0tFTUthcksxTE9pT05PT3VUZVJNbUE1Z0Q2dmR1R3I1RWxMUGNpN21n?=
 =?utf-8?B?bUlTQVFRRUNuMzBZT293T01iaWtqUVdBZ1VaaG9xYVhNT2hnYTdsUzZvRUZk?=
 =?utf-8?B?SHdFOUcxVW90K0h6T3pBak5xbTJqdzU5WnpGc3N3dmZhZm1mR2FrazNrNjJ2?=
 =?utf-8?B?Mk1iWk1LbWF2L0JKWG13VWg5Rzg4V2xpb2dXdHFlbHlMamM2MU16cGNCNzdP?=
 =?utf-8?Q?V4Mu88fn8+9nPk+Q=3D?=
X-Exchange-RoutingPolicyChecked: Z7GbQ+VLLIlFmz310N9Rm3BsUflXCvc9K6Ie1eRUKlpdfmrJkzpc4NYYDZEvsvbGPYxDjiukpBkaQp81dFtk/9NuMhLGaDLQqRQ1E+3hYdL/0Z7yB77giZR3sOflhQ464Z0SbXD0cseQ+NE7VKt9tNvetbtWaVpFIkPWZ6GXxcqntEsn1d5gITGcRNiI0FZaRWHmCKWlu0g+N88n7IXCYfbYM6E1YYT1i4nqKRcZWTc+agXsCVSxFhunhUqkkkwtf8p9kk98K+UIqTyi3Eaw5sUTnB26cdGJzrREEkRppHHcdIsS202S5yR2Me5kSMgD8mjXEBsdplTlJQ9xRPyhWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c411613-367a-4c92-e1b4-08de7dd1dd01
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 11:49:04.4733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bB1yrzSL6Tq/LtmtTAVlOGGYrbLPhZAQD7u7e1Al/asWAUJpfkW+oX5RCabObutMPBehQSw4fJ6SbxzUw2RZPybYvEttfr7vAk56wVSIqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8674
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

On 3/9/2026 12:17 PM, Mandal, Anurag wrote:
> 
>> -----Original Message-----
>> From: Burakov, Anatoly <anatoly.burakov@intel.com>
>> Sent: 09 March 2026 15:49
>> To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org
>> Cc: Richardson, Bruce <bruce.richardson@intel.com>;
>> alex.chapman@arm.com; stable@dpdk.org
>> Subject: Re: [PATCH] net/ice: fix rss simple_xor hash function
>>
>> On 3/9/2026 3:32 AM, Anurag Mandal wrote:
>>> RSS Simple XOR hash function is supported by the NIC as per datasheet
>>> & also in ICE Linux Ethernet kernel driver but the same is not enabled
>>> in ICE PMD even though code support is already present.
>>>
>>> This patch fixes the issue by removing the simple_xor check & adding
>>> proper error log for empty argument.
>>>
>>> Bugzilla ID: 1518
>>> Fixes: 0b952714e9c1 ("net/ice: refactor PF hash flow")
>>> Cc: stable@dpdk.org
>>>
>>> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
>>> ---
>>
>> Hi,
>>
>>>    drivers/net/intel/ice/ice_hash.c | 9 ++++-----
>>>    1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/intel/ice/ice_hash.c
>>> b/drivers/net/intel/ice/ice_hash.c
>>> index 77829e607b..d57b5ee0e4 100644
>>> --- a/drivers/net/intel/ice/ice_hash.c
>>> +++ b/drivers/net/intel/ice/ice_hash.c
>>> @@ -1109,12 +1109,11 @@ ice_hash_parse_action(struct
>> ice_pattern_match_item *pattern_match_item,
>>>    			rss_type = rss->types;
>>>
>>>    			/* Check hash function and save it to rss_meta. */
>>> -			if (pattern_match_item->pattern_list !=
>>> -			    pattern_empty && rss->func ==
>>> -			    RTE_ETH_HASH_FUNCTION_SIMPLE_XOR) {
>>> -				return rte_flow_error_set(error, ENOTSUP,
>>> +			if (pattern_match_item->pattern_list ==
>>> +			    pattern_empty) {
>>> +				return rte_flow_error_set(error, EINVAL,
>>>    					RTE_FLOW_ERROR_TYPE_ACTION,
>> action,
>>> -					"Not supported flow");
>>> +					"Invalid empty argument");
>>
>> I think this changes existing semantics a little too far.
>>
>> The original code disallowed simple XOR only for cases where pattern wasn't
>> empty (if it was, we allowed it - i.e. if it was a global RSS configuration). The fix
>> disallows empty patterns altogether, whereas what it should've done instead
>> is remove this check, and instead modify the second check to look for empty
>> patterns (because otherwise we would go through further checks down the
>> line for non-empty patterns).
>>
>>>    			} else if (rss->func ==
>>>    				   RTE_ETH_HASH_FUNCTION_SIMPLE_XOR){
>>>    				rss_meta->hash_function =
>>
>>
>> --
>> Thanks,
>> Anatoly
> 
> Hi Anatoly,
> 
> Thank you for your comments.
> I understand the current change disallows all empty patterns altogether and that should be rectified.
> My doubt  is should be allow both empty and non empty patterns to apply for simple_xor like symmetric Toeplitz ?

That's what your patch fixes, is it not? It already allowed empty 
patterns with simple xor (the second branch of the if condition).

> 
> Thanks,
> Anurag M
> 


-- 
Thanks,
Anatoly
