Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA1CC88E45
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 15:21:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95FD442D7D;
	Fri, 11 Sep 2026 17:21:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id B19B342D35
 for <dev@dpdk.org>; Fri, 11 Sep 2026 17:21:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789140090; x=1820676090;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=PKG47gu5ZJ9FtG4BubCJjJspzEyGVKeVdwXaze9v2fQ=;
 b=GG/+ttNMxLghht9bNg+6vhpxTDbOwNWzjXsxHAcSNHIm2aX80Vu1wYcA
 ZEZIoU5oj0awgtDow7rD1fnpbgwAKhfkxE4Bxeatme2JK95GRMNJlpXM/
 KVUEGZ6EslMt8RGjBfxKtFXm4Ww71tz8CP6V7XwSmRs5pNisyBAQH3BSV
 ysxi6u6yn1PquM7padH/OrzfboO6u/NlkVU3CbECsS5UOUJROcAEbzTPE
 rDuEsIKAh5xR2o9F9lvr4JUmdhED7lS7vgBzdhhJDsSoy76I6G9+YD835
 0VGhOw1UjYg3vAgH2X0NXBRA/Y/0zTU8zJky/om6jxvJomD7Cva0TGT2p A==;
X-CSE-ConnectionGUID: vuCIU22GQfa/tmO/71oB6Q==
X-CSE-MsgGUID: ZST3RmPVRROaGg2YXEfwtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89734905"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="89734905"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 08:21:28 -0700
X-CSE-ConnectionGUID: /ILB6iZ5QeSnOUxorjZ8vw==
X-CSE-MsgGUID: mhK6LvW7RTq0tk8TY44Grw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="295434313"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 08:21:25 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 08:21:24 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 08:21:24 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 08:21:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGMoBnHQwA2M5iX4/t1pHepGeUfsKRmjGPbOY12LmXwE2keUxT9ivrieSer47X7YehOr/nrLi6mUn2Fu2f5ElneWjTYO/xl7hErN9H4RHUq2YbnXyQRwbnb/6sDt+7QVlDlMgW3Ao59b+cejKmx2yj6wlSYwyyYsML0XKJirYYHa/oWtkC9dw8BmXvnCd6vGJKX2WYqvgZ1V8wO0RK+EdvIdIqodFXczy/LKtqCDxPO9D6gxd1lHVTo4tZiF/vNlgA8FIK3o+xULe2p+e2ULKFRHK5TtIMaAbzHaKWjK1odUTU1xQHWPofvLj3KNB4XLDitQVCuLQe/IR+xC73UvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3eHBv8cIqgQwWKwfIuvjA5+LqPTHZE6giemfD7dQkg=;
 b=oPBbv8bffewW52S+8lCvx9BfMrP9fcV5kH9GiKCOHqWwMpbvgviyZCMR3QGo/+el7lri2M0Z5NwZpePbBYFyRaQWDAkjbshewFZvK7vMBjvlJvYKJAFhwRFIrMUivTIMlLbTIcvgx21C0pkE9Ug1UahLGMoQFVoYVjPQX7aLxz/GI91E6LVNmwqICX1Nv16PX6yMDTt66te1IuodAgJBhin0oBhM1E3dWi8orfNVfTNnQqcw62cini0BzBF2UsvWpXWPXs6OH5dVozz3oS/G5el0ANPP7SoCiObuvmskd4bZXCuIasvkm3e6my6sfHxnGZRx+Vxr4kdInptK5HMSVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DSM1PFC06F5FBDE.namprd11.prod.outlook.com (2603:10b6:f:fc02::14d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 15:21:18 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 15:21:17 +0000
Date: Fri, 11 Sep 2026 16:21:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Zhang Tengfei <zhtfdev@gmail.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2] net/ixgbe: add fdir_buffer_size devarg
Message-ID: <aqQcaApthiWR-T_W@bricha3-mobl1.ger.corp.intel.com>
References: <20260908155858.126042-1-zhtfdev@gmail.com>
 <20260910155812.127658-1-zhtfdev@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260910155812.127658-1-zhtfdev@gmail.com>
