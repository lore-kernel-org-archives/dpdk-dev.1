Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AAECA9EC0
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:32:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E1514065A;
	Sat, 10 Oct 2026 20:32:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 57A4040658
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:31:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791657121; x=1823193121;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=ni09r9kNx3Shxz68im3w/DDRPTvzRysr7LsydEjWBL4=;
 b=RjVY4MgpbsDEKtrNW3H9ocDaJLa2691+cqVjS71bVeB2KvK9xrdJ6ffl
 lBXzzGqUcUs881qyXwsdK+XGnclgmnArnqG/ExjVc+tRIYh/ZGSU5DXOV
 k6kNP4IwSG6kMMn6UpUekQuOZfCJHVs3E4cA2ilxvU2c+3Zxg8KFjEP0u
 rONbSjFZcEEsdMsbDS/93OeR++IEAYH/Y38qwmkJnnOjkeKGkRNM9pXu6
 VEdps5sMf7qbiruRM0Nql0ehyyKBs75RgZ7AfuSJivJbv3GfyIaWbfs+V
 V3OsHlAPLVxQ5HizUwmlNDOUdgiH/c31kRnV/w0QReuQ9hon+oC8iImq0 w==;
X-CSE-ConnectionGUID: hMAkS2DCSjKLz08RzJgTMw==
X-CSE-MsgGUID: wI6Ie6dvQQ+1e111AFXlwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="521430"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="521430"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:31:58 -0700
X-CSE-ConnectionGUID: eM1TTgiRSPyK/zaqC1anCQ==
X-CSE-MsgGUID: FZF4svUOTy2OQCH0CCVIZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="2357486"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:31:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:31:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:31:53 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:31:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oauiS6EpPGt3PC/Foqau2VUSUFXU9q17mAHWCB9YsjoeL403XXhwcnaLTfX2AhxZ6k6L+7J7t0NKOtAm2q/oWjG5GeO25sgwBI8ZYk+Dzffq9atr/7VmiQegrBLuC1da0LRj1PUH1R7AeYiQh2Ekr6ZTbt1fHu9kt6iEPeX1vzCbgT608geDDpZ+fMy/UJoCqcTSRZffNdRJV1f1ZeBoVt01tbyThOQ/+qA7ZsKAuKuzDY0wXIXP//8g/kLmB0VlIo3oj3RoVBwOesWsJFK5swbGPdAdFPdeE++MrkCOYtonNCl+uQY+UnG+afSH5pIND0oBEiQ9vB8EEJFAjKVbYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqXuR8athIQWwLW3VEwPhhS5iwYuFoYTFXWgleS/C/Y=;
 b=ENbJ+Rtfk+f0+3eMULbtR79+CHnXTbVeOJRWlDYo3pBRihOAEibSpxq3xRCedDhajyQxzkLUBrBNuRyY1FCGOjO+HD//47zVUV3W2222FstrBGQsadnLwFpwFhS9UkAxBB8joRQ2SjatrRVIv9t6i+Fh80rcCm2WsiecAuSOmkBxbs3YfFpUPjvEldPgSloul0IpCo76HUP59O4pCQvg4VKm8kDbbNeeW52cRiw22LjXEF70ZDDn2dVbkYTTvZHqlvfkNiXxRoJQe2x8QhEqZhYcjqBH7Vmefx/i74wGofOliWv+YP9y+xQS25WeIa6g99zgTgQ6Q/eiWS7kce4HTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SJ5PPF524F3F9FA.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::829) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sat, 10 Oct
 2026 18:31:45 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:31:45 +0000
