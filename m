Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EE8CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 15:08:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19B76402E1;
	Thu,  6 Nov 2025 16:08:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 489A4402BC;
 Thu,  6 Nov 2025 16:08:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762441681; x=1793977681;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=YkRlPUQQvmDWeykXTqUGN4P19Gh6nhy5azxKc0hGhFw=;
 b=EO+L8ZcL/2FLQC+/q9+ixr0Q4Rh9Zs0nqDJnyE9B7T/iUTcGx/rdwDzE
 BObLBwnUfrjOKm7tGGbNaVrqfpQYrScbzrfEzyHRY4U0y1J15pd39fmO0
 c76TIXuUL1K1Cg3JlNEeOxeginOnY2ifcedKmrBvdIq+AzBOZB5fB0dyf
 +xF1od8sVY+qxsb5QCL00zSYz3H1b5e/M9BZu93TQWKSTzRh7793v1jv3
 OYMzUCV2K0YaBRjGXHSfnBhm0b7DUhtX30h747+K3T06CI6QCUstkHe4i
 kbsFloR9dzWAyuDGisMWdgXnwiAmfx934O8PMl+tSdw155q3TmmFr+Iv4 A==;
X-CSE-ConnectionGUID: Wv7h/SAjTziNIWoIATWg7A==
X-CSE-MsgGUID: /pqD3+crQK+LmKxIhUOVZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64463293"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="64463293"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 07:08:00 -0800
X-CSE-ConnectionGUID: QZya+CVPSW+DnbV3Vi2LMA==
X-CSE-MsgGUID: H/WKITRZRxObqfmuzynyMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="211237086"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 07:08:00 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 07:07:59 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 07:07:59 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 07:07:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAqExqeLBWoxDeruu0SwyHLVGGbo4223UFTz2UdcS+WQCuDEVT36sGOmk1Cm/cVompJFq/IAWqj3v1ufnFBo4R14zuFA4NEFhx191OcZVPi6HzB8tMmDYh8gMEl48clmkRNzbVqww5n3w9as0LlfUf51VpEkG58YQXj7vKNbvHxckmArdP3VKHOJHGb9U0N6bDtxAq7J9WEQ26ee/LY78g7qsqYAFkEQ/eQRJppLzCyvX3L2sDsg2v4doYC/B3IL/3/oX2yWIAxiToMi3slGml0HNyBlt+OmOHT7N+PtYaPW6wU3YOohseNlOjPbY44lRVGT+sI3hAENm83cSoa4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj/1/l5tO4yLx+6iB6rMbi1jg+ALONO/NyN5MngiBmU=;
 b=i6KiSmsA7nZ5/Y47IJ94GYYXVFZ7UgZV5pTArTFcZJUUelFLlEfGqpLfeISF0VKzu1wQiVsHxHoZu8u2ogzjmnxBcZ3GmuNHpEthtRym37XUsdV//JAWRvvmecx8g/EohE9mvM8FhdThBv4MRRwuBcGy/6C8s6Ib55g2ayNeBcT4cC1ZRSbpPAm0SN4t+LTc7Sb76UaxnFLQYN2bjCgbgyqHdim2T5YH3zj1TgzdXNsIbgYa3FQNkYt3WyWaAuHXlZJ7hpoOzxQEeFjOuS0t4Vqm7OB8qJigrvLpDJLP4lQWPSZ8NO7Z3DtOBfQLpnNjjVfPDc7EvQbpyHwNOQOSFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PR11MB8733.namprd11.prod.outlook.com (2603:10b6:0:40::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.7; Thu, 6 Nov 2025 15:07:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 15:07:51 +0000
Date: Thu, 6 Nov 2025 15:07:46 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v3 2/6] net/iavf: remove duplication in AVX-512 VLAN
 insert logic
