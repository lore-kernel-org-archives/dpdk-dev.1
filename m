Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237D1C624D7
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 10:57:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 554AE427A4;
	Thu,  3 Sep 2026 12:57:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 180104028D
 for <dev@dpdk.org>; Thu,  3 Sep 2026 12:57:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788433071; x=1819969071;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=rnj1mVe4kYBdKSlwYzrHzB1BisyvlBNI6fqLVg7FSJc=;
 b=OXPBbKT0YW2XEC1p6bdwbZHUntRqegerlw4KWn/L90qpcMhUOhj6JTRl
 sK7b8PyElOzQTY+R/64pslhCMrxntT0QkHUJcqIsMUoAHKBxNQ1kf/no6
 QlAXlQVRwi1FAgRfNFP40hGC3vhxpLCaaGVQjeEydhRiq46S52NHhw6P7
 ZNqesGGDVbzqP13Vx57h93GopxxFV8KUGkigiUky/F+kihqsDqxe+zhGC
 nmig9izdjYGuQzJBoFNW/gSTYhambCr6mt2KD1IgSjcnMDfTnwuARfyGg
 ddK42Q54kIkh4qJY7BBuMei6CLgnszBN3VcdPvOc3V2xdu3q7WtPi57ja w==;
X-CSE-ConnectionGUID: sHWDLi90Rfaewqqn0vjtoQ==
X-CSE-MsgGUID: OJBDgDbDSTO3nCs+oncoUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88789705"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="88789705"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:57:50 -0700
X-CSE-ConnectionGUID: lQRmVxWBR7qLxY8xDdO3Vw==
X-CSE-MsgGUID: Hnmh94zpTOOSYaft+jii+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="274963186"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:57:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:57:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 03:57:49 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:57:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwriU9WPEGMTmipzsmMRkWA2rUXW6od+0sCHGWzd2eXQD6L5ius61cIhyusubuFTLM0ZhKfvQ3bTc5b/ZLsym006N+5AvQ/CVDqb7JiA3fD/uuW2JkEV1elhWSGq60mqEM5P7NnfGs8CXNj62eD1IqgvpZxU5K3jqOjNVphuQnkMO+4Gmbk0y9g0CvLdk8UTQRq6gpuBtwUiWziwou5p5H23Os1ySR34lw2VdgcdDFqet8pB83IVh/RKthizNELiwBXszAJGc3VHx0KQjGT612QEG5usdnDNXkhMV1rYBdF4zbdowe2heW8IjGeE/t3jfudMMAf/L9p9wr7WwcpVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLuc1FcqZFpX8LFXw6urJhUblpMg/FvoTBGll89tBAs=;
 b=kDUiTOnMfyb9daXCIXR+vKakRK/HHxudZcgJRmrakgHw1uVe6JyAhQcrai3ffHXpcWKwOd/Sd3R1fkPLcc/ncWrmA2/i6bN+YS3sTg9SY5GGBi+IidJYGYchi4kHnSaLbYe2iRuqwp+aOHCEkYDzu8KlGKs1GQAniuv3VOdTWiu2CpfEctfRdiyPRw3JtReGDKb8gDW1uXGmgGih20/SDsHri47yRkpaLjlQsU7OdEKSXnIM0pNNpvpErr6CfC3X0jnT03B3ri7U19vCyKzEYlZYdcZPe4FKumY+E7VcCnzvD2ASyu79ak0lZovS08yGC0JcGTnd7eQOl6rj9+13ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS0PR11MB7189.namprd11.prod.outlook.com (2603:10b6:8:137::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Thu, 3 Sep
 2026 10:57:41 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:57:41 +0000
Date: Thu, 3 Sep 2026 11:57:37 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 00/23] ethdev: refactor remaining uses of flow director
Message-ID: <aplSoSomjuQXTIc3@bricha3-mobl1.ger.corp.intel.com>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260806051004.166778-1-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0303.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::27) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS0PR11MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f38a758-081f-4c52-f0f3-08df09aa2ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|4143699003|11063799006|10067099003|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: 5cdqyxBohipsWc4RcdszgJH31VoDBgoFs/HYOSCjiJUcz7+FocWb1pwbP7FBBsPzd2LunjgzzEiUrZPV4AG1oXE2GXQN3n7A8ZIwFHfdEYQThOo2cO0oSDXq1BLZHT3Y1POlLDMOcpll4D/tu/bLKm3jLphnSXoNpduh3lU0L7CDpfHfnOf2eSH3cqxDMUteNjugiR3w7sgZWyjk3xZlaFC1s9h70uK7Oms4IgrK+Ly/LH1g5WltN2kjJSN+S0o26NjyTzH88hmmLQ0VMNlqAOs4tfdecmYnwGLOPD7H1cMMxVzr8l46xX4+hq6Co1SnG0t9qQym5RDsBw1urDZu0mUecANLtTvOUeSkj9TARf5OK8V5uZvQebH8oQl0vIYTppg2kAgeFSGy5h4cOKgswrnMcUvRWYN5vUfnhiA6ht6bcLeIrHtC0s+hUuXnteJUjaHe9FZBgm/G1gGva4/VsV9dA6At905CiihykOzogGWHBnLkjQCI8acTXfKVnfpyhSGnTXB/oBoATfbPXKh7q5nZxXWH58VZG4Mjlz5BgiyYok5f2Ql4iRo4DS04p02G3SjS4QRMwErqCRKt3NrbHTWkcf264paoB6SfkY+jAgR6csdnA1pswKRdIdKGjPM71M577JGnj/teJVd3RpOcSPuqttHdodgYbTnh10QjlQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JugUudVejpmXgyhEMi4x9mfOXrsVYijmtkPZeHEndTEbTyCA693MZGYS8eME?=
 =?us-ascii?Q?lq+Gk6La4iwJ6TPvYc5RtAWVjG4yaKO9rK5VF8tn3A8Fp4c5DtHP3XIX4S1/?=
 =?us-ascii?Q?a/I40ePBfon8vy7xPfEw6gYsL6MN0rMZL1f31Ztj8WY4nxXc4pEEasDu8/cO?=
 =?us-ascii?Q?KTmuv8x3ROYdsPCYUYMLrCyeMOij/kuT6I90Vw4x9jr48kmqGuGAevw6L4iM?=
 =?us-ascii?Q?+rg1oeglxEf59wWvh5kERg9KYC0RAB3nEYM146jQfjIIU9/oqyVKsi9g8L67?=
 =?us-ascii?Q?R9+0B9zxHFWuNYz6uGN5V2Q/V5+sPwir0Zklt6KmFRVjPZyxbWkABynch3NR?=
 =?us-ascii?Q?zoYxEzEuZEhQjynRIkWJLFza7UbV0r/2VrtA8t3c/7wCxxIrTgw4DDeNX6xh?=
 =?us-ascii?Q?P7W6l309M93XhxwZIe54zRtk+1EwzMxJFtKxC7RM6DBYc7C50olp6pziymxQ?=
 =?us-ascii?Q?eFi4LTrIAAjhfl+OJq3wfKL2FrdfWgYwxwnZw+whWvs2R4rHxK75T82gwXcm?=
 =?us-ascii?Q?XM5voqvHT1Cs7egE04XHGXgCrgKNxofj/fj7XdmTmJL1Mm02GjvGA/xR3jME?=
 =?us-ascii?Q?aer3xyePGltePMf0n0HjfBrX8jHYd9beRIVUBsMvkQZBl3OGUvBvEaORCfd2?=
 =?us-ascii?Q?M50PDVxoBy+r6HVi5UdibVMkhU+nzNehfa2vjHqy3FV0eEpOGP9AYFR/hUjq?=
 =?us-ascii?Q?u4947qZUxP+rl64aPAIpEtFY5K3MrBj/ihWh9p9KlInmjqqO24JpgnO8Feao?=
 =?us-ascii?Q?d/juNQA4sr/X9jCLSNI1LhkCnDMx5gamgT5kva3RJaKhEfYulYZNKX0ksepL?=
 =?us-ascii?Q?WN+GfMTyM8POuJJrfx8lOGHehsb9dECcPcvwWj+7YnF7NlMPoTNhrx929T/+?=
 =?us-ascii?Q?5p891NXPl60FupNl2IkbuIh14wNgON0wj3gAfXArwZIIPuxa6LTCam9rtuFw?=
 =?us-ascii?Q?Qj+1vHPWgxAXER5S+mGQTSc3eQvGJNsNbIWAgXxueaSljcCWFDcLMJ6CXi1M?=
 =?us-ascii?Q?TG2b+oPCPnHS1Q1/veXy15lqHgu+dR3nQlp2tv3vSg/I/W0pRa/J+HrThB3G?=
 =?us-ascii?Q?NIExsMcmKgzZwUewL02VGRLM7gFiqS7J2DX551RtjOrJugbqIo1qGF68f56w?=
 =?us-ascii?Q?t9s0LCEtStIORlkJaj5dIA48/bwAbbK5fdAVsoEJkVlJStmv8zbuKCw+Rrvr?=
 =?us-ascii?Q?X4VAKuSVUpBCeI4TIrH0FFrDllihHVKl77nI9LBUfsOpeKJRHARPj/kfke0w?=
 =?us-ascii?Q?2AwBO0Yvqqs9CRzLCi53zo2E208pEFGlgY7pR+4uolY5hDzEf7meSILBBaXU?=
 =?us-ascii?Q?XZQHclDIvEQkktisM4U66noDj5JBlX3Lns1PYkh/DSCAlN5TOcqv1tEmJifX?=
 =?us-ascii?Q?BYQGp2zwCMkCFFZiPCvN97R329Jw7evIJP8QcZAUNyT5+cO4djOyDeq9eMqZ?=
 =?us-ascii?Q?k4u90OgXdTX/CPkRFccSN96BnDfo1DiThlbohxoMO0SZrIXjM/VnkMPzur4o?=
 =?us-ascii?Q?3xVbTBFXbMr7sQa77q3k2CMDPtRGU8HDhqu952w/GnjjiFSBBqCBwFQx7Vsr?=
 =?us-ascii?Q?LB3vZ2eS8oAH4ex0GwQrgbAaVr8KX2PX+gGkibQMMhWbpLlESfNlBXWhN6A8?=
 =?us-ascii?Q?kg4tfyNwkQZP+M2KMu6SeT2vU2MYZht78hmCbUAHGvNKCFVxfoGkRAGeTecz?=
 =?us-ascii?Q?4gaI+w+0JWa93Q0muXyWrdcApcnVKzxt99mvZBsN4ScNFnj53aGbooTJ1KFZ?=
 =?us-ascii?Q?uo/RaS3EMQO0A6RbJt4v8NoIpbOGKYM=3D?=
