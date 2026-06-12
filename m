Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AADCD98CE
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 10:07:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03F88434BA;
	Fri, 12 Jun 2026 12:07:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id CBA4F434B7
 for <dev@dpdk.org>; Fri, 12 Jun 2026 12:07:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781258829; x=1812794829;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mwbq0a+IoRHX0JU2/9Kj78rv5Hy8/+koBj5WJfyA14k=;
 b=nBvj/tkCqopJCppLGo5PkEclgH/Qk3tVkqEN9VP0m7q/vE/uWntA/uBC
 shTUOZpjxVx8cjMq0VgEmNot0xwcg4ba3OKqMDQ5UATXLQsrKUTjUyW8L
 QuFyBXjnWSLKZpYTCRRTFLvVqsQz6/7llf++A9ujLSFWKg4G36nAVdAkC
 GGjD79ydW66fzsOIXlRLrhQWpeeHiEW1OwR/YjucxQkKPtoGQwYsCec9D
 bhxlWiOqc71RE2cDD6rZrmJ/DGc2lqFs0cl1IOXG8X2qrCNjyNZs0QBz9
 U3XinjeXofNINUgDvaBP5/gsklYavvRq+liV4ScLC9o58MSKR0I3DU6XE w==;
X-CSE-ConnectionGUID: E6Npmvm5RHGrtwdTVb/RlQ==
X-CSE-MsgGUID: C6u01l69RcyHDnHIxgqgXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82071578"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="82071578"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 03:06:58 -0700
X-CSE-ConnectionGUID: mU5Djz+SSxSwLSwh9zG/eg==
X-CSE-MsgGUID: Q+m1L372RLivB1LQs1WOsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="270445764"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 03:06:57 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 03:06:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 03:06:56 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 03:06:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whg6xygodjY/ktl6bAFNhplKBydBL76ro9CgjHBED9lYTZsgEdNP6ohh33j/AJpFrmrd8M5cDz21Q+cF6Ao/bNhLqaiM9qM9KRca5iaNbvkNRcg9/pOFXWblz/UNEiaXI72PA0XfSWJbcsFvsotrlwSeVsXuvPFMUOMaLSe5A7DQK/VmRVDOE0aUiaYQ1958UqJ8zb4YjBGRdJTafKvfqAYv4CoSVioy6MOiyL9lxAb6HowIt4Au4Hgc33I5iW//vKBHuMEunVm2xPWepkSKOX9q+fjA/ryNgdRh1317n6XPIa+sAjROMJjFl5VynT0GSbZwQOAByH3iBo5/LfMVew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwbq0a+IoRHX0JU2/9Kj78rv5Hy8/+koBj5WJfyA14k=;
 b=o97d0YJRoZxCc1MzsLFavbZSw82u1aOdJnHc1ZmFT3UWb2iZVUFVDFZu5lwClwYRJr1WMpP6UqEoo37ctCOvGxnOGBz3LDbXSQe3X/xSii8ShQTRWITCnAs2U1gpoZSTruQqsZ/n0EkQSAC3+xdBmKzi+TPxpT6c3x/kExsooz1xnczVK2ROAwvzRtyWrKnk6dNYfBElGCUhFu5KHM3bKF0L0ex4LwxAMcStUqrzMSWK6YyvWjmXVupFMUj6N1HsWZI53gcFA0qTOUKrGp4UyvCysq6JkebSd8MhxqXnSnLwvvBjcEeugWqK05CivHtTTX0ASZASKCYxbMnngLI50A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.14; Fri, 12 Jun 2026 10:06:54 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%4]) with mapi id 15.21.0113.014; Fri, 12 Jun 2026
 10:06:54 +0000
Message-ID: <ba648a06-3605-4cb6-bb5a-0b842ba31b40@intel.com>
Date: Fri, 12 Jun 2026 11:06:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] doc: improve IP reassembly, IPsec, multicast, and
 keep-alive
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Akhil Goyal
 <gakhil@marvell.com>
