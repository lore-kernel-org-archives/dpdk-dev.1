Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C27C5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 16:21:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22CB440285;
	Tue, 11 Aug 2026 18:21:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id C53D34026F
 for <dev@dpdk.org>; Tue, 11 Aug 2026 18:21:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786465302; x=1818001302;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sBvDR0/AvrGnByY5NUmxpMfuR5A466l32h6z/UofpGo=;
 b=W2sq/TfUBExF1ShKj37zX6NY2fGUAWphCzm/+MUTW4nIcm71KxQqnLn2
 XGiLU611wEg0UhzkyYLB8SdseGm992xsJY3SgEBEp20F6EeHB7oQruu1P
 cNBJWYFhAO9y+UB4TxQGXTIGUqTCUMzXRxaQpxgMkS7Zl2R6WbrcGNTpg
 fY3Pyk4VMfrEKbb689LDQlE/6nVNYJe4Ocya5FvAPqsrXz3VfOKfIzexY
 M8O859uIHyWJXkMwHw6/r2pTVXu9xJ3kR+Fx+31ppV8xBKz9Kd7fS54d0
 usIDJX6frULVPh/Qz3ive0+304IlkJp168xUaz6xCFEIRQEHsgN1TJ9S8 w==;
X-CSE-ConnectionGUID: XGgplkiFRcqPlc2OVptNhQ==
X-CSE-MsgGUID: MUdCISg2SpidXR4l1y522A==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="98518310"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="98518310"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 09:21:41 -0700
X-CSE-ConnectionGUID: mF47kY3qQ0KA1PY5WVwocQ==
X-CSE-MsgGUID: PfC7sL5zSbS+srgbErxgBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="267650728"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 09:21:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 09:21:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 09:21:40 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 09:21:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Igv+RsS4oesL4d9SAnOWgXGLQoi4cKNZI53wpXwgBMsdQnykXs+0uFFet+K94qwrF42LRrGP9upcF2doXz4k99vbKbo7oU70bopt53Ayjirm90xoVlCQLIgyu7EnNcNyUr4aKBMnUGUkVQ66YcKzQJhwx5pu6/D47NaiGJxUesvji0VO5CPjnroaqGJ23RWXTZw8IZae+9uClbMo08ewB6DM7w2qXGBB0ua/gnaPQ9llX13620qekGc6+YcG7pye9rg0aLR82aLYXcKBTKvvsH5Nqzgk5VvLb0PsVegsRQriNp1hW608vVX5ib5WEp6Y64uAQCvPCwm4YpF4TD2FNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7OO8p5yT+WAJ16lrVhJqsyQbhwbUCJwAHM2lVK2Gbg=;
 b=wCMA0OLbzg4xyyFYT6YiaYhCY0jUSUfOPZYMsDvSwsjGDj/IO+BlS0YYv/OlaNLsQCCtfqs5SX8Z7cutwQrzcb+wQtx6lMOabS81RROdauAlGoKTvCqsywcZt0f+DxOLtKOVEKjBpwPHarM/wSCY7d4GqiJ9QZoIchp8oiF3czu2sj0Gy1sWSWOmLfgro807RqxgNO9MvtJewohHJjVYz+T2R5m1qicXVocqt0IhKrpia3FaNdsVYnSyv37OBcYRJqdobVayTSBH8PW0cItBeGvEIsXNpZGqRCT7KpqmZ8Oe+EOCN7RgO4Qzv6RKybmylOh46JAEOVqYoKfoM19vtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 DM6PR11MB4626.namprd11.prod.outlook.com (2603:10b6:5:2a9::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.12; Tue, 11 Aug 2026 16:21:37 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 16:21:37 +0000
Message-ID: <475ae05d-aa41-4a2d-bb54-1912fd3aae2a@intel.com>
Date: Tue, 11 Aug 2026 17:21:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto/ipsec_mb: require minimum version 2.0 for IPsec MB
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Kai Ji <kai.ji@intel.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>
References: <20260811112636.4106950-1-radu.nicolau@intel.com>
 <20260811085300.66c89502@phoenix.local>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <20260811085300.66c89502@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P251CA0021.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::24) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|DM6PR11MB4626:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dbaab8b-1e0c-472e-cfe2-08def7c49dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zB3mErlkriT+HFbtqD5MRfKGgm0UMmtXwYmquYijOVLsWUe/UhBo11Lr44OgfU50YPyS2VfFOI2z38YVaSN6h52DT+PUilDcIMamQ75JDX2eL4wWMTbqBKAWzQLIudAxSU92bliZO+pDrz0F3NgcKxDHuq4Ays499A1ZSYacAae1Tj7neCYNbrbn4tTEGNu5X+Cw8FKRiSvG63ANM5Xz+2ugvBE5VZ1yuus3QwP4DGPwgNSmOuImF3GCN4oziU4mv60lM3y+9Pyf//LFQ4vxYQGZ7K3fad4C2Fx9Z5oXoH8CWu/mOUqugSPepGiClhlWUH+8flCPUUlKtiTIea1hl2ARxWa8u1RQSi6M4bJC9ypPrPKkpEy7IhGQRYIQzQ2Rc1rvECQJZshMjoEgvX7kc9OPxVuepcyoFmgfVgmReOVE5U+SinlYkNiy1RlvjUzO847FGsHon2It5v/0XV4Vi1CB6TWIYFrNTh0KO5LotbtcjpNEyaup0uvgx7W14QKGdRw4psSiui0e9otj40eN3pUdg+O5LghajQ6FKWSDipIqDg3BseYBiEPHmXAG6EyXtvXOn83V6p3bXNUZMP01q500DTDzdYkoQ0/e8QtK1+Ij7m6Ob0Xgdk3WTrnwo/TvM4xA7rjYK4iztM0d6YILC1EIfrFMUr2U4yE8LNBesx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c21VWFlnRXI0VXFGYVNqRmRLQlNMLzdyS21EemFNTTFTM0tVZDN6TENxSWV2?=
 =?utf-8?B?anNBcnpSSU9hYzhueHlhWlVvMTJnb2JmcU1BSThiUTYzYWdjamc0d25CdStZ?=
 =?utf-8?B?a2R2aUg3NVc4N0FLcXkvTStlTXJzZHFkUjZnTWdRU0NBWTlvS2VtSEtOVHlZ?=
 =?utf-8?B?RmlPb1FKL3Vha3pHWXBLbXZ2VktGWlcxcWM5cm1NSktzcVRiL0JDLzdDQ2Vv?=
 =?utf-8?B?d2tQUUY5a2Z5OVdoTnZta2RmTDhzODNXeTYrODRkVE9JOFliMTE1VmxmczFh?=
 =?utf-8?B?N1dZY0pqMWptMm1pc1N6dHR0VHhnTnNOT1ZKQWw1a2pCbk5tbXhVSW9kWUxn?=
 =?utf-8?B?NkwwR29hSWhZVElQMnBrLy91bzZVWVk5VTlyZDVoR21qV3YwSEVrdUhYNjNC?=
 =?utf-8?B?czRQQmxHUThBaitabTRyQzkvRlBsS2hVZEhZQSszeWsvRnloRTBKVC9KeERh?=
 =?utf-8?B?Q09rVUdvbVVsditrdXRybXhsc2tHV0sxclc1YVdXM3ZNNEYrQWNlS3paSFdR?=
 =?utf-8?B?dUFSZmU1SzFycjA2b0Z1cktmdlBCdDdoUzFIZDdqZXlEU0FMUitacVFBM0k0?=
 =?utf-8?B?eHFwOTJVNHdQVmJ2OTlTMElpdFFodjlqRnFtdTlScmZwa1ZyczJoQk02OWRs?=
 =?utf-8?B?dVVBVGZCb2FEajJHbnQzbTk4MnBVQklMWTg1bTBRL1BwZ2JvbjhLa1U1T1BC?=
 =?utf-8?B?L2JkekN0Q3R5Y2o1UXcrb1I5ODBSWExUTjY0Q010L3Z3REREd2tQWVpMNjg5?=
 =?utf-8?B?VHNYL0V5NDV2RWk0RDNMYjVSWmR0bm9JeHdQUnF2b3NwMFduOHlLbTFxTTdU?=
 =?utf-8?B?ZDRMZDVTdk5jclQ4djgzNkhUWXdDcXhJQTcyOW9obTRZWE56aFUxeUFMeEMw?=
 =?utf-8?B?RFlWTTVIRGVZZ0xqZnlrOWxCYXBrOFQxOGZPRGMxS1Y2bzhQU1lkU2pBelFD?=
 =?utf-8?B?SXgrQ2hleGZwUklyOFYvUzVWcFpXakhRY2VobXBxTXJ2SFU4bmo5ZEEzL3lI?=
 =?utf-8?B?TDJBc1UzUVpKMk5ZbldMRSs3Z0lUOG1lWjYrVFgvdkg5cFpVYzNBRzh4cHhh?=
 =?utf-8?B?YUJEVnZZaTdLRFZXWmVLbjMvcDJvZmdFSTZtK3RHdE5wL3FnSG90b2Rva2ZU?=
 =?utf-8?B?WVNwd3dCSkRINlNtaFA3TWJKUTlsc2ttZXFuMDlWRUZEUlJhUTlNOUtTNXFM?=
 =?utf-8?B?Ry9ucm5mRlJneGFrM2JFVDlzN0tpQmZRb0hreS9zcGw0bS9vYkdlcE5VUXBC?=
 =?utf-8?B?dEpJMG9hZE5zUE14c2l0Z2RlT096R0ViT1JxNnFnSjcvVDZyclZ5MjhISlRO?=
 =?utf-8?B?bGd6TG5lYzQ1Mm9TWERKbGpKMkx4NGovZGVkZ01rRncvL043TTU4UWJPMUsw?=
 =?utf-8?B?UmV6dDJ4YkxZb2xvUGxuejNETG4zV1VvaXQ3eWNWVjM0MWl0QjBnNkVzY01O?=
 =?utf-8?B?OTdlS1BmdlAvbERpaUtEem5XbHJwaVNic2w1QWJEeWFEd1BjcjVWbWJCUDNX?=
 =?utf-8?B?S2JNNHVRLzdSd210SGR3aW1WMUw4UjQwTGlXNUJoWDdyUVg4Z00vMWphOXlH?=
 =?utf-8?B?UCtDTzkzWjVTaktiYThOcDJpM0c4eWQzbkU4L3ByTitlZjZpVmRaMnFpT08w?=
 =?utf-8?B?eWh0RjRnN29Yakt6Nk5XYjRaaElXMjFRWGY2eWE1RFkxbkx4bC82Z01helFZ?=
 =?utf-8?B?UFFETzV6ZjZqR0R4Mk1RNC9odVBMUGM2aUdLS0tJZ2lrTzlGUlQrUUQ0TlBN?=
 =?utf-8?B?VGg2S2F3Y09IZ2NXUXBFdTlJanZCakRFSWdvQ0lEeGhwTzBpMmw5eU5VSkRO?=
 =?utf-8?B?aTJKSFRzODlKWWFzUDl4eUpsVG5DOGVBclRiMzIvaGpISlRFVjJab2owRkdk?=
 =?utf-8?B?dExhY2hVYVZSK1Iyak9ubGhWdG10WXV0ZGdEOUtVc1BzQTdQUjd0YlN5aXZa?=
 =?utf-8?B?Y2VpVGNyWEJkcFNWU216SXhYVnBpL21DRnpDTlRKaTUwYldCdWhPRTBmaHpU?=
 =?utf-8?B?RXE1N0FxUFdxSlozaXJuTVJnMDVjL05OczVFMWx1SXdCOTNwaE56UkswZE5p?=
 =?utf-8?B?RFZXTlMxd3VHQTBMZ2VPQURsTnZtcm5LandaaEp5ZzY3SEpSZDUrRFpmdGIv?=
 =?utf-8?B?ak01UzlhRHZWeFV2Q1BQc3U0K096VHpRUTUveFhzOUIvdXd6VWpDanBaaTJn?=
 =?utf-8?B?S09GdDNlSUh1L2RxKzJVb3J0SmlsRkRsMW1QYkV0TWY1eVhQN2p3K1poSDBr?=
 =?utf-8?B?QjdCZUtJTkVmelpRQVlKbFd6dHBWSHBDNmhCTUpUWEpoR0JaOXlvTFo2Qk5T?=
 =?utf-8?B?VS9EM2tzeE9YY2wwNjBsNFBhZGUwQlk0b3VwcWRacnFwL3FsTjJidz09?=
