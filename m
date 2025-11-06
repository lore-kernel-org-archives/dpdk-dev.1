Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76891CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 15:33:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1A414021F;
	Thu,  6 Nov 2025 16:33:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 8ACA04013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 16:33:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762443181; x=1793979181;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ygNy/vhmXisp5S81EFgbjJWt1jrytn1u4czBlTW7Fuo=;
 b=l5ReF/Nh78TB0Oe//Bmcjz91RZR989SWzUT6AoJYT3OmZuvN6uBTCO68
 F3mPMr5xeQRN6TsPGbGpUThvB0rSbisPrTM6gferG/sq0eUVhXZeqV53X
 225nZdQN8mJ3QbBtCVckgL0Iu3LnyfL+N59iMTK0wf/uKyRp6b7cwQTOk
 irml5/Z+Y2E3bCD/BR2AWpusd0tZD7unVUxNj4BQP4l7Jw8Be9ekJopFv
 PQf6zXZ/27g5UfcJEUs1MyBSRQrLqNFY/HXhRXAEey9CAqFffDtgI4FVM
 7kG+glG+g4Q42GHAJdMj8bXqJ7xXIUmqOZj+g/s4MIJXrgp7ynbxvHxTG Q==;
X-CSE-ConnectionGUID: we/xKee6S7GrgZMpEH8izQ==
X-CSE-MsgGUID: hln1Tp16S9iGBLX368hS0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="87212484"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="87212484"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 07:33:00 -0800
X-CSE-ConnectionGUID: tsaGcG31TCihB6GzbTvaUw==
X-CSE-MsgGUID: 5KffOWutSQWU1ml3kd2OHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187039744"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 07:33:00 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 07:32:59 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 07:32:59 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 07:32:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFq3KGKmHsofCkmlhos+OKdwd1O1GnLVZxoSit7/Ivj55qzL2LbRlBFieTs6Ejev7CqBtNUBJf8BaebT3chbVP+awUHhbRPZbomjjPGxtiQdNpJgKCe2D0BEiKtSBZm6UN8e5kwLuQFwLJxh/tzg9BKWDute3IYfhyLrNPhOReUXLMRtg15MPNr3FlB/U5Z0MCsFJLpryDd9qRBJd1KoLXq0e1lMKWVDUkGIJazhgP73sxm7eof/dQiD9ZwpuAMOxC8M4amdgfD545anWe31e221mvtitinEs7oxqoo+sMI21bzB1LcRIqPL2cYsTUATG9WlTPXshv1l0htBh/04AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzuGxkz5R8mBNbuZdBszAkc0q74YXvUeQTrIzqOPxCw=;
 b=C0CcmsrF/mFaFbgxQ5Cx2047/KqIqmfxMn6Cbak51HUzrWbqlWcA6d+nWrXdkG18IpeKbAc06XD4XycKB2el47QGF+INPAqbm0oAy5481JM9IlWz+MlxfoMpqpgJtzi/CYOQZAzEMIBk4KWwrUb7i0j6v7rPO3vCJvQSMmCAauLBbGkNytrm23b+222zvER/0uJdNApErRAyYIFX1hl9pd4p0Eud2wCaxsZvGRFowEZ6mlmtJMxx58rfiUpp6a8jgOKsL6yrdg08Z8wsRWNq56n8wYDG0az6DNBbQd/FTtGEhffnOReTEofnXK0MMcV1PW8HEviUmj//oAkkyifPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB7040.namprd11.prod.outlook.com (2603:10b6:806:2b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 15:32:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 15:32:54 +0000
