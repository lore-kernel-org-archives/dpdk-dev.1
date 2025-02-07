Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69AFC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:03:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C49BE42798;
	Fri,  7 Feb 2025 13:03:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 48FF440DFD
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:03:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738929805; x=1770465805;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HwaqHJ9RTfidwAJbGTlo550O9X3XNGd0YsJBIoxyCv4=;
 b=FIMygX1s9e+7BuvihO4AyJer2wMYkzzeBYodQmIlOR1Lg9R04Jsih85g
 CqfdXY2IKAWfCBdIboFJWSgf4tP5ciDF7iZfDqlcvcAv41bg43juz6Fzt
 FhriRxNsfKEi3EcrnYHa+E3TfLo1x0y//l7ZTqukF/5K8FclmI93hGvie
 LD8Vq79lQVIN7OrBoL+KKvSC5dad94O8F7kcr1aM7j/jBM4OT1xMfXyQO
 U0vjZ4pfFpOeOgn7tBeEXkJmmF3vaiApStzETnlJ6LzQ+UsPiHKdOdaok
 f2Ez6/+uTCdXVAP4SRGrq4pnRHQfgUvtPJfjNzDwlP2Nq0pvTbW8Ipo1U w==;
X-CSE-ConnectionGUID: GTtEHjHeSSqNoe72iJmU1Q==
X-CSE-MsgGUID: M+OrOxETSpOHnw1D3LpIWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51001657"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="51001657"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:03:23 -0800
X-CSE-ConnectionGUID: OKCFsikxQC6sKRPAvB35Pg==
X-CSE-MsgGUID: WlblzI8mQf+nFumQD1yoOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="111431285"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Feb 2025 04:03:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 04:03:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 04:03:22 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 04:03:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+oS2wtBTeN7VddJ5MNhPqhRFdxb89ylVdTu/vF5Qd/MBSG6OVdZ0ayek8r31y4kPJffoXyoG4rnKsMvZnXiSrRzKzhGC7zOUkI6M1IAsLo7h4/cQtJfRwZCmANqr3f6pcdzKiiHlS+Klxd8D8YrpCvRPSB2Do8Df07Q+4b1yc2sgwmD1ewQoblSNwTVuxpE7kcuhS7SMrsjQhQE95svzZiummhmoSklv2Bpa426FVmXbzl2Tll7EYnDmYRuwEabtF9trUB85pZjH4LemPmGiYhEpgOK4AxbYk0g50h6VnmVboJPZmdW9cDnxSd6hAEp07vm98FXO11lVLF9JPgDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViygTSdpxNH3RitnXhl48cDGO2NOo8jV5nX9twWQIDo=;
 b=R3klVrdRdZhF9IMG9R0ZIL9HPzw16R/dXrufOTWMMUOjmJ51EY0daDR/brjZSvU0fYcb42GDCT4GtS1Uszc1M0furdukXfxalAtot3u5aab5Yxf5fcJfTNLpSxkfoHaCNvKmCOgdrI053y0/G6wsCj5HzwkhuQGiNZNh/LhOQ35k4dfBdRvxBebwe1yyt5h84528P6XSGdNGXkUqY259d73NfIikxwozQU/6Ei4iTMnc99Ah1teJKqiZ6cCjcpU5sR6Bcy7AkKZdgh3b2UUTAStYFAySkAodJAg8C/LY8pIjn0bTdXo0TYZDn6H1o7JAxjym/zsw3g8TTVziTzCicw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by PH7PR11MB6332.namprd11.prod.outlook.com (2603:10b6:510:1fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 12:03:13 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 12:03:12 +0000
Date: Fri, 7 Feb 2025 12:03:07 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v5 2/2] common/idpf: enable AVX2 for single queue Tx
Message-ID: <Z6X2e4hD7FQN94ax@bricha3-mobl1.ger.corp.intel.com>
References: <20250203052430.1243485-2-shaiq.wani@intel.com>
 <20250203075508.1304702-1-shaiq.wani@intel.com>
 <20250203075508.1304702-3-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250203075508.1304702-3-shaiq.wani@intel.com>
