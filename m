Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FDFCC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 09:37:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 758C94042F;
	Wed, 14 Oct 2026 11:37:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 331FE4042E
 for <dev@dpdk.org>; Wed, 14 Oct 2026 11:37:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791970643; x=1823506643;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YiNMGFjFn38X4OBVUTC1F6nzfDnFq7megk3MeAXh7Do=;
 b=mHf9/LriJDhVRzKsa2GELUvZ11ZImtcDr+Q26c69hYXDEdvT6EliRa2D
 7cQV4TI710tkJ8LJJvxmSLJd16zhTr1Q5EM27535gismWq1mQqpmcjm0y
 IZLkLxQHn5ZUbLg+qreDLGweD59K4jrnGBBqmBxek4gawLf0UOfd04d7n
 HHDtF0a0Zz/mieYVk1pg/62s5xZmn6Ck1mZ0q0QhMuRl23GSlDYPYpTA+
 jMy+di+Ld4a6eHtHoKOhAB/TXO5PULVQszeWgm5I5AFEFa5xK5fnxZ7fo
 NTAY1Z9Wr2Piekv0g7XE3LWWAhUH0bim7STyQ+C2v30U4W0cXVeHtvIEx A==;
X-CSE-ConnectionGUID: DxDoTUH6SveqDEAqth7IFg==
X-CSE-MsgGUID: R+LDuEUHSrKUE8i77U1yxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="598487"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="598487"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 02:37:18 -0700
X-CSE-ConnectionGUID: 8Hf7V82zTZ+ibX54q+j8+g==
X-CSE-MsgGUID: RUb97TypTWSE9KTMq30XKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1276776"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 02:37:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 02:37:16 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 02:37:16 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 02:37:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ld6r+dmyjMDucgf2PsgfDdUPdasKww12h/EKoEBG93xH9HVmk+RZoXiIP+MTnG4+dSHR5UsQCvbXQThGkSvaxqAeQSrjjQidl1/hY7SOeb3emV7+TZtXaR+2Y07gMRibMp5iPVN/w02IGIAZ1gUrpWUiZy/JVPqcLG+QfMBzCKqt2jQJhkSEeFMF/yZRma2kNYYtMLnWVg26RPUATCh+jeG7QmIFkXH5yYS0zkTa/zeQpKj+cgfnjH8m7dcn47mepcoV1rkSsn3VdagE08fvflJwVOt7kaC/69FOvCj7whE+KtrY/NNcOu61MiMqm50skAU+LzYtMmznKP5dbpmT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pob/LANKqXgHA2m0yJZ4bstbNjxhahcAPp3VLgaZSI=;
 b=QZnJfHWYzvxiUWDOPQATVipYticjEi1yomWr1nEnuF7suTyzjtU/ouCgRoh8UXowpl0m0H2uPg3u83z9wxYougM1ztL3aVDCKoAM5b3iSMboSMNr7eDO3X+84xY/5Hv71FU5CuktPTeR53w3IhHPXSV8z3/Qnee3pZRQHzh+G986DnbsP3k3RMvPQ3Hul7oxkWVVQlSoVsIKZKKopA4K4HjOSxKfnOSPuu20U6pwVfba96CFj9PP+g2z/+DTv3RgFwOp4TH2XPPVArors8fBl136lDKUqKsw9+TmkxMKl9H84dvSoNYprdsfRxkRCJjqwF/heHbaIRvuvjhc/+zfbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 SJ0PR11MB5135.namprd11.prod.outlook.com (2603:10b6:a03:2db::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.20; Wed, 14 Oct 2026 09:37:11 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 09:37:11 +0000
Message-ID: <9a235219-aa8c-4372-8a61-d2ca9d731604@intel.com>
Date: Wed, 14 Oct 2026 10:37:07 +0100
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
 <SAWPR11MB992100DA82CA3158F0D374C184A72@SAWPR11MB9921.namprd11.prod.outlook.com>
 <CO6PR18MB44840100B18E768A90E3A5F3D8812@CO6PR18MB4484.namprd18.prod.outlook.com>
 <0UZYeU6OS3OoPauzypyoiQ@monjalon.net>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <0UZYeU6OS3OoPauzypyoiQ@monjalon.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P191CA0018.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::11) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|SJ0PR11MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: 3058fe7f-54e9-43b8-a86b-08df29d6b8e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|261009223027099003|4143699003|10067099003|18002099003|56012099006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: wlzX04x9g3JNWPNC8zS3LE6ovsAaytAj55SgFGpIjQZ9aN9Pvp50jQpnQ04C4UXZpoYciXN64XFoLvK9XKCNAJIFX9NC+QXy2h6HNkM3Q56ikqXYcY3pkxWCX4cZhsAVefxDWc18+0lY7QpJvdWJlERImJ/rEerKGFMsUaNC21Jpp1/KKTPnx7NSM9Hims9XSRcgrwpB/8EyHTFyGSHdL7jppcUoQxyp4S1DOiwc8I+w56XrwkBIa29jkwXNTwNyyOwMcumgaSIg9Koyn/H4y0CeDs8dwbCmteE2Xbfn1dDAlEOuaHIWhQV5T8fGYms7oHyTaE0LVGLtyGniArEpeK7oKsOrIiWQoqhXOcBcze23LzX/C2HFdSGOAtcyrLaFMOMvIz++IlqpKepricQeFntAv7Zson+8vcOaYDNiAXI0FAH3DubNBMvBm5k/eoR/tkQjfsBBseUwJ6D8N2lddgGtRX7in0VE6K2pccnw3NM0qJ+2/svj/nGXBlVlVduu9M1k4ZMC6xnZRMizFCDjwMy/MocRcWT2L6JCPioL8qRGcNHQWoC8VMdSEs8HEYLQjDJ4STamdnVJqAiYFPHcQcXnnL4563SESUS4Ab3ICgoPb6IZlkWcmPAIns9ANZo+MH/W2q0YIm3yx1M57FBBbTA8HKg+O+5hHO6cbIdQmyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(261009223027099003)(4143699003)(10067099003)(18002099003)(56012099006)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWNMbXVJUHcyS052bWFkRmpKSU5rZkRxc3RERDRtZXA0VldOQnQ4ckVZYnAw?=
 =?utf-8?B?dU90R0JYWmcwS01zTXNuWWc4YURZenZBREs5ckwwTUhYWXN2bjZyWWxqNkUr?=
 =?utf-8?B?a05xNnZGa2VjSWpBYTJBNGdCMEJNc0NCQlE2a05CMHg3WDdYVVJ2QkFhSW1U?=
 =?utf-8?B?M1JBQ3JSUUZ6VmVLNHRiUGUwUEtoWkhaZlg1L2ZOUk1JRFlqRzNHbk1mTXRr?=
 =?utf-8?B?TXcrNVFQRVRIcTE3eXlEeTl5QXpQa3F3WFdGeGVGVCsxU29xYWhYaXZTTkcz?=
 =?utf-8?B?TCtwM0Q4eUJwVjNSNXh1cnpHbjZvUGRzcFZPemM3dGtCekd5UFc0QVV6b0RM?=
 =?utf-8?B?MjZSR0pBM25oM3Z0d0g3d2p5OWhhb2NMV3M1UVJjaStjQmpCOTdjbHVlT2xS?=
 =?utf-8?B?SFp3YVdYV005aXdPWElUdTgzRUE1ZzB5c2dwczYzY1pDRzIvNjIycnhqTXpp?=
 =?utf-8?B?bXhNQWo4c1N2V1d6ZURON2prZUoyOEpvcjFzaENyTkVjZUdHaTMvVm1qTXc4?=
 =?utf-8?B?TEJuVHgxNDREUDljK1RYbUdaTUFJT3FsU3FsSTBweXNaNnVxQVBmeU1LZ1ph?=
 =?utf-8?B?MThjZWtETlZOYlRRc0RFRllMMUNleThsa3FrTFo4dEpIN3pUUEZKTE9DK3pn?=
 =?utf-8?B?YXB6c3NTcFN1bXpuV0xpd0dMU2tuclJDeWxLVDhZRnJzYUd3NG12L1MraWtH?=
 =?utf-8?B?ajV3MTRJYlhGalBTTXhmVU00NkpQMCtaaGsvczBKUUVkb1c4ZFFvaFlsUlYw?=
 =?utf-8?B?aFNiak9IOWkyZThMbjhSVndzUUdEOStpdEZtN29DN2dEejRiMDdiMmRnMnhT?=
 =?utf-8?B?RmhIUDM2bFFQcHl0ZTJYdXhnUzVrU2ZyQ1NrVzhMcDd4M3NZNWxKQnZtSHlQ?=
 =?utf-8?B?cjJZMVFrTFhLWDc2QWJyK0Q2T2VHOS9FdjY1NDFoZmNQZ0tMdmtROHVYYXU2?=
 =?utf-8?B?bW9lb1NmNGR3cHRla3BVUUNnRmIwbUthTHRJSk1ZTHJuTGNNZ3ZLczlwRTZx?=
 =?utf-8?B?WFJXN3AvaGFtQ0RZeDB5NHo4TGhiQTBGMUh4dFRtbHhYWVRQS2JQaVJMTGpa?=
 =?utf-8?B?S2lTTGJnVHVXQnFuK1NTYXBueW0ySW1pZ3pNSnFVYzhDNVNhNmtUazZSc28y?=
 =?utf-8?B?WS92dGY0elQ4V2RlNDYzYWJ6Z0NScnRIVVFvR1cxMG84dk1CeUdhMS9Ra1Rt?=
 =?utf-8?B?c2ZJSGU3R05KOWRiZWsxU2grMnMxYTJsQlp0V1BnSHM5NUxmMWpMcWFOSUtM?=
 =?utf-8?B?U2JWcWxRRG1uRlRIRE1EMjAvVzVYMUxtSmJ3MXEwUFhydkxMM0tsSnRGSzRJ?=
 =?utf-8?B?RkVSd0JPVHZ2dTVtVjBpdGxCYzU1TENsUDhZMzZCUEVyQXM2SndhM3RDZ2Yy?=
 =?utf-8?B?RzlIN3p6SGRlYWtmb0ZhRGxEK2FhVWJYYUJQYmx2QzNhdnFsU3hTYmtTdDR6?=
 =?utf-8?B?aUo5cVdsR0hJM0RiSCtaVEhlM2lORFhKaCsvWjZIa2xCbkgzUUk4WUdKS3BF?=
 =?utf-8?B?S0pYVkZjWE5VMUNSalNaQ0owNWxESFl6VnN5SFp0c2VLQTBVMXVNWXloL21K?=
 =?utf-8?B?aVl4TExDWjB0bXVmN0RQZXJacktEbVhmWVhhU3NBRGJQeEY5d0dvZGFsdzJV?=
 =?utf-8?B?UXBxUFc2cThNY1g4enlib3VISmV3cE1XWUtwdjh1L200MndPaWI2KzhqQXUy?=
 =?utf-8?B?ak12WkRUSmhmSXIraFpjdUtMeEthMzNmQjE0b250ckZZTlhCTmkyczNISXdT?=
 =?utf-8?B?VnIwM21zUC9BVUw5VmswN0lLbEpuNVJRaXY1TmovazdzajdYTCtjRVNFd3F1?=
 =?utf-8?B?bHpwRTFyLzUxdGRUaUN5VCt4ZmsyeTFUbXVQSDlsZzJXaXc2REpEY2g2MTg2?=
 =?utf-8?B?QTdJZmtvWENSMlVWak10MEFIVnVGQlB5TWJDVUhNWVhhRFRhdEFKUlg5R25W?=
 =?utf-8?B?K1lXdHFNY2VnTzdXYzN1eUllb0c5RE52ZFFkZDRjT0QzTWdWUVAxdW51Sm01?=
 =?utf-8?B?OUNNcDJxTm5CZEIrbUh2RlRvV1Fwd3k1dmZ4NEZ5dlg3S2p3Wmw5RjFUYXky?=
 =?utf-8?B?V0xYZENnaTVkblFYZHNiU3JrL2FlTjNDVSt6TkNUL00zMExqWGNERllGMVU5?=
 =?utf-8?B?UTlGSkJlSzhNcElGR1NPM2F2SzZ2TFFsYzY0cjNNaXIzT1YxTFRJZkVLRnV5?=
 =?utf-8?B?d01nNlpvK1pQY0VIZk0xTUNaQ2ZTRllHYzVpNUJFU2V4T1JDb2VqZ0ZIcU43?=
 =?utf-8?B?d3FjWkFSMnEwUzJvK0dnM0x1QmZxUVV5eHowbE5FSkNxaFRHMDlIaXViRUJK?=
 =?utf-8?B?dmhZQTZUeUJOdDNJbnVsTVV6Wm85ZVQvTlZTcmpYeHhmR2pJaEFnUT09?=
