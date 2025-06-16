Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E39EC71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 08:27:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD09840BA0;
	Mon, 16 Jun 2025 10:27:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 5D5364067E
 for <dev@dpdk.org>; Mon, 16 Jun 2025 10:27:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750062466; x=1781598466;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=dwwG5WGGgPVp/kLCCuNuD3ddHRR+YfU322N1BggZZTw=;
 b=KQd3fjA+HcRdKVXGAxQ1ltIO/fi+QzzgLCYEeIKYilP7lIb12YaPrjpp
 sp1vg41Db1r/PrCp/En7swn+gnH10eIp2i18t6xvBN+Ir6ABqDYQPBK+q
 GcZawkNnxtQnfm6NSlW0U+5AXntDkT6fYQXHu45ZmwnWzS8P4nGKwAPjV
 TBd4mhob3ktr6XDkOQjAIm6yky75c2tJzqL7CYhnJ5HVEJ9rydGXeFquA
 KkdfMiSAV7XU+CJuixjRb1XYXkMBDEL0dikEfWMZ/VwRsdwH6PVZgsS1F
 H0dg3TUn08j80S2UvTxb57uMOFGAg2TVcj8YLXP8TXgJx2xDalFWjmu4m w==;
X-CSE-ConnectionGUID: HD6fNOrkSRCHkqHPOkfPVA==
X-CSE-MsgGUID: E/wf0sIgRBu3PIhnOezVrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="51424032"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="51424032"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 01:27:23 -0700
X-CSE-ConnectionGUID: LxMCSA8bS22kEUmOKRa2ng==
X-CSE-MsgGUID: rFS/JipqSwySiO7NGFgifA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="148242424"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 01:27:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 01:27:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 01:27:22 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.83)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 01:27:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZLmO5b+n5dFRfH0p+M25HRA7aB3ltvzpZEICyikNL5KwoY0d7+wfefzmvYpYBrn9kGZ9Q5PyTjVWfi7Fclu0+qGUVClbpltG4U8leFOpR49s4SZzDPf/Io1WfFti9bxioj/GsCO7DRiegpVySCRPayHwf9CKY/4NHrG8W1GzrgTP6wigM6yB535dzW75lCyDKPIUBtWnJ4uJBy0wW5nEQU1KURcb96GGQYhA/MbHWoDmL8egRP4WDNk7RtQ8LHKtQplX+1Vwq43eojXjq/EzYV9KqYM3M60vresFUygHfOvI3ObmSEHXxCT13bFExntdSiqpwXh791nhwI60n1E7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ri9bBXNHv28uRQkc4t69xQ0QkSz19LQ9E6spNm82Ohk=;
 b=nWY7h8BLUj6eay8MJWpYW4ZTn2HCT/gccKe/fJeAU2AG8Pogu6tmK+qpNbiEK7DCakUwOdJNoYa3EXeqgCWoOYyF5nvZFHeN3YlBNCqb2KOMCBW7QVlHQb55HlTIC24vIqwKeq12rgA2Z+J3MiPTXfOfKoX86tt1RGs5rMNGNxgpoCU9hHxKDzw3Co9+uFkZ2UKdDgy9vKCdP+sOc51APlv+V7ZVYTw9wJ7nb5f3zS/DPl1aLAFXOZzFYzpPU+nwwzWH5O6QPywm1VtoFoD33q2QSW6+w+Rs/a8rZT8ff+Oc0iq5kQCtBQEKkQ0UI2EG7hq3ZogzmuEZ5BuURvf9bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB7962.namprd11.prod.outlook.com (2603:10b6:510:245::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 08:27:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 08:27:05 +0000
Date: Mon, 16 Jun 2025 09:27:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] buildtools: allow a different minimum meson version for
 Windows
