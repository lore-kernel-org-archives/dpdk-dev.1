Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8890BCA5FDD
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 14:45:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69BFA4026C;
	Fri,  2 Oct 2026 16:45:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id A848A4003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 16:45:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790952323; x=1822488323;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=Pan/Imv9FIe+o8YpUKdoWBOmlVkegPN7SY82nHSou14=;
 b=jvhDW81Dq1X+xMRn7m03shxHbyotvhnWFmYCIdDltM/VpUsglQLQEAVs
 kdVCBRUPgL7Rw2vraox7LCNDmAu5DH+FI8ORCWLaJ0bexf3o7Oakb3Hbc
 qNmonqMhgtWmLjULbZhuLvejojD60MMDCTYqoevGj57ygrruOLNBnSypn
 ZOEHB7i3NVvqyZdyHFNMJcYsN0RgB8n07sF5IQPsWPGNuJ2hlGfKYQVyB
 nbmGTICPkIYxBvZYacSK8nDLMAYo4I3K18mmWOXj602gdW66PdNoDjweo
 UWtdpM9QG+VqnnKHYNDqOjp8LB0yey3oczJRLPME4DBfjK6wlOyoFPulO Q==;
X-CSE-ConnectionGUID: HCC8MDxRRIauo97W1Xo7vg==
X-CSE-MsgGUID: rs4MSomtTSuR9RSpdpLizQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="91738675"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="91738675"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 07:45:21 -0700
X-CSE-ConnectionGUID: D7QyMcKvROityrPTK0RuMw==
X-CSE-MsgGUID: NqyRTSZESWOxcoifhy7erg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="279511893"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 07:45:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 07:45:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 07:45:21 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 07:45:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NO5h/z+Jdw/k9Q+43kfLjCZxgm7TTb09BW3Imd6fMDbgq3s5FAikHPk8GNINPhx0z+FnNy0FYpWA/88+kAJyh+RRE+XCqAYUaubZ0EcopjR67R3ekybvyHcsGSJdZyUQVh/l/IypWDjZ9jRxp6G+CjYIbDpPzHOvEcV63dPOlKQOrk8fdXQBlFOKuDJjIfzrQczEtIOs1asDLPA8E/9anM0ZuI4dB/aQHF1CcfDM5XSmRPLcco3/dtMM99RZWx0s4Iz52d0uFhDFqu3szSUIfq7aRMTYYa7C432nxelT3dTd1O0rs7010XUW+H1HIWELUhZAl9MkpK7gaaipn4IjZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTcx9meX4y12HOEIt8HIbiYOUQkv3lwYdNUfgWGyQbQ=;
 b=raWdPCXdUCJbzvb9sgBwwFrnkhSEvWvMxlqAjW9M//NTXE0amZ42GQDs0HFcUS4efaTHUsMH5Z/+Zvf8sOkestFqx/Re4Ph8du5gxboYO0rVBCcaeCq3f69LOChKG4zTw+RjucArPMJ4E7LF9fdOGWcfcHEmM1hxCaqskMK0CLM0xgPde8oEvBr9CNwH0SzBAS65kURJI9o/ULlDKVV2jkuOjCnVoC9GSnk1T7/JemwC70fWx5y6j26tt/FDYpsy8UTMhZcruukNbwTPWfQNzSszHO8ZBA8BpWy08hfN31GYACJvoXhCyrAcrXSBT/wcnqIM1F+zlC/nsv6b94LYtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SN7PR11MB7042.namprd11.prod.outlook.com (2603:10b6:806:299::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.18; Fri, 2 Oct 2026 14:45:18 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.015; Fri, 2 Oct 2026
 14:45:17 +0000
Message-ID: <d8512459-29e6-4bf1-914c-d2d81b7a400e@intel.com>
Date: Fri, 2 Oct 2026 16:45:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/19] net/ixgbe: reimplement ethertype parser
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
References: <e389782f585880877bd626cc0a05bac81e418393.1789560945.git.anatoly.burakov@intel.com>
 <0baf24e4-ef72-4462-8804-6be86701a423@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <0baf24e4-ef72-4462-8804-6be86701a423@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2P250CA0022.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::27) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SN7PR11MB7042:EE_
