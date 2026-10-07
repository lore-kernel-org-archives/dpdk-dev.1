Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C537CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 10:55:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A72284279A;
	Wed,  7 Oct 2026 12:55:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 702C64279A
 for <dev@dpdk.org>; Wed,  7 Oct 2026 12:55:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791370529; x=1822906529;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sxwfTV8N+435vFB2p6FbuG51Fw6IJVj39SDmBU7Vqxo=;
 b=jenqwKdtGRTgdGsupCPz6cjvzzvQErpIHTGfsX6P6DUnADUOfP0VoVOZ
 J1N3oKPcLgK6Ocpr8oSU3fAR5v0UmhohY8EXngmVJH/L7GHfLIHquGJCm
 tBjLj1z/BJq5ZJRqaynRAFWx9QtIAKsiBQSKXWVAoR+l38hDEIzshLDJ6
 enoOrebLe1MpNWt7LITm0gJqB34yvt9A4aCcUsxNROxaMdajMMHnAQcyg
 bOV8tW37rMD1kmrBagTaD6msZcLTMqe8fTT2PqEcU3tN976a5HBosxjUJ
 Flb62F6TBVyNGRiFMAFUVRD8seHB7OZ8g09o+/w8TeyfVaD4oP69UME0e Q==;
X-CSE-ConnectionGUID: +lKnoVmjTkez8tWGd/HdjA==
X-CSE-MsgGUID: 2ucL3eQwTriVWQETs4pidQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="23691"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="23691"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 03:55:25 -0700
X-CSE-ConnectionGUID: MRUR0x3kSGit3aELBsZFwA==
X-CSE-MsgGUID: ayJXvaPHSHG5s4wviViOdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="303708805"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 03:55:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 03:55:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 03:55:19 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 03:55:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E598ZQ+ucxTIhGRpxC6IKhXYFpqoZelzuWe3dOMP48i3Nvlh3pu99nJVhpdoEmNUEWAmFzY7mXj5LQEUzJlYBFmrgIbruNRadb2OGwloY7aXJKbV++DR8eE26lA0SYaOzk0IldFZp0Je9c+7fT2QzN+4e8r6Jz+010hUCxeKECvK/fUU1qsmY57f564WrpVzsbDd9t21631VglEPJ0JqT7MsndnRpz7/UefzdFEvlPOKtHYp31iMjiA2IgAg6sClrjUVjNeWmTdejh1tDi/HYmtucYRSq5QfOq1KyUGfK05SogIxfoXT2DPokgemMltTyZOKoJudqI4QxibszQyDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOA8E+FRSf1VlIr0L5XQgoydpyid+6L6/QU9VksQyHw=;
 b=MQyjSVNWFmvKjHJXf8BDCgTRG8WBMAm/nyyR/rsHeErKWv3iSjSXe8B9Z2Z8M3y+drbmClQgf3qxLgJnBsJgQs5mUTceha/D1gzgfhwvnYC6308keCJPaYqPg7Znf2oJL5pg9+3PN+gmY5/dSFqHEdsIfEwSxpGKbtYKR/nKelpTy5g+AIMy+4t4FaqR3z24rwMGKOIOf4mbd3XHa/J/RRurSWkP3rex1ttLjIxAL9iy2CAeHOm4Kgw93GBMAK+lPgJ96HFo4bSxp0lNZKKfhAk6NsJT1/U5y70rcPPYK8/a6B+EmpJpcwWl1UwiaPcsJXOSRHurDxWEr1l7cczx/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MW4PR11MB5774.namprd11.prod.outlook.com (2603:10b6:303:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 10:55:16 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 10:55:16 +0000
Message-ID: <50c63db0-9f8f-4d7d-82ba-c0f0a4547cce@intel.com>
Date: Wed, 7 Oct 2026 12:55:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 05/26] eal: provide VFIO only for Linux
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>, Dmitry Kozlyuk
 <dmitry.kozliuk@gmail.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007073206.567001-1-david.marchand@redhat.com>
 <20261007073206.567001-6-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20261007073206.567001-6-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::16) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MW4PR11MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: c96c8db4-47f9-4c26-ce7f-08df24617880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8vPwgWQvyctnwRiyxI9evp2JzuDzbZnWMu0RXf8oNxr7P7vTEqKlf0oktqlXd2zUPx/TDIR6TOS9W6FRdlYS6bUrMsuyghNg0FyF0aIuntVEuXQK5mi0FABkQe2WEHW5tmI4t96pHR8PCBRgYo/qA5sFUF1/QM8UxyNRtMDfOJ1dJ1J9pF7IdW0E4xujw93qGtHAc3iswIg5rlnDJdfJW/FnABzDorWiTafb8fxHCWUVNxYdw9nXSHQ9pXNpOXzw+e5K5ud9SpCM1U479iM7isTfYJlmJ5h1OTw5LdrxbmZcHvYb3+hQ7wEg3Q+Kzos40BecOPtjliYZvan8PPQl24tfQIAwAk1P0LvzLJ2uYBOCV+H+83W9KuJ7SwtKVGwYFm3CIHYkQ74F2MPQCcsaDLG0GvhFJ8GsjdcZBvoiin1D5BwbZMYaHM23WroHZmGa5C87F8mzUn6z0FnEqunAmYtXBTlmZ++eS3Jirx1YDmn4WerDIWPvpL5tfsRYU0biAMyhrtNjzZxji+66ULyc8tIlV3bTXhvRx7+u8FnCjKnsauKDPcAOAb0Lu+XNjRYhb9C5y3OoESnYJqkz64QAuO704hjyu6QRXOtG945WJEnDDre0Gr3njoZ0SU/PeYEVX9VZcPWj/NmW32GLGaf2myyYhiLZtx8mFLhrJyTkNN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXFBbzIzYS9ZeTRIMG1tTWpTeEZLSFVBQjl3bEppcDFoVDBsN3llb000RG9p?=
 =?utf-8?B?a204aDJCWTBMQkhyakVwMXpaQlRuWjFEZXVJOTBZZXpqTEI4dEtZNENSc1Bp?=
 =?utf-8?B?S0ZKYnoyTmV6QkRqQmZBZHF2QmdFM1ZTZjNJWlpmUXg2eVpnbVBpOTJ1c1FF?=
 =?utf-8?B?dS9kcXdWbUovUFNveHNjZ2tPdjBBTGZHRk1FRGdIeEZpbTA5RFo4S1lNRnFR?=
 =?utf-8?B?RWJuRTRZNEhIelJVazFZb3FOSzBvTWRQaG0xL0ppQ01OQVN0M05FTUl2eDl6?=
 =?utf-8?B?aEtQaDg2NENQNXJzdlZDVUl4VHlsTjN4cWFEeURkNDNDbUx1RkY1Y0pCTWE0?=
 =?utf-8?B?K2lPbGF5ZjFXTnkyc1FRUHVCWkNMUmI5emZSWGVuM3ZPaDRaRFVpWHB5YW5o?=
 =?utf-8?B?VUhZSXNJY0J0RkphZ3dvTjFYbWhjTnppZUhKQlpydmZ1T1U4U2lwR25hS3pL?=
 =?utf-8?B?N0ozeStYWWFHZkFzUFFwZFdNaFQyL3RndURnRXFlVXhBNXRaK1YxK0FSN1J0?=
 =?utf-8?B?Z01YY0MzMVV5SURuK09VNldiOHUySGNYSXc3R3BUV09IYmJjU0d2TTYrRUxH?=
 =?utf-8?B?NmRFQ3BJVVdPWjNBUjMwZUgxOTh1NnBNWFo0TTZoQW5TSy9DMFNmVXRYMG1Q?=
 =?utf-8?B?ZG12TWNxLzRGRFk3N1EyV2RSbjJ1bCtzYzVRQUJ3V2hUTDZvQWVIQ1plSjlz?=
 =?utf-8?B?TlVyOUcrM3pTNmhWaVYwOFA1TFdDMGQyN2Z2cnFpbWFPMy9KQ0VFRHFlNXhY?=
 =?utf-8?B?dVl1eUo5YmRjalJMY3Y5dXdvcTh2QVk1RUtDVlhLT3ZqcFhDNnJPZEFwOEpM?=
 =?utf-8?B?UldTeHB4ck9tRVRKVmpZSUh3bGxMd0NUSFhhL0xsUFpHeEVqbFBxcUF4RkM3?=
 =?utf-8?B?ZXhJZFo5VGNja2Nlb1NQMVJXUE1IN3lBbU9Vbmp5bzhnOXJIU3FHZnlQdW1E?=
 =?utf-8?B?SDJVcjhZUW9ISnMyQ0NBMFFhWk1QamJ2dE0yRG1ybHpGd0M2MkRuU1FwbHdX?=
 =?utf-8?B?TzYrQVRpZ2txYWRqM29MaXhWUUdsdVpnam43S2tLbTUvTktTV1lyRlJQS1N4?=
 =?utf-8?B?RlJMYmhtSTdvNkplNURLdVNkdHpRWnNlVThtN0FqRlIrY1haL2FidkZjdmNj?=
 =?utf-8?B?L0VQT3A3bnZZZUlsd0RYRFRETHowbk9lTmVUM2dZNjdvSWFIODZLc2VPeE1W?=
 =?utf-8?B?TkI2SzdEOHN2a3FuOW91YS9BMFF1aEVkQ28xcTlWOG5kOVo2Q052NSsvYlIw?=
 =?utf-8?B?WW5VMGNRdTU5clFpTjBXb2oxQmZRcktpbDIyV3VQZ0NqeEZLYStGblczd05h?=
 =?utf-8?B?bDBQSUZWV1VtRTNtSEZhTEZxY21RTkFUZjB5SkpVNkwyOEJldW02SzBGOFVQ?=
 =?utf-8?B?SThneE4xL01JNENlSDRKZkJRa3R5L2Z4ZVB6YnhLL0psWHM1S1ErMi9xM0RJ?=
 =?utf-8?B?elpaZ3RxSWpKSHNBT1dFbjlUdk5xVVBmNDRzN29JeStDeXBpSzYyMFBsSkYr?=
 =?utf-8?B?TktaM1l3ckJpQUN6anFCbEh6alFrV3BGUUl5RDlEQjJueWF4TEFvRTlYdzNw?=
 =?utf-8?B?cnJldFNWY3M3dFowM3BoQUhRZ0FZVldOKzRuRjF0Nm1CS1dvb0Rab2l4T0FI?=
 =?utf-8?B?dWRxUlg5a1dEa0NnbG1VRXdIZEdidkFmaTdBSHNTRnNxZUo0dS96bzlXWkJW?=
 =?utf-8?B?QXdKNzc3MmlxV2dXayt4YWRHcC9vQkdraDFPTjQzd1Bqc1pzOWt0RTIrelkw?=
 =?utf-8?B?RmhWcUlhR0k1SUhnMGxjQm9HMzFpdGxudjFzUDVEOFl1b1RPTkt1Vm91QktU?=
 =?utf-8?B?R0V3MHp5SFlybXpneElKendNSDVQVElFS0p1MVJlNXk3OS92cC9kcjQ1K20v?=
 =?utf-8?B?MU9yb3Z0Yys2S0F3cEZsdEhIRWNxUnlpT2hzSVMwYlJTank4VTU2b1l4THdn?=
 =?utf-8?B?b3Y4MVZERmYwU29pRVZYZmY1aElnRnQ0U3pXZmJ2T29sbmtpZWZ0R3pUaGVz?=
 =?utf-8?B?bUhwblVoMVlYelNEeW0rWFhTdXh1ZVg4M3l0RTVxV240cktXUndtNGdNRzVH?=
 =?utf-8?B?YnY3KzVCdXRrT2tEci9pTmR4WHBrT1dmTFArZ1NEcExHRm9tdmZsendtRms1?=
 =?utf-8?B?VERkMDFQSXJheTJJbmF0dTdPRFdaeUZWeUZkNm1RTzlibHF6Z04vaElJNFJl?=
 =?utf-8?B?ZnliQklaK1Nzd3JvcW5wYUdmZnBHODFOUW1YditaQ2hObUVXTmx2NTdRT0xq?=
 =?utf-8?B?R3haUHQzZmJXVG14ZW9venc0VlI5T3dYZ0VTU3crd2t0TS9yazVMVXR3NGFH?=
 =?utf-8?B?VWJZeTdZa25DVmVtL0Qyd1BldGl6WCtYdGxzQWVjUk9tRHFVTlE0RC9uSnhD?=
 =?utf-8?Q?lkyDcU99FUn7MDIc=3D?=
