Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F882CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 09:06:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39DA44066A;
	Fri, 26 Sep 2025 11:06:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id D207C4042F
 for <dev@dpdk.org>; Fri, 26 Sep 2025 11:06:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758877576; x=1790413576;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=OPXEApRMkgml27mPxaP3HjNp9yqY5Yi8ueMGc5487k8=;
 b=LdgRZGQcwp9pzB8i+X2fvXbOlkUhbso9BSxRO5gYwouhLr21VdjFuNYC
 XhE7w3HYqAcS2IVhX2fePbCLY3y10/SSzGPBZA/sNGc+cZzKVjRpAvOF8
 wA1SGHsju4bJYpieQxz3WL+8OfXt6mEKqNFJC4BJEBGELxzY1wOlZKUh3
 sJPMyLsmXZTDx0ABpFNdWCUyXqogsK7OsKuSZtcKWgv6NPcNLKISDAK84
 aSos6t6pdOkebC+kLriwcRao3W+rB91Cd0kL7fDOnzRoYKIC1mHkrbYj/
 at4sZElMwzPbYHqovDKj5sxyDOmDaejJmKKDBDS4WUDO0sUPQSfppr2dR Q==;
X-CSE-ConnectionGUID: Gf5WQckZT0+UjprOyA1DuQ==
X-CSE-MsgGUID: V+9mJOWvQI2calGguzyLBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65020526"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="65020526"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 02:06:14 -0700
X-CSE-ConnectionGUID: VZ9AlcYbSbmxUtpm7DRXKA==
X-CSE-MsgGUID: TKYc1vAFQkaKD9Ozx0aKUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; d="scan'208";a="177954127"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 02:06:14 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 02:06:13 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 02:06:13 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 02:06:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWWwjM+7IFXLqAuMmVLwhNT9UDSxqRYJBPqCYLcgY0nBr+Q4WwKtrB/WVwwUFyhZQlT8RM16RGdmVM0rAKBlkyBd8tSXtWTyBQ1Oh6Tq1ttIupoTdvkA4aBWfNuqhFYcRXP/lhsvy579zsYbEEXmdDoaLc+yiZw3Y2E/h4MKewfskK0Kfjt8DdPaT5L7vwB1eRSJavpACv0K6wEsW2+plrPKq3sqT7SZuuIV5+a8VQCfj7X1RwRXnYb68V2aKv8k3Mvzbd7dJtEvGYkqZ4zQOCagHisnYRNEJXJfN6XHop3xR/VL/P6ouUj72UzZ8VBtH96iGa52iipu68hqCfqUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sm+OWDueS8femYmH7iMTPZP5ff0/zlp9J1V1hHbj/M=;
 b=hcry4wKjjYkt0t8IU2L/gJRUjFdriDP5PzEvMSRi2fE4nnn7RPo2YhHEBcOvSddekJwXfxYgnn8Q9XOwajC/5rJsqI7KttUYmEsSP4ICY4h6jKDcgMnouBwsf8MwqCz1UVJesVgE6ZoQnazHqifWDXnWmc3Rv96PyybRioM1O/GV7TN0QkGzvrygmjgEJ89T7T1Qv8fEEAjuwZds/eRUE5D553ODgm1lg4xnHjGsBbc9g2paSWj1TSVOjAuV8X9Ijd60+hWW5+UaywFfSqhVgSkU3J4ix6BfDUwSgbBFzWdBUJE+GhRVf56KJi5mFRxiseqO45h+3BgP/OEjT10uGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB5199.namprd11.prod.outlook.com (2603:10b6:a03:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 09:06:06 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 09:06:06 +0000
Date: Fri, 26 Sep 2025 10:06:01 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v4 6/7] buildtools/chkincs: use a staging directory for
 headers
