Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D89C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 14:16:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7BA84027E;
	Tue,  7 Jul 2026 16:16:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 612AA4025F;
 Tue,  7 Jul 2026 16:16:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783433794; x=1814969794;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6gAn063Zw/2UUh8rVOojwbaZprhCgdAtFmWbsHdue7k=;
 b=EUnkS4g8Xgw3q0C53X5/aBbop7r+5CJqWIkBlqAtFjJpZ2vtxg2C2yDz
 +D0RpYIeOnwGNpnZtvp31ARv4BZtWb559qYyrWjlPDvJqDvSQwRSbaYmE
 6byAUsopLJlYGK34nL3uCINNV3n2YdfWZ8bjifIOeRFARjZ0tX24B54JI
 DdCRp1uU6gN0PBttv6n1duyIBy/Yc5FvFeJ4qRY1aK0X6+0bfy2Es0zQI
 mXR0jh1cFIl/f9V6Pet/1d3zHNxKIDat0yblTz4dYG/jqrg6Xr0ZA9Bps
 nJlOhpgTcVN+ZF4gO8woeR+QTKH9x+6tl1VxD7a4sxXSRgCKQxanF8/j/ g==;
X-CSE-ConnectionGUID: TrDLlTm5SCGFBvxrZXG2eg==
X-CSE-MsgGUID: XZbtfVtER6qjmqIIn6XkCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="87997178"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="87997178"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 07:16:33 -0700
X-CSE-ConnectionGUID: 3S4tlE8IS+W20mv3yeODIg==
X-CSE-MsgGUID: mlTBZCFiSge/U+2xR4q+pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="247631249"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 07:16:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 07:16:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 07:16:33 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 07:16:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgroA5H9fgsEpZqnYEw4TbNPuQfjRkiZitkTA660aH5tjztRaEeaIa5fcQnF1Rb/DmexYwJbugdqpMZgfNn2pmNyEl3oW6VpDucGAVXAcGnKdz9y8Wj/nPd1S4iRbdQYzbxGKUf54m133RT9jC5ZGXM/d4Djl4JzwymHVof2kOeaTgnmuqdS0OPJk0m4zGlALsmRiWDJWCNEmrIvLUam48grMn5HQMCRyyHEjKxFDgt6ahkkVE4FlWOFo9dSej8mGmxeCqe8Nvupyut8HBiSw/pICIlTyXT6QNZZRP6iracE0z1fpE00PdhjcghnzKx6FGStawRUAx1d8p9c1w/0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEyQrppATqciwJkGqsxQwbazk16iq2k0hGIlATVg/Qc=;
 b=FfvHqLi/qqhe+0lCkY19D0F5hYcgWKf+1HEYFEagb5pZPpBGEFhiPOgOKj6j7gW/hSWnPusGQSzswtC8Kz8IKwpecbS2GFmjEssi2Om5RbrGchCor/tZ6uFqfmIRM1+9qc7/h4r0pzivrwH0qoVuchlaUXurZ5r+ZMYe4vQycVbOqR9rLLOYHvI70lmNu8W3Sd0oto+nCs7LM/9QAD1/2z9WgjqxL7WvWom/4x1sY1Ns7Tnw+5hBqmh5GpsZMEuQea/qC+0IAnIv2+Blv9plI3SF7AnbmPkjnVLqPl4nOb/s3CC3XAKYOx2K8rwslEzDbJrNxEzpupGXp4deNFnWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA1PR11MB6268.namprd11.prod.outlook.com (2603:10b6:208:3e4::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 14:16:29 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 14:16:29 +0000
Date: Tue, 7 Jul 2026 15:16:23 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Maayan Kashani <mkashani@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>, David Marchand
 <david.marchand@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] build: fix libpcap detection with unusable header
