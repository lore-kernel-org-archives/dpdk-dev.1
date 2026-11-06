Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35180606A32C
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HxDjFiJK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCE7540671;
	Fri,  6 Nov 2026 13:15:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTPS id 04EB4402D8;
 Fri,  6 Nov 2026 13:15:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793967339; x=1825503339;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GJi8L9qiKmgH2g6o2Q6okNC+XVlu72TZMqulYLcrsqE=;
 b=HxDjFiJKXohgozjFCPQBSuJ1u8/DScIKMoWj0462a66ed6qcUO0WczXV
 M9VZoPDcFMV+2l07uunGuflcM5W68d5owXcGjN5ZHAhF/L0RPJbtD6I8N
 7vBOzMttPEhYgSgMT5wdtxznz/3ViIgnvKY8+WA142J8X/fgOXKM+/U3I
 58LvgUPwQ35Gp2AsdBjnkOWvutG+AGyR5ybx3gUShgugUnQZ6aF0X0MXf
 dObTg4njSECnob/JD9SDPfb9aEdZkJmYYSVxigtbM43MM9/BUvHZ5iAST
 MT0tq/4Dli3I5KR/yA4ewaFJ2HI0N4idExQzfd0IMupvC/8PBWmMvSTYj w==;
X-CSE-ConnectionGUID: Ju+hx+5ARaGOts4Q9n5nAA==
X-CSE-MsgGUID: QyboyHfBROuh74IqkcHNPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2800555"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2800555"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 04:15:37 -0800
X-CSE-ConnectionGUID: /5j7SozMTMCw8417nt5bWg==
X-CSE-MsgGUID: 7YVl6smvR7OFqNxEpc2Ksw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7427584"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 04:15:38 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 04:15:37 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 04:15:37 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.12) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 04:15:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lm8DxmdRsmA7pgtLbIjynFdlAtcozlBKY5wn6wc0Dnu3favfK+NQZlDRdfOdGpzTOIx1bu7RYVJjlr11p2EkUbivhaOguD9z3UYOn6ytZKz1ziQsqldnvZPvxOotEfwktrSo9A4MTPgPkgXKA/PjieCtRDYJb5+Hk7pOhLzWU8e+MIySOdwDcdI3y1y+9lBAqb+QlTZJL89c2odIR+tDfZ5umUExrFD3oPSXC/TAbgVqskrmZ6uhvCNFAv5qPC+oRCIUjdrrFiZqiC6h8PdHXLgRaiDEV3zIWBobg4S/Ad6soD1ZNKiknnD4BArD8tpBxh6tF15UG5NoJrwelAi69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frIpdRwnY+kfxvupW/cwSj46/a4z/uHaoticG48+VLE=;
 b=QvX5/n6SiMwZcOJQvtHzbovBP7C2jX6wnEYr3uIs8T8dGAXRnXwHYuABQuOwdwzbrZ7fQnTz2ufM5Ey/wAp1JTQvewiMuUoR+OFaixpgo3WuQ3Z88e6Z+Itfh5lYYaWZH1ZT9OfTHBqgrYz1gRfiGG0VP7LJqCo8uG90+QtSbNHplYtSeDUq9KouosroJWhkhHchDqx1tkeEWTW4CucdKnlgMPR6ghjrN5yDTFb1/qoy3uhVTx880MnvSN84vwK7dUWXI5IVCMj/K+re0IM02td86TZcA33lSIkrVhHjdfX6trWhhuuJgzDHpgnj/Kg4SHPEHSh0sHq8ZClgXCy2bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LVUPR11MB9787.namprd11.prod.outlook.com (2603:10b6:408:39b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 12:15:35 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 12:15:35 +0000
Date: Fri, 6 Nov 2026 12:15:30 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH 7/8] net/ice: fix DCF representor info leak on close
Message-ID: <au3E4rWunK3wsR5h@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793871697.git.anurag.mandal@intel.com>
 <03ede32d5d1c9d92658c07ee7b4136e39446bbd0.1793871697.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <03ede32d5d1c9d92658c07ee7b4136e39446bbd0.1793871697.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DU7P194CA0012.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::18) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LVUPR11MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ca9e5f-e911-436e-d066-08df3bffa939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|10067099003|4143699003|11063799006|261026121527099003|261028144727099003|261026140227099003|261022113327099003|261022105027099003|56012099006;
