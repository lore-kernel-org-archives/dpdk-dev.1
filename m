Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B5BCCA464
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:01:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF3E1402DA;
	Fri, 16 Oct 2026 13:00:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 70FC040656
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:00:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792148430; x=1823684430;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cqKKnCQMyU1iZSssEXOFMn8g/udmKXX/vkk6fmQo7v0=;
 b=f3iYR/lmrwALj2T07QledAO3rmX5E7JV852SxRO5+mivJJwwJzzxaCGi
 L+kSmU8Q0WTf1yZM6dXzH6x52gszpbj9A12DaBLHwu8YcxjUzxQsUjn96
 lLy3g98asHQyLvJ+tC3DlY6MfxErWg73/KckPhFW7sPJYHoNIcsX3MFHI
 yXBtryemRDzTaI4KhubUwsYKjsNpzGejorWbklVNKCTyfHLQavkR34UyY
 sCpwrr+uRBvrf3ZI41ZqILpQj3EODN8l4a433815xgViAp7mD2PZfrL5P
 abtj3KNUBiDUHvLDaY3/dnU66aVlLwmI6pF4WSCNwkTf+9c1kQA7J6YJE w==;
X-CSE-ConnectionGUID: YughoYd/SYS+Em/olmOUTw==
X-CSE-MsgGUID: WDWQWcF3SlO7wohsJkQrbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="828077"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="828077"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:00:29 -0700
X-CSE-ConnectionGUID: +wxZQJI3SYm0OjwkyeBLBw==
X-CSE-MsgGUID: 1yH1IQGoR56WU8kiyULqPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1987636"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:00:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 04:00:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 04:00:27 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.25) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 04:00:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKoNPxrvdyQtFPkRk1Cz4RVYPRUlZdnHfkDCqLxgEQXX3eYRrU0QnhQgvlVjujQ93FMBuiZzXGp/sfh5DasnU3flGXS/OwfqmDO7XAjcOZ2pdvYE/9XMCHgQgigVt4OXLEooURsSrgeLpE9f9sKAWjU7rZVWl3WVhCGbF4La40zHRp4oCtipmP6ArXwbpzPVmmWv4mf50/k2FgpKWue265cz0rhrVrNBm3Nb2NrgUW78SKRb/nR7jfJU7Y9gElwhhtQQP8U25sdTQ8b696RA73nTdD3jAgxrH7INmtRrKTKUMssR51HGkwiQDicallxIKJVzicDZ0h2o2sGuVLFVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D761JZ7hDJEEM1NYns1HYdsEnr7qrR6+J3x+5mPYbSg=;
 b=US05YTecrQDmCcd9LK0bvedG8VC7LEbJoOpkBsKorIItqLra1XvEo1P3zqIByphh7bbCgK6Y+Jek3Q8GgjV+tH5MEJZcAMcATvHEe5PdYkTSBnQzLFN8hv8XpFLdgUMsaAFJ9bpzHaK0hvv+tI70/FJzluRLCaudCB/r9TxV8EJSlNyPFCpl23sCVITWQuVYbn4CMELnaN0ozXbTsYkvcIdXnvjaRAOHumMjRYfDrxx0vt+/yzoRizx8k5lOcCXYWG3+wioiuMH/shii3xpqrGUKQqvaoI+GCv1+vb7PlA/d8ba874evETbZh7hKrEnu7pJm2O5FsdlNfdzunvCG6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 EAYPR11MB9969.namprd11.prod.outlook.com (2603:10b6:303:2d7::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Fri, 16 Oct 2026 11:00:25 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 11:00:25 +0000
Message-ID: <554c8393-4a9e-4185-90dd-73fe22b7afc6@intel.com>
Date: Fri, 16 Oct 2026 13:00:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/7] net/iavf: fix hash flow metadata leaks
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>
References: <cover.1791991100.git.anatoly.burakov@intel.com>
 <60442096f221bf2ccd30dcc2d19a7f9819a9a2c2.1791991100.git.anatoly.burakov@intel.com>
 <AT6PR11MB044526DC14053DED4A12805BFAE49B2@AT6PR11MB044526.namprd11.prod.outlook.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <AT6PR11MB044526DC14053DED4A12805BFAE49B2@AT6PR11MB044526.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0006.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|EAYPR11MB9969:EE_
