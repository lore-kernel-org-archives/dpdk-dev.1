Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CDFC5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 15:31:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98498427E4;
	Thu, 13 Aug 2026 17:31:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 0EE50402D3
 for <dev@dpdk.org>; Thu, 13 Aug 2026 17:31:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786635071; x=1818171071;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=r+jk1s95A4gvEIhc+JVx0ktDwIKRyG36Qmf5VZXxWlI=;
 b=E+0YOOsRIK4uuwQxUrqh1CCX/XEGW6JmcMcr1ebwB3XNjgAVNVouQUHw
 iv15SmmJzOH4aNB67o8+GTGQX2MYDcN25FCNJFBpOikVao4hT8t8F9BmS
 TMWmNudS6iRQvub8NuM3DYz0gHFrJnVJlA1wtCcsSH6kMJvNYjpbJT4Yr
 Ye/9FaSpvoN11OS2eg6geoZghTRv/5od8FWOTdrGhDRJDeUJvE0aGP8vu
 UMTb6cz8hhXtORTFOQJfvlkIHbJRVYX/OYGK9W4dzudXkgASmn4c3/6+Y
 RSVHjya5uToMYhAbT6EDnq+3q2oGRmKqIndkBSZguJAYdU8Pq3jpp5bYe Q==;
X-CSE-ConnectionGUID: 3Kqwxg8WQwmqBdhbaS5FiQ==
X-CSE-MsgGUID: UzaNI0F7RdGmNpW6D3+d8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="97876274"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="97876274"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 08:31:04 -0700
X-CSE-ConnectionGUID: fwg8OgFqTYOIpj4kXOuJWw==
X-CSE-MsgGUID: +1fsyyCGRRKBahH2EEhEMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="302221789"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 08:31:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 08:31:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 08:31:01 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.42)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 08:31:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGew2jJstZfXRzBGDBzPILifVkn+EaDYf1g+cEkTafBbczvVeHanvk1E8tpn23gCQiVe//WsRCPk3N0vYFF1zrHgvz1jMWhdq7QA3RFpt7YeGjZVVc4uA2VqgE+A67UIS98cdYtOmXYvWpvDYEJMQRIEk5qIpxvbwaE8gkG9N1h2qxoV1vFOKMG3w8gn7bjA19DWyu7bgSoOGqzdgydB75695Opem1VWDCTXQ2GIp6tFDXAdjVYzAEgB67pPgCV9ZXoGOaZJaXHvGYDWwcH/MX7tPq0XhFd8InZ4U8dOc8DGDcNJgJhZTJIx5h5y6Mgx+WcHcckrQgnva/YYw2neLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLvrlKS/A7XgObxOKeqhCOhSBoAIJoriCvJcZaFFBNg=;
 b=OlWajqtM14FSdBU/z4st+KdBahsI3txLb27uJwsMT6S/dH7q2Xr12ZvhlFrzgD+6RzyBEi9MbORsD9fI8J8/ieeY4jABW7aVVsVNdWSlpHhLNgKPhV8YHWD660GAmU6eCIMm8qKdmQJWzplRWhm3Oxd+jCuDeDyIPqnG7GCD1b5wkJULrDvp793UiRgndQQCyvYDOeunwp+174YbbrqAkSfTX6IMsnyEcEtmUDUoIAiHgIdDSTLZ5bKGzrBJzjpzqwvNlu4qdQgnOp+2WJgFsNsy1iUusOMDiKUakX3GBqa7FkFsF0miUJKqP44DU8OHoNd2QhSKuJ2x1usxlRtNpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS4PR11MB243254.namprd11.prod.outlook.com (2603:10b6:8:50f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 15:30:57 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:30:57 +0000
Date: Thu, 13 Aug 2026 16:30:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 1/2] net/iavf: remove Tx LLDP dynfield method
Message-ID: <an3jLT5WkSmhXTER@bricha3-mobl1.ger.corp.intel.com>
References: <20260810140354.1869708-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260810140354.1869708-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P189CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::31) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS4PR11MB243254:EE_
X-MS-Office365-Filtering-Correlation-Id: 174efd76-c7e1-4872-2544-08def94fdf19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|11063799006|10067099003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CDXekBoiG/jZ5XvU97vqSefXdWVpi3ZEK9rqCLUmX3uZ+rBtaX8LoSB2plSLhQzInbPjFcFWg6P03PV1VYlHL0jLujsU7egLKEawqvA5Swr2I9ft2TqJXeEbpq2gWZ+hGFr/nMwiFQ/0AzydHWRyH9sDjMeP1aXwIp+tlfCTilJ/9qcM/qRh4JmL019+7YJNYheNm+AgIVmFxNnd/zvpNaY9QlekJNvCEKKplWuVqU7/1xKNHNdJvQZcxnbWe6GwdZqbkdr6Y53dxGsCLSLFO/nSubDc8XL2Z4Cn12epOezEEt2FqDUBvgvX6in7AYUlEDxsUlYHANaq6cW/Oi1RhiaRGU7rDL6Q9GNRWsKopsCfesb24ZAuKE2Qy5xUmOQGUT82vxA83is+6AjaYgqtbNBd+H9guqghKO/m0jiNOn0hJxeUT6SJimvLwQTzyb5zulU+0euj2JQaLhSgWjSlGI2BL4CVUxFqL9ADotlo521c7tnG4cYmseGIDYRGlZCpPykRmiM5m5VMvSY8FiwuurdQqCvkmmFDOk0O+0AMIUVw6AI+o7j+qR0JyZlvOsaP6ZquokBv3tVHcTGWvDske8RjBn4uPLZHDSbPE1EITCClNUNQ2nD9OwXv+o8THE612PfKUYwiFxf/JUaNmk3da1WHaPAnu0OXRIr0opg4uvs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?94U53QConr43w7YlMU6YdzpWie2veCZhTInmSYh9/7LS1FuaSJ8n8okw554O?=
 =?us-ascii?Q?iIcH6p6JYN093oq4+cuWIDM7ERkz1/dPYobj2ltHbxCB2jnseGGz9caPsZod?=
 =?us-ascii?Q?iBfhVH404KIrvejhFsiVD2IcDNmAekuvvd3Iiiqkphyeq8m/K+9PC35jUFBI?=
 =?us-ascii?Q?lcVYO6+FA9AMQcIwcS+IJdSby+MF6d7Pzg8kGTAK5XJPX/9sMH2DdPaIqFsQ?=
 =?us-ascii?Q?PSnwa4gc9lBKmLNiU4tc7/5uY+jYprrHR2b1NweLLNt4rRLmIDPy/PRAddxc?=
 =?us-ascii?Q?XKX+PYE2TD1xKgMB0BBJdjum7R1CsYtwiT6DYbYV7lllsFuhEgnsOUj82drX?=
 =?us-ascii?Q?/Pc93v2qP2hvAQBGGzHYWtt8hT9jNmmpMbGBQHz8009AjlGX1dblLSYhs45i?=
 =?us-ascii?Q?60yfDSI/RSFBmY2vXPr0lmqiTluamLOn9IGWtYN6mNWB9HMimr+DPh8XmPkM?=
 =?us-ascii?Q?eWZond9cGD6lKI1mrQBUYaltL3MdiJSQapXZnF9jwI3AIp9OfdtGSSWLfjb5?=
 =?us-ascii?Q?DNHeXVv0ra1dhJi1AMgUqzjPArLRGG6Th8Q+pV3GNxM6WCLqNWXgSjUJ6bpC?=
 =?us-ascii?Q?42b6LIHYuT1bnpSZkbmuFubor10ShArdlwdNl03xerAkvdgfhiIC/GmJ41d9?=
 =?us-ascii?Q?PcehwuVngKxEZyANZZWmWDUKHEVoTxDhJ4Osg7IeN28LIFUsT1ffOo9lsMb4?=
 =?us-ascii?Q?EAufZsq4h0qxFNFOeSxV//PObtBEKxRpa8nNJMcXhxZRHUMjSAH0epFrFZUn?=
 =?us-ascii?Q?OOMbPqW7K4RE0wZ7kqjk+bCD1INkTCOv6HNdt/ivIzd5YrBsxqu9GvnblM6y?=
 =?us-ascii?Q?lvjLoDbJoNueo5W/hWfx99i51C7vss+pI0fTkKauRyyXaxTIFg1pyHNqNtMX?=
 =?us-ascii?Q?tTjNlPJh+zdsEASPqDXMiUIdz8FYT+sY9cXCZ5WEAQzXGizoUnqyNQQOGpVZ?=
 =?us-ascii?Q?gkEXb0dzklL0NYx2toJHSPdeDMgk5WZu1anlLSF3nJd/1xRBSe50Ka7LXrvP?=
 =?us-ascii?Q?xdAMtqq6hHlz7dg+JBuNOYy35OExcmndrtDWKfoi7/JA7NepEKyJr6tKV+Xn?=
 =?us-ascii?Q?L5qN6p+eJd9BFmsbh1LZY3kyo/Y4dIvUf5y3ASGTB7C3rF4z68bF53fvFbvT?=
 =?us-ascii?Q?Z8cY3XKXWtzPIjnI9rkhy+8aIWPzwj82K1vfxv4qUVDwwoX1te5dBW48e4OS?=
 =?us-ascii?Q?IY5l+AFyWIVoWebn275AJdStIzhp9VCn6krYVSPYZ0nBR4WrqQmm+HN/qoYM?=
 =?us-ascii?Q?kUMtu8HSiiosztYmZGf8MrFA4RaNvdRngUlg2/heLZS1Y7s6zSqo5R0aWMOM?=
 =?us-ascii?Q?57gnLRb0SL2gHLK7Bub0wtFUeDdf/N6WW+CuyR+IY/X146GWQu2ZbcNrsKHj?=
 =?us-ascii?Q?L7SWk72jKJpklpAqTkFpD7Ie4QvXaGlwd/iXJXyiz0lYtYBHkOG3Y0MihKRy?=
 =?us-ascii?Q?DW2Ep6dHNaW78dquEFLDOganRwRexpIT1M9fu8nqwiBBApSq5DOnY+Ya8wlo?=
 =?us-ascii?Q?6X7wBaW30tm/O/rwW3XpMdvliadDFn0x5lALXg9nVSomzdx2ABavhbsYq5Cv?=
 =?us-ascii?Q?DHj2aBoYKVwxmGGs39/qtiwtNI6a7mt+0EcO92ZVdJICikPHZL0XY7/SKhRf?=
 =?us-ascii?Q?wxVBiGcyL1HxNvCJbKKHnaXWW6glL0fBRabVtMh2WuksysjfvwdvV0vd5Ouh?=
 =?us-ascii?Q?pO2f/UIvWdmh5hp1kUGqfYDyqWmQ0q1Oi7W8O8gMdhQ0pkGPfBqaKlD26IIe?=
 =?us-ascii?Q?lBxPdMl+iRaW3g6ZC9p/HG5O+9l1E0E=3D?=
