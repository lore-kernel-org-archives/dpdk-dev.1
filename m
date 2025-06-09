Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD50FC5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:38:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0E9740661;
	Mon,  9 Jun 2025 12:38:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 8FF3C40658
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749465530; x=1781001530;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=u7A1xPxs+V9jFkYVvixcMl1yjSLxL5+x1iKtH1D6GF8=;
 b=cA2fiXRuyeR2NrHy1EOg/vCXs4dJUqKfnuoJPhEJQZlfVgvOrkk+5Xhy
 fuHkhGyzrZ9BrDMg0wxNglUOP2XAaiL78sllgf7Fti6NsFOxp3YtuYAsI
 EEsweNFtuEoI0ffa3FYm0iJoUprks6WX6HoJJpOPzmBuJWhYMwWwlKM6f
 IrhSbetAwsQWufmyXSYx2mH2JtItx8ii1m8OcBaExGv94N8LOV4WNjLI1
 rPmUtnQE9s83I+wEZ51vvOT4G7uSQuAYqUGOWYPrK1boiTKDMYnJX/Dhw
 c8lT6K3V0Ea9AY9beK/LIvlmnt44ewgwN8k3+T6jMFZSPkjG9+Gw3Boz8 w==;
X-CSE-ConnectionGUID: nHq17GbaRyKnl4mGdcGRJg==
X-CSE-MsgGUID: Pnm+lObEQ5aaQCSowZd+Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="55340613"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="55340613"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:38:48 -0700
X-CSE-ConnectionGUID: hxMdXcMgRymHODxX5K8roA==
X-CSE-MsgGUID: dVQwIGGUTjybhbdYfd/YnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151716021"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:38:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 03:38:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 03:38:48 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.82)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 03:38:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMIIxgb60upAWLD0BNAW1L7sbgnnqaSY1cs5hSOgZohgFcR/IB7yOZ8Cqr39KGJjG+gVnL9EeK3/9w84fO+5jvjx0lNgYUAGGayC/8TR48sjWbi5EQ/P2G7FFnb1hHBzXj1SgK4T6I9KR0xVxJW19fO6R5sErB2dfS94mY1kcG9QewHkYwLh9Cfq9/pimMs9vouL+DICmj6VWCzJU9EcJ5lDvaQlgqv5pGUoMUdu0zsOKzGzbrTeooY+d8ujVCGdLOSBSSqrvvIl5v8wqTnjjL6hYd/Qj4yJgBtpemt7BuSqTTWD/8y/7Gk+/HxNLdO0XyVGyYZRUFQvZrzulV1kQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmB1AaGEa3ga4l6bxT8Nub1RSjYSym4L3GMOn8fRZE4=;
 b=N32mCamW0nfcf3G6yyeHNSuTuQvpVCVSNljxHa6wQQ2pm+NS38Lob8FUd8NGW0UVfp2taTyBVhmH68LFLLMIdklzbs2P2Mj9o0em8wSpddg7y/Qe3SSaDZfex/AiLjemMDmPsp7+sJg/S/x4woWed4npVbjvYB9iwMgMU6lrHBM/2sCyXx4DeAZTwrVRn+4LyL5mSSz8Q4PGyJsInypDo3+GEaosDPs5anyLLMcHW9cewD5p7WlaKsnmBI61ATiYPNmVoIu3wEwgYCUliYQaUzfZ6fMVlVeqcbrtJq6SWhIx0AOCK2y48bMqZ4mNVBelRyRGk0SXy2dt4pmaVGQ3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA0PR11MB4736.namprd11.prod.outlook.com (2603:10b6:806:9f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 10:38:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 10:38:45 +0000
Date: Mon, 9 Jun 2025 11:38:40 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v5 12/34] net/ixgbe: make context desc creation non-static
Message-ID: <aEa5sM_wH-A5HGG4@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
 <a83990ed1b856c34ed546d4ca77f9e8f8c202051.1749229650.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a83990ed1b856c34ed546d4ca77f9e8f8c202051.1749229650.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0079.eurprd04.prod.outlook.com
 (2603:10a6:10:232::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA0PR11MB4736:EE_
X-MS-Office365-Filtering-Correlation-Id: efacf324-518f-4baf-db2a-08dda741cf7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JKoe+E5ueMowH9n0adg55F0+iID8c4OyUvh02I8BYDJ7V2Vmn9RMTS8BHerX?=
 =?us-ascii?Q?7L5/jaQ4CJ90rF59+JAHsxr0uMAzNtypv0zvFRmH47JdgyWsXDCwZRdJiMLI?=
 =?us-ascii?Q?fFbMlfFsBIaXr+nXef50kIfnqVFidzsoqlRMuN6rmuXD2Qe+DYvlyVgBYUxc?=
 =?us-ascii?Q?RUDJ6TPJqPRR8Aqj78uKTDcMACDMwSN3EEbRUeIDIqnloP3xFupTRB1C7koX?=
 =?us-ascii?Q?3hVPEyF/q5nR6S4P/AhfHNgQlhPovBb1ByDzn7YCAKkSaJr+fP6BqcIsYqod?=
 =?us-ascii?Q?rrp33H1hx3ORKI/NhIAInXeokTY9vJhfMgea5AX8J65lGRBk5gaog6gOR7ki?=
 =?us-ascii?Q?5lw55qLTe19Xe+o+dERGMEKGrdc88cvb3ooTCmLGiUyg9CbtT7CyqojNkJnw?=
 =?us-ascii?Q?fHEtPOyqQ7R5xfGCpkkwN2GF7yuJ7B+Jw6kjl/Y3UczG3CUtYyU0fcz8/Tbg?=
 =?us-ascii?Q?+0EL+lcQaOqFCUYphN+koQAVIxy/hN4X0bszJf0qhov7bwQCP3AfbUuHM4Kf?=
 =?us-ascii?Q?80Y6OgzPP4qxRFZ86rijsdlGxnml5Res5yIkYVOff5yUFJ0m1B4cw5J4Af1b?=
 =?us-ascii?Q?ZtYg3Cz/CfFhjRw4ipHVCbN53MvEKenb/MT/4DqAWJJ1YIoTQbBQI3fXRX3j?=
 =?us-ascii?Q?7yGx4/ECqHiNetPq9PEuWQMNQPVMhjK5YrSiHaM4aht8u0MznWR5aHvcdunk?=
 =?us-ascii?Q?9OQbKAX6kJH/c5QWN67o+3+yZTIr7UYl31mrgw1DNzM82D3xUhkq5tQPUvfg?=
 =?us-ascii?Q?+hpVMvFGqCb/POoYHIi+dQJi7sGQCDkmlS9NXY/m2EdwsVkx6Js4HdE0kZr+?=
 =?us-ascii?Q?1GCe2rst/eiCo99oROjbpPE3eEWOzhqNIXARpl9aBLqKfuYSPx1Nk2N8sPaU?=
 =?us-ascii?Q?q7PnfM9pt9AbiT76kBC8MsQipowL9p95rlJSn+Hzbd3t5QH3IH5aSVUirE0S?=
 =?us-ascii?Q?Q0vLy6oKyAuWHVHaYfIBbLGktBDBAih9/tsHnb9FND2rH0Lb/37uE2/19Br1?=
 =?us-ascii?Q?D/6TJ/cl1ofdrHJv3PbAciVFlrl/L6hhgbeBq3+G74XqSnYBrCG65pql83zH?=
 =?us-ascii?Q?nVZJyaODtg2tWRVn65Z40JT4o1jB5DcBOncDXgfpxs09IGPhaHiesVhkhMDx?=
 =?us-ascii?Q?KRSatcyi7ksBrhDoO8aXLVLkLJJ5QN9VReBDKDSOMh8Y5zYcNn77r3jNZFF6?=
 =?us-ascii?Q?24SRwTienqzY4DHyxPWFNSvnWQDVj58eVOus7cquEbGOGHOcRFlXA26aJdQe?=
 =?us-ascii?Q?14DPRHb5w9sAvuYuHWdz+cb7r2+W+AHuLhD2KxCQrLD1sXgMmb/k9di3Ow68?=
 =?us-ascii?Q?hTZ5X7JC9D611KeRfw/pCc990xNWyrzQ2PEKOX/TkVwuIcRfXCb7ZwWF32S+?=
 =?us-ascii?Q?LRiBVO60FiC5RROR0bfYenkvxKzrP2e/DMBl5vIlsZaKdajqNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Fcg+TS51vWL4sEVLWhc/P3CA7ROCahB+eM9tZIqV3wADKZiUvWM3sIfC1tS?=
 =?us-ascii?Q?tPoxRyhm0Dh6HJN4WYZoRq7iKcftX3oDlbaTXpCQiQKAlif8nAYoHHh5Pw6n?=
 =?us-ascii?Q?79OA3+qguRVghUcJJVSg/OoUf46Rs2Mi/NjQ81gZiILOeXYCC0xgJCBpY3gO?=
 =?us-ascii?Q?gkQ6QExo3CYDGhvliNqxQw2zWBy43NxsqWkBowhM0FT2JvTH3v0Mpp6eYIEw?=
 =?us-ascii?Q?TCPJ4ZoG7iw3Gv2ocvdQE4N+8gYXO4g9Mq2r3KnjNgFKndLGlv7KxvDWuwRk?=
 =?us-ascii?Q?rr6jCQN00EZanhRpLwRbmZ99iK5ffQjZozOgzbGcJ8iD1ZaLzWF8k9dgNYke?=
 =?us-ascii?Q?tSmTdS3mErec6rLsE+ds7PkaLjgdlktyqSdcYEAzEivkkfLW0JhOYgO0YXTg?=
 =?us-ascii?Q?wxkZu+9us01ieQwA7PaFZTP64aC96ZsxgtEb1FA20BVMWSV+V/hQirEeZN9q?=
 =?us-ascii?Q?OlvWyZWUOka2k4kn5OteFtT/9zKfORCN9a9xkT1WJA8la77nK+BBz9ztEbR2?=
 =?us-ascii?Q?KRhhycXGOosDL9Jo4EusCCbzdsBE6nmbXmbwfY4h8e4Fp0ejxqRtI2icjph1?=
 =?us-ascii?Q?pJkCknBYT8PNcW2wOLyv2sQUuM4tf5nTGuanT2A/wb5UftVO0pbyOdDtNFne?=
 =?us-ascii?Q?q8UOIEdUhM1swHQTILRG5amYkgZOlLAxaTuLymH9wHTnETKy2DQlk9BdOZun?=
 =?us-ascii?Q?hppawmqW/LgAvfftasUyLqmeGPY8LAJCTK3LpAGguC6QxK3GyopJZOYZDzhq?=
 =?us-ascii?Q?7qkTsmyCNuq9XqDAewpX7MT66y67o0Zq3FbELFdLwsnQqVVKeOdPy4qD0XoV?=
 =?us-ascii?Q?ZSPDQft9h6Ig0nVlJu9fuWZfYMmFcSRwwHxTbgj1V1599dxlZyXS+pLKlBgP?=
 =?us-ascii?Q?e6vq+3Ccmt1YxPwJ0p4zCdU0j/XDJE3WYPYKtvMaiMPjx8EJJOU9yb7sBK3k?=
 =?us-ascii?Q?NqSHqe2xeKS7rdTt39hkpJpJ3WBTxm2gnSoapPwiZuAi21CDvqM2LFfQJSmC?=
 =?us-ascii?Q?K7TP6dWD/c04ZrjHOhm9nzoevUE8pB/MZstgLPZEADP5juP6dgfHJdcPUzt1?=
 =?us-ascii?Q?HkQilXF76xsOqG5d4mdQBG2FBwZFmPIlS7ZHBTB1ON2aEqWYJZCNH5QerZq8?=
 =?us-ascii?Q?B8X6MqH6ja1vNNyVfp3qTbG4fEPPkY7akhb+lyZlos7fN1JROH9fKuLjpu4v?=
 =?us-ascii?Q?p1M0XkU3mXtt+a0o7OSd263yfwQtkb1nXqYR3chuI50IfUSUxoykZwS2jkG9?=
 =?us-ascii?Q?SfbD079mR6uGPNNuZ/jYMmRRaZ11eV+Ur8efKaJ3tf1nF3Xi51jcsFtL/5eV?=
 =?us-ascii?Q?eDab/BIWu6hrj7+SIZnOJi1CQnSBXnQCbRV6vbbjs7oELrTokfLwuEcz9YyI?=
 =?us-ascii?Q?yta+pYqhScYUt2LopL0o08Z+3kW/8rBMTOJ3TuovBdU5ELp7MxYuX2QkRoc0?=
 =?us-ascii?Q?OcSPUOE4PuIYXaluEClmeAepfUjFHkm9Dr8r0f5UZcYyhygn1gIa/Xhw+u1h?=
 =?us-ascii?Q?IffdLqWCmDLl3kD393ws3U5NVQAKY2qyMV5pOWgMekeR1o2aQJOjQx9/Euly?=
 =?us-ascii?Q?ZGUcgiaPpgQxiAtuzR/sT1swLj4T1Q3p8KrvaXzVP3LpWLLDk851q3b0tvwW?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efacf324-518f-4baf-db2a-08dda741cf7c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 10:38:45.3340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFWcJwDHRBno3koCRh/UtRvDRKLXbBSC/37fs0QSMv2gOJMeRgI9KSfw6XpW8flVovEiIY+wa1H3NYqd9WS4kMakAl+xS5v3abc9NGLlBPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4736
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

On Fri, Jun 06, 2025 at 06:08:51PM +0100, Anatoly Burakov wrote:
> We will need this function in multiple files, so make it non-static.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

This can probably be squashed into the commit where it is needed in
multiple files.
