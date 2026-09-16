Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5412EC88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 11:06:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FB23427BA;
	Wed, 16 Sep 2026 13:06:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 9B6924067D
 for <dev@dpdk.org>; Wed, 16 Sep 2026 13:06:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789556789; x=1821092789;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jCB2qvLFDh4VsiKkEYOOH29qzFR8uhCyFdQ53iVZrMk=;
 b=RH2faWii/yBx6JT0AOI/pNBgybIjBFM0/ljokzPzRZCM/4AVXGYaHDeA
 wspkiBBj6pm4HMtxhNl6VkAryXKYiL8+qDMQk/ibkniGuINARhcB/vaMV
 jlLGXCm22WgI+sIgrOvfXExJco0DdH3K4wNgtUqisPuLsFsNmRBw4rWbE
 R9/GBNnMh9xpBBlx8afZtRC6Wm0iC0H/b8UsU3DiMUSl/b3qwufSBGtNa
 ENCUGeaMQE15Ptnw5e6IEgJb/whabVBPigkf56miizt/nAS5XRUjLFnPz
 K3mrLMlVVLBsWwDCRZyRDkFxEiHGEXuxJFvaC6I/t5AmgFLTV8jwmEsdW g==;
X-CSE-ConnectionGUID: SV8Vv33JT2+bpAK9e3nQCA==
X-CSE-MsgGUID: FNGZg2+dSkOMBgwsP1PdWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89869998"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89869998"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 04:06:28 -0700
X-CSE-ConnectionGUID: Zw9MPsPbTyqo0I9Ynk2zeA==
X-CSE-MsgGUID: sN3EYKDlSpuMl4Sqh5qwJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="311595068"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 04:06:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 04:06:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 04:06:27 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 04:06:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbFuAeT+pzD6HpiX/9Q+XW/AmvBa+7spEC589CtuVITgTCVR97vnr8bF5ZJH6Jlgr4TizqZFGz+MURWWW4YqxbXovIlrYjSRyY6y4FowF7Y7nFBLHBXD8zVfrOdDbeDALtTfgJ9szeDzo+bNtqkLSk+BU5vgM+zm+tCbS6xwud85TES1c5WetmXjBo4sTb2NvjEwyj0lAScYX1+X2+I/Uss2c5qGQq0f92aHfMJxP1r7rn43TjOeN81f+PAcnzHL5XqxY+IH/OM27F86AILyb0Tf7jGWgCIKNV887TW+BOUZllS+jHLhbpiUkebSekWJtjNAmrSdLMZc/90mlaMp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWKIkK3jsYsWCSof3xaEgLYMA/DolZfUv+76gRpdKOw=;
 b=XBuUQbCqyjFe9Ry8oVmHlcCrMaDS96RsxJZQ0ptKld13eYlASr9gjRKrZ06XE2QZm2CZ7hD/ebnFBebNrj99KqN64gzNgEPSrxNfqNTFsnGCg0RkbSO3kjZs+4XsKqShSuxyRNvwupgKrTvII4UeaTxE8fH/xeAISLesGsfNgXFI0dTcqM8edVA1vK1Wmgt82IxTRBdjsV5EvYkfWoil9hg7ABdJXSuk8kEfRD1nE+e2hS9rGe/DqNJ5QyZ4BCCBKGFHcmu9Lc3l+l7tk7O1yAN0uUHI0tZ4J2ppsPj0QLFwgZN99unX9mfBOaD1ozpXbR+PegenLBYE363uvjoi6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA3PR11MB420097.namprd11.prod.outlook.com (2603:10b6:806:531::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 11:06:23 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%5]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 11:06:23 +0000
Message-ID: <5836fd0b-e6a6-4d69-88d7-3e2cefa10ba5@intel.com>
Date: Wed, 16 Sep 2026 13:06:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/26] Support VFIO cdev API in DPDK
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <cover.1789044746.git.anatoly.burakov@intel.com>
 <CAJFAV8yEwjyh0KT3WhAFS1G29C2M_GbHxh1S6cRoVVsWGiM_NA@mail.gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <CAJFAV8yEwjyh0KT3WhAFS1G29C2M_GbHxh1S6cRoVVsWGiM_NA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0085.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::14) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA3PR11MB420097:EE_
