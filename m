Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE32C44506
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 15:14:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E9CE40150;
	Fri, 10 Jul 2026 17:14:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 88E1F400D5
 for <dev@dpdk.org>; Fri, 10 Jul 2026 17:14:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783696466; x=1815232466;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UESLZPCgt0/d0wlOUbGA44TLSbLNPTzwcp1xWXEnFno=;
 b=YZUbUXhkdbItAaxkXpx+vw5qMZRHkyWcE9y/zTyY6ElTEmzZXSqhuLrM
 +2EmuupPnA1CgqIqxeGwjFImJwQZHv5eJYjDGG/GPX2fWihbkcV7PrBkD
 ojDi+GiYFDpp7zYJE2+iSgeK2e3qC3Rn7M27tUbJci/mDzi2TxGlmSDXs
 cYOzJldguf4qrc9XE4S1kGjEE2R0nn8ICW44/KlRYrqp/1McUws0udquH
 LDs3BWWaUXoyVlrZhhJIVgB+i/ROZ3FH65zzTehEImPbVypT1I+NeD/aV
 RWf+jEha5GuLWgRfMp7nIBzWajbd+yIPVWfukc42zLHOze07gYEeSJchI A==;
X-CSE-ConnectionGUID: EtCMTG8GQ4+MvUTKRIExqw==
X-CSE-MsgGUID: zL3mONDtQtyjqALlLvZ+Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84418321"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84418321"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 08:14:25 -0700
X-CSE-ConnectionGUID: jBQjwHwwQkSKn3RzXuajcw==
X-CSE-MsgGUID: kqXdBTMQRQKXLy+wnLDj5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="254407965"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 08:14:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 08:14:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 08:14:25 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 08:14:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjMCrfaehbcSwFywEDm/EEOiAShEPYYlthWgiI4iSs6PAmFibzw7sIprcoBd8lIRiOSrU9tka/l6kDrYgA9KnKRnqynJ2jeJmhi5mbonQ4/HMF6I1PFmflfwwnuQE6YbyOV4aB3Rxu8c7Ct0IiT0KsW3sEtbMU6ix0Un76I01UNfdBXeKLSszWfY/u5O//LqnHkrQnUYm4w9gIEMz8GL7xo0vDC4RA0DVg6L4SoOPEgIeNg7R/lADWTPmcIEbRtQmgy5VoBXASSZ0ZW0BomcKhzwpgFwcEDJtb/1xxeLKgMYJvTAUZrgd5J2gxmHa+zXIkVuh/3hiK3QhQBGPJ/+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6V/+tkqVYSo+DZ+rvdcBtekcvRUPNw7G6ayBDwc0tgg=;
 b=ZOwXzWzRTNMR8HdBFfxfem2qtBJZHUEURw0Cj6nzGUnMPCvIKdtI9CTUv+jmch14yABmcEUNvNGaTPag9NsJQ7+jcILzKJYoQ9wr6bB2SJ6kwPEvHfl+4G+LFzFXfnga9+6EtNfJcqPj699mlYYvY7xr8lZC3lC7MzdqFI5jPYYUqbmIvjTDViklI+q5O8CRQRnFgi740uu7AVPT6fV/8/aIyeU6NWbTWHUnzu21UQ4R1o+QNurcuPlbps+9xwwEXACUUyNk4z0H4UH5yPsypjAip+0T8p2A/JOSIrFbaaNay5ru4YtpJot0OZBLcCVYz2J9wWZd8R4JqLuVVTtINA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS0PR11MB7767.namprd11.prod.outlook.com (2603:10b6:8:138::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 15:14:21 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 15:14:21 +0000
Date: Fri, 10 Jul 2026 16:14:17 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dawid Wesierski <dawid.wesierski@intel.com>
CC: <dev@dpdk.org>, <marek.kasiewicz@intel.com>
Subject: Re: [PATCH 2/2] net/iavf: disable runtime queue setup during queue
 rate limiting
Message-ID: <alEMScYtuGJfEo_U@bricha3-mobl1.ger.corp.intel.com>
References: <20260703121952.1277387-6-dawid.wesierski@intel.com>
 <20260708231926.1550698-1-dawid.wesierski@intel.com>
 <20260708231926.1550698-3-dawid.wesierski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260708231926.1550698-3-dawid.wesierski@intel.com>
X-ClientProxiedBy: DUZPR01CA0218.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::21) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS0PR11MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8e3810-d95c-4848-4aed-08dede95eb45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: BkuihxYH9o0+AXZy2on5zvXSe+aSoIjrON3Fh+eVtRVv2kNa0VhGbHHDrqtleVOCyPEEHx7zuKw1sc8Vi6NOjIr+rKLKYbwJV/eUZi5fqCySzUXEF4zBxjC5eXvdsy+Ptpf1krXFdkUK+GoQfmbwm002rzDMvaG4Eu9a3D+3ALCbW3UP3g5jLOkB5Ld6Nq69v/0MANDUl6ScecJQnStihQlto1DQsXLMQOuWEj8v9sk/+fgYzyIl0oFkXl/goTZDLQAw5Y4WMrsdSnKKrICk7kVIyVcLCC4wuQICDkAZ6i4EXF7W7fBrjLKotiBQThglGXWT0Yk+RHayyu9mehUDs17KE+VYYXH7mwIe86Jzz9/4BzJ91JJGCGysSQGJfXr9WienqiTm6EeMLS4bS6f+F8ts6HHwmF01Toz1GrEkl9amRVdvzjh3LUKDgJP5GGPhqiRiw9knu/kUN3IM5Iovor2WSSGgk8tJ2l/mN7PnSJ982ODEknAD+Vz3uld7GYdEj4tGXanRVg2fI7ZoM4vgo+nygyhrtzt7kjic0B/WOiSEhwPF9AwljsdVBNUizwmJKIUivxUuEEVkoAswRYAV4Wbs22eecUXAfM9fkNa6p/qccjYghwW411OwFhCu9qz8MT0DC2iGB/sJ6UU4DVS8VdJ08FNB7ivQu2gtKsZhv0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s9JjeQtlhE0Wxu9BUC4+LoqGgOEbcXBcXz6Yr6Z69G/eFq+zPzCaMfZmqvis?=
 =?us-ascii?Q?OBaLvRRpA+oaWsRwG+gJVgeVT77N59COWcuuilbiUzqODyeuCQsfbfh0L2MO?=
 =?us-ascii?Q?oAXxaBWtM9JRTgajPABBPAyiH2zLn5chfnNpUwY2tPvafbt/TnuRWKHcbPB7?=
 =?us-ascii?Q?k+U5ER4xf2OQFWAU095LyS2/nMMzlVfz+Ex9ozq9krzbMhc1PfowBI/xKtXw?=
 =?us-ascii?Q?2RPdSDTEC7G2TRvbeJ1gaEkWSbaqBJS76+xiRvqt2r4knF5P77qobZsyTHuH?=
 =?us-ascii?Q?2DqucdPlbebMkxpY3gGjqtPbGgLHa+bWBm003H96oFCF3G6srwbqiZBftWMW?=
 =?us-ascii?Q?su8IH74X3qY4hakbOEt4G8N4Zj2+/8gUZ8V/CsLVyfsddWCR7nzCPTqAGwYS?=
 =?us-ascii?Q?5Rni60x0UXxFts2HlKXngf5w/HQKk+STptiCo/Wju4CQEyjmrzI/IVY+zFBr?=
 =?us-ascii?Q?J/cBHGWzIn/QCm4uKOGFi3XxSwC5rHeBSveh5ljFzYRDeqphr7TiNG4IuGI0?=
 =?us-ascii?Q?xG7nUOjhLVkUzC4jRk608UWTvcWfIo/BbV4yzbA4k0kRj7DYK8xGObydup53?=
 =?us-ascii?Q?Bp9rZaMD3It8hQ8AhtuGh3klhf+eENWaDZAf3+JbH/U/PNS0nvtJS+949V3a?=
 =?us-ascii?Q?Qa2Arl90f9vooRPz2FJpbpjKKcERfeNB6lsidY5spkmWU35wYXk7oa8iNSPh?=
 =?us-ascii?Q?Uww8S2ezZUpX74JgH42PNN5trCjG2WZFVfE1u/ljNW2FsIBrOR8KMk8A9Zeg?=
 =?us-ascii?Q?UQ/rXj0tVRIOWLrxMXo7LMffWb+2DDoQ+G1SI4L5mUiopVhf4qM6z4naBO0F?=
 =?us-ascii?Q?JLyusNCcTRN8u5ZcKB8pqc23bn6vcnv0VpZvtaXiv2fKFH90Abx1BoWbkGmV?=
 =?us-ascii?Q?EGHZHAJY8kYxD4PQfO3VfChAHbCD5mPhGlg1xMtnzBlIFdS9O/ZQzXm0itVp?=
 =?us-ascii?Q?pNMrv/0X29buGaGb4TNbTu/NICbB0w2z85nDe/P3KQsumj7jb0+RrDnrlBQZ?=
 =?us-ascii?Q?yBcfA7GvrHn0XQFVsxdAv/VIvf8ViQiAeg8zV8m9mxvVznhOYzPbZ4plfMSp?=
 =?us-ascii?Q?P9j45C61KhqLIkjLIf9hXosenUXpdhLzWgLWybM8lhsURQByEFfT6TBvVh+U?=
 =?us-ascii?Q?ayNG8MJMWyaIyzCzvbbV/ZJlkYEqMa+wxqOjToBCsxqhUTWPI+LjwNB3YHKV?=
 =?us-ascii?Q?Us1FHM3EJBoC96EnlSkBJmqE307O1cPaG2ns1yyfBD6rsKciUoXUq9aPPX7v?=
 =?us-ascii?Q?2k8zQtleQ6X1LbZ5PVeyr+wrMgz7vPZv+0sodPbxQ4MDPsi48kLH/vckZB0N?=
 =?us-ascii?Q?BFeo8ihTi4+sMS/Ld3YbHtGEsmgVQ9zMYf5fea8+pLw5x00Tu6B1D72oPggI?=
 =?us-ascii?Q?Kac3OCkfQ65ctIVg7qvC4A20O2KRZrcgaJIgDbUKV5lM2aMbF/HI/4s6AL5+?=
 =?us-ascii?Q?sXL6OwBxRlQvJ+O7kwXjliMsvZyknGvnM06X0wKH+pw2MUAlwhpkoonhoc48?=
 =?us-ascii?Q?tJsd9Qn5hFZEohqvK1Lw74nvkJpu1AKVLE4DTml2WymceZb1ooLam8xUvuD6?=
 =?us-ascii?Q?ccd+kbwnXDZezEBDW1oe7649o/Lz0ekD04QrJKd+wtlc3qBiKAdSYraGTzx3?=
 =?us-ascii?Q?JDtVDoXGtbjZOON4vxQ4OLNS2PrQUxDHvS+BkgdG+1ogaWm0lfvSimEC8oQP?=
 =?us-ascii?Q?gyYgfTOHMXhRTVX0RFWW+iXaY2TpJrZn0AmS01Y+qloDaQriJOYUG7abHr6R?=
 =?us-ascii?Q?5OjekFK7d0oQUF+tk1p4J+7Ynbbx7hE=3D?=
