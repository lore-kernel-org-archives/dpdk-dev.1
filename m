Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8836DCCF9EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 09:23:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 408C640608;
	Wed, 29 Oct 2025 10:23:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 3DF5640288;
 Wed, 29 Oct 2025 10:23:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761729819; x=1793265819;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=QHS6RLz+qAkhTzxHWsmyWK9Kk9h2+mgVqZcBxGkoroE=;
 b=e7YukLjKCU0bkudjBY8+zRAWcxb3BO1PMX/Zc3k83No3b6z3yBU50LzO
 3SdAMXloeOhbNPjKWDK/ENPS18d3WQl7y07UN6EJeMBC5XGc6IPWgK1j1
 N8EZAU7XMCOUGpb07xRrGRnhFp6po2KvI5oQxG9JEXp9P3tdsveSdBxdY
 6laZ1SREfZfWTRC3xWuj8hJ8N28WWbTGH41n9eqVRgnRZPKRjtOWUg2gB
 DeO+4GryJQTbLWao0d6xY+9ULV5TS9ezbf0s4tVihIMIdVQbVuya/BFsN
 cQ3BNEsJ1RZfEVfUULRPZCFFUEeP0EMvlvaNkf/RQqRHdP8kCWNcoQMc1 Q==;
X-CSE-ConnectionGUID: szy2HJ1DRmG3e3RNHefa9A==
X-CSE-MsgGUID: 4mJhOIDKTdigTXAMA/tEsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63748754"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="63748754"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:23:37 -0700
X-CSE-ConnectionGUID: y+1wo/nlSGqnpGZaQvMWyg==
X-CSE-MsgGUID: 3eMVUVi7TUG7H8L1nxmt6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="186353760"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:23:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 02:23:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 02:23:36 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 02:23:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2tJzfeZg+xSUjYocoGwPOmw5seRUnOnh8/gv+Wpx6lGLeOPl60kzB0yjbTdsoRiQUQqH+VOKSdCzn/5ox+KfQIipei1ZBxNHJ+nL80iVTNI5U78V0SnQ/b2pLSetyII95uEqMSiKxFIPtZ2GvGRXgfJAg8/Xr8XxGbYzkuIfbvVnMM20VtkeYTGgJgEVFUaNNjf9yVWo3A6E1N17RauWp3i16JqHhGQvr0OWOPE6IHI7Hxc9Z2XhxhQ0i/rW5KEtyEphK6ICpUNqrG+VhOn8aTfdJFc1blzLEF/YZR4fP6wPmxWH8PDq8QcZr7OrdTxByPPXN1jtUg6zKweqKhsBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETTkg1YpjPeo2kL+mK9vaburmzH6RJQ86l6j6aGey3U=;
 b=SbOxp6G7qLYuQsKKnbYjhL/+dVrq01RB+M14P8gOClgK0UimnOLzCaXb8JeJwYS2VcDzTjirJIb607ZgeUr4mavgA/b/ZiUuSD4aF7pRbWulFO3t+lOUnRCi5ydGSJDC9AcdHN5ppK+vreL9kdtvrA9H7pZ6RjiGNueTu3LMnpHj7d3av+9c4P28GSr/u8NhzjwFagGXAlSj0CZdRIFAvs9CilvEv21HcVRVXDIxfF9K1iV7eH6i7L9Phi3mOHG+gAAgZvPv1GUJLLoWgt952AA1Dc3JR1yIIpukrxSH/nbUjfVYQv+rNaKkQC/TOopgykNGed05D0UWy2q7e8Diug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8698.namprd11.prod.outlook.com (2603:10b6:408:205::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 09:23:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 09:23:33 +0000
Date: Wed, 29 Oct 2025 09:23:25 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Morten
 =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@oss.nxp.com>, "Shai
 Brandes" <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>, "Ron
 Beider" <rbeider@amazon.com>, Amit Bernstein <amitbern@amazon.com>, "Wajeeh
 Atrash" <atrwajee@amazon.com>, Gaetan Rivet <grive@u256.net>, yangxingui
 <yangxingui@h-partners.com>, Fengchengwen <fengchengwen@huawei.com>, "Praveen
 Shetty" <praveen.shetty@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Rosen Xu <rosen.xu@altera.com>, "Andrew
 Boyer" <andrew.boyer@amd.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Wenbo Cao <caowenbo@mucse.com>, Jerin Jacob
 <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "techboard@dpdk.org" <techboard@dpdk.org>, Ivan Malov
 <ivan.malov@arknetworks.am>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: Fixing MBUF_FAST_FREE TX offload requirements?
Message-ID: <aQHdDf7DnAIyIzR4@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F65442@smartserver.smartshare.dk>
 <aMvMNUxSslnM68OR@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65446@smartserver.smartshare.dk>
 <f3d8956d80814d82a450abc263349ea7@huawei.com>
 <157addba-7dc8-4f0c-8b86-4ca8d057cdfc@oktetlabs.ru>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <157addba-7dc8-4f0c-8b86-4ca8d057cdfc@oktetlabs.ru>
X-ClientProxiedBy: DU7PR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: 3784ef88-ac83-45f3-afd4-08de16ccd4fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?+r31z7mGf1XbzRnLTkFfNGToT9Eq94Xmum3CeOokM8mSZsVJJYjYbUg9UU?=
 =?iso-8859-1?Q?WOpTE+xCeF7R5DOFOcVTe88gSqUZPPwMI2GGTX+vyYq/sivcIhpm9Y14Z/?=
 =?iso-8859-1?Q?GFTXrbFxXnqE5OTT1xbuB6+p9fy8DJzadnjD7slaekwZZg5N1IGdCdsrtb?=
 =?iso-8859-1?Q?3XIyoD/yn0+uSbrDU6MhT4i2GEgMxKIQz/0XA4KaPnApuqffAtWwakkgh+?=
 =?iso-8859-1?Q?31iesgK+jIb6eFtpJxMO9r68X7Hqk9E9T5UOziwsojuHCPR2e5kFJoJ4Kf?=
 =?iso-8859-1?Q?osh4yhDCspz7aNkkqND6gH1TfkcK9Ft/rngjffw9Q54Leyi/BM+2vhXkV2?=
 =?iso-8859-1?Q?naoPtjkXP13vCUtGFo9XjeTNqv3XwGL4otinorDnrrDRMUpBAMZPZ8TFfM?=
 =?iso-8859-1?Q?cvEYZ8PSf1tgzhvzXccUBM+b1X1S83vEfAkumeumm31tkWd5CoRb/J+B5n?=
 =?iso-8859-1?Q?vdRDCEAf+Qn46wjq6iT+7gfIVvGcjdWrgzuaALbQaANtqGGLBZ3N/83Yor?=
 =?iso-8859-1?Q?dQ7IVnMK8TOdPK8I6df7PFFkda+0xyg5Tmltg/oaNzWkAG5w16VD0UJXzF?=
 =?iso-8859-1?Q?qEHRhlJf//WhBpLFH5xGGBs5fjKHdEMdcp6GBiyWghxMGRODaBTxoj07nN?=
 =?iso-8859-1?Q?jA/sYNYpDnv+wGtlS2JhDwsBrETV0E6b5jNXusJ9ILT8OH14LG64K471hy?=
 =?iso-8859-1?Q?SiPZ0rGFvhOZ4syW3IlLTjVFzns0KoSvvjDi+krx7tGyj2XRRZ9kW7b4lP?=
 =?iso-8859-1?Q?FEyfLZGqgdy/EYI7TGADhpKq9d425pbqI8oLetyi1FyMx9OJMfWkEkn3gk?=
 =?iso-8859-1?Q?3p/L1j/+X7T3zkP9Rlz/Dh3qfhDKB3vzPAs6S0JCFTswbl/WyDZK7fetJi?=
 =?iso-8859-1?Q?vXjrpjglb6xuxt0VLYyBbSaZLKLoZOkL/k+UEz+7HyXSwMy/CrJKaJVJjy?=
 =?iso-8859-1?Q?P9k5YMJLpfF86+0qkfG9ADq+I0OTTUv2MFnqFUZXRpMIRKBNhQTgLShQgP?=
 =?iso-8859-1?Q?FDFr6Hg2DUxvpoWZW+Xwrk+uQJydJPRb3GoF1CndirXHhIjcXZUmnuT6X/?=
 =?iso-8859-1?Q?IsTMTpQqn8+F/EZsIuepM4vRnRRxQafNh/gTT6OdvYJE0CeY38nbI9GX8+?=
 =?iso-8859-1?Q?mE0xEpymi6CvPmyl3fs9FMXPYjWAblOEMaQ8XEH2eET1zkMU25b8oRY9Hp?=
 =?iso-8859-1?Q?L8fbYJc626Vz1gvL8nTzKA1KgpjF5WRafScLGh4cSFkqS38M3vJrF01VbO?=
 =?iso-8859-1?Q?eBN92tV+u8pBhGDEHCYBAgJaDC2cOlif7So0aRUzEPyTdxM541tCfUNpN0?=
 =?iso-8859-1?Q?4rQiUkNMPpz0YP3Q1fjhTdgMNBTYFOo7nZLuaU4BYWfy+gBwWiphS2vpJY?=
 =?iso-8859-1?Q?FfautXtGZeU4oAB7Ma6uFyehUDwPMyoUpeJ35O2EwJOp7KQ+7Nn5x5wFoy?=
 =?iso-8859-1?Q?dny24WX4H2P/CMajPD9h8zPK1+AKd/7nDMe+uw6+tP4oB+fs7X2pKVUtxt?=
 =?iso-8859-1?Q?eLrNFOFmkUtO4/TzAwoscKmJd7era+dbdW0qpLxkOltA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YEKMdRYW3kL1ogBlyIVXjX+gLrB+Ohf1dzoiY5jdKWTa8sFXcX7sVGg2KE?=
 =?iso-8859-1?Q?hItzPWYrN4qUE2at9q7FkdkbqLHmE1K7GnagcZEAkk6p3ZQt3untS/AixV?=
 =?iso-8859-1?Q?3X3qzikNzPrsMIIe+hL3NBFULw1hzrhZYQRCCtez1KJMrsCsCsKLB5lH+p?=
 =?iso-8859-1?Q?m5rNd4kXV604pFsBKrf8NC4l3J3IRpXLT0m+UgVGrRPYOMLYgTLhtFUvYq?=
 =?iso-8859-1?Q?qOvFttvQn5uGWw0FoUH1qKnW//Ily0wzwnvI9lp21GWTyvo3KpnhmghPqP?=
 =?iso-8859-1?Q?lQ25oY0ffUqz32hs3AJWm9AY0oxIweB+LsbDEHVzRpwC9TRgYfeeuI9Nzf?=
 =?iso-8859-1?Q?Aay/zpNoaMx8bU/3nOmZrdmBCcjGhNeQy0pIG8svSlZwEPFXNKkXjddOGx?=
 =?iso-8859-1?Q?OoH2O9K1pG96YWD8BeJ1dSRvua6/GxpXGu/FXrV6tvAQBMLVpXJxiPbGtG?=
 =?iso-8859-1?Q?vXesnT802NdFwW41vkD8oPU3TnVGuGKenm00VCmlHNYirwFPj+2b/B9qhN?=
 =?iso-8859-1?Q?h0AH4HTDamzNRV0j2G+PyORgJ1Qws181FFTHii2pRKOVwTXYHoiYisOAI4?=
 =?iso-8859-1?Q?fU/FjmxC2cKnkS8SJAGJB6rOaI70eFOWagYUWSW2Satn+YAXrs2rMislwG?=
 =?iso-8859-1?Q?zKvqVU3nyjDtB93KfZcCP4mlcoKgAsodhOnze8Wcl+EkZTJKONPY8WjEqV?=
 =?iso-8859-1?Q?rJVPaHSHoF4VFoK8O3GK5zylcoon1DjPGMbSLDFOtV0FRy6jpSuiAIck9R?=
 =?iso-8859-1?Q?w+C9QjjT+sIrBPQKZCTBmvbHpoegVjiff2o/K1MJiIYdSV6R20KalIiNJu?=
 =?iso-8859-1?Q?vF+XFVG2h9EFo8d/MStAH2kJd7zZbBaZ2OW6hXNmugGGbUb+6vEIvDdKmv?=
 =?iso-8859-1?Q?LIQbz28VZb3NMnaQ6roIe/Fjp3oGywHYOyP2ZO1Z+Y/WPIg+PN6qB6gW7a?=
 =?iso-8859-1?Q?seY1vTiPhSDZgdCY0dBU5xma+cQYveZzWqgQD3zHtXWQKt8MAguWRH6cUS?=
 =?iso-8859-1?Q?TJ9DO80QKymdsCpi9tb4i1DN0q5h6Yhu1B9Vz0X2YeIcxSnI/JSJ2oenzo?=
 =?iso-8859-1?Q?NylwVwvhwca7fsgEisupL5pZ6zXD/rrRO7zYugVzIeTYgvSzJEBbo9WlyV?=
 =?iso-8859-1?Q?lsEvrG2hsowPsuboTx33dfsFfaWP9eNM353nl76rPNPIiKCsyoJk4kq5s2?=
 =?iso-8859-1?Q?QpMMVfkdSFNuBJTgEvDCeGs/jh/HksoiiSzJA34y3uTZXO7J3LPRXxchWC?=
 =?iso-8859-1?Q?R1MDq4a6Xh0Sz3dkpOGy+EoKcUleIohf5tO980gLPTYLCvKt4wseOTqh52?=
 =?iso-8859-1?Q?DWVzSwYXrJaspyroMRwsPYsCYpR68STMgDskXqWojHAxws0HByOr8M3cEV?=
 =?iso-8859-1?Q?ZZ/xhHE3GQ4TSrD6Ur08gSFH0w4iPR+lKpiPv7SpSqgHGtfXwCC002O46k?=
 =?iso-8859-1?Q?2i1G88YRZc1lRTgW8VLhJ08AYtIhKd0SgwSRQczR7dxjhXj+YC9g5W+4Dq?=
 =?iso-8859-1?Q?fMFhHXhU10jdVa+ioL54pqoPJnDI2/jjlHtPyQX3t4R9Bczk3WUSUBoLoY?=
 =?iso-8859-1?Q?yCGqAGFDS7WTQCZ3o+1Mr4HXwN1FwflPPQi1ypuMT15BzcQPEex0EZKc+N?=
 =?iso-8859-1?Q?fxu1WZDDMvfZLWwv4LQg0wE7EDrNk58+HYpKCJEckgmxyrl5Vmmi0mTQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3784ef88-ac83-45f3-afd4-08de16ccd4fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 09:23:33.8483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ETmoyGAsgnlwgKjI6zIcT16iJ8CjT3j3NS/a58BzUWkiy9jZlsm6vLMSTYz20a1olTNnkSGB3nI/VCiSCh5ifgJs+kWubgw7E35u4h9Mf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8698
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

On Wed, Oct 29, 2025 at 12:16:37PM +0300, Andrew Rybchenko wrote:
> On 9/18/25 5:12 PM, Konstantin Ananyev wrote:
> > 
> > 
> > > Subject: RE: Fixing MBUF_FAST_FREE TX offload requirements?
> > > 
> > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > Sent: Thursday, 18 September 2025 11.09
> > > > 
> > > > On Thu, Sep 18, 2025 at 10:50:11AM +0200, Morten Brørup wrote:
> > > > > Dear NIC driver maintainers (CC: DPDK Tech Board),
> > > > > 
> > > > > The DPDK Tech Board has discussed that patch [1] (included in DPDK
> > > > 25.07) extended the documented requirements to the
> > > > RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE offload.
> > > > > These changes put additional limitations on applications' use of the
> > > > MBUF_FAST_FREE TX offload, and made MBUF_FAST_FREE mutually exclusive
> > > > with MULTI_SEGS (which is typically used for jumbo frame support).
> > > > > The Tech Board discussed that these changes do not reflect the
> > > > intention of the MBUF_FAST_FREE TX offload, and wants to fix it.
> > > > > Mainly, MBUF_FAST_FREE and MULTI_SEGS should not be mutually
> > > > exclusive.
> > > > > 
> > > > > The original RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE requirements were:
> > > > > When set, application must guarantee that
> > > > > 1) per-queue all mbufs come from the same mempool, and
> > > > > 2) mbufs have refcnt = 1.
> > > > > 
> > > > > The patch added the following requirements to the MBUF_FAST_FREE
> > > > offload, reflecting rte_pktmbuf_prefree_seg() postconditions:
> > > > > 3) mbufs are direct,
> > > > > 4) mbufs have next = NULL and nb_segs = 1.
> > > > > 
> > > > > Now, the key question is:
> > > > > Can we roll back to the original two requirements?
> > > > > Or do the drivers also depend on the third and/or fourth
> > > > requirements?
> > > > > 
> > > > > <advertisement>
> > > > > Drivers freeing mbufs directly to a mempool should use the new
> > > > rte_mbuf_raw_free_bulk() instead of rte_mempool_put_bulk(), so the
> > > > preconditions for freeing mbufs directly into a mempool are validated
> > > > in mbuf debug mode (with RTE_LIBRTE_MBUF_DEBUG enabled).
> > > > > Similarly, rte_mbuf_raw_alloc_bulk() should be used instead of
> > > > rte_mempool_get_bulk().
> > > > > </advertisement>
> > > > > 
> > > > > PS: The feature documentation [2] still reflects the original
> > > > requirements.
> > > > > 
> > > > > [1]:
> > > > 
> > > https://github.com/DPDK/dpdk/commit/55624173bacb2becaa67793b7139188487
> > > 6
> > > > 673c1
> > > > > [2]:
> > > > https://elixir.bootlin.com/dpdk/v25.07/source/doc/guides/nics/features.
> > > > rst#L125
> > > > > 
> > > > > 
> > > > > Venlig hilsen / Kind regards,
> > > > > -Morten Brørup
> > > > > 
> > > > I'm a little torn on this question, because I can see benefits for both
> > > > approaches. Firstly, it would be nice if we made FAST_FREE as
> > > > accessible
> > > > for driver use as it was originally, with minimal requirements.
> > > > However, on
> > > > looking at the code, I believe that many drivers actually took it to
> > > > mean
> > > > that scattered packets couldn't occur in that case either, so the use
> > > > was
> > > > incorrect.
> > > 
> > > I primarily look at Intel drivers, and that's how I read the driver code too.
> > > 
> > > > Similarly, and secondly, if we do have the extra
> > > > requirements
> > > > for FAST_FREE, it does mean that any use of it can be very, very
> > > > minimal
> > > > and efficient, since we don't need to check anything before freeing the
> > > > buffers.
> > > > 
> > > > Given where we are now, I think keeping the more restrictive definition
> > > > of
> > > > FAST_FREE is the way to go - keeping it exclusive with MULTI_SEGS -
> > > > because
> > > > it means that we are less likely to have bugs. If we look to change it
> > > > back, I think we'd have to check all drivers to ensure they are using
> > > > the
> > > > flag safely.
> > > 
> > > However, those driver bugs are not new.
> > > If we haven't received bug reports from users affected by them, maybe we can
> > > disregard them (in this discussion about pros and cons).
> > > I prefer we register them as driver bugs, instead of changing the API to
> > > accommodate bugs in the drivers.
> > > 
> > >  From an application perspective, here's an idea for consideration:
> > > Assuming that indirect mbufs are uncommon, we keep requirement #3.
> > > To allow MULTI_SEGS (jumbo frames) with FAST_FREE, we get rid of requirement
> > > #4.
> > 
> > Do we really need to enable FAST_FREE for jumbo-frames?
> > Jumbo-frames usually means much smaller PPS number and actual RX/TX overhead
> > becomes really tiny.
> 
> +1
> > > Since the driver knows that refcnt == 1, the driver can set next = NULL and
> > > nb_segs = 1 at any time, either when writing the TX descriptor (when it reads the
> > > mbuf anyway), or when freeing the mbuf.
> > > Regarding performance, this means that the driver's TX code path has to write to
> > > the mbufs (i.e. adding the performance cost of memory store operations) when
> > > segmented - but that is a universal requirement when freeing segmented mbufs
> > > to the mempool.
> > 
> > It might work, but I think it will become way too complicated.
> > Again I don't know who is going to inspect/fix all the drivers.
> > Just not allowing FAST_FREE for mulsti-seg seems like a much more simpler and safer approach.
> > > For even more optimized driver performance, as Bruce mentions...
> > > If a port is configured for FAST_FREE and not MULTI_SEGS, the driver can use a
> > > super lean transmit function.
> > > Since the driver's transmit function pointer is per port (not per queue), this would
> > > require the driver to provide the MULTI_SEGS capability only per port, and not
> > > per queue. (Or we would have to add a NOT_MULTI_SEGS offload flag, to ensure
> > > that no queue is configured for MULTI_SEGS.)
> 
> 
> FAST_FREE is not a real Tx offload, since there is no promise from
> driver to do something (like other Tx offloads, e.g. checksumming or
> TSO). Is it a promise to ignore refcount or take a look at memory pool
> of some packets only? I guess no. If so, basically any driver may
> advertise it and simply ignore if the offload is requested, but
> driver can do nothing with these limitations on input data.
> 
> It is a performance hint in fact and promise from application to
> follow specified limitations on Tx mbufs.
> 
> So, if application specifies both FAST_FREE and MULTI_SEG, but driver
> code can't FAST_FREE with MULTI_SEG, it should just ignore FAST_FREE.
> That's it. The performance hint is simply useless in this case.
> There is no point to make FAST_FREE and MULTI_SEG mutual exclusive.
> If some drivers can really support both - great. If no, just ignore
> FAST_FREE and support MULTI_SEG.
> 
> "mbufs are direct" must be FAST_FREE requirement. Since otherwise
> freeing is not simple. I guess is was simply lost in the original
> definition of FAST_FREE.
> 
That's a good point and expanation of things. Perhaps we are better to
deprecate FAST_FREE and replace it with a couple of explicit hints that
better explain what they are?

- RTE_ETH_TX_HINT_DIRECT_MBUFS
- RTE_ETH_TX_HINT_SINGLE_MEMPOOL

/Bruce