References: <20250216230903.124496-1-nandinipersad361@gmail.com>
 <20260611212119.1026721-1-stephen@networkplumber.org>
 <20260611212119.1026721-10-stephen@networkplumber.org>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <20260611212119.1026721-10-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::16) To SJ0PR11MB5661.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|BL3PR11MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c74ce84-e338-492c-6f92-08dec86a541c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: MPLb3Sryuk0xHg6LeYuo21N/xGY/UIJa4QIQz0PXClYGpgj08rPZmjlne7AR2vuyjtF8kg4QT7XisvHZsgaOilEPAR7972DH+VzxGFDfuRrJ6umpamRnWd4KvCtgh5DORTSVL9ceSUf06hYb7jksIL4cvfqBjTjzmhNghML9ASkqjVo6QAqwcCK7uaNA95hpS1y5t4mlosDv+4/OGU7UONFbLcNklX3jh0rg/jXu9WE3uZy6KuISZzdeFpJ2rFrFTEUGFR2A1KCs4XK8xU6g0EOIl+L7kOxE8EaIGpvjiSCHfQJB71uNVtR5aidGL6si6axqhdymHcBv0ZP9ujkinYrGEQNjPefKTwYKZbknrV11TZGXjkmiH9dvOCXI6FE3J2mkQ2eFoDo9tuyIoPtucEWeoFBGpn8mGDkc6VZgHF0ySzaRFVEG3/dWS92Q60g4BNkP+7A5OR+M6F37sBxXcyT3TPBIq/1BPkTui5xlFLyissT2OIB60ATwfnnkfuA48GDEDwUK73JZbi4MaIc3RpvdoGxJYH0wcC5GKfgdlmdMtgKmO1p82LiEo+zqda67xqh8gix7DaDx0sxa33nQc11cow8c5xk+KUK5V5eq+vE9We5BYh5PccvuiHH7eWkokgHlEFa3wJQA1N5RIuvlSF0T0GT1ozHMz9rkrJyiycZj0GtVEVwMWJ3aYdhL/Unu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG5KS0dZTXlXOHBBdWk3NTFiRHpRQ3c1RDdYWnR4VlI4QzNCZm52SkQyMWh2?=
 =?utf-8?B?dXVMbW82aEo2RlI1SGlvZ0laemFHaStJZm4wRXI3UkIweFlVRVNXQjRiN05p?=
 =?utf-8?B?S291UDB1amlXekZpakRDYjVXL1JSNU9rc0JTaXI2QzB5UGJsZjRxbU5uZnln?=
 =?utf-8?B?OUJGYWZLcDJYViswaGNhdU11clNoZmE2TUxBcGF0WlhyekZLa0dIbTZXR1My?=
 =?utf-8?B?VWEzQVNiWEh0YTI0SVZrekFjWVBVZ3AycFoxb1ZtQisva2hDdHR2RUJsWVFS?=
 =?utf-8?B?MTVVaXFwcDVET3NYTFgxWTJPbFUydmFKUG9zdG9ERDVVbzdGQ2F3SVdvQmZF?=
 =?utf-8?B?V1EvQXJUNFVGYTc4c2RxNXA1QTVoTlBodVZZTndnNFlwNjl3SDA1dW1RdWlT?=
 =?utf-8?B?anNUVHIrS2JVTG9NczN4WCtEcVJNUnY5am5uSUxwbWVmK1daL2ZMZHNraFFZ?=
 =?utf-8?B?TmtCM1JTYmxzRXVBMHplQ2tsZXdLVDhaNFhycCtSL05ZcGtyMUlVS3gvM2V1?=
 =?utf-8?B?c0dKb0FJSUZ5Y25CWWNkRXBLeDFqeWZ0VXFNRk5JQUxDV0N0V3RNZkd5Undj?=
 =?utf-8?B?Qm9jTzBEd3oyOEdmME1HTjNTb3R2dWhNa1ZqM29qa2tBemVaR1lTRGhKMlJz?=
 =?utf-8?B?VzlrdEtCdmNKdGVuNlRZckhLSjQ3TnFWN0d2aDNsdFBMa2xndkMxbWlrWW5l?=
 =?utf-8?B?UHNxRFFaWDE0YnJCMFF5dEFBeWpKZ1VNWEM0c0kxRGlwQThxUVZxMnJiUm45?=
 =?utf-8?B?UHg3WEQrNSs0RzdzbTBoT3hlVGE2Mm4xUlJDSDh2RHpld3QyY2MrVWE5V2do?=
 =?utf-8?B?anlwaXFpWWNpSjNPN0VsQjVkTVRVUUlsczg4NG5NdThlWEdWTzlVMlhCdWRt?=
 =?utf-8?B?TThQY1pwVklYUE5YNVdpMUt6bmlDNjBqYm9zMHJibGR5YkVxL3laTlNjTDRK?=
 =?utf-8?B?QXdJNTJOSCtqU0lMZHkxc0tSRHBrQi9vZUp5NGg1cXF2M1RGS3FLZnFSS3ZH?=
 =?utf-8?B?RythMUNvSHNKS0pQcnR2OUUxS0I4Q0Q5YWFQTzZzTkpUSjdncmV2VERrMUhN?=
 =?utf-8?B?cXZDcU55Y0tsRzg4NXdXSHo2T0IvWWo3YnN0Nml1aEdxcHFoaW5iOHZPNWhV?=
 =?utf-8?B?azRwMW1jeCtnQkx2K3ZLL2FtaGtrTW45ODAxTFV5dG9vcFkzMWZCWmcxTzRt?=
 =?utf-8?B?OHVlTlg1TDBtbzZKOUtpcHBuNG9UaWVtcnF2R0ZnZWIxd3NraWg3L0JxVDd0?=
 =?utf-8?B?YkhkN0M3enNybzk0WTViNElTNThyUDZydWk5bHlQNGdZQm5LbXZyRmlaYjJV?=
 =?utf-8?B?MFIrTjhpWnBRSGJBbjd3VGxUYjFYV1dXdFdtNW0xdDZtdFhuL2tVMU10M2ow?=
 =?utf-8?B?RDhqL1pnQTlNTUdsd1MwWGJBR2JGVjNYR00vYzlHMUl2bDl2V01KOTc5Y2Vr?=
 =?utf-8?B?a2xKeGRKaGF0LzJHS0MvNGhGempzcEd3U01YZXYvWWNOY1NyRGhKd0l2UUpE?=
 =?utf-8?B?N3RzRVdweUdnRWswMmpQcWRNUnBOUmhQSDhid2QveTlyNGNCbDVjSWRORExH?=
 =?utf-8?B?alpXNUw1SFNLWWRwWkY2dkhsY0J1YjMrTUhTVlhhUE00TmlyMk54WCtWSC9W?=
 =?utf-8?B?MlZMci92ei9jWGpBTkVSMHJReXE0YUI4Y1BOMURoUGJ3emVxTlNKWUxrRDlP?=
 =?utf-8?B?SVpFbFF5V0ZkazJ1T21YMWFLVHFRRU0zdGNsTHFKemMreXFCL21MbzlvYzFY?=
 =?utf-8?B?WHQ2V1VWV0tmZ2lDR0dMRm9mdERmd3J2RlJLSi9IcjVOODhoVnhJWWJlUC9O?=
 =?utf-8?B?ZURpVndMTSsydVdsZjcwSy8xbEREQlhmTUxKZm5tdlRmZ20wMWo0a3ArVXV4?=
 =?utf-8?B?RTVuSldyQ2xoZnA1YU5CYXBKWExHQURHcEtVN29aUUJLSVVJV0RjMnozdEUr?=
 =?utf-8?B?TitiUWN4amI0WFBIY253bEdUNmcyamRTYzROanhzQkhQT3NCd1ZSdmV2UGhE?=
 =?utf-8?B?RjNWcXdEMUNYRVJ0dzhmRjBJMnFpbDRJaVRXdmpjNTZNNUNSak85Qkl5UEF6?=
 =?utf-8?B?b256ZkhDWWNmNmVnK05ST1k3RGtyWnZhd1drZURiZXkyYnVxUzYxWFRndlVj?=
 =?utf-8?B?czlFVVNXR0ovNC91STdGeStWelhXYnZDZjE5ZUFXemZSeDZJeXFsVmJnaW1W?=
 =?utf-8?B?Rzd5R2FXeTdqbFIxVi9UR2RUU2lvRXlOQnVpbnZ1MFROYjhSSG1vbTVBajZC?=
 =?utf-8?B?SXNsSXl0bldhTlptcHdwRXR1VzJ1cW10OUdZbXBkQTB3OFAvcEQ1MUVjSFBt?=
 =?utf-8?B?NUlFWWVqZkQvZ1pEWHErdHo3QzNnU2VrdWJDR0VaNmFwdHJlRWdidz09?=
