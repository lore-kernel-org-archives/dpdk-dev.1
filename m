Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B004CA9ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 07:53:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 995944026D;
	Mon, 12 Oct 2026 09:53:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4930140041
 for <dev@dpdk.org>; Mon, 12 Oct 2026 09:53:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791791632; x=1823327632;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=FQT02v6DyaoXmN9c7EZfr8Har0+jIn1U/z0pfwT4CB4=;
 b=Geg5qpRkqDNJT0kRUTkusWmshwXpl975scuEdKpcnAMi3Gh2LNViWBFs
 JTz5itSnVL3Yf8zRvZerFZ8eHIlPhlWyN0cMwA1XuQbGhH5YQ37x+IZTV
 OmlSlQyZMwEbslDzswFbghiN7jcAwUqv5xJry5wXusetjs0uavrbGdKzB
 Vny1YJ11yRpXXg0Fa0I2Fgfgf+uo+RZq/YQHp7Lze7opK3IWjRgHqhwdZ
 0RFRVWa/H6c+Rps29BlMYSI/XfM4SrI8hc1ljwVARxcmmijVekSlITnyT
 diwcfDpubhXwpTiRHolYfF2mEcPi2pgbj3iBy34X+G6CPNC6XP76lnY6E w==;
X-CSE-ConnectionGUID: RaQHS6tFSLC5g+4ZoQAi9A==
X-CSE-MsgGUID: BpVUXE2nQQKWpg0ro+Gl5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="376707"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="376707"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 00:53:51 -0700
X-CSE-ConnectionGUID: gChL8xoOSnSo2FwW6q0klA==
X-CSE-MsgGUID: WowYGkpQTCmLfLWVikEoCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1292083"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 00:53:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 00:53:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 00:53:50 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 00:53:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9z2LhhiByV1dCcVbeQf5l39eAUAKeEWwm+WaF5Gxg6zl+vodyp/HwRh6qsv/sY/gMgWT8UNHjGVQmXcb3eQCqcHcPy81zseyRQ1DD2luj6J+lccSOCbJp1agKwPTbbpM0tVFFqmX0GCHhVlmvwjZ9BsQpRqjh0hZ+5ishx0jbjV2FB7oSvERuM36HGKLOau7s8CIaaFvQfxJuvQ8cBJ5YQo/nllJIVzv9W+/T9xi4BE2azjkiIdzCs5adMs8PaAzBeFeyFeoS6/HZ+BSF7KDJilmSBOh9GsuHNzdXuH7Il8MT+W9yvfIqQ+WR2xxVzAHk8DXf5ni0B7gLF7O/yJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Efr0SliwDCrAFL4EDjI3iS0vHYKvS+knjeF1nPf/5TU=;
 b=VF6uMdCTk26J+5n+vwuXWCswu15bo20gAnVqAP9bAlScSF48i1BVI5L/y7HVtE7sJYqMzbbzAW4RddTYfHqyzSZjD5RxsLtxOqm9DsCkyuluhC/Cmpa8/ltRnrKEr9sRrtXnVCqBxry0qR2zzrQtE5obb5F225ZdYpdYOlGL1Dym1TJQO3pwcCkpkcRk+hoNGeQLDkZAgYqNSfuUW3iHjMydxY4jP1/HO7fd5YW61rIaZ+KYr2UiZ4rVKR4KCwHfo3vAtvNrOcGTKKXFm65DG4FHUM2C6CVm2Fnw7iZNzYRc7AnGSfxrhMpOVKJTCJSQc4SKTE/ZTc7ZIiqsWb7NQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 07:53:48 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 07:53:48 +0000
Date: Mon, 12 Oct 2026 08:53:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <liujie5@linkdatatechnology.com>
CC: <stephen@networkplumber.org>, <dev@dpdk.org>, liufeng1 <liufeng1@sugon.com>
Subject: Re: [PATCH v1 1/1] bus/pci: add RTE_PCI_DRV_NEED_IOVA_AS_PA flag
Message-ID: <asySBXhKMzigqIDW@bricha3-mobl1.ger.corp.intel.com>
References: <20261010092525.2025485-1-liujie5@linkdatatechnology.com>
 <20261010092525.2025485-2-liujie5@linkdatatechnology.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261010092525.2025485-2-liujie5@linkdatatechnology.com>