X-Exchange-RoutingPolicyChecked: mxhWjIf15alqCQxHX8SqJ8rFC0G8qA0LoYUOiUILy76Xm6fPV9BwSKX6PvLOyQsBoYlNK+mJc4mlBLiCETrqbP5w8kpicNDSxqZPGHPUoN5dcbdbn8BLZBGFUGMQQoH6Ib3OcgJNTeqy/k7cerpEOEun/UGNiplXCZMkgobzqyNqp6q9qqr6fNrs8PxH6gEfvlyM5Zr5MlslrswqEPX9qImzWFpz8Yre3zX9n4HNsTSw5Tq9ni1Vb20PIhzgJbBfGbZUMIC4cZ7Ffo8zDUy34/HfG4H6qnudbfp+aV5KZ/MQ/QPmmk9mcqKHyXAXv1l96lLpUPUThMO3cezToUgWsg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8e3810-d95c-4848-4aed-08dede95eb45
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 15:14:21.3497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZpGvBRwionbWq7sTh4MDXIZFR/fniwRz69GJZRF//suwhsijM4HWvHKCIfbCuv2Q0h9upC8Jh5hLBNaPexJ73Mq3g/eY3Z4hPY3BZmpX2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7767
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

On Wed, Jul 08, 2026 at 07:19:26PM -0400, Dawid Wesierski wrote:
> Runtime queue setup on E810 VFs causes queue state corruption when
> queues are dynamically reconfigured while the hardware rate limiter
> is actively pacing TX queues. Queue configuration messages to the PF
> via virtchnl can race with ongoing TX operations, leading to undefined
> behavior.
> 
> Rather than gating this behind a devarg that an application would have
> to know to set (and could just as easily avoid triggering the race by
> not calling rte_eth_{rx,tx}_queue_setup() on a running port), stop
> advertising RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP and
> RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP as soon as the application
> commits a per-queue bandwidth rte_tm hierarchy, i.e. as soon as the
> condition that causes the race actually exists. iavf_dev_info_get() is
> re-queried by the ethdev layer on every rx/tx_queue_setup() call, so
> this is enough for the generic layer to start rejecting runtime queue
> (re)configuration with -EBUSY once queue rate limiting is active, and
> to automatically allow it again once the rte_tm hierarchy is torn
> down.
> 
> vf->qtc_map, already used elsewhere to look up a queue's TC mapping,
> is repurposed as the "queue bandwidth committed" signal since it's set
> by iavf_hierarchy_commit() exactly when a per-queue bandwidth mapping
> has been pushed to the PF, regardless of whether the port was stopped
> at the time. Fix two related issues found while making it load-bearing
> for this check:
> 
> - iavf_hierarchy_commit() replaced vf->qtc_map on every successful
>   commit without freeing the previous allocation, leaking memory.
> - vf->qtc_map was never released on VF teardown, so
>   iavf_uninit_vf()/iavf_init_vf() (e.g. across a VF reset) could leave
>   a stale pointer referencing freed unrelated memory, and the runtime
>   queue setup capability would never be re-advertised after a reset.
> 
> Both are fixed by freeing vf->qtc_map before replacing it in
> iavf_hierarchy_commit(), and freeing and clearing it in
> iavf_uninit_vf().
> 
> Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
> Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