X-ClientProxiedBy: DB3PR08CA0028.eurprd08.prod.outlook.com (2603:10a6:8::41)
 To CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|PH7PR11MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: fb924096-29b9-40b5-ae16-08dd476f6585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UsQ24EDkCdYaej+BXFFz7EKWbrFocpnrQvTrpPRQzLJPb/CyJcr8XwW8nJ5a?=
 =?us-ascii?Q?dMSyWfAEf0pgJGncde+Yb6RQ29p7FsZxfEGv2MHi31jXO7OSITPPGDRRs90g?=
 =?us-ascii?Q?nUi2ybfPHTJnRTeM5+u93q1dELW6yS8SzGg+eOvx8bWgl92muot63qE3e8yW?=
 =?us-ascii?Q?dbyaB2rgOpys5KlnxXtHA2xfmjEgTeXKuLa0HoeZPG96uPBo5Jhh+p4BDwUg?=
 =?us-ascii?Q?UYJQce3q7ulqPlIA0kqfKVRnRkIW3YEo4WhcwSfALOcQKUMHo7DT62tvRNOV?=
 =?us-ascii?Q?Y437P+u1wpFEcX/NcF4ZQaT5cXSEHGO36HN9ng42wworz1OZ989fddOIxw7p?=
 =?us-ascii?Q?ZJV0FVNo1K5ZXlYT9P20QBW00jP9kiQZf7btmipbuJu7UbnlXnj7Ti4v9vHV?=
 =?us-ascii?Q?fggAbk0OSTDN30RNCGZi9/1vIPjXUDEJ8jobtd9lcNjWow+60MKTHTui4E8F?=
 =?us-ascii?Q?BH8zrzbgqd0N4Z2BkIqsrem1gLy5FLXOtEapg9DnluWUhnbtZC0YuMOcWBj0?=
 =?us-ascii?Q?wxf+xZVeIQOkwlSqng2kHDE9uUM/lwM7PJqXuymDvAwFOv9jmuueF0yDQo0r?=
 =?us-ascii?Q?gcI1fOZW3UQDFw+aZKsYOqF2DD6D2nV7l5o2XkY0UyoQeCqaiFPqpdoOodTW?=
 =?us-ascii?Q?3JdOPFkNduTjRY/YG9+RfAY0cISANRzfHkRP5OpyThvKW0+crzaSvhaFdYIf?=
 =?us-ascii?Q?3o7+l8EWSY2u4UKjvAsQtoPqc+PnR6EqvIfQM1RdR53gI4v+9yqi8MJ6rFfq?=
 =?us-ascii?Q?oja4bOIcirsch+DtLo720NKoU+bb+tfcaYYWfFYVE/3AwYDGp+JQaP7Zuz2e?=
 =?us-ascii?Q?2GwKtqil2rufO2GqnnXyV4KEDeW1sw6FPhLm09suUAxoyMctcnhQ6o59AXNi?=
 =?us-ascii?Q?Q0SF69fiPXxZQ6rx8mvSMlVxH2Ui4W4+210rOyYbCkCy0137w9oyhdnB7tLA?=
 =?us-ascii?Q?XALvziigBCkATDGnP2S5rknqK7laDlqX01QCZ3dfs1s9c0ikpU3VHz1/n80u?=
 =?us-ascii?Q?YYZB/TpeULUNeOsUk5dfjMbk+RT36Q7cIwDsJQ6W0Xub6mlPXolV//MABcTF?=
 =?us-ascii?Q?EDKfWGzP/wUzjAVsl3QDkwwCXZmhjVa9bmKXSE97hLKclSs5x2o+hBgUOD0i?=
 =?us-ascii?Q?/lWITdcdnlGp0Ca+gPcO0Ib6NueWw2LQd1qF2y7pcVH2wD1V/n+nct2Gnj0Z?=
 =?us-ascii?Q?zv5FXPAftniMIjI9AVNNXe5zU87eGbLjVgIERwBpoLsGoFlWaAvUVQdGK598?=
 =?us-ascii?Q?TRoZSWtPQ9Zeig8o151yYvrGWJE4u0Zb0quFGG7Xv/UTOrZpUZDYdMPwqaCE?=
 =?us-ascii?Q?xf+VWyZdC9RRN3Z2kbu63oAklGN+wBu5H6t6pF0iscqn3trf60qVMaOjsIsI?=
 =?us-ascii?Q?NOryCyLQkinUtb8e8EGY3nAg163l?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QzdqoEZL2ZYvbRztp/yfmp5kXCEDOPa4rq7+I1eYnG7EvZV78kMgWJ+4T5YJ?=
 =?us-ascii?Q?y2ZvFkM/cDjw5KgHpXfo9nDExsHlZV5dEHNLlCtC2OKcWS9SAUlQZT3jZ/JR?=
 =?us-ascii?Q?uzjLCiQILJh4KSeS+QDu5MeytXmsnChVVGUUxw+oi/9WIi+HE9cwU7c24Mww?=
 =?us-ascii?Q?2acgzy3ajP58VfP46fV/Ot9y3i7IeFALWYxhbhSUxEWMLN91eDskw1Gw3mYb?=
 =?us-ascii?Q?ysG8in+4wMnhsyA/5vmCpQ56O8TwVilJ04KzVAeUGLtUZuMufSR0mV85XDdz?=
 =?us-ascii?Q?b0ekuI+pSkCH3d9nKNkB8j7Fo5ZNxxFC/Cc7CKKRUpuJlLDNonM1POQP6jvf?=
 =?us-ascii?Q?5YSjv92x7m4r3Dgr0d7blC3q+rrRjmVwR6Bj3D5T3AFm+WgV/gmddaveB+Bo?=
 =?us-ascii?Q?bSKZGJ6S33yoX8hRlwfpAEahnFP9ZsMkIwuU/rOfjBxn8YY7mUtTlbdaBSLG?=
 =?us-ascii?Q?RJN8clPd7mtog5gvwL1U3zIe04diZMhDz/xFvlTxIP7sP5CC0azgSD8Ua6Xs?=
 =?us-ascii?Q?VrnC2j2+1obD+Y0+BoRTbKHAk9eJ4y+LMWe4xxxmNEnUWN4ElsTNMuirUp/j?=
 =?us-ascii?Q?j6cYwzWo5wBc2erINKcteQkuscybNn1LKasE/j5vjAFoHCM7ucdvO0PTvw4r?=
 =?us-ascii?Q?PhQ6EUnzB5SsVzioYfGmKXlfdc+NKB3GX2iiHe5s0l6zd8gDig0T1vjwqvYq?=
 =?us-ascii?Q?UgIRJ6hebmPMdJmArPiP/gOeIDgT+BBnU32v2Iw0vPQaRnIovayQ3J41RV/d?=
 =?us-ascii?Q?yDst7Bb5WQ670X78dzeyRR7rz4vA9KZTsi1CzEDd8rV24xX0DJIMJW5OKi/J?=
 =?us-ascii?Q?kSvNsTmxM81t6SmQu44Z0jWnNmBSX/AupIMPDm2Ha68xH0+r2o0vat9wDO7+?=
 =?us-ascii?Q?/oDFMT8GGqbguAGIHfSIFmnJTvwkUeAp/+SdAePuds+9m7gIH30dQSt/gKbF?=
 =?us-ascii?Q?/Cfmho40lLDq3mJNGPWB0qB8aI+lGb3T9rHxCFg+2rlKQjhR2p+JnqolZd4w?=
 =?us-ascii?Q?buNl5CliTUROFXB4nbTXHDK5PTCXnsqpuVCbQ4f4m9GECPUXryKuqy0iZzNb?=
 =?us-ascii?Q?U/kylcGtpwSnflgwcAzhNwlRoF89g89FCoMqnsSQxWC0GzK4y1F4C5d5mVDU?=
 =?us-ascii?Q?aX5ZI+wK7tI//bUtyN66FG+ij7Q9Wqj8Owfv13mQYcrhSNmtHkNpIciMuebf?=
 =?us-ascii?Q?v9xyxi5Ex4CETY4dvkarpGTyjBt77d03BOH/Y1brkFLbx32JXrxbVqOO7dQw?=
 =?us-ascii?Q?7k8xKTKjZTDmvXIBqTPJeU1aJZf4GIvLnrRXIt7iqu7CYFDEFPIrKmQlvMqC?=
 =?us-ascii?Q?9m6VKMBvQYQWcxlxBXCeQx0rKRuDO7ktowdNhHOCQq7YCXHuB17qZyp69ZCy?=
 =?us-ascii?Q?Qeo824Y6hpyvwA8FJMr8xAi0T/KT3LTinQTJDQK0iNKGHHaj2BPIDb+NLrrp?=
 =?us-ascii?Q?56dBWt+Li2deoXqR2LL4IvC8qkZ0nR7si0kbLPOXLO3C+A4+Op8rgLon8OPU?=
 =?us-ascii?Q?PBs1RCJM+sj1g/z7LCMk0Y32mgK9P6NQ+IEQX+1SdKC2z5pEgN6hozBJY76Z?=
 =?us-ascii?Q?edc/YZbuDhcgHm6ePfy0YetYdkl9yg1WczlaU4BNsX7/i4PdfSE4c53QMSVx?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb924096-29b9-40b5-ae16-08dd476f6585
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 12:03:12.8640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gdbRvblqtznFk135Vu/AKwBSLXvKeGXL9jkKcwaFlBhcKId4NPRfd2gAJwQPJXQPUbFoIkTvX7bJn4L/fd2UvKasOFbP+JlRWFBf1rq4hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6332
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

