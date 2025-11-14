Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A532ECE8D53
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 16:08:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10664410D4;
	Fri, 14 Nov 2025 17:08:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 17CEF410D4
 for <dev@dpdk.org>; Fri, 14 Nov 2025 17:08:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763136497; x=1794672497;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=b+9NW7Q8hyZxl8pU523d4CoOr/ReFnFQ9Vzblbtittc=;
 b=T9gLIhx87G3r4XclCoHNuQDPQJX9lMhIfd6LO2r/vmWgjgzduGyVNswE
 vw3DBvjeT3GnD7jMoVAgmgKlOI0ShLxnM5PviMFXLcdIHGJuDW4bBzhZl
 wAPwwnV8oJVCeki9m687ANzRAD2Q9VPKGE0dLtxVsdM2vjtzJPVpM36Yz
 10M9L6jc8z+9z8clO+vwvkBUOxblfRufLdAxwM4SzwgG+2qGS/gkNkruq
 qwIoAo+XTBgOtwXNFF7GDm/L0c8wrCokEkZUVxmS/KX9wAgw85MdokP73
 N/Ekq2VWDOXFZTDMqrtbAbw7G13rYKuZkjoxY8DgWzADBszPRcbiwSU+v Q==;
X-CSE-ConnectionGUID: b7O+liUcQzOnEQTGxLXwxA==
X-CSE-MsgGUID: gx+x3g5rQ6iOh0rp2xPStw==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="64237330"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="64237330"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 08:08:16 -0800
X-CSE-ConnectionGUID: Q9JUYPWkREO8p3BUgGMHdg==
X-CSE-MsgGUID: dW1dTFRpQtiwuZrwdeOA1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="189818657"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 08:08:16 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 08:08:15 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 14 Nov 2025 08:08:15 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.52)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 08:08:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqLUMO6JtOAVgyHGjZHz1Qvj87IXzVo1RMcLRR8zdLomPYdzrLx2CEEYLUjsbBnWDkaSnSK88APWoV4/32UekW2FZk9aKvMc6Mph4oza0ta/y90f/Yz32oTsVTZsC/JcRjztgxhDn1V52PkrxBu9+3r1SdD6NKGh+c6VUumGozBQ+AuQc81RAbdYHYCCILGKKh6QJocT5vikCqYu55+iBEiEnYLTezNVt9r10Jw/Mpuo9AXLgwyb1RanUWjygu1AxR3BmuLn6Bsw67BLfSH8SP0HJoh8DBlYudtd7zTUO80E9Ynfj81/GYer9BEeUZvOMmI0ji5qrCFJvb1eD/CP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atQEVVHzL4ftsGZ8jJPaRv8j+LSDTi9vFEGsluBdeWs=;
 b=SIeh1Xf/fZee9kfx2ce6HFjD20sxjE18XMRivOW1mH3qzC49P0cy7jrEnG8ppDGNADXfUUGa6UoLMT2iOaw1fugmU5OvLoYi7ux0Pu0mmL+fUHp2gz/DM0strOeXxz73f9uPnCj38Y7wVdNW1jo8VqHAVWDZV9If47v+MuleststguD2XCtghBLiDndgEleQzW0p4ab45/hWaBSxG/7q3u+99xsQ+b4M5X9YiO2Na0XUat2zmHnTyFFA3wPHhGI5kuoD2NagYAIj0H73UzbmMiBRVxmKJRN/evvUxwLoIr7pdYYDV2EqWQMTL5VHvR4O5GYYNYa0lt5WiXG+r6nupw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF0FD67B0BC.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::80f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 16:08:14 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 16:08:13 +0000
Date: Fri, 14 Nov 2025 16:08:08 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 7/7] test: re-enable format-truncation warnings
Message-ID: <aRdT6J9h-vXyv6sD@bricha3-mobl1.ger.corp.intel.com>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251111221857.443752-1-stephen@networkplumber.org>
 <20251111221857.443752-8-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251111221857.443752-8-stephen@networkplumber.org>
