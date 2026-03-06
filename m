Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD77F01832
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:45:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9B1B402D3;
	Fri,  6 Mar 2026 14:45:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id A9EB740262;
 Fri,  6 Mar 2026 14:45:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772804712; x=1804340712;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1BieFev2F8j/yjVdeY9FCZoT2D2qRQLYc4LUpWyv6D0=;
 b=PwVXcKdg8b+BvzaWz+pR+uGBefSXH45ICrLENFhfMWgLY7d2o+QEO85T
 GSFrjL4bMh07div7EGW6EjnOqxPmRVxooL+9dlrz8WPL62QZzgSIApsTE
 YHQ678Bie3V0HYTpD0FU/rep42TJ9hVDU98cpE4gA/XNd2ry7e99QtPny
 Bt7uLQtz0BkxTPfcvJPYb1IHmmn4SFLf4PYyIlii/98/N96CpPB75vPM0
 gU5CQYB1ZemGH2ib+rbzu7+hQA/gdXffc7Rgvur7FRYvhGfETHjKCZL7D
 30YL3IcD/m5Yg69egWn58Njm6oqlDDV+TPgIbKxwSYVal8HfDFeDYbNwm Q==;
X-CSE-ConnectionGUID: p6m6jGocSMGUDR9G1rGI7w==
X-CSE-MsgGUID: NJ6zFyAyRQaRluGk8fDpTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="73610787"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="73610787"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 05:45:10 -0800
X-CSE-ConnectionGUID: UdIiGT9sTuWG4Oys3mXBfA==
X-CSE-MsgGUID: 7G+01H7GT5amzfddFile/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="219145513"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 05:45:10 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 05:45:09 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 6 Mar 2026 05:45:09 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 05:45:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwpYGXatehd+/rpIf68K7UOVdp0/TgqbswbMv8/Npoqj/rMj7ezslq7vFzljzaKvVJrxXoEkhM03+VgYYVWkTSiHUKtYDwY0gC4nXiSfj65/+mdG0bnceJdtCd9Ucwo1HlrF+IqO4TKIPMjcAWQjVc8zFHP2J7QmyPbVfohsuUiZkjD4SI4sipKQoy1QDIAW5DWRTo/BUED92KpJVMUueQ4+UzXE0bRAI4FPijdWyL5eBkGQlPxfkjcxhVWTbK4B4xXegvDxMkLQUutbK+oZzpukMGgVeASY7Suc57fnqPF+4DJzAajmaMLLei2SNoe74rNTmbKIMPUvktWmvJdY+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BP3SlqzeVa0vycxLLguCgnWVmjnUK+EZJaAUkPiHYRU=;
 b=OJwGKs+40HV6z445SxR4ZAWRmpondnv/ZVcHRqFMv+54porYjQUi40BtIxEsTgSwojpKGPwfX2BbABhYvTVcBCiaJ1UFvMHFzG5pCdfaIsPCVTrLZu3wpLKgzmjYxLY6HB/w0MJtnG5t3b+1stjjwgiC0hwbPPb2Aw7REiZNJF4yLDRQMSuRMkDwuEvHBiIs934Lyy7xcZmpThedw8GGajDzC+WBROX1tA4GvUN5F6Njfv0x2JjhfYjqMXi8H7XtKxtZMzfeyetq/4RiRNvzzH/QiRCIPnD9Ws52NsJsuZeU9NTXZsMNKaGYtuJ0wrPgh4TorW3JTmDluPsyVdZp7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH3PR11MB7297.namprd11.prod.outlook.com (2603:10b6:610:140::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 13:45:06 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 13:45:06 +0000
Message-ID: <f46aa723-75a0-41dc-a063-d79420365b3a@intel.com>
Date: Fri, 6 Mar 2026 14:45:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/idpf: handle Tx of mbuf segments larger than 16k
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>, Xiaoyun Li <xiaoyun.li@intel.com>, Beilei Xing
 <beilei.xing@intel.com>, Junfeng Guo <junfengg@nvidia.com>
References: <20260303150026.1601461-1-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260303150026.1601461-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0053.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::23) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH3PR11MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2cbfc9-23ff-4f71-7cd8-08de7b86937e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: OYvXmyM/6JoUZeALtz9V02MWBAhp2tztepVS9rO2HzE2mdo6AbLw5wI8wG9QN/3E6iBIRsX36cgU6Xujv0oN9S+vCGiKpmmtwliTATWfifR2JQqzn/y7hWeyo4wahklPzadKV9dvsfVuCJHw6Azx+yXKhw0+MSXfW2PZpKJd+RzcAQJlZXuKEiEhvTnX8frxd/DIMLNX4/bnHRkufOK8+Ygs25vYflq3pA5YduDxZPp4SRpYVmfB0uDM4QujzJGTGPUAiB0aCdqMMlO9BJt5ujOvCK9lcOZ50Mpk+kErgrxf7dE8LEkdW2gvShf00adElcoXvcXm7d9OsHiO13jF35lSbqiSaL42BQS0Gjfl3qRXxcuaRbLNBAaHaXAx+rCl1XEolXQGvTr92V545eJpWy9519LyvTeK+rOprpUm5E+Qo4s6CHQV7atOyZhpcwHqJj+uxKMP6YBwIKw+mulqgzafjfZ1LsCky39W8F2gDVGkUrhWJRLvXaDJVM6oQx4s2gMf4DoUPJZMlCVKrt1MuYagAtp90dU/izywGDg3gIn/dl+9PbD8oSHDiiWoz0qolmIpX9DWn/xvFaG6Q+YBEsiP+MvP9oNI/bMw4xIzMRPwURoqlI56WQd9I0DFfED5xeuixu1NzeO2W6B7S05ANTpOKs/Ywl5BF9Yx8k/MR8xJ9PezxXqfj6UIQMO03Kk7nBP+wNnHw5/QcUFHEYuK5FN/1seOeq57AR6cMeWC1uc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1B6cy9ib00yaFpNVmZRNGtxSWs0SjMwdDVHL0ZQRUEzdzRaYW52SDlLdzN4?=
 =?utf-8?B?ZkVSYm1EK01LbjJEZDZiaUYraUdja2w3S2dvek50Q0lDVTBmR28rTXJjVVZR?=
 =?utf-8?B?VlQrYXJvN2dlMkNURTZaRkppSENPQUhZOFc0MzcxS0ZTZGxXeEFrRllyWTlv?=
 =?utf-8?B?NlBvbXFBcCtRT1YzQ1RVQTZCWDRZMFlONitiNTcrdms1bXIyakwvQXBqZ2t2?=
 =?utf-8?B?UWVJYzZXSDBBL0hRZHdGSEhIeTJ5eE5lTEFoWHJRS2xIRlphMUZYejlPQndT?=
 =?utf-8?B?cTREYSttN2dKUzhqQ0JlQldIbUZtQzFRZXhRcGpvSUlZUk1aWmd6cS9PQlR6?=
 =?utf-8?B?dlJGZGVYN1JGSXNPRC9RbVBqQ3M5RGptMTdoZ0pqTDk2bjg2cDFYTGEvdDJH?=
 =?utf-8?B?c01NNzB1RnhhN0VxZEJTUTlmN0JpWmhsdTYrcjlRZEJ2UTJnUWxYQjVnaHVq?=
 =?utf-8?B?SVpnNG11ZzRKVEJGc0FFbTJnd0NZcDdGVlZvdWZza2FUVjVFcWNGeGh0SkRn?=
 =?utf-8?B?OXMwQjBSNURBdHZtNDFvaHRSQnJCUzZFbGdkSFpQdTAraWQ0SmRrMHdzeUdR?=
 =?utf-8?B?RVl3Vzc2WmhEa0FMUXBoKzFKekJ2d0lwc3NidUJwOFVqYXhaRzFodkZoUjZL?=
 =?utf-8?B?Ty8wUVJWcWYyQkFPcStOejlJK1FRM0NiUThEN2U2RzJ0ZXJDMUdFYUJUaGlR?=
 =?utf-8?B?eDhjcWFQOW1pSmFWVVFvSmtVaVVMQjVJa3NkemRkZ3M5LzEwMFBDOFlLcEVt?=
 =?utf-8?B?KysrRHNEdXRueGNsL2swaVkrWERPYURNanZSOGlvMndsazFMTW9yODZKOVh3?=
 =?utf-8?B?TDZhWnRSSWNVSWNDOVVWaG9Ldi8zc1I4cTk1WTI2ZTF5bEJZL3ZDUGQwbE95?=
 =?utf-8?B?dGZ3ZXp5bEFaVVI5MGlJRFVlMlBmUGYrNk1GY245c0RBdURLRFhrd2ZSSzB0?=
 =?utf-8?B?Ny8xcmN1SVNBZ29EOGZBWVJBSlNoaWJ2TGlnSlFhRmJCOENYUFROdEM3bUUr?=
 =?utf-8?B?RmRNekhxQjlXMzhwRWJlNmJwRFRGNm5qV01hTjZGME9kRjJpZGV2dXovcG9E?=
 =?utf-8?B?NDdMdDRZQ04yUDF1SVV6Vyttb05QalpWYklaV3l5R3dHQm1EVlVxMWVqWEFa?=
 =?utf-8?B?OGN2bkhlR3Nadzl2TjE3SEF2RU1PaXhpWWhYM3NZelA1ak5lQ2lwdnBiSTJo?=
 =?utf-8?B?c1dqbTJGVy9aWFl1eTlRbHNzSmlYYjM3LzhqOU1ETll6ZnpLcUtrczBMYTJx?=
 =?utf-8?B?dnNpNzRVenh2NkNNQ1FFam5sTmhBdXQ5MStmVnViTGh4d3l0RGZtZ25XeUJB?=
 =?utf-8?B?YWgwSTlmcGJaTkZMZkZ4b3V5TjgvK2FTNEVjYmFnTlM4Y2FKeGNraWttWXRp?=
 =?utf-8?B?c2lOMmF1WlVmQ0FmNDRGUDVOd2JpK3JzTmFQZmgzODVZQ3JiYWZJQUFhVFYy?=
 =?utf-8?B?Mm5Yb1ZMTkYweW4rOWdvSHFXS0x0eFBUYXhpK3dySnFvdi93MEtadzBZQnR1?=
 =?utf-8?B?dkZCYUZvK1JCOG1pWm9tZU51REVtdnhPQmxNclBWOEhrcTZyTmdtdm1rU0lS?=
 =?utf-8?B?OFBCb3hLaXV6bzBqdXlmbEhYWnhSZWNTS3ZZOE82c2hHQjdsbUEzeGdac3Vi?=
 =?utf-8?B?cnVQWUtQZnJRWGZXMktxV0pmblRSUVNveUZCblJCTzd5cXFvck5YeU9xWmE2?=
 =?utf-8?B?UHFwdEFaVU5GSkZJeTdCdlkrdW96dkhpYkNsSkNHcE95TC9hWGppd3VBWVhh?=
 =?utf-8?B?UEhlSEd2bWZBWkZpVDNldllyUitHODRGVUpoeStuMURSM3N4R3VXWmFTckJr?=
 =?utf-8?B?UVFoYlpQWnloY0U2M3RDQ0xOcEsvLzd5bHpvUUQ3UEtScmk0VmJKK2hmMnNK?=
 =?utf-8?B?ZkJZRGgzMGdvYzI0NFdmOG8rQTBZTEE0dC9zNlRHOVpWSEdVMHVsanlwV3Vp?=
 =?utf-8?B?bGs2cU1qQTExN0NBK1FjZDJPMVd0S3JaTUtQRW1xNFNodXd0eGJIanpXWlQ4?=
 =?utf-8?B?QTFZcmNvYnFSb1I1b0crZUduK3dKTktwNEVoTmd3RWZ3M3dSVEx5KzBVOC9z?=
 =?utf-8?B?S1RML0grcnRuNlNCRGVXV09vQ1JlTlMwYmFaTDU1cHVvTUVvK1FJUDhhQkZx?=
 =?utf-8?B?MnUxWkgzRGZHdTA0S240YXU1ZDVSOHNsWEFITy9YQkNEdkJRSXZIV0Jkang2?=
 =?utf-8?B?Y2JLSS9FT2RlVjF3cVREaUhmK015TGhydDBYMW41Q2FhRGp0RU8vV292NldD?=
 =?utf-8?B?M1hERHNGZ0xDQzZWNHk2bWVQNVRVd1FYeGtySllWdnlrTDBkeGhrREdwVmd5?=
 =?utf-8?B?TXRmcjF2bEtsNWpPZ3dDdTFUcFRGWHJQU1RHYXRBeUhoaGFKVVRod1BOck9X?=
 =?utf-8?Q?YART9jOAdwoUeYPw=3D?=
