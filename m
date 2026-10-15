Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856C3CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 09:55:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2FA4400EF;
	Thu, 15 Oct 2026 11:55:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id D156A40041
 for <dev@dpdk.org>; Thu, 15 Oct 2026 11:55:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792058103; x=1823594103;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=DjRvp57qxR16lIEf4DseTsJ00DgXh28h/CGqR736DX0=;
 b=EBufU2HHWSzmtbMc4AvGUBKtq4BlKkszrDhBZU7kNfeAm/ERtwAyOesO
 ddUn4tV4ZEjGFo4oyydscCnWFaUbegWQuS/encLteJPPRpPTH+H9A0MfH
 j1pXO5XyHQdfh0R6QQ33Wwh6kckiD9579O8781UbQzBeMXX6itVus52R/
 S5U8TmuVTU1hBYwBIKNeADbIe4gRIoIjkovyQFr7yWkYYbHxzh3iY+47d
 pPw1eOCDA101XooqpZGZ6mi5XzsNV+Qdi9zGTpwxYa8PR39/ZicogArGC
 PHVeu9Zy+Zne4FEyOK3YFWnkZLP9pCnM9BJrYgp8i5+RxznrI8dHm8Fzf g==;
X-CSE-ConnectionGUID: 8Boe2BTQSKuvrLSfnwwg2w==
X-CSE-MsgGUID: AkzHnqWOSt2prwL2oB60RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="817867"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="817867"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 02:55:02 -0700
X-CSE-ConnectionGUID: Z93pU05USxWT6MUCXmY5dA==
X-CSE-MsgGUID: fGBOxHryTCqico0UzYpLFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2008799"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 02:55:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 02:55:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 02:55:01 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 02:55:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxShd+96HrYZbEt19DGdoqn4/DBw/aNfkRT60SdFl5uGl1XYhtE83SwxshF4zNDNpVFXu9/hs9CR0fZnCG2jcMHJQq4hTdr9w2xxL8sYQLDl0MblZPeNF1z+x7CWNOGQFr7/mLb7egoNYwN2TodSDevxZBW4abLkm6YAaNnIFptjS5ue118GxxvS1QE6jR6pAkvT7Tc9NsQU6aJVqusnKmWBBBb8wgjzgSdlFcGA0c1rMoXNLytsRmTM8mnJ0q33mghYNDUNTyQ0K9mYh1MmhrBOhtwKwSxBnB0eKHofygidNT+KRULYxWirePPTXsWUIt67YWdbFS/Krx01BNMrfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/sqcQuR1RqAEXIub8uWA/Ek21c1L3Dl7Ep+4Iz/ntw=;
 b=HxIpZDK2hfQrb4YtbLSjUtUtOxoKG/oB+qvYYo9eBrQGF/OAC4xr0ge+YJaICyuT66cHcL9a4xQeMf7Bd1aKW5KP0yb2+aMEuT6X9yF9UrraZf2aWkCr140M3OsWEBERweeUk4Tkyny6mTPgS/FSFsfRDigrYB0VwrxvFFBg1bshnLdrCr1rt+SQpRByMc0rgkhcU3KraMd0RcY5Xz0kJw2kic4pPbcLx3MRHowro98c955e+LSwD+QtbuktlkbE6tLwSe6EeClvTGlRN1Fxbo/N6sBG/pfPUKcSBjClRw5ShR4RFFkYLp2LSJmqtvJa3JzlEGXTlH55bNn5OYPWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS0PR11MB7768.namprd11.prod.outlook.com (2603:10b6:8:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 09:54:53 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 09:54:50 +0000
Date: Thu, 15 Oct 2026 10:54:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Robin Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH dpdk 1/2] lib: remove cmdline from always enabled libraries
Message-ID: <atCi5cpwhcv5oyEQ@bricha3-mobl1.ger.corp.intel.com>
References: <20261014192153.2693883-4-rjarry@redhat.com>
 <20261014192153.2693883-5-rjarry@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261014192153.2693883-5-rjarry@redhat.com>
