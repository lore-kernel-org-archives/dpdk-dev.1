Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44538FD8FF1
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 18:19:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EDD94027F;
	Thu, 26 Feb 2026 19:19:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 6DF83400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 19:19:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772129979; x=1803665979;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3TBV0zXRoK/avpt30/mwG4QIXhg1qb0RgZjxgiXk8Eo=;
 b=ZdkSfaWr6mwcB0wTvnXkSic21ojfvOKa55QFo3LBZUWWWkZ5AtTUh5iy
 DiydDEp92aaSiK2tlpA1fnC7BsOGYn2M5h/z21eITt5vvMAccJEdKKSDN
 beEdnoraRvEPv4cLsIiwltBbB/dByIXrwEPUkneVJeFIZ4Z8Daq3rrtDO
 +e2S+ncJrraSduYc9Sr8PX13jWTHer9Hv5tVeKyCkqQ87h2VUX/53hoPE
 9UDKApIIxrpodawmJkbKJaJ83xQ2AjeY+RPgdNpZjgNxio2sMaTYkmIqU
 x5wUrtphbI1pLcvixYpLd9yS3FizRIvTidaYe+J97nsrUDGlJoZiOWW+d w==;
X-CSE-ConnectionGUID: ES+2r4DrRoSQ/26seHCoQQ==
X-CSE-MsgGUID: O12CvB//Tw+mQJ7+RcimFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84662214"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="84662214"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 10:19:38 -0800
X-CSE-ConnectionGUID: 9sLD+Qr9Rw+xaWOpJ9Xncg==
X-CSE-MsgGUID: TpYzYpi8Q527X+PMys6jxQ==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 10:19:38 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 10:19:37 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 10:19:37 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 10:19:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUcyvZd5hg0ITZ4cCM4PkD/30puPvC5sx1zvYtXnyK4vODHUZCxrh+nZZA93xGwqh6tLFfdHX5mLCs9vrUZ8/B0zm7lpnCa+ryCRY8lbyChdB+Ku92Ps0f5hszEiKRqnfA4gzESqZml3pqaw6kpzZcVr1w0Wm+ZtcjgCxJIdVJCO4hbKqm6iRpAtA62f4vFXIw3tLUyzxXcWDz3OIG3bNRJ54v68VkMvo18I3nTYIoqYP/rPcFVo0yt6/uoNhzD5gfPdkSVIHTQq2lnapFARQpbwKT53YozUHUNW07ZaAzxkTKsL4F9VqJKmkClJm9G4XpPF5Z3K6e7zINf2XZRJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4pAntSStuC5wxyzkyduXa1Je7MHMIh/Xl+bhy7UUvY=;
 b=noE/8u5ORTOSV81x/up69vuzzbFfrgos5Q/LdB7J+hnB4ms9svMSNSbtX1bShERjryn7/k81nwEu9ti+fnbkbyd7L75WGdILLBYmTmG7zm200QxP0eF80lwGzt9yNFMCXqdyYLymO1u2+LbDUUPHm1DH8zPIm3Vq27EI0VLvOTdmAyJtIPPgMh0G5olK0x0dkPQ9ZE86B/C9em0jYP9vthOClaCvI9hyJsd+2KOevLB5YoiVsT1NGrBLMdP1yYIfXModFDQpKjOCIShm+bSLGsQx2QHW+DjTWyCvui2NW7vtmEfFzz0DfsIl+kuEtL44+MxfFWRrejbqgBF9TmfGMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7891.namprd11.prod.outlook.com (2603:10b6:208:3fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 18:19:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 18:19:35 +0000
Date: Thu, 26 Feb 2026 18:19:30 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH v12 3/3] app/testpmd: add sleep command
Message-ID: <aaCOsmCbo0nXE770@bricha3-mobl1.ger.corp.intel.com>
References: <253bd83015321590b266eee7c5f774b7c8956831.1772124281.git.anatoly.burakov@intel.com>
 <9190a614adc2b641b4be3f3160ec109cb087cb24.1772124281.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9190a614adc2b641b4be3f3160ec109cb087cb24.1772124281.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0320.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 8532da0c-55b7-4f05-dcff-08de7563983e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: k8zNIkNhpsi9b52r/FyVTm2Sxhd0EjfGpQWsZYSpbdS2C2nDEziA1J8n3LnMznMAv4MTZKQwRc/ZGqzmax06jxg9LpxK3VJMowhRwPemC88xDQ9q48moa7HXtnhr/mdHS+I4TEMa2qPb7zGLg9+D2R7D9dK+OrsnlbfWk7y91+i0TrvGd3bDG49DKYBMDQwwwFaxJNwRR+yco1XKzFAoVHuOFgkf5uB85k8KcUkkPcnhlIUBUd6mXFLnMkS32M3z47SluiT6aa83lYIeEmrGZ5R1JR3aXSFOI2iDUtcMtZH/VcSPuhyKtaxZ7x0UCAs0Y5+Wy/QnxiF+gESljA2sBUuBv/Az68xUpAm1J+QtmVLfo3/F5rZ5KGzHns7aPYEmD7m0HDcsnAcpA3FSDtU19SdpsT0VaiOxUVr2inbl12mqL/PLF9p4jW7AbfitF4/F6ojkjDZQFrwDLQfroH4q8cKel5mfUnHgVRh1NfY1ZekmwkmF2RU2nSVaTtw0W/YbtviGTfRqOuKmpaKafVifw6LvXMVp7lgRVNfDXRepEKUx0CVnoAF6wAgrTEIRBdV7z23AGnQvdr1Fkt7FK0OJ4Ey0cgAO0iKeCu3TXZmKzBYjEpXsm/Z+/mAH4Q3q+dlNvdBhd4ZlzNIZb3XQAbK8jFZPg6OMd9dA6bj39yVM4qo5vMRmbM+GG+AbPL5/tWYdv4zx3CE+1Dnq6FS5ETna1ko9rO7cMe4Kbs+cGjxBjrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mxAN/uw+KQ+eWX0KABKBPwxJq5BIHsukxFM95I6Kh2pxqvKVtk87ncWlVEOp?=
 =?us-ascii?Q?g5KADEOd30cl/cWL3iA1qHvqs15FsNy5Ay3N90Oj5W4aryrkFjH+1meozTo3?=
 =?us-ascii?Q?2XrqXp2oAbn1LCLpEnitWe0OLtyE5U/mQMta73hMdr9S5o56J5HAQOf1tVD8?=
 =?us-ascii?Q?e9+LkWDZA3SuK3ELRdZkAHSLe/8GcfwrhEPpv+rFk/J7RJQXUavEpdDBIxLN?=
 =?us-ascii?Q?98uNZou9rIrbi9iBrKPX1EnIJfirBDRtoZ2UZuXYzHwfSqsbUp9laIDjYRyq?=
 =?us-ascii?Q?8rkIT6g/2JYY0vPiW/Zq3UDCZwGoTx86Lkg+E74Ig+ji/NqIC7Tb3Uiij6Be?=
 =?us-ascii?Q?dzkMHU8G2TRqdpzybWZL4j8DTJwHPvxLxMcYzrzmcIVZI4b7YViEAK89v1VX?=
 =?us-ascii?Q?LLqV5xQ3XGXcfPmcaDvBBMhwDuSNjygNjO5QsrNAOTm9TprIUWsjTYNcT/c2?=
 =?us-ascii?Q?eMYw/RaiP5d/SHvLE+ZNi4HP/s2k7WbyRU8Bfd4+DOwXYKre++ycwUp+6LNw?=
 =?us-ascii?Q?prXumeMXj7m2dZAJsz3H/0FMZXkleUZR1ZbVpAG3Bh49gabUJC6JcEd9ihTL?=
 =?us-ascii?Q?0fPmAZLB6Xhz4Yyq7cS5wSqNW48XIara6qquSfgXfvmpOl5xo4Sewu+0QYWM?=
 =?us-ascii?Q?UsibibVWVuE5lTkV4aRiBT8JLFoFpeCbIIzsZ9McHdjuzVBttWOJxZBGFbuM?=
 =?us-ascii?Q?g9wH2wz1tHVdXeEiLdu5k+vh+yAkr3G/ExGIFwUSXJQ6fX2TyVajgU3X+Tx7?=
 =?us-ascii?Q?0L1Zll26DokLgysnoYBIVl5X664mhimsRS7RUKVrsN90yJoLtHJR/lUmdXXh?=
 =?us-ascii?Q?Twyw3ZtTnQRinSlKvRjfDRku0kKtROKW4ubK0MxwBNJdHB1yHC7x4RSSfFLz?=
 =?us-ascii?Q?Ls8wHjbbBfnkOfVCV6lp+majn10ZtSSzDqDelYbEL7VLqCu6R88yNuRwD3mz?=
 =?us-ascii?Q?Kt5XDwB+trXSJBTY9agrC5UyVAHjLTiXXV1N/6ogXy+7kargUuTLcq50Vd93?=
 =?us-ascii?Q?LpXYAfFEzxFmrW+SoqSOpwmyJJr4K4iRQ3hQ+xIdCJppF9dL9QShuhRQ+cJ0?=
 =?us-ascii?Q?vwCLN15nDZBib++HGGQ2orm/gxonbu3DaW79ejOdAuRZSLhbH6PJXmY6s42O?=
 =?us-ascii?Q?R8aeEKKaRFiLk3FTtB/9Gj/2jrU0eAV0fFEO7v3OkYXzdWqQ52JfatND39EB?=
 =?us-ascii?Q?hjw+wXfDlMvNutQgLlZyA07K6WqEzTuKz+l3Y7yg7dePcMDbKjPGMxlJFHHU?=
 =?us-ascii?Q?DEEDFmVw4FXrW8z12cBbBW9ui26vvdRxa1tWCqc9muLaD+sk3FrwVfuqSQ3s?=
 =?us-ascii?Q?NAXRtovpyMhma3JX72Telk//Gwj6xRg+YbNRCex10FxeeKO9MgWujvBAjrMs?=
 =?us-ascii?Q?wRLNzsN/ljb8vAhWzPgi5VhGGvsqX4yR2eTRcLx/t4LnoRLNUxlkxh7w7kAM?=
 =?us-ascii?Q?nxHlGGahEU5UBDOkjiLn/N4kdtjCsZtADwxsm/mUlRQYDAJLhmeiaxAznr+M?=
 =?us-ascii?Q?ndaXgK+qsxXFg951FWhON81Xhj1hLYzffKvRweDa26z52WJkQ9LKRCWnRVod?=
 =?us-ascii?Q?Ni53CZGIN0vQogPiuUktNyBdoES7xjoKQIsuyfCjUWYFPlmYERgQFXSvjmss?=
 =?us-ascii?Q?FnbI4uCmGBhE3m9T31LPl4t4W9v1+54y+deRb0fqK32VooPW0MmYwvTivU5P?=
 =?us-ascii?Q?nDub/SN+1qC8LXfydhAB9x9Cj28UyMtd/DqBtC9ETmx2f6Xni8jTilxDRW0k?=
 =?us-ascii?Q?DYhN02zvnjsmHa0p0LlFxaM2f12gPz0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8532da0c-55b7-4f05-dcff-08de7563983e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 18:19:35.1076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDXY6Z7VUt1fTO/VesZ+lOFTuDr3rh30k6zCAKKVG0evankPyVexI+n/N+2tqG2tjAE2FKFsrgZwkUjmJy3fKmL2xbvkAsyZreiEgz+QZ2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7891
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

