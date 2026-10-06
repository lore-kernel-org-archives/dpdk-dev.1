Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA2CCA5FFE
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 14:52:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 881F040262;
	Tue,  6 Oct 2026 16:52:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id F20C14025A
 for <dev@dpdk.org>; Tue,  6 Oct 2026 16:52:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791298328; x=1822834328;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+72gJTuNlg4spwzBdfd3G83nntnqfCx1Cz6DXuQjfuI=;
 b=KieYvzVXGy2kvnG31oggN6CmG0koYLzAVJvhWA9FH51t/c2oQs+cm2lU
 OOpAiGJ3gPrcCdBzqSVDYvYbz3TcUXUjzm54eiS1CqA02YhttoK51djwh
 gwOX4Q775EOIDyjidAzAzjqWM9RWTbGuE8h2FSeXUvsUB58gwEGiUULq8
 5IgokuIgeR+x2j+i92ozU/46Lh/EIHkiKbiNZB/y5UvqGEXj7CgDN+96Y
 DaMdHjMEr1vHxwAhqfR0TKc9YM07kxPo4PD4jqC85HCqxEvq9LH9x3jLV
 48HqCebKQgx8RQeyEIZb4ZU+HmZL/c6GoaIWIox5OSeRXFJBGO9A6WGd/ A==;