Message-ID: <2941526b-3840-496f-9a45-958ba907a5e2@intel.com>
Date: Sat, 10 Oct 2026 19:31:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/25] net/ixgbe: reimplement syn parser
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <b050af1f631ee04c717bc59d2f10933393b34071.1791543154.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <b050af1f631ee04c717bc59d2f10933393b34071.1791543154.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0067.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::6) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SJ5PPF524F3F9FA:EE_
X-MS-Office365-Filtering-Correlation-Id: 18aeb805-2232-496e-5330-08df26fcbcee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: d5qnTnl4CbzgDW8qiO0ciUgbeL0mHJegcE58xzLjIDrtzeooTDDxrpRWXxb0QcVJAyEFh9bgm26USnW3iyXMhzgjdp4ZGR84pkFIH4Ex/N/VxZS6KWpZWCBaXnTjbJm0Iu6PWXWIE0IfgAGWTv+krABVHsrqEVElmse+kmBRaAnYj22ByIOMV3aUFSDdpK2LO6OlY03XJL9KwhaXKWgTnaY49xTeDycBEXhQoyTSxD2rXCwQOmf6BOkZEb7P77y0HoXm8qTd7YAZOlLXAGi5iAU7xyATGKDn6nPzea9heTJK1Y+QAJ871rU7G7pmluzZZsM44u23fsTs0d5kVQvhe6atUSk2URHOXQkcR8QqbjgaspiDe86vs6eE64imEbwBx9l/6kX0Uz+pTlZAr8O6aLqK5fyZB5ibzB32dp0urRoJbh3WyZGTVk08t7E4zwiGCB3ndiD/+HugDvphXxCO41qGmQYzb1CsyySpVryuU3AYeq7AeUiIJ8Rx7mi9GtokJ/WiWkPrirNa0ezl/MuPkp0KxCZLSD0ViZFKwwwgo6Ohq5ByRcXEAiegTW9uYK4eZsyZAj2NNTA8phiM0LhojIl3kQtTzaYd6bREKviZiNWkbflI97Y2Jg2F//XZ38vgJW/p9WgJiliZiQra0dAIAmdHGVErJvXm4rW7UTdzOOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0ozaUY0ZUxmcUs5UDZ5RWc2bUhtVVRGVUwwcU1iaXNEdkQwcWtKblVTRzE1?=
 =?utf-8?B?OWVoNTJhRURHNUJTcjFCckQ4RWV3d3dRd1BneDd0bUtGV0JlVHFVc252ZkIw?=
 =?utf-8?B?RnFnK3JzVzgrcTNHdW82YmcxSG4zWE1LZ2duYW5jV0drRUp0RExFSll3Vy9X?=
 =?utf-8?B?Q3FiTnZ4c0RjU2tkN3A5bXkwb0tSeWYyaVZvMExLeWFEakE0ZFVWS1RwVi8y?=
 =?utf-8?B?RWR2c3czZVNINnlYczBuaDAxbldLemRzWkU3aEdPMnFYZDhkTUNQZGt6Yk5D?=
 =?utf-8?B?SG9NcmZ1cTlwNXpBWEx4SVREbG8vc0EvUHlWSjdmbHJGNnRWZTdNQzdkSUY1?=
 =?utf-8?B?MHg1VWZnbXlkQ0J0cU5rYisvZWNheDVOVVkrQkYzM3d3R2xJUDArZTl2QzNM?=
 =?utf-8?B?cEpoRmU2QXpWa2lRSmVKQ3JDZExYSDJhMkZGc1Y2c2tXeEV6MWtVY0M1bnBQ?=
 =?utf-8?B?eDBmWGMzQmZ3U0hmTjRTaWhKcERZMCtKQ0RPWXFSRjBJSXBldEtuNW9sVmVr?=
 =?utf-8?B?THFLdXZmdDhsRFJHaEFrU1huL1FJeVl1TzJwZk5LT0pzVVBPUGdab3RYMGZS?=
 =?utf-8?B?bE44NlJITW1DQ2dydlpPQ084UG5YQXkyMmthaGRBQ1VlVkd1M1BaUTFrVThl?=
 =?utf-8?B?Q2luaUx6WTB6cVl6bytYeUNYK0U0RkZPanlpNTM4SlBNSWxOeks4RnVJZXly?=
 =?utf-8?B?aGRiNWJuT1ZJTEVpNmFDZG8wSXlDb0Q5SlRRVGcrRzNWV2U0L01xek44dzB1?=
 =?utf-8?B?N2NWQy80SHo1bEdDeU9FSXREbXVTSXM0ZEtmejRYTWxqbXAwZFlBT0JYSTNa?=
 =?utf-8?B?VmpaWjJTeEozRWR3bmxzZGM4ZFEvQWlvUFNCUkRqYUMwNnpDZG4rZ1JUL05Q?=
 =?utf-8?B?aHFUQy9RWEh0aUZIdG1kY0lFZ2tEeWc3T1dLMk10M2ZrQVBIS2lpY29qS1Q0?=
 =?utf-8?B?MENJeUNvTldvZ3dLcU16MFBOWFEzOEQ0THlNcWR5eXYxUXdaYlZZdFRydHdu?=
 =?utf-8?B?dG9jbTZjbFZvckFRMWRJNlpIdk9SeE1qbk1RVEZwazZyaklscXV2VFFKTEZS?=
 =?utf-8?B?a2YrTUlFaGZ0ait2aWtwM1JmeHZNSXExMlhHbG0rVmNCY1RuaVcrQmxtYmx0?=
 =?utf-8?B?azJ2UXdZMkFXcnB0aG5HaUxUNnlWRzJlQUFzL28xSmRvT2JlSTJFK05XY0FM?=
 =?utf-8?B?bTdTZWFKd0l6Qm9PYzRUdUV5UXdNZmE3RXBlQ01GM0VYVmVlL2dzWDZRZkxv?=
 =?utf-8?B?M1o3clRwVWxudThFZlRDd2loOCt6eW9aSFlYbjVjKzc4VVVxY0JPVmxPcFV0?=
 =?utf-8?B?T0kyTlVMU1p5eDdlSURhYUtGblBmckpoRytlOW8rU0RubE53RTZIT3ZDNDkw?=
 =?utf-8?B?dkM0NjRKZ3N6U0VaTEUvVWVsb3dIMEpwZ213WkczSHltTkhxYTNSM1luVDNS?=
 =?utf-8?B?NTRkNXBOZ1N3MTZ5ZXMrNC9PUGhVcmpFak13WlRIRndQSlc1S2pveXFGV213?=
 =?utf-8?B?ckJ6NngvVi9CRGVOa2RTaThRZDY0U1k5SDhEeS9kNU5iTXQvWGZTVk5BYzhr?=
 =?utf-8?B?dXI0M3doNlhySHNSbDFQNFN2bU9keWcxdjZ3MElzOExnZyt0QzBieTh3Nloz?=
 =?utf-8?B?MWhzY3dMM2gzK3VWOU4rdFJtN3ZYdVo2Rng1dnlSR2ZzYStaTVE3NTJmMW5I?=
 =?utf-8?B?TFllMXFNREsvNEdsM29lY3VqVlBOZ3U2MlkyeEVtOExWQU9ZcnlJdUw3RnJY?=
 =?utf-8?B?T0hRay90Z1E2WUI4Q0lNeTF6Q0h6OTRDeTdxSlJUd0lTeDRuZnNOc0RNd1ZY?=
 =?utf-8?B?ZzdxbjZFMUFvZThsRTdOaWpraUhDVjhXMjM0elZ1ZkpGbllubnlJVGoxSDNV?=
 =?utf-8?B?T0F6ckxYUWRrcTNGSXdUMXZvd25PU1pRK3NnZG1vSzNlY0NYZ2RSSDhDZzJ1?=
 =?utf-8?B?YnJXVjdtUnlYbGhYVzlHbU9xeXBKblBpME54cEpTR1liWGNlbVp2RmltbkZp?=
 =?utf-8?B?YjZlK21iYTVNV2dJZGk2ZGpTVWxtOS96SktmQkZTaUtPVVpFU1VyT3ZHdkha?=
 =?utf-8?B?VXJmUVQrekpLZjFoLzdCc2lxYXJKU3A4RkNISGZlK0thZmpzY204UkNhdlhK?=
 =?utf-8?B?V0JPMXNZSGFRTjBtR2ZEZmE4UUEreVBxczQwYyswdlJwcU5EOGNrd2MvR1Y4?=
 =?utf-8?B?azJoMFdUWisrQjQ1NUNCbVUzb1VqWUFoTmo0NUVBWERVdHRBZnRRV29uY3ZT?=
 =?utf-8?B?a2ZJUnRVTHBTMk53aWMrdHJWeldSQ0hzMFhyMDhzZ3NjY2pMWXVLdWpCODN6?=
 =?utf-8?B?azFHdjgvaTFIajR6QU9KclRJOW5ZSnQxV1dlTFVhYjZiYXZxOElRWHhNYi9N?=
 =?utf-8?Q?idWo1be3f6YokLcE=3D?=
