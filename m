Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DB3CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 15:53:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 298C040672;
	Wed, 20 May 2026 17:53:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 73B8440670
 for <dev@dpdk.org>; Wed, 20 May 2026 17:53:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779292387; x=1810828387;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7Duubbw02cKtwO+BJGCcRAV1kJEzXu8GFuyjfo2PTVQ=;
 b=dPFrd99ulA2ZaE8yPQNlOc27euLQqM6+2HN77+A6x7xkfo61bVnFwdPA
 k8Ap+ggOxuyyLC+O/CY0k2bU7J4eJBZa+Q+Gdj9TK/vJB1GEBZm1nUlAf
 nxmjGbM6tGmtP09qe/bHe7LyVTNTmoeh9I2N5pJL9hRjqy9wTxZUtn6Wb
 cR3nDL4FoBr/fAcDkzfN8N6cQZfDbcQQAxFx5UfyibPGso92IZB3ljZVa
 2VTrnaf+0SD/FFdz0tGglu89lcP/ZhePgTUQTKKjHZyHxrXcS8Pq1rGzu
 53Fbgi+Rw1xyypm1yynbUkPLcvlq6PHxvIqT58ETqUlMYraELdzklYY3x g==;
X-CSE-ConnectionGUID: DKwXwctASeO3m5oHrVHj9g==
X-CSE-MsgGUID: Ydcp6uDeThqV6rhGUtKJew==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="79344084"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="79344084"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 08:53:05 -0700
X-CSE-ConnectionGUID: 0r04zraER+GUl8S2UxnhnQ==
X-CSE-MsgGUID: lqV4gVyHSu+S+p6hKmQuKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="242030714"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 08:53:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 08:53:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 08:53:04 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 08:53:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hy3f97uskZbh0LyesLcx+gyMysCc1tUR+JGtqRRs7zLD81OlU/Lra29stj6EJiJ4DrYCQT3D1d7RGFtUyeQEo9byN7/qlH5yipyV4AQ/fhVnLSG+dAcbTR0vw+YKZpjg/TOzjHY+6mmzL06CKxh/gMU7zJ/MWigZBtuDq13ihC1iMDJxcjVL5SuTkDOoTMnKbJSRKczm0UtEAXppM4agYqSra5zGj4hs7IUeA1sRmLuwTsIiGKJufeK4psvyVzgoo2mxTDHdS7PnoickVrN1NyGNRfdorP8m8UwkUMLPIBOGR4evHeguTPJsEblU/IpaAGtEfqTcGx4N8zKHNeD+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7l0v03A5YsZIZ+T674UcTM0hGzPzUvVWENQ7huOcghw=;
 b=aSbpXX1l3ltFvASmOOvciGeIkQYnj6Yg6ElM/2/KsE792yIcoS5RcY2xvNXGJldvzCghgmav9QxSpWD4m6ItnjQ9HKG9UQIPHhVAn09x3g3QCC7syfxruvmJUYKaPG2IAHjSzKLm1HiZjKQmHJTjx4snb004qXDgTCWNRZZ/VZgpHDwxycndic6NCQCwTVbpoCB8zHTkWUwyPrmRK3ZTgXWEMvG4U47vfFC14SvHkOffI9d4kP/uq0+REui1qHgCdjNBprmWVLBZLMBntyUqgw3Y932cwoisJNKthRfYYBrq9x5Yy0BE7ZHYuGbRfGRuf85428jdP1c+iPOxRNYu5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 15:53:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 15:53:00 +0000