Message-ID: <ak0KN_oZGU1WkPHm@bricha3-mobl1.ger.corp.intel.com>
References: <20260707133028.236546-1-mkashani@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260707133028.236546-1-mkashani@nvidia.com>
X-ClientProxiedBy: DU7P250CA0029.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::18) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA1PR11MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ad97f3-9d2e-4708-7980-08dedc32567f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18002099003|56012099006|11063799006|5023799004|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: Q1nU3swP6i/+L70aFIgaCq+wWzzLirPnDVGVAr10ST9VyLNTkC162zUuEyv12Zk2ZWatTFNOkctHE7AzAs3ueR8mJJVvBtl9cQFCZpsi8UHNuHyrv7PZi+QElIb0ogeb1oAkAbkwfxC4NVUz/9FoYonu0fwcNl4wQEn2lMWNT4DSJlKTS7UJtnZ3IIr/FnWt5gfBWvTiww3wORmbLgzBLXarZmYZuveEP1DyiNAjB6N7i9Xf8ZuqlydCmkquqRV5I/5z3DgLnBuWvrbyTPYuQNoQJQXnZO1HosAmnnxgB+11caNtEJ7OeIkXJnOTEzLqL46t+N7Cxyjy/U2Uswruu2emoqC47T2mQiHMpUCSyGKVKllLMORwsIyQ0DX57jsFovl69iQ64u330DMGOjhbhU6IhU07NdmOfZDntBnXeeGwyrqN0t4MFSnxyHogVxJ3hFizkSjMBjumALTUo4eqSSXaxTW2/UByoQkZRSkyWnbIv3SotrdLLqI8LPw276VQqvRTqocxUM5AsEEZUUSO3hnJc+12J04v4j+p8nmwUvfK7bjt+JNriHTi0NH0bskBd/az5N6Fovo7dZtWbfGr7qEa+uCmtBI4WTB+Ru7D4qVydlb6agHmDh75eDDcZmrLyQupHh0zRm1xDn3QJ21TlE0sH5JMiZbss8MBtspqoMc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(56012099006)(11063799006)(5023799004)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nIq6zjD8ArbgDBcbNMXl249Lml7CXLiBbFd3psch+aLy2zWXDLsDORlJjjs3?=
 =?us-ascii?Q?vhElOtdp1DdmuZjsKJrNQ5bbOAiG3tExXfEfP7h5OVxZUVk1+ccOgdgMlsVr?=
 =?us-ascii?Q?GiFantZfplEG0Oj13JjKO9ymLu/3BD1PhpnF++E/QgMMKNUbKQV2Bw1R1lKG?=
 =?us-ascii?Q?vcrMqB7bgJzj4YNITrG/+hwaXoFkg7Wynk6QPGbahUMv82IqszZ2XNyUc4mV?=
 =?us-ascii?Q?Za52PegLZvE3UlCeKqPeUx3Ji9riVNy91gejOCsRelqXruPmdXzrCbjADKm5?=
 =?us-ascii?Q?BYbz+mUwS+L/lzwQ4Vo2oQVE9tHD5Dep+FBhRdvKodSLD6b4KsgjwBT1e82p?=
 =?us-ascii?Q?63mSgzNumirqWDw43JsUfK4f7iQ0wvUxw9WitKx9zaOCTPNA1n7nK7tpGd71?=
 =?us-ascii?Q?nhAv3OVSGHCwLsdoAP0FrGqSwcPAI2crlcJ8uT0ydBG7RAM4LWbTbHr4yJZs?=
 =?us-ascii?Q?iuCC1WxCriqZPly9eplEqERH4dvpc2rHKhI/F3Cx8PHMU8fuIiZpQyHbAfSk?=
 =?us-ascii?Q?mjBE5ANbrSsfDASii2G8p+0FXY0sm951WN4dJ+yc/Ki2YFPs59eU4L8Jn6e1?=
 =?us-ascii?Q?kX/8xojITvWYLjUhpu+KeBBFR0D1W6/sYOvO4XEEagOsGi4EsEWswN+ZVQRM?=
 =?us-ascii?Q?TCCGtPHPbxZ7B85Ej1FLVuTlt4RSULOD3D5bUVJa7OySWyBQQ1lRGzqznKHD?=
 =?us-ascii?Q?7RAfXdXSLYRU4P4pE5DdOqzFYivf5S6LFHOwB0Ghv14nvuN1qOE16w1SQR5A?=
 =?us-ascii?Q?mt42k2JFbikdlO/wg8Jtmsxp7ARP+gHON0d9ONR80SsMZQembrjm2uRjU+M1?=
 =?us-ascii?Q?aBNEZ0jVdme3mwqRwoEhQ/QBlvaYkTDiPU9iSMbnt6WAdeDcwjvK2S5RFm1b?=
 =?us-ascii?Q?JfNLBOaBxH5J3YvQUXGMqN18ds+4U4Q/zZ9r/VsM+rWjVh6YLIa29zSa8fzA?=
 =?us-ascii?Q?z571W64BxT3pz0qb+shbQqCwGFUnqxSkMnN4Tjs/0IGTsC1a6jI53YvAyyU7?=
 =?us-ascii?Q?Gpa7fL8RRlln33gaO3Ana7CP/otNDkwDp3AzLaX94PKJjfW5spWZ9Pt/ZkZ2?=
 =?us-ascii?Q?C/JqA0whV2S0+sCWYJoS58ueBd5Ot+QbV4tRWPdoqBiYagaSbf7BT0K6sB6+?=
 =?us-ascii?Q?XMdijZKzm+k43iApj74TDbibB5O/+GC26EoAfIt54pGVCFqtZcB5GabTIOSV?=
 =?us-ascii?Q?wy6XU2CBgXWFyEv1GoGC9D+wHa+ESqptOIpWCN2izAxlA/Rm8kOmAF3jVsA7?=
 =?us-ascii?Q?Ibq7F18GNkDHWivr9CG/JK5OFNiSVg4wXtocyuTR2N8ErzCYiJ/F+gArWg3u?=
 =?us-ascii?Q?FTzjlm5PgI3bIUbidY1y9oi5NbHS/bRDQjvl2YOKmfTWSDWTGuQQ3GQ0E6F0?=
 =?us-ascii?Q?HlNaq3MOlAEXp9u01/JtFfY0snMLYSV7NFfyt+cao6vITBmpn4drd0mguDTv?=
 =?us-ascii?Q?DwdSFy9hkeM8+mKtNF1BOUQHeabJcTZz9wBL8MvkGS9dFo40/dapZfbvlw3k?=
 =?us-ascii?Q?4OcHkVFdbLrF+1NNk/+MCX6yT5JyB4BwietCQu4322w/JQ/0539ItmTzDHCG?=
 =?us-ascii?Q?WzmCzdK0XgHOXjjR6CJAODEWeFwb9fGgKZtUmZOtalmzxWudAvvhUgCA35aF?=
 =?us-ascii?Q?LGAUTmxIENV7xns5Z2N+93/uExiOJoWoZWlM25BXFHfgTG/3lFMczAmXRd38?=
 =?us-ascii?Q?eHjt021/F/SLmic3m2hyyk9eCFS+k/FQ7qExYvBbCT+U3Pf5sKwBZEXRL++t?=
 =?us-ascii?Q?2jxqTTvPjdppYDF4mKMNZ/nBfIYbRI0=3D?=
