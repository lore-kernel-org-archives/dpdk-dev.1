Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F9606E010
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LMAZvbPD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC3FA40E3B;
	Mon,  2 Nov 2026 15:54:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 7D94040E1F
 for <dev@dpdk.org>; Mon,  2 Nov 2026 15:54:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793631245; x=1825167245;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=tqUeMWKSxm7CzNURdvaB4S03keghsdLp2zRpyMtr+o0=;
 b=LMAZvbPDVUsdPy036qVEHa6MiFnCbNaxHqJmrqphuZXu9kOncg8tRIHq
 baXYirYC5+FTJZFjlta9vN/hZ6f9velXIqCe6F3d55/NFUBe0vTaYOMvo
 6f3DntO4awj0Zx46q4+H7ar88HisiJvngFiPOLFCks6KJJY66JUgQgYac
 3vSOxuIclLYynNczh7z8Y+ilHiGXX4EIutzf1kZa4FCfPwYzF97jtbQhd
 Q6alJeo+PeVleKVqjYib8GreaJrv5W0DveuYvn/StfBqao5wqd7zNeoNv
 dIoITCp5L2oS++2R6k9ELo652KX99IEs2cPlSkQjbwU3hlE7v7Q9HEt+J w==;
X-CSE-ConnectionGUID: YIT1w69rRN62OgWJpuQlUg==
X-CSE-MsgGUID: 6Yb4zGDwQcSrou8fO3agww==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2358181"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2358181"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 06:54:03 -0800
X-CSE-ConnectionGUID: wtX0WUFnT8ydqgoZNNEctg==
X-CSE-MsgGUID: 00pWnrlIRv2zjbTDyFggLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6467389"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 06:54:03 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 06:54:02 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 06:54:02 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 06:54:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwnmFt8Bk02rXxeCKdK4mghoFVkY0ZTjYl11FpCC8XHrlspitZ7PsSHUHXPrxlFc5XEQOFEqpkrRPk+KA98x1oOK/kuWH3b6qBDpGnpff9WYsud3AnSIOk7/X4hsSAl0fAxHA2DW4B2XZd7USR2KDDwoYUvnJFJD090Gd2hEdL3rGsVaH94MMDIf+w0JDhX2oPhhPtktpFD7EU0tvCPAcPMMt/8jo0iddJWkDZ2xUkO3qp0u+NTkGY35bmLuvjLOWEFCaAX+6jpDNIBQpNzRZhD9OQ9iZJ9nfsYPe/Wanlg2HnoQCXRse6myNC9XQ5rGk71dt8e+X1hnLNVv4t545g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxUlYuFx2aXPO7+g9vs2BNBkJi8f2w5jwmqvUBJKxng=;
 b=fNQ+mDqWl+u01hR3D25frCpT6mMZZvlVhXKB+Vc9lfdzX2BBRFmY5iUPa9DJzYPZ1ZHus2KDYgg9fv9h5jUOiVyXX6dAQFA3vIQzLYLZBTJU9KyU2FIziZa7KpEUpMs307sstnNPRYcVjmj2rx6uOsbODYfe5zZhtVh+c5SQaGlsXUGggdhxuRZsIobps4nl6ZxRu3uYst3vJXjjn43Afumex4w/k4B1mk6yB9nEKibJypfMnvWqmxC9KKg6HJbAExvMw1moqtiwA+WCnPJ0+LLWsQRC23ksWfrwdbrbi8qkTfu7So/hBiiXYOaVBmMWh4qwbPOqQ2mnvIUL8oXexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LVXPR11MB9777.namprd11.prod.outlook.com (2603:10b6:408:387::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 14:53:59 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 14:53:59 +0000
Date: Mon, 2 Nov 2026 14:53:54 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 1/9] net/i40e: skip FDIR flow engine when FDIR is
 unavailable
