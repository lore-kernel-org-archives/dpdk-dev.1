Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74679CD8CAD
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 07:49:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0AC5402BE;
	Tue,  9 Jun 2026 09:49:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 61C24402AD
 for <dev@dpdk.org>; Tue,  9 Jun 2026 09:49:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780991381; x=1812527381;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=q9+QDBD5XElKKiAml3yX3Mb7/qkhY70ecl3Mh9ei7vY=;
 b=bCz0F+BujEkAeWcGvdGeEqUzBQD1xk+c1qtv6cI/aNAnKwWa/jYPTCHi
 Bz13Vwj55ltsnoztDO4spgtd334j+Q8u3FhU/gf9AjiE5L3Y+q0kDHqtz
 gnKnVYQVFZ04cqm3aBxwNItn6hK8y2W/sjBj3omha9KXLEfChrVEoNtqo
 iczatYoMgoQKqLh+4rZZR5LSRoV8RSy26fm0VfvmqtLVVdfqFGqiyCxmS
 I6oMhDD+h8MWabMO5rKAGu7ZybI5imfynGTNJJuJjrP0zY/pNIoGsjZI2
 G5F3q11GwZzKKDGroKfeilzLesA3fIGnHj32umDTb5P+gW4voK1ZAjxy1 Q==;
X-CSE-ConnectionGUID: /cNovm62RfitzERD8ShuDQ==
X-CSE-MsgGUID: eW0J7Cp5So2bUgAwAnpTug==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="107180584"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="107180584"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 00:49:40 -0700
X-CSE-ConnectionGUID: RonMep56RAmdZMxo4Ze9KQ==
X-CSE-MsgGUID: kgd7BRNPTUOXuFEzNplMvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="239450809"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 00:49:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 00:49:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 00:49:40 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 00:49:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWXkBI8FvraVW4VxilRoKFNB+tmzJfYRrYNvtiFzKRWD9wyXWMldsuhBciuD7jupIHClevQdqMzxd02J1Uo0JaEiurDYi0P527OCdcq6DHH74+281dHvOGVDNMUOd4/hHrFA7kt+v8S9eCEhr11Sc0ehUcJl4cgQlsAQjEmZh68IfHrNCQ9OhKv8QeagkMEhzRGnMqmvGnaYgO3V3SI1njHgpb6smg4rK2ZygMjHy0lADS5nQQXTAUk19za8btTnRsP3SmDMMYzYqanw89MJdyUL2/1dCgiWhEKFqsRhYQhA6Sm20nU1CqusEZcCbo5ABDE5u0XlL4JwPyoUbntu5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEbNveppyUM9JaE0vuDNGdgan4hs7uXGxAAPnor3XnA=;
 b=KFlBo4TJgamGaUmflGp8ELMlQjDmgYd7WqFp35GnsU7I5reW99DFFsabK1eaOtMGwBjg4Pv7zyH3gDxDZUnhgx6KjupyRlEcrz3P4G7UE/muql/n/i+KZ4cpB837hIU3njrqA9jSCSDc80F7zWHay9XopXqaTNRlHhR99f3NDLlxRxblymxP3sFhodrLDn4wSAqK40QMUHgBbjPoYXF5wW1ECW+D/C9MU+Y3SdvNeCuh1oiCaEV2Fg4HxbgmtYQRqkTsP3axSEie+/i4wefKfIj9T03FcQ4VgThSmAjVWknAz/BdIVSHopgBa+gI2RHpBkfLSDhpUNiziZoqpDnEIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8461.namprd11.prod.outlook.com (2603:10b6:408:1e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 07:47:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 07:47:37 +0000
Date: Tue, 9 Jun 2026 08:47:33 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Srikanth Yalavarthi <syalavarthi@marvell.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 1/1] buildtools: remove absolute paths from pc file
Message-ID: <aifFFS9gvRn9JYKg@bricha3-mobl1.ger.corp.intel.com>
References: <20260609043220.930405-1-syalavarthi@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260609043220.930405-1-syalavarthi@marvell.com>
X-ClientProxiedBy: DU7P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fab176c-9c59-48be-67c6-08dec5fb605c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jX21LlL0JxvZz121eLKnnRKdNhKWR5rxSA8WZ4tC1pBZybmXo9A6U1k58Whtb047i55dGOVk3KavzrchQWRSvnZCx4gttNkWJJNrB4ktLy0EiRcwbUcGHm1JN3a0mFPNeSbqTlWK6e63u/36IifWQ9Kiw72PmGlcDVcrfrU7bbetA+s/bpbikjnnCOc/77TvU0pKDezMyIo985rG4edOV/Udzq8gLe+wwU9aeEHFg3XsVkBbth8l1QTZCxZY/LVbPx7xFxQtkr5vntlrR9xn7WqemUnXHPQZLlXM6hjDyT0G2Zgn8sK9E3s1iOMCFGJBKrpbwPMjKpVCX5fsRIiPpG/tK5ucPNK+e//GMkUDdA1RPwJMS5FbSK6jtui6ToKEpphxHylv3dtdNl+PmJ2j77wX3HVPh+2sRunvOOcgHl6UmetLgKQ1J+StRaIUXYSsXAZUJivyFU7OwmZ0o6wod1PrvP3crX/1rZQBgT2/w7Mi0Sn6m5fWGhuapq4LMqC2vlWvO1eepVNwOttbdN28kKcki7pujEEl9o7kPsdBTkx5QTWQzh6s80/13RZHKXTZ3zrxv6b4iU+/cPeBGk1Fm5ENTHFWnhJWEJDDuvwbbR7Yu4hvzmPP6+VcbyNNouCPrZkT4sZEL8aHWEvF+mrwYjeZlMTxXtvLK7b2dtXpG8EQaH7bxqylwm8O9sgWe5bcaksszjAf/QtmXvHmsGn9Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JUfYNS/4KCW2JiHBMKwt88VGDm1IN0rAif3X75mvmrHTXRnQOzmhPjvXRyyI?=
 =?us-ascii?Q?lZ3zL85z0bWk8rfbB/sh8p0BohbNrhZEKMme74HCf9uENqYBHRLRCEOOV0iO?=
 =?us-ascii?Q?F1viinyB0ejkTTv++zidweyIzSoboRKQWtm6gSssBpM/hYcYIDw2v6x1mRRQ?=
 =?us-ascii?Q?JEb0qDgVqstY+nWhPYSVGRAaZq//yowUgg54i826VJGA+za4Md0GUfJ66puN?=
 =?us-ascii?Q?QlufjVdyJF648yhpBkVyEyu9yNf09dz6w9+nLtjaP7WbEQIwfI3H4GyYAe1k?=
 =?us-ascii?Q?cIAIHQHE75kJ68+jDGCF2q2gyO6WHc/8U8KNy+LQXyGebTV/gBFkerjLkgOh?=
 =?us-ascii?Q?3b2RY+wbk1vd78DlbSsCtfsB3JgQxPR+YmOmGO/sFnsqFoSsRXmz228SVz0S?=
 =?us-ascii?Q?80WsUQ76v9xgYlXOwAR1GqMSn+NKdYq5CfgIUuRNZuHKXdB8Dy+Orpn/sMjE?=
 =?us-ascii?Q?ecc5FHN9jujDukNuh8f1xOxxpI0ASIe7E0FEquwYUGeeHcuMzOhz2ImBdhnd?=
 =?us-ascii?Q?U+XF9iRqbYkQ/z5glBibEzZSc38Ga1ZBbExaETofLuzDIyYBLOXssx/9KPD1?=
 =?us-ascii?Q?QAWsWMkhI9166ITmhpnq0QaULgSNlnLN834zYN6Pn59F++pXoez2EWp8siKu?=
 =?us-ascii?Q?MyiX+CZcju7Gxb06HFGqBOkqi42YFFJ1tazASBlOsauJWDqMlnQI6fYX3x/L?=
 =?us-ascii?Q?JCN/wTm0NP3ySC1/KfL1YzJK6hTcIkTbUiHtpGCMeeY0U/S7ve+VDvKxM2ge?=
 =?us-ascii?Q?DPOnXM7TzlKTW3aCtksxHdVa1fO4bF/JTkXknCNvZxTWCr+5ijXkA0HP0DG/?=
 =?us-ascii?Q?3tHFslFva/3unsA3DcfcQoUnUbADkb3Ne6QGD5/DJ6pcZYtJzWZBLsMOJc+S?=
 =?us-ascii?Q?qSs8+2Ym0fnyRVmMGVYyLOR3wDzj+OfNlSpNB2/Gnt5K9/vDHpB6XJjNTBXp?=
 =?us-ascii?Q?J+3ZVZVkcDE33mlLlDXI6h8fRlDGcu9xFVfdEWHA2WHHTn4Obam6N3mu5F/F?=
 =?us-ascii?Q?ml99ATtB8y8UBM93fmtWAGUIXLIQFN0TWVXODU01vHe0TS+TYaW3Kj7w0AMB?=
 =?us-ascii?Q?SGCkGHHWyF+/Xz3CWD7bu7w597RKt++DhhHL1fWknhSgH7fa3I/lEK/OoX3E?=
 =?us-ascii?Q?VDeaLd5/HllASVBrHWrUea81gXvT1ynyASaZ2DJjo7fNAE2kUGHJSvwd50sA?=
 =?us-ascii?Q?6k0PbtO+6QVPPl+SAxpNYbxFHbVs4AsQYhAAw5EWthIMNptlMj7Us21NL8Jg?=
 =?us-ascii?Q?xwR1egS8JPnB0zxtAoRwDgzbh6diQSY+8wFC9vii8espOYz1TggWycKacr1r?=
 =?us-ascii?Q?GiXMHQ40420w7cOq8+/2YUN6eYIF+t7EEVni6S3V4M0PxzKDLrzzRl1GYaLu?=
 =?us-ascii?Q?m73j8TTuqypYoBb/w6wVb2nA3MLqauxi1ZCU22t8+AY8Ql0/Lja5GXA6OvdR?=
 =?us-ascii?Q?6OQPgiftUkECPp28q2F2IUgbgRGF3JH354kN0EOX3gtt0J8SQjTu3t0vNFUD?=
 =?us-ascii?Q?8Ajqb1Nk/kSuJmyWpHBisU9PCvH8qHfl+FIOBZUGnK1yDqGpaYzAVl2eaaKn?=
 =?us-ascii?Q?YkgCaqiyQinRhjJdTaiOWR07trdmlbXp6lsmAVG8JEBVTilkcTiK++9DCNKp?=
 =?us-ascii?Q?C4IamFXEc0IkNsOUZaZCB+YeM0fBWgLVohWK8Ymxs6JaUF4WHFBokmH/mzBd?=
 =?us-ascii?Q?ol/P7xJBP3nG1Gjkb9SbCWGJN74ejKa82CasDoPLrBiy4Sb8P+AFnxNWigR6?=
 =?us-ascii?Q?sFwjBFU3HzoSml4odt9nC/3FfDtAiqQ=3D?=
