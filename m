Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E42606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DdQQ+ok7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF57A40283;
	Tue, 20 Oct 2026 18:36:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 085DD4025A
 for <dev@dpdk.org>; Tue, 20 Oct 2026 18:36:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792514167; x=1824050167;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=YdwNcYsWp/C/Fa7pBf+2a9LwWQsVRl72RThPUWMYYSI=;
 b=DdQQ+ok7UhW/kaiBxnYCHZnl+/6sPV6STbUnmjPTUcVaX4p96NyjeQqu
 6L0S2QalUDSBh1yY94kTo3hSLmm7RLcV14WN4N0kWZWXbj48B5+x4is0i
 q5I0iRsswifnVCZZHc4/sn0gXCAP6PWjYMCYeZc4PNrb258Q3rCPG2Khx
 06g392Px2sueaX9vAjEtxfmdSiV1Dr5UQyvSKQ8cIK2vWcM0QwuKgAK/J
 dUWywwI4mijxQxTzjfg97x3jFBWFy37hHPO+4wykUPM0LFVlbONIeUdOB
 XoUCDkaez9whW3vw3xHjVKF2bSGSTerEfW+iSIqM6Ox3d0a7SfNHH602A A==;
X-CSE-ConnectionGUID: TuOZ/gdiTZeolPHXweLI4w==
X-CSE-MsgGUID: N6E81F3lTGGLqJVwiea5TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1103261"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1103261"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 09:35:26 -0700
X-CSE-ConnectionGUID: /1ghofzTSfOWkxG+PZQ4fA==
X-CSE-MsgGUID: JpgKyIHZSVS+uFYfGW6iSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2802704"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 09:35:26 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 09:35:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 09:35:26 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 09:35:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUY4BzqT2yRe/SdzRfiSpT7aat3bHicGTrJdOuUHnCIK4MMjPCBVa6+SANStAjQgQRgz35PIXltWSxEq70gDRQcDGMdyzBtL3TERGQAJrtc4R3RGmViIG+NvTZqxxhaeCYMwKPPTZOlcwb9Enj4qbkGPbcvaVp1a3zdiqA+YXkDUWY/1pQSZKwwBeOb0r+xZL8YSs1g6BIs9jrg3rHUvP1zaPG7M1COnmtKnT0SWOOdpUfcE5iWn2fsJXLDRy2mamIr5UOVTYEhatDuV1VoXpRGVqChZmc79QG2l5G5hLOtmzOoAlfFWF9CoaduLWJe+3MOYOJxksPHFKNYCIqpgwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moW0Mwf0LHzAdQYofW49QD11ucdGC8O4XwOwWvbJdso=;
 b=mUwgcHvB/Os3D+fQ86thQVbORT5I59SVGq6zzvcmcjZGDh5KfOPvQGqSA1Yh43K0mbyRz+KztzGeOudSdsvJ6GjPROLW1bMJVJxC1PXIyF3MKvYtxYEi6prsWdbzF9RnB+NCteYk4UrYiKWZkwWqvgskhKglbyuCvqtq8gLjyTll5IkYH8cGYESyZrfQfb/42yJuznnbXNi1RANtFayWhKZoFTxv7+d5dmZsSxu573Y6Ns1M8Ceecj3u8fudSYrVKcoj77ixn6Ozj0Jy3KU99RUgCKTVQ63QTe8lgDCUtbyc8EBtkB0Ux489jtTXNGOYI9CDTJX8TCTJKtJuM3FFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH7PR11MB6794.namprd11.prod.outlook.com (2603:10b6:510:1b8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 16:35:23 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 16:35:23 +0000
Date: Tue, 20 Oct 2026 17:35:17 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 0/2] i40e base code updates
Message-ID: <ateYRUyGusQ0_r7e@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1792150724.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1792150724.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0094.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::20) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH7PR11MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b0451a-6425-4bcf-71e1-08df2ec82365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: GU6LTijhdw2ynxMLnxpJFMCv0yDntz9rL1uYSyQF9W2BL0cWBCC5enXCU5zwrDtRmSfPXSxkohHi4SJeUI+b6cFnrFUv+Sy3KcZUelIYr+AX/mW5hlZD2Owi/3BRLtiCklEUxwzEtocPr2c+jClg+uSSqB7RRcllQNGr/8YrCIXFAmYEJnfkOEKuwQkTI+FUQPDvsYGSOo2qRQ+ugOIG2ihy0+iCT+0IuXa/NfGinVP1PPJNcYsq9EaRaKKC4Bs3ZohukKtaVuVQeNI/PkLfF37hlPngUpqQnYXCLJ3ldGckfVp9vSjKZDWav1FLHsyKSwqEC1Q6EZ5HuMqOUuxxCHokwCCihTLOufsX8s1MESaxh+VD9qOb6+kFRrZ96glHOISkM8VBx8LtLbTBCksnn8JnMDheXco26++dUoM85DP0LqVSBonVIcDDn7/9UvJuHJazYx3pQiZJgqt+Dd5z3yfI8juhWm/AfwPPDoInMQVV9pQVm5ak01YGldVdmy6rLU47Qgi0xZ6A70Gfm6AsuxXg/4azOcBEXacdcFrH9iJva8jdRVFONd4PzeznK/hNmdhq47rk66GuE1JlcnfSRdgxRFk2p5Tb+8/VgmplpeSoyQfMYKpR3eYLvnmFAn4WtQH6nyoW6IjvC5yvnrfe4drlfMa6g6qtAXUAqCfzVRo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jaTDU4YLT+poO5U2HTXR+53tCZfHLXzkDUVxYBq+aZi7DDqSV2khqV9Wc+UD?=
 =?us-ascii?Q?+Mr7vts3uPRlc3VZKYMP+NlkT+Csa+xsSuHSQ3dWh1gdp3BxPd9c8lyTuynH?=
 =?us-ascii?Q?6sxSQl0iTwzFyx3KPrIDL71EVr7NCNtIDZP4ne8LQgjt2STqr9U/D7NdQmXw?=
 =?us-ascii?Q?h9ZZdXn8OIlIxkkiyW37irYTyuxtq9Bq1/tSsWnfYndPJlH0sxMzbL4sFR80?=
 =?us-ascii?Q?cR7O7H/xjkde3j1sI0oraIDGwwqBpBNVtieLGBdP6SNNa4XTakxE30q8eDJ5?=
 =?us-ascii?Q?L41vboKqCYcsk9M4VVdOn39txil8fhF1HWPazh8gfQoS3kO+7eJhMKeWSapP?=
 =?us-ascii?Q?+FoglyXkynqbYy9KRS3Cqkcc7Jv04dOS+QUt2B2kNpTM8TbZFvm5myc91Wih?=
 =?us-ascii?Q?OkUqfyQ3s8UXHJoEW7dI7HVCevKYRv1RR6TwVEBfOUZ8miqrrFPTbM8tI8C1?=
 =?us-ascii?Q?AzbpScbAOajO1UKNamnfyyQ1wZRIAW9QTgLbgn3wcPjYf+KZprsYKdbZ1Dxb?=
 =?us-ascii?Q?h5lLj9MxDceYLHK7X2D3o8dc88Axu7bddfHK4kEb+BAHMUXg1tHSJvdPvE2Q?=
 =?us-ascii?Q?LW85SV5DqAep6HkOQrqf0I9Qv0Q9NhvmwhKVTLqAv2JJ8GZDkRXyzMgocNBz?=
 =?us-ascii?Q?gbXs5DPJmSuJN1uuX1NjYSJBfgxjH/iwyf2OlYaS2n3/4nE2t/F+g616eFnX?=
 =?us-ascii?Q?spkFjjMqpwshxXVIDfPoxfhDI2vOiAdjT6szHGyLuHjuuelS9bFxAASJJpF4?=
 =?us-ascii?Q?BfnGPkQs84lc1MQMjC6pGKYH2HFszptxlQu71Q2XK/Ws2jioA0xbfDrgOKaz?=
 =?us-ascii?Q?+F5sdt9Dfp2scE1zwHkRgY6X1vVkWGBEOjk2IDnB9g5iblWKfPWIoznHE5is?=
 =?us-ascii?Q?akt2XVzJsbsdv4BpIbs5U90MUREDUgcnIYlkS9KCXGCsVLAOTHqKJHpVrCUa?=
 =?us-ascii?Q?ghAN5qWeCDiHE9WFBvIv/eJOF55NJzkcM70xoB2WRnK0wWCJd0CiaK/yLkPP?=
 =?us-ascii?Q?i+PctPWq0sRw09mpAFFeHDfWdpteCmRmsT2Sxfpg2c+ff6zSIJ8qKi/A6Kl2?=
 =?us-ascii?Q?rOcStSviQRVEn+CEbIfENL7FOOpcqiFZs3W96AXw9HxRA2wqA2dc9wKA49qD?=
 =?us-ascii?Q?FtKvIjKx768JMLnh0Cl9L/DosQTVW7knvGjzAniE4stcASOQENPvsf3UG8pU?=
 =?us-ascii?Q?GgrIyPSTsnvYm+EkmhCPWZVZtuOyxV8RqRv/OUdmn7CxJPOh0mj3Q45JByuE?=
 =?us-ascii?Q?C0Un6PSwHgZ1/qUWFtwyIzzSgJgh+Ed8X9wkSyNI9U1oqOsyScLpfWUq6+RF?=
 =?us-ascii?Q?QMFRmSIG+1YpzoNwTORh7b6bP4PSGoT4iGKc3Nqy+XAC6ONMWvtkgqGs7Lps?=
 =?us-ascii?Q?/jTu8jfoMzYfABOR1kV+Ez88RPwBTdJkOYh2w0RnFqCxWdEGOlhcTI92rR67?=
 =?us-ascii?Q?EEkoFtlp68Y4JYMewyhpqOGojO0WKxd36rUKrL4SvX+AEBpRpefpG0v/O56X?=
 =?us-ascii?Q?P19WSLQzOmHzDDeixU+LLLovD2LzgL1cRX1wE94AG054fJY3mq0l1qhWHP+a?=
 =?us-ascii?Q?qLNiagTLQAG8gVQUbzjdAYK6qtBnatsBkYxv7JNxKLuPYu89ZIhkCRAzAYEB?=
 =?us-ascii?Q?M7awc2GngAU44nbxDqO4amsofAUsFRsLuZeO89pa7snjYhQCnGUqb33B1YQe?=
 =?us-ascii?Q?DOscgQa8vkAEAH90LiFxdhXz05EzIxNdb7AhRJp2N4lLLS+HYAeV8X9yI8Pm?=
 =?us-ascii?Q?f/rl8Xgbj90E1wlwtI0xEQHknoL/fEM=3D?=