X-Exchange-RoutingPolicyChecked: nLP9oIXiZ4tFRzx6BAEKmO1yFcmldBLvIswEVTrtEUL+oSXIxktDvvDK2YFM24dl4NvLt1nBg0nUyTKw3QXU/sryB05bbqPFrNL19DRewz2h1OQZ53yeQBIbvI0kcJVmbzudD01XXI7YaCjt24fFtVd/gQZK+n3/Rcwkg/cRMJkrw9qhzrkTtF+Ghww2cfwveXTPKaDZWPR+5xeQhSVlausqrR8soyT7d2QCvTYf4OpmEZ2snu3U8icWHCNCumQBYIMQZbMUoy4Ux34IEt7Gp0hgW1il/4CSpQbCZ/CtmasLSOQWWV432DEG08UO1ClgBWAjc/VUeshMF4kt0Gw92g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 18aeb805-2232-496e-5330-08df26fcbcee
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:31:45.4649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gN6YA3WzgBRunoHUfYOrVWXTD7bk08bKfYzO8fOpBBunZzZtc990n4olgdcwCKtMsTOeeD1s9vnz5Cr9yi8VQPmf0D9k6bRjeLCjt7HnVYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF524F3F9FA
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 10/9/2026 11:58 AM, Anatoly Burakov wrote:
> Use the new flow graph API and the common parsing framework to implement
> flow parser for SYN.
>
> As a result of this migration, queue index validation has changed:
>
> - queue is now validated at parse time against the configured number of Rx
>    queues (nb_rx_queues), rather than at install time against the hardware
>    maximum (IXGBE_MAX_RX_QUEUE_NUM)
> - the per-function queue bound check in ixgbe_syn_filter_set() has been
>    removed as it is no longer needed
>
> The syn filter tracking infrastructure is moved completely inside the new
> engine and is removed from the rest of the driver.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>
-- 
Regards,
Vladimir

