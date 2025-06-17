Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C174C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 10:10:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4254640B8F;
	Tue, 17 Jun 2025 12:10:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id C78A540609
 for <dev@dpdk.org>; Tue, 17 Jun 2025 12:10:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750155034; x=1781691034;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ToGptRExqCMfxGKE8OC3+7d66Ckv+QPi2XOnjvtKhPw=;
 b=QNckjKLt3LkvnYzenn32yxp2Eb+efp5wES5zal8wI71/ULhBVKFPluzc
 +aE4xMDx9JuXetTZCfjeskf9bLsf5wHTbqYaaIVTk0E6YCUzNz8z3Foc9
 Jks58GumYSdYISZQ68xxpblUu6JMWt9gUZbvdIXr3uHS3h8D7r75rIlUB
 sfC/LRjLterUO9Rv9zqZIAE5O+DQvpR9pBDgKE2aia+8XnaGEb79OPrvh
 lz+icD7sN13XewYPovZqCu6k+fNE1nJrrbCyXJCsPb/2Dn8bShHJ0uRT/
 3Gizp3baQs4fVKsu90oWF0vIgiv0uvVTKiniF4PJEfXZiQMgBhbJAp2eK g==;
X-CSE-ConnectionGUID: 2tQkPupdT66iURt2OzGd7A==
X-CSE-MsgGUID: S5HaS9qdS3qTs2FBC8oTlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52459824"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="52459824"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 03:10:33 -0700
X-CSE-ConnectionGUID: keWKPLMlRy+/GbEiZtf+jg==
X-CSE-MsgGUID: Lle3TlPCRrK4LKf8dL2DEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="149623134"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 03:10:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 03:10:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 03:10:32 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.87)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 03:10:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+7gTYrbKc9TR2YYAIiF0pFncFA5HFNywVJ9IZEsCplBDiwCRuKpqBLdzqSznK6jNhuejZW9tAeCekKoYc5ZMOChM+mv04vAEyJOzd+CZzxXfI6vArJwY+JmXhizaFxWPsl+sakUgyWOP1F4Cx4i5oLXMNGOoKUGcocWVSNQOMnmwLm/IDx6Q9Dvr7iXBkzUp7uqEoWJM3yJ5HrZyk/BpPvMRsWTK0HykATjrAiMD27BkT20IxtKRwXgpMbcXqoGz7U6DCIgngVfXxgLoT8LozDYyayQAvI1FBJvYTpQeCCe8e5+M/lYsQ0LpUywyvwywT8ZR0fnMWcRNthUEqXGNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ph23NUex9RLqH2QrbN+mIEyPJcdp3wEeyYIDAUwOHfQ=;
 b=CbOvvTdpNdBKXhLOIcP/60KO21VSEGvEg7EPekQRg9JKOIW6OD39qeZb3vyZ7f1RClHAUehGYjmqCGcmklc5T0PyvstaaLeKdBlYdxyddyBqoYT+c90pN79ZC+hbmqJpqOTsROYDcriXKBcNDPKYs/4YcJRFg6oTUI8v59ZUpPAJUg9m+OZi6VdRRdaMgbgpcwy6Pxbk1aCRG/DO6ssFM916N5Kbz4FU/JBCaCKoTaIYCB1d2rMkIoJF1AkzF/F715NyP8Cy+/6WHFVK32H9jb/biSvQQtb5gtBanJRu1nfVngZKK9V0Dl4w7yNHeVFWHKRVUY96HOEv8roBYntwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH0PR11MB8190.namprd11.prod.outlook.com (2603:10b6:610:188::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 10:10:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 10:10:17 +0000
Date: Tue, 17 Jun 2025 11:10:11 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v5 4/4] doc: announce TxPP support for E830 adapters
Message-ID: <aFE_AxZ8Ltx5EkDh@bricha3-mobl1.ger.corp.intel.com>
References: <20250610131159.495566-2-soumyadeep.hore@intel.com>
 <20250617001429.551262-1-soumyadeep.hore@intel.com>
 <20250617001429.551262-5-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250617001429.551262-5-soumyadeep.hore@intel.com>
