Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D355C606AAC3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GQbrEE6C
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 329B8402E8;
	Mon, 19 Oct 2026 17:53:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id C3CE140298
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:53:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792425195; x=1823961195;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QqHMw6RuUIHdWp88yUei5Z/F5k8h6aQY8VsFB2BfnrU=;
 b=GQbrEE6C7KN6gdBBn5u2LZZAMDyHpO2Df6A4UhdHj9MxpnvtxjCu3CVZ
 1gOMsddez1caCIe8LrP9qs3CU0wl+lPFcc9wFBG6DAXz90xai0u6vry9p
 0nlwtMsnCjNoGkiE1Dqh4JJs6d1wB7GQxqlyJMlxUfkQ0H/EOTx4L7O7q
 wOUe+Syt/QyIVkZevoWcxN+fRY/M3MVU71vVyXSjCe3qQT4E+d+3zn+rX
 d0O59idJ6GVodu2uNxD4iapkT6FB0VsfRKMDs0bHBi6JQwMvlOgDBCQAc
 yqgbvRI5tTUO1BRRK95WTUsEJ1mYyu3yRAAm84cGIai/bG+k5VP+WqFJN A==;
X-CSE-ConnectionGUID: H7mwIDXOSEmVxDYO1wLqyg==
X-CSE-MsgGUID: 90wqSb0uQP6uG7Kj6JBaIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1005597"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1005597"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 08:53:14 -0700
X-CSE-ConnectionGUID: 23Ft+4h5T02PmNDhHM6ngw==
X-CSE-MsgGUID: NIq5rs8MQK2vnkLCcK+TLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="3036661"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 08:53:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 08:53:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 08:53:12 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 08:53:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmXMAs22A162+aARJbzty6g2sdzG+nh01g5p/4SeTq5NDOSWqiqJlXvKCIpN01SeoDlvN05ytJJ9DYG16e+5/OqZ4aiYk1fivUHwWN4V2KDjDcDEUEAfiAZNt9/ZIzH6EstIZ5RvSEZSZIuhIN/dSyb7lFC7zrPcmG2VBV7CBXEj9gkQEG3t2003KaGQb+k62lOcyV3XWpg4ZRBDUdx6eCINBS3G5u243mT2A1UCWIHV4f5dnrRHaHfby0E3WlJCSA/v22RPe/ZUEx3DY0q23+kGTRuSlKS54na7HBx7sltGMvh08b1rrNkkiCYMtKUS6fis7MJsgI+1LHk9cQ3dYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ad+b6DExlNoebGTIuy7EQ0SIMcJC+4/cPUah4nZESlk=;
 b=s+QEa0p8x0ELZJsD1HtOyNSNQ+eas2pjjeV9POnnRJp50MC5vWKyWGAKubNWs8Y3n+OHXQr1Ic33d8jDjjqGZhV760Rf0/k1g5OXb8ZruBhVTRyM0ewslWD7CYL+PYMhJZnKaYImIdEVmyIENheBmkqRDWKOY7I775pvpZKFPG/LFSRatxqy+GZkp2ndCoG4xqyFcGE5bUchF4MjyhbfVHou3Brmyb06CRSTJl7E0O9+LzvbLi8x90D8rcx4vbOzEtQ98V/S+zASL8EXjMf21xai6pKyoCsQR4xtWwZ8KkNq2omuNsHdKSzBnRAIWjhzTRMWfExiitT4Aab7DCoObA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 LV0PR11MB032640.namprd11.prod.outlook.com (2603:10b6:408:60c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 15:53:10 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 15:53:08 +0000
Message-ID: <03c3bfc6-0f94-4f80-ac4a-e818de9f08ee@intel.com>
Date: Mon, 19 Oct 2026 16:53:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] crypto/ipsec_mb: add support for IPsecMB 3.0
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Kai Ji <kai.ji@intel.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
References: <20261012135947.1895429-1-radu.nicolau@intel.com>
 <8OA9ksWHSu-USgHcEeFFXg@monjalon.net>
 <18b34f38-6961-42e1-a828-ca60035a11eb@intel.com>
 <uyjFhmv-QzKanl-x0A8T0A@monjalon.net>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <uyjFhmv-QzKanl-x0A8T0A@monjalon.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0301.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::6) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|LV0PR11MB032640:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a7b7e3-b9d4-458d-4c6e-08df2df9123f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: a+rwGzjNJlpncpi7QHIGQ81FBjDMpNwnq2ZQCK9XZ+DcOHOfwJ9KUrJBGBMjUyuc9IXTsyxqSpNpxpvFPOlLw7SmCazUEN7lFYPTiGiHhs0bYVEfwngMckhxcI9V3j+eQdLraZ88QhOawrbSDkgMTqJnMOso9c4AlfBP/FnreM0Sx/PY5K52YXtJbTfY4ppgA3wMw+CTFCE0Z0qSLA7iTGF2fI5M3Hymlk2xCMUw19CZQF9+2jpxG0E7+pIuBhH87EhgBbHyPJwxs2HCKvFFWtZzGXWkbNxdCnz4vKZuZJc8vxLQdFbps4Y6KnhTPddkf9QXvmlod69OtRHiE9Onmrd+dggBJ9LnmfXZnSEZLYYukUW1Pb7l+EwTdLrs2BECyZPvLqgDlmYcuBGfW2Nf0Zs4DN0M5bJrUi+nZVXncjY8w6x7ibmFN++deOuaeDJxIu6ARc/VmW/bdNfdRVZghj2e6dOpeCHrzCsV3yYAwOlT57S7Q5Mj4VIF4XIrCHOWjeDiXVzURXWxEvcRi33cQ4rm6JxjE46kpaGbx3ZgiTIdgDiolpLRq0GbSr/RWEaCcbzfdRoxVXFuhcCTU3pC2fprqn23o4shgJV47I7+gyTuJ5fpMXvGh0k59ohDp+L+jEzJ4a9hCEJz6/ehapgvJVZCvF2XIh6fXRxTr3YAUcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWdzVEIwL2FjTFd1WEo1TXF0VzNOWHAwUW44L2dubGEzSW94V3huVHJIb1V4?=
 =?utf-8?B?cE0xZkZDNEYvanF6TW1ZWEJhSXhIUjRrVE55MDh6T1dqTjB2aUsxa2p2S3Zn?=
 =?utf-8?B?ZmsvdG1QanRmTGR6aThZU1BGL2Rhdnp2NU5oYXRtekJneXdUNHRaMU9zemow?=
 =?utf-8?B?Q3UwQWhacUNaVTdnc2NodXdxV2NOdFBHUmNVeG9VTDB1VXYwQjd1eFBRV0dP?=
 =?utf-8?B?bXJSM3F2VEZyWTYyQzJxeXNkc2QzQ1lLSGJZajUvazhCZUZ2VjZMbU1rSHpo?=
 =?utf-8?B?clVIK0t5ZVNWc0swdVhRUXltdDV2WVZpR1VYamIzcHVvc25CZGxUOUlvU2xL?=
 =?utf-8?B?VC80MWZTb0RnaFFDcFdqTStUNVpQSExJZS9xVnViZ1VkQnVTWjVORGh2UE5S?=
 =?utf-8?B?aVVmbHZqNnZMQytPb3cvdkZLZkF5UzJreklBZ0NZVW9VTUhZYWh1eWY4ZFov?=
 =?utf-8?B?bFhTZkduWFdlZFUwb2diSUhaY0tyUmJFRkd6ZmRCek9YT28wbkJiT3F4NDBQ?=
 =?utf-8?B?c3ovQ3pJSTV0NFhVWDBESGdDdU05UWJrS1pWWmpvZ0IwaGhQSEM0eExDQ3BD?=
 =?utf-8?B?c1FXeWlPWXZXSE1ienBUWFhIYzNOMnNoY1NReTI5VWxySVZESXlOTW5pMkgz?=
 =?utf-8?B?akl6ckF0cEpBbEFxTnNiaHZNOVg2L1hybUM5bjZpWU9KNTVualBneExGY2tD?=
 =?utf-8?B?eVNOUTRCcGRjUWVobGpOVU5LaGloWU13aDZLYi9Fd3d5T09iNTNkSWlwQk4w?=
 =?utf-8?B?SGtIKzdPa0NQbDZaQmVEeXNaNkFYOU82cklhTHNhQjI3WnlDV213VHVDZkpt?=
 =?utf-8?B?WU1TNEJ2OVdYeG5yTWYxTjVKK1NSQnRJUU5hMHRNN1lCSXk4NnM3TGlCcHpF?=
 =?utf-8?B?SkR5bVhxRGtYQW43RysyVlA1bmxtK3pQVng2cU13NVRJUm44dDJaZU11UXB5?=
 =?utf-8?B?eTNUdDdldmh4M3VFOU56dHBIUFYyQ2pSSkhPM3BXbHZ5bVRmWU9NdmtQSGFZ?=
 =?utf-8?B?VGNSaTZJUmV5Mys5dVhpbTNnNGNwemU0bzFKdlRIdnBscytjT0FUQkFxRnFs?=
 =?utf-8?B?dGtZTTdCNXZRVmdJSitBcnRBS3pyeTl6eUJwRTVPK2VuRGpqaHNDTW1PVnhC?=
 =?utf-8?B?eVJtWFVpbnlJSnYvN1FsdzZnZlJIaXF1UTFuS0hLMktMazdRN1VPU3NkUkJu?=
 =?utf-8?B?dWJCS3A2NlB2WUhQQWtNcnltdXprdk1EZ3cxMllPK2w1dW1SbDdUeTB5MkRD?=
 =?utf-8?B?SVd2SDZLMXlrT3FPalM2TzNxMkl5YzJHbXdHZW9xeDYvUU1naUpSSXVWT2VN?=
 =?utf-8?B?N0JnNkprRXl3T21zV1ArMDI0QmJsYVViMGFMZzFYWUpTN3NwQVJockNzb0lI?=
 =?utf-8?B?SklWcHM5RXB2MENEMDFBOCtQWEpCUUtQQWJxRFNzZk1VT0NhSVhEZ3lYTEpW?=
 =?utf-8?B?cUkzTnVMRnIraVdIZWwvamtQQUViNDVHLzVJOWppek5mdjJuMmlzMngxZ2dO?=
 =?utf-8?B?cklRcFI5K2JrcDN6WkQ2TjZLeEkwekNwVlhqU2pwQStsZi9XczFsRlFjUjlF?=
 =?utf-8?B?cDh5RFVNMGFwbXFmNzR3eTlSNmR2b0tNNnhwM0FSZGM5VVZ4ak1zRWFnMmo1?=
 =?utf-8?B?N2ZCZUtRdmt5WWZPMytSTWhrVTRNU0ZVQmt5SW42bHB6MDNkdXJkQll6dk0v?=
 =?utf-8?B?WEM0RnBsSk40WEc1U0t3OGk2eGYxd0ZTdmpZRWIyK21wcFd6UHRTVEt1ZUxK?=
 =?utf-8?B?eW9CSElqTFdHY0taOGg1cmt2Uk1NLytXdEtLQkRiNnVSM2x6d0R3dCsvNnNB?=
 =?utf-8?B?OTVPQ0xwNVc0N1dPYVdyMlBIUkZFOWoyQWpWcjRsZnJycHlKZENra1YyT3o1?=
 =?utf-8?B?dllaS0xVakFHcFUyV0hJWEZ0TEtoSVBMOVJOeGpIaXpzV1NUTlJzNHVNL0dC?=
 =?utf-8?B?RC9JS1J0WlcxSTR5K05lVjQwSnVXWk9EQVJsUjR1RDZCczEwZ1E1RGFJb3RP?=
 =?utf-8?B?MWFiaFNCRWhWbzJMbTFkbERhUGdYSlJhY3lFWTVldUJBVllzUitOTUtSNnVT?=
 =?utf-8?B?SHFGNml3Q0FaMXAyTTlvdjUyNTJlMDFOZnFodGZmbjhrcXZ4c0t1M1gzYSt0?=
 =?utf-8?B?bnZXNHhaNUdGRGR1OFdsRFlOdmt0TEJFV1dmTExYSDJubVJVRjNBeU8vREVI?=
 =?utf-8?B?bGVmaGQ4d1ZCRFRCNjU0bTdtTXdic0lGK1lFWktoYlVWL0VPWG1UZGx1SjN0?=
 =?utf-8?B?dkpUa3BlVDJoUEFCYnZTRkQ2TWJCcWs4emRra3FWVnl3QVNCcEJHQjNsVk5w?=
 =?utf-8?B?Wlh4Rmd3dE82Z1B0U1dCSmtlZ2hLdm5GalNtWlpsV1laY1I4VEY0dz09?=
