Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4EAF54ACF
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:20:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E62C2406BB;
	Tue, 24 Mar 2026 17:20:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id CEEAF4025F;
 Tue, 24 Mar 2026 17:20:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774369224; x=1805905224;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5SMmHLqTVsd8TX8ZopUudoZPczbHC410wCrAgWgYnBI=;
 b=GmYX6vMMV9w9wvOkMKJ6iRRah6OjLxtAxR6GFDj1b2hnU4zXWdhxhZO0
 c6MFhKBgK8TkHT8uvO0LZeO/4KYSyzuapTLqG1AmYW8b5Mcx4BLQqVXXT
 VBAcA2nhUJqam25pZvDcGiQCcN8z4EgkWs+Ol+nwuwUpI1P3sDzL6T/G2
 8uypvFNddF7T/OM0ve+JmNPXWwgjMfy5bPJvwAzdU409zfYAN90o/OQdJ
 2gmlX49ZmO+S/vMdr5Hy6rMwcKf2IBNT0aSc6MzboS4sU2rhF+8EGf95E
 y1RK4Oq+HqZze4mS54UC2R1SYBAXdkKmiZbIOqj1y38Mc5DCjYenn5Gy1 g==;
X-CSE-ConnectionGUID: sjWY1FI3QoC1aWOC7q0wCg==
X-CSE-MsgGUID: utKGgWM4ThWf5dyCoc1zKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="74574520"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="74574520"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 09:20:17 -0700
X-CSE-ConnectionGUID: L29VAfgJR2OUyfKBlVhy2w==
X-CSE-MsgGUID: iOSeWWtbTW6CFdT/Thv3PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="219530481"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 09:20:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 09:20:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 09:20:16 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.55)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 09:20:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/babDUNGmrT2pt/nvAqMsfym/tji8BXbN8tUOuKLIrMumWQoBR/utSM6YXgg9CmCUjxi+EBW00ia7pLppa/DOir9zyCWZKYd3nuS7Vqyhn2ku2GSU28vEbBrKRtYEmvmTwgu1++eJHBtyA5/I4B7qTWtusZdLS396p1Jv38e6sdfFgkYV0oILJSyx2Kgi8K7f2dmPnilAaKOl+a5nfFTW1w44KyjpT7RFWFWUY4wUtfCZDkbDlvVuAht2GZJTXfF+P5gfjwOnsRNzvkiNGM2EAcE1xGadR+xesnVHqdsnrIHBkhbgy4ekstaXOyf1f0RcYBrvYr83u2b22OsRkbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMmU1RsJSDiTNwlGRgZTVNCypCVm+qovlyWTKGNimLU=;
 b=jPCOyC3yXaPmg3pHwv9A1yjn7OMkh8RMUsz6GispO3dJjeH01qWmMgLutE0SqSc5f+/4wOC/O9vZ9L9W98VozFxHZfpd9HxvIytwI6bgGhzweaCKvMT0IEFTPjXF8qw+G74IGa1LmitggvGxSYSOMJ/B8KyYzFco0p8uFrsqRv247yvxdsasgkvRb1WeKiA95v5qY3dyM3HPdSXgU+WVETvQSmkj6NbkQR86YKUiOrjy8E488Nbnn2h1aCU5TPM2AAS0xRN8xkWmFydZMe8LF6Ujcy9IJegB1iprs/3Bnygbnf9+Ps4mCC3S47lFlKHWDXLny7D/NvjVahqb/p8OBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB5232.namprd11.prod.outlook.com (2603:10b6:5:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 16:20:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 16:20:13 +0000
Date: Tue, 24 Mar 2026 16:20:08 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/i40e: fix raw flow item validation
Message-ID: <acK5uJTAJQRgcxIO@bricha3-mobl1.ger.corp.intel.com>
References: <20260324155627.1849904-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260324155627.1849904-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0074.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB5232:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9c509e-f6a2-45e2-61c3-08de89c13a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: yRX8EefSsXkJ/HcV7ZpKDynZaoCroSUE89/iSX0xH6Due8oDyZQdIKpYCVVEtVxMXSKNag1TtNQBH0XNcHncHMxoHNg5gfXwQpdvxMOC6E5Qo5dNMcprMHdxMsktb7dz5b2RJm8tYG1h9d7kwJsGDFtjuNjGD1kJSSn68XZbZbmb6/Jli02iaSPf/EFsHASSmR05X4BMepi2HMXVvoU2+9J+AH9MH+DB7NFWZ15SYyqvvTnqMsn8iySXQrc60WfMbDLbdWY7ul576mUrtUN41ydkRQuO7K6kiMh8CxkqkiwgCJabQfJBj495ItiSrMFzg9ZlftaX70+8DVSoAk/wumMDSwVoZ+DFv0bLwRGpWasHF88cdBrS5kTf7qK3OyGXCMIwZGVkFDQW8wfaqbo1P3+XR3hq0l8z/Rq9teNqyUjP0d6D5TvzsPUU+1S+6UZ3iz0h40hHkwkDWLlD0su8K9sGPaZopHRCDai2nwu4Zr1M5PEnPml1bFfQkKSfSxaC0Z9308osEF3u6KUcCukzx31BnSGHy/hlFquDgHO6xmx8HwgZQ4wIJlwuwnKEfa13xJ+4mEsCzD6aT7Gd3Xaw9KE6PivT6eMuYaAwWjNdStXarEbAMTnn1eltSTkxVI753Jl4GMx8GM9fW1gbiJp50lwJqTjyuzZzk8LvAa33Iz5xb6Q5ChVISGbnZjFcCQuWA4uAOFaSNL5egFFSePXy2hnLtttsr00h2UtzlPyiyqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FlsQZc2yfC51KLRm4xZjzrn+uT2tDVav6k5qVbivzbf/fuyzowJO0KN7Zjs2?=
 =?us-ascii?Q?0ghNyQfbkhyAwdlsqiYUsNML3d7qtyt05BgsohQFiAf+crqHpQhlESSknYFs?=
 =?us-ascii?Q?hgK4+rsDM3/0t4o6ukJBH45newNtxKUPd+Okqgs+uy1s70Muo93NgIbv9aGP?=
 =?us-ascii?Q?7tDZrAGdMeKDIqOCx+YL2Kjpqn3n8poG/Y6lO1D80U5HRw+0U9zwMQZAWNby?=
 =?us-ascii?Q?glzEI2T6Gq7YvgT/n6KRvccCkTg7PFhioPmkSWuW5T4BxvbPpocBJpdvlFv9?=
 =?us-ascii?Q?IQ0pEBkP+n/nub4ybpjarRfbomJoAMRM7sLlUrG8DWfUdOVh9H7JRgH9163C?=
 =?us-ascii?Q?UK/4IFQn0xNVNSpfIA314AuPW+Cllmfng+zHPHsQWLaZAigyyjM+Rq0ybak+?=
 =?us-ascii?Q?CLSNM96/otRB1T6JkI6h+s9hVL+iak4pW/OWVuFbTbeT5TTnE2nyrl0Qwx9F?=
 =?us-ascii?Q?6/XDv4QnehTK3XCY/r9jJuv6n/d6jKK5RPaMwEHL3Ap2UqtDAkbKgQrLbt6i?=
 =?us-ascii?Q?gSVLoJ+Lgv57diwJ++V96/4xJ1pzyhKNxvtXIyeXjcRCkEkkbu2QJQ6MhrqG?=
 =?us-ascii?Q?Hf1maC1gWyP9GLwglEWglWQi5ksMYYm2Bo2tBbvym4SsDT5WCjjqSd2coff1?=
 =?us-ascii?Q?cxQURuR+wgN+/4ZFsW6EHo5uxMVKDCOsSPmj/lmX9PrCAQZwehN5PvmwBqjO?=
 =?us-ascii?Q?IO4J6SxHHuQV4mooIrmLoo4c5XL3hs4Dk7/YIimz68x8Rc4YOB46E9kcj3EU?=
 =?us-ascii?Q?gexBswWvNfle+ozhHcLful67z9A1JrKr3O5w9gC298Cs02he5eXLH0h3d2Zd?=
 =?us-ascii?Q?4twrekWBdz3bsRcPjQa0KTYnXqUaluPdg9RMVwd66hMaNWrf8uYftFCKo5Qp?=
 =?us-ascii?Q?s3opLMpwskq5DeqCwPpt52JJ1pijXIgYZH6wZvL3uER85mDZ2n4CD1vnoJrA?=
 =?us-ascii?Q?XfAQLElYuFm4h0K3N/3oyzDcxYB9zBNfZix0/W4j/IsP/yklxiNkgWmnOuBs?=
 =?us-ascii?Q?4oGzKkpIhLUXYkM/25G6cZ6DBIWYfNqhdTCBrTs/ijEGWLWdyu1ZuMBqicbI?=
 =?us-ascii?Q?rZEzUqkLMO3DKkjT12DNo3v3pUgf0di1i41dSNDgw/tmHFtgIUs/5R2LXQF+?=
 =?us-ascii?Q?PBskMpRNy+0OE/ycIPrANFxwLPw6928Qwz62iRqfjy1EnwfKfarW+i7N3KKP?=
 =?us-ascii?Q?NUs+ORsr0cFQYdG3cL8ili5ytAMceBMHp+Z+rb1QJ8FWWjZMJ+XNi+50vF5A?=
 =?us-ascii?Q?xJwzT/g4ZrGp6lrFXxO7DTlk824t7jFoBG69QAcjrsbOw+0GQaDfYRU2xaLm?=
 =?us-ascii?Q?1YWS1XeXO8bwVfb8MuMt0OCKvl/OLEVSUY+n/npAsCr4HQA5CaPlwKr7TSoL?=
 =?us-ascii?Q?wtLIy2pp25JW946bMJr5YN9vkM72vmvxRQF9At89OZGItbIwHbCqs6p02vC5?=
 =?us-ascii?Q?oTpJFR4feYoBfZfAd6e9HyC7yXdACBQxaGsZ+zPplkAPbgxyKD3WdKwJOVfi?=
 =?us-ascii?Q?zMBkYPtZ0LcoU/JR4YofEfo7ukkDKfxa7+TkPpT9MANm7el3jRElhhp9Sfh4?=
 =?us-ascii?Q?nmm/25ROGvRy20aVC3nEylQfsRiC7Yi5zbSU59MI6DCeFBlh/eA0oOk/T5M2?=
 =?us-ascii?Q?RjRT+kINe3mXJLRtOnMrPz6zl5RWnb95XJxAFeFPOJJuqG4gRmBP6NBrhI8i?=
 =?us-ascii?Q?Ya/HfGSC6zJC03BonXHjq16WHWyfFDn5cGz0O47Md5bs0+aVt5/oEoLkFMvg?=
 =?us-ascii?Q?sR3eF9EZiRO6FSFtEpa5t7mwb4Y5Jxk=3D?=
X-Exchange-RoutingPolicyChecked: SOSXXzKy0Fa1Ggbo3UNmWapKarEcFNB9oIPl7QJ0gTupyWCxYqU+k2Sjm5THKhfUd9Gsbrwd9u70/QQMPPO/EZzYyRg7NrIf8tx778UptNOK/5tbUuoSpX8WX+kSh7Xz6pX5iBWjhX0ntW3F3sx1echA9OF2WXstZoAdCDzXMCQa4tPSYch+qSUQaVq4QW3bAUcIMUR14gJ+qxiD0JJuegfaPfHHLUL2PmEX/UwmWXcMalb0EInq4L8W9y+AdLoWSuGlKr5zEHh7aWaFO33AI9+H6iTzAHLwBudGDvRcw9g2GiY+VE+oM++ae1jI8WGQNCegJwlQMDk+LwNGIz5o7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9c509e-f6a2-45e2-61c3-08de89c13a4a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 16:20:13.6347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEr3QY0LI2zG9xdMl3K8VSOD6O2h3HNjQX7eNLq7a5qNYBzBkM9H7UinTcRwe2dh9FIXhp44vUyOJBDYmwoFsm4M5fiFdCc1UAzV/Dsqqrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5232
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

On Tue, Mar 24, 2026 at 03:56:27PM +0000, Ciara Loftus wrote:
> Commit c138a6c3bd0a ("net/i40e: validate raw flow items before
> dereferencing") rejected raw flow items when spec and mask length
> fields differ, intending to prevent out-of-bounds pattern access.
> 
> This breaks flows using the default rte_flow_item_raw_mask, which
> sets mask.length to 0xffff regardless of the spec pattern size. Remove
> the erroneous check.
> 
> Fixes: c138a6c3bd0a ("net/i40e: validate raw flow items before dereferencing")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_flow.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
> index 84cfddb92d..78191a2d22 100644
> --- a/drivers/net/intel/i40e/i40e_flow.c
> +++ b/drivers/net/intel/i40e/i40e_flow.c
> @@ -2360,13 +2360,6 @@ i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
>  							   "NULL RAW mask pattern");
>  					return -rte_errno;
>  				}
> -				if (raw_spec->length != raw_mask->length) {
> -					rte_flow_error_set(error, EINVAL,
> -							   RTE_FLOW_ERROR_TYPE_ITEM,
> -							   item,
> -							   "RAW spec and mask length mismatch");
> -					return -rte_errno;
> -				}
>  			}

This looks a correct check to have. Maybe we need to check how the default
mask is generated for this case and fix things there?

>  
>  			for (i = 0; i < raw_spec->length; i++) {
> -- 
> 2.43.0
> 