X-ClientProxiedBy: DU2P251CA0019.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::26) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS0PR11MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 771b7ed7-8225-4cd5-821d-08df2aa25a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|18002099003|10067099003|22082099003|4143699003|11063799006|261009223027099003|261009221227099003|56012099006;
X-Microsoft-Antispam-Message-Info: xRp3A1jAMFZzgiAjIUzDsQrCccaqy8Bn4B7OrpweZ09DG92JWbTHf/9tvryzzEKzP7L0ft0SJMlqt3A0pG+Y0VWTuaMDbjvPj9c7UVXZSzmXSMeHfsFEDJRU8uAZoQg5x5Z3uZ5FqAnMOoYFWdWo5IAWkP84nDQgsHEQfp4WJCBaGqUYXwXmh/jBTna0GOqfKn8ggMozYFA/wukSMdB6TpVJtPpZxtuoTONRHjaaNF7NgT4wPuZSaISammgv6pxXIRZ5KLhL9Cnb6bYx26OWwg/TJzrwd1a2v9swZkvEqBIOygEm/GTgzSbVKgV+fQ5vfiXJuJwLO+d3oTyavDVwg12V9qJ0WJgvsnPnFJqaWWsdMmocKHeDS1WW5rj5JpaaZ7b2Vgtetyht9uljwkii8JSFVg4pY1T7aobB6WIPF9CZg4LYku3/KYxrRgTU7VLcpSCEqKERr8jUwi8lA4qy9ViH6VQRSjYNva3jYC1ByGe3IvRRbViwPoM8qIUMoaMCxHVujME5FQ4Rhr/HwII/6g+rdK48leX7j3RKCr94jLx7gRuuO7Yz6yFohGLmnfMp+/H4N7imdaQftj/lARi4lnQTI57djRGLEQKG0zVAqtsrkR7pbHUpM8o4W7WCeHHW1EahY8N16WXrwJtF5pTEEbmnZZ6l+/LEu3VeIwfnyXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(4143699003)(11063799006)(261009223027099003)(261009221227099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?90PohlLq9F3x7wL7IGhzRbC3vNPoYjFE+l+yZZfGRnFQImx4HX8rEUh32Mlb?=
 =?us-ascii?Q?Sa8TBDU8aKITlUmQ8+jr0l+fM+yByaRvIeZbYLpP3QV+Rm23n11+50AviZpa?=
 =?us-ascii?Q?QEYWzO6y5KlrauJCtu2Nn78DXa1gdkCvZMOo5loWZ6uGPlbqFmn0vrTBWP9m?=
 =?us-ascii?Q?z/hpypddsEa1eun7gIKC652h3h2Bs8l4PHod8O+dFeCL2Wz+4tH91AtkQ8V+?=
 =?us-ascii?Q?cdkR1X4UOaJtGlBvPEeRlWPYV216G5jhdVU4YAykZqqouHpJPiAF8iWBWgtx?=
 =?us-ascii?Q?YD20k+Vd4Pkael06SOscJ1+HhbvU5b4c9lNjJZnR+LouL3xDJjyQVm0SgrDp?=
 =?us-ascii?Q?oCIiiKyhquoesA7nCzKEcGy/1P/rZCwDmsxgydRjzQ1kYKRxnMiHOcMNTuVq?=
 =?us-ascii?Q?g8wEmkcRLIjbcOxCkWwr/Kevr6t7gOyNUj6lAWyGutLG1vODm8inFXHiJNJd?=
 =?us-ascii?Q?OYuddH4vZCeRip/gc3Q5nhCvl/EADJxCuDlQIer8ZdZnWfTOgprKNwNqacBg?=
 =?us-ascii?Q?3SExOELWP5qu8yDl9oY8FuTkQb+1obIC06peiwhuTTXCgp5WpovPmxkStJnS?=
 =?us-ascii?Q?1/kTLIDbDrlWIBX7u5l56+J2jY+vhdPZM3TKWZZdILv5VaSYz+6p3TOX0J/f?=
 =?us-ascii?Q?W6bd7RnjmP8RrTHEVeC+9KVWyS3uH4+CykQviACICwoD41LWjAKTz84+AsOU?=
 =?us-ascii?Q?J9hAEmr2Y4zP3ijIMyUtr/yc9jJZkHM9ZydFVNIZk0/AXYxs6+IrILbNzPsk?=
 =?us-ascii?Q?KtQWL6rjd8nogJpZiLOZrxxHv/HzXq2rSlHQZK0EG2aK7bi5H4DkMvv7TL31?=
 =?us-ascii?Q?gug/AmylA45x3ivgkXdyetU9T0Qoc9ytgp1eZbwtYB4bLgXVQIDw6qgZh/7W?=
 =?us-ascii?Q?QqWrdYFeGRp8pt9EWLDk01OT+1gTlh0nMLHxy3aHNGpK6gFoRLE7JZdFWCkx?=
 =?us-ascii?Q?4pVfHX7NbE/dRowbXWQFI3Yo0QEA1H1GtDl/vxOuk3JIVzfp3/rqwznj1eOX?=
 =?us-ascii?Q?XRPjytGfLF7bYguARrzUi7VWl3V1ANez4XRvB9EIfb70iFOxEJpzjzWSQl+j?=
 =?us-ascii?Q?R5ESnRv1qVderJfptBG35RfwajlE7lC1bgLErrVco1MOIVk+XkxLfGdh8PNk?=
 =?us-ascii?Q?LAK8TysMjboIms9axala96cw55+QCEcGiW73UpQuqc3tw1N3meG4vIjJTcdo?=
 =?us-ascii?Q?I6r8kDJaIzVo2/e7M9H3MIsYyIMGivyVdF5wmmD+ULPLf5pqRrX9YiM/Mffu?=
 =?us-ascii?Q?mQz5rekU7f/eahow0kPcJro3RJF7a+MofdrZaOFN9ixwxElFJZcx1tN2SFIE?=
 =?us-ascii?Q?vDV69FnDqjvIbXMFVR94C4BYfd9ll6t6W42lqm4C4lxjBST+C8zmbzwVZJMs?=
 =?us-ascii?Q?WJ8SmPCCMFzonAfTA48OMea9FPFsFReEB+uePus6vFID7wfEhNtSiBXNJaj7?=
 =?us-ascii?Q?vR1bipNh3Ktl3wJZyjVIcOOYQRY34fjpcGxjWyoY0OYzllwadO/2K0QCyLNj?=
 =?us-ascii?Q?gVH31liirk/FpR9Nsd8eciJKvv1mF9w6nKx93ptODsi+q7+/47DJWn8T46RX?=
 =?us-ascii?Q?4BknzpcxrOA+I/+8bGunNcVmKRbfflV6nUsS0eWxQqMyl8H9d1FwzvfyHFDl?=
 =?us-ascii?Q?Zj5D5r3t+krUOej18aBKPqo8pCi+EDrAFwKOEKBWZe8mg+1eTA6+/MydPtNj?=
 =?us-ascii?Q?Ga6eR4gCXVSMPUTSpdceghRKOtohFRuT4yxxwFJuNi0oHzpS0sHTcKjs74qf?=
 =?us-ascii?Q?UF9ogDOQVJqNsecBCkyi3PZUfedQ0xE=3D?=
X-Exchange-RoutingPolicyChecked: Cp3iBhIeK1W/cI092oGSOHN10qSqM99iOi2KD6KWn5F/SKL09e25fC/blTuXYhlVwhH5JlkYBCD0gwOsrkdf6YPszdtgYHxs/3IgMVjL99pcQ6HeZNhHLks5gFITkkwdYKwKLeoNFMZS8QVNACAdwgh0I9bS8bTaJBFZB0KmAfrZxTf16FS1PwwLwe+/rnGYyZoS6N4IwT73Akv062lesWEGEGq0hJ324YRFzVdmkZ+ePX5vnUgE3497fUuJ+eXv9wSCIyuZYxvMsGfO6Z3+LrViZ8IkXpSc1mjq30UMGVHdfHc4LAIE5+LHvQIf3pfc/eQkbEZXzEndKNuSI0uijg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 771b7ed7-8225-4cd5-821d-08df2aa25a52
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 09:54:50.2043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5ieyW0MJYdGG0g89Bifrcv5YLgw5bfNAeLQy6rA3ObQgHHE5aWQYtmnMbaTFWjsFJaqtICfj9Cf+THCKvIPgPfQnLPstZSixbls8n3H6W4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7768
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

On Wed, Oct 14, 2026 at 09:21:54PM +0200, Robin Jarry wrote:
> This library is not used by any driver nor other library:
> 
> 	$ git grep -l '#include <cmdline.*\.h>' -- \
> 		':!:app/' ':!:examples/' ':!:*testpmd*'
> 	buildtools/dpdk-cmdline-gen.py
> 	lib/cmdline/cmdline.h
> 	lib/cmdline/cmdline_parse_bool.h
> 	lib/cmdline/cmdline_parse_etheraddr.h
> 	lib/cmdline/cmdline_parse_ipaddr.h
> 	lib/cmdline/cmdline_parse_num.h
> 	lib/cmdline/cmdline_parse_portlist.h
> 	lib/cmdline/cmdline_parse_string.h
> 	lib/cmdline/cmdline_rdline.h
> 	lib/cmdline/cmdline_socket.h
> 
> The only apps and examples where it is actually used already have an
> explicit dependency. There is no point in always enabling it.
> 

The original idea was to ensure that testpmd was always buildable even if
all libs were disabled, but there's no reason why we need that requirement,
so dropping this is ok.

> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>  lib/meson.build | 1 -
>  1 file changed, 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
