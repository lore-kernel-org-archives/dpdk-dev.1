Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0002CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:40:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C8AA40B99;
	Thu, 15 Oct 2026 16:40:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 10F7840B99;
 Thu, 15 Oct 2026 16:40:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792075237; x=1823611237;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5Ls238Uzx9zKQvl9AzvST8wEPAEOzUW15Avz1dKU+KE=;
 b=YNOe/Qa0pJlCX9QjM6qFvbAgpYqxjPsNXFfKlIvzOajDSlmMiSKfDWrK
 wTe5zVEpTXgxKIQFwaGBNW6VrmqaHrTGJ5bKn/dl8rrlAnmACR6WRPD23
 pcx93A55z4BTwfF83gujnIVS2BbuWmqCJxEFGehJhzPGVYIvJhjpMXwwh
 9ZsMhg/GHFfxvN2vg5Fm7PkYMOyt0rU5u2BCFEXYF+oTqlQD0xjSxu7TY
 QGYlOOLoxp7yBdACXsKC7i5FDVObQCwkTMIzHoUz0j46TRHMd+hBTBPSL
 tJC1ulFwgxtENj3DZFqQy95kXKiBJiImbu1rK2yj8S+joZrsp+g/i/oG0 w==;
X-CSE-ConnectionGUID: WfPv0W4XTeeR4ubXpOK+9Q==
X-CSE-MsgGUID: 08+cK4MmTX+0eBNVLtFq/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="951242"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="951242"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:40:36 -0700
X-CSE-ConnectionGUID: UQSSxEdoTTKUwaRvBY5Wpg==
X-CSE-MsgGUID: +S8TruRCQv6nwTF+CIX6Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1725538"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:40:36 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:40:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:40:35 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.30) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:40:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1jmEgaY+Fx5n6yf5XJpxszxR/mZnpA8Tr5HEKKXAPWI2olTtk49o9pDL10WWyal7TiavOJy2gnJzS5piJWMPcCalAaCxWmIMcZhW5PZvobNwCjrQIoEqVtWDppmuYFdehQZkgdBV8tODoCG6DdMxJKTl5kFJc9d2ItXpGxfqIZUau5dQF+gvJDqeWzuAfPGW6mNuMUSojscZLJ3f+ht4/YeIvsC7s6kkbanD4DXCfKwt55G43Fw1px6e/7oV/aCEsOx/wS9R+jUuOBHWWQNfPvi6tQXMhYVVH2YA1zZNr/pxMk5Eg931OGw/ICMgtIvIFj6v/bMw0P/cdrEPiJRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4UsVGd3Lf7iEAF9k2notssj3Ds4x2dN63zKP7VYRuc=;
 b=ZKhrnZ9GRf64rwEwK7u00Ys/wpZKpaBPMiT/8WjVFa68qAg5pGwxiU3VtBVdM3K977rNYHj1hEx2olzjQdXjcRTf96qjlp7iiGN3B1gxfxGSnXkqHGLV7P7sXg5WrK+ml8/4Y5dJ/IcWAteVd80s5hdAp726AIVYUosX+h5XnX5/dRP+2DeC9aX/nu9WzPJ2ZEGOZvc/p0DpK7tfWTLktihOU2kW4KLTmZm8cKnI1pld9Dj/OETctkp5avhm2YtrEdOMTggrt9Q9VR4WeJ12ujkRpVFMqvqS4fvQOek51hfyEgRb3d/Xf45tiH97VVdFP+TyUArNlQ9YT+0eoHP0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SN7PR11MB6655.namprd11.prod.outlook.com (2603:10b6:806:26d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:39:59 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:39:59 +0000
Date: Thu, 15 Oct 2026 15:39:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, <techboard@dpdk.org>, <david.marchand@redhat.com>
Subject: Re: [PATCH v2 3/3] net/ice: do not include private headers in testpmd
Message-ID: <atDlunTe_r3gqsVW@bricha3-mobl1.ger.corp.intel.com>
References: <35d9aed797cb433296b1c0d53fbda4b45c38e833.1792074055.git.anatoly.burakov@intel.com>
 <ff393eb2eef43c9ab3d27824badda9743e717a98.1792074055.git.anatoly.burakov@intel.com>
 <atDk1fSEoCYA8ZZd@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <atDk1fSEoCYA8ZZd@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU7P251CA0022.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::24) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SN7PR11MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: f5052cde-fceb-4177-475b-08df2aca3032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|10067099003|18002099003|22082099003|3023799007|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: tTJBq2AedwLCLgy92F7XEoDAL+Uf2HCEnAlYSh2IGXPjIqkosgWElKNdW/B6ZOm4fajaz3v7HraTJeiCLj7r9g4MXtDNDv5r+p1yztdyBoWAG6JFWizl4oHAZJL5Czv/4SVsq/mlLPApdvd/5VxtOlq7QRoQPH5ujhsOXUqwbTFWJp19wR0Er6oARwZCsOpY85v1iB22nmq0mUR0oP/Tks58x7UKglptHrBjXdEz77Ww4AQxPp4y+EMGCP//+CmGlY46H7SrrHmh7N/opxdCSunEJJHK1VehVvPz3pFhMi5tQLEQZALehZas9olIbt2xIDWoc4YTGAHTrftzpQ269+2Iq299Ao4a7S548F/C/Px/oTdXkwvd3VDusfBqu2CU3vS7uav0R/Zsj9NTdtC1bOHuuNXF7gQj2yDIJuj/7iqL1gv2eoaO/A4VOZB0UbrV4aY4PxqjddeiQww5ib/j4ZU/U0DF3oUZyMv1A2pXRHKn/vZOd9KGaLP0dVlIRllrMctgcG0GF0PBMTD4r0Iw33c7MzM3XyarVjaj8i+7cA6sfe/uv8sQqNi/Pa+qvriKMQp82XRUeiSPa/z+/rb0/On4boZ6cnOPXwY65I2pIW1aJ3Uk3i0Ukb9QXLJLDG8KtfupjkdG4Jo+dHhJ35/sZ7ywQajukVa3yzsY6xJ1iKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mFoXcMUAObyz99Dvmtsm4qoKYjrZV3l6OEtbPJM7aa4Yl/zatsjPZ1MskjHa?=
 =?us-ascii?Q?19g7SfYv4Tct2KN3pOB1KtbXPz6qpI8n4oYwqhNpBsSg1x6E6EUhVMJE+wE/?=
 =?us-ascii?Q?SGKRPMjJRPsI6c2YqDH95/iw0qMWol9zcQtQywYIsN8xQ8vj+AlzsiC7WTCr?=
 =?us-ascii?Q?NhXJYBiNZQmZTEiyFBL3vsreu9sBdsXMe1aXqiem3WTEI/VMElw3gBcMa+PX?=
 =?us-ascii?Q?bLeP8smo/bVr1klOBYgZzGE/cSbk2umUXhYK3J3gRuQ53qQ0AoW0+APZmo6o?=
 =?us-ascii?Q?HANBKpVwWnYAs3+01Hi6wIhrB/MG1HaT2ksdzEx/I2FRzi7I3n3YpgEOIQia?=
 =?us-ascii?Q?I5zIlKhiYRDhLBfao+iFNFWp2/JCPvJBuq7Gn/c2lZGPyEit+vqGb0XFChQJ?=
 =?us-ascii?Q?wNgENi5wzrEnn8k6FHX/UiOjel/7wsjC0gfVFnYTf/evS9Xt0kms9m49HM1C?=
 =?us-ascii?Q?43GXQpxIC0GlT/4BLiE+T8lQM3nXcnxBlYzKyXTiC21RcHExyg8NBBMdf7LA?=
 =?us-ascii?Q?gi3G9uTAvOQ6IGaLku1pKoStLhuS4RTIVkigZn6Mh0aWtpCH+K6/kjgK7zUl?=
 =?us-ascii?Q?Du2b99m+oralB5wB8J3Yj33BuI8YLfxMd1YglAbH4bwqvK+2CUjAGjIxnr0L?=
 =?us-ascii?Q?PBeoJZDjLKNb5Dd0VPPM2ECh8q4XpslfXVkXswAQrwsZ55sOcx5TaMicEoCm?=
 =?us-ascii?Q?JGWK2SowImEKinDrJYh/cwxRhLZwlrenXi2M/S0vRq1OX8aZUAQVhkW/Jg4n?=
 =?us-ascii?Q?Vom1PmerGMkTiiW8VUKZ16CPPwPcbH5c5cBuCtS3NVcxze+a+zBCtNiLLWQ/?=
 =?us-ascii?Q?VdfttyICOytOqFwHuLu/r/28DeR1P4GDC4JuZ859dM+c/BsbZ5hixQE1fnLe?=
 =?us-ascii?Q?2UdZDp2dqcen1kSahZu1aeLtbU9Q+Qm/lvYOPBA3aaHlbIsiMe9m4Xa1+HhH?=
 =?us-ascii?Q?H3LdWWyIZ0Z/Svbs3zWPbGq8r824aHZI8WffERWVfvY4yLpBbK73i0t9+zcr?=
 =?us-ascii?Q?I7OOhTVfrZxNolq2NcDBwSQnA7PPE0JG+CIehmlKEOu3+6e2dtviHEwonPGM?=
 =?us-ascii?Q?OE/gGqOVGwMgoXV4XNv9KWNnDMuuAiqMrUsbhOWYCPKB1d9xUomy++aiJ1J6?=
 =?us-ascii?Q?eTvkfJsNPLC8QsmzVQ/mYG9/rzLqsMJ3/FCENgac5hSsWNJOtLZvNeAH0jqa?=
 =?us-ascii?Q?Q2EWSWinRJCurJVmNhz68/I3UnuwGxMA0UT025SLw+oo6E8BUhTZociY6EPF?=
 =?us-ascii?Q?MhBd5g5Z95NM8Kw9ZZdspyQg5clk/dG0yX0J57Yoyf7lrjf6XekUcgKLEntC?=
 =?us-ascii?Q?PRak3HcUSRN49dwD+28C/z65cOdITFdWwrnwIzfJdjONK8ojYTEPhLxSwNxn?=
 =?us-ascii?Q?3KcaoYTIPzFHCLNdbO3p54pnUo7IGBD0xbopKYkBUnrCJ5UtQaVgSbF1w0a4?=
 =?us-ascii?Q?0OgWmj+QYkdOiGX8BtTkn0WF8G8BoIfyUNLbHwXFFVr+KvQW4wdlvuRFPksq?=
 =?us-ascii?Q?YG48rpRDYTvu/FudDbPQjzqYQkzL1sypW1TLZU/q8yAdcFB4Cgp/6tuP6odU?=
 =?us-ascii?Q?f3XP2Pv5hF/CGg+WnkSIMN6ZikZAcItZFzbgwge3MxAE0Uw1Ln1C70x7Nd13?=
 =?us-ascii?Q?6xhMDioY7zEA1Vu+jDp5ZIMJEFo7vU4HLRha/J1E3FI7YSpXu8uyT0AoPGr4?=
 =?us-ascii?Q?ZPCc3ohO/q/q1BePIGrBBAKS5t4wcW9be/eMcqjnnwg2byUJrpuAA8rZwymJ?=
 =?us-ascii?Q?lkqCbKppuScxyevukOQ8Y2hYIvJxP/I=3D?=
