Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B05E10ED676
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 13:07:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61B5F42E1D;
	Fri, 27 Mar 2026 14:07:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 8BBB642D8C
 for <dev@dpdk.org>; Fri, 27 Mar 2026 14:07:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774616872; x=1806152872;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=52FtbalX5XdIA4NozWQPIasRyaAOkoT2XJRPWraCGW4=;
 b=Thlm87CkpOobZiSRBfgoXHoHZr55NzERmGXuSk6g3Kws5xHGO8LzW3ii
 8WY26lOHJ2q9b7LxufwPRhjM3lR1v+8k0YT9un7/uf8yILXOM8rLGSAll
 hym7xZRAqO5dVtpcL6OdJDTWbuetm5vsluhREGVFFYxbA2R4VRZU15mOC
 mrg54jOW2kbOTXwCv2Wkfq+45sE6vf7/nkEa6qrL3GMHbBATurceD2Rus
 6Mg5c5enf62Chjy2lIZE6MEaB+xDs5ag1o3G5+rf2uauEbAYQ36xo8pu/
 3/m/lK6F9dMxlbbazIKJtDzDlPMPIuk35MAq3BtR6HrwXL/xrhbGkdvA+ w==;
X-CSE-ConnectionGUID: g/vjQTQwTqG24IUdF/f1Hg==
X-CSE-MsgGUID: Er6CF/SKTnKOED0FVWpBFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75654790"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="75654790"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 06:07:51 -0700
X-CSE-ConnectionGUID: TlkJB1IlQl2i17jZ+d+FJA==
X-CSE-MsgGUID: jH5GeUGNTl+PN8FwAE9upQ==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 06:07:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 06:07:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 06:07:49 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 06:07:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7a1kvJ288PxwgYg8CxvQk20V87WyWYnClfMBOHJr5QgPX01K2AyihDn5y62vq5XVFDT2ues98jEqSk69pPMYf+b9DIgqwnuH2j3IOUyya96C6nY4VLhA+yIUGk0KVHbnhJujE2kkL9WRUghBqJbzi/97O9HKLfTt+42rV/Vg5gnxhZ32gYpOgquIXj2b473s1jnC5p2MTBFvGv/vNphZ0lzcy3z0LOgm9olYFShuj3d1e0/AIXyELBQxnoqqKjVlXo/kORsYNcXM37ofSS15VFoRDTA3K4yC6KpKYBtmsYqQV2n4hWA3We4qbII9VoNin9a9WSSUz01nUD0pkvMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaRltgi3iszPJGsTDIxH/BK+c2yYffdFzkpz3owIfhw=;
 b=jIpDGqG2Ct3eBij8JFWb8W63HSv1FIpqXlZnK4CMCzY3M1meNJkqFvNYola7lfogih3AJT3DC69K7orJD5L8f4a3bljKMjdXXenFB800YPi5X2piZyg8EEjs5hqhSHG1b80uHs7Mp14z8Gvw1cIEVNIX1mLp3C5d3M6aAR1vmjwD0ewotTmqui2qFvCibClroHRdgqaPg4fgF6UldkH8EffJ5JNK0S+ScdfblP3tgTJ3Oc+KJrm0bqTfnnkPMUeUYo5A4of5ZRDpYUX4Fooz5IDw2JggILWd1jmhjVpmU7zhVTWZOHNEbNWzs3Z9TXaXaY+q2k53k7uJ2opLR+HL3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BY1PR11MB8005.namprd11.prod.outlook.com (2603:10b6:a03:523::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 13:07:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 13:07:47 +0000
Date: Fri, 27 Mar 2026 13:07:42 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: hailinxx <hailinx.xu@intel.com>
CC: <dev@dpdk.org>, <john.mcnamara@intel.com>
Subject: Re: [PATCH v1 0/3] nics: update intel nic latest recommended
 matching list
Message-ID: <acaBHl8ozKryn7zE@bricha3-mobl1.ger.corp.intel.com>
References: <20260326005407.623302-1-hailinx.xu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260326005407.623302-1-hailinx.xu@intel.com>
X-ClientProxiedBy: DU2P250CA0010.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BY1PR11MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: a826c57d-65e4-4a36-518e-08de8c01d799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 2OMuYL8p0/bHFwj+WbDUvqQtgjzj+NiCcfyBP8Zf3Exrg2z3QUO03mEGlZgm1Q5YAP93PE1qa5ppC3dpWFF8s8/yH0BOTswiizXIOKF6rbVfKS8nh9Kq/nSEqthCjfSYhXOJ3DzviYMNVcNzMkJ6d6RtMGSXcs5upm1BmTD+Q3FGiSEv5xRzRkndouS1ZEJxCGOTnImU/0NGbMAyFmTiIR/eBA6YQ/O9zt/exOJrO9z4AC/ScpcvhelONGCbR8OXsdI7LOW0plq4XGnMX1FtH4WtfLfaUuS9rBCf0MjUmX7oGXgCy9xFyu5p7TA+yKfJEgljUJc8uFg19jciQNl/phDrz96VabsTFzxOTkNGXLXK3zuFmEhkGTlKrER5K3t27zJ9aoeN1+JWr8LPtGYtjp73FRD39ZXJ0R4DbA8jcwOke3d7nvs/KAD9gGH6YKQpBB49s5v2HVAdNac+Lqa2Bk23qPLKlK62CI+ZC808hpWX5UIl6lxYRViPTc3FIPCAEW12bF8ifSWGijcD/KTcPHJfT4s+SfakdMnzmY9x6Zdxz7Ch+kqJYsWF40fNwoLP5yd5EpTaJQQOf2lxOuenQTblgFOlP4FATEiVrEklwYb2PSUaoa3tycCHU2Q/BdhJ3cYSC+9jd+aNoqWjXPqbyue1lI+TmoaYxbGowRlhu5bcPl7iz31rLMmdwmNI56+fZzPen8NPOF9JeruAxZOalmMa8kksw8XQPn4T2AySYKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F9W6B5PS6oH2/9DbgbUA4FuxipslW+3DXNncfK4vweX7WKk+/zd4/rlGJXdN?=
 =?us-ascii?Q?j1IgF7QwZwaMNDC0I9wQqJIyacB3elyrS5PHuGJxVOXG+RI+U+epQrNAqKJK?=
 =?us-ascii?Q?MydNLZLy/8vc1hNkkeXMrc1D/0iV4ZptJDF6jpnWfKNeI4H6yBYeyCg0HV7+?=
 =?us-ascii?Q?6IjxEYK77RGOmgMVPblfk01SCxH2huC2DIh31V/Gp4C5RBclMEU399THnajb?=
 =?us-ascii?Q?9JElNwfTyqdjmenrG198vNfrLy3tZZvzTktSNn5aiD7J0oWox6m2tVG3sRIC?=
 =?us-ascii?Q?5KRnSSmOt/yrk+d07lr9BRa4NA+koeG2DD9BK8m90N5jXKdvL047fL7R9rh6?=
 =?us-ascii?Q?XCnMwe/iFL/95kQJU5OPH2+ZkR8qlSXBHQ+kFaINZew/UEEqvS1rmusVADuR?=
 =?us-ascii?Q?XvK+6RP9HkQViwYwbXp/TV+ka3joEypwkzt7ALWDPZDoXBhZLfivOOyjAN2K?=
 =?us-ascii?Q?nlswoatrmtcdnVv6o19yBz4D2Wcgq3wPOOBdYkcur9tca45lkJYtnYD4EJTS?=
 =?us-ascii?Q?8iBo6quuW97dmNVkHsD+L3yz/f9T0PgPCdSF9Y/cQVzL9yBnyeBSI7NFqltz?=
 =?us-ascii?Q?UHt17Otv2w8p+Mzh8jCiaReVpkVaixQFtZ/oevmvZLaXSqT91jPCYXSabNug?=
 =?us-ascii?Q?Liy/R/8C1vIpTQIpvwrME4fFqraSjd/fpblY42k4/zW9SBWrvdYP5PUFj9V7?=
 =?us-ascii?Q?l5x8ZXoyj8dEXGB2zP9TrM8O0YH1Srf21h5mpC9BLz6K9cVYF+4zBVnWzgQl?=
 =?us-ascii?Q?F4UP1pUsbT9+7dMfbyIDJ5Q8wk12O89YVEjLoGp/PSQFUIwrUxgmDCmDrIIb?=
 =?us-ascii?Q?C7SGSzhWrVXWnI/ldRXFjK3GNVb7LqnY4ObidaWxHHbsqC7VjzgBQy49eYE2?=
 =?us-ascii?Q?eVH41q83jfFrGwiUqjYzbToJJBrkZT8e3a74Ev055bfXXpueeV5LDcw8cZJS?=
 =?us-ascii?Q?PVxn1+QctNhadwTqo09bRzVsXQtTjQdKIVOeSnMQnVFUoS93hLn5/Cgb2KrW?=
 =?us-ascii?Q?2ERCs0CwK3jjxdQ5//dZ8DbURVZ4hSSYSx8OoN1QCoLPezhQZRMT/fAyBT7D?=
 =?us-ascii?Q?wauZYob6VkRsVC4aMrCTb9IekYKD/FfbVRki0jaf5NT/yXVlaAWLRxBOdYcb?=
 =?us-ascii?Q?eUqTB5Fp21Osub8gsp2N7D5A/RddvnfAf1ZiFaktI0eJTYVezNyQrLhYFF2s?=
 =?us-ascii?Q?TPDqTszStcrv+TIQKeepjTXPqVolZhGQX7JoBpFashGT8wGJLqjGfNtioJHB?=
 =?us-ascii?Q?24tT/DaHdXCL2UCeZBlNFSB2r9IbBpVpC9HKtpcrbz3fYGe8WwI6zb0Czg6Z?=
 =?us-ascii?Q?aMmMi7kdeAEQWK3bxUDeN1dpc+BfRFm05T9LtwPgbXXPmRNdzjfl4saGrBXb?=
 =?us-ascii?Q?8cCUO9Kc49p5UVeIMwwYBucLaA3MkyJTc+Od9V0OyrGfQ1ArS9RHosNaQIJF?=
 =?us-ascii?Q?9uhqOyPRdi+WdHq+B49GSQVyd8oJMlPM4UiUklJrI19RQOAfZ2xgb0+dsR2g?=
 =?us-ascii?Q?zd7N4xsF0x8AaVr5B358yga5tDCvM5+2dkZCIvXQCn3Z4gklydPSXUJPpnOh?=
 =?us-ascii?Q?fgunN7WTD2Qn4Muqw1m15ogVKYN2KAXHRWQ9nhuZ7Y2rAumMsUEsVJv19BsD?=
 =?us-ascii?Q?eTOKD7hEacj6TBwClOLE0m2kR8vTf1sSqraNmn63wcg9RDNofKHWT6aqP8KU?=
 =?us-ascii?Q?lwaVFYYZ6X3IkmeQaT/k3CaFJ+/6tAGSwYmDWLaA28eGqKQPmP2D8ErWHUFD?=
 =?us-ascii?Q?1iHyY6OiLxZ4jUBgojVFdRkB4IiGM+Q=3D?=
X-Exchange-RoutingPolicyChecked: csqHGYsLaYjCe6DsLB9mAcKwcDaNEmO9Cnh2jchA2vZgZchxvA7H7SsRL5+VoSfaJhX3ZY2Di3nx4jEg9oM8fIhqxmbxb2BZxgO1SXwkuxhZ68/ZUswM9wYnfeGKeIgxDvbAguI+SCLY7v5Jyp8X8TCMrzQt2Bdf7cXlltpXofqeK5VSKOtWyVIxvFimalaryKxChp3yD3A16CVGt0siKZLJ2oIoUfKh5/fq1b61JjZmpEg2Mbwgtg/ahiAEErvNx1bzhERsMWKDAibIOccLsqxSvXSjNqGtJza1cjiZQW50ss79xjZWaUWnUdj7DqiggE+sJx2Yy91RrR1xf/VyRw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a826c57d-65e4-4a36-518e-08de8c01d799
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 13:07:47.4682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTck6shncLQH7gxqtv3Ocw4q2/Z7xl8KuJX+FTSeIL6TroSkXgqN0BzZDVQbZMjD6rwMdiQQ1VItV37qKCUTZfH6EvLzrzTmOWxX4eIEIzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8005
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

On Thu, Mar 26, 2026 at 12:54:04AM +0000, hailinxx wrote:
> 1. Updated ice latest recommended matching list
> 2. Updated i40e latest recommended matching list
> 3. Add ixgbe(E610,X550) latest recommended matching list
> 
> *** SUBJECT HERE ***
> 
> Hailin Xu (3):
>   net/ice: updated ice latest recommended matching list
>   net/i40e: updated i40e latest recommended matching list
>   net/ixgbe: updated ixgbe latest recommended matching list
> 
>  doc/guides/nics/i40e.rst  | 52 +++++++++++++++++++++------------------
>  doc/guides/nics/ice.rst   |  4 +++
>  doc/guides/nics/ixgbe.rst | 28 +++++++++++++++++++++
>  3 files changed, 60 insertions(+), 24 deletions(-)
> 
Please review patchset [1] and see if you think it's worth taking and then
rebasing this set on top of that?

/Bruce

[1] https://patches.dpdk.org/project/dpdk/list/?series=37782