Message-ID: <aE_VVNiio9Ewz-h2@bricha3-mobl1.ger.corp.intel.com>
References: <1749831278-8286-1-git-send-email-andremue@linux.microsoft.com>
 <aE_Jf9p5HY17jc1M@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aE_Jf9p5HY17jc1M@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: PA7P264CA0091.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 6797c904-0810-4b84-bea1-08ddacaf9396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jc5kJBiS1ZS9HTOo5q5zMnK7oa078XQNZadn+J6nnA5RH5n6wDFIlLY233x/?=
 =?us-ascii?Q?0IORzKud2A/MYE59NZhK8uPSk6hsFJ29vp/OstEiedtxpVhNEu4reJqU0qWw?=
 =?us-ascii?Q?aUoWZzycJnydJt7ldHJqpwt8rGKe+MJ36ns4lYzY5wilh3Qam+mJ0WtFy5xr?=
 =?us-ascii?Q?z4Tx82n0CqQWHmcqku4MSlKp8BjudglrL/v9m/q/EmXbeaf6CTRqFogXgl00?=
 =?us-ascii?Q?PFCpA7NZzn61iBNfsX09KdMRfwlKfYeM0lztdmv/QRGnB9rnR1g0PrjqNLr/?=
 =?us-ascii?Q?azI3iMEe6A8YYKIzkflqNd3d9kgVkvJRLeF7REIsDbrM3cL4zAT+fQsMBKEl?=
 =?us-ascii?Q?CK2kPP4h5jceVgHe3v8wTPq4CFZydlWia4ubFrmS/EAI0p20t9079vlJgihx?=
 =?us-ascii?Q?liGn85zP5318Inpk0biRKewtlIXOA16j9ytsJaUVndyVEBuy3bCa6D7mnsZ4?=
 =?us-ascii?Q?ePXq2m922wWuH2T42q1cmzxI3hr/UIphUSxEKqodMWNtD4TRAAyp/RUu5Vxq?=
 =?us-ascii?Q?q12zHQl2oVxbqeISfbzrujM4IXRQQQV8R2jwKAsCLUt4sR7NeblUkYwGirsc?=
 =?us-ascii?Q?NbP05L2+a5GwUPFkDGsotxGkQWTFWhjMCsUx3ORvwwz1LwcYYDXozu+kcfmG?=
 =?us-ascii?Q?tQAdFBaZpstIYXOqeCE6G6rOFbq1bzb75y22YS7m1AWOR88FQFimbFnfYa9y?=
 =?us-ascii?Q?JPgzzAm2e+N8eLszAaDOdUZYzdyNyLKAszsqG7CK2/xk7/QW1D/GYCIOw8LB?=
 =?us-ascii?Q?sb8x1e8bH8ZH3iFn8Ls5PihHIAjzJVAVzsF9SnbtaZJTJvX5g/G7PleGrgfh?=
 =?us-ascii?Q?nNSWihbSub4AeqlztAHreOyCoj0Z2K1fc6PbdAGETMnJIE+TcOv4s8XfzL/h?=
 =?us-ascii?Q?I4KO7sxe8J0QLYJaK3fUdNeYyATZ5QsxtIld59jIit7lb5KvK4V4ziVvTb8e?=
 =?us-ascii?Q?W8Yl0CdcuTaKGIPXbSd7FU0XlLINXh45RkyN9K06drwVfCgIgQUuA1wI2xkS?=
 =?us-ascii?Q?cO4rfwnfU+twZyNZAonZqGhn42v4mY8U1Qe3N/C7D4HrROYdgr1Qdy9Ffi0s?=
 =?us-ascii?Q?R0u/1TOTfa02kGGaWH49r0NJsO06Ws16SvlgcHgdpGvWfa4LyNnDaY4pALZS?=
 =?us-ascii?Q?lGWgi/WGTihz2uKnXDAANFlFge9JSRWgQboZvklpOMIdzn9O4Tw62wNBF7ms?=
 =?us-ascii?Q?5oIJ+dZY6yMroIIGcRymurllQ9Z+F6/xGbGtrdsWODetbywjHYZgP1qTE4ec?=
 =?us-ascii?Q?6KuuIvXub8y1+Mh+7F5jLz38/s3SxjkD0PJRcx6HUbVDnHRONw9WQsH3al8S?=
 =?us-ascii?Q?YoZt2BMet8kGBxcqrnTr9IOhc70WcXjivkC/+9vCKx6xbgkHZfyIG+QGY3dH?=
 =?us-ascii?Q?tldSEVZcQ8iFXSKvZlIgTOyR5IDhWkGAiteNjEZDJrWhcYsu7ADhziD5TT3a?=
 =?us-ascii?Q?XGekVZQtp4s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DlDaCuVIUx+5+W7SIfI+dd5TMsBW42yQMr42JYmjZJkDjuotiyQ6qx0gJ8YO?=
 =?us-ascii?Q?4vMUowdHaBpAaVFxQKGbLWd6LCgZEudnIKqIocAZpuo71V376bbCYjfUtxAQ?=
 =?us-ascii?Q?sjJCINSa2R1L4+JDvhl/O5d26KxXKF1sBh0OJzD9m5ri76hxSTM+egTylqGG?=
 =?us-ascii?Q?hdmtoHVk4y30jH0rqfyiHmdgp9W3TLbtPm0djBs137yrC8/4MOx4S+fb4Kc+?=
 =?us-ascii?Q?NXGhq6a/HmjOt1a+8GOvhDAwy2QdyfAtviuYd7+gY1wHsZEabv3hiwU8xA8+?=
 =?us-ascii?Q?q4pNNrOQknRhtS67ne9+repN0nBUCK++MvLS3y1HJ4OUX243M1DV2N1AMxSL?=
 =?us-ascii?Q?9e2NunplR3d89fe+oJGKDIDU4ZJPDnPTIewao+hWevcqimnCQDTiBDgUxpGB?=
 =?us-ascii?Q?4acoo9hM1/r/YArUKGPos3FALunota08UicbessTaZ0NsNF+gYq4k8ERDMs4?=
 =?us-ascii?Q?Q7foKK5uVKiPOqE42EPpMmKVWRXtlttU/WB83+pX6UB19Cy8jF8Rteca3Yeo?=
 =?us-ascii?Q?L3oY5ArEVK0bvQca7h6iYlhRKkSP8PUWX7FBxkl+Pk7AWxjhZt5OL5NZL/D+?=
 =?us-ascii?Q?/kD9mCb4xuN2ix7466G6I4JAHMTzA2louzlMPC2fnYxg+CVRtFkeV7Si9gEF?=
 =?us-ascii?Q?8/HEJ3VYWoOD7bWs0Ycc86BxcHaFm+tsD5Prx07V/NaZKKutDETYi4qQ3zkO?=
 =?us-ascii?Q?JtC0kKSFq+RGYrpesJY+X9E2d8xo/ymDdmu/SBDGYaMsyaf2RzH+P3iI5yhi?=
 =?us-ascii?Q?MSWhkHdY9EDteu7rBAOcBeYJ2TpBnOyGOfEn/eP00TXKIqE2xuSf9ay7Z+I9?=
 =?us-ascii?Q?uJQn0KDThQT+zVtG7lrCtM6sbCy+PWxy1vp3Eh5u4RBvM1ihNR672YmthH/Z?=
 =?us-ascii?Q?LIgzonQY09LK8Wwjz6Obg/YcGnJGa5Hn0b+vozRTgZ6Og7VU+7G+6a29yXd3?=
 =?us-ascii?Q?AdYfOA50pOjt18p5QW0s68NjpY9yvqVqd9JOV/WwMC3Q9QmiXpEoxAZg76X3?=
 =?us-ascii?Q?oLp6KKcnMBsImC+uoVNWcLPMImlSkP4Z8QiN0IWeDTkf3pbT860/eeSTuMIg?=
 =?us-ascii?Q?9iLSJU2myx4QwvoAoAPUnjqwQZ9qHfbWbFFlMQ8u9509TTGaUNPfbhUuZiEN?=
 =?us-ascii?Q?KBRcPvA1brohrsnqh4I1By4flhEucI3DQzoB4tWZIXlCjBeNjk4yRXmA0ikz?=
 =?us-ascii?Q?95JHoQXbyZ9D7DJCsVIP6UIRbycyK7JezD6RjbcgLIvUAIPsXVEPWNTp4cPu?=
 =?us-ascii?Q?DcRjPijZLwHMEZqobwriYFPYdpwSEyI/KBDdH8cyNRTEbrk17l9ghWcJhRsy?=
 =?us-ascii?Q?h8mw+N0aVAM0po3rR8COW8a+0xC4L6gxs/duK91/TecC8tEYtE6tsk1GJ2rW?=
 =?us-ascii?Q?+3H9eG/dT+Ifnq44L3ZjN7r8Y6nHCj7WO+7yHrGfjincRQLxEdJRL6i3HxSR?=
 =?us-ascii?Q?zo/1FnA+VRo9lpSa1eOuC4Ch2JwtV7NfPZNaxTcQLWlTF+fp3Ns8c+V0cDh5?=
 =?us-ascii?Q?x5WUMnzrMW3jbY3WPcYQ395x7TJRq2+DFXThCIXnbgj3powyw38ZEj4CV5B0?=
 =?us-ascii?Q?N/MYy5YqqrW+n2cQIE4NfeGqXHVUEvDylC8gLO/w46NZTS4uuYr/uiMNxVoY?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6797c904-0810-4b84-bea1-08ddacaf9396
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 08:27:05.4127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbMIFjz5YrQ8x3eYkJi0ipmxAM8zC4xnbe9yBhStwFyHb50OrCnZsV8SGl96q9mnTysWFmotdW5QrN1rp70RyXmnOfRaN/nVAqeNI+PFoFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7962
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

