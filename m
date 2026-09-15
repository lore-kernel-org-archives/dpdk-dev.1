Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05FAC88E7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 16:35:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90BEB40265;
	Tue, 15 Sep 2026 18:35:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1A6124003C
 for <dev@dpdk.org>; Tue, 15 Sep 2026 18:35:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789490119; x=1821026119;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HqVGgsZn5R156ezSJS1ozzlAYUx5B68ZlH7X8AMdPV8=;
 b=HHjOJUuE4c45RYjCxUhyqilLqOtrBmln7vaFb42u9VE9pTkUDVMtnPf+
 nBYPGG9XJPXvsEwM9ubNYeCxFfSIW/+SE+ZTP55XCv4gevR8igpfU445i
 G9PyI4hZT/5g+UI+Uf/sX9gRO9iQHe11vs/QDFdG8kS1pUSXyC5a81p2H
 Y7ltkqGSjKTAaJ8Pey/Cg9MXpc4B7MV5c9OUeW2ODRJ6Xlai7V9yIALc2
 YihRFOEJXiP5Y/AX1EqegeB3Yl6kWtN5CnZ95MCwNkfCiEJBxjjTqPpk1
 mjbKVZn/VzTbAzlL/swbHn+PDPIMGNb031IC3ojPn4JWhQcSmfBJvUcmA A==;