On Thu, Feb 26, 2026 at 04:44:50PM +0000, Anatoly Burakov wrote:
> Test-pmd already has a way to run a list of commands from file, but there
> is no way to pause execution for a specified amount of time between two
> commands. This may be necessary for simple automation, particularly for
> waiting on some asynchronous operation such as link status update.
> 
> Add a simple sleep command to wait until certain number of seconds has
> passed, using the newly added cmdline library floating point support.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

One little suggestion below. 
> Notes:
>     v1 -> v2:
>     - Add floating point support to cmdline
>     - Use floating point format for pause command
> 
>  app/test-pmd/cmdline.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
> index c33c66f327..766c83c944 100644
> --- a/app/test-pmd/cmdline.c
> +++ b/app/test-pmd/cmdline.c
> @@ -152,6 +152,9 @@ static void cmd_help_long_parsed(void *parsed_result,
>  
>  			"quit\n"
>  			"    Quit to prompt.\n\n"
> +
> +			"sleep secs\n"
> +			"    Sleep for secs seconds (can be fractional).\n\n"

I would add an example to the bracket to clarify "fractional", perhaps:
	(can be fractional e.g. 0.1)
or even:
	(can be fractional e.g. 0.1, for 100 millisec sleep)

>  		);
>  	}
>  
> @@ -8044,6 +8047,37 @@ static cmdline_parse_inst_t cmd_quit = {
>  	},
>  };
>  
> +/* *** SLEEP *** */
> +struct cmd_sleep_result {
> +	cmdline_fixed_string_t sleep;
> +	double secs;
> +};
> +
> +static void cmd_sleep_parsed(void *parsed_result,
> +	__rte_unused struct cmdline *cl,
> +	__rte_unused void *data)
> +{
> +	struct cmd_sleep_result *res = parsed_result;
> +
> +	rte_delay_us_sleep(res->secs * 1E6);
> +}
> +
> +static cmdline_parse_token_string_t cmd_sleep_sleep =
> +	TOKEN_STRING_INITIALIZER(struct cmd_sleep_result, sleep, "sleep");
> +static cmdline_parse_token_num_t cmd_sleep_seconds =
> +	TOKEN_NUM_INITIALIZER(struct cmd_sleep_result, secs, RTE_FLOAT_DOUBLE);
> +
> +static cmdline_parse_inst_t cmd_sleep = {
> +	.f = cmd_sleep_parsed,
> +	.data = NULL,
> +	.help_str = "sleep <secs>: sleep for a specified number of seconds",
> +	.tokens = {
> +		(void *)&cmd_sleep_sleep,
> +		(void *)&cmd_sleep_seconds,
> +		NULL,
> +	},
> +};
> +
>  /* *** ADD/REMOVE MAC ADDRESS FROM A PORT *** */
>  struct cmd_mac_addr_result {
>  	cmdline_fixed_string_t mac_addr_cmd;
> @@ -14088,6 +14122,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
>  	&cmd_showdevice,
>  	&cmd_showcfg,
>  	&cmd_showfwdall,
> +	&cmd_sleep,
>  	&cmd_start,
>  	&cmd_start_tx_first,
>  	&cmd_start_tx_first_n,
> -- 
> 2.47.3
> 
