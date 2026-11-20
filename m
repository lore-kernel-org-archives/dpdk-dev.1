Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3061360A2604
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oHQSfKWm;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=aulWizQt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0D8B40263;
	Fri, 20 Nov 2026 11:53:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTPS id 9977540151
 for <dev@dpdk.org>; Fri, 20 Nov 2026 11:53:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795172039; x=1826708039;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=n0LqTq1zK+fI1lC2r7N1z0J/IGfp40TTPyfVFmQH1pw=;
 b=oHQSfKWm9zwanQomD3JtZPl8nSY4Sc2cnqk+6PoSvkimpWuHW3qdYDxQ
 qoFKtTiNPlMQkcNChgyjLF1L3Uadr+yjXNFCZCBulaHGbt1AlRDKZJROT
 J5JgmSUemcaDsuYLONmGXZbsXBVTCdFjkdiFYKJ15IGK1yo3px9JJ94XC
 RNjuKQEEDC61vAjIqjbJEDUCvVRo1jeTxh/CKs0ZghK+zyVhx8JOqjts6
 zPKm3njN/lpm/NVVmR6N3oY9aKrcFAApFiNv0CpRZxXVwuQZUNsZ3D6UY
 0Mz1A2EKiECxOebnb2cvjRuLAqYNtqG7qqLsgrMRNNILbb8IG38xgWmyP Q==;
