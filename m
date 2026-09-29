Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5F9CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:36:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABF7F40A7A;
	Tue, 29 Sep 2026 18:36:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 2A56F4026E
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:36:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790699761; x=1822235761;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Zy5h7lVtQZyr/Fxv3QAMEFsVm6LSocff1BYD48TQLaM=;
 b=FNyVhDqYKEtcszMlxFqwgzotyQdOgGne0TqAk02zDPe/z41ACUqMzbkx
 rfG83KBshdx4EeEn3jdOI9TR65r2do8mgjJpkNPAltqZKcD9B2t9t53//
 vdkQWal6Gc2wOIcs6Jq+/Pr/n0rXIAEa5D84kmLIIkEspKTNJhSj7DZLp
 tKkTIP84qUnmi6KiuDJiLtMEkib2gM5rO5PXGhRjQZZ4VGlVQ7SQErjTD
 j/B9L6e4F6IlGKoNf416PsH0Dub6vDG65rbOXnqiOMcN3iFGu3Oye3b3z
 p2cw3Bl0GpqeRjVtcHlfo2BeJazlSgQQGs7nRvC4jwC3KS2bLZqTdXabi w==;
X-CSE-ConnectionGUID: gHvIKsoARbmlQIn5oMtHsg==
X-CSE-MsgGUID: DDBqDRRNTGyvhrAMHvXCtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90286791"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="90286791"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 09:36:00 -0700
X-CSE-ConnectionGUID: WT+JlNupSoG/gCxbJO8R0A==
X-CSE-MsgGUID: MKpGejxATHGpolRL4JDpeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="273197981"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 09:36:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 09:35:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 09:35:59 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 09:35:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lez30+6J9QPnfHXmBgNdrcW52eIWC+smCTR3gTMGFDnTB6Ilu1Z1qzpy84x/oMXhtk370xD0wNi5g+vmtuluuGoXxhsClrzSPvhWQS1GnZ7d+uIvIkwaJV4/6u55joqf0h5vlzEvHUsuzCDR0D4rm1WVsF63jJmEp6KmNoIZtnLo/vp31ux00Pb9WJgHtxU9olybuLyI4iuJ4vO6q3Qb1sxcHTj7BXlyNCz63cXPf4vC2iV4SLYvEfChs8YIScw09UOEpIBkC64MrI4FzgbXgjQSw4QkEEvwchWNn49SsGFgRpZz6aT3RcqH6mTRhm+cYrpA9kQoBfNT1vj/GzzrGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zy5h7lVtQZyr/Fxv3QAMEFsVm6LSocff1BYD48TQLaM=;
 b=V7BtEG+O2u70c6OCcpJPoIvvE9NKxu7tsacjzrTa6HkErnRmNw75pvEOyY9XMBMGkzqskvjVtw/v8wf4OZTnaD4Gbybiyxp8axu5NJaWC7H0snw/g9Oiq8gKq4uKMRHETzGb5upoHRtAQU1LjUrp8Q+HA38uV0/SHF566YpZO10W6/Siq4VSYVUgvuN/F0K7i++oF6heeGzHXunQeSg89ryd3AaYqZ1cQSbhbnATY4z1wwDtxTx21Gio8mnLOmTffsyjByuw2bixNOQJxgnIr7dvECElbe6xkkafZg5blANv7k5BURPsXVMG9yS5o4cCfnQd6319FyHD3a9/1UnPXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 CY8PR11MB7135.namprd11.prod.outlook.com (2603:10b6:930:61::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Tue, 29 Sep 2026 16:35:57 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0451.026; Tue, 29 Sep 2026
 16:35:57 +0000
Message-ID: <a69c273f-8ad3-4435-9acf-ce768e1d1789@intel.com>
Date: Tue, 29 Sep 2026 17:35:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] test/crypto: add ML-KEM support
To: Pratik Senapati <psenapati@marvell.com>, <dev@dpdk.org>
CC: <gakhil@marvell.com>, <gmuthukrishn@marvell.com>, <kai.ji@intel.com>
References: <20260929105909.1305576-1-psenapati@marvell.com>
 <20260929122059.1344615-1-psenapati@marvell.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <20260929122059.1344615-1-psenapati@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8PR04CA0002.eurprd04.prod.outlook.com
 (2603:10a6:10:110::12) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|CY8PR11MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 85997464-c462-4606-81d2-08df1e47bcc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: te676gYHoyCnBS1Y1j9dJXONpPoypH5hxKa4i7XWSgw2TAfsxmQ9CUp9KKTfCOwq1ohBT8AZn62yjZYpup21/ZiQuSnUe8K20uwSGDAO4GIdLpPKCADepg/CRMhM5A1FMvqujy+OUcP9h1Vl2AJ3UlZqQ7Q/c4i+l25Lp/mWXpoT4wEGP8CLwXMv6R6mIFDfNp2nFRJP58WeFYsMMWNrMIt6bQtgvjhBdwPBXSO2p4D6SmVQoI0O3+LTryW6zwJbtJPLet8rIBo6xyjnvZPNgNaGOfr38itOHgdRgdi4PdQAVCAaSGmbxQd+IA5oRQGt3IUejHfY3pBy+yq5lo1+INE/FapW8ryBhwXMTUfBwdaV3+0rBeyP4sgJaadU2Q32Ie/nk1SKCbLBXjZI5cmHjvxk6HHYwGbvfCr982fYTwHIcks4AxoRGTyj7oUhkxyMhxzhl2I6Qj49y83DR4L2+UHnydpRzeX7QhdqZ/EmQZq7D5kSQu+qVzWNr6ejP/UvlG1gIqzzhTPhNps8knkY3cI9z5D82UdVyI5VrVluzIkA7YKXgeDPwf4Yux0oNNUUCNYwnBLMrBlq3qMcmVFIAJFIa8u9MsIDgjdODx13LUt/qjk+gded+hB06Xw8m1IeRB8grDmriwZmmHQbj17Kp4r1IxCaDUBQkJ2Ftz1ZZsE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0JkRUNRb2dQcGY2T0hmeDRxNzFtWExpY0lFK1lHWHYwOUwvcEZTaEFxZUFB?=
 =?utf-8?B?dDlpOGh6Q1NZM0tSWG9QTHVKVlBpdDN4SDg1b1hWb1dyUEJlN1lyOUlsMGVa?=
 =?utf-8?B?ejQ5Yyt0c1c0M3NYUmtrbXBsVXliZzRlVFAyZGdFVTd6eU5zV0xnR3J6aWJG?=
 =?utf-8?B?S1owc1BFQmRyeWFwRzZwQ2RYb3hwVHMwSzBZa2RHOGs5Tk40Y1RTdXV1M3hE?=
 =?utf-8?B?UWVLMmsrUk5MR25ZcjM3OGdMMEQ2YkdjczdCSG5OOFhPY2VqRTZPT1gwWUpW?=
 =?utf-8?B?MTZLRE44aFdKdDA4YklsSWREaUlKd05EejhFamNZWWFhUVZsTUV6VnlwMlZ0?=
 =?utf-8?B?RUxYMWVMNHBZNFQxbitzK1JpSHhyQjdoRTV6MjlGTnZsdW93RlFrNTN5RUs5?=
 =?utf-8?B?aUZFcTRTaVk3aTFhbHRjL1JzQ0Y1ODlRY2VZOS96bklZalcxMHpUSEl3QkJQ?=
 =?utf-8?B?eDZjY08rWjBMazJOM2xVbWRRU2pBa2VnZXVOelFpR2c2NmcyaDBWZlQ4ZzYr?=
 =?utf-8?B?dVVOcWJHWHh0QTJUOVVNL1FEdE5scCt2a3RhUjVObzNkMkdJbnQwNmRkMUcv?=
 =?utf-8?B?UkFCdkhEWlZjbUZvVzQ4d0ZzUld0WERjemVLL212RytxOGRKaTFLK1p2ZXdS?=
 =?utf-8?B?dU1GeGEyTkhHT2NJNUczSCtoZWY0VVRmdFlJQVZGTFJrNUVBdTRKbmtNZVRp?=
 =?utf-8?B?Mk93d1ZLTjN2ZWdqbHBXdklXakZqb3N4ajZMaFVhR3psM1ZuNFpETkRSMFl2?=
 =?utf-8?B?eHZiNkFlZTVjSFY3bG1NUTgxN2F2RUVOcTBSNHhsSzJqeEJsRjRGTW9KaGc3?=
 =?utf-8?B?Q1pwM2ZoblNjS2FTQ1dibXFoYy9JOWMwMjNVVlpRbCtGanRkOTQrSHM5ODJa?=
 =?utf-8?B?YVQ3Qk5YUDQyTVkrV1dFTU5aSXQzWUJLL1d0RmZ6T3k2cSs5VlNKNUR6ak5R?=
 =?utf-8?B?NVM4ZmYybzNFeGQ2dXppSFk4V21kS3lBVUs2U2FCNEZONmRZMHU2cng1ZzdD?=
 =?utf-8?B?WEhaN2pMQjMxZVNmOHFtemsvdW9vdUdhaG41U3phUVBZcnV3QmlNR2JDSlhP?=
 =?utf-8?B?N3pvMWFwWFVpK2Q0SUNUYzMvazFEd3V4eGRVWnpNdkRoa3pSRFZ3S0JRb0lk?=
 =?utf-8?B?VDNCN1lyWFAySGJvZEZOWEN3REhDeEhFVEgrS3JGTmZtdngzeUlhdk1qemln?=
 =?utf-8?B?OUprQ1Z4Y1BnR2JEVlg1NDdnOEZuckQxaWhYOEZHNU5mVWRmaVJmT0c3RThT?=
 =?utf-8?B?V21odUpaNXVJa0hTYVd5NDhERkR3WmU4OUtoSUFiTy9qZExtT1lIbWw2N1Fv?=
 =?utf-8?B?QmEwcU43bW9jWTBwZ1ZYZmJmazZHSDdreGxTRTc3R1ZDaDE2ZmkxYjFaY3A5?=
 =?utf-8?B?SVpadW94YUJKbHlNUEhVMERGN2p6QmorV3Z0azBzTzJuQmN5ZHp1eFZ1eHEr?=
 =?utf-8?B?bG12MEtsdDJJN2NpMnJ6TEEyc3JwcW9vYXA4VzFSa3F2NGwydkg0QWxpNk84?=
 =?utf-8?B?dHRpL3lCR3NzdklrRCtzZktKMnlJOUlUcm8rOEZLelRTenZ2cUp1d0hKTXhl?=
 =?utf-8?B?OEVrRHN3T1E0T3ZlanhLRXpsc05wOU55K3lma1dQZ3NXK05OTS8vdGE4OXJS?=
 =?utf-8?B?RUI1amtyTS82RVdWeW5RVXdvNWpSbUEvd3puYnNmd1gwQmVvQ0EvU2lVUExF?=
 =?utf-8?B?MHlTenRuZytEeWhYcWFETkxCRzQyU1JpV09UelZXaWlmeThMRFF3QXBMMjJl?=
 =?utf-8?B?UFZ3b21LRG4rUEJRaU1JK2lCdDlXQis2anJOUzV1eU9zNEJlbjQ2Q1pINEtN?=
 =?utf-8?B?Wi9JR0paVWRTeEhrdVQ1YVhYSG01ZGFNdU1BcW04UzFhTDBhNU9ZZnFhM1VK?=
 =?utf-8?B?V1R0dU9SUmIzc1pFRVdpR3E1azl5cDEvZGxRQUxraUUyMFNkYWtnbmw5empm?=
 =?utf-8?B?Rml5eGdhVE5hRzQ3djg1SVpxbGtQSEMyUlJQbEpEcjBoNXZHSE5pWHM0OTNs?=
 =?utf-8?B?aGV2bml5MGJYNjlSRkdHMnltcW93bFNBL1NmSElPcWM3cFVhb09FSG9kY3Qz?=
 =?utf-8?B?bmkrNTFWU1JFUDFqOFFjdVAxUERKdnFmRytMcnJRS1VKMXoyWFJsSVRlNjZl?=
 =?utf-8?B?dmo2MmluNXZIdmY3YS9aMy96Snl3SXRJT1A0YXhaakg0K0VvOEsxNnI0QXE4?=
 =?utf-8?B?WmpWWHB0RW9UTXBub3lZM2dMUWo5YXZseDZKZ3BtemYydkZ1dU9HeW4yaG9t?=
 =?utf-8?B?S3FONlFqaE1HQVBUc0RoU3Z3TzdWa1A3S1YzVzkrVHRPdXMrNGFmaEp1VGRC?=
 =?utf-8?B?cjgzeFJ5UDRqckZsL2RxQ0NQYjFKdGdESnB0cS9FZEd6d1p3YnlFQT09?=