X-ClientProxiedBy: DUZPR01CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::17) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DSM1PFC06F5FBDE:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd22d3a-e796-4042-bd87-08df10185342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YURFqiepg0Oc2pB0FzOtw8Q1llC+M9a2m66oGr1bNzUOeKw4wTAeX7HUUwilSC3ZEuPfCjf41tZmk0iC2iabfpevcoU6s9KiEvUVYSOAplfYEjfMUAO/0JVMV3PGqkgO3sumYhmV0GCilpd+kxYxxQB9HXzWXGdLT1v/+ZL+9CyJbVRwIiv3ylfzuzC0b2KJX0qk/rLijaCr5vsuW/9mXkzNcQOlSOsb1Vt3fHCpFCjhoP61R5IU66OlPgBEcyoYml+fIU78R8CLM/3xMWef8bhUre+VfMQ7NObdp3ItLNn4sIIFBflnZQKPqkFzb7YrzaJujqfRoHHHVohxVR33WnjEeoIGyHSUGVrQHuMhWetBUXtiRAYhS1v2M+z5aAbTCXtNW5rqXJMLo24SsYYIDKzshiY7K7epLp8oqTIyddzTYBnAI/vKzemur8iMJiISj0ODzAxoFKYo4dGgRc5MeUfYmj+/fpG72vbRCRPaA2wDaInk5DHWHytRiFZgpgZZR40vxwu/wO33RWVIY9iTySKI42gNihKxsqxkO5lbEpBflDGx5mN4F0jZ2maRHf/FWFOoJjMlG7GIvTvWzE9e/LiS6B245ZkA5Cr+DBw0oUyeo+06Xfw9Ay+hi3KurckrksJsgbncQaAgkeYMvVhb9glhpjudAYCiQ1HrunXsj0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3QUQHTY/IEVRtPWDdaIrYqu1YgXtghLHZEWBC3fhAOQpOmvBfyvMByhuz4+s?=
 =?us-ascii?Q?gB5zKRNqZrIha2K4XjujQgz4VIAJhlwhH9NTnotqmNKC9lCvJOvAnDVA8iV1?=
 =?us-ascii?Q?/7sKAM35eY4GKmignsAS0JDCySKf7/JpAtChFD62AdUIxSL+HSNUtcs1vEhy?=
 =?us-ascii?Q?czbSd149cxfwWJ19yemFb0hTNz7v7nBn/ssFLIbTZNy+ktGu4fEycZOJOmk/?=
 =?us-ascii?Q?dl9IFYIwM1i8YU7JGGuH1Yc+J0jVRONQubZMlZKg865P+T7V2P4+wSpM77xo?=
 =?us-ascii?Q?X4CmQEZqKozEqeXeUl2nhjTt+XN8R87IA6L/6QYk/JkYK8ZXd6X/v0jAbbxC?=
 =?us-ascii?Q?Xpe83eZmMRfXgfV+4XYV8Kti7+wVxUNaSMVgaD8+QQHEa1fzgi0vaqTEiBye?=
 =?us-ascii?Q?rEVsts5ruQCPZYvKtK/F8FHwVlHCnYV/ycaB/eaNcHMKX4m4z7uN54thMAMI?=
 =?us-ascii?Q?vUGaodXhI0j1/cf1mqL8npAYZ3Zg55Tusw6pZ74XUr/+asiI8fRAsfyxtGZ8?=
 =?us-ascii?Q?SH7Oh6hRN4YEMKKZTPpy6gMrFqmDIDDHBiiw5a2sFWr9VdvMV5oBq3Q91MDE?=
 =?us-ascii?Q?LAbjJIvF1OjICvn8RdB9wE1RrAgwUGg6Io+TFthMyd8nzPEtGbcairOw0j5v?=
 =?us-ascii?Q?HaBE5rVan0q1bGCvzXfRCm6ypqtbkNeySN7c/OO88TUz0t3ti9Agyf6B2Rsn?=
 =?us-ascii?Q?ubGU8DDEU6+y5j2pufuGkswoJIH7FzSXFj9seACX/X5ZbQVuBUwvA0cc9GLy?=
 =?us-ascii?Q?vrtC1YfkgXWBO4a9y+kJNo4si99nhYETkyhuUHe4iN2IFEEqNJUtKKP9wCB4?=
 =?us-ascii?Q?A/giEa4dSD0H2YUWy89NQyPWXXWuhcTkYR5nhcE9VR81jQiWTZLmNAjTYfLA?=
 =?us-ascii?Q?8JaYr2JeDGKbokfTZhos9fj+kWZZVsVLSebImj2R0m+zVRBjKLVTNFng/DMt?=
 =?us-ascii?Q?bTPWE9pt79fuSVxBYntkZS8kN5jPMgKapXl6n6CtqWGCR+hvIkhy/8EuKJb9?=
 =?us-ascii?Q?j9O+2IkKJ7BnIYJcF7UCg50/2xz/2vf6MPbA/4Ws2cOVhYT6iIenDGCvUpZS?=
 =?us-ascii?Q?JaGPE50bWsFHQBkKG6gFp8FmM7MF4r/ddOchTAWMsMMejdTUcFOZZAnRNbXc?=
 =?us-ascii?Q?eYu9jqDQPdWw2T2a8yjeGtmf4eFSJ8fH0ybb8kvI//B51b08y+UX3qJpb5JJ?=
 =?us-ascii?Q?gHB6K9yVCFnJvXS6ZV++x6jVoagJIEiJ8QdCpvBP7Z9+DIphRsyPtDR9sxl5?=
 =?us-ascii?Q?CQoH6UmNvfET5mRE/qs7VoYyqerTvTgr6s1NMtkBhUZ2C79X2sPTd/1Gua2C?=
 =?us-ascii?Q?SnrRUF0B9cYnfdJAKOrs+VvicinLPOC1KN/Qw1urkO1sZiqJ8x2Wbq2bTJn4?=
 =?us-ascii?Q?d4pGzj4UQ6K1eZYWf1NJegV2Z8hFE6OnG9pWYys+4P9upgMVkDWfs/WtV2Nk?=
 =?us-ascii?Q?rEeLRsJsZVw8V96RqfEScmrj+8umEum6cMuGy2scB0TuuHVxr7avpTDprzh3?=
 =?us-ascii?Q?kgmSR+y1Pzi1eD6eVTUU3bd5tGgqGiZh14pQNAIP3bd+svknZPBx8zcENLIC?=
 =?us-ascii?Q?M6lQ4i91XXXQ4pgclSzUS7BRBpCwhR1CCi7ehryZKmHeyl4QIExGZz+E3wsq?=
 =?us-ascii?Q?grkJDBwGkFWUt6HEJj+zhKyJb+mJZ7CrTAR/gIN4sXcsbXB141z9nJNpxhWD?=
 =?us-ascii?Q?pbgEuVsutst6kpML4nglPomXKlpYwpeaSmlBadm83PBXtKjISNjhY0PkIvFl?=
 =?us-ascii?Q?8TIh7yPxKz4Sc1eLeu7+B2TFaf04BS8=3D?=