X-Exchange-RoutingPolicyChecked: og+DrMPdcsyboUscp+JN+PybPet5ESkDz1atlG2TW1nEqa8crZfF57Pv8YB7r1WIU2OZngD0cNZd7zkMk4IRRCVRIzvfAD1W89VKykWjStwGXnFZJNm4THegpXDZnPVrj0VkNFOoQ7Q/1B6oGH10ZqTSd+Xx6oLPLPh1OcEWIrAtBhTWFBcyiDaWr15wstPL/xw7yZbq132x5WyTolDa+Du/8+EbxWKjnP77IWkAdOwzXG3wgU8SLsbOBXB8p6M98kJr8sYiVDBlgoHSx/GtRK0ATgbuZDcttcU8/g7B9MdOw4OlXBMzYS0AGAndYuA4n4Z+p0U9NKAKwx+b/vMIVg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c74ce84-e338-492c-6f92-08dec86a541c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5661.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 10:06:54.4136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDQ5fcMAduOT/ROHZMh4Cc2se2IP9/4E+G9uVfGhIXUGO3+kO5qzzO8OMd5m6RnfXCU2Rzdvm6zNeLhz9jacKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
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


On 11-Jun-26 10:18 PM, Stephen Hemminger wrote:
> Updated multiple networking sample application guides:
>
> ip_reassembly.rst:
> - Enhanced fragment reassembly process descriptions
> - Improved command-line parameter documentation
> - Fixed formatting and terminology consistency
>
> ipsec_secgw.rst:
> - Restructured configuration file format sections
> - Improved security association descriptions
> - Enhanced clarity of IPsec gateway operations
>
> ipv4_multicast.rst:
> - Simplified multicast forwarding explanations
> - Fixed formatting in code examples
> - Improved readability of routing descriptions
>
> keep_alive.rst:
> - Enhanced keep-alive mechanism descriptions
> - Fixed minor formatting issues
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
