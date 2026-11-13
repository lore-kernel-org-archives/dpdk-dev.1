Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7364606A334
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KxcgNKrR;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=PMK0uqH9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA0644028E;
	Fri, 13 Nov 2026 17:56:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 3FF274003C
 for <dev@dpdk.org>; Fri, 13 Nov 2026 17:56:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794588973; x=1826124973;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=MqTh6dJ/p04vKFvdm318h2Lr+sO6K3htxvbOMLr8obk=;
 b=KxcgNKrRz6kU+JkmwrVXEybcAOBiy70p+xSE856iQKoUedFUza39SUha
 Z6j/DU1zNt4qKus/hKix2zhotEc0rWHT2SojpE0a6rWHoVu8nNSPipA2Y
 dfOlzQ4MMu94i4YdLhwEfgjbmRBG29QAuh0SQDdodNivuu8upvKi6agpu
 gNHTKxgLV9nF4NMSctGNgdxe+0GyH2mPPwcVNxCRsc09D/G6s+v+SJ5mD
 /aedpq0KUqu+1yBG6Jh1F8U5X10HPjTSfbu27Oom1EvfK9HtJQO86tTSR
 LS8vZye2qKyjn4tXXMO8rfHbmXqNB9AJdIbSFmOeTRsceXwt6qVCC5jx+ w==;