Message-ID: <aNZXeXui-n59iRAb@bricha3-mobl1.ger.corp.intel.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250925123150.3063298-1-david.marchand@redhat.com>
 <20250925123150.3063298-7-david.marchand@redhat.com>
 <aNVV3PwL39sY-W80@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zjD5M7DDapTZfjCzusm-w5ufBJq+0C3wkFeKt5o79rGQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8zjD5M7DDapTZfjCzusm-w5ufBJq+0C3wkFeKt5o79rGQ@mail.gmail.com>
X-ClientProxiedBy: DUZP191CA0043.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7c2cbb-5824-40f4-1779-08ddfcdbecfa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K9bC3ebNvh2wBSsbNqeNKL8C04C4IY+kdFjz/DMOaYrynaCfTQFLxWNu8z9B?=
 =?us-ascii?Q?PNf3UbXSwgx+zf//JPY5F0WtN+Snk14hhfkxS/EMSkBrxnb6zZg4iwqn8ghe?=
 =?us-ascii?Q?PS+0Cs//H7w5QfKFR1bvgNLt/6N3itM2WItQLfDsHte3cijbC/iHfvQ+tII8?=
 =?us-ascii?Q?mM3lcio2gwHtM1mCx31G7feioq0WTLnxhZTxD3qe3JQAc8ax7J5I451vPIZ/?=
 =?us-ascii?Q?yV9Gh0q/PhiXVUYSp5n5bdEoyn/lOOE99wWm2xSB3ppcOf/pk1hHXcpvPOIf?=
 =?us-ascii?Q?hs/oQHAs94UvBZB+Pe3qPqpeWzXRqJerS79MpuFmO7XWsnuAAKcoFkaYUUZx?=
 =?us-ascii?Q?hcUI9ey3ijFtg65MuC6XkCO2wkMd0aFVOQqbd6MlEQ+KU5CN2u8IyfZKarCZ?=
 =?us-ascii?Q?38iCa2ltDzVFAvGLZ+iVgY2oesAoBXS8xfEyrClnG8TKF+j016nBuuIJdRqU?=
 =?us-ascii?Q?pWMBt7gBY/W1K/RZFVK5KMNFaMqiY2CALa7xy2W0WyKGWNivOKZ0uAxCSkmu?=
 =?us-ascii?Q?eLacV/CQE1i41KB94xnvD4b+3wup/G2C9/sJBbPxH86ymQ/w3Ly23XPAC73E?=
 =?us-ascii?Q?j865UDOLeWkviZnBLbxj0+VB/aIrcRl2OK5VD6CRhnND9g5az2mAp6n16pSu?=
 =?us-ascii?Q?PeQ38zFvUaVeREpVswGzh0dAcJCbkDNDXInp4q5N8fJGY1wkmDM/tu5/uUzp?=
 =?us-ascii?Q?m/hU3VFPHSQvRB1dxgJt/76waZZ1GQO8Dmuh1Kre7RkkuPGih7s7DpyOl/CF?=
 =?us-ascii?Q?OXVo6MDH7gTAtxHheyrH0gfJIJ1y4Tx2XL0XUrpEe9iYQf+TIqm0bHHANusi?=
 =?us-ascii?Q?1LtM2XJUR+TmNZNho4b9lM10Ifdk3TFluTfz3Ir82wqPRLspXWMq5pKq8NKD?=
 =?us-ascii?Q?Xh9LHXexg9em2BlDETkYpxZczaLwZoxhEzcdAcbxNSRoVPCmSDpv0DloaW22?=
 =?us-ascii?Q?Bz3UqUqCykCQo7/pZGxZRhUOv+aETwADvCLWCWPe7XYO2wAGYRnT2oa5vc3D?=
 =?us-ascii?Q?B/8g/eyApXlfgixtz6WopFli+OtPuOseq7mmqb98dAsWF00L2cIebWPh5/K2?=
 =?us-ascii?Q?KuYMx8f1dlJzs2kIu7cFzMfJvjagIt2Dv8zQhlJCbKJ/esW+fY5DeG6mRmKl?=
 =?us-ascii?Q?LkeTPrkWq7HabZhvBAk+e1HAR4+YpmFEt9vJVeGdlewY8zCu3ou0X2pj+RWv?=
 =?us-ascii?Q?X9+ESRRIDOi/VUr2IlO/A0FsPRv83GkF6XoxM4a1xTgGFxZ0ZeKhMJWFCfOW?=
 =?us-ascii?Q?3jx1L0pdEAIGm22FooDEQiRnG00S+IYn+c1hAZFO7RQLBh4BjfO2BSleFkd4?=
 =?us-ascii?Q?LmKupBxKNR62WVvpCzqZu5HtjLE7XhYls6PSANLMXr7M1laAKS5NDHlkArTT?=
 =?us-ascii?Q?fWL7lR+tCsiqDAzSCvhCqtV8rp/nPlBiLiVtUMWS4F7Tcgfc+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w34Sv0QKKBmsyE+MCCwX/4UqcFN0j+SE6ATISO643HJFwcYwSzNflht3tctJ?=
 =?us-ascii?Q?7ypQbJV8Z5cbwpcc76lb7arabX8yVsp1UMGkijZQnrriwV+njH2LwWHS3F5g?=
 =?us-ascii?Q?aLxkVLQjOV9+Oc9BAKh6tNxodXAXLTDH369reu+np7CnfhZiCBOsM3AOWpBX?=
 =?us-ascii?Q?8PH0oKVee1F/IKwb1EkLTMl5rQV05/6qmBdfZsm7Dv4v24qE7eoPLg9VTOWb?=
 =?us-ascii?Q?XlIkOZOX0oiwb6pcKI9C6Xl2SXbo2ZIKcs+FCCfPfRbGzjj8AtASe6uxLUZD?=
 =?us-ascii?Q?3kTBDvEeGdNJ0UyX6kHWEuWPXQ7szfVy/I1CCayHYCOxNHzIV0P/uBXR0G7M?=
 =?us-ascii?Q?x1nGli++rhs6eJgBiJTYpoAssSXaymF0c18JJyTRNJk+1RJlh3bGA1ZezLAR?=
 =?us-ascii?Q?GuwD3uwIx9gNrVFpIoBVzbBu0FFxTR80/s5A2NEEByNnr5J8LVuAteaLoOHY?=
 =?us-ascii?Q?YcvIK3FHcOfkPouc5VAefSLOweBLGKiUT1lu+uB6YgYwtuEyAAZGbS2GsbrT?=
 =?us-ascii?Q?XhrTexm1D2uN5kfV06LjcEzwoYM6Piy2UdUydC3d9FaQJx5h59mJZiC9TmAg?=
 =?us-ascii?Q?vhsZMWoMassQ1F6tahQJo7MvlPk6Fm5yFX/BcpJ8NtUCrkQyUMKffnkwmucA?=
 =?us-ascii?Q?1iDjWstN2AzI0DrSg6RilFRyHe0wXgY++7UhebcfbW6BlG4zD4rx1vxVfiHd?=
 =?us-ascii?Q?Vl0M68aWsX0lplgZ4c///ocdM5NACfx7vWvPrlRsPXWulUJXj7+qoSJYxUo/?=
 =?us-ascii?Q?343hMz6L4YCZLhR1wNiPwX/LaCAEvYq0ASZG/6GTnOy5fgdASuginqtMH2ta?=
 =?us-ascii?Q?YYcqImb0yAT8zlmnbfvB6DtCs5mgHa/cA2as2e8J+hqFmwPqsezHwhXsdjRN?=
 =?us-ascii?Q?SZzyPnrP7egrn+f6iIoO+Z4L4mJ/uiG3QyVNhTNTiwvkFczJEGxx7hePZOFA?=
 =?us-ascii?Q?5h6r3U4sdi+X1JF+OhCOdieBdyafOVnqqtD4oepTeeW21qQzUSYhXGK4SgmE?=
 =?us-ascii?Q?Onrsjx29ULmYMe1pheN+G7lQj6ItGl73Mj/S7l/avHjz/P+MdEkmv3geRafz?=
 =?us-ascii?Q?TqfW8rU+q9kcJusQ661gMudRPP52NUZK+xlnjRrQqg9mMDbdMOj5wB47nC9y?=
 =?us-ascii?Q?qeITrENd/ki0xoMk9XRZiDx2eInK1/9byNpukT4XAmYwkon4M3Pk0YKpgvcf?=
 =?us-ascii?Q?vL6KggeptOrAxXtx63Ur+yMGByPuhOENaAAQ0kzEiUwMtH6V8+hTULL5J1Dz?=
 =?us-ascii?Q?zGL6GybBx3a7qc61fZW2ub73oAE+0j3zM8P3izbvC4zZNz9E2/5h5uSWmLfV?=
 =?us-ascii?Q?7aH0tKi3vzTV6iPtnlOC6MSZCIWMhazFoLdWke/dho9IOwyTmtPGxkXoT9wh?=
 =?us-ascii?Q?wrWjWiKSbrTaXNlMgqVSmfws31zrSQ02ZVGFb/X8ttwn/ASoBaONQ0YzKrrT?=
 =?us-ascii?Q?QPWpL7vbwPvrSaybvyxq2D4/Pe4eIkBSoEhmJdxWKA86k4J7wMKPNT9hidui?=
 =?us-ascii?Q?yeFJoBzN0yJRudmcEWTEXqZo3tL/X/t8DpCarq5oVHT1roRp1cBnKPmmpzkt?=
 =?us-ascii?Q?FcwAnE8hxZkk1basxyyf7ESX0XO0tytjLxQyU9BUIu0H1nnouUwXvX/Ke+8F?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7c2cbb-5824-40f4-1779-08ddfcdbecfa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 09:06:06.2627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xenHAiteRWw+OKcthJrEut23ljLVBgDzbufu73PRMLW2oTiDszYyWZC3hv1RQvOimexCRsaMTGE8lZ5QoTYmB4YmBsx4qY8zH1jEho7yy4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5199
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