X-Exchange-RoutingPolicyChecked: q/AtnKslkMFjTih10TKJshOLQLsSwrMQTc9MoofB5WOhfDmsyBzTX49qnv9KNcVMm6WuTBaiibcHMU/qpCli+2dUN56lGPHaGbAFE+cGABA6p6uEPdIlw6Pw79MLeUaR8ujv8ty5UtF4AgU85R9Gu/N2Fg8F7v+Wei160rs8fgSIMLDShKdNmKD9YfGW10G6EQKkfU0bm0bO9OmbnhMsJVMimo2MfuqaO4d3qnYu6o1y9r9HnK/c4nXsykrSSeOcMw3zOkJfs1xCpYvMZOfkNoOMKvbuq8Gwtkuc/IQDOqFpfNnNs7bGEcd1oTRvZYKtlSpxR09Vxz5dc+Gk0o/lww==
X-MS-Exchange-CrossTenant-Network-Message-Id: 174efd76-c7e1-4872-2544-08def94fdf19
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:30:57.6385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4IgKwYinIjn02QphaYQQerDxAFLEvqKJ0wyBgyk85od1hAJluSnmsDCAXo6x9WXd7ihqbhPzBF3RoUsiK6CDcGw9ODtHgh7alktG+ZmF8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB243254
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

