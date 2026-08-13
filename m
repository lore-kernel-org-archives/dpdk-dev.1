Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95028C5CFEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 15:22:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6273427E4;
	Thu, 13 Aug 2026 17:22:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id B2472402D3
 for <dev@dpdk.org>; Thu, 13 Aug 2026 17:22:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786634566; x=1818170566;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=KlnIbThiQjYbD8crIMnmQZbiHraUk0zmpW4Qr9QGPHw=;
 b=WiWnKKRNgJe1dKXU3SGjmnuqz+khZ4AodZKKflvEjYbEgzNeo0j4eEpj
 w3/2Ug6u7DVASKhSpJADfp8+2sekb8Tw7wD2fuwr08oHzEZo098uWRPz1
 lJTAUkdMddhZcJKAfMWledpdqt5BEkNziyUe1gdPufZCdJCE3/nb7briT
 7dshHhtpHxSEZZ6+vb55QJZgNv7J7ZUBkZ3M00BvY5DDuPNg9QoZGvbrI
 wmrpolDFsLaLc4cnHGNiZ3AHepqrDaNPpBbMc5Iz4vA/GaSHsIcOIY1fK
 U+U2Ayyjsg6kcEnld0HzpcM1BcIBkDLtFIe8g/XgmYaXGJa4l3aHPdMkW g==;
X-CSE-ConnectionGUID: jInmYCETR2e57MSJe0QQHg==
X-CSE-MsgGUID: Yafa/A80RLS8gCTrCnkehg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87337896"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="87337896"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 08:22:43 -0700
X-CSE-ConnectionGUID: xpDYKm0lQj6yswaOtitU2Q==
X-CSE-MsgGUID: J1n4bN1tSziWjjgobeTUfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="260695523"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 08:22:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 08:22:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 08:22:38 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 08:22:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXp0mb82MLN3Zxfc8dqqLf/VfYDCLfRvpGvT7Sl6K6Amiz9eZpAXAPPqDWNDqdHvnYR6dVIS23EIDzJtxcsZ47F31hsBzO+rW5mob/iDi5qCg2jytNdIL4h8WdNFb/WyRuEReFPY8IqWshZo6sv/wAIUcgvGxMGiaAhWO/uJ8u45TDw/MvtxFbGvPmYKH/NdQe2GOSAmkfmPLH3sqLFeFwc2jj5OW6GH9C42kaqFVrIuPqoRYEdip1xcJgC0ogBUdlIabAdxPKPNheoB+cWuRjb7P1aWM+jtrMYfKqJXVDsY3AdOXpElgDKueU/8t5lywq6VWmctCNSv3nfk1LESZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mx2QVRW/dGI7bLaVUjitDnvL3IeFMxeS73aQD6Yn7A=;
 b=hVdd3I2VqzUaZW0TSzKx71h7HHv8JHhO7WF1ZNn9LXE/OZnWCIbUSeT6vEXjNIBvfT1BmlPOkp/O0YReZmJ/XlFXvrj0ij5NNX+e31nhOS1dDjXuTsvstXj6m5sbBEaP8JrXVpUjYeQjgN/NLeSRnjBNTWJryL3A6N/087ZcnElw5s6wwlNMhJJrulfSdDew9vMysOteqWwid7ZGBEtyAJGuJGpnu9r5zYBH0pnX3H4u37/w7DacQlezvmSTtBIEzqLJT+IiyKxFyorWBACTPqxpymPs3p5r9rx1Yu4sD9AYQKu4kF7uHDgm3hxKPkJ5s1Xal4HBRDRAzkQMdvzosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DM6PR11MB4578.namprd11.prod.outlook.com (2603:10b6:5:2a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 15:22:35 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:22:29 +0000
Date: Thu, 13 Aug 2026 16:22:24 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Hailin Xu <hailinx.xu@intel.com>
CC: <dev@dpdk.org>, <manjunathgouda.hosamani@intel.com>
Subject: Re: [PATCH v1] doc/ice: Add E835 to ice guide
Message-ID: <an3hMPwELdziO4Zx@bricha3-mobl1.ger.corp.intel.com>
References: <20260810020420.128869-1-hailinx.xu@intel.com>
 <an3dpmK6j_sn0QEl@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <an3dpmK6j_sn0QEl@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2P251CA0025.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::23) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DM6PR11MB4578:EE_