X-Exchange-RoutingPolicyChecked: mqiz4/pk+qBJJbtwPB+Z6coXHP0ZRxCPf7ggXviC1I3W7c0+Sim0oKrW47m0QqI53KioGYhmn3hdVOmtiwzgr+weypjAneF0tZrklMPDbKk8oeWVOn1yAtbZ6+HNYlINDdKu4vwou3riE4M4hjfNuRzINFym8AG+kplcspGKHorESYmms1Iv5dEuSwfCoovoLeGLmCVKlllnMoygZU4f9dEUTJ+TedjjIRABc3Yp43Qo9qYMz35Q+0/DcmTC4Io6p8yMRg5h23Lngd2e00KSU777276I70RgR6BYgb6JffbbxUlNMQbOpqVXfxUMd7JNjvzDZJWAw2CT74FJecsbVQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fab176c-9c59-48be-67c6-08dec5fb605c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:47:37.9279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pC+r4Cv6Axx70lN1a3BVnrOY43ZnT8LSKXm1zykjiumevwpf5aQABFRd5rWHESAXY5FtGMEyHTFGu8fc7DNbJ/X50nfr83vZ4g49JPSvRS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8461
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

On Tue, Jun 09, 2026 at 10:02:20AM +0530, Srikanth Yalavarthi wrote:
> When linking with non-versioned libraries, absolute paths
> of the libraries are added to libdpdk.pc. This patch replaces
> the absolute path with correct linker flags, -l<libname>.
> 

Do we need to check if we need a "-L" flag for some of these paths that are
stripped?

> https://github.com/mesonbuild/meson/issues/7766
> 
> Signed-off-by: Srikanth Yalavarthi <syalavarthi@marvell.com>
> ---
>  buildtools/pkg-config/set-static-linker-flags.py | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/buildtools/pkg-config/set-static-linker-flags.py b/buildtools/pkg-config/set-static-linker-flags.py
> index 2745db34c29..bd217b07fc8 100644
> --- a/buildtools/pkg-config/set-static-linker-flags.py
> +++ b/buildtools/pkg-config/set-static-linker-flags.py
> @@ -6,9 +6,16 @@
>  # Should be called from meson build itself
>  import os
>  import sys
> +import re
>  
>  
>  def fix_ldflag(f):
> +    if f.startswith('/'):
> +        libfile = os.path.basename(f)
> +        m = re.match(r'^lib(.+?)\.(a|so(?:\..*)?)$', libfile)
> +        if m:
> +            return '-l' + m.group(1)
> +
>      if not f.startswith('-lrte_'):
>          return f
>      return '-l:lib' + f[2:] + '.a'
> -- 
> 2.34.1
> 