X-CSE-ConnectionGUID: uE48HHzaSTKmOhv3l7poNA==
X-CSE-MsgGUID: McDmQRRVQfeh0GbaX0BZSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="102511689"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="102511689"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:52:06 -0700
X-CSE-ConnectionGUID: yJ4a9qfGTfGL5KKVK+yGfQ==
X-CSE-MsgGUID: +fa9Cb6SSraMCHVQLQnH3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="285268325"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:52:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 07:52:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 07:52:05 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 07:52:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvaqCkXwGMJgA9eCCUUTh95prPBOAWCqJVxW9TZu2tiq55EymUmEKWz3o54dIwRAdf7iJr21Nzxag7re8WMga5PmMJi4Xom2vBSKrlU3nK7M6xSe5I0c9tvChFBGCPa0piqkLlfUSWoE3i5bzEnAXg2gZNxr08bmYnbni976dQdRtsyLcLq43s1X1xMpeLk+FKZnQg/F2x2PR8RYBaYM11YWlJefX2ZEcpH6f2iP0ODCj0h5/w/PKG0M0ErTvTPXMfLLqQgyJj1tY6jpbOZ+fZrm8uv1oCSk43mAETjdm8bpi1CbnSGUubUDC9lUW1nqElKiqRO2LqeKHpeun9bEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=motlECyT0B82eM7guOab1CJyaaNM0/7qjm8/erzZ8Pg=;
 b=XM3UUnNslirz/yi9QCsVmkuGzvCaCJbTsBfrDKcOurSV8ukC/OLEPnAoiyHKH9sMn143exob/3vV2W3Pt7EEmkT0Ht6nravyRByl7SL0y4SZk8qqfXRs0b1surfPXm6jJ28OX509pG+dFdEggSvmFZrtdKiF3zlLMVAqV8yF3ektV0snOWC8+0bbWbr/6u764H3+1l4sG3cjzZtyVR/SEqtUQJa3Wk8HK6vYU709LHv5m2yfvxpAXlENMh4QdFbRgOhsZbos8kQKAD+6288BBfG4fTX/WX95qUmXFGWnMCPMTQqrVT3S7zMDH7OuUN0eUKqBfxXRsJgsuMytquDT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA1PR11MB9850.namprd11.prod.outlook.com (2603:10b6:806:4d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 14:52:02 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 14:52:01 +0000
Message-ID: <ad3731dc-3f06-4df2-bfcd-a6df26e8bdc8@intel.com>
Date: Tue, 6 Oct 2026 16:51:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/iavf: set interrupt throttling register
Content-Language: en-US
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <20261005110613.473007-1-bruce.richardson@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20261005110613.473007-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0300.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::35) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA1PR11MB9850:EE_
X-MS-Office365-Filtering-Correlation-Id: 161e51fe-abc1-47e2-d7a2-08df23b96121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: VTCPAPMKkHztp+TdPeR2LLBX42kVSxc35YtTzYglfG1zlMcdjljC9E7654OQAMxhJ8v1YKqEmicrHSc3gRIDNZ135vxttWFqu3CdbzcvIOdQibA+OkhmuPw0KLlbo9kin3zNHmxMA5bhwUTkI8vPRHaHF1oPVLqZQquo/jPKJQYBvTT01IiTVj5rAWZIjifvIvnxWi8HyZD40ahYfz+kp1eEHxZhvJpJ4OQjBoE2DJEtPmv2o88BXbeoc/M7+LTPeg94UlTGQXX9Upv6CY7qBMh3WNleUEKzx3vSLLFsNUdOKAz1OeCx1yN6hqJkzZWeXaMuivnYSke8C+qvvuswS3yqhf+LD2+5UgqXQJvDBjlMdz6uKxw1lAMoohVpT0e3TKCkY8DQaZkI/nb69RZaHq4pdn2pfw/7BytRDqAMd3K9PtWwdbVA/wJY90QtX9cZJ7RMbyXWIfTV4vCm5xxqjiKQLShp5iwdB1CPKbPCVOmwucFhyTWIap9ZdEKpN7RljLtXXB7COhffP4RaESe3hjFQ9eeS/N6qLZtjzs09j7r0aai897qzFYo8rTBA9+CYBRGGW04ON4ZD1+P1Gf/ay7hasmn6q6+cc+i19XWzrs3Mf8/gljyVMEw3cociSSjou/qOqWcB5lHgEYVOA+qCGPWosu08MYriTA8/hJr11cE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjlzTnd3aDJBRkk0dkdRN3c4dFBqZ3JrZStONThvNndFRm1RU0J1b0U4TGJk?=
 =?utf-8?B?WVV0clhveG9BNjlBZTk3cUpydGxBNHdBNzY4YjA1TE5PWmhlQnFFTjV6dWZZ?=
 =?utf-8?B?TS9hMFB3L2lRNHJyWjRmOE1ZdnpUSGIzd0xrUzZpUC80NUt5SDBKY1JZeU5k?=
 =?utf-8?B?NWVWQ0IyUFBvQUhIWWNWMzBPQ0RwS01QaHdnZUxGM2ZqbFBZNHhyYmRSUmQ2?=
 =?utf-8?B?cjB0ZUhwNDkrWjRDeTJNMjNGTWEvRHRheGI5V3IxZkhwZGdUTkZVNnp2a25k?=
 =?utf-8?B?V1QxQTFXY2FzUm5DRlBxTk5KK25pMVRYRnBDMURIU2FFZVd4VjRnU3JvalEv?=
 =?utf-8?B?Z1pNUXQ4dk0rbUp0Zm1EZzRtVVBWcUZIaVE2Vks2NExVd21nVk5NS2FhS213?=
 =?utf-8?B?L2IzbGhkOWUvUW1Zd1FxVEhxWUhuQ3ZwWTRGd0x6ZkdtK3NyMGpGOHpvRG9W?=
 =?utf-8?B?Zmovd0xlcDBuWlNBOUtKcnNaT3ZKdGkwRDNia3JrcFBjNElGdXZ3ZXo5UEQw?=
 =?utf-8?B?MFgrRFBmK2phcDFpZ3RXbTdhNXFSTktydG5wdS80Q3ZCcmlnSWFhNjlNQXJ3?=
 =?utf-8?B?c2k0M0Z1TWR3SG5BWmNzeGVUVWNqZ0IzUS8yOFRaVUpTVkpxRCtTclpmWm8w?=
 =?utf-8?B?OUtNZHF0QisrNVNXNkJZQ1BOQXB3RmZZQ3Z5Z1d0N0tvdTM0NWhYbmpEdWlC?=
 =?utf-8?B?S21FM3ppTGJNVmwyZ1JPWjQ3alV1dVYwYjFwaG8zWDdkZllUbjUyY3RrdjBp?=
 =?utf-8?B?bzFkT2I0QURRck5mYUZ0SUsxdCtMM2dDeml1bE1PRnhMdWVZNHpPbm1LRzlD?=
 =?utf-8?B?V3N6SG5PTE1OeVdISm5SWnJ1RGhOZVBYQjJzY2tOTEhQSGFoay8zU3QvZng4?=
 =?utf-8?B?NHVNTzFjOHBwYUNQS1JjZ2NsUllZaUJtbGQvc1I0V1RwQTlLcDlJWXhCNEpx?=
 =?utf-8?B?WmFvWC9USWVMeVB2OHdva21MSkVtYjNZbm1QdXhOQkhGV3NDU3RkTXIyU3Br?=
 =?utf-8?B?Y2ZOMWVWMXF1THZKWXNEU1pmdEhrOWJSQ2xDM1Aydzh3WmJDeERNdFJIOWFr?=
 =?utf-8?B?MlZ6NXA0QXdvUnFCbUpKZk9tc0swWjZDakZJelNRMDY3cVpFMWdoaUY4V1ha?=
 =?utf-8?B?K2NSTkRTSVdTNkIyejRyOGduTnNIdXdSZVVhMGdyZzBaSmhTRXE5d3pyQjJI?=
 =?utf-8?B?NVJ0cUl6U0hIeC9oNE9TRlVkRkI0RkhmYlFOVTBiWHR5dk4vMjZyK2M1emRx?=
 =?utf-8?B?UGdsVGZ6Z1RJOWFpdWhIemk4U0dHMGJFMUxQRU4xNVUvR2kwRzhqbzRFNjg4?=
 =?utf-8?B?RU1OWUVtOXhLTWF1dk5TakVBK2NQMHpucG9USFF5TEhXZnNYVW9VbGlyV2Nn?=
 =?utf-8?B?cTQvQ1cwVlNTOUprc2djR1hHaFluM3FXdDB6M3hmb3BqVVNJSURsUU5OYU1B?=
 =?utf-8?B?eE55eE5VWXhsOUhFZndiVWlLcTU2Z2llcnBGanZQMjlOQmwxS2k5TjZvNkhm?=
 =?utf-8?B?U3RXb2ZqaGZ6U3RQUFd0RFE5WjFlRThUVTB0cEdjT0swU21pVTJjckp3OUkv?=
 =?utf-8?B?NG5zMjRMTzZBQjl2Q0o4eWlhNlJaMUNGajRHVTNaS2hXOGROd25LUkhYaXZJ?=
 =?utf-8?B?VjVyNGtpa2Z5UmtnYWdMRWFWYXlTbTBTU1FhVllFbWJzT2dWQldRSTU4TlY0?=
 =?utf-8?B?M0xxcG9VeUc0eTQySUd5Z2NaLzYxS1RKV1BXS25saTc0VVFjSEJyNWtLSWRj?=
 =?utf-8?B?Vm0ya2xDVlQxQktlQllta1ZFVmdwN09ZcHY0V2M5MGQ5ZkdrSldjRUVUSUNE?=
 =?utf-8?B?SThWK0Ntd1BmVjMxNFdtOVQzQTVzZWlpNzBQYUxnS3JhSmRzakY2QWI4SHZL?=
 =?utf-8?B?aTliMHlFVTc4U09hSGFsd05NaFhSUDFrdk9kbnM1YTlncDluOXRXUC8vSnRq?=
 =?utf-8?B?dHNwUzNzYlN4c2RmUlorN0pLNDlDYmFCaklxMTZ4c2x5MSs3Q1NiR09XV2pG?=
 =?utf-8?B?TC8wYTg2T05jTHFHcmtwYytRWkFDR0srcUJ0ZzM4aXF6dUVLUUZPMVArcUhW?=
 =?utf-8?B?STVudGh6a015UkFUQ3JRcGJWbmpuOFBFUjlZeDlyZ29vUnFRSm5GcnBJRnJO?=
 =?utf-8?B?YjVIaVRRTTBlRWhDa3VOMk13MVl5NWFWa3MvWVY5ek96VGQzT0dOd3Z6Vis1?=
 =?utf-8?B?V2Q0aWlsdFlCczJlaDR2NVZyR2tmK0lXZGJyb0VLeGFjWlcxZmcvQ0kwVG9S?=
 =?utf-8?B?R1VPSTQrdW9MSStXV2RCUElLY01lSHUrM1dqYy95UGloUUhnVENocHRINkR5?=
 =?utf-8?B?NmlqUWhlVU1KVVdWQThWQ0dtakF0ZDdSdGx1TXZYWHhLUzFOUWg4MGM2Vm54?=
 =?utf-8?Q?DwD7b3a4E5/aS0Ps=3D?=
