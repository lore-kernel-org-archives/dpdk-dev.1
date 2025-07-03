Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A706DC83030
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 12:46:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B900340267;
	Thu,  3 Jul 2025 14:46:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 31D8040264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 14:46:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751546772; x=1783082772;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=97KO8M44j+OviLocvBqF+F7G9nSjNXx+nR+biozbKhY=;
 b=kjZG2Y/ixHQ3BkBtnVPJdKS9rDA2zi0bxfmKUaNQZErdueRgoYJ9uEUE
 9oyD3cSM8E4imsbh9iDCFjKCQXZxACViaHB5U/rG4OmnsnImuShVpi8ra
 m9tedZ9a9glIYVQZVpci4YvlGu95v2nfbBorKLD/jcDUVgyQDOCEXJJy1
 geXfn69IwrXmvpnlp2dYJprIFimfBAloFVpMraTjIy+JfDOrLlqeHc+ob
 f7UvcUaiU+URI2Csg2uO99+2AYUzWyFFtUB0U3jclcZ+pgIn2EV+vH8fe
 J5Jc6LWvwJW5a/yaMng1OB1k789WAfA4m6F44ANuvPom+3QcIYX/BOheB w==;
X-CSE-ConnectionGUID: 0jslkM9vTR2V+kWf30BWFA==
X-CSE-MsgGUID: /HbPBaxZQ/eguHaLDFncCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="57679763"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="57679763"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 05:46:11 -0700
X-CSE-ConnectionGUID: Ozx6EnnDQLqJnoOjnQBFSA==
X-CSE-MsgGUID: 2S4DXNazQ6a15EtXgy9BVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="158403565"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 05:46:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 05:46:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 05:46:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 05:46:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HexDTER3eH4Wt4f5McL/X0w6z757RbyQpL2SXCgt6OwUjx5sntNa5Nm7JCanMUnI9+LZ/VsNLbhm+chU5tsgaw/ZBDrSxkWaaAs87x5UwWVRPsQUZr6UwXhvP47llvJCRQGMdVFkpNB6tuD2LWwaqbDHi71IwtX/wehnu+d3Ei/IgSbjwzVLYxUQS6UjJZoHI7gXnnMwiLNlGnfmkr5lnlvGiO0FKuc+d9nR/b97adkxzQzaFLrhDu2dhyoPUKft8r7bOVkRJ8KH+302qe4DAvEmo7PINQBhsCPnCm9a18YiyQ5O2joHr5kpeHlLdQl7UXiMyCiH+98xak7LlvCw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWzMMLd2uYzAC8NQe3q1eQc87I7XKCyOgT5u7XnWg20=;
 b=Z86kTUssdVwqulrpQ69kEtfYKWG6qVf2veF3PCgoKI+kK2ffg/of+VG2hb0FHJHjbWyj/eW7uBWzmkvRT0RvPbc4DHV1q+c5R6wUI8SvnpIcYtAczB3FUU45a0vEtZACoIkd6x43H+P9S+MOVdKpyS4WBBj2OA95Qqfw8IxiZhYh+iatzRPFZYO87kHqlhRfTIP/E70ZO/r5N5i0JI8cvdoK8bMvWa6+p6aZ/t3YY4ydA6ulgnRlHawS1V8ae4JrNefQoCHm9WdqaY1T7TCoDEh+YaBpy3NR9fXH+bSNkuj6mr2sHY64eNyUF+3xSmAh6uxPtbdrqKhlq7o0AnRyOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB8299.namprd11.prod.outlook.com (2603:10b6:a03:53f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 12:45:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 12:45:35 +0000
Date: Thu, 3 Jul 2025 13:45:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/intel: deprecate some SSE paths
Message-ID: <aGZ7a0Wha4DyfrZo@bricha3-mobl1.ger.corp.intel.com>
References: <20250703121624.1050845-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250703121624.1050845-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DB9PR05CA0013.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: a15eae24-cb40-453a-dc38-08ddba2f815f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ttkFnnmh2M/jBoHBtK/SnoHCftjQD7TNPFTecLUHJ91CvBuFIgS+iYylJo6b?=
 =?us-ascii?Q?cSz3MsK2fmZtts22Hda0Qq1DRhmuFfhM7QMcF0hZR5kwFEIX3aagUabYG3WB?=
 =?us-ascii?Q?sMnXvYBujV+sWoc26m/rNKMk72AQw8fOl4Pjz6KceO1yi0/0YHovjO0Jn3VZ?=
 =?us-ascii?Q?5vAdu+dSiB1M89O/vB0Bedh006gGzoBl0VZcr/BXjo3POUp2axcqr7GnbYns?=
 =?us-ascii?Q?0qKtnRoJeD9NZ+gsnILuBtdenTbc5qcisMtQj+Q9A22P2O9zGCzIEgI4+Dta?=
 =?us-ascii?Q?JxW4zO01vi6xr2zHgSjHcT/IyEfrrJTzoTFh2EmJITEJ1ao2eDZjJYQ+CJKl?=
 =?us-ascii?Q?1F4LtPwsqDBxN2eOpY7CEqUDAgoC1mkgonXsBXI/pEZ6NhWy6Oxxioi/yKA1?=
 =?us-ascii?Q?Zn+pwlHOS3WSzw6ooGy04g6JLmHno4K8n+vM33qofktsH9wPd/wKDOywCHAD?=
 =?us-ascii?Q?85kFeAsnod7EOu0opOyp6D6r654wr31byLCfJtZlGF3WRjd5jlWiKujs1Bxf?=
 =?us-ascii?Q?zIbfo9GjqQxzgEaaRPNOSRpy8+qL3unpmxAJTiX54KsFQU0dwgMCuWISy8Hc?=
 =?us-ascii?Q?VytFPiw6o8/u04QwoPHZ33k898IbVKfWq1FnPvFHht58oeMJkx1IPnr0wV8M?=
 =?us-ascii?Q?PHcpKH13ZBi7Omk9h/cQteNy1QXN5dOSiktziY/hgLM4zsM+VDlCmgIGCIhw?=
 =?us-ascii?Q?VN4eBlQj1/CxdNiYPi9TV7tG6YNVyzfL438jFHOWMaJ1iNJmLUEY9JJWUt9Z?=
 =?us-ascii?Q?PatPnJY8bqoe3DoyFIFKPT0dqyv2EMs44UpOwRzlDxfaWixQe3a0eeQtdnqs?=
 =?us-ascii?Q?ys6PmJszhbEfpv6ectXtDsxKq9o0OMZa9oXPKvVhDXJQGGSePOESL6/cW8Em?=
 =?us-ascii?Q?NSGSOOhnEwWDnwrCjw8VuOJoxsqfUrwoIdd16Ie9M3cJw90f63T1yctHv8Ny?=
 =?us-ascii?Q?VYofv208tCTT4kHA9eN3w/prZYYfdj3iqeLSAReNz0R1wtM5sgnnvEfyCsH9?=
 =?us-ascii?Q?bMDVGDNTVibe+xLXP28drpmsB/12m38bBW/+MC3xYKRUrEe0kr9NKjS9pCL6?=
 =?us-ascii?Q?Lb2OR2tzk1d7YysKh/V8CxLNBzSpcFwkv0eokadZBJPIW0w202XVu1t5LxVY?=
 =?us-ascii?Q?GWPd6eXLCy8W4RS9Yq2xCPqqpF7zbg8XLAW6A2hOZlSqo4PcOpLiwgSlJxdM?=
 =?us-ascii?Q?Rp9h32qUcXctwDn8+A7Cg507ss6KrMqPVvJ65iYaXbzJ5KfuFfyI+GPb3FSW?=
 =?us-ascii?Q?o1cOYZwEDJchi3PZUpFRXEXYcHH+KuL447sYozEcEJdO1vCrdjHxK59hztxu?=
 =?us-ascii?Q?akeLxPMFRBtB/96EAWPTRLcvXdbpgUc5SgHd+s7gNrHuFlGDs60uJ7fysOlm?=
 =?us-ascii?Q?2MzibdRmR6C2YN1CJdjzfvm7GeOrVRnlihakZTD/i//5e2Ni2f52waWAp4Ud?=
 =?us-ascii?Q?76Q3SLj9n68=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qG8rxOMNi8gkrOHQcrZk7ORsN9wLZWzcTaA8F9S6aH2oCF0daWUY0PL2sTc2?=
 =?us-ascii?Q?Nyqmun/eSuTubHkVYkBY0U9bpHXEP6hQGT/EGklFXkKAFkjrhUtYpTkXeCtx?=
 =?us-ascii?Q?AsHBPAJXqNH7SEFbOuTRuBUYxQDzf4D0AxrG4a9pA8nKNLpbgwPlossKPiJF?=
 =?us-ascii?Q?qKAj20833O/7UdjHy+kXDkWSKIbMwOP+EsWH2j1S8rZgHXnhlfNtxbuY8IhT?=
 =?us-ascii?Q?75CZG7jA1H+pUmFX8fV3DGWJUcrNLQ0vPjMURR+lGsnYy9f51lRfyUuNQ1Sh?=
 =?us-ascii?Q?IDjY/0AbvHRs/mVXdNQDV8vQP7q0zv1MPS5QxYrefAxVoMvYb2RtMNaqn3jr?=
 =?us-ascii?Q?C6+hPldvwXC+4DniO2+T7AwvAITOzdfH7ZoQVJYvi+YSWHq9z8pzf7ZP2pRM?=
 =?us-ascii?Q?2f+REZTsO/T1zVrI7I85lA6D1Q12m2wzcye4Q4naxko49UaR1K0oU/0X6AXh?=
 =?us-ascii?Q?IcgiAVXFkdLmxuE01vVn+7yu2AraYGK3gNx8Sjh2nfs3caHBs7+aTvZk34IZ?=
 =?us-ascii?Q?ktF3S9lGobB0Bh94GweBud6N0KlWVjoSEkL5DFzpxqsCpuJUMufgiPXJonn7?=
 =?us-ascii?Q?3j0jKQWx8YM88VRN3ZGAqCUumPCSrTgfnQyaIOcv0Fw3dzEd5qZ7YvsLFBFV?=
 =?us-ascii?Q?uFq9vJ1W+ORnBOqL1Z/iQvDjRlT9KcU4vHiW/ABqYyKc8sHUW38bYtU4d15j?=
 =?us-ascii?Q?d/WAdbqB6y1XIL6VytnikX7ve7YoHgWte/Jgq8j2kg9MpGKlz5TJRPfdLbEK?=
 =?us-ascii?Q?n/fPQ8FcbiVATcCXYbYPJDkKdSjHwrNWvarTRBKsIIY/WydFxH+nFM2xNiHj?=
 =?us-ascii?Q?xp75ptHunLZ/62aknbJCsDNAGI353QeNt8qrfrLmp4d7wopExUH9XctXighC?=
 =?us-ascii?Q?3DiOJgIKzLMybuyGZAmA7o87vC4Mit8741hQdzM3/nig7zrA8j3nq4Ttc4Hb?=
 =?us-ascii?Q?41OslfFQ9GOGLoEfWhBO0L2mHFeDSkd6tsKf673vPjHGDggS4x2eA76qCog3?=
 =?us-ascii?Q?/HnJTGMN/MFfWqDsspuCqba5BbkxPbIvf5HigafXGh1DokYr+Jte2LmrtBrK?=
 =?us-ascii?Q?avuBJkXUUc0z5i0EgP9g8QKKphb93w4Bilq84IOg7A2KhzGxfH+a1vgjP7V/?=
 =?us-ascii?Q?8QoJ5mZBJjLRIeGWgLf7fKvU5SJBMQL8MXuQYXxEd+XgAdIBBC9dFxrlURJI?=
 =?us-ascii?Q?b6PoG6FylihpSXm03/JcG5yrTJeB8TqZoI62L2sMkEXLmBhOD2r+lNU6PWVe?=
 =?us-ascii?Q?BNdPUrFtkWLCwVvKGyQln3x6vgp/w+5/gbFqnnH43JoUkvzBnDxTKmInsiBY?=
 =?us-ascii?Q?8j3vLzpt+zLNJ4fDiZeATe6U0LZ0yg5qAlyTPWJOz7aMx8ryYz9CUDBGv+jI?=
 =?us-ascii?Q?XHp+/Ho5K9OQdp+wiLhoWWQ9b1DN8q5eXHG52Pr4oC80Pdziv3DGf8caPwo7?=
 =?us-ascii?Q?ltcxs50SXVErr54OcBUTqS1dnn+bbDJ9WWEOHjTJhUym4SBYGNc8IqGsmGtu?=
 =?us-ascii?Q?V5HAJBB+DEwZfONozh0vcBWzo0zVphbYKgwIlsxMEbHtyTqOQT+ddT1DsjBY?=
 =?us-ascii?Q?qcTBXmydlNnkOxwrs6vMJsN4WGRH9fP2h+83m1rHfZnRjxSewweyMa41bp52?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a15eae24-cb40-453a-dc38-08ddba2f815f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 12:45:35.5699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqRzuGx78u4DbwmodAJf4CuhuzNpMJUYEMCQaGBAKFhAiQiFimTTjvV3OpU9svoUoLnRGXPsdeWJHBWSuxHD1lHcohHlVJPj3SM6N0KG76A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8299
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

On Thu, Jul 03, 2025 at 12:16:24PM +0000, Ciara Loftus wrote:
> The SSE rx and tx paths will be removed from the i40e, iavf and ice
> drivers in the 25.11 release. Each of these drivers have faster vector
> paths (AVX2 and AVX-512) which have feature parity with the soon to be
> removed SSE paths. In environments where AVX2 or AVX-512 are not
> supported, the scalar path will still be used, which also has feature
> parity.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  doc/guides/rel_notes/deprecation.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
> index e2d4125308..7b9b6beaa5 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -80,6 +80,11 @@ Deprecation Notices
>    and the header struct ``rte_vxlan_gpe_hdr`` with the macro ``RTE_ETHER_VXLAN_GPE_HLEN``
>    will be removed in DPDK 25.11.
>  
> +* net/intel: drivers that have an SSE vector path alongside other vector paths, namely
> +  i40e, iavf and ice, will have their SSE vector paths removed in DPDK 25.11. This change
> +  will not result in any feature loss, as the fallback scalar paths which have feature
> +  parity with SSE will be used in the cases where the SSE paths would have been used.
> +

Hi Ciara,

I think it would be good to mention AVX in the deprecation notice as well
as in the commit log, since it's not as though we are removing the SSE to
have all apps drop down to scalar. Instead, it's being deprecated because
modern x86 systems all support AVX2, if not AXV-512, so SSE code path
should be unnecessary in new deployments.

/Bruce

>  * ethdev: The flow API matching pattern structures, ``struct rte_flow_item_*``,
>    should start with relevant protocol header structure from lib/net/.
>    The individual protocol header fields and the protocol header struct
> -- 
> 2.34.1
> 
