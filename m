Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5BFC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 10:59:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0930D402DC;
	Thu, 15 May 2025 12:59:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id F069C40289
 for <dev@dpdk.org>; Thu, 15 May 2025 12:59:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747306796; x=1778842796;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qI8MC52rsaYhRUksw5L+65AVUHsZj31gT5d2P2ggzWQ=;
 b=lOzPAbaO0XUrHWD3eeogTKfdW/tM6zQqsvuhK1V08Rtd8pVbx8D1jC98
 eB6QDwIJk8xNcHwF9YJQLpBcLY1XkMTFz65N4uDfhmlp8hSpxQ7AGSvyO
 oddnw1ywE4+8dWsSF/YW6p5t3QnusZW/aLPqKuBB84XrEJt2KRW/2rjSG
 ETBfX7Bm3FxhVjf6jl1WUZM71ypfWrhgKXuIwUKgvQC1j1vj4j/FrW99N
 lduKE6FQNAzjH2pmVVZ6SDIPkBOUSna2Df0uKKoprC3wLSQi/gOJCEH+8
 OZCAxxecc8FgzVMfG9db2wRmSFKBO57qnXCbDAwzdy+rP9ziRQjUUqeWv Q==;
X-CSE-ConnectionGUID: GVtIv6s6RdCHu5SPH43R9A==
X-CSE-MsgGUID: iUCWBgGZSzC0fWoargBZQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="51872903"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="51872903"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 03:59:55 -0700
X-CSE-ConnectionGUID: 9WQtm5JaRRy7gBYYP7r7iA==
X-CSE-MsgGUID: VLPof16JQCGoIWey/a/3sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="169404721"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 03:59:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 03:59:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 03:59:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 03:59:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9uMIElzo6lRpp2ty4nByVIE/aWbDs8ZFxhfyizd9NQeJNiQkgt426agG4ppWX77cA79t+IodEYnyW4WFMMPCLosKZb05FSHSGRsOCeJ5HmLMWvGHNT047rJrdOa27/x1yPk2l8GWzamfrnd+LO1u+KuBmp9Ky6dfdMxp3HjuuGBAxzhtHGgS9AVFUgbkg6SqPLlRNpkVLbAVne/qOj0pptrLSLBlvD3ALw0TCkXjg0UPSGMYCl6607Nnw/e+i9V8/RnSAbScVFFTE1yHYMIkm1XmYpY4M9oK5AwuEVpZ7ivC8LyK386IKgOso8Kn6W7WEiaSF6mb0AKr0gYwHgUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmSWqmi54nePFJDiBXhYeRUvtzv0dOVY+9kA7hvylR4=;
 b=fLf6hOPwsU5m7W/25XykVmifZf08NUTn9FxFUwMiZIYs6UY+k6+FUAg5L7RZbLYskx+gNGW58bVFJrv4GbUI5WKG83xly0wA/Re2g+dSlvIfSbt6BTsf4sQ+vBnZ44S1V8EA/EV3GvgBa3V6bzERybGCII2jiO1WPusYYrYgiko4YEWsXfz1sGO/m+piU6q4ziOTcHQc9WwlL37jhA3UubSbuiGXsawo0dA6u0rVpdXJqoRO1blUaotBZ1RI/NdWUQebmaE8nWvteXTiuvNDT8nF//VBPqHWiTAZEWeqjtEIwXnzzVgYXaz6iMfyoGfo+uTOoc+pSBf/TLSG+lUuFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6163.namprd11.prod.outlook.com (2603:10b6:930:28::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 10:59:52 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 10:59:52 +0000
Date: Thu, 15 May 2025 11:59:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Ian
 Stokes" <ian.stokes@intel.com>
