Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C30C7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 10:38:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5BFE42E5F;
	Thu, 19 Jun 2025 12:38:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id B92834025E;
 Thu, 19 Jun 2025 12:38:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750329532; x=1781865532;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=L6LUYdCvLvObyv3uV2+/S5CAwkOh9Q0dtrkPFTC6VOc=;
 b=O0f1D2fo1cxVt0bgDeVfYwwwD86+OQyNJEKxR9ne7vW+qbv/tgyFlpTX
 EbENx2LRWhWxT8m3KxFpwq9lmUwjhWrDFDYwtI6Z4B9flu1Am7z0lVUn4
 KZnMRIdsWadNzoQ/QNvdMkSH6WvCUb8Ng6RMfM/w2fBrXj51DBrahCY/t
 OwfxAXCy4PYlRKfVlynfmKTva9+v5o6gDysVEBIjkNhTwWtPtntYt14yu
 Z92ryMkTHNlWXe+tOWtYl11gbhA6uS9oDUiZT+mWtLsEmWsbtrLF5NRF6
 XpcmUfS5Zvz6TryK5HsJRe3Si812YL7EaRi0sVToXfhv5NKIpxHcW557f A==;
X-CSE-ConnectionGUID: 47EsMLXER86mzdj7+ExvCw==
X-CSE-MsgGUID: KgSedhzaSLaAtA4ln7QBtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63619810"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; d="scan'208";a="63619810"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 03:38:50 -0700
X-CSE-ConnectionGUID: EjXEAGCtSxa4dTsL4B47vg==
X-CSE-MsgGUID: WC28Wa1iSDiyWOzc8uyudg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; d="scan'208";a="174189403"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 03:38:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 03:38:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 19 Jun 2025 03:38:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.72)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 03:38:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChVpDF2pYKrgXQAOsSrGlaeseFDkr3l2/kZtktZLMqdhSO0rr8AvPoDzdtQdnDFhje+lfFsGJA8Z5C95YhwBQtTIgNwBMXkPDmT4F/86pK8kpl3+voP7IbS3/7SpHkaX0yCBmlWnuXTuyTugnypJha3xNmX3rcf80L9fijdePGnfjwyCwFKPWC34vUV5pjuROYgzGeb15lLZcBet3QOa/SQ/xPesCWgYIF5QJdl77bv0xVgnmLCMIEFD74jWyZOrBoJP0hRCj4RlXt02sKtZWSZ1VHwd3l2ReCe/uBzeZH8j5ju3biHuQBIdjA2b2Xo2Nx34JS+ayXqhFeapzCn1jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIcyGn/KZCb4EBv8nH3ACqR9l3qxjb+3J2/La5wWwg4=;
 b=iL5dxOshemLaP+UqxURdojmeHEqMsXJUVkCOTFSNiJ0s7xFb/XyWEXcgi4e63Nuu63MGYflzrHT5JWRjDSnE6k6QrVYda0u6o2/A763TAWJWJAYDMzRm9KOC0k+egjXNOnG9e5L5mjih3WRGm9weTEtoJqQ+7vD/kF7vy7dApMwcviAExKFTEbF+pWswnHrmHMU/O0jh60eeFrBMfaNtwrMpprf2GuMvopbw8JhO8BwRpk1Q+Se5wHvEK0NXb+32rsCv6WopfyCDuECUvkSEyfv707xOFbLa22acetZkjUhxTn3iuweStXXVoOWKyUahUJdYRgAeENL3IXwqFai8mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Thu, 19 Jun
 2025 10:38:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 10:38:45 +0000
Date: Thu, 19 Jun 2025 11:38:40 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Mingjin Ye <mingjinx.ye@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH v2 2/2] net/ice: fix updating DCF RSS hash
Message-ID: <aFPosGxr4YCulx3w@bricha3-mobl1.ger.corp.intel.com>
References: <20250611095058.114465-1-mingjinx.ye@intel.com>
 <20250618070844.174484-1-mingjinx.ye@intel.com>
 <20250618070844.174484-2-mingjinx.ye@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250618070844.174484-2-mingjinx.ye@intel.com>