X-Microsoft-Antispam-Message-Info: q2MImLw2Z3g/6fni0tIlW+JRpysKd/HPRKsYuKH3GwPQXlFWvWozWZ4CRb2laCE3vYhsIRPvn7tcQquGpQa1vzwKBQkzTNROQcpJqMW9BLpPSt6fMxbpWt/jCvEKcILJyo72+7ErUsczC2J1WaTg8GQGCx/wHng9Z8KDfsFO1mv9mKxnrV3jLn7mUfuNNO72StWCTGL6SXLlQCYzM5z/0r6HtBSkjoSDcHzmN1vZFZLyLHnoXYGO78WYFkdtlWIQMjQkKLJfWiiDsN2OIoH2Zp4zAVbCh2MzKbjYh7FYmG8aplMgfwP5VQsGKvYGwL1LLgccjLxA+dm6yft2F4rkOKExeTeRTuxtnLUA8DbBd8XwueIt+8CN1r9dVWj9JYDz1nr898duEqp3UOD8i1x4hWmynqbX6lKgwDbYOroj0Rwy7KSeJuLbZIpEDgwaBD0Lnl6ViNtPpKMOPJmf3QrIsiUb5dr5g/4NfR2JUDExoUXQu6eOpBvbl9ejofTmnwZwfTgO6ALOHjYDhVV35wqZiceTK3kmessCrmggx+tt6bmQI+RbpQQNiv3EAj+xIKTW2s9mpjfFgHIXWweDUF3oCazCeQtIgfueRuBFA2xpg8BVY9htz58DIWNU1bNF8HbReAire6pZ/GdGTFYNqwuOsu3Knay6XnskRymyinkw9nU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261026121527099003)(261028144727099003)(261026140227099003)(261022113327099003)(261022105027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G7h4/pQ4UkN2C1Y185uha/34zdt/3kZBdLJqOC2MKszCVAulMqucbk3T2aMz?=
 =?us-ascii?Q?eZprQy9AlG/+38dLSSNUuxkQh6afkiQh7BvX4ujeJhqeWKdu5u0dZtxHS9JN?=
 =?us-ascii?Q?Sqt045lj4prbXlJSaSQ0t9Kg0vg9kP0HniCdTKrXCjvBqrTll0+cU8ll48Hg?=
 =?us-ascii?Q?MoH36YDKcpadskjaGN5T7Ku1lYcw7iecrpRX7irMIN3kq46M+/GtucFUa0DL?=
 =?us-ascii?Q?hrO60z9fLl9MyfCdV/pNURSAuO5Mt+pO+PD7+0mqLAJP9a01sFvc2/gJR3of?=
 =?us-ascii?Q?sXhtzs2lWgb01wKvN6OHIfBnmdTKfi52azaa5o64Je5Q0vDZrmaHiKWOtPm1?=
 =?us-ascii?Q?ePRwPuVL7WLNsWtvOripu+5IAlpbvApCJig3MIT5T/dP4k3TZKOS6nSIPiuF?=
 =?us-ascii?Q?axOYKAEsOhTS0Xq9STiwtlU75zNYSlKVtKG3C+TF1EAw4ezaK7t9yRk/Ex1N?=
 =?us-ascii?Q?StQiRsx9tqXEKGDwEzkhjUkkyWK/xqNhHSOxRssnF9F7BIKg1CIFsLzNZK+Y?=
 =?us-ascii?Q?hd7Plfnq2WtyIXXqgbo+9bQobdSgSwjqTuIQNeGp60xJho0AvzlxpENs+X6y?=
 =?us-ascii?Q?6Y9NDERfjpDoCKBhqWksEXJHdZYyppeLk/ADHS3223uT5iuyIr7BvhXdNUA4?=
 =?us-ascii?Q?rkNLlA7x5dRTSdK7SaLzC2r4JovBd+pZQS9rPXJwWPDlIhds5l12viO5b9D1?=
 =?us-ascii?Q?1CBYFXv/6xwDVtP2ZqSmY/PTRpEZr3SFCrZrV+9LfYO3DFBffgUrBE4pCx9t?=
 =?us-ascii?Q?V9UCJqmZM1AO61Dku/kpzqERamQrGJbmsPwnqHWPX+UwsIZy4QiCRFcyAVkJ?=
 =?us-ascii?Q?3zzwhNTlQPuPmNNlz5USMeLDxEorU6BWxqdyJ10YMn3M1qJcNKnl6D3k4BgS?=
 =?us-ascii?Q?FvIAc7LsgSlKCdPZZ8zeCeFM/IiVLEVeV8K3JR1lROPQExHh08RN8wkubH78?=
 =?us-ascii?Q?eM8zU+R3c95J5rCkTAkrELH9OB5CyuxsWDfB6vRDoZsHFqXK5hXt9G0aAjNZ?=
 =?us-ascii?Q?Foh5D/z9R7LLlVo+1HGUwvNeyBz3QE1wysaSJYjJRDVceb46sZRZvYvWUH2T?=
 =?us-ascii?Q?vUxy1JwcrczE71hgK8LQsoFQgvrS+sRiK1c1nz0H6mtm4NzhQxWQrQlM0gEF?=
 =?us-ascii?Q?7n+1rUCNw/Dk9sVIiG5EjcjCt2aBOJOtUMZepq60GJKOQLkPB6TGEE3f3fiH?=
 =?us-ascii?Q?SORurOGhojEBxp9Ekzan9sdkF9gMykCPDefB4D9qnWlUHVlS7TgK+D7VwehJ?=
 =?us-ascii?Q?JLzdwTgtJqgg6z57VK3AHPsPgg9jp/44JRJmtT32q0WSpL9Fv99sK9lgiLHo?=
 =?us-ascii?Q?flc9QWUPvQikwauehXK4ouKqp4bXDLvPnRPfwJJxLMmcJ16T5AG06GaFXugT?=
 =?us-ascii?Q?zzzsPEGJZqWV+ur3E6DbKb+jTsBeLIhyBV+EWhW2CMuyGeMTWGq2bkx6STqn?=
 =?us-ascii?Q?NaVkEyTFLPWFfizLEoJOpdQipKomkslIBeTb8KuuGMHm98d33rgetykkOwv8?=
 =?us-ascii?Q?VTavL1EYXjZFAe619fDIC4Lr1S6dtYqTyuquIhPmXJEEMaaseAVKBQFOvStT?=
 =?us-ascii?Q?4uvYwbvdHWNjLOwolqPI0Kpsi7WJxAkLc66NVYucgBgG3nWw5WcYm0CKRDxk?=
 =?us-ascii?Q?MJSZ6hGSkutM2AAAqD4JYJlxN728mWAA5shig5V0CDMKWcEzH91oO1IwC2SK?=
 =?us-ascii?Q?j0X2DVarw4Jw9WPe7XJevE7U+3OgKrFqtrS1kdKpCDD3BJJ+zyJxBf+0zORv?=
 =?us-ascii?Q?SydRvOQxWNG1/s0W/9URYu2kP1UMqIc=3D?=
X-Exchange-RoutingPolicyChecked: QwKX8pve3j6jlgEdwQkSUb0TQqwP0bNQkUNeIDzeRw3+AKCZejmKj55hbK1UAyM5bQ0KB9aFlgeuo/SLRanXQx6+H2TOv4HVfSD9hSx4qZTpYq/IgFz8Tcq5Ye0WnBVBxpkYWbkc0H6qtdkuTacQbIxWIsJ3dhLsGv6XO38nT17hqgyKOvnN45lVQXClti9MCBPYGjxf4qYVkZar/Hkt8O7ZbHfde26OMHXof9OxH8ZPQYyp4WAnrI/qs7sK0CoSemh0NoeHgVKY2LZjSXSM9lsUBmKwJHBeD1yC/S/Xp47LgPPOJZlly6bc4958t+zatEcVjnxhvDClYW4vut24fg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ca9e5f-e911-436e-d066-08df3bffa939
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 12:15:35.3442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3uVFx/hJqvniczaJmEVbwOZf9v11YrADPkwTsJTMm0XCBTcSYUNWG14u0VwIsIt4x5abgrK9OsSE1DLaDir1tELWu85uru7LZr6RwGoQ0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9787
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

On Thu, Nov 05, 2026 at 09:47:24AM +0000, Anurag Mandal wrote:
> The representor info array is only freed by ice_dcf_dev_uninit(),
> which runs on device removal.
> Closing the DCF port with rte_eth_dev_close() releases the port
> without freeing it.
> 
> Free it in ice_dcf_dev_close().
> ice_dcf_dev_reset() needs the info to survive, as init notifies
> the representors again, so move the rest of close into
> ice_dcf_dev_teardown() and call that from reset instead.
> 
> Fixes: c7e1a1a3bfeb ("net/ice: refactor DCF VLAN handling")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