On Mon, Aug 10, 2026 at 02:03:53PM +0000, Ciara Loftus wrote:
> Prior to this commit two methods existed for triggering LLDP packet
> transmission in the driver: the dynamic mbuf field method and the mbuf
> packet-type method. This commit removes the dynamic mbuf field method. The
> dynfield method required applications to tag every LLDP packet manually,
> whereas the packet-type method gives the driver the opportunity to tag LLDP
> packets automatically on the Rx path, leaving no work to be done by the
> application to explicitly flag a packet as LLDP before transmission.
> 
> The per-queue LLDP state is reduced from the tri-state 'lldp_mode' to a
> single 'lldp_enabled' boolean. The testpmd command 'set tx lldp on'
> whose purpose was to enable the dynfield lldp method is removed. The
> ptype lldp method is enabled via the enable_ptype_lldp devarg (as has
> always been the case since support was introduced):
> 
> 	-a 0000:xx:xx.x,enable_ptype_lldp=1
> 
> The deprecation notice for the dynfield is removed and the driver
> documentation is updated.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  doc/guides/nics/intel_vf.rst                  | 29 +--------
>  doc/guides/rel_notes/deprecation.rst          |  4 --
>  doc/guides/rel_notes/release_26_11.rst        |  5 ++
>  drivers/net/intel/common/tx.h                 |  2 +-
>  drivers/net/intel/iavf/iavf_ethdev.c          | 28 +--------
>  drivers/net/intel/iavf/iavf_rxtx.c            | 15 ++---
>  drivers/net/intel/iavf/iavf_rxtx.h            | 17 +-----
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 22 +++----
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 22 +++----
>  drivers/net/intel/iavf/iavf_testpmd.c         | 61 -------------------
>  10 files changed, 43 insertions(+), 162 deletions(-)
> 
Good cleanup, thanks.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