X-CSE-ConnectionGUID: 4ktDl4i4TpeLvUwmjMZouQ==
X-CSE-MsgGUID: C1pQ0yhiTi+nCCJMVlLiig==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93559729"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="93559729"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 09:35:18 -0700
X-CSE-ConnectionGUID: RiQLkpAHSUuCBU+lo5L76Q==
X-CSE-MsgGUID: 0B1LmvM4RxOAQs8ygmd8ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="270440047"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 09:35:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 09:35:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 09:35:17 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.36) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 09:35:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j49A5Hds5pv7F68h8HL/ZBUeh6U2a9+reKnHaMqY3dg60dLdTLL4AYu7/HPnPHZeRLXMCCUQbbdr5yGQmhjwRDrLHgqUtBFZq/0qCz6ULTKRpGU1vG2z6vnelTEJ96ff77KWrHH1d6CWzgp5lg4qIsV2z65c1WqiaA/D1dX6YRgBXdan4f2SRzf/6ETsmwrLXkmGYzucOlL6wCr4aeLYYEg4vwT43X51j9ssKOW72DEji6AjF7UH7ID0ew8mA4NlLUoFbNwEJ+Bbdgh+BD/Dd46ZoFAmh/t5MpSFmlPuHOuIcMhxmAxpVQ3/vnrBHwsiBLHmt5A30hAXhMWE+j5+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+fMMGP5lsTWmgbhg9PCT4AgDrc+ocLe0JfAzV+Mu0g=;
 b=htUi0onRL0+RHctoUJmTVlyK+zqzTpSV8JwdeZvhSRTGi4csrcAKaZvou3FiUtK3ijnSbhltzOtNQEj6oWqMzE6t1KxahEFyxHBSjm+DcvBIg2poN704FbTAuM4EmSYmwwPe/u3y/JjYG0iRmLsE1uxXJ37d5NdllhRw6zJY4pv7GGe65Pg8xeTAFrl8sGxqJAzgkYFCtELvV5qUr7z1RvLvV+oXmbwz1wGu+2ow4Uyh+wVzKpZ9bwnW/cQuVUoBM9H7fstxcg6ol/Ow49jBKLnt497l32N24Jp74s0l+xvVQWSypZSTVG3+6/fLoz8gsXwZhssyScEdSISmuChPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CY8PR11MB7685.namprd11.prod.outlook.com (2603:10b6:930:73::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 16:35:13 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 16:35:12 +0000
Date: Tue, 15 Sep 2026 17:35:07 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>
Subject: Re: [PATCH v3] build: drop dependency on libbsd
Message-ID: <aqlzu6RsCibSzzIj@bricha3-mobl1.ger.corp.intel.com>
References: <20260624113550.821516-1-bruce.richardson@intel.com>
 <20260629142931.2666673-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260629142931.2666673-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZPR01CA0235.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::19) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CY8PR11MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 585fe71e-ddc6-46eb-f9ba-08df1347501b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xgIevXxvU8vZdid0RJYfTjxjrhrUKbc72bm9KoPvLRq9QyTqrSiFjArOjIk6kxbaR1ehbylGBypn42+ZTTlVzXi3hJhMB0LjVl7wEUbp/HICKF5Fh7rUcDEzjMImXdjDxBCOG7rGpXl0WFYNhG0UKcJz+q9ZsbbfNQZTcQNdvwqw09eMCGPRBGA+IT5RE8elINUoRUZVGuTN4QI0Wu3RI38gOptwsVC9KbAXglYBDTbRNfSL3Auo7BrYBw7RYaN1nnseWTetEda7qjhbmL8sDikkrMn5BibOrT15PniuXUfoAHEf7cr+QY5YmWTyJjGJPvRSgqW0Iuy9PUUHAS8vKufVjV5SFqurSIQEUypG9V/Oibf148x61TOnDxoV6L+EfYwOV6JcYobva/GPjYgsVM8xMs7EdAWzxkBohmMUCHqjv4nXt2sFNdpnuiIwn5ROL3R2NVeTt3m4mz9iqtno10wXoeZIQqKHgD0bvI0FoyEZIIJuMBgyYMRHYF1KZjedOE5OQ7nSKnWTZiohWqQw/GcNiZ+J2ZVRUYfHSiHAI+VTIUswuLnNavASWWMJ48+9jGs1S5gbz/2/ZsQsbDJ3LzPX4I09/+hGQAkUoN+CWgM7iiKrMFSJNBkmLv2hNuA6zPLw5+cDomm6E7Gs4aZx85GxxVjbAev0uRx5BZlvFSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4pnIxJqJJBDeWyquo63n20RKiexoUxNicAphEJGYNeAQRJXQVGre3DqTp4we?=
 =?us-ascii?Q?RfKhuoDY1gmQI5XSkGRGE8wk9RBgq2yjIBrJ4d5iRp4AawVJTiagjFhkASiU?=
 =?us-ascii?Q?OSlLakwf2uYlA0tVafGeASuzlDo+H6JE1khQxfBGII5ECJJgcfAJahgrqnuF?=
 =?us-ascii?Q?bEC7x3llyrdEhCAuY1yXtJTGqQ6OjKNwkNkix5zKuNHFK5Pe1Axx8Bg8l5sa?=
 =?us-ascii?Q?kFXWJ9jc9izxGkhU5Vm9JfSuVvXaER/CUMb8DVCbIPgiv6gITPyH1qeILeGo?=
 =?us-ascii?Q?K5dhc3uT+Te6p8/7a/yvTh0Aj/jzn0vDqtDTrBZU7X2QG+dhgKuYGe0my5zV?=
 =?us-ascii?Q?fxR8tHT5t0Yrgd7W7xI3oflaHiIPzQl7e/hiAolWaJoF3yJzuFN1VObPunKJ?=
 =?us-ascii?Q?INBW1w/MwWfpL3tGLuncHqaEc5nE5bthCP8BXF9IjrG/Pp3qsFQbUhFb6hCG?=
 =?us-ascii?Q?7xs1TzpUQi2eXqQNf67Tt8SBXFNGdBVK+/cASEBmA1U9GpeHM7YpeQ+zoB6K?=
 =?us-ascii?Q?AEgOywLK1EUdx+Q2RYJZ/XWB3kpsgE9pcbajTjOHqkaufrHh0eUpqhUCra19?=
 =?us-ascii?Q?zdV5VUDGWL5RotwhJ/AVN4Yr1Wad8aXeugHQRdUmz39MB8QFek2cgEty0UsX?=
 =?us-ascii?Q?wbeapSQ9I5MxR2nzKwDJfSEmTHPKlt7zyvq1vDhpJKfnuFMr0jdLDfKwPsFt?=
 =?us-ascii?Q?aXFU8NDa4xzCXnPFxt6Tz3LM4Hcv9nlcGzSfLZVIIOgnzUCsp6jvJnZS1h9q?=
 =?us-ascii?Q?y4wHbLZS7pZqRXtRQPLaeR5B1iKjlOjPukQQKEEOnLZ4JMWnij+i2W72TxUk?=
 =?us-ascii?Q?xbogqk+Ed+YjY4S0bFlfNOVuSK7UPLnPk0b5q859iHxQgZokZKdjLBUOnXgW?=
 =?us-ascii?Q?zvr9al+GZqcF4lbYio8ZXyI+Tm9IKLNCZKXWmt8V98+bT1uYn56P7UNW34Uu?=
 =?us-ascii?Q?vPaFyHtwXaafTOFvhtmnS+tTsM4Nkqu2/OxGp8kjkAtRQr5cTZVx/yqInYPh?=
 =?us-ascii?Q?Wizhuxce9xmwNUODPDNswYbwwCk1O7U1r3ftIu0GdxWbaZGSk2ZbcJ6ymUmW?=
 =?us-ascii?Q?uXi42bHG0GPvHxBQ3DXWKPWTQDGOOHU+yWMUjuV6SLXFaLOO3Iem3xksYlH0?=
 =?us-ascii?Q?GwVguk+75v4oG9UjZgJJjk84TOUwWU3VccbXvjCJqg8W8Bx1Dfsy4FWe07/A?=
 =?us-ascii?Q?2PiAuzKbN6eGHiaAl15aSjS7iWWH5NepCGCOig4m+AHRFgUw2JxowWS5MVPr?=
 =?us-ascii?Q?J2qpXfcWvAjbKQ9mNnAqpPF4+64TCQ+KxsS3jO+j3J+D7EhkYFE65E2vRX9O?=
 =?us-ascii?Q?4KOUNnbhWFhl4Hs8WrGCKiIWJ27zFlHpbX4e4LA3ebldmvoOq5Qs/DdKhvs4?=
 =?us-ascii?Q?kOLNcFuDO79+e4eJro7VSTuwVaBCsoGYkSp/ZLZq2gNc9sPUPMRYyMh8SjsI?=
 =?us-ascii?Q?SP1rkyixt81xa7DLqn8KDeZNBmlms+dLrpZwXKFcIwpW70mOaJU/IqfKdmR3?=
 =?us-ascii?Q?erwiGEStb8o4uWHCva4Tw5rboIYrLliHmfZDGaFkeBr9kPhqVyltQB+sB0g9?=
 =?us-ascii?Q?2SvhhaRhsF3sOb5/k6Pl9WmtenlzFzineoZkYpX/rNum4H8jAge+X4zAbmk7?=
 =?us-ascii?Q?g3/s5lqNwF906tlnuR3711YW47DOsRmrLHTuL5hQUztKQxzYHOTBMRfwvPzA?=
 =?us-ascii?Q?lt3ZicwWfJLY7oI2dvq3kEYeTc5w/u5PaNsSzI2Eu3yQdiOCnbRLNxOyKuSX?=
 =?us-ascii?Q?ZrlE+tz2016Mep5WT2D50nd/bY1D6gU=3D?=
