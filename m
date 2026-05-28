Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7EACD4F54
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 14:14:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AE0C4021F;
	Thu, 28 May 2026 16:14:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id BBC1D4003C
 for <dev@dpdk.org>; Thu, 28 May 2026 16:14:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779977654; x=1811513654;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9ynqGyHd5z0L52qKotEuwrWdGIsc9LH2fSoZ44omvqg=;
 b=H4cPdP5Y7k1SYyT0MxN7lM036f0NQDuqo8wqsX57rxzatwgOSbHhn/nF
 5p51E7rj15wPYut6SLeAJF7IqpG1sPHt3sxj0DnPMa8eKSk/WIHIOfNuG
 ZP5x7UMuUHMdY/ea3WPkpWON+VyBs3Hswi+yHNuL2hc9yfIvxA9SL7b6y
 jAog5W6COAE8zAJWri1oqNpoBXeg8QLATQNjJ2a04Pd6EHbXGvrrthFur
 4UkOUYLdzjv3Ms0xf8EL8O+t78rYV6dMCIJTQCkB8YbqmfBPBjVYvVf2c
 AKPafeF1d2p/0fvI1bjN5qARzCB3MfcKIy/2RnhBVjTiB2jGiKaUM71pS g==;
X-CSE-ConnectionGUID: amVJ6ZnhRLa2KoZGOAaQog==
X-CSE-MsgGUID: 2SQ7SfDmQ2OGHu64Onv+1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91126444"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="91126444"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 07:14:13 -0700
X-CSE-ConnectionGUID: 5M8aFen+SGuLTsdRW068ug==
X-CSE-MsgGUID: +6omy0G0Q86vYtcc044ebw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="242719580"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 07:14:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 07:14:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 07:14:11 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 07:14:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inJsJn16ByIy9EEkuLAfQzTNZIj/vy/0T3V4ZyYYnqwN0T7uW0mMghUlT4xvdcRTWXiJ1+CwVHnPV+lEnEnaZmCH49EcFw5E5kF7xk2mIbH8a9r5/g4108OMw4svo+WNfO8pMx6ut1OlUNrVBqJkvp5pWXiwhGF4xnUl5nkM/129vkJ8GOK4TbHfKmOJ6m40QK3+RqZ9CiRRQpGSSvBZ3a66LdUw6WOc+S47GAjmAe7qBdPbaAPfnZpQ7zQDWN7V+4qUE17Yz2I7uF87ocK7Mpb71k/VOHCn++QN6lJGF68gT4JSAFxuaxJi9VrVVe6wgZFugrKiFz04MouDgj0anQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UCXSiDmyU33w9fNmAGOBl7bqcq6soLQIUfGpkmF7YU=;
 b=PjJ1SAQ0LSi/IgTzYLLmEudX+EOsH+T5N3C6VvGWjMSxiss30cxmGBfKOWTShoQX8wiQC8zTB20fUdJ6dTrIMkmM4Vdj5ompikTOIx7JN/rlRbPBFgQ0npH89sJsOe8DM8+OMOyFnA/XU4aS/aoQKw5m66DZvZe37uj+IKuDlAD73dC1Ce4ksmZGfDdJFGUB3SWR9c5dDQlcYvGxPhWTyUQ4szhCftFsm7MAfqtvyjgvPBG8KTNgNyj16PJxu600HIsn7QAVBpPflzI+LlscPRSkHzRPwNEAO0g3lvp6ZBq2p3dqIzX11Wu2muVztz/QWz0vCkFJHRpDT9HKNQqHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA3PR11MB8894.namprd11.prod.outlook.com (2603:10b6:208:574::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.19; Thu, 28 May 2026 14:14:05 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 14:14:05 +0000
Message-ID: <a98ae9f0-fce3-49b9-a4df-d76e08696c2c@intel.com>
Date: Thu, 28 May 2026 16:13:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/27] net/intel/common: add common flow attr validation
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <cover.1779717943.git.anatoly.burakov@intel.com>
 <cover.1779717943.git.anatoly.burakov@intel.com>
 <d75e9a02b40ccfe8fd2e00977ee99e9be95ca9ad.1779717944.git.anatoly.burakov@intel.com>
 <ahbxgjoGdAEm99kj@bricha3-mobl1.ger.corp.intel.com>
 <9dbc8a94-ceca-41f0-b759-a23cbae76902@intel.com>
 <ahg_hFvDIpwzYEyQ@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <ahg_hFvDIpwzYEyQ@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::20) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA3PR11MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b945d4-bbdd-482e-c856-08debcc35ffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|11063799006|5023799004|3023799007|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: Lw0BUdeXF4ETYeuMxw9g+/UIwA55xrFH6feh4KaPfKgkLSlGaaxXe+O8IEqjJ2A/wkUHJi4V0k99iS00oE826ecaQ1T7Xjv/Rq1ODymZDElpZKAFAJPuuNbbQ6OUejFL6LTET1ll0XCpDg8Ltp9uk84l6XGWoV77P9tBgKmQh6W3g83BSaX6hEf+XX1wEFlk18yibC3D8xkwRbGihlb8eUJptS4MWFZH0wtK8kTpDtCnFOdeZ0O0klr4ltn83yPhCeLJkWL0nbhPP/XL20scfrb6k/wHiN7jSqPoOwxq//Ius7M6ZZPhprfsxxTK7Kpxua9sia3W/aWuh77fOX1TmGOwA8TjFb9mhBCLPIh3aJM9HCmWeVH/j+A8O/XBj0tcywCeI/72Aviu11I+DYbR6QzVLmQ9IHuDVA+F6+d25bfLZTRPX4FzmoC00Me9gehJOAkU6CSduYqNyHaDBV7eMxU0koL7Ou0Y1kb5MT6WSM/fKauI/SD2oX/Xzy9a1ZtVApmqMugwKDE0GHb/005ujpsjLKg/XG/yxWcBCEaCuf+vm1gX1UzYPaGaxtuQYMdve8pCUAzfsuF0N3JtE+BKZqE+1U88eqgFimrArvTevgXlGPn+Bc5mXrH9YCV6SDPa01/U3N4QjpDilEh56B76WL+qld7luW5c0R4CbDQqmmaL9l+YKq472SEYiWnZZLhJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(5023799004)(3023799007)(4143699003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFVCMnBJUnRoWVZYTC9MUHlrSVh1RzcrZ21hek5NSWFpMEdzUUh6Qm1Bd0sr?=
 =?utf-8?B?aW1ZaE9YR3k1RVR6NEVaaW9KYlExTUNhQ2x1QzY0VjhXUzZkeTBzZDRuNkly?=
 =?utf-8?B?bVlmMVBJZVR0b0pKNENxTUUvWTFnVTdyNFR1Uk1QSmZLNVhMR0VNUytLTkc0?=
 =?utf-8?B?bUc4bWFnQ2cwenRVc015OHdlamtFUkZiY2llSVk4a01HU3QvRFRZczQ5ZjVt?=
 =?utf-8?B?NUdGQ1FlTnNuSDdNNjBIVm4yYzhMeXNON0ZHbm4xQlo5dTBlR1NnWnZVbXpD?=
 =?utf-8?B?dzYxcEFjcXZ6cXc3VTJ4ZzkzbHZiY2lzNkxOVXd6bndqd0FDRW5BQnVuNUNl?=
 =?utf-8?B?ZGFxRUd5Mm4yN1kyVUMvS3o3UnVtR1pQQkpyT3FCYnBubHo0cnlYZEs2U1lw?=
 =?utf-8?B?RXA0Ym9LUnM0MDBXd3VNa2xtMFFETjhqSXNKLzJML3ByNi9obm5RS1NITVRp?=
 =?utf-8?B?YjE3R2IvY0oza1dJWElWRUoyL21lbHNHaHF2ZXFmWHRwc2NQcjhGR2J2QUVK?=
 =?utf-8?B?a1FRdVdibllpZ0VGbS9JYXE4WTlWWjVBK2RwMVAxRXRyN3FhWXh2dE9Hc2I0?=
 =?utf-8?B?M0ZHVXZ2eWx2VTZ6MktuTzJSdlNuMG8xVkhSd0t2M1BmcVpkMHdqYlRRL21t?=
 =?utf-8?B?bW8xS1JtV042V1puSlBGc25QWEl0OVhpc0tzZU5WRjZDSkt6bHZ6SzViajBt?=
 =?utf-8?B?dWx1RW1SdzZsQ2hBTHVDV2VvQ3A2UlhycTVUWFJtVXNTbHpxVTl4ckp1a25B?=
 =?utf-8?B?bVVQSWs2U1hXVGNBT2xyNTRqYitvUENKNGhMM2lSdkRRZ09lWnNmWDNENGlM?=
 =?utf-8?B?emd2NzlBeVh0dFgyd1lxOE5NRHJPZEdUOGRtRmZadExKb0Zzd3I3bFVYNnRV?=
 =?utf-8?B?cUZtZkN4T3lZa1ZXaVplNkVxUjhLVnQ0S3pLVjRTbWh5OWpkaVhNRGdDRy9Q?=
 =?utf-8?B?LzY5Y1NPVGxxSHBkV24vaVJyZlRITmV6TTlnTDFMK0pnejlFQytkYklPVHVy?=
 =?utf-8?B?MlF6VzhzdzlRSDJSNmZPQ2FwQmU0S3ZlSHlwN3lrN2ZzQkFWWFZMU2tTMWpQ?=
 =?utf-8?B?Uit5YUx1YjZEQU5vOC9SS3NsVk1BY3hDQjZlZDF1WEc2YURHYk9FUDR5OFkz?=
 =?utf-8?B?UHcxUW9DcSt4Z3RzSlhJNlJQY3JGb1VTZWIxZlF3ZklQZEZmMkhBei9wZzV4?=
 =?utf-8?B?M2dwQmR4aWdtVGZIZzNLWll2N1B6VkFpOW5QdHNDWnBhcC9rMi9hT3h5QVJ4?=
 =?utf-8?B?TE9ScFlGSHdMcTQ3cHJLcmRaREpyRU9TMXFnVGZ4Y0dLQ2xnQSt2Z3pnQ2Uz?=
 =?utf-8?B?WjdwbFBXMEtjTHdyZTd4UUloMWZ3d0p3bEdpZk5zTWlrK1ZWbVBYVW5ZKzRJ?=
 =?utf-8?B?d1Z3U1NBaTExeE84amFuVGM4WG9BSmpuV2tHMmNUVkpac3Z5bUZMSGNsSy9a?=
 =?utf-8?B?cXdrMy9VOW9Hbko5d0ROdWlRSVdmdnErSkFGT0lHLzFrQ3BtN3g3MklhOVBI?=
 =?utf-8?B?V3k2a0o2bG5GRC9MYmprRUw1Rngrb1ZlelQ1UVZwN3h4YUp4YmhBWkhKcGhR?=
 =?utf-8?B?ZlRIMmVBUDZJSTNpTjJkWTU2VExOa0ZQVTJ5WkdmcDlJZVlNSldMayttRy8r?=
 =?utf-8?B?aDh0NjlDcXY2YXo3OXFPenFoQkdNN1dRZUhSb1oyemlodi9MdzUyQ2liS2po?=
 =?utf-8?B?MlZ2RGd6bHJwTDRlZUZ4dnU3SzhiL2psSHhRUnZnZkhSL3VrcmFOS0lXNjdE?=
 =?utf-8?B?eENoNVczNXRRai9qVUJvMmFZMUVwL3FKa0piOVNiZWRLTmxCZ3pPUWZRdlNx?=
 =?utf-8?B?QmFDTjhNQ0ExbXBDWjJzUjQwekY0c3pHejhTd0JkZEtHRlhZQmgwUWU3b1JQ?=
 =?utf-8?B?NnJjc2N5WGZoQmFtWkREZW1aSGF5MjRRRGR3dzVoSjRWb1BOcW85ZldpZDFB?=
 =?utf-8?B?Z3VmUlZ6Z21Ia2czV080b3VtVUwvejk4QlYvN0J2U1o4anh2bVZsWDhLcXda?=
 =?utf-8?B?VmJRM3lZM29CbnF6c0dVL3daTkk2Z3RIZ01Nb29ocWNNRzlTUTcvODBUQURi?=
 =?utf-8?B?Uks1Rmc4d29xSERjNFFmL1lCRVJpa2ZseEczemxlWm80QjNHUWc4K3RQQlNN?=
 =?utf-8?B?NnJZRU90dlo4V0xLYjBiSG9kN0pnYXhpNlJhclpsM0hBcXF6SHljZFd2eEl4?=
 =?utf-8?B?UllOdkNBYTF1NE9UdkZOeTczNkRSaU5YdHhidE9tcWthOUgwZ3ZpcVJKSWM0?=
 =?utf-8?B?RGdVd2E4VDA2ckVzenkzR2pxNG1hVjJiQy96VjZhVnNQL3pkYUxrS1pXMkZQ?=
 =?utf-8?B?YzNxODdBTXJvK2NXbGFwVlRuYklyK1ZSK0tWVVlGMGNJaEdZbjFNWm01RW0x?=
 =?utf-8?Q?T3bHsU6RHgKXpn/o=3D?=
