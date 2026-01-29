Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC329D6100B
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 11:43:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B69F402C1;
	Thu, 29 Jan 2026 12:43:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 63CB2402BA
 for <dev@dpdk.org>; Thu, 29 Jan 2026 12:43:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769687016; x=1801223016;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jcdyyqCT4fZTCf5G7z8GVZ2jbNuGlsLQgoqxzF7YS8E=;
 b=WgFmNyDOATthWgTQpgoYoE5cm6dDiujlVeG0eBrIkwdpeKO6LuPgVVzf
 sSaYbnqCm2fOc8HTwXRe90Uyws+o2RCBiSXMJjtCtaQyfLYUNau+aU5P/
 nbZNaDt3a2G4QPoLxyHHGQYEoDCHcOnEf7ZOL/MQ8EV7Fif/vCAr8aAvu
 kI3LWsDo8ZmkmzaPFw4lPjmqiujgLYMt0rtigznczY3mR/F9yEUOZEAxI
 cR895d9HSfDC6AM3/fRCKRMRADv7bOi9POI0qZGJUuCurIBsok61x7Tvd
 DMWoCPxgcM9Al4L94ySejrnjsH0qUwQef2zQAd0J9+ayKIYmT3MkBwxuE Q==;
X-CSE-ConnectionGUID: 0hbhGaNQTFmxAgXYAVI6Rg==
X-CSE-MsgGUID: Q82MSHc0ShqUGjJGlerPGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70976253"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; d="scan'208";a="70976253"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2026 03:43:35 -0800
X-CSE-ConnectionGUID: VZMdOf91SGiZZwNC3dXdCw==
X-CSE-MsgGUID: PzQCFo4kRgOD+Bi9q0s4iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; d="scan'208";a="239811367"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2026 03:43:34 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 03:43:33 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 03:43:33 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 03:43:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Deg8ZZVti0egfSA12OSaM6RXN8wNkspgAKja/duFrVARYcMLJnm0lugotfXSiG/TOgVBsQZA2JrHNvuf+AYW/bum8ku/dXiPh/B/Bi9iz/B+cCcIdS6aGQokb0KYz4pLGtrJ7d/ILM7lt1rASIja+r9EsIIoDl/+QwfPQKUbnjqhXdFf8g+LeFXeIVNSqZcn5hRiwMtOZhbPCVfI8OXRnXGa8xQRxIGvyPh5gXuvp1cItE4jtZpM25zVr4/l8nutSK0tOcxGPfBkUNNjz5TfvWfafp/Rbr8hx9CBqv2el/Te+gkKSBmt4rM7z1fdpbCNBjFYQKoaCmKIa6iXfK+8yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2M4RVNeXgei2S49lvB/K1v39In0qwc/4OOgFkXL9Tnw=;
 b=tGYy6L0CH7VmBiGwEUZxdBrgEnSHOzY8+kSa93Ql2K2sKiq/4Sh0sLINoOKBrTPKKMzmPZ83oiSTO6azn3k3ynxzXPVMfdH8gI+ZNTCPPRk6cA6u5ff5yIvpQ9Y436m9BGxtLXMSoVZEEa22JwTcxbaw39tgHfbR9UjAk6zDdPaI64BXzUMFUBodrodwB3+qREbIraqYdGDTt5iSHVEBAiqq6nEQHZK19vrAqK0mM0+NWDm8/RLM+NtboiFsN78AwmJU+Eg1+jWU0jEaN9ePGx9PTDD+sgYgagnnZnjVSAcRn9RsiUN54fU5haUUm765f9upym03rfIVHZ/aFL5czQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7446.namprd11.prod.outlook.com (2603:10b6:510:26d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 11:43:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9564.008; Thu, 29 Jan 2026
 11:43:24 +0000
Date: Thu, 29 Jan 2026 11:43:20 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Lukas Sismis <sismis@dyna-nic.com>
CC: <dev@dpdk.org>, <stephen@networkplumber.org>
Subject: Re: [PATCH v8 1/6] cmdline: include stddef.h for MSVC compatibility
Message-ID: <aXtH2KV9p3PyQazu@bricha3-mobl1.ger.corp.intel.com>
References: <20260129114202.61185-1-sismis@dyna-nic.com>
 <20260129114202.61185-2-sismis@dyna-nic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260129114202.61185-2-sismis@dyna-nic.com>
X-ClientProxiedBy: DUZPR01CA0320.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e6cf44e-ca3b-45f5-27ca-08de5f2b9c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aXKfVi/szTfmcx2fApYywRZLL1lB3doa8pfxhZWacb9G5tXgcWdi3G10iBa+?=
 =?us-ascii?Q?FsH/C7stolilXK+AkTZ059BZkh3cfXi5uTaKOO0FamywMH7X83HmbFoMC5Nk?=
 =?us-ascii?Q?VsJFZ8XM8mxgzFmh1s9hMQu0f3W9DJkgexCbjDea3xxQZVmgP5UHcMqBuODy?=
 =?us-ascii?Q?o8DlLTwNkk1wZW9nBZUUWhZC7qcTwQXGWQ3PgXQ8EaydfzwI921JK3ZIKYU6?=
 =?us-ascii?Q?LFslLeCYXHESQYtQZI6tyMjgJC+bj64c2pcVGXKwhkerwMBh67kOMVABnKDB?=
 =?us-ascii?Q?gf54jU/CTIv/F2qT3I3UGeBgqbgxlyzPtS5qHQs2zWXrpRE4osBonQjtbm2I?=
 =?us-ascii?Q?9NcJUbajKfm5Bz+Pip3F/A5mObVcv8ppJUmypBdMSDh2Rsj4eiGYkiYHuGCr?=
 =?us-ascii?Q?JB6iT3y3tUwdl+PdSNGGjO7JPQrtchoimqbYQC3ehQF0b8oqbr9ZfVKKBkpe?=
 =?us-ascii?Q?BNHM8JnCpGTG9v7ERKlU+dRV9yOtxZ7aqZksZd4Q8KECDw0QB2sJ0yJ5kOah?=
 =?us-ascii?Q?M4nPzT2KQC+Ylbx4G0XkTzddtaLDUyGBzsmzth7AS9GJyGs33+/eLzrTJSp+?=
 =?us-ascii?Q?kScTZLmMgGhXgA+8X0+AUB9EIKiOCXzOOz6lZGfSnQiq95pWvPGiDwDD+GMQ?=
 =?us-ascii?Q?OCkqHZ6KiUc1CIAV7KjqSdsbuxSCTjf9MG09Tfc9x0iYWfN7CmPttV9Vg/w2?=
 =?us-ascii?Q?dQfouEOVIwdnxp3Wyup9laVgpQUNChokQ4KKwoOxb3k2e3ZruHvMTwX7Prin?=
 =?us-ascii?Q?OabQkbQw29N/JE3NiIdWZ9E+gtg2ZZJVVhGNhyyt/kypR0G82TbQMDHWXb0E?=
 =?us-ascii?Q?gyneqpTl5LdF5uazIZhwmYiJ7X2nojaVIAu7SeDCGGMvQs2RCYIHhyHtPADA?=
 =?us-ascii?Q?jKnsW0C605svRyp/8SC7zRdSPjnoc+2zjqMsBBdcMOQ8MSQitvfHBtl9VIfi?=
 =?us-ascii?Q?6xTuCIrgfHynYl72iTtS/xBOQhq6bRWyecaImH6jsIyw/+WI0MpJJXF6vZaw?=
 =?us-ascii?Q?gFaXRRL6T1MGyIbOdbQmZPjp4KE3tXwpmZFWj7SVkEMfleh5coyw9JQo/00m?=
 =?us-ascii?Q?Ya/TScITKEct1ezN85w1PoX1ZeRGXSL5jwGgAkthxCA6qNU/cLipuiJTk53X?=
 =?us-ascii?Q?oM1ZX3u3QdQF9Lnu7XEMvSmxSwrLsJpRdBolIImcQuopuN6YDBefxk6Z0idW?=
 =?us-ascii?Q?qWXUiXhOEPOyfZaHQxuahA5eITVks23MxjzjYSDaXZtnd/1Im1TY9tek/hKM?=
 =?us-ascii?Q?4OS7nSlvVVFhEe5qaOBrmCTETpNJ5Ek/P3iyN03yA5jhSqrM5uuZ3AT1iBi8?=
 =?us-ascii?Q?8L9Hu/03+HRWNqsovRNsmgW+Lb7kMY0ZdEW1QzX1S9sKGu/cTV2AIkyY0yXq?=
 =?us-ascii?Q?BeaZyv0znvx22e3bRko96DD+a0Gj/r7zhSPUXP4oPgMZSaOifhUEilfESC+J?=
 =?us-ascii?Q?fn0F1R9hUCZLXjUnOs8FOoNKpKtISETaPTKYyxinjGnQSxN78Q3vaG68IgzX?=
 =?us-ascii?Q?ISamvyt53GNh5qLfUgL874nndEPyilPiziaRaogxahpyAsfyMjcF+ycaHFMe?=
 =?us-ascii?Q?gdZzD6iTwP8ErVQTAkc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?al6tnJie9wnwLPdlEBYFFbl9E/U/F3xeIsdnAR4JTQL96Ui4yx7RPdaVe6+u?=
 =?us-ascii?Q?ND7ibzm0QLzC6mefwqMv+iAhICBROvR2NDpAAgGwRXEhjSLhShcW8FWCcS8Z?=
 =?us-ascii?Q?H17uDONgZj1b4BNXRztZvojRqPgbCo3fUDBgXfkl4kXFe3WAnaLuKTMU7kiV?=
 =?us-ascii?Q?N0UqiKPRBSpg/BZD6sUJ3XnLu0X42JQ9vsR88lnnzFKp0lO+BtGmYl3CRiEy?=
 =?us-ascii?Q?Ir+9HTJUQeqD/MHzWoxfYJ1UHk2rf4ReVKkazeT8/aBLP0/GbQP/DI8qJYwu?=
 =?us-ascii?Q?VsbQcXHMMdILtCZ8KGIrvh0UuaS5Xl+flGbNn7A1kbCB2lov993F+xFZwGR+?=
 =?us-ascii?Q?LpsZJ6F7JFCSyzjidRYqlKeNO7S+giSL3BmpbxgODNt0JoXT9puxVDt0YK/Y?=
 =?us-ascii?Q?5dujDvDPK7XDltsv9gWPq4W7M3Su0oOycEbmr6MBxXfMArPCYpmgV1SPUTwR?=
 =?us-ascii?Q?5PmlYwRBWqhleAzbOhHrQkdEdWzTqJQdvnVKdiLBEDBUdNgitfBjwPCNV/EP?=
 =?us-ascii?Q?luSg7liNRgZlwDPdhHwgxVMEGdHEEFTyTD7N6uAZ/lJQbnf1jZ0lKQ8wCMWi?=
 =?us-ascii?Q?UbiXz+N6r8LyMahiwHcTR0uYVpdwBhoeqCF2II0IsGkMS08q9EKf41Yq5bc0?=
 =?us-ascii?Q?JqziwilnVluOIviI4VdxJf2PMThGbLtmjB/s9UWU3lMcr0wo222TpkpP0nKX?=
 =?us-ascii?Q?+//zn8v2xKmKQhcRyFKwbejTePauxIcAMsoABlhdILdpUn/1nv91S60ruwcS?=
 =?us-ascii?Q?QyoyGgTycyHuQpBJxjEM0JCT6l3kpqmAXWrujchK9hYkvljbJrf/uUEHaebn?=
 =?us-ascii?Q?Ctc8bp6G1sKWu7fZUK7aVNcE4i05JDJlv8EYmAy0nkueRA5j8sSRS668S7lF?=
 =?us-ascii?Q?cYefflaEtHJAHG9g2Glh0cpWaArWVi2+Anp/864aFoQpzL/z0V0nhkvb3ykY?=
 =?us-ascii?Q?hhQXePFELHjU7C1noxjXUI34yveed6Hj1XlhNrxbnC93Ge9jFEgUS/X5L32C?=
 =?us-ascii?Q?jF2+mg/wyaM7q7jn7JecTolHDz+T7yR2hTFgMpUp3Fmn939BKQNoxLanseHu?=
 =?us-ascii?Q?c9S5TGE3zNOOOti0Kq/KhjH+8NWRGOxNzMoVj8GGBFhQUm1zfznhRF2w5sxr?=
 =?us-ascii?Q?XehRPMqXFkdVkjC9HpkYfdvOfexuO/yh8Q5DqeqB9nYVnSmppHY5OTiFWwJw?=
 =?us-ascii?Q?J9je6sBwO8m/3tw5IngwsaBf3D+sSSZQMKQEUX3Oli7ddUChVWiJxVnKTlz/?=
 =?us-ascii?Q?eAkWNyM3ro8TW5iG00vH6FgdL5N5+7Y9KXFIljcpOh34S6svil8F0WinqQgv?=
 =?us-ascii?Q?dC4l4uvnPFmLIxk+TcQPnLLco4TtO3gsPWGkYWQ6ZfwWPGlH0ICE49GD0VXm?=
 =?us-ascii?Q?+gpgViqTcgBs+HnRgsonwO9TZmDdQtpK4FG5aupmQIAvFBIwaiSfWhVovdBm?=
 =?us-ascii?Q?ASqZ0fisBU9Qhb3iqMyNLwm+rXDHAq8SoripP2xc/qPFRBQOQjz9wuW/HNwK?=
 =?us-ascii?Q?I1XYd/6j0+iNk7htjD3BqjryMT/2lyXaezl6ns7qfKv4y1TNyY8EupuNI0h1?=
 =?us-ascii?Q?eau6Dap06jAeNS+kS7BA6/5Z/tX5YWzeT9r7HHx1d7Wa2OxW6xTyS25bYNEX?=
 =?us-ascii?Q?8N4WiP7DQSFycgUEaEXL4yjRK9Tui6+NLQawue0K9+Ep96FqtmziofrGVG+Z?=
 =?us-ascii?Q?uBadO+p+o5isKZYqmrA03AR8gM197deRifndwFvGtggEb43C1wT3Sy607ASP?=
 =?us-ascii?Q?rfSUTe8RIuhxtRpd6QiBdDHZqjLdWxs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6cf44e-ca3b-45f5-27ca-08de5f2b9c92
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 11:43:24.8926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZjm0y5Uv4dBOcStNAFKMU2LNnSBY+wziYpmRcPlcJTorxWXiPMxw9Ow2Ia3cej9w0fv5wwSgGZplpXIwnO9pMcQEKkni8UnkvgeIPd1I5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7446
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

On Thu, Jan 29, 2026 at 12:41:57PM +0100, Lukas Sismis wrote:
> Include <stddef.h> at the top of cmdline_parse.h before the
> fallback offsetof macro definition. This improves MSVC build
> compatibility by ensuring the standard offsetof is available
> before the fallback definition, avoiding macro redefinition
> warnings when building with /WX (warnings as errors).
> 
> The standard header provides offsetof on all platforms, and
> including it first ensures the fallback is only used when truly
> needed.
> 
> Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
> ---
>  lib/cmdline/cmdline_parse.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/cmdline/cmdline_parse.h b/lib/cmdline/cmdline_parse.h
> index d9a7d86256..c4131e4af5 100644
> --- a/lib/cmdline/cmdline_parse.h
> +++ b/lib/cmdline/cmdline_parse.h
> @@ -7,6 +7,8 @@
>  #ifndef _CMDLINE_PARSE_H_
>  #define _CMDLINE_PARSE_H_
>  
> +#include <stddef.h>
> +
>  #ifdef __cplusplus
>  extern "C" {
>  #endif
> -- 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