X-Exchange-RoutingPolicyChecked: bXcF0yCCMUnINccGcqj10n58G53q65lBW7fVyYY+ELx07U5qM+A5VG91hzyURo82cJcpK0G/yYX9Nl23m0djAz05tIhy4DWxJ8okw0s3f+HupI5/isfO1JmNHUIapGKx46ztjbTZ2EyuIvog0B5+D+JvHlMZ6TQ/jyBOabLW+wFb7YBj9LUwg+QsXUbw7k3UMsG9N7RU7khzXvNUJ9jnHNsExMZjtDQzYjynlaRsTDP9zKibuuImw9IYqtoDVZZn3fgRaaTQJ9ZEvSIO8od2ck7BbWcVjtlMuVgb9Mf3bIgFIVQmId8hf1ka8Q4X2bJMqbY/Ci2YiqfRzzY5l8lNlg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c96c8db4-47f9-4c26-ce7f-08df24617880
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 10:55:16.4366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G62JSMqxYi4QDozgMppbUPRN8dcCFNpcGXoC5Ci5Nl3XpoEEsm2T9vqQ6dEQVlQvbVA4140q8ArYfAhFmoyNfUio+zfF5HBMkx2/4tg9YB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5774
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

On 10/7/2026 9:31 AM, David Marchand wrote:
> The VFIO API is used only in Linux related code.
> 
> We can hide this API on other OSes and unexport associated symbols,
> before the next commit which makes this API entirely internal.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