However, this patch needs a rebase since some of the changes to cleanup
the qtc_map were made in a previously-applied patch.

>  doc/guides/nics/intel_vf.rst           | 10 ++++++++++
>  doc/guides/rel_notes/release_26_07.rst |  3 +++
>  drivers/net/intel/iavf/iavf_ethdev.c   | 23 ++++++++++++++++++++---
>  drivers/net/intel/iavf/iavf_tm.c       |  2 ++
>  4 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
> index e010f852cf..a47e3f6736 100644
> --- a/doc/guides/nics/intel_vf.rst
> +++ b/doc/guides/nics/intel_vf.rst
> @@ -150,6 +150,16 @@ Intel\ |reg| E800 Series Ethernet devices:
>    for example: ``-a 18:00.0,quanta_size=2048``.
>    The default value is 1024, and quanta size should be set as the product of 64 in legacy host interface mode.
>  
> +* Runtime (post-start) Rx/Tx queue setup can race with the hardware Tx rate
> +  limiter on E810 VFs and corrupt queue state.
> +  Once an application commits a per-queue bandwidth ``rte_tm`` hierarchy,
> +  the driver automatically stops advertising
> +  ``RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP`` and
> +  ``RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP``,
> +  so ``rte_eth_rx_queue_setup()``/``rte_eth_tx_queue_setup()``
> +  are rejected with ``-EBUSY`` on a running port for as long as queue rate
> +  limiting is active.
> +
>  * When using the Intel out-of-tree "ice" PF/kernel driver v1.13.7 or later,
>    to create VFs with >16 queues (aka. "large VFs"),
>    it is necessary to change the rss_lut_vf_addr setting in sysfs from the default of 64 to 512.
> diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
> index 6352ef27ab..7ea80112f4 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst
> @@ -143,6 +143,9 @@ New Features
>  
>    * Added support for transmitting LLDP packets based on mbuf packet type.
>    * Implemented AVX2 context descriptor transmit paths.
> +  * Runtime Rx/Tx queue setup is now automatically disabled while a
> +    per-queue bandwidth ``rte_tm`` hierarchy is committed, to avoid
> +    corrupting queue state on E810 VFs.
>  
>  * **Updated Intel ice driver.**
>  
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index 80e740ef29..5d0c361978 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -1160,9 +1160,18 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
>  	dev_info->reta_size = vf->vf_res->rss_lut_size;
>  	dev_info->flow_type_rss_offloads = IAVF_RSS_OFFLOAD_ALL;
>  	dev_info->max_mac_addrs = IAVF_NUM_MACADDR_MAX;
> -	dev_info->dev_capa =
> -		RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
> -		RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
> +	/*
> +	 * Runtime queue setup can race with the hardware Tx rate limiter on
> +	 * E810 VFs and corrupt queue state. Once a per-queue bandwidth rte_tm
> +	 * hierarchy has been committed (vf->qtc_map is set), stop advertising
> +	 * the capability so the ethdev layer rejects further rx/tx_queue_setup()
> +	 * calls on a running port with -EBUSY. The capability is re-advertised
> +	 * automatically once the rte_tm hierarchy is torn down.
> +	 */
> +	if (vf->qtc_map == NULL)
> +		dev_info->dev_capa =
> +			RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
> +			RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
>  	dev_info->rx_offload_capa =
>  		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
>  		RTE_ETH_RX_OFFLOAD_QINQ_STRIP |
> @@ -2756,6 +2765,14 @@ iavf_uninit_vf(struct rte_eth_dev *dev)
>  	rte_free(vf->qos_cap);
>  	vf->qos_cap = NULL;
>  
> +	/*
> +	 * Drop the committed queue/TC bandwidth mapping so a subsequent
> +	 * iavf_init_vf() (e.g. after a device reset) starts with runtime
> +	 * Rx/Tx queue setup available again (see iavf_dev_info_get()).
> +	 */
> +	rte_free(vf->qtc_map);
> +	vf->qtc_map = NULL;
> +
>  	rte_free(vf->rss_lut);
>  	vf->rss_lut = NULL;
>  	rte_free(vf->rss_key);
> diff --git a/drivers/net/intel/iavf/iavf_tm.c b/drivers/net/intel/iavf/iavf_tm.c
> index e3492ec491..c9d856e937 100644
> --- a/drivers/net/intel/iavf/iavf_tm.c
> +++ b/drivers/net/intel/iavf/iavf_tm.c
> @@ -905,6 +905,8 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
>  	if (ret_val)
>  		goto fail_clear;
>  
> +	/* replace the previously committed mapping, if any */
> +	rte_free(vf->qtc_map);
>  	vf->qtc_map = qtc_map;
>  	if (adapter->stopped == 1)
>  		vf->tm_conf.committed = true;
> -- 
> 2.47.3
> 