Message-ID: <auikAsJKNG7SY2No@bricha3-mobl1.ger.corp.intel.com>
References: <5e64cc416c8ab3b038eee6bb55836e0b8ed507ab.1793353214.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5e64cc416c8ab3b038eee6bb55836e0b8ed507ab.1793353214.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0127.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::13) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LVXPR11MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: ca36c4f2-2d6c-4c8b-1e0b-08df38f12066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261022105027099003|261026140227099003|10067099003|18002099003|22082099003|261102123227099002;
X-Microsoft-Antispam-Message-Info: 18/RHGTtnvkChMmxs3EDd6jCvWLsvJcYDQMZTt0wtZ2r0pQVjonImKDZxnekb7GEkYQTVlu24BIcBQi2l8ybytOfl2blxAMpz5laMLkIxH/kzmtCa2PzlK8M5Y1A1GQYX2ssmkHQbH5AA8AGHPkRafBua5YRDkdUNZexevV/mpUXPqmqHdFCVG+7a4GWDPOb7bkWFJhiqWdyCyvxT+Z9ZwOo/xhXBGNI0wjtw7MBuFAmA6vEmtEeYrt2r1UCs85C5p6E7rQG6+8xugc5FHamXII+IWbwMiJcfMTg3jmD1evR4gYBY8JLBVKPotO1V72VfvFAuzjvaRjihmdNu+0/S+mmDRwCra4wFFxDTtqQjg1hiKjHqhpB6aI4bYwjTRLNjF+94/QOIaOo2vUvqADXuTZvxeOFitbWV6bjpZPDoFIqkVz0BbvW2BC+PXDUV1EiDLyroMub3cigO3bAbtDmPv1UfNANXYvjddu6DBESGfVGnzQE4zDPzhFbdYsaxMunKl2DsGd1+Ag2YphVitb4np934VPRKnXztK7BgTrZiwAPNh8/OzxZ6dS8Y2aFD0vHT1hvTSJhhy8/TwD7Ey/7497hz/ehiS+XtLPa08+PUXCthsy2skW6iDmuMEnu4DxvyeL3b+ozh+t+t3pg5UqGs300HYHBKEizhwkZKejdw7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(261102123227099002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O1I3u6SHiNRt+ZJ0vXptE7V1Elu2KCVJKyddXanDjclFpwk107kKeXAsNE2a?=
 =?us-ascii?Q?4dIeS1gbSfvZLAP98Re+9Gulc3ZeYwxbV8V+2ownxOca+YUOW2i3ff3Ne6gN?=
 =?us-ascii?Q?Py3aDSR+zv95LLHZMxAjNagnGKCeQ6y/KcLS0holRquLJ4pYLgO+f+iAxZXx?=
 =?us-ascii?Q?vq8inmepzpIlSUtVBrawKheQtW4cUJ4xUpZCdLfWsnbDSS5PDeT241ghTQiP?=
 =?us-ascii?Q?v4u+9XfAV0j04WJwspcSkJqsHQWQHWaL+yptVW+AnCPm+dxokRxyl6Nq9V2p?=
 =?us-ascii?Q?pUZbtIFsxdmECYp2NTYhDJDcQvRwNIHjkunMH1m+KMobO3SePI+njOHao/sJ?=
 =?us-ascii?Q?5CQDfmHR1T3WnabnQVcujtJxvhLx62XvrDQ+I80Zprlbcu5Qpa+jGPMBYLbY?=
 =?us-ascii?Q?qCrjkxWxWBNG5OHNhWA2SEHyGvWq8L4ECDtbJw9a/N3GuvgZIiqBGLRWffst?=
 =?us-ascii?Q?dt5Ftn7onIdTRVH2c28Dx1pzPG9jhE3c82Ic3c3OJXPQPVFImrxG0qyATuNb?=
 =?us-ascii?Q?hPf2lmtFxocBmPJa/Ay/BuJxynRkwbeU3daEs8dYQi3qdgjP0QRZ4OHYqKvM?=
 =?us-ascii?Q?JriBC29ISdqGvZA2XU6upjPngKt1Re4vGMCEZokVIl7tnJDP0XdqL7a2FL6m?=
 =?us-ascii?Q?Y0heBQGZqFceP6WVaLIl41wkLBKK0FifPpHc1+/rpJnqAJSpr5IAZOghx8cx?=
 =?us-ascii?Q?JMZlL9KVdSY5z5F+BTOZqJf8pgTJJ2mq0I8ZwZsKAmwvoIoVDj8/fQctSFPQ?=
 =?us-ascii?Q?fVwaPzOCde5Gqzq5P0W7XUSWM7Pgs7Br6+kPQmc35ifUn/gJ/2oLnset9FcT?=
 =?us-ascii?Q?3vyb4QpewQRNJQN2HPYTVNSv5f58XZpcBRIc7CRs/OCeH1B33NA9GQS4Md3B?=
 =?us-ascii?Q?mDMnkYsx+CLfY+FRaU2RMZQsLpfkStggV6bT8SDdTJwQlZekpeGUtiw1VRd4?=
 =?us-ascii?Q?+MyLVlXw9wZcVdIqVAkfX+iouP1Z4tFbR/fnlHoWaP6cJKMD3FJjwdk3v0LR?=
 =?us-ascii?Q?Vjc25AqMpBt+qNVPvSODveI14qQiqSFSHdtxHtGyKnnFIzWeytq3ijVrxyyd?=
 =?us-ascii?Q?30P5nYCgwQf6FXGH+9dGq6tI6oru+ITjdEdKx+2tbjTTVkuhKvgXDCn9WGXH?=
 =?us-ascii?Q?9ahPVxRwiGBGgyOh1xT3oJZFoRoFNLPIJnAZhLqhYk7TqHgBp0pikUhg5oGv?=
 =?us-ascii?Q?gtUlhZ211+j2Xk3ClykhAxKrW+dBM0rlET3+gqfvbUwq6m22WlZ4fkh4Xguo?=
 =?us-ascii?Q?TDpIhfTKGNRsSQeq6VW/EmAXkUSua/iT2nBo2vYgJW9Dzrw1FGj+DphVuFpc?=
 =?us-ascii?Q?DqI2fSvkBfzimq/SXxVJD5RtXSNhv2EwfJl08ZHZDui1XmB1V6kJbfh9qyJc?=
 =?us-ascii?Q?GqBOQOJDmA+L5cC2tk7gSTZEIN33x0YrEPAyX6XqdttixiLFiQN7oPp0TlMS?=
 =?us-ascii?Q?KVcZMs28J3zy6SsFoCfvBSl1d6CjnQLRzMokt2+s5lBi1Rh3VQIyP/NTLDF0?=
 =?us-ascii?Q?Qq0SS1RTqoifHFOMnJmlcTXYqw4n+BUKw2fJBTISPzydT6tCISI8kf2X+QeR?=
 =?us-ascii?Q?dlotfShcgX0K8uRdKs5+5NCIzhlJMhjVgqHRLSH52e1aWkC0hp5phWw7gOn0?=
 =?us-ascii?Q?P8Xld0FiyZmes5vAEkyM+FnbD+n7VMZw6EXRIa+5OfbDSjdAuendyFjFkKEU?=
 =?us-ascii?Q?WdpOpwmsI2uaQtIeraOaj6oorrnt5yDK4GYknT5UQQ64ctSdA4W3ZTSYuS2f?=
 =?us-ascii?Q?6iXC4tddmx1ZDdIduEAcAKigETKA0nM=3D?=
X-Exchange-RoutingPolicyChecked: iwi2FL4VCiTsJQQAoqcI1Bz90tHCRcUP1lwtmruelHt3fBVJdsvCmstUWBOq3UO/Wf1D/YZWVaf6tDTwSC5DkqaDbzJ4OmXKLmeN1eQBTdpD6i6x6PGAuFo6S6+B+CuxW0b9E3LeXLzQwzt7v3gDKzP9O40nNP+lecR67lss1hdTsY/zQkFJIQtkk0IP6EeZtFoyvQXRQ4R8SO6k+hX/EmArBHGqkCNs6LqK24CPDxYUOM48+IhgflJDup7zajcZFEs50iPZ4WiU0KD347cUIg2ivPGOLjhLJwxH2sYPRuKfVoL4xwRMKua9NxvHfcpZKHxV5WQt8aeO3YX0/IdYAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ca36c4f2-2d6c-4c8b-1e0b-08df38f12066
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 14:53:59.3358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5M2q0eQpEbzJBWtlX4GaVOM6pnlpy5OsGkgP7FBiWavlVzP3whXAmeZIqmmuvaQdzUrLQlWSCiOZmLRtQyteEdn3og1qNYtMD/rJZbdITIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9777
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

On Fri, Oct 30, 2026 at 09:40:14AM +0000, Anatoly Burakov wrote:
> The FDIR flow engine was initialized even when flow director was not
> usable. With no FDIR filter space, engine init failed and logged an
> error. When FDIR was disabled because its queue could not be allocated,
> the engine was initialized and FDIR flows only failed at install.
> 
> Return -ENOTSUP in both cases so that the engine is skipped.
> 
> Fixes: 05432a6e4676 ("net/i40e: reimplement FDIR parser")
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_flow_fdir.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce
