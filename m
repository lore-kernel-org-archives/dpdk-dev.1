Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABE1CAC5BD
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 08:16:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EFC640664;
	Mon, 29 Sep 2025 10:16:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id E0A9D4028C
 for <dev@dpdk.org>; Mon, 29 Sep 2025 10:16:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759133799; x=1790669799;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2+qM+MlyAlY0qEa/XYe/eFGMTbmuo14jFMmyzdFa+Hw=;
 b=HN7MbGiELqeckvZg5KXP/zQNBqldxMJVVVaodobOc5xSMD3JDntl1i/q
 K9F5t81apSkPXs9C8qU6X0joJ3IWsydQjOjZjB3Sx0Ltvf/VZ37d8pvRO
 27O3qMt2wMs5iQM2pczzvhJxeaIcnUjSAsC/UVwPYHdnlMOaG7TZdOGaV
 XApHw5sX4MluHXTA0kMahWdiMzMrdzLwdCsk0j+oMQimq8B2byZ1C7uDN
 W5PlZC16WBWfwJjS55CtgI6vzu+FOYPIgta0UzvBwjwxW/kGWA7MngwX7
 QFZ6PN4IKH+FTzdFyPHng8T4IQH1nzw1I/+uSYYZJ7S2+y6s2Fwdm0Fk7 w==;
X-CSE-ConnectionGUID: 2wvyKPLlR9qNJDj2C0rFzQ==
X-CSE-MsgGUID: WKY33GZPS92XPgybHLyl3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="48933999"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="48933999"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 01:16:38 -0700
X-CSE-ConnectionGUID: tt5dT1O9Sn+ougiUPDBo7w==
X-CSE-MsgGUID: cyg0WyLrQyyAcXEPgOoo5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="182469924"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 01:16:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 01:16:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 01:16:37 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 01:16:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JU4o1kO46CFSiJccBTDOgsuWMjmAXodp7uBuKkcXDlvwpmurO92Oof6ClJF4WSy3Io4mo40HhvFtPNeKADsf3ktrDV1Ursm0bvmYUcvKyfJSzrGOYRSpY9+LQWItVZoPVWGBMG0iCGFKJgl2nTa4JN5RB7hxBrU/T9T2B3URCs0Enp7zuA+rt6oLRBV4aekPXyonwiGNsu0DWgFBlqD41E22W3CHNe6/M1fVnSZZCEMZQpkH6D1zNknxceSi5ycNBjB4lQP/+IrT+HbotyIh+he8oxAfgxt4x+jYkjtsDfJmBLpTT/0aXfjggEMrIdjSZTNpTyicxfXqKS32azX0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRLkzfGX+gmpKjFlPLza+RysBsQfXroug9Or2S4HpzY=;
 b=QfbtD+vPKjuVQht+6LFNjIO2I2RGyU3LytYhTZ8OhfSoh7frEGUGHBauH9aNuqztRmDUPAi02pQaz8cGHemlzq6y1oJph63kx6NQtXN3kPRFJq5dSEDvfSqLU61n7GiLJY/EcGIKnvTdMsjcxLigfy3prfEoDNvHBz3X5q2KjKBsQ1dzrARydQO1A2oGo3PqpyxgUzaHzQ16fMk8J8TP6sVaR4l69c+8jNyNjPwJTC3t7hpIEi3kdHcv+3GRFH1M/T4hkp7yrjAJdTPSfkyR8GUEVsUPZbUG378W+mchnTwYv9mIB8jM8UDErC1eAAjz0ovXfwiU+4/KNgVPIqupmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB7994.namprd11.prod.outlook.com (2603:10b6:806:2e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 08:16:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 08:16:34 +0000
Date: Mon, 29 Sep 2025 09:16:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v5 8/9] buildtools/chkincs: use a staging directory for
 headers
Message-ID: <aNpAXuCNZmNy6bAR@bricha3-mobl1.ger.corp.intel.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250926124103.750844-1-david.marchand@redhat.com>
 <20250926124103.750844-9-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250926124103.750844-9-david.marchand@redhat.com>
