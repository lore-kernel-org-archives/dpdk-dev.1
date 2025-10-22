Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F86CCD1BB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 14:13:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B706D40262;
	Wed, 22 Oct 2025 16:13:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id A1DE740262
 for <dev@dpdk.org>; Wed, 22 Oct 2025 16:13:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761142385; x=1792678385;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=232rToexrehZfhZWhw8JY0ewpUtBfhyUrk06DmJzb+8=;
 b=ZbliASnG4EU9kFukmEtYkp29CzrrjThCRwzIe1oBTdOMUv8PfsiVFdj3
 Lo+H+I7ssFfDnbbvKaQRKWVc7TKlkJwsNUXfqq7gLshndrAfC8m3/gLWo
 7n7SPht4OZhV4eGTnXIq+flHqUubiggN+jVqqEzP5JOdRhF5JaGo+X4nC
 EFA21ITv3Tw1B0WGzW7AfB7skGeLtKqfT8TFXI46YVPnwJ9UIY56uR27a
 mr80+jchBVvOkKNIuFM7OYQEsASuBI91yJd7qjm316NW1mWU6XedB7LB8
 b9Gkk1mQPxf1uVd2utjCESY+MRX4k0mVm3Ci/JuxADO+jV+g1ASfVT1Rc w==;
X-CSE-ConnectionGUID: YAn3876nSk6/1kcbK1rOaA==
X-CSE-MsgGUID: lP3fM9OjQM6im98SgQS7TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="50866982"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; d="scan'208";a="50866982"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2025 07:13:03 -0700
X-CSE-ConnectionGUID: Jlfznz86TFeMascBY4Kk0g==
X-CSE-MsgGUID: RPRLVypNSC+WjYulokQF5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; d="scan'208";a="184663109"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2025 07:13:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 07:13:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 07:13:02 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 07:13:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxHusD6dOQLf3fY+NHasbcb/MnTzh3jRdSNFP6RW2EDpesGvc/2P58Vt+palDKc5qiBwUVS062R+Hm0rnabi68kmZPLj0eBGvirTNQT6MS/WbU5NgMXuQuV3m0rBi7Y4/kME4VeieWiLVAOvzn0FNQjxO2vW+ENdrOO98B9jg3K0B50hO28fRx4r/RpQsIqWSgPkU8cXqJsIFzhLCpQ73gJC2CHr7h5H1kOhXMgxrjupzVG+jPQKto2tEEUHz6DG2vB5Iux/C8F+Ut42WLmOU38dNC+Gw5QCqsNkrmjPclXWv19oRjGKO/1PZL4/6pFDG1pTwsgyRa/CuWN9Q9t2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzFPCioogXTxvGKlRJVmSmPlHV14n8Pj7qgYjJgljb0=;
 b=LEgalgBAzTHSAi0Nsc9WtUj8kXoX5na/VpgAnIq275S4gz0n/wUWNQE/DdJ0BKvIK+2guT61ZHQaYxJlogPB/tkLebvk3JSvqGF38mxe6yRxPbPwUp8c8Z3apcY/7FaV6gSQ1yVly7MU8UAnktst1RPL9Ww0VLyokvcQpc5/H0865kK+9KZNTAPggz/ggAczfuNDW/Wc/FW3srfOZArvxyvWOcNDFigJPeYSWhkqJSj6LzxgCSxpMhtAhOmb6U1aAqGddRIRxm0w5R7xJ7RNX1SgZ4/D142qadxWyT5B1Avx/BncSeuuuf7Ok0Cvardb6SVgpzJuzWt7L9SgBlySJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7748.namprd11.prod.outlook.com (2603:10b6:930:87::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 14:12:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 14:12:33 +0000
Date: Wed, 22 Oct 2025 15:12:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Chengwen Feng
 <fengchengwen@huawei.com>, <dev@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>, Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: Re: [PATCH v2] mbuf: optimize segment prefree
Message-ID: <aPjmS8gr4CZKOzqw@bricha3-mobl1.ger.corp.intel.com>
References: <20250827213535.21602-1-mb@smartsharesystems.com>
 <20251020120202.80114-1-mb@smartsharesystems.com>
 <aPifDTMMaD2FRMun@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F654EE@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F654EE@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0188.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fac3c81-267d-4ace-2e33-08de11750b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?5+NAUffMc4ah1oIiepwL/cppfnh56+MbHtxlcOfmlQbbbfmwRZbyxnrWNW?=
 =?iso-8859-1?Q?YY7FdKwH7Oo0q9Tvk/sTSkNPC5ohVtU6kvdohppcmn8nyia8h8/BHNoO1s?=
 =?iso-8859-1?Q?9xTLe7VeA56/TDwkLJcgm92LseIVuwjLD9lA02bREnRZ8Oc5WfHdmeJ/Kk?=
 =?iso-8859-1?Q?T19ubUuM5LRGcCDoFHGGJ97TX5u+0LbROJA2jwOWQYZXnR3K5Lsp1GI3he?=
 =?iso-8859-1?Q?xzXGris9GVeSewUnbrdv0zk3UyAOX08dOGJuFfbcxLZZfi8ol0Sj/YP2Dp?=
 =?iso-8859-1?Q?ebEzhFE2FNX8/ZGEgjr+/ZB/9Q6lzqNiLvmkkmdo0hr6ekHZRhUfBr4hR7?=
 =?iso-8859-1?Q?s416+wFhtrFTWQZmn62GWcyC/9BSncFNKn30bxvD0jOZPbnxxi7lb+GXPT?=
 =?iso-8859-1?Q?+YJw4aUTvaG8J1fc/lw8MefMmb8ljHQ5BMUosyBPLDxvivyE+9ioVb61PS?=
 =?iso-8859-1?Q?rj8FUvKkY9VUmmS+pNDb380L0r/2w3IKHvGKHYSQdZDDluPjWefAj1RIo9?=
 =?iso-8859-1?Q?ApBrYwRJEekxKFxPPqTUF5KEPRhgfe6gkMQTNzsFa29hwzbG1+0aLcSfr0?=
 =?iso-8859-1?Q?4AI4F7leUPTvgGfqKqkECm+ZQoTo0FnmaPVHwQ+clQz9fzZQtynQYByQOv?=
 =?iso-8859-1?Q?yRbSY+rYwHgnoNtkyEbbllKvTXgKeeZBytsu+65ey85oASVqmZW286KCMC?=
 =?iso-8859-1?Q?vIEoDHWtKDwlK7jph0csanRkHk1Y5AZRK+Y/hNG/mST2oaLVFAhiyTbLnT?=
 =?iso-8859-1?Q?FJ+2aYhGhdtho454zTgZpMVAaoEJ93C19VGlzpo9LUABQfA6QI8WRwGpeP?=
 =?iso-8859-1?Q?JT6EZQmH+vxRVL9kQk8YOnFxz2Wzlk75++LKIFIQJvvbjzT/OaAVckcvFq?=
 =?iso-8859-1?Q?dnf5X/g9QNkNqJbJr2k7CxDdXuP8gl+12YPR212x5OjH9SEjqk5UHkxdh3?=
 =?iso-8859-1?Q?w96L4clwEm8ahhtFsE1qZrCwUqwUjTyjSCHApX3rByUjumjOrZSBNbtSa2?=
 =?iso-8859-1?Q?u+Kf7yhMHseRVTRXrIRob8C6EC8yyeGMZDOcvJpgDN4KV3GwCZnNHG+SPS?=
 =?iso-8859-1?Q?GnNVLsx9B1ydr0G0eYqRdZHbnfrQtW1Xs1pYpzUXRIZyMFmugMHvoB3ju7?=
 =?iso-8859-1?Q?AKAcBuiFh8XPZ3+07keMjQQTCmeeeNUhMVh3X5IkmftrhP5cAHV/h/Tz7v?=
 =?iso-8859-1?Q?LzIMmR/iJ7amrQgCzAgoYz+P1QKSiyh4mAqyDTmCsx8xQ9QffdevXX/QYZ?=
 =?iso-8859-1?Q?jdjrcYQ4gdChWHDaxJ+iA4RUis6/+SstkgduP7PED5e0iXaz1wCBjcq3io?=
 =?iso-8859-1?Q?GGXgC+fkR+kjxXBnWsK6BFwhwXfRmLPBSHvlCZgZgDHhiczqlmm3LP0MAR?=
 =?iso-8859-1?Q?st96JHmw91JSCdsJ/LainD9Cn2TV1JpEU9Ez/csfNk6bPRoA962QxEt89i?=
 =?iso-8859-1?Q?WMXiMiwBlbWVZApmo/jcnmcMZtKEuf0rIZo6mue6Atd8QHOrJYj0H0EqJA?=
 =?iso-8859-1?Q?XzYmLFNmGZTmdRPsNbgp3w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Q70/Qhv2bLJbw0q4i7EQ0uIdnNVEHviv9r7hlvZ6S7n/IuPSiEiU1SiT3H?=
 =?iso-8859-1?Q?+anih+7EaneqLF73dGdji3G4robCJQ1D+U9o4GLHC6RsfTRnpmXeSfT7aZ?=
 =?iso-8859-1?Q?i5+zpGAgUL9XwmlWpIlofGVs0KUm8OVrJ1xpDEK83605d3MrAZOTUK1ABn?=
 =?iso-8859-1?Q?PBVI4goL22DD5jUJFyKnKQSnwQp3qcAy95JmkwIAH2MBwIzai6Rsa3sYgK?=
 =?iso-8859-1?Q?Ow86OTYtt/OhGwTKDOUJBzXieovdjyJ4es5zP9wZUepoyVLZQfZG9u1Y09?=
 =?iso-8859-1?Q?Xq2rTGt4CpLD9ALVAWZ1h9eQOiCnAlwh+a1+ui/aZ+0gWmQujM+i5qs25J?=
 =?iso-8859-1?Q?I8d2MrCe1eoCfxBM5E56A2VLb0RUgb8BLrAXGOZuAjO07D6pVePHDxBhR7?=
 =?iso-8859-1?Q?p5llk0vxNzKY5Wr1iSz4SMFoDJfPQTJUviP1zEWRleOZxfeo7HDdsNbgay?=
 =?iso-8859-1?Q?MJsjwHO3m4fggGTGqFi4SoDzbaGKMAfFHriS92m22C83Mv3VZTEaVdqmwQ?=
 =?iso-8859-1?Q?5U+sXBIBvRkISWfzf39elpfWm9WfgtCXMG9lPlsmRt+jgXpuR8hvwnICMT?=
 =?iso-8859-1?Q?wcTwvwvAeE83qeyiVhAkWSjc6XAe/pxhfJIkHpmKWcUMkiJy9Ow1s+PqcF?=
 =?iso-8859-1?Q?9MoFNRmIheklhrbHfQo/SlYTanI9rA+mIDwStYuQlEln1bptFoMQuWwMbf?=
 =?iso-8859-1?Q?crBH8uKxkcznbNHsEDAQk/V7bEB8/vcHMqGOJC6l+nuMkm1QYgFva78PES?=
 =?iso-8859-1?Q?hr5bqbqE5xovxVTVIXlAJxcuYAdwAKSjGVDYnJLhSKQAUjH/5UXaiSvlcF?=
 =?iso-8859-1?Q?ZS2ncOEPNBBuzxKPIR7+SL6D/dya9pYbODIBDvCtW9zbBNL0LHnFGjWJOy?=
 =?iso-8859-1?Q?ClETFAsnsFjnt/SH1F6F0KWf7Fbu39u3cHq6dkXa+LWIgBb2XtGIZ9JH5a?=
 =?iso-8859-1?Q?Agp3G/CyehejIuW/V1HJOhP8lkLDkF3z92HZS2wCfYfkHMOG8b8r7eUMSv?=
 =?iso-8859-1?Q?ZfDHC7qu9bHUSgHKjYVYBSI+nMbxAiGkzHaUN8IlDv/4Cog/IonzjgR9qh?=
 =?iso-8859-1?Q?daxzIw14mfzKRjN4x7XE3k8jcxkwD0SyJRiBLVJkAPsCdAsHPfmwHa5Xkj?=
 =?iso-8859-1?Q?yJhzK0/EmELvufOQkhekWJNemgRe+GczJkeavT3hieHn5ETYJFyHZVAcvO?=
 =?iso-8859-1?Q?uq7hZOL7BB5ftnccaA53C9uVpvT6WrTptOApDfLgCTXhlItRj+z245Na52?=
 =?iso-8859-1?Q?VhENAHOS9rMiNn0UF01sA84C5yC7NW1sxzJvRWZOyS9U5sSZCpU3GScxf1?=
 =?iso-8859-1?Q?LJ87EnpMWPdHxMu65/ocf4SFvXivMCZoIO22vnaF6IS0JE5NWmOCxXzvu0?=
 =?iso-8859-1?Q?a2a+qddTCEk6fnOAxuVzxPLJ56DyiiZutCChPaWAteiCXHOQr0pdTJivwa?=
 =?iso-8859-1?Q?QeTTlKGTRCQ/BxZs1ZjtRZt0h5V3jYOLldV0vPA+oAhXXJzVK9tien+qoI?=
 =?iso-8859-1?Q?VuVr5lTf0gH5+fZ/iPD93ru84hU0MLxqS0PIl5CjvNswCdvyToUjf7xVXI?=
 =?iso-8859-1?Q?4AB1TPAevA8PRBbJzq3mO1mllrU0qlMyRvGeF+tMuFHh+Yed7wPQIcH4kd?=
 =?iso-8859-1?Q?c8SwaR0S9AI/vtGMuSpvPsORQiDNe129zm4B34I/vM3lfSoCpzEcdg7g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fac3c81-267d-4ace-2e33-08de11750b0f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 14:12:33.0502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUsBG5Jbu01xOzHi5iWHcX+TXy1vWqCt8EIwAgcF5aFjG6VEElpkA2jEBW2dV7QzYtWsezfWW9yrWUXN0qJEyTqSHUXNm7EerpqfiEmYW1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7748
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

On Wed, Oct 22, 2025 at 03:53:21PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Wednesday, 22 October 2025 11.08
> > 
> > On Mon, Oct 20, 2025 at 12:02:01PM +0000, Morten Brørup wrote:
> > > Refactored rte_pktmbuf_prefree_seg() for both performance and
> > readability.
> > >
> > > With the optimized RTE_MBUF_DIRECT() macro, the common likely code
> > path
> > > now fits within one instruction cache line on x86-64 when built with
> > GCC.
> > >
> > > Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> > 
> > Reviewed-by: Bruce Richardson <bruce.richardson@intel.com>
> > 
> 
> [...]
> 
> > >  #define RTE_MBUF_DIRECT(mb) \
> > >  	(!((mb)->ol_flags & (RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL)))
> > >
> > > +#if defined(RTE_TOOLCHAIN_GCC) && defined(RTE_ARCH_X86)
> > > +/* Optimization for code size.
> > > + * GCC only optimizes single-bit MSB tests this way, so we do it by
> > hand with multi-bit.
> > > + *
> > > + * The flags RTE_MBUF_F_INDIRECT and RTE_MBUF_F_EXTERNAL are both in
> > the MSB of the
> > > + * 64-bit ol_flags field, so we only compare this one byte instead
> > of all 64 bits.
> > > + * On little endian architecture, the MSB of a 64-bit integer is at
> > byte offest 7.
> > > + *
> > > + * Note: Tested using GCC version 16.0.0 20251019 (experimental).
> > > + *
> > > + * Without this optimization, GCC generates 17 bytes of
> > instructions:
> > > + *      movabs rax,0x6000000000000000       // 10 bytes
> > > + *      and    rax,QWORD PTR [rdi+0x18]     // 4 bytes
> > > + *      sete   al                           // 3 bytes
> > > + * With this optimization, GCC generates only 7 bytes of
> > instructions:
> > > + *      test   BYTE PTR [rdi+0x1f],0x60     // 4 bytes
> > > + *      sete   al                           // 3 bytes
> > > + */
> > > +#undef RTE_MBUF_DIRECT
> > > +#define RTE_MBUF_DIRECT(mb) \
> > > +	(!(((const uint8_t *)(mb))[offsetof(struct rte_mbuf, ol_flags) +
> > 7] & \
> > > +	(uint8_t)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 *
> > 8))))
> > > +static_assert(((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 *
> > 8)) << (7 * 8) ==
> > > +	(RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL),
> > > +	"RTE_MBUF_F_INDIRECT and/or RTE_MBUF_F_EXTERNAL are not in
> > MSB.");
> > > +#endif
> > > +
> > Couple of comments/thoughts/questions here.
> > 
> > * This looks like a compiler limitation that should be fixed in GCC. IF
> > we
> >   put this optimization in, how will we know when/if we can remove it
> > again
> >   in future? I'm not sure we want this hanging around forever.
> 
> Agree.
> There are plenty of hand crafted optimizations in DPDK, which are already obsolete;
> it seems no one has found a good way of identifying them. Including myself.
> 
> > * Can the static_assert - which just checks flags are in the MSB - be
> > * simplified to e.g.
> >   "((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) << CHAR_BIT) == 0"
> >   or "__builtin_ctzll(...) > (7 * CHAR_BIT)"
> > * As in prev bullet, I tend to prefer use of CHAR_BIT over hard-coded
> > 8.
> 
> In v3, I have simplified both the static_assert and the optimized macro as you suggested on Slack,
> with some minor improvements.
> 
> > * Is it necessary to limit this to just GCC and x86? If it leads to the
> >   best code on x86, why not include for all compilers? What about non-
> > x86
> >   LE platforms?
> 
> I had already tested ARM64, where it didn't make a difference; now I have added a note about it.
> I also tested ARM32, which doesn't benefit either, but I didn't add a note about it.
> I also tested Loongarch (on Godbolt), which does benefit from it, so I added it.
> 
> Now, as I'm writing this email, Godbolt shows that RISC-V and POWER could also benefit.
> Maybe we should just replace the standard macro with the optimized macro. WDYT?
> 
I think that's not a bad idea. At least everything would be consistent.

/Bruce