X-MS-Office365-Filtering-Correlation-Id: a333036d-a15f-44f7-8e53-08def94eafd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|56012099006|10067099003|11063799006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: zCwsM8abb177WvRL/oL6jMRsvpAH1EyDx8DWaMRcUUF74EydAIJj0wJJQeBjPqkwPINAQzDSgYpcaHO5fxEyo6b7qsiYUTcRW/Jh94pBQXtH+frCpsi4f4SErO1oxpjTq5t/Tb8SPK5l34o3aOT81EF+uiJCb+mAJwPynofK7uDe6/Dr/L0PvEP98ubT0sOVvqkK2OfvNNVhfv09AiDMCdgf0uV33zTGYCDXweaGKaN4D/iEcCyjgFELv3i/Py6L9hkVx2WPsYKQ84jJzylR8LSIPp0I9YYxMXkG3n2lbn3ql+9M+i+mcyUjjocpX5p4eY8SFoUS0nwkmW9XU5/1xY5cDuG2vanZSmllFkh1J0K6qbn3D9XsqN7P9PKk5KMsZXlrM04jPRYPhSArsJVxDmDlMKPtaccvePOLGyV5DzL6QtGTkgpA3CtEG7xV4k6UVh3qqS2V9LTt75vwbiHFF5MD4DS9FFSG8b3EzNOfCBHofWgSKQeQfjt8fY0uPXfbG9L280A0b3ccmOiPJNvoP9UpPQfwW+1CcexygnkexwAp847D8RilqMiqtEkE3s1URQg4zF/t+WdYjx0M7hXJ/oiM+BD2bSzgmRt01Z6f40mjfwl82h12ME2jSiRBTlnqk9Ft4nq6iNwnYseQbOrcUg96p07z7BSmZojdxi5NeP4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1zhd0BkERItFwKX0FF6gD9AktoidAq0VfrYjHwl7DRJ1NacjCVhCKnsjr7st?=
 =?us-ascii?Q?8I6AxC+TXdoHZrYrTOhs/5QFerGdxw7jTv+ghZGJ0KCFMxsxT/K7DguRTjHk?=
 =?us-ascii?Q?Xt1v48XDeXZucqFdL8hqP2etqWEpUkrfwjig7Yg6L6co2iegHFCNr2/ucoOU?=
 =?us-ascii?Q?XAa1Tm5O/Bq11AvwoSbg2hUrhGBEciZGf0P25voPIEHKv6zGPQgJ12SknO4g?=
 =?us-ascii?Q?8ucL8Bgw1iKgszl4C/fqXLy7C/ag8++BoZWlurgdKIXfawg2Zjudt00vcgFT?=
 =?us-ascii?Q?NV3ZQn9JHSv5AjR1tDy7Cifdpk7GmvQRxKnUGjRY+e0X934B6H9BSQUu3JeA?=
 =?us-ascii?Q?DTa1vx6kd8IPALP5BydZs2HtvENNwDVeHsfcW1gJ/j1j5JxXgSpD1Ld99PaP?=
 =?us-ascii?Q?30gGD9Wbangee2T+IhX8rdz3fpzcTxjd6CXZwk7vjjU607/6nvwZQY014ohn?=
 =?us-ascii?Q?++eA6g8f+Bs0LbOtrIvh0V6gVV7q9Vg8mPkpGPDpd5RnoluIwILV1Ltm/VZo?=
 =?us-ascii?Q?YR/Y/zhpfEG/WQhIeAimVe1WIpGxg09EQWKEWB6LkRcitPFc1PGDEq6D0Bi2?=
 =?us-ascii?Q?JFBRXv0PYKFXzNsdQVTOOWD4EgynDb/Dr21wS7O42vCaPU/5m65goVGTOXJ7?=
 =?us-ascii?Q?6M6aHlxBDcWy7scbhmyUbOfYX5VM9U25Hg9/AdixEtHO0+6nVspQxGuE/yow?=
 =?us-ascii?Q?Au7oSUw83XzdOphq5pwc4jo0TJTFgZ3jjyXV4xZM0m2D1cZwdsLNb1IP2CbM?=
 =?us-ascii?Q?d6XuT/OHhssdAdAwXVDRw0xc1iC7s2sVJ0LS3Ht9W2pwyWCz5XjZtOoiMpib?=
 =?us-ascii?Q?1WifmnfYQSOL1mkA1Gcct7Ks0foN1+u6f1+MwJ0DESIpwWExI6Ggwi0lITZP?=
 =?us-ascii?Q?d5NoZ7Bx+tbLwXyIDTWYCRA4SknyZbZN8hqJPrdijntC4eBFc1wS6yOszb9+?=
 =?us-ascii?Q?Be6MMPt+ZofxbuYc3M2zuU74qf5+k92oQobj+Uw/pi0zHZQqFiPVxRxeVEGe?=
 =?us-ascii?Q?BGuWBks3tTpRG3PH39GFKhCqU817Sxair2KY6M/hIPvvsueG+r1lVf3AIteP?=
 =?us-ascii?Q?l2AQLWCzlQWyQa6eokTuxUhnIxlc7rww/TJy6N1YgbKB7KBgDArgypxmBk+w?=
 =?us-ascii?Q?o0Exik/xXPI/ddfkifo2Zye7pJ+84nE9JJ86UgGljfyhGk1VX/WmJQpLM/CF?=
 =?us-ascii?Q?q+0kXKdy5UZ/GG4kAR5wmQYpVWXVYBJpj8lSQDpiXh6w9cdSNmaBXpH0rCs5?=
 =?us-ascii?Q?p54FtpZKINq3aIMukSJutRGDcsAn9jwPFumUAAlM4uhKBrNNyycecjoJN0FF?=
 =?us-ascii?Q?bx61s7Y79q/iw9ij8VwHvM20ZmWVQbWWqqaM3inwp55ItNJtq0Ty7XWDHjmg?=
 =?us-ascii?Q?DsV78Y3vY721z6mURD0PCGEMBEUsdcmQSnkC2A3PTa2IXf7dgwYecIAw5hb9?=
 =?us-ascii?Q?YdwcnSSw6q7GiIsZQMpXb7MVRMAH0aemw+lLhN64qLEnRHDECxYz+t901Mdv?=
 =?us-ascii?Q?ajrStRLn9/dMpgYhDKzFoUwo6y17miPVRrG+E3zBvkSupDujaSRwUNLVBiuv?=
 =?us-ascii?Q?S5wq2stEDF6Dv9NNeJAerHPAqQksMk/L58/kwHghuwnTc/lQwwD7EksW8Mqo?=
 =?us-ascii?Q?M05Gj7NT1zqSEGwDdgeAQbRbqEsUWrP/D0EJzfiWMUqvXYA/TuX4GMy82Gke?=
 =?us-ascii?Q?Q6YJmohCStXvm4F/FwYA/7wbTFwkY2djCW2glCfIWbyW5ubkfiD+jdozKUNu?=
 =?us-ascii?Q?YxsUfLa4ctjcAUK6Rf2xxZBSQ1a2ypE=3D?=
