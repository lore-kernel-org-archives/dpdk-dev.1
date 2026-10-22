Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7EF606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KmFfc47E
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB90C40264;
	Thu, 22 Oct 2026 15:15:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 0138F4003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 15:15:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792674919; x=1824210919;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jqPQc+RDIZ410xOXEfoX3/ppk3ZL56wnwR+PwTDTYJU=;
 b=KmFfc47Eg6xkFsH3fDjfHMF6/Tivl8A2m+Zcly9XrnMtZgUln+eVJtxx
 c+kzEPoXAHhUxabB1JE2v2ntOknIr45hszW7zFScJrTBu5QxA+ByN+hLw
 0njDqcGJGvR84cMWi2xtICxG52EV0aSkTm2VMDpDFmyoMEBdqiuRND9Qu
 zY7vIRBguKm4oTLj/zrowpPaqhZmKYdrA7fCVYHMTOKTxFrwUFJL8V5/W
 tXT1ocD+8RVkV7WCiBfR8wY5QE3Usg9F/XYbHUEqfTZx6iSJbtsFAnhws
 UxS9RlYtCS05yeLmDkdkyWYgiowgFZRTe7VYdycdXan0BL8zYeQZI1w0O A==;
X-CSE-ConnectionGUID: 5Q3JPXUNQiuErlilu2o/TQ==
X-CSE-MsgGUID: FxTr8EnkTQKRwT/wZYABTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1430930"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1430930"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 06:15:18 -0700
X-CSE-ConnectionGUID: znLRJCW3REOBS1c+Hsd7kA==
X-CSE-MsgGUID: BjIXyetfSEKwN7f6qs05/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="5183494"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 06:15:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 06:15:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 06:15:14 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 06:15:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxhotFbyq4DdrcXtTvV708FOUWvL0Ok7ZtKADYqrA+Y5RivCDm0hJTFfH8snECNFvSiJuvRd/S8fArJo8SPWP9a1Ih/14izdeuIfUvq19Qj6BSpQPAohVzNcTqMu0xqpl9FPwBdmL3aIl1K8axYPsOFU/nzqN7RcBhgCc9Kserj2tUcFQdyn4cE0VVAT8VTGWYHDZYAJUuMi0eE1zmsQI3dUxuuUlX6DyzjXCvPKPkyOHXEl/+hZSQWH1J6B9+KNFVX+1cWWM7rDiqfPfv7mB88FihqF1fz3AJ5vvML9LzMR8S97C3Vw9JSXn6IuLx7WcnkihA77LZMHpKhMyy1FsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pexmQHIVJ0AMebmCNXFvcVpK/9ffXVN4r6NflRsuF8=;
 b=h6mDD1mCkZkUnW9Vr2+qqBrbJjoxc4hYnRgEsz2CrOKK+03JhCopaYH0UiHSJlvXs2l4C+VPNh4LVYEgwE0QDUofq4GZHzR/HVeLaT7dnvGV97OIvJ4L6DE6gNXqv/zdgyloMzIcAS6RG4i2hf0cDpIfbONMNJVWCGVI4FiGfguQMLJiAd+So6T+DL+FGyWoSRvIm1KOuZmiDpW6Kx+Cd6L2P81bHKDfLhUdHXO0Lj7izQI2MCcOCeTX1zvs9kJBaIYFW+Zo6N6rCD6+pV8scKonX1gGq/GgQz5gi7PN2L70UJ/jIaXjGLKSsIfIIi6KZKQJpXpbzzbh3p2v5TyVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CO1PR11MB4836.namprd11.prod.outlook.com (2603:10b6:303:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Thu, 22 Oct
 2026 13:15:11 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 13:15:11 +0000
Date: Thu, 22 Oct 2026 14:15:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Qi
 Zhang" <qi.z.zhang@intel.com>, Qiming Yang <qiming.yang@intel.com>
Subject: Re: [PATCH v4 05/10] net/iavf: fix generic flow error-path leaks
Message-ID: <atoMWtOT6uF8vJZT@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1792592724.git.anatoly.burakov@intel.com>
 <cover.1792592724.git.anatoly.burakov@intel.com>
 <d3514bf9087c4d9477937c885cb5c4352de642ec.1792592724.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d3514bf9087c4d9477937c885cb5c4352de642ec.1792592724.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0030.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::35) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CO1PR11MB4836:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d4c545-65f5-48b7-7cab-08df303e80ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261021121427099003|56012099006|4143699003|11063799006|261009223027099003|10067099003|261021123027099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: IyKfNQ2nC6m2tGZ6XdGeXFofj/fLIkNLrTBrxv4rPR0DMknFUMezyFGHmVJnVVrHwNU5/ft0OJuEfzV/zoM3xjBahyo+WfLiRDGcGr0elorFsJVa9h+rF5yTDCM4PGd3bd2QmpxRiVYml3vvvhwtC9NeWeWGtE0+5VSEI2gnywCa+XiBldVfQmQY9gIcA5vTew3EAvE9Q2lJPKQo+rCf7YBwgoOn3JwEn8aH/msSwIe4pfHpQFHy75/Qd/1Btmrl7+h/LWqT4Mfj0YC7i5Fk4sifqrUD7xzn3wPuAr9Dct4guuA4iKOvrNY8GxBGue9Oo7qi5jVMQP3dEjpv80FZ8PPpBTUFoH6p/m746nkeuw673rUr/atYDK7hWZWHQZ3c+KzSEtr5AZiXSflZm1jHgnoL6AARh8P3lwabMsiDBg4sJI34h6oaR36jGNxBU0MjY0cGIy/iRuBxZILJ8alzHR1nB7uCvm7DMOoz9lUMzgpI69rNpvBqO6CiZsrRIYfmnIoRgYzDlqSmiUtHTqoe8uXsHyYbrg6/rbl29RZAI8CNCZhJehjhRGEFdfxwkaWtCMxVTay9VEZXMtqx7i5gH+We8DwVdrEvELi6WuxPT+EfOQ3WDhJeMW0egbYQ/OBwoOLx2B/i83jJ9Eydrv0k35Mw+cckDrXgC/Oex9eGhTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261021121427099003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(261021123027099003)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aLfYaiGWGolchVE2T0x6qpgNo+pbmghty29NZt1Fnfxk6TMbrdHFgbhjMnSZ?=
 =?us-ascii?Q?j4AV/MRTso5b7jXjIs1eciZbaRZpeLGOYH29v6PTeIEhnphu0Ff0rEYkidB1?=
 =?us-ascii?Q?+Cc8vn5JwlGxDGOzcq93THCZxvDXWH3eD0zr9wAugr4cC1T9aC769B+3/zs1?=
 =?us-ascii?Q?r5b+ofrcNKARsDPgS/W3ywFPvHblzKqVRRNqYDZQtLFFF1vvhwLw2y8RR6xx?=
 =?us-ascii?Q?DeKufEScpBEz937Yy6mcYDaBKS61rub+n0oIPnmZvyJZH2rNKknUS16GEDVh?=
 =?us-ascii?Q?hdZIkp4m3Qy87E6m4u3t6OYd/wwQkiVNXYyRLOvlawYyjDeMEY1jV9Me2sOT?=
 =?us-ascii?Q?4d5pAWTh+G1/Ozg00EJIsf3yTSGB/yFk5mK0O0vKxn6gjgPEBl0B+jiaCS75?=
 =?us-ascii?Q?p5pqNZi4DQ03YoJnR35qmvLURlfVBrDGWsy16oMgqL8o7eGjPWMbZuecepP0?=
 =?us-ascii?Q?q+DwMVwOYaSRQuncrdpiQYEY/nJOX1i0qcMr5s4ZH6bYhvEI1CqDP1Cd8pya?=
 =?us-ascii?Q?UooukfTpqtw7Sb/shzOYgGXiEUb74Bkwyh2sDZHVEYOcSKS7gru5EsQfeKzy?=
 =?us-ascii?Q?SRVzOsiBJbZYlYw12mu2PlZhk1buri98ENwXBOyTOaLIEB1vtIHxXG55YKiS?=
 =?us-ascii?Q?4og5a7bvKtVrboz6HenbgAN7PddRa9sxtXP2x5947Q5WuEY3WZ05NurXPQcm?=
 =?us-ascii?Q?8rFi5zrQpDTUlKXrmbuOlB9UCuYay7H/OXbNoHG2crXdpwbAUcgtc6s0yAnJ?=
 =?us-ascii?Q?h09qjbZXJ8CBmAOqtD/GWI4Ak6ZIFREaRMq344wjXIB13kQYzgWlWRXXULRe?=
 =?us-ascii?Q?1D+zBRfVG6MhC0ArtnOuGUChESyfAUpIMSPpIyXTtBqFoNqOULaMX+YsgfvC?=
 =?us-ascii?Q?7QiOeR4I0Ai/2WXnMdnfXJEmADxDDaNNXUuKkENqsAzdsd/7qfe8+z4aWS++?=
 =?us-ascii?Q?d8U9/0tBiVkaCxhUQDhOhqf1s9oXvRh1pEAaJ6c3XYrtsU4UkPs+KmdV92wS?=
 =?us-ascii?Q?FiUYhnIQatBOl9brhmd5mDhRB25CHID8NvCos2OgpWqsF8nGuxojEUJKb8Y9?=
 =?us-ascii?Q?RUwjJ47TG1YWKoRmtggC/j/mZFaLK+HAJr/Ic23qax3VX9YpT9mBtP5OvxU5?=
 =?us-ascii?Q?ILy5TmTAG8DwMGvvbYaxPjw9Y+hLmv2Rx6d0ZxmS588riF8/NyPI539ZKMml?=
 =?us-ascii?Q?YhkECnLWqEssPe5kOEmF6pXM17BAiAAMwlTNecj9tUmAL3cCxppajrkroEbS?=
 =?us-ascii?Q?9Q00xTQvIpQLzkZ/y6ZpXo17/UaTHUIb+QzybaQLMcDVwb3UANn24/TSo9R+?=
 =?us-ascii?Q?YZGEYvDpHxk3nnZBzbVih2DeMG6fYxqS1evPFzNkhOSXlBl1XtieKQn1ysMt?=
 =?us-ascii?Q?PK5J6UB+C5bualCC0XKoePEvO/DJk4j+m+sOyTaIcsBvbTmn4rAO3IeLPRTT?=
 =?us-ascii?Q?LWqVxXAIVAcoZUSg1j0Z3F/HDEIw67nI8f3/q2kgUHkksDK75EqsxjSpUhzX?=
 =?us-ascii?Q?h7s7iwH8RVViTSWwSw++V7k4Y5SyyB81BqChoE7lDVM1aGUL9gU7H5QV6fPT?=
 =?us-ascii?Q?cFfdaP8GfBGznM9p6pH51cnlMSrwMqrGOxWBq0pOdnX6+NhFrGw/XzDoDYG4?=
 =?us-ascii?Q?vxYMUxMk3UX4Ej5SXbyM+4yX6MshafDgmIhRVmuA+Ddx3NX1Kci/KJzVld3w?=
 =?us-ascii?Q?ntzoKsFStbwisQPw4lnEW3ZdyUT5CzF4TnCa6xtSFOmCP4aCNP3R7Shgn7OS?=
 =?us-ascii?Q?+0wYzHWQRzkZwAXHBJTBTwLuGOGtdbY=3D?=