X-CSE-ConnectionGUID: pL1A53guQluRXirY7Do4Hg==
X-CSE-MsgGUID: URTB0MliT1eWQU4UoQ8gKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3391780"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3391780"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 08:56:11 -0800
X-CSE-ConnectionGUID: xtwABPKrS8iRy6ZVOcDEtA==
X-CSE-MsgGUID: 1iS60AEbRyuilUd7eRPEag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9047577"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 08:56:10 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 08:56:10 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 08:56:10 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 08:56:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hesj7cWkGpFFE6lyAL/5hrwdPfQi14AIuJUwPFan6UeeLo5y+bWqj+S/ejjfZjY9MrOLvEgohZ1m0TifWtvdt5F2H+vLzM9dHBIxNMY5xzh5uDQsCAwuUnnjmBmM01uy5tklUYOmB6K2V80SMJHp5PIHs+JzhK0/nRKrDGaroD9yBQpZ2Owic0we4raNbgpW0JgsTfQX7J+QaZA56SPaqxiB4+aP2bO9e6XMd6+0fvPjhdCqvKVr62UNDC1Mynrm2cYcr7tL2pFT6jX8PKAf8bdvgIbsODOemB0O1qnm6WU+XB68Ia1gKlUfQXbFQQWOvcnr1zYqaJCZu5hPzEZbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nbNHgc3p21yB52/Wr54UEwTYeJcWuA3DTGhh9WEtq4=;
 b=nirUCrIyLFfTEmBSqJbyxfsmj6Zd5/pSb/rvIilXXENGxWEDRFVfu0M3N9MyOWOwGhS8L/Hgm27c+mV8ahEbTSg97z1NJ+yaNibT7XiaebzxuCNLhrnb6Zq2glf6Uf/vWUTmA4WMi+T4tghRVgOLI0EEWBGwKXAswrGQW9YjQw5rFT6kRQuw8XcLt6wQtzYK3asGXoHVNLzBiXA8HXmvyZJnuHx7Aj6+cKlovK/76YMjT5ask87Dg//DyHlaUT0uae82kdOEbLeP9a4h6gAQaQYktYUje+bXUpDR/sBjRrcaugryT2gKHhE7Da4hK9v3B9yGlLp28wXdjW2hiP8PGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nbNHgc3p21yB52/Wr54UEwTYeJcWuA3DTGhh9WEtq4=;
 b=PMK0uqH9ozZhYGVCk5B0qBXNOwd4Azs1qSnQNORPWhFWSKzWGVFxi8dpPieo0/bLUrcGjXYaimGlHIhkEu93CuIaQq2U5f3JoeXKl4LmMpH3HxBXbiyIHVuW8/ULp2sGogB41N2v3+Ybx+fSU4RC/sHId90bPLELQafTie697DY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA2PR11MB5115.namprd11.prod.outlook.com (2603:10b6:806:118::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Fri, 13 Nov
 2026 16:55:44 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 16:55:44 +0000
Date: Fri, 13 Nov 2026 16:55:40 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/3] deprecate unneeded build options/support
Message-ID: <avdBDHUshM9ft9Vl@bricha3-mobl1.ger.corp.intel.com>
References: <20260602090847.905721-1-bruce.richardson@intel.com>
 <20261104201506.4091374-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104201506.4091374-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU7P251CA0021.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::23) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA2PR11MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: e27f0e19-d70b-4259-77bc-08df41a6f54e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261102123227099003|261022113327099003|4143699003|11063799006|261021121427099003|56012099006|261009223027099003|261021123027099003|261026121527099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: jKtHpVqKT1o67xzBPIl7CycAKchJBPQDD8xodks/N+51DmMBmufGX4bNy7aWW4u1ttkwsrLLYdYeVS4UwKHySTmb2uxFu7pNCV+o5zaG2JHlzANX6K7Da5zTC/bmjvXPvEo532JRhneTMshgJ+PVXmpnZBtnEBjMBwcvtxwf7HBFU3/4SOXh42l2qO/IobiTun9NjYizQOIN9SIzMIvjxeQt8zKyHHt4Lbzgo+eIrbS2yH/bJYA8trX86eDOl+4HzkWdNEopaUFYCcyRi7ihnAWpOoiwTrRv+cLI3Kp9IYWcqATcPqNh3R8s+KoCb060Tpzh5LRRJWyMHtcwkP0S1vMQQU8yFJXR7bfzl+Wl2L+qCzLlDvq3zb/D6BxiXEd5X2HaVj8T3XKdeRqDTo4sr9wOeWIe9WM9e54kTn59H7uXLfJcN6eOZiydnjIRBHWx88akHCw2L1gRbFjlycu75WMkwGO/gGwBbstXh0x3vooohGzgRgQd837hiBb/OIag6bZf9fkk6AX1R8kyfq+Z1iqvs59GphQuXsYIEEO8qRAobOAM5duPQ3XyJZteokwZQR0Qmei8vK1L+FOLp8HEsSIXhr3yuAX9vJkF9BziAjjKWh9n9CIMqesG/IUVeiQTlafSyi42OgqEHHDLe0EVotMC3Gyx0B8IgW41dcfhUMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261102123227099003)(261022113327099003)(4143699003)(11063799006)(261021121427099003)(56012099006)(261009223027099003)(261021123027099003)(261026121527099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NHmZJTtNZkJfRJc+5twoyDL8W1LIBg32Fh7XRByirYMxSCZnOUvR105kbItH?=
 =?us-ascii?Q?XUJl7Y5K4mZMljeqLuMJe6scxgK9NvlmerJrdrglPStQOKf2DkKLNPlAxKhN?=
 =?us-ascii?Q?syKtBT9G4Rfz5q/NPB68YBhicHpZSSGK8xxPGGaQPaRROuBVfwM+Tos90qVv?=
 =?us-ascii?Q?3gBTRSPO6hHlDX7uj4tmfNoGPehdNTz+sq2AG5Tg30MOBHiC05q1fBdE8yh4?=
 =?us-ascii?Q?SubzhD3zxAUWs4JpcKVrBnKuBRUOkYXrTq2G03Ss4bFQwMfocrtg3WPg/MhR?=
 =?us-ascii?Q?S9K/ZuUxq7YuICFH/6//hURRQlxrjKrno0Ig6RA21+KE8SZ7QJQ7MsPKq4X9?=
 =?us-ascii?Q?0LeICKqa8qgtIkhP5ZezcSy15TGqqwW+EwMNEseB4uqo/cno5Lf0LgA+1lpk?=
 =?us-ascii?Q?LkP2mPnsV+UqgKBK3GTmYB++ysyl5LxXz20aWy50WP5b3iSGB4PfQ6ajj5PC?=
 =?us-ascii?Q?bOFZVDrE4Qx1ecL1eA7DBv2Frd7b6c8G9/FkO0dFc1tJWPReteabVpBfAB8l?=
 =?us-ascii?Q?FCQhHbgNyBo3PaR/BEUpm9W4i0zTcbq+co0FfyMNyaKCNnL2FC13MWNDhEbg?=
 =?us-ascii?Q?uz6SHyTK/M9hw8/FR4wbThdyl3iTtapc5fDZ2uJwr4vEMyLFRMLkxmQXryg4?=
 =?us-ascii?Q?9yRFPJQzQNjJmA2TPMtPY6URAQyiePAHktBBy+BBQWDUvJgXV5DvTbREmxsZ?=
 =?us-ascii?Q?vlFxGnq6dxqcM5iTnqKc2p800gb1zhenaawVuVFWDiowtTilLR83G8Q+Q3ta?=
 =?us-ascii?Q?rNt1rq66XvyGSZ8wR5JMQdMnF2TitAI13bVxZ27Gi8S7Wa3bEuG+g1A3BKvk?=
 =?us-ascii?Q?WpoSklRXE792hkDxp9r3SsJ09wjB3Y2j914IynJSE7BYGd7VHn5yyQp7OW+h?=
 =?us-ascii?Q?Kk7KiefKC7IxcVUW18EwfhqcfbbOPF9yH4IA2eYqAvjXM6lisrjD1jfyCv2z?=
 =?us-ascii?Q?wMPKrsnPJCG7+z9UdHFVwLgQ+ZnApBGCIPskCY2GhApvbjBooDDJAv8sJRG7?=
 =?us-ascii?Q?AwdvifpDjprqBwzdP1DCK1BjccMAr0yxVcOk6jCOlEh9EgzAisJlns/xV8xa?=
 =?us-ascii?Q?mAzrqAVNjINAj79b88+e+FJ9AaLBQqlYgw/9IxucjamlnzoXAsYwS0Lw1MzA?=
 =?us-ascii?Q?e6XaYKrMrqcylc2+z3mjj89D3rJBXWO+K8fatNrK6++3DaN0P7JR3Uo3IIfh?=
 =?us-ascii?Q?auqYD2A7akxEV9nxjtnoQRW/SbBhyHlczYTQmSLlohNPxJrPbayc3RqZiApa?=
 =?us-ascii?Q?xB/yWoLDB9TcgOnvFQOgNU+aQ7YwPUsPr9BougoOqzw3WvMbjq9V6JEc9C7x?=
 =?us-ascii?Q?Rtjgnjx9Ew0vtXu969lMB4AeE3JcrUyPenwi/GDkmPFlbv5K5khIYyD3lOpb?=
 =?us-ascii?Q?raqFDjrMYqoU0cVFbs1OrsQL+P0FRGtk91C12MZ/KSDeGmzpdjfibpAEqIn7?=
 =?us-ascii?Q?vOP9lLiPu19rxxduStLdWXklOf4uElMfVN6PU/7aRbfrmcdvNJ3NIbXtRqza?=
 =?us-ascii?Q?36UR8V5Nqcc7i8223y5yWXxjcE4C+WYBiqHp6qh/aRXpONumK+bm8rUNcyLy?=
 =?us-ascii?Q?62+i+P+F9iy1jluP7kpDX5Tm6+zh/CNkWogvHjWqHLT8zmjm3cszfNEj/eJQ?=
 =?us-ascii?Q?PIboh3wUuEZAv3nWZWFSjmAfY/SXp2ya0zmOz6nCGuAsTFmDljVLKYjgC9SQ?=
 =?us-ascii?Q?kdwWsw3eXdHYRnbeoFHThxSDPC7hJ9DJhGSyKWA/CucxSTpIXS5E9VDrQ+O4?=
 =?us-ascii?Q?bP6a0wLZCL1Ez4vjaOi8fMsbrkpSoxU=3D?=
X-Exchange-RoutingPolicyChecked: u0nepUHiKmroI60zk32ZvwoOsdPX8suG27jQ10FSs2p5+TKkltkerJERw9VqADU74KNSVJH9nC+ifg21cOopEK7RyHTUbns+pDSUUROjkwicyQ7ZG36P6I8zv4lsSq/kbnMs7P1w8NnUKConb5LOsWUudUCoQ8l5FgZcXgEaKxe6+XZkfiTTrQGSbH+5ZZsu1H2ljkn+p5YnxsFO3c+ABz1/XL7xBpbx2Pa+F4NjCdifuIcgMgyJxZZhUIWjSrUOU/0UTizHGvqxY7RBaB65Sh+MI0GR6Ka4xOJNQCtIZyTiPAQPfRvJdG+//oXm55TlX43PiJQT4Jz2ttsFmpk1Ng==
X-MS-Exchange-CrossTenant-Network-Message-Id: e27f0e19-d70b-4259-77bc-08df41a6f54e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:55:44.7735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOAdQg+EH//RHn/A9W4MP+uSpwo6L6cjibHNQm5giyuvxak0TaCuvI6DocYDHS80g3Bu8I8NNWWAXWlbcQ4IlqtD0q7bXJQRWQtMDBcvKYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5115
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 08:15:03PM +0000, Bruce Richardson wrote:
> Having unnecessary build options just makes things confusing for
> the user, and expands the set of potential builds. This set
> deprecates 3 build options, including deprecating all HPET support,
> and marks them for future removal.
> 
> ---
> v2: rather than always building HPET to remove the option, deprecate
>     all HPET support, which will also allow option removal in future.
> 
> Bruce Richardson (3):
>   build: deprecate kernel dir option
>   build: deprecate standalone tests option
>   build: deprecate HPET support
> 
>  app/meson.build                      |  6 +-----
>  doc/guides/linux_gsg/enable_func.rst | 32 ----------------------------
>  doc/guides/linux_gsg/sys_reqs.rst    |  3 ---
>  doc/guides/rel_notes/deprecation.rst | 11 ++++++++++
>  meson_options.txt                    |  6 +++---
>  5 files changed, 15 insertions(+), 43 deletions(-)
> 
Ping for acks to get these deprecation notices into 26.11 release.

Thanks,
/Bruce