On Mon, Feb 03, 2025 at 01:25:08PM +0530, Shaiq Wani wrote:
> In case some CPUs don't support AVX512. Enable AVX2 for them to
> get better per-core performance.
> 
> The single queue model processes all packets in order while
> the split queue model separates packet data and metadata into
> different queues for parallel processing and improved performance.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

See feedback inline below. Would it be possible for this release to rework
the driver to use the common functions from drivers/net/intel/common? If
not, can that be looked at for the next release?

/Bruce

> ---
>  doc/guides/nics/idpf.rst                    |   8 +-
>  doc/guides/rel_notes/release_25_03.rst      |   7 +
>  drivers/common/idpf/idpf_common_device.h    |   1 +
>  drivers/common/idpf/idpf_common_rxtx.h      |   4 +
>  drivers/common/idpf/idpf_common_rxtx_avx2.c | 224 ++++++++++++++++++++
>  drivers/common/idpf/version.map             |   1 +
>  drivers/net/intel/idpf/idpf_rxtx.c          |  13 ++
>  7 files changed, 255 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
> index 0370989a07..90b651d193 100644
> --- a/doc/guides/nics/idpf.rst
> +++ b/doc/guides/nics/idpf.rst
> @@ -93,9 +93,11 @@ The paths are chosen based on 2 conditions:
>  
>  - ``CPU``
>  
> -  On the x86 platform, the driver checks if the CPU supports AVX512.
> -  If the CPU supports AVX512 and EAL argument ``--force-max-simd-bitwidth``
> -  is set to 512, AVX512 paths will be chosen.
> +  On the x86 platform, the driver checks if the CPU supports AVX instruction set.
> +  If the CPU supports AVX512 and EAL argument --force-max-simd-bitwidth is set to 512, AVX512 paths will be chosen
> +  else if --force-max-simd-bitwidth is set to 256, AVX2 paths will be chosen.
> +  Note that 256 is the default bitwidth if no specific value is provided.
> +
>  
>  - ``Offload features``
>  
> diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
> index a88b04d958..905e8f363c 100644
> --- a/doc/guides/rel_notes/release_25_03.rst
> +++ b/doc/guides/rel_notes/release_25_03.rst
> @@ -76,6 +76,13 @@ New Features
>  
>    * Added support for virtual function (VF).
>  
> +* **Added support of AVX2 instructions on IDPF.**
> +
> +   Support for AVX2 instructions in IDPF single queue RX and TX path
> +   added.The single queue model processes all packets in order within
> +   one RX queue, while the split queue model separates packet data and
> +   metadata into different queues for parallel processing and improved performance.
> +
>  
>  Removed Items
>  -------------
> diff --git a/drivers/common/idpf/idpf_common_device.h b/drivers/common/idpf/idpf_common_device.h
> index 734be1c88a..5f3e4a4fcf 100644
> --- a/drivers/common/idpf/idpf_common_device.h
> +++ b/drivers/common/idpf/idpf_common_device.h
> @@ -124,6 +124,7 @@ struct idpf_vport {
>  	bool rx_vec_allowed;
>  	bool tx_vec_allowed;
>  	bool rx_use_avx2;
> +	bool tx_use_avx2;
>  	bool rx_use_avx512;
>  	bool tx_use_avx512;
>  
> diff --git a/drivers/common/idpf/idpf_common_rxtx.h b/drivers/common/idpf/idpf_common_rxtx.h
> index f50cf5ef46..e19e1878f3 100644
> --- a/drivers/common/idpf/idpf_common_rxtx.h
> +++ b/drivers/common/idpf/idpf_common_rxtx.h
> @@ -306,5 +306,9 @@ __rte_internal
>  uint16_t idpf_dp_singleq_recv_pkts_avx2(void *rx_queue,
>  					struct rte_mbuf **rx_pkts,
>  					uint16_t nb_pkts);
> +__rte_internal
> +uint16_t idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue,
> +					struct rte_mbuf **tx_pkts,
> +					uint16_t nb_pkts);
>  
>  #endif /* _IDPF_COMMON_RXTX_H_ */
> diff --git a/drivers/common/idpf/idpf_common_rxtx_avx2.c b/drivers/common/idpf/idpf_common_rxtx_avx2.c
> index 277b2a9469..7d292ff19e 100644
> --- a/drivers/common/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/common/idpf/idpf_common_rxtx_avx2.c
> @@ -478,3 +478,227 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16
>  {
>  	return _idpf_singleq_recv_raw_pkts_vec_avx2(rx_queue, rx_pkts, nb_pkts);
>  }
> +static __rte_always_inline void
> +idpf_tx_backlog_entry(struct idpf_tx_entry *txep,
> +		     struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
> +{
> +	int i;
> +
> +	for (i = 0; i < (int)nb_pkts; ++i)
> +		txep[i].mbuf = tx_pkts[i];
> +}

Can idpf driver switch to using ci_tx_entry (and ci_tx_entry_vec) from the
intel/common/tx.h header? Then we can drop this code and just use
ct_tx_backlog_entry and similar functions.

> +
> +static __rte_always_inline int
> +idpf_singleq_tx_free_bufs_vec(struct idpf_tx_queue *txq)
> +{
> +	struct idpf_tx_entry *txep;
> +	uint32_t n;
> +	uint32_t i;
> +	int nb_free = 0;
> +	struct rte_mbuf *m, *free[txq->rs_thresh];
> +
> +	/* check DD bits on threshold descriptor */
> +	if ((txq->tx_ring[txq->next_dd].qw1 &
> +			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) !=
> +			rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE))
> +		return 0;
> +
> +	n = txq->rs_thresh;
> +
> +	 /* first buffer to free from S/W ring is at index
> +	  * next_dd - (rs_thresh-1)
> +	  */
> +	txep = &txq->sw_ring[txq->next_dd - (n - 1)];
> +	m = rte_pktmbuf_prefree_seg(txep[0].mbuf);
> +	if (likely(m)) {
> +		free[0] = m;
> +		nb_free = 1;
> +		for (i = 1; i < n; i++) {
> +			m = rte_pktmbuf_prefree_seg(txep[i].mbuf);
> +			if (likely(m)) {
> +				if (likely(m->pool == free[0]->pool)) {
> +					free[nb_free++] = m;
> +				} else {
> +					rte_mempool_put_bulk(free[0]->pool,
> +							     (void *)free,
> +							     nb_free);
> +					free[0] = m;
> +					nb_free = 1;
> +				}
> +			}
> +		}
> +		rte_mempool_put_bulk(free[0]->pool, (void **)free, nb_free);
> +	} else {
> +		for (i = 1; i < n; i++) {
> +			m = rte_pktmbuf_prefree_seg(txep[i].mbuf);
> +			if (m)
> +				rte_mempool_put(m->pool, m);
> +		}
> +	}
> +
> +	/* buffers were freed, update counters */
> +	txq->nb_free = (uint16_t)(txq->nb_free + txq->rs_thresh);
> +	txq->next_dd = (uint16_t)(txq->next_dd + txq->rs_thresh);
> +	if (txq->next_dd >= txq->nb_tx_desc)
> +		txq->next_dd = (uint16_t)(txq->rs_thresh - 1);
> +
> +	return txq->rs_thresh;
> +}

