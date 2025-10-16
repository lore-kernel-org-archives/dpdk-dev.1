Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDC0CCD195
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 14:48:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6E9F41133;
	Thu, 16 Oct 2025 16:48:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 5BE3E4026D;
 Thu, 16 Oct 2025 16:48:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760626131; x=1792162131;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Tlov/TfI4KuoYg60zDk77AeXcuu6F2DJzM9GXG2jDz0=;
 b=CNWdVEVm0Da7oeolXUPu6U5b/md4gwyNApuxluayxZXhwjazbaOJ2uYU
 kzjGYGhAYq4RyD2htkIJxj2BHh64u2DFoypc7WLTJBni1uYwEOr+4huTF
 MbMt+yFXfTFym8PmyPF0VH7xhhogJvgYGTUyzCuo5Q26qZmbkOal3IvdP
 rTr6ZvsWzKt+Nx2CwbnP5dZ1G/FX/o0wTo7hUZPxzyuFuPJrKYzedrmus
 FrAsfFXgrk4lyxIqa+TLYdAnyG28U5CYbdp+x3JshZiQVXFnKlVn8kFd2
 pHk1YR17yg0A0oQ5NxLuL01C4DGp348pSZ8FFE7GNafjrjD4fpr9jtjwj Q==;
X-CSE-ConnectionGUID: dnl2ySP/Qcm49IATutnIYA==
X-CSE-MsgGUID: 1fYClaSlSsi11jCQ/vqZkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="88290127"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="88290127"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 07:48:49 -0700
X-CSE-ConnectionGUID: engDoWUrSCuMY9p1JsxIXQ==
X-CSE-MsgGUID: sNNvQ/bqR/OT0F78SZDF6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="213071153"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 07:48:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 07:48:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 07:48:48 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.16) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 07:48:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWa+EJ8yJR96lQIlwyfjpdFwiFZEs4CuU9EvsmVQqtfIE4gVPRlbSFgHUU0mIVEPS7eKBBAhG41C8gPs/2avaav33nX+TXMRS2sg9ATkkxUtB5YwWpIYSxtVe89/T06rZcYZ9vtLpXOzPryShnv9N4pqu5F9uUMnlNOmPkDUa7YA42uv6bd3BoPkrMZIWKmKeGIxwmSpXt0VcLNXCy3yU3n62UnEOzOvSUU3/GjP0AIzJIhB/ohYJCuTbiskI9328x5mXSVBuRiFa5pOBDmwjYmfORxjx8teGxtWE8H076fxnypw9iqvcVMm7g3ldT3+sfm5eKHrpBdK3cTAvNYi6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9UsLbQfcjngmwc/xR0/y5K5I6LHLqeXrHLfmgmHDZ8=;
 b=tJGaYmws2TTc+iqAwiRkGcDFMBHs5DHTfdp5QpUBdrNTFDBgnlkFJnENh93Wg5EWi3uP33kW6ZQef3LvV3ltqwnIEdMr13GsCtlIAyG4VLPCqi8MSNogCeXVMObT8p5XRzPjUG5szHYMSTqYu53o/NVLjTedHXD+aC45Pq7mUkZAnDI00qE4cot2wCwyo6rc9t31/w894C87Oqn+S+U69WI84HlhoqwXwplWI5aUWBhUdtuoqJJUQgs4rSIKjEQTY8Lk14M+ZO5oq7hyjs1SJd7HI8muFCxhKR7IzZCvFQgXDJK83IDCgL/pMk2OyHCpe6ZQ7ikYVrTfctoej56LBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB6986.namprd11.prod.outlook.com (2603:10b6:930:56::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 14:48:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 14:48:46 +0000
Date: Thu, 16 Oct 2025 15:48:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thierry Herbelot <thierry.herbelot@6wind.com>
CC: Ciara Loftus <ciara.loftus@intel.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/e1000: fix crash when built with GCC 13
Message-ID: <aPEFya9U-aGhR2tb@bricha3-mobl1.ger.corp.intel.com>
References: <20251010125848.965340-1-ciara.loftus@intel.com>
 <f2050e39-4fb2-44cb-bbf6-e0fca99ab9cd@6wind.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f2050e39-4fb2-44cb-bbf6-e0fca99ab9cd@6wind.com>
X-ClientProxiedBy: DU6P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: d18747a0-c915-498f-1ab8-08de0cc31c05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GxCybjufI7W+YgfqZUyGhPJNKAK+5iFNAVoS/ThjxZzv4JWsJX258dwjsDxE?=
 =?us-ascii?Q?19SjvcmYF7QyBOlampihG0bsiaq4zy92G24dUECW9o51D0LHhrK7riLR14/B?=
 =?us-ascii?Q?FBH52QAIEdTWpl8iJf6h0JeZyvbAufUehXcB+JpoZLq5/bqHaoSmMpudVH5F?=
 =?us-ascii?Q?91VAbl0Edqa0f6HIoFRHM55Q+kTR1Biz+wLhnJivP1CWSeXTsIHMCrsT7THp?=
 =?us-ascii?Q?kjCetH37+zO3GRuA3MAYjiEOUAWx+hvWT3qvAFsy78FbRcIsrvoCTPeFnVzO?=
 =?us-ascii?Q?3pvlGLPGGpnIRUjJxg3CSEsh7Uv0EfLTu+KuwmzQI2/ntEHVorRi63Orcstb?=
 =?us-ascii?Q?TgZ6pmw7jtGCzV5znCj+0FRpfmEsn+M6XlYXaBIKQfFKquJSAjTaoPe+2IZI?=
 =?us-ascii?Q?8VSdF1/Zpln9tmSUXf3RhTKSnf3BLwVslahLZVkEPkrrMAorKuwteMZVAliM?=
 =?us-ascii?Q?V06s5aGNjF/7qsmI7Xgj52uruIb4Yi23hENgP4/fhDjkkZtLy3Y77WF7GQnl?=
 =?us-ascii?Q?1jzwp7674nC8U9OdkyoxsZf7DoHomAoodckKf1LMZI139qL1/1WU2sjVGJAv?=
 =?us-ascii?Q?NEO5yqNH9Z0YSvMx1Xb/EbX9LyLnEffPRIb1E2rKAVDDL3gzT+UB2QI0HHbr?=
 =?us-ascii?Q?ZXdGSjp9h+E5iOKvR/yfmmWFlyY7m5BsatfCmZhTdLqPw5gbRZS11bf+3cjK?=
 =?us-ascii?Q?OGWwBJ3gCxu3mDOYKb4lPzfewx1ojCxHUrTGlobMUcFRv2Xu5ytLODYCvUb4?=
 =?us-ascii?Q?MQ8PlbyCLlIHRACSaJ8ZFMGZ6mXaJ0CmYhN5tfSG/YJQcDaobgkvuHE7Th/r?=
 =?us-ascii?Q?Ih4QQHQaCSaJP8fQgsLBFWfyvWcWPAAUbhmCrFKpKDEd6WrCBHbpDI7xJKas?=
 =?us-ascii?Q?KW9qnYmBr97W6SNi3zWsvTXJF/T6PWIP40+Zne3BtGxLy1ChNrqRZvGuVIOT?=
 =?us-ascii?Q?C5kLC+CTf9OQyFio9tA8V9xZ8Ywe3bc6Xl/1lBtk+l+EXMVzlXIMOvDgENXz?=
 =?us-ascii?Q?Gsa165Um8u6biH7zOOsIUn2gVtpwwjwm3zTsQKoMyxcLDkIFCAS/HfswJDp8?=
 =?us-ascii?Q?k4u3989tJ5RfXPH5BU4aUPu8A6ZnP1YPvuR1yyDyvQdIgh1zSu1r0xWsn4DB?=
 =?us-ascii?Q?pm7Ki+/4QSmrtgMq1bbfFbzVC2K/9bmeE4QRRTJRRmJM/1+dh0TheGE54Hrt?=
 =?us-ascii?Q?MhM0wowJVBlIz35Y2z6sYCO5YqJeZurGS33AsE7dF0jS6Kzrgm1L8iv2FR2o?=
 =?us-ascii?Q?wQ0J0GPSusgq5S+B9alQbNyHE0IgXO3akaNikW3nIN+Y6ne5UXX7yHyYH2D0?=
 =?us-ascii?Q?uvG+/J3MeHWvvm/zbx3TglHUBOSEa3iv2COwHNd5vtcIHFr0vaT+EHK7yhcb?=
 =?us-ascii?Q?nrRlRxDwi5pT4i37KD59hyFpoZlbkl1eaBEbZvZldOHmdXqVYLRZp0GRFRez?=
 =?us-ascii?Q?Trx4+rkhcjPRdGcxaI+Tl0g5TI8/1199?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LYWn0ETfywwbVN1FmIC+QPlNV/0moBncAJWf0wnf4y4CPdV87OnLZNmecJP+?=
 =?us-ascii?Q?7c6gLdq9qf0EZXkRUsQfKzK7NlEBRNiWcvQI8UdeNL51Ey631hqRs2CEoZ4y?=
 =?us-ascii?Q?AtVDX7ZKXdLZ91PvGe4Gwn5w22xJ9HEoKJDOC0vboEbOIaUJU0yDWLbL9+fB?=
 =?us-ascii?Q?VszmYiioPwQ6DX1uTNyz+RWgYVCLuERHSoyOKC0yOXTyP86RRQzC1TxvUy53?=
 =?us-ascii?Q?9eA5HiHAqLvBU+p7zDuuzTS6GM0BQuTUFDDj2eguHX9o4hZpkCmUwVZA53N6?=
 =?us-ascii?Q?J5V+sED3O76sD6fig3kIPb5oLngmgOmAn9iMDUwbi0d68aNnmKqBoY76E17g?=
 =?us-ascii?Q?BmHSEbArUAi8LBNNpraOqyPfbdZCV5okTJASgdSNV3/hlRAlYmO2kvpMBeX0?=
 =?us-ascii?Q?MXeefrYdKv2aZp0Koq5gJ4R2TbGdS8kN6sf53Vrbm9ENr4h9jrPfmVtUhrTv?=
 =?us-ascii?Q?CSYIdJuw2upWXFtb796WWNsp4C1UyZTCxJobuXEgWLZdxlyFN6sptz6Olv/f?=
 =?us-ascii?Q?egqSTzImJ9CE/cJR1oOB9w4/IGSFHamQ7qgI7TQTSZa+nSxFYdyAadiN3TI+?=
 =?us-ascii?Q?+2U8XT3PH+j+B16tcqx9xye20aEHmx+JvcS+7kWByvD2zDqs6Cnu/8G/Drhr?=
 =?us-ascii?Q?dIzugvEmIoZPhsQOfKk2gK4H//0A5iA0sK5mXiy+U8xZPSRFXG1ZgXLRn48q?=
 =?us-ascii?Q?4n60g1QWrL45bNTMuMjYBDNZRsJK6ek0npQa1YFnP/A5Dp5xYpKVBJS4xdw3?=
 =?us-ascii?Q?y7t+9dMhvhwwBqodd34y+ORtnAJTkczdqAhlFvBXvb1XnvXVeTcsfw5oxu5i?=
 =?us-ascii?Q?mVLCcE64UVcxdoGegN6fAYvm88OC1F9TFHLurtafEKTOeIUKaHwjfl6J8Vtn?=
 =?us-ascii?Q?4Z8akl0N688191UUDR/5SnErEL+E+dm64Qf3g/ao1jKJBYXTC9o0lGVAaZL2?=
 =?us-ascii?Q?jnlDMY0HN3SWXzE8V0WhVftJMtlBFHPoZuuU96J/ebzU+JadxHuGWnLlKagX?=
 =?us-ascii?Q?OI/q5EyKXWvKxpUImdMyWf4hUce90K8+N+PNp/WLRb7EV+f4sPzRAO1viccd?=
 =?us-ascii?Q?3o/TTDrryPyL6rvFQ5f0J8SjNprKKgq8ElNYHnR1casH+MD/8LF1nNnW+VDj?=
 =?us-ascii?Q?pLp2+1ubmsDtdV5792u6S/1M1O/kuf1hw67VEErRmRnoAlJxyd5K6pxE8NFS?=
 =?us-ascii?Q?e7+Pv9DX89vSw52df5MfOz0WR0leSCtO+EFKanb4ek2eTjYcmwTPTk+esDwV?=
 =?us-ascii?Q?2YnFjja69pSgYucZUJkdkNf08BrD+KNZQQeNVYNwq64FxkDve7Ny8mquhGj2?=
 =?us-ascii?Q?B/bx6eZbMrdgErfrevMDHCD2ioSPN+acWBVpnGaEZi6f82+1ooI56mBiV/VJ?=
 =?us-ascii?Q?TXmIZK9BU82MIAqG0MrAj68WlfcMCzG+n8J++7L8Jv9XQAyagElxxrQh0b/o?=
 =?us-ascii?Q?iAE1G8yJKXLWExx18HlXQZT1BNVhRmOnG0Ix1bgAzU5OFXPuwSzPJD2WOnSb?=
 =?us-ascii?Q?SqnFve7GkPlcyjj5chzTUhKH9jQ2FgTL172FvUikGOaFbVALUOFMhEtkqpaH?=
 =?us-ascii?Q?HBo7qXcvsD8MBj3h8iAIn7AbFaHM9m8lyCxRCPeWPDecLUS8cem4UMCphkeQ?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d18747a0-c915-498f-1ab8-08de0cc31c05
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 14:48:46.4231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojKQorr1K7/TbI0sZ7Nz0GtAuULYpvI++1eFr75Vj6D5Waysq78nIDUWelOoYObt3eEUuSGFqALm/ostS7Uj81yyDGlwB6B2EFVptKjLSQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6986
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

On Fri, Oct 10, 2025 at 03:31:51PM +0200, Thierry Herbelot wrote:
> On 10/10/25 14:58, Ciara Loftus wrote:
> > The e1000 PMD crashes during initialisation in a Ubuntu 24.04 VM when
> > compiled with gcc-13 with -O3 optimisations. This patch introduces a
> > compiler barrier after the register read that was causing the issue.
> > 
> > Bugzilla ID: 1691
> > Fixes: af75078fece3 ("first public release")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> 
> Tested-by: Thierry Herbelot <thierry.herbelot@6wind.com>
> 
> The patch fixes the crash at startup.
> 
> 	Thanks
> 
> 	Thierry
> 
> > ---
> >   drivers/net/intel/e1000/base/e1000_mac.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/net/intel/e1000/base/e1000_mac.c b/drivers/net/intel/e1000/base/e1000_mac.c
> > index 2fa97d12a9..41aae86ffe 100644
> > --- a/drivers/net/intel/e1000/base/e1000_mac.c
> > +++ b/drivers/net/intel/e1000/base/e1000_mac.c
> > @@ -1842,6 +1842,7 @@ s32 e1000_id_led_init_generic(struct e1000_hw *hw)
> >   		return ret_val;
> >   	mac->ledctl_default = E1000_READ_REG(hw, E1000_LEDCTL);
> > +	rte_compiler_barrier();
> >   	mac->ledctl_mode1 = mac->ledctl_default;
> >   	mac->ledctl_mode2 = mac->ledctl_default;
> 
Since adding a compiler barrier is still a workaround (all-be-it a fairly
unintrusive one), I'm going to hold off this patch until rc2 or rc3 in the
hopes we get more details as to the exact root cause and why gcc-13 is
producing code that crashes.

/Bruce