X-CSE-ConnectionGUID: GNE6QaanTdm0mJL/omSImQ==
X-CSE-MsgGUID: 7En+Y7ysQySWpubWslGPsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4092399"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4092399"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 02:53:58 -0800
X-CSE-ConnectionGUID: zIbMkkYVT6CHoOm1p4lELA==
X-CSE-MsgGUID: ciTlBJSIQCu59IC7WPBjBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10663987"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 02:53:57 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 02:53:56 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 02:53:56 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 02:53:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqoPBaFfWSnJHiKjIcOeULXEOh0sHql0uCreRgUGYI6sSrzzIWFzdgzR2hXCELO0pbvE0ximsYhVLBzNyjmteQ2fBTP40ZR4cQniYKQcF3pII3oS7zyYPMZvLGYhf1/2VHWkZNegkrCOcNI1DOHv6ujYdMEusWozhk983WqJswuPa1gfEIxpxNf36nKi1Vn7guHTAhkshTkHNsHqFyse5cKsRIj/ixJcV6NvUYEy8xiV9x3RwMBiCm52iUI3JjPs6y/NP+ZHQLOzEk+6QWlj1DIZcF7gT2DonVSJT4DCzM49obFa2gFwnBYiY1uhiJAcoCXz8ZYRVX01NhwLVqMMnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzUkeFanBTZC/m+QPkxogIoWh59I6GBFZO57SRrWdOs=;
 b=PQEqZUubLG2qo/qa5dl34LjHzv0UG6XPQeaVYFEEQqzpYrAh2qT6qLWxga04b1e9I/ECrbuWNEAvQh9g4bOolzMpnl/9Q1VwRKxmqXWCfzNJjUw17EyTF5n0JWCQbfISEwty9gb3G9vdBiY/Q2kmwp9Y9qQbcXmU+kJ0WITIIbCl2zzbYkOhgpMREJsHFgzVXeIvVOE6MHUpbnvFmAN7peDXejmOX+DTCOIPjv4j8jCpeZG1cVCAgdPOYBuAYUd8MZio0XkkWzEUDxcJXVeCff91MAnstSbd9oHxM6SwjpTCrXEUULoGxVDdMn0YVIBlJEGR472rNvPkxs3Lbao35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzUkeFanBTZC/m+QPkxogIoWh59I6GBFZO57SRrWdOs=;
 b=aulWizQtUlkWVYt2YD+UP3ZAoESP3mZ2mMGXUmuUJ/ixVkbcETXMnw6zTwSQSBM7oLHHj4Ce3RQNLuJUhKF+uWOcmj3GM3vBL0zJTbeQQv11io6Hlse++rZ+2hHjyGDj/EWbc+NpyGPTVRK1iHm/I9yX6MxBKEFdqdzE8gfyJPM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH8PR11MB8039.namprd11.prod.outlook.com (2603:10b6:510:25f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Fri, 20 Nov
 2026 10:53:54 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 10:53:54 +0000
Date: Fri, 20 Nov 2026 10:53:48 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Hore, Soumyadeep"
 <soumyadeep.hore@intel.com>, "Burakov, Anatoly" <anatoly.burakov@intel.com>,
 "Penigalapati, Sandeep" <sandeep.penigalapati@intel.com>
Subject: Re: [PATCH] net/ice: disable Rx timestamp offload on vector paths
Message-ID: <awAmvPRzZEpZkUdi@bricha3-mobl1.ger.corp.intel.com>
References: <20261118160720.2763248-1-bruce.richardson@intel.com>
 <IA4PR11MB9278D85532ED471D00F094F78E792@IA4PR11MB9278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA4PR11MB9278D85532ED471D00F094F78E792@IA4PR11MB9278.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU7P250CA0014.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::8) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH8PR11MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 63257e42-d59d-4da2-2f53-08df46f49191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|4143699003|11063799006|56012099006|261021121427099003|261026140227099003|261022105027099003|261028144727099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SJDPhI48+T94SVF/TbY017pnfC3Rsiv+uwCynijw+KD2Ptf/sk4x47ZzlZVQQ/nTF+EG0j6SfzqDi1jeXfDfM7ZEUbRxiTX0S/b8MyyNRwjJDuoaiQGgTHge41O0FieDOpVtpZMtrrDns1+uBUVJJO//e3OxJE9C1JYhXNptY34oPAmYYTi9EROVYdoOCLsNDDI44/TEtiYSABw1twa1CmQBnPD32Td1QSb5j0xvwqfbxY/LJKRG9I6vRApAt9swxdz+cOxOiqiScalP9N129tgYz/tnevx5wMoB7Klvqub7ReOmLG9Qoiee+lzj2CfPX+QKThgd66+448kFxqCFJQPPieSDDFUfMsGTmJtzI9781Ea35Hz/kLL0vMRp2bWuN0A99XQWpEzeeeNcgwttdU88FY6G3ciD2YmBZejOmPyOn5tyRTJVo6FD2W1qcFuq6J+fauo8nYaIVYz/w0CAjuKf32r8n6FdgFkzGrzFBTqZki7VXgaH+GJk017YuVahw/2Pxknzu7bxGyVVRFZRcnWwWc//4cAvRdowfLUhT5149SicL62odksa2rSSbo3C3bTT0GLVRbmyhhOrd4GV/Bjo/Q4OXFBZAGKXOrWFMAIHdbGQgaE+TcAdqV4Q0In5ksvntvBL6ZuoekEfkt6L4wnZFZlgd8+tp7F5Krg4nQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261026140227099003)(261022105027099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2lQpBkfvzAmujZU8Mrj38Yt2YS/AVTYp5ktsPLXp4ENY66tmOQeZcGuM5caY?=
 =?us-ascii?Q?1vc1dEpVU00jRtSut7HojZ4Torwk6aUhyMY1SlGCbt9P2Yxtr3Up/t+Pbs1/?=
 =?us-ascii?Q?4hVTOQ9LzANyB3XH7rGWpMmhtnOkoFCADHLCD3lLKWkJn9E9UqzoFZRWQZsd?=
 =?us-ascii?Q?RYiHlK3P5UiHAmYNY/Hyxvvh8wTN5CZpbkbWRaak/eBsqJFbBkaA0rQ2SRd3?=
 =?us-ascii?Q?6S95V0tfBS8aTyoSv2Y10tnFUEHK8k1ioCx58Mv8rRzs5ka0+G+mFrpTvOhS?=
 =?us-ascii?Q?Ff+AQ4aBkZwBNN5uGdR2M8IM9TSLakEY237D4VaiyQvQMJoywheN36b5cmb+?=
 =?us-ascii?Q?0cYkfTcSx7xgXzA1yytbngePnpHseNABuaZz/CDd78EvIErTMoE0hWgMIHRT?=
 =?us-ascii?Q?jHdlnbJcVPwtaOfzCjRQfBK05P4MfHpgyLyve++Ay12VWbO87Nxdfb4PIfaZ?=
 =?us-ascii?Q?t3m+YhryTRjfpVBxUQ4RyqxW16V5SV5dk53PQkIoXuIQtoxmjYq7Pi0OGGUx?=
 =?us-ascii?Q?7ojDqvdlNeK6TH5I/V6NEyLOcbPzGmjxicWsODxo5Sno+pmcziyLZEQ7LjQR?=
 =?us-ascii?Q?sA9jdh/aGPp1aeSSxsRIvq/V9NDKlgd/6N3X9o5iwFjg7O9ORp7+8x69EwOD?=
 =?us-ascii?Q?i0PyKtUIOrI7dzs1ZZZ3+z6JsP9NB9ywc6AmfMFngyOMZ4wprezWd/dLMDRp?=
 =?us-ascii?Q?yisM3PLWIQrof8xotyDAmSlq5k8OyS5o4NMdmZFmqka3aSpfRoJAIkkUpB9I?=
 =?us-ascii?Q?/ZsQyheWuHSIPfb2XwEb9eWT7fNDPYwdn8kE8Nqmz1mhjPF55+PB03IxJ2SY?=
 =?us-ascii?Q?Z7mJiRn3BYji4qvLLnZgdeol4pdCX+Ase+DQE7Hi42AFzpcQWIB0PWx/gDnm?=
 =?us-ascii?Q?Y/hjtNRVnD5pfFumhwI5mGxo2nsy6yHiR38sJ2pXVOWr+Wvlks6SqqDcDKqE?=
 =?us-ascii?Q?H2Ab3pLEAYA0l6c9D+XiFT2eBmlbFLV1FbJx4v0yz0NKhakFlOOEUZpb/TvA?=
 =?us-ascii?Q?WQ1DW0koWgKnG6eddkQ5G5tZ2nnIFjwR1ocajt6eP3PD6oZCdEnKzkAfMXoP?=
 =?us-ascii?Q?Czz1sWq6Z0kqR1r9xMfumksrj/S00RmPdNr6ZoVYDfor5uOd/8gi7F75Eln0?=
 =?us-ascii?Q?m9f6x+yELrGMCa2MR2aMnnzjNxNkMqsSylAFpiUvy6+5Vg+8F2mhccKq+XtD?=
 =?us-ascii?Q?0IvEgKuH17I4qibaT1XpkLH9IYA6M7aFbh4sazgHZDbjCzbX0r8i0B4e/Q6Q?=
 =?us-ascii?Q?aav4HjYAe0gtVBv01OEEhS4d60Fw0rOwAWFM7cUzdnEWzTtU1gw6V/2Jf2BG?=
 =?us-ascii?Q?mMVmo643kJaDR6LoSCoXtp2DcP2hUjARaghQycNgnx8tlVhkEfQ6VnIuAoeq?=
 =?us-ascii?Q?/+2VN64C7yFSKscJSU4qP0O8FsRWxjCwJkw40IVEfvXSGOXlbujwmBw4mxns?=
 =?us-ascii?Q?MLZjvl9EE/5GqM6UEmyAUdGQFcKa5DVWFfEZwa+nF4Akbx/2JudX/pMfRJCu?=
 =?us-ascii?Q?RyTRiKGA4oXD0pfvjwcASTrCWf66TOcZvZORYJuEtLAB1Nk6SgjnZoaNu4wc?=
 =?us-ascii?Q?ldkbF0qW6eNuC0KGXd7nrt3UrPiDUi0xH80UQkYA4DzT1ZpXCxcwAjIEvJ70?=
 =?us-ascii?Q?5EGDPy0Br8zBGj6ktWcyvYeuTJz32yqkNVat7SjoE1xfMH+he3l6GFzKE9sb?=
 =?us-ascii?Q?efCjEG8toXQCP8njNdt9RJNLc+ZhNm8xFTLkZbYw9vgBbL3KiQq/rUrNl5tN?=
 =?us-ascii?Q?LPzvUi+ygsICLNYQJaGZi9oVqLeJrm0=3D?=