X-Exchange-RoutingPolicyChecked: en8iPv+AEW2u0nOQBvdpUF2KVIRSQ6E7r5Tb5XYEKC106a3BY5mQuKDw/W+/QojXCbmwZbuS3EUuIUw9q+SQQ63C/2ft2Q8MO08Gavfuv6G+T8mpC95dnjw/nT405drHuMStuYZfERhctI1/LeUpUHFvqSt4ZJorKP2ryDIWHDaAiV6D1t3mEEcFdm+FBiGOIWoFhuFasnohVmGMy0zMc/uVwhapPXXjKMLVM0/n38J7J8Z/o4sM1Kq6Ek5C9Z7Q6CYRkex+2Q2hmttvuE3LolTMZc4LNGTbH8q35NaBHTjkv0obOVxeM44L1/FO3tJ+s5k7qqdYS5pqYaITRVd5Ww==
X-MS-Exchange-CrossTenant-Network-Message-Id: a333036d-a15f-44f7-8e53-08def94eafd6
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:22:28.9330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqRW2k6X6CiPev/8OcNRpzDT38fsRk+HdC7ywoU08z1r3sTsZTEvRmflyndQmjf0heAjPCuGpjEZJdK5DL0wGyPGr7EyCJM4jDH8myNGYgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4578
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

