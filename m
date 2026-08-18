Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22D9C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 16:14:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1713C4028B;
	Tue, 18 Aug 2026 18:14:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 3F6B34027C
 for <dev@dpdk.org>; Tue, 18 Aug 2026 18:14:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787069658; x=1818605658;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=GKwHGkXAofhDu+tkwY6SoDk3Ki/p6nx2yS3oTEMWcL8=;
 b=mlj6P3LfkaJ/Kg8zCXhLz4ZTgAAF+XPYU35XdBtW78DnqyAsZ39c2rqN
 OA/mbPLCggBqLfiIMRVCHiKQAfyl2eiBbE4SEWnOFRuhCBv6vAFMVDKSe
 +IPg2iJwWhL1VLgKeGlVhSGxZqNfQmROYMq2UHmZZHLwFSZ8kFxUux35Y
 g/7VZE2v4jYAmOeoXx/siGZsrmKS63bgSCHLIifh4nDw8XsA0rsH2MmUm
 yFywtkpuT7j8PKNBZ5xzdZ1GF6WKLl029NxelRi+9zhZhDF/Px0saQ60P
 fRZze6Yl661fL7XhLlFZRk+zpq/jvDCk+tgqMuunkR+u6koovmaNhtulU Q==;
X-CSE-ConnectionGUID: hEkT5taCTeGHTT6tBvRDBQ==
X-CSE-MsgGUID: QcKgByw1Qour8SDZ9xpThw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="105101368"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="105101368"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 09:14:17 -0700
X-CSE-ConnectionGUID: l1OSqdaVTNiBoNg3jO59RQ==
X-CSE-MsgGUID: iA9l8nkrRXClMr3IzwqIRA==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 09:14:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 09:14:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 09:14:15 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 09:14:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qR6Zt4XFRAoyqaauk5KEkscl/635nRqsNzSSbYJ9YrCxgHFQNhAGejQ8VsrTXbeMnCsf9h6O229v9DPApZLSWwLz2EbPRvycIkdgYCJJsXa0uvHc4v2Q7KYCg1L5/DC3OvBkye/ZADUIQwHEZmlJfsI02kVZNRGUYz82V3ytXCtpUt4R3HrBLYOFjEKzmttqyJthv4mqB4+LiWL2tk88HvteRC4GqzSATt/eCijksCP4Q/nm1RNnQ5F+clCfzbWT/ZRGRvP4ceh45u7JZneWr51wqSuJ0TphIvlfunMnnLm/8a6GJBze1Rqwu167VnFSfk0qntfw+9r4FyLtpV3zsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTXpOhaeQYEuoIkNewu2S7ho4zjs4LgegFro63Tg3gI=;
 b=lf5ph3SfZVpbVu+OROO6esXw3gsjNfNnAStoiyX+4M4zdI8qKR2wxSyFgo9Yzfkvx8Fhj1KYf57STznEyIlK/tUW1MaQAJwwY86tkk+OT6WEu1KQeVVqfMkq+xCejXYEo4VPaVdkHOE807+d/PqIn+NyImvWWsnffp626ovudyErmNG9aMfAAXWl7PyXxzWUD6YZ5/ZEUiBeYocAuZKwtSsw2I8mFJ+kIB1SXeObfBrQzxZ8xSXvSy6MFE0kyrYVOxOCwUaPTXARpL9hQdph8yAmAvqwqxCOyZQcq8kSKC/z3lW339/X1QcD//lwOaOHYCuqV2ICXnVGq+SEQZ3n9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 MN6PR11MB8244.namprd11.prod.outlook.com (2603:10b6:208:470::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 16:14:11 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0292.024; Tue, 18 Aug 2026
 16:14:11 +0000