X-MS-Office365-Filtering-Correlation-Id: d7574a3e-e806-4bdb-031f-08df13e28b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|4143699003|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wMDZBGyYz2VrouMlAx6E/GbDx9qqfzuC8IGx/51gUBPzs7EVKiNJ84044wl59/kkZWKwIM8g8tR+BnfTRVbqvMT5sitep4yjwH2Zm/Qydu61fVyB4eCdcaEtAfD3ksRGbC9vxpalRhWwDDf2wf3n4vvxjy/yNovc4lz5DxXuAIiZwBtVrZXx3iFskV9CFS2t1LFt7g8YfEtSmCKoiyFs5x1HG/9cm+4/tdDGC5go/Jm8CtLVzlCJlWHwvaPWkJP+BREzO1wTw4riYjkjpRxq1Wcvw7ElEg3Xm/9vGO3o2saQUcyvbN86GGZxjKgKMt12dz+jrgA8sACpcGfUsGjK0lRFYYnrIVHK1oioK2MTFo55h/h+6DswImos7K5GcILLBgV79lXi4Pimx7/1rfMGjU+5zcZ0I7rFi5DKgIVT3C2AVKjT2gPgVm0W5JB4g13Nns5mkL/CdG3wOZgF8j2KdLwJmthxibWhxexCIlnSpETRccFihZON0aDRmofNIwmdT1L18kMc64JDH4vOc0OzkUu4kRzwE2KWH9UAwebXtUMCDNMDQ95GDS//SRzvZMKqjfgBSTTTGDyFunrSMltBvCTkB5v36lBE1cLb0Xr6xfn0WLqUw8a66QFnwGlKMvkEDhzOKA6cIck0qFF/xoye+xhPfdDQd8bGDTy1MJZCva4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE5tbDFwaDJXT3hibEtTTmZ2T1RWWTdwT2ZHUnBPOWx1RktLTzFrSmtsbWFn?=
 =?utf-8?B?YkYzdzJOS2FIQkJDM3RieUpVelhpbStGWEtuZ08yMlBUZkJqcFlmWTJJcEE4?=
 =?utf-8?B?QTBTUjQvNmFMTmdERUx1dWdQMTdpcCtJN09kNlZEdVVqOWlnSjhhZjFadEQx?=
 =?utf-8?B?Z1JkazVINEFCUU9uenllOW1RMHVGekdkWGltUHF5V0p1cG04SjB6RWhrY0JU?=
 =?utf-8?B?QS9ScG9EZ1lLWG12NFRtajdIN3FOZTVPTHVCajF1Y3FEbnJjUU51ZE05VXdM?=
 =?utf-8?B?c0tGZDJPUElIbHlFUm5OZlRqeU9XZ0thVCthbk82RFFGVnpGUGx4WEdHNEFz?=
 =?utf-8?B?SUJNOWNNN3ltUVdweXNTOEs5SnNscERBTm1qQUFvZG1sS2lxV2wveVpvSng0?=
 =?utf-8?B?YVpZb1d2dXlCY0lXUlBMZjhBcXNUSkR5a2paUkFKTzhqYzV1bEFMeS9wQkVV?=
 =?utf-8?B?cVBwVDlHdElHaUFGVkZvcGJUY1BDa3pCTDBCaDE2eE9KZFZSQkRXWWpNbU1Q?=
 =?utf-8?B?bXFoRnVWcnlRbHFlL2xNUFY0a3V3YzQzQjNYSmVyUkZuYUFxQTYwN2tlekxn?=
 =?utf-8?B?cGI4Zk8rcGdxZE1jRkRFT2VHYXJtWldMMjlUZnJrRFdmaFdyNklmRTRFa0dB?=
 =?utf-8?B?RnhuVDVjbUJRVktNZXhGNnh3dDAxMTdzeG9nbFBlU1ZVU2w4eGQ0ZWpqQUsx?=
 =?utf-8?B?cWRHM0lXck5FV0hqcngvQnN2UU81eFJ1ZDNFekpWbjR4N1FmMTRELzNhOCsz?=
 =?utf-8?B?NCtLZ2FXQUpvWitmSm85T1M1ck5sSFg2dXYySzYwTSttTHdLSTJsdkNsVmdH?=
 =?utf-8?B?NTF2emM2em9jdHFsTkpwSkJxeklYcUIxc1krTDM0TFF2aXBaVWszRU9zdjZW?=
 =?utf-8?B?ekhOUmhPelowVklTUXZlaG9iR0hkS1JOY3J1QTRZZE9ZUll5ZHhCUG1tdFBL?=
 =?utf-8?B?UnFoWVk5T3BBTTcza3p0QlhTT2ZqQU9NL1dDTUlHTXJrMWpRZStVZXlXcE02?=
 =?utf-8?B?dFducjVuMjdoYjlBUlhnMVBxQjJ5TXVzbUVUMFdxMHYyaDh6VVpESWRseUl0?=
 =?utf-8?B?cDdwUmRFaS9VUWZPV0pLVlFqcDd6dnNmQXdPL2g3N05kN3VaTGpacHhDWldm?=
 =?utf-8?B?WmNKVTc1c2IwdTFTT21ma1BMTUdLbHZFd3hpUHlkdXovSVJudmNEUjhxS2ph?=
 =?utf-8?B?K3oxVXpDbDhpTitzQ2plaDNpNFk2dG9tWUI5MDJIY1FCVWg0Uzg3WUpTQ2RY?=
 =?utf-8?B?ZFZkdUdMYlRRdFFnWjZDbE9PTnFJdjVVMWNYcWJsSWhLUHpiTTlrNnRpKytm?=
 =?utf-8?B?WUt4eUpXNEdlSzNZSTFMY0RJUWRxY1FOaTdKNWZnQnd6TFV1QU5wcXZjZlVv?=
 =?utf-8?B?WjluajI3TjVnbWIzcFhkb3ZvQ1VHU0VYRDViaWVjVTYvNC9ZREcvN0JCbTRH?=
 =?utf-8?B?NDBQR3F5RGFHT2dzWmpGb1NwU2VreWh5bkp1MVpvdGxDVlB0dlA3L3BBNm1q?=
 =?utf-8?B?WGZBc3djRE0vQWNuMXZaMUltZmxkTUlmRFMwM1BIOEd4d0tiSHVLVkZPTVRq?=
 =?utf-8?B?OE02Z2t5VXlPbmw5RzVtVjkrR2tZc3NEVUdpY1lQSlFsd1d5UFBxdVdFc3B2?=
 =?utf-8?B?U2xHTFNPNzBQYzdwbW9xTlQyZEkxUXN5TjNKYzcwWW1Ja004bFk5NmcyTTFU?=
 =?utf-8?B?NExpS1FUN3Vad0xKNGN2SGZmRHZZVjdhUC90VEdFdWZldm1sa3piTTZ2cXBp?=
 =?utf-8?B?M2VLN0s5TytGd3EvUUlVWWVOM2tEbVJLLzNzVjJQYWphZWhQYVlZYnZVM2Fx?=
 =?utf-8?B?NjMxRkZvUFJpTE5DbFFnSzhTcE80VnBMK2NnUjJISzlnNG1kWDgvbEdXVG12?=
 =?utf-8?B?NG53Z3d0MWFjMEZ0NTM3RVNjMWNPeW1TRk5vaWZvM3JySzRsUTdtcHhaY0Ru?=
 =?utf-8?B?NDNMNzB5NCsxYnREL281UFRsbG8yTWRESmRSenNBOTRvUjNIdlRUL3lFU1RL?=
 =?utf-8?B?Nk5YcGMxRWZUL2lTUEJtRlVTaU9hUlFZS1BCd2dPR05yVnk5dmY1THRNcWN3?=
 =?utf-8?B?Z3JYRHFac1VONEwyVm1iaG12dCs4MnRNMlFVVlhtQTNnVkF6VGw0WFN0bkRt?=
 =?utf-8?B?ZEdNNEJBeElBYk1GSTBFU3dGR3ZuTnpPcUdnekt4Um1NQSs2cFVLdVAzQWxH?=
 =?utf-8?B?SkZia3pYMXltWm1SSm56MVIrZC9lV2hHN25xYWV0RFZVTndHQ1o1dDU0bmVV?=
 =?utf-8?B?YlNpc3NMc1QrWDJSTnI5aUdxWHB2c3FjSVVKK2NFY21peXBLWERsSTRVNXdM?=
 =?utf-8?B?MGw3S0VoUzJOT096M1NtTk1MMmR3MkszMExHckhjQmVUcmc3TXAyMnpvcHVB?=
 =?utf-8?Q?JH4I0U6RVZOFCU8w=3D?=
