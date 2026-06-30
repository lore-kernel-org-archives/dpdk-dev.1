Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4386BC43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 15:20:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6082A4067B;
	Tue, 30 Jun 2026 17:20:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 0B3DD40611
 for <dev@dpdk.org>; Tue, 30 Jun 2026 17:20:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782832811; x=1814368811;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TqKl9Mzl/TGHWSlEgflLkWFhGnprjKt3j9R2eJzELxY=;
 b=kjTtADkaxceA1y+MfLOO1EoR0ObxH4wXxX7Vfu/xY79cWgVvBqopD1nS
 6RTMBBD3OQR13FQByvrxAc1dv8RGc1OEk/zI7diTRmwn/vy9Nc3vS+RBR
 rBID64yxMtu3TGgRl/f50TJ+aHzQci/1lvX8Bcr0LKYfaSEEsDZkOR8Fh
 khGCxKtfRCdLpEmPhy+hzg2PTbs74ZHsTLAVB2J0S2mQhw9YOIQBBVUNb
 Nh71hMrAKi9M8NQbiM9wi5cBYb6lvwNZyp2ZkcyRT16qMd4ezKVMi+RGn
 ECpaPsAmVlN0r78lrV33K5S2jjvmisKjQLSJ4MPQbF7nsx71nv6EQZXL8 w==;