X-Exchange-RoutingPolicyChecked: PoOkMB5RnAgukspm6qpUkNE3MUoYsa0wysuxwmmhEuceP8dtMVY9+tb7pf5qod3G3shw9bW3LcUNTtQXCPj9azVVjBHOIuYxAG7ADOkcSPS9oLE5c+FtRYkeVbGB0NheBO8BZ14rpiHeBsm++6yRhM8NmnGlg6TjBM0O+hPalOjunlQWEmrEqP+niH8K2hiu7/BVmQIwMKdLBzOp/foEo0pGsaZhqmyfkeSRi0/lzafXWxDBgRxMh9rnIyzm450xYyBuEKWEO6EZfFY/MfqZs7BOyBMBc/mw8eSv3QZ2Ea389mf0rB81a6xbTp7Llqff4mWmMJw0fC5CKSe97/yIOg==
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2cbfc9-23ff-4f71-7cd8-08de7b86937e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 13:45:06.5524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Lj9qHqFK+oEFjWIUP+h5Bo8TbSTX0HUuLiJEpTzGdHlpbyu4js4UxeUKZoq9Oc3Pr3yjeOFHNHazy7MDMDA8ASKCQX/TihjUAI2VE19ahI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7297
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

On 3/3/2026 4:00 PM, Bruce Richardson wrote:
> Recent rework of the Tx single-queue path in idpf aligned that path with
> that of other drivers, meaning it now supports segments of size greater
> than 16k. Rework the split-queue path to similarly support those large
> segments.
> 
> Fixes: 770f4dfe0f79 ("net/idpf: support basic Tx data path")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