On Fri, Sep 26, 2025 at 10:14:31AM +0200, David Marchand wrote:
> On Thu, 25 Sept 2025 at 16:47, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > > diff --git a/buildtools/chkincs/meson.build b/buildtools/chkincs/meson.build
> > > index 49dbc55254..376556f5f4 100644
> > > --- a/buildtools/chkincs/meson.build
> > > +++ b/buildtools/chkincs/meson.build
> > > @@ -12,38 +12,47 @@ gen_c_files = generator(gen_c_file_for_header,
> > >          arguments: ['@INPUT@', '@OUTPUT@'])
> > >
> > >  cflags = machine_args
> > > +cflags += '-Wno-missing-field-initializers'
> > >  cflags += no_wvla_cflag
> > > +cflags += '-I' + dpdk_source_root + '/config'
> > > +cflags += '-I' + dpdk_build_root
> > > +cflags += '-I' + dpdk_chkinc_staging_dir
> > >
> >
> > Two minor suggestions, 1) should we not use "include_directories()" here to
> > pass these properly? and 2) would using the existing "global_inc" value as
> > include path not work ok? Is the reason for not using the latter the fact
> > it includes too many source dirs?
> 
> 1) include_directories() requires a source directory to exist, so I
> would need to keep almost empty directories with minimal meson.build
> in them.
> 
Ack.