X-Exchange-RoutingPolicyChecked: Vzwj7EGQJrWRME7id9F3hw0rcKBMCME0Ybp/xYc+oqabB9hIg3YkOfMJev1jNCLZa9Lvq+EnqSQB8m6eC3yNLsdIv63xCay6qmtlFZaMM9XkffsK4MSItAHMDRSIrvm+z07Ud4OhpLdS+9yu+VhT5LVrXFqzanzc79tzjd4umKpPEpfoYoaj45w2zN5o6tbiMdx5VInJK5uQqgXu+K2jKy6K87HyORZq6q0+umiA0IG0UroiY2I5sCkkrKm9MIki6O/kdfbaeQpumOTBeLfqKHCxJlrzmP2pDcIDtQWImGoLUkVrZa/PCyC4C+lyLiUVDeLX/7OwEPL5Uqab6KvZMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ad97f3-9d2e-4708-7980-08dedc32567f
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 14:16:29.3142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heViH4l4h/nFWn7QttclLyiPymHnwlfQw4jrHonamBdgpJrHRC44pqNFsNwcsp20ahIeGSw+xHbLYJ0iUgCQKLgBEPvZhJSqDkeXbZd43HM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6268
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

On Tue, Jul 07, 2026 at 04:30:28PM +0300, Maayan Kashani wrote:
> The libpcap detection only checked that the library was present, that
> <pcap.h> could be included, and that a trivial program links. None of
> these fail when a distribution ships a libpcap-devel package whose
> <pcap.h> is empty (present but declaring nothing) while libpcap.so is
> installed: has_header() passes on an empty file and the link test does
> not reference any pcap symbol. RTE_HAS_LIBPCAP was then set and the
> pcap-dependent code (bpf_convert.c, port source/sink, dumpcap) failed
> to build with errors such as:
> 

Why would a distribution ship a devel package with an empty header file for
pcap.h? Is that expected behaviour in some scenario that I'm unaware of,
because it seems strange to me?

/Bruce

>   bpf_convert.c: error: invalid use of undefined type
>                  'const struct bpf_insn'
> 
> Require an actual pcap declaration (pcap_create) to be visible in the
> header before enabling libpcap support, so a broken or empty header
> disables the optional pcap features instead of breaking the build.
> 
> Fixes: d6024c0a6757 ("build: cleanup libpcap dependent components")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> ---
>  config/meson.build | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/config/meson.build b/config/meson.build
> index d7f5e55c18f..4bfb8535781 100644
> --- a/config/meson.build
> +++ b/config/meson.build
> @@ -290,7 +290,10 @@ if not pcap_dep.found()
>      # pcap got a pkg-config file only in 1.9.0
>      pcap_dep = cc.find_library(pcap_lib, required: false)
>  endif
> -if (pcap_dep.found() and cc.has_header('pcap.h', dependencies: pcap_dep)
> +# has_header() passes even when pcap.h is empty; require a real declaration.
> +if (pcap_dep.found()
> +        and cc.has_header_symbol('pcap.h', 'pcap_create', dependencies: pcap_dep,
> +                args: '-D_GNU_SOURCE')
>          and cc.links(min_c_code, dependencies: pcap_dep))
>      dpdk_conf.set('RTE_HAS_LIBPCAP', 1)
>      dpdk_extra_ldflags += '-l@0@'.format(pcap_lib)
> -- 
> 2.21.0
> 