<snip>

>   		uint64_t cd_qw0 = 0, cd_qw1 = 0;
>   		nb_ctx = idpf_set_tso_ctx(ol_flags, tx_pkt, &tx_offload, txq,
>   					  &cd_qw0, &cd_qw1);
>   
> -		/* Calculate the number of TX descriptors needed for
> -		 * each packet. For TSO packets, use ci_calc_pkt_desc as
> -		 * the mbuf data size might exceed max data size that hw allows
> -		 * per tx desc.
> +		/* Calculate the number of TX descriptors needed for each packet.
> +		 * For TSO packets, use ci_calc_pkt_desc as the mbuf data size
> +		 * might exceed the max data size that hw allows per tx desc.
>   		 */
> -		if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
> +		if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))

This looks like a drive-by fix for an unrelated issue. That particular 
code was introduced here:

2904020f8313 ("net/intel: add common function to calculate needed descs")

There are other drivers that check TSO flags but only look at TCP_SEG 
but not UDP_SEG - should they all look for both? Perhaps this should be 
looked at and fixed across all our PMD's that support TSO.

(to be clear, this is a general question, I'm not implying these changes 
must be part of this patchset)

>   			nb_used = ci_calc_pkt_desc(tx_pkt) + nb_ctx;
>   		else
>   			nb_used = tx_pkt->nb_segs + nb_ctx;
>   
> +		if (txq->nb_tx_free <= txq->tx_free_thresh) {
> +			/* TODO: Need to refine
> +			 * 1. free and clean: Better to decide a clean destination instead of
> +			 * loop times. And don't free mbuf when RS got immediately, free when
> +			 * transmit or according to the clean destination.
> +			 * Now, just ignore the RE write back, free mbuf when get RS
> +			 * 2. out-of-order rewrite back haven't be supported, SW head and HW head
> +			 * need to be separated.
> +			 **/
> +			nb_to_clean = 2 * txq->tx_rs_thresh;
> +			while (nb_to_clean--)
> +				idpf_split_tx_free(txq->complq);
> +		}
> +
> +		if (txq->nb_tx_free < nb_used)
> +			break;
> +
>   		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
>   			cmd_dtype = IDPF_TXD_FLEX_FLOW_CMD_CS_EN;
>   
> @@ -959,30 +959,52 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>   			ctx_desc[0] = cd_qw0;
>   			ctx_desc[1] = cd_qw1;
>   
> -			tx_id++;
> -			if (tx_id == txq->nb_tx_desc)
> +			if (++tx_id == txq->nb_tx_desc)
>   				tx_id = 0;
>   		}
>   
> +		cmd_dtype |= IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
> +		struct rte_mbuf *m_seg = tx_pkt;
>   		do {
> -			txd = &txr[tx_id];
> -			txn = &sw_ring[txe->next_id];
> -			txe->mbuf = tx_pkt;
> +			uint64_t buf_dma_addr = rte_mbuf_data_iova(m_seg);
> +			uint16_t slen = m_seg->data_len;
> +
> +			txe->mbuf = m_seg;

CodeRabbit picked up on something here, and I think it's worth highlighting.

When we're splitting segments, we assign txe->mbuf to the first segment...

<snip>

> +				txe = &sw_ring[sw_id];
> +				/* sub-descriptor slots do not own the mbuf */
> +				txe->mbuf = NULL;

...then set subsequent segments to NULL...

> +			}
>   
> -			/* Setup TX descriptor */
> -			txd->buf_addr =
> -				rte_cpu_to_le_64(rte_mbuf_data_iova(tx_pkt));
> -			cmd_dtype |= IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
> +			/* Write the final (or only) descriptor for this segment */
> +			txd = &txr[tx_id];
> +			txd->buf_addr = rte_cpu_to_le_64(buf_dma_addr);
>   			txd->qw1.cmd_dtype = cmd_dtype;
> -			txd->qw1.rxr_bufsize = tx_pkt->data_len;
> +			txd->qw1.rxr_bufsize = slen;
>   			txd->qw1.compl_tag = sw_id;

...and we're supposed to write the final descriptor here, but we've 
stored the mbuf pointer in the *first* descriptor, not in the *last* 
one, which means when this descriptor gets to processing completions, 
the mbuf pointer of that descriptor will be NULL? Is that intended?


> -			tx_id++;
> -			if (tx_id == txq->nb_tx_desc)
> +			if (++tx_id == txq->nb_tx_desc)
>   				tx_id = 0;
>   			sw_id = txe->next_id;
> -			txe = txn;
> -			tx_pkt = tx_pkt->next;
> -		} while (tx_pkt);
> +			txe = &sw_ring[sw_id];
> +			m_seg = m_seg->next;
> +		} while (m_seg);
>   
>   		/* fill the last descriptor with End of Packet (EOP) bit */
>   		txd->qw1.cmd_dtype |= IDPF_TXD_FLEX_FLOW_CMD_EOP;

-- 
Thanks,
Anatoly
