Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE86C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 08:00:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA0A3402E9;
	Tue,  1 Sep 2026 10:00:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 182864027E
 for <dev@dpdk.org>; Tue,  1 Sep 2026 10:00:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788249622; x=1819785622;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gk9Q7tM00K8giiWfm4q0w2JAcMwsBFG/3uoOI2LwBsM=;
 b=WDOpN7UKhcWxjVrBijhzUHXTCwhRnoxPQRtXQKcUridK25+0tD7aD0FT
 Ow4oRNl6lQ+ZvfCH1hGdFWttCYYhadoEBQ8vajpT9JApkJ3r5x6VXAWP2
 k3A8S2ej/Ie+86cKzdzZ9q88EIsmmG6vdiMxMpSw6kyiakD43QGCIjkRV
 4myEe6VB/tgHvRiIkCGMEbNqNtF9nxJj/q5HzhE6XVI5li6e9+bw2Uzhp
 YxhgebZbhGCTpvrRemJOVu77rR+kXzhjEINqDiJQiWGEA42mFPZwKxv+J
 iPcwFzqSvAOCo79VFeWoEi8RRxgDjaBLjROgffVFpOUMRjTDJrj3NuHbt g==;
X-CSE-ConnectionGUID: amuRQCqPT4SjEGoUpEY4tQ==
X-CSE-MsgGUID: vxYxnHArTxW2UqODorZj9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92484348"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="92484348"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 01:00:21 -0700
X-CSE-ConnectionGUID: 5UehSW4TRxSC5A7NhUU6mg==
X-CSE-MsgGUID: 6wUEHByBR/2wA9Nwj3Ifcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="268493114"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 01:00:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 01:00:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 01:00:20 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 01:00:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFqOpawcv00fdk5DecIjXCrLTPdxBYudXyonKnnteaCI3gtwm8moEvqMpfWP7rwhFT94bknle9KMi8tgPxvAAq/1f88qXFEBp9PYHT531/GI6j5xrU9IqEMgrUPYq6DJXiXIPMYOV0Rs8ZiM28UAzf25yiz/H7/wWjJJboe3zgI7YRK1Hby8vs5au3ByQVvPVIHiGEjeyCSuoMuy1QiolE37MUPVfDk/hpvulysvGwsymC3RKoB50U88ayvfxNUTn/Gs04bR0Nqc+V5nMDSzyl3sfkZAF0KT7uGrhZcgCuJUSqgX3RU9M3fgjWOiStkDhNcFATmpqzjKU9ggW2lvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlM0B7aobhlz2SvHvrT8Mzld4iN2VNRchEii9/RPY8w=;
 b=CsfZWRxrXg2flX+GdFweMLeZHa/1l4InEQ8HhWHMifbzCeO4VZBLRMFHLxhFhWuumnXftgu1qlOnLKkhdFHH5oGaoK6lGue8LhAgIzc2Od9Ac50dEWBRezBseawCVkI35qJa5GaU9MJqS7eEq1L6ifsHgWLat0MyoJuCJwVGaQEa43b/GW1BjNQ52+bS8ISYyWfi91th24fgaLftd9kMd5OnXNp8Hc/OqGf3I5KFz7Ckd8y+YXiY+DKbBMvlhvto1j/q78LKbXpCDDcr5Id+mPsW1mdNTMX8KBevdLq8s1OtjrmjUohmVGKPDSO/3mAXlUpMTpJKUS8gVAMkTObEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA1PR11MB6347.namprd11.prod.outlook.com (2603:10b6:208:388::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:00:17 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:00:17 +0000
Date: Tue, 1 Sep 2026 09:00:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, Sunil Pai G <sunil.pai.g@intel.com>, Jiayu Hu
 <hujiayu.hu@foxmail.com>
Subject: Re: [PATCH v2] vhost: remove dependency on PCI library
Message-ID: <apaGCjzrVq4XyiJp@bricha3-mobl1.ger.corp.intel.com>
References: <20260831074159.1506521-1-david.marchand@redhat.com>
 <20260901070024.1606766-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260901070024.1606766-1-david.marchand@redhat.com>
X-ClientProxiedBy: DU7P190CA0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::35) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA1PR11MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e214d21-2293-43d5-6d25-08df07ff0fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: pugSQl4lB6ied79jdu4QhGyDbW/v5XayZoFWSIZQz9O2yaxRkl6xZIsYkm2+aLnBXbMA+LYyP5tgsJarvxgEl1PH5VycZI8pkUVxZ1422UXMM+uEq1HnqKhTIUJPn9Nf9/08uHuOmoTYpG+i5TZD3WC/KbgI5Phz+gzAzGlNDE/0Tmb8sIB2E2ZewaF5Eu2y04NUdF+4OwfBSsEMVIGljEL7jApKpVBgsrjyDn4TwHmdnWWl6PDSNJTGJgmwY3rt3QteZJBlNKwEqG5rmSna5WOOHa7VMeVCGVWIu0kDyToVirwENOhBaGMqiuq8neMhFMSffyx7Y4grRr1D7Jfk4wQDkfaFJkste36SxR8T6P8cF1Ewf0zAokrs3e9VTYNssZ/qH6PPmWxdFXESQhcnaD/O4/ejln1+Qibthg6HQupoBOIcIn+HzHNwMk3Rsm5XhQC7N11CyYsZZfiTZNXOU3ejSOirFbS3LaajBMy+zyjxM1cpA4270cpB6YycwTKe7kZ0CuEdEK0QY+vjVKgQV+XvNGmSSy8YvZrA2hDguu2dAWNQG0TPZvnDeNNImSGbbHsI9kQnvXt8RpsyJEhjb1NKb774tutdJpAArAXkIqq1RIWAcz2Xcrgd7cmCGyqQFbHGq9lVT1j60XTP4D8QnEwKI1J5+dc0Pk622IRv3kA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x7G0PTvh0l1Z9O3k4L2eRxfxtufZupcB+9451mGCrPOXPAZJpCRqrmOS98oG?=
 =?us-ascii?Q?aBhe995QV+d+60NhMjUdNR0ft9rMVlqxYuwMTOPmI4uS2v3F2zPjtsMOL7sd?=
 =?us-ascii?Q?fXNjlxXOFPrO8dV3ylBmE82MDKutB/l2WYFxofyCleH+uePw1T2Tul2KqUfT?=
 =?us-ascii?Q?8wAFBRkNcW4oFGN+pbcC/2c6ZDHiDvXxz//etlVyUMS4QgfsaiETWRC2PrDT?=
 =?us-ascii?Q?L7Vr+AMxeqkOQWT452F6mXsxW2FnZWbovp/kgV+itHK/oFO8cbtkJagbcDja?=
 =?us-ascii?Q?9nC2eJ2LBDV9xh4rwq3jsFr3bw4VVqRLgGDdbAO9rE9FZEEuC+sMdwxU1aqJ?=
 =?us-ascii?Q?WVmwyexEGNHH3Wkq35U/ade0iaoyM19dDJjQPMOQT9Y05lkIDkoZdiSFHqHL?=
 =?us-ascii?Q?bCEi4ZBSxapFWwXYB2KZCRkG84dBIQNLm90XfzNaBRtc/gkYIrF+2/LpdPAY?=
 =?us-ascii?Q?ees1HxhbTVDEfrlzZPW7857I3+66giv2fhQwvuOVnlVgEgxzxYNE/ziWi0cU?=
 =?us-ascii?Q?m+PkyuTCood7DLQYdJI/FdcExlTaYehBphQbqj7Qq62lrHhpO2Lak88VkSNu?=
 =?us-ascii?Q?aozx4QaG6x5BqVCgRg1N+vZDxZOHT3hXw6xhoAOHs48+H0jY71nG6JutWClI?=
 =?us-ascii?Q?f89Z72R22NoXgVa/Ssz3XsNTxDeKVMAHK7+9KaBqcpKQt9l2UQXXa2WZ4SMg?=
 =?us-ascii?Q?duIm9+i6goB4iCYmAK6/gxMeIrIFsMxKl99mwstPU6lrsS/8TAn3ZvX6avIu?=
 =?us-ascii?Q?e1OnW/NQ/r3jSJkZPfLVaeigyte5d8xdp6K8X6Nz5/vYANEtUK3nFQw75WDk?=
 =?us-ascii?Q?BrYnr5mne7hYUXCizV++x5zSs2VXZ/1vbb0hh8K44gOvmfi/BfACMhcv1VMM?=
 =?us-ascii?Q?fKaKtMTzkqjCZdsqa02PfM/l5MXG76tZY14hYv/VkyV0MrFWzuVms58NeAW4?=
 =?us-ascii?Q?bp5WI8755jyQn7TjZOooS5LhNeLXnVX2rK7tpGbqdhcsBu4Os6NH661HTVaH?=
 =?us-ascii?Q?G1aozWNF4GaPLIA94mRkpr+r6SOMUkSZZxvlQ5Gg5P2alPx9bpgPL4G+kIJ4?=
 =?us-ascii?Q?lUPF29OeQW8PeAyqRjh4HQ5YEk+HiX6aHbtZ6eCVdiBnl6Zm5lrjMd6UYOgp?=
 =?us-ascii?Q?kh90Y2R22m+t7oAWDIZ8uwWIGSkId4086gjTcVu++06QHV6rifjzYoiNSlxg?=
 =?us-ascii?Q?BfKWsEVpBs4c+io35Vyll+lMgJcSm7qGlbR/FSRtDYHSK6t4Zlg/caHFEumM?=
 =?us-ascii?Q?XWyLtEuI+RO1SdLe8RwMQouC2sQARSZ5ZhgpckAkct5wbRCs5CUnFF/cFeCW?=
 =?us-ascii?Q?s+y9rHegHU9iBldZFmoP9ckZiSKQHFIpK9YAvQnZiKSMOVOcGuJAV16A4fVP?=
 =?us-ascii?Q?saDCmzdxVmN9Qrd6qkATnPVOPN2ttqXFQ7GKEOo9XvfMO0v5hDSmRoCoqzQI?=
 =?us-ascii?Q?Jxd0CPgYnBwZKHejUXR/V+VDtD8OfCrDpf08OEyNJyFSMMeWaPyPg1nDGA6z?=
 =?us-ascii?Q?Z4dau6pgXjawD/9EG8+eVtd+8eAktp7BBSmofRuMyO00agDUj7pWvzqjcE22?=
 =?us-ascii?Q?nLga/ncoqbVLnk0XOM+VKJr0JHE6dj8IX6Pqv1IOwlB52CRwTy2FcX9K+nFX?=
 =?us-ascii?Q?dGgWDSdxu5Ups642rRCxYck60Sv8PXzTkq35qtLQqfpEam/AdAK2QSBPYzOI?=
 =?us-ascii?Q?wvqdcsot4Sisl4Fr3O+2TlPiZHdipx6WZGkp5//LRF4nO+wXJdAZk6N6IBlh?=
 =?us-ascii?Q?iRIfIe8yQ7Y5bA75Kw5S+ZYqSQpipbk=3D?=
