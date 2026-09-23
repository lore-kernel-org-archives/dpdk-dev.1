Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26FEC982FA
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 12:06:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD25740262;
	Wed, 23 Sep 2026 14:06:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 304F74021E
 for <dev@dpdk.org>; Wed, 23 Sep 2026 14:06:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790165169; x=1821701169;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1boyT9men+S4Uk6Wv5gJWX0EO+RvfK7ret2kT7BnnQo=;
 b=Z2IfsaxZapFWtYWPgBpsjYv58EzFWdI9ZyYmC+LZttRIEx68TKQCMNPg
 sec/rgHLG9Cw3NPYlrU2T3U+AHnFDFAa60keEylJy8C9MCnkhSNkAv1WH
 cZ5iQAH8++BcPyUBtU/aLVPVm0QnFXC16tDGOhmHYz1tBgm5pSioDlur5
 uV+5Ue5p00J9/3W6+XodulbmtCywmssLG/IRtUKBVxh/eN41OHR2jz+1c
 d6+41ylFdEIGqZls7/ry1YmpRvGOKmFR3qsKTKaQDsA6jBGcw64EuNGNe
 hPRIKIKRH+51iUhtCiSFBYni48weL4mrOuQdKMcd9baQ4HcLt4QEdsPZM A==;
X-CSE-ConnectionGUID: s1c/aSKiTO6Z7cz0g713IA==
X-CSE-MsgGUID: 2XUWlnQeSUC3/Ro/dd7xYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90967008"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="90967008"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 05:04:26 -0700
X-CSE-ConnectionGUID: yNp1w5oMTjmXdisVJDjwOw==
X-CSE-MsgGUID: uomEWXVqTy2pxpzJxP3/SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4667089"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 05:04:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 05:04:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 05:04:25 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.37) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 05:04:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGtwwrGdAqcqnQHqg8pCSMAELdP+iSa6HsMgYAo1lA7NINJFjOTlSlh1f8MiaCq3Nd7vABT/yi1BAeL0PC5CswfsZ08AuM6AkLBx1fJ5R/EvKF5PdP4dJuLjodSxWX408hJ7grqT7MD2gcR9djIIVno9nIQUQjo140sriQ/1kUeYBnd3k9ehb1tG+9IFPwzHBn+9u5nFigWzVELltgt6zVK/HyTPrjh1Z6WRF8FWeCYcXYfh1aQLqxbU3oUByZaw+RGtQxp1ZuYSFuF/mdojvPjHnt2Pt1YA2fbMmM5Set1/RW1UFLJ3vUBxYrvRwHGYyw8dBHj5v/3JHUDilTnLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/Zh4XOpXscUVri77RrpCRFhfipbig3WUYbi+CnwV+I=;
 b=XzkytR4ty5gbRrIIuDEa843mZMuM7I4f/bYz77gmkNHDnCoa6B0w7Jq4uVFGYEFd+gKHpOly28PMR8p0iKAadn9zRxPUqHHZ4dzQOhfAd3GHyvIxF8B5dAgtz7+ie6/5SE71+9sY1QTUxKDmkqsAKMcioDPbPhabb9EFQQA5Q/nL5C0sK2gxDYZZcPwuBDnbbOEzRo+3gmWLT6Y0zG4rrCSmna0M2Mb+Pb39oVKHBG5ZaTOrc6cPYsE0XUzvl5bzss+8AimE9MDVwSvq28xTQkPYjhJMslQmQ8gEaOW0JhF6oJONYqlgSNZx9hEAmWhWyLVLhp0OnTyGn/ToAtJZ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SAVPR11MB9573.namprd11.prod.outlook.com (2603:10b6:806:4e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 12:04:20 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 12:04:20 +0000
Message-ID: <b608ec63-fb12-48bf-ab2b-c65e9bab7675@intel.com>
Date: Wed, 23 Sep 2026 14:04:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] net/iavf: add a helper for sending MAC addresses
 to PF
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <ciara.loftus@intel.com>, <rjarry@redhat.com>, <cfontain@redhat.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260914081725.1097704-1-david.marchand@redhat.com>
 <20260914081725.1097704-3-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260914081725.1097704-3-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::24) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SAVPR11MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7ca93b-835e-4002-81a3-08df196accb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: A705+BtZt7p2nK9AvtCI8rH3AMxKUhzvgGqUoiVGy8H6bmecOq3ZoKzWt06e6WE7/aOEkgCChnUmfLP/344G+GOkr0ka2MOfLf+jTfPQ+yEiaE13q3EyQ+mhobyWZs7lyaK68pJpCkZmwTiAC2nCDXe42j7j9p7javXIWI+Z9xnffHd2DFYX9PET5AEfFztbJ8sNyhtIIDOoeN58T/LgynNVJd3ahRchNSjs7KIoGE2Er1rwweCZZPz+zFXB9L0s/DkALg8GRJQMePYbFjUMgFxdZ2QtcF/2R3BVRTOXcFTp9nQNQVsZL9Xi5D8xAFlypwVVwpqq+YEDYNjEWHuT7qQ2EsMjHUH/l8TyosnxJ3lKl9ojfz+dQKNsiwww2WluZd70GNGPqzMRu96UFwxSFgMKKZARdcDxTwMIfmSQlqVKkyhbk4j32N/AcmXSjYQ4Tq5e9hy3/OMc/rLV1GRY/7Rg0M5qrne8kbBDihOMvec/H5XgKSfOE9PvCN3kHXlcbLAGN7Lq43wH5IBWU8ob9bnHsVw45e3L30M9XhQyANgmZ1WVT8IoBtcnkZG9OcaBTo/1ogetV0Vu/Y+zuvLKCehpatNehm8ljP/fSgMLVsXkgf3RtFoZj59y94IIVdI0Pw1M2qdAX4FQorp0/xc73hQsOJpsOEVdrI33eoRw+wM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmp1emx4YmRuVjRuckV3RzFybDY0akprTmczTm8rUzhuRy9SRE1BQThkbmg2?=
 =?utf-8?B?cHlWb0Q4TWsvUUtsZHhuamlYS3dCcVFDTldXa3FTdVpCc0p6S2l6Y3V5V2VP?=
 =?utf-8?B?K0NZMDZ4SHV5Q3pyNTc2K1MzOGg5QjdzbExLdXVNWHBEYmhMbTNwa0p1QUdM?=
 =?utf-8?B?VzdaOXVzdVJheUluMkx2T2IxSXdmTFJOSVFOdVhrbDhjSFFKTzExSnplRGFE?=
 =?utf-8?B?a215aFZUdHZrMkxLaEhodWdWV1hkOFhrZklPNUtzVTFPbzI3dnJVR3VaUllw?=
 =?utf-8?B?cXVBQmpyOVVBcmEveEVjY0JCWWlKWGE2WVJmb1ppRHhxRWZ3UU1BbkdEMEFj?=
 =?utf-8?B?UGtiZ2ZzYzAvU0V2WGRmdVlhYmplTEZzaGprTWNocXdXVEt0aFVlRkNHYmNT?=
 =?utf-8?B?R05zVjM0dHdxZHFuRTFaWnpYYVN1NmkzbUVpRkdQYTdKVkxEV1NWZjlZeExV?=
 =?utf-8?B?MlMrbmFlZ1RmNkJNYVU3cFhVd0pMWWQ3eGtYRUdHL2RmTWR5VzVOVUkwUjRC?=
 =?utf-8?B?MGJwcDBmRS9KUGxBSHdBQS9la1ZTQTZueFdkdWIrRHlUNmZyWktXSDh0dGR3?=
 =?utf-8?B?akl5OUN3cmRKMDlUbDRNdHV4cWZ1WGg2bzdKSEVUM1haVmNYN203UklGTi9B?=
 =?utf-8?B?NEQxQzlGQXd5MGJIVzBEMDN5VGx0SmcrSzJ3R0RVNjZXcGdDYWx1bnVnblNS?=
 =?utf-8?B?YitSNlFxZ3k1c2NvQnB6NDhCNWpkQ0wwQmVLcXJaR3BCZ1lrL1lwSTJOTXA4?=
 =?utf-8?B?K0NOWVN0b1JPUGgrV3llNkZoK1RzdEp6OG9admQzcDhzNnVqeVpXTm91cTRy?=
 =?utf-8?B?ZnJ4K3A4dVJzNG9JOFZSUGhyTjlXb2NUSG9Ec1ByTExZb1hZbXdvYXR5QVZy?=
 =?utf-8?B?ZldydzdoQzU1T2NvZk5PV05oTWtVd3ZmN0sxMElrbGd6M2UzTmU0NllHTlRJ?=
 =?utf-8?B?ZDJaTzgzKzdKNllaNGxlSEF6RGoxb3JvNzJoRGVrWDRSOG0xSWhBcGsweFBX?=
 =?utf-8?B?eEYvb2NIeTdNWERSMXFERGZGbkhwRHExT0tRaWRaSmJHZVY4Rm5PWThWUmJR?=
 =?utf-8?B?V2hsckFYVGtaNC9vR0RPcnoxUGI1dkFPUG5VSU1za3VNRjMxc3JDdyt0QTBW?=
 =?utf-8?B?Rmk2SXJ6MFRrWmRhUGdmSFpyb2dmTkx2MnQvUVA3MG9BU2g1ZmpYRFhKeVRn?=
 =?utf-8?B?WnpPaitwbnkydGRnZGNOTUNZeWFQaXBxYVYzZ1FLRTkzbVZqTC9DM1N1UmNX?=
 =?utf-8?B?cGZOMVVqa0VudFBiODI3RzRTYWNnN3RSSXBuaU9zVWRVWDFUc09jRTZOUlAr?=
 =?utf-8?B?OWJiNW95NEtDRDJFNUUweVVSTnFwa1F1Q3pyOXc0MC9lYzdjN2lyVDRWY3pQ?=
 =?utf-8?B?Z3JPWUtzNjNsN1BmekV1Q1ByZk1Nb0xVV0NHOXBPb3dBNWU0Y3g2R1ZDQlZI?=
 =?utf-8?B?cGl4Q2dOeG1IN2w4OFAycGM4VTEzcUtMVUpSOStLRzlJVTMremtDRUNHMEJw?=
 =?utf-8?B?T0llWjFYakRLdGNpWDY5SGZOZGE4eThBZXZHc1ZCN1lHdGpRc2ZqZmFjanBG?=
 =?utf-8?B?ZkU1NGRyM0R4WFNQT1E4UHlQRHhyc0RONnkzOWpTdC84RzBNMkNGcTNGVytI?=
 =?utf-8?B?Nnloc2Rzb0hyVXVmbW9kZnhLSnEwNWRwZW1Vd2dsdUxZNVRvdnV2NktVOENY?=
 =?utf-8?B?VmRYUEl4eEFuRS80R1pxeE4yUit2emVrcmRYN20xWFo2Zyt6aCsrb0RjWDFo?=
 =?utf-8?B?NzNLcDVZeXBub1F0OGM1Q3hEdWFiekpvSWRTTUJyejFUQncwT1VsQmEzM0hV?=
 =?utf-8?B?ZzFFSFZCcW1wSVgwVzAwcEpQRGVuSE8rYjVuZW5ORjNZYXpCWEc3WFhianlx?=
 =?utf-8?B?V1ZiRDBqMUNJWmJLaVJhWmZTWW9IRHp2WjRwOHdxeWhnZUdtNjVFU3htQk9B?=
 =?utf-8?B?aEt1NGs5U0Jra0htcG5yRFBXTHhPMG1IWkFub0xkTnluOGdBL0Radlk1Q09j?=
 =?utf-8?B?TVduZTlwY1NpUVJsaXNab2J3dDZIV0s4dzZPMmFRYzZQeVNZMkRVTENPOEtv?=
 =?utf-8?B?UjBKdllwd3NSQ0Q3L0RocmVyTlFpQVNhdW0wUlgxcUNoTUZjR3dXWGtMMkdm?=
 =?utf-8?B?OXorQVB4aWxWK0IzOGhzVU1uNkkxelFZWnFyeHB4VVN4S0hZaUlwZEh6aS9a?=
 =?utf-8?B?cjlGcDdnQmNJb1NtbmhueUJVWEhLSWU3SmdPekRxR0l3TytOdkFyQWpIVmpY?=
 =?utf-8?B?VXdXSDVtNVJWZkdtdTJxU29FNHBWaFAyZy9tbExHRHRhNzFFRzhJcURWUmVy?=
 =?utf-8?B?dVZtSms1NHIzdXZYYmtGVVA4R3hpalF2M2l3V1ViNTF2STkyS1NKTmwveUhl?=
 =?utf-8?Q?RWSBADalwIaxjIAw=3D?=
