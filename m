Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F414B606A335
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=keJwqznX;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=TJT1CRW+
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6D3B4028E;
	Fri, 13 Nov 2026 17:55:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTPS id 63C7D4003C
 for <dev@dpdk.org>; Fri, 13 Nov 2026 17:55:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794588903; x=1826124903;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=t0qojujdqTrFnz+ayBUdxFQSbTpC2dtoQbP1v3hT2FI=;
 b=keJwqznX39GQ7kE/SwRH3DtwfFeAf5BXrTRWRCI2qtbVvBZQ0Z9bgkwI
 qLzzvXVIxoOYSSBXPur9t1xUhc5PwylSAOwEThNCRQ4MLRD1Q7qI7utik
 ZvM6E9DeB+X2bvBtpXlOoUNsqpgCq90jXt5RSSjqOpcEvvK2R24fPbNBo
 UtbWocPj2wyYiZoqolUEZiaANytYzBA8kA8duQa1Z+7NrHPK5IWlTx1I/
 pjdnrPJXeM7g9iWs0mCdoX8J21sQbf2XIyufuxg21UjsQIamk3tIWaJbN
 OZwWsidlgw7pmGaXlxxQ48fmn+S76VfAl6ZWTw98Q+exZbvzLlWy4pjAE Q==;
X-CSE-ConnectionGUID: fFMIOygORqG0mQ/9AMmKkw==
X-CSE-MsgGUID: Vy9fOgOBTzKt545kvFyaMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3404390"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3404390"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 08:55:01 -0800
X-CSE-ConnectionGUID: J64drpjaRdCYFVy3AoWNNA==
X-CSE-MsgGUID: 21FdrSiwR02pBtVwf7obuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9282172"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 08:55:00 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 08:55:00 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 08:55:00 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 08:54:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmO4YBq2SJ44B97H1S0I6JfRZaGVEDQC05HiT2fuQyCGk5J4hGHYuF9y+GxfiVsW1tAqjPXwYjSFjlV9SoL9pxgh9E9FuG8diRnl0aFOiZySOjghXMsNcPUoQLiPSh4sy5UrDYHFZYQSDptd4LZXCUXIGOci7hONvgSHtUIFCq0mooJ1DyOiZeoBrZ9/ik16Ei+QbL7WX4GxWsLsQ47luvzx9nlNLU31gFK9Hk3RpiaUGceHBZmckeM6U22ydYcdps4Ts91vEY9u2K3fvwSMgpeK2Xt075afQmkS++Va3T4GLMr3m7PMPk4PTv9XPHutIl3M/NIWgCuvE0CORmtdiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zFucdxmsD1T45pCJadoOeIAVo3e1jfgDz2vQYSFx/Y=;
 b=uA2Sc64KKLx7KX85esJZodvVusd1PkI8AGAf2A9Anszigqyt7h2ZrL1o+pWA5e1GAowTNx4bytEhmMRjcbsvT2fwVN7rX7QVcykCje7zfoEYmSm/sTePJjHS/8may6PDbhLvzvpG3Yg7Pt2qvrSofVF/fUnMLW6s2Wv5/p9OnPdTT8PJo3wEupQx09fvFFLTfN5FxYaLlWYXh9H9sa3c40ZdNf6RvOINovRSh17RnDZMXTl3BHOvqz9pjJtnnlLJcn+Scv+woCpfAkCGrA7wsDS6wkWlnSQnJPeML7bIhEWPfS+kNfmOroPCIr++Nq9zYcwEt2X07G5L7+zmHfHQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zFucdxmsD1T45pCJadoOeIAVo3e1jfgDz2vQYSFx/Y=;
 b=TJT1CRW+fIAZcPb2BnvqBtjWfvfTumezLT+WYQff6MesHjSd9eukBWLctBrYEpC5gaF4082ypqXlGvAIsU0e6AMom5qdCVPHcvML2kjFSVrSZIJbp2cixo5xRtQk0hyhvhmZQRef2jXT1O1+DxNf0hmgwDebQaZ49ErEeqdeKCY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MN2PR11MB4662.namprd11.prod.outlook.com (2603:10b6:208:263::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 16:54:05 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 16:54:05 +0000
Date: Fri, 13 Nov 2026 16:54:00 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>,
 <vladimir.medvedkin@intel.com>, <brian.johnson@intel.com>
Subject: Re: [PATCH 0/4] doc: fix Intel NIC driver guides
Message-ID: <avdAqHOr2SXmbY8s@bricha3-mobl1.ger.corp.intel.com>
References: <20261113205034.173313-1-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113205034.173313-1-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DUZPR01CA0304.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::6) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MN2PR11MB4662:EE_
X-MS-Office365-Filtering-Correlation-Id: fe8ff6a2-9468-4216-ec53-08df41a6ba4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261102123227099003|11063799006|261021121427099003|261021135927099003|261009223027099003|261022075727099003|261022105027099003|10067099003|261021123027099003|261026121527099003|56012099006|261026140227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Y5pRkWRmEEkCSJiDYym4FX9h9wpQAv1qhJBnD5NnpWxXP+0Zu8CtkPnX7J1rh4yAZXC14PXnHMCN9HRi20zR/BqUlrS3o84tgoUc0zwNPv2qh1GbEK2psjHym27QlBi5r5SGvZE3LjuodnOP2JHiZiUtwKjFiM2PM2PHMPhMdA/sz4snbOrKk4OuN0bs7r7FKVb1PztiNadoGWu9PDWiRQeT3DUtM6VV2Hml4UR1gVOz1/hZ3ANoX0RonpXEndDqEqi5sY3WvbshtTacwAIfcMkZ0ZMEAhAQHL5RFfDzALr9PEBu48DLZfGyBcLKGKB5mBOihdvWwvvAqNKhckoQ8KrzRVK5oJQaB/PWIxXTrFLpZKqL+fRCMOsGZ3Me7VjCpToLK+aXfc3SWKSpwXRkg0drAcjmatzJtH6Bytwj69u+mLdtMHuTNNtouy0cCu8wTMhLiFodk0iNUvj9p5yoNX2olwV3HHHo/AaNUgDXXTnYOg3ehrTJdZSOevAfSOUwLt5JE4hrb2MybcB46EhC7HM3jB45CSZlJmXHXQGRi8kf9Gavz8JJIJUZeOyaPoFzmw976Dy33XaWd0JwEDNoX4qQc1jRYGUTYWgi5Xbe7r9YbfTj2RI2RQNzQS+OpfKVkpA4T22tSPVKKBQedgDkgqx5EnnNnvEa+fZ5ODzwOqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261102123227099003)(11063799006)(261021121427099003)(261021135927099003)(261009223027099003)(261022075727099003)(261022105027099003)(10067099003)(261021123027099003)(261026121527099003)(56012099006)(261026140227099003)(261028144727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uc/hptMW6pAX8FdN2qY3tCUx8S/5fTQENKZqgFSd3DTrkmgY8AZQSDEKronY?=
 =?us-ascii?Q?8KePbVjNUYSGYoq+hu5LCMJSfRbzEPpAMF2mVaByYLzsUtU+3yia+93gb4E7?=
 =?us-ascii?Q?uGyZESaARSD11BgcRld3zcabXXWFzic6K0vwfQxVdtpKn+2LYYctEd83UaLU?=
 =?us-ascii?Q?GyT0ssG1b0ovT0tjnG6ZuiGMnb5hNKO5QkeohkelTF8389LHPR9RMM35Wveg?=
 =?us-ascii?Q?dSncuiVH6wLEPL2D4Yjq/B8rQMjVkWIxLCWORXvZiC6V2s+IesuQyeqSczyV?=
 =?us-ascii?Q?22mLseJw9fBo9PR+ZdfGO4FR3QusZt+O6V1yOKVR+oY6aDviGzoozYqPzgrz?=
 =?us-ascii?Q?byv/8G2z4jaD7DsHEjwZioY2BlLECj1lvF1unI7usBFelowdbr1QgHqRY3wB?=
 =?us-ascii?Q?EEYHemtA/yYZXW9tfew+bGeq8cWaNxRnSTPS+bGEl9hnC4Bclz91cMTpGfSN?=
 =?us-ascii?Q?gT8LAauJCjfUoG0T7LqPRyGWprZeocT3Z3TSdUPq6tO78fcmaYTLhjggFZMc?=
 =?us-ascii?Q?OYVgikc8HT/WVCJd/jcNv/INnsSOmGujQUE3o25ozO7GrNTASBOfLY8SLanz?=
 =?us-ascii?Q?mAHDHhfTna+h7v87lHJOmbFzdrIdIj9tW3KfNp8A+4hcfWpKdGlsDGjqrFCx?=
 =?us-ascii?Q?383JOLtZum+daKoE2wXpgg+Ap6JH8cOweerDOvHYqvC25WwAxUXc7QqU6EDf?=
 =?us-ascii?Q?DisTATlY4xp0igJFyjnQl5VTobzqTGyAKVSxDg4FmajGd8Xa70Sp7dz47frE?=
 =?us-ascii?Q?ew6ymKic777KZRzQ1BanhfD+l1Do5gFKz92I+YVOHQlztEA7vsm9kuB8ZDVb?=
 =?us-ascii?Q?AXB3TA7eNdjgmB6O5bsMkrXurIBdzfgmP8unlZNQpkvg4bQ9p6R5sTHI55P+?=
 =?us-ascii?Q?VQCt6JkIY3JpBNQOS3ac0fVHPCYVC9G05WQKGPQouOENSThREvm81eE1kzjB?=
 =?us-ascii?Q?/yxfg7APbXutlu07vBOR580yRCUBfvhjzqUBROz/ZxMC6trMpTmz9DXuVsOH?=
 =?us-ascii?Q?rUC+7nxxuYeLIw0VaL/8m5pZslEOSVmunCZPqyP34dFJ8pFnmqouLIIc2WNr?=
 =?us-ascii?Q?fgi8mCNVpOYvstCgGFU2CA4F25jDfwLx9PSnuvLuSXiYCGrZISLPFLxCmVaq?=
 =?us-ascii?Q?wNv93WBbZ9CwLRIlHgf5nKnUxLNnN9SndqJGRymQtpjkc292mtYG8tt5eIog?=
 =?us-ascii?Q?dh75LLNnGOXooy0FKLmFmaXfMEvijlsFuYTYFjyAsx4GPfGzwm+N3rswK1J5?=
 =?us-ascii?Q?gRKg7sMpz7d+5zZ5oS8M425QznExZRyZoTUIH1g8enW3D0CSHuh7GsqLFEtb?=
 =?us-ascii?Q?JP/nJiCy1WLRDHQlOGC6GRLlLpLL/Z/Ww0CeKNjfL9YUzIUxclCiwYQguJC5?=
 =?us-ascii?Q?uM/rQGExDpfPhJ5SX3vh4HIt/qQ4f/GjGKDCPVdiLM2fRRpV+iayJb7UE8qZ?=
 =?us-ascii?Q?Ef0fSImLyYBxcgqvfB900TnuylLMqX7Wb8Qw627uhzE3iAgby3OLv98S5BFK?=
 =?us-ascii?Q?JNLWp/HNU3SXC3lCAfoVtKiuaU+Nuzefz93CYjkDW9AhFzQInkaN4fqfWP4W?=
 =?us-ascii?Q?St3grWF5ABmYgufjVoto+COXiAd7uhyW3Fm4u4PmqZm3OBj2jJ6Flx6xkrjo?=
 =?us-ascii?Q?LuZGPkG6DnUb81Eu175Hmdy+pg5+wkuCBlQmsCvLlOhFe4r3gf30Tx6x/Ofg?=
 =?us-ascii?Q?+2z3pjXe+8pkUkVm1MOkHyasPAZoVWDeMR4kJQUBoN68xQvOKhkW/ocEG2wc?=
 =?us-ascii?Q?D3NB0XqHklWHApmhrWAWIka7943O+Zk=3D?=
X-Exchange-RoutingPolicyChecked: reIYavZexRy7cfnaDjWMPCaCdtkRmd/aeiVmFkUbypBmSOByLxQ7yY9YMPcDsaCRLF7EX30aDU/w6fBvD+hacqDweMvFvxOvTGpjwlzigPksyobElGJKZR2pdNh2fO6vNGaMm65R+3hgcrZI7TNksBSG3HQVqj0RNudriiH062IgR0yGod3Cbi2RpAFZpsMNxrDCEDQKqk13GrF6N6vARLhT+0XxiWCwDHrID5mEXhQ8NiB+yDToGcjSpABM/os8CAmXIcDVDf+NKiWaedtJEjCrBycpQ42gO6ugaNnuSHAHWmvIPstw3aXB31+Qu77wyabllQFMQi0pWXuBDbrF4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8ff6a2-9468-4216-ec53-08df41a6ba4a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:54:05.6868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAH3HdoG8wrBfl4lkMcIA3d9HVADTwgQz+0hjQonSdrc00OZiD+ZfYuy22lUlGHhoy2MkaeZ+w4/GtxShM709byB9bUy8VehZr83wK3ZTKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4662
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 08:50:30PM +0000, Sandeep Penigalapati wrote:
> This series corrects a number of documentation errors found while
> reviewing the Intel NIC driver guides: wrong feature and attribute
> names, stale macro names, broken or incomplete command examples, a
> missing "set bypass event" option, and assorted grammar and spacing
> issues.
> 
> Each patch is self-contained and touches only its own driver guide.
> 
> 
> Sandeep Penigalapati (4):
>   doc: fix ice guide
>   doc: fix i40e guide
>   doc: fix ixgbe guide
>   doc: fix intel VF guide
> 
>  doc/guides/nics/i40e.rst     | 16 ++++++++--------
>  doc/guides/nics/ice.rst      | 26 +++++++++++++++-----------
>  doc/guides/nics/intel_vf.rst | 16 ++++++++--------
>  doc/guides/nics/ixgbe.rst    | 24 +++++++++++++-----------
>  4 files changed, 44 insertions(+), 38 deletions(-)
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

However, I'm not sure about the fixes lines on each patch. Given that each
patch fixes multiple issues in each doc file, I suspect that most patches
should have multiple fixes lines on them. It's unlikely that a single
commmit introduced all errors.

/Bruce
