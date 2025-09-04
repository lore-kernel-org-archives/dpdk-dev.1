Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14C7CA1013
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 16:47:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD9414278F;
	Thu,  4 Sep 2025 18:47:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id ABDF240275
 for <dev@dpdk.org>; Thu,  4 Sep 2025 18:47:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757004435; x=1788540435;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=XikGcKBeqFUm8MtvtL3rWEtje4hksfEcNouZjFiQ/R4=;
 b=cGcOnn1gJMzsAmeU5wC4h0Voj9AzPtUaw9VdRFh3XTxKl9v2ocwJkU7s
 juXFvY4KKz9x1xrxfEB7SnGM2pUsRWfiquifWN8AhGMBhJ8jPVjwcyoqM
 cTc3Y2BbNozGvHVApYtEAXrWu8M4Dypyh04XNkWdfDXMxOfAQTWMNXNAH
 P4DXsyFY+ewtPcSzyg5PKwX0RSmOtnB7ha523ZyO9VAdjSOQG+su3RYZP
 GgIhhHA8SOrLvZOecokmbL3c5ySiCWlxwP0UFW6Gpcy3+pEw6MxydN/I2
 tWxGib6/lSP1L/QDKjL9p8IivwCC+cxjQDOZ8vY00dvnDkh8SJIo1xkGL Q==;
X-CSE-ConnectionGUID: KRGcgxrpQj+BXAbsNiRjMw==
X-CSE-MsgGUID: eSExKqRmTZa5sARcAeWAxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="58564015"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="58564015"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 09:47:14 -0700
X-CSE-ConnectionGUID: ww3cXWo0QXq29UWbA2te/w==
X-CSE-MsgGUID: IjUQHSOYS8SdziTQBJES2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="202780878"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 09:47:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:47:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 09:47:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.77) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:47:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Udh9kWLXfElVIDl0a5ZHv12ArZ0YtlG/u+2+mWRebbD/IIM+fHdbLSSOuK+n9phh8gPZnK0Rrl7FjVni14fO+EI306nZ7o9K2UU79clwPDBoFWbUJwEaGSnZQpnKotbnQ1IMSwuBF76kGoQXHx1glTB8ln9x9kK4HN1vXAum1oo/7XoNkyW306Cs0YVly5BSgosw12x5JJSakt9AhjuwNoRvwqWMGv5R0vqpqvQyfZrHDtw5746evbFXdUtA6wo0+ZQnBG1PVSwUQVEorUC5Oaud9kPXaCInmFHrQGlLmMeSdmwcR2LEpoP9lUrBVg5lIvIY5YqIFwhnj6kFZr6aUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxlX6Y+g1jOeJIeqShi+xY9YC3KFikoTJ6hb4v6dEkI=;
 b=DTRD93WeKxuakFx+7UQrjM2yiBMcqe7ziwTusFf4lRQn8kHxNedRDI3WEkZ3kFp8GHa3GnvzXcEL8lWYyIHxBBPAo1iyULyDCZg+gKKGDVi/HK3hsnpRNvY/Kt5ZjZnuBbqalNxS8rhq7ZM1+wp95QxVhjGSOP9dNTQq70dtLf3ohtdT4Vin2ph+a42L8OE/COZhEZW4Ehbx82ehBZevCw0JeKsty++RAUuylAmC9WQXlrzN8/hVOtpuYnRlT4F1TsbHOCZ9bZngQQjjwCUUEA5pds8gKeo5jVejQGidZ2wiBvAVtL8KSHnsdE+BLAjWjAbep9Jzqge9WZO1A2346Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB7049.namprd11.prod.outlook.com (2603:10b6:510:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 16:47:10 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 16:47:10 +0000
Date: Thu, 4 Sep 2025 17:47:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 3/4] net/i40e: remove redundant vector Rx queue setup
 code
Message-ID: <aLnCiWRjP2Blkswj@bricha3-mobl1.ger.corp.intel.com>
References: <20250901095953.1858938-1-ciara.loftus@intel.com>
 <20250902104859.2100141-1-ciara.loftus@intel.com>
 <20250902104859.2100141-4-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250902104859.2100141-4-ciara.loftus@intel.com>
