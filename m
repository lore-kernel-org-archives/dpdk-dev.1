Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CDCC5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 11:43:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC5234013F;
	Fri, 14 Aug 2026 13:43:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 52770400D5;
 Fri, 14 Aug 2026 13:43:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786707786; x=1818243786;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jijkqycDqPC8rPyAPeDJZcx8nJgCZ5Hw024WZO1ahhA=;
 b=fpw+LDvL63Vk0dtlFUQmngwIGyUhNrKNUIeEV8IUynIt9lLrGT6XfLG3
 iE87wRkGpRgQqFVlbl1KCdelaetRHeW7QO01EDmDfkdIP4Y32RcqpaUU0
 2QQI1ckZPlzbU4TrDDE2elA/gHJKXIuDUoHoj9MTKYWOH7ZYpSRPDk31u
 +rgcDkNY4hiZuSVlWDUslNT07MRyzcgSV40YDNzkJMz8RhvtyTE+uHj+A
 ozZaxVEXSZeFOu/BX7/TWjqdqJ3RCP04x02CVYj3h7pzzfmMQMu1MX/Re
 gqIghIdNsLRYEABibxuIOzuqj6ONjevjz2pp//Xo4SxCMSj0O6NFdnhlp A==;
X-CSE-ConnectionGUID: 5H6t1Z/nTsmVfBHVEvvbgQ==
X-CSE-MsgGUID: RHI1b/+pRW+TGgaJ8tTCDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="90960799"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="90960799"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 04:43:04 -0700
X-CSE-ConnectionGUID: EhWpI2B1TgaqRU3Vt6AFWg==
X-CSE-MsgGUID: tCiO6WcpRbOoLa1sDlD/2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="267690629"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 04:43:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 04:43:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 14 Aug 2026 04:43:03 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 04:43:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szANySZGbWIRMSS/L/sJmgj49QCeQvZwPgFl+lQp/sJickWXBXH6WmEbTdvsr4SbpNjnn1GHo+70KrHTeRwgmVk0/TgIBKTDkGY7obKm4Tz/SOPvLPzaHasGzTfChBOR+FpSOhTAnflQ+loYkN54RguMpo5zpjaYo5IH3OQxAZyfTLuR2tE2816cQX85uJ8HbUWpiF5YdVygbwewuxYfuF99NKwUkxkcskbRd7Bh+tz52H9KCSbBs/JxzSe6qojXyQgG+aNP+U5Sb7p9yhppva9369eKr00JC/P5Ptf7ai19rh05b658YHbcL6hodWPlqPL/D+pJi4U1fU88VO24EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUvRmcOogbi3J/KIlIjtiSfBggJXcGM9r2OQ5lGYqY4=;
 b=GVCxyWDWEsTpBMWJMSTTzaf8qVzY5lB5jEaxV/ofIPimhjzj5cGssxIGqi1Cgyf1DNkRbPS2Doj+xIA1EgNr88h73Fb0ZgwlAYbkiogmr0XlU849x9PkZJanPfCV+yOQoqD/nqTpC0/qOZ+iPFfG+FMwgY4RZmZ8qQroS9s9qMWf/h0ULZxXI+egQ0jpVypVt3W+dZUe5kU5B0FGI2moEnqc1PEPMyjdcwhxI/pfrCjPn+4eM4Ije92gH96X9ayFlIkhPOaf4GClES+atsicrDssb7UkZmabXn0JqmWAmCU4fZ/AgSUQFAsM81V0Jrq+O72w/+U2fNHesYAIkN5/5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS0PR11MB7622.namprd11.prod.outlook.com (2603:10b6:8:144::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 11:42:59 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 11:42:59 +0000
Date: Fri, 14 Aug 2026 12:42:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 1/2] net/i40e: preserve RSS RETA across port stop and start
Message-ID: <an7_PhaodNI01qV_@bricha3-mobl1.ger.corp.intel.com>
References: <20260812143844.71339-1-ciara.loftus@intel.com>
 <an77PfrEDxuqSBu1@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <an77PfrEDxuqSBu1@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU7P251CA0012.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::18) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS0PR11MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 3adb2649-bba0-4d7a-e9c9-08def9f93081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|4143699003|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ep8WMyXt7ivqayQr1r0YZRCSIzaxDfALFAlYMq/Mz2/8xy//hV1SzXnqsmswIM77gAnhyFOUqO3H+pPWuuyNw8wEdXrlCNfOYCAsDpbFjtmHP2ZnP4HXC9jKF71Go5zeZD+EE/SsaXefgC5+DfuipElyVPTorHq47/5IHaliFIkfqb7FN7Ir3xarQMMGhhMPUVwVOvwxwz1kvMRZ+P3pJBSF/P5jbbtpmEqkUFx9LyFoRjtIEpXvXfbDwJ8JL9Mszv0sCbq2azivbKjcHy2qr0iXtckTZKzI08UnAGytG/gSsOoiHa9JAYLmj1SfftF9iPXnIihOHvjgdDvFQ4+2u6aLlGLdZM/+W78wluhhXh9EEAgFOgSCQheNZj41fBM2HPzq587SelJ6HZRS30yj7qip1zV1d+E7CVvLC9RfAKflImGKxkc907Nt32/MDY2/D1oc7/0206rnAY8phpRa1XXSRFJyP4fECukhJ9VM+pouBZFDiJIWGjfsZWuentUaeVhY7W2G0Fq/txBWchNG3JAnb/uc/JE3Z1guEC1EKniLm+Wzf3ey0f5F4GJ82Hfqs+31CD6o0BKEYnDLrPlppV4eo+NBW+Qzmv1pZTqwDMoWXBRyDfA7uByje6inORgBrE5c/cyQN8j9SIhv+Xs6pbUFvmQYH3KIQTZc813zEVs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VgZLdE6gp8YCm6SYZBuyAYaxkS7hFi0MYBsjpV2hgryubBG84Kk8h5S81mZO?=
 =?us-ascii?Q?b+5zVLxwkX/7ebAL3/dbQEnwC3tR0wz6M9UML5sdH5J7OYgOYbliOGrRDweK?=
 =?us-ascii?Q?7RG5EoVFRZb3AvfMhw0gY+nE31GvkjZh8mHULInD4yfsRoLDDgUJhGdligYh?=
 =?us-ascii?Q?lX6+frSEO4fmn95lanBTCBJqaautQ7qsW3LH/AatOx5exiGQhtzgU2sNDwCu?=
 =?us-ascii?Q?tgzmul9SkW5UJWTRLNLH05XDkA2aovLl6FCyCwrt5Jixt/3YTtryPmdX8KDJ?=
 =?us-ascii?Q?8TIX+JGYmMRtairpVk6wX2cmwf3vNJQdSoBK4dQatBBmBzVVleSByX9qDwkI?=
 =?us-ascii?Q?IwlyW6tHmvgaQbcu1+pYpjnjKz4qbB0MBIOOS/8iaXG8WOBIG31rc/KmyLM+?=
 =?us-ascii?Q?uwnP0VMu1sSXywMQOY5LYdAGDh1LFhCnig1FYFJJ8ga3ZM1exXRU1jt+12mL?=
 =?us-ascii?Q?D2+m+O3j/tkz9X+iq2VRFVKp4B9adTgMqTrJ1o3pt1/LgTZy7ToHlHLFaZo+?=
 =?us-ascii?Q?O90sM6sFVuODNMJAwLLBIQZJOMtRbKKqVEEEz7ovXdZXTOUAtqdTf1HfHKNE?=
 =?us-ascii?Q?ZA1Vn7C+cOadi//ECQHSTorv8JniggCVpMSZeNdlpyxCTgx2jNkFj8Xzw7Qi?=
 =?us-ascii?Q?iNOFc0CAYaz3WmRqfFFjp1FVSgeQ53ZRe55LZOjRQAnoV8RMTyrab+Ettzf9?=
 =?us-ascii?Q?cZDVt6FxxS/Y+qkSfDBpll0yHO2YjEbV0lKHuNRv+cvv5Ez2NAl6tsuJK6B2?=
 =?us-ascii?Q?muqdu93+7XZo6b5PEJKlJ0t/oe0fypAkqFojZsQiSSBiQKZDVKaLwLZvcCGn?=
 =?us-ascii?Q?B6rrkXaVyskzVvx3NmpxZ9ray7wykvN4+3CG6awTBHW1QZrpOm0C2Ix8ahAP?=
 =?us-ascii?Q?PaI9+8UwhT97T72WxIhD5ry9Aoi07z4egWtvi06RjqFmrCpcFJH2sSUyluxL?=
 =?us-ascii?Q?CixWRjJetQDuPUd5yREMKefjF1ZDa126gJ0gT6vZeScNXiwWsCPjRbnFwigf?=
 =?us-ascii?Q?mlBlRhOD4TOdBD6B39tDAb3rjzvVVE7tPkurrIP8jy4SVN2VjOe8x2opn5wS?=
 =?us-ascii?Q?BQoKLjwQsJ8z5+mrK92Op+ioD/zGFw9S9dmrU9fxY2+oGFpJyxgmNLwG1UFb?=
 =?us-ascii?Q?uyiAlCCqXhsGHxGfXtU9P+aYr+RDVMXDiUniGgK8I0HeZ1ijhV4fOSHKEFQI?=
 =?us-ascii?Q?Wrl22py0cz0dirZ3xJMM7w26qjmoxZYNlRBwIBB/QVFIH1b3E+UaqcDhqN0G?=
 =?us-ascii?Q?+ANmqQ3TWKXk8cLwBXXi/dfS9fXkvoJEJe2XRvJUPr7pQwv96z+rOO6osgU8?=
 =?us-ascii?Q?9mNh7wkjpWS23IrsOujxoOrZ2gtt7h0kSu4lVnT6Bf0QaSih4ekqZcKauRRl?=
 =?us-ascii?Q?ra+3ec9Uq6KzyjPzRfPApH9mt7TTtGQS09hlDxoNzwUrcA62cye19uX+/unS?=
 =?us-ascii?Q?Cxc6sVMAVi4nt8ZuTBUBI3KeXraDAmJRVq2uEBMuhtFMa5gssC8Re/Nkg0O/?=
 =?us-ascii?Q?xO7I6XUoTEHwkW2CsxUWLy6o54hBEuHjFHbz7/nr3/0yf2aJsTMISfYdtZ+j?=
 =?us-ascii?Q?JmIe5n2SIKx7/ESOTTygwhah/tkEU6TuhzbzGEFQIF5bvg/+BQOkYJUjJkWS?=
 =?us-ascii?Q?PXKS09rvSUQonkD6QooEYIW3SYq+Wc8aLO8mI9bx5yySzAoTB/4TwSuTHTVU?=
 =?us-ascii?Q?7g/P0FtUgixXFoOfRB/aFDxYkhM43nNW2kzA9ifUO2YzYR2BU6/FLnt7Cn7C?=
 =?us-ascii?Q?VtQyUN4er0wc7q0V1c0i2gp1W22YomY=3D?=
