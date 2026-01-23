Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A2AD77880
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 16:50:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E00F40269;
	Fri, 23 Jan 2026 17:50:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id EB22F4021F;
 Fri, 23 Jan 2026 17:50:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769187039; x=1800723039;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=kLyKANtpWmrDXd0L+Z70mrsA6HWuaGjt1QKoNE7H/cQ=;
 b=S3siPyw0vagZbtgzKMFmQRr6HYPdw8snYlfuHThbVov5B91cbSJeGKw2
 WcJiIstYKUmGK61qyczFsDR8WrsCMEGTyTfhjNZA7ZJWFMkMMIE0j8PmE
 7GUcC7ZoVC7eWVxP/+Bdq6iBpXiedAOy9nT/yicVNnpY3HpAn18YrsZ+B
 14AtacagFFpFCJtCY23zGe7okT1wQ+2mVUS0uTaZumfZh08F5F2AcItXk
 AsyQWAq9+oBN9nA6CbhLES5NnFnwc1RILoe2NzteGRuGNpdjrjeS+Ur8u
 BXGgzVo4N+s7mJ+F4UR0HUBxqnK6pnUs4nR9e30kiWNhqZKccXZsXQmyA g==;
X-CSE-ConnectionGUID: mHj7uWicSnm/8LGPiYrH9w==
X-CSE-MsgGUID: nW80AjBrT0KjQbg6NirhIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="70163463"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="70163463"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 08:50:38 -0800
X-CSE-ConnectionGUID: GFdSoX20TCCTwF5L1bv2nQ==
X-CSE-MsgGUID: h70wXntYQB2Bqw4t2KuTBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="207098886"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 08:50:37 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 08:50:36 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 23 Jan 2026 08:50:36 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 08:50:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9AgB4KZO0FXhVAWMyDbRbLJAIxh6MfasamUJ4d/REcpzSf+sLc1BUH1PXUf6eh30t5J2PcDUlmU3YnDzln4LVkuECOlOskmS0w3EVKMYKc0FHnSL+UQZbLeL/lBxDWVDbRayyqqipVwjUfLLi+vkiicpUkuxLnJFOSyWV+ko5QhlUfMydnTGHdif3zomf9Lx2EA3uL2iFkwEwTZSb5aSoFoIw+ti/aPWbiWF03F+Up1NJ2+4FNCvmGCkAxhwCVPGQKJ7Rl7mUlg8Lk4GeOg+f2IjRPDiblTBdTNvbZpusbXp/b1d5e1r3byLZG45WRZUbbmFfx+uouM2pygDuFpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZq40WbGO7EFOyocBRG3K+yVI9HFiyNgdwzYleFGkFk=;
 b=PyRowXnDeAzNtp/76r/J95f+dKAFrvSyeTjKu/812eST2G5DLVi9/2jqBFSJbyvUKtpBzyj45dta5QUCD9NoWerxPeZIJa3pkz5wt3UfUeC/JY1IBndapSc5kYkxXPS4/JOGveCejcfQHPJVuzZXyehkH9hSb3UQk3pMqHsQWln6thBaY20jn2qZJRA8QAcF52lGKKhpbghPeB+aElgzUlzlrlkEDdamsjuRAlqp/Vx/CyWdkjSMyF6+ZI2FxmqsaQM90WP0DQ0U9t3EUvOHKJ5ESWuwOsYZGnYGtRJSJ2sgfoZ/1IGRMW8WXemgb2g+TbUA/CB/dDDRLOprSci+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Fri, 23 Jan
 2026 16:50:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 16:50:34 +0000
Date: Fri, 23 Jan 2026 16:50:29 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thierry Herbelot <thierry.herbelot@6wind.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Anatoly Burakov
 <anatoly.burakov@intel.com>, <stable@dpdk.org>, Olivier Matz
 <olivier.matz@6wind.com>
Subject: Re: [V2] drivers/net: reorder Intel drivers list in meson script
Message-ID: <aXOm1Xep0eINPO3y@bricha3-mobl1.ger.corp.intel.com>
References: <20260123162104.1854187-1-thierry.herbelot@6wind.com>
 <20260123162707.1854505-1-thierry.herbelot@6wind.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260123162707.1854505-1-thierry.herbelot@6wind.com>