X-ClientProxiedBy: LO4P123CA0241.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF0FD67B0BC:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b55f37-fdd6-4588-df68-08de239803a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TLUPEzrEMPLlEnEaY/PLMf7ox+umrr+qOt95u4S9Lgr4Xi9p8G14pnc+0xnb?=
 =?us-ascii?Q?EAqx8obiHNZKwTIrynn3mlDfDSEWBV/ruqy25rxHYkl1YSq4yleRcQfWGZIi?=
 =?us-ascii?Q?llAdlZBiovj55cXu3T2uyKifvZr/RfTr6Q5YC+jpFhULgKGGzJ3t3/VVbBaW?=
 =?us-ascii?Q?NtUKrcdIPWlGiwGmkIBGdF4o86WdyqA3PMUJvpi7emXp+nVBu20iklCj9QQa?=
 =?us-ascii?Q?Hna9l0mhGt5v/GR/L30s7lPuvvVJ/mrk0FpMAkK2bkVvZgfTMQSu4RvwpwL6?=
 =?us-ascii?Q?kyn1fTOtWyAXDAmp6zs+XaiiZiAZMHMofMMVuFWEg7Trb7ecntHXLsta5EGr?=
 =?us-ascii?Q?yLmdtc7fHrezGbFZnYwtkaWHzVURg8fjZkkiKvzeKobhBJjgKY8mMuRZ6+xc?=
 =?us-ascii?Q?zQTQD2AXOpzcini15mgmyKLIDTmkN+gLZ3tEilq5Jgin15RsGLROM+HD8nSQ?=
 =?us-ascii?Q?7Z2ZisvQvi2eKz2SBKnLdYnSHkbT0O5EFKaArNmAmctV9Yk4Y3N3G5FWDYWE?=
 =?us-ascii?Q?kPTrq9CSy59XwQ89jbTgh3XURiRS17cvhp1pXv5Pv3Pocc3ogvWRP6XBt9Fl?=
 =?us-ascii?Q?36FPu2TF1GR4pI5ngVbyFzAh0izROsLdD5EzzroHMRk0inkhBXZ8Pqk0KMez?=
 =?us-ascii?Q?mqy4BiHAMuNg0SXrs7Qkg5E/TMfAettIFFVkiXMO7XUEFNwonNdd1kPm0Cqv?=
 =?us-ascii?Q?XAzt8QjkhA57CWsLUsv6CR+5AjwQ2kRB7g6gMkRkTrVZEyNitzc7p6aBpb6f?=
 =?us-ascii?Q?35+2jCS5lUpxvCkfgdm2JOD01zSLha6qfqbyqNJR6/i7JEXPNk0dQWD68oia?=
 =?us-ascii?Q?5BVmcCmTYtWEQvGYepOZAdPF9nw51xPhZfHlUYpRYzAWIppfdLWTELKtn0+q?=
 =?us-ascii?Q?wlZh6NgF8qscNVpJS7QkeW8Tw3U06hteubizjtBzoGpYAgHpNN6ABjKmPVTD?=
 =?us-ascii?Q?G2Bu0d0tjBj03keorYqZH9lsAwnRrn85YOvUEyyGlYezG+RUrYen1i2RTpYk?=
 =?us-ascii?Q?zN1tt0yr6BKc3gtN2f2Jp7ewPubRilS14CIUStRkL388Hok/BmAeccQWYNPU?=
 =?us-ascii?Q?KF/9V26oE15jpV60rUKF+uPJmvgdHbvkCsIxIRu/Unl5ZPyREQu+TaAF7/Yg?=
 =?us-ascii?Q?IptY+OvO2hbDhhyiFxAysYhPMEkTQiwbtb6gMn0+Tds0RYBvOxGVdnExVoV3?=
 =?us-ascii?Q?nFN4XsoAAn5NLW1oxHNn3Iv5IuY0ozCGYnT3hD+VoAFvVZlwOqkN8aRcuD1h?=
 =?us-ascii?Q?DJClzNN2C0sifBOitpN8Doq3hjKLKZkXJd2xjK2GwaWsgPcgWKMzek6FpEut?=
 =?us-ascii?Q?WyQb4Y1Imtg0sQzl/Fzltb3mnJ1VqfZeG6G4G9NdbuE6Ibp73Tyt7vViW4M2?=
 =?us-ascii?Q?CGmNULzY+K+yPxhUmf0r383f5UepnFiWB+tRuDzU0Yvqqh3MP6AdrzCbPSGy?=
 =?us-ascii?Q?Tt6QGvatniISPfxidS12bHPDdCykm+mu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FoqXHdaXb2PET7I8h/nku3jWerLY19bDPNbiEBGVRCHHsgFTC+NAOW98HwmC?=
 =?us-ascii?Q?HGJ6OlCmVB2uF4GP4kAO7X3Wc0WlAMEcFs0pWrIe4bZE+N9rjPumbVEZkPpg?=
 =?us-ascii?Q?es3Va+misAZVyN0ZnHfNK2FlUtAQ4ds49yLLXhhRhl2zoMJVL5kgY9lNMrjJ?=
 =?us-ascii?Q?AN46BPv1+jK9ONyXyhcxk5AFz++2lonjY7QTma/tnrM574YqtMcM/u8ExwST?=
 =?us-ascii?Q?qEtNJMiLnMIklBNpUixL41OeMjTVyueB7qp+OoxIW8pM+W5atM6OgTfx3lKh?=
 =?us-ascii?Q?+Nv6D/0MnwrdF0KZfdxYsfxeKYyrpUTROfBlQnBhgZIbCEk2SS5uHgyYeSVh?=
 =?us-ascii?Q?fjOih7IAL3kIX0akztW0N6AJIiiJwS5YwbJfYksgRwUJgLB/9AkTSWRbhfOD?=
 =?us-ascii?Q?owhzDOStJeEkj5CmUmJzGXLZKdksUJZ3fXJBvae6dzT+okb5Jm5YAAO6pzhR?=
 =?us-ascii?Q?FBmG0OFmU7EDtivxjWcwEVglZuD0Jsdb4j5u1CMbJx8htdcWHhbqybk6gF9E?=
 =?us-ascii?Q?/zR1gP4NNWfXg9FoTT7VHzLN2XdQomIKZ6DYLSG5wKmyzUROb6e0QRxjuBIT?=
 =?us-ascii?Q?sLAk+A7xVH/B4JoJHCAOL+EXr0VPAP1tOkg2gpI6AxpVcKnZOO8rXdiaCrUK?=
 =?us-ascii?Q?FqkqaUf27zDEvO2PU7mvB6VBzGhfbGBD0pKzugmOmSWiCrvLlkmpn3g/90td?=
 =?us-ascii?Q?kPVJ2sxOfsJRvDOB6zzLsVtRuxH/eyH4Zcs5id6bqFM5qcmM8PS8e9wsjq6M?=
 =?us-ascii?Q?+mowytRkMZWGg94uu2pyC3bNzK8DJruuvQ3zz5ROwevPnNEmkeDl6QZXjZkk?=
 =?us-ascii?Q?9iNC7KftALbYgN/z/Gank7PkN3fHKhCPcxuAy+IrOLHs/cesfIz3pHrkB+U6?=
 =?us-ascii?Q?H7Xw36QVXUXndPZdJ7OCasQTKP3BKWGL/eu1ICirW73NjS8xVOR/NxKditQh?=
 =?us-ascii?Q?f20csblbNLDsNKALNSTz6lKYI225HNmRVUeQP9HFhUBaaNwDasqjmDM0OE5U?=
 =?us-ascii?Q?3iDTuC5GLkXFiK383xmv/fkpHXPmLCmPEjDrSLATF7f7PXtbpBi1v0xstZ1a?=
 =?us-ascii?Q?0uLo5rVWzyjDq11MFXQV5jDb8en4hcg4nGZoq8gL2bWIvsKGgAbdhjUgY+Wy?=
 =?us-ascii?Q?VM3GqBSoouU6jn3IG+IzD2XzvoGaNw/xB6otb3nimXg3Ns4pXTBsL7V3GmTg?=
 =?us-ascii?Q?msS/3ck1wedW1YbBWXQrPkUvhJnqoQEtJDHeLSr5HeI9lYb5zU2Cl9TA3bpe?=
 =?us-ascii?Q?lUef7jiem5FzpvB4rH6k3xdXcFD6ZzOTB/4iL7Gds3xDZNcLjSL2iL6djZfs?=
 =?us-ascii?Q?Std98KSZaWR9rGAaCCagWCV9G5GmahOUqHlAeRD+3c4L+p5+ttNiXGc+Qsch?=
 =?us-ascii?Q?QYdJREd+x7Lno967otdAf5egByx4vUlFtWrUT6kXw2lWyQwInVtdtBY4ByvC?=
 =?us-ascii?Q?dlZdctjOWfcZ4M8yDREUOh5I8hmm3Yqy641GZLLtqKKQHSL032d+gU+o3ISi?=
 =?us-ascii?Q?sOFfahWfJV2zfHSYY7YreH9CakpYTyo0JcfE8jYpTqOhS9PKeHztCnD5fdBi?=
 =?us-ascii?Q?+WVnfvzE1Paw0SQ6VDAxO9BTSAflaNlXzenvS2LsS/2J4niFRHhoMnRdqm+Y?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b55f37-fdd6-4588-df68-08de239803a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 16:08:13.8736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVmgIS3JGKzUQOO7WhfWSJmD0HP9UmmMwBL3xcnWP3pfED/SGWSPl1mzitFSALx0eu1r/l3OCgIDPg/5T9ev0xVXRS9AwUMw1KwUCom0pQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0FD67B0BC
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

On Tue, Nov 11, 2025 at 02:17:24PM -0800, Stephen Hemminger wrote:
> Tests should be built with warnings.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  app/test/meson.build | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/app/test/meson.build b/app/test/meson.build
> index 8df8d3edd1..66cbabe9fe 100644
> --- a/app/test/meson.build
> +++ b/app/test/meson.build
> @@ -260,7 +260,6 @@ cflags += no_wvla_cflag
>  extra_flags = [
>          # Strict-aliasing rules are violated by uint8_t[] to context size casts.
>          '-fno-strict-aliasing',
> -        '-Wno-format-truncation',
>  ]
>  
>  foreach arg: extra_flags
> -- 
> 2.51.0
> 