X-ClientProxiedBy: LO2P123CA0079.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH0PR11MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: de9a08f9-d348-47c0-fa6e-08ddad872896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PGJAtmkHE3gPCPv0COZHJmsuSg3wm6Fq87Y+AUQq5n3upEHt/bA+sqI+79sf?=
 =?us-ascii?Q?4OMVatrBTv2fspiFTDDn+kSRBo1ee4zrZYT4BxxIM18FUb4OBwhzHxI3QrlK?=
 =?us-ascii?Q?wlCDDcuxuzkCgWbgYjDnC1sPHozK9scVs3nDbWPvbudRdZD5ugnT/PTY7Xnj?=
 =?us-ascii?Q?VolQTyGWM5WxOVIQoTNwwPFbFy3I+ivqpfmn9Iqa4PNfp3K6zndCRpOROGt6?=
 =?us-ascii?Q?P/CgzckCwQ5IzacPlLFG5RMN7cDkMEfbY0qUBUw4VVuhrh8Xwd+8ern3WCqE?=
 =?us-ascii?Q?M4CO6FtvHTwv4IObfVSIAkcGa05YUmDQF5Rq48vdA2QD2rDncKUhoRzGbMFP?=
 =?us-ascii?Q?p+dxPO/aLkqT5WbRwmRQKgszFXCh3uQiaumMHuYXxIjc691YB/hkWjfMUS8C?=
 =?us-ascii?Q?7IJ6rI9WbXso0vlZQnyE1O1vQOjgtamqY3O8BTR7/NHCfQgtBT+TwT91OwQH?=
 =?us-ascii?Q?4QP/UUkEqwHtSSEx5lixZz/VcqU7fjyeORmrgaieLk+umMzcpKEWgiLsjrVi?=
 =?us-ascii?Q?iDWET4C5SVaiobjavXe4QGGXefh6EOhEjleDJUB8xr5FvYPH4j8+jcLgwX/D?=
 =?us-ascii?Q?YfWdEDpxergWsO2JgOtuk4qOHsAEHcJijauxBcR+RW5sCBXPSkdCJr+SXY0k?=
 =?us-ascii?Q?KxpkpY92Slnhqz2J/PTjc+sM2oMZyFRNP27cj2BlFbfRFWN+XgZDMkzKH3Sa?=
 =?us-ascii?Q?9v6CAQ5SawlSfoiFLHY4KQTksxLrpFl1BBz9gxZrZ/lq2mPLpn1eCW6EFD90?=
 =?us-ascii?Q?WB+cKkQmA5VVnJFnjDzyf7uuJ/V5lQkdz91FnW1Bk5big1l363JoIGNd24xm?=
 =?us-ascii?Q?fQ1qHIqmwozQmJle2RMOwBzbNLJY50HMdcBPxi9Rvug9v+t7z5G4S2Lz+rWk?=
 =?us-ascii?Q?pX17ArMPOn12QRmW42zk6MQM1QEU/dbmLTOpRibVHPHhiM9YC3cmomk2/IZK?=
 =?us-ascii?Q?tpmyb+1Ahhr4jIcU9rHnW6Tyz0wLTdno/AKehdDcw6HAB5Vf1Iklv1PXhMJt?=
 =?us-ascii?Q?v0qJWGbBN1g65554WYRYxocLluXe31U50NKDxjAvRlZkrvH8Qe/CafzQWgkb?=
 =?us-ascii?Q?Gi4LFI35692z1JJyqrfNeQVHhVqjPFBdUK16VHawFYh3BsKAPvGICGrouceA?=
 =?us-ascii?Q?gXrUKXSyFEH4Qsr++MzfRHQZjjHqngCPrnEgS1S2zTOIpE+PqTNGERfG02kw?=
 =?us-ascii?Q?E8wwagDQJe4sRj37bZItBi1NAtszlwWsTa7B7nMHq86sWor+NtQYCFZn7sW9?=
 =?us-ascii?Q?K7MvhWIPwL364v1UnbOMqvuHbOQzsWYm48YF9lFyamfGZtSYO/0gOot9sdEc?=
 =?us-ascii?Q?l6XGwJSFCPRZTKNXe/K3yKtTC/PxYXsVsqSLWK2taSZXJcCb3x75PsegYBZU?=
 =?us-ascii?Q?xfrq6XO++G133J9PTYmj8gI3IxFLEt2dmPHoCdgwJiSiF+v/SFWMZREyFMy4?=
 =?us-ascii?Q?L7N8EHq7LGA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2tHjiN9EspW54pgWo0MKp97G11LtPccDiHAWvoI/T9V4A8hmHUlr3y+VpQE4?=
 =?us-ascii?Q?ltrCD1/KKuCG6dWRQ2mHABdEYJTt9cFkhzR+vQBGLUno5mrHX9KnTCDsiHSf?=
 =?us-ascii?Q?HAkIhCd/Rr/Fdzyja+jDBBcHEI56BbiJlfQ/LJ2p+UFHCoUhghKLCGYwZwZA?=
 =?us-ascii?Q?AKriObajEGpZgIvz8RPhDcgc/I8PnfgDKDXSeDzWAtEb9/1x6rPVYJwe6J+d?=
 =?us-ascii?Q?859e+xmqJvRX4xiI8yJypx9c71WNvu9ogjZyi9/s95KYr0ZAOGTa1j78jjhV?=
 =?us-ascii?Q?nf2UUPEbdmeN/niVx+FDIWZAMXvVknpz6CPEFrVfdN+RXu932gK6nNTZB9ya?=
 =?us-ascii?Q?6EJMgbPG9Qm2UZR63UH/VNOOkcS9wlD94aM5LlUbSRZ5libXvS6jA2wtQjgj?=
 =?us-ascii?Q?Yu6tdX9/YzFXJioF+DzOHWpYizGyaHQeb3K7t2FK8i7brzMAdOOguYrzOypk?=
 =?us-ascii?Q?kpxo5Sh5eelf1nLXz/3REh5ztGWMYLts1UtzyuoJSOrqLGc6HIZQt7N50uT9?=
 =?us-ascii?Q?GXqlnyO5HxKxc15d0if33rHF56Pwa4Tl+0XOTNNrVp0+uOTzwN37sxjYWHqh?=
 =?us-ascii?Q?YEVyl8WYs2HO8tiR/6qjW7l0CtyE4GyYTJR/QyualRvwESVoiUHJLDa2XbKk?=
 =?us-ascii?Q?NFxk/c4XNsp5wHZ3hHW+4dv7K4OEjSoFa0hm1yVdjMn+YBdkpmvhhPCKxZoo?=
 =?us-ascii?Q?PyaePZoifKR49yW4XlPVp8G/iE/lG49J1iVKbth+Ef/vaNU6FEkjyWdI1Qg4?=
 =?us-ascii?Q?rS3XFoLEuv4hsy+4fZRQ1RQJF36XB2u/+FP1ihhnzGvWYLUXh3u05m9GlgCJ?=
 =?us-ascii?Q?KxtkMUpX1j4naa3prO7xQFEVf47BtYfdnEqwgzhxl+m3mXZhq9i+pBvVH8aw?=
 =?us-ascii?Q?vGnSxuCtUFfynjj06aE375gdIrlgPUWYPgQJwtAkVJeBoaDvuriy9OXVW8o1?=
 =?us-ascii?Q?vstzoIMN5kRLSPEXn+KbqpS9UUTVjbgRWB9rBn1XSzlibsmko4Hg5TPEvIIL?=
 =?us-ascii?Q?WXLmSj6L/xtyuUBro5WoRXP4pjoNQnxifPWTfD5liayFeCAJS3F5A1+B+gYL?=
 =?us-ascii?Q?c71BTXhy2W1CIGY3Nl33Om8/sM2Fbr24fVlMieb6Mond22P+u8/+/xEHnf93?=
 =?us-ascii?Q?fs3KH2ntRe1lzA4rHDKCv2dQcIHDeZQhmVhteBKaw1Djt6Be6t6mBoMSAUjd?=
 =?us-ascii?Q?/NTkkHbIcsJszaOigkv6DvAVZDSS7zHf9nkFbUxOHWUrs7XZYJWfKw/OmNhC?=
 =?us-ascii?Q?fNQwaQL6455yVJlQjylMoqIbD8AYR331HC9RsF61KQdO6DfqiKhBj5XmGsKG?=
 =?us-ascii?Q?eZkIEBaOWNFhSmDv4j4lmNbXLFljuDix8Wrnlm4EIL31EoSsc47Wp3O7Ybcz?=
 =?us-ascii?Q?h1cHjp2uEiqArJZkU8fMEBzDBNJT4vS0HTGgC3dWigNm9uYjjlVg1TgDsBTu?=
 =?us-ascii?Q?CEDdFRrCrASqUFD1M8Hdiw1oxGlnyIXfv9vcErZ0gdIt0cujOiKeCsXHzy+/?=
 =?us-ascii?Q?D/1jXC+L7yH5QZ36bHVBqLfvH+IrjBQQWmIMHYZB1Dre02ecQFh5gVCc0xLl?=
 =?us-ascii?Q?1iLOmzSRFznC+nCKjz6nIJTm3T6x60VCsbEjz+YE+MboVOWG8xhKP9Q4gQZW?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de9a08f9-d348-47c0-fa6e-08ddad872896
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 10:10:17.1728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvfbNj73OodcImjySviewygEuz47Z1cVgA6YpbEEcPSsu1muQeBbbv6vl44XfQeEXLh4nf7xM30AulhMSvl5+iMYXWEyGa6cQW3IPfqmwmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8190
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