X-ClientProxiedBy: DUZP191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec2f30f-ff8a-4b58-f01d-08ddaf1d7763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LHMXm1R+idNUHLDmmA+XF3/dCpv5ljngEQLe22iKtBMLhTxWeVujpCVXG3VK?=
 =?us-ascii?Q?QXrPDzN1Nb8DZaAGSM5BVgkVomDZqOHH296cy2sqGzeKI+ENQWr26GLsCBJ+?=
 =?us-ascii?Q?H60FVvFi9zZoe1/Xq9c4dDB8MBCJOP6Gn2b5nTNb6LLOXH2ixrc9dnvuAT/P?=
 =?us-ascii?Q?kL+sPFVStjhmie3ByWbFOmQm9etqzpESWUh5cXqLyMaApDnJSUg1GLwCjqUP?=
 =?us-ascii?Q?pALnT63K/rhaVOLEi5Z/B9/3aPjP/WMBtcXDsLuFLu8fbTJ2kugDgBbqzeYJ?=
 =?us-ascii?Q?fnt/MglFmrSOCWAN5bYKfcByTST9kqMqHIZWJiliUJlk3e7qorVDxX3ol4VO?=
 =?us-ascii?Q?QtyT+qopM2jlZNV9ci0S65pmLFE3syC3pWjMptFojimm9u4IFKNlsU9TUt/S?=
 =?us-ascii?Q?iLixdA7OBvP64Ltc6CncSFc4lz+J2zEy4Gz4f4CoO3Xy9b0ya14F7RisrDIe?=
 =?us-ascii?Q?UyfxriMWoPN5vGQFon/CFLk5RGAlVOIE68cl8I5z5lES5gVkFE7DtW/PX+rU?=
 =?us-ascii?Q?OMvAdWI1mWWJniVFFHrp19swz30R5QuXaeOzwrb7nG2vVd+Pd/xcXP9DH5/B?=
 =?us-ascii?Q?T4/d/g1vnx6gM5n2vY+UNewH1wJoAgNXKM7pRTvTdWcBL7CtgT+fYxT54jhn?=
 =?us-ascii?Q?4hKB4Zg7zXVaMeUL3YKuwELPT/f/hcZ28JCRm072VEeW2Dywp5Y3x0r1VzT5?=
 =?us-ascii?Q?UXMnMT7dmR2w3FvprRReQ+1rNqWmnMYJIRQnnMeMDMx7l/qTYrKYf45sqrFW?=
 =?us-ascii?Q?OTzrWMeSmkOIz+V3s/iaysAAFF2GZb6zhGWgu/2y40QPwHa9HZsTW+9VZTdI?=
 =?us-ascii?Q?3Y9ZaYojF/EDFntrQ9f7NuNvttYg3o57FbCnybu3VUr0lrauSiWhWbpIbTKB?=
 =?us-ascii?Q?8qGNaLuaUmqqOyIqL2nUUOEveZS6k8+z2kadp26c+fRvVNTvMR35ayCvOwC6?=
 =?us-ascii?Q?rfp8Gdx0fAGxsC4XoBF/hPb2uOCshcnP2y6EVkMZdDMJOqb90lrN11Fvix7u?=
 =?us-ascii?Q?YVDolfUiVTlak6bu8DDOCNMk1jvnO/KmQHB1ERcva/FO9ramHuI0uG9YwL6f?=
 =?us-ascii?Q?TgevURslY0G5Q6dYcwdsI6NZ16JjNhutEA7XuJ9CN/yUwCS0VzWOGvX+PHL9?=
 =?us-ascii?Q?GTwHlKmV7GQePVFmepdk7+Xd4BKmKlwoXRO04GE9HOZ6tEWca76qFpSvKK6e?=
 =?us-ascii?Q?3E+BE8w4X8lNYo2a704LVYhUbBw2/ERd02iCAbj4Yc8Zn9TItWb9XAOS2t//?=
 =?us-ascii?Q?eeOu2yZLCLk74T52WLdta5sLhsC9drGKSrdwUxwcHX9hYtEzHliTiM4ASfR8?=
 =?us-ascii?Q?YubTi4dwn7HJULLY7MFT8Qsu08XNIMVAUWdcpuWUsQhkNbzmVBONfFmAZxO0?=
 =?us-ascii?Q?xiL5LZRYsdRDM1ICuDwzl1QWeSRkwBSuRSwQ9+3ywbYaCx0Pjw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v2TdUZQm0F2NO5tTOZODThA6K8riJK0hCjsx8vp51DdzH0vdjC2KeWB/XT7p?=
 =?us-ascii?Q?A4EjGmi5nn8aCnR3mSWgup6Uiyg/Ys3WmANpxmDvqomHxcr/KqxVIiB9gnHY?=
 =?us-ascii?Q?qCgAJoJwW4hrkibJa4zSKaH7dLD1deX2kiI1BFrhfcA7ZjQTyXK2KcsDhV9/?=
 =?us-ascii?Q?ZtDCBALEJ8Un2V+br0iE8+f50buzzFv7Tgwwzanv4z7B7BtRRaVJpwJmFlfN?=
 =?us-ascii?Q?Ev3B+fSuzKOnptkCEgHgxith8AQIsWavDAX464FTPS9lU3k4RAvB9vTdxCzp?=
 =?us-ascii?Q?k6EwBCPKpIHtlOTtlX/xHq5QscSBFk+PqNxcqsvSl5f0pZeI16YWDa2RYUXz?=
 =?us-ascii?Q?BOMnosLqC8z4+9SPyX8EE6idQKIzJd0U8bdaNBGiOYzdlF3YkTtTEmNC37HI?=
 =?us-ascii?Q?XWsJjdZWMOEKVgGRG5b7guNLwqFdsNkwKQKzU/uuBf5MPVIIpf8V9Y8ch+jF?=
 =?us-ascii?Q?tflF2esnB6xDjrLVu+dRVU4N7scYt4yflLSzXB1yzDb6vXOkN03eKQ/FwyP1?=
 =?us-ascii?Q?Qn91VPMXiemlTZ5oRl/xOPG7qo7xrBUBTYNLV0GEBhbIdNYyIFoZvsW+1GtI?=
 =?us-ascii?Q?S8fmBsPZ4kJjf08s0bZ/wBOTK+czQa4I/zZgV0/wkQ4uxL6oKnW7p+5gHMkb?=
 =?us-ascii?Q?7JY9c355lgYAFEsML03+n0/R/jSZSCFb0RVi2sfDjDsB/a9jsqZ//s9wKDAQ?=
 =?us-ascii?Q?tu36HKf12Z2vnfO1+aahEc+UqnKqiboZOgUVGATbNEAoxnt/U8ERo6rOhr5g?=
 =?us-ascii?Q?nvcal5pGuuF/yAVPtcAG3z6N4V88XwaG+07moUZGTJoCE2/Xfud4m+QKyrhv?=
 =?us-ascii?Q?6gD4xeenpVpN5ltYwis915R9/4haCIpZeOL6uIVocNdZ/XPyY7sBRV3LpM4+?=
 =?us-ascii?Q?EvZYnU3tkBGB2IlGQQxQqnj9n0snDR3emLB8Qxyqrepa8n9xgbQzkI3ZS41u?=
 =?us-ascii?Q?ykxK/aSGZvLmS2kubjdVMxyh3oz1JEtmNwFMrm4EJo0sfiV5IBeZ+U19kDW8?=
 =?us-ascii?Q?PxWnQlH1ONkPQrgFs6APUpY7QNiNH/lah+qKGCj//KwRKDPnY+AHQ+5HUpwo?=
 =?us-ascii?Q?RPtl7/Jnud/QzmnwB4ZAqD0yokiY9L4fb/6QE/rG2BDMvF+kWhT5UgAO13RQ?=
 =?us-ascii?Q?GUc4tMyVbnJPFmFFXGF3doamvtP2086cMYbSUq3H6A1sAUuMQsmDbIkc3EJm?=
 =?us-ascii?Q?OM/vUbqRpttBzQyGWKf0vlQNuQ+e1m/FO6Th8vZsCEjwrHSxXjzt4hz6EGeo?=
 =?us-ascii?Q?PvkVN4VMuSymOUEUPlpfbacSV4rJtWu8REJsJm5k9BID6YPiZyYuEEj04sJy?=
 =?us-ascii?Q?bC9oiydW5wYdGJGHxOpmMENEHtl/S3juH/CYB+cd8LlkJ3RpREEUYzbBsFjq?=
 =?us-ascii?Q?GWvXrxSTPD19tAysBbIj6V0jP3MxV+WN4VkL3zGUG5/bfeQ8PyyFCBicP/sN?=
 =?us-ascii?Q?INIKYEbuMzbTQBGCfwyldy1nvbA7bAkTeuDadXih0KSa7lMzcC7RhCiFIewR?=
 =?us-ascii?Q?4tAyfuWx+uKHuv/S5pgSHXmzoqztchngpBxw8sym6IEcbAqN60onTbNghYYi?=
 =?us-ascii?Q?gHjRf4sXpPjCXpADOgG0o2v6oFjHGP4mFkGPbX0Ijvgt9MJaIQtwa0Ryviyt?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec2f30f-ff8a-4b58-f01d-08ddaf1d7763
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 10:38:44.9357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsLf5nHV2/wa/bhs+yH3lErfR0u8uq4NOPLKYZPneX5hWdAKS4iiJ5VzuvFsIJ9Ep4kVTzEPl13PY0VoYXusvckRzFBcDGt0fh5u0tXQ3Cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7704
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

On Wed, Jun 18, 2025 at 07:08:44AM +0000, Mingjin Ye wrote:
> The driver does nothing if the rss key is invalid during the rss
> hash update.
> 
> Extract the update rss key code from ice_dcf_dev_rss_hash_update to
> ice_dcf_set_rss_key and make it consistent with the pf behaviour.
> 
> Fixes: c223cadc9e5f ("net/ice: support RSS hash configuration in DCF mode")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Patchset applied to dpdk-next-net-intel.

Thanks,
/Bruce