X-Exchange-RoutingPolicyChecked: F6ajHoogjcNqUyvyUTo9syianPeBZcHDUtnkk9y6GuHrJnQnVj5xPeTFBV20zjSgLnEZm4HeOl4tRHhPhWXHXSgs9ilQdAZi11cCKrWfK9QMakSaKGSLZQqQ5y+CuiLicvxqqACcl9DLIPWUsrvrzuRQPA1d4LM1j3XaeAtiIauzBOCRFwvSJd6jz3YnLGoUy891Hp+qQTg1+wZLB5WCoC7fSRDM1a8Tb6uO9gD8p6GTNhLkMv0Ih7ZNMlinYtSFEkXS8rwjPbRoxOtnDqCEpqrOPxAPho82T1OU4tbPUtxxuvrmMvey7DJKTRhPsn65UzO/Z/kBd5zsF5jiEqnUGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b0451a-6425-4bcf-71e1-08df2ec82365
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:35:23.4435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3JmQRBsFDaiNVnNFbgjMcSrGwvFLIDPFqYxSTbR411lR3JySkeVP8jI5RadTT8kh60GSDp3hDkDJlUo5Ido+O6mKxxnmRHGXIMSq1Zq0xM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6794
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 16, 2026 at 12:39:27PM +0100, Anatoly Burakov wrote:
> Small base code update for i40e driver.
> 
> Oleg Akhrem (1):
>   net/i40e/base: add get wake packet AQ command
> 
> Szymon T Cudzilo (1):
>   net/i40e/base: avoid implicit conversions
> 
>  drivers/net/intel/i40e/base/i40e_adminq_cmd.h | 12 ++++++++++++
>  drivers/net/intel/i40e/base/i40e_nvm.c        | 16 ++++++++--------
>  2 files changed, 20 insertions(+), 8 deletions(-)
> 
Series applied to dpdk-next-net-intel.
Thanks.