X-MS-Office365-Filtering-Correlation-Id: a36ba4a8-0365-4f5e-fb0a-08df2093c6a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 8cLbQBNFvr//mVGrdXAtm/ONcerUxXFjlJRy6zPn0fuzrNnh7DUAtIFlEpl4qoVWivD4yudQO3hfNbG7VtoB+PryDpQwHVHEZTP7L7Jmye+RD9ss5oPI1mbsVBdlf8cV1LToUp9ogHJmpqspKhfmdM8zybVlXwvfoo7mequbQzuwco5nlcWHr204kFlGhK5MuTI963+70UMoGMxm4uIwp4h554lvz1623z35+5kCmft/SKsKPlyEKFjqLP5l95z9m/ORyNvC4wabPIelJ8VinsrVrAbsTvgwCBphZoq4bVPywhghdUAAYbHVN+VkneQhe6ffvh4H2DHKMuQNVZfok6rMn1SN5YGV7aciLx1iuUkTJdX3g6JAJSM7w8WZZDSN8wK72gLrpTqcHVHHTKOy/LmRpN7kQCZBbkQVXKK+Jscxa45txY0OVl6o5otRfMuwDIr5/P6Fq8ys6nZhQvA3H4Ll8/nZmdswqVU3xf3qawZplPFmiMFA/5eWNXANurRDlhjk1Nkaw3WCpgdyOM2P7V6THcDyLAWcLEOkHDcPQ2spggqPSRZ5gC6Za4y0EDMhueug2ma4EFDUCmw12z7Z+DyZwfPjX/r/jxiZZcIMr/M8P3hvRV7u07F0aOm2YOjHpBANzs3i4wjhQRBozW8CO/viXjcXfSB9yZpEnDf68CQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFRMRVg3cGJleCtUa3RqcUtzVnI1MVdrdWR4aHFFSGdYT09HczFrQ0ZONnFr?=
 =?utf-8?B?UWR3RngyMUl5Y1VqS05OMi9GakFFVzZxN243ejBtQWlFOW1CSzd1NWh3U015?=
 =?utf-8?B?NDdPWWZkanp0eEFnZHFMck91L3lCWElIZm1UM0hNUDFaOHVzVlRZQnpTekxo?=
 =?utf-8?B?bkxKd2szQjMrVWxZbXpka0tVYkNhTmwvQlBONjJWOUI3d3FrWmdoZy9tUFd2?=
 =?utf-8?B?UlgyR0dPa2dtRUFoR3hGM3hDSlJOZTVYUTVUY3VIVFFtVS8ydDNNMFU1elIy?=
 =?utf-8?B?MkxYOXJJNEtOSERkZ1MybnlVTXl5VElNdlRhNyt0U1hsOGIrYVJvVTAxMnRK?=
 =?utf-8?B?aUdQSWhyYzJVTXJJcE1kV3pMVWZsQVR0akpuaWpXT0p0dzhBWGxhc3ZPQWdM?=
 =?utf-8?B?V3FHVGhsUk9Kb1hNc09hcGlXWW5XcWYwYlN2cDc4NEE2aEtnaUd2VlB1UTlD?=
 =?utf-8?B?clR6a2xtdlZDMG5qbVRzaHVSTzhKOEcvRmRuTlFhN3haUFp1NGQ4emRORlR1?=
 =?utf-8?B?UkdpZC91b3dkbHBkRWF0SlhvbWxmT3hXMXNoYi9OTVJDVXoyRGJLSmQ2M3Z0?=
 =?utf-8?B?MGM5elc5TzlIQ1NnQTMyMmVQdk5ZZTNjS0xMbFdJL3c2ekJybXZtemFaYTRE?=
 =?utf-8?B?NTFMU1hZVnJMQVFQVGhjUTlXTkxheThuREFHNmo1WTZsOFRId0NUWENGS1pv?=
 =?utf-8?B?RW93SkxJK0hVZzBkNy9FU0pNREtvTCtZVXJIZHphU2NnRlk1MUZKV1NSTTh4?=
 =?utf-8?B?NFpFK3IvT2Ftd3h4czZTRkhIT21pTUdmZkl2cDVCZEJHblBMcWkyZllEM0Mz?=
 =?utf-8?B?UFYxQXorOE8zb2VxUktFMm13bDcwcE9ZYWg0UUVYUlEwTTFoME54N3V0TUlN?=
 =?utf-8?B?Q0xUbjU3ajdldmtsS3RQZEdKZlR1cTQybExxZ1krU2FLb1g1QmNpSU11Yi8w?=
 =?utf-8?B?UTM1Rjc4ZHpJRFNBSHRYQmtIK0xNY3Fxd3FMSkpjVzcxZWd5UHlVT05sMEVp?=
 =?utf-8?B?K3FFNGlzMHgwSjBpdndUWFVQVkJYVXZVMkdhVTFjVm9pRUwrSDNzOEU5L0o1?=
 =?utf-8?B?b0tYai9rQ3hQZEpDV3FjVnVkeGh6cjhvYmJsNmpSTUJRcGJZdnRjY0R5M2o2?=
 =?utf-8?B?NFBqblNkNWpFQnlKVjVwOUdkV3I0SWtuRXhQNlFhVTQ0UlpwWUI4M1R0U2E5?=
 =?utf-8?B?VGIzTmZFRDJmSUErMCsrTTJMSnBFWFkwZGFzWDMzc0NrMXpBcHdiVlZDUkc3?=
 =?utf-8?B?dForbWl4TFFOZUtDRjUrOW5WbVdNZXFpd1dtV2M2L2NuR2R1Qlh1aEQ1bmU3?=
 =?utf-8?B?cmxNTklnOVlwMWExZW0zSWY3d2VyaGQzR3RadFhmVmRXUnNNTTh0OWZjaHQz?=
 =?utf-8?B?V2ZpanRvZzh6aFdEN25GMUxvbFYvY0NZQmVxeGplZG81UVE1WEtGRHA4NUlX?=
 =?utf-8?B?bWwrU1l0M250Vm5sLzZ3SGlMNGd2VjJTemc1dWk2cEpDTkh5U2NiWVhkRGNr?=
 =?utf-8?B?dm9NMlBSVEZoT2kwSUVGMVN2TFAxbWVVU3AwUTVlUmllanNzTStmclEyOHpI?=
 =?utf-8?B?dG5JWEhzV1d0NkcyTUpjclBWVHhDY3Z5K0czVnFUZlNYSFVPNkN3OEdVWHRX?=
 =?utf-8?B?N1pQQUVVSlQvQlZBZ0Z5Tk5QWlgxNU9mK1ZuRjJ2ajRFOGpKNGdIS1VWQUpI?=
 =?utf-8?B?bnU3M3R5bkxGcUlpU0phR0tvUEJ4SnNEOC9WamgvSHhoeTl4U0tOTUt5ckZQ?=
 =?utf-8?B?UGc5QVlMZy95a1RLTkFYWDJEbEptU0ZKWlRHVGR3TUJYUGlrMWR4bkdpN1RK?=
 =?utf-8?B?Si9ic0xRL1FOeURqRzMrNElMYjRONThJK09UbncrczYwZmJKVVhsQ0UvM0E2?=
 =?utf-8?B?Z0RlZFJwcktUTUtDVzE5NEhwR0htcGFzbkkzaVNSbUJDcklzSTNPb3F4c3Rm?=
 =?utf-8?B?bEx1ZHJSZytCNU5XU3ByUFNLVVUyeSt5Rzc1K3ZaUTNqT2pKdm8rNTBSVXhp?=
 =?utf-8?B?YzVpMHZXSW40alJFZ29qWDZLTzJnZ0RwNlk3dWduWGJVM2V5bzVlWURJRHBi?=
 =?utf-8?B?QnRvYXROaTUySzREcVZUOXVFc1BXdHpjRzNicFl1YWFyS1ZUdGp1QndNUllm?=
 =?utf-8?B?UUxqOVlZWVdTQjBkYnAxUnNDeEIzY1J5ZGl5dkFaais3TDhnU3NiVUluU1lR?=
 =?utf-8?B?TEg5aWM2akNkTTdaQmM0SFRTenBQMnV3RlVha1EwbDhCeXVYZnYrWGFRWTY5?=
 =?utf-8?B?QmxrM0FBcTdFMVRpNXhuc3IrM0pxaTVxcklCOHJWZ0dSV0tHbmZRSlhTb2ha?=
 =?utf-8?B?ZklWakZ1citQVE05OGRycG9zNGpKMjVVSGFCVDdoSlJIcm1tdERIZ1dMWldy?=
 =?utf-8?Q?AOYLLcDWqNr2dz/o=3D?=
