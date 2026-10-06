Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A564CA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 14:30:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F0EE40262;
	Tue,  6 Oct 2026 16:30:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 8ACF34025A
 for <dev@dpdk.org>; Tue,  6 Oct 2026 16:30:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791297012; x=1822833012;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=28r3YvyjHL9gPhOUENEvfz1BfPQwyMVQV+YBY6D+Djs=;
 b=ZOIpjKevubkak9mQ8AjQNV3+2taTKBKblqEX/9O/sKLzoaNIVnVStwu3
 Psu9m1zXMhFW4ocpr0uWEE8QLIekY1iscIlA1HPjmjxJ8jGCP3yhq5Ali
 k5TFo7imdomS8N1mmIHyws7ddQa5IRaw7drKXzNHVpaWNaQWx5bVV2+l5
 dcl+t1ZTjY+9HlHDfMw8ICoDIlR9kVnzYyI3g/BXEZAbOpugqyS6PfYh0
 LJCZuu7tFE46z7CroshBwZ6d/1HjNrkVdB+ZDcs5dcJ436+zYPc+BHAiH
 TQks8+129kTLvUHNP1Xm85FuSvByDhaU5svAiwAWF9Xu8MXn1xEC6bAAt w==;
X-CSE-ConnectionGUID: Al2YvutdReeMwuHYiL7O/g==
X-CSE-MsgGUID: IZYcP39GSCqGqxbvk6j5Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="40614"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="40614"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:30:11 -0700
X-CSE-ConnectionGUID: nqzIJHnMS2aCOC1oWg8g0Q==
X-CSE-MsgGUID: D1MVfJMBQBCbXDqYViuJhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="273534776"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:30:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 07:30:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 07:30:10 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 07:30:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVfFKE9ne37R7JdvdZKfdv0G6ygFGYLhk5xYA1FEwY6JiONOlV3skyV2EDUPSB5eDNwOf9ercu5MomybFcGZoyg5qsX+XpoIYZrjhwqqcxcvtXCY2InImgjGzNYDtlPmt4NFTN/DxIOgDImQ+JYzxkRDfkjPajM/yz+zFpZN/2cbFYEzFy4O6WRqj/ZGcqMeJJC8wqetuNZn88sbY3JGri/wRNFQ0dk1hfsOeUfqmXbOnS9SIcbEOghMR5kU+wzpJQEWsblw9f76O4VBk2NpZ48z6fPJwvvkRwxgGaXZ4jpyxcCtQbP1QFwkPW3YgAkxWcQn9eTt6pM2j3BS0t1iHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xppjs2WE9WbsGM8X6DhoaDroq9rNZTuZF1zkWQ/OYlk=;
 b=LeHB2N4Jejv0XWVh7prsckYGTxI+47XS0Jjg7cTB6hlBaFMLJguU7MHZur1CAXBLbIxwktPZoWamMCeNAVbrrvTfZlXrznYSMeTQDAzhrS/nSUqFMH9vpvQxIwNZFQOpWGYzHT11gostQ5w/NcitoRZdYOja17Mvxgsvh1Tz/8AUqe5vwT05MLHtrrTgFDnbL7Anic8I0G9nOAm9AUGGqppZVOqzs04rsiGwLjVmvuvYAQsuw+DKrGrDau9PysLErYvuo9/eKZIXQbsD1tUoQrZQ23mXlNQzS6muTU119S+F3bPsfZKHqcndrRlSYUfBE9T7x+JQ/+PpeJSwi5GRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH9PR11MB9903.namprd11.prod.outlook.com (2603:10b6:610:341::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 14:30:05 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 14:30:05 +0000
Message-ID: <86d76bd9-0b96-4304-b8e4-a70814ab7144@intel.com>
Date: Tue, 6 Oct 2026 16:30:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ice: use macros to get field values
To: Omar Munchaev <omarmunchaev@gmail.com>, <dev@dpdk.org>
CC: Omar Munchaev <omar.munchaev@gmail.com>, Bruce Richardson
 <bruce.richardson@intel.com>
References: <20260928172759.3369704-1-omar.munchaev@gmail.com>
 <20260928172759.3369704-2-omar.munchaev@gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260928172759.3369704-2-omar.munchaev@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0142.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::22) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH9PR11MB9903:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed8534d-46e1-40ab-b5b3-08df23b65093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|4143699003|11063799006|5023799004|18002099003|22082099003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: zw6JYcAkoor9V3jJxeJz6Ef/u/udrQERE9ZcvarWqJ1DJLBwz8M1N1D478Ass/zmwV/UeVp7Azhy8s41yDm3oirIRpNwB4noHGMADvlFjlYQBTT55YyJ9ChvhLJW850CuiDzp03P9ql75ps2/9WtfS18lUwVtuEShTp/KUgc2fSAqXSQT9uYKM6fjO1XPhraJiO3pCSL1nQGFmPUJQwwlGy9+acRu0zoPkdWUjYhPaUHXGgivreRYhpwCMurD3hKl1ICMVGsarh2OfV1UlacrVt0HDCSpZbHdBtFmjtPy+zMvBaK0bN2T3rf/OEdMUJDhdyYRS24b3DBLx8TCnaLd7pDtDG1R8RcbzhyvUf1t5Vw7qeYPI8ckhp165JN4NuvH6MpVItlLH5ee3O8MPp4A7V4rew0Fh5Md0U8QJGAQDhbz5/jRofNOVpgZgVozG5w+c4N4+ppVozY1zbPPTpD69eCyWhzsgRF/J3IX5BQFiwB+z9eJ4w+q84ZBC128vi/Gr3rwFdZH9TnaPf0/oeQFCPiXsJhf6t3CvOUh5OnGnK5Htsg+JuSUrLW+kDhsCONiKn78h2rK/puIDdTMrMGPwqQ7KeO3Diz3lIJ2UyZAX86KRVbVGKtdpeBA497rzaJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(11063799006)(5023799004)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW5PNEovNS81ZHYxU2pRL2pOSnhjc0RxU29iQlJEQXBrVFpydVNJYjNMUG9t?=
 =?utf-8?B?WnYvUUk4RnNHOWM5Y2s5d2FUQnBqWnlEcXlnU2ExQ2Y0b1pFOXBLQlBuamdX?=
 =?utf-8?B?VHJzalQyeTMzd3VuQnZyWmFxaTFKSXFOd295UGRKWVFSaG15WU5oUmlBME5E?=
 =?utf-8?B?S2dBeURvYlRyMUN6UXAvZlFGL3hpV3hETkNnZnl3TWNSVG9hamZ3c2p1aSto?=
 =?utf-8?B?TVQ0dzF2S3pvMDY0ejhndFdrR0s5b0xsNmE3UjJCNGYyU1M2UEU4ZE1ZV1M4?=
 =?utf-8?B?U1RoS2cwbnFKanh2WmlUbGc2anp1WmYrOUQrSWhhL09HTzhXS2V2T0h2ZFZL?=
 =?utf-8?B?V2RGeUErbVk2a2hSM0tqQ29aZ3hFdzFVRHdrMlo0a0FKWUUzWGFSQ090aWNi?=
 =?utf-8?B?bTZVTTZVWUFWaG44Q1dlSEZoYnZWN3JzanRHb2x6eHVhMGtuMXRRbUJmUnNM?=
 =?utf-8?B?eUZ1c0V1aXJoUTVJYkxucHh3S1Ftck5tYzc4ZHBaZVNEaGoyNFRUY3NON2Zy?=
 =?utf-8?B?cTVEeDRTNEt3ODZYTHNHMlVVTmVpS1laR2M0Q2JQK3ptS1VWblNySnM5TWtl?=
 =?utf-8?B?OW1leHlTQng0bFoxSkdHRFRRdWdnMmJTS0hTWGJ2WHkwZHNtS1hYQWUyd09i?=
 =?utf-8?B?cVVpb2hYdFR6cXh3NnFHa3VpeEN4OGhQOTRoNmJ6OFdOMXorc3hTdG93VEE3?=
 =?utf-8?B?cXYvQVlXeDZ0SnRUQnJ6Yi8rWmRxbHVFYjZUbjlBSWlrTzFSb3JXY3B1dmFi?=
 =?utf-8?B?K2JBTVovbzUxb092M0JJNDlpOEdmVVl5L2F2cHlrNHBLZGdFbVA0a05yU1FL?=
 =?utf-8?B?ZUZHQVNaaS9hWWsrYmFMTDNFd05XSkg2MVBaRGJFdG53SHlaU2N3TUlHRzVy?=
 =?utf-8?B?M0JxcVhXU1c3cmZpTUdRcXI0d2RKU3duYmoxMzVDL3hnQTdJYUhweHJ4MmNF?=
 =?utf-8?B?a1lCTm96Y3ZoMGkyMGdQTERYOGtwTlpkKzNtcEVuY2h5djZxaFROcTVaUVRt?=
 =?utf-8?B?Q1Jjemtrb2F1WlMrYk5FV25qT1NWdDBwbi95TWFWYWF1UVUySFB2NWRhSERz?=
 =?utf-8?B?M3ZPTGcxbWp6SXVWN3ArcTJqaEttZFhHNHcxS2s2WTZjSHNCQ3lnNG4zazk4?=
 =?utf-8?B?L2RzV2dCWjBaOEIyWEZwYnpkaU9pZEU5Y3NzNzJBbFl1SzRBb0pmemdnVWhv?=
 =?utf-8?B?MEtHRnppMldPUjFkUnNXQThQdmFreXYvMlpRZyt6RDZXbmloRDJjTmtqMmIx?=
 =?utf-8?B?dmorUWE0SlNDSmk5cUVjanJnYUZHb3d3SVRtZ0ZmQ0RiWnhBWjIxRE9yb1gx?=
 =?utf-8?B?Sy9rbzFxdXRJMGlObXhFeUMxNUxIWEpIK1p1NHJMazBiUHdkYkNsc1B0dW05?=
 =?utf-8?B?bDNUY05UZHEzdStSUWpQblpJZkJ2QlZRZERndFgwYTgxSmlSZVJUQlVxL0FS?=
 =?utf-8?B?eTdkOTVGaS8xS2xNdVlTNWtBbW1OY2RFNW9LbitwTXBPejBDNUhGZzhsaUhz?=
 =?utf-8?B?UTZKS1dxaTgvRHBkOGdycjRraS9DUDdHT0NpL3c1NTB5cDViZFBYZmNjRC8z?=
 =?utf-8?B?OUlPdDMrcEZTemdpL2dBRzc1bHpjZHhTQnFMMFUxY09mQXRjZ1RRa3FKS3R6?=
 =?utf-8?B?bUw5YmoybDJJRU9YVmc4TEpmMkorVEV6TTVLMDE0S09RenV2c21FL21xdEdm?=
 =?utf-8?B?MzVGTnRtcnZnTkF2YU1zLzlydE5QSUQvN3U5TUtybVp3OXNsV2k1eTVXa3Zx?=
 =?utf-8?B?TWRIZnlLOUhxQjR0elE3MUtMcVlrMTNNQVpHek5WRWN1NXRtaUM0Z2lOakdq?=
 =?utf-8?B?aThKV1FHWCtFMTJXQStSd3BZdmxYRUZBUExJRmxiaHpZS3lRc0xZaE51bzBM?=
 =?utf-8?B?WlhEZDNESWxKcXZXWUdrN0pPWlpkeU41a1lmSlg2Z2pMT3VVM2sxQldKOGw0?=
 =?utf-8?B?dnpabU56TGFWK21Oay9HVGdvQ0xBQ1pzZ0hpQTgrdzdSN2w4SnFFUDROdVps?=
 =?utf-8?B?UzA4ZXFDZjlFY29KRVVHZzQvWkhYci9NWlB4bzNPQU01NDBhRWhuVlZFSkhS?=
 =?utf-8?B?Tm14Vm4yUHpML2llRFFxZERLTEpIZG1VWHRzT0NjL0RwZk1Fb2JNbkF2VjRz?=
 =?utf-8?B?ZUhCN1hpZWJ0WnJKY240NHBnV2pTSTYvanRObHFub1JQM1ZrQ2xUZjdJUkNh?=
 =?utf-8?B?dzNWclRHOEtZVm13anZmbTI3UHdwNE5UOTVOUkFNZG1MT08zelFESUo1UTFq?=
 =?utf-8?B?cFVxcFR3TWRUTG1sN1U0VkxtVmdxMVhTamVGVDVNcUFxaVRrZ2NZUFpMRFNW?=
 =?utf-8?B?azZiQWVQVVZlanhxTTNiNmcvdEk1SWZ6VEdadStYUjFOd3h4NjZra0owb0xC?=
 =?utf-8?Q?EVnjO28381VGU9m4=3D?=