X-Exchange-RoutingPolicyChecked: BNNk3rovooBcRLanDa/enU+hCcXxZuEczFzGEeK8VUEz9mw5NTl3iSu/NXtb4SfMybaUgLwGlGkqkFMUHvj+TaQbQ+5kjHLhKQOhrQG45+EAoaZesSfFPXElkQEE/0qrqEMZCmTrvxV5Ca0PNQA+ZCBeia5X9Qgf6adp5S32IIW+0Kvr3XAOmp2eruhTVjSSbnrSUA6+jcQZ3/buWuo2Yh8ZFQ+7WIsr+HCPtk5cQuA+ZfyMwG+++Xtj89vf5O6xShJdjgBCXoCY9FOUL5gCiouV6FeKRMPWRRwMCqQtBcRHo+90pTbTnUU7L+UHC7T9lExKBInP8StJvtF2taUz4w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a7b7e3-b9d4-458d-4c6e-08df2df9123f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 15:53:08.8096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXuHr37p+C6b7gNTijsmjBq1JrHHJPlWFlc66P6xKUVOV3k7PITL6gMiOpAocuCDhOWqVLNW2RO2BqrmehQ9HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB032640
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 19-Oct-26 4:04 PM, Thomas Monjalon wrote:
> 19/10/2026 16:16, Radu Nicolau:
>> On 19-Oct-26 12:27 PM, Thomas Monjalon wrote:
>>> 19/10/2026 11:25, Radu Nicolau:
>>>> On 13-Oct-26 8:41 PM, Thomas Monjalon wrote:
>>>>> 12/10/2026 15:58, Radu Nicolau:
>>>>>> Intel(R) Multi-Buffer Crypto for IPsec Library released version 3.0.0
>>>>>> codenamed Túnel Pablo
>>>>>> https://github.com/intel/intel-ipsec-mb/releases/tag/v3.0.0
>>>>>>
>>>>>> This patchset adds support for the new library version and support
>>>>>> for the new algorithms included in this release.
>>>>>>
>>>>>> Series-acked-by: Kai Ji <kai.ji@intel.com>
>>>>>>
>>>>>> Radu Nicolau (4):
>>>>>>      crypto/ipsec_mb: add support for IPsecMB 3.0
>>>>>>      crypto/ipsec_mb: add support for 256-NxA4/5/6 algorithms
>>>>>>      crypto/ipsec_mb: add support for ML-KEM and ML-DSA
>>>>>>      test/crypto: add asym test suite for AESNI_MB
>>>>> Sorry I will give a defensive NACK
>>>>> because you never fixed the problem with the Arm fork.
>>>>> The crypto branch is already not compiling on Arm
>>>>> because of your recent change for IPsec MB 2.0.
>>>> Hi Thomas, with the latest changes and removal of minimum required
>>>> version these patches are now compiling on Arm, are we ok to withdraw
>>>> the NACK?
>>> If they compile, yes.
>>> What changed?
>> The main change is that they are now rebased on main, and not
>> next-crypto, which included the change for IPsec MB min version 2.0.
>>
>> They compile (and there should be no further issue with Arm compilation)
> So let's say I remove my NACK.
> But I am not supportive of the way it is ignoring the Arm fork.
> I really would like to see a unified repo for IPsec MB.

I'm not sure about the odds of seeing a unified repo, but I'm fairly 
sure that both versions of the library can have the same API - and they 
do at the moment, for the most recent common version, which is 1.5.

So the PMD, as it is now and with these new patches, will still have 
full support for the Arm fork, while also supporting the new features 
from the new Intel releases.