Message-ID: <f081ed03-997f-4daa-88fe-ce309eb79591@intel.com>
Date: Tue, 18 Aug 2026 17:14:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] IXGBE IPsec fixes
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <cover.1787059137.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <cover.1787059137.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0060.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::10) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|MN6PR11MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b525155-c405-4b6e-f3a0-08defd43bd4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +C5lJbCow0arkV+k+MKT+b3Arkt6mK/YbwpmDqcQAzl98KMPnWh8MvnavDzYQHZ5phEquW/yxQNn2fRPugWNfVGS+9Jfw2WQEaRPokwv0PkDQHCgmZHtKYDADqE0zxyMgHaEPX4AsjFPwZL32EVkG+/7Lmtm+n5vdkSFQULGTa/XIZGQalLDbshdIjmzNvKPuQhFstcYsgzEjxCBLJJr6AMZo1eR5dirY0ZUIi4jZvtuaTNaxDIbzpFIrh04zLzEJeo6n7RF37ChWNfBlCzfiYcKDK25TcwgBpzgpLqSoJ3B96KTkKETjcIceaPjHKIhg5PGPYmsC2r0dT0IetfkfIrMEh7fhqhHc+pTN9uXfv2t8vm4nQiVKlgcaQMMsrSbkqeQLUexRaevBPR8EduXLdpk9XjLilqBAhdVSvMeC/oLWYlnvXI7mW99IDa0nBt/1xKp+qcwvTcNciN/UZfXh5+xLJAzue0HRXwLh50zBjcqL1cU6uYUQNKXOv/fP7mfSk8bhbCeboJevPFkx/1ufcqITUu0Fulnaik2Ph1QCk1ThapVzKik2lNN/Xoa1CXC8E20zpWIgEUHRpFkktqQHb2gC/2i2MKZ2sbRf1RYR2WS1TWuAVoS/QhFhJ4Y9AAmUGmF64+L3H4E6OisjQpx2zAI7/pPxALPOMkYMj/jf+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlRBMzR6MWR2bmZYV1h6NS8wVmdPTURBUWVCTUJ1cDdmMjZUZkZLdkFGTGk1?=
 =?utf-8?B?cFZlSzlxTGttQ3RQTC91ZGdvaGhBcTJBZG9GZ2JsVEI5N0VjdlhSNHZhNFIy?=
 =?utf-8?B?Zy9HTzR0ejFEcUNVWCtoMWF4Skc5bWhzRVM3ZU9Ka0V5MWNiTGZQc3l5TmpG?=
 =?utf-8?B?THZkODZxTDE4bHNGcGhhY2FsL1R5RHo2U3hpR1p5KzNUSkpsaGVZUkhjNXBu?=
 =?utf-8?B?c3p2aFZWQkRPRXdaczcrZE1NZWdLN0RVSkdqTndPWlFhRXNyMm5sYjJEZXkx?=
 =?utf-8?B?ajBFaXJVSlExK0xPbWI4WTBRRFhWdTRiK0t0ZndIOWRwVDNzcnVzeVVqY2Ni?=
 =?utf-8?B?RVNrWWhJblN1bWdRUGozUU5sNW8wMGtSaGtaTzZyY2dBTVRGemU3dU5qVStU?=
 =?utf-8?B?K0grODg4b2gvUHBpZVlJTzE5cVNiWUxuUS81Nlo0NGN4NldEY251L2VBVzFY?=
 =?utf-8?B?TDlpNWFPYUY5SnZmNjNzVWVGSnNmU1MxZEVSaE9UOTlJVlVYSWlqUHhndlZv?=
 =?utf-8?B?MXlDNmtXa0VyaWZod2xXdHFaV044c3cwVk54a2FNZmU5TmdhdUoyTmFHTis4?=
 =?utf-8?B?eENOeWZDR3FscUpIZlQ0dTJqT08xVVVldUdzT2d1bnUwTnJjUWxiRFhqSURt?=
 =?utf-8?B?MXVqQzhxbUgyNHVFOHh0UXhrWG1tREVKenNyRENNUEcrNCsweGNqcmppTTdu?=
 =?utf-8?B?dDl1VUpRSEl4TzN2UHdQN1ZBMlBFdUhjOGV2Q2tsU1gvelI3MFBNV1VPQjVp?=
 =?utf-8?B?bDMzRFV6dDBlK0hnbmlKZEk1Q1lsRWtPRHBORWZrSWs5c1RMVVBmeWNyMERj?=
 =?utf-8?B?aHdYVEl3eXZndzMxNlVSS3A0Wjc4ZHZKQzlxSXVGU2xQakUwajJvQytvc0o3?=
 =?utf-8?B?WExGTGtDeWVjS0VQQmIwYnl5c0xzRVdKRUZjZXI1Tm91UUdzaU05QzZEOFN0?=
 =?utf-8?B?eXpOTnJScFBKaVJqa1g4OW8vYWtJdXZuZExVTmtzM1FxTTFBL0xObnBBaTAr?=
 =?utf-8?B?M1BKb0RQcFY0RlFacWRQamFNMGhYQ1dsbWw1Z2tUSkxlWWtzQWpPWXNCTXlE?=
 =?utf-8?B?K3FDUEdPTjdvQU5OL1JqU3I4dlkvNS9DeVBGeG9ISWY4bzFYbm56Zm9lTjd4?=
 =?utf-8?B?L2txZjBydEk0a0JyVVRLeW9BZXVUcDJmRWEyb2luNklaRWtCK01iNklpbzJa?=
 =?utf-8?B?Q3ErMDlYWmNLWmV3SEVQZ0s5dEMrcEVWazJiV003OHlkUVhLQm1oRnJPa0Q2?=
 =?utf-8?B?OWJLblF2QitPVTJ5NXgxcHlXengyWVBMRlprbjJjY0pOU0VxYTI1aUVENW16?=
 =?utf-8?B?RTFrTXNVMnE4Y1FxS29rSmxJMWthTkJsU3dhREEyR3J2Y294UmJhL2xyWW53?=
 =?utf-8?B?SERhRWI2REpJY1pvQjNKN01rcUdRcTRDV0xpdzJKZHdjaWtXMnBWUFdPem5H?=
 =?utf-8?B?NTgyOEhCSzdGbTVZcm1qZVU0NzMrZ3pkYXd1dWh5TWY4RXpzNXNlbUVJdkNP?=
 =?utf-8?B?dHNaa3pweHlaNm53QUpsRWlSTm9zY2o1OW95M3lDRFIraE40WGsxMkoyMnox?=
 =?utf-8?B?T3U1N2ROeE5CZTcyN2podU9MVmE0Q3hyVkdSV25VSmk1SWdtZ2lIVUwzUjJq?=
 =?utf-8?B?ekJuMDAySjZ2aUhmeWJ3d1NLOExURk1XZ0djL2hIMzdkcjNDVXdKZjh0STh3?=
 =?utf-8?B?WU1sc29Tdk12cXdwRzlnU09sVzIvOTVNa2l6S2xlTElaWFV2aGFqaS9qMG9h?=
 =?utf-8?B?bGtPUENMZGFBbTFTZjNmMzJBY3pLU3pSVU5Zb0ZzYi8vNHUrR0xtcXRwNVdu?=
 =?utf-8?B?NjFsd2RiK0JkZ1krVVdOc2lDQytFZ2lBSm8xdHVRbTVkdTU0MDIxU2pHZkZC?=
 =?utf-8?B?UExJaWkyaDNsb2ZZdWNLbEVKd24rdm9UWEhmV0dYcDVJN3lNTnM0aDBWWmtE?=
 =?utf-8?B?WXp3Qzg1QmdYcW9oZGlJK3JoQ1hlTW04UTZ0SEt1U0NaZVpjdk1UMEJ0ZUFx?=
 =?utf-8?B?a2I3SHg4VmlvNC9jVnlkakhnbzhhUVRJeTcrRlJITENWOUZ3Qk4wUjdHNGg5?=
 =?utf-8?B?NFQyRnRqZjl3S1R3UTA1RmpNZnpNQmpLeDNyeXBnd05YRmlOcHdKUnFabG5S?=
 =?utf-8?B?Tk43UVdIUEIzWFg3dmR6S2xqcGZ3U0lXbE16b3J5NU9RNjNlTDRPRGNNRTlB?=
 =?utf-8?B?ZEhrdStxVEUyMjJSSkpRWTNXblBjQlp6RWM2YUs0RC82Tng4c1FSSFZWMC9z?=
 =?utf-8?B?aWl4ZnJaTWV3MUJ4N2pBa1hXRzBoM0k5ZUg1VzRZdWZTTStSVGVhbHZWTXFZ?=
 =?utf-8?B?QmdlK0V1SDJwMFVLUHdTZ096QWZ1eGdsMzBwQ3ZIRVQ2QUhHbStYQT09?=
