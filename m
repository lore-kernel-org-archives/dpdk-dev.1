Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B853C43327
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 15:27:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26ABF40652;
	Mon, 29 Jun 2026 17:27:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 8178040299;
 Mon, 29 Jun 2026 17:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782746850; x=1814282850;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=eCMJuHgLDqM8dRNzG2DJr041H2/UEy8jfc/gG52Asgo=;
 b=gDK90rAFDRUMMHGrrZEUTgDgfYNFlZKo/E5sPAXWi1VB2gSwWiJC7AA8
 ZtPQq0DMvta3AtN6QEP6r4qm3WYOYdu9Nq3Ygz87fQyW7qknpIZwe8XdR
 qvajKAva5yfsZY50cftw/jUbLQK6Y8kqWgvF2BIs4pKOKzCcfF9by1P4l
 Ox/q7absqhWraja+RIYJaycUBt6TAO1Q7X65Y9qFTTeIJavnHvN2pb+6L
 w/OnR8EcdlEwbKLmlTKterV0cRXMEdzxWdSbVGrV2VMsikH6ri7VT9f2O
 yauaJtfpnr6OYJ2aIYV2RQkz2atm5r7C6P+zKsx3skgJk+vcCzLlSQwA4 g==;
X-CSE-ConnectionGUID: BvxJBlxERIGB5Y25K0x50A==
X-CSE-MsgGUID: OpXjxmObR22idGpLpZs17g==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83210183"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; d="scan'208";a="83210183"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 08:27:29 -0700
X-CSE-ConnectionGUID: SaLJRmH5R66hopJ2GL/HwA==
X-CSE-MsgGUID: NZGLgT6nSIytyjfyRmyqPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; d="scan'208";a="251595401"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 08:27:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 08:27:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 08:27:28 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 08:27:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKPAfryo+Xbp+zeGkpWyIYc8WVvUJRUg8lp5pXftZZp9u1wS9DqkMmChzjAUio4hw6n9FO9GCZAydCt0yOHa0/QAOU2HpN4w1iBts7Q/P6Mulnqs9jD9flRVkb3fFMB8WhgiH88wH3eTUAoJayH6ajaXf0/CiPb/qcHwKWgA5mgEilejYMA8/62xvUJi5MHmfIYzeWTnpxyepW+KRCHjZjd34kL1VEpZg24PGgn2JFEmZDZd26QWEsXZJrg6cmGNZxed/LuPxHL+vVCjoF4k8dS57rg4OPEuaNxZmJeAjpXFK50A1TGuw8JwFYj656QMUQ0MiMVKRCwETEQ15n0kLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yS0amKGnfm2/RmWRNBfKCA4Ef4Fyrk796wQr/YxVZVY=;
 b=S409k+r1rboKB+AkyV90Ut9bE7o4B53yJvQLKV0WVB6PXHISKemE8De18Fy4zWRCuNNJc4CYhmxk7a6r0ZfchOy0LvgY4z25ltbhrtyylssKE69zv/N/2VQOrmjtobCXe7CNuZFPLbVZi2uKKQ5hcoZNNI5Vq+hAmQwo8xZk78JOi1lYm6bks+xtdY3dHDNJm/iVVtIssYERQp/zn9EtzRY1faFc//uluDP5mvVLKykNM4LaVKwND1HdAJhNy/fOJfbpirKpjmGpyfR+ZrfUIZEkA4f7r6XhSdS22N+WbHcNvjXO2fnk+qxRhmzw11Ss9qXVK8Ti/s9D8jbmTVw7/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by LVUPR11MB9568.namprd11.prod.outlook.com (2603:10b6:408:39e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:27:25 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 15:27:25 +0000
Date: Mon, 29 Jun 2026 16:27:21 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>
CC: Shuzo Ichiyoshi <deadcafe.beef@gmail.com>, "Zage, David"
 <david.zage@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: Re: [PATCH 2/2] net/e1000: fix igc Tx descriptor ring wrap