Message-ID: <aQy5wo9cjynKaK2j@bricha3-mobl1.ger.corp.intel.com>
References: <20251105152642.2981673-1-ciara.loftus@intel.com>
 <20251106115016.3035639-1-ciara.loftus@intel.com>
 <20251106115016.3035639-3-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251106115016.3035639-3-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0109.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PR11MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d6e50e-aa1c-48e7-2bfd-08de1d464132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8xu5ZiV7tLkbtdOQJyeREH/bl+m7bU22/rzWnWIklluXgE3YQlQ1aij/ova2?=
 =?us-ascii?Q?ljmCzudbWJh63ezEm3Edf062VyFZ7W6VHkI3M+AW+3UJbjNK+NfDl6eo7Goi?=
 =?us-ascii?Q?M7a7ZQDp9l9MsnxIGgur/AVAKcn6Y9PTZUgKs4NMnBE7jL/ygiGG2e6IUK8u?=
 =?us-ascii?Q?sP6fbxsXiw73VD5KEGA8Of2NCPGGX3j+bfrGhGvQh3L1196IUXOo48kYmT11?=
 =?us-ascii?Q?EiwSb/xVS7tumUpCebbX4JIBmk0b3sCma49OIcZlby1DdlWLLnyvbRkohyJd?=
 =?us-ascii?Q?xO6q5UHpEytEJZNKVo5RKzb2R7y5VjaNeISRgq/KArGU39SmWbyvgq1Sr/Bd?=
 =?us-ascii?Q?m7kr6DbRK+i/R98e127LgQrrW6lEBDvYhQtsZ4VqR3rcW1tIvb1GavlyI7T5?=
 =?us-ascii?Q?MSBSVb8lExwLq9uOuntSwWIbO3jWHtnOBX+hTgPlgJ3TdKdIO91Xb0pV1Uxl?=
 =?us-ascii?Q?47UJUFokL/ihQla1Mt787slbapryyZrc8DzJtZ9uyjMvoleE4MVAbKRJiTyV?=
 =?us-ascii?Q?53XFkZcYqPFb6mtb9DoW3KptkZjUl0TfmrDUMbdLpdazywj3HOJ7YWNJrOUj?=
 =?us-ascii?Q?HLZugeedG833NjN3fGFnL33D5kWqpdIy4afB5ckD7lOEpYBlLq0cMRCIAPD8?=
 =?us-ascii?Q?JJ0TkwnOhQ13N5UPZLrEacn78HhQluwBtghL2DoxhL8xm9HMJXZnNx6Fo18B?=
 =?us-ascii?Q?wa4l7vTWHqpjmc8RBMxFnUMI3fXH+X+kVqgL5DllGwXr9V1Ppg8y4UrpsA1X?=
 =?us-ascii?Q?1g+yKwbJTHingQ5MXA1DAdJkTKEmJKjYWVzKJJVhd54KnIOKbf84WD3R/SDT?=
 =?us-ascii?Q?ytX6lAvKKA0q794zu8bklPqI95+IzQHaE37wNZzJZ2+i6wspJQ4k4HHZYr05?=
 =?us-ascii?Q?JD4zdCdzKTnYdQRuYRHgDe9sU6A8/GdoI53wdXMM1I2RII7jSCrG0xAW/4R0?=
 =?us-ascii?Q?RULnAM/Pnfyy7oUpJPwql1UFyuvidQc7AMt25nLIRiNbawC6K73WmjGElCed?=
 =?us-ascii?Q?3eWmpp31bZ3XSb7fIl5SfUpV6rx8N80W2HYo8dGt5at64yvwv8yscS8o7rif?=
 =?us-ascii?Q?9TP/EliqODUIzvPp7yBA91ZFRCW2mApqfnfVdrHtefVvH4b+J8a40UTH1zlP?=
 =?us-ascii?Q?L5CabB4lQDgHqInvWffC7hkj8khE8hlBWs0ncJpuIGS2884Jx8Dtq7vKtY+G?=
 =?us-ascii?Q?uNaQdDLbUy9rRiwLEpjZUIwwf4pqTY3a9W4MgGIQIFEQpdbNScRw0/fHX9S4?=
 =?us-ascii?Q?HVP0MAxfSi5nAMmsFKgiHj6EFWHf4tzycboy5SvFm/T99cYm5h1QZKXPdnSQ?=
 =?us-ascii?Q?5bYfe6a0F4g4PpWi0Lj3Rb94wIkZxzgUUiAYF7pho4xyLidxU5HgX99GBu4l?=
 =?us-ascii?Q?/jRQU3XyUGTe8wF5EhL/O2kS+iwaGHArQyO4yR9So+JFCLSNnqL1dROkmb7q?=
 =?us-ascii?Q?ermVim5I0bWJizx3o2V9R5DVYuRNTQiV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iBITmKtsFYLnhiO6wio7uANzkp0Ac4HvjVbXEBQev3lqpaRtkw/hsG9A6XB6?=
 =?us-ascii?Q?riLZBw+MMQMuGTsd3Ta0yO8t+Iv9nhIukRzlaPLEgVQB/mkzOHLlJGpCpkc6?=
 =?us-ascii?Q?Mjq//SLzTbM/lDIsw6bjKwG6BNhXMYVS4tzgWGRkrJBEtPLQRHLbYW1iu+KE?=
 =?us-ascii?Q?UNbbjRvvudGZ1pv7kM8PbX7YnPDx0pD+tv/ey09g0HPYJvnrVgFqlDZmyp5B?=
 =?us-ascii?Q?AdVpoIzgiS7AnPijYWU5jyzwmN5RhJbayMAOjiZyNIeKKkYIHAPhyAXlbjh3?=
 =?us-ascii?Q?rAvy7dd2oVD27PXTc0w75RSbM2GUMlWdGGnSv3r7Q3xXsuiQXh9sAvlwVjxJ?=
 =?us-ascii?Q?qF7zAgK2W0/u0C6XR+t9bEIypRCJKBxe+4JriJbcPCGENPx7ks3BNmxuv1a7?=
 =?us-ascii?Q?rki8sdDqD0CSlj230saq3aAFAn80vRLkdlSLS6HgPCF1FS3dC2l4M2nnca+W?=
 =?us-ascii?Q?gJh9GwBbSaxc1Hy6VPpOIINFgGCk6oo0okb1HtFCrlFzm07owjNITcbxDUuR?=
 =?us-ascii?Q?sYqdwXR8ZuxC3GsxDhAiLvdZ6RcDqhGgSODAuSC5cgB+vFILpoVsTc+R+a+T?=
 =?us-ascii?Q?ckDs3EaEMk15wT9iLfRUGG4r8mC6FLXIfMMoXUlQoQHCFL4q6AVDVIiTjhU4?=
 =?us-ascii?Q?dJgdWyV3zWTtAklmlY2fiTM4NjMN3ZWqHhVnWLmG5ZcZC8glQ8uQXYUTf49o?=
 =?us-ascii?Q?SHHSW0uYEBjjnOZAHBODo7UCDvbxZU0eqeqGx1pLhoPuxL/PFFV2wwtzJANs?=
 =?us-ascii?Q?stzP83AmwfdGbxZA4xUzs/6KeoEh6ET2/U9U8Uq79qYDqbLUj7tXXWqWCrB+?=
 =?us-ascii?Q?UCSjIgHj2xysnBk2HoIC6RG47TNFoNgRAgMru1C5JrG1WgL4UcVKWOh/Gfzp?=
 =?us-ascii?Q?RVGcc4CQz4As+YooFuUME9x3WUQP5Z8S24Fzc6UjYXdLgultVbnETQQwwkuw?=
 =?us-ascii?Q?UQ8BVoRtMr39IF2V70KhIJ0NHwGR07jfj4M+Ev2w/ypZfit/iLno4mP7u7Kz?=
 =?us-ascii?Q?U+ztM14nZos98cTxNY7gQ+GAGZ3oV6TqCkYFfpINVmHASBmnrnaQl9N9GNPV?=
 =?us-ascii?Q?unmU11VAcTRQrfCNPzYlbmSBm7BlUF3F3Wycv7e06DEXvOMoVH/l4GUFUAKa?=
 =?us-ascii?Q?NcNGiAGSAhZh2qMCcXf489yFOD8Ovqqv03fTAAJPyqIaANN1zx9JSBoORGbK?=
 =?us-ascii?Q?+IVtF+pNjLZOZO8sCiW+dCeiaADxPiBRaIqIcL6Q1eLoW1Hjry2sCCDNPOMh?=
 =?us-ascii?Q?dxeUDW7RboVSTZIzheEkoNhk1xa9MRE/TVopAQObBpDy4LjKGntsGyv+crhE?=
 =?us-ascii?Q?IPd6kkeOQoVz9gWwfs9pIj1ZURIX8S4v6lzeBGuj/1TjQuVoe+hgEHFuHZrY?=
 =?us-ascii?Q?+paqxs6Z9S5tSSz3DcRt5GDSQRwjY6L227ZktWWwRJyUvEwJla/Pdmb+yR66?=
 =?us-ascii?Q?ejDWu3vDetg4IRvzYytRcArf+QOjhLyL1KdNixHtBjAR2prForo3QXpFzTih?=
 =?us-ascii?Q?QQ6lZ7EckIopWrmHB9nfK0k5XG4oBR+81PQv2h5/WGN8Pf9CyoEvHqerULbZ?=
 =?us-ascii?Q?goWspDOQRHrzsbDtI8qRJxqURmes+0VTZ7m2FDCDK2sQPx371VldrBsHnnff?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d6e50e-aa1c-48e7-2bfd-08de1d464132
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 15:07:51.4024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSBdLvSeoV7sHmJwWay0zKQ5fIe2Tb1IwNt6srH6XqZadgw+pWAuYef/DWY5xbchUSHhW4D/1Uxsp2AnjJEmVXoEOyPnTOHOrVTdf744b7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8733
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

On Thu, Nov 06, 2025 at 11:50:12AM +0000, Ciara Loftus wrote:
> The part of the transmit descriptor that holds the L2TAG1 VLAN tag was
> potentially being written to twice on the AVX-512 context path. Fix this
> by removing one of the writes.
> 
> Fixes: 4f8259df563a ("net/iavf: enable Tx outer checksum offload on AVX512")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 66 ++++++-------------
>  1 file changed, 20 insertions(+), 46 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