X-Exchange-RoutingPolicyChecked: ktXjOafN5EMlfOJ86M/6oFmyH/oCsxn9xhUMLvLeXomdSB5nKv3IXS+dGQ1GYgeTdlehY5JrMdCaZVDa1mRaC3G8k1BAOSDV/B0Q32jaoeGJCJTKTe5dvS3GBdHRO7Ox7SYHkyHOewTzVZAYmXFt5hHetBrGuysN/TVt/xIKWZpOgndbCxRdyvssH+NPAEzPkCJkWb0bVQCK710APwrR532vTpHzT2JMY5WIHSjNuJHkcKSysqXZU26yOUb8hS5kxiV6Su2qqKYMpBsPX+Y58TMZ/d0ulZnjHQUyFgyjMQeKaB3YyHPxHRUZPiCwg0Xuu4O2RvztFaLVtSKDrakxVw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7ca93b-835e-4002-81a3-08df196accb0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 12:04:20.2821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFC87MMmXJcsBG3jN58CjcTRDUuvyhXsFCL1LRFPxIcxq/uipqTmMDtAKMVoSV44fsBnffbH/qxlwxP8JS/x0DUCcKRBTeX8jRKDej4xrw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR11MB9573
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

On 9/14/2026 10:17 AM, David Marchand wrote:
> Rather than have multiple implementations of the same code,
> define a single helper.
> 
> This is also a good place where to check if the driver is requesting too
> many addresses in a single message to the PF.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