X-ClientProxiedBy: DB7PR05CA0004.eurprd05.prod.outlook.com
 (2603:10a6:10:36::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a2adf3-ddb2-4a23-a2f8-08de5a9f86d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nouEu5zWabm8UeVD+mcmD1GeDHR2Li1Srx28mK6ihqFrqbbQpN0V/Uq/ysLa?=
 =?us-ascii?Q?XBOH5ogm80gfesEN92BZ8MQXBGymIRG2SLQsQecKmyJxwj6iOFGvhtiPpf1p?=
 =?us-ascii?Q?1L1FAg9Q8PjWQdtdul2ITO31CA3rBHTbpprCewX1qXpiNvfUX8X0/zvsjsEk?=
 =?us-ascii?Q?mYy6vEQBtZsKg0gVagtmsPzRvMuJI0NUQlcE/eb0oeg50TvVvajSFpsmH4SX?=
 =?us-ascii?Q?gLBemqmbmejWkrV6cybEdzhzbJgm6O0DneqQLAzv96U2yywtqc31t3klCP5L?=
 =?us-ascii?Q?NuvKPKEtrVVqIKa10QSplBOv7Deb5k/gQGFREe7CWfmsiGY2UQfMtf5jAhPH?=
 =?us-ascii?Q?pqOCfpbzwasoQIojGd1LvX3m5WtoKvi7mEVqKqaXOApeodcVebSgRnA8zLGj?=
 =?us-ascii?Q?WjsV/3zCnPoGpimDNzRl1LINTAIIgxSmualEKmHzvurnLjHnIa5QrnQrGLMc?=
 =?us-ascii?Q?kxMcpHIfi4voTY1Sv/yVUdTYVD9xLwXkdHc6Yq6jun2Gp3bk42MRcb2yaKV/?=
 =?us-ascii?Q?uZH3KuaNtL5Tm/y91CS420nSgxJ+Dhpxhb8obfPaCBjY2XX4dXAn8/pTOCbx?=
 =?us-ascii?Q?U06igQZCFWRyUio+ISgMacl5UMVbvu1caNN4ZPcHqBAxtDU5jI/oDNxJaYm4?=
 =?us-ascii?Q?VDHjOssVGo3ysGCZFBHxi9LnKW4fh0M2eeoaotfu7ZWCAtQ6w5utPwRrkd5f?=
 =?us-ascii?Q?RxSgb4yoxRehh7JPUMjGRjNvSBJlr8a2UVVzMNJS1B8oPnQBo2fwdbJDu3UL?=
 =?us-ascii?Q?Tx0N8sTYrLh/lOqgTlvd6r+/ZHLwjBIsI4gnwr50FMvoWnmPH3/MVLPEyY0+?=
 =?us-ascii?Q?ehkszeduYUggUe46mTNAqRJonAAnB+2HArbEOiylhv1kHBP7nOJasvNDmRes?=
 =?us-ascii?Q?pxcyNnRc/b/3bP84WE1SayXamzULi21ecRY/q8lxnsTqrMF2ifoPB3c9eQwC?=
 =?us-ascii?Q?HLKX59xkGkzSVfFHYFRN8Arahg5JhIbfAwZt+qAQk3u7nQ04BjBWWbdzdzhN?=
 =?us-ascii?Q?lfNGLuBoE7hMHKeREflGs/YN4cN1oJScMOECraJ0386n2CA9GfGgkuuUAQ5I?=
 =?us-ascii?Q?4rcpP6e+IgafRF0ymrzF+vzNvsbY5VPX5jAVmwJIg9H1EabnW+bd9KirM6qL?=
 =?us-ascii?Q?YTWaEGo9MCj/2AVBgsuPRzxsEV2f5ckeNYsqPUJN/0FInNefgNJ8zK5VkLsE?=
 =?us-ascii?Q?m5bgLPvSSag/Y8ABF7ZlkKHa39ImYvrS45VAs7fo98bwNDL6pXutRcAYK2BT?=
 =?us-ascii?Q?Fk/skagzNyGCngjoNXzdkCV4LOx1luYIClZjOeiULE1NftOOgguspzAXuKNZ?=
 =?us-ascii?Q?UbEqWYcqgOr84iIR129eIg5kve8vJbfuLNsZPHobMETNRNboA042h3HQuaPy?=
 =?us-ascii?Q?8AII4lfFMCya8Jdjr+A456zwhIqaGzbC42RMSlZMK8YXrCco8baC3S5vg8MU?=
 =?us-ascii?Q?4QfemKLl2GluDrd+D0uSwrAMngXdmj3la/XHEDEWb0GCbfYxAPcXujQuhzOX?=
 =?us-ascii?Q?L+o43lwZpnQONoF792HLJm+oEDjiu4CevRYyfGEWHZtxm01+Gv2GajkiZVJd?=
 =?us-ascii?Q?Fhcub74c65FtKd3x4Ho=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+N8DB4phdIC9eg84mlQxekdtAGKjKa1qCwAnmHQncj5dHftor6YMYFnC0o0J?=
 =?us-ascii?Q?77TB7iBHr5SCgyqRmuHlWHDNQjXqSWHS14MKIeCilLS1FXF0gWWT9OvcF265?=
 =?us-ascii?Q?xwqA6GgJ72rqougUlMP1GS35C5JflhxSrS4SB0gMhiQU/IiKIW0ec2Kox1w+?=
 =?us-ascii?Q?aQJdmtDWlumh/9BrVQEebvwphs+3tKOxjRWF3A8w3QFTpmoPy+v2TT63VOEq?=
 =?us-ascii?Q?tf/C5ZiNh68UTcQ14xUB+BYIT4nPoTjybPaHZeaL+J+u3p5yJTSuWWrQAB12?=
 =?us-ascii?Q?4q/zJObzeSWpLhmDsdoVN+k0p8PsdyGErgy6Q9okJZQyAblBD35u+cAkRfQy?=
 =?us-ascii?Q?yWlBi4WAkhB/BTu4DxFHgM9S7GcEGvF14tTyyUvKswR9PsCvjqVXX2i/x4DA?=
 =?us-ascii?Q?hwp5PcesndrqppAciFBv2ZczsGj43cfhi9oT+1npnPMekEJegWVgc5crI6pv?=
 =?us-ascii?Q?18to8ejjLCFlW8FSyWoGl8bkIDyFuYKS453+NLztTIvpTnE+Z1FSXooDStPG?=
 =?us-ascii?Q?jr10hOlbQ264rNttATKug8Jlf0BHFI8a+mZrxWeQyhAsYYu/HIm28QNfRHi3?=
 =?us-ascii?Q?v7ajKrIDLJ/GIcjhNHghfpic2oVmcW5ct7CwaaGBHMcth92wc0BuJy2OYTDZ?=
 =?us-ascii?Q?T6TMLF5PTVoEwnsE78sVM45bA7t7KxgGDnNGg+Jgn/7MxLpDCZq6JPPNwPfh?=
 =?us-ascii?Q?t6jXh5lv6i/bA0PtvpSPrzeCnjn+C3qE9Kuvn9QL//hecmq8tzEJiXxCcR/C?=
 =?us-ascii?Q?LE1zVPTQYxHR4ZbgD66Q70NMdAQ2BINiq0q8tDCXxiU/Pgnp/EGy+4vK+Mb9?=
 =?us-ascii?Q?lSoPoe4HIYpZW3ZubSLx6DhR3+zhPcOK+CqI+Cdw+jmTC6AUoIUpjkIzTOKj?=
 =?us-ascii?Q?ZDMyTnBuCrgpZLhrxfp+qx9lZEr/H2IVaPUksYTKvMdcrs0hjlyAwBXlu82r?=
 =?us-ascii?Q?Szim7I5LrOliY9+wemeLMlMtJyK4syx0S+e8OTWQcjhoI2Ch7JJJdYX+2Fw8?=
 =?us-ascii?Q?felTx7qk/6LyNxvNLnfMKAYQ3Wm9M1YYXVJR1WdGxIqidZgiSfZ1oQdEA+jw?=
 =?us-ascii?Q?VHNpIEJ9GqT9uekP2Lct5jgLrMydAGl9ENdl0LzNjLnXuAD7QW2Kj8r4Z5I/?=
 =?us-ascii?Q?i42/taeu97+RibvAhWGCynPkozie1MK1mydNqdjvQtn5HbHKDeu/nQqXDkqS?=
 =?us-ascii?Q?dyGhhRFXvOkMUIox0uUKmM2gU1MpMSX3YbbgzRdYvDU7PS2+oa4OoU+TFeI+?=
 =?us-ascii?Q?UPIcKE0MB/uNYZ4dCZkn136uGo3IZkEsJUw6fKeBZeq5tj5HuNtf+E0vYdDl?=
 =?us-ascii?Q?RcqHzMxp/EGgKNxa7enfs8XCqTQ6YBI0rHV12glIzDwjfpOdYCzGbyvtBEwX?=
 =?us-ascii?Q?f4+vRnVrGDm4wTTPDdUgw2FkSBsGoFyg9GmMq1yOi+ch/crxWbxDW+nvQqMH?=
 =?us-ascii?Q?IX8HopKCsXzKYBFGwYF9uR6M0myVu3udWIZ/rm2hjH77+1iTD1WA781IPtwW?=
 =?us-ascii?Q?2/AWMKsqcpZ69TMnZqAjoReFPZyxEEB/7nMEI9HBZRt/2M6c7obW0UwdK4RY?=
 =?us-ascii?Q?rz9F+b1K4ioHgUArTF9yozT91QjysN/cWDtVgzyjmndhjPrh9tBgmAT9Vtzd?=
 =?us-ascii?Q?k566NUVK3eDouNIcnS+9SNwWyYyacVQeRMhDzZQu84+d8TYsQM6OWrt/xBEQ?=
 =?us-ascii?Q?yqbsGtDlhq12ZWo2dQGkc1maj0/yZ48Ptvc+PiFq/KrWlam6F/pBb8D4LyJU?=
 =?us-ascii?Q?bOKTiXvH3wmCf95K5NvYkAhRsMwD/K8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a2adf3-ddb2-4a23-a2f8-08de5a9f86d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 16:50:34.4113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8+IGSgmrOtQjasEFztvpd4ASXRC/d+8wofK4GwNKiQYouNiUUAsi9qo6kjnGNrOGM4tAR+vAWbbHchqSQvP8Z1WUq7zdtL2/co39pPzfFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5214
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

On Fri, Jan 23, 2026 at 05:27:07PM +0100, Thierry Herbelot wrote:
> After an upstream patch (see Fixes), net_ixgbe_vf is no longer
> declared in testpmd PMD info, when compiling under Redhat-9:
> 
> > $ meson setup build && ninja -C build
> > $ ./usertools/dpdk-pmdinfo.py build/app/dpdk-testpmd|grep ixgbe
> >     "name": "net_ixgbe",
> 
> Name 'net_ixgbe_vf' should also be reported.
> 
> One workaround is to move 'intel/ixgbe' as last in the list of Intel
> drivers. This restores net_ixgbe_vf under Redhat-9:
> 
> > $ meson setup build && ninja -C build
> > $ ./usertools/dpdk-pmdinfo.py build/app/dpdk-testpmd|grep ixgbe
> >     "name": "net_ixgbe_vf",
> >     "name": "net_ixgbe",
> 
> Fixes: 04f1b16c54f3 ("drivers: merge common and net idpf drivers")
> Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
> ---
> V2: use shorter lines in commit log.
> ---
>  drivers/net/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/meson.build b/drivers/net/meson.build
> index c7dae4ad273c..8d96244cdbb0 100644
> --- a/drivers/net/meson.build
> +++ b/drivers/net/meson.build
> @@ -32,8 +32,8 @@ drivers = [
>          'intel/ice',
>          'intel/idpf',
>          'intel/ipn3ke',
> -        'intel/ixgbe',
>          'intel/cpfl',  # depends on idpf, so must come after it
> +        'intel/ixgbe',
>          'ionic',
>          'mana',
>          'memif',

This is a strange one - did you do any investgation into why or how this
fixes things? You describe it as a workaround so any hints towards a proper
root cause and fix are welcome :-)