On Tue, Jun 17, 2025 at 12:14:29AM +0000, Soumyadeep Hore wrote:
> E830 adapters currently support Tx Time based queues.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>

Hi,

as a general comment on adding documentation, only split lines at
punctuation marks. If line length exceeds 100 character for docs, that
doesn't matter - neither does it matter if the lines are a bit short.

See also other comments below.

/Bruce

> ---
>  doc/guides/nics/ice.rst | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index 77985ae5a2..e7d1fb2e1b 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -415,6 +415,31 @@ and add the ``--force-max-simd-bitwidth=64`` startup parameter to disable vector
>  
>     examples/dpdk-ptpclient -c f -n 3 -a 0000:ec:00.1 --force-max-simd-bitwidth=64 -- -T 1 -p 0x1 -c 1
>  
> +Tx Packet Pacing
> +~~~~~~~~~~~~~~~~
> +
> +In order to deliver the timestamp with every packet, a special type of Tx Host Queue is
> +used, the TS Queue. This feature is currently supported only in E830 adapters.
> +
> +The tx_offload ``RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP`` is used to enable the feature.
> +In order to deliver timestamps internally ``set txtimes`` is used where inter burst
> +and intra burst time interval in nsecs is provided.
> +For example:
> +
> +.. code-block:: console
> +
> +   dpdk-testpmd -a 0000:31:00.0 -c f -n 4 -- -i --tx-offloads=0x200000
> +   set fwd txonly
> +   set txtimes <inter_burst>,<intra_burst>
> +   start
> +
> +Based on the offload

The offload - meaning the offload flags? Where should that offload flag be
specified, at Tx queue setup time, or at port configure time?

>  Tx Time Queue will be enabled during ice_tx_queue_setup()
> +only for E830 adapters. The initial time should be fetched using
> +rte_eth_read_clock(). Further the timestamps should be calculated based on the
> +inter_burst and intra_burst times, then storing it into proper format as to be
> +placed in packet header.

What is the proper format?

> The timestamps should then be copied to packet mbufs
> +and packet header length should be adjusted accordingly.

Where in the packet mbuf?
How should the packet header length be adjusted? Should that be done by the
user, or is it done automatically?

> +
>  Generic Flow Support
>  ~~~~~~~~~~~~~~~~~~~~
>  
> -- 
> 2.43.0
> 