X-Exchange-RoutingPolicyChecked: dhAa2hyJpjuMuc1hw0MZuUyuOT0lcsL2DscJNbNRGXDGrWkmbSEYpoBM3rleMB97B0STR1wluNjPCzI0FcN6vLJtyF8a7lW4z9IBxv9LnXHhxKwlvmbefwkOQReaXr15Ytzbod54ap8SRkcGOOn9mZY+N9Et1hNZc+qQoO4tKGNXKChuGN1emzbA11fR1J3N4IpcafPl1IB6340ADsIT30LtrjdVqurWrJP+3SzirMInULpRqX2jnpb+k63VWgzOLiIYAvh69np9lJjs/N+uOrU4L2XirYblRU/C3cF6BBwmFrI3JHmSovou9otxVH/8mjS/t0Dv1acUpoiydxLI2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: a36ba4a8-0365-4f5e-fb0a-08df2093c6a9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 14:45:17.7942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gc+z8AMny0eF8V4eJYIlbAsVNpJze9DhgV1LhzDKaNAJ+s5rYjsa8DNzp6nLNDW7PP28m0OpsqITVIO7pNcJdLIU7ezd9LPwhLMUVfrGASE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7042
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

On 9/19/2026 6:10 PM, Medvedkin, Vladimir wrote:
> 
> On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
>> Use the new flow graph API and the common parsing framework to implement
>> flow parser for ethertype.
>>
>> The old ethertype parser was accepting certain things that were later
>> rejected by the actual ethertype installation code, in particular DROP
>> action as well as dst MAC address filtering. This was removed from the
>> graph parser.
>>
>> The ethertype filter tracking table is used by the rte_flow ethertype
>> engine, but it is also in use by other features, so the filter tracking
>> is refactored to be properly shared between the engine and other features
>> that write into the same table.
>>
>> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
>> ---

