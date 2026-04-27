Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDEBFF8861
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 10:02:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4ADB5402BC;
	Mon, 27 Apr 2026 12:02:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 368A5402B2;
 Mon, 27 Apr 2026 12:02:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777284167; x=1808820167;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sKSupWM2hSH+VH84JOcUp9UXzUxtnzl8Q9H0Z0ByzDA=;
 b=ZQl7vKOE97706igW4rbS4dvUOL7xcA4/Y7DAuYqr41MERDu+TA78xuWc
 KlCe9Ky1XJuhzahALgMqD3RIr76uR7TDhZeyMTu23YiTABC/rzj2/hE3H
 Tvn7J8aQ8h71Xi45J6GNFTE6xKXYiZ27Np8advTs8F0wKcEbLmHAn9JEO
 BQkKYX3UL0pJhXk8aakRtcCKYKv3jhhZbIeATYUB8UUdb9a+5HXRiDYZs
 uvjlKHd59LjCcmH0dfQu38h69I7EFasIfkfrD2KnSiNYr83gYvUj9JYAc
 TOA37/JB036pieizTNKeKdPZ4qWKBVEn3P3GRSxy+zsqXBPnMz0NEQUsr w==;
X-CSE-ConnectionGUID: Vts96uZIT7OwKIw2b4J7RQ==
X-CSE-MsgGUID: iE7N0wmjSf+NePh47MaprQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="77193345"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="77193345"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 03:02:45 -0700
X-CSE-ConnectionGUID: BAf7j+G5QoiTKOGnLsG/Qg==
X-CSE-MsgGUID: jzWk/TkfTFihx0fyHQaZHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="230959599"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 03:02:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 03:02:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 03:02:39 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 03:02:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlKZBFWEkCb6Cp1sxEw8ZMj8UR3MgQ9OZZvCd/JVnF61KxwesNccD+j5GMWiWtrwgU3nAVVbn7nu4Ob6iyAcwqUHjzRGJ/sS8fepvbR3nLksq9rj9yfug4mWYZfcLFOSC2NCBXDCp4PI0G9Hemkt1akau0me3L/I4TxIdlpIlaVVS+kpa7EvrOkDXJEtuISRkGLG4cKZbSxaRDmqqOErKShs6hY7/xdZmvq9DQlQXwmW6uNDo9spikQfnh4G+ltSXFj2aHTrVGS/BnTbj5wq5tB4ssRqP0Y+78UZAPSCkhlmcG5OcImPVp86kSkyEBXs8wGxlRkJubz2A5B0Orc2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ze9tt8UqWsABNGJBy0YscodXURJ0PfIzax2auV6ax4=;
 b=VfoBbE84kyn+i+ULTCGOGLsa78grvgSzqBnp4wt7t3fV/gnWtJBJ8/yqCBIveXXa3FIOdg1N5YToR625/ASickh69mx4ePEP3IN972vUJhRC+81wM81zmahK4d+Vqe3AtjKYdy7HX0petEksHXqAQ2VsQRORNVpwLzXTMJFs0x0p/Ox71ClZyv2ozZ5E7CfbTHIkJM34di6qe1nQas/ExkSlMUMp6UFEprGrE61a/OcWXoK4QBQDnuzNwELRp8JADjKcEp9EhMN/rwWB0eUQhH3WcJoAV85kzumBPvfszbZsEU2JCXI2AqD1IsVTMoX0jZL2iaie/5UtPwr0ZNw89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS4PPF814058951.namprd11.prod.outlook.com (2603:10b6:f:fc02::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 10:02:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 10:02:33 +0000
Date: Mon, 27 Apr 2026 11:02:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sunyang Wu <sunyang.wu@jaguarmicro.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] app/testpmd: avoid cmdline use-after-free on SIGINT
Message-ID: <ae80NGXJc7qgqoDA@bricha3-mobl1.ger.corp.intel.com>
References: <20260427091055.22412-1-sunyang.wu@jaguarmicro.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260427091055.22412-1-sunyang.wu@jaguarmicro.com>
X-ClientProxiedBy: DB9PR06CA0022.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS4PPF814058951:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4e554d-a116-477d-0e5c-08dea4441a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 7rG3niBIZD1HsXF6LNH0+JGZ8FDsw3xyScx/dHQOTxa02eCzQGYpsA66Q4t46KjoFIwBoZQPT3QgL0KoJ029hIlji5ArhX383O4f92QcugIDERxfyFw7RydTGlaSCyJI9h6lkkXgu4QLW2kPrHhcTYMuEDuGIg8iglaptthSwanHy/WaviomasVxl9mK0aI6FDLYoTJKTyZ1Y3S9giOVJgV4f5wCoXuiOZHymMQBjzwqAm9X+JMxLJFvtHO2tIuXB4F+v7zf1rs6WgNGj4AuVVGhAH4K7Yp2WvNDrb74UWHhuOFbQVnJ90LcDBDP1IblOqwgePoVVggZdKq/aXLvaqb1AnV0m2yUOURg+5bLhjajEysxKG00o7183pQ4X9EIK187lFStQEVu2i+gQBQ4rX06p1SQvjxlCckoboz0GZ/VlMsz930+w0vSq9f92qKXlpxyFpBzH6gGwr/Bmec3JwCLGoGYIFs7ZZPpxX4TuV7gOXlAnGLPYu/HN0lJ4RCdduKXNQuaM4QIJAyGHOEiNArRz4b4yLLLckKYLkCwrXFNdMhCMk7Sq+aNP3WoLVs8v8UU90UoUql0Ye9YFBJEUPUmYzlL7CrNDAvsHsimhJbuVuTlwekM1eFxtkOxc/JJj12hqi6kuhqt/iXQSxrDhA46hHEuE2bcxn75fS5S7G9YXweArn+ivNCHT45Xxm9BDF+HGZeuFgZWbjo/fDEWg3/zBicx6v/p9PUKg+JSyuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oJrF0lKMUawFO7TMtU5D8Yl66hY33AxLiqdvyZwh8eXZ9MgE7BFfYu+3A5qW?=
 =?us-ascii?Q?Cv1kBpDkqzQdu3TFhzf03E7jTqE5VbFo5TS3NrkEfcAS0ZvYmZ+jH77GE+Je?=
 =?us-ascii?Q?CIVOaGQkMvYAMPABLoDsMx5gCpX9UQ5aMI6pzn9yAg12ja/dlGG/QuEZz8Dg?=
 =?us-ascii?Q?DI/pRplW2lM0tRWGefEN9EmvSsChLY4xgjj2zlla5/VNnhYaZxlzgdyg1NfZ?=
 =?us-ascii?Q?oRg0AjaIhjUOG9CHx1CzTPIT7eovO7kCyVbO7XfBBvKn4+tFbOlxLsr75Hzx?=
 =?us-ascii?Q?Y0QF/4JB0O4Cum9oA+z8j9VHTZJ84hgy7ZaExsLGQea2yHAIL6xIhOxOcJ0e?=
 =?us-ascii?Q?2EBqY+u3a7VpWRU/2g0inrTcyx3/nfuKdUAuq06Yrnm37/zBQFdsbNvqMBox?=
 =?us-ascii?Q?ciCPTmaXkEtVGfUfQ36j4Dbts9c9ndUFHotJHM05cpmD5vnV5wWiDw+C+Tg6?=
 =?us-ascii?Q?4PfuHeUt+zpQRAHYOZZyNbQ4RmFvgJ00rnhyT4GzIXrvg/tXau7ou4KteNjc?=
 =?us-ascii?Q?Awpe+MtkDWqyKHS+pvDxxfWiXd9s2lh80j2TsYEnAUdkMXVKUu54F5DdAY/x?=
 =?us-ascii?Q?EGq9ZPwUREWP93dsm7VY0ejPlQx6v9hPPM8yRlFv9ENEDsVY+YEu1a7T4Out?=
 =?us-ascii?Q?2EbtZFLLV52vF0AlBNS7Hk5f0AeZ//eautj6kGekAanb26nSxBX23N1zB4xM?=
 =?us-ascii?Q?XiU5xTxRaH+CBJMKTF1UX1o/T5z28WE8clTE1FZEwl4lyBi79rjdzIDs9QIr?=
 =?us-ascii?Q?VqyTK8bax4q5ZUOuvqnpFDhhI2ZtGtDeihi2rWfWkP4eL3IhGAc0NmLDlpOo?=
 =?us-ascii?Q?XBn5H2D5IVq+GthA/CktH+AyaDLXrQvGEoUiCsBtyZGMeU3RaeJNKhwqA7OS?=
 =?us-ascii?Q?gpUFeu3nykO8ooSdl2Kz1Pgw2VBhAw/wWoz+sjdaB262vCgNxqBcu8E65ibq?=
 =?us-ascii?Q?iE3SO21aU1zWRLejKJLFvn7/mc3dncykZf6pbaQQ4tW2P5ce4KDP91EtbNE8?=
 =?us-ascii?Q?FzggJh8Q6usGna8mINzvSuinARvCkRPYOxKa1fL78J9U8uCZ+CGrnNsVD7xx?=
 =?us-ascii?Q?6hX9q7mbLBTn9ZeqtHxmlAGJmRML/mt90f6czWp7UhhsnbEVDC5gDZGohZlK?=
 =?us-ascii?Q?Rx8tnejyJagZciJUcU0nROgYIDG1sAaEBHGeXLRTr7bMY4OycSELHexnlW2e?=
 =?us-ascii?Q?ex6mBBocZMexbheNeQ/iaAkrbph8sq2361wXqBUAPCltb/QgygiViFtc3a7Z?=
 =?us-ascii?Q?gojELLbVlS2mk12var7RzEvFkPxJuBJOsWdvd+i2xPc9K4gx6v7JYN1XYl9M?=
 =?us-ascii?Q?T7B9mLLfbFoZUixwEPILn2itEkkIW9KXPgj0mWxy7bBDxrN/ivaM5rAUqGOs?=
 =?us-ascii?Q?ucPx1rlX4SQk2MMjbHz3W2ySpYYABg0UrXxnVTgb1X0gdg6tRF6Vc6b2K1ub?=
 =?us-ascii?Q?+mdHS5ASy1dfGQkOqcCL3MLbu31rUWr6+bT0zBbqZa1fLItX4pCa0qZ23QIv?=
 =?us-ascii?Q?Ixsx/0ZwLQgHLBK919+CEwKtGbjiKB8PJmG99RWbTndrzDMyBxooU0zMWu/D?=
 =?us-ascii?Q?rpEbqaC11XkwL8GaZ3WcroFsYpQFiVxy9ip0fAnQ+Zmi7FBukbWskiO3u4O4?=
 =?us-ascii?Q?QOb270Q5WOs3bzt+p1YgXuAWuXa+pHHO/KlREcPcb1PY06eTv8Eh7GoUChmE?=
 =?us-ascii?Q?iLLjo1ZhZF4NlQ4h6iPOSFeGhpwqXVAzYF6iXPnTBNi5WrN1yUV/Mt2j8SQH?=
 =?us-ascii?Q?Na64ke8OBDpFf/sN3iIkdZIAR02CDB8=3D?=