X-Exchange-RoutingPolicyChecked: o42Nrirdded60xCFNub2aXGWI6bRCnRHUyocZLufziCRWQ6WqWUbODfVrETzEYiBNsb+yj6Cx+p+j6Swik8HgbfKYRnzgR7NsqUXb7KXhYix1EV4mQybyEoZVHCKNuVJotRIrajN8NLcks6sWgSZzRaBc/EonwaMVjtl26u9VSODEvQCMDgjFitL3YlSPe1QgKxnZIi+tB1c0exr1EDfkL3N1BaRY2EdJKR9aolOz/iZ4Z0+xpRsry1OxggL923s/U4+hin1PYWBHr6PwzRUOMry3THo9Mve0U9wQRbGYtM1E06NRV7252nDCy6rfOizEJgEuEB4iS6RfhjSxbdK1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d4c545-65f5-48b7-7cab-08df303e80ac
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 13:15:11.5880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuvmybAT2UxVVIRb7IplseQYwJYU94BTcTJPibQqjDNZZU5jvbpqlu+/fUBJppHeb/BJ1D6oJ4xjxZspoy6v4C9f6K3AWhidshtMKtpLSsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4836
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 03:25:45PM +0100, Anatoly Burakov wrote:
> If a flow engine fails to initialize, parsers registered by earlier
> engines remain allocated. Pattern matching also leaks its item array
> when allocation of the match result fails.
> 
> Unwind registered parsers on flow initialization failure and free the
> item array on match-result allocation failure.
> 
> Fixes: ff2d0c345c3b ("net/iavf: support generic flow API")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_generic_flow.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
