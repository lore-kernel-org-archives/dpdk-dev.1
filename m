Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2930ACCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 12:04:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E83340698;
	Wed, 12 Nov 2025 13:04:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 74A2340281;
 Wed, 12 Nov 2025 13:04:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762949060; x=1794485060;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Zlb3sPoC9Pn8OH85f7jy9Ngw/64HZwiioDQv2fAl4yU=;
 b=NhHmk30s4AN86nhrOhjIUXxaZO05UhLibrm/f8DU5KvvkGLhrZLx5ZM9
 xFgZn5iz/MS0WqfC5r4I6a0c2+V31yY6+5iLTovZfIt31yuI0cTpnaIa8
 22Qae04Vu171Eq9EcMCiE0JmoXuWVfFZZgx/DjTxnH0tuawMa5a7IH7Ml
 wvnRooseFWl0ptpyHEjyd+CAba0xCNjEfk5gxxXSsxNI6dZck2bSpOguW
 D1pbWS+5Ivbh2+QROHK7/R2MoRFXj8CF50ee6gleVK7YgT1y5tL5wyOxF
 8QsALlHA2rRX7kRWi7JZFLH3wCT3RNMFMfxHDnMEUNl8dpssqfKimSzhc A==;
X-CSE-ConnectionGUID: uu5/WVCSR0ux5uNkfNvHvg==
X-CSE-MsgGUID: eGM1MOUlRbODU/EzfgQPfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="75316193"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="75316193"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 04:04:19 -0800
X-CSE-ConnectionGUID: +0m7h+xnTECQCZw/jXUbrA==
X-CSE-MsgGUID: fJME2fHYTMCly51q/4P9Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="194394617"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 04:04:20 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 04:04:19 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 04:04:19 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 04:04:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAkiYhrGDqDlJyTEIIr+Qd9ib/NKGQMTkr0PdW7USrsl79EUnmMrWq2xHocra0HQHSz8EYUM2oBJhKc6FRjECb16McdDphTdEh3B+kqso7WXSodtPF0WKcveBEFAvfIXxQobH+tOPluEVaTCtWAShh1HODqRr5F9mtF99md3bTPdYfQSf1kGCxrAISNN29mYNgzHeRv0gV2GwylPDkFtK/CyR6mRAps2+icFt8sKvSnf0bErrpuwpaqrhwFZa8CXK4EOxnzkH0REJq8/zP/gbZbmW5mIVcYL2VmHIxH+3tOCGTj/xryE7vgXgzPslUY1K5lKp2nJ7KTMENVGwrjtpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4i2pQnyfTcH+tTgYp2orRwXZKMlAie83dEQLoYSue4=;
 b=ZjmOy4YO4AfhswaQ6SvByiyyLKSaVb6v905dHwiTVW5z8p/TOFsrpf++d7qQcnawU9xgC+fQC9Hyn3ckCtklVLQvakHqOT5GuayrOvgmXOiD3MDZrGuZThvUU8vxu7CAF3MwNVaHh26Xq8Yw8xJL7zqLlb+YGsjseM5MP+eIH/Vhs8Y4VNPZX60BJAzzdcwLluVO4ZIQv34KgUBALoV2WqJFTt1NC0Re0Tn9j8n78vGWFy3hNYpj035vQpiownSauFIAoxHeoJMbYnO/oyU14NX5QsZS6L9Ugzs8qF1t4Fo0NDuoi8NqnKtyN1XtZKGU8ZGSdFXbT4/UGnjyxaqUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 12:04:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 12:04:16 +0000
Date: Wed, 12 Nov 2025 12:04:11 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Zhichao Zeng <zhichaox.zeng@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Jeff Guo <jia.guo@intel.com>, Ferruh Yigit
 <ferruh.yigit@amd.com>, Wenzhuo Lu <wenzhuo.lu@intel.com>
Subject: Re: [PATCH v2] net/ice: fix statistics read error
Message-ID: <aRR3u0Ady0ZbUbIn@bricha3-mobl1.ger.corp.intel.com>
References: <20251107074338.957352-1-zhichaox.zeng@intel.com>
 <20251110080514.2506769-1-zhichaox.zeng@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251110080514.2506769-1-zhichaox.zeng@intel.com>