X-Exchange-RoutingPolicyChecked: k0mdtsUxavlm6/DIIVOL79nJwQX1LkHCiDsyH23hQ8adiexfJmLhgrYaWzpSfXp2AMth4zwG83Li6heOyWpCOPZuQcpEdVL8m/9s//OKK5vdQFQIGeEGOq3nGGM15PRkmUhBafstcGdZSJ3HVBg0R3GxC1Gsl1UcZSVDXlOygVsz4dWPH5Gxn39Rir9lHz+DSlBIVkgTwOoAVHd1r0wqxVMerKa4VIBDHAkUqWZna/NYlEd5LoX9TTV0FO8MkJsIFrq3FXYWTlgT/tYJSOIGGIeWCWWx6RVwoxR27sH+hRMIr1PlRw5urGRkEhEsRqtXK2Zkmr536g4heqIqEm5mqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b945d4-bbdd-482e-c856-08debcc35ffd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 14:14:05.0001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0r7/gBpG1GmLbgP/HfnDkubN52VZZpddYm7nFWpqyQCha/hAvQGvDUoPll4VY+YlNPyOQNq5GUguvUCaem9DggOx+9EQpLxM/li3QUyDvOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8894
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

On 5/28/2026 3:13 PM, Bruce Richardson wrote:
> On Thu, May 28, 2026 at 02:39:47PM +0200, Burakov, Anatoly wrote:
>> On 5/27/2026 3:28 PM, Bruce Richardson wrote:
>>> On Mon, May 25, 2026 at 03:06:23PM +0100, Anatoly Burakov wrote:
>>>> There are a lot of commonalities between what kinds of flow attr each Intel
>>>> driver supports. Add a helper function that will validate attr based on
>>>> common requirements and (optional) parameter checks.
>>>>
>>>> Things we check for:
>>>> - Rejecting NULL attr (obviously)
>>>> - Default to ingress flows
>>>> - Transfer, group, priority, and egress are not allowed unless requested
>>>>
>>>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>>>> ---
>>>>    drivers/net/intel/common/flow_check.h | 69 +++++++++++++++++++++++++++
>>>>    1 file changed, 69 insertions(+)
>>>>
>>>> diff --git a/drivers/net/intel/common/flow_check.h b/drivers/net/intel/common/flow_check.h
>>>> index 74fb28ae3d..0572028664 100644
>>>> --- a/drivers/net/intel/common/flow_check.h
>>>> +++ b/drivers/net/intel/common/flow_check.h
>>>> @@ -54,6 +54,7 @@ ci_flow_action_type_in_list(const enum rte_flow_action_type type,
>>>>    /* Forward declarations */
>>>>    struct ci_flow_actions;
>>>>    struct ci_flow_actions_check_param;
>>>> +struct ci_flow_attr_check_param;
>>>>    static inline const char *
>>>>    ci_flow_action_type_to_str(enum rte_flow_action_type type)
>>>> @@ -271,6 +272,74 @@ ci_flow_check_actions(const struct rte_flow_action *actions,
>>>>    	return parsed_actions->count == 0 ? -EINVAL : 0;
>>>>    }
>>>> +/**
>>>> + * Parameter structure for attr check.
>>>> + */
>>>> +struct ci_flow_attr_check_param {
>>>> +	bool allow_priority; /**< True if priority attribute is allowed. */
>>>> +	bool allow_transfer; /**< True if transfer attribute is allowed. */
>>>> +	bool allow_group;    /**< True if group attribute is allowed. */
>>>> +	bool expect_egress;  /**< True if egress attribute is expected. */
>>>> +};
>>>> +
>>>> +/**
>>>> + * Validate rte_flow_attr structure against specified constraints.
>>>> + *
>>>> + * @param attr Pointer to rte_flow_attr structure to validate.
>>>> + * @param attr_param Pointer to ci_flow_attr_check_param structure specifying constraints.
>>>> + * @param error Pointer to rte_flow_error structure for error reporting.
>>>> + *
>>>> + * @return 0 on success, negative errno on failure.
>>>> + */
>>>> +static inline int
>>>> +ci_flow_check_attr(const struct rte_flow_attr *attr,
>>>> +		const struct ci_flow_attr_check_param *attr_param,
>>>> +		struct rte_flow_error *error)
>>>> +{
>>>> +	if (attr == NULL) {
>>>> +		return rte_flow_error_set(error, EINVAL,
>>>> +					  RTE_FLOW_ERROR_TYPE_ATTR, attr,
>>>> +					  "NULL attribute");
>>>> +	}
>>>> +
>>>> +	/* Direction must be either ingress or egress */
>>>> +	if (attr->ingress == attr->egress) {
>>>> +		return rte_flow_error_set(error, EINVAL,
>>>> +					  RTE_FLOW_ERROR_TYPE_ATTR, attr,
>>>> +					  "Either ingress or egress must be set");
>>>> +	}
>>>> +
>>>> +	/* Expect ingress by default */
>>>> +	if (attr->egress && (attr_param == NULL || !attr_param->expect_egress)) {
>>>> +		return rte_flow_error_set(error, EINVAL,
>>>> +					  RTE_FLOW_ERROR_TYPE_ATTR_EGRESS, attr,
>>>> +					  "Egress not supported");
>>>> +	}
>>>
>>> I think "allow_egress" is possibly a better name here. "expect_egress"
>>> implies that egress must be present, but the logic here seems to be only
>>> allowing egress if the flag is provided.
>>
>> No, the check right above this prevents unspecified egress *if* ingress is
>> also specified.
> 
> So the error message above should be "Either ingress or egress must be set,
> but not both"?

Sure, yes, a rulle cannot be both egress and ingress.

> 
>> Meaning, one of egress/ingress *must* be specified, and if
>> it's egress, it is only allowed when we are expecting egress.
>>
> Yes, so it's either ingress or egress but egress is only allowed in some
> cases. But nothing in this check prevents ingress alone when expect_egress
> is set, so egress is allowed but not required, so I still think
> "allow_egress" is a better name. "expect_egress" is a bit ambivilent, in
> that it's unclear how strong that expectation is - is it an error, or just
> a warning if the expectation is not met, for example?

Rules cannot be both ingress and egress, and they cannot be neither 
ingress and egress. That leaves two options: either the rule is ingress, 
or the rule is egress.

If the rule isn't ingress, it by definition will be egress in order to 
pass earlier checks. The intent is also that a rule that is "expected to 
be egress" must be egress to be accepted.

However, now that I think of it, you're right in that the condition is 
subtly wrong. By default, we expect the rule to be ingress (i.e. not 
setting "expect egress" implies we are expecting ingress), but we only 
*check* if the rule is egress - we would *not* check if the rule is 
egress. I think the condition should be replaced with:

1) if attr_param == NULL, rule *cannot* ever be expected to be egress 
because we specify egress expectations in attr_param - so, rule being 
egress when attr_param == NULL is an error
2) if attr_param != NULL, egress *must* match expect_egress

So, basically:

if ((attr_param == NULL && attr->egress) || (attr->egress != 
attr_param->expect_egress)

this should better match the intent.

> 
> /Bruce


-- 
Thanks,
Anatoly
