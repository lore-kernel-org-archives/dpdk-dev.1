Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077F5606AD03
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G3RdsEz0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E2B34027C;
	Wed, 21 Oct 2026 18:20:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id B5C3D40041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 18:20:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792599658; x=1824135658;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jwCuchmPiHYoOmFbD8kV5tQ2QGuc1pWJIEbwZcSWd/k=;
 b=G3RdsEz0YY8MxpJQOfcAjF6qA4b6j9gGmey3iE1GkWABpgXB6xwajPVW
 8gfw9uhV/ZbPvL6PHXfdFbbfrnfMefdLlQjR718lM4P/KkIlJcngD6pE9
 mVsBf6ij05twHhRqS+JntWBJHigIJ2HN1+PBI17+7o5vI3LwOf3nrFszt
 o19RxCckGgDiiqRYqQd4vV/e3AYOOF9SLmYBepttzPZN7quG2og/xTsWk
 iXBoLsVtkqA37FxK3D0NtGvgrKFqjYm6rH8/NOMw2Bw6+oWf7QPLaNMJD
 DFpMQQ5c4n2Zcb8dDY+e0FhOVr5DcFECdK8p0eec7fWsK9VIlaCLkKOo4 w==;
X-CSE-ConnectionGUID: G85EqyDlQbW4RCs/m5NZVA==
X-CSE-MsgGUID: ZZdnn9FXTGikeNwA5nSl3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1363862"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1363862"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 09:20:56 -0700
X-CSE-ConnectionGUID: az/YkjLqTFOmCD86hzX9pA==
X-CSE-MsgGUID: PlvkSNB4QE2DA+CXIcibzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="4969837"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 09:20:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 09:20:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 09:20:55 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 09:20:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BW8l3LMCKXpsqHuQYv4Um6jej1jaN8/mCySYTOdziihcX197HME/nubAfjBpi64nQagQoEGKJ9Ju6HMM+SVQBh7FmPZc/UBht0LdVg/JVHfs9w4wYuDKjnYSDL7FC6Ki9vWSrAe0D451Jy6CjWTbWlSHcvsdaDptB7xM/48m6PajNmLRSJr13AwzSXIjFZ4XXGQm6g3uJ3Z+copkzyrmY6DCk8dxE9RTkDpnO5gzdqloL/kJ+EytJLRU3d1New+zldYW/zBalQZIZSpForWqOEgwN3ATSTLcBzh1WZnKCLoc3FO4XKFHCrgEDmlddLVvHTExHHNXdl6usWsiY1wWcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpfLFocNkuHGq4mZlV0nsaFvA5dh7HYldtGtR6Yesf0=;
 b=QKY+yDRtbRWmkWL3z6VI+HOTRSrXayGOaIum0l/hrgJKObf81TL7ICqwj3yIqpQ1/NTdXA/kGvYWWedDUirQizYBoaYR06rffdOE8xmWjeWtN2/y7AT0gAbIgcddbc+JuxY2FJT3OL/m+vZyCBhyE078KtFqS7lPOcFoIDXtEYxQ1LrhpDJuuhTGVOMpqI2TVOBaCpQHQ7MbsiY89Bjcm9UHUcFuIEk4MhmeQTiPGGHEN0bKjuvj2xSsCQvJAiVbyeWNPosPW8/qW+0ukFP4z6bBORyLxk3KkNLCDCk0f7Ir02ykkopwiZF7DcPksrALSRXknpFiM802apBYv5W43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by IA4PR11MB8990.namprd11.prod.outlook.com (2603:10b6:208:56b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 16:20:52 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 16:20:49 +0000
Date: Wed, 21 Oct 2026 17:20:43 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 1/1] net/ice: remove obsolete shared counter support
Message-ID: <atjmW_8J0l1cDanb@bricha3-mobl1.ger.corp.intel.com>
References: <c0048e1fcd107079bc21a08bf3843a631792edb0.1792422953.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c0048e1fcd107079bc21a08bf3843a631792edb0.1792422953.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0018.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::23) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|IA4PR11MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a7c0c6-6c0b-4969-f7ef-08df2f8f44ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: rl/ogdCZFv2B6ZgQgN6MGiMfgFCB0JzmRLujL5D4Ls7a3yTDgsrtmocQ5HA0jlV0U/OwV2laksfwrGN5mjtsD3B5t+TF1eCAg00QCZo8TH6ZMOUYiPzIJi3r1oLAueCST+XT515sR4BxUL4umHegGxs1KXclR38ZZxmr1w48UVncOjNQmVuK6OWEkrbRpR8Jb7g7ieFsg/HJyJAaNgkHMALutYhB7ddve38CbsAGXkbj5Ime2HUk/pk2l/HEH4uT8ZKShMske/4xoAXs1ZaiS1kJmBMRdUyezz3NP0MgqnHitTCw+U+oxuGdnut78KDyWJf2eadQyJR9OukxT4jG4Hap79T+fwgvIINoKIaKvzuHwdloN96teT377Kh53YmRYf8cmc0ED+z6dyrEhIMvbul93MWY78Z4H24RDV2tjWUeNkAGPZ3nWIHTOBTACSkMue2EtBFD5Q2s8pkw4Ce/8zrykvSmcylxaTSKdOvRjMnzdm/34zoItEUqZ/SCX94q0iU5DtJzIXc95aOMOjeeC/85QGn6gb1V7Ma4FaBPxRpECg3zgmN6W4rxctZHdQ9RObui0CDnDfhypVJt51M6UBSDh0o3J1P2gC202DZmS3Nyvu3veIgVPLHpJy7JAJj/pFuWTuMsSjDF5/Snk+0JzecfBI0+E8QLXKwXILja7mQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZW5kIrYkbtpX8WGfuAmhmCJ7Na6Tvny/EgCaj+v66QfysfRvDoeDaQbxqudM?=
 =?us-ascii?Q?0KwfTVN83x6822++GFTmD7TNRK0GBUMkmZ4funLR29IAZEXV7TqOv8BtD6C0?=
 =?us-ascii?Q?9pMM2xNbuTGE0sTZF/awIMVJ+b8PdgFqNmSmK5gn87uopvNFz0vjB/nXPY+k?=
 =?us-ascii?Q?gHTGqRARakp5IPJ1Uvpm1fNCAnkfh0DOeIq36hY1B6lyBauSHkGT4Sr2pHB2?=
 =?us-ascii?Q?ds7SNPiuFUcNUdKA9M1NiYEPjPg3eAIZwukIAQbPaDn2u3OG7iabGKOp9UJF?=
 =?us-ascii?Q?0P5dEP7vDEuu9k21RHhqFProyKpj9n29vYsTsJn2QKWX9ZvRn9bi7hW5y9uJ?=
 =?us-ascii?Q?QSR74ylsge13LzdAfTknnkz51C9MeGa9Th9Zn7O6o39Vj+LDNlGKj5VQ48xI?=
 =?us-ascii?Q?w/EkesW+BRO+vx0/9XwoWqTXY1ei8aoUaUOSsuCbEZm7cqCv1dpg4dRkGYYh?=
 =?us-ascii?Q?3wkJzpT089W2GBbiptf89uMfqNiVLyNc6sHK4TFPmbcoN8nYc3S3gBDHfzjh?=
 =?us-ascii?Q?SL9V1cnvAwLLvvQ47pwiaH2Mo+ANsPuvknNjmnlxnpaQgvVmse3QKm7qxZSO?=
 =?us-ascii?Q?ZOekt7zAuOHuae08N7313lLGXUIrFigvWfER/AKLHoIvaj5y1y/FR6ej4RlV?=
 =?us-ascii?Q?uk0b8/THM8JkQabTy7DhNcRzTDt3oU7zJkbBfWF0GbMBRMUvDDXYL6EokLVg?=
 =?us-ascii?Q?PIpu5be6OJeUg24agMx22xCogrLrUfNPm0RYkb6u0IPaltg/b4v2VFQECJ+k?=
 =?us-ascii?Q?adBZXtE+FH1joVKVJ+SK182C8IAHOm/qZ3BhPBczbCSbv9K+78jG0V7+n+AX?=
 =?us-ascii?Q?6Da59/MUgSM7t/RUe3wgRltio5w/02BNXurNoW/FWUcDMRWRNEYpUt/A7Qf0?=
 =?us-ascii?Q?99yJyZ6bA1ajgWRTcuNG1CrGnckZlOLkuEzh2YvqQODLYbD32cFVQmMryQzC?=
 =?us-ascii?Q?p7czTYZyAf5GyYrS52rbBpZSWOWjCgyfo9EU9b1nEl8lC80kUT8Eo1e/TpeP?=
 =?us-ascii?Q?BIeDSr/8jKBdJGBH4ItjcPP1vLrdGwmjA1BzV0G6hAw1bZRetPvFoaLKvVBR?=
 =?us-ascii?Q?D5RPykAv3q1L7hyOxEYcGB6JdwDb1z/5OUT36579cXPkAW5T4BZK/Sl+vPi9?=
 =?us-ascii?Q?zA369t332MpDd9/4se97aKXWXd0fZYNVrbHGvUUsoBVCfnHtT1249oQ+o7UZ?=
 =?us-ascii?Q?sJFnVzu2wu++s8Zpp7CuRX7JYS5S7evpDYIr+LJ37i0slQRX67XyZXKNgxR8?=
 =?us-ascii?Q?PWJ7g0xdWqScFN7ZLKz075LsQSIGW5jRIcPdNZoetTvpImVM88eRL+u2CBiB?=
 =?us-ascii?Q?CAeo9oEESx+vLxvizVLEPK+nHxcqV1i8EC8/S3VkXJ2dQUs/SDw0SalMdZ+Y?=
 =?us-ascii?Q?1ABFvmQ4FKseN04HxBvd7OMDiq5kz6wcPLVzPXvnb8C94KMyQIsNuTOPME2p?=
 =?us-ascii?Q?znnjwTouChG99ow4wimgL6L94qTndR1WXFk5/NoApsQCQN6U8rnQHuRTYfgZ?=
 =?us-ascii?Q?N6BvtBGk6aUYlVuKVrId8XQHS6Ng9XcQ7vN8wmmhpImfviTXaPLbftw+JEq/?=
 =?us-ascii?Q?9UJbNb5/g24whqpUqBe0OG7XTxS7hJe3JpJhmyZAovQ5vEaMP/G6xdaGyJCD?=
 =?us-ascii?Q?tQGPAiFD0TAVh6I7CbRis2bu/Hqetm0DYSHTTTiXmYH6Nv/GFnaN+lYPIcDS?=
 =?us-ascii?Q?QSZ2OB7an5xxhp8TMBUyzW4AX+Avaph33JQKSgsiHkKtC14EHU7Lwti36Mg8?=
 =?us-ascii?Q?C+NIWHPqsIWaMr6DcqJVkRh5mCRAsAI=3D?=