X-Exchange-RoutingPolicyChecked: qGlVSO7OoGNAe/Ft4A/iiZNDdzORFRmuSRDviuFplCMh1esJxY+CNgBw7irhaTPHdxLFuEMdX60YPinYvzrpvkaCP+PN1QOw5vR1PsB2VEzLEb69YOIBWEKWfVddCQjWRu5Q3l8PE4aCDeQ62kXkWH3cYS4S3g9PqdqluVBb/RmH0EGNtt4CWqUzqTNzEVfhjorBKQfzYHCLe/l8O3G1cjeuLtp15cf7bcg057oUnHwbeIX5GYbpROE6NBjzk+M78huej+ta24gAdOs3RHokN2DmaryKyOH8jEuKZxfFqCYQJV4JDNbcU1+O4XndPha4U7mWKn/DPMnqtuVHfnYd7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 161e51fe-abc1-47e2-d7a2-08df23b96121
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 14:52:01.7830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSbr4iRJNsWOb8tVU+/jI5xZBLgE7uOFDaZLHG32yceYusySF5OoDFWB8S3X45Zqscz/OAtSwhPejv0LtvysfwQYUJQpBFlcqC7OKICKIy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9850
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

On 10/5/2026 1:06 PM, Bruce Richardson wrote:
> The interrupt throttling register(ITR) bank 0 value is set to 2, but
> to ensure best performance across all systems also set the bank 1 value
> to match.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
