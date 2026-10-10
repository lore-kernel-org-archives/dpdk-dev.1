Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE570CA9EC0
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:38:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EED9F400D7;
	Sat, 10 Oct 2026 20:38:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id C4C684026D
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:38:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791657499; x=1823193499;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=72DayA7CEhR7s8LN2P9n6e9nNnYQmhcjdbzFB7VGpfE=;
 b=IdDR97mwaFt8yzYMp8oi1P5ykbp/6gwSaNHY8NnCWcX0JhiUG+YtVCho
 PGT5tcnLnTUL6wVQg/ADbAt3Zo05SAn4KInkpCj9PZgIUy5ZKfwXxzLc/
 LK97voi0RtLjnH0R/uZnLLd2NFORL2EE6Wk8utl5pn7NaHgqE+19qa3Wm
 dr/NRgptjT0TT2A2fOrk03PL7CwaahENXdPm/MX4xTQ50U/rSnJLmnbw8
 0f4RM1WJ1b4pzKUvGpJSzLkzENJ7FoifJvf9ivqv96NX1CKqDbGs80NI7
 GgGWrvNGe/XjjC9rjN3tzhSXJKdJsh+y6FbiALMafePbxXLInxgfRzL0a w==;
X-CSE-ConnectionGUID: jrGKwUsQQaizRRXFLtfBUw==
X-CSE-MsgGUID: du4PU/uxREKMbeXzicVxFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="434990"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="434990"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:38:18 -0700
X-CSE-ConnectionGUID: yuDU3WY2QkKofan+OISaPA==
X-CSE-MsgGUID: EkgmPGEzQM+O4zkbJG3j9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="877752"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:38:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:38:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:38:17 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.70)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:38:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wT4WDImEl13W8kG3rK4j0E9EAaLPcFOZVdQT+OGmMeKandkuQZkmtEdxPSkUBOa2GmE2xpEj1qp4lxc98rHj+WTU9t21ItEf+6vjQaQP+hftzuy0flxUl/vi5Q9tKtxVFDulKaPeWshZbPvb1+C7qlDu+9HpxlZ1uK5QekwCsyVN7dTN8U52ikWNul0zmzrzl8ucxN6hpSooDgNzckVd3rCM8mXPRtuN0GCbKAdJ2wxmBVsJQOQdsI3R9ULOAW5+/mh+btD4+XVMu4fc76Vabpj+M1mfa3nuwSD1Wm2UrM3kE25G0USfDlzKmqbwkINJsQrufDBTKPrlHE+Zq9RT9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cMZuTeq7HHOY8nYCuvfGc/Lk1W2+6PbAEvwOvzcdfs=;
 b=RlWfWQqw6mEjwfXSw6G4XuYGoCYWprNWcC4Jmp9cj1IJ3I9Cnkde+jhMS0WRovjsIJ8CivbLDhwuAER66Oi8mRfYxk71oxX33l4G7pVo1GHvaPIEAaAO33ueVEAnJckECu61dlDPIuRBXe59CClO0Ig5OGGZMp8val9G2rArkSp6yyJv0ubt/KYQ7cBLtWBSwvqJWb6ocaIv+hnO+bbpf4EYlPuQ29jJYaiDRxHvxlJ7OF7X63YLg6AjMUFAVdVXZ6huV9bPzzS6Ytz92RJIdI4H/l6/99E80GzAS/AxfYon1nWYte9vXWSrg/JbFSu52LI0yQ1NT6lhxFeeUk9xbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA2PR11MB5049.namprd11.prod.outlook.com (2603:10b6:806:11b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Sat, 10 Oct
 2026 18:38:09 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:38:09 +0000
Message-ID: <194f1720-dfdb-47d1-a4db-866410bedffd@intel.com>
Date: Sat, 10 Oct 2026 19:38:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/25] net/ixgbe: reimplement security parser
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <6dc188bc6bbc426ab6afbec8c22dc8fa6af18828.1791543155.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <6dc188bc6bbc426ab6afbec8c22dc8fa6af18828.1791543155.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0007.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::12) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SA2PR11MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: ec46507e-4eed-4862-bd43-08df26fda1c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 3LBlAchKsovnP/4NUq+RcxC/I3Sm0s0C1EjDZ2UjPZivAtwIzWC+2l2XFN0f3ir0IP+WCMuYKe5pzCPNe3tWM3WhPpa3P8JxJtpSVGq2xAMCWCVNfumgMKJcFYHYWBMzfySGXvQkNYrd3cdHyLXIZGDwXcknGghRxaEUBGFeMa1KOQHzf+RnxS4XSAooEAJ1pIMczFIwe19aCZtmT8w7IHK2rjhj0O2VZJRpOvqqiW0qPpc68J4H3+HbDUWlrFmirjexDxYI7d6KxCCZMJfTj7RUh9awEkTA22UKN1piHBkhBjfZChozLrJzcSRRze/e636b71yybiSg8HmnGU4MDF6rdbbFoZIjpt3e5qlOUPcJL6HChn9Y9MTkMmL0TtiqJ0Lx7bkvUmN/OHdyi86w0yxrp4emB5yid+T4OSQ+X+DKuqnRElqzqkf0lQXYO2LWNM6wewQ9Hcyvi6KyIVE2/23suUPTMqyRlc/EY0VqD0tueYajEFUW4NPMOBflQNl6oARb9nPHw+kcTlMUt5knxteX+HWVoDb0/JG6vmR7FAmAyJ+ehZkSiFPmmW8055cQkBouBKtmfgOCw3gU3B25kWFblLZhqBB/qP4GFL0YZsUKvv+xOqvtj1eFsFLUx/uikuq1QeTQ96ZkLEFn/JlqwSCeyNzYIfEWmxvPbuidPg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDJnRXdyREZ5V2UwQ2NnUXdha2t2T2xpODdUUEpsM0VaOTAyVGVVaDVYeXFq?=
 =?utf-8?B?b3N0Tno2bVF6eVY4M05mcndHWG5EbXkxZFkyekVRZmxBTkZJekNZMEZsYUh2?=
 =?utf-8?B?cjFWQ2ZGTGtjaVY2OXl6WThTNS9WV1VUWVIvMkxIdEVqd1dMZDZrTmRsY1Ry?=
 =?utf-8?B?enlGWlZxcXk1ZHBiR2R1Ri9OQ3BkM3hqVzNCSnFGVnpESThTdldsS3ovdDN2?=
 =?utf-8?B?c0JqaUxtNXFaRXZ6L3dZZHJXNGRVbE5MT2pyY09MN1cyQVZFY20weGRKeDZY?=
 =?utf-8?B?VGNkQzZiZ2RWcmFUdms3TWlxaUxUaU96QTlLTUs2d0tFOXlrcFJNUjgyS0FF?=
 =?utf-8?B?UFAwRElVclFnbldCVkVOaHFTQlBHQllQYW1LNFpKNW9OdmRmZ2h0OHFyVWFR?=
 =?utf-8?B?VVJ2eVJTdUFNbEYvUHFYUkFhYUFMZXJsTHgzb1NNY0k3QUdESmV0anVHbmdl?=
 =?utf-8?B?aTJjNWZrT2tlV0UzL0o2ODV1UXloZ1ZoYjhyVFpyT2MyU2xFSHk4Y200UTRN?=
 =?utf-8?B?N2oreFpNVjhvNnBYUW5lQnRQb2tBRWxPbWZtN0dFUDdsY3l5c2VjNmpaUUMz?=
 =?utf-8?B?UWJFSWRZS2Q1OENnbGNpOG1hdG9PeWJKV0tQQ08rSlRhTldPemdHZWkyd1pT?=
 =?utf-8?B?aWN4bVkzWDZ1Mm5QNzFFWlBjakNkYkpwZDg5RU5SUTh1cytDY21WQlBoeHRP?=
 =?utf-8?B?c0ozemFhSkdpSzJOekVIdkpaaVZyblB3alZoQTJMbFRyUURCTEgxMDh0Z0cx?=
 =?utf-8?B?eVlUU0loVHRZekF6eFBzZEo0dmk3UHpGWVgvdXEraE9sdEhlMjFCMUw0dEVY?=
 =?utf-8?B?anNmSUZFakJNYU5adjl2cWcxUE5mVmd5QVY5alBHcWtqV0VLb1JQL2NZVlFQ?=
 =?utf-8?B?ZmZORjlGQTZLdmtRaHBmTXdUMHA3THYzbzArcHpqcmh1YXJOMkxvZmNvUllJ?=
 =?utf-8?B?TFVjUjdaTW42QkpHalN0Zk5CNkJUUFVaaTBpbk91U09UT3NJT1VKMHFhbDFI?=
 =?utf-8?B?cG15QUgweWVOUnhPbXpTdlFoRW5JbUpyRkMzWjN6aDh2U3BCbVNGejhnOGNH?=
 =?utf-8?B?amNMWEphaEoxK2VIMnk5RGowc3N1ZkUvck1HU3Z0dXZCSDlWY0dGMHpxWTBs?=
 =?utf-8?B?aFU1Z3Rla2JtbHJvTFpVYU1SRG9Dd0ZLb1I1YUVmMHZRckNFSmZ1NktyMHF1?=
 =?utf-8?B?UXBaaGw1WHhqOCtFeCtaeDdPYmF1S1h5dlcrSEVtc1V0OEF0ckZwcGlic1Zh?=
 =?utf-8?B?ODd4cmVNUzhTcUFXNmt5SVVCOUdXMjRCU0RURXlzbGc2aGdDL3I4VU10cUJZ?=
 =?utf-8?B?cllCZlZEekFUUnQ3ckdtc1JxTEQ2YTJWTnNkSit3c3ZJVGlXQmNjTUtQM3l6?=
 =?utf-8?B?MjJJYTdrbWpCR1RvdU8yRVFuSFNrTzNoeUJ4YnAxeHhPN3hpZ2w1SGtKQUpZ?=
 =?utf-8?B?bkxTRU1zWXAzM1ZuaCtDUVc0bHBEWVk1NGVwcnJGMzRwRUhGOUt5clZWTGlJ?=
 =?utf-8?B?M3c0ZUVXOVE5MVlWSmNhVm5FZWJmakZ3K255Vlp1RURqVHNWY05raXZVUUxv?=
 =?utf-8?B?MHVzcU9EWVZHK2EyeE1RMUZtNXNnaWpLV2d6ZTc4R3BFMGlUYVRmR1RiMmNl?=
 =?utf-8?B?SVJYUGFmZUJsQVVGNnR2ZG5jZmk3OTlUN1AvWmtCTDlvek5TVFdDMWFQSXlN?=
 =?utf-8?B?WjBRc3J3VlZJRVNVelBvUU1qNWYvelBUcGtDQ1JYU0tHcFpZcXd1YnN0VnUx?=
 =?utf-8?B?eGRRV2xrZlZES0RhMytWUzVJMnluRDE2ZndUTDFYNm14VTN6RmI3SUdNdVpm?=
 =?utf-8?B?QmM4VlJwandvcWR4aVVMcGp6OFJIRmJmaDV5SE1vVms0SVluakFVT2JVUTB0?=
 =?utf-8?B?d2RzbHlIWi9pUnA1RFNOYm1ERTJjM0hDaUExVSt3NksvaFhGSUpaNU9Nd1k3?=
 =?utf-8?B?VnlQbUJRajBEY0ZEZXU4M3NqMmFLd2VCRnJGU1ZZK0gvUHJReUxxQWtKUkJy?=
 =?utf-8?B?VWF3T2Y4S0VQeFZYaWx2d1JBcnhtQ2c3V2EyL2RVaFBXTHFSc296aEgxWFZk?=
 =?utf-8?B?U3A4UDQ2L3JjUVl2RVhVeVhMbnlXOWZ5bDdRMEtIUjVRTE5halZrWGxzSXZa?=
 =?utf-8?B?VmxoWUJiUTdrYkh5SnlBYU11bUVVc0pGSHM3RUV3Y0o1Qm9XNWJNMGdsYlIw?=
 =?utf-8?B?YU5iZVJ0RHhPK3NQQm1LZktqcDR6cDBXV1ZkaFhKYjZISWhyNXlkTFNRZWV5?=
 =?utf-8?B?KzM5WXAya1J0MWltM05xZXc0bklNNGJJSjRCS0pSQ0p0YXh3V1RhMDZ0RXZN?=
 =?utf-8?B?Tmt4b3BOQThneEtrOStMQkJNZW8yOWc1UVArdGhPMXkyR2J4U0wzeU1Oa2JM?=
 =?utf-8?Q?QS3pC01o2fIcWhKU=3D?=