X-Exchange-RoutingPolicyChecked: YK189x1RKyoIcFQOqxw/0J+9e8/GmWYYVr95/le6VJX/MnhFCMauB1xnV1S1BlzN2oTFqK+1p+SLSyaE6xtxCosifiQAtFP5hO0kp6RZQQhgkeApKTneTpIm1s9MO89UiBDTnI98iI1AXYqbzbU1cjuY6GVxpdwuLBe4WcxX2hf0kTv8JSZGYrRGElu34Z5spgbQOvCNr35dJi1R3BvrAppEsfE9wteY54IyKws7gpks27YHuZBTPM5m0XcJvF48h4qFjlPAo6+nUZrvZ8bnom9pLoaTjNld/wcHLQIVtacerZ3qwbDbbxeReYnJZSXyZr5Tx0IIwGZ9IKRx/9TaZw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed8534d-46e1-40ab-b5b3-08df23b65093
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 14:30:05.4237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4teoQ9QvL5bj1DW5FYewqoSGP1PJ+cQrys+8FL+7CxpjREDLAbZT/L8AAPN9BidOFpvufIdqMsO4tsyljxzCvBVBdK6f1QBxz18C4P2wzAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR11MB9903
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

On 9/28/2026 7:27 PM, Omar Munchaev wrote:
> Currently, in ice_check_fdir_programming_status,
> descriptor fields are accessed through direct
> bit mask manipulation and shifts.
> The ice driver has macros for this, so rewrite the function
> to use FIELD_GET macros instead.
> 
> Signed-off-by: Omar Munchaev <omar.munchaev@gmail.com>
> ---
>   drivers/net/intel/ice/ice_rxtx.c | 37 ++++++++++++--------------------
>   1 file changed, 14 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index 882af80833..f14e5e56b5 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -4465,36 +4465,27 @@ static inline int
>   ice_check_fdir_programming_status(struct ci_rx_queue *rxq)
>   {
>   	volatile union ci_rx_flex_desc *rxdp;
> -	uint16_t qword1;
> -	uint16_t rx_status;
> -	uint16_t error;
> -	uint16_t id;
> +	uint32_t stat_err, error, id

Missing semicolon, so the build fails. Please run 
`devtools/test-meson-builds.sh` script before submission. When 
submitting new versions of the patch, you should increment the version, 
and the patchset also does not have proper threading. Please refer to 
contribution guidelines[1] for how to do this correctly.

[1] https://core.dpdk.org/contribute/

That said, the rest of it looks fine to me, so the semicolon issue can 
be fixed on apply.

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