X-Exchange-RoutingPolicyChecked: nDIvFiTASjQDyZFv7duH7kClVagPBux3XXGtvLt6FKrdoOSlRhec5hZz4LGPgZvYi9AC2L4fezhOLPgcSsu8DzAUKHkwtCCQ88k6RmLnMouq2kHVDAjli7V3qFPttJQLeWJXLwS5dY1TIIOyajM6Yw/oykuy2HWXCODDgeWoJSvm2JokGrfX3kQafPmQSI/nZUUmUljoGf09H74Zmh9nEthrNSWeVCVb4Nyg0/ChcOHUbIC9Gr/jeC0RflOW2kIMt70msGsCz5vwnVQltFp69QbMkDZkbWTVwvrNJ1AE4dRf0sJyw8yir4Z0QccAsH7GVbOIqEPVvl8Hdl9qewVJ7w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d7574a3e-e806-4bdb-031f-08df13e28b68
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 11:06:23.4496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPy9Wl3Muvk5lhuYceFy2XIjkLJ0WZ9JGT9FVJFbwCdK2x7JXQ+zWw/St/8rkBxOhHHFJQivk7REeoppkAtWFYaXyXsh2RdABN4YnWrSjpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB420097
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

On 9/15/2026 4:32 PM, David Marchand wrote:
> On Thu, 10 Sept 2026 at 14:53, Anatoly Burakov
> <anatoly.burakov@intel.com> wrote:
>>
>> This patchset introduces a major refactor of the VFIO subsystem in DPDK to
>> support character device (cdev) interface introduced in Linux kernel, as well as
>> make the API more streamlined and useful. The goal is to simplify device
>> management, improve compatibility, make the code readable, and clarify API.
>>
>> The following sections outline the key issues addressed by this patchset and the
>> corresponding changes introduced.
>>
>> 1. Only group mode is supported
>> ===============================
>>
>> Since kernel version 4.14.327 (LTS), VFIO supports the new character device
>> (cdev)-based way of working with VFIO devices (otherwise known as IOMMUFD). This
>> is a device-centric mode and does away with all the complexity regarding groups
>> and IOMMU types, delegating it all to the kernel, and exposes a much simpler
>> interface to userspace. The old group-based implementation will still be around,
>> and will need to be kept in DPDK for compatibility reasons.
>>
>> To enable this, VFIO is heavily refactored, so that the code can support both
>> modes while relying on (mostly) common infrastructure.
>>
>> Additionally, new `vfio_get_mode` API is added for those cases that need
>> some introspection into VFIO's internals, with two modes: group (old-style),
>> and cdev (the new mode).
>>
>> Historically, no-IOMMU mode was technically a variant of group mode, the
>> distinction is largely irrelevant to the user, as all usages of noiommu checks
>> in our codebase are for deciding whether to use IOVA or PA, not anything to do
>> with managing groups. However, now that upcoming kernel versions will support
>> no-IOMMU for both group, cdev compatibility, and full cdev paths, a new
>> `vfio_get_iommu_mode` is also added, with two modes: safe (full IOMMU backing),
>> and unsafe (no-IOMMU mode). The naming is chosen explicitly to emphasize that
>> using no-IOMMU mode is not ideal.
>>
>> 2. Custom container assignment API does not map to cdev mode
>> ============================================================
>>
>> The existing `rte_vfio_device_setup/release` model is fundamentally incompatible
>> with cdev mode, because for custom container cases, the expected flow is that
>> the user binds the IOMMU group (and thus, implicitly, the device itself) to a
>> specific container using `rte_vfio_container_group_bind`, whereas this step is
>> not needed for cdev as the device fd is assigned to the container straight away.
>>
>> Therefore, what we do instead is introduce a new API for container device
>> assignment which, semantically, will assign a device to specified container, so
>> that when it is mapped using `rte_pci_map_device`, the appropriate container is
>> selected. Under the hood though, we essentially transition to getting device fd
>> straight away at assign stage, so that by the time the PCI bus attempts to map
>> the device, it is already mapped and we just return an fd. There is no
>> "unassign" API because `release_device` already performs that function.
>>
>> Because the API is now unified around device assignment, the old group-specific
>> API's can be removed and, where appropriate, reimplemented using new API. There
>> were other users of VFIO which relied on group API but only for convenience
>> purposes; no actual VFIO functionality depended on those API's.
>>
>> List of removed API's:
>>
>> * `rte_vfio_get_group_fd`
>> * `rte_vfio_clear_group`
>> * `rte_vfio_container_group_bind` (replaced by container assign API)
>> * `rte_vfio_container_group_unbind`
>> * `rte_vfio_noiommu_is_enabled` (replaced by new mode API)
>>
>> 3. The API responsibilities aren't clear and bleed into each other
>> ==================================================================
>>
>> Some API's do multiple things at once. In particular:
>>
>> * `rte_vfio_get_device_info` will setup the device
>> * `rte_vfio_setup_device` will get device info
>>
>> These API's have been adjusted to do one thing only.
>>
>> 4. The API does not need to be public
>> =====================================
>>
>> The initial idea for exposing VFIO API was to enable userspace applications to
>> directly map memory for DMA, but it turns out that in practice only drivers use
>> this API. Therefore, the entire VFIO API is made internal, driver-only, and is
>> renamed from `rte_vfio` to `dev_vfio`.
> 