X-CSE-ConnectionGUID: 1Ta2T+3sRVmXueige6e4kA==
X-CSE-MsgGUID: 84ZrFqRITXecwVQH0a2ftQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83685743"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="83685743"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 08:20:10 -0700
X-CSE-ConnectionGUID: +wMPhietSeG66sH/iT3pLA==
X-CSE-MsgGUID: PPYqMJVHRTSxnMyzhhr3mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="276578182"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 08:20:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 08:20:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 08:20:09 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.31) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 08:20:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n76cxNQ/5dgMMXcHMPdJt7kFhCCCrNd0da4Nst3/vAkLtNhAOVLa6S8YWOt92BCeBBK5Z7XVXZCKZzA8kYd9DQdyTbrP1PIkYU2omrvlNlxuPA9uDaUMLR+C7TQbkNNRVFySqPffpXhUaE5gX9jzjXPf0MTy+FhC4gX/1jyuFRuHrFrZtRP9KnkL6gcDU8XNbehAgaWy6QRBKCynTd4s4eNf6xvMFIHZYSVyn+KruIWO/SF1yF2bdpYC05Ag2Roy62tMFGwXFYv0QtqJAV5uuIgZSgX89PZ/g/HXtX3PULOXFP/HjEVf0muf1yRWZOL8CBr8YkajQQzeZA9l1RqlIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liv6KVNEkuW78y+QTcGkZQkDXX+hegFKKMpupQ2GopU=;
 b=oC1iuIfgf8o26cSlIflEnIzjqoHckkOLCSoG3yUO8DbiwfVAmLEkixqbyy2lXrOrBIzvr+mTu26YQYCzNkcOO06bR4XWsHuQK7kSMa67ihjHNNQlA8u0PqenNsoN2qVQ5DxOQSFkFJB4txnP1UwmoCn1vgrjBWkIlwBh7PlzggNQzId8rEd2zDOuL+E0z+gri2hXz8jGF+SX+p3jTa8QCUS9tsNiZnieDS+9/L1VgX1Bguh84o6LIfzi1HeLCZbKyJ2BrOYBeIaUZbCkkmc7jjC20/mw1c+mvvywIpEz/SWaid3qyfNyXeO+CvHEBWU/2NuMSKd9OSjgiJZ1mLlB1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA0PR11MB8333.namprd11.prod.outlook.com (2603:10b6:208:491::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 15:20:06 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 15:20:06 +0000
Date: Tue, 30 Jun 2026 16:20:01 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dawid Wesierski <dawid.wesierski@intel.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <marek.kasiewicz@intel.com>
Subject: Re: [PATCH v3 3/6] net/ice: add scheduler rate-limiter burst size
 devarg
Message-ID: <akPeoZMNCDOpq6iN@bricha3-mobl1.ger.corp.intel.com>
References: <20260618144442.312844-8-dawid.wesierski@intel.com>
 <20260630120657.1046588-1-dawid.wesierski@intel.com>
 <20260630120657.1046588-4-dawid.wesierski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630120657.1046588-4-dawid.wesierski@intel.com>
X-ClientProxiedBy: DU6P191CA0064.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::24) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA0PR11MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0d0eba-ba4e-4676-92b8-08ded6bb10a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|56012099006|18002099003|6133799003|3023799007|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: NAcrTtNPKmC+wwXsL0Y/uJPsXCTGQYCrqq0VDa4xZ4v1nbHzxWPcNLhroe5U+yYn31pfLQzPJIwlq8T3P2nSLzF5Sd8eccXL4GcRjGFEPxGbDUuxVHwUK39rOqsVC2quSc7EMtA7M+yPrcxW+69sXPGaIo4sE4HiTaL4QAgR18WRM2oynTXMqK9NCEop9H8AmHDKKH768p7JAIQcFVNwTiE2TIaIBoZ5/Lj1JL/3cxK44oy8QzQeb3K5dkPaURC7VBCd/nI0VV2nIm3d4bmaWe4P3HNhWyHna6JGtzAtiYUPHPFCElp998CY0NFaw5xMMj1fg4wNO47YSEyqdrWOGl4KMsCUo+0Emk3qAQB9eRTjfZqbFzsmNKsMgHkwLL45sFBChDWQbb9StDxHJnQyriwNyefZAwASChBJ6eNYUew9BNaUYOG5Dkc6RExSKLKEDWHzqry3rD2cwWWbM96vDR7WOdcNS5OhnK/LJ6E6oVigTcpfHHCg5pUs6CsIqUg2G2L/3aTq32pF5MyVX0btp1srPyRxsGNEVRUzwrXAvb58/BBmPS05UwrUHIAdt7aanR9vuHLMJ+NS+O6jBahqxOUwwCFI4Fya7M35/nZuuytFhpu3lq/CqQ3Pk5F4T00iR1TElsXg7pqqinVDbbstOaqAootF2B+XqiGVs7QvH+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(56012099006)(18002099003)(6133799003)(3023799007)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q5CPN8mtXx77sljiPfUpuWNzfd3o2t7HnEDhviJ9RwQyJhAekJdJgadOkA6J?=
 =?us-ascii?Q?QZeKEsVjh4vdquqrtsk1ppZjLwaojlKSzZUVF8SZGbsyp7uAiwsWFKefze4g?=
 =?us-ascii?Q?hxbB8XfyDteEGZ+/l4Tx3crTNgisDTTqvQ7/aMoOacPU2Ac7LvKpzBKVN8UU?=
 =?us-ascii?Q?aBSl6xvL68mUmARlgOSuwv4uH0ZJt7iIuf2csvicITVarIFUf8x39BmUOeFS?=
 =?us-ascii?Q?4iZEB24YHVipd3H+wjzQe1d5hdcNyDcQd/HdKCIP8Qagbnlm/UqcbmtnzEJo?=
 =?us-ascii?Q?ccdP9PFrim8APy1HrX/oMRABxFMZi8188mKQUNkkzCbc00uYfBnn/los2QSF?=
 =?us-ascii?Q?DdM43Ft6c721/3SgO7tdR0LUxjU8MF6y5r6XBlDXSVHl6wMruzGP6/aLR2sg?=
 =?us-ascii?Q?9pc1CwoIYCjMv8CHUnwzUo45ACvs68Sf9hFefYGZJ62TZxu8/0xbbsKHwxPD?=
 =?us-ascii?Q?t90O24+TK4aj/0W+Y09PErzdqN7YpT9vsW/tnXcQ6UtJjLqSmMrsSOcPz5Uj?=
 =?us-ascii?Q?0XYfGBg2Y17nFjwfxIDGVr4Jtqqfc9qNst0zafYqkaPItgFWTC83Qq/wDJGq?=
 =?us-ascii?Q?0C68b3K1AuUVOPbM8LTAAEdQzW2f8Q7gwk312WYTbS+Ew2qCze0LcEfLU1go?=
 =?us-ascii?Q?16nrwgrVmhd9VQlFnUdfxSk2c47wF+2CACyCbx5KitpUzUyN3TR/odOVRIMG?=
 =?us-ascii?Q?//5YKeePoh52vVSdHuv1eZ/fskTT1K9UMwciv9kKAOEMTyuxqGiJLLlAwy8H?=
 =?us-ascii?Q?U6IjsEaNuGHdF7J7Gwmy6NEaqIs56x+x/hmA1CYI/TIXDcSMYVdh9IfTKPVE?=
 =?us-ascii?Q?HroQPUwHCAVD+h2RoUEig7kYxTDiEsxqFWVtdVv8sZ5UY/Eiv+r1G/k/UaX/?=
 =?us-ascii?Q?cAxIxxe6xt9bropPzDJ/LRgutGDP4qO35QCEKpVz+r+XCD3+e9YKmHdxVg7a?=
 =?us-ascii?Q?Vf75Wjd5e7INdVUg4xHYeBMnF4yvLfP1nBFODak0G6BNbT79LWhpR7VagTzA?=
 =?us-ascii?Q?ovw5IqhAuZDl0jRBP5lzIT953TmJgH4PW60HvV3vdCLZ4Z2J8lTNqG9jdkez?=
 =?us-ascii?Q?TEXTiXkyLlaJFEZ9tqPdFazxAvY56wpDXlvbsWGddxNj+eWtuXeC4mRMuI1M?=
 =?us-ascii?Q?OEdaYbjVpraUeJHOzLKLAaZL8vbgsVxPxUDmUYOx87bC5lo3XwLKUNyqWtDX?=
 =?us-ascii?Q?DI4TTaw3moMWkzgVMa9dPPREf3aDDhzVBafOTRHhMvl5mv51LpIfO+HHpnxd?=
 =?us-ascii?Q?HQft5Tc2KbqDYcB9vnp8NzdluGL9gABdD4mtUe5I7HPLcdAjNTIGBRKOX1Ff?=
 =?us-ascii?Q?M6mlISrNT8duHVTN4hR/SdXB/Ip4A748+Svq8NnwfP1z2gRs8RL/wPDfJTWU?=
 =?us-ascii?Q?51TFBb9ftGm22pBZWW5kk+KYx62pY9rygxNGdKl79ByrWRPgZfpdAvn+wYFK?=
 =?us-ascii?Q?XNic9csh2tWHxbJywQHQQY5I+0meja78gdRn4bQSUFqVvVPQ9bTnFnUj9fk3?=
 =?us-ascii?Q?BsxwyuQAO3djVtGCeWvP9ZEICAWVqbOMYSY8F8cBMR28hse3A2HoYf9lMZHB?=
 =?us-ascii?Q?7bCITrK7HZveLbL/IVHiqEZDqH0PLdLPma7BvJZGSeC1/Dez/bud/rAimhjs?=
 =?us-ascii?Q?MrC6CFcDDnC1IzDSj/tW3GbJaIynRdfocsXVE1Qtv5g5kTKtIOp52e0nWW+5?=
 =?us-ascii?Q?vaqqqYFC50Q9Z4hiAyYdzL/zTABZNyyvsIxRd3HV+AaZY3TtrhYGxZRLb53/?=
 =?us-ascii?Q?ISclTdVsQf8eGe4FIvSTjUKCyDtsBrI=3D?=