X-Exchange-RoutingPolicyChecked: RQHQe/ebyGAAfKyHrjaF34gnMDS2xURBvJLmGtOwcp21QRZG11y0zhvsGuoG6jV5VQZ3xV2AseBLFtsKa7VAcD7phYLkqDrgd/Hmw7CcNGbkpC8zvCTDZxMr1j7bboPXN3/lvMxT6dFK/MSQLil4j4gRHiQ/UXxPhswvU3B6TCfsZuuzWncXnbtdBV+NVgkZ9zV9y2aDhVjCpoMQNweP00xKFIPyNh+Omh9SSFNcQbTX5Lajt6w3kEuMGxFXVQPpMatm8gdx+Tvt77n/O4TdB42C5iBp9AAYRIlC3ZZ5t56cRPwTjcqQSVZZx6Fr/FP6SlRU5oHjtF77UgWKAfHneA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4e554d-a116-477d-0e5c-08dea4441a01
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 10:02:33.7392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWziG0t5veibMO6a/VRxMEANbzLuUlQYdd20ucCkvNXDJ1+kbVV4AAM+gl7Yz5cdM4QZwGllithhk5X/pC9oAa2Yq7l9CrWW8M9VenpuXAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF814058951
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

On Mon, Apr 27, 2026 at 05:10:55PM +0800, Sunyang Wu wrote:
> When testpmd runs in interactive mode, SIGINT is handled by setting
> the quit flag and calling prompt_exit() so the cmdline input path can
> be interrupted.
> 
> However, prompt() frees the cmdline object with cmdline_stdin_exit()
> after cmdline_interact() returns, while the global testpmd_cl pointer
> may still be observed by a later signal during shutdown. If SIGINT
> arrives after the cmdline object is freed, prompt_exit() may call
> cmdline_quit() on stale state and trigger a use-after-free.
> 
> Keep the existing prompt_exit() behavior so interactive input can
> still be cancelled, but store the cmdline object in a local variable
> and clear testpmd_cl before freeing it.
> 
> This preserves the interactive-mode fix introduced for Windows while
> avoiding a shutdown-time use-after-free.
> 
> Fixes: f1d0993e034e ("app/testpmd: fix interactive mode on Windows")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
> ---
>  app/test-pmd/cmdline.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
> index c5abeb5730..e3ed0f1865 100644
> --- a/app/test-pmd/cmdline.c
> +++ b/app/test-pmd/cmdline.c
> @@ -14500,22 +14500,28 @@ cmdline_read_from_file(const char *filename, bool echo)
>  void
>  prompt_exit(void)
>  {
> -	cmdline_quit(testpmd_cl);
> +	if (testpmd_cl != NULL)
> +		cmdline_quit(testpmd_cl);
>  }
>  
>  /* prompt function, called from main on MAIN lcore */
>  void
>  prompt(void)
>  {
> -	testpmd_cl = cmdline_stdin_new(main_ctx, "testpmd> ");
> -	if (testpmd_cl == NULL) {
> +	struct cmdline *cl;
> +
> +	cl = cmdline_stdin_new(main_ctx, "testpmd> ");
> +	if (cl == NULL) {
>  		fprintf(stderr,
>  			"Failed to create stdin based cmdline context\n");
>  		return;
>  	}
>  
> -	cmdline_interact(testpmd_cl);
> -	cmdline_stdin_exit(testpmd_cl);
> +	testpmd_cl = cl;
> +	cmdline_interact(cl);
> +	/* Clear global pointer before freeing cmdline object. */
> +	testpmd_cl = NULL;
> +	cmdline_stdin_exit(cl);
>  }

Do you need some memory barriers in this code to guarantee that the NULL
pointer is visible to other threads before you start calling the exit
function?

/Bruce
