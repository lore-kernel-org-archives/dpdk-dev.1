Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5686ACC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 12:44:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 907604060A;
	Wed, 14 Oct 2026 14:44:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id DDB794021E
 for <dev@dpdk.org>; Wed, 14 Oct 2026 14:44:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791981893; x=1823517893;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+aFjOkNSdixN/FvD/AzedvkEvrF1o9u+Dahwpy9c+6c=;
 b=jggbOHqyTmQ6OKPzPlps2lpHp5EtwxDEhc74O6seYSCZoNkJHqdiRb1h
 /aeyXENE/blKOv8WDV7krVEAofgjcEUH5/rnjTRVt1sCLl9KtmsP4doGJ
 C+pYKllRPiNEAQt7WjJistu/Ym0kjN9k7ufXQsjaEYz5iLi8pmkHjWNNM
 nXSWbugqIadF0DKwLxlJdco8HDz/z3i+Cr8w6PEQDNRsz4pzuu9xjRFGY
 D6CJQNYT72zFxXfb4UKWprkR+6gKV8Hr8Xb5wXXTRjk5Y782QnErLXNbV
 gDHPCmaCpDs4IMSPpNDFjRv22HD0jDV/t4U7AqVfxv1E5/z0/jDCZ6RCN g==;
X-CSE-ConnectionGUID: GkGPmT73QfKayjlOsN6TRw==
X-CSE-MsgGUID: WRmkP97lQtCGW4ga9Dqfgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="613791"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="613791"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 05:44:52 -0700
X-CSE-ConnectionGUID: /SywqQizRX+M2ZWfs+9PwA==
X-CSE-MsgGUID: 9yehjzdyQH2WWRCvNdyRdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1371554"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 05:44:50 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 05:44:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 05:44:50 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 05:44:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRh2JvaFYJyI+Rg9YnoEZt2HhAlJUuME4DbU5uG/3HYUNZujFa/5Je+iBR51d/n3LNGI+7UIKg1N+0w1YWE6ta1jQPFcribHhYGky7ES187eL2n99zqSP4N/V1vADJIxWW2V6KkStCrjwO+Q3JevfutpPuHpkW6E3Djj3RZpCixNN9TBDfwyHWD9BqxtxgM1+Ln+xLygztgaoztHh+1ZtirVEOMYb3joc3p4tB5AtH4JwB379aTp7j+/5eSKIHN3fhMrxy4VOSm8EFallVU27FwfSK8ME9SNrHd9HwhWA6J5X7BFsgUXhc6ZBk005omngK6KtXvrOpFH3dZpQtXaoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aFjOkNSdixN/FvD/AzedvkEvrF1o9u+Dahwpy9c+6c=;
 b=aQdu79Fj+0AuloTJ9c2m6NiB+VPOg1SuIBGUzC+g9wt3fah0P9xunKv6xfiPMXaBZNcDdwztQNvgOw/xwNhdjSD3JL+LlJfLg1sXAr5BMFvW0IrCpBbKpgZj6jPgTcszau4Q2wFwnuJZmmFfdC6HqBVX7nYc4IWY95vvIfIPhO4p1Z4J62O3BBCjLKN611SB0IQigZvS7mkm59KJRMcoedWaBPCDxfJbvf6HFtXywmD1yPk/ndEUSJ1vU+seNZwqq/dLyT+bU3BXV8L36iM2Bk/0UkwAvzEm0DyuulUv7xUVLS4OPR7fcCm4eb2POs9KfZGiMZ0y6bbgGlyVqIyK5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 BL1PR11MB6052.namprd11.prod.outlook.com (2603:10b6:208:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 12:44:41 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 12:44:40 +0000
Message-ID: <6ecbe3c1-0925-4392-afd8-53c777495175@intel.com>
Date: Wed, 14 Oct 2026 13:44:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] crypto/ipsec_mb: require minimum version 2.0 for IPsec
 MB
To: Thomas Monjalon <thomas@monjalon.net>
CC: "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Ji, Kai" <kai.ji@intel.com>, Akhil Goyal
 <gakhil@marvell.com>, David Marchand <david.marchand@redhat.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>, John McNamara
 <john.mcnamara@intel.com>