X-ClientProxiedBy: DU7P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3bbe54-4659-4166-616b-08ddff3080b8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ts2q4JJQ6x0/nDoQEdD+lqRlEOMm5eQSRQCG2WBbOU50EJE0KCwlA+569v91?=
 =?us-ascii?Q?P6QIpgaNUwsWepxtvjsY54CpsJj/VX3dFp2SrgKaXJEPNpCjjV64G8vF6E8i?=
 =?us-ascii?Q?8FJFpFL4CgJp9bvDzx1+Srt0IVjePc3HVOi8hvJO2GYXnnQ1xC0vcVOXAUdA?=
 =?us-ascii?Q?L6WDuvsh//O9nfbXCw0UKl3gZUYFqV1WZoH4vD/D0RWUFzKV+FAKFAmM4HAr?=
 =?us-ascii?Q?XC7ep7uLVdvpZxWGFwc87kAf3NxWKCgzz+322BS3ONJDawGiA619GaOJX4xt?=
 =?us-ascii?Q?oUY++U9onKZE1FjVyWj4Zek0fo5uSo+UXE6Fjh5Zb+uIwWOKCI2ITIDsdkZB?=
 =?us-ascii?Q?KRw5S09qF64PCpx17l3MxswwqIV/NWL4Z9yox2/NC8a83Kj/VZA26/MWw1d3?=
 =?us-ascii?Q?fHnXFWMaeoAsb9GBsBZVw9P9EWeoepUMqSCjkrjqIKWTk6seSKPPMAiYU7jJ?=
 =?us-ascii?Q?ZDkvVxCGqCKK39NDoNQwInZNuI//804uAlgpHprFhGobEdCtknY1vxS3tv9N?=
 =?us-ascii?Q?2UExkR2OgDS4zDtiRf3dLl0whkwuvrghjHMBqn++ENX8hu67Epl5Xo37HCaG?=
 =?us-ascii?Q?4oC5G6SRtJvOyzQI9S8BBcz776A5jHwek7JiiCDoi8AJolgc49+vn1Kjkptn?=
 =?us-ascii?Q?9BCzzuhGe9J7oB7oxFtFXRdbWxVgvnee2jCiY45OQE+pvzFd54rinenbMXzD?=
 =?us-ascii?Q?HnVL1egfgSo/LmHccp4NYAvRsXvkwGBMnheBd4uqwY9eCst6SY+I0BH3iGNt?=
 =?us-ascii?Q?77KxkjbQ23GFH+Fv/n3N3pxAJdymMvldhHHHLgUGdBSusmRmtAGMeGeXEhc4?=
 =?us-ascii?Q?b31koz0hWPH8QVidaSn5XHqgV8Npt1QNw9AAN8e/D7KUhVC5LwN11V8mQBj1?=
 =?us-ascii?Q?ysCNCfwuh/vbkhUcVmEjAbC1wD3I2UeS0Id2MKqGx/VpJ/h2oUvtHJ2v5qHQ?=
 =?us-ascii?Q?4l/L3en0uIR27spOZeIYt37qrDPb49BzoPa5QGTU8oNyIA70JF4xFUnYyMVK?=
 =?us-ascii?Q?SvgiOxMtXzt5F0TjTMS3fN/r0faKDI1l6nXcAlOaeet/hlB6qJ1x3CrBNQbP?=
 =?us-ascii?Q?oFCnyoyy1rApt3cI4jcyx/GGjqGBXEp48Auc/ryULsC7Q/QMAe6H0KW6CfnW?=
 =?us-ascii?Q?V76WkEPdqehG67D5kBsNjdZnIUp4EawPTzI9V2YZxuhq/OkrNwF3n7lK05Zz?=
 =?us-ascii?Q?Sh4Eg7VcUWbVO8iwUfPF8KohHEGO/GehnKLmDy97LFXxvoQVQGDavgFMBYH2?=
 =?us-ascii?Q?U+N2EPQ2I6c8/KkQQEPllrmAqDdWzA5XoEL1QkLmBGoOuvgPB5QEvRvNmIaA?=
 =?us-ascii?Q?OSKs+7e3YYnKxHoJ3ooXHGWW3Gb9U+nlGlgftMz2LrCgal/POvjIJ0Luw47a?=
 =?us-ascii?Q?G2expc1/ApRpYNiSmIninNU+qSSjkSEI/iE3lRKFNmgr8F+1gC+f8sOssE3D?=
 =?us-ascii?Q?8y/sGHSSkP9NPnk8h60egZYFKl+hdikU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hKjO4YfOIg34HBhZxDlQf6KCP6XUeZUxtc4rWnqDJ6cubN3nFkAP/ak3We1X?=
 =?us-ascii?Q?mtvylnuyn5AnvAx9d0aIA3hsTTMPrYIrzLf77gaxPoqwUMCjDpwXJ8+GLR/b?=
 =?us-ascii?Q?Ixf16RuC4o57U6hwNms0+7Ol8yKGPOGkh1eyMbLprSWVBy67tetLg76yF6bN?=
 =?us-ascii?Q?v9hmo6eDG69Mp1jupkA6BOeVu6ad/Qv5f2ngJ/LQuBiRGX4jmKFG2DPOMLqx?=
 =?us-ascii?Q?IXVyXZ6c9iD2ZCQCVIRcnZNFdKDsDglj8KG0aDQFVHoVihkJ85jXPKJzjNyX?=
 =?us-ascii?Q?UOQs1MHMIVK+ByisHVezwPsJ5dA2GmLV6swK3y/bxpjWz50nwoM9uSJGOsAF?=
 =?us-ascii?Q?7JTwohDhlnTZY2eKalngvAp0lsjl54WawHWm1k2wqkal0P9AO/MhTHHzyiOy?=
 =?us-ascii?Q?ZOq5VlIAH+Qee3+Jilz9gO3V3uHPkBvr0brUEPXyc1UWgBsWSTswxqAep2fQ?=
 =?us-ascii?Q?blqCA2CV2lbRJtlm4z0+o7iqLDi2jpZ+/KjHSyTj6S6nSCx8sWBGRp/42V/w?=
 =?us-ascii?Q?aAS3LexoZTqrmn6R/tQKGsmvkUneC7S8ALEMnJdCxwA1WaQGcHOkQAcvEc1X?=
 =?us-ascii?Q?MQRfukAHhkqUDOB2j5hketST1ASXKLq4whOA/Dwh5TPrAdK7Heim71w/CjPi?=
 =?us-ascii?Q?iolrd3wFnaljnSzzsY739nA2tGvYwa/XPGhbkWnxGVe5of0KZ8um1VEKMBiD?=
 =?us-ascii?Q?uzJVi1dEKaHgrtOJhrrR5T+jZ6qMfPDjWmFtsfbOkVoJbPLLylvoUo4WrnRF?=
 =?us-ascii?Q?xVhwHct7nWm/jH6vVQTRvWHJs/suH2bGBrBnEgExisvCQQXuQjrQcXvO40Ih?=
 =?us-ascii?Q?UCW5q0jRKfm8Lkos/BSiIJFfqecqvgNelccmC5juGcDGnBWK2+1IizRZ1om1?=
 =?us-ascii?Q?pB9SwO0mYx3q65vG7IbQ/Slg0kaLEZKJ+At3fJs6UBJqXWe9ll+7P9KsH90l?=
 =?us-ascii?Q?600MRTj33A7mvzN9uZmfgIu/jqeVVgeTRu7e5EM39Di5L1wjXDhEfH+tbQji?=
 =?us-ascii?Q?/nF8XPEEYoahj6a4VOC+rj2KwCp+vfWbf+oY7OdnEmgGpXSeU83E5DDcBsmd?=
 =?us-ascii?Q?ZodSWYMitx9ijBLN8s8uXUVTNMRrhq4/jDUrl/klB3inkEpZMpGzfsSplNVP?=
 =?us-ascii?Q?XS9ieqkQKtoJp/7MQx2bz94gMgr8V64y/NdLTjxSLrXuwhqt0+p91Nod+pzj?=
 =?us-ascii?Q?YS3a9mgpscrown/J8bRSZhCBREDLXhkA6jDyI684jEvG1Og7SkLEsAx1HFNn?=
 =?us-ascii?Q?qc/Loe9Qwar/FGetBafGK3B4fAfWEIWLvfI8b2y0B0fRZUeBrWNJ31Jd1uzN?=
 =?us-ascii?Q?YLK4wOkTKlgSpukoDe39S7CMQZLcOo2tH0zPp7jsbwaLJ/OHCaeKwC5gWsEE?=
 =?us-ascii?Q?b0/5ENDq4G2B4P0ngzQYnOPVw/XwpzU5zVdTXYwhEKq2ItX7nU4BM3d4PXXw?=
 =?us-ascii?Q?7gLYtw/ycHOKR9nz0aLE1FXbqKX2J6elymK8dEXyYysgMInuf443R8xIaSs+?=
 =?us-ascii?Q?I3c8RZ/H8YmLnpn0ELV948mDY7OBl9XVvILXtCtpvJSPFhlkCum6TzanJFCq?=
 =?us-ascii?Q?svKiLaDr2OjhKH+hC2LqGfWqBd0we85wSXiP8EPIE618IRW9x+C+AN6sU5ST?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3bbe54-4659-4166-616b-08ddff3080b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 08:16:34.1499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GCe71zdtKyI/OFYPZsoUT3w5LpUFvZcESwd5FAwDuK3xK6GGG58Eq6MCpNg1qyRmMeaXM8PBvvOphmL69Hp514iVWRa5cwjKQtRYuEm438=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7994
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

On Fri, Sep 26, 2025 at 02:41:01PM +0200, David Marchand wrote:
> A problem with the current headers check is that it relies on
> meson dependencies objects that come with their include_directories
> directives, and all of those point at the library / driver sources.
> 
> This means that we won't detect a public header including a private
> (as in, not exported) header, or a driver only header.
> 
> To address this issue, a staging directory is added and every header
> is copied to it.
> 
> Drivers and library headers are staged to two different directories
> and the check is updated accordingly.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v4:
> - split global_inc (isolating config include path from EAL headers),
> - moved all changes under buildtools/chkincs,
> 
> Changes since v3:
> - removed update of global_inc (which was unneeded, and probably was
>   what triggered a Windows clang build issue reported by CI),
> - moved all staging operations under a check on check_includes= option,
> - moved staging directories under buildtools/chkincs/,
> - renamed all variables to reflect those concern the headers check,
> - made chkincs binaries depend on staging deps instead of having the
>   libraries/drivers depend on them,
> - added C++ check for driver headers (missed in v3),
> 
> ---
> 
Played around a bit last week with options for doing chkincs, however, I
didn't find anything obviously simpler or better than this. Let's go with
this solution!

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

