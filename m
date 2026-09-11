Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05C6C88E50
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 09:37:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95B6440269;
	Fri, 11 Sep 2026 11:37:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 1C26240264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 11:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789119440; x=1820655440;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ivHMvPumRllhkCbtAPSHrK9Lzmkx8da+vmzBAxFpjYU=;
 b=fSxKbUvhFfQGGEC046XnIEOd+FZAIgAC+0vLdzcfZs5JEUPCyRH1Pkn9
 SbSlKBtBulwHk1aYyHbt7I/K1MQ3YGuyy/CrJ0xTF3N64J0I5y9WGHXmP
 DcfkzmG0SuxU+Von+a++kjd5kEdrUh6ZPSDslXEX3oPy1ngGECmfVaETU
 TGM7OAtCfrMRbPAv/tNBUkMRVmQd654gcPX4J5opP8sJPRLmhpJc2Fiv2
 VyyPXQQqj9//GSM+XSU21vyB+aItrZJ1oxXRDE7ejk3B30P06sc8umdkO
 E7pHdInNRVmmsLewNXTBIJX2YsbjHlwSroYzj6GhRCb5qfvwZhA4bLtIh A==;
X-CSE-ConnectionGUID: HZZ1TFgASkWS+8qMjHkPsQ==
X-CSE-MsgGUID: Hb2/VcifTbe0XeIcH7tP2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="100243150"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="100243150"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:37:19 -0700
X-CSE-ConnectionGUID: tZV+o5DHRN+S5pvLmfMPTA==
X-CSE-MsgGUID: ueXbdbSVRoiyy+1WWIpBDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="272380143"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:37:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:37:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 02:37:17 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.56) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:37:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuM/ZQqHNO8Qa/GT0uC1YmuWb/XiqQioRz+KIxffpZoZmQws1XIRHffhmI3KnQldpErHQ40JM93e/CwtF9hw3LWL3X4FsIylJ+XcZSIRamlKJs8nm28Az4/vizymCo9sJVMwoaU6qWHtMiGzXOrdFG/np8UttciQl+sBym7RbWh7sSiYurFoIm5mWf4YcJ0C6Aw8ID5R3mNTmrQmVJq1zWCm0LjVunB1jwfWdtpjfgfZWfBOEXXGyJPddLG0JvWdX3Wr+oXMGufpCBLgZjMgIiTchgxrpoquVh8y+EkAZyFk/AVHhokeY+lu+p14qLs1LELS9ild6dJWwBD67XMU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HW+C7tgR6o6pp9LN7zYV0k4sYFnihPDPnlPtKgLWlvU=;
 b=dsiaYatq1CKofX0coc5PC/1tNXlPhAnelawfrNAqs+bj8RbboRDcmUDkFRf0ECExb/niUAjk+iJtulxSr647FG+8ElF0JN4mdu3P/PU0wxbjvb5vtK8+e8FjzlBGAkkVXFbzlI42OoVUWVNXT3aJl78jK2UsaLLXvQ94D2Awg9uBJdlbLd1cCJFcx+xc5g0DK9DX480JLQC1YQIb+Orty1U+I7bVcXY+I15wRUMGaYbV2UnZuvMj5f4fjrOUB2B9INIEwk59N9bdfDDIxLUlaA2muG0Z6yuuzWkKoeMzTFCVBzmovHy6dUG1m14uzcRSCw+8/2lkUmz5Xbgx4cktyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ1PR11MB6154.namprd11.prod.outlook.com (2603:10b6:a03:45f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.9; Fri, 11 Sep 2026 09:37:12 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 09:37:12 +0000
Message-ID: <67d60d81-2424-4666-b05f-127647157bc4@intel.com>
Date: Fri, 11 Sep 2026 11:37:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] net/iavf: accept up to 32k unicast MAC addresses
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260904122804.2256481-1-david.marchand@redhat.com>
 <fa883da6-5491-4b9f-8382-9102045427c8@intel.com>