X-Exchange-RoutingPolicyChecked: aJzFhe+haJKl/YScs4BL9Z5GxRTkOq9F8H4eeuAE6sbj0WRy33zpuDrynbC4gDsXonDg39nW2vILqXcMmOgYkq48tVhquCI6wJin56MFnfvDE0nmuppiV+HPtHfYmyE6mIR/JZ+FfqNnNAWZoDLH4I78I6xk/yW9AkpX4nQrjftIZVRDvKthbeL3R8/Wy1VnikhlFKIscS9YSll7rlb59nQUPHGnEbDT2Ofltzfw3OeZTrEJII/G8OsbjZnMpvNpp+AXgAHYyYhCS7Ub9TeyIJV5ix9nuSkYc8VI6IP6claKZThMK1vJz+BMjsZdeZM08K9VMf+5pa53SNV0M5bgJQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd22d3a-e796-4042-bd87-08df10185342
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:21:17.5629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJkapIrJez8Qey3wOXj/SCp8byJwHfb25+SjCzsegKDHTWzZFGTXEJRHIAXac2Nwkcr1B6wO7malFgGjF+6sqOIjQdVpWlTTfUqH0jvDJ3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PFC06F5FBDE
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

On Thu, Sep 10, 2026 at 11:58:12PM +0800, Zhang Tengfei wrote:
> After public fdir_conf was removed from rte_eth_conf, the private
> pballoc field stays at the 64K default. Add a probe-time devarg so
> applications can select 128K or 256K Flow Director table size.
> 
> Reject Flow Director with DCB in ixgbe_fdir_configure(), since FDIR
> steals Rx packet buffer space that DCB also uses.
> 
> Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
> ---
> v2:
> * rename fdir_pballoc to fdir_buffer_size
> * reject Flow Director when DCB is enabled in ixgbe_fdir_configure()
> * document the DCB limitation as an RST note
> * keep the original indent of ixgbe_parse_devargs
> 
>  doc/guides/nics/ixgbe.rst              | 26 ++++++++++++
>  doc/guides/rel_notes/release_26_11.rst |  5 +++
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c | 55 ++++++++++++++++++++++----
>  drivers/net/intel/ixgbe/ixgbe_ethdev.h |  2 +-
>  drivers/net/intel/ixgbe/ixgbe_fdir.c   | 13 +++++-
>  drivers/net/intel/ixgbe/ixgbe_flow.c   |  7 +++-
>  6 files changed, 98 insertions(+), 10 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

