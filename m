Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CA4CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:25:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AFC0402E7;
	Thu, 15 Oct 2026 16:25:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id AA86B4027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:25:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792074342; x=1823610342;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=raAWSynge9S6n4pArMBwdRRvkGWOJUXlNtc7hoMBnLg=;
 b=mGauugciPcJFKXdrPfKxHo2fARJQlklpdANVOMYNHt6jno+uUHiv9GVT
 kv+docsEpEudKqQQAveUoMuYuAZcO+d21VSZ7ySfXoGgDalIXDYPD/9MR
 xyvJNRU078kKF4fMjC0XfWsbAPB23fs3eD6DICcoONfHaAXMvTCiqOruE
 nFfLOPh0BNZN8yMkFZYDg8OYayDm260JasfJKmpcPdpcBNv2OAfRvZlGn
 Mcrci/oH4A4Acf69c9URxVnGl2+6oNZeuYXF0Vaz7HgSOwDP1Hz9zP3/9
 8GSZz9zHRk9eNOhq5sAv8nuv+bh3dr6WBuTdr2iPTKsmMDPuB1UQNCgGX A==;
X-CSE-ConnectionGUID: iXCeeK7ORySm/OpV88LCUA==
X-CSE-MsgGUID: vQcJ90q1S4KrkzLSs/XXkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="731788"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="731788"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:25:41 -0700
X-CSE-ConnectionGUID: qjWHFiopSOell8Pl+SjiNg==
X-CSE-MsgGUID: m/saLkZaSNijcLuKYOSAyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1954846"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:25:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:25:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:25:39 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:25:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8Gbd2E4SSB2Sinp4Pnzow+RMTT8ERoCGV8IeXzD6lEG+03iBATBxETw8lBmL+jEWCOdNFuHAJswuMCAEWDieZszVHJE1hZqz37jXbP8SCB7D9IwGE8r1gZEQSyxBUaTKCjblQdhR21NzdfETPIFZl57OfS2eijTXhXhdUvKXdvEQYcUO7hXSFZ93LdDHnnMhjeP/O9+ZnUcfPlNRoQJLfGlbKf9wwDmXQ7VZYXVBGExZo4smj2buxLcG0cSep3qxImIpaDQ4xpenT/UPjtr4Gm/70/Lf1w2kMb6svbXAPDGbF+bZNhC4Y27hGUqZVh+4CXmJV9EeS8MHMvQ/zHhgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtaG6il/08K2E2Cu/3vcw6txe4ycC41jzusLyqJas7M=;
 b=cF/I15u2u1ObrFXkzkhnVZOwrxNMZ1LkpPXEgZr5tzmx+9C1TOKlM2f3Y6hvtLEb4cyr3n1PJ/E7ESjghtKCXaVw7HF+3RQlqXPGp/L7OAIQwE3rUaiS7ThUohQAOmTA4J2iz5vXcCkN0aH19FO3NrmkAYGBEBu+T6kArMHjebafnINMtLMtrbeCXtr/18vxZiChKGuA7/rqb3E1XFQgYQrXRfJ1MZDUNVfFWNdFXOFk7tPA5JA2A+kSQNCIPRzJKNH/BWXbXH6NU79h0/BngHLGYFtEtAGi7YBudQiB2/XSD6X1lnAVCPLbGpGx5dysgXVJb8foDVRVN028cqfDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by DM4PR11MB6168.namprd11.prod.outlook.com (2603:10b6:8:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 14:25:37 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 14:25:37 +0000
Message-ID: <fcd72cd6-9db9-4650-9acd-293720699fe1@intel.com>
Date: Thu, 15 Oct 2026 15:25:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] net/i40e: fix compile issue in raw parsing
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <9e8c2ae1de56389366cbbbc2bf92492e732c3344.1792051372.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <9e8c2ae1de56389366cbbbc2bf92492e732c3344.1792051372.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::31) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|DM4PR11MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e8b511-f096-4dc8-6667-08df2ac82e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|18002099003|56012099006|22082099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: VDBNltGq4iWDSWKbPjjK8uesMgEH1wgROc/VZezJIhnOzk04FS+A/b8ZmQ5d5tOCuVvtE6xI62knM4M7XHy5hRh9s+Gsx8Kyb8+pvMLagG6P1X6SuyzkHfO0dIEH5LL65fq3K20CONU8mMjYXwxPCIan2IB7+uP3h9uT+6mHZ98J+1JRvk/eGbsJYdTCiW61eCEnhfVxtQKmSdhjGyDmQwBJrSQ51qr4vYkLhwkEybQ/1XLJxOnvUHgFEgJVWJmHYi4I0XBvyrJ9kqtG1b6MVduyi611YYL8xxw7Dj9rzaK+2Rt915fUB0QsHXDPEEvrc1YnWZE9xbDLPd4XHWSp4tmy7gpQJd2MT5IB4cBVJF23bwY40irOKcUkbEGaK97dyRuv17AtqV8JoLhD6lLxrwfeZMAeFr9JhswdP/YoEMVsqZF1sZ9jTBvx8i07iBd4Sla5YWI8MlXxi49MZT9dWBCSNDXFW7OFw1nprVAcWSdumPI9I2txCqoYldej9CCG3nHphcR8/FxZmlwLeCwTjltihnD0YmU0nJS1P+esIz7bNadz2gzE3jOuiEdAMI66OJlDekkAduHzhYWnNt5x/nQV/1q/HJoEbJ/Ymmph57xcuiO9/f4Mqv5GkgDDL5Y2sCpsthH6HVe4EV2IzROW4swgZLTkhj6ELcfHyDMrsB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(18002099003)(56012099006)(22082099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzZjZUFjR0UxS1BqeTk1WFZSRHBSVW1IdHcyTHdFTzJmOGpVbW9rNmE0dDVS?=
 =?utf-8?B?S2xubEVFWDlmUFVQSzJDZWxOUFBLVThOeDFYVDJrMGtOYUJ2WGwxVzd5QjBR?=
 =?utf-8?B?RHovakVqaEJxeXFiZG02ckdTN01Ra2xZN1l0VkJNUzBkdSs2UUlOOENWSkRH?=
 =?utf-8?B?a1lobjRPR1VuSlp6RXlNRU0yZmVGTCtZK0FNaFppMWxsS1VSRXZTc1M2QW1D?=
 =?utf-8?B?SFhSU2ttNkJwaEI2TGl1SXcyVHB5VFpXZnk3bHE4T0NlWENQOVcvRkRNS2tn?=
 =?utf-8?B?c2FDMGFjMWlHdlpIdFk5eUZubS9sWlFROExHSG5ZQmNhR0l4S1N5Z0EzcjdO?=
 =?utf-8?B?N2RjSEI2MzNqdGIybkZOMTJINHdvVzZBeG5tSkc1Slhja3JTVlBJR3UxSXh3?=
 =?utf-8?B?ZXBjYjZtemdDbVZiQm02VFphK1h6MnpWSXhPY3E4RElrMzRCT1M4ZWM5U1JO?=
 =?utf-8?B?UG5LbWU5MjI1UUpCRm1KV0cyYW9iaTZUZENQNmNlUXl4dGlLdXpDRzI1TXdr?=
 =?utf-8?B?RzdBb3hiTEtQNTE4aTMvWGFnRmx0M05DUFNhV2tzUEc0ZFlvQTlmQTh5VnYw?=
 =?utf-8?B?YTRjODhSZXBZQ1UzNG5iby8xUlpWblBuZXdHMGRNeVhBT09jbHRqYWh4Q0hY?=
 =?utf-8?B?Y0picVhCazdzOFA2TmlxZXBTeHFnSkRTeFBKd3lJYUh5MVpTSVlWaG1VRDdS?=
 =?utf-8?B?Tm9sL2p1U25NeXRtTHZnaFU1NEFzTjhRdGRndnZmVklHM2ZXcEozR1E4ckJW?=
 =?utf-8?B?ZklGelFWZ3lwdUIvYkRPZHBwZmw3b0c3dTVJR1RCS0grZnBGa3RYUk5wK2Uw?=
 =?utf-8?B?M0ZQOFlKZ2NlaFVVMGVPdDlIMzlYK0hQWDNBRXNXTXdXb1ZBcWVvc2Z4bGpK?=
 =?utf-8?B?djV1b0hHMnovN3Z4TjVtMW5UdmVQQ2FrZUc0SENYUGs4S3V5TTFVT1JxTVBq?=
 =?utf-8?B?aWRvMEUzMG5hOWJWVHFnY0N6NWpCaGtreHVITWtUQUFmYXd5TExUcWdPdGFl?=
 =?utf-8?B?NVYwQ0V1b3hKb2psbmZIYWdPRzVqVW9USEhQZGYyVGdTc2ZhQS9XbUl0alFr?=
 =?utf-8?B?N0RuRzNtVmU0TjJCbVB3K0dJT25RYzlUa2VTNWhGSVVrQnkvT2txVnBiQXov?=
 =?utf-8?B?TUhkNUpBei8wQTNITnhCTUFDOFpIWmY1YnMrQ1NTUmVSU3VpbnkrbkVWWU0y?=
 =?utf-8?B?a0FXZVB1SXdjNWdyZnIxU2laa3JTcU1xNEtMbVdPMmQ3Zy9ZYnJkRGpSS1gr?=
 =?utf-8?B?aUo2UGVTazVzU2Vud0NkTWlXRE5LeXBSZEFiR2ZWdUVNTk9BZ1RyaHEzNlBW?=
 =?utf-8?B?anIydjRNZ3d4cUR1R2I5WW1HaldMRGFaUkw5V1FTR0xRUUpIYUNCUVpNSHo1?=
 =?utf-8?B?Vjl3WXNZSDB3SU1NU0NsUHFHTTJTS2V1bXZjSXJlVkhiMy9ML205OE96ZjNn?=
 =?utf-8?B?NjV3aWVnM24weXpsV1ZJVit4T2MzL1JGSVpWN3NpaWlXcTZ6dkdPeE9oYWk4?=
 =?utf-8?B?Q1JYQUNyY0FXRURUSVVUaC9Ld2pwQnZEUytIR1JlT2tCODEyUCs1dWJuRng5?=
 =?utf-8?B?WG9qWGttbzAvb1BJWW55bGkxQzA5a3pmWEl2NUljVk4vQ05ZU3BEQVR6MkN4?=
 =?utf-8?B?cG5ZbVV0MURMVUJ1ZDFqV3gxamw2aE4zakdKc3RjNVNyTk5lMEh2L01GTU9I?=
 =?utf-8?B?R2RybkZ5WnowU3pQSFNoZVdleUJYaGVKQ0J4OUlHNkdGcUZqandta2ZvSVJ1?=
 =?utf-8?B?cEZxbkFzRHh4MVF4R2VzZTl4RXRER1RCbVJjTXFkYjh3RzhkVVkySUUrR2th?=
 =?utf-8?B?QkxWdTlyYmk1dzg5Y2JWWWJnVDZrSFhwMUV1eElJd0pyd2NBdXpwTU5FR002?=
 =?utf-8?B?OTNXVXB6dFcyZWprSnEvN0pmbFVXbHBUSVdHSXdzeVZyQnZhY1R4S2JyZEIv?=
 =?utf-8?B?YjJVQ0Z3UERjU21Zb0xsUGlQZTg3M21LSkdDSXJhOWNHTExKc3p4empWQzZL?=
 =?utf-8?B?MVVhdGk3MUhQTEVHZGxUTjdBUTZ6VXljemdHUWFVZjNDa3NVd2pnWWVXaFQw?=
 =?utf-8?B?Sys2MSthV0c0VnVydVBnQkhKaEFvMkFPZmRhWHY1OGRNeTc0MEdEQ3hhdEM0?=
 =?utf-8?B?WFcvV3lnRlQwT2dNRGhaNFU0aVBTTldUTG9TbDYyNFJraFBZaVBQTTNvayt1?=
 =?utf-8?B?SnlMSW51SkcrRnJBQTlzRWM4KzBJdjVZQnFLKzlhRnlQc3gyODdnN21ya1kx?=
 =?utf-8?B?VHBUNXBDM2djYXRyYzBjWHQrYTM5VEQzWVdFWHVCYzQ0emRNMTRVRjltQlFO?=
 =?utf-8?B?V0FGdER2N0VEZEMyNCtQOHkySk0wczA3d0FGdkZWYWhRUzFjelZJZE5YV0h6?=
 =?utf-8?Q?isaJ98oD21KGtcTo=3D?=
X-Exchange-RoutingPolicyChecked: MgLbM4wE6RR9MXHd6K1xUD68m2iIbZqYr9fJDK/pTb0XL+Cuba59hRqlgbSBGFE6EyklovDWQktDA2JYQNzly/ocN/4A4lJD0cgGq2pTLIerKAqHLselsigV6AgFW6areePsMRNaMZii0XB0d3cRD1pVMskeHTu/11v/eLTePIYWGg3Gwj1hw5T06rxek0Ez2Uk4n4VvnlududNkgxn3+wlenJlS+0VbduNoHmGnkp16hbHIYN23eXj0ZQVTen1se13kR0fcsPwmjIkhHMgSEI2a4rdYkrfPG/9j1T+adIkogDY+kvIHnqxAZJW1fpu2Fb/jFZAuf1OBFkIoN+zReQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e8b511-f096-4dc8-6667-08df2ac82e87
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:25:37.4473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NaZZv2kYhEQ1Ypzzro/xVxyF4mfZBQ35e46B7kWNIWGhnw0hraA42L2jAFINYtWxvj1tHoYKjWWFRxIkiO2A/KxXOPWcVh8NPET8fDdaSXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6168
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

On 10/15/2026 9:02 AM, Anatoly Burakov wrote:
> When parsing RAW items, we iterate over previously parsed RAW items. They
> are sized by an enum, but we should not be using an enum for indexing and
> comparing it against an uint8_t RAW ID. Fix it by using uint8_t instead.
>
> Fixes: c8f6ee59ffe6 ("net/i40e: reimplement FDIR parser")
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/i40e/i40e_flow_fdir.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/intel/i40e/i40e_flow_fdir.c b/drivers/net/intel/i40e/i40e_flow_fdir.c
> index cd377b218b..55997295ed 100644
> --- a/drivers/net/intel/i40e/i40e_flow_fdir.c
> +++ b/drivers/net/intel/i40e/i40e_flow_fdir.c
> @@ -799,7 +799,7 @@ i40e_fdir_node_raw_validate(const void *ctx, const struct rte_flow_item *item,
>   	const struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
>   	const struct rte_flow_item_raw *raw_spec = item->spec;
>   	const struct rte_flow_item_raw *raw_mask = item->mask;
> -	enum i40e_flxpld_layer_idx raw_id = fdir_filter->input.flow_ext.raw_id;
> +	uint8_t raw_id = fdir_filter->input.flow_ext.raw_id;
>   	size_t spec_size, spec_offset;
>   	size_t total_size, i;
>   	size_t new_src_offset;
> @@ -932,7 +932,7 @@ i40e_fdir_node_raw_process(void *ctx,
>   	struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
>   	const struct rte_flow_item_raw *raw_spec = item->spec;
>   	const struct rte_flow_item_raw *raw_mask = item->mask;
> -	enum i40e_flxpld_layer_idx raw_id = fdir_filter->input.flow_ext.raw_id;
> +	uint8_t raw_id = fdir_filter->input.flow_ext.raw_id;
>   	enum i40e_flxpld_layer_idx layer_idx = fdir_filter->input.flow_ext.layer_idx;
>   	struct i40e_fdir_flex_pit *flex_pit;
>   	size_t spec_size, spec_offset, i;

-- 
Regards,
Vladimir