Similarly, this looks the same as ci_tx_free_bufs_vec.

> +
> +static inline void
> +idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
> +		  struct rte_mbuf *pkt, uint64_t flags)
> +{
> +	uint64_t high_qw =
> +		(IDPF_TX_DESC_DTYPE_DATA |
> +		 ((uint64_t)flags  << IDPF_TXD_QW1_CMD_S) |
> +		 ((uint64_t)pkt->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S));
> +
> +	__m128i descriptor = _mm_set_epi64x(high_qw,
> +				pkt->buf_iova + pkt->data_off);
> +	_mm_store_si128(RTE_CAST_PTR(__m128i *, txdp), descriptor);
> +}
> +
> +static inline void
> +idpf_singleq_vtx(volatile struct idpf_base_tx_desc *txdp,
> +		 struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags)
> +{
> +	const uint64_t hi_qw_tmpl = (IDPF_TX_DESC_DTYPE_DATA |
> +			((uint64_t)flags  << IDPF_TXD_QW1_CMD_S));
> +
> +	/* if unaligned on 32-bit boundary, do one to align */
> +	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
> +		idpf_singleq_vtx1(txdp, *pkt, flags);
> +		nb_pkts--, txdp++, pkt++;
> +	}
> +
> +	/* do two at a time while possible, in bursts */
> +	for (; nb_pkts > 3; txdp += 4, pkt += 4, nb_pkts -= 4) {
> +		uint64_t hi_qw3 =
> +			hi_qw_tmpl |
> +			((uint64_t)pkt[3]->data_len <<
> +			 IDPF_TXD_QW1_TX_BUF_SZ_S);
> +		uint64_t hi_qw2 =
> +			hi_qw_tmpl |
> +			((uint64_t)pkt[2]->data_len <<
> +			 IDPF_TXD_QW1_TX_BUF_SZ_S);
> +		uint64_t hi_qw1 =
> +			hi_qw_tmpl |
> +			((uint64_t)pkt[1]->data_len <<
> +			 IDPF_TXD_QW1_TX_BUF_SZ_S);
> +		uint64_t hi_qw0 =
> +			hi_qw_tmpl |
> +			((uint64_t)pkt[0]->data_len <<
> +			 IDPF_TXD_QW1_TX_BUF_SZ_S);
> +
> +		__m256i desc2_3 =
> +			_mm256_set_epi64x
> +				(hi_qw3,
> +				 pkt[3]->buf_iova + pkt[3]->data_off,
> +				 hi_qw2,
> +				 pkt[2]->buf_iova + pkt[2]->data_off);
> +		__m256i desc0_1 =
> +			_mm256_set_epi64x
> +				(hi_qw1,
> +				 pkt[1]->buf_iova + pkt[1]->data_off,
> +				 hi_qw0,
> +				 pkt[0]->buf_iova + pkt[0]->data_off);
> +		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp + 2), desc2_3);
> +		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp), desc0_1);
> +	}
> +
> +	/* do any last ones */
> +	while (nb_pkts) {
> +		idpf_singleq_vtx1(txdp, *pkt, flags);
> +		txdp++, pkt++, nb_pkts--;
> +	}
> +}
> +
> +static inline uint16_t
> +idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
> +				       uint16_t nb_pkts)
> +{
> +	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
> +	volatile struct idpf_base_tx_desc *txdp;
> +	struct idpf_tx_entry *txep;
> +	uint16_t n, nb_commit, tx_id;
> +	uint64_t flags = IDPF_TX_DESC_CMD_EOP;
> +	uint64_t rs = IDPF_TX_DESC_CMD_RS | flags;
> +
> +	/* cross rx_thresh boundary is not allowed */
> +	nb_pkts = RTE_MIN(nb_pkts, txq->rs_thresh);
> +
> +	if (txq->nb_free < txq->free_thresh)
> +		idpf_singleq_tx_free_bufs_vec(txq);
> +
> +	nb_commit = nb_pkts = (uint16_t)RTE_MIN(txq->nb_free, nb_pkts);
> +	if (unlikely(nb_pkts == 0))
> +		return 0;
> +
> +	tx_id = txq->tx_tail;
> +	txdp = &txq->tx_ring[tx_id];
> +	txep = &txq->sw_ring[tx_id];
> +
> +	txq->nb_free = (uint16_t)(txq->nb_free - nb_pkts);
> +
> +	n = (uint16_t)(txq->nb_tx_desc - tx_id);
> +	if (nb_commit >= n) {
> +		idpf_tx_backlog_entry(txep, tx_pkts, n);
> +
> +		idpf_singleq_vtx(txdp, tx_pkts, n - 1, flags);
> +		tx_pkts += (n - 1);
> +		txdp += (n - 1);
> +
> +		idpf_singleq_vtx1(txdp, *tx_pkts++, rs);
> +
> +		nb_commit = (uint16_t)(nb_commit - n);
> +
> +		tx_id = 0;
> +		txq->next_rs = (uint16_t)(txq->rs_thresh - 1);
> +
> +		/* avoid reach the end of ring */
> +		txdp = &txq->tx_ring[tx_id];
> +		txep = &txq->sw_ring[tx_id];
> +	}
> +
> +	idpf_tx_backlog_entry(txep, tx_pkts, nb_commit);
> +
> +	idpf_singleq_vtx(txdp, tx_pkts, nb_commit, flags);
> +
> +	tx_id = (uint16_t)(tx_id + nb_commit);
> +	if (tx_id > txq->next_rs) {
> +		txq->tx_ring[txq->next_rs].qw1 |=
> +			rte_cpu_to_le_64(((uint64_t)IDPF_TX_DESC_CMD_RS) <<
> +					 IDPF_TXD_QW1_CMD_S);
> +		txq->next_rs =
> +			(uint16_t)(txq->next_rs + txq->rs_thresh);
> +	}
> +
> +	txq->tx_tail = tx_id;
> +
> +	IDPF_PCI_REG_WRITE(txq->qtx_tail, txq->tx_tail);
> +
> +	return nb_pkts;
> +}
> +
> +uint16_t
> +idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
> +			       uint16_t nb_pkts)
> +{
> +	uint16_t nb_tx = 0;
> +	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
> +
> +	while (nb_pkts) {
> +		uint16_t ret, num;
> +
> +		num = (uint16_t)RTE_MIN(nb_pkts, txq->rs_thresh);
> +		ret = idpf_singleq_xmit_fixed_burst_vec_avx2(tx_queue, &tx_pkts[nb_tx],
> +						    num);
> +		nb_tx += ret;
> +		nb_pkts -= ret;
> +		if (ret < num)
> +			break;
> +	}
> +
> +	return nb_tx;
> +}
> diff --git a/drivers/common/idpf/version.map b/drivers/common/idpf/version.map
> index 22b689f5f5..0557321963 100644
> --- a/drivers/common/idpf/version.map
> +++ b/drivers/common/idpf/version.map
> @@ -10,6 +10,7 @@ INTERNAL {
>  	idpf_dp_singleq_recv_pkts_avx512;
>  	idpf_dp_singleq_recv_scatter_pkts;
>  	idpf_dp_singleq_xmit_pkts;
> +	idpf_dp_singleq_xmit_pkts_avx2;
>  	idpf_dp_singleq_xmit_pkts_avx512;
>  	idpf_dp_splitq_recv_pkts;
>  	idpf_dp_splitq_recv_pkts_avx512;
> diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
> index a8377d3fee..0c3ecd2765 100644
> --- a/drivers/net/intel/idpf/idpf_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_rxtx.c
> @@ -887,6 +887,11 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
>  	if (idpf_tx_vec_dev_check_default(dev) == IDPF_VECTOR_PATH &&
>  	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
>  		vport->tx_vec_allowed = true;
> +
> +		if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 &&
> +		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
> +			vport->tx_use_avx2 = true;
> +
>  		if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512)
>  #ifdef CC_AVX512_SUPPORT
>  		{
> @@ -946,6 +951,14 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
>  				return;
>  			}
>  #endif /* CC_AVX512_SUPPORT */
> +			if (vport->tx_use_avx2) {
> +				PMD_DRV_LOG(NOTICE,
> +					    "Using Single AVX2 Vector Tx (port %d).",
> +					    dev->data->port_id);
> +				dev->tx_pkt_burst = idpf_dp_singleq_xmit_pkts_avx2;
> +				dev->tx_pkt_prepare = idpf_dp_prep_pkts;
> +				return;
> +			}
>  		}
>  		PMD_DRV_LOG(NOTICE,
>  			    "Using Single Scalar Tx (port %d).",
> -- 
> 2.34.1
> 