X-Exchange-RoutingPolicyChecked: 3s7qjtBH32sVwrOj1qdrk4lZNmyuNe0FKdcv2W86uRZgciBYXj+saUEJ87oJTbCKBmiY9CUpNtxlnTF6N9F7YNwZ0cau/gpgNyUCQm+SkOnsuYkgF6EKJ6CiaH/JChY32KAuNTwf0MG/455f21Rzk4vMID7E4DelhKuwkkIBRDiZwR3teCTRTeqnFKDzMRq5+Mly5Q0aJuaVwlbqa4BZrO8/G7+wZqRV+WW8Y9DQHsgMvSYOoeKIqEZKWhGeWmHxS5XcIadTmRsBz40FVx53gJMuOp4O3XmsQf+bqBIPcgPF65wuLyQBOBKw4scmWTrD1ILdbPjyBlYEDBK4BlsR3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a7c0c6-6c0b-4969-f7ef-08df2f8f44ab
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 16:20:49.0735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnQ1nHx9ugExHOWkkQyuaYVsSEQovSBqpV5OWxjfM1eOEtSqTyixDqoB5GG4Y1ol5BsHYPO+CYIZS2JSKwdmmaej3eRWPZjjsLSCsBTbBxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8990
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 04:16:00PM +0100, Anatoly Burakov wrote:
> The shared attribute was removed from the `COUNT` action, with indirect
> actions replacing it. ICE still carries shared-counter handling, but
> its FDIR path always allocates a dedicated counter.
> 
> Remove the unreachable shared-counter lookup and reference counting,
> along with the saved action ID used only for sharing.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
