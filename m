Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5163CD4F54
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 12:40:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9A204021F;
	Thu, 28 May 2026 14:39:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1A2254003C
 for <dev@dpdk.org>; Thu, 28 May 2026 14:39:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779971998; x=1811507998;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4EMVJEUMkuuVhTUwZLlQOCVAi/Api597GkTmA0dYDDs=;
 b=giLlNGOugyGIQePzWMIeuDPLtLdXnF0uygHc71PqiZ6rLt8j84G4dQNM
 HjUNnQCCXSOVdHhE11QI6gSi/6v87XRJv59fYYiVACoixtCsiDYBLVKbJ
 B6g1SGmFwnh4gVLe+CnbO6YeXKNDc6OxqIIGhqA+Q/00RJGfoEbCfuyvb
 d4/9wca+UYivnR/Yfsrcvp+ZFpf9MVrFdQnMY25vnxLXJ2saHKePIIhpP
 ZPu1hqto7fgSVy4lH83oJnEengq9ntibgH2wQcOLzzW1Gox1ogmJXfXhP
 pUo7v5Bg8jih3+vfOS5misbi/vXK49v9wb6ApltWf0fRh42AyXN8zQjUV A==;
X-CSE-ConnectionGUID: OIwrzkaTRLqMFehc1N8nlQ==
X-CSE-MsgGUID: FKXiUDC8Svi2nXd94Nm4iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="83389470"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="83389470"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 05:39:57 -0700
X-CSE-ConnectionGUID: JW7B5LUbTkiNnKTNYeQSMw==
X-CSE-MsgGUID: MIg6tNtUQPe3Qfs1SxztWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="238122818"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 05:39:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 05:39:56 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 05:39:56 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 05:39:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKfdnCvg8LEQUOjsyg3Bz1smoUv/hPZIEER+vg27RcjhClfcdN6IDTBSEPhqKOlrZS5FuN1peS2PwZGN5npv09goOUaQ8PAEAQk2tFuj6AS18QZaCqx9XaUunpszH/Ct9lmXMMxgirBm6kuNiNeVKlhhbA0ThedrSWMBa870sfuzPeWUFwLTmnMHLGcNnw/w+ChLC3KaQNFO85LM7tMkiCHA/iICuYAWtM4/9tlul2aKp2XnRyamAnsyDlCjIXpd9gymL5LzJ/mSWuF8sWP3ram9dMmLM8RBWsVGPlHL7kGJ8qliBJChpT03HDhNFf7UIDqVRtrnyPNkGSDBNYy14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxGWXTaW0Pdvy6y5AJogqfGTIe1yqN/XyWFQkd3lKqY=;
 b=BSRg6oqYSldew7EBTXhbaYIqsmGxT9nr/SM3RX0Iawz/oCFsWANZFXRX9YZZygaSe/UsP/vBrDdDFpFraRa7j89Ieq8jjm+Lw9+PyiEfkZbEOREjXEMVAyJi9s1jOPVuZHvCg3FMvK9W/dNXEv2F6mN02ml7mb+j7dnjdPtBuzl8zY00KqB7OoKc7P0MqTQyjbdXQl7Ynf2AkeeJ7Se1+lC+Wzmco+04uGkJWX8R2chs77i0oImTLsIiHwhx2Q9f41zDQOTV6OMARFgu0Pvg9v8m1rd5pzBdOS6M1lDZL88IZmayRDf/IWuxkEYeg8kXSLlcNypQEpj18FeLlAeBCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA3PR11MB7581.namprd11.prod.outlook.com (2603:10b6:806:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 12:39:52 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 12:39:52 +0000
Message-ID: <9dbc8a94-ceca-41f0-b759-a23cbae76902@intel.com>
Date: Thu, 28 May 2026 14:39:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/27] net/intel/common: add common flow attr validation
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <cover.1779717943.git.anatoly.burakov@intel.com>
 <cover.1779717943.git.anatoly.burakov@intel.com>
 <d75e9a02b40ccfe8fd2e00977ee99e9be95ca9ad.1779717944.git.anatoly.burakov@intel.com>
 <ahbxgjoGdAEm99kj@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <ahbxgjoGdAEm99kj@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0027.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::32) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA3PR11MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 2494e13b-216e-4e3a-f54e-08debcb636e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|4143699003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: FrLP3lhIx43swFyJep9GiEdQ+ETeF0n3gRKHbB3GcuyCDCcz12tkEHOR1fMPYdYQvgDckeo+fLCmkbyObr+Z1fmjAXc67Ac14aARKR4UGCIpWYb4MkSkRt+0fSK+1GHyEGUd3kbh/dHztla1uVrWZoPhvmR0WeGLk+PtH7DV9Yv0+VJauGx6K7BD8OagrYmOaKcVA3jcx6wiq7n7uR4tfqZiUM54TCL9iUeIjkv2ByR+pnx2ft5g8dGxnYuw8GRhtigR6d7wDj8oz6fG6nD4jEjSxz/bcHUe1+h6e71UGDuWxgyu50oTpWMH93PjIEwHEyguPtbONB7oHW7ZUV6qUvGaASC/D5ZWMBiydkND4Y160NR6bRu9Ow0xBWSLxzCH9ryi/MVHFHlPb2c4BJmXgoGr/jf3bygffxW6qHDGtBWcmzPQAfhsNF0RQPWJX7TrsSbR+jl6Yfdp/4IVS4zWhQQVolGS5cD56anZeNupTGy3wnmmz8AxhzhuU9hqWmvp0nz2JJZreA1au4Qa9W7TStBthrsStuF9dCf/ZxW+/MTSgGCEqvAepAhq+xXSkxk8/rmGHbZ3qn2aE4xhuX7td52ynNJexgp3v1XN4ZPrikQvcBn1X/lYJFkV1ozwFJX2vyYSYWADtXsUtYwWrocOG0EmWW8KnyNdt8enzgbeZH4phvquwV75jjAHRl8vC9mm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(4143699003)(56012099006)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGZZZTR1SGhLdHhtb3pXaHJFTXJMWnFWdzlWeXV1U1VaZkdYWHFzUEN4SzdS?=
 =?utf-8?B?MTdpRWRNNHM3NnRZWkkzL2t0Rld6OFhNUjVKTml1QXAyN2xnendlT2E4Q0kw?=
 =?utf-8?B?OVFiUU9QK0RIYU83QzdJcXAzRWtxWXo3NW9acXFreXl3RHhsTldOYU55VGMw?=
 =?utf-8?B?RlVpN1VLb1p3Q2ZPS01xUFZIN2FNdWNxcitodlY3MHQwcDliSGJCZzNYdjlZ?=
 =?utf-8?B?eHIxWkovSDFROUNrRnBYQ1lvNisvWHAyUzZNRGtFR0FkRXRucVgzUWlMM1pr?=
 =?utf-8?B?OWY4QW9jNGVJSmxHdVh1Y0NITmw3Yi96TlgyTExxd0svejRpY1FPUTZoelZ1?=
 =?utf-8?B?UmZNdFpXNFc4YnpIV0hUSmphM0ExT2ppT0tTQXlVcmpBSFRoWVk0T0wrQy9q?=
 =?utf-8?B?cWdyRFJ4N1A2SUdHbGxIVkJGcXNiZHN1UWYyTTJvMVRFRi8wYlY3M1lMUkV3?=
 =?utf-8?B?ZGM3OGRxa0RKOWJXZHRUUFJ2QXFhWjBrT28yQUVBK09PdWlUaUxWZ3haT1Qx?=
 =?utf-8?B?VHBrWk40TGFzL0tZSE16blpuaEFWOEtwK2haOFRvQUhFVzR3aXJQTU12V1lm?=
 =?utf-8?B?a0tXQlFmVENVblNHcEJwUEdMZGE5dzBWTTl6ZHplUXdlcyt3M2hwMml1NW44?=
 =?utf-8?B?YTNhR2tEcE12MmlQQ3RpN01pNjZFVDFvVHEvZnJjUm5EdjdWUlRJd0JmQ2cy?=
 =?utf-8?B?WmV2TEVCaWdLaXZsTTlYd1ZaVzJZakNHT3RwY2tQTXJ0K1FhMVdXWW91bzFE?=
 =?utf-8?B?SFBFRmVYeElML0lpNTNFdkJYOStoSXN0cGtkZ0Z6bFJpT2cybDNvQm50Zmg4?=
 =?utf-8?B?M3dZRjVQbnR3SUVKMUI0b0dHcjlRZWhMc1R4aE9nNnozaXFlWWFpbmJlMVpS?=
 =?utf-8?B?R1l6a1ZlWmxJeXU1bUozb01aMGRWKzFPdENidmVuZzVycVdNdytPRGxaK1lH?=
 =?utf-8?B?UGVBNlVkbDhVdnczWTJsdU9XMlF5WmwyYWVYS3RZbDV0Q1J2aFdKMGN5ZkFT?=
 =?utf-8?B?MG9KaVJZempMYjJFNjFNNHdXSU51VGxDL0ZqR0hrY2loaDlRUVowTVpEeGox?=
 =?utf-8?B?NWErS254ZUZFejdYOHRwQzUxM0ZLVTBQcU5oN3lRVkR4ZGFaejErSWZ3UjFW?=
 =?utf-8?B?U0FiVzZnSWl4Y0FyN0Uzb1JkNFVZOHBIeCt1enNkc2gzWlFndW9iTllCOVJi?=
 =?utf-8?B?Q1YyaXRsNTZGbVVac0lrTC8zRFJSYm43bHd6S1JsTmFVdjV3K085S25RdjY2?=
 =?utf-8?B?MGxDM0ZMNmlTOHF1ekNxbzVEZ3o5ZnIwRHZOdm42bnV3cERXNU9KYk5NZUlB?=
 =?utf-8?B?LzJPeEpzRGw4dkNBY0tGQ1R5T1M4bGpaTG5nRC9XcGpKV2tSb2tTNURveXZ5?=
 =?utf-8?B?OG9ma2dhRXU1aFloZFJzS0o3N25vQ3ZtZE5sMmpoYjNkdm40N1JpL3pNQ2cz?=
 =?utf-8?B?eHNjZ1IvKzdWQVlmdkd1MG0xSE1XRTFXWFUwdVhqQ1EzZzRiU3E3QlhKVWRL?=
 =?utf-8?B?Rit0VktlS3ZFbURoL0RMdzlkalBkd25qMXdveHA5c2VPTkdBRDFFM1U0L0tl?=
 =?utf-8?B?M3JUMFFtbjBZWGlWUEZYSnpuNHBONkI5L1lCZ1pKR21DT3VpVUg0WGdQODcw?=
 =?utf-8?B?WUkrZ0k0ODdmSFUvanZEcDVEYUVVMHlBZ01ZSGQzYlBLbG9JSFdTeGVJVit0?=
 =?utf-8?B?N3QwL2JMSzEraDMxTHE3b2dRWHNsNDMwZjlsYUR0MmFKL0dVMThPeG81V2I1?=
 =?utf-8?B?dEt1U3hZSEJNUyttSHNpaGE2TFQ2aDY4SHJTamhLU3o1VHVDTDArKzNwZDF5?=
 =?utf-8?B?MUMxNUhnRnV3UHhTN1l3M1QwbDM1VWVWQlQvS2l1d2c0VTB5a1B1dldWTnVO?=
 =?utf-8?B?M2JOcUVKcjlsNThKSWNBcDBFczlMUExDM21EbmExNXFKNGNwVGpPdlZCd1RK?=
 =?utf-8?B?UDRSUnBiMitDdzdONlRhKytac0RmUnFOcU1XYWpEUU5na0NkOXlPWXBtMGgw?=
 =?utf-8?B?VWo1OVRKK2dxbStWaEtoNUZKdUxNRkh5akczMC9GYmtoZkNPUEY2dWc4K3pi?=
 =?utf-8?B?b2U4WjE3MjBURXFiQkFlaUR5QVBwbWRDeFRBdnB2MERvSVFaWmZkd0N3ZWNK?=
 =?utf-8?B?cHNMU2lkV1RLZ0RYV1hEc0svY2t4ZGRtNlRUWFhJQUtyVTlPQjV6K1RHdXli?=
 =?utf-8?B?NHkyVFBiWGpvWlJpbnoxUGxraytEVjhMK1ZZTGU2VFRPVGNrWTVmUldXbUhs?=
 =?utf-8?B?YWQ1NStWYW50bFliNklvK3JuRkZZcW10clpFci82SkdkbXgvTEk1YlpQUzRX?=
 =?utf-8?B?b2YvdFRQZ3JjVGRUc0xSZnhPL3Zzb2JFYk56QW1TcjNHT3BuK1ExODFPS08r?=
 =?utf-8?Q?bc4Y/U24LmB8W8Zw=3D?=
