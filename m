Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF35C79FBE
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 12:45:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02DAC410DC;
	Wed,  9 Sep 2026 14:45:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 60F8B40A76;
 Wed,  9 Sep 2026 14:45:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788957951; x=1820493951;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=S8N7H+gEEFMNKMJEjQkZKFfKPqWQFCwKEf+PWPf0bJE=;
 b=SKlpnA/t3e+jgGwZUb3gLrQPVLDWqZk9wWvTudPCwUU9KIfHD+3ZhfXd
 LhUvSiDZin70I/URlMdnETbksVTlv5FmCAqs1+0B9ttkEnSWmY6HTx0oL
 U/aexOIhW40GVk9ETVLzKpZYcEbXkcj3Lmw289Wv4fQSWWBtLEHLwhViA
 wDfxGyfUhr44VafMU0gb0Dz/6M+LHKXxm07DQMTQg1whGkbKSB2zi2Cln
 2MBjE5HKUqwuetxgimgD3w5xy1kyiPc+ATIgDbdTGSpQv+SXhR+b5OmaC
 dL24niN4u9Z1nDBfHH/xiROTaF7ZcdkYZOAoS49jNzav5fQGbIeqI7R99 w==;
X-CSE-ConnectionGUID: 3rPy6pVWRoO/e9EfXokxHw==
X-CSE-MsgGUID: c4pcyY6jQYy3T7Ap/ByEjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93204987"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="93204987"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 05:45:48 -0700
X-CSE-ConnectionGUID: 0tZAiOwXQCaOHEPaMz2/UQ==
X-CSE-MsgGUID: rBu1U7CtQgqRlx46CndfwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="274834050"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 05:45:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 05:45:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 05:45:47 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 05:45:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eC5AgaZ/h7HHNwFg8f9sUewI/7cT4GX89XE4uTvFxamIQrDWlJBsjT2JzzyHqgRh472p0YN5DMZEQFY6gw8bkJhaeEa0bGaTQ57NpqVsneQC0VWI8T2JtYCQvI1mIMoJJOGG+bL3/8pSQqzUOw2tMYEsdml2jUddcIdyvsq3NEkYlsUphFzPkFtcdFC2QUvZ+Jk1Imvf93ulV0qXoUpHrHxo9gyhGVZtv+/zwuEhDU1pl7WVpv6o8KxSIKsTFI3mNYcfW4UhwoKwdb29pHaUFpG6DOpnIj5tKT7ZVTFD5wXWF6MdSFW5eMXQeh7Fuu6oUHvVwonDSgtSc+1zMmofCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+fomGNz2YCm7oLQkpIqLOeaQNQ5+h3LPRLnJsinafo=;
 b=S11g8LAPcxj2pO3yLwuPSPZyP9+iOykhJt9e+dfuU+8KObSHoUGBkDck8Km/6AAeka7DBn4+DkmIlT0+LdWUYY/gKv+TfT01+gXfpeonszbBLKo83vXpvNHBSqAE5J+Tn8+TAMULwFokFWQsmzgvrk0gQPc/PSpUcmeOKYtxjl8GnBAVJujh/sCnwKTk3NU915icmpDQE0bshpjR7us/3oc07WU93Fu4Ww9fzQpmFV5/Xv1Wj0+kQIiiD/D1q3uaV0fMEZq8eXr3pbNS3USoDzbCf5/12syGp9hTrR2L8B5DyeTWw0lFxCfoBmm4c8HU6GYbSipHHbxMkgISPaQLYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 12:45:39 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 12:45:37 +0000
Date: Wed, 9 Sep 2026 13:45:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2 3/4] net/ice: fix Rx queue count reporting after TM
 commit