X-Exchange-RoutingPolicyChecked: luIs7lOViBPLEQafQNlfFE8PwfWYDrYcCW46r1FS63g9Q2pEVgadnoKlBlCTV32lMEqX0r8Fq+ykt0LY3xVCDLuy0xCSLTJ/dqG/PoHdJmIF87k8K4YngdaccL1wphivW7bLHcJEprSqLMBitrZyr9G8FR3RcI5rwIVY91g7H4BCtcS9E0zTjm9qzr5gw9MD7mDSnJT1Ln9PY2sNWunhtsFw66PKf4TiB13RYXKgoJnmwTdCUUe/YX3XoJKBBNsti2v7TnLKC8NKT4khIOFIlBif0LCaXvXW4bw01UtgrMQtTjO+ncF1GfUuQO5Vn/L2TvR7TvDSPwOnYy31l+hkPQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3058fe7f-54e9-43b8-a86b-08df29d6b8e2
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:37:11.3656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joYI+qDDdUbrxSdQneYDmMZFc/N1WkfCHTbkoQJgNjE3IrRZSiKiuABGr6aIs48+5BgjfAvMXJYd+ejxZqUc2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5135
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


On 13-Oct-26 8:51 PM, Thomas Monjalon wrote:
> 24/09/2026 13:18, Akhil Goyal:
>>> From: Nicolau, Radu <radu.nicolau@intel.com>
>>>> Increase the minimum required IPsec MB library version to 2.0 As a
>>>> consequence, clean up the aesni_mb PMD code.
>>>>
>>>> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
>>> Acked-by: Pablo de Lara <pablo.de.lara.guarch@intel.com>
>> Applied to dpdk-next-crypto
> As usual with Intel IPsec MB, it triggers a compilation failure on Arm:
>
> drivers/crypto/ipsec_mb/pmd_aesni_mb.c:24:32:
> error: 'IMB_CIPHER_SM4_GCM' undeclared
>
> I have to drop this commit while pulling next-crypto in main.
>
> Please find a solution.
> I'm still advocating to merge the Arm fork.

Hi Thomas, the root cause of the build failure on Arm is their library 
fork which lags behind, being at 1.5 release which is at this point 
almost 3 years old.

The only solution in this release cycle is to drop this patch and rebase 
the ones adding support for 3.0.

Considering Arm lack of support and contributions for these PMD over the 
last couple of years, the only long term solution I see to avoid PMD 
code littered with ifdefs and supporting very old releases of the 
library is to drop the Arm version altogether.

