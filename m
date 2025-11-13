Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEF9CD5BCE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 11:36:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BB2840DCD;
	Thu, 13 Nov 2025 12:36:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id F0E8C406A2
 for <dev@dpdk.org>; Thu, 13 Nov 2025 12:36:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763033761; x=1794569761;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=yKtbp0Ox7CDUEVN+vK1X+mj8UmBKnpyQj7KusSJwDpc=;
 b=Z/zKWRvWsEtsV9iIYtSCZZ26MB9S9Tj7hsvhK7KgUZ3CAROiRUb6X9xb
 AKrBCGe/t/0e+R/q6J+L1fVirUVDyuDrO34z1JOy3yTXNZk1PxEL+t0uH
 FQ55MmhZxbS6brhI3HUVcMV2NcL7+3l+ivqWytbxM2aOB+nYchvYMViDG
 1q2H1NUnLr6RO82ry0ElFYj66mhCzQJeFhsqEoZ6glqvBOd45dE8PMNMD
 dtswu+c1zNsPNbxzfJL1stid9/q1iEbfGfLVsbxuUsN8bmG4i/qA+8lrJ
 xR2sBQp7kMobvEQuxOp8gJH80oJ3ISacbUocaoZCOMSbQZ81cE5/ymJ+9 g==;
X-CSE-ConnectionGUID: 4E7p5oLSSAOuQRf2gM01lg==
X-CSE-MsgGUID: TFniro7AQlOzk1cPvGzAAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="65205263"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="65205263"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 03:36:00 -0800
X-CSE-ConnectionGUID: e/SN545qT/SGo0mC7GDS/Q==
X-CSE-MsgGUID: TGmuZqZmRmmeicaOz31wmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="188750201"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 03:36:00 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 03:35:59 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 03:35:59 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.18) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 03:35:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGVOYuF9qIUieRaGB0FDhv33qlM+CHal2ntmvnwlqIi50RjZip7X/LmEQrApbVqPt4p8h8q7BTyzsT3R0sm/F2NKFepPzHslEexNOjojrOvXzdkNNfT4tbNt5/I+nxxG2Taa79ScTlVINyS0ebV4etqs0Z3+3JA9r/6wdeC+6b1WMXGkZGbEgv993yRwBuoL8sHCfcyvI8Ejb2nr94MFxWuyGY71WZOuILA0AriwHHuP/yn6U4Xatbl1k2hh87Vr1vbNTGC3vaWgXEDIVYicPD5P6bpng30cGGGcAxy0RWBBi9a9AVel69570HiXtyHict49JYTBKKwiJRedcJaN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZpyRUL/YdlqiYTQVTLU0C4xztLqulAlgPkaXlOoiKw=;
 b=eNaFRGIbEz4PgmEPO/fMveUMiBx4qQI670jE1x4S4katv9g/1ReRKQGzOap3jXdOCJctPtwSSxtm8gE5mDLp+dRIeV+RNiDx5d5eNRGYBnWBO3BVbrekkm+5M1hL144opQEb85AfTMiDkEWelWDGZxNEbEAP0bBi1HEkk5vEvWxIOq4yFTIKAihUKZ3QyYOom8EobbBKpdnUSJgO2y2tBjRK6i8a7BHyHjfTpBtm1YY2UN+U/h2dVIeMevkbzBlZwo1/sn9V05Hlflk7GJaVIZLGRuB6Qe6HMGw7oBWv9LdoR1UUNLnJriI5cawBhOID5Pt51wbYQpcu3fmVkW6lOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6089.namprd11.prod.outlook.com (2603:10b6:930:2f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 11:35:52 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 11:35:52 +0000
Date: Thu, 13 Nov 2025 11:35:47 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/ice: add MAC anti-spoof disable option
Message-ID: <aRXCkzTTkhjwWLI1@bricha3-mobl1.ger.corp.intel.com>
References: <20251113105914.34949-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251113105914.34949-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: d86eb42c-4512-4fe7-042c-08de22a8cd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g3w96754NuZdr4Y2zF+wlgRZF/828xynD3wtXfKvqdd2dLK34TK2hP7VwaQa?=
 =?us-ascii?Q?Lb/sHaUuddeB6/jTTWgxVE0f45idedq8nJD6QWwFZCESveB1J3DXFYMk02QX?=
 =?us-ascii?Q?Z/w5fhVKArVuTUDFwhVQTIZwI2NgXm/dsWFLGvTEwLh1Dheo5Dh8M+Bf1BRy?=
 =?us-ascii?Q?heiK9N/hjMGl8p2Z3NUrBFmeo4K9IDcuur2OiPlqBKLjtgdlzVx2vzaV0L1z?=
 =?us-ascii?Q?eYnBAlK7+4uPFT6aH6jlbD8p7j44+rFiFvxhlinXLaEMdbQjmhiKbM6OjMtd?=
 =?us-ascii?Q?XGdTKbYZLzZXtGPevnlVwh1vnVLbKv7e4Xp+1ihntN0yIOuy25cls2IwFqfa?=
 =?us-ascii?Q?Ae8w2eq6plBYLs0xOdlBksa2HIjVP0q2BJrjHzrqMhrE9ElDSZUZJbqEjlwh?=
 =?us-ascii?Q?Zd7eSSGVlkKrKMEltCwTflvkuxWHOypCqSkkt/2xBVI6n7pIl9HSO+Atd01G?=
 =?us-ascii?Q?XfkXS3SbBijMsnz8TsYR+KSTdCz3C7X1Na55winAmPP8H5bFFoWvz2WqInms?=
 =?us-ascii?Q?5h5rDWwMvyr8bmKXmyXIocvf60hdu6L/L30ChHLhQOIfZhvEI4PGz1gMSatl?=
 =?us-ascii?Q?B3amzyBYmoAN+NHEtKWMAygKaFxTVkNj+9SF9NfXKha54ouWeKgQg0d6voSL?=
 =?us-ascii?Q?OH72v7R7BefiTIqerMQso7u3gnaGS1iwlfkXnBm/g2WV6rQtd3jb0ZVqBGb9?=
 =?us-ascii?Q?xE9NOxx9nqBFNG9oLUA41l7Ji0zS0ussyjYMCgg3YTGxIjREGWEHlErMXXPK?=
 =?us-ascii?Q?kXb6IabA4o3VKbkqpki1OwykRfJsqEVAn5KqLC2lt3ApAY4K+BcaUzU3V38V?=
 =?us-ascii?Q?cF4qpGt6S/VMHokpd+ZaWxBCwPzO+hRURBGB/uVYdv9x2A5NNcEhn7I2f92C?=
 =?us-ascii?Q?PxGZsJNrXkjHdJ3xLcXSmmOd1kXSKqXGyD1XaDEG4qeGua0ziwvQdJpf0qJA?=
 =?us-ascii?Q?x5sgALY9DgArSKuDBv36imDqIh8iucwJiXoa1ZLs6r25aAJ57l4Bl2jYxjCI?=
 =?us-ascii?Q?Vf7GCZDIysuJZUiBKgHDtD8z6QhxDP/yyki8jXzXuST9N5rSgV6CrSDcVdzp?=
 =?us-ascii?Q?28zcfCeJ4TTKNjz3HpbKTlDmK76gDyx9vYFxGuUpAigIwvTbyd5ezaUTSMid?=
 =?us-ascii?Q?EqPjxdeJh0pDoBRWxJz52yPoRV0dlCyUd3Lbnlo+CQfBZFtLC5nqqZKWhG+q?=
 =?us-ascii?Q?l847SEisZIWpGU/s6WVvitJXhdqM9qbwGQUcpApUEK2inXkgfnjPALavMh5X?=
 =?us-ascii?Q?X4O4h5UXQXi1qbU0ManBp13gyQbVGglzSBVePmbsztpd3TCJ87gf54jnWsUm?=
 =?us-ascii?Q?Amrka0A+wziLfK9hfjo3m8qjccpQ8MBizRp7Jk5LTv6bVP0naQkqFE8EnKCB?=
 =?us-ascii?Q?4ZrbQu/hjCJtTHjAqEk0kB5RxMgOpax5xpGhVQXiA1Uz714VURdOH84Z3XSd?=
 =?us-ascii?Q?sHS7eFqNhZQdQzZf7u7LKOwxfqGN3sC1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ThKthY4TvvPZdOMz57Q/iSLVUp1e1vIcNg+OTah1v0wDnNzT2qjFB7VcK7BC?=
 =?us-ascii?Q?3wJee/sFeWPVbKmiBJbO8H4+zRrAlfTNXktQ5nH3Xodbw9EhoI/WB//cfehw?=
 =?us-ascii?Q?1SGDIWyDyh/iGvgwXvu14hZHe2ld24/9R816u465DASVYPmS4xbDhUFJ7sBM?=
 =?us-ascii?Q?gFCFLaqNcSeqXfsDB6zAmbNjdGCn7i6ZeZDqfmDGGChkI0bSFCbtW0CAqouC?=
 =?us-ascii?Q?x1j5Det9FXDH/eL3oR+zHmcRAoJJDkHu4b7WRnAXpHrY81EGA6AlV4fFQldL?=
 =?us-ascii?Q?kJXpNBKetTAsHnCv1Fj7fuakENMWrspbXh+1hJ0FMo3Kf98ZkvBEH0TmLqcy?=
 =?us-ascii?Q?nfqsQblM9Q+dpWZ18RsTJ95c/IALceO8Zr65vD8/VVoCtfL1moMdtju7mweg?=
 =?us-ascii?Q?JpEABM7nZ/iGiy7tYrA/Oj26GhGAimI7DzM/tUiJWEJ/jyMyqiESoTIAFx5A?=
 =?us-ascii?Q?2/eBOsneQ0D3ELiubOdKIjXDw7Lp+SfuwrWJVLs1tWzhCMhQ/DXM1Za8KjE8?=
 =?us-ascii?Q?aDVF0TveqMTR2Z+iOYdwXbNZc8HAhjKsWCLq6ARhWhSIUTU7iJb79rmAbfS/?=
 =?us-ascii?Q?V7nv6Eg33mC4uzgEc85KwZdy4Hrslf96jBNYAablItPBpAsoE2Cy99B7QuIT?=
 =?us-ascii?Q?m/55LuTG+2PRemKkyVBsWW0kWfPvv0XKDsKWHg4XU5Lnrz44qH6ixLGo8+k0?=
 =?us-ascii?Q?ZEaE+mt26QAup/yb72cHWs39ng4ok5Q5NwfruoG8rzjqgda9nHJqJBiJ0Q8/?=
 =?us-ascii?Q?1I3qcU8OGOTS1DZoE5TcIzo0B9v0LCmnKVjninXQ29Z86DXmSfiI1LScDxTm?=
 =?us-ascii?Q?PEmYlgmzOixa81cDJqP/f1oI72V+24HSUgZanBSTkOP/K35/NDL5F8N5K7au?=
 =?us-ascii?Q?YFsCIoqsQWGlqHzefhLxjYIzHCfmt5vCaWPUoscue6ERGtbfrtRIt9UDe5A0?=
 =?us-ascii?Q?cgEG60u35cSk3G2b0vDXvNbpzbOS0B06tCG5jCh/8PHhLh623Tbhq99rsmfS?=
 =?us-ascii?Q?kHNUch8oVbxC6To+UoXQwpZtkfg7STnS4zLobLi60H0m2/L/zVw8zSBFEhDU?=
 =?us-ascii?Q?5ntsvw3olr89xchET2UoYOTK48GsAQoo83ovMT6ge7biRzwBfZGiDjhSVZzR?=
 =?us-ascii?Q?qgbs/55ijmzvBD23yg567UYUbVF+DQqKsLkGoTjtnQDwJV0q0GMHKrJAEs4D?=
 =?us-ascii?Q?wDmSAGvTM6Dv8Ms+86p2OcR1jyBeroio2uCVyia9dZw37PfUfA59NXqrWQYJ?=
 =?us-ascii?Q?AIAKeSpYdMPe2qZU6fxRLfh+kAVYcmJ5Crll8Ppa5oCDn8G8TzKxIgZa/s6Y?=
 =?us-ascii?Q?JruWav4m7VcDiLsd+eZ4lxnxXjbC07nbdAW0pWi7e/+dIBNrXFqqXvgrqanR?=
 =?us-ascii?Q?DEPOWxudM2qNDuLzs/4lW7zNzoOHUHXCJJQtzBe4YIU9i9DtQYvqdUeEhOaB?=
 =?us-ascii?Q?jYRm0NYjumyOV6H9YX+yKef4LTRUjSrFLv2j6QSJlF31flouY7xOQjsPNskY?=
 =?us-ascii?Q?QfeAXEP3PTSsLaaap9g8ClIRTuC00O2I9/ASAOW6rJBR2MKMWfFZck+i11JF?=
 =?us-ascii?Q?zt8KcfcC4hOjVCyLczUizZ1jiiXu9tJood6Loom0v8BzfVCrSwKoEFopImbF?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d86eb42c-4512-4fe7-042c-08de22a8cd0a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:35:52.4270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmF433/RaK3GCYqWEcPcMZ9d/Npbm/wPnllObWEpyhhX3z9JjQfIKWijZcbolvvWSBAjd9/XKi3H+hrEudMeKwdaVDGalqGf/5H7zIFOJI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6089
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

On Thu, Nov 13, 2025 at 10:59:14AM +0000, Anurag Mandal wrote:
> VRRP advertisement packets are dropped as TX-errors upon transmission from
> a vsi of ice PF due to MAC anti-spoof check. There is no way to disable
> this check in the Tx direction to avoid these packets being dropped.
> 
> This patch introduces devarg "mac-anti-spoof-disable" to allow user to
> disable MAC anti-spoof check. Disable MAC Anti-spoof check in the Tx
> direction to avoid getting dropped as TX-errors upon packet transmission
> when their source MAC address matches one of the MAC addresses assigned
> to that same NIC port.
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>

See feedback inline below.

/Bruce

> ---
>  doc/guides/nics/ice.rst            | 11 +++++++++++
>  drivers/net/intel/ice/ice_ethdev.c | 22 ++++++++++++++++++++++
>  drivers/net/intel/ice/ice_ethdev.h |  1 +
>  3 files changed, 34 insertions(+)
> 
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index 6cc27cefa7..bc86de0081 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -194,6 +194,17 @@ Runtime Configuration
>  
>      -a 80:00.0,source-prune=1
>  
> +- ``MAC Anti-spoof Disable`` (default ``0``)
> +
> +  Disable MAC Anti-spoof check in the Tx direction to avoid getting dropped
> +  as TX-errors upon packet transmission when their source MAC address
> +  matches one of the MAC addresses assigned to that same NIC port.
> +
> +  MAC Anti-spoof can be disabled by setting the devargs parameter ``mac-anti-spoof-disable``,
> +  for example::
> +
> +    -a 80:00.0,mac-anti-spoof-disable=1
> +

I dislike as a point of principle having options with "disable" in the
name, because it means that the normal logic for on/off is reversed. For
example, in this case to enable anti-spoof you set it to 0. Also, having
disable in the name makes the name longer!

How about having this setting called "mac-anti-spoof" and setting the
default to 1.

>  - ``Protocol extraction for per queue``
>  
>    Configure the RX queues to do protocol extraction into mbuf for protocol
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index c1d92435d1..a0eae74bbb 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -42,6 +42,7 @@
>  #define ICE_DDP_LOAD_SCHED_ARG    "ddp_load_sched_topo"
>  #define ICE_TM_LEVELS_ARG         "tm_sched_levels"
>  #define ICE_SOURCE_PRUNE_ARG      "source-prune"
> +#define ICE_MAC_ANTI_SPOOF_DISABLE "mac-anti-spoof-disable"
>  #define ICE_LINK_STATE_ON_CLOSE   "link_state_on_close"
>  
>  #define ICE_CYCLECOUNTER_MASK  0xffffffffffffffffULL
> @@ -60,6 +61,7 @@ static const char * const ice_valid_args[] = {
>  	ICE_DDP_LOAD_SCHED_ARG,
>  	ICE_TM_LEVELS_ARG,
>  	ICE_SOURCE_PRUNE_ARG,
> +	ICE_MAC_ANTI_SPOOF_DISABLE,
>  	ICE_LINK_STATE_ON_CLOSE,
>  	NULL
>  };
> @@ -1768,6 +1770,20 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
>  			vsi_ctx.info.sw_flags |=
>  				ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
>  		}
> +		/* MAC Anti-Spoof */
> +		if (ad->devargs.mac_anti_spoof_disable == 1) {
> +			/* Disable mac anti-spoof check in the
> +			 * Tx direction to avoid getting dropped
> +			 * as TX-errors for VRRP support when
> +			 * mac-anti-spoof-disable devarg is set
> +			 */
> +			vsi_ctx.info.sw_flags &=
> +				~ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;

If the source prune feature conflicts with the anti-spoof one in some way,
then we need to check at devargs processing time for conflicts and warn the
user. Also, if the user specifies on flag which changes the default of the
other, a logging message should be emitted (e.g. at INFO or NOTICE level)

> +			vsi_ctx.info.sw_flags |=
> +				ICE_AQ_VSI_SW_FLAG_ALLOW_LB;
> +			vsi_ctx.info.sec_flags =
> +				ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF;

This seems strange to me. When anti-spoof disable flag is set, we turn on
the ENA (enable, right?) MAC_ANTI_SPOOF flag?

> +		}
>  		cfg = ICE_AQ_VSI_PROP_SW_VALID;
>  		vsi_ctx.info.valid_sections |= rte_cpu_to_le_16(cfg);
>  		vsi_ctx.info.sw_flags2 = ICE_AQ_VSI_SW_FLAG_LAN_ENA;
> @@ -2467,6 +2483,11 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
>  	if (ret)
>  		goto bail;
>  
> +	ret = rte_kvargs_process(kvlist, ICE_MAC_ANTI_SPOOF_DISABLE,
> +				 &parse_bool, &ad->devargs.mac_anti_spoof_disable);
> +	if (ret)
> +		goto bail;
> +
>  	ret = rte_kvargs_process(kvlist, ICE_LINK_STATE_ON_CLOSE,
>  				 &parse_link_state_on_close, &ad->devargs.link_state_on_close);
>  
> @@ -7732,6 +7753,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_ice,
>  			      ICE_DDP_LOAD_SCHED_ARG "=<0|1>"
>  			      ICE_TM_LEVELS_ARG "=<N>"
>  			      ICE_SOURCE_PRUNE_ARG "=<0|1>"
> +			      ICE_MAC_ANTI_SPOOF_DISABLE "=<0|1>"
>  			      ICE_RX_LOW_LATENCY_ARG "=<0|1>"
>  			      ICE_LINK_STATE_ON_CLOSE "=<down|up|initial>");
>  
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index 72ed65f13b..9b36627d12 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -617,6 +617,7 @@ struct ice_devargs {
>  	uint8_t ddp_load_sched;
>  	uint8_t tm_exposed_levels;
>  	uint8_t source_prune;
> +	uint8_t mac_anti_spoof_disable;
>  	int link_state_on_close;
>  	int xtr_field_offs;
>  	uint8_t xtr_flag_offs[PROTO_XTR_MAX];
> -- 
> 2.34.1
> 