Content-Language: en-US
In-Reply-To: <fa883da6-5491-4b9f-8382-9102045427c8@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0217.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ1PR11MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: fad3a96f-0a1f-407e-b8de-08df0fe841d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|6133799003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: kMimfWPCxjiutZX4J6qV4UV4G0LE0U6Ia12vX+l4hWyif3Y9baOMTajmy4wyotYngsfAMwlgECPH8j2OOIw22FQAzJ4LQQMGap1WcyqihwWXRHfbZ2zEvqxV8/a5+++QdFmF/YIkhseZtNVBiU4LsPt9hnDAhsvX+mLrQ1lBDzSug/9RS/5ezdabcY8lpFBXRh11bJ4Jgt3Bv98UQDcNAacJBUauJfDsepjEMPZgt8fqBLSizbSQQZyuoOM+R4WoAcRCiAfeKS6riWnGJaUSYMYCmMuYfbCWuK0c/8rDkugRtSmuVilUjfg16b7fkIegqEYkL/iLA48KKhn2J1ktzbRfz2U1jFglYASEc6ROeb8yZmjPnjxUdg9hwKWr55iEzMbmmr/e7/QzE4QMfMiqpf5+ZYt0BwhKJBwD0w0301/Z63aNB1La9aTCuqMx1zCpX+tpg7SmSBDNR4ZqmTyHsS4ojBXHbciX3Q6Tkt5urGrHIk8BFAGH+G9qMswV13aI9adADpyNnRrhbfFzsK7AYvjgeq0KUozph1gQXG6MAStU2f++SylJ6uocie0RYDB2K2XYrx947me8I66iX16Rz6MCRfddSBujbc58SQes04nV819raLTA0kGgd7fbFkLp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzhVYi83cEc0a0dOWmx4THdYbmVpWWtXbmVMY2x3SDFBdmdEMytKU0FwbXpS?=
 =?utf-8?B?NW9TdkU3T2dSc0toQTlVVUYwMFU4NjVOc2IwZVNNVXZMVEdVdHo5cmVUTkhB?=
 =?utf-8?B?YVU5RU5acEtpSHdWRStmVmY1NkowV1dIdDJTUUdIZFhJNFBZWHZxMjNqK0V3?=
 =?utf-8?B?RUk5eUYvdWdEWTRMYUg3MDNGWWtoR0dHZVltMjZtWTNxcE1qT0pTbzF6TXp2?=
 =?utf-8?B?clJaMkRycHU5SVkwbFhwOFNTb1g1YUZpc1hvQkh6TkxsemEwQnFtWDZSdXBw?=
 =?utf-8?B?R3gyUVVnMHFUKzhqWXRjWW5Ud0g5OHVSOXlsRWdXejZaaHhFOHBuNlBZS24y?=
 =?utf-8?B?Y1RPeHZMVnEyQmlnVldqSDY0OWs3TlZVK1FSWmpUaUZyS05qQUlka3JydmxQ?=
 =?utf-8?B?REZjVUpXQjJjYkVFNm5JY0VLNTVHblpwRXRBM0VzRDVwVXJXcDZIelpiWVlL?=
 =?utf-8?B?L3NtMndKMXRUSWd5aHlFZ2ZMUHpUc0lLMzRLa3NhNWNPVXhicTYwWjJvQWRV?=
 =?utf-8?B?ZysyTmZ3ZFRsUHM1emxaWHhWbkhoandwdTBGMGloMVduNTc3c0tWb0E0aWJt?=
 =?utf-8?B?TnBHK3pUZ1VvSUhFdHdJK3Ryd2cxeUhDRDlON1FxUEwxdG80WGE3MTBKVkpC?=
 =?utf-8?B?RVc5L3FPM291c0hxQ3VNeW5NNStjYWgwUk44Y1RGamViYnowWUpNV1hVc2Iy?=
 =?utf-8?B?SWxDR2lGRjc0OXJqaU0zWHlLWEdCd01GdElHbmdLNUhUWXRxeWdHV080UzM3?=
 =?utf-8?B?ZUp5T2FNdGZwRHV3OTBESXI5RjhWakE5YjVpTTU3a29oNFo5M3RFS2c1akx4?=
 =?utf-8?B?WXVKOFZ2bmtvR2J1OE0vMHRrUDJVckNKRDRmSGd5akJQSEFIcXhuSnJ4cEs4?=
 =?utf-8?B?eS9tQ1c4aE5TVlBVNXJibnMxcXhIWUxYYzRSUTU2QmE4ZDVZY2x5MjdIM3NS?=
 =?utf-8?B?aXpraysrUUdKRnRvTm0wam9Kcmtld2xyNS9uaXkyNHZKSytFeEZwWjVYTTJT?=
 =?utf-8?B?ZUZhb241TEZLbVJnUHFCNmhtWkpycVVZa3JCalpTc25admMwR2grQ0tRV3JS?=
 =?utf-8?B?QkdJaG9EZmV1Vyt5enVOUWp6dFo2aUszMG0rZCszMnhqdUFSQXJ6UUZiM2dI?=
 =?utf-8?B?RGU1L2F1STZDa2h6bzFDenRRbWE0bGZMakg5cTgzc3dGUzM4bGtQWFFyTm5T?=
 =?utf-8?B?enNWSG1lNndxVkJxL2RSUC9adnhPYmlTd1VRSWVFQi9ZNGNJSXl2R3NlNENB?=
 =?utf-8?B?YVhkZHJjSG1STjBOb1Fyd0NCYkRoVmZXdkRCaDgzN2NPNCtvMVoxMzBqVjZm?=
 =?utf-8?B?RlNFWVM3Yk14Nm53WEppOWpJTWN1akRlRGxnYWtsbWlFRWN2SWpjcURIOHpQ?=
 =?utf-8?B?cDNaY3dHNzlHa21pY0dXZFcyT2RDaTF2WS9XaGZUZUZCWmxjUFpqWjdWTnFK?=
 =?utf-8?B?aytSd3E4N0xyUmoxdXo3SGsrS2pzVUNiekNjemFCN05qSFltZDBLQU9sNVJp?=
 =?utf-8?B?YUt3bHU2bjlxT29BS2pBNjhVWkhJeUxwVWdVLzh4MjU3OTZRMTdrbUc1WXRS?=
 =?utf-8?B?MEtGMnNmY3VhdGtXbENLZUR3ZFRRUWwwNVJJOEoyNFZpN1o3UnZ0Rzh3bzJ4?=
 =?utf-8?B?WE01bHhyZ29Zdmp0dUppeS9DUG1JWlp1SFlGelhhL0d0emhPalVoQ1JxSVhr?=
 =?utf-8?B?NmFBdVpGbW41QzVYQk91b0hSWXU2ZlYvVS9kcDJuZlFKTDZpTW5FenpyeXBG?=
 =?utf-8?B?VUMrU2tja1E2dTNFaDRVUGRlcktaMUxNbmVkWEF4YWdkVnNodlNGbTJ3U2l0?=
 =?utf-8?B?ckhOUkJVMkpGK1FaaTdULzNadmtBRlRmLzhXQnRXYmZhZVFWY25LZk5TbE1U?=
 =?utf-8?B?NVlTWCtGdmZuVG9CL2dTa2U4L0FFOG55Rm8yK1hta3kvd0FncTVxVjQvQW1v?=
 =?utf-8?B?ZmNUNXY2azNhNTFvZW8zOVFyTENsYkp3Ull4UXp5OGlRVWxob1greGttYXI4?=
 =?utf-8?B?UWd4SDlrNU5xQkxobHc0eFowdlZWM2RRYUNlSS9yZ2FIQzNkOXQ3b3JLZXBL?=
 =?utf-8?B?cENjU3hib1l1QnMwMWNLOHJ6MDF2WG04d1JGYWpJV0VNTnNWdUZEamFkdHhv?=
 =?utf-8?B?WXZybmNqWGFhMi9mRkFzbnB2MUhodStKaThsWEhhZ2NOaitleWxUYTR4NHY2?=
 =?utf-8?B?dlRNN28ybkttZ2lRMUVrT1JyUnA1anNpSnR0cmNEN3VLYmJLakh4ZHVPenE0?=
 =?utf-8?B?R1hSNUdaM1hDSUNxNndPd3ByeXNMeTNFd2Y2TVNiRUlBWjJaYnRmK2w1RTNi?=
 =?utf-8?B?U2ZIaVN6cmRsLzVZU1p0TTNPSVlnRzJIdDZDUWJWWld3ME9zbkdVZkFHMVlI?=
 =?utf-8?Q?AQBstZxiYJpYhfyQ=3D?=