Subject: Re: [PATCH v3 06/13] net/iavf: use the common Rx queue structure
Message-ID: <aCXJIo34sEid9hC2@bricha3-mobl1.ger.corp.intel.com>
References: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
 <85efadfaf90568018e15c47e810c56b693d4a4cb.1747054471.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <85efadfaf90568018e15c47e810c56b693d4a4cb.1747054471.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0283.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: ef0c5549-8f97-448d-b75e-08dd939f9e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?manhAYyJBk77Q31ILzgCLvvx1bwZgIw5ulZHoS2T8W+1LT8d5azPi1/i3Gd6?=
 =?us-ascii?Q?h8RmgKQHlYo+I++b+fHofmh9FXzJ2VYu5CPpssUOhZnDsP5u+EDoMrikJ6UY?=
 =?us-ascii?Q?JhrkYofLfqchXOMZagMeONTevIh5q2O23eJzJCdjTAvWEL/IBe/II/Uwe6nk?=
 =?us-ascii?Q?4S1IS5A7jUZ4lyvMdkFxX815YkEkvGJHr5f0e0ss/9UAIBpBxElaTGpCWgIp?=
 =?us-ascii?Q?4L3kx816tNXHEFq2vzSGHd+DfzcK2VH3NXul2lffPVSX7smu8taZ/nP25OBD?=
 =?us-ascii?Q?2iFlo5Njn8bcnnUbJOhqmLdYa9QqDlpj4oJsltNh8Mz0DELkGrBKmB09cWLw?=
 =?us-ascii?Q?Xx/lwLxlwZDXUr2lO0WD50kOfJuLhlT9RPbTq2wGU5v8lWWQHtLukXI8jQHp?=
 =?us-ascii?Q?dqG0Sa0jLI+leJkPdmjPqPpZ5VC0WKJzREbJfthUsiZVYTFglIZQRpG9U/+M?=
 =?us-ascii?Q?yoTvIojmFUnatUCCZtydZNRv9Aol8BE8ppA5EcR6C/TIhSJJktJRXwJlVUyA?=
 =?us-ascii?Q?QFIUcp5BHkSRJGOxe+KIPQBd3mxKTT7dcIDSoxuUbH9EOu2l4SfH/v88MoxE?=
 =?us-ascii?Q?AB0OMVIkx1qPHaOIkGnc7Mg7KjJHaWuaS6L6Op/3xBG2MB+O9w6A0XhC+I8F?=
 =?us-ascii?Q?+qcNj5imdbtKBiKbIGPNn15C4Jk1CsC+j4wNlIcGW6KnPkC/yBf3NUu3iUi1?=
 =?us-ascii?Q?xaQlwNBeW6fiHij55DjK/gDYsSCCQ3fv91Ihaglwvc/ggsCnuIe2E7K9bL1I?=
 =?us-ascii?Q?fv5PI5W0qyJe6qQLuG4AHpJhu+m5xM2z161QBlH5EPk2y/LUHky31adkJuTm?=
 =?us-ascii?Q?rCzVQqtr9vF3sixvghWIvSS4Uu9L1JtaOFlWVCf0N0JekYudCx0EXMjc9S3T?=
 =?us-ascii?Q?AEIojyxlwOoZNxEGZueARqRJmESMzOni50Jc8w8gOatvDhLfs01zxxUgXqXU?=
 =?us-ascii?Q?vp1ePmlwsjnVtwAf/PLQDXyqytXGrUF2wqIsaclqmZ8wQNthjkBorR2iJjec?=
 =?us-ascii?Q?95q5cZNSyeO0PIdRaEnqqIsGSpGGt+o0CUE5Oj9IFy51I3DHu+nYel8jPIee?=
 =?us-ascii?Q?sAJGhvEoRWtz6QdgS0rMJS5uVfC4w24oc0/fnogFgPhD53uMaUBH5fOTPIUF?=
 =?us-ascii?Q?qNsKBEjgfAsBD5gAL9nWqb187rod/3nR42jaA3mavLkGBW0G5LmJgB9KH6Ii?=
 =?us-ascii?Q?Q5GTWXQYnLVU8rUr/VWw/kLqM8NsObAkhhHxKlZR4V5zbWfTi/VP/PLlwrJL?=
 =?us-ascii?Q?Xa55khwTor4Rsxkv1kwIpZ9RnrJfe21GyQsB3+Nz/5s2i5ZvXFmwiOVO2ihv?=
 =?us-ascii?Q?L19IWuDhVoIs+ef8YfngGEpxKHtjcypJwjfc+1uAK9s74vrHTjEpB9eo5jCI?=
 =?us-ascii?Q?4HqK/9DQVKo669o34KEreddi6yRdOcfRboB/+v1Q6rP/u8TwiZHAbI+MftSg?=
 =?us-ascii?Q?ifCi6B8GQPc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RCb2ygICVaP8ppWMKNZkUT5qDkufhnCjuSN3Bitke8C0qy+yA55VIWnFgMnl?=
 =?us-ascii?Q?YVnfyuLpYu+xhwMs4cOEe7cCaqG823zZADa40zlgGkswiGk2ziLN34dgg8LH?=
 =?us-ascii?Q?sdUW9ReKag3IFbtdVLDHRI2SsL4+gCsjfhrVTJCmIn3YzvVvjtr7Om9qQNy6?=
 =?us-ascii?Q?5dHimK0r9sps95PBR+xSNCYu6ODZDfseuLbMrqUN2A9fHWSvrg2snehQkVBR?=
 =?us-ascii?Q?tjo0WcY3gU86Y2SY//gELvlzsc5bflvwDI6Vp4LpXubnhBLOwLnLx94nmEHT?=
 =?us-ascii?Q?QhluPYindKz01vYuJv4BCakVLqDuWQSd8jXJaDWG0ZFdBZq/eoNzCnWysgRn?=
 =?us-ascii?Q?AYkpoTnaDxMejIoJ0weJr9DFlhjpmt+ldws+zKAlkDJrucdtP+JmEJgWcuOi?=
 =?us-ascii?Q?QSjsYV5ZQp9hpZmERpnHk4OYYYAVV9fnePBGsFdAoAswthIaAiOA+cPVhO74?=
 =?us-ascii?Q?R7aerhPZlBk0t/9OLfyxGvTBeM26+sXYncu9+UClEJLlK6VErGfYn48pRq17?=
 =?us-ascii?Q?ZvQC1kR1rbvSTchTwtye2tz7defWHrt2dgi7zcSk5ry1HG0ooQqrVTBU6vO6?=
 =?us-ascii?Q?qqvEo7jPJjm7wUbenvGkK0xB/LlmC8Aj5durYizlFFrMNq+mv3aBZi4AjIBx?=
 =?us-ascii?Q?27jUeWb+kM2f7ZY235IDZt2ZRgSMa4VPKq7SpUyZvZJTXPgXZW8vv5LwvhP7?=
 =?us-ascii?Q?cWzDZ1irc1QhUKmVxYs7/TjGUa2yUxKH9NK8QWYQHTt4Dff16EymOKeWaIaP?=
 =?us-ascii?Q?RBu8qabKMk4Cpghf0XX1dSCqPM60pMfey0T0mfbzI2a6wAPi6O4ofy93q3is?=
 =?us-ascii?Q?xKmGmtvmDgNQM/uI9CQh5hVmlQA8FA3wAXnwDWEmb3pf9RwS7wH6z6iHm8OD?=
 =?us-ascii?Q?Tp7+sFAcLZXV4vqcTyvjSjhQ1aEIjo4/hDVC+H1xHaqEsBGiMsdttjB5vcjh?=
 =?us-ascii?Q?zlaydiKOMsqysWX1srjPQbTnx+uTENW78tqzWt+TGO0awNyfYSVaDCD8cDE0?=
 =?us-ascii?Q?nB7XYXTIrs+EHKVu3+0SRBsSFPvkIK+Kp/PPOkCtRyZD/JSch0J2HIM+a6Cr?=
 =?us-ascii?Q?h7wdNa5MG+wmRwZurwQsfq+1pe+tDT46jrMFTbkOSvnmxdneTPFJNj5OkYi1?=
 =?us-ascii?Q?Kt0sz7nd51o6AjxDqTVS5z63sSKQeJptoNnPCTLoiePzTynlPzCrHTcIXsUj?=
 =?us-ascii?Q?WQhRqJO1wp/T0LA0b+uUamhCXUMI5t06dLPuS83UVWKDNVc0RzTJNH9pl2Vy?=
 =?us-ascii?Q?iSpR2zBmtVY3teO3Z5UR0dvfIr23bRYtRABnQNcf4sNmo+4WTAHGy00IDlec?=
 =?us-ascii?Q?Pai6ZBVqzIi/qJwbPwmax4mD+K4IkaywCojGNaVZgPnovjmdLD50Bs3OG1mj?=
 =?us-ascii?Q?kW7ZMHi+uCgmjhwbe7SGfUNJlwJ+yXamhtsx+HvuosNeu9igZTZX3Iy2FEiL?=
 =?us-ascii?Q?dSZU0VEEx8NuXavXVoX+z2IUIq7mB0lcqrLZfod53LfwJHmpN6vtzsNUTg3h?=
 =?us-ascii?Q?FmrR6oC889mnhistrdkRfqq78WDZGfmn4SAKu9ruAtCsATkqvP9WdRLBnWhy?=
 =?us-ascii?Q?Bs6m0lSMff5GfsGYe7Euqv46cyWzoahWwPQCxs1kBVASHyz87/Pf34c0p91Y?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0c5549-8f97-448d-b75e-08dd939f9e05
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 10:59:51.9392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAdvTA9LdnHa2H4eucxILdGJrdtJZzrCephCxvvC25Tu3FP2kxUAxn2gaWBAcHIgoXpX9zrP6y/WJS4bkQzCaUZrAv2n11Itw43mnZzLTbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6163
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