X-Exchange-RoutingPolicyChecked: LsvjN8G2B/8tyaxKUhvzva8tV9FSslv8C0ivytLCUU1dQV62TaT9JYl/1ehy2sghA2bkWNFpZFwXA+aTOXD1h/eWwaMUZZK52uVCL4yYdt0k6/xLvkJELXXmlajIxji0J2O24mm4cZEnh7mqUX1M4Q0bzrU9qNakV/OxkAnxiCT4N5qLwyVc2CsSQVlDDx3yjv+I0GkqAwRSlDDa6jmDlSApWjF5bglj2/eMw+dgOu0+yKuFjlEKGrDFqQC8URYyFrUjEvA+HNrwUSA9fqtZ2hFv0U6ttug8ZtMcgJyCXYOsW22vWBf5QHHyWOAAu6RZvl7yXU8LXaxG5B4tD2xY2w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 63257e42-d59d-4da2-2f53-08df46f49191
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 10:53:53.9610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXuffvNYZIOzx0aulXWCFSWO+FnbfdNi3lzDftIXiu/KJ0oWJKmL6t5iRwQYBp3c2q2UF3CdyBze6nuYgCW4tEL07m+DTn0Yw1CplPRC2a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8039
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 11:42:30AM +0000, Loftus, Ciara wrote:
> > Subject: [PATCH] net/ice: disable Rx timestamp offload on vector paths
> > 
> > Enabling IEEE1588 timesync on a running ice port requires the Rx
> > timestamp offload to be configured. Previously, having that offload
> > always made the driver use the scalar Rx path, which is the only path
> > that sets the PTP mbuf flags. Since Rx timestamp support was added to
> > the AVX2 and AVX-512 Rx paths, a vector path can now be selected with
> > the offload enabled. Timesync then gets enabled after port start, and
> > PTP packets are received without the IEEE1588 PTP and timestamp flags
> > set.
> > 
> > Remove the timestamp offload from the vector Rx path masks so that
> > requesting it selects a scalar Rx path again. Flag can be re-added once
> > PTP support has also been added in the vector paths.
> > 
> > Fixes: 332eb4ec8ff0 ("net/ice: support Rx timestamp offload on vector path")
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>

Applied to dpdk-next-net-intel.
/Bruce