X-Exchange-RoutingPolicyChecked: qbPYjlZHN/y31dZvw//mp+1T+Pif3CPed4Ua8cx9Cg5Ic/50BOcBg4WXNeEDqdWA2anNfq7vuWxbpFt/Hw8+iosbXMo43d0MQzPGMm/PH731ghBmy93DhNv+obhkXw3qTt7WG9StHYgkI6gnUMUUpaRSJ2n1NWbLt6rv3p6ppQQTUxuqR4a65Tva2AxFME8GLOx8wuKrZC1HG3+4yGer5Fzi1rvn9/H1ynGDwFm1P8aeyJXHDqDSY8fgen4akKBbsVuXf9+4vRIafmJHICuFUFh9iaBtYm150lQdlbHcp8cf3Oy7/T58ZtPA/Jh6Osflt2YW2Z8Ikh4CphyOIqdb7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e214d21-2293-43d5-6d25-08df07ff0fbb
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 08:00:17.2992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iq5mkzE1d/IzDpR9lfivIzY5asImoLlLskl3eNXRQh75Kl3929/lXsQhh3LfonVuo1GtJHWLypb4IpJxs1VAVBk9PjygO2Ad6WjjpMb/kmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6347
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

On Tue, Sep 01, 2026 at 09:00:24AM +0200, David Marchand wrote:
> Since the async datapath code switched to dmadev, there is no reason to
> depend on the pci library.
> 
> Fixes: 53d3f4778c1d ("vhost: integrate dmadev in asynchronous data-path")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v1:
> - fixed "internal" dependencies of examples,
> 
> ---
>  examples/vdpa/meson.build  | 1 +
>  examples/vhost/meson.build | 1 +
>  lib/vhost/meson.build      | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
No objection to this patch, but rather than changing this now, would we not
be better just waiting to see what happens with the sync datapath itself?
If it gets removed from vhost lib, then a larger cleanup is likely which
should encompass these changes and more.
