Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6BFC5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 14:14:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98332402CE;
	Wed, 19 Aug 2026 16:14:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7D8CB402C4
 for <dev@dpdk.org>; Wed, 19 Aug 2026 16:14:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787148883; x=1818684883;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hDdpdiNM272J2Q6D9p1unuVKZZ7VtqtUbSajLaAE9Go=;
 b=Je//6jp5SlEobmvIcEVncfnypm3rh/jPGfOASBOI0JpaPYc+kvKTRYXF
 JK9O/fPOdweZtZSF/7zHpVs1rltZ8UvUh4XhcpL1CD3dtUgoi6t1UrEIJ
 QZbfZMJJWdSuxz700O5YjUilt2XUsma+/h2dwtOfcG3JLLe2Cn4GkCptB
 H/AFIhq+fxHKILv+T/8Qk3/LrnE9ebVrc8ZgVwC8/Ol85jdqAV1hwlUlM
 ajQpvft234j7B87mV8G1i4b1p315avnzfxEqh8GTQOGNHilRJLsVsuOOV
 ETagS4Gj2ghA7m4yQ9UnI1cjTvTGNY7HrSJEFAsvw4lHOdddTeAU8iY6g Q==;
X-CSE-ConnectionGUID: x0z6xUG7QKm2Ls+F+EVYSA==
X-CSE-MsgGUID: YylKQHeBSYCQH22XRsoMWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87522124"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="87522124"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 07:14:39 -0700
X-CSE-ConnectionGUID: jA1Ez/VBS2SJb8aADTOHbg==
X-CSE-MsgGUID: LqFAH+oHRjabBmvUOv1FFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="266168226"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 07:14:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 07:14:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 07:14:38 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 07:14:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFeqsyfDek+rntOH6lguEqaqzZpYV43t0GO+SFzd0Vz0Ul5IbBxWp1lu7XnGZgjroEMVbtY8aDkBj+mvxjogeAb0/u4E3crUyvBljlnxk+lH9YmOpEjEpbUyPslHn3eT0zi7fvsSmgs1dsksWqxQD8m44wmiARQBuYZAbxQrYPyPSNq2iRp+nmxBuD+wvPyLrygRuu1TAfWqgw1OKGeWETkOeDxrgodhtYqGD64vmW88iWVJ8ACeCvNxuy0/WGmOmcspDo8ZH1H5+YcZrmMoO3MhF37I1S9IE8YqknArL93ijFbmSU1XUdz6PnLieGGrUP17iHqMw0kUdEASK1F9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tl0/HnLL2koWPoQAUnfAzFikxkVylH0yxz64eGcxpGI=;
 b=ceH1zJUMMC7/tvRe1hk82p9ZNfK/yg/ENQC8Rjxc1Hoa/XJ8Nq8KX+p52Do/buVpctLBl6/vBt83woBqn/NbjGWJfojYJ8SnmMPPBTthJO1hk81h2X1yUzmODrTUqzRi3KNZL6CsDEm2SNf0rfxhIzALL133FeN6uuWXRSm7JuhR2CANtOHVc7f46ijdvViEl9q8N0GCa2FGncTguaIbv1U/aW3Xl6BMX4p/GqmtI/TQZDWxIJtbqgCVu7t+01XFVnBSXX4lwf/ghXMoAxab/uzL7TUMAY6WYA4J02EdXNfyKzpH1viScvFYnRF6V+/wFEech7kXUlU6b3bN2UyVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA0PR11MB7283.namprd11.prod.outlook.com (2603:10b6:208:439::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 14:14:35 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 14:14:35 +0000
Date: Wed, 19 Aug 2026 15:14:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/ice/base: add missing devices to supported products
Message-ID: <aoW6R-GNaIuEKMLI@bricha3-mobl1.ger.corp.intel.com>
References: <20260819184147.254069-1-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260819184147.254069-1-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DU7P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::17) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA0PR11MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6ff4fa-377e-475f-241a-08defdfc329c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: QTtav+NMWkpgyxOQe+jREp3/w0GSNulcgQHJCpjPVgRs2YXFL9kTf7C62UyWezBXjiPRVgFfD6+YUg1w08s439rOgPX49/83HD1RxF4Iu2Q3F171kkKpsDnPOu1Vfa3p7gFQ0KXJm5OmRZeJuwp/p4G4LdeNysWXuNzyloUESlz1CnZ8U/uGpipe4H3cMlPFaLSRwl6ZZOsAzx/GY3sRPSQFGx1wouae7Tn4+GMYcvUTlcadsvE8mg8344exbXoXWat+Dde1bvXl99Ohe0NNIX5cIBF0+J+wOtpQ2kQAPEoJcxO2cS/D4ZY3JoY+aEJV/LNhz9C7b7QrSd2IVRdFuNkWrXshKef2PQ5IgkrqtJv13GwPlJBD05l0TPunpjykGKgAJUUSqX37rGU0BEiN7OaHgFfoMH0DsgmE7dPN8uHepiNKOxZ5oCpZrq6mzaH/k8WnFwBh5nk6vaUiRnwcYnAYXwPCkI0Kxo503lJWngYGjMq/Q2YqewyvSRNAj12oiRqN9etsVIGjxHIQmZcOExZBFwR63v9BQJOvpr8q9kV6QcYi12pbgxugT0aHopETRpypizLYCNG1BTrasNOLe8wkOIbBFXtD/67ZQXFJp0GVgukDGh9nq3D2ovIfCKYbxP5gsgx0CQpLbMpq3gyGZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?txg7afmHAb9KVaGp2OoxPXFfULyYhzTFfEO9RFUMv3jGvtGiJkGlYdGRFgBa?=
 =?us-ascii?Q?aYErqa09y9hTBQ8bWainPrXxq9d16w+Hx20cKDPrFczncMeluiMrl9COla3V?=
 =?us-ascii?Q?sLhahzYDpEPaCMvCDvLXkLcpXdOElgeyvxejT0+24RvFaOxnhWfv4mAmQkCZ?=
 =?us-ascii?Q?x+O0qsf0cD79fovxqDOn3PJ4yXf/cSTrXAthCohS6EucS2dJO+nw8p3SwVfX?=
 =?us-ascii?Q?j1uGT+rze7kt6oBwdMqxmkk8LGF+wK1hfVmwycATaaS4YfsHwHwV0jx8TRd/?=
 =?us-ascii?Q?I1oAQoyTSfu68HcQlgPyMBFtujqO8woc3CrzjO4VxTxVVgRq6xPtbMA/td0i?=
 =?us-ascii?Q?0ggghuEm93qBlIyHyhroXAuaV+P7mau0864gAm105+Ybn0eDQxb2gxMq2Ju2?=
 =?us-ascii?Q?IHJtZJGna4sWTsVWOTklxXmPMOQPc8RkkeVqiM/gLqhoNqIgRQzpnH3iAegt?=
 =?us-ascii?Q?ApRiNzEn4CibA5f/kuAJQ/G7zfUt1Pts9GYGXPitAJGINPjAeX2zyfHXXrtm?=
 =?us-ascii?Q?91xx5xXCKpCEJ+LHkhTMYtWmQ++BZo/aOTapWAeh/NyhuHCcvA4SafXZQDEj?=
 =?us-ascii?Q?7AwvQZbWpyiuMkj2R+cOS1pNbxVqLZzU+9FaQLZ9oNivhbQpSz/lrpX6KyDx?=
 =?us-ascii?Q?mSXVmbSBkQC8ZGkaLjleyap6TuZ//mftaxjt8J0SQxiw5qZVFmTPS50d7PPx?=
 =?us-ascii?Q?k+8IEM6e/oQu7tIjO0rjlW6GP4tJGyx207jOtqTMd9+YkIwLAQXvzXuy5zk3?=
 =?us-ascii?Q?TuvxrNwPKkMwHg1MKhb3Ht4Vq9FLOIIpM+haoGNm7uXTAHW53Awbu2mnY3V4?=
 =?us-ascii?Q?aJjQQ79PnER529R+7hMfq92AMQVw9oKpNMEi9xHokzeLr0fOfrvc8WvFbOKc?=
 =?us-ascii?Q?BE/qP2H/AJYxvNaXoSIpW66R/4EsRtcwUsS27hh66zCaBCPpOq3Tn+1MW+53?=
 =?us-ascii?Q?LAkuxrPL7lzJcUrbf0WzaouWdXS3pQRm+fehAsAn7Ewy39ol+2k95QEa3Bhe?=
 =?us-ascii?Q?RorBEGiqxRuHczUTuz4TAl995ge61+tWRYFOYvfZSK+Vy/0kyZitR/Fvc5Fn?=
 =?us-ascii?Q?9gvnQxgnjlC+h5v03GzEWSNpzxOMUmXHJPKKBOCFJgenqBEoutq2HQ40Qe0X?=
 =?us-ascii?Q?gXj5DSDOft/hIf3lGhQRZLdGS1lnyJEicAPXhsqgofD28XzTPkHr54Vh5ELH?=
 =?us-ascii?Q?16YnBR5gOb9D3QCniNEHKu0X8Ws+jiJXXe/jJBsi51bbpU7Y4iteGFH+7R2P?=
 =?us-ascii?Q?vdsR0bHwK0qqjYYq1IpE5zrBAyHpN5GWdzBx0lMiiBW0PLL2hh0TbJP8xfTe?=
 =?us-ascii?Q?5VbOQ7O7d0lMKCpK3vb4C11S7KhqrU4Yc+kL8BwLkmEmQYsPsznHhXfe3KYO?=
 =?us-ascii?Q?rCjKcxyR/2ngsbsz4hXjelgDQOvfpQF+u12Ze7xWF36AZBJClB+4/Nj4AO+b?=
 =?us-ascii?Q?/07Ni9DKbiseW00bxvhofiF8bArYYfFmn1ctr2PY0fAjAuBQooUAd4YH+sGq?=
 =?us-ascii?Q?lfLTqd5P520dQUvYWJ5c2iIyTJ+WtSZP584c9W41oM00MxOR14mgzC2wEE5Y?=
 =?us-ascii?Q?CiSTt/BjGqiu2SLcIrcNgrNyb6FaO17nDqZmttnuZo/OvpKLWZCHAIO2VY45?=
 =?us-ascii?Q?9MrLNO18jIjsixyhdeNRYSWUCZBrkl011yjXyXD90Y4QJNT9q46l3U0NgO6A?=
 =?us-ascii?Q?UY6hUeiHPfl0kOtK6U34+m8PvWvAlJqAzPHLzIh0LNyeZNDrmCqrFQ57OA8G?=
 =?us-ascii?Q?MLUzd+kJkQv/Pluwj9uj+Uj8wP0h+vY=3D?=
