Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079C0FD5323
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 09:44:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2944F4027F;
	Fri, 27 Feb 2026 10:44:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 52C2B4003C;
 Fri, 27 Feb 2026 10:44:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772185498; x=1803721498;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YYb5OgxA865JD797g39glujB5FnSvK2KAXCPMkIMg2A=;
 b=WIk0HXjDbQbPPXLth1TOQva+gAacqt0chpPB8Ky/zobHXufNapH2VZCo
 8FmmH91CbhUrKzkZiXkJgC0XzjX6+E4e1EKXQEX1+3t+QTR4pUr0elkNc
 TGweMwQKUg9KIBybRSG5HVOuXIv/bcJrvwe1lDI0tzHF/MR7i0jN73D8P
 sUG6E/ZaCob/nPtIEDdbEyCSqXzzWA6a/n5z7j+DbJ6zZs+s+2dvT8LjK
 XXNeHlAUXw/TWfCN3YMtdSDnJ/L7XLz6TKYNJ/4blh+BafupeoUyQZxym
 5WdlrBKRnDVYBWz0xnyfxtJZsvy4E4IJKtTUfkIaaAAPT9gj9yl3BhQrX w==;
X-CSE-ConnectionGUID: 9l1iWy3AQQmw5E+hEQgvTg==
X-CSE-MsgGUID: HP0q+hFPRqSNETwVCSrrcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="90841645"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; d="scan'208";a="90841645"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 01:44:56 -0800
X-CSE-ConnectionGUID: 5ex4to1BSSiE3c4uBuaxQw==
X-CSE-MsgGUID: kZ+cjRbtRea7p5vWu/MT7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; d="scan'208";a="215970773"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 01:44:56 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 01:44:55 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Feb 2026 01:44:55 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 01:44:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8fuZi4jwxv2VqDpv0zVtnuxQdFL6jVQnXAQ2I2y/NR4MtkyVYpHL3PZP2wqaXi23IxTEaK5/s4qBvdgsAkF4sSRerEH/KYcGHuJALUDS4VLQvE5WuBimHQ5QioEYd7P3TT7b6p4KU1KZ9raeg/5CxIhqlDshqxyV6beTVnS+BUmbcB7nQXtu2x5dox9ZjRC+Qm9e+51IuIsaff+fAec1jcFl6jOxGZhwcxPxkeTo1H1XHjHs9XfQ4UHkvzKZNQSd9bhCWZ4AQ7sMLoow02iR05PTxU+ENnQICbR1ZLXVjwK3yqSZFKW5Waew0NS9ZFnRVRtyQmW26c2PQPmCKUmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYcJWxcDiN7+k7CYPh7dz2ylfSOnt2oqq2UyGhvGC30=;
 b=tpuZo4DKq76Yak0FFMU6urymYVC+1Nz/HaWEDzONm482QDHgMHkar067xPiDqNEgOuqojKzWc2gr/5zw4KM3WR2iP9BjMTDrS7wyBUyWvKVBR5QhhamFySzDXXb9OTApAFLZkWK987wHjrO+GV/fLyK9Wveej7ytNJQULCASR7fifLOYVrOVZ0Vf9WcflSIRbk7tM9XYSw5I1MrVa4bp+28wiJztAIOjjS9PdTQOlhGGeB1grhvNAQJdXz2Laqm0nujGU6GiXKlW5MNRznVQ+E94aHAQjHrffvoOe/5vo7pXJRuMXGtwgAp+lAp6xPLOkE2rqz69luyDx0P7iYBmYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 PH7PR11MB7051.namprd11.prod.outlook.com (2603:10b6:510:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 09:44:53 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 09:44:53 +0000
Message-ID: <a77c313f-a90b-4ccb-ad77-bf48ee5695cc@intel.com>
Date: Fri, 27 Feb 2026 09:44:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hash: fix pointer alignment
To: Bruce Richardson <bruce.richardson@intel.com>
CC: Marat Khalili <marat.khalili@huawei.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>, 
 Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 Pablo de Lara <pablo.de.lara.guarch@intel.com>, Yerden Zhumabekov
 <e_zhumabekov@sts.kz>, "dev@dpdk.org" <dev@dpdk.org>
References: <20260226142206.860737-1-radu.nicolau@intel.com>
 <cc3138af2b6d4f4ebb806db04affd487@huawei.com>
 <b28a0e99-8642-499d-95a8-a6ed30f939d4@intel.com>
 <aaCjRvcjabv2PFuO@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <aaCjRvcjabv2PFuO@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR06CA0014.eurprd06.prod.outlook.com (2603:10a6:8:1::27)
 To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|PH7PR11MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f76642-6aca-4267-01f4-08de75e4dbac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info: U5SY5BBOHA7l86CaUJyBPdav4BTOD+Pj0Z1qNSH+KN1h4f3G90JtT0IJNGmfayH3XqQEaUv3ZjRGtWvq3Wv6oRcQfxx91eE5GTS6xasLF86wkl8gFMujO17ktzuh7WLKt+iHs8j1RHDKkW6EI8KjQw22VXiF8WspkTSjNbZA74OUUACEd1v0bMIaPOBdy1aBmfy7ExWDKBTiadl/EudApdnnHup9pP/I3XsHpC6VdK8Q4mdOV2fD4LdAzf4R7MnhduvbvKhz7sm4bJSk5UlrcOjZ20c9333/naNc7Dt8T9Mt3DSUcd4ksyHREUvEVKdWQciu5yYwYmtH+SONnJJRasm8lZjFe5RkQdIybaZFHFo3Eh95wV5C57awNPqV+9C9OnC2Gk++Nm6FfIAOpAqlc1W11Zk9SQKMo2y0M8wsPiVBeTHtIQvmr8HpPgh+w7UFde8rnZKGRFdLaDa6sPLuxiOMwjx+T8rpIOrke9pcXATcuJgwGM8FoPFMUPCB4sTC3wa0gbzR21sOBgvVgZm1yFYEtAL4EED8OSXs8MGAORZMAKQ+o2Gqof5Hi9p1ql5RXXaFjvDK/TAFEGhMZJtt+zc7nCYrevDniEUpzx5NpqNK4Mokp9mgatooebb+tUuixkUtYq4rV+pYTISlUyG1oenQTZQGYkz9kIlQIib7ZYUStOyUUnTtgSqR/bg1uSXudREemt+sXnxo3yDJBK04BJ6dBlmy2HhZJnK4zgzDEmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHUwaDAvWGNoQ2RhbjNFeERPM2N0UTRick1ZaTQxYWpHdkJzUXg4TDBCOTk1?=
 =?utf-8?B?UWREVno2WlRWeG0xODQyM3Rra1ZNbTFLUWtKQm9sV1c5UkdoYXphNXo4a0xL?=
 =?utf-8?B?ZithNVl1ZU93a0wwUTlJbWNJZDNOUnpDK09lUGdkKzRRSVdqMFkzdlNCc3lS?=
 =?utf-8?B?SDUxMlhRVnNEVDM1NlBlNXhPbFY3YlkxR0tZRk9EeVF2cWhoNWIzdzhEbVdz?=
 =?utf-8?B?VE1FM1FyclI5L05wS0tQaWFpK1JtR3pCVXo5eGRxVEVxL3U4SE5qS1o4cGhV?=
 =?utf-8?B?U0NjM1NQL1g5TGRpcDViUTlScklHUi93V3hWOGc0NFZ1aWpJRUkxdGtpdTUx?=
 =?utf-8?B?T1Fzc3FJN2JUUWorUjNUb01tY01MYnZ0ZVg1RjRMZTRUWEoxTkhqN0pXOWdT?=
 =?utf-8?B?Zkd1d1JTVnpIYzRKamd3YWNSdnFPd1N1MWFHMDI4aHA1QnF4SndQOVpSd3Mr?=
 =?utf-8?B?bG5hSTIzOXNKTTVuTDFVa3d3aEVIR1VaWkZWSE1laEVOTHl3S1A2MWpmdXFi?=
 =?utf-8?B?TWExNlJ5dm81V01hbTB3MmRWeEdNYUowSCtrOFRGM2hTRFpPZjVpZHZzUHBo?=
 =?utf-8?B?U1NsUm4zeThwM2VvdTNnZUtHRDZKYTh6U0F2VU1UUEl1WjhEYlAvVHg1cnhz?=
 =?utf-8?B?alJYYnFGVUVwSklVZytWTFBQWS85aHpoMnBiRnBJRVdiUVZqWjJJMUd4SEJl?=
 =?utf-8?B?S0E5VjRITU13cE9sYnlUanNzK0dZdUJBSWNldkNsU0pLSkJ3TmYxZ1A1NlpC?=
 =?utf-8?B?YzY0Y3FPcEl5cEhRTU5RblphR3JwS3k2V2daek9aUy9oMjhUbGpteUFMQXVK?=
 =?utf-8?B?am1FemI1T0JoS0NWL2RoUDQwMjlkZ1pBblFTdUxHUHpZdWZiK0o3b0dndlMr?=
 =?utf-8?B?eG1NbkFmRSsxUVg4c3Jzd1dHWWovVm4yTFMzdzFlb1BlckxmSXlmNlJvcmFU?=
 =?utf-8?B?dml4R0hxUXZJNzZoOEhvWjVaUEtXUFBwSXJmeFFoTWgzTS9yV0RjcGRvYkpV?=
 =?utf-8?B?NUxKelRZQityNHNOQVRjK3BBWjZvV3FwSkp2TnpPcndMR1U0c1N1VWRCUnRq?=
 =?utf-8?B?TjZwVWxDOTA5cTVLTFp3K1Z5eVRVb0dXdWV5YzdOSVN4Skp3aDlnMmhLd3dZ?=
 =?utf-8?B?SG1kNGRTZ2k0WEsyY0NmOWRmUDN0d3NQcC9YRDJwZWd3V3NhSjUyMmEydjFU?=
 =?utf-8?B?ZDc2Y0xwWFoyRTRBdVNiRHFwWittelFtNVl3TWJUMHN3RGFkYjYyb21RNm5y?=
 =?utf-8?B?aWdSSi9wb0JBd1E2RVdOK3lIeUVzZ3JQRVVvd2JML2d2K2duUWVhMWU4T1VY?=
 =?utf-8?B?YjdZME9ENncveTBTckxtSDRNTXlMZWxQeWUxdlRLcjUxVzlTRTJ6dk9mRzVM?=
 =?utf-8?B?emFsSEVlNFpkd2NPc3l0ZmcyNXBjR2ZqT2xMaXlwcXJUYWFnVGhZWnVySFZz?=
 =?utf-8?B?c1VjbHlDSXE0OXN3RWloTy95a21oUXd3cGQvODNreHFmUTdnc0VUWkRFV3Fj?=
 =?utf-8?B?bi9pV240T3J4SC9FUmFqVWZScnM1c0FQZWZvSlBvTzgzdGFZazlIdHBmdXJS?=
 =?utf-8?B?SERzVE1rN2ovQnBidzBxU0E4ZDFNWEptZWNGenh4bDMzY2NweFVUZm1mMUx3?=
 =?utf-8?B?Uk9FMFh6Mk1IMXFIelRBSE1WWmNBd0FBamZzMXZacUV0ZGN0OW84dnYrRXht?=
 =?utf-8?B?aEZDcjU0WjhGU3FpOVROcXpYTTByNEZDNzFTeEpRODJmY0FjYWJ1Ym4wa090?=
 =?utf-8?B?dXI5b0ljYkF0eGpuRWdWcHBWZFowckh1M2E4dS9hb0pyaGc0aUgxNXlVZTJk?=
 =?utf-8?B?UVpPK1lIeUpGSmJBMHZuNUxxd0dvTFhZdjFlVm5BUmozam9SNHVmT0xUTHhw?=
 =?utf-8?B?bVBpRitPL0xpTk9wKzZZdTVRWENUUkdYcG1RS1J4L2pZdnR2aEQ0enN2VVo4?=
 =?utf-8?B?RVh4eEdISkJLOFR3Y3AxY3hSUmlPbUJiQzlUUGI0SVdocGQzQVZDOU9FdHkx?=
 =?utf-8?B?SmpKMDJXTUxaYmx6YVdKR2Rhd085MkF6di9HdGc3YWc5TkgrcVJRL2phQjRX?=
 =?utf-8?B?N1pvRFVFazZ5QUxIRmFUQzQ4SDYybVBsWVNEVEdPUXFPL1RGZlpVOGwzOVo4?=
 =?utf-8?B?VlhnbVZVTXVyMzU3WXlzMWt6aEhnalFoNmxwU3h1M0FuajBCWnBBRHV2NFhx?=
 =?utf-8?B?c1NMS21CK0w0VHN6Wk4xWThQQ0lhUHhlYlRMN21oQVJFSmFCNjBLc2g0K0JC?=
 =?utf-8?B?eE5WbUppZFpLb3lTNzY0cnRnWjhoMHBvb1JQaFJlNklkY2RrUW0vQStMSHF5?=
 =?utf-8?B?Y2h6UGdHaVlJZjVyL3dESUkxVTBIM1djYlpHelhLRU9qS0I3MWpmZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f76642-6aca-4267-01f4-08de75e4dbac
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 09:44:53.4204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ge7sNb+rWnfUJOaxKxXL6+LR61mslagpcJzgowHCfWsbaQcbs45Ecbu8Htr9UuieCs+Cc6yKKqdRJCHmg2taw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7051
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


On 26-Feb-26 7:47 PM, Bruce Richardson wrote:
> On Thu, Feb 26, 2026 at 04:43:26PM +0000, Radu Nicolau wrote:
>> On 26-Feb-26 4:22 PM, Marat Khalili wrote:
>>>> diff --git a/lib/hash/rte_hash_crc.h b/lib/hash/rte_hash_crc.h
>>>> index fa07c97685..66f11fafcd 100644
>>>> --- a/lib/hash/rte_hash_crc.h
>>>> +++ b/lib/hash/rte_hash_crc.h
>>>> @@ -127,6 +127,24 @@ rte_hash_crc(const void *data, uint32_t data_len, uint32_t init_val)
>>>>    	unsigned i;
>>>>    	uintptr_t pd = (uintptr_t) data;
>>>>
>>>> +	/* align input to 8 byte boundary if needed */
>>>> +	if ((pd & 0x7) && data_len >= 8) {
>>> Perhaps the case data_len < 8 should also be included, with each of the if's below checking and correcting data_len individually?
>> No need to include this case; if data_len < 8 it will skip the for loop and
>> fall through those 3 if's, and get processed there.
>>
>>
>>>> +		uintptr_t unaligned_bytes = 8 - (pd & 0x7);
>>>> +		data_len -= unaligned_bytes;
>>>> +		if (unaligned_bytes & 0x4) {
>>>> +			init_val = rte_hash_crc_4byte(*(const uint32_t *)pd, init_val);
>>>> +			pd += 4;
>>>> +		}
>>>> +		if (unaligned_bytes & 0x2) {
>>>> +			init_val = rte_hash_crc_2byte(*(const uint16_t *)pd, init_val);
>>>> +			pd += 2;
>>>> +		}
>>>> +		if (unaligned_bytes & 0x1) {
>>>> +			init_val = rte_hash_crc_1byte(*(const uint8_t *)pd, init_val);
>>>> +			pd += 1;
>>>> +		}
>>> Shouldn't the order be the opposite?
>> As long as we process the right number of bytes the order doesn't matter.
> But if we reverse the order we get more natural alignment. If the data
> pointer is off-by-one, e.g. 0x65, and unaligned_bytes == 7, if we do as
> here, we calculate the 4-byte version and 2-byte versions with 1-byte
> alignment of the data. By reversing the order, we would do the 2-byte
> calculation on 2-byte aligned data, and the 4-byte calc on 4-byte aligned
> data etc.
Yes, that is correct, I will send a v2.