X-Exchange-RoutingPolicyChecked: Z8bAmxHtK0RUHMK4m61Rc0bctPAjXvCay85hYZSQpU3rlIMBAiD8aKaMjrejchmLZgHWjvxxgMKkEGp6lBUiigzqbmBK0JlZwyOyMpxmk5Pq0YDWXzIZ56l1eWcj0tpqpZQ93roMXXEDteeNi2pI41OPIUpopz5h3xbOxZXa5gKsjJn2CN7lwBnXnowooe8P5tzn6HwdkuZ2SAVukHNsSYNLNWdlZRA/6/TzRwwu7lf1lam2M9upTOeXjgh5d5wIrTEcts96hdRpqBaIa2adQr+++yj42NOupDa4VLiuP1HswK6mkqZzP8c8uEZo4Vske7/8bCZ1amipXCNdNlbtcg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f38a758-081f-4c52-f0f3-08df09aa2ce4
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 10:57:41.4232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rgl2WuytlG4ouv6FrevB+41Uuenk657mQTMxezRilVnvOYykhH1fXJliVvD/LonXEbZk92drxyJey9O4Sn1/2qqIEUiayFXx4CBd8muifw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7189
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

On Wed, Aug 05, 2026 at 10:08:54PM -0700, Stephen Hemminger wrote:
> The original flow support in DPDK was Intel-specific and built around
> the flow director feature. It was superseded by the generic rte_flow
> API introduced in the 17.02 release. The direct API calls to flow
> director were removed in 20.11, but the data structures were never
> removed and drivers still use them. Some Intel drivers also carry
> driver-specific APIs related to flow director.
> 
> These vestiges mean applications can still see flow director data
> structures, since rte_ethdev.h pulls in rte_eth_ctrl.h. It also means
> several drivers and libraries have come to depend on network header
> definitions arriving indirectly.
> 
> Since drivers still need these definitions, rte_eth_ctrl.h is renamed
> to ethdev_fdir.h and the remaining bits in ethdev_driver.h are folded
> into it. This is a driver SDK header, not public API, and exists only
> so that drivers still carrying legacy flow director state have
> somewhere to get these definitions. New drivers should not use it.
> 
> Applications relying on the indirect includes will need to add explicit
> ones; this is a source level change only, with no ABI impact. The fdir
> option of the testpmd "show port" and "clear port" commands is also
> removed.
> 
> v4 - fix AI review comments
>    - fix build of enetfec
>    - cleanup more leftovers from flow director in testpmd
> 
> Stephen Hemminger (23):
>   drivers/net: remove unused include in dpaa and dpaa2
>   ethdev: use DPDK byte order conversion
>   net/ixgbe: remove experimental FDIR API
>   net/i40e: remove experimental FDIR API
>   app/testpmd: remove support for flow director
>   app/testpmd: move str_to_flowtype to i40e
>   app/test: include headers directly
>   gro: include headers directly
>   crypto/dpaa_sec: include UDP header
>   net/gve: include UDP, SCTP and TCP headers
>   net/nfp: break implicit dependency on rte_eth_ctrl.h
>   net/mana: include used network headers
>   node: get UDP header
>   net/rnp: include network headers
>   net/r8169: get network headers
>   net/ngbe: include network protocol headers
>   examples: include network headers
>   net/mlx5: include rte_flow as needed
>   net/sfc: include rte_flow
>   net/intel/common: include network headers
>   net/enetfec: add missing sys/types.h include
>   ethdev, drivers: isolate flow director
>   doc: add release note about rte_ethdev changes
> 
I think this patchset needs to be split up, as many patches have no
relevance to flow director that I can see. The various patches cleaning up
header includes should be in one patchset. The byte order conversion change
probably belongs as a standalone patch, and then the actual fdir changes go
as a final patchset.

/Bruce