X-Exchange-RoutingPolicyChecked: Hhcm+X3d4XkCvD184dmFMPXsBT0Q8/hHxqTv0i93FSCpm1hzaCLB4LzJkSgIRtPltpLqFdOlaVCxLV70cy2aEfkVDGNUFPz230smLqY/VDGi5Y9WNyX04dLCMMZlzUKPwQ4/6Q/jIb5148uh8y+33PWyUNd4O9GETIRbRyStlXB7qF1w5Ga2RIRtKsOUp8f+ui0X1ox25OcyGUnx9ge/fY/EE8KD9EaKuxPtprehabcPeT88R+zkYS5iA++oWCG0RqGPX2bNFPj9ou+za81Acdv2d5L+ZXcOs8THAKtx/+upJernzX6RviNro/0NU6seN3rRURuSUOTMKdmwopB17Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0d0eba-ba4e-4676-92b8-08ded6bb10a6
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 15:20:06.3871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oe+4A1n5pbeVk+XvsaCkD3PTXiOY1ZwfGBbVxfkRkjIJCpWipoNneX84mTMetZOrEC+9oDPI7S9JsZzyBEr4IoXNEu2wc0xICxJ7uPv0WlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8333
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

On Tue, Jun 30, 2026 at 08:06:53AM -0400, Dawid Wesierski wrote:
> From: Marek Kasiewicz <marek.kasiewicz@intel.com>
> 
> The E810 Tx scheduler uses a token bucket algorithm where the burst
> size controls the maximum bytes sent in a single burst before the
> rate limiter throttles. The hardware default of 15 KB allows
> micro-bursts of ~10 max-size frames, which violates tight
> inter-packet spacing requirements in time-sensitive networking
> applications such as SMPTE ST 2110-21 narrow-sender compliance.
> 
> Add a "rl_burst_size" device argument that lets the application lower
> the scheduler rate-limiter burst size (for example to 2 KB) to force
> near-constant-rate output matching the configured shaper profile.
> The burst size is a global scheduler resource, so the override is
> applied once at probe time and only when the user explicitly requests
> it; the hardware default is left unchanged otherwise.
> 
> Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
> Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