Message-ID: <akKO2avov17T9bui@bricha3-mobl1.ger.corp.intel.com>
References: <20260629045511.473850-1-deadcafe.beef@gmail.com>
 <20260629045511.473850-2-deadcafe.beef@gmail.com>
 <IA3PR11MB92549B10D6A67B13D8AE092FD8E82@IA3PR11MB9254.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB92549B10D6A67B13D8AE092FD8E82@IA3PR11MB9254.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2P250CA0016.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::21) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|LVUPR11MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b305d0-85ec-4a78-c36e-08ded5f2ec43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: J5mx3yKfCus9kRdVWGL0CgG8gtPiIBMEYxnYCTOtas6yRwF4z+Ttml3Fl6rMlArmtSPmoS426c42ZuUO3GVbxDfgIm+F5Gco+eSaFZ8mM9Bq0bj2cgFGL+isaVbBaeh1hvTC/BwYLcdRU6HydKvw59Q2AADD9A3U1S07g9owBINP+srh22GlnWI9sMBXs0XOz3M8fKD3/ZKGTWK/30JubOBnbpiTNFC1elMQEoihIBakMw2wLlhn9/FTwFkoDUg46JX+mq/qQIVkD/ezqny2jT4XZoRh4WHSVrotkMXTJzDQgT9U17L1isWC57r2hYRLbkowm+Y1myBySnNyDjhVdnUpCA+GhxOOxC1frdm683myz9aZyjsrlVYp1GhP5/Hl8Wc15e0kkWWcKqpFETV09LLxGXLX/sYV3XaGdlwfZIGmwoRM+PLehGPJKRFTGvQllFi8+GDYpc0fXJSGdgIIwvAUO2n5vyBOkBNleUqaLhqc3LY43m509h8hR9+HnP2OtUt8ct2cn+CtTXTvju1ezBUcS429LnOLOltk+Exyj7sEr9oGwqnHVPGolDnPhlrml7oPlvX9kYa3RFwvZ4EwR+3VuOajUrJ/ugsLhVj4dtDqqYPMNGyIC17JfhiKvW/PncVVqlcQWvP2xKdms6NURkCVvwL2fI0OUroFdXe3YTY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WCZvf1sE6YP7OfHHM/vcZku65SZ0vRujHtYTwSItQQ4KL15gMz0gOkKw8pl5?=
 =?us-ascii?Q?1xnFu5snJSym4a5e1xfON1RNqTa6HLGzXkE4DJB4Zj+vcC+3QzoERosirmMT?=
 =?us-ascii?Q?mesXhFTWUvuiFPfSlJpzf531SaCaBTlwyT1cuuEACyLJ3jMCWEbhWrdYtxmT?=
 =?us-ascii?Q?hu+JVQ062o+Fc9URGt1UBNz8Zb/q5tKIujx5RN0CEqULRxYVA0RPG2jhiAIU?=
 =?us-ascii?Q?i/Hu8aBdf4LYYk3i5QGDN6uWQMsp+wjxD86kR65zIeieYMB4lk6GM4pCgzX3?=
 =?us-ascii?Q?JCXM9j1N7b77/ZlnCTL+ym0H81qiNHR2k8nJ3LnSlBalZHwARIjcdc/6zSGB?=
 =?us-ascii?Q?oZs3WrlhJYeHeML2aofVwlgqJmzMf3OXF9fkIjB3srNDinSsZfp2Yq9+Tgnl?=
 =?us-ascii?Q?QcqU/BQgQ2z7g4in933i0hi8l8GzCIDHuuDt3s4mLL35Wjnwjxk2U/z5U4RW?=
 =?us-ascii?Q?6n3c2LnnFZ4BoZsSUT6lhENeAd6GiY7JljjZl6YnTf1MYj4aSa6QWRZrzGBP?=
 =?us-ascii?Q?WzA1Aff9lAN9wh5NplgPVcxWXMpfAU8T/MGsVWdO7GJ/aCeqMpc50+WYLLad?=
 =?us-ascii?Q?OnHyjijjHmK4cIegbw5NvKu1PSQ5HIr1C/VOkM6i5I/av3mXHgGCSf5du1pv?=
 =?us-ascii?Q?afWR5wmbDb7LgJiJPP3aX8jvOswKAE3lidyh/3wO+xLI5LWPnabKnFl3FSAp?=
 =?us-ascii?Q?cOGOxX/o1LB4hF7hsCxAXYoxxSdXDHgQn+YU3ihEzAkH9mtmFXrtXe16+Ter?=
 =?us-ascii?Q?umPIJE02Q6sk0hY5kCZDmUDbzwDZwFNbQCzV1JDD1/PHj0knuGtJBcWqNyO2?=
 =?us-ascii?Q?J+ZZrmNSML1clLRkfF+W7plLbrAksA32+7CLV3qojWtg4Jso4s3uov9h3lED?=
 =?us-ascii?Q?Y9BPTTZ6b11hT4V79Lief9p0Od/TqwdQDv9JiKD9t7lOdEm73Y7WcT7uKCtP?=
 =?us-ascii?Q?9fxrsnfcnyvCuuhygShAqAuCXk8zrykKzN+9tW8Ynj+72wKAkg6/17MswlAk?=
 =?us-ascii?Q?9NU6LQwf0CKZKJODrncLafk4RdGB3ZvgIGNy/oAZMJlrCbyEweK4yAzvp+it?=
 =?us-ascii?Q?sg2LpZ6oayGCL6sliJ2b+ei9lbkUJP6R2nrKPI0qw/YF/d7MZ2RIAdYLnE6w?=
 =?us-ascii?Q?y5znAVBB2qiBNC1DsP/8lCUAxGuNhvYsGR4PNU5VdeBrL0w5my0uOyUGIqJh?=
 =?us-ascii?Q?GdtgsYNyS7Z/QQtxMUxwFsBsP/yh6SIN6qLHjtU//n+ZgI/Y60Y4/9Gx/jUr?=
 =?us-ascii?Q?uCJGyE5FrsKTlBn67IRiIRHztw8s3YxBlqIuEwIXyPVeymh62CpugbEG6Ozo?=
 =?us-ascii?Q?hBhhqt+zxqL6gW/+fUnIdLhqCLc1QyEqyDfQKZbbVT1cAvMEXgiFFDMrdemi?=
 =?us-ascii?Q?2Vbi3GFL1rH7+tKrC6Yfc7aeY6/HZ39Jn0T8Be95rioO7sGTBC9rO80eXZqX?=
 =?us-ascii?Q?rOrlchIsZb1gY+g8PvjduNr4J24u0sZqQ8cM1CfIf3oDxnPx8txhxKhIjwtA?=
 =?us-ascii?Q?tutyg8LIGhGB6XMwdtrdn/+IKr28FPDNn5aKhw4iK865pirg9W+P3rJ/GRaN?=
 =?us-ascii?Q?JAwvBrzC1t3VC0YZa7UDwg5wno5k0sxJxErsvkVJJiCUqAyGCfqvnhqmMcVR?=
 =?us-ascii?Q?MLYfY1gr2SlXklUu/lDYvlEBNqYVZJd/O5Lp+lUyrZeADP62ViiaoLggpoPf?=
 =?us-ascii?Q?d7PoCvd71neP0qcccFtky9jSF2KDaPEXwucUfLOrzqELeo2NzcstxoZiVNo5?=
 =?us-ascii?Q?PqIUklhZkCJ+cHswx16pLa07MaQFgSI=3D?=