Date: Thu, 6 Nov 2025 15:32:50 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 0/6] Fixes for iavf VLAN insertion offload
Message-ID: <aQy_oupad2hl5yR0@bricha3-mobl1.ger.corp.intel.com>
References: <20251105152642.2981673-1-ciara.loftus@intel.com>
 <20251106115016.3035639-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251106115016.3035639-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZP191CA0059.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: dfdcfe10-f4c6-45bb-c8eb-08de1d49c14b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mc5NjuhwwujIiVXvFMmvLxZ9V6O6pFFbEy/UBGL8B9AQlq+I8hpluXlkDBLt?=
 =?us-ascii?Q?ErB3U8YjFFZwwtoY+XcE/pJSzIutlpwLWR34lP8f5/sSYtc1irgNS4UVHD4i?=
 =?us-ascii?Q?i7JIgJM+0zKQ5sROHuFk24umLvlwZLwVIj4ign4j2ClJuxMrtvLKDz1Gh+Qf?=
 =?us-ascii?Q?e1QIDmjrRTPhxXnGqoypntzBcrkWKDWQ6Mjr2j3I/z1y9UemerOMU4JRgj4f?=
 =?us-ascii?Q?d/YXj4GA4SnqIj2eIWiWvxym7pC/kX0XAjRH5ngSabwF3KT8hZ21J8CwfTgM?=
 =?us-ascii?Q?dB92+z0ml0iqoqs9E3/oj3sLLjoewGws4I0KXEeZo7BKXGrGLp76cgEbSAt2?=
 =?us-ascii?Q?5mmFPGL1LNXe7Wftbw6U7VKmGYkJaIsX4Q8lNEVcYAY7DJk55G8WQtGGtabi?=
 =?us-ascii?Q?SoHijEyzz8OfTZFw8bPx2TfSM9i51r/FJHWqyzyDmmoUNnWTUSskw/9ygztH?=
 =?us-ascii?Q?p2BjHYbeFbg+J/wnn1oH/0RAWtbOOP5NYrxrV7TOZIX22R78i4X7SnpVdcYF?=
 =?us-ascii?Q?IEQK/JNojhBN3P5ANWl2+c8ySNZVkrqb7yT2Mb6ZW93ciAs5doBcuUP1X11D?=
 =?us-ascii?Q?/wyYYKdSkM29ZjQTcUbIsFfjKyc79edPfBi03VeBLn3CQo4xv2tVpDqKKRNZ?=
 =?us-ascii?Q?C8+QkeFn35wFRz6ymIoaeKvKu3wBnAK5rTy2nhXguaTL0wQj+Bg8Zy+beSxK?=
 =?us-ascii?Q?c1QoVF0xfe4vUkqi9Y2Hu3HLdJHYrUtPpf3JmJ/6eSTgnu/LrZZ5IUBPvvgy?=
 =?us-ascii?Q?VMidrBAQ0ogUN+9mFQ+2HKm17y/tU8gKBhEQA8euGRHR7t3l4FqMi2fMqDfO?=
 =?us-ascii?Q?LlUNyvvDek2yC/z0kZIzPYKWUZi8kJHHTsH8Hl0Me6KQz2b8ee11cBlPj9CV?=
 =?us-ascii?Q?1y7rxhhrbbZs5h3LbanvYU0ndqv5Z5pWi3BQFo5TsmUVYSQKsSZIvlG2mIy3?=
 =?us-ascii?Q?N1QimGI+o5OKC+1Lr4FfgT5PkgTzOoZBkYfPt7gRqOG7/2/ZlUZrLskE2oW/?=
 =?us-ascii?Q?DLWu9EqMzuQ0lx3qYsC+PY7QZG8oTsWUfcyOdg1HiQIFjy41p75D+vwUD6oz?=
 =?us-ascii?Q?ArPqQlirwKSc2I+zURLX3VqM/GZ9/2VIIY4Z0Kt7/vyO8YSMeTc95ZMJsq0Y?=
 =?us-ascii?Q?bL3HTQutx/sSCXZlzsgsn7OPbJz63QCxLQtbQ5Vqgip5vi13O19JKci9OK/A?=
 =?us-ascii?Q?AroxOssa9ewvWrBIMuM9qUkHN6Do1nQGowDAl7xxK2cBPdlMz2rGKgOs9/Xr?=
 =?us-ascii?Q?Bcf7to8jPSJB0+Hd8fmoKJxetgujKNnUMeBZIpQ5L4UkQdzhDRG3b5YM2eth?=
 =?us-ascii?Q?kX5G5daXkyVtASIWOnPcm2Xq4dKsAy7t1528U06H8mqiXbAooHzxK8aMdzXn?=
 =?us-ascii?Q?P3nJLKEJHD0H8aqJ4V/ugpIHR6f80c6UFdWdOVjBRL6vIykWhVsyFlITx63n?=
 =?us-ascii?Q?X++YWlAXq/JKM3dj2dnwLW+jBC/927uA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aAGKKz0mk4fJ+zpdjBkqtKMkddx1RP+xdW8yMf3j+zrO+evT/V4/6GPBogOb?=
 =?us-ascii?Q?OfVnICo8BDnEYqWpUlGOBI7PNKKt0WAZ9+ymjcjIMEuP/SNXLpfZaZbrkui1?=
 =?us-ascii?Q?4mpF9JrFmRDTroURa+Ye0CKGgeDYPRJd6y7PQ/7U4TI/gp+ftTjr4aPm/lOy?=
 =?us-ascii?Q?CrLX1i++5r30uNchJYzX44HK33i7fp6Fvcctu3S4qcuh8d1/M/9BFtqyyAEc?=
 =?us-ascii?Q?w6ICfpY2CXNj/TYp0GRE32NCD4mvNy7/TdX3RcB2ub7JgPvEPsWsaSv0OHa5?=
 =?us-ascii?Q?wssR35VYOsiI5kq4qLU2BKOPKRyR0hx2+4bLinHA9b053JEwkNNfXsKzVQd9?=
 =?us-ascii?Q?urwIY9ulMCiWNdRkYrptzYbO49mnPkfutPDbY/lW+r5+Yqx5RM1xjmhuF4JE?=
 =?us-ascii?Q?wX3cxidM6SXxICz7ec5jzEVQYkKMcpH2xWqhnjvV96uMho/Zlc6rqw8Ok3FF?=
 =?us-ascii?Q?kgVSTIo1Cv3gjRJQ9FtSgU/+SNRxwlLt19geEvjURr/U5CS9XYAQe+oXu7tS?=
 =?us-ascii?Q?vmFIV/qWcBjGtzczug2bXMA/l8GuxHtztoF4a7ZNsNZQn4XlD01bwgnGmwe1?=
 =?us-ascii?Q?Hly22oZDlQFVPVwc10JOCVDrYYZrp3bFuIxWBprXvaeGpezypnSMivCZEW5L?=
 =?us-ascii?Q?Uull+Wka3VagZ9AADIxOySJgdO7MjaHKmcdZ7yXYiafEM/j4n090BJRmh+bj?=
 =?us-ascii?Q?w6WrFtjhcVHtPVq+6sMXX8SXwT6zsMQYF2V9kLn/2zue9uZVEyVXtm+mq4b0?=
 =?us-ascii?Q?8xvO7CWEso+r6IsfZ9ENCGGbsCO10kbnqqESu4KZXFjJMmIp5tFZxDvb4cEW?=
 =?us-ascii?Q?IXbXLaJz0kXlc20NNDzx8+BgGZgFsgTH5YanirYOWXGrXwyOiEwlnzwD6Uo4?=
 =?us-ascii?Q?kioRCWg0fyEQpCMbD4VkhG6mnaGOBRYSp+qGf/cAgtIkigQoBTfnzQnzcPbq?=
 =?us-ascii?Q?LO3uFL3JmQSa2uM59s0KnOjDqNE2bSx7/5RklDYhpoSNGUApr2jM7LozbIyW?=
 =?us-ascii?Q?ThSdeh6N/NvI6Cy3VUlEbpFXOpAztiYioWQUHixoPMpY4kfXH7Mkjw48QY3v?=
 =?us-ascii?Q?CbhuMKj67+cMyel930Vj2K5qwuBWpiCu/PD8JiSxUoy0XmPV9k2XB3Ls3H1E?=
 =?us-ascii?Q?Ox8fC929W1xoj+ixe66oDbqxbfJAjy2KwVtVmygXcYQFJIuglJEJ8/vWxD8T?=
 =?us-ascii?Q?851vn2rOgjj6Enp+VgCIyR9LsZDuA39hLsePYTgvwX7RiKvrYK19+mAuuA97?=
 =?us-ascii?Q?dLaTnq0GOgO+RXHEBWmFeQgtHTDDjuaoE84ax2MvMDnI8WKjuQVhBBY9f4Xu?=
 =?us-ascii?Q?LeOG3LAHH1d5pn1OsjV9qq4xaCqhlHAXjKqq/XrrDZqKeyNflQBU2YhgEPB6?=
 =?us-ascii?Q?txN4X0isJ/vxMhsWIkFzLmL0KqfxXo25I8P8khZRj4PN11Jn0nvaSouddgdp?=
 =?us-ascii?Q?lDIEobxbx7mr91Wyg/wavzwVVFLBF/Wig518B1PWDNRTXjSmoEmpLAgMKfPj?=
 =?us-ascii?Q?LJCjNF4MIB5L3WYGvj4QRhCHRZcleB9Pa6NujTBtNO7w80T1Y1rbfrwvl0h8?=
 =?us-ascii?Q?N4faQQQL8RraD6PLCT1UNOnJVUQaHs1pka2TeJeW4McI16TL4sQ9pVi0RIsY?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdcfe10-f4c6-45bb-c8eb-08de1d49c14b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 15:32:54.8514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RI1/fG+rqqLkCRf6o+jXKOjURiccqCRTmQUUG5/fQpc13FA0aDf7caJ3p+iYjmyIezJPH7scEkuW+KMNS7D9oV8F2j3aTbLTDj2347PSfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7040
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