X-Exchange-RoutingPolicyChecked: TrGiNKwAvzT5b4a1Y12rGAp3m+AVdtF/Na/JSDlFIOXOUZXEIE1zCaAbx9Rje+ly28s3oIi81fD3eW33RjdPprN5/TU0unI47txhhhQAFtRK/sIO4wqkDSsR2dnOQbrYdJEfsryOmUPQOAvw34WCWv8mJ8B2pOY59fZw+mMt/FoZJY76OYg0p3fkAyyVUNidpncUtXc1MUnkpaE0tVrXXcmfwAB/6UGoB3Hbzaj/Lum+OZY4RTrcx20ofAU5RyPqJ8HBBCNLl6c3So8un14S8tNr9qatbpxZoM5jsGrU5ezbbwlWFb4IcMmKIEhJJs+xFh6Mj/lOmRi3dAzRM0laiQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 585fe71e-ddc6-46eb-f9ba-08df1347501b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:35:12.1954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAZSyAiQb+PjFaHf/NIVaCzBAZ9fazzLTomjUXL66+F27ZC0Sa75OhYuGNx9WJKqnc7LJjolnwgqi0N0a55jJziP4KPI4OAGGq3tsI3qDIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7685
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

On Mon, Jun 29, 2026 at 03:29:20PM +0100, Bruce Richardson wrote:
> Glibc added the strlcpy and strlcat functions to version 2.38, released
> in 2023, meaning they are natively available in modern linux distros. At
> this point, the value of having the libbsd provided versions of these
> functions is reduced, so let's simplify the code options here by
> providing just two options for strlcpy rather than three:
> 
> 1. native implementation for BSD and recent Linux
> 2. DPDK-specific fallbacks using snprintf
> 
> Since the strlcpy and strlcat functions are the only two items used from
> libbsd, we can then drop completely any DPDK dependency on libbsd.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> v3:
> * removed additional references to libbsd in scripts and docs
> * corrected detection of strlcpy by adding _GNU_SOURCE to detection
>   check, which matches DPDK build.
> * added extra macro check in fallback header, to handle case where
>   strlcpy is available for DPDK build, but not for app builds, e.g.
>   where strict c11 compliance is required.
> 
> v2:
> * Took the work further than v1, dropping libbsd dependency entirely.
>   Now DPDK just supports native strlcpy or it's own fallback version.
> ---
>  .github/workflows/build.yml       |  2 --
>  app/test/test_string_fns.c        |  4 ++--
>  buildtools/pkg-config/meson.build |  3 +--
>  config/meson.build                |  7 +++----
>  devtools/process-iwyu.py          | 10 +++++-----
>  doc/guides/howto/af_xdp_dp.rst    |  1 -
>  lib/eal/include/rte_string_fns.h  | 22 ++++++----------------
>  lib/eal/meson.build               |  4 +---
>  lib/telemetry/telemetry.c         |  2 --
>  lib/telemetry/telemetry_data.c    |  1 -
>  lib/telemetry/telemetry_legacy.c  |  2 --
>  11 files changed, 18 insertions(+), 40 deletions(-)
> 
Ping for review or comments on this change!