> 2) Indeed, global_inc is not usable as is.
> 
> meson.build:global_inc = [include_directories('.', 'config',
> meson.build-    'lib/eal/include',
> meson.build-    'lib/eal/@0@/include'.format(host_machine.system()),
> meson.build-    'lib/eal/@0@/include'.format(arch_subdir),
> meson.build-)]
> 
> global_inc refers to the EAL sources, so anything in those directories
> is reachable.
> There are a number of non exported headers in there, like
> lib/eal/include/rte_eal_paging.h or Windows specific/internal headers
> in lib/eal/windows/include.
> 
> I can split it as two variables.
>

Ok, thanks. Was just making suggestions to try and improve things.
 
> >
> > >  sources = files('main.c')
> > >  sources += gen_c_files.process(dpdk_chkinc_headers)
> > >
> > > -# some driver SDK headers depend on these two buses, which are mandatory in build
> > > -# so we always include them in deps list
> > > -deps = [get_variable('shared_rte_bus_vdev'), get_variable('shared_rte_bus_pci')]
> > > -if dpdk_conf.has('RTE_BUS_VMBUS')
> > > -    deps += get_variable('shared_rte_bus_vmbus')
> > > -endif
> 
> [snip]
> 
> > > diff --git a/drivers/meson.build b/drivers/meson.build
> > > index f25f425565..dae1e83ca4 100644
> > > --- a/drivers/meson.build
> > > +++ b/drivers/meson.build
> > > @@ -245,7 +245,31 @@ foreach subpath:subdirs
> > >          if get_option('enable_driver_sdk')
> > >              install_headers(driver_sdk_headers)
> > >          endif
> > > -        dpdk_chkinc_headers += driver_sdk_headers
> > > +        dpdk_chkinc_headers += headers
> > > +        dpdk_chkinc_drivers_headers += driver_sdk_headers
> > > +
> > > +        if get_option('check_includes')
> > > +            if headers.length() > 0
> > > +                dpdk_chkinc_staging_deps += declare_dependency(sources:
> > > +                        custom_target(lib_name + '_header_staging',
> > > +                                output: lib_name + '_header_staging.stamp',
> > > +                                command: [stage_headers_cmd, dpdk_chkinc_staging_dir, '@OUTPUT@',
> > > +                                    headers],
> > > +                                install: false,
> > > +                        )
> > > +                )
> >
> > Rather than using an external script and custom target for this, would the
> > configure_file() meson function, with "copy" set to true also work for us?
> > https://mesonbuild.com/Reference-manual_functions.html#configure_file
> 
> I don't like configure_file().
> Touching any of those headers will trigger a meson reconfigure, right?
> I think I am not the only one who dislike meson reconfigurations that
> pollutes your terminal a lot when you do many compilations (Thomas?).
> 
> But let's say this is acceptable.
> 
> I had tried but configure_file() won't accept outputting to a specific
> directory, or I am doing it wrong?
> Trying again as an example in lib/meson.build:
>         foreach header: headers + indirect_headers
>             configure_file(input: header,
>                 output: 'staging/@BASENAME@.h',
>                 copy: true,
>                 install: false,
>             )
>         endforeach
> 
> Gives:
> ../lib/meson.build:221:12: ERROR: configure_file keyword argument
> "output" Output 'staging/@BASENAME@.h' must not contain a path
> segment.
> 
> 
> Relooking *again* at all this (la nuit porte conseil), if we tracked
> headers in global variables, for "normal" headers, arch headers,
> generic headers and drivers headers, all of the changes could be
> isolated in the buildtools/chkincs directory.
> This would also make it possible to factorize install_headers() calls,
> and avoid drivers doing it behind drivers/meson.build back (I spotted
> one).
> 
> I just pushed an experiment:
> - single headers install:
> https://github.com/david-marchand/dpdk/commit/headers_rework~2
> - chkincs rework (still not using configure_file):
> https://github.com/david-marchand/dpdk/commit/headers_rework~1
> 
> WDYT?
> 

Those changes seem good to me.

One final idea/suggestion (apologies for the many suggestions here). Rather
than having a new script and dependency tracking for the header copies,
would it be easier to do the header copy as part of the existing C file
generation script? It's already writing a C file to an output directory,
would it make sense to have that script just copy the header file to the
same location too?

/Bruce