Hi Vladimir!

> <snip>
>> @@ -7198,8 +7177,11 @@ static int
>>   ixgbe_timesync_enable(struct rte_eth_dev *dev)
>>   {
>>       struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data- 
>> >dev_private);
>> +    struct ixgbe_filter_info *filter_info =
>> +        IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
>>       uint32_t tsync_ctl;
>>       uint32_t tsauxc;
>> +    uint32_t etqf;
>>       struct timespec ts;
>>       memset(&ts, 0, sizeof(struct timespec));
>> @@ -7221,10 +7203,19 @@ ixgbe_timesync_enable(struct rte_eth_dev *dev)
>>       ixgbe_start_timecounters(dev);
>>       /* Enable L2 filtering of IEEE1588/802.1AS Ethernet frame types. */
>> -    IXGBE_WRITE_REG(hw, IXGBE_ETQF(IXGBE_ETQF_FILTER_1588),
>> -            (RTE_ETHER_TYPE_1588 |
>> -             IXGBE_ETQF_FILTER_EN |
>> -             IXGBE_ETQF_1588));
>> +    etqf = RTE_ETHER_TYPE_1588 | IXGBE_ETQF_FILTER_EN | IXGBE_ETQF_1588;
>> +    if (!filter_info->timesync_installed) {
>> +        int idx = ixgbe_ethertype_table_add(&filter_info- 
>> >ethertype_table,
>> +                RTE_ETHER_TYPE_1588, etqf, 0);
> if I understood this part correctly, from now Ethertype filters are no 
> longer statically dedicated for predefined set of ethertypes (ref 
> IXGBE_ETQF_FILTER_1588) and now are dynamically managed. It is probably 
> worth to separate this to another commit, or at least mention about in 
> commit message

Yes, I'll separate it out.

>> +
>> +        if (idx < 0) {
>> +            PMD_DRV_LOG(ERR, "no free ETQF slot for 1588 timestamping");
>> +            return idx;
>> +        }
>> +        filter_info->timesync_idx = idx;
>> +        filter_info->timesync_installed = true;
>> +    }
>> +    ixgbe_ethertype_filter_program(hw, filter_info->timesync_idx, 
>> etqf, 0);
> <snip>
>> +
>> +static int
>> +ixgbe_flow_ethertype_register(struct ci_flow *flow, struct 
>> rte_flow_error *error)
>> +{
>> +    struct ixgbe_ethertype_flow *ethertype_flow = (struct 
>> ixgbe_ethertype_flow *)flow;
>> +    struct ixgbe_filter_info *filter_info =
>> +        IXGBE_DEV_PRIVATE_TO_FILTER_INFO(flow->dev_data->dev_private);
>> +    int idx;
>> +
>> +    idx = ixgbe_ethertype_table_add(&filter_info->ethertype_table,
>> +            ethertype_flow->ether_type, ethertype_flow->etqf,
>> +            ethertype_flow->etqs);
> 
> nit: is it worth to check if idx is negative instead of handling only 2 
> error codes?

Will fix.

> 
>> +    if (idx == -EEXIST) {
>> +        return rte_flow_error_set(error, EEXIST,
>> +                RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
>> +                "Ethertype filter already exists");
>> +    }
>> +    if (idx == -ENOSPC) {
>> +        return rte_flow_error_set(error, ENOSPC,
>> +                RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
>> +                "Ethertype filters are full");
>> +    }
>> +    ethertype_flow->index = idx;
>> +
>> +    return 0;
>> +}
>> +
> <snip>
>> @@ -168,38 +180,29 @@ ixgbe_add_tx_flow_control_drop_filter(struct 
>> rte_eth_dev *eth_dev)
>>       struct ixgbe_filter_info *filter_info =
>>           IXGBE_DEV_PRIVATE_TO_FILTER_INFO(eth_dev->data->dev_private);
>>       uint16_t vf_num;
>> +    uint32_t etqf, etqs;
>>       int i;
>> -    struct ixgbe_ethertype_filter ethertype_filter;
>>       if (!hw->mac.ops.set_ethertype_anti_spoofing) {
>>           PMD_DRV_LOG(INFO, "ether type anti-spoofing is not 
>> supported.");
>>           return;
>>       }
>> -    i = ixgbe_ethertype_filter_lookup(filter_info,
>> -                      IXGBE_ETHERTYPE_FLOW_CTRL);
>> -    if (i >= 0) {
>> -        PMD_DRV_LOG(ERR, "A ether type filter entity for flow control 
>> already exists!");
>> -        return;
>> -    }
>> +    etqf = IXGBE_ETQF_FILTER_EN | IXGBE_ETQF_TX_ANTISPOOF |
>> +            IXGBE_ETHERTYPE_FLOW_CTRL;
>> +    etqs = 0;
>> +    if (!filter_info->antispoof_installed) {
>> +        int idx = ixgbe_ethertype_table_add(&filter_info- 
>> >ethertype_table,
>> +                IXGBE_ETHERTYPE_FLOW_CTRL, etqf, etqs);
>> -    ethertype_filter.ethertype = IXGBE_ETHERTYPE_FLOW_CTRL;
>> -    ethertype_filter.etqf = IXGBE_ETQF_FILTER_EN |
>> -                IXGBE_ETQF_TX_ANTISPOOF |
>> -                IXGBE_ETHERTYPE_FLOW_CTRL;
>> -    ethertype_filter.etqs = 0;
>> -    ethertype_filter.conf = TRUE;
>> -    i = ixgbe_ethertype_filter_insert(filter_info,
>> -                      &ethertype_filter);
>> -    if (i < 0) {
>> -        PMD_DRV_LOG(ERR, "Cannot find an unused ether type filter 
>> entity for flow control.");
>> -        return;
>> +        if (idx < 0) {
>> +            PMD_DRV_LOG(ERR, "no free ETQF slot for Tx anti-spoof 
>> filter");
> here and for ixgbe_timesync_enable(), what if 
> ixgbe_ethertype_table_add() returns -EEXIST? It is better to add since 
> ixgbe_ethertype_filter_lookup() was removed

This should not be possible. If the entry is already installed, 
antispoof_installed will be true. If it's false, then the only way in 
which we could have the same filter already installed is through 
rte_flow which would not produce such specific ETQF values.

-- 
Thanks,
Anatoly