X-Exchange-RoutingPolicyChecked: DrFuqJCkQRDvptqGnM5iqo5wiJGbtJ9jwSfDiNje1AENfKtxBL82Slf1T6+VC8z6adIgW/ePxreprsOzypy9SwMnBsIkYknJn9+G6mkzLTfNpkFBzucoSbGwOnG46+fhp5bAp2vF/5Sc3UQJFVnkTWS4tcNa+2WvEx6gXxJt3sO2bjRHJb0b3ayABR/qZtNNHCZA8RfQJSNAjtjfiILsoc7w1k8J3qLhdhoFZ1m9E3fmRSHshWi6wfEN4B90Mg/hJHGFlswu+tPqxRh6OuhosMfbOGMDIBQU23+W0MXeC1HV2c+djbYBgxdhJ3NKwhMdj/lLfphseXUEJvF2gPg4Qw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b525155-c405-4b6e-f3a0-08defd43bd4d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 16:14:11.6589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDQzZ9hK7lzDh4CMnCaDL1+NojlarDIvOPCfQXyQ1/p5V1mM0eZyEbkw3xptjG+hU5h7A2zYhtMHd+I3UQMagw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8244
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


On 18-Aug-26 2:19 PM, Anatoly Burakov wrote:
> Small array of fixes and refactors for IXGBE IPsec implementation.
>
> Anatoly Burakov (6):
>    net/ixgbe: add key length check in IPsec
>    net/ixgbe: remove unnecessary dev pointer
>    net/ixgbe: harmonize return values in IPsec
>    net/ixgbe: get rid of unnecessary malloc in IPsec
>    net/ixgbe: fix missing HW write in IPsec
>    net/ixgbe: refactor IPsec code
>
>   drivers/net/intel/ixgbe/ixgbe_ipsec.c | 355 ++++++++++++--------------
>   drivers/net/intel/ixgbe/ixgbe_ipsec.h |   1 +
>   2 files changed, 161 insertions(+), 195 deletions(-)
Series-acked-by: Radu Nicolau <radu.nicolau@intel.com>