X-Exchange-RoutingPolicyChecked: D0S6rv3x2pvsuBPf7DFC0HzykH9goR9boiDX4TLKoZKhGLvLTstgeCCqLAmRICWaT5d3Y4h+Jj8xyipBEFfzQVa69mqp6wkSKtc5rlfGPH60+gT3B4RmIitAcIbDOnMgDl6rHvvmT0tHvHXf829iNt8Q+02JbVOfuZMzUcAkg2yeYj2KjrcetmJkiNw9yWkcJdiN/s3MnWd5cM8jW2U84c/oywMQX6Na7lTSAZEWoY8HV7WS/5+lC29+aEqJMeJn2B3d4wViau4OwRrYI4d+ls+7WgpV8ntDn4Wy5ZuIILS8rreiDx/8SLw98yEcjePClAKaOZHcer/Ipv9/BMny+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: fad3a96f-0a1f-407e-b8de-08df0fe841d8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:37:12.4929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZoMDx1KFzVYR9+G1joQZW+93/bzn7H3xPSM4kCaB8C80ljcCPBnmt9c5YKej2sC1WjYznfeZ1RpFLK/vEXnKqU+M7ou67AGcxvAeg1kfHz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6154
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

On 9/10/2026 12:24 PM, Burakov, Anatoly wrote:
> On 9/4/2026 2:28 PM, David Marchand wrote:
>> E810 hardware provides 32k switch lookups.
>> Thanks to this, it is possible to allow a lot more secondary mac
>> addresses than what is possible today.
>>
>> In practice, the maximum number of macs available per port may be lower
>> and depends on usage by other (trusted?) VFs on the same PF.
>> There is no way to figure out this limit but to try adding a mac address
>> and get an error from the PF driver.
>>
>> Mailbox exchanges are limited to IAVF_AQ_BUF_SZ, segment messages
>> accordingly.
>>
>> Signed-off-by: David Marchand <david.marchand@redhat.com>
>> ---
>> Changes since v5:
>> - separated from series that went in next-net,
>> - rebased,
>>
>> Changes since v4:
>> - rebased,
>>
>> Changes since v2:
>> - added an entry in release notes,
>> - removed unneeded temp variable,
>>
>> Changes since v1:
>> - fixed buffer overflow on mailbox messages during port restart/VF reset,
>>
> 
> Hi David,
> 
> <snip>
> 
>> -void
>> -iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
>> +static int
>> +iavf_add_del_uc_addr_bulk(struct iavf_adapter *adapter, struct 
>> rte_ether_addr *addrs,
>> +              uint32_t nb_addrs, bool add)
>>   {
>> +#define IAVF_ETH_ADDR_PER_REQ \
>> +    ((IAVF_AQ_BUF_SZ - sizeof(struct virtchnl_ether_addr_list)) / \
>> +     sizeof(struct virtchnl_ether_addr))
>>       struct {
>>           struct virtchnl_ether_addr_list list;
>> -        struct virtchnl_ether_addr addr[IAVF_NUM_MACADDR_MAX];
>> -    } list_req = {0};
>> -    struct virtchnl_ether_addr_list *list = &list_req.list;
>> +        struct virtchnl_ether_addr addr[IAVF_ETH_ADDR_PER_REQ];
>> +    } cmd_buffer;
>> +#undef IAVF_ETH_ADDR_PER_REQ
>> +    struct virtchnl_ether_addr_list *list = &cmd_buffer.list;
>>       struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
>>       uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
>> -    struct iavf_cmd_info args = {0};
>> -    int err, i;
>> -    size_t buf_len;
>> -    for (i = 0; i < IAVF_NUM_MACADDR_MAX; i++) {
>> -        struct rte_ether_addr *addr = &adapter->dev_data->mac_addrs[i];
>> -        struct virtchnl_ether_addr *vc_addr = &list->list[list- 
>> >num_elements];
>> +    for (uint32_t i = 0; i < nb_addrs; i++) {
>> +        struct iavf_cmd_info args;
>> +        uint32_t batch;
>> +        int err;
>> -        /* ignore empty addresses */
>> -        if (rte_is_zero_ether_addr(addr))
>> -            continue;
>> +        batch = i % RTE_DIM(cmd_buffer.addr);
>> +
>> +        if (batch == 0) {
>> +            memset(&cmd_buffer, 0, sizeof(cmd_buffer));
>> +            list->vsi_id = vf->vsi_res->vsi_id;
>> +            list->num_elements = 0;
>> +        }
>> +
>> +        memcpy(list->list[batch].addr, addrs[i].addr_bytes,
>> +            sizeof(list->list[batch].addr));
>> +        list->list[batch].type = VIRTCHNL_ETHER_ADDR_EXTRA;
>>           list->num_elements++;
>> -        memcpy(vc_addr->addr, addr->addr_bytes, sizeof(addr- 
>> >addr_bytes));
>> -        vc_addr->type = (list->num_elements == 1) ?
>> -                VIRTCHNL_ETHER_ADDR_PRIMARY :
>> -                VIRTCHNL_ETHER_ADDR_EXTRA;
>> +        if (batch != RTE_DIM(cmd_buffer.addr) - 1 && i != nb_addrs - 1)
>> +            continue;
>> +
>> +        memset(&args, 0, sizeof(args));
>> +        args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR : 
>> VIRTCHNL_OP_DEL_ETH_ADDR;
>> +        args.in_args = (uint8_t *)list;
>> +        args.in_args_size = sizeof(struct virtchnl_ether_addr_list) +
>> +            sizeof(struct virtchnl_ether_addr) * list->num_elements;
>> +        args.out_buffer = msg_buf;
>> +        args.out_size = IAVF_AQ_BUF_SZ;
>> +        err = iavf_execute_vf_cmd_safe(adapter, &args);
>> +        if (err != 0) {
>> +            PMD_DRV_LOG(ERR, "fail to execute command %s for %u macs",
>> +                add ? "VIRTCHNL_OP_ADD_ETH_ADDR" : 
>> "VIRTCHNL_OP_DEL_ETH_ADDR",
>> +                list->num_elements);
>> +            return err;
>> +        }
>> +
>> +        PMD_DRV_LOG(DEBUG, "executed command %s for %u macs",
>> +            add ? "VIRTCHNL_OP_ADD_ETH_ADDR" : 
>> "VIRTCHNL_OP_DEL_ETH_ADDR",
>> +            list->num_elements);
>>       }
>> -    /* for some reason PF side checks for buffer being too big, so 
>> adjust it down */
>> -    buf_len = sizeof(struct virtchnl_ether_addr_list) +
>> -          sizeof(struct virtchnl_ether_addr) * list->num_elements;
>> +    return 0;
>> +}
>> -    list->vsi_id = vf->vsi_res->vsi_id;
>> -    args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR : 
>> VIRTCHNL_OP_DEL_ETH_ADDR;
>> -    args.in_args = (uint8_t *)list;
>> -    args.in_args_size = buf_len;
>> -    args.out_buffer = msg_buf;
>> -    args.out_size = IAVF_AQ_BUF_SZ;
>> -    err = iavf_execute_vf_cmd_safe(adapter, &args);
>> -    if (err)
>> -        PMD_DRV_LOG(ERR, "fail to execute command %s",
>> -                add ? "OP_ADD_ETHER_ADDRESS" : "OP_DEL_ETHER_ADDRESS");
>> +void
>> +iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
>> +{
>> +    int start = -1;
>> +    int i;
>> +
>> +    /* Handle primary address (index 0) separately */
>> +    if (!rte_is_zero_ether_addr(&adapter->dev_data->mac_addrs[0]))
>> +        iavf_add_del_eth_addr(adapter, &adapter->dev_data- 
>> >mac_addrs[0], add,
>> +            VIRTCHNL_ETHER_ADDR_PRIMARY);
>> +
>> +    /* Process secondary addresses in contiguous blocks */
>> +    for (i = 1; i < IAVF_UC_MACADDR_MAX; i++) {
>> +        struct rte_ether_addr *addr = &adapter->dev_data->mac_addrs[i];
>> +
>> +        if (!rte_is_zero_ether_addr(addr)) {
>> +            if (start == -1)
>> +                start = i;
>> +            continue;
>> +        }
>> +
>> +        if (start != -1) {
>> +            iavf_add_del_uc_addr_bulk(adapter, &adapter->dev_data- 
>> >mac_addrs[start],
>> +                i - start, add);
>> +            start = -1;
>> +        }
>> +    }
>> +
>> +    if (start != -1) {
>> +        iavf_add_del_uc_addr_bulk(adapter, &adapter->dev_data- 
>> >mac_addrs[start],
>> +            i - start, add);
>> +    }
>>   }
>>   int
>> @@ -2304,7 +2353,7 @@ iavf_add_del_mc_addr_list(struct iavf_adapter 
>> *adapter,
>>       struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
>>       uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
>>       uint8_t cmd_buffer[sizeof(struct virtchnl_ether_addr_list) +
>> -        (IAVF_NUM_MACADDR_MAX * sizeof(struct virtchnl_ether_addr))];
>> +        (IAVF_MC_MACADDR_MAX * sizeof(struct virtchnl_ether_addr))];
>>       struct virtchnl_ether_addr_list *list;
>>       struct iavf_cmd_info args;
>>       uint32_t i;
> 
> I would have preferred it if the caller managed the chunking, not the 
> "add_del_addr_bulk" function. There is precedent for this style of 
> refactor already [1], and I would like to keep things consistent - keep 
> the loop simple (without memsets etc.), and make the caller manage how 
> many addresses are being sent at once.
> 
> [1] https://patches.dpdk.org/project/dpdk/ 
> patch/5e6a55afa2b45e3ee5ec17af7a6c548c96e9698b.1771945933.git.anatoly.burakov@intel.com/
> 
> This specific refactor is more about removing rte_malloc, but it does 
> also reorganize the loop in a way that I find to be more readable.
> 