X-Exchange-RoutingPolicyChecked: xgu/2tKkoYdIlNR2Vzbv7Vx6iiDk8nKTIQFhAnSDPqoiFp2QddI1NSwxYHXNYP9tSVxr5scncbQFMTfTE7dQjFGWVAuQtAIU+aulRhY/7HDc99ZeJQMhAmai2+m2HD0BXubISwq1addwsgEBGRCwG/Iy6HBub6qBx2ymeOp0QkPrE28OjsGI4o3IsEc9D2lK3CF8M6gi5PdY23R5X2JqTnFXCTBSecO0gkGSSn3TgnK9574Z+4P8Bw5UnKL1w2HoHOjop3GKFd9OcmojXCtoNIoeQ7o5txNUBLkRp1MZu8mj/AsoSyvzjpPJTJxpZ5rW4TNWoYfqlBfraRFuijRDpQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f5052cde-fceb-4177-475b-08df2aca3032
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:39:59.5061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwhfE1JnyzxQC0UzpVfZLgbpX7m3BF1UCPI71ahCXlNg6nixXUekTSpLfj+CuaA5MivPD53/of0wjYBxmiZeFdwAx0hmzsBRymhnBjqF6i4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6655
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

On Thu, Oct 15, 2026 at 03:36:05PM +0100, Bruce Richardson wrote:
> On Thu, Oct 15, 2026 at 03:21:04PM +0100, Anatoly Burakov wrote:
> > Currently, the `ice_testpmd.c` file includes headers that are only
> > available to driver itself, but should not be available to applications,
> > including testpmd. Instead, testpmd should access them through public PMD
> > specific API.
> > 
> > The ice driver does not have one (even though it offers a testpmd file), so
> > add the public PMD-specific API header, move all function definitions
> > into that file, and get rid of driver-private includes in testpmd file.
> > 
> > Fixes: df539aaf35cb ("net/ice: refactor flex descriptor protocol field extraction")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > ---
> >  doc/guides/nics/ice.rst                |  3 +
> >  doc/guides/rel_notes/release_26_11.rst |  2 +
> >  drivers/net/intel/ice/ice_diagnose.c   |  1 +
> >  drivers/net/intel/ice/ice_ethdev.h     |  9 ---
> >  drivers/net/intel/ice/ice_testpmd.c    |  7 ++-
> >  drivers/net/intel/ice/meson.build      |  1 +
> >  drivers/net/intel/ice/rte_pmd_ice.h    | 76 ++++++++++++++++++++++++++
> >  7 files changed, 88 insertions(+), 11 deletions(-)
> >  create mode 100644 drivers/net/intel/ice/rte_pmd_ice.h
> > 
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Given where we are, this is probably a reasonable solution. However, I'm
> also thinking that maybe we should have a discussion as to whether testpmd
> - which is, after all, for testing PMDs - should be limited to the public
> APIs. Is there not a case to be made for allowing the per-driver testpmd
> files to access the internals of the driver for testing purposes?
> 
+techboard and others for more input and thoughts for the future.