On Thu, Nov 06, 2025 at 11:50:10AM +0000, Ciara Loftus wrote:
> A series of fixes for VLAN insertion offload in the iavf PMD.
> 
> v3:
> * Use RTE_SET_USED instead of #ifdefs in patch 1.
> 
> v2:
> * Split AVX512 QinQ fixes into two separate patches (5 and 6)
> * Remove duplication in AVX-512 VLAN insert logic
> * Ensure correct behaviour when IAVF_TX_VLAN_QINQ_OFFLOAD  is set/unset
> * Consistent checking of mbuf offload flags before vlan location flags
> * Reorder, put fix for existing AVX-512 bulk logic before introducing single tx logic for QinQ
> 
> Ciara Loftus (6):
>   net/iavf: fix compilation with VLAN insertion disabled
>   net/iavf: remove duplication in AVX-512 VLAN insert logic
>   net/iavf: ensure correct conditions for AVX-512 VLAN offload
>   net/iavf: fix single VLAN insertion positioning
>   net/iavf: fix QinQ insertion for single packet Tx
>   net/iavf: fix QinQ insertion with mbuf flags VLAN and QINQ
> 
>  drivers/net/intel/iavf/iavf_rxtx.c            | 53 +++++-------
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 83 ++++++++-----------
>  drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 16 ++--
>  3 files changed, 63 insertions(+), 89 deletions(-)
> 
Series applied to dpdk-next-net-intel

Thanks,
/Bruce