Hi David!

> Thanks for the cleanup!
> 
> I am still in the process of reviewing.
> Some first comments.
> 
> 
> - About patch 1, I am not sure I understand your intention.
> Without applying it, a conflict appears later in the series.
> 

It's because the first patch is queued for next-net but our CI doesn't 
seem to be capable of rebasing on top of that tree yet, so as a 
workaround (to get compile checks etc.) I added it to the first patch 
series. The cover letter states that.

> 
> - Do you know if some Linux capability is needed for using the cdev mode?
> Did you test this change in (unpriviledged) containers for example?

I did not test such a scenario as I do not have a setup for this. I know 
we've done internal testing but not for unprivileged/non-root scenarios.

> - It was a ugly/gray area so far, but should we stop exposing an API
> that do nothing on Windows and FreeBSD?
> Especially now that we make it internal.

I am not 100% sure why this is necessary to do - my best guess is that 
some of the drivers call into VFIO API which means it needs to at least 
link correctly. I would gladly remove all such references, but I would 
suggest this to be future work and out of scope for this patchset. Now 
that we're removed the ABI surface we can do whatever!

> 
> Drivers calling the VFIO API may be broken/falsely announcing support
> on other OSes.
> I prefer a clear broken build rather than some runtime failure on
> those OSes the day someone starts testing.