X-ClientProxiedBy: DB7PR05CA0011.eurprd05.prod.outlook.com
 (2603:10a6:10:36::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7f6a8a-5c4d-4074-0b79-08ddebd2b101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dSHuR5bTBDbvLXOJrZQy/U+8+MuHeClvVWFme3EtqkJkNpQGwQLjm3gFA4zv?=
 =?us-ascii?Q?3+eEbLTwvBP6EJVcg/+mi7O3VIk4+qvmdH/B6rLE+EHlw1e+BTR3jYCfrZsV?=
 =?us-ascii?Q?ufAm5VLUiJi7rGZKZ8ZeHMwYi0XY8+alfO/3jNixJi3Nv5MT3JWF7yjOuv7x?=
 =?us-ascii?Q?8df5W57lkVRNaIA/pmfN+vRbNTneMQgbaRNMidzkwh6x7xXYio9PvvEh81hK?=
 =?us-ascii?Q?P5e3sAB+m9xZSbiLZG1I5zWcXUGur59W+faHYa7b/1vCq0tVQ4uwzSkQLyPR?=
 =?us-ascii?Q?8KW0qeVT25GLtiV3u5uT7P1/Cb2xaVcgTrm4ybfHCzS+qgCIl2DUfMsJbgMK?=
 =?us-ascii?Q?xUoOx3bF2GaDZyAFHxtL8fqPzjHN325Vj4SgW8F47uj1Og2KyWorrJDeHnDr?=
 =?us-ascii?Q?UWvMprZJvkZMVZH3zJf4Ml38Mxcq1ko8PKNY207PFOKMoes/X24ybncgf708?=
 =?us-ascii?Q?PWQvn1jKzkhxYB+qQvNP0VlNkyjQEDUO7DD8q+g24KYE5PKdpUgrtnqSc3m4?=
 =?us-ascii?Q?L4Prt8ZFh/PeM+sx0tCrDQagJMMPWgu3z7wz/9rqD83rXUqoms5wfMJGcCIt?=
 =?us-ascii?Q?rhz1PNtwagn9udejQr7NwJov+3S1ZOyaaDqxEu8e5QnGAxcnZQotTJI/cWvs?=
 =?us-ascii?Q?Wfn4ijYyD2cQpgpButhBNSSWWJr/P2g9dV+70KM6/tOMnpH+BqYsQTtBUBXx?=
 =?us-ascii?Q?h6OnvZRL5Z9LrinA59tBgD8WoQ1+gX02sRqQV+SYNSjURT3j4p7dhz7GQKK1?=
 =?us-ascii?Q?d4c+1bBx1uj74CdOYBk939+Eqe0/Icjm6A4SHE1AXI6iIBXvXC3GfJ5FnRm3?=
 =?us-ascii?Q?uGrQwGU61TToUgdI72uXcCgnFpH1bSNB8g0RygUElOYleGaPjRTxPiyzrET8?=
 =?us-ascii?Q?hfjKeC6WEI6ftSXm4+Rh42Wmx6MwlkdMnDmyQ7B1ZTeYBywUV/Rg/JWSHlfw?=
 =?us-ascii?Q?n4R5mAIL6u/LSylqIQDEVqApnG8staTTuqjJN5hgtJCrfl2Lwh0Ld6igO8cK?=
 =?us-ascii?Q?bP9mqeb++T40QqhzeJ6vmiQA1O1DThJWdAUU77gY/FghRkjF7Ep5er5+iTfa?=
 =?us-ascii?Q?f9XnG7VHJlsnXWszgmZ1D1MFVXmltw01pR0u7T8xCEaafTzExozJW+WeqaNH?=
 =?us-ascii?Q?rqH9EVDbpBcnFIdsixtWBIUt5JCCSD6u3VqdVLTEb+20GYEdj8nC6KuNob6/?=
 =?us-ascii?Q?BO7XbB6/G7FE8rCBTW45mDknMs6tpmg8nX45ek6+B8p6xZ/kEF5KkgC3w7dq?=
 =?us-ascii?Q?2PHwz2/9MgHtr55nPwtpt4EcKEi6s1e6FhEjv+YA6UKPFmB9IVtexy6gZt2K?=
 =?us-ascii?Q?xTpgl4+1JGmc0eaeKxaDdlb1NVuIGyWPzSHpH2VSUbJIp11zYn9wx9maKWmn?=
 =?us-ascii?Q?1vhYcr5/JNvhLO15w74rgPTTKrqHjgQinFSg3rQOg451+uCRrw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FDK13MSJJdj0ncx57jEPpPfWzFaS/oMvzQpJ7+f/VBROTtdfVXuhPIKokWd9?=
 =?us-ascii?Q?uZhhXrqhIJdZXDzBYRtzWT52hSUu6jcYHYZ4vyG22bZO2xjijIqny2rX26Fv?=
 =?us-ascii?Q?Oxyb87a+gMs5RyspAJgBmVz3PbegW+r/60Ykj7O/pQf7Xy6VDHgfhCNxI1lX?=
 =?us-ascii?Q?qMTq/+2QNNdnjithFbVnHzxY558PsD+1UJEzVA9fYaACF4rZnrIbsA0rfnKq?=
 =?us-ascii?Q?lKUon/AXohP6xuITnKvTm7zmsey2IyGjVSC0Yh5gwQRCdqhFMYCLa6oiMn8F?=
 =?us-ascii?Q?lWSdvlWE3XyNeSGILU+MFwMiENWc/XzIJjODOr2adOmIm7xmZ70MsiHDnRk2?=
 =?us-ascii?Q?RopMRWFut8f28ViVC63zBGML1/Ww6vdNWHJTx3jBxpny9f5YoRdHZ+8FUoqw?=
 =?us-ascii?Q?4Vw8sbdLtp0HwsURpDBVqx0mPDTCL1WKzqiv943udstdsHuVK720cmgZnEAz?=
 =?us-ascii?Q?9X1lBURXMV/4afHLXVdAPfugg9qiy0STamqcdSvJ6AD/3xXrrg/PleYsUWgI?=
 =?us-ascii?Q?XD38EO5Uzn+4wGPhjfFTcrQmhxSsqqNoVSnkuem/ftKJfuWq6995R4kBWQEA?=
 =?us-ascii?Q?ZlW6LXxDwC2oTSFDsNKq00+aBxitxG3RMSPUE6a6oh0FhqqmlBN2HVnewVHN?=
 =?us-ascii?Q?3RPVOypmmuZ/hpkNCbzw0iPQmvVFyWhbtAHu0oZ9zrUAJT5ZO4wVlMjnQ6Vi?=
 =?us-ascii?Q?XNdQHQUQ4AUOcB0ZGKZsPkOU0CQOukjp6cNkqb0g7Lw5AaDptd/oDee8+1jp?=
 =?us-ascii?Q?DEgkuXJnNuqDss5oyT57Eo1w3OybTkKz29TmbDjxUNgXokoTLm+f9Q2UB+pA?=
 =?us-ascii?Q?mSALJOi4S7fYNX7tXbKw0R8NDu/c7vSjXppOk51m1J/yGjrCXC3aL78w3hBZ?=
 =?us-ascii?Q?vB3iEQfwiUxTsUoq9e8P4Dy9/O8gXhv/N0lOiCkcQbWepC7nMgxCv3B3+VtN?=
 =?us-ascii?Q?9DRhOX18KqDWhyScebQd7fNG60xju87npcTDMN7W83Hfq0GHqOgK2CpvFelk?=
 =?us-ascii?Q?JpQxNKD1N/4LI0mPQEXUQcGqPlIku2QAcwPw7gz9qVCnz256iO+U52oPND8J?=
 =?us-ascii?Q?55EtUYNnI/huL4B4A+jRjvjE6VzgzlnHKDM6v/0eld6HRi/i8v5rRnzi2piT?=
 =?us-ascii?Q?iqMLFCgDpAtDWr4Lh5+LmRXfz5SCBB3+C9X52b6kKgMACH0RZu2tatAl51Ji?=
 =?us-ascii?Q?GSOkVJTZMFoXLU+XQDILbh2bGi7HAWVnWVuEIJRqfWIBsXrNfkb292wKOcw4?=
 =?us-ascii?Q?UmLC8O4eImdecW4QY73zakJwc6hvtSLinxxq+MNKKvHFVi6/coWJ3g4pSzuc?=
 =?us-ascii?Q?1FFG9WiMtkgx4jrr6hyT+yk1bQmv8vwLXVxGnbj2VegOyDkLnm7MfQtJ/+0J?=
 =?us-ascii?Q?ZL9vtszwL1yBNVon7HITrDIOPpyNS3Eq6fnbRxwQCpUgT+o+Fcg5pZqaoR43?=
 =?us-ascii?Q?1a4UzIXxwfgO3ChCKyUU4VwDe5PFXKtyvvmeouF/y2wrt2tfBYiwEiAnJGPs?=
 =?us-ascii?Q?BJwc6vtIwfXoneopt4NspVEC4i27S+J4gAYE+3DUnEQfLRdM1OsRgWQnZTAC?=
 =?us-ascii?Q?NNXwGAtCs8SxBPfsHMbtyJqXepISxOneLrSzBRMBSX7xkhifg7vR4LbtLz9Z?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7f6a8a-5c4d-4074-0b79-08ddebd2b101
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 16:47:10.3793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+zG65r1BJeoUkUgAU+dvrd/XzFaWV5IBPwvN4tO3QIzsrSY8EgV/24lSLXdc1XyYhkH1o/MnXKJdlLN1dqLalBmj1vQWbLXnyySMJaIsfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7049
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

On Tue, Sep 02, 2025 at 10:48:58AM +0000, Ciara Loftus wrote:
> Some assignments were being done twice:
> 1. Marking each rxq as a vector queue
> 2. Marking the device as vector allowed
> 
> This commit makes sure that these are only performed once.
> 
> Fixes: 052ae311091c ("net/i40e: use the common Rx path selection infrastructure")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_rxtx.c | 29 ++++-------------------------
>  1 file changed, 4 insertions(+), 25 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Will squash into offending commit in next-net-intel tree.