However, one issue flagged below that needs resolution before merge.


>  doc/guides/nics/ice.rst                | 12 +++++++
>  doc/guides/rel_notes/release_26_07.rst |  5 +++
>  drivers/net/intel/ice/ice_ethdev.c     | 46 ++++++++++++++++++++++++++
>  drivers/net/intel/ice/ice_ethdev.h     |  1 +
>  4 files changed, 64 insertions(+)
> 
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index 8251416918..187c7e821f 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -158,6 +158,18 @@ Runtime Configuration
>  
>      -a 80:00.0,source-prune=1
>  
> +- ``Scheduler rate-limiter burst size`` (default ``0``)
> +
> +  The hardware Tx scheduler uses a default rate-limiter burst size that favours
> +  throughput. Time-sensitive applications can lower this value to reduce Tx
> +  latency jitter at the cost of throughput by setting the ``rl_burst_size``
> +  devargs parameter, in bytes. The value is clamped to the hardware-allowed
> +  range. A value of ``0`` (the default) keeps the hardware default.

The documentation here is wrong, in that values are not clamped, but are
instead rejected if they are out of range.

  ICE_INIT: ice_dev_init(): Invalid rl_burst_size 2097152 bytes
  testpmd: No probed ethernet devices

If you like, I can update the docs on apply to remove this clamping
reference. Alternatively, if you do want to clamp the values, please respin
this patchset. If you do, you can keep my ack on the new version.

