Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E21C79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 14:05:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AEA840691;
	Tue,  8 Sep 2026 16:05:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id EE670402DF
 for <dev@dpdk.org>; Tue,  8 Sep 2026 16:05:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788876320; x=1820412320;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1M0LyngQ/dA8rDkH1gq2dGVwPjn6mW1IjYZeWFyvFAQ=;
 b=HnT04zBIUlXWa3f0RPFfinKUAaV2g3i3yHjLb8THtVHPF919JtiGxm4w
 iCxQZWfYh+Q/y3r6odSNEmj1PGilkNSf/xrvidAi1xFM83CdGaXbXb8js
 2unoADd73dAUbmRe1iQrz/0SXLouZ0YNWJhYF2CVMOY/hnfPOcRj9+3YF
 xOj93gvmXvPLPj0qp7E4AD/oRb9tDrU3fMxfYViDfDBzNMUrHnT7vnLu1
 5m06VzBkMihQMTrOJFRlDz5FpoZepvmgPbv3aS1hGPCyoc3DVdlPaROCv
 MFeWxhBkl+FywZ211d6bdFNQgxFQCuIjyq+/V+OHXKS/z+sLTcKcM5eNN Q==;
X-CSE-ConnectionGUID: C/L1LPxKTuiCrGUPp59ZxA==
X-CSE-MsgGUID: OzYXzdfvS1mRzlRnCca+nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89483477"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="89483477"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 07:05:19 -0700
X-CSE-ConnectionGUID: bVDE1QazQQaEPDDPkrswEw==
X-CSE-MsgGUID: HoW7owuMT260I3NVoTz7Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="294514975"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 07:05:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 07:05:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 07:05:17 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 07:05:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KreC5vWIkqTEq8UkfBO8lczx52/cdy9/d9OECLluPtMzBhrjbGTkVFjVE5K7D8ilLDcS7YyOsZPIBRiZrb5MkzHeRKE9u4Gmpbo0NsTdxU4APqXHRhvcZqZ6uADihn7BSSfGGinirF0qe97/DndR1uxLKGg+hPYeHmNLl48ejj9RzcfGcoP21AhGdAN1JPSCe/pDUWOYFaxOO5CZrgOrO0Gg7yQ9yK4VlBvJ0kaH4PrRvwHqEAlMDV2aoX5znMhQ4oODNNn/oyCSSJRJntuENw7wuBXEmej3QPWH0gxzWBp4n12Q/vjeYJ8xKD3L2Njzx6QrwnJiR9FYCXG38xKwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1M0LyngQ/dA8rDkH1gq2dGVwPjn6mW1IjYZeWFyvFAQ=;
 b=v3HNjz5RNvV8PFTDaSqRChig8S3l+DWjaZzw+3BODt3dyFJnzzjrMNL8lEUY2JR+IpF3/Z0d3X8Wb7wVlfcOl14ZWzFcnw3Sreh3e2lmUqDiGczBaVWPn+l5DBgajigu0/asHFZZS2EmIJC0F+IMQhefcmzvspssdtS3DUow0UYN5HzPPv1UeeQ9QGxYGthXdI7qSPPBsnKUEyRc7Kyx/ndGyuVtTzYmHa0rUN/j1Dg/VWWtiCsBTK/vCP/7pblfXsXRqwMxal/dXDUbaBNBo3dvtYYytXXVz0uNTl36BUTGuzw5VzAw+3HHaMKUQoS4DzffxWcVzmhIzgtKOYVp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 PHXPR11MB9686.namprd11.prod.outlook.com (2603:10b6:510:3ca::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 14:05:15 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 14:05:14 +0000
Message-ID: <aefb2909-0c8c-47b1-ac03-9563c7662aee@intel.com>
Date: Tue, 8 Sep 2026 15:05:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] crypto: add RSA-specific capability parameters
To: Sucharitha Sarananaga <ssarananaga@marvell.com>, <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <gmuthukrishn@marvell.com>
References: <20260831102328.2813604-1-ssarananaga@marvell.com>
 <20260903082648.3610676-1-ssarananaga@marvell.com>
 <20260903082648.3610676-2-ssarananaga@marvell.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <20260903082648.3610676-2-ssarananaga@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0036.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::23) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|PHXPR11MB9686:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e1ec7a-b62e-4557-38c2-08df0db23470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|18002099003|22082099003|3023799007|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: w5qPhlauSt1LwgqaFvPcst7upe72tfcp6mBsqphe/0d0LzIBPXscOqJNgciRzeNPG0riV4rhjsSy0ZLtrt/Ymos6hU5VxNsd9it3RznzqMazBaB+erUyZDOsBQdW8io1hHGI8BUWb3OkcVSBq+JNJp2gpL+qX4WQTZbZynmUBWV8y1ygVUe2FHn9fPTcvY2PTIaubsHP1lrX36ZzdIjFDKVpfC7aI+ZzQXDpSBe9T4qGWn1LAKViXVFz7OGd0Ey+Zd3zUmVYFf58UVzJhBO7OctHX3ZASC0s1ZlO89hecqVOqXfufvnPSR3qiUJto/bnDmThNYvpwaylP1i6ScdzrFcpuvdOnK07B0lSUf4crUSUaf42JszlKgApiX/TQvF/pmuVrzitHtlqFkQmRJEKyQ4yX69IxQ8CRVnmleJ6n/5N3FsEAt5wXdrTUdxE7PTegNyb7VQvy0cnA/ia02TMzca/TgJWF7gy2SSAiCDDWb175f/z4SWhq3oWpxBICfle+p61/0pwFJKwdfIZkHZeQ8ojTS5E+j0BlShkD1rzyIcNoPvjNzE+k5BmuNt88c+1P0Lf4nicQ5DHxvnK+gNPHqD/ba/mQxQc6igtzuLE2hlKQNuaBxWTx0XJZ8fNK33bdJlFXwM1bgOEXgmFV2xotkk6LAuMl7MnU7gVEN6RzYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ni9IdkI3WWJrakc4NEFaY2kzaWRjUFU4WXZUWkdGNnJLYXNZVXAyRVo5U01N?=
 =?utf-8?B?TG9pUWZSWFVYd3dGVzlOMkJvQkhPdFZYUGtIWGtHQW1KRjBZT245cFUzY2FR?=
 =?utf-8?B?ajdWdVhOdzlCcGVYNmxWN2FOWG91UVo1dWQ1QzRjTWtNcG9EczFxNnowcFpm?=
 =?utf-8?B?NVZQcXpVS0t6OGg2ZkgwL09EcG5xdkhNTW5NZkptUkQzN1JJVHM2Y3hjTXNT?=
 =?utf-8?B?bm8zVXk3bmxGNUlCOEtsZC8zbE5ra1VvSWxvZG41R0JzRTVvZzRoK0k2Vncv?=
 =?utf-8?B?WGkxOExHSCtERmRPMVJCdmViSW9ibkpRK1BGVzhCbFNuaUIydWZiNnhLQzRw?=
 =?utf-8?B?ZEpkTFBPbFk0WXh5ak9uRzgyQXhGZ2oraTUrNDc5Ti8vckRtZFRwVUp2MEVh?=
 =?utf-8?B?TVJOWnNvR1hNOEhTSWxyMUJucEhkZmk3Rmx6S1dBVFVWK2NhNGduOTRlWThK?=
 =?utf-8?B?d2lWWkt0bUdxWU1rOGQydU4rNmRhU2lkUGd0Yjh1Q25lZkcwMmhLWmlLWUVi?=
 =?utf-8?B?U0pwQWtNZnFLck5qK21qY1JqK2pMK0NrRzBoZE00OXowSTFkQmhwQW5NUWc2?=
 =?utf-8?B?REtDV0pVcjdocUlQNkhzRng4M2Z3MHRZaGhSTnQ0Qm5BenptblpmRHVJbDhU?=
 =?utf-8?B?cis4WWFXK0dCc3JHdlgyak93My91SUhOd2xjUmZ2ZGRDRzRVQnFicVk4Wlhr?=
 =?utf-8?B?VFlDQWZ3aFJFekJFSVJZQkh0dlZFNzF1bUhSaFprZUw3NmV0Y2VRZ0JZRDlS?=
 =?utf-8?B?SUc4eXVib3dZVTRiU3ovRC9YZ1ZpWkFud2dueS9McGlzRmJVMGFia1Yzblpw?=
 =?utf-8?B?Vld3S1dETTJFZnk3c0xWd2ZqM3NtUXJuUExMdnFzbis1ZXNGVXdXUzhxL0U4?=
 =?utf-8?B?TUlUZVUrQXRjZVZCVjl6dWUxa05BSURNSTduTnQrODZSQ0thZzV5TG0wZ1hH?=
 =?utf-8?B?Q2dHL3djL21GRktjUUtxSUJ5L0x1LzY4MG94M0dOZllsRzNzWHFBVS9zZko0?=
 =?utf-8?B?K2c5Q3BXWFRFU21URmNJaUFvMWkrUDVBOFFUd01VU1NPNVJ4ZzdMTFFjaTNs?=
 =?utf-8?B?dVNDVCswSzlvOHVvTUJtRy9NOGo4bC9MVG8zRzE2Nk1HQWtSZ2JhSTB2aHkz?=
 =?utf-8?B?OXFWZFBkWW8wejB0MUkyWXNzUmRRNGtzZXY2ekNpVjIrTVdPNjBjZzIwSkk4?=
 =?utf-8?B?OG9QaFQ3dllEUzQ5d2xENHdON0VlbnpEUnQ1L0FNSDVZQlNqMEFuSUQ2SC9K?=
 =?utf-8?B?WkYyVG1KWWlybUJqQSsrZnVyOG80MFZsclluazk0elRTNE0wK2UyNFhHZm11?=
 =?utf-8?B?VkZranhtSVgybXlzeTV5dFlOQTJieGpKQ0drNnJDRnNpVUl5dUY4WVVCVWFX?=
 =?utf-8?B?QTUrc1NwOVYrNXVYdDBXTzdJS09ZT0dIRXVtVUZaZFNRNXNDYVJxTmpsTkl3?=
 =?utf-8?B?Vk9OTGNjRXdNOGx1YUM0TGhaeFpHeU9FU3BVaFhlRm5uZWx4bTRMWDRPTGVR?=
 =?utf-8?B?ZWg5TGFBQ3FPR2R5Z2t5a0h6T1BYOGxCTkR5dFdIWFZIV0JpaHhQVFZxeXRW?=
 =?utf-8?B?RTZLVEpqOE1GS1oybklKMjNaeVljcTF3SWxqUzZRSytuYUVzWW9lSFJjcXRq?=
 =?utf-8?B?cVJYN3U1UFpvYWZ3eVBBeWk3QzdlelpnaW9xS2RtSE11bTZKR3dDUTlkRXZG?=
 =?utf-8?B?ZjFJakJXMDliK3NuQXJiVnhleGxBeTV1elZEekhOZkdiaUViMUhTNDVzd1Rj?=
 =?utf-8?B?QjdWRVJiZ3FQanRJVFR1dHpoTVpVblpvVHFucGtSTkRNa01oWjJyVFU5YmhW?=
 =?utf-8?B?bnNsbFFLL2FKYXE2UXUrUUR4RlpOZ3FaOWhsQ1lWRHFKTEtzQzlNcVBhM1Fv?=
 =?utf-8?B?bjdUNTA5dEFWR0pIWXk0ai9SaExTTDZCak1xUVZQanYzSDN6RjdqSUFRRHY1?=
 =?utf-8?B?SU5MSG5xR1NrdVlzQjJHMS9uSmxiOFplT3Fyb2VVYVBsS3FlbWhLMXRvU2x0?=
 =?utf-8?B?Rzd3R1dIK0w1eUxRNTRCcUduU3R2SkU2cjlCVXd1YmV1REJUendLQ2lXUUt5?=
 =?utf-8?B?QXU1MWNRNHEyLytLK1pMNThsOHExMVdoMkY4eVF5VnhKanU2Zm81TnF3eDB2?=
 =?utf-8?B?Sm4rbW9nWEphTU1odVFEcnpVSysxU0wwTmowaUtqM2Z2WFlRMmZRRnRtRXll?=
 =?utf-8?B?cWZhbVk4WjFZdS9BdTFIVUh0R0hkelpCaW4vRTI2ZjJxVjBPWGhrMXZYU2ZM?=
 =?utf-8?B?Q2FBR1YwZCt3S2ZpaGxaM2pwTWJ5QW1uWGRNbWtmS1d0YzBoOGJualA3c0Fq?=
 =?utf-8?B?LzlaOWx0QXgrN3pYc0FpQTNBNWxjcDdSTlhMeEMwU3JSOTYyemE2UT09?=