X-Exchange-RoutingPolicyChecked: khYE3RXhCR1HMUUAI9hziZvm628s9syWTV4fURev4TbjT8lw3P4a/BBvUZmg+l2IzAKtAlgLA0yGvE4V4wK67tsAV3ZMvYouQ3WmEQ5A3kadv8+WLK/RAx+lho39FOrT/rR3G9iPpeZxTJRrhDtB6hVrEiaJeLyjHu56olmnws1oALxSnMYPnJh28fK7XzauwRpnh1Jfhv43v1+B0ZjLbRGhF8EoOB9TOO8IVSipBSQ9yGcJwCc0L3ChmzIXYJ3TpE4kU3GoFXewtlC8JRrxeS2FMlOF6XXUo7vUSU9NNJ4G5x4tJj8niKVjFuUMaG00LycxGDuIltXWH9RAtxf4xg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b305d0-85ec-4a78-c36e-08ded5f2ec43
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:27:25.6939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3/FgjIkdsyoZ9clufhaCQ+z6KImeiP+YI4xBd4FHHnUrXqh1uMMl4w2fhiHoX5a3XFjHEDK8ih5yVilisoVHVz1wDo6n6OcAB31yiTZM8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9568
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

On Mon, Jun 29, 2026 at 06:59:37AM +0100, Song, Yoong Siang wrote:
> On Monday, June 29, 2026 12:51 PM, Shuzo Ichiyoshi <deadcafe.beef@gmail.com> wrote:
> >igc_xmit_pkts() reserves two extra descriptors for launch time.
> >It indexed sw_ring[tx_last + 2] without wrapping the descriptor
> >index first.
> >
> >If tx_last is one of the last two descriptors in the ring, this
> >reads past the software ring. Wrap the index before looking up
> >last_id.
> >
> >Fixes: 2e79349dcd07 ("net/e1000: fix igc launch time calculation")
> >Cc: stable@dpdk.org
> >Signed-off-by: Shuzo Ichiyoshi <deadcafe.beef@gmail.com>
> 
> Reviewed-by: Song Yoong Siang <yoong.siang.song@intel.com>
> 
> Thanks for the fix.
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