References: <20260811112636.4106950-1-radu.nicolau@intel.com>
 <0UZYeU6OS3OoPauzypyoiQ@monjalon.net>
 <9a235219-aa8c-4372-8a61-d2ca9d731604@intel.com>
 <1ZyWCFPKR3SU1pTJ1PHaEw@monjalon.net>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <1ZyWCFPKR3SU1pTJ1PHaEw@monjalon.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0039.eurprd04.prod.outlook.com
 (2603:10a6:10:234::14) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|BL1PR11MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc72199-0ffc-4209-2cc5-08df29f0ea0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|10067099003|6133799003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5JukLsyO49dhQ/ne7N4hI12ye8xqwGtKxJhqNAheIg6sY9mNpCDHQUtBFy52QtxSfwjr0QnJBb46N/katIdJBHYRO6bV2FgYbjEJBjsLGADxs3nzQ9rWrxS/rIvFqYBvySKBFPGNtUF65u8Fy55ZnVQdN5E2/cmsV3mUnvg6dV4I0fPioQKe1XfiCkX+u1OiV0lZHjG1UNXYB5ixtfr3y9KrkjGGnHyVU7goP6XvBJX+PCNlN3rg723DO/1g+14x17oBqbsJXdoSjMWmCnZMxn8T3/yb4Gb0e4CiYglQW43WExOM1QJsD0Y0nscLdPLRB7xPOinq5R2pX1pcPp1Y67uQMUvyLaKIKCSGXIUJV57B0PfF56FPagcd8HysyF+2tYEMj9E/oB/OBhd0AXR5yqhJJ3WqqC8WsXOwTsQiesJ2PaF7vQ+pNjqJRJ6+8r4ThL7wPhOm/SIHMcbIepIYYgGfZqk8D5Er2vJUoKIjZCR59FIAO7uKhVNmHHdwA4witlfVhM2jTLvt1nzkpQII/4pf7Nhn0beAH3ew2N97Wmev48E8xNyEgLZD32HLF4rbxZ5xFjk7ylMxlmTItwgsjY09NQCaXxxSOn9Te3ZRdicqNGLvYgz5aYSc9xMlZGP3ot5c/4p+960Y6/KBY1C9NzSJWxDhQ7wYjSH4CuwPICY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(6133799003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1R1b2N2dlBKN2lKb0JFZkkvZzVMdEZ5U0lGZThhTXNEUE04dG1uNko4QUlp?=
 =?utf-8?B?YVl5bDNES1I2emMwTm1sOG9uS0RlVHVsOWQxalNZYjdCQkVGZG9vRG9uZ21l?=
 =?utf-8?B?Mk9JUkFqWjdmaFhhZnluSjVUNy9VQklmK2kvam9jWFRRNWFMRjIzSzlibDRM?=
 =?utf-8?B?dU1neDNaaWkybzhCK2U4dmFQVlg5emh2NTVhOUVGODE2OU00c09PYklQUlBJ?=
 =?utf-8?B?SG54NllHUUVaTUtEQkFNelUyc0crRDFZVjRiREgzTm1XNUxFaXZYQ2VMU2V3?=
 =?utf-8?B?NkJLSmV5cjJHL1RHRk9RamZnMUxnTEdTb1ZtNWV1TmkvOHpqTFcycVY1TWVy?=
 =?utf-8?B?ZG14Uk12dkVoaXhuRzNrMW8yb0dQdlFmbFFVRkRpUzh4WHl2Ly9SZzJMTG1u?=
 =?utf-8?B?YjVMOUw0bXFqdUZHYTZRcUxVUkptWmhmdGJ2ZElQQUkrYnVvYzZtQUt6bFph?=
 =?utf-8?B?Q2cwWGNnT2o1ZXdGa2gySFJRYkZzS21qSlJPVnpwYmRXMFp4dkVNRjloeWkz?=
 =?utf-8?B?eEUwdEZWaVpqdnR1bUJ1UmxPclUrb0EvWE1KRms1QVVhZ0pXeWd1WG1wSkRx?=
 =?utf-8?B?dFdJZWQ3YVpHRGNqQ3AwRzhpeWJsK1E5WW5IekYxbDU2RmhnNmZTWTVrK0FN?=
 =?utf-8?B?ckdnd0wxdjlzRG9LSVh2eXN2dmdRUktaZkgyR05ZTGxQWmszU1BNait1ZWhO?=
 =?utf-8?B?dS8vL1VrTGsxTDFaNzJGY0Z3bWxXZldUTDJEOVdVd21aUTcrQlVlbHZ2czJ6?=
 =?utf-8?B?U0t1YjYwcFhaeGRaK0FycnFqbzlkcjNzN3RNNHhRcUdSdGs0UE05Uy9hTFlI?=
 =?utf-8?B?M3VsNkEyMVVzSk8rUDh4LzNqdHBYZHJzODduTXhaQThVVExlRjg0SDV1ZXcz?=
 =?utf-8?B?NTV4bWwwNkdrL1RVL1loazRBYVo1MTZVdWpnZDNvVW0wMWVmQkpDL3dNU1VC?=
 =?utf-8?B?U3RkMTF1dUdPalN4aTNWZ2RJR2dyakFGZkJMWnFrWFpNWlJ0dkNEWFVwbUkw?=
 =?utf-8?B?UjZQUElYdHlIcG1hY29xWEhyazYxdzlhdk5MTU1lQlh3UkQ0dEEzSHpua0ZW?=
 =?utf-8?B?cS9tSURXMXpJU0QrUlFIRzNweEkxZEI3S3VQSUtucXFDWnl2NmJncUdrMVJu?=
 =?utf-8?B?L3Y1Q01sR29xWTdsRnVPZitZdGJLUXpZVUgxazBBeDNsdHhHSFZoTytOUUQy?=
 =?utf-8?B?aE1WY21yTHI0Um40L1VubnBMTUQxL3hqQXBzSTJPRXplNHM4ZjQ0LzhJMlor?=
 =?utf-8?B?YTl0My94YUJrbW82YVJYVWhvblhHbFJrNUszVHdvRXEwRjVtSHNJWmsyU3BY?=
 =?utf-8?B?RnBlS0dDTDMzK21rdElaaDBQRjFJREEyVUFlZEl6VzNKSjUvaFdRRTBOZk1R?=
 =?utf-8?B?REUxb2JsN1VjendCeHp6OWlvWTQ3TEtjaURyY0J6Z0xpQ1AvS1lvZjEvWHU4?=
 =?utf-8?B?cm93RTd0VDNYdGtZS244d2JiRTRiS09uNzN5U2N0QVhjVzNDSTFvU0RpVlk0?=
 =?utf-8?B?ZytnL0dBUDh4dDEyaDYrMU1sTGFRVW1jaFFhTFQ3a25odWZPZHlrN240ODhy?=
 =?utf-8?B?cy9iZ1lYM2NuQTJyakRRL0hIOGwrUCs0bUtsRUFRZHJ3Ym45Q091dXpWNFlt?=
 =?utf-8?B?ZWR6Z01FbWVuSjNvbUdBUjhqNkV0QzhmQ3cveXJSYUtXWHJkNXR4ak40L0dr?=
 =?utf-8?B?cXFDaUVBT2pJNm5aRTRVMTVYRFNxN01HbU4wckdFVGNvK3JZK29iUDVHQkZ3?=
 =?utf-8?B?N3p1dUVNdTdjNTlKZ2dpYkpxKzdSY3dNNVpRRVA4Z2RSRjgwTmFQcUo3TVNI?=
 =?utf-8?B?dlllbUdUQlo2R1c1b2N4SkNWbWYxS3RLeGRqWDdxSThGeTY5aCt2VjJIYTBM?=
 =?utf-8?B?R2tGd2dJbG9kK0RVSWl3ZXZ2L05WM2dTaCtoYXB5YXhBekhqL2h0MVlwd05U?=
 =?utf-8?B?aXNkTG0rZWw4RFg4dFUzekNEeTFOMEsrck9TVUE0QmhMQ0xUcGYxQmZDZzhv?=
 =?utf-8?B?ZnhtRWIvSnZnbGhibE1LT2VMY0E5SHRMZ21waG5yS1hpZ2g0RW1yT3NhYkpQ?=
 =?utf-8?B?aG43ZFpWcWRMNDdQZ3poMUhNVGJrTHkrSTFSWEcwb2hhTFZGQlBkUDdoNTlQ?=
 =?utf-8?B?SmlkTngwWlFQb1N2Wmt5cEZLVXlQaFZmUHZlQVVoMUVWNU1EamNYcjNuQ1Rs?=
 =?utf-8?B?K0hWd0VvZ0dmV3BjZVJ0Z01LUGhSU3ZaeWNycjU1S0ZzYitGWUZsRGd2elFJ?=
 =?utf-8?B?RlV1UW9pUGYrRVEwVkFXMnQ0cExaT2JYQVNmajZDMkxJVVpLMFJGaytzbndB?=
 =?utf-8?B?TE9qaGZFQWJJbDEweTFRdG5XU05UTjZJc1ZtT2N6UnFOR3YwRTNudz09?=
X-Exchange-RoutingPolicyChecked: hrv6kAQYpZipahPBGlezije/UZpAmJi55uNlNzUljOkWn3zXxCpAxRdJtEHLk48k+O/OYiBS89zhD1T7IZ2R7fvL4sW2855dEORROzyD6oqJt5/s7muguIKTD87gW6UGcONC4oOF4PHdE5rM5PLghgbPa9Ogk/8i0HQBFLYwMyaxzHUof4kGRDck7HiKg62ywO70NHF5BHxe7BexFpK9UVxdV+Lx+GLFNi+740vGq0QvMsvNSX7QgUF2+6Kw6yNhJ8X0E+sTVCsTW+mZ6NTEr5Oc8vxzSVwfJ3Og4gtSA4SEcPn1mxP1koE1QmsQW15ygWYccit/4twCXFfi2KEbiQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc72199-0ffc-4209-2cc5-08df29f0ea0d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 12:44:40.8276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RX/XP++Ed8Hn4cqSGJWO5OK6zCtdXq0grC/0QqMcZuA5JSVbaulazET5D9N7+O7bNme9Z/FO3V7EFr2wAK0xsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6052
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


On 14-Oct-26 1:16 PM, Thomas Monjalon wrote:
> 14/10/2026 11:37, Radu Nicolau:
>> On 13-Oct-26 8:51 PM, Thomas Monjalon wrote:
>>> 24/09/2026 13:18, Akhil Goyal:
>>>>> From: Nicolau, Radu <radu.nicolau@intel.com>
>>>>>> Increase the minimum required IPsec MB library version to 2.0 As a
>>>>>> consequence, clean up the aesni_mb PMD code.
>>>>>>
>>>>>> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
>>>>> Acked-by: Pablo de Lara <pablo.de.lara.guarch@intel.com>
>>>> Applied to dpdk-next-crypto
>>> As usual with Intel IPsec MB, it triggers a compilation failure on Arm:
>>>
>>> drivers/crypto/ipsec_mb/pmd_aesni_mb.c:24:32:
>>> error: 'IMB_CIPHER_SM4_GCM' undeclared
>>>
>>> I have to drop this commit while pulling next-crypto in main.
>>>
>>> Please find a solution.
>>> I'm still advocating to merge the Arm fork.
>> Hi Thomas, the root cause of the build failure on Arm is their library
>> fork which lags behind, being at 1.5 release which is at this point
>> almost 3 years old.
>>
>> The only solution in this release cycle is to drop this patch and rebase
>> the ones adding support for 3.0.
>>
>> Considering Arm lack of support and contributions for these PMD over the
>> last couple of years, the only long term solution I see to avoid PMD
>> code littered with ifdefs and supporting very old releases of the
>> library is to drop the Arm version altogether.
> No.
> The only solution is to work with Arm.

Indeed that would be the ideal solution.

If anyone @Arm is still watching this space, please chip in.