> +
> +  For example::
> +
> +    -a 80:00.0,rl_burst_size=2048
> +
>  - ``Protocol extraction for per queue``
>  
>    Configure the RX queues to do protocol extraction into mbuf for protocol
> diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
> index 5d7aa8d1bf..db8c4d5b16 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst
> @@ -136,6 +136,11 @@ New Features
>    * Added support for transmitting LLDP packets based on mbuf packet type.
>    * Implemented AVX2 context descriptor transmit paths.
>  
> +* **Updated Intel ice driver.**
> +
> +  * Added ``rl_burst_size`` devarg to configure the scheduler rate-limiter
> +    burst size, reducing Tx latency jitter for time-sensitive traffic.
> +
>  * **Updated NVIDIA mlx5 ethernet driver.**
>  
>    * Added support for selective Rx in scalar SPRQ Rx path.
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index ad9c49b339..465cf07383 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -41,6 +41,7 @@
>  #define ICE_DDP_FILENAME_ARG      "ddp_pkg_file"
>  #define ICE_DDP_LOAD_SCHED_ARG    "ddp_load_sched_topo"
>  #define ICE_TM_LEVELS_ARG         "tm_sched_levels"
> +#define ICE_RL_BURST_SIZE_ARG     "rl_burst_size"
>  #define ICE_SOURCE_PRUNE_ARG      "source-prune"
>  #define ICE_LINK_STATE_ON_CLOSE   "link_state_on_close"
>  
> @@ -59,6 +60,7 @@ static const char * const ice_valid_args[] = {
>  	ICE_DDP_FILENAME_ARG,
>  	ICE_DDP_LOAD_SCHED_ARG,
>  	ICE_TM_LEVELS_ARG,
> +	ICE_RL_BURST_SIZE_ARG,
>  	ICE_SOURCE_PRUNE_ARG,
>  	ICE_LINK_STATE_ON_CLOSE,
>  	NULL
> @@ -2147,6 +2149,29 @@ parse_u64(const char *key, const char *value, void *args)
>  	return 0;
>  }
>  
> +static int
> +parse_u32(const char *key, const char *value, void *args)
> +{
> +	uint32_t *num = args;
> +	unsigned long tmp;
> +	char *endptr;
> +
> +	errno = 0;
> +	tmp = strtoul(value, &endptr, 0);
> +	if (errno != 0 || endptr == value || *endptr != '\0') {
> +		PMD_DRV_LOG(WARNING, "%s: \"%s\" is not a valid u32", key, value);
> +		return -1;
> +	}
> +	if (tmp > UINT32_MAX) {
> +		PMD_DRV_LOG(WARNING, "%s: value \"%s\" is out of range", key, value);
> +		return -1;
> +	}
> +
> +	*num = (uint32_t)tmp;
> +
> +	return 0;
> +}
> +
>  static int
>  parse_tx_sched_levels(const char *key, const char *value, void *args)
>  {
> @@ -2448,6 +2473,11 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
>  	if (ret)
>  		goto bail;
>  
> +	ret = rte_kvargs_process(kvlist, ICE_RL_BURST_SIZE_ARG,
> +				 &parse_u32, &ad->devargs.rl_burst_size);
> +	if (ret)
> +		goto bail;
> +
>  	ret = rte_kvargs_process(kvlist, ICE_SOURCE_PRUNE_ARG,
>  				 &parse_bool, &ad->devargs.source_prune);
>  	if (ret)
> @@ -2662,6 +2692,21 @@ ice_dev_init(struct rte_eth_dev *dev)
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * Override the hardware default scheduler rate-limiter burst size only
> +	 * when the user explicitly requests it. A smaller burst reduces Tx
> +	 * latency jitter for time-sensitive traffic at the cost of throughput,
> +	 * so it must not change for every port. ice_cfg_rl_burst_size()
> +	 * validates the value against the hardware-allowed range.
> +	 */
> +	if (ad->devargs.rl_burst_size != 0 &&
> +	    ice_cfg_rl_burst_size(hw, ad->devargs.rl_burst_size) != 0) {
> +		PMD_INIT_LOG(ERR, "Invalid rl_burst_size %u bytes",
> +			     ad->devargs.rl_burst_size);
> +		ice_deinit_hw(hw);
> +		return -EINVAL;
> +	}
> +
>  #ifndef RTE_EXEC_ENV_WINDOWS
>  	use_dsn = false;
>  	dsn = 0;
> @@ -7713,6 +7758,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_ice,
>  			      ICE_DDP_FILENAME_ARG "=</path/to/file>"
>  			      ICE_DDP_LOAD_SCHED_ARG "=<0|1>"
>  			      ICE_TM_LEVELS_ARG "=<N>"
> +			      ICE_RL_BURST_SIZE_ARG "=<N>"
>  			      ICE_SOURCE_PRUNE_ARG "=<0|1>"
>  			      ICE_RX_LOW_LATENCY_ARG "=<0|1>"
>  			      ICE_LINK_STATE_ON_CLOSE "=<down|up|initial>");
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index 20e8a13fe9..0a9d75b9cd 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -631,6 +631,7 @@ struct ice_devargs {
>  	uint8_t ddp_load_sched;
>  	uint8_t tm_exposed_levels;
>  	uint8_t source_prune;
> +	uint32_t rl_burst_size;
>  	int link_state_on_close;
>  	int xtr_field_offs;
>  	uint8_t xtr_flag_offs[PROTO_XTR_MAX];
> -- 
> 2.47.3
> 
> ---------------------------------------------------------------------
> Intel Technology Poland sp. z o.o.
> ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
> Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.
> 
> Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
> 