On Mon, Jun 16, 2025 at 08:36:31AM +0100, Bruce Richardson wrote:
> On Fri, Jun 13, 2025 at 09:14:38AM -0700, Andre Muezerie wrote:
> > There is a minimum meson version specified in the DPDK meson project
> > section, which has been documented. This string is parsed by
> > buildtools\get-min-meson-version.py and this information is used by
> > lab automation to install the corresponding meson package on the
> > build machine.
> > 
> > Turns out that the meson version specified on the DPDK project
> > (0.57.x) is buggy on Windows: it has issues related to path
> > manipulation, and these issues are causing failures. Therefore,
> > a newer meson is required on Windows.
> > 
> > To avoid bringing the minimum requirements up for all operating
> > systems before a more appropriate release, this patch implements
> > a mechanism allowing a different version to be specified for Windows.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> 
> I am fine with the principle, few comments inline below just on the
> specific implementation.
> 
> /Bruce
> 
> > ---
> >  buildtools/get-min-meson-version.py | 12 ++++++++++--
> >  meson.build                         |  9 +++++++++
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/buildtools/get-min-meson-version.py b/buildtools/get-min-meson-version.py
> > index f0de8fdf2b..10a2596a5a 100755
> > --- a/buildtools/get-min-meson-version.py
> > +++ b/buildtools/get-min-meson-version.py
> > @@ -11,12 +11,19 @@
> >  basedir = dirname(buildtools_path)
> >  
> >  with open(join(basedir, "meson.build")) as f:
> > +    if os.name == "nt":
> > +        keyword = "windows_meson_version"
> > +        pattern = r"windows_meson_version:\s*'>=\s*([0-9\.]+)'"
> > +    else:
> > +        keyword = "meson_version"
> > +        pattern = r"meson_version:\s*'>=\s*([0-9\.]+)'"
> > +
> 
> Minor nit, but I'd suggest shortening this a little to:
> 
>     keyword = "meson_version"
>     if os.name == "nt":
>         keyword = "windows_" + keyword
>     pattern = fr"{keyword}:\s*'>=\s*([0-9\.]+)'"
> 
> or even further shortening gives:
> 
>     keyword = "windows_meson_version" if os.name == "nt" else "meson_version"
>     pattern = fr"{keyword}:\s*'>=\s*([0-9\.]+)'"
> 
> >      for ln in f.readlines():
> > -        if "meson_version" not in ln:
> > +        if keyword not in ln:
> >              continue
> >  
> >          ln = ln.strip()
> > -        ver_match = re.search(r"meson_version:\s*'>=\s*([0-9\.]+)'", ln)
> > +        ver_match = re.search(pattern, ln)
> >          if not ver_match:
> >              print(
> >                  f"Meson version specifier not in recognised format: '{ln}'",
> > @@ -24,3 +31,4 @@
> >              )
> >              sys.exit(1)
> >          print(ver_match.group(1), end="")
> > +        break
> > diff --git a/meson.build b/meson.build
> > index 5ff68cb3af..1ae51996be 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -13,6 +13,15 @@ project('DPDK', 'c',
> >          meson_version: '>= 0.57.2'
> >  )
> >  
> > +# Meson does not support dynamic/conditional values for meson_version in
> > +# the project section.
> > +# The line below contains the minimum meson version required on Windows,
> > +# which gets parsed by get-min-meson-version.py.
> > +# It is important to keep this line below the "project" section, so that
> > +# the script can make the correct determination according to the operating
> > +# system.
> > +# windows_meson_version: '>= 1.5.2'
> > +
> 
> Why not pick a string that is not a superset of the general meson_version
> one? That would avoid the need to position it below the project one, and
> save you having to document that in a long comment. (also avoid the need to
> add the "break" into the python script, not that that is a big deal!)
> For example, how about using:
> 
> * windows_min_meson
> * windows_meson_ver
> * windows meson_min_ver
> 
Or even: "meson_version_windows", since the rest of the pattern we look for
occurs after this string.