X-ClientProxiedBy: DU7PR01CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::15) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MW3PR11MB4620:EE_
X-MS-Office365-Filtering-Correlation-Id: 1723abba-19ca-4086-5952-08df2835f28d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|11063799006|4143699003|261009221227099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0OLM61hhzzmUZd4wawMjM55zyDkaWmrOxVT0R/3EvoBCLyS2yXT1qdoqfcy3fBLOwHALNc6MMcur6dzHR11qbX564ZJUAC/x02E62RYQwOsPiqXa9EMUxctkUzAKdGZDYOZVAv/1ldU0IWqoKFdolmjKz9IpqVXpwnofGkyBKhOxH5Ka43VNAvgmXRXVFJKaBQMT0ukPfq2435225HLnwRyEA75YRXz2yXBczvvK9JSYHLdoxs1kDvrF+mhG8dQBW0GRnOs//J3lZEuuiJ0OsGhRaIr2BZmfGro9oxjDwwW1Pj3/MKhIe3XkHoGJS/eFSmMMTBbhpLnHFdTV+8H2Kx7eFfFcC6Be5/r8N5IKCqPY8luWPQB80nLPcWqp+GhLZpbMEvIN2nzPJZmpWk8S1BRAhUM4/Gbv9uZsGidYejcFzbLVelVUMudWAmfaSbcYMzFRwbOUb93jnZ1goeK/QbxB9T9ekB3Kq+811tma3sETrZspMzTMjKqc9R+Lqq28WEhgHujAPc4YgWzE0+kK8sEYhdkplW9apsQdieghoQbKfE5uNpSqqgRJF/PJAVDPQCauO00oihlZtfMtqx5w/bcGIiUGnBuKQ+0DpuLqIimX4Qy2p3REd53cSoBHIm9KGZ4hdbArEre9qYjSirvq7vCmkGvdVG3/Ql/szdWSEWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(261009221227099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sdYpB7jN5vO35Wx88sPBghH0+6+ZKt+G/xOuQGRUES7JutiXHdoE9A5zhK5a?=
 =?us-ascii?Q?VP0TWvsaKYLOiOHC16J5eHfdZPqMF11p4xEMslaiMHfPloUnPfRvHOAoiYR5?=
 =?us-ascii?Q?OgART2Xx41TYE5YILsYQ0zq7XdetK5fpvrbfnpnuLKCW3DmHXg1lVjiFJej1?=
 =?us-ascii?Q?veY+JD1RLBbaRXW8FqSM8KyfAWuhG6T0sqwsFt57Dc8K1FN1Luypo538BlYl?=
 =?us-ascii?Q?ZyPLyZHLs6i3XYvda8Yvio4bRmeEAWj53VPWuW4QmoqgHagWJw0UXJnlxNIZ?=
 =?us-ascii?Q?eo/IkzbDBYMyzVLonBEoGl5E/gBGXbwbbrPuF7K3nxYMYZ5afLNM9GbAz9AV?=
 =?us-ascii?Q?4msSG0UUAll0nEso8RIQ5C/Wq3igdWUOdq1OvwfvbdW66EQiOwiuWkJdU+GL?=
 =?us-ascii?Q?qyySN2tdolK5vJSY207kMWbOg+ULa6GJO3oAE+4Gj12SMTSnh64XqG9tzVRR?=
 =?us-ascii?Q?RdZz42Q5SPtSdmQTtLDJD7mD+QQGFICMCU0lFtPi+BROF4rgrk79RkeG8hfP?=
 =?us-ascii?Q?Kjx4JsE1MDqoYTvJaFSxpTaM+a4evd7DnykzhdIwfirMBs6aiqzvE+QNLvr6?=
 =?us-ascii?Q?46kyMvHiLKJublm5loWcMpLKLnghfJQE8fDJBOitPAft1GXby4JGaNePmRKf?=
 =?us-ascii?Q?uKWxr7dfkwQx1fPBYhoBCyhFl9cAM/Mzx+wyq4jdsyIDpKGieUoAUyqOx+Hx?=
 =?us-ascii?Q?nRJdCcj4/eB6XzX9BpPDZVFr5txD+rPHPOHbl1RsbFIuKywSOj9hfbBT8Dzu?=
 =?us-ascii?Q?4rHl+dHA+FJJDBq8HllAafbyTcf5GHAZyUrAEDAClGRcEsAqkRZMwf4oJ0Ju?=
 =?us-ascii?Q?OTju07YanujN2WAlHilyq6/rKiJMeTfdaiW8nxfqQfan9gN9SlgReDtbPSiu?=
 =?us-ascii?Q?4NYwGxnbGhIuzXAR4o+15Qj3hcDiTKzz2A5SJhxnOiblplmiNsG/Dbr2QHOg?=
 =?us-ascii?Q?tObg2GgP9KnQxF7LSEm1u2t6bSHrzvBncWMobncEH35IGU5FDnZKlM3lIknp?=
 =?us-ascii?Q?pZmXtkAc+1LlIqWObl3UXiwBvgVcQqLIUcRZ8gk+wyB4VatzmsuBcN++yYFd?=
 =?us-ascii?Q?EaxkhbyBMr+13WRtOh6nRCm6GxWuP3N7BGb4ESCkDfRkVOFRuXdsPBP4Df4a?=
 =?us-ascii?Q?1wyfMSq+pttTIDhYMA/6zupSQE88AgBhYG8Vmu5SJUVivtOZN1fFQY/SLTDZ?=
 =?us-ascii?Q?QyU4IaYHRN+zHuPwbqtTD6vEL+1W7Cx2pAsUpRIftdnL0TO7Dczj/ndcdZXC?=
 =?us-ascii?Q?UmDEcbrDTDpJeS82ryJJ8lS0GomHXcVABxsZhmbB0XoWjhItzaEmTGIHBWeu?=
 =?us-ascii?Q?7PtcDL/+qwH+oT10v6WZkWbewE2IwZvRF4yfjo5785DgoTGr66yekaTi8Lmp?=
 =?us-ascii?Q?Le0s6G3ejihkwlYyWhh+E2pke+cheWmLhJbKNZxxUEN9ZqYPBJK3khD8pcjT?=
 =?us-ascii?Q?QRjFdpQi4pVIQfestgLk+d8NAdiTuL5ji7s2wg5DEIpv/3xokdo0pfZ9HB69?=
 =?us-ascii?Q?BZ4hzHhe5pmRFaWtSyft9scNBwgysYqjblIxRq8PpTHGMP49PM/aQ7HYv0Io?=
 =?us-ascii?Q?b2M3txcdUc82/FFTXsCTWT7pZdpSmWp8XeWVK9qFReV3GpPXeACKOevYsSp7?=
 =?us-ascii?Q?Omlg98eDFB6pecFyb1MO80jzMIbpnp3VrcyWszW+90mJ/+HCA5ZXkZrbLIts?=
 =?us-ascii?Q?nnq5l9UW9LmMZZqRTYMbvErqvDGJo1Lyj8mLUi3tDJ5VmExVEXXQB6B6ytDt?=
 =?us-ascii?Q?9pVSF6deLFT/WzoTvrIJlAS/ZcHG7uw=3D?=