X-Exchange-RoutingPolicyChecked: BJJO/BcFoKwMkg909O8Ti+yjaJzE3VLO6M6yK9V3bwv094jx/ImLmsrF1KpLQdZ9ORAGshEW6Z8wZbGGWlmMjqydUu7oQc+vU5BXAP/s4Hu+fHWClrRDeRP+kvZI/9Bg72ACqqBWTv4uYtuw9mg5T0/kB43RKzkjFcgNiywdx9f+8DcgCsGY0i8UN4hvacAevAOD428bcqFDuA3qt54jM/c3G8VKWnT5NEfD/L6kVsEJfO2jOYEeuV2oFAhDaynrFHBzdzRGjTvS1RZcO1edJBgcKY5UxR5t3kJXqUM0+mM7icgVnS22Eng+1AZvtPEc5hQ+0jMuatoPOMVGhpe8SA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e1ec7a-b62e-4557-38c2-08df0db23470
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 14:05:14.8760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oH8VQ5eKcrLKFn55UjyRgCsqY3MnGH14W5N4x1IfRBHUL9O6f0ErjcTEQjuaanIFpabC/pp2NI7M7nFi83+dXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR11MB9686
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


On 03-Sep-26 9:26 AM, Sucharitha Sarananaga wrote:
> The existing asymmetric capability structure reports generic
> modulus length and hash algorithm support, but it cannot
> describe RSA-specific parameters required by OAEP and PSS.
>
> RSA operations may support different padding schemes and MGF1
> hash algorithms independent of the primary hash algorithm.
> Applications currently have no standard way to discover these
> capabilities from a PMD.
>
> Add rsa_capa to report RSA modulus length, supported padding
> schemes, and MGF1 hash algorithms. Keep hash_algos for reporting
> primary digest support.
>
> Also clarify that the generic modlen field applies to other
> modulus-based transforms such as MODEXP, MODINV, DH, and DSA.
>
> RSA-PSS signing also normally generates its salt internally, so
> the same message never produces the same signature twice, making
> it impossible to validate against fixed test vectors (e.g.
> ACVP/CAVP SigGen).
>
> Add pss_explicit_salt to rsa_capa so a PMD can
> advertise support for an application-supplied PSS salt, and add
> the corresponding pss_salt field to rte_crypto_rsa_op_param to
> carry those bytes per sign operation. Leaving pss_salt unset keeps
> today's internally-generated-salt behavior unchanged.
>
> Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
> ---

Acked-by: Radu Nicolau <radu.nicolau@intel.com>