X-ClientProxiedBy: DB3PR06CA0006.eurprd06.prod.outlook.com (2603:10a6:8:1::19)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a99927e-d13c-4689-42a2-08de21e39a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zkhyKYxB1YhTSiIM4saSAuhXS9MEyrBDX8imURJntOlCWWdvdShfUnsHmDMS?=
 =?us-ascii?Q?BmKTn0zmuNqQghV7ECTh5nrqt/kQpABkv8RdUBCnbHxvukNVreT7AJ/jO3vp?=
 =?us-ascii?Q?C1CzpdJWnD9NOHktIpPmvAyeNxfw1SeIQ+3F42yWPcaD+npQ4OTXEFePvMuZ?=
 =?us-ascii?Q?20WPpuX/TrvHYf0PTBdUF7Y1J8Q6BYCLyc3WLgencmAnO4OwIFNj7XeecqGt?=
 =?us-ascii?Q?szzYg/DFToWqp2vxiL6N8gb9tQu13QQezuOVwsyP7LuIaVBPHeRD3Rkz4lvu?=
 =?us-ascii?Q?K0bQeUUAFNCzvW+Dqn2k7CZpgLfiR8OVLSlXcj1Uc80J6QjHFXFnh4nxxHr6?=
 =?us-ascii?Q?pCln+TMotKFdF2odYTB+qjZp+yCLJIgct7ULxcnEXQ/33LvkNde7lfhbb1eZ?=
 =?us-ascii?Q?FcC8+QIXkwmrq28vgaNLWRhi5mN6C6+nySO8bSwOBN2tn9N3lE+69Z/mjjJy?=
 =?us-ascii?Q?Dlz7I4FfhpzcJmGzvwinO9754rNhFI/Nsw9CjPpLCregEXBWoqC/wjDJMsOs?=
 =?us-ascii?Q?uKmhnzQWJmvSjcdV/D1DmozlHgUWlauuNpLNLVS8Hhqz0iWn3Oaw32zFNJ8W?=
 =?us-ascii?Q?22e1GCdt2GJ+ldCVaOZQ1qK2vxIdn3TnzFORUUbQmkbXDJOkefdJgC9wZz2P?=
 =?us-ascii?Q?xF2Jg12e1tWeLRt6CfjjIPc2QOzl/5KywS2CC7ZxTT+6PSUqqFHVgSUbSyS+?=
 =?us-ascii?Q?uoZkujw54KwwxxXFf3BduXzDLy8wN0UYW+mDR0aN0pYhnxKwlSkYrUvtSncF?=
 =?us-ascii?Q?9Cxzd4MNG1DlqFpHxPsLeoKUbbyB1pRLmwCw4f9WHdNnL4CcOBN3rHX6K0mJ?=
 =?us-ascii?Q?A8VvLB9Q10VeGO9uq3OOYtUXaSrM2HOvN6bhscIxrvuND3Dgcpi0EJ1QCOqi?=
 =?us-ascii?Q?ReqGJD6tDNCW1QCBJj1nJSPtIPnlRxb34EMmHE2UlFNlSgJKwC+TN9TBgb4x?=
 =?us-ascii?Q?E37RbySRJtTW+6k7XCJSNOeIVU4GrcVmBIeZ4BI/TxiOJo5qPV+knewOeeVq?=
 =?us-ascii?Q?d2ZaEuE1nPWPNY9Z6fUu+ECrfMMbt1qgAfapnNzTaRD7q7Ys2kDg/ap9CQVQ?=
 =?us-ascii?Q?qYoUSZIz9pJ7a4GAuTgKjdzX8KZYoLkdFTzqqBPgS/7oenCt2VdwriwQqrQZ?=
 =?us-ascii?Q?FpvjKoymlex5zGeHWAJP5ZOVOPpus76e8M2vvt/GLmpVqriY+GLhyMgRifjj?=
 =?us-ascii?Q?VmPzDulBoUKXb6CSw01alEQ9BbKH7n8OtOsTBEU2yuCDS1sx5qvfjp5NsmoL?=
 =?us-ascii?Q?neVNpI0r4Ogre2heBI54hJMDld0Om+323Q7o+ZmU5v8YUvwf8rV1HhijOPfM?=
 =?us-ascii?Q?cSFuxeXQNinM+WiuW+mFmQ4HmwisCyJAEReylbinklUAGzGBXcR6fdd8l6u0?=
 =?us-ascii?Q?ihv87/0QcGnZm3TYwkOybVqV0X7lzoEWsyOWYKHDx3hXlV99KzTEQaNs/MeO?=
 =?us-ascii?Q?UIKIGRxI1eGYRRPT+oc5fnFRY+aKsfH2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7RH/E0YHJ3L5FaKUu5heOHEY91dTpKSqx9eEKqPzgaVLuJy1OgRVKxeDa5Vb?=
 =?us-ascii?Q?XMOtUoTopqKRnqMYMphUDwqMnvzdrIHvwXl0tlxy6iSDTCdjAP+c2UIZLIBJ?=
 =?us-ascii?Q?bx8iOmDdQ2aQRBOqpsx7/WqsGPEXsh+Tqqr4DhUJbIRWYYUU9uQFD6a7xYPD?=
 =?us-ascii?Q?TVkIxYJNSkuij0aHj0ZbNBAWpCCBaP8nlEZ7ln9RqxkGXPUftUVV72Iiw+iy?=
 =?us-ascii?Q?U3a6ua+GjqFeSGCpYLAS0e9cNfuI95dXsVAqLyv0TrRvzhKTo0t5WHYx/uJ0?=
 =?us-ascii?Q?iJLS4ffVAZU6iDkSwfRhDO2oYKJ1Yn2+olIy/37oshJSLDhLYur20aOfuy0k?=
 =?us-ascii?Q?DcQMBpfao9Q9La2msdUqLOo7bJBfGcoSBrGHMYRCWJEoyhJ89DPQizE7OzTV?=
 =?us-ascii?Q?/gRAL/q4b+yy629TbOwkj8xPjt33wkT4mdqQB8aWYe5DONIfpbWLBuRbLmQe?=
 =?us-ascii?Q?T6oJ7jDMJ3FFPo1VDOPQk1jPUsqHllg/M4hQ2FM9acj1pXw62MXR4xDIAKkO?=
 =?us-ascii?Q?OBpdX+pPKJw+JGDR4q9pg24nS8XftZzsCISiOhyILu3tocSoV1MAb8+fIjPB?=
 =?us-ascii?Q?si/7qmYTqtHz9SXZv+OEW9pxXo7ufGE+twOJUgxeHg8UOpBpberx9sEDv8dS?=
 =?us-ascii?Q?0XO9bP2AYHuEPIHxc0y46+K/5JXxqCKQiCt9ypRBtOmhKLPADIxhMbfTK7AZ?=
 =?us-ascii?Q?/LG7jfJsjPe/jCzmYkpM6clPiEG32Jh+eW5gW14FgEO+5mRchk62kP+i3IXW?=
 =?us-ascii?Q?vnbptaKsbtUbxg5SSY8R6TCEsGVkJAgg2Jbrr2ceMbg6SH9NZDlSVfmcpeVn?=
 =?us-ascii?Q?yTMJdqX8FKGp1eylopt+iJ2N21UxDFz+poTopCF3nboCjEOVvvd2pwNAQWSk?=
 =?us-ascii?Q?h71upj+vo1KWOwiktg1wW5JQjsOIwK64J5cbLzv3iGU9yeNejQN2zGZ+J+bA?=
 =?us-ascii?Q?Al3NMTIfYXOsgx7wAhUOYBFScVnAj4zUEFlgo5Fs7nW6n4TpTApphYChLE8Y?=
 =?us-ascii?Q?H8fbtDgDiC3jFM046vz5fLJfkWjB49Eg/0pLO7ELDHXa1g57YEtAKme6nUxE?=
 =?us-ascii?Q?6fRS+JVIWUxubBYHSLfg/8TKQXpuL8JxZ2rre6EXyNE/xN8Yfjd8FttdSrlb?=
 =?us-ascii?Q?98nHlhISOFWpPoceD+4LlxwLMsFHhfINMaF1KDn3ZN0PACYWf6BEQPUhxE5S?=
 =?us-ascii?Q?x3hxtn13dRZ429LCVcL7FAMAdn+92fMIQKgLb1wbNhJeKYSYjmhZhRb7rMha?=
 =?us-ascii?Q?ui7mUCMbdTOkiMxxKVfuB/LozBFqrV9EN+xtnP0tlc96t7H4k3JkHUE/1WFp?=
 =?us-ascii?Q?ncrB9Xs4w91MLHBgW4XVi02MuUNKfBYb+7xaLZ2YfEnGJA/cPDzOcskqAWYx?=
 =?us-ascii?Q?4dVPJ+Xgc2IMg7VTlP5EU0JkF5Xg7MBOA1jJoGmJRLX37O2nEMXnO1ft18sR?=
 =?us-ascii?Q?Er2ParUbSzSb8J0T2cPwCsQF4V9c80hZsjTsKeIVqwC4KGAbGm6kvB16nXux?=
 =?us-ascii?Q?IfLLXQbYxPwwF8eYdFSONu3uXikHPVorrYftm+QdmJXUnK9dyrk+xHIE3hVv?=
 =?us-ascii?Q?ihZ5cdlFrlAY08fuxURMY3S8tfP5P4czlKuJI5Dk5VuCupl0Nv0Q16xHY0nR?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a99927e-d13c-4689-42a2-08de21e39a43
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 12:04:16.5154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xe/L0y/Exdc/5pY0PA9E4FLSBvRS1hNCrsmCJRdvpP+DGH1tmxFFq0wlYQWqIE3D8ljt2kd663Muhk4DKyXdKnETEUS43JexZDSF1DDG+Vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6733
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