I agree.

> 
> --vfio-intr / --vfio-vf-token EAL options are already Linux only.
> So EAL common code looks already ready.
> 
> There may be one complication on the PCI bus side, with its calls to
> vfio_dma_map/unmap but it seems doable (implement per OS
> dma_map/dma_unmap internal symbols ?).
> 
> Something like:
> https://github.com/david-marchand/dpdk/commit/cc77440883b0d38b842d6c520292b540eabb78c4
> https://github.com/david-marchand/dpdk/commit/8f426089f949e0694e5201193be88de673c4283d

That can be done, yes.

> 
> 
> - Probably for later, but I see one more constant added in config/meson.build.
> All VFIO objects seems to be local (or exchanged over MP messages).
> 
> How much effort would it take to remove those constants in config/meson.build?
> I am thinking about RTE_MAX_VFIO_CONTAINERS, RTE_MAX_VFIO_GROUPS,
> RTE_MAX_VFIO_DEVICES, EAL_VFIO_MAX_USER_MEM_MAPS.

Compile time constants is a balancing act between flexibility and and 
ease of implementation. *Technically*, because all of the configuration 
etc. is process local, I believe we can just do per process 
malloc/realloc and expand these lists as they grow, thereby doing away 
with any limitations. However, obviosly, it would require some plumbing 
work.

That said, now that VFIO code is much cleaner and more structured, I do 
not think it is difficult to do that.

> 
> 
> - rte_eal_check_module() only user is VFIO.
> No opensource project use it.
> It could be removed in the future.
> 
Agree.

-- 
Thanks,
Anatoly