X-Exchange-RoutingPolicyChecked: 2b3mQiVdkWxBNGZSj4X/X2m2+tKnHKr6psg40CnClTHl8fdFkF7QaZVpU9ofYkEG2jG0i5VjD8mm/jsxmfm0qiFcMTD40Z6gmwkpTcGcz4Zcfgx69fXHtPaAEuiBZhqPIqKE5n9Pivo5HBw6waoMKTlODnhsTLMUfPCrw7TIZZqVbBwlbFpiFbhhOC47wtOEbyiDj4N1ZoBjZubkIP4q/zxt6iJknDtp12CM9nIY5VfnHJSHyxfNS1E4DyUamc48O1EOqSUjOsI5oAQt/tJ3so+yxK4BM2p/kR5pcEWE8NeFAMEW5sJTAIcOJaLRZDJ4a9rl6J7VhBDirwzkrDRJ8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 85997464-c462-4606-81d2-08df1e47bcc7
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 16:35:57.3149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1sgXYaOaJsXkaTi6xf4e8Neubab2alw/qP4D8ozn7WLG0tFU9RI8GZwLDMLxHvUVctrXfRoOSO3TnNrsOfq7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7135
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


On 29-Sep-26 1:20 PM, Pratik Senapati wrote:
> Extend ML-KEM Support in Test to include ML-KEM768
> and ML-KEM1024 test vectors for
> deterministic encapsuluation and
> deterministic decapsulation.
>
> Signed-off-by: Pratik Senapati <psenapati@marvell.com>
> ---

There are still missing tests vector variants, see below:

   0) TestCase mlkem_512_encap: passed
   1) TestCase mlkem_512_encap (deterministic): passed
   2) TestCase mlkem_768_encap (deterministic): passed
   3) TestCase mlkem_1024_encap (deterministic): passed
  + TestCase [ 1] : test_mlkem_encap succeeded

