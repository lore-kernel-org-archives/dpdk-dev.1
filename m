Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5553AFD8FE7
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 17:44:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7937D4028F;
	Thu, 26 Feb 2026 18:44:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 8EE094027F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 18:44:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772127873; x=1803663873;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=ZZPnvXQZllqjPcEECjPD+NRJV8P2qj41A5uUQVY15Rk=;
 b=FiRXRmzCiD7A9J76Jd67jWmw639CdroH6ck7BNWM9x0/V1JjHcmoGu0Y
 p0iszR4yDTdjwJSa2ry7rkZWBQAGkk0n3BUDys2hyewMmueer1ZrbEMQV
 KzcDCMaPHXEJIIMoRH/1BZ/hzb4UiF6csc7NaNF+5M4fnonw5qEe1GAue
 svPGkaS1+Kb4qTmgvAVVlKIt8gMT8wKo3bhgGHuvWw0T/lmCMOlOR1RDw
 3QIBuxeaE7+98TK/Lup1r0HFJ/aMaEDnNsa6FiCw3V16DqrZhlg2ypsf1
 iHuS0y+Blquva7FoVb+zDVt8dfX7Sn5lO6NH2ZcDRVFlsIihGay1sfdOO Q==;
X-CSE-ConnectionGUID: p9r08hNRThyTxwBv/USi6w==
X-CSE-MsgGUID: womjoFzQS8GnQDXKFOqCOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="83529425"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="83529425"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 09:44:32 -0800
X-CSE-ConnectionGUID: H2CAyHH7RVq4tKh17cZ+tw==
X-CSE-MsgGUID: enYUS7O6SqqWREtDY5iTAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="214151673"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 09:44:32 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 09:44:32 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 09:44:32 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 09:44:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvIVhAtXzDnf/Rkn42ZrceeXtaWyht/AYMTA43xfZvWBhUS4jn6p5vhcFaHrH7M3fV78fBTq1ExmPA3OiutC9q/lnUIt9c52DwuRD5WNTonk2bIZKeQeTHZdH3Gk4BZSVjrVSgKMIjrptnbeNgdjKo+Y+CYowtrvX76pUHxD3xacN8PCtXSdp48sFNoQdwWsWs//7f2JbOuAU1m0ynM6tqj7PlKPjH2ZSEHeIUQWWJgzhLhCpwND5QLmlRBy9Ia0mqT8hJ9AGTT649mTJbGsiYmnL9kWzMvfzWRYSSL0EEMIQhFgY2LUtZxqRpN/W4ihTuJXLEmdNsXRtK0YW2cXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8u7ilmLzP+f1n3WBxfn7oMg16JCd/SMOpfZ2+uwCbo=;
 b=wYYccPdOHSVvx7c+WCSx2UTbFQ0mClBs2z2txhV8QyIF1T11rWiF+xGvfeMjRuHOTprBOXM9pc58IxN5VByycTTeSyIpIooXzQzv4e98LmE2CdVcZi423WdO/e1TbujpeiqViX97Mwbcl9MZLxXZfquAM3Za5P+ddW/Ix2Wua9hFX4UI/LvAIF1AuPHaQ8lxBCJxQQbIuq+jimd9YThmEuYf61oajWV3M/Fmxh0iQ7PXyf7gA1H83WtfCqwGXqUPv97N4VVbvLYzJEi4axjROpO9jZSG/0vq8OoUSCHcfsyq2zn5Jr6+m5shtfO1QHnJPWF+nQ/0jf/ii1j7mHPXCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by CO1PR11MB5171.namprd11.prod.outlook.com (2603:10b6:303:94::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 17:44:24 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9632.015; Thu, 26 Feb 2026
 17:44:23 +0000
Message-ID: <60ef6b0d-40c9-4931-b07a-caeb239121b7@intel.com>
Date: Thu, 26 Feb 2026 17:44:21 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/intel: fix wrap-around check in simple Tx scalar path
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20260226153636.3925387-1-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260226153636.3925387-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P251CA0010.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::27) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|CO1PR11MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b7c4266-8022-425c-0ae6-08de755eadc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: x9xNl97QIlyhJ8TH3ErezhP1RSye0q38j3pwEI/5BEzbuRzxC80buZNKLPOtdXyIbrOC9kyeo5SWIbq1JtAVmI2NT2+3wciXSsuWFjeRjJvDA6s2huawCVju8blMuHUOZ1An1Jhmz2oGT3D0zQ+fEsUy9+mYhkkkD09IrXTRPwxfiDCBihIvFhTq6cAuuVBazfW/DkwdBp8EYmNDMsgyHGH7C3vPqFQICmY2CzY5vtvZvCQ7HMxX8OYAbczLgIFleqJ+SB/GnRmAdJel0Vv/WZSl/0FmN3NOGhxlkeG36SgiMPUIyqmfB9R+sCHjQ3m563aNG301+UF7iWMQsRu3uypYJvUda1C75YXw//22Ru59NtHVoIWHvbZnm6E9qQRyb0IsF+J6AVfaN5+bb13d1nZdSW/K3AJ+Wf5H34/8OSUIW0imyiwqxCiQI8QYUKpxNktGzWGtcJ6KACPCC1QTNsmygFN0L7hsGJganqkpqbBOjGQkGdtxUuBcB6uGkUDsKfeMvIOaVUxJb2jltEjcCqBJzLzAXdI+iGn/Uwox+FIgTNHxXlAidcPIBHZqGNVmrRe4Z9TqkhNFZQmo4q2/tA9H6viUV3QmicgSNOJ7dCSZo29XtDFCGayN6qDLs5+7LA1QYUulELilC+6/blkcJ4JTwKIfRGpZMizvoBM1q0dJAbeS+0qKaHmskQPopBH2Ftdd1r7J4PYsIpEQ6/V2gcTh00H8Gb/ytqgIM72UzRY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmdFNEZYaTZwTkNkZ28xNmo2VGhRdHF2RlBwZWJoWTJCdG42WEJ5L0V2bWI0?=
 =?utf-8?B?c1Nia0dHV1pDbzl3bm9hWXBpTlVuZm4zeldUaXpIeHk5VzZyai8zOFlrdVkw?=
 =?utf-8?B?d3Z1R0tIVWd3M0hZc0dSTXJMeE1nZm81cDk5RFBoMTUvdTFuK1pBMElrWEhh?=
 =?utf-8?B?dzYweVZtdFZmeDFuOVRSK3hEQXpaZ1J5K1FuaVhRUHhVaW5aZnlhaUVMc3Fl?=
 =?utf-8?B?SzFNbWlYVmtEMFBRSFU4WUgyY0pCVWhScWlGc25QY050SGpaeUtSOG9JTXFU?=
 =?utf-8?B?ejRIOEFQby9ZZ1haVVc4a3ZieXJPYnlhMTFvSnFiZGIrWWtLSkQ0bVBBUTRi?=
 =?utf-8?B?RFdXNXZQbU9YWUdUTlZIeU91aHJVOHlzZTFxMm5NTldCdi9UaEdZTmFpd2tl?=
 =?utf-8?B?NStwSDZnNVhBZWVaTVErTGNzNXdHYmYzT3BuNXAyaEpPWVVSS0s4WXRzeFAx?=
 =?utf-8?B?U1J0MkwvZmhScEg1SUJkRS8zUGdBSEFYazJhbFlUYS9mUEcreUVNZEkzaldX?=
 =?utf-8?B?N3RydzcxRDVpS2J3MXdtcGtBTlBtSzdUeDd1YmNjbkh5YktsUktldVg3dU8y?=
 =?utf-8?B?enplWVJDZzQ5ei9jSnhOYmRwUTh1NUNLQ0VNVE5sK0owNWtURUVPSGowdmd0?=
 =?utf-8?B?SFVOQmZ6Y3BKZWQvaEpDVXBCQkNSaGRTcWwwUTZzTjQxbndvRlcyRlVXcjJv?=
 =?utf-8?B?YVd5UEdzcSs3dmFTVW5SM0FlR0Y1Z0dXdHZlTmoyK1NTUVFuZkU3dGs0WWJy?=
 =?utf-8?B?TmoyNm9neXN3b0lmbGZsOFhHWEpFbFl3eWt0RXd5c0NPOExLN1ZXNEEyN0Ry?=
 =?utf-8?B?cUhDNWFyV2pQMjZJOEw1eW9Ea3VwVUg1NU5rMGQrSEExWE10cFBTVU1VSVky?=
 =?utf-8?B?QXVHbDFlNVZPMUtnUC9BR29FdndtZXVOWG5VUFZudVY1RE50OXh1elZOelM0?=
 =?utf-8?B?SGdmWndyUFBvS2dSOHVGdS9Icm9nWkRGM0pKOG5KeFQzSGJ2VStLL0RoZ1lO?=
 =?utf-8?B?MExzNS9IY21MMmpWZWNSMHo1eFVvS0E2djJLQmlDUDkwOVU2aXNPTC9Bckk0?=
 =?utf-8?B?WXBNdXdMNG10SVJtdCtqZXk1N0VaTGFJOXk4eXZBeEYyeXprNmc4NzRYN0cv?=
 =?utf-8?B?Qnc1RWN2K0l3VThLQ1VCS0pSdDRCZ0g3dEcwQjV1T25CQnVpZGMxTENFTlVZ?=
 =?utf-8?B?aUZ4bUxVVVBia3V4bzAzZ0hqdUg4LytuRjlOWEoxZ1ZIbU55c0xXdVVQYXVX?=
 =?utf-8?B?SjN6WFdZbHhhNVNKcjRUU3pSNTM3ckQ0ekVja2FKT2drdTE0VHU0Umx1TGEy?=
 =?utf-8?B?NkJKclduUm1QRlFIb0Fjc01zcWJRcHlpSmxXbVQxNWxvU2dySUNIYWNlVVIw?=
 =?utf-8?B?LzdPbDA2S2pXNnNKZnVkRlU0QjZRdHVsK3BGTGRSYVV1dEJTVEZxRmZ3dmhM?=
 =?utf-8?B?cklSdWJhaUpxN1J2NjFaRDNQcHZIU29xRkxYcVRMOVUyRTlwalBvNUozTEd0?=
 =?utf-8?B?QmpHdGNpYnpzcWJjNTdHR1RYRzh6VDFYeWh0NFJTZURjQXd2STM0T3RkR3Yr?=
 =?utf-8?B?YzF4bjZWaFZvSnRYbGE0ekNUdDV6aHlFUHk4K25kZUV2dDVSVm9TWkRWelA2?=
 =?utf-8?B?YzV1WjNLazduTUtLRWFkcmRZQ242WW1PbkpiTGRyd1VUdUxGWnprby9tUmVN?=
 =?utf-8?B?R0lwVld3M2RHWisvOFhEbXA1TVZsajJlRTB5b1NwRkNEY3R6WlhOci8wS2x5?=
 =?utf-8?B?ZUV6dGYrbk44NnBWUmFsbHFJQ0VYVVV6SHBXREJ3T3pqUGdxdlRFTWc2VXh3?=
 =?utf-8?B?WHNTUFJIeVZpdmV5Q2p5NDNkN09Da2V2QXpVWW53K3BKc2VvMGlqVUxQb05x?=
 =?utf-8?B?QXlGN1poRGp4bnZKUUQreEVDTkViRlRXcGJWa0Y3azNZazhMVzF0cWc2NVZx?=
 =?utf-8?B?Y3ZuVDB2ajhqd1UrL3ZOQnd4cTIvdkZOZzNoRzN3cnFVNENOMlNjTnBQS2FL?=
 =?utf-8?B?MndKM29VM0J1NUlNejlrdlFpK3dOQytLSGFHblVBSWdUcjhsU3Q2Z2NJNlRm?=
 =?utf-8?B?R2hEZlJFTjE3NExpNkJVMklMUXJDbitNa3AzSE1rS21teXZiQWw5SUR6WmFI?=
 =?utf-8?B?QkxudytmeDBXcVVXaVJ1OC9iY2lSb2dXMkxUK2lWMmlTWjMrOE5ySmpQOG9y?=
 =?utf-8?B?UFlrcGxXekJDTFFkVjdETld5b2w0MkJzUitvdHBCcnZMQ3Z6YkVYTnNyMWZY?=
 =?utf-8?B?SWxzbE1PMU9PeGxpU1lsUjVzWjNYT1RLYXEzbUdCTDNHN3h1NFFaV05IRnE0?=
 =?utf-8?B?d2xmVTQramVlSk9xTUpna01tNFI1T3VjQnhQaUs3Q1hNbDBBK2pjUi9NZkds?=
 =?utf-8?Q?tyvbZItLEc2vpU3I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7c4266-8022-425c-0ae6-08de755eadc9
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 17:44:23.7937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GVsIwtBPaX3CrPe24k8aceT/BWNc1IYJTtUOY3JRSsjjmAm58BO4rQlya++n/qQjusTHdG5By7Ma2wgXt6A9wCHxzSui7s68HttRI+fdhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5171
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 2/26/2026 3:36 PM, Bruce Richardson wrote:
> There was an error condition when the burst of packets being transmitted
> ended exactly on the last descriptor of the ring. In that instance
> alone, we ended up writing an invalid tx_tail value to the hardware, of
> ring_size rather than of zero. Add an explicit check for this case to
> the simple Tx path code.
>
> Fixes: 9bacf6a81b92 ("net/intel: align scalar simple Tx path with vector logic")
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   drivers/net/intel/common/tx_scalar.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
> index 4475995180..9fcd2e4733 100644
> --- a/drivers/net/intel/common/tx_scalar.h
> +++ b/drivers/net/intel/common/tx_scalar.h
> @@ -145,6 +145,8 @@ ci_xmit_burst_simple(struct ci_tx_queue *txq,
>   		if (txq->tx_next_rs >= txq->nb_tx_desc)
>   			txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
>   	}
> +	if (tx_id == txq->nb_tx_desc)
> +		tx_id = 0;
>   
>   	txq->tx_tail = tx_id;
>   

-- 
Regards,
Vladimir