X-MS-Office365-Filtering-Correlation-Id: a04e6d96-ad4c-400f-cfe9-08df2b74ae28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|10067099003|18002099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: /Xcubeoy4ioL6epfNO52V8OH1aTCcghWVISpkUuo2HX5Jxk5bccVQ22wpOptrPwj8hZHW20ym7jO2BFFzsgNPjQIu2GhNYnIFNaEwM9EoBclfTuuQm7MaDCLDqvaQHijsNJwvZ48fCRoICKhCe+EL3urOon65mh34AyhskVW8ueLPYpr3TUbSJcYZ487QgVb7LrV4nr3CGxkVs09Fwgieta70CQx4DHFwEN+92cp9yMaPn0UrB65cm5dXMi9H8fqwPMvdIM7KOcnyyM3O3IJV94JHRsoU+STsYnuzx5aFZhD3Rjx8Uk/+KLZnkstIgr5vngOtioncD85+vhpXyoLAXrjpUy9vDNe2Wy7T+SPLqMNBeSGy0LAUzpTu+JKQNS/5WMv3mHoozKf1SoEHNFMMyyymCYhW2PeVIAJ1pMqxGIifb+xYAokELvK+4lrl/PguUkmFivTPdqhaC4pyvr9dZxoXM29AnJ4lKYZmf0HKOAqRW7AuCx0S7rHjg3Quu2abeY5AkmPj26fepoLC0I29rrS0BT1kza8DM+AjJCfmy6SRlPPlyloZ7irmNbOoaLsKQxMUAjvI2vXbMauNGYVjp1Z7U6rZpG4jCdwWZlxZ3hQ6oa9aZZqZ7YsWS4YSKvc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(10067099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGRHdHppaEswQUFWUk5xdEJxZ3VXalRyTE9XOFBiZGNMaDRWaGtsQ1VzSG9H?=
 =?utf-8?B?cjN4UWZBUVlzUk1EZGwyNElLSUpLanNwTlI1QnI1TnRZYXVLVzAyalpuSENH?=
 =?utf-8?B?NVBWVjdjNmpZL0VicWJxdFZOSSsyR2lRc0VoNVoweTlmMFBYM2VtbzlNNzJW?=
 =?utf-8?B?NjZUSnVJLzNNNkVlNXQ0L0ZVUDhIMjExTURsR1VSdTVrOWh5ZXBmRjYvTnlv?=
 =?utf-8?B?V1NzbnJTRXlqYjdiV2trRmNXLzRqUWhwTUUyNW9QNlRxZHd2N0FwRlJwaFph?=
 =?utf-8?B?NHJKZzR2MGZsbWFLR01RUW1GVVBFcFJMR1NHdCtJMWl2UCsyOVhOcUJpRkRy?=
 =?utf-8?B?N3duWmp4MkdJdnEwN1UvcFQ4bEZTRXRtbEFWZlNaa25tdzNweUpYclorSVpS?=
 =?utf-8?B?aEFBY1dxMnY0VkFSUzE1eXN2SFJrVHdzVWtHUmxHNjV4YVRwMThTUzE0MkdT?=
 =?utf-8?B?QmVuZEtXN3AyckhEWUdHeTFTMUZ2ejVkN3pYc3VWTEFzaklkN1NiTUZ5Z2N2?=
 =?utf-8?B?VnpQWmhuN1Y1TFFrQ1VTdS9DQ1BzUExVRGdIVUJjYTdiMncrME5XVnBIQzVK?=
 =?utf-8?B?NFRYM3dIMi9rb3hqanhndVhTQU9PV0lpRVA1dEVXMFdFN0pOZDRoOGNwQ0V0?=
 =?utf-8?B?UjEvME9FWXpxYjFkTWNOZWZXNmRkOUZHSU9CZ3picUdEOFJzZENTRld0SzVn?=
 =?utf-8?B?Q0ttcWlwLzZqK1ZGeUVoNjdhRFd0TERxbXZORURZOVJkQmN2ZUM1aFZyVXBs?=
 =?utf-8?B?RWo1QlMydlpWR0tuRjQ5K0FCMk5zNmI5NlU4OFcrSHNZOFBnbTdxL3J0T0VS?=
 =?utf-8?B?clNneXpiTCtabDlTOU1CRW85dVFYUm5oSEtJaUNoK3pWWnN5NVRTS3VVaG1u?=
 =?utf-8?B?ZUJJR1VGVjBIMTg1RUw0eXdqZ0dzTERzV05BTHhVS09GcURnWlFMbnd6VE9M?=
 =?utf-8?B?a050bnZTeGhMOHJPcUdXeGJXKzBOZHNhUVM3Q1ZoL0t4UDJNdFI2c3RJTFB2?=
 =?utf-8?B?Q0tDUmxiMXdGSG13UTN3dTlSQTluL1M4LytNc3d0TjlPWmpmYWtuUnF2bnlR?=
 =?utf-8?B?bGowQjcwMWFOWDNEaDgwaXhVSWNtNVRWUFFMelBWZEdOdVJrNi9TZWdKRDNR?=
 =?utf-8?B?Wk5YZXNZcjN6eDA0YzliUzV2N1lPNnNCaGNvZlA5cVUyYTM3QVpzVWNGTmZY?=
 =?utf-8?B?NjFQTjd2SUNlMkxpV2dsMFNQVDRLNG5xbVB3MDNjWWRyMHpZVTg4eVk4bG85?=
 =?utf-8?B?c0NnRXFhUmJQTC90aWFzL09lOG8vMStvMFRIS3AydkVIbi9YTmlnbDlXZXEv?=
 =?utf-8?B?elJsQndWaFB0S2o3cktVOUplekh1YlVKK0t4bDJva0MzdGxCcFhobnVXSmVG?=
 =?utf-8?B?MkZjcDJ3MEY1azJ3SEUzQlZEVm5VM3FXeGJzREwza3RUcWFIU0M0cWYzaDB4?=
 =?utf-8?B?Z2NXMkZLWFNtd3FwVDVTR3VEVjlRYTg3MlprZlVrb0pDSnZQWnRvcmNpbzZm?=
 =?utf-8?B?Z1VRNHFUVytaZ2R4VEN1K05IUmsxR2RHbW9zbmtrUUxjRktOWk1yTXJ4RU1F?=
 =?utf-8?B?UlJIYTJFdzRXcGxXM080bmVibVd0R2QzNUpIU21PTkdxR3p4RUtvODZQVUta?=
 =?utf-8?B?Y2FXNW01WVZzWXc2UkIyenpBZ0JjN0JuMDFmTk5hMEpzcjZhdFJqblZLOFZG?=
 =?utf-8?B?YmFRRk9oTVFFNk5PK2dYZlJmbE9ncVp5YzBoYXJVeVNtcGRrTjdWQUtwWW1u?=
 =?utf-8?B?ak4vR3ZweU9lYm04TFVqWG5LSTNuSWtLelJTczNhT2RydzRxVmZBMkQ4dWNY?=
 =?utf-8?B?djlIRm1GSmF0Q0NtenBZUS9URU5WTnRhMXQvRTRaWGlEejRhMGp5aERlMUZH?=
 =?utf-8?B?MDF1YjFLNE5rUG9XMzQ4VStmMnNFd2pSNDlDUzhBakJZTWZnR3pkemFBY2VK?=
 =?utf-8?B?L3EwMUNzOVJuK3M1QUxPU0pMSHord20yS3NLV24wdDNVd0RuU0EyNFJCQi8z?=
 =?utf-8?B?SVJid0d2SUtLOUMrVU1maVpzNW94aEMyS2JXbGNlRk93QzFVZnBWcnN6K0lM?=
 =?utf-8?B?Yk5zbHhCcmJHN0dZaVZrOEFMOG5zUkVNWFJmTnpST2VsaUYyeEFhZml0RVRU?=
 =?utf-8?B?ZFRoNmZHV2JJYVVVQzNxTGdKMEJWTnMrR3phaG5WWDBYOHlsWW5LL1JyYTVC?=
 =?utf-8?B?TGhuZXZhVUlRSUh0VFlNKzNqZW9BL2NqZ1RwbDVCb0t1WEswckphZ2NQY2hs?=
 =?utf-8?B?VTQ0VmRKaXRNUmpHWVJDMFkyNU1vTzZOUGh3ek1qL3pLMUJpZE53aG5HN3ZR?=
 =?utf-8?B?RXdzSG9EcVFpMW15Yk91YVd2SUtpeitBTW9FSWRmTWtKVE9GeXRBZDVWeFFX?=
 =?utf-8?Q?csHI+3gv321xszxU=3D?=
X-Exchange-RoutingPolicyChecked: frEcUwZcHCTiXnNqg+6Ld7qgVEMaUyeG3AMQZfV4vwuMJ7d5aJbJcWU9ZoZvinefjGAb/ZEq6VU41qsLhmDYqXYXJm8v/SDcOMMdXLesB7MKi87JWVuXBeEQpwsu4tCFKeisg3IUCQzvauvgiRvPwqFVGTW4uK9ZWDVRh85w70Rjz+G1PVuKcB4QRAjUw3ghjkZyvu9ydiz2e+zxE2WZqHF/SwTT99x14hP86uJ27sKERwlQDMNu7ymtQbaT9t6KoBSMIngBB0HVscZQoPwWVrvbFBbH2ohlAFdPjNSRj+gP7OAvFORbe88xnbF0RgIrvFV/eDg911EZa9nhygSHLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a04e6d96-ad4c-400f-cfe9-08df2b74ae28
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 11:00:25.0858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mRyIb2vHYWDbQnPY0PpHR5Q8WSQQBnnWtR4rAYue9+/aVnLrjm1jFnzdPZ/q4wS/EmX0A9E0ax+iR/9AUnDQmfuG6Hf/RSrmSWUcbWdY5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9969
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

On 10/16/2026 5:12 AM, Mandal, Anurag wrote:
> 
>> -----Original Message-----
>> From: Anatoly Burakov <anatoly.burakov@intel.com>
>> Sent: 14 October 2026 20:49
>> To: dev@dpdk.org
>> Subject: [PATCH v1 5/7] net/iavf: fix hash flow metadata leaks
>>
>> Hash flow parsing allocates RSS metadata, but validation has no callback to
>> release it. Creation also leaks the metadata if rule allocation or the request to
>> add the RSS rule fails.
>>
>> Add a validation callback to release the parsed metadata, and free it on both
>> creation failure paths. Parsing already checks the RSS inputs; validation does
>> not add or remove a rule.
>>
>> Fixes: 7be10c3004be ("net/iavf: add RSS configuration for VF")
>> Fixes: 215a247b5f33 ("net/iavf: refactor hash flow")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   drivers/net/intel/iavf/iavf_hash.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/net/intel/iavf/iavf_hash.c
>> b/drivers/net/intel/iavf/iavf_hash.c
>> index cef30cd08e1..6787a380f8e 100644
>> --- a/drivers/net/intel/iavf/iavf_hash.c
>> +++ b/drivers/net/intel/iavf/iavf_hash.c
>> @@ -80,6 +80,9 @@ iavf_hash_destroy(struct iavf_adapter *ad, struct
>> rte_flow *flow,  static void  iavf_hash_uninit_parser(struct iavf_adapter *ad);
>> static int
>> +iavf_hash_validation(struct iavf_adapter *ad, struct rte_flow *flow,
>> +		     void *meta, struct rte_flow_error *error); static int
>>   iavf_hash_parse_pattern_action(struct iavf_adapter *ad,
>>   			       struct iavf_pattern_match_item *array,
>>   			       uint32_t array_len,
>> @@ -680,6 +683,7 @@ static struct iavf_flow_engine iavf_hash_engine = {
>>   	.create = iavf_hash_create,
>>   	.destroy = iavf_hash_destroy,
>>   	.uninit = iavf_hash_uninit_parser,
>> +	.validation = iavf_hash_validation,
>>   	.name = "hash",
>>   	.type = IAVF_FLOW_ENGINE_HASH,
>>   	.rule_size = sizeof(struct virtchnl_rss_cfg), @@ -1579,6 +1583,15 @@
>> iavf_hash_parse_pattern_action(struct iavf_adapter *ad,
>>   	return ret;
>>   }
>>
>> +static int
>> +iavf_hash_validation(__rte_unused struct iavf_adapter *ad,
>> +		     __rte_unused struct rte_flow *flow, void *meta,
>> +		     __rte_unused struct rte_flow_error *error) {
>> +	rte_free(meta);
>> +	return 0;
>> +}
>> +
>>   static int
>>   iavf_hash_create(__rte_unused struct iavf_adapter *ad,
>>   		 __rte_unused struct rte_flow *flow, void *meta, @@ -1594,6
>> +1607,7 @@ iavf_hash_create(__rte_unused struct iavf_adapter *ad,
>>   		rte_flow_error_set(error, EINVAL,
>>   				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
>>   				   "No memory for rss rule");
>> +		rte_free(meta);
>>   		return -ENOMEM;
>>   	}
>>
>> @@ -1609,6 +1623,7 @@ iavf_hash_create(__rte_unused struct iavf_adapter
>> *ad,
>>   				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
>>   				   "Failed to add rss rule.");
>>   		rte_free(rss_cfg);
>> +		rte_free(meta);
>>   		return -rte_errno;
>>   	}
>>
>> --
>> 2.52.0
> 
> Hi Anatoly,
> 
> I had submitted similar fix  in this patch earlier.
> https://patches.dpdk.org/project/dpdk/patch/20261010121255.528329-1-anurag.mandal@intel.com/
> 
> Thanks,
> Anurag M

Thanks, I didn't see it before! Your patch fixes some things mine 
doesn't, and vice versa, so what I'll do (if you don't mind!) is I'll 
respin my patchset and include your patch with my additions.

-- 
Thanks,
Anatoly