Date: Wed, 20 May 2026 16:52:55 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <patrick.mahan@hpe.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/ice: improve log messages for DDP loading
Message-ID: <ag3Y1401SlX2hcTm@bricha3-mobl1.ger.corp.intel.com>
References: <20260516101942.443871-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260516101942.443871-1-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0259.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW3PR11MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: c1125944-c2c8-4924-82d0-08deb687de6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: Tk5FftoFf9sOjTL1zO4IaZ68NhTK5AAavF+LKPf8NFlthsfi2OVlt9DQkGn9fvk8pV/4euCm3M+RcAbA+8fHClVrO1VsnGy2X1VcucBn3KF0oljp0dbVztIPXSOoma779EZYi+P+3xCZ1QmgKrOzFYH6/PKaQ8FzQRLnfE/WuQAMWPXWfCwZXlxJ1EG9i+3jVQYoPsnyGGZAomOuy6OrDZm6goDIVnFR+b4AshZweLwnlde7hxQDRU/hXODN3N8CXGhFZBkzyAuLUdpY/1Cjagy2PWFjyTd/UMSEG5qkQtOPshxR2FmwhGRZArU/fUlUw5UghLT0eUf0VFfyCC+9fQUTwXgQvBEcF7jIwtG+W1pJk1o9I+xjSgCxZT/SIjDw2BYfgsvIGuIG4dUqm8mWZAjaTI/NMqOVJmpg0OQXSAPeifeVNTYZDkLAeL2LH+ZkRKmSL7sR03ZsmOifBVOb8bFfZlQEsslSFRxayFZHxIrVUJdoTtLTWhrR0i6Dk6hjFERXw27xmFU7eEoZW64Czv4A2wm/QwfgyB3GkODaJ/0wEQj1x3nIeOWRCafBxBR2saVfNIrllR8Wry9OmofNQ4ks6mqpidbKBpmIbQG5D+9c3xRhrfL/a4SzTgXXfT6NaQThnAL9oTtBRF7NNzdzog3/igEJklC9fQ5+1lDUhpXGiW9IFaRG4V9D1wMIgHYm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yy+8gHwYlFCZiVTX/rxbulxsBggwvUNCDqmfIK/Lsv8HoGGWytXxrN2UpIES?=
 =?us-ascii?Q?JWhGuhbEWus7juJ0PPYssqNsIciILX1FMtknf0kD9hVaIwUrY00x69XaRf+R?=
 =?us-ascii?Q?iLiXRx/r1k1YrPWp8N01UYSoOSB+Bq9UNFr+NL4AQwu5kZ79KcKxMArCcoZf?=
 =?us-ascii?Q?p5xkSuQrEGInMuStl/0yp/3K8MjjkfRS8tWMFVNsKcQrUvow+T7RMdFL+RVL?=
 =?us-ascii?Q?c/Gkdn/mTDV/jqvCMsnYxggtoEjB26hcAodkBd10Jem7Qgf72dYTrxH8QTMS?=
 =?us-ascii?Q?hMXSuBBNS6hbCUvC/4Wbh6bt2o4ipdszX6Xcoxiyqo3MlvmN2n8G8VBwKVZe?=
 =?us-ascii?Q?tnG0kGwpWb995EmFGv4wFrqyL2c/dKgV84t2jk3efU5r6NrHYd2J3NOZbErm?=
 =?us-ascii?Q?bVA0xz6WryjKG0budVVEpcFX2fgZpE+P8od19jlLRbTB1b8BX4WBd1u2Z0us?=
 =?us-ascii?Q?LDnSe6Hd3vOJfBrxm3dY3sfXAnjZTxGK8kq4EnNaNr1plObC/v90ynW9KSdO?=
 =?us-ascii?Q?JkdyGHKgKRX8m+SeF5kww5saWMJy/9lmTAjXixKPI1QrVTTczbKIgEQlUqIn?=
 =?us-ascii?Q?iXF08oHHv2W25x2mAnNlMSs1b055yMWzDua8/vSR3GOlmA7IgzDi3E/z5rqN?=
 =?us-ascii?Q?ljMiqGBH8EM8/JpXAYXc01YvEYjVC9Q0jbRziWuZD4/z2ZOhl/Ga2cfsNlOh?=
 =?us-ascii?Q?jD/O8APwv7jL9dFGemoavAd86M5HKJUu40MjAjKfEixNKHzmxh1ZhlwikoAi?=
 =?us-ascii?Q?gy4GZY15FCkOl/9gMqPYT/1YsqN++Do1JSP7WIRtCW1k4H150mN4JIjsBneL?=
 =?us-ascii?Q?0iB53jIGORWYjlEYCNr+PfuEpPLFTUsaIRVg9DEecGQ6cfOatj/ad5OhRJPl?=
 =?us-ascii?Q?Tz0gSwu4Lgh9qHSD0c5TGy8fmyxVy1HcfuNVD+TS76LnK2FyTdOtIBB7D6rJ?=
 =?us-ascii?Q?gU5saOqy3SsaNjpy16zYasr4vi40rpLggJ2hvFJC0L5yNQNNCJh4ACWQNj1J?=
 =?us-ascii?Q?sK5ekFniJGtuXC7JIEkxlbt0pYiJnldDcPz54GJ/DZkwF7qjoYRvKerreZ8R?=
 =?us-ascii?Q?5bdjH4aS2uOoDI4aPE/F9hzSyfk2eF41ueI0XMNuqDnFxWoG2yOwFpQUqd0M?=
 =?us-ascii?Q?1YpqV2IS7td5N2WcXNcInWi2gd42jYqEsa/XTr4Zkxy2GIukXfFCzYm3KtC5?=
 =?us-ascii?Q?bG9aWy3MGC7JcF9Z/pdnkYRPzXq3xB4Jzn9X+xEAn8l2k443CULZsoMI89Ys?=
 =?us-ascii?Q?N2CMt2oCDbWcmznhBBgT/Cq9OU+8zHTimmg+wEr5mAJl8N9rsfJMf+0VYfcD?=
 =?us-ascii?Q?Upy6zjYH1b/MjGioTX7Rxdt1ZriwXN3KGYrodk96QCunMyHjAt/vh1Ft8BZh?=
 =?us-ascii?Q?y7cO1QmIi1q7iJWgyZGTdmz/lk9aKBBpECOG4ciZsAuvtb88PbZ/51skTyuP?=
 =?us-ascii?Q?M1mBtwyvs+6IR1zwRpOx9J0OGmJZesc5kky1wHp5aWAxGx+mrjfFpgE2ITC7?=
 =?us-ascii?Q?1yBwsf46ZiMHtoIYbj9Fta4tVy6rCZnNUDarzSyaA8AstePZ0jpZ77SuCsvx?=
 =?us-ascii?Q?Si3ifVYm3dMG8GRp1TK3Qs/ZJDcxEr7mgdNLNEeGTp+aHP6FWgJgmaucCU+8?=
 =?us-ascii?Q?CXKgNuPJdpjzfC4Ls+dmGWuqDkupLP/NE5yHhrcp9l9GVJ5tQnNDZKK42Ufj?=
 =?us-ascii?Q?SNsM4drkzT2ty/l089c8RII2v3u7S8jg1wrJZyEbiuvY+7w00PQ4nv1MyLQE?=
 =?us-ascii?Q?yNc13MqOZz0DivDMmnASZkQ2k53FpJ8=3D?=