X-Exchange-RoutingPolicyChecked: HlGbne07iLHEVV1rjZCdzZQTbNTvIYnVfX0n3JOn0ycoQ7uV7OJL9KDYC2DZgtxcbEWiTvt3WrnHz4529t+rMpzUFeEQ+06WfVp5JheIoxRbyFEY1eQgzk1cjLt15NZfHZRsBnSzxYcXeC/yUAj3RKYmDWvnf5OXMFuaeGI2PEvRYXJoNTzOYM8gF6OSK273+P67ktq6m2sC3ZRK8LkPWzC/allCWEFRDXP/FPEhEa7ADSsNygfNdRhModg4loNkjZzzJfMrsQeVXvwD0eOsl3A6TK/TgHP3PqNpLeTfBaveEntepVktLa0BET/deDGlPWkieg7lcLs1NfDpKfA+tg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adb2649-bba0-4d7a-e9c9-08def9f93081
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 11:42:59.1512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/Z86zFq5KW3u9NvKwEp4AFr/W6HKrW71bHSj30wOtaFDScWXuafjAxeXsE/cWHj+jE6fPq0LFPJtEU7NqPui8x6ov8VIPVazfy6Mc2qhpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7622
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

On Fri, Aug 14, 2026 at 12:25:49PM +0100, Bruce Richardson wrote:
> On Wed, Aug 12, 2026 at 02:38:43PM +0000, Ciara Loftus wrote:
> > Currently, updating the RSS redirection table and then stopping and
> > starting a port loses the update. The port comes back with the default
> > table. The ethdev API requires RSS settings to be retained across
> > stop/start.
> > 
> > The `rss_reta_updated` flag protects a user-provided RETA from being
> > overwritten by the default table when the device is started. However
> > `i40e_dev_stop()` clears this flag, so a subsequent `i40e_dev_start()`
> > treats the RETA as untouched and resets it to the default.
> > 
> > Fix it by clearing `rss_reta_updated` in `i40e_dev_configure()` instead of
> > `i40e_dev_stop()`. A reconfiguration still reverts to the default table,
> > while a plain stop/start now preserves the RETA.
> > 
> > Bugzilla ID: 1127
> > 
> > Fixes: 36c5dc8e5d3c ("net/i40e: fix overwriting RSS RETA")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> >  drivers/net/intel/i40e/i40e_ethdev.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Patches applied to dpdk-next-net-intel.
Thanks,
/Bruce