On Mon, May 12, 2025 at 01:54:32PM +0100, Anatoly Burakov wrote:
> Make the iavf driver use the new common Rx queue structure.
> 
> Because the iavf driver supports both 16-byte and 32-byte descriptor
> formats (controlled by RTE_LIBRTE_IAVF_16BYTE_RX_DESC define), the common
> queue structure has to take that into account, so the ring queue structure
> will have both, while the actual descriptor format is picked by iavf at
> compile time using the above macro. Direct usage of Rx queue structure is
> now meant to be replaced with a macro access that takes descriptor size
> into account.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 
> Notes:
>     v2:
>     - Fix compile issues for Arm
> 
>  drivers/net/intel/common/rx.h                 |  12 ++
>  drivers/net/intel/iavf/iavf.h                 |   4 +-
>  drivers/net/intel/iavf/iavf_ethdev.c          |  12 +-
>  drivers/net/intel/iavf/iavf_rxtx.c            | 192 +++++++++---------
>  drivers/net/intel/iavf/iavf_rxtx.h            |  76 ++-----
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  24 +--
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |  22 +-
>  drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  27 ++-
>  drivers/net/intel/iavf/iavf_rxtx_vec_neon.c   |  30 +--
>  drivers/net/intel/iavf/iavf_rxtx_vec_sse.c    |  46 ++---
>  drivers/net/intel/iavf/iavf_vchnl.c           |   6 +-
>  11 files changed, 207 insertions(+), 244 deletions(-)
> 
> diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
> index 9a691971bc..2d9328ae89 100644
> --- a/drivers/net/intel/common/rx.h
> +++ b/drivers/net/intel/common/rx.h
> @@ -38,6 +38,8 @@ struct ci_rx_queue {
>  		volatile union i40e_32byte_rx_desc *i40e_rx_32b_ring;
>  		volatile union ice_16b_rx_flex_desc *ice_rx_16b_ring;
>  		volatile union ice_32b_rx_flex_desc *ice_rx_32b_ring;
> +		volatile union iavf_16byte_rx_desc *iavf_rx_16b_ring;
> +		volatile union iavf_32byte_rx_desc *iavf_rx_32b_ring;
>  	};

Aren't the descriptors used by iavf the same as those used by i40e, and the
flex descriptors used by it the same as those used by ice? If so, we should
look to merge their definitions.

/Bruce