On Mon, Nov 10, 2025 at 04:05:14PM +0800, Zhichao Zeng wrote:
> The statistics contain 40 bits. The lower 32 bits are read first, followed
> by the upper 8 bits.
> 
> In some cases, after reading the lower 32 bits, a carry occurs from
> the lower bits, which causes the final statistics to be incorrect.
> 
> This commit fixes this issue.
> 
> Fixes: a37bde56314d ("net/ice: support statistics")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zhichao Zeng <zhichaox.zeng@intel.com>
> 
> ---
> v2: replace single retries with loops
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 4669eba7c7..016b25c63a 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -6351,10 +6351,16 @@ ice_stat_update_40(struct ice_hw *hw,
>  		   uint64_t *stat)
>  {
>  	uint64_t new_data;
> +	uint32_t lo_old, hi, lo;
>  
> -	new_data = (uint64_t)ICE_READ_REG(hw, loreg);
> -	new_data |= (uint64_t)(ICE_READ_REG(hw, hireg) & ICE_8_BIT_MASK) <<
> -		    ICE_32_BIT_WIDTH;
> +	do {
> +		lo_old = ICE_READ_REG(hw, loreg);
> +		hi = ICE_READ_REG(hw, hireg);
> +		lo = ICE_READ_REG(hw, loreg);
> +	} while (lo_old > lo);
> +
> +	new_data = (uint64_t)lo;
> +	new_data |= (uint64_t)(hi & ICE_8_BIT_MASK) << ICE_32_BIT_WIDTH;
>  
>  	if (!offset_loaded)
>  		*offset = new_data;
> @@ -6363,10 +6369,8 @@ ice_stat_update_40(struct ice_hw *hw,
>  		*stat = new_data - *offset;
>  	else
>  		*stat = (uint64_t)((new_data +
> -				    ((uint64_t)1 << ICE_40_BIT_WIDTH)) -
> -				   *offset);
> -
> -	*stat &= ICE_40_BIT_MASK;
> +					((uint64_t)1 << ICE_32_BIT_WIDTH))
> +				   - *offset);

This part wasn't in v1, was it? It looks wrong to me, and the original code
looks correct. Given that offset and new_data should both be 40-bit
quantities, any wraparound would be at 40-bits rather than 32-bits no? Can
you explain why we would use a 32-bit shift here?

>  }
>  
>  /**
> -- 
> 2.34.1
> 