On Thu, Aug 13, 2026 at 04:07:18PM +0100, Bruce Richardson wrote:
> On Mon, Aug 10, 2026 at 10:04:20AM +0800, Hailin Xu wrote:
> > Signed-off-by: Hailin Xu <hailinx.xu@intel.com>
> > ---
> >  doc/guides/nics/ice.rst | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Some suggested tweaks below, which I will make on apply, thanks.
> 
> > 
> > diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> > index b671422ad7..e908b11f6b 100644
> > --- a/doc/guides/nics/ice.rst
> > +++ b/doc/guides/nics/ice.rst
> > @@ -13,6 +13,7 @@ the following controllers,
> >  - Intel Ethernet Connection E823
> >  - Intel Ethernet Connection E825
> >  - Intel Ethernet Controller E830
> > +- Intel Ethernet Controller E835
> >  
> >  Linux Prerequisites
> >  -------------------
> > @@ -58,16 +59,16 @@ The full list of in-tree and out-of-tree Linux kernel drivers from kernel.org
> >  and Linux distributions that were tested and verified
> >  are listed in the Tested Platforms section of the Release Notes for each release.
> >  
> > -=====  =============  ===========  =========  ============  =======  =======
> > -DPDK   Kernel Driver  Default DDP  COMMS DDP  Wireless DDP  E810 FW  E830 FW
> > -=====  =============  ===========  =========  ============  =======  =======
> > -26.07     2.6.6         1.3.59      1.3.63       1.3.28      5.0      2.10
> > -26.03     2.4.5         1.3.53      1.3.61       1.3.25      4.91     1.20
> > -25.11     2.3.14        1.3.43      1.3.55       1.3.25      4.9      1.11
> > +=====  =============  ===========  =========  ============  =======  ============
> > +DPDK   Kernel Driver  Default DDP  COMMS DDP  Wireless DDP  E810 FW  E830&E835 FW
> 
> I think it might be better to write as "E830/E835" rather than using an
> "&". It seems a bit easier to read.
> 
> > +=====  =============  ===========  =========  ============  =======  ============
> > +26.07     2.6.6         1.3.59      1.3.63       1.3.28      5.0        2.10
> > +26.03     2.4.5         1.3.53      1.3.61       1.3.25      4.91       1.20
> > +25.11     2.3.14        1.3.43      1.3.55       1.3.25      4.9        1.11
> 
> I don't think it's worth adding an extra space to these numbers, increasing
> the diff unnecessarily. It's only really the headers which change.
> 
> >  24.11     1.15.4        1.3.36      1.3.46       1.3.14      4.6
> >  23.11     1.13.7        1.3.36      1.3.46       1.3.14      4.4
> >  22.11     1.10.1        1.3.30      1.3.37       1.3.10      4.1
> > -=====  =============  ===========  =========  ============  =======  =======
> > +=====  =============  ===========  =========  ============  =======  ============
> >  
> >  
> >  Dynamic Device Personalization (DDP) package loading
> > -- 

Applied to dpdk-next-net-intel, with suggested minor changes.

Thanks,
/Bruce