X-Exchange-RoutingPolicyChecked: VJEpslZ4MITCshZufvRZhdq/LpJGobcffoR6s4Huu7HCV+FcIG85W0Uz4VyWDxOntEKN5GP0w9ZBp7bDLV2965mvgjnyCuaqKz15vD23iWCq1kBb5R4sDEdkxKaiX7qWJk7/9o8UunpNQZzANsP/cP8lhylw4592SAPje9Ssdu58UlkFNKIauqDFwkAWubzqfxzWirQtm2vUmg/uKzMaBtBhenfmEDxOlBsteju/P3TQIYpjbmRiN7v/StTJ7DEVyoM9qm9U3agnJD5XaD9rRmJZ5L+sScl9MH+v7VxFSfvM1vWgBGPFdWCzN+vwPE7q6ag31kYLD3FTnyVU49Enhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6ff4fa-377e-475f-241a-08defdfc329c
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 14:14:35.6996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUVDAG3lGfJkBwGwn5vapXmNXU3THFen1508dtCO1ZJpRSb4ylNRUhK65QN25STq/trRm8CHAXLCFpnbTdhH2+KOVN6qvWnh/MIO1KLgbhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7283
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

On Wed, Aug 19, 2026 at 02:41:47PM -0400, sandeep.penigalapati@intel.com wrote:
> From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> 
> The ice base driver already supports the E822, E823, E825 and E835
> controllers. Add them to the list of supported products in the README.
> 
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> ---
>  drivers/net/intel/ice/base/README | 4 ++++
>  1 file changed, 4 insertions(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
/Bruce