X-Exchange-RoutingPolicyChecked: BjMTux9KNe2tj6VON8xDJgAS1ipycKzT4PJcjW7YF9Ivbh8RHQR6ep9Vv1yvdHdu3qt/7GbiDAhvxd2aEmnnQarjc6v3BsP0ekdq/VjOy1l9/bLw7hwC2Wzm2+zS+3PrCDf8E25ypAINy40A3u0uWVPB35KBewpMy5ROjUhx6NkdV33iqGqshP1cPdzpRgKrtTQdUPons4TaWvagFeZe75d7hsIWKqRL89/EPxeXCXRZn00NVWgnhOaq6FxBHPi3NoEhGNnqv+jA6p5mzLhfS+JRw9AiCKJiUOEBqZakzgbXtPNB44y4BXdj6X7w9rWOlHVn/82EW+ngkWM6NdasZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c1125944-c2c8-4924-82d0-08deb687de6c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 15:53:00.3993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiTMbd2/yfKxMse5p0bLZhmiW/JOmASFehxrOnXPkLwej+px/5gO1sGp0+DTSA4KGAUFqyv73bYPKuZsaqoJ1hxgm3+9KqLX/aWio5HYyRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4556
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

On Sat, May 16, 2026 at 12:19:41PM +0200, David Marchand wrote:
> Some nics may not provide a serial number (PCI capability
> RTE_PCI_EXT_CAP_ID_DSN).
> 
> This results in a confusing ERROR log:
> ICE_INIT: ice_dev_init(): Failed to read device serial number
> 
> This is confusing as DDP loading does *not* require the serial number to
> be present for the port to be functional afterwards.
> 
> Besides, after trying various path, if the default DDP is not present on
> the runtime system, the port initialisation ends up with a vague error:
> ICE_INIT: ice_load_pkg(): failed to search file path
> 
> Improve the situation with adjusting the log level when reading the
> SN fails, then add more debug context to DDP file loading and end up
> with a ERROR log mentioning the expected file.
> 
> ICE_INIT: ice_firmware_read(): Cannot read DDP file
> 	/lib/firmware/updates/intel/ice/ddp/ice-b49691ffffe6e69c.pkg
> ICE_INIT: ice_firmware_read(): Cannot read DDP file
> 	/lib/firmware/intel/ice/ddp/ice-b49691ffffe6e69c.pkg
> ICE_INIT: ice_firmware_read(): Cannot read DDP file
> 	/lib/firmware/updates/intel/ice/ddp/ice.pkg
> ICE_INIT: ice_firmware_read(): Cannot read DDP file
> 	/lib/firmware/intel/ice/ddp/ice.pkg
> ICE_INIT: ice_load_pkg(): Failed to load default DDP package
> 	/lib/firmware/intel/ice/ddp/ice.pkg
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 31 ++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
