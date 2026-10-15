Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CB8CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 08:54:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2D564025A;
	Thu, 15 Oct 2026 10:54:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id AD59B40041;
 Thu, 15 Oct 2026 10:54:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792054466; x=1823590466;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UzDyzb2DnEln+TWIoKX3MEfGBDf5nmUhEB6DKMwDZsc=;
 b=Nrs8n9M3XEoCzjPG2JRe6CedrQsGbmo65XhCT0gq8X7J+uS0g/l5+Lv4
 +YamQT8i4+mMVjoY8v7z9APkmknrxJDI6J9Y+Hd/Z8NscaZa3DF4T6qYj
 tB1BVbNWMDEbkUZ4/bCb7CMWRkA4pqBL0IUV2TWv0UOrjld/LjzErNnBF
 oty2TgB1CSvFer+KDLmoRG6+VdDL7MxkJlbn0MT6+tgOIpklQdte3+H8l
 hsHh+lpIQDUSPqLaAKoGFeaHuiyBsDV/+xPgF98t2uzbGC1YfDLdmAZIt
 za3L5x1Yk91fqUYd7IlrPMzSZBwyeCQGPDGsiHfL29BIUv4YSuaEkF1pk w==;
X-CSE-ConnectionGUID: GxDTZh4IR9akCGSjFhm7lg==
X-CSE-MsgGUID: Klvcn6zTQf29br14hRB9ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="922260"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="922260"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 01:54:25 -0700
X-CSE-ConnectionGUID: KK9+4eqGS1qiJXo5DuYphQ==
X-CSE-MsgGUID: GscM4oAyQxCW3DI8BordBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2003760"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 01:54:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 01:54:24 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 01:54:24 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 01:54:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7G0gMeL2y4oN7vGx9Lc/ed+rfDW+6pLs6Av97mCbD+ehQFhTgiw7ftr8nOT4Yj93hzhkpFA4zdTjjac+o+Gc6s3vamFvKGeM6rsbSaYbMWC4WHrUPBXOCWLicrs77zp3fQzjH7nxZP/gnXR8p61s1BPbcVRXN9WNkgpqfHYSHOum0FXW2fYTjb+44DImidf89D4r+lIv1aolyJiz70HKs/zeWEgzs3x7T+IYgd2nYcdKo1y9StObFBIOjyETcGXe9G0/yCljJKXfKOx8XdaApZC7iq96VbDa8Wn1/L+eN61RbLI4bYecdZ0yy3mzPIclk0gvlVlOpNelBDl+Or87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sn6OhuEX0U23E8C6HGcOfEixWbfAW+1i8dWBNJUvRU=;
 b=b+asgxAUEDuJdbrRzUdFXq1dgUf/NzC64f4PInQZLxr6PqwV1k7WiL9Ck0+S0NM1vIblzOXCHC7r8aJmgExQZV7qYbVXTtH68z9Z2ZKh7ZxRydcfXNIkr9NLeDkaQ3HJ5IOTDDSWWbzaq4m4VhVCGkv/ldlGqvfKHTxYI/m95OlTNGzz2UfH78I8GguouQlWj7R/3kr3DASVTnXENdrOKLx+JarPCl4I6vHN4jc5RlybnSmFdLd2uwESSU/ZXp4UrJbvpVof0fKrvrSEGYWaCtfLVsDZ2d/J201vF4rm6E3fubdWKuW5Ip4dKJGpCrCcz+khn7VTHnYsdTRZ+1vK6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA1PR11MB6073.namprd11.prod.outlook.com (2603:10b6:208:3d7::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.21; Thu, 15 Oct 2026 08:54:21 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 08:54:21 +0000
Message-ID: <79bf9b9d-9113-4049-a321-7d8a7b57dac5@intel.com>
Date: Thu, 15 Oct 2026 10:54:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eal: enforce internal API check with Clang
To: Thomas Monjalon <thomas@monjalon.net>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>
References: <20261014201627.571496-1-thomas@monjalon.net>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20261014201627.571496-1-thomas@monjalon.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:e5::9) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA1PR11MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9534fc-d129-4e37-20df-08df2a99e75c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 9hRD9WzaJORV0Jy8oDGLuCRhjQdTc5UBajdC4309mrPOZvtwAfLtXlnejK1w806Y0M802Jtt8j/8BPFG6Q+9LbMYuSUgoyv/QQ1mJuQfUigYcZDeDroDf2vyoUHLKvaxXakscu100cHw8cA4c69FnZS9rJs4fgd9U8GvVGResBHWvp09MKetYBOh6YRTyC/9Uz0O6Gq0tigrusS+lqDuKOd297LMxZ1fA62TB1u9o2AbmwveOItT6zakGP5t8bm5g+S+khyPkaRLiVN26rTdkw14OgW7Y1CAu7IoK8AuTF7odXTEHv6l9WfAxid2y5n5RCxeMfxPqZGcO3Sx+LcB5u95zcPuzRanjycXO+i/qWS+DRqUrpRkdbPLxqH1tyFYlL1PMwlczg0h04iSmYwLASzbFmQE4/WEoadLQwHLBWSup+zjIAKaiX3FjfVTDBKeOYv1+zjNyol9xj4bEaD9JeXncb5deTQVQZoS26ZPLApT9Dave3qWaq2JZX176Cq43c7EWQLv1jdudmvYwlocPgyPsJJnFTBnRZ/SS5hQTRG+0345lRgU5ah6uGDZpSFzoXzkkTdap1H4NwLq2LMvvpRBt01o4LUnAV7XcHEcSJlUe0XvPFPq6JolbQNbTC/KP8Mkblrh7R7P3obUnCaIGSG6liG6qtDRzirw0lawsE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkhHd0ZiaGlsNDNNUlFxeStEVFU2c2Y1VzkzUVNLQ0pXSGVoNkpQOW44U1F3?=
 =?utf-8?B?dG90TENEZkMyZ3RnajMxWCtyYUtEcTdVcmoyQVo2ZEkzR2ZWalVvdUcvMEZa?=
 =?utf-8?B?QmhLbzFBTmlMWENJZWpaQWtrQTAzRjFrRUxaaC84STVRMjc5VkxFODI1WGpR?=
 =?utf-8?B?VTA0eXROZTB5K01PSkFzR1hBRHZKc21tSGUreUxxaXZmNjJ5WTBmQmZnTmZG?=
 =?utf-8?B?SVFSTzZ3ejQ2bEw1TlBTUXVCWlRQNlZSUjdqNVErVDRRcndEZUVCbkhKeFZm?=
 =?utf-8?B?S29TellkbXA4QVlKektaYkJLSStxdTNkY2hSYmt6dHdaU2NPT09xbm9tVCt0?=
 =?utf-8?B?ZEdEeEVvdEhvdU9LVTFjQ0UydHNqUVg4NG9XbElmSHR6QmE3bzFBRmwyZ3Z5?=
 =?utf-8?B?UUhYSmp2RHdxMzdIbXlYSWFCTm1rUWNpalhPZWpGMmd1TWcrMm5NR0xtYzVC?=
 =?utf-8?B?Q1hEM1hCTG5EWkIxM21nMCtGY2ZhSW4xYmw2TFhWV2NOYmpyeHMrR0FjZ1Ra?=
 =?utf-8?B?TG1TeVkwL01IWCtsdC9pWmk0QkcvTXExa3FVRi95SjV6SnViMXlxb0pwY0hQ?=
 =?utf-8?B?QnExWEphVzg1ekZvVHN6cU54L0tscWFKUVMwVElLeDBjYUM4TjNaemlZbkky?=
 =?utf-8?B?aXkyYkwyY3dnT1l4NVlwYmxEUmozblVtaE5ZRmxxd1ZUR1ZIMm5NNzBVMjFW?=
 =?utf-8?B?NW5xOHJOQkxGZDhvYUtnaDM5QWpZalNud053WllQMjBNTERTVDg4ZWc1Y0d6?=
 =?utf-8?B?TnF2ZXR2YVo5emhiZVJvM0pSeElaMjFRV3pNWVU0bEx0TnRVSFNkSmlJWmNt?=
 =?utf-8?B?OHM1Q1E4em1OZ0xGcWczeDVJLzIwYURLQWpHbWE5SlIzbDdkUHp3UlBrYzlt?=
 =?utf-8?B?TVZkUXlydVdMK25XTFA2dm1ZeTFnNFFtY3dNcndCT2JYOHM5UTJqcnhONTNY?=
 =?utf-8?B?SVgrWkwzdzNUNVNaa3lFUHY3T3lWclFhSTFDeDN2L1U1bVFDK05LYnoraXpL?=
 =?utf-8?B?am1HSnlqTlpPV3ptR05EaG1HelhzS3Q4dHFYQWVHZXN0eXJpcnhBYTdoKzNN?=
 =?utf-8?B?L2I4SWJKY0ozRUNta0hSRmt6WXBRSUM5TjU5QkNHZzEvSEg3YXNwN1R5OFFQ?=
 =?utf-8?B?dmhzQ1NRbUEvMis0OEZCSEk1WWQvdDVaa01ITmJaQzIxaUtFRE1YNkxLSTNh?=
 =?utf-8?B?Q1MwcEZBeVlaUFFnWlRhTXhHMm9BMGxGbkJONUszQjRJK25EQ0ZqVzh6OHR3?=
 =?utf-8?B?TDJzTmQzcnZUc3F3WlZXdzNzdGExcU1YbHk5VzhXYkRSNEoxRjh3TTBsYy9D?=
 =?utf-8?B?UG1sdEdiUVl4aXUwWkxVRFZjMWZtUlpXRkUxQ0IyMmdqc1hXZjZrUDJic3du?=
 =?utf-8?B?V09RQmtKclpRZzV4bURGVlRrd290akdnZEtybTN3R1o2ckFZRjV4ZUhIV1RQ?=
 =?utf-8?B?MndIWkZzaURSVnhYdHdVOEhUUTVXLy9aVGFHb2d0bnVMMmdINzhIQnovSHJO?=
 =?utf-8?B?TGRQNEVzaDJnKzB4SFF6czdTbitzSFltOU9EcDFwN1BYNUozVjVnOENaRDRU?=
 =?utf-8?B?SWhwQVQ3d0lRYk1INmNhMWxZRnZ5VUlPV0dyVFovQXF4TVlScGNzMytHUmdD?=
 =?utf-8?B?R0dOOXVpQ3Z4QXhDQ1lNVWlJRXZCb1JQb3oxd2JLenlhN3NwUXMwMlVmeENW?=
 =?utf-8?B?MXorbzZ2bmpnTlhGTTI5cCtldmZLYUFHb0trdXN1VEQyUnB6RitvOHR1KzJv?=
 =?utf-8?B?ZDFzczc5b3V6dHkwVS80VVpwQXhaRnp2V1ZxWHlqM3lReGZINEFmQ3VsQ2h1?=
 =?utf-8?B?dGJzOHNLSENYVkpwQWkvRHpBemJmMXBQcS9EMDY1emtjOVY0aXVVVWlZMnBE?=
 =?utf-8?B?MUtRek95OHNyODFGVFB1TXNKVUhmNTBnRlowUUFScHNoZk82UG9YRzNCTFlV?=
 =?utf-8?B?ak5MeU1zVnJsUjNKd2JXMkVXNU8veHFlQ2ZRbUR6dDNTZ0lIL25TNzhMYjhs?=
 =?utf-8?B?and1U3FvdURPbVl4ZkdXUmFNVkNibm5pVHRXZXhWMExobHQrMEovR3FZZnc3?=
 =?utf-8?B?cElBVEhEOXExWmNHUXdscmx6MHhRSGx2YkZyUXNzZS9MSXFEbWdpU3BldWk1?=
 =?utf-8?B?c1lUODVGWWtBUnV1L0lpbUpVcHc3ZkphTWhzek1SVlZoZ0JtY2VRRmpHVXQr?=
 =?utf-8?B?Q0t0bjJUUmVxbWp0dTBsUUZ6OGltaVB5R0tQQ0JjVm1Qc3B6UmQ3TENlYmdU?=
 =?utf-8?B?UXpoa2M2ZWlwQ3NjYVU2NkZSWGs3Z2EvRE1leHdQZjM3cElXaG9GNzJ3UENL?=
 =?utf-8?B?TEZZbGFFTjFvYyt4Y2gwQkNqdEtrUUk1eGFZZXpkSytndXNocGNjS1IrRUJt?=
 =?utf-8?Q?a5Bu0Q0/M5O4TVtI=3D?=