Message-ID: <aqFU65urQMY_E2ET@bricha3-mobl1.ger.corp.intel.com>
References: <20260904105139.3117640-1-ciara.loftus@intel.com>
 <20260907130750.3406004-1-ciara.loftus@intel.com>
 <20260907130750.3406004-4-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260907130750.3406004-4-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P195CA0005.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::24) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LV3PR11MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: 401ec8aa-b1b7-4f34-d727-08df0e703f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kdeYAAZx2gXUFYZq61jQqJekN2ICxNQbma0SbSdGhApswXM4YcNb4zFtmZcvzUbuOecsUf/fT/bA8dYyPkiU3qrJVYni8V2GlIWO4ONHwSsqMoqFHP/7iC5vEtTXByQ4VxzL73dBAInAwkY75buMxKvEohDc8ZXgwKY31KPxpxvkO5mO0fqGmjR8uqAlLBR6UAaaeKHO1PnhCzh9J/SsiSbgYaF3oD7N521jrRHfhisI+/ZmsRXLooXwv0YAc8AMqHjWBn5DWu0QU0KbYQu77SxGc6Ry+8Fv/yduWq/41+dylD8jHfZUzRLmyg4urkVgJyB1ibyQTHapfS3/18oPNFBlwAP1Io7Ha8C4eCtdj0ZW14/gH+JWqWKZUVnjh4cu1/1XAE6UjCgEYzsmfdf4sGo1Xg1GquIt3+w564wi8cNAnJP6Gmf3uDDXHi6H87HyPj6CZ4R6I0UdqzNJMt0tvC26YNNZBgyLGOA2VZHScjdKTCYaXxkTq5g5g0bR7QOO1AJEwm1ruqVsvOtslviM+nwMdyzUHsPNvuuvemTlq/5AILLzrORsHyCHj2XwWVZMV8x4dM7lnx1VgdCCS1JzYMMBVCPh67wdiAO1vTlawT7n85tc5XKq+cWJGIefJWfH3YFvGF11X/ito8iziNGtsseDCITAj0B6icdvdU7lzfo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pul7cJYh/g4jhYTEfOUKqNbdxQ1DuPKs40QXZbkdlzwBH4zXTKp81NZfRJbd?=
 =?us-ascii?Q?pQVr+we6XPPzSVh7GzUvW8XllU4/5wuAlD4Hd/kqDyWiEm7NEkLBO84UMvZX?=
 =?us-ascii?Q?mAzdtmargNy2/CzctVaqIgTpxzXgrdviX4eDcHOg8V4xmLL8BML3JfYrDA/5?=
 =?us-ascii?Q?Uk9wmFLqzgbFgAL3cfE3QPIMyJMG6267SSFGzmvOe1jvK5in3NXDORd6Xpgq?=
 =?us-ascii?Q?rdbQBaN0mz388a9W3Ts3ckovaV4Lflhb8aJIKzonXWPuTQnSU4q1YeFYGeKK?=
 =?us-ascii?Q?8EuwvHJcS1KnbSxo8dcTNnQLpvPje02+6J/kEODpPROYPB5TScXtTzoQ0RfX?=
 =?us-ascii?Q?wxkpXjfKdDw9uoDShAWVjgxnML9dCOO3b+Urkqh9PmL2ezEFnjs9gWvMoTGp?=
 =?us-ascii?Q?7NiBglNga2rt2i9+fZFdwE6EW1YjixSdfEPGdysJVBuCOVeBE2PkGViI0VP+?=
 =?us-ascii?Q?DkwZ6xTNo99xpi+J/6vt/ZkIdWIocc42u1TFph8i7r5ztSsynWdyPZ4nIJNY?=
 =?us-ascii?Q?wz4/biRoQthKub8buZBAhqsuI5Sko6HSfWadKld97Rg0AAQ7SzaaKhcsfGZB?=
 =?us-ascii?Q?RehhkrrrWc8ASFupKRsjtSt7X8Pepf1zFoClp/aEa0qqm2M+ail4UxH4hDoe?=
 =?us-ascii?Q?fOQYifbswtKs2j2/gx6S09GeVNhdnZn9ThYfO73wBcr0SzANBRPagvKscaHA?=
 =?us-ascii?Q?UELGBX0+3vWdp4ZP0FhkVuf+DsZ+nGu/KCqRsTVRPTwkIzPaL/uWUK9f1vtD?=
 =?us-ascii?Q?J6bxuxKOTloqxmFIvPWRxijyqm4LsUDwM7f2L57mAhE4kBKzdw5HSbfSv5CK?=
 =?us-ascii?Q?55WIw+vAh+SCdZfPMlW1ZVgZh+eoHYCJXTsyACp1jRayu7755eP0TB/vf8o9?=
 =?us-ascii?Q?mpc7+oU06AvyTH6EiyC0pKmp5vS6HaLvAdplX2++JIp4rki50r9foaVpwCW4?=
 =?us-ascii?Q?mlnl9g6fHQlXbud6uo7AWxzoJT45naMyp393HD5FpK/pIzzBaf6gBEcARfB+?=
 =?us-ascii?Q?ZeYM9Z4VaAC07m8RHeJmjVm8BF888qvbJhpqGJGyKAoBECY15cXqmRcAv3lI?=
 =?us-ascii?Q?B1dLt51xASBgbCm9PcM3/Eb6yh1inz4M8V046zSozGwiQ5UFNK6wPxqxa1Ti?=
 =?us-ascii?Q?yzfq8z4XNybiAFkp995zjAWunCV86A5iKULn1HGry6kMJBaILSONaSg6mozs?=
 =?us-ascii?Q?6XqKeTWWG5QYfi2CT7TG7QUKWIJpPp4cR4N5eJCjDQGiq9dGR6iHDJ24RYPV?=
 =?us-ascii?Q?ftZYzVQ7ZPryODKUE7nJLOMnOvHBaXWweKMz5nupQY3YKtbcDIygF5I0Jq69?=
 =?us-ascii?Q?GK4A+kYmHM9Z22l/eSc2wPjMiyCby7Y9HOj9Spxz7jNgew48wl94jp8OgDJK?=
 =?us-ascii?Q?u/pZf+ai/4OFKZj+9Ap4Yux98deCqWVKwbrJY9Ggp7CM4AAfsY8aMAqakKTJ?=
 =?us-ascii?Q?nwCU622dasifBxOWIqpAyGCLLPu8XusnrdTtR8XvK/IiRdManD0uYRIPn7ZA?=
 =?us-ascii?Q?10N7HKawU6yEBjG2dJw3BsnmYEIQcPR41U6Z5RZLGSoAzmG3KvaA9hZzCmSq?=
 =?us-ascii?Q?ngPxjUOwuLrzXe8Z45loMiZZzU6y/HEOcHIX/ndxuscMcrqaCEaWI1HJFvZM?=
 =?us-ascii?Q?SjAd/sUiUmDUmJ1Bb/WeQcE0g+gn8bWAQuUVMvFZksNKzocRH2gnO8A2BUNq?=
 =?us-ascii?Q?3bI3J6e0pHZFucmpGLXQVq/8pB+XcF1gHjYPSGx05qtDavKhRDE+njSThWpb?=
 =?us-ascii?Q?wgQGFqu5eiwieKpNxDFncyf8I7KnOGk=3D?=