I tried prototyping a loop, and realized that the fact that MAC address 
list has holes in it is making things a little difficult, but here's 
what I came up with as an alternative implementation, I think it's a 
little clearer:

```
#define IAVF_ETH_ADDR_PER_REQ \
	((IAVF_AQ_BUF_SZ - sizeof(struct virtchnl_ether_addr_list)) / \
	 sizeof(struct virtchnl_ether_addr))

struct iavf_eth_addr_cmd {
	struct virtchnl_ether_addr_list list;
	struct virtchnl_ether_addr extra[IAVF_ETH_ADDR_PER_REQ];
};

static int
iavf_send_uc_addr_list(struct iavf_adapter *adapter,
		       struct virtchnl_ether_addr_list *list, bool add)
{
	const char *opname = add ? "VIRTCHNL_OP_ADD_ETH_ADDR" : 
"VIRTCHNL_OP_DEL_ETH_ADDR";
	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
	struct iavf_cmd_info args = {0};
	int err;

	args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR : VIRTCHNL_OP_DEL_ETH_ADDR;
	args.in_args = (uint8_t *)list;
	args.in_args_size = sizeof(struct virtchnl_ether_addr_list) +
		sizeof(struct virtchnl_ether_addr) * list->num_elements;
	args.out_buffer = msg_buf;
	args.out_size = IAVF_AQ_BUF_SZ;

	err = iavf_execute_vf_cmd_safe(adapter, &args);
	if (err != 0)
		PMD_DRV_LOG(ERR, "fail to execute command %s for %u macs",
			opname, list->num_elements);
	else
		PMD_DRV_LOG(DEBUG, "executed command %s for %u macs",
			opname, list->num_elements);

	return err;
}

void
iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
{
	struct rte_ether_addr *addrs = adapter->dev_data->mac_addrs;
	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
	uint32_t idx = 1;

	/* Handle primary address (index 0) separately */
	if (!rte_is_zero_ether_addr(&addrs[0]))
		iavf_add_del_eth_addr(adapter, &addrs[0], add,
			VIRTCHNL_ETHER_ADDR_PRIMARY);

	/* the secondary address list is sparse, so gather it into full batches */
	while (idx < IAVF_UC_MACADDR_MAX) {
		struct iavf_eth_addr_cmd cmd = {0};
		uint16_t nb_addrs = 0;

		for (; idx < IAVF_UC_MACADDR_MAX && nb_addrs < IAVF_ETH_ADDR_PER_REQ; 
idx++) {
			if (rte_is_zero_ether_addr(&addrs[idx]))
				continue;

			memcpy(cmd.list.list[nb_addrs].addr, addrs[idx].addr_bytes,
				sizeof(cmd.list.list[nb_addrs].addr));
			cmd.list.list[nb_addrs].type = VIRTCHNL_ETHER_ADDR_EXTRA;
			nb_addrs++;
		}

		if (nb_addrs == 0)
			break;

		cmd.list.vsi_id = vf->vsi_res->vsi_id;
		cmd.list.num_elements = nb_addrs;
		if (iavf_send_uc_addr_list(adapter, &cmd.list, add) != 0)
			break;
	}
}
```

-- 
Thanks,
Anatoly
