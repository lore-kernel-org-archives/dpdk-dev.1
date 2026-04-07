Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48AFEDB7DC
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 09:22:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 900FF40265;
	Tue,  7 Apr 2026 11:22:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 7BE8340150
 for <dev@dpdk.org>; Tue,  7 Apr 2026 11:22:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775553746; x=1807089746;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bWxDijbAiHBz2/nYwcH0ywX6EJ8TjKmXLum1dodSO2U=;
 b=EZ+5+dJ9//65cwH8SBB2yrzWUUCnfKlzSDRbDypAQsPKkXcjmLCdhMJI
 53HaVGssPhNTAxGmw+lxDjEWdByhQQ+sR6//JPcmZoU33CezCJHZERpKe
 TNfnEDVeGqpWwld73F9tbidrW03QnTV787o4lXrpPowcMqeg84PdRQpZl
 tdYWBiw9RkFVb+eoN/EzwJEDFLhIPyq7oRTqUX5Vt8TTZDRvgkU8XF63z
 x52LYI5UZjb9Dg19HuACdVVNL6j7Gqt31QFhvTnRxBpZW9w3ACQAnq5V4
 BatYiRZw+A/v0Jc/rprfmJfaj6H03+LJrJ2m86zXiEDSpkz0tdMn6oOSi Q==;