X-Exchange-RoutingPolicyChecked: PxFVtOx2BKHxr8kj38sIEl7jft+qAN8pLXJA6iAfRBpjLn46v1Esw/DVr+KfNoA54iYCi7zWlmUIDQ8Ns64Jx5T37rredA9QLlvmvisPfFm1DfgOe3n8LGOEyki0N+2pYuUZq0VMt1Ktdp1g1lsvfMpp67jn/4iZy31cQWGPGLxe6Ebn7DERcqaUKr/gpDwcaHnRPjhTpLsvFAD/26D+p+xyiE/3+SRBveCgD4b/CZViDFdkH9RH7tdVyLPAs4PPrrMzrVVZI32D6cA6X9IX9lwKt/SZEIEdEMzM1xQhoZPWQkAqFISXrzH5dmxrIXB1diDDyhYOiSzIO1/ttdvWew==
X-MS-Exchange-CrossTenant-Network-Message-Id: 401ec8aa-b1b7-4f34-d727-08df0e703f38
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 12:45:37.1905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yX5/dT38lnGd6JtuLfHYlQy8RDEDijwuFAV6Wzdxt+DFnOPrDQwVXCyVNQIObsehSV4mKe1A/95PTohzSDxo1VWb/gFq4QaZFLIucQD2xgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8603
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

On Mon, Sep 07, 2026 at 01:07:49PM +0000, Ciara Loftus wrote:
> Currently, ice_dev_info_get() assigns the value of `vsi->nb_qps` to both
> `max_rx_queues` and `max_tx_queues`.
> 
> After a Tx scheduler hierarchy is committed, the value of nb_qps may grow
> to reflect the VSI's larger Tx scheduler capacity. However the Tx scheduler
> hierarchy change has no effect on the VSI's Rx queue allocation,
> which stays fixed at its original size for the life of the port. An
> application can then request more Rx queues than the VSI's actual Rx
> resources support when the inflated nb_qps is assigned to `max_rx_queues`.
> 
> `vsi->nb_qps` also feeds `ice_vsi_disable_queues_intr()`, which clears
> both Rx and Tx queue interrupt registers by absolute queue index on
> every port stop. Once `nb_qps` grows past the VSI's fixed queue window,
> this can clear interrupt registers belonging to a different VSI.
> 
> Fix this by introducing `vsi->nb_tm_txqs` to track the Tx scheduler
> capacity as it grows, leaving `vsi->nb_qps` as the VSI's fixed
> queue allocation for the life of the port. `ice_vsi_disable_queues_intr()`
> is switched to `nb_used_qps`, which already tracks the actually configured
> queue count.
> 
> Fixes: 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> v2:
> * renamed nb_tm_qps to nb_tm_txqs
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 5 +++--
>  drivers/net/intel/ice/ice_ethdev.h | 1 +
>  drivers/net/intel/ice/ice_tm.c     | 8 ++++----
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