X-Exchange-RoutingPolicyChecked: PgK/xM/juCNsONDuTK+oXpF/aySxKaaqNGLm80nHamtPYyr/nZ5OH70r6YtzcZpc/ygcFwaJXC86DnwFuoZlw6iBoJ3UYYk4ykERZIHASZ3LdcmCfzAgEFy1dW6R7iLyfgDHW/x3esLlOPo+E5bqCIFrozT5WQL+JNoN4cxODhNYhdSTtdPIVrJxw6sa/zVSXVuAtnQvhQwSnsc6DdDGE5x43xPc2zbRli0lz/vbjbxt1LqZhZcNcDndOt4LROfb0o7KzNRRqaDovC4ZTEmMWRFczMgJeoaYzVT1EsSnxOGHKdInK9gbEbJfVZO4q7OdR8zsgn18zniAKHp0Nr6Qrw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbaab8b-1e0c-472e-cfe2-08def7c49dad
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 16:21:36.9853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cl2/qlkIcBLS97stsafCUnSMnPPwCM9K/t+NFTw0zIy3SrTDlrBUe+N2DqCRWC9GfFGSVIwKpo4UYTMjFCEDDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4626
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


On 11-Aug-26 4:53 PM, Stephen Hemminger wrote:
> On Tue, 11 Aug 2026 11:26:35 +0000
> Radu Nicolau <radu.nicolau@intel.com> wrote:
>
>> Increase the minimum required IPsec MB library version to 2.0
>> As a consequence, clean up the aesni_mb PMD code.
>>
>> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
>> ---
> What happens if user has out of date library?
> Is it detected at build config time with reasonable warning?

At config time the PMDs will be disabled with a warning explaining the 
reason: "IPSec_MB version >= 2.0.0 is required, found version 1.5.0".

> What was release date?
> Debian changelog says 2.0 was introduced in 18 Sep 2024
> and is Debian stable (trixie).

According to 
https://github.com/intel/intel-ipsec-mb/releases#release-v2.0 it's 
November 2024