X-Exchange-RoutingPolicyChecked: ocPdO0dBfUWmkrjElUTnbWcjwLEVkzbcVrNPo7cmLSQQNdeijYpAwGfp3wdVD3SvCxMCmbNQYG4dgz+K8Ada4GT6vzw4Lj2MREz0M2W5Xry0xYHCnoQwFUUYo4ZlW32YD9CUahrWlAjkAZIDYbgaEB/iMgUejQ05BCvF+X6BWx1hVAn+nRhL356J/IIB1Q+vH6+wrx6TU7WmcZ6gYJWYJ0OFjpG73bkHS9YZkn/DIXrPx/3VcZAXUXwwEtTh34EZt40+x23UZJiWaUbeZt06s/KltQiaSV/E1G4YGZff9cfNkj5XQhiVhi9t4uUPsW8xrgQWmLf6qtDQrWhr0JHwqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ec46507e-4eed-4862-bd43-08df26fda1c4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:38:09.4016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vt02ZFOkmOmvqCQrEOtEDrWkzHc6bzx2VOKPsaLPpKvXCleT0kjsih2BviBD2p/l/vjZvgapnYuFjaCF7bRbcaSx4mRZXOs5Q56OdeJMKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5049
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

Hi Anatoly,
one comment inline

On 10/9/2026 11:59 AM, Anatoly Burakov wrote:
> Use the new flow graph API and common flow engine infrastructure to
> implement flow parser for security filter. As a result, flow item checks
> have become more stringent:
>
> - Mask is now explicitly validated to not have unsupported items in it,
>    when previously they were ignored
> - Mask is also validated to mask src/dst addresses, as otherwise it is
>    inconsistent with rte_flow API
> - The security engine was only looking for IPv4/IPv6 pattern items and
>    completely ignored both prefix and suffix. This logic has been replaced
>    by allowing [ETH]/IP/[UDP|ESP] patterns, as is used in ipsec-gw app
>
> Previously, security parser was a special case, now it is a first class
> citizen. All decryption SA tracking has been moved into the engine, as the
> engine is now the authoritative source of new Rx flows and the state of
> the Rx SA table (the Tx SA table is still up to IPsec code to manage).
>
> Because IPsec code does not manage the Rx SA table now, a synchronization
> mechanism is needed to prevent IPsec code from deallocating a security
> session when it is still referenced by security flows, so the security
> session is now atomically refcounted. For Tx, the refcount is effectively
> a noop, whereas for Rx it is now managed by rte_flow security engine.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
<snip>
>   static inline void
>   ixgbe_crypto_write_rx_ip(struct ixgbe_hw *hw, uint32_t idx,
>   		const struct ipaddr *ip, bool enable)
> @@ -137,195 +131,165 @@ ixgbe_crypto_clear_ipsec_tables(struct rte_eth_dev *dev)
>   		ixgbe_crypto_write_tx_key(hw, i, key, 0, false);
>   	}
>   
> -	memset(priv->rx_ip_tbl, 0, sizeof(priv->rx_ip_tbl));
> -	memset(priv->rx_sa_tbl, 0, sizeof(priv->rx_sa_tbl));
> -	memset(priv->tx_sa_tbl, 0, sizeof(priv->tx_sa_tbl));
> +	*priv->tx_sa_tbl = (struct ixgbe_crypto_tx_sa_table){0};
tx_sa_tbl is an array of 1024 elements. Do we really need to cleanup 
only the first one?
> +}
> +
<snip>

-- 
Regards,
Vladimir