X-CSE-ConnectionGUID: gSwwxxmdREWIePjPklZcuQ==
X-CSE-MsgGUID: I2RZ+QmyTPicfyiRFHnxfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="80105949"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; d="scan'208";a="80105949"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 02:22:25 -0700
X-CSE-ConnectionGUID: MmMcuLZxT0yFd04e0+ji6w==
X-CSE-MsgGUID: kWQVoDdUTjm2/JWBATWzbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; d="scan'208";a="228391263"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 02:22:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 02:22:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 02:22:24 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 02:22:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dn/tbOocvWC5IwhgY8/GU7AVSK6fKQDYOG6MKTdAaG6bWQ6uHhok4tu9J2eElWZxa6WSJPFRQIh+ByRF0ZI++yhlxWttUML40qAPcdYjfpm1fOCSK0qb1Q/g98uGlXvwxSD562OoEy/Ml40rggQe1xg7NyTHPCSJtDy3IEnOZuqnXLeA7igUzIdHoA6FdkqmZt51RXZAT6V4pnA0RJv+p9VUKb6wa7uyLQ60cM1wERBmCStP5yxdttmnRpqAM3T6w3WlyhwJuA4QJM4Bc6HKsCcULB4VmWRl8ai5gWHNeY3xWwXXKXqgEUzMgi5ny6iZM1li7WzG5ngjOoeELUqdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUjoRUWJUemlUK2G/VfCFq1Kfh6zhvHpCP1TR8zudk4=;
 b=e45QONIaqm1HEcVoHQ7ou5VclqSOq6zywSveY5kEltJLt7ZgN4JtnfW74Eoa9+qmjmUDzyNARnvskOkLRLQJehhfPlVIAn+6jVFe/mEauVpPuyNpdOBNOf0RevyiESEyp+zsITrWPf7Apebm/dCCLvSLtgp1hXHxTs7k2Vof9OF05UMb+5g9CUjKrlCRw+G9P9VE2G5TXNWH2Pxwc9Be4tM5ht4B2MpDhzj4qGPCjrbmuOwyMWOfHUg8lwpWhLqFgKDY8+wdI/IbLU10BptSYLu2sShYZEhEtVKFZTvtIiR3kimXUeIPaxSyvHFPJAWzXuLTbEh4hLW8F7415pRPXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF307806035.namprd11.prod.outlook.com (2603:10b6:518:1::d13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Tue, 7 Apr
 2026 09:22:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 09:22:21 +0000
Date: Tue, 7 Apr 2026 10:22:16 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 00/23] examples: enable -Wshadow across all examples
Message-ID: <adTMyFa8893zgMHL@bricha3-mobl1.ger.corp.intel.com>
References: <20260407035209.650419-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260407035209.650419-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0082.eurprd04.prod.outlook.com
 (2603:10a6:10:232::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF307806035:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b900f3c-5f47-46b5-9601-08de94872be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: AuoHpyS53hdCpUYodhhNrwalKWl7furbkeRdDGajPB/DrjTIOrdqPON9ghvDBPBPrWAWI0+BvON/pSzRWyIzkGRtIoNAHsr7yzAzujXcEc2Ct96HWncyqGWdBw0uJjXMb1QaImEJu2l4aTYb0R+6AcbW1aJ8NYprVMS12k2w3CuOLh/9Gd8UECK+wEYasNL7I4hDN4B4jkfrnQh4uzLD/J8GDyquJeDVuk9qhDglIvekZi8aFGlV4qq+JW3ucjyWT75/fkgbx7V5ChEZ8Mbk16YdXbSoctI/RgMMDuWJ5yaxsdt0/lO7mkbfjZB9gAJpubKlI41w2OMY+f1TPKeYSdYQhP4IWHQhNAa/9lAEfUFUVxMO/+Tb8T9f+LpT7CWBMVFJr9t5+3Kp5/7LJfviiNN0x8mfKTm7aVZ/6Zsk8fD0NC79XLxrhrCQnUx72GgFxZj0Vn447kDFOT+XJxbWQbvKcIMclaCH3m+uZtFkEgcg5/yLZK9MxrloaTrhzKO9w46PCe4WPszta1oUvG/oBgvKavCqe89V4OiEPKWOmyPsRB1bsqTVz9V2pbYMoGWekGI/JgI2PpitNvH2HZvDZjg8MDyWxbC5ho2hscA2PmzW6/lZdpjlvgkDR5yEqP1q82kxPeQ/gvKXKcbJ7TyfgJU5gT8xdXgQRo1Jfk6v2i7+OdXQ4SoDkjn1jqm/IkR4HfhUXhlb2lmaU/Ki14Y9Xa/0BAgkV3Iphw8Hbtc7bFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/oBrakEbhE+yaqXaHw1VmFib0EQDSjLtUhhHGDwWRJq2pBh0/hVgz+KDxOTG?=
 =?us-ascii?Q?mWgIibAcOywwnCgws4Tuma8JuLKva1juVL7zxB9fjINHVklXXMEGxEV+smUg?=
 =?us-ascii?Q?iH/qWKCFIiedbTTz4sazrP9rADMewEAQRHbau9w/VXUEZg309x9NST8xkNlm?=
 =?us-ascii?Q?eVykb6RKEiEByxv3H3mhyMZ3H99sNSR6egTp/6D3l0CBClPNVthe0IUwEVgZ?=
 =?us-ascii?Q?D0i06cybhwtxxSBJpqI5PbK5xfUTcI1nkjsX0M/5KToZCTaeNqOwzvX1uz7V?=
 =?us-ascii?Q?MplAm98pqiMiS4HCWvjrveo3tKBDT8hDafVhOiBrtOVKz4ZduswceoJ7oVHT?=
 =?us-ascii?Q?8IqAR2HdPBx+N7q7v/72MOA+tjdAy9ELZ8ApY4k54bUPibHPSihYgoC25jgA?=
 =?us-ascii?Q?p9WWpiT/ePtEz8mBu7BiRY9VJyfog4fiASvGE6hR+XWlv1aUpGcGwJbkBo3L?=
 =?us-ascii?Q?g6v9fx5TU5oxaBrvn/K1OS5ABVdRhwNpzabkr4SVrA107itHeM41/azeFPU3?=
 =?us-ascii?Q?CS4a8Un8aa1Uh1OgMCIp7eTCeRGqT6s3SITxn5Max8czKqJvLKa+WmeCpbDa?=
 =?us-ascii?Q?480t2QpCOrDdF57s1SOhrlumALh0MxTOeSP0v0rM85wP4tIsoNT5YS/bKhc4?=
 =?us-ascii?Q?h0gC+TxU5mCQ+VrWFuRZAxSFOMhyq6wmx36Vur2JspjPJL+s1MKIdAthnEIM?=
 =?us-ascii?Q?MhZpvy5mKfFwoD01E8n3uDek38lVO6pgDY4NYLm5X3DD0zLvR0Wsx5bBaJtd?=
 =?us-ascii?Q?kHAKsCjEiD4E5wH3Olz3PODOs0twK5S600UGx+YwzITMD50fRrt5vd7Uv8rL?=
 =?us-ascii?Q?Xw5m1iG10T8Ihx1Dy175PYNPrnjprDFpmonGHP3LbymHv8lUzap6xS4bSVPU?=
 =?us-ascii?Q?rTkb3SAzGJG4eRmm6gxuZZw+ag40r7FDuoDsI02xKtP3OnvnBhGJLbtn8JMq?=
 =?us-ascii?Q?5+nTer2e69M3/mYqvdLXibhHzDmyw9+cyLaHwcbyCRDfIDlMUGrtfZgSD5w6?=
 =?us-ascii?Q?HrNbvhgf4WTwp+teE3RGqucnZ9eTgV76bmJW9YyO3jmv2FIinkd7jgShb7YI?=
 =?us-ascii?Q?BcBtYJG9Ojrjdqf6o8hKX0NkXpCvAkntrOb4W4miAid/spY8NhAwdKeTcaKs?=
 =?us-ascii?Q?C0TtnbouUCbNB2YidYSYCj76yWTErTPgZuAb15BD3dwciT2Q6h4Nzf62lxwu?=
 =?us-ascii?Q?Wwpf62I07TlP7griiBNlgoajUgV40MagPt637pvn4b4S2T0oy1O/RXS2jayF?=
 =?us-ascii?Q?h+sbJPko2akJZDNGCuyGj2buvvFn3UeOExPC2x/pInkP8gD3t6lOwRDh0Nit?=
 =?us-ascii?Q?4lFGGVn9d+uicenw7RvUPexEsZbyGE2f713RT4wKO2wOHt7qy7c8FCbkIeiU?=
 =?us-ascii?Q?kZfV8IiLUluIc8j83wfamQUlMtdshpU+Hp/9Cl4kvIIg9JHgsG/XF6sBZleV?=
 =?us-ascii?Q?0+tpyq04xDHtkPPU57XIEPgxWfzOBetmy6GgfyoFDpb//U5mK3TgLnc6srKD?=
 =?us-ascii?Q?Ix8sHyJxtpMRFNTWNXHtEmLKLCVcBDSiYiWGsfHmP7x3oZXya80D+tlGb2a7?=
 =?us-ascii?Q?HygUpe+ZdMFB3YDgV1xQC8+by6iJqogvVnmubVVa9cq6AcINc9Iq8QDpEUhA?=
 =?us-ascii?Q?poAR2OMP2LvF8OUHWFW9rDKPFw70Zo6ovDA/7/R7sbsqw/OqOZ2l88J7s61f?=
 =?us-ascii?Q?zrGxVyRY4l/jg/4u2Q0TOn1xOnKTnimnklDGxcQvNSrtOT+RDthH6We01de6?=
 =?us-ascii?Q?mfctnNWQxQDxrxaAUhvtwzYjuZ0f8ow=3D?=
X-Exchange-RoutingPolicyChecked: F7WajBPW+rgHsOY+0BxhEgQ2TU+g/OZ9/G3HioyQg3n3lugo9rbrxqeZPaeD4qjDlP2VHbTMLKzGjplFjFmNteP4RYX/NV5hgAcPXCMBmzkdlfpvWZGhxUyQF9W/b8LPyY0paXfXrCtSlbQLFhRb8PaQzWCF4XsZjVeYoXwFzSAihEK0ZAdmy/gelIo4k0tua/8JDEtJKK+lTaZMhA97XEpvFiUleEgdWvfQeijoeDEVKf4bTGG0MK6FNU7aHsa0UngEShDjLN3nwMw8adMqIoyfRUVEJ8xggoGY4+/xGGAzOui7OwR00OBstAVA5HvICCt7zZbNYcLzUv1GHV8+2g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b900f3c-5f47-46b5-9601-08de94872be1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 09:22:21.3440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMRZd5/KUePf+L8/TlFejl0X/5eAoHm+xqrnRNnq53h0bAdC7j4b5U4Np2NOkJWW1vKA/nB1rPBUNK3h3G0f7oDydARIHlGTX1l1EIwQG+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF307806035
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

On Mon, Apr 06, 2026 at 08:49:26PM -0700, Stephen Hemminger wrote:
> Several DPDK examples had -Wshadow disabled via no_shadow_cflag in
> their meson.build files. This series fixes all shadow variable
> warnings and removes the suppression flag, so that -Wshadow is
> enabled uniformly across every example.
> 
> The fixes fall into three categories:
>  - Renaming function parameters or local variables that shadow
>    globals (most patches)
>  - Removing unused function parameters that duplicated globals
>    (dma, bond, flow_filtering, ipsec-secgw, vhost, qos_sched)
>  - Simply removing no_shadow_cflag where there were no warnings
>    (vm_power_manage, bbdev_app, l2fwd-crypto, l2fwd-event,
>    l3fwd-graph)
> 
> All the patches are listed as fixes they are not worth
> back porting so no Fixes: tag is given.
> 
> Stephen Hemminger (23):
>   examples/ethtool: fix shadow variable warning
>   examples/eventdev_pipeline: fix shadow variable warning
>   examples/dma: fix shadow variable warnings
>   examples/packet_ordering: fix shadow variable warning
>   examples/bond: fix shadow variable warnings
>   examples/vmdq: fix shadow variable warning
>   examples/server_node_efd: fix shadowed variable
>   examples/flow_filtering: fix shadowed variables
>   examples/ipsec-secgw: fix shadowed variables
>   examples/ip_pipeline: fix shadow variable
>   examples/multi_process: fix shadowed variable
>   examples/vm_power_manage: enable shadow warnings
>   examples/bbdev_app: enable shadow warnings
>   examples/ptpclient: fix shadow variable warnings
>   examples/vhost: fix shadow warnings
>   examples/qos_sched: eliminate shadowed variables
>   examples/l2fwd-jobstats: fix shadowed variable
>   examples/l2fwd-crypto: remove no shadow flag
>   examples/l2fwd-event: remove no shadow flag
>   examples/l2fwd-keepalive: fix shadow variable warning
>   examples/l3fwd-graph: remove no shadow flag
>   examples/l3fwd: fix shadow variable warnings
>   examples/l3fwd-power: fix shadow variable warnings
> 

Thanks for the cleanup, Stephen.

Series-Acked-by: Bruce Richardson <bruce.richardson@intel.com>