X-Exchange-RoutingPolicyChecked: N7plbqGvFSG2ItYDHGbZbAURtthl0iJ177ospBpi4LtjlbJS7xwAPG5G3NmH6J8F2r3W+oyjQRYG/+cEOVmcynTqpzSEX9OoDO2mDgFdv//bQjp/2tnXVs3z978fO4t2uYUZ8LiHcaXjjXD+2T5fWdQHUhXT9j2360RCkxNa5FY/v1KgCT7JHPdXCRlNtcm+Da4DdBEbxh5Ci59vcQ/EkfxVuAQQsSYa72FB6VGAzdh0lXIrgah63iSN9BGDB+DH+/t8YJk2BPUD3PvqjD6keTqQ7Tsso6AmRxo7lmOUqc57V4dzLoc3+flEmyOgeZOv7KBe0ilM/zugDEL+LDF7Xg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1723abba-19ca-4086-5952-08df2835f28d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 07:53:48.0562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c25DRz0aCvQykLOdEfJgqFH9Pzdnt4vf4kUYBb2VeFdELtpdPZrOWX8ZHl0gsV5wVXhZ0ZW0R6Raqnz1eh+j9uNGpaHwZaRryITvXX//HGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
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

On Sat, Oct 10, 2026 at 05:25:25PM +0800, liujie5@linkdatatechnology.com wrote:
> From: liufeng1 <liufeng1@sugon.com>
> 
> Add a new PCI driver flag, RTE_PCI_DRV_NEED_IOVA_AS_PA, that allows a
> driver to tell the PCI bus layer it cannot work with IOVA as VA and
> must use IOVA as PA.
> 
> The existing RTE_PCI_DRV_NEED_IOVA_AS_VA flag already provides the
> opposite requirement. Some PCI devices, however, are managed by a
> kernel driver that uses an identity-mapped IOMMU domain (e.g. when the
> 		kernel is booted with iommu=pt). The user-space PMD for such devices
> must use IOVA as PA, because the DMA addresses programmed by DPDK must
> match the identity mapping programmed by the kernel driver.
> 
> Without this flag, a PCI driver bound to a non-VFIO/UIO kernel driver
> has no way to force IOVA as PA. pci_device_iova_mode() returns
> RTE_IOVA_DC for those devices, and rte_eal_init() then sees an enabled
> IOMMU and selects RTE_IOVA_VA, which breaks identity-domain PMDs and
> forces users to pass --iova-mode=pa on the command line.
> 
> When RTE_PCI_DRV_NEED_IOVA_AS_PA is set, pci_device_iova_mode()
> returns RTE_IOVA_PA for the device. The requirement is propagated
> through rte_pci_get_iommu_class() to rte_bus_get_iommu_class(), so
> rte_eal_init() selects IOVA as PA automatically.
> 
> This is a generic mechanism: any PCI driver whose underlying kernel
> driver uses an identity IOMMU domain can set the flag.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---
>  drivers/bus/pci/bus_pci_driver.h | 2 ++
>  drivers/bus/pci/linux/pci.c      | 4 ++++
>  drivers/bus/pci/pci_common.c     | 3 +--
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/pci/bus_pci_driver.h b/drivers/bus/pci/bus_pci_driver.h
> index c04ebddf59..5d5efbbb3e 100644
> --- a/drivers/bus/pci/bus_pci_driver.h
> +++ b/drivers/bus/pci/bus_pci_driver.h
> @@ -140,6 +140,8 @@ struct rte_pci_driver {
>  #define RTE_PCI_DRV_KEEP_MAPPED_RES 0x0020
>  /** Device driver needs IOVA as VA and cannot work with IOVA as PA */
>  #define RTE_PCI_DRV_NEED_IOVA_AS_VA 0x0040
> +/** Device driver needs IOVA as PA and cannot work with IOVA as VA */
> +#define RTE_PCI_DRV_NEED_IOVA_AS_PA 0x0080
>  
>  /**
>   * Register a PCI driver.
> diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
> index bcf0a409da..bf7125e214 100644
> --- a/drivers/bus/pci/linux/pci.c
> +++ b/drivers/bus/pci/linux/pci.c
> @@ -609,6 +609,8 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
>  			iova_mode = RTE_IOVA_PA;
>  		else if ((pdrv->drv_flags & RTE_PCI_DRV_NEED_IOVA_AS_VA) != 0)
>  			iova_mode = RTE_IOVA_VA;
> +		else if ((pdrv->drv_flags & RTE_PCI_DRV_NEED_IOVA_AS_PA) != 0)
> +			iova_mode = RTE_IOVA_PA;
>  		break;
>  	}
>  
> @@ -620,6 +622,8 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
>  	default:
>  		if ((pdrv->drv_flags & RTE_PCI_DRV_NEED_IOVA_AS_VA) != 0)
>  			iova_mode = RTE_IOVA_VA;
> +		else if ((pdrv->drv_flags & RTE_PCI_DRV_NEED_IOVA_AS_PA) != 0)
> +			iova_mode = RTE_IOVA_PA;
>  		break;
>  	}
>  	return iova_mode;

Do we need a sanity check somewhere that we don't have two drivers with
conflicting flags set i.e. one NEED_IOVA_AS_VA and one NEED_IOVA_AS_PA? It
should never happen, I imagine, but things that should never happen have
this annoying habit of sometimes happening! :-)

/Bruce