X-Exchange-RoutingPolicyChecked: XFFjrJ8GmrcQ6S4LUkAj660Dy+i2ss/sDtKBUNl0+b2wbZxQfR4bn06gNKFu/ipKlREUKBd7+iJSJcRkPNzpytFLLe9IUxsyYL8t/MKtVHTgZfdoHPZdtJuZqvlkWzY5OTfqwePGYPv0fj8ZG6i6dUf2vQmVXfd4WBhqGg5ulUeruTtoXkW76yxSEkM2jRwvDitmnpxtzapZ4RdTfGKgYdOI844JtZaMy6m6+pQv0THhHSvF+zKLcDWJCanTcSyJofW5Gg/ZdARB6Nww6h+qfMrP69q2iOmZ8IXtMKijHgpHinXCViig/pyRMZgV1G0nZ6P6MDRdb/IKjyxxIsfh6w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2494e13b-216e-4e3a-f54e-08debcb636e5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 12:39:52.5897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SatX+fdUGx9KPHy0pmlwgCG1vOaLKu/7s3qYKo5qitKCjPYtPNLJmRmOL/pfFtt/4sG9LDfLHjTYSVtagtmGXxvy5irq5xIdG4ofA14gnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7581
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

On 5/27/2026 3:28 PM, Bruce Richardson wrote:
> On Mon, May 25, 2026 at 03:06:23PM +0100, Anatoly Burakov wrote:
>> There are a lot of commonalities between what kinds of flow attr each Intel
>> driver supports. Add a helper function that will validate attr based on
>> common requirements and (optional) parameter checks.
>>
>> Things we check for:
>> - Rejecting NULL attr (obviously)
>> - Default to ingress flows
>> - Transfer, group, priority, and egress are not allowed unless requested
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   drivers/net/intel/common/flow_check.h | 69 +++++++++++++++++++++++++++
>>   1 file changed, 69 insertions(+)
>>
>> diff --git a/drivers/net/intel/common/flow_check.h b/drivers/net/intel/common/flow_check.h
>> index 74fb28ae3d..0572028664 100644
>> --- a/drivers/net/intel/common/flow_check.h
>> +++ b/drivers/net/intel/common/flow_check.h
>> @@ -54,6 +54,7 @@ ci_flow_action_type_in_list(const enum rte_flow_action_type type,
>>   /* Forward declarations */
>>   struct ci_flow_actions;
>>   struct ci_flow_actions_check_param;
>> +struct ci_flow_attr_check_param;
>>   
>>   static inline const char *
>>   ci_flow_action_type_to_str(enum rte_flow_action_type type)
>> @@ -271,6 +272,74 @@ ci_flow_check_actions(const struct rte_flow_action *actions,
>>   	return parsed_actions->count == 0 ? -EINVAL : 0;
>>   }
>>   
>> +/**
>> + * Parameter structure for attr check.
>> + */
>> +struct ci_flow_attr_check_param {
>> +	bool allow_priority; /**< True if priority attribute is allowed. */
>> +	bool allow_transfer; /**< True if transfer attribute is allowed. */
>> +	bool allow_group;    /**< True if group attribute is allowed. */
>> +	bool expect_egress;  /**< True if egress attribute is expected. */
>> +};
>> +
>> +/**
>> + * Validate rte_flow_attr structure against specified constraints.
>> + *
>> + * @param attr Pointer to rte_flow_attr structure to validate.
>> + * @param attr_param Pointer to ci_flow_attr_check_param structure specifying constraints.
>> + * @param error Pointer to rte_flow_error structure for error reporting.
>> + *
>> + * @return 0 on success, negative errno on failure.
>> + */
>> +static inline int
>> +ci_flow_check_attr(const struct rte_flow_attr *attr,
>> +		const struct ci_flow_attr_check_param *attr_param,
>> +		struct rte_flow_error *error)
>> +{
>> +	if (attr == NULL) {
>> +		return rte_flow_error_set(error, EINVAL,
>> +					  RTE_FLOW_ERROR_TYPE_ATTR, attr,
>> +					  "NULL attribute");
>> +	}
>> +
>> +	/* Direction must be either ingress or egress */
>> +	if (attr->ingress == attr->egress) {
>> +		return rte_flow_error_set(error, EINVAL,
>> +					  RTE_FLOW_ERROR_TYPE_ATTR, attr,
>> +					  "Either ingress or egress must be set");
>> +	}
>> +
>> +	/* Expect ingress by default */
>> +	if (attr->egress && (attr_param == NULL || !attr_param->expect_egress)) {
>> +		return rte_flow_error_set(error, EINVAL,
>> +					  RTE_FLOW_ERROR_TYPE_ATTR_EGRESS, attr,
>> +					  "Egress not supported");
>> +	}
> 
> I think "allow_egress" is possibly a better name here. "expect_egress"
> implies that egress must be present, but the logic here seems to be only
> allowing egress if the flag is provided.

No, the check right above this prevents unspecified egress *if* ingress 
is also specified. Meaning, one of egress/ingress *must* be specified, 
and if it's egress, it is only allowed when we are expecting egress.

-- 
Thanks,
Anatoly