X-Exchange-RoutingPolicyChecked: SlLfefpQ1Lnl78/XmxfIUrz8EfSHhitdipKK+fYOr8jxxWt8a01utxINfim9/iWvT2PK6OnAIJudaGnbNpvLPesq4o8MEIajgJnCscNnw3AgpkNxpIirKJregvl5PdR+SkQS1h/oW8sdqmJX8nlsvpvE/5zNau/KBtus5md1149yrRIpvye68gslNivpGsf38uGeIvdX+b5sk4uO9raYdA9oiAL0RqPeRFz8jGsdsu14Fr4pLslcM6Ma+8BgMfGpSKch2v4KYAq9PNIm5RJaoRNuFCwVfpbSgbf8oKZzzVKqqif8PjeJbSE3/nDE6zDaIUE5KnnJ6M2YB23OTa8+EQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9534fc-d129-4e37-20df-08df2a99e75c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:54:21.1481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsnESEFoQuyw3KcYatkJlLsyvj8YPuOzQG4nrqi0kOdm4QG0eCB+IhZGaGTTlf2+IboCk1MRT2Sn1K/CH7QeGACT5LzOHN4m+elfoQeVySk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6073
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

On 10/14/2026 10:16 PM, Thomas Monjalon wrote:
> The __rte_internal macro is intended to prevent calls
> to internal API functions unless ALLOW_INTERNAL_API is defined.
> Unfortunately the check misses some calls to internal API
> when built with GCC or Clang.
> Clang can be better to diagnose such cases.
> 
> Clang 14 and later support the error attribute
> and therefore select it instead of diagnose_if for __rte_internal.
> Unlike diagnose_if, the error attribute only rejects
> internal API calls that remain after optimization.
> Internal API calls can therefore go easily unnoticed,
> making internal API checks less strict with recent Clang.
> 
> Prefer diagnose_if when available to keep strong Clang diagnostics.
> Retain the error attribute as a fallback for GCC.
> 
> Fixes: 4ab63cd60ceb ("eal: fix internal ABI tag with clang")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
